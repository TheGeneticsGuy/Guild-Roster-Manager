GRM_RF = {}; -- Realm Free

GRM_RF.IsRealmFree = function()
    local _, _, _, interface = GetBuildInfo()
    return interface >= 16001 and interface < 20000 -- For now, it is just Wow Forever
end

-- Non Forever builds still append the server
GRM_RF.GetFullName = function()
    local addonUser = (GetUnitName("PLAYER", false))

    return GRM_G.RealmFree and addonUser or (addonUser .. "-" ..  GRM_G.realmName)
end

-- Non Forever builds append guild name for x-realm guild compatibility of same name
GRM_RF.ConfigureGuildName = function()
    local isReady = false;
    local finalGuildName = "";
    local guildName, _, _, server = GetGuildInfo("PLAYER");
    if not guildName or (not GRM_G.RealmFree and not server) then
        guildName, _, _, server = GetGuildInfo("PLAYER")
    end
    local timePassed = 0;
    if not guildName or (not GRM_G.RealmFree and not server) then
        timePassed = time() - GRM_G.SessionTime;
    end
    if (GRM_G.RealmFree and guildName) or (not GRM_G.RealmFree and server) or (timePassed > 10) or (count == countLimit) then
        isReady = true;
        finalGuildName = guildName
    end
    
    if not GRM_G.RealmFree and isReady then
        if server ~= nil then
            finalGuildName = guildName .. "-" .. string.gsub(string.gsub(server, "-", ""), "%s+", "");
        else
            finalGuildName = guildName .. "-" .. GRM_G.realmName;
        end
    end

    return isReady, finalGuildName;
end