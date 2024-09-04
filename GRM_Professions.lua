local Prof = {};

GRM.Prof = Prof;

local profEnum = { [164] = "BS" , [165] = "LW" , [171] = "Alc" , [182] = "Herb" , [186] = "Mine" , [197] = "TL" , [202] = "Eng" , [333] = "Ench" , [393] = "Skin" , [755] = "JC" , [773] = "Insc" };

-- Method:          Prof.GetProfessionTag ( int )
-- What it Does:    Returns the profession tag to be used when showing player professions
-- Purpose:         Quality of life information
Prof.GetProfessionTag = function ( professionID )
    return GRM.L ( profEnum[professionID] );
end

-- Method:          Prof.GetProfessionNameByID ( int )
-- What it Does:    Returns the localized name of the profession
-- Purpose:         Information for player on members in the guild and their professions
Prof.GetProfessionNameByID = function ( id )
    return C_TradeSkillUI.GetTradeSkillDisplayName ( id );
end

-- Method:          Prof.GetProfessionIcon ( int )
-- What it Does:    Returns the profession icon file to be set as texture
-- Purpose:         Easily call the profession texture icons
Prof.GetProfessionIcon = function ( id )
    return WORLD_QUEST_ICONS_BY_PROFESSION[ id ];
end

-- Method:          Prof.GetProfessionsNote ( string )
-- What it Does:    Returns the string formatted representation of player's professions and rank
-- Purpose:         Build a clean and concise format for the player's notes
Prof.GetProfessionsNote = function ( name )
    local notes = {};
    local player = GRM.GetPlayer ( name );

    -- Initialize the pattern
    if not GRM_G.professionNoteFormat then
        GRM_G.professionNoteFormat = "[{name}]{num}";
        GRM_L[GRM_G.professionNoteFormat] = true;
    end

    if player and player.prof1 and player.prof2 then

        -- Same number so let's format it differently.
        if #player.prof1 > 0 and #player.prof2 > 0 and player.prof1[2] == player.prof2[2] then
            return ( "[" .. Prof.GetProfessionTag ( player.prof1[1] ) .. "]/[" .. Prof.GetProfessionTag ( player.prof2[1] ) .. "]" .. player.prof1[2] ); -- [Alch]/[Eng]-300

        else
            if #player.prof1 > 0 then
                table.insert ( notes , GRM.L ( GRM_G.professionNoteFormat , Prof.GetProfessionTag ( player.prof1[1] ) , nil , player.prof1[2] ) );
            end

            if #player.prof2 > 0 then
                table.insert ( notes , GRM.L ( GRM_G.professionNoteFormat , Prof.GetProfessionTag ( player.prof2[1] ) , nil , player.prof2[2] ) );
            end
        end
    end

    if #notes > 1 then
        return notes[1] .. "/" .. notes[2];
    else
        return notes[1];
    end
    return
end

