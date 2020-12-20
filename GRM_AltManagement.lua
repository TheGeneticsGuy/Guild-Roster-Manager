
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
    if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][name] then
        id = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][name].altGroup;
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
            if group[1].name == name then
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


-- Method:          GRM.PlayerHasAltsOrIsMain ( string )
-- What it Does:    Returns true if the player has at least 1 alt
-- Purpose:         Useful to save resources to know if a person has alts. No need to do unnecessary alt maintenance or checks otherwise.
GRM.PlayerHasAltsOrIsMainTest = function ( playerName )
    local result = false
    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][playerName];
    if player ~= nil then
        if #player.altGroup > 0 then
            result = true;
        end
    end
    return result;
end

-- Method:          GRM.PlayerIsAnAlt ( playerTable )
-- What it Does:    Returns true if the given player is considered an "alt" not a main, or no designation
-- Purpose:         To inform if the player is an alt more easily.
GRM.PlayerIsAnAltTest = function ( player )
    local result = false;

    if player.altGroup ~= "" and GRM_Alts[GRM_G.guildName][player.altGroup].main ~= player.name then
        result = true;
    end

    return result;
end

-- Method:          GRM.isAltAlreadyAdded ( string , playerTable )
-- What it Does:    Checks if player has already been added, and if so, doesn't do anything.
-- Purpose:         Save a lot of resources and logic processing if it is determined this player has already been added.
GRM.isAltAlreadyAddedTest = function ( altName , player )
    local result = false;

    if #player.altGroup > 0 then
        for i = 1 , #GRM_Alts[GRM_G.guildName][player.altGroup] do
            if GRM_Alts[GRM_G.guildName][player.altGroup][i].name == altName then
                result = true;
                break;
            end
        end
    end
    
    return result;
end

-- Method:          GRM.PlayerHasAlts ( playerTable )
-- What it Does:    Returns true if the player has alts
-- Purpose:         Cleaner code. Easier to call this.
GRM.PlayerHasAlts = function ( player )
    local result = false;

    if player.altGroup ~= "" and #GRM_Alts[GRM_G.guildName][player.altGroup] > 1 then     -- Since they will be on their own list, even if just a main, then
        result = true;
    end

    return result;
end

-- Method:          GRM.GetNumAlts ( string )
-- What it Does:    Returns the number of alts a player has
-- Purpose:         Useful to know to save time on parsing through tables needlessly.
GRM.GetNumAlts = function ( groupID )
    local result = 0;
    if groupID ~= "" and GRM_Alts[GRM_G.guildName][groupID] then
        result = #GRM_Alts[GRM_G.guildName][groupID] - 1; -- minues 1 for the player's own self.
    end

    return result;
end

-- Method:          GRM.GetAltsGroup ( string )
-- What it Does:    Returns the alt grouping table if a given groupID
-- Purpose:         Easy lookup
GRM.GetAltsGroup = function ( altGroupID )
    if altGroupID ~= "" and GRM_Alts[GRM_G.guildName][altGroupID] then
        return GRM_Alts[GRM_G.guildName][altGroupID];
    else
        return {};
    end
end

-- Method:          GRM.GetListOfAlts ( playerTable )
-- What it Does:    Returns the list of all of the alts from the alt Grouping, not including the player's own self, as well as their class Name
-- Purpose:         Useful to UI function easy lookup
GRM.GetListOfAlts = function ( player )
    local names = {};

    if player.altGroup ~= "" then
        for i = 1 , #GRM_Alts[GRM_G.guildName][player.altGroup] do
            if GRM_Alts[GRM_G.guildName][player.altGroup][i].name ~= player.name then
                table.insert ( names , { GRM_Alts[GRM_G.guildName][player.altGroup][i].name , GRM_Alts[GRM_G.guildName][player.altGroup][i].class } );
            end
        end

    end

    return names
end

