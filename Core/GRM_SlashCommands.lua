---------------------------------------------
-------- SLASH COMMAND FUNCTIONS ------------
---------------------------------------------

-- Method:          GRM.SlashCommandScan()
-- What it Does:    Triggers a one-time scan of the guild for changes.
-- Purpose:         Mainly useful for people that wish to disable active scanning and just do a 1-time check on occasion.
GRM.SlashCommandScan = function()
    GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("Scanning for Guild Changes Now. One Moment..."));
    GRM_G.ManualScanEnabled = true;
    GRM.GuildRoster();
    QueryGuildEventLog();
    C_Timer.After(1.5, GRM.Scan.BuildNewRoster);
end

-- Method:          GRM.SlashCommandSync()
-- What it Does:    Activates a one-time data sync with guildies
-- Purpose:         For people that want to sync data, but don't want it to be on all the time, just on occasion as they choose.
--                  Flexibility to the user!
GRM.SlashCommandSync = function(count)

    count = count or 0;

    -- Let's recheck permissions as they can change mid-session if guild permissions are adjusted by guild leader.
    if not GRM_G.HasAccessToGuildChat and count == 0 then
        GRM.Util.RegisterGuildChatPermission();

        C_Timer.After(1, function()
            GRM.SlashCommandSync(1); -- Delay to ensure server has a second to send the response. - Count is to retry once.
        end);
        return;
    end

    if not GRMsyncGlobals.UILoaded then
        GRMsync.LoadSyncUI();
    end

    -- if not GRM_UI.GRM_SyncTrackerWindow:IsVisible() then
    --     GRM_UI.GRM_SyncTrackerWindow:Show();
    -- else
    if GRM.S().syncEnabled and GRM_G.HasAccessToGuildChat and not GRM_G.InGroup then

        if ((time() - GRMsyncGlobals.timeAtLogin) >= GRM.S().syncDelay) and not GRM_G.OnFirstLoad then

            if GRMsyncGlobals.currentlySyncing or
                (not GRMsyncGlobals.currentlySyncing and (time() - GRM_G.slashCommandSyncTimer > 10) and
                    (time() - GRMsyncGlobals.timeOfLastSyncCompletion > 10)) then

                if not GRMsyncGlobals.currentlySyncing then

                    GRMsyncGlobals.reloadControl = false; -- Remove the hold on the first sync if it applies.

                    -- if not GRMsyncGlobals.SyncTracker.TriggeringSync then
                    --     GRMsyncGlobals.SyncTracker.TriggeringSync = true;
                    --     GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Initializing Sync. One Moment..." ) );
                    --     GRM_API.ResetProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 1 , 0 , 0 } , false );
                    -- end

                    GRM_G.slashCommandSyncTimer = time();

                    GRM.Report(GRM.L("Initializing Sync Action. One Moment..."));

                    if not GRM_UI.GRM_CoreFrame.GRM_AddonUsersFrame:IsVisible() then
                        GRM.RegisterGuildAddonUsersRefresh();
                    end

                    -- GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Hide();

                    C_Timer.After(1.5, GRMsync.Initialize);

                    -- Now, let's add a brief delay, 3 seconds, to trigger sync again
                    C_Timer.After(10, function()

                        if not GRMsyncGlobals.currentlySyncing and GRM.GetNumAddonUsersAvailableToSync() == 0 and
                            GRM.S().syncEnabled then

                            if #GRM_G.currentAddonUsers == 0 then
                                GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("No Players Currently Online to Sync With..."));
                                -- GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();
                                GRMsync.ResetSyncTracker();
                            else
                                if #GRM_G.currentAddonUsers == 1 then
                                    GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("No Member is Available to Sync"));
                                    -- GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();
                                    GRMsync.ResetSyncTracker();
                                else

                                end
                            end
                            -- GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();

                        else
                            C_Timer.After(GRMsyncGlobals.ErrorCD + 1, function()
                                if not GRMsyncGlobals.WaitingInQue then
                                    if not GRMsyncGlobals.currentlySyncing and
                                        ((time() - GRMsyncGlobals.timeOfLastSyncCompletion >= 16) and
                                            ((time() - GRMsyncGlobals.TimeSinceLastSyncAction) >= GRMsyncGlobals.ErrorCD)) then
                                        GRM.Report(GRM.L("GRM:") .. " " ..
                                                       GRM.L("Sync has failed to start. Please try again!"));
                                        -- GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();
                                        GRMsync.ResetSyncTracker();
                                    end
                                end
                            end);
                        end
                    end);
                else
                    local name = "";
                    if GRMsyncGlobals.IsElectedLeader then
                        name = GRM.GetClassifiedName(GRMsyncGlobals.CurrentSyncPlayer);
                    else
                        name = GRM.GetClassifiedName(GRMsyncGlobals.DesignatedLeader)
                    end
                    GRM.Report(GRM.L("GRM:") .. " " ..
                                   GRM.L(
                            "Currently syncing with {name}. Please wait until after sync completes to activate again.",
                            name));
                end

            else
                local timer = (time() - GRM_G.slashCommandSyncTimer);
                if (time() - GRMsyncGlobals.timeOfLastSyncCompletion) < timer then
                    timer = (time() - GRMsyncGlobals.timeOfLastSyncCompletion);
                end

                GRM.Report(GRM.L("Please wait {num} more seconds before manually initiating the sync process again.",
                    nil, nil, 15 - timer));
                -- GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();
                GRMsync.ResetSyncTracker();

            end
        else
            GRM.Report(GRM.L(
                "Sync is disabled for {num} seconds after logging in. Please wait {custom1} seconds longer.", nil, nil,
                GRM.S().syncDelay, (GRM.S().syncDelay - (time() - GRMsyncGlobals.timeAtLogin))));
            -- GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();
            GRMsync.ResetSyncTracker();

        end

    elseif not GRM.S().syncEnabled then
        local restartSync = function()
            GRM.S().syncEnabled = true;
            GRM_UI.EnableSyncUIChanges();
            GRM.RegisterMessage();
            GRM.SlashCommandSync();
        end

        GRM.SetConfirmationWindow(restartSync, GRM.L("Sync is Currently Disabled. Do you wish to re-enable?"));

    elseif GRM_G.HasAccessToGuildChat and GRM_G.InGroup then
        GRM.Report(GRM.L(
            "SYNC is currently disabled while you are grouped. Due to server restricted addon to addon talk data caps, and in an effort to avoid clogging up the shared global comm space of all addons, sync will be temporarily restricted while grouped."));

    elseif not GRM_G.HasAccessToGuildChat then
        GRM.Report(GRM.L("SYNC is currently not possible! Unable to Sync with guildies when guild chat is restricted."));
    end
    -- end

