-- TESTING



GRM.TestRejoinWithNameChange = function()
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

GRM.TestRejoin = function()
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