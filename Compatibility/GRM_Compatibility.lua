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


-------------------------------------
-------- BUILD COMPATIBILITY --------
------------ FUNCTIONS --------------
-------------------------------------

GRM.CanViewOfficerNote = function()
    if C_GuildInfo.CanViewOfficerNote then
        return C_GuildInfo.CanViewOfficerNote();
    else
        return CanViewOfficerNote();
    end
end

GRM.CanEditOfficerNote = function()
    if C_GuildInfo.CanEditOfficerNote then
        return C_GuildInfo.CanEditOfficerNote();
    else
        return CanEditOfficerNote();
    end
end

-- An assumption they will update this API to the namespace C_GuildInfo
GRM.CanEditPublicNote = function()
    if C_GuildInfo.CanEditPublicNote then
        return C_GuildInfo.CanEditPublicNote();
    else
        return CanEditPublicNote();
    end
end

GRM.GuildRoster = function()
    if C_GuildInfo.GuildRoster then
        C_GuildInfo.GuildRoster();
    else
        GuildRoster();
    end
end

-- 10.2.5 change
GRM.GetColorPickerFrame = function(type)

    if type == 1 then
        if ColorPickerOkayButton then
            return ColorPickerOkayButton;
        else
            return GRM_UI.ColorPickerFrame.Footer.OkayButton;
        end
    elseif type == 2 then
        if ColorPickerWheel then
            return ColorPickerWheel;
        else
            return GRM_UI.ColorPickerFrame.Content.ColorPicker.Wheel;
        end
    elseif type == 3 then
        if GRM_UI.ColorPickerFrame.Header then
            return GRM_UI.ColorPickerFrame.Header;
        else
            return ColorPickerFrameHeader;
        end
    elseif type == 4 then
        if ColorPickerCancelButton then
            return ColorPickerCancelButton;
        else
            return GRM_UI.ColorPickerFrame.Footer.CancelButton;
        end
    end
end

-- 10.2 Change
GRM.IsAddOnLoaded = function(addonName)
    if C_AddOns and C_AddOns.IsAddOnLoaded then
        return C_AddOns.IsAddOnLoaded(addonName);
    else
        return IsAddOnLoaded(addonName);
    end
end

GRM.LoadLuaAddOn = function(addonName)
    if C_AddOns and C_AddOns.LoadAddOn then
        return C_AddOns.LoadAddOn(addonName);
    else
        return LoadAddOn(addonName);
    end
end

GRM.ForceLoadAddon = function(addonName)
    if not GRM.IsAddOnLoaded(addonName) then
        GRM.LoadLuaAddOn(addonName);
    end
end

-- 1.15.4 Changes pre-empted retail
GRM.SetSliderTemplate = function()
    if pcall ( CreateFrame , "Frame" , nil , UIParent , "UISliderTemplateWithLabels" ) then -- pcall will not throw errors, just return false if doesnt' exist
        GRM_G.SliderTemplate = "UISliderTemplateWithLabels"
    else
        GRM_G.SliderTemplate = "UISliderTemplate"
    end
end
GRM_G.SliderTemplate = "UISliderTemplate"

-- Method:          GRM.issecretvalue()
-- What it Does:    Returns if a value is a secret value, but since this dropped in 12.0, API doesn't currently exist
-- Purpose:         Compatibility of all builds
GRM.issecretvalue = function( value )
    if issecretvalue then
        local isSecret = issecretvalue(value);
        if isSecret and not GRM_G.secretValueDelay then
            GRM_G.secretValueDelay = true;
        end
        return isSecret
    end
    return false
end

-- Method:          GRM.GetMaxPlayerLevelByExpansion()
-- What it Does:    Returns the max player based on the current expansion, not the build. 
-- Purpose:         With things like  pre-patches, the actual real max level will not yet be expansion level, like 80, but not yet 90 for Midnight 12.0.
--                  So you have to swap to the more accurate API. The problem is this API is limited and doesn't exist in all builds.
GRM.GetMaxPlayerLevelByExpansion = function()
    if GetMaxLevelForLatestExpansion then
        return GetMaxLevelForLatestExpansion();
    else
        return GetMaxPlayerLevel();
    end
end

-- Method:          GRM.SetNote ( string, string, boolean, int )
-- What it Does:    If the old API is no longer available, it uses the new SetNote API
-- Purpose:         SetNote is protected in retail, but it is not protected in Classic builds. Sharing same backend
--                  API Blizz has removed the officer and public set notes API but there is a lag in classic builds.
GRM.SetNote = function(guid, newNote, isPublic, index)
    if isPublic then
        if GuildRosterSetPublicNote then
            GuildRosterSetPublicNote(index, newNote);
        else
            C_GuildInfo.SetNote(guid, newNote, isPublic);
        end
    else
        if GuildRosterSetOfficerNote then
            GuildRosterSetOfficerNote(index, newNote);
        else
            C_GuildInfo.SetNote(guid, newNote, isPublic);
        end
    end
end

