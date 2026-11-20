GRM_Sys = {};

local ProcessedChatCache = {}
local ProcessedChatQueue = {}
local MAX_CACHE_SIZE = 100
local hookedFrames = setmetatable({}, { __mode = "k" })

-- Tells Blizzard which chat lines actually need to be transformed
local function ChatMessagePredicate(text, ...)
    if GRM.issecretvalue(text) or type(text) ~= "string" or ProcessedChatCache[text] then
        return false 
    end
    
    -- Only return true if the line contains a player link or offline message
    if string.find(text, "|Hplayer:", 1, true) or string.find(text, GRM.L("has gone offline."), 1, true) then
        return true
    end
    
    return false
end

-- Formats the text and returns it along with all original metadata
local function ProcessChatMessageSafe(text, ...)
    if GRM.issecretvalue(text) then
        return text, ...
    end
    local originalText = text
    local modified = false

    -- Hyperlink Detection
    if string.find(text, "|Hplayer:", 1, true) then
        text = string.gsub(text, "(|Hplayer:([^|:]+)[^|]-|h)(.-)(|h)", GRM_Sys.ReplaceHyperlink)
        if text ~= originalText then modified = true end
    
    -- Offline Detection
    elseif string.find(text, GRM.L("has gone offline."), 1, true) then
        text = GRM_Sys.ReplaceOfflineMessage(text)
        if text ~= originalText then modified = true end
    end
    
    -- If we modified the text, save string to our cache so we never process it again
    if modified then
        ProcessedChatCache[text] = true
        table.insert(ProcessedChatQueue, text)
        
        -- Prevent memory leaks by capping the cache size
        if #ProcessedChatQueue > MAX_CACHE_SIZE then
            local oldestString = table.remove(ProcessedChatQueue, 1)
            ProcessedChatCache[oldestString] = nil
        end
    end
    
    return text, ...
end

-- Any chat frame can be modified
GRM_Sys.HookChatFrames = function()
    if GRM_G.ChatFramesHooked then
        return
    end

    local function HookSingleChatFrame(chatFrame)
        if not chatFrame or hookedFrames[chatFrame] then
            return
        end

        hookedFrames[chatFrame] = true

        -- Retail and WOW Forever Addogeddon taint free hook.
        if chatFrame.TransformMessages then
            hooksecurefunc(chatFrame, "AddMessage", function(self, text)
                if GRM.issecretvalue(text) or type(text) ~= "string" then return end
                
                -- Only trigger a buffer transform if this new line contains actionable targets
                if string.find(text, "|Hplayer:", 1, true) or string.find(text, GRM.L("has gone offline."), 1, true) then
                    -- FIX: We now pass BOTH the Predicate and the Transform function!
                    self:TransformMessages(ChatMessagePredicate, ProcessChatMessageSafe)
                end
            end)
            
        -- CLASSIC ERA / WOTLK: Safe to use the legacy hook (No chat taint lockdown exists here)
        else
            local originalAddMessage = chatFrame.AddMessage
            chatFrame.AddMessage = function(self, text, ...)
                if GRM.issecretvalue(text) then return originalAddMessage(self, text, ...) end
                
                if text and type(text) == "string" then
                    local success, modifiedText = pcall(ProcessChatMessageSafe, text)
                    if success and modifiedText then text = modifiedText end
                end
                
                return originalAddMessage(self, text, ...)
            end
        end
    end

    -- Hook all existing frames
    for _, frameName in ipairs(CHAT_FRAMES) do
        if _G[frameName] then HookSingleChatFrame(_G[frameName]) end
    end

    -- Watch for dynamically created whisper/BNET tabs
    hooksecurefunc("FCF_OpenNewWindow", function()
        for _, frameName in ipairs(CHAT_FRAMES) do
            if _G[frameName] then HookSingleChatFrame(_G[frameName]) end
        end
    end)
    hooksecurefunc("FCF_OpenTemporaryWindow", function()
        for _, frameName in ipairs(CHAT_FRAMES) do
            if _G[frameName] then HookSingleChatFrame(_G[frameName]) end
        end
    end)

    GRM_G.ChatFramesHooked = true
end

