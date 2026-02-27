-- To hold initial Configuration type functions as well as
-- initialization process


local Config = {};

GRM.Config = Config;

-- Build UI addon listener for delayed load frames.
local Initialization = CreateFrame("Frame");



-- Method:          Config.GetTimeOffesets()
-- What it Does:    Determines the number of hours a player needs to gain or lose based on their local time, to match server time.
-- Purpose:         The date() function pulls OS time, not server time. This allows me to adjust for it.
Config.GetTimeOffesets = function()
    -- First, let's get local time.
    local local_TimeTable = date("*t");
    -- Then, server time
    local day, _, hour = select(3, GRM.Time.GetTodaysDate());

    local offsetServer = 0;

    if local_TimeTable.day == day then
        -- we can easily check this now.
        if local_TimeTable.hour == hour then
            offsetServer = 0;
        elseif local_TimeTable.hour > hour then
            offsetServer = (local_TimeTable.hour - hour) * -1; -- -hours
        elseif local_TimeTable.hour < hour then
            offsetServer = hour - local_TimeTable.hour --  +hours
        end

    else
        if local_TimeTable.day > day then
            offsetServer = ((local_TimeTable.hour + 24) - hour) * -1;
        elseif local_TimeTable.day < day then
            offsetServer = (hour + 24) - local_TimeTable.hour
        end
    end

    return offsetServer;
end

-------------------------------------------------
--------- INITIALIZATION ON START ---------------
-------------------------------------------------


-- Method:          Config.ActivateAddon( self , string , string )
-- What it Does:    First, doesn't trigger to load until all variables of addon fully loaded.
--                  Then, it triggers to delay until player is fully in the world, in that order.
--                  Finally, it delays 5 seconds upon querying server as often initial Roster and Guild Event Log query takes a moment to return info.
-- Purpose:         To ensure the smooth handling and loading of the addon so all information is accurate before attempting to parse guild info.
Config.ActivateAddon = function(_, event, addon, isReload )
    if event == "ADDON_LOADED" and addon == GRM_G.addonName then
        Initialization:UnregisterEvent("ADDON_LOADED");
        Initialization:RegisterEvent("PLAYER_ENTERING_WORLD"); -- Ensures this check does not occur until after Addon is fully loaded.

    elseif event == "PLAYER_ENTERING_WORLD" then
        Initialization:UnregisterEvent("PLAYER_ENTERING_WORLD");

        if isReload then
            GRMsyncGlobals.reloadControl = true;
        end

        if GRM_G.faction == nil then
            GRM_G.faction = UnitFactionGroup("PLAYER");
        end

        GRM.ConfigureAnnounceOnLogin(); -- So no repeat announcements

        GRM_G.OStimeOffset = Config.GetTimeOffesets(); -- One time configuration of gameTime Offsets;

        GRM.DataLoadDelayProtection();
    end
end

-- Initialize the first frames as game is being loaded.
Initialization:RegisterEvent("ADDON_LOADED");
Initialization:SetScript("OnEvent", Config.ActivateAddon );

_G["GRM_ToggleOptionsWindow"] = GRM.MinimapGRM.MainWindowOpenLogic; -- Addon Compartment button above minimap (see .toc)