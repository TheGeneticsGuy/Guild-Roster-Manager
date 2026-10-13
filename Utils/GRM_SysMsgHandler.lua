GRM_Sys = {};

local MainTagEvents = {
    CHAT_MSG_GUILD                 = true,
    CHAT_MSG_WHISPER               = true,
    CHAT_MSG_GUILD_ACHIEVEMENT     = true,
    CHAT_MSG_PARTY                 = true,
    CHAT_MSG_PARTY_LEADER          = true,
    CHAT_MSG_RAID                  = true,
    CHAT_MSG_RAID_LEADER           = true,
    CHAT_MSG_INSTANCE_CHAT         = true,
    CHAT_MSG_INSTANCE_CHAT_LEADER  = true,
    CHAT_MSG_OFFICER               = true,
}

-- Method:          CreateGuildCreationDatePattern()
-- What it Does:    Creates the guild Creation Date Pattern
-- Purpose:         Easier parse the creation date without repetitive work.
local CreateGuildCreationDatePattern = function()
    local pattern = GUILD_INFO_TEMPLATE;

    if GRM_G.BuildVersion >= 30000 or GRM_G.Region == "deDE" or GRM_G.Region == "frFR" or GRM_G.Region == "koKR" then
        for i = 1, 5 do
            pattern = string.gsub(pattern, "%%" .. i .. "$d", "(%%d+)");
        end
    else
        pattern = string.gsub(pattern, "%%d", "(%%d+)");
    end

    return pattern;
end

-- Method:          SystemMessageHookControl()
-- What it Does:    Checks to ensure script modification happens at the end of the sequential table to ensure all addon compatibility
-- Purpose:         Quality of life - prevent frustration for other addon devs
local SystemMessageHookControl = function()
    if (time() - GRMsyncGlobals.timeAtLogin) < 30 then
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", GRM_Sys.SetSystemMessageFilter);
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", GRM_Sys.SetSystemMessageFilter);
    end
end

-- Method:          GRM_Sys.MessageHookControl()
-- What it Does:    Handles some communications issues with the chat so that the main tags can be hooked into and edited
-- Purpose:         Message editing of GRM tags
GRM_Sys.MessageHookControl = function()
    if not GRM_G.MainHookConfigured and IsInGuild() and GRM.S() then
        for chat_event in pairs(MainTagEvents) do
            ChatFrame_AddMessageEventFilter(chat_event, GRM.AddMainToChat);
        end
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", GRM_Sys.SetSystemMessageFilter);
        GRM_G.MainHookConfigured = true;
    end
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
                if GRM_G.BuildVersion < 40000 then -- Not known exact expansion it changed
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
        -- SPECIAL RULES? No need atm as no need for alts to be given any special preference.
    end
end

local IsDisabled

GRM.IsValidToAddTags = function( player )
    -- Nickname first
    local nickname = GRM.NN.GetNickname(player.name)
    local result = false
    local isUnassigned = false
    local isMain = GRM.IsMain(player.name)

    if nickname and nickname ~= "" then
        -- Player has nickname, let's check nickname settings for main
        local nickMainDisabled = GRM_Name.IsTagDisabled("NICKMAIN", GRM.S().nicknameFormatMain)
        local nickAltDisabled = GRM_Name.IsTagDisabled("NICKKALT", GRM.S().nicknameFormatAlt)
        local nickUnassignedDisabled = GRM_Name.IsTagDisabled("NICKUNASSIGNED", GRM.S().nnFormatUnassigned)

        if isMain then
            if not nickMainDisabled then
                result = true;
            end
        else
            -- In a group
            if GRM.PlayerHasAlts(player) then
                -- Player is an Alt or unassigned
                if not GRM.PlayerIsUnassignedInGroup(player) then
                    -- Player is an Alt and IS assigned
                    if not nickAltDisabled then
                        result = true
                    end
                else
                    isUnassigned = true
                    -- player is unassigned
                    if not nickUnassignedDisabled then 
                        result = true
                    end
                end
            else
                -- player is unassigned
                isUnassigned = true
                if not nickUnassignedDisabled then 
                    result = true
                end
            end
        end
    
    else
        -- No nickname - alt/main only
        if GRM.PlayerHasAlts(player) then
            if not GRM.PlayerIsUnassignedInGroup(player) then
                local mainDisabled = GRM_Name.IsTagDisabled("NICKMAIN", GRM.S().nicknameFormatMain)
                local altDisabled = GRM_Name.IsTagDisabled("NICKKALT", GRM.S().nicknameFormatAlt)
                if isMain then
                    if not mainDisabled then
                        result = true;
                    end
                else
                    if not altDisabled then
                        result = true;
                    end
                end
            else
                isUnassigned = true
            end
        end
    end

    return result, isMain, isUnassigned
