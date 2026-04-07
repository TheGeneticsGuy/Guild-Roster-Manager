-- Useful utility functions around the guild

local G_Util = {};
GRM.G_Util = G_Util;

-- Method:          G_Util.GetNumGuildies()
-- What it Does:    Returns the int number of total toons within the guild, including main/alts
-- Purpose:         For book-keeping and tracking total guild membership.
G_Util.GetNumGuildies = function()
    return GetNumGuildMembers();
end

-- Method:          G_Util.GetNumGuildiesInGuild ( table )
-- What it Does:    Returns the number of current guildies there are
-- Purpose:         For accurate reporting on most recent current snapshot of a guild in the database
G_Util.GetNumGuildiesInGuild = function(guildData)
    local c = 0;

    for _, p in pairs(guildData) do
        if type(p) == "table" then
            c = c + 1;
        end
    end

    return c;
end

-- Method:          G_Util.DatabasesAligned()
-- What it Does:    Checks to see if the number of guildies in expected databases align properly
-- Purpose:         There appears to be some kind of anomaly that appeared in 12.0.x where guilds of same name but different server could get mixed
--                  on a server call, but only temporarily. Very weird when querying guild data but this ensures the data aligns.
G_Util.DatabasesAligned = function()
    if GRM_G.gClubID and GRM_G.gClubID ~= 0 then
        local classicAPI_Count = 0;
        for i = 1, G_Util.GetNumGuildies() do
            local name = GetGuildRosterInfo(i);
            if name then
                classicAPI_Count = classicAPI_Count + 1;
            else
                print("GRM DEBUG: Classic Roster API Returnig Empty. PLEASE REPORT TO GRM DEV ON DISCORD (link curseforge).");
                return false;   -- easy early exit.
            end
        end

        local clubMembers = C_Club.GetClubMembers ( GRM_G.gClubID );
        if GRM.issecretvalue(clubMembers) then
            return false;   -- Midnight Secret Value protections
        end
        
        if classicAPI_Count > 0 and classicAPI_Count == GRM.Util.TableLength(C_Club.GetClubMembers ( GRM_G.gClubID )) then
            return true;
        else
            print(string.format("GRM DEBUG: Inconsistent Guild Server Data - %s - %s. PLEASE REPORT TO GRM DEV ON DISCORD (link curseforge). Author is trying to source error.", classicAPI_Count , GRM.Util.TableLength(C_Club.GetClubMembers ( GRM_G.gClubID ) )));
        end
    end
    return false;
end

-- Method:          G_Util.CheckGuildRanks()
-- What it Does:    Checks for any changes in the guild rank structure of the guild and reports on them
-- Purpose:         Just extra info, especially to help make it more clear to the player why they might get spammed in their log for mass demote/promotions
G_Util.CheckGuildRanks = function()
    -- If the ranks are set, let's check if they do not match now.
    local numRanks = GuildControlGetNumRanks();

    if numRanks == 0 or numRanks == nil then -- To prevent an error here, as this is critical, we wil not continue forward.
        return;
    end

    local guildData = GRM.GetGuild();
    local ranks = G_Util.GetListOfGuildRanks(true, true, true);

    if not ranks or ranks == "" then
        return;
    end

    guildData.ranks = guildData.ranks or ranks;

    GRM_G.guildRankNames = GRM_G.guildRankNames or G_Util.ParseGuildRanks();

    local updateRankCount = function()
        if guildData.grmNumRanks == nil or guildData.grmNumRanks == 0 then
            guildData.grmNumRanks = numRanks;
        end
    end

    if numRanks ~= guildData.grmNumRanks then

        updateRankCount();
        GRM_G.rankChangeShift = numRanks - guildData.grmNumRanks;
        GRM.Log.AddRankRenameEntry(GRM_G.rankChangeShift, nil, nil, GRM.Time.GetTimestamp());
        guildData.grmNumRanks = numRanks;
        GRM_G.numRanksHasChanged = true;

    else

        local rankNames = G_Util.GetListOfGuildRanks(true, true);
        local changeMade = false;

        if not rankNames or rankNames == "" then
            return;
        end
        updateRankCount();

        for i = 1, #rankNames do
            if rankNames[i] ~= GRM_G.guildRankNames[i] then
                changeMade = true;
                GRM.Log.AddRankRenameEntry(nil, GRM_G.guildRankNames[i], rankNames[i], GRM.Time.GetTimestamp());
            end
        end

        if changeMade then
            guildData.ranks = ranks;
            GRM_G.guildRankNames = G_Util.ParseGuildRanks();
        end
    end
end

