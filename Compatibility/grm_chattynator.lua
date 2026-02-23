
GRM_G.Compat.ChattynatorLoaded = false;
GRM_G.Compat.ChattynatorInitialized = false;
GRM_G.Compat.ChattynatorTabs = {};

local chattynator = {};
GRM.chattynator = chattynator;

-- Method:          GRM.IsChattynatorLoaded()
-- What it Does:    Checks if Chattynator is loaded and sets the compatibility flag accordingly.
-- Purpose:         To allow GRM to know if it can attempt to integrate with Chattynator for enhanced chat features, such as sending messages to specific tabs.
chattynator.IsChattynatorLoaded = function()
    if GRM.IsAddOnLoaded("Chattynator") then
        GRM_G.Compat.ChattynatorLoaded = true;
        return true;
    end
    return false;
end


-- Detect a Chattynator tab by its string name
chattynator.GetChattynatorTab = function(tabName)
    if Chattynator and Chattynator.API and Chattynator.API.GetWindowsAndTabs then
        local windows = Chattynator.API.GetWindowsAndTabs()
        local coreTabs = { ["GENERAL"]=COMMUNITIES_DEFAULT_CHANNEL_NAME,["GUILD"]=COMMUNITIES_GUILD_GENERAL_CHANNEL_NAME,["COMBAT_LOG"]=COMBAT_LOG};

        for wIndex, tabs in ipairs(windows) do
            for ind, name in ipairs(tabs) do

                if coreTabs[name] then
                    if coreTabs[name] == tabName then
                        return wIndex, ind, name
                    end
                else
                    if name == tabName then
                        return wIndex, ind, name
                    end
                end

            end
        end
    end
    return nil, nil
end

-- Force the Chattynator tab to accept GRM messages
chattynator.ConfigureChattynatorTab = function(wIndex, tIndex)
    local profileName = CHATTYNATOR_CURRENT_PROFILE or "DEFAULT"

    if CHATTYNATOR_CONFIG and CHATTYNATOR_CONFIG.Profiles and CHATTYNATOR_CONFIG.Profiles[profileName] then
        
        local profile = CHATTYNATOR_CONFIG.Profiles[profileName]
        if profile.windows and profile.windows[wIndex] then
            local tabConfig = profile.windows[wIndex].tabs[tIndex]
            
            if tabConfig then
                if not tabConfig.addons then 
                    tabConfig.addons = {} 
                end
                -- Whitelist GRM. 
                tabConfig.addons["Guild_Roster_Manager"] = true
            end
        end
    end
end

chattynator.ChattynatorReport = function( msg , r, g, b)
    for i = 1, #GRM.S().reportChannel do
        local wIndex, tIndex = chattynator.GetChattynatorTab(GRM.S().reportChannel[i]);

        if wIndex and tIndex then
            chattynator.ConfigureChattynatorTab(wIndex, tIndex)
            print("Sending to Chattynator channel: " .. GRM.S().reportChannel[i] .. " - " .. msg)
            
            -- Suppress the annoying debug prints left by Chattynator's dev
            Chattynator.API.AddMessageToWindowAndTab(wIndex, tIndex, msg, r, g, b)
        end
    end
end

chattynator.SetReportChannel = function( wIndex, tIndex, name)
    GRM_G.Compat.ChattynatorTabs[name] = {wIndex, tIndex};
end

chattynator.DisableChannel = function(name)
    local wIndex, tIndex = chattynator.GetChattynatorTab(name);

    if wIndex and tIndex then
        local profileName = CHATTYNATOR_CURRENT_PROFILE or "DEFAULT"
        if CHATTYNATOR_CONFIG and CHATTYNATOR_CONFIG.Profiles and CHATTYNATOR_CONFIG.Profiles[profileName] then
            local profile = CHATTYNATOR_CONFIG.Profiles[profileName]

            if profile.windows and profile.windows[wIndex] then
                local tabConfig = profile.windows[wIndex].tabs[tIndex]

                if tabConfig then
                    -- There is a setting that enables ALL addons. If that is checked, we and profile.windows[wIndex].tabsare going to
                    if tabConfig.groups.ADDON then
                        tabConfig.groups.ADDON = false;
                    end
                    tabConfig.addons["Guild_Roster_Manager"] = false; -- Remove GRM from the allowed addons list for this tab
                end 

            end

        end
    end
end

chattynator.EnableChannel = function(name)
    local wIndex, tIndex = chattynator.GetChattynatorTab(name);

    if wIndex and tIndex then
        local profileName = CHATTYNATOR_CURRENT_PROFILE or "DEFAULT"
        if CHATTYNATOR_CONFIG and CHATTYNATOR_CONFIG.Profiles and CHATTYNATOR_CONFIG.Profiles[profileName] then
            local profile = CHATTYNATOR_CONFIG.Profiles[profileName]

            if profile.windows and profile.windows[wIndex] then
                local tabConfig = profile.windows[wIndex].tabs[tIndex]

                if tabConfig then
                    tabConfig.addons["Guild_Roster_Manager"] = true; -- Add GRM to the allowed addons list for this tab
                end 
            end

        end

    end

end

chattynator.InitializeTabsForGRM = function()
    local windows = Chattynator.API.GetWindowsAndTabs();

    for i = 1 , #windows do
        for j = 1 , #windows[i] do
            local name = windows[i][j];
            if GRM_G.Compat.ChattynatorTabs[name] then
                chattynator.EnableChannel(name);
            else
                chattynator.DisableChannel(name);
            end
        end
    end
    
end