GRM_S = {};

GRM_G.SettingsPages = 17;
GRM_G.SettingsTabFocus = 0;

-- Method:          GRM_S.SetDefaultAddonSettings( object , int )
-- What it Does:    Establishes the default addon setttings for all of the options and some other misc. stored variables, like minimap position
-- Purpose:         Easy access to settings on a default reset.
GRM_S.SetDefaultAddonSettings = function(player, page)

    -- Misc needs a tab home
    player.nameFormat = 1;      -- 1 = Blizzard naming convention(only include if not server), 2 = Always include server, 3 = Always remove server

    if not player.removedMacroRules then
        player.removedMacroRules = {};
    end

    -- Page 0 = misc stuff unrelated to specific settings
    if page == 0 then
        player.showMouseoverRetail = true;
        player.showMouseoverOld = true;
        player.minimapPos = 345;

        if GRM_G.BuildVersion >= 100000 then    -- 10.0 DF increased size of minimap slightly
            player.minimapRad = 105;
        else
            player.minimapRad = 80;
        end

        player.customPos = false;
        player.macroToolCoordinates = {"", "", 0, 0};
        player.minimapCustomPos = {"", ""};
        player.CoreWindowPos = {"", "", 0, 0};
        player.SyncTrackerPOS = {"", "", 0, 0};
        player.RosterFramePOS = {"", "", 0, 0};
        player.disableMacroToolLogSpam = false;
        player.ignoreDeadNames = false;
        player.JDAuditToolFilter = false;
        player.JDAuditToolIgnoreProtected = false;

        -- GRM Roster
        player.showMains = true;
        player.showAlts = true;
        player.showMainTags = false;
        player.showAltTags = false;
        player.showRosterOffline = true;
        player.showRosterOptions = true;
        player.groupByMain = false;
        player.numRosterRows = 18;

        -- One time messaging
        player.banInfoReport = false;

        local rosterFrameDefault = 885;
        if GRM_G.BuildVersion >= 80000 then -- Mythic+ Size Diff
            rosterFrameDefault = rosterFrameDefault + 90;
        end

        player.UIScaling = {{600, 535, 1.0}, {400, 439, 1.0}, {1200, 515, 1.0}, {1100, 540, 1.0}, {875, 400, 1.0},
                            {rosterFrameDefault, 525, 1.0}};

        player.classicUIInformed = false;

        -- Messaging for save data being too much
        player.LogSizeWarning = { false , false , false , false };

        -- General Options Tab
    elseif page == 1 then
        player.viewOnLoad = true;
        player.onlyViewIfChanges = true;
        player.syncSettings = true;
        player.minimapEnabled = true;

        -- Minimap button type - 1 is custom default, but 2 is standard
        if LibStub and LibStub("LibDataBroker-1.1", true ) and LibStub("LibDBIcon-1.0", true) then
            player.minimapType = 1;
        else
            player.minimapType = 2;
        end

        player.twentyFourHrScale = GRM.Use24HrBasedOnDefaultLanguage();
        player.selectedLang = GRM_G.LocalizedIndex;
        player.selectedFont = 1;
        player.fontModifier = 0;
        player.tooltipSize = 0.9;
        player.dateFormat = 1;
        player.reportChannel = {};
        player.defaultTabSelection = {false, 1};
        player.syncCompatibilityMsg = false;

        -- Scan Options Tab
    elseif page == 2 then
        player.inactiveHours = 336;
        player.eventAdvanceDays = 14;
        player.scanDelay = 30;
        player.calendarAnnouncements = true;
        player.reportInactiveReturn = true;
        player.onlyAnnounceForMain = false;
        player.scanEnabled = true;
        player.levelReportMin = 10;
        player.levelFilters = {true, true, true, true, true, true, true, true, true, true, true};
        player.allAltRequirement = false; -- I want it off by default.
        player.recordLevelUp = true;
        player.AnnounceBdayOnLogin = true;
        player.bdayAnnounce = true;
        player.annivAnnounce = true;

        -- Sync Options Tab
    elseif page == 3 then
        player.syncEnabled = true;
        player.syncRank = GRM.G_Util.GetRankRestrictedDefaultRankIndex();
        player.syncChatEnabled = true;
        player.syncBanList = true;
        player.syncRankBanList = GRM.GetFirstOfficerRank();
        player.exportAllRanks = true;
        player.syncCustomNote = true;
        player.syncRankCustom = GRM.G_Util.GetRankRestrictedDefaultRankIndex();
        player.autoTriggerSync = true;
        player.syncDelay = 60;

        -- Officer Options Tab
    elseif page == 4 then
        player.addTimestampToNote = false;
        player.allowEventsToCalendar = true;
        player.joinDateDestination = 1;
        if GRM_G.BuildHasRestrictions then
            player.joinDateDestination = 3; -- Default to Custom Note
        end
        player.customTags = {"", ""};
        player.includeTag = true;
        player.addNotesToLeft = true;
        player.noteSetEnabled = true;
        if GRM_G.BuildHasRestrictions then
            player.noteSetEnabled = false;
        end
        player.globalDateFormat = 1;

        -- Backup Options Tab
    elseif page == 5 then

        -- Help Options Tab
    elseif page == 6 then

        -- UI Options Tab
    elseif page == 7 then

        player.showLevel = true;
        player.showLevelMaxOnly = false;
        player.showMythicRating = true;
        player.showFaction = true;

        -- No cross-faction guilds prior to Dragonflight expansion
        if GRM_G.BuildVersion < 100000 then
            player.showFaction = false;
        end
        player.useFade = false;

        -- No guild rep pre-Cataclysm expansion.
        if GRM_G.BuildVersion < 40000 then
            player.viewGuildRep = false;
        else
            player.viewGuildRep = true;
        end

        player.showBorders = false; -- Off by default
        player.showBDay = true;
        player.colorizeNames = true;
        player.colorizeClassicRosterNames = true;
        player.hideFramesInCombat = true;

        -- Log Options and Side Window
    elseif page == 8 then
        player.toLog = {};
        player.toChat = {};

        local s = "toLog";
        for i = 1, 2 do

            if i == 2 then
                s = "toChat";
            end

            player[s].joined = true;
            player[s].leveled = true;
            player[s].inactiveReturn = true;
            player[s].promotion = true;
            player[s].demotion = true;
            player[s].note = true;
            player[s].officerNote = true;
            player[s].customNote = true;
            player[s].nameChange = true;
            player[s].rankRename = true;
            player[s].eventAnnounce = true;
            player[s].left = true;
            player[s].recommend = true;
            player[s].banned = true;

            if GRM_G.HardcoreActive then
                if i == 1 then
                    player[s].death = true;
                else
                    player[s].death = false;
                end
            end

        end

        player.showLineNumbers = true;
        player.shiftClickRemove = true;
        player.autoFocusSearch = false;
        player.showTooltip = true;
        player.logFontSize = 0;
        player.logColor = { -- 15 total
        {0.5, 1.0, 0.0}, -- Joined
        {0.0, 0.44, 0.87}, -- Leveled
        {0.0, 1.0, 0.87}, -- Inactive Return
        {1.0, 0.914, 0.0}, -- Promotions
        {0.91, 0.388, 0.047}, -- Demotions
        {1.0, 0.6, 1.0}, -- Note
        {1.0, 0.094, 0.93}, -- Officer Note
        {0.24, 0.69, 0.49}, -- Custom Note
        {0.90, 0.82, 0.62}, -- Name Change
        {1, 1, 1}, -- Rank Rename
        {0.0, 0.8, 1.0}, -- Event Announce
        {0.5, 0.5, 0.5}, -- Left Guild
        {0.65, 0.19, 1.0}, -- Recommendations
        {1.0, 0.0, 0.0}, -- Banned Coloring
        {0.76, 0.0, 0.0} -- Death
        };

        -- Export Options
    elseif page == 9 then
        player.exportDelimiter = {true, ";"};
        player.specialCharRemoval = false;
        player.columnHeaders = false;
        player.ExportLevelRange = {1, 999}; -- 999 represents MaxLevel
        player.exportFilters = {};
        player.exportFilters.name = true;
        player.exportFilters.rank = true;
        player.exportFilters.level = true;
        player.exportFilters.class = true;
        player.exportFilters.race = true;
        player.exportFilters.sex = true;
        player.exportFilters.lastOnline = true;
        player.exportFilters.mainAlt = true;
        player.exportFilters.alts = true;
        player.exportFilters.joinDate = true;
        player.exportFilters.promoteDate = true;
        player.exportFilters.rankHist = true;
        player.exportFilters.bday = true;
        player.exportFilters.rep = true;
        player.exportFilters.note = true;
        player.exportFilters.oNote = true;
        player.exportFilters.cNote = true;
        player.exportFilters.mythicScore = true;
        player.exportFilters.faction = true;
        player.exportFilters.Realm = true;
        player.exportFilters.GUID = false;
        player.exportFilters.MainOrAlt = false;
        player.exportFilters.mainOnly = true;

        if GRM_G.HardcoreActive then
            player.exportHardcoreSort = 1;
        end

        if GRM_G.BuildVersion < 40000 then
            player.exportFilters.rep = false;
        end

        if GRM_G.BuildVersion < 80000 then
            player.exportFilters.mythicScore = false; 
        end

        -- Macro Tool Kick Options
    elseif page == 10 then
        player.kickRules = {};
        player.macroSyncKickEnabled = true;
        player.ignoreFilter = false;
        player.removedMacroRules.kickRules = {};
        player.macroHotKey = "CTRL-SHIFT-K";

        -- Macro Tool Promote Options
    elseif page == 11 then
        player.promoteRules = {};
        player.macroSyncPromoteEnabled = true;
        player.ignoreFilter = false;
        player.removedMacroRules.promoteRules = {};
        player.promoteOnlineOnly = false;
        player.macroHotKey = "CTRL-SHIFT-K";

        -- Macro Tool Demote Options
    elseif page == 12 then
        player.demoteRules = {};
        player.macroSyncDemoteEnabled = true;
        player.ignoreFilter = false;
        player.removedMacroRules.demoteRules = {};
        player.demoteOnlineOnly = false;
        player.macroHotKey = "CTRL-SHIFT-K";

        -- Audit
    elseif page == 13 then
        player.onlyShowIncomplete = false;
        player.unknownIsComplete = true;
        player.includeBirthdaysInAudit = false;

        -- Macro Tool Special Options
    elseif page == 14 then
        player.specialRules = {};
        player.macroSyncSpecialEnabled = true;
        player.ignoreFilter = false;
        player.removedMacroRules.specialRules = {};
        player.macroHotKey = "CTRL-SHIFT-K";

        -- Modules
    elseif page == 15 then

        -- GroupInfoModule
        player.GIModule = {};
        player.GIModule.enabled = true;
        player.GIModule.DisableGroupInfoTooltip = false;

        -- Classic Tab
    elseif page == 16 then
        -- HARDCORE MODE
        player.includeDeathTime = true;
        player.addDeathTag = true
        player.ignoreDeathChannel = false;

        -- Classic In General
        player.ProfReportUpdatesToChat = false;
        player.ProfRankAutoUpdate = false;
        player.ProfNoteDestination = 1;
        player.ProfFullyDisabled = false;
        if GRM_G.BuildHasRestrictions then
            player.ProfNoteDestination = 3;
        end
        if GRM_G.BuildVersion >= 100000 then
            player.ProfFullyDisabled = true;
        end

        -- Names Tab
    elseif page == 17 then
        player.showMainName = true;
        player.useMainTag = true;
        player.mainTagIndex = 2;
        player.mainTagColor = {};
        player.mainTagColor.r = 1;
        player.mainTagColor.g = 0;
        player.mainTagColor.b = 0;
        player.showNickname = false;
        player.showNicknameNotMain = true;
        player.ShowNicknameToAll = true;

    end