-- Method:          CreateGuildCreationDatePattern()
-- What it Does:    Creates the guild Creation Date Pattern
-- Purpose:         Easier parse the creation date without repetitive work.
local CreateGuildCreationDatePattern = function()
    local pattern = GUILD_INFO_TEMPLATE;

    if GRM_G.BuildVersion >= GRM_ENUM.BUILD.WOTLK or (GRM_G.BuildVersion >= GRM_ENUM.BUILD.FOREVER and GRM_G.BuildVersion < GRM_ENUM.BUILD.TBC) or GRM_G.Region == "deDE" or GRM_G.Region == "frFR" or GRM_G.Region == "koKR" then
        for i = 1, 5 do
            pattern = string.gsub(pattern, "%%" .. i .. "$d", "(%%d+)");
        end
    else
        pattern = string.gsub(pattern, "%%d", "(%%d+)");
    end

    return pattern;
end

-- Method:          SyncPlayerGoneOffline ( string )
-- What it Does:    Reports back if player you are syncing with has gone offline.
-- Purpose:         Will need to break sync if players has gone offline.
local SyncPlayerGoneOffline = function(msg)
    local result = false;

    local breakIndex = string.find(msg, " "); -- This format fits almost all
    if breakIndex == nil then
        breakIndex = string.find(msg, "下線了。"); -- Taiwanese
        if breakIndex == nil then
            breakIndex = string.find(msg, "下线了。"); -- Mandarin
        end
    end

    local fullName = GRM.AppendServerName(string.sub(msg, 1, breakIndex - 1), true);

    if (GRMsyncGlobals.IsElectedLeader and GRMsyncGlobals.CurrentSyncPlayer == fullName) or
        (not GRMsyncGlobals.IsElectedLeader and GRMsyncGlobals.DesignatedLeader == fullName) then
        result = true;
    end

    return result;
end

-- Method:          SystemMessagePatternMatchCheck ( string , string , string )
-- What it Does:    Return true if the pattern matches
-- Purpose:         During sync, if a player goes offline then you will be notified that sync has failed using this.
local SystemMessagePatternMatchCheck = function(pattern, msg, name)

    local result = false;
    local toMatch = "";
    if pattern == 1 then

        if not GRM_G.NotOnlineSystemMessage then
            if GRM_G.Region == "esES" or GRM_G.Region == "esMX" or GRM_G.Region == "koKR" or GRM_G.Region == "zhTW" then
                toMatch = "%%s";

            elseif GRM_G.Region == "zhCN" then
                if GRM_G.BuildVersion < GRM_ENUM.BUILD.CATA then -- Not known exact expansion it changed
                    toMatch = "\"%%s\""
                else
                    toMatch = "“%%s”";
                end

            elseif GRM_G.Region == "itIT" or GRM_G.Region == "ruRU" then
                toMatch = "\"%%s\""

            elseif GRM_G.Region == "koKR" then
                toMatch = "“%%s";

            else
                toMatch = "\'%%s\'";
            end

            GRM_G.NotOnlineSystemMessage = string.gsub(ERR_CHAT_PLAYER_NOT_FOUND_S, toMatch, "(.+)");
        end
        if string.match(msg, GRM_G.NotOnlineSystemMessage) ~= nil and string.find(msg, name, 1, true) ~= nil then
            result = true;
        end

    end

    return result;
end

