
-- CLASSIC Specific functions

-- Method:          GRM.ClassicCheckForNewMember ( string , int )
-- What it Does:    Live checks when a player joins the guild and reports on it
-- Purpose:         For specific use on Classic. In Retail there is the new, vastly more efficient, community API. Here we aree forced to be somewhat limited.
GRM.ClassicCheckForNewMember = function ( name , scanNumber )
    local rosterName , rank , rankInd , level , zone , note , oNote , classFile , pts , rep , guid , _ ;
    local isFound = false;
    local rosterIndex = 0;

    for i = 1 , GRM.GetNumGuildies() do
        rosterName , rank , rankInd , level , _ , zone , note , oNote , _ , _ , classFile , pts , _ , _ , _ , rep , guid = GetGuildRosterInfo ( i );
        if name == rosterName then
            isFound = true;
            rosterIndex = i;
            break;
        end
    end

    if isFound then           -- This means it shows successfully 1 found player...

        if not GRM_G.liveAddedToons[rosterName] then

            GRM_G.liveAddedToons[rosterName] = {};

            local race , sex;
            if guid ~= "" then
                race , sex = select ( 4 , GetPlayerInfoByGUID ( guid ) );
            end
            if race == nil or sex == nil then
                race , sex = select ( 4 , GetPlayerInfoByGUID ( guid ) );   -- Call a second time... sometimes the server is weird and the first call produces nil, but the immediate 2nd does respond.
                if race == nil or sex == nil then
                    race = "";
                    sex = 1;
                end
            end

            local memberInfoToAdd = {};

            memberInfoToAdd.name = rosterName                                           -- 1
            memberInfoToAdd.rankName = rank;                                            -- 2
            memberInfoToAdd.rankIndex = rankInd;                                        -- 3 (It needs to be 1 less to match when compared to the guildRosterInfo call )
            memberInfoToAdd.level = level;                                              -- 4
            memberInfoToAdd.note = note;                                                -- 5
            if CanViewOfficerNote() then
                memberInfoToAdd.officerNote = oNote;                                    -- 6
            else
                memberInfoToAdd.officerNote = nil; 
            end
            memberInfoToAdd.class = classFile;                                          -- 7
            memberInfoToAdd.lastOnline = 0;                                             -- 8 Time since they last logged in in hours.
            memberInfoToAdd.zone = zone;                                                -- 9
            memberInfoToAdd.achievementPoints = pts;                                    -- 10    
            memberInfoToAdd.isMobile = false;                                           -- 11
            memberInfoToAdd.rep = rep;                                                  -- 12
            memberInfoToAdd.isOnline = true;                                            -- 13
            memberInfoToAdd.status = 0;                                                 -- 14
            memberInfoToAdd.GUID = guid;                                                -- 15
            memberInfoToAdd.race = "";                                                  -- 16
            memberInfoToAdd.sex = 1;                                                    -- 17
            memberInfoToAdd.rosterSelection = rosterIndex;                                        -- 18

            GRM.RecordJoinChanges ( memberInfoToAdd , GRM.GetClassColorRGB ( classFile , true ) .. GRM.SlimName ( name ) .. "|r" , true , select ( 2 , GRM.GetTimestamp() ) , true );

            -- Check Main Auto tagging...
            -- Check Main Auto tagging...
            if not GRM_G.OnFirstLoad then
                GRM.SetGuildInfoDetails();
            end

            -- -- Delay for time to check "Unique Accounts" change...
            C_Timer.After ( 10 , function()               
                if GRM_G.DesignateMain then
                    GRM.SetMain ( name , 1 );
                    GRM.Report ( GRM.L ( "GRM Auto-Detect! {name} has joined the guild and will be set as Main" , GRM.GetClassifiedName ( name , true ) ) );
                    if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                        GRM.RefreshAuditFrames ( true , true );
                    end
                end
            end);
        end

    elseif GRM_G.RejoinControlCheck <= 90 then
        GRM_G.RejoinControlCheck = GRM_G.RejoinControlCheck + 1;

        -- Try to refresh the roster
        if GRM_G.RejoinControlCheck % 10 == 0 then
            GRM.GuildRoster();
        end

        C_Timer.After ( 0.1 , function()
            -- Re-Check 1 time.
            GRM.ClassicCheckForNewMember( name , scanNumber );
        end);
        return;
    end

    GRM_G.RejoinControlCheck = 0;
    GRM_G.LiveScanningBlock.joinC[scanNumber] = false;
end

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

    if GuildFrame and GuildFrame:IsVisible() then
        if GRM_G.BuildVersion < 40000 then
            for i = 1 , GRM_UI.ContainerButtonCount do
                _G[ "GuildFrameButton" .. i ]:UnlockHighlight();
            end
        else
            for i = 1 , GRM_UI.ContainerButtonCount do
                _G[ "GuildRosterContainerButton" .. i ]:UnlockHighlight();
            end
        end
    end
end