end

-- Method:          GRM_S.IsSettingsConfigured()
-- What it Does:    Returns true if the settings are an old format
-- Purpose:         Cleanup the settings check on login.
GRM_S.IsSettingsConfigured = function()
    local result = true;

    if (GRM.Util.TableLength(GRM_AddonSettings_Save) == 0 and #GRM_AddonSettings_Save == 0 and GRM_AddonSettings_Save[1] ==
        nil) then
        result = false;
    end

    return result;
end

-- Method:          GRM_S.RefreshAllSettings()
-- What it Does:    Resets the whole addon due to missing save settings data.
-- Purpose:         Adapt the new DB.
GRM_S.RefreshAllSettings = function()
    GRM_GuildMemberHistory_Save, GRM_PlayersThatLeftHistory_Save, GRM_AddonSettings_Save, GRM_LogReport_Save, GRM_CalendarAddQue_Save, GRM_GuildDataBackup_Save, GRM_Restore_Members, GRM_Restore_FormerMembers, GRM_Restore_Log, GRM_PlayerListOfAlts_Save, GRM_Alts, GRM_MinimapPosition = GRM.ClearPermData();
    GRM_AddonSettings_Save.VERSION = GRM_G.Version;
end

-- Method:          GRM_S.IsOldSettingsFormat()
-- What it Does:    Clears the old settings and rebuilds the database to new format.
-- Purpose:         Necessary for changes and backwards compatibility
GRM_S.IsOldSettingsFormat = function()
    local result = false;

    if (IsInGuild() and GRM_AddonSettings_Save[GRM_G.guildName]) then
        if not GRM_AddonSettings_Save.VERSION then
            GRM_AddonSettings_Save.VERSION = GRM_G.Version;
        end
        result = false;
    elseif not GRM_AddonSettings_Save.VERSION then
        return true;
    end

    return result;