-- Method:          AnnounceIfMacroReady( string )
-- What it Does:    Announces if a player, after they logon, match a macro rule
-- Purpose:         To give a reminder to perform an action once the person is currently online.
local AnnounceIfMacroReady = function(msg)
    if CanGuildPromote() or CanGuildDemote() then
        local listOfNames = {};

        local name = GRM.AppendServerName(string.match(msg, "|Hplayer:([^:]*)(.-)|h%[.-%]|h"));

        if name and CanGuildPromote() then
            listOfNames = GRM.GetPromoteAndDemoteNamesByFilterRules(2);

            for i = 1, #listOfNames do
                if listOfNames[i].name == name then
                    if GRM.G_Util.IsGuildieOnline(listOfNames[i].name) then

                        if not GRM_G.MacroMatchList[listOfNames[i].name] then
                            GRM_G.MacroMatchList[listOfNames[i].name] = {false, false};
                        end

                        if not GRM_G.MacroMatchList[listOfNames[i].name][1] then
                            GRM.Report(GRM.L("GRM:") .. " " ..
                                           GRM.L("{name} matches rules for a promotion and is currently online.",
                                    GRM.GetClassifiedName(listOfNames[i].name)));
                            GRM_G.MacroMatchList[listOfNames[i].name][1] = true;
                        end

                        break
                    end
                end
            end
        end

        if CanGuildDemote() then
            listOfNames = GRM.GetPromoteAndDemoteNamesByFilterRules(3);

            for i = 1, #listOfNames do
                if listOfNames[i].name == name then
                    if GRM.G_Util.IsGuildieOnline(listOfNames[i].name) then

                        if not GRM_G.MacroMatchList[listOfNames[i].name] then
                            GRM_G.MacroMatchList[listOfNames[i].name] = {false, false};
                        end

                        if not GRM_G.MacroMatchList[listOfNames[i].name][2] then
                            GRM.Report(GRM.L("GRM:") .. " " ..
                                           GRM.L("{name} matches rules for a demotion and is currently online.",
                                    GRM.GetClassifiedName(listOfNames[i].name)));
                            GRM_G.MacroMatchList[listOfNames[i].name][2] = true;
                        end

                        break
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Sys.IsValidToAddTags( playerTable )
-- What it Does:    Evaluates if a player should receive tags based on dropdown settings
GRM_Sys.IsValidToAddTags = function(player)
    local nickname = GRM.NN.GetNickname(nil, player)
    local result = false
    local isUnassigned = false
    local isMain = GRM.IsMain(player.name)
    local hasAlts = GRM.PlayerHasAlts(player)

    if nickname and nickname ~= "" then
        -- Player has nickname, check nickname settings
        local nickMainDisabled = GRM_Name.IsTagDisabled("NICKMAIN", GRM.S().nicknameFormatMain)
        local nickAltDisabled = GRM_Name.IsTagDisabled("NICKALT", GRM.S().nicknameFormatAlt)
        local nickUnassignedDisabled = GRM_Name.IsTagDisabled("NICKUNASSIGNED", GRM.S().nnFormatUnassigned)

        if isMain then
            result = not nickMainDisabled
        else
            if hasAlts then
                if not GRM.PlayerIsUnassignedInGroup(player) then
                    result = not nickAltDisabled
                else
                    isUnassigned = true
                    result = not nickUnassignedDisabled
                end
            else
                isUnassigned = true
                result = not nickUnassignedDisabled
            end
        end
    else
        -- No nickname, check standard Main/Alt settings
        if hasAlts then
            if not GRM.PlayerIsUnassignedInGroup(player) then
                -- FIXED: Check MAIN and ALT settings, not NICK settings!
                local mainDisabled = GRM_Name.IsTagDisabled("MAIN", GRM.S().nameFormatMain)
                local altDisabled = GRM_Name.IsTagDisabled("ALT", GRM.S().nameFormatAlt)
                
                if isMain then
                    result = not mainDisabled
                else
                    result = not altDisabled
                end
            else
                isUnassigned = true
            end
        end
    end

    return result, isMain, isUnassigned
end

-- Method:          GRM_Sys.SetGuildInfoDetails()
-- Purpose:         Calls the server info on the guild and parses out the number of exact unique accounts are in the guild.
--                  It also filters the chat msg to avoid chat spam, then unfilters it immediately after
--                  as a Quality of Life feature so the user can manually continue to call as needed.
-- Purpose:         It is useful information to know how many unique acocunts are in the guild. This particularly is useful 
--                  comparing how many "mains" there are on the audit window...
GRM_Sys.SetGuildInfoDetails = function()
    GRM_G.MsgFilterDelay = true; -- Resets the 1 second timer upon calling this method for the chat spam blocking.
    GRM.ConfigureGuild();

    if not GRM_G.MsgFilterEnabled then -- Gate to ensure this only is registered one time.
        GRM_G.MsgFilterEnabled = true; -- Establishing boolean gate so it is only registered once.
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", GRM_Sys.SetSystemMessageFilter);
    end
    GuildInfo();
    -- This should only be blocked momentarily.
    C_Timer.After(2, function()
        GRM_G.MsgFilterDelay = false;
    end);
end

