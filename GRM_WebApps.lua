local WebApps = {}
GRM.WebApps = WebApps

-- Method:          WebApps.GetWebAppURL( appName: string )
-- What it Does:    Returns the URL for the requested web app by name
-- Purpose:         To provide users with quick access to web apps associated with GRM
WebApps.GetWebAppURL = function( appName )

    local appURLs = {
        ["log"] = "https://grm-parser-webapp.onrender.com/",
    }

    return appURLs[appName] or nil
end