end

-- Method:          GRM_S.UpdateOldSettingsFormat()
-- What it Does:    Updates the addon from the old settings style
-- Purpose:         The database has shifted over time and this allows backwards compatibility.
GRM_S.UpdateOldSettingsFormat = function()

    local playerV = "";
    local isFound = false;

    if GRM_AddonSettings_Save[1] or GRM_AddonSettings_Save.H then

        if GRM_AddonSettings_Save.H then
            if GRM_AddonSettings_Save.H.version ~= nil then
                GRM_AddonSettings_Save.H.version = nil;
            end
        end
        if GRM_AddonSettings_Save.A then
            if GRM_AddonSettings_Save.A.version ~= nil then
                GRM_AddonSettings_Save.A.version = nil;
            end
        end
        playerV = GRM_Patch.ManageOldSettingsDB();

    else

        -- 1.84 and on
        if GRM_AddonSettings_Save[GRM_G.addonUser] ~= nil and GRM_AddonSettings_Save[GRM_G.addonUser].version ~= nil then
            isFound = true;
            playerV = GRM_AddonSettings_Save[GRM_G.addonUser].version;
        end

        -- Build settings for first time.
        if not isFound then

            -- Need to check version of any player.
            for name in pairs(GRM_AddonSettings_Save) do
                if GRM_AddonSettings_Save[name].version ~= nil and GRM_AddonSettings_Save[name].version ~= GRM_G.Version then
                    playerV = GRM_AddonSettings_Save[name].version;
                    break
                end
            end

            if (playerV == "" or playerV == nil) and IsInGuild() then

                if not GRM_AddonSettings_Save[GRM_G.guildName] then

                    -- Add new guild
                    GRM_AddonSettings_Save[GRM_G.guildName] = {};

                    -- Load the Default Settings
                    for i = 0, GRM_G.SettingsPages do
                        GRM_S.SetDefaultAddonSettings(GRM_AddonSettings_Save[GRM_G.guildName], i);
                    end

                    -- Forcing core log window/options frame to load on the first load ever as well
                    GRM_G.ChangesFoundOnLoad = true;

                end

                if GRM_AddonSettings_Save[GRM_G.addonUser] then
                    GRM_G.playerOnlySettings = true;
                    GRM_AddonSettings_Save[GRM_G.guildName].syncSettings = false;
                    GRM_AddonSettings_Save[GRM_G.addonUser].syncSettings = false;
                end
            end
        end
    end

    -- Some error protection for some edge cases pre 1.978
    if not playerV or playerV == "" then
        playerV = GRM_G.Version;
    end

    return playerV;
