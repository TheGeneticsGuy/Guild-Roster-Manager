-- Save Variables for GRM
-- API to access and modify

GRM_AddonSettings_Save = GRM_AddonSettings_Save or {};                          -- Configuration saved here for all alts. Each toon gets their own configuration table as they might be in different guilds, thus player may want to configure different.
GRM_LogReport_Save = GRM_LogReport_Save or {};                                  -- This will be the stored Log of events and changes.
GRM_GuildMemberHistory_Save = GRM_GuildMemberHistory_Save or {}                 -- Detailed information on each guild member
GRM_PlayersThatLeftHistory_Save = GRM_PlayersThatLeftHistory_Save or {};        -- Data storage of all players that left the guild, so metadata is stored if they return. Useful for "rejoin" tracking, and to see if players were banned.
GRM_CalendarAddQue_Save = GRM_CalendarAddQue_Save or {};                        -- Since the add to calendar is protected, and requires a player input, this will be qued here between sessions. { name , eventTitle , eventMonth , eventDay , eventYear , eventDescription }
GRM_PlayerListOfAlts_Save = GRM_PlayerListOfAlts_Save or {};                    -- This is used so the player has a working alt list to reference, so they can add themselves to an alt list.
GRM_Alts = GRM_Alts or {};                                                      -- Alt groupings
GRM_DebugLog_Save = GRM_DebugLog_Save or {};                                    -- Character specific debug log for addon dev use submission.
GRM_Misc = GRM_Misc or {};                                                      -- This serves as a backup placeholder to hold important values if a player logs off in the middle of something, it can carry on where it left off by storing a marker.
GRM_DailyAnnounce = GRM_DailyAnnounce or {};
-- Backups...
GRM_GuildDataBackup_Save = GRM_GuildDataBackup_Save or {};                      -- For guild transferring to a new server
-- Minimap position for databroker
GRM_MinimapPosition = GRM_MinimapPosition or {};                                -- Saving this due to changes in frame positions need to now be saved

-- Functions table
GRM = {};

-- local ghostSettings;    -- In case a player leaves the guild abruptly.

--------------------------
--- DATA Queries ---------
--------------------------

-- OF NOTE, original tables will be returned, not new copies. These are absolutely mutatable tables and this is done intentionally.
-- The GRM API for public use being built in the GRM_API.lua file will follow the rules of functional programming and share copies of the tables.
-- As style preference, this is so a call can be made to the data, and it can be updated without needing a "SET" API for use. This will NOT be true in
-- the general use API class.

-- Method:          GRM.S( string )
-- What it Does:    Returns the player's settings. "S" is for settings.
-- Purpose:         The entire purpose of this is to streamline the code a bit and clean it up.
GRM.S = function ( name )
    if name and GRM_AddonSettings_Save[name] then
        return GRM_AddonSettings_Save[name];
    else
        if GRM_G.playerOnlySettings then
            -- if GRM_AddonSettings_Save[GRM_G.addonUser] then
            return GRM_AddonSettings_Save[GRM_G.addonUser];
            -- else
            --     ghostSettings = ghostSettings or BuildGhostSettings();
            --     return ghostSettings;
            -- end
        else
            -- if GRM_AddonSettings_Save[GRM_G.guildName] then
            return GRM_AddonSettings_Save[GRM_G.guildName];
            -- else
            --     ghostSettings = ghostSettings or BuildGhostSettings();
            --     return ghostSettings;
            -- end
        end
    end
end

-- -- Method:          BuildGhostSettings()
-- -- What it Does:    Creates a parallel settings profile
-- -- Purpose:         Since settings are tied to the guild, or to the player, if someone quits a guild, all of a sudden the settings unload
-- --                  Well, this is a problem if there are frames in the middle of loading, or various GRM features still being processed and calling settings variables.
-- --                  Now, if the settings are called, and instead of returning a nil, it will just return the placeholder default setting, which doesn't relaly matter
-- --                  as you are now in the guild, but it will allow those edge cases to finish running and not cause lua errors when leaving a guild abruptly.
-- local BuildGhostSettings = function()
--     local player = {};
--     for i = 0, GRM_G.SettingsPages do
--         GRM.SetDefaultAddonSettings (player, i);
--     end

--     return player;
-- end

-- Method:          GRM.GetPlayer ( string [, bool] [, string] )
-- What it Does:    Returns the playerTable
-- Purpose:         Easier to pull player data.
GRM.GetPlayer = function ( name , appendServer , gName )
    local guildName = gName or GRM_G.guildName;

    if guildName ~= "" and GRM_GuildMemberHistory_Save[ guildName ] then
        if not appendServer then
            return GRM_GuildMemberHistory_Save[ guildName ][ name ];
        else
            return GRM_GuildMemberHistory_Save[ guildName ][ GRM.AppendServerName ( name , true ) ];
        end
    else
        return nil;
    end
end

-- Method:          GRM.GetFormerPlayer ( string [, bool] [, string])
-- What it Does:    Returns the playerTable
-- Purpose:         Easier to pull player data.j
GRM.GetFormerPlayer = function ( name , appendServer , gName )
    local guildName = gName or GRM_G.guildName;

    if guildName ~= "" and GRM_GuildMemberHistory_Save[ guildName ] then
        if not appendServer then
            return GRM_PlayersThatLeftHistory_Save[ guildName ][ name ];
        else
            return GRM_PlayersThatLeftHistory_Save[ guildName ][ GRM.AppendServerName ( name , false ) ];
        end
    else
        return nil;
    end
end

-- Method:          GRM.GetGuild ( [,string] )
-- What it Does:    Returns the guild database of all players with the selected, or default current guild.
-- Purpose:         Compartmentalize the data queries.
GRM.GetGuild = function ( name )

    if name then
        return GRM_GuildMemberHistory_Save[ name ];
    else
        return GRM_GuildMemberHistory_Save[ GRM_G.guildName ];
    end

end

-- Method:          GRM.GetFormerMembers ( [,string] )
-- What it Does:    Returns the guild database of all players with the selected, or default current guild.
-- Purpose:         Compartmentalize the data queries.
GRM.GetFormerMembers = function ( name )

    if name then
        return GRM_PlayersThatLeftHistory_Save[ name ];
    else
        return GRM_PlayersThatLeftHistory_Save[ GRM_G.guildName ];
    end

end

-- Method:          GRM.GetLog ( [,string] )
-- What it Does:    Returns the log report of the given guild, or the default guild you are in
-- Purpose:         Call the data easily.
GRM.GetLog = function( name )

    if name then
        return GRM_LogReport_Save[name];
    else
        return GRM_LogReport_Save[GRM_G.guildName];
    end

end

-- Method:          GRM.GetEvents ( [,string] )
-- What it Does:    Returns items in queue to be added to the calendar.
-- Purpose:         Call the data easily.
GRM.GetEvents = function( name )

    if name then
        return GRM_CalendarAddQue_Save[name];
    else
        return GRM_CalendarAddQue_Save[GRM_G.guildName];
    end

end

-- Method:          GRM.GetAddOnUserGuildAlts ( [,string] )
-- What it Does:    Returns list of addon users' alts that have been auto-found and registered for given guild.
-- Purpose:         Call the data easily.
GRM.GetAddOnUserGuildAlts = function ( name )

    if name then
        return GRM_PlayerListOfAlts_Save[name];
    else
        return GRM_PlayerListOfAlts_Save[GRM_G.guildName];
    end

end

-- Method:          GRM.GetGuildAlts ( string )
-- What it Does:    Returns the database of alts for the given guild or current guild
-- Purpose:         Call the data easily.
GRM.GetGuildAlts = function ( name )
    if name then
        return GRM_Alts[name];
    else
        return GRM_Alts[GRM_G.guildName];
    end
end

-- Method:          GRM.GetClubMemberInfo ( string , int )
-- What it Does:    Returns the info provided by the Club API on a member
-- Purpose:         The GetGuildRosterInfo provides some info that Club API does not, and the club API provides some info the guild API does not. This is an easy lookup by name.
GRM.GetClubMemberInfo = function ( playerName , clubID )
    local result;
    clubID = clubID or C_Club.GetGuildClubId();

    if clubID and clubID ~= "" then
        local members = C_Club.GetClubMembers ( clubID );
        local name = "";
        local player = {};

        for i = 1 , #members do
            player = C_Club.GetMemberInfo ( clubID , members[i] )
            name = GRM.GetFullNameClubMember ( player.guid );

            if name ~= "" and name == playerName then
                result = player;
                break;
            end
        end

    end

    return result;
end

-- Method:          GRM.GetMemberInfoWithFullName ( int , int )
-- What it Does:    Returns the Club member info, as well as their full name-serverName
-- Purpose:         It is necessary to have the full player-serverName, but the Club API only returns the slim non-server name. This ensures you have their full name as well by utilizing the guid.
GRM.GetMemberInfoWithFullName = function ( memberID , clubID )
    clubID = clubID or C_Club.GetGuildClubId();

    local memberInfo = C_Club.GetMemberInfo ( clubID , memberID );
    local fullName = "";

    if memberInfo then
        fullName = GRM.GetFullNameClubMember ( memberInfo.guid );
    end

    return memberInfo , fullName;
end

-- Method:          GRM.GetListOfGuildies( bool )
-- What it Does:    Returns a list of all current members of the guild in alphabetical order
-- Purpose:         Occasionally you want a list of guild members.
GRM.GetListOfGuildies = function( slimName )
    local list = {};
    local members = C_Club.GetClubMembers ( GRM_G.gClubID );
    local fullName = "";

    for i = 1 , #members do
        if slimName then
            table.insert ( list , C_Club.GetMemberInfo ( GRM_G.gClubID , members[i] ).name );
        else
            fullName = select ( 2 , GRM.GetMemberInfoWithFullName ( members[i] ) );
            table.insert ( list , fullName );
        end
    end
    sort ( list );
    return list;
end

-- Method:          GRM.GetIndexOfPlayerOnList ( table , string )
-- What it Does:    Returns index of player in a list, or nil if not found.
-- Purpose:         Faster searching using binary search algorithm.
GRM.GetIndexOfPlayerOnList = function ( sortedTable , name )
    local bottomNum = 1;
    local topNum = #sortedTable;
    local mid = 0;

    while topNum >= bottomNum do
        mid = math.floor ( ( bottomNum + topNum ) / 2 );    -- Cut it in half, and ensure it rounds down like dividing an integer

        if name < sortedTable[mid].name then        -- It is below!
            topNum = mid - 1;

        elseif name == sortedTable[mid].name then   -- It is a match!
            return mid;

        else                            -- It is above!
            bottomNum = mid + 1;
        end
    end

    return nil;
end