end

-- Method:          GRM.SlashCommandCenter()
-- What it Does:    It Centers all of the windows, in case the player dragged them off the screen
-- Purpose:         Help keep frames organized. Just a necessary feature as someone is eventually going to say they tossed the frame off screen.
GRM.SlashCommandCenter = function()
    GRM_UI.GRM_CoreFrame:ClearAllPoints();
    GRM_UI.GRM_CoreFrame:SetPoint("CENTER", UIParent);
    GRM.S().CoreWindowPos = {"", "", 0, 0};

    GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame:ClearAllPoints();
    GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame:SetPoint("CENTER", UIParent);

    GRM_UI.GRM_AuditJDTool:ClearAllPoints();
    GRM_UI.GRM_AuditJDTool:SetPoint("CENTER", UIParent);

    GRM_UI.GRM_ToolCoreFrame:ClearAllPoints();
    GRM_UI.GRM_ToolCoreFrame:SetPoint("CENTER", UIParent);

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:ClearAllPoints();
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetPoint("CENTER", UIParent);

    GRM_UI.GRM_RosterFrame:ClearAllPoints();
    GRM_UI.GRM_RosterFrame:SetPoint("CENTER", UIParent);
    GRM.S().RosterFramePOS = {"", "", 0, 0};

    if GRMsyncGlobals.UILoaded then
        -- GRM_UI.GRM_SyncTrackerWindow:ClearAllPoints();
        -- GRM_UI.GRM_SyncTrackerWindow:SetPoint ( "CENTER" , UIParent );
        GRM.S().SyncTrackerPOS = {"", "", 0, 0};
    end

    GRM.S().macroToolCoordinates = {"", "", 0, 0};

    GRM_UI.ResetScalingForAll();
    local rosterFrameDefault = 885;

    if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA then -- Mythic Rating Frame Size
        rosterFrameDefault = rosterFrameDefault + 90;
    end

    GRM.S().UIScaling = {{600, 535, 1.0}, {400, 439, 1.0}, {1200, 515, 1.0}, {1100, 540, 1.0}, {875, 400, 1.0},
                         {rosterFrameDefault, 525, 1.0}};