end

-- Method:          GRM_S.LoadSettings( isManual )
-- What it Does:    On first time loading addon, it builds default addon settings. It checks for addon version change
--                  And, if there are any changes, they will be added into that logic block.
--                  And new setting can be tagged on.
-- Purpose:         Saving settings between gaming sessions. Also, this is built to provide backwards compatibility for future flexibility on feature adding, if necessary.
GRM_S.LoadSettings = function( isManual )
    local playerV = "";

    if not GRM_S.IsSettingsConfigured() then
        GRM_S.RefreshAllSettings();
    end
    -- This means we are in the old database that needs to be updated.
    -- Pre 1.84
    if GRM_S.IsOldSettingsFormat() then
        playerV = GRM_S.UpdateOldSettingsFormat();
    else
        playerV = GRM_AddonSettings_Save.VERSION;
        if IsInGuild() then

            if not GRM_AddonSettings_Save[GRM_G.guildName] then

                -- No settings established yet.
                GRM.Report("\n" ..
                               GRM.L("Configuring Guild Roster Manager for {name} for the first time.",
                        GRM.SlimName(GRM_G.guildName)));

                -- Add new guild
                GRM_AddonSettings_Save[GRM_G.guildName] = {};

                -- Load the Default Settings
                for i = 0, GRM_G.SettingsPages do
                    GRM_S.SetDefaultAddonSettings(GRM_AddonSettings_Save[GRM_G.guildName], i);
                end

                -- Forcing core log window/options frame to load on the first load ever as well
                GRM_G.ChangesFoundOnLoad = true;

            end

            if GRM_AddonSettings_Save[GRM_G.addonUser] then
                GRM_G.playerOnlySettings = true;
                GRM_AddonSettings_Save[GRM_G.guildName].syncSettings = false;
                GRM_AddonSettings_Save[GRM_G.addonUser].syncSettings = false;
            end

        end

    end
    if not isManual and playerV ~= nil and playerV ~= "" then
        -- PATCH FIXES
        if string.find(playerV, "R") == nil then
            playerV = "R" .. playerV;
        end
        GRM_Patch.SettingsCheck(tonumber(string.match(playerV, "R(.+)")));

    else
        -- No need to delay
        GRM_S.FinalSettingsConfigurations( isManual );
        GRM_G.currentlyPatching = false;
    end

