
-- Tool to use GRM data to build pre-made macros based on certain filters to handle promotions/demotions/kicking of players. This is due to the fact that the API to do these actions was restricted in patch 7.3, effectively breaking many guild leadership and management addons. This is an attempt to help officers and Guild Leaders' lives out a little bit through creating quick rebuilding macros.

-- Globals

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
GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton = CreateFrame( "Button" , "GRM_ToolViewSafeListButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton = CreateFrame( "Button" , "GRM_ToolSyncRulesButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton.GRM_ToolSyncRulesButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

-- Macro Control Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton = CreateFrame( "Button" , "GRM_ToolClearSelectedMacrodNamesButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton = CreateFrame( "Button" , "GRM_ToolResetSelectedMacroNamesButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

-- Reset Settings
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton = CreateFrame( "Button" , "GRM_ToolResetSettingsButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

-- Core Ignore List Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton = CreateFrame( "Button" , "GRM_ToolIgnoreClearSelectionButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton = CreateFrame( "Button" , "GRM_ToolIgnoreResetSelectedNamesButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton = CreateFrame( "Button" , "GRM_ToolIgnoreRemoveAllButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

-- Optional spam control
GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton = CreateFrame ( "CheckButton" , "GRM_MacroToolDisableLogSpamCheckbutton" , GRM_UI.GRM_ToolCoreFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbuttonText = GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-- Online Cnly Control
GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton = CreateFrame ( "CheckButton" , "GRM_MacroToolShowOnlineOnlyCheckButton" , GRM_UI.GRM_ToolCoreFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-- Safe Details
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText4 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolCoreIgnoreCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_IgnoreListRuleTypeText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-- Tabs
GRM_UI.GRM_ToolCoreFrame.GRM_KickTab = CreateFrame ( "Button" , "GRM_KickTab" , GRM_UI.GRM_ToolCoreFrame , GRM_G.TabTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText = GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );
GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab = CreateFrame ( "Button" , "GRM_PromoTab" , GRM_UI.GRM_ToolCoreFrame , GRM_G.TabTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText = GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );
GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab = CreateFrame ( "Button" , "GRM_DemoteTab" , GRM_UI.GRM_ToolCoreFrame , GRM_G.TabTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText = GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );

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

-- Rules Scroll Frame
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_ToolRulesScrollFrame" , GRM_UI.GRM_ToolCoreFrame );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame = CreateFrame ( "Frame" , "GRM_ToolRulesScrollBorderFrame" , GRM_UI.GRM_ToolCoreFrame , "TranslucentFrameTemplate" );
-- CONTENT FRAME (Child Frame)
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame = CreateFrame ( "Frame" , "GRM_ToolRulesScrollChildFrame" );
-- SLIDER
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder = CreateFrame ( "Slider" , "GRM_ToolRulesScrollFrameSilder" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame , "UIPanelScrollBarTemplate" )
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:Hide();

-- Text
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText5 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText6 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText8 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText9 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickRulesText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" )
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameRankRestrictionText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickQueText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFramePromoteQueText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDemoteQueText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

----------------------
-- Custom Rules ------
----------------------

GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton = CreateFrame( "Button" , "GRM_CustomRuleAddButton" , GRM_UI.GRM_ToolCoreFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

-- Custom Rules Popup Frame
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame = CreateFrame ( "Frame" , "GRM_ToolCustomRulesFrame" , GRM_UI.GRM_ToolCoreFrame , "TranslucentFrameTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();

-- Rank Custom Rules
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1 = CreateFrame ( "CheckButton" , "GRM_ToolRulesRankRadialButton1" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2 = CreateFrame ( "CheckButton" , "GRM_ToolRulesRankRadialButton2" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );

GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-- Level Custom Rules
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesLevelRadialButton1" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2 = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesLevelRadialButton2" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" )
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox = CreateFrame( "EditBox" , "GRM_CustomRuleLevelStartEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:ClearFocus();
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox = CreateFrame( "EditBox" , "GRM_CustomRuleLevelStopEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:ClearFocus();

-- Class Custom Rules
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClassCheckBox = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesClassCheckBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClassCheckBoxText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesClassCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-- Custom Rules General Fontstrings
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );

GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox = CreateFrame( "EditBox" , "GRM_CustomRuleNameEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:ClearFocus();

-- Confirm and Cancel Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton = CreateFrame( "Button" , "GRM_ToolCustomRulesConfirmButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton = CreateFrame( "Button" , "GRM_ToolCustomRulesCancelButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIPanelButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesFrameCloseButton = CreateFrame( "Button" , "GRM_ToolCustomRulesFrameCloseButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIPanelCloseButton" );
-- Custom Rule Filters
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolRecommendKickCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox = CreateFrame( "EditBox" , "GRM_RosterKickRecommendEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearFocus();
-- Day or Month selection
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected = CreateFrame ( "Frame" , "GRM_TimeScaleSelected" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu = CreateFrame ( "Frame" , "GRM_TimeScaleDropDownMenu" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected = CreateFrame ( "Frame" , "GRM_GuildOrRankSelected" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhite" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu = CreateFrame ( "Frame" , "GRM_GuildOrRankdDropDownMenu" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:Hide();
-- Alts control filter
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed = CreateFrame ( "CheckButton" , "GRM_ToolAltsOfflineTimed" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-- Apply Rules to Control
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1 = CreateFrame ( "CheckButton" , "GRM_ApplyRulesRadioButton1" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2 = CreateFrame ( "CheckButton" , "GRM_ApplyRulesRadioButton2" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3 = CreateFrame ( "CheckButton" , "GRM_ApplyRulesRadioButton3" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:CreateFontString ( nil , "OVERLAY" , GRM_G.GameFontNormal );

-- Kick even if active filter
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton = CreateFrame ( "CheckButton" , "GRM_KickEvenIfActiveButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox = CreateFrame( "EditBox" , "GRM_KickEvenIfActiveEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:ClearFocus();
-- Day or Month selection even if active
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected = CreateFrame ( "Frame" , "GRM_KickEvenIfActiveTimeSelected" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu = CreateFrame ( "Frame" , "GRM_KickEvenIfActiveTimeMenu" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();

-- General use Right click button
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu = CreateFrame ( "Frame" , "GRM_ToolContextMenu" , GRM_UI.GRM_ToolCoreFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuDividerText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
-- Context Dropdown Buttons
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1 = CreateFrame ( "Button" , "GRM_ContextButton1" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1.GRM_ContextButton1Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2 = CreateFrame ( "Button" , "GRM_ContextButton2" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2.GRM_ContextButton2Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3 = CreateFrame ( "Button" , "GRM_ContextButton3" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3.GRM_ContextButton3Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton = CreateFrame ( "Button" , "GRM_ToolContextMenuCancelButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton.GRM_ToolContextMenuCancelButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

-- Custom Note pattern match
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolCompareStringCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolEmptyCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolPublicNoteCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolOfficerCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton = CreateFrame ( "CheckButton" , "GRM_ToolCustomCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox = CreateFrame( "EditBox" , "GRM_NoteSearchEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:ClearFocus();

-- Safe Text Note Match
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton = CreateFrame ( "CheckButton" , "GRM_SafeTextMatchButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox = CreateFrame( "EditBox" , "GRM_SafeTextSearchEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "InputBoxTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:ClearFocus();

-- Guild Reputation RULES
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton = CreateFrame ( "CheckButton" , "GRM_GuildRepRuleCheckButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonTextRetailOnlyText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
-- Operator Selection
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected = CreateFrame ( "Frame" , "GRM_GuildRepSymbolSelected" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu = CreateFrame ( "Frame" , "GRM_GuildRepSymbolDropDownMenu" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
-- Reputation Selection
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected = CreateFrame ( "Frame" , "GRM_GuildRepRanksSelected" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu = CreateFrame ( "Frame" , "GRM_GuildRepRanksDropDownMenu" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();

-- Log Custom Message
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton = CreateFrame ( "CheckButton" , "GRM_CustomLogMessageButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame = CreateFrame ( "Frame" , "GRM_CustomLogMessageEditBoxFrame" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox = CreateFrame( "EditBox" , "GRM_CustomLogMessageEditBox" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:ClearFocus();

-- PROMOTION/DEMOTION Specific
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1 = CreateFrame ( "CheckButton" , "GRM_ApplyRegardlessActivityRadialButton1" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2 = CreateFrame ( "CheckButton" , "GRM_ApplyRegardlessActivityRadialButton2" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "UIRadioButtonTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
-- Dropdown Rank Selection with line
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected = CreateFrame ( "Frame" , "GRM_DestinationRankSelected" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu = CreateFrame ( "Frame" , "GRM_DestinationRankDropdownMenu" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected , BackdropTemplateMixin and "BackdropTemplate" );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:Hide();
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-- Sync rule
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton = CreateFrame ( "CheckButton" , "GRM_ToolSyncButton" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

-----------------------------
--- END OF FRAME CREATION ---
-----------------------------

-- Global Locals
local repOperators = { "<" , "=" , ">" };

GRM_G.countAction = { 0 , 0 , 0 };  -- time of kick, promote , demote last counts
GRM_G.counts = { 0 , 0 , 0 };       -- count values of each

-- INITIALIZING FRAME VALUES
GRM_UI.GRM_ToolCoreFrame:ClearAllPoints();
GRM_UI.GRM_ToolCoreFrame:SetPoint ( "CENTER" , UIParent );
GRM_UI.GRM_ToolCoreFrame:SetFrameStrata ( "MEDIUM" );
GRM_UI.GRM_ToolCoreFrame:SetSize ( 1200 , 515 );
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
GRM_UI.GRM_ToolCoreFrame.ValidatedNames = {};
GRM_UI.GRM_ToolCoreFrame.TabPosition = 1;           -- 1 = kick , 2 = promote , 3 = demote
GRM_UI.GRM_ToolCoreFrame.Timer = 0;
GRM_UI.GRM_ToolCoreFrame.Safe = {};                 -- List of safe people for whatever the reason.
GRM_UI.GRM_ToolCoreFrame.MacroSuccess = true;       -- For manually scanning roster when validating macro success

-- Mass Kick, Promote, and Demote tool
GRM_UI.ruleTypeEnum = { [1] = "kickRules" , [2] = "promoteRules" , [3] = "demoteRules" };
GRM_UI.ruleTypeEnum2 = { [1] = "kick" , [2] = "promote" , [3] = "demote" };
GRM_UI.ruleTypeEnum3 = { [1] = GRM.L ( "Kick" ) , [2] = GRM.L ( "Promote" ) , [3] = GRM.L ( "Demote" ) };

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

                    if GRM.IsRuleHighlighted() then
                        GRM_UI.RestoreTooltipScale();
                        GameTooltip:Hide();
                        GRM.ClearRuleHighlights();

                    elseif GRM.IsAnyMacroHighlighted() then
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
                    GRM_G.MacroInProgress = true;
                    if MacroFrame:IsVisible() then          -- this needs to be hidden or the script won't update the macros.a
                        MacroFrameCloseButton:Click();
                    end
                    GRM_G.HK = false;
                    GRM.PurgeMacrodNames();

                    GRM.GuildRoster();
                    if GRM_G.BuildVersion >= 30000 then
                        QueryGuildEventLog();
                    end
                    
                    -- Need to validate the names are update now...
                    if GRM.IsMacroActionComplete() then
                        
                        C_Timer.After ( 2 , function()
                            GRM.ValidateMacroRecordingSuccess ( false );
                        end);

                    end
                    
                    GRM.BuildQueuedScrollFrame ( true , false , false );
                    GRM.BuildMacrodScrollFrame ( true , true );
                    GRM_G.timeDelayValue = time(); -- resetting delay
                    

                    if not GRM_G.AuditWindowRefresh and GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                        GRM_G.AuditWindowRefresh = true;

                        -- Delay action
                        C_Timer.After ( 2 , function()
                            GRM.RefreshAuditFrames ( true , true );
                            GRM_G.AuditWindowRefresh = false;
                        end);
                    end
                end
                self.Timer = 0;
            end
        end);

        GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnHide" , function()
            -- Clear the macro!
            GRM.CreateMacro ( "" , "GRM_Tool" , "INV_MISC_QUESTIONMARK" , GRM_G.MacroHotKey );
            GRM_G.MacroInProgress = false;
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
            GRM.ScanRecommendationsList();
            
        end);

        -- Text
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "TOPLEFT" , 17 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1:SetWidth ( 146 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText2:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1 , "RIGHT" , 6 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText2:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText2:SetWidth ( 85 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText2:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "TOPRIGHT" , -10 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:SetJustifyH ( "RIGHT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:SetWidth ( 110 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "BOTTOMRIGHT" , -10 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3:Hide();

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "TOPLEFT" , 17 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4:SetWidth ( 146 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText5:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4 , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText5:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText5:SetWidth ( 101 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText5:SetWordWrap ( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText6:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "BOTTOMLEFT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText6:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText6:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "BOTTOM" , 0 , -20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:SetWidth ( 320 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:SetSpacing ( 1 )

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "TOPRIGHT" , 2 , -19 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetWidth ( 160 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetSpacing ( 1 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetTextColor ( 1 , 0 , 0 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText8:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "TOP" , 0 , 17 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText8:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText9:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "TOP" , 0 , 17 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText9:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOMLEFT" , -20 , -35 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText2:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOMRIGHT" , 18 , -35 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText2:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText , "BOTTOMLEFT" , 0 , -2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOMRIGHT" , 18 , -49 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickQueText:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , "TOP" , 0 , 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFramePromoteQueText:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab , "TOP" , 0 , 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDemoteQueText:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab , "TOP" , 0 , 2 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameRankRestrictionText:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton , "BOTTOM" , 0 , -12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameRankRestrictionText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameRankRestrictionText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame , "TOPLEFT" , 110 , -35 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions:SetWidth ( 150 );
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1:SetTextColor ( 0 , 0.77 , 0.063 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1 , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2:SetTextColor ( 0 , 0.77 , 0.063 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2 , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3:SetTextColor ( 0 , 0.77 , 0.063 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1 , "BOTTOM" , 0 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:SetTextColor ( 0.64 , 0.102 , 0.102 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:SetText ( "____________" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2 , "BOTTOM" , 0 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:SetTextColor ( 0.64 , 0.102 , 0.102 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:SetText ( "____________" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3 , "BOTTOM" , 0 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:SetWidth ( 150 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:SetTextColor ( 0.64 , 0.102 , 0.102 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:SetText ( "____________" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

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

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_IgnoreListRuleTypeText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "TOPLEFT" , 15 , -15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_IgnoreListRuleTypeText:SetTextColor ( 1 , 0 , 0 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame , "BOTTOMLEFT" , 13 , 13 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:SetScript ( "OnClick", function()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:GetChecked() then
                GRM.S().ignoreFilter = true;
                GRM.TriggerIgnoredQueuedWindowRefresh();
            else
                GRM.S().ignoreFilter = false;
                GRM.TriggerIgnoredQueuedWindowRefresh();
            end
            GRM.SyncSettings();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton:SetPoint ( "RIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbuttonText , "LEFT" , - 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbuttonText:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_ToolCoreFrame , "BOTTOMRIGHT" , -52 , 14 );
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton:SetScript ( "OnClick", function( self , button )
            if button == "LeftButton" then
                if self:GetChecked() then
                    GRM.S().disableMacroToolLogSpam = true;                 
                else
                    GRM.S().disableMacroToolLogSpam = false;
                end
                GRM.SyncSettings();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetPoint ( "RIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButtonText , "LEFT" , - 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButtonText:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameRankRestrictionText , "BOTTOM" , 0 , -15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetScript ( "OnClick", function( self , button )
            if button == "LeftButton" then

                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:IsVisible() then
                    if self:GetChecked() then
                        if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                            GRM.S().promoteOnlineOnly = true;
                        else
                            GRM.S().demoteOnlineOnly = true;
                        end
                    else
                        if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                            GRM.S().promoteOnlineOnly = false;
                        else
                            GRM.S().demoteOnlineOnly = false;
                        end
                    end

                    GRM_UI.FullMacroToolRefresh();
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                        GRM.TriggerIgnoredQueuedWindowRefresh();
                    end

                    GRM.SyncSettings();
                else
                    if self:GetChecked() then
                        self:SetChecked ( false );
                    else
                        self:SetChecked ( true );
                    end
                end
            end
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
                        if c > 0 and GRM.S().ignoreFilter then
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
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton , "BOTTOM" , 0 , -20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton:SetSize ( 110 , 75 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetWidth ( 95 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetSpacing ( 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton:SetScript ( "OnClick" , function ( _ , button )
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

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton:SetScript ( "OnEnter" , function( self )
            if not GRM.IsAnyIgnored() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "There are currently no players on the Ignore List" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        -- Sync button
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton:SetSize ( 50 , 30 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame , "BOTTOMLEFT" , 12 , 12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton.GRM_ToolSyncRulesButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                print("Pending Feature - Will prioritize soon - about 85% built" )
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton:SetScript ( "OnEnter" , function( self )
            GRM.BuildMacroSyncTooltip( self );
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);
        
        -- RULES
        GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton:SetSize ( 175 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                local validToOpen = true;

                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
                    GRM_UI.ConfigureCustomRuleKickFrame ( false , nil );  -- Creating a new rule
                    if not CanGuildRemove() then
                        validToOpen = false;
                        GRM.Report ( GRM.L ( "Unable to remove players from the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                    end

                elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    GRM_UI.ConfigureCustomRulePromoteFrame ( false , nil );  -- Creating a new rule
                    if not CanGuildPromote() then
                        validToOpen = false;
                        GRM.Report ( GRM.L ( "Unable to promote players within the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                    end
                    
                elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                    GRM_UI.ConfigureCustomRulePromoteFrame ( false , nil );  -- Creating a new rule
                    if not CanGuildDemote() then
                        validToOpen = false;
                        GRM.Report ( GRM.L ( "Unable to demote players within the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                    end

                end

                if validToOpen then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
                    GRM.ClearRuleHighlights();
                end
            end
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetSpacing ( 1 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetWidth ( 275 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetScript ( "OnClick", function()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.allAltsApplyToKick = true;
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.allAltsApplyToKick = false;
            end
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickRulesText:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3 , "BOTTOM" , -85 , -12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickRulesText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickRulesText:SetWidth ( 150 );

        -- Buttons
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "BOTTOM" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:SetSize ( 200 , 30 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetWidth ( 195 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetWordWrap ( true );
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton , "BOTTOM" , 0 , -4 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetSize ( 130 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetWordWrap ( true );
        GRM_UI.ScaleFontStringToObjectSize ( true , 130 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText , 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButton:SetScript ( "OnClick" , function( _ , button )
            if button == "LeftButton" then

                local resetSettings = function()
                    local index = 10;
                    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                        index = 11;
                    elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                        index = 12;
                    end
                    GRM.ResetDefaultSettings( index );
                end

                if IsShiftKeyDown() and IsControlKeyDown() then
                    resetSettings();
                else
                    GRM.SetConfirmationWindow ( resetSettings , GRM.L ( "Are you sure you want to reset all Macro Tool Rules and Settings?" ) .. "\n" .. GRM.L ( "This will also clear all of your saved rules." ) );
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
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "RIGHT" , 25 , 10 );
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

        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetWidth ( 105 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetWordWrap ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetSpacing ( 0.5 );

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
            GRM.RestoreTooltip();
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
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickRulesText , "BOTTOMLEFT" , 0 , -42 );
        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetSize ( 80 , 25 );
        GRM.TabResize ( GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , 80 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:SetScript ( "OnClick" , function ( self , button )
            if button == "LeftButton" and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:IsVisible() then
                local needsFullRefresh = false;
                if GRM_UI.GRM_ToolCoreFrame.TabPosition ~= 1 then
                    needsFullRefresh = true;
                end
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 1;                   -- Set Position
                self:LockHighlight();                                       -- Lock Highlight
                GRM_UI.ConfigureToolTab();
                -- Load Lock window
                if needsFullRefresh then
                    GRM_UI.FullMacroToolRefresh();
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                    GRM.TriggerIgnoredQueuedWindowRefresh();
                end
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
        GRM.TabResize ( GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab , 80 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:IsVisible() then
                local needsFullRefresh = false;
                if GRM_UI.GRM_ToolCoreFrame.TabPosition ~= 2 then
                    needsFullRefresh = true;
                end
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 2;                   -- Set Position
                GRM_UI.ConfigureToolTab();
                -- Load Lock window
                if needsFullRefresh then
                    GRM_UI.FullMacroToolRefresh();
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                    GRM.TriggerIgnoredQueuedWindowRefresh();
                end
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
        GRM.TabResize ( GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab , 80 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:SetScript ( "OnClick" , function ( self , button )
            if button == "LeftButton" and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:IsVisible() then
                local needsFullRefresh = false;
                if GRM_UI.GRM_ToolCoreFrame.TabPosition ~= 3 then
                    needsFullRefresh = true;
                end
                GRM_UI.GRM_ToolCoreFrame.TabPosition = 3;                   -- Set Position
                self:LockHighlight();                                       -- Lock Highlight
                GRM_UI.ConfigureToolTab();
                -- Load Lock window
                if needsFullRefresh then
                    GRM_UI.FullMacroToolRefresh();
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                    GRM.TriggerIgnoredQueuedWindowRefresh();
                end
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

        -- method:          GRM_UI.ConfigureToolTab()
        -- What it Does:    Locks the selected tab highlighted
        -- Purpose:         UX feature
        GRM_UI.ConfigureToolTab = function()
            if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
                -- Highlights
                GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:LockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:Hide();

            elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:LockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:Show();

                if GRM.S().promoteOnlineOnly then
                    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( false );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:Show();

            elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:LockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:UnlockHighlight();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:Show();

                if GRM.S().demoteOnlineOnly then
                    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( false );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:Show();

            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
        end
        
        -- Macro'd ScrollFrame
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame:SetSize ( 370 , 350 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "BOTTOMRIGHT" , 25 , 0 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:SetSize ( 352 , 326 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollBorderFrame , "BOTTOMLEFT" , 5 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:SetScrollChild ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollFrame:SetHitRectInsets ( 0 , -30 , 0 , 0 );
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
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame , "BOTTOMRIGHT" , 20 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame:SetHitRectInsets ( 1 , 50 , 1 , 1 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:SetSize ( 262 , 326 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollBorderFrame , "BOTTOMLEFT" , 5 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:SetScrollChild ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:SetHitRectInsets ( 0 , -30 , 0 , 0 );
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
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollFrame:SetHitRectInsets ( 0 , -30 , 0 , 0 );
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
        
        -- Rules Scroll Frame
        -- Ignored ScrollFrame
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:SetSize ( 305 , 200 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_KickTab , "BOTTOMLEFT" , 0 , -8 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame:SetSize ( 287 , 176 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame , "BOTTOMLEFT" , 5 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame:SetScrollChild ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame:SetHitRectInsets ( 0 , -30 , 0 , 0 );
        -- Slider Parameters
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:SetOrientation ( "VERTICAL" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:SetSize ( 20 , 155 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame , "TOPRIGHT" , 8.5 , -10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:SetValue ( 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:SetValueStep ( 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:SetStepsPerPage ( 12 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder.currentV = 0;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:SetScript ( "OnValueChanged" , function ( self , value )
            GRM.HybridScrollOnValueChangedConfig (
                self , value , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame , 
                8 , 22 , GRM.BuildRulesScrollFrame , GRM_UI.GRM_ToolCoreFrame.RuleEntries
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

        -- Context Menu Initializations
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:SetSize( 80 , 125 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:SetFrameStrata ( "FULLSCREEN_DIALOG" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu , 7 , -10 );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu , 7 , -25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1:SetSize ( 65 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1.GRM_ContextButton1Text:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1.GRM_ContextButton1Text:SetWidth ( 65 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1.GRM_ContextButton1Text:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1 , "BOTTOMLEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2:SetSize ( 65 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2.GRM_ContextButton2Text:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2.GRM_ContextButton2Text:SetWidth ( 65 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2.GRM_ContextButton2Text:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2 , "BOTTOMLEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3:SetSize ( 65 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3.GRM_ContextButton3Text:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3.GRM_ContextButton3Text:SetWidth ( 65 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3.GRM_ContextButton3Text:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuDividerText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton , "TOPLEFT" , 0 , 4 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuDividerText:SetText ("__");
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu , "BOTTOMLEFT" , 7 , 5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton:SetSize ( 65 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton.GRM_ToolContextMenuCancelButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton.GRM_ToolContextMenuCancelButtonText:SetWidth ( 65 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton.GRM_ToolContextMenuCancelButtonText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
                GRM.ClearRuleHighlights();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                GRM.ClearRuleHighlights();
                self:Hide();
            end
        end);


    end

    -- End of one-time load only, now need to be reloaded on any change of font, size, or language.
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 0 then
                if MacroFrame:IsVisible() then          -- this needs to be hidden or the script won't update the macros.a
                    MacroFrameCloseButton:Click();
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames = {};
                GRM.BuildMacrodScrollFrame ( true , true );
            else
                GRM.Report ( GRM.L ( "No Names to Add to the Macro" ) );
            end
        end
    end);

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1:SetText( GRM.L ( "Name:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText2:SetText( GRM.L ( "Macro:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:SetText( GRM.L ( "# Moves:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDestinationRankHeaderText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4:SetText( GRM.L ( "Name:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText4:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText5:SetText( GRM.L ( "Action" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText5:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText6:SetText( GRM.L ( "Hot Key: {name}" , GRM_G.MacroHotKey ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText6:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText8:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText8:SetText( GRM.L ( "Queued Actions" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText9:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText9:SetText( GRM.L ( "Current Actions" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameRankRestrictionText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameRankRestrictionText:SetText( GRM.L ( "Players the same rank or higher will not be shown" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:SetText ( GRM.L ( "Due to limitations with macros a player can only move 1 rank at a time." ))

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions:SetText ( GRM.L ( "Permissions" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1:SetText ( GRM.L ( "Kick" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2:SetText ( GRM.L ( "Promote" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3:SetText ( GRM.L ( "Demote" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Safe List Tool
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText1:SetText ( GRM.L ( "Name:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText2:SetText ( GRM.L ( "Ignored Action:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreFrameText3:SetText ( GRM.L ( "Ignored Players Safe From Action" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_IgnoreListRuleTypeText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButtonText:SetText ( GRM.L ( "Only show players with ignored action" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetText ( GRM.L ( "Clear Selection" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreResetSelectedNamesButton.GRM_ToolIgnoreResetSelectedNamesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreClearSelectionButton.GRM_ToolIgnoreClearSelectionButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoreRemoveAllButton.GRM_ToolIgnoreRemoveAllButtonText:SetText ( GRM.L ( "Remove all players from Ignore List" ) );

    -- Button Text
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    if #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 0 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetText( GRM.L ( "Click to Build Macro" ) );
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton.GRM_ToolBuildMacroButtonText:SetText( GRM.L ( "No Current Names to Add" ) );
    end
    GRM.SetMacroButtonText();

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetText ( GRM.L ( "Clear Selection" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton.GRM_ToolResetSelectedMacroNamesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolClearSelectedMacrodNamesButton.GRM_ToolClearSelectedMacrodNamesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton.GRM_ToolViewSafeListButtonText:SetText ( GRM.L ( "View Ignore List" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText:SetText ( GRM.L ( "Total Queued:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText:SetText ( GRM.L ( "Actions Ignored:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickQueText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFramePromoteQueText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDemoteQueText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Rules
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickRulesText:SetText ( GRM.L ( "Rules" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickRulesText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText );
    GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText:SetText ( GRM.L ( "Add Custom Rule" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton.GRM_ToolSyncRulesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolSyncRulesButton.GRM_ToolSyncRulesButtonText:SetText ( GRM.L ( "Sync" ) );

    -- Tabs
    GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_KickTabText:SetText ( GRM.L ( "Kick" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText:SetText ( GRM.L ( "Promote" ) );
    GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:GetWidth() , GRM_UI.GRM_ToolCoreFrame.GRM_PromoTabText , 3 );
    GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText:SetText ( GRM.L ( "Demote" ) );
    GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:GetWidth() , GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTabText , 3 );

    -- Settings Reset
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSettingsButtonText:SetText ( GRM.L ( "Restore Defaults" ) );

    -- Context Menu
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuDividerText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton.GRM_ToolContextMenuCancelButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuCancelButton.GRM_ToolContextMenuCancelButtonText:SetText ( GRM.L ( "Cancel" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ToolContextMenuText:SetText ( GRM.L ( "Options" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1.GRM_ContextButton1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2.GRM_ContextButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3.GRM_ContextButton3Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    
    ----------------------
    --- CUSTOM FILTERS ---
    ----------------------

    if not isManual then

        --------------- RULES FRAME -----------------
        -- Core Frame
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:ClearAllPoints();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetPoint ( "CENTER" , UIParent );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetSize ( 450 , 760 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetMovable ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetToplevel ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetFrameStrata ( "HIGH" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:RegisterForDrag ( "LeftButton" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetScript ( "OnDragStart" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.StartMoving );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetScript ( "OnDragStop" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.StopMovingOrSizing );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule = {};
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.isEdit = false;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal = "";
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        end);
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetScript ( "OnHide" , function()
            -- reset the rules
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule = {};
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.isEdit = false;
            GRM_UI.GRM_ToolCoreFrame.GRM_CustomRuleAddButton.GRM_CustomRuleAddButtonText:SetText ( GRM.L ( "Add Custom Rule" ) );
            GRM.ClearRuleHighlights();
        end);

        -- Close Button
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesFrameCloseButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOPRIGHT" , 0 , 0 );

        -- Title
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOPLEFT" , 15 , -15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetTextColor ( 1 , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOP" , 0 , -22 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetSize ( 250 , 30 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetTextInsets( 2 , 3 , 3 , 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetMaxLetters ( 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:EnableMouse( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetAutoFocus( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetTextColor ( 1 , 0.82 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetNumeric ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox.ruleNameText = "";

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change the Rule Name" ) );
            GameTooltip:Show();
        end);
    
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);        

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetScript ( "OnEscapePressed" , function ( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox.ruleNameText );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetScript ( "OnEnterPressed" , function ( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            self:SetText ( GRM.Trim ( self:GetText() ) );

            if self:GetText() == "" then
                GRM.Report ( GRM.L ( "Please Set a Name for this Rule. It can be 1 to 25 characters in length." ) );
            end

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox.ruleNameText = self:GetText();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name = self:GetText();
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
            GRM.RestoreTooltip();
        end);
        
        -- LEVEL RANGE
        -- Radial buttons
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetHitRectInsets ( 0 , -115 , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetHitRectInsets ( 0 , -150 , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1 , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2 , "RIGHT" , 2 , 0 );
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetScript ( "OnClick", function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked ( true );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0 , 0 ); 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelFilter = false;
            GRM_UI.DisableLevelSelectionEditBoxes();            
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetScript ( "OnClick", function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelFilter = true;
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( true );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0 , 0 ); 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.EnableLevelSelectionEditBoxes();            
        end);
        
        -- Edit Boxes
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text , "BOTTOMLEFT" , 0 , -10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText:SetTextColor ( 1 , 0.82 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetSize ( 50 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetNumeric ( true );
        if GRM_G.BuildVersion < 60000 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetMaxLetters ( 2 ); -- 60000+ is Warlords of Draenor on, where level cap could be > 100
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetMaxLetters ( 3 );
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetAutoFocus( false )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetTextInsets( 2 , 3 , 3 , 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:EnableMouse( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = "";
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetJustifyH ( "CENTER" );

        -- Divider
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox , "RIGHT" , 10 , 0 );
        -- Divider
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetSize ( 50 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelText , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetNumeric ( true );
        if GRM_G.BuildVersion < 60000 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetMaxLetters ( 2 ); -- 60000+ is Warlords of Draenor on, where level cap could be > 100
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetMaxLetters ( 3 );
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetAutoFocus( false )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetTextInsets( 2 , 3 , 3 , 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:EnableMouse( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = "";
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetJustifyH ( "CENTER" );
    
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetScript ( "OnEscapePressed" , function ( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetScript ( "OnEnterPressed" , function ( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            local number = tonumber ( GRM.Trim ( self:GetText() ) );
            if number == 0 then
                number = 1;
            end

            if number >= GRM_G.LvlCap then
                number = GRM_G.LvlCap;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = tostring ( GRM_G.LvlCap );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = tostring ( number );
            end
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[1] = number;

            -- need to Adjust the 2nd if necessary as well.
            local number2 = tonumber ( GRM.Trim ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:GetText() ) );

            if ( number == GRM_G.LvlCap and GRM_G.LvlCap > number2 ) or ( number2 ~= GRM_G.LvlCap and number > number2 ) then
                number2 = number;
                if number2 == GRM_G.LvlCap then
                    number2 = 999;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = tostring ( GRM_G.LvlCap );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = tostring ( number2 );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[2] = number2;
            end
            
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetScript ( "OnEscapePressed" , function ( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText );
            self:ClearFocus();
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetScript ( "OnEnterPressed" , function ( self )
            self:ClearFocus();
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            local number = tonumber ( GRM.Trim ( self:GetText() ) );
            if number == 0 then
                number = 1;
            end
        
            if number >= GRM_G.LvlCap then
                number = 999;           -- 999 is default for level cap so when expansion changes and level cap goes up, it auto floats the new filters to level cap again.
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = tostring ( GRM_G.LvlCap );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = tostring ( number );
            end
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[2] = number;
        
            -- need to Adjust the 2nd if necessary as well.
            local number2 = tonumber ( GRM.Trim ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:GetText() ) );
        
            if number < number2 then
                number2 = number;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = tostring ( number2 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[1] = number2;
            end
            
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetFocus();
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
        end);

        -- Confirm Button
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:SetSize ( 145 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "BOTTOM" , -20 , 15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then

                -- Set the values if cursor still focused
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:ClearFocus();
                end

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearFocus();
                end

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:ClearFocus();
                end

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:ClearFocus();
                end

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:ClearFocus();
                end

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:ClearFocus();
                end

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:ClearFocus();
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:HasFocus() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:ClearFocus();
                end

                -- This should be auto-disabled if it's an empty string
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeText == "" then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeMatch = false;
                end

                if GRM.IsRuleReady() then
                    -- Add or edit the new rule
                    if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.isEdit then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ruleIndex = GRM.GetRulesCount( GRM_UI.GRM_ToolCoreFrame.TabPosition ) + 1;
                    end

                    GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name] = GRM.DeepCopyArray ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule );

                    -- Configure editTime for sync purposes
                    GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name].editTime = time();

                    -- Set the GUID
                    GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name].GUID = GRM.GetMacroRuleGUID ( GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name] );

                    -- GRM_G.MacroRuleSyncFormat[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name] = {};
                    -- GRM_G.MacroRuleSyncFormat[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name].ruleString = GRM.ConvertMacroRuleToString ( GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name] , GRM_UI.GRM_ToolCoreFrame.TabPosition );
                    -- GRM_G.MacroRuleSyncFormat[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name].ruleIndex = GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name].ruleIndex;

                    -- Clear it from removed rules if it is there...
                    GRM.S().removedMacroRules[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name] = nil;

                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.isEdit then
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal ~= GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name then
                            -- It's an Edit and it has been renamed... In that case we are going to send a message to show it different name;
                        
                            -- First, add it to our own removedRules so it can be referenced to be removed against.
                            -- GRM.AddToRemovedRules ( GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition] , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal , GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal] , time() , nil );

                            -- Next, we now add the new rule
                            -- GRM.SendRuleRemove ( GRM_UI.GRM_ToolCoreFrame.TabPosition , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal , time() , GRM_G.addonUser , false );


                            GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal] = nil;
                            -- Configure the sync saved data as well
                            GRM_G.MacroRuleSyncFormat[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal] = nil;   -- removed the saved format here - no need to store it anymore.
                        end
                    end

                    if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 and GRM.S().macroSyncKickEnabled ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 and GRM.S().macroSyncPromoteEnabled ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and GRM.S().macroSyncDemoteEnabled ) then
                        -- GRM.SendRuleAdd ( GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition] , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name , GRM_G.MacroRuleSyncFormat[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name].ruleString , true );
                    end

                    
                        
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
                    GRM.RefreshNumberOfHoursTilRecommend();
                    GRM_UI.FullMacroToolRefresh();
                    GRM.SyncAddonSettings();
                end
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:SetSize ( 145 , 25 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "BOTTOM" , 20 , 15 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
            end
        end);

        -- Method:          SetRankNamesToCustomRuleCheckButtons()
        -- What it Does:    Sets all the custom rules checkbox to the rank names
        -- Purpose:         Keep rank names set properly.
        local SetRankNamesToCustomRuleCheckButtons = function()
            local numRanks = GuildControlGetNumRanks(); -- minus 1 because we are not including the guild leader
            local button , buttontext;

            for i = 1 , ( numRanks - 1 ) do
                button = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1];
                buttontext = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][2];

                if i <= ( numRanks - 1 ) then
                    buttontext:SetText ( GuildControlGetRankName ( numRanks + 1 - i ) );
                    buttontext:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
                    button:Show();
                else
                    button:Hide();
                end

            end
        end

        -- Initializes all checkboxes
        local BuildRankCheckBoxes = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes or {};
            local numRanks = GuildControlGetNumRanks() - 1;

            for i = 1 , numRanks do
                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i] then
                    local button = CreateFrame ( "CheckButton" , "GRM_ToolCustomRulesRank" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , GRM_G.CheckButtonTemplate );
                    local buttontext = button:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i] = { button , buttontext };

                    if i == 1 then
                        button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1 , "BOTTOMRIGHT" , 0 , -5 );
                    else
                        if i % 3 == 1 then
                            button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i - 3][1] , "BOTTOMLEFT" , 0 , -5 );
                        else
                            button:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i - 1][1] , "RIGHT" , 100 , 0 );
                        end
                    end
                    buttontext:SetPoint ( "LEFT" , button , "RIGHT" , 2 , 0 );
                    buttontext:SetWidth ( 95 );
                    buttontext:SetJustifyH ( "LEFT" )

                    button:SetScript ( "OnClick" , function ( self , button )
                        if button == "LeftButton" then
                            if self:GetChecked() then
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks[i] = true;
                            else
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks[i] = false;
                            end
                        end
                    end);

                end
            end

            -- Need to set the following button in the correct position
            if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes > 6 then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[7][1] , "BOTTOMLEFT" , 0 , -5 );
            elseif #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes > 3 then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[4][1] , "BOTTOMLEFT" , 0 , -5 );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[1][1] , "BOTTOMLEFT" , 0 , -5 );
            end

            SetRankNamesToCustomRuleCheckButtons();
        end

        -- Method:          GRM_UI.SetRankCustomRuleFilters()
        -- What it Does:    Applies the custom rules selected ranks
        -- Purpose:         Set the rules properly as they are used.
        GRM_UI.SetRankCustomRuleFilters = function()
            local numRanks = GuildControlGetNumRanks() - 1;
            if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes ~= numRanks then       -- If window was open at same time rank was removed, we can rebuild the frames
                BuildRankCheckBoxes();
            end

            for i = 1 , numRanks do
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks[i] ~= nil then
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks[i] then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetChecked ( true );
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetChecked ( false );
                    end
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks[i] = false;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetChecked ( false );
                end
            end
        end

        -- Method:          GRM_UI.SetDefaultRankFilters()
        -- What it Does:    Sets all the default rules to true and puts all the buttons as checked, even though they are disabled
        -- Purpose          Purely aesthetics and ease to manipulate if enabling buttons
        GRM_UI.SetDefaultRankFilters = function()
            local numRanks = GuildControlGetNumRanks() - 1;
            local playerIndex = GRM_UI.GetRankIndexDescendingOrder();
            if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes ~= numRanks then       -- If window was open at same time rank was removed, we can rebuild the frames
                BuildRankCheckBoxes();
            end

            -- Want to disable all ranks in promotion or demotion as in most cases you don't want it to apply to all players.
            local setRankEnabled = true;
            if GRM_UI.GRM_ToolCoreFrame.TabPosition > 1 then
                setRankEnabled = false;
            end

            for i = 1 , numRanks do
                
                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 and i >= playerIndex then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks[i] = false;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetChecked ( false );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks[i] = setRankEnabled;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetChecked ( setRankEnabled );
                end
            end
        end

        GRM_UI.EnableEvenIfActiveButton = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 1 , 0 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:EnableMouse ( true );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetTextColor ( 1 , 1 , 1 );
        end

        GRM_UI.DisableEvenIfActiveButton = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:EnableMouse ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyEvenIfActiive = false;
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetChecked ( false );
        end

        -- Method:              GRM_UI.EnableCustomSelectionOfRanks()
        -- What it Does:        Activates the checkboxes so individual ranks can be selected.
        -- Purpose:             Allow custom rank filtering.
        GRM_UI.EnableCustomSelectionOfRanks = function()
            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes do
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][2]:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter = true;
            end
            GRM_UI.ConfigureRankCheckBoxesPromoteAndDemote();
            if not GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.activityFilter then
                GRM_UI.EnableEvenIfActiveButton();
            end
        end

        -- What it Does:            Enables all Custom Rule Rank Checkboxes and greys them out.
        GRM_UI.DisableCustomSelectionRanks = function()
            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes do
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][2]:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter = false;
            end
            GRM_UI.DisableEvenIfActiveButton();
        end

        
        -- Method:          GRM_UI.DisableLevelSelectionEditBoxes()
        -- What it Does:    Disables editing of this feature in the controls
        -- Purpose:         Easier UX controls
        GRM_UI.DisableLevelSelectionEditBoxes = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelText:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText:SetTextColor ( 0.5 , 0.5 , 0.5 );
        end

        -- Method:          GRM_UI.EnableLevelSelectionEditBoxes()
        -- What it Does:    Enables editing of this feature in the controls
        -- Purpose:         Easier UX controls
        GRM_UI.EnableLevelSelectionEditBoxes = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetTextColor ( 1 , 1 , 1 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelText:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetTextColor ( 1 , 1 , 1 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText:SetTextColor ( 1 , 0.82 , 0 );
        end

        -- Method:              GRM_UI.EnableRankActivityFrames()
        -- What it Does:        Activates the rule frames as needed
        -- Purpose:             UI quality of life
        GRM_UI.EnableRankActivityFrames = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 1 , 0 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:EnableMouse ( true );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetTextColor ( 1 , 1 , 1 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 1 , 0.82 , 0 );

        end

        -- Method:              GRM_UI.DisableRankActivityFrames()
        -- What it Does:        Disabled certain rule frame UI features as needed
        -- Purpose:             UI quality of life
        GRM_UI.DisableRankActivityFrames = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:EnableMouse ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
        end

        -- Method:          GRM_UI.ConfigureRankCheckBoxesPromoteAndDemote()
        -- What it Does:    Configures the checkboxes UX experience to adapt over for promotions/demotions
        -- Purpose:         UX
        GRM_UI.ConfigureRankCheckBoxesPromoteAndDemote = function()
            local playerIndex = GRM_UI.GetRankIndexDescendingOrder();
            local rankCap
            if GRM_UI.GRM_ToolCoreFrame.TabPosition > 1 then
                rankCap = ( GuildControlGetNumRanks() - GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.destinationRank );
            end

            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes do

                if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 2  and i <= rankCap ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and i > rankCap + 1 ) then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:Enable();

                    if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 and i >= playerIndex ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 and i >= playerIndex - 1 ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and i >= playerIndex ) then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][2]:SetTextColor ( 1 , 0 , 0 );

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetScript ( "OnEnter" , function ( self )
                            GRM_UI.SetTooltipScale()
                            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                            if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
                                GameTooltip:AddLine( GRM.L ( "Unable to kick players at this rank" ) );
                            elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                                GameTooltip:AddLine( GRM.L ( "Unable to promote players at this rank." ) );
                            elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                                GameTooltip:AddLine( GRM.L ( "Unable to demote players from this rank." ) );
                            end
                            GameTooltip:Show();
                        end);
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetScript ( "OnLeave" , function()
                            GRM.RestoreTooltip();
                        end);
                        
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][2]:SetTextColor ( 1 , 0.82 , 0 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetScript ( "OnEnter" , nil );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetScript ( "OnLeave" , nil );
                    end
                else 
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][2]:SetTextColor ( 0.5 , 0.5 , 0.5 );

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetScript ( "OnEnter" , function ( self )
                        GRM_UI.SetTooltipScale()
                        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                        if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                            GameTooltip:AddLine( GRM.L ( "Unable to promote players at this rank to \"{name}\"" , GuildControlGetRankName ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.destinationRank ) ) );
                        elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                            GameTooltip:AddLine( GRM.L ( "Unable to demote players at this rank to \"{name}\"" , GuildControlGetRankName ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.destinationRank ) ) );
                        end
                        GameTooltip:Show();
                    end);
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.customRankCheckBoxes[i][1]:SetScript ( "OnLeave" , function()
                        GRM.RestoreTooltip();
                    end);

                end
            end
        end

        -- Method:          GRM_UI.ConfigureCustomRuleKickFrame ( bool , string , bool  )
        -- What it Does:    Configures the values of all the buttons on the custom rules creation window
        -- Purpose:         Keep rules settings displayed properly.
        GRM_UI.ConfigureCustomRuleKickFrame = function ( isEdit , ruleName , isCopy )

            local matchString = GRM.L ( "Click to Set" );
            local safeString2 = GRM.L ( "Click to Set" );

            -- Build Rank Filter
            BuildRankCheckBoxes();
            GRM_UI.ModifyRuleUI();

            if isEdit then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule = GRM.GetKickRule ( ruleName );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.createdBy = { GRM_G.addonUser , select ( 2 , UnitClass ("PLAYER") ) };

                -- Sync Rule at top left
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sync then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Enabled" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 0 , 0.82 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Disabled" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetChecked ( false );
                end
                GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText );

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo == 1 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );
                elseif GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo == 2 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                end

                -- Build header text
                if isCopy then
                    local tempRule = GRM.BuildNewKickRuleTemplate();
                    ruleName = tempRule.name;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name = ruleName;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ruleIndex = tempRule.ruleIndex;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetText ( "(" .. GRM.L ( "Copy" ) .. ")" );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetText ( "(" .. GRM.L ( "Edit" ) .. ")" );
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal = ruleName;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetText ( ruleName );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox.ruleNameText = ruleName;

                -- Inactivity filter
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.activityFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Enable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 1 , 1 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Enable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 1 , 0 , 0 );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.numDaysOrMonths;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.numDaysOrMonths );


                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( GRM.L ( "Months") );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( GRM.L ( "Days") );
                end

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.allAltsApplyToKick then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetChecked ( false );
                end

                GRM_UI.ConfigureRankCheckBoxesPromoteAndDemote();
                -- Rank Filter
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI:EnableCustomSelectionOfRanks();
                else
                    
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.DisableCustomSelectionRanks();
                end
                GRM_UI.SetRankCustomRuleFilters();
                
                -- Activity Filter, Regardless if Active
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyEvenIfActiive then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetChecked ( false );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialNumDaysOrMonths;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialNumDaysOrMonths );
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetText ( GRM.L ( "Months") );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetText ( GRM.L ( "Days") );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();

                -- Level Range
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0.82 , 0  );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.EnableLevelSelectionEditBoxes();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.DisableLevelSelectionEditBoxes();
                end
                local levelRange = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[1];
                if levelRange == 999 then
                    levelRange = GetMaxPlayerLevel();
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetText ( levelRange );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:GetText();
                levelRange = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[2];
                if levelRange == 999 then
                    levelRange = GetMaxPlayerLevel();
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetText ( levelRange );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:GetText();

                -- Guild Rep 
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetText ( repOperators[GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repOperator] );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep , true ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:Show();

                if GRM_G.BuildVersion >= 40000 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 1 , 1 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep , false ) );
                end
                
                -- Note Matching
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetChecked( true );
                    GRM_UI.EnableNoteMatch();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetChecked ( false );
                    GRM_UI.DisableNoteMatch();
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetChecked( true );
                    GRM_UI.DisableNoteEditBox();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetChecked ( false );
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch then
                        GRM_UI.EnableNoteEditBox();
                    end
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[1] then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetChecked ( false );
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[2] then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetChecked ( false );
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[3] then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetChecked ( false );
                end

                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty then
                    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString > 0 then
                        matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString;
                    end
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern = matchString;

                if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeText > 0 then
                    safeString2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeText;
                end

                -- Safe Text Entry
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeMatch then
                    GRM_UI.EnableSafeNoteMatch();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 1 , 1 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Enable();
                    
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetText ( safeString2 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = safeString2;
                else
                    GRM_UI.DisableSafeNoteMatch();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetText ( safeString2 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = safeString2;
                end

                -- Ok let's reset
                matchString = GRM.L ( "Click to Set" );
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLog then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Enable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 1 , 1 , 1 );
                    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg > 0 then
                        matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg;
                    end
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetChecked ( false );
                end 
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern = matchString;

            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule = GRM.BuildNewKickRuleTemplate();

                -- Sync Rule at top left
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Enabled" ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 0 , 0.82 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetChecked ( true );
                GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox.ruleNameText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name;

                -- Inactivity filter
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value = 12;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetText ( "12" );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( GRM.L ( "Months") );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 1 , 1 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 1 , 0 , 0 );

                -- Rank Filter
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked( false );
                                
                GRM_UI.SetDefaultRankFilters();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:EnableMouse ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetTextColor ( 1 , 1 , 1 );
                
                GRM_UI.DisableCustomSelectionRanks();

                -- Activity Filter Regardless if Active
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value = 12;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetText ( "12" );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetText ( GRM.L ( "Months") );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();

                -- Level Range
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetText ( 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetText ( GRM_G.LvlCap );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = "1";
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = tostring ( GRM_G.LvlCap );
                GRM_UI.DisableLevelSelectionEditBoxes();

                -- Guild Rep
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetText ( repOperators[2] );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( 4 , false ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                
                -- Custom Note
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern = "";
                GRM_UI.DisableNoteMatch();

                -- Safe Text Match
                GRM_UI.DisableSafeNoteMatch();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetText ( safeString2 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = safeString2;
                
                -- Custom Log Entry
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern = matchString;
                
            end

            -- These frames will be the same edit or not
            -- Disable certain frames that only apply in promote/demote
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:Show();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearAllPoints();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText , "RIGHT" , 5 , 0 );

            GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText );

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.isEdit = isEdit;            

        end

        -- Method:          GRM_UI.ConfigureCustomRulePromoteAndDemoteFrame ( bool , string , bool )
        -- What it Does:    Configures the values of all the buttons on the custom rules creation window
        -- Purpose:         Keep rules settings displayed properly.
        GRM_UI.ConfigureCustomRulePromoteAndDemoteFrame = function ( isEdit , ruleName , isCopy )

            local matchString = GRM.L ( "Click to Set" );
            local safeString2 = GRM.L ( "Click to Set" );

            -- Build Rank Filter
            BuildRankCheckBoxes();
            GRM_UI.ModifyRuleUI();
            
            
            if isEdit then

                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule = GRM.GetPromoteRule ( ruleName );

                    
                elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule = GRM.GetDemoteRule ( ruleName );
                end

                -- Unique rule changes between demote/promote
                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:Hide();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearAllPoints();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected , "RIGHT" , 5 , 0 );

                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sinceAtRank then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetText ( GRM.L ( "Promote Player if at Rank for" ) );
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetText ( GRM.L ( "Promote Player if in Guild for" ) );
                    end

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetHitRectInsets ( 0 , 0 , 0 , 0 );


                elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:Hide();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearAllPoints();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText , "RIGHT" , 5 , 0 );

                    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText );

                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.createdBy = { GRM_G.addonUser , select ( 2 , UnitClass ("PLAYER") ) };

                -- Sync checkbox top right
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sync then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Enabled" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 0 , 0.82 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Disabled" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetChecked ( false );
                end
                GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText );

                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo == 1 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );
                elseif GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo == 2 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                end

                -- Build header text
                if isCopy then
                    ruleName = GRM.BuildNewPromoteOrDemoteRuleTemplate().name;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name = ruleName;
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetText ( "(" .. GRM.L ( "Copy" ) .. ")" );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetText ( "(" .. GRM.L ( "Edit" ) .. ")" );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal = ruleName;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetText ( ruleName );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox.ruleNameText = ruleName;

                -- Inactivity filter
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.activityFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 1 , 1 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Enable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 1 , 0 , 0 );

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:EnableMouse ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetTextColor ( 1 , 1 , 1 );

                    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.regardlessOfActivity then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                            GRM_UI.DisableRankActivityFrames();
                        else
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0 , 0 );
                            GRM_UI.EnableRankActivityFrames();
                        end
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:Enable();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:Enable();
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Enable();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 1 , 0.82 , 0 );

                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter then
                            GRM_UI.DisableEvenIfActiveButton();
                        end
                    end
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:EnableMouse ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
    
                    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                        GRM_UI.DisableRankActivityFrames();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:Disable();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:Disable();
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Disable();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
    
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter then
                            GRM_UI.EnableEvenIfActiveButton();
                        end
                    end
                end

                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.regardlessOfActivity then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:SetChecked ( true );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:SetChecked ( false );
                        
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.activityFilter then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                        end
                        
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:SetChecked ( false );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:SetChecked ( true );
                        
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.activityFilter then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0 , 0 ); 
                        end
                    end
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.numDaysOrMonths;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.numDaysOrMonths );
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( GRM.L ( "Months") );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( GRM.L ( "Days") );
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetTextColor ( 1 , 1 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetText ( GuildControlGetRankName ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.destinationRank ) );
                local playerIndex = GRM_UI.GetRankIndexDescendingOrder();
                local rankCap = ( GuildControlGetNumRanks() - GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.destinationRank );

                if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 and rankCap >= playerIndex ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and rankCap >= playerIndex - 1 ) then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetTextColor ( 1 , 0 , 0 );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetTextColor ( 1 , 1 , 1 );
                end


                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.allAltsApplyToKick then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetChecked ( false );
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialNumDaysOrMonths;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialNumDaysOrMonths );
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetText ( GRM.L ( "Months") );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetText ( GRM.L ( "Days") );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();

                GRM_UI.ConfigureRankCheckBoxesPromoteAndDemote();
                -- Rank Filter
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI:EnableCustomSelectionOfRanks(); 
                else
                    
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.DisableCustomSelectionRanks();
                end
                GRM_UI.SetRankCustomRuleFilters();
                
                -- Level Range
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0.82 , 0  );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.EnableLevelSelectionEditBoxes();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.DisableLevelSelectionEditBoxes();
                end
                local levelRange = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[1];
                
                if levelRange == 999 then
                    levelRange = GetMaxPlayerLevel();
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetText ( levelRange );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:GetText();
                levelRange = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[2];
                if levelRange == 999 then
                    levelRange = GetMaxPlayerLevel();
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetText ( levelRange );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:GetText();

                -- Guild Rep 
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetText ( repOperators[GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repOperator] );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep , true ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:Show();

                if GRM_G.BuildVersion >= 40000 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repFilter then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 1 , 1 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep , false ) );
                end
                
                
                -- Note Matching
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetChecked( true );
                    GRM_UI.EnableNoteMatch();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetChecked ( false );
                    GRM_UI.DisableNoteMatch();
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetChecked( true );
                    GRM_UI.DisableNoteEditBox();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetChecked ( false );
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch then
                        GRM_UI.EnableNoteEditBox();
                    end
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[1] then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetChecked ( false );
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[2] then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetChecked ( false );
                end
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[3] then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetChecked ( true );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetChecked ( false );
                end

                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty then
                    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString > 0 then
                        matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString;
                    end
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern = matchString;

                if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeText > 0 then
                    safeString2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeText;
                end

                -- Safe Text Entry
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeMatch then 

                    GRM_UI.EnableSafeNoteMatch();

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 1 , 1 , 1 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Enable();
                    
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetText ( safeString2 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = safeString2;
                    
                else
                    GRM_UI.DisableSafeNoteMatch();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetText ( safeString2 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = safeString2;
                end

                -- Ok let's reset
                matchString = GRM.L ( "Click to Set" );
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLog then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Enable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 1 , 1 , 1 );
                    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg > 0 then
                        matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg;
                    end
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetChecked ( false );
                end 
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern = matchString;


            else
                -- NOT AN EDIT

                -- Unique rule changes between demote/promote
                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:Hide();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearAllPoints();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected , "RIGHT" , 5 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetText ( GRM.L ( "Promote Player if at Rank for" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:EnableMouse ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetTextColor ( 1 , 1 , 1 );

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:SetChecked ( false );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:SetChecked ( true );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0 , 0 );

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetHitRectInsets ( 0 , 0 , 0 , 0 );

                elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:Hide();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:ClearAllPoints();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText , "RIGHT" , 5 , 0 );

                    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText );
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule = GRM.BuildNewPromoteOrDemoteRuleTemplate();

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Enabled" ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 0 , 0.82 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetChecked ( true );
                GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:Hide(); -- (Edit)
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleNameEditBox.ruleNameText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.ruleNameOriginal = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name;

                -- Inactivity filter
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value = 12;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetText ( "12" );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( GRM.L ( "Months") );
                            
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 1 , 1 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 1 , 0 , 0 );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Enable();
                
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetTextColor ( 1 , 1 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetText ( GuildControlGetRankName ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.destinationRank ) );

                -- Rank Filter
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked( true );
                                
                GRM_UI.SetDefaultRankFilters();
                GRM_UI.ConfigureRankCheckBoxesPromoteAndDemote();
                
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:EnableMouse ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetTextColor ( 1 , 1 , 1 );
                
                -- Activity Filter Regardless if Active
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value = 3;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetText ( "3" );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetText ( GRM.L ( "Months") );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();

                -- Level Range
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox:SetText ( 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox:SetText ( GRM_G.LvlCap );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStartEditBox.levelNameText = "1";
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomRuleLevelStopEditBox.levelNameText = tostring ( GRM_G.LvlCap );
                GRM_UI.DisableLevelSelectionEditBoxes();

                -- Guild Rep
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetText ( repOperators[2] );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( 4 , false ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                
                -- Custom Note
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetChecked ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern = "";
                GRM_UI.DisableNoteMatch();

                -- Safe Text Entry
                GRM_UI.DisableSafeNoteMatch();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetText ( safeString2 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = safeString2;


                -- Custom Log Entry
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern = matchString;
                
            end

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.isEdit = isEdit;            

        end
 
        -- Method:          GRM_UI.ConfigureCustomRulePromoteFrame ( bool , string )
        -- What it Does:    Configures the values of all the buttons on the custom rules creation window
        -- Purpose:         Keep rules settings displayed properly.
        GRM_UI.ConfigureCustomRulePromoteFrame = function ( isEdit , ruleName )
            GRM_UI.ConfigureCustomRulePromoteAndDemoteFrame ( isEdit , ruleName );
        end

        -- INACTIVITY CUSTOM RULES
        --------------------------

        -- Apply Rules To: 
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetScript ( "OnClick", function ( self )
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo == 1 then
                self:SetChecked ( true );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo = 1;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0 , 0 );

                -- Disable the rest
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetScript ( "OnClick", function ( self )
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo == 2 then
                self:SetChecked ( true );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo = 2;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0 , 0 );

                -- Disable the rest
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0.82 , 0 );
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "This only applies to KNOWN alts. Unconfigured will be excluded." ) );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3:SetScript ( "OnClick", function ( self )
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo == 3 then
                self:SetChecked ( true );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyRulesTo = 3;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetTextColor ( 1 , 0 , 0 );

                -- Disable the rest
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2:SetChecked ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetTextColor ( 1 , 0.82 , 0 );
            end
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText , "BOTTOMLEFT" , -5 , -11 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.activityFilter = true;

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 1 , 1 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 1 , 0 , 0 );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:EnableMouse ( true );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetTextColor ( 1 , 1 , 1 );
    

                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.regardlessOfActivity then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0 , 0 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
                        GRM_UI.DisableRankActivityFrames();
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0 , 0 );
                        GRM_UI.EnableRankActivityFrames();
                    end
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:Enable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:Enable();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Enable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 1 , 0.82 , 0 );

                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter then
                        GRM_UI.DisableEvenIfActiveButton();
                    end
                end

            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.activityFilter = false;

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:EnableMouse ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:EnableMouse ( false );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );

                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    GRM_UI.DisableRankActivityFrames();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:Disable();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:Disable();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetTextColor ( 0.5 , 0.5 , 0.5 );

                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter then
                        GRM_UI.EnableEvenIfActiveButton();
                    end
                end

            end
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetSize ( 25 , 22 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetMaxLetters ( 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetNumeric ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value = 0;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetAutoFocus( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetScript ( "OnEscapePressed" , function( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetScript ( "OnEnterPressed" , function( self )
            self:ClearFocus();   
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetScript ( "OnEditFocusLost" , function( self ) 
            self:HighlightText ( 0 , 0 );

            local numMonths = tonumber ( self:GetText() );
            local lowerLimit = 0;
            if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 or GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                lowerLimit = -1;
            end

            if numMonths > lowerLimit and numMonths < 100 then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.numDaysOrMonths = numMonths;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value = numMonths;
            else
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths then
                    if lowerLimit == 0 then
                        GRM.Report ( GRM.L ( "Please choose a month between 1 and 99" ) );
                    else
                        GRM.Report ( GRM.L ( "Please choose a month between 0 and 99" ) );
                    end
                elseif not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths then
                    if lowerLimit == 0 then
                        GRM.Report ( GRM.L ( "Please choose a day between 1 and 99" ) );
                    else
                        GRM.Report ( GRM.L ( "Please choose a day between 0 and 99" ) );
                    end
                end
            end   
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value );
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox , "RIGHT" , 3 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetSize (  60 , 18 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetFrameStrata ( "DIALOG" );
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

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change" ) );
            GameTooltip:Show();
        end);
    
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end)

        -- Promotion Rules
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetSize (  225 , 22 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetFrameStrata ( "DIALOG" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetWidth ( 195 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetWordWrap ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:SetWidth ( 220 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:SetFrameStrata ( "DIALOG" );
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:Show();
            end
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetScript ( "OnShow" , function() 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:Hide();
        end)
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetScript ( "OnMouseDown" , function( _ , button )
            if button == "LeftButton" then
                if  GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:IsVisible() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:Hide();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:Show();
                    GRM.RestoreTooltip();
                    GRM_UI.PopularGuildOrRankDropDown();
                end
            end
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change" ) );
            GameTooltip:Show();
        end);
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end)
        
        
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
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu.Buttons[i] = { tempButton , tempButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ) }
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
                        local number = tonumber ( string.match ( self:GetName() , ("%d+" ) ) );

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected.GRM_TimeScaleSelectedText:SetText ( FontButtonText:GetText() );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:Hide();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected:Show();

                        -- Days to months.
                        if number == 1 and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths = true;
                                                        
                        -- Going from months to days
                        elseif number == 2 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths = false;

                        end

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.numDaysOrMonths;
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RosterKickRecommendEditBox.value );
                    end
                end);
                FontButton:Show();
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleDropDownMenu:SetHeight ( height + 15 );
        end

         -- Method:          GRM_UI.PopularGuildOrRankDropDown()
        -- What it Does:    Creates a dropdown window for the GRM tool rule for promotions on since last rank or since join
        -- Purpose:         Greater flexibility and control to the player
        GRM_UI.PopularGuildOrRankDropDown = function()
            local buffer = 5;
            local height = 0;
            local width = 225;
            local names = { GRM.L ( "Promote Player if at Rank for" ) , GRM.L ( "Promote Player if in Guild for" ) };

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons or {};

            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons do
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons[i][1]:Hide();
            end

            for i = 1 , 2 do
                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons[i] then
                    local tempButton = CreateFrame ( "Button" , "GRM_GuildOrRankdButton" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons[i] = { tempButton , tempButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ) }
                end

                local FontButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons[i][1];
                local FontButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons[i][2];

                FontButton:SetWidth ( width );
                FontButton:SetHeight ( 11 );
                FontButton:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
                FontButtonText:SetText ( names[i] );
                FontButtonText:SetWidth ( width - 5 );
                FontButtonText:SetWordWrap ( false );
                FontButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
                FontButtonText:SetPoint ( "CENTER" , FontButton );
                FontButtonText:SetJustifyH ( "CENTER" );

                if i == 1 then
                    FontButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu , 0 , -7 );
                    height = height + FontButton:GetHeight();
                else
                    FontButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu.Buttons[i - 1][1] , "BOTTOM" , 0 , -buffer );
                    height = height + FontButton:GetHeight() + buffer;
                end

                FontButton:SetScript ( "OnClick" , function( self , button ) 
                    if button == "LeftButton" then
                        local number = tonumber ( string.match ( self:GetName() , ("%d+" ) ) );

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected.GRM_GuildOrRankSelectedText:SetText ( FontButtonText:GetText() );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:Hide();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankSelected:Show();

                        -- Based on if going since player joined the guild
                        if number == 1 and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sinceAtRank then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sinceAtRank = true;
                                                        
                        elseif number == 2 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sinceAtRank then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sinceAtRank = false;

                        end

                    end
                end);

                FontButton:SetScript ( "OnEnter" , function( self )
                    GRM_UI.SetTooltipScale()
                    GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                    GameTooltip:AddLine( FontButtonText:GetText() );
                    GameTooltip:Show();
                end);
                
                FontButton:SetScript ( "OnLeave" , function()
                    GRM.RestoreTooltip();
                end)


                FontButton:Show();
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildOrRankdDropDownMenu:SetHeight ( height + 15 );
        end

        -- RANK FILTER REGARDLESS OF ACTIVITY
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText , "BOTTOMLEFT" , -5 , -11 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyEvenIfActiive = true;
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.applyEvenIfActiive = false;
            end
            if GameTooltip:IsVisible() then
                GRM.RestoreTooltip()
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine(  "|CFFFF0000" .. GRM.L ( "WARNING!" ) .. "|r " .. GRM.L ( "Use Cautiously. Applies to all at rank, regardless of being active or inactive." ) );
            GameTooltip:AddLine ( GRM.L ( "This will only apply to players with verified promotion dates." ) );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText , "RIGHT" , 7 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetSize ( 25 , 22 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetMaxLetters ( 2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetNumeric ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value = 0;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetAutoFocus( false );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetScript ( "OnEscapePressed" , function( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetScript ( "OnEnterPressed" , function( self )
            self:ClearFocus();   
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetScript ( "OnEditFocusLost" , function( self ) 
            self:HighlightText ( 0 , 0 );

            local numMonths = tonumber ( self:GetText() );
            if numMonths > 0 and numMonths < 100 then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialNumDaysOrMonths = numMonths;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value = numMonths;
            else
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths then
                    GRM.Report ( GRM.L ( "Please choose a month between 1 and 99" ) );
                elseif not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths then
                    GRM.Report ( GRM.L ( "Please choose a day between 1 and 99" ) );
                end
            end   
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value );
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox , "RIGHT" , 3 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetSize (  60 , 18 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetFrameStrata ( "DIALOG" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetWidth ( 50 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetWordWrap ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:SetWidth ( 60 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:SetFrameStrata ( "DIALOG" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:Show();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetScript ( "OnShow" , function() 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetScript ( "OnMouseDown" , function( _ , button )
            if button == "LeftButton" then
                if  GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:IsVisible() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Show();
                    GRM_UI.PopulateActivityScaleSelectionDropDown();
                end
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change" ) );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        -- Method:          GRM_UI.PopulateActivityScaleSelectionDropDown()
        -- What it Does:    Creates a dropdown window for the GRM tool to allow player to select whether to choose months or days in terms of time passed.
        -- Purpose:         Greater flexibility and control to the player filter rules
        GRM_UI.PopulateActivityScaleSelectionDropDown = function()
            local buffer = 3;
            local height = 0;
            local width = 60;
            local names = { GRM.L ( "Months" ) , GRM.L ( "Days" ) };

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons or {};

            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons do
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons[i][1]:Hide();
            end

            for i = 1 , 2 do
                if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons[i] then
                    local tempButton = CreateFrame ( "Button" , "GRM_ToolTimeScaleButton" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons[i] = { tempButton , tempButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ) }
                end

                local FontButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons[i][1];
                local FontButtonText = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons[i][2];

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
                    FontButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu , 0 , -7 );
                    height = height + FontButton:GetHeight();
                else
                    FontButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu.Buttons[i - 1][1] , "BOTTOM" , 0 , -buffer );
                    height = height + FontButton:GetHeight() + buffer;
                end

                FontButton:SetScript ( "OnClick" , function( self , button ) 
                    if button == "LeftButton" then
                        local number = tonumber ( string.match ( self:GetName() , ("%d+" ) ) );

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected.GRM_KickEvenIfActiveTimeSelectedText:SetText ( FontButtonText:GetText() );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:Hide();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected:Show();

                        -- Days to months.
                        if number == 1 and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths = true;
                            
                        -- Going from months to days
                        elseif number == 2 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths then
                            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths = false;

                        end

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialNumDaysOrMonths;
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveEditBox.value );
                    end
                end);
                FontButton:Show();
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeMenu:SetHeight ( height + 15 );
        end

        -- REPUTATION RULE
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text , "BOTTOMLEFT" , -20 , -40 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton , "RIGHT" , 2 , 0 );
        

        if GRM_G.BuildVersion >= 40000 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonTextRetailOnlyText:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetScript ( "OnClick" , function ( self , button )
                if button == "LeftButton" then
                    if self:GetChecked() then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repFilter = true;
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( true );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 1 , 1 , 1 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( true );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep , true ) );
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repFilter = false;
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:EnableMouse ( false );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:EnableMouse ( false );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( GRM.GetReputationTextLevel ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep , false ) );
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                    end
                end
            end);
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:SetChecked ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonTextRetailOnlyText:SetPoint ( "BOTTOM" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected , "TOP" , 0 , 1 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonTextRetailOnlyText:SetTextColor ( 1 , 0 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonTextRetailOnlyText:Show();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonText:SetTextColor ( 0.5 , 0.5 , 0.5 );
        end

        -- Method:          GRM.ConfigureDropDownSymbols()
        -- What it Does:    Configures the dropdown menu to accomadate some operators that don't make sense at the edges
        -- Purpose:         Quality of Life settings control
        GRM.ConfigureDropDownSymbols = function()

            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep == 4 then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[1][1]:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[1][2]:SetTextColor ( 1 , 0 , 0 );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[1][1]:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[1][2]:SetTextColor ( 1 , 1 , 1 );
            end

            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep == 8 then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[3][1]:Disable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[3][2]:SetTextColor ( 1 , 0 , 0 );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[3][1]:Enable();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu.Buttons[3][2]:SetTextColor ( 1 , 1 , 1 );
            end

        end

        GRM.SetRepSymbolSelection = function ( _ , buttonNumber )
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repOperator = buttonNumber;  -- + 3 is to deal with reputation at neutral is index 4
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetText ( repOperators[buttonNumber] );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:Show();
        end

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonText , "RIGHT" , 3 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetSize (  55 , 18 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetFrameStrata ( "DIALOG" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetWidth ( 52 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetWordWrap ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:SetWidth ( 55 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:SetFrameStrata ( "DIALOG" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetScript ( "OnShow" , function() 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetScript ( "OnMouseDown" , function( self , button )
            if button == "LeftButton" then
                if  GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:IsVisible() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                    GRM.CreateDropDownMenu ( self , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu , 14 , 11 , "THICKOUTLINE" , repOperators ,  GRM.SetRepSymbolSelection );
                    GRM.ConfigureDropDownSymbols();
                end
                GRM.RestoreTooltip();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change" ) );
            GameTooltip:Show();
        end);
    
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        GRM.ConfigureSymbolSelected = function()
            if ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep == 4 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repOperator == 1 ) or ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep == 8 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repOperator == 3 )then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repOperator = 2;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetText ( repOperators[2] );
            end
        end

        GRM.SetGuildRepSelection = function ( _ , buttonNumber , buttonText )
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep = buttonNumber + 3;  -- + 3 is to deal with reputation at neutral is index 4
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetText ( buttonText:GetText() );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:Show();
            GRM.ConfigureSymbolSelected();
        end

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetSize (  120 , 18 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetFrameStrata ( "DIALOG" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetWidth ( 115 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetWordWrap ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:SetWidth ( 120 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:SetFrameStrata ( "DIALOG" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetScript ( "OnShow" , function() 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetScript ( "OnMouseDown" , function( self , button )
            if button == "LeftButton" then
                local repList = { GRM.GetReputationTextLevel ( 4 , true ) , GRM.GetReputationTextLevel ( 5 , true ) , GRM.GetReputationTextLevel ( 6 , true ) , GRM.GetReputationTextLevel ( 7 , true ) , GRM.GetReputationTextLevel ( 8 , true ) };
                if  GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:IsVisible() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolDropDownMenu:Hide();
                    GRM.CreateDropDownMenu ( self , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu , 11 , 11 , "THICKOUTLINE" , repList ,  GRM.SetGuildRepSelection );
                end
                GRM.RestoreTooltip();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change Rep" ) );
            GameTooltip:Show();
        end);
    
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end)

        
        -- CUSTOM RANK RULE Button Controls
        --------------------
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2 , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetScript ( "OnClick", function()
            GRM_UI.EnableCustomSelectionOfRanks();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked ( true );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0 , 0 ); 
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetScript ( "OnClick", function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetChecked ( true );
            GRM_UI.DisableCustomSelectionRanks();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1:SetChecked ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetTextColor ( 1 , 0 , 0 ); 
        end);
        
        -- String matching Custom Rules
        ---------------------
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton:SetScript ( "OnClick" , function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch = true;
                GRM_UI.EnableNoteMatch();
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch = false;
                GRM_UI.DisableNoteMatch();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButtonText , "RIGHT" , 15 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetMaxLetters ( 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetAutoFocus( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetSize ( 175 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetNumeric ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern = "";

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton , "BOTTOMRIGHT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:SetScript ( "OnClick" , function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty = true;
                GRM_UI.DisableNoteEditBox();
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty = false;
                GRM_UI.EnableNoteEditBox();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton , "BOTTOM" , 0 , -6 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:SetScript ( "OnClick" , function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[1] = true;

            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[1] = false;

            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText , "RIGHT" , 8 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:SetScript ( "OnClick" , function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[2] = true;

            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[2] = false;

            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetScript ( "OnClick" , function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[3] = true;

            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.notesToCheck[3] = false;

            end
        end);

        GRM_UI.EnableNoteMatch = function()
            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:Enable();
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetTextColor ( 1 , 1 , 1 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButtonText:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButtonText:SetTextColor ( 1 , 0.82 , 0 );
        end

        GRM_UI.DisableNoteMatch = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetTextColor ( 0.5 , 0.5 , 0.5  );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButtonText:SetTextColor ( 0.5 , 0.5 , 0.5  );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText:SetTextColor ( 0.5 , 0.5 , 0.5  );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText:SetTextColor ( 0.5 , 0.5 , 0.5  );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButtonText:SetTextColor ( 0.5 , 0.5 , 0.5  );
        end

        GRM_UI.EnableNoteEditBox = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetTextColor ( 1 , 1 , 1 );
            local matchString = GRM.L ( "Click to Set" );
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch then
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString == "" then
                    matchString = GRM.L ( "Click to Set" );
                else
                    matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString;
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetText ( matchString );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern = matchString;
            end
        end

        GRM_UI.DisableNoteEditBox = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetText ( "" );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetTextColor ( 0.5 , 0.5 , 0.5  );
        end

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetScript ( "OnEscapePressed" , function ( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetScript ( "OnEnterPressed" , function ( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            self:SetText ( GRM.Trim ( self:GetText() ) );
            local textResult = self:GetText();

            if textResult == "" then
                textResult = GRM.L ( "Click to Set" );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString = "";
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString = textResult;
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern = textResult;
            self:SetText ( textResult );
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetScript ( "OnEditFocusGained" , function ( self )
            if self:GetText() == GRM.L ( "Click to Set" ) then
                self:SetText ( "" );
            end
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
        end);
        
        -- SAFE TEXT MATCH
        ----------------------------
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButtonText:SetTextColor ( 1 , 0.82 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetScript ( "OnClick" , function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeMatch = true;
                GRM_UI.EnableSafeNoteMatch();
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeMatch = false;
                GRM_UI.DisableSafeNoteMatch();
            end
        end);

        GRM_UI.EnableSafeNoteMatch = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Enable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 1 , 1 , 1 );
        end

        GRM_UI.DisableSafeNoteMatch = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:Disable();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetTextColor ( 0.5 , 0.5 , 0.5  );
        end


        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "This only searches the officer note for the safe tag" ) );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButtonText , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetMaxLetters ( 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetAutoFocus( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetSize ( 175 , 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetNumeric ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = "";

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetScript ( "OnEscapePressed" , function ( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetScript ( "OnEnterPressed" , function ( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            self:SetText ( GRM.Trim ( self:GetText() ) );
            local textResult = self:GetText();

            if textResult == "" then
                textResult = GRM.L ( "Click to Set" );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeText = "";
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.safeText = textResult;
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox.stringPattern = textResult;
            self:SetText ( textResult );
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetScript ( "OnEditFocusGained" , function ( self )
            if self:GetText() == GRM.L ( "Click to Set" ) then
                self:SetText ( "" );
            end
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "Examples of simple tags:" ) );
            GameTooltip:AddLine ( " " );
            GameTooltip:AddLine ( GRM.L ( "[S]" ) );
            GameTooltip:AddLine ( "*" .. string.upper ( GRM.L ( "Safe" ) ) .. "*" );
            GameTooltip:AddLine ( string.upper ( GRM.L ( "Do Not Kick" ) ) );
            GameTooltip:AddLine ( " " );
            GameTooltip:AddLine ( GRM.L ( "Must be an exact match" ) , 1 , 0 , 0 );

            GameTooltip:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextSearchEditBox:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        -- CUSTOM REP
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetScript ( "OnClick" , function( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLog = true;
                GRM_UI.EnableCustomLogEntry();
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLog = false;
                GRM_UI.DisableCustomLogEntry();
            end
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "This note will appear with the log notification when a player meets this rule's conditions." ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        GRM_UI.EnableCustomLogEntry = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 1 , 1 , 1 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Enable();
        end

        GRM_UI.DisableCustomLogEntry = function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:Disable();

            local matchString = GRM.L ( "Click to Set" );

            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLog and #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg > 0 then
                matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg;
            end 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetText ( matchString );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern = matchString;
        end

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton , "BOTTOMRIGHT" , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame:SetSize ( 335 , 45 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame:SetScript ( "OnMouseDown" , function ( _ , button )
            if button == "LeftButton" and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLog and not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:HasFocus() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetFocus();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame , "TOPRIGHT" , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetMaxLetters ( 20 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:EnableMouse ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetAutoFocus( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetSize ( 332 , 45 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetMultiLine ( true );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetSpacing ( 1 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetMaxLetters ( 80 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetTextInsets ( 8 , 9 , 5 , 8 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetNumeric ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern = "";

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox , "TOPRIGHT" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount:Hide();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip:SetTextColor ( 1 , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip:Hide();

        -- end);
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetScript ( "OnTextChanged" , function( self )
            if self:HasFocus() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount:SetText ( self:GetNumLetters() .. "/" .. GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:GetMaxLetters() );
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetScript ( "OnEscapePressed" , function ( self )
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetScript ( "OnEnterPressed" , function ( self )
            self:SetText ( GRM.Trim ( self:GetText() ) );
            
            local textResult = self:GetText();
            if textResult == "" then
                textResult = GRM.L ( "Click to Set" );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg = "";
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg = textResult;
            end
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern = textResult;
            self:SetText ( textResult );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            self:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern );
            
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame:EnableMouse ( true );
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetScript ( "OnEditFocusGained" , function ( self )
            if self:GetText() == GRM.L ( "Click to Set" ) then
                self:SetText ( "" );
            end
            self:SetCursorPosition ( self:GetUTF8CursorPosition() );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount:SetText ( self:GetNumLetters() .. "/" .. GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:GetMaxLetters() );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount:Show();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip:Show();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame:EnableMouse ( false );
        end);
    
        -----------------------
        ------------ PROMOTION DEMOTION Unique BUTTONS
        -----------------------

        -- Activity Check
        -- Radial buttons
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "BOTTOMRIGHT" , 0 , -5 )
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1 , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2 , "RIGHT" , 2 , 0 );
        
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:SetScript ( "OnClick", function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:SetChecked ( true );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0 , 0 ); 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:SetChecked ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.regardlessOfActivity = true;
            GRM_UI.DisableRankActivityFrames();            
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:SetScript ( "OnClick", function()
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:SetChecked ( true );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetTextColor ( 1 , 0 , 0 ); 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:SetChecked ( false );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.regardlessOfActivity = false;
            GRM_UI.EnableRankActivityFrames();
        end);

        -- Compares ranks in order in numerically descending fasion than ascending.
        GRM_UI.GetRankIndexDescendingOrder = function()
            return ( GuildControlGetNumRanks() - GRM_G.playerRankID );
        end

        GRM_UI.SetDiestinationSelection = function ( _ , buttonNumber , buttonText )
            local playerIndex = GRM_UI.GetRankIndexDescendingOrder();

            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:Hide();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.destinationRank = ( GuildControlGetNumRanks() - buttonNumber + 1 );  -- + 3 is to deal with reputation at neutral is index 4
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetText ( buttonText:GetText() );

            if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 and buttonNumber >= playerIndex ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and buttonNumber >= playerIndex - 1 ) then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetTextColor ( 1 , 0 , 0 );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetTextColor ( 1 , 1 , 1 );
            end

            -- Re-configure the checkboxes.
            GRM_UI.ConfigureRankCheckBoxesPromoteAndDemote();
        end

        GRM_UI.AdjustColoringOfDestinationRanks = function()
            local playerIndex = GRM_UI.GetRankIndexDescendingOrder();
            for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu.Buttons do

                if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 and i >= playerIndex ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and i >= playerIndex - 1 ) then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu.Buttons[i][2]:SetTextColor ( 1 , 0 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu.Buttons[i][1]:SetScript ( "OnEnter" , function ( self )
                        GRM_UI.SetTooltipScale()
                        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );

                        if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                            GameTooltip:AddLine( GRM.L ( "Unable to promote players to this rank" ) );
                        elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                            GameTooltip:AddLine( GRM.L ( "Unable to demote players to this rank" ) );
                        end
                        GameTooltip:Show();
                    end);
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu.Buttons[i][1]:SetScript ( "OnLeave" , function()
                        GRM.RestoreTooltip();
                    end);
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu.Buttons[i][2]:SetTextColor ( 1 , 0.82 , 0 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu.Buttons[i][1]:SetScript ( "OnEnter" , nil );      -- No tooltip necessary if rank is ok
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu.Buttons[i][1]:SetScript ( "OnLeave" , nil );
                end

            end
        end

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText , "TOPLEFT" , 0 , 10 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetSize (  160 , 18 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetFrameStrata ( "DIALOG" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetPoint ( "CENTER" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetWidth ( 155 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetWordWrap ( false );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected , "BOTTOM" );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:SetWidth ( 160 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:SetFrameStrata ( "DIALOG" );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:SetScript ( "OnKeyDown" , function ( self , key )
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetScript ( "OnShow" , function() 
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:Hide();
        end)

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetScript ( "OnMouseDown" , function( self , button )
            if button == "LeftButton" then
                if  GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:IsVisible() then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:Hide();
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksDropDownMenu:Hide();
                    GRM.CreateDropDownMenu ( self , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankDropdownMenu , 12 , 12 , "THICKOUTLINE" , GRM.GetListOfGuildRanks() ,  GRM_UI.SetDiestinationSelection );
                    GRM_UI.AdjustColoringOfDestinationRanks();
                end
                GRM.RestoreTooltip();
            end
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change" ) );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end)

        -- Sync details
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxFrame , "BOTTOMLEFT" , 0 , 0 );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetScript ( "OnClick" , function ( self )
            if self:GetChecked() then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sync = true;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.editTime = time();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Enabled" ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 0 , 0.82 , 1 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton:SetChecked ( true );                
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.sync = false;
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetText ( GRM.L ( "Rule Sync Disabled" ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetTextColor ( 1 , 0 , 0 );
            end
            GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText );
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetPoint ( "Left" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButton , "RIGHT" , 2 , 0 );

        -----------------------
        ---- UI MODIFICATIONS DEPENDING ON Macro Action
        -----------------------

        -- Method:          GRM_UI.ModifyRuleUI()
        -- What it Does:    Adjusts the positioning of the main rules selection filters window and various frames to adjust for kick, promote, and demote filters
        -- PurposeL         Rather than rebuild whole new frames for each, this just builds one reusable frame for all 3 rule types.
        GRM_UI.ModifyRuleUI = function()

            -- Unpinning for all as needed
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:ClearAllPoints();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:ClearAllPoints();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:ClearAllPoints();
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText:ClearAllPoints();

            -- Kick
            if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 or GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                
                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetText ( GRM.L ( "Kick Inactive Player Reminder at" ) .. " " );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetText ( GRM.L ( "Kick Players at Selected Rank(s) after" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetText ( GRM.L ( "Only recommend to kick if all player linked alts exceed max time" ) );

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOPLEFT" , 38 , -60 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:Hide();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText:Hide()

                elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetText ( GRM.L ( "Demote Player if Inactive for" ) .. " " );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText:SetText ( GRM.L ( "Demote to Rank:" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetText ( GRM.L ( "Only recommend to Demote if all player linked alts exceed max time" ) );

                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOPLEFT" , 38 , -80 );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:Show();
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText:Show()
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton , "RIGHT" , 2 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed , "BOTTOMLEFT" , -8 , -15 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton , "BOTTOMLEFT" , 0 , -15 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButton , "BOTTOMRIGHT" , 0 , -10 );
                
                if GRM.S().selectedLang == 5 then -- Russian
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetSize ( 450 , 760 );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetSize ( 450 , 760 );
                end

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:Hide();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:Show();

            -- Promote and Demote
            elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then

                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetText ( GRM.L ( "Promote Player if at Rank for" ) .. " " );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetText ( GRM.L ( "Apply Promotions Regardless of Activity" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetText ( GRM.L ( "Apply Only to Active Players" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText:SetText ( GRM.L ( "Promote to Rank:" ) );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetText ( GRM.L ( "Player is considered inactive if offline for" ) .. " " );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimedText:SetText ( GRM.L ( "Ignore inactivity if at least one player linked alt is active" ) );
                
                end

                GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text );
                GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text );
                
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2 , "BOTTOMRIGHT" , 2 , -7 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2 , "BOTTOMLEFT" , -8 , -65 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton , "BOTTOMLEFT" , 0 , 25 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolAltsOfflineTimed:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText , "BOTTOMLEFT" , -5 , -10 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame , "TOPLEFT" , 38 , -80 );

                if GRM.S().selectedLang == 5 then -- Russian
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetSize ( 450 , 760 );
                else
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:SetSize ( 450 , 760 );
                end
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText:Show();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton:Hide();

            end

            GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText );

        end



        GRM_UI.LocalizationMModifications = function()
                    -- Localization adjustments
            if GRM.S().selectedLang == 5 then -- Russian
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:ClearAllPoints();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton , "BOTTOMLEFT" , 0 , -6 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:ClearAllPoints();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton , "BOTTOMLEFT" , 0 , -5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:ClearAllPoints();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOM" , 0 , -65 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetSize ( 110 , 65 );
            else
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:ClearAllPoints();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton:SetPoint ( "LEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText , "RIGHT" , 8 , 0 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:ClearAllPoints();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton , "BOTTOMLEFT" , 0 , -5 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:ClearAllPoints();
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolResetSelectedMacroNamesButton , "BOTTOM" , 0 , -95 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolViewSafeListButton:SetSize ( 110 , 25 );
            end
        end

    end

    -- Custom Rules Fontstrings
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRuleNumberText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRecommendKickCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesConfirmButton.GRM_ToolCustomRulesConfirmButtonText:SetText( GRM.L ( "Confirm" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesCancelButton.GRM_ToolCustomRulesCancelButtonText:SetText ( GRM.L ( "Cancel" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text:SetText ( GRM.L ( "Apply Only to Selected Ranks" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton1Text );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text:SetText ( GRM.L ( "Apply to All Ranks" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolRulesRankRadialButton2Text );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText:SetText ( GRM.L ( "Kick Players at Selected Rank(s) after" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text:SetText ( GRM.L ( "Apply to All Levels" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton1Text );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text:SetText ( GRM.L ( "Apply Only to Level Range" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRadialButton2Text );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelText:SetText ( GRM.L ( "To" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomRulesLevelRangeText:SetText ( GRM.L ( "Level Range:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButtonText:SetText ( GRM.L ( "Require Text Match" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCompareStringCheckButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonText:SetText ( GRM.L ( "Player Guild Rep is" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepSymbolSelected.GRM_GuildRepSymbolSelectedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected.GRM_GuildRepRanksSelectedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButtonText:SetText ( GRM.L ( "Only Match Empty Notes" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolEmptyCheckButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText:SetText ( GRM.L ( "Public Note" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolPublicNoteCheckButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText:SetText ( GRM.L ( "Officer Note" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolOfficerCheckButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButtonText:SetText ( GRM.L ( "Custom Note" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolCustomCheckButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonTextRetailOnlyText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRuleCheckButtonTextRetailOnlyText:SetText ( GRM.L ( "(Disabled in Classic)" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbuttonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbuttonText:SetText ( GRM.L ( "Disable chat log spam while using the Macro Tool" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton , GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbuttonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButtonText:SetText ( GRM.L ( "Only Show Players Currently Online" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton , GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButtonText );
    -- Updated Rules
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesText:SetText ( GRM.L ( "Apply Rules to:" ) );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text:SetText ( GRM.L ( "All" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton1.GRM_ApplyRulesRadioButton1Text );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text:SetText ( GRM.L ( "Alts Only" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton2.GRM_ApplyRulesRadioButton2Text );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text:SetText ( GRM.L ( "Mains Only" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRulesRadioButton3.GRM_ApplyRulesRadioButton3Text );

    -- Safe Text Msg
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButtonText:SetText ( GRM.L ( "Ignore Rule With Text Match" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButton, GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_SafeTextMatchButtonText );

    -- Custom Log msg
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButtonText:SetText ( GRM.L ( "Custom Log Entry Message" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButton , GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageButtonText );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetFontObject ( "GameFontWhite" );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxCount:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBoxTip:SetText ( GRM.L ( "Press ENTER to Save" ) );

    -- Promotions and Demotions
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ApplyRegardlessActivityRadialButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_RankDestinationText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_DestinationRankSelected.GRM_DestinationRankSelectedText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );

    -- Sync
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_ToolSyncButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    
    -- UI modications as needed for localization purposes as well as different pinning and additional options depening on macro type.
    GRM_UI.LocalizationMModifications();
    GRM_UI.ModifyRuleUI();

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
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:Hide();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions1_K:Show();
        end

        if CanGuildPromote() then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:Hide();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions2_P:Show();
        end

        if CanGuildDemote() then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:Hide();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTextPermissions3_D:Show();
        end
    end
end


-----------------------------
----- QUED SCROLL FRAME -----
-----------------------------

-- Method:          GRM.GetQueuedEntries ( bool )
-- What it Does:    Determines which grouping to import
-- Purpose:         Proper sorting of players in the guild to be added to the mass kick tool
GRM.GetQueuedEntries = function ()
    local result = {};

    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
        if CanGuildRemove() then
            result = GRM.GetKickNamesByFilterRules();
        end
    elseif ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 and CanGuildPromote() ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and CanGuildDemote() ) then
        result = GRM.GetNamesByFilterRules ( GRM_UI.GRM_ToolCoreFrame.TabPosition );
    end

    return result;
end

-- Method:          GRM.SetKickQueuedValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Quality of life feature.
GRM.SetKickQueuedValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind];
    local mainTag = "|CFFFF0000 (" .. GRM.L ( "M" ) .. ")|r";
    local altTag = "|CFFFF8080 (" .. GRM.L ( "A" ) .. ")|r";
    local tag = "";
    local tab = "";

    if GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].isMain then
        tag = mainTag;
    elseif GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].isAlt then
        tag = altTag;
    end

    if GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].tab then
        tab = "        ";
    end

    -- Player Name
    line[2]:SetText ( tab .. GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].name .. tag );
    line[2]:SetTextColor ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].class[1] , GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].class[2] , GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].class[3] , 1 );
    line[3]:SetText ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].action );

    if GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].action == GRM.L ( "Kick" )then
        line[3]:SetTextColor ( 1 , 0 , 0 , 1 );
    elseif GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].action == GRM.L ( "Promote" ) then
        line[3]:SetTextColor ( GRM.S().logColor[4][1] , GRM.S().logColor[4][2] , GRM.S().logColor[4][3] , 1 );
    elseif GRM_UI.GRM_ToolCoreFrame.QueuedEntries[ind2].action ==  GRM.L ( "Demote" ) then
        line[3]:SetTextColor ( GRM.S().logColor[5][1] , GRM.S().logColor[5][2] , GRM.S().logColor[5][3] , 1 );
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

-- Method:          GRM.GetToolTipLine ( table )
-- What it Does:    Constructs a string based on the rule info, for a tooltip
-- Purpose:         UX
GRM.GetToolTipLine = function ( rulePart )
    local result = {};

    for i = 1 , #rulePart do
        if rulePart[i][1] == "Inactive" then
            table.insert ( result , " - " .. GRM.L ( "Last Online" ) .. ": " .. GRM.HoursReport ( rulePart[i][2] ) );
        elseif rulePart[i][1] == "Rank" then
            table.insert ( result , " - " .. GRM.L ( "Matching Rank" ) .. ": " .. rulePart[i][2] );
        elseif rulePart[i][1] == "Level" then
            table.insert ( result , " - " .. GRM.L ( "Within Level Range: {num} - {custom1}" , nil , nil , rulePart[i][2] , rulePart[i][3] ) );
        elseif rulePart[i][1] == "Note Match" then
            table.insert ( result , " - " .. GRM.L ( "Note match: {name}" , "\"" .. rulePart[i][2] .. "\"" ) );
        elseif rulePart[i][1] == "Empty Note Match" then
            table.insert ( result , " - " .. GRM.L ( "Empty Note match: {name}" , "\"" .. rulePart[i][2] .. "\"" ) );
        elseif rulePart[i][1] == "Main/Alt" then
            table.insert ( result , " - " .. GRM.L ( "Main/Alt: {name}" , "\"" .. rulePart[i][2] .. "\"" ) );
        elseif rulePart[i][1] == "RankTime" then
            table.insert ( result , " - " .. GRM.L ( "Time at Rank: {name}" , "\"" .. rulePart[i][2] .. "\"" ) );
        elseif rulePart[i][1] == "GuildTime" then
            table.insert ( result , " - " .. GRM.L ( "Time in Guild: {name}" , "\"" .. rulePart[i][2] .. "\"" ) );
        elseif rulePart[i][1] == "Rep" then
            table.insert ( result , " - " .. rulePart[i][2] );
        elseif rulePart[i][1] == "Safe Tag" then
            table.insert ( result , " - " .. GRM.L ( "No safe tag '{name}' in officer note" , rulePart[i][2] ) );
        end
    end

    return result;
end

-- Method:          GRM.UpdateQueuedTooltip ( int )
-- What it Does:    Sets the tooltip for the Queued scrollframe in the GRM kick tool
-- Purpose:         Make it clear the QoL controls.
GRM.UpdateQueuedTooltip = function ( ind )
    local taggedName = GRM.Trim ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][2]:GetText() );
    if string.find ( taggedName , "|" ) then
        taggedName = string.match ( taggedName , "(.+)|CFF" );
    end
    local details;
    local mainTag = "|CFFFF0000 (" .. GRM.L ( "M" ) .. ")|r";
    local altTag = "|CFFFF8080 (" .. GRM.L ( "A" ) .. ")|r";
    local player = GRM.GetPlayer ( taggedName );
    local name = "";
    local tag = "";
    local mainName = "";
    local alts = {};

    -- See if main tag is needed.
    if player.altGroup ~= "" then
        alts , mainName = GRM.GetListOfAlts ( player );
        if mainName ~= "" then
            if mainName == player.name then
                tag = mainTag;
            else
                tag = altTag;
            end
        end
    end

    -- Match the class color
    name = GRM.GetClassColorRGB ( player.class , true ) .. player.name .. "|r" .. tag;

    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][1] , "ANCHOR_CURSOR" );
    GameTooltip:AddLine ( name );

    -- Add Alts
    local altList = "";
    for i = 1 , #alts do
        if i == 1 then
            altList = GRM.L ( "Alts:" ) .. " |r";
        end

        tag = "";
        if alts[i][1] == mainName then
            tag = mainTag;
        end
        altList = altList .. GRM.GetClassColorRGB ( alts[i][2] , true ) .. GRM.FormatName ( alts[i][1] ) .. "|r" .. tag .. ", ";

        if i % 4 == 0 and not ( i == #alts ) then
            altList = altList .. "\n";
        end

        if i == #alts then
            altList = string.sub ( altList , 1 , #altList - 2 );
            GameTooltip:AddLine ( altList );
            GameTooltip:AddLine ( " " );
        end
    end

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries do
        if GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i].name == player.name then

            if type ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i][#GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i]] ) == "table" then
                for j = 1 , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i] do
                    GameTooltip:AddLine ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i][j][1] )     -- Rule Name
                    details = GRM.GetToolTipLine ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i][j][2] );     -- Rule Sub details

                    for k = 1 , #details do
                        GameTooltip:AddLine ( details[k] , 1 , 1 , 1 );
                    end
                    GameTooltip:AddLine ( " " );    -- adds a small space between the lines
                end
            else
                GameTooltip:AddLine ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i].customMsg )
                GameTooltip:AddLine ( " " );
            end

            break;
        end
    end

    GameTooltip:AddLine ( GRM.L ( "{custom1} to open Player Window" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Click" ) .. "|r" ) );
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
GRM.BuildQueuedScrollFrame = function ( showAll , fullRefresh , isBanAltList , bannedInGuildList , customKickGroup )
    local hybridScrollFrameButtonCount = 13;
    local buttonHeight = 25;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollFrame:GetWidth() - 5;
    if showAll and fullRefresh then
        GRM_UI.GRM_ToolCoreFrame.ValidatedNames = {};
        if not isBanAltList and not bannedInGuildList and not customKickGroup then
            GRM_UI.GRM_ToolCoreFrame.QueuedEntries = GRM.GetQueuedEntries();
        elseif isBanAltList then
            GRM_UI.GRM_ToolCoreFrame.QueuedEntries = GRM.DeepCopyArray ( GRM_G.KickAllAltsTable );
            GRM_G.KickAllAltsTable = {};
        elseif bannedInGuildList then
            GRM_UI.GRM_ToolCoreFrame.QueuedEntries = GRM.DeepCopyArray ( GRM_G.KickAllBannedTable );
            GRM_G.KickAllBannedTable = {};
        elseif customKickGroup then
            GRM_UI.GRM_ToolCoreFrame.QueuedEntries = GRM.DeepCopyArray ( GRM_G.customKickList );
            GRM_G.customKickList = {};
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
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" )
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

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalQueText2:SetText ( #GRM_UI.GRM_ToolCoreFrame.QueuedEntries );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameTotalIgnoredText2:SetText ( #GRM_UI.GRM_ToolCoreFrame.Safe );

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
            local playerName = GRM.Trim ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolQueuedScrollChildFrame.AllButtons[ind][2]:GetText() );
            if string.find ( playerName , "|" ) then
                playerName = string.match ( playerName , "(.+)|CFF" );
            end
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
            GRM.RestoreTooltip();
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
        if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].isHighlighted then
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

-- Method:          GRM.AdjustForDemoteMacroLimitation ( table )
-- What it Does:    Checks for duplicates in the list and purges all of them. This implies there are multiple players with the same name.
-- Purpose:         The /gdemote macro command has a limitation on merged realm guilds. You cannot get the macro to work (as of patch 9.0.2) if the server is appended
--                  This ultimately creates a point of flaw where in a merged realm you can have multiple characters with the same name, but from different realms. As such, for the addon to compensate,
--                  what happens is GRM decides to just purge the names of the players with the SAME name and instead gives a notification for the player to do those demotions manually, in the rare, edge case scenario
--                  this this might occur. Hopefully Blizzard revises this macro at some point in the future.
GRM.AdjustForDemoteMacroLimitation = function ( entries )
    local names = {};
    local count , num = 0 , 0;
    local name = {};
    local listOfMembers = GRM.GetListOfGuildies( true );

    for i = #entries , 1 , -1 do
        num = 0;
        name = GRM.SlimName ( entries[i].name );        -- Next name
        
        for j = 1 , #listOfMembers do                   -- Let's compare to existing guild. If this person on the list has 2 copies of a member in the guild with the same name we are in trouble.

            if name == listOfMembers[j] then
                -- name match!!!
                num = num + 1;

                if num > 1 then                         -- sign of 2 copies!!!
                    if not names[name] then             -- don't need to add more than once.
                        names[name] = entries[i].name;  -- Add the full name for report to chat
                        count = count + 1;
                    end
                    table.remove ( entries , i ); -- purge repeats
                end
                break;

            end
        end

    end

    -- Now, we remove the purged names
    for n in pairs ( names ) do
        for i = #entries , 1 , -1 do
            if GRM.SlimName ( entries[i].name ) == n then
                table.remove ( entries , i);
                break;
            end
        end
    end

    if count > 0 then
        for _ , fullName in pairs ( names ) do
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Demotion Macro Limitation!!! Unable to demote {name} due to multiple players in the guild with the same name, though different realms. Please demote manually." , fullName ) );
        end
    end
    
    return entries;
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

    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
        GRM_UI.GRM_ToolCoreFrame.QueuedEntries = GRM.AdjustForDemoteMacroLimitation ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries );
    end

    local entries = GRM_UI.GRM_ToolCoreFrame.QueuedEntries;
    local macroSet = false;
    
    -- Create the macro
    while i <= #entries do
        if not GRM.IsNameBlacklisted ( entries[i].name ) then
            tempText = macroTxt;
            -- Save room on the macro if player is on the same server as you
            if count == 0 then
                tempText = "/run GRM.RMM()\n" .. entries[i].macro .. " " .. GRM.GetMacroFormattedName ( entries[i].name );
                count = 1;
            else
                tempText = tempText .. "\n" .. entries[i].macro .. " " .. GRM.GetMacroFormattedName ( entries[i].name );
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

-- Method:          GRM.GetMacroCountForPromoteAndDemote()
-- What it Does:    Returns the count of the number of times a macro needs to be hit
-- Purpose:         To inform the player how many times macro must be hit.
GRM.GetMacroCountForPromoteAndDemote = function()
    local macroTxt = "";
    local tempText = "";
    local count = 0;
    local count2 = 0;
    local i = 1;
    local entries = GRM.DeepCopyArray ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries );
    local listOfNames = {};
    
    -- Create the macro
    while i <= #entries do
        if not GRM.IsNameBlacklisted ( entries[i].name ) then
            tempText = macroTxt;
            -- Save room on the macro if player is on the same server as you
            if count == 0 then
                tempText = "/run GRM.RMM()\n" .. entries[i].macro .. " " .. GRM.GetMacroFormattedName ( entries[i].name );
                count = 1;
            else
                tempText = tempText .. "\n" .. entries[i].macro .. " " .. GRM.GetMacroFormattedName ( entries[i].name );
            end

            -- Macro still not full and we are still on the first set
            if #tempText < 256 and count2 == 0 then
                macroTxt = tempText;

                if entries[i].numRankJumps > 1 then
                    entries[i].numRankJumps = entries[i].numRankJumps - 1;
                    table.insert ( listOfNames , entries[i] );
                end
                i = i + 1;

            -- Macro Still not full and we are on the 2nd loop that is not being used to be built
            elseif #tempText < 256 and count2 > 0 then
                macroTxt = tempText;

                if entries[i].numRankJumps > 1 then
                    entries[i].numRankJumps = entries[i].numRankJumps - 1;
                    table.insert ( listOfNames , entries[i] );
                end
                i = i + 1;

            -- Macro IS full, and we are still on the first set.
            elseif count2 == 0 and ( #tempText > 255 or ( i == #entries and #listOfNames > 0 ) ) then
                count = 0;
                count2 = count2 + 1;
                macroTxt = "";
                tempText = "";
                if #listOfNames > 0 then
                    for j = 1 , #listOfNames do
                        table.insert ( entries , listOfNames[j] );
                    end
                    listOfNames = {};
                end

            -- Macro IS full, and we are on the subsequent sets.
            elseif count2 > 0 and ( #tempText > 255 or ( i == #entries and #listOfNames > 0 ) ) then
                count = 0;
                count2 = count2 + 1;
                macroTxt = "";
                if #listOfNames > 0 then
                    for j = 1 , #listOfNames do
                        table.insert ( entries , listOfNames[j] );
                    end
                    listOfNames = {};
                end
            end

        else
            i = i + 1;      -- Name was blacklisted, moving on.
        end

        if i > #entries then
            count2 = count2 + 1;
        
            if #listOfNames > 0 then
                count = 0;
                macroTxt = "";
                tempText = "";
                for j = 1 , #listOfNames do
                    table.insert ( entries , listOfNames[j] );
                end
                listOfNames = {};
            end
        end
    end

    return count2;
end

-- Method:          GRM.IsMacroActionComplete()
-- What it Does:    Checks if any names on the qued list are not blacklist and if so, they are still going to be built into the macro list, thus we know it is not complete
-- Purpose:         Useful to know when all macro actions have compelted to do a verification they reached destination ranks
GRM.IsMacroActionComplete = function()
    local result = true;
    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries do
        if not GRM.IsNameBlacklisted ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[i].name ) then
            result = false;
        end
    end

    return result;
end

-- Method:          GRM.PurgeMacrodNames()
-- What it Does:    Removes the names just macro'd from the list
-- Purpose:         Rebuild the macros ASAP!
GRM.PurgeMacrodNames = function()
    local startCount = #GRM_UI.GRM_ToolCoreFrame.QueuedEntries;

    for i = #GRM_UI.GRM_ToolCoreFrame.MacroEntries , 1 , -1 do
        for j = #GRM_UI.GRM_ToolCoreFrame.QueuedEntries , 1 , -1 do
            if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].name == GRM_UI.GRM_ToolCoreFrame.QueuedEntries[j].name then

                if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
                    table.remove ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries , j );
                else
                    -- Don't purge from the quue yet if they need multiple jumps.
                    if GRM_UI.GRM_ToolCoreFrame.QueuedEntries[j].numRankJumps > 1 then
                        GRM_UI.GRM_ToolCoreFrame.QueuedEntries[j].numRankJumps = GRM_UI.GRM_ToolCoreFrame.QueuedEntries[j].numRankJumps - 1;
                    else
                        table.remove ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries , j );
                    end
                end
                GRM_UI.GRM_ToolCoreFrame.ValidatedNames[GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].name] = GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].rankIndex;
                table.remove ( GRM_UI.GRM_ToolCoreFrame.MacroEntries , i );
                break;
            end
        end
    end

    if startCount ~= #GRM_UI.GRM_ToolCoreFrame.QueuedEntries then
        C_Timer.After ( 0.5 , function()
            GRM.GetCountOfNamesBeingFiltered();
            GRM.RefreshSelectHybridFrames ( true , true , true , false );
        end);
    end

end

-- Method:          GRM.ValidateMacroRecordingSuccess ( bool )
-- What it Does:    Checks if all of the rank changes matched their destination rank, if not, rescans the roster for changes
-- Purpose:         To ensure integrity of the roster
GRM.ValidateMacroRecordingSuccess = function( isReScan )
    local ranksAllMatching = true;
    local guildData = GRM.GetGuild();

    for name , rankIndex in pairs ( GRM_UI.GRM_ToolCoreFrame.ValidatedNames ) do
        if guildData[name].rankIndex ~= rankIndex then
            ranksAllMatching = false;
            break;
        end
    end

    if not ranksAllMatching then
        if not isReScan then        -- Only going to scan 1 time...
            GRM.Report ( GRM.L ( "GRM:" ) .. " : " .. GRM.L ( "Not all macro changes validated. One moment..." ) );
            GRM_UI.GRM_ToolCoreFrame.MacroSuccess = false

            GRM.GuildRoster();
            if GRM_G.BuildVersion >= 30000 then
                QueryGuildEventLog();
            end
            
            C_Timer.After ( 2 , function()
                GRM_G.ManualScanEnabled = true;
                GRM.BuildNewRoster();
                C_Timer.After ( 1 , function()
                    GRM_G.MacroInProgress = false;
                end);
            end);
        else
            -- Not able to validate
            GRM_UI.GRM_ToolCoreFrame.MacroSuccess = true;
            GRM_G.MacroInProgress = false;
            GRM.Report ( GRM.L ( "Warning! Macro changes were not able to be validated. Please verify expected results before using the macro tool further." ) );
        end
    else
        GRM_UI.GRM_ToolCoreFrame.MacroSuccess = true;
        GRM_G.MacroInProgress = false;
        GRM.Report ( GRM.L ( "Macro rank changes have been validated!" ) );
    end

end

-- Method:          GRM.SetMacroValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Quality of life feature.
GRM.SetMacroValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind];

    -- Player Name
    line[2]:SetText ( GRM.GetMacroFormattedName ( GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2].name ) );
    line[2]:SetTextColor ( GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2].class[1] , GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2].class[2] , GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2].class[3] , 1 );
    line[3]:SetText ( GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2].macro );
    line[4]:SetText ( GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2].numRankJumps );

    if GRM_UI.GRM_ToolCoreFrame.MacroEntries[ind2].isHighlighted then
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
                if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k].name == name then
                    if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k].isHighlighted then
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
                if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k].name == name then
                    if GRM_UI.GRM_ToolCoreFrame.MacroEntries[k].isHighlighted then
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
    GRM.SetMacroValues ( #GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset );
end

-- Method:          GRM.KickMacrodSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe backups at position 1
-- Purpose:         Clean scrolling
GRM.KickMacrodSetFirstValue = function()
    GRM.SetMacroValues ( 1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset - #GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons + 1 );
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
    GameTooltip:AddLine ( GRM.L ( "{custom1} to open Player Window" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Click" ) .. "|r" ) );
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
        if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].isHighlighted then
            GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].isHighlighted = false;
            table.insert ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames , GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].name );        -- Add the name to the blacklist
            table.remove ( GRM_UI.GRM_ToolCoreFrame.MacroEntries , i );
        end
    end
    -- need to remove from qued as well.
    GRM.BuildMacrodScrollFrame ( false , false );
end

-- Method:          GRM.RMM()
-- What it Does:    Resets Macro
-- Purpose:         Clear the macro after each use so it can be rebuilt - prevents double use of macro by spam clicking.
GRM.RMM = function()
    GRM.CreateMacro ( "" , "GRM_Tool" , "INV_MISC_QUESTIONMARK" , GRM_G.MacroHotKey );
    GRM_G.HK = true;
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
    
    if ( showAll and fullRefresh ) or ( not showAll and not fullRefresh ) then

        GRM_UI.GRM_ToolCoreFrame.MacroEntries , count , size = GRM.GetMacroEntries();

        if GRM_UI.GRM_ToolCoreFrame.TabPosition > 1 then
            count = GRM.GetMacroCountForPromoteAndDemote();     -- Specialized count for multi-hit promotions/demotions
        end

    elseif not fullRefresh then
        GRM.CreateMacro ( "" , "GRM_Tool" , "INV_MISC_QUESTIONMARK" , GRM_G.MacroHotKey );    -- Clear the macro
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
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" ),
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" )
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
            GRM.SetMacroValues ( i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.Offset - hybridScrollFrameButtonCount ) , i );
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
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3:SetText ( GRM.L ( "Macro Size: {num}/255" , nil , nil , size ) );
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3:Show();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:SetText ( GRM.GetHotKeyRecommendationScript ( count ) );

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:Show();

        if GRM_UI.GRM_ToolCoreFrame.TabPosition > 1 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:Show();
        end
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText3:Hide();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameText7:Hide();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:Hide();
    end

    -- Not relevant for kicks, only macros and demotions - kicks == 1
    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_TooCoreFrameLimitationText:Hide();
    end

    -- Permissions Text
    GRM_UI.RefreshToolPermissionReport();
    GRM.SetMacroButtonText();

end

-- Method:          GRM.GetHotKeyRecommendationScript ( int )
-- What it Does:    Gets the proper hotkey message to the player based on the type of macro action, and if plural or singular form
-- Purpose:         Quality of life and properly grammatic messaging.
GRM.GetHotKeyRecommendationScript = function ( count )
    count = "|CFFFF0000" .. count .. "|r";
    local singularEnum = { [1] = GRM.L ( "When you are ready to remove the players, press the Hot-Key {name} 1 time to complete all actions" , "|CFF00CCFF" .. GRM_G.MacroHotKey .. "|r" ) , [2] = GRM.L ( "When you are ready to Promote the player, press the Hot-Key {name} 1 time to complete all actions" , "|CFF00CCFF" .. GRM_G.MacroHotKey .. "|r" ) , [3] = GRM.L ( "When you are ready to Demote the player, press the Hot-Key {name} 1 time to complete all actions" , "|CFF00CCFF" .. GRM_G.MacroHotKey .. "|r" ) }
    local pluralEnum = { [1] = GRM.L ( "When you are ready to remove the players, press the Hot-Key {name} {num} times to complete all actions" , "|CFF00CCFF" .. GRM_G.MacroHotKey .. "|r" , nil , count ) , [2] = GRM.L ( "When you are ready to Promote the players, press the Hot-Key {name} {num} times to complete all actions" , "|CFF00CCFF" .. GRM_G.MacroHotKey .. "|r" , nil , count ) , [3] = GRM.L ( "When you are ready to Demote the players, press the Hot-Key {name} {num} times to complete all actions" , "|CFF00CCFF" .. GRM_G.MacroHotKey .. "|r" , nil , count ) }

    if count == 1 then
        return singularEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition];
    else
        return pluralEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition];
    end
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
        GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].isHighlighted = false;
    end
end

-- Method:          GRM.BuildKickMacrodScrollButtons ( int , boolean )
-- What it Does:    Initiates the buttons and their values for each line of the Macrod window of the GRM kick tool's hybridscrollframe
-- Purpose:         Create a smooth scrolling experience in the GRM kick window
GRM.BuildKickMacrodScrollButtons = function ( ind , isResizeAction )
    local coreButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][2];
    local buttonText2 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][3];
    local buttonText3 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][4];

    -- Name
    buttonText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Actions don't need to be run more than once.
    if not isResizeAction then

        buttonText1:SetPoint ( "LEFT" , coreButton , "LEFT" , 5 , 0 );
        buttonText1:SetJustifyH ( "LEFT" );
        buttonText1:SetWidth ( 146 )
        buttonText1:SetWordWrap ( false );

        buttonText2:SetPoint ( "LEFT" , buttonText1 , "RIGHT" , 5 , 0 );
        buttonText2:SetJustifyH ( "LEFT" );
        buttonText2:SetWidth ( 150 );
        buttonText2:SetWordWrap ( false );

        buttonText3:SetPoint ( "RIGHT" , coreButton , "RIGHT" , -20 , 0 );
        buttonText3:SetJustifyH ( "RIGHT" );
        buttonText3:SetWordWrap ( false );

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
            if string.find ( playerName , "-" , 1 , true ) == nil then
                playerName = playerName .. "-" .. GRM_G.realmName;
            end
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
                        if GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].name == playerName then

                            if not GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].isHighlighted then
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1]:LockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].isHighlighted = true;
                            else
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.AllButtons[ind][1]:UnlockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.MacroEntries[i].isHighlighted = false;
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
        end);

        coreButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

    end
end

-------------------------
-- Ignored List Window --
-------------------------

-- Method:          GRM.HowManySafeListsIsPlayerOn ( player )
-- What it Does:    Returns true of the player is on the safe list of
-- Purpose:         UI control on the mouseover button tooltip 
GRM.HowManySafeListsIsPlayerOn = function ( player )
    local c = 0;

    for _ , safeList in pairs ( player.safeList ) do
        if safeList[1] then
            c = c + 1;
        end
    end

    return c;
end

-- Method:          GRM.IsAnyIgnoredHighlighted()
-- What it Does:    It scans through the Ignored List and reports true if any are selected and the number of selected
-- Purpose:         To adjust the text statement of the button.
GRM.IsAnyIgnoredHighlighted = function()
    local result = false;
    local count = 0;

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries do
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].isHighlighted then
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
            if c > 0 and GRM.S().ignoreFilter then
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
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].isHighlighted = false;
    end
end

-- Method:          GRM.GetIgnoredEntries ()
-- What it Does:    Determines which grouping to import
-- Purpose:         Proper sorting of players in the guild to be added to the GRM Tool
GRM.GetIgnoredEntries = function ()
    local result = {};
    if GRM.S().ignoreFilter then
        result = GRM.GetOnlySafePlayersWithIgnoredAction();
    else
        result = select ( 2 , GRM.GetSafePlayers ( true ) );
        
        -- Now, see if we need to add a reason.
        for i = 1 , #GRM_UI.GRM_ToolCoreFrame.Safe do
            for j = 1 , #result do
                if result[j].name == GRM_UI.GRM_ToolCoreFrame.Safe[i].name then
                    result[j].reason = GRM_UI.GRM_ToolCoreFrame.Safe[i].reason;
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
    local guildData = GRM.GetGuild();
    local player;
    local rule = GRM_UI.ruleTypeEnum2[GRM_UI.GRM_ToolCoreFrame.TabPosition];

    -- We need to scan and find all the entries, then find them in the guild
    for i = #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries , 1 , -1 do

        -- First check if it is highlighted
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].isHighlighted then

            -- Now scan through the roster and update.
            player = guildData[ GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].name ];

            if player then
                player.safeList[rule][1] = false;
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
    local guildData = GRM.GetGuild();
    local rule = GRM_UI.ruleTypeEnum2[GRM_UI.GRM_ToolCoreFrame.TabPosition];
    local count = 0;

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.safeList[rule][1] then
                player.safeList[rule][1] = false;
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
            GRM_UI.GRM_MemberDetailMetaData.GRM_SafeFromRulesButton:SetChecked ( false );
        end
    end
end

-- Method:          GRM.GetNumIgnored()
-- What it Does:    Returns the count of total ignored people
-- Purpose:         To determine the number ignored for UI purposes.
GRM.GetNumIgnored = function()
    local guildData = GRM.GetGuild();
    local rule = GRM_UI.ruleTypeEnum2[GRM_UI.GRM_ToolCoreFrame.TabPosition];
    local count = 0;

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.safeList[rule][1] then
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
    local guildData = GRM.GetGuild();
    local rule = GRM_UI.ruleTypeEnum2[GRM_UI.GRM_ToolCoreFrame.TabPosition];
    local result = false;

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if player.safeList[rule][1] then
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
        result[i] = {};
        result[i].name = GRM_UI.GRM_ToolCoreFrame.Safe[i].name;
        result[i].class = GRM_UI.GRM_ToolCoreFrame.Safe[i].class;
        result[i].isHighlighted = false;
        result[i].reason = GRM_UI.GRM_ToolCoreFrame.Safe[i].reason;
        result[i].rankIndex = GRM_UI.GRM_ToolCoreFrame.Safe[i].rankIndex;
        result[i].lastOnline = GRM_UI.GRM_ToolCoreFrame.Safe[i].lastOnline;
    end
    return result;
end

-- Method:          GRM.SetIgnoredValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Quality of life feature.
GRM.SetIgnoredValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind];
    local colors = GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2].class;
    -- Player Name
    line[2]:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2].name );
    line[2]:SetTextColor ( colors[1] , colors[2] , colors[3] , 1 );
    if #GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2].reason > 0 then
        line[3]:SetText ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2].reason );
        line[3]:SetTextColor ( 1.0 , 0.84 , 0 , 1 );
    else
        line[3]:SetText ( "None" );
        line[3]:SetTextColor ( 0 , 0.77 , 0.063 , 1 );
    end

    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[ind2].isHighlighted then
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
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k].name == name then
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k].isHighlighted then
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
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k].name == name then
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[k].isHighlighted then
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
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].name == playerName then
            index = i;
            if GRM_G.playerRankID >= GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].rankIndex then
                rankRestrictText = GRM.GetReasonIgnoredMsg ( GRM_G.playerRankID , GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].rankIndex );
            end
            break;
        end
    end

    if string.find ( reason , GRM.L ( "Kick" ) , 1 , true ) then
        atLeastOne = true;
        
        if index ~= nil then
            lastOnline = GRM.HoursReport ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[index].lastOnline );
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
    
        GameTooltip:AddLine ( " " );    -- adds a small space between the lines
        GameTooltip:AddLine ( GRM.L ( "|CFFE6CC7FClick|r to Select for Removal" ) );
        GameTooltip:AddLine ( GRM.L ( "{custom1} to open Player Window" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Click" ) .. "|r" ) );
        GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FCtrl-Shift-Click|r to Search the Log for Player" ) );
        GameTooltip:Show();
    end

end

-- Method:          GRM.TriggerIgnoredQueuedWindowRefresh()
-- What it Does:    Refreshes the GRM Tool's Ignored window after hiding the tooltip
-- Purpose:         Prevent code bloat for something with repeated use.
GRM.TriggerIgnoredQueuedWindowRefresh = function()
    GRM_UI.RestoreTooltipScale();
    GameTooltip:Hide();
    
    if GRM.S().ignoreFilter then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolCoreIgnoreCheckButton:SetChecked( true );
    end

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_IgnoreListRuleTypeText:SetText ( GRM_UI.ruleTypeEnum3[GRM_UI.GRM_ToolCoreFrame.TabPosition] );

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
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries = GRM.GetIgnoredEntries ();
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
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" )
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
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].name == playerName then

                            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].isHighlighted then
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][1]:LockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].isHighlighted = true;
                            else
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.GRM_ToolIgnoredScrollChildFrame.AllButtons[ind][1]:UnlockHighlight();
                                GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame.AllIgnoredEntries[i].isHighlighted = false;
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
            GRM.RestoreTooltip();
        end);
    end
end

-----------------------------------
--------- RULES SCROLLFRAME -------
-----------------------------------

-- Method:          GRM.GetRulesCount( integer )
-- What it Does:    Returns the number of rules that already exist
-- purpose:         So it can be determined with rule number is being added
GRM.GetRulesCount = function ( RulesType )
    local count = 0;

    for _ in pairs ( GRM.S()[GRM_UI.ruleTypeEnum[RulesType]] ) do
        count = count + 1;
    end

    return count;
end

-- Method:          GRM.RemoveRuleButtonLogic ( string , string )
-- What it Does:    Removes the given rule
-- Purpose:         Control over adding and removing rules.
GRM.RemoveRuleButtonLogic = function ( ruleType , name )
    local typeEnum = { ["kickRules"] = 1 , ["promoteRules"] = 2 , ["demoteRules"] = 3 };
    local epochTime = time();
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
    GRM.AdjustRuleNumbers ( name , ruleType , GRM.S()[ruleType][name].ruleIndex );
    -- GRM.AddToRemovedRules ( ruleType , name , GRM.S()[ruleType][name] , epochTime , nil );
    -- Send message out to remove the rule
    -- GRM.SendRuleRemove ( typeEnum[ruleType] , name , epochTime , GRM_G.addonUser , true );
    GRM.S()[ruleType][name] = nil;
    GRM_UI.FullMacroToolRefresh();
end

-- Method:          GRM.AdjustRuleNumbers ( string , string , int )
-- What it Does:    Adjusts the given rule number
-- Purpose:         Auto-adjust the rule numbers when deleting to keep them properly sorted
GRM.AdjustRuleNumbers = function ( name , ruleType , number )
    for ruleName , rule in pairs ( GRM.S()[ruleType] ) do
        if ruleName ~= name and rule.ruleIndex > number then
            rule.ruleIndex = rule.ruleIndex - 1;
        end
    end
    -- for ruleName , rule in pairs ( GRM_G.MacroRuleSyncFormat[ruleType] ) do
    --     if ruleName ~= name and rule.ruleIndex > number then
    --         rule.ruleIndex = rule.ruleIndex - 1;
    --     end
    -- end
end

-- -- Method:          GRM.AddToRemovedRules ( string , string , table , int , string )
-- -- What it Does:    Adds the rule to the removedRules and then adds the timestamp this occurred
-- -- Purpose:         To keep track of what rules have been removed.
-- GRM.AddToRemovedRules = function ( ruleType , name , rule , epochTime , removedBy )
--     local remover = removedBy or GRM_G.addonUser;
--     local rule = GRM.ConvertMacroRuleToString ( rule , ruleType )
--     GRM.S().removedMacroRules[ ruleType ][name] = { epochTime , remover , rule };
-- end

-- Method:          GRM.GetKickRule()
-- What it Does:    Returns the given rule by name
-- Purpose:         To easily be able to edit the existing rule
GRM.GetKickRule = function ( name )
    return GRM.DeepCopyArray ( GRM.S()["kickRules"][name] );
end

-- Method:          GRM.GetPromoteRule()
-- What it Does:    Returns the given rule by name
-- Purpose:         To easily be able to edit the existing rule
GRM.GetPromoteRule = function ( name )
    return GRM.DeepCopyArray ( GRM.S()["promoteRules"][name] );
end

-- Method:          GRM.GetDemoteRule()
-- What it Does:    Returns the given rule by name
-- Purpose:         To easily be able to edit the existing rule
GRM.GetDemoteRule = function ( name )
    return GRM.DeepCopyArray ( GRM.S()["demoteRules"][name] );
end

-- Method:          GRM.ChangeRuleName ( string , string , string )
-- What it Does:    Copies the old rule and sets the new one.
-- Purpose:         Allow the editing of the rule names
GRM.ChangeRuleName = function ( ruleType , newName , oldName )
    GRM.S()[ruleType][newName] = GRM.DeepCopyArray ( GRM.S()[ruleType][oldName] );
    GRM.S()[ruleType][newName].name = newName;
    GRM.S()[ruleType][oldName] = nil;
end

-- Method:          GRM.GetMacroRuleGUID ( table )
-- What it Does:    Builds an integer value for GUID, stores it as a string.
-- Purpose:         Building a unique GUID for the rule will allow easier syncing on the rule between players without needing to cross check all values
GRM.GetMacroRuleGUID = function ( rule )
    return tostring ( GRM.ConvertStringToVal ( rule.name ) + rule.editTime ); -- Just tyake byte value of name + epoch time. Will always be unique
end

-- Method:          GRM.BuildNewKickRuleTemplate( string , int )
-- What it Does:    Creates a new rules template to be added on confirmation
-- Purpose:         To easily add new rules.
GRM.BuildNewKickRuleTemplate = function( name , num )
    local ruleNumber = num or GRM.GetRulesCount( 1 ) + 1;
    local ruleName = "";
    local nameSet = false;

    if name ~= nil then
        ruleName = name;
    else
        local tempNum = ruleNumber;

        while not nameSet do
            ruleName = GRM.L ( "{name}'s Kick Rule {num}" , GRM.SlimName ( GRM_G.addonUser ) , nil , tempNum );
            if GRM.S()["kickRules"][ruleName] ~= nil then
                tempNum = tempNum + 1;
            else
                nameSet = true;
            end
        end
    end
    local result = {};

    result.name = ruleName
    result.isEnabled = true;

    result.applyRulesTo = 1;                -- All = 1 , Alts = 2 , Mains = 3

    result.activityFilter = true;
    result.isMonths = true;
    result.numDaysOrMonths = 12;
    result.allAltsApplyToKick = true;

    result.rankFilter = false;
    result.ranks = {};

    result.levelFilter = false;
    result.levelRange = { 1 , 999 };

    result.noteMatch = false;
    result.noteMatchEmpty = false;
    result.notesToCheck = { true , true , true };   -- Public , Officer, Custom
    result.matchingString = "";
    
    result.rankSpecialIsMonths = true;
    result.rankSpecialNumDaysOrMonths = 12;
    
    result.repFilter = false;
    result.repOperator = 2
    result.rep = 4;            -- 4 = neutral

    result.customLog = false;
    result.customLogMsg = "";
    result.ruleIndex = ruleNumber;
    result.editTime = 0;
    result.sync = true;
    result.createdBy = { GRM_G.addonUser , select ( 2 , UnitClass ("PLAYER") ) };
    result.safeText = "";
    result.safeMatch = false;
    result.GUID = "";

    result.applyEvenIfActiive = false;  -- Unique rule to kicks

    return result , ruleName;
end

-- Method:          GRM.BuildNewPromoteOrDemoteRuleTemplate( string , int )
-- What it Does:    Creates a new rules template to be added on confirmation
-- Purpose:         To easily add new rules.
GRM.BuildNewPromoteOrDemoteRuleTemplate = function ( name , num , tabPosition )
    local ruleName = "";
    local nameSet = false;
    local position = tabPosition or GRM_UI.GRM_ToolCoreFrame.TabPosition;
    local ruleNumber = num or GRM.GetRulesCount( position ) + 1;
    local ruleNameString = { [2] = "{name}'s Promote Rule {num}" , [3] = "{name}'s Demote Rule {num}" };
    local ruleType = { [2] = 2 , [3] = 3 }; -- localize it, I know it seems redundant,

    if name ~= nil then
        ruleName = name;
    else
        local tempNum = ruleNumber;
        while not nameSet do 
            ruleName = GRM.L ( ruleNameString[position] , GRM.SlimName ( GRM_G.addonUser ) , nil , tempNum );
            if GRM.S()[GRM_UI.ruleTypeEnum[position]][ruleName] ~= nil then
                tempNum = tempNum + 1;
            else
                nameSet = true;
            end
        end
    end
    local result = {};

    -- Activity Filters

    result.name = ruleName
    result.isEnabled = true;
    result.ruleType = ruleType[position];

    result.applyRulesTo = 1;                -- All = 1 , Alts = 2 , Mains = 3

    result.activityFilter = true;
    result.isMonths = true;
    result.numDaysOrMonths = 12;
    result.allAltsApplyToKick = true;
    if position == 2 then
        result.sinceAtRank = true;
    end

    result.rankFilter = true;
    result.ranks = {};

    result.levelFilter = false;
    result.levelRange = { 1 , 999 };    

    result.noteMatch = false;
    result.noteMatchEmpty = false;
    result.notesToCheck = { true , true , true };   -- Public , Officer, Custom
    result.matchingString = "";

    result.rankSpecialIsMonths = true;
    result.rankSpecialNumDaysOrMonths = 3;
    
    result.repFilter = false;
    result.repOperator = 2
    result.rep = 4;            -- 4 = neutral

    result.customLog = false;
    result.customLogMsg = "";
    result.ruleIndex = ruleNumber;
    result.editTime = 0;
    result.sync = true;
    result.createdBy = { GRM_G.addonUser , select ( 2 , UnitClass ("PLAYER") ) };
    result.safeText = "";
    result.safeMatch = false;
    result.GUID = "";

    -- Unique rules to demote and promote
    result.destinationRank = GuildControlGetNumRanks() - 1;     -- Default is 1st to last lowest rank;
    if position == 2 then
        result.regardlessOfActivity = false;
    end

    return result , ruleName;
end
-- Edited By???
-- Method:          GRM.ValidateRule ( table )
-- What it does:    Returns true of the rule contains all of the expected variables in their proper form.
-- Purpose:         To ensure integrity of the rules.
GRM.ValidateRule = function ( rule , ruleType )
    local isValid = true;
    local missingValues = {};
    local ruleFilters = { "ruleType" , "destinationRank" , "regardlessOfActivity"  , "applyEvenIfActiive", "name" , "isEnabled" , "applyRulesTo" , "activityFilter" , "isMonths" , "numDaysOrMonths" , "allAltsApplyToKick" , "rankSpecialIsMonths" , "rankSpecialNumDaysOrMonths" , "rankFilter" , "ranks" , "levelFilter" , "levelRange" , "noteMatch" , "noteMatchEmpty" , "notesToCheck" , "matchingString" , "repFilter" , "repOperator" , "rep" , "customLog" , "customLogMsg" , "ruleIndex" , "editTime" , "sync" , "createdBy" , "sinceAtRank" , "safeText" , "GUID" , "safeMatch" };

    if not rule then
        isValid = false;
        missingValues = ruleFilters;
    end

    if isValid then
        for i = 1 , #ruleFilters do
            isValid = true;
            if rule[ruleFilters[i]] == nil then
                if i < 4 then
                    if ruleType > 1 then
                        if i == 3 then
                            if ruleType == 2 then
                                isValid = false;
                            end
                        else
                            isValid = false;
                        end
                    end
                elseif i == 4 then
                    if ruleType == 1 then
                        isValid = false
                    end

                elseif i == 31 then
                    if ruleType == 2 then
                        isValid = false;
                    end
                else
                    isValid = false
                end

                if not isValid then
                    table.insert ( missingValues , ruleFilters[i] );
                end
            end
        end
    end
    
    if #missingValues > 0 then
        isValid = false;
    end

    return isValid , missingValues;
end

-- Method:          GRM.RuleIntegrityCheck()
-- What it Does:    Scans through all the rules for the macro tool of a player and reports anything wrong and removes the rule
-- Purpose:         Prevent lua errors and maintain integrity of the macro rules.
GRM.RuleIntegrityCheck = function()
    local isValid = false;
    local missingValues = {};

    local getMissing = function ( missingV )
        local missing = "";
        for i = 1 , #missingV do
            if i < #missingV then
                missing = missing .. missingV[i] .. ", ";
            else
                missing = missing .. missingV[i];
            end
        end
        return missing;
    end

    for i = 1 , 3 do
        for name , rule in pairs ( GRM.S()[GRM_UI.ruleTypeEnum[i]] ) do
            isValid , missingValues = GRM.ValidateRule ( rule , i );

            if not isValid then
                GRM.S()[GRM_UI.ruleTypeEnum[i]][name] = nil;
            end

        end
    end
end

-- Method:          GRM.IsAnyInTableEnabled ( table )
-- What it Does:    Takes a boolean 1D array and returns true as long as one value in the array is true
-- Purpose:         Universal use for multi table checks on the custom rules window
GRM.IsAnyInTableEnabled = function( givenTable )
    for i = 1 , #givenTable do
        if givenTable[i] then
            return true;
        end
    end

    return false;
end

-- Method:          GRM.AreAllEnabled( table )
-- What it Does:    If any of the results are NOT enabled it returns false
-- Purpose:         UX controls for the custom rules
GRM.AreAllEnabled = function ( givenTable )
    for i = 1 , #givenTable do
        if not givenTable[i] then
            return false;
        end
    end

    return true;
end

GRM.IsRuleReady = function()
    local result = true;

    -- Name must be valid
    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name == "" then
        result = false;
        GRM.Report ( GRM.L ( "Please Set a Name for this Rule. It can be 1 to 25 characters in length." ) );
    end
    -- Rank filter rule check
    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter then
        if GRM.IsAnyInTableEnabled( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks ) then
            if GRM.AreAllEnabled ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.ranks ) then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankFilter = false;      -- No need to set the rank filter as enabled if all ranks are being checked.
            end
        else
            result = false;
            GRM.Report ( GRM.L ( "Please select at least 1 RANK to apply this rule to." ) );
        end
    end

    if result then

        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelFilter then
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[1] == 1 and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelRange[2] == 999 then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.levelFilter = false;     -- No need to check a range if it already fits the range.
            end
        end

        -- If no string is set just disable this feature.
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch then
            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatchEmpty and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString == "" then
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch = false;
            end
        end

    end

    return result;
end

-- Method:          GRM.RulesIntegrityCheck ( int )
-- What it Does:    Does a quick integrity check on the rule makes sure it is good for us. This will be expanded upon
-- Purpose:         Ensure integrity of data due to syncing.
GRM.RulesIntegrityCheck = function ( ruleType )
    for _ , rule in pairs ( GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]] ) do
        if rule.createdBy[1] == "" then
            rule.createdBy = { GRM_G.addonUser , select ( 2 , UnitClass ("PLAYER") ) };
        end
    end
end

-- Method:          GRM.GetRuleEntries ( int )
-- What it Does:    Determines which rule grouping to import
-- Purpose:         Proper sorting of players in the guild to be added to the mass kick tool
GRM.GetRuleEntries = function ( ruleType )
    local result = {};
    local tempTable = {};

    GRM.RulesIntegrityCheck ( ruleType );

    if ruleType == 1 then
        tempTable = GRM.DeepCopyArray ( GRM.S().kickRules );
    elseif ruleType == 2 then
        tempTable = GRM.DeepCopyArray ( GRM.S().promoteRules );
    elseif ruleType == 3 then
        tempTable = GRM.DeepCopyArray ( GRM.S().demoteRules );
    end

    for _ , rule in pairs ( tempTable ) do
        table.insert ( result , rule );
    end
    sort ( result , function ( a , b ) return a.ruleIndex < b.ruleIndex end );

    return result;
end

-- Method:          GRM.ClearRuleHighlights()
-- What it Does:    Clears the highlights when loading and refreshing the rules each time it is edited.
-- Purpose:         Clean UX
GRM.ClearRuleHighlights = function()
    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons do
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][3] = false;
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][1]:UnlockHighlight();
    end
end

-- Method:          GRM.ClearRuleHighlightsButGiven ( frame )
-- What it Does:    Clears the highlights of all the buttons that were NOT clicked
-- Purpose:         Clean UX
GRM.ClearRuleHighlightsButGiven = function( button )
    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons do
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][1] ~= button then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][3] = false;
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][1]:UnlockHighlight();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][3] = true;
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][1]:LockHighlight();
        end
    end
end

-- Method:          GRM.IsRuleHighlighted()
-- What it Does:    Returns true if any of the rules are highlighted
-- purpose:         UX controls
GRM.IsRuleHighlighted = function()
    local result = false;
    local ruleName = "";

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons do
        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][3] then
            ruleName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][2]:GetText();
            result = true;
            break;
        end
    end

    return result , ruleName;
end

-- Method:          GRM.ShiftRuleUp ( string )
-- What it Does:    As it says, shifts the rule up in the rule list
-- Purpose:         Custom organization of the rules list
GRM.ShiftRuleUp = function ( ruleName )
    local ruleData = GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]];
    ruleData[ruleName].ruleIndex = ruleData[ruleName].ruleIndex - 1;
    local ruleType = GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition];

    for name , rule in pairs ( ruleData ) do
        if ruleName ~= name and rule.ruleIndex == ruleData[ruleName].ruleIndex then
            rule.ruleIndex = rule.ruleIndex + 1;
            break;
        end
    end

    -- GRM_G.MacroRuleSyncFormat[ruleType][ruleName].ruleIndex = tonumber ( ruleData[ruleName].ruleIndex );

    -- for name , rule in pairs ( GRM_G.MacroRuleSyncFormat[ruleType] ) do
    --     if ruleName ~= name and rule.ruleIndex == ruleData[ruleName].ruleIndex then
    --         rule.ruleIndex = rule.ruleIndex + 1;
    --         break;
    --     end
    -- end
    GRM_UI.FullMacroToolRefresh();
end

-- Method:          GRM.ShiftRuleDown( string )
-- What it Does:    As it says, shifts the rule up in the rule list
-- Purpose:         Custom organization of the rules list
GRM.ShiftRuleDown = function ( ruleName )
    local ruleData = GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]];
    -- Increment up by 1
    ruleData[ruleName].ruleIndex = ruleData[ruleName].ruleIndex + 1;
    local ruleType = GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition];

    for name , rule in pairs ( ruleData ) do
        if ruleName ~= name and rule.ruleIndex == ruleData[ruleName].ruleIndex then
            rule.ruleIndex = rule.ruleIndex - 1;
            break;
        end
    end
    -- GRM_G.MacroRuleSyncFormat[ruleType][ruleName].ruleIndex = tonumber ( ruleData[ruleName].ruleIndex );

    -- for name , rule in pairs ( GRM_G.MacroRuleSyncFormat[ruleType] ) do
    --     if ruleName ~= name and rule.ruleIndex == ruleData[ruleName].ruleIndex then
    --         rule.ruleIndex = rule.ruleIndex - 1;
    --         break;
    --     end
    -- end
    GRM_UI.FullMacroToolRefresh();
end

-- Method:          GRM.BuildRuleButtons ( int , boolean , int )
-- What it Does:    Initiates the buttons and their values for each line of the Rules window of the GRM macro tool's hybridscrollframe
-- Purpose:         Create a smooth scrolling experience in the GRM macro tool window
GRM.BuildRuleButtons = function ( ind , isResizeAction , buttonWidth )
    local coreButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][2];
    local checkButton = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][4];
    local buttonDown = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][5];
    local buttonUp = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][6];

    buttonText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );

    -- Actions don't need to be run more than once.
    if not isResizeAction then

        checkButton:SetPoint ( "LEFT" , coreButton , "LEFT" , 5 , 0 );
        checkButton:SetHitRectInsets ( 0 , 0 , 0 , 0 );

        buttonText1:SetPoint ( "LEFT" , checkButton , "RIGHT" , 5 , 0 );
        buttonText1:SetJustifyH ( "LEFT" );
        buttonText1:SetWidth ( buttonWidth - 35 )
        buttonText1:SetWordWrap ( false );
        
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

        coreButton:SetScript ( "OnMouseDown" , function ( self , button )
            local ruleName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][2]:GetText();
            if button == "RightButton" then

                -- Set the Button Logic
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1:SetScript ( "OnClick" , function()
                    local validToOpen = true;

                    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then

                        if not CanGuildRemove() then
                            validToOpen = false;
                            GRM.Report ( GRM.L ( "Unable to remove players from the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                        else
                            GRM_UI.ConfigureCustomRuleKickFrame ( true , ruleName );
                        end
    
                    elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                        if not CanGuildPromote() then
                            validToOpen = false;
                            GRM.Report ( GRM.L ( "Unable to promote players within the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                        else
                            GRM_UI.ConfigureCustomRulePromoteAndDemoteFrame ( true , ruleName );
                        end
                        
                    elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                        if not CanGuildDemote() then
                            validToOpen = false;
                            GRM.Report ( GRM.L ( "Unable to demote players within the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                        else
                            GRM_UI.ConfigureCustomRulePromoteAndDemoteFrame ( true , ruleName );
                        end
    
                    end
                    if validToOpen then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Show();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
                    end
                end);
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2:SetScript ( "OnClick" , function()
                    GRM.RemoveRuleButtonLogic ( GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition] , ruleName );
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:IsVisible() and GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.name == ruleName then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Hide();
                    end
                end);

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3:SetScript ( "OnClick" , function()
                    local validToOpen = true;

                    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then

                        if not CanGuildRemove() then
                            validToOpen = false;
                            GRM.Report ( GRM.L ( "Unable to remove players from the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                        else
                            GRM_UI.ConfigureCustomRuleKickFrame ( true , ruleName , true );
                        end
    
                    elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
                        if not CanGuildPromote() then
                            validToOpen = false;
                            GRM.Report ( GRM.L ( "Unable to promote players within the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                        else
                            GRM_UI.ConfigureCustomRulePromoteAndDemoteFrame ( true , ruleName , true );
                        end
                        
                    elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
                        if not CanGuildDemote() then
                            validToOpen = false;
                            GRM.Report ( GRM.L ( "Unable to demote players within the guild at current rank." ) .. " " .. GRM.L ( "Feature disabled." ) );
                        else
                            GRM_UI.ConfigureCustomRulePromoteAndDemoteFrame ( true , ruleName , true );
                        end
    
                    end
                    if validToOpen then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:Show();
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
                    end
                end);

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:ClearAllPoints();
                GRM.ClearRuleHighlightsButGiven ( self );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:SetPoint ( "BOTTOMRIGHT" , self , "TOPLEFT" , 0 , -2 );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton1.GRM_ContextButton1Text:SetText ( GRM.L ( "Edit" ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton2.GRM_ContextButton2Text:SetText ( GRM.L ( "Remove" ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu.GRM_ContextButton3.GRM_ContextButton3Text:SetText ( GRM.L ( "Copy" ) );
                GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Show();
                GRM_UI.RestoreTooltipScale();
                GameTooltip:Hide();
            end
        end);            

        coreButton:SetScript ( "OnEnter" , function ()
            GRM.UpdateRulesTooltip( ind );
        end);

        coreButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        local refreshTooltip = function( anchor )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( anchor , "ANCHOR_CURSOR" );

            if anchor:GetChecked() then
                GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r to Disable Rule" ) );
            else
                GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r to Enable Rule" ) );
            end
            GameTooltip:Show();
        end

        checkButton:SetScript ( "OnClick" , function( self , button )
            if button == "LeftButton" then
                local ruleName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][2]:GetText();
                if self:GetChecked() then
                    GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][ruleName].isEnabled = true;
                    refreshTooltip( self );
                else
                    GRM.S()[GRM_UI.ruleTypeEnum[GRM_UI.GRM_ToolCoreFrame.TabPosition]][ruleName].isEnabled = false;
                    refreshTooltip( self );
                end
                GRM_UI.FullMacroToolRefresh();
            end
        end);

        checkButton:SetScript ( "OnEnter" , function ( self )
            refreshTooltip( self );
        end);

        checkButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        buttonDown:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM.ShiftRuleDown ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][2]:GetText() );
            end
        end);

        buttonUp:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM.ShiftRuleUp ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][2]:GetText() );
            end
        end);

    end
end

-- Method:          GRM.BuildRulesScrollFrame( bool , bool )
-- What it Does:    Updates the Rules scrollframe as needed
-- Purpose:         UX of the GRM mass kick tool
GRM.BuildRulesScrollFrame = function ( showAll , fullRefresh )
    local hybridScrollFrameButtonCount = 8;
    local buttonHeight = 22;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame:GetWidth() - 5;

    if showAll and fullRefresh then
        GRM_UI.GRM_ToolCoreFrame.RuleEntries = GRM.GetRuleEntries ( GRM_UI.GRM_ToolCoreFrame.TabPosition );
    end

    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons or {};
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset or ( hybridScrollFrameButtonCount );

    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset < hybridScrollFrameButtonCount then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset = hybridScrollFrameButtonCount;
    elseif GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset > hybridScrollFrameButtonCount and GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset > #GRM_UI.GRM_ToolCoreFrame.RuleEntries then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset = #GRM_UI.GRM_ToolCoreFrame.RuleEntries;
    end

    for i = 1 , #GRM_UI.GRM_ToolCoreFrame.RuleEntries do
        -- Build HybridScrollFrame Buttons
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i] then

                local button = CreateFrame ( "Button" , "RuleButton" .. i , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame );
                local checkButton = CreateFrame ( "Checkbutton" , "RuleCheckButton" , button , GRM_G.CheckButtonTemplate );
                local buttonUp = CreateFrame ( "Button" , "RuleButtonUp" .. i , button , "UIPanelScrollUpButtonTemplate" );
                local buttonDown = CreateFrame ( "Button" , "RuleButtonDown" .. i , button , "UIPanelScrollDownButtonTemplate" );

                GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i] = {
                    button ,
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),
                    false,
                    checkButton,
                    buttonDown,
                    buttonUp
                };

                -- Configure the button
                button = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][1];
                if i == 1 then
                    button:SetPoint ( "TOP" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame , "TOP" , 7 , 0 );
                else 
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                button:SetHighlightTexture ( "Interface\\Buttons\\UI-Panel-Button-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );

                -- Configure the up and down sorting buttons
                buttonDown = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][5];
                buttonUp = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][6];

                buttonDown:SetPoint ( "RIGHT" , button , "RIGHT" , -5 , 0 );
                buttonDown:SetSize ( 15 , 15 );
                buttonUp:SetPoint ( "RIGHT" , buttonDown , "LEFT" , -5 , 0 );
                buttonUp:SetSize ( 15 , 15 );

                GRM.BuildRuleButtons ( i  , false , buttonWidth );
                
            end
        end

        if i >= ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset - hybridScrollFrameButtonCount + 1 ) and i <= GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset then
            GRM.SetRuleValues ( i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset - hybridScrollFrameButtonCount ) , i );
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i - ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset - hybridScrollFrameButtonCount )][1]:Show();
        end
        
        -- Slider Height is controlled by tallying how many of these are necessary
        scrollHeight = scrollHeight + buttonHeight;
    end

    -- Hide unused buttons...
    for i = #GRM_UI.GRM_ToolCoreFrame.RuleEntries + 1 , #GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons do
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[i][1]:Hide();
    end

    GRM.SetHybridScrollFrameSliderParameters ( 
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrame , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder, 
        buttonWidth , buttonHeight , scrollHeight , #GRM_UI.GRM_ToolCoreFrame.RuleEntries , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons , 
        GRM.KickRulesHybridShiftDown , GRM.KickRulesHybridShiftUp , hybridScrollFrameButtonCount
    );

    if #GRM_UI.GRM_ToolCoreFrame.RuleEntries > 8 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:Show();
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollFrameSilder:Hide();
    end

    GRM.ClearRuleHighlights();

end

-- Method:          GRM.SetRuleValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Quality of life feature.
GRM.SetRuleValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind];

    -- Player Name
    line[2]:SetText ( GRM_UI.GRM_ToolCoreFrame.RuleEntries[ind2].name );
    if GRM_UI.GRM_ToolCoreFrame.RuleEntries[ind2].isEnabled then
        line[4]:SetChecked ( true );
    else
        line[4]:SetChecked ( false );
    end

    -- Up and down buttons - first one only down needs to be seen.
    if ind2 == 1 and ind == 1 then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][6]:Hide();
        if #GRM_UI.GRM_ToolCoreFrame.RuleEntries > 1 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][5]:Show();
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][5]:Hide();
        end
    elseif ind2 == #GRM_UI.GRM_ToolCoreFrame.RuleEntries then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][5]:Hide();
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][5]:Show();
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][6]:Show();
    end
    
    -- Update the tooltip if underlying data changes
    if GameTooltip:IsVisible() and GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][1]:IsMouseOver() then 
        GRM.UpdateRulesTooltip ( ind );
    end
end

-- Method:          GRM.KickRulesHybridShiftDown()
-- What it Does:    Shifts all the values DOWN one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.KickRulesHybridShiftDown = function()
    if #GRM_UI.GRM_ToolCoreFrame.RuleEntries > 8 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons;
        local MouseOverButton = 0;

        -- Shift them down...
        for i = 1 , #buttons - 1 do

            -- Header Line
            buttons[i][2]:SetText( buttons[i+1][2]:GetText() );
            buttons[i][4]:SetChecked ( buttons[i+1][4]:GetChecked() );

            if buttons[i+1][5]:IsVisible() then
                buttons[i][5]:Show();
            else
                buttons[i][5]:Hide();
            end

            if buttons[i+1][6]:IsVisible() then
                buttons[i][6]:Show();
            else
                buttons[i][6]:Hide();
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:IsVisible() then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
            GRM.ClearRuleHighlights();
        end

        GRM.KickRulesSetLastValue();
        if MouseOverButton > 0 then
            GRM.UpdateRulesTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.KickRulesHybridShiftUp()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.KickRulesHybridShiftUp = function()
    if #GRM_UI.GRM_ToolCoreFrame.RuleEntries > 8 then
        local buttons = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons;
        local MouseOverButton = 0;

        for i = #buttons , 2 , -1 do

            buttons[i][2]:SetText( buttons[i-1][2]:GetText() );
            buttons[i][4]:SetChecked( buttons[i-1][4]:GetChecked() );

            if buttons[i-1][5]:IsVisible() then
                buttons[i][5]:Show();
            else
                buttons[i][5]:Hide();
            end

            if buttons[i-1][6]:IsVisible() then
                buttons[i][6]:Show();
            else
                buttons[i][6]:Hide();
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:IsVisible() then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolContextMenu:Hide();
            GRM.ClearRuleHighlights();
        end

        GRM.KickRulesSetFirstValue();
        if MouseOverButton > 0 then
            GRM.UpdateRulesTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.KickRulesSetLastValue()
-- What it Does:    Sets the last value of the hybridscrollframe backups at position 16
-- Purpose:         Clean scrolling
GRM.KickRulesSetLastValue = function()
    GRM.SetRuleValues ( #GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset );
end

-- Method:          GRM.KickRulesSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe backups at position 1
-- Purpose:         Clean scrolling
GRM.KickRulesSetFirstValue = function()
    GRM.SetRuleValues ( 1 , GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.Offset - #GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons + 1 );
end

-- Method:          GRM.GetRanksIncludedInFilter ( table )
-- What it Does:    Returns the name of all the ranks currently being filtered
-- Purpose:         Custom rule UX controls.
GRM.GetRanksIncludedInFilter = function( listOfRanks )
    local namedRanks = {};
    local num = 1;

    -- Don't need to include Guild Leader rank
    for i = GuildControlGetNumRanks() , 2 , -1 do
        if listOfRanks[num] then
            table.insert ( namedRanks , GuildControlGetRankName ( i ) );
        end
        num = num + 1;
    end

    return namedRanks;
end

-- Method:          GRM.UpdateRulesTooltip()
-- What it Does:    Sets the tooltip for the Queued scrollframe in the GRM kick tool
-- Purpose:         Make it clear the QoL controls.
GRM.UpdateRulesTooltip = function ( ind )
    local ruleName = GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][2]:GetText();
    local rule = {};
        if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then
            rule = GRM.GetKickRule ( ruleName );
        elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
            rule = GRM.GetPromoteRule ( ruleName );
        elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
            rule = GRM.GetDemoteRule ( ruleName );
        end
    local c = {};
    local time = "";
    c.E = { 0 , 0.77 , 0.063 }; -- enabled
    c.D = { 1 , 0 , 0 };        -- disabled
    local status = "";
    local statusColor = {};
    
    if rule.sync then
        status = GRM.L ( "Enabled" );
        statusColor = { 0 , 0.8 , 1 };
    else
        status = GRM.L ( "Disabled" );
        statusColor = c.D;
    end

    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollChildFrame.AllButtons[ind][1] , "ANCHOR_CURSOR" );
    GameTooltip:AddLine ( "|CFFE6CC7F" .. GRM.L ( "Rule Filter: {name}" , "|r" .. rule.name ) , 0 , 0.8 , 1 );
    GameTooltip:AddLine ( "|CFFE6CC7F" .. GRM.L ( "Created By: {name}" , "|r" .. GRM.GetClassColorRGB ( rule.createdBy[2] , true ) .. rule.createdBy[1] ) );
    GameTooltip:AddLine ( "|CFFE6CC7F" .. GRM.L ( "Sync: {name}" , "|r" .. status ) , statusColor[1] , statusColor[2] , statusColor[3] );
    GameTooltip:AddLine ( " " );

    if rule.applyRulesTo == 2 then
        GameTooltip:AddLine ( GRM.L ( "Alts Only" ) , 1 , 0 , 0 );
    elseif rule.applyRulesTo == 3 then
        GameTooltip:AddLine ( GRM.L ( "Mains Only" ) , 1 , 0 , 0 );
    end

    if GRM_UI.GRM_ToolCoreFrame.TabPosition > 1 then
        GameTooltip:AddDoubleLine ( GRM.L ( "Destination Rank:" ) , GuildControlGetRankName ( rule.destinationRank ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
    end

    if rule.activityFilter then
        if rule.isMonths then
            if rule.numDaysOrMonths == 1 then
                time = GRM.L ( "Month");
            else
                time = GRM.L ( "Months");
            end
        else
            if rule.numDaysOrMonths == 1 then
                time = GRM.L ( "Day");
            else
                time = GRM.L ( "Days");
            end
        end

        if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 or GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
            GameTooltip:AddDoubleLine ( GRM.L ( "Inactivity:" ) , GRM.L ( "Notify if inactive for {num} {name}" , time , nil , rule.numDaysOrMonths ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
        elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then
            if rule.sinceAtRank then
                GameTooltip:AddDoubleLine ( GRM.L ( "Time at Rank:" ) , GRM.L ( "Notify if at current rank for {num} {name}" , time , nil , rule.numDaysOrMonths ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
            else
                GameTooltip:AddDoubleLine ( GRM.L ( "Time in Guild:" ) , GRM.L ( "Notify if a member for at least {num} {name}" , time , nil , rule.numDaysOrMonths ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
            end
        end
    else
        if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 or GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then
            GameTooltip:AddDoubleLine ( GRM.L ( "Inactivity:" ) , GRM.L ( "Disabled" ) , 1 , 0.82 , 0 , c.D[1] , c.D[2] , c.D[3] );
        else
            GameTooltip:AddDoubleLine ( GRM.L ( "Time at Rank:" ) , GRM.L ( "Disabled" ) , 1 , 0.82 , 0 , c.D[1] , c.D[2] , c.D[3] );
        end
    end

    if rule.rankFilter then
        local listOfRanks = GRM.GetRanksIncludedInFilter( rule.ranks );
        local ranks = listOfRanks[1];
        for i = 2 , #listOfRanks do
            ranks = ranks .. ", " .. listOfRanks[i];
        end
        GameTooltip:AddDoubleLine ( GRM.L ( "Ranks:" ) , ranks , 1 , 0.82 , 0 , 1 , 1 , 1 );

        if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 or GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 ) and rule.applyEvenIfActiive then

            time = "";
            if rule.rankSpecialIsMonths then
                if rule.rankSpecialNumDaysOrMonths == 1 then
                    time = GRM.L ( "Month");
                else
                    time = GRM.L ( "Months");
                end
            else
                if rule.rankSpecialNumDaysOrMonths == 1 then
                    time = GRM.L ( "Day");
                else
                    time = GRM.L ( "Days");
                end
            end
            
            GameTooltip:AddDoubleLine (GRM.L ( "Time at Rank:" ) , GRM.L ( "Notify if at Rank for {num} {name}" , time , nil , rule.rankSpecialNumDaysOrMonths ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
        end
    else
        GameTooltip:AddDoubleLine ( GRM.L ( "Ranks:" ) , GRM.L ( "All Ranks" ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
    end

    if rule.levelFilter then
        local topLevel;
        if rule.levelRange[2] == 999 then
            topLevel = GRM_G.LvlCap;
        else
            topLevel = rule.levelRange[2];
        end
        GameTooltip:AddDoubleLine ( GRM.L ( "Level Range:" ) , GRM.L ( "{num} to {custom1}" , nil , nil , rule.levelRange[1] , topLevel ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
    else
        GameTooltip:AddDoubleLine ( GRM.L ( "Level Range:" ) , GRM.L ( "1 to {num}" , nil , nil , GRM_G.LvlCap ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
    end

    if GRM_G.BuildVersion >= 40000 then

        if rule.repFilter then
            local msg = "";
            if rule.repOperator == 1 then
                msg = GRM.L ( "Guild Rep lower than {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
            elseif rule.repOperator == 2 then
                msg = GRM.L ( "Guild Rep equal to {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
            elseif rule.repOperator == 3 then
                msg = GRM.L ( "Guild Rep higher than {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
            end

            GameTooltip:AddDoubleLine ( GRM.L ( "Guild Rep:" ) , msg , 1 , 0.82 , 0 , 1 , 1 , 1 );
        else
            GameTooltip:AddDoubleLine ( GRM.L ( "Guild Rep:" ) , GRM.L ( "Disabled" ) , 1 , 0.82 , 0 , c.D[1] , c.D[2] , c.D[3] );
        end
    end

    if rule.noteMatch then
        if not rule.noteMatchEmpty then
            GameTooltip:AddDoubleLine ( GRM.L ( "Note Match:" ) , "\"" .. rule.matchingString .. "\"" , 1 , 0.82 , 0 , 1 , 1 , 1 );
        else
            GameTooltip:AddDoubleLine ( GRM.L ( "Note Match:" ) , ( "<" .. GRM.L ( "Empty Notes" ) .. ">" ) , 1 , 0.82 , 0 , 1 , 1 , 1 );
        end
    else
        GameTooltip:AddDoubleLine ( GRM.L ( "Note Match:" ) , GRM.L ( "Disabled" ) , 1 , 0.82 , 0 , c.D[1] , c.D[2] , c.D[3] );
    end

    if rule.safeMatch then
        GameTooltip:AddDoubleLine ( GRM.L ( "Safe Text Match:" ) , "\"" .. rule.safeText .. "\"" , 1 , 0.82 , 0 , 1 , 1 , 1 );
    else
        GameTooltip:AddDoubleLine ( GRM.L ( "Safe Text Match:" ) , GRM.L ( "Disabled" ) , 1 , 0.82 , 0 , c.D[1] , c.D[2] , c.D[3] );
    end

    GameTooltip:AddLine ( " " );
    GameTooltip:AddLine ( "|CFFE6CC7F" .. GRM.L ( "Right-Click|r to Edit or Remove custom rule" ) );

    GameTooltip:Show();
end

------------------------------------------
------ Custom Rules UI Controls ----------

-- Method:          GRM.HasTimeExceededDate ( string , int )
-- What it Does:    Returns true if the player is ready for a rank change based on time passed
-- Purpose:         Scanning for changes on promotions and demotions
GRM.HasTimeExceededDate = function ( epochDate , hoursTilRecommend )
    local result = false;
   
    if math.floor ( ( time() - epochDate ) / 3600 ) >= hoursTilRecommend then
        result = true;
    end
    return result;
end

-- Method:          GRM.GetSingularOrPluralFormattingForMacroToolMsg ( bool , int , bool )
-- What it Does:    Returns the proper string before it is translated.
-- Purpose:         To handle plural and singular formats as a quality of life feature.
GRM.GetSingularOrPluralFormattingForMacroToolMsg = function ( isMonths , num , inactive )
    local choice = { "Player has been at rank for more than {num} Day" , "Player has been at rank for more than {num} Days" , "Player has been at rank for more than {num} Month" , "Player has been at rank for more than {num} Months" };
    local result = "";

    if isMonths then
        if num > 1 or num == 0 then
            result = choice[4];
        else
            result = choice[3];
        end
    else
        if num > 1 or num == 0 then
            result = choice[2];
        else
            result = choice[1];
        end
    end

    if inactive then
        result = "CFFFF0000( " .. GRM.L ( "Inactive" ) .. " )|r" .. result;
    end
    return result;
end

-- Method:          GRM.GetToolTipMessageForInGuildMessage ( bool , int , bool )
-- What it Does:    Returns the proper string before it is translated.
-- Purpose:         To handle plural and singular formats as a quality of life feature.
GRM.GetToolTipMessageForInGuildMessage= function ( isMonths , num , inactive )
    local choice = { "Player has been a member for more than {num} Day" , "Player has been a member for more than {num} Days" , "Player has been a member for more than {num} Month" , "Player has been a member for more than {num} Months" };
    local result = "";

    if isMonths then
        if num > 1 then
            result = choice[4];
        else
            result = choice[3];
        end
    else
        if num > 1 then
            result = choice[2];
        else
            result = choice[1];
        end
    end

    if inactive then
        result = "CFFFF0000( " .. GRM.L ( "Inactive" ) .. " )|r" .. result;
    end
    return result;
end

-- Method:          GRM.GetNamesByFilterRules()
-- What it Does:    Collects the names of all the players who match the given rule
-- Purpose:         Macro Tool use
GRM.GetNamesByFilterRules = function( ruleTypeIndex )
    local listOfPlayers = {};
    local ruleCount = ruleTypeIndex or GRM_UI.GRM_ToolCoreFrame.TabPosition;

    GRM_G.countAction[ruleCount] = time();
    
    -- No need to do all the work if there are no rules to check!
    if GRM.GetRulesCount ( ruleCount ) == 0 or GRM_G.guildName == "" or GRM_G.guildName == nil then -- the guildName thing is a redundancy that can occur due to lag, just protection against error.
        return listOfPlayers;
    end

    -- The name formatting is purely to be used for the macro to be added.
    
    local ruleConfirmedCheck = true
    local listOfPlayers , tempRuleCollection = {} , {};
    local macroAction = { [2] = "/gpromote" , [3] = "/gdemote" };
    local rankDestination = { [2] = GRM.L ( "Promote to Rank:" ) , [3] = GRM.L ( "Demote to Rank:" ) };
    local playerMatch = false;

    -- need to know if player can be promoted or demoted to destination rank, and how many rank moves they need to make to get there.
    local playerCanBeMoved = function ( playerRankIndex , destinationRank , ruleType )
        local result = false;
        local numRankPlacesToMove = 0;

        if ( ruleType == 2 and playerRankIndex > destinationRank ) then
            result = true;
            numRankPlacesToMove = ( playerRankIndex - destinationRank );
        elseif ( ruleType == 3 and playerRankIndex < destinationRank ) then
            result = true;
            numRankPlacesToMove = ( destinationRank - playerRankIndex );
        end

        return result , numRankPlacesToMove;
    end

    for _ , player in pairs ( GRM.GetGuild() ) do
        if type ( player ) == "table" and player.name ~= GRM_G.addonUser then
            -- reset for this player.

            for ruleName , rule in pairs ( GRM.S()[ GRM_UI.ruleTypeEnum[ruleCount] ] ) do
                if rule.isEnabled then
                    ruleConfirmedCheck = true;
                    tempRuleCollection = {};
                    -- Check filter

                    -- if my rank is lower is only way to work- cannot kick someone a higher or equal rank
                    if GRM_G.playerRankID < player.rankIndex then 
                        local canMove , numRankMoves = playerCanBeMoved ( player.rankIndex , ( rule.destinationRank - 1 ) , rule.ruleType );

                        if canMove then
                            -- Need to at least insert the ruleName and number of jumps it needs to make to destination rank
                            table.insert ( tempRuleCollection , { rankDestination[rule.ruleType] , GuildControlGetRankName ( rule.destinationRank ) , numRankMoves } );
                            local alts = GRM.GetListOfAlts ( player );

                            ----------------------------
                            -- RULES TO CHECK AGAINST --
                            ----------------------------
                            -- MAIN/ALT
                            if ruleConfirmedCheck and rule.applyRulesTo > 1 then
                                ruleConfirmedCheck = false;

                                if rule.applyRulesTo == 2 and not player.isMain and GRM.PlayerIsAnAlt ( player ) then
                                    ruleConfirmedCheck = true;
                                    table.insert ( tempRuleCollection , { "Main/Alt" , GRM.L ( "Player is an Alt" ) } );

                                elseif rule.applyRulesTo == 3 and player.isMain then
                                    -- Player is not a main!
                                    ruleConfirmedCheck = true
                                    table.insert ( tempRuleCollection , { "Main/Alt" , GRM.L ( "Player is a Main" ) } );
                                end

                            end
                            
                            if rule.ruleType == 3 then
                                -- Inactivity
                                if ruleConfirmedCheck and rule.activityFilter and not ( rule.rankFilter and rule.applyEvenIfActiive ) then
                                    ruleConfirmedCheck = false;

                                    if not rule.allAltsApplyToKick or ( rule.allAltsApplyToKick and not GRM.IsAnyAltActive ( alts , GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].hours ) ) then
                                        -- Is actually considered inactive
                                        if player.lastOnline >= GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].hours then
                                        -- Cannot remove players same rank or higher, so they have to be a higher index than you to remove them.
                                            ruleConfirmedCheck = true;
                                            table.insert ( tempRuleCollection , { "Inactive" , player.lastOnline } );
                                        end
                                    end
                                end

                                -- Extra activity filter based on rank
                                if ruleConfirmedCheck and not rule.activityFilter and rule.rankFilter and rule.applyEvenIfActiive then
                                    -- We know that the rank is valid at this point as it has been made true
                                    ruleConfirmedCheck = false;
                                    if rule.ranks[(GuildControlGetNumRanks() - player.rankIndex)] and player.rankHist[1][7] and GRM.HasTimeExceededDate ( player.rankHist[1][5] , GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].evenIfActiveHours ) then
                                        ruleConfirmedCheck = true;
                                        table.insert ( tempRuleCollection , { "Rank" , player.rankName } );
                                        table.insert ( tempRuleCollection , { "RankTime" , GRM.GetTimePassedUsingEpochTime ( player.rankHist[1][5] )[4] } );
                                    end
                                end

                            elseif rule.ruleType == 2 then

                                -- Inactivity -- can only promote based on activity if there is a verified promotion date currently.
                                if ruleConfirmedCheck and rule.activityFilter then
                                    ruleConfirmedCheck = false;

                                    -- Initial activity
                                    if ( rule.sinceAtRank and player.rankHist[1][7] and GRM.HasTimeExceededDate ( player.rankHist[1][5] , GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].hours ) ) or ( not rule.sinceAtRank and player.joinDateHist[1][6] and GRM.HasTimeExceededDate ( player.joinDateHist[1][4] , GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].hours ) ) then


                                        -- It appears the player HAS been at the rank for that given amount of time - now, do we promote no matter what, or do we check for inactivity?
                                        if rule.regardlessOfActivity then
                                            -- YES - promote regardless.
                                            ruleConfirmedCheck = true; 
                                            table.insert ( tempRuleCollection , { "RankTime", GRM.L ( GRM.GetSingularOrPluralFormattingForMacroToolMsg ( rule.isMonths , rule.numDaysOrMonths ) , nil , nil , rule.numDaysOrMonths ) } );
                                        else

                                            -- Promote logic is slightly different
                                            if rule.ruleType == 2 then
                                    
                                                -- If player is NOT INACTIVE   -- OR -- At least one alt is active
                                                if player.lastOnline < GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].inactive or ( rule.allAltsApplyToKick and GRM.IsAnyAltActive ( alts , GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].inactive ) ) then
                                                    ruleConfirmedCheck = true;

                                                    if rule.sinceAtRank then
                                                        table.insert ( tempRuleCollection , { "RankTime" , GRM.L ( GRM.GetSingularOrPluralFormattingForMacroToolMsg ( rule.isMonths , rule.numDaysOrMonths ) , nil , nil , rule.numDaysOrMonths ) } );
                                                    else
                                                        table.insert ( tempRuleCollection , { "GuildTime" , GRM.L ( GRM.GetToolTipMessageForInGuildMessage ( rule.isMonths , rule.numDaysOrMonths ) , nil , nil , rule.numDaysOrMonths ) } );
                                                    end
                                                    
                                                end
                                                

                                            -- Demote logic is slightly different.
                                            elseif rule.ruleType == 3 then

                                                -- If player IS INACTIVE (if not inactive why would you be demoting?)
                                                if player.lastOnline >= GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].inactive then
                                                    
                                                    if not rule.allAltsApplyToKick or ( rule.allAltsApplyToKick and not GRM.IsAnyAltActive ( alts , GRM_G.NumberOfHoursTilRecommend[GRM_UI.ruleTypeEnum2[rule.ruleType]][ruleName].inactive ) ) then
                                                        ruleConfirmedCheck = true;
                                                        table.insert ( tempRuleCollection , { "RankTime" , GRM.L ( GRM.GetSingularOrPluralFormattingForMacroToolMsg ( rule.isMonths , rule.numDaysOrMonths ) , nil , nil , rule.numDaysOrMonths ) } );
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end

                                -- Extra activity filter based on rank
                            if ruleConfirmedCheck and rule.rankFilter then
                                -- We know that the rank is valid at this point as it has been made true
                                ruleConfirmedCheck = false;
                                if rule.ranks[(GuildControlGetNumRanks() - player.rankIndex)] then
                                    ruleConfirmedCheck = true;
                                    table.insert ( tempRuleCollection , { "Rank" , player.rankName } );
                                end
                            end

                            -- Level Filters
                            if ruleConfirmedCheck and rule.levelFilter then
                                ruleConfirmedCheck = false;

                                local topLevel;
                                if rule.levelRange[2] == 999 then
                                    topLevel = GRM_G.LvlCap;
                                else
                                    topLevel = rule.levelRange[2];
                                end
                                if player.level >= rule.levelRange[1] and player.level <= topLevel then
                                    ruleConfirmedCheck = true;
                                    table.insert ( tempRuleCollection , { "Level" , rule.levelRange[1] , topLevel } );
                                end
                            end

                            -- Reputation Filter
                            if ruleConfirmedCheck and GRM_G.BuildVersion >= 40000 and rule.repFilter then
                                ruleConfirmedCheck = false;
                                local msg = "";
                                -- Less than Operator
                                if rule.repOperator == 1 and player.guildRep < rule.rep then
                                    msg = GRM.L ( "Guild Rep lower than {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
                                elseif rule.repOperator == 2 and player.guildRep == rule.rep then
                                    msg = GRM.L ( "Guild Rep equal to {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
                                elseif rule.repOperator == 3 and player.guildRep > rule.rep then
                                    msg = GRM.L ( "Guild Rep higher than {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
                                end

                                if #msg > 0 then
                                    ruleConfirmedCheck = true;
                                    table.insert ( tempRuleCollection , { "Rep" , GRM.L ( "Rep: {name} - {name2}" , GRM.GetReputationTextLevel ( player.guildRep , true ) , msg ) } );
                                end
                            end

                            -- Note match filter
                            if ruleConfirmedCheck and rule.noteMatch and not rule.noteMatchEmpty then

                                if #rule.matchingString > 0 then
                                    ruleConfirmedCheck = false;

                                    -- public note
                                    if rule.notesToCheck[1] and string.find ( string.lower ( player.note ) , string.lower ( rule.matchingString ) , 1 , true ) ~= nil then
                                        ruleConfirmedCheck = true;
                                    end
                                    -- Officer Note
                                    if not ruleConfirmedCheck and rule.notesToCheck[2] and string.find ( string.lower ( player.officerNote ) , string.lower ( rule.matchingString ) , 1 , true ) ~= nil then
                                        ruleConfirmedCheck = true;
                                    end
                                    -- Custom Note
                                    if not ruleConfirmedCheck and rule.notesToCheck[3] and string.find ( string.lower ( player.customNote[6] ) , string.lower ( rule.matchingString ) , 1 , true ) ~= nil then
                                        ruleConfirmedCheck = true;
                                    end

                                    if ruleConfirmedCheck then
                                        table.insert ( tempRuleCollection , { "Note Match" , rule.matchingString } );
                                    end
                                end

                            end

                            -- Empty note
                            if ruleConfirmedCheck and rule.noteMatch and rule.noteMatchEmpty then
                                ruleConfirmedCheck = false;
                                local notes = "";

                                if ( rule.notesToCheck[1] and player.note == "" ) then
                                    notes = GRM.L ( "Public" );
                                end
                                if ( rule.notesToCheck[2] and player.officerNote == "" ) then
                                    if #notes > 0 then
                                        notes = notes .. " , " .. GRM.L ( "Officer" );
                                    else
                                        notes = notes .. GRM.L ( "Officer" );
                                    end
                                end
                                if ( rule.notesToCheck[3] and player.customNote[6] == "" ) then
                                    if #notes > 0 then
                                        notes = notes .. " , " .. GRM.L ( "Custom" );
                                    else
                                        notes = notes .. GRM.L ( "Custom" );
                                    end
                                end

                                if #notes > 0 then
                                    ruleConfirmedCheck = true;
                                    table.insert ( tempRuleCollection , { "Empty Note Match" , notes } );                            
                                end
                            end

                            -- Safe Note
                            if ruleConfirmedCheck and rule.safeMatch then
                                if player.officerNote ~= nil and #player.officerNote > 0 then
                                    
                                    if string.find ( player.officerNote , rule.safeText , 1 , true ) then
                                        ruleConfirmedCheck = false;
                                    end
                                end

                                if ruleConfirmedCheck then
                                    table.insert ( tempRuleCollection , { "Safe Tag" , rule.safeText } );
                                end
                            end


                            if ruleConfirmedCheck then

                                -- RULE IS GOOD - ADD PLAYER

                                if not player.safeList[GRM_UI.ruleTypeEnum2[rule.ruleType]][1] then      -- Ignore for scanning... but I still want a count of the ignored.



                                    playerMatch = false;
                                    if rule.ruleType == 1 then
                                        playerMatch = true;
                                        
                                    elseif rule.ruleType == 2 then
                                        
                                        if ( not GRM.S().promoteOnlineOnly ) or ( GRM.S().promoteOnlineOnly and GRM.IsGuildieOnline ( player.name ) ) then
                                            playerMatch = true;
                                        end

                                    elseif rule.ruleType == 3 then

                                        if ( not GRM.S().demoteOnlineOnly ) or ( GRM.S().demoteOnlineOnly and GRM.IsGuildieOnline ( player.name ) ) then
                                            playerMatch = true;
                                        end
                                        
                                    end

                                    if playerMatch then
                                        local index = GRM.GetIndexOfPlayerOnList ( listOfPlayers , player.name );

                                        if not index then
                                            table.insert ( listOfPlayers , {} );
                                            index = #listOfPlayers;
                                            listOfPlayers[index].name = player.name;
                                            listOfPlayers[index].class = GRM.GetClassColorRGB ( player.class );
                                            listOfPlayers[index].lastOnline = player.lastOnline;
                                            listOfPlayers[index].action = GRM_UI.ruleTypeEnum3[rule.ruleType];
                                            listOfPlayers[index].macro = macroAction[rule.ruleType];
                                            listOfPlayers[index].isHighlighted = false;
                                            listOfPlayers[index].rankIndex = rule.destinationRank - 1;      -- Miinus 1 rank for it to match the player indexes
                                            listOfPlayers[index].mainName = GRM.GetMainName ( player , true );
                                            listOfPlayers[index].customMsg = "";
                                        end

                                        local numJumps = 0;
                                        if rule.ruleType == 2 then

                                            numJumps = player.rankIndex - ( rule.destinationRank - 1 );
                                            if not listOfPlayers[index].numRankJumps then               -- if this doesn't exist
                                                listOfPlayers[index].numRankJumps = numJumps;
                                            elseif listOfPlayers[index].numRankJumps < numJumps then    -- Only want to update it if it is more jumps.
                                                listOfPlayers[index].numRankJumps = numJumps;
                                            end

                                        else

                                            numJumps = ( rule.destinationRank - 1 ) - player.rankIndex;
                                            if not listOfPlayers[index].numRankJumps then               -- if this doesn't exist
                                                listOfPlayers[index].numRankJumps = numJumps;
                                            elseif listOfPlayers[index].numRankJumps < numJumps then    -- Only want to update it if it is more jumps.
                                                listOfPlayers[index].numRankJumps = numJumps;
                                            end

                                        end

                                        table.insert ( listOfPlayers[index] , { rule.name , tempRuleCollection } );
                                        sort ( listOfPlayers , function ( a , b ) return a.name < b.name end );
                                    end

                                else
                                    local index = GRM.GetIndexOfPlayerOnList ( GRM_UI.GRM_ToolCoreFrame.Safe , player.name );
    
                                    if index == nil and player.name ~= GRM_G.addonUser then
                                        table.insert ( GRM_UI.GRM_ToolCoreFrame.Safe , {} );
                                        index = #GRM_UI.GRM_ToolCoreFrame.Safe;
                                        GRM_UI.GRM_ToolCoreFrame.Safe[index].name = player.name
                                        GRM_UI.GRM_ToolCoreFrame.Safe[index].rankIndex = player.rankIndex;
                                        GRM_UI.GRM_ToolCoreFrame.Safe[index].class = GRM.GetClassColorRGB ( player.class );
                                        GRM_UI.GRM_ToolCoreFrame.Safe[index].reason = GRM_UI.ruleTypeEnum3[rule.ruleType];
                                        GRM_UI.GRM_ToolCoreFrame.Safe[index].lastOnline = player.lastOnline;
                                        GRM_UI.GRM_ToolCoreFrame.Safe[index].isHighlighted = false;
                                    end
                                end
                                
                            end
                        end
                    end
                end
            end
        end
    end

    if #listOfPlayers > 0 then
        for i = 1 , #listOfPlayers do
            sort ( listOfPlayers[i] , function ( a , b ) return a[1] < b[1] end );
        end
    end

    -- Get count
    GRM_G.counts[ruleCount] = #listOfPlayers;

    return listOfPlayers;
end

-- Method:          GRM.GetMacroFormattedName ( string )
-- What it Does:    Returns either a name with a server or not
-- Purpose:         If a player is on the same server as you, you don't need to add their server, thus you can remove it and allow more space in the macro tool
GRM.GetMacroFormattedName = function ( name )
    local result = "";
    if ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 and GRM_G.BuildVersion >= 90000 ) or ( GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 and string.find ( name , GRM_G.realmName , 1 , true ) ~= nil ) then      -- If the player has the same realm name as me than it can be shortened.
        result = GRM.SlimName ( name );
    else
        result = name;
    end

    return result;
end

-- Method:          GRM.GetKickNamesByFilterRules ()
-- What it Does:    Gets the names that adhere to the given rules
-- Purpose:         To populate the macro tool
GRM.GetKickNamesByFilterRules = function()
    local listOfPlayers = {};
    GRM_G.countAction[1] = time();

    -- No need to do all the work if there are no rules to check!
    if GRM.GetRulesCount ( 1 ) == 0 or GRM_G.guildName == "" or GRM_G.guildName == nil then -- the guildName thing is a redundancy that can occur due to lag, just protection against error.
        return listOfPlayers;
    end

    -- The name formatting is purely to be used for the macro to be added.
    
    local ruleConfirmedCheck = true
    local listOfPlayers , tempRuleCollection = {} , {};

    for _ , player in pairs ( GRM.GetGuild() ) do
        if type ( player ) == "table" and player.name ~= GRM_G.addonUser then
            -- reset for this player.

            for ruleName , rule in pairs ( GRM.S().kickRules ) do
                if rule.isEnabled then
                    ruleConfirmedCheck = true;
                    tempRuleCollection = {};
                    -- Check filter

                    -- if my rank is lower is only way to work- cannot kick someone a higher or equal rank
                    if GRM_G.playerRankID < player.rankIndex then

                        -- main
                        if ruleConfirmedCheck and rule.applyRulesTo > 1 then
                            ruleConfirmedCheck = false;

                            if rule.applyRulesTo == 2 and not player.isMain and GRM.PlayerIsAnAlt ( player ) then
                                ruleConfirmedCheck = true;
                                table.insert ( tempRuleCollection , { "Main/Alt" , GRM.L ( "Player is an Alt" ) } );

                            elseif rule.applyRulesTo == 3 and player.isMain then
                                -- Player is not a main!
                                ruleConfirmedCheck = true
                                table.insert ( tempRuleCollection , { "Main/Alt" , GRM.L ( "Player is a Main" ) } );
                            end
                        end

                        -- Inactivity
                        if ruleConfirmedCheck and rule.activityFilter and not ( rule.rankFilter and rule.applyEvenIfActiive ) then
                            ruleConfirmedCheck = false;

                            if not rule.allAltsApplyToKick or ( rule.allAltsApplyToKick and not GRM.IsAnyAltActiveForRecommendKicks ( GRM.GetListOfAlts ( player ) , ruleName  ) ) then
                                -- Is actually considered inactive
                                if player.lastOnline >= GRM_G.NumberOfHoursTilRecommend.kick[ruleName] then
                                -- Cannot remove players same rank or higher, so they have to be a higher index than you to remove them.
                                    ruleConfirmedCheck = true;
                                    table.insert ( tempRuleCollection , { "Inactive" , player.lastOnline } );
                                end
                            end
                        end

                        -- Rank Filters
                        if ruleConfirmedCheck and rule.rankFilter and not rule.applyEvenIfActiive then
                            ruleConfirmedCheck = false;

                            if rule.ranks[(GuildControlGetNumRanks() - player.rankIndex)] then
                                ruleConfirmedCheck = true;
                                table.insert ( tempRuleCollection , { "Rank" , player.rankName } );
                            end

                        end

                        -- Extra activity filter based on rank
                        if ruleConfirmedCheck and not rule.activityFilter and rule.rankFilter and rule.applyEvenIfActiive then
                            -- We know that the rank is valid at this point as it has been made true
                            ruleConfirmedCheck = false;
                            if rule.ranks[ (GuildControlGetNumRanks() - player.rankIndex) ] and player.rankHist[1][7] and GRM.GetHoursSinceTimestamp ( player.rankHist[1][5] ) >= GRM_G.NumberOfHoursTilRecommend.kickActive[ruleName] then
                                ruleConfirmedCheck = true;
                                table.insert ( tempRuleCollection , { "Rank" , player.rankName } );
                                table.insert ( tempRuleCollection , { "RankTime" , GRM.GetTimePassedUsingEpochTime ( player.rankHist[1][5] )[4] } );
                            end
                        end

                        -- Level Filters
                        if ruleConfirmedCheck and rule.levelFilter then
                            ruleConfirmedCheck = false;

                            local topLevel;
                            if rule.levelRange[2] == 999 then
                                topLevel = GRM_G.LvlCap;
                            else
                                topLevel = rule.levelRange[2];
                            end
                            if player.level >= rule.levelRange[1] and player.level <= topLevel then
                                ruleConfirmedCheck = true;
                                table.insert ( tempRuleCollection , { "Level" , rule.levelRange[1] , topLevel } );
                            end
                        end

                        -- Reputation Filter
                        if ruleConfirmedCheck and GRM_G.BuildVersion >= 40000 and rule.repFilter then
                            ruleConfirmedCheck = false;
                            local msg = "";
                            -- Less than Operator
                            if rule.repOperator == 1 and player.guildRep < rule.rep then
                                msg = GRM.L ( "Guild Rep lower than {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
                            elseif rule.repOperator == 2 and player.guildRep == rule.rep then
                                msg = GRM.L ( "Guild Rep equal to {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
                            elseif rule.repOperator == 3 and player.guildRep > rule.rep then
                                msg = GRM.L ( "Guild Rep higher than {name}" , GRM.GetReputationTextLevel ( rule.rep , true ) );
                            end

                            if #msg > 0 then
                                ruleConfirmedCheck = true;
                                table.insert ( tempRuleCollection , { "Rep" , GRM.L ( "Rep: {name} - {name2}" , GRM.GetReputationTextLevel ( player.guildRep , true ) , msg ) } );
                            end
                        end

                        -- Note match filter
                        if ruleConfirmedCheck and rule.noteMatch and not rule.noteMatchEmpty then

                            if #rule.matchingString > 0 then
                                ruleConfirmedCheck = false;

                                -- public note
                                if rule.notesToCheck[1] and string.find ( string.lower ( player.note ) , string.lower ( rule.matchingString ) , 1 , true ) ~= nil then
                                    ruleConfirmedCheck = true;
                                end
                                -- Officer Note
                                if not ruleConfirmedCheck and rule.notesToCheck[2] and string.find ( string.lower ( player.officerNote ) , string.lower ( rule.matchingString ) , 1 , true ) ~= nil then
                                    ruleConfirmedCheck = true;
                                end
                                -- Custom Note
                                if not ruleConfirmedCheck and rule.notesToCheck[3] and string.find ( string.lower ( player.customNote[6] ) , string.lower ( rule.matchingString ) , 1 , true ) ~= nil then
                                    ruleConfirmedCheck = true;
                                end

                                if ruleConfirmedCheck then
                                    table.insert ( tempRuleCollection , { "Note Match" , rule.matchingString } );
                                end
                            end

                        end

                        -- Empty note
                        if ruleConfirmedCheck and rule.noteMatch and rule.noteMatchEmpty then
                            ruleConfirmedCheck = false;
                            local notes = "";

                            if ( rule.notesToCheck[1] and player.note == "" ) then
                                notes = GRM.L ( "Public" );
                            end
                            if ( rule.notesToCheck[2] and player.officerNote == "" ) then
                                if #notes > 0 then
                                    notes = notes .. " , " .. GRM.L ( "Officer" );
                                else
                                    notes = notes .. GRM.L ( "Officer" );
                                end
                            end
                            if ( rule.notesToCheck[3] and player.customNote[6] == "" ) then
                                if #notes > 0 then
                                    notes = notes .. " , " .. GRM.L ( "Custom" );
                                else
                                    notes = notes .. GRM.L ( "Custom" );
                                end
                            end

                            if #notes > 0 then
                                ruleConfirmedCheck = true;
                                table.insert ( tempRuleCollection , { "Empty Note Match" , notes } );                            
                            end
                        end

                        -- Safe Note
                        if ruleConfirmedCheck and rule.safeMatch then
                            if player.officerNote ~= nil and #player.officerNote > 0 then
                                
                                if string.find ( player.officerNote , rule.safeText , 1 , true ) then
                                    ruleConfirmedCheck = false;
                                end
                            end

                            if ruleConfirmedCheck then
                                table.insert ( tempRuleCollection , { "Safe Tag" , rule.safeText } );
                            end
                        end


                        if ruleConfirmedCheck then
                            -- RULE IS GOOD - ADD PLAYER
                            -- Check safe list too
                            if not player.safeList.kick[1] then      -- Ignore for scanning... but I still want a count of the ignored.
                                local index = GRM.GetIndexOfPlayerOnList ( listOfPlayers , player.name );

                                if index == nil then
                                    table.insert ( listOfPlayers , {} );
                                    index = #listOfPlayers;
                                    listOfPlayers[index].name = player.name;
                                    listOfPlayers[index].class = GRM.GetClassColorRGB ( player.class );
                                    listOfPlayers[index].lastOnline = player.lastOnline;
                                    listOfPlayers[index].action = GRM_UI.ruleTypeEnum3[1];
                                    listOfPlayers[index].macro = "/gremove";
                                    listOfPlayers[index].isHighlighted = false;
                                    listOfPlayers[index].customMsg = "";
                                    listOfPlayers[index].isMain = false;
                                    listOfPlayers[index].isAlt = false;
                                    listOfPlayers[index].tab = false;
                                end
                                
                                table.insert ( listOfPlayers[index] , { rule.name , tempRuleCollection } );
                                sort ( listOfPlayers , function ( a , b ) return a.name < b.name end );

                            else
                                local index = GRM.GetIndexOfPlayerOnList ( GRM_UI.GRM_ToolCoreFrame.Safe , player.name );

                                if index == nil and player.name ~= GRM_G.addonUser then
                                    table.insert ( GRM_UI.GRM_ToolCoreFrame.Safe , {} );
                                    index = #GRM_UI.GRM_ToolCoreFrame.Safe;
                                    GRM_UI.GRM_ToolCoreFrame.Safe[index].name = player.name
                                    GRM_UI.GRM_ToolCoreFrame.Safe[index].rankIndex = player.rankIndex;
                                    GRM_UI.GRM_ToolCoreFrame.Safe[index].class = GRM.GetClassColorRGB ( player.class );
                                    GRM_UI.GRM_ToolCoreFrame.Safe[index].reason = GRM.L ( "Kick" );
                                    GRM_UI.GRM_ToolCoreFrame.Safe[index].lastOnline = player.lastOnline;
                                    GRM_UI.GRM_ToolCoreFrame.Safe[index].isHighlighted = false;
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- if #listOfPlayers > 0 then
    --     for i = 1 , #listOfPlayers do
    --         sort ( listOfPlayers[i] , function ( a , b ) return a[1] < b[1] end );
    --     end
    -- end

    listOfPlayers = GRM.SortAltsUnderMain ( listOfPlayers );

    if #GRM_UI.GRM_ToolCoreFrame.Safe then
        sort ( GRM_UI.GRM_ToolCoreFrame.Safe , function ( a , b ) return a.name < b.name end );
    end

    -- Get count
    GRM_G.counts[1] = #listOfPlayers;

    return listOfPlayers;
end

-- Method:          GRM.SortAltsUnderMain ( table )
-- What it Does:    Sorts all of the people in the macro tool to be mains, with alts underneath them
-- Purpose:         Quality of life sorting when looking at the macro tool
GRM.SortAltsUnderMain = function( listOfPlayers )
    local result = {}; -- We are going ot build a 2D array
    local player = {};
    local alts = {};
    local mainName = "";
    local isFound = false;
    local finalList = {};

    while #listOfPlayers > 0 do

        for i = #listOfPlayers , 1 , -1 do
            
            player = GRM.GetPlayer ( listOfPlayers[i].name );

            if player.altGroup == "" then
                table.insert ( result , { GRM.DeepCopyArray( listOfPlayers[i] ) } );
                table.remove ( listOfPlayers , i );
            else
                alts , mainName = GRM.GetListOfAlts ( player );

                if mainName == "" or mainName == player.name then
                    -- Main Name found, now let's cycle through and get all the alts too.
                    table.insert ( result , { GRM.DeepCopyArray( listOfPlayers[i] ) } );
                    table.remove ( listOfPlayers , i );
                    
                    if mainName ~= "" then
                        result[#result][1].isMain = true;
                    
                        for j = 1 , #alts do
                            for k = #listOfPlayers , 1 , -1 do

                                if listOfPlayers[k].name == alts[j][1] then

                                    local tempMain = GRM.DeepCopyArray ( result[#result][1] );
                                    listOfPlayers[k].isAlt = true;
                                    listOfPlayers[k].tab = true;

                                    table.insert ( result[#result] , GRM.DeepCopyArray( listOfPlayers[k] ) );
                                    table.remove ( result[#result] , 1 );   -- Removing the main
                                    table.remove ( listOfPlayers , k );

                                    sort ( result[#result] , function ( a , b ) return a.name < b.name end );   -- Sort the alts alphabetically

                                    -- Put the main back on top
                                    table.insert ( result[#result] , 1 , tempMain );
                                    break;
                                end
                            end
                        end
                    end

                    break;
                elseif mainName ~= "" then
                    -- We need to verify if mainName is on the list to be kicked
                    isFound = false;
                    for j = #listOfPlayers , 1 , -1 do
                        if listOfPlayers[j].name == mainName then
                            isFound = true;
                            break;
                        end
                    end

                    if not isFound then
                        -- This means an alt is being kicked, but not a main.
                        listOfPlayers[i].isAlt = true;
                        table.insert ( result , { GRM.DeepCopyArray( listOfPlayers[i] ) } );
                        table.remove ( listOfPlayers , i );
                    end
                end

            end

        end

    end

    sort ( result , function ( a , b ) return a[1].name < b[1].name end );

    -- Now, return it in a linear format in a 1D array
    for i = 1 , #result do
        for j = 1 , #result[i] do
            table.insert ( finalList , result[i][j] );
        end
    end

    return finalList
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
    local guildData = GRM.GetGuild();
    local rule = GRM_UI.ruleTypeEnum2[GRM_UI.GRM_ToolCoreFrame.TabPosition];

        for _ , player in pairs ( guildData ) do
            if type ( player ) == "table" and player.safeList[rule][1] and player.name ~= GRM_G.addonUser then

                count = count + 1;
                -- Default just gets the count - otherwise it returns the list of players as well.
                if getCountAndPlayers then
                    names[count] = {};
                    names[count].name = player.name;
                    names[count].class = GRM.GetClassColorRGB ( player.class );
                    names[count].isHighlighted = false;
                    names[count].reason = "";
                    names[count].rankIndex = player.rankIndex;
                    names[count].lastOnline = player.lastOnline;
                end
            end
        end
    return count , names;
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

-- Method:          GRM.RefreshMacroToolRuleCount()
-- What it Does:    Refreshes the UI text count on the macro tool
-- Purpose:         Update frames on the fly
GRM.RefreshMacroToolRuleCount = function()
    -- let's set the indicator text above the macro tool rule tabs
    if GRM_UI.GRM_ToolCoreFrame and GRM_UI.GRM_ToolCoreFrame:IsVisible() then
        if GRM_G.counts[1] == 0 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickQueText:SetTextColor ( 0 , 0.8 , 1 );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickQueText:SetTextColor ( 1 , 0 , 0 );
        end

        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameKickQueText:SetText ( GRM_G.counts[1] );

        if GRM_G.counts[2] == 0 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFramePromoteQueText:SetTextColor ( 0 , 0.8 , 1 );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFramePromoteQueText:SetTextColor ( GRM.S().logColor[4][1] , GRM.S().logColor[4][2] , GRM.S().logColor[4][3] );
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFramePromoteQueText:SetText ( GRM_G.counts[2] );

        if GRM_G.counts[3] == 0 then
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDemoteQueText:SetTextColor ( 0 , 0.8 , 1 );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDemoteQueText:SetTextColor ( GRM.S().logColor[5][1] , GRM.S().logColor[5][2] , GRM.S().logColor[5][3] );
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolRulesScrollBorderFrame.GRM_ToolCoreFrameDemoteQueText:SetText ( GRM_G.counts[3] );
    end
end

-- RULES!!!
-- Method:          GRM.GetCountOfNamesBeingFiltered()
-- What it Does:    Returns the number of names rules apply to
-- Purpose:         Refreshes the names
GRM.GetCountOfNamesBeingFiltered = function()
    local listOfNames = {};
    local k , p , d = 0 , 0 , 0;    -- Kick , Promote , Demote

    -- Add Remove Names
    if CanGuildRemove() then

        if time() - GRM_G.countAction[1] > 0.25 then
            listOfNames = GRM.GetKickNamesByFilterRules();
            for _ in pairs ( listOfNames ) do
                k = k + 1;
            end
            GRM_G.counts[1] = k;
        else
            k = GRM_G.counts[1];
        end
    end

    -- Add Promotion Names
    if CanGuildPromote() then
        if time() - GRM_G.countAction[2] > 0.25 then
            listOfNames = GRM.GetNamesByFilterRules( 2 );
            for _ in pairs ( listOfNames ) do
                p = p + 1;
            end
            GRM_G.counts[2] = p;
        else
            p = GRM_G.counts[2];
        end
    end

    -- Add Demotion Names
    if CanGuildDemote() then
        if time() - GRM_G.countAction[3] > 0.25 then
            listOfNames = GRM.GetNamesByFilterRules( 3 );
            for _ in pairs ( listOfNames ) do
                d = d + 1;
            end
            GRM_G.counts[3] = d;
        else
            d = GRM_G.counts[3];
        end
    end

    GRM.RefreshMacroToolRuleCount();

    return k , p , d , listOfNames;
end

------------------------
--- CUSTOM RULES -------
------------------------

-- Method:          GRM_UI.RefreshManagementTool( bool )
-- What it Does:    Refreshes the management tool
-- Purpose:         Compartmentalize the refresh details.
GRM_UI.RefreshManagementTool = function( isBanAltList , isBanInGuild , customKickGroup )
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

    -- Re-check they are valid
    GRM.RuleIntegrityCheck();

    GRM_G.playerRankID = GRM.GetGuildMemberRankID ( GRM_G.addonUser );
    GRM_UI.GRM_ToolCoreFrame.GRM_ToolMacrodScrollChildFrame.BlacklistedNames = {};  -- reset the blacklist.
    GRM_UI.GRM_ToolCoreFrame.Safe = {}; -- reset this list to rebuild
    GRM.BuildQueuedScrollFrame ( true , true , isBanAltList , isBanInGuild , customKickGroup );
    -- On reshow, always reset the macro
    GRM_UI.GRM_ToolCoreFrame.MacroEntries = {};
    GRM.BuildMacrodScrollFrame ( true , false );
    
    -- Load the options properly
    GRM_UI.LoadRulesUI();
    GRM_UI.RefreshToolButtonsOnUpdate();

    -- Populate the macro 
    if isBanAltList or isBanInGuild or customKickGroup then
        GRM_UI.GRM_ToolCoreFrame.GRM_ToolBuildMacroButton:Click();
    end

end

-- Method:          GRM_UI.RefreshToolButtonsOnUpdate()
-- What it Does:    For the "OnUpdate" script handler of the button to update the text as needed
-- Purpose:         Quality of life information so as not needed to open button, it is just visual.
GRM_UI.RefreshToolButtonsOnUpdate = function()

    if GRM_G.guildName ~= "" then
        
        GRM_UI.GRM_LoadToolOldRosterButton.count = {GRM.GetCountOfNamesBeingFiltered()};
        GRM_UI.GRM_LoadToolOldRosterButton.total = GRM_UI.GRM_LoadToolOldRosterButton.count[1] + GRM_UI.GRM_LoadToolOldRosterButton.count[2] + GRM_UI.GRM_LoadToolOldRosterButton.count[3];
        GRM_UI.GRM_LoadToolButton.count = GRM_UI.GRM_LoadToolOldRosterButton.count;
        GRM_UI.GRM_LoadToolButton.total = GRM_UI.GRM_LoadToolOldRosterButton.total;

        if GRM_UI.GRM_LoadToolButton:IsVisible() then
            if GRM_UI.GRM_LoadToolButton.total > 0 then
                GRM_UI.GRM_LoadToolButtonText:SetText ( GRM.L ( "Macro Tool: {num}" , nil , nil , GRM_UI.GRM_LoadToolButton.total ) );
            else
                GRM_UI.GRM_LoadToolButtonText:SetText ( GRM.L ( "Macro Tool" ) );
            end
        end

        if GRM_UI.GRM_LoadToolOldRosterButton:IsVisible() then
            if GRM_UI.GRM_LoadToolOldRosterButton.total > 0 then
                GRM_UI.GRM_LoadToolOldRosterButtonText:SetText ( GRM.L ( "Macro Tool: {num}" , nil , nil , GRM_UI.GRM_LoadToolOldRosterButton.total ) );
            else
                GRM_UI.GRM_LoadToolOldRosterButtonText:SetText ( GRM.L ( "Macro Tool" ) );
            end
        end
    else
        GRM_UI.GRM_LoadToolButtonText:SetText ( GRM.L ( "Macro Tool" ) );
        C_Timer.After ( 5 , function()
            GRM_UI.RefreshToolButtonsOnUpdate();
        end);
    end
end

-- Method:          GRM_UI.LoadRulesUI()
-- What it Does:    Rebuilds the options settings... for kick rules
-- Purpose:         UX easily on call, can be recalled with a rank change too.
GRM_UI.LoadRulesUI = function()
    GRM_UI.ConfigureToolTab();
    GRM.BuildRulesScrollFrame ( true , true );
end

-- Method:          GRM_UI.FullMacroToolRefresh()
-- What it Does:    Triggers a full refresh of ALL frames, like if the player creates and adds a new rule it will reprocess all
-- Purpose:         Quality of life, live updating of the UI as changes are made.
GRM_UI.FullMacroToolRefresh = function()
    GRM.RefreshNumberOfHoursTilRecommend();
    GRM_UI.RefreshManagementTool();
    GRM.SyncSettings();
end

-- Method:          GRM_UI.GRM_ToolCoreFrame()
-- What it Does:    Handles some on load property controls, if it is a rules load, or you are loading to use the tool for kicking alts or currently banned but still in guild players
-- Purpose:         UX ease of controls.
GRM_UI.GRM_ToolCoreFrame:SetScript ( "OnShow" , function ()

    if GRM_G.KickAltControl then
        GRM_UI.RefreshManagementTool( GRM_G.KickAltControl );
        GRM_G.KickAltControl = false;
    elseif GRM_G.kickBannedControl then
        GRM_UI.RefreshManagementTool( false , GRM_G.kickBannedControl );
        GRM_G.kickBannedControl = false;
    elseif GRM_G.customKickGroup then
        GRM_UI.RefreshManagementTool( false , false , GRM_G.customKickGroup );
        GRM_G.customKickGroup = false;
    else
        GRM_UI.RefreshManagementTool( false , false );
    end

    if GRM.S().disableMacroToolLogSpam then
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton:SetChecked ( true );
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton:SetChecked ( false );
    end

    if GRM.S().disableMacroToolLogSpam then
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton:SetChecked ( true );
    else
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolDisableLogSpamCheckbutton:SetChecked ( false );
    end

    if GRM_UI.GRM_ToolCoreFrame.TabPosition == 1 then

        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:Hide();

    elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 2 then

        if GRM.S().promoteOnlineOnly then
            GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( true );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( false );
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:Show();

    elseif GRM_UI.GRM_ToolCoreFrame.TabPosition == 3 then

        if GRM.S().demoteOnlineOnly then
            GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( true );
        else
            GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:SetChecked( false );
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_MacroToolShowOnlineOnlyCheckButton:Show();
    end

end);

----------------------------------------------
------------ MACRO SYNC LOGIC ----------------
----------------------------------------------
--- For syncing macro rules among officers ---
----------------------------------------------

-- On loading initial button - log current state of buttons - then log any updates made and report
-- Mouseover of button should show what buttons are in sync... and if still checking state "pending..."
-- Set it to trigger sync if you just enabled it.

-- -- Globals
-- GRM_G.MacroSyncList = {};                   -- Collects the names and their rules as they arrive
-- GRM_G.MacroSyncLeads = {};                  -- Collection of names to determine who is the number one person to sync macro rules with
-- GRM_G.MacroSyncCollecting = false;          -- On the initial timing sync request
-- GRM_G.MacroSyncTimeOutCheck = { 0 , 0 };    -- to compare on recursive error check. Each step this will be reset to time(). If time goes by between each check then we know sync failed, it will retry. - 2nd number is the step you are at///./
-- GRM_G.MacroRuleSyncFormat = {};
-- GRM_G.MacroRuleSyncFormat.kickRules = {};
-- GRM_G.MacroRuleSyncFormat.promoteRules = {};
-- GRM_G.MacroRuleSyncFormat.demoteRules = {};
-- GRM_G.macroSizeMod = 12;                        -- Static value representing macro prefix size
-- GRM_G.macroRequestQue = {};
-- GRM_G.MacroSyncQuePosition = 0;                 -- Tracking the position in que to be used in the tooltip
-- GRM_G.macroSyncSending = false                  -- Indicates the sending is currently in process
-- GRM_G.macroSyncRulesReceived = {};   -- Number of rules received and accepted in this sync
-- GRM_G.macroSyncRulesReceived.kickRules = {};
-- GRM_G.macroSyncRulesReceived.promoteRules = {};
-- GRM_G.macroSyncRulesReceived.demoteRules = {};

-- -- Method:          GRM.ResetMacroSyncValues()
-- -- What it Does:    Resets default values of sync progress
-- -- Purpose:         Clear old information if no longer needed
-- GRM.ResetMacroSyncValues = function()

--     GRM_G.macroSyncRulesReceived.kickRules = {};
--     GRM_G.macroSyncRulesReceived.promoteRules = {};
--     GRM_G.macroSyncRulesReceived.demoteRules = {};

-- end

-- -- Method:          GRM.MacroSync ( string , string , string )
-- -- What it Does:    Diverts the sync protocol to the macro tool use
-- -- Purpose:         To sync macro rules
-- GRM.MacroSync = function ( syncMsg , prefix , sender )
--     local intendedRecipient = "";

--     if prefix == "GRM_MACRO_T" then
--         -- Timestamp received, add to collection
--         GRM.MacroSyncCollectTime ( sender , syncMsg );

--     elseif prefix == "GRM_Macro_RK" and syncMsg == GRM_G.addonUser then
--         -- Received Kick rules request
--         GRM.CollectRequest ( 1 , sender );

--         if not GRM_G.macroSyncSending then
--             print ("SendingRules")
--             C_Timer.After ( 2 , GRM.SendRules );

--         end

--     elseif prefix == "GRM_Macro_RP" and syncMsg == GRM_G.addonUser then
--         -- Received Promote rules request
--         GRM.CollectRequest ( 2 , sender );

--         if not GRM_G.macroSyncSending then
--             C_Timer.After ( 1 , GRM.SendRules );
--         end

--     elseif prefix == "GRM_Macro_RD" and syncMsg == GRM_G.addonUser then
--         -- Received Demote rules request
--         GRM.CollectRequest ( 3 , sender );

--         if not GRM_G.macroSyncSending then
--             C_Timer.After ( 1 , GRM.SendRules );
--         end

--     elseif prefix == "GRM_Macro_SK" then
--         -- Received Kick rule
--         intendedRecipient , syncMsg = GRM.GetRecipient ( syncMsg )
--         print("RECEIVED KICK: " .. intendedRecipient)
--         if intendedRecipient == GRM_G.addonUser then
--             print("RECEIVED KICK 2")
--             GRM.CollectRule ( syncMsg , 1 , false , nil );
--         end

--     elseif prefix == "GRM_Macro_SP" then
--         -- Received Promote rule
--         intendedRecipient , syncMsg = GRM.GetRecipient ( syncMsg )
--         if intendedRecipient == GRM_G.addonUser then
--             GRM.CollectRule ( syncMsg , 2 , false , nil );
--         end

--     elseif prefix == "GRM_Macro_SD" then
--         -- Received Demote rule
--         intendedRecipient , syncMsg = GRM.GetRecipient ( syncMsg )
--         if intendedRecipient == GRM_G.addonUser then
--             GRM.CollectRule ( syncMsg , 3 , false , nil );
--         end
        
--     elseif prefix == "GRM_Macro_MK" then
--         print("Received Kick Rule")
--         -- Received rule
--         GRM.CollectRule ( syncMsg , 1 , false , nil );

--     elseif prefix == "GRM_Macro_MP" then
--         print("Received Promote Rule")
--         -- Received Promote Rule
--         GRM.CollectRule ( syncMsg , 2 , false , nil );

--     elseif prefix == "GRM_Macro_MD" then
--         print("Received Demote Rule")
--         -- Received Demote Rule
--         GRM.CollectRule ( syncMsg , 3 , false , nil );

--     elseif prefix == "GRM_Macro_LK" then
--         print("Received Live Kick Rule")
--         -- Received LIVE rule
--         GRM.CollectRule ( syncMsg , 1 , true , sender );

--     elseif prefix == "GRM_Macro_LP" then
--         print("Received Live Promote Rule")
--         -- Received LIVE Promote Rule
--         GRM.CollectRule ( syncMsg , 2 , true , sender );

--     elseif prefix == "GRM_Macro_LD" then
--         print("Received Live Demote Rule")
--         -- Received LIVE Demote Rule
--         GRM.CollectRule ( syncMsg , 3 , true , sender );

--     elseif prefix == "GRM_Macro_PQ" then    -- Position in Que
--         -- Received Que update
--         GRM.CollectQuePosition ( syncMsg );

--     elseif prefix == "GRM_Macro_FN" and syncMsg == GRM_G.addonUser then
--         -- Received Finished Statement
--         GRM.ReviewFinalResults();

--     elseif prefix == "GRM_Macro_XR" then
--         -- Received Finished Statement
--         GRM.ReceiveRuleRemove ( syncMsg , sender );

--     elseif prefix == "GRM_Macro_XL" then
--         -- Received Finished Statement
--         GRM.ReceiveRuleRemoveLive ( syncMsg , sender );

--     end

--     -- Else, nothing happens, end of function, just ignore the msg.
-- end

-- -- Method:          GRM.MacroSyncSend ( table , int , string )
-- -- What it Does:    Sends the macro rule out to be compared.
-- -- Purpose:         Build a lead, reusable tool to send the rules to other players easily.
-- GRM.MacroSyncSend = function ( macroType , customMsg )
--     local syncPrefixEnum = { [1] = "GRM_Macro_SK" , [2] = "GRM_Macro_SP" , [3] =  "GRM_Macro_SD" , [4] = "GRM_Macro_RK" , [5] = "GRM_Macro_RP" , [6] =  "GRM_Macro_RD" , [7] = "GRM_Macro_LK" , [8] = "GRM_aMcro_LP" , [9] = "GRM_Macro_LD", [10] = "GRM_Macro_PQ", [11] = "GRM_Macro_FN" , [12] = "GRM_Macro_XR" , [13] = "GRM_Macro_MK" , [14] = "GRM_Macro_MP" , [15] = "GRM_Macro_MD" , [16] = "GRM_Macro_XL"  }; -- "R == Request" and "S == Send" , "L" = "Live" - important differentiation on new data.

--     local prefix = syncPrefixEnum[macroType];
--     local msg = customMsg or "";


--     -- DO NOT SEND FOR NOW
--     -- GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?" .. prefix .. "?" .. msg , GRMsyncGlobals.channelName );
-- end

-- Method:          GRM.ConvertMacroRuleToString ( table , int )
-- What it Does:    Returns the text string in syncable format of the rule given
-- Purpose:         So rule can be shared
GRM.ConvertMacroRuleToString = function ( rule , ruleType )
    local result = "";
    local typeEnum = { ["kickRules"] = 1 , ["promoteRules"] = 2 , ["demoteRules"] = 3 };

    if type ( ruleType ) == "string" then
        ruleType = typeEnum [ ruleType ];
    end

    if ruleType == 1 then       -- kick rule
        result = GRM.BuildKickRuleTosync ( rule );

    elseif ruleType == 2 then   -- Promote rule
        result = GRM.BuildPromoteRuleToSync ( rule );

    elseif ruleType == 3 then   -- Demote rule
        result = GRM.BuildDemoteRuleToSync ( rule );

    end

    return result;
end

-- -- Method:          GRM.GetRecipient ( string )
-- -- What it Does:    Parses out the recipient's name in the msg
-- -- Purpose:         Only players the message is intended for need to analyze this. Saves processing cycles needlessly.
-- GRM.GetRecipient = function ( msg )
--     local name = string.sub ( msg , 1 , string.find ( msg , "?" ) -1 );
--     local msg = GRM.Next ( msg );

--     return name , msg;
-- end

-- -- Method:          GRM.CollectRequest ( int , string )
-- -- What it Does:    Collects the name of the person requesting the data
-- -- Purpose:         Prevent double requesting and to be able to hold a que if multiple requests are received at the same time.
-- GRM.CollectRequest = function ( ruleType , sender )
--     -- Verify not already added
--     if not GRM_G.macroRequestQue[sender] then
--         GRM_G.macroRequestQue[sender] = { false , false , false };
--     end

--     GRM_G.macroRequestQue[sender][ruleType] = true;

-- end

-- -- Method:          GRM.CollectQuePosition ( string )
-- -- What it Does:    Collects the position the player is in que to receive the sync data. In most cases this will be 1, if in middle of sync, but in rare cases multiple login at same time this could be more
-- -- Purpose:         Simple UI feature for the tooltip to help indicate a sort of ETA on when you will receeive the sync update.
-- GRM.CollectQuePosition = function ( msg )
--     local name , num = string.match ( msg , "(.+)?(%d+)" );

--     if name == GRM_G.addonUser then
--         print("Sync Position")
--         GRM_G.MacroSyncQuePosition = tonumber ( num );
--     end
-- end

-- -- Method:          GRM.MacroSyncSendTime()
-- -- What it Does:    Send the timestamp the player logged on
-- -- Purpose:         To compile a list and determine who has been online the longest.
-- GRM.MacroSyncSendTime = function()
--     GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_MACRO_T?" .. tostring (GRMsyncGlobals.timeAtLogin) , GRMsyncGlobals.channelName );
-- end

-- -- Method:          GRM.MacroSyncCollectTime()
-- -- What it Does:    Collects the players into a table as they send in their timeOnline stamps
-- -- Purpose:         Determine who we are going to sync with.
-- GRM.MacroSyncCollectTime = function( sender , time )
--     print("Collecting 1")
--     if GRM_G.MacroSyncCollecting then
--         local player = GRM.GetPlayer ( sender );
--         if player then
--             local canPromote , canDemote , canKick = GRM.GetPlayerRankPermissions ( player.name , player.rankIndex );
--             local isFound = false;
--             for i = 1 , #GRM_G.MacroSyncList do
--                 if GRM_G.MacroSyncList[i][2] == player.name then
--                     GRM_G.MacroSyncList[i] = { tonumber ( time ) , player.name , canKick , canPromote , canDemote };
--                     isFound = true;
--                     break;
--                 end
--             end

--             if not isFound then
--                 table.insert ( GRM_G.MacroSyncList , { tonumber ( time ) , sender , canKick , canPromote , canDemote } );   -- re-arranged to be in order of the macro tool
--             end
            
--         end
--     end
-- end

-- -- Method:          GRM.CompareTime
-- -- What it Does:    Compares the timestamp of people online for syncing the macro rules
-- -- Purpose:         To determine who is good to sync with.
-- GRM.CompareTime = function()

--     -- Need to reset these values...
--     GRM_G.MacroSyncLeads.kick = { 0 , "" };
--     GRM_G.MacroSyncLeads.promote = { 0 , "" };
--     GRM_G.MacroSyncLeads.demote = { 0 , "" };
--     local canKick , canPromote , canDemote = CanGuildRemove() , CanGuildPromote() , CanGuildDemote();
    
--     if #GRM_G.MacroSyncList > 0 then

--         sort ( GRM_G.MacroSyncList , function ( a , b ) return a[1] < b[1] end );

--         -- Set leads
--         for i = 1 , #GRM_G.MacroSyncList do
            
--             -- Check kickLead
--             if canKick and GRM_G.MacroSyncList[i][3] and ( GRM_G.MacroSyncLeads.kick[1] == 0 or GRM_G.MacroSyncLeads.kick[1] > GRM_G.MacroSyncList[i][1] ) then
--                 GRM_G.MacroSyncLeads.kick = { GRM_G.MacroSyncList[i][1] , GRM_G.MacroSyncList[i][2] };
--             end

--             -- Promotions Lead
--             if canPromote and GRM_G.MacroSyncList[i][4] and ( GRM_G.MacroSyncLeads.promote[1] == 0 or GRM_G.MacroSyncLeads.promote[1] > GRM_G.MacroSyncList[i][1] ) then
--                 GRM_G.MacroSyncLeads.promote = { GRM_G.MacroSyncList[i][1] , GRM_G.MacroSyncList[i][2] };
--             end

--             -- Demotions Lead
--             if canDemote and GRM_G.MacroSyncList[i][5] and ( GRM_G.MacroSyncLeads.demote[1] == 0 or GRM_G.MacroSyncLeads.demote[1] > GRM_G.MacroSyncList[i][1] ) then
--                 GRM_G.MacroSyncLeads.demote = { GRM_G.MacroSyncList[i][1] , GRM_G.MacroSyncList[i][2] };
--             end

--         end
--     end

--     GRM.RequestRulesToCompare();
--     GRM_G.MacroSyncCollecting = false;  -- all done
-- end

-- -- Method:          GRM.RequestRulesToCompare()
-- -- What it Does:    Sends a request to each lead of the macro rule for their rules.
-- -- Purpose:         Control the flow of requesting for info.
-- GRM.RequestRulesToCompare = function()
    
--     -- Kick rules
--     if GRM_G.MacroSyncLeads.kick[1] > 0 then
--         print("Requesting kick rules to compare")
--         GRM.MacroSyncSend ( 4 , GRM_G.MacroSyncLeads.kick[2] );
--     end

--     -- if GRM_G.MacroSyncLeads.promote[1] > 0 then
--     --     GRM.MacroSyncSend ( 5 , GRM_G.MacroSyncLeads.promote[2] );
--     -- end

--     -- if GRM_G.MacroSyncLeads.demote[1] > 0 then
--     --     GRM.MacroSyncSend ( 6 , GRM_G.MacroSyncLeads.demote[2] );
--     -- end

-- end



-- Method:          GRM.B2Num ( bool )
-- What it Does:    If something is true it returns it as 1 and 0 if false
-- Purpose:         Easy converion to num values for true or false which helps shave just a few chars on the sync data as well.
GRM.B2Num = function ( bool , convertToString )
    local result;
    local conv = { [true]=1 , [false]=0 };

    if type ( bool ) == "boolean" then
        result = conv[bool];
        if convertToString then
            result = tostring ( result )
        end
    end
    
    return result;
end

-- Method:          GRM.Num2B ( string )
-- What it Does:    Converts a string 1 to true and string 0 to false booleans
-- Purpose:         Easier converting when syncing data back and forth, keeps msg slim to pack and unpack it
GRM.Num2B = function ( numString )
    local result;
    local conv = { ["1"]=true , ["0"]=false };

    if type ( numString ) == "string" then
        result = conv[numString];
    end

    return result;
end

-- Method:          getRanksString ( string )
-- What it Does:    Converts the nested table into a string
-- Purpose:         Easier parsing on the receiving end of sync message
local getRanksString = function ( ranks )
    local result = "&&X";

    if #ranks > 0 then
        for i = 1 , #ranks do
            result = result .. GRM.B2Num ( ranks[i] , true ) .. "?";
        end
        result = result .. "X&&";
    else
        result = "&&X&X&&"
    end

    return result;
end

-- Method           getStringWithPlaceholder ( string )
-- What it Does:    For sync purposes - if it finds an empy string, there needs to be a placeholder so it replaces it with this uncomon string
-- Purpose:         Easy with parsing string on the receiving end.
local getStringWithPlaceholder = function ( msg )
    local result = "@&@";
    if msg == "" then
        return result;
    else
        return msg;
    end
end

-- Method:          GRM.BuildKickRuleTosync ( table )
-- What it Does:    Converts all of the rule values into a string
-- Purpose:         So the rule can be shared among officers.
GRM.BuildKickRuleTosync = function ( rule )

    -- Set all rule values into a large string.
    local result =                                              -- Indexed because when they are received they will be added into an array starting at 1
    getRanksString ( rule.ranks ) ..                            -- 1
    getStringWithPlaceholder ( rule.matchingString ) .. "?" ..  -- 2
    getStringWithPlaceholder ( rule.customLogMsg ) .. "?" ..    -- 3
    rule.name .. "?" ..                                         -- 4
    rule.createdBy[1] .. "?" ..                                 -- 5
    rule.createdBy[2] .. "?" ..                                 -- 6
    GRM.B2Num ( rule.activityFilter , true ) .. "?" ..          -- 7
    GRM.B2Num ( rule.isMonths , true ) .. "?" ..                -- 8
    GRM.B2Num ( rule.noteMatch , true ) .. "?" ..               -- 9
    GRM.B2Num ( rule.noteMatchEmpty , true ) .. "?" ..          -- 10
    GRM.B2Num ( rule.notesToCheck[1] , true ) .. "?" ..         -- 11
    GRM.B2Num ( rule.notesToCheck[2] , true ) .. "?" ..         -- 12
    GRM.B2Num ( rule.notesToCheck[3] , true ) .. "?" ..         -- 13
    GRM.B2Num ( rule.applyEvenIfActiive , true ) .. "?" ..      -- 14
    GRM.B2Num ( rule.rankSpecialIsMonths , true ) .. "?" ..     -- 15
    GRM.B2Num ( rule.allAltsApplyToKick , true ) .. "?" ..      -- 16
    GRM.B2Num ( rule.rankFilter , true ) .. "?" ..              -- 17
    GRM.B2Num ( rule.levelFilter , true ) .. "?" ..             -- 18
    GRM.B2Num ( rule.repFilter , true ) .. "?" ..               -- 19
    GRM.B2Num ( rule.customLog , true ) .. "?" ..               -- 20
    tostring ( rule.numDaysOrMonths ) .. "?" ..                 -- 21
    tostring ( rule.levelRange[1] ) .. "?" ..                   -- 22
    tostring ( rule.levelRange[2] ) .. "?" ..                   -- 23
    tostring ( rule.rankSpecialNumDaysOrMonths ) .. "?" ..      -- 24
    tostring ( rule.applyRulesTo ) .. "?" ..                    -- 25
    tostring ( rule.repOperator ) .. "?" ..                     -- 26
    tostring ( rule.rep ) .. "?" ..                             -- 27
    tostring ( rule.editTime ) .. "?" ..                        -- 28
    rule.safeText .. "?" ..                                     -- 29
    tostring ( rule.safeMatch ) .. "?" ..                       -- 30
    rule.GUID;                                                  -- 31

    return result;
end

-- Method:          GRM.BuildPromoteRuleToSync ( table )
-- What it Does:    Converts all of the rule values into a string
-- Purpose:         So the rule can be shared among officers.
GRM.BuildPromoteRuleToSync = function ( rule )

    -- Set all rule values into a large string.
    local result = 
    getRanksString ( rule.ranks ) ..                            -- 1
    getStringWithPlaceholder ( rule.matchingString ) .. "?" ..  -- 2
    getStringWithPlaceholder ( rule.customLogMsg ) .. "?" ..    -- 3
    rule.name .. "?" ..                                         -- 4
    rule.createdBy[1] .. "?" ..                                 -- 5
    rule.createdBy[2] .. "?" ..                                 -- 6
    GRM.B2Num ( rule.activityFilter , true ) .. "?" ..          -- 7
    GRM.B2Num ( rule.isMonths , true ) .. "?" ..                -- 8
    GRM.B2Num ( rule.noteMatch , true ) .. "?" ..               -- 9
    GRM.B2Num ( rule.noteMatchEmpty , true ) .. "?" ..          -- 10
    GRM.B2Num ( rule.notesToCheck[1] , true ) .. "?" ..         -- 11
    GRM.B2Num ( rule.notesToCheck[2] , true ) .. "?" ..         -- 12
    GRM.B2Num ( rule.notesToCheck[3] , true ) .. "?" ..         -- 13
    GRM.B2Num ( rule.regardlessOfActivity , true ) .. "?" ..    -- 14   -- UNIQUE
    GRM.B2Num ( rule.rankSpecialIsMonths , true ) .. "?" ..     -- 15
    GRM.B2Num ( rule.allAltsApplyToKick , true ) .. "?" ..      -- 16
    GRM.B2Num ( rule.rankFilter , true ) .. "?" ..              -- 17
    GRM.B2Num ( rule.levelFilter , true ) .. "?" ..             -- 18
    GRM.B2Num ( rule.repFilter , true ) .. "?" ..               -- 19
    GRM.B2Num ( rule.customLog , true ) .. "?" ..               -- 20
    tostring ( rule.numDaysOrMonths ) .. "?" ..                 -- 21
    tostring ( rule.levelRange[1] ) .. "?" ..                   -- 22
    tostring ( rule.levelRange[2] ) .. "?" ..                   -- 23
    tostring ( rule.rankSpecialNumDaysOrMonths ) .. "?" ..      -- 24
    tostring ( rule.applyRulesTo ) .. "?" ..                    -- 25
    tostring ( rule.repOperator ) .. "?" ..                     -- 26
    tostring ( rule.rep ) .. "?" ..                             -- 27
    tostring ( rule.editTime ) .. "?" ..                        -- 28
    tostring ( rule.destinationRank ) .. "?" ..                 -- 29
    tostring ( rule.sinceAtRank ) .. "?" ..                     -- 30
    rule.safeText .. "?" ..                                     -- 31
    tostring ( rule.safeMatch ) .. "?" ..                       -- 32
    rule.GUID;                                                  -- 33

    return result;
end

-- Method:          GRM.BuildDemoteRuleToSync ( table )
-- What it Does:    Converts all of the rule values into a string
-- Purpose:         So the rule can be shared among officers.
GRM.BuildDemoteRuleToSync = function ( rule )

    -- Set all rule values into a large string.
    local result = 
    getRanksString ( rule.ranks ) ..                            -- 1
    getStringWithPlaceholder ( rule.matchingString ) .. "?" ..  -- 2
    getStringWithPlaceholder ( rule.customLogMsg ) .. "?" ..    -- 3
    rule.name .. "?" ..                                         -- 4
    rule.createdBy[1] .. "?" ..                                 -- 5
    rule.createdBy[2] .. "?" ..                                 -- 6
    GRM.B2Num ( rule.activityFilter , true ) .. "?" ..          -- 7
    GRM.B2Num ( rule.isMonths , true ) .. "?" ..                -- 8
    GRM.B2Num ( rule.noteMatch , true ) .. "?" ..               -- 9
    GRM.B2Num ( rule.noteMatchEmpty , true ) .. "?" ..          -- 10
    GRM.B2Num ( rule.notesToCheck[1] , true ) .. "?" ..         -- 11
    GRM.B2Num ( rule.notesToCheck[2] , true ) .. "?" ..         -- 12
    GRM.B2Num ( rule.notesToCheck[3] , true ) .. "?" ..         -- 13
    GRM.B2Num ( rule.rankSpecialIsMonths , true ) .. "?" ..     -- 14
    GRM.B2Num ( rule.allAltsApplyToKick , true ) .. "?" ..      -- 15
    GRM.B2Num ( rule.rankFilter , true ) .. "?" ..              -- 16
    GRM.B2Num ( rule.levelFilter , true ) .. "?" ..             -- 17
    GRM.B2Num ( rule.repFilter , true ) .. "?" ..               -- 18
    GRM.B2Num ( rule.customLog , true ) .. "?" ..               -- 19
    tostring ( rule.numDaysOrMonths ) .. "?" ..                 -- 20
    tostring ( rule.levelRange[1] ) .. "?" ..                   -- 21
    tostring ( rule.levelRange[2] ) .. "?" ..                   -- 22
    tostring ( rule.rankSpecialNumDaysOrMonths ) .. "?" ..      -- 23
    tostring ( rule.applyRulesTo ) .. "?" ..                    -- 24
    tostring ( rule.repOperator ) .. "?" ..                     -- 25
    tostring ( rule.rep ) .. "?" ..                             -- 26
    tostring ( rule.destinationRank ) .. "?" ..                 -- 27
    tostring ( rule.editTime ) .. "?" ..                        -- 28
    rule.safeText .. "?" ..                                     -- 29
    tostring ( rule.safeMatch ) .. "?" ..                       -- 30
    rule.GUID;                                                  -- 31


    return result;
end

-- -- Method:          GRM.SendRuleAdd ( string , string , string , bool )
-- -- What it Does:    Sends a macro rule to a player to be checked, any type
-- -- Purpose:         Syncing rules
-- GRM.SendRuleAdd = function ( ruleType , ruleName , ruleString , isLive )
--     local sendDetails;
--     if isLive then
--         sendDetails = { ["kickRules"] = 13 , ["promoteRules"] = 14 , ["demoteRules"] = 15 };
--     else
--         sendDetails = { ["kickRules"] = 7 , ["promoteRules"] = 8 , ["demoteRules"] = 9 };
--     end

--     local msg = ruleString or GRM.ConvertMacroRuleToString ( GRM.S()[ruleType][ruleName] , ruleType );

--     GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRM_G.macroSizeMod;
--     GRM.MacroSyncSend ( sendDetails[ruleType] , msg );
-- end

-- -- Method:          GRM.SendRuleRemove ( string , string , int , string , bool )
-- -- What it DoeS:    Sends a message to a player to remove the given rule
-- -- Purpose:         Quality of life in syncing macro rules
-- GRM.SendRuleRemove = function ( typeIndex , ruleName , epochTime , removedBy , isLive )
--     local prefix = 12; -- "GRM_Macro_XR"
--     local t = epochTime or time();

--     if isLive then
--         prefix = 16; -- "GRM_Macro_XL"
--     end

--     local msg = typeIndex .. "?" .. ruleName  .. "?" .. removedBy .. "?" .. t; 
--     GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRM_G.macroSizeMod;
--     GRM.MacroSyncSend ( prefix , msg );
-- end


-- -- Method:          GRM.ReceiveRuleRemove ( string , string )
-- -- What it Does:    Determines if a rule was received as a live rule, or a retroactive sync, and then updates file as needed.
-- GRM.ReceiveRuleRemove = function ( msg , sender )
    
--     local ruleType , epochTime , name = string.match ( msg , "%d?%d?%d+?.+" );

--     isLive = GRM.Num2B ( isLive );
--     ruleType = tonumber ( ruleType );
--     epochTime = tonumber ( epochTime );

--     if isLive then
--         GRM.ReceiveRuleRemoveLive ( ruleType , epochTime , name );
--     else
--         GRM.ReceiveRuleRemoveSync ( ruleType , epochTime , name );
--     end

-- end

-- -- Method:          GRM.RemoveMacroRule ( string , string , bool )
-- -- What it Does:    Removes a macro rule LIVE\
-- -- Purpose:         Part of macro sync algorithm
-- GRM.RemoveMacroRule = function ( ruleName , ruleType , liveUpdate , sender )
--     print ("Removing Rule: " .. ruleName )
--     -- GRM.S()[ruleType][ruleName] = nil;
    

--     if liveUpdate then
--         local removeMsg = { ["kickRules"] = GRM.L ( "Kick Rule \"{name}\" Removed by {name2}" , ruleName , GRM.GetClassifiedName ( sender ) ) , ["promoteRules"] = GRM.L ( "Promote Rule \"{name}\" Removed by {name2}" , ruleName , GRM.GetClassifiedName ( sender ) ) , ["demoteRules"] = GRM.L ( "Demote Rule \"{name}\" Removed by {name2}" , ruleName , GRM.GetClassifiedName ( sender ) ) };

--         GRM.Report ( GRM.L ( "Macro Rule Sync:" ) .. " " .. removeMsg[ruleType] );
--     end

--     GRM.RefreshNumberOfHoursTilRecommend();
-- end

-- -- GRM.RemoveMacroRule
-- GRM.ReceiveRuleRemoveLive = function ( ruleType , epochTime , name )

-- end

-- GRM.ReceiveRuleRemoveSync = function ( ruleType , epochTime , name )

-- end

-- -- Method:          GRM.SendRuleRemove ( bool , int  int , string)
-- -- What it Does:    Sends a macro rule sync on a rule that has been removed
-- -- Purpose:         Syncing macro rules among players in same guild.
-- GRM.SendRuleRemove = function ( isLive , ruleType , epochTime , name )
--     local msg = GRM.B2Num ( isLive , true ) .. "?" .. ruleType .. "?" .. epochTime .. "?" .. name;
--     GRM.MacroSyncSend ( 12 , msg );
-- end

-- -- Method:          GRM.SendKickRules ( string , int , table , int )
-- -- What it Does:    This sends the kick rules to the other player in a qued fashion
-- -- Purpose:         Syncing macro rules.
-- GRM.SendRules = function ( s , t , rules , count )
--     GRM_G.macroSyncSending = true;

--     local sender , ruleType;

--     if not s then
--         sender , ruleType = GRM.GetNextInMacroSyncQue();
--         GRM.SendNumInQue();
--     else
--         sender = s;
--         ruleType = t;
--     end

--     local ruleFunctions = { GRM.CompileKickRules , GRM.CompilePromoteRules , GRM.CompileDemoteRules };
--     local macroRules = rules or ruleFunctions[ruleType]();
--     local ruleCount = count or 1;
--     local msg = "";
    
--     for i = ruleCount , #macroRules do
--         msg = sender .. "?" .. macroRules[i].ruleString;
        
--         GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRM_G.macroSizeMod;
--         print("Sending rules here type: " .. ruleType)
--         GRM.MacroSyncSend ( ruleType , msg );

--         if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
--             GRMsyncGlobals.SyncCount = 0;
--             C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
--                 GRM.SendRules ( sender , ruleType , rules , i );    -- Send with full details
--             end);
--             return;
--         end
--     end

--     print("Sending rules complete")
--     -- Rule send complete - let's check next step
--     GRM_G.macroRequestQue[sender][ruleType] = false;

--     -- Let's check same person for additional requests
--     for i = 1 , #GRM_G.macroRequestQue[sender] do
--         if GRM_G.macroRequestQue[sender][i] then
--             ruleType = i;
--             GRM.SendRules ( sender , ruleType );    -- still need another rule set to be sent.
--             return;
--         end
--     end

--     -- remove sender from que
--     GRM_G.macroRequestQue[sender] = nil;
--     GRM.MacroSyncSend ( 11 , sender );  -- Let player know done sending

--     -- On to the next in que
--     if GRM.GetNumInQue() > 0 then
--         C_Timer.After ( 5 , GRM.SendRules );
--         return;
--     end

--     GRM_G.macroSyncSending = false;
-- end

-- -- Method:          GRM.GetNumInQue()
-- -- What it Does:    Returns the integer number of people qued
-- -- Purpose:         Organize the que send list
-- GRM.GetNumInQue = function()
--     local num = 0;

--     for _ in pairs ( GRM_G.macroRequestQue ) do
--         num = num + 1;
--     end

--     return num;
-- end

-- -- Method:          GRM.SendNumInQue()
-- -- What it Does:    Sends out to each person in que their placement in the que so the tooltip can update if que is taking a while
-- -- Purpose:         Quality of life info on tooltip
-- GRM.SendNumInQue = function()
--     local msg = "";
--     local count = 1;

--     for name in pairs ( GRM_G.macroRequestQue ) do
--         msg = name .. "?" .. count;
--         GRM.MacroSyncSend ( 10 , msg );
--         GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRM_G.macroSizeMod;
--     end

-- end

-- -- Method:          GetNextInMacroSyncQue()
-- -- What it Does:    It returns the name and type of the person in the macro sync que next
-- -- Purpose:         Control the flow of the requests properly if qued.
-- GRM.GetNextInMacroSyncQue = function()
--     local name , ruleType;

--     for n , ruleRequest in pairs ( GRM_G.macroRequestQue ) do
--         for i = 1 , #ruleRequest do
--             if ruleRequest[i] then
--                 name = n;
--                 ruleType = i;
--                 break;
--             end
--         end
--         if name then    -- Add an escape
--             break;
--         end
--     end

--     return name , ruleType;
-- end

-- -- Method:          GRM.CompileKickRules()
-- -- What it Does:    Compiles all of your kick rules to be sent
-- -- Purpose:         Control the flow of information when sending.
-- GRM.CompileKickRules = function()
--     local listOfRules = {};
--     local tempTable = {};

--     for ruleName , rule in pairs ( GRM.S().kickRules ) do
--         if rule.sync then
--             if not GRM_G.MacroRuleSyncFormat.kickRules[ruleName] then
--                 GRM_G.MacroRuleSyncFormat.kickRules[ruleName] = {};
--                 GRM_G.MacroRuleSyncFormat.kickRules[ruleName].ruleString = GRM.ConvertMacroRuleToString ( rule , 1 );
--                 GRM_G.MacroRuleSyncFormat.kickRules[ruleName].ruleIndex = tonumber ( rule.ruleIndex );
--             end
--             table.insert ( listOfRules , GRM_G.MacroRuleSyncFormat.kickRules[ruleName] );
--         end
--     end

--     sort ( listOfRules , function ( a , b ) return a.ruleIndex < b.ruleIndex end );

--     return listOfRules;
-- end

-- -- Method:          GRM.CompilePromoteRules()
-- -- What it Does:    Compiles all of your promote rules to be sent
-- -- Purpose:         Control the flow of information when sending.
-- GRM.CompilePromoteRules = function()
--     local listOfRules = {};

--     for ruleName , rule in pairs ( GRM.S().promoteRules ) do
--         if rule.sync then
--             if not GRM_G.MacroRuleSyncFormat.promoteRules[ruleName] then
--                 GRM_G.MacroRuleSyncFormat.promoteRules[ruleName] = {};
--                 GRM_G.MacroRuleSyncFormat.promoteRules[ruleName].ruleString = GRM.ConvertMacroRuleToString ( rule , 2 );
--                 GRM_G.MacroRuleSyncFormat.promoteRules[ruleName].ruleIndex = tonumber ( rule.ruleIndex );
--             end
--             table.insert ( listOfRules , GRM_G.MacroRuleSyncFormat.promoteRules[ruleName] );
--         end
--     end

--     sort ( listOfRules , function ( a , b ) return a.ruleIndex < b.ruleIndex end );
--     -- Send in a qued format.

--     return listOfRules;
-- end

-- -- Method:          GRM.CompileDemoteRules()
-- -- What it Does:    Compiles all of your demote rules to be sent
-- -- Purpose:         Control the flow of information when sending.
-- GRM.CompileDemoteRules = function()
--     local listOfRules = {};

--     for ruleName , rule in pairs ( GRM.S().demoteRules ) do
--         if rule.sync then
--             if not GRM_G.MacroRuleSyncFormat.demoteRules[ruleName] then
--                 GRM_G.MacroRuleSyncFormat.demoteRules[ruleName] = {};
--                 GRM_G.MacroRuleSyncFormat.demoteRules[ruleName].ruleString = GRM.ConvertMacroRuleToString ( rule , 3 );
--                 GRM_G.MacroRuleSyncFormat.demoteRules[ruleName].ruleIndex = tonumber ( rule.ruleIndex );
--             end
--             table.insert ( listOfRules , GRM_G.MacroRuleSyncFormat.demoteRules[ruleName] );
--         end
--     end

--     sort ( listOfRules , function ( a , b ) return a.ruleIndex < b.ruleIndex end );
--     -- Send in a qued format.

--     return listOfRules;
-- end

-- -- Method:          GRM.ReceiveRule ( string )
-- -- What it Does:    Parses the received rule into an array
-- -- Purpose:         For syncing macro rules
-- GRM.ReceiveRule = function ( ruleMsg , ruleType )
--     local tempRanks , ruleMsg = string.match ( ruleMsg , "&&X(.+)X&&?(.+)" );
--     local receivedR = {};
--     local whileFilter = { [1]=21 , [2]=21 , [3]=20 };
--     receivedR[1] = {};

--     while tempRanks and string.find ( tempRanks , "?" ) ~= nil do
--         table.insert ( receivedR[1] , GRM.Num2B ( string.sub ( tempRanks , 1 , 1 ) ) );
--         tempRanks = string.sub ( tempRanks , 3 );
--     end

--     local ind = string.find ( ruleMsg , "?" );
--     local value = "";
--     local c = 1;
    
--     while ind do
--         table.insert ( receivedR , string.sub ( ruleMsg , 1 , ind - 1 ) );
--         ruleMsg = string.sub ( ruleMsg , ind + 1 );
--         ind = string.find ( ruleMsg , "?" );
--         c = c + 1;
--         if c > 6 then
--             if c < whileFilter[ruleType] then
--                 receivedR[c] = GRM.Num2B ( receivedR[c] );
--             else
--                 receivedR[c] = tonumber ( receivedR[c] );
--             end
--         else
--             -- c < 5
--             if c == 2 or c == 3 then
--                 if receivedR[c] == "@&@" then
--                     receivedR[c] = "";
--                 end
--             end
--         end
--     end

--     if #ruleMsg > 0 then
--         table.insert ( receivedR , tonumber ( ruleMsg ) );
--     end

--     return receivedR , ruleType;
-- end

-- -- Method:          GRM.CollectRule ( string , int , bool , string )
-- -- What it Does:    Collects the received rule and compares it
-- -- Purpose:         So player can know if they need to add the rule or not.
-- GRM.CollectRule = function ( ruleMsg , ruleType , liveUpdate , sender )
--     local rule = GRM.ReceiveRule ( ruleMsg , ruleType );

--     -- Compare rule to see if to add or to send the other person my rule
--     if ruleType == 1 then
--         GRM.MacroSyncCompareRule ( rule , "kickRules" , liveUpdate , sender );
--     elseif ruleType == 2 then
--         GRM.MacroSyncCompareRule ( rule , "promoteRules" , liveUpdate , sender );
--     elseif ruleType == 3 then
--         GRM.MacroSyncCompareRule ( rule , "demoteRules" , liveUpdate , sender );
--     end
-- end

-- -- Method:          GRM.MacroSyncCompareRule ( table , string )
-- -- What it Does:    Compares the rule received to what you already have and either absorbs it or ignores it.
-- -- Purpose:         To see which rule is the most recent.
-- GRM.MacroSyncCompareRule = function ( rule , ruleType , liveUpdate , sender )
--     print("Received rule")
--     -- First thing, let's check if the rule exists, and if it does, let's check editTimes
--     local addRule = false;
--     local ruleName = rule[4];

--     local senderNeedsToRemove = false;

--     -- Check if it already exists
--     if GRM.S()[ ruleType ][ ruleName ] then
--         if GRM.S()[ ruleType ][ ruleName ].editTime < rule[28] and GRM.S()[ ruleType ][ ruleName ].sync then
--             -- Rule needs to be added / overwrite existing
--             addRule = true;
--             print("Need to add it")
--         else
--             print("already exists")
--         end

--     -- Rule exists, but you removed it, let's see who is more recent.
--     elseif GRM.S().removedMacroRules[ ruleType ][ ruleName ] then
        
--         if GRM.S().removedMacroRules[ ruleType ][ ruleName ][1] <= rule[28] then
--             addRule = true;
--         else
--             senderNeedsToRemove = true;
--         end

--     else
--         print("AddingRule")
--         addRule = true;
--     end

--     if not liveUpdate then

--         GRM_G.macroSyncRulesReceived[ruleType][ruleName] = {};
--         GRM_G.macroSyncRulesReceived[ruleType][ruleName].toAdd = addRule;
--         GRM_G.macroSyncRulesReceived[ruleType][ruleName].senderRemove = senderNeedsToRemove;

--     end

--     -- Now we add it.
--     if addRule then
--         GRM.AddMacroRule ( rule , ruleType , liveUpdate , sender );

--     else
--         print("Rule already added")
--     end

-- end

-- -- Method:          GRM.AddMacroRule ( ruleTable , int , bool )
-- -- What it Does:    Takes the table values of the macro rule and adds them to the new rule
-- -- Purpose:         Allow slimmer storing of rule data for syncing purposes and storage efficiency, and to convert back to useful form easily.
-- GRM.AddMacroRule = function ( newRule , ruleType , liveUpdate )
--     local rule = {};
    
--     if ruleType == "kickRules" then
--         rule = GRM.BuildNewKickRuleTemplate();
--         rule.applyEvenIfActiive = newRule[14];  -- Unique rule to kicks
--         rule.name = newRule[4]
--         rule.applyRulesTo = newRule[25];                -- All = 1 , Alts = 2 , Mains = 3
--         rule.activityFilter = newRule[7];
--         rule.isMonths = newRule[8];
--         rule.numDaysOrMonths = newRule[21];
--         rule.allAltsApplyToKick = newRule[16];
--         rule.rankFilter = newRule[17];
--         rule.ranks = newRule[1];
--         rule.levelFilter = newRule[18];
--         rule.levelRange = { newRule[22] , newRule[23] };
--         rule.noteMatch = newRule[9];
--         rule.noteMatchEmpty = newRule[10];
--         rule.notesToCheck = { newRule[11] , newRule[12] , newRule[13] };   -- Public , Officer, Custom
--         rule.matchingString = newRule[2];
--         rule.rankSpecialIsMonths = newRule[15];
--         rule.rankSpecialNumDaysOrMonths = newRule[24];
--         rule.repFilter = newRule[19];
--         rule.repOperator = newRule[26];
--         rule.rep = newRule[27];            -- 4 = neutral
--         rule.customLog = newRule[20];
--         rule.customLogMsg = newRule[3];
--         rule.editTime = newRule[28];
--         rule.createdBy = { newRule[5] , newRule[6] };
--         rule.safeText = newRule[29];
--         rule.safeMatch = newRule[30];
--         rule.GUID = newRule[31];
        
--     elseif ruleType == "promoteRules" then
--         rule = GRM.BuildNewPromoteOrDemoteRuleTemplate ( nil , nil , 2 );
--         rule.regardlessOfActivity = newRule[14];  -- Unique rule to promote
--         rule.destinationRank = newRule[29];       -- Unique rule to promote/demote
--         rule.name = newRule[4]
--         rule.applyRulesTo = newRule[25];                -- All = 1 , Alts = 2 , Mains = 3
--         rule.activityFilter = newRule[7];
--         rule.isMonths = newRule[8];
--         rule.numDaysOrMonths = newRule[21];
--         rule.allAltsApplyToKick = newRule[16];
--         rule.rankFilter = newRule[17];
--         rule.ranks = newRule[1];
--         rule.levelFilter = newRule[18];
--         rule.levelRange = { newRule[22] , newRule[23] };
--         rule.noteMatch = newRule[9];
--         rule.noteMatchEmpty = newRule[10];
--         rule.notesToCheck = { newRule[11] , newRule[12] , newRule[13] };   -- Public , Officer, Custom
--         rule.matchingString = newRule[2];
--         rule.rankSpecialIsMonths = newRule[15];
--         rule.rankSpecialNumDaysOrMonths = newRule[24];
--         rule.repFilter = newRule[19];
--         rule.repOperator = newRule[26];
--         rule.rep = newRule[27];            -- 4 = neutral
--         rule.customLog = newRule[20];
--         rule.customLogMsg = newRule[3];
--         rule.editTime = newRule[28];
--         rule.createdBy = { newRule[5] , newRule[6] };
--         rule.sinceAtRank = newRule[30];
--         rule.safeText = newRule[31];
--         rule.safeMatch = newRule[32];
--         rule.GUID = newRule[33];

--     elseif ruleType == "demoteRules" then
--         rule = GRM.BuildNewPromoteOrDemoteRuleTemplate( nil , nil , 3 );
--         rule.destinationRank = newRule[27];       -- Unique rule to promote/demote
--         rule.name = newRule[4]
--         rule.applyRulesTo = newRule[24];                -- All = 1 , Alts = 2 , Mains = 3
--         rule.activityFilter = newRule[7];
--         rule.isMonths = newRule[8];
--         rule.numDaysOrMonths = newRule[20];
--         rule.allAltsApplyToKick = newRule[15];
--         rule.rankFilter = newRule[16];
--         rule.ranks = newRule[1];
--         rule.levelFilter = newRule[17];
--         rule.levelRange = { newRule[21] , newRule[22] };
--         rule.noteMatch = newRule[9];
--         rule.noteMatchEmpty = newRule[10];
--         rule.notesToCheck = { newRule[11] , newRule[12] , newRule[13] };   -- Public , Officer, Custom
--         rule.matchingString = newRule[2];
--         rule.rankSpecialIsMonths = newRule[14];
--         rule.rankSpecialNumDaysOrMonths = newRule[23];
--         rule.repFilter = newRule[18];
--         rule.repOperator = newRule[25];
--         rule.rep = newRule[26];            -- 4 = neutral
--         rule.customLog = newRule[19];
--         rule.customLogMsg = newRule[3];
--         rule.editTime = newRule[28];
--         rule.createdBy = { newRule[5] , newRule[6] };
--         rule.safeText = newRule[29];
--         rule.safeMatch = newRule[30];
--         rule.GUID = newRule[31];

--     end

--     GRM.S()[ruleType][rule.name] = GRM.DeepCopyArray ( rule );
--     -- Clear it from removed rules if it is there...
--     GRM.S().removedMacroRules[ ruleType ][rule.name] = nil;
--     -- Don't refresh UI until sender confirms they sent last rule
--     GRM.RefreshNumberOfHoursTilRecommend();
-- end

-- -- Method:          GRM.ReviewFinalResults()
-- -- What it Does:    Reviews the ultimate results of received rules
-- -- Purpose:         Ensure both players on the same page and quality of life reporting to the player
-- GRM.ReviewFinalResults = function()
--     print("Reviewing final results")
--     local countToSend = 0;
--     local listOfRulesToSend = {};
--     listOfRulesToSend.kickRules = {};
--     listOfRulesToSend.promoteRules = {};
--     listOfRulesToSend.demoteRules = {};

--     local count = { { 0 , 0 } , { 0 , 0 } , { 0 , 0 } }; -- { added , removed }
--     local ruleGroup = { "kickRules" , "promoteRules" , "demoteRules" };

--     for i = 1 , #ruleGroup do
--         for ruleName , rule in pairs ( GRM.S()[ruleGroup[i]] ) do

--             -- If it was not received, but you have this rule, then send it back as a LIVE update to specific person
--             if not GRM_G.macroSyncRulesReceived[ruleGroup[i]][ruleName] then
--                 if rule.sync then
--                     listOfRulesToSend[ruleGroup[i]][ruleName] = {};

--                     -- CPU cycle logic saving
--                     if not GRM_G.MacroRuleSyncFormat[ruleGroup[i]][ruleName] then
--                         GRM_G.MacroRuleSyncFormat[ruleGroup[i]][ruleName] = {};
--                         GRM_G.MacroRuleSyncFormat[ruleGroup[i]][ruleName].ruleString = GRM.ConvertMacroRuleToString ( GRM.S()[ruleGroup[i]][ruleName] , i );
--                         GRM_G.MacroRuleSyncFormat[ruleGroup[i]][ruleName].ruleIndex = tonumber ( rule.ruleIndex );
--                     end

--                     listOfRulesToSend[ruleGroup[i]][ruleName] = GRM_G.MacroRuleSyncFormat[ruleGroup[i]][ruleName];
--                     listOfRulesToSend[ruleGroup[i]][ruleName].toAdd = true;
--                     listOfRulesToSend[ruleGroup[i]][ruleName].name = ruleName;
--                     listOfRulesToSend[ruleGroup[i]][ruleName].editTime = rule.editTime;
--                     countToSend = countToSend + 1;
--                 end
--             else
--                 -- Rule received exists - only add to list if telling them to remove it
--                 if GRM_G.macroSyncRulesReceived[ruleGroup[i]][ruleName].senderRemove then
--                     listOfRulesToSend[ruleGroup[i]][ruleName] = {};
--                     listOfRulesToSend[ruleGroup[i]][ruleName].toAdd = false;
--                     listOfRulesToSend[ruleGroup[i]][ruleName].name = ruleName;
--                     listOfRulesToSend[ruleGroup[i]][ruleName].editTime = rule.editTime;
--                     countToSend = countToSend + 1;
--                 end

--             end
--         end
--     end
    
--     -- REPORTING TO CHAT
--     if GRM.S().syncChatEnabled then
--         local isAnyCount = false;
--         local i = 0;
--         for ruleGroup in pairs ( GRM_G.macroSyncRulesReceived ) do
            
--             if ruleGroup == "kickRules" then
--                 i = 1;
--             elseif ruleGroup == "promoteRules" then
--                 i = 2;
--             elseif ruleGroup == "demoteRules" then
--                 i = 3;
--             end

--             for _ , rule in pairs ( GRM_G.macroSyncRulesReceived[ruleGroup] ) do
--                 if rule.toAdd then
--                     count[i][1] = count[i][1] + 1;
--                     isAnyCount = true;
--                 elseif rule.toRemove then
--                     count[i][2] = count[i][2] + 1;
--                     isAnyCount = true;
--                 end
--             end
--         end
--         -- Only report to chat IF there is an udpate.
--         if isAnyCount then
--             GRM.Report ( GRM.L ( "Macro Rules Sync Result:" ) );

--             if count[1][1] > 0 then
--                 GRM.Report ( GRM.L ( "Kick Rules Added: {num}" , nil , nil , count[1][1] ) );
--             end
--             if count[1][2] > 0 then
--                 GRM.Report ( GRM.L ( "Kick Rules Removed: {num}" , nil , nil , count[1][2] ) );
--             end

--             if count[2][1] > 0 then
--                 GRM.Report ( GRM.L ( "Promote Rules Added: {num}" , nil , nil , count[2][1] ) );
--             end
--             if count[2][2] > 0 then
--                 GRM.Report ( GRM.L ( "Promote Rules Removed: {num}" , nil , nil , count[2][2] ) );
--             end

--             if count[3][1] > 0 then
--                 GRM.Report ( GRM.L ( "Demote Rules Added: {num}" , nil , nil , count[3][1] ) );
--             end
--             if count[3][2] > 0 then
--                 GRM.Report ( GRM.L ( "Demote Rules Removed: {num}" , nil , nil , count[3][2] ) );
--             end
--         end
--     end

--     if countToSend > 0 then
--         GRM.ResponseBackAfterMacroSync ( listOfRulesToSend );
--     else
--         print("Macro ccSync Complete")
--     end
    
    
--     -- Reset values and report end of macro rule sync
--     -- GRM.ResetMacroSyncValues();
-- end

-- -- Method:          GRM.ResponseBackAfterMacroSync ( table )
-- -- What it Does:    Sends a throttled response back of all the rules you have that needed to be added or removed by the syncer
-- -- Purpose:         Decentralized syncing.
-- GRM.ResponseBackAfterMacroSync = function ( listOfRulesToSend , sortedListOfRulesToSend , index )
--     local typeEnum = { ["kickRules"] = 1 , ["promoteRules"] = 2 , ["demoteRules"] = 3 };
--     local rulesToSend = {};
--     local startIndex = index or 1;

--     if sortedListOfRulesToSend then
--         rulesToSend = sortedListOfRulesToSend;
--     else
--         -- Let's create a sorted list so when sending it arrives neatly and in order
--         rulesToSend.kickRules = {};
--         rulesToSend.promoteRules = {};
--         rulesToSend.demoteRules = {};

--         -- Let's sort in send order
--         for ruleType in pairs ( listOfRulesToSend ) do
--             for ruleName , rule in pairs ( listOfRulesToSend[ruleType] ) do
--                 table.insert ( rulesToSend[ruleType] , rule );
--             end
--         end
--         sort ( rulesToSend.kickRules , function ( a , b ) return a.ruleIndex < b.ruleIndex end );
--         sort ( rulesToSend.promoteRules , function ( a , b ) return a.ruleIndex < b.ruleIndex end );
--         sort ( rulesToSend.demoteRules , function ( a , b ) return a.ruleIndex < b.ruleIndex end );
--     end

--     -- Now, we can send back our own rules to add and the ones that should be removed
--     for ruleType in pairs ( rulesToSend ) do
--         for i = startIndex , #rulesToSend[ruleType] do
           
--             if rulesToSend[ruleType][i].toAdd then
--                 -- Send Live request to add
--                 print("Sending Rule: " .. rulesToSend[ruleType][i].name .. "\n" .. rulesToSend[ruleType][i].ruleString )
--                 GRM.SendRuleAdd ( ruleType , nil , rulesToSend[ruleType][i].ruleString , false );
--             else
--                 -- Send Live request to remove
--                 print("Send Rule to Remove: " .. rulesToSend[ruleType][i].name)
--                 GRM.SendRuleRemove ( typeEnum[ruleType] , rulesToSend[ruleType][i].name , rulesToSend[ruleType][i].editTime  )
--             end

--             if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
--                 GRMsyncGlobals.SyncCount = 0;
--                 C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
--                     GRM.ResponseBackAfterMacroSync ( nil , rulesToSend , i );    -- Send with full details
--                 end);
--                 return;
--             end

--             startIndex = 1;
--         end
--     end

--     print("Macro ccSync Complete 2")
-- end


-- Method:          GRM.BuildMacroSyncTooltip()
-- What it Does:    Builds the tooltip for the sync feature
-- Purpose:         Information over the macro sync button
GRM.BuildMacroSyncTooltip = function( button )
    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( button , "ANCHOR_CURSOR" );
    GameTooltip:AddLine( "Pending Feature... Not yet ready" );
    GameTooltip:Show();
end

-- GRM.RemoveRuleSync = function()

-- end

-- -- Method:          GRM.RefreshSyncUsers()
-- -- What it Does:    Refreshes the users you are syncing with in case people you had on your list previously are now offline.
-- -- Purpose:         Have up to date list to sync rules with as people come online and offline all the time.
-- GRM.RefreshSyncUsers = function()
--     if not GRM_G.MacroSyncCollecting then
--         GRM.InitializeMacroSync();
--     end
-- end

-- -- Method:          GRM.InitializeMacroSync()
-- -- What it Does:    Initializes the sync protocol so GRM only needs 1 prfix registered.
-- -- Purpose:         For sync purposes of macro tool
-- GRM.InitializeMacroSync = function ()
--     if not GRMsyncGlobals.RulesSet then
--         GRMsync.MessageTracking = GRMsync.MessageTracking or CreateFrame ( "Frame" , "GRMsyncMessageTracking" );
--         GRMsync.BuildSyncNetwork ( true , false );
--         C_Timer.After ( 1 , function()
--             GRM.InitializeMacroSync();
--             return;
--         end);
--     else
--         GRM.SendInitialRequest();
--     end
-- end

-- -- Method:          GRM.SendInitialRequest()
-- -- What it Does:    Initializes Macro Sync
-- -- Purpose:         So Macro Rules can be shared
-- GRM.SendInitialRequest = function()
--     GRM_G.MacroSyncQuePosition = 0;
--     GRM_G.MacroSyncCollecting = true;
--     GRM_G.MacroSyncTimeOutCheck = time();
--     C_ChatInfo.SendAddonMessage ( "GRMUSER" , "GRM_MACRO_R?" , "GUILD" );   -- Piggie back a function that should already be configured.

--     -- Add delay here
--     C_Timer.After ( 5 , GRM.CompareTime );
-- end

-- -- Macro sync algorithm

-- Send Request to All
-- Other GRM "officers" receive request and send response back of their timeOnline
--         We want to determine who has been online the longest
-- Spend 5 seconds collecting responses, in case of lag
-- Determine who is longest online
-- Send this person all of your rules
-- This person will receive and compare all rules
--   Rules received they do not have will be absorbed
--   Rules they have that you do not they will then send back to you.