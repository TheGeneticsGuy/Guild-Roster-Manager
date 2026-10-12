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

-- Method:          AddMainTagToComeOnlineSystemMessage ( string )
-- What it Does:    Adds the main/alt tags to the system messages for coming online.
-- Purpose:         Alt management feature!
local AddMainTagToComeOnlineSystemMessage = function(msg)
    local name = select(3, msg:find("|Hplayer:([^:]*)(.-)|h%[.-%]|h"));
    local fullName = GRM.AppendServerName(name);
    local result = msg;

    if GRM.GetGuild() and GRM_G.guildName ~= "" and IsInGuild() then

        local player = GRM.GetPlayer(fullName);
        if IsInGuild() and player then

            local systemMsgHex = "|CFFFFFF00";
            local mainTag = GRM_Name.GetMainTags(false, GRM.S().mainTagIndex);
            local altTag = GRM_Name.GetAltTags(false, GRM.S().mainTagIndex);
            local tempName = "";
            local classColor = "";
            if GRM.S().colorizeNames then
                classColor = GRM.GetStringClassColorByName(fullName);
            end

            if ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then

                if GRM.IsMain ( fullName ) then

                    tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. GRM_G.TagHexCode .. mainTag .. "|r " .. GRM.L("has come online.");

                elseif GRM.PlayerIsAnAlt(player) and not GRM.S().showMainName then -- Only show tag if NOT showing main
                    -- Has alts, but is not the main.

                    tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. GRM_G.TagHexCode .. altTag .. "|r " .. GRM.L("has come online.");

                end
            end

            if GRM.S().showMainName and GRM.PlayerIsAnAlt(player) then
                local mainName = GRM.GetFormattedMainName(fullName, false);

                if mainName ~= "" then
                    local mainColoring = GRM.GetStringClassColorByName(mainName);
                    mainName = mainColoring .. "(" .. GRM.FormatName(mainName) .. ")|r"

                    if ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then
                        mainName = mainName .. " " .. GRM_G.TagHexCode .. mainTag .. "|r";
                    end

                    if tempName ~= "" then
                        tempName = tempName .. " " .. mainName;
                    else
                        tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. " " .. mainName .. " " .. GRM.L("has come online.");
                    end
                end
            end

            if tempName == "" then
                tempName = systemMsgHex .. string.format("%s|Hplayer:%s|h[%s]|h|r", classColor, name, name) .. " " .. GRM.L("has come online.");
            end

            if tempName ~= "" then
                result = tempName;
            end
        end
    end

    return result;
end

-- Method:          AddMainTagToGoneOfflineSystemMessage ( string )
-- What it Does:    Adds the main tag to the system message announce when a player goes offline and colorizes their names
-- Purpose:         Quality of life information.
local AddMainTagToGoneOfflineSystemMessage = function(msg)
    
    local breakIndex = string.find(msg, " "); -- This format fits almost all
    if not breakIndex then
        breakIndex = string.find(msg, "下線了。"); -- Taiwanese
        if not breakIndex then
            breakIndex = string.find(msg, "下线了。"); -- Mandarin
        end
    end

    local finalNameFormat = "";
    local tempName = "";
    local fullName = "";

    if GRM.GetGuild() then

        fullName = GRM.AppendServerName(string.sub(msg, 1, breakIndex - 1));

        if GRM.S().showMainName and not ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then
            local mainName = GRM.GetFormattedMainName(fullName, false);

            if mainName ~= "" then
                local formattedMainName = GRM.FormatName(mainName);

                if formattedMainName ~= GRM.FormatName(fullName) then
                    local mainColoring = GRM.GetStringClassColorByName(mainName);
                    tempName = mainColoring .. "(" .. GRM.FormatName(mainName) .. ")|r"
                end
            end

        elseif ( GRM.S().useMainTag and GRM_G.TagHexCode ~= "" ) then
            local showAltTag = false;
            local player = GRM.GetPlayer(fullName);

            if player and not GRM.PlayerHasAlts(player) or not GRM.S().showMainName then
                showAltTag = true;
            end

            finalNameFormat = GRM.GetNameWithMainTags(fullName, true, GRM.S().showMainName, showAltTag, true);
        end

        if GRM.S().colorizeNames then
            if finalNameFormat == "" then
                local hexCode = GRM.GetStringClassColorByName(fullName);
                fullName = hexCode .. GRM.FormatName(fullName) .. "|r";
            end
        else
            fullName = GRM.FormatName(fullName);
        end
    end

    if finalNameFormat == "" then
        if tempName ~= "" then
            finalNameFormat = fullName .. " " .. tempName;
        else
            finalNameFormat = fullName;
        end
    end

    return finalNameFormat .. string.sub(msg, breakIndex);