end

-- Method:          GRM_S.GuildSpecificConfigurations()
-- What it Does:    Triggers configurations in a guild based on settings preferences.
-- Purpose:         Need to trigger if player joins a guild.
GRM_S.GuildSpecificConfigurations = function()
    if IsInGuild() then
        GRM_UI.CorePositionInit();
        GRM_UI.CoreToolPositionInit();
        -- GRM_UI.CoreSyncTrackerInit();
        -- Register window to save data to.
        GRM.SetReportWindow();
        GRM.RefreshMainTagHexCode();
        -- The Tag Headers
        GRM.SetJoinAndRejoinTags();
        -- General one-time configurations
        GRM.Scan.RefreshNumberOfHoursTilRecommend();
    end
end

-- Method:          GRM_S.FinalSettingsConfigurations( bool )
-- What it Does:    Calculates the final settings configurations
-- Purpose:         Compartmentalizes this so it can only be on call as needed.
GRM_S.FinalSettingsConfigurations = function( isManual )
    -- Verify Settings DB is good
    GRM_S.VerifyAddonSettings();

    -- In case of disconnect during some events that you may need to continue from.
    GRM.MiscCleanupOnLogin();
    -- Let's load that minimap button now too...
    GRM.MinimapGRM.GRM_MinimapButtonInit();
    -- One time processing, saves a bit of resources for an oft used string manipulation feature.

    if IsInGuild() then
        GRM_S.GuildSpecificConfigurations()
    else
        GRM.SetReportWindow();
    end

    -- Initialize the race Ids just once
    if GRM.Util.TableLength(GRM_G.raceIDEnum) == 0 then
        GRM.ConfigureEnums();
    end

    -- Re-setup macro
    if SocialsMicroButton then
        GRM.BuildGuildRosterHotkeyAndMacro(1, SocialsMicroButton);
    else
        GRM.BuildGuildRosterHotkeyAndMacro(1, GuildMicroButton);
    end

    -- For sync...
    GRMsyncGlobals.timeAtLogin = time(); -- Important for Sync Leader backend election algorithm.

    -- Classic Chat coloring
    -- Only initialize when in a guild or else it coluld overwrite ElvUI without a way to disable
    if IsInGuild() then
        GRM.SetChatColoring();
    end

    GRM_G.AddonIsFullyConfigured = true;
    GRM_API.Initialized = true;
    -- Settings loaded... carry on.
    GRM.SettingsLoadedFinishDataLoad( isManual );