-- Method:          GRM_Sys.GetNameWithMainTags( string)
-- What it Does:    Retrieves the fully formatted string for UI elements and Achievements
-- Purpose:         Global accessibility for formatting strings according to dropdown settings.
GRM_Sys.GetNameWithMainTags = function(name)
    local player = GRM.GetPlayer(name)

    if player then
        if GRM.PlayerHasAlts(player) then
            GRM_G.IsAltGrouping = true
        end

        local addTag, isMain, isUnassigned = GRM_Sys.IsValidToAddTags(player)

        if addTag then
            local mainName = isMain and name or GRM.GetPlayerMain(nil, player)
            local nickname = GRM.NN.GetNickname(nil, player)
            
            name = GRM_Name.GetFormattedNameString(name, mainName, nickname, isMain, isUnassigned, nil, false)
        end
    end

    return name
end

-- Method:          GRM_Sys.AnnounceAchievement( string, string )
-- What it Does:    Announced earned achievements from the guild in classic
GRM_Sys.AnnounceAchievement = function(source, link)
    local formattedName = GRM_Sys.GetNameWithMainTags(source)
    local message = string.gsub(string.gsub(BROADCAST_ACHIEVEMENT, "%%s", formattedName), "$a", link)
    local color = ChatTypeInfo["GUILD"]
    GRM.Report("|cff00c8ff" .. GRM.L("GRM:") .. "|r " .. message, color.r, color.g, color.b)
end


-- Need to work with the built-in sync system to ensure only 1 leader reports to chat...
C_ChatInfo.RegisterAddonMessagePrefix("GRM_GCHAT");
GRM.GRM_FrameChatTest = CreateFrame("Frame", "GRM_FrameChatTest");
GRM.GRM_FrameChatTest:RegisterEvent("CHAT_MSG_ADDON");
GRM.GRM_FrameChatTest.IsInLoop = false;

GRM.GRM_FrameChatTest:SetScript("OnEvent", function(_, event, prefix, msg, _, sender)
    -- Only acknowledge if you are sending it to yourself, as this is just a check to see if you have access
    if event == "CHAT_MSG_ADDON" and prefix == "GRM_GCHAT" and sender ~= GRM_G.addonUser then
        local prefix2 = string.sub(msg, 1, string.find(msg, "?") - 1);

        -- Force global controls update check
        if prefix2 == "GINFOUPDATE" and not GRM.GRM_FrameChatTest.IsInLoop then
            GRM.GRM_FrameChatTest.IsInLoop = true;
            CommunitiesGuildInfoFrame_UpdateText(CommunitiesFrameGuildDetailsFrameInfo);
            GRM_Sys.GlobalSettingsLoopCheck(nil, true);
        end
    end
end);

-- Method:          GRM_Sys.GlobalSettingsLoopCheck ( int )
-- What it Does:    Controls the recheck on the guildInfo as when the window is closed it doesn't refresh immediately.
-- Purpose:         Quality control to keep the settings check as fast as possible on global control changes
GRM_Sys.GlobalSettingsLoopCheck = function(epochTime, first)
    local timer = epochTime or time();
    local reCheck = function()
        local canExit = false;
        local text, isRestricted = GRM.G_Util.GetGuildInfoText();
        if isRestricted or (GRM_G.GuildInfo ~= text and not first) then
            canExit = true;
        end

        return canExit;
    end

    if (time() - timer) <= 10 then
        if reCheck() then
            GRM.Global.UpdateGuildLeaderPermissions(false, true);
            GRM.GRM_FrameChatTest.IsInLoop = false;
        else
            GRM.GuildRoster();
            C_Timer.After(1, function()
                GRM_Sys.GlobalSettingsLoopCheck(timer, false);
                return;
            end);
        end
    else
        GRM.GRM_FrameChatTest.IsInLoop = false;
    end
end

-- Method:          SpecialAddonAltTagCleanup ( string , int )
-- What it Does:    If the player is using one of those alt name/main guild message addons this parses it out
-- Purpose:         So it is compatible with guild chat manipulated addons...
local function SpecialAddonAltTagCleanup(note, startIndex)
    local tags = {":", "]", ")", "-", ">"};
    local isSpecial = false;
    if startIndex > 1 then
        for i = startIndex - 1, 1, -1 do
            local tag = string.sub(note, i, i)
            for j = 1, #tags do
                if tag == tags[j] then
                    note = string.sub(note, startIndex);
                    startIndex = 1; -- Need to update it!
                    isSpecial = true;
                    break
                end
            end
            if isSpecial or (i == startIndex - 2) then
                break
            end
        end
    end
    return note, startIndex;
