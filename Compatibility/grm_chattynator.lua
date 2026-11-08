
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
        chattynator.HookChattynatorAPI();
        return true;
    end
    return false;
end


-- Method:          chattynator.GetChattynatorTab(string)
-- What it Does:    Iterates through Chattynator's windows and tabs to find a tab matching the given name
-- Purpose:         To retrieve the window and tab index of a Chattynator tab by name, allowing GRM to send messages to it.
chattynator.GetChattynatorTab = function(tabName)
    if Chattynator and Chattynator.API and Chattynator.API.GetWindowsAndTabs then
        local windows = Chattynator.API.GetWindowsAndTabs()
        local coreTabs = { ["GENERAL"]=COMMUNITIES_DEFAULT_CHANNEL_NAME,["GUILD"]=COMMUNITIES_GUILD_GENERAL_CHANNEL_NAME,["COMBAT_LOG"]=COMBAT_LOG};

        for wIndex, tabs in ipairs(windows) do
            for ind, name in ipairs(tabs) do

                if coreTabs[name] then
                    if coreTabs[name] == tabName or name == tabName then
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

-- Method:          chattynator.ConfigureChattynatorTab (int,int)
-- What it Does:    Forces ChattynatorTab to allow GRM messages
-- Purpose:         Chattynator Compatibility
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

-- Method:          Config.GetTimeOffesets( string, float, float, float)
-- What it Does:    Utilizes the Chattynator reporting instead of the AddMessage of the built-in defaults instead
-- Purpose:         Chattynator is a really cool addon and GRM should support it.
chattynator.ChattynatorReport = function( msg , r, g, b)
    if GRM.S() then
        for i = 1, #GRM.S().reportChannel do
            local wIndex, tIndex = chattynator.GetChattynatorTab(GRM.S().reportChannel[i]);

            if wIndex and tIndex then
                chattynator.ConfigureChattynatorTab(wIndex, tIndex)
                
                -- Suppress the annoying debug prints left by Chattynator's dev
                Chattynator.API.AddMessageToWindowAndTab(wIndex, tIndex, msg, r, g, b)
            end
        end
    end
end

-- Method:        chattynator.SetReportChannel( int, int, string )
-- What it Does:  Initializes into memory the GRM reporting channels matched to Chattynator tab indexes
-- Purpose:       Chattynator compatibility!
chattynator.SetReportChannel = function( wIndex, tIndex, name)
    GRM_G.Compat.ChattynatorTabs[name] = {wIndex, tIndex};
end

-- Method:        chattynator.DisableChannel( string )
-- What it Does:  Disables Chattynator tabs reporting GRM if GRM itself is not configured for it
-- Purpose:       Unify GRM settings to Chattynator settings of GRM channel reporting
chattynator.DisableChannel = function(name)
    local wIndex, tIndex = chattynator.GetChattynatorTab(name);

    if wIndex and tIndex then
        local profileName = CHATTYNATOR_CURRENT_PROFILE or "DEFAULT"
        if CHATTYNATOR_CONFIG and CHATTYNATOR_CONFIG.Profiles and CHATTYNATOR_CONFIG.Profiles[profileName] then
            local profile = CHATTYNATOR_CONFIG.Profiles[profileName]

            if profile.windows and profile.windows[wIndex] then
                local tabConfig = profile.windows[wIndex].tabs[tIndex]

                if tabConfig then
                    tabConfig.addons["Guild_Roster_Manager"] = false; -- Remove GRM from the allowed addons list for this tab
                end 

            end

        end
    end
end

-- Method:        chattynator.EnableChannel( string )
-- What it Does:  Enables Chattynator tabs reporting GRM if GRM itself is configured for it
-- Purpose:       Unify GRM settings to Chattynator settings of GRM channel
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

-- Method:          chattynator.InitializeTabsForGRM()
-- What it Does:    Enables or Disables chattynator tabs to GRM based on the addon settings.
-- Purpose:         Chattynator compatibility initialization upon logging in. Ensure settings unity between addons for compatibility
chattynator.InitializeTabsForGRM = function()
    if not Chattynator then
        return
    end
    
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

-- Method:          chattynator.RefreshChattynatorTabs()
-- What it Does:    Triggers a refresh of chattynator's tabs
-- Purpose:         I need it to refresh the tabs after I create one.
chattynator.RefreshChattynatorTabs = function()
    if Chattynator and Chattynator.API then
        local dummyFilter = function() return true end
        -- Adding and removing a filter triggers Chattynator's "RefreshStateChange" callback
        Chattynator.API.AddFilter(dummyFilter, 1, 1)
        Chattynator.API.RemoveFilter(dummyFilter, 1, 1)
    end
end

-- Method:          chattynator.CreateChattynatorTab( string )
-- What it Does:    Creates a Chattynator tab with the given name and configures it for GRM reporting.
-- Purpose:         To allow users to easily create new Chattynator tabs for GRM
chattynator.CreateChattynatorTab = function( customName )
    local profileName = CHATTYNATOR_CURRENT_PROFILE or "DEFAULT"
    if CHATTYNATOR_CONFIG and CHATTYNATOR_CONFIG.Profiles and CHATTYNATOR_CONFIG.Profiles[profileName] then
        local newTab = {
            name = customName,
            groups = {},
            channels = {},
            addons = {["Guild_Roster_Manager"] = true},
            backgroundColor = "1a1a1a", 
            tabColor = "06a1ff",
            whispersTemp = {}, 
            filters = {},
            isTemporary = false
        }
        table.insert(CHATTYNATOR_CONFIG.Profiles[profileName].windows[1].tabs, newTab)
        GRM_Chat.AddReportChannel(customName, nil, false)
        chattynator.RefreshChattynatorTabs();
        chattynator.EnableChannel(customName);
    end
end

-- Method:          chattynator.CleanupChattynatorTabs()
-- What it Does:    Cleans up chattynator compatibility list
-- Purpose:         If a user removes a GRM window from reporting, in the options, it should also disable it in Chattynator
chattynator.CleanupChattynatorTabs = function()
    local tabs = GRM.S().reportChannel;
    local isFound = false;
    local coreTabs = { ["GENERAL"]=COMMUNITIES_DEFAULT_CHANNEL_NAME,["GUILD"]=COMMUNITIES_GUILD_GENERAL_CHANNEL_NAME,["COMBAT_LOG"]=COMBAT_LOG};

    for name in pairs(GRM_G.Compat.ChattynatorTabs) do
        isFound = false;
        for i = 1 , #tabs do
            if tabs[i] == name or (coreTabs[name] and coreTabs[name] == tabs[i] )then
                isFound = true;
                break
            end
        end
        if not isFound then
            GRM_G.Compat.ChattynatorTabs[name] = nil;
        end
    end

    chattynator.InitializeTabsForGRM();
    
end

-- Method:          chattynator.HookChattynatorAPI()
-- What it Does:    Uses Chattynator's native AddModifier API to format names before display.
chattynator.HookChattynatorAPI = function()
    if not GRM_G.Compat.ChattynatorHooked and Chattynator and Chattynator.API and Chattynator.API.AddModifier then
        
        Chattynator.API.AddModifier(function(data)
            
            -- If data.text exists and contains our hidden GRM marker...
            if data.text and type(data.text) == "string" and string.find(data.text, "\001GRM\001", 1, true) then
                
                -- Remove the hidden marker GRM adds so it doesn't print the weird box
                data.text = string.gsub(data.text, "\001GRM\001", "")

                -- 2. Find the FIRST player hyperlink (the sender) and replace the displayed name
                data.text = string.gsub(data.text, "(|Hplayer:([^|:]+)[^|]-|h)(.-)(|h)", function(prefix, playerName, displayedName, suffix)
                    
                    local fullName = GRM.AppendServerName(playerName)
                    local player = GRM.GetPlayer(fullName)
                    
                    if player and GRM.GetGuild() then
                        local addTag, isMain, isUnassigned = GRM_Sys.IsValidToAddTags(player)
                        
                        if addTag then
                            local mainName = isMain and fullName or GRM.GetPlayerMain(nil, player)
                            local nickname = GRM.NN.GetNickname(nil, player)

                            -- Import GRM's formatting
                            local formattedName = GRM_Name.GetFormattedNameString(playerName, mainName, nickname, isMain, isUnassigned, nil, false)

                            -- Try to find a level tag that has its own specific color ("|cffAAAAAA(90)|r")
                            local coloredLevel = string.match(displayedName, "|c%x%x%x%x%x%x%x%x%s*%([%d]+%)%s*|r")
                            
                            -- Try to find a plain level tag ("(90)")
                            local plainLevel = string.match(displayedName, "%([%d]+%)")

                            -- Coloring
                            local classColor = GRM.GetStringClassColorByName(fullName)
                            formattedName = classColor .. formattedName .. "|r"

                            if coloredLevel then
                                -- The level has its own unique color. Put it OUTSIDE the class color reset
                                formattedName = classColor .. formattedName .. "|r " .. coloredLevel
                            elseif plainLevel then
                                -- The level doesn't have a unique color. Tuck it INSIDE our class color wrapper
                                formattedName = classColor .. formattedName .. " " .. plainLevel .. "|r"
                            else
                                -- No level tag found at all
                                formattedName = classColor .. formattedName .. "|r"
                            end

                            -- Chattynator appends levels to the name "[Arkaan (90)]"
                            local cleanName = string.gsub(string.gsub(displayedName, "|c%x%x%x%x%x%x%x%x", ""), "|r", "")

                            if string.match(cleanName, "^%s*%[") then
                                return prefix .. "[" .. formattedName .. "]" .. suffix
                            else
                                return prefix .. formattedName .. suffix
                            end
                        end
                    end
                    
                    -- If no formatting needed, return it exactly as it was
                    return prefix .. displayedName .. suffix
                end, 1) -- The '1' ensures we ONLY replace the sender!

            end
        end)
        
        GRM_G.Compat.ChattynatorHooked = true
    end
end