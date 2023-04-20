-- ALT MANAGEMENT FUNCTIONS IN A SINGLE CLASS
-- This will function to organize alt management easier and quicker access to the alt functions.
-- As GRM has grown, the core file has grown quite large. This will help me from trying to remember
-- if a function exists and trying to seek it out, to instead putting it in a more compact file.

-- Method:          GRM.GetAltGroupMain ( string )
-- What it Does:    Returns the string name of the player who is listed as the main, and also the GUID if requested
-- Purpose:         Easily get the player's main.
GRM.GetAltGroupMain = function ( altGroup , includeGUID )
    local main = "";
    local GUID = "";

    if altGroup ~= "" and GRM_Alts[GRM_G.guildName][altGroup] then
        main = GRM_Alts[GRM_G.guildName][altGroup].main;

        local player = GRM.GetPlayer ( main );
        if includeGUID and player then
            GUID = player.GUID;
        end
    end

    return main , GUID;
end

-- Method:          GRM.GetPlayerMain ( string )
-- What it Does:    Returns the full player of the toon's main, or himself if he is main, or an empty string if no main.
-- Purpose:         Useful lookup for many purposes...
GRM.GetPlayerMain = function ( playerName )
    local player = GRM.GetPlayer ( playerName);
    local result = "";

    if player then

        if player.isMain then
            result = playerName;
        else
            if player.altGroup ~= "" and GRM_Alts[GRM_G.guildName][player.altGroup].main ~= "" then
                result = GRM_Alts[GRM_G.guildName][player.altGroup].main;
            end
        end

    end
    return result;
end

-- Method:          GRM.GetNumAltGroups ( string )
-- What it Does:    Return the count of the number of alt groups in the guild
-- Purpose:         To determine which unique identifier to give the alt group.
GRM.GetNumAltGroups = function( guildName )
    guildName = guildName or GRM_G.guildName;
    local count = 0;

    for _ in pairs ( GRM_Alts[guildName] ) do
        count = count + 1;
    end

    return count;
end

-- Method:          GRM.GetPlayerAltGroupID ( string )
-- What it Does:    Returns the id of the player's alt Group
-- Purpose:         Easy lookup tool to query it.
GRM.GetPlayerAltGroupID = function ( name )
    local id;
    local player = GRM.GetPlayer ( name );

    if player then
        id = player.altGroup;
    end
    return id
end

-- Method:          GRM.CreateNewAltGroupID ( string )
-- What it Does:    Creates a new unique identifier
-- Purpose:         For managing the alt groups.
GRM.CreateNewAltGroupID = function ( guildName )
    guildName = guildName or GRM_G.guildName;
    local count = GRM.GetNumAltGroups ( guildName );
    local newID = count + 1;
    if newID == 1 then
        newID = 2;
    end

    while GRM_Alts[guildName][tostring ( newID ) ] do
        newID = newID + 1;
    end

    return tostring ( newID );
end

-- Method:          GRM.ConvertGUIDToVal ( string )
-- What it Does:    Converts the string into a byteValue sum
-- Purpose:         To create a unique identifier in smaller form. It should also be noted that this only handles the Blizzard format of a GUID as if it uses
--                  special unicode characters it will not unique value it correctly and a different method should be used. This is strictly for the Warcraft player GUID format valueing.
GRM.ConvertGUIDToVal = function ( guid )

    guid = string.gsub ( guid , "Player%-%d+%-" , "" );
    local byteArray = { string.byte ( guid , 1 , -1 ) };
    local result = 0;

    for i = 1 , #byteArray do
        result = result + byteArray[i];
    end
    return result;
end

-- Method:          GRM.ConvertStringToVal ( string )
-- What it Does:    Creates a Unique Identifier with the player
-- Purpose:         For purposes of creating a unique ID hash.
GRM.ConvertStringToVal = function ( name )
    name = name or "";
    local result = 0;
    local nameByteArray = { string.byte ( name , 1 , -1 ) };
    for i = 1 , #nameByteArray do
        result = result + nameByteArray[i];
    end
    return result;
end

-- Method:          GRM.IsToonNotInAltGroup ( string , string )
-- What it Does:    It checks the entire alt grouping databse for the guild to see if they are in any group
-- Purpose:         To validate that the player is not currently in any group for integrity checks, before adding to one.
GRM.IsToonNotInAltGroup = function ( name , guildName )
    local gName = guildName or GRM_G.guildName;
    local validated = true;                                 -- so far!
    local foundID = {};

    for id , group in pairs ( GRM_Alts[gName] ) do          -- Scan through all alt groups
        for i = 1 , #group do
            if group[i].name == name then
                validated = false;
                table.insert ( foundID , id );
            end
        end
    end

    return validated, foundID;
end

-- Method:          GRM.RemoveAltFromGrouping ( string , playerTable )
-- What it Does:    It removes a player from the alt grouping
-- Purpose:         alt management.
GRM.RemoveAltFromGrouping = function ( groupID , guildName , player )
    -- Let's remove main status.
    if GRM_Alts[guildName][groupID].main == player.name then
        GRM_Alts[guildName][groupID].main = "";
        player.isMain = false;
    end

    -- Now we remove the name from the group
    for i = 1 , #GRM_Alts[guildName][groupID] do
        if GRM_Alts[guildName][groupID][i].name == player.name then
            table.remove ( GRM_Alts[guildName][groupID] , i );
            break;
        end
    end

    if player.name == GRM_G.currentName then
        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
    end
end

-- Method:          GRM.PlayerIsAnAlt ( playerTable )
-- What it Does:    Returns true if the given player is considered an "alt" not a main, or no designation
-- Purpose:         To inform if the player is an alt more easily.
GRM.PlayerIsAnAlt = function ( player )
    local result = false;

    if player and player.altGroup ~= "" and GRM_Alts[GRM_G.guildName][player.altGroup].main ~= player.name then
        result = true;
    end

    return result;
end

-- Method:          GRM.GetTimeOfAltGroupChange ( table )
-- What it Does:    Returns the integer epoch timestamp of when the player's last modification to the alt group came.
-- Purpose:         Syncing alt data generally.
GRM.GetTimeOfAltGroupChange = function ( player )
    local result = 0;

    if player then
        result = player.altGroupModified;
    end

    return result;
end

-- Method:          GRM.AltModifiedIntegrityCheck()
-- What it Does:    Verifies the integrity of certain data
-- Purpose:         Due to the possibility of sync failing in the middle, like if someone goes offline or the other hits a loading screen in the middle of a sync, it is possible that this data can end up nil, in certain cases. This resolves that bug by rebuilding the variable.
GRM.AltModifiedIntegrityCheck = function()
    for _ , player in pairs ( GRM.GetGuild() ) do
        if type ( player ) == "table" then

            if not player.altGroupModified then

                if player.altGroup ~= "" and GRM_Alts[GRM_G.guildName][player.altGroup] then
                    
                    -- verifi timeOfChange is not nil
                    if not GRM_Alts[GRM_G.guildName][player.altGroup].timeModified then
                        GRM_Alts[GRM_G.guildName][player.altGroup].timeModified = 0;
                    end

                    player.altGroupModified = GRM_Alts[GRM_G.guildName][player.altGroup].timeModified + 1 - 1; -- Disassociate and create new index.
                else
                    -- Alt Group has been broken
                    if not GRM_Alts[GRM_G.guildName][player.altGroup] then
                        player.altGroup = "";
                    end

                    player.altGroupModified = 0;    -- nil value, and not in a group, so just set to default.
                end

            end

        end
    end
end

-- Method:          GRM.PlayerHasAlts ( playerTable )
-- What it Does:    Returns true if the player has alts
-- Purpose:         Cleaner code. Easier to call this.
GRM.PlayerHasAlts = function ( player )
    local result = false;

    if player and player.altGroup ~= "" then
        
        if GRM_Alts[GRM_G.guildName][player.altGroup] ~= nil then
            if #GRM_Alts[GRM_G.guildName][player.altGroup] > 1 then     -- Since they will be on their own list, even if just a main, then
                result = true;
            end

        end
    end

    return result;
end

-- Method:          GRM.LeftPlayerHasAlts ( playerTable )
-- What it Does:    Checks if the player had alts at the time they left the guild
-- Purpose:         Useful to check before doing a lot of computational work, and since the altGroup no longer applies upon leaving the guild, a record of their alts when in the guild is stored...
GRM.LeftPlayerHasAlts = function ( player )
    local result = false;

    if player and #player.altsAtTimeOfLeaving > 0 then
        result = true;
    end

    return result;
end

-- Method:          GRM.GetNumAlts ( string , table )
-- What it Does:    Returns the number of alts a player has
-- Purpose:         Useful to know to save time on parsing through tables needlessly.
GRM.GetNumAlts = function ( groupID , altData )
    local result = 0;
    local alts = altData or GRM_Alts[GRM_G.guildName];

    if groupID ~= "" and alts[groupID] then
        result = #alts[groupID] - 1; -- minues 1 for the player's own self.
    end

    return result;
