GRM_S = {};

GRM_G.SettingsPages = GRM_ENUM.OPTIONS_TABS.TOTAL
GRM_G.SettingsTabFocus = 0;

-- Method:          GRM_S.SetDefaultAddonSettings( object , int )
-- What it Does:    Establishes the default addon setttings for all of the options and some other misc. stored variables, like minimap position
-- Purpose:         Easy access to settings on a default reset.
GRM_S.SetDefaultAddonSettings = function(setting, page)

    local TABS = GRM_ENUM.OPTIONS_TABS
    if not setting.removedMacroRules then
        setting.removedMacroRules = {};
    end

    -- =======================================================
    if page == TABS.MISC then
    -- =======================================================
        setting.showMouseoverRetail = true;
        setting.minimapPos = 345;
        setting.minimapRad = GRM_G.BuildVersion >= GRM_ENUM.BUILD.DF and 105 or 80;
        setting.customPos = false;
        setting.macroToolCoordinates = {"", "", 0, 0};
        setting.minimapCustomPos = {"", ""};
        setting.CoreWindowPos = {"", "", 0, 0};
        setting.SyncTrackerPOS = {"", "", 0, 0};
        setting.RosterFramePOS = {"", "", 0, 0};
        setting.disableMacroToolLogSpam = false;
        setting.ignoreDeadNames = false;
        setting.JDAuditToolFilter = false;
        setting.JDAuditToolIgnoreProtected = false;

        setting.showMains = true;
        setting.showAlts = true;
        setting.showMainTags = false;
        setting.showAltTags = false;
        setting.showRosterOffline = true;
        setting.showRosterOptions = true;
        setting.groupByMain = false;
        setting.numRosterRows = 18;
        setting.banInfoReport = false;
        setting.classicUIInformed = false;
        setting.LogSizeWarning = { false , false , false , false };

        local rosterFrameDefault = GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA and 975 or 885;
        setting.UIScaling = {{600, 535, 1.0}, {400, 439, 1.0}, {1200, 515, 1.0}, {1100, 540, 1.0}, {875, 400, 1.0}, {rosterFrameDefault, 525, 1.0}};

    -- =======================================================
    elseif page == TABS.GENERAL then
    -- =======================================================
        setting.viewOnLoad = true;
        setting.onlyViewIfChanges = true;
        setting.syncSettings = true;
        setting.minimapEnabled = true;
        setting.minimapType = (LibStub and LibStub("LibDataBroker-1.1", true) and LibStub("LibDBIcon-1.0", true)) and 1 or 2;
        setting.twentyFourHrScale = GRM.Use24HrBasedOnDefaultLanguage();
        setting.selectedLang = GRM_G.LocalizedIndex;
        setting.selectedFont = 1;
        setting.fontModifier = 0;
        setting.tooltipSize = 0.9;
        setting.dateFormat = 1;
        setting.reportChannel = {};
        setting.defaultTabSelection = {false, 1};
        setting.syncCompatibilityMsg = false;

    -- =======================================================
    elseif page == TABS.SCAN then
    -- =======================================================
        setting.inactiveHours = 336;
        setting.eventAdvanceDays = 14;
        setting.scanDelay = 30;
        setting.calendarAnnouncements = true;
        setting.reportInactiveReturn = true;
        setting.onlyAnnounceForMain = false;
        setting.scanEnabled = true;
        setting.levelReportMin = 10;
        setting.levelFilters = {true, true, true, true, true, true, true, true, true, true, true};
        setting.allAltRequirement = false; 
        setting.recordLevelUp = true;
        setting.AnnounceBdayOnLogin = true;
        setting.bdayAnnounce = true;
        setting.annivAnnounce = true;

    -- =======================================================
    elseif page == TABS.SYNC then
    -- =======================================================
        setting.syncEnabled = true;
        setting.syncRank = GRM.G_Util.GetRankRestrictedDefaultRankIndex();
        setting.syncChatEnabled = true;
        setting.syncBanList = true;
        setting.syncRankBanList = GRM.GetFirstOfficerRank();
        setting.exportAllRanks = true;
        setting.syncCustomNote = true;
        setting.syncRankCustom = GRM.G_Util.GetRankRestrictedDefaultRankIndex();
        setting.autoTriggerSync = true;
        setting.syncDelay = 60;

    -- =======================================================
    elseif page == TABS.OFFICER then
    -- =======================================================
        setting.addTimestampToNote = false;
        setting.allowEventsToCalendar = true;
        setting.joinDateDestination = GRM_G.BuildHasRestrictions and 3 or 1;
        setting.customTags = {"", ""};
        setting.includeTag = true;
        setting.addNotesToLeft = true;
        setting.noteSetEnabled = not GRM_G.BuildHasRestrictions;
        setting.globalDateFormat = 1;

    -- =======================================================
    elseif page == TABS.BACKUP then
    -- =======================================================

    -- =======================================================
    elseif page == TABS.HELP then
    -- =======================================================

    -- =======================================================
    elseif page == TABS.UI then
    -- =======================================================
        setting.showLevel = true;
        setting.showLevelMaxOnly = false;
        setting.showMythicRating = true;
        setting.showFaction = GRM_G.BuildVersion >= GRM_ENUM.BUILD.DF;
        setting.useFade = false;
        setting.viewGuildRep = GRM_G.BuildVersion >= GRM_ENUM.BUILD.CATA;
        setting.showBorders = true; 
        setting.showBDay = true;
        setting.colorizeNames = true;
        setting.colorizeClassicRosterNames = true;
        setting.hideFramesInCombat = true;

    -- =======================================================
    elseif page == TABS.LOG then
    -- =======================================================
        setting.toLog = { joined=true, leveled=true, inactiveReturn=true, promotion=true, demotion=true, note=true, officerNote=true, customNote=true, nameChange=true, rankRename=true, eventAnnounce=true, left=true, recommend=true, banned=true, death = GRM_G.HardcoreActive }
        setting.toChat = { joined=true, leveled=true, inactiveReturn=true, promotion=true, demotion=true, note=true, officerNote=true, customNote=true, nameChange=true, rankRename=true, eventAnnounce=true, left=true, recommend=true, banned=true, death = false }
        
        setting.showLineNumbers = true;
        setting.shiftClickRemove = true;
        setting.autoFocusSearch = false;
        setting.showTooltip = true;
        setting.logFontSize = 0;
        setting.logColor = { 
            {0.5, 1.0, 0.0}, {0.0, 0.44, 0.87}, {0.0, 1.0, 0.87}, {1.0, 0.914, 0.0}, {0.91, 0.388, 0.047}, 
            {1.0, 0.6, 1.0}, {1.0, 0.094, 0.93}, {0.24, 0.69, 0.49}, {0.90, 0.82, 0.62}, {1, 1, 1}, 
            {0.0, 0.8, 1.0}, {0.5, 0.5, 0.5}, {0.65, 0.19, 1.0}, {1.0, 0.0, 0.0}, {0.76, 0.0, 0.0} 
        };

    -- =======================================================
    elseif page == TABS.EXPORT then
    -- =======================================================
        setting.exportDelimiter = {true, ";"};
        setting.specialCharRemoval = false;
        setting.columnHeaders = false;
        setting.ExportLevelRange = {1, 999}; 
        setting.exportFilters = { name=true, rank=true, level=true, class=true, race=true, sex=true, lastOnline=true, mainAlt=true, alts=true, joinDate=true, promoteDate=true, rankHist=true, bday=true, rep=true, note=true, oNote=true, cNote=true, mythicScore=true, faction=true, Realm=true, GUID=false, MainOrAlt=false, mainOnly=true };
        
        if GRM_G.HardcoreActive then
            setting.exportHardcoreSort = 1
        end
        if GRM_G.BuildVersion < GRM_ENUM.BUILD.CATA then
            setting.exportFilters.rep = false
        end
        if GRM_G.BuildVersion < GRM_ENUM.BUILD.BFA then
            setting.exportFilters.mythicScore = false
        end


    -- =======================================================
    elseif page == TABS.KICK then
    -- =======================================================
        setting.kickRules = {};
        setting.macroSyncKickEnabled = true;
        setting.ignoreFilter = false;
        setting.removedMacroRules.kickRules = {};
        setting.macroHotKey = "CTRL-SHIFT-K";

    -- =======================================================
    elseif page == TABS.PROMOTE then
    -- =======================================================
        setting.promoteRules = {};
        setting.macroSyncPromoteEnabled = true;
        setting.ignoreFilter = false;
        setting.removedMacroRules.promoteRules = {};
        setting.promoteOnlineOnly = false;
        setting.macroHotKey = "CTRL-SHIFT-K";

    -- =======================================================
    elseif page == TABS.DEMOTE then
    -- =======================================================
        setting.demoteRules = {};
        setting.macroSyncDemoteEnabled = true;
        setting.ignoreFilter = false;
        setting.removedMacroRules.demoteRules = {};
        setting.demoteOnlineOnly = false;
        setting.macroHotKey = "CTRL-SHIFT-K";

    -- =======================================================
    elseif page == TABS.AUDIT then
    -- =======================================================
        setting.onlyShowIncomplete = false;
        setting.unknownIsComplete = true;
        setting.includeBirthdaysInAudit = false;

    -- =======================================================
    elseif page == TABS.SPECIAL then
    -- =======================================================
        setting.specialRules = {};
        setting.macroSyncSpecialEnabled = true;
        setting.ignoreFilter = false;
        setting.removedMacroRules.specialRules = {};
        setting.macroHotKey = "CTRL-SHIFT-K";

    -- =======================================================
    elseif page == TABS.MODULES then
    -- =======================================================
        setting.GIModule = { enabled=true, DisableGroupInfoTooltip=false };

    -- =======================================================
    elseif page == TABS.CLASSIC then
    -- =======================================================
        setting.includeDeathTime = true;
        setting.addDeathTag = true
        setting.ignoreDeathChannel = false;
        setting.ProfReportUpdatesToChat = false;
        setting.ProfRankAutoUpdate = false;
        setting.ProfNoteDestination = GRM_G.BuildHasRestrictions and 3 or 1;
        setting.ProfFullyDisabled = GRM_G.BuildVersion >= GRM_ENUM.BUILD.DF;

    -- =======================================================
    elseif page == TABS.NAMES then
    -- =======================================================
        setting.mainTagIndex = 1
        setting.altTagIndex = 1
        setting.nickTagIndex = 1
        setting.nameFormatMain = 2
        setting.nameFormatAlt = 4
        setting.nicknameFormatMain = 1
        setting.nicknameFormatAlt = 1
        setting.nnFormatUnassigned = 1
        setting.mainTagColor = { r = 1.0, g = 0.0, b = 0.0 }
        setting.nicknameTagColor = { r = 0.0, g = 0.8, b = 1.0 }

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
                    GRM_G.playerOnlySettings = false

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
        else
            GRM_G.playerOnlySettings = true
            GRM_AddonSettings_Save[GRM_G.addonUser] = {}
            for i = 0, GRM_G.SettingsPages do
                GRM_S.SetDefaultAddonSettings(GRM_AddonSettings_Save[GRM_G.addonUser], i);
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
        GRM_Chat.SetReportWindow();
        GRM_Name.RefreshTagHexCode();
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
        GRM_Chat.SetReportWindow();
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
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame] = 1,
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame] = 2,
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame] = 3,
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame] = 4,
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_UXOptionsFrame] = 7,
        [GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame] = 8,
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_ModulesFrame] = 15,
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_ClassicOptionsFrame] = 16,
        [GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame] = 17
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
    -- If a specific page isn't passed, use the actively focused tab!
    local page = pageIndex or GRM_S.GetPageIndex();
    local resetAll = IsShiftKeyDown() and IsControlKeyDown()
    local settings = GRM.S()

    if resetAll then
        -- Resetting ALL player data
        for i = 0, GRM_G.SettingsPages do
            GRM_S.SetDefaultAddonSettings(settings, i)
        end
        GRM.Report(GRM.L("All GRM Settings have been set to default."))
    elseif page then
        -- Reset only specific settings
        GRM_S.SetDefaultAddonSettings(settings, page)
        
        if page == GRM_ENUM.OPTIONS_TABS.KICK then
            GRM.Scan.RefreshNumberOfHoursTilRecommend()
        end
    end

    -- ==========================================
    -- UI REFRESH HANDLERS
    -- ==========================================
    local TABS = GRM_ENUM.OPTIONS_TABS

    -- Core Options UI Frame Refreshes
    if GRM_UI.GRM_CoreFrame:IsVisible() then
        if resetAll or page == TABS.GENERAL then
            GRML.SetNewLanguage(GRM_G.LocalizedIndex, false, true)
        end

        -- Refresh the Options UI for most tabs
        if resetAll or page < TABS.EXPORT or page == TABS.CLASSIC or page == TABS.NAMES then 
            GRM_UI.OptionsCore.RefreshOptionsUI()
        end
    end

    -- Name formatting
    if page == TABS.NAMES then
        GRM_UI.NamesTab.BuildNamesTab()
    end

    -- Global Re-checks
    GRM.Global.UpdateGuildLeaderPermissions(false, true)

    -- Specific Tab / Tool Refreshes
    if resetAll or page == TABS.MODULES then
        GRM_UI.ConfigureGroupInfoRules()
    end

    if (resetAll or page == TABS.LOG) and GRM_UI.GRM_CoreFrame.GRM_LogFrame:IsVisible() then
        GRM_UI.RefreshLogExtraOptions()
        GRM_UI.ColorPicker.RefreshLogColorOptions()
        GRM.Log.ResetLogStringPoints(true)
        GRM.Log.BuildLogComplete(true, false, true)
    end

    if (resetAll or page == TABS.EXPORT) and GRM_UI.GRM_ExportLogBorderFrame and GRM_UI.GRM_ExportLogBorderFrame:IsVisible() then
        GRM.Export.SetExportTabHighlights()
    end

    if (resetAll or (page >= TABS.KICK and page <= TABS.DEMOTE) or page == TABS.SPECIAL) and GRM_UI.GRM_ToolCoreFrame:IsVisible() then
        GRM_UI.RefreshManagementTool()
    end

    -- General Environment Resets
    if resetAll then
        GRM_UI.ResetScalingForAll()
        GRM.SlashCommandCenter()
    end
    
    if not (LibStub and LibStub("LibDataBroker-1.1", true) and LibStub("LibDBIcon-1.0", true)) then
        GRM.MinimapGRM.GRM_MinimapButtonInit()
    end

    GRM_UI.CorePositionInit()
    GRM_UI.CoreToolPositionInit()
    GRM_Name.RefreshTagHexCode()
    GRM_Chat.SetReportWindow()
    GRM.Scan.RefreshNumberOfHoursTilRecommend()
end