end

-- Method:          UpdateNoteFromChat ( string , string )
-- What it Does:    Updates the player note if you are an officer to do it, and the player typed !note in chat
-- Purpose:         Help with adding public notes for guildies who it is restricted due to officer changes.
local function UpdateNoteFromChat( playerName , note)
    local maxNoteSize = 31;

    if GRM.Util.GetNumLetters(note) > maxNoteSize then
        C_Timer.After(0.1, function()
            GRM.Report(
                GRM.L("The note is too long. Only the first {num} characters will be set.", nil, nil, maxNoteSize));
        end);
    end
    -- Let's find the player
    local player = GRM.GetPlayer ( playerName );
    if player then
        local i = GRM.GetRosterSelectionID( playerName , player.GUID );
        if i then
            GRM.SetNote ( player.GUID, note, true, i );

            if GRM.S().toChat.note then
                C_Timer.After(1, function()
                    GRM_G.ReportedNoOfficerOnly = false;
                    if not GRM_G.noteUpdateSpamProtection then
                        GRM_G.noteUpdateSpamProtection = true
                        GRM.Report(GRM.L("{name}'s note has been updated!", GRM.SlimName(playerName)));

                        C_Timer.After(2,function()
                            GRM_G.noteUpdateSpamProtection = false;
                        end);
                    end
                end);
            end
        end
    end
end

-- Method:          GRM_Sys.TriggerPlayerNote ( string , string )
-- What it Does:    Parses every comment in the guild frame and looks for the !note tag
--                  and adds anything after it, up to 31 characters, to player note
-- Purpose:         Mainly for use in Classic
GRM_Sys.TriggerPlayerNote = function(playerName, msg)
    if GRM_G.BuildHasRestrictions then
        return;
    end
    
    local caseFreeTxt = string.lower(msg);
    local startIndex = string.find(GRM.Util.Trim(caseFreeTxt), GRM.L("!note"));

    if startIndex == nil then
        string.find(GRM.Util.Trim(caseFreeTxt), "!note"); -- Always working in case of other language
    end

    -- No need to continue on if it is not found at start... No need to do extra attempt processing
    if startIndex ~= nil then
        msg, startIndex = SpecialAddonAltTagCleanup(GRM.Export.RemoveStringColoring(msg), startIndex); -- Cleaning it up!!!
        if startIndex == 1 then

            -- Success!
            -- Let's check what we have... No point in carrying on if there is no note to set...
            local note = GRM.Util.Trim(string.sub(msg, select(2, string.find(string.lower(msg), GRM.L("!note"))) + 1));

            if #note > 0 then
                -- Note is good, let's trigger the boolean...
                if (GRM_G.BuildVersion >= GRM_ENUM.BUILD.CLASSICERA and GRM.CanEditPublicNote() and (GRM.CanEditOfficerNote() or GRM_G.addonUser == playerName)) or
                    (GRM_G.BuildVersion < GRM_ENUM.BUILD.CLASSICERA and GRM.CanEditPublicNote()) then -- Don't need to write your own public note.
                    UpdateNoteFromChat(playerName, note);
                else

                    if GRM.S().toChat.note then
                        -- Do an officer check of addon users online...
                        GRM.RegisterGuildAddonUsersRefresh();
                        C_Timer.After(2.1, function()
                            local addonUsers = GRM_G.currentAddonUsers;
                            local officerFoundOnlineWithAddon = false;
                            for i = 1, #addonUsers do
                                if GRM.IsGuildieAnOfficer(addonUsers[i][1]) then
                                    officerFoundOnlineWithAddon = true;
                                    break
                                end
                            end

                            if not officerFoundOnlineWithAddon and not GRM_G.ReportedNoOfficerOnly then
                                GRM_G.ReportedNoOfficerOnly = true;
                                if playerName ~= GRM_G.addonUser then
                                    GRM.Report(GRM.L("GRM:") .. " " ..
                                                   GRM.L("No officer online to set {name}'s note", GRM.SlimName(playerName)));
                                else
                                    GRM.Report(GRM.L("GRM:") .. " " ..
                                                   GRM.L("No officer is currently online to update your note"));
                                end
                            elseif officerFoundOnlineWithAddon then
                                C_Timer.After(1, function()
                                    GRM_G.ReportedNoOfficerOnly = false;
                                    if not GRM_G.noteUpdateSpamProtection then
                                        GRM_G.noteUpdateSpamProtection = true;
                                        GRM.Report(GRM.L("{name}'s note has been updated!", GRM.SlimName(playerName)));

                                        C_Timer.After(2,function()
                                            GRM_G.noteUpdateSpamProtection = false;
                                        end);
                                    end
                                end);
                            end
                        end);
                    end
                end
            end
        end
    end