end

-- Method:          GRM.GetAltsGroup ( string )
-- What it Does:    Returns the alt grouping table if a given groupID
-- Purpose:         Easy lookup
GRM.GetAltsGroup = function ( altGroupID )

    if altGroupID and altGroupID ~= "" and GRM_Alts[GRM_G.guildName][altGroupID] then
        return GRM_Alts[GRM_G.guildName][altGroupID];
    else
        return {};
    end
end

-- Method:          GRM.GetListOfAlts ( playerTable , bool , table )
-- What it Does:    Returns the list of all of the alts from the alt Grouping, not including the player's own self, as well as their class Name
-- Purpose:         Useful to UI function easy lookup
GRM.GetListOfAlts = function ( player , includeGUID , syncTable )
    local names = {};
    local mainName;
    local altData = syncTable or GRM_Alts[GRM_G.guildName]; -- Sync has a copied table that is static during sync, so to use this function during sync we don't want it to check the live table.

    if player.altGroup ~= "" then
        for i = 1 , #altData[player.altGroup] do
            if altData[player.altGroup][i].name ~= player.name then

                local p = GRM.GetPlayer ( altData[player.altGroup][i].name );
                if not includeGUID or ( includeGUID and not p ) then
                    table.insert ( names , { altData[player.altGroup][i].name , altData[player.altGroup][i].class , altData[player.altGroup].timeModified } );
                else
                    table.insert ( names , { altData[player.altGroup][i].name , altData[player.altGroup][i].class , p.GUID , altData[player.altGroup].timeModified } );
                end
            end
        end

        mainName = altData[player.altGroup].main;

    end

    return names , mainName;
end

-- Method:          GRM.GetAlts ( playerTable )
-- What it Does:    Returns all of the player alts if there are any
-- Purpose:         Allow to obtain just the list of alts without any other data 
GRM.GetAlts = function ( player , altData )
    local names = {};
    altData = altData or GRM_Alts[GRM_G.guildName];
    
    if altData and player and player.altGroup ~= "" then
        for i = 1 , #altData[player.altGroup] do
            if altData[player.altGroup][i].name ~= player.name then
                table.insert ( names , altData[player.altGroup][i].name );
            end
        end
    end

    sort ( names );

    return names;
end

-- Method:          GRM.GetMainName ( string )
-- What it Does:    Returns the main name of the given alt from the alt grouping, or returns "" if none is established for the given player.
-- Purpose:         To have a cleaner, simpler way of obtaining the main name.
GRM.GetMainName = function ( fullName , includeParentheses )
    local player = GRM.GetPlayer ( fullName );
    local playerHasAlts = false;
    local main = "";

    if not player then
        player = GRM.GetFormerPlayer ( fullName );
        if player then
            if #player.altsAtTimeOfLeaving > 0 then
                playerHasAlts = true;
            end
            if #player.mainAtTimeOfLeaving > 0 then
                main = player.mainAtTimeOfLeaving[1];
            end
        end
    else
        playerHasAlts = GRM.PlayerHasAlts ( player );
        if player.altGroup ~= "" then
            main = GRM_Alts[GRM_G.guildName][player.altGroup].main;
        end
    end

    if main ~= "" and includeParentheses then
        main = "(" .. main .. ")";
    end

    return main , playerHasAlts;
end

