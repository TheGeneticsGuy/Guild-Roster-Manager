-- GRM PUBLIC ACCESS API TO QUERY GRM DATABASE

-- NOTES ON USE AND DESIGN STYLE
-- Note 1: Name format input

-- Since GRM deals with so many aspects of merged realm, cross-realm, classic and retail servers, all as a single universal code-base, to make our lives easier a full "Name-Server" format must be used for implementation on input. The server MUST be in the proper Blizzard database format too which I will explain below. Be aware that when querying the Blizzard servers this automatically has the name-serverName in proper format, so you don't need to do much work here, but for people that might be more hands-on in customizing the input arguments, follow these recommendations.
-- Example on Name Format:
--          Name: Arkaan-Zul'jin    -- CORRECT
--          Name: Arkaan            -- INCORRECT
--
-- Example on Server Format:
--          Name: Arkaan-AlteracMountains   -- CORRECT
--          Name: Arkaan-Alterac Mountains  -- INCORRECT

-- Note: The server name must also be appended to the name of the guild.
--          guildName: "Is a Subatomic Particle-Zul'jin"    -- CORRECT
--          guildName: "Is a Subatomic Particle"            -- INCORRECT

-- There are many varied realm names beyond just a simple white space removal, so I wrote a script to auto-format your guild name to the proper format, if needed at all. I suspect most will never need it.
-- Function:    GRM_API.ConvertRealmNameToDatabaseFormat ( realmName );

-- Note 2: Return results

-- If the player calls a function and it returns "nil" then one can assume there is no data to return. In other words, the player is non-existent given the input.
-- Example:
--          local isMain = GRM_API.IsMain( playerName );  -- One could also write it:  local isMain = playerName:GRM_API.IsMain();
--
-- If the "isMain" variable is true/false, then we know the player has been found in the database AND they are or are not a main. If the "isMain" == nil, then the playerName was not found in the given database.


-- Note 3: Default inputs can be changed

-- By default, to make this as simple as possible, the only thing that needs to be entered as an input is the player's name. The code will auto-default to using your current faction and guild as the database to look through. However, if you wish, you can modify the database query to any faction/guild you wish.
-- Example:
-- "Default"            local isMain = GRM_API.IsMain ( "Arkaan-Zul'jin" )                                              -- CORRECT  -- addon defaults to current faction and guild
-- This "default" ==    local isMain = GRM_API.IsMain ( "Arkaan-Zul'jin" , "Is a Subatomic Particle-Zul'jin" )    -- CORRECT  -- This is the exact same thing as previous. As can be seen, previous format is to simplify process.

-- "Search Database"    local isMain = GRM_API.IsMain ( "Arkaan-Tanaris" , "Dawn of the Dead-Tanaris" )                 -- CORRECT  -- addon now searches current faction, but guild on another server

-- Note: You will receive an error text notifaction that catches the failure to find results in a query. It will inform you what it could not find, the guild or the player. This will auto-query the whole databse be it Horde or Ally, so the only thing you really need to ensure is proper playerName spelling and proper guildName spelling/formatting.


-- FUNCTION ARGUMENTS
-- 
-- [, argument] -- this indicates an "optional" argument.

-- EXAMPLE: GRM_API.IsMain ( string [, string ] )
-- 
--          GRM_API.IsMain ( "Arkaan-Zul'jin" )                                                 -- CORRECT
--          GRM_API.IsMain ( "Arkaan-ConnectedRealm" , "connectedRealmGuild-ConnectedRealm" )   -- CORRECT





-- Table to hold all methods.
GRM_API = {};

GRM_API.Initialized = false;


-- GRM API ACCESS MISC - Public use general tools further down

-- Method:          GateCheck ( string , string )
-- What it Does:    Acts as a gate check to not throw errors, validates input information
-- Purpose:         Since this is public access API, it is being built with some safeguards in place to prevent Lua errors.
local function GateCheck ( playerName , guildName )
    
    if not GRM_API.Initialized then -- return nil every time until initialized
        return;
    end

    local isValid = true;
    local gName,f;

    -- Guild Name Check
    local gName = guildName or GRM_G.guildName;
    if gName == "" then
        isValid = false;
    end

    -- Validate player info
    if isValid then
        if GRM_G.F == "H" then
            f = "A";
        else
            f = "H";
        end

        if not GRM_GuildMemberHistory_Save[GRM_G.F][gName] and not GRM_GuildMemberHistory_Save[f][gName] then
            isValid = false;
            GRM.Report ( GRM.L ( "GRM API Error:" ) .. " " .. GRM.L ( "The guild name \"{name}\" cannot be found in the database. Ensure proper formatting." , gName ) );
                
        else
            -- Setting which faction it is properly for return
            if GRM_GuildMemberHistory_Save[GRM_G.F][gName] then
                f = GRM_G.F;
            end
        end
        
        if isValid then
            if not GRM_GuildMemberHistory_Save[f][gName][playerName] then
                isValid = false;
                GRM.Report ( GRM.L ( "GRM API Error:" ) .. " " .. GRM.L ( "The player name \"{name}\" cannot be found in the database. Ensure proper spelling." , playerName ) );
            end
        end
    end

    return isValid , gName , f;
end

-- Method:          GRM_API.ConvertRealmToDatabaseFormat ( string )
-- What it Does:    Converts the Realm format to proper format\
-- Purpose:         Necessary for database talk.
GRM_API.ConvertRealmNameToDatabaseFormat = function ( realmName )
    return string.gsub ( string.gsub ( realmName , "-" , "" ) , "%s+" , "" );
end

-- Method:          GRM.ClearFriendsList()
-- What it Does:    Clears the entire server side, non-battletag friends list completely to zero
-- Purpose:         For debugging cleanup
GRM_API.ClearFriendsList = function()
    for i = C_FriendList.GetNumFriends() , 1 , -1 do
        local name = C_FriendList.GetFriendInfoByIndex ( i ).name;
        C_FriendList.RemoveFriend ( name );
    end
end

-- Method:          GRM.ClearAllOfficerNotes()
-- What it Does:    Clears every officer note to every player in the guild
-- Purpose:         Mass cleanup abilities
GRM_API.ClearAllOfficerNotes = function()

    if CanEditOfficerNote() then
        for i = 1 , GetNumGuildMembers() do
            GuildRosterSetOfficerNote ( i , "" );
        end
    else
        if IsInGuild() then
            GRM.Report ( GRM.L ( "Unable to change officer notes at current rank" ) );
        else
            GRM.Report ( GRM.L ( "Player is not currently in a Guild" ) );
        end
    end
end

--------------------------------
-- Public Access GRM database --
--------------------------------

-- Method:          GRM_API.GetMemberData ( string [, string ] )
-- What it Does:    Returns the entire metaData profile on a player as a table. The data is washed and rebuilt so the values cannot be modified.
-- Purpose:         Database access
GRM_API.GetMemberData = function ( playerName , guildName )
    local valid , memberData , gName , faction;
    valid , gName , faction = GateCheck ( playerName , gName );

    if valid then
        memberData = GRM.DeepCopyArray ( GRM_GuildMemberHistory_Save[faction][gName][playerName] );
    end

    return valid , memberData
end

-- Method:          GRM_API.GetMain ( string [, string ] );
-- What it does:    Returns the player's main if they are part of an alt grouping. Or, retuns nil if there is no main designation. It can return its own name. 
-- Purpose:         Database access
GRM_API.GetMain = function( playerName , guildName )
    local valid , result , gName , faction;
    valid , gName , faction = GateCheck ( playerName , guildName );

    if valid then
        if GRM_GuildMemberHistory_Save[faction][gName][playerName].isMain then
            result = playerName;
        elseif #GRM_GuildMemberHistory_Save[faction][gName][playerName].alts > 0 then
            local alts = GRM_GuildMemberHistory_Save[faction][gName][playerName].alts;

            for i = 1 , #alts do
                -- main found!
                if alts[i][5] then
                    result = GRM.DeepCopyArray ( alts[i][1] );
                    break;
                end
            end
        end
    end

    return result;
end

-- Method:          GRM_API.IsMain ( string [, string ] );
-- What it does:    Returns true or false if the player is a main. If player cannot be found, it returns nil.
-- Purpose:         Database access
GRM_API.IsMain = function( playerName , guildName )
    local valid , result , faction , gName;
    valid , gName , faction = GateCheck ( playerName , guildName );

    if valid then
        if GRM_GuildMemberHistory_Save[faction][gName][playerName].isMain then
            result = true;
        else
            result = false;
        end
    end

    return result;
end

GRM_API.GetAlts = function( playerName , namesOnly , guildName )
    local valid , result , gName , faction;
    valid , gName , faction = GateCheck ( playerName , gName );

    if valid then


    end

    return result;
end

GRM_API.GetJoinDate = function( playerName , getOriginal , guildName )
    local valid , result , gName , faction , verified;
    valid , gName , faction = GateCheck ( playerName , gName );

    if valid then


    end

    return result , verified;
end

GRM_API.GetLastPromotionDate = function( playerName , guildName )
    local valid , result , gName , faction , verified;
    valid , gName , faction = GateCheck ( playerName , gName );

    if valid then


    end

    return result , verified;
end

GRM_API.GetBirthday = function( playerName , guildName )
    local valid , day , month , timestamp , gName , faction;
    valid , gName , faction = GateCheck ( playerName , gName );

    if valid then


    end

    return day , month, timestamp;
end

GRM_API.GetCustomNote = function( playerName , guildName )
    local valid , result , gName , faction;
    valid , gName , faction = GateCheck ( playerName , gName );

    if valid then


    end

    return result;
end

