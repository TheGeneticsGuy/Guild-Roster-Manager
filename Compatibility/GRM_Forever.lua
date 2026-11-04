GRM_WOWF = {};

GRM_WOWF.IsWowForever = function()
    local _, _, _, interface = GetBuildInfo()
    return interface >= 16001 and interface < 20000
end