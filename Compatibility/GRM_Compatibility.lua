-- The necessity of this file is for the single codebase need for ALL Warcraft build versions.
-- Often, a new release hits in say retail, and many API changes happens by Blizzard, but the Classic builds are now out of sync
-- because they haven't received those changes yet until their next major build update, which could be months away. Other times Blizz
-- decides certain API must be restricted in Classic builds for originality purposes. So, GRM has to account for inconsistent API at times.

local Comp_API = {};
GRM.Comp_API = Comp_API;

-- Returns the max amount of macros
Comp_API.GetMaxMacros = function()
    if MAX_ACCOUNT_MACROS then
        return MAX_ACCOUNT_MACROS
    else
        return Constants.MacroConsts.MAX_ACCOUNT_MACROS;
    end
end