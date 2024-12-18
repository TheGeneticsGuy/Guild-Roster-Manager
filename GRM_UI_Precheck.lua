-- To hold the functions for ensuring the proper UI settings for the guild.
-- Blizz re-added the old classic roster and I just think it's kind of a pain to maintain 2 different interfaces
-- and with such low demand for Classic purism on the guild roster, I will not be supporting.

local UI_Pre = {};
GRM.UI_Pre = UI_Pre;

UI_Pre.checkClassicUIRoster = function()

    if not GRM.S().classicUIInformed then
        GRM.S().classicUIInformed = true;
        local guild_interface = GetCVar("useClassicGuildUI");

        if guild_interface and guild_interface == "1" then
            -- We now have a problem, the old roster interface

            local msg = '|CFFFF0000' .. GRM.L( "One Time Notice" ) .. "|r\n\n" .. GRM.L ( "Blizzard re-introduced the Classic roster, which you currently have enabled. GRM features will be limited. The communities roster will give you access to all of GRM's features.") .. "\n\n" .. GRM.L( "Would you like to enable the communities roster?" );

            GRM.SetConfirmationWindow(UI_Pre.EnableCommunities, msg , nil , {350 , 200 } );
        end
    end
end

-- Method:          UI_Pre.EnableCommunities()
-- What it Does:    Enables the Communities Guild UI instead of Classic in the cVAR
-- Purpose:         Keep GRM's database easier to manage by just dealing with 1 guild interface.
UI_Pre.EnableCommunities = function()
    SetCVar("useClassicGuildUI", "0");
    GRM.Report ( GRM.L ("GRM:") .. " " .. GRM.L ( "Communities Roster is now Enabled.") );
end