end

-- Method:          GRM.SlashCommandHelp()
-- What it Does:    Displays a list of all slash commands and what they do
-- Purpose:         To HELP the player with slash commands lol
GRM.SlashCommandHelp = function()

    local slash = "/grm";
    local slash2 = "/roster";
    if GRM_L["/XXXX"] ~= true then
        slash = GRM_L["/XXXX"];
    end
    if GRM_L["/YYYY"] ~= true then
        slash2 = GRM_L["/YYYY"];
    end

    GRM.Report("\n" .. GRM.L("Guild Roster Manager") .. " " .. GRM.L("(Ver:") .. " " .. GRM_G.Version .. ( GRM_G.Beta and " - Beta" or "" ) .. ")\n\n" ..
                   slash .. "                     - " .. GRM.L("Opens Guild Log Window") .. "\n" .. slash2 ..
                   "                   - " .. GRM.L("Opens Custom Guild Roster Window") .. "\n" .. slash .. " " ..
                   GRM.L("clearall") .. "         - " .. GRM.L("Resets ALL saved data") .. "\n" .. slash .. " " ..
                   GRM.L("clearguild") .. "     - " .. GRM.L("Resets saved data only for current guild") .. "\n" ..
                   slash .. " " .. GRM.L("center") .. "          - " .. GRM.L("Re-centers the Log window") .. "\n" ..
                   slash .. " " .. GRM.L("sync") .. "             - " ..
                   GRM.L("Triggers manual re-sync if sync is enabled") .. "\n" .. slash .. " " ..
                   string.lower(GRM.L("Export")) .. "          - " .. GRM.L("Opens the Data Export Tool") .. "\n" ..
                   slash .. " " .. string.lower(GRM.L("Macro")) .. "           - " ..
                   GRM.L("Opens the Advanced Macro Tool") .. "\n" .. slash .. " <" .. GRM.L("TabName") .. ">  - " ..
                   GRM.L("Open any GRM window: {name}, {name2}, {custom1}, etc.", GRM.L("log"), GRM.L("event"), nil,
            GRM.L("ban")) .. "\n" .. slash .. " " .. GRM.L("scan") .. "             - " ..
                   GRM.L("Does a one-time manual scan for changes") .. "\n" .. slash .. " " .. GRM.L("dead") ..
                   "             - " .. GRM.L("Does a one-time check for dead accounts") .. "\n" .. slash .. " " ..
                   GRM.L("version") .. "         - " .. GRM.L("Displays current Addon version") .. "\n" .. slash .. " " ..
                   "guid" .. "              - " .. GRM.L("Add unique player GUID to chat window to copy") .. "\n" .. slash .. " " ..
                   "prof" .. "              - " .. GRM.L("Update profession ranks (Classic Era Only)") .. "\n" .. slash .. " " ..
                   "altlimit X" .. "      - " .. GRM.L("X = any number. Receive report on alt group sizes over limit") .. "\n" .. slash ..
                   " " .. GRM.L("hardreset") .. "      - " ..
                   GRM.L("WARNING! Complete hard wipe, including settings, as if addon was just installed."));
end

-- Method:          GRM.SlashCommandClearAll()
-- What it Does:    Resets all data account wide, as if the addon was just installed, on the click of the button.
-- Purpose:         Useful to purge data in case of corruption or trolling or other misc. reasons.
GRM.SlashCommandClearAll = function()
    GRM_UI.GRM_CoreFrame:EnableMouse(false);
    GRM_UI.GRM_CoreFrame:SetMovable(false);
    GRM_UI.GRM_RosterConfirmFrameText:SetText(GRM.L("Really Clear All Account-Wide Saved Data?"));
    GRM_UI.GRM_RosterConfirmYesButtonText:SetText(GRM.L("Yes!"));
    GRM_UI.GRM_RosterConfirmYesButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            GRM.ResetAllSavedData(); -- Resetting!
            GRM_UI.GRM_RosterConfirmFrame:Hide();
        end
    end);
    GRM_UI.GRM_RosterConfirmFrame:Show();
