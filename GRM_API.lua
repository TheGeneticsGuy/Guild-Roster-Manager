-- GRM PUBLIC ACCESS API TO QUERY GRM DATABASE

-- NOTES ON GENERAL USE:

-- * API calls do not need to include guild/faction. If excluded, they will default to current faction addon user is in
-- * Server will be appended if left off name. The server MUST be included on toons not of the same realm
-- * `faction` = "H" for Horde and "A" for Alliance
-- * If the player cannot be found, results will return as 'nil`
-- * Please note, the "GET" data returned is a copy of the GRM DB and not linked to the GRM database to be modified.

-- Table to hold all methods.
GRM_API = {};

-- Error Protection
GRM_API.GetCheck = function ( name , guild , faction , formerMemberDB )
    local isValid = false;
    local guildData;
    if not formerMemberDB then
        guildData = GRM_GuildMemberHistory_Save;
    else
        guildData = GRM_PlayersThatLeftHistory_Save;
    end

    name = GRM.AppendServerName ( name );
    guild = guild or GRM_G.guildName;
    faction = faction or GRM_G.F;

    if name ~= "" and guild ~= "" and faction ~= "" then
        if guildData[faction] and guildData[faction][guild] and guildData[faction][guild][name] then
            isValid = true;
        end
    end

    return isValid , name , guild , faction;
end

--------------------------------
-- Public Access GRM database --
--------------------------------

-- Method:          GRM_API.GetMember ( string [,string] [,string] )
-- What it Does:    Returns the member and all player data stored by GRM
GRM_API.GetMember = function ( name , guild , faction )
    local result;
    local isValid;
    isValid , name , guild , faction = GRM_API.GetCheck ( name , guild , faction );

    if isValid then
        result = GRM.DeepCopyArray ( GRM_GuildMemberHistory_Save[faction][guild][name] );
    end

    return result;
end

-- Method:          GRM_API.GetFormerMember ( string [,string] [,string] )
-- What it Does:    Returns the former Member and all player data stored by GRM
GRM_API.GetFormerMember = function ( name , guild , faction )
    local result;
    local isValid;
    isValid , name , guild , faction = GRM_API.GetCheck ( name , guild , faction , true );

    if isValid then
        result = GRM.DeepCopyArray ( GRM_PlayersThatLeftHistory_Save[faction][guild][name] );
    end

    return result;
end

-- Method:          GRM_API.GetMemberAlts ( string [,string] [,string] )
-- What it Does:    Returns an alphabetically sorted list of alts in a string array
GRM_API.GetMemberAlts = function ( name , guild , faction )
    local result;
    local isValid;
    isValid , name , guild , faction = GRM_API.GetCheck ( name , guild , faction );

    if isValid then
        result = GRM.GetAlts ( GRM_GuildMemberHistory_Save[faction][guild][name] , GRM_Alts[guild] );
    end

    return result;
end


-- GRM_API.GetCustomNote = function()
    

-- end

-- GRM_API.SetCustomNote = function()


-- end

-- GRM_API.GetPlayerNote = function()

-- end

-- GRM_API.GetOfficerNote = function()

-- end


-- GRM_API.GetBirthday = function()


-- end


-- GRM_API.GetJoinDates = function()


-- end


-- GRM_API.GetPromotionDates = function()


-- end


-- GRM_API.GetBanedPlayers = function()

-- end


-- GRM_API.GetTimeAsMember = function()

-- end


-- GRM_API.GetTimeAtRank = function()

-- end


-- GRM_API.GetRankHistory = function()

-- end


-- GRM_API.GetMembershipHistory = function()

-- end


-- GRM_API.GetWhoInvited = function()

-- end


-- GRM_API.GetRoles = function()       -- Pending GRM feature

-- end


-- GRM_API.GetNickname = function()    -- Pending GRM Feature

-- end


-- GRM_API.GetPronouns = function()    -- Pending GRM Feature (as requested)

-- end



------------------------------------------------------
------------------------------------------------------
---- TOOLBOX FOR UNIQUE API POWER TOOLS --------------
---- WARNING!!! USE WITH CAUTION!! -------------------
------------------------------------------------------

-- Method:          GRM.ClearFriendsList()
-- What it Does:    Clears the entire server side, non-battletag friends list completely to zero
-- Purpose:         To cleanup friends if you wanted
GRM_API.ClearFriendsList = function()
    for i = C_FriendList.GetNumFriends() , 1 , -1 do
        C_FriendList.RemoveFriend ( C_FriendList.GetFriendInfoByIndex ( i ).name );
    end
end

-- Method:          GRM.ClearAllOfficerNotes()
-- What it Does:    Clears every officer note to every player in the guild
-- Purpose:         Mass cleanup abilities
GRM_API.ClearAllOfficerNotes = function()
    if GRM.CanEditOfficerNote() then
        for i = 1 , GetNumGuildMembers() do
            GuildRosterSetOfficerNote ( i , "" );
        end
    end
end

-- Method:          GRM.ClearAllOfficerNotes()
-- What it Does:    Clears every public note to every player in the guild
-- Purpose:         Mass cleanup abilities
GRM_API.ClearAllPublicNotes = function()
    if GRM.CanEditPublicNote() then
        for i = 1 , GetNumGuildMembers() do
            GuildRosterSetPublicNote ( i , "" );
        end
    end
end

-- Method:          GRM.RestoreAllPublicNotesFromSave()
-- What it Does:    Looks at the GRM save database and restores all the public notes
-- Purpose:         In case someone nefariously overwrites all public notes
GRM_API.RestoreAllPublicNotesFromSave = function()
    local guildData = GRM_GuildDataBackup_Save[GRM_G.F][GRM_G.guildName].Auto.members;
    local name = "";

    if GRM.CanEditPublicNote() then
        for i = 1 , GRM.GetNumGuildies() do 
            name = GetGuildRosterInfo ( i );
            for n , player in pairs ( guildData ) do 
                if type ( player ) == "table" and name == n then 
                    GuildRosterSetPublicNote ( i , player.note);
                end
            end
        end
    end
end

-- Method:          GRM.RestoreAllOfficerNotesFromSave()
-- What it Does:    Looks at the GRM save database and restores all the officer notes
-- Purpose:         In case someone nefariously overwrites all officer notes
GRM_API.RestoreAllOfficerNotesFromSave = function()
    local guildData = GRM_GuildDataBackup_Save[GRM_G.F][GRM_G.guildName].Auto.members;
    local name = "";

    if GRM.CanEditOfficerNote() then
        for i = 1 , GRM.GetNumGuildies() do 
            name = GetGuildRosterInfo ( i );
            for n , player in pairs ( guildData ) do 
                if type ( player ) == "table" and name == n then 
                    GuildRosterSetOfficerNote ( i , player.officerNote );
                end
            end
        end
    end
end

-- Method:          GRM_API.SetAllUnlinkedPlayersToMain()
-- What it Does:    Any player that is not a main, and does not have any linked alts will be set as main.
-- Purpose:         Mass tool for OCD people who want to set all as main.
GRM_API.SetAllUnlinkedPlayersToMain = function()
    local guildData = GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName];

    for name , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.altGroup == "" then
                GRM.SetMain ( name );
            end
        end
    end

    if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
        GRM.RefreshAuditFrames ( true , true );
    end

end

-- Method:          GRM_API.SetAllUnknownPromoteDates ( int , int , int )
-- What it Does:    Sets all players who do not have a rank change date set yet as the given date
-- Purpose:         Mass tool to cleanup timestamps if you really do not want to investigate
-- NOTES:           This is not really recommended to use, in that it is better to try to determine at least relative join dates
GRM_API.SetAllUnknownPromoteDates = function ( day , month , year )

    if GRM.IsValidSubmitDate ( day , month , year ) then

        for _ , player in pairs ( GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName] ) do
            if type ( player ) == "table" then

                -- Ok, let's do the rank history first
                if player.promoteDateUnknown or player.rankHist[1][2] == 0 then

                    player.rankHist = { { player.rankName , 0 , 0 , 0 , 0 , 0 , false , 1 } }; -- Wipe the history
                    player.rankHist[1][1] = player.rankName;
                    player.rankHist[1][2] = day;
                    player.rankHist[1][3] = month;
                    player.rankHist[1][4] = year;
                    player.rankHist[1][5] = GRM.TimeStampToEpoch ( { day , month , year } );
                    player.rankHist[1][6] = time();
                    player.rankHist[1][7] = true;
                    player.rankHist[1][8] = 1;
                    
                    -- If player had it set to "unknown before"
                    player.promoteDateUnknown = false;

                end

            end
        end

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
            GRM.RefreshAuditFrames ( true , true );
        end

    end
end

-- Method:          GRM_API.SetAllUnknownJoinDates ( int , int , int )
-- What it Does:    Sets all players who do not have a promote date set yet as the given date
-- Purpose:         Mass tool to cleanup timestamps if you really do not want to investigate
-- NOTES:           This is not really recommended to use, in that it is better to try to determine at least relative join dates
GRM_API.SetAllUnknownJoinDates = function ( day , month , year )

    if GRM.IsValidSubmitDate ( day , month , year ) then

        for _ , player in pairs ( GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName] ) do
            if type ( player ) == "table" then

                -- Now, Join Date
                if player.joinDateUnknown or player.joinDateHist[1][1] == 0 then

                    player.joinDateHist = {};
                    table.insert ( player.joinDateHist , { day , month , year , GRM.TimeStampToEpoch ( { day , month , year } ) , time() , true , 1 } );

                    player.joinDateUnknown = false;

                    GRM.AddTimeStampToNote ( player.name , GRM.FormatTimeStamp ( { day , month , year } , false , false , false ) );

                    player.events[1][1][1] = day;
                    player.events[1][1][2] = month;
                    player.events[1][1][3] = year;
                    player.events[1][2] = false;  -- Gotta Reset the "reported already" boolean!
                    GRM.RemoveFromCalendarQue ( player.name , 1 , nil );

                end 
            end
        end

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
            GRM.RefreshAuditFrames ( true , true );
        end
        if GRM_UI.GRM_RosterChangeLogFrame.GRM_EventsFrame:IsVisible() then
            GRM.RefreshAddEventFrame()
        end

    end
end