end

-- Method:          GRM_S.VerifyAddonSettings()
-- What it Does:    Validates the settings by adding missing or removing redundant.
-- Purpose:         Cleanup the Save DB
GRM_S.VerifyAddonSettings = function()
    -- Build the template
    local player = {};
    for i = 0, GRM_G.SettingsPages do
        GRM_S.SetDefaultAddonSettings (player, i);
    end

    local Validate = function(saveSettings)
        local updateSetting = false;
        local saveSettingsType = "";
        local playerSettingsType = "";
        local length1 = 0;
        local length2 = 0;

        for settingName in pairs(player) do
            updateSetting = false;

            if saveSettings[settingName] == nil then
                updateSetting = true;
            else
                saveSettingsType = type(saveSettings[settingName]);
                playerSettingsType = type(player[settingName]);
                if saveSettingsType == "table" then
                    length1 = GRM.Util.TableLength(saveSettings[settingName]);
                end
                if playerSettingsType == "table" then
                    length2 = GRM.Util.TableLength(player[settingName]);
                end

                -- Ensure same type if not, wipe and set as default
                if saveSettingsType ~= playerSettingsType then
                    updateSetting = true;

                elseif saveSettingsType == "table" and length1 ~= length2 and length1 > 0 and length2 > 0 then
                    updateSetting = true;
                    -- Mismatched length tables - whoops!
                    for i = 1, length2 do
                        if saveSettings[settingName][i] ~= nil then
                            player[settingName][i] = saveSettings[settingName][i];
                        end
                    end
                end

            end
            if updateSetting then
                if type(player[settingName]) == "table" then
                    saveSettings[settingName] = GRM.Util.DeepCopyArray(player[settingName]);
                else
                    saveSettings[settingName] = player[settingName];
                end
                
            end

        end

        for settingName in pairs(saveSettings) do

            if player[settingName] == nil then
                saveSettings[settingName] = nil
            end

        end

        return saveSettings
    end

    if GRM_G.guildName ~= "" and GRM_G.guildName ~= nil and GRM_AddonSettings_Save[GRM_G.guildName] then
        GRM_AddonSettings_Save[GRM_G.guildName] = Validate(GRM_AddonSettings_Save[GRM_G.guildName]);
    end

    if GRM_AddonSettings_Save[GRM_G.addonUser] ~= nil then
        GRM_AddonSettings_Save[GRM_G.addonUser] = Validate(GRM_AddonSettings_Save[GRM_G.addonUser]);
    end

