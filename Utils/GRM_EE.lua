-- Easter egg management!


-- { GuildName , What to Say }
GRM_G.listOfGuilds = {
    ["Mysterious Intent-Tichondrius"] = "RogFactor",
    ["Is a Subatomic Particle-Zul'jin"] = "SAP Times"

}

GRM_G.listOfPlayers = {
    ["Tauros-EmeraldDream"] = "|cffff0000R" .. "|cffff6a00o" .. "|cfffff700g" .. "|cff44ff00F" .. "|cff0000ffa" .. "|cffa200ffc" .. "|cffff00f2t" .. "|cffff0000o" .. "|cffff6a00r", -- Gonna make this colorful for fun.

}

GRM.IsGuildEE = function ( nameOfGuild )
    local result = false;
    if GRM_G.listOfGuilds[nameOfGuild] ~= nil then
        result = true;
    end
    return result;
end

GRM.IsPlayerEE = function ( nameOfPlayer )
    local result = false;
    if GRM_G.listOfPlayers[nameOfPlayer] ~= nil then
        result = true;
    end
    return result;
end

