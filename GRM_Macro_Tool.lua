
-- Mass Kick, Promote, and Demote tool

-- CREATING FRAMES -- 
-- Core Frame
GRM_UI.GRM_ToolCoreFrame = CreateFrame( "Frame" , "GRM_ToolCoreFrame" , UIParent , "TranslucentFrameTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame = CreateFrame( "Frame" , "GRM_ToolIgnoreListFrame" , UIParent , "TranslucentFrameTemplate" );

-- Core Frame Close Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameCloseButton = CreateFrame( "Button" , "GRM_ToolCoreFrameCloseButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelCloseButton" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameCloseButton:SetPoint( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame , 3 , 3 );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreListFrameCloseButton = CreateFrame( "Button" , "GRM_ToolIgnoreListFrameCloseButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "UIPanelCloseButton" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreListFrameCloseButton:SetPoint( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , 3 , 3 );

-- Core Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton = CreateFrame( "Button" , "GRM_ToolBuildMacroButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:CreateFontString ( "GRM_ToolBuildMacroButtonText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton = CreateFrame( "Button" , "GRM_ToolViewSafeListButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:CreateFontString ( "GRM_ToolViewSafeListButtonText" , "OVERLAY" , "GameFontNormalTiny" );

-- Macro Control Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton = CreateFrame( "Button" , "GRM_ToolClearSelectedMacrodNamesButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton:CreateFontString ( "GRM_ToolClearSelectedMacrodNamesButtonText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton = CreateFrame( "Button" , "GRM_ToolResetSelectedMacroNamesButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton:CreateFontString ( "GRM_ToolResetSelectedMacroNamesButtonText" , "OVERLAY" , "GameFontNormalTiny" );

-- Reset Settings
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton = CreateFrame( "Button" , "GRM_ToolResetSettingsButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:CreateFontString ( "GRM_ToolResetSettingsButtonText" , "OVERLAY" , "GameFontNormalTiny" );

-- Core Ignore List Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton = CreateFrame( "Button" , "GRM_ToolIgnoreClearSelectionButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton:CreateFontString ( "GRM_ToolIgnoreClearSelectionButtonText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton = CreateFrame( "Button" , "GRM_ToolIgnoreResetSelectedNamesButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton:CreateFontString ( "GRM_ToolIgnoreResetSelectedNamesButtonText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton = CreateFrame( "Button" , "GRM_ToiolIgnoreRemoveAllButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton:CreateFontString ( "GRM_ToolIgnoreRemoveAllButtonText" , "OVERLAY" , "GameFontNormalTiny" );

-- Text
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText1" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText2 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText2" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText3" , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText4" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText5" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText6 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText6" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText7" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText8 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText8" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText9 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText9" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText10 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameText10" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTextPermissions" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTextPermissions1" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTextPermissions2" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTextPermissions3" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTextPermissions1_K" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTextPermissions2_P" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTextPermissions3_D" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameKickRulesText = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameKickRulesText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTotalQueText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText2 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTotalQueText2" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTotalIgnoredText" , "OVERLAY" , "GameFontNormalTiny" )
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText2 = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameTotalIgnoredText2" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameRankRestrictionText = GRM_UI.GRM_ToolCoreFrame:CreateFontString ( "GRM_ToolCoreFrameRankRestrictionText" , "OVERLAY" , "GameFontNormalTiny" );

-- Safe Details
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( "GRM_ToolCoreIgnoreFrameText1" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( "GRM_ToolCoreIgnoreFrameText2" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( "GRM_ToolCoreIgnoreFrameText3" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText4 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( "GRM_ToolCoreIgnoreFrameText4" , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolCoreIgnoreCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:CreateFontString ( "GRM_ToolCoreIgnoreCheckButtonText" , "OVERLAY" , "GameFontNormalSmall" );

-- Rules mini window
GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules = CreateFrame( "Frame" , "GRM_ToolKickRules" , GRM_UI.GRM_ToolCoreFrame );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolPromoteRules = CreateFrame( "Frame" , "GRM_ToolKickRules" , GRM_UI.GRM_ToolCoreFrame );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolDemoteRules = CreateFrame( "Frame" , "GRM_ToolKickRules" , GRM_UI.GRM_ToolCoreFrame );

-- Pinned Rules
GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed = CreateFrame ( "CheckButton" , "GRM_ToolAltsOfflineTimed" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed:CreateFontString ( "GRM_ToolAltsOfflineTimedText" , "OVERLAY" , "GameFontNormalSmall" );

-- Tabs
GRM_UI.GRM_ToolCoreFrame.GRM_KickTab = CreateFrame ( "Button" , "GRM_KickTab" , GRM_UI.GRM_ToolCoreFrame , "TabButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText = GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:CreateFontString ( "GRM_KickTabText" , "OVERLAY" , "GameFontNormal" );
GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab = CreateFrame ( "Button" , "GRM_PromoTab" , GRM_UI.GRM_ToolCoreFrame , "TabButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText = GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:CreateFontString ( "GRM_PromoTabText" , "OVERLAY" , "GameFontNormal" );
GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab = CreateFrame ( "Button" , "GRM_DemoteTab" , GRM_UI.GRM_ToolCoreFrame , "TabButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText = GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:CreateFontString ( "GRM_DemoteTabText" , "OVERLAY" , "GameFontNormal" );

-- Macro'd Scroll Frame
-- SCROLL FRAME
GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_ToolMacrodScrollFrame" , GRM_UI.GRM_ToolCoreFrame );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame = CreateFrame ( "Frame" , "GRM_ToolMacrodScrollBorderFrame" , GRM_UI.GRM_ToolCoreFrame , "TranslucentFrameTemplate" );
-- CONTENT FRAME (Child Frame)
GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame = CreateFrame ( "Frame" , "GRM_ToolMacrodScrollChildFrame" );
-- SLIDER
GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder = CreateFrame ( "Slider" , "GRM_ToolMacrodScrollFrameSilder" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame , "UIPanelScrollBarTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:Hide();

-- Queued Scroll Frame
GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_ToolQueuedScrollFrame" , GRM_UI.GRM_ToolCoreFrame );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame = CreateFrame ( "Frame" , "GRM_ToolQueuedScrollBorderFrame" , GRM_UI.GRM_ToolCoreFrame , "TranslucentFrameTemplate" );
-- CONTENT FRAME (Child Frame)
GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame = CreateFrame ( "Frame" , "GRM_ToolQueuedScrollChildFrame" );
-- SLIDER
GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder = CreateFrame ( "Slider" , "GRM_ToolQueuedScrollFrameSilder" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame , "UIPanelScrollBarTemplate" )
GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:Hide();

-- Ignored Scroll Frame
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_ToolIgnoredScrollFrame" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollBorderFrame = CreateFrame ( "Frame" , "GRM_ToolIgnoredScrollBorderFrame" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "TranslucentFrameTemplate" );
-- CONTENT FRAME (Child Frame)
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame = CreateFrame ( "Frame" , "GRM_ToolIgnoredScrollChildFrame" );
-- SLIDER
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder = CreateFrame ( "Slider" , "GRM_ToolIgnoredScrollFrameSilder" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame , "UIPanelScrollBarTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:Hide();

----------------------
-- Custom Rules ------
----------------------

GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton = CreateFrame( "Button" , "GRM_CustomRuleAddButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:CreateFontString ( "GRM_CustomRuleAddButtonText" , "OVERLAY" , "GameFontNormalTiny" );

-- Custom Rules Popup Frame
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame = CreateFrame ( "Frame" , "GRM_ToolCustomRulesFrame" , GRM_UI.GRM_ToolCoreFrame , "TranslucentFrameTemplate" );

-- Rank Custom Rules
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBox = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRankCheckBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBoxText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBox:CreateFontString ( "GRM_ToolCustomRulesRankCheckBoxText" , "OVERLAY" , "GameFontNormalSmall" );

-- Level Custom Rules
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelCheckBox = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesLevelCheckBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelCheckBoxText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelCheckBox:CreateFontString ( "GRM_ToolCustomRulesLevelCheckBoxText" , "OVERLAY" , "GameFontNormalSmall" );

-- Class Custom Rules
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClassCheckBox = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClassCheckBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClassCheckBoxText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClassCheckBox:CreateFontString ( "GRM_ToolCustomRulesClassCheckBoxText" , "OVERLAY" , "GameFontNormalSmall" );

-- Custom Rules RankCheckBoxes
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank1 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank1" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank2 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank2" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank3 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank3" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank4 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank4" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank5 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank5" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank6 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank6" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank7 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank7" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank8 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank8" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank9 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank9" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank1.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank1:CreateFontString ( "GRM_ToolCustomRulesRank1Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank2.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank2:CreateFontString ( "GRM_ToolCustomRulesRank2Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank3.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank3:CreateFontString ( "GRM_ToolCustomRulesRank3Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank4.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank4:CreateFontString ( "GRM_ToolCustomRulesRank4Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank5.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank5:CreateFontString ( "GRM_ToolCustomRulesRank5Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank6.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank6:CreateFontString ( "GRM_ToolCustomRulesRank6Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank7.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank7:CreateFontString ( "GRM_ToolCustomRulesRank7Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank8.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank8:CreateFontString ( "GRM_ToolCustomRulesRank8Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank9.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRank9:CreateFontString ( "GRM_ToolCustomRulesRank9Text" , "OVERLAY" , "GameFontNormalSmall" );

-- Custom Rules ClassCheckBoxes
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass1 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass1" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass2 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass2" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass3 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass3" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass4 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass4" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass5 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass5" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass6 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass6" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass7 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass7" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass8 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass8" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass9 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass9" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass10 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass10" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass11 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass11" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass12 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClass12" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass1.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass1:CreateFontString ( "GRM_ToolCustomRulesClass1Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass2.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass2:CreateFontString ( "GRM_ToolCustomRulesClass2Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass3.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass3:CreateFontString ( "GRM_ToolCustomRulesClass3Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass4.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass4:CreateFontString ( "GRM_ToolCustomRulesClass4Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass5.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass5:CreateFontString ( "GRM_ToolCustomRulesClass5Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass6.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass6:CreateFontString ( "GRM_ToolCustomRulesClass6Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass7.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass7:CreateFontString ( "GRM_ToolCustomRulesClass7Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass8.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass8:CreateFontString ( "GRM_ToolCustomRulesClass8Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass9.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass9:CreateFontString ( "GRM_ToolCustomRulesClass9Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass10.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass10:CreateFontString ( "GRM_ToolCustomRulesClass10Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass11.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass11:CreateFontString ( "GRM_ToolCustomRulesClass11Text" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass12.text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClass12:CreateFontString ( "GRM_ToolCustomRulesClass12Text" , "OVERLAY" , "GameFontNormalSmall" );

-- Custom Rules General Fontstrings
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( "GRM_ToolRuleNumberText" , "OVERLAY" , "GameFontNormal" );

-- Confirm and Cancel Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton = CreateFrame( "Button" , "GRM_ToolCustomRulesConfirmButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:CreateFontString ( "GRM_ToolCustomRulesConfirmButtonText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton = CreateFrame( "Button" , "GRM_ToolCustomRulesCancelButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:CreateFontString ( "GRM_ToolCustomRulesCancelButtonText" , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesFrameCloseButton = CreateFrame( "Button" , "GRM_ToolCustomRulesFrameCloseButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIPanelCloseButton" );

-- Custom Rule Filters
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolRecommendKickCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "OptionsSmallCheckButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:CreateFontString ( "GRM_ToolRecommendKickCheckButtonText" , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox = CreateFrame( "EditBox" , "GRM_RosterKickRecommendEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearFocus();
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Hide();
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote = CreateFrame ( "Frame" , "GRM_RosterKickOverlayNote" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNoteText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:CreateFontString ( "GRM_RosterKickOverlayNoteText" , "OVERLAY" , "GameFontNormalSmall" );

-- Day or Month selection
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected = CreateFrame ( "Frame" , "GRM_TimeScaleSelected" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "InsetFrameTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:CreateFontString ( "GRM_TimeScaleSelectedText" , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu = CreateFrame ( "Frame" , "GRM_TimeScaleDropDownMenu" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected , "InsetFrameTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();

-----------------------
-- End Custom Rules ---
-----------------------

-- INITIALIZING FRAME VALUES
GRM_UI.GRM_ToolCoreFrame:ClearAllPoints();
GRM_UI.GRM_ToolCoreFrame:SetPoint ( "CENTER" , UIParent );
GRM_UI.GRM_ToolCoreFrame:SetFrameStrata ( "MEDIUM" );
GRM_UI.GRM_ToolCoreFrame:SetSize ( 1175 , 470 );
GRM_UI.GRM_ToolCoreFrame:EnableMouse ( true );
GRM_UI.GRM_ToolCoreFrame:SetMovable ( true );
GRM_UI.GRM_ToolCoreFrame:SetToplevel ( true );
GRM_UI.GRM_ToolCoreFrame:RegisterForDrag ( "LeftButton" );
GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnDragStart" , GRM_UI.GRM_ToolCoreFrame.StartMoving );
GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnDragStop" , function()
    GRM_UI.GRM_ToolCoreFrame:StopMovingOrSizing();
    GRM_UI.SaveToolPosition();
end);

GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:ClearAllPoints();
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetPoint ( "CENTER" , UIParent );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetFrameStrata ( "MEDIUM" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetSize ( 475 , 435 );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:EnableMouse ( true );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetMovable ( true );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetToplevel ( true );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:RegisterForDrag ( "LeftButton" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetScript ( "OnDragStart" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.StartMoving );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetScript ( "OnDragStop" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.StopMovingOrSizing );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries = {};
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:Hide();

-- Global Variables for the frames
GRM_UI.GRM_ToolCoreFrame.IsInitialized = false;
GRM_UI.GRM_ToolCoreFrame.MacroEntries = {};
GRM_UI.GRM_ToolCoreFrame.QueuedEntries = {};
GRM_UI.GRM_ToolCoreFrame.TabPosition = 1;           -- 1 = kick , 2 = promote , 3 = demote
GRM_UI.GRM_ToolCoreFrame.Timer = 0;
GRM_UI.GRM_ToolCoreFrame.Safe = {};                 -- List of safe people for whatever the reason.

GRM_UI.GRM_ToolCoreFrame:Hide();                    -- Default load position is hidden

-- Method:          GRM_UI.LoadToolFrames ( boolean )
-- What it Does:    Holds the load of all frames unless "OnShow" of the GRM_ToolCoreFrame for compartmentalized rebuilding.
-- Purpose:         More efficient resource use, also, a need to recall and reload the frames if on a language or font/font size change.
GRM_UI.LoadToolFrames = function ( isManual )

    GRM_UI.GRM_ToolCoreFrame.IsInitialized = true;

    -- Only load this once...
    if not isManual then 
        -- Use ESC key to exit window.
        GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                    if GRM.IsAnyMacroHighlighted() then
                        GRM_UI.RestoreTooltipScale();
                        GameTooltip:Hide();
                        GRM.ResetToolMacrodHighlights();
                        GRM.SetMacroButtonText();
                    else
                        self:SetPropagateKeyboardInput ( false );
                        self:Hide();
                    end
                end
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                if GRM.IsAnyIgnoredHighlighted() then
                    GRM.ResetIgnoredHighlights();
                    GRM.SetIgnoredButtonText();
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                else
                    self:SetPropagateKeyboardInput ( false );
                    self:Hide();
                end
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:SetScript ( "OnShow" , function()
            GRM.TriggerIgnoredQueuedWindowRefresh();
        end);

        GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnUpdate" , function ( self , elapsed )
            self.Timer = self.Timer + elapsed;
            if self.Timer >= 0.025 then
                if GRM_G.HK then
                    if MacroFrame:IsVisible() then          -- this needs to be hidden or the script won't update the macros.a
                        MacroFrame:Hide();
                    end
                    GRM_G.HK = false;
                    GRM.PurgeMacrodNames();
                    GRM.BuildQueuedScrollFrame ( true , false , false );
                    GRM.BuildMacrodScrollFrame ( true , true );

                    if GRM_G.CurrentlyScanning then
                        -- Trigger scan again upon completion
                        GRM_G.reDoScan = true;
                    else
                        -- Trigger scan now!
                        GRM.BuildNewRoster();
                    end
                end
                self.Timer = 0;
            end
        end);

        GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnHide" , function()
            -- Clear the macro!
            GRM.CreateMacro ( "" , "GRM_Tool" , "INV_MISC_QUESTIONMARK" , "CTRL-SHIFT-K" );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:Hide();
        end);

        -- Text
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "TOPLEFT" , 17 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1:SetWidth ( 146 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText2:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1 , "RIGHT" , 6 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText2:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText2:SetWidth ( 191 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText2:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "BOTTOMRIGHT" , -10 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3:Hide();

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "TOPLEFT" , 17 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4:SetWidth ( 146 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4 , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5:SetWidth ( 101 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText6:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "BOTTOMLEFT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText6:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText6:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame , "BOTTOMLEFT" , 20 , 15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText8:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "TOP" , 0 , 17 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText8:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText9:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "TOP" , 0 , 17 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText9:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText10:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "RIGHT" , 20 , -75 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText10:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText10:SetWidth ( 300 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText10:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText10:SetSpacing ( 1 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText10:SetText ( "|cffff0000PENDING FEATURE|r\nCustom Rules/Filters, as well as promotion and demotion mass macros are not yet implemented" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOMLEFT" , -10 , -35 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText2:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOMRIGHT" , 10 , -35 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText2:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText , "BOTTOMLEFT" , 0 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOMRIGHT" , 10 , -49 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameRankRestrictionText:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton , "BOTTOM" , 0 , -12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameRankRestrictionText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameRankRestrictionText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5 , "RIGHT" , 115 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions:SetWidth ( 150 );
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1:SetTextColor ( 0 , 0.77 , 0.063 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1 , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2:SetTextColor ( 0 , 0.77 , 0.063 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2 , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3:SetTextColor ( 0 , 0.77 , 0.063 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1 , "BOTTOM" , 0 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:SetTextColor ( 0.64 , 0.102 , 0.102 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:SetText ( "____________" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2 , "BOTTOM" , 0 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:SetTextColor ( 0.64 , 0.102 , 0.102 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:SetText ( "____________" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3 , "BOTTOM" , 0 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:SetTextColor ( 0.64 , 0.102 , 0.102 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:SetText ( "____________" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

        -- Safe List Text
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollBorderFrame , "TOPLEFT" , 17 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetWidth ( 135 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1 , "RIGHT" , 6 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetWidth ( 101 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "TOP" , 0 , -15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText4:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollBorderFrame , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText4:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText4:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "BOTTOMLEFT" , 13 , 13 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton , 27 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:SetScript ( "OnClick", function()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:GetChecked() then
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].ignoreFilter = true;
                GRM.TriggerIgnoredQueuedWindowRefresh();
            else
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].ignoreFilter = false;
                GRM.TriggerIgnoredQueuedWindowRefresh();
            end
            GRM.SyncSettings();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton , "TOP" , 0 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton:SetSize ( 110 , 75 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetWidth ( 95 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                
                local result , count = GRM.IsAnyIgnoredHighlighted();
                local msg = "";

                if result then
                    -- The action...
                    local confirmFunction = function()
                        GRM.RemoveHighlightedPlayersFromIgnoredList();  -- use popup confirm window!!!
                        if count > 1 then
                            msg = GRM.L ( "{num} players removed from the Ignored List" , nil , nil , count );
                        else
                            msg = GRM.L ( "{num} player was removed from Ignore List" , nil , nil , count );
                        end
                    end

                    if count == 1 then
                        GRM.SetConfirmationWindow ( confirmFunction , GRM.L ( "Really remove selected player from the ignore list?" ) );
                    else
                        GRM.SetConfirmationWindow ( confirmFunction , GRM.L ( "Really remove the {num} selected players from the ignore list?" , nil , nil , count ) );
                    end
                    
                else
                    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries == 0 then
                        local c = #( select ( 2 , GRM.GetSafePlayers ( true ) ) );
                        if c > 0 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].ignoreFilter then
                            if c > 1 then
                                msg = GRM.L ( "There are no names to select. {num} players are filtered" , nil , nil , c );
                            else
                                msg = GRM.L ( "There are no names to select. 1 player is filtered" );
                            end
                        else
                            msg = GRM.L ( "There are no names currently selected to be removed from the Ignore List." );
                        end
                        
                    else
                        msg = GRM.L ( "There are currently no names to remove" );
                    end
                end

                if #msg > 0 then
                    GRM.Report ( msg );
                end

            end
        end);


        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollBorderFrame , "RIGHT" , 20 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton:SetSize ( 110 , 75 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetWidth ( 95 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                local result = GRM.IsAnyIgnoredHighlighted();

                if result then
                    GRM.ResetIgnoredHighlights();
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                else
                    GRM.Report ( "Nothing to clear" );
                end

                GRM.SetIgnoredButtonText();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton:SetScript ( "OnEnter" , function( self )
            if GRM.IsAnyIgnoredHighlighted() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "Pressing the ESC key will also clear all lines" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton:SetScript ( "OnLeave" , function()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton , "BOTTOM" , 0 , -20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton:SetSize ( 110 , 75 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetWidth ( 95 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                if GRM.IsAnyIgnored() then
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                    GRM.SetConfirmationWindow ( GRM.ClearAllPlayersFromIgnoreList , GRM.L ( "Do you really wish to clear all players from the Ignore List?" ) );
                else
                    GRM.Report ( GRM.L ( "There are currently no players on the Ignore List" ) );
                end
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton:SetScript ( "OnEnter" , function( self )
            if not GRM.IsAnyIgnored() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "There are currently no players on the Ignore List" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton:SetScript ( "OnLeave" , function()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
        end);
        
        -- RULES
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetSize ( 175 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Show();
                GRM_UI.ConfigureCustomRuleKickFrame ( false , #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules + 1 );  -- Creating a new rule
            end
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules , "TOPLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed , 27 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText:SetSpacing ( 1 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText:SetWidth ( 275 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed:SetScript ( "OnClick", function()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed:GetChecked() then
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].allAltsApplyToKick = true;
                GRM_UI.RefreshManagementTool();
            else
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].allAltsApplyToKick = false;
                GRM_UI.RefreshManagementTool();
            end
            GRM.SyncSettings();
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameKickRulesText:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3 , "BOTTOM" , -85 , -12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameKickRulesText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameKickRulesText:SetWidth ( 150 );

        -- Buttons
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:SetSize ( 200 , 25 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetWidth ( 195 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_ToolCoreFrame , "BOTTOMRIGHT" , -15 , 15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetSize ( 130 , 30 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetWordWrap ( true );
        GRM_UI.ScaleFontStringToObjectSize ( true , 130 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText , 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetScript ( "OnClick" , function( _ , button )
            if button == "LeftButton" then

                local resetSettings = function()
                    GRM.ResetDefaultSettings( 10 );
                end

                if IsShiftKeyDown() and IsControlKeyDown() then
                    resetSettings();
                else
                    GRM.SetConfirmationWindow ( resetSettings , GRM.L ( "Are you sure you want to reset all Macro Tool Rules and Settings?" ) );
                end
            end
        end);
    
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetScript ( "OnEnter" , function ( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "Resets all Macro Tool Rules and Settings" ) );
            GameTooltip:AddLine( "|CFFE6CC7F" .. GRM.L ( "Ctrl-Shift-Click" ) .. "|r - " .. GRM.L ( "Resets ALL settings, not just the ones on this page" ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetScript ( "OnLeave" , function ()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "RIGHT" , 20 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton:SetSize ( 110 , 75 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetWidth ( 95 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                local result , count = GRM.IsAnyMacroHighlighted();
                local msg = "";

                if result then
                    -- The action...
                    GRM.RemoveNamesFromMacroEntries();
                    if count > 1 then
                        msg = GRM.L ( "{num} players removed from the macro" , nil , nil , count );
                    else
                        msg = GRM.L ( "{num} player was removed from the macro" , nil , nil , count );
                    end
                else
                    if #GRM_UI.GRM_ToolCoreFrame.MacroEntries > 0 then
                        msg = GRM.L ( "There are no names currently selected to be removed from the macro." );
                    else
                        if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 0 then
                            msg = GRM.L ( "The macro is not yet built. Please click the button to create the macro." );
                        else
                            msg = GRM.L ( "There are currently no names to add" );
                        end
                    end
                end

                if #msg > 0 then
                    GRM.Report ( msg );
                end
            end
        end);

        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOM" , 0 , -95 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetSize ( 130 , 25 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetWidth ( 105 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetScript ( "OnClick" , function( _ , button )
            if button == "LeftButton" then
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:Hide();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:Show();
                end
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            local countIgnored = GRM.GetSafePlayers();
            local result = "";

            if countIgnored > 0 then
                if countIgnored == 1 then
                    result = GRM.L ( "1 player is on the safe list." );
                else
                    result = GRM.L ( "{num} players are on the safe list." , nil , nil , countIgnored );
                end

                if #GRM_UI.GRM_ToolCoreFrame.Safe > 0 then
                    if #GRM_UI.GRM_ToolCoreFrame.Safe == 1 then
                        result = result .. " " .. GRM.L ( "1 action is being ignored." );
                    else
                        result = result .. " " .. GRM.L ( "{num} actions are being ignored." , nil , nil , #GRM_UI.GRM_ToolCoreFrame.Safe );
                    end
                else
                    result = result .. " " .. GRM.L ( "No current actions are being ignored" );
                end
            else
                result = GRM.L ( "No players are currently safe from recommendations" );
            end
            
            GameTooltip:AddLine ( result );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetScript ( "OnLeave" , function()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton , "BOTTOM" , 0 , -20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton:SetSize ( 110 , 75 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetWidth ( 95 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                local result = GRM.IsAnyMacroHighlighted();

                if result then
                    GRM.ResetToolMacrodHighlights();
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                else
                    GRM.Report ( "Nothing to clear" );
                end

                GRM.SetMacroButtonText();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton:SetScript ( "OnEnter" , function( self )
            if GRM.IsAnyMacroHighlighted() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "Pressing the ESC key will also clear all lines" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton:SetScript ( "OnLeave" , function()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
        end);

        -- RULES TABS
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules:SetSize ( 325 , 265 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolPromoteRules:SetSize ( 325 , 265 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolPromoteRules:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolDemoteRules:SetSize ( 325 , 265 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolDemoteRules:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , "BOTTOMLEFT" , 0 , -5 );

        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameKickRulesText , "BOTTOMLEFT" , 0 , -6 );
        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetSize ( 80 , 25 );
        PanelTemplates_TabResize ( GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , nil , 80 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetScript ( "OnClick" , function ( self , button )
            if button == "LeftButton" then
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 1;                   -- Set Position
                self:LockHighlight();                                       -- Lock Highlight
                GRM_UI.SetToolTabHighlights();
                -- Load Lock window
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetScript ( "OnEnter" , function( self )
            if not CanGuildRemove() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "Player's rank does not have permission to remove others from the guild" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetScript ( "OnLeave" , function()
            if GameTooltip:IsVisible() then
                GRM_UI.RestoreTooltipScale();
                GameTooltip:Hide();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , "RIGHT" , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:SetSize ( 80 , 25 );
        PanelTemplates_TabResize ( GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab , nil , 80 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 2;                   -- Set Position
                GRM_UI.SetToolTabHighlights();
                -- Load Lock window
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:SetScript ( "OnEnter" , function( self )
            if not CanGuildPromote() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "Player's rank does not have permission to promote others in the guild" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:SetScript ( "OnLeave" , function()
            if GameTooltip:IsVisible() then
                GRM_UI.RestoreTooltipScale();
                GameTooltip:Hide();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab , "RIGHT" , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:SetSize ( 80 , 25 );
        PanelTemplates_TabResize ( GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab , nil , 80 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:SetScript ( "OnClick" , function ( self , button )
            if button == "LeftButton" then
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 3;                   -- Set Position
                self:LockHighlight();                                       -- Lock Highlight
                GRM_UI.SetToolTabHighlights();
                -- Load Lock window
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:SetScript ( "OnEnter" , function( self )
            if not CanGuildDemote() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "Player's rank does not have permission to demote others in the guild" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:SetScript ( "OnLeave" , function()
            if GameTooltip:IsVisible() then
                GRM_UI.RestoreTooltipScale();
                GameTooltip:Hide();
            end
        end);

        -- method:          GRM_UI.SetToolTabHighlights()
        -- What it Does:    Locks the selected tab highlighted
        -- Purpose:         UX feature
        GRM_UI.SetToolTabHighlights = function()
            if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
                -- Highlights
                GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:LockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:UnlockHighlight();

                -- Rule Window
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolPromoteRules:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolDemoteRules:Hide();

                GRM.BuildCustomButtons( 1 );

            elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:LockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:UnlockHighlight();

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolPromoteRules:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolDemoteRules:Hide();

                GRM.BuildCustomButtons( 2 );

            elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:LockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:UnlockHighlight();

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolPromoteRules:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolDemoteRules:Show();

                GRM.BuildCustomButtons( 3 );
            end
        end

        -- Macro'd ScrollFrame
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame:SetSize ( 370 , 350 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame , "TOPLEFT" , 15 , -50 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:SetSize ( 352 , 326 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "BOTTOMLEFT" , 5 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:SetScrollChild ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames = {};
        -- Slider Parameters
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:SetOrientation ( "VERTICAL" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:SetSize ( 20 , 305 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame , "TOPRIGHT" , 8.5 , -10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:SetValue ( 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:SetValueStep ( 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:SetStepsPerPage ( 13 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder.currentV = 0;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:SetScript ( "OnValueChanged" , function ( self , value )
            GRM.HybridScrollOnValueChangedConfig (
                self , value , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame , 
                13 , 25 , GRM.BuildMacrodScrollFrame , GRM_UI.GRM_ToolCoreFrame.MacroEntries
            );
        end);
        
        -- Queued ScrollFrame
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame:SetSize ( 280 , 350 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "RIGHT" , 150 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame:SetHitRectInsets ( 1 , 50 , 1 , 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:SetSize ( 262 , 326 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "BOTTOMLEFT" , 5 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:SetScrollChild ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame );
        -- Slider Parameters
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:SetOrientation ( "VERTICAL" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:SetSize ( 20 , 305 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame , "TOPRIGHT" , 8.5 , -10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:SetValue ( 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:SetValueStep ( 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:SetStepsPerPage ( 13 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder.currentV = 0;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:SetScript ( "OnValueChanged" , function ( self , value )
            GRM.HybridScrollOnValueChangedConfig (
                self , value , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame , 
                13 , 25 , GRM.BuildQueuedScrollFrame , GRM_UI.GRM_ToolCoreFrame.QueuedEntries
            );
        end);

        -- Ignored ScrollFrame
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollBorderFrame:SetSize ( 290 , 325 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollBorderFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "TOPLEFT" , 30 , -60 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame:SetSize ( 272 , 301 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollBorderFrame , "BOTTOMLEFT" , 5 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame:SetScrollChild ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame );
        -- Slider Parameters
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:SetOrientation ( "VERTICAL" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:SetSize ( 20 , 280 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame , "TOPRIGHT" , 8.5 , -10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:SetValue ( 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:SetValueStep ( 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:SetStepsPerPage ( 12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder.currentV = 0;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:SetScript ( "OnValueChanged" , function ( self , value )
            GRM.HybridScrollOnValueChangedConfig (
                self , value , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame , 
                12 , 25 , GRM.BuildIgnoredScrollFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries
            );
        end);

        if not MacroFrame then
            ShowMacroFrame();
            MacroFrameCloseButton:Click();
        end

        MacroFrame:HookScript ( "OnHide" , function()
            if not GRM_G.HK then        -- Don't want to wipe the macro yet.
                if GRM_UI.GRM_ToolCoreFrame:IsVisible() and #GRM_UI.GRM_ToolCoreFrame.MacroEntries > 0 then
                    -- To ensure no overlap of default frame logic actions.
                    C_Timer.After ( 0.5 , function()
                        GRM.BuildMacrodScrollFrame ( true , true );
                    end);
                end
            end
        end);

    end

    -- End of one-time load only, now need to be reloaded on any change of font, size, or language.

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 0 then
                if MacroFrame:IsVisible() then          -- this needs to be hidden or the script won't update the macros.a
                    MacroFrame:Hide();
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames = {};
                GRM.BuildMacrodScrollFrame ( true , true );
            else
                GRM.Report ( GRM.L ( "No Names to Add to the Macro" ) );
            end
        end
    end);

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1:SetText( GRM.L ( "Name:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText2:SetText( GRM.L ( "Macro:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4:SetText( GRM.L ( "Name:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText4:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5:SetText( GRM.L ( "Action" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText5:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText6:SetText( GRM.L ( "Hot Key: {name}" , "CTRL-SHIFT-K" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText6:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText8:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText8:SetText( GRM.L ( "Queued Actions" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText9:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText9:SetText( GRM.L ( "Current Actions" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameRankRestrictionText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameRankRestrictionText:SetText( GRM.L ( "Players the same rank or higher will not be shown" ) );

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions:SetText ( GRM.L ( "Permissions" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1:SetText ( GRM.L ( "Kick" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2:SetText ( GRM.L ( "Promote" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3:SetText ( GRM.L ( "Demote" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Safe List Tool
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetText ( GRM.L ( "Name:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetText ( GRM.L ( "Ignored Action:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3:SetText ( GRM.L ( "Ignored Players Safe From Action" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText:SetText ( GRM.L ( "Only show players with ignored action" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetText ( GRM.L ( "Clear Selection" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToiolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetText ( GRM.L ( "Remove all players from Ignore List" ) );

    -- Button Text
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetText ( GRM.L ( "Clear Selection" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetText ( GRM.L ( "View Ignore List" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText:SetText ( GRM.L ( "Total Queued:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText:SetText ( GRM.L ( "Actions Ignored:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Rules
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameKickRulesText:SetText ( GRM.L ( "Rules" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameKickRulesText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText:SetText ( GRM.L ( "Only recommend to kick if all player linked alts exceed max time" ) );
    
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText:SetText ( GRM.L ( "Add Custom Rule" ) );    

    -- Tabs
    GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText:SetText ( GRM.L ( "Kick" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText:SetText ( GRM.L ( "Promote" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText:SetText ( GRM.L ( "Demote" ) );

    -- Settings Reset
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetText ( GRM.L ( "Restore Defaults" ) );
    
    ----------------------
    --- CUSTOM FILTERS ---
    ----------------------

    if not isManual then
        -- Core Frame
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:ClearAllPoints();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetPoint ( "CENTER" , UIParent );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetSize ( 450 , 550 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetMovable ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetToplevel ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetFrameStrata ( "HIGH" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:RegisterForDrag ( "LeftButton" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetScript ( "OnDragStart" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.StartMoving );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetScript ( "OnDragStop" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.StopMovingOrSizing );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        end);
        -- Close Button
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesFrameCloseButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOPRIGHT" , 0 , 0 );

        -- Title
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOP" , 0 , -18 );

        -- Confirm Button
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:SetSize ( 145 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "BOTTOM" , -20 , 15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:SetScript ( "OnClick" , function ( self , button )
            if button == "LeftButton" then
                print("Warning - not yet implemented. Just edit the time offline for now.")
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:SetSize ( 145 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "BOTTOM" , 20 , 15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:SetScript ( "OnClick" , function ( self , button )
            if button == "LeftButton" then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
            end
        end);

        -- Method:          GRM_UI.ConfigureCustomRuleKickFrame ( bool , int )
        -- What it Does:    Configures the values of all the buttons on the custom rules creation window
        -- Purpose:         Keep rules settings displayed properly.
        GRM_UI.ConfigureCustomRuleKickFrame = function ( isEdit , ruleNum )
            if isEdit then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetText ( GRM.L ( "Edit {name} Rule {num}" , GRM.L ( "Kick" ) , nil , ruleNum ) );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetText ( GRM.L ( "{name} Rule {num}" , GRM.L ( "Kick" ) , nil , ruleNum ) );
            end

            GRM_UI.SetRankNamesToCustomRuleCheckButtons( "GRM_ToolCustomRulesRank" );

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNoteText:SetText ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] );

            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][5] then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetChecked ( true );
            end

            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:IsVisible() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:Show();
            end

            local names = { GRM.L ( "Months" ) , GRM.L ( "Days" ) };
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( names[ GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] ] );

        end

        -- INACTIVITY CUSTOM RULES
        --------------------------

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOPLEFT" , 25 , -75 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetScript ( "OnClick", function()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:GetChecked() then
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][5] = true;
            else
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][5] = false;
            end
            GRM.SyncSettings();
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText , "RIGHT" , 1.0 , 0 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:SetFrameStrata ( "HIGH" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:SetSize ( 30 , 22 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNoteText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNoteText:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetSize ( 25 , 22 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetMaxLetters ( 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetNumeric ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearFocus();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.RuleButtons = {};

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:SetScript ( "OnMouseDown" , function ( self , button )
            if button == "LeftButton" then
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:IsEnabled() then
                    self:Hide();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetText ( "" );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Show()
                end
            end    
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetScript ( "OnEscapePressed" , function( self )
            self:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetScript ( "OnEnterPressed" , function( self )
            local numMonths = tonumber ( self:GetText() );
            if numMonths > 0 and numMonths < 100 then
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] = numMonths;

                -- if by month
                if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] == 1 then
                    GRM_G.NumberOfHoursTilRecommend = GRM.GetNumHoursTilRecommend ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] );

                -- if by day
                elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] == 2 then
                    GRM_G.NumberOfHoursTilRecommend = ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] * 24 );
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNoteText:SetText ( numMonths );
                self:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:Show();
                GRM_UI.RefreshManagementTool();
                GRM.SyncSettings();
            else
                if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] == 1 then
                    GRM.Report ( GRM.L ( "Please choose a month between 1 and 99" ) );
                elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] == 2 then
                    GRM.Report ( GRM.L ( "Please choose a day between 1 and 99" ) );
                end
            end      
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetScript ( "OnEditFocusLost" , function( self ) 
            self:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote:Show();
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNote , "RIGHT" , 3 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetSize (  60 , 18 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetWidth ( 50 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetWordWrap ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:SetWidth ( 60 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:SetFrameStrata ( "DIALOG" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetScript ( "OnShow" , function() 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetScript ( "OnMouseDown" , function( _ , button ) 
            if button == "LeftButton" then
                if  GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:IsVisible() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Show();
                    GRM_UI.PopulateScaleSelectionDropDown();
                end
            end
        end);

        -- Method:          GRM_UI.PopulateScaleSelectionDropDown()
        -- What it Does:    Creates a dropdown window for the GRM tool to allow player to select whether to choose months or days in terms of time passed.
        -- Purpose:         Greater flexibility and control to the player
        GRM_UI.PopulateScaleSelectionDropDown = function()
            local buffer = 3;
            local height = 0;
            local width = 60;
            local names = { GRM.L ( "Months" ) , GRM.L ( "Days" ) };

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons or {};

            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons do
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons[i][1]:Hide();
            end

            for i = 1 , 2 do
                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons[i] then
                    local tempButton = CreateFrame ( "Button" , "GRM_ToolTimeScaleButton" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons[i] = { tempButton , tempButton:CreateFontString ( "GRM_ToolTimeScaleButtonText" .. i , "OVERLAY" , "GameFontWhiteTiny" ) }
                end

                local FontButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons[i][1];
                local FontButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons[i][2];

                FontButton:SetWidth ( width );
                FontButton:SetHeight ( 11 );
                FontButton:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
                FontButtonText:SetText ( names[i] );
                FontButtonText:SetWidth ( width - 5 );
                FontButtonText:SetWordWrap ( false );
                FontButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
                FontButtonText:SetPoint ( "CENTER" , FontButton );
                FontButtonText:SetJustifyH ( "CENTER" );

                if i == 1 then
                    FontButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu , 0 , -7 );
                    height = height + FontButton:GetHeight();
                else
                    FontButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons[i - 1][1] , "BOTTOM" , 0 , -buffer );
                    height = height + FontButton:GetHeight() + buffer;
                end

                FontButton:SetScript ( "OnClick" , function( self , button ) 
                    if button == "LeftButton" then
                        local nameOfButton = self:GetName();
                        local number = tonumber ( string.sub ( nameOfButton , #nameOfButton ) );
                        local needsRefresh = false;

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( FontButtonText:GetText() );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:Show();

                        -- Days to months.
                        if number == 1 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] ~= 1 then
                            needsRefresh = true;
                            GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] = 1;
                            
                            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] == 99 then
                                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] = 12;
                                GRM.Report ( GRM.L ( "Time before recommending to kick has been set to the default period of 12 Months." ) );
                            else
                                local num = math.floor ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] / 30 );
                                if num == 0 then
                                    num = 1;
                                end
                                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] = ( num );
                                GRM.Report ( GRM.L ( "Time before recommending to kick has been set to {num} Months." , nil , nil , num ) );
                            end
                            
                        -- Going from months to days
                        elseif number == 2 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] ~= 2 then
                            needsRefresh = true;
                            GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] = 2;

                            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] > 3 then
                                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] = 99;
                                GRM.Report ( GRM.L ( "Time before recommending to kick has been set to 99 Days. For a longer time period, use the months instead." ) );
                                
                            else
                                local num = 30 * GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4];
                                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] = ( num );
                                GRM.Report ( GRM.L ( "Time before recommending to kick has been set to {num} Days." , nil , nil , num ) );
                            end

                        end

                        if needsRefresh then
                            GRM.SetNumHoursToKickValue();
                            GRM_UI.RefreshManagementTool();
                            GRM.SyncSettings();
                        end
                    end
                end);
                FontButton:Show();
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:SetHeight ( height + 15 );
        end

        -- CUSTOM RANK RULES
        --------------------

        -- What it Does:            Disables all Custom Rule Rank Checkboxes and greys them out.
        GRM_UI.DisableAllRankCheckboxes = function()
            local checkbox;
            for i = 1 , 9 do
                checkbox = GetClickFrame ( "GRM_ToolCustomRulesRank" .. i );
                checkbox:SetChecked ( true );
                checkbox:Disable();
                checkbox.text:SetTextColor ( 0.5 , 0.5 , 0.5 );
            end
        end

        -- What it Does:            Enables all Custom Rule Rank Checkboxes and greys them out.
        GRM_UI.EnableAllRankCheckBoxes = function()
            local checkbox;
            for i = 1 , 9 do
                checkbox = GetClickFrame ( "GRM_ToolCustomRulesRank" .. i );
                checkbox:Enable();
                checkbox.text:SetTextColor ( 1 , 0.82 , 0 );
            end
        end
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBox:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "BOTTOMLEFT" , 0 , -15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBoxText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBox , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBox:SetScript ( "OnClick", function()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBox:GetChecked() then
                GRM_UI.EnableAllRankCheckBoxes();
                
            else
                GRM_UI.DisableAllRankCheckboxes();

            end
        end);

        -- Initializes all checkboxes
        local BuildRankCheckBoxes = function()
            local checkBox;
            for i = 1 , 9 do
                checkbox = GetClickFrame ( "GRM_ToolCustomRulesRank" .. i );

                if i == 1 then
                    checkbox:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBoxText , "BOTTOMLEFT" , 0 , -15 );
                else
                    if i % 3 == 1 then
                        checkbox:SetPoint ( "TOPLEFT" , GetClickFrame ( "GRM_ToolCustomRulesRank" .. ( i - 3 ) ) , "BOTTOMLEFT" , 0 , -15 );
                    else
                        checkbox:SetPoint ( "LEFT" , GetClickFrame ( "GRM_ToolCustomRulesRank" .. ( i - 1 ) ) , "RIGHT" , 100 , 0 );
                    end
                end
                checkbox.text:SetPoint ( "LEFT" , checkbox , "RIGHT" , 2 , 0 );
                checkbox.text:SetWidth ( 95 );
                checkbox.text:SetJustifyH ( "LEFT" )
            end
        end

        -- local SelectRankCheckBoxes = function ( index )

        -- end

        -- RMEOVE THIS WHEN READY
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBox:Hide();
        
        

        -- BuildRankCheckBoxes();
       
        -- Method:          GRM_UI.SetRankNamesToCustomRuleCheckButtons()
        -- What it Does:    Sets all the custom rules checkbox to the rank names
        GRM_UI.SetRankNamesToCustomRuleCheckButtons = function( checkBoxName )
            local numRanks = GuildControlGetNumRanks(); -- minus 1 because we are not including the guild leader
            local checkbox;

            for i = 1 , 9 do
                checkbox = GetClickFrame ( checkBoxName .. i );

                if i <= ( numRanks - 1 ) then
                    checkbox.text:SetText ( GuildControlGetRankName ( numRanks + 1 - i ) );
                    checkbox.text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
                    checkbox:Show();
                else
                    
                    checkbox:Hide();
                end

            end
        end
    end


    -- Custom Rules Fontstrings
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText:SetText( GRM.L ( "Confirm" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText:SetText ( GRM.L ( "Cancel" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetText ( GRM.L ( "Kick Inactive Player Reminder at" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickOverlayNoteText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBoxText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesRankCheckBoxText:SetText ( GRM.L ( "Apply Only to Selected Ranks:" ) );

end

-----------------------------
--- UI Control Functions ----
-----------------------------

-- Method:          GRM_UI.RefreshToolPermissionReport()
-- What it Does:    Rebuilds the permissions text
-- Purpose:         UX
GRM_UI.RefreshToolPermissionReport = function()
    if GRM_UI.GRM_ToolCoreFrame.IsInitialized and GRM_UI.GRM_ToolCoreFrame:IsVisible() then
        if CanGuildRemove() then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:Hide();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions1_K:Show();
        end

        if CanGuildPromote() then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:Hide();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions2_P:Show();
        end

        if CanGuildDemote() then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:Hide();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTextPermissions3_D:Show();
        end
    end
end


-----------------------------
----- QUED SCROLL FRAME -----
-----------------------------

-- Method:          GRM.GetQueuedEntries ( bool )
-- What it Does:    Determines which grouping to import
-- Purpose:         Proper sorting of players in the guild to be added to the mass kick tool
GRM.GetQueuedEntries = function ( useRules )
    local result = {};

    if useRules then
        result = GRM.GetNamesByFilterRules();
    else

    end

    return result;
end

-- Method:          GRM.SetKickQueuedValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Quality of life feature.
GRM.SetKickQueuedValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind];

    -- Player Name
    line[2]:SetText ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][1] );
    line[2]:SetTextColor ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][2][1] , GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][2][2] , GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][2][3] , 1 );
    line[3]:SetText ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][4] );

    if GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][4] == GRM.L ( "Kick" )then
        line[3]:SetTextColor ( 1.0 , 0.84 , 0 , 1 );
    elseif GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][4] == GRM.L ( "Promote" ) then
        line[3]:SetTextColor ( 1.0 , 0.84 , 0 , 1 );
    elseif GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2][4] ==  GRM.L ( "Demote" ) then
        line[3]:SetTextColor ( 1.0 , 0.84 , 0 , 1 );
    end

    -- Update the tooltip if underlying data changes
    if GameTooltip:IsVisible() and GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][1]:IsMouseOver() then 
        GRM.UpdateQueuedTooltip ( ind );
    end
end

-- Method:          GRM.KickQueuedHybridShiftDown()
-- What it Does:    Shifts all the values DOWN one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.KickQueuedHybridShiftDown = function()
    if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 13 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons;
        local MouseOverButton = 0;

        -- Shift them down...
        for i = 1 , #buttons - 1 do

            -- Header Line
            buttons[i][2]:SetText( buttons[i+1][2]:GetText() );
            buttons[i][2]:SetTextColor ( buttons[i+1][2]:GetTextColor ( buttons[i+1][3]:GetText() ) );
            buttons[i][3]:SetText( buttons[i+1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i+1][3]:GetTextColor ( buttons[i+1][3]:GetText() ) );

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.KickQueuedSetLastValue();
        if MouseOverButton > 0 then
            GRM.UpdateQueuedTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.KickQueuedHybridShiftUp()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.KickQueuedHybridShiftUp = function()
    if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 13 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons;
        local MouseOverButton = 0;

        for i = #buttons , 2 , -1 do

            buttons[i][2]:SetText( buttons[i-1][2]:GetText() );
            buttons[i][2]:SetTextColor ( buttons[i-1][2]:GetTextColor ( buttons[i-1][2]:GetText() ) );
            buttons[i][3]:SetText( buttons[i-1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i-1][3]:GetTextColor ( buttons[i-1][3]:GetText() ) );

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.KickQueuedSetFirstValue();
        if MouseOverButton > 0 then
            GRM.UpdateQueuedTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.KickQueuedSetLastValue()
-- What it Does:    Sets the last value of the hybridscrollframe backups at position 16
-- Purpose:         Clean scrolling
GRM.KickQueuedSetLastValue = function()
    GRM.SetKickQueuedValues ( #GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset );
end

-- Method:          GRM.KickQueuedSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe backups at position 1
-- Purpose:         Clean scrolling
GRM.KickQueuedSetFirstValue = function()
    GRM.SetKickQueuedValues ( 1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset - #GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons + 1 );
end

-- Method:          GRM.UpdateQueuedTooltip()
-- What it Does:    Sets the tooltip for the Queued scrollframe in the GRM kick tool
-- Purpose:         Make it clear the QoL controls.
GRM.UpdateQueuedTooltip = function ( ind )

    local playerName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][2]:GetText();
    local reason = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][3]:GetText();
    local lastOnline = "";

    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][1] , "ANCHOR_CURSOR" );
    GameTooltip:AddLine ( playerName , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][2]:GetTextColor() );

    if reason == GRM.L ( "Kick" ) then

        for i = 1 , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries do
            if GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i][1] == playerName then
                lastOnline = GRM.HoursReport ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i][5] );
                break;
            end
        end
        
        GameTooltip:AddLine ( GRM.L ( "Last Online" ) );
        GameTooltip:AddLine ( lastOnline , 1 , 1 , 1 );

    elseif reason == GRM.L ( "Promote" ) then

    elseif reason == GRM.L ( "Demote" ) then

    end

    GameTooltip:AddLine ( " " );    -- adds a small space between the lines
    GameTooltip:AddLine ( GRM.L ( "|CFFE6CC7FCtrl-Click|r to open Player Window" ) );
    GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FCtrl-Shift-Click|r to Search the Log for Player" ) );
    GameTooltip:Show();

end

-- Method:          GRM.TriggerKickQueuedWindowRefresh()
-- What it Does:    Refreshes the GRM Kick Tool's Queued window after hiding the tooltip
-- Purpose:         Prevent code bloat for something with repeated use.
GRM.TriggerKickQueuedWindowRefresh = function()
    GRM_UI.RestoreTooltipScale();
    GameTooltip:Hide();
    GRM.BuildQueuedScrollFrame ( true , true , false );
    GRM_UI.RefreshToolButtonsOnUpdate();
end

-- Method:          GRM.BuildQueuedScrollFrame( bool , bool , bool )
-- What it Does:    Updates the Queued scrollframe as needed
-- Purpose:         UX of the GRM mass kick tool
GRM.BuildQueuedScrollFrame = function ( showAll , fullRefresh , isBanAltList )
    local hybridScrollFrameButtonCount = 13;
    local buttonHeight = 25;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:GetWidth() - 5;

    if showAll and fullRefresh then
        if not isBanAltList then
            GRM_UI.GRM_ToolCoreFrame.QueuedEntries = GRM.GetQueuedEntries ( true );
        else
            GRM_UI.GRM_ToolCoreFrame.QueuedEntries = GRM.DeepCopyArray ( GRM_G.KickAllAltsTable );
            GRM_G.KickAllAltsTable = {};
        end
    end

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons or {};
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset or ( hybridScrollFrameButtonCount );

    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset < hybridScrollFrameButtonCount then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset = hybridScrollFrameButtonCount;
    elseif GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset > hybridScrollFrameButtonCount and GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset > #GRM_UI.GRM_ToolCoreFrame.QueuedEntries then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset = #GRM_UI.GRM_ToolCoreFrame.QueuedEntries;
    end

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries do
        -- Build HybridScrollFrame Buttons
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[i] then

                local button = CreateFrame ( "Button" , "QueuedButton1_" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[i] = {
                    button ,
                    button:CreateFontString ( "QueuedString1_" .. i , "OVERLAY" , "GameFontWhiteTiny" ),
                    button:CreateFontString ( "QueuedString2_" .. i , "OVERLAY" , "GameFontWhiteTiny" )
                };

                button = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[i][1];
                if i == 1 then
                    button:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame , "TOP" , 7 , 0 );
                else 
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                button:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );
                GRM.BuildKickQueuedScrollButtons ( i  , false );
                
            end
        end

        if i >= ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset - hybridScrollFrameButtonCount + 1 ) and i <= GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset then
            GRM.SetKickQueuedValues ( i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset - hybridScrollFrameButtonCount ) , i );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.Offset - hybridScrollFrameButtonCount )][1]:Show();
        end
        
        -- Slider Height is controlled by tallying how many of these are necessary
        scrollHeight = scrollHeight + buttonHeight;
    end

    -- Hide unused buttons...
    for i = #GRM_UI.GRM_ToolCoreFrame.QueuedEntries + 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons do
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[i][1]:Hide();
    end

    GRM.SetHybridScrollFrameSliderParameters ( 
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder, 
        buttonWidth , buttonHeight , scrollHeight , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons , 
        GRM.KickQueuedHybridShiftDown , GRM.KickQueuedHybridShiftUp , hybridScrollFrameButtonCount
    );

    if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 13 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:Show();
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrameSilder:Hide();
    end

    if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 0 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetText( GRM.L ( "Click to Build Macro" ) );
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetText( GRM.L ( "No Current Names to Add" ) );
    end

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalQueText2:SetText ( #GRM_UI.GRM_ToolCoreFrame.QueuedEntries );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetText ( #GRM_UI.GRM_ToolCoreFrame.Safe );

end

-- Method:          GRM.BuildKickQueuedScrollButtons ( int , boolean )
-- What it Does:    Initiates the buttons and their values for each line of the Queued window of the GRM kick tool's hybridscrollframe
-- Purpose:         Create a smooth scrolling experience in the GRM kick window
GRM.BuildKickQueuedScrollButtons = function ( ind , isResizeAction )
    local coreButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][2];
    local buttonText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][3];

    -- Name
    buttonText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Actions don't need to be run more than once.
    if not isResizeAction then

        buttonText1:SetPoint ( "LEFT" , coreButton , "LEFT" , 5 , 0 );
        buttonText1:SetJustifyH ( "LEFT" );
        buttonText1:SetWidth ( 146 )
        buttonText1:SetWordWrap ( false );

        buttonText2:SetPoint ( "LEFT" , buttonText1 , "RIGHT" , 5 , 0 );
        buttonText2:SetJustifyH ( "CENTER" );
        buttonText2:SetWidth ( 101 )
        buttonText2:SetWordWrap ( false );

        coreButton:EnableMouse ( true );
        coreButton:RegisterForDrag ( "LeftButton" );

        -- Setup draggable conditions
        coreButton:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_ToolCoreFrame:StartMoving();
        end);
        coreButton:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_ToolCoreFrame:StopMovingOrSizing();
            GRM_UI.SaveToolPosition();
        end);

        coreButton:SetScript ( "OnMouseDown" , function ( _ , button )
            local playerName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][2]:GetText();
            if button == "LeftButton" then
                if IsShiftKeyDown() and IsControlKeyDown() then
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                    -- If Core GRM window is not open, let's open it!
                    if not GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                        GRM_UI.GRM_RosterChangeLogFrame:Show();
                    end
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogTab:Click();
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame.GRM_LogEditBox:SetText( GRM.SlimName ( playerName ) );
                elseif IsControlKeyDown() then
                    GRM.OpenPlayerWindow( playerName );
                end
            end
        end);            

        coreButton:SetScript ( "OnEnter" , function ()
            GRM.UpdateQueuedTooltip( ind );
        end);

        coreButton:SetScript ( "OnLeave" , function()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
        end);
    end
end

-- Method:          GRM.IsMouseStillOverAnyButton ( array )
-- What it Does:    Returns true if the mouse is still over anothe button in the hybridscrollframe
-- Purpose:         
GRM.IsMouseStillOverAnyButton = function ( buttons )
    local result = false;
        
    for i = 1 , #buttons do
        if buttons[i][1]:IsMouseOver() then
            result = true;
            break;
        end
    end

    return result;
end

---------------------------
--- MACROD Scroll Frame ---
---------------------------

-- Method:          GRM.IsAnyMacroHighlighted()
-- What it Does:    It scans t hrough the macros and reports true if any are selected and the number of selected
-- Purpose:         To adjust the text statement of the button.
GRM.IsAnyMacroHighlighted = function()
    local result = false;
    local count = 0;

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.MacroEntries do
        if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][11] then
            count = count + 1;
            result = true;
        end
    end

    return result , count;
end

-- Method:          GRM.SetMacroButtonText()
-- What it Does:    Determines which text messages needs to be set to the button text.
-- Purpose:         UX quality of life.
GRM.SetMacroButtonText = function()
    local result , count = GRM.IsAnyMacroHighlighted();
    if result then
        if count > 1 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetText ( GRM.L ( "Click to remove selected names from the macro" ) );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetText ( GRM.L ( "Click to remove selected name from the macro" ) );
        end
    else
        if #GRM_UI.GRM_ToolCoreFrame.MacroEntries == 0 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetText ( GRM.L ( "Macro is currently empty" ) );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetText ( GRM.L ( "No names selected to remove from macro" ) );
        end
    end
end

-- Method:          GRM.IsNameBlacklisted ( string )
-- What it Does:    Returns true if name is on the temp blacklisted list as it has been removed from the macro build.
-- Purpose:         Keep the purge macro names from being rebuilt into the macro, for this session of the window being open.
GRM.IsNameBlacklisted = function ( name )
    local result = false;

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames do
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames[i] == name then
            result = true;
            break;
        end
    end

    return result;
end

-- Method:          GRM.GetMacroEntries ()
-- What it Does:    Determines which grouping to import
-- Purpose:         Proper sorting of players in the guild to be added to the mass kick tool
GRM.GetMacroEntries = function ()
    local result = {};
    local macroTxt = "";
    local tempText = "";
    local finalCount = 0;
    local count = 0;
    local count2 = 0;
    local i = 1;
    local entries = GRM_UI.GRM_ToolCoreFrame.QueuedEntries;
    local macroSet = false;
    
    -- Create the macro
    while i <= #entries do
        if not GRM.IsNameBlacklisted ( entries[i][1] ) then
            tempText = macroTxt;
            -- Save room on the macro if player is on the same server as you
            if count == 0 then
                tempText = "/run GRM_G.HK=true\n" .. entries[i][3];
                count = 1;
            else
                tempText = tempText .. "\n" .. entries[i][3];
            end

            -- Macro still not full and we are still on the first set
            if #tempText < 256 and count2 == 0 then
                macroTxt = tempText;
                table.insert ( result , entries[i] );
                i = i + 1;

            -- Macro Still not full and we are on the 2nd loop that is not being used to be built
            elseif #tempText < 256 and count2 > 0 then
                macroTxt = tempText;
                i = i + 1;

            -- Macro IS full, and we are still on the first set.
            elseif #tempText > 255 and count2 == 0 then
                finalCount = #macroTxt;
                GRM.CreateMacro ( macroTxt , "GRM_Tool" , "INV_MISC_QUESTIONMARK" , "CTRL-SHIFT-K" );
                macroSet = true;
                count = 0;
                count2 = count2 + 1;
                macroTxt = "";
                tempText = "";

            -- Macro IS full, and we are on the subsequent sets.
            elseif #tempText > 255 and count2 > 0 then
                count = 0;
                count2 = count2 + 1;
                macroTxt = "";
            end

        else
            i = i + 1;      -- Name was blacklisted, moving on.
        end

        if i > #entries then
            if not macroSet and #tempText > 0 then
                finalCount = #macroTxt;
                GRM.CreateMacro ( macroTxt , "GRM_Tool" , "INV_MISC_QUESTIONMARK" , "CTRL-SHIFT-K" );
            end
            count2 = count2 + 1;
            -- Finished!
        end
    end

    return result , count2 , finalCount;
end

-- Method:          GRM.PurgeMacrodNames()
-- What it Does:    Removes the names just macro'd from the list
-- Purpose:         Rebuild the macros ASAP!
GRM.PurgeMacrodNames = function()

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.MacroEntries do
        for j = #GRM_UI.GRM_ToolCoreFrame.QueuedEntries , 1 , -1 do
            if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][1] == GRM_UI.GRM_ToolCoreFrame.QueuedEntries[j][1] then
                table.remove ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries , j );
                break;
            end
        end
    end

end

-- Method:          GRM.SetKickMacrodValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Quality of life feature.
GRM.SetKickMacrodValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind];

    -- Player Name
    line[2]:SetText ( GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2][1] );
    line[2]:SetTextColor ( GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2][2][1] , GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2][2][2] , GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2][2][3] , 1 );
    line[3]:SetText ( GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2][3] );

    if GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2][11] then
        line[1]:LockHighlight();
    else
        line[1]:UnlockHighlight();
    end

    -- Update the tooltip if underlying data changes
    if GameTooltip:IsVisible() and GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1]:IsMouseOver() then 
        GRM.UpdateMacrodTooltip ( ind );
    end
end

-- Method:          GRM.KickMacrodHybridShiftDown()
-- What it Does:    Shifts all the values DOWN one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.KickMacrodHybridShiftDown = function()
    if #GRM_UI.GRM_ToolCoreFrame.MacroEntries > 13 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons;
        local MouseOverButton = 0;
        local name = "";

        -- Shift them down...
        for i = 1 , #buttons - 1 do
            name = buttons[i+1][2]:GetText();
            -- Header Line
            buttons[i][2]:SetText( name );
            buttons[i][2]:SetTextColor ( buttons[i+1][2]:GetTextColor ( buttons[i+1][2]:GetText() ) );
            buttons[i][3]:SetText( buttons[i+1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i+1][3]:GetTextColor ( buttons[i+1][3]:GetText() ) );

            for k = 1 , #GRM_UI.GRM_ToolCoreFrame.MacroEntries do
                if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k][1] == name then
                    if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k][11] then
                        buttons[i][1]:LockHighlight();
                    else
                        buttons[i][1]:UnlockHighlight();
                    end
                    break;
                end
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.KickMacrodSetLastValue();
        if MouseOverButton > 0 then
            GRM.UpdateMacrodTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.KickMacrodHybridShiftUp()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.KickMacrodHybridShiftUp = function()
    if #GRM_UI.GRM_ToolCoreFrame.MacroEntries > 13 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons;
        local MouseOverButton = 0;
        local name = "";

        for i = #buttons , 2 , -1 do
            name = buttons[i-1][2]:GetText();

            buttons[i][2]:SetText( name );
            buttons[i][2]:SetTextColor ( buttons[i-1][2]:GetTextColor ( buttons[i-1][2]:GetText() ) );
            buttons[i][3]:SetText( buttons[i-1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i-1][3]:GetTextColor ( buttons[i-1][3]:GetText() ) );

            for k = 1 , #GRM_UI.GRM_ToolCoreFrame.MacroEntries do
                if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k][1] == name then
                    if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k][11] then
                        buttons[i][1]:LockHighlight();
                    else
                        buttons[i][1]:UnlockHighlight();
                    end
                    break;
                end
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.KickMacrodSetFirstValue();
        if MouseOverButton > 0 then
            GRM.UpdateMacrodTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.KickMacrodSetLastValue()
-- What it Does:    Sets the last value of the hybridscrollframe backups at position 16
-- Purpose:         Clean scrolling
GRM.KickMacrodSetLastValue = function()
    GRM.SetKickMacrodValues ( #GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset );
end

-- Method:          GRM.KickMacrodSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe backups at position 1
-- Purpose:         Clean scrolling
GRM.KickMacrodSetFirstValue = function()
    GRM.SetKickMacrodValues ( 1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset - #GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons + 1 );
end

-- Method:          GRM.UpdateMacrodTooltip()
-- What it Does:    Sets the tooltip for the Macrod scrollframe in the GRM kick tool
-- Purpose:         Make it clear the QoL controls.
GRM.UpdateMacrodTooltip = function ( ind )
    local playerName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][2]:GetText();

    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1] , "ANCHOR_CURSOR" );
    GameTooltip:AddLine ( playerName , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][2]:GetTextColor() );

    GameTooltip:AddLine ( " " );    -- adds a small space between the lines
    GameTooltip:AddLine ( GRM.L ( "|CFFE6CC7FClick|r to Select for Removal" ) );
    GameTooltip:AddLine ( GRM.L ( "|CFFE6CC7FCtrl-Click|r to open Player Window" ) );
    GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FCtrl-Shift-Click|r to Search the Log for Player" ) );
    GameTooltip:Show();
end

-- Method:          GRM.TriggerKickMacrodWindowRefresh()
-- What it Does:    Refreshes the GRM Kick Tool's Macrod window after hiding the tooltip
-- Purpose:         Prevent code bloat for something with repeated use.
GRM.TriggerKickMacrodWindowRefresh = function()
    GRM_UI.RestoreTooltipScale();
    GameTooltip:Hide();
    GRM.BuildMacrodScrollFrame ( true , true );
    GRM_UI.RefreshToolButtonsOnUpdate();
end

-- Method:          GRM.RemoveNamesFromMacroEntries()
-- what it Does:    Cleans up the macro as needed
-- Purpose:         UX features for easier use.
GRM.RemoveNamesFromMacroEntries = function ()
    for i = #GRM_UI.GRM_ToolCoreFrame.MacroEntries , 1 , - 1 do
        if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][11] then
            GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][11] = false;
            table.insert ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames , GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][1] );        -- Add the name to the blacklist
            table.remove ( GRM_UI.GRM_ToolCoreFrame.MacroEntries , i );
        end
    end
    -- need to remove from qued as well.
    GRM.BuildMacrodScrollFrame ( false , false );
end

-- Method:          GRM.BuildMacrodScrollFrame( bool , bool )
-- What it Does:    Updates the Macrod scrollframe as needed
-- Purpose:         UX of the GRM mass kick tool
GRM.BuildMacrodScrollFrame = function ( showAll , fullRefresh )
    local hybridScrollFrameButtonCount = 13;
    local buttonHeight = 25;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:GetWidth() - 5;
    local count = 0;
    local size = 0;

    GRM.ResetToolMacrodHighlights();
    
    if showAll and fullRefresh then
        GRM_UI.GRM_ToolCoreFrame.MacroEntries , count , size = GRM.GetMacroEntries();

    elseif not showAll and not fullRefresh then
        GRM_UI.GRM_ToolCoreFrame.MacroEntries , count , size = GRM.GetMacroEntries();

    elseif not fullRefresh then
        GRM.CreateMacro ( "" , "GRM_Tool" , "INV_MISC_QUESTIONMARK" , "CTRL-SHIFT-K" );    -- Clear the macro
    end


    GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons or {};
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset or ( hybridScrollFrameButtonCount );

    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset < hybridScrollFrameButtonCount then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset = hybridScrollFrameButtonCount;
    elseif GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset > hybridScrollFrameButtonCount and GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset > #GRM_UI.GRM_ToolCoreFrame.MacroEntries then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset = #GRM_UI.GRM_ToolCoreFrame.MacroEntries;
    end

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.MacroEntries do
        -- Build HybridScrollFrame Buttons
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[i] then

                local button = CreateFrame ( "Button" , "MacrodButton1_" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[i] = {
                    button ,
                    button:CreateFontString ( "MacrodString1_" .. i , "OVERLAY" , "GameFontWhiteTiny" ),
                    button:CreateFontString ( "MacrodString2_" .. i , "OVERLAY" , "GameFontNormalTiny" )
                };

                button = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[i][1];
                if i == 1 then
                    button:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame , "TOP" , 7 , 0 );
                else 
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                -- button:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );
                button:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
                GRM.BuildKickMacrodScrollButtons ( i  , false );
                
            end
        end

        if i >= ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset - hybridScrollFrameButtonCount + 1 ) and i <= GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset then
            GRM.SetKickMacrodValues ( i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset - hybridScrollFrameButtonCount ) , i );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset - hybridScrollFrameButtonCount )][1]:Show();
        end
        
        -- Slider Height is controlled by tallying how many of these are necessary
        scrollHeight = scrollHeight + buttonHeight;
    end

    -- Hide unused buttons...
    for i = #GRM_UI.GRM_ToolCoreFrame.MacroEntries + 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons do
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[i][1]:Hide();
    end

    GRM.SetHybridScrollFrameSliderParameters ( 
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder, 
        buttonWidth , buttonHeight , scrollHeight , #GRM_UI.GRM_ToolCoreFrame.MacroEntries , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons , 
        GRM.KickMacrodHybridShiftDown , GRM.KickMacrodHybridShiftUp , hybridScrollFrameButtonCount
    );
    
    if #GRM_UI.GRM_ToolCoreFrame.MacroEntries > 13 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:Show();
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:Hide();
    end

    -- Macro text
    if #GRM_UI.GRM_ToolCoreFrame.MacroEntries > 0 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3:SetText ( GRM.L ( "Macro Size: {num}/255" , nil , nil , size ) );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3:Show();
        if count == 1 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7:SetText ( GRM.L ( "Press the Hot-key 1 time to complete all actions" ) );
        elseif count > 1 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7:SetText ( GRM.L ( "Press the Hot-key {num} times to complete all actions" , nil , nil , count ) );
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7:Show();
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText3:Hide();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCoreFrameText7:Hide();
    end

    -- Permissions Text
    GRM_UI.RefreshToolPermissionReport();
    GRM.SetMacroButtonText();

end

-- Method:          GRM.ResetToolMacrodHighlights()
-- What it Does:    Unlocks all the highlights
-- Purpose:         GRM special tool UX
GRM.ResetToolMacrodHighlights = function()
    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons ~= nil then
        for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons do
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[i][1]:UnlockHighlight();
        end
    end

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.MacroEntries do
        GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][11] = false;
    end
end

-- Method:          GRM.BuildKickMacrodScrollButtons ( int , boolean )
-- What it Does:    Initiates the buttons and their values for each line of the Macrod window of the GRM kick tool's hybridscrollframe
-- Purpose:         Create a smooth scrolling experience in the GRM kick window
GRM.BuildKickMacrodScrollButtons = function ( ind , isResizeAction )
    local coreButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][2];
    local buttonText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][3];

    -- Name
    buttonText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Actions don't need to be run more than once.
    if not isResizeAction then

        buttonText1:SetPoint ( "LEFT" , coreButton , "LEFT" , 5 , 0 );
        buttonText1:SetJustifyH ( "LEFT" );
        buttonText1:SetWidth ( 146 )
        buttonText1:SetWordWrap ( false );

        buttonText2:SetPoint ( "LEFT" , buttonText1 , "RIGHT" , 5 , 0 );
        buttonText2:SetJustifyH ( "LEFT" );
        buttonText2:SetWidth ( 191 );
        buttonText2:SetWordWrap ( false );

        coreButton:EnableMouse ( true );
        coreButton:RegisterForDrag ( "LeftButton" );

        -- Setup draggable conditions
        coreButton:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_ToolCoreFrame:StartMoving();
        end);
        coreButton:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_ToolCoreFrame:StopMovingOrSizing();
            GRM_UI.SaveToolPosition();
        end);

        coreButton:SetScript ( "OnMouseDown" , function ( _ , button )
            local playerName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][2]:GetText();
            if button == "LeftButton" then
                if IsShiftKeyDown() and IsControlKeyDown() then
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                    -- If Core GRM window is not open, let's open it!
                    if not GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                        GRM_UI.GRM_RosterChangeLogFrame:Show();
                    end
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogTab:Click();
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame.GRM_LogEditBox:SetText( GRM.SlimName ( playerName ) );
                elseif IsControlKeyDown() then
                    GRM.OpenPlayerWindow( playerName );
                else

                    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.MacroEntries do
                        if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][1] == playerName then

                            if not GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][11] then
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1]:LockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][11] = true;
                            else
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1]:UnlockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.MacroEntries[i][11] = false;
                            end
                            GRM.SetMacroButtonText();

                            break;
                        end
                    end

                end
            end
        end);            

        coreButton:SetScript ( "OnEnter" , function ()
            GRM.UpdateMacrodTooltip( ind );

            if #GRM_UI.GRM_ToolCoreFrame.MacroEntries > 13 and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:IsVisible() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:Show();
            end

        end);

        coreButton:SetScript ( "OnLeave" , function()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
            if not GRM.IsMouseStillOverAnyButton ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons ) then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrameSilder:Hide();
            end
        end);

    end
end

-------------------------
-- Ignored List Window --
-------------------------

-- Method:          GRM.IsAnyIgnoredHighlighted()
-- What it Does:    It scans through the Ignored List and reports true if any are selected and the number of selected
-- Purpose:         To adjust the text statement of the button.
GRM.IsAnyIgnoredHighlighted = function()
    local result = false;
    local count = 0;

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][3] then
            count = count + 1;
            result = true;
        end
    end

    return result , count;
end

-- Method:          GRM.SetIgnoredButtonText()
-- What it Does:    Determines which text messages needs to be set to the Clear Ignored Text
-- Purpose:         UX quality of life.
GRM.SetIgnoredButtonText = function()
    local result , count = GRM.IsAnyIgnoredHighlighted();
    if result then
        if count > 1 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetText ( GRM.L ( "Click to remove selected names from Ignore List" ) );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetText ( GRM.L ( "Click to remove selected name from Ignore List" ) );
        end
    else
        if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries == 0 then
            -- there ARE players on the safe list, but they are currently being filtered out to only show those with active actions being filtered.
            local c = #( select ( 2 , GRM.GetSafePlayers ( true ) ) );
            if c > 0 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].ignoreFilter then
                if c > 1 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetText ( GRM.L ( "No players to select. {num} players filtered" , nil , nil , c ) );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetText ( GRM.L ( "No players to select. 1 player filtered" ) );
                end
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetText ( GRM.L ( "No players on Ignore List" ) );
            end
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetText ( GRM.L ( "No names selected to remove from Ignore List" ) );
        end
    end

    -- Count Visible
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText4:SetText( GRM.L ( "Ignored Players: {num}" , nil , nil , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries ) );
end

-- Method:          GRM.ResetIgnoredHighlights()
-- What it Does:    Unlocks all the highlights
-- Purpose:         GRM special tool UX
GRM.ResetIgnoredHighlights = function()
    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons ~= nil then
        for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons do
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i][1]:UnlockHighlight();
        end
    end

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][3] = false;
    end
end

-- Method:          GRM.GetIgnoredEntries ( bool )
-- What it Does:    Determines which grouping to import
-- Purpose:         Proper sorting of players in the guild to be added to the GRM Tool
GRM.GetIgnoredEntries = function ()
    local result = {};
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].ignoreFilter then
        result = GRM.GetOnlySafePlayersWithIgnoredAction();
    else
        result = select ( 2 , GRM.GetSafePlayers ( true ) );
        
        -- Now, see if we need to add a reason.
        for i = 1 , #GRM_UI.GRM_ToolCoreFrame.Safe do
            for j = 1 , #result do
                if result[j][1] == GRM_UI.GRM_ToolCoreFrame.Safe[i][1] then
                    result[j][4] = GRM_UI.GRM_ToolCoreFrame.Safe[i][4];
                    break;
                end
            end
        end
    end   

    return result;
end

-- Method:          GRM.RemoveHighlightedPlayersFromIgnoredList()
-- What it Does:    Removes the highlights from the selected names, and sets them to no longer be ignored, and then rebuilds teh frames with that data.
-- Purpose:         Ability to manage ignore list in mass.
GRM.RemoveHighlightedPlayersFromIgnoredList = function ()
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local player;

    -- We need to scan and find all the entries, then find them in the guild
    for i = #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries , 1 , -1 do

        -- First check if it is highlighted
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][3] then

            -- Now scan through the roster and update.
            player = guildData[ GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][1] ];
            if player ~= nil then
                player.safeList = false;
                table.remove ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries , i );

                -- Rebuild the mouseover frame in case it is open
                if GRM_G.currentName == player.name and GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
                    GRM.PopulateMemberDetails ( GRM_G.currentName );
                end
            end
        end
    end

    -- Unlock the highlights now.
    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons ~= nil then
        for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons do
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i][1]:UnlockHighlight();
        end
    end

    GRM.TriggerKickQueuedWindowRefresh();
    GRM.TriggerIgnoredQueuedWindowRefresh();
    GRM.SetIgnoredButtonText();
end

-- Method:          GRM.ClearAllPlayersFromIgnoreList()
-- What it Does:    Removes all players from the ignore list
-- Purpose:         Ease of allowing the player to easily remove all from the ignore list.
GRM.ClearAllPlayersFromIgnoreList = function()
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local count = 0;

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.safeList then
                player.safeList = false;
                count = count + 1;
            end
        end
    end

    if count > 0 then
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons ~= nil then
            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons do
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i][1]:UnlockHighlight();
            end
        end

        GRM.TriggerKickQueuedWindowRefresh();
        GRM.TriggerIgnoredQueuedWindowRefresh();
        GRM.SetIgnoredButtonText();

        if count == 1 then
            GRM.Report ( GRM.L ( "{num} player was removed from Ignore List" , nil , nil , "1" ) );
        else
            GRM.Report ( GRM.L ( "{num} players removed from the Ignored List" , nil , nil , count ) );
        end
        
        if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
            GRM_UI.GRM_MemberDetailMetaData.GRM_SafeFromRulesCheckButton:SetChecked ( false );
        end
    end
end

-- Method:          GRM.GetNumIgnored()
-- What it Does:    Returns the count of total ignored people
-- Purpose:         To determine the number ignored for UI purposes.
GRM.GetNumIgnored = function()
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local count = 0;

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.safeList then
                count = count + 1;
            end
        end
    end

    return count;
end

-- Method:          GRM.IsAnyIgnored()
-- What it Does:    Returns true if at least one can be ignored - easy check rather than relying on a full count
-- Purpose:         UX
GRM.IsAnyIgnored = function()
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local result = false;

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.safeList then
                result = true;
                break;
            end
        end
    end

    return result;
end

-- Method:          GRM.GetOnlySafePlayersWithIgnoredAction()
-- What it Does:    Returns the list of players in a proper format for compatibility
-- Purpose:         Transition these useful lists to the ignored window frames, more for programming ease.
GRM.GetOnlySafePlayersWithIgnoredAction = function ()
    local result = {};
    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.Safe do
        table.insert ( result , { GRM_UI.GRM_ToolCoreFrame.Safe[i][1] , GRM_UI.GRM_ToolCoreFrame.Safe[i][3] , false , GRM_UI.GRM_ToolCoreFrame.Safe[i][4] } );
    end
    return result;
end

-- Method:          GRM.SetIgnoredValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Quality of life feature.
GRM.SetIgnoredValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind];
    local colors = GRM.GetClassColorRGB ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2][2] )
    -- Player Name
    line[2]:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2][1] );
    line[2]:SetTextColor ( colors[1] , colors[2] , colors[3] , 1 );
    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2][4] > 0 then
        line[3]:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2][4] );
        line[3]:SetTextColor ( 1.0 , 0.84 , 0 , 1 );
    else
        line[3]:SetText ( "None" );
        line[3]:SetTextColor ( 0 , 0.77 , 0.063 , 1 );
    end

    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2][3] then
        line[1]:LockHighlight();
    else
        line[1]:UnlockHighlight();
    end

    -- Update the tooltip if underlying data changes
    if GameTooltip:IsVisible() and GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][1]:IsMouseOver() then 
        GRM.UpdateIgnoredToolTip ( ind );
    end
end

-- Method:          GRM.IgnoredHybridShiftDown()
-- What it Does:    Shifts all the values DOWN one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.IgnoredHybridShiftDown = function()
    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries > 12 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons;
        local MouseOverButton = 0;
        local name = "";

        -- Shift them down...
        for i = 1 , #buttons - 1 do
            name = buttons[i+1][2]:GetText();

            -- Header Line
            buttons[i][2]:SetText( name );
            buttons[i][2]:SetTextColor ( buttons[i+1][2]:GetTextColor ( buttons[i+1][3]:GetText() ) );
            buttons[i][3]:SetText( buttons[i+1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i+1][3]:GetTextColor ( buttons[i+1][3]:GetText() ) );

            for k = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k][1] == name then
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k][3] then
                        buttons[i][1]:LockHighlight();
                    else
                        buttons[i][1]:UnlockHighlight();
                    end
                    break;
                end
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.IgnoredSetLastValue();
        if MouseOverButton > 0 then
            GRM.UpdateIgnoredToolTip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.IgnoredHybridShiftUp()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.IgnoredHybridShiftUp = function()
    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries > 12 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons;
        local MouseOverButton = 0;
        local name = "";

        for i = #buttons , 2 , -1 do
            name = buttons[i-1][2]:GetText();

            buttons[i][2]:SetText( buttons[i-1][2]:GetText() );
            buttons[i][2]:SetTextColor ( buttons[i-1][2]:GetTextColor ( buttons[i-1][2]:GetText() ) );
            buttons[i][3]:SetText( buttons[i-1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i-1][3]:GetTextColor ( buttons[i-1][3]:GetText() ) );

            for k = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k][1] == name then
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k][3] then
                        buttons[i][1]:LockHighlight();
                    else
                        buttons[i][1]:UnlockHighlight();
                    end
                    break;
                end
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.IgnoredSetFirstValue();
        if MouseOverButton > 0 then
            GRM.UpdateIgnoredToolTip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.IgnoredSetLastValue()
-- What it Does:    Sets the last value of the hybridscrollframe
-- Purpose:         Clean scrolling
GRM.IgnoredSetLastValue = function()
    GRM.SetIgnoredValues ( #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset );
end

-- Method:          GRM.IgnoredSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe
-- Purpose:         Clean scrolling
GRM.IgnoredSetFirstValue = function()
    GRM.SetIgnoredValues ( 1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset - #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons + 1 );
end

-- Method:          GRM.UpdateQueuedTooltip()
-- What it Does:    Sets the tooltip for the Queued scrollframe in the GRM kick tool
-- Purpose:         Make it clear the QoL controls.
GRM.UpdateIgnoredToolTip = function ( ind )

    local playerName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][2]:GetText();
    local reason = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][3]:GetText();
    local lastOnline = "";
    local atLeastOne = false;
    local rankRestrictText = "";
    local index;

    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][1] , "ANCHOR_CURSOR" );
    GameTooltip:AddLine ( playerName , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][2]:GetTextColor() );

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][1] == playerName then
            index = i;
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][6] ~= nil and GRM_G.playerRankID >= GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][6] then
                rankRestrictText = GRM.GetReasonIgnoredMsg ( GRM_G.playerRankID , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][6] );
            end
            break;
        end
    end

    if string.find ( reason , GRM.L ( "Kick" ) , 1 , true ) then
        atLeastOne = true;
        
        if index ~= nil then
            lastOnline = GRM.HoursReport ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[index][5] );
            GameTooltip:AddLine ( GRM.L ( "Last Online" ) );
            GameTooltip:AddLine ( lastOnline , 1 , 1 , 1 );
        end
    end

    if string.find ( reason , GRM.L ( "Promote" ) , 1 , true ) then
        atLeastOne = true;
    end

    if string.find ( reason , GRM.L ( "Demote" ) , 1 , true ) then
        atLeastOne = true;
    end

    if not atLeastOne then
        GameTooltip:AddLine ( GRM.L ( "Action" ) );
        GameTooltip:AddLine ( GRM.L ( "None" ) , 0 , 0.77 , 0.063 );
    end

    if rankRestrictText ~= "" then
        GameTooltip:AddLine ( rankRestrictText , 1 , 0 , 0 );
    end
    
    GameTooltip:AddLine ( " " );    -- adds a small space between the lines
    GameTooltip:AddLine ( GRM.L ( "|CFFE6CC7FClick|r to Select for Removal" ) );
    GameTooltip:AddLine ( GRM.L ( "|CFFE6CC7FCtrl-Click|r to open Player Window" ) );
    GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FCtrl-Shift-Click|r to Search the Log for Player" ) );
    GameTooltip:Show();

end

-- Method:          GRM.TriggerIgnoredQueuedWindowRefresh()
-- What it Does:    Refreshes the GRM Tool's Ignored window after hiding the tooltip
-- Purpose:         Prevent code bloat for something with repeated use.
GRM.TriggerIgnoredQueuedWindowRefresh = function()
    GRM_UI.RestoreTooltipScale();
    GameTooltip:Hide();
    
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].ignoreFilter then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:SetChecked( true );
    end        

    GRM.BuildIgnoredScrollFrame ( true , true );
    GRM.SetIgnoredButtonText();
    GRM_UI.RefreshToolButtonsOnUpdate();
end

-- Method:          GRM.BuildIgnoredScrollFrame( bool , bool )
-- What it Does:    Updates the Ignored scrollframe as needed
-- Purpose:         UX of the GRM mass kick tool
GRM.BuildIgnoredScrollFrame = function ( showAll , fullRefresh )
    local hybridScrollFrameButtonCount = 12;
    local buttonHeight = 25;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame:GetWidth() - 5;

    GRM.ResetIgnoredHighlights();

    if showAll and fullRefresh then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries = GRM.GetIgnoredEntries ( true );
    end

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons or {};
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset or ( hybridScrollFrameButtonCount );

    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset < hybridScrollFrameButtonCount then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset = hybridScrollFrameButtonCount;
    elseif GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset > hybridScrollFrameButtonCount and GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset > #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset = #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries;
    end

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
        -- Build HybridScrollFrame Buttons
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i] then

                local button = CreateFrame ( "Button" , "IgnoredButton1_" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i] = {
                    button ,
                    button:CreateFontString ( "IgnoredString1_" .. i , "OVERLAY" , "GameFontWhiteTiny" ),
                    button:CreateFontString ( "IgnoredString2_" .. i , "OVERLAY" , "GameFontWhiteTiny" )
                };

                button = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i][1];
                if i == 1 then
                    button:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame , "TOP" , 7 , 0 );
                else 
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                button:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );
                GRM.BuildIgnoredScrollButtons ( i  , false );
                
            end
        end

        if i >= ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset - hybridScrollFrameButtonCount + 1 ) and i <= GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset then
            GRM.SetIgnoredValues ( i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset - hybridScrollFrameButtonCount ) , i );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.Offset - hybridScrollFrameButtonCount )][1]:Show();
        end
        
        -- Slider Height is controlled by tallying how many of these are necessary
        scrollHeight = scrollHeight + buttonHeight;
    end

    -- Hide unused buttons...
    for i = #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries + 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons do
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[i][1]:Hide();
    end

    GRM.SetHybridScrollFrameSliderParameters ( 
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder, 
        buttonWidth , buttonHeight , scrollHeight , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons , 
        GRM.IgnoredHybridShiftDown , GRM.IgnoredHybridShiftUp , hybridScrollFrameButtonCount
    );

    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries > 12 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:Show();
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrameSilder:Hide();
    end

end

-- Method:          GRM.BuildIgnoredScrollButtons ( int , boolean )
-- What it Does:    Initiates the buttons and their values for each line of the Ignored List window
-- Purpose:         Create a smooth scrolling experience in the GRM Ignored window
GRM.BuildIgnoredScrollButtons = function ( ind , isResizeAction )
    local coreButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][2];
    local buttonText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][3];

    -- Name
    buttonText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Actions don't need to be run more than once.
    if not isResizeAction then

        buttonText1:SetPoint ( "LEFT" , coreButton , "LEFT" , 5 , 0 );
        buttonText1:SetJustifyH ( "LEFT" );
        buttonText1:SetWidth ( 135 )
        buttonText1:SetWordWrap ( false );

        buttonText2:SetPoint ( "LEFT" , buttonText1 , "RIGHT" , 5 , 0 );
        buttonText2:SetJustifyH ( "CENTER" );
        buttonText2:SetWidth ( 101 )
        buttonText2:SetWordWrap ( false );

        coreButton:EnableMouse ( true );
        coreButton:RegisterForDrag ( "LeftButton" );

        -- Setup draggable conditions
        coreButton:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:StartMoving();
        end);
        coreButton:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:StopMovingOrSizing();
        end);

        coreButton:SetScript ( "OnMouseDown" , function ( _ , button )
            local playerName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][2]:GetText();
            if button == "LeftButton" then
                if IsShiftKeyDown() and IsControlKeyDown() then
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                    -- If Core GRM window is not open, let's open it!
                    if not GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                        GRM_UI.GRM_RosterChangeLogFrame:Show();
                    end
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogTab:Click();
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame.GRM_LogEditBox:SetText( GRM.SlimName ( playerName ) );
                elseif IsControlKeyDown() then
                    GRM.OpenPlayerWindow( playerName );
                else
                    -- Deal with the highlights!
                    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][1] == playerName then

                            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][3] then
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][1]:LockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][3] = true;
                            else
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][1]:UnlockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i][3] = false;
                            end
                            GRM.SetIgnoredButtonText();

                            break;
                        end
                    end

                end
            end
        end);            

        coreButton:SetScript ( "OnEnter" , function ()
            GRM.UpdateIgnoredToolTip( ind );
        end);

        coreButton:SetScript ( "OnLeave" , function()
            GRM_UI.RestoreTooltipScale();
            GameTooltip:Hide();
        end);
    end
end

-----------------------------------------------------------
-- EXTRA CONTROL FUNCTIONS IN RELATION TO THIS FEATURE ----
-----------------------------------------------------------
-- Note, they will be placed under the general GRM global

-- Method:          GRM.RefreshAllMacroToolFrames()
-- What it Does:    Triggers a refresh of ALL the hybridscrollframes and features of the GRM Macro tool
-- Purpose:         UX
GRM.RefreshAllMacroToolFrames = function()
    if GRM_UI.GRM_ToolCoreFrame:IsVisible() then
        GRM_UI.RefreshManagementTool();

        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
            GRM.TriggerIgnoredQueuedWindowRefresh();
        end
    end                    
end


-- Method:          GRM.GetSafePlayers()
-- What it Does:    Returns the number of players that are set to be ignored on the recommendations macro
-- Purpose:         It is good to know the count for visual reasons
GRM.GetSafePlayers = function( getCountAndPlayers )
    local count = 0;
    local names = {};
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];

        for _ , player in pairs ( guildData ) do
            if type ( player ) == "table" and player.safeList then

                count = count + 1;
                -- Default just gets the count - otherwise it returns the list of players as well.
                if getCountAndPlayers then
                    table.insert ( names , { player.name , player.class , false , "" , player.lastOnline , player.rankIndex } ); -- name,class,isHighlighted,Reason
                end
            end
        end
    return count , names;
end

-- GRM.AddOrEditRule = function ( rule , isAnEdit )

--     if isAnEdit then

--     else
--         for i = 1 , #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules do

--         end
--     end

-- end

-- GRM.CreateFilterRule = function ( toDoAction , filterType , tScale , value )
--     local action = { [ "kick" ] = 1 , [ "promote" ] = 2 , [ "demote" ] = 3 };
--     local typeOfFilter= { [ "time" ] = 1 , ["level"] = 2 , ["rank"] = 3 , ["class"] = 4 };
--     local timeScale = { [ "month" ] = 1 , [ "day" ] = 2 };
--     local rule = { action [ toDoAction ] };

--     -- Kick action
--     if rule[1] == 1 then

--         table.insert ( rule , typeOfFilter [ filterType ] );

--         if rule[2] == 1 then
--             GRM.AddKickRuleBasedOnTime()

--         elseif rule[2] == 2 then
--             GRM.AddKickRuleBasedOnLevel();

--         elseif rule[3] == 3 then
--             GRM.AddKickRuleBasedOnRank();

--         elseif rule[4] == 4 then
--             GRM.AddKickRuleBasedOnClass();


--         table.insert ( rule , timeScale [ tScale ] );
--         table.insert ( rule , value );

--         if GRM.CanRuleBeAdded ( rule ) then

--         end

--     -- Promote action
--     elseif rule[1] == 2 then

--     -- Demote action
--     elseif rule[1] == 3 then

--     end

-- end

-- -- Method:          GRM.CanRuleBeAdded ( array )
-- -- What it Does:    Determines if a rule already exists, or there is a contradictory rule
-- -- Purpose:         Need to allow player the flexibility to create their own custom rules without creating contradictory rules breaking the filter process
-- GRM.CanRuleBeAdded = function( rule )
--     local result = true;

--     for i = 1 , #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules do
--         -- First, determine if rule 1 matches up.
--     end

--     return result;
-- end

-- RULES!!!
-- Method:          GRM.GetNamesByFilterRules()
-- What it Does:    Gets the names of the guildies that apply to the given rules.
-- Purpose:         Give the ability a way to apply the rules.
GRM.GetNamesByFilterRules = function()
    local result = {};
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local tempDetails = {};
    local needsToSave = false;
    local saveControlCheck = false;
    local notAllKickRulesMet = false
    -- local notAllKickRulesMet , notAllPromoRulesMet, notAllDemoteRulesMet = false , false , false;
    GRM_UI.GRM_ToolCoreFrame.Safe = {};         -- Reset the list of names

    -- Escape if database hasn't fully loaded yet
    if not guildData then
        return result;
    end
    -- Ok, scan through every member of the guild and scan the rules.

    if #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules > 0 then             -- No Need to do all the work if no rule
        for _ , player in pairs ( guildData ) do
            if type ( player ) == "table" then
                -- No need to check the rules on the player if they are ranked higher than you...
                tempDetails = {};
                needsToSave = false;
                notAllKickRulesMet = false;
                -- notAllKickRulesMet , notAllPromoRulesMet, notAllDemoteRulesMet = false , false , false;
                local currentRule = 1;

                for j = 1 , #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules do
                
                    -- Kick rules
                    if CanGuildRemove() and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][1] == 1 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][5] and not notAllKickRulesMet  then
                        saveControlCheck = false;

                        needsToSave , saveControlCheck , notAllKickRulesMet , tempDetails = GRM.GetNamesFromKickRules ( j , player , needsToSave , saveControlCheck , notAllKickRulesMet , tempDetails );

                    -- Promote Rules
                    elseif CanGuildPromote() and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][1] == 2 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][4] then
                        saveControlCheck = false;



                        if needsToSave and not saveControlCheck then
                            needsToSave = false;
                        end
                    -- Demote Rules
                    elseif CanGuildDemote() and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][1] == 3 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][4] then
                        saveControlCheck = false;



                        if needsToSave and not saveControlCheck then
                            needsToSave = false;
                        end
                    end

                    -- Only add the name if necessary.
                    if needsToSave and ( j == #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules or GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j+1][1] > currentRule ) then
                        table.insert ( tempDetails , false );
                        table.insert ( result , tempDetails );        -- I need to do a clean copy
                    end
                    
                    -- If the rule changes this should be logged.
                    if  j + 1 <= #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j+1][1] > currentRule then
                        currentRule = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j+1][1];
                    end
                end
            end
        end
    end

    return result;
end


-- Method:          GRM.GetReasonIgnoredMsg ( int , int , int )
-- What it Does:    Returns the string reason an action cannot occur on the ignore list
-- Purpose:         To help the player understand why another player cannot be removed.
GRM.GetReasonIgnoredMsg = function ( myRank , targetRank )
    local result = "";

    if myRank >= targetRank then

        if myRank == targetRank then
            result = GRM.L ( "Same Rank" );
        elseif myRank > targetRank then
            result = GRM.L ( "Higher Rank" );
        end
    end

    return result;
end

-- Method:          GRM.GetNamesFromKickRules ( int , bool , bool , bool , array )
-- What it Does:    Gets the names that adhere to the given rules
-- Purpose:         UX
GRM.GetNamesFromKickRules = function( j , player , needsToSave , saveControlCheck , notAllKickRulesMet , tempDetails )

    local ind = 0;
    local isFound = false;

    -- Returns true if the player has already been added
    -- Prevents double adding a player name
    local isPlayerAlreadyInList = function( textName )
        local result = false;
        local index = GRM.GenericPlayerQuery ( GRM_UI.GRM_ToolCoreFrame.Safe , textName )

        if index ~= nil then
            result = true;
        end

        return result , index;
    end

    -- The name formatting is purely to be used for the macro to be added.
    local name = "";
    if string.find ( player.name , GetRealmName() , 1 , true ) ~= nil then
        name = GRM.SlimName ( player.name );
    else
        name = player.name;
    end

    -- By Time
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][2] == 1 then
           
        if not GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].allAltsApplyToKick or ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].allAltsApplyToKick and not GRM.IsAnyAltActiveForRecommendKicks ( player.alts ) ) then
            -- if by Month
            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][3] == 1 then

                -- No need to do extra processing if not necessary.
                if GRM_G.NumberOfHoursTilRecommend == 0 then
                    GRM_G.NumberOfHoursTilRecommend = GRM.GetNumHoursTilRecommend ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] );
                end

                -- Error protection if it returns nil, meaning the server is not providing dates at this time.
                if GRM_G.NumberOfHoursTilRecommend == 0 then
                    return nil;
                end

                if player.lastOnline >= GRM_G.NumberOfHoursTilRecommend then
                    if GRM_G.playerRankID < player.rankIndex then
                        if not player.safeList then      -- Ignore for scanning... but I still want a count of the ignored.
                            needsToSave = true;
                            saveControlCheck = true;
                            tempDetails = { player.name , GRM.GetClassColorRGB ( player.class ) , "/gremove " .. name , GRM.L ( "Kick" ) , player.lastOnline , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][1] , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][2] , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][3] , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][4] , false };
                            -- { name , kickRule , ByTimeOffline , MonthCheck , MonthNumber }
                        else
                            isFound , ind = isPlayerAlreadyInList ( player.name );

                            if not isFound then
                                table.insert ( GRM_UI.GRM_ToolCoreFrame.Safe , { player.name , player.rankIndex , player.class , GRM.L ( "Kick" ) } );
                            else
                                GRM_UI.GRM_ToolCoreFrame.Safe[ind][4] = GRM_UI.GRM_ToolCoreFrame.Safe[ind][4] .. ", " .. GRM.L ( "Kick" );
                            end
                        end
                    end
                end

                -- if by Day
            elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][3] == 2 then
                if player.lastOnline >= GRM_G.NumberOfHoursTilRecommend then
                    if GRM_G.playerRankID < player.rankIndex then
                        if not player.safeList then
                            needsToSave = true;
                            saveControlCheck = true;
                            tempDetails = { player.name , GRM.GetClassColorRGB ( player.class ) , "/gremove " .. name , GRM.L ( "Kick" ) , player.lastOnline , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][1] , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][2] , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][3] , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][4] , false };
                            -- { name , kickRule , ByTimeOffline , DayCheck , DayNumber }
                        else
                            isFound , ind = isPlayerAlreadyInList ( player.name );

                            if not isFound then
                                table.insert ( GRM_UI.GRM_ToolCoreFrame.Safe , { player.name , player.rankIndex , player.class , GRM.L ( "Kick" ) } );
                            else
                                GRM_UI.GRM_ToolCoreFrame.Safe[ind][4] = GRM_UI.GRM_ToolCoreFrame.Safe[ind][4] .. ", " .. GRM.L ( "Kick" );
                            end
                        end
                    end
                end
            end
        end

    -- -- If by Level
    -- elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][2] == 2 then


    -- -- If by Rank
    -- elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[j][2] == 3 then


    end

    -- If the player matched a previous filter, but they did not match this filter, then needsToSave should be set to false as it doesn't match all filters...
    if needsToSave and not saveControlCheck then
        needsToSave = false;
        notAllKickRulesMet = true;
    end

    return needsToSave , saveControlCheck , notAllKickRulesMet , tempDetails;