GRM.AddAltTest = function ( playerName , altName , isSync , syncTimeStamp )

    if not playerName then
        return;
    end
    
    if playerName == altName then
        GRM.Report ( GRM.L ( "{name} cannot become their own alt!" , GRM.FormatName ( playerName ) ) );
    else
        local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][playerName];
        local alt = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][altName];
        local timeOfChange = 0;
        local isMain = false;
        local classMain , classAlt = "" , "";
        

        -- Method:          Adding alt to the player grouping
        -- This means:      Player has no alts, but the alt is already part of an alt group...
        local addToAltGroup = function( addToAltGroup )
            local memberToAdd = player;
            local groupID = alt.altGroup;

            if not addToAltGroup then
                memberToAdd = alt;
                groupID = player.altGroup;
            end

            -- Ok, remove the player's main status and group as needed, since they don't have any alts.
            if memberToAdd.isMain then
                -- Since player is the main already, we are going to drop the alt's main status
                memberToAdd.isMain = false;
                memberToAdd.mainStatusChangeTime = timeOfChange;
                GRM_Alts[GRM_G.guildName][memberToAdd.altGroup] = nil; -- Clear that alt grouping

                if memberToAdd.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                end

            end

            -- Set new altGroup ID 
            memberToAdd.altGroup = groupID;

            table.insert ( GRM_Alts[GRM_G.guildName][memberToAdd.altGroup] , {} );
            GRM_Alts[GRM_G.guildName][memberToAdd.altGroup].timeOfChange = timeOfChange;
            GRM_Alts[GRM_G.guildName][memberToAdd.altGroup][#GRM_Alts[GRM_G.guildName][memberToAdd.altGroup]].name = memberToAdd.name;
            GRM_Alts[GRM_G.guildName][memberToAdd.altGroup][#GRM_Alts[GRM_G.guildName][memberToAdd.altGroup]].class = memberToAdd.class;

            sort ( GRM_Alts[GRM_G.guildName][memberToAdd.altGroup] , function ( a , b ) return a.name < b.name end );
        end

        timeOfChange = syncTimeStamp or time();

        -- Error Protection check
        if alt and player then
            classMain = player.class;
            classAlt = alt.class;

            if not isSync and GRM.PlayerIsAnAltTest ( alt ) then
                GRM_G.selectedAltGroup = alt.altGroup;
            end
        elseif not isSync then
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Failed to add alt for unknown reason. Try closing Roster window and retrying!" ) );
            return
        end
        if player.altGroup == alt.altGroup or GRM.isAltAlreadyAdded ( altName , player ) then
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
                alt.mainStatusChangeTime = timeOfChange;
                GRM.RemoveAltTest ( alt.name , isSync , timeOfChange )

                -- Then, we add to the new list and set the change times
                alt.altGroup = player.altGroup;
                alt.altGroupModified = timeOfChange;

                table.insert ( GRM_Alts[GRM_G.guildName][alt.altGroup] , {} );
                GRM_Alts[GRM_G.guildName][alt.altGroup].timeOfChange = timeOfChange;
                GRM_Alts[GRM_G.guildName][alt.altGroup][#GRM_Alts[GRM_G.guildName][alt.altGroup]].name = alt.name;
                GRM_Alts[GRM_G.guildName][alt.altGroup][#GRM_Alts[GRM_G.guildName][alt.altGroup]].class = alt.class;

                sort ( GRM_Alts[GRM_G.guildName][alt.altGroup] , function ( a , b ) return a.name < b.name end );
        
                if alt.name == GRM_G.currentName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                end

            else
                -- Only the alt has a group... so let's add the player to the alt group
                -- Still need to determine if player is main - and if so, logic to check if alt is main as well...
                addToAltGroup( true );

            end

        elseif GRM.PlayerHasAlts ( player ) then
            -- Player has alts, alt does not, so let's add the alt to the player

            addToAltGroup( false );
        
        else

            -- Alt is a main - is the player too?
            if alt.isMain then

                -- Player is main?
                if player.isMain then
                    -- Since player AND alt are main, we are going to keep player's status and remove the alt's main status.
                    alt.isMain = false;
                    alt.mainStatusChangeTime = timeOfChange;
                    GRM_Alts[GRM_G.guildName][alt.altGroup] = nil;
                    alt.altGroup = player.altGroup;
                    alt.altGroupModified = timeOfChange;

                    table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
                    GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timeOfChange;
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].name = alt.name;
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].class = alt.class;

                    if alt.name == GRM_G.currentName then
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
                    end


                else
                    -- Since alt IS a main, but the player isn't, we are going to join the player to the alt's group
                    player.altGroup = alt.altGroup;
                    player.altGroupModified = timeOfChange;
                    table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
                    GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timeOfChange;
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].name = player.name;
                    GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].class = player.class;

                end

            else
                -- alt has no alts and isn't main, thus no alt group

                -- Let's see if player already has an altGroup
                if not player.isMain then
                    player.altGroup = GRM.CreateNewAltGroupID();
                    GRM_Alts[GRM_G.guildName][player.altGroup] = {};
                    GRM_Alts[GRM_G.guildName][player.altGroup].main = "";
                end

                alt.altGroup = player.altGroup;

                GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timeOfChange; 
                table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
                GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].name = alt.name;
                GRM_Alts[GRM_G.guildName][player.altGroup][#GRM_Alts[GRM_G.guildName][player.altGroup]].class = alt.class;

            end
        end

        -- LIVE UPDATE THE FRAMES
        if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

            if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_G.currentName].altGroup == alt.altGroup then
                GRM.PopulateAltFrames ( GRM_G.currentName );
            end
        end

    end