end

-- Method:          GRM_Sys.SetSystemMessageFilter ( self , string , string )
-- What it Does:    Starts tracking the system messages for filtering. This is only triggered on the audit frame initialization or if a player has left the guild
-- Purpose:         To control system message spam when doing server inquiries
GRM_Sys.SetSystemMessageFilter = function(_, _, msg, ...)
    local result = false;
    GRM_G.SystemMessagesEnabled = true;

    -- Error protection to not break chat
    if GRM.S() then
        if msg and time() - GRMsyncGlobals.timeAtLogin > 1 and not GRM_G.TempBanSystemMessage and not GRM.issecretvalue(msg)  then
            GRM_G.guildInfoSystemMessage = GRM_G.guildInfoSystemMessage or
                                            string.sub(GUILD_INFO_TEMPLATE, 1,
                    string.find(GUILD_INFO_TEMPLATE, "%%") - 1);
            -- GUILD INFO FILTER (GuildInfo())
            if GRM_G.MsgFilterDelay and 
                (string.find(msg, GRM_G.guildInfoSystemMessage) ~= nil or string.find(msg, GRM.Util.Trim(CHAT_GUILD_SEND)) ~=
                    nil) then -- These may need to be localized. I have not yet tested if other regions return same info. It IS system info.
                if string.find(msg, GRM_G.guildInfoSystemMessage) ~= nil and ((time() - GRM_G.SystemMsgThrottle) > 1) then
                    GRM_G.SystemMsgThrottle = time();
                    GRM_G.CreationDatePattern = GRM_G.CreationDatePattern or CreateGuildCreationDatePattern();

                    local a, b, c, _, numUniqueAccounts = string.match(msg, GRM_G.CreationDatePattern);
                    local month, day, year;
                    -- a , b , c can be either day, month, or year, depending on the Region formatting for the note.
                    if GRM_G.Region == "deDE" or GRM_G.Region == "esES" or GRM_G.Region == "esMX" or GRM_G.Region ==
                        "frFR" then
                        day = a;
                        month = b;
                        year = c;
                    elseif GRM_G.Region == "enUS" or GRM_G.Region == "itIT" or GRM_G.Region == "ptBR" or GRM_G.Region ==
                        "ruRU" or GRM_G.Region == "zhCN" or GRM_G.Region == "zhTW" then
                        day = b;
                        month = a;
                        year = c;
                    elseif GRM_G.Region == "koKR" then
                        day = c;
                        month = b;
                        year = a;
                    end

                    -- On first logging in, there can be an error and not be able to load.
                    if day ~= "0" then

                        numUniqueAccounts = tonumber(numUniqueAccounts);

                        -- For auto-main tagging... detect the change here!
                        if numUniqueAccounts > GRM_G.numAccounts and GRM_G.numAccounts ~= 0 then
                            GRM_G.DesignateMain = true;
                            C_Timer.After(10.1, function()
                                GRM_G.DesignateMain = false;
                            end);
                        end

                        GRM_G.numAccounts = numUniqueAccounts;
                        local date = day .. "-" .. month .. "-" .. year;

                        if GRM_G.guildCreationDate == "" or GRM_G.guildCreationDate ~= date then
                            GRM_G.guildCreationDate = date;
                        end

                    end
                end
                result = true;

                -- Player Not Found when trying to add to friends list message
            elseif (GRM_G.MsgFilterDelay or GRM_G.MsgFilterDelay2) and
                (msg == GRM.L("Player not found.") or string.find(msg, GRM.L("added to friends")) ~= nil or
                    string.find(msg, GRM.L("is already your friend")) ~= nil) then
                result = true;

            elseif GRMsyncGlobals.CurrentSyncPlayer and GRMsyncGlobals.CurrentSyncPlayer ~= "" and
                SystemMessagePatternMatchCheck(1, msg, GRMsyncGlobals.CurrentSyncPlayer) then

                if GRMsyncGlobals.currentlySyncing then
                    GRMsync.EndSync(false);
                end

                result = true;

            elseif string.find(msg, GRM.L("has promoted")) ~= nil or string.find(msg, GRM.L("has demoted")) ~= nil or
                string.find(msg, GRM.L("joined the guild.")) ~= nil or string.find(msg, GRM.L("left the guild.")) ~= nil or
                string.find(msg, GRM.L("has been kicked")) ~= nil then
                -- Silence messages the log
                result = GRM.SystemMessageLiveDetectionControl(msg);

                -- Force filter the message
                if string.find(msg, GRM.L("has been kicked")) ~= nil and
                    (GRM_UI.GRM_ToolCoreFrame:IsVisible() and GRM.S().disableMacroToolLogSpam) then
                    result = true;
                end

                -- Normal System message... Let's add the main tags...
            elseif not GRM_G.MainNameSystemMsgControl then -- No need to add a tag if they just joined... as they have no tag, and their profile is not yet generated. Addon will see them as a non-guildie the first instant.
                if (time() - GRMsyncGlobals.timeAtLogin) > 5 and GRM.S() and
                    ((GRM_G.TagHexCode ~= "" and (GRM.S().showMainName or GRM.S().useMainTag)) or GRM.S().colorizeNames) then
                    if string.find(msg, GRM.L("has come online.")) ~= nil then
                        GRM.GuildRoster();
                        msg = AddMainTagToComeOnlineSystemMessage(msg);

                        -- Check if it is their birthday.
                        GRM.Scan.AnnounceIfBirthday(msg);

                        C_Timer.After(1.5,
                            function() -- Giving a delay as I found instantly the "IsOnline" to not be accurate from server always. Need a second or so to register.
                                AnnounceIfMacroReady(msg);
                            end);

                    elseif string.find(msg, GRM.L("has gone offline.")) ~= nil then
                        if GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
                            GRMsync.EndSync(false);
                        end
                        GRM.GuildRoster();
                        msg = AddMainTagToGoneOfflineSystemMessage(msg);
                    end

                elseif (time() - GRMsyncGlobals.timeAtLogin) > 5 then
                    if string.find(msg, GRM.L("has come online.")) ~= nil or
                        string.find(msg, GRM.L("has gone offline.")) ~= nil then
                        GRM.GuildRoster();
                    end
                end
            elseif GRM_G.MainNameSystemMsgControl and string.find(msg, GRM.L("has gone offline.")) ~= nil and
                GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
                GRMsync.EndSync(false);
            end
        else
            result = true;
        end
    end

    SystemMessageHookControl();

    return result, msg, ...;