end

-- Method:          AddMainTagToComeOnlineSystemMessage ( string )
-- What it Does:    Adds the formatted main/alt/nickname tags to the come online message
local AddMainTagToComeOnlineSystemMessage = function(msg)
    -- We use gsub to safely reconstruct the clickable player link!
    return string.gsub(msg, "(|Hplayer:([^:]*).-|h)%[.-%](|h)", function(prefix, name, suffix)
        local fullName = GRM.AppendServerName(name)
        local player = GRM.GetPlayer(fullName)

        if player and GRM.GetGuild() then
            local addTag, isMain, isUnassigned = IsValidToAddTags(player);

            if addTag then
                -- Fetch the core details
                local mainName = ""
                if isMain then
                    print("PLAYER IS MAIN")
                    mainName = fullName
                else
                    mainName = GRM.GetPlayerMain(fullName)
                end
                
                local nickname = GRM.NN.GetNickname(fullName)
                
                -- Route it through your new universal formatter!
                local formattedName = GRM_Name.GetFormattedNameString(fullName, mainName, nickname, isMain, isUnassigned, nil, false)
                
                -- Colorize
                if GRM.S().colorizeNames then
                    local classColor = GRM.GetStringClassColorByName(fullName)
                    formattedName = classColor .. formattedName .. "|r"
                end
                
                -- Reconstruct the chat link with the newly formatted name
                return prefix .. "[" .. formattedName .. "]" .. suffix
            end
        end
        
        -- Fallback if not a guild member
        return prefix .. "[" .. name .. "]" .. suffix
    end, 1)
end

-- Method:          AddMainTagToGoneOfflineSystemMessage ( string )
-- What it Does:    Adds the formatted main/alt/nickname tags to the gone offline message
local AddMainTagToGoneOfflineSystemMessage = function(msg)
    local breakIndex = string.find(msg, " ")
    if not breakIndex then
        breakIndex = string.find(msg, "下線了。") or string.find(msg, "下线了。")
    end

    if not breakIndex then return msg end

    local name = string.sub(msg, 1, breakIndex - 1)
    local fullName = GRM.AppendServerName(name)
    local player = GRM.GetPlayer(fullName)

    if player and GRM.GetGuild() then
        local addTag, isMain, isUnassigned = IsValidToAddTags(player);

        if addTag then
            -- Fetch the core details
            local mainName = ""
            if isMain then
                print("PLAYER IS MAIN")
                mainName = fullName
            else
                mainName = GRM.GetPlayerMain(fullName)
            end
            
            local nickname = GRM.NN.GetNickname(fullName)

            -- Route it through your new universal formatter!
            local formattedName = GRM_Name.GetFormattedNameString(fullName, mainName, nickname, isMain, isUnassigned, nil, false)
            
            -- Colorize
            if GRM.S().colorizeNames then
                local classColor = GRM.GetStringClassColorByName(fullName)
                formattedName = classColor .. formattedName .. "|r"
            end
            
            -- Since going offline we don't need brackets as we can't click to msg
            return formattedName .. string.sub(msg, breakIndex)
        end
    end

    return msg
end

-- -- Method:          AddMainTagToComeOnlineSystemMessage ( string )
-- -- What it Does:    Adds the main/alt tags to the system messages for coming online.
-- -- Purpose:         Alt management feature!
-- local AddMainTagToComeOnlineSystemMessage = function(msg)
--     local name = select(3, msg:find("|Hplayer:([^:]*)(.-)|h%[.-%]|h"));
--     local fullName = GRM.AppendServerName(name);
--     local result = msg;

--     if GRM.GetGuild() and GRM_G.guildName ~= "" and IsInGuild() then

--         local player = GRM.GetPlayer(fullName);
--         if IsInGuild() and player then

--             local systemMsgHex = "|CFFFFFF00";
--             local mainTag = GRM_Name.GetMainTags(false, GRM.S().mainTagIndex);
--             local altTag = GRM_Name.GetAltTags(false, GRM.S().mainTagIndex);
--             local tempName = "";
--             local classColor = "";
--             if GRM.S().colorizeNames then
--                 classColor = GRM.GetStringClassColorByName(fullName);
--             end

--             if ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then

--                 if GRM.IsMain ( fullName ) then

--                     tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. GRM_G.TagHexCode .. mainTag .. "|r " .. GRM.L("has come online.");

