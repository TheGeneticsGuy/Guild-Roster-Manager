local NamesTab = {};
GRM_UI.NamesTab = NamesTab;

local playerClass = select(2,UnitClass("player"));
local altClass = "MAGE" ~= playerClass and "MAGE" or "ROGUE" -- Adjust classes if the same
local nickClass = "WARRIOR" ~= playerClass and "WARRIOR" or "HUNTER"
local toonClass = "DRUID" ~= playerClass and "DRUID" or "PALADIN"
local mainName = GRM.GetClassColorRGB(playerClass, true) .. GRM.L("MainName") .. "|r";
local altName = GRM.GetClassColorRGB(altClass, true) .. GRM.L("AltName") .. "|r";
local nickName = GRM.GetClassColorRGB(nickClass, true) .. GRM.L("Nickname") .. "|r";
local toonName = GRM.GetClassColorRGB(toonClass, true) .. GRM.L("ToonName") .. "|r";

-- Helper to grab the base dummy text for UI dropdown options
local GetPreview = function(type, index)
    if type == "MAIN" then
        return GRM_Name.GetFormattedNameString(mainName, mainName, "", true, false, index, true)
    elseif type == "ALT" then 
        return GRM_Name.GetFormattedNameString(altName, mainName, "", false, false, index, true)
    elseif type == "NICKMAIN" then
        return GRM_Name.GetFormattedNameString(mainName, mainName, nickName, true, false, index, true)
    elseif type == "NICKALT" then
        return GRM_Name.GetFormattedNameString(altName, mainName, nickName, false, false, index, true)
    elseif type == "NICKUNASSIGNED" then
        return GRM_Name.GetFormattedNameString(toonName, mainName, nickName, false, true, index, true)
    end
    return ""
end

local GetPreviewList = function(type, index)
    local l={}
    for i = 1, index do
        l[i] = GetPreview(type, i)
    end
    return l
end

-- Overlapping dropdowns are annoying - close as needed
local CloseOtherDropdowns = function(ind)
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame

    if not ind or ind ~= 1 then
        f.GRM_MainTagDDMenu:Hide()
    end

    if not ind or ind ~= 2 then
        f.GRM_AltTagDDMenu:Hide()
    end

    if not ind or ind ~= 3 then
        f.GRM_MainFormatDDMenu:Hide()
    end

    if not ind or ind ~= 4 then
        f.GRM_AltFormatDDMenu:Hide()
    end

    if not ind or ind ~= 5 then
        f.GRM_NickMainFormatDDMenu:Hide()
    end

    if not ind or ind ~= 6 then
        f.GRM_NickAltFormatDDMenu:Hide()
    end
    if not ind or ind ~= 7 then
        f.GRM_NickTagDDMenu:Hide()
    end
    if not ind or ind ~= 8 then
        f.GRM_NickUnassignedFormatDDMenu:Hide();
    end
end

-- For instant updating as changes made in Options > Names Tab
local UpdateText = function()
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame

    f.GRM_MainTagDDSelected.GRM_MainTagDDSelectedText:SetText(GRM_Name.GetMainTags(false, GRM.S().mainTagIndex))
    f.GRM_AltTagDDSelected.GRM_AltTagDDSelectedText:SetText(GRM_Name.GetAltTags(false, GRM.S().altTagIndex))
    f.GRM_NickTagDDSelected.GRM_NickTagDDSelectedText:SetText(GRM_Name.GetNickTags(false, GRM.S().nickTagIndex))
    
    -- We pass the original names, but the GetPreview helper applies the wrappers!
    f.GRM_MainFormatDDSelected.GRM_MainFormatDDSelectedText:SetText(GetPreview("MAIN", GRM.S().nameFormatMain))
    f.GRM_AltFormatDDSelected.GRM_AltFormatDDSelectedText:SetText(GetPreview("ALT", GRM.S().nameFormatAlt))
    f.GRM_NickMainFormatDDSelected.GRM_NickMainFormatDDSelectedText:SetText(GetPreview("NICKMAIN", GRM.S().nicknameFormatMain))
    f.GRM_NickAltFormatDDSelected.GRM_NickAltFormatDDSelectedText:SetText(GetPreview("NICKALT", GRM.S().nicknameFormatAlt))
    f.GRM_NickUnassignedFormatDDSelected.GRM_NickUnassignedFormatDDSelectedText:SetText(GetPreview("NICKUNASSIGNED", GRM.S().nnFormatUnassigned))

    -- Update the Color Picker Textures directly! (Just like the Log color boxes)
    local c1 = GRM.S().mainTagColor
    f.GRM_MainColorPicker.texture:SetColorTexture(c1.r, c1.g, c1.b, 1.0)
    f.GRM_MainTagDDSelected.GRM_MainTagDDSelectedText:SetTextColor(c1.r, c1.g, c1.b);
    f.GRM_AltTagDDSelected.GRM_AltTagDDSelectedText:SetTextColor(c1.r, c1.g, c1.b);
    
    local c2 = GRM.S().nicknameTagColor
    f.GRM_NickColorPicker.texture:SetColorTexture(c2.r, c2.g, c2.b, 1.0)
end

NamesTab.BuildNamesTab = function()
    local OptionsFrame = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame
    GRM_UI.CreateCoreFrame("GRM_NamesOptionsFrame", OptionsFrame, nil, GRM_ENUM.OPTIONS_SIZE.W, GRM_ENUM.OPTIONS_SIZE.H, nil, false, {"BOTTOMLEFT", "BOTTOMLEFT", 0, 0}, nil, false, false)

    local f = OptionsFrame.GRM_NamesOptionsFrame

    ---------------------------------------
    -- SECTION 1- STANDARD FORMATTING   --
    ---------------------------------------
    GRM_UI.CreateString("GRM_NameOptionsTitle", f, "GameFontNormal", GRM.L("Name Formatting (No Nickname)") .. ":", 20, {"TOPLEFT", f, "TOPLEFT", 18, -30}, nil, {0.0, 0.8, 1.0}, nil, {0.0, 0.8, 1.0})

    -- Main & Alt Tag Dropdowns
    GRM_UI.CreateString("GRM_MainTagLbl", f, "GameFontNormal", GRM.L("Main Tag") .. ":", 12, {"TOPLEFT", f.GRM_NameOptionsTitle, "BOTTOMLEFT", 5, -15})
    GRM_UI.CreateDropDownMenu("GRM_MainTagDD", f, nil, {"LEFT", f.GRM_MainTagLbl, "RIGHT", 5, -2}, {60, 25}, GRM_Name.GetMainTags(true), 12, {1,1,1}, nil, nil, function(idx) GRM.S().mainTagIndex = idx; UpdateText() end, nil, nil, true, function() CloseOtherDropdowns(1) end, 4)

    GRM_UI.CreateString("GRM_AltTagLbl", f, "GameFontNormal", GRM.L("Alt Tag") .. ":", 12, {"LEFT", f.GRM_MainTagDDSelected, "RIGHT", 15, 2})
    GRM_UI.CreateDropDownMenu("GRM_AltTagDD", f, nil, {"LEFT", f.GRM_AltTagLbl, "RIGHT", 5, -2}, {60, 25}, GRM_Name.GetAltTags(true), 12, {1,1,1}, nil, nil, function(idx) GRM.S().altTagIndex = idx; UpdateText() end, nil, nil, true, function() CloseOtherDropdowns(2) end, 4)

    -- Tag Color Picker
    GRM_UI.CreateString("GRM_TagColorLbl", f, "GameFontNormal", GRM.L("Tag Color") .. ":", 12, {"LEFT", f.GRM_AltTagDDSelected, "RIGHT", 20, 2})
    GRM_UI.ColorPicker.CreateColorBox("GRM_MainColorPicker", f, 18, {"LEFT", f.GRM_TagColorLbl, "RIGHT", 10, 0}, GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b,
    function(r,g,b)
        GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b = r, g, b
        GRM_Name.RefreshTagHexCode()
        UpdateText()
    end,
    function()
        CloseOtherDropdowns()
    end
    )

    -- Main 
    GRM_UI.CreateString("GRM_MainFmtLbl", f, "GameFontNormal", GRM.L("Format for Mains") .. ":", 12, {"TOPLEFT", f.GRM_MainTagLbl, "BOTTOMLEFT", 0, -15})
    GRM_UI.CreateDropDownMenu("GRM_MainFormatDD", f, nil, {"TOPLEFT", f.GRM_MainFmtLbl, "BOTTOMLEFT", -5, -5}, {350, 25}, GetPreviewList("MAIN", 3), 14, {1,1,1}, nil, nil, function(idx) GRM.S().nameFormatMain = idx; UpdateText() end, function() return GetPreviewList("MAIN", 3) end, nil, true, function() CloseOtherDropdowns(3) end, 4)
    
    -- Alt 
    GRM_UI.CreateString("GRM_AltFmtLbl", f, "GameFontNormal", GRM.L("Format for Alts") .. ":", 12, {"TOPLEFT", f.GRM_MainFormatDDSelected, "BOTTOMLEFT", 5, -10})
    GRM_UI.CreateDropDownMenu("GRM_AltFormatDD", f, nil, {"TOPLEFT", f.GRM_AltFmtLbl, "BOTTOMLEFT", -5, -5}, {350, 25}, GetPreviewList("ALT", 5), 14, {1,1,1}, nil, nil, function(idx) GRM.S().nameFormatAlt = idx; UpdateText() end, function() return GetPreviewList("ALT", 5) end, nil, true, function() CloseOtherDropdowns(4) end, 4)
    
    ---------------------------------------
    -- SECTION 2 - NICKNAME FORMATTING   --
    ---------------------------------------
    GRM_UI.CreateString("GRM_NickOptionsTitle", f, "GameFontNormal", GRM.L("Nickname Formatting") .. ":", 20, {"TOPLEFT", f.GRM_AltFormatDDSelected, "BOTTOMLEFT", 0, -20}, nil, {0.0, 0.8, 1.0})

    GRM_UI.CreateString("GRM_NickTagLbl", f, "GameFontNormal", GRM.L("Nick Tag") .. ":", 12, {"TOPLEFT", f.GRM_NickOptionsTitle, "BOTTOMLEFT", 5, -15})
    GRM_UI.CreateDropDownMenu("GRM_NickTagDD", f, nil, {"LEFT", f.GRM_NickTagLbl, "RIGHT", 5, -2}, {125, 25}, GRM_Name.GetNickTags(true), 12, {1,1,1}, nil, nil, function(idx) GRM.S().nickTagIndex = idx; UpdateText() end, nil, nil, true, function() CloseOtherDropdowns(7) end, 4)

    GRM_UI.CreateString("GRM_NickColorTitle", f, "GameFontNormal", GRM.L("Nickname Tag Color") .. ":", 12, {"LEFT", f.GRM_NickTagDDSelected, "RIGHT", 20, 2})

    -- Color Box Anchored to Radial 2
    GRM_UI.ColorPicker.CreateColorBox("GRM_NickColorPicker", f, 18, {"LEFT", f.GRM_NickColorTitle, "RIGHT", 10, 0}, GRM.S().nicknameTagColor.r, GRM.S().nicknameTagColor.g, GRM.S().nicknameTagColor.b, function(r,g,b)
        GRM.S().nicknameTagColor.r, GRM.S().nicknameTagColor.g, GRM.S().nicknameTagColor.b = r, g, b
        UpdateText()
    end,
    function()
        CloseOtherDropdowns()
    end
    )

    -- Nickname on Main 
    GRM_UI.CreateString("GRM_NickMainFmtLbl", f, "GameFontNormal", GRM.L("Format for Mains with Nicknames") .. ":", 12, {"TOPLEFT", f.GRM_NickTagLbl, "BOTTOMLEFT", 0, -15})
    GRM_UI.CreateDropDownMenu("GRM_NickMainFormatDD", f, nil, {"TOPLEFT", f.GRM_NickMainFmtLbl, "BOTTOMLEFT", -5, -5}, {350, 25}, GetPreviewList("NICKMAIN", 8), 12, {1,1,1}, nil, nil, function(idx) GRM.S().nicknameFormatMain = idx; UpdateText(); end, function() return GetPreviewList("NICKMAIN", 8) end, nil, true, function() CloseOtherDropdowns(5) end, 4)
    
    -- Nickname on Alt
    GRM_UI.CreateString("GRM_NickAltFmtLbl", f, "GameFontNormal", GRM.L("Format for Alts with Nicknames") .. ":", 12, {"TOPLEFT", f.GRM_NickMainFormatDDSelected, "BOTTOMLEFT", 5, -10})
    GRM_UI.CreateDropDownMenu("GRM_NickAltFormatDD", f, nil, {"TOPLEFT", f.GRM_NickAltFmtLbl, "BOTTOMLEFT", -5, -5}, {350, 25}, GetPreviewList("NICKALT", 8), 12, {1,1,1}, nil, nil, function(idx) GRM.S().nicknameFormatAlt = idx; UpdateText(); end, function() return GetPreviewList("NICKALT", 8) end, nil, true, function() CloseOtherDropdowns(6) end, 4)

    -- Nickname on Unconfigured Toon
    GRM_UI.CreateString("GRM_NickUnassignedFmtLbl", f, "GameFontNormal", GRM.L("Format for Unassigned with Nicknames") .. ":", 12, {"TOPLEFT", f.GRM_NickAltFormatDDSelected, "BOTTOMLEFT", 5, -10})
    GRM_UI.CreateDropDownMenu("GRM_NickUnassignedFormatDD", f, nil, {"TOPLEFT", f.GRM_NickUnassignedFmtLbl, "BOTTOMLEFT", -5, -5}, {350, 25}, GetPreviewList("NICKUNASSIGNED", 3), 12, {1,1,1}, nil, nil, function(idx) GRM.S().nnFormatUnassigned = idx; UpdateText(); end, function() return GetPreviewList("NICKUNASSIGNED", 3) end, nil, true, function() CloseOtherDropdowns(8) end, 4)

    f:SetScript("OnShow", function()
        GRM_G.SettingsTabFocus = GRM_ENUM.OPTIONS_TABS.NAMES
        GRM_UI.GRM_CoreFrame.GRM_CoreFrameReScale:Show()
    end)

    UpdateText()
end