end

-- Method:          GRM_Sys.SystemMessageHandler ( self , string , string )
-- What it Does:    Starts tracking the system messages. This only runs if system messages are disabled, thus this prioritizes over the filtering function
-- Purpose:         For faster response to LIVE events rather than waiting for server query updates.
GRM_Sys.SystemMessageHandler = function(_, _, msg)
    if not GRM_G.SystemMessagesEnabled and not GRM.issecretvalue(msg) then

        -- Error protection to not break chat
        if GRM.S() and GRM.GetGuild() ~= nil then
            if msg and time() - GRMsyncGlobals.timeAtLogin > 1 and not GRM_G.TempBanSystemMessage then

                GRM_G.guildInfoSystemMessage = GRM_G.guildInfoSystemMessage or
                                                   string.sub(GUILD_INFO_TEMPLATE, 1,
                        string.find(GUILD_INFO_TEMPLATE, "%%") - 1);

                -- GUILD INFO FILTER (GuildInfo())
                if GRM_G.MsgFilterDelay and
                    (string.find(msg, GRM_G.guildInfoSystemMessage) ~= nil or
                        string.find(msg, GRM.Util.Trim(CHAT_GUILD_SEND)) ~= nil) then -- These may need to be localized. I have not yet tested if other regions return same info. It IS system info.
                    if string.find(msg, GRM_G.guildInfoSystemMessage) ~= nil and
                        ((time() - GRM_G.SystemMsgThrottle) > 1) then
                        GRM_G.SystemMsgThrottle = time();
                        GRM_G.CreationDatePattern = GRM_G.CreationDatePattern or CreateGuildCreationDatePattern();

                        local a, b, c, _, numUniqueAccounts = string.match(msg, GRM_G.CreationDatePattern);
                        local month, day, year;
                        -- a , b , c can be either day, month, or year, depending on the Region formatting for the note.
                        if GRM_G.Region == "deDE" or GRM_G.Region == "esES" or GRM_G.Region == "esMX" or GRM_G.Region ==
                            "frFR" then
                            day = a;
                            month = b;
                            year = c;
                        elseif GRM_G.Region == "enUS" or GRM_G.Region == "itIT" or GRM_G.Region == "ptBR" or
                            GRM_G.Region == "ruRU" or GRM_G.Region == "zhCN" or GRM_G.Region == "zhTW" then
                            day = b;
                            month = a;
                            year = c;
                        elseif GRM_G.Region == "koKR" then
                            day = c;
                            month = b;
                            year = a;
                        end

                        -- On first logging in, there can be an error and not be able to load.
                        if day ~= "0" then

                            numUniqueAccounts = tonumber(numUniqueAccounts);

                            -- For auto-main tagging... detect the change here!
                            if numUniqueAccounts > GRM_G.numAccounts and GRM_G.numAccounts ~= 0 then
                                GRM_G.DesignateMain = true;
                                C_Timer.After(10.1, function()
                                    GRM_G.DesignateMain = false;
                                end);
                            end

                            GRM_G.numAccounts = numUniqueAccounts;

                            local date = day .. "-" .. month .. "-" .. year;

                            if GRM_G.guildCreationDate == "" or GRM_G.guildCreationDate ~= date then
                                GRM_G.guildCreationDate = date;
                            end

                        end
                    end

                elseif GRMsyncGlobals.CurrentSyncPlayer and GRMsyncGlobals.CurrentSyncPlayer ~= "" and
                    SystemMessagePatternMatchCheck(1, msg, GRMsyncGlobals.CurrentSyncPlayer) then

                    if GRMsyncGlobals.currentlySyncing then
                        GRMsync.EndSync(false);
                    end

                elseif string.find(msg, GRM.L("has promoted")) ~= nil or string.find(msg, GRM.L("has demoted")) ~= nil or
                    string.find(msg, GRM.L("joined the guild.")) ~= nil or string.find(msg, GRM.L("left the guild.")) ~=
                    nil or string.find(msg, GRM.L("has been kicked")) ~= nil then
                    -- Silence messages the log
                    GRM.SystemMessageLiveDetectionControl(msg);

                    -- Normal System message... Let's add the main tags...
                elseif not GRM_G.MainNameSystemMsgControl then -- No need to add a tag if they just joined... as they have no tag, and their profile is not yet generated. Addon will see them as a non-guildie the first instant.
                    if (time() - GRMsyncGlobals.timeAtLogin) > 5 and GRM.S() and
                        ((GRM_G.TagHexCode ~= "" and (GRM.S().showMainName or GRM.S().useMainTag)) or GRM.S().colorizeNames) then
                        if string.find(msg, GRM.L("has come online.")) ~= nil then
                            GRM.GuildRoster();
                            msg = AddMainTagToComeOnlineSystemMessage(msg);

                            -- Check if it is their birthday.
                            GRM.Scan.AnnounceIfBirthday(msg);

                            C_Timer.After(1.5,
                                function() -- Giving a delay as I found instantly the "IsOnline" to not be accurate from server always. Need a second or so to register.
                                    AnnounceIfMacroReady(msg);
                                end);

                        elseif string.find(msg, GRM.L("has gone offline.")) ~= nil then
                            if GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
                                GRMsync.EndSync(false);
                            end
                            GRM.GuildRoster();
                            msg = AddMainTagToGoneOfflineSystemMessage(msg);
                        end

                    elseif (time() - GRMsyncGlobals.timeAtLogin) > 5 then
                        if string.find(msg, GRM.L("has come online.")) ~= nil or
                            string.find(msg, GRM.L("has gone offline.")) ~= nil then
                            GRM.GuildRoster();
                        end
                    end
                elseif GRM_G.MainNameSystemMsgControl and string.find(msg, GRM.L("has gone offline.")) ~= nil and
                    GRMsyncGlobals.currentlySyncing and SyncPlayerGoneOffline(msg) then
                    GRMsync.EndSync(false);
                end
            end
        end
        -- Re-evaluate message controls
        SystemMessageHookControl();
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