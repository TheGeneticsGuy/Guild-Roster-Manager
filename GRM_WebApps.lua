local WebApps = {}
local grm_official_site = "guildrostermanager.com";

GRM.WebApps = WebApps

-- Method:          WebApps.GetWebAppURL( appName: string )
-- What it Does:    Returns the URL for the requested web app by name
-- Purpose:         To provide users with quick access to web apps associated with GRM
WebApps.GetWebAppURL = function( appName , removeHttp )

    local appURLs = {
        ["www"] = "www." .. grm_official_site,
        ["root"] = grm_official_site,
        ["extract"] = "extract." .. grm_official_site,
        ["changelog"] = "www." .. grm_official_site .. "/changelog"
    }

    local address = appURLs[appName];

    if address then
        if not removeHttp then
            return "https://" .. address;
        else
            return address;
        end
    end
    return
end