end

-- Method:          GRM_S.GetPageIndex()
-- What it Does:    Returns the index number to the corresponding frame
-- Purpose:         To coordinate in resetting default settings based on the specific frame the player is on.
GRM_S.GetPageIndex = function()
    local allFrames = {
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame] = 1,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame] = 2,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame] = 3,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame] = 4,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_UXOptionsFrame] = 7,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame] = 8,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ModulesFrame] = 15,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ClassicOptionsFrame] = 16,
        [GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame] = 17
    };
    local result;

    for x, y in pairs(allFrames) do
        if x:IsVisible() then
            result = y;
        end
    end
    return result;
end

-- Method:          GRM_S.ResetDefaultSettings( int )
-- What it Does:    Resets the OPTIONS to the default one for only the currently logged in player
-- Purpose:         Easy, quality of life for user in the options, for simple reset.
GRM_S.ResetDefaultSettings = function(pageIndex)
    local page = pageIndex or GRM_S.GetPageIndex();
    local needsRefresh = false;
    local resetAll = false;

    if IsShiftKeyDown() and IsControlKeyDown() then
        needsRefresh = true;
        resetAll = true;

        -- resetting ALL player data.
        local settings = GRM.S();
        for i = 0, GRM_G.SettingsPages do
            GRM_S.SetDefaultAddonSettings(settings, i);
        end

        GRM.Report(GRM.L("All GRM Settings have been set to default."));

    elseif page then

        needsRefresh = true;
        -- Reset only specific settings
        local settings = GRM.S();
        GRM_S.SetDefaultAddonSettings(settings, page);

        if page == 10 then
            GRM.Scan.RefreshNumberOfHoursTilRecommend();
        end

    end

    if needsRefresh then
        if (resetAll or page == 1) and GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
            GRML.SetNewLanguage(GRM_G.LocalizedIndex, false, true);
        end

        -- Check Permissions
        GRM.Global.UpdateGuildLeaderPermissions(false, true);

        -- Reset frames as needed
        if (resetAll or page < 9) and GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then -- General options
            GRM_UI.OptionsCore.RefreshOptionsUI();
        end

        if page == 15 then
            GRM_UI.ConfigureGroupInfoRules();
        end

        -- refresh the log as settings might be changed.
        if (resetAll or page == 8) and GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
            GRM_UI.RefreshLogExtraOptions();
            GRM_UI.RefreshLogColorOptions();
            GRM.ResetLogStringPoints(true);
            GRM.BuildLogComplete(true, false, true);
        end

        if (resetAll or page == 9) and GRM_UI.GRM_ExportLogBorderFrame and GRM_UI.GRM_ExportLogBorderFrame:IsVisible() then
            GRM.Export.SetExportTabHighlights();
        end

        if (resetAll or ((page > 9 and page < 13)) or page == 14) and GRM_UI.GRM_ToolCoreFrame:IsVisible() then
            GRM_UI.RefreshManagementTool();
        end

        if resetAll then
            GRM_UI.ResetScalingForAll();
        end

        if not (LibStub and LibStub("LibDataBroker-1.1", true) and LibStub("LibDBIcon-1.0", true)) then
            GRM.MinimapGRM.GRM_MinimapButtonInit();
        end

        GRM_UI.CorePositionInit();
        GRM_UI.CoreToolPositionInit();
        GRM.RefreshMainTagHexCode();
        GRM.SetReportWindow();
        GRM.Scan.RefreshNumberOfHoursTilRecommend();
    end

end