end

-- Method:          GRM.SlashCommandClearGuild()
-- What it Does:    Resets all data guild wide, as if the guild is brand new or newly joined.
-- Purpose:         Useful to purge the data if someone trolled the guild and made a mess of the data,
-- or if there is a major error corrupting the data, but you don't want to wipe all account wide
GRM.SlashCommandClearGuild = function()
    GRM_UI.GRM_CoreFrame:EnableMouse(false);
    GRM_UI.GRM_CoreFrame:SetMovable(false);
    GRM_UI.GRM_RosterConfirmFrameText:SetText(GRM.L("Really Clear All Guild Saved Data?"));
    GRM_UI.GRM_RosterConfirmYesButtonText:SetText(GRM.L("Yes!"));
    GRM_UI.GRM_RosterConfirmYesButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            -- Kill switch the scanning
            GRM_UI.GRM_RosterConfirmFrame:Hide();
            if GRM_G.CurrentlyScanning then
                GRM_G.changeHappenedExitScan = true;
            end
            GRMsync.EndSync(true); -- Force ending sync
            GRM.Report(GRM.L("Wiping all saved Guild data! Rebuilding from scratch...")); -- Give instant response message even though action takes a second.

            GRM.ResetGuildSavedData(GRM_G.guildName); -- Resetting!

        end
    end);
    GRM_UI.GRM_RosterConfirmFrame:Show();
end

-- Method:          GRM.HardReset()
-- What it Does:    It deletes player addon settings, thus the addon detects that and assumes
--                  this is the first time any toon has logged in with addon installed and
--                  triggers full reset and initialization.
-- Purpose:         To bypass all UI features and do a full hard reset, if the player needs
--                  This has no warning, so it is mainly for emergency resets, just in case
GRM.HardReset = function()

    local hardReset = function()
        GRM_AddonSettings_Save = nil;
        GRM_AddonSettings_Save = {};
        ReloadUI();
    end

    GRM.SetConfirmationWindow(hardReset, GRM.L("Do you really want to wipe all GRM data and settings account-wide?"));
end

-- Method:          GRM.SlashCommandVersion()
-- What it Does:    Displays the version of the addon (all viewable with /roster help)
-- Purpose:         General info if wanted.
GRM.SlashCommandVersion = function()
    GRM.Report("\n" .. GRM.L("Guild Roster Manager") .. "\n" .. GRM.L("(Ver:") .. " " .. GRM_G.Version .. ( GRM_G.Beta and " - Beta" or "" ) .. ")\n");
end

-- Method:          GRM.SlashCommandMinimapReset()
-- What it Does:    Resets the minimap to default position
-- Purpose:         In case player drags the minimap off screen...
GRM.SlashCommandMinimapReset = function()
    GRM.MinimapGRM.ResetMinimapPositionToDefault()
end

-- Method:          GRM.SlashCommandKick()
-- What it Does:    Opens or closes the mass kick window
-- Purpose:         Allow slash command use of the mass kick window for ease
GRM.SlashCommandKick = function()
    if not IsInGuild() then
        GRM.Report(GRM.L("You must be in a guild to view the Guild Macro Tool!"));
        return
    end
    
    if (time() - GRMsyncGlobals.timeAtLogin) > 5 or GRM_G.MinimapOk then
        if GRM_UI.GRM_ToolCoreFrame:IsVisible() then
            GRM_UI.GRM_ToolCoreFrame:Hide();
        else
            GRM_UI.GRM_ToolCoreFrame:Show();
        end
    else
        GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("One moment, GRM is still being configured."));
    end
end

-- Method:          GRM.SlashCommandBan()
-- What it Does:    Opens the Ban window by slash command
-- Purpose:         Expanded slash command controls.
GRM.SlashCommandBan = function()
    if not GRM_UI.GRM_CoreFrame:IsVisible() then
        GRM_UI.GRM_CoreFrame:Show();
    end
    GRM_UI.GRM_CoreFrame.GRM_BanListTab:Click();
end

-- Method:          GRM.SlashCommandAudit()
-- What it Does:    Opens the Audit window by slash command
-- Purpose:         Expanded slash command controls.
GRM.SlashCommandAudit = function()
    if not GRM_UI.GRM_CoreFrame:IsVisible() then
        GRM_UI.GRM_CoreFrame:Show();
    end
    GRM_UI.GRM_CoreFrame.GRM_GuildAuditTab:Click();
end

-- Method:          GRM.SlashCommandLog()
-- What it Does:    Opens the Log window by slash command
-- Purpose:         Expanded slash command controls.
GRM.SlashCommandLog = function()
    if not GRM_UI.GRM_CoreFrame:IsVisible() then
        GRM_UI.GRM_CoreFrame:Show();
    end
    GRM_UI.GRM_CoreFrame.GRM_LogTab:Click();
end

-- Method:          GRM.SlashCommandUsers()
-- What it Does:    Opens the Sync Users window by slash command
-- Purpose:         Expanded slash command controls.
GRM.SlashCommandUsers = function()
    if not GRM_UI.GRM_CoreFrame:IsVisible() then
        GRM_UI.GRM_CoreFrame:Show();
    end
    GRM_UI.GRM_CoreFrame.GRM_AddonUsersTab:Click();
end

-- Method:          GRM.SlashCommandEvents()
-- What it Does:    Opens the Events window by slash command
-- Purpose:         Expanded slash command controls.
GRM.SlashCommandEvents = function()
    if not GRM_UI.GRM_CoreFrame:IsVisible() then
        GRM_UI.GRM_CoreFrame:Show();
    end
    GRM_UI.GRM_CoreFrame.GRM_AddEventTab:Click();
end

-- Method:          GRM.SlashCommandOptions()
-- What it Does:    Opens the Options window by slash command
-- Purpose:         Expanded slash command controls.
GRM.SlashCommandOptions = function()
    if not GRM_UI.GRM_CoreFrame:IsVisible() then
        GRM_UI.GRM_CoreFrame:Show();
    end
    GRM_UI.GRM_CoreFrame.GRM_OptionsTab:Click();
end


-- Method:          GRM.SlashCommandExport()
-- What it Does:    Opens the export window
-- Purpose:         Give player access to feature@
GRM.SlashCommandExport = function()
    if IsInGuild() then
        if GRM_G.guildName ~= "" then
            if not GRM_UI.GRM_ExportLogBorderFrame then
                GRM.Export.LoadExportUI( false );
                GRM_UI.GRM_ExportLogBorderFrame.TabPosition = 1;
                GRM.Export.SetExportTabHighlights();
                GRM_UI.GRM_ExportLogBorderFrame:Show();
            else
                if not GRM_UI.GRM_ExportLogBorderFrame:IsVisible() then
                    GRM_UI.GRM_ExportLogBorderFrame.TabPosition = 1;
                    GRM_UI.GRM_ExportLogBorderFrame:Show();
                else
                    GRM_UI.GRM_ExportLogBorderFrame:Hide();
                end
            end
        else
            GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("One moment, GRM is still being configured."));
        end
    else
        GRM.Report(GRM.L("{name} is not currently in a guild. Unable to Proceed!", GRM.SlimName(GRM_G.addonUser)));
    end
end

-- Method:          GRM.SlashCommandModulesOptions()
-- What it Does:    Opens the Module tab under Options
-- Purpose:         Easy slash command control to get here.
GRM.SlashCommandModulesOptions = function()
    GRM.SlashCommandOptions();
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_ModulesTab:Click();
end

-- Method:          GRM.SlashCommandGUID()
-- What it Does:    Pastes the player's GUID to the chat box to easily be copied
-- Purpose:         Special use case to obtain GUIDs
GRM.SlashCommandGUID = function()
    local guid = UnitGUID("PLAYER");
    if not GRM.issecretvalue(guid) then
        C_Timer.After(0.5,
            function() -- Need to add slight delay as hitting enter on the keyboard for the command auto closes.
                ChatFrameUtil.OpenChat(guid);
            end);
    else
        GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("Unable to Retrieve. Addons currently restricted."))
    end
end

-- Method:          GRM.SlashCommandProf()
-- What it Does:    Triggers the profession note update to run with a slash command
-- Purpose:         Allow the quick updating of professions.
GRM.SlashCommandProf = function()
    if GRM_G.BuildVersion < GRM_ENUM.BUILD.BFA and C_GuildInfo.IsGuildOfficer() then
        GRM_UI.ExportProfessionConfirm();
    else
        if GRM_G.BuildVersion >= GRM_ENUM.BUILD.WOD then
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Only Available in Classic or Forever" ) );
        elseif not C_GuildInfo.IsGuildOfficer() then
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Only Available for Officers" ) );
        end
    end
end

GRM.SlashCommandSearch = function(text)
    local searchName;

    if GRM.GetPlayer(GRM_G.addonUser) then
        GRM.SlashCommandAudit();

        -- if text == string.lower ( GRM.L ( "Search" ) ) or text == "Search" then
        -- Open search window, but nothing to search

        if string.match(text, "(" .. string.lower(GRM.L("Search")) .. ").+") ~= nil then
            searchName = string.match(text, string.lower(GRM.L("Search")) .. "(.+)");

        elseif string.match(text, "(Search).+") ~= nil then
            searchName = string.match(text, "(Search).+");

        end

        if searchName then

            if GRM_UI.GRM_RosterFrame and GRM_UI.GRM_RosterFrame:IsVisible() then

            elseif GRM_UI.GRM_CoreFrame.GRM_AuditFrame:IsVisible() then
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_PlayerSearchAuditEditBox:SetText(GRM.Util.Trim(searchName));
                GRM.RefreshAuditFrames(false, false, GRM.Util.Trim(searchName));
            else
                GRM_R.LoadRosterFrame();
                GRM_UI.GRM_RosterFrame.GRM_PlayerSearchRosterEditBox:SetText(GRM.Util.Trim(searchName));
            end
        end
    else
        GRM.Report(GRM.L("One moment, GRM is still being configured."));
    end
end

-- Method:          GRM.SlashCommandAltLimitAudit ( int )
-- What it Does:    Triggers an audit of all alt groups to see which exceed the
--                  specified limit passed in the command
-- Purpose:         To help guild leaders of mega guilds manage alt groups better by
GRM.SlashCommandAltLimitAudit = function( input )
    local limit = string.match ( input , "altlimit (%d+)" ) or string.match ( input , GRM.L("altlimit" ) .. " (%d+)" );
    if limit then
        GRM_API.ReportAltGroupsOverLimit ( tonumber ( limit ) );
    else
        GRM.Report(GRM.L("Please specify a number limit after the altlimit command."));
    end
end

-- Method:          GRM.InitiateConfirmFrame ( string , function , string , string , function , bool , int , int )
-- What it Does:    Configures the generic popup window for confirmation of an action
-- Purpose:         Repeat use of the popup window without needing to keep copying and pasting the configuration window.
GRM.InitiateConfirmFrame = function(InfoText, buttonFunction, button1Text, button2Text, cancelButtonFunction,
    disableCloseFunctionOnHide, width, height , scaleButton )

    local w = width or 275;
    local h = height or 120;
    local buttonWidthDefault = 70
    local b1Width = 0;
    local b2Width = 0;

    GRM_UI.GRM_RosterConfirmFrame:SetSize(w, h);
    GRM_UI.GRM_RosterConfirmFrameText:SetWidth(GRM_UI.GRM_RosterConfirmFrame:GetWidth() - 20);

    -- Configure info text
    if InfoText ~= nil and InfoText ~= "" then
        GRM_UI.GRM_RosterConfirmFrameText:SetText(InfoText);
    else
        GRM_UI.GRM_RosterConfirmFrameText:SetText("");
    end
    -- Yes Button
    if button1Text ~= nil and button1Text ~= "" then
        GRM_UI.GRM_RosterConfirmYesButtonText:SetText(button1Text);
        if scaleButton then
            b1Width = GRM_UI_Util.ScaleButtonToFontStringSize ( GRM_UI.GRM_RosterConfirmYesButton , GRM_UI.GRM_RosterConfirmYesButtonText , 4 );
        end
    else
        GRM_UI.GRM_RosterConfirmYesButtonText:SetText(GRM.L("Yes!"));
        GRM_RosterConfirmYesButton:SetWidth ( buttonWidthDefault );
    end
    -- Cancel Button
    if button2Text ~= nil and button2Text ~= "" then
        GRM_UI.GRM_RosterConfirmCancelButtonText:SetText(button2Text);
        if scaleButton then
            b2Width = GRM_UI_Util.ScaleButtonToFontStringSize ( GRM_UI.GRM_RosterConfirmCancelButton , GRM_UI.GRM_RosterConfirmCancelButtonText , 4 );
        end
    else
        GRM_UI.GRM_RosterConfirmCancelButtonText:SetText(GRM.L("Cancel"));
        GRM_RosterConfirmCancelButton:SetWidth ( buttonWidthDefault );
    end

    -- Normalize button widths to be biggest
    if b1Width ~= b2Width then
        if b1Width > b2Width then
            GRM_UI.GRM_RosterConfirmCancelButton:SetWidth ( b1Width );
        else
            GRM_UI.GRM_RosterConfirmYesButton:SetWidth ( b2Width );
        end
    end

    GRM_UI.GRM_RosterConfirmYesButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            if buttonFunction ~= nil then
                buttonFunction();
                GRM_UI.GRM_RosterConfirmFrame:Hide();
            else
                GRM.Report(GRM.L("No Action Configured"));
            end
        end
    end);

    -- If custom logic on cancel as well
    if cancelButtonFunction then
        GRM_UI.GRM_RosterConfirmCancelButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                GRM_UI.GRM_RosterConfirmFrame:Hide();
                cancelButtonFunction();
            end
        end);
        GRM_UI.GRM_RosterConfirmFrame:SetScript("OnHide", function()
            if not disableCloseFunctionOnHide then
                cancelButtonFunction();
            end
        end);

        -- or just the default actions
    else
        GRM_UI.GRM_RosterConfirmCancelButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                GRM_UI.GRM_RosterConfirmFrame:Hide();
            end
        end);
        GRM_UI.GRM_RosterConfirmFrame:SetScript("OnHide", nil);
    end

    GRM_UI.GRM_RosterConfirmFrame:Show();
end

-- Method:          GRM.OpenCoreWindow ( bool )
-- What it Does:    Opens the Core Window
-- Purpose:         Reusable window to open the roster.
GRM.OpenCoreWindow = function(isGeneric)
    local openExport = false;

    if IsInGuild() then

        if not isGeneric and GRM_UI.GRM_CoreFrame:IsVisible() then
            openExport = true; -- Window is visible, we are going to open the export window

        else
            GRM.MinimapGRM.MainWindowOpenLogic();
        end

    else
        GRM.Report(GRM.L("{name} is not currently in a guild. Unable to Proceed!", GRM.SlimName(GRM_G.addonUser)));
    end

    return openExport;
end

-- SLASH COMMAND LOGIC
GRM.SlashCommandRosterActions = function ( slashCommand )
    SlashCmdList[slashCommand] = function(input)

        local isAlreadyReported = false;

        if input == nil or input:trim() == "" then
            GRM_R.LoadRosterFrame();
        else
            isAlreadyReported = true;
            GRM.Report(GRM.L("Invalid Command: Please type '/grm help' for More Info!"));
        end

        if not IsInGuild() and not isAlreadyReported then
            GRM.Report(GRM.L("{name} is not currently in a guild. Unable to Proceed!", GRM.SlimName(GRM_G.addonUser)));
        end

    end
end

-- SLASH COMMAND LOGIC
GRM.SlashCommandActions = function( slashCommand )
    SlashCmdList[slashCommand] = function(input)
        -- if input is invalid or is just a blank info... print details on addon.
        local command;
        local alreadyReported = false;
        local inGuild = IsInGuild();
        if input ~= nil and string.lower(input) ~= nil then -- and string.find ( input , "forcepurge" , 1 , true ) == nil then  -- purge data may have name after, don't want to lowercase that
            command = string.lower(input);
        end

        if input == nil or input:trim() == "" then
            GRM.OpenCoreWindow(true);

            -- Clears all saved data and resets to as if the addon was just installed. The only thing not reset is the default settings.
        elseif command == "clearall" or command == "resetall" or command == GRM.L("clearall") then
            alreadyReported = true;
            GRM.SlashCommandClearAll();

            -- Clears all saved data specific to the guild...
        elseif command == "clearguild" or command == "resetguild" or command == GRM.L("clearguild") then
            if inGuild then
                GRM.SlashCommandClearGuild();
            end

            -- Does a hard reset of the entire database...
        elseif command == "hardreset" or command == GRM.L("hardreset") then
            GRM.HardReset();
            -- List of all the slash commands at player's disposal.
        elseif command == "help" or command == GRM.L("help") then
            alreadyReported = true;
            GRM.SlashCommandHelp();

            -- Version
        elseif command == "version" or command == "ver" or command == GRM.L("version") then
            alreadyReported = true;
            GRM.SlashCommandVersion();

            -- Resets the poisition of the window back to the center.
        elseif command == "reset" or command == "center" or command == GRM.L("center") then
            alreadyReported = true;
            GRM.SlashCommandCenter();

            -- Re-triggering SYNC
        elseif command == "sync" or command == GRM.L("sync") then
            if inGuild then
                GRM.SlashCommandSync()
            end

            -- For manual scan trigger!
        elseif command == "scan" or command == GRM.L("scan") then
            if inGuild then
                GRM.SlashCommandScan();
            end

            -- for resetting the minimap
        elseif command == "minimap" or command == GRM.L("minimap") then
            alreadyReported = true
            GRM.SlashCommandMinimapReset();

        elseif command == "ban" or command == GRM.L("ban") then
            GRM.SlashCommandBan();

        elseif command == "audit" or command == GRM.L("audit") then
            GRM.SlashCommandAudit();

        elseif command == "log" or command == GRM.L("log") then
            GRM.SlashCommandLog();

        elseif command == "kick" or command == GRM.L("kick") or command == "tool" or command == string.lower(GRM.L("Tool")) or
            command == "promote" or command == string.lower(GRM.L("Promote")) or command == "demote" or command ==
            string.lower(GRM.L("Demote")) or command == "macro" or command == string.lower(GRM.L("Macro")) or command ==
            "special" or command == string.lower(GRM.L("Special")) then
            GRM.SlashCommandKick();

        elseif command == "users" or command == "syncusers" or command == GRM.L("users") or command == GRM.L("syncusers") then
            GRM.SlashCommandUsers();

        elseif command == "event" or command == "events" or command == GRM.L("event") or command == GRM.L("events") then
            GRM.SlashCommandEvents();

        elseif command == "opt" or command == "option" or command == "options" or command == GRM.L("opt") or command ==
            GRM.L("option") or command == GRM.L("options") then
            GRM.SlashCommandOptions();

        elseif command == "export" or command == string.lower(GRM.L("Export")) then
            GRM.SlashCommandExport();

        elseif command == "module" or command == string.lower(GRM.L("Module")) or command == "plugin" or command ==
            string.lower(GRM.L("Plugin")) then
            GRM.SlashCommandModulesOptions();

        elseif command == "dead" or command == string.lower(GRM.L("dead")) or command == "deadnames" or command ==
            string.lower(GRM.L("deadnames")) then
            local customKickList = GRM.Scan.CheckForDeadAccounts(true);
            GRM.Report(GRM.L("Dead player accounts found: {num}", nil, nil, #customKickList));
            if not CanGuildRemove() then
                for i = 1, #customKickList do
                    GRM.Report(GRM.GetClassifiedName(customKickList[i].name,false));
                end
            end

            -- FOR FUN!!!
        elseif command == "hello" or command == "sexy" then
            alreadyReported = true;
            GRM.Report("Arkaan is SEXY! Mmmm Arkaan! Super, ridiculously hot addon dev!");

        elseif command == "guid" then
            GRM.SlashCommandGUID();

        elseif command == "prof" or command == string.lower ( GRM.L ( "Prof" ) ) then
            GRM.SlashCommandProf();

        elseif input:find( "altlimit" ) or input:find ( string.lower ( GRM.L ( "altlimit" ) ) ) then
            GRM.SlashCommandAltLimitAudit(input);

            -- /grm search
        elseif string.match(command, "(" .. string.lower(GRM.L("Search")) .. ").+") ~= nil or
            string.match(command, "(Search).+") ~= nil or command == string.lower(GRM.L("Search")) or command == "Search" then
            GRM.SlashCommandSearch(command)

        elseif string.find(command, "debug") ~= nil then
            GRM.Debug.DebugConfig(command);            

        else
            alreadyReported = true;
            GRM.Report(GRM.L("Invalid Command: Please type '/grm help' for More Info!"));
        end

        if not inGuild and not alreadyReported then
            GRM.Report(GRM.L("{name} is not currently in a guild. Unable to Proceed!", GRM.SlimName(GRM_G.addonUser)));
        end
    end
end

GRM.SlashCommandRosterActions("ROSTER");
GRM.SlashCommandActions("GRM");