end

GRM_Sys.ReplaceHyperlink = function(prefix, playerName, displayedName, suffix)
    local cleanNameStr = string.gsub(string.gsub(playerName, "|c%x%x%x%x%x%x%x%x", ""), "|r", "")
    local fullName = GRM.AppendServerName(cleanNameStr)
    local player = GRM.GetPlayer(fullName)
    
    if player and GRM.GetGuild() then
        local addTag, isMain, isUnassigned = GRM_Sys.IsValidToAddTags(player)
        if addTag then
            local mainName = isMain and fullName or GRM.GetPlayerMain(nil, player)
            local nickname = GRM.NN.GetNickname(nil, player)
            local formattedName = GRM_Name.GetFormattedNameString(cleanNameStr, mainName, nickname, isMain, isUnassigned, nil, false)
            
            local cleanDisplay = string.gsub(string.gsub(displayedName, "|c%x%x%x%x%x%x%x%x", ""), "|r", "")
            local coloredPrefixLvl = string.match(displayedName, "(|c%x%x%x%x%x%x%x%x%s*%d+%s*[:-]%s*|r)")
            local plainPrefixLvl = string.match(cleanDisplay, "^%s*%[?%s*(%d+%s*[:-])")
            local coloredSuffixLvl = string.match(displayedName, "(|c%x%x%x%x%x%x%x%x%s*%([%d]+%)%s*|r)")
            local plainSuffixLvl = string.match(cleanDisplay, "(%([%d]+%))")

            if GRM.S().colorizeNames then
                local classColor = GRM.GetStringClassColorByName(fullName)
                if coloredPrefixLvl then formattedName = coloredPrefixLvl .. classColor .. formattedName .. "|r"
                elseif plainPrefixLvl then formattedName = classColor .. plainPrefixLvl .. formattedName .. "|r"
                else formattedName = classColor .. formattedName .. "|r" end

                if coloredSuffixLvl then formattedName = formattedName .. " " .. coloredSuffixLvl
                elseif plainSuffixLvl then formattedName = string.sub(formattedName, 1, -3) .. " " .. plainSuffixLvl .. "|r" end
            else
                if coloredPrefixLvl then formattedName = coloredPrefixLvl .. formattedName
                elseif plainPrefixLvl then formattedName = plainPrefixLvl .. formattedName end
                if coloredSuffixLvl then formattedName = formattedName .. " " .. coloredSuffixLvl
                elseif plainSuffixLvl then formattedName = formattedName .. " " .. plainSuffixLvl end
            end

            if string.match(cleanDisplay, "^%s*%[") and not string.match(formattedName, "^%s*%[") then
                return prefix .. "[" .. formattedName .. "]" .. suffix
            else
                return prefix .. formattedName .. suffix
            end
        end
    end
    return prefix .. displayedName .. suffix
end

