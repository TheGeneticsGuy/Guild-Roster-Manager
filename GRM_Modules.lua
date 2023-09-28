
-- CUSTOM MODULES FOR GRM

GRM_M = {};

GRM_M.CreateModule = function ( moduleName , createSettingsTab )
    local name = moduleName:gsub ( "%s" , "" );

    -- Name must have no whiteSpace
    GRM_G.Modules[name] = {};
    
    if createSettingsTab then
        GRM_G.Modules[name].SettingsTab = true;
    else
        GRM_G.Modules[name].SettingsTab = false;
    end

end

GRM_M.AddModuleSetting = function ( moduleName , type , settingsName , defaultSetting )


end

