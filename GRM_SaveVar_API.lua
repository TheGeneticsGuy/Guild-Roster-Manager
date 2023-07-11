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
            return GRM_AddonSettings_Save[GRM_G.addonUser];
        else
            return GRM_AddonSettings_Save[GRM_G.guildName];
        end
    end
end

-- Method:          GRM.GetPlayer ( string [, bool] [, string] )
-- What it Does:    Returns the playerTable
-- Purpose:         Easier to pull player data.
GRM.GetPlayer = function ( name , appendServer , gName )
    local guildName = gName or GRM_G.guildName;

    if guildName ~= "" then
        if not appendServer then
            return GRM_GuildMemberHistory_Save[ guildName ][ name ];
        else
            return GRM_GuildMemberHistory_Save[ guildName ][ GRM.AppendServerName ( name , false ) ];
        end
        return nil;
    end
end

-- Method:          GRM.GetFormerPlayer ( string [, bool] [, string])
-- What it Does:    Returns the playerTable
-- Purpose:         Easier to pull player data.
GRM.GetFormerPlayer = function ( name , appendServer , gName )
    local guildName = gName or GRM_G.guildName;

    if guildName ~= "" then
        if not appendServer then
            return GRM_PlayersThatLeftHistory_Save[ guildName ][ name ];
        else
            return GRM_PlayersThatLeftHistory_Save[ guildName ][ GRM.AppendServerName ( name , true ) ];
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
GRM.GetClubMemberInfo = function ( playerName , guildClubID )
    local result;
    local clubID = guildClubID or C_Club.GetGuildClubId();

    if clubID and clubID ~= "" then
        local members = C_Club.GetClubMembers ( clubID );
        local name = "";

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

-- Method:          GRM.GetNumKeyedEntries ( table )
-- What it Does:    Returns the count of the number of keyed entries in a table
-- Purpose:         Generic use iterator to return count since '#' only works on string length and arrays length
GRM.GetNumKeyedEntries = function ( t )
    local c = 0;

    for x in pairs ( t ) do
        if type ( x ) == "string" then
            c = c + 1;
        end
    end

    return c;
end