-- Method:          Prof.AppendProfessionReportToNote ( string , int )
-- What it Does:    Updates the note of the player with the profession details, and overwrites old if necessary
-- Purpose:         Add professions to Classic usefulness
Prof.AppendProfessionReportToNote = function ( name , destination )

    local player = GRM.GetPlayer ( name );
    local note, officerNote, customNote = "" , "" , "";
    local pattern = "%[[^%]]+%]%-?%d%d?%d?";                            -- 1 profession [Eng]-300
    local pattern2 = "%[[^%]]+%]%-?%d%d?%d?/%[[^%]]+%]%-?%d%d?%d?";     -- 2 profession [Eng]-300/[Alch]-250
    local pattern3 = "%[[^%]]+%]/%[[^%]]+%]%-?%d%d?%d?";                -- Same Level   [Eng]/[Alch]-300
    local updatedNote = "";
    local success = false;
    local sizeTooBig = 0;
    local countOfChanges = 0;

    -- Function to control handling of the note formatting and replacement of old info no matter where the destination.
    local updateNote = function ( pendingNote , notes , size )
        local updatedNote = "";
        size = size or 31;

        if pendingNote then
            if not string.find ( pendingNote , "[D]" ) then     -- Need to make sure we don't override any death note here.
                if string.match ( pendingNote , pattern3 ) then                 -- 2 professions found - Both with same level
                    updatedNote = string.gsub ( pendingNote , pattern3 , notes );
                elseif string.match ( pendingNote , pattern2 ) then             -- 2 professions found
                    updatedNote = string.gsub ( pendingNote , pattern2 , notes );
                elseif string.match ( pendingNote , pattern ) then              -- 1 profession only
                    updatedNote = string.gsub ( pendingNote , pattern , notes );
                else
                    -- Note not found, let's just update the note by appending profession to end.
                    if ( #pendingNote + #notes ) < size then
                        updatedNote = pendingNote .. " " .. notes;
                    else
                        updatedNote = pendingNote .. notes;
                    end
                end
            end
        else
            -- No note exists
            updatedNote = notes;
        end
        return updatedNote
    end

    -- Core Logic
    if player then

        local notes = Prof.GetProfessionsNote( name );
        local index = GRM.GetRosterSelectionID ( player.name , player.GUID );
        if notes and index then

            -- Public Note
            if destination == 1 and ( GRM.CanEditPublicNote() or name == GRM_G.addonUser ) then

                if index then
                    note = select( 7, GetGuildRosterInfo(index) );

                    updatedNote = updateNote ( note , notes );

                    if updatedNote ~= "" and updatedNote ~= note and #updatedNote < 32 then
                        player.note = updatedNote;
                        GuildRosterSetPublicNote ( index , updatedNote );
                        success = true;

                    elseif updatedNote ~= note and #updatedNote > 31 then
                        sizeTooBig = #updatedNote - 31;
                    end

                end

            -- Officer Note
            elseif destination == 2 and GRM.CanEditOfficerNote() then

                if index then
                    officerNote = select( 8, GetGuildRosterInfo(index) );

                    updatedNote = updateNote ( officerNote , notes );

                    if updatedNote ~= "" and updatedNote ~= officerNote and #updatedNote < 32 then
                        player.officerNote = updatedNote;
                        GuildRosterSetOfficerNote ( index , updatedNote );
                        success = true;

                    elseif updatedNote ~= note and #updatedNote > 31 then
                        sizeTooBig = #updatedNote - 31;
                    end

                end

            -- Custom Note
            elseif destination == 3 then
                customNote = player.customNote[4]
                updatedNote = updateNote ( customNote , notes , GRM_G.MaxCustomNoteSize );

                if updatedNote ~= "" and updatedNote ~= customNote and #updatedNote <= GRM_G.MaxCustomNoteSize then    -- Custom note max

                    Prof.SetCustomNoteDirectly ( player.name , updatedNote );
                    success = true;

                elseif updatedNote ~= note and #updatedNote > GRM_G.MaxCustomNoteSize then
                    sizeTooBig = #updatedNote - GRM_G.MaxCustomNoteSize;
                end
            end

        end

        if success and player.name == GRM_G.currentName and GRM_UI.GRM_MemberDetailMetaData and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
            GRM.PopulateMemberDetails ( GRM_G.currentName );
        end

    end

    return success , sizeTooBig;
end

-- Method:          GRM.SetCustomNoteDirectly ( string , string )
-- What it Does:    Sets the Custom Note, but a slimmed down version so it is not syncing anything
-- Purpose:         Useful for the profession Update
Prof.SetCustomNoteDirectly = function ( name , customNote )
    local player = GRM.GetPlayer ( name );

    if player then

        player.customNote[2] = time();
        player.customNote[3] = GRM_G.addonUser;
        player.customNote[4] = customNote;

    end
end

-- Method:          Prof.InitiateProfessionUpdate( bool , table , table , int )
-- What it Does:    Sets all of the destination notes with the profession report or updates them if they already exist
-- Purpose:         Useful feature in Classic to give access to professions.
-- Notes:           This is throttled as pattern matching a guild say 500+ could cause a slight stutter in one pass.
Prof.InitiateProfessionUpdate = function( showReport , namesProcessed , playersNotUpdated , countOfChanges )

    local guildData = GRM.GetGuild();
    local success;
    local sizeTooBig;
    local count = 0;
    local throttleLimit = 75;
    namesProcessed = namesProcessed or {};
    playersNotUpdated = playersNotUpdated or {};
    countOfChanges = countOfChanges or 0;

    if guildData then
        for name , player in pairs ( guildData ) do
            if type ( player ) == "table" then
                if not namesProcessed[name] then
                    namesProcessed[name] = true;
                    success , sizeTooBig = Prof.AppendProfessionReportToNote ( name , GRM.S().ProfNoteDestination );
                    if success or ( not success and sizeTooBig > 0 ) then
                        if not success then
                            table.insert ( playersNotUpdated , { name , sizeTooBig } )
                        else
                            countOfChanges = countOfChanges + 1;
                        end
                    end

                    count = count + 1;
                    if count >= throttleLimit then
                        C_Timer.After ( 0.3 , function()
                            Prof.InitiateProfessionUpdate ( showReport , namesProcessed , playersNotUpdated , countOfChanges );
                        end);
                        return;
                    end
                end
            end
        end
    end

    Prof.ReportProfChanges ( showReport , playersNotUpdated , countOfChanges );
end

-- Method:          Prof.ReportProfChanges ( bool )
-- What it Does:    Initiates the profession exporting to the notes, or updating, and reports if requested the players unable to be updated
-- Purpose:         Useful information in Classic.
Prof.ReportProfChanges = function ( showReport , playersNotUpdated , countOfChanges )

    GRM_G.playersNotUpdated = playersNotUpdated;
    if showReport then

        if countOfChanges > 0 or #playersNotUpdated > 0 then
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Profession Update Report" ) );

            if countOfChanges > 0 then
                GRM.Report ( GRM.L ( "Total Notes Updated with Profession Details: {num}" , nil , nil , countOfChanges ) );
            end

            if #playersNotUpdated > 0 then
                GRM.Report ( GRM.L ( "Total Notes not able to update: {num}" , nil , nil , #playersNotUpdated ) );
                GRM.Report ( GRM.HL.GenerateHyperlink( "GRM" , "profReport" , nil , GRM.L ( "Click to View All Names" ) , "00ccff" ) );
            end

        else
            GRM.Report ( "\n" ..  GRM.L ( "GRM:" ) .. " " .. GRM.L ( "No Professions Have Changed" ) );
        end

    end
end

-- Method:          Prof.ReportPlayersNotUpdated()
-- What it Does:    Reports the players that need notes updated to the chat window as hyperlinks
-- Purpose:         Make life easier for leader to update player note and make room.
Prof.ReportPlayersNotUpdated = function()
    local limit = 0
    local max = 15;

    if #GRM_G.playersNotUpdated > 0 then
        print("\n");    -- Spacing for Aesthetics
    end

    for i = #GRM_G.playersNotUpdated , 1 , -1 do
        GRM.Report ( GRM.HL.GenerateHyperlink( "GRM" , "openPlayer" , nil , GRM.GetClassifiedName ( GRM_G.playersNotUpdated[i][1] , false ) , "ffffff" ) .. " - " .. GRM.L ( "Note too long: Free up {num} characters" , nil , nil , GRM_G.playersNotUpdated[i][2] ) , 1 , 1 , 1 );
        table.remove ( GRM_G.playersNotUpdated , i );
        limit = limit + 1;

        if limit == max and i > 1 then
            GRM.Report ( GRM.HL.GenerateHyperlink( "GRM" , "profReport" , nil , GRM.L ( "Click to Continue - {num} Members Remaining" , nil , nil , #GRM_G.playersNotUpdated ) , "00ccff" ) );
            break;
        end
    end
end

-- Method:          Prof.AutoStartProfessionUpdate()
-- What it Does:    Acts as the gate for auto-starting the note update
-- Purpose:         To only run this when designated to do so.
Prof.AutoStartProfessionUpdate = function()
    if GRM.S().ProfRankAutoUpdate and GRM_G.BuildVersion < 50000 and C_GuildInfo.IsGuildOfficer() then
        Prof.InitiateProfessionUpdate( GRM.S().ProfReportUpdatesToChat );
    end
end