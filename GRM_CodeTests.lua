-- TESTING
GRM_T = {};


GRM_T.TestRejoinWithNameChange = function()
    for name , player in pairs ( GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName] ) do
        if type ( player ) == "table" then
            print("Testing with: " .. player.name );
            player.name = "XXXXXXXXXX-Zul'jin";
            GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ]["NoobName-Zul'jin"] = {};
            GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ]["NoobName-Zul'jin"] = GRM.DeepCopyArray ( player );
            GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName][name] = nil;

            break;
        end
    end
end

GRM_T.TestRejoin = function()
    for name , player in pairs ( GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName] ) do
        if type ( player ) == "table" then
            print("Testing with: " .. player.name );
            GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ][name] = {};
            GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ][name] = GRM.DeepCopyArray ( player );
            GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName][name] = nil;

            break;
        end
    end
end

GRM_T.TestJoinWithSameNameButDifferent = function()
    for name , player in pairs ( GRM_GuildMemberHistory_Save[GRM_G.F][GRM_G.guildName] ) do
        if type ( player ) == "table" then
            print("Testing with: " .. player.name );
            player.GUID = UnitGUID("PLAYER");
            player.class = "HUNTER"

            break;
        end
    end
end

GRM_T.TestRankNumChange = function()
    local ranks = GRM.GetListOfGuildRanks ( true , true , true );
    GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ].ranks = string.sub ( ranks , string.find ( ranks , "|" ) + 2 )
    GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ].grmNumRanks = 9;
end