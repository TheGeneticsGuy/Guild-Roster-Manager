local NamesTab = {};
GRM_UI.NamesTab = NamesTab;

-- Dropdown Arrays
local ddMainFormat = { "Smashy (Do not modify chat)", "Smashy <M>", "Smashy <Smashy>" }
local ddAltFormat = { "Smashy (Do not modify chat)", "Smashy <A> (Arkaan <M>)", "Smashy <A>", "Smashy (Arkaan)", "Smashy <Arkaan>" }
local ddNickMainFormat = { "Smashy (Boss)", "Smashy <Boss>", "Smashy ~Boss~", "*Boss* (Replace Name)" }
local ddNickAltFormat = { "Smashy (Boss)", "Smashy <Boss>", "*Boss* (Replace Name)", "Smashy (Boss) <Arkaan>", "*Boss* <Arkaan>" }

NamesTab.BuildNamesTab = function()
    GRM_UI.CreateCoreFrame("GRM_NamesOptionsFrame", GRM_UI.GRM_CoreFrame.GRM_OptionsFrame, nil, GRM_ENUM.OPTIONS_SIZE.W, GRM_ENUM.OPTIONS_SIZE.H, nil, false, {"BOTTOMLEFT", "BOTTOMLEFT", 0, 0}, nil, false, false)
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame

    ---------------------------------------
    -- SECTION 1 - STANDARD FORMATTING   --
    ---------------------------------------
    GRM_UI.CreateString("GRM_NameOptionsTitle", f, "GameFontNormal", GRM.L("Standard Name Formatting") .. ":", 20, {"TOPLEFT", f, "TOPLEFT", 18, -25}, nil, {0.0, 0.8, 1.0})
    
    -- Main 
    GRM_UI.CreateString("GRM_MainFmtLbl", f, "GameFontWhite", GRM.L("Format for Mains:"), 12, {"TOPLEFT", f.GRM_NameOptionsTitle, "BOTTOMLEFT", 5, -15})
    GRM_UI.CreateDropDownMenu("GRM_MainFormatDD", f, nil, {"TOPLEFT", f.GRM_MainFmtLbl, "BOTTOMLEFT", -5, -5}, {200, 25}, ddMainFormat, 12, {1,1,1}, nil, nil, function(idx) GRM.S().nameFormatMain = idx; NamesTab.UpdateText() end, nil, nil, true)
    GRM_UI.CreateString("GRM_MainLivePreview", f, "GameFontWhite", "", 12, {"LEFT", f.GRM_MainFormatDDSelected, "RIGHT", 15, 0})

    -- Alt 
    GRM_UI.CreateString("GRM_AltFmtLbl", f, "GameFontWhite", GRM.L("Format for Alts:"), 12, {"TOPLEFT", f.GRM_MainFormatDDSelected, "BOTTOMLEFT", 5, -15})
    GRM_UI.CreateDropDownMenu("GRM_AltFormatDD", f, nil, {"TOPLEFT", f.GRM_AltFmtLbl, "BOTTOMLEFT", -5, -5}, {200, 25}, ddAltFormat, 12, {1,1,1}, nil, nil, function(idx) GRM.S().nameFormatAlt = idx; NamesTab.UpdateText() end, nil, nil, true)
    GRM_UI.CreateString("GRM_AltLivePreview", f, "GameFontWhite", "", 12, {"LEFT", f.GRM_AltFormatDDSelected, "RIGHT", 15, 0})

    -- Color Picker for Standard Tags
    GRM_UI.CreateString("GRM_StdColorLbl", f, "GameFontWhite", GRM.L("Standard Tag Color:"), 12, {"LEFT", f.GRM_AltLivePreview, "RIGHT", 25, 0})
    GRM_UI.ColorPicker.CreateColorBox("GRM_MainColorPicker", f, 18, {"LEFT", f.GRM_StdColorLbl, "RIGHT", 10, 0}, GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b, function(r,g,b)
        GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b = r, g, b
        NamesTab.UpdateText()
    end)

    ---------------------------------------
    -- SECTION 2 - NICKNAME FORMATTING   --
    ---------------------------------------
    GRM_UI.CreateString("GRM_NickOptionsTitle", f, "GameFontNormal", GRM.L("Nickname Formatting") .. ":", 20, {"TOPLEFT", f.GRM_AltFormatDDSelected, "BOTTOMLEFT", -5, -35}, nil, {0.0, 0.8, 1.0})

    -- Nickname on Main 
    GRM_UI.CreateString("GRM_NickMainFmtLbl", f, "GameFontWhite", GRM.L("Format for Mains with Nicknames:"), 12, {"TOPLEFT", f.GRM_NickOptionsTitle, "BOTTOMLEFT", 5, -15})
    GRM_UI.CreateDropDownMenu("GRM_NickMainFormatDD", f, nil, {"TOPLEFT", f.GRM_NickMainFmtLbl, "BOTTOMLEFT", -5, -5}, {200, 25}, ddNickMainFormat, 12, {1,1,1}, nil, nil, function(idx) GRM.S().nicknameFormatMain = idx; NamesTab.UpdateText() end, nil, nil, true)
    GRM_UI.CreateString("GRM_NickMainLivePreview", f, "GameFontWhite", "", 12, {"LEFT", f.GRM_NickMainFormatDDSelected, "RIGHT", 15, 0})

    -- Nickname on Alt
    GRM_UI.CreateString("GRM_NickAltFmtLbl", f, "GameFontWhite", GRM.L("Format for Alts with Nicknames:"), 12, {"TOPLEFT", f.GRM_NickMainFormatDDSelected, "BOTTOMLEFT", 5, -15})
    GRM_UI.CreateDropDownMenu("GRM_NickAltFormatDD", f, nil, {"TOPLEFT", f.GRM_NickAltFmtLbl, "BOTTOMLEFT", -5, -5}, {200, 25}, ddNickAltFormat, 12, {1,1,1}, nil, nil, function(idx) GRM.S().nicknameFormatAlt = idx; NamesTab.UpdateText() end, nil, nil, true)
    GRM_UI.CreateString("GRM_NickAltLivePreview", f, "GameFontWhite", "", 12, {"LEFT", f.GRM_NickAltFormatDDSelected, "RIGHT", 15, 0})

    -- Color Picker for Nickname Tags
    GRM_UI.CreateString("GRM_NickColorLbl", f, "GameFontWhite", GRM.L("Nickname Tag Color:"), 12, {"LEFT", f.GRM_NickAltLivePreview, "RIGHT", 25, 0})
    GRM_UI.ColorPicker.CreateColorBox("GRM_NickColorPicker", f, 18, {"LEFT", f.GRM_NickColorLbl, "RIGHT", 10, 0}, GRM.S().nicknameTagColor.r, GRM.S().nicknameTagColor.g, GRM.S().nicknameTagColor.b, function(r,g,b)
        GRM.S().nicknameTagColor.r, GRM.S().nicknameTagColor.g, GRM.S().nicknameTagColor.b = r, g, b
        NamesTab.UpdateText()
    end)

    f:SetScript("OnShow", function()
        GRM_G.SettingsTabFocus = GRM_ENUM.OPTIONS_TABS.NAMES
        GRM_UI.GRM_CoreFrame.GRM_CoreFrameReScale:Show()
    end)

    NamesTab.UpdateText()
end

NamesTab.UpdateText = function()
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame

    -- Dropdown Texts
    f.GRM_MainFormatDDSelected.GRM_MainFormatDDSelectedText:SetText(ddMainFormat[GRM.S().nameFormatMain] or ddMainFormat[1])
    f.GRM_AltFormatDDSelected.GRM_AltFormatDDSelectedText:SetText(ddAltFormat[GRM.S().nameFormatAlt] or ddAltFormat[2])
    f.GRM_NickMainFormatDDSelected.GRM_NickMainFormatDDSelectedText:SetText(ddNickMainFormat[GRM.S().nicknameFormatMain] or ddNickMainFormat[1])
    f.GRM_NickAltFormatDDSelected.GRM_NickAltFormatDDSelectedText:SetText(ddNickAltFormat[GRM.S().nicknameFormatAlt] or ddNickAltFormat[1])

    -- Live Previews
    f.GRM_MainLivePreview:SetText("[Guild] [" .. GRM_Name.GetFormattedNameString("Smashy", "Smashy", "", true) .. "]: Hello!")
    f.GRM_AltLivePreview:SetText("[Guild] [" .. GRM_Name.GetFormattedNameString("Smashy", "Arkaan", "", false) .. "]: Hello!")
    f.GRM_NickMainLivePreview:SetText("[Guild] [" .. GRM_Name.GetFormattedNameString("Smashy", "Smashy", "Boss", true) .. "]: Hello!")
    f.GRM_NickAltLivePreview:SetText("[Guild] [" .. GRM_Name.GetFormattedNameString("Smashy", "Arkaan", "Boss", false) .. "]: Hello!")
end