GRM_Sys.ReplaceOfflineMessage = function(text)
    local offlineStr = GRM.L("has gone offline.")
    local offStart = string.find(text, offlineStr, 1, true)
    if not offStart then return text end
    
    -- Grab everything before the offline string (this includes timestamps and the name)
    local beforeText = string.sub(text, 1, offStart - 1)
    
    -- Safely isolate the name from the timestamp using a reverse space search
    local prefix = ""
    local rawName = beforeText
    local trimmed = GRM.Util.Trim(beforeText)
    local lastSpace = string.match(trimmed, "^.*()%s")
    
    if lastSpace then
        prefix = string.sub(beforeText, 1, lastSpace)
        rawName = string.sub(beforeText, lastSpace + 1)
    end
    
    local cleanRawName = string.gsub(string.gsub(rawName, "|c%x%x%x%x%x%x%x%x", ""), "|r", "")
    cleanRawName = GRM.Util.Trim(cleanRawName)
    local fullName = GRM.AppendServerName(cleanRawName)
    local player = GRM.GetPlayer(fullName)
    
    if player and GRM.GetGuild() then
        local addTag, isMain, isUnassigned = GRM_Sys.IsValidToAddTags(player)
        if addTag then
            local mainName = isMain and fullName or GRM.GetPlayerMain(nil, player)
            local nickname = GRM.NN.GetNickname(nil, player)
            local formattedName = GRM_Name.GetFormattedNameString(cleanRawName, mainName, nickname, isMain, isUnassigned, nil, false)
            
            if GRM.S().colorizeNames then
                local classColor = GRM.GetStringClassColorByName(fullName)
                formattedName = classColor .. formattedName .. "|r"
            end
            
            local escapedRawName = string.gsub(cleanRawName, "([%%^%$%(%)%.%[%]%*%+%-%?])", "%%%1")
            local pratPattern = "|c%x%x%x%x%x%x%x%x" .. escapedRawName .. "|r"
            
            if string.find(rawName, pratPattern) then rawName = string.gsub(rawName, pratPattern, formattedName, 1)
            else rawName = string.gsub(rawName, escapedRawName, formattedName, 1) end
            
            return prefix .. rawName .. string.sub(text, offStart)
        end
    end
    return text
end

-- Method:          ProcessSystemMessage ( string )
-- What it Does:    The core routing logic for all system messages.
-- Returns:         boolean (shouldFilter), string (modifiedMsg)
local ProcessSystemMessage = function(msg)
    local shouldFilter = false

    GRM_G.guildInfoSystemMessage = GRM_G.guildInfoSystemMessage or string.sub(GUILD_INFO_TEMPLATE, 1, string.find(GUILD_INFO_TEMPLATE, "%%") - 1)

    -- GuildInfo filter (GuildInfo())
    if GRM_G.MsgFilterDelay and (string.find(msg, GRM_G.guildInfoSystemMessage) or string.find(msg, GRM.Util.Trim(CHAT_GUILD_SEND))) then
        if string.find(msg, GRM_G.guildInfoSystemMessage) and ((time() - GRM_G.SystemMsgThrottle) > 1) then
            GRM_G.SystemMsgThrottle = time()
            GRM_G.CreationDatePattern = GRM_G.CreationDatePattern or CreateGuildCreationDatePattern()
            local a, b, c, _, numUniqueAccounts = string.match(msg, GRM_G.CreationDatePattern)
            if a and b and c then
                local month, day, year
                if GRM_G.Region == "deDE" or GRM_G.Region == "esES" or GRM_G.Region == "esMX" or GRM_G.Region == "frFR" then
                    day, month, year = a, b, c
                elseif GRM_G.Region == "koKR" then
                    day, month, year = c, b, a
                else
                    day, month, year = b, a, c
                end

                if day ~= "0" then
                    numUniqueAccounts = tonumber(numUniqueAccounts)
                    if numUniqueAccounts > GRM_G.numAccounts and GRM_G.numAccounts ~= 0 then
                        GRM_G.DesignateMain = true
                        C_Timer.After(10.1, function() GRM_G.DesignateMain = false end)
                    end
                    GRM_G.numAccounts = numUniqueAccounts
                    local date = day .. "-" .. month .. "-" .. year
                    if GRM_G.guildCreationDate == "" or GRM_G.guildCreationDate ~= date then
                        GRM_G.guildCreationDate = date
                    end
                end
            end
        end
        shouldFilter = true

    -- Player Not Found / Friend List Spam, etc
    elseif (GRM_G.MsgFilterDelay or GRM_G.MsgFilterDelay2) and (msg == GRM.L("Player not found.") or string.find(msg, GRM.L("added to friends")) or string.find(msg, GRM.L("is already your friend"))) then
        shouldFilter = true

    -- Sync Player Disconnects
    elseif GRMsyncGlobals.CurrentSyncPlayer and GRMsyncGlobals.CurrentSyncPlayer ~= "" and SystemMessagePatternMatchCheck(1, msg, GRMsyncGlobals.CurrentSyncPlayer) then
        if GRMsyncGlobals.currentlySyncing then GRMsync.EndSync(false) end
        shouldFilter = true

    -- Guild Event Spam Control (Promoted, Demoted, Kicked, etc.)
    elseif string.find(msg, GRM.L("has promoted")) or string.find(msg, GRM.L("has demoted")) or string.find(msg, GRM.L("joined the guild.")) or string.find(msg, GRM.L("left the guild.")) or string.find(msg, GRM.L("has been kicked")) then
        shouldFilter = GRM.SystemMessageLiveDetectionControl(msg)
        if string.find(msg, GRM.L("has been kicked")) and (GRM_UI.GRM_ToolCoreFrame:IsVisible() and GRM.S().disableMacroToolLogSpam) then
            shouldFilter = true
        end

     elseif not GRM_G.MainNameSystemMsgControl then
        if (time() - GRMsyncGlobals.timeAtLogin) > 5 and GRM.S() then
            if string.find(msg, GRM.L("has come online.")) then
                GRM.GuildRoster()
                GRM.Scan.AnnounceIfBirthday(msg)
                C_Timer.After(1.5, function() AnnounceIfMacroReady(msg) end)
            elseif string.find(msg, GRM.L("has gone offline.")) then
                if GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
                    GRMsync.EndSync(false)
                end
                GRM.GuildRoster()
            end
        end
        
    -- Fallback Sync Disconnect Check
    elseif GRM_G.MainNameSystemMsgControl and string.find(msg, GRM.L("has gone offline.")) and GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
        GRMsync.EndSync(false)
    end
    return shouldFilter, msg