--                 elseif GRM.PlayerIsAnAlt(player) and not GRM.S().showMainName then -- Only show tag if NOT showing main
--                     -- Has alts, but is not the main.

--                     tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. GRM_G.TagHexCode .. altTag .. "|r " .. GRM.L("has come online.");

--                 end
--             end

--             if GRM.S().showMainName and GRM.PlayerIsAnAlt(player) then
--                 local mainName = GRM.GetFormattedMainName(fullName, false);

--                 if mainName ~= "" then
--                     local mainColoring = GRM.GetStringClassColorByName(mainName);
--                     mainName = mainColoring .. "(" .. GRM.FormatName(mainName) .. ")|r"

--                     if ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then
--                         mainName = mainName .. " " .. GRM_G.TagHexCode .. mainTag .. "|r";
--                     end

--                     if tempName ~= "" then
--                         tempName = tempName .. " " .. mainName;
--                     else
--                         tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. " " .. mainName .. " " .. GRM.L("has come online.");
--                     end
--                 end
--             end

--             if tempName == "" then
--                 tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. " " .. GRM.L("has come online.");
--             end

--             if tempName ~= "" then
--                 result = tempName;
--             end
--         end
--     end

--     return result;
-- end

-- -- Method:          AddMainTagToGoneOfflineSystemMessage ( string )
-- -- What it Does:    Adds the main tag to the system message announce when a player goes offline and colorizes their names
-- -- Purpose:         Quality of life information.
-- local AddMainTagToGoneOfflineSystemMessage = function(msg)
    
--     local breakIndex = string.find(msg, " "); -- This format fits almost all
--     if not breakIndex then
--         breakIndex = string.find(msg, "下線了。"); -- Taiwanese
--         if not breakIndex then
--             breakIndex = string.find(msg, "下线了。"); -- Mandarin
--         end
--     end

--     local finalNameFormat = "";
--     local tempName = "";
--     local fullName = "";

--     if GRM.GetGuild() then

--         fullName = GRM.AppendServerName(string.sub(msg, 1, breakIndex - 1));

--         if GRM.S().showMainName and not ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then
--             local mainName = GRM.GetFormattedMainName(fullName, false);

--             if mainName ~= "" then
--                 local formattedMainName = GRM.FormatName(mainName);

--                 if formattedMainName ~= GRM.FormatName(fullName) then
--                     local mainColoring = GRM.GetStringClassColorByName(mainName);
--                     tempName = mainColoring .. "(" .. GRM.FormatName(mainName) .. ")|r"
--                 end
--             end

--         elseif ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then
--             local showAltTag = false;
--             local player = GRM.GetPlayer(fullName);

--             if player and not GRM.PlayerHasAlts(player) or not GRM.S().showMainName then
--                 showAltTag = true;
--             end

--             finalNameFormat = GRM.GetNameWithMainTags(fullName, true, GRM.S().showMainName, showAltTag, true);
--         end

--         if GRM.S().colorizeNames then
--             if finalNameFormat == "" then
--                 local hexCode = GRM.GetStringClassColorByName(fullName);
--                 fullName = hexCode .. GRM.FormatName(fullName) .. "|r";
--             end
--         else
--             fullName = GRM.FormatName(fullName);
--         end
--     end

--     if finalNameFormat == "" then
--         if tempName ~= "" then
--             finalNameFormat = fullName .. " " .. tempName;
--         else
--             finalNameFormat = fullName;
--         end
--     end

--     return finalNameFormat .. string.sub(msg, breakIndex);
-- end

