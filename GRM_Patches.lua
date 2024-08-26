
---UPDATES AND BUG PATCHES
--- Total Patches: 131 - 2024 - 08 - 06

GRM_Patch = {};
local patchNeeded = false;
local DBGuildNames = {};
local startTime = 0;
local FID = 0;
local PID = 0;
local oldDB = false;
local delayTrigger = false;
local reported = false;     -- Update reported to chat
GRM_G.currentlyPatching = false;

-- Method:          GRM_Patch.SettingsCheck ( float )
-- What it Does:    Holds the patch logic for when people upgrade the addon
-- Purpose:         To keep the database healthy and corrected from dev design errors and unanticipated consequences of code.
GRM_Patch.SettingsCheck = function ( numericV , count , patch )
    GRM_G.currentlyPatching = true;
    local numActions = count or 0;
    local baseValue = patch or 0;
    local patchNum = 0;

    if FID == 0 then
        if UnitFactionGroup ( "PLAYER" ) == "Horde" then
            FID = 1;
        else
            FID = 2;
        end
    end

    if PID == 0 and GRM_AddonSettings_Save[FID] and GRM_AddonSettings_Save[FID][1] then

        for k = 2 , #GRM_AddonSettings_Save[FID] do
            if GRM_AddonSettings_Save[FID][k][1] == GRM_G.addonUser then
                PID = k;
                break;
            end
        end

    end

    -- Redundancy error for the massive settings DB overhaul, if the overhaul occurs but someone crashes in the middle of it, we want to ensure it doesn't wreck pre-overhaul
    if GRM_AddonSettings_Save[1] == nil and GRM_AddonSettings_Save["H"] == nil and numericV < 1.961 then
        numericV = 1.9605;
    end

    -- Purpose of this function...
    -- Updates are not that computationally intensive on their own, but I'd imagine if a player has not updated GRM is a very very long time the process might cause the game to hang for several seconds and possible
    -- timeout. This prevents that and makes it more obvious to the player what is occurring.
    local loopCheck = function ( actionValue )

        if not delayTrigger then
            numActions = numActions + 1;
            baseValue = actionValue;
        end

        -- Announce in chat that GRM is updating for patches... Only state this one time in the cycle.
        if not reported then
            reported = true;

            GRM.Report ( "|CFFFFD100" .. GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Applying update patches... one moment." ) );
            startTime = time();
            patchNeeded = true;
        end

        C_Timer.After ( 2 , function()
            GRM_Patch.SettingsCheck ( numericV , numActions , baseValue );
        end);
        return true;
    end

    patchNum = patchNum + 1; -- Iterate up each patch.
    -- Introduced Patch R1.092
    -- Alt tracking of the player - so it can auto-add the player's own alts to the guild info on use.
    if numericV < 1.092 and baseValue < 1.092 and #GRM_PlayerListOfAlts_Save == 0 then
        GRM_Patch.SetupAltTracking();
        if loopCheck ( 1.092 ) then         -- this can be checked again, so can hold previous value
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Introduced Patch R1.100
    -- Updating the version for ALL saved accounts.
    if numericV < 1.100 and baseValue < 1.100 then
        GRM_Patch.UpdateRankControlSettingDefault();
        if loopCheck ( 1.100 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Introduced Patch R1.111
    -- Added some more booleans to the options for future growth.
    if numericV < 1.111 and baseValue < 1.111 and #GRM_AddonSettings_Save[FID][2][2] == 26 then
        GRM_Patch.ExpandOptions();
        if loopCheck ( 1.111 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Intoduced Patch R1.122
    -- Adds an additional point of logic for "Unknown" on join date...
    if numericV < 1.122 and baseValue < 1.122 then
        GRM_Patch.IntroduceUnknown();
        if loopCheck ( 1.122 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Introduced Patch R1.125
    -- Bug fix... need to purge of repeats
    if numericV < 1.125 and baseValue < 1.125 and GRM_AddonSettings_Save[FID][2][2][24] == 0 then
        GRM_Patch.RemoveRepeats();
        GRM_Patch.EstablishThrottleSlider();
        if loopCheck ( 1.125 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Introduced Patch R.1.126
    -- Need some more options booleans
    if numericV < 1.126 and baseValue < 1.126 then
        GRM_Patch.CleanupSettings ( 30 );

        if #GRM_AddonSettings_Save[FID][2][2] == 30 then
            GRM_Patch.ExpandOptionsScalable( 10 , 30 , true );  -- Adding 10 boolean spots
        end
        -- Need some more options int placeholders for dropdown menus
        if #GRM_AddonSettings_Save[FID][2][2] == 40 then
            GRM_Patch.ExpandOptionsScalable( 5 , 40 , false );  -- Adding 5 boolean spots
        end

        -- Minimap Created!!!
        if GRM_AddonSettings_Save[FID][2][2][25] == 0 or GRM_AddonSettings_Save[FID][2][2][26] == 0 then
            GRM_Patch.SetMinimapValues();
        end

        if loopCheck ( 1.126 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Introduced R1.129
    -- Some erroneous promo date formats occurred due to a faulty previous update. These cleans them up.
    if numericV < 1.129 and baseValue < 1.129 then
        GRM_Patch.CleanupPromoDatesOrig();
        if loopCheck ( 1.129 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Introduced R1.130
    -- Sync addon settings should not be enabled by default.
    -- Greenwall users sync was getting slower and slower and slower... this resolves it.
    if numericV < 1.130 and baseValue < 1.130 then
        GRM_Patch.TurnOffDefaultSyncSettingsOption();
        GRM_Patch.ResetSyncThrottle();
        if loopCheck ( 1.130 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- R1.131
    -- Some messed up date formatting needs to be re-cleaned up due to failure to take into consideration month/date formating issues on guildInfo system message on creation date.
    if numericV < 1.131 and baseValue < 1.131 then
        GRM_Patch.ResetCreationDates();
        if loopCheck ( 1.131 ) then
            return;
        end
    end

    patchNum = patchNum + 1; -- Patch 10
    -- Some flaw in the left players I noticed... this cleans up old database issues.
    if numericV < 1.132 and baseValue < 1.132 then
        GRM_Patch.CleanupLeftPlayersDatabaseOfRepeats();
        if loopCheck ( 1.132 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Introduced in 1.133 - placed in the beginning to to critcal issue with database
    if numericV < 1.133 and baseValue < 1.133 then
        GRM_Patch.CleanupGuildNames();
        if loopCheck ( 1.133 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Sets the settings menu configuration and updates the auto backup arrays to include room for the autobackups...
    if numericV < 1.137 and baseValue < 1.137 then
        GRM_Patch.ConfigureAutoBackupSettings();
        if loopCheck ( 1.137 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Cleanup the guild backups feature. This will affect almost no one, but I had the methods in the code, this just protects some smarter coders who noticed it and utilized them.
    if numericV < 1.140 and baseValue < 1.140 then
        GRM_Patch.ResetAllBackupsPatch();
        if loopCheck ( 1.140 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Cleans up the Promo dates.
    if numericV < 1.142 and baseValue < 1.142 then
        GRM_Patch.CleanupPromoDates();
        GRM_Patch.ExpandOptionsType ( 3 , 3 , 45 );
        GRM_Patch.ModifyNewDefaultSetting ( 46 , { 1 , 0 , 0 } );
        if loopCheck ( 1.142 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.143 and baseValue < 1.143 then
        GRM_Patch.ModifyNewDefaultSetting ( 36 , false );
        GRM_Patch.ModifyNewDefaultSetting ( 37 , false );
        GRM_Patch.ModifyNewDefaultSetting ( 43 , GRM_G.LocalizedIndex );
        if loopCheck ( 1.143 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.144 and baseValue < 1.144 then
        GRM_Patch.FixBrokenLanguageIndex();
        if loopCheck ( 1.144 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1461 and baseValue < 1.1461 then
        GRM_Patch.SetProperFontIndex();
        GRM_Patch.ModifyNewDefaultSetting( 45 , 0 );
        if loopCheck ( 1.1461 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1471 and baseValue < 1.1471 then
        GRM_Patch.SetMiscConfiguration();
        if loopCheck ( 1.1471 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1480 and baseValue < 1.1480 then
        GRM_Patch.ExpandOptionsType ( 1 , 2 , 48 );
        GRM_Patch.ModifyNewDefaultSetting ( 49 , 2 );
        GRM_Patch.LanguageSettingModify();                          -- Adding custom note logic
        GRM_Patch.AddNewDefaultSetting ( 3 , true , true );         -- Print log report for custom note boolean
        GRM_Patch.AddNewDefaultSetting ( 13 , true , true );        -- Chat log report for custom note boolean
        GRM_Patch.SetProperRankRestrictions();
        if loopCheck ( 1.1480 ) then
            return;
        end
    end

    patchNum = patchNum + 1; -- Patch 20
    if numericV < 1.1482 and baseValue < 1.1482 then
        GRM_Patch.FixAltData();
        GRM_Patch.ExpandOptionsType ( 1 , 1 , 49 );
        if loopCheck ( 1.1482 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1490 and baseValue < 1.1490 then
        GRM_Patch.FixAltData();
        if loopCheck ( 1.1490 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1492 and baseValue < 1.1492 then
        GRM_Patch.RemoveAllAutoBackups();
        if loopCheck ( 1.1492 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1500 and baseValue < 1.1500 then
        GRM_Patch.CleanupAnniversaryEvents();
        GRM_Patch.RemoveTitlesEventDataAndUpdateBirthday();
        GRM_Patch.UpdateCalendarEventsDatabase();
        if loopCheck ( 1.1500 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1501 and baseValue < 1.1501 then
        GRM_Patch.RemoveTitlesEventDataAndUpdateBirthday();
        if loopCheck ( 1.1501 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1510 and baseValue < 1.1510 then
        GRM_Patch.ExpandOptionsType ( 1 , 1 , 50 );
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 51 );
        GRM_Patch.MatchLanguageTo24HrFormat();
        if loopCheck ( 1.1510 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.1530 and baseValue < 1.1530 then
        GRM_Patch.FixBanListNameGrammar();
        if loopCheck ( 1.1530 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.20 and baseValue < 1.20 then
        GRM_Patch.FixDoubleCopiesInLeftPLayers();
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 52 );
        GRM_Patch.ModifyNewDefaultSetting ( 53 , false );
        GRM_Patch.ModifyNewDefaultSetting ( 24 , 1 );
        GRM_Patch.AddPlayerMetaDataSlot ( 41 , "" );            -- Adding the GUID position...
        GRM_Patch.FixPlayerListOfAltsDatabase();
        if loopCheck ( 1.20 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.21 and baseValue < 1.21 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 53 );
        GRM_Patch.ModifyNewDefaultSetting ( 54 , false );
        if loopCheck ( 1.21 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.22 and baseValue < 1.22 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 54 );
        if loopCheck ( 1.22 ) then
            return;
        end
    end

    patchNum = patchNum + 1; -- patch 30
    if numericV < 1.25 and baseValue < 1.25 then
        GRM_Patch.ExpandOptionsType ( 2 , 2 , 55 );         -- adding 56 and 57
        GRM_Patch.ModifyNewDefaultSetting ( 56 , false );  -- 57 can be true
        if loopCheck ( 1.25 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.26 and baseValue < 1.26 then
        GRM_Patch.AddStreamViewMarker();
        GRM_Patch.PratCompatibilityCheck();
        if loopCheck ( 1.26 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.27 and baseValue < 1.27 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 57 );
        if loopCheck ( 1.27 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.28 and baseValue < 1.28 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 57 );         -- Needs to be repeated as unfortunately new characters this was not updated properly.
        GRM_Patch.ExpandOptionsType ( 2 , 2 , 58 );
        GRM_Patch.ModifyNoteSavedSettings();
        if loopCheck ( 1.28 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.29 and baseValue < 1.29 then
        GRM_Patch.RemoveRepeats();
        GRM_Patch.LogDatabaseRepair();
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 60 );             -- add a boolean
        GRM_Patch.ModifyNewDefaultSetting ( 61 , false );       -- Set all booleans to false (default adds it as true)
        GRM_Patch.ExpandOptionsType ( 4 , 1 , 61 );             -- Add string
        if loopCheck ( 1.29 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.30 and baseValue < 1.30 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 62 );             -- Add a boolean
        GRM_Patch.ModifyNewDefaultSetting ( 63 , false );       -- needs to be off by default
        GRM_Patch.ExpandOptionsType ( 3 , 1 , 63 );             -- for keeping the setpoints...
        GRM_Patch.ModifyNewDefaultSetting ( 64 , { "" , "" } ); -- needs to be off by default
        if loopCheck ( 1.30 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.31 and baseValue < 1.31 then
        -- need to repeat this check as I forgot to build it in the settings last time for new player alts...
        GRM_Patch.FixCustomMinimapPosition();                   -- need to fix a minimap bug I accidentally introduced...
        GRM_Patch.ExpandOptionsType ( 3 , 1 , 63 );             -- for keeping the setpoints...
        GRM_Patch.ModifyNewDefaultSetting ( 64 , { "" , "" } ); -- needs to be off by default
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 64 );             -- Add boolean for main tag controls
        GRM_Patch.ModifyNewDefaultSetting ( 65 , false );       -- put them off by default.
        if loopCheck ( 1.31 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.32 and baseValue < 1.32 then
        GRM_Patch.ConvertLeaderNoteControlFormatToGuildInfo();  -- Formatting the guild controls to be in the player note window...
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 65 );             -- Add boolean for leader purge controls
        GRM_Patch.ModifyNewDefaultSetting ( 66 , false );       -- put them off by default.
        if loopCheck ( 1.32 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.33 and baseValue < 1.33 then
        GRM_Patch.ModifyNewDefaultSetting ( 53 , true );            -- set the guild reputation visual to true
        GRM_Patch.ModifyNewDefaultSetting ( 17 , true );            -- Sets it by default to make sure only "mains" are announced as a bday approaches, to avoid event chat spam.
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 66 );                 -- Add boolean for showing birthday
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 67 );                 -- Add boolean for allowing birthday sync
        GRM_Patch.ConvertAndModifyAnniversaryStorageFormat();       -- Modify the way events are stored and changed!
        GRM_Patch.ModifyPlayerMetadata ( 22 , { { 0 , 0 , 0 } , false , "" , 0 } , true , 2 ); -- Modify member record details for birthday, resets it to base value
        if loopCheck ( 1.33 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.34 and baseValue < 1.34 then
        GRM_Patch.EventDatabaseIntegrityCheckAndRebuild();
        if loopCheck ( 1.34 ) then
            return;
        end
    end

    -- patch 40
    patchNum = patchNum + 1;
    if numericV < 1.35 and baseValue < 1.35 then
        GRM_Patch.AltListRepeatAndSelfCleanup();
        GRM_Patch.FixEventCalendarAdvanceScanTimeFrame();
        if loopCheck ( 1.35 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.39 and baseValue < 1.39 then
        GRM_Patch.ModifyNewDefaultSetting ( 55 , true );                                                        -- Ensures the setting to only announce returning from inactivity if ALL alts meet the criteria.
        GRM_Patch.ModifyNewDefaultSetting ( 56 , true );                                                        -- Record leveling data
        GRM_Patch.ModifyNewDefaultSetting ( 47 , { true , true , true , true , true , true , true , true } );   -- Level filtering options
        GRM_Patch.CleanupErroneousSlashesInBanNames();                                                          -- Custom names from ban list cleaned up a little.
        GRM_Patch.AddBanSlotIndex();
        if loopCheck ( 1.39 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.40 and baseValue < 1.40 then
        GRM_Patch.AddBanSlotIndex();
        if loopCheck ( 1.40 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.41 and baseValue < 1.41 then
        GRM_Patch.ModifyNewDefaultSetting ( 66 , false );                -- Auto Focus the search bar.
        if loopCheck ( 1.41 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.42 and baseValue < 1.42 then
        GRM_Patch.FixUnknownPromoShowing();
        if loopCheck ( 1.42 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.43 and baseValue < 1.43 then
        GRM_Patch.ConvertEmptyGUID();
        GRM_Patch.FixLeftPlayersClassToUppercase();
        GRM_Patch.AddPlayerMetaDataSlot ( 42 , false );            -- Adding the ban flag and is currently no longer on server position...
        GRM_Patch.BuildGUIDProfilesForAllNoLongerInGuild();
        if loopCheck ( 1.43 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.44 and baseValue < 1.44 then
        GRM_Patch.FixLogOfNilEntries();
        if loopCheck ( 1.44 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.45 and baseValue < 1.45 then
        GRM_Patch.FixBanData();
        GRM_Patch.FixAltListsDatabaseWide();
        GRM_Patch.ModifyPlayerMetadata ( 37 , {} , false );
        if loopCheck ( 1.45 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.50 and baseValue < 1.50 then
        GRM_Patch.IntegrityCheckAndFixBdayAndAnniversaryEvents();
        GRM_Patch.ModifyNewDefaultSetting ( 19 , true );                                        -- Needs to be reset to only sync with players with current version due to overhaul
        GRM_Patch.ModifyNewDefaultSetting ( 24 , 1 );                                           -- Due to the changes in sync, resetting people back to defautl 100% as some are killing themselves too low lol
        GRM_Patch.SortGuildRosterDeepArray();
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanUpAltLists , true , false , true );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.RemoveUnnecessaryHours , true , true , false );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupPromoDateSyncErrorForRejoins , true , true , false );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupPromoJoinDateOriginalTemplateDates , true , true , false );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupBirthdayRepeats , true , false , true );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupBanFormat , true , true , false );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.SlimBanReason , true , true , false );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupRemovedAlts , true , true , true );
        GRM_Patch.FinalAltListCleanup()
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupCustomNoteError , true , true , false );
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupJoinAndPromosSetUnknownError , true , true , false );
        if loopCheck ( 1.50 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.51 and baseValue < 1.51 then
        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupPromoDateSituation , true , true , false );
        if loopCheck ( 1.51 ) then
            return;
        end
    end

    -- patch 50
    patchNum = patchNum + 1;
    if numericV < 1.53 and baseValue < 1.53 then
        GRM_Patch.GuildDataDatabaseWideEdit ( GRM_Patch.CleanupJoinDateError );
        if loopCheck ( 1.53 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.56 and baseValue < 1.56 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 68 );                 -- Add boolean for checkbox for JD Audit tool
        GRM_Patch.ModifyNewDefaultSetting ( 69 , false );
        if loopCheck ( 1.56 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.57 and baseValue < 1.57 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 69 );                 -- Add boolean for checkbox for the log tooltip enablement
        if loopCheck ( 1.57 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.59 and baseValue < 1.59 then
        DeleteMacro("GRM_Roster")                                   -- Deleting the macro to rebuild it in general.
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 70 );                 -- Add boolean to enable or disable the GRM window on the old roster.
        GRM_Patch.ModifyNewDefaultSetting ( 71 , false );
        if loopCheck ( 1.59 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.61 and baseValue < 1.61 then
        GRM_Patch.RemoveOneAutoAndOneManualBackup();
        if loopCheck ( 1.61 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.63 and baseValue < 1.63 then
        GRM_Patch.ExpandOptionsType ( 3 , 1 , 71 );                             -- for keeping the setpoints of GRM window...
        GRM_Patch.ModifyNewDefaultSetting ( 72 , { "" , "" , 0 , 0 } );         -- Center position default
        GRM_Patch.AddPlayerMetaDataSlot ( 43 , false );                         -- Adding the position to have an "unknown" option in regards to bdays
        if loopCheck ( 1.63 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.64 and baseValue < 1.64 then
        GRM_Patch.ExpandOptionsType ( 4 , 1 , 72 );
        if loopCheck ( 1.64 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.66 and baseValue < 1.66 then
        GRM_Patch.ModifyNewDefaultSetting ( 48 , { "" , "" } );
        if loopCheck ( 1.66 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.67 and baseValue < 1.67 then
        GRM_Patch.ExpandOptionsType ( 3 , 1 , 73 );                             -- for keeping the setpoints of GRM window...
        GRM_Patch.ModifyNewDefaultSetting ( 74 , { "" , "" , 0 , 0 } );         -- Center position default
        GRM_Patch.ExpandOptionsType ( 3 , 1 , 74 );                             -- Adding slots 75 for storing the names and rules for kick/promote/demote tool
        GRM_Patch.AddPlayerMetaDataSlot ( 44 , false );                         -- Rule if player rules should be ignored.
        GRM_Patch.ModifyNewDefaultSetting ( 10 , true );                        -- Needs to be done before the conversion because I WANT players to use this feature
        GRM_Patch.ConvertRecommendedKickDateToRule ( 75 );                      -- Converts the old month date to the new feature
        GRM_Patch.ExpandOptionsType ( 3 , 1 , 75 );                             -- Adding slot 76 for the GRM tool safe list to only show players where actions were ignored
        if loopCheck ( 1.67 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.69 and baseValue < 1.69 and GRM_G.BuildVersion < 80000 then
        GRM_Patch.FixClassIncompatibilityBuild();
        if loopCheck ( 1.69 ) then
            return;
        end
    end

    -- patch 60
    patchNum = patchNum + 1;
    if numericV < 1.70 and baseValue < 1.70 then
        if GRM_G.BuildVersion < 80000 then
            GRM_Patch.RemoveMacroInClassic();
        end

        if GRM_G.BuildVersion < 40000 then
            GRM_Patch.ModifyNewDefaultSetting ( 53 , false );
        end

        GRM_Patch.PlayerMetaDataDatabaseWideEdit ( GRM_Patch.CleanupPromotionDateMouseOverError , true , true , false );
        GRM_Patch.FixMonthDateRecommendationError();
        GRM_Patch.ClearExtraBackups();
        if loopCheck ( 1.70 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.73 and baseValue < 1.73 then
        GRM_Patch.ModifyNewDefaultSetting ( 10 , true );            -- Mouseover control checkbox on whether to show the tooltip or not.
        if loopCheck ( 1.73 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.74 and baseValue < 1.74 then
        GRM_Patch.ModifyNewDefaultSetting ( 9 , true );            -- Colorcode Names in Chat
        if loopCheck ( 1.74 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.75 and baseValue < 1.75 then
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 76 );                 -- Add boolean for checkbox to enable or disable the !note feature
        if loopCheck ( 1.75 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.76 and baseValue < 1.76 then
        GRM_Patch.ExpandOptionsType ( 1 , 1 , 77 );                 -- Log specific font size modifier - default 100% size = 0;
        GRM_Patch.ModifyNewDefaultSetting ( 78 , 0 );
        if loopCheck ( 1.76 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.77 and baseValue < 1.77 then
        GRM_Patch.ExpandOptionsType ( 3 , 2 , 78 );                 -- Export delimiter selection and export details
        GRM_Patch.ModifyNewDefaultSetting ( 79 , { true , ";" } );
        if GRM_G.BuildVersion < 40000 then
            GRM_Patch.ModifyNewDefaultSetting ( 80 , { true , true , true , true , true , true , true , true , true , false , true , true , true , true } );     -- Export filters with Guild rep disabled
        else
            GRM_Patch.ModifyNewDefaultSetting ( 80 , { true , true , true , true , true , true , true , true , true , true , true , true , true , true } );     -- Export filters
        end
        GRM_Patch.ExpandOptionsType ( 2 , 1 , 80 );                 -- Auto include export headers
        GRM_Patch.ModifyNewDefaultSetting ( 81 , false );           -- Don't keep it ON as default
        if loopCheck ( 1.77 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.80 and baseValue < 1.80 then
        GRM_Patch.ExpandOptionsType ( 3 , 1 , 81 );
        GRM_Patch.ModifyNewDefaultSetting ( 82 , { 1.0 , 1.0 , 1.0 , 1.0 , 1.0 } );     -- Adding Scaler controls to the addon settings.
        if loopCheck ( 1.80 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.801 and baseValue < 1.801 then
        GRM_Patch.AddPlayerMetaDataSlot ( 45 , "" );                         -- Adding the position to have an "unknown" option in regards to bdays
        GRM_Patch.AddPlayerMetaDataSlot ( 46 , 1 );
        if loopCheck ( 1.801 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.81 and baseValue < 1.81 then
        GRM_Patch.FixOptionsSetting ( 82 , { 1.0 , 1.0 , 1.0 , 1.0 , 1.0 } , GRM_Patch.FixScalingOption );
        if loopCheck ( 1.81 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.812 and baseValue < 1.812 then
        if GRM_G.BuildVersion < 40000 then
            GRM_Patch.FixOptionsSetting ( 80 , { true , true , true , true , true , true , true , true , true , false , true , true , true , true , true , true } , GRM_Patch.ExpandExportFilters );
        else
            GRM_Patch.FixOptionsSetting ( 80 , { true , true , true , true , true , true , true , true , true , true , true , true , true , true , true , true } , GRM_Patch.ExpandExportFilters );
        end

        if loopCheck ( 1.812 ) then
            return;
        end
    end

    -- patch 70
    patchNum = patchNum + 1;
    if numericV < 1.82 and baseValue < 1.82 then
        GRM_Patch.FixOptionsSetting ( 6 , 20 , GRM_Patch.UpdateMinimumScanTime );       -- New default setting to max 20 seconds
        if loopCheck ( 1.82 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.831 and baseValue < 1.831 then
        GRM_Patch.FixDoubleCopiesInCurrentGuilds(); -- Due to an error reported... this was likely due to a bug that existed for a couple of hours before I noticed, but a couple hundred people had downloaded it... it was still somewhat edge case but it opened the door. Well, someone won the lottery!
        GRM_Patch.FixDoubleCopiesInLeftPLayers();   -- Prob not necessary, but need to cover all my bases here on this one...
        GRM_Patch.FixDoubleCopiesInBackup();        -- Same as above.
        GRM_Patch.RealignDatabaseDueToMisSort();    -- Due to a faulty insert that I created in 1.82 /sigh

        if GRM_G.BuildVersion < 80000 then
            GRM_Patch.ModifyNewDefaultSetting ( 71 , true );        -- needs to fix mouseover In Classic. Might have been forced disabled on accident.
        end

        if loopCheck ( 1.831 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Not an actual patch, but I want to force this rebuild to be split up
    if numericV < 1.832 and baseValue < 1.832 then
        if GRM_Patch.IsAnySettingsTooLow() then
            for i = 1 , #GRM_AddonSettings_Save do
                for j = 2 , #GRM_AddonSettings_Save[i] do
                    GRM_AddonSettings_Save[i][j][2][1] = "8.2.5R1.76";  -- Trigger the setting to reload for all.
                end
            end;

            numericV = 1.76;
            loopCheck ( 1.76 );
            return;
        end

        GRM_Patch.FixAltGroupings();

        if loopCheck ( 1.832 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Additional Database Rebuilding!
    if numericV < 1.833 and baseValue < 1.833 then
        -- Update the database now!!!
        GRM_Patch.ConvertAddonSettings();
        GRM_Patch.ConvertListOfAddonAlts();
        GRM_Patch.ConvertMiscToNewDB();
        GRM_Patch.ConvertBackupDB();

        if loopCheck ( 1.833 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Additional Database Rebuilding!
    if numericV < 1.834 and baseValue < 1.834 then
        GRM_Patch.ConvertLogDB();
        GRM_Patch.ConvertCalenderDB();

        if loopCheck ( 1.834 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- Additional DB Rebuilding
    -- Additional Database Rebuilding!
    if numericV < 1.835 and baseValue < 1.835 then
        GRM_Patch.FixUnremovedData();
        GRM_GuildMemberHistory_Save = GRM_Patch.ConvertPlayerMetaDataDB ( GRM_GuildMemberHistory_Save , 1 );
        GRM_PlayersThatLeftHistory_Save = GRM_Patch.ConvertPlayerMetaDataDB ( GRM_PlayersThatLeftHistory_Save , 2 );

        if loopCheck ( 1.835 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    -- For those coming off the beta...
    if numericV == 1.84 then
        GRM_Patch.FixNameChangePreReleaseBug();
    end

    if numericV < 1.865 and baseValue < 1.865 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.AddVerifiedPromotionDatesToHistory , true , true , false );
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.updateKickRules );
        GRM_Patch.ModifyPlayerSetting ( "promoteRules" , {} );
        GRM_Patch.ModifyPlayerSetting ( "demoteRules" , {} );
        GRM_Patch.ModifyPlayerSetting ( "allAltsApplyToKick" , nil );

        if loopCheck ( 1.865 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.87 and baseValue < 1.87 then
        GRM_Patch.AddPlayerSetting ( "colorizeClassicRosterNames" , true );

        if loopCheck ( 1.87 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.88 and baseValue < 1.88 then
        GRM_Patch.ModifyPlayerSetting ( "exportFilters" , nil , "class" );
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , nil , "allAltsApplyToKick" );
        GRM_Patch.ModifyMemberData ( GRM_Patch.fixAltGroups , true , false , true );
        GRM_Patch.FixManualBackupsFromDBLoad();
        GRM_Patch.AddGroupInfoModuleSettings();
        GRM_Patch.AddPlayerSetting ( "useFullName" , false );
        GRM_Patch.AddTextColoringValues();
        GRM_Patch.ModifyPlayerSetting ( "reportChannel" , GRM_Patch.ModifyPlayerChannelToMulti , nil );

        if loopCheck ( 1.88 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.89 and baseValue < 1.89 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.RemoveInvalidIndex , true , true , false );
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixMainTimestampError , true , true , false );
        GRM_Patch.ModifyPlayerSetting ( "exportFilters" , GRM_Patch.AddExportOptions );
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.AddKickRule );
        GRM_Patch.AddPlayerSetting ( "defaultTabSelection" , { false , 1 } );

        if GRM_G.BuildVersion < 20000 then
            SetCVar("chatClassColorOverride" , 0 );     -- This will get overridden if needed
        end

        if loopCheck ( 1.89 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.90 and baseValue < 1.90 then
        GRM_Patch.AddPlayerSetting ( "syncDelay" , 60 );
        GRM_Patch.AddPlayerSetting ( "autoTriggerSync" , true );
        GRM_Patch.AddPlayerSetting ( "syncCompatibilityMsg" , true );

        if loopCheck ( 1.90 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.91 and baseValue < 1.91 then
        GRM_Patch.ModifyPlayerSetting ( "levelReportMin" , GRM_Patch.AdjustLevelCapDueToSquish );

        if loopCheck ( 1.91 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.912 and baseValue < 1.912 then
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.AddKickRuleOperator );

        if loopCheck ( 1.912 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.915 and baseValue < 1.915 then
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.AddRulesValue );
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.ModifyKickRuleMaxLevel );
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.ModifyKickRuleLogic );
        GRM_Patch.AddPlayerSetting ( "disableMacroToolLogSpam" , false );
        if loopCheck ( 1.915 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.916 and baseValue < 1.916 then
        GRM_Patch.FixLogChangeRankEntries();

        if loopCheck ( 1.916 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.917 and baseValue < 1.917 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.fixAltGroups , true , false , true );

        if loopCheck ( 1.917 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.918 and baseValue < 1.918 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixMemberRemovePlayerData , true , true , false );   -- Clear these out - can I remove this feature?
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixRankHistoryEpochDates , true , true , false );
        GRM_Patch.AddMemberMetaData ( "recommendToDemote" , false );
        GRM_Patch.AddMemberMetaData ( "recommendToPromote" , false );

        if loopCheck ( 1.918 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.921 and baseValue < 1.921 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixRankHistory , true , true , false );
        GRM_Patch.ModifyMemberData ( GRM_Patch.UpdateSafeListValue , true , true , false );

        if loopCheck ( 1.921 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.925 and baseValue < 1.925 then
        GRM_Patch.ModifyGuildValue ( GRM_Patch.PurgeGuildRankNamesOldFormat );

        if loopCheck ( 1.925 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.926 and baseValue < 1.926 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixRankHistory , true , true , false );
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixVerifiedDatesForRejoins , true , true , false );  -- Re-fixing
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixRankHistoryEpochDates , true , true , false );
        GRM_Patch.ModifyMemberData ( GRM_Patch.CleanupSafeLists , true , true , false );

        if loopCheck ( 1.926 ) then
            return;
        end
    end

    -- patch 90
    patchNum = patchNum + 1;
    if numericV < 1.92995 and baseValue < 1.92995 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.fixAltGroups , true , false , true ); -- Long standing bug - cleanup groups
        GRM_Patch.VerifyMacroRuleIntegrity();
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.AddRulesValue );
        GRM_Patch.ModifyPlayerSetting ( "promoteRules" , GRM_Patch.AddRulesValue );
        GRM_Patch.ModifyPlayerSetting ( "demoteRules" , GRM_Patch.AddRulesValue );

        if loopCheck ( 1.92995 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.92996 and baseValue < 1.92996 then
        -- Quick Data Integrity Check
        GRM_Patch.GuildDataIntegrityCheck();
        GRM_Patch.ConfigureNewAltGroups();
        GRM_Patch.AddMemberMetaData ( "altGroup" , "" );
        GRM_Patch.AddMemberMetaData ( "altGroupModified" , 0 );
        GRM_Patch.AddMemberMetaData ( "mainAtTimeOfLeaving" , {} );
        GRM_Patch.AddMemberMetaData ( "altsAtTimeOfLeaving" , {} );
        GRM_Patch.BuildNewAltLists();

        if loopCheck ( 1.92996 ) then
            return;
        end
    end

    patchNum = patchNum + 1;
    if numericV < 1.92997 and baseValue < 1.92997 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.UpdateUnknownRankFormat , false , true , false );
        GRM_Patch.ModifyMemberData ( GRM_Patch.FixUnknownBirthdayBug , true , true , true );
        GRM_Patch.ModifyMemberData ( GRM_Patch.ConvertRankHistoryToRanks , true , true , false ); -- Only modifying current

        if loopCheck ( 1.92997 ) then
            return;
        end
    end

    -- 93
    patchNum = patchNum + 1;
    if numericV < 1.92998 and baseValue < 1.92998 then
        GRM_Patch.ModifyPlayerSetting ( "kickRules" , GRM_Patch.ConfigureRuleIndexAndEditTime );
        GRM_Patch.ModifyPlayerSetting ( "promoteRules" , GRM_Patch.ConfigureRuleIndexAndEditTime );
        GRM_Patch.ModifyPlayerSetting ( "demoteRules" , GRM_Patch.ConfigureRuleIndexAndEditTime );
        GRM_Patch.AddPlayerSetting ( nil , nil , GRM_Patch.AddRemovedRules );

        if loopCheck ( 1.92998 ) then
            return;
        end
    end

    -- Patch 94
    patchNum = patchNum + 1;
    if numericV < 1.92999 and baseValue < 1.92999 then
        GRM_Patch.ModifyMemberData ( GRM_Patch.ConvertJoinHistory , true , true , false ); -- Only modifying current
        GRM_Patch.ModifyMemberData ( GRM_Patch.RemoveOldAltLists , true , true , false );           -- some time after this patch
        GRM_Patch.ModifyPlayerSetting ( "syncSameVersion" ,  true );                                -- Due to enormous sync changes, this needs to be enabled to prevent possible problems.
        GRM_Patch.AddPlayerSetting ( "AnnounceBdayOnLogin" , true );                                -- New setting to control whether to announce to guild chat if it is the player's bday
        GRM_Patch.AddPlayerSetting ( "ignoreDeadNames" , false );                                   -- New setting regarding tracking player dead names
        GRM_Patch.AddPlayerSetting ( "macroSyncKickEnabled" , true );                                -- New setting macro sync rules
        GRM_Patch.AddPlayerSetting ( "macroSyncPromoteEnabled" , true );                             -- Same --
        GRM_Patch.AddPlayerSetting ( "macroSyncDemoteEnabled" , true );                              -- Same --

        if loopCheck ( 1.92999 ) then
            return;
        end
    end

    -- Patch 95
    patchNum = patchNum + 1;
    if numericV < 1.93 and baseValue < 1.93 then

    -- ONLY DO THIS IF PATCH HAS BEEN COMPLETELY SUCCESSFUL!!! If we get this far it has!

        GRM_Patch.ResetBackups( true , true );        -- Clearing the manual - unfortunately it needs to be done. Mostly unused feature anyway.

        GRM_G.ForceAuto = true;                 -- We want to force auto-backup this session so it backs up the alt groups.
        if loopCheck ( 1.93 ) then
            return;
        end
    end

    -- patch 96
    patchNum = patchNum + 1;
    if numericV < 1.931 and baseValue < 1.931 then

        GRM_Patch.ModifyPlayerSetting ( "syncSpeed" , nil );
        if loopCheck ( 1.931 ) then
            return;
        end
    end

    -- patch 97
    patchNum = patchNum + 1
    if numericV < 1.9311 and baseValue < 1.9311 then

        GRM_Patch.ModifyMemberData ( GRM_Patch.FixTimestamps , true , true , false );
        if loopCheck ( 1.9311 ) then
            return;
        end
    end

    -- patch 98
    patchNum = patchNum + 1;
    if numericV < 1.933 and baseValue < 1.933 then

        if GRM_G.BuildVersion < 80000 and GRM_G.BuildVersion >= 30000 then
            GRM_Patch.AddPlayerSetting ( "achievements" , true );
        end

        if loopCheck ( 1.933 ) then
            return;
        end
    end

    -- patch 99
    patchNum = patchNum + 1;
    if numericV < 1.937 and baseValue < 1.937 then

        GRM_Patch.ModifyPlayerSetting ( "ignoreDeadNames" , nil );
        GRM_Patch.AddMemberMetaData ( "deadNameIgnore" , false );

        if loopCheck ( 1.937 ) then
            return;
        end
    end

    --patch 100
    patchNum = patchNum + 1;
    if numericV < 1.944 and baseValue < 1.944 then

        GRM_Patch.ModifyMemberData ( GRM_Patch.PlayerNameFixFormerMembers , false , true , false );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "promoteRules" , "sinceAtRank" , true );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "kickRules" , "safeText" , "" );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "promoteRules" , "safeText" , "" );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "demoteRules" , "safeText" , "" );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "kickRules" , "safeMatch" , false );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "promoteRules" , "safeMatch" , false );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "demoteRules" , "safeMatch" , false );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "kickRules" , "GUID" , GRM_Patch.CreateMacroGUID );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "promoteRules" , "GUID" , GRM_Patch.CreateMacroGUID );
        GRM_Patch.ModifyOrAddMacroRuleSetting ( "demoteRules" , "GUID" , GRM_Patch.CreateMacroGUID );

        if loopCheck ( 1.944 ) then
            return;
        end
    end

    --patch 101
    patchNum = patchNum + 1;
    if numericV < 1.945 and baseValue < 1.945 then

        GRM_Patch.ModifyMemberData ( GRM_Patch.PlayerNameFixFormerMembers , false , true , false );

        if loopCheck ( 1.945 ) then
            return;
        end
    end

    --patch 102
    patchNum = patchNum + 1;
    if numericV < 1.946 and baseValue < 1.946 then

        GRM_Patch.AddPlayerSetting ( "chatTooltip" , true );
        GRM_Patch.ConfigureNewGlobalDateFormat();
        GRM_Patch.ModifyPlayerSetting ( "syncSameVersion" , nil );
        GRM_Patch.AddMemberMetaData ( "alts" , nil );
        GRM_Patch.AddMemberMetaData ( "removedAlts" , nil );
        GRM_Patch.FixIfGuildChange();

        if loopCheck ( 1.946 ) then
            return;
        end
    end

    --patch 103
    patchNum = patchNum + 1;
    if numericV < 1.947 and baseValue < 1.947 then

        GRM_Patch.ModifyPlayerSetting ( "exportFilters" , GRM_Patch.AddExportOptions );
        GRM_Patch.AddPlayerSetting ( "promoteOnlineOnly" , false );
        GRM_Patch.AddPlayerSetting ( "demoteOnlineOnly" , false );

        if loopCheck ( 1.947 ) then
            return;
        end
    end

    --patch 104
    patchNum = patchNum + 1;
    if numericV < 1.948 and baseValue < 1.948 then

        GRM_Patch.ModifyMemberData ( GRM_Patch.FixMissingClass , true , true , false );
        GRM_Patch.ModifyMemberData ( GRM_Patch.UpdateYearFormatting , true , true , false );
        GRM_Patch.AddMemberMetaData ( "removedAlts" , nil );    -- Forgot to remove the reference

        if loopCheck ( 1.948 ) then
            return;
        end
    end

    --patch 105
    patchNum = patchNum + 1;
    if numericV < 1.953 and baseValue < 1.953 then

        GRM_Patch.AltModifiedFix();
        GRM_Patch.ModifyMemberData ( GRM_Patch.PreviousAltGroupRejoinFix , true , true , false );

        if loopCheck ( 1.953 ) then
            return;
        end
    end

    --patch 106
    patchNum = patchNum + 1;
    if numericV < 1.96 and baseValue < 1.96 then

        if GRM_GuildMemberHistory_Save["H"] then
            GRM_Patch.ModifyMemberData ( GRM_Patch.JoinAndRankDataFix , true , true , false );
            GRM_Patch.AddPlayerSetting ( "coreWindowPos" , { "" , "" , 0 , 0 } );
        end


        if loopCheck ( 1.96) then
            return;
        end
    end

    -- patch 107
    patchNum = patchNum + 1;
    if numericV < 1.961 and baseValue < 1.961 then
        if not delayTrigger then
            numActions = numActions + 1; -- Need to wrap this count inside here as they will not be counted in loopcheck'
            GRM_Patch.ConvertSettings();
            GRM_Patch.ConvertDatabase();
        end

        if loopCheck ( 1.961 ) then
            return;
        end
    end

    -- patch 108
    patchNum = patchNum + 1;
    if numericV < 1.962 and baseValue < 1.962 then
        if not delayTrigger then
            numActions = numActions + 1; -- Need to wrap this count inside here as they will not be counted in loopcheck
            GRM_Patch.ConvertSaveFiles();
        end

        if loopCheck ( 1.962 ) then
            return;
        end
    end

    GRM_Patch.CleanupIfPlayerRolledBack();

    -- patch 109
    patchNum = patchNum + 1;
    if numericV < 1.97 and baseValue < 1.97 then

        GRM_Patch.EditSetting ( "allowAutoBackups" , nil );
        GRM_Patch.EditSetting ( "autoIntervalDays" , nil );
        GRM_Misc = {};  -- Rebuilding the way this is handled. Wiping it.
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixPersonWhoBanned , true , true , false );    -- DB change - for edge case if player's DB converted
        GRM_Patch.EditSetting ( "UIScaling" , GRM_Patch.ResetUIScaling );

        if loopCheck ( 1.97 ) then
            return;
        end
    end

    -- patch 110
    patchNum = patchNum + 1;
    if numericV < 1.972 and baseValue < 1.972 then

        if GRM_G.BuildVersion >= 80000 then
            GRM_Patch.AddMemberSpecificData ( "MythicScore" , 0 );
        end
        GRM_Patch.AddNewSetting ( "showLevel" , true );
        GRM_Patch.AddNewSetting ( "showMythicRating" , true );
        GRM_Patch.AddNewSetting ( "showLevelMaxOnly" , false );
        GRM_Patch.CleanUpAltGroupsFromError();

        if loopCheck ( 1.972 ) then
            return;
        end
    end

    -- patch 111
    patchNum = patchNum + 1;
    if numericV < 1.973 and baseValue < 1.973 then

        GRM_Patch.AddNewSetting ( "exportFilters" , 23 , GRM_Patch.AddExportEntry );
        if GRM_G.BuildVersion < 100000 then
            GRM_Patch.AddNewSetting ( "showFaction" , false );
        else
            GRM_Patch.AddNewSetting ( "showFaction" , true );
        end
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.AddFaction , true , true , false );
        GRM_Patch.FixJoinNameError();

        if loopCheck ( 1.973 ) then
            return;
        end
    end

    -- patch 112
    patchNum = patchNum + 1;
    if numericV < 1.977 and baseValue < 1.977 then

        GRM_Patch.FixMissingNames();
        GRM_Patch.AddNewSetting ( "RosterFramePOS" , { "" , "" , 0 , 0 } );

        if loopCheck ( 1.977 ) then
            return;
        end
    end

    -- patch 113
    patchNum = patchNum + 1;
    if numericV < 1.978 and baseValue < 1.978 then

        GRM_Patch.FixSettingsNames();
        GRM_Patch.ConvertSettingsToNewFormat();

        GRM_AddonSettings_Save.VERSION = "R1.978";
        if loopCheck ( 1.978 ) then
            return;
        end
    end

    -- patch 114
    patchNum = patchNum + 1;
    if numericV < 1.979 and baseValue < 1.979 then

        GRM_Patch.DeleteLegacyMacro();
        if GRM_G.BuildVersion >= 80000 then
            GRM_Patch.AddMemberSpecificData ( "MythicScore" , 0 );
        end

        GRM_AddonSettings_Save.VERSION = "R1.979";
        if loopCheck ( 1.979 ) then
            return;
        end
    end

    -- patch 115
    patchNum = patchNum + 1;
    if numericV < 1.981 and baseValue < 1.981 then

        GRM_Patch.EditSetting ( "UIScaling" , GRM_Patch.ResetUIScaling );
        GRM_Patch.EditSetting ( "UIScaling" , GRM_Patch.UpdateUIScaling );
        GRM_Patch.AddNewSetting ( "specialCharRemoval" , false );
        GRM_Patch.EditSetting ( "exportFilters" , GRM_Patch.ConvertExportFilters );
        GRM_Patch.AddNewSetting ( "ExportLevelRange" , {1,999} );  -- 999 represents MaxLevel

        GRM_AddonSettings_Save.VERSION = "R1.981";
        if loopCheck ( 1.981 ) then
            return;
        end
    end

    -- patch 116
    patchNum = patchNum + 1;
    if numericV < 1.982 and baseValue < 1.982 then

        GRM_Patch.AddNewSetting ( "bdayAnnounce" , true );
        GRM_Patch.AddNewSetting ( "annivAnnounce" , true );
        GRM_Patch.AddNewSetting ( "groupByMain" , false );
        GRM_Patch.AddNewSetting ( "showMainTags" , false );
        GRM_Patch.AddNewSetting ( "showMains" , true );
        GRM_Patch.AddNewSetting ( "showAlts" , true );
        GRM_Patch.AddNewSetting ( "showAltTags" , false );
        GRM_Patch.AddNewSetting ( "showRosterOffline" , true );
        GRM_Patch.AddNewSetting ( "showRosterOptions" , true );
        GRM_Patch.AddNewSetting ( "numRosterRows" , 18 );
        GRM_Patch.EditSetting ( "UIScaling" , GRM_Patch.UpdateUIScaling );

        GRM_AddonSettings_Save.VERSION = "R1.982";
        if loopCheck ( 1.982 ) then
            return;
        end
    end

    -- patch 117
    patchNum = patchNum + 1;
    if numericV < 1.983 and baseValue < 1.983 then

        GRM_Patch.AddMemberSpecificData ( "MythicScore" , 0 );
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixAltGroupModified , true , true , false , nil );
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.ModifyJoinAndPromoteDates , true , true , false , nil );
        GRM_Patch.EditSetting ( "removedMacroRules" , GRM_Patch.UpdateRemovedMacro );
        GRM_Patch.AddNewSetting ( "specialRules" , {} );
        GRM_Patch.AddNewSetting ( "macroSyncSpecialEnabled" , true );

        GRM_AddonSettings_Save.VERSION = "R1.983";
        if loopCheck ( 1.983 ) then
            return;
        end
    end

    -- patch 118
    patchNum = patchNum + 1;
    if numericV < 1.984 and baseValue < 1.984 then

        GRM_Patch.AddNewSetting ( "macroHotKey" , "CTRL-SHIFT-K" );

        GRM_AddonSettings_Save.VERSION = "R1.984";
        if loopCheck ( 1.984 ) then
            return;
        end
    end

    -- patch 119
    patchNum = patchNum + 1;
    if numericV < 1.985 and baseValue < 1.985 then

        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FormatFixVerifiedTime , true , true , false , nil );

        GRM_AddonSettings_Save.VERSION = "R1.985";
        if loopCheck ( 1.985 ) then
            return;
        end
    end

    -- patch 120
    patchNum = patchNum + 1;
    if numericV < 1.986 and baseValue < 1.986 then

        if GRM.IsHardcoreActive() then
            GRM_Patch.AddNewSetting ( "death" , true , nil , "toChat" );
            GRM_Patch.AddNewSetting ( "death" , true , nil , "toLog" );
            GRM_Patch.AddNewSetting ( 15 , { 0.76 , 0 , 0 } , nil , "logColor" );
        end
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.AddHardcoreVariables , true , true , false , nil );
        GRM_Patch.AddNewSetting ( "addDeathTag" , true );
        GRM_Patch.AddNewSetting ( "includeDeathTime" , true );
        GRM_Patch.AddNewSetting ( "exportHardcoreSort" , 1 );

        GRM_Patch.AddMemberSpecificData ( "alts" , nil );
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixStandardFormatAndRankHistFormat , true , true , false , nil );
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FormatFixVerifiedTime , true , true , false , nil );
        GRM_Patch.AltGroupIntegrityCheck();

        GRM_AddonSettings_Save.VERSION = "R1.986";
        if loopCheck ( 1.986 ) then
            return;
        end
    end

    -- patch 121
    patchNum = patchNum + 1;
    if numericV < 1.988 and baseValue < 1.988 then

        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixStandardStamp , true , true , false , nil );
        GRM_Patch.AddNewSetting ( "hideFramesInCombat" , true );

        GRM_AddonSettings_Save.VERSION = "R1.988";
        if loopCheck ( 1.988 ) then
            return;
        end
    end

    -- patch 122
    patchNum = patchNum + 1
    if numericV < 1.990 and baseValue < 1.990 then

        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixHCModeData , true , true , false , nil );

        GRM_AddonSettings_Save.VERSION = "R1.990";
        if loopCheck ( 1.990 ) then
            return;
        end
    end

    -- 123
    patchNum = patchNum + 1
    if numericV < 1.9902 and baseValue < 1.9902 then

        GRM_Patch.EditSetting ( "levelFilters" , GRM_Patch.UpdateLevelFilterSOD );

        GRM_AddonSettings_Save.VERSION = "R1.9902";
        if loopCheck ( 1.9902 ) then
            return;
        end
    end

    -- 124
    patchNum = patchNum + 1
    if numericV < 1.9903 and baseValue < 1.9903 then

        GRM_Patch.EditSetting ( "GIModule" , GRM_Patch.CleanUpGroupInfo );

        GRM_AddonSettings_Save.VERSION = "R1.9903";
        if loopCheck ( 1.9903 ) then
            return;
        end
    end

    -- 125
    if numericV < 1.9904 and baseValue < 1.9904 then

        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixWrathClassicEvokerBug , false , true , false , nil );

        GRM_AddonSettings_Save.VERSION = "R1.9904";
        if loopCheck ( 1.9904 ) then
            return;
        end
    end

    -- 126
    if numericV < 1.9905 and baseValue < 1.9905 then

        GRM_Patch.EditSetting ( "demoteRules" , GRM_Patch.MarcoRuleDataConsistencyFix );
        GRM_Patch.EditSetting ( "promoteRules" , GRM_Patch.MarcoRuleDataConsistencyFix );
        GRM_Patch.EditSetting ( "mainTagColor" , GRM_Patch.FixMainTagColor );
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.JoinDateErrorFix , true , true , false , nil );

        GRM_AddonSettings_Save.VERSION = "R1.9905";
        if loopCheck ( 1.9905 ) then
            return;
        end
    end

    -- 127
    if numericV < 1.99061 and baseValue < 1.99061 then

        GRM_Patch.EditSetting ( "demoteRules" , GRM_Patch.MarcoRuleDataConsistencyFix );
        GRM_Patch.AddMemberSpecificData ( "recommendSpecial" , true );

        GRM_AddonSettings_Save.VERSION = "R1.99061";
        if loopCheck ( 1.99061 ) then
            return;
        end
    end

    -- 128
    if numericV < 1.99094 and baseValue < 1.99094 then

        GRM_Patch.AddNewSetting ( "ignoreDeathChannel" , false );
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixRanKHistError , true , true , false , nil );

    GRM_AddonSettings_Save.VERSION = "R1.99094";
        if loopCheck ( 1.99094 ) then
            return;
        end
    end

    -- 129
    if numericV < 1.99095 and baseValue < 1.99095 then

        GRM_Patch.FixAltGroupData();

        GRM_AddonSettings_Save.VERSION = "R1.99095";
        if loopCheck ( 1.99095 ) then
            return;
        end
    end

    -- 130
    if numericV < 1.99096 and baseValue < 1.99096 then

        GRM_Patch.EditSetting ( "levelFilters" , GRM_Patch.AddNewLevelFilters );

        GRM_AddonSettings_Save.VERSION = "R1.99096";
        if loopCheck ( 1.99096 ) then
            return;
        end
    end

    -- 131
    if numericV < 1.9910 and baseValue < 1.9910 then

        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.PlayerPromotedToOfficerNoteUpdate , true , true , false , nil );
        GRM_Patch.BuildNewMainAltDB();
        GRM_Patch.EditSetting ( "banInfoReport" , nil );
        GRM_Patch.AddMemberSpecificData ( "lastOnlineTime" , { 0 , 0 , 0 , 1 } );
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.ConvertHours , true , false , false , nil );

        GRM_AddonSettings_Save.VERSION = "R1.9910";
        if loopCheck ( 1.9910 ) then
            return;
        end
    end

    -- 132
    if numericV < 1.9911 and baseValue < 1.9911 then

        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.ModifyCustomNote , true , true , false , nil );
        GRM_Patch.EditSetting ( "syncBDays" , nil );
        GRM_Patch.AddNewSetting ( "banInfoReport" , false );

        GRM_AddonSettings_Save.VERSION = "R1.9911";
        if loopCheck ( 1.9911 ) then
            return;
        end
    end

    -- 133
    if numericV < 1.9913 and baseValue < 1.9913 then
        GRM_Patch.ModifyMemberSpecificData ( GRM_Patch.FixLegacyFormattingErrorOnRankAndJoinHist , true , true , false , nil );
        GRM_Patch.AltGroupUpdateTweak();

        GRM_AddonSettings_Save.VERSION = "R1.9913";
        if loopCheck ( 1.9913 ) then
            return;
        end
    end

    GRM_Patch.FinalizeReportPatches( patchNeeded , numActions );
end

-- Final report is good to go!
-- Note, these are purposefully "PRINTED" as they are not necessary to be stored in the chat logs which other addons might save.
GRM_Patch.FinalizeReportPatches = function ( patchNeeded , numActions )
    if patchNeeded then

        -- Ok, let's update the version!
        print ( "|CFFFFD100" .. GRM.L ( "GRM Updated:" ) .. " v" .. GRM_G.Version:match ( "R(.+)" ) );

        if numActions > 1 then
            print ( "|CFFFFD100" .. GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Update Complete... {num} patches applied." , nil , nil , numActions ) );
        else
            print ( "|CFFFFD100" .. GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Update Complete... 1 patch applied." ) );
        end
        print ( "|CFFFFD100" ..  GRM.L ( "Total Patch Time:" ) .. " " .. GRM.GetTimePassedInZone ( startTime ) );

    end

    GRM_G.currentlyPatching = false;

    -- Updating the version for ALL saved accoutns.
    GRM_AddonSettings_Save.VERSION = GRM_G.Version;

    if oldDB then
        GRM.ConfigureMiscForPlayer( GRM_G.addonUser );
    end

    -- Add new guild
    if IsInGuild() and not GRM_AddonSettings_Save[GRM_G.guildName] then
        GRM_AddonSettings_Save[GRM_G.guildName] = {};

        -- Load the Default Settings
        for i = 0 , GRM_G.SettingsPages do
            GRM.SetDefaultAddonSettings ( GRM_AddonSettings_Save[GRM_G.guildName] , i );
        end
    end


    C_Timer.After ( 1 , GRM.FinalSettingsConfigurations );
end

---------------------------
-- CORE TOOLS -------------
---------------------------

-- 1.97
-- Method:          GRM_Patch.AddMemberSpecificData ( string , anyVar )
-- What it Does:    Goes through the entire account wide database and adds the player's metadata a new setting
-- Purpose:         Reusable function for error work and to avoid on code bloat spam.
GRM_Patch.AddMemberSpecificData = function ( settingName , value )
    for guildName in pairs ( GRM_GuildMemberHistory_Save ) do                  -- The guilds in each faction
        for _ , player in pairs ( GRM_GuildMemberHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild
            if type ( player ) == "table" then
                player[settingName] = value;
            end
        end
    end

    -- Former memebrs
    for guildName in pairs ( GRM_PlayersThatLeftHistory_Save ) do                  -- The guilds in each faction
        for _ , player in pairs ( GRM_PlayersThatLeftHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
            if type ( player ) == "table" then
                player[settingName] = value;
            end
        end
    end

    -- Check the backup data as well.
    local backup = { "members" , "formerMembers" };

    for guildName in pairs ( GRM_GuildDataBackup_Save ) do
        for i = 1 , #backup do        -- Member vs formerMember

            if GRM_GuildDataBackup_Save[guildName][backup[i]] == nil or #GRM_GuildDataBackup_Save[guildName][backup[i]] > 0 then
                GRM_GuildDataBackup_Save[guildName][backup[i]] = {};
            else
                for _ , player in pairs ( GRM_GuildDataBackup_Save[guildName][backup[i]] ) do
                    if type ( player ) == "table" then
                        player[settingName] = value;
                    end
                end
            end
        end
    end
end

-- R1.97
-- Method:          GRM_Patch.ModifyMemberSpecificData ( function , bool , bool , bool , object or var )
-- What it Does:    Goes through the entire account wide database and modifies a player's or guild's metadata based on the actions of the given function
-- Purpose:         Reusable function for error work and to avoid on code bloat spam.
GRM_Patch.ModifyMemberSpecificData = function ( databaseChangeFunction , editCurrentPlayers , editLeftPlayers , includeAllGuildData , modifier )

    if editCurrentPlayers then
        for guildName in pairs ( GRM_GuildMemberHistory_Save ) do                  -- The guilds in each faction
            for name , player in pairs ( GRM_GuildMemberHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if type ( player ) == "table" then
                    if includeAllGuildData then
                        GRM_GuildMemberHistory_Save[guildName][name] = databaseChangeFunction ( GRM_GuildMemberHistory_Save[guildName] , player , modifier );
                    else
                        GRM_GuildMemberHistory_Save[guildName][name] = databaseChangeFunction ( player , modifier );
                    end
                end
            end
        end
    end

    -- Former memebrs
    if editLeftPlayers then
        for guildName in pairs ( GRM_PlayersThatLeftHistory_Save ) do                  -- The guilds in each faction
            for name , player in pairs ( GRM_PlayersThatLeftHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if type ( player ) == "table" then
                    if includeAllGuildData then
                        GRM_PlayersThatLeftHistory_Save[guildName][name] = databaseChangeFunction ( GRM_PlayersThatLeftHistory_Save[guildName] , player , modifier );
                    else
                        GRM_PlayersThatLeftHistory_Save[guildName][name] = databaseChangeFunction ( player , modifier );
                    end
                end
            end
        end
    end

    -- Check the backup data as well.
    local backup = { "members" , "formerMembers" };
    for guildName in pairs ( GRM_GuildDataBackup_Save ) do
        for i = 1 , #backup do        -- Member vs formerMember

            if ( i == 1 and editCurrentPlayers ) or ( i == 2 and editLeftPlayers ) then
                if GRM_GuildDataBackup_Save[guildName][backup[i]] == nil or #GRM_GuildDataBackup_Save[guildName][backup[i]] > 0 then
                    GRM_GuildDataBackup_Save[guildName][backup[i]] = {};
                else
                    for name , player in pairs ( GRM_GuildDataBackup_Save[guildName][backup[i]] ) do
                        if type ( player ) == "table" then
                            if includeAllGuildData then
                                GRM_GuildDataBackup_Save[guildName][backup[i]][name] = databaseChangeFunction ( GRM_GuildDataBackup_Save[guildName][backup[i]] , player , modifier );
                            else
                                GRM_GuildDataBackup_Save[guildName][backup[i]][name] = databaseChangeFunction ( player , modifier );
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 1.971
-- Method:          GRM_Patch.AddNewSetting ( string , value , function , string )
-- What it Does:    Creates a new settings value
-- Purpose:         Be able to add new tools and controls to player.
GRM_Patch.AddNewSetting = function ( nameOfNewSetting , value , additionalLogic , additionalSetting )
    for g in pairs ( GRM_AddonSettings_Save ) do
        if type(GRM_AddonSettings_Save[g]) == "table" then
            if not additionalSetting and not additionalLogic then
                GRM_AddonSettings_Save[g][nameOfNewSetting] = value;
            elseif not additionalSetting and type ( additionalLogic ) == "function" then
                GRM_AddonSettings_Save[g] = additionalLogic ( GRM_AddonSettings_Save[g] , value );
            elseif additionalSetting then
                GRM_AddonSettings_Save[g][additionalSetting][nameOfNewSetting] = value;
            end
        end
    end
end

-- 1.87
-- Method:          GRM_Patch.EditSetting ( string , function )
-- What it Does:    Allows the player to modify an existing setting to a new value given the valueOrLogic function
-- Purpose:         To be able to retroactively adapt and make changes to the database.
GRM_Patch.EditSetting = function ( setting , valueOrLogic , additionalSetting )
    for p in pairs ( GRM_AddonSettings_Save ) do
        if type (GRM_AddonSettings_Save[p]) == "table" then
            if type ( valueOrLogic ) == "function" then
                if additionalSetting then
                    if GRM_AddonSettings_Save[p][setting][additionalSetting] ~= nil then
                        GRM_AddoSnettings_Save[p][setting][additionalSetting] = valueOrLogic ( GRM_AddonSettings_Save[p][setting] );
                    end
                else

                    GRM_AddonSettings_Save[p][setting] = valueOrLogic ( GRM_AddonSettings_Save[p][setting] );
                end
            else
                if additionalSetting then
                    if GRM_AddonSettings_Save[p][setting][additionalSetting] ~= nil then
                        GRM_AddonSettings_Save[p][setting][additionalSetting] = valueOrLogic;
                    end
                else
                    GRM_AddonSettings_Save[p][setting] = valueOrLogic;
                end
            end
        end
    end
end

---------------------
-- old db settings work --
---------------------

-- Method:          GRM_Patch.ManageOldSettingsDB()
-- What it Does:    Preps settings DB for conversion
-- Purpose:         Cleanup the "LoadSettings" function in GRM_Core as it had a lot of old legacy code. Let's shift it over to patches.
GRM_Patch.ManageOldSettingsDB = function()
    local FIDD = 0;
    local PIDD = 0;
    local F = "H";
    local isFound = false;
    local playerV = "";

    oldDB = true;   -- Class global.

    if UnitFactionGroup ( "PLAYER" ) == "Horde" then
        FIDD = 1;
        F = "H";
    else
        FIDD = 2;
        F = "A";
    end

    if GRM_AddonSettings_Save["H"] then
        for name in pairs ( GRM_AddonSettings_Save[F] ) do
            if name == GRM_G.addonUser then
                isFound = true;
                playerV = GRM_AddonSettings_Save[F][name].version;
                break;
            end
        end

        if not isFound then
            for name in pairs ( GRM_AddonSettings_Save[F] ) do
                if GRM_AddonSettings_Save[F][name].version ~= nil and GRM_AddonSettings_Save[F][name].version ~= GRM_G.Version then
                    playerV = GRM_AddonSettings_Save[F][name].version;
                    break;
                end
            end
        end

        if not isFound then
            GRM.Report ( "\n" .. GRM.L ( "Configuring Guild Roster Manager for {name} for the first time." , GetUnitName ( "PLAYER" , false ) ) );

            -- Old Database so still have FID outdated system - legacy code compatibility so it can be fully updated.
            -- Add new player
            GRM_AddonSettings_Save[F][GRM_G.addonUser] = {};
            -- Add new player
            -- Load the Default Settings
            for i = 0 , GRM_G.SettingsPages do
                GRM.SetDefaultAddonSettings ( GRM_AddonSettings_Save[F][GRM_G.addonUser] , i );
            end

            GRM.ConfigureMiscForPlayer( GRM_G.addonUser );

            GRM_G.IsNewToon = true;
            -- Forcing core log window/options frame to load on the first load ever as well
            GRM_G.ChangesFoundOnLoad = true;

        elseif not IsInGuild() then
            GRM_G.IsNewToon = true;
            GRM_G.ChangesFoundOnLoad = true;
        end

    else
        for j = 2 , #GRM_AddonSettings_Save[FIDD] do
            if GRM_AddonSettings_Save[FIDD][j][1] == GRM_G.addonUser then
                isFound = true;

                if GRM_AddonSettings_Save[FIDD][j][2][1] ~= nil and GRM_AddonSettings_Save[FIDD][j][2][1] ~= GRM_G.Version then
                    playerV = GRM_AddonSettings_Save[FIDD][j][2][1];
                end
                break;
            end
        end

        -- Verify at least one profile needs to be updated. This is done to account for new toons as well on an update.
        if not isFound then
            for i = 1 , #GRM_AddonSettings_Save do
                for j = 2 , #GRM_AddonSettings_Save[i] do
                    if GRM_AddonSettings_Save[i][j][2][1] ~= nil and GRM_AddonSettings_Save[i][j][2][1] ~= GRM_G.Version then
                        playerV = GRM_AddonSettings_Save[i][j][2][1];
                        break;
                    end
                end
                if playerV ~= "" then
                    break;
                end
            end

        -- Integrity check on the addon settings.
        else
            isFound =  GRM_Patch.PlayerSettingsIntegrityCheck();
        end

        if not isFound then
            GRM.Report ( "\n" .. GRM.L ( "Configuring Guild Roster Manager for {name} for the first time." , GetUnitName ( "PLAYER" , false ) ) );

            -- Old Database so still have FID outdated system - legacy code compatibility so it can be fully updated.
            -- Add new player
            table.insert ( GRM_AddonSettings_Save[FIDD] , { GRM_G.addonUser } );
            PIDD = #GRM_AddonSettings_Save[FIDD];                                -- We know what the ID is...

            -- Unique Settings added to the player.
            table.insert ( GRM_AddonSettings_Save[FIDD][PIDD] , GRM_Patch.GetDefaultAddonSettings() );

            GRM_G.IsNewToon = true;
            -- Forcing core log window/options frame to load on the first load ever as well
            GRM_G.ChangesFoundOnLoad = true;

        elseif not IsInGuild() then
            GRM_G.IsNewToon = true;
            GRM_G.ChangesFoundOnLoad = true;
        end
    end

    return playerV;
end

-- Only applies to updating much older databases so mostly deprecated, but if someone has a significantly old version they will need to run it through this on their update.
-- Method:          GRM_Patch.PlayerSettingsIntegrityCheck()
-- What it Does:    Checks for broken player addon settings in relation to some previous errors that could be introduced. Returns a boolean to determine if the player settings need to be rebuilt for that current player
-- Purpose:         To fix any issues in regards to previous bug.
GRM_Patch.PlayerSettingsIntegrityCheck = function()
    local g = GRM_AddonSettings_Save;
    local needsToKeep = true;

    for i = 1 , #g do
        for j = #g[i] , 2 , -1 do
            if g[i][j][2] == nil then
                if needsToKeep and g[i][j][1] == GRM_G.addonUser then
                    needsToKeep = false;
                end
                table.remove ( g[i] , j );
            end
        end
    end
    return needsToKeep;
end

------------------------
--- CLASSIC ISSUES -----
------------------------

-- Method:          GRM_Patch.FixClassIncompatibilityBuild()
-- What it Does:    Activates the popup window to enable wiping and hard restting the addon data due to a previous incompatible load
-- Purpose:         Resolves issues from players who enabled an outdated version of the addon.
GRM_Patch.FixClassIncompatibilityBuild = function()
    GRM_AddonSettings_Save = {};

    local hardReset = function()
        GRM_AddonSettings_Save = {};
        ReloadUI();
    end

    GRM.SetConfirmationWindow ( hardReset , GRM.L ( "GRM has errored due to a previous incompatible build with Classic that was enabled. Click YES to reload UI and fix the issue" ) );
end

-- Method:          GRM_Patch.RemoveMacroInClassic()
-- What it Does:    Checks if macro exists and then removes it if it does.
-- Purpose:
GRM_Patch.RemoveMacroInClassic = function()

    if GetMacroInfo ( "GRM_Roster" ) ~= nil then
        DeleteMacro ( "GRM_Roster" );
    end

end

-- Method:          GRM.TimeStampToEpoch (timestamp)
-- What it Does:    Converts a given timestamp: "22 Mar '17" into Epoch Seconds time (UTC timezone)
-- Purpose:         On adding notes, epoch time is considered when calculating how much time has passed, for exactness and custom dates need to include it.
GRM.TimeStampToEpoch = function ( timestamp , IsStartOfDay , knownHour , knownMinute , knownSeconds )
    local monthEnum = { Jan = 1 , Feb = 2 , Mar = 3 , Apr = 4 , May = 5 , Jun = 6 , Jul = 7 , Aug = 8 , Sep = 9 , Oct = 10 , Nov = 11 , Dec = 12 };
    local daysBeforeMonthEnum = { ['1']=0 , ['2']=31 , ['3']=59 , ['4']=90 , ['5']=120 , ['6']=151 , ['7']=181 , ['8']=212 , ['9']=243 , ['10']=273 , ['11']=304 , ['12']=334 };
    -- Parsing Timestamp to useful data.
    if not timestamp then
        return;
    end

    local day , month, year , hour , minute , seconds , leapYear;

    if type ( timestamp ) == "string" then
        timestamp = GRM.GetCleanTimestamp ( timestamp );
        year = GRM.GetEventYear ( timestamp );
        month = monthEnum [ GRM.GetEventMonth ( timestamp ) ];
        day = GRM.GetEventDay ( timestamp );
    elseif type ( timestamp ) == "table" then
        day = timestamp[1];
        month = timestamp[2];
        year = timestamp[3];
        if year < 1000 then
            year = year + 2000;
        end
    end

    leapYear = GRM.IsLeapYear ( year );

    -- End timestamp Parsing...

    if IsStartOfDay then
        hour = 11;
        minute = 1;
        seconds = 0;
    else
        if knownHour and knownMinute then
            hour = knownHour;
            minute = knownMinute;
        else
            hour , minute = GetGameTime();
        end
        seconds = knownSeconds or date ( '*t' ).sec;
    end

    -- calculate the number of seconds passed since 1970 based on number of years that have passed.
    local totalSeconds = 0;
    for i = year - 1 , 1970 , -1 do
        if GRM.IsLeapYear ( i ) then
            totalSeconds = totalSeconds + ( 366 * 86400 ); -- leap year = 366 days + 1 extra day
        else
            totalSeconds = totalSeconds + ( 365 * 86400 ); -- 365 days in normal year
        end
    end

    -- Now lets calculate how much time this year...
    local monthDays = daysBeforeMonthEnum [ tostring ( month ) ];
    if leapYear and ( month > 2 or ( month == 2 and day == 29 ) ) then -- Adding 1 for the leap year
        monthDays = monthDays + 1;
    end
    -- adding month days so far this year to result so far.
    totalSeconds = totalSeconds + ( monthDays * 86400);

    -- The rest is easy... as of now, I will not import hours/minutes/seconds, but I will leave the calculations in place in case need arises.
    totalSeconds = totalSeconds + ( ( day - 1 ) * 86400 );  -- days
    totalSeconds = totalSeconds + ( hour * 3600 );
    totalSeconds = totalSeconds + ( minute * 60 );
    totalSeconds = totalSeconds + seconds;

    return totalSeconds;
end


-------------------------------
--- START PATCH LOGIC ---------
-------------------------------

-- Introduced Patch R1.092
-- Alt tracking of the player - so it can auto-add the player's own alts to the guild info on use.
GRM_Patch.SetupAltTracking = function()
    -- Need to check if already added to the guild...
    local guildNotFound = true;
    if GRM_G.guildName ~= nil then
        for i = 2 , #GRM_GuildMemberHistory_Save[ FID ] do
            if GRM_GuildMemberHistory_Save[FID][i][1][1] == GRM_G.guildName then
                guildNotFound = false;
                break;
            end
        end
    end

    -- Build the table for the first time! It will be unique to the faction and the guild.
    table.insert ( GRM_PlayerListOfAlts_Save , { "Horde" } );
    table.insert ( GRM_PlayerListOfAlts_Save , { "Alliance" } );

    if IsInGuild() and not guildNotFound then
        -- guild is found, let's add the guild!
        table.insert ( GRM_PlayerListOfAlts_Save[ FID ] , { { GRM_G.guildName , GRM_G.guildCreationDate } } );  -- alts list, let's create an index for the guild!

        -- Insert player name too...
    end
end


-- Introduced Patch R1.100
-- Updating the version for ALL saved accounts.
GRM_Patch.UpdateRankControlSettingDefault = function()
    local needsUpdate = true;
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if GRM_AddonSettings_Save[i][j][2][22] > 0 then
                -- This will signify that the addon has already been updated to current state and will not need update.
                needsUpdate = false;
                break;
            else
                GRM_AddonSettings_Save[i][j][2][22] = 2;      -- Updating rank to general officer rank to be edited.
            end
        end
        if not needsUpdate then     -- No need to cycle through everytime. Resource saving here!
            break;
        end
    end
end


-- Introduced Patch R1.111
-- Added some more booleans to the options for future growth.
GRM_Patch.ExpandOptions = function()
    -- Updating settings for all
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if #GRM_AddonSettings_Save[i][j][2] == 26 then
                table.insert ( GRM_AddonSettings_Save[i][j][2] , true );        -- 27th option
                table.insert ( GRM_AddonSettings_Save[i][j][2] , true );        -- 28th option
                table.insert ( GRM_AddonSettings_Save[i][j][2] , true );        -- 29th option
                table.insert ( GRM_AddonSettings_Save[i][j][2] , false );       -- 30th option
            end
        end
    end
end


-- Intoduced Patch R1.122
-- Adds an additional point of logic for "Unknown" on join date...
GRM_Patch.IntroduceUnknown = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if #GRM_GuildMemberHistory_Save[i][j][r] == 39 then
                    table.insert ( GRM_GuildMemberHistory_Save[i][j][r] , false );      -- isUnknown join
                    table.insert ( GRM_GuildMemberHistory_Save[i][j][r] , false );      -- isUnknown promo
                end
            end
        end
    end

    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if #GRM_PlayersThatLeftHistory_Save[i][j][r] == 39 then
                    table.insert ( GRM_PlayersThatLeftHistory_Save[i][j][r] , false );      -- isUnknown join
                    table.insert ( GRM_PlayersThatLeftHistory_Save[i][j][r] , false );      -- isUnknown promo
                end
            end
        end
    end
end

-- Introduced Patch R1.125
-- Bug fix... need to purge of repeats
GRM_Patch.RemoveRepeats = function()
    local t;
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            local r = 2;
            while r <= #GRM_GuildMemberHistory_Save[i][j] do            -- Using while loop to manually increment, rather than auto in a for loop, as table.remove will remove an index.
                t = GRM_GuildMemberHistory_Save[i][j];
                local isRemoved = false;
                for s = 2 , #t do
                    if s ~= r and GRM_GuildMemberHistory_Save[i][j][r][1] == t[s][1] then
                        isRemoved = true;
                        table.remove ( GRM_GuildMemberHistory_Save[i][j] , r );
                        break;
                    end
                end
                if not isRemoved then
                    r = r + 1;
                end
            end
        end
    end
end


-- Introduced Patch R1.125
-- Establishing the slider default value to be 40 for throttle controls ( 100% )
GRM_Patch.EstablishThrottleSlider = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            GRM_AddonSettings_Save[i][j][2][24] = 40;
        end
    end
end

-- Introduced Patch R1.126
-- Ability to add number of options on a specific scale
GRM_Patch.ExpandOptionsScalable = function( numNewIndexesToAdd , baseNumber , addingBoolean )
    -- Updating settings for all
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if #GRM_AddonSettings_Save[i][j][2] == baseNumber then
                for s = 1 , numNewIndexesToAdd do
                    if addingBoolean then
                        table.insert ( GRM_AddonSettings_Save[i][j][2] , true );        -- X option position
                    else
                        table.insert ( GRM_AddonSettings_Save[i][j][2] , 1 );           -- Adding int instead, placeholder value of 1
                    end
                end
                -- We know it is starting at 30 now.
                if baseNumber == 30 then
                    GRM_AddonSettings_Save[i][j][2][31] = false;                        -- This one value should be defaulted to false.
                end
            end
        end
    end
end

-- Introduced Patch R1.126
-- Minimap Created!!!
GRM_Patch.SetMinimapValues = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            GRM_AddonSettings_Save[i][j][2][25] = 345;
            GRM_AddonSettings_Save[i][j][2][26] = 78;
        end
    end
end

-- TEST HELPERS
-- Introduced Patch R1.126
GRM_Patch.CleanupSettings = function ( anyValueGreaterThanThisIndex )
    local settings = GRM_AddonSettings_Save[FID];
    for i = 2 , #settings do
        if #settings[i][2] > anyValueGreaterThanThisIndex then
            while #settings[i][2] > anyValueGreaterThanThisIndex do
                table.remove ( settings[i][2] , #settings[i][2] );
            end
        end
    end
    GRM_AddonSettings_Save[FID] = settings;
end

-- Some Promo dates were erroneously added with a ": 14 Jan '18" format. This fixes that.
-- Introduced Patch R1.129
GRM_Patch.CleanupPromoDatesOrig = function()
    local t = GRM_GuildMemberHistory_Save;
    for i = 1 , #t do                         -- Horde and Alliance
        for j = 2 , #t[i] do                  -- The guilds in each faction
            for r = 2 , #t[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if t[i][j][r][12] ~= nil and string.find ( t[i][j][r][12] , ":" ) ~= nil then
                    t[i][j][r][12] = string.sub ( t[i][j][r][12] , 3 );
                    t[i][j][r][36][1] = t[i][j][r][12];
                end
            end
        end
    end

    -- Save the updates...
    GRM_GuildMemberHistory_Save = t;

    local s = GRM_PlayersThatLeftHistory_Save;
    for i = 1 , #s do
        for j = 2 , #s[i] do
            for r = 2 , #s[i][j] do
                if s[i][j][r][12] ~= nil and string.find ( s[i][j][r][12] , ":" ) ~= nil then
                    s[i][j][r][12] = string.sub ( s[i][j][r][12] , 3 );
                    s[i][j][r][36][1] = s[i][j][r][12];
                end
            end
        end
    end

    -- Need to set default setting to sync on all toons to only those with current version. This is to prevent reversion of bug
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            GRM_AddonSettings_Save[i][j][2][19] = true;
        end
    end

end

-- R1.130
-- Sync settings across players in the same guild should not have been set to true. This corrects that.
GRM_Patch.TurnOffDefaultSyncSettingsOption = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            GRM_AddonSettings_Save[i][j][2][31] = false;
        end
    end
end

-- R1.130
-- Logic change dictates a reset... People will need to reconfigure.
GRM_Patch.ResetSyncThrottle = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            GRM_AddonSettings_Save[i][j][2][24] = 40;
        end
    end
end

-- R1.130
-- Due to date formatting issue not alligning with US, they need to be wiped and reset, and the English date is made more correct.
GRM_Patch.ResetCreationDates = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do
            -- Only need to fix if it was updated with 1.130
            if GRM_GuildMemberHistory_Save[i][j][1][1] ~= nil then
                GRM_GuildMemberHistory_Save[i][j][1] = GRM_GuildMemberHistory_Save[i][j][1][1];
            end
        end
    end

    for i = 1 , #GRM_CalendarAddQue_Save do
        for j = 2 , #GRM_CalendarAddQue_Save[i] do
            -- Only need to fix if it was updated with 1.130
            if GRM_CalendarAddQue_Save[i][j][1][1] ~= nil then
                GRM_CalendarAddQue_Save[i][j][1] = GRM_CalendarAddQue_Save[i][j][1][1];
            end
        end
    end

    for i = 1 , #GRM_PlayersThatLeftHistory_Save do
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do
            -- Only need to fix if it was updated with 1.130
            if GRM_PlayersThatLeftHistory_Save[i][j][1][1] ~= nil then
                GRM_PlayersThatLeftHistory_Save[i][j][1] = GRM_PlayersThatLeftHistory_Save[i][j][1][1];
            end
        end
    end
    for i = 1 , #GRM_LogReport_Save do
        for j = 2 , #GRM_LogReport_Save[i] do
            -- Only need to fix if it was updated with 1.130
            if GRM_LogReport_Save[i][j][1][1] ~= nil then
                GRM_LogReport_Save[i][j][1] = GRM_LogReport_Save[i][j][1][1];
            end
        end
    end

    for i = 1 , #GRM_PlayerListOfAlts_Save do
        for j = 2 , #GRM_PlayerListOfAlts_Save[i] do
            -- Only need to fix if it was updated with 1.130
            if GRM_PlayerListOfAlts_Save[i][j][1][1] ~= nil then
                GRM_PlayerListOfAlts_Save[i][j][1] = GRM_PlayerListOfAlts_Save[i][j][1][1];
            end
        end
    end
end


-- R1.132
-- For cleaning up the Left PLayers database
GRM_Patch.CleanupLeftPlayersDatabaseOfRepeats = function()
    local repeatsRemoved = 1;
    local count = 2;
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                             -- For each server
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                      -- for each guild
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do            -- For each player
                count = 2;
                while count <= #GRM_PlayersThatLeftHistory_Save[i][j] and r <= #GRM_PlayersThatLeftHistory_Save[i][j] do           -- Scan through the guild for match
                    if r ~= count and GRM_PlayersThatLeftHistory_Save[i][j][count][1] == GRM_PlayersThatLeftHistory_Save[i][j][r][1] then
                        -- match found!
                        table.remove ( GRM_PlayersThatLeftHistory_Save[i][j] , count );
                        repeatsRemoved = repeatsRemoved + 1;
                        -- Don't incrememnt up since you are removing a slot and everything shifts down.
                    else
                        count = count + 1;
                    end
                end
            end
        end
    end
end

-- R1.133
-- For cleaning up a broken database...
GRM_Patch.CleanupGuildNames = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do
        for s = 2 , #GRM_GuildMemberHistory_Save[i] do
            if GRM_GuildMemberHistory_Save[i][s][1] == nil then
                -- Let's scan through the guild to see if it has my name!
                local isFound = false;
                for j = 2 , #GRM_GuildMemberHistory_Save[i][s] do
                    if GRM_GuildMemberHistory_Save[i][s][j][1] == GRM_G.addonUser then
                        GRM_GuildMemberHistory_Save[i][s][1] = GRM_G.guildName;
                        isFound = true;
                        break;
                    end
                end
                if not isFound then
                    GRM_GuildMemberHistory_Save[i][s][1] = "";
                end
            end
        end
    end

    for i = 1 , #GRM_PlayersThatLeftHistory_Save do
        for s = 2 , #GRM_PlayersThatLeftHistory_Save[i] do
            if GRM_PlayersThatLeftHistory_Save[i][s][1] == nil then
                -- Let's scan through the guild to see if it has my name!
                local isFound = false;
                for j = 2 , #GRM_PlayersThatLeftHistory_Save[i][s] do
                    if GRM_PlayersThatLeftHistory_Save[i][s][j][1] == GRM_G.addonUser then
                        GRM_PlayersThatLeftHistory_Save[i][s][1] = GRM_G.guildName;
                        isFound = true;
                        break;
                    end
                end
                if not isFound then
                    GRM_PlayersThatLeftHistory_Save[i][s][1] = "";
                end
            end
        end
    end
end

-- Added R 1.137
-- Method:          GRM_Patch.AddAutoBackupIndex()
-- What it Does:    Adds 2 indexes that will be permanently in place for autobackup indexes...
-- Purpose:         So that the autobackup has a place to be set...
GRM_Patch.AddAutoBackupIndex = function()
    for i = 1 , #GRM_GuildDataBackup_Save do    -- For each faction
        for j = 2 , #GRM_GuildDataBackup_Save[i] do
            -- Insert 2 points...
            table.insert ( GRM_GuildDataBackup_Save[i][j] , 2 , {} );
            table.insert ( GRM_GuildDataBackup_Save[i][j] , 3 , {} );
        end
    end
end

-- Added R1.137
-- Method:          GRM_Patch.ConfigureAutoBackupSettings()
-- What it Does:    Establishes Auto Backup settings
-- Purpose:         For a new feature, all player settings should be set default to 7 days, when the original setting placeholder was 1
GRM_Patch.ConfigureAutoBackupSettings = function()
    -- Updating settings for all
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            GRM_AddonSettings_Save[i][j][2][41] = 7;
        end
    end
end

-- Method:          GRM_Patch.ResetAllBackupsPatch()
-- What it Does:    Wipes all backup data, but then reinitializes an index for each guild
-- Purpose:         For managing the database of guild backups
GRM_Patch.ResetAllBackupsPatch = function()
    -- Reset the backup data in case any player was messing around with it...
    GRM_GuildDataBackup_Save = nil;
    GRM_GuildDataBackup_Save = {};
    GRM_GuildDataBackup_Save = { { "Horde" } , { "Alliance" } };
    -- Let's go through all the guilds!
    for i = 1 , #GRM_GuildMemberHistory_Save do
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do
            table.insert ( GRM_GuildDataBackup_Save[i] , { GRM_GuildMemberHistory_Save[i][j][1] , {} } );
        end
    end
end

-- Intoduced Patch R1.142
-- Method:          GRM_Patch.CleanupPromoDates()
-- What it does:    Parses through all of the guild promo and removes the "12:01am" after it...
-- Purpose:         Some patches previously an erroenous stamping was added, this fixes it.
GRM_Patch.CleanupPromoDates = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            -- First the current players...
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if GRM_GuildMemberHistory_Save[i][j][r][12] ~= nil then
                    local timestamp = GRM_GuildMemberHistory_Save[i][j][r][12];
                    GRM_GuildMemberHistory_Save[i][j][r][12] = string.sub ( timestamp , 1 , string.find ( timestamp , "'" ) + 2 );
                end
            end

            -- Now, the left players (i,j indexes will be the same, no need to reloop to find)
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if GRM_PlayersThatLeftHistory_Save[i][j][r][12] ~= nil then
                    local timestamp = GRM_PlayersThatLeftHistory_Save[i][j][r][12];
                    GRM_PlayersThatLeftHistory_Save[i][j][r][12] = string.sub ( timestamp , 1 , string.find ( timestamp , "'" ) + 2 );
                end
            end
        end
    end
end

-- Introduced patch R1.142
-- Method:          GRM_Patch.ExpandOptionsType(int,int,int,object)
-- What it Does:    Expands the number of options settings, and initializes the type
-- Purpose:         Reusuable for future flexibility on updates.
-- 1 = number, 2=boolean, 3 = array , 4 = string
GRM_Patch.ExpandOptionsType = function( typeToAdd , numberSlots , referenceCheck , saveOption )
    local expansionType;
    if saveOption then
        expansionType = saveOption;
    else
        if typeToAdd == 1 then          -- Int
            expansionType = 1;
        elseif typeToAdd == 2 then      -- Boolean
            expansionType = true;
        elseif typeToAdd == 3 then      -- Array/Table
            expansionType = {};
        elseif typeToAdd == 4 then      -- String
            expansionType = "";
        end
    end
    -- Updating settings for all
    for i = 1 , #GRM_AddonSettings_Save do
        for j = #GRM_AddonSettings_Save[i] , 2 , -1 do
            if #GRM_AddonSettings_Save[i][j] == nil then
                table.remove ( GRM_AddonSettings_Save[i] , j );
            else
                if #GRM_AddonSettings_Save[i][j] == 1 then
                    table.remove ( GRM_AddonSettings_Save[i] , j );                 -- Error protection in case bad settings profile build
                else
                    if #GRM_AddonSettings_Save[i][j][2] == referenceCheck then
                        for k = 1 , numberSlots do
                            table.insert ( GRM_AddonSettings_Save[i][j][2] , expansionType );
                        end
                    end
                end
            end
        end
    end
end

-- Introduced patch R1.142
-- Method:          GRM_Patch.ModifyNewDefaultSetting ( int , object )
-- What it Does:    Modifies the given setting based on the index point in the settings with the new given setting
-- Purpose:         To create a universally reusable patcher.
GRM_Patch.ModifyNewDefaultSetting = function ( index , newSetting )
    for i = 1 , #GRM_AddonSettings_Save do
        for j = #GRM_AddonSettings_Save[i] , 2 , -1 do
            if GRM_AddonSettings_Save[i][j][2] ~= nil and GRM_AddonSettings_Save[i][j][2][index] ~= nil then
                GRM_AddonSettings_Save[i][j][2][index] = newSetting;
            else
                table.remove ( GRM_AddonSettings_Save[i] , j );

                -- Double check if it is current player still is found
                local isFound = false;
                for k = 2 , #GRM_AddonSettings_Save[FID] do
                    if GRM_AddonSettings_Save[FID][k][1] == GRM_G.addonUser then
                        isFound = true;
                        break;
                    end
                end
                if not isFound then -- Edge case scenario of addon settings being lost thus are replaced with defaults.
                    table.insert ( GRM_AddonSettings_Save[FID] , { GRM_G.addonUser } );
                    PID = #GRM_AddonSettings_Save[FID];
                    table.insert ( GRM_AddonSettings_Save[FID][PID] , GRM_Patch.GetDefaultAddonSettings() );
                    GRM_G.IsNewToon = true;
                    -- Forcing core log window/options frame to load on the first load ever as well
                    GRM_G.ChangesFoundOnLoad = true;
                end
            end
        end
    end
end

-- Introduced patch R1.144
-- Method:          GRM_Patch.FixBrokenLanguageIndex()
-- What it does:    Checks if the index value is set to zero, which it should not, but if it is, defaults it to 1 for English
-- Purpose:         Due to an unforeseen circumstance, the placeholder value of zero, which represents no language, could be pulled before setting was established, thus breaking load.
GRM_Patch.FixBrokenLanguageIndex = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if GRM_AddonSettings_Save[i][j][2][43] == 0 then
                if GRM_G.Region == "" or GRM_G.Region == "enUS" or GRM_G.Region == "enGB" then
                    GRM_AddonSettings_Save[i][j][2][43] = 1;
                elseif GRM_G.Region == "deDE" then
                    GRM_AddonSettings_Save[i][j][2][43] = 2;
                elseif GRM_G.Region == "frFR" then
                    GRM_AddonSettings_Save[i][j][2][43] = 3;
                elseif GRM_G.Region == "itIT" then
                    GRM_AddonSettings_Save[i][j][2][43] = 4;
                elseif GRM_G.Region == "ruRU" then
                    GRM_AddonSettings_Save[i][j][2][43] = 5;
                elseif GRM_G.Region == "esMX" then
                    GRM_AddonSettings_Save[i][j][2][43] = 6;
                elseif GRM_G.Region == "esES" then
                    GRM_AddonSettings_Save[i][j][2][43] = 7;
                elseif GRM_G.Region == "ptBR" then
                    GRM_AddonSettings_Save[i][j][2][43] = 8;
                elseif GRM_G.Region == "koKR" then
                    GRM_AddonSettings_Save[i][j][2][43] = 9;
                elseif GRM_G.Region == "zhCN" then
                    GRM_AddonSettings_Save[i][j][2][43] = 10;
                elseif GRM_G.Region == "zhTW" then
                    GRM_AddonSettings_Save[i][j][2][43] = 11;
                else
                    GRM_AddonSettings_Save[i][j][2][43] = 1;        -- To default back to...
                end
            end
        end
    end
end

-- Method:          GRM_Patch.SetProperFontIndex();
-- What it Does:    Sets the defautl font index to their selected language.
-- Purpose:         On introduction of the fonts, this sets the font index in the saves properly...
GRM_Patch.SetProperFontIndex = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if GRM_AddonSettings_Save[i][j][2][43] ~= nil then
                GRM_AddonSettings_Save[i][j][2][44] = GRML.GetFontChoiceIndex( GRM_AddonSettings_Save[i][j][2][43] , GRM_AddonSettings_Save[i][j][2][43] );
            else
                GRM_AddonSettings_Save[i][j][2][44] = GRML.GetFontChoiceIndex( 1 , 1 );
            end
        end
    end
end

-- Method:          GRM_Patch.ConfigureMiscForPlayer( string );
-- What it Does:    Builds a file for tracking active data that can be reference back to on a relog... so as to mark where to carry on from
-- Purpose:         In case a player logs out in the middle of critical things, both front and backend, it has a marker stored on where to restart from.
GRM_Patch.ConfigureMiscForPlayer = function( playerFullName )
    table.insert ( GRM_Misc , {
        playerFullName,                                 -- 1) Name
        {},                                             -- 2) To hold the details on Added Friends that might need to be removed from recruit list (if added and player logged in that 1 second window)
        {},                                             -- 3) Same as above, except now in regards to the Players who left the guild check
        {},                                             -- 4) GUID rebuild check - former member, by adding to friends list you can rebuild GUID
        "",                                             -- 5) ""
        "",                                             -- 6) ""
        0                                               -- 7) ""
    } );
end

-- R1.147
-- Method:          GRM_Patch.SetMiscConfiguration()
-- What it Does:    Configures the new save file by making a uniqe index for each toon already saved
-- Purpose:         To be able to save a player the headache of incomplete tasks that need a marker on where to carryon from where it was left off.
GRM_Patch.SetMiscConfiguration = function()
    -- Reset it just in case...
    GRM_Misc = {};
    -- Now to add for each player...
    for i = 1 , #GRM_PlayerListOfAlts_Save do
        for j = 2 , #GRM_PlayerListOfAlts_Save[i] do
            for r = 2 , #GRM_PlayerListOfAlts_Save[i][j] do
                GRM_Patch.ConfigureMiscForPlayer ( GRM_PlayerListOfAlts_Save[i][j][r][1] );
            end
        end
    end
end

-- Added patch 1.148
-- Method:          GRM_Patch.ModifyPlayerMetadata ( int , object , boolean , int )
-- What it Does:    Allows the player to modify the metadata for ALL profiles in every guild in the database with one method
-- Purpose:         One function to rule them all! Keep code bloat down.
GRM_Patch.ModifyPlayerMetadata = function ( index , newValue , toArraySetting , arrayIndex )
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if not toArraySetting then
                    GRM_GuildMemberHistory_Save[i][j][r][index] = newValue;
                else
                    GRM_GuildMemberHistory_Save[i][j][r][index][arrayIndex] = newValue;
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if not toArraySetting then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][index] = newValue;
                else
                    GRM_PlayersThatLeftHistory_Save[i][j][r][index][arrayIndex] = newValue;
                end
            end
        end
    end

    -- Need backup info to be modified as well...
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                if not toArraySetting then
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][index] = newValue;
                                else
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][index][arrayIndex] = newValue;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


-- Added patch 1.20
-- Method:          GRM_Patch.AddPlayerMetaDataSlot ( int , object )
-- What it Does:    Allows the player to insert into the metadata for ALL profiles in every guild in the database with one method
-- Purpose:         One function to rule them all! Keep code bloat down.
GRM_Patch.AddPlayerMetaDataSlot = function ( previousMaxIndex , newValue )
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if #GRM_GuildMemberHistory_Save[i][j][r] == previousMaxIndex then
                    table.insert ( GRM_GuildMemberHistory_Save[i][j][r] , newValue );
                end
            end
        end
    end

    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if #GRM_PlayersThatLeftHistory_Save[i][j][r] == previousMaxIndex then
                    table.insert ( GRM_PlayersThatLeftHistory_Save[i][j][r] , newValue );
                end
            end
        end
    end

    -- Need backup info to be modified as well...
    local needsToBreak = false;
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do

                    needsToBreak = false;

                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            if GRM_GuildDataBackup_Save[i][j][s][m] ~= nil then
                                for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                    if #GRM_GuildDataBackup_Save[i][j][s][m][n] == previousMaxIndex then
                                        table.insert ( GRM_GuildDataBackup_Save[i][j][s][m][n] , newValue );
                                    end
                                end
                            else
                                -- Uh oh... backup corrupted?
                                GRM_GuildDataBackup_Save[i][j] = { GRM_GuildDataBackup_Save[i][j][1] , {} };
                                needsToBreak = true;
                                break;
                            end
                        end
                    end
                    if needsToBreak then
                        break;
                    end

                end
            end
        end
    end
end

-- Introduced patch R1.148
-- Method:          GRM_Patch.AddNewDefaultSetting ( int , object , boolean )
-- What it Does:    Modifies the given setting based on the index point in the settings with the new given setting
-- Purpose:         To create a universally reusable patcher.
GRM_Patch.AddNewDefaultSetting = function ( index , newSetting , isArray )
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if not isArray then
                GRM_AddonSettings_Save[i][j][2][index] = newSetting;
            else
                table.insert ( GRM_AddonSettings_Save[i][j][2][index] , newSetting );
            end
        end
    end
end

-- patch R1.148
-- Method:          GRM_Patch.SetProperRankRestrictions()
-- What it Does:    Sets the ban list rank and custom note rank to match overall sync filter rank, if necessary
-- Purpose:         Clarity for the addon user on rank filtering.
GRM_Patch.SetProperRankRestrictions = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            -- If ban List rank restriction is not right then set it to proper default
            if GRM_AddonSettings_Save[i][j][2][22] > GRM_AddonSettings_Save[i][j][2][15] then
                GRM_AddonSettings_Save[i][j][2][22] = GRM_AddonSettings_Save[i][j][2][15];
            end

            -- Same with custom note
            if GRM_AddonSettings_Save[i][j][2][49] > GRM_AddonSettings_Save[i][j][2][15] then
                GRM_AddonSettings_Save[i][j][2][49] = GRM_AddonSettings_Save[i][j][2][15];
            end
        end
    end
end

-- patch R1.1482
-- Method:          GRM_Patch.FixAltData()
-- What it Does:    Goes to every saved player and changes a boolean to a today's timestamp
-- Purpose:         There was some sync code that erroneously added a boolean instead of the epoch time stamp for when a player's alt was modified. This fixes that problem
-- Limitation:      This has potential to overwrite some other's data if it hasn't sync'd in a while, but it is unlikely to be an issue for 99% of the population.
GRM_Patch.FixAltData = function()
    local timestamp = time();
    for i = 1 , #GRM_GuildMemberHistory_Save do                                 -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                          -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do                   -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                -- Alt list
                for k = 1 , #GRM_GuildMemberHistory_Save[i][j][r][11] do        -- the alt lists each player in the guild
                    if type ( GRM_GuildMemberHistory_Save[i][j][r][11][k][6] ) == "boolean" then
                        GRM_GuildMemberHistory_Save[i][j][r][11][k][6] = timestamp;
                    end
                end
                -- Alt Removed List
                for k = 1 , #GRM_GuildMemberHistory_Save[i][j][r][37] do        -- the alt lists each player in the guild
                    if type ( GRM_GuildMemberHistory_Save[i][j][r][37][k][6] ) == "boolean" then
                        GRM_GuildMemberHistory_Save[i][j][r][37][k][6] = timestamp;
                    end
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                for k = 1 , #GRM_PlayersThatLeftHistory_Save[i][j][r][11] do        -- the alt lists each player in the guild
                    if type ( GRM_PlayersThatLeftHistory_Save[i][j][r][11][k][6] ) == "boolean" then
                        GRM_PlayersThatLeftHistory_Save[i][j][r][11][k][6] = timestamp;
                    end
                end
                -- Alt Removed List
                for k = 1 , #GRM_PlayersThatLeftHistory_Save[i][j][r][37] do        -- the alt lists each player in the guild
                    if type ( GRM_PlayersThatLeftHistory_Save[i][j][r][37][k][6] ) == "boolean" then
                        GRM_PlayersThatLeftHistory_Save[i][j][r][37][k][6] = timestamp;
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.RemoveGuildBackup ( string , string , int , string , boolean )
-- What it Does:    Removes a Backup Point for the guild...
-- Purpose:         Database Backup Management
GRM_Patch.RemoveGuildBackup = function( guildName , creationDate , factionInd , backupPoint , reportChange )
    if GRM_G.DebugEnabled then
        GRM.AddDebugMessage ( time() .. "GRM_Patch.RemoveGuildBackup()?" .. guildName .. "?" .. creationDate .. "?" .. backupPoint );
    end

    local forcedForm = 0;
    if UnitFactionGroup ( "PLAYER" ) == "Horde"  then
        forcedForm = GRM_AddonSettings_Save["H"][GRM_G.addonUser].dateFormat;
    else
        forcedForm = GRM_AddonSettings_Save["A"][GRM_G.addonUser].dateFormat;
    end

    if string.find ( guildName , "-" ) ~= nil then
        for i = 2 , #GRM_GuildDataBackup_Save[factionInd] do
            if type ( GRM_GuildDataBackup_Save[factionInd][i][1] ) == "table" then
                if GRM_GuildDataBackup_Save[factionInd][i][1][1] == guildName then
                    for j = 2 , #GRM_GuildDataBackup_Save[factionInd][i] do
                        if GRM_GuildDataBackup_Save[factionInd][i][j][1] ~= nil and GRM.FormatTimeStamp ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , true  , false , forcedForm ) == backupPoint then
                            if reportChange then
                                GRM.Report ( "|CFFFFD100" .. GRM.L ( "Backup Point Removed for Guild \"{name}\"" , guildName ) );
                            end
                            if string.find ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , "AUTO_" ) ~= nil then
                                GRM_GuildDataBackup_Save[factionInd][i][j] = {};
                            else
                                table.remove ( GRM_GuildDataBackup_Save[factionInd][i] , j );
                            end
                            break;
                        end
                    end
                    break;
                end
            elseif type ( GRM_GuildDataBackup_Save[factionInd][i][1] ) == "string" then
                if GRM_GuildDataBackup_Save[factionInd][i][1] == guildName then
                    for j = 2 , #GRM_GuildDataBackup_Save[factionInd][i] do
                        if GRM_GuildDataBackup_Save[factionInd][i][j][1] ~= nil and GRM.FormatTimeStamp ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , true  , false , forcedForm ) == backupPoint then
                            if reportChange then
                                GRM.Report ( "|CFFFFD100" .. GRM.L ( "Backup Point Removed for Guild \"{name}\"" , guildName ) );
                            end
                            if string.find ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , "AUTO_" ) ~= nil then
                                GRM_GuildDataBackup_Save[factionInd][i][j] = {};
                            else
                                table.remove ( GRM_GuildDataBackup_Save[factionInd][i] , j );
                            end
                            break;
                        end
                    end
                    break;
                end
            end
        end
    else
        for i = 2 , #GRM_GuildDataBackup_Save[factionInd] do
            if type ( GRM_GuildDataBackup_Save[factionInd][i][1] ) == "table" then
                if GRM_GuildDataBackup_Save[factionInd][i][1][1] == guildName and GRM_GuildDataBackup_Save[factionInd][i][1][2] == creationDate then
                    for j = 2 , #GRM_GuildDataBackup_Save[factionInd][i] do
                        if GRM_GuildDataBackup_Save[factionInd][i][j][1] ~= nil and GRM.FormatTimeStamp ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , true , false , forcedForm  ) == backupPoint then
                            if reportChange then
                                GRM.Report ( "|CFFFFD100" .. GRM.L ( "Backup Point Removed for Guild \"{name}\"" , guildName ) );
                            end
                            if string.find ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , "AUTO_" ) ~= nil then
                                GRM_GuildDataBackup_Save[factionInd][i][j] = {};
                            else
                                table.remove ( GRM_GuildDataBackup_Save[factionInd][i] , j );
                            end
                            break;
                        end
                    end
                    break;
                end
            else
                if GRM_GuildDataBackup_Save[factionInd][i][1] == guildName then
                    for j = 2 , #GRM_GuildDataBackup_Save[factionInd][i] do
                        if GRM_GuildDataBackup_Save[factionInd][i][j][1] ~= nil and GRM.FormatTimeStamp ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , true  , false , forcedForm ) == backupPoint then
                            if reportChange then
                                GRM.Report ( "|CFFFFD100" .. GRM.L ( "Backup Point Removed for Guild \"{name}\"" , guildName ) );
                            end
                            if string.find ( GRM_GuildDataBackup_Save[factionInd][i][j][1] , "AUTO_" ) ~= nil then
                                GRM_GuildDataBackup_Save[factionInd][i][j] = {};
                            else
                                table.remove ( GRM_GuildDataBackup_Save[factionInd][i] , j );
                            end
                            break;
                        end
                    end
                    break;
                end
            end
        end
    end
end


-- Method:          GRM_Patch.RemoveAllAutoBackups()
-- What it Does:    Removes all autobackups for all guilds both factions
-- Purpose:         Due to a flaw in the way auto-saved backups were added, this is now fixed.
GRM_Patch.RemoveAllAutoBackups = function()
    local tempBackup = GRM_GuildDataBackup_Save;
    for i = 1 , #tempBackup do
        for j = 2 , #tempBackup[i] do
            -- find a guild, then find if there are any autobackups...
            for s = 2 , 3 do
                if tempBackup[i][j][s] ~= nil and #tempBackup[i][j][s] > 0 then
                    -- We found a backup!!! Let's remove it!!!
                    if type ( tempBackup[i][j][1] ) == "table" then
                        GRM_Patch.RemoveGuildBackup ( tempBackup[i][j][1][1] , tempBackup[i][j][1][2] , i , tempBackup[i][j][s][1] , false );
                    else
                        GRM_Patch.RemoveGuildBackup ( tempBackup[i][j][1] , "Unknown" , i , tempBackup[i][j][s][1] , false );
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.CleanupAnniversaryEvents()
-- What it Does:    Due to an error with syncing alt join date data, this cleanus up the string for proper format
-- Purpose:         So players are properly reported for anniversary reminders.
GRM_Patch.CleanupAnniversaryEvents = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if GRM_GuildMemberHistory_Save[i][j][r][22][1][2] ~= nil then
                    if type ( GRM_GuildMemberHistory_Save[i][j][r][22][1][2] ) == "string" then
                        local tempString = string.gsub ( GRM_GuildMemberHistory_Save[i][j][r][22][1][2] , "Joined: " , "" );
                        GRM_GuildMemberHistory_Save[i][j][r][22][1][2] = string.sub ( tempString , 1 , string.find ( tempString , "'" ) + 2 );
                    end
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if GRM_PlayersThatLeftHistory_Save[i][j][r][22][1][2] ~= nil then
                    if type ( GRM_PlayersThatLeftHistory_Save[i][j][r][22][1][2] ) == "string" then
                        local tempString = string.gsub ( GRM_PlayersThatLeftHistory_Save[i][j][r][22][1][2] , "Joined: " , "" );
                        GRM_PlayersThatLeftHistory_Save[i][j][r][22][1][2] = string.sub ( tempString , 1 , string.find ( tempString , "'" ) + 2 );
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.RemoveTitlesEventDataAndUpdateBirthday()
-- What it Does:    Due to a change in the way the events (birthday, anniversary, custom) are handled, and for localization reasons, this "title" can be removed
-- Purpose:         Updating the database to prevent old errors from old databases.
GRM_Patch.RemoveTitlesEventDataAndUpdateBirthday = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                for s = 1 , 2 do
                    if #GRM_GuildMemberHistory_Save[i][j][r][22][s] == 4 and type ( GRM_GuildMemberHistory_Save[i][j][r][22][s][3] ) == "boolean" then
                        table.remove ( GRM_GuildMemberHistory_Save[i][j][r][22][s] , 1 );
                    end
                    if s == 2 and #GRM_GuildMemberHistory_Save[i][j][r][22][s] == 3 then
                        table.insert ( GRM_GuildMemberHistory_Save[i][j][r][22][s] , 0 );       -- extra index for the timestamp of the change
                    end
                end
            end
        end
    end

    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                for s = 1 , 2 do
                    if #GRM_PlayersThatLeftHistory_Save[i][j][r][22][s] == 4 and type ( GRM_PlayersThatLeftHistory_Save[i][j][r][22][s][3] ) == "boolean" then
                        table.remove ( GRM_PlayersThatLeftHistory_Save[i][j][r][22][s] , 1 );
                    end
                    if s == 2 and #GRM_PlayersThatLeftHistory_Save[i][j][r][22][s] == 3 then
                        table.insert ( GRM_PlayersThatLeftHistory_Save[i][j][r][22][s] , 0 );
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.UpdateCalendarEventsDatabase()
-- What it Does:    Checks the oldEventsDatabase and adds an eventTypeIndex identifier at the end. In this case, a 1 because ONLY anniversaries have ever been documented
-- Purpose:         To enable all new features to be implemented with the events log and the elimination of errors that will occur with new database changes.
GRM_Patch.UpdateCalendarEventsDatabase = function()
    for i = 1 , #GRM_CalendarAddQue_Save do
        for j = 2 , #GRM_CalendarAddQue_Save[i] do
            for r = 2 , #GRM_CalendarAddQue_Save[i][j] do
                if #GRM_CalendarAddQue_Save[i][j][r] == 6 then
                    table.insert ( GRM_CalendarAddQue_Save[i][j][r] , 1 );
                end
            end
        end
    end
end

-- Method:          GRM_Patch.MatchLanguageTo24HrFormat()
-- What it Does:    Checks the selected language then defaults to 24hr scale or 12hr scale
-- Purpose:         Auto-configure what is the popular hour/min format for the day based on the language preference.
GRM_Patch.MatchLanguageTo24HrFormat = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if GRM_AddonSettings_Save[i][j][2][43] == 1 or GRM_AddonSettings_Save[i][j][2][43] == 6 then         -- 2 German, 3 French default to 24hr scale, the rest 12hr.
                GRM_AddonSettings_Save[i][j][2][39] = false;
            else
                GRM_AddonSettings_Save[i][j][2][39] = true;
            end
        end
    end
end

-- Method:          GRM_Patch.FixBanListNameGrammar()
-- What it Does:    Corrects any ill added names through the manual ban system and corrects their format
-- Purpose:         Human error protection retroactive that is now implemented live.
GRM_Patch.FixBanListNameGrammar = function()
    -- Only need to do this for non-Asian languages.
    if GRM_AddonSettings_Save[FID][PID][2][43] < 9 then
        -- need to update the left player's database too...
        for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
            for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
                for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                    local server = string.sub ( GRM_PlayersThatLeftHistory_Save[i][j][r][1] , string.find ( GRM_PlayersThatLeftHistory_Save[i][j][r][1] , "-" ) + 1 );
                    GRM_PlayersThatLeftHistory_Save[i][j][r][1] = GRM.FormatInputName ( GRM.SlimName ( GRM_PlayersThatLeftHistory_Save[i][j][r][1] ) ) .. "-" .. server;
                end
            end
        end
    end
end

-- Method:          GRM_Patch.RemoveDouble ( table )
-- What it Does:    Iterates through the roster and finds all copies and removes them
-- Purpose:         Fixing a coding flaw
GRM_Patch.RemoveDouble = function ( finalStepTable )
    local t = finalStepTable;
    local i , c , r = 2 , 2 , 2;
    while i <= #t do
        c = 0;
        local n = t[i][1];
        for j = 2 , #t do
            if t[j][1] == n then
                c = c + 1;
                if c > 1 then
                    r = j;
                    break;
                end;
            end;
        end;
        if c > 1 then
            table.remove ( t , r );
        else
            i = i + 1;
        end;
    end
end

-- Methhod:         GRM_Patch.FixDoubleCopiesOfData ( array )
-- What it Does:    Fixes the database given to it of left or joined players
-- Purpose:         Reusuable logic depending on the selected database of choice.
GRM_Patch.FixDoubleCopiesOfData = function ( dataTable )
    for j = 1 , #dataTable do
        for s = 2 , #dataTable[j] do

            GRM_Patch.RemoveDouble ( dataTable[j][s] );

        end
    end
end

-- Method:          GRM_Patch.FixDoubleCopiesInLeftPLayers()
-- What it Does:    Cleans up the left players for double copies which could have happened with the ban list.
-- Purpose:         Fix an error in the code from patch 1.1530 in the ban list modification updates.
GRM_Patch.FixDoubleCopiesInLeftPLayers = function()
    GRM_Patch.FixDoubleCopiesOfData ( GRM_PlayersThatLeftHistory_Save );
end

-- Method:          GRM_Patch.FixDoubleCopiesInCurrentGuilds()
-- What it Does:    Cleans up the current players for double copies which could have happened with a previous flaw in a recent update.
-- Purpose:         Fix database error.
GRM_Patch.FixDoubleCopiesInCurrentGuilds = function()
    GRM_Patch.FixDoubleCopiesOfData ( GRM_GuildMemberHistory_Save );
end

-- Method:          GRM_Patch.FixDoubleCopiesInBackup()
-- What it Does:    Fixes the lingering issue in the backups as well
-- Purpose:         Fixes coding flaw that allowed a double entry
GRM_Patch.FixDoubleCopiesInBackup = function()
    local needsToBreak = false;
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do

                    needsToBreak = false;

                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            if GRM_GuildDataBackup_Save[i][j][s][m] ~= nil then
                                -- Logic to remove the doubles in a whie loop
                                GRM_Patch.RemoveDouble ( GRM_GuildDataBackup_Save[i][j][s][m] );

                            else
                                -- Uh oh... backup corrupted?
                                GRM_GuildDataBackup_Save[i][j] = { GRM_GuildDataBackup_Save[i][j][1] , {} };
                                needsToBreak = true;
                                break;
                            end
                        end
                    end
                    if needsToBreak then
                        break;
                    end

                end
            end
        end
    end
end

-- Method:          GRM_Patch.RemoveAltCopies()
-- What it Does:    Removes any instance or copy of a player due to the merging of the database
-- PurposE:         To cleanup the mistake of a coding error in an earlier build...
GRM_Patch.RemoveAltCopies = function()
    for i = 1 , #GRM_PlayerListOfAlts_Save do
        for j = 2 , #GRM_PlayerListOfAlts_Save[i] do
            for r = #GRM_PlayerListOfAlts_Save[i][j] , 2 , -1  do
                -- Cycling through all the guildies now.
                for k = #GRM_PlayerListOfAlts_Save[i][j] , 2 , -1 do
                    if r ~= k and GRM_PlayerListOfAlts_Save[i][j][r][1] == GRM_PlayerListOfAlts_Save[i][j][k][1] then
                        table.remove ( GRM_PlayerListOfAlts_Save[i][j] , k );
                        break;
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.DoAltListIntegrityCheckAndCleanup()
-- What it Does:    Checks for nil entries, removes them
-- Purpose:         Cleanup the database in case of errors.
GRM_Patch.DoAltListIntegrityCheckAndCleanup = function()
    for i = 1 , #GRM_PlayerListOfAlts_Save do
        for j = #GRM_PlayerListOfAlts_Save[i] , 2 , -1 do -- Cycle backwards in case of index remove.
            if GRM_PlayerListOfAlts_Save[i][j] == nil then
                table.remove ( GRM_PlayerListOfAlts_Save[i] , j );
            else
                for r = #GRM_PlayerListOfAlts_Save[i][j] , 2 , -1 do    -- Cycle backwards in case of index remove.
                    if GRM_PlayerListOfAlts_Save[i][j][r] == nil then
                        table.remove ( GRM_PlayerListOfAlts_Save[i][j] , r );
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.FixPlayerListOfAltsDatabase()
-- What it Does:    Fixes the double guild references left over from a database conversion in the alts list
-- Purpose:         when trying to sync settings between alts, the list tree of alts was split between multiple references of the guild. This clears that up.
GRM_Patch.FixPlayerListOfAltsDatabase = function()
    local isMatch = false;
    local guildName = "";
    local isProper = false;
    GRM_Patch.DoAltListIntegrityCheckAndCleanup(); -- Important to do this first...

    for i = 1 , #GRM_PlayerListOfAlts_Save do
        for j = #GRM_PlayerListOfAlts_Save[i] , 2 , -1 do   -- Cycle backwards...
            -- Look for matches within the guilds.
            -- Get name of the guild considering new and old database...
            guildName = "";
            isProper = false;
            isMatch = false;
            if type(GRM_PlayerListOfAlts_Save[i][j][1]) == "table" then
                guildName = GRM_PlayerListOfAlts_Save[i][j][1][1];
            elseif type(GRM_PlayerListOfAlts_Save[i][j][1]) == "string" then
                guildName = GRM_PlayerListOfAlts_Save[i][j][1];
            end

            if string.find ( guildName , "-" ) ~= nil then              -- If it has a yphen, it's a new database guild, it is the one we want.
                isProper = true;
            end

            -- Need to purge the double if 2x outdated...
            if not isProper then
                -- The guild name does not have the server name attached.
                for r = #GRM_PlayerListOfAlts_Save[i] , 2 , -1 do
                    if r ~= j then
                        if type ( GRM_PlayerListOfAlts_Save[i][r][1] ) == "table" and GRM.SlimName ( GRM_PlayerListOfAlts_Save[i][r][1][1] ) == guildName then
                            -- guild match with a propper guild
                            if string.find ( GRM_PlayerListOfAlts_Save[i][r][1][1] , "-" ) ~= nil then
                                isMatch = true;
                            end
                        elseif type ( GRM_PlayerListOfAlts_Save[i][r][1] ) == "string" and GRM.SlimName ( GRM_PlayerListOfAlts_Save[i][r][1] ) == guildName then
                            if string.find ( GRM_PlayerListOfAlts_Save[i][r][1] , "-" ) ~= nil then
                                isMatch = true;
                            end
                        end

                        -- Now, need to copy my databse over to this proper one...
                        if isMatch then
                            for k = 2 , #GRM_PlayerListOfAlts_Save[i][j] do
                                table.insert ( GRM_PlayerListOfAlts_Save[i][r] , GRM_PlayerListOfAlts_Save[i][j][k] );
                            end
                            -- Now remove the unpropper guild.
                            table.remove ( GRM_PlayerListOfAlts_Save[i] , j );
                            break;
                        end
                    end
                end

                if not isMatch then
                    -- if not a match, then let's just leave the guild name and purge the reset
                    while #GRM_PlayerListOfAlts_Save[i][j] > 1 do
                        table.remove ( GRM_PlayerListOfAlts_Save[i][j] , 2 );
                    end
                end
            else
                -- Now, determine if there is a match
                for r = #GRM_PlayerListOfAlts_Save[i] , 2 , -1 do         -- cycle through the guilds...
                    if r ~= j then                                              -- make sure it is not the same
                        if type ( GRM_PlayerListOfAlts_Save[i][r][1] ) == "table" and GRM.SlimName ( GRM_PlayerListOfAlts_Save[i][r][1][1] ) == GRM.SlimName ( guildName ) then
                            -- guild match with a propper guild
                            if string.find ( GRM_PlayerListOfAlts_Save[i][r][1][1] , "-" ) ~= nil then
                                isMatch = true;
                            end
                        elseif type ( GRM_PlayerListOfAlts_Save[i][r][1] ) == "string" and GRM.SlimName ( GRM_PlayerListOfAlts_Save[i][r][1] ) == GRM.SlimName ( guildName ) then
                            if string.find ( GRM_PlayerListOfAlts_Save[i][r][1] , "-" ) ~= nil then
                                isMatch = true;
                            end
                        end

                        -- Now, need to copy my databse over to this proper one...
                        if isMatch then
                            for k = 2 , #GRM_PlayerListOfAlts_Save[i][r] do
                                table.insert ( GRM_PlayerListOfAlts_Save[i][j] , GRM_PlayerListOfAlts_Save[i][r][k] );
                            end
                            -- Now remove the unpropper guild.
                            table.remove ( GRM_PlayerListOfAlts_Save[i] , r );
                            break;
                        end
                    end
                end
            end
        end
    end

    -- Now, need to purge the copies...
    GRM_Patch.RemoveAltCopies();
end

-- Added in patch 1.26
-- StreamViewMarker is setting an "Unread Messages" marker.
GRM_Patch.AddStreamViewMarker = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do
            if #GRM_GuildMemberHistory_Save[i][j][1] == 4 then
                table.insert ( GRM_GuildMemberHistory_Save[i][j][1] , 0 );      -- Initially set to zero the first time...
            end
        end
    end

    for i = 1 , #GRM_GuildDataBackup_Save do
        for j = 2 , #GRM_GuildDataBackup_Save[i] do
            for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                if #GRM_GuildDataBackup_Save[i][j][s] > 0 and #GRM_GuildDataBackup_Save[i][j][s][3][1] == 4 then
                    table.insert ( GRM_GuildDataBackup_Save[i][j][s][3][1] , 0 );
                end
            end
        end
    end
end

-- Added in patch 1.26
-- Noticed an issue with only 1 format
GRM_Patch.PratCompatibilityCheck = function()
    if GRM.IsAddOnLoaded("Prat-3.0") then
        for i = 1 , #GRM_AddonSettings_Save do
            for j = 2 , #GRM_AddonSettings_Save[i] do
                if GRM_AddonSettings_Save[i][j][2][42] == 1 then
                    GRM_AddonSettings_Save[i][j][2][42] = 2;
                elseif GRM_AddonSettings_Save[i][j][2][42] == 3 then
                    GRM_AddonSettings_Save[i][j][2][42] = 4;
                end
            end
        end
    end
end

-- Introduced patch R1.28
-- Method:          GRM_Patch.ModifyNoteSavedSettings()
-- What it Does:    Converts the boolean saved variable to an int, so I can have a 1,2, or 3 for public, officer, custom note options
-- Purpose:         To adapt the old database to new UI configuration options without creating a new index or needlessly complicating the code.
GRM_Patch.ModifyNoteSavedSettings = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if GRM_AddonSettings_Save[i][j][2][20] == true then
                GRM_AddonSettings_Save[i][j][2][20] = 1;
            elseif GRM_AddonSettings_Save[i][j][2][20] == false then
                GRM_AddonSettings_Save[i][j][2][20] = 2;
            end
        end
    end
end

-- Introduced patch 1.29
-- Method:          GRM_Patch.LogDatabaseRepair()
-- What it Does:    Looks for a code when searching in a string that can cause WOW to freeze and removes the string
-- Purpose:         Mature language filter cause some weird censored strings to build on save, which messaged up when trying to parse through em that could freeze WOW. This cleans that up
GRM_Patch.LogDatabaseRepair = function()
    for i = 1 , #GRM_LogReport_Save do
        for j = 2 , #GRM_LogReport_Save[i] do
            for k = #GRM_LogReport_Save[i][j] , 2 , -1 do   -- Increment in reverse down as you will possibly be removing a bunch of error'd messages.
                if string.find ( GRM_LogReport_Save[i][j][k][2] , "\000" ) ~= nil then
                    table.remove ( GRM_LogReport_Save[i][j] , k );
                end
            end
        end
    end
end

-- Introduced patch 1.31
-- Method:          GRM_Patch.FixCustomMinimapPosition()
-- Method:          If custom position was set in 1.30, it now removes it and resets position...
-- Purpose:         There was an error in the R1.30 release that sync'd settings erroneously that needed to be resolved
GRM_Patch.FixCustomMinimapPosition = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if GRM_AddonSettings_Save[i][j][2][63] then
                GRM_AddonSettings_Save[i][j][2][63] = false;
                GRM_AddonSettings_Save[i][j][2][26] = 78;
                GRM_AddonSettings_Save[i][j][2][25] = 345;
            end
        end
    end
end

-- This should only be done if you are the officer...
-- Intoduced 1.32
-- Method:          GRM_Patch.ConvertLeaderNoteControlFormatToGuildInfo()
-- What it Does:    It looks for the 2 codes, removes them from the public or officer note, and then adds them to guild info.
-- Purpose:         Cleanup for new feature!
GRM_Patch.ConvertLeaderNoteControlFormatToGuildInfo = function()
    -- No need to do the work if you can't!
    local result = "";
    if GRM.CanEditOfficerNote() then
        local g1 = false;
        local g2 = false;

        for i = 1 , GRM.GetNumGuildies() do
            -- For guild info
            local rankInd , _ , _ , _ , note , officerNote = select ( 3 , GetGuildRosterInfo ( i ) );

            if rankInd == 0 then
                -- Guild Leader identified!
                -- first, let's look for grm1, if it's there, let's get rid of it.
                -- make it easier to match the case.

                local ind , ind2 = 0 , 0;
                local msg = "";
                for j = 1 , 2 do
                    if j == 1 then
                        msg = note;
                    else
                        msg = officerNote;
                    end

                    ind = string.find ( msg , "grm1" );

                    -- Checking the public note
                    local num;
                    local sign;

                    if ind ~= nil then      -- grm1!!
                        num = ind;
                        sign = string.sub ( msg , num - 1 , num - 1 );

                        -- we found a note!
                        if sign ~= nil and ( sign == "+" or sign == "-" ) then
                            -- Note is valid! Convert and add it to result!
                            if not g1 then
                                result = "g1^" .. sign .. "_" .. result;
                                g1 = true;
                            end
                            -- Remove it from note now!
                            if j == 1 then
                                msg = string.gsub ( msg , sign .. "grm1" , "" );
                                GuildRosterSetPublicNote ( i , GRM.Trim( msg ) );
                            else
                                msg = string.gsub ( msg , sign .. "grm1" , "" );
                                GuildRosterSetOfficerNote ( i , GRM.Trim( msg ) );
                            end
                        end;
                    end

                    ind2 = select ( 2 , string.find ( msg , "g2^" ) );
                    if ind2 ~= nil then     -- g2^!!
                        num = ind2;
                        sign = string.sub ( msg , num + 1 , num + 1 );

                        -- we found a note!
                        if sign ~= nil and tonumber ( sign ) ~= nil then
                            -- Note is valid! Convert and add it to result!
                            if not g2 then
                                result = result .. "g2^" .. sign;
                                g2 = true;
                            end
                            -- Remove it from note now!
                            if j == 1 then
                                msg = string.gsub ( msg , "g2^" .. sign , "" );
                                GuildRosterSetPublicNote ( i , GRM.Trim( msg ) );
                            else
                                msg = string.gsub ( msg , "g2^" .. sign , "" );
                                GuildRosterSetOfficerNote ( i , GRM.Trim( msg ) );
                            end
                        end;
                    end
                end
                break;
            end
        end
    end
    if result ~= "" then
        result = "\n\n" .. GRM.L ( "GRM:" ) .. "\n" .. string.gsub ( result , "_" , "\n" );
        local guildInfo = GetGuildInfoText();
        GRM.L ( "GRM has moved the Guild Leader setting restriction codes to the Guild Info tab." );
        if #guildInfo + #result <= 500 then
            SetGuildInfoText ( guildInfo .. result );
        else
            GRM.L ( "Please make room for them and re-add." );
        end
    end
end

-- Method:          GRM_Patch.ConvertAndModifyAnniversaryStorageFormat()
-- What it Does:    Converts the old string format to the new better storage format for anniversary dates
-- Purpose:         Better, cleaner scanning of events. Less parsing text
GRM_Patch.ConvertAndModifyAnniversaryStorageFormat = function()
    local date = {};
    local template = { { 0 , 0 , 0 } , false , "" };

    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if not GRM_GuildMemberHistory_Save[i][j][r][40] and #GRM_GuildMemberHistory_Save[i][j][r][20] > 0 then
                    date = GRM.ConvertGenericTimestampToIntValues ( GRM_GuildMemberHistory_Save[i][j][r][20][#GRM_GuildMemberHistory_Save[i][j][r][20]] );
                    if date ~= nil then
                        GRM_GuildMemberHistory_Save[i][j][r][22][1] = { { date[1] , date[2] , date[3] } , false , "" };
                    else
                        GRM_GuildMemberHistory_Save[i][j][r][20] = {};
                        GRM_GuildMemberHistory_Save[i][j][r][22][1] = template;
                    end
                else
                    GRM_GuildMemberHistory_Save[i][j][r][22][1] = template;
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if not GRM_PlayersThatLeftHistory_Save[i][j][r][40] and #GRM_PlayersThatLeftHistory_Save[i][j][r][20] > 0 then
                    date = GRM.ConvertGenericTimestampToIntValues ( GRM_PlayersThatLeftHistory_Save[i][j][r][20][#GRM_PlayersThatLeftHistory_Save[i][j][r][20]] );
                    if date ~= nil then
                        GRM_PlayersThatLeftHistory_Save[i][j][r][22][1] = { { date[1] , date[2] , date[3] } , false , "" };
                    else
                        GRM_PlayersThatLeftHistory_Save[i][j][r][20] = {};
                        GRM_PlayersThatLeftHistory_Save[i][j][r][22][1] = template;
                    end
                else
                    GRM_PlayersThatLeftHistory_Save[i][j][r][22][1] = template;
                end
            end
        end
    end

    -- Need backup info to be modified as well...
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                if not GRM_GuildDataBackup_Save[i][j][s][m][n][40] and #GRM_GuildDataBackup_Save[i][j][s][m][n][20] > 0 then
                                    date = GRM.ConvertGenericTimestampToIntValues ( GRM_GuildDataBackup_Save[i][j][s][m][n][20][#GRM_GuildDataBackup_Save[i][j][s][m][n][20]] );
                                    if date ~= nil then
                                        GRM_GuildDataBackup_Save[i][j][s][m][n][22][1] = { { date[1] , date[2] , date[3] } , false , "" };
                                    else
                                        GRM_GuildDataBackup_Save[i][j][s][m][n][20] = {};
                                        GRM_GuildDataBackup_Save[i][j][s][m][n][22][1] = template;
                                    end
                                else
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][22][1] = template;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- R1.34
-- Method:          GRM_Patch.EventDatabaseIntegrityCheckAndRebuild()
-- what it Does:    Checks if the anniversary date formatting has been properly reset, and if so, rebuilds it.
-- Purpose:         Patch 1.33 had some unexpected bugs and some people's databases did not convert. This resolves that.
GRM_Patch.EventDatabaseIntegrityCheckAndRebuild = function()
    if GRM_GuildMemberHistory_Save[FID][2][2][22][1][1] ~= nil and type ( GRM_GuildMemberHistory_Save[FID][2][2][22][1][1] ) == "table" and #GRM_GuildMemberHistory_Save[FID][2][2][22][1][1] == 3 then
        -- do nothing...
    else
        GRM_Patch.ConvertAndModifyAnniversaryStorageFormat();
        GRM_Patch.ModifyPlayerMetadata ( 22 , { { 0 , 0 , 0 } , false , "" , 0 } , true , 2 ); -- Modify member record details for birthday, resets it to base value
    end
end

-- R1.35
-- Method:          GRM_Patch.AltListRepeatAndSelfCleanup()
-- What it Does:    Removes all alt list copies and instances where main is listed as own alt.
-- Purpose:         Clean up the alt lists!
GRM_Patch.AltListRepeatAndSelfCleanup = function()
    local c = 1; -- C will be my reusable count variable.

    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                -- Ok, now we need to check the alt lists, parse through them, eliminate repeats, and instances the name matches the players name.
                if #GRM_GuildMemberHistory_Save[i][j][r][11] > 0 then
                    c = 1;
                    while c <= #GRM_GuildMemberHistory_Save[i][j][r][11] do
                        if GRM_GuildMemberHistory_Save[i][j][r][11][c][1] == nil or GRM_GuildMemberHistory_Save[i][j][r][11][c][1] == GRM_GuildMemberHistory_Save[i][j][r][1] then  -- if altName is playerName, they are listed as their own alt. Remove! Cleanup!
                            table.remove ( GRM_GuildMemberHistory_Save[i][j][r][11] , c );
                            c = c - 1;
                        else
                            for k = #GRM_GuildMemberHistory_Save[i][j][r][11] , c , -1 do
                                if k ~= c and ( GRM_GuildMemberHistory_Save[i][j][r][11][k][1] == nil or GRM_GuildMemberHistory_Save[i][j][r][11][c][1] == GRM_GuildMemberHistory_Save[i][j][r][11][k][1] ) then
                                    table.remove ( GRM_GuildMemberHistory_Save[i][j][r][11] , k );
                                end
                            end
                        end
                        c = c + 1;
                    end
                end
            end
        end
    end

    -- Left player history
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                -- Ok, now we need to check the alt lists, parse through them, eliminate repeats, and instances the name matches the players name.
                if #GRM_PlayersThatLeftHistory_Save[i][j][r][11] > 0 then
                    c = 1;
                    while c <= #GRM_PlayersThatLeftHistory_Save[i][j][r][11] do
                        if GRM_PlayersThatLeftHistory_Save[i][j][r][11][c][1] == nil or GRM_PlayersThatLeftHistory_Save[i][j][r][11][c][1] == GRM_PlayersThatLeftHistory_Save[i][j][r][1] then  -- if altName is playerName, they are listed as their own alt. Remove! Cleanup!
                            table.remove ( GRM_PlayersThatLeftHistory_Save[i][j][r][11] , c );
                            c = c - 1;
                        else
                            for k = #GRM_PlayersThatLeftHistory_Save[i][j][r][11] , c , -1 do
                                if k ~= c and ( GRM_PlayersThatLeftHistory_Save[i][j][r][11][k][1] == nil or GRM_PlayersThatLeftHistory_Save[i][j][r][11][c][1] == GRM_PlayersThatLeftHistory_Save[i][j][r][11][k][1] ) then
                                    table.remove ( GRM_PlayersThatLeftHistory_Save[i][j][r][11] , k );
                                end
                            end
                        end
                        c = c + 1;
                    end
                end
            end
        end
    end

    -- Backups
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                -- Now, do the work on the saved database...
                                if #GRM_GuildDataBackup_Save[i][j][s][m][n][11] > 0 then
                                    c = 1;
                                    while c <= #GRM_GuildDataBackup_Save[i][j][s][m][n][11] do
                                        if GRM_GuildDataBackup_Save[i][j][s][m][n][11][c][1] == nil or GRM_GuildDataBackup_Save[i][j][s][m][n][11][c][1] == GRM_GuildDataBackup_Save[i][j][s][m][n][1] then  -- if altName is playerName, they are listed as their own alt. Remove! Cleanup!
                                            table.remove ( GRM_GuildDataBackup_Save[i][j][s][m][n][11] , c );
                                            c = c - 1;
                                        else
                                            for k = #GRM_GuildDataBackup_Save[i][j][s][m][n][11] , c , -1 do
                                                if k ~= c and ( GRM_GuildDataBackup_Save[i][j][s][m][n][11][k][1] == nil or GRM_GuildDataBackup_Save[i][j][s][m][n][11][c][1] == GRM_GuildDataBackup_Save[i][j][s][m][n][11][k][1] ) then
                                                    table.remove ( GRM_GuildDataBackup_Save[i][j][s][m][n][11] , k );
                                                end
                                            end
                                        end
                                        c = c + 1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

--R1.35
-- Method:          GRM_Patch.FixEventCalendarAdvanceScanTimeFrame()
-- What it Does:    If the time to announce events in advance is greater than 28 it defaults it to 28
-- Purpose:         Issue where a setting was set to between 1 and 99 and should have been between 1 and 28, so some people had setting more in advance.
--                  This is problematic as the scanning is built to only go a max 1 month in advance, so to keep it clean it defaults to 4 weeks, or 28 days, which also happens
--                  to be the length of the shortest month, thus always ensuring 28 days is never greater than 1 month away (in other words 31 day month, Jan 30th, 31 days later = March 3rd, for example)
GRM_Patch.FixEventCalendarAdvanceScanTimeFrame = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if GRM_AddonSettings_Save[i][j][2][5] > 28 then
                GRM_AddonSettings_Save[i][j][2][5] = 28;
            end
        end
    end
end

--R1.39
-- Method:          GRM_Patch.CleanupErroneousSlashesInBanNames()
-- What it Does:    Due to a previous erroneous method where custom names with forward slash could be added, it removes any bad names like that.
-- Purpose:         Cleanup Left players lists
GRM_Patch.CleanupErroneousSlashesInBanNames = function()
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = #GRM_PlayersThatLeftHistory_Save[i][j] , 2 , - 1 do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if string.find ( GRM_PlayersThatLeftHistory_Save[i][j][r][1] , "/" ) ~= nil then
                    table.remove ( GRM_PlayersThatLeftHistory_Save[i][j] , r );
                end
            end
        end
    end
end

-- Added patch 1.39
-- Method:          GRM_Patch.AddBanSlotIndex ()
-- What it Does:    Allows the player to modify the metadata for ALL profiles in every guild in the database with one method
-- Purpose:         One function to rule them all! Keep code bloat down.
GRM_Patch.AddBanSlotIndex = function ()
    local table = {};
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                table = { GRM_GuildMemberHistory_Save[i][j][r][17][1] , GRM_GuildMemberHistory_Save[i][j][r][17][2] , GRM_GuildMemberHistory_Save[i][j][r][17][3] , "" };
                GRM_GuildMemberHistory_Save[i][j][r][17] = table;
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild)
                table = { GRM_PlayersThatLeftHistory_Save[i][j][r][17][1] , GRM_PlayersThatLeftHistory_Save[i][j][r][17][2] , GRM_PlayersThatLeftHistory_Save[i][j][r][17][3] , "" };
                GRM_PlayersThatLeftHistory_Save[i][j][r][17] = table;
            end
        end
    end

    -- Need backup info to be modified as well...
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                table = { GRM_GuildDataBackup_Save[i][j][s][m][n][17][1] , GRM_GuildDataBackup_Save[i][j][s][m][n][17][2] , GRM_GuildDataBackup_Save[i][j][s][m][n][17][3] , "" };
                                GRM_GuildDataBackup_Save[i][j][s][m][n][17] = table;
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Patch 1.42
-- Method:          GRM_Patch.FixUnknownPromoShowing()
-- What it Does:    If the promo date has been configured, it will ensure the Unknown flag is off
-- Purpose:         Previously, if a player was set to "unknown", it would only overwrite their promotion date on a sync, but if they detected it on their own in the log scan, it would still say unknown.
--                  The timestamp was stored, just the unknown flag needed to be set to off.
GRM_Patch.FixUnknownPromoShowing = function()

    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if GRM_GuildMemberHistory_Save[i][j][r][12] ~= nil then
                    GRM_GuildMemberHistory_Save[i][j][r][41] = false;
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild)
                if GRM_PlayersThatLeftHistory_Save[i][j][r][12] ~= nil then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][41] = false;
                end
            end
        end
    end

    -- Backups
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                -- Now, do the work on the saved database...
                                if GRM_GuildDataBackup_Save[i][j][s][m][n][12] ~= nil then
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][41] = false;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Patch 1.43
-- Method:          GRM_Patch.ConvertEmptyGUID()
-- What it Does:    In case of when players had been added to ban list, if they were lacking the GUID, this converts it to an empty string prepping for update
-- Purpose:         guid discovery for pre-patch 8.0 players that are on the left player list.
GRM_Patch.ConvertEmptyGUID = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if GRM_GuildMemberHistory_Save[i][j][r][42] == nil then
                    GRM_GuildMemberHistory_Save[i][j][r][42] = "";
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild)
                if GRM_PlayersThatLeftHistory_Save[i][j][r][42] == nil then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][42] = "";
                end
            end
        end
    end

    -- Backups
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                -- Now, do the work on the saved database...
                                if GRM_GuildDataBackup_Save[i][j][s][m][n][42] == nil then
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][42] = "";
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Patch 1.43
-- Method:          GRM_Patch.FixLeftPlayersClassToUppercase()
-- What it Does:    If it finds a string, it makes it upper case... in current form it is not properly formated for localization free class formatting.
-- Purpose:         Prevent downstream bugs
GRM_Patch.FixLeftPlayersClassToUppercase = function()
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild)
                if GRM_PlayersThatLeftHistory_Save[i][j][r][9] ~= nil then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][9] = string.upper ( GRM_PlayersThatLeftHistory_Save[i][j][r][9] );
                else
                    GRM_PlayersThatLeftHistory_Save[i][j][r][9] = "PRIEST";     -- sets default to priest, even though it is wrong... fixes previous bug.
                end
            end
        end
    end

    -- Backups
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][4] do
                                -- Now, do the work on the saved database...
                            if GRM_GuildDataBackup_Save[i][j][s][4][n][9] ~= nil then
                                GRM_GuildDataBackup_Save[i][j][s][4][n][9] = string.upper ( GRM_GuildDataBackup_Save[i][j][s][4][n][9] );
                            else
                                GRM_GuildDataBackup_Save[i][j][s][4][n][9] = "PRIEST";
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Patch 1.43
-- Method:                  GRM_Patch.BuildGUIDProfilesForAllNoLongerInGuild()
-- What it Does:            Does an initial trigger check to identify all the GUIDs of players no longer in the guild and adds them, as well as fixes their classes
-- Purpose:                 GUID was not readily available pre-8.0. This brings up all old info up to parity properly.
GRM_Patch.BuildGUIDProfilesForAllNoLongerInGuild = function()
    if not GRM_G.OnFirstLoad and not GRM_G.CheckingGUIDThroughFriendsList then
        GRM.QueryPlayersGUIDByFriendsList ( GRM.GetPlayersWithoutGUID() , 1 , true );
    elseif GRM_G.CheckingGUIDThroughFriendsList then
        return;
    else
        C_Timer.After ( 5 , GRM_Patch.BuildGUIDProfilesForAllNoLongerInGuild )
    end
end

-- Patch 1.44
-- Method:          GRM_Patch.FixLogOfNilEntries()
-- What it Does:    Removes entries that are nil that should be text
-- Purpose:         Cleans up the log of errors.
GRM_Patch.FixLogOfNilEntries = function()

    for i = 1 , #GRM_LogReport_Save do
        for j = 2 , #GRM_LogReport_Save[i] do
            for s = #GRM_LogReport_Save[i][j] , 2 , -1 do
                if GRM_LogReport_Save[i][j][s][2] == nil then
                    table.remove ( GRM_LogReport_Save[i][j] , s );
                end;
            end;
        end;
    end;

    for i = 1 , #GRM_GuildDataBackup_Save do
        for j = 2 , #GRM_GuildDataBackup_Save[i] do
            for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                    for m = #GRM_GuildDataBackup_Save[i][j][s][5] , 2 , -1 do
                        if GRM_GuildDataBackup_Save[i][j][s][5][m][2] == nil then
                            table.remove ( GRM_GuildDataBackup_Save[i][j][s][5] , m );
                        end;
                    end;
                end;
            end;
        end;
    end;
end

-- Patch 1.45
-- Method:          GRM_Patch.FixBanData()
-- What it DOes:    For some reason some people previously didn't update properly
-- Purpose:         To prevent Lua errors.
GRM_Patch.FixBanData = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if GRM_GuildMemberHistory_Save[i][j][r][17][4] == nil then
                    GRM_GuildMemberHistory_Save[i][j][r][17][4] = "";
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild)
                if GRM_PlayersThatLeftHistory_Save[i][j][r][17][4] == nil then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][17][4] = "";
                end
            end
        end
    end

    -- Need backup info to be modified as well...
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                if GRM_GuildDataBackup_Save[i][j][s][m][n][17][4] == nil then
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][17][4] = "";
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 1.45
-- Method:          GRM_Patch.FixAltCopies ( 2D Array )
-- What it Does:    Removes all copies of alts on a list
-- Purpose:         Cleans up alt lists a bit from a previous flaw.
GRM_Patch.FixAltCopies = function( listOfAlts )
    local i = 1;

    while i <= #listOfAlts do
        for j = #listOfAlts , 1 , -1 do
            if j ~= i and listOfAlts[j][1] == listOfAlts[i][1] then
                table.remove ( listOfAlts , j );
            end
        end
        i = i + 1;
    end
    return listOfAlts;
end

-- 1.45
-- Method:          GRM_Patch.FixAltListsDatabaseWide()
-- What it Does:    Cleans up the alt lists
-- Purpose:         There was a flaw that might have caused some alt lists to represent incorrectly.
GRM_Patch.FixAltListsDatabaseWide = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if #GRM_GuildMemberHistory_Save[i][j][r][11] > 0 then
                    GRM_GuildMemberHistory_Save[i][j][r][11] = GRM_Patch.FixAltCopies ( GRM_GuildMemberHistory_Save[i][j][r][11] );
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild)
                if #GRM_PlayersThatLeftHistory_Save[i][j][r][11] > 0 then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][11] = GRM_Patch.FixAltCopies ( GRM_PlayersThatLeftHistory_Save[i][j][r][11] );
                end
            end
        end
    end

    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                if #GRM_GuildDataBackup_Save[i][j][s][m][n][11] > 0 then
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][11] = GRM_Patch.FixAltCopies ( GRM_GuildDataBackup_Save[i][j][s][m][n][11] );
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 1.50
-- Method:          GRM_Patch.IntegrityCheckAndFixBdayAndAnniversaryEvents()
-- What it Does:    Rechecks database conversion integrity due to previous issue where in the process of converting, the database did not convert properly, and then rebuilds it properly if issue found
-- Purpose:         In a prior update it has been discovered that a select few people while they were updating, the whole thing came to a crashing fault due to a lua error elsewhere in the addon that caused the process
--                  to crash. This resolves all of that.
GRM_Patch.IntegrityCheckAndFixBdayAndAnniversaryEvents = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if not GRM_GuildMemberHistory_Save[i][j][r][22][1][1] then
                    GRM_GuildMemberHistory_Save[i][j][r][22][1] = { { 0 , 0 , 0 } , false , "" };
                end
                if #GRM_GuildMemberHistory_Save[i][j][r][22][2] == 3 then
                    GRM_GuildMemberHistory_Save[i][j][r][22][2] = { { 0 , 0 , 0 } , false , "" , 0 };
                end
            end
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild)
                if not GRM_PlayersThatLeftHistory_Save[i][j][r][22][1][1] then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][22][1] = { { 0 , 0 , 0 } , false , "" };
                end
                if #GRM_PlayersThatLeftHistory_Save[i][j][r][22][2] == 3 then
                    GRM_PlayersThatLeftHistory_Save[i][j][r][22][2] = { { 0 , 0 , 0 } , false , "" , 0 };
                end
            end
        end
    end

    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                if not GRM_GuildDataBackup_Save[i][j][s][m][n][22][1][1] then
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][22][1] = { { 0 , 0 , 0 } , false , "" };
                                end
                                if #GRM_GuildDataBackup_Save[i][j][s][m][n][22][2] == 3 then
                                    GRM_GuildDataBackup_Save[i][j][s][m][n][22][2] = { { 0 , 0 , 0 } , false , "" , 0 };
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.SortDeepArrayInOrder ( multi-dArray )
-- What it Does:    sorts a deep array with the first index sorted together. It also removes the first index which is the guild identifier before continuing...
-- Purpose:         To be able to organize the given array.
GRM_Patch.SortDeepArrayInOrder = function( givenArray )
    local tempIndex = givenArray[1];
    table.remove ( givenArray , 1 );
    sort ( givenArray , function ( a , b ) return a[1] < b[1] end );
    table.insert ( givenArray , 1 , tempIndex );
    return givenArray;
end

-- 1.50
-- Method:              GRM_Patch.SortGuildRosterDeepArray()
-- What it Does:        Sorts all character data stored arrays
-- Purpose:             To keep the databases alphabetized and the same between databases.
GRM_Patch.SortGuildRosterDeepArray = function()

    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            GRM_GuildMemberHistory_Save[i][j] = GRM_Patch.SortDeepArrayInOrder ( GRM_GuildMemberHistory_Save[i][j] );
        end
    end

    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            GRM_PlayersThatLeftHistory_Save[i][j] = GRM_Patch.SortDeepArrayInOrder ( GRM_PlayersThatLeftHistory_Save[i][j] );
        end
    end

    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            GRM_GuildDataBackup_Save[i][j][s][m] = GRM_Patch.SortDeepArrayInOrder ( GRM_GuildDataBackup_Save[i][j][s][m] );
                        end
                    end
                end
            end
        end
    end
end

-- 1.50
-- Method:          GRM_Patch.PlayerMetaDataDatabaseWideEdit ( function , bool , bool , bool )
-- What it Does:    Implements the function logic argument on all metadata profiles of all character profiles database wide: in-guild, previously in-guild, and all backup data indexes
-- Purpose:         Patch code bloat getting large. Streamline the process of writing patches a bit and allow me to condense previous changes as well without risk of inconsistent
GRM_Patch.PlayerMetaDataDatabaseWideEdit = function ( databaseChangeFunction , editCurrentPlayers , editLeftPlayers , includeAllGuildData )
    if editCurrentPlayers then
        for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
            for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
                for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                    if includeAllGuildData then
                        GRM_GuildMemberHistory_Save[i][j][r] = databaseChangeFunction ( GRM_GuildMemberHistory_Save[i][j] , GRM_GuildMemberHistory_Save[i][j][r] );
                    else
                        GRM_GuildMemberHistory_Save[i][j][r] = databaseChangeFunction ( GRM_GuildMemberHistory_Save[i][j][r] );
                    end
                end
            end
        end
    end

    if editLeftPlayers then
        for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
            for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
                for r = 2 , #GRM_PlayersThatLeftHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                    if includeAllGuildData then
                        GRM_PlayersThatLeftHistory_Save[i][j][r] = databaseChangeFunction ( GRM_PlayersThatLeftHistory_Save[i][j] , GRM_PlayersThatLeftHistory_Save[i][j][r] );
                    else
                        GRM_PlayersThatLeftHistory_Save[i][j][r] = databaseChangeFunction ( GRM_PlayersThatLeftHistory_Save[i][j][r] );
                    end
                end
            end
        end
    end

    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            if ( m == 3 and editCurrentPlayers ) or ( m == 4 and editLeftPlayers ) then
                                for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do
                                    if includeAllGuildData then
                                        GRM_GuildDataBackup_Save[i][j][s][m][n] = databaseChangeFunction ( GRM_GuildDataBackup_Save[i][j][s][m] , GRM_GuildDataBackup_Save[i][j][s][m][n] );
                                    else
                                        GRM_GuildDataBackup_Save[i][j][s][m][n] = databaseChangeFunction ( GRM_GuildDataBackup_Save[i][j][s][m][n] );
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 1.50
-- Method:          GRM_Patch.CleanUpAltLists( MDarray , MDarray )
-- What it Does:    Removes alts that are listed still but yet are not actually in the guild.
-- Purpose:         Previous error discovered in edge case scenario that could cause an alt to not be fully removed from the database even if their toon is removed from the guild.
GRM_Patch.CleanUpAltLists = function( guildData , player )
    local isFound = false;
    for i = #player[11] , 1 , -1 do
        isFound = false;
        for j = 2 , #guildData do
            if guildData[j][1] == player[11][i][1] then
                isFound = true;
                break;
            end
        end

        if not isFound then
            table.remove ( player[11] , i );
        end
    end
    return player;
end

-- 1.50
-- Method:          GRM_Patch.RemoveUnnecessaryHours ( array )
-- What it Does:    Removes the hour/min stamps on the join date timestamps
-- Purpose:         Due to previous error when syncing join dates, the unnecesary hour stamp was included and is just wasted space and no need to force addon to parse everytime.
GRM_Patch.RemoveUnnecessaryHours = function (  player )
    if player[12] ~= nil and string.find ( player[12] , ":" ) ~= nil then
        player[12] = string.sub ( player[12] , 1 , string.find ( player[12] , "'" ) + 2 );
    end
    return player;
end

-- 1.50
-- Method:          GRM_Patch.CleanupPromoDateSyncErrorForRejoins ( array )
-- What it Does:    if the player has a promotion date stored, yet has empty sync data, this cleans it up.
-- Purpose:         Due to a previous erro whose source has been squashed, the template placeholder date was included and sync'd around, overwriting as legit.
GRM_Patch.CleanupPromoDateSyncErrorForRejoins = function ( player )
    if player[12] ~= nil and player[36][1] == "" then
        player[36] = { player[12] , player[13] };
    end
    return player;
end

-- 1.50
-- Method:          GRM_Patch.CleanupPromoJoinDateOriginalTemplateDates ( array )
-- What it Does:    Removes the placeholder template that has existed on error and spread around thanks to sync
-- Purpose:         Cleanup the database
GRM_Patch.CleanupPromoJoinDateOriginalTemplateDates = function ( player )
    if player[12] ~= nil and player[12] == "1 Jan '01" then        -- Player found!
        -- Ok, let's clear the history now!
        player[12] = nil;
        player[25] = nil;
        player[25] = {};
        table.insert ( player[25] , { player[4] , string.sub ( player[2] , 1 , string.find ( player[2] , "'" ) + 2 ) , player[3] } );
        player[36] = { "" , 0 };
        player[41] = false;
    end

    if #player[20] > 0 and player[20][#player[20]] == "1 Jan '01" or player[20][#player[20]] == "1 Jan '01 12:01am" then
        player[20] = nil;   -- oldJoinDate wiped!
        player[20] = {};
        player[21] = nil;
        player[21] = {};
        player[15] = nil;
        player[15] = {};
        player[16] = nil;
        player[16] = {};
        player[2] = GRM.GetTimestamp();
        player[3] = time();
        player[35] = { "" , 0 };
        player[40] = false;
    end
    return player;
end

-- 1.50
-- Method:          GRM_Patch.CleanupBirthdayRepeats ( array , array )
-- What it Does:    Checks for birthday repeats due to previous bug...
-- Purpose:         Remove previous database error
GRM_Patch.CleanupBirthdayRepeats = function( guildData , player )
    local count = 1;
    if player[22][2][1] == nil or player[22][2][1][1] == nil then
        player[22][2] = { { 0 , 0 , 0 } , false , "" , 0 };
    else
        if player[22][2][1][1] > 0 then
            for i = 2 , #guildData do
                if guildData[i][22][2][1][1] == player[22][2][1][1] and guildData[i][22][2][1][2] == player[22][2][1][2] then
                    -- Birthdays found
                    count = count + 1;
                end
                if count > 17 then  -- Clears the birthdays of people with more than 17 total toons - minimizes data cleaneup to affect only those with real issue or those with multi accounts, so more rare
                    -- Need to cleanup all birthdays of this date.
                    GRM.CleanupBirthdays ( guildData[i][22][2][1][1] , guildData[i][22][2][1][2] , false , guildData );
                    break;
                end
            end
        end
    end
    return player;
end

-- 1.50
-- Method:          GRM_Patch.SlimBanReason( array );
-- What it Does:    Cleans up Ban list reasons to fit properly as there was some override allowed previously due to erro
-- Purpose:         Prevent failure to sync bans because of this issue
GRM_Patch.SlimBanReason = function ( player )
    if type ( player[18] ) ~= "string" then
        player[18] = "";
    else
        if #player[18] > 75 then
            player[18] = string.sub ( player[18] , 1 , 74 );
        end
    end
    return player;
end

-- 1.50
-- Method:          GRM_Patch.CleanupBanFormat ( array )
-- What it Does:    Checks proper formatting of the ban table and fixes it.
-- Purpose:         Fix previous error in the ban system.
GRM_Patch.CleanupBanFormat = function ( player )
    if type ( player[17] ) ~= "table" or #player[17] ~= 4 then
        player[17] = { false , 0 , false , "" };
        player[18] = "";
    end

    return player;
end

-- 1.50
-- Method:          GRM_Patch.CleanupRemovedAlts ( string )
-- What it Does:    Cleans up all the "Remove Alt" data in a guild in resets it.
-- Purpose:         Due to a discovery in a flaw in how this data was stored when a player is removed from the guild, it has been fixed at the source in code, but
--                  this is kind of a messy fix and just needs a hard reset. It likely won't affect players' alt lists much at all.
GRM_Patch.CleanupRemovedAlts = function ( guildData , player )
    local isFound = false;
    if #player[37] > 0 then
        -- Next, determine if player is no longer in the guild
        for i = #player[37] , 1 , -1 do
            isFound = false;
            for j = 2 , #guildData do
                if guildData[j][1] == player[37][i][1] then
                    isFound = true;
                    break;
                end
            end
            if not isFound then
                table.remove ( player[37] , i );
            end
        end
        player[37] = GRM_Patch.FixAltCopies(player[37]);
    end
    return player;
end

-- 1.50
-- Method:          GRM_Patch.FinalAltListCleanup()
-- What it Does:    Fixes some previous flaws to align the database properly
-- Purpose:         To enable quick syncing pre-check comparisons the compare strings need to be exactl
-- Algorithm steps.
-- Step 1:  Determine if player has alts
-- Step 2:  Cycle through each alt of his own and find its index in the database
-- Step 3:  Determine if his name is on that al list
-- Step 4:  If not on the alt list, add the alt properly.
-- Step 5:  Remove altName from all other groupings
-- Step 5a: Ensure current list of alts is added to and maintained as reference
GRM_Patch.FinalAltListCleanup = function ()
    local guildData = GRM_GuildMemberHistory_Save;
    local isFound = false;
    local classColors = {};
    local collectedIndexes = {};

    local isValidIndex = function ( ind )
        local result = true;
        for i = 1 , #collectedIndexes do
            if collectedIndexes[i] == ind then
                result = false;
            end
        end
        return result;
    end

    for p = 1 , #guildData do
        for q = 2 , #guildData[p] do

            for i = 2 , #guildData[p][q] do
                if #guildData[p][q][i][11] > 0 then
                    collectedIndexes = {};
                    -- Player has been found with alts
                    -- Now, cycling through each alt
                    for m = 1 , #guildData[p][q][i][11] do
                        isFound = false;
                        -- Checking the alts lits of each alt, determine if player is on it.
                        for k = 2 , #guildData[p][q] do
                            if guildData[p][q][i][11][m][1] == guildData[p][q][k][1] then       -- Player's initial alt has had their alt grouping found...
                                -- Collecting the index
                                table.insert ( collectedIndexes , k );
                                -- Now, let's determine if main player is on each of their lists properly
                                for r = 1 , #guildData[p][q][k][11] do
                                    if guildData[p][q][k][11][r][1] == guildData[p][q][i][1] then
                                        isFound = true;
                                        -- Confirmed! Player is on the alt lists of his alts.
                                        break;
                                    end
                                end
                                if not isFound then
                                    -- Let's add it!
                                    classColors = GRM.GetClassColorRGB ( guildData[p][q][i][9] , false );
                                    table.insert ( guildData[p][q][k][11] , { guildData[p][q][i][1] , classColors[1] , classColors[2] , classColors[3] , guildData[p][q][i][10] , time() } );
                                end
                                break;
                            end
                        end
                    end

                    -- Now, remove the alt from all other alt Groupings...
                    for j = 2 , #guildData[p][q] do
                        if isValidIndex ( j ) then                  -- No need to check players that are saved.
                            for m = #guildData[p][q][j][11] , 1 , -1 do
                                if guildData[p][q][j][11][m][1] == guildData[p][q][i][1] then
                                    table.remove ( guildData[p][q][i][11] , m );
                                end
                            end
                        end
                    end
                end
            end

        end
    end
end

-- 1.50
-- Method:          GRM_Patch.CleanupCustomNoteError()
-- What it Does:    Checks the end of the custom note for a '?' sendAddonMessage comms divider. If found, it checks if next is an index number, if so, it clears the last 2 markers at end, example, like "9?"
-- Purpose:         This is due to incorrect parsing previously on sync that in some cases added an X number with divider at end of the new custom note, so like "Arkaan's Discord Name is Arkaan?"
--                  The source of the error is now resolved, so just cleaning up notes where this may apply
GRM_Patch.CleanupCustomNoteError = function( player )
    if player[23][6] == nil then
        -- let's fix it if it's broken!!!
        player[23] = { true , 0 , "" , GRM_AddonSettings_Save[FID][PID][2][49] , false , "" };
    elseif #player[23][6] > 2 and string.sub ( player[23][6] , #player[23][6] , #player[23][6] ) == "?" and tonumber ( string.sub ( player[23][6] , #player[23][6] - 1 , #player[23][6] -1 ) ) ~= nil then
        player[23][6] = string.sub ( player[23][6] , 1 , #player[23][6] - 2 );
    end
    return player
end

-- method:          GRM_Patch.SlimDate ( string )
-- What it Does:    Returns the string with the hour/min taken off the end.
-- Purpose:         For SYNCing, the only important piece of info on the timestamp is the date, and comparing it is the same. I don't want sync to trigger over and over
--                  Because the hour/min is off on the sync when that is unimportant info, at least in this context.
GRM_Patch.SlimDate  = function ( date )
    if date ~= "" then
        date = string.sub ( date , 1 , string.find( date , "'" ) + 2 );
    end
    return date;
end

-- 1.50
-- Method:          GRM_Patch.CleanupJoinAndPromosSetUnknownError ( array )
-- What it Does:    Rebuilds the database properly for a previous "Set as Unknown" bug that existed.
-- Purpose:         To cleanup previous errors
GRM_Patch.CleanupJoinAndPromosSetUnknownError = function( player )
    -- join date
    if #player[20] == 0 and player[36][1] ~= "" and player[35][1] ~= "1 Jan '01" and player[35][1] ~= "1 Jan '01 12:01am" then
        if player[35][1] ~= GRM_Patch.SlimDate ( GRM.GetTimestamp() ) then
            table.insert ( player[20] , GRM_Patch.SlimDate ( player[35][1] ) );
            table.insert ( player[21] , player[35][2] );
            player[40] = false;     -- unknown set to false
        end
    end

    -- promo date
    if player[12] == nil and player[36][1] ~= "" and player[36][1] ~= "1 Jan '01" and player[36][1] ~= "1 Jan '01 12:01am" then
        player[12] = GRM_Patch.SlimDate ( player[36][1] );
        player[13] = player[36][2];
        player[41] = false;     -- unknown set to false
    end

    return player;
end

-- 1.51
-- Method:          GRM_Patch.CleanupPromoDateSituation ( array )
-- What it Does:    Fixes an old issue with the database
-- Purpose:         Prevent Lua errors when reporting times are off when looking at their dates.
GRM_Patch.CleanupPromoDateSituation = function( player )
    if #player[20] > 0 and player[20][1] == "" then
        player[20] = {};
    end

    if player[12] ~= nil and player[12] == "" then
        player[12] = nil;
    end
    return player
end

-- 1.53
-- Method:          GRM_Patch.CleanupJoinDateError ( array , array )
-- What it Does:    Checks for repeats of join date, and if it finds > 40 (threshold I find reasonable for cleaning up > so small guilds may not receive benefit)
--                  if repeats found > 40 then it cleans them up
-- Purpose:         Error in the massive 1.50 overhaul that affects *some* people.
GRM_Patch.CleanupJoinDateError = function ( guildData )
    local count = 0;
    local tempGuild = guildData;
    for i = 2 , #guildData do
        count = 0;
        if guildData[i][35][1] ~= "" then
            for j = 2 , #tempGuild do
                if tempGuild[j][35][1] ~= "" and tempGuild[j][35][1] == guildData[i][35][1] then
                    count = count + 1;
                end
                if count > 75 then  -- Cleanup JoinDates
                    break;
                end
            end
        end
        if count > 40 then
            guildData = GRM_Patch.CleanupJoinDateRepeats ( guildData , guildData[i][35][1] );
            break;
        end
    end
    return guildData;
end

-- 1.53
-- Method:          GRM_Patch.CleanupJoinDateRepeats ( array , string )
-- What it Does:    Removes all instances of the same given date and either resets the data, or moves back one index to previous setting
-- Purpose:         Error in updating the databases for
GRM_Patch.CleanupJoinDateRepeats = function ( guildData , date )
    for i = 2 , #guildData do
        if guildData[i][35][1] == date then
            if #guildData[i][20] > 1 then
                table.remove ( guildData[i][15] , #guildData[i][15] );
                table.remove ( guildData[i][16] , #guildData[i][16] );
                table.remove ( guildData[i][20] , #guildData[i][20] );
                table.remove ( guildData[i][21] , #guildData[i][21] );

                guildData[i][2] = guildData[i][20][#guildData[i][20]];
                guildData[i][3] = guildData[i][21][#guildData[i][21]];
                guildData[i][35] = { guildData[i][20][#guildData[i][20]] , guildData[i][21][#guildData[i][21]] };
            else
                guildData[i][2] = GRM.GetTimestamp();
                guildData[i][3] = time();
                guildData[i][15] = {};
                guildData[i][16] = {};
                guildData[i][20] = {};
                guildData[i][21] = {};
                guildData[i][35] = { "" , 0 };
            end
            guildData[i][40] = false;
        end
    end
    return guildData;
end

-- 1.53
-- Method:          GRM_Patch.GuildDataDatabaseWideEdit ( function )
-- What it Does:    Implements function logic on the guild as a whole
-- Purpose:         Rather than focusing on the metadata, it focuses on the guild.
GRM_Patch.GuildDataDatabaseWideEdit = function ( databaseChangeFunction )
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            GRM_GuildMemberHistory_Save[i][j] = databaseChangeFunction ( GRM_GuildMemberHistory_Save[i][j] );
        end
    end

    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            GRM_PlayersThatLeftHistory_Save[i][j] = databaseChangeFunction ( GRM_PlayersThatLeftHistory_Save[i][j] );
        end
    end

    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            GRM_GuildDataBackup_Save[i][j][s][m] = databaseChangeFunction ( GRM_GuildDataBackup_Save[i][j][s][m] );
                        end
                    end
                end
            end
        end
    end
end

-- Method:          GRM_Patch.RemoveOneAutoAndOneManualBackup)_
-- What it Does:    Removes 1 of the auto-backup positions and one of the manual
-- Purpose:         Free up resources, prevent overflow issues that can occur on load by having too deep of these nested backups
GRM_Patch.RemoveOneAutoAndOneManualBackup = function()
    for i = 1 , #GRM_GuildDataBackup_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildDataBackup_Save[i] do                  -- The guilds in each faction
            if #GRM_GuildDataBackup_Save[i][j] > 1 then

                if #GRM_GuildDataBackup_Save[i][j] > 2 and ( #GRM_GuildDataBackup_Save[i][j][3] == 0 or string.find ( GRM_GuildDataBackup_Save[i][j][3][1] , "AUTO_" , 1 , true ) ~= nil ) then
                    table.remove ( GRM_GuildDataBackup_Save[i][j] , 3 );     -- Remove the 2nd auto-added backup.
                end

                -- Now we remove any extra manual backups.
                while #GRM_GuildDataBackup_Save[i][j] > 3 do
                    table.remove ( GRM_GuildDataBackup_Save[i][j] , #GRM_GuildDataBackup_Save[i][j] );
                end
            end
        end
    end
end

-- Method:          GRM_Patch.ConvertRecommendedKickDateToRule ( int )
-- What it Does:    It converts the old setting to the new format.
-- Purpose:         Integration into the GRM tool.
GRM_Patch.ConvertRecommendedKickDateToRule = function( index )
    for i = 1 , #GRM_AddonSettings_Save do
        for j = #GRM_AddonSettings_Save[i] , 2 , -1 do
            if GRM_AddonSettings_Save[i][j][2] ~= nil and GRM_AddonSettings_Save[i][j][2][index] ~= nil then

                GRM_AddonSettings_Save[i][j][2][index] = { { 1 , 1 , 1 , GRM_AddonSettings_Save[i][j][2][9] , GRM_AddonSettings_Save[i][j][2][10] } };

            else
                table.remove ( GRM_AddonSettings_Save[i] , j );

                -- Double check if it is current player still is found
                local isFound = false;
                for k = 2 , #GRM_AddonSettings_Save[FID] do
                    if GRM_AddonSettings_Save[FID][k][1] == GRM_G.addonUser then
                        isFound = true;
                        break;
                    end
                end
                if not isFound then -- Edge case scenario of addon settings being lost thus are replaced with defaults.
                    table.insert ( GRM_AddonSettings_Save[FID] , { GRM_G.addonUser } );
                    PID = #GRM_AddonSettings_Save[FID];
                    table.insert ( GRM_AddonSettings_Save[FID][PID] , GRM_Patch.GetDefaultAddonSettings() );
                    GRM_G.IsNewToon = true;
                    -- Forcing core log window/options frame to load on the first load ever as well
                    GRM_G.ChangesFoundOnLoad = true;
                end
            end
        end
    end
end

-- Method:          GRM_Patch.CleanupPromotionDateMouseOverError ( array )
-- What it Does:    Due to an error on setting the promotion date when a new player joins incompletely, this resolves that mouseover bug of promotion date history
-- Purpose:         If a player joins guild AND changes rank since the last you logged, it was reporting they joined and they changed rank. However, the rank history was getting set as nil
--                  in some cases which would throw a Lua error on mouseover. This cleans that up.
GRM_Patch.CleanupPromotionDateMouseOverError = function ( player )

    for i = #player[25] , 1 , -1 do
        if #player[25][i] == 1 then
            table.remove ( player[25] , i );
        end
    end

    return player;
end

-- Method:          GRM_Patch.FixMonthDateRecommendationError()
-- What it Does:    Previous error on the macro tool changed the default reporting to 75 months. This changes it to 12 months
-- Purpose:         Reset just the settings of this one erroneously, but if they don't match, it means the player has already adjusted this setting and it will be left alone.
GRM_Patch.FixMonthDateRecommendationError = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = #GRM_AddonSettings_Save[i] , 2 , -1 do
            if GRM_AddonSettings_Save[i][j][2] ~= nil and GRM_AddonSettings_Save[i][j][2][75][1][3] == 1 and GRM_AddonSettings_Save[i][j][2][75][1][4] == 75 then
                GRM_AddonSettings_Save[i][j][2][75][1][4] = 12;
            end
        end
    end
end


-- Method:          GRM_Patch.ClearExtraBackups()
-- What it Does:    Scans through the backups and remove duplicates
-- Purpose:         The /grm ClearGuild was failing to remove the backs, so it was rebuilding it every time the guild was remade.
GRM_Patch.ClearExtraBackups = function()
    for i = 1 , #GRM_GuildDataBackup_Save do                -- Factions
        for j = #GRM_GuildDataBackup_Save[i] , 2 , -1 do    -- Individual Guilds
            for k = ( j - 1 ) , 2 , -1 do                   -- Scanning through individual after grabbing 1
                if GRM_GuildDataBackup_Save[i][k][1][1] == GRM_GuildDataBackup_Save[i][j][1][1] and GRM_GuildDataBackup_Save[i][k][1][2] == GRM_GuildDataBackup_Save[i][j][1][2] then
                    table.remove ( GRM_GuildDataBackup_Save[i] , k );
                    break;
                end
            end
        end
    end
end

-- 1.81
-- Method:          GRM_Patch.FixOptionsSetting ( int , var , function )
-- What it Does:    Determines if the setting exists. If it does not, is sets the correctSetting. If it does, then it modifies the setting based on the function logic
-- Purpose:         It is possible in some cases when updating the addon the system crashes before a system updated takes, maybe in the middle of it. This verifies and fixes issues with the settings.
GRM_Patch.FixOptionsSetting = function( index , correctSetting , settingsControlFunction )

    for i = 1 , #GRM_AddonSettings_Save do
        for j = #GRM_AddonSettings_Save[i] , 2 , -1 do
            if #GRM_AddonSettings_Save[i][j] == nil then
                table.remove ( GRM_AddonSettings_Save[i] , j );
            else
                if #GRM_AddonSettings_Save[i][j] == 1 then
                    table.remove ( GRM_AddonSettings_Save[i] , j );                 -- Error protection in case bad settings profile build
                else
                    if GRM_AddonSettings_Save[i][j][2][index] ~= nil then
                        GRM_AddonSettings_Save[i][j][2][index] = settingsControlFunction ( GRM_AddonSettings_Save[i][j][2][index] , correctSetting );
                    else
                        GRM_AddonSettings_Save[i][j][2][index] = correctSetting;
                    end
                end
            end
        end
    end
end

-- 1.81
-- Method:          GRM_Patch.FixScalingOption ( var , table )
-- What it Does:    Checks if the format of the setting is correct and fixes each part of it properly to defauly correct setting, or keeps previous settings if ok.
-- Purpose:         Integrity check of this due to a potential issue that caused crash when creating the setting.
GRM_Patch.FixScalingOption = function ( setting , correctSetting )

    if setting ~= nil and #setting == 5 then
        for i = 1 , #setting do
            if setting[i] == nil or type ( setting[i] ) ~= "number" then
                setting[i] = correctSetting[i];
            end
        end
    else
        setting = correctSetting;
    end

    return setting;
end

-- 1.81
-- Method:          GRM_Patch.ExpandExportFilters ( var , table )
-- What it Does:    Addes 2 extra booleans to the table for export filter controls for sex/race
-- Purpose:         So that the sex and race filters can be added to the settings.
GRM_Patch.ExpandExportFilters = function ( setting , correctSetting )
    if setting ~= nil and #setting == 14 then
        setting[15] = true;
        setting[16] = true;
    else
        setting = correctSetting;
    end

    return setting;
end

-- 1.82
-- Method:          GRM_Patch.UpdateMinimumScanTime ( int , int )
-- What it Does:    Checks if the minimum scan setting is below 20 seconds, and if it is, sets it to 20
-- Purpose:         To set the minimum to only be at 20 seconds instead of the previous 10.
GRM_Patch.UpdateMinimumScanTime = function ( setting , correctSetting )
    if setting == nil or setting < 20 then
        setting = correctSetting;
    end
    return setting;
end

-- 1.831
-- Method:          GRM_Patch.RealignDatabaseDueToMisSort()
-- What it Does:    Takes all guild saves and sorts them properly, including backups
-- Purpose:         Fix a dump insert issue I created in 1.82
GRM_Patch.RealignDatabaseDueToMisSort = function ()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            GRM_GuildMemberHistory_Save[i][j] =  GRM_Patch.SortDeepArrayInOrder ( GRM_GuildMemberHistory_Save[i][j] );
        end
    end

    -- need to update the left player's database too...
    for i = 1 , #GRM_PlayersThatLeftHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_PlayersThatLeftHistory_Save[i] do                  -- The guilds in each faction
            GRM_PlayersThatLeftHistory_Save[i][j] =  GRM_Patch.SortDeepArrayInOrder ( GRM_PlayersThatLeftHistory_Save[i][j] );
        end
    end

    local needsToBreak = false;
    -- Need backup info to be modified as well...
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do

                    needsToBreak = false;
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 4 do
                            if GRM_GuildDataBackup_Save[i][j][s][m] ~= nil then
                                GRM_GuildDataBackup_Save[i][j][s][m] =  GRM_Patch.SortDeepArrayInOrder ( GRM_GuildDataBackup_Save[i][j][s][m] );
                            else
                                -- Uh oh... backup corrupted?
                                GRM_GuildDataBackup_Save[i][j] = { GRM_GuildDataBackup_Save[i][j][1] , {} };
                                needsToBreak = true;
                                break;
                            end
                        end
                    end

                    if needsToBreak then
                        break;
                    end

                end
            end
        end
    end
end


-- Patch 1.84
-- Method:          GRM_Patch.FixAltGroupings()
-- What it DOes:    Lingering bug needs to be fixed before applying DB changes - clears copies of alts or fixes broken incomplete lists
-- Purpose:         To clear an old bug
GRM_Patch.FixAltGroupings = function()
    for i = 1 , #GRM_GuildMemberHistory_Save do                         -- Horde and Alliance
        for j = 2 , #GRM_GuildMemberHistory_Save[i] do                  -- The guilds in each faction
            for r = 2 , #GRM_GuildMemberHistory_Save[i][j] do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).

                if #GRM_GuildMemberHistory_Save[i][j][r][11] == 0 then   -- player has no alts

                    -- Let's see if player is on any alt lists.
                    for s = 2 , #GRM_GuildMemberHistory_Save[i][j] do

                        -- no need to check oneself.
                        if r ~= s and #GRM_GuildMemberHistory_Save[i][j][s][11] > 0 then

                            for k = #GRM_GuildMemberHistory_Save[i][j][s][11] , 1 , -1 do
                                if GRM_GuildMemberHistory_Save[i][j][s][11][k][1] == GRM_GuildMemberHistory_Save[i][j][r][1] then
                                    -- Player IS on a list!!! Remove him
                                    table.remove ( GRM_GuildMemberHistory_Save[i][j][s][11] , k );
                                end
                            end

                        end

                    end

                end
            end
        end
    end

    -- Need backup info to be modified as well...
    if GRM_GuildDataBackup_Save ~= nil then
        for i = 1 , #GRM_GuildDataBackup_Save do
            for j = 2 , #GRM_GuildDataBackup_Save[i] do
                for s = 2 , #GRM_GuildDataBackup_Save[i][j] do
                    if #GRM_GuildDataBackup_Save[i][j][s] > 0 then
                        -- 3 and 4 = history and leftHistory
                        for m = 3 , 3 do
                            for n = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do

                                if #GRM_GuildDataBackup_Save[i][j][s][m][n][11] == 0 then  -- player has no alts

                                    -- Let's see if player is on any alt lists.
                                    for v = 2 , #GRM_GuildDataBackup_Save[i][j][s][m] do

                                        -- no need to check oneself.
                                        if s ~= v and #GRM_GuildDataBackup_Save[i][j][s][m][v][11] > 0 then

                                            for k = #GRM_GuildDataBackup_Save[i][j][s][m][v][11] , 1 , -1 do
                                                if GRM_GuildDataBackup_Save[i][j][s][m][v][11][k][1] == GRM_GuildDataBackup_Save[i][j][s][m][n][1] then
                                                    -- Player IS on a list!!! Remove him
                                                    table.remove ( GRM_GuildDataBackup_Save[i][j][s][m][v][11] , k );
                                                end
                                            end

                                        end

                                    end

                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


-- 1.84
-- Method:          GRM_Patch.IsAnySettingsTooLow()
-- What it Does:    Returns true if the number of settings options is below 79
-- Purpose:         Due to a previous bug some people might not have configured their setttings properly. This resolves it
GRM_Patch.IsAnySettingsTooLow = function()
    for i = 1 , #GRM_AddonSettings_Save do
        for j = 2 , #GRM_AddonSettings_Save[i] do
            if #GRM_AddonSettings_Save[i][j][2] <= 78 then  -- Trigger the setting to reload for all.
                return true;
            end
        end
    end;

    return false;
end

-- 1.84 - Shifted over - only needed as temporary placeholder to normalize creation of a new player before overwriting. This saves a lot of extra code just keeping it here.
-- Method:          GRM_Patch.GetDefaultAddonSettings()
-- What it Does:    Establishes the default addon setttings for all of the options and some other misc. stored variables, like minimap position
-- Purpose:         Easy access to settings on a default reset.
GRM_Patch.GetDefaultAddonSettings = function()
    local defaults = {
        GRM_G.Version,                                                                                          -- 1)  Version
        true,                                                                                                   -- 2)  View on Load
        { true , true , true , true , true , true , true , true , true , true , true , true , true , true },    -- 3)  All buttons are checked in the log window (14 so far)
        336,                                                                                                    -- 4)  Report inactive return of player coming back (2 weeks is default value)
        14,                                                                                                     -- 5)  Event Announce in Advance - Cannot be higher than 4 weeks ( 28 days ) ( 1 week is default);
        30,                                                                                                     -- 6)  How often to check for changes ( in seconds )
        false,                                                                                                  -- 7)  Add Timestamp on join to Officer Note
        true,                                                                                                   -- 8)  Use Calendar Announcements
        true,                                                                                                   -- 9)  Color Code names
        true,                                                                                                   -- 10) Show the mouseover window or not.
        true,                                                                                                   -- 11) Report Inactive Returns
        true,                                                                                                   -- 12) Announce Upcoming Events.
        { true , true , true , true , true , true , true , true , true , true , true , true , true , true },    -- 13) Checkbox for message frame announcing. Disable
        true,                                                                                                   -- 14) Allow Data sharing between guildies
        GRM.GetRankRestrictedDefaultRankIndex(),                                                                -- 15) Rank Player must be to accept sync updates from them.
        true,                                                                                                   -- 16) Receive Notifications if others in the guild send updates!
        true,                                                                                                   -- 17) Only announce the anniversary of players set as the "main"
        true,                                                                                                   -- 18) Scan for changes
        true,                                                                                                   -- 19) Sync only with players who have current version or higher.
        1,                                                                                                      -- 20) Add Join Date to Officer Note = 1, Public Note = 2 , custom = 3
        true,                                                                                                   -- 21) Sync Ban List
        GRM.GetFirstOfficerRank(),                                                                              -- 22) Rank player must be to send or receive Ban List sync updates!
        1,                                                                                                      -- 23) Only Report level increase greater than or equal to this.
        1,                                                                                                      -- 24) 100 % speed
        345,                                                                                                    -- 25) Minimap Position
        78,                                                                                                     -- 26) Minimap Radius
        true,                                                                                                   -- 27) Notify when player requests to join guild the recruitment window
        true,                                                                                                   -- 28) Only View on Load if Changes were found
        true,                                                                                                   -- 29) Show "main" name in guild/whispers if player speaking on their alt
        false,                                                                                                  -- 30) Only show those needing to input data on the audit window.
        true,                                                                                                   -- 31) Sync Settings of all alts in the same guild
        true,                                                                                                   -- 32) Show Minimap Button
        true,                                                                                                   -- 33) Audit Frame - Unknown Counts as complete
        true,                                                                                                   -- 34) Allow Autobackups
        true,                                                                                                   -- 35) Share data with ALL guildies, but only receive from your threshold rank
        true,                                                                                                   -- 36) Show line numbers in log
        true,                                                                                                   -- 37) Enable Shift-Click Line removal of the log...
        true,                                                                                                   -- 38) Custom Note Sync allowed
        GRM.Use24HrBasedOnDefaultLanguage(),                                                                    -- 39) Use 24hr Scale
        true,                                                                                                   -- 40) Track Birthdays
        7,                                                                                                      -- 41) Auto Backup Interval in Days
        2,                                                                                                      -- 42) Main Tag format index
        GRM_G.LocalizedIndex,                                                                                   -- 43) Selected Language ( 1 default is English)
        1,                                                                                                      -- 44) Selected Font ( 1 is Default )
        0,                                                                                                      -- 45) Font Modifier Size
        { 1 , 0 , 0 },                                                                                          -- 46) RGB color selection on the "Main" tagging (Default is Red)
        { true , true , true , true , true , true , true , true },                                              -- 47) Level Filter Options - 60 , 70 , 80 , 85 , 90 , 100 , 110 , 120
        { "" , "" },                                                                                            -- 48) Custom Join and Rejoin tags
        2,                                                                                                      -- 49) Default rank for syncing Custom Note
        0.9,                                                                                                    -- 50) Default Tooltip Size
        1,                                                                                                      -- 51) Date Format  -- 1 = default  "1 Mar '18"
        false,                                                                                                  -- 52) Use "Fade" on tabbing
        true,                                                                                                   -- 53) Disable Guild Reputation visual
        true,                                                                                                   -- 54) Enable Auto-Popup of the recruitment window if a player comes online.
        true,                                                                                                   -- 55) Only report returning from inactivity of ALL alts are past the threshold date.
        true,                                                                                                   -- 56) Report Leveling Data to Log
        true,                                                                                                   -- 57) Include "Joined:" in the officer/public note join date tag
        true,                                                                                                   -- 58) Show Borders around public/officer/custom notes
        true,                                                                                                   -- 59) Report notes to the log on leaving guild...
        true,                                                                                                   -- 60) Only recommend player to kick if ALL alts are offline for the given time.
        true,                                                                                                   -- 61) Use a custom message in the guild recruit window when inviting players
        "",                                                                                                     -- 62) The custom message
        false,                                                                                                  -- 63) Using a customized minimap position.
        { "" , "" },                                                                                            -- 64) The setpoints of the custom minimap position
        true,                                                                                                   -- 65) Main Tags...
        false,                                                                                                  -- 66) Auto Focus the search bar when opening the log.
        true,                                                                                                   -- 67) Show Birthday on the player detail window...
        true,                                                                                                   -- 68) Allow Birthday Sync
        false,                                                                                                  -- 69) Only show players with JD needing updating in JD Audit Tool
        true,                                                                                                   -- 70) Disable or enable the log tooltip
        true,                                                                                                   -- 71) Show GRM player window on old Guild Roster as well
        { "" , "" , 0 , 0 },                                                                                    -- 72) Coordinates for core GRM window
        "",                                                                                                     -- 73) GRM Report Destination Default (kept in string format so as not to waste data saving a whole frame)
        { "" , "" , 0 , 0 },                                                                                    -- 74) Coordinates for core Mass Kick Tool Window
        { { 1 , 1 , 1 , 12 , true } },                                                                          -- 75) Rules for Reminders and Promote/Demote/Kick Recommendations.
        false,                                                                                                  -- 76) Safe List hybrid scrollframe checkbox - true to only show players where actions ignored
        true,                                                                                                   -- 77) Allow !note for non-officers to set their own note
        0,                                                                                                      -- 78) Log font modified size
        { true , ";" },                                                                                         -- 79) Export Delimiter selection - it defaults ";"
        { true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true},                     -- 80) Export filters for member and former members (16 items so far)
        false,                                                                                                  -- 81) Auto-include export column headers
        { 1.0 , 1.0 , 1.0 , 1.0 , 1.0 }                                                                        -- 82) Scale Controls for GRM frames (Core , mouseover , Macro , export , "" )

    }

    -- Classic Values adjusted
    if GRM_G.BuildVersion < 40000 then
        defaults[53] = false;       -- Guild Rep not added until Cataclysm
        defaults[80][10] = false;   -- Disabled Guild Rep Export
    end


    return defaults;
end

-- Major Database Overhaul (1.84))
-- Method:          GRM_Patch.ConvertAddonSettings()
-- What it Does:    Converts the old array database into a dictionary lookup, which is faster
-- purpose:         Speed and easier to read settings!
GRM_Patch.ConvertAddonSettings = function()
    if GRM_AddonSettings_Save["H"] == nil then
        local tempUI = GRM.DeepCopyArray ( GRM_AddonSettings_Save );
        local newUI = {};

        newUI["H"] = {};
        newUI["A"] = {};


        local faction = "H";
        local name = "";

        for i = 1 , 2 do

            if i == 2 then
                faction = "A";
            end

            for j = 2 , #tempUI[i] do
                name = tempUI[i][j][1];

                newUI[faction][ name ] = {};     -- Set each player name to the settings properly
                for i = 0 , 14 do
                    GRM.SetDefaultAddonSettings ( newUI[faction][ name ] , i );
                    if i == 10 then
                        newUI[faction][ name ]["kickRules"] = { { 1 , 1 , 1 , 12 , true } };
                    end
                end

                newUI[faction][name]["version"] = tempUI[i][j][2][1];
                newUI[faction][name]["showMouseoverRetail"] = tempUI[i][j][2][10];
                newUI[faction][name]["showMouseoverOld"] = tempUI[i][j][2][71];
                newUI[faction][name]["minimapPos"] = tempUI[i][j][2][25];
                newUI[faction][name]["minimapRad"] = tempUI[i][j][2][26];
                newUI[faction][name]["customPos"] = tempUI[i][j][2][63];
                newUI[faction][name]["minimapCustomPos"] = tempUI[i][j][2][64];
                newUI[faction][name]["CoreWindowPos"] = tempUI[i][j][2][72];
                newUI[faction][name]["macroToolCoordinates"] = tempUI[i][j][2][74];
                newUI[faction][name]["JDAuditToolFilter"] = tempUI[i][j][2][69];
                newUI[faction][name]["viewOnLoad"] = tempUI[i][j][2][2];
                newUI[faction][name]["colorizeNames"] = tempUI[i][j][2][9];
                newUI[faction][name]["showMainName"] = tempUI[i][j][2][29];
                newUI[faction][name]["syncSettings"] = tempUI[i][j][2][31];
                newUI[faction][name]["minimapEnabled"] = tempUI[i][j][2][32];
                newUI[faction][name]["twentyFourHrScale"] = tempUI[i][j][2][39];
                newUI[faction][name]["mainTagIndex"] = tempUI[i][j][2][42];
                newUI[faction][name]["selectedLang"] = tempUI[i][j][2][43];
                newUI[faction][name]["selectedFont"] = tempUI[i][j][2][44];
                newUI[faction][name]["fontModifier"] = tempUI[i][j][2][45];
                newUI[faction][name]["mainTagColor"] = {};
                newUI[faction][name]["mainTagColor"]["r"] = tempUI[i][j][2][46][1];
                newUI[faction][name]["mainTagColor"]["g"] = tempUI[i][j][2][46][2];
                newUI[faction][name]["mainTagColor"]["b"] = tempUI[i][j][2][46][3];
                newUI[faction][name]["tooltipSize"] = tempUI[i][j][2][50];
                newUI[faction][name]["dateFormat"] = tempUI[i][j][2][51];
                newUI[faction][name]["useMainTag"] = tempUI[i][j][2][65];
                newUI[faction][name]["reportChannel"] = tempUI[i][j][2][73];
                newUI[faction][name]["inactiveHours"] = tempUI[i][j][2][4];
                newUI[faction][name]["eventAdvanceDays"] = tempUI[i][j][2][5];
                newUI[faction][name]["scanDelay"] = tempUI[i][j][2][6];
                newUI[faction][name]["calendarAnnouncements"] = tempUI[i][j][2][12];
                newUI[faction][name]["reportInactiveReturn"] = tempUI[i][j][2][11];
                newUI[faction][name]["onlyAnnounceForMain"] = tempUI[i][j][2][17];
                newUI[faction][name]["scanEnabled"] = tempUI[i][j][2][18];
                newUI[faction][name]["levelReportMin"] = tempUI[i][j][2][23];
                newUI[faction][name]["onlyViewIfChanges"] = tempUI[i][j][2][28];
                newUI[faction][name]["levelFilters"] = tempUI[i][j][2][47];
                newUI[faction][name]["allAltRequirement"] = tempUI[i][j][2][55];
                newUI[faction][name]["recordLevelUp"] = tempUI[i][j][2][56];
                newUI[faction][name]["syncEnabled"] = tempUI[i][j][2][14];
                newUI[faction][name]["syncRank"] = tempUI[i][j][2][15];
                newUI[faction][name]["syncChatEnabled"] = tempUI[i][j][2][16];
                newUI[faction][name]["syncSameVersion"] = tempUI[i][j][2][19];
                newUI[faction][name]["syncBanList"] = tempUI[i][j][2][21];
                newUI[faction][name]["syncRankBanList"] = tempUI[i][j][2][22];
                newUI[faction][name]["syncSpeed"] = tempUI[i][j][2][24];
                newUI[faction][name]["exportAllRanks"] = tempUI[i][j][2][35];
                newUI[faction][name]["syncCustomNote"] = tempUI[i][j][2][38];
                newUI[faction][name]["syncRankCustom"] = tempUI[i][j][2][49];
                newUI[faction][name]["syncBDays"] = tempUI[i][j][2][68];
                newUI[faction][name]["addTimestampToNote"] = tempUI[i][j][2][7];
                newUI[faction][name]["allowEventsToCalendar"] = tempUI[i][j][2][8];
                newUI[faction][name]["joinDateDestination"] = tempUI[i][j][2][20];
                newUI[faction][name]["customTags"] = tempUI[i][j][2][48];
                newUI[faction][name]["includeTag"] = tempUI[i][j][2][57];
                newUI[faction][name]["addNotesToLeft"] = tempUI[i][j][2][59];
                newUI[faction][name]["noteSetEnabled"] = tempUI[i][j][2][77];
                newUI[faction][name]["useFade"] = tempUI[i][j][2][52];
                newUI[faction][name]["viewGuildRep"] = tempUI[i][j][2][53];
                newUI[faction][name]["showBorders"] = tempUI[i][j][2][58];
                newUI[faction][name]["showBDay"] = tempUI[i][j][2][67];
                newUI[faction][name]["UIScaling"] = tempUI[i][j][2][82];
                newUI[faction][name]["toLog"] = {};
                newUI[faction][name]["toChat"] = {};
                newUI[faction][name]["showLineNumbers"] = tempUI[i][j][2][36];
                newUI[faction][name]["shiftClickRemove"] = tempUI[i][j][2][37];
                newUI[faction][name]["autoFocusSearch"] = tempUI[i][j][2][66];
                newUI[faction][name]["showTooltip"] = tempUI[i][j][2][70];
                newUI[faction][name]["logFontSize"] = tempUI[i][j][2][78];
                newUI[faction][name]["exportDelimiter"] = tempUI[i][j][2][79];
                newUI[faction][name]["exportFilters"] = tempUI[i][j][2][80];
                newUI[faction][name]["columnHeaders"] = tempUI[i][j][2][81];
                newUI[faction][name]["allAltsApplyToKick"] = tempUI[i][j][2][60];
                newUI[faction][name]["kickRules"] = tempUI[i][j][2][75];
                newUI[faction][name]["ignoreFilter"] = tempUI[i][j][2][76];
                newUI[faction][name]["onlyShowIncomplete"] = tempUI[i][j][2][30];
                newUI[faction][name]["unknownIsComplete"] = tempUI[i][j][2][33];
                newUI[faction][name]["allowAutoBackups"] = tempUI[i][j][2][34];
                newUI[faction][name]["autoIntervalDays"] = tempUI[i][j][2][41];

                local s = "toLog";
                local int = 3;
                for k = 1 , 2 do
                    if k == 2 then
                        s = "toChat";
                        int = 13;
                    end
                    newUI[faction][name][s] = {};
                    newUI[faction][name][s]["joined"] = tempUI[i][j][2][int][1];
                    newUI[faction][name][s]["leveled"] = tempUI[i][j][2][int][2];
                    newUI[faction][name][s]["inactiveReturn"] = tempUI[i][j][2][int][3];
                    newUI[faction][name][s]["promotion"] = tempUI[i][j][2][int][4];
                    newUI[faction][name][s]["demotion"] = tempUI[i][j][2][int][5];
                    newUI[faction][name][s]["note"] = tempUI[i][j][2][int][6];
                    newUI[faction][name][s]["officerNote"] = tempUI[i][j][2][int][7];
                    newUI[faction][name][s]["customNote"] = tempUI[i][j][2][int][14];
                    newUI[faction][name][s]["nameChange"] = tempUI[i][j][2][int][8];
                    newUI[faction][name][s]["rankRename"] = tempUI[i][j][2][int][9];
                    newUI[faction][name][s]["eventAnnounce"] = tempUI[i][j][2][int][10];
                    newUI[faction][name][s]["left"] = tempUI[i][j][2][int][11];
                    newUI[faction][name][s]["recommend"] = tempUI[i][j][2][int][12];
                    newUI[faction][name][s]["banned"] = tempUI[i][j][2][int][13];

                end

                newUI[faction][name]["includeBirthdaysInAudit"] = true;                                   -- New setting option is added
            end

        end
        GRM_AddonSettings_Save = newUI;
    end
end


GRM_Patch.CollectAllGuildNames = function()
    local result = {};
    local F = "H";

    if GRM_PlayerListOfAlts_Save["H"] == nil then

        for i = 1 , #GRM_PlayerListOfAlts_Save do
            if i == 2 then
                F = "A";
            end
            result[ F ] = {};

            for j = 2 , #GRM_PlayerListOfAlts_Save[i] do
                if type ( GRM_PlayerListOfAlts_Save[i][j][1] ) ~= "string" and string.find ( GRM_PlayerListOfAlts_Save[i][j][1][1] , "-" ) ~= nil then
                    result[ F ][ GRM_PlayerListOfAlts_Save[i][j][1][1] ] = {};
                end
            end
        end
    else
        for i = 1 , 2 do
            if i == 2 then
                F = "A";
            end

            result[ F ] = {};

            for guildName in pairs ( GRM_PlayerListOfAlts_Save[ F ] ) do
                result[ F ][ guildName ] = {};
            end

        end
    end

    return result;
end

-- Method:          GRM_Patch.ConvertListOfAddonAlts()
-- What it Does:    Converts the old database array into a keyed dictionary
-- Purpose:         Faster efficiency in accessing player info.
GRM_Patch.ConvertListOfAddonAlts = function()

    DBGuildNames = GRM_Patch.CollectAllGuildNames();

    if GRM_PlayerListOfAlts_Save["H"] == nil then
        local tempUI = GRM.DeepCopyArray ( GRM_PlayerListOfAlts_Save );
        local newUI = {};

        newUI["H"] = {};
        newUI["A"] = {};

        local f = "H";
        local gName;

        for i = 1 , 2 do
            gName = "";

            if i == 2 then
                f = "A";
            end

            for j = 2 , #tempUI[i] do

                if type ( tempUI[i][j][1] ) ~= "string" and string.find ( tempUI[i][j][1][1] , "-" ) ~= nil and newUI[f][ tempUI[i][j][1][1] ] == nil then

                    gName = tempUI[i][j][1][1];
                    newUI[f][ gName ] = {};                                 -- Set the guild Name

                    for s = 2 , #tempUI[i][j] do                            -- Each player in a guild
                        newUI[f][ gName ][ tempUI[i][j][s][1] ] = {};
                    end
                end
            end
        end

        GRM_PlayerListOfAlts_Save = newUI;
    end
end

-- 1.84 (DB Overhaul)
-- Method:          GRM_Patch.ConvertBackupDB()
-- What it Does:    Converts the old database array into a keyed dictionary
-- Purpose:         Faster efficiency in accessing player info.
GRM_Patch.ConvertBackupDB = function()

    if GRM_GuildDataBackup_Save["H"] == nil then
        local tempUI = GRM.DeepCopyArray ( GRM_GuildDataBackup_Save );
        local newUI = {};

        DBGuildNames = DBGuildNames or GRM_Patch.CollectAllGuildNames();

        newUI["H"] = {};
        newUI["A"] = {};

        local f = "H";
        local gName;

        for i = 1 , 2 do
            gName = "";

            if i == 2 then
                f = "A";
            end

            for j = 2 , #tempUI[i] do

                if type ( tempUI[i][j][1] ) ~= "string" and string.find ( tempUI[i][j][1][1] , "-" ) ~= nil and newUI[f][ tempUI[i][j][1][1] ] == nil then            -- Purge old broken database
                    gName = tempUI[i][j][1][1];
                    if tempUI[i][j][1][2] == "0-0-1999" then
                        tempUI[i][j][1][2] = "";
                    end
                    newUI[f][ gName ] = { tempUI[i][j][1][2] };                             -- Set the guild Name

                    local v = "Auto";
                    for k = 1 , 2 do
                        if k == 2 then
                            v = "Manual";
                        end

                        newUI[f][ gName ][v] = {};                                         -- Now setting each backup to their own entry
                        newUI[f][ gName ][v]["date"] = "";
                        newUI[f][ gName ][v]["epochDate"] = 0;
                        newUI[f][ gName ][v]["members"] = {};
                        newUI[f][ gName ][v]["formerMembers"] = {};
                        newUI[f][ gName ][v]["log"] = {};

                    end

                    if tempUI[i][j][1][2] ~= "" then
                        -- Copy over the backupData
                        if #tempUI[i][j][2] > 0 then
                            newUI[f][ gName ]["Auto"] = { 1 };
                            newUI[f][ gName ]["Auto"]["date"] = tempUI[i][j][2][1];
                            newUI[f][ gName ]["Auto"]["epochDate"] = tempUI[i][j][2][2];
                            newUI[f][ gName ]["Auto"]["members"] = GRM.DeepCopyArray ( tempUI[i][j][2][3] );
                            newUI[f][ gName ]["Auto"]["formerMembers"] = GRM.DeepCopyArray ( tempUI[i][j][2][4] );
                            newUI[f][ gName ]["Auto"]["log"] = GRM.DeepCopyArray ( tempUI[i][j][2][5] );
                        end
                        if tempUI[i][j][3] ~= nil and #tempUI[i][j][3] > 0 then
                            newUI[f][ gName ]["Manual"] = { 1 };
                            newUI[f][ gName ]["Manual"]["date"] = tempUI[i][j][3][1];
                            newUI[f][ gName ]["Manual"]["epochDate"] = tempUI[i][j][3][2];
                            newUI[f][ gName ]["Manual"]["members"] = GRM.DeepCopyArray ( tempUI[i][j][3][3] );
                            newUI[f][ gName ]["Manual"]["formerMembers"] = GRM.DeepCopyArray ( tempUI[i][j][3][4] );
                            newUI[f][ gName ]["Manual"]["log"] = GRM.DeepCopyArray ( tempUI[i][j][3][5] );
                        end
                    end
                end
            end

            -- Due to dealing with an old bug of a database being converted and normalizing database properly.
            for names in pairs ( DBGuildNames[f] ) do
                if newUI[f][ names ] == nil then
                    newUI[f][ names ] = { "" };
                    local type = "Auto";
                    for k = 1 , 2 do
                        if k == 2 then
                            type = "Manual";
                        end
                        newUI[f][ names ][type] = {};
                        newUI[f][ names ][type]["date"] = "";
                        newUI[f][ names ][type]["epochDate"] = 0;
                        newUI[f][ names ][type]["members"] = {};
                        newUI[f][ names ][type]["formerMembers"] = {};
                        newUI[f][ names ][type]["log"] = {};
                    end
                end
            end

        end

        GRM_GuildDataBackup_Save = newUI;
    end
end

-- 1.84 (DB Overhaul)
-- Method:          adaptLogDB ( table , table , string , string )
-- What it Does:    Adapts the old DB to the new
-- Purpose:         Resolve a lingering issue that could occur if the log ever grows > 30,000 lines.
local adaptLogDB = function ( newUI , tempUI , f )
    local gName = tempUI[1][1];

    newUI[f][ gName ] = {};                         -- Set the guild Name
    table.remove ( tempUI , 1 );                    -- No need to keep the name/creation date index. Irrelevant position and info now.

    -- Copy over the Log Entries
    for s = 1 , #tempUI do

        newUI[f][ gName ][s] = tempUI[s];

    end

    return newUI[f][gName] , tempUI;
end

-- 1.84 (DB Overhaul)
-- What it Does:    Adapts the old DB to the new
-- Purpose:         Resolve a lingering issue that could occur if the log ever grows > 30,000 lines, and now sets no limit.
local convertBackLogDB = function ( backupLog )
    local newUI = {};

    table.remove ( backupLog , 1 );

    -- Copy over the Log Entries
    for s = 1 , #backupLog do

        newUI[ s ] = backupLog[ s ];
    end

    return newUI;
end

-- 1.84 (DB Overhaul)
-- Method:          GRM_Patch.ConvertLogDB()
-- What it Does:    Converts the old database array into a keyed dictionary
-- Purpose:         Faster efficiency in accessing player info.
GRM_Patch.ConvertLogDB = function()

    if GRM_LogReport_Save["H"] == nil then
        local tempUI = GRM.DeepCopyArray ( GRM_LogReport_Save );
        local newUI = {};
        DBGuildNames = DBGuildNames or GRM_Patch.CollectAllGuildNames();

        newUI["H"] = {};
        newUI["A"] = {};

        local f = "H";
        local gName;

        for i = 1 , 2 do
            gName = "";

            if i == 2 then
                f = "A";
            end

            for j = 2 , #tempUI[i] do

                if type ( tempUI[i][j][1] ) ~= "string" and string.find ( tempUI[i][j][1][1] , "-" ) ~= nil and newUI[f][ tempUI[i][j][1][1] ] == nil then            -- Purge old broken database
                    gName = tempUI[i][j][1][1];
                    newUI[f][ gName ] , tempUI[i][j] = adaptLogDB ( newUI , tempUI[i][j] , f );

                    -- Now, need to update the backup logReports if they exist as well.
                    if #GRM_GuildDataBackup_Save[f][gName].Auto > 0 then
                        GRM_GuildDataBackup_Save[f][gName]["Auto"]["log"] = convertBackLogDB ( GRM_GuildDataBackup_Save[f][gName]["Auto"]["log"] );
                    end

                    if #GRM_GuildDataBackup_Save[f][gName].Manual > 0 then
                        GRM_GuildDataBackup_Save[f][gName]["Manual"]["log"] = convertBackLogDB ( GRM_GuildDataBackup_Save[f][gName]["Manual"]["log"] );
                    end
                end
            end

            for names in pairs ( DBGuildNames[f] ) do
                if newUI[f][ names ] == nil then
                    newUI[f][ names ] = {};
                end
            end

        end

        GRM_LogReport_Save = newUI;
    end
end

-- 1.84 (DB overhaul)
-- Method:          GRM_Patch.ConvertMiscToNewDB()
-- what it Does:    Converts the old array format of the database of looking up players to the new
-- Purpose:         Overhaul of database to take advantage of Lua key hashmapping that is built-in.
GRM_Patch.ConvertMiscToNewDB = function()
    if #GRM_Misc > 0 and #GRM_Misc[1] == 7 then
        local tempUI = GRM.DeepCopyArray ( GRM_Misc );
        local newUI = {};

        for i = 1 , #tempUI do
            newUI[tempUI[i][1]] = {
                tempUI[i][2],
                tempUI[i][3],
                tempUI[i][4],
            };
        end

        GRM_Misc = newUI;
    end
end


-- 1.84 DB overhaul
-- Method:          GRM_Patch.ConvertCalenderDB()
-- What it Does:    Converts the old database array into a keyed dictionary
-- Purpose:         Faster efficiency in accessing player info.
GRM_Patch.ConvertCalenderDB = function()

    if GRM_CalendarAddQue_Save["H"] == nil then
        local tempUI = GRM.DeepCopyArray ( GRM_CalendarAddQue_Save );
        local newUI = {};
        DBGuildNames = DBGuildNames or GRM_Patch.CollectAllGuildNames();

        newUI["H"] = {};
        newUI["A"] = {};

        local f = "H";
        local gName;

        for i = 1 , 2 do
            gName = "";

            if i == 2 then
                f = "A";
            end

            for j = 2 , #tempUI[i] do

                if type ( tempUI[i][j][1] ) ~= "string" and string.find ( tempUI[i][j][1][1] , "-" ) ~= nil and newUI[f][ tempUI[i][j][1][1] ] == nil then

                    gName = tempUI[i][j][1][1];
                    newUI[f][ gName ] = {};                                 -- Set the guild Name

                    for s = 2 , #tempUI[i][j] do                            -- Each Calendar Entry
                        newUI[f][ gName ][s - 1] = tempUI[i][j][s];
                    end
                end
            end

            for names in pairs ( DBGuildNames[f] ) do
                if newUI[f][ names ] == nil then
                    newUI[f][ names ] = {};
                end
            end
        end

        GRM_CalendarAddQue_Save = newUI;
    end
end


-- 1.84 DB overhaul
-- Method:          GRM_Patch.ConvertPlayerMetaDataDB( table )
-- What it Does:    Converts the old database array into a keyed dictionary
-- Purpose:         Faster efficiency in accessing player info.
GRM_Patch.ConvertPlayerMetaDataDB = function( database , version )
    local result = nil;

    if database["H"] == nil then
        local tempUI = GRM.DeepCopyArray ( database );
        local newUI = {};
        DBGuildNames = DBGuildNames or GRM_Patch.CollectAllGuildNames();

        newUI["H"] = {};
        newUI["A"] = {};

        local f = "H";
        local gName;
        local member;
        local defaultDate = ( "1 Jan '01 00:01" .. GRM.L ( "24HR_Notation" ) );

        for i = 1 , 2 do
            gName = "";

            if i == 2 then
                f = "A";
            end

            for j = 2 , #tempUI[i] do

                if type ( tempUI[i][j][1] ) ~= "string"  and string.find ( tempUI[i][j][1][1] , "-" ) ~= nil and newUI[f][ tempUI[i][j][1][1] ] == nil then

                    local numRanks;
                    local clubID;

                    gName = tempUI[i][j][1][1];
                    if tempUI[i][j][1][2] == "0-0-1999" then
                        tempUI[i][j][1][2] = "";
                    end
                    newUI[f][ gName ] = {};
                    newUI[f][ gName ]["grmName"] = tempUI[i][j][1][1];
                    newUI[f][ gName ]["grmCreationDate"] = tempUI[i][j][1][2];

                    if version == 1 then
                        if tempUI[i][j][1][3] == nil then
                            newUI[f][ gName ]["grmNumRanks"] = 0;       -- might not be accurate, but chances are it will be.
                        else
                            newUI[f][ gName ]["grmNumRanks"] = tempUI[i][j][1][3];
                        end
                        numRanks = newUI[f][ gName ]["grmNumRanks"];
                        if tempUI[i][j][1][4] == nil then
                            newUI[f][ gName ]["grmClubID"] = 0;
                        else
                            newUI[f][ gName ]["grmClubID"] = tempUI[i][j][1][4];
                        end
                        clubID = newUI[f][ gName ]["grmClubID"];
                    end

                    for s = 2 , #tempUI[i][j] do

                        newUI[f][ gName ][ tempUI[i][j][s][1] ] = {};           -- Established the player in new DB format as a key
                        member = newUI[f][ gName ][ tempUI[i][j][s][1] ];

                        -- Now, convert the player's metaData over;
                        -- Removed indexes: 2 , 3 , 12 , 13 , 14 , 26, 38
                        member["name"] = tempUI[i][j][s][1];
                        member["rankName"] = tempUI[i][j][s][4]
                        member["rankIndex"] = tempUI[i][j][s][5];
                        member["level"] = tempUI[i][j][s][6];
                        member["note"] = tempUI[i][j][s][7];
                        member["officerNote"] = tempUI[i][j][s][8];
                        member["class"] = tempUI[i][j][s][9];
                        member["isMain"] = tempUI[i][j][s][10];
                        member["alts"] = tempUI[i][j][s][11];
                        member["leftGuildDate"] = tempUI[i][j][s][15];
                        member["leftGuildEpoch"] = tempUI[i][j][s][16];
                        member["bannedInfo"] = tempUI[i][j][s][17];
                        member["reasonBanned"] = tempUI[i][j][s][18];
                        member["oldRank"] = tempUI[i][j][s][19];
                        member["joinDate"] = tempUI[i][j][s][20];
                        member["joinDateEpoch"] = tempUI[i][j][s][21];
                        member["events"] = tempUI[i][j][s][22];
                        member["customNote"] = tempUI[i][j][s][23];
                        member["lastOnline"] = tempUI[i][j][s][24];
                        member["rankHistory"] = tempUI[i][j][s][25];
                        member["recommendToKick"] = tempUI[i][j][s][27];
                        member["zone"] = tempUI[i][j][s][28];
                        member["achievementPoints"] = tempUI[i][j][s][29];
                        member["isMobile"] = tempUI[i][j][s][30];
                        member["guildRep"] = tempUI[i][j][s][31];
                        member["timeEnteredZone"] = tempUI[i][j][s][32];
                        member["isOnline"] = tempUI[i][j][s][33];
                        member["status"] = tempUI[i][j][s][34];
                        member["verifiedJoinDate"] = tempUI[i][j][s][35];

                        if member["verifiedJoinDate"][1] == "1 Jan '01 12:01am" or member["verifiedJoinDate"][1] == defaultDate or member["verifiedJoinDate"][1] == nil then
                            member["verifiedJoinDate"] = { "" , 0 };
                        end

                        member["verifiedPromoteDate"] = tempUI[i][j][s][36];

                        if member["verifiedPromoteDate"][1] == "1 Jan '01 12:01am" or member["verifiedPromoteDate"][1] == defaultDate or member["verifiedPromoteDate"][1] == nil then
                            member["verifiedPromoteDate"] = { "" , 0 };
                        end

                        member["removedAlts"] = tempUI[i][j][s][37];
                        if type ( tempUI[i][j][s][39] ) == "table" then             --  Eliminates an old bug
                            member["mainStatusChangeTime"] = 0;
                        else
                            member["mainStatusChangeTime"] = tempUI[i][j][s][39];
                        end
                        member["joinDateUnknown"] = tempUI[i][j][s][40];
                        member["promoteDateUnknown"] = tempUI[i][j][s][41];
                        member["GUID"] = tempUI[i][j][s][42];
                        member["isUnknown"] = tempUI[i][j][s][43];
                        member["birthdayUnknown"] = tempUI[i][j][s][44];
                        member["safeList"] = tempUI[i][j][s][45];
                        member["race"] = tempUI[i][j][s][46];
                        member["sex"] = tempUI[i][j][s][47];
                    end

                    -- BACKUP UPDATE TOO!!!

                    if version == 1 then
                        GRM_Patch.ConvertBackupPlayerDataPreCheck ( f , gName , tempUI[i][j][1][2] , numRanks , clubID );
                    end

                end
            end

            for names in pairs ( DBGuildNames[f] ) do
                if newUI[f][ names ] == nil then
                    newUI[f][ names ] = {};
                    newUI[f][ names ]["grmName"] = names;
                    newUI[f][ names ]["grmCreationDate"] = "";

                    if version == 1 then
                        newUI[f][ names ]["grmNumRanks"] = 0;
                        newUI[f][ names ]["grmClubID"] = 0;
                    end
                end
            end

        end
        result = newUI;
    end

    if result == nil then
        result = database;
    end

    return result;
end

-- Method:          GRM_Patch.ConvertBackupPlayerDataPreCheck ( string , string )
-- What it Does:    Pre-checks if needs to do a DB update if backup exists, and if it does, runs it through
-- Purpose:         Can't just update the normal data. You need to update the backup Data as well
GRM_Patch.ConvertBackupPlayerDataPreCheck = function( f , gName , creationDate , numRanks , clubID )
    if #GRM_GuildDataBackup_Save[f][gName].Auto > 0 then
        GRM_GuildDataBackup_Save[f][gName]["Auto"]["members"] = GRM_Patch.ConvertBackupPlayerData ( GRM_GuildDataBackup_Save[f][gName]["Auto"]["members"] , gName , creationDate , 1 , numRanks , clubID );
        GRM_GuildDataBackup_Save[f][gName]["Auto"]["formerMembers"] = GRM_Patch.ConvertBackupPlayerData ( GRM_GuildDataBackup_Save[f][gName]["Auto"]["formerMembers"] , gName , creationDate , 2 );
    end

    if #GRM_GuildDataBackup_Save[f][gName].Manual > 0 then
        GRM_GuildDataBackup_Save[f][gName]["Manual"]["members"] = GRM_Patch.ConvertBackupPlayerData ( GRM_GuildDataBackup_Save[f][gName]["Manual"]["members"] , gName , creationDate , 1 , numRanks , clubID );
        GRM_GuildDataBackup_Save[f][gName]["Manual"]["formerMembers"] = GRM_Patch.ConvertBackupPlayerData ( GRM_GuildDataBackup_Save[f][gName]["Manual"]["formerMembers"] , gName , creationDate , 2 );
    end
end

-- Method:          GRM_Patch.ConvertBackupPlayerData ( table )
-- What it does:    Takes the backup data and converts it to the new DB format
-- Purpose:         Conversion of the DB
GRM_Patch.ConvertBackupPlayerData = function ( playerData , guildName , creationDate , version , numRanks , clubID )
    local tempUI = GRM.DeepCopyArray ( playerData );
    local result = {};
    local newDB = {};
    local member;
    local defaultDate = ( "1 Jan '01 00:01" .. GRM.L ( "24HR_Notation" ) );

    newDB["grmName"] = guildName;
    newDB["grmCreationDate"] = creationDate;

    if version == 1 then
        newDB["grmNumRanks"] = numRanks;
        newDB["grmClubID"] = clubID;
    end

    for s = 2 , #tempUI do

        newDB[ tempUI[s][1] ] = {};           -- Established the player in new DB format as a key
        member = newDB[ tempUI[s][1] ];

        -- Now, convert the player's metaData over;
        -- Removed indexes: 2 , 3 , 12 , 13 , 14 , 26, 38
        member["name"] = tempUI[s][1];
        member["rankName"] = tempUI[s][4]
        member["rankIndex"] = tempUI[s][5];
        member["level"] = tempUI[s][6];
        member["note"] = tempUI[s][7];
        member["officerNote"] = tempUI[s][8];
        member["class"] = tempUI[s][9];
        member["isMain"] = tempUI[s][10];
        member["alts"] = tempUI[s][11];
        member["leftGuildDate"] = tempUI[s][15];
        member["leftGuildEpoch"] = tempUI[s][16];
        member["bannedInfo"] = tempUI[s][17];
        member["reasonBanned"] = tempUI[s][18];
        member["oldRank"] = tempUI[s][19];
        member["joinDate"] = tempUI[s][20];
        member["joinDateEpoch"] = tempUI[s][21];
        member["events"] = tempUI[s][22];
        member["customNote"] = tempUI[s][23];
        member["lastOnline"] = tempUI[s][24];
        member["rankHistory"] = tempUI[s][25];
        member["recommendToKick"] = tempUI[s][27];
        member["zone"] = tempUI[s][28];
        member["achievementPoints"] = tempUI[s][29];
        member["isMobile"] = tempUI[s][30];
        member["guildRep"] = tempUI[s][31];
        member["timeEnteredZone"] = tempUI[s][32];
        member["isOnline"] = tempUI[s][33];
        member["status"] = tempUI[s][34];
        member["verifiedJoinDate"] = tempUI[s][35];

        if member["verifiedJoinDate"][1] == "1 Jan '01 12:01am" or member["verifiedJoinDate"][1] == defaultDate or member["verifiedJoinDate"][1] == nil then
            member["verifiedJoinDate"] = { "" , 0 };
        end

        member["verifiedPromoteDate"] = tempUI[s][36];

        if member["verifiedPromoteDate"][1] == "1 Jan '01 12:01am" or member["verifiedPromoteDate"][1] == defaultDate or member["verifiedPromoteDate"][1] == nil then
            member["verifiedPromoteDate"] = { "" , 0 };
        end

        member["removedAlts"] = tempUI[s][37];
        if type ( tempUI[s][39] ) == "table" then             --  Eliminates an old bug
            member["mainStatusChangeTime"] = 0;
        else
            member["mainStatusChangeTime"] = tempUI[s][39];
        end
        member["joinDateUnknown"] = tempUI[s][40];
        member["promoteDateUnknown"] = tempUI[s][41];
        member["GUID"] = tempUI[s][42];
        member["isUnknown"] = tempUI[s][43];
        member["birthdayUnknown"] = tempUI[s][44];
        member["safeList"] = tempUI[s][45];
        member["race"] = tempUI[s][46];
        member["sex"] = tempUI[s][47];
    end

    result = newDB;

    return result;
end

-- 1.841
-- Method:          GRM_Patch.FixNameChangePreReleaseBug()
-- What it Does:    Removes a double copy in the DB that occurs by changing the name
-- Purpose:         Fix a beta error
GRM_Patch.FixNameChangePreReleaseBug = function()

    for F in pairs ( GRM_GuildMemberHistory_Save ) do
        for guildName in pairs ( GRM_GuildMemberHistory_Save[F] ) do
            for name , playerData in pairs ( GRM_GuildMemberHistory_Save[F][guildName] ) do
                if type ( playerData ) == "table" and name ~= playerData.name then
                    GRM_GuildMemberHistory_Save[F][guildName][playerData.name] = nil;
                    GRM_GuildMemberHistory_Save[F][guildName][playerData.name] = {};
                    GRM_GuildMemberHistory_Save[F][guildName][playerData.name] = GRM.DeepCopyArray ( GRM_GuildMemberHistory_Save[F][guildName][name] );
                    GRM_GuildMemberHistory_Save[F][guildName][name] = nil;
                end
            end
        end
    end

    for F in pairs ( GRM_PlayersThatLeftHistory_Save ) do
        for guildName in pairs ( GRM_PlayersThatLeftHistory_Save[F] ) do
            for name , playerData in pairs ( GRM_PlayersThatLeftHistory_Save[F][guildName] ) do
                if type ( playerData ) == "table" and name ~= playerData.name then
                    GRM_PlayersThatLeftHistory_Save[F][guildName][playerData.name] = nil;
                    GRM_PlayersThatLeftHistory_Save[F][guildName][playerData.name] = {};
                    GRM_PlayersThatLeftHistory_Save[F][guildName][playerData.name] = GRM.DeepCopyArray ( GRM_PlayersThatLeftHistory_Save[F][guildName][name] );
                    GRM_PlayersThatLeftHistory_Save[F][guildName][name] = nil;
                end
            end
        end
    end

end
-- Method:          GRM_Patch.LegacyPurge ( string , string )
-- What it Does:    Removes the database of this guild compeltely
-- Purpose:         Deal with old errors from legacy data.
GRM_Patch.LegacyPurge = function ( guildName , faction )
    GRM_GuildMemberHistory_Save[faction][guildName] = nil;
    GRM_PlayersThatLeftHistory_Save[faction][guildName] = nil;
    GRM_CalendarAddQue_Save[faction][guildName] = nil;
    GRM_LogReport_Save[faction][guildName] = nil;
    GRM_GuildDataBackup_Save[faction][guildName] = nil;
    GRM_PlayerListOfAlts_Save[faction][guildName] = nil;
    GRM_Alts[guildName] = nil;
end

-- 1.87
-- Method:          GRM_Patch.ModifyMemberData ( function , bool , bool , bool )
-- What it Does:    Goes through the entire account wide database and modifies a player's or guild's metadata based on the actions of the given function
-- Purpose:         Reusable function for error work and to avoid on code bloat spam.
GRM_Patch.ModifyMemberData = function ( databaseChangeFunction , editCurrentPlayers , editLeftPlayers , includeAllGuildData , modifier )

    if editCurrentPlayers then
        for F in pairs ( GRM_GuildMemberHistory_Save ) do                         -- Horde and Alliance
            for guildName in pairs ( GRM_GuildMemberHistory_Save[F] ) do                  -- The guilds in each faction
                if type ( GRM_GuildMemberHistory_Save[F][guildName] ) == "table" then
                    for name , player in pairs ( GRM_GuildMemberHistory_Save[F][guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                        if type ( player ) == "table" then
                            if includeAllGuildData then
                                GRM_GuildMemberHistory_Save[F][guildName][name] = databaseChangeFunction ( GRM_GuildMemberHistory_Save[F][guildName] , player , modifier );
                            else
                                GRM_GuildMemberHistory_Save[F][guildName][name] = databaseChangeFunction ( player , modifier );
                            end
                        end
                    end
                else
                    GRM_Patch.LegacyPurge ( guildName , F );
                end
            end
        end
    end

    -- Former memebrs
    if editLeftPlayers then
        for F in pairs ( GRM_PlayersThatLeftHistory_Save ) do                         -- Horde and Alliance
            for guildName in pairs ( GRM_PlayersThatLeftHistory_Save[F] ) do                  -- The guilds in each faction
                for name , player in pairs ( GRM_PlayersThatLeftHistory_Save[F][guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                    if type ( player ) == "table" then
                        if includeAllGuildData then
                            GRM_PlayersThatLeftHistory_Save[F][guildName][name] = databaseChangeFunction ( GRM_PlayersThatLeftHistory_Save[F][guildName] , player , modifier );
                        else
                            GRM_PlayersThatLeftHistory_Save[F][guildName][name] = databaseChangeFunction ( player , modifier );
                        end
                    end
                end
            end
        end
    end

    -- Check the backup data as well.
    local backup = { "Auto" , "Manual" , "members" , "formerMembers" };
    for F in pairs ( GRM_GuildDataBackup_Save ) do
        for guildName in pairs ( GRM_GuildDataBackup_Save[F] ) do
            for i = 1 , 2 do            -- Auto vs Manual

                if not GRM_GuildDataBackup_Save[F][guildName][backup[i]] then

                    for j = 1 , 2 do

                        GRM_GuildDataBackup_Save[ F ][ guildName ][backup[j]] = {};
                        GRM_GuildDataBackup_Save[ F ][ guildName ][backup[j]]["date"] = "";
                        GRM_GuildDataBackup_Save[ F ][ guildName ][backup[j]]["epochDate"] = 0;
                        GRM_GuildDataBackup_Save[ F ][ guildName ][backup[j]]["members"] = {};
                        GRM_GuildDataBackup_Save[ F ][ guildName ][backup[j]]["formerMembers"] = {};
                        GRM_GuildDataBackup_Save[ F ][ guildName ][backup[j]]["log"] = {};
                    end
                end

                if #GRM_GuildDataBackup_Save[F][guildName][backup[i]] > 0 then

                    for j = 3 , 4 do        -- Member vs formerMember

                        if ( j == 3 and editCurrentPlayers ) or ( j == 4 and editLeftPlayers ) then
                            if GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] == nil or #GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] > 0 then
                                GRM_GuildDataBackup_Save[F][guildName][backup[i]] = {};
                            else
                                for name , player in pairs ( GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] ) do
                                    if type ( player ) == "table" then
                                        if includeAllGuildData then
                                            GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]][name] = databaseChangeFunction ( GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] , player , modifier );
                                        else
                                            GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]][name] = databaseChangeFunction ( player , modifier );
                                        end
                                    end
                                end
                            end
                        end
                    end

                end
            end
        end
    end
end

-- 1.87
-- Method:          GRM_Patch.ModifyGuildValue ( function )
-- What it Does:    Goes through the entire account wide database and modifies a guild's metadata based on the actions of the given function
-- Purpose:         Reusable function for error work and to avoid on code bloat spam.
GRM_Patch.ModifyGuildValue = function ( databaseChangeFunction )
    for F in pairs ( GRM_GuildMemberHistory_Save ) do                         -- Horde and Alliance
        for guildName in pairs ( GRM_GuildMemberHistory_Save[F] ) do                  -- The guilds in each faction
            GRM_GuildMemberHistory_Save[F][guildName] = databaseChangeFunction ( GRM_GuildMemberHistory_Save[F][guildName] );
        end
    end

    -- Former memebrs
    for F in pairs ( GRM_PlayersThatLeftHistory_Save ) do                         -- Horde and Alliance
        for guildName in pairs ( GRM_PlayersThatLeftHistory_Save[F] ) do                  -- The guilds in each faction
            GRM_PlayersThatLeftHistory_Save[F][guildName] = databaseChangeFunction ( GRM_PlayersThatLeftHistory_Save[F][guildName] );
        end
    end

    -- Check the backup data as well.
    local backup = { "Auto" , "Manual" , "members" , "formerMembers" };
    for F in pairs ( GRM_GuildDataBackup_Save ) do
        for guildName in pairs ( GRM_GuildDataBackup_Save[F] ) do
            for i = 1 , 2 do            -- Auto vs Manual
                if #GRM_GuildDataBackup_Save[F][guildName][backup[i]] > 0 then
                    for j = 3 , 4 do        -- Member vs formerMember
                        if GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] == nil or #GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] > 0 then
                            GRM_GuildDataBackup_Save[F][guildName][backup[i]] = {};
                        else
                            GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] = databaseChangeFunction ( GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] );
                        end
                    end

                end
            end
        end
    end
end

-- 1.92
-- Method:          GRM_Patch.AddMemberMetaData ( string , variable )
-- What it Does:    Goes through the entire account wide database and adds the player's metadata a new setting
-- Purpose:         Reusable function for error work and to avoid on code bloat spam.
GRM_Patch.AddMemberMetaData = function ( settingName , value )
    for F in pairs ( GRM_GuildMemberHistory_Save ) do                         -- Horde and Alliance
        for guildName in pairs ( GRM_GuildMemberHistory_Save[F] ) do                  -- The guilds in each faction
            for _ , player in pairs ( GRM_GuildMemberHistory_Save[F][guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild
                if type ( player ) == "table" then
                    player[settingName] = value;
                end
            end
        end
    end

    -- Former memebrs
    for F in pairs ( GRM_PlayersThatLeftHistory_Save ) do                         -- Horde and Alliance
        for guildName in pairs ( GRM_PlayersThatLeftHistory_Save[F] ) do                  -- The guilds in each faction
            for _ , player in pairs ( GRM_PlayersThatLeftHistory_Save[F][guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
                if type ( player ) == "table" then
                    player[settingName] = value;
                end
            end
        end
    end

    -- Check the backup data as well.
    local backup = { "Auto" , "Manual" , "members" , "formerMembers" };
    for F in pairs ( GRM_GuildDataBackup_Save ) do
        for guildName in pairs ( GRM_GuildDataBackup_Save[F] ) do
            for i = 1 , 2 do            -- Auto vs Manual
                if #GRM_GuildDataBackup_Save[F][guildName][backup[i]] > 0 then

                    for j = 3 , 4 do        -- Member vs formerMember

                        if GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] == nil or #GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] > 0 then
                            GRM_GuildDataBackup_Save[F][guildName][backup[i]] = {};
                        else
                            for _ , player in pairs ( GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] ) do
                                if type ( player ) == "table" then
                                    player[settingName] = value;
                                end
                            end
                        end
                    end

                end
            end
        end
    end
end

-- 1.87
-- Method:          GRM_Patch.ModifyPlayerSetting ( string , function )
-- What it Does:    Allows the player to modify an existing setting to a new value given the valueOrLogic function
-- Purpose:         To be able to retroactively adapt and make changes to the database.
GRM_Patch.ModifyPlayerSetting = function ( setting , valueOrLogic , additionalSetting )
    for F in pairs ( GRM_AddonSettings_Save ) do
        for p in pairs ( GRM_AddonSettings_Save[F] ) do
            if type ( valueOrLogic ) == "function" then
                if additionalSetting then
                    if GRM_AddonSettings_Save[F][p][setting][additionalSetting] ~= nil then
                        GRM_AddonSettings_Save[F][p][setting][additionalSetting] = valueOrLogic ( GRM_AddonSettings_Save[F][p][setting] );
                    end
                else
                    GRM_AddonSettings_Save[F][p][setting] = valueOrLogic ( GRM_AddonSettings_Save[F][p][setting] );
                end
            else
                if additionalSetting then
                    if GRM_AddonSettings_Save[F][p][setting][additionalSetting] ~= nil then
                        GRM_AddonSettings_Save[F][p][setting][additionalSetting] = valueOrLogic;
                    end
                else
                    GRM_AddonSettings_Save[F][p][setting] = valueOrLogic;
                end
            end
        end
    end
end

-- 1.943
-- Method:          GRM_Patch.ModifyOrAddMacroRuleSetting ( string , string , function or type )
-- What it Does:    Allows the player to modify an existing setting to a new value given the valueOrLogic function
-- Purpose:         To be able to retroactively adapt and make changes to the database of macro rules
GRM_Patch.ModifyOrAddMacroRuleSetting = function ( ruleType , setting , valueOrFunction )
    for F in pairs ( GRM_AddonSettings_Save ) do
        for p in pairs ( GRM_AddonSettings_Save[F] ) do
            if not GRM_AddonSettings_Save[F][p][ruleType] then
                GRM_AddonSettings_Save[F][p][ruleType] = {};
            end
            for _,rule in pairs ( GRM_AddonSettings_Save[F][p][ruleType] ) do

                if type ( valueOrFunction ) == "function" then
                    rule = valueOrFunction ( rule , setting );
                else
                    rule[setting] = valueOrFunction;
                end

            end
        end
    end
end

-- 1.87
-- Method:          GRM_Patch.AddPlayerSetting ( string , object , function )
-- What it Does:    Allows the player to add a new setting to all settings profiles
-- Purpose:         To be able to retroactively adapt and make changes to the database.
GRM_Patch.AddPlayerSetting = function ( nameOfNewSetting , value , additionalLogic )
    for F in pairs ( GRM_AddonSettings_Save ) do
        for p in pairs ( GRM_AddonSettings_Save[F] ) do
            if not additionalLogic then
                GRM_AddonSettings_Save[F][p][nameOfNewSetting] = value;
            else
                GRM_AddonSettings_Save[F][p] = additionalLogic ( GRM_AddonSettings_Save[F][p] );
            end
        end
    end
end

-- 1.87
-- Method:          GRM_Patch.AddVerifiedPromotionDatesToHistory ( player )
-- What it Does:    Checks if the rank has been verified but not added to the player history and if so, adds it to player history
-- Purpose:         Correct a flaw of failed promotion date DB placement from previous update
GRM_Patch.AddVerifiedPromotionDatesToHistory = function ( player )

    if player.verifiedPromoteDate[1] ~= "" and ( #player.rankHistory == 0 or player.rankHistory[#player.rankHistory][1] == "" ) then
        local rankName = player.rankName;
        local dateString = player.verifiedPromoteDate[1];
        local dateEpoch = player.verifiedPromoteDate[2];

        if #player.rankHistory > 0 then
            player.rankHistory[#player.rankHistory][1] = rankName;
            player.rankHistory[#player.rankHistory][2] = dateString;
            player.rankHistory[#player.rankHistory][3] = dateEpoch;
        else
            table.insert ( player.rankHistory , { rankName , dateString , dateEpoch } );
        end
    end

    return player;
end

-- 1.87
-- Method:          GRM_Patch.updateKickRules ( table )
-- What it Does:    Converts the old kickRules format to the new one.
-- Purpose:         Setup the kickRules properly
GRM_Patch.updateKickRules = function( kickRules )
    local result = {};

    if #kickRules > 0 then

        local kickRule1 = GRM.L ( "Kick Rule {num}" , nil , nil , 1 );
        result[ kickRule1 ] = {};
        result[ kickRule1 ].name = kickRule1;
        result[ kickRule1 ].isEnabled = kickRules[1][5];

        result[ kickRule1 ].activityFilter = true;
        if not kickRules[1][5] then
            result[ kickRule1 ].activityFilter = false;
        end
        result[ kickRule1 ].isMonths = true;
        if not kickRules[1][3] == 2 then
            result[ kickRule1 ].isMonths = false;
        end
        result[ kickRule1 ].numDaysOrMonths = kickRules[1][4];

        result[ kickRule1 ].rankFilter = false;
        result[ kickRule1 ].ranks = {};

        result[ kickRule1 ].levelFilter = false;
        result[ kickRule1 ].levelRange = { 1 , 999 }; -- 999 represents level cap

        result[ kickRule1 ].classFilter = false;
        result[ kickRule1 ].classes = {};

        result[ kickRule1 ].raceFilter = false;
        result[ kickRule1 ].races = {};

        result[ kickRule1 ].noteMatch = false;
        result[ kickRule1 ].notesToCheck = { true , true , true };
        result[ kickRule1 ].matchingString = "";
        result[ kickRule1 ].ruleNumber = 1;
    else
        result = kickRules;     -- It has already been set, no needto overwrite!
    end

    return result
end

-- 1.88
-- Method:          GRM_Patch.fixAltGroups ( table , table )
-- What it Does:    Checks for inconsistent alt groups and de-associates them as necessary
-- Purpose:         To fix alt groupings.
GRM_Patch.fixAltGroups = function ( guildData , player )
    local altAltNames;
    local isValid = true;

    -- Collect the altNames
    local getAltNames = function ( altList , name )
        local names = {};
        for i = 1 , #altList do
            table.insert ( names , altList[i][1] );
        end
        table.insert ( names , name );
        -- Now, add my own name;
        sort ( names )
        return names;
    end

    if player.alts and #player.alts > 0 then                                    -- Only proceed if this toon has alts.
        isValid = true;                                         -- Good so far reset
        local altNames = getAltNames ( player.alts , player.name );                 -- get the list of altNames, including player, sorted
        for i = #altNames , 1 , -1 do
            if altNames[i] ~= player.name then
                if guildData[altNames[i]] == nil then           -- Some error protection - removing the name if it is no longer in the guild.
                    table.remove ( altNames , i );
                else
                    if not guildData[altNames[i]].alts then
                        guildData[altNames[i]].alts = {};
                    end
                    altAltNames = getAltNames ( guildData[altNames[i]].alts , altNames[i] );
                    for j = 1 , #altNames do
                        if altAltNames[j] == nil or altNames[j] ~= altAltNames[j] then
                            isValid = false;
                            break;
                        end
                    end
                end
            end
        end

        if not isValid then             -- If not valid clear all the alts in this grouping.
            for i = 1 , #altNames do
                guildData[altNames[i]].alts = {};
            end
        end
    else
        player.alts = {};
    end

    player.removedAlts = {};    -- Cleaning up removed alts.

    return player;
end

-- 1.947
-- Method:          GRM_Patch.VerifyMacroRuleIntegrity()
-- What it Does:    Establishes the rule if it doesn't exist
-- Purpose:         Someone with a very old version of the addon could not load it with this error and it was just reported.
GRM_Patch.VerifyMacroRuleIntegrity = function()
    for F in pairs ( GRM_AddonSettings_Save ) do
        for p in pairs ( GRM_AddonSettings_Save[F] ) do

            if GRM_AddonSettings_Save[F][p].kickRules == nil then
                GRM_AddonSettings_Save[F][p].kickRules = {};
            end
            if GRM_AddonSettings_Save[F][p].promoteRules == nil then
                GRM_AddonSettings_Save[F][p].promoteRules = {};
            end
            if GRM_AddonSettings_Save[F][p].demoteRules == nil then
                GRM_AddonSettings_Save[F][p].demoteRules = {};
            end
        end
    end
end

-- 1.872
-- Method:          GRM_Patch.FixManualBackupsFromDBLoad
-- What it Does:    CleansUpDatabases that need to be cleaned up
-- Purpose:         Apparently there is a bug where if the previous one crashed on load, the auto got updated but not manual. This resolves that by just removing it.
GRM_Patch.FixManualBackupsFromDBLoad = function()
    -- Check the backup data as well.
    local backup = { "Auto" , "Manual" , "members" , "formerMembers" };
    for F in pairs ( GRM_GuildDataBackup_Save ) do
        for guildName in pairs ( GRM_GuildDataBackup_Save[F] ) do
            for i = 1 , 2 do            -- Auto vs Manual
                if #GRM_GuildDataBackup_Save[F][guildName][backup[i]] > 0 then

                    for j = 3 , 4 do        -- Member vs formerMember
                        if GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] == nil or #GRM_GuildDataBackup_Save[F][guildName][backup[i]][backup[j]] > 0 then
                            GRM_GuildDataBackup_Save[F][guildName][backup[i]] = {};
                        end
                    end
                end
            end
        end
    end
end

-- 1.872
-- Method:          GRM_Patch.AddGroupInfoModuleSettings()
-- What it Does:    Adds the module settings for the Group Info optional plugin/module
-- Purpose:         Allow user to control the module from within the core grm page
GRM_Patch.AddGroupInfoModuleSettings = function()
    local values = {};
    values = {};
    values["enabled"] = true;
    values["InteractDistanceIndicator"] = true
    values["tradeIndicatorColorAny"] = { 0 , 0.97 , 0.97 };
    values["tradeIndicatorColorConnectedRealm"] = { 0 , 0.97 , 0.97 };

    GRM_Patch.AddPlayerSetting ( "GIModule" , values );
end

-- 1.872
-- Method:          GRM_Patch.AddTextColoringValues()
-- What it Does:    Adds a new control for message coloring
-- Purpose:         Bring log coloring controls to player UX customization options.
GRM_Patch.AddTextColoringValues = function()
    local values = {
        { 0.5 , 1.0 , 0.0 },        -- Joined
        { 0.0 , 0.44 , 0.87 },      -- Leveled
        { 0.0 , 1.0 , 0.87 },       -- Inactive Return
        { 1.0 , 0.914 , 0.0 },      -- Promotions
        { 0.91 , 0.388 , 0.047 },   -- Demotions
        { 1.0 , 0.6 , 1.0 },        -- Note
        { 1.0 , 0.094 , 0.93 },     -- Officer Note
        { 0.24 , 0.69 , 0.49 },     -- Custom Note
        { 0.90 , 0.82 , 0.62 },     -- Name Change
        { 0.64 , 0.102 , 0.102 },   -- Rank Rename
        { 0.0 , 0.8 , 1.0 },        -- Event Announce
        { 0.5 , 0.5 , 0.5 },        -- Left Guild
        { 0.65 , 0.19 , 1.0 },      -- Recommendations
        { 1.0 , 0.0 , 0.0 }         -- Banned Coloring
    };

    GRM_Patch.AddPlayerSetting ( "logColor" , values );
end

-- 1.872
-- Method:          GRM_Patch.ModifyPlayerChannelToMulti ( string )
-- What it Does:    Takes the reportChannel and converts the formatting to an array for multiple channels
-- Purpose:         To allow message output to multiple channels.
GRM_Patch.ModifyPlayerChannelToMulti = function ( reportChannel )
    local result = {};

    if reportChannel ~= "" then
        table.insert ( result , reportChannel );
    end

    return result;
end

-- 1.89
-- Method:          GRM_Patch.RemoveInvalidIndex ( table )
-- What it Does:    An old error from sync which still had the old database integer index of 40, is redundant, is now removed
-- Purpose:         Properly cleaned up database.
GRM_Patch.RemoveInvalidIndex = function ( player )

    if player[40] ~= nil then
        player[40] = nil;
    end

    return player;
end


-- 1.89
-- Method:          GRM_Patch.AddExportOptions ( table )
-- What it Does:    Adds 3 options to the xport rules for members/non members
-- Purpose:         More control of the export data.
GRM_Patch.AddExportOptions = function ( exportFilters )

    if exportFilters then
        if #exportFilters == 16 then
            exportFilters[17] = false;      -- Mains only export? False by default.
        end

        if #exportFilters == 17 then        -- Rank history
            exportFilters[18] = true;
        end

        if #exportFilters == 18 then        -- alts only or mains only
            exportFilters[19] = true;
        end

        if #exportFilters == 19 then        -- GUID
            exportFilters[20] = false;
        end

        if #exportFilters == 20 then        -- Remove special characters from sy
            exportFilters[21] = false;
        end
    end

    return exportFilters;
end

-- 1.89
-- Method:          GRM_Patch.FixUnremovedData()
-- What it Does:    Sees if there is an old index of a guild that was never purged from the core DB, though it was removed from everywhere else, and purges it
-- Purpose:         Unable to do DB conversion for some people without first resolving this old bug.
GRM_Patch.FixUnremovedData = function()

    local isGuildFound = false;

    for i = 1 , #GRM_GuildMemberHistory_Save do        -- Faction
        for j = #GRM_GuildMemberHistory_Save[i] , 2 , -1 do   -- guild

            if GRM_GuildMemberHistory_Save[i][j][1] ~= nil and GRM_GuildMemberHistory_Save[i][j][1][1] ~= nil then

                -- Let's scan through the LeftPlayerHistory to see if guild is found. If not, let's remove it.
                isGuildFound = false;

                for r = 2 , #GRM_PlayersThatLeftHistory_Save[i] do
                    if GRM_PlayersThatLeftHistory_Save[i][r][1] ~= nil and GRM_PlayersThatLeftHistory_Save[i][r][1][1] ~= nil then
                        if GRM_PlayersThatLeftHistory_Save[i][r][1][1] == GRM_GuildMemberHistory_Save[i][j][1][1] then      -- Comparing if guild names the same, then it is found
                            isGuildFound = true;
                            break;
                        end
                    end
                end

                if not isGuildFound then
                    table.remove ( GRM_GuildMemberHistory_Save[i] , j );
                end

            end
        end
    end
end

--1.89
-- Method:          GRM_Patch.FixMainTimestampError ( table )
-- What it Does:    Checks to see if incorrect information is in this data slot during sync
-- Purpose:         Fix an error that breaks sync for some people.
GRM_Patch.FixMainTimestampError = function( player )
    if type ( player.mainStatusChangeTime ) ~= "number" then
        player.mainStatusChangeTime = nil;
        player.mainStatusChangeTime = 0;
    end

    return player;
end

-- 1.89
-- Method:          GRM_Patch.AddKickRule()
-- What it Does:    Adds a new kickRuleOption
-- Purpose:         AddMoreFilters
GRM_Patch.AddKickRule = function ( kickRules )
    for name in pairs ( kickRules ) do
        if not kickRules[name].noteMatchEmpty then
            kickRules[name].noteMatchEmpty = false;
        end
        if not kickRules[name].applyRulesTo then
            kickRules[name].applyRulesTo = 1;
        end
        if not kickRules[name].applyEvenIfActiive then
            kickRules[name].applyEvenIfActiive = false;
        end
        if not kickRules[name].rankSpecialIsMonths then
            kickRules[name].rankSpecialIsMonths = true;
        end
        if not kickRules[name].rankSpecialNumDaysOrMonths then
            kickRules[name].rankSpecialNumDaysOrMonths = 12;
        end
        if not kickRules[name].repFilter then
            kickRules[name].repFilter = false;
        end
        if not kickRules[name].rep then
            kickRules[name].rep = 4;                -- Selection = neutral
        end
        if not kickRules[name].repOperator then
            kickRules[name].repOperator = 2;        -- lesser, equals, greater  2 is equals
        end
        if not kickRules[name].customLogMsg then
            kickRules[name].customLogMsg = "";
        end
        if not kickRules[name].customLog then
            kickRules[name].customLog = false;
        end
        if not kickRules[name].allAltsApplyToKick then
            kickRules[name].allAltsApplyToKick = false;
        end

    end
    return kickRules
end

-- 1.91
-- Method:          GRM_Patch.AdjustLevelCapDueToSquish()
-- What it Does:    Adjusts the level filtering to below 60 to remove potential errors
-- Purpose:         Adapt to 9.0 launch
GRM_Patch.AdjustLevelCapDueToSquish = function ( levelReportMin )
    if levelReportMin > 60 then
        levelReportMin = 50;    -- Set it to current cap
    end
    return levelReportMin;
end

-- 1.912
-- Method:          GRM_Patch.AddKickRuleOperator()
-- What it Does:    Adds a new kickRuleOption
-- Purpose:         AddMoreFilters
GRM_Patch.AddKickRuleOperator = function ( kickRules )
    for name in pairs ( kickRules ) do
        if not kickRules[name].repOperator then
            kickRules[name].repOperator = 2;        -- lesser, equals, greater  2 is equals
        end
    end
    return kickRules
end

-- 1.92
-- Method:          GRM_Patch.AddRulesValue()
-- What it Does:    Add a way to sort the rules by index
-- Purpose:         Player rule customization
GRM_Patch.AddRulesValue = function ( rules )
    local c = 1;

    for name in pairs ( rules ) do
        rules[name].ruleIndex = c;
        c = c + 1;

        -- Fixing a typo variable error save on the custom log messaging.
        if rules[name].customlog ~= nil then
            if rules[name].customlog then
                rules[name].customLog = true;
            else
                rules[name].customLog = false;
            end
        end
        rules[name].customlog = nil;
    end
    return rules;
end

-- 1.92
-- Method:          GRM_Patch.ModifyKickRuleMaxLevel()
-- What it Does:    Add a way to sort the rules by index
-- Purpose:         Player rule customization
GRM_Patch.ModifyKickRuleMaxLevel = function ( kickRules )

    for name in pairs ( kickRules ) do
        if kickRules[name].levelRange == GRM_G.LvlCap then
            kickRules[name].levelRange = 999;
        end
    end
    return kickRules;
end

-- 1.92
-- Method:          GRM_Patch.ModifyKickRuleLogic ( table )
-- What it Does:    If the player is looking for activity, this adjusts the rules to account for that so that the kick recommendations aren't overriden by secondary settings
-- Purpose:         Correction to a logic flow flaw in the settings.
GRM_Patch.ModifyKickRuleLogic = function ( kickRules )
    for name in pairs ( kickRules ) do
        if kickRules[name].activityFilter then
            kickRules[name].applyEvenIfActiive = false;
        end
    end
    return kickRules;

end

-- 1.92
-- Method:          GRM_Patch.FixLogChangeRankEntries()
-- What it Does:    Goes into every log entry for "rank changes" and checks if the "old rank" is nil or empty, implying it never saved right and then removes it  from the log.
-- Purpose:         A bug was found where this could occur, so the bug has been fixed, but we need to now cleanup the log from bad entries, especially if they ever reprocess the strings.
GRM_Patch.FixLogChangeRankEntries = function()
    for faction in pairs ( GRM_LogReport_Save ) do
        for guildName in pairs ( GRM_LogReport_Save[faction] ) do
            for i = #GRM_LogReport_Save[faction][guildName] , 1 , -1 do
                if GRM_LogReport_Save[faction][guildName][i][1] == 6 and ( GRM_LogReport_Save[faction][guildName][i][4] == "" or GRM_LogReport_Save[faction][guildName][i][4] == nil ) then
                    table.remove ( GRM_LogReport_Save[faction][guildName] , i );
                end
            end
        end
    end
end

-- 1.92
-- Method:          GRM_Patch.FixMemberRemovePlayerData ( playerObject )
-- What it Does:    Sets the removed Alts table to nil to remove the errors now that that bug no longer exists.
-- Purpose:         To fix issue with mismatching alt groupings.
GRM_Patch.FixMemberRemovePlayerData = function ( player )
    player.removedAlts = {};
    return player;
end

-- Method:          GRM_Patch.ValidateUnverifiedDate ( playerTable, string  )
-- What it Does:    Checks if formatting is valid, then if not it fixes it
-- Purpose:         Cleanup some old formatting bugs with old data. Added redundency as well.
GRM_Patch.ValidateUnverifiedDate = function( player , dateVersion )

    -- If general formatting error, replace.
    if not player.rankHistory or #player.rankHistory == 0 or player.rankHistory[1][3] == 0 then
        player.rankHistory = { {  "" , "" , 0 } };
    end

    if not player[dateVersion] or #player[dateVersion] == 0 then
        player[dateVersion] = { "" , 0 };
    end

    local toRemove = false;

    for i = #player.rankHistory , 1 , -1 do

        -- add generic table if necessary
        if not type (player.rankHistory[i] ) == "table" then
            player.rankHistory[i] = {  "" , "" , 0 };

        elseif ( not player.rankHistory[i][1] or type ( player.rankHistory[i][1] ) ~= "string" ) or ( not player.rankHistory[i][2] or type ( player.rankHistory[i][2] ) ~= "string" ) or ( not player.rankHistory[i][3] or type ( player.rankHistory[i][1] ) ~= "number" ) then

            if i == #player.rankHistory then

                if player[dateVersion][1] ~= "" then
                    player.rankHistory[i][1] = player.rankName;
                    player.rankHistory[i][2] = GRM.GetCleanTimestamp ( player[dateVersion][1] );
                    player.rankHistory[i][3] = GRM.TimeStampToEpoch ( player.rankHistory[i][2] , true );
                end
            else
                -- if one is errored they all are.
                toRemove = false;

                -- We must remov
                if ( not player.rankHistory[i][1] or type ( player.rankHistory[i][1] ) ~= "string" ) or ( not player.rankHistory[i][2] or type ( player.rankHistory[i][2] ) ~= "string" ) then
                    toRemove = true;

                elseif ( not player.rankHistory[i][3] or type ( player.rankHistory[i][3] ) ~= "number" ) then

                    if player.rankHistory[i][2] ~= "" then
                        player.rankHistory[i][3] = GRM.TimeStampToEpoch ( GRM.GetCleanTimestamp ( player.rankHistory[i][2] ) , true );
                    else
                        toRemove = true;
                    end

                end

                if toRemove then
                    table.remove ( player.rankHistory , i );
                end
            end
        end
    end

    return player;
end

-- 1.92
-- Method:          GRM_Patch.FixRankHistoryEpochDates ( playerObject )
-- What it Does:    fixes any issues with the rankHistory
-- Purpose:         With the release of the macro tool for promotions and demotions it was necessary to check these to ensure they were valid and there was some logic flaws found in how the epoch stamps were saved. That was fixed, but now they need to be retroactively fixed.
GRM_Patch.FixRankHistoryEpochDates = function ( player )

    player = GRM_Patch.ValidateUnverifiedDate ( player , "verifiedPromoteDate" );

    for i = 1 , #player.rankHistory do
        if player.rankHistory[i][3] ~= 0 and player.rankHistory[i][2] ~= "" then

            player.rankHistory[i][3] = GRM.TimeStampToEpoch ( player.rankHistory[i][2] , true );

        end
    end

    return player;
end


-- 1.921
-- Method:          GRM_Patch.FixRankHistory ( player )
-- What it Does:    Purges bad dates that could not be fixed as they are showing empty still
-- Purpose:         Eliminate the remnants of an old bug from the cloanup of the epoch stamps on the rank history. Subsequent rank changes in the history are not needed to be kept if they are empty from the previous fix.
GRM_Patch.FixRankHistory = function ( player )
    for i = #player.rankHistory , 2 , -1 do
        if player.rankHistory[i][1] == "" then
            table.remove ( player.rankHistory , i );
        end
    end

    return player;
end

-- 1.921
-- Method:          GRM_Patch.UpdateSafeListValue ( player )
-- What it Does:    Changes the safeList from a strictly boolean value, for kicks, and adds an array so individual settings can be made for each of the macro tool types
-- Purpose:         Expand customizability and flexibility for players with the macro tool settings and use
GRM_Patch.UpdateSafeListValue = function ( player )
    local currentValue = false;

    if player.safeList then
        if type ( player.safeList ) == "boolean" then
            currentValue = player.safeList;
        elseif player.safeList.kick and player.safeList.kick[1] ~= nil and type ( player.safeList.kick[1] ) == "boolean" then
            currentValue = player.safeList.kick[1]
        else
            currentValue = false;
        end
    end

    player.safeList = {};
    player.safeList.kick = { currentValue , false , 0 , 0 };    -- IsEnabled , isExpireEnabled, how many days, EpochTimeOfExpiration
    player.safeList.promote = { false , false , 0 , 0 };
    player.safeList.demote = { false , false , 0 , 0 };

    return player;
end

-- 1.923
-- Method:          GRM_Patch.FixVerifiedDatesForRejoins ( player )
-- What it Does:    Checks if the rank and join histories match up with the verified date. If they don't, it wipes the verified.
-- Purpose:         Found a flaw with rejoins - if a player rejoined but date was NOT verified, it kept the original verified join date from their previous membership time, which was wrong
GRM_Patch.FixVerifiedDatesForRejoins = function ( player )
    -- Validate this the join date info
    if not player.verifiedJoinDate or not player.verifiedJoinDate[1] or not player.joinDate then
        if not player.verifiedJoinDate or not player.verifiedJoinDate[1] then
            player.verifiedJoinDate = { "" , 0 };
        end
        if not player.joinDate then
            player.joinDate = {};
        end
    end

    if #player.verifiedJoinDate[1] > 0 and #player.joinDate > 0 then
        if GRM.GetCleanTimestamp ( player.verifiedJoinDate[1] ) ~= GRM.GetCleanTimestamp ( player.joinDate[#player.joinDate] ) then
            player.joinDate[#player.joinDate] = GRM.GetCleanTimestamp ( player.verifiedJoinDate[1] );
            player.joinDateEpoch[#player.joinDateEpoch] = GRM.TimeStampToEpoch ( player.joinDate[#player.joinDate] , true );
        end
    elseif #player.verifiedJoinDate[1] > 0 and #player.joinDate == 0 then
        player.joinDate[1] = GRM.GetCleanTimestamp ( player.verifiedJoinDate[1] );
        player.joinDateEpoch[1] = GRM.TimeStampToEpoch ( player.joinDate[1] , true );
    end

    -- Validate f ormatting for all players first.
    if not player.verifiedPromoteDate or not player.verifiedPromoteDate[1] or player.verifiedPromoteDate[1] == "nil" or not player.rankHistory or not player.rankHistory[#player.rankHistory][2] then
        if not player.verifiedPromoteDate or not player.verifiedPromoteDate[1] or player.verifiedPromoteDate[1] == "nil" then
            player.verifiedPromoteDate = { "" , 0 };
        end
        if not player.rankHistory or not player.rankHistory[#player.rankHistory][2] then
            player.rankHistory = nil;
            player.rankHistory = { { "" , "" , 0 } };
        end
    end

    if #player.verifiedPromoteDate[1] > 0 and #player.rankHistory > 0 then
        if GRM.GetCleanTimestamp ( player.verifiedPromoteDate[1] ) ~= GRM.GetCleanTimestamp ( player.rankHistory[#player.rankHistory][2] ) then
            player.rankHistory[#player.rankHistory][1] = player.rankName;
            player.rankHistory[#player.rankHistory][2] = GRM.GetCleanTimestamp ( player.verifiedPromoteDate[1] );
            player.rankHistory[#player.rankHistory][3] = GRM.TimeStampToEpoch ( player.rankHistory[#player.rankHistory][2] , true );
        end
    elseif #player.verifiedPromoteDate[1] > 0 and #player.rankHistory == 0 then
        player.rankHistory[1][1] = player.rankName;
        player.rankHistory[1][2] = GRM.GetCleanTimestamp ( player.verifiedPromoteDate[1] );
        player.rankHistory[1][3] = GRM.TimeStampToEpoch ( player.rankHistory[1][2] , true );
    end

    return player;
end

-- 1.925
-- Method:          GRM_Patch.PurgeGuildRankNamesOldFormat ( guild )
-- What it Does:    Takes the old "rankNames" variable in the guild table and purges it by setting it to nil
-- Purpose:         Due to an error in separating the names by commas, given you can name ranks with commas, the regex parsing was separating them by commas which breaks things. Instead of parsing and trying to decipher and replace, it just purges the old data and rebuilds it under a new variable name. Quick and easy fix.
GRM_Patch.PurgeGuildRankNamesOldFormat = function ( guildData )
    guildData.rankNames = nil;
    return guildData;
end

-- 1.926
-- Method:          GRM_Patch.CleanupSafeLists ( table )
-- What it Does:    Due to a previous error if the addon crashed when patching you could end up with tons of nested variables. This cleans them up
-- Purpose:         Fix a previous patching flaw
GRM_Patch.CleanupSafeLists = function ( player )

    -- Previous bug
    local rule = player.safeList.kick;
    if type ( rule[1] ) == "table" then

        while ( type ( rule[1] ) == "table" and rule[1].kick ) do
            rule = rule[1].kick;
        end

        if type ( rule[1] ) == "boolean" then
            player.safeList.kick = { rule[1] , rule[2] , rule[3] , rule[4] }
        end

    end

    return player;
end

-- 1.93
-- Method:          GRM_Patch.ConfigureNewAltGroups()
-- What it Does:    It configures the new SavedVariable by establishing the guild names.
-- Purpose:         Rebuilding the structure of alt groups for ease.
GRM_Patch.ConfigureNewAltGroups = function()
    for faction in pairs ( GRM_GuildMemberHistory_Save ) do
        for guildName in pairs ( GRM_GuildMemberHistory_Save[faction] ) do
            GRM_Alts[ guildName ] = {};
        end
    end
end

-- 1.93
-- Method:          GRM_Patch.BuildNewAltLists()
-- What it Does:    Modifies the guild into the new format.
-- Purpose:         adapt the guild lists to the new system.
GRM_Patch.BuildNewAltLists = function()
    local alt;
    local groupID;

    -- Setting the most recent chan ge timestamp.
    local getHighestTimeOfChange = function ( player )
        local time = 0;

        if #player.alts > 0 then

            for i = 1 , #player.alts do
                if not player.alts[i][6] then
                    player.alts[i][6] = 0;
                end

                if player.alts[i][6] > time then
                    time = player.alts[i][6];
                end
            end

            -- If you have alts, there needs to be a timestamp
            if time == 0 then
                time = time();
            end
        end

        return time;
    end

    for F in pairs ( GRM_GuildMemberHistory_Save ) do                         -- Horde and Alliance
        for guildName in pairs ( GRM_GuildMemberHistory_Save[F] ) do                  -- The guilds in each faction
            for _ , player in pairs ( GRM_GuildMemberHistory_Save[F][guildName] ) do
                if type ( player ) == "table" then

                    if player.altGroup == "" and player.alts and ( #player.alts > 0 or player.isMain ) then

                        groupID = GRM.CreateNewAltGroupID ( guildName );

                        player.altGroup = groupID;
                        player.altGroupModified = getHighestTimeOfChange ( player );

                        GRM_Alts[guildName][ groupID ] = {};
                        GRM_Alts[guildName][ groupID ].main = "";
                        GRM_Alts[guildName][ groupID ].timeModified = player.altGroupModified;

                        GRM_Patch.AddAltForPatch ( "" , groupID , guildName , player );

                        if player.isMain then
                            GRM_Alts[guildName][ groupID ].main = player.name;
                        end

                        -- Now, let's cycle through all of the alts.
                        for i = 1 , #player.alts do

                            alt = GRM_GuildMemberHistory_Save[F][guildName][player.alts[i][1]];
                            if alt ~= nil then
                                -- We know it is valid and toon is still in the guild
                                alt.altGroup = groupID;

                                if alt.isMain then
                                    GRM_Alts[guildName][ groupID ].main = alt.name;
                                end

                                GRM_Patch.AddAltForPatch ( "" , groupID , guildName , alt );
                            end
                        end
                        -- Alphabetize them
                        sort ( GRM_Alts[guildName][ groupID ] , function ( a , b ) return a.name < b.name end );

                    end

                end
            end

            -- Ensure the altGroupModified is the same for all
            for altGroupID in pairs ( GRM_Alts[guildName] ) do
                for i = 1 , #GRM_Alts[guildName][altGroupID] do

                    GRM_GuildMemberHistory_Save[F][guildName][GRM_Alts[guildName][altGroupID][i].name].altGroupModified = GRM_Alts[guildName][altGroupID].timeModified;
                end
            end

        end
    end
end

-- 1.93
-- Method:          GRM_Patch.AddAltForPatch ( string , string , string , playerTable )
-- What it Does:    Repeatable function to use for patching the player into the new data table
-- Purpose:         Cleaaner code to strip this out.
GRM_Patch.AddAltForPatch = function( oldGroupID , newGroupID , guildName , player )

    -- First, let's handle the OLD group ID
    if oldGroupID ~= "" then
        player.altGroup = newGroupID;
        GRM.RemoveAltFromGrouping ( oldGroupID , guildName , player );
    end
    -- Now we add to the new group.
    local ind = #GRM_Alts[guildName][newGroupID] + 1;

    GRM_Alts[guildName][newGroupID][ind] = {};
    GRM_Alts[guildName][newGroupID][ind].name = player.name;
    GRM_Alts[guildName][newGroupID][ind].class = player.class;

end

-- 1.93
-- Method:          GRM_Patch.RemoveOldAltLists ( playerTable )
-- What it Does:    Removes the alt information in the old format from the player
-- Purpose:         Deprecated data point.
GRM_Patch.RemoveOldAltLists = function ( player )
    player.alts = nil;
    return player;
end

-- 1.93
-- Method:          GRM_Patch.FixUnknownBirthdayBug ( playerTable , guildTable )
-- What it Does:    Checks to see if there is an alt grouping where one is set to unknown and another isn't. This shouldn't happen. If you set one in an alt grouping to unknown, they should all become unknown, or vice versa
-- Purpose:         Fix a bug where bday is synced among the alt grouping but the unknown bday status was not.
GRM_Patch.FixUnknownBirthdayBug = function ( guildData , player )

    if player.birthdayUnknown and player.altGroup ~= "" then

        local alts = {};
        local gName = guildData.grmName;
        local tempAlt;
        local clear = false;

        -- Now, we need to scan through their alts]
        -- WRITE A PATCH - check all alt groups if you find "unknown in an alt group, check all of the alts and if any others are not listed as unknown, then clear the entire history from unknown."
        if player.altGroup ~= "" then
            for i = 1 , #GRM_Alts[gName][player.altGroup] do
                if GRM_Alts[gName][player.altGroup][i].name ~= player.name then
                    table.insert ( alts , { GRM_Alts[gName][player.altGroup][i].name , GRM_Alts[gName][player.altGroup][i].class } );
                end
            end
        end

        -- Now, we check the alts
        for i = 1 , #alts do
            tempAlt = guildData[alts[i][1]];

            -- This indicates that there is disparity in the grouping - 1 is showing unknown, and at least one other is showing unknown as well.
            if tempAlt and not tempAlt.birthdayUnknown then
                clear = true;
                break;
            end
        end

        if clear then
            for i = 1 , #alts do
                tempAlt = guildData[alts[i][1]];

                if tempAlt then
                    tempAlt.events[2] = { { 0 , 0 , 0 } , false , "" , 0 };
                    tempAlt.birthdayUnknown = false;
                end
            end
        end
    end

    return player;
end

-- 1.93
-- Method:          GRM_Patch.ConvertRankHistoryToRanks ( playerObject , bool )
-- What it Does:    Converts the player rank history to the new format and purges the old
-- Purpose:         Simplifying multiple player variables into one.
GRM_Patch.ConvertRankHistoryToRanks = function ( player , isFormerMembers )
    local timeTable;
    local changeType = 1; -- 1 = promotion, 2 = demotion, 3 = Left guild
    local timeArray , rank , leftGuildEpoch , verified;
    local verificationFound = false;
    -- RankHistory default = { { "" , "" , 0 } }; -- Deprecating out
    -- verifiedPromote = { "" , 0 };              -- Deprecating out

    -- Add a new rank format
    player.rankHist = player.rankHist or {};

    if player.verifiedPromoteDate ~= nil then
        -- First, add verified date into first index - we are always going to insert new into the first index.
        if player.verifiedPromoteDate[1] ~= nil and type ( player.verifiedPromoteDate[1] ) == "string" and player.verifiedPromoteDate[1] ~= "" then
            timeTable = GRM.ConvertGenericTimestampToIntValues ( player.verifiedPromoteDate[1] );

            if timeTable and player.verifiedPromoteDate[2] ~= nil and type ( player.verifiedPromoteDate[2] ) == "number" and player.verifiedPromoteDate[2] > 0 and player.verifiedPromoteDate[2] ~= 978375660 then  -- Removing old date redundancy
                table.insert ( player.rankHist , 1 , { player.rankName , timeTable[1] , timeTable[2] , timeTable[3] , GRM.TimeStampToEpoch ( player.verifiedPromoteDate[1] ) , player.verifiedPromoteDate[2] , true , 1 } );
                verificationFound = true;
            end
        end
    end

    -- Need to move people over
    if isFormerMembers then

        if player.oldRank ~= nil and player.leftGuildEpoch ~= nil then
            if player.oldRank ~= "" then
                rank = player.oldRank;
            else
                rank = player.rankName
            end

            if #player.leftGuildEpoch > 0 then
                timeArray = GRM.ConvertGenericTimestampToIntValues ( player.leftGuildDate[#player.leftGuildDate] );
                leftGuildEpoch = player.leftGuildEpoch[#player.leftGuildEpoch];
                verified = true;
            else
                timeArray = select ( 2 , GRM.GetTimestamp() );
                leftGuildEpoch = time();
                verified = false;
            end

            table.insert ( player.rankHist , 1 , { rank , timeArray[1] , timeArray[2] , timeArray[3] , leftGuildEpoch , leftGuildEpoch , verified , 3 } );
        end

    end

    -- Since RankHistory first data set is supposed to allign and be the same as the verified, if you already added verified you will want to skip over it.
    local startingPoint = 0;
    if verificationFound then
        startingPoint = 1;
    end

    -- Go backwards
    if player.rankHistory ~= nil then
        for i = ( #player.rankHistory - startingPoint ) , 1 , -1 do

            if player.rankHistory[i] ~= nil and player.rankHistory[i][2] ~= nil and type ( player.rankHistory[i][2] ) == "string" and player.rankHistory[i][2] ~= "" then
                timeTable = GRM.ConvertGenericTimestampToIntValues ( player.rankHistory[i][2] );

                if timeTable and player.rankHistory[i][1] ~= nil and type ( player.rankHistory[i][1] ) == "string" and player.rankHistory[i][3] ~= nil and type ( player.rankHistory[i][3] ) == "number" and player.rankHistory[i][3] > 0 then

                    if string.find ( player.rankHistory[i][1] , "Left Guild" , 1 , true ) ~= nil then
                        changeType = 3;
                        verified = true;
                        leftGuildEpoch = GRM.TimeStampToEpoch ( player.rankHistory[i][2] );

                    else
                        -- Normal rank change - not a time they left
                        changeType = 1;
                        verified = false;
                        leftGuildEpoch = 0;
                    end

                    table.insert ( player.rankHist , { player.rankHistory[i][1] , timeTable[1] , timeTable[2] , timeTable[3] , GRM.TimeStampToEpoch ( player.rankHistory[i][2] ) , leftGuildEpoch , verified , changeType } );
                end

            end
        end
    end

    if #player.rankHist == 0 then
        player.rankHist = { { player.rankName , 0 , 0 , 0 , 0 , 0 , false , 1 } };
    end

    player.rankHistory = nil;
    player.verifiedPromoteDate = nil;
    player.oldRank = nil;

    return player;
end

-- Patch 1.93
-- Method:          GRM_Patch.UpdateUnknownRankFormat ( playerTable )
-- What it Does:    Changes an old format that I found was unnecessary
-- Purpose:         Just cleanup.
GRM_Patch.UpdateUnknownRankFormat = function ( player )

    if player.rankName == ( "< " .. GRM.L ( "Unknown" ) .. " >" ) then
        player.rankName = "";
    end

    return player;
end

-- 1.93
-- Method:          GRM_Patch.ConvertJoinHistory ( playerObject )
-- What it Does:    Converts the player join date history to the new format and purges the old
-- Purpose:         Simplifying multiple player variables into one.
GRM_Patch.ConvertJoinHistory = function ( player )

    local timeTable , tTable;
    local leftGuildEpoch;

    -- Add a new rank format
    player.joinDateHist = player.joinDateHist or {};

    local verified = false;

    if player.joinDate ~= nil then
        for i = #player.joinDate , 1 , -1 do

            if player.joinDate[i] ~= nil and type ( player.joinDate[i] ) == "string" and player.joinDate[i] ~= "" then
                timeTable = GRM.ConvertGenericTimestampToIntValues ( player.joinDate[i] );

                if timeTable and player.joinDateEpoch[i] ~= nil and player.joinDateEpoch[i] ~= nil and type ( player.joinDateEpoch[i] ) == "number" and player.joinDateEpoch[i] > 0 then
                    verified = false;

                    if player.leftGuildDate[i] ~= nil then
                        leftGuildEpoch = player.leftGuildEpoch[i];
                        tTable = GRM.ConvertGenericTimestampToIntValues ( player.leftGuildDate[i] );
                        table.insert ( player.joinDateHist , { tTable[1] , tTable[2] , tTable[3] , leftGuildEpoch , leftGuildEpoch , true , 2 } );
                    end

                    if i == #player.joinDate and player.verifiedJoinDate[1] ~= nil and type ( player.verifiedJoinDate[1] ) == "string" and player.verifiedJoinDate[1] ~= "" then
                        timeTable = GRM.ConvertGenericTimestampToIntValues ( player.verifiedJoinDate[1] );

                        if timeTable and player.verifiedJoinDate[2] ~= nil and type ( player.verifiedJoinDate[2] ) == "number" and player.verifiedJoinDate[2] > 0 and player.verifiedJoinDate[2] ~= 978375660 then  -- Removing old date redundancy
                            table.insert ( player.joinDateHist , 1 , { timeTable[1] , timeTable[2] , timeTable[3] , GRM.TimeStampToEpoch ( player.verifiedJoinDate[1] ) , player.verifiedJoinDate[2] , true , 1 } );
                            verified = true;
                        end
                    end

                    if not verified then

                        table.insert ( player.joinDateHist , { timeTable[1] , timeTable[2] , timeTable[3] , GRM.TimeStampToEpoch ( player.joinDate[i] ) , 0 , false , 1 } );
                    end

                end

            end
        end
    end

    if #player.joinDateHist == 0 then
        player.joinDateHist = { { 0 , 0 , 0 , 0 , 0 , false , 1 } };
    elseif player.joinDateHist[#player.joinDateHist][7] == 2 then
        table.remove ( player.joinDateHist , #player.joinDateHist );    -- We don't know the original join date, so removing the leave date.
    end

    player.leftGuildDate = nil;
    player.leftGuildEpoch = nil;
    player.joinDate = nil;
    player.joinDateEpoch = nil;
    player.verifiedJoinDate = nil;

    return player;
end

-- 1.93
-- Method:          GRM_Patch.ConfigureRuleIndexAndEditTime ( string )
-- What it DoeS:    Reconfigures the rule indexes so they can be sorted later
-- Purpose:         For creating sortable macro rules
GRM_Patch.ConfigureRuleIndexAndEditTime = function ( rules )
    local c = 1;

    -- Add the removed Rule
    for name in pairs ( rules ) do

        rules[name].ruleNumber = nil;

        rules[name].ruleIndex = c;
        rules[name].editTime = 0;
        rules[name].sync = false;
        rules[name].createdBy = { "" , "" };
        c = c + 1;
    end

    return rules;
end

-- 1.93
-- Method:          GRM_Patch.AddRemovedRules ( table )
-- What it Does:    Adds a new settings rule category
-- Purpose:         So removed rules can be tracked so if you remove them, the next sync you don't just re-receive it again.
GRM_Patch.AddRemovedRules = function ( rulesTable )

    if not rulesTable["removedMacroRules"] then
        rulesTable["removedMacroRules"] = {};
        rulesTable["removedMacroRules"]["kickRules"] = {};
        rulesTable["removedMacroRules"]["promoteRules"] = {};
        rulesTable["removedMacroRules"]["demoteRules"] = {};
    end

    return rulesTable;
end

-- 1.931
-- Method:          GRM_Patch.FixTimestamps ( table )
-- What it Does:    Due to an old legacy issue, there are some instances where incorrect dates exist in the system, like Feb 30th, due to some faulty logic. This cleans all of those up and with new logic, should not re-occur
-- Purpose:         Cleanup Timestamps from legacy bugs
GRM_Patch.FixTimestamps = function ( player )

    local timeTable = {};
    local forcedForm = 0;

    if UnitFactionGroup ( "PLAYER" ) == "Horde"  then
        forcedForm = GRM_AddonSettings_Save["H"][GRM_G.addonUser].dateFormat;
    else
        forcedForm = GRM_AddonSettings_Save["A"][GRM_G.addonUser].dateFormat;
    end

    for i = 1 , #player.joinDateHist do
        timeTable = {};

        if player.joinDateHist[i][4] ~= nil and player.joinDateHist[i][1] and player.joinDateHist[i][1] > 0  and player.joinDateHist[i][2] and player.joinDateHist[i][2] > 0 and player.joinDateHist[i][3] and player.joinDateHist[i][3] > 0  then
            player.joinDateHist[i][4] = GRM.TimeStampToEpoch ( { player.joinDateHist[i][1] , player.joinDateHist[i][2] , player.joinDateHist[i][3] } );
        else
            player.joinDateHist = { { 0 , 0 , 0 , 0 , 0 , false , 1 } };
            break;
        end
        if player.joinDateHist[i][5] == nil then
            player.joinDateHist[i][5] = 0;
        end
        if player.joinDateHist[i][4] > 0 then
            timeTable = select ( 2 , GRM.EpochToDateFormat ( player.joinDateHist[i][4] , forcedForm ) );

            if timeTable and ( player.joinDateHist[i][1] ~= timeTable[1] or player.joinDateHist[i][2] ~= timeTable[2] or player.joinDateHist[i][3] ~= timeTable[3] ) then
                player.joinDateHist[i][1] = timeTable[1];
                player.joinDateHist[i][2] = timeTable[2]
                player.joinDateHist[i][3] = timeTable[3]
            end

        end

    end

    for i = 1 , #player.rankHist do
        timeTable = {};

        if player.rankHist[i][5] > 0 then
            timeTable = select ( 2 , GRM.EpochToDateFormat ( player.rankHist[i][5] , forcedForm ) );

            if timeTable and ( player.rankHist[i][2] ~= timeTable[1] or player.rankHist[i][3] ~= timeTable[2] or player.rankHist[i][4] ~= timeTable[3] ) then
                player.rankHist[i][2] = timeTable[1];
                player.rankHist[i][3] = timeTable[2]
                player.rankHist[i][4] = timeTable[3]
            end

        end

    end

    return player;
end

-- 1.944
-- Method:          GRM.PlayerNameFixFormerMembers ( playerObject )
-- What it Does:    Checks for missing name variable and then adds the name using GUID, or purges if GUID and name are missing
-- Purpose:         Due to a previous lua error, the name on former members maye have been lost and overwritten when they were trying to rejoin
GRM_Patch.PlayerNameFixFormerMembers = function ( player )
    local name , realm = "" , "";

    if player.name == nil or player.name == "" then
        if player.GUID ~= nil and player.GUID ~= "" then
            name , realm = select ( 6 , GetPlayerInfoByGUID ( player.GUID ) );

            if name == nil or name == "" then
                name , realm = select ( 6 , GetPlayerInfoByGUID ( player.GUID ) );
            end

            if name ~= nil and name ~= "" then

                if realm == "" or realm == nil  then
                    player.name = GRM.AppendServerName ( name );
                else
                    player.name = name .. "-" .. realm;
                end
            else
                player.name = "";
            end

        else
            player = nil; -- just purge it if it has no GUID and no name, as it is basically useless data now.
        end
    end

    return player;
end

-- 1.944
-- Method:          GRM_Patch.CreateMacroGUID ( string )
-- What it Does:    Creates a unique GUID for macros
-- Purpose:         To make the macro sync process easier.]
GRM_Patch.CreateMacroGUID = function ( rule )

    rule.GUID = tostring ( GRMsync.ConvertStringToVal ( rule.name ) + rule.editTime );

    return rule
end

-- 1.946
-- Method:          GRM_Patch.ConfigureNewGlobalDateFormat()
-- What it Dpes:    Adds a new setting, but first aligns it with the old global
-- Purpose:         Adding a new timestamp setting so the global can be differentiated.
GRM_Patch.ConfigureNewGlobalDateFormat = function()
    for F in pairs ( GRM_AddonSettings_Save ) do
        for p in pairs ( GRM_AddonSettings_Save[F] ) do

            if not GRM_AddonSettings_Save[F][p]["globalDateFormat"] then
                GRM_AddonSettings_Save[F][p]["globalDateFormat"] = 1;
            end

            GRM_AddonSettings_Save[F][p]["globalDateFormat"] = tonumber ( GRM_AddonSettings_Save[F][p].dateFormat );

        end
    end
end

-- 1.946
-- Method:          GRM_Patch.FixIfGuildChange()
-- What it Does:    Fixes an error where if a guild namechange was detected, it updated all but hte new alt groups.
-- Purpose:         Fix Lua errors that would occur downstream of this issue
GRM_Patch.FixIfGuildChange = function()

    local isMatched = false;
    for guild in pairs ( GRM_Alts ) do
        isMatched = false;

        for faction in pairs ( GRM_GuildMemberHistory_Save ) do
            for guildName in pairs ( GRM_GuildMemberHistory_Save[faction] ) do
                if guildName == guild then
                    isMatched = true;
                    break;
                end
            end
            if isMatched then
                break;
            end

        end

        if not isMatched then
            local oldGuildName = "";
            -- Errors found
            -- Found out which guild has no name match
            for faction in pairs ( GRM_GuildMemberHistory_Save ) do
                for guildName in pairs ( GRM_GuildMemberHistory_Save[faction] ) do
                    isMatched = false;

                    for gName in pairs ( GRM_Alts ) do
                        oldGuildName = gName;
                        if gName == guildName then
                            isMatched = true;
                            break;
                        end
                    end

                    if not isMatched then
                        -- We found the flawed candidate.
                        GRM_Alts[guildName] = GRM.DeepCopyArray ( GRM_Alts[oldGuildName] );
                        GRM_Alts[oldGuildName] = nil;
                        GRM_GuildMemberHistory_Save[faction][guildName].grmName = guildName;
                        GRM_PlayersThatLeftHistory_Save[faction][guildName].grmName = guildName;
                        break;
                    end
                end
            end

            if not isMatched then
                break;
            end
        end
    end
end

-- 1.948
-- Method:          GRM_Patch.FixMissingClass ( playerTable )
-- What it Does:    Populates the class back due to a previous sync error
-- Purpose:         Issue with sync due to a previous error caused class to be nil, so this is fixing a downstream issue
GRM_Patch.FixMissingClass = function ( player )

    local class;
    if player.class == nil and player.GUID and string.find ( player.GUID , "Player-" ) ~= nil then
        class = GetPlayerInfoByGUID ( player.GUID );
        if class == nil or class == "" then
            class = GetPlayerInfoByGUID ( player.GUID );
        end

        if class ~= nil and class ~= "" then
            player.class = class;
        else
            player.class = "HUNTER" -- just a generic placeholder class that will be fixed if they ever rejoin or on the next scan, in case server is slow to provide info.
        end
    end

    return player;
end

-- 1.948
-- method:          GRM_Patch.UpdateYearFormatting ( playerTable )
-- What it Does:    Updates any 2-digit year formats to proper 4
-- Purpose:         Normalization of some timestamp logic requires the timestamp data to have the years in proper format, not abbreviated.
GRM_Patch.UpdateYearFormatting = function ( player )

    for i = 1 , #player.rankHist do
        if player.rankHist[i][4] > 0 and player.rankHist[i][4] < 100 then
            player.rankHist[i][4] = player.rankHist[i][4] + 2000;
        end
    end

    for i = 1 , #player.joinDateHist do
        if player.joinDateHist[i][3] > 0 and player.joinDateHist[i][3] < 100 then
            player.joinDateHist[i][3] = player.joinDateHist[i][3] + 2000;
        end
    end
    return player;
end


-- Method:          GRM_Patch.AltModifiedFix()
-- What it Does:    Verifies the integrity of certain data
-- Purpose:         Due to the possibility of sync failing in the middle, like if someone goes offline or the other hits a loading screen in the middle of a sync, it is possible that this data can end up nil, in certain cases. This resolves that bug by rebuilding the variable.
GRM_Patch.AltModifiedFix = function()

    for faction in pairs ( GRM_GuildMemberHistory_Save ) do
        for guild in pairs ( GRM_GuildMemberHistory_Save[faction] ) do
            for _ , player in pairs ( GRM_GuildMemberHistory_Save[faction][guild] ) do
                if type ( player ) == "table" then

                    if not player.altGroupModified then

                        if player.altGroup ~= "" and GRM_Alts[guild][player.altGroup] then

                            -- verifi timeOfChange is not nil
                            if not GRM_Alts[guild][player.altGroup].timeModified then
                                GRM_Alts[guild][player.altGroup].timeModified = 0;
                            end

                            player.altGroupModified = GRM_Alts[guild][player.altGroup].timeModified + 1 - 1; -- Disassociate and create new index.

                        else
                            -- Alt Group has been broken
                            if not GRM_Alts[guild][player.altGroup] then
                                player.altGroup = "";
                            end

                            player.altGroupModified = 0;    -- nil value, and not in a group, so just set to default.
                        end

                    end

                end
            end
        end
    end
end

-- 1.953
-- Method:          GRM_Patch.PreviousAltGroupRejoinFix( playerTable )
-- What it Does:    Adds the member data variable if it doesn't exist as an empty table
-- Purpose:         This was not properly added to all members previously, prior to feature being implemented.
GRM_Patch.PreviousAltGroupRejoinFix = function ( player )

    if not player.altsAtTimeOfLeaving then
        player.altsAtTimeOfLeaving = {};
    end

    return player;
end

-- 1.96
-- Method:          GRM_Patch.JoinAndRankDataFix ( playerTable )
-- What it Does:    Fixes a storage formatting problem of empty tables that should never have been added during ban data sync
-- Purpose:         Prevent downstream errors by fixing previous error.
GRM_Patch.JoinAndRankDataFix = function ( player )
    return GRM.JoinAndRankDataCleanup ( player );
end

-- 1.97
-- Nethod:          GRM_Patch.ConvertSaveFiles( int )
-- What it Does:    Converts all the databases and removes the faction designation from them
-- Purpose:         Patch 10.1 allows cross faction guilds. This needed to be done.
GRM_Patch.ConvertSaveFiles = function( index )

    local data = { GRM_LogReport_Save , GRM_CalendarAddQue_Save , GRM_PlayerListOfAlts_Save , GRM_GuildMemberHistory_Save , GRM_PlayersThatLeftHistory_Save };
    local newDataTable = {};
    delayTrigger = true;
    local j = index or 1;

    for i = j , #data do

        if data[i]["H"] then
            newDataTable = {};
            for F in pairs ( data[i] ) do
                for guildName in pairs ( data[i][F] ) do

                    if not newDataTable[guildName] then
                        newDataTable[guildName] = {};
                        newDataTable[guildName] = GRM.DeepCopyArray ( data[i][F][guildName] );

                        -- Update player faction;
                        if i > 3 then
                            for _ , player in pairs ( newDataTable[guildName] ) do
                                if type(player) == "table" then
                                    if F == "H" then
                                        player.faction = 0;
                                    elseif F == "A" then
                                        player.faction = 1;
                                    end
                                end
                            end
                        end

                    end

                end
            end

            if i == 1 then
                GRM_LogReport_Save = nil;
                GRM_LogReport_Save = newDataTable;
            elseif i == 2 then
                GRM_CalendarAddQue_Save = nil;
                GRM_CalendarAddQue_Save = newDataTable;
            elseif i == 3 then
                GRM_PlayerListOfAlts_Save = nil;
                GRM_PlayerListOfAlts_Save = newDataTable;
            elseif i == 4 then
                GRM_GuildMemberHistory_Save = nil;
                GRM_GuildMemberHistory_Save = newDataTable;
            elseif i == 5 then
                GRM_PlayersThatLeftHistory_Save = nil;
                GRM_PlayersThatLeftHistory_Save = newDataTable;
            end

            if i == 1 or i > 3 then
                C_Timer.After ( 2 , function()
                    GRM_Patch.ConvertSaveFiles( i + 1 );
                end);
                return;
            end
        end
    end

    delayTrigger = false;
end

-- 1.97
-- Method:          GRM_Patch.ConvertSettings()
-- What it Does:    Converts the addonSettings DB
-- Purpose:         Patch 10.1 compatibility
GRM_Patch.ConvertSettings = function()
    local newDataTable = {};

    if GRM_AddonSettings_Save["H"] then

        for F in pairs ( GRM_AddonSettings_Save ) do
            for name in pairs ( GRM_AddonSettings_Save[F] ) do

                newDataTable[name] = GRM.DeepCopyArray ( GRM_AddonSettings_Save[F][name] );

            end
        end

        GRM_AddonSettings_Save = nil;
        GRM_AddonSettings_Save = newDataTable;  -- Final Overwrite.
    end
end

-- 1.97
-- Method:          GRM_Patch.ConvertDatabase()
-- What it Does:    Due to the 10.1 changes, faction being removed, this now converts DB to not matter about factions...
-- Purpose:         Convert DB
GRM_Patch.ConvertDatabase = function( backups )

    local newBackups = backups or {};
    delayTrigger = true;

    if GRM_GuildDataBackup_Save["H"] then
        for f in pairs ( GRM_GuildDataBackup_Save ) do
            for guild in pairs ( GRM_GuildDataBackup_Save[f] ) do
                if guild ~= "members" and guild ~= "formerMembers" then
                    if not newBackups[guild] and GRM_GuildMemberHistory_Save[f][guild] then

                        newBackups[guild] = {};

                        if GRM_GuildDataBackup_Save[f][guild]["Manual"].date == "" then
                            newBackups[guild].date = "";
                            newBackups[guild].epochDate = 0;
                            newBackups[guild].numGuildies = 0;
                            newBackups[guild].members = {};
                            newBackups[guild].formerMembers = {};
                            newBackups[guild].log = {};
                            newBackups[guild].alts = {};
                            if ( GRM_GuildDataBackup_Save[f][guild][1] and GRM_GuildDataBackup_Save[f][guild][1] ~= "" ) then
                                newBackups[guild].guildCreationDate = GRM_GuildDataBackup_Save[f][guild][1];
                            elseif ( GRM_GuildMemberHistory_Save[f][guild].grmCreationDate and GRM_GuildMemberHistory_Save[f][guild].grmCreationDate ~= "" ) then
                                newBackups[guild].guildCreationDate = GRM_GuildMemberHistory_Save[f][guild].grmCreationDate;
                            else
                                newBackups[guild].guildCreationDate = "";
                            end

                        else

                            newBackups[guild].date = GRM_GuildDataBackup_Save[f][guild]["Manual"].date;
                            newBackups[guild].epochDate = GRM_GuildDataBackup_Save[f][guild]["Manual"].epochDate;
                            newBackups[guild].numGuildies = GRM.GetNumGuildiesInGuild ( GRM_GuildDataBackup_Save[f][guild]["Manual"].members );
                            newBackups[guild].members = GRM.DeepCopyArray ( GRM_GuildDataBackup_Save[f][guild]["Manual"].members );
                            newBackups[guild].formerMembers = GRM.DeepCopyArray ( GRM_GuildDataBackup_Save[f][guild]["Manual"].formerMembers );
                            newBackups[guild].log = GRM.DeepCopyArray ( GRM_GuildDataBackup_Save[f][guild]["Manual"].log );
                            newBackups[guild].alts = GRM.DeepCopyArray ( GRM_GuildDataBackup_Save[f][guild]["Manual"].alts );

                            if GRM_GuildDataBackup_Save[f][guild]["Manual"].members.grmCreationDate and GRM_GuildDataBackup_Save[f][guild]["Manual"].members.grmCreationDate ~= "" then
                                newBackups[guild].guildCreationDate = GRM_GuildDataBackup_Save[f][guild]["Manual"].members.grmCreationDate;

                            elseif GRM_GuildDataBackup_Save[f][guild][1] and GRM_GuildDataBackup_Save[f][guild][1] ~= "" then
                                newBackups[guild].guildCreationDate = GRM_GuildDataBackup_Save[f][guild][1];
                            else
                                newBackups[guild].guildCreationDate = "";
                            end

                        end

                        C_Timer.After ( 2 , function()
                            GRM_Patch.ConvertDatabase ( newBackups );
                        end);
                        return;
                    end
                end
            end
        end

        GRM_GuildDataBackup_Save = nil;
        GRM_GuildDataBackup_Save = {};
        GRM_GuildDataBackup_Save = newBackups;
    end

    delayTrigger = false;
end

-- 1.93 -- Old function needed to be preserved...
GRM_Patch.ResetBackups = function( includeManual , includeAuto )
    for f in pairs ( GRM_GuildDataBackup_Save ) do
        for guild in pairs ( GRM_GuildDataBackup_Save[f] ) do
            if type ( guild ) == "string" then
                GRM_GuildDataBackup_Save[f][guild] = {};

                if includeManual then
                    GRM_GuildDataBackup_Save[f][guild].Manual = {};
                    GRM_GuildDataBackup_Save[f][guild]["Manual"].date = "";
                    GRM_GuildDataBackup_Save[f][guild]["Manual"].epochDate = 0;
                    GRM_GuildDataBackup_Save[f][guild]["Manual"].members = {};
                    GRM_GuildDataBackup_Save[f][guild]["Manual"].formerMembers = {};
                    GRM_GuildDataBackup_Save[f][guild]["Manual"].log = {};
                    GRM_GuildDataBackup_Save[f][guild]["Manual"].alts = {};
                end
                if includeAuto then
                    GRM_GuildDataBackup_Save[f][guild].Auto = {};
                    GRM_GuildDataBackup_Save[f][guild]["Auto"].date = "";
                    GRM_GuildDataBackup_Save[f][guild]["Auto"].epochDate = 0;
                    GRM_GuildDataBackup_Save[f][guild]["Auto"].members = {};
                    GRM_GuildDataBackup_Save[f][guild]["Auto"].formerMembers = {};
                    GRM_GuildDataBackup_Save[f][guild]["Auto"].log = {};
                    GRM_GuildDataBackup_Save[f][guild]["Auto"].alts = {};
                end
            end
        end
    end
end

-- R1.97
-- Method:          GRM_Patch.FixPersonWhoBanned ( playerObject )
-- What it Does:    Fixes banned Info discrepancy due to a sync bug error previously.
-- Purpose:         The "reason banned" was erroneously added to the "person who banned" name, which complicates some things. As such, the reason is removed from the index and the bannedPlayer info is reset.
GRM_Patch.FixPersonWhoBanned = function ( player )

    if player.bannedInfo and player.bannedInfo[4] ~= nil then
        if player.bannedInfo[4] ~= "" and string.find ( player.bannedInfo[4] , "-" ) == nil then
            player.bannedInfo[4] = "";
        end
    else
        player.bannedInfo = { false , 0 , false , "" };
    end

    return player;
end

-- 1.92996
-- Method:          GRM_Patch.GuildDataIntegrityCheck()
-- What it Does:    Performs a check to see if the same guild name is on Horde and Alliance. If so, it purges the guild data from the database that is the most outdated.
-- Purpose:         An unexpected error occurred when transferring from one classic expansion to the next, like Vanilla to TBC. The SavedVariables would be transferred by the client, but then a person could go and create a new guild on opposite faction with the same name, and GRM would then detect it as a new guild. As of Oct 24, 2022, I have only ever gotten 1 report of this ever happening, but it is possible others just never report it. This is just some logic to check against this, clean it up, and future proof against this happening in the future. Thanks @Kreun on Discord for the report!
GRM_Patch.GuildDataIntegrityCheck = function()
    local F2 = "A";
    local indexTable = {
        [1] = 8 , [2] = 8 , [3] = 7 , [4] = 6 , [5] = 6 , [7] = 6 , [8] = 6 , [9] = 6 , [10] = 11 , [11] = 5 , [14] = 5 , [16] = 5 , [17] = 7 , [19] = 7
    }
    local log1Date , log2Date = {} , {};

    for F in pairs ( GRM_GuildMemberHistory_Save ) do                         -- Horde and Alliance
        for name in pairs ( GRM_GuildMemberHistory_Save[F] ) do                  -- The guilds in each faction

            if F == "H" then
                F2 = "A";
            else
                F2 = "H";
            end

            for n in pairs ( GRM_GuildMemberHistory_Save[F2] ) do

                if n == name then

                    -- There is a match. Let's look at the log
                    if #GRM_LogReport_Save[F][name] > 0 and #GRM_LogReport_Save[F2][name] > 0 then
                        -- Both have logs

                        local found = false;
                        local found2 = false;

                        for i = #GRM_LogReport_Save[F][name] , 1 , -1 do
                            if indexTable[GRM_LogReport_Save[F][name][i][1]] and GRM_LogReport_Save[F][name][i][indexTable[GRM_LogReport_Save[F][name][i][1]]] ~= nil then
                                found = true;
                                log1Date = GRM_LogReport_Save[F][name][i][indexTable[GRM_LogReport_Save[F][name][i][1]]];
                                break;
                            end
                        end

                        for i = #GRM_LogReport_Save[F2][name] , 1 , -1 do
                            if indexTable[GRM_LogReport_Save[F2][name][i][1]] and GRM_LogReport_Save[F2][name][i][indexTable[GRM_LogReport_Save[F2][name][i][1]]] ~= nil then
                                found2 = true;
                                log2Date = GRM_LogReport_Save[F2][name][i][indexTable[GRM_LogReport_Save[F2][name][i][1]]];
                                break;
                            end
                        end

                        if found and found2 then

                            if GRM.TimeStampToEpoch ( log1Date ) < GRM.TimeStampToEpoch ( log2Date ) then
                                -- The F1 one is most recent, delete the other
                                GRM_Patch.PurgeGuildFromDatabase ( name , F , true );
                            else
                                GRM_Patch.PurgeGuildFromDatabase ( name , F2 , true );
                            end
                        end

                    elseif #GRM_LogReport_Save[F][name] > 0 then
                        GRM_Patch.PurgeGuildFromDatabase ( name , F2 , true );    -- purging the guild with no log
                    else
                        GRM_Patch.PurgeGuildFromDatabase ( name , F , true );
                    end

                    break;
                end
            end
        end
    end
end

-- Method:          GRM_Patch.PurgeGuildFromDatabase( string , string , bool )
-- What it Does:    Completely purges a guild from the player database... that it is not currently logged into
-- Purpose:         Cleanup old guild data from a guild the player is no longer a part of.
GRM_Patch.PurgeGuildFromDatabase = function ( guildName , faction , special )

    if guildName == GRM_G.guildName or guildName == GRM.SlimName ( GRM_G.guildName ) then
        if not special then
            GRM.Report ( "\n" .. GRM.L ( "Player Cannot Purge the Guild Data they are Currently In!!!" ) .. "\n" .. GRM.L( "To reset your current guild data type '/grm clearguild'" ) );
        end
    else

        if GRM_GuildMemberHistory_Save[faction][guildName] ~= nil then

            GRM_GuildMemberHistory_Save[faction][guildName] = nil;
            GRM_PlayersThatLeftHistory_Save[faction][guildName] = nil;
            GRM_CalendarAddQue_Save[faction][guildName] = nil;
            GRM_LogReport_Save[faction][guildName] = nil;
            GRM_GuildDataBackup_Save[faction][guildName] = nil;
            GRM_PlayerListOfAlts_Save[faction][guildName] = nil;
            GRM_Alts[guildName] = nil;

            if not special then
                GRM.Report ( GRM.L ( "{name} has been removed from the database." , guildName ) );
            end

        else
            -- remove the saved data if any exists as well
            -- Do a purge of the guild regardless, if it's showing up here, it means it's get lingering bad data.
            if GRM_GuildDataBackup_Save[faction][guildName] ~= nil then
                GRM_GuildDataBackup_Save[faction][guildName] = nil;
                if not special then
                    GRM.Report ( GRM.L ( "Error: Guild Not Found..." ) );
                end
            else
                if not special then
                    GRM.Report ( GRM.L ( "{name} has been removed from the database." , guildName ) );
                end
            end

        end
    end
end

-- 1.97 (Retro cleanup of old setting smod)
GRM_Patch.LanguageSettingModify = function()
    local isFound = false;
    for k = 2 , #GRM_AddonSettings_Save[FID] do
        if GRM_AddonSettings_Save[FID][k][1] == GRM_G.addonUser then
            isFound = true;
            PID = k;
            break;
        end
    end
    if not isFound then -- Edge case scenario of addon settings being lost thus are replaced with defaults.
        table.insert ( GRM_AddonSettings_Save[FID] , { GRM_G.addonUser } );
        PID = #GRM_AddonSettings_Save[FID]
        table.insert ( GRM_AddonSettings_Save[FID][#GRM_AddonSettings_Save[FID]] , GRM_Patch.GetDefaultAddonSettings() );
        GRM_G.IsNewToon = true;
        -- Forcing core log window/options frame to load on the first load ever as well
        GRM_G.ChangesFoundOnLoad = true;
    else
        GRM_Patch.ModifyPlayerMetadata ( 23 , { true , 0 , "" , GRM_AddonSettings_Save[FID][PID][2][49] , false , "" } , false , -1 );
    end
end

-- 1.97
-- Method:          GRM_Patch.ResetUIScaling ( table )
-- What it Does:    Converts the UI SCaling variables to the new format that allows frame scaling with corner
-- Purpose:         Quality of Life UI feature.
GRM_Patch.ResetUIScaling = function( scaling )
    local W , H , S = 0 , 0 , 0;
    if not scaling or not scaling[1] then

        scaling = { { 600 , 535 , 1.0 } , { 400 , 439 , 1.0 } , { 1200 , 515 , 1.0 } , { 1075 , 540 , 1.0 } , { 875 , 400 , 1.0 } };

    else

        for i = 1 , 5 do
            if not scaling[i] or type ( scaling[i] ) ~= "table" then
                S = 1;

                scaling[i] = {};

                if i == 1 then
                    W , H = 600 , 535;
                elseif i == 2 then
                    W , H = 400 , 439;
                elseif i == 3 then
                    W , H = 1200 , 515;
                elseif i == 4 then
                    W , H = 1075 , 550;
                else
                    W , H = 875 , 400;
                end

                scaling[i] = { W , H , S };
            end
        end
    end

    return scaling;
end
-- 1.971
-- Method:          GRM_Patch.CleanUpAltGroupsFromError()
-- What it Does:    Cleans up old dead alt groups
-- Purpose:         Realized an issue where if a person left/kicked from the guild whilst having no alts, but they were a main, they would leave but their dead alt group stayed there.
GRM_Patch.CleanUpAltGroupsFromError = function()
    for guildName in pairs ( GRM_Alts ) do

        for altGroup in pairs ( GRM_Alts[guildName] ) do

            if not GRM_GuildMemberHistory_Save[ guildName ] then
                GRM_Alts[guildName] = nil;
            else
                if GRM_Alts[guildName][altGroup].main == nil or ( GRM_Alts[guildName][altGroup].main ~= "" and not GRM_GuildMemberHistory_Save[ guildName ][ GRM_Alts[guildName][altGroup].main ] ) then
                    GRM_Alts[guildName][altGroup] = nil;
                    for _,player in pairs ( GRM_GuildMemberHistory_Save[ guildName ] ) do
                        if type(player) == "table" then
                            if player.altGroup == altGroup then
                                player.altGroup = "";
                            end
                        end
                    end
                end
            end

        end

    end

    for guildName in pairs ( GRM_GuildDataBackup_Save ) do

        for altGroup in pairs ( GRM_GuildDataBackup_Save[guildName].alts ) do

            if GRM_GuildDataBackup_Save[guildName].alts[altGroup].main ~= "" and not GRM_GuildDataBackup_Save[guildName].members[ GRM_GuildDataBackup_Save[guildName].alts[altGroup].main ] then
                GRM_GuildDataBackup_Save[guildName].alts[altGroup] = nil;
            end

        end

    end

end

-- 1.973
-- Method:          GRM_Patch.FixJoinNameError()
-- What it Does:    Due to a lua error crashing the on-load of a player, this removes it if their name was not stored properly.
-- Purpose:         Cleans up previous error.
GRM_Patch.FixJoinNameError = function()
    for guildName in pairs ( GRM_GuildMemberHistory_Save ) do                  -- The guilds in each faction
        for name , player in pairs ( GRM_GuildMemberHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild
            if type ( player ) == "table" then
                if name == "" or player.name == "" or player.name == nil then
                    if name == "" then
                        GRM_GuildMemberHistory_Save[guildName][name] = nil;
                    else
                        GRM_GuildMemberHistory_Save[guildName][name].name = name;
                    end
                end
            end
        end
    end

    -- Former memebrs
    for guildName in pairs ( GRM_PlayersThatLeftHistory_Save ) do                  -- The guilds in each faction
        for name , player in pairs ( GRM_PlayersThatLeftHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
            if type ( player ) == "table" then
                if type ( player ) == "table" then
                    if name == "" or player.name == "" or player.name == nil then
                        if name == "" then
                            GRM_PlayersThatLeftHistory_Save[guildName][name] = nil;
                        else
                            GRM_PlayersThatLeftHistory_Save[guildName][name].name = name;
                        end
                    end
                end
            end
        end
    end

    -- Check the backup data as well.
    local backup = { "members" , "formerMembers" };

    for guildName in pairs ( GRM_GuildDataBackup_Save ) do
        for i = 1 , #backup do        -- Member vs formerMember

            if GRM_GuildDataBackup_Save[guildName][backup[i]] == nil or #GRM_GuildDataBackup_Save[guildName][backup[i]] > 0 then
                GRM_GuildDataBackup_Save[guildName][backup[i]] = {};
            else
                for name , player in pairs ( GRM_GuildDataBackup_Save[guildName][backup[i]] ) do
                    if type ( player ) == "table" then
                        if name == "" or player.name == "" or player.name == nil then
                            if name == "" then
                                GRM_GuildDataBackup_Save[guildName][backup[i]][name] = nil;
                            else
                                GRM_GuildDataBackup_Save[guildName][backup[i]][name].name = name;
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 1.972
-- Method:          GRM_Patch.AddExportEntry( settingsTable , int )
-- What it Does:    Addes the 22nd entry to the export options
-- Purpose:         Enable a new setting for Mythic+ exporting.
GRM_Patch.AddExportEntry = function ( settings , entryCap )

    if settings.exportFilters == nil then
        settings.exportFilters = {};
    end

    for i = 1 , entryCap do
        if settings.exportFilters[i] == nil then
            if i == 23 and GRM_G.BuildVersion < 100000 then
                settings.exportFilters[i] = false;
            else
                settings.exportFilters[i] = true;
            end
        end
    end

    return settings;
end

-- 1.973
-- Method:          GRM_Patch.AddFaction( playerTable )
-- What it Does:    Adds the faction index as 0 for Horde and 1 for Alliance
-- Purpose:         Update the faction designation.
GRM_Patch.AddFaction = function ( player )

    if not player.faction then
        player.faction = -1.        -- Placeholder faction until it is actually scanned and known.
    end

    return player;
end

-- R1.976
-- Method:          GRM_Patch.FixMissingNames ( playerTable )
-- What it Does:    Looks for an empty string for player name and updates it
-- Purpose:         Restore players' name
GRM_Patch.FixMissingNames = function ()

    for guildName in pairs ( GRM_PlayersThatLeftHistory_Save ) do                  -- The guilds in each faction
        for name , player in pairs ( GRM_PlayersThatLeftHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
            if type ( player ) == "table" then

                if name == "" then
                    GRM_PlayersThatLeftHistory_Save[guildName][name] = nil;

                elseif player.name == "" then
                    player.name = name;
                end

            end
        end
    end

    for guildName in pairs ( GRM_GuildMemberHistory_Save ) do                  -- The guilds in each faction
        for name , player in pairs ( GRM_GuildMemberHistory_Save[guildName] ) do           -- The players in each guild (starts at 2 as position 1 is the name of the guild).
            if type ( player ) == "table" then

                if name == "" then
                    GRM_GuildMemberHistory_Save[guildName][name] = nil;

                elseif player.name == "" then
                    player.name = name;
                end

            end
        end
    end

    -- Check the backup data as well.
    local backup = { "members" , "formerMembers" };
    for guildName in pairs ( GRM_GuildDataBackup_Save ) do
        for i = 1 , #backup do        -- Member vs formerMember

            if GRM_GuildDataBackup_Save[guildName][backup[i]] == nil or #GRM_GuildDataBackup_Save[guildName][backup[i]] > 0 then
                GRM_GuildDataBackup_Save[guildName][backup[i]] = {};
            else
                for name , player in pairs ( GRM_GuildDataBackup_Save[guildName][backup[i]] ) do
                    if type ( player ) == "table" then

                        if name == "" then
                            GRM_GuildDataBackup_Save[guildName][backup[i]][name] = nil;

                        elseif player.name == "" then
                            player.name = name;
                        end

                    end
                end
            end

        end
    end
end

-- 1.978
-- Method:          GRM_Patch.FixSettingsNames()
-- What it Does:    Fixes an edge case issue where some of these values were ghost added
-- Purpose:         Fix an old edge case bug that was found.
GRM_Patch.FixSettingsNames = function()

    if GRM_AddonSettings_Save.coreWindowPos then
        GRM_AddonSettings_Save.coreWindowPos = nil;
    end
    if GRM_AddonSettings_Save.SyncTrackerPOS then
        GRM_AddonSettings_Save.SyncTrackerPOS = nil;
    end
    if GRM_AddonSettings_Save.RosterFramePOS then
        GRM_AddonSettings_Save.RosterFramePOS = nil;
    end
end

-- 1.978
-- Method:          GRM_Patch.ConvertSettingsToNewFormat()
-- What it Does:    Converts the settings to be a more lean and useful DB
-- Purpose:         To build a more lean settings system that will not accidentally overwrite save settings.
GRM_Patch.ConvertSettingsToNewFormat = function()
    if not GRM_AddonSettings_Save.VERSION then

        local listOfGuilds = {};
        local newSettings = {};
        local toonsInGuild = {};

        for name in pairs ( GRM_GuildMemberHistory_Save ) do
            if name:find ( "-" ) ~= nil then

                -- Add the guildName to the list.
                -- .done indicates if settings have been already completed for this guild because
                -- one toon was found with settings set to guild-wide.
                if not listOfGuilds[name] then
                    listOfGuilds[name] = {};
                    listOfGuilds[name]["done"] = false;
                end

                if not listOfGuilds[name].done then
                    toonsInGuild = GRM.GetAddOnUserGuildAlts(name);
                    if not toonsInGuild then
                        GRM_PlayerListOfAlts_Save[name] = {}
                    end

                    if GRM.TableLength(toonsInGuild) > 0 then
                        -- Add all the alts of that account to the guild
                        for names in pairs ( toonsInGuild ) do

                            -- Settings found for toon
                            if GRM_AddonSettings_Save[names] then
                                if GRM_AddonSettings_Save[names].syncSettings then
                                    -- Because they are global, we can keep add them, then break.
                                    newSettings[name] = {};
                                    GRM_AddonSettings_Save[names].version = nil;
                                    newSettings[name] = GRM.DeepCopyArray ( GRM_AddonSettings_Save[names] );
                                    listOfGuilds[name].done = true;
                                end
                            end

                        end

                        -- if not this would mean that none of the alts had syncSettings at global
                        -- In this case we find the highest rank member of the guild instead and use the settings of that player.
                        if not listOfGuilds[name].done then

                            local playerHighestRank = "";
                            local highestRank = 99;
                            local player = {};
                            for names in pairs ( toonsInGuild ) do
                                if GRM_AddonSettings_Save[names] then
                                    player = GRM.GetPlayer ( names , nil , name );
                                    if player and player.rankIndex < highestRank then
                                        highestRank = player.rankIndex;
                                        playerHighestRank = names;
                                    end
                                end
                            end

                            -- Now, check result... whoever has highest rank (lowest index) we use their settings.
                            if playerHighestRank ~= "" then
                                if GRM_AddonSettings_Save[playerHighestRank] then
                                    GRM_AddonSettings_Save[playerHighestRank].syncSettings = true;
                                    GRM_AddonSettings_Save[playerHighestRank].version = nil;
                                    newSettings[name] = {};
                                    newSettings[name] = GRM.DeepCopyArray ( GRM_AddonSettings_Save[playerHighestRank] );
                                end
                            end

                            listOfGuilds[name].done = true;

                        end
                    else
                        -- No settings to even copy, just declare this guild done.
                        listOfGuilds[name].done = true;
                    end
                end

            end
        end
        GRM_AddonSettings_Save = {};
        GRM_AddonSettings_Save = GRM.DeepCopyArray ( newSettings );

        -- Now, add your own server if this is a player who logged in in a new server
        if IsInGuild() and not GRM_AddonSettings_Save[GRM_G.guildName] then

            -- No settings established yet.
            GRM.Report ( "\n" .. GRM.L ( "Configuring Guild Roster Manager for {name} for the first time." , GRM.SlimName(GRM_G.guildName) ) );

            -- Add new guild
            GRM_AddonSettings_Save[GRM_G.guildName] = {};

            -- Load the Default Settings
            for i = 0 , GRM_G.SettingsPages do
                GRM.SetDefaultAddonSettings ( GRM_AddonSettings_Save[GRM_G.guildName] , i );
            end

            -- Forcing core log window/options frame to load on the first load ever as well
            GRM_G.ChangesFoundOnLoad = true;

        end

    end
end

-- R1.979
-- Method:          GRM_Patch.DeleteLegacyMacro()
-- What it Does:    Deletes this old macro that doesn't need to exist anymore
-- Purpose:         After removal of the old roster, this macro no longer needs to exist.
GRM_Patch.DeleteLegacyMacro = function()

    if GetMacroIndexByName ( "GRM_Roster" ) ~= 0 then
        DeleteMacro ( "GRM_Roster" );
    end
end

-- R1.981
-- Method:          GRM_Patch.ConvertExportFilters ( table )
-- What it Does:    Converts a keyed table insteasd
-- Purpose:         Much cleaner and easier to read...
GRM_Patch.ConvertExportFilters = function( exportFilters )

    local newFilters = {};

    if exportFilters and exportFilters[1] ~= nil then

        newFilters.name = exportFilters[1];
        newFilters.rank = exportFilters[2];
        newFilters.level = exportFilters[3];
        newFilters.class = exportFilters[4];
        newFilters.race = exportFilters[15];
        newFilters.sex = exportFilters[16];
        newFilters.lastOnline = exportFilters[5];
        newFilters.mainAlt = exportFilters[6];
        newFilters.alts = exportFilters[14];
        newFilters.joinDate = exportFilters[7];
        newFilters.promoteDate = exportFilters[8];
        newFilters.rankHist = exportFilters[18];
        newFilters.bday = exportFilters[9];
        newFilters.rep = exportFilters[10];
        newFilters.note = exportFilters[11];
        newFilters.oNote = exportFilters[12];
        newFilters.cNote = exportFilters[13];
        newFilters.mythicScore = exportFilters[22];
        newFilters.faction = exportFilters[23];
        newFilters.GUID = exportFilters[20];
        newFilters.MainOrAlt = exportFilters[17];
        newFilters.mainOnly = exportFilters[19];

        if GRM_G.BuildVersion < 40000 then
            newFilters.rep = false;
        end

        if GRM_G.BuildVersion < 80000 then
            newFilters.mythicScore = false;
        end

        exportFilters = newFilters;
    else
        exportFilters = {};
        exportFilters.name = true;
        exportFilters.rank = true;
        exportFilters.level = true;
        exportFilters.class = true;
        exportFilters.race = true;
        exportFilters.sex = true;
        exportFilters.lastOnline = true;
        exportFilters.mainAlt = true;
        exportFilters.alts = true;
        exportFilters.joinDate = true;
        exportFilters.promoteDate = true;
        exportFilters.rankHist = true;
        exportFilters.bday = true;
        exportFilters.rep = true;
        exportFilters.note = true;
        exportFilters.oNote = true;
        exportFilters.cNote = true;
        exportFilters.mythicScore = true;
        exportFilters.faction = true;
        exportFilters.GUID = false;
        exportFilters.MainOrAlt = false;
        exportFilters.mainOnly = true;

        if GRM_G.BuildVersion < 40000 then
            newFilters.rep = false;
        end

        if GRM_G.BuildVersion < 80000 then
            newFilters.mythicScore = false;
        end

        exportFilters = newFilters;
    end

    return exportFilters;
end

-- R1.981
-- Method:          GRM_Patch.UpdateUIScaling ( table )
-- What it Does:    Adds aanother scaling save value
-- Purpose:         Ability to scale the new roster frame.
GRM_Patch.UpdateUIScaling = function ( UIScaling )
    local rosterFrameDefault = 885;
    if GRM_G.BuildVersion >= 80000 then
        rosterFrameDefault = rosterFrameDefault + 90;
    end
    UIScaling[4] = { 1075 , 540 , 1 };                      -- Export log has been updated
    UIScaling[6] = { rosterFrameDefault , 525 , 1 };        -- Adding Roster Frame

    return UIScaling;
end

-- R1.983
-- Method:          GRM_Patch.FixAltGroupModified ( table )
-- What it Does:    Rebuilds a missing variable, if missing
-- Purpose:         Due to an old bug, some people may have lost this variable and it needs ot be restored.
GRM_Patch.FixAltGroupModified = function ( player )

    if not player.altGroupModified then
        player.altGroupModified = 0;
    end

    return player;
end

-- R1.983
-- Method:          GRM_Patch.ModifyJoinAndPromoteDates ( table )
-- What it Does:    Modifies the joinDateHist of the player
-- Purpose:         Standard format change.
GRM_Patch.ModifyJoinAndPromoteDates = function ( player )

    if player.joinDateHist then
        for i = 1 , #player.joinDateHist do

            if player.joinDateHist[i][1] == nil or player.joinDateHist[i][2] == nil or player.joinDateHist[i][3] == nil then
                player.joinDateHist[i] = { 0 , 0 , 0 , "0" , 0 , false , 1 };
            else
                if player.joinDateHist[i][1] == 0 then
                    player.joinDateHist[i][4] = "0";
                else
                    player.joinDateHist[i][4] = GRM.ConvertToStandardFormatDate ( player.joinDateHist[i][1] , player.joinDateHist[i][2] , player.joinDateHist[i][3] );
                end
            end
        end
    else
        player.joinDateHist = { { 0 , 0 , 0 , "0" , 0 , false , 1 } };
    end

    if player.rankHist then
        for i = 1 , #player.rankHist do
            if player.rankHist[i][2] == nil or player.rankHist[i][3] == nil or player.rankHist[i][4] == nil then
                player.joinDateHist[i] = { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 };
            else
                if player.rankHist[i][2] == 0 then
                    player.rankHist[i][5] = "0";
                else
                    player.rankHist[i][5] = GRM.ConvertToStandardFormatDate ( player.rankHist[i][2] , player.rankHist[i][3] , player.rankHist[i][4] );
                end
            end
        end
    else
        player.rankHist = { { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 } };
    end

    return player;
end

-- R1.983
-- Method:          GRM_Patch.UpdateRemovedMacro ( table )
-- What it Does:    Adds a new array for the specialRules that have been removed
-- Purpose:         All the control and syncing of the macro rules.
GRM_Patch.UpdateRemovedMacro = function ( rules )

    if not rules.specialRules then
        rules.specialRules = {};
    end

    return rules;
end

-- R1.985
-- Method:          GRM_Patch.FormatFixVerifiedTime ( playerTable )
-- What it Does:    Checks if the wrong info was saved as a string and the overwrites it correctly.
-- Purpose:         This ensures the proper formatting of a date.
GRM_Patch.FormatFixVerifiedTime = function ( player )

    if not player.joinDateHist then
        player.joinDateHist = { { 0 , 0 , 0 , "0" , 0 , false , 1 } };
    end

    for i = 1 , #player.joinDateHist do

        if type ( player.joinDateHist[i][5] ) == string then
            player.joinDateHist[i][5] = time();
        end

    end

    for i = 1 , #player.rankHist do

        if type ( player.rankHist[i][6] ) == string then
            player.rankHist[i][6] = time();
        end

    end

    return player;
end

-- R1.986
-- Method:          GRM_Patch.AddHardcoreVariables ( playerTable )
-- What it Does:    Adds Variables for hardcore mode
-- Purpose:         Tracking data for hardcore mode
GRM_Patch.AddHardcoreVariables = function ( player )

    if not player.HC then
        player.HC = {};
    end

    if player.HC.isDead == nil then
        player.HC.isDead = false;
    end

    if player.HC.timeOfDeath == nil then
        player.HC.timeOfDeath = { 0 , 0 , 0 , 0 , 0 , false };
        -- day , month , year , hour , min , verified
    end

    return player;
end

-- R1.986
-- Method:                  GRM_Patch.CleanupIfPlayerRolledBack()
-- What it Does:            Removes these non relevant data indexes
-- Purpose:                 This can occur if a player rolls back too far of an addon. One player rolled back a VERY early version re-adding this old DB. This will add to protect against it.
GRM_Patch.CleanupIfPlayerRolledBack = function()
    GRM_AddonSettings_Save["A"] = nil;
    GRM_AddonSettings_Save["H"] = nil;
    GRM_GuildMemberHistory_Save["A"] = nil;
    GRM_GuildMemberHistory_Save["H"] = nil;
    GRM_PlayersThatLeftHistory_Save["A"] = nil;
    GRM_PlayersThatLeftHistory_Save["H"] = nil;
    GRM_CalendarAddQue_Save["A"] = nil;
    GRM_CalendarAddQue_Save["H"] = nil;
    GRM_LogReport_Save["A"] = nil;
    GRM_LogReport_Save["H"] = nil;
    GRM_GuildDataBackup_Save["A"] = nil;
    GRM_GuildDataBackup_Save["H"] = nil;
    GRM_PlayerListOfAlts_Save["A"] = nil;
    GRM_PlayerListOfAlts_Save["H"] = nil;
end

-- R1.986
-- Method:          GRM_Patch.FixStandardFormat ( table )
-- What it Does:    Modifies the joinDateHist of the player
-- Purpose:         Standard format change.
GRM_Patch.FixStandardFormatAndRankHistFormat = function ( player )

    if player.joinDateHist and #player.joinDateHist[1] == 7 and player.joinDateHist[1][1] ~= "" then
        for i = 1 , #player.joinDateHist do
            if type ( player.joinDateHist[i][4] ) ~= string then
                if player.joinDateHist[i][1] == 0 then
                    player.joinDateHist[i][4] = "0";
                else
                    player.joinDateHist[i][4] = GRM.ConvertToStandardFormatDate ( player.joinDateHist[i][1] , player.joinDateHist[i][2] , player.joinDateHist[i][3] );
                end
            end
        end

    else
        player.rankHist = { { 0 , 0 , 0 , "0" , 0 , false , 1 } };
    end

    if player.rankHist and #player.rankHist[1] == 8 and player.rankHist[1][2] ~= "" then
        for i = 1 , #player.rankHist do
            if type ( player.rankHist[i][5] ) ~= string then
                if player.rankHist[i][2] == 0 then
                    player.rankHist[i][5] = "0";
                else
                    player.rankHist[i][5] = GRM.ConvertToStandardFormatDate ( player.rankHist[i][2] , player.rankHist[i][3] , player.rankHist[i][4] );
                end
            end
        end
    else
        player.rankHist = { { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 } };
    end

    return player;
end

-- R1.986
-- Method:          GRM_Patch.AltGroupIntegrityCheck()
-- What it Does:    Does a deep dive on every angle of the alt groups and ensures they are functional, or it cleans them out
-- Purpose:         Resolve some older edge case bugs
GRM_Patch.AltGroupIntegrityCheck = function()
    for guildName in pairs ( GRM_GuildMemberHistory_Save ) do
        if type ( GRM_GuildMemberHistory_Save[guildName] ) == "table" then
            local guildData = GRM_GuildMemberHistory_Save[guildName]
            local altsGroup = GRM_Alts[guildName];
            local player;

            if altsGroup and guildData then

                -- let's start scanning for errors!
                -- First, review altgroups to ensure they are valid
                for _ , member in pairs ( guildData ) do
                    if type ( member ) == "table" then

                        if member.altGroup ~= "" then
                            -- Confirmed, player has an alt group

                            if not GRM_Alts[guildName][member.altGroup] then
                                -- AltGroupNotFound

                                -- Remove alt Group if not found
                                member.altGroup = "";
                                member.isMain = false;
                                member.altGroupModified = 0;
                                member.mainStatusChangeTime = 0;

                            else
                                -- Alt Group Found!
                                local alts = GRM_Alts[guildName][member.altGroup];
                                local removed = false;

                                if member.isMain then

                                    -- if main is not added to alt Group, let's fix that!
                                    if alts.main == "" then

                                        -- Ensure player is added to his own altGroup
                                        for j = 1 , #alts do
                                            if alts[j].name == member.name then
                                                break;
                                                -- member found, no need to add
                                            end

                                            if j == #alts then
                                                -- not found, let's add him
                                                table.insert ( alts , {} );
                                                alts[#alts].name = member.name;
                                                alts[#alts].class = member.class;

                                                sort ( alts , function ( a , b ) return a.name < b.name end );
                                            end
                                        end

                                        alts.main = member.name;
                                        alts.timeModified = time();
                                    elseif alts.main ~= member.name then
                                        member.altGroup = "";
                                        member.isMain = false;
                                        member.altGroupModified = 0;
                                        member.mainStatusChangeTime = 0;

                                        -- remove the player from the altGroup now
                                        for j = #alts , 1 , -1 do
                                            if alts[j].name == member.name then
                                                table.remove ( alts , j );
                                                removed = true;
                                                break;
                                            end
                                        end
                                    end
                                end

                                -- Verify player is in the group.
                                if not removed then
                                    local found = false;
                                    for i = 1 , #alts do
                                        if alts[i].name == member.name then
                                            found = true;
                                        end
                                    end
                                    if not found then
                                        table.insert ( alts , {} );
                                        alts[#alts].name = member.name;
                                        alts[#alts].class = member.class

                                        sort ( alts , function ( a , b ) return a.name < b.name end );
                                    end
                                end
                            end
                        else
                            if member.isMain then
                                member.isMain = false;
                                member.altGroupModified = 0;
                                member.mainStatusChangeTime = 0;
                            end
                        end
                    end
                end

                -- Second, remove all the alts no longer in the guild
                for key in pairs ( altsGroup ) do

                    -- First, clear the alt group if no alts in it.
                    if #altsGroup[key] == 0 then
                        altsGroup[key] = nil;

                    else

                        for i = #altsGroup[key] , 1 , -1 do


                            if #altsGroup[key][i] == 2 then

                                -- Erroneous formatting
                                table.insert ( altsGroup[key] , {} );
                                altsGroup[key][#altsGroup[key]].name = altsGroup[key][i][1];
                                altsGroup[key][#altsGroup[key]].class = altsGroup[key][i][1];

                                sort ( altsGroup[key] , function ( a , b ) return a.name < b.name end );

                            end

                            player = guildData[altsGroup[key][i].name];

                            if not player or ( player and player.altGroup ~= key ) then

                                -- Clear main if player is being removed
                                if altsGroup[key].main == altsGroup[key][i].name then
                                    altsGroup[key].main = "";
                                end

                                table.remove ( altsGroup[key] , i );

                            end

                            -- Check if altGroup needs to be completely removed.
                            if #altsGroup[key] == 0 or ( #altsGroup[key] == 1 and altsGroup[key].main == "" ) then

                                if #altsGroup[key] == 1 then
                                    player = guildData[altsGroup[key][1].name];
                                    if player then
                                        player.altGroup = "";
                                        player.isMain = false;
                                        player.altGroupModified = 0;
                                        player.mainStatusChangeTime = 0;
                                    end
                                end

                                altsGroup[key] = nil;
                                break;
                            end
                        end

                    end
                end

            elseif not altsGroup and guildData then
                GRM_Alts[guildName] = {};
                GRM_Patch.ClearAllAltGroupsAndMainStatus ( guildName );

            elseif altsGroup and not guildData then
                GRM_Alts[guildName] = nil

            end
        end
    end

end

-- R1.986
-- Method:          GRM_Patch.ClearAllAltGroupsAndMainStatus ( string )
-- What it Does:    Cleans up broken alt groups for guilds and clears it all with a reset
-- Purpose:         Only wipe certain data, not all of it.
GRM_Patch.ClearAllAltGroupsAndMainStatus = function( guildName )

    local guildData = GRM.GetGuild ( guildName )

    for i = 1 , 4 do

        -- Be sure to include the former members
        if i == 2 then
            guildData = GRM.GetFormerMembers ( guildName );
        end

        if i == 3 then
            if GRM_GuildDataBackup_Save[guildName].members == nil or #GRM_GuildDataBackup_Save[guildName].members > 0 then
                GRM_GuildDataBackup_Save[guildName].members = {};
            else
                guildData = GRM_GuildDataBackup_Save[guildName].members;
            end
        end

        if i == 4 then
            if GRM_GuildDataBackup_Save[guildName].formerMembers == nil or #GRM_GuildDataBackup_Save[guildName].formerMembers > 0 then
                GRM_GuildDataBackup_Save[guildName].formerMembers = {};
            else
                guildData = GRM_GuildDataBackup_Save[guildName].formerMembers;
            end
        end

        if guildData then
            for _ , player in pairs ( guildData ) do
                if type ( player ) == "table" then
                    player.altGroupModified = 0;
                    player.mainStatusChangeTime = 0;
                    player.isMain = false;
                    player.altGroup = "";
                    player.altsAtTimeOfLeaving = {};
                    player.mainAtTimeOfLeaving = {};
                end
            end

            if i == 1 then
                GRM_Alts[guildName] = {};
            elseif i == 2 then
                GRM_GuildDataBackup_Save[guildName].alts = {};
            end
        end

    end
end

-- 1.988
-- Method:          GRM_Patch.FixStandardStamp( playerTable )
-- What it Does:    Fixes some formatting issues that existed from a previous bug
-- Purpose:         Clean up DB.
GRM_Patch.FixStandardStamp = function ( player )

    if not player.rankHist[1] or type(player.rankHist[1][2]) == "String" then
        player.rankHist = { { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 } };
    elseif type(player.rankHist[1][6]) == "String" then
        if #player.rankHist[1][6] > 0 then
            player.rankHist[1][6] = time();
            player.rankHist[1][7] = true;
        else
            player.rankHist[1][6] = 0;
            player.rankHist[1][7] = false;
        end
    end

    if not player.joinDateHist[1] or type(player.joinDateHist[1][1]) == "String" then
        player.rankHist = { { 0 , 0 , 0 , "0" , 0 , false , 1 } };
    elseif type(player.rankHist[1][5]) == "String" then
        if #player.rankHist[1][5] > 0 and player.rankHist[1][1] > 0 then
            player.rankHist[1][5] = time();
            player.rankHist[1][6] = true
        else
            player.rankHist[1][5] = 0;
            player.rankHist[1][6] = false
        end

    end

    return player
end

-- 1.990
-- Method:          GRM_Patch.FixHCModeData( playerTable )
-- What it Does:    Adds the 6th index of the timeOfDeath array. The default was only 5, but when death occurred a new entry was added
-- Purpose:         Consistency of the DB so it is easier to parse with external tools
GRM_Patch.FixHCModeData = function ( player )

    if player.HC then
        if #player.HC.timeOfDeath == 5 then
            player.HC.timeOfDeath[6] = false;
        end
    end

    return player
end

-- R1.9902
-- Method:          GRM_Patch.UpdateLevelFilterSOD ( table )
-- What it Does:    Adds a new level filter option at index 9, which is for SOD
-- Purpose:         All the control and syncing of the macro rules.
GRM_Patch.UpdateLevelFilterSOD = function ( rules )

    if #rules == 8 then
        table.insert ( rules , true )
    end

    return rules;
end

-- R1.9904
-- Method:          GRM_Patch.CleanUpGroupInfo ( table )
-- What it Does:    Purges redundant settings
-- Purpose:         Cleanup player settings from features due to Blizz restricting interact distance API
GRM_Patch.CleanUpGroupInfo = function( setting )

    setting.InteractDistanceIndicator = nil;
    setting.tradeIndicatorColorAny = nil;
    setting.tradeIndicatorColorConnectedRealm = nil;

    return setting;
end

-- Method:          GRM_Patch.FixWrathClassicEvokerBug ( playerTable )
-- What it Does:    Checks if a player class is inccorect from some weird bug in classic and wrath that the GUID
--                  was false-positive stating the player class was Evoker. Clears up old bug
GRM_Patch.FixWrathClassicEvokerBug = function ( player )

    if player.class == "EVOKER" then
        player.class = "HUNTER";
    end

    return player;
end

-- R1.9905
-- Method:          GRM_Patch.MarcoRuleDataConsistencyFix( ruleTable )
-- What it Does:    Removes a rule that doesn't apply in the macro
-- Purpose:         Cleanup rule for data consistency.
GRM_Patch.MarcoRuleDataConsistencyFix = function ( rule )

    for _, rule in pairs ( rule ) do
        rule.applyEvenIfActiive = nil;
        rule.regardlessOfActivity = nil;
        rule.rankSpecialIsMonths = nil;
        rule.rankSpecialNumDaysOrMonths = nil;
    end

    return rule;
end

-- R1.9905
-- Method:          GRM_Patch.FixMainTagColor ( rule )
-- What it Does:    Checks if there is data consistency
-- Purpose:         Due to a UI error, some data was being stored as nil and wrecking things.
GRM_Patch.FixMainTagColor = function ( rule )

    if not rule then
        rule = {};
    end

    if not rule.r then
        rule.r = 1;
        rule.g = 0;
        rule.b = 0;
    end

    return rule;
end

-- R1.9905
-- Method:          GRM_Patch.JoinDateErrorFix ( table )
-- What it Does:    Checks for the error, and if there is one, resets the metadata table.
-- Purpose:         Cleanup DB from old errors.
GRM_Patch.JoinDateErrorFix = function ( player )

    if player.joinDateHist[1] == nil or player.joinDateHist[1][3] == nil then
        player.joinDateHist = { { 0 , 0 , 0 , "0" , 0 , false , 1 } };   -- Reset the metadata
    end

    return player;
end

-- R1.99095
-- Method:          GRM_Patch.FixAltGroupData()
-- What it Does:    Fixes the alt group from an existing error where an index was missing.
-- Purpose:         Prevents addon from being able to complete scan for changes until error is fixed.
GRM_Patch.FixAltGroupData = function()

    for guildName in pairs ( GRM_Alts ) do
        for groupID , alts in pairs ( GRM_Alts[guildName] ) do
            for i = #alts , 1 , -1 do
                if alts[i] == nil then
                    table.remove ( alts , i );
                end
            end
        end
    end

    for guildName in pairs ( GRM_GuildDataBackup_Save ) do
        if GRM_Alts[guildName].alts then
            for groupID , alts in pairs ( GRM_Alts[guildName].alts ) do
                for i = #alts , 1 , -1 do
                    if alts[i] == nil then
                        table.remove ( alts , i );
                    end
                end
            end
        end
    end
end

-- R1.99096
-- Method:              GRM_Patch.AddNewLevelFilters ( table )
-- What it Does:        Adds 2 new boolean points in the levelFilters table, to account for Cata, and also the MOP classic changes in 10.2.7
-- Purpose:             Ensure one build compatibility.
GRM_Patch.AddNewLevelFilters = function ( levelFilters )

    if #levelFilters == 9 then
        table.insert ( levelFilters , true );
    end

    if #levelFilters == 10 then
        table.insert ( levelFilters , true );
    end

    return levelFilters
end

-- R1.990992        GRM_Patch.FixRanKHistError ( playerTable )
-- What it Does:    Resets the rank history of the data was corrupted
-- Purpose:         There was a bug that seemed to affect some players due to a previous error that crashed in middle of update.
GRM_Patch.FixRanKHistError = function ( player )
    if type ( player.rankHist[1][5] ) == "number" then
        if #(tostring(player.rankHist[1][5])) == 8 then
            player.rankHist[1][5] = tostring ( player.rankHist[1][5] );
        end
    end
    if player.rankHist[1][3] == nil or player.rankHist[1][4] == nil or type(player.rankHist[1][4]) == "string" or type(player.rankHist[1][5]) == "number" then
        player.rankHist = { { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 } };
    end
    return player
end

-- R1.990992
-- Method:          GRM_Patch.PlayerPromotedToOfficerNoteUpdate( playerTable )
-- What it Does:    Sets any nil officer notes to an empty string
-- Purpose:         Fixes an old reference issue for players who were not officers or were promoted to officer
GRM_Patch.PlayerPromotedToOfficerNoteUpdate = function( player )
    if player.officerNote == nil then
        player.officerNote = "";
    end
    player = GRM_Patch.FixRanKHistError ( player );
    return player
end

-- R1.9910
-- Method:          GRM_Patch.BuildNewMainAltDB()
-- What it Does:    Adds the mains to the new database
-- Purpose:         Building a custom relational DB with the groupID as the foreign key in the new Mains table -- easier lookup
GRM_Patch.BuildNewMainAltDB = function()
    local timestamp = time();
    local GRM_Mains = {};

    -- For current guild.
    for guildName , guildData in pairs ( GRM_GuildMemberHistory_Save ) do
        if type ( guildData ) == "table" then
            local alts = GRM.GetGuildAlts ( guildName );

            -- Let's create the new guild entry (or set it to it in case player say, disconnected in middle of update)
            GRM_Mains[guildName] = GRM_Mains[guildName] or {};

            -- Now we need to add all the mains to the new Main DB
            for name , player in pairs ( guildData ) do
                if type ( player ) == "table" then

                    group = alts[player.altGroup];

                    -- Mains
                    if player.isMain and group and group.main == name then
                        GRM_Mains[guildName][name] = player.altGroup;
                    end

                    -- Alt Group timestamp
                    if not player.altGroupLeft then
                        player.altGroupLeft = 0;
                    end

                    -- Legacy bug where incorrect number was used in timestamp
                    if group then
                        player.altGroupLeft = 0; -- Player is in a group...

                        if group.timeModified >= timestamp or group.timeModified == 0 then
                            group.timeModified = 1;
                        end

                        if player.mainStatusChangeTime >= timestamp then
                            player.mainStatusChangeTime = 1;
                        end

                        if #group == 1 then -- only a main
                            if player.isMain and player.mainStatusChangeTime < timestamp then
                                group.timeModified = tonumber ( player.mainStatusChangeTime );

                            elseif not player.isMain then   -- In a 1 person group but is not the main. Group should not exist.
                                GRM_Mains[guildName][name] = nil;
                                alts[player.altGroup] = nil;
                                player.altGroupLeft = 0;
                                player.altGroup = "";
                            end
                        end
                    else
                        if player.altGroupModified then
                            player.altGroupLeft = tonumber ( player.altGroupModified ); -- has left a group
                        end
                        player.altGroup = "";       -- Eliminates an old bug reference if player had an altGroup but no alt Group
                    end

                    if player.altGroupLeft >= timestamp then
                        player.altGroupLeft = 1;
                    end

                    -- Lineup the timestamps
                    if group and group.timeModified ~= player.altGroupLeft then
                        if group.timeModified < player.altGroupLeft then
                            group.timeModified = tonumber ( player.altGroupLeft );
                        else
                            player.altGroupLeft = 0;
                        end
                    end

                    -- Now, wipe the old data
                    player.isMain = nil;
                    player.mainStatusChangeTime = nil;
                    player.altGroupModified = nil;

                end
            end
        end
    end
    -- For backups
    for guildName , guildData in pairs ( GRM_GuildDataBackup_Save ) do
        if type ( guildData ) == "table" then
            local alts = guildData.alts;

            -- This indicates that there is actual save data
            if alts and guildData.numGuildies > 0 then
                for name , player in pairs ( guildData.members ) do
                    if type ( player ) == "table" then

                        group = alts[player.altGroup];

                        -- Mains
                        if player.isMain and group and group.main == name then
                            GRM_Mains[guildName][name] = player.altGroup;
                        end

                        -- Alt Group timestamp
                        if not player.altGroupLeft then
                            player.altGroupLeft = 0;
                        end

                        -- Legacy bug where incorrect number was used in timestamp
                        if group then
                            player.altGroupLeft = 0; -- Player is in a group...

                            if group.timeModified >= timestamp or group.timeModified == 0 then
                                group.timeModified = 1;
                            end

                            if player.mainStatusChangeTime >= timestamp then
                                player.mainStatusChangeTime = 1;
                            end
                            if #group == 1 then -- only a main
                                if player.isMain and player.mainStatusChangeTime < timestamp then
                                    group.timeModified = tonumber ( player.mainStatusChangeTime );

                                elseif not player.isMain then   -- In a 1 person group but is not the main. Group should not exist.
                                    GRM_Mains[guildName][name] = nil;
                                    alts[player.altGroup] = nil;
                                    player.altGroupLeft = 0;
                                    player.altGroup = "";
                                end
                            end
                        else
                            if player.altGroupModified then
                                player.altGroupLeft = tonumber ( player.altGroupModified ); -- has left a group
                            end
                        end

                        if player.altGroupLeft >= timestamp then
                            player.altGroupLeft = 1;
                        end

                        -- Lineup the timestamps
                        if group and group.timeModified ~= player.altGroupLeft then
                            if group.timeModified < player.altGroupLeft then
                                group.timeModified = tonumber ( player.altGroupLeft );
                            else
                                player.altGroupLeft = 0;
                            end
                        end

                        -- Now, wipe the old data
                        player.isMain = nil;
                        player.mainStatusChangeTime = nil;
                        player.altGroupModified = nil;

                    end
                end
            end
        end
    end

end

-- 1.9911
-- Method:          GRM_Patch.ModifyCustomNote ( playerTable )
-- What it Does:    Removes the 4th rank restriction index from the custom Note.
-- Purpose:         This is deprecated and only left in to not have to deal with rewriting a lot. The overall custom note sync rank restriction handles this now.
GRM_Patch.ModifyCustomNote = function ( player )
    if #player.customNote == 6 then
        table.remove ( player.customNote , 4 ); -- Remove the depreceated index
    end
    if #player.customNote == 5 then
        table.remove ( player.customNote , 4 ); -- Remove the rank action deprecated index next, which is now in same position
    end
    return player;
end

-- 1.9913
-- Method:          GRM_Patch.AltGroupUpdateTweak()
-- What it Does;    Does an integrity check fix from a carryover bug on the DB overhaul
-- Purpose:         Ensure DB has a good starting point.
GRM_Patch.AltGroupUpdateTweak = function()

    local namesCollected = {};
    local altGroups = {};
    local player = {};
    local count = 0;
    local count2 = 0;

    for guildName , guildData in pairs ( GRM_GuildMemberHistory_Save ) do
        if type ( guildData ) == "table" then
            altGroups = GRM.GetGuildAlts ( guildName );
            namesCollected = {};                        -- Reset for each guild

            if altGroups then

                -- First, scan through every alt group, check every toon and ensure it corresponds to their player altGroup reference in playerTable.
                for groupNum , group in pairs ( altGroups ) do
                    if #group > 0 then
                        for i = #group , 1, -1 do

                            player = GRM.GetPlayer ( group[i].name , false , guildName );

                            if player then
                                -- Ok, player exists, now let's ensure the alt group is properly matching.
                                if player.altGroup ~= groupNum and not namesCollected[ group[i].name ] then
                                    -- THEY DO NOT MATCH AND name has not been processed.
                                    player.altGroup = groupNum;
                                    namesCollected[ group[i].name ] = true;

                                elseif player.altGroup ~= groupNum and namesCollected[ group[i].name ] then
                                    -- THEY DO NOT MATCH AND NAME HAS BEEN PROCESSED
                                    -- Since already processed, we are just going to purge the alt from the group, and assume player.altGroup is good.
                                    table.remove ( group , i );
                                    if #group == 0 then -- After removing, no one is left.
                                        GRM_Alts[guildName][groupNum] = nil;
                                    elseif group.main == player.name then
                                        group.main = "";
                                    end

                                elseif player.altGroup == groupNum and not namesCollected[ group[i].name ] then
                                    -- THEY DO MATCH AND NAME NOT PROCESSED - LOOKS GOOD!
                                    count2 = count2 + 1;
                                    namesCollected[ group[i].name ] = true;
                                end


                            else
                                -- Remove player from the alt group since it doesn't exist in guild.
                                namesCollected[ group[i].name ] = true;
                                table.remove ( group , i );
                                if #group == 0 then -- After removing, no one is left.
                                    GRM_Alts[guildName][groupNum] = nil;
                                elseif group.main == player.name then
                                    group.main = "";
                                end
                            end
                            count = count +1;
                        end
                    else
                        GRM_Alts[guildName][groupNum] = nil;        -- This should never happen, but cleanup in case of older legacy issue
                    end
                end

            end
        end
    end

    -- For backups
    for guildName , guildData in pairs ( GRM_GuildDataBackup_Save ) do
        if type ( guildData ) == "table" then
            altGroups = guildData.alts;
            namesCollected = {};                        -- Reset for each guild

            -- This indicates that there is actual save data
            if altGroups and guildData.numGuildies > 0 then

                -- First, scan through every alt group, check every toon and ensure it corresponds to their player altGroup reference in playerTable.
                for groupNum , group in pairs ( altGroups ) do
                    if #group > 0 then
                        for i = #group , 1, -1 do

                            player = guildData.members[ group[i].name ];

                            if player then
                                -- Ok, player exists, now let's ensure the alt group is properly matching.
                                if player.altGroup ~= groupNum and not namesCollected[ group[i].name ] then
                                    -- THEY DO NOT MATCH AND name has not been processed.
                                    player.altGroup = groupNum;
                                    namesCollected[ group[i].name ] = true;

                                elseif player.altGroup ~= groupNum and namesCollected[ group[i].name ] then
                                    -- THEY DO NOT MATCH AND NAME HAS BEEN PROCESSED
                                    -- Since already processed, we are just going to purge the alt from the group, and assume player.altGroup is good.
                                    table.remove ( group , i );
                                    if #group == 0 then -- After removing, no one is left.
                                        altGroups[groupNum] = nil;
                                    elseif group.main == player.name then
                                        group.main = "";
                                    end

                                elseif player.altGroup == groupNum and not namesCollected[ group[i].name ] then
                                    -- THEY DO MATCH AND NAME NOT PROCESSED - LOOKS GOOD!
                                    count2 = count2 + 1;
                                    namesCollected[ group[i].name ] = true;
                                end


                            else
                                -- Remove player from the alt group since it doesn't exist in guild.
                                namesCollected[ group[i].name ] = true;
                                table.remove ( group , i );
                                if #group == 0 then -- After removing, no one is left.
                                    altGroups[groupNum] = nil;
                                elseif group.main == player.name then
                                    group.main = "";
                                end
                            end
                            count = count +1;
                        end
                    else
                        altGroups[groupNum] = nil;        -- This should never happen, but cleanup in case of older legacy issue
                    end
                end


            end
        end
    end
    print(count .. " : " .. count2)
end

-- R1.9913          GRM_Patch.FixLegacyFormattingErrorOnRankAndJoinHist ( playerTable )
-- What it Does:    Resets the rank history of the data was corrupted
-- Purpose:         There was a bug that seemed to affect some players due to a previous error that crashed in middle of update.
GRM_Patch.FixLegacyFormattingErrorOnRankAndJoinHist = function ( player )

    if type (player.rankHist[1][6]) == "string" then
        if player.rankHist[1][7] == true and player.rankHist[1][2] and type ( player.rankHist[1][2] ) == "number" and player.rankHist[1][2] > 0 and player.rankHist[1][3] and type ( player.rankHist[1][3] ) == "number" and player.rankHist[1][3] > 0 and player.rankHist[1][4] and type ( player.rankHist[1][4] ) == "number" and player.rankHist[1][4] > 0 and type ( player.rankHist[1][5] ) == "string" and #player.rankHist[1][5] == 8 then
            player.rankHist[1][6] = 1;  -- Placeholder time as verified.
        else
            player.rankHist = { { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 } };
        end
    end

    if type (player.joinDateHist[1][5]) == "string" then
        if player.joinDateHist[1][5] == true and player.joinDateHist[1][1] and type ( player.joinDateHist[1][1] ) == "number" and player.joinDateHist[1][1] > 0 and player.joinDateHist[1][2] and type ( player.joinDateHist[1][2] ) == "number" and player.joinDateHist[1][2] > 0 and player.joinDateHist[1][3] and type ( player.joinDateHist[1][3] ) == "number" and player.joinDateHist[1][3] > 0 and type ( player.joinDateHist[1][4] ) == "string" and #player.joinDateHist[1][4] == 8 then
            player.joinDateHist[1][5] = 1;  -- Placeholder time as verified.
        else
            player.joinDateHist = { { 0 , 0 , 0 , "0" , 0 , false , 1 } };
        end
    end

    return player
end

-- R1.9913
-- Method:          GRM_Patch.ConvertHours ( playerTable )
-- What it Does:    Converts the total number of hours into a table representing count of each day
-- Purpose:         Added a new table, this fixes that.
GRM_Patch.ConvertHours = function( player )
    local totalHrs = player.lastOnline;

    local years = math.floor( totalHrs / 8760)  -- 8760 hours in a year (365 days * 24 hours)
    totalHrs = totalHrs % 8760                    -- Remaining hours after extracting years

    local months = math.floor( totalHrs / 720)  -- 720 hours in a month (30 days * 24 hours)
    totalHrs = totalHrs % 720                     -- Remaining hours after extracting months

    local days = math.floor( totalHrs / 24 )     -- 24 hours in a day
    local remaining_hours = totalHrs % 24      -- Remaining hours after extracting days
    player.lastOnlineTime = { years , months , days , remaining_hours };

    return player
end