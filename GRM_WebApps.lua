local WebApps = {}
local grm_official_site = "guildrostermanager.com";

GRM.WebApps = WebApps

-- Method:          WebApps.GetWebAppURL( appName: string )
-- What it Does:    Returns the URL for the requested web app by name
-- Purpose:         To provide users with quick access to web apps associated with GRM
WebApps.GetWebAppURL = function( appName )

    local appURLs = {
        ["www"] = "www." .. grm_official_site,
        ["root"] = grm_official_site,
        ["extract"] = "extract." .. grm_official_site,
        ["changelog"] = "www." .. grm_official_site .. "/changelog"
    }

    local address = appURLs[appName];

    if address then
        return "https://" .. address;
    end
    return
end