end




------------------------
--- CUSTOM RULES -------
------------------------

GRM_UI.GRM_ToolCoreFrame.CustomRulesKickFrames = {};
GRM_UI.GRM_ToolCoreFrame.CustomRulesPromoteFrames = {};
GRM_UI.GRM_ToolCoreFrame.CustomRulesDemoteFrames = {};

-- Method:          GRM.GetKickRules()
-- What it Does:    Returns all the rules, as arrays, that are for kicking a player
-- Purpose:         Easier to manage and compartmentalize the rules.
GRM.GetKickRules = function()
    local kickRules = {};

    for i = 2 , #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules do
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[i][1] == 1 then
            table.insert ( kickRules , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[i] );
        end
    end

    return kickRules;
end

-- Method:          GRM.GetPromoteRules()
-- What it Does:    Returns all the rules, as arrays, that are for promoting a player
-- Purpose:         Easier to manage and compartmentalize the rules.
GRM.GetPromoteRules = function()
    local promoteRules = {};

    for i = 2 , #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules do
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[i][1] == 2 then
            table.insert ( promoteRules , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[i] );
        end
    end

    return promoteRules;
end

-- Method:          GRM.GetDemoteRules()
-- What it Does:    Returns all the rules, as arrays, that are for demoting a player
-- Purpose:         Easier to manage and compartmentalize the rules.
GRM.GetDemoteRules = function()
    local demoteRules = {};

    for i = 2 , #GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules do
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[i][1] == 3 then
            table.insert ( demoteRules , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[i] );
        end
    end

    return demoteRules;
