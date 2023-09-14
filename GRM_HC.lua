
-- Classic HARDCORE Mode feature set for GRM

-- Live collection of when someone has died

local GRM_HC = {};
local deathEvent = "GUILD_MEMBER_DIED" ;

GRM_HC.deathEvent = CreateFrame ( "Frame" );

GRM_HC.HardCoreInitialize = function()

    if C_GameRules and C_GameRules.IsHardcoreActive() then
        GRM_G.HardcoreActive = true;

        GRM_HC.deathEvent:RegisterEvent ( deathEvent );
        GRM_HC.deathEvent:SetScript ( "OnEvent" , function ( _ , event , name ) 

            if event == deathEvent then
                GRM_HC.LogDeath ( name );
            end

        end);

        -- Method:          GRM_HC.LogDeath ( string )
        -- What it Does:    Logs the death of the player
        -- Purpose:         Ensure accurate time reporting of a player's death.
        GRM_HC.LogDeath = function ( name )

            if not name:find ( "-" , 1 , true ) then
                name = name .. "-" .. GRM_G.realmName;
            end
            local player = GRM.GetPlayer ( name );

            if player then
                local dateArray = select ( 2 , GRM.GetTimestamp() );
                dateArray[6] = true;

                player.HC.isDead = true;
                player.HC.timeOfDeath = { dateArray[1] , dateArray[2] , dateArray[3] , dateArray[4] , dateArray[5] , true };

                if GRM.S().addDeathTag and GRM.CanEditPublicNote() then
                    GRM_HC.ExportDeathTag ( player , dateArray );

                end

                GRM_HC.ReportDeathToLog( player.name , player.class , player.level , dateArray );

            end
        
        end

        -- Method:          GRM_HC.ExportDeathTag ( string , table )
        -- What it Does:    Exports the death tag to the player note
        -- Purpose:         Report on when a player dies... Useful since there is not UI Interface
        GRM_HC.ExportDeathTag = function ( player , dateArray )
            for i = 1 , GRM.GetNumGuildies() do
                local memberName , _ , _ , _ , _ , _ , memberNote , officerNote = GetGuildRosterInfo ( i );
                
                if memberName == player.name then
                    if not memberNote:find ( "%[" .. GRM.L ( "D" ) .. "%]" ) then
                        local tagToAdd = "[" .. GRM.L ( "D" ) .. "]";
                        local maxLetters = GRM_UI.GRM_MemberDetailMetaData.GRM_PlayerNoteEditBox:GetMaxLetters();

                        local day , month;
                        if dateArray[1] < 10 then
                            day = "0" .. tostring ( dateArray[1] );
                        else
                            day = tostring ( dateArray[1] );
                        end

                        if dateArray[2] < 10 then
                            month = "0" .. tostring ( dateArray[2] );
                        else
                            month = tostring ( dateArray[2] );
                        end

                        local possibleTag = tagToAdd .. "-" .. dateArray[3] .. month .. day;
                        local finalNote = "";

                        if GRM.S().includeDeathTime then

                            if #(memberNote .. " " .. possibleTag) <= maxLetters then
                                finalNote = memberNote .. " " .. possibleTag;

                            elseif #(memberNote .. possibleTag) <= maxLetters then
                                finalNote = memberNote .. possibleTag;

                            elseif #(memberNote .. " " .. tagToAdd) <= maxLetters then
                                finalNote = memberNote .. " " .. tagToAdd;

                            elseif #(memberNote .. tagToAdd) <= maxLetters then
                                finalNote = memberNote .. tagToAdd;

                            else
                                -- Critical to know, so force overwrite of at least 3 chars.
                                finalNote = "[" .. GRM.L ( "D" ) .. "]" .. memberNote:sub ( 1 , #memberNote - 3 );
                            end
                        else
                            if #(memberNote .. " " .. tagToAdd) <= maxLetters then
                                finalNote = memberNote .. " " .. tagToAdd;

                            elseif #(memberNote .. tagToAdd) <= maxLetters then
                                finalNote = memberNote .. tagToAdd;
                            else
                                -- Critical to know, so force overwrite of at least 3 chars.
                                finalNote = "[" .. GRM.L ( "D" ) .. "]" .. memberNote:sub ( 1 , #memberNote - 3 );
                            end
                        end

                        if finalNote ~= "" then

                            finalNote = GRM.Trim(finalNote);
                            
                            local simpleName = GRM.GetStringClassColorByName ( player.name ) .. GRM.SlimName ( player.name ) .. "|r";
                            local logReportWithTime , logReport = GRM.GetNoteChangeString ( simpleName , memberNote , finalNote , select ( 2 , GRM.GetTimestamp() ) );
            
                            if GRM.S().toChat.note then
                                GRM.PrintLog ( { 4 , logReport } );
                            end
                            -- Also adding it to the log!
                            GRM.AddLog ( { 4 , logReportWithTime , simpleName , memberNote , finalNote , select ( 2 , GRM.GetTimestamp() ) } );

                            player.note = finalNote;
                            GuildRosterSetPublicNote ( i , finalNote );
                            
                        end
                    
                    end
                    break;
                end
            end

        end

        -- Method:          GRM_HC.ReportDeathToLog ( string , string , int , table )
        -- What it Does:    Adds to the log when a player days
        -- Purpose:         Death reporting feature.
        GRM_HC.ReportDeathToLog = function ( name , class , level , dateArray )
            
            local logReportWithTime , logReport = GRM.GetDeathString ( name , class , level , dateArray );

            -- No need to report to chat since the chat already notifies everyone in guild.
            GRM.AddLog ( { 24 , logReportWithTime , name , class , level , dateArray } );

            if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
                GRM.BuildLogComplete( true , true );
            end

            if GRM_UI.GRM_RosterFrame ~= nil and GRM_UI.GRM_RosterFrame:IsVisible() then
                GRM_R.RefreshRosterName();
            end

        end

        -- Method:          GRM_HC.GatherAllDeaths ( [ int , int ] )
        -- What it Does:    Returns table of every player death
        -- Purpose:         For player reporting and tracking.
        GRM_HC.GatherAllDeaths = function( levelRange )
            local result = {};
            local guild = GRM.GetGuild();
            local formerGuild = GRM.GetFormerMembers();

            local getReport = function ( p , currentMember )
                local deathReport = {};
                deathReport.name = p.name;
                deathReport.class = p.class;
                deathReport.level = p.level;
                deathReport.date = tonumber ( GRM.ConvertToStandardFormatDate ( p.HC.timeOfDeath[1] , p.HC.timeOfDeath[2] , p.HC.timeOfDeath[3] ) );
                deathReport.dateVerified = p.HC.timeOfDeath[6];
                deathReport.currentMember = currentMember;

                return deathReport;
            end

            for name , player in pairs ( guild ) do
                if type (player) == "table" then
                    if player.HC.isDead then
                        if not levelRange or ( levelRange and ( player.level >= levelRange[1] and player.level <= levelRange[2] ) ) then
                            table.insert ( result , getReport ( player , true ) );
                        end
                    end
                end
            end

            for name , player in pairs ( formerGuild ) do
                if type (player) == "table" then
                    if player.HC.isDead then
                        if not levelRange or ( levelRange and ( player.level >= levelRange[1] and player.level <= levelRange[2] ) ) then
                            table.insert ( result , getReport ( player , false ) );
                        end
                    end
                end
            end

            return result;
        end

        -- Method:          GRM_UI.GetHardcoreDeaths( bool )
        -- What it Does:    Reports back the integer count number of deaths
        -- Purpose:         Useful for counting the number dead
        -- NOTE             Set on global GRM_UI table for access from the UI
        GRM_UI.GetHardcoreDeaths = function( useLevelFilter )

            if not useLevelFilter then
                return GRM_HC.GatherAllDeaths();
            else
                local lower = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:GetText();
                local upper = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:GetText();
                if lower ~= "" then
                    lower = tonumber ( lower );
                else
                    lower = 1;
                end
                if upper ~= "" then
                    upper = tonumber ( upper );
                else
                    upper = GRM_G.LvlCap;
                end

                local deaths = GRM_HC.GatherAllDeaths ( { lower , upper } );

                return #deaths , deaths;
            end
        end

        -- Method:          GRM_UI.GetAllDeathsSorted()
        -- What it Does:    Collects all of the hardcore deaths and then sorts them
        -- Purpose:         For export reasons...
        GRM_HC.GetAllDeathsSorted = function()

            local _ , deaths = GRM_UI.GetHardcoreDeaths ( true );

            if GRM.S().exportHardcoreSort == 1 then
                sort ( deaths , function ( a , b ) return a.name < b.name end );
            elseif GRM.S().exportHardcoreSort == 2 then
                sort ( deaths , function ( a , b ) return a.level > b.level end );
            elseif GRM.S().exportHardcoreSort == 3 then
                sort ( deaths , function ( a , b ) return a.class < b.class end );
            elseif GRM.S().exportHardcoreSort == 4 then
                sort ( deaths , function ( a , b ) return a.date > b.date end );
            end

            return deaths;
        end

        -- Method:          GRM_UI.BuildExportDeaths()
        -- What it Does:    Builds the list of names to be exported to the Export Log window
        -- Purpose:         Export the hardcore mode death lists...
        GRM_UI.BuildExportDeaths = function()
            local scrollWidth = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:GetWidth() - 3;
            local completeString = "";
            local delimiter = "";
            local playerDetails = "";
            local isMergedRealm = GRM.IsMergedRealmServer();

            if GRM.S().exportDelimiter[1] then
                delimiter = GRM.S().exportDelimiter[2];
            end

            -- Build the arrays to use.
            local deaths = GRM_HC.GetAllDeathsSorted();

            local num1 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:GetText() );
            local num2 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:GetText() );

            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText ( "" );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSize ( scrollWidth , 12 );   -- Default Size at one line

            for i = num1 , num2 do
                playerDetails = "";

                if num1 <= #deaths then
                    
                    -- Build the string
                    -- Name:
                    name = deaths[i].name;
                    if GRM.S().specialCharRemoval then
                        name = GRM.RemoveSpecialCharacters ( name );
                    end

                    if isMergedRealm then
                        playerDetails = playerDetails .. name .. delimiter;                                   -- name
                    else
                        playerDetails = playerDetails .. GRM.SlimName ( name ) .. delimiter;                  -- name
                    end

                    -- Level:
                    playerDetails = playerDetails .. deaths[i].level .. delimiter;

                    -- Level:
                    playerDetails = playerDetails .. deaths[i].class .. delimiter;

                    -- TimeOfDeath = 
                    playerDetails = playerDetails .. deaths[i].date .. delimiter;


                    if #playerDetails > 0 then
                        local modifier = 1;
    
                        if delimiter == "||" or delimiter == "\\t" or delimiter == "::" then
                            modifier = 2;
                        end
                        playerDetails = string.sub ( playerDetails , 1 , #playerDetails - modifier );  -- eliminate the last delimiter
                        if i < num2 then
                            completeString = completeString .. playerDetails .. "\n";
                        else
                            completeString = completeString .. playerDetails;               -- Don't need to add the line break at the end.
                        end 
                    end

                else
                    break;
                end
            end

            if completeString ~= "" then
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HighlightText ( 0 );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:Show();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText ( completeString );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();
                
                C_Timer.After ( 2 , function()
                    GRM.ExportScrollSliderConfigure( scrollWidth );
                end);
            end
        end

    end

end

GRM_HC.HardCoreInitialize();