end

GRM_Sys.SetSystemMessageFilter = function(chatFrame, event, msg, ...)
    if GRM.issecretvalue(msg) then
        return false, msg, ...
    end

    local shouldFilter = false
    GRM_G.SystemMessagesEnabled = true
    
    if GRM.S() and msg and time() - GRMsyncGlobals.timeAtLogin > 1 and not GRM_G.TempBanSystemMessage then
        shouldFilter, msg = ProcessSystemMessage(msg)
    else
        shouldFilter = true
    end

    return shouldFilter, msg, ...
end

GRM_Sys.SystemMessageHandler = function(_, _, msg)
    if GRM.issecretvalue(msg) then
        return
    end
    
    if not GRM_G.SystemMessagesEnabled then
        if GRM.S() and GRM.GetGuild() ~= nil and msg and time() - GRMsyncGlobals.timeAtLogin > 1 and not GRM_G.TempBanSystemMessage then
            ProcessSystemMessage(msg)
        end
        -- SystemMessageHookControl()
    end
end

-- Method:          GRM_Sys.ParseChatForNote
-- What it Does:    Parses every comment in the guild frame and looks for the !note tag
GRM_Sys.ParseChatForNote = function(chatFrame, event, msg, sender, ...)
    if GRM.issecretvalue(msg) or GRM.issecretvalue(sender) then
        return false, msg, sender, ...
    end

    if IsInGuild() and GRM.S() and GRM.S().noteSetEnabled and GRM_G.guildName ~= "" and not GRM.issecretvalue(msg) then
        if not GRM_G.BuildHasRestrictions then
            GRM_Sys.TriggerPlayerNote(sender, msg)
        end
    end
    
    -- Must return all arguments back to the chat frame securely!
    return false, msg, sender, ...
end

GRM_Sys.MessageHookControl = function()
    if not GRM_G.MainHookConfigured and IsInGuild() and GRM.S() then
        
        -- 1. Safely hook Guild and Officer chat to scan for the !note command
        ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", GRM_Sys.ParseChatForNote)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", GRM_Sys.ParseChatForNote)
        
        -- 2. Safely hook the system messages to process guild info and spam filters
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", GRM_Sys.SetSystemMessageFilter)
        
        -- 3. Initialize the 100% Taint-Free Chat Formatter (TransformMessages)
        GRM_Sys.HookChatFrames()
        
        GRM_G.MainHookConfigured = true
    end
end