end

-- Method:          GRM.BuildKickRules()
-- What it Does:    Builds the buttons/frames for the custom rules for kicking
-- Purpose:         Customizable UX
GRM.BuildKickRules = function()
    -- print("Building Kick Rules")
end

-- Method:          GRM.BuildKickRules()
-- What it Does:    Builds the buttons/frames for the custom rules for Promotions
-- Purpose:         Customizable UX
GRM.BuildPromoteRules = function()

end

-- Method:          GRM.BuildKickRules()
-- What it Does:    Builds the buttons/frames for the custom rules for Demotions
-- Purpose:         Customizable UX
GRM.BuildDemoteRules = function()

end

-- Method:          GRM.BuildCustomButtons( int )
-- What it Does:    Builds the
GRM.BuildCustomButtons = function( actionIndex )

    local rules = {};
    if actionIndex == 1 then
        rules = GRM.GetKickRules();
    elseif actionIndex == 2 then
        rules = GRM.GetPromoteRules();
    elseif actionIndex == 3 then
        rules = GRM.GetDemoteRules();
    end
    
    if actionIndex == 1 then
        if #rules > 0 then
            GRM.BuildKickRules();

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.CustomRulesKickFrames[#GRM_UI.GRM_ToolCoreFrame.CustomRulesKickFrames][1] , "BOTTOMLEFT" , 0 , -5 );

        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed , "BOTTOMLEFT" , 0 , -5 );

        end

    elseif actionIndex == 2 then
        if #rules > 0 then
            GRM.BuildPromoteRules();

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.CustomRulesPromoteFrames[#GRM_UI.GRM_ToolCoreFrame.CustomRulesPromoteFrames][1] , "BOTTOMLEFT" , 0 , -5 );

        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules , "TOPLEFT" , 0 , -5 );

        end
        

    elseif actionIndex == 3 then
        GRM.BuildDemoteRules();

        if #rules > 0 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.CustomRulesDemoteFrames[#GRM_UI.GRM_ToolCoreFrame.CustomRulesDemoteFrames][1] , "BOTTOMLEFT" , 0 , -5 );

        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_CustomRuleAddButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules , "TOPLEFT" , 0 , -5 );

        end
        
    end

    
end




-- Method:          GRM.SetNumHoursToKickValue()
-- What it Does:    Resets the numberOfHours value if player changes it, on the fly
-- Purpose:         UX
GRM.SetNumHoursToKickValue = function()
    -- General one-time configurations
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] == 1 then
        GRM_G.NumberOfHoursTilRecommend = GRM.GetNumHoursTilRecommend ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] );
    -- if by day
    elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][3] == 2 then
        GRM_G.NumberOfHoursTilRecommend = ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].kickRules[1][4] * 24 );
    end
end

-- Method:          GRM_UI.RefreshManagementTool( bool )
-- What it Does:    Refreshes the management tool
-- Purpose:         Compartmentalize the refresh details.
GRM_UI.RefreshManagementTool = function( isBanAltList )
    if not GRM_UI.GRM_ToolCoreFrame.IsInitialized then

        -- Check permissions - set tab as default one 
        if not CanGuildRemove() then
            if CanGuildPromote() then
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 2;
            elseif CanGuildDemote() then
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 3;
            end
        end

        GRM_UI.LoadToolFrames ( false );
    end
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames = {};  -- reset the blacklist.
    GRM.BuildQueuedScrollFrame ( true , true , isBanAltList );
    -- On reshow, always reset the macro
    GRM_UI.GRM_ToolCoreFrame.MacroEntries = {};
    GRM.BuildMacrodScrollFrame ( true , false );
    
    -- Load the options properly
    GRM_UI.LoadRulesUI();
    GRM_UI.RefreshToolButtonsOnUpdate();

    -- Populate the macro 
    if isBanAltList then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:Click();
    end

end

-- Method:          GRM_UI.RefreshToolButtonsOnUpdate()
-- What it Does:    For the "OnUpdate" script handler of the button to update the text as needed
-- Purpose:         Quality of life information so as not needed to open button, it is just visual.
GRM_UI.RefreshToolButtonsOnUpdate = function()
    local count = #GRM.GetNamesByFilterRules();

    if GRM_UI.GRM_LoadToolButton:IsVisible() then
        if count > 0 then
            GRM_UI.GRM_LoadToolButtonText:SetText ( GRM.L ( "Macro Tool: {num}" , nil , nil , count ) );
        else
            GRM_UI.GRM_LoadToolButtonText:SetText ( GRM.L ( "Macro Tool" ) );
        end
    end

    if GRM_UI.GRM_LoadToolOldRosterButton:IsVisible() then
        if count > 0 then
            GRM_UI.GRM_LoadToolOldRosterButtonText:SetText ( GRM.L ( "Macro Tool: {num}" , nil , nil , count ) );
        else
            GRM_UI.GRM_LoadToolOldRosterButtonText:SetText ( GRM.L ( "Macro Tool" ) );
        end
    end
end

-- Method:          GRM_UI.LoadRulesUI()
-- What it Does:    Rebuilds the options settings... for kick rules
-- Purpose:         UX easily on call, can be recalled with a rank change too.
GRM_UI.LoadRulesUI = function()

    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].allAltsApplyToKick then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolKickRules.GRM_ToolAltsOfflineTimed:SetChecked ( true );
    end
    
    GRM_UI.SetToolTabHighlights();
    -- Load which tab
end

GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnShow" , function ()
    GRM_UI.RefreshManagementTool( GRM_G.KickAltControl );
    GRM_G.KickAltControl = false;
end);


-- New tool - mass kick g7^X rank - and g8^{Arkaan,Chris}
-- Need to designate profiles SAFE from recommendations to kick
-- Safe ignore list window needs to be independent, but if called to load by slash command then it needs to bring up the GRM Tool AND the Safe window

------- RULE FORMAT

-- KICKING - First index = 1

    -- By Time - Second index = 1

        -- By Month
        -- { 1 , 1 , 1 , numMonths }

        -- By Day
        -- { 1 , 1 , 2 , numDays }

    -- By Level - Second index = 2

        -- Minimum Level
        -- { 1 , 2 , minLevel }

        -- Maximum Level
        -- { 1 , 2 , maxLevel }

    -- By Rank - Second index = 3

        -- Minimum Level
        -- { 1 , 3 , minRank }

        -- Maximum Level
        -- { 1 , 3 , maxRank }
    --
--

-- PROMOTING - First index = 2

-- DEMOTING - First index = 3