-- Method:          GRM.AddAlt ( string, string , bool , int )
-- What it Does:    Adds a player to the alt grouping
-- Purpose:         Alt group management.
GRM.AddAlt = function ( playerName , altName , isSync , syncTimeStamp )
    
    local addToAltsGroup = false;

    if not playerName then
        return;
    end
    
    if playerName == altName then
        if not isSync then
            GRM.Report ( GRM.L ( "{name} cannot become their own alt!" , GRM.FormatName ( playerName ) ) );
        end

    else
        local player = GRM.GetPlayer ( playerName );
        local alt = GRM.GetPlayer ( altName );
        local classMain , classAlt = "" , "";
        local timeOfChange = syncTimeStamp or time();
        
        -- Method:          Adding alt to the player grouping
        -- This means:      Player has no alts, but the alt is already part of an alt group...
        local addToAltGroup = function( addToAltsG )

            local memberToAdd = player;
            local groupID = alt.altGroup;

            if not addToAltsG then
                memberToAdd = alt;
                groupID = player.altGroup;
            end

            -- Ok, remove the player's main status and group as needed, since they don't have any alts.
            if memberToAdd.isMain then
                -- Since player is the main already, we are going to drop the alt's main status
                memberToAdd.isMain = false;
                memberToAdd.mainStatusChangeTime = timeOfChange

                if memberToAdd.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                end

            end

            GRM.RemoveAlt ( memberToAdd.name , isSync , timeOfChange );

            -- Set new altGroup ID 
            memberToAdd.altGroup = groupID;
            memberToAdd.altGroupModified = timeOfChange;
            GRM.UpdateAltGroupModifiedTime ( groupID , timeOfChange );

            table.insert ( GRM_Alts[GRM_G.guildName][memberToAdd.altGroup] , {} );
            GRM_Alts[GRM_G.guildName][memberToAdd.altGroup][#GRM_Alts[GRM_G.guildName][memberToAdd.altGroup]].name = memberToAdd.name;
            GRM_Alts[GRM_G.guildName][memberToAdd.altGroup][#GRM_Alts[GRM_G.guildName][memberToAdd.altGroup]].class = memberToAdd.class;
            GRM_Alts[GRM_G.guildName][memberToAdd.altGroup].timeModified = timeOfChange;
            sort ( GRM_Alts[GRM_G.guildName][memberToAdd.altGroup] , function ( a , b ) return a.name < b.name end );
        end
        -- END FUNCTION

        -- Error Protection check
        if alt and player then
            classMain = player.class;
            classAlt = alt.class;

        else
            if not isSync then
                GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Failed to add alt for unknown reason. Try closing Roster window and retrying!" ) );
            end
            return
        end

        if player.altGroup ~= "" and player.altGroup == alt.altGroup then
            if not isSync then
                GRM.Report ( GRM.L ( "{name} is Already Listed as an Alt." , GRM.FormatName ( altName ) ) );
            end
            return
        end

        -- Now we check status of the groups - which format is the add alt request:
        --      Both have groups they are already in.
        --      Player has a group but the alt adding to does not
        --      Player doesn't have a group but the alt DOES

        -- Let's start with checking who has alts, because if they do, they are already in a group
        if GRM.PlayerHasAlts ( alt ) then
            -- Ok, they alt we want to add has its own group already.
            
            -- Do both have agroups? Let's check the player
            if GRM.PlayerHasAlts ( player ) then

                -- They both have alt groups it seems, so let's remove the alt from the group, and add to player's
                -- First, remove from alt's own list.
                -- Before we do that, remove any main status that might exist.
                alt.isMain = false;
                alt.mainStatusChangeTime = timeOfChange
                GRM.RemoveAlt ( alt.name , true , timeOfChange )

                -- Then, we add to the new list and set the change times
                alt.altGroup = player.altGroup;
                alt.altGroupModified = timeOfChange;
                GRM.UpdateAltGroupModifiedTime ( player.altGroup , timeOfChange );
                
                table.insert ( GRM_Alts[GRM_G.guildName][alt.altGroup] , {} );
                GRM_Alts[GRM_G.guildName][alt.altGroup][#GRM_Alts[GRM_G.guildName][alt.altGroup]].name = alt.name;
                GRM_Alts[GRM_G.guildName][alt.altGroup][#GRM_Alts[GRM_G.guildName][alt.altGroup]].class = alt.class;
                GRM_Alts[GRM_G.guildName][alt.altGroup].timeModified = timeOfChange;
                
                sort ( GRM_Alts[GRM_G.guildName][alt.altGroup] , function ( a , b ) return a.name < b.name end );
        
                if alt.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();

                    if GRM_Alts[GRM_G.guildName][alt.altGroup].main ~= "" then
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                    else
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Hide();
                    end
                end

            else
                -- Only the alt has a group... so let's add the player to the alt group
                -- Still need to determine if player is main - and if so, logic to check if alt is main as well...
                addToAltGroup( true );
                addToAltsGroup = true;

            end

        elseif GRM.PlayerHasAlts ( player ) then
            -- Player has alts, alt does not, so let's add the alt to the player
            addToAltGroup( false );
            addToAltsGroup = false;
        
        else
            -- NEITHER HAVE ALTS

            -- Alt is a main - is the player too?
            if alt.isMain then

                -- Player is main?
                if player.isMain then
                    -- Since player AND alt are main, we are going to keep player's status and remove the alt's main status.
                    alt.isMain = false;
                    GRM_Alts[GRM_G.guildName][alt.altGroup] = nil;
                    alt.altGroup = player.altGroup;
                    alt.mainStatusChangeTime = timeOfChange;
                    GRM.UpdateAltGroupModifiedTime ( player.altGroup , timeOfChange );

                    table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].name = alt.name;
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].class = alt.class;
                    GRM_Alts[GRM_G.guildName][player.altGroup].timeModified = timeOfChange;

                    sort ( GRM_Alts[GRM_G.guildName][player.altGroup] , function ( a , b ) return a.name < b.name end );

                    if alt.name == GRM_G.currentName then
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                    end


                else
                    -- Since alt IS a main, but the player isn't, we are going to join the player to the alt's group
                    player.altGroup = alt.altGroup;
                    player.altGroupModified = timeOfChange;
                    GRM.UpdateAltGroupModifiedTime ( player.altGroup , timeOfChange );

                    table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].name = player.name;
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].class = player.class;
                    GRM_Alts[GRM_G.guildName][player.altGroup].timeModified = timeOfChange;

                    sort ( GRM_Alts[GRM_G.guildName][player.altGroup] , function ( a , b ) return a.name < b.name end );
                end

            else
                -- alt has no alts and isn't main, thus no alt group

                -- Let's see if player already has an altGroup
                if not player.isMain then
                    player.altGroup = GRM.CreateNewAltGroupID();
                    GRM_Alts[GRM_G.guildName][player.altGroup] = {};
                    GRM_Alts[GRM_G.guildName][player.altGroup].main = "";

                    -- Add player to the group - only need to add if creating a new group, otherwise if player is a main they are already in the grouping.
                    table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].name = player.name;
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].class = player.class;
                    GRM_Alts[GRM_G.guildName][player.altGroup].timeModified = timeOfChange;

                    player.altGroupModified = timeOfChange;
                end

                alt.altGroup = player.altGroup;
                alt.altGroupModified = timeOfChange
                GRM.UpdateAltGroupModifiedTime ( player.altGroup , timeOfChange );

                -- Now, add the alt to the group
                table.insert ( GRM_Alts[GRM_G.guildName][alt.altGroup] , {} );
                GRM_Alts[GRM_G.guildName][alt.altGroup][#GRM_Alts[GRM_G.guildName][alt.altGroup]].name = alt.name;
                GRM_Alts[GRM_G.guildName][alt.altGroup][#GRM_Alts[GRM_G.guildName][alt.altGroup]].class = alt.class;
                GRM_Alts[GRM_G.guildName][alt.altGroup].timeModified = timeOfChange;

                sort ( GRM_Alts[GRM_G.guildName][alt.altGroup] , function ( a , b ) return a.name < b.name end );
            end
        end

        -- LIVE UPDATE THE FRAMES
        if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

            if GRM.GetPlayer ( GRM_G.currentName ).altGroup == alt.altGroup then
                GRM.PopulateAltFrames ( GRM_G.currentName );
            end
        end

    end

    return addToAltsGroup;
end

-- Method:          GRM.AddRejoinToAltGroup ( playerTable , bool )
-- What it Does:    Using the stored player information when someone leaves the guild, it checks their alt group and adds them back to it.
-- Purpose:         One less thing to do manually if you jokingly kick someone or someone returns.
GRM.AddRejoinToAltGroup = function ( player , isTransfer )

    local added = false;

    if player and #player.altsAtTimeOfLeaving > 0 then

        local alts = player.altsAtTimeOfLeaving;
        local guildData = GRM.GetGuild();

        for i = 1 , #alts do

            for _ , p in pairs ( guildData ) do
                if type (p) == "table" then

                    if p.GUID == alts[i][3] or ( isTransfer and p.name == alts[i][1] and p.class == alts[i][2] ) then
                        GRM.AddAlt ( p.name , player.name , true );
                        added = true;
                        break;
                    end
                    
                end
            end

            if added then
                break;
            end

        end

    end

    player.altsAtTimeOfLeaving = {};    -- No need to carry this info now that they have rejoined.

    return added;
end

-- Method:          GRM.RemoveAlt (string , boolean , int )
-- What it Does:    Detags the given altName to that set of toons.
-- Purpose:         Alt management, so whoever has addon installed can tag player as alts and mains and manipulate easily.
GRM.RemoveAlt = function ( playerName , isSync , epochTime )

    local timestamp = time();

    if not playerName then
        return;
    end

    local player = GRM.GetPlayer ( playerName );

    if player and player.altGroup ~= "" then

        if isSync then
            timestamp = epochTime;
        end

        local needsRefresh = false;

        -- Ok, remove him from the grouping...
        for i = 1 , #GRM_Alts[GRM_G.guildName][player.altGroup] do
            if GRM_Alts[GRM_G.guildName][player.altGroup][i].name == player.name then
                table.remove ( GRM_Alts[GRM_G.guildName][player.altGroup] , i );
                player.altGroupModified = timestamp;
                break;
            end
        end

        if GRM_Alts[GRM_G.guildName][player.altGroup].main == player.name then
            GRM_Alts[GRM_G.guildName][player.altGroup].main = "";
        end
        
        -- Check if no players left in the grouping, and if so, clear it from existence.
        if #GRM_Alts[GRM_G.guildName][player.altGroup] < 2 then 
            
            -- no main left, with only one person means to disband the group
            if #GRM_Alts[GRM_G.guildName][player.altGroup] == 1 and GRM_Alts[GRM_G.guildName][player.altGroup].main == "" then

                local p = GRM.GetPlayer ( GRM_Alts[GRM_G.guildName][player.altGroup][1].name );
                if p then

                    p.altGroup = "";
                    p.altGroupModified = timestamp;

                    if GRM_Alts[GRM_G.guildName][player.altGroup][1].name == GRM_G.currentName then
                        needsRefresh = true;
                    end
                end
                GRM_Alts[GRM_G.guildName][player.altGroup] = nil;
            elseif #GRM_Alts[GRM_G.guildName][player.altGroup] == 0 then
                GRM_Alts[GRM_G.guildName][player.altGroup] = nil;
            end

        else
            GRM.UpdateAltGroupModifiedTime ( player.altGroup , timestamp );
        end

        if not needsRefresh and player.altGroup == GRM.GetPlayerAltGroupID ( GRM_G.currentName ) then
            needsRefresh = true;
        end

        -- Now, if the player WAS a main, let's set him to main in his own solo group.
        if player.isMain then
            player.altGroup = GRM.CreateNewAltGroupID();
            GRM_Alts[GRM_G.guildName][player.altGroup] = {};
            GRM_Alts[GRM_G.guildName][player.altGroup].main = player.name;

            GRM_Alts[GRM_G.guildName][player.altGroup][1] = {};
            GRM_Alts[GRM_G.guildName][player.altGroup][1].name = player.name;
            GRM_Alts[GRM_G.guildName][player.altGroup][1].class = player.class;
            GRM_Alts[GRM_G.guildName][player.altGroup].timeModified = timestamp;

        else
            player.altGroup = "";
        end

        player.altGroupModified = timestamp;

        -- LIVE FRAMES UPDATE
        if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and needsRefresh then

            GRM.PopulateAltFrames ( GRM_G.currentName );
        end
    end

end

-- Method:          GRM.UpdateAltGroupModifiedTime ( string , int )
-- What it Does:    Modifies the modified time for all alts that were in the grouping when the alt group changes in any way
-- Purpose:         For syncing, to ensure the current timestamp is most accurate.
GRM.UpdateAltGroupModifiedTime = function ( altGroup , timestamp )

    if altGroup ~= "" and GRM_Alts[GRM_G.guildName][altGroup] then
        GRM_Alts[GRM_G.guildName][altGroup].timeModified = timestamp;

        if GRM_Alts[GRM_G.guildName][altGroup] then
            for i = 1 , #GRM_Alts[GRM_G.guildName][altGroup] do
                GRM.GetPlayer ( GRM_Alts[GRM_G.guildName][altGroup][i].name ).altGroupModified = timestamp;
            end
        end
    end
end

-- Method:          GRM.AddPlayerToOwnAltList()
-- What it Does:    For the first time a player logs on that toon, or joins a guild with that toon, it adds them to their own alt list.
-- Purpose:         For easy alt management. AUTO adds alt info for a guild :D
GRM.AddPlayerToOwnAltList = function()
    -- Ok, now let's add the player to an alt list...
    -- First, find the player in member save and determine if they are the main, if not, check his alt list, determine who is main.
    -- if no main, first person on list can add.
    -- if main, then main will add this player.
    local player = GRM.GetPlayer ( GRM_G.addonUser );

    if player then
        -- Ok, adding the player!
        local officialToons = GRM.GetAddOnUserGuildAlts();
        officialToons[GRM_G.addonUser] = { false };

        -- if the player already is on a list, let's not add them automatically.
        if player.altGroup == "" then
            -- Ok, good, let's check the alt list!

            if GRM.GetNumKeyedEntries ( officialToons ) > 1 then    -- No need if it is just myself - if number of entries == 1 then it is just me
                -- Ok great, there is already another player in the guild! Let's put them into the same alt grouping!

                local isAdded = false;

                for altName in pairs ( officialToons ) do
                    -- Make sure it is not the player.

                    player = GRM.GetPlayer ( altName );
                    if altName ~= GRM_G.addonUser and player then

                        if player.isMain then
                            -- ADD ALT HERE!!!!!!
                            local addToAltsGroup = GRM.AddAlt ( GRM_G.addonUser , altName , false , time() );
                            GRM.SyncBirthdayWithNewAlt ( GRM_G.addonUser , altName , addToAltsGroup );
                            isAdded = true;
                            break;
                        end

                    end
                end

                -- if it was not added, then add it here! No alt was set as main.
                if not isAdded then
                    for altName in pairs ( officialToons ) do
                        -- Make sure it is not the player.
                        if altName ~= GRM_G.addonUser then
                            local addToAltsGroup = GRM.AddAlt ( GRM_G.addonUser , altName , false , time() );
                            GRM.SyncBirthdayWithNewAlt ( GRM_G.addonUser , altName , addToAltsGroup );
                            break;
                        end
                    end
                end
            end
        end
    else
        -- Player was just invited, and his metadata details have not been populated as of yet. Let's retry in a moment.
        C_Timer.After ( 5 , function()
            GRM.AddPlayerToOwnAltList();
        end);
    end

end

-- Method:          GRM.CheckIfNeedToAddAlt()
-- What it Does:    Lets you know if the player is already on the list of alts, and returns the position of the guild in the table as well.
-- Purpose:         For alt auto-tagging for the addon.
GRM.CheckIfNeedToAddAlt = function()
    local result = true;
    local officialToons = GRM.GetAddOnUserGuildAlts();
    
    if officialToons ~= nil and officialToons[GRM_G.addonUser] ~= nil then
        result = false;
    end

    return result;
end

-- Method:          GRM.SetBirthdayForAltGrouping ( string , int , int , int , string , int )
-- What it Does:    Sets all of the alts to the same birthday as well when there is a modification
-- Purpose:         Ensure birthdays are set for all alts, as it is assumed it is one player
GRM.SetBirthdayForAltGrouping = function ( playerName , day , month , year , date , timeStamp )
    local player = GRM.GetPlayer ( playerName );
    local tempAlt;

    if player and GRM.PlayerHasAlts ( player ) then
        local alts = GRM.GetListOfAlts ( player );
        for i = 1 , #alts do

            tempAlt = GRM.GetPlayer ( alts[i][1] );
            if tempAlt then
                -- Alt found!
                tempAlt.events[2][1] = { day , month , year };
                tempAlt.events[2][2] = false;
                tempAlt.events[2][3] = date;
                tempAlt.events[2][4] = timeStamp;

                if tempAlt.birthdayUnknown then
                    tempAlt.birthdayUnknown = false
                end

                GRM.RemoveFromCalendarQue ( tempAlt.name , 2 , nil );

                -- Update frames if looking at them on the spot...
                if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and tempAlt.name == GRM_G.currentName and GRM.S().showBDay then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailBirthdayButton:Hide();
                    GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:SetText ( GRM.FormatTimeStamp ( date , false , true ) );
                    GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:Show();
                end
            end
        end
    end
end

-- Method:          GRM.ResetBirthdayForAltGroup ( string , boolean , int , string )
-- What it Does:    Resets the birthdays for the player and all the alts connected in the group
-- Purpose:         Birthday is universal of an alt grouping... keeps them together.
-- Note:            It does leave a timstamp of the change so that you will not resync the player data again from other players, if you wanted to remove the bday.
--                  This is a unique removal to just yourself.
GRM.ResetBirthdayForAltGroup = function ( name , isLiveSync , num , sender , isUnknown )

    local player = GRM.GetPlayer ( name );

    if player then

        -- First, change the given player's data and reset it
        local timestamp = num;
        local tempAlt;
        if timestamp == 0 then
            timestamp = time();
        end

        local updateUI = function ( textName )
            if not isUnknown and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == textName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailBirthdayButton:Show();
                GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:Hide();
            end
        end

        player.events[2] = { { 0 , 0 , 0 } , false , "" , timestamp };
        if not isUnknown then
            player.birthdayUnknown = false;
        end

        updateUI ( name );
        GRM.RemoveFromCalendarQue ( player.name , 2 , nil );

        local alts = GRM.GetListOfAlts ( player );

        for i = 1 , #alts do
            tempAlt = GRM.GetPlayer ( alts[i][1] );
            if tempAlt then
                tempAlt.events[2] = { { 0 , 0 , 0 } , false , "" , timestamp };
                GRM.RemoveFromCalendarQue ( tempAlt.name , 2 , nil );

                if not isUnknown then
                    tempAlt.birthdayUnknown = false;
                else
                    tempAlt.birthdayUnknown = true;
                end

                updateUI ( alts[i][1] );
            end
        end

        -- No need to run this
        if not isLiveSync then
            if GRM.S().syncBDays and GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().syncRank;
                if GRM.S().exportAllRanks then
                    syncRankFilter = GuildControlGetNumRanks() - 1;
                end
                GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_BDAYREM?" .. syncRankFilter .. "?" .. name .. "?" .. tostring ( timestamp ) , "GUILD" );
            end
        else
            GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
            GRMsyncGlobals.updatesEach[6] = GRMsyncGlobals.updatesEach[6] + 1;
        -- elseif not isUnknown then
            -- if GRM.S().syncChatEnabled then
            --     if #alts > 0 then
            --         GRM.Report ( GRM.L ( "{name}'s alt grouping has had their Birthday removed by: {name2}" , GRM.GetClassifiedName ( name , true ) , GRM.GetClassifiedName ( sender , true ) ) );
            --     else
            --         GRM.Report ( GRM.L ( "{name}'s Birthday has been removed by: {name2}" , GRM.GetClassifiedName ( name , true ) , GRM.GetClassifiedName ( sender , true ) ) );
            --     end
            -- end                
        end

        if not isUnknown and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == name then
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailBirthdayButton:Show();
            GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:Hide();
        end

    end
end

-- Method:          GRM.SyncBirthdayWithNewAlt ( string , string , boolean )
-- What it Does:    Sets the new alt to the same birthday as the previous alts
-- Purpose:         Keep alts all in sync on the birthday.
GRM.SyncBirthdayWithNewAlt = function ( name , newAlt , useAlt )
    local player = {};
    local tempAlt;
    local needToRemoveFromQue = false;

    if useAlt then
        player = GRM.GetPlayer ( newAlt );
    else
        player = GRM.GetPlayer ( name );
    end

    if player and GRM.PlayerHasAlts ( player ) then  -- Validate player found in databse AND player has alts.
        local alts = GRM.GetListOfAlts ( player , false );

        for i = 1 , #alts do
            tempAlt = GRM.GetPlayer ( alts[i][1] );

            needToRemoveFromQue = false;

            if tempAlt.events[2][1] ~= player.events[2][1] then
                needToRemoveFromQue = true;
                tempAlt.events[2][1] = player.events[2][1];
            end
            if tempAlt.events[2][2] ~= player.events[2][2] then
                needToRemoveFromQue = true;
                tempAlt.events[2][2] = player.events[2][2];
            end
            if tempAlt.events[2][3] ~= player.events[2][3] then
                needToRemoveFromQue = true;
                tempAlt.events[2][3] = player.events[2][3];
            end
            if tempAlt.events[2][4] ~= player.events[2][4] then
                needToRemoveFromQue = true;
                tempAlt.events[2][4] = player.events[2][4];
            end

            if needToRemoveFromQue then
                if tempAlt.birthdayUnknown then
                    tempAlt.birthdayUnknown = false
                end
                GRM.RemoveFromCalendarQue ( tempAlt.name , 2 , nil );
            end

            -- Update frames if looking at them on the spot...
            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and name == GRM_G.currentName and GRM.S().showBDay and tempAlt.events[2][3] ~= "" then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailBirthdayButton:Hide();
                GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:SetText ( GRM.FormatTimeStamp ( tempAlt.events[2][3] , false , true ) );
                GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:Show();
            end

            if GRM_UI.GRM_RosterChangeLogFrame.GRM_EventsFrame:IsVisible() then
                GRM.RefreshAddEventFrame()
            end
        end
    end
end

-- Method:              GRM.SetMain ( string , int )
-- What it Does:        Sets the player as main, as well as updates that status among the alt grouping.
-- Purpose:             Main/alt management control.
GRM.SetMain = function ( mainName , timestamp )
    if not mainName or GRM_G.guildName == "" then
        return;
    end

    local player = GRM.GetPlayer ( mainName );
    local timeS = timestamp or time();

    -- Protectection in case they join and then immediately quit
    if player then

        if timeS > player.mainStatusChangeTime then

            -- if player is in a group or not
            player.isMain = true;
            player.mainStatusChangeTime = timeS;

            if player.name == GRM_G.currentName and GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
            end
            
            if player.altGroup ~= "" then

                -- Set old main to NOT alt.
                local p = GRM.GetPlayer ( GRM_Alts[GRM_G.guildName][player.altGroup].main );
                if GRM_Alts[GRM_G.guildName][player.altGroup].main ~= "" and GRM_Alts[GRM_G.guildName][player.altGroup].main ~= player.name and p then

                    p.isMain = false;
                    p.mainStatusChangeTime = timeS;

                    if GRM_Alts[GRM_G.guildName][player.altGroup].main == GRM_G.currentName and GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible()  then
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                    end

                end

                GRM_Alts[GRM_G.guildName][player.altGroup].main = player.name;

            else
                -- No group, no one set as main. Let's create a new group
                player.altGroup = GRM.CreateNewAltGroupID();
                GRM_Alts[GRM_G.guildName][player.altGroup] = {};
                GRM_Alts[GRM_G.guildName][player.altGroup].main = player.name;
                
                table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
                GRM_Alts[GRM_G.guildName][player.altGroup][1].name = player.name;
                GRM_Alts[GRM_G.guildName][player.altGroup][1].class = player.class;
                GRM_Alts[GRM_G.guildName][player.altGroup].timeModified = 0; -- Alt group not truly modified, only setting main.

            end

            -- LIVE FRAMES UPDATE
            if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

                if player.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Show();
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Hide();
                end

                if GRM.GetPlayer ( GRM_G.currentName ).altGroup == player.altGroup then
                    GRM.PopulateAltFrames ( GRM_G.currentName );
                end
            end
        end
    end

end

-- Method:              GRM.DemoteFromMain ( string , string )
-- What it Does:        If the player is "main" then it removes the main tag to false
-- Purpose:             User Experience (UX) and alt management!
GRM.DemoteFromMain = function ( mainName , timestamp )

    if not mainName or GRM_G.guildName == "" then
        return;
    end

    local player = GRM.GetPlayer ( mainName );
    local timeS = timestamp or time();
    
    if player then

        player.isMain = false;
        player.mainStatusChangeTime = timestamp;

        if player.altGroup ~= "" then

            if #GRM_Alts[GRM_G.guildName][player.altGroup] == 1 then
                -- Just 1, since no longer a main, let's purge this.
                GRM_Alts[GRM_G.guildName][player.altGroup] = nil;
                player.altGroup = "";

            elseif GRM_Alts[GRM_G.guildName][player.altGroup].main == player.name then
                GRM_Alts[GRM_G.guildName][player.altGroup].main = "";

                if player.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                end
            end
        end

            -- LIVE FRAMES UPDATE
        if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

            if player.name == GRM_G.currentName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
            end

            if GRM.GetPlayer ( GRM_G.currentName ).altGroup == player.altGroup then
                GRM.PopulateAltFrames ( GRM_G.currentName );
            end
        end
    end
end

-- Method:          GRM.GetAltTag ( int )
-- What it Does:    Returns the hex value/colored string with the alt or main tag
-- Purpose:         For taggin the autocomplete names to make it easier to see who is and isn't and alt/main
GRM.GetAltTag = function ( value )
    local result = "";
    local mainDisplay = GRM.GetMainTags ( false , GRM.S().mainTagIndex );
    local altDisplay = GRM.GetAltTags ( false , GRM.S().mainTagIndex );
    if value == 1 then
        result = "|cffab0000 " .. mainDisplay;
    elseif value == 2 then
        result = "|cffab0000 " .. altDisplay;
    end
    return result;
end

-- Method:          GRM.AddAltAutoComplete()
-- What it Does:    Takes the entire list of guildies, then sorts them as player types to be added to alts list
-- Purpose:         Eliminates the possibility of a person entering a fake name of a player no longer in the guild.
GRM.AddAltAutoComplete = function()
    local partName = GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:GetText();
    local tag = 0;
    local players = {};

    for _ , player in pairs ( GRM.GetGuild() ) do
        if type ( player ) == "table" then
            if player.name ~= GRM_G.currentName then   -- no need to go through player's own window
                -- Determine alt/main tag
                tag = 0;
                -- 0 = no tag, 1 = main, 2 = alt
                if player.isMain then
                    tag = 1;
                elseif GRM.PlayerHasAlts ( player ) then
                    tag = 2;
                end

                table.insert ( players , { player.name , player.class , tag } );
            end
        end
    end
    -- Need to sort "Complex" table
    sort ( players , function ( a , b ) return a[1] < b[1] end );    -- Alphabetizing it for easier parsing for buttontext updating. - This sorts the first index of the 2D array
    
    -- Now, let's identify the names that match
    local matchingList = GRM.GetAutoCompleteMatches ( players , partName , 30 );
    
    -- Populate the buttons now...
    if partName ~= nil and partName ~= "" then

        if #matchingList > 0 then
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:Hide();
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Hide();
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:Show();
            GRM.BuildAutoCompleteAltSelectionScrollFrame ( matchingList );
            GRM_G.currentHighlightIndex = 1;
            GRM.ResetAutoCompleteHighlights();
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[1][1]:LockHighlight();
        else
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:Show();
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Show();
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:Hide();
            -- Hide the buttons
            if GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons then
                for i = 1 , #GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons do
                    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i][1]:Hide();
                end
            end
            if string.lower ( GRM_G.currentName ) == string.lower ( partName ) then
                GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetText ( GRM.L ( "Player Cannot Add Themselves as an Alt" ) );
                GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Hide();
            else
                GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetText ( GRM.L ( "Player Not Found" ) );
            end
        end          
    else
        if GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons then
            for i = 1 , #GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons do
                GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i][1]:Hide();
            end
        end
        GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:Hide();
        GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetText ( GRM.L ( "Please Type the Name of the alt" ) );
        GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:Show();
        GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Show();
    end
end

-- Method:              GRM.KickAllAlts ( string )
-- What it Does:        Bans all listed alts of the player as well and adds them to the ban list. Of note, addons cannot kick players anymore, so this only adds to ban list.
-- Purpose:             QoL. Option to ban players' alts as well if they are getting banned.
GRM.KickAllAlts = function ( playerName , banReason )
    GRM_G.KickAllAltsTable = {};
    local player = GRM.GetPlayer ( playerName );

    if player then
    -- Ok, let's parse the player's data!
        local tempAlt;
        local instructionNote = GRM.L ( "Reason Banned?" ) .. "\n" .. GRM.L ( "Click \"YES\" When Done" );
        local result = banReason or "";

        if GRM.GetNumAlts ( player.altGroup ) > 0 and ( GRM_G.isChecked2 or GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_BanAllAltsCheckbox:GetChecked() ) then
            local index;
            local listOfAlts = GRM.GetAltsGroup ( player.altGroup );

            for i = 1 , #listOfAlts do
                if listOfAlts[i].name ~= player.name and listOfAlts[i].name ~= GRM_G.addonUser then
                    tempAlt = GRM.GetPlayer ( listOfAlts[i].name );

                    -- The banning...
                    if GRM_G.isChecked or GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_BanAllAltsCheckbox:GetChecked() then
                        tempAlt.bannedInfo[1] = true;
                        tempAlt.bannedInfo[2] = time();
                        tempAlt.bannedInfo[3] = false;
                        tempAlt.bannedInfo[4] = GRM_G.addonUser;

                        if result == "" then
                            if GRM_UI.GRM_MemberDetailPopupEditBox:IsVisible() then
                                result = GRM_UI.GRM_MemberDetailPopupEditBox:GetText();
                            elseif GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanReasonEditBox:IsVisible() then
                                result = GRM.Trim ( GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanReasonEditBox:GetText() );
                            end 
                        end

                        if result ~= nil and result ~= instructionNote and result ~= GRM.L ( "Reason Banned?" ) and result ~= "" then
                            tempAlt.reasonBanned = result;
                        elseif result == nil or result == GRM.L ( "Reason Banned?" ) then
                            tempAlt.reasonBanned = "";
                        else
                            tempAlt.reasonBanned = result;
                        end
                    end

                    -- The kicking...
                    if GRM_G.isChecked2 then

                        table.insert ( GRM_G.KickAllAltsTable , {} );
                        index = #GRM_G.KickAllAltsTable;
                        GRM_G.KickAllAltsTable[index].name = tempAlt.name;
                        GRM_G.KickAllAltsTable[index].class = GRM.GetClassColorRGB ( tempAlt.class );
                        GRM_G.KickAllAltsTable[index].lastOnline = tempAlt.lastOnline;
                        GRM_G.KickAllAltsTable[index].action = GRM.L ( "Kick" );
                        GRM_G.KickAllAltsTable[index].macro = "/gremove";
                        GRM_G.KickAllAltsTable[index].isHighlighted = false;
                        GRM_G.KickAllAltsTable[index].mainName = GRM.GetMainName ( tempAlt , true );
                        GRM_G.KickAllAltsTable[index].customMsg = GRM.L ( "Kicking {name}'s alts" , GRM.SlimName ( playerName ) );
                        
                    end

                end
            end
            if #GRM_G.KickAllAltsTable > 0 then
                -- Bring popup reminder to select it...
                GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Kick macro created. Press \"CTRL-SHIFT-K\" to kick all of {name}'s alts" , GRM.FormatName ( playerName ) ) );
                GRM_G.KickAltControl = true;
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 1;
                if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
                    GRM_UI.GRM_ToolCoreFrame:Show();
                    
                elseif GRM_UI.GRM_ToolCoreFrame:IsVisible() then
                    GRM_UI.RefreshManagementTool( GRM_G.KickAltControl );
                    GRM_G.KickAltControl = false;

                end
            end
        end
    end

    -- Refresh the frames!
    GRM.RefreshSelectHybridFrames ( true , true , true , false );
end

-- Method:          GRM.PopulateAltFrames( string )
-- What it Does:    This generates the alt frames in the main addon metadata detail frame
-- Purpose:         Clean formatting of the alt frames.
GRM.PopulateAltFrames = function ( playerName )
    -- let's start by prepping the frames.
    local player = GRM.GetPlayer ( playerName );
    local alts = GRM.GetListOfAlts ( player );
    local numAlts = #alts;
    local main = "";
    
    if player.altGroup ~= "" then
        main = GRM_Alts[GRM_G.guildName][player.altGroup].main;
    end
    local color = {};

    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:Show();
    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame:Show();
    local scrollHeight = 0;
    local scrollWidth = 170;
    local buffer = 1;

    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons = GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons or {};  -- Create a table for the Buttons.
    -- populating the window correctly.
    for i = 1 , numAlts do
        -- if font string is not created, do so.
        if not GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i] then
            local tempButton = CreateFrame ( "Button" , "GRM_AltAdded" .. i , GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame ); -- Names each Button 1 increment up

            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i] = { tempButton , tempButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ) };
        end

        if i == numAlts and #GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons > numAlts then
            for j = numAlts + 1 , #GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons do
                GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[j][1]:Hide();
            end
        end

        local AltButtons = GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][1];
        local AltButtonsText = GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][2];
        AltButtons:SetSize ( 86.5 , 20 );
        AltButtons:RegisterForClicks( "RightButtonDown" , "LeftButtonDown" );

        -- Check if main
        local name = GRM.SlimName ( alts[i][1] );
        if main ~= "" and alts[i][1] == main then
            name = name .. "\n|cffff0000" .. GRM.L ( "(main)" );
            AltButtonsText:SetWordWrap ( true );
        else
            AltButtonsText:SetWordWrap ( false );
        end
        AltButtonsText:SetText ( name );
        color = GRM.GetClassColorRGB ( alts[i][2] , false );
        AltButtonsText:SetTextColor ( color[1] , color[2] , color[3] , 1.0 );
        AltButtonsText:SetWidth ( 80 );

        if i == 1 and GRM.S().fontModifier > 0 and string.find ( name , GRM.L ( "(main)" ) ) ~= nil then
            AltButtonsText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
        else
            AltButtonsText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
        end
        
        AltButtonsText:SetPoint ( "CENTER" , AltButtons );
        AltButtonsText:SetJustifyH ( "CENTER" );

        -- LogicGRM.RemoveMainAltTags
        AltButtons:SetScript ( "OnClick" , function ( self , button )
            if button == "RightButton" then
                
                -- Parse the button number, so the alt position can be identified...
                local altNum = tonumber ( string.match ( self:GetName() , "%d" ) );
                local isMain = false;

                -- Ok, populate the buttons properly...
                GRM_G.pause = true;
                
                if string.find ( AltButtonsText:GetText() , GRM.L ( "(main)" ) ) == nil then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions.GRM_altSetMainButtonText:SetText ( GRM.L ( "Set as Main" ) );
                    GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions.GRM_altOptionsText:SetText ( AltButtonsText:GetText() );
                else -- player IS the main... place option to Demote From Main rahter than set as main.
                    GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions.GRM_altSetMainButtonText:SetText ( GRM.L ( "Set as Alt" ) );
                    isMain = true;
                    GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions.GRM_altOptionsText:SetText ( string.sub ( AltButtonsText:GetText() , 1 , string.find ( AltButtonsText:GetText() , "\n" ) - 1 ) );
                end

                GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions.GRM_altRemoveButtonText:SetText( GRM.L ( "Remove" ) );

                GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions:ClearAllPoints();
                GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions:SetPoint( "TOPRIGHT" , self , "BOTTOM" );

                GRM_UI.ConfigureAltNamesContextMenuSize();
                GRM_UI.GRM_MemberDetailMetaData.GRM_altDropDownOptions:Show();

                -- Set the Global info now!
                if GRM.GetPlayer ( GRM_G.currentName ) then
                    GRM_G.selectedName = { GRM_G.currentName , tostring ( GRM_G.tempAltName ) , GRM_G.guildName , isMain };
                end

            elseif button == "LeftButton" then
                if not IsShiftKeyDown() then

                    if GRM_G.tempAltName ~= "" then
                        if IsControlKeyDown() then
                            GRM.OpenPlayerWindow( GRM_G.tempAltName );
                        elseif GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailServerNameToolTip:IsVisible() and not GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailNameText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                            -- This makes the main window the alt that was clicked on! TempAltName is saved when mouseover action occurs.
                            GRM.SelectPlayerOnRoster ( GRM_G.tempAltName );
                        end
                    end
                else
                    if GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailNameText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                        GRM_G.tempAltName = GRM_G.currentName;
                    end
                    if GRM_G.tempAltName ~= "" then
                        GRM.GR_Roster_Click ( GRM_G.tempAltName );
                        GRM_G.tempAltName = "";
                    end
                end
            end
        end);
        
        -- Now let's pin it!
        if i == 1 then
            AltButtons:SetPoint( "TOPLEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame , 0 , - 1 );
            scrollHeight = scrollHeight + AltButtons:GetHeight();
        elseif i == 2 then
            AltButtons:SetPoint( "TOPLEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i - 1][1] , "TOPRIGHT" , 1 , 0 );
        else
            AltButtons:SetPoint( "TOPLEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i - 2][1] , "BOTTOMLEFT" , 0 , - buffer );
            if i % 2 ~= 0 then
                scrollHeight = scrollHeight + AltButtons:GetHeight() + buffer;
            end
        end
        AltButtons:Show();
    end

    -- Pin the button
    if numAlts == 0 then
        GRM_UI.GRM_AddAltButton2:ClearAllPoints();
        GRM_UI.GRM_AddAltButton2:SetPoint ( "TOP" , GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame , "TOP" , 0 , - 1 );
    elseif numAlts == 1 then
        GRM_UI.GRM_AddAltButton2:ClearAllPoints();
        GRM_UI.GRM_AddAltButton2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[1][1] , "TOPRIGHT" , 1 , 0 );
    else
        GRM_UI.GRM_AddAltButton2:ClearAllPoints();
        GRM_UI.GRM_AddAltButton2:SetPoint ( "TOP" , GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[numAlts - 1][1] , "BOTTOM" , 0 , - buffer);
        if numAlts % 2 == 0 and numAlts > 12 then
            scrollHeight = scrollHeight + GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[numAlts - 1][1]:GetHeight() + buffer;
        end
    end
    GRM_UI.GRM_AddAltButton2:Show();

    if numAlts > 12 then
        if GRM_UI.GRM_MemberDetailMetaData.GRM_GroupInviteButton:IsVisible() then
            GRM_UI.GRM_MemberDetailMetaData.GRM_SafeFromRulesButton:SetPoint ( "LEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_GroupInviteButton , "RIGHT" , 5 , 0 );
        end
    end

    -- Update the size -- it either grows or it shrinks!
    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame:SetSize ( scrollWidth , scrollHeight );

    --Set Slider Parameters ( has to be done after the above details are placed )
    local scrollMax = ( scrollHeight - GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:GetHeight() ) + ( buffer * .5 );
    if scrollMax < 0 then
        scrollMax = 0;
    end
    
    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetMinMaxValues ( 0 , scrollMax );
    -- Mousewheel Scrolling Logic
    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:EnableMouseWheel( true );
    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:SetScript( "OnMouseWheel" , function( _ , delta )
        local current = GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:GetValue();
        
        if IsShiftKeyDown() and delta > 0 then
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( 0 );
        elseif IsShiftKeyDown() and delta < 0 then
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( scrollMax );
        elseif delta < 0 and current < scrollMax then
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( current + 20 );
        elseif delta > 0 and current > 1 then
            GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( current - 20 );
        end
    end);

    if GRM.PlayerOrAltHasJD ( GRM_G.currentName ) then
        if GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailJoinDateButton:IsVisible() then
            GRM_UI.GRM_MemberDetailMetaData.GRM_SyncDateArrowButton:ClearAllPoints();
            GRM_UI.GRM_MemberDetailMetaData.GRM_SyncDateArrowButton:SetPoint ( "LEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailJoinDateButton , "RIGHT" , 0 , 0 );
        elseif GRM_UI.GRM_MemberDetailMetaData.GRM_JoinDateText:IsVisible() then
            GRM_UI.GRM_MemberDetailMetaData.GRM_SyncDateArrowButton:ClearAllPoints();
            GRM_UI.GRM_MemberDetailMetaData.GRM_SyncDateArrowButton:SetPoint ( "LEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_JoinDateText , "RIGHT" , 8 , -0.5 );
        end
        GRM_UI.GRM_MemberDetailMetaData.GRM_SyncDateArrowButton:Show();
    else
        GRM_UI.GRM_MemberDetailMetaData.GRM_SyncDateArrowButton:Hide();
    end
    
    GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame:Show();
end

-- Method:          GRM.GetSortedAltNamesWithDetails ( string )
-- What it Does:    Returns the alt grouping of the player, with their own name, the player details, as well as main sorted as index 1.
-- Purpose:         Mainly for use with the alt groupings window on mouseover of the player alts on core popup window.
GRM.GetSortedAltNamesWithDetails = function ( playerName )
    local finalList = {};
    local type = GRM_G.altDetailsControl[1];
    local descending = GRM_G.altDetailsControl[2];
    local isAdded = false;
    local player = GRM.GetPlayer ( playerName );
    local playerDetails;
    local tempAlt = {};

    if player and GRM.PlayerHasAlts ( player ) then
        local alts = GRM.GetListOfAlts ( player );
        local numAlts = #alts - 1;

        -- Build the list of alts.
        for r = 1 , #alts do
            tempAlt = GRM.GetPlayer ( alts[r][1] )

            if tempAlt then
                
                playerDetails = { tempAlt.name , tempAlt.level , tempAlt.class , tempAlt.rankIndex , tempAlt.isMain , tempAlt.lastOnline , tempAlt.joinDateHist[1][4], GRM.GetTimestampOfLastRankChange ( tempAlt ) , tempAlt.isOnline };
                
                -- Alphabetical
                if type == 1 then
                    -- Add the alt to the list
                    table.insert ( finalList , 1 , playerDetails );
                    if r == #alts then
                        if descending then
                            sort ( finalList , function ( a , b ) return a[1] < b[1] end );     -- Sorts complex table with first index alphabetically with score ranking
                        else
                            sort ( finalList , function ( a , b ) return b[1] < a[1] end );     -- Sorts complex table with first index alphabetically with score ranking
                        end
                    end
                
                    -- By Time
                elseif type == 2 then
                    if #finalList == 0 then
                        table.insert ( finalList , playerDetails );
                    else
                        -- Now, need to scan through the list to see what we have
                        isAdded = false;
                        for j = 1 , #finalList do
                            if descending then
                                if playerDetails[6] < finalList[j][6] then
                                    table.insert ( finalList , j , playerDetails );
                                    isAdded = true;
                                    break;
                                end
                            else
                                if playerDetails[6] > finalList[j][6] then
                                    table.insert ( finalList , j , playerDetails );
                                    isAdded = true;
                                    break;
                                end
                            end
                        end
                        if not isAdded then
                            table.insert ( finalList , playerDetails ); -- Just add it to the end
                        end
                    end

                    -- by Level
                elseif type == 3 then

                    if #finalList == 0 then
                        table.insert ( finalList , playerDetails );
                    else
                        -- Now, need to scan through the list to see what we have
                        isAdded = false;
                        for j = 1 , #finalList do
                            if descending then
                                if playerDetails[2] > finalList[j][2] then
                                    table.insert ( finalList , j , playerDetails );
                                    isAdded = true;
                                    break;
                                end
                            else
                                if playerDetails[2] < finalList[j][2] then
                                    table.insert ( finalList , j , playerDetails );
                                    isAdded = true;
                                    break;
                                end
                            end
                        end
                        if not isAdded then
                            table.insert ( finalList , playerDetails ); -- Just add it to the end
                        end
                    end

                    -- by Rank
                elseif type == 4 then
                    if #finalList == 0 then
                        table.insert ( finalList , playerDetails );
                    else
                        -- Now, need to scan through the list to see what we have
                        isAdded = false;
                        for j = 1 , #finalList do
                            if descending then
                                if playerDetails[4] < finalList[j][4] then
                                    table.insert ( finalList , j , playerDetails );
                                    isAdded = true;
                                    break;
                                end
                            else
                                if playerDetails[4] > finalList[j][4] then
                                    table.insert ( finalList , j , playerDetails );
                                    isAdded = true;
                                    break;
                                end
                            end
                        end
                        if not isAdded then
                            table.insert ( finalList , playerDetails ); -- Just add it to the end
                        end
                    end
                end
            end
        end
    end
    return finalList;
end

-- Method:          GRM.IsAnyAltActive ( table , int)
-- What it Does:    Returns true if at least one of the alts is active
-- Purpose:         No need to announce inactive return if it is just an old alt...
GRM.IsAnyAltActive = function ( listOfAlts , hours )
    local result = false;
    local inactiveHours = hours or GRM.S().inactiveHours;
    local player;

    for i = 1 , #listOfAlts do

        player = GRM.GetPlayer ( listOfAlts[i][1] );

        if player then
            if player.lastOnline < inactiveHours then
                result = true;
                break;
            end
        end
    end

    return result;
end

-- Method:          GRM.IsAnyAltActiveForRecommendKicks ( table , rule  )
-- What it Does:    Returns true if at least one of the alts is active
-- Purpose:         No need to announce inactive return if it is just an old alt...
GRM.IsAnyAltActiveForRecommendKicks = function ( listOfAlts , ruleName )
    local result = false;
    local player;

    for i = 1 , #listOfAlts do

        player = GRM.GetPlayer ( listOfAlts[i][1] );

        if player then

            if GRM_G.NumberOfHoursTilRecommend.kick[ruleName] == nil then
                GRM.RefreshNumberOfHoursTilRecommend();
            end

            if player.lastOnline < GRM_G.NumberOfHoursTilRecommend.kick[ruleName] then
                result = true;
                break;
            end
        end
    end

    return result;
end

-- Method:          GRM.ChangePlayerNameInAltGrouping ( string , string )
-- What it Does:    Changes the alt grouping listing of the player's name that needs to be changed as they were detected as a namechange in the guild.
-- Purpose:         Clenaup all places where the player's name was different if they namechange, for continuity's sake and not needing to build a new profile for them.
GRM.ChangePlayerNameInAltGrouping = function ( oldName , newName )
    for groupID , alts in pairs ( GRM_Alts[GRM_G.guildName] ) do

        if GRM_Alts[GRM_G.guildName][groupID].main == oldName then
            GRM_Alts[GRM_G.guildName][groupID].main = newName;
        end

        for i = 1 , #alts do
            if alts[i].name == oldName then
                alts[i].name = newName;
            end
        end
    end
end

-- Method:          GRM.SyncJoinDatesOnAllAlts()
-- What it Does:    Tales the player name and makes ALL of their alts share the same timestamp on joining.
-- Purpose:         Ease for the addon user to be able to sync the join dates among all alts rather than have to manually do them 1 at a time.6
GRM.SyncJoinDatesOnAllAlts = function ( playerName )
    local player = GRM.GetPlayer ( playerName );

    if player then
        -- now, let's check the alt info.
        local date = { player.joinDateHist[1][1] , player.joinDateHist[1][2] , player.joinDateHist[1][3] };
        local finalTStampEpoch = player.joinDateHist[1][4]
        local syncEpochStamp = time();
        local tempAlt;
        local alts = GRM.GetListOfAlts ( player );

        -- Let's cycle through the alts now.
        for i = 1 , #alts do
            -- Now, need to match the alt to the real database

            tempAlt = GRM.GetPlayer ( alts[i][1] );

            if tempAlt then
                -- Let's match the values now...

                tempAlt.joinDateHist[1][1] = date[1];
                tempAlt.joinDateHist[1][2] = date[2];
                tempAlt.joinDateHist[1][3] = date[3];
                tempAlt.joinDateHist[1][4] = finalTStampEpoch;
                tempAlt.joinDateHist[1][5] = syncEpochStamp
                tempAlt.joinDateHist[1][6] = true;
                tempAlt.joinDateHist[1][7] = 1;

                -- If it was unKnown before
                tempAlt.joinDateUnknown = false;

                -- Let's set those officer/public notes as well!
                local noteDestination = "none";
                if GRM.S().addTimestampToNote and ( GRM.CanEditOfficerNote() or GRM.CanEditPublicNote() ) then
                    for h = 1 , GRM.GetNumGuildies() do
                        local guildieName ,_,_,_,_,_, note , oNote = GetGuildRosterInfo( h );
                        if tempAlt.name == guildieName then
                            local noteDate = "";
                            local t = GRM.FormatTimeStamp ( { date[1] , date[2] , date[3] } , false , false , GRM.S().globalDateFormat );
                            if GRM.S().includeTag then
                                noteDate = GRM_G.customHeaderJoin .. " " .. t;
                            else
                                noteDate = t;
                            end
                            
                            if GRM.S().joinDateDestination == 1 and GRM.CanEditOfficerNote() and ( oNote == "" or oNote == nil ) then
                                noteDestination = "officer";
                                GuildRosterSetOfficerNote( h , noteDate );
                            elseif GRM.S().joinDateDestination == 2 and GRM.CanEditPublicNote() and ( note == "" or note == nil ) then
                                noteDestination = "public";
                                GuildRosterSetPublicNote ( h , noteDate );
                            elseif GRM.S().joinDateDestination == 3 then
                                noteDestination = "custom";
                                GRM.SetJoinDateToCustomNote ( guildieName , noteDate );
                            end  
                            break;
                        end
                    end
                end
                
                -- Gotta update the event tracker date too!
                tempAlt.events[1][1][1] = date[1];
                tempAlt.events[1][1][2] = date[2];
                tempAlt.events[1][1][3] = date[3];
                tempAlt.events[1][2] = false;  -- Gotta Reset the "reported already" boolean!
                -- Update the Calendar Que since anniversary dates might be changed as a result
                GRM.RemoveFromCalendarQue ( tempAlt.name , 1 , nil );

                -- To Avoid the spam, we are going to treat this like a SYNC message
                -- Let's send the changes out as well!
                
                if GRM.S().syncEnabled then
                    local syncRankFilter = GRM.S().syncRank;
                    if GRM.S().exportAllRanks then
                        syncRankFilter = GuildControlGetNumRanks() - 1;
                    end
                    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_JDSYNCUP?" .. GRM_G.addonUser .. "?" .. syncRankFilter .. "?" .. tempAlt.name .. "?" .. tostring ( finalTStampEpoch ) .. "?" .. tostring ( date[1] ) .. "?" .. tostring ( date[2] ) .. "?" .. tostring ( date[3] ) .. "?" .. tostring ( syncEpochStamp ) .. "?" .. noteDestination , "GUILD");
                end

            end
        end
    end

    -- Update the Audit Frames!
    if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
        GRM.RefreshAuditFrames ( true , true );
    end

    -- Should definitely refresh the frame here if necessary... prevent mouse tooltip errors
    if GRM_UI.GRM_RosterChangeLogFrame.GRM_EventsFrame:IsVisible() then
        GRM.RefreshAddEventFrame()
    end

end

-- Method:          GRM.SyncJoinDateUsingEarliest()
-- What it Does:    Syncs the join date of the grouping of alts to all be the same as the alt with the earliest join date
-- Purpose:         For join date syncing and time-saving for the player
GRM.SyncJoinDateUsingEarliest = function()
    GRM.SyncJoinDatesOnAllAlts ( GRM.GetAltWithOldestJoinDate ( GRM_G.currentName ) );
end

-- Method:          GRM.SyncJoinDateUsingMain()
-- What it Does:    Syncs the join date of the grouping of alts to all be the same as the alt with the player's main
-- Purpose:         For join date syncing and time-saving for the player
GRM.SyncJoinDateUsingMain = function()
    GRM.SyncJoinDatesOnAllAlts ( GRM.GetPlayerMain ( GRM_G.currentName ) );
end

-- Method:          GRM.SyncJoinDateUsingCurrentSelected()
-- What it Does:    Syncs the join date of the grouping of alts to all be the same as the alt with the currently selected player on the roster
-- Purpose:         For join date syncing and time-saving for the player
GRM.SyncJoinDateUsingCurrentSelected = function()
    GRM.SyncJoinDatesOnAllAlts ( GRM_G.currentName );
end

-- Method:          GRM.GetAltWithOldestJoinDate ( string )
-- What it Does:    Returns the name of the player with the oldest join date in his grouping of main/alts
-- Purpose:         When syncing join dates among a grouping of alts, it would be nice to have an option to sync to the oldest join date.
GRM.GetAltWithOldestJoinDate = function ( playerName )
    local player = GRM.GetPlayer ( playerName );
    local oldestPlayer = { playerName , 0 };
    local day , nonth, year = 0 , 0 , 0;
    local oldestDate = "";
    
    if player then
        local alts = GRM.GetListOfAlts ( player );
        local playerAlt;

        if player.joinDateHist[1][4] > 0 then
            oldestPlayer[2] = player.joinDateHist[1][4];
            oldestPlayer[1] = playerName;
            oldestDate = GRM.FormatTimeStamp ( { player.joinDateHist[1][1] , player.joinDateHist[1][2] , player.joinDateHist[1][3] } , false , false );
        end

        for i = 1 , #alts do
            playerAlt = GRM.GetPlayer ( alts[i][1] );
            if playerAlt then
                if playerAlt.joinDateHist[1][4] > 0 then                           -- First, double check it is set
                    
                    if oldestPlayer[2] == 0 or playerAlt.joinDateHist[1][4] < oldestPlayer[2] then
                        oldestPlayer = { alts[i][1] , playerAlt.joinDateHist[1][4] };
                        oldestDate = GRM.FormatTimeStamp ( { playerAlt.joinDateHist[1][1] , playerAlt.joinDateHist[1][2] , playerAlt.joinDateHist[1][3] } , false , false );
                    end

                end
            end
        end
    end

    return oldestPlayer[1] , oldestDate;
end

-- Method:          GRM.IsAltJoinDatesSynced()
-- What it Does:    Returns true if the player has already sync'd all of the alt data.
-- Purpose:         Quality of Life... no need to ask the player to sync alt data if already sync'd
GRM.IsAltJoinDatesSynced = function ( playerName )
    local player = GRM.GetPlayer ( playerName );
    local result = false;

    if player then
        local alts = GRM.GetListOfAlts ( player );
        local playerAlt;

        if #alts > 0 and player.joinDateHist[1][4] > 0 then
            -- Cycle through each alt...
            local isNotSync = false;

            for i = 1 , #alts do
                playerAlt = GRM.GetPlayer ( alts[i][1] );
                if playerAlt then
                    if playerAlt.joinDateHist[1][4] == 0 or ( playerAlt.joinDateHist[1][4] > 0 and ( playerAlt.joinDateHist[1][1] ~= player.joinDateHist[1][1] or playerAlt.joinDateHist[1][2] ~= player.joinDateHist[1][2] or playerAlt.joinDateHist[1][3] ~= player.joinDateHist[1][3] ) ) then
                        isNotSync = true;
                    end
                end
                if isNotSync then
                    break;
                end
            end
            if not isNotSync then
                result = true;
            end
        end
    end
    return result;
end

-- Method:          GRM.PlayerOrAltHasJD ( string )
-- What it Does:    Returns true if the player or any of his alts has the join date set... unknown counts as NOT set
-- Purpose:         On the mouseover of the join date, it would not be useful to give the option to sync join dates if not at least 1 alt in the group has the JD set
--                  In other words, it is about a good user experience and not giving them options that are unnecessary and useless...
-- NOTE:            Note, if the player has NO alts... it will return as false.
GRM.PlayerOrAltHasJD = function ( playerName )
    local result = false
    local player = GRM.GetPlayer ( playerName );

    if player then
        local alts = GRM.GetListOfAlts ( player );
        local playerAlt;

        if #alts > 0 then                       -- The player needs to have at least one alt.
            if player.joinDateHist[1][4] > 0 then        -- Player Has a join date!
                result = true;
            else
                -- player does not have a JD... let's check if any of the alts do.
                for i = 1 , #alts do       -- cycle through the alts
                    playerAlt = GRM.GetPlayer ( alts[i][1] );
                    if playerAlt then
                        if playerAlt.joinDateHist[1][4] > 0 then
                            result = true;
                        end
                    end
                    if result then
                        break;
                    end
                end
            end
        end
    end
    return result;
end