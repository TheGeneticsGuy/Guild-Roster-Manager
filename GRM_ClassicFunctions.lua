
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