local Global = {};
GRM.Global = Global;

GRM_G.GuildInfoNeedsChangeNotification = false;

-- Method:          Global.ModifySpecificGuildControlValue ( int , string )
-- What it Does:    Modifies the position of the guild Control and returns the string
-- Purpose:         Easy modification of the string.
Global.ModifySpecificGuildControlValue = function(position, newValue)
    local rules = Global.GetRulesString(GRM.G_Util.GetGuildInfoText());
    local result = "";

    if rules then
        local parts = { strsplit(";", rules) }
        
        -- Ensure backward compatibility padding in case it's a malformed string
        while #parts < 10 do
            table.insert(parts, "X")
        end

        parts[position] = tostring(newValue)
        result = table.concat(parts, ";")
    end

    return result;
end

-- Method:          Global.UpdateGuildInfoWithNewValue ( int , string, bool )
-- What it Does:    Modifies the control values then inserts them into the guildInfo over the original GRM controls, effectively replacing them
-- Purpose:         Ease of controls of global GRM controls for the addon user.
Global.UpdateGuildInfoWithNewValue = function(controlIndex, newValue, isMyEdit )
    if CanEditGuildInfo() and isMyEdit then
        local guildInfoText , isRestricted = GRM.G_Util.GetGuildInfoText();

        if isRestricted then
            GRM.Report(GRM.L("Addon currently restricted by the server from reading Guild Info. Please adjust the settings when addon is not restricted to update global controls."));
        else
            -- Need to reset and hide this.
            if GRM_UI.GRM_CustomPopupFrame:IsVisible() then
                GRM_UI.GRM_CustomPopupFrame:Hide();
            end

            local rulesString = Global.GetRulesString(GRM.G_Util.GetGuildInfoText());

            if rulesString ~= nil then
                local first, last = string.find(guildInfoText, rulesString, 1, true);

                if first and last then
                    local text = "grm^" .. Global.ModifySpecificGuildControlValue(controlIndex, tostring(newValue)) .. "^g";

                    local onCloseFunction = function()
                        GRM.Report(GRM.L("Complete") .. " - " .. GRM.L("It may take up to 60 seconds for other guild members to detect the changes and update."));
                        C_Timer.After(30, function()
                            -- The delay needs to be here as sometimes the note, while update on your end, takes about 10 seconds or less to get a callback that the server properly updated it.
                            GRMsync.SendMessage("GRM_GCHAT", "GINFOUPDATE?", "GUILD"); -- Send out to force others to update their permissions
                            Global.UpdateGuildLeaderPermissions(true, true);
                        end);
                    end
                    GRM.InitiateEditBoxPopup( text , GRM.L("Copy this text anywhere into the Guild Info window (preferably the end).") , onCloseFunction );
                end
            end
        end
    end
end

-- Method:          Global.GetRulesString( string)
-- What it Does:    Pulls the rules from the guild Info note
-- Purpose:         To clear the guildInfo and clean it up for expanded  global controls.
Global.GetRulesString = function( guildInfoText )
    return string.match(guildInfoText, "grm^(.+)^g");
end

-- Method:          Global.GetEachGlobalControl( string )
-- What it Does:    Returns the parsed string based on the pattern match
-- Purpose:         Faster and cleaer code for parsing the global controls
Global.GetEachGlobalControl = function(rulesString)
    if rulesString then
        -- Returned to normal, just checking for 10
        GRM_G.MatchPatternCust10 = GRM_G.MatchPatternCust10 or GRM.BuildComPattern(10, ";", false);
        return string.match(rulesString, GRM_G.MatchPatternCust10);
    else
        return nil;
    end
end

-- Method:          Global.GetGlobalControlValue ( int )
-- What it Does:    Returns the Global control value from the guildInfo global string
-- Purpose:         Easily pull values from the parsed note.
Global.GetGlobalControlValue = function(index)
    local guildInfoText = GRM.G_Util.GetGuildInfoText();
    local rulesString = Global.GetRulesString(guildInfoText);
    local result;

    if rulesString ~= nil and rulesString ~= "" then
        result = select(index, Global.GetEachGlobalControl(rulesString));
    end
 
    -- Error protection
    if rulesString == "" then
        result = true;
    end

    return result;
end

-- Method:          Global.UpdateGuildLeaderPermissions( bool , bool )
-- What it Does:    Scans the guild leader note for special tags and controls, pushes them to addon player setting - Rechecks every 60 seconds...
-- Purpose:         So the guild leader can mass enable/disable certain features in the addon.
Global.UpdateGuildLeaderPermissions = function(isMyEdit, forced)
    local notes, isRestricted = GRM.G_Util.GetGuildInfoText();

    if not isRestricted and IsInGuild() and GRM_G.GuildInfo ~= notes and GRM.S() then
        if notes ~= nil and #notes > 0 then

            if not GRM_G.tagFormatChangeNotice then
                GRM_G.tagFormatChangeNotice = true;

                if CanEditGuildInfo() and string.find(notes, "grm^", 1, true) == nil and
                    (string.find(notes, "g1^", 1, true) ~= nil or string.find(notes, "g2^", 1, true) ~= nil) then
                    GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("A new format exists for global settings controls.") ..
                                   "\n" .. GRM.L("Go to GRM window > Options > Officer Tab > \"Set Global Controls\"") ..
                                   "\n" .. GRM.L(
                        "Remove the old format when all guildies have updated properly. You may wish to leave it in Guild Info until then."));
                end

            end

            local rulesString = Global.GetRulesString(GRM.G_Util.GetGuildInfoText());

            if rulesString then
                local timeFormat, generalSync, banSync, customSync, joinDateLocation, enableUsingTags, joinTag,
                    rejoinTag, noteTrigger, profSync = Global.GetEachGlobalControl(rulesString);

                -- Timestamp format
                Global.SetTimestampRestriction(timeFormat, isMyEdit);

                -- Rank restriction control!
                Global.SetLeaderRankRestrictionSetting(generalSync, isMyEdit);

                -- Ban Restriction control
                Global.SetLeaderBanRestrictionSetting(banSync, isMyEdit);

                -- Custom Note Restriction Control
                Global.SetLeaderCustomNoteRestrictionSetting(customSync, isMyEdit);

                -- Join Date destiation Control
                Global.SetLeaderJoinDateRestrictionSetting(joinDateLocation, isMyEdit);

                -- Use join/Rejoin headers
                Global.SetLeaderUsingJoinTagHeaders(enableUsingTags, isMyEdit);

                -- Tag Formatting
                Global.SetJoinTagCustomFormat(joinTag, rejoinTag, isMyEdit);

                -- !Note enabled controls
                Global.SetNoteTriggerRestrictions(noteTrigger);
                
                -- Profession restrictions (Classic Only)
                Global.SetLeaderProfessionRestrictionSetting(profSync, isMyEdit);

            end
            GRM_G.GuildInfo = notes;
        end
        
        if GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
            GRM_UI.BuildLogFrames()
        end
    end
    if not forced then
        -- Just check once per 30 minutes as it will check at start of session and you SHOULD get a message of change.
        -- Message may not come through immediately though if addon to addon comms temporarily restricted.
        C_Timer.After(1800, function()      
            if IsInGuild() and GRM.S() then
                Global.UpdateGuildLeaderPermissions(false, false);
            end
        end);
    end
end

-- Method:          Global.SetJoinTagCustomFormat ( string , string , bool )
-- What it Does:    Checks for the number after the given match, and forces the player to adhere to those setting...
-- Purpose:         Conformity within the guild in the settings.
Global.SetJoinTagCustomFormat = function(customJoin, customRejoin, isMyEdit)
    -- first, very it is not nil
    local needsRefresh = false;

    -- DEFAULTS
    if customJoin == "XX" then
        customJoin = GRM.L("Joined:");
    end
    if customRejoin == "XX" then
        customRejoin = GRM.L("Rejoined:");
    end

    -- Custom JOIN
    if customJoin ~= "X" and customJoin ~= GRM.S().customTags[1] and GRM.S().includeTag then

        -- Cannot be greater than Max Characters (16) characters
        if #customJoin >
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagJoinEditBox:GetMaxLetters() then
            if isMyEdit then
                GRM.Report(GRM.L(
                    "Custom Join Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}.",
                    customJoin, nil, #customJoin, GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                        .GRM_OfficerOptionsFrame.GRM_CustomTagJoinEditBox:GetMaxLetters()));
            end
        else
            local finalReport = "";
            if isMyEdit or CanEditGuildInfo() then
                if #GRM.S().customTags[1] > 0 then
                    finalReport = GRM.L("Custom Join Tag has been changed from \"{name}\" to \"{name2}\"",
                        GRM.S().customTags[1], customJoin);
                else
                    finalReport = GRM.L("Custom Join Tag has been set to \"{name}\"", customJoin);
                end
            else
                if #GRM.S().customTags[1] > 0 then
                    finalReport = GRM.L(
                        "Your Guild Leader has changed the Custom Join Tag from \"{name}\" to \"{name2}\"",
                        GRM.S().customTags[1], customJoin);
                else
                    finalReport = GRM.L("Your Guild Leader has set the Custom Join Tag to \"{name}\"", customJoin);
                end
            end
            GRM.Report(GRM.L("GRM:") .. " " .. finalReport);
            GRM.S().customTags[1] = customJoin;

            if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagJoinEditBox:IsVisible() then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagJoinEditBox:SetText(
                    GRM.S().customTags[1]);
            end
            needsRefresh = true;
        end
    end

    -- Custom REJOIN
    if customRejoin ~= "X" and customRejoin ~= GRM.S().customTags[2] then

        -- Cannot be greater than Max Characters (16) characters
        if #customRejoin >
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagREJoinEditBox:GetMaxLetters() then
            if isMyEdit then
                GRM.Report(GRM.L(
                    "Custom Rejoin Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}.",
                    customRejoin, nil, #customRejoin, GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                        .GRM_OfficerOptionsFrame.GRM_CustomTagREJoinEditBox:GetMaxLetters()));
            end
        else
            local finalReport = "";
            if isMyEdit or CanEditGuildInfo() then
                if #GRM.S().customTags[2] > 0 then
                    finalReport = GRM.L("Custom Rejoin Tag has been changed from \"{name}\" to \"{name2}\"",
                        GRM.S().customTags[2], customRejoin);
                else
                    finalReport = GRM.L("Custom Rejoin Tag has been set to \"{name}\"", customRejoin);
                end
            else
                if #GRM.S().customTags[2] > 0 then
                    finalReport = GRM.L(
                        "Your Guild Leader has changed the Custom Rejoin Tag from \"{name}\" to \"{name2}\"",
                        GRM.S().customTags[2], customRejoin);
                else
                    finalReport = GRM.L("Your Guild Leader has set the Custom Rejoin Tag to \"{name}\"", customRejoin);
                end
            end
            GRM.Report(GRM.L("GRM:") .. " " .. finalReport);

            GRM.S().customTags[2] = customRejoin;
            if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagREJoinEditBox:IsVisible() then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagREJoinEditBox:SetText(
                    customRejoin);
            end
            needsRefresh = true;
        end
    end

    if needsRefresh then
        GRM.SetJoinAndRejoinTags();
    end
end

-- Method:          Global.SetNoteTriggerRestrictions ( string )
-- What it Does:    Checks the Guildinfo tag if settings need to be adjusted and modify the settings if they do.
-- Purpose:         Allow global control in enforcing all officers use this function.
Global.SetNoteTriggerRestrictions = function(noteTrigger)
    noteTrigger = tonumber(noteTrigger);
    -- first, very it is not nil
    if noteTrigger ~= nil and noteTrigger < 3 then

        if GRM_G.BuildHasRestrictions and noteTrigger == 1 then
            GRM_G.GlobalControl7 = false;
            needsRefresh = false;
            GRM.S().noteSetEnabled = false;
            if not GRM_G.GuildInfoNeedsChangeNotification and CanEditGuildInfo() then
                GRM_G.GuildInfoNeedsChangeNotification = true;
                GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("The Global Control string in your guild info needs to be updated. GRM no longer has the ability to do it. Please type /grm and go to the Options and Officer tab to re-obtain a new control text string to manually copy over."))
            end
            return
        end

        if not CanEditGuildInfo() then
            GRM_G.GlobalControl7 = true;
        end

        local needsRefresh = false;

        if noteTrigger == 1 and not GRM.S().noteSetEnabled then
            GRM.S().noteSetEnabled = true;
            GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("'!note' trigger has been globally ENABLED"));
            needsRefresh = true;

        elseif noteTrigger == 2 and GRM.S().noteSetEnabled then
            GRM.S().noteSetEnabled = false;
            GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("'!note' trigger has been globally DISABLED"));
            needsRefresh = true
        end

        if needsRefresh then
            -- Update the frames if necessary
            if GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                if GRM.S().noteSetEnabled then
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame
                        .GRM_NoteTagFeatureCheckButton:SetChecked(true);
                else
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame
                        .GRM_NoteTagFeatureCheckButton:SetChecked(false);
                end
            end
        end

    else
        -- Not valid, disable it.
        GRM_G.GlobalControl7 = false;
    end
end

-- NEW Method:      Global.SetLeaderProfessionRestrictionSetting ( string , bool )
-- What it Does:    Checks for the profession configuration and enforces it on users
-- Purpose:         Conformity and unification of addon settings.
Global.SetLeaderProfessionRestrictionSetting = function(profSync, isMyEdit)
    -- This feature does not apply to retail (Build 10.0+ / 100000+)
    -- if GRM_G.BuildVersion >= 100000 then
    --     return
    -- end

    profSync = tonumber(profSync);

    if profSync ~= nil then
        if not CanEditGuildInfo() then
            GRM_G.GlobalControl10 = true;
        end

        -- Ensure value is within correct rage or set to default
        if profSync < 0 or profSync > 4 then
            profSync = 0;
        end

        local needsRefresh = false;
        local isFullyDisabled = (profSync == 0);
        local isAutoUpdate = (profSync >= 1 and profSync <= 4);
        local destination = (profSync < 4 and profSync) or GRM.S().ProfNoteDestination; -- fallback in case malformed

        -- We check for a new variable ProfFullyDisabled
        if GRM.S().ProfFullyDisabled ~= isFullyDisabled then
            GRM.S().ProfFullyDisabled = isFullyDisabled;
            needsRefresh = true;
        end

        -- Auto Update state change
        if GRM.S().ProfRankAutoUpdate ~= isAutoUpdate then
            GRM.S().ProfRankAutoUpdate = isAutoUpdate;
            needsRefresh = true;
        end

        -- Destination change
        if isAutoUpdate and GRM.S().ProfNoteDestination ~= destination then
            GRM.S().ProfNoteDestination = destination;
            needsRefresh = true;
        end

        if needsRefresh then
            Global.UpdateGuildInfoWithNewValue(10, profSync, isMyEdit);

            local finalReport = "";
            local locations = {"Public Note", "Officer Note", "Custom Note"};

            if isMyEdit or CanEditGuildInfo() then
                if isFullyDisabled then
                    finalReport = GRM.L("Profession feature has been globally set to FULLY DISABLED.");
                elseif not isAutoUpdate then
                    finalReport = GRM.L("Profession auto-updating has been globally DISABLED.");
                else
                    finalReport = GRM.L("Profession auto-updating globally changed to be added to the {name}", GRM.L(locations[destination]));
                end
            else
                if isFullyDisabled then
                    finalReport = GRM.L("Your Guild Leadership has globally set the Profession feature to FULLY DISABLED.");
                elseif not isAutoUpdate then
                    finalReport = GRM.L("Your Guild Leadership has globally DISABLED Profession auto-updating.");
                else
                    finalReport = GRM.L("Your Guild Leadership has globally set Profession auto-updating to the {name}", GRM.L(locations[destination]));
                end
            end
            
            GRM.Report(GRM.L("GRM:") .. " " .. finalReport);

            if GRM_UI.GRM_RosterChangeLogFrame and GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                GRM_UI.ConfigureClassicProfessionOptions( not GRM.S().ProfFullyDisabled );
            end
        end

    else
        GRM_G.GlobalControl10 = false;
    end
end


-- Method:          Global.IsCustomJoinRestricted()
-- What it Does:    Returns true if the guild Info has the custom join tag note set properly to a custom
-- Purpose:         Prevent players from making editing changes
Global.IsCustomJoinRestricted = function()
    local result = false;
    local customJoin = Global.GetGlobalControlValue(7);

    if customJoin ~= nil then
        if customJoin == "XX" or #customJoin <=
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagJoinEditBox:GetMaxLetters() then
            result = true;
        end
    end

    return result, customJoin;
end

-- Method:          Global.IsCustomReJoinRestricted()
-- What it Does:    Returns true if the custom Rejoin is restricted globally using the guild info note
-- Purpose:         Prevent players from changing their settings if it is already restricted in the guild info note
Global.IsCustomReJoinRestricted = function()
    local result = false;
    local customReJoin = Global.GetGlobalControlValue(8);

    if customReJoin ~= nil then

        if customReJoin == "XX" or #customReJoin <=
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_CustomTagREJoinEditBox:GetMaxLetters() then
            result = true;
        end
    end

    return result, customReJoin;
end

-- Method:          Global.SetTimestampRestriction ( string , bool )
-- What it Does:    Checks for the number after the given match, and forces the player to adhere to those setting...
-- Purpose:         Conformity within the guild in the settings.
Global.SetTimestampRestriction = function(timeFormatIndex, isMyEdit)

    -- Let's first verify it is not nil as any player could put anything there, no need to throw errors out there constantly due to bad formatting.
    if tonumber(timeFormatIndex) ~= nil then
        timeFormatIndex = tonumber(timeFormatIndex);
    else
        GRM_G.GlobalControl5 = false;
        return;
    end

    if not CanEditGuildInfo() then
        GRM_G.GlobalControl5 = true;
    end

    if timeFormatIndex > 17 then
        timeFormatIndex = 17
    end

    -- Now, we check to see if yours matches it or not. If it doesn't, you need to change it.
    if timeFormatIndex ~= GRM.S().globalDateFormat then

        GRM.S().globalDateFormat = timeFormatIndex;
        Global.UpdateGuildInfoWithNewValue(1, timeFormatIndex , isMyEdit);

        local finalReport = "";
        local month, day, year = select(2, GRM.Time.GetTodaysDate());
        local timestamp = GRM.Time.FormatTimeStamp({day, month, year}, false, false, GRM.S().globalDateFormat);

        if isMyEdit or CanEditGuildInfo() then
            finalReport = GRM.L("Timestamp Formatting has been Globally Set to: < {name} >", timestamp);
        else
            finalReport = GRM.L("Your Guild Leader Has Globally Set the Timestamp Formatting to: < {name} >", timestamp);
        end
        GRM.Report(GRM.L("GRM:") .. " " .. finalReport);

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:IsVisible() then
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected
                .GRM_TimestampSelectedText:SetText(timestamp);
        end
    end
end

-- Method:          Global.SetLeaderRankRestrictionSetting ( string , bool )
-- What it Does:    Checks for the number after the given match, and forces the player to adhere to those setting...
-- Purpose:         Conformity within the guild in the settings.
Global.SetLeaderRankRestrictionSetting = function(generalSyncIndex, isMyEdit)

    generalSyncIndex = tonumber(generalSyncIndex);
    if generalSyncIndex ~= nil then

        if not CanEditGuildInfo() then
            GRM_G.GlobalControl1 = true;
        end

        -- Now, we need to verify it is a valid rank number. Note, indexes start at zero, but a general count starts at 1. So number of ranks is 10, while their index is 0-9.
        if generalSyncIndex > GuildControlGetNumRanks() - 1 then
            generalSyncIndex = GuildControlGetNumRanks() - 1;
        end
        -- Now, we check to see if yours matches it or not. If it doesn't, you need to change it.
        if generalSyncIndex ~= GRM.S().syncRank then

            local finalReport = "";
            if isMyEdit or CanEditGuildInfo() then
                finalReport = GRM.L("Sync Restrictions Globally Changed to {name} or Higher",
                    GuildControlGetRankName(generalSyncIndex + 1));
            else
                finalReport = GRM.L("Your Guild Leader Has Set Sync Restrictions to {name} or Higher",
                    GuildControlGetRankName(generalSyncIndex + 1));
            end
            GRM.Report(GRM.L("GRM:") .. " " .. finalReport);

            GRM.S().syncRank = generalSyncIndex;
            if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame:IsVisible() then
                GRM.CreateOptionsRankDropDown();
            end

        end
    else
        GRM_G.GlobalControl1 = false;
    end
end

-- Method:          Global.SetLeaderBanRestrictionSetting ( string , bool )
-- What it Does:    Checks for the number after the given match, and forces the player to adhere to those Ban setting...
-- Purpose:         Conformity within the guild in the settings.
Global.SetLeaderBanRestrictionSetting = function(banSync, isMyEdit)
    banSync = tonumber(banSync);

    -- first, very it is not nil
    if banSync ~= nil then

        if not CanEditGuildInfo() then
            GRM_G.GlobalControl2 = true;
        end

        -- Now, we need to verify it is a valid rank number. Note, indexes start at zero, but a general count starts at 1. So number of ranks is 10, while their index is 0-9.
        if banSync > GuildControlGetNumRanks() - 1 then
            banSync = GuildControlGetNumRanks() - 1;
        end
        -- Now, we check to see if yours matches it or not. If it doesn't, you need to change it.
        if banSync ~= GRM.S().syncRankBanList then

            if GRM.S().syncRank < banSync then
                GRM.S().syncRankBanList = GRM.S().syncRank;
                Global.UpdateGuildInfoWithNewValue(3, GRM.S().syncRank, isMyEdit)

                GRM.Report(GRM.L("Warning! Unable to select a Ban List rank below \"{name}\"",
                    GuildControlGetRankName(GRM.S().syncRankBanList + 1)) .. "\n" ..
                               GRM.L("Setting to match core filter rank"));

            else
                GRM.S().syncRankBanList = banSync;

                Global.UpdateGuildInfoWithNewValue(3, banSync, isMyEdit)

                local finalReport = "";
                if isMyEdit or CanEditGuildInfo() then
                    finalReport = GRM.L("BAN Sync Restrictions Globally Changed to {name} or Higher",
                        GuildControlGetRankName(banSync + 1));
                else
                    finalReport = GRM.L("Your Guild Leader Has Set BAN Sync Restrictions to {name} or Higher",
                        GuildControlGetRankName(banSync + 1));
                end
                GRM.Report(GRM.L("GRM:") .. " " .. finalReport);

                if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame:IsVisible() then
                    GRM.CreateOptionsRankDropDown();
                end
            end
        end
    else
        GRM_G.GlobalControl2 = false;
    end
end

-- Method:          Global.SetLeaderCustomNoteRestrictionSetting ( string , bool )
-- What it Does:    Checks for the number after the given match, and forces the player to adhere to those Ban setting...
-- Purpose:         Conformity within the guild in the settings.
Global.SetLeaderCustomNoteRestrictionSetting = function(customSyncIndex, isMyEdit)
    customSyncIndex = tonumber(customSyncIndex);

    -- first, very it is not nil
    if customSyncIndex ~= nil then

        if not CanEditGuildInfo() then
            GRM_G.GlobalControl3 = true;
        end

        -- Now, we need to verify it is a valid rank number. Note, indexes start at zero, but a general count starts at 1. So number of ranks is 10, while their index is 0-9.
        if customSyncIndex > GuildControlGetNumRanks() - 1 then
            customSyncIndex = GuildControlGetNumRanks() - 1;
        end

        -- Now, we check to see if yours matches it or not. If it doesn't, you need to change it.
        if customSyncIndex ~= GRM.S().syncRankCustom then
            GRM.S().syncRankCustom = customSyncIndex;

            local finalReport = "";
            if isMyEdit or CanEditGuildInfo() then
                finalReport = GRM.L("CUSTOM NOTE Sync Restrictions Globally Changed to {name} or Higher",
                    GuildControlGetRankName(customSyncIndex + 1));
            else
                finalReport = GRM.L("Your Guild Leader Has Set CUSTOM NOTE Sync Restrictions to {name} or Higher",
                    GuildControlGetRankName(customSyncIndex + 1));
            end
            GRM.Report(GRM.L("GRM:") .. " " .. finalReport);

            if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame:IsVisible() then
                GRM.CreateOptionsRankDropDown();
            end
        end
    else
        GRM_G.GlobalControl3 = false;
    end
end

-- Method:          Global.SetLeaderJoinDateRestrictionSetting ( int , bool )
-- What it Does:    Checks for the number after the given match and forces all players to adhere to that setting.
-- Purpose:         Conformity and unification of addon settings and to prevent multiple people from adding join date to multiple locations.
Global.SetLeaderJoinDateRestrictionSetting = function(joinDateLocationIndex, isMyEdit)
    joinDateLocationIndex = tonumber(joinDateLocationIndex);

    -- first, very it is not nil
    if joinDateLocationIndex ~= nil then

        if not CanEditGuildInfo() then
            GRM_G.GlobalControl4 = true;
        end

        -- Confirming it is GL controlled
        local location = {"Officer Note", "Public Note", "Custom Note"};
        local needsRefresh = false;

        if joinDateLocationIndex > 3 or joinDateLocationIndex < 0 then

            GRM.S().joinDateDestination = 1;
            GRM.S().addTimestampToNote = true;
            joinDateLocationIndex = 1;
            Global.UpdateGuildInfoWithNewValue(5, joinDateLocationIndex, isMyEdit);

            -- Update guildinfo...
            GRM.Report(GRM.L(
                "Setting join date to destination index {num} is not valid. Value must be between 0 and 3. Setting to default of Officer Note.",
                nil, nil, joinDateLocationIndex));

            needsRefresh = true;

        end

        -- Disabled = 0, Officer Note = 1, Public Note = 2 , custom = 3
        if joinDateLocationIndex ~= GRM.S().joinDateDestination then
            GRM.S().joinDateDestination = joinDateLocationIndex;
            Global.UpdateGuildInfoWithNewValue(5, joinDateLocationIndex, isMyEdit);

            if joinDateLocationIndex == 0 then
                if GRM.S().addTimestampToNote then
                    GRM.S().addTimestampToNote = false
                end
            else
                GRM.S().addTimestampToNote = true;
            end
            needsRefresh = true;
        end

        if needsRefresh then
            local finalReport = "";
            if isMyEdit or CanEditGuildInfo() then
                if joinDateLocationIndex == 0 then
                    finalReport = GRM.L(
                        "Join Dates Globally Changed to no longer be added to the note when a player joins the guild");
                else
                    finalReport = GRM.L("Join Dates Globally Changed to only be added to the {name}",
                        location[joinDateLocationIndex]);
                end
            else
                if joinDateLocationIndex == 0 then
                    finalReport = GRM.L("Your Guild Leader has disabled adding join dates to player notes");
                else
                    finalReport = GRM.L("Your Guild Leader Has Set Join Dates to only be added to the {name}",
                        location[joinDateLocationIndex]);
                end
            end
            GRM.Report(GRM.L("GRM:") .. " " .. finalReport);
        end

        if needsRefresh then
            if GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                GRM_UI.ConfigureJoinDateLocation();
            end
        end

    else
        GRM_G.GlobalControl4 = false;
    end
end

-- Method:          Global.SetLeaderUsingJoinTagHeaders ( string, bool)
-- What it Does:    Checks if including the tag headers should be enabled or disabled
-- Purpose:         To help conformity in the guild on the destination of the notes.
Global.SetLeaderUsingJoinTagHeaders = function(headerControl, isMyEdit)
    if headerControl == "+" or headerControl == "-" then
        local needsRefresh = false;

        if not CanEditGuildInfo() then
            GRM_G.GlobalControl4_5 = true;
        end

        -- + = on, - = off
        if headerControl == "+" and not GRM.S().includeTag then
            GRM.S().includeTag = true;
            GRM.Report(GRM.L(
                "The \"{name}\" and \"{name2}\" tags have globally been set to be added to join date note entries.",
                GRM_G.customHeaderJoin, GRM_G.customHeaderRejoin));
            needsRefresh = true;
        elseif headerControl == "-" and GRM.S().includeTag then
            GRM.S().includeTag = false;
            GRM.Report(GRM.L(
                "The \"{name}\" and \"{name2}\" tags have globally been disabled from adding to join date note entries.",
                GRM_G.customHeaderJoin, GRM_G.customHeaderRejoin));
            needsRefresh = true;
        end

        if needsRefresh then
            if GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                GRM_UI.ConfigureJoinDateLocation();
            end
            Global.UpdateGuildInfoWithNewValue(6, headerControl, isMyEdit);
        end

    else
        GRM_G.GlobalControl4_5 = false;
    end
end

-- Method:          Global.IsSyncRankGuildLeaderRestricted ( int )
-- What it Does:    Returns a boolean if the player's guild leader does have restriction standardization
--                  and returns the rank of that restriction by index.
-- Purpose:         Necessary for UX quality control on various methods to change and manipulate the settings.
Global.IsSyncRankGuildLeaderRestricted = function(selectedIndex)

    local result = false;
    local controlValue = Global.GetGlobalControlValue(selectedIndex);

    if controlValue ~= nil and controlValue ~= "X" then
        result = true;
        local controlVal = tonumber(controlValue);
        if controlVal ~= nil then
            controlValue = controlVal;
        end

        if selectedIndex == 1 then
            if controlValue > 17 or controlValue < 1 then
                controlValue = 1;
            end

        elseif selectedIndex > 1 and selectedIndex < 5 then -- 2 , 3 , 4
            if controlValue > GuildControlGetNumRanks() - 1 then -- Set to lowest if necessary.
                controlValue = GuildControlGetNumRanks() - 1;
            end

        elseif selectedIndex == 5 then
            if controlValue > 3 or controlValue < 0 then
                -- default
                controlValue = 1;
            end

        elseif selectedIndex == 6 then
            if controlValue ~= "+" and controlValue ~= "-" then
                result = false;
            end

        elseif selectedIndex == 9 then
            if controlValue < 1 or controlValue > 2 then
                result = false;
            end
        elseif selectedIndex == 10 then
            if controlValue < 0 or controlValue > 4 then
                result = false;
            end
        end
    end

    return result, controlValue;
end

-- Method:          Global.ReportRankRestriction ( int )
-- What it Does:    Reports restriction rank if you try make a change to sync rank restrictions, yet in the guild info there are values set to control it.
-- Purpose:         Use for reporting any of the sync rank restrictions...
Global.ReportRankRestriction = function(rankIndex)
    if rankIndex ~= nil then
        GRM.Report(GRM.L("GRM:") .. " " ..
                       GRM.L("Unable to Change Rank. Guild Leader has set restriction to {name} or higher",
                GuildControlGetRankName(rankIndex + 1)));
    else
        GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("Unable to Change Rank. Guild Leader has set restriction level."));
    end
end

-- Method:          Global.GetRankRestrictionText ( int )
-- What it Does:    Returns the text of the restriction rank guild leader has set it to for the controlled values in the guild info window
-- Purpose:         To make it obvious for player why they do not have access to sync rank controls.
Global.GetRankRestrictionText = function(rankIndex)
    local result = "";
    if rankIndex ~= nil then
        result = GRM.L("Unable to Change Rank. Guild Leader has set restriction to {name} or higher",
            GuildControlGetRankName(rankIndex + 1));
    else
        result = GRM.L("Unable to Change Rank. Guild Leader has set restriction level.");
    end
    return result;
end

-- Method:          Global.GetGlobalSettingsProgress()
-- What it Does:    Compiles the progress with the global functions
-- Purpose:         For use with creating an export of them.
Global.GetGlobalSettingsProgress = function()
    local guildInfoText = GRM.G_Util.GetGuildInfoText();
    local rulesString = Global.GetRulesString(guildInfoText);
    local result = {};

    if rulesString then
        local guildControl = {Global.GetEachGlobalControl(rulesString)};

        for i = 1, #guildControl do
            if guildControl[i] ~= "X" then
                table.insert(result, {true, guildControl[i]});
            else
                table.insert(result, {false});
            end
        end

    end
    return result;
end

-- Method:          Global.AllGlobalsAreSet()
-- What it Does:    Returns true if all globals are set in the guildInfo properly
-- Purpose:         To help with guild Info global settings and tooltip info for UX
Global.AllGlobalsAreSet = function()
    local result = true;
    local globals = Global.GetGlobalSettingsProgress();

    if #globals > 0 then
        for i = 1, #globals do
            if i < 10 and not globals[i][1] then
                result = false;
                break
            end
        end
    else
        result = false;
    end


    if result then
        local rulesString = Global.GetRulesString(GRM.G_Util.GetGuildInfoText())
        local correctRules = Global.GetAllGlobalRulesAsString(false);

        if rulesString ~= correctRules then
            result = false;
        end

    end

    return result;
end

-- Method:          Global.SetGlobalControlsToGuildInfo()
-- What it Does:    Rebuilds the guild control tags and inserts them back into the guildInfo
-- Purpose:         Give the user the ability to control some specific functions globally.
Global.SetGlobalControlsToGuildInfo = function()
    local notes, isRestricted = GRM.G_Util.GetGuildInfoText();
    if isRestricted then
        GRM.Report(GRM.L("Addon currently restricted by the server from reading Guild Info. Please wait to export the global control text when addon is not restricted."));
        return;
    end
    local controlString = Global.GetAllGlobalRulesAsString( true );
    local existingRules = Global.GetRulesString(notes);
    local result = "";

    if existingRules then
        -- ok rules already there, so we will need to save over them.
        local startIndex, endIndex = string.find(notes, existingRules, 1, true);
        if startIndex ~= nil and endIndex ~= nil then
            result = (string.sub(notes, 1, startIndex - 5) .. controlString .. string.sub(notes, endIndex + 3));
        end
    else
        -- Just append to the end
        result = GRM.Trim(notes) .. "\n" .. controlString;
    end

    -- Ok, let's set the values
    if #result > 0 and GRM_UI.GuildInfoEditBox then
        if #result <= GRM_UI.GuildInfoEditBox:GetMaxLetters() then

            local onCloseFunction = function()
                GRM.Report(GRM.L("Complete") .. " - " .. GRM.L("It may take up to 60 seconds for other guild members to detect the changes and update."));
                C_Timer.After(10, function()
                    -- The delay needs to be here as sometimes the note, while update on your end, takes about 10 seconds or less to get a callback that the server properly updated it.
                    GRMsync.SendMessage("GRM_GCHAT", "GINFOUPDATE?", "GUILD"); -- Send out to force others to update their permissions
                    Global.UpdateGuildLeaderPermissions(true, true);
                end);
            end
            GRM.InitiateEditBoxPopup( controlString , GRM.L("Copy this text anywhere into the Guild Info window (preferably the end).") , onCloseFunction );
        else
            GRM.Report(GRM.L("Unable to add globals controls to GuildInfo. There is not enough room."));
            GRM.Report(GRM.L("You need to clear {num} characters to fit the control tags", nil, nil,
                (#result - GRM_UI.GuildInfoEditBox:GetMaxLetters())));
        end
    end

end

-- Method:          Global.GetAllGlobalRulesAsString( bool )
-- What it Does:    Builds the Globals string for the GuildInfo window
-- Purpose:         Quality of Life to help ease new players into the addon.
Global.GetAllGlobalRulesAsString = function( includeEnds )

    local modifier = "+";
    if not GRM.S().includeTag then
        modifier = "-";
    end

    local customHeader = "^^";
    if GRM.S().customTags[1] == "" or GRM.S().customTags[1] == GRM.L("Joined:") then
        customHeader = "XX";
    else
        customHeader = GRM.S().customTags[1];
    end

    local customRejoinHeader = "";
    if GRM.S().customTags[2] == "" or GRM.S().customTags[2] == GRM.L("Rejoined:") then
        customRejoinHeader = "XX";
    else
        customRejoinHeader = GRM.S().customTags[2];
    end

    local noteEnabled = 1;
    if not GRM.S().noteSetEnabled then
        noteEnabled = 2;
    end

    local profSetting = "X"
    if GRM_G.BuildVersion < 100000 then
        -- We are in Classic, read actual addon states
        if GRM.S().ProfFullyDisabled then
            profSetting = "4"
        elseif not GRM.S().ProfRankAutoUpdate then
            profSetting = "0"
        else
            local defDest = 1;
            if GRM_G.BuildHasRestrictions then
                defDest = 3;
            end
            profSetting = tostring(GRM.S().ProfNoteDestination or defDest);
        end
    else
        -- In retail, preserving existing 11th value in case Classic GL set it, 
        -- otherwise we default to X.
        local existingProf = Global.GetGlobalControlValue(11)
        if existingProf and existingProf ~= "X" then
            profSetting = existingProf
        end
    end

    -- Added profSetting
    local globalRules = (GRM.S().globalDateFormat .. ";" .. GRM.S().syncRank .. ";" .. GRM.S().syncRankBanList .. ";" ..
            GRM.S().syncRankCustom .. ";" .. GRM.S().joinDateDestination .. ";" .. modifier .. ";" .. customHeader ..
            ";" .. customRejoinHeader .. ";" .. noteEnabled .. ";" .. profSetting);

    if includeEnds then
        globalRules = "grm^" .. globalRules .. "^g";
    end


    return globalRules;
end