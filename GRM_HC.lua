
-- Classic HARDCORE Mode feature set for GRM
-- Live collection of when someone has died

local HC = {};
GRM.HC = HC;

HC.deathEvent = CreateFrame ( "Frame" );

HC.HardCoreInitialize = function()

    local region = {
        ["enUS"] = "HardcoreDeaths",
        ["ptBR"] = "MortesHardcore",
        ["esMX"] = "MuertesEnExtremo",
        ["esES"] = "MuertesHardcore",
        ["deDE"] = "HardcoreTode",
        ["frFR"] = "Morts",
        ["ruRU"] = "ГероическиеСмерти",
        ["koKR"] = "하드코어",
        ["zhCN"] = "专家死亡",
        ["zhTW"] = "專家模式玩家死亡",
    }

    GRM_G.HardCoreDeaths = region[GRM_G.Region];

    if GRM.IsHardcoreActive() then
        GRM_G.HardcoreActive = true;

        HC.deathEvent:RegisterEvent ( "CHAT_MSG_CHANNEL" );
        HC.deathEvent:SetScript ( "OnEvent" , function ( _ , _ , text , playerName , _ , _ ,  _ , _ , _ , _ , channel )

            if GRM_G.HardCoreDeaths == channel then
                local name = HC.ParseOutPlayerName ( text );

                if name then
                    local player = GRM.GetPlayer ( name , true );
                    if player then
                        HC.LogDeath ( player.name );
                    end
                end
            end

        end);

        -- Method:          GRM.GetParsedJoinPlayerName ( string )
        -- What it Does:    Parses out the player name from the death report all 11 clients
        -- Purpose:         To live determine the name of the player that died
        HC.ParseOutPlayerName = function ( text )
            return text:match ( "%[([^%]]+)%]" );
        end

        -- Method:          HC.LogDeath ( string )
        -- What it Does:    Logs the death of the player
        -- Purpose:         Ensure accurate time reporting of a player's death.
        HC.LogDeath = function ( name )

            if not name:find ( "-" , 1 , true ) then
                name = name .. "-" .. GRM_G.realmName;
            end
            local player = GRM.GetPlayer ( name );

            if player then
                local dateArray = GRM.Time.GetTimestamp();
                dateArray[6] = true;

                player.HC.isDead = true;
                player.HC.timeOfDeath = { dateArray[1] , dateArray[2] , dateArray[3] , dateArray[4] , dateArray[5] , true };

                if GRM.S().addDeathTag and GRM.CanEditPublicNote() then
                    HC.ExportDeathTag ( player , dateArray );

                end

                HC.ReportDeathToLog( player.name , player.class , player.level , dateArray );

            end

        end

        -- Method:              HC.SetPlayerAsDeadByGUID ( string , int , int , string )
        -- What it Does:        Finds a player in the roster by GUID, then updates their note and sets them to being dead.
        -- Purpose:             Handling the situation of double copies of players still in the guild because of name copies
        GRM.SetPlayerAsDeadByGUID = function ( guid , lastOnline , i , note )
            if GRM.CanEditPublicNote() and not string.find ( note , "[D]" ) then
                local  playerGUID = select ( 17 , GetGuildRosterInfo(i) );
                if playerGUID == guid then
                    local deathNote = "[D]-" .. HC.ConvertLastOnlineHoursToTimestamp ( lastOnline );
                    GuildRosterSetPublicNote ( i, deathNote );
                end
            end
        end

        -- Method:          HC.ConvertLastOnlineHoursToTimestamp ( int )
        -- What it Does:    It converts the last online hours into an actual standard date formatted timestamp.
        -- Purpose:         Useful for tagging dead players in HC mode when it is determined the toon is dead/deleted.
        HC.ConvertLastOnlineHoursToTimestamp = function ( lastOnlineHours )
            -- First, convert hours into seconds.
            local seconds = lastOnlineHours * 3600;
            -- Second, let's take current epoch time, and subtract how many seconds ago. This will give us epoch stamp, within an hour, of last login, assuming they don't login a dead toon.
            local epochTime = ( time() - seconds );
            local timestamp = select ( 2 , GRM.Time.EpochToDateFormat( epochTime , false) );

            return GRM.Time.ConvertToStandardFormatDate ( timestamp[1] , timestamp[2] , timestamp[3] );
        end

        -- Method:          HC.ExportDeathTag ( string , table )
        -- What it Does:    Exports the death tag to the player note
        -- Purpose:         Report on when a player dies... Useful since there is not UI Interface
        HC.ExportDeathTag = function ( player , dateArray )
            local i = GRM.GetRosterSelectionID ( player.name , player.GUID );
            if i then

                local memberNote = select ( 7 , GetGuildRosterInfo( i ) );
                if not note then
                    note = "";
                end

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
                        local logReportWithTime , logReport = GRM.GetNoteChangeString ( simpleName , memberNote , finalNote , GRM.Time.GetTimestamp() );

                        if GRM.S().toChat.note then
                            GRM.PrintLog ( { 4 , logReport } );
                        end
                        -- Also adding it to the log!
                        GRM.AddLog ( { 4 , logReportWithTime , simpleName , memberNote , finalNote , GRM.Time.GetTimestamp() } );

                        player.note = finalNote;
                        GuildRosterSetPublicNote ( i , finalNote );

                    end

                end
            end
        end

        -- Method:          HC.ReportDeathToLog ( string , string , int , table )
        -- What it Does:    Adds to the log when a player days
        -- Purpose:         Death reporting feature.
        HC.ReportDeathToLog = function ( name , class , level , dateArray )

            local logReportWithTime = GRM.GetDeathString ( name , class , level , dateArray );

            -- No need to report to chat since the chat already notifies everyone in guild.
            GRM.AddLog ( { 24 , logReportWithTime , name , class , level , dateArray } );

            if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
                GRM.BuildLogComplete( true , true );
            end

            if GRM_UI.GRM_RosterFrame ~= nil and GRM_UI.GRM_RosterFrame:IsVisible() then
                GRM_R.RefreshRosterName();
            end

        end

        -- Method:          HC.GatherAllDeaths ( [ int , int ] )
        -- What it Does:    Returns table of every player death
        -- Purpose:         For player reporting and tracking.
        HC.GatherAllDeaths = function( levelRange )
            local result = {};
            local guild = GRM.GetGuild();
            local formerGuild = GRM.GetFormerMembers();

            local getReport = function ( p , currentMember )
                local deathReport = {};
                deathReport.name = p.name;
                deathReport.class = p.class;
                deathReport.level = p.level;
                deathReport.date = tonumber ( GRM.Time.ConvertToStandardFormatDate ( p.HC.timeOfDeath[1] , p.HC.timeOfDeath[2] , p.HC.timeOfDeath[3] ) );
                deathReport.dateVerified = p.HC.timeOfDeath[6];
                deathReport.currentMember = currentMember;

                return deathReport;
            end

            for _ , player in pairs ( guild ) do
                if type (player) == "table" then
                    if player.HC.isDead then
                        if not levelRange or ( levelRange and ( player.level >= levelRange[1] and player.level <= levelRange[2] ) ) then
                            table.insert ( result , getReport ( player , true ) );
                        end
                    end
                end
            end

            for _ , player in pairs ( formerGuild ) do
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

        -- Method:          GRM_UI.GetAllDeathsSorted()
        -- What it Does:    Collects all of the hardcore deaths and then sorts them
        -- Purpose:         For export reasons...
        HC.GetAllDeathsSorted = function()

            local _ , deaths = GRM.Export.GetHardcoreDeaths ( true );

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

        -- Method:          GRM_UI.VerifyIfHCChannelsEnabled()
        -- What it Does:    Verifies the hardcore death channel is enabled, due to the event listening change in 1.15.2, and if not, an option to enable it.
        -- Purpose:         This entire feature can only work if this is enabled.
        GRM_UI.VerifyIfHCChannelsEnabled = function()
            if GRM_UI.ChannelEnabled ( GRM_G.HardCoreDeaths ) then
                return;
            end

            if not GRM.S().ignoreDeathChannel then
                -- Enable or Disable the text
                local IsDeathChatEnabled = function()
                    local list = FCF_GetCurrentChatFrame().channelList;
                    for i = 1 , #list do
                        if list[i] == GRM_G.HardCoreDeaths then
                            return true;
                        end
                    end

                    return false;
                end

                local EnabledChannel = function()
                    JoinChannelByName ( GRM_G.HardCoreDeaths );
                    GRM.S().ignoreDeathChannel = true;
                    GRM.Report ( GRM.L ( "Please note, GRM will now track the deaths behind the scenes. If you wish to see the full server message, you will need to manually enable in the General Chat Settings." ) );

                    if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ClassicOptionsFrame:IsVisible() then
                        GRM_UI.ConfigureHCOptions();
                    end
                end

                local IgnoreDeathChannel = function()
                    GRM.S().ignoreDeathChannel = true;
                end

                local msg = GRM.L("You will not be asked this again.")
                GRM.InitiateConfirmFrame ( GRM.L ( "For GRM to log guild member deaths, you will need to join the \"{name}\" channel. Do you wish to join?" , GRM_G.HardCoreDeaths ) .. "\n\n" .. msg , EnabledChannel , nil , nil , IgnoreDeathChannel , false , 375 , 140 );
            end

            return false;
        end
    end
end

HC.HardCoreInitialize();