-- Method:          ProcessSystemMessage ( string )
-- What it Does:    The core routing logic for all system messages.
-- Returns:         boolean (shouldFilter), string (modifiedMsg)
local ProcessSystemMessage = function(msg)
    local shouldFilter = false

    GRM_G.guildInfoSystemMessage = GRM_G.guildInfoSystemMessage or string.sub(GUILD_INFO_TEMPLATE, 1, string.find(GUILD_INFO_TEMPLATE, "%%") - 1)

    -- 1. GUILD INFO FILTER (GuildInfo())
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

    -- 2. Player Not Found / Friend List Spam
    elseif (GRM_G.MsgFilterDelay or GRM_G.MsgFilterDelay2) and (msg == GRM.L("Player not found.") or string.find(msg, GRM.L("added to friends")) or string.find(msg, GRM.L("is already your friend"))) then
        shouldFilter = true

    -- 3. Sync Player Disconnects
    elseif GRMsyncGlobals.CurrentSyncPlayer and GRMsyncGlobals.CurrentSyncPlayer ~= "" and SystemMessagePatternMatchCheck(1, msg, GRMsyncGlobals.CurrentSyncPlayer) then
        if GRMsyncGlobals.currentlySyncing then GRMsync.EndSync(false) end
        shouldFilter = true

    -- 4. Guild Event Spam Control (Promoted, Demoted, Kicked, etc.)
    elseif string.find(msg, GRM.L("has promoted")) or string.find(msg, GRM.L("has demoted")) or string.find(msg, GRM.L("joined the guild.")) or string.find(msg, GRM.L("left the guild.")) or string.find(msg, GRM.L("has been kicked")) then
        shouldFilter = GRM.SystemMessageLiveDetectionControl(msg)
        if string.find(msg, GRM.L("has been kicked")) and (GRM_UI.GRM_ToolCoreFrame:IsVisible() and GRM.S().disableMacroToolLogSpam) then
            shouldFilter = true
        end

    -- 5. Logon / Logoff Name Replacements
    elseif not GRM_G.MainNameSystemMsgControl then
        if (time() - GRMsyncGlobals.timeAtLogin) > 5 and GRM.S() then
            if string.find(msg, GRM.L("has come online.")) then
                GRM.GuildRoster()
                msg = AddMainTagToComeOnlineSystemMessage(msg)
                GRM.Scan.AnnounceIfBirthday(msg)
                C_Timer.After(1.5, function() AnnounceIfMacroReady(msg) end)

            elseif string.find(msg, GRM.L("has gone offline.")) then
                if GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
                    GRMsync.EndSync(false)
                end
                GRM.GuildRoster()
                msg = AddMainTagToGoneOfflineSystemMessage(msg)
            end
        end
        
    -- 6. Fallback Sync Disconnect Check
    elseif GRM_G.MainNameSystemMsgControl and string.find(msg, GRM.L("has gone offline.")) and GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
        GRMsync.EndSync(false)
    end

    return shouldFilter, msg
end

-- Method:          GRM_Sys.SetSystemMessageFilter
-- Purpose:         Filters chat spam during server inquiries and injects tags.
GRM_Sys.SetSystemMessageFilter = function(_, _, msg, ...)
    local shouldFilter = false
    GRM_G.SystemMessagesEnabled = true

    if GRM.S() and msg and time() - GRMsyncGlobals.timeAtLogin > 1 and not GRM_G.TempBanSystemMessage and not GRM.issecretvalue(msg) then
        shouldFilter, msg = ProcessSystemMessage(msg)
    else
        shouldFilter = true
    end

    SystemMessageHookControl()
    return shouldFilter, msg, ...
end

-- Method:          GRM_Sys.SystemMessageHandler
-- Purpose:         Tracks events when filtering is OFF, while still injecting name tags.
GRM_Sys.SystemMessageHandler = function(_, _, msg)
    if not GRM_G.SystemMessagesEnabled and not GRM.issecretvalue(msg) then
        if GRM.S() and GRM.GetGuild() ~= nil and msg and time() - GRMsyncGlobals.timeAtLogin > 1 and not GRM_G.TempBanSystemMessage then
            
            -- We don't care about the boolean return here, we just want to run the logic and modify the string!
            _, msg = ProcessSystemMessage(msg)
        end
        SystemMessageHookControl()
    end
end

-- Method:          GRM_Sys.SetGuildInfoDetails()
-- Purpose:         Calls the server info on the guild and parses out the number of exact unique accounts are in the guild. It also filters the chat msg to avoid chat spam, then unfilters it immediately after
--                  as a Quality of Life feature so the user can manually continue to call as needed.
-- Purpose:         It is useful information to know how many unique acocunts are in the guild. This particularly is useful when comparing how many "mains" there
--                  are on the audit window...
GRM_Sys.SetGuildInfoDetails = function()
    GRM_G.MsgFilterDelay = true; -- Resets the 1 second timer upon calling this method for the chat spam blocking. This ensures player manual calls are visual, but code calls are filtered.
    GRM.ConfigureGuild();

    if not GRM_G.MsgFilterEnabled then -- Gate to ensure this only is registered one time. This is also controlled here so as to not waste resources by being called needlessly if player never checks audit window
        GRM_G.MsgFilterEnabled = true; -- Establishing boolean gate so it is only registered once.
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", GRM_Sys.SetSystemMessageFilter);
    end
    GuildInfo();
    -- This should only be blocked momentarily.
    C_Timer.After(2, function()
        GRM_G.MsgFilterDelay = false;
    end);
end