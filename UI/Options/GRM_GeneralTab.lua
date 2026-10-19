local GeneralTab = {};
GRM_UI.GeneralTab = GeneralTab;


local function GetTimestampList()
    local list = {}
    local month, day, year = select(2, GRM.Time.GetTodaysDate());
    -- Generate the 17 format examples dynamically
    for i = 1, 17 do
        list[i] = GRM.Time.FormatTimeStamp({day, month, year}, false, false, i)
    end
    return list
end

-- Show Minimap
local function ToggleMinimap(self)
    GRM.S().minimapEnabled = self:GetChecked()
    if GRM.S().minimapEnabled then
        GRM.MinimapGRM.Show(); GRM_MinimapPosition.hide = false
    else
        GRM.MinimapGRM.Hide(); GRM_MinimapPosition.hide = true
    end
end

-- Sync Settings
local syncTooltip = function(self)
    GRM_UI.SetTooltipScale()
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:AddLine(GRM.L("This only affects settings for your current guild: {name}", "|cff00ccff" .. GRM.SlimName(GRM_G.guildName) .. "|r"))
    GameTooltip:Show()
end

local ToggleSync = function(self)
    GRM.S().syncSettings = self:GetChecked()
    GRM_G.playerOnlySettings = not GRM.S().syncSettings
    
    if GRM.S().syncSettings then
        GRM_AddonSettings_Save[GRM_G.addonUser] = nil
        OptionsFrame.settingsOwner:SetText(GRM.L("{name}'s Settings", GRM.SlimName(GRM_G.guildName)))
    else
        GRM_AddonSettings_Save[GRM_G.addonUser] = GRM.Util.DeepCopyArray(GRM_AddonSettings_Save[GRM_G.guildName])
        OptionsFrame.settingsOwner:SetText(GRM.L("{name}'s Settings", GRM.SlimName(GRM_G.addonUser)))
    end
    GRM.SetJoinAndRejoinTags()
    GRM_UI.OptionsCore.RefreshOptionsUI()
    ToggleMinimap(GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton) 
end

-- Show At Logon
local ToggleShowOnLogon = function(self)
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
    GRM.S().viewOnLoad = self:GetChecked()
    if GRM.S().viewOnLoad then
        f.GRM_RosterLoadOnLogonChangesCheckButton:Enable()
        f.GRM_RosterLoadOnLogonChangesCheckButtonText:SetTextColor(1.0, 0.82, 0.0, 1.0)
    else
        f.GRM_RosterLoadOnLogonChangesCheckButton:Disable()
        f.GRM_RosterLoadOnLogonChangesCheckButtonText:SetTextColor(0.5, 0.5, 0.5, 1)
    end
end

-- Language
local function GetLanguageList()
    local list = {}
    for i = 1, #GRML.Languages do
        list[i] = GRM.L(GRML.Languages[i])
    end
    return list
end

local function SelectFont(parsedNumber)
    GRM.S().selectedFont = parsedNumber;
    GRML.SetNewFont(parsedNumber);

    -- Additional frame check...
    GRM_UI.ElvUIReset = true;
    GRM_UI.ElvUIReset2 = true;
    if GRM.IsAddOnLoaded("AddOnSkins") then
        GRM_UI.GRM_CoreFrame:Hide();
        GRM_UI.GRM_CoreFrame:Show();
        if GRM_UI.GRM_Mouseover:IsVisible() then
            GRM_UI.GRM_Mouseover:Hide();
            GRM_G.pause = true;
            GRM_UI.GRM_Mouseover:Show();
        end
    end
    
    GRM_UI.OptionsCore.RefreshOptionsUI()
end

local function SelectTimestamp(parsedNumber)
    GRM.S().dateFormat = parsedNumber;
    GRM.ReprocessAllLogEntriesToCurrentLanguage();
    GRM_UI.OptionsCore.RefreshOptionsUI()
end

local function SelectLanguage(parsedNumber)
    GRM.S().selectedLang = parsedNumber;
    GRM_G.LocalizedIndex = parsedNumber;
    GRM.S().selectedFont = GRML.GetFontChoiceIndex(parsedNumber);
    GRML.SetNewLanguage(GRM.S().selectedLang, false, false);

    -- Special UI Reset Logic (From your old Populate function)
    GRM_UI.ElvUIReset = true;
    GRM_UI.ElvUIReset2 = true;
    
    local count = GRML.GetNumberUntranslatedLines(GRM.S().selectedLang);
    if GRM_G.Region == "enUS" then count = count - 10 end
    
    if count > 0 and not GRML.TranslationStatusEnum[GRML.Languages[GRM.S().selectedLang]] then
        local msg = GRM.L("{num} phrases still need translation to {name}", GRM.L(GRML.Languages[GRM.S().selectedLang]), nil, count)
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetText(msg);
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:Show();
    else
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:Hide();
    end

    if GRM.IsAddOnLoaded("AddOnSkins") then
        GRM_UI.GRM_CoreFrame:Hide();
        GRM_UI.GRM_CoreFrame:Show();
        if GRM_UI.GRM_Mouseover:IsVisible() then
            GRM_UI.GRM_Mouseover:Hide();
            GRM_G.pause = true;
            GRM_UI.GRM_Mouseover:Show();
        end
    end

    if parsedNumber == GRM_G.LocalizedIndex then
        GRM.Report(GRM.L("Font has been Reset to DEFAULT."));
    end
    
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame.GRM_LevelRange:SetText(GRM.GetLevelRange());
    GRM.ReprocessAllLogEntriesToCurrentLanguage();

    if #GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons > 0 then
        GRM.Log.ResetLogStringPoints(GRM.S().showLineNumbers);
    end
    
    -- Refresh options to show updated dropdown labels
    GRM_UI.OptionsCore.RefreshOptionsUI()
end

-- 24Hr Time
local function Get24HrList()
    return { GRM.L("24 Hour"), GRM.L("12 Hour (am/pm)") }
end

local function Select24HrFormat(parsedNumber)
    GRM.S().twentyFourHrScale = (parsedNumber == 1)
    GRM.ReprocessAllLogEntriesToCurrentLanguage();
    GRM_UI.OptionsCore.RefreshOptionsUI()
end

local function ToggleOnlyChanges(self)
    GRM.S().onlyViewIfChanges = self:GetChecked()
end

-- Default Tabs
local function GetDefaultTabList()
    return { GRM.L("LOG"), GRM.L("EVENTS"), GRM.L("BAN LIST"), GRM.L("SYNC USERS"), string.upper(GRM.L("Options")), GRM.L("AUDIT") }
end

local function GetFontList()
    return GRML.FontNames
end

local function ToggleCompat(self)
    GRM.S().syncCompatibilityMsg = self:GetChecked()
end

local function ProcessDestinationEditBox(self)
    local text = self:GetText()
    GRM_Chat.EstablishNewCustomReportWindow(text)
    if GRM_G.Compat.ChattynatorLoaded then
        GRM.chattynator.InitializeTabsForGRM()
    end
    self:ClearFocus()
    GRM_UI.ReportDestination(self)
end

local function ToggleDefaultTab(self)
    GRM.S().defaultTabSelection[1] = self:GetChecked()
end

local compatTooltip = function(self)
    GRM_UI.SetTooltipScale()
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:AddLine(GRM.L("This only reports to chat once per session."))
    GameTooltip:Show()
end

local editBoxTooltip = function(self)
    if not self:HasFocus() then
        GRM_UI.SetTooltipScale()
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        GameTooltip:AddLine(GRM.L("Channel Settings Are Character Specific and Will Not Be Sync'd"))
        GameTooltip:AddLine(GRM.L("Multi-Channel support. Just separate with commas"))
        GameTooltip:Show()
    end
end

-- Tooltip Size Slider
local function UpdateTooltipSlider(value)
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
    if f.GRM_TooltipScaleSlider:IsVisible() and
        (f.GRM_TooltipScaleSlider.Slider:IsMouseOver() or f.GRM_TooltipScaleSlider.Forward:IsMouseOver() or f.GRM_TooltipScaleSlider.Back:IsMouseOver()) then
        f.GRM_TooltipScaleSlider.Slider.GRM_TooltipScaleSliderText2:SetText(math.floor(value + 0.5) .. "%")
        local scale = ((value - 50) / 5) * 0.02 + 0.8
        GameTooltip:SetScale(scale)
        
        if f.GRM_TooltipScaleSlider:IsMouseOver() or f.GRM_TooltipScaleSlider:IsMouseOver() then
            GRM.S().tooltipSize = (scale)
            GRM_UI.NewTooltipScale()
        end
    end
end

local function OnTooltipSliderMouseUp(self, button)
    if button == "RightButton" then
        self:SetValue(100)
        GRM.S().tooltipSize = 1.0
    elseif button == "LeftButton" then
        GRM.S().tooltipSize = (((self:GetValue() - 50) / 5) * 0.02 + 0.8)
        GRM_UI.NewTooltipScale()
    end
end

local ttSliderTooltip = function(self)
    if not GameTooltip:IsVisible() then
        GRM_UI.SetTooltipScale()
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        GameTooltip:AddLine(GRM.L("This only affects GRM tooltips"), 1, 0, 0)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(GRM.L("Right-Click to Reset to 100%"))
        GameTooltip:Show()
    end
end

-- Font Size Slider
local function UpdateFontSlider(value)
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider
    -- Update the "%" text
        f.GRM_FontSizeSliderText2:SetText(math.floor(value + 0.5) .. "%")
        
        -- Update the "Example" text scale live
        f.GRM_FontSizeSliderTextExample:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12 + ((math.floor(value + 0.5) - 100) / 10))
end

local function OnFontSliderMouseUp(self, button)
    if button == "RightButton" then
        if GRM.S().fontModifier ~= 0 then
            GRM.S().fontModifier = 0; 
            GRML.SetNewFont(GRM.S().selectedFont)
        end
    elseif button == "LeftButton" then
        GRM.S().fontModifier = (self:GetValue() - 100) / 10
        GRML.SetNewFont(GRM.S().selectedFont)
    end
end

local achieveTooltip = function(self)
    GRM_UI.SetTooltipScale()
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:AddLine(GRM.L("Only Guild Members with GRM installed will see."))
    GameTooltip:Show()
end

local function ToggleAchieve(self)
    GRM.S().achievements = self:GetChecked()
end

local fontSliderTooltip = function(self)
    GRM_UI.CreateTooltipFromTable(self, {1, GRM.L("Right-Click to Reset to 100%")})
end

local CloseOtherDropdowns = function(ind)
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame

    if ind ~= 1 then
        f.GRM_DefaultTabDDMenu:Hide()
    end

    if ind ~= 2 then
        f.GRM_TimestampDDMenu:Hide()
    end

    if ind ~= 3 then
        f.GRM_24HrDDMenu:Hide()
    end

    if ind ~= 4 then
        f.GRM_LanguageDDMenu:Hide()
    end

    if ind ~= 5 then
        f.GRM_FontDDMenu:Hide()
    end
end

GeneralTab.UpdateText = function()
    local f = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
    if not f then return end

    -- Language
    f.GRM_LanguageDDSelected.GRM_LanguageDDSelectedText:SetText(GRM.L(GRML.Languages[GRM.S().selectedLang]))
    
    -- Font
    f.GRM_FontDDSelected.GRM_FontDDSelectedText:SetText(GRML.FontNames[GRM.S().selectedFont])
    f.GRM_FontDDSelected.GRM_FontDDSelectedText:SetFont(GRML.listOfFonts[GRM.S().selectedFont], GRM_G.FontModifier + 11)

    -- Timestamp
    local month, day, year = select(2, GRM.Time.GetTodaysDate())
    f.GRM_TimestampDDSelected.GRM_TimestampDDSelectedText:SetText(GRM.Time.FormatTimeStamp({day, month, year}, false, false, GRM.S().dateFormat))

    -- 24hr / 12hr Time
    local HourFormat = { GRM.L("24 Hour"), GRM.L("12 Hour (am/pm)") }
    f.GRM_24HrDDSelected.GRM_24HrDDSelectedText:SetText(GRM.S().twentyFourHrScale and HourFormat[1] or HourFormat[2])

    -- Default Tab
    local tabChoices = GetDefaultTabList()
    f.GRM_DefaultTabDDSelected.GRM_DefaultTabDDSelectedText:SetText(tabChoices[GRM.S().defaultTabSelection[2]])
    
    -- Default Tab Checkbox (Since it wasn't tracked globally)
    f.GRM_DefaultTabSelectionButton:SetChecked(GRM.S().defaultTabSelection[1])

    -- Sliders
    local fontVal = (GRM.S().fontModifier * 10) + 100
    f.GRM_FontSizeSlider.Slider:SetValue(fontVal)
    f.GRM_FontSizeSlider.Slider.GRM_FontSizeSliderText2:SetText(math.floor(fontVal + 0.5) .. "%")
    if f.GRM_FontSizeSlider.Slider.GRM_FontSizeSliderTextExample then
        f.GRM_FontSizeSlider.Slider.GRM_FontSizeSliderTextExample:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12 + GRM.S().fontModifier)
    end

    local ttVal = (((GRM.S().tooltipSize - 0.8) / 0.02) * 5) + 50
    f.GRM_TooltipScaleSlider.Slider:SetValue(ttVal)
    f.GRM_TooltipScaleSlider.Slider.GRM_TooltipScaleSliderText2:SetText(math.floor(ttVal + 0.5) .. "%")

end

-- General first time only UI initialization
GeneralTab.InitializeGeneralTab = function(isManualUpdate)
    local OptionsFrame = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame;

    GRM_UI.CreateCoreFrame("GRM_GeneralOptionsFrame", OptionsFrame, nil, GRM_ENUM.OPTIONS_SIZE.W, GRM_ENUM.OPTIONS_SIZE.H, nil,
                            false, {"BOTTOMLEFT", "BOTTOMLEFT", 0, 0}, nil, false, false)
    local f = OptionsFrame.GRM_GeneralOptionsFrame

    if not isManualUpdate then
        f:SetScript("OnShow", function()
            GRM_G.SettingsTabFocus = GRM_ENUM.OPTIONS_TABS.GENERAL;
            GRM_UI.GRM_CoreFrame.GRM_CoreFrameReScale:Show();
            if f.GRM_ReportDestinationEditBox then
                GRM_UI.ReportDestination(f.GRM_ReportDestinationEditBox)
            end
        end);
    end

    GRM_UI.CreateString("GRM_GeneralOptionsFrameText", f, "GameFontNormal", GRM.L("General:"), 20, {"TOPLEFT", f, "TOPLEFT", 18, -30},
                        nil, {0.0, 0.8, 1.0})
    GRM_UI.CreateCheckBox("GRM_ShowMinimapButton", f, nil, nil, {"TOPLEFT", f.GRM_GeneralOptionsFrameText, "BOTTOMLEFT", -4, -4}, ToggleMinimap,
                            GRM.L("Show Minimap Button"), "GameFontNormalSmall", 12)

    if LibStub and LibStub("LibDataBroker-1.1", true) and LibStub("LibDBIcon-1.0", true) then
        GRM_UI.CreateRadialButtons("GRM_MinimapTypeButton", f, nil, {GRM.L("Standard"), GRM.L("Move Anywhere")}, {"LEFT", f.GRM_ShowMinimapButton.GRM_ShowMinimapButtonText, "RIGHT", 10, 0},
                                    true, true, 12, nil, GRM.MinimapGRM.SetSelectedMinimap)
    end

    GRM_UI.CreateCheckBox("GRM_SyncAllSettingsCheckButton", f, nil, nil, {"TOPLEFT", f.GRM_ShowMinimapButton, "BOTTOMLEFT", 0, -6}, ToggleSync,
                            GRM.L("Sync Addon Settings on All Alts in Same Guild"), "GameFontNormalSmall", 12, syncTooltip, GRM.RestoreTooltip)
    GRM_UI.CreateCheckBox("GRM_RosterLoadOnLogonCheckButton", f, nil, nil, {"TOPLEFT", f.GRM_SyncAllSettingsCheckButton, "BOTTOMLEFT", 0, -6},
                            ToggleShowOnLogon, GRM.L("Show at Logon"), "GameFontNormalSmall", 12)
    GRM_UI.CreateCheckBox("GRM_RosterLoadOnLogonChangesCheckButton", f, nil, nil, {"LEFT", f.GRM_RosterLoadOnLogonCheckButton.GRM_RosterLoadOnLogonCheckButtonText, "RIGHT", 6, 0},
                          ToggleOnlyChanges, GRM.L("Only Show if Log Changes"), "GameFontNormalSmall", 12)
    GRM_UI.CreateCheckBox("GRM_SyncCompatibilityMessageButton", f, nil, nil, {"TOPLEFT", f.GRM_RosterLoadOnLogonCheckButton, "BOTTOMLEFT", 0, -6},
                          ToggleCompat, GRM.L("Be Informed When GRM is out of date."), "GameFontNormalSmall", 12, compatTooltip, GRM.RestoreTooltip)
    GRM_UI.CreateCheckBox("GRM_DefaultTabSelectionButton", f, nil, nil, {"TOPLEFT", f.GRM_SyncCompatibilityMessageButton, "BOTTOMLEFT", 0, -6}, ToggleDefaultTab, GRM.L("Default Open Tab:"), "GameFontNormalSmall", 12)
    GRM_UI.CreateDropDownMenu("GRM_DefaultTabDD", f, nil, {"LEFT", f.GRM_DefaultTabSelectionButton.GRM_DefaultTabSelectionButtonText, "RIGHT", 8, 0}, {110, 25}, GetDefaultTabList(), 12, {1,1,1},
                            GRM.L("{custom1} to Change Default GRM Tab on First Open.", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Left-Click") .. "|r"), GRM.RestoreTooltip, function(idx) GRM.S().defaultTabSelection[2] = idx end,
                            nil, nil, true, function() CloseOtherDropdowns(1) end)

    -- =======================================================
    -- REPORT DESTINATION EDITBOX
    -- =======================================================
    GRM_UI.CreateString("GRM_ReportDestinationText", f, "GameFontNormalSmall", GRM.L("Chat Window for All GRM Messages:"), 12,
                        {"TOPLEFT", f.GRM_DefaultTabSelectionButton, "BOTTOMLEFT", 5, -12})

    GRM_UI.CreateEditBox("GRM_ReportDestinationEditBox", f, "InputBoxTemplate", 240, 22, {"LEFT", f.GRM_ReportDestinationText, "RIGHT", 8, 0}, "CENTER", {1,1,1},
                         127, false, editBoxTooltip, GRM.RestoreTooltip, nil, nil, false, ProcessDestinationEditBox)
    
    if not isManualUpdate then
        f.GRM_ReportDestinationEditBox:HookScript("OnEditFocusLost", function()
            if GRM_G.Compat.ChattynatorLoaded then
                GRM.chattynator.CleanupChattynatorTabs()
            end
        end)
    end

    -- GRM_L["{custom1} to Change the Font"] = true -- NOT USED??!?!?!?!?
    -- UPDATE GRM.L("|CFFE6CC7FLeft-Click|r to Change Tab")

    GRM_UI.CreateString("GRM_GeneralOptionsFormattingText", f, "GameFontNormal", GRM.L("Style Choices:"), 20, {"TOPLEFT", f.GRM_ReportDestinationText, "BOTTOMLEFT", 0, -10},
                        nil, {0.0, 0.8, 1.0})

    -- TIMESTAMP FORMAT
    local DEFAULT_SIZE = {150, 25}

    GRM_UI.CreateString("GRM_TimestampLbl", f, "GameFontNormalSmall", GRM.L("Timestamp:"), 12, {"TOPLEFT", f.GRM_GeneralOptionsFormattingText, "BOTTOMLEFT", 0, -16})
    GRM_UI.CreateDropDownMenu("GRM_TimestampDD", f, nil, {"LEFT", f.GRM_TimestampLbl, "RIGHT", 8, 0}, DEFAULT_SIZE, GetTimestampList(), 12, {1,1,1},
                                nil, nil, function(idx) SelectTimestamp(idx) end, nil, nil, true, function() CloseOtherDropdowns(2) end)

    -- 24HR FORMAT
    GRM_UI.CreateString("GRM_24HrLbl", f, "GameFontNormalSmall", GRM.L("Hour Format:"), 12, {"LEFT", f.GRM_TimestampDDSelected, "RIGHT", 25, 0})
    GRM_UI.CreateDropDownMenu("GRM_24HrDD", f, nil, {"LEFT", f.GRM_24HrLbl, "RIGHT", 8, 0}, DEFAULT_SIZE, Get24HrList(), 12, {1,1,1},
                                nil, nil, function(idx) Select24HrFormat(idx) end, nil, nil, true, function() CloseOtherDropdowns(3) end)
                                
    -- LANGUAGE
    GRM_UI.CreateString("GRM_LanguageLbl", f, "GameFontNormalSmall", GRM.L("Language:"), 12, {"TOPLEFT", f.GRM_TimestampLbl, "BOTTOMLEFT", 0, -16})
    GRM_UI.CreateDropDownMenu("GRM_LanguageDD", f, nil, {"TOPLEFT", f.GRM_TimestampDDSelected, "BOTTOMLEFT", 0, -4}, DEFAULT_SIZE, GetLanguageList(), 12, {1,1,1},
                            GRM.L("{custom1} to Change the Language", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Left-Click") .. "|r"), GRM.RestoreTooltip,
                            function(idx) SelectLanguage(idx) end, nil, nil, true, function() CloseOtherDropdowns(4) end)
    
    GRM_UI.CreateString("GRM_LanguageCountText", f, "GameFontNormalSmall", "", 12, {"LEFT", f.GRM_LanguageDDSelected, "RIGHT", 10, 0}, 290, {0.0, 0.8, 1.0}, "LEFT", false)
    
    -- FONT
    GRM_UI.CreateString("GRM_FontLbl", f, "GameFontNormalSmall", GRM.L("Font:"), 12, {"TOPLEFT", f.GRM_LanguageLbl, "BOTTOMLEFT", 0, -16})
    GRM_UI.CreateDropDownMenu("GRM_FontDD", f, nil, {"TOPLEFT", f.GRM_LanguageDDSelected, "BOTTOMLEFT", 0, -4}, DEFAULT_SIZE, GetFontList(), 12, {1,1,1},
                            GRM.L("{custom1} to Change Display Format", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Left-Click") .. "|r"), GRM.RestoreTooltip,
                            function(idx) SelectFont(idx) end, nil, nil, true, function() CloseOtherDropdowns(5) end)
    
    -- =======================================================
    -- SLIDERS
    -- =======================================================
    
    GRM_UI.CreateOptionsSlider("GRM_FontSizeSlider", f, "MinimalSliderWithSteppersTemplate", {"TOPLEFT", f.GRM_FontLbl, "BOTTOMLEFT", 0, -16}, 75, 125, 5, 12, GRM.L("Font Scale:"), 100, "GameFontNormalSmall", UpdateFontSlider, fontSliderTooltip, GRM.RestoreTooltip, OnFontSliderMouseUp, true)
    f.GRM_FontSizeSlider.Slider:SetWidth(175)

    -- Preview of Font Size
    GRM_UI.CreateString("GRM_FontSizeSliderTextExample", f.GRM_FontSizeSlider.Slider, "GameFontNormal", GRM.L("Example"), 12, {"LEFT", f.GRM_FontSizeSlider.Forward, "RIGHT", 75, 0}, nil, {1, 0.82, 0})

    -- Tooltip Size Slider
    GRM_UI.CreateOptionsSlider("GRM_TooltipScaleSlider", f, "MinimalSliderWithSteppersTemplate", {"TOPLEFT", f.GRM_FontSizeSlider.GRM_FontSizeSliderText, "BOTTOMLEFT", 0, -16}, 50, 150, 5, 12, GRM.L("Tooltip Scale:"), 100, "GameFontNormalSmall", UpdateTooltipSlider, ttSliderTooltip, GRM.RestoreTooltip, OnTooltipSliderMouseUp, true, false)
    f.GRM_TooltipScaleSlider.Slider:SetWidth(175)

    f.GRM_TooltipScaleSlider.Slider:SetScript ( "OnEnter" , function ( self ) ttSliderTooltip ( self ); end)
    f.GRM_TooltipScaleSlider.Slider:SetScript ( "OnLeave" , GRM.RestoreTooltip)
    f.GRM_TooltipScaleSlider.Forward:SetScript ( "OnEnter" , function ( self ) ttSliderTooltip ( self ); end)
    f.GRM_TooltipScaleSlider.Forward:SetScript ( "OnLeave" , GRM.RestoreTooltip)
    f.GRM_TooltipScaleSlider.Back:SetScript ( "OnEnter" , function ( self ) ttSliderTooltip ( self ); end)
    f.GRM_TooltipScaleSlider.Back:SetScript ( "OnLeave" , GRM.RestoreTooltip)

    -- =======================================================
    -- CLASSIC ONLY
    -- =======================================================
    if GRM_G.BuildVersion < GRM_ENUM.BUILD.CATA and GRM_G.BuildVersion >= GRM_ENUM.BUILD.WOTLK then      
        GRM_UI.CreateCheckBox("GRM_AchievementAnnounceButton", f, nil, nil, {"BOTTOMLEFT", f, "BOTTOMLEFT", 15, 25}, ToggleAchieve, GRM.L("Achievement Announce"), "GameFontNormalSmall", 12, achieveTooltip, GRM.RestoreTooltip)
    end

    GeneralTab.UpdateText()
end

-- =======================================================
-- UTILITIES
-- =======================================================

GeneralTab.BuildMultiChannelString = function()
    local channels = GRM.S().reportChannel
    if #channels == 0 then
        return DEFAULT_CHAT_FRAME.name
    end
    return table.concat(channels, ",")
end

-- Keep in global GRM_UI since used in many places
GRM_UI.ReportDestination = function(reportEditBox)
    reportEditBox:SetText(GeneralTab.BuildMultiChannelString())
end