end

-- Method:          GRM.RemoveAlt(string , string , boolean , int , boolean )
-- What it Does:    Detags the given altName to that set of toons.
-- Purpose:         Alt management, so whoever has addon installed can tag player as alts and mains and manipulate easily.
GRM.RemoveAltTest = function ( playerName , isSync , timestamp )

    if not playerName then
        return;
    end

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][playerName];

    if player then

        timestamp = timestamp or time();

        -- Ok, remove him from the grouping...
        for i = 1 , #GRM_Alts[GRM_G.guildName][player.altGroup] do
            if GRM_Alts[GRM_G.guildName][player.altGroup][i].name == player.name then
                table.remove ( GRM_Alts[GRM_G.guildName][player.altGroup] , i );
                GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timestamp;
                break;
            end
        end
        
        -- Check if no players left in the grouping, and if so, clear it from existence.
        if #GRM_Alts[GRM_G.guildName][player.altGroup] == 0 then
            GRM_Alts[GRM_G.guildName][player.altGroup] = nil;

        -- Still at least 1 player in the grouping, so let's check if the player was the main, and if they were, clear the main status.
        elseif GRM_Alts[GRM_G.guildName][player.altGroup].main == player.name then
            GRM_Alts[GRM_G.guildName][player.altGroup].main = "";
        end

        -- Now, if the player WAS a main, let's set him to main in his own solo group.
        if player.isMain then
            player.altGroup = GRM.CreateNewAltGroupID();
            GRM_Alts[GRM_G.guildName][player.altGroup] = {};
            GRM_Alts[GRM_G.guildName][player.altGroup].main = player.name;
            GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timestamp;

            GRM_Alts[GRM_G.guildName][player.altGroup][1] = {};
            GRM_Alts[GRM_G.guildName][player.altGroup][1].name = player.name;
            GRM_Alts[GRM_G.guildName][player.altGroup][1].class = player.class;
            
        else
            player.altGroup = "";
        end

        player.altGroupModified = timestamp;

        -- LIVE FRAMES UPDATE
        if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

            if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_G.currentName].altGroup == player.altGroup then
                GRM.PopulateAltFrames ( GRM_G.currentName );
            end
        end
    end

end

-- Method:          GRM.AddPlayerToOwnAltList()
-- What it Does:    For the first time a player logs on that toon, or joins a guild with that toon, it adds them to their own alt list.
-- Purpose:         For easy alt management. AUTO adds alt info for a guild :D
GRM.AddPlayerToOwnAltListTest = function()
    -- Ok, now let's add the player to an alt list...
    -- First, find the player in member save and determine if they are the main, if not, check his alt list, determine who is main.
    -- if no main, first person on list can add.
    -- if main, then main will add this player.
    local playerIsFound = false;
    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_G.addonUser];

    if player ~= nil then
        playerIsFound = true;
        -- Ok, adding the player!
        GRM_PlayerListOfAlts_Save[GRM_G.F][GRM_G.guildName][GRM_G.addonUser] = {};


        -- if the player already is on a list, let's not add them automatically.
        if player.altGroup == "" then
            -- Ok, good, let's check the alt list!

            if GRM.GetNumKeyedEntries ( GRM_PlayerListOfAlts_Save[GRM_G.F][GRM_G.guildName] ) > 1 then    -- No need if it is just myself - if number of entries == 1 then it is just me
                -- Ok great, there is already another player in the guild! Let's put them into the same alt grouping!

                local isAdded = false;
                for altName in pairs ( GRM_PlayerListOfAlts_Save[GRM_G.F][GRM_G.guildName] ) do
                    -- Make sure it is not the player.
                    if altName ~= GRM_G.addonUser and GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][altName] then

                        if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][altName].isMain then
                            -- ADD ALT HERE!!!!!!
                            GRM.AddAltTest ( GRM_G.addonUser , altName , false , time() );
                            GRM.SyncBirthdayWithNewAltTest ( GRM_G.addonUser );
                            isAdded = true;
                            break;
                        end

                    end
                end

                -- if it was not added, then add it here! No alt was set as main.
                if not isAdded then
                    for altName in pairs ( GRM_PlayerListOfAlts_Save[GRM_G.F][GRM_G.guildName] ) do
                        -- Make sure it is not the player.
                        if altName ~= GRM_G.addonUser then
                            GRM.AddAltTest ( GRM_G.addonUser , altName , false , time() );
                            GRM.SyncBirthdayWithNewAltTest ( GRM_G.addonUser );
                            break;
                        end
                    end
                end
            end
        end
    end
    -- Player was just invited, and his metadata details have not been populated as of yet. Let's retry in a moment.
    if not playerIsFound then
        C_Timer.After ( 5 , function()
            GRM.AddPlayerToOwnAltList();
        end);
    end
end

-- Method:          GRM.SyncBirthdayWithNewAlt ( string )
-- What it Does:    Sets the new alt to the same birthday as the previous alts
-- Purpose:         Keep alts all in sync on the birthday.
GRM.SyncBirthdayWithNewAltTest = function ( newAlt )
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local player = guildData[newAlt];
    local tempAlt;

    if player and GRM.PlayerHasAlts ( player ) then                                             -- Validate player found in databse AND playerr has alts.
        for i = 1 , #GRM_Alts[GRM_G.guildName][player.altGroup] do
            if GRM_Alts[GRM_G.guildName][player.altGroup][i].name ~= player.name then
                tempAlt = guildData[GRM_Alts[GRM_G.guildName][player.altGroup][i].name ];

                if tempAlt then
                    if tempAlt.events[2][3] ~= "" or ( tempAlt.events[2][3] == "" and #tempAlt.alts == 1 and not tempAlt.isMain and player.events[2][3] ~= "" ) then -- We only need to check the first alt as all should have same
                        
                        local updatePos1 = newAlt;
                        local updatePos2 = tempAlt.name;
                        -- reverse them if the player I am overriding is the main.                                                                                                                                                          -- Neither of them are set as mains... so 1 with date takes priority
                        if #player.alts == 1 and ( player.isMain or ( not player.isMain and not tempAlt.isMain and player.events[2][4] ~= 0 ) ) then
                            updatePos1 = tempAlt.name;
                            updatePos2 = newAlt;
                        end
                        
                        guildData[updatePos1].events[2][1] = guildData[updatePos2].events[2][1];
                        guildData[updatePos1].events[2][2] = guildData[updatePos2].events[2][2];
                        guildData[updatePos1].events[2][3] = guildData[updatePos2].events[2][3];
                        guildData[updatePos1].events[2][4] = guildData[updatePos2].events[2][4];

                        if guildData[updatePos1].birthdayUnknown then
                            guildData[updatePos1].birthdayUnknown = false
                        end

                        GRM.RemoveFromCalendarQue ( guildData[updatePos1].name , 2 , nil );

                        -- Update frames if looking at them on the spot...
                        if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and guildData[updatePos1].name == GRM_G.currentName and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].showBDay and guildData[updatePos1].events[2][3] ~= "" then
                            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailBirthdayButton:Hide();
                            GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:SetText ( GRM.FormatTimeStamp ( guildData[updatePos1].events[2][3] , false , true ) );
                            GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:Show();
                        end

                        if GRM_UI.GRM_RosterChangeLogFrame.GRM_EventsFrame:IsVisible() then
                            GRM.RefreshAddEventFrame()
                        end

                    -- Only purge the date if being added to a group with no date of more than just you, OR, if the "main" does not have a date...
                    elseif tempAlt.events[2][3] == "" and ( #tempAlt.alts > 1 or ( #tempAlt.alts == 1 and tempAlt.isMain ) ) then
                        -- New alt grouping does not have a birthday seet, so let's remove the birthday of incoming alt if set...
                        player.events[2] = { { 0 , 0 , 0 } , false , "" , 0 };
                        if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and player.name == GRM_G.currentName and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].showBDay then
                            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailBirthdayButton:Show();
                            GRM_UI.GRM_MemberDetailMetaData.GRM_BirthdayText:Hide();
                        end
                    end
                end
            end
        end
    end
end

-- Method:              GRM.SetMain ( string , string , boolean , int )
-- What it Does:        Sets the player as main, as well as updates that status among the alt grouping.
-- Purpose:             Main/alt management control.
GRM.SetMainTest = function ( mainName , isSync , timestamp )
    if not mainName then
        return;
    end

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][mainName];
    timestamp = timestamp or time();

    -- if player is in a group or not
    player.isMain = true;
    player.mainStatusChangeTime = timestamp;
    
    if player.name == GRM_G.currentName then
        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
        GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
    end
    
    if player.altGroup ~= "" then
        
        if GRM_Alts[GRM_G.guildName][player.altGroup].main ~= "" and GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_Alts[GRM_G.guildName][player.altGroup].main] then
            GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_Alts[GRM_G.guildName][player.altGroup].main].isMain = false;
            GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_Alts[GRM_G.guildName][player.altGroup].main].mainStatusChangeTime = timestamp;

            if GRM_Alts[GRM_G.guildName][player.altGroup].main == GRM_G.currentName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
            end
        end

        GRM_Alts[GRM_G.guildName][player.altGroup].main = player.name;
        GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timestamp;

    else
        -- No group, no one set as main. Let's create a new group
        player.altGroup = GRM.CreateNewAltGroupID();
        GRM_Alts[GRM_G.guildName][player.altGroup] = {};
        GRM_Alts[GRM_G.guildName][player.altGroup].main = player.name;
        GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timestamp;

         
        table.insert ( GRM_Alts[GRM_G.guildName][player.altGroup] , {} );
        GRM_Alts[GRM_G.guildName][player.altGroup][1].name = player.name;
        GRM_Alts[GRM_G.guildName][player.altGroup][1].class = player.class;
        player.altGroupModified = timestamp;

    end

    -- LIVE FRAMES UPDATE
    if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

        if player.name == GRM_G.currentName then
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Show();
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Hide();
        end

        if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_G.currentName].altGroup == player.altGroup then
            GRM.PopulateAltFrames ( GRM_G.currentName );
        end
    end

end

-- Method:              GRM.DemoteFromMain ( string , string , boolean , int )
-- What it Does:        If the player is "main" then it removes the main tag to false
-- Purpose:             User Experience (UX) and alt management!
GRM.DemoteFromMainTest = function ( mainName , isSync , timestamp )

    if not mainName then
        return;
    end

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][mainName];
    timestamp = timestamp or time();

    if player then
        if GRM_Alts[GRM_G.guildName][player.altGroup].main == player.name then
            GRM_Alts[GRM_G.guildName][player.altGroup].main = "";
            GRM_Alts[GRM_G.guildName][player.altGroup].timeOfChange = timestamp;

            player.isMain = false;
            player.mainStatusChangeTime = timestamp;

            if player.name == GRM_G.currentName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
            end
        end
    end

    -- LIVE FRAMES UPDATE
    if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then

        if player.name == GRM_G.currentName then
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailAltText:Show();
        end

        if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_G.currentName].altGroup == player.altGroup then
            GRM.PopulateAltFrames ( GRM_G.currentName );
        end
    end

end

-- Method:          GRM.GetAltTag ( int )
-- What it Does:    Returns the hex value/colored string with the alt or main tag
-- Purpose:         For taggin the autocomplete names to make it easier to see who is and isn't and alt/main
GRM.GetAltTag = function ( value )
    local result = "";
    local mainDisplay = GRM.GetMainTags ( false , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].mainTagIndex );
    local altDisplay = GRM.GetAltTags ( false , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].mainTagIndex );
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
GRM.AddAltAutoCompleteTest = function()
    local partName = GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:GetText();
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local tag = 0;
    local matches = {};

    for _ , player in pairs ( guildData ) do
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

                table.insert ( matches , { player.name , player.class , tag } );
            end
        end
    end
    -- Need to sort "Complex" table
    sort ( matches , function ( a , b ) return a[1] < b[1] end );    -- Alphabetizing it for easier parsing for buttontext updating. - This sorts the first index of the 2D array
    
    -- Now, let's identify the names that match
    local matchingList = {};
    local found = false;
    local innerFound = false;
    for i = 1 , #matches do
        innerFound = false;
        if string.lower ( partName ) == string.lower ( string.sub ( matches[i][1] , 1 , #partName ) ) then
            innerFound = true;
            found = true;
            table.insert ( matchingList , matches[i] );
        end
        if #matchingList == GRM_G.MaxAltAutoCompleteList then
            break;
        end
        if innerFound ~= true and found then    -- resource saving
            break;
        end
    end

    -- If No alphabetical matches, try partial
    if #matchingList == 0 then
        for i = 1 , #matches do
            if string.find ( string.lower ( matches[i][1] ) , string.lower ( partName ) ) ~= nil then
                table.insert ( matchingList , matches[i] );
            end
            if #matchingList == GRM_G.MaxAltAutoCompleteList then
                break;
            end
        end
    end
    
    -- Populate the buttons now...
    if partName ~= nil and partName ~= "" then
        local resultCount = #matchingList;
        if resultCount > 0 then
            GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:Hide();
            GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Hide();
            GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:Show();
            GRM.BuildAutoCompleteAltSelectionScrollFrame ( matchingList );
            GRM_G.currentHighlightIndex = 1;
            GRM.ResetAutoCompleteHighlights();
            GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[1][1]:LockHighlight();
        else
            GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:Show();
            GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Show();
            GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:Hide();
            -- Hide the buttons
            if GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons then
                for i = 1 , #GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons do
                    GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i][1]:Hide();
                end
            end
            if string.lower ( GRM_G.currentName ) == string.lower ( partName ) then
                GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetText ( GRM.L ( "Player Cannot Add Themselves as an Alt" ) );
                GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Hide();
            else
                GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetText ( GRM.L ( "Player Not Found" ) );
            end
        end          
    else
        if GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons then
            for i = 1 , #GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons do
                GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i][1]:Hide();
            end
        end
        GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:Hide();
        GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetText ( GRM.L ( "Please Type the Name of the alt" ) );
        GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:Show();
        GRM_UI.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:Show();
    end
end

-- Method:              GRM.KickAllAlts ( string )
-- What it Does:        Bans all listed alts of the player as well and adds them to the ban list. Of note, addons cannot kick players anymore, so this only adds to ban list.
-- Purpose:             QoL. Option to ban players' alts as well if they are getting banned.
GRM.KickAllAltsTest = function ( playerName )
    GRM_G.KickAllAltsTable = {};
    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][playerName];

    if player then
    -- Ok, let's parse the player's data!
        local tempAlt;
        local instructionNote = GRM.L ( "Reason Banned?" ) .. "\n" .. GRM.L ( "Click \"YES\" When Done" );
        local result = "";

        if #GRM.GetNumAlts ( player.altGroup ) > 0 and ( GRM_G.isChecked2 or GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_BanAllAltsCheckbox:GetChecked() ) then
            local index;
            local listOfAlts = GRM.GetAltsGroup ( player.altGroup );

            for i = 1 , #listOfAlts do
                if listOfAlts[i].name ~= player.name and listOfAlts[i].name ~= GRM_G.addonUser then
                    tempAlt = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][listOfAlts[i].name];

                    -- The banning...
                    if GRM_G.isChecked or GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_BanAllAltsCheckbox:GetChecked() then
                        tempAlt.bannedInfo[1] = true;
                        tempAlt.bannedInfo[2] = time();
                        tempAlt.bannedInfo[3] = false;
                        tempAlt.bannedInfo[4] = GRM_G.addonUser;

                        if GRM_UI.GRM_MemberDetailPopupEditBox:IsVisible() then
                            result = GRM_UI.GRM_MemberDetailPopupEditBox:GetText();
                        elseif GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanReasonEditBox:IsVisible() then
                            result = GRM.Trim ( GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanReasonEditBox:GetText() );
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
    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][playerName];
    local alts = GRM.GetListOfAlts ( player );
    local numAlts = #alts;
    local main = "";
    
    if player.altGroup ~= "" then
        main = GRM_Alts[GRM_G.guildName][player.altGroup].main;
    end
    local color = {};

    GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:Show();
    GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame:Show();
    local scrollHeight = 0;
    local scrollWidth = 128;
    local buffer = 1;

    GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons = GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons or {};  -- Create a table for the Buttons.
    -- populating the window correctly.
    for i = 1 , numAlts do
        -- if font string is not created, do so.
        if not GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i] then
            local tempButton = CreateFrame ( "Button" , "GRM_AltAdded" .. i , GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame ); -- Names each Button 1 increment up
            GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i] = { tempButton , tempButton:CreateFontString ( "GRM_AltAddedText" .. i , "OVERLAY" , "GameFontWhiteTiny" ) };
        end

        if i == numAlts and #GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons > numAlts then
            for j = numAlts + 1 , #GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons do
                GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[j][1]:Hide();
            end
        end

        local AltButtons = GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][1];
        local AltButtonsText = GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][2];
        AltButtons:SetSize ( 65 , 15 );
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
        AltButtonsText:SetWidth ( 60 );

        if i == 1 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].fontModifier > 0 and string.find ( name , GRM.L ( "(main)" ) ) ~= nil then
            AltButtonsText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 7.5 );
        else
            AltButtonsText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 7.5 );
        end
        
        AltButtonsText:SetPoint ( "CENTER" , AltButtons );
        AltButtonsText:SetJustifyH ( "CENTER" );

        -- Logic
        AltButtons:SetScript ( "OnClick" , function ( self , button )
            if button == "RightButton" then
                -- Parse the button number, so the alt position can be identified...
                local altNum = tonumber ( string.match ( self:GetName() , "%d" ) );
                local isMain = false;
                local width = 70;
                local height = 85;
                    

                -- Ok, populate the buttons properly...
                GRM_G.pause = true;
                GRM_UI.GRM_altDropDownOptions:ClearAllPoints();
                GRM_UI.GRM_altDropDownOptions:SetPoint( "TOPRIGHT" , self , "BOTTOM" );

                if string.find ( AltButtonsText:GetText() , GRM.L ( "(main)" ) ) == nil then
                    GRM_UI.GRM_altSetMainButtonText:SetText ( GRM.L ( "Set as Main" ) );
                    GRM_UI.GRM_altDropDownOptions.GRM_altOptionsText:SetText ( AltButtonsText:GetText() );
                else -- player IS the main... place option to Demote From Main rahter than set as main.
                    GRM_UI.GRM_altSetMainButtonText:SetText ( GRM.L ( "Set as Alt" ) );
                    isMain = true;
                    GRM_UI.GRM_altDropDownOptions.GRM_altOptionsText:SetText ( string.sub ( AltButtonsText:GetText() , 1 , string.find ( AltButtonsText:GetText() , "\n" ) - 1 ) );
                end

                if GRM_UI.GRM_altDropDownOptions.GRM_altOptionsText:GetStringWidth() + 15 > width then       -- For scaling the frame based on size of player name.
                    width = GRM_UI.GRM_altDropDownOptions.GRM_altOptionsText:GetStringWidth() + 15;
                end
                if GRM_UI.GRM_altSetMainButtonText:GetStringWidth() + 15 > width then
                    width = GRM_UI.GRM_altSetMainButtonText:GetStringWidth() + 15;
                end
                if GRM_UI.GRM_altRemoveButtonText:GetStringWidth() + 15 > width then
                    width = GRM_UI.GRM_altRemoveButtonText:GetStringWidth() + 15;
                end

                GRM_UI.GRM_altDropDownOptions:SetSize ( width , height );
                GRM_UI.GRM_altRemoveButton:SetSize ( 80 , 20 );
                GRM_UI.GRM_altSetMainButton:SetSize ( 80 , 20 );
                GRM_UI.DisableVerifyButton();
                GRM_UI.GRM_altRemoveButtonText:SetText ( GRM.L ( "Remove" ) );
                GRM_UI.GRM_ConfirmDropdownButton:Hide();
                GRM_UI.GRM_altDropDownOptions.GRM_MergeDateOverButton:Hide();
                GRM_UI.GRM_altRemoveButton:Show();
                GRM_UI.GRM_altDropDownOptions:Show();

                -- Set the Global info now!
                local currentPLayer = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_G.currentName];
                if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRM_G.currentName] then
                    GRM_G.selectedAlt = { GRM_G.currentName , GRM.GetListOfAlts ( currentPLayer )[altNum][1] , GRM_G.guildName , isMain };
                end
            elseif button == "LeftButton" then
                if not IsShiftKeyDown() then
                    if GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailServerNameToolTip:IsVisible() and not GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailNameText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                        -- This makes the main window the alt that was clicked on! TempAltName is saved when mouseover action occurs.
                        if GRM_G.tempAltName ~= "" then
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
            AltButtons:SetPoint( "TOPLEFT" , GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame , 0 , - 1 );
            scrollHeight = scrollHeight + AltButtons:GetHeight();
        elseif i == 2 then
            AltButtons:SetPoint( "TOPLEFT" , GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i - 1][1] , "TOPRIGHT" , 1 , 0 );
        else
            AltButtons:SetPoint( "TOPLEFT" , GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i - 2][1] , "BOTTOMLEFT" , 0 , - buffer );
            if i % 2 ~= 0 then
                scrollHeight = scrollHeight + AltButtons:GetHeight() + buffer;
            end
        end
        AltButtons:Show();
    end

    -- Pin the button
    if numAlts == 0 then
        GRM_UI.GRM_AddAltButton2:ClearAllPoints();
        GRM_UI.GRM_AddAltButton2:SetPoint ( "TOP" , GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame , "TOP" , 0 , - 1 );
    elseif numAlts == 1 then
        GRM_UI.GRM_AddAltButton2:ClearAllPoints();
        GRM_UI.GRM_AddAltButton2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[1][1] , "TOPRIGHT" , 1 , 0 );
    else
        GRM_UI.GRM_AddAltButton2:ClearAllPoints();
        GRM_UI.GRM_AddAltButton2:SetPoint ( "TOP" , GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[numAlts - 1][1] , "BOTTOM" , 0 , - buffer);
        if numAlts % 2 == 0 and numAlts > 12 then
            scrollHeight = scrollHeight + GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[numAlts - 1][1]:GetHeight() + buffer;
        end
    end
    GRM_UI.GRM_AddAltButton2:Show();

    if numAlts > 12 then
        if GRM_UI.GRM_MemberDetailMetaData.GRM_GroupInviteButton:IsVisible() then
            GRM_UI.GRM_MemberDetailMetaData.GRM_SafeFromRulesButton:SetPoint ( "LEFT" , GRM_UI.GRM_MemberDetailMetaData.GRM_GroupInviteButton , "RIGHT" , 5 , 0 );
        end
    end

    -- Update the size -- it either grows or it shrinks!
    GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame:SetSize ( scrollWidth , scrollHeight );

    --Set Slider Parameters ( has to be done after the above details are placed )
    local scrollMax = ( scrollHeight - GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:GetHeight() ) + ( buffer * .5 );
    if scrollMax < 0 then
        scrollMax = 0;
    end
    
    GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetMinMaxValues ( 0 , scrollMax );
    -- Mousewheel Scrolling Logic
    GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:EnableMouseWheel( true );
    GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:SetScript( "OnMouseWheel" , function( _ , delta )
        local current = GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:GetValue();
        
        if IsShiftKeyDown() and delta > 0 then
            GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( 0 );
        elseif IsShiftKeyDown() and delta < 0 then
            GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( scrollMax );
        elseif delta < 0 and current < scrollMax then
            GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( current + 20 );
        elseif delta > 0 and current > 1 then
            GRM_UI.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue ( current - 20 );
        end
    end);
    GRM_UI.GRM_CoreAltFrame:Show();
end