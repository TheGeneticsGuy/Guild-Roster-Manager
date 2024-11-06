-- ALT MANAGEMENT FUNCTIONS IN A SINGLE CLASS
-- This will function to organize alt management easier and quicker access to the alt functions.
-- As GRM has grown, the core file has grown quite large. This will help me from trying to remember
-- if a function exists and trying to seek it out, to instead putting it in a more compact file.

--------------------------------
---- MAIN DESIGNATION LOGIC ----
--------------------------------

-- Method:          GRM.SetMain ( string , int )
-- What it Does:    Set the player to main by the given player name. It also removes an existing main back to alt status
-- Purpose:         Easily control for setting mains.
GRM.SetMain = function ( playerName , timestamp )
    if not playerName or GRM_G.guildName == "" then
        return;
    end
    local player = GRM.GetPlayer ( playerName );

    if player then
        timestamp = timestamp or time();
        local group = GRM.GetAltGroup ( player.altGroup );

        if not group or ( group and group.main ~= playerName ) then    -- No need to set to main if player is already main.

            if group then

                if group.timeModified < timestamp then
                    -- Player is in a group
                    group.main = playerName;
                    group.timeModified = timestamp;
                end
            elseif player.altGroupLeft < timestamp then
                -- Player is not in a group, need to create new altGroup and set as main.
                -- Ensure altGroup is fresh
                player.altGroup = "";
                GRM.CreateAltGroup ( player.name , true , timestamp );
            end

            -- LIVE FRAMES UPDATE
            if GRM_UI.GRM_MemberDetailMetaData and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

                if player.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Show();
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Hide();
                end

                -- Doesn't just need to be current - can be looking at alt window.
                if GRM_G.currentName and GRM_G.currentName ~= "" then
                    local altMember = GRM.GetPlayer ( GRM_G.currentName );
                    if altMember and altMember.altGroup == player.altGroup then
                        GRM.PopulateAltFrames ( GRM_G.currentName );
                        GRM_UI.RefreshSelectFrames ( false , true , false , false , true , false );
                    end
                end
            end

        -- if player is already main, but the sync data shows a newer tiemstamp, let's absord the newer timestamp even though no data changes.
        elseif group and group.timeModified < timestamp then
            group.timeModified = timestamp;
        end

    end
end

-- Method:          GRM.DemotePlayerFromMain ( string , int )
-- What it Does:    Set player to alt if they are currently set as main.
-- Purpose:         Easy control to set player to main.
GRM.DemotePlayerFromMain = function ( playerName , timestamp )

    if not playerName or GRM_G.guildName == "" then
        return;
    end

    local player = GRM.GetPlayer ( playerName );
    timestamp = timestamp or time();

    -- Player is main
    if player then
        local group = GRM.GetAltGroup ( player.altGroup );

        if group then
            if #group == 1 and group.main == player.name then
                -- Just 1, since no longer a main, let's purge this altGroup
                GRM.RemoveAltGroup ( player.altGroup , timestamp )

            elseif #group > 1 and group.main == player.name then
                group.main = "";
                group.timeModified = timestamp;
            end

            -- LIVE FRAMES UPDATE
            if GRM_UI.GRM_MemberDetailMetaData and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

                if player.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                    if GRM.GetAltGroup ( player.altGroup ) then
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                    end
                end

                if GRM.GetPlayer ( GRM_G.currentName ).altGroup == player.altGroup then
                    GRM.PopulateAltFrames ( GRM_G.currentName );
                end
            end
        end
    end
end

-- Method:          GRM.GetAltGroupMain ( string , bool )
-- What it Does:    Returns the string name of the player who is listed as the main, and also the GUID if requested
-- Purpose:         Easily get the player's main.
GRM.GetAltGroupMain = function ( altGroup , includeGUID )
    local main = "";
    local GUID = "";
    local class = "";
    local group = GRM.GetGuildAlts()[altGroup];

    if group then
        main = group.main;

        for i = 1 , #group do
            if group[i].name == main then
                class = group[i].class;
            end
        end

        if includeGUID then
            local player = GRM.GetPlayer ( main );
            if player then
                GUID = player.GUID;
            end
        end
    end

    return main , GUID , class;
end

-- Method:          GRM.GetPlayerMain ( string )
-- What it Does:    Returns the full player of the toon's main, or himself if he is main, or an empty string if no main.
-- Purpose:         Useful lookup for many purposes...
GRM.GetPlayerMain = function ( playerName )
    local player = GRM.GetPlayer ( playerName);

    if player then

        local group = GRM.GetAltGroup ( player.altGroup );

        if group and group.main ~= "" then
            return group.main;
        end
    end
    return "";
end

-- Method:          GRM.GetFormattedMainName ( string )
-- What it Does:    Returns the main name of the given alt from the alt grouping, or returns "" if none is established for the given player.
-- Purpose:         To have a cleaner, simpler way of obtaining the main name.
GRM.GetFormattedMainName = function ( fullName , includeParentheses )
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

-- Method:          GRM.IsMain ( string )
-- What it Does:    Returns true if the given player is listed as a Main
-- Purpose:         Easy lookup code for mains.
GRM.IsMain = function ( playerName )
    local player = GRM.GetPlayer( playerName );

    if player then
        local group = GRM.GetAltGroup ( player.altGroup );
        if group and group.main == playerName then
            return true;
        end
    end
    return false;
end

-- Method:          GRM.IsFormerMemberMain ( playerTable )
-- What it Does:    Returns true if the former member was a main at the time he left the guild
-- Purpose:         Particularly useful with the GroupInfo module.
GRM.IsFormerMemberMain = function ( player )
    if #player.mainAtTimeOfLeaving > 0 and player.mainAtTimeOfLeaving[1] == player.name then
        return true;
    end
    return false;
end


----------------------------------
--- END MAIN DESIGNATION LOGIC ---
----------------------------------


---------------------------------
----- Alt DESIGNATION LOGIC -----
---------------------------------

-- Method:          GRM.GetAltGroup ( string )
-- What it Does:    Returns the alt Group from the DB based on the alt Group ID, or nil if it doesn't exit.
-- Purpose:         Easy DB call to get the alt Group.
GRM.GetAltGroup = function ( groupID )
    local altGroups = GRM.GetGuildAlts();

    if groupID and altGroups[groupID] then
        return altGroups[groupID];
    end
    return;     -- Return nil if no alt group.
end

-- Method:          GRM.CreateAltGroup ( string , boo , int )
-- What it Does:    Creates a new altGroup and sets the given time of creation
-- Purpose:         Necessary to create a new alt group on occasion.
GRM.CreateAltGroup = function ( playerName , setAsMain , timestamp )
    local player = playerName;
    if type (playerName) == "string" then
        player = GRM.GetPlayer ( playerName );
    end
    timestamp = timestamp or time();

    if player and player.altGroup == "" then

        local groupID = GRM.CreateNewAltGroupID();
        GRM.GetGuildAlts()[groupID] = {};
        local group = GRM.GetGuildAlts()[groupID];

        if setAsMain then
            group.main = player.name;
        else
            group.main = "";
        end

        -- Add player to the group .
        table.insert ( group , {} );
        group[#group].name = player.name;
        group[#group].class = player.class;
        group.timeModified = timestamp;
        player.altGroupLeft = 0;
        player.altGroup = groupID;
    end
end

-- Method:          GRM.AddAlt ( string, string , int )
-- What it Does:    Adds a player to the alt grouping
-- Purpose:         Alt group management.
GRM.AddAlt = function ( playerName , secondPlayerName , timestamp )

    if not playerName or not secondPlayerName then
        return;
    end

    local addToAltsGroup = false;
    timestamp = timestamp or time();

    if playerName ~= secondPlayerName then

        local player = GRM.GetPlayer ( playerName );
        local player2 = GRM.GetPlayer ( secondPlayerName );

        -- Data Protection check - no need to add to group if they are already in the same altGroup
        if not player or not player2 then
            return
        end
        if player.altGroup ~= "" and player.altGroup == player2.altGroup then   -- This means they are already in the same group, no need to add
            return
        end

        --  Now we check status of these toons to determine how to add to group - 4 options:
        --      Both have groups they are already in.
        --      Player has a group but the alt adding to does not
        --      Player doesn't have a group but the alt DOES
        --      Neither has alts
        local altGroup1 = GRM.GetAltGroup ( player.altGroup );
        local altGroup2 = GRM.GetAltGroup ( player2.altGroup );

        if not altGroup1 and not altGroup2 then
            -- Neither has alts (this means neither is a main)
            GRM.CreateAltGroup ( player.name , false , timestamp );
            player2.altGroup = "";
            GRM.AddPlayerToAltGroup ( player2 , player.altGroup , timestamp , false );

        elseif altGroup1 and not altGroup2 then
            -- Player 1 is in an alt group, but player 2 is not
            player2.altGroup = "";
            GRM.AddPlayerToAltGroup ( player2 , player.altGroup , timestamp , false );

        elseif not altGroup1 and altGroup2 then
            -- Player 1 is NOT in an alt group, but player 2 is.
            player.altGroup = "";
            GRM.AddPlayerToAltGroup ( player , player2.altGroup , timestamp , false );
            addToAltsGroup = true;

        -- Much more complicated logic if both toons being added to a group are already part of an alt grouping, so let's consider ALL scenarios.
        elseif altGroup1 and altGroup2 then
            -- Both of them are already in an alt group.
            -- Now we need to check a few scenarios:
            --      - Player 1 has alts, but player2 is main without alts.
            --          - Player 1 has a main, with alts, player2 is also a main.
            --          - Player 1 has NO main, with alts, player2 is also a main
            --      - Player 2 has alts, but player1 is main without alts.
            --          - Player 2 has a main, with alts, player1 is also a main.
            --          - Player 2 has NO main, with alts, player1 is also a main
            --      - Player 1 and Player 2 both have alts with sub-scanrios OR, neither has alts:
            --          - Player1 has alts and a main designated, Player2 only has alts
            --          - Player2 has alts and a main designated, Player1 only has alts
            --          - Player1 and Player2 have alts and both have main designated, or neither have alts.
            --          - Player1 and Player2 have alts, neither have mains

            if #altGroup1 > 1 and #altGroup2 == 1 then  -- Implies altGroup2 is just a main with no alts
                -- First, we need to purge the player2 altGroup - 'altGroup2' can no longer be referenced.
                GRM.GetGuildAlts()[player2.altGroup] = nil;
                local setAsMain = false;

                if altGroup1.main == "" then
                    -- Since the group1 w/alts also has a main, then demote the player2 from main
                    setAsMain = true;
                end

                player2.altGroup = "";
                GRM.AddPlayerToAltGroup ( player2 , player.altGroup , timestamp , setAsMain );

            elseif #altGroup2 > 1 and #altGroup1 == 1 then
                -- First, we need to purge the player1 altGroup - 'altGroup1' can no longer be referenced.
                GRM.GetGuildAlts()[player.altGroup] = nil;
                local setAsMain = false;

                if altGroup2.main == "" then
                    -- In this case we are designating the toon being added as the new main
                    setAsMain = true;
                end
                player.altGroup = "";
                GRM.AddPlayerToAltGroup ( player , player2.altGroup , timestamp , setAsMain );
                addToAltsGroup = true;

            elseif ( #altGroup1 > 1 and #altGroup2 > 1 ) or ( #altGroup1 == 1 and #altGroup2 == 1 ) then
                -- Oh my! Both groups have alts!
                if altGroup1.main ~= "" and altGroup2.main == "" then
                    -- This means we are going to add player2 to player1's alt group. To do this, we need to first remove player2 from his own altGroup
                    GRM.RemovePlayerFromAltGroup ( player2.name , timestamp , false , false , false , false );
                    player2.altGroup = "";
                    GRM.AddPlayerToAltGroup ( player2 , player.altGroup , timestamp , false );

                elseif altGroup2.main ~= "" and altGroup1.main == "" then
                    -- This means we are going to add player1 to player2's alt group. To do this, we need to first remove player1 from his own altGroup
                    GRM.RemovePlayerFromAltGroup ( player.name , timestamp , false , false , false , false );
                    player.altGroup = "";
                    GRM.AddPlayerToAltGroup ( player , player2.altGroup , timestamp , false );
                    addToAltsGroup = true;

                elseif altGroup1.main ~= "" and altGroup2.main ~= "" then
                    -- Since both have mains, we are going to prioritize adding this player to altGroup2, and removing his main status, so the gorup2 being added to will retain their status. In other words, we are prioritizing the existing main of the group.
                    if ( #altGroup1 == 1 and #altGroup2 == 1 ) then
                        -- Then both players are mains but neither has alts
                        GRM.DemotePlayerFromMain ( player2.name , timestamp );  -- This will also remove the alt Group
                    else
                        GRM.RemovePlayerFromAltGroup ( player2.name , timestamp , false , false , false , false );
                    end
                    player2.altGroup = "";
                    GRM.AddPlayerToAltGroup ( player2 , player.altGroup , timestamp , false );

                elseif altGroup1.main == "" and altGroup2.main == "" then
                    GRM.RemovePlayerFromAltGroup ( player2.name , timestamp , false , false , false , false );
                    player2.altGroup = "";
                    GRM.AddPlayerToAltGroup ( player2 , player.altGroup , timestamp , false );

                end
            end
        end

        -- LIVE UPDATE THE FRAMES
        if GRM_UI.GRM_MemberDetailMetaData and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
            if GRM.GetPlayer ( GRM_G.currentName ).altGroup == player.altGroup then
                GRM.PopulateAltFrames ( GRM_G.currentName );
            end
        end

    end
    return addToAltsGroup;
end

-- Method:          GRM.RemoveAltGroup ( string , int )
-- What it Does:    Removes the altGroup completely, as well as removes main designation
-- Purpose:         Alt managemenet controls.
GRM.RemoveAltGroup = function ( groupID , timestamp )
    local altGroup = GRM.GetAltGroup ( groupID );
    local guildData = GRM.GetGuild();
    timestamp = timestamp or time();

    if altGroup then

        -- next, purge the altGroupID from all of the players in the alt grouping
        for i = 1 , #altGroup do
            if guildData[altGroup[i].name] then
                guildData[altGroup[i].name].altGroup = "";
                guildData[altGroup[i].name].altGroupLeft = timestamp;
            end
        end

        -- Finally, purge the alt Group
        GRM_Alts[GRM_G.guildName][groupID] = nil;
    end
end

-- Method:          GRM.IsPlayerInAltGroup ( string , string )
-- What it Does:    Returns true or false if player is in an alt group. This includes returning true if player is in their own group as main
-- Purpose:         Cleaner reusable code.
GRM.IsPlayerInAltGroup = function ( groupID , playerName )
    local result = false;
    local group = GRM.GetAltGroup ( groupID );
    if group then
        for i = 1 , #group do
            if group[i].name == playerName then
                result = true;
                break;
            end
        end
    end

    return result;
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

-- Method:          GRM.GetNumAltGroups ( [,string] )
-- What it Does:    Return the count of the number of alt groups in the guild
-- Purpose:         To determine which unique identifier to give the alt group.
GRM.GetNumAltGroups = function( guildName )
    return GRM.TableLength ( GRM.GetGuildAlts( guildName or GRM_G.guildName ) );
end

-- Method:          GRM.GetAltNamesList ( playerTable )
-- What it Does:    Returns all of the player alts if there are any
-- Purpose:         Allow to obtain just the list of alts without any other data
GRM.GetAltNamesList = function ( player , alts , includeOwnName )
    local names = {};
    alts = alts or GRM.GetGuildAlts();

    if alts and player and player.altGroup ~= "" and alts[player.altGroup] then
        for i = 1 , #alts[player.altGroup] do
            if alts[player.altGroup][i].name ~= player.name or includeOwnName then
                table.insert ( names , alts[player.altGroup][i].name );
            end
        end
    end
    sort ( names );     -- Let's get them alphabetical
    return names;
end

-- Method:          GRM.GetListOfAlts ( playerTable , bool , table )
-- What it Does:    Returns the list of all of the alts from the alt Grouping, not including the player's own self, as well as their class Name
-- Purpose:         Useful to UI function easy lookup
GRM.GetListOfAlts = function ( player , includeGUID , altData )
    local names = {};
    local mainName;
    altData = altData or GRM.GetGuildAlts(); -- Sync has a copied table that is static during sync, so to use this function during sync we don't want it to check the live table.
    local group = GRM.GetAltGroup ( player.altGroup );

    if group then
        for i = 1 , #group do

            if group[i] ~= nil and group[i].name ~= nil and group[i].name ~= player.name then

                local member = GRM.GetPlayer ( group[i].name );
                if not includeGUID or ( includeGUID and not member ) then
                    table.insert ( names , { group[i].name , group[i].class , group.timeModified } );
                else
                    table.insert ( names , { group[i].name , group[i].class , member.GUID , group.timeModified } );
                end
            end
        end
        mainName = group.main;

    elseif player.altGroup ~= "" then
        -- Redundancy for a legacy bug
        player.altGroup = "";
    end

    return names , mainName;
end

-- Method:          GRM.GetListOfAltsLowerRankThanMyself ( playerTable )
-- What it Does:    Returns the list of alts who are capable of being kicked
-- Purpose:         To easily mass kick an list of alts.
GRM.GetListOfAltsLowerRankThanMyself = function( player )
    local alts = GRM.GetListOfAlts( player );
    local unableToKick = {};

    if #alts > 0 then
        sort ( alts , function ( a , b ) return a[1] < b[1] end );
        local guild_data = GRM.GetGuild();
        local alt = {};
        local myRank = GRM.GetPlayer(GRM_G.addonUser).rankIndex

        for i = #alts , 1 , -1 do
            alt = GRM.GetPlayer(alts[i][1])
            if alt and alt.rankIndex <= myRank then
                table.insert ( unableToKick , alts[i][1] )  -- Add to a name
                table.remove ( alts, i );               -- Alt rank is higher than my current toon, so unable to kick.
            end
        end
    end

    return alts, unableToKick;
end

-- Method:          GRM.PlayerIsAnAlt ( playerTable )
-- What it Does:    Returns true if the given player is considered an "alt" not a main, or no designation
-- Purpose:         To inform if the player is an alt more easily.
GRM.PlayerIsAnAlt = function ( player )

    if player then
        local group = GRM.GetAltGroup ( player.altGroup );
        if group and group.main ~= player.name then
            return true;
        end
    end

    return false;
end

-- Method:          GRM.PlayerHasAlts ( playerTable )
-- What it Does:    Returns true if the player has alts
-- Purpose:         Cleaner code. Easier to call this.
GRM.PlayerHasAlts = function ( player )
    if player and player.altGroup ~= "" then
        local altGroup = GRM.GetAltGroup ( player.altGroup );

        if altGroup and #altGroup > 1 then
            return true
        end
    end
    return false;
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

-- Method:          GRM.GetNumAlts ( string )
-- What it Does:    Returns the number of alts a player has
-- Purpose:         Useful to know to save time on parsing through tables needlessly.
GRM.GetNumAlts = function ( groupID )
    local result = 0;
    local group = GRM.GetAltGroup ( groupID );

    if group then
        result = #group - 1; -- minues 1 for the player's own self.
    end

    return result;
end

-- Method:          GRM.AddPlayerToAltGroup ( string , string , int , bool , bool )
-- What it Does:    Adds the given player to the alt group based on the altGroupID, the playerName,
-- Purpose:         Sub-level function for the main AddAlt function
GRM.AddPlayerToAltGroup = function ( player , groupID , timestamp , setAsMain , syncChange )

    local group = GRM.GetAltGroup ( groupID );

    if group then
            -- Only in this case do we remove the player from the alt group
        if syncChange and player.altGroup ~= "" then
            GRM.RemovePlayerFromAltGroup ( player.name , timestamp , false , false , syncChange , false );
        end

        if player.altGroup == "" then      -- This will ONLY add to a group if they are not already in one.
            timestamp = timestamp or time();

            -- adding name/class to group
            table.insert ( group , {} );
            group[#group].name = player.name;
            group[#group].class = player.class;

            if setAsMain then
                group.main = player.name;
            end

            group.timeModified = timestamp;
            -- Adding alt GroupID to new alt
            player.altGroup = groupID;
            player.altGroupLeft = 0;

            sort ( GRM_Alts[GRM_G.guildName][player.altGroup] , function ( a , b ) return a.name < b.name end );
        end
    end
end

-- Method:          GRM.RemovePlayerFromAltGroup ( string , int , bool , bool . bool , bool )
-- What it Does:    Removes a player from the alt group, and if it is a main, creates their own new alt group
-- Purpose:         Controls to add and remove alts.
GRM.RemovePlayerFromAltGroup = function( playerName , timestamp , keepMainStatus , refreshUI , syncChange , leavingGuild )
    if not playerName then
        return;
    end

    local player = GRM.GetPlayer ( playerName );

    if player then
        local group = GRM.GetAltGroup ( player.altGroup );
        local playerIsMain = false;
        timestamp = timestamp or time();

        if group then
            -- Ok, remove him from his grouping...
            for i = 1 , #group do
                if group[i].name == playerName then
                    table.remove ( group , i );
                    if group.main == playerName then
                        playerIsMain = true;
                        group.main = "";
                    end
                    break;
                end
            end

            -- Now, check if need to dissolve the group. Conditions to Dissolve:
            -- * Zero Remaining in Group
            -- * Only 1 remaining in group, and there is no longer aa main
            if #group <= 1 then

                if #group == 0 then     -- Implies the toon removed was the only one in it, so just purge the group
                    GRM.GetGuildAlts()[player.altGroup] = nil;

                elseif group.main == "" then      -- This means there were 2 players and 1 was removed, the player removed was the main, thus now alt group has no main - dissolve
                    local member = GRM.GetPlayer ( group[1].name );
                    if member then
                        member.altGroup = "";
                        if scanDiscovery then
                            member.altGroupLeft = tonumber ( group.timeModified );
                            if group.timeModified > 0 then
                                member.altGroupLeft = member.altGroupLeft - 1;
                            end
                        else
                            member.altGroupLeft = timestamp;        -- Necessary for sync purposes - log when players were no longer in an alt Group
                        end
                    end
                    GRM.GetGuildAlts()[player.altGroup] = nil;
                end

            elseif not syncChange and not leavingGuild then
                group.timeModified = timestamp;
            end

            -- Check if he is main, if so, some additional logic necessary.
            if keepMainStatus and playerIsMain then
                -- Now, we are not going to remove him from main status just because he is removed from a group. He will be removed but still kept as main in his own  group.
                -- So, we now need to create a new altGroup. This will also set as main, and it will change the GroupID
                player.altGroup = "";
                GRM.CreateAltGroup ( player , true , timestamp );
            else
                player.altGroup = "";
                if not syncChange then
                    player.altGroupLeft = timestamp;
                end;
            end

        elseif player.altGroupLeft ~= timestamp then
            player.altGroupLeft = timestamp
        end

        -- Even if player is not removed from a grouping, the time should be logged as now it is made in-sync with others' addon on players no longe in guild.
        if refreshUI then
            if GRM_UI.GRM_MemberDetailMetaData and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
                GRM.PopulateAltFrames ( GRM_G.currentName );
            end
            GRM_UI.RefreshSelectFrames ( true , true , false , true , true , true );
        end
    end
end

-- Method:          timeModified ( int )
-- What it Does:    Returns the epoch timestamp of the most recent alt group change.
-- Purpose:         Easily unify the timestamp.
GRM.GetAltGroupTimeStamp = function ( groupID )
    local altGroup = GRM.GetAltGroup ( groupID );

    if altGroup then
        return altGroup.timeModified;
    end

    return 0;
end

-- Method:          GRM.IsAnyAltActive ( table , int)
-- What it Does:    Returns true if at least one of the alts is active
-- Purpose:         No need to announce inactive return if it is just an old alt...
GRM.IsAnyAltActive = function ( alts , hours )
    hours = hours or GRM.S().inactiveHours;
    local player;

    for i = 1 , #alts do

        player = GRM.GetPlayer ( alts[i] );

        if player then
            if player.lastOnline < hours then
                return true;
            end
        end
    end

    return false;
end

-- Method:          GRM.IsAnyAltActiveForRecommendKicks ( table , rule  )
-- What it Does:    Returns true if at least one of the alts is active
-- Purpose:         No need to announce inactive return if it is just an old alt...
GRM.IsAnyAltActiveForRecommendKicks = function ( alts , ruleName )
    local result = false;
    local player;

    for i = 1 , #alts do

        player = GRM.GetPlayer ( alts[i] );

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
                        GRM.AddAlt ( p.name , player.name );
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
                    if player and altName ~= GRM_G.addonUser then

                        if GRM.IsMain ( altName ) then

                            -- ADD ALT HERE!!!!!!
                            local addToAltsGroup = GRM.AddAlt ( GRM_G.addonUser , altName );
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
                            local addToAltsGroup = GRM.AddAlt ( GRM_G.addonUser , altName );
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
    local officialToons = GRM.GetAddOnUserGuildAlts();

    if officialToons ~= nil and officialToons[GRM_G.addonUser] ~= nil then
        return false;
    end
    return true;
end

-- Method:          GRM.ChangePlayerNameInAltGrouping ( string , string )
-- What it Does:    Changes the alt grouping listing of the player's name that needs to be changed as they were detected as a namechange in the guild.
-- Purpose:         Clenaup all places where the player's name was different if they namechange, for continuity's sake and not needing to build a new profile for them.
GRM.ChangePlayerNameInAltGrouping = function ( oldName , newName )
    local guildAlts = GRM.GetGuildAlts();

    for groupID , alts in pairs ( guildAlts ) do

        for i = 1 , #alts do
            if alts[i].name == oldName then
                alts[i].name = newName;

                -- Update main name if necessary.
                if alts.main == oldName then
                    alts.main = newName;
                end
                return;
            end
        end
    end
end

-----------------------------------------
--- END ALT GROUPING AND STATUS LOGIC ---
-----------------------------------------


--------------------------
--- ALT GROUP UI LOGIC ---
--------------------------

-- Method:          GRM.GetAltWithOldestJoinDate ( string )
-- What it Does:    Returns the name of the player with the oldest join date in his grouping of main/alts
-- Purpose:         When syncing join dates among a grouping of alts, it would be nice to have an option to sync to the oldest join date.
GRM.GetAltWithOldestJoinDate = function ( playerName )
    local player = GRM.GetPlayer ( playerName );
    local oldestPlayer = { playerName , 0 };
    local oldestDate = "";

    if player then
        local alts = GRM.GetAltNamesList ( player );
        local playerAlt;

        if player.joinDateHist[1][1] > 0 then
            oldestPlayer[2] = tonumber ( player.joinDateHist[1][4] );
            oldestPlayer[1] = playerName;
            oldestDate = GRM.FormatTimeStamp ( { player.joinDateHist[1][1] , player.joinDateHist[1][2] , player.joinDateHist[1][3] } , false , false );
        end

        for i = 1 , #alts do
            playerAlt = GRM.GetPlayer ( alts[i] );
            if playerAlt then
                if playerAlt.joinDateHist[1][1] > 0 then                           -- First, double check it is set

                    if oldestPlayer[2] == 0 or tonumber ( playerAlt.joinDateHist[1][4] ) < oldestPlayer[2] then
                        oldestPlayer = { alts[i] , tonumber ( playerAlt.joinDateHist[1][4] ) };
                        oldestDate = GRM.FormatTimeStamp ( { playerAlt.joinDateHist[1][1] , playerAlt.joinDateHist[1][2] , playerAlt.joinDateHist[1][3] } , false , false );
                    end

                end
            end
        end
    end

    return oldestPlayer[1] , oldestDate;
end

-- Method:          GRM.SyncJoinDatesOnAllAlts()
-- What it Does:    Tales the player name and makes ALL of their alts share the same timestamp on joining.
-- Purpose:         Ease for the addon user to be able to sync the join dates among all alts rather than have to manually do them 1 at a time.6
GRM.SyncJoinDatesOnAllAlts = function ( playerName )
    local player = GRM.GetPlayer ( playerName );

    if player then
        -- now, let's check the alt info.
        local date = { player.joinDateHist[1][1] , player.joinDateHist[1][2] , player.joinDateHist[1][3] };
        local standardFormat = player.joinDateHist[1][4]
        local syncEpochStamp = time();
        local alts = GRM.GetAltNamesList ( player );
        local tempAlt;

        -- Let's cycle through the alts now.
        for i = 1 , #alts do
            -- Now, need to match the alt to the real database

            tempAlt = GRM.GetPlayer ( alts[i] );

            if tempAlt then
                -- Let's match the values now...

                tempAlt.joinDateHist[1][1] = date[1];
                tempAlt.joinDateHist[1][2] = date[2];
                tempAlt.joinDateHist[1][3] = date[3];
                tempAlt.joinDateHist[1][4] = standardFormat;
                tempAlt.joinDateHist[1][5] = syncEpochStamp
                tempAlt.joinDateHist[1][6] = true;
                tempAlt.joinDateHist[1][7] = 1;

                -- If it was unKnown before
                tempAlt.joinDateUnknown = false;

                -- Let's set those officer/public notes as well!
                if GRM.S().addTimestampToNote and ( GRM.CanEditOfficerNote() or GRM.CanEditPublicNote() ) then -- By default I block non officers from auto-adding notes
                    for h = 1 , GRM.GetNumGuildies() do
                        local h = GRM.GetRosterSelectionID ( tempAlt.name , tempAlt.GUID );
                        if h then
                            local note , oNote = select ( 7 , GetGuildRosterInfo(h) );

                            if not note then
                                note = "";
                            end
                            if not oNote then
                                oNote = "";
                            end

                            local noteDate = "";
                            local timestamp = GRM.FormatTimeStamp ( { date[1] , date[2] , date[3] } , false , false , GRM.S().globalDateFormat );

                            if GRM.S().includeTag then
                                noteDate = GRM_G.customHeaderJoin .. " " .. timestamp;
                            else
                                noteDate = timestamp;
                            end

                            if GRM.S().joinDateDestination == 1 and GRM.CanEditOfficerNote() and ( oNote == "" or oNote == nil ) then
                                GuildRosterSetOfficerNote( h , noteDate );
                            elseif GRM.S().joinDateDestination == 2 and GRM.CanEditPublicNote() and ( note == "" or note == nil ) then
                                GuildRosterSetPublicNote ( h , noteDate );
                            elseif GRM.S().joinDateDestination == 3 then
                                GRM.SetJoinDateToCustomNote ( tempAlt.name , noteDate );
                            end
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
                    GRMsync.SendMessage ( "GRM_SYNC" , "GRM_JDSYNCUP?" .. GRM_G.addonUser .. "?" .. syncRankFilter .. "?" .. tempAlt.name .. "?" .. standardFormat .. "?" .. tostring ( syncEpochStamp ) , "GUILD");
                end

            end
        end
    end
    GRM_UI.RefreshSelectFrames ( true , true , false , true , true , true );
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

-- Method:          GRM.IsAltJoinDatesSynced( string )
-- What it Does:    Returns true if the player has already sync'd all of the alt data.
-- Purpose:         Quality of Life... no need to ask the player to sync alt data if already sync'd
GRM.IsAltJoinDatesSynced = function ( playerName )
    local player = GRM.GetPlayer ( playerName );
    local result = false;

    if player then
        local alts = GRM.GetAltNamesList ( player );
        local playerAlt;

        if #alts > 0 and player.joinDateHist[1][1] > 0 then
            -- Cycle through each alt...
            local isNotSync = false;

            for i = 1 , #alts do
                playerAlt = GRM.GetPlayer ( alts[i] );
                if playerAlt then
                    if playerAlt.joinDateHist[1][1] == 0 or ( playerAlt.joinDateHist[1][1] > 0 and ( playerAlt.joinDateHist[1][1] ~= player.joinDateHist[1][1] or playerAlt.joinDateHist[1][2] ~= player.joinDateHist[1][2] or playerAlt.joinDateHist[1][3] ~= player.joinDateHist[1][3] ) ) then
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
        local alts = GRM.GetAltNamesList ( player );
        local playerAlt;

        if #alts > 0 then                       -- The player needs to have at least one alt.
            if player.joinDateHist[1][1] > 0 then        -- Player Has a join date!
                result = true;
            else
                -- player does not have a JD... let's check if any of the alts do.
                for i = 1 , #alts do       -- cycle through the alts
                    playerAlt = GRM.GetPlayer ( alts[i] );
                    if playerAlt then
                        if playerAlt.joinDateHist[1][1] > 0 then
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
        main = GRM.GetAltGroup( player.altGroup ).main;
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
                local isMain = false;

                -- This is wrapped in the OnUpdate, but if this action is paused it needs to run when clicked 1 time
                if GRM_G.pause then
                    local listOfAlts = GRM.GetListOfAlts ( GRM.GetPlayer(GRM_G.currentName) );

                    if GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons ~= nil then
                        for i = 1 , #GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons do
                            if GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][1]:IsVisible() and GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][1]:IsMouseOver ( 1 , -1 , -1 , 1 ) and GRM.GetMouseFocus( GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][1] ) and listOfAlts[i] and listOfAlts[i][1] then

                                GRM_G.tempAltName = listOfAlts[i][1];
                                break;
                            end
                        end
                    end
                end

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
        local alts = GRM.GetAltNamesList ( player );

        -- Build the list of alts.
        for i = 1 , #alts do
            tempAlt = GRM.GetPlayer ( alts[i] )

            if tempAlt then

                playerDetails = { tempAlt.name , tempAlt.level , tempAlt.class , tempAlt.rankIndex , GRM.IsMain ( tempAlt.name ) , tempAlt.lastOnline , tempAlt.joinDateHist[1][4], GRM.GetTimestampOfLastRankChange ( tempAlt ) , tempAlt.isOnline , tempAlt.lastOnlineTime };

                -- Alphabetical
                if type == 1 then
                    -- Add the alt to the list
                    table.insert ( finalList , 1 , playerDetails );
                    if i == #alts then
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

-- Method:          GRM.GetAltTag ( int )
-- What it Does:    Returns the hex value/colored string with the alt or main tag
-- Purpose:         For taggin the autocomplete names to make it easier to see who is and isn't and alt/main
GRM.GetAltTag = function ( value )
    if value == 1 then
        return ( "|cffab0000 " .. GRM.GetMainTags ( false , GRM.S().mainTagIndex ) );
    elseif value == 2 then
        return ( "|cffab0000 " .. GRM.GetAltTags ( false , GRM.S().mainTagIndex ) );
    end
    return "";
end

-- Method:          GRM.AddAltAutoComplete()
-- What it Does:    Takes the entire list of guildies, then sorts them as player types to be added to alts list
-- Purpose:         Eliminates the possibility of a person entering a fake name of a player no longer in the guild.
GRM.AddAltAutoComplete = function()
    local partName = GRM_UI.GRM_MemberDetailMetaData.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:GetText();
    local tag = 0;
    local players = {};
    local guildData = GRM.GetGuild();
    local altGroup = {};

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.name ~= GRM_G.currentName then   -- no need to go through player's own window
                -- Determine alt/main tag
                tag = 0;
                altGroup = GRM.GetAltGroup ( player.altGroup );
                -- 0 = no tag, 1 = main, 2 = alt
                if altGroup then
                    if altGroup.main == player.name then
                        tag = 1;
                    elseif #altGroup > 1 then
                        tag = 2;
                    end
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

-- Method:              GRM.KickAllAlts ( string , list , string , int )
-- What it Does:        Bans all listed alts of the player as well and adds them to the ban list. Of note, addons cannot kick players anymore, so this only adds to ban list.
-- Purpose:             QoL. Option to ban players' alts as well if they are getting banned.
GRM.KickAllAlts = function ( playerName , alts , banReason , epochTimeStamp )
    GRM_G.KickAllAltsTable = {};
    epochTimeStamp = epochTimeStamp or time();

    if #alts > 0 then
    -- Ok, let's parse the player's data!
        local tempAlt;
        local instructionNote = GRM.L ( "Reason Banned?" ) .. "\n" .. GRM.L ( "Click \"YES\" When Done" );
        local result = banReason or "";

        if GRM_G.isChecked2 or GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_BanAllAltsCheckbox:GetChecked() then

            for i = 1 , #alts do
                if alts[i][1] ~= playerName and alts[i][1] ~= GRM_G.addonUser then   -- Can't include themselves to kick
                    tempAlt = GRM.GetPlayer ( alts[i][1] );

                    -- The banning...
                    if GRM_G.isChecked or GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_BanAllAltsCheckbox:GetChecked() then
                        tempAlt.bannedInfo[1] = true;
                        tempAlt.bannedInfo[2] = epochTimeStamp;
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
                        local index = #GRM_G.KickAllAltsTable;
                        GRM_G.KickAllAltsTable[index].name = tempAlt.name;
                        GRM_G.KickAllAltsTable[index].class = GRM.GetClassColorRGB ( tempAlt.class );
                        GRM_G.KickAllAltsTable[index].lastOnline = tempAlt.lastOnline;
                        GRM_G.KickAllAltsTable[index].action = GRM.L ( "Kick" );
                        GRM_G.KickAllAltsTable[index].macro = "/gremove";
                        GRM_G.KickAllAltsTable[index].isHighlighted = false;
                        GRM_G.KickAllAltsTable[index].mainName = GRM.GetFormattedMainName ( tempAlt , true );
                        GRM_G.KickAllAltsTable[index].customMsg = GRM.L ( "Kicking {name}'s alts" , GRM.SlimName ( playerName ) );
                        GRM_G.KickAllAltsTable[index].isMain = false;
                        GRM_G.KickAllAltsTable[index].isAlt = false;
                        GRM_G.KickAllAltsTable[index].tab = false;

                    end

                end
            end
            if #GRM_G.KickAllAltsTable > 0 then
                -- Bring popup reminder to select it...
                GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Kick macro created. Press \"CTRL-SHIFT-K\" to kick all of {name}'s alts" , GRM.FormatName ( playerName ) ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:Click();
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

        -- Refresh the frames!
        GRM_UI.RefreshSelectFrames ( true , true , true , false , true , true );
    end
end

------------------------
--- END ALT UI LOGIC ---
------------------------
----------------------
--- BIRTHDAY LOGIC ---
----------------------

-- Method:          GRM.SetBirthdayForAltGrouping ( string , int , int , int , string , int , bool )
-- What it Does:    Sets all of the alts to the same birthday as well when there is a modification
-- Purpose:         Ensure birthdays are set for all alts, as it is assumed it is one player
GRM.SetBirthdayForAltGrouping = function ( playerName , day , month , year , date , timeStamp , isFullSync )
    local player = GRM.GetPlayer ( playerName );
    local tempAlt;

    if player and GRM.PlayerHasAlts ( player ) then
        local alts = GRM.GetAltNamesList ( player );
        for i = 1 , #alts do

            tempAlt = GRM.GetPlayer ( alts[i] );

            if tempAlt then

                if i == 1 and isFullSync and ( tempAlt.events[2][1][1] ~= day or tempAlt.events[2][1][2] ~= month ) then
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + #alts;
                    GRMsyncGlobals.updatesEach[5] = GRMsyncGlobals.updatesEach[5] + #alts;
                end

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

-- Method:          GRM.ResetBirthdayForAltGroup ( string , int , bool , string , bool )
-- What it Does:    Resets the birthdays for the player and all the alts connected in the group
-- Purpose:         Birthday is universal of an alt grouping... keeps them together.
-- Note:            It does leave a timstamp of the change so that you will not resync the player data again from other players, if you wanted to remove the bday.
--                  This is a unique removal to just yourself.
GRM.ResetBirthdayForAltGroup = function ( name , timestamp , isUnknown , sender , isFullSync )

    local player = GRM.GetPlayer ( name );

    if player then

        timestamp = timestamp or time();

        -- Live frame update on the fly
        local updateUI = function ( altName )
            if not isUnknown and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == altName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailBirthdayButton:Show();
                GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:Hide();
            end
        end

        if isFullSync and player.events[2][1][1] ~= 0 then
            -- Only count if actually making a change, not if just updating the timestamp
            GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
            GRMsyncGlobals.updatesEach[5] = GRMsyncGlobals.updatesEach[5] + 1;
        end

        player.events[2] = { { 0 , 0 , 0 } , false , "" , timestamp };

        if not isUnknown then
            player.birthdayUnknown = false;
        end

        updateUI ( name );
        GRM.RemoveFromCalendarQue ( player.name , 2 , nil );

        local alts = GRM.GetAltNamesList ( player );
        local tempAlt;
        for i = 1 , #alts do
            tempAlt = GRM.GetPlayer ( alts[i] );

            if tempAlt then

                if i == 1 and isFullSync and tempAlt.events[2][1][1] ~= 0 then
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + #alts;
                    GRMsyncGlobals.updatesEach[5] = GRMsyncGlobals.updatesEach[5] + #alts;
                end

                tempAlt.events[2] = { { 0 , 0 , 0 } , false , "" , timestamp };

                GRM.RemoveFromCalendarQue ( tempAlt.name , 2 , nil );

                if not isUnknown then
                    tempAlt.birthdayUnknown = false;
                else
                    tempAlt.birthdayUnknown = true;
                end

                updateUI ( alts[i] );
            end
        end

        if not isFullSync then
            -- No need to run this if on sync
            if not sender then
                if GRM.S().syncEnabled then
                    local syncRankFilter = GRM.S().syncRank;
                    if GRM.S().exportAllRanks then
                        syncRankFilter = GuildControlGetNumRanks() - 1;
                    end
                    GRMsync.SendMessage ( "GRM_SYNC" , "GRM_BDAYREM?" .. syncRankFilter .. "?" .. name .. "?" .. tostring ( timestamp ) , "GUILD" );
                end

                if #alts > 0 then
                    GRM.Report ( GRM.L ( "{name}'s alt grouping has had their Birthday removed" , GRM.GetClassifiedName ( name , true ) ) );
                else
                    GRM.Report ( GRM.L ( "{name}'s Birthday has been removed." , GRM.GetClassifiedName ( name , true ) ) );
                end

            elseif GRM.S().syncChatEnabled then
                local msg = "";
                if #alts > 0 then
                    GRM.Report ( GRM.L ( "{name}'s alt grouping has had their Birthday removed by: {name2}" , GRM.GetClassifiedName ( name , true ) , GRM.GetClassifiedName ( sender , true ) ) );
                else
                    msg = "{name}'s Birthday has been removed by: {name2}";
                end
                GRM.Report ( GRM.L ( msg , GRM.GetClassifiedName ( name , true ) , GRM.GetClassifiedName ( sender , true ) ) );
            end
        end

        updateUI ( name );
    end
end

-- Method:          GRM.SyncBirthdayWithNewAlt ( string , string , boolean , int )
-- What it Does:    Sets the new alt to the same birthday as the previous alts
-- Purpose:         Keep alts all in sync on the birthday.
GRM.SyncBirthdayWithNewAlt = function ( name , newAlt , useAlt , timestamp )
    local player = {};
    local tempAlt;
    local needToRemoveFromQue = false;


    if useAlt then
        player = GRM.GetPlayer ( newAlt );
    else
        player = GRM.GetPlayer ( name );
    end

    if player and GRM.PlayerHasAlts ( player ) then  -- Validate player found in databse AND player has alts.
        local alts = GRM.GetAltNamesList ( player );

        if timestamp and timestamp ~= player.events[2][4] then
            player.events[2][4] = timestamp;
        end

        for i = 1 , #alts do
            tempAlt = GRM.GetPlayer ( alts[i] );

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

            GRM_UI.RefreshSelectFrames ( false , true , false , true , true , true );
        end
    end
end

----------------------
--- END BDAY LOGIC ---
----------------------

-- When syncing alt Groups, sync to the main of that alt group.