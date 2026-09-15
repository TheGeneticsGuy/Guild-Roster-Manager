-- To hold initial Configuration type functions as well as
-- initialization process


local Config = {};

GRM.Config = Config;

-- Build UI addon listener for delayed load frames.
local Initialization = CreateFrame("Frame");

-- Method:          Config.GetTimeOffesets()
-- What it Does:    Determines the number of hours a player needs to gain or lose based on their local time, to match server time.
-- Purpose:         The date() function pulls OS time, not server time. This allows me to adjust for it.
Config.GetTimeOffesets = function()
    -- First, let's get local time.
    local local_TimeTable = date("*t");
    -- Then, server time
    local day, _, hour = select(3, GRM.Time.GetTodaysDate());

    local offsetServer = 0;

    if local_TimeTable.day == day then
        -- we can easily check this now.
        if local_TimeTable.hour == hour then
            offsetServer = 0;
        elseif local_TimeTable.hour > hour then
            offsetServer = (local_TimeTable.hour - hour) * -1; -- -hours
        elseif local_TimeTable.hour < hour then
            offsetServer = hour - local_TimeTable.hour --  +hours
        end

    else
        if local_TimeTable.day > day then
            offsetServer = ((local_TimeTable.hour + 24) - hour) * -1;
        elseif local_TimeTable.day < day then
            offsetServer = (hour + 24) - local_TimeTable.hour
        end
    end

    return offsetServer;
end

-------------------------------------------------
--------- INITIALIZATION ON START ---------------
-------------------------------------------------

-- Live Frames for Event tracking
local GeneralEventTracking = CreateFrame("Frame");
local SystemMessageChecking = CreateFrame("Frame");
local AchievementsChecking = CreateFrame("Frame");

-- Method:          Config.ActivateAddon( self , string , string )
-- What it Does:    First, doesn't trigger to load until all variables of addon fully loaded.
--                  Then, it triggers to delay until player is fully in the world, in that order.
--                  Finally, it delays 5 seconds upon querying server as often initial Roster and Guild Event Log query takes a moment to return info.
-- Purpose:         To ensure the smooth handling and loading of the addon so all information is accurate before attempting to parse guild info.
Config.ActivateAddon = function(_, event, addon, isReload )
    if event == "ADDON_LOADED" and addon == GRM_G.addonName then
        Initialization:UnregisterEvent("ADDON_LOADED");
        Initialization:RegisterEvent("PLAYER_ENTERING_WORLD"); -- Ensures this check does not occur until after Addon is fully loaded.

    elseif event == "PLAYER_ENTERING_WORLD" then
        Initialization:UnregisterEvent("PLAYER_ENTERING_WORLD");

        if isReload then
            GRMsyncGlobals.reloadControl = true;
        end

        if GRM_G.faction == nil then
            GRM_G.faction = UnitFactionGroup("PLAYER");
        end

        GRM.ConfigureAnnounceOnLogin(); -- So no repeat announcements

        GRM_G.OStimeOffset = Config.GetTimeOffesets(); -- One time configuration of gameTime Offsets;
        GRM_G.SessionTime = time();
        GRM.DataLoadDelayProtection();
    end
end

-- Method:          GRM.DelayForGuildInfoCallback()
-- What it Does:    It basically recursively waits til the conditions are met and the server properly retrieved the guildCreationDate
-- Purpose:         If a guild is on more than one server with the same name, that can complicate things. This helps idenitfy the server by the creation date as well...
GRM.DelayForGuildInfoCallback = function()
    if GRM_G.guildCreationDate == "" then
        if not GRM_G.secretValueOnLoadDelay then
            if GRM_G.secretValueDelay then
                GRM_G.secretValueOnLoadDelay = true
                GRM.SecretValueLoadDelayHandler();
            else
                GRM.SetGuildInfoDetails();
                GRM.GuildRoster();
                if GRM_G.RestrictionAnnounced then
                    GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("Addons are no longer restricted. Continuing GRM initialization now.") );
                end
            end
        end
        C_Timer.After(1, GRM.DelayForGuildInfoCallback);
        return
    elseif GRM_G.NumberOfHoursTilRecommend.kick == nil or GRM_G.NumberOfHoursTilRecommend.kickActive == nil then
        GRM.Scan.RefreshNumberOfHoursTilRecommend();

        C_Timer.After(1, GRM.DelayForGuildInfoCallback);
        return
    elseif GRM_G.gClubID == 0 then
        if C_Club.GetGuildClubId ~= nil then
            GRM_G.gClubID = C_Club.GetGuildClubId();
        else
            GRM_G.gClubID = 1;
        end

        GRM_G.secretValueOnLoadDelay = false;
        C_Timer.After(1, GRM.DelayForGuildInfoCallback);
        return
    else
        GRM_G.trackingTriggered = false;
        GRM.TrackingConfiguration(false);
    end
end

GRM_G.mainTagEvents = {
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

-- Method:          GRM.MessageHookControl()
-- What it Does:    Handles some communications issues with the chat so that the main tags can be hooked into and edited
-- Purpose:         Message editing of GRM tags
GRM.MessageHookControl = function()

    if not GRM_G.MainHookConfigured and IsInGuild() and GRM.S() then
        for chat_event in pairs(GRM_G.mainTagEvents) do
            ChatFrame_AddMessageEventFilter(chat_event, GRM.AddMainToChat);
        end
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", GRM.SetSystemMessageFilter);
        GRM_G.MainHookConfigured = true;
    end

end

-- Method:          GRM.SystemMessageHookControl()
-- What it Does:    Checks to ensure script modification happens at the end of the sequential table to ensure all addon compatibility
-- Purpose:         Quality of life - prevent frustration for other addon devs
GRM.SystemMessageHookControl = function()
    if (time() - GRMsyncGlobals.timeAtLogin) < 30 then
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", GRM.SetSystemMessageFilter);
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", GRM.SetSystemMessageFilter);
    end
end

-- Method:          GRM.LoadAddon()
-- What it Does:    Enables tracking of when a player joins the guild or leaves the guild. Also fires upon login.
-- Purpose:         Manage tracking guild info. No need if player is not in guild, or to reactivate when player joins guild.
GRM.LoadAddon = function()
    GeneralEventTracking:RegisterEvent("PLAYER_GUILD_UPDATE"); -- If player leaves or joins a guild, this should fire.
    GRM_G.SystemMessagesEnabled = IsListeningForMessageType("SYSTEM")
    if GRM_G.BuildVersion < 100000 then
        GeneralEventTracking:SetScript("OnEvent", function(_, event)
            if event == "PLAYER_GUILD_UPDATE" then
                C_Timer.After(10, function()
                    GRM.ManageGuildStatus();
                end);
            end
        end);

        ChatConfigFrame:HookScript("OnHide", function()
            GRM_G.SystemMessagesEnabled = IsListeningForMessageType("SYSTEM");
        end);
    else
        GeneralEventTracking:RegisterEvent("VIGNETTES_UPDATED");
        GeneralEventTracking:SetScript("OnEvent", function(_, event)
            if event == "PLAYER_GUILD_UPDATE" then
                C_Timer.After(10, function()
                    GRM.ManageGuildStatus();
                end);
                
            elseif event == "VIGNETTES_UPDATED" then -- Need to listen for enablign and disablingh of system messages to determine which handler to use.
                GRM_G.SystemMessagesEnabled = IsListeningForMessageType("SYSTEM");
            end
        end);
    end

    -- Speecial handler in case system messages disabled, so instead of filtering, we just listen
    SystemMessageChecking:RegisterEvent("CHAT_MSG_SYSTEM");
    SystemMessageChecking:SetScript("OnEvent", GRM.SystemMessageHandler);

    if GRM_G.BuildVersion < 40000 and GRM_G.BuildVersion >= 30000 then
        -- Achievements are broken in WotLK classic - so don't announce for modern versions or it'll duplicate
        C_ChatInfo.RegisterAddonMessagePrefix("GRMACHIEV");
        AchievementsChecking:RegisterEvent("CHAT_MSG_ADDON");
        AchievementsChecking:RegisterEvent("ACHIEVEMENT_EARNED");
        AchievementsChecking:SetScript("OnEvent", function(_, event, prefix, msg, channel, sender)
            if IsInGuild() then
                if event == "CHAT_MSG_ADDON" and prefix == "GRMACHIEV" and channel == "GUILD" and sender ~=
                    GRM_G.addonUser then
                    if GRM.S() and GRM.S().achievements then
                        GRM.AnnounceAchievement(sender, msg);
                    end
                elseif event == "ACHIEVEMENT_EARNED" and GRM.S() and GRM.S().achievements then
                    GRM.OnAchievementEarned(prefix)
                end
            end
        end);

    end

    -- Initialize chat tagging
    if IsInGuild() then
        GRM.MessageHookControl();
    end

    -- Quick Version Check
    if not GRM_G.VersionCheckRegistered then
        GRM.RegisterVersionCheck();
        C_ChatInfo.SendAddonMessage("GRMVER", GRM_G.Version .. "?" .. tostring(GRM_G.PatchDay), "GUILD");
        GRM_G.VersionCheckRegistered = true;
    end

    -- Modular load control
    GRM_G.GRMfunctionDisabled = false;

    -- Delay needs to be here to try to help prevent any initialization errors that might occur for some people.
    if not CommunitiesFrame then
        C_Timer.After(3, function()
            GRM.LoadRecursiveErrorCheck();
            GRM.ForceLoadAddon("Blizzard_Communities");
        end);
    else
        GRM.LoadRecursiveErrorCheck();
    end
end

-- Method:          GRM.LoadRecursiveErrorCheck()
-- What it Does:    Rechecks if a certain frame function is loaded.
-- Purpose:         For some reason some edge cases out there some clients load these very slow, and an addon can trigger before this is done.
GRM.LoadRecursiveErrorCheck = function()

    if not CommunitiesFrame then
        C_Timer.After(3, function()
            GRM.LoadRecursiveErrorCheck();
        end);
    else
        GRM.finalLoadSteps();
    end
end

-- Method:          GRM.finalLoadSteps()
-- What it Does:    Throttles loading information
-- Purpose:         Compartmentalizes and throttles loading details until the frames are loaded by the system so as to prevent attempts to hook into frames that do not yet exist
GRM.finalLoadSteps = function()
    -- Determine who is using the addon...
    -- 3 second dely to account for initialization of various variables. Safety cushion.
    C_Timer.After(3, GRM.RegisterGuildAddonUsers);

    -- Important to set this in case player logs in whilst in a group
    if IsInGroup() then
        GRM_G.InGroup = true;
    end

    -- Activate the GRM frames!
    GRM.InitiateMemberDetailFrame();
    GRM.GuildRoster();
    QueryGuildEventLog();

    C_Timer.After(1, function()
        GRM.TrackingConfiguration(false);
    end);

end

-- Method:          GRM.ReactivateAddon ()
-- What it Does:    If addon no longer needs to be enabled due to player not being in a guild, or leaving a guild, this slimmer reactivation protocol
--                  is necessary because it doesn't need to re-register frames like it would on the first activation upon logging in.
-- Purpose:         Resource efficiency.
GRM.ReactivateAddon = function()
    C_Timer.After(5, GRM.Util.RegisterGuildChatPermission);

    GRM_G.playerRankID = GRM.GetPlayerRankIDAtStart();
    GRM.SetGuildInfoDetails();
    QueryGuildEventLog();

    if not GRM.S() then
        GRM_AddonSettings_Save[GRM_G.guildName] = {};
        -- Load the Default Settings
        for i = 0, GRM_G.SettingsPages do
            GRM.SetDefaultAddonSettings(GRM_AddonSettings_Save[GRM_G.guildName], i);
        end
    end

    if not GRM_UI.GRM_RosterChangeLogFrame.GRM_RosterChangeLogFrameReScale then
        -- Let's set window scales now...
        GRM_UI.SetAllWindowScales(true);
    end

    if IsInGuild() then
        GRM.SetChatColoring();
        if GRM.IsHardcoreActive() then
            GRM_UI.VerifyIfHCChannelsEnabled();
        end

        -- Re-trigger the minimap
        GRM.MinimapGRM.GRM_MinimapButtonInit();
    end

    C_Timer.After(2, GRM.LoadAddon);
end

-- Method           GRM.ManageGuildStatus()
-- What it Does:    If player leaves or joins the guild, it deactivates/reactivates tracking - as well as re-checks guild to see if rejoining or new guild.
-- Purpose:         Efficiency in resource use to prevent unnecessary tracking of info if out of the guild.
GRM.ManageGuildStatus = function()
    if GRM_G.guildStatusChecked ~= true then
        GRM_G.timeDelayValue = time(); -- Prevents it from doing "IsInGuild()" too soon by resetting timer as server reaction is slow.
        if not IsInGuild() then
            local tempVal = IsInGuild();
            if not tempVal then
                -- DO nothing, this is just consuming to trigger initial query to server as sometimes API returns nil.
            end
        end
    end
    if GRM_G.timeDelayValue == 0 or (time() - GRM_G.timeDelayValue) >= 2 then -- Let's do a recheck on guild status to prevent unnecessary scanning.
        
        if IsInGuild() then
            if GRM_G.DelayedAtLeastOnce then
                if not GRM_G.currentlyTracking then
                    GRM.ReactivateAddon();
                end
                GRM_G.guildStatusChecked = false;
                return
            else
                GRM_G.DelayedAtLeastOnce = true;
                C_Timer.After(10, GRM.ManageGuildStatus);
                return
            end
        else
            -- Reset some values;
            if not GRM_G.GRMfunctionDisabled then
                GRM_G.GRMfunctionDisabled = true;
                GRMsyncGlobals.SyncOK = false;
                GRM_G.IndexOfLastLogEntry = 0;
                GRM_G.playerRankID = nil;
                GRM_G.OnFirstLoad = true;
                GRM_G.guildName = "";
                GRM_G.guildCreationDate = "";
                GRM_G.trackingTriggered = false;
                GRM_G.currentlyTracking = false;
                GRM_G.DelayedAtLeastOnce = true; -- Keeping it true as there does not need to be a delay at this point.
                GRM_G.guildRankNames = nil; -- reset guild rank names.
                GRMsyncGlobals.DatabaseLoaded = false;

                GRM.MinimapGRM.Hide();

                GRM_G.UI_Events:UnregisterEvent("GUILD_EVENT_LOG_UPDATE");
                if GRMsync.MessageTracking ~= nil then
                    GRMsync.MessageTracking:UnregisterAllEvents();
                end
                GRM.Scan.ResetTempLogs();
                GRMsync.ResetDefaultValuesOnSyncReEnable(); -- Need to reset sync algorithm too!
                GRM_UI.GRM_RosterChangeLogFrame:Hide();

                GRM_G.guildStatusChecked = false;
            end
        end               
    else
        GRM_G.guildStatusChecked = true;
        C_Timer.After(5, GRM.ManageGuildStatus); -- Recursively re-check on guild status trigger.
    end
end


-- Method:          GRM.DataLoadDelayProtection( bool , int )
-- What it Does:    It checks if the calendar and date info is available from the server yet and if not, it recursively reloads
-- Purpose:         To prevent certain errors due to the server returning this information slowly as of patch 8.1.5 for some reason.
GRM.DataLoadDelayProtection = function( isReady , count )
    isReady = isReady or false;
    count = count or 0;
    local countLimit = 25;

    if GRM.Time.GetCurrentCalendarTime().month and GRM.Time.GetCurrentCalendarTime().month ~= 0 then
        if IsInGuild() then
            if GetGuildInfo("PLAYER") ~= nil then -- Critical to be receiving data properly from the server...
                count=count+1;
                -- Need to pull guildName
                local guildName, _, _, server = GetGuildInfo("PLAYER");
                if not guildName or not server then
                    guildName, _, _, server = GetGuildInfo("PLAYER")
                end
                local timePassed = 0;
                if not server then
                    timePassed = time() - GRM_G.SessionTime;
                end
                if server or timePassed > 10 or count == countLimit then
                    isReady = true;
                end
                
                if isReady then
                    if server ~= nil then
                        GRM_G.guildName = guildName .. "-" .. string.gsub(string.gsub(server, "-", ""), "%s+", "");
                    else
                        GRM_G.guildName = guildName .. "-" .. GRM_G.realmName;
                    end
                end
            end
        else
            count = count + 1;
            if count == countLimit then
                isReady = true
            end
        end
    end

    if not isReady then
        C_Timer.After(0.5, function()
            GRM.DataLoadDelayProtection(isReady, count)
        end);
    else
        -- Secret Protections - Let's check
        print("Secret Check");
        GRM.Secrets.InitializeSecretCheck();
        GRM.LoadSettings();
    end
end;

-- Method:          GRM.SettingsLoadedFinishDataLoad( bool )
-- What it Does:    Compartmentalizes the OnLoad process of the addon so some things can be verified and pre-checked before continuing, like loading addon settings.
-- Purpose:         Prevent errors of course!
GRM.SettingsLoadedFinishDataLoad = function( isManual )
    -- Rerun this for the language changes...
    -- this will also build initial frames...
    local langIndex = GRM_G.LocalizedIndex;
    if GRM.S() then
        langIndex = GRM.S().selectedLang;
        GRM_G.MacroHotKey = GRM.S().macroHotKey;
    else
        GRM_G.MacroHotKey = "CTRL-SHIFT-K";
    end

    GRML.SetNewLanguage(langIndex, true, false);

    -- Restore debugLog since addonloaded
    GRM_G.DebugLog = GRM_DebugLog_Save;

    if IsInGuild() then

        GRM_G.playerRankID = GRM.GetPlayerRankIDAtStart();

        -- Let's set window scales now...
        GRM_UI.SetAllWindowScales(true);

        if GRM.IsHardcoreActive() then
            
            C_Timer.After (5, function()
                if GRM.S() then
                    GRM_UI.VerifyIfHCChannelsEnabled();
                end
            end);
        end

        GRM.GuildRoster(); -- Initial queries...
        QueryGuildEventLog();

        -- MISC Quality of Life Settings...
        -- Addon Compatibility Detection
        -- EPGP uses officer notes and is an incredibly popular addon. This now ensures auto-adding not will default to PUBLIC note rather than officer.
        if GRM.IsAddOnLoaded("epgp") and GRM.S().joinDateDestination ~= 3 then
            GRM.S().joinDateDestination = 2;
        end

        if not isManual then
            C_Timer.After(2, GRM.LoadAddon); -- Queries do not return info immediately, gives server a 2 second delay.
        end
    else
        GRM.ManageGuildStatus();
    end
end

-- Initialize the first frames as game is being loaded.
Initialization:RegisterEvent("ADDON_LOADED");
Initialization:SetScript("OnEvent", Config.ActivateAddon );

_G["GRM_ToggleOptionsWindow"] = GRM.MinimapGRM.MainWindowOpenLogic; -- Addon Compartment button above minimap (see .toc)