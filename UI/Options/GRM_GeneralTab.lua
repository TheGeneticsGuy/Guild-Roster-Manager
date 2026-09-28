local GeneralTab = {};
GRM_UI.GeneralTab = GeneralTab;

GeneralTab.InitializeGeneralTab = function( isManualUpdate )
    local optionsFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame;

    GRM_UI.CreateCoreFrame("GRM_GeneralOptionsFrame", optionsFrame, nil, GRM_ENUM.OPTIONS_SIZE.W, GRM_ENUM.OPTIONS_SIZE.H, nil, false, {"BOTTOMLEFT", "BOTTOMLEFT", 0, 0}, nil, false, false)
    local GRM_GeneralOptionsFrame = optionsFrame.GRM_GeneralOptionsFrame

    if not isManualUpdate then
        GRM_GeneralOptionsFrame:SetScript ( "OnHide" , function()
            if GRM_G.MainTagColor then
                GRM_UI.ColorPickerFrame:Hide();
            end
        end);

        GRM_GeneralOptionsFrame:SetScript ( "OnShow" , function()
            GRM_G.SettingsTabFocus = GRM_ENUM.OPTIONS_TABS.GENERAL;
            GRM_UI.GRM_RosterChangeLogFrame.GRM_RosterChangeLogFrameReScale:Show();
        end);

        
    end


    -- TODO - Adapt to new UI API
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton = CreateFrame ( "CheckButton" , "GRM_RosterLoadOnLogonCheckButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButton = CreateFrame ( "CheckButton" , "GRM_RosterLoadOnLogonChangesCheckButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_UXOptionsFrame.GRM_ColorizeSystemMessagesCheckButton = CreateFrame ( "CheckButton" , "GRM_ColorizeSystemMessagesCheckButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_UXOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_UXOptionsFrame.GRM_ColorizeSystemMessagesCheckButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_UXOptionsFrame.GRM_ColorizeSystemMessagesCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton = CreateFrame ( "CheckButton" , "GRM_ShowMinimapButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton = CreateFrame ( "CheckButton" , "GRM_AchievementAnnounceButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton = CreateFrame ( "CheckButton" , "GRM_SyncAllSettingsCheckButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButton = CreateFrame ( "CheckButton" , "GRM_DefaultTabSelectionButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

    -- Message Destination
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox = CreateFrame( "EditBox" , "GRM_ReportDestinationEditBox" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InputBoxTemplate" );

    -- Language Selection
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelectionText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected = CreateFrame ( "Frame" , "GRM_LanguageSelected" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InsetFrameTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:Hide();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected.GRM_LanguageSelectedText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu = CreateFrame ( "Frame" , "GRM_LanguageDropDownMenu" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected , "InsetFrameTemplate" );

    -- Font Selection
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected = CreateFrame ( "Frame" , "GRM_FontSelected" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InsetFrameTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:Hide();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected.GRM_FontSelectedText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu = CreateFrame ( "Frame" , "GRM_FontDropDownMenu" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected , "InsetFrameTemplate" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected = CreateFrame ( "Frame" , "GRM_NonGlobalTimestampSelected" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InsetFrameTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:Hide();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected.GRM_NonGlobalTimestampSelectedText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu = CreateFrame ( "Frame" , "GRM_NonGlobalTimestampSelectedDropDownMenu" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected , "InsetFrameTemplate" );

    -- 24 or 12hr timescale Selection
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected = CreateFrame ( "Frame" , "GRM_24HrSelected" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InsetFrameTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:Hide();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu = CreateFrame ( "Frame" , "GRM_24HrSelectedDropDownMenu" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected , "InsetFrameTemplate" );

    -- Default Tab Selection
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected = CreateFrame ( "Frame" , "GRM_DefaultTabSelected" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InsetFrameTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:Hide();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected.GRM_DefaultTabSelectedText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu = CreateFrame ( "Frame" , "GRM_DefaultTabMenu" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected , "InsetFrameTemplate" );

    -- Fontstrnig
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFrameText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFormattingText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton = CreateFrame ( "CheckButton" , "GRM_SyncCompatibilityMessageButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    
    -- OPTIONS font size slider
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider = CreateFrame ( "Slider" , "GRM_FontSizeSlider" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "MinimalSliderWithSteppersTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText2 = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText3 = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

    -- OPTIONS Tooltip size slider
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider = CreateFrame ( "Slider" , "GRM_TooltipScaleSlider" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , "MinimalSliderWithSteppersTemplate" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText2 = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );


    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFrameText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , 18 , - 30 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFrameText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 20 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFrameText:SetText ( GRM.L ( "General:" ) );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFrameText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFormattingText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationText , "BOTTOMLEFT" , 0 , - 15 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFormattingText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 20 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFormattingText:SetText ( GRM.L ( "Style Choices:" ) );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFormattingText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );

    -- Show Minimap CheckButton!
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFrameText , "BOTTOMLEFT" , -4 , -4 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButtonText:SetText ( GRM.L ( "Show Minimap Button" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButtonText );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton:SetScript ( "OnClick" , function( self , button )
        if button == "LeftButton" then
            if self:GetChecked() then
                GRM.S().minimapEnabled = true;
                GRM.MinimapGRM.Show();
                GRM_MinimapPosition.hide = false;
            else
                GRM.S().minimapEnabled = false;
                GRM.MinimapGRM.Hide();
                GRM_MinimapPosition.hide = true;
            end
        end
    end);

    if LibStub and LibStub("LibDataBroker-1.1", true ) and LibStub("LibDBIcon-1.0", true) then
        GRM_UI.CreateRadialButtons ( "GRM_MinimapTypeButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame , nil , { GRM.L ( "Standard" ) , GRM.L ( "Move Anywhere" ) } , { "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButtonText , "RIGHT" , 10 , 0 } , true , true , 12 , nil , GRM.MinimapGRM.SetSelectedMinimap );
    end

    -- Sync Addon Settings
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton , "BOTTOMLEFT" , 0 , -6 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButtonText:SetText ( GRM.L ( "Sync Addon Settings on All Alts in Same Guild" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButtonText );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton:SetScript ( "OnClick" , function( self , button )
        if button == "LeftButton" then
            if self:GetChecked() then
                GRM_G.playerOnlySettings = false;
                GRM_AddonSettings_Save[GRM_G.addonUser] = nil;
                GRM.S().syncSettings = true;
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.settingsOwner:SetText ( GRM.L ( "{name}'s Settings" , GRM.SlimName ( GRM_G.guildName ) ) );
                GRM.SetJoinAndRejoinTags();
                GRM_UI.OptionsCore.RefreshOptionsUI();

                if GRM.S().minimapEnabled then
                    GRM.MinimapGRM.Show();
                    GRM_MinimapPosition.hide = false;
                else
                    GRM.MinimapGRM.Hide();
                    GRM_MinimapPosition.hide = true;
                end

            else
                GRM.S().syncSettings = false;
                GRM_G.playerOnlySettings = true;
                GRM_AddonSettings_Save[GRM_G.addonUser] = GRM.Util.DeepCopyArray ( GRM_AddonSettings_Save[GRM_G.guildName] );
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.settingsOwner:SetText ( GRM.L ( "{name}'s Settings" , GRM.SlimName ( GRM_G.addonUser ) ) );
                GRM.SetJoinAndRejoinTags();
                GRM_UI.OptionsCore.RefreshOptionsUI();

                if GRM.S().minimapEnabled then
                    GRM.MinimapGRM.Show();
                    GRM_MinimapPosition.hide = false;
                else
                    GRM.MinimapGRM.Hide();
                    GRM_MinimapPosition.hide = true;
                end

            end
        end
    end);

    -- Show at Logon Button
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton , "BOTTOMLEFT" , 0 , -6 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButtonText:SetText ( GRM.L ( "Show at Logon" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButtonText );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton:SetScript ( "OnClick", function()
        if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton:GetChecked() then
            GRM.S().viewOnLoad = true;
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButton:Enable();
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButtonText:SetTextColor ( 1.0 , 0.82 , 0.0 , 1.0 );
        else
            GRM.S().viewOnLoad = false;
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButton:Disable();
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButtonText:SetTextColor ( 0.5 , 0.5 , 0.5 , 1 );
        end
    end);

    -- Show only if changes checkButton
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButton:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButtonText , "RIGHT" , 6 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButton , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButtonText:SetText ( GRM.L ( "Only Show if Log Changes" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButton , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButtonText );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonChangesCheckButton:SetScript ( "OnClick", function( self )
        if self:GetChecked() then
            GRM.S().onlyViewIfChanges = true;
        else
            GRM.S().onlyViewIfChanges = false;
        end
    end);

    -- Report Destination
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton , "BOTTOMLEFT" , 5 , -12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationText:SetText ( GRM.L ( "Chat Window for All GRM Messages:" ) );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationText , "RIGHT" , 8 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetSize ( 240 , 22 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetMaxLetters ( 127 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetFontObject ( "GameFontWhite" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetTextInsets( 2 , 3 , 3 , 2 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetAutoFocus ( false );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:EnableMouse ( true );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetJustifyH ( "CENTER" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetScript ( "OnEnter" , function( self )
        if not self:HasFocus() then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "Channel Settings Are Character Specific and Will Not Be Sync'd" ) );
            GameTooltip:AddLine ( GRM.L ( "Multi-Channel support. Just separate with commas" ) );
            GameTooltip:Show();
        end
    end)
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

    -- Setting the info to the editBox
    GRM_UI.ReportDestination = function( reportEditBox )
        reportEditBox:SetText ( GRM.BuildMultiChannelString() );
    end
    
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetScript ( "OnShow" , function ( self )
        GRM_UI.ReportDestination ( self );
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetScript ( "OnEscapePressed" , function ( self )
        self:ClearFocus();
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetScript ( "OnEnterPressed" , function ( self )
        local text = self:GetText();
        GRM.EstablishNewCustomReportWindow ( text );
        if GRM_G.Compat.ChattynatorLoaded then
            GRM.chattynator.InitializeTabsForGRM();
        end
        self:ClearFocus();
        GRM_UI.ReportDestination ( self );
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetScript ( "OnEditFocusLost" , function ( self )

        if self:IsVisible() then
            local text = self:GetText();
            GRM.EstablishNewCustomReportWindow ( text );
            if GRM_G.Compat.ChattynatorLoaded then
                GRM.chattynator.InitializeTabsForGRM();
            end
            self:ClearFocus();
        else
            self:HighlightText ( 0 , 0 );
        end

        GRM_UI.ReportDestination ( self );
        if GRM_G.Compat.ChattynatorLoaded then
            GRM.chattynator.CleanupChattynatorTabs();
        end
    end)

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetScript ( "OnEditFocusGained" , function ( self )
        self:HighlightText ( 0 );
        self:SetCursorPosition ( 0 );
        GRM.RestoreTooltip()
    end);

    -- LANGUAGE SELECTION
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelectionText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_GeneralOptionsFormattingText , "BOTTOMLEFT" , 0 , -12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelectionText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelectionText:SetText ( GRM.L ( "Language Selection:" ) );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected , "TOPRIGHT" , 1 , -3.5 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetWidth ( 290 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetWordWrap ( false );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelectionText , "RIGHT" , 8 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:SetSize (  115 , 18 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected.GRM_LanguageSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected.GRM_LanguageSelectedText:SetWidth ( 130 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected.GRM_LanguageSelectedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected , "BOTTOM" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:SetWidth ( 115 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:SetFrameStrata ( "DIALOG" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:Show();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Hide();
    end)

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:SetScript ( "OnMouseDown" , function( _ , button )
        if button == "LeftButton" then
            if  GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:IsVisible() then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Hide();
            else
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Hide();

                GRM_UI.DD.PopulateLanguageDropdown();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Show();
            end
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:SetScript ( "OnEnter" , function( self )
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:IsVisible() and not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:IsVisible() then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r to Change the Language" ) );
            GameTooltip:Show();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end)

    -- FONT SELECTION
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelectionText , "BOTTOMLEFT" , 0 , -16 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontText:SetText ( GRM.L ( "Font Selection:" ) );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected , "BOTTOMLEFT" , 0 , -10 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:SetSize (  115 , 18 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected.GRM_FontSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected.GRM_FontSelectedText:SetWidth ( 115 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected.GRM_FontSelectedText:SetWordWrap ( false );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected , "BOTTOM" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:SetWidth ( 115 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:SetFrameStrata ( "DIALOG" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:Show();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Hide();
    end)

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:SetScript ( "OnMouseDown" , function( _ , button )
        if button == "LeftButton" then
            if  GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:IsVisible() then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Hide();
            else
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Hide();
                GRM_UI.DD.PopulateFontDropdown();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Show();
            end
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:SetScript ( "OnEnter" , function( self )
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:IsVisible() then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r to Change the Font" ) );
            GameTooltip:Show();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end)

-- Non Global Timestamp
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText , "BOTTOMLEFT" , 0 , -18 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalText:SetText ( GRM.L ( "Timestamp Format:" ) );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalText , "RIGHT" , 3 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:SetSize (  115 , 18 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected.GRM_NonGlobalTimestampSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected.GRM_NonGlobalTimestampSelectedText:SetWidth ( 110 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected.GRM_NonGlobalTimestampSelectedText:SetWordWrap ( false );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected.GRM_NonGlobalTimestampSelectedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected.GRM_NonGlobalTimestampSelectedText:SetJustifyH ( "CENTER" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected , "BOTTOM" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:SetWidth ( 115 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:SetFrameStrata ( "DIALOG" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:Show();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:Hide();
    end)

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:SetScript ( "OnMouseDown" , function( _ , button )
        if button == "LeftButton" then
            if  GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:IsVisible() then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:Hide();
            else
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Hide();
                GRM_UI.DD.PopulateTimestampFormatDropDown ( true );
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:Show();
            end
        end
    end);

    -- 24Hr Time Selection
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected , "RIGHT" , 25 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrText:SetText ( GRM.L ( "Hour Format:" ) );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrText , "RIGHT" , 10 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:SetSize (  115 , 18 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText:SetWidth ( 110 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText:SetWordWrap ( false );GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText:SetJustifyH ( "CENTER" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected , "BOTTOM" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:SetWidth ( 115 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:SetFrameStrata ( "DIALOG" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:Show();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Hide();
    end)

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:SetScript ( "OnMouseDown" , function( _ , button )
        if button == "LeftButton" then
            if  GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:IsVisible() then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Hide();
            else
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Hide();
                GRM_UI.DD.Populate24HrDropDown();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Show();
            end
        end
    end);

    -- FONT SLIDER
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText , "RIGHT" , 20 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetMinMaxValues ( 75 , 125 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetObeyStepOnDrag ( true );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetValueStep ( 5 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetWidth ( 170 );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected , "RIGHT" , 20 , 2 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText:SetText ( GRM.L ( "Font Scale:" ) );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText:SetWordWrap ( true );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText:SetJustifyH ( "CENTER" );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText2:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider , "RIGHT" , 20 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText3:SetPoint ( "BOTTOM" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider , "TOP" , 0 , 10 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText3:SetText ( GRM.L ( "Example" ) );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText3:SetTextColor ( 1 , 0.82 , 0 , 1 );
    local modifier = 0;
    if GRM.S() then
        modifier = GRM.S().fontModifier;
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 + modifier );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetScript ( "OnValueChanged" , function( _ , value )
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText2:SetText ( math.floor ( value + 0.5 ) .. "%" );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSliderText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 + ( ( math.floor ( value + 0.5 ) - 100  ) / 10 ) );
        if GameTooltip:IsVisible() then
            GRM.RestoreTooltip();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetScript ( "OnMouseUp" , function ( self , button )
        if button == "RightButton" then
            self:SetValue ( 100 );
            if GRM.S().fontModifier ~= 0 then
                GRM.S().fontModifier = 0;
                GRML.SetNewFont ( GRM.S().selectedFont );
            end
        elseif button == "LeftButton" then
            GRM.S().fontModifier = ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:GetValue() - 100 ) / 10;
            GRML.SetNewFont ( GRM.S().selectedFont );
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetScript ( "OnEnter" , function ( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        GameTooltip:AddLine( GRM.L ( "Right-Click to Reset to 100%" ) );
        GameTooltip:Show();
    end);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSizeSlider.Slider:SetScript ( "OnLeave" , function ()
        if GameTooltip:IsVisible() then
            GRM.RestoreTooltip();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontText , "BOTTOMLEFT" , 0 , -18 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText:SetText ( GRM.L ( "Tooltip Scale:" ) );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText , "RIGHT" , 20 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetMinMaxValues ( 50 , 150 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetObeyStepOnDrag ( true );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetValueStep ( 5 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetWidth ( 175 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText2:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider , "RIGHT" , 20 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetScript ( "OnValueChanged" , function( self , value )
        if self:IsVisible() and ( self:IsMouseOver() or GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Forward:IsMouseOver() or GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Back:IsMouseOver() ) then
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSliderText2:SetText ( math.floor ( value + 0.5 ) .. "%" );
            GameTooltip:SetScale ( ( ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:GetValue() - 50 ) / 5 ) * 0.02 + 0.8 );

            if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Forward:IsMouseOver() or GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Back:IsMouseOver() then
                GRM.S().tooltipSize = ( ( ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:GetValue() - 50 ) / 5 ) * 0.02 + 0.8 );
                GRM_UI.NewTooltipScale();
            end
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetScript ( "OnMouseUp" , function ( self , button )
        if button == "RightButton" then
            self:SetValue ( 100 );
            GRM.S().tooltipSize = 1.0;
        elseif button == "LeftButton" then
            GRM.S().tooltipSize = ( ( ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:GetValue() - 50 ) / 5 ) * 0.02 + 0.8 );
            GRM_UI.NewTooltipScale();
        end
    end);

    local ScaleSliderTooltip = function( self )
        if not GameTooltip:IsVisible() and not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:IsVisible() and not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:IsVisible() then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "This only affects GRM tooltips" ) , 1 , 0 , 0  );
            GameTooltip:AddLine( " " );
            GameTooltip:AddLine( GRM.L ( "Right-Click to Reset to 100%" ) );
            GameTooltip:Show();
        end
    end

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetScript ( "OnEnter" , function ( self )
        ScaleSliderTooltip ( self );
    end)
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Slider:SetScript ( "OnLeave" , function ()
        GRM.RestoreTooltip()
    end);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Forward:SetScript ( "OnEnter" , function ( self )
        ScaleSliderTooltip ( self );
    end)
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Forward:SetScript ( "OnLeave" , function ()
        GRM.RestoreTooltip()
    end);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Back:SetScript ( "OnEnter" , function ( self )
        ScaleSliderTooltip ( self );
    end)
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_TooltipScaleSlider.Back:SetScript ( "OnLeave" , function ()
        GRM.RestoreTooltip()
    end);


    -- ONLY APPLIES TO CLASSIC WOTLK
    if GRM_G.BuildVersion < 40000 and GRM_G.BuildVersion >= 30000 then

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButtonText , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButtonText:SetText ( GRM.L ( "Achievement Announce" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButtonText );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton:SetScript ( "OnClick" , function( self , button )
            if button == "LeftButton" then
                if self:GetChecked() then
                    GRM.S().achievements = true;
                else
                    GRM.S().achievements = false;
                end
            end
        end);

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "Only Guild Members with GRM installed will see." ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_AchievementAnnounceButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip()
        end);

    end

    -- Sync options - Hide messages recommending others to update addon.
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButton , "BOTTOMLEFT" , 0 , -6 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton , "RIGHT" , 2 , 0)
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButtonText:SetText ( GRM.L ( "Be Informed When GRM is out of date." ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButtonText );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton:SetScript ( "OnClick", function( self )
        if self:GetChecked() then
            GRM.S().syncCompatibilityMsg = true;
        else
            GRM.S().syncCompatibilityMsg = false;
        end
    end);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton:SetScript ( "OnEnter" , function( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        GameTooltip:AddLine( GRM.L ( "This only reports to chat once per session." ) );
        GameTooltip:Show();
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncCompatibilityMessageButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_RosterLoadOnLogonCheckButton , "BOTTOMLEFT" , 0 , -6 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButton , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButtonText:SetText ( GRM.L ( "Always open to selected tab:" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButton , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButtonText );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButton:SetScript ( "OnClick" , function( self , button )
        if button == "LeftButton" then
            if self:GetChecked() then
                GRM.S().defaultTabSelection[1] = true;
            else
                GRM.S().defaultTabSelection[1] = false;
            end
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelectionButtonText , "RIGHT" , 1.0 , 1.5 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:SetSize (  110 , 18 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected.GRM_DefaultTabSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected.GRM_DefaultTabSelectedText:SetWidth ( 105 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected.GRM_DefaultTabSelectedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:SetPoint ( "TOP" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected , "BOTTOM" );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:SetWidth ( 110 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:SetFrameStrata ( "DIALOG" );


    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:Show();
        end
    end);

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Hide();
    end)

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:SetScript ( "OnMouseDown" , function( _ , button )
        if button == "LeftButton" then
            if  GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:IsVisible() then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Hide();
            else
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelectedDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Hide();
                GRM_UI.DD.PopulateDefaultTabDropdown();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Show();
            end
        end
    end);

    -- For tooltip
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton:SetScript ( "OnEnter" , function( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        GameTooltip:AddLine( GRM.L ( "This only affects settings for your current guild: {name}" , "|cff00ccff" .. GRM.SlimName ( GRM_G.guildName ) .. "|r" ) )
        GameTooltip:Show();
    end);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_SyncAllSettingsCheckButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

end