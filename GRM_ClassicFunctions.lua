
-- CLASSIC Specific functions

-- Method:          GRM.GetParsedNameFromInviteAnnouncementWithoutServer ( string )
-- What it Does:    Parses out the player name from the system message of when a guildie joins the guild
-- Purpose:         In Classic the system message seems to not include the hyphen, so a new function needs to be used to determine the player.
GRM.GetParsedNameFromInviteAnnouncementWithoutServer = function ( text )
    local name = "";
    local index = 0;
    for i = 1 , GRM.GetNumGuildies() do
        name = GetGuildRosterInfo ( i );

        if string.find ( text , GRM.SlimName ( name ) , 1 , true ) ~= nil then      -- if not nil, name of a guildie matches that of the roster.
            -- NAME FOUND... break!
            index = i;
            break;
        end
    end
    return name , index;
end

-- Method:          GRM_UI.DisableFramesForClassic()
-- What it Does:    Disables option checkboxes that don't apply in Classic, but may be updated in the future.
-- Purpose:         Porting GRM to Classic needs to have this consideration for non-existent features, like the calendar, in the original Warcraft release.
GRM_UI.DisableFramesForClassic = function()

    if GRM_G.BuildVersion < 40000 then  -- Not introduced until WOTLK

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_RosterReportAddEventsToCalendarButton:Disable();
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_RosterReportAddEventsToCalendarButtonText:SetTextColor ( 0.5 , 0.5 , 0.5 );

    end
end

-- Method:          GRM.ClearRosterHighlights()
-- What it Does:    Unlocks the highlighted player of the guildRoster if any is selected
-- Purpose:         Needed to unlock the highlights properly so it is not confusing who is selected.
GRM.ClearRosterHighlights = function()
    SetGuildRosterSelection ( 0 );      -- If you do not clear the selection, it will just re-highlight the bar when it updates.\

    if GRM_G.BuildVersion < 80000 and GuildFrame and GuildFrame:IsVisible() then
        if GRM_G.BuildVersion < 40000 then
            for i = 1 , GRM_UI.ContainerButtonCount do
                _G[ "GuildFrameButton" .. i ]:UnlockHighlight();
            end
        elseif GRM_G.BuildVersion < 80000 then
            for i = 1 , GRM_UI.ContainerButtonCount do
                _G[ "GuildRosterContainerButton" .. i ]:UnlockHighlight();
            end
        end
    end
end