-- Method:          G_Util.GetListOfGuildRanks( bool , bool , bool)
-- What it Does:    Gets a list of all rank names for dropdown menu
-- Purpose:         For building the macro dropdown menu for destination rank
G_Util.GetListOfGuildRanks = function(includeLeader, descending, asString)
    local numRanks = GuildControlGetNumRanks(); -- minus 1 because we are not including the guild leader
    local result = {};
    local resultString = "";

    local delimiter = "||";
    local name = "";

    local c = 1;
    if not includeLeader then
        c = 2;
    end

    if descending then
        for i = c, numRanks do
            name = GuildControlGetRankName(i);
            if not name or name == "" then
                return nil;
            end

            if asString then
                if i == numRanks then
                    resultString = resultString .. name;
                else
                    resultString = resultString .. name .. delimiter;
                end
            else
                table.insert(result, name);
            end
        end
    else
        for i = numRanks, c, -1 do

            name = GuildControlGetRankName(i);
            if not name or name == "" then
                return nil;
            end

            if asString then
                if i == c then
                    resultString = resultString .. name;
                else
                    resultString = resultString .. name .. delimiter;
                end
            else
                table.insert(result, name);
            end
        end
    end

    if asString then
        return resultString;
    else
        return result;
    end
end

-- Method:          G_Util.ParseGuildRanks()
-- What it Does:    Parses the string with al the guild ranks and returns it as an array
-- Purpose:         Due to some tables scanning logic I want to keep this stored as a string and then converted to a table during your session or re-converted if the ranks are updated.
G_Util.ParseGuildRanks = function()
    local ranks = {};

    for rankName in string.gmatch(GRM.GetGuild().ranks, "[^||]+") do
        table.insert(ranks, rankName);
    end
    return ranks;
end

-- Method:          G_Util.GetGuildMemberRankID ( string )
-- What it does:    Returns the rank index of the given player's name, or 0 if unable to find player
-- Purpose:         Rank needs to be known in certain circumstances, like knowing if something was a promotion or a demotion.
G_Util.GetGuildMemberRankID = function(name)
    local result
    -- Prevents errors if the other players sends a sync call too early, it will just ignore it.
    if GRM.GetGuild() and GRM.GetPlayer(name) then
        result = GRM.GetPlayer(name).rankIndex;
    end
    return result;
end

-- Method:          G_Util.GetNumGuildiesOnline()
-- What it Does:    Returns the int number of players currently online, with option to include those only on mobile, but not physically in the game, or not.
-- Purpose:         So on mouseover, the index on the roster call can be determined properly as online people are indexed first.
G_Util.GetNumGuildiesOnline = function()
    return select(2, GetNumGuildMembers());
end

-- Method:          G_Util.GetListOfOnlinePlayers()
-- What it Does:    Returns a string array of names, sorted in order, of players that are currently online
-- Purpose:         Easy use to know who is online currently in case you are checking something relevant.
G_Util.GetListOfOnlinePlayers = function()
    local list = {};

    for i = 1, G_Util.GetNumGuildies() do
        local player_name , _ , _ , _ , _ , _ , _ , _ , is_online = GetGuildRosterInfo(i);
        if is_online then
            table.insert(list, player_name);
        end
    end
    sort(list);
    return list;
end

-- Method:          G_Util.IsGuildieOnline( string , playerTable )
-- What it Does:    Lets you know if a guildie is currently online by returning true
-- Purpose:         It is useful to save resources and for knowledge to know if a player is currently online or not. No need to scan certain things wastefully if they are offline.
G_Util.IsGuildieOnline = function(name , player )

    player = player or GRM.GetGuild()[name];

    if player and player.isOnline then
        return true;
    end
    return false;
end

-- Method:          G_Util.GetSortedPlayerNames()
-- What it Does:    Gets the full list of guild members full sorted in order
-- Purpose:         Necessary for asynchronous scan through the guild since you can't use the pairs dictionary scan
G_Util.GetSortedPlayerNames = function()
    local names = {}
    local guild = GRM.GetGuild()

    if guild then
        for name, player in pairs(GRM.GetGuild()) do
            if type(player) == "table" then
                table.insert(names, name)
            end
        end
        table.sort(names)
    end
    return names
end

-- Method:          G_Util.GetGuildInfoText()
-- What it Does:    Gets the guild info text, with a check to see if it is currently restricted or not
-- Purpose:         Adapt to the 12.0.1 Midnight changes where many functions are now restricted in combat.
G_Util.GetGuildInfoText = function()
    local isRetricted = false;
    local result = "";
    if C_GuildInfo.GetInfoText then
        if not GRM_G.AddonRestricted then
            result = C_GuildInfo.GetInfoText();
        else
            isRetricted = true;
        end
    else
        result = GetGuildInfoText();
    end
    return result, isRetricted;
end

-- Method:          G_Util.GetGuildMOTD()
-- What it Does:    Gets the guild MOTD text, with a check to see if it is currently restricted or not
-- Purpose:         Adapt to the 12.0.1 Midnight changes where many functions are now restricted in combat.
G_Util.GetGuildMOTD = function()
    if not GRM_G.AddonRestricted then
        return GetGuildRosterMOTD();
    end

    return "";
end


