GRM_UI.InitializeMouseover = function()

    -- Core Frame
    GRM_UI.GRM_Mouseover = CreateFrame( "Frame" , "GRM_Mouseover" , UIParent , "TranslucentFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MouseoverCloseButton = CreateFrame( "Button" , "GRM_MouseoverCloseButton" , GRM_UI.GRM_Mouseover , "UIPanelCloseButton");
    GRM_UI.GRM_Mouseover:Hide();  -- Prevent error where it sometimes auto-loads.'
    GRM_UI.GRM_Mouseover.alts = {};

    -- Guild Member Detail Frame UI and Children
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton = CreateFrame ( "Button" , "GRM_SetPromoDateButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton.GRM_SetPromoDateButtonText = GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected = CreateFrame ( "Frame" , "GRM_DayDropDownMenuSelected" , GRM_UI.GRM_Mouseover , "InsetFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected.GRM_DayText = GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu = CreateFrame ( "Frame" , "GRM_DayDropDownMenu" , GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected , "InsetFrameTemplate" );

    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected = CreateFrame ( "Frame" , "GRM_YearDropDownMenuSelected" , GRM_UI.GRM_Mouseover , "InsetFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected.GRM_YearText = GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu = CreateFrame ( "Frame" , "GRM_YearDropDownMenu" , GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected , "InsetFrameTemplate" );

    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected = CreateFrame ( "Frame" , "GRM_MonthDropDownMenuSelected" , GRM_UI.GRM_Mouseover , "InsetFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected.GRM_MonthText = GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu = CreateFrame ( "Frame" , "GRM_MonthDropDownMenu" , GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected , "InsetFrameTemplate" );

    -- SUBMIT BUTTONS
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton = CreateFrame ( "Button" , "GRM_DateSubmitButton" , GRM_UI.GRM_Mouseover , "UIPanelButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton = CreateFrame ( "Button" , "GRM_DateSubmitCancelButton" , GRM_UI.GRM_Mouseover , "UIPanelButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt = GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButtonTxt = GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- Fontstring for MemberRank History
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton = CreateFrame ( "Button" , "GRM_MemberDetailJoinDateButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButtonText = GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_JoinDateText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- if player doesn't know their join date or promo date.
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton = CreateFrame ( "Button" , "GRM_SetUnknownButton" , GRM_UI.GRM_Mouseover.GRM_DateSubmitButton , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton.GRM_SetUnknownButtonText = GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- Birthdays
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton = CreateFrame ( "Button" , "GRM_MemberDetailBirthdayButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText = GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_BirthdayText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

    -- Notes of the
    GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow = CreateFrame( "Frame" , "GRM_PlayerNoteWindow" , GRM_UI.GRM_Mouseover , BackdropTemplateMixin and "BackdropTemplate" );
    GRM_UI.GRM_Mouseover.GRM_noteFontString1 = GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow:CreateFontString ( nil , "OVERLAY" , "GameFontWhite" );
    GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox = CreateFrame( "EditBox" , "GRM_PlayerNoteEditBox" , GRM_UI.GRM_Mouseover );
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow = CreateFrame( "Frame" , "GRM_PlayerOfficerNoteWindow" , GRM_UI.GRM_Mouseover , BackdropTemplateMixin and "BackdropTemplate" );
    GRM_UI.GRM_Mouseover.GRM_noteFontString2 = GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow:CreateFontString ( nil , "OVERLAY" , "GameFontWhite" );
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox = CreateFrame( "EditBox" , "GRM_PlayerOfficerNoteEditBox" , GRM_UI.GRM_Mouseover );
    GRM_UI.GRM_Mouseover.GRM_NoteCount = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhite" );
    GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:Hide();
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:Hide();

    -- Custom NOTEBOX
    -- Reason for the ban
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame = CreateFrame ( "Frame" , "GRM_CustomNoteEditBoxFrame" , GRM_UI.GRM_Mouseover , BackdropTemplateMixin and "BackdropTemplate" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox = CreateFrame ( "CheckButton" , "GRM_CustomNoteSyncMetaCheckBox" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteMetaCheckBoxText = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox = CreateFrame( "EditBox" , "GRM_CustomNoteEditBox" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetAutoFocus( false );
    --CUSTOM NOTE SCROLL FRAME
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_CustomNoteScrollFrame" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame );
    -- SLIDER
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider = CreateFrame ( "Slider" , "GRM_CustomNoteScrollFrameSlider" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame , GRM_G.SliderTemplate );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSliderOverlayTextUp = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:CreateFontString ( nil , "OVERLAY" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSliderOverlayTextDown = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:CreateFontString ( nil , "OVERLAY" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide();
    -- Populating Frames with FontStrings
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalLarge" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLevel = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailONoteTitle = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

    -- LAST ONLINE
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

    -- STATUS TEXT
    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

    -- ZONEINFORMATION
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1 = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2 = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- GROUP INVITE
    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton = CreateFrame ( "Button" , "GRM_GroupInviteButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton.GRM_GroupInviteButtonText = GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- Safe from recommendations checkbox
    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton = CreateFrame ( "Button" , "GRM_SafeFromRulesButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton.GRM_SafeFromRulesButtonText = GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- Tooltips
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankToolTip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailRankToolTip" , GRM_UI.GRM_Mouseover , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankToolTip:Hide();
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateToolTip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailJoinDateToolTip" , GRM_UI.GRM_Mouseover , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateToolTip:Hide();
    GRM_UI.GRM_Mouseover.GRM_MemberDetailServerNameToolTip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailServerNameToolTip" , GRM_UI.GRM_Mouseover , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateToolTip:Hide();
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNotifyStatusChangeTooltip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailNotifyStatusChangeTooltip" , GRM_UI.GRM_Mouseover , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNotifyStatusChangeTooltip:Hide();
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailNJDSyncTooltip" , GRM_UI.GRM_Mouseover , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip:Hide();
    GRM_UI.GRM_Mouseover.GRM_OfficerNoteTooltip = CreateFrame ( "GameTooltip" , "GRM_OfficerNoteTooltip" , nil , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_OfficerNoteTooltip:SetScale ( 0.65 );
    GRM_UI.GRM_Mouseover.GRM_OfficerNoteTooltip:Hide();

    --Sync Join Date Side Frame Options
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame = CreateFrame ( "Frame" , "GRM_SyncJoinDateSideFrame" , GRM_UI.GRM_Mouseover , "TranslucentFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_SyncJoinDateText = GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButton = CreateFrame ( "Button" , "GRM_JDMainButton" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame  );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButtonText = GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButton:CreateFontString ( nil , "OVERLAY" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButton = CreateFrame ( "Button" , "GRM_JDSelectedPlayerButton" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame  );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButtonText = GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButton:CreateFontString ( nil , "OVERLAY" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton = CreateFrame ( "Button" , "GRM_JDOldestButton" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame  );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButtonText = GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton:CreateFontString ( nil , "OVERLAY" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButton = CreateFrame ( "Button" , "GRM_JDSyncCancelButton" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame  );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButtonText = GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButton:CreateFontString ( nil , "OVERLAY" );

    -- Custom Note Confirm and Cancel Buttons
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton = CreateFrame ( "Button" , "GRM_ConfirmCustomNoteButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButtonText = GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton = CreateFrame ( "Button" , "GRM_CancelCustomNoteButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButtonText = GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- Popout arrow textures
    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton = CreateFrame ( "Button" , "GRM_SyncDateArrowButton" , GRM_UI.GRM_Mouseover , "UIPanelScrollUpButtonTemplate" );
    -- Popout arrow textures
    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton = CreateFrame ( "Button" , "GRM_ExtraAltDetailsArrowButton" , GRM_UI.GRM_Mouseover , "UIPanelScrollUpButtonTemplate" );

    -- Reputation Level
    GRM_UI.GRM_Mouseover.GRM_ReputationLevelText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- Locked Message
    GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- Banned Fontstring and Buttons
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1 = GRM_UI.GRM_Mouseover:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall");
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton = CreateFrame ( "Button" , "GRM_MemberDetailBannedIgnoreButton" , GRM_UI.GRM_Mouseover , "GameMenuButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton.GRM_MemberDetailBannedIgnoreButtonText = GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- ALT FRAMES!!!
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame = CreateFrame( "Frame" , "GRM_CoreAltFrame" , GRM_UI.GRM_Mouseover );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame:Hide(); -- No need to show initially. Occasionally on init. it would popup the title text. Just keep hidden with init.
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_CoreAltScrollFrame" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame );

    -- CONTENT ALT FRAME (Child Frame)
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame = CreateFrame ( "Frame" , "GRM_CoreAltScrollChildFrame" );
    -- SLIDER
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider = CreateFrame ( "Slider" , "GRM_CoreAltScrollFrameSlider" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame , GRM_G.SliderTemplate );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Hide();
    -- ALT HEADER
    GRM_UI.GRM_Mouseover.GRM_altFrameTitleText = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    -- ALT OPTIONSFRAME
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions = CreateFrame ( "Frame" , "GRM_altDropDownOptions" , GRM_UI.GRM_Mouseover , BackdropTemplateMixin and "BackdropTemplate" );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsDividerText = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- ALT Right Click frame buttons
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton = CreateFrame ( "Button" , "GRM_altSetMainButton" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions  );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton = CreateFrame ( "Button" , "GRM_altRemoveButton" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton = CreateFrame ( "Button" , "GRM_altFrameCancelButton" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButtonText = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- MouseOver Right Click Context Menu STATUS
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame = CreateFrame ( "Frame" , "GRM_MouseOverStatusFrame" , GRM_UI.GRM_Mouseover , BackdropTemplateMixin and "BackdropTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameTopText = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameDividerText = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- Status context menu buttons
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1 = CreateFrame ( "Button" , "GRM_MouseOverStatusFrameButton1" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame  );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2 = CreateFrame ( "Button" , "GRM_MouseOverStatusFrameButton2" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton = CreateFrame ( "Button" , "GRM_MouseOverStatusFrameCancelButton" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButtonText = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- Right Click Join, Promote, Birthdate menu
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame = CreateFrame ( "Frame" , "GRM_MouseOverDateStatusFrame" , GRM_UI.GRM_Mouseover , BackdropTemplateMixin and "BackdropTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameTopText = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameDividerText = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- Status context menu buttons
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1 = CreateFrame ( "Button" , "GRM_MouseOverDateStatusFrameButton1" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame  );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2 = CreateFrame ( "Button" , "GRM_MouseOverDateStatusFrameButton2" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3 = CreateFrame ( "Button" , "GRM_MouseOverDateStatusFrameButton3" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4 = CreateFrame ( "Button" , "GRM_MouseOverDateStatusFrameButton4" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton = CreateFrame ( "Button" , "GRM_MouseOverDateStatusFrameCancelButton" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButtonText = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    -- Add Alt core button
    GRM_UI.GRM_AddAltButton2 = CreateFrame ( "Button" , "GRM_AddAltButton2" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame , "GameMenuButtonTemplate" );
    GRM_UI.GRM_AddAltButton2Text = GRM_UI.GRM_AddAltButton2:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- ADD ALT EDITBOX Frame
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame = CreateFrame ( "Frame" , "GRM_AddAltEditFrame" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame , "TranslucentFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltTitleText = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox = CreateFrame ( "EditBox" , "GRM_AddAltEditBox" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame , "InputBoxTemplate" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBoxCloseButton = CreateFrame ( "Button" , "GRM_AddAltEditBoxCloseButton" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame , "UIPanelCloseButton" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2 = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_AddAltScrollFrame" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame );
    -- CONTENT FRAME (Child Frame)
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame = CreateFrame ( "Frame" , "GRM_AddAltScrollChildFrame" );
    -- SLIDER
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider = CreateFrame ( "Slider" , "GRM_AddAltScrollFrameSlider" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame , GRM_G.SliderTemplate );

    -- MOUSEOVER alt grouping window...
    -- AUDIT FRAME SCROLL FRAME
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame = CreateFrame ( "Frame" , "GRM_AltGroupingScrollBorderFrame" , UIParent , "TranslucentFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrameTitle = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrameCloseButton = CreateFrame( "Button" , "GRM_AltGroupingScrollBorderFrameCloseButton" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "UIPanelCloseButton");
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_AltGroupingScrollFrame" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame );
    -- BANLIST CONTENT FRAME (Child Frame)
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame = CreateFrame ( "Frame" , "GRM_AltGroupingScrollChildFrame" );
    -- BANLIST SLIDER
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider = CreateFrame ( "Slider" , "GRM_AltGroupingScrollFrameSlider" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame , "UIPanelScrollBarTrimTemplate" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_MainTag = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    -- Fontstrings
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingName = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLevel = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingRank = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLastOnline = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupHeaderTooltip = CreateFrame ( "GameTooltip" , "GRM_AltGroupHeaderTooltip" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupHeaderTooltip:Hide();

    -- Horde/Ally icones
    GRM.CreateTexture ( GRM_UI.GRM_Mouseover , "GRM_HordeIconTexture" , "BORDER" , false );
    GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt , "TOP" , 0 , -2);
    GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:SetTexture ( "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\Horde_Icon.blp" );
    GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:SetWidth ( 22 );
    GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:SetHeight ( 22 );

    GRM.CreateTexture ( GRM_UI.GRM_Mouseover , "GRM_AllianceIconTexture" , "BORDER" , false );
    GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt , "TOP" , 0 , -2);
    GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:SetTexture ( "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\Alliance_Icon.blp" );
    GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:SetWidth ( 22 );
    GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:SetHeight ( 22 );

    -- Hardcore Death Texture
    GRM.CreateTexture ( GRM_UI.GRM_Mouseover , "GRM_DeathTexture" , "ARTWORK" , false );
    GRM_UI.GRM_Mouseover.GRM_DeathTexture:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover , "CENTER" , 0 , 0 );
    GRM_UI.GRM_Mouseover.GRM_DeathTexture:SetTexture ( "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\dead.png" );
    GRM_UI.GRM_Mouseover.GRM_DeathTexture:SetWidth ( 350 );
    GRM_UI.GRM_Mouseover.GRM_DeathTexture:SetHeight ( 350 );

    -- Tooltip
    GRM_UI.GRM_Mouseover.GRM_BirthdayTooltip = CreateFrame ( "GameTooltip" , "GRM_BirthdayTooltip" , GRM_UI.GRM_Mouseover , "GameTooltipTemplate" );
    GRM_UI.GRM_Mouseover.GRM_BirthdayTooltip:Hide();

    -- Member Mouseover window - macro tool checkbox frame
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame = CreateFrame ( "Frame" , "GRM_MacroToolIgnoreListSettingsFrame" , GRM_UI.GRM_Mouseover , "TranslucentFrameTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_MacroToolIgnoreListSettingsFrameCloseButton = CreateFrame ( "Button" , "GRM_MacroToolIgnoreListSettingsFrameCloseButton" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "UIPanelCloseButton" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2 = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox = CreateFrame ( "CheckButton" , "GRM_IgnoreListFrameKickCheckBox" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText2 = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox = CreateFrame ( "CheckButton" , "GRM_IgnoreListFramePromoteCheckBox" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText2 = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox = CreateFrame ( "CheckButton" , "GRM_IgnoreListFrameDemoteCheckBox" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText2 = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton = CreateFrame ( "CheckButton" , "GRM_IgnoreListKickTimeExpireButton" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox = CreateFrame( "EditBox" , "GRM_IgnoreListKickTimeExpireEditBox" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , "InputBoxTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:ClearFocus();

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton = CreateFrame ( "CheckButton" , "GRM_IgnoreListPromoteTimeExpireButton" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox = CreateFrame ( "EditBox" , "GRM_IgnoreListPromoteTimeExpireEditBox" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , "InputBoxTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:ClearFocus();

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton = CreateFrame ( "CheckButton" , "GRM_IgnoreListDemoteTimeExpireButton" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "InterfaceOptionsCheckButtonTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText = GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox = CreateFrame( "EditBox" , "GRM_IgnoreListDemoteTimeExpireEditBox" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton , "InputBoxTemplate" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:ClearFocus()

    -- Frame Control
    -- Placement and Dimensions
    GRM_UI.GRM_Mouseover:ClearAllPoints();

    if not isManualUpdate then
        GRM_UI.GRM_Mouseover.GRM_MouseoverCloseButton:HookScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                if not GRM_UI.MemberDetailFrame:IsVisible() then
                    GRM_G.pause = false;
                end
            end
        end);
        GRM_UI.SetCloseButtonTooltip ( GRM_UI.GRM_Mouseover.GRM_MouseoverCloseButton );
    end
    GRM_UI.GRM_Mouseover:SetSize( 400 , 438 );
    GRM_UI.GRM_Mouseover.timer = 0;
    GRM_UI.GRM_Mouseover.GRM_MouseoverCloseButton:SetPoint( "TOPRIGHT" , GRM_UI.GRM_Mouseover , "TOPRIGHT" , -4 , -4 );
    GRM_UI.GRM_Mouseover.GRM_MouseoverCloseButton:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover:EnableMouse ( true );
    GRM_UI.GRM_Mouseover:SetToplevel ( true );

    GRM_UI.GRM_Mouseover:SetScript ( "OnUpdate" , GRM.MemberDetailToolTips );

    -- Logic handling: If pause is set, this unpauses it. If it is not paused, this will then hide the window.
    GRM_UI.GRM_Mouseover:SetScript ( "OnKeyDown" , function ( self , key )

        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                if not self.GRM_AltGroupingScrollBorderFrame:IsVisible() then
                    if not GRM_UI.MemberDetailFrame:IsVisible() then
                        if GRM_G.pause then
                            GRM_G.pause = false;
                        else
                            self:Hide();
                        end
                    else
                        GRM_UI.MemberDetailFrame:Hide();
                    end
                else
                    self.GRM_AltGroupingScrollBorderFrame:Hide();
                end
            end
        else
            if not GRM_UI.MemberDetailFrame:IsVisible() then
                if GRM_G.pause then
                    GRM_G.pause = false;
                else
                    self:Hide();
                end
            else
                GRM_UI.MemberDetailFrame:Hide();
            end
        end
    end);

    -- Context menu for Right Click mouseover name or Alts list
    GRM_UI.ConfigureAltNamesContextMenuSize = function()
        local width = 93;

        if ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText:GetStringWidth() + 15 ) ) then       -- For scaling the frame based on size of player name.
            width = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText:GetStringWidth() + 15;
        end
        if ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:GetStringWidth() + 15;
            GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton:GetWidth() );
        end
        if ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:GetStringWidth() + 15;
        end
        if ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButtonText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButtonText:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButtonText:GetStringWidth() + 15;
            GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton:GetWidth() );
        end
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:SetSize ( width , 106 );
    end

    -- Right click menu for mouseover status
    GRM_UI.ConfigureStatusContextMenuSize = function( height )
        local width = 177;

        if ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameTopText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameTopText:GetStringWidth() + 15 ) ) then       -- For scaling the frame based on size of player name.
            width = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameTopText:GetStringWidth() + 15;
        end
        if ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:GetStringWidth() + 15;
            GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1 , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1:GetWidth() );
        end
        if GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:IsVisible() then
            if ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text:GetStringWidth() + 15 ) )  then
                width = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text:GetStringWidth() + 15;
                GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2 , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:GetWidth() );
            end
        end
        if ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButtonText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButtonText:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButtonText:GetStringWidth() + 15;
        end
        GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:SetSize ( width , height );
    end

    -- For promote, Demote, and Birthday
    GRM_UI.ConfigureDateContextMenuSize = function ( height )
        local width = 93;
        if ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameTopText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameTopText:GetStringWidth() + 15 ) ) then       -- For scaling the frame based on size of player name.
            width = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameTopText:GetStringWidth() + 15;
        end
        if ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:GetStringWidth() + 15;
            GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1 , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:GetWidth() );
        end
        if ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:GetStringWidth() + 15;
            GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2 , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:GetWidth() );
        end
        if GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:IsVisible() then
            if ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text:GetStringWidth() + 15 ) )  then
                width = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text:GetStringWidth() + 15;
                GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3 , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:GetWidth() );
            end
        end
        if GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:IsVisible() then
            if ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text:GetStringWidth() + 15 ) )  then
                width = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text:GetStringWidth() + 15;
                GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4 , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:GetWidth() );
            end
        end
        if ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButtonText:GetStringWidth() >= width ) or ( width < ( GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButtonText:GetStringWidth() + 15 ) )  then
            width = GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButtonText:GetStringWidth() + 15;
        end

        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:SetSize ( width , height );
    end

    -- Configuring and sizing right-click menu if over the mouseover player's name.
    GRM_UI.ConfigureRightClickPlayerNameWindow = function()
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:ClearAllPoints();
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText , "BOTTOM" );

        -- Set the name
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText:SetText ( GRM.SlimName ( GRM_G.selectedName[2] ) );

        if not GRM_G.selectedName[3] then    -- player is not the main.
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:SetText ( GRM.L ( "Set as Main" ) );
        else -- player IS the main... place option to Demote From Main rahter than set as main.
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:SetText ( GRM.L ( "Set as Alt" ) );
        end
        -- Export will always show export!
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:SetText ( GRM.L ( "Reset Data!" ) );

        GRM_UI.ConfigureAltNamesContextMenuSize();
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Show();
        GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
        GRM_G.pause = true;
    end

    -- This configures as the right click button happens.
    GRM_UI.ConfigureStatusRightClickMenu = function()
        local height = 93;
        local statusText = GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:GetText();
        local needsToOpen = false;

        for i = 1 , #GRM_G.Status do
            if statusText == GRM_G.Status[i] then
                if statusText == GRM_G.Status[1] or statusText == GRM_G.Status[2] then  -- Active or Mobile
                    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:SetText ( GRM.L ( "Notify When Player Goes Offline" ) );
                    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:Hide();
                    needsToOpen = true;
                elseif statusText == GRM_G.Status[3] then  -- Offline
                    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:SetText ( GRM.L ( "Notify When Player Comes Online" ) );
                    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:Hide();
                    needsToOpen = true;
                elseif statusText == GRM_G.Status[4] or statusText == GRM_G.Status[5] then  -- AFK or BUSY
                    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:SetText ( GRM.L ( "Notify When Player is Active" ) );
                    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text:SetText ( GRM.L ( "Notify When Player Goes Offline" ) );
                    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:Show();
                    height = 113;
                    needsToOpen = true;
                end

                break;
            end
        end

        if needsToOpen then
            GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Show();
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
            GRM_G.pause = true;
            GRM_UI.ConfigureStatusContextMenuSize ( height );
        end
    end

    -- Right Click menu configuration for promotion rank history or editing
    GRM_UI.ConfigurePromoteDateRightClickMenu = function()
        local height = 113;
        local player = GRM.GetPlayer ( GRM_G.currentName );

            if player then

            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:ClearAllPoints();
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt , "BOTTOM" );

            -- Logic already configured as it is static
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:SetText ( GRM.L ( "Edit Date" ) );
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:SetScript ( "OnClick" , function ( _ , button )
                if button == "LeftButton" then
                    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Click();
                    GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetText ( GRM.L ( "Edit Promo Date" ) );
                    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
                end
            end);

            -- Logic reconfigured for each player.
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:SetText ( GRM.L ( "Clear History" ) );
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:SetScript ( "OnClick" , function( _ , button )
                if button == "LeftButton" then
                    GRM.ClearPromoDateHistory ( player.name , player.promoteDateUnknown , player );
                    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
                end
            end );

            -- To show button 3 or not.
            if not player.promoteDateUnknown and not player.rankHist[1][7] then
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text:SetText ( GRM.L ( "Confirm Date" ) );
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:SetScript ( "OnClick" , function ( _ , button )
                    if button == "LeftButton" then
                        GRM_UI.ConfirmPromoDate();
                        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
                    end

                end);
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:Show();
                height = height + 16;

                if player.rankHist[1][6] and not player.joinDateUnknown then
                    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text:SetText ( GRM.L ( "Use Join Date" ) );
                    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:SetScript ( "OnClick" , function ( _ , button )
                        if button == "LeftButton" then
                            GRM.CopyFromJoinDate();
                            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
                        end
                    end);
                    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:Show();
                    height = height + 16;
                else
                    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:Hide();
                end

            else
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:Hide();
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:Hide();
            end

            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Show();
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
            GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
            GRM_G.pause = true;
            GRM_UI.ConfigureDateContextMenuSize ( height );
        end
    end

    -- Right Click menu configuration for promotion rank history or editing
    GRM_UI.ConfigureJoinDateRightClickMenu = function()
        local height = 113;
        local player = GRM.GetPlayer ( GRM_G.currentName );

        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:ClearAllPoints();
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_JoinDateText , "BOTTOM" );

        -- Logic already configured as it is static
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:SetText ( GRM.L ( "Edit Date" ) );
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Click();
                GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetText ( GRM.L ( "Edit Join Date" ) );
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
                GRM_UI.GRM_Mouseover.GRM_JoinDateText:Hide();
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Hide();
            end
        end);

        -- Logic reconfigured for each player.
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:SetText ( GRM.L ( "Clear History" ) );
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:SetScript ( "OnClick" , function( _ , button )
            if button == "LeftButton" then
                player.joinDateUnknown = false;
                GRM.ClearJoinDateHistory ( player.name , player.joinDateUnknown , player );
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
            end
        end );

        -- To show button 3 or not.
        if not player.joinDateUnknown and not player.joinDateHist[1][6] then

            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text:SetText ( GRM.L ( "Confirm Date" ) );
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:SetScript ( "OnClick" , function ( _ , button )
                if button == "LeftButton" then
                    GRM_UI.ConfirmJoinDate();
                    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
                end

            end);
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:Show();
            height = height + 16;

            if player.rankHist[1][7] and not player.promoteDateUnknown then
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text:SetText ( GRM.L ( "Use Promo Date" ) );
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:SetScript ( "OnClick" , function ( _ , button )
                    if button == "LeftButton" then
                        GRM.CopyFromPromoDate();
                        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
                    end
                end);
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:Show();
                height = height + 16;
            else
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:Hide();
            end

        else
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:Hide();
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:Hide();
        end

        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Show();
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
        GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
        GRM_G.pause = true;
        GRM_UI.ConfigureDateContextMenuSize ( height );
    end

    GRM_UI.ConfigureBirthDayRightClickMenu = function()
        local height = 110;
        local player = GRM.GetPlayer ( GRM_G.currentName );

        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:ClearAllPoints();
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_BirthdayText , "BOTTOM" );

        -- Logic already configured as it is static
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:SetText ( GRM.L ( "Edit Date" ) );
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:Hide();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Click();
                GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetText ( GRM.L ( "Edit Birthday" ) );
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
            end
        end);

        -- Logic reconfigured for each player.
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:SetText ( GRM.L ( "Remove Date" ) );
        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:SetScript ( "OnClick" , function( _ , button )
            if button == "LeftButton" then
                GRM.ResetBirthdayForAltGroup ( player.name , time() , false , nil , false );
                GRM_UI.RefreshSelectFrames ( false , true , false , false , true , true );
                GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
            end
        end );

        GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Show();
        GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
        GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
        GRM_G.pause = true;
        GRM_UI.ConfigureDateContextMenuSize ( height );
    end

    -- For Fontstring logic handling, particularly of the se.
    GRM_UI.GRM_Mouseover:SetScript ( "OnMouseDown" , function ( _ , button )
        if button == "RightButton" then

            if not GRM.IsMouseOverAltButton() then  -- The alt names - they have their own separate logic window if scrolling window

                local isOnActionableText = false;
                local contextMenu = 0;  -- So we know WHICH right click window version to bring up.

                -- Over Mouseover player name
                if GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                    isOnActionableText = true;
                    contextMenu = 1;

                    -- Over player online status text
                elseif GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:IsVisible() and GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                    isOnActionableText = true;
                    contextMenu = 2;

                -- Over Promotion date text
                elseif GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:IsVisible() and GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                    isOnActionableText = true;
                    contextMenu = 3;

                -- Over Join Date Text
                elseif GRM_UI.GRM_Mouseover.GRM_JoinDateText:IsVisible() and GRM_UI.GRM_Mouseover.GRM_JoinDateText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                    isOnActionableText = true;
                    contextMenu = 4;

                -- Over Birthday date text
                elseif GRM_UI.GRM_Mouseover.GRM_BirthdayText:IsVisible() and GRM_UI.GRM_Mouseover.GRM_BirthdayText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                    isOnActionableText = true;
                    contextMenu = 5;
                end

                if isOnActionableText then
                    GRM_G.selectedName = GRM.GetSelectedName ( GRM_G.currentName ); -- Setting to global the alt name chosen.
                else
                    GRM_G.selectedName = GRM.GetSelectedName (); -- This purges it
                end

                if GRM_G.selectedName[1] then -- Looks like we need a right click context menu!!!

                    -- Clear the tooltips to make way for right click context menu
                    GRM.MouseOverClearAllTooltips();

                    -- Now, let's build the menus
                    if contextMenu == 1 then
                        GRM_UI.ConfigureRightClickPlayerNameWindow();   -- Player Name

                    elseif contextMenu == 2 then
                        GRM_UI.ConfigureStatusRightClickMenu();         -- Status Text Mouseover

                    elseif contextMenu == 3 then                        -- Rank Date
                        GRM_UI.ConfigurePromoteDateRightClickMenu();

                    elseif contextMenu == 4 then                        -- Join Date
                        GRM_UI.ConfigureJoinDateRightClickMenu();

                    elseif contextMenu == 5 then                        -- Birthday
                        GRM_UI.ConfigureBirthDayRightClickMenu();

                    end

                end
            end
        elseif button == "LeftButton" then
            if not IsShiftKeyDown() then
                if GRM_UI.GRM_Mouseover.GRM_MemberDetailServerNameToolTip:IsVisible() and not GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                    -- This makes the main window the alt that was clicked on! TempAltName is saved when mouseover action occurs.
                    if GRM_G.tempAltName ~= "" then
                        GRM.SelectPlayerOnRoster ( GRM_G.tempAltName );
                    end
                end
            else
                if GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:IsMouseOver ( 2 , -2 , -2 , 2 ) then
                    GRM_G.tempAltName = GRM_G.currentName;
                end
                if GRM_G.tempAltName and GRM_G.tempAltName ~= "" then
                    GRM.GR_Roster_Click ( GRM_G.tempAltName );
                    GRM_G.tempAltName = "";
                end
            end
        end
    end);

    GRM_UI.GRM_Mouseover:SetScript ( "OnHide" , function()
        GRM.ClearAllFrames( false );
        if not GRM_UI.MemberDetailFrame:IsVisible() and not GRM_UI.MemberDetailFrame:IsVisible() then
            GRM_G.pause = false;

        else
            if GRM_G.pause then
                if GRM_UI.MemberDetailFrame then
                    GRM_UI.MemberDetailFrame.LockedFrameText:Show();
                end

            end
        end
    end);

    GRM_UI.GRM_Mouseover:SetScript ( "OnShow" , function()

        local configured1 = false;
        -- Configure only once
        if GRM_UI.MemberDetailFrame and not GRM_UI.MemberDetailFrame.LockedFrameText then
            GRM_UI.MemberDetailFrame.LockedFrameText = GRM_UI.MemberDetailFrame:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
            GRM_UI.MemberDetailFrame.LockedFrameText:SetPoint ( "BOTTOMRIGHT" , GRM_UI.MemberDetailFrame , "TOPRIGHT" , -5 , 0 );
            GRM_UI.MemberDetailFrame.LockedFrameText:SetFont (  GRM_G.FontChoice , GRM_G.FontModifier + 13 );
            GRM_UI.MemberDetailFrame.LockedFrameText:SetTextColor ( 1 , 0 , 0 , 1 );
            GRM_UI.MemberDetailFrame.LockedFrameText:SetText ( GRM.L ( "Locked. Press ESC" ) );
            GRM_UI.MemberDetailFrame.LockedFrameText:Hide();

            GRM_UI.MemberDetailFrame:HookScript ( "OnHide" , function()
                if not GRM_UI.GRM_Mouseover:IsVisible() then
                    GRM_G.pause = false;
                end
                GRM_UI.GRM_GetJoinDateButton:Hide();
            end);

            GRM_UI.MemberDetailFrame:HookScript ( "OnShow" , function()
                GRM_UI.GRM_GetJoinDateButton:Show();
            end);

        else
            configured1 = true;
        end

        if configured1 then
            GRM_UI.MemberDetailFrame.LockedFrameText:Hide();
        end

    end);

    GRM_UI.ResetDeath = function()
        local player = GRM.GetPlayer ( GRM_G.currentName );
        local clearDeath = false;

        if player then
            local noteToCheck = player.note;
            if GRM_G.BuildHasRestrictions then
                noteToCheck = player.customNote[4];
            end

            if noteToCheck:find ( "%[" .. GRM.L ( "D" ) .. "%]" ) then
                if not GRM_G.BuildHasRestrictions then
                    if GRM.CanEditPublicNote() then
                        local newNote = string.gsub ( noteToCheck:gsub ( "%[" .. GRM.L ( "D" ) .. "%]%-%d%d%d%d%d%d%d%d" , "" ) , "%[" .. GRM.L ( "D" ) .. "%]" , "" );
                        newNote = GRM.Util.Trim ( newNote );

                        if newNote ~= noteToCheck then
                            local i = GRM.GetRosterSelectionID ( player.name , player.GUID );

                            if i then

                                local simpleName = GRM.GetStringClassColorByName ( player.name ) .. GRM.SlimName ( player.name ) .. "|r";

                                local logReportWithTime , logReport = GRM.GetNoteChangeString ( simpleName , noteToCheck , newNote , GRM.Time.GetTimestamp() );

                                if GRM.S().toChat.note then
                                    GRM.Log.PrintLog ( { 4 , logReport } );
                                end
                                -- Also adding it to the log!
                                GRM.Log.AddLog ( { 4 , logReportWithTime , simpleName , noteToCheck , newNote , GRM.Time.GetTimestamp() } );

                                player.note = newNote;
                                GRM.SetNote ( player.GUID, newNote, true, i );
                                clearDeath = true;

                            end
                        end
                    else
                        GRM.Report ( GRM.L ( "The \"{custom1}\" indicates the player is dead." , nil , nil , nil , "[" .. GRM.L ( "D" ) .. "]" ) .. "\n" .. GRM.L ( "Your rank does not have permission to remove the tag." ) , GRM.S().logColor[15][1] , GRM.S().logColor[15][2] , GRM.S().logColor[15][3] );
                    end
                else
                    local newNote = string.gsub ( noteToCheck:gsub ( "%[" .. GRM.L ( "D" ) .. "%]%-%d%d%d%d%d%d%d%d" , "" ) , "%[" .. GRM.L ( "D" ) .. "%]" , "" );
                    newNote = GRM.Util.Trim ( newNote );

                    if newNote ~= noteToCheck then
                        
                        player.customNote[2] = time();
                        player.customNote[3] = GRM_G.addonUser;
                        player.customNote[4] = newNote;

                        GRM.RecordCustomNoteChanges(newNote, noteToCheck, GRM_G.addonUser, player.name, true)
                    end
                end
            else
                clearDeath = true;
            end

            if clearDeath then
                player.HC.isDead = false;
                player.HC.timeOfDeath = { 0 , 0 , 0 , 0 , 0 , false };

                GRM.Report ( GRM.L ( "{name} is no longer reported as Dead." , GRM.GetClassifiedName ( player.name , true ) ) , GRM.S().logColor[15][1] , GRM.S().logColor[15][2] , GRM.S().logColor[15][3] );

                if GRM_UI.GRM_Mouseover:IsVisible() then
                    GRM.ClearAllFrames( false );
                    GRM.PopulateMemberDetails ( GRM_G.currentName );
                end
                GRM_UI.RefreshSelectFrames ( true , true , false , true , true , false );
            end
        end

    end

    --Death Ignore Button
    GRM_UI.CreateButton ( "GRM_ClearDeathButton" , GRM_UI.GRM_Mouseover , "UIPanelButtonTemplate" , nil , 200 , 22 , { "TOP" , GRM_UI.GRM_Mouseover , "BOTTOM" , 0 , 1 } , GRM_UI.ResetDeath );
    GRM_UI.GRM_Mouseover.GRM_ClearDeathButton.Text:SetText ( GRM.L ( "Player is Still Alive" ) )

    GRM_UI.CreateString ( "GRM_RIPtext" , GRM_UI.GRM_Mouseover , "GameFontNormal" , "" , 15 , { "BOTTOM" , GRM_UI.GRM_Mouseover , "TOP" , 0 , 0 } , nil , nil , "CENTER" , false );

    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover , "TOPRIGHT" , -7 , 0 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:SetSize ( 438 , 146 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:SetFrameStrata ( "HIGH" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.timer = 0;
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_SyncJoinDateText:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame , 0 , -15 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_SyncJoinDateText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 , "THICKOUTLINE" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_SyncJoinDateText:SetText ( GRM.L ( "Please Select Which Join Date to Sync" ) );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_SyncJoinDateText:SetWidth ( 379 );

    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame , "TOPLEFT" , 10 , -25 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton:SetSize ( 366 , 24 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton , "LEFT" , 10 , 0 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton , "BOTTOMLEFT" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButton:SetSize ( 366 , 24 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButton , "LEFT" , 10 , 0 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDMainButton , "BOTTOMLEFT" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButton:SetSize ( 366 , 24 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButton , "LEFT" , 10 , 0 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSelectedPlayerButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame , "BOTTOMLEFT" , 10 , 10 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButton:SetSize ( 366 , 24 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButton , "LEFT" , 10 , 0 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButtonText:SetText ( GRM.L ( "Cancel" ) );

    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDSyncCancelButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            GRM.PopulateMemberDetails ( GRM_G.currentName );
            GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
        end
    end);

    -- Do not want to give player the option to sync JD data if they remove all their alts or reset JD data whilst this frame is open... close it if changes. Check every 2 seconds.
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:SetScript ( "OnUpdate" , function ( self , elapsed )
        self.timer = self.timer + elapsed;
        if self.timer > 2 then
            if not GRM.PlayerOrAltHasJD ( GRM_G.currentName ) then
                self:Hide();
            end
            self.timer = 0;
        end
    end)
    -- Logic for syncing JDs...
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame.GRM_JDOldestButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            GRM.SyncJoinDateUsingEarliest();
            GRM.PopulateMemberDetails ( GRM_G.currentName );
            GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
        end
    end);


    -- Logic for when the sync frame loads up...
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:SetScript ( "OnShow" , function ( self )
        -- True for each of the buttons... which will depend on the logic of what to show.
        local count = 0;
        local mainName = "";
        local playerHasJD = GRM.PlayerHasJoinDate ( GRM_G.currentName );
        local oldestPlayerAndDate , oldestDate = GRM.GetAltWithOldestJoinDate ( GRM_G.currentName );
        local mainHasJD = {};

        -- Ok, need this data in case we want to sync to the main. But we don't want to ask the player that if main has no date set...
        if GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:IsVisible() then
            mainName = GRM_G.currentName;
        else
            mainName = GRM.GetPlayerMain ( GRM_G.currentName );
        end
        -- Get Main info...
        if mainName and mainName ~= "" and mainName ~= GRM_G.currentName then
            mainHasJD = GRM.PlayerHasJoinDate ( mainName );
        end

        -- First Button
        self.GRM_JDOldestButtonText:SetText ( ">  " .. GRM.L ( "Sync All Alts to the Earliest Join Date: {name}" , GRM.GetClassifiedName ( oldestPlayerAndDate , true ) ) .. " |CFFFF0000- " .. oldestDate );

        -- Second Button
        if mainName and mainName ~= "" and mainName ~= GRM_G.currentName and oldestPlayerAndDate ~= mainName and mainHasJD[1] then
            self.GRM_JDMainButtonText:SetText ( ">  " .. GRM.L ( "Sync All Alts to {name}'s |cffff0000(main)|r Join Date" , GRM.GetClassifiedName ( mainName , true ) ) .. " |CFFFF0000- " .. mainHasJD[2]  );
            -- Set the script to proper button
            self.GRM_JDMainButton:SetScript ( "OnClick" , function ( _ , button )
                if button == "LeftButton" then
                    GRM.SyncJoinDateUsingMain();
                    GRM.PopulateMemberDetails ( GRM_G.currentName );
                    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
                end
            end);
            self.GRM_JDMainButton:Show();
            count = count + 1;
        elseif oldestPlayerAndDate ~= GRM_G.currentName and playerHasJD[1] then
            self.GRM_JDMainButtonText:SetText ( ">  " .. GRM.L ( "Sync All Alts to {name}'s Join Date" , GRM.GetClassifiedName ( GRM_G.currentName , true ) ) .. " |CFFFF0000- " .. playerHasJD[2] );
            self.GRM_JDMainButton:SetScript ( "OnClick" , function ( _ , button )
                if button == "LeftButton" then
                    GRM.SyncJoinDateUsingCurrentSelected();
                    GRM.PopulateMemberDetails ( GRM_G.currentName );
                    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
                end
            end);
            self.GRM_JDMainButton:Show();
            count = count + 2;
        end

        -- Third Button
        -- If the 2nd button wasn't filled, well, neither will the third... hide both the 2nd and 3rd buttons
        if count == 0 then
            self.GRM_JDMainButton:Hide();
            self.GRM_JDSelectedPlayerButton:Hide();
            -- transform logic to size for just 1 button
            self:SetSize ( 439 , 93 )

        -- This means that the potential 3rd position was filled to the 2nd, thus we can hide the 3rd button.
        elseif count == 2 then
            self.GRM_JDSelectedPlayerButton:Hide();
            -- transform logic to size for just 2 buttons
            self:SetSize ( 439 , 119 )
        -- this means that the first button was filled, the 2nd button was filled, now let's determine if the 3rd button will also be filled.
        elseif count == 1 then
            -- No need to repeat this, since the oldest will permanently be on button 1
            if oldestPlayerAndDate[1] ~= GRM_G.currentName and playerHasJD[1] then
                self:SetSize ( 439 , 146 );
                self.GRM_JDSelectedPlayerButtonText:SetText ( ">  " .. GRM.L ( "Sync All Alts to {name}'s Join Date" , GRM.GetClassifiedName ( GRM_G.currentName , true ) ) .. " |CFFFF0000- " .. playerHasJD[2] );
                self.GRM_JDSelectedPlayerButton:SetScript ( "OnClick" , function ( self , button )
                    if button == "LeftButton" then
                        GRM.SyncJoinDateUsingCurrentSelected();
                        GRM.PopulateMemberDetails ( GRM_G.currentName );
                        self:Hide();
                    end
                end);
                self.GRM_JDSelectedPlayerButton:Show();
            else
                self:SetSize ( 439 , 119 )
                self.GRM_JDSelectedPlayerButton:Hide();
            end
        end
    end);


    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        elseif key == "ESCAPE" then
            self:Hide();
        end
    end);

    -- Day Dropdown
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:SetSize ( 40 , 24 );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected , "RIGHT" , 5 , 0 );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:SetFrameStrata ( "HIGH" );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected , "BOTTOM" );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:SetWidth ( 45 );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:SetFrameStrata ( "HIGH" );

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected.GRM_DayText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected );
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected.GRM_DayText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 13 );

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )

        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Show();
        end

    end);

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:Hide();
    end);

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:SetScript ( "OnEnter" , function( self )
        if not GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:IsVisible() then
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change Day" ) );
            GameTooltip:Show();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end)

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:SetScript ( "OnMouseDown" , function ( _ , button )
        if button == "LeftButton" then
            if GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:Hide();
            else
                GRM_UI.DD.InitializeDropDownDay();
                GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:Show();
                GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:Hide();
                GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:Hide();
            end
        end
    end);

    -- Month dropdown
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetSize ( 110 , 24 );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt , "BOTTOM" , -86.5 , -4  );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetFrameStrata ( "HIGH" );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected , "BOTTOM" );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:SetWidth ( 106 );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:SetFrameStrata ( "HIGH" );

    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected.GRM_MonthText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected );
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected.GRM_MonthText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 13 );

    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Show();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:Hide();
    end);

    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetScript ( "OnEnter" , function( self )
        if not GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:IsVisible() then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change Month" ) );
            GameTooltip:Show();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end)

    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetScript ( "OnMouseDown" , function ( _ , button )
        if button == "LeftButton" then
            if GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:Hide();
            else
                GRM_UI.DD.InitializeDropDownMonth();
                GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:Show();
                GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:Hide();
                GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:Hide();
            end
        end
    end);

    -- Year Dropdown
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:SetSize ( 110 , 24 );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected , "RIGHT" , 5 , 0 );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:SetFrameStrata ( "HIGH" );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected , "BOTTOM" );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:SetWidth ( 69 );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:SetFrameStrata ( "HIGH" );

    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected.GRM_YearText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected );
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected.GRM_YearText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 13 );

    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
                GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Show();
            end
        elseif key == "ESCAPE" then
            self:Hide();
            GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Show();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:SetScript ( "OnShow" , function()
        GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:Hide();
    end);

    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:SetScript ( "OnEnter" , function( self )
        if not GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:IsVisible() then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to Change Year" ) );
            GameTooltip:Show();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end)

    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:SetScript ( "OnMouseDown" , function ( _ , button )
        if button == "LeftButton" then
            if GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:Hide();
            else
                GRM_UI.DD.InitializeDropDownYear();
                GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:Show();
                GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:Hide();
                GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:Hide();
            end
        end
    end);

    --Rank Drop down submit and cancel
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:SetSize ( 119 , 24 );
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt , "BOTTOM" , 0 , -4 );
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton.GRM_SetPromoDateButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton );
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton.GRM_SetPromoDateButtonText:SetText ( GRM.L ( "Date Promoted?" ) );
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton.GRM_SetPromoDateButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:GetWidth() , GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton.GRM_SetPromoDateButtonText , 2 );
    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:SetScript( "OnClick" , function ( self , button )
        if button == "LeftButton" then
            self:Hide();
            GRM.SetDateSelectFrame ( "PromoRank" );  -- Position, Frame, ButtonName
            GRM_G.pause = true;
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:SetScript( "OnShow" , function ()
        GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
    end);

    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_DateSubmitButton , "RIGHT" , 6 , 0 );
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:SetWidth( 98.5 );
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton.GRM_SetUnknownButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_SetUnknownButton );
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton.GRM_SetUnknownButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10.5 );
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton.GRM_SetUnknownButtonText:SetText ( GRM.L ( "Unknown" ) );
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" and not GRM_UI.GRM_Mouseover.GRM_DayDropDownMenu:IsVisible() then
            local buttonText = GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:GetText();
            if buttonText == GRM.L ( "Set Join Date" ) or buttonText == GRM.L ( "Edit Join Date" ) then
                GRM.ClearJoinDateHistory ( GRM_G.currentName , true );
                GRM.DateSubmitCancelResetLogic( true , "join" , false , nil);
            elseif buttonText == GRM.L ( "Set Promo Date" ) or buttonText == GRM.L ( "Edit Promo Date" ) then
                GRM.ClearPromoDateHistory ( GRM_G.currentName , true );
                GRM.DateSubmitCancelResetLogic( true , "promo" , false , nil );
            elseif not GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:IsVisible() and ( buttonText == GRM.L ( "Set Birthday" ) or buttonText == GRM.L ( "Edit Birthday" ) ) then
                GRM.ResetBirthdayForAltGroup ( GRM_G.currentName , 0 , true , nil , false);
                GRM.DateSubmitCancelResetLogic ( true , "bday" , false , nil );
            end

            GRM_UI.RefreshSelectFrames ( false , true , false , false , false , false );

            if GRM.PlayerOrAltHasJD ( GRM_G.currentName ) then
                if GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton , "RIGHT" , 0 , 0 );
                elseif GRM_UI.GRM_Mouseover.GRM_JoinDateText:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_JoinDateText , "RIGHT" , 8 , -0.5 );
                end
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Hide();
            end

        end
    end);

    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:SetScript ( "OnEnter" , function( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        GameTooltip:AddLine( GRM_UI.GRM_Mouseover.GRM_SetUnknownButton.GRM_SetUnknownButtonText:GetText() );
        GameTooltip:Show();
    end)
    GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);


    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" and not GRM_UI.GRM_Mouseover.GRM_YearDropDownMenu:IsVisible() then
            GRM.DateSubmitCancelResetLogic( false , nil , false , nil );
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:SetScript ( "OnEnter" , function( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        GameTooltip:AddLine( GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButtonTxt:GetText() );
        GameTooltip:Show();
    end)
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

    -- Name Text
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:SetPoint( "TOP" , 0 , -30 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:SetFont (  GRM_G.FontChoice , GRM_G.FontModifier + 21 );

    -- LEVEL Text
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLevel:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText , "BOTTOM" , 0 , -4 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLevel:SetFont (  GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Rank promotion date text
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailLevel , "BOTTOM" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt:SetFont (  GRM_G.FontChoice , GRM_G.FontModifier + 18 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt:SetTextColor ( 0.90 , 0.80 , 0.50 , 1.0 );

    -- Reputation text
    GRM_UI.GRM_Mouseover.GRM_ReputationLevelText:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt , "TOP" , -2 , 3 );
    GRM_UI.GRM_Mouseover.GRM_ReputationLevelText:SetFont (  GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_Mouseover , "TOPRIGHT" , -5 , -4 );
    GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText:SetFont (  GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText:SetTextColor ( 1 , 0 , 0 , 1 );
    GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText:SetText ( GRM.L ( "Locked. Press ESC" ) );
    GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText:Hide();

    -- "MEMBER SINCE"
    GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt , "BOTTOM" , -3 , -2 );
    GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetSize ( 12 , 12 );
    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:GetNormalTexture():SetRotation ( -1.57 ); -- Sets the arrow to the right.
    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:GetPushedTexture():SetRotation ( -1.57 ); -- Sets down texture arrow to the right.

    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetScript ( "OnEnter" , function ( self )
        if GRM.PlayerOrAltHasJD ( GRM_G.currentName ) then
            GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip:SetOwner ( self , "ANCHOR_CURSOR" );

            if GRM.IsAltJoinDatesSynced ( GRM_G.currentName ) then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip:AddLine( GRM.L ( "Join Date of All Alts is Currently Synced" ) );
            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip:AddLine( GRM.L ( "{custom1} to sync join date among all alts in grouping." , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Click" ) .. "|r" ) );
            end
            GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip:Show();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetScript ( "Onleave" , function()
        GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip:Hide();
    end);

    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetScript ( "OnClick" , function ( _ , button )
        -- Special Logic for sync dates.
        if button == "LeftButton" then
            if not GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:IsVisible() then
                if GRM.PlayerOrAltHasJD ( GRM_G.currentName ) and not GRM.IsAltJoinDatesSynced( GRM_G.currentName ) then
                -- Hide the other custom frame...
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailNJDSyncTooltip:Hide();
                    GRM_G.pause = true;
                    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Show();
                end
            else
                GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
            end
        end
    end);

    -- Alt details Side button
    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow , "BOTTOMRIGHT" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:SetSize ( 12 , 12 );
    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:GetNormalTexture():SetRotation ( -1.57 ); -- Sets the arrow to the right.
    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:GetPushedTexture():SetRotation ( -1.57 ); -- Sets down texture arrow to the right.

    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:SetScript ( "OnEnter" , function ()
        if not GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "{custom1} to keep alt details open." , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Click" ) .. "|r" ) );
            GameTooltip:Show();
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Show();        -- The OnShow will have the trigger action...
            GRM_G.pause = true;
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:SetScript ( "OnLeave" , function()
        if not GRM_G.AltSideWindowFreeze then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide();
            GRM_G.pause = false;
        end
        GRM.RestoreTooltip();
    end);

    GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            if GRM_G.AltSideWindowFreeze and GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide();
            else
                if not GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Show();
                end
                GRM_G.pause = true;
                GRM_G.AltSideWindowFreeze = true;
                GRM.RestoreTooltip();
            end
        end
    end);

    -- "LAST ONLINE"
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover , 8 , -32 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt:SetJustifyH ( "CENTER" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt:SetWidth ( 106 )
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt:SetText ( GRM.L ( "Last Online" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 , "THICKOUTLINE" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTitleTxt , "BOTTOM" , -2 , -2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt:SetWidth ( 86 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt:SetJustifyH ( "CENTER" );

    -- PLAYER STATUS
    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt , "BOTTOM" , 0 , - 18 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetWidth ( 100 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetJustifyH ( "CENTER" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetWordWrap ( false );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM.ConfigureOnlineStatusText();

    -- ZONE
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle , "TOPLEFT" , 5 , 15 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:SetText ( GRM.L ( "Time In:" ) .. " " );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1 , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1 , "TOPLEFT" , -5 , 2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 , "THICKOUTLINE" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:SetText ( GRM.L ( "Zone:" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );


    -- Is Main Note!
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText , "TOP" , 0 , 2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:SetText ( GRM.L ( "( Main )" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:SetTextColor ( 1.0 , 0.0 , 0.0 , 1.0 );

    GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText , "TOP" , 0 , 2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText:SetText ( "( " .. GRM.L ( "Alt" ) .. " )" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText:SetTextColor ( 1.0 , 0.5 , 0.5 , 1.0 );

    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetTextColor ( 1 , 1 , 1 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt , "BOTTOM" , 0 , -4 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Join Date Button Logic for visibility
    GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover , -10 , -32 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt:SetText ( GRM.L ( "Date Joined" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt:SetWidth ( 106 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt:SetJustifyH ( "CENTER" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 , "THICKOUTLINE" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailDateJoinedTitleTxt , "BOTTOM" , -2 , -2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:SetSize ( 106 , 22.5 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButtonText:SetText ( GRM.L ( "Join Date?" ) )
    GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:GetWidth() , GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButtonText , 2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:SetScript ( "OnClick" , function ( self , button )
        if button == "LeftButton" then
            self:Hide();
            if GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
            elseif GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Hide();
            end

            if GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Hide();
            end

            GRM.SetDateSelectFrame ( "JoinDate" );  -- Position, Frame, ButtonName
            GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
            GRM_G.pause = true;
        end
    end);

    -- Birthday Button and text
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton , "BOTTOM" , 0 , -5 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText:SetText ( GRM.L ( "Birthday" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 , "THICKOUTLINE" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText , "BOTTOM" , 0 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:SetSize ( 106 , 22.5 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText:SetText ( GRM.L ( "Set Birthday" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText:SetWidth ( 100 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText:SetWordWrap ( true );
    GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText , "BOTTOM" , -1.5 , -2 );
    GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetWidth ( 89 );
    GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetJustifyH ( "CENTER" );
    GRM_UI.GRM_Mouseover.GRM_BirthdayText:Hide();

    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:SetScript ( "OnClick" , function ( self , button )
        if button == "LeftButton" then
            self:Hide();
            if GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
            elseif GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Hide();
            end
            GRM.SetDateSelectFrame ( "Birthday" );  -- Position, Frame, ButtonName
            GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
            GRM_G.pause = true;
        end
    end);

    -- GROUP INVITE BUTTON
    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover , 16, 13 )
    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:SetSize ( 93 , 26 );
    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton.GRM_GroupInviteButtonText:SetText ( GRM.L ( "Group Invite" ) );
    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton.GRM_GroupInviteButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_GroupInviteButton );
    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton.GRM_GroupInviteButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );


    -- player note edit box and font string (31 characters)
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow , "TOPLEFT" , 5 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle:SetText ( GRM.L ( "Note:" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle:SetWidth ( 159 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle:SetWordWrap ( false );

    GRM_UI.GRM_Mouseover.GRM_MemberDetailONoteTitle:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow , "TOPLEFT" , 5 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailONoteTitle:SetText ( GRM.L ( "Officer's Note:" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailONoteTitle:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailONoteTitle:SetWidth ( 159 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailONoteTitle:SetWordWrap ( false );

    -- OFFICER AND PLAYER NOTES
    GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow:SetPoint( "LEFT" , GRM_UI.GRM_Mouseover , 15 , 10 );
    GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow:SetSize ( 166 , 53 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow , 8 , -7 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetWordWrap ( true );
    GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetSpacing ( 1 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetWidth ( 143 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetMaxLines ( 3 );

    -- Officer Note
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow:SetPoint( "RIGHT" , GRM_UI.GRM_Mouseover , -15 , 10 );
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow:SetSize ( 166 , 53 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow , 8 , -7 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetWordWrap ( true );
    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetSpacing ( 1 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetWidth ( 143 );
    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetMaxLines ( 3 );

    if not GRM.S() or GRM.S().showBorders then
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow:SetBackdrop ( GRM_UI.noteBackdrop );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow:SetBackdrop ( GRM_UI.noteBackdrop );
    else
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow:SetBackdrop ( GRM_UI.framelessBackdrop );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow:SetBackdrop ( GRM_UI.framelessBackdrop );
    end

    -- Due to sizing and spacing... don't want to allow font manipulation of the edits...
    GRM_UI.GRM_Mouseover.GRM_MemberDetailONoteTitle:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNoteTitle:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.ReconfigureNoteFonts = function()
        GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetFontObject ( "GameFontWhite" );
        if not GRM_G.BuildHasRestrictions then
            GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetFontObject ( "GameFontWhite" );
            GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetFontObject ( "GameFontWhite" );
        end
    end

    if not GRM_G.BuildHasRestrictions then
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow , "TOP" , 0 , 0 );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow , "BOTTOM" , 0 , 0 );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetSize ( 166 , 60 );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetTextInsets ( 8 , 9 , 9 , 8 );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetMaxLetters ( 31 );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetMultiLine ( true );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetSpacing ( 1 );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:EnableMouse ( true );
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetFrameStrata ( "HIGH" );
        GRM_UI.GRM_Mouseover.GRM_NoteCount:SetPoint ("TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow , -6 , 8 );

        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetPoint( "TOP" , GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow , "TOP" , 0 , 0 );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetPoint( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow , "BOTTOM" , 0 , 0 );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetSize ( 166 , 60 );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetTextInsets( 8 , 9 , 9 , 8 );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetMaxLetters ( 31 );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetMultiLine( true );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetSpacing ( 1 );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:EnableMouse( true );
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetFrameStrata ( "HIGH" );

        GRM_UI.GRM_Mouseover.GRM_NoteCount:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    
        -- Script handlers on Note Edit Boxes
        local defNotes = {};
        defNotes.defaultNote = GRM.L ( "Click here to set a Public Note" );
        defNotes.defaultONote = GRM.L ( "Click here to set an Officer's Note" );
        defNotes.tempNote = "";
        defNotes.finalNote = "";

        -- Script handlers on Note Frames
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow:SetScript ( "OnMouseDown" , function ( self , button )
            if button == "LeftButton" and GRM.CanEditPublicNote() or GRM_G.currentName == GRM_G.addonUser then
                GRM_UI.GRM_Mouseover.GRM_NoteCount:SetPoint ("TOPRIGHT" , self , -6 , 8 );
                GRM_G.pause = true;
                GRM_UI.GRM_Mouseover.GRM_noteFontString1:Hide();
                GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
                GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
                defNotes.tempNote = GRM_UI.GRM_Mouseover.GRM_noteFontString2:GetText();
                if defNotes.tempNote ~= defNotes.defaultONote and defNotes.tempNote ~= "" then
                    defNotes.finalNote = defNotes.tempNote;
                else
                    defNotes.finalNote = "";
                end
                GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetText( defNotes.finalNote );
                GRM_UI.GRM_Mouseover.GRM_noteFontString2:Show();

                GRM_UI.GRM_Mouseover.GRM_NoteCount:SetText( GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:GetNumLetters() .. "/31");
                GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:Show();
                GRM_UI.GRM_Mouseover.GRM_NoteCount:Show();
                GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:Hide();
            end
        end);

        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow:SetScript ( "OnMouseDown" , function ( self , button )

            if button == "LeftButton" and GRM.CanEditOfficerNote() then
                GRM_UI.GRM_Mouseover.GRM_NoteCount:SetPoint ("TOPRIGHT" , self , -6 , 8 );
                GRM_G.pause = true;
                GRM_UI.GRM_Mouseover.GRM_noteFontString2:Hide();
                GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
                defNotes.tempNote = GRM_UI.GRM_Mouseover.GRM_noteFontString1:GetText();
                if defNotes.tempNote ~= defNotes.defaultNote and defNotes.tempNote ~= "" then
                    defNotes.finalNote = defNotes.tempNote;
                else
                    defNotes.finalNote = "";
                end
                GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetText( defNotes.finalNote );
                GRM_UI.GRM_Mouseover.GRM_noteFontString1:Show();

                -- How many characters initially
                GRM_UI.GRM_Mouseover.GRM_NoteCount:SetText( GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:GetNumLetters() .. "/31" );
                GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:Show();
                GRM_UI.GRM_Mouseover.GRM_NoteCount:Show();
                GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:Hide();

                -- Clear the Tooltip
                if GRM_UI.GRM_Mouseover.GRM_OfficerNoteTooltip:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_OfficerNoteTooltip:Hide();
                end
            end
        end);

        -- Method:          GRM_UI.PlayerPublicNoteEditBox()
        -- What it Does:    Performs the exit note logic where it does not save the public note
        -- Purpose:         Repeat use, clean logic use
        GRM_UI.PlayerPublicNoteEditBox = function()
            GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:Hide();
            GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
            defNotes.tempNote = GRM_UI.GRM_Mouseover.GRM_noteFontString1:GetText();
            if defNotes.tempNote ~= defNotes.defaultNote and defNotes.tempNote ~= "" then
                defNotes.finalNote = defNotes.tempNote;
            else
                defNotes.finalNote = "";
            end
            GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetText ( defNotes.finalNote );
            GRM_UI.GRM_Mouseover.GRM_noteFontString1:Show();
            if GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:IsVisible() ~= true then            -- Does not unpause if the date still needs to be selected or canceled.
                GRM_UI.Unpause();
            end
        end

        -- Cancels editing in Note editbox
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetScript ( "OnEscapePressed" , GRM_UI.PlayerPublicNoteEditBox );

        -- Edit focus lost logic on both editboxes
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetScript ( "OnEditFocusLost" , function( self )
            self:Hide();
            GRM_UI.GRM_Mouseover.GRM_noteFontString1:Show();
        end);
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetScript ( "OnEditFocusLost" , function( self )
            self:Hide();
            GRM_UI.GRM_Mouseover.GRM_noteFontString2:Show();
        end);

        -- Updates char count as player types.
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetScript ( "OnTextChanged" , function ( self )
            GRM_UI.GRM_Mouseover.GRM_NoteCount:SetText ( self:GetNumLetters() .. "/31" );
        end);

        -- Updating the new information to Public Note
        GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetScript ( "OnEnterPressed" , function ( self )
            local playerDetails = {};
            playerDetails.newNote = self:GetText();
            playerDetails.name = GRM_G.currentName;
            local player = GRM.GetPlayer ( playerDetails.name );

            if player then
                -- First, let's add the change to the official server-sde note
                local h = GRM.GetRosterSelectionID ( playerDetails.name , player.GUID );
                if h then
                    local publicNote = select ( 7 , GetGuildRosterInfo( h ) );
                    if not publicNote then
                        publicNote = "";
                    end

                    if not GRM_G.BuildHasRestrictions and publicNote ~= playerDetails.newNote and ( GRM.CanEditPublicNote() or GRM_G.currentName == GRM_G.addonUser ) then      -- No need to update old note if it is the same.

                        -- Saving the changes!
                        player.note = playerDetails.newNote;                        -- Metadata
                        GRM.SetNote ( player.GUID, playerDetails.newNote, true, h );

                        if GRM_G.CurrentlyScanning then
                            GRM_G.changeHappenedExitScan = true;
                        end

                        -- To metadata reporting
                        local simpleName = GRM.GetStringClassColorByName ( playerDetails.name ) .. GRM.SlimName ( playerDetails.name ) .. "|r";
                        local logReportWithTime , logReport = GRM.GetNoteChangeString ( simpleName , publicNote , playerDetails.newNote , GRM.Time.GetTimestamp() );

                        if GRM.S().toChat.note then
                            GRM.Log.PrintLog ( { 4 , logReport } );
                        end
                        -- Also adding it to the log!
                        GRM.Log.AddLog ( { 4 , logReportWithTime , simpleName , publicNote , playerDetails.newNote , GRM.Time.GetTimestamp() } );

                        -- Set the note
                        local theNote = "";
                        if #playerDetails.newNote == 0 then
                            GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetText ( defNotes.defaultNote );
                            theNote = defNotes.defaultNote;
                        else
                            GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetText ( playerDetails.newNote );
                            theNote = playerDetails.newNote;
                        end
                        -- update the edit box
                        self:SetText( playerDetails.newNote );

                        -- If the memberdetailframe is open, set it as well...
                        if GRM.SlimName ( CommunitiesFrame.GuildMemberDetailFrame.Name:GetText() ) == GRM.SlimName ( GRM_G.currentName ) then
                            if CommunitiesFrame.GuildMemberDetailFrame.NoteBackground.PersonalNoteText and CommunitiesFrame.GuildMemberDetailFrame.NoteBackground.PersonalNoteText:IsVisible() then
                                CommunitiesFrame.GuildMemberDetailFrame.NoteBackground.PersonalNoteText:SetText ( theNote );
                            end
                        end

                        if GRM_UI.GRM_AuditJDTool:IsVisible() then
                            GRM.AuditRefresh( true );
                        end

                        GRM_UI.RefreshSelectFrames ( true , false , false , false , true , false );
                    end
                end
            end

            self:Hide();
            GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
            GRM_UI.GRM_Mouseover.GRM_noteFontString1:Show();
            if GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:IsVisible() ~= true then            -- Does not unpause if the date still needs to be selected or canceled.
                GRM_UI.Unpause();
            end
        end);

        -- Method:          GRM_UI.EscapeOfficerNoteEditBox ()
        -- What it Does:    Holds the logic for the editbox
        -- Purpose:         For repeat use...
        GRM_UI.EscapeOfficerNoteEditBox = function ()
            GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:Hide();
            GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
            defNotes.tempNote = GRM_UI.GRM_Mouseover.GRM_noteFontString2:GetText();
            if defNotes.tempNote ~= defNotes.defaultONote and defNotes.tempNote ~= "" then
                defNotes.finalNote = defNotes.tempNote;
            else
                defNotes.finalNote = "";
            end
            GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetText( defNotes.finalNote );
            GRM_UI.GRM_Mouseover.GRM_noteFontString2:Show();
            if GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:IsVisible() ~= true then            -- Does not unpause if the date still needs to be selected or canceled.
                GRM_UI.Unpause();
            end
        end

        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetScript ( "OnEscapePressed" , GRM_UI.EscapeOfficerNoteEditBox );

        -- Updates char count as player types.
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetScript ( "OnTextChanged" , function ( self )
            GRM_UI.GRM_Mouseover.GRM_NoteCount:SetText( self:GetNumLetters() .. "/31" );
        end);

        -- Updating the new information to Public Note
        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetScript ( "OnEnterPressed" , function ( self )
            local playerDetails = {};
            playerDetails.newNote = self:GetText();
            playerDetails.name = GRM_G.currentName;

            local player = GRM.GetPlayer ( playerDetails.name );

            if player then
                -- First, let's add the change to the official server-sde note
                local h = GRM.GetRosterSelectionID ( playerDetails.name , player.GUID );
                if h then
                    local officerNote = select ( 8 , GetGuildRosterInfo( h ) );
                    if not officerNote then
                        officerNote = "";
                    end

                    if not GRM_G.BuildHasRestrictions and officerNote ~= playerDetails.newNote and GRM.CanEditOfficerNote() then      -- No need to update old note if it is the same.

                        -- Saving the new note details!
                        player.officerNote = playerDetails.newNote;      -- to addon metadata
                        GRM.SetNote ( player.GUID, playerDetails.newNote, false, h );
                        if GRM_G.CurrentlyScanning then
                            GRM_G.changeHappenedExitScan = true;
                        end

                        -- To metadata reporting
                        local simpleName = GRM.GetStringClassColorByName ( playerDetails.name ) .. GRM.SlimName ( playerDetails.name ) .. "|r";
                        local logReportWithTime , logReport = GRM.GetOfficerNoteChangeString ( simpleName , officerNote , playerDetails.newNote , GRM.Time.GetTimestamp() );

                        if GRM.S().toChat.officerNote then
                            GRM.Log.PrintLog ( { 5 , logReport } );
                        end
                        -- Also adding it to the log!
                        GRM.Log.AddLog ( { 5 , logReportWithTime , simpleName , officerNote , playerDetails.newNote , GRM.Time.GetTimestamp() } );

                        local theNote = "";
                        if #playerDetails.newNote == 0 then
                            GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetText ( defNotes.defaultONote );
                            theNote = defNotes.defaultONote;
                        else
                            GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetText ( playerDetails.newNote );
                            theNote = playerDetails.newNote;
                        end
                        self:SetText( playerDetails.newNote );

                        if GRM_UI.MemberDetailFrame:IsVisible() then
                            if GRM.SlimName ( CommunitiesFrame.GuildMemberDetailFrame.Name:GetText() ) == GRM.SlimName ( GRM_G.currentName ) then
                                GRM_UI.MemberDetailFrame.OfficerNoteBackground.OfficerNoteText:SetText( theNote );
                            end
                        end

                        if GRM_UI.GRM_AuditJDTool:IsVisible() then
                            GRM.AuditRefresh( true );
                        end
                        GRM_UI.RefreshSelectFrames ( true , false , false , false , true , false );
                    end
                end
            end

            self:Hide();
            GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
            GRM_UI.GRM_Mouseover.GRM_noteFontString2:Show();
            if GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:IsVisible() ~= true then            -- Does not unpause if the date still needs to be selected or canceled.
                GRM_UI.Unpause();
            end
        end);

    end

    -- Reusable function for the Ignroe rules selection window
    GRM_UI.ReEnableSubIgnoreOption = function ( button , text , editBox )
        button:Enable();
        editBox:Enable();
        text:SetTextColor ( 1 , 0.82 , 0 );
        editBox:SetTextColor ( 1 , 1 , 1 );
    end

    -- Reusable function for the Ignroe rules selection window
    GRM_UI.DisableSubIgnoreOption = function ( button , text , editBox )
        button:Disable();
        editBox:Disable();
        text:SetTextColor ( 0.5 , 0.5 , 0.5 );
        editBox:SetTextColor ( 0.5 , 0.5 , 0.5 );
    end  

    -- Rebuild the checkbox frame here...
    GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow = function()
        local ruleEnum = { [false] = "|CFF00CCFF" .. GRM.L ( "Monitoring" ) .. "|r" , [true] = "|CFFFF0000" .. GRM.L ( "Ignoring" ) .. "|r" };
        local disabled = "|CFFFF0000" .. GRM.L ( "Disabled at Current Rank" ) .. "|r";
        local color1 , color2 , color3 = "" , "" , "";
        local baseHeight = 245;
        local player = GRM.GetPlayer ( GRM_G.currentName );
        GRM_MacroToolIgnoreListSettingsFrame.currentName = GRM_G.currentName;

        if not player.safeList then
            player.safeList = GRM.GenerateSafeListForPlayer();
        end

        GRM.ValidateIgnoreExpireDates ( player );

        if player.safeList.kick[1] then
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox:SetChecked( true );
            GRM_UI.ReEnableSubIgnoreOption ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox );
            color1 = "|CFF00CCFF";

        else
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox:SetChecked ( false );
            color1 = "|CFF7F7F7F";
            -- Adjust coloring and use of sub option
            GRM_UI.DisableSubIgnoreOption ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox );
        end

        if player.safeList.promote[1] then
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:SetChecked( true );
            GRM_UI.ReEnableSubIgnoreOption ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox );
            color2 = "|CFF00CCFF";
        else
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:SetChecked ( false );
            GRM_UI.DisableSubIgnoreOption ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox );
            color2 = "|CFF7F7F7F";
        end

        if player.safeList.demote[1] then
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:SetChecked( true );
            GRM_UI.ReEnableSubIgnoreOption ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox );
            color3 = "|CFF00CCFF";
        else
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:SetChecked ( false );
            GRM_UI.DisableSubIgnoreOption ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox );
            color3 = "|CFF7F7F7F";
        end

        -- Kick ignore list tiime expire config
        if player.safeList.kick[2] then
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:SetChecked ( true );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:ClearAllPoints();

            if player.safeList.kick[1] then
                local date = "";
                local timeLeft = "";
                if player.safeList.kick[4] > 0 then
                    date = GRM.Time.EpochToDateFormat ( player.safeList.kick[4] - ( player.safeList.kick[3] * 86400 ) );
                    timeLeft = GRM.Time.GetTimePassedInZone ( nil , player.safeList.kick[4] - time() , true );
                end
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:SetText ( GRM.L ( "Configured: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. date .. "|r" ) );
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:SetText ( GRM.L ( "Time Left: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. timeLeft .. "|r" ) );

                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:Show();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:Show();
                baseHeight = baseHeight + GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.modifier;
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , "BOTTOMLEFT" , 10 , - ( 1 + GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.modifier ) );

            else
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:Hide();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:Hide();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , "BOTTOMLEFT" , 10 , -1 );
            end

        else
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:SetChecked ( false );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:ClearAllPoints();
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , "BOTTOMLEFT" , 10 , -1 );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:Hide();
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:Hide();
        end


        -- PROMOTE FILTERS
        if player.safeList.promote[2] then
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:SetChecked ( true );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:ClearAllPoints();

            if player.safeList.promote[1] then
                local date = "";
                local timeLeft = "";
                if player.safeList.promote[4] > 0 then
                    date = GRM.Time.EpochToDateFormat ( player.safeList.promote[4] - ( player.safeList.promote[3] * 86400 ) );
                    timeLeft = GRM.Time.GetTimePassedInZone ( nil , player.safeList.promote[4] - time() , true );
                end
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:SetText ( GRM.L ( "Configured: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. date .. "|r" ) );
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:SetText ( GRM.L ( "Time Left: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. timeLeft .. "|r" ) );

                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:Show();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:Show();
                baseHeight = baseHeight + GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.modifier;
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , "BOTTOMLEFT" , 10 , - ( 1 + GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.modifier ) );

            else
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:Hide();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:Hide();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , "BOTTOMLEFT" , 10 , -1 );
            end


        else

            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:SetChecked ( false );

            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:ClearAllPoints();
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , "BOTTOMLEFT" , 10 , -1 );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:Hide();
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:Hide();
        end


        -- DEMOTE FILTERS
        if player.safeList.demote[2] then
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:SetChecked ( true );

            if player.safeList.demote[1] then
                local date = "";
                local timeLeft = "";
                if player.safeList.demote[4] > 0 then
                    date = GRM.Time.EpochToDateFormat ( player.safeList.demote[4] - ( player.safeList.demote[3] * 86400 ) );
                    timeLeft = GRM.Time.GetTimePassedInZone ( nil , player.safeList.demote[4] - time() , true );
                end
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:SetText ( GRM.L ( "Configured: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. date .. "|r" ) );
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:SetText ( GRM.L ( "Time Left: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. timeLeft .. "|r" ) );

                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:Show();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:Show();
                baseHeight = baseHeight + GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.modifier;


            else
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:Hide();
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:Hide();
            end

        else

            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:SetChecked ( false );

            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:Hide();
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:Hide();
        end

        -- Monitoring/Ignored text
        local kickMsg , promoteMsg, demoteMsg = "" , "" , "";

        if CanGuildRemove() then
            kickMsg = ruleEnum[player.safeList.kick[1]];
        else
            kickMsg = disabled;
        end

        if CanGuildPromote() then
            promoteMsg = ruleEnum[player.safeList.promote[1]];
        else
            promoteMsg = disabled;
        end

        if CanGuildDemote() then
            demoteMsg = ruleEnum[player.safeList.demote[1]];
        else
            demoteMsg = disabled;
        end

        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText2:SetText ( kickMsg );
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText2:SetText ( promoteMsg );
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText2:SetText ( demoteMsg );

        -- Expire checkboxs
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetText ( player.safeList.kick[3] );
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText:SetText ( GRM.L ( "Reactivate monitoring after {num} days." , nil , nil , color1 .. player.safeList.kick[3] .. "|r" ) .. "  " .. GRM.L ( "Set Days:" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText );
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetText ( player.safeList.promote[3] );
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText:SetText ( GRM.L ( "Reactivate monitoring after {num} days." , nil , nil , color2 .. player.safeList.promote[3] .. "|r" ) .. "  " .. GRM.L ( "Set Days:" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText );
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetText ( player.safeList.demote[3] );
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText:SetText ( GRM.L ( "Reactivate monitoring after {num} days." , nil , nil , color3 .. player.safeList.demote[3] .. "|r" ) .. "  " .. GRM.L ( "Set Days:" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText );

        -- Frame positions and sizing
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:SetHeight ( baseHeight );
    end

    GRM_UI.MacroIgnoreCheckBoxesFrame_OnUpdate = function( self , elapsed )
        self.Timer = self.Timer + elapsed;
        if self.Timer >= 1 then
            local player = GRM.GetPlayer ( GRM_G.currentName );
            -- Kick
            if GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:IsVisible() and player.safeList.kick[4] > 0 then
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:SetText ( GRM.L ( "Time Left: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. GRM.Time.GetTimePassedInZone ( nil , player.safeList.kick[4] - time() , true ) .. "|r" ) );
            end

            -- Promote
            if GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:IsVisible() and player.safeList.promote[4] > 0 then
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:SetText ( GRM.L ( "Time Left: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. GRM.Time.GetTimePassedInZone ( nil , player.safeList.promote[4] - time() , true ) .. "|r" ) );
            end


            -- Demote
            if GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:IsVisible() and player.safeList.demote[4] > 0 then
                GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:SetText ( GRM.L ( "Time Left: {custom1}" , nil , nil , nil , "|CFFFFFFFF" .. GRM.Time.GetTimePassedInZone ( nil , player.safeList.demote[4] - time() , true ) .. "|r" ) );
            end

            if ( time() >= player.safeList.kick[4] ) or  ( time() >= player.safeList.kick[4] ) or  ( time() >= player.safeList.kick[4] ) then
                GRM.ValidateIgnoreExpireDates ( player );
            end

            self.Timer = 0;
        end
    end

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        elseif key == "ESCAPE" then
            self:Hide();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:SetScript ( "OnUpdate" , GRM_UI.MacroIgnoreCheckBoxesFrame_OnUpdate );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:SetScript ( "OnHide" , function() GRM.VerifySafeList();GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.currentName = ""; end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:SetSize ( 400 , 235 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover , "BOTTOMLEFT" , 0 , 2 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.modifier = 32;
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.Timer = 1;
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_MacroToolIgnoreListSettingsFrameCloseButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "TOPRIGHT" , 2 , 2 );
    if not isManualUpdate then
        GRM_UI.SetCloseButtonTooltip ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_MacroToolIgnoreListSettingsFrameCloseButton );
    end
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText:SetPoint ( "Top" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "TOP" , 0 , -12 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 16 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText:SetText ( GRM.L ( "Macro Rule Ignore Lists" ) );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetPoint ( "Top" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText , "BOTTOM" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetText ( GRM.L ( "Select categories you wish the player to be ignored" ) );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetTextColor ( 1 , 1 , 1 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetWordWrap ( true );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetSpacing ( 1 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetJustifyH ( "CENTER" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_ListFilterHeadingText2:SetWidth ( 372 );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame , "TOPLEFT" , 12 , -43 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox , "RIGHT" , 1 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText:SetText ( GRM.L ( "Kick Rules" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText2:SetPoint ( "RIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox , "RIGHT" , 253 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText2:SetJustifyH ( "RIGHT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBoxText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox:SetScript ( "OnClick" , function ( self , button )
        if button == "LeftButton" then

            local player = GRM.GetPlayer ( GRM_G.currentName );
            if self:GetChecked() then
                player.safeList.kick[1] = true;
            else
                player.safeList.kick[1] = false;
            end

            GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
            GRM.RefreshAllMacroToolFrames();
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                GRM.TriggerIgnoredQueuedWindowRefresh();
            end
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameKickCheckBox , "BOTTOMRIGHT" , -10 , -1 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton , "RIGHT" , 1 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText , "BOTTOMLEFT" , 0 , -7 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:SetTextColor ( 0.90 , 0.80 , 0.50 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText , "BOTTOMLEFT" , 0 , -6 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:SetTextColor ( 0.90 , 0.80 , 0.50 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:SetScript ( "OnClick", function( self )
        local player = GRM.GetPlayer ( GRM_G.currentName );
        if self:GetChecked() then
            if not player.safeList.kick[2] then
                player.safeList.kick[2] = true;

                if player.safeList.kick[3] > 0 then
                    player.safeList.kick[4] = time() + ( player.safeList.kick[3] * 86400 );
                end
            end
        else
            if player.safeList.kick[2] then
                player.safeList.kick[2] = false;
                GRM.RestoreTooltip();
            end
        end
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:SetScript ( "OnEnter" , function( self )

        local player = GRM.GetPlayer ( GRM_G.currentName );

        if player.safeList.kick[2] and player.safeList.kick[4] > 0 then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "WARNING! Unchecking this setting will reset the timer upon re-enabling." ) );
            GameTooltip:Show();
        end
    end);
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireButtonText , "RIGHT" , 8 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetSize ( 33 , 29 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetMaxLetters ( 3 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetNumeric ( true );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:EnableMouse ( true );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox.value = 0;
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetAutoFocus( false );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetFontObject ( "GameFontWhiteTiny" );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetScript ( "OnEscapePressed" , function( self )
        self:SetText ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox.value );
        self:ClearFocus();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetScript ( "OnEnterPressed" , function( self )
        local numDays = tonumber ( self:GetText() );
        if numDays > 0 and numDays < 1000 then
            local player = GRM.GetPlayer ( GRM_G.currentName );

            player.safeList.kick[3] = numDays;
            player.safeList.kick[4] = time() + ( numDays * 86400 );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox.value = numDays;
        else
            GRM.Report ( GRM.L ( "Please choose a day between {num} and {custom1}" , nil , nil , 1 , 999 ) );
        end
        self:ClearFocus();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox:SetScript ( "OnEditFocusLost" , function( self )
        self:HighlightText ( 0 , 0 );
        self:SetText ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListKickTimeExpireEditBox.value );
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox , "RIGHT" , 1 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText:SetText ( GRM.L ( "Promote Rules" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText2:SetPoint ( "RIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox , "RIGHT" , 253 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText2:SetJustifyH ( "RIGHT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBoxText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox:SetScript ( "OnClick" , function ( self , button )
        if button == "LeftButton" then

            local player = GRM.GetPlayer ( GRM_G.currentName );

            if self:GetChecked() then
                player.safeList.promote[1] = true;
            else
                player.safeList.promote[1] = false;
            end

            GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
            GRM.RefreshAllMacroToolFrames();
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                GRM.TriggerIgnoredQueuedWindowRefresh();
            end
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFramePromoteCheckBox , "BOTTOMRIGHT" , -10 , -1 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton , "RIGHT" , 1 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText , "BOTTOMLEFT" , 0 , -7 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:SetTextColor ( 0.90 , 0.80 , 0.50 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText , "BOTTOMLEFT" , 0 , -6 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:SetTextColor ( 0.90 , 0.80 , 0.50 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:SetScript ( "OnClick", function( self )
        local player = GRM.GetPlayer ( GRM_G.currentName );
        if self:GetChecked() then
            if not player.safeList.promote[2] then
                player.safeList.promote[2] = true;

                if player.safeList.promote[3] > 0 then
                    player.safeList.promote[4] = time() + ( player.safeList.promote[3] * 86400 );
                end
            end
        else
            if player.safeList.promote[2] then
                player.safeList.promote[2] = false;
                GRM.RestoreTooltip();
            end
        end
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:SetScript ( "OnEnter" , function( self )
        local player = GRM.GetPlayer ( GRM_G.currentName );
        if player.safeList.promote[2] and player.safeList.promote[4] > 0 then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "WARNING! Unchecking this setting will reset the timer upon re-enabling." ) );
            GameTooltip:Show();
        end
    end);
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireButtonText , "RIGHT" , 8 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetSize ( 33 , 29 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetMaxLetters ( 3 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetNumeric ( true );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:EnableMouse ( true );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox.value = 0;
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetAutoFocus( false );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetFontObject ( "GameFontWhiteTiny" );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetScript ( "OnEscapePressed" , function( self )
        self:SetText ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox.value );
        self:ClearFocus();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetScript ( "OnEnterPressed" , function( self )
        local numDays = tonumber ( self:GetText() );
        if numDays > 0 and numDays < 1000 then
            local player = GRM.GetPlayer ( GRM_G.currentName );
            player.safeList.promote[3] = numDays;
            player.safeList.promote[4] = time() + ( numDays * 86400 );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox.value = numDays;
        else
            GRM.Report ( GRM.L ( "Please choose a day between {num} and {custom1}" , nil , nil , 1 , 999 ) );
        end
        self:ClearFocus();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetScript ( "OnEditFocusLost" , function( self )
        self:HighlightText ( 0 , 0 );
        self:SetText ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListPromoteTimeExpireEditBox.value );
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox , "RIGHT" , 1 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText:SetText ( GRM.L ( "Demote Rules" ) );
    GRM.NormalizeHitRects ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText2:SetPoint ( "RIGHT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox , "RIGHT" , 253 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText2:SetJustifyH ( "RIGHT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBoxText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox:SetScript ( "OnClick" , function ( self , button )
        if button == "LeftButton" then
            local player = GRM.GetPlayer ( GRM_G.currentName );
            if self:GetChecked() then
                player.safeList.demote[1] = true;
            else
                player.safeList.demote[1] = false;
            end

            GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
            GRM.RefreshAllMacroToolFrames();
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                GRM.TriggerIgnoredQueuedWindowRefresh();
            end
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListFrameDemoteCheckBox , "BOTTOMRIGHT" , -10 , -1 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton , "RIGHT" , 1 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText , "BOTTOMLEFT" , 0 , -7 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:SetTextColor ( 0.90 , 0.80 , 0.50 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText , "BOTTOMLEFT" , 0 , -6 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:SetTextColor ( 0.90 , 0.80 , 0.50 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:SetScript ( "OnClick", function( self )
        local player = GRM.GetPlayer ( GRM_G.currentName );
        if self:GetChecked() then
            if not player.safeList.demote[2] then
                player.safeList.demote[2] = true;

                if player.safeList.demote[3] > 0 then
                    player.safeList.demote[4] = time() + ( player.safeList.demote[3] * 86400 );
                end
            end
        else
            if player.safeList.demote[2] then
                player.safeList.demote[2] = false;
                GRM.RestoreTooltip();
            end
        end
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:SetScript ( "OnEnter" , function( self )

        local player = GRM.GetPlayer ( GRM_G.currentName );
        if player.safeList.demote[2] and player.safeList.demote[4] > 0 then
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "WARNING! Unchecking this setting will reset the timer upon re-enabling." ) );
            GameTooltip:Show();
        end
    end);
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireButtonText , "RIGHT" , 8 , 0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetSize ( 33 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetMaxLetters ( 3 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetNumeric ( true );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:EnableMouse ( true );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox.value = 0;
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetAutoFocus( false );
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetFontObject ( "GameFontWhiteTiny" );

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetScript ( "OnEscapePressed" , function( self )
        self:SetText ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox.value );
        self:ClearFocus();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetScript ( "OnEnterPressed" , function( self )
        local numDays = tonumber ( self:GetText() );
        if numDays > 0 and numDays < 1000 then
            local player = GRM.GetPlayer ( GRM_G.currentName );
            player.safeList.demote[3] = numDays;
            player.safeList.demote[4] = time() + ( numDays * 86400 );
            GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox.value = numDays;
        else
            GRM.Report ( GRM.L ( "Please choose a day between {num} and {custom1}" , nil , nil , 1 , 999 ) );
        end
        self:ClearFocus();
    end);

    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetScript ( "OnEditFocusLost" , function( self )
        self:HighlightText ( 0 , 0 );
        self:SetText ( GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame.GRM_IgnoreListDemoteTimeExpireEditBox.value );
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
    end);

    -- Checkbox
    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:SetSize ( 93 , 26 );
    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton.GRM_SafeFromRulesButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton );
    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton.GRM_SafeFromRulesButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton.GRM_SafeFromRulesButtonText:SetText ( GRM.L ( "Macro Rules" ) );
    GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:GetWidth() , GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton.GRM_SafeFromRulesButtonText , 2 );
    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:SetScript ( "OnClick", function ( _ , button )
        if button == "LeftButton" then
            local player = GRM.GetPlayer ( GRM_G.currentName );

            if IsControlKeyDown() then
                -- Set All settings to Enable

                if IsShiftKeyDown() then
                    GRM_UI.SyncAltsToSameIgnoreFilters ( player );
                    GRM.Report ( GRM.L ( "{name}'s alts now share the same macro rule ignore settings." , GRM.GetClassifiedName ( player.name , true ) ) );
                    GRM.RefreshAllMacroToolFrames();
                else
                    GRM_UI.SetAllMacroIgnoreFilters ( player , true );
                    GRM_UI.SetIgnoreCheckButtonTooltip();
                    GRM.RefreshAllMacroToolFrames();
                end

            elseif IsAltKeyDown() then
                -- Disable player from all macro lists
                GRM_UI.SetAllMacroIgnoreFilters ( player , false );
                GRM_UI.SetIgnoreCheckButtonTooltip();
                GRM.RefreshAllMacroToolFrames();
            else
                if not GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:Show();
                    GRM_G.pause = true;
                else
                    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:Hide();
                end
                -- Let's hide the tooltip in this instance. The others I'll keep up.
                GRM.RestoreTooltip();
            end

            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                GRM.TriggerIgnoredQueuedWindowRefresh();
            end

            if GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:IsVisible() then
                GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow();
            end
        end
    end);

    GRM_UI.SetIgnoreCheckButtonTooltip = function()
        local player = GRM.GetPlayer ( GRM_G.currentName );
        if player and player.altGroup ~= nil then

            local safeList = player.safeList or GRM.GenerateSafeListForPlayer();

            local ruleEnum = { [false] = "|CFF00CCFF" .. GRM.L ( "Monitoring" ) .. "|r" , [true] = "|CFFFF0000" .. GRM.L ( "Ignoring" ) .. "|r" }
            local numSafeLists = GRM.HowManySafeListsIsPlayerOn ( player );
            local disabled = "|CFFFF0000" .. GRM.L ( "Disabled at Current Rank" ) .. "|r";
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton , "ANCHOR_CURSOR" );

            -- Set Permissions.

            local kickMsg , promoteMsg, demoteMsg = "" , "" , "";

            if CanGuildRemove() then
                kickMsg = ruleEnum [safeList.kick[1]];
            else
                kickMsg = disabled;
            end

            if CanGuildPromote() then
                promoteMsg = ruleEnum [safeList.promote[1]];
            else
                promoteMsg = disabled;
            end

            if CanGuildDemote() then
                demoteMsg = ruleEnum [safeList.demote[1]];
            else
                demoteMsg = disabled;
            end

            GameTooltip:AddLine ( GRM.L ( "Macro Tool:" ) );
            GameTooltip:AddDoubleLine ( GRM.L ( "Kick Rules" ) , kickMsg );
            GameTooltip:AddDoubleLine ( GRM.L ( "Promote Rules" ) , promoteMsg );
            GameTooltip:AddDoubleLine ( GRM.L ( "Demote Rules" ) , demoteMsg );
            GameTooltip:AddLine ( " " );

            if numSafeLists < 3 then
                GameTooltip:AddLine ( GRM.L ( "{custom1} to add player to all 3 macro tool ignore lists" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Click" ) .. "|r" ) );
            end
            if numSafeLists > 0 then
                GameTooltip:AddLine ( GRM.L ( "{custom1} to remove player from all 3 macro tool ignore lists" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Alt-Click" ) .. "|r" ) );
            end

            if GRM.PlayerHasAlts ( player ) then
                GameTooltip:AddLine ( GRM.L ( "{custom1} to push ignore list settings to {name}'s alts" , GRM.GetClassifiedName ( GRM_G.currentName , true ) , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Shift-Click" ) .. "|r" ) );
            end

            local macroText = "";
            if GRM_L["/XXXX"] ~= true then
                macroText = GRM_L["/XXXX"];
            else
                macroText = "/grm";
            end

            GameTooltip:AddLine ( " " );
            GameTooltip:AddLine( GRM.L ( "Type \"{name} {name2}\" to Bring Up Macro Tool. {custom1} also work." , macroText , string.lower ( GRM.L ( "Macro" ) ) , nil , "\n" .. string.lower ( GRM.L ( "Tool" ) ) .. ", " .. string.lower ( GRM.L ( "Kick" ) ) .. ", " .. string.lower ( GRM.L ( "Promote" ) ) .. ", " .. string.lower ( GRM.L ( "Demote" ) ) ) );
            GameTooltip:Show();
        end
    end

    -- For use in the mosueover button above for auto-setting values
    GRM_UI.SetAllMacroIgnoreFilters = function ( player , isEnabled )

        player.safeList = player.safeList or GRM.GenerateSafeListForPlayer();
        for list in pairs ( player.safeList ) do
            player.safeList[list][1] = isEnabled;
        end
    end

    -- To enable or disable the ignore list for all alts...
    GRM_UI.SyncAltsToSameIgnoreFilters = function( player )

        if GRM.PlayerHasAlts ( player ) then                     -- Number of alts, if > 0 then do something.
            local alt;
            local group = GRM.GetGuildAlts()[player.altGroup];

            player.safeList =  player.safeList  or GRM.GenerateSafeListForPlayer();
            if group then
                for i = 1 , #group do              -- Loop through all alts
                    alt = GRM.GetPlayer ( group[i].name );
                    if alt ~= nil then
                        -- No point in adding yourself.
                        local safeList = GRM.Util.DeepCopyArray ( player.safeList );
                        alt.safeList = safeList;
                        GRM.VerifySafeList(alt);
                    end
                end
            end
            GRM.VerifySafeList(player);
        end
    end

    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:SetScript ( "OnEnter" , function()
        GRM_UI.SetIgnoreCheckButtonTooltip();
    end);

    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip();
    end);

    -- CUSTOM NOTE WINDOW DETAILS
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText , "RIGHT" , 5 , 0 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:Hide();
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "TOPLEFT" , 5 , 0 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText:SetText ( GRM.L ( "Custom Public Notes:" ) );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText:SetWordWrap ( false );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "TOPLEFT" , 2 , -1.5 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetSize ( 159 , 106 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetTextInsets( 7 , -10 , 10 , 6 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetMaxLetters ( GRM_G.MaxCustomNoteSize );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:EnableMouse( true );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetMultiLine( true );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetSpacing ( 1 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteMetaCheckBoxText , "RIGHT" , 0 , -1.5 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetHitRectInsets ( 0 , 0 , 0 , 0 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetSize ( 26 , 26 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteMetaCheckBoxText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "BOTTOMLEFT" , 2 , -2 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteMetaCheckBoxText:SetText ( "Sync:" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteMetaCheckBoxText:SetWordWrap ( false );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteMetaCheckBoxText:SetJustifyH ( "LEFT" );

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteMetaCheckBoxText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetScript ( "OnClick", function( self , button )
        if button == "LeftButton" then
            local player = GRM.GetPlayer ( GRM_G.currentName );
            if player then
                if self:GetChecked() then
                    player.customNote[1] = true;
                    GRM_UI.ResetCustomNoteSyncTooltip();
                else
                    player.customNote[1] = false;
                    GRM_UI.ResetCustomNoteSyncTooltip();
                end
            end
        end
    end);

    GRM_UI.ResetCustomNoteSyncTooltip = function()
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox , "ANCHOR_CURSOR" );
        local script = "";
        if GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:GetChecked() then
            script = GRM.L ( "Click to Disable Sync of Custom Note" );
        else
            script = GRM.L ( "Click to Enable Sync of Custom Note" );
        end
        GameTooltip:AddLine( script );
        GameTooltip:Show();
    end

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetScript ( "OnEnter" , GRM_UI.ResetCustomNoteSyncTooltip );

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript ( "OnEditFocusGained" , function ( self )
        GRM_G.OriginalEditBoxValue = self:GetText();
        GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
        GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:Hide();
        GRM.RestoreTooltip()
        GRM_G.pause = true;
        if self:GetText() == GRM.L ( "Click here to set Custom Notes" ) then
            self:SetText( "" );
        end
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:SetText ( self:GetNumLetters() .. "/150" );
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:Show();

        -- Group Invite button may need to temporarily be turned off.
        GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:Hide();
        GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:Show();
        GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton:Show();
        GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:Hide();
    end);


    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript ( "OnEditFocusLost" , function ()
        GRM_UI.CustomNoteEditBoxOnFocusLost();
    end);

    local MaxValue = 0;
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript ( "OnTextChanged" , function( self )
        if self:HasFocus() then
            local numLetters = self:GetNumLetters();
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:SetText ( numLetters .. "/150" );

            GRM.BuildCustomNoteScrollFrame( self:GetText() );
            local max = select ( 2 , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:GetMinMaxValues() );
            if max > 0 and numLetters > 0 then
                local cursorPosition = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetCursorPosition();
                if cursorPosition == numLetters then
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue ( max );
                else
                    if max - MaxValue > 15 then
                        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue (  math.floor ( ( cursorPosition / GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetMaxLetters() ) * max ) );
                    end
                end
            end
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript ( "OnEscapePressed" , function()
        GRM_UI.CustomNoteEditBoxOnFocusLost();
    end)

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript ( "OnEnterPressed" , function()
        -- Store the update.
        local newString = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetText();
        local cursorPosition = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetCursorPosition();
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText ( string.sub ( newString , 1 , cursorPosition ) .. "\n" .. string.sub ( newString , cursorPosition + 1 ) );
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetCursorPosition ( cursorPosition + 1 );
    end)

    -- EditBox tooltip
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript ( "OnEnter" , function( self )
        if not self:HasFocus() then
            local player = GRM.GetPlayer ( GRM_G.currentName );

            if player then
                -- No need to bother with tooltip if there is no editor.
                if player.customNote[3] ~= "" then
                    local isFound = false;
                    -- Need to check if the person who edited is still in the guild
                    if GRM.GetPlayer ( player.customNote[3] ) then
                        isFound = true;
                    end
                    GRM_UI.SetTooltipScale();
                    GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                    -- if still in the guild
                    local noteDisplay = "";
                    if isFound then
                        if player.customNote[4] == "" then
                            noteDisplay = GRM.L ( "Note Removed by {name}" , GRM.GetClassifiedName ( player.customNote[3] , false ) );
                        else
                            noteDisplay = GRM.L ( "Edited by {name}" , GRM.GetClassifiedName ( player.customNote[3] , false ) );
                        end
                        GameTooltip:AddLine( noteDisplay );
                    else
                        GameTooltip:AddLine( GRM.L ( "Edited by {name}" , player.customNote[3] .. " (" .. GRM.L( "|CFFFF0000Player No Longer in Guild" ) .. ")"  ) );
                    end
                    GameTooltip:AddLine ( GRM.Time.EpochToDateFormat ( player.customNote[2] ) );
                    GameTooltip:Show();
                end
            end
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);

    -- SCROLL FRAME
    if GRM.S().showBorders then
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:SetBackdrop ( GRM_UI.noteBackdrop );
    else
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:SetBackdrop ( GRM_UI.framelessBackdrop );
    end
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_PlayerNoteWindow , "BOTTOMLEFT" , 0 , -10 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:SetSize ( 166 , 113 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:EnableMouse ( true );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame:SetScript ( "OnMouseDown" , function ( _ , button )
        if button == "LeftButton" then
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:Show();
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetFocus();
        end
    end);
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetScrollChild ( GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetSize ( 163 , 98 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetPoint (  "Bottom" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "BOTTOM" , 1 , 5 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:EnableMouseWheel( true );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetOrientation ( "VERTICAL" );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetSize ( 16 , 78 )
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "RIGHT" , 2 , 0 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue ( 0 );
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetScript ( "OnValueChanged" , function ( self )
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetVerticalScroll ( self:GetValue() );
    end);

    GRM_UI_Util.BuildSliderTextures ( GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider );

    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetScript ( "OnShow" , function( self )
        local tempVal = self:GetValue();
        if tempVal == 0 then
            self:SetValue( 20 );
            self:SetValue ( tempVal );
        else
            self:SetValue( 0 );
            self:SetValue ( tempVal );
        end
    end);

    -- Confirm notes
    GRM_UI.ReconfigureNoteFonts();

    -- Confirm Custom Note
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton );
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButtonText:SetText ( GRM.L ( "Confirm" ) );
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "BOTTOM" , -2.5 , -17 );
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:SetSize ( 80 , 22 );
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:SetFrameStrata ( "TOOLTIP" );
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            -- Store the update.
            GRM.SetCustomNote();

            if GRM_UI.GRM_AuditJDTool:IsVisible() then
                GRM.AuditRefresh( true );
            end

            GRM_UI.RefreshSelectFrames ( false , false , false , false , true , false , true );
        end
    end)

    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:SetScript ( "OnEnter" , function ( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        GameTooltip:AddLine( GRM.L ( "Confirm Custom Note" ) );
        GameTooltip:Show();
    end);
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end);
    -- Cancel Custom Note
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton );
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 )
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButtonText:SetText ( GRM.L ( "Cancel" ) );
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame , "BOTTOM" , 2.5 , -17 );
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton:SetSize ( 80 , 22 );

    -- LOGIC HANDLING ON MODIFYING THE CUSTOM NOTE!!!!!!
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton:SetScript ( "Onclick" , function ( _ , button )
        if button == "LeftButton" then
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
        end
    end);

    -- Method:          GRM_UI.CustomNoteEditBoxOnFocusLost( bool )
    -- What it Does:    It resets to original value stored when player gained editbox focus
    -- Purpose:         Reusuable tool for many locations... avoid code bloat.
    GRM_UI.CustomNoteEditBoxOnFocusLost = function( isForced )
        -- Check if group invite button is necessary to come back.
        local player = GRM.GetPlayer ( GRM_G.currentName );
        if isForced or ( not ( GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:IsVisible() and GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:IsMouseOver() and IsMouseButtonDown ( 1 ) ) or ( GRM.Util.Trim ( GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetText() ) == player.customNote[4] ) ) then

            GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:Hide();
            GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton:Hide();
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText ( GRM_G.OriginalEditBoxValue );
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:Hide();

            if GRM_G.currentName ~= GRM_G.addonUser then
                GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:Show();

                if player.isOnline then
                    GRM.SetGroupInviteButton ( GRM_G.currentName );
                    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:Show();
                end
        end
            GRM.BuildCustomNoteScrollFrame ( GRM_G.OriginalEditBoxValue );
            if GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:IsVisible() ~= true then            -- Does not unpause if the date still needs to be selected or canceled.
                GRM_UI.Unpause();
            end
        end
    end

    -- Heads-up text if player was previously banned
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton , "TOPLEFT" , 0 , 2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:SetWordWrap ( true );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:SetTextColor ( 1.0 , 0.0 , 0.0 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:SetWidth ( 400 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:SetText ( GRM.L ( "WARNING!" ) .. "\n" .. GRM.L ( "Player Was Previously Banned!" ) );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover , "TOPLEFT" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton:SetWidth ( 113 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton:SetHeight ( 22 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton.GRM_MemberDetailBannedIgnoreButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton.GRM_MemberDetailBannedIgnoreButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton.GRM_MemberDetailBannedIgnoreButtonText:SetText ( GRM.L ( "Ignore Ban" ) );

    -- ALT FRAME DETAILS!!!
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteWindow , "BOTTOM" , 0 , -10 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame:SetSize ( 170 , 150 );
       -- ALT FRAME SCROLL OPTIONS
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:SetSize ( 170 , 140 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame , "TOP" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:SetScrollChild ( GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame );
    -- Slider Parameters
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetOrientation( "VERTICAL" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetSize( 16 , 109 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetPoint( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame , "TOPRIGHT" , 10 , -13 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetValue( 0 );

    GRM_UI_Util.BuildSliderTextures ( GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider );

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:SetScript( "OnValueChanged" , function(self)
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame:SetVerticalScroll( self:GetValue() )
    end);

    GRM_UI.GRM_Mouseover.GRM_altFrameTitleText:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame , "TOP" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_altFrameTitleText:SetText ( GRM.L ( "Player Alts" ) );
    GRM_UI.GRM_Mouseover.GRM_altFrameTitleText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 , "THICKOUTLINE" );

    GRM_UI.GRM_AddAltButton2:SetSize ( 86 , 20 );
    GRM_UI.GRM_AddAltButton2Text:SetPoint ( "CENTER" , GRM_UI.GRM_AddAltButton2 );
    GRM_UI.GRM_AddAltButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_AddAltButton2Text:SetText( GRM.L ( "Add Alt" ) ) ;
    GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_AddAltButton2:GetWidth() , GRM_UI.GRM_AddAltButton2Text   , 2 );

    -- ALT DROPDOWN OPTIONS
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:SetFrameStrata ( "FULLSCREEN_DIALOG" );

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions , 7 , -13 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsText:SetText ( GRM.L ( "Options" ) );

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton:SetPoint ("TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions , 7 , -22 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton , "BOTTOMLEFT" , 0 , 4 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:SetText( GRM.L ( "Remove" ) );

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsDividerText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton , "TOPLEFT" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsDividerText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altOptionsDividerText:SetText ("__");
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions , "BOTTOMLEFT" , 7 , 4 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButtonText:SetText ( GRM.L ( "Cancel" ) );

    -- Status Right Click Menu
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:SetFrameStrata ( "FULLSCREEN_DIALOG" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus , "BOTTOM" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameTopText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame , 7 , -13 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameTopText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameTopText:SetText ( GRM.L ( "Options" ) );

    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1:SetPoint ("TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame , 7 , -22 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1:SetSize ( 151 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1 , "BOTTOMLEFT" , 0 , 4 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:SetSize ( 151 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameDividerText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton , "TOPLEFT" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameDividerText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameDividerText:SetText ("__");
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame , "BOTTOMLEFT" , 7 , 4 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton:SetSize ( 151 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButtonText:SetText ( GRM.L ( "Cancel" ) );

    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        elseif key == "ESCAPE" then
            self:Hide();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameCancelButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
            GRM_UI.Unpause();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1:SetScript ( "OnClick" , function ( _ , button )

        if button == "LeftButton" then
            local statusText = GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton1Text:GetText();

            if statusText == GRM.L ( "Notify When Player is Active" ) then
                GRM.AddPlayerStatusCheck ( GRM_G.selectedName[1] , 1 );
                GRM_UI.Unpause();
            elseif statusText == GRM.L ( "Notify When Player Comes Online" ) then
                GRM.AddPlayerStatusCheck ( GRM_G.selectedName[1] , 2 );
                GRM_UI.Unpause();
            elseif statusText == GRM.L ( "Notify When Player Goes Offline" ) then
                GRM.AddPlayerStatusCheck ( GRM_G.selectedName[1] , 3 );
                GRM_UI.Unpause();
            end
            GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then

            if GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame.GRM_MouseOverStatusFrameButton2Text:GetText() == GRM.L ( "Notify When Player Goes Offline" ) then
                GRM.AddPlayerStatusCheck ( GRM_G.selectedName[1] , 3 );
            end
            GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
        end
    end);


    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:SetFrameStrata ( "FULLSCREEN_DIALOG" );

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameTopText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame , 7 , -13 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameTopText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameTopText:SetText ( GRM.L ( "Options" ) );

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:SetPoint ("TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame , 7 , -22 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton1 , "BOTTOMLEFT" , 0 , 4 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton2 , "BOTTOMLEFT" , 0 , 4 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton , "TOPLEFT" , 0 , 4 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton4Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameDividerText:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton , "TOPLEFT" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameDividerText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameDividerText:SetText ("__");
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame , "BOTTOMLEFT" , 7 , 4 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton:SetSize ( 90 , 26 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButtonText:SetText ( GRM.L ( "Cancel" ) );

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        elseif key == "ESCAPE" then
            self:Hide();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameCancelButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
            GRM_UI.Unpause();
        end
    end);


    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame.GRM_MouseOverDateStatusFrameButton3:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
        end
    end);


end

-- Method:                  GR_MetaDataInitializeUIThird( boolean )
-- What it Does:            Initializes "More of the frames values/scripts"
-- Purpose:                 Can only have 60 "up-values" in one function. This splits it up.
GRM_UI.GR_MetaDataInitializeUIThird = function( isManualUpdate )

    --ADD ALT FRAME
    -- if not isManualUpdate then
    --     -- To be used in the future
    -- end

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover , "BOTTOMRIGHT" ,  -7 , 0 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:SetSize ( 173 + ( #GRM_G.realmName * 3.5 ) , 226 );                -- Slightly wider for larger guild names.
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:SetToplevel ( true );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBoxCloseButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame , "TOPRIGHT" , -4 , -5 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBoxCloseButton:SetSize ( 26 , 26 );

    -- Scroll Frame Details
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame:SetSize ( GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:GetWidth() - 10 , 111.75 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox , "BOTTOM" , 2 , 0 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame:SetScrollChild ( GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame );
    -- Slider Parameters
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetOrientation( "VERTICAL" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetSize ( 18 , 95 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame , "RIGHT" , -2.5 , 0 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue( 0 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetScript( "OnValueChanged" , function ( self )
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame:SetVerticalScroll( self:GetValue() )
    end);

    GRM_UI_Util.BuildSliderTextures ( GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider );

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltTitleText:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame , 0 , - 15 );
    if not isManualUpdate then
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltTitleText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14.5 , "THICKOUTLINE" );
    end
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltTitleText:SetText ( GRM.L ( "Choose Alt" ) );

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame , "BOTTOMLEFT" , 15 , 13 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:SetTextColor ( 0.5 , 0.5 , 0.5 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:SetText ( GRM.L ( "(Press Enter to Select)" ) .. "\n" .. GRM.L ( "(Press Tab to Cycle)" ) );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:SetJustifyH ( "LEFT" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameTextBottom:SetSpacing ( 1 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetWidth ( 146 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetWordWrap ( true );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:SetSpacing ( 1 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:SetPoint ( "BOTTOM" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame , 0 , 30 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:SetText ( GRM.L ( "Shift-Click Name On Roster Also Works" ) );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:SetWidth ( 146 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:SetWordWrap ( true );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText2:SetSpacing ( 1 );

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetPoint( "TOP" , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltTitleText , "BOTTOM" , 0 , -2 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetSize ( 126 + ( #GRM_G.realmName * 3.5 ) , 25 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetTextInsets( 2 , 3 , 3 , 2 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetMaxLetters ( 40 );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetFontObject ( "GameFontWhite" );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:EnableMouse( true );
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetAutoFocus( false );

    GRM_UI.AddAltButtonControls = function ( _ , button )
        if button == "LeftButton" then
            -- Let's see if player is at hard cap first!
            local player = GRM.GetPlayer ( GRM_G.currentName );
            if player then
                if GRM.GetNumAlts ( player.altGroup ) >= 75 then
                    GRM.Report ( GRM.L ( "Addon does not currently support more than 75 alts!" ) );
                else
                    GRM_G.pause = true;
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetAutoFocus( true );
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetText( "" );
                    GRM.AddAltAutoComplete();
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:Show();
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetAutoFocus( false );
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetFocus();
                end
            end
        end
    end

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:SetScript ( "OnHide" , function()
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( 0 );
        GRM_G.currentHighlightIndex = 0;
    end);

    -- ALT EDIT BOX LOGIC
    GRM_UI.GRM_AddAltButton2:SetScript ( "OnClick" , GRM_UI.AddAltButtonControls );

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetScript ( "OnEscapePressed" , function( self )
        self:ClearFocus();
    end);

    -- Updating with each character typed
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetScript ( "OnChar" , function ()
        GRM.AddAltAutoComplete();
    end);

    -- When pressing backspace.
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetScript ( "OnKeyDown" , function ( self , key)
        if key == "BACKSPACE" then
            local text = self:GetText();
            if text ~= nil and #text > 0 then
                self:SetText ( string.sub ( text , 0 , #text - 1 ) ); -- Bring it down by 1 for function, then return to normal.
            end
            GRM.AddAltAutoComplete();
            self:SetText( text ); -- set back to normal for normal Backspace upkey function... if I do not do this, it will delete 2 characters.
        elseif key == "DOWN" or key == "UP" or key == "TAB" then
            GRM_UI.AddAltSelectionControls ( self , key );
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        elseif key == "ESCAPE" then
            self:Hide();
        end
    end);

    GRM_UI.AddAltSelectionControls = function( _ , key )
        local notSet = true;
        local buttons = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons;
        local i = GRM_G.currentHighlightIndex;

        if key == "DOWN" or ( key ~= "UP" and not IsShiftKeyDown() ) then
            if i == 1 and notSet then
                if ( i + 1 ) <= #buttons and buttons[i + 1][1]:IsVisible() then
                    GRM_G.currentHighlightIndex = 2;
                    buttons[i][1]:UnlockHighlight();
                    buttons[i + 1][1]:LockHighlight();
                    notSet = false;
                end
            else
                if ( i + 1 ) <= #buttons and buttons[i + 1][1]:IsVisible() then
                    GRM_G.currentHighlightIndex = i + 1;
                    buttons[i][1]:UnlockHighlight();
                    buttons[i + 1][1]:LockHighlight();
                    notSet = false;
                    GRM_UI.SetAddAltSliderValue();
                else
                    GRM_G.currentHighlightIndex = 1;
                    buttons[i][1]:UnlockHighlight();
                    buttons[1][1]:LockHighlight();          -- Set it back to the first one...
                    notSet = false;
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( 0 );
                end
            end

        elseif key == "UP" or ( key ~= "DOWN" and IsShiftKeyDown() ) then
            -- -- if at position 1... shift-tab goes back to any position.
            if i == 1 and notSet then
                if buttons[GRM_G.NumberAltInSelection][1]:IsVisible() then
                    GRM_G.currentHighlightIndex = GRM_G.NumberAltInSelection;
                    buttons[i][1]:UnlockHighlight();
                    buttons[GRM_G.NumberAltInSelection][1]:LockHighlight();
                    notSet = false;
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( select ( 2 , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:GetMinMaxValues() ) );
                end
            else
                GRM_G.currentHighlightIndex = i - 1;
                buttons[i][1]:UnlockHighlight();
                buttons[i - 1][1]:LockHighlight();          -- Set it back to the first one...
                notSet = false;
                GRM_UI.SetAddAltSliderValue();
            end
        end
    end

    -- Method:          GRM_UI.SetAddAltSliderValue()
    -- What it Does:    Controls the points at which the slider is stationed when tab OR shift-tabbing
    -- Purpose:         Quality of Life controls for UI
    GRM_UI.SetAddAltSliderValue = function ()
        if GRM_G.currentHighlightIndex < 7 then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( 0 );
        elseif GRM_G.currentHighlightIndex > 6 and GRM_G.currentHighlightIndex < 13 then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( 84 );
        elseif GRM_G.currentHighlightIndex > 12 and GRM_G.currentHighlightIndex < 19 then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( 168 );
        elseif GRM_G.currentHighlightIndex > 18 and GRM_G.currentHighlightIndex < 25 then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( 252 );
        elseif GRM_G.currentHighlightIndex > 24 and GRM_G.currentHighlightIndex < 31 then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:SetValue ( select ( 2 , GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider:GetMinMaxValues() ) );
        end
    end

    GRM_UI.AddAltSideFrameLogic = function( editBox )
        local currentText = editBox:GetText();
        if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:IsVisible() and ( GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:GetText() == GRM.L ( "Player Not Found" ) or GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:GetText() == GRM.L ( "Player Cannot Add Themselves as an Alt" ) or GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrameHelpText:GetText() == GRM.L ( "Player is Already in this Alt Group" ) ) then
            if GRM.SlimName ( GRM_G.currentName ) == currentText or GRM_G.currentName == currentText then
                GRM.Report ( GRM.L ( "Player Cannot Add Themselves as an Alt" ) );
            elseif GRM_UI.GRM_Mouseover.alts[currentText] then
                GRM.Report ( GRM.L ( "Player is Already in this Alt Group" ) );
            end
            GRM.Report ( GRM.L ( "Please choose a VALID character to set as an Alt" ) );
        else
            if currentText ~= nil and currentText ~= "" then
                local addToAltsGroup = false;
                local nameToAdd = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[GRM_G.currentHighlightIndex][2]:GetText();
                nameToAdd = GRM.RemoveMainAltTags ( nameToAdd );

                if editBox:GetText() ~= nameToAdd then
                    editBox:SetText ( nameToAdd );
                else
                    local timestamp = time();
                    -- Refresh alt frames
                    -- Add the alt here, Hide the frame
                    addToAltsGroup = GRM.AddAlt ( GRM_G.currentName , nameToAdd , timestamp );
                    GRM.SyncBirthdayWithNewAlt ( GRM_G.currentName , nameToAdd , addToAltsGroup , timestamp );

                    GRM_UI.RefreshSelectFrames ( false , true , false , true , true , true , true );

                    -- Communicate the changes!
                    if GRM.S().syncEnabled then
                        GRM_UI.SendFullAltGroup ( GRM_G.currentName , nameToAdd , timestamp );
                    end

                    editBox:ClearFocus();
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:Hide();

                    if GRM_UI.GRM_LoadToolButton:IsVisible() then
                        GRM_UI.RefreshToolButtonsOnUpdate_Async( false , false );
                    end
                    GRM.Report ( GRM.L ( "{name} added to {name2}'s list of Alts." , GRM.GetClassifiedName ( nameToAdd , true ) , GRM.GetClassifiedName ( GRM_G.currentName , true ) ) );
                end
            else
                GRM.Report ( GRM.L ( "Please choose a character to set as alt." ) );
            end
        end
    end

    -- Method:          GRM_UI.SendFullAltGroup ( string , string , int , int , playerTable , altsTable )
    -- What it Does:    Sends the full player alt group
    -- Purpose:         When updating an alt group, you cannot just send only the 1 alt, as the alt groups are a whole. You send the full group
    GRM_UI.SendFullAltGroup = function( currentName , nameToAdd , timestamp , index , player , alts )
        index = index or 2;

        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
            syncRankFilter = GuildControlGetNumRanks() - 1;
        end

        local endCap = "?X"; -- END CAP
        player = player or GRM.GetPlayer ( nameToAdd );

        if player then
            alts = alts or GRM.GetAltGroup ( player.altGroup );
            local main = "";
            local msg = "";
            local tempMsg = "";

            if alts and GRM.IsPlayerInAltGroup ( player.altGroup , currentName ) then       -- Confirming the toons are now in the same alt group after adding.
                if alts.main == "" then
                    main = "#";
                else
                    main = alts.main;
                end

                for i = index , #alts do

                    if i == 2 then
                        msg = "GRM_ADDALT?" .. syncRankFilter .. "?S?" .. alts[1].name .. "?" .. main .. "?" .. timestamp .. "?" .. tostring(#alts-1) .. "?" .. nameToAdd .. "?" .. currentName;
                    elseif msg == "" then
                        msg = "GRM_ADDALT?" .. syncRankFilter .. "?##?" .. alts[1].name;
                    end

                    tempMsg = msg .. "?" .. alts[i].name;

                    if ( #tempMsg + GRMsyncGlobals.sizeModifier + #endCap ) < 255 then
                        msg = tempMsg;

                    else
                        -- Do not add the new name, just send the msg
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , msg , "GUILD" );
                        msg = "GRM_ADDALT?" .. syncRankFilter .. "?##?" .. alts[1].name .. "?" .. alts[i].name;
                    end

                    -- If at the end of the alt Group, we need to send, even if not a full string.
                    if i == #alts then
                        msg = msg .. endCap;
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , msg , "GUILD" );
                    end

                    -- Check if there needs to be a throttled delay
                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        index = i;
                        if i == #alts then
                            index = index + 1;
                        end

                        GRMsyncGlobals.SyncCount = 0;
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRM_UI.SendFullAltGroup ( currentName , nameToAdd , timestamp , index , player , ats );
                        end);
                        return;
                    end
                end
            end
        end
    end

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetScript ( "OnEnterPressed" , function( self )
        if self:HasFocus() then
            GRM_UI.AddAltSideFrameLogic ( self );
        end
    end);

    -- ALT FRAME LOGIC
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButton:SetScript ( "OnClick" , function ( _ , button )

        if button == "LeftButton" then
            local altDetails = GRM_G.selectedName;
            local buttonName = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altSetMainButtonText:GetText();

            if buttonName == GRM.L ( "Set as Main" ) then

                if GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:IsVisible() then
                    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:Hide();
                end
                GRM.SetAltAsMainDropDownMenuLogic ( GRM_G.selectedName );

            elseif buttonName == GRM.L ( "Set as Alt" ) then
                if GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:IsVisible() then
                    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:Hide();
                end
                GRM.DemoteMainToAltDropDownMenuLogic ( altDetails );

            end

            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
        end
    end);

    -- Also functions to clear history...
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            local buttonName = GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altRemoveButtonText:GetText();
            local altDetails = GRM_G.selectedName;

            if buttonName == GRM.L ( "Remove" ) then
                local timestamp = time();
                GRM.RemovePlayerFromAltGroup ( altDetails[2] , timestamp , true , true );
                -- Send comm out of the changes!

                if GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then
                    GRM.BuildAltGroupingScrollFrame( GRM_G.currentName );
                end

                if GRM_UI.GRM_LoadToolButton:IsVisible() then
                    GRM_UI.RefreshToolButtonsOnUpdate_Async( false , false );
                end

                if GRM.S().syncEnabled then
                    local syncRankFilter = GRM.S().syncRank;
                    if GRM.S().exportAllRanks then
                        syncRankFilter = GuildControlGetNumRanks() - 1;
                    end
                    GRMsync.SendMessage ( "GRM_SYNC" , "GRM_RMVALT?" .. syncRankFilter .. "?" ..altDetails[2] .. "?" .. tostring ( timestamp ) .. "?" .. altDetails[1] , "GUILD");
                end

                GRM.Report ( GRM.L ( "{name} has been removed from {name2}'s list of Alts." , GRM.GetClassifiedName ( altDetails[2] , true ) , GRM.GetClassifiedName ( GRM_G.currentName , true ) ) );

            elseif buttonName == GRM.L ( "Reset Data!" ) then
                GRM_UI.GRM_RosterConfirmFrameText:SetText( GRM.L ( "Reset All of {name}'s Data?" , GRM.GetClassifiedName ( altDetails[1] , true ) ) );
                GRM_UI.GRM_RosterConfirmYesButtonText:SetText ( GRM.L ( "Yes!" ) );
                GRM_UI.GRM_RosterConfirmYesButton:SetScript ( "OnClick" , function( _ , button )
                    if button == "LeftButton" then
                        GRM.ResetPlayerMetaData ( altDetails[1] );
                        GRM_UI.GRM_RosterConfirmFrame:Hide();
                        GRM_UI.RefreshSelectFrames ( false , true , true , true , true , true );
                    end
                end);
                GRM_UI.GRM_RosterConfirmFrame:Show();
            end
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
            GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
        end
    end);

    -- Method:          GRM_UI.ConfirmPromoDate()
    -- What it Does:    Confirms the current date and adds it.
    -- Purpose:         Easier UX for confirming dates, especially in Classic
    GRM_UI.ConfirmPromoDate = function()
        local name = GRM_G.currentName;
        local player = GRM.GetPlayer ( name );

        if player and player.rankHist[1][2] ~= 0 then
            -- For SYNC
            player.rankHist[1][6] = time();
            player.rankHist[1][7] = true;

            -- If player had it set to "unknown before"
            player.promoteDateUnknown = false;
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetText ( string.gsub ( GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:GetText() , "!!" , "" ) );

            -- Send the details out for others to pickup!
            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().syncRank;
                if GRM.S().exportAllRanks then
                    syncRankFilter = GuildControlGetNumRanks() - 1;
                end
                GRMsync.SendMessage ( "GRM_SYNC" , "GRM_PD?" .. syncRankFilter .. "?" .. name .. "?" .. tostring ( player.rankHist[1][5] ) .. "?" .. tostring( player.rankHist[1][6] ) , "GUILD" );
            end
        end

        GRM_UI.Unpause();
        -- Update Audit Frames.
        GRM_UI.RefreshSelectFrames ( false , true , false , true , true , true );
    end
    -- Method:          GRM_UI.ConfirmJoinDate()
    -- What it Does:    Confirms the current date and adds it.
    -- Purpose:         Easier UX for confirming dates, especially in Classic
    GRM_UI.ConfirmJoinDate = function()
        local name = GRM_G.currentName;
        local player = GRM.GetPlayer ( name );

        if player and player.joinDateHist[1][1] ~= 0 then
            -- For SYNC
            player.joinDateHist[1][5] = time();
            player.joinDateHist[1][6] = true;
            player.joinDateHist[1][7] = 1;

            -- If player had it set to "unknown before"
            player.joinDateUnknown = false;
            GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetText ( string.gsub ( GRM_UI.GRM_Mouseover.GRM_JoinDateText:GetText() , "!!" , "" ) );

            -- Send the details out for others to pickup!
            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().syncRank;
                if GRM.S().exportAllRanks then
                    syncRankFilter = GuildControlGetNumRanks() - 1;
                end

                GRMsync.SendMessage ( "GRM_SYNC" , "GRM_JD?" .. syncRankFilter .. "?" .. name .. "?" .. tostring ( player.joinDateHist[1][4] ) .. "?" .. tostring ( player.joinDateHist[1][5] ) , "GUILD");
            end
        end

        GRM_UI.Unpause();
        -- Update Audit Frames.
        GRM_UI.RefreshSelectFrames ( false , true , false , true , true , true );
    end

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions.GRM_altFrameCancelButton:SetScript ( "OnClick" , function ( _ , button )
        if button == "LeftButton" then
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
            GRM_UI.Unpause();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        elseif key == "ESCAPE" then
            self:Hide();
        end
    end);

    -- Need to make new checkbox option to choose to record levels or not
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected , "BOTTOM" , -26 , -3 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetWidth( 98.5 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:SetWidth( 98.5 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:SetPoint ( "LEFT" , GRM_UI.GRM_Mouseover.GRM_SetUnknownButton , "RIGHT" , 6 , 0 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButtonTxt:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButtonTxt:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10.5 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButtonTxt:SetText ( GRM.L ( "Cancel" ) );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetPoint ( "CENTER" , GRM_UI.GRM_Mouseover.GRM_DateSubmitButton );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10.5 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetText ( GRM.L ( "Set Join Date" ) );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetSpacing ( 0 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetWordWrap ( true );
    GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:GetWidth() , GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt , 2 );
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetScript ( "OnShow" , function()
        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Hide();
        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Hide();
        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Hide();
        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Hide();
        if GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
        end
        if GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
        end
    end);

    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetScript ( "OnEnter" , function( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        GameTooltip:AddLine( GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:GetText() );
        GameTooltip:Show();
    end)
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()
    end)

    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetScript ( "OnKeyDown" , function ( self , key )

        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                GRM.ClearAllFrames( false );
                GRM.PopulateMemberDetails ( GRM_G.currentName );
            end
        elseif key == "ESCAPE" then
            self:SetPropagateKeyboardInput ( false );
            GRM.ClearAllFrames( false );
            GRM.PopulateMemberDetails ( GRM_G.currentName );
        end
    end);

    -- Scroll Frame Details
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetSize ( 340 , 150 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetClampedToScreen ( true );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetFrameStrata("HIGH");
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.timer1 = 0;
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.timer2 = 0;

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrameCloseButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "TOPRIGHT" , 4 , 3 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:SetSize ( 320 , 110 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:SetPoint (  "Bottom" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "BOTTOM" , 0 , 10 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:SetScrollChild ( GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrameTitle:SetPoint ( "Bottom" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "TOP" , 0 , -3 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrameTitle:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 16 );
    -- Slider Parameters
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetOrientation ( "VERTICAL" );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetSize ( 20 , 85 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame , "TOPRIGHT" , -1.5 , -14.5 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetValue ( 0 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetValueStep ( 20 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetStepsPerPage ( 14 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetScript ( "OnValueChanged" , function ( self )
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:SetVerticalScroll ( self:GetValue() );
    end);

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_MainTag:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 7 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_MainTag:SetText ( GRM.L ( "(main)" ) );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_MainTag:SetTextColor ( 1.0 , 0.0 , 0.0 , 1.0 );

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingName:SetPoint ( "TOPLEFT" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "TOPLEFT" , 25 , -15 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingName:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingName:SetText ( GRM.L ( "Name" ) );

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLevel:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "TOP" , -60 , -15 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLevel:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLevel:SetText ( GRM.L ( "Level" ) );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLevel:SetWidth ( 75 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLevel:SetJustifyH ( "CENTER" );

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingRank:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "TOP" , 8 , -15 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingRank:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingRank:SetText ( GRM.L ( "Rank" ) );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingRank:SetWidth ( 75 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingRank:SetJustifyH ( "CENTER" );

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLastOnline:SetPoint ( "TOP" , GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame , "TOP" , 98 , -15 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLastOnline:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLastOnline:SetText ( GRM.L ( "Last Online" ) );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLastOnline:SetWidth ( 75 );
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingLastOnline:SetJustifyH ( "CENTER" );

    GRM_UI.AltGroupingBorderFrame_OnShow = function()
        if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:Hide();
        end
        GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.timer2 = 0;               -- reset onupdate timer...
        if GRM_UI.GRM_Mouseover:IsMouseOver() then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:ClearAllPoints();
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_Mouseover , "BOTTOMRIGHT" , -1 , 0 );
            GRM.BuildAltGroupingScrollFrame( GRM_G.currentName );
        elseif CalendarViewEventFrame and CalendarViewEventFrame:IsVisible() and CalendarViewEventFrame:IsMouseOver() then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:ClearAllPoints();
            if GRM.IsAddOnLoaded ( "LOIHCal" ) and not LOIHCalDB.config.overlay then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint ( "TOP" , LOIHCal_Container , "BOTTOM" , 0 , -50 );
            else
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint ( "BOTTOMLEFT" , CalendarViewEventFrame , "BOTTOMRIGHT" , 11 , 0 );
            end
            GRM_UI.GRM_Mouseover:Hide();
            GRM.BuildAltGroupingScrollFrame( GRM_G.CurrentCalendarName );
        elseif CalendarCreateEventFrame and CalendarCreateEventFrame:IsVisible() and CalendarCreateEventFrame:IsMouseOver() then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:ClearAllPoints();
            if GRM.IsAddOnLoaded ( "LOIHCal" ) and not LOIHCalDB.config.overlay then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint ( "TOP" , LOIHCal_Container , "BOTTOM" , 0 , -50 );
            else
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint ( "BOTTOMLEFT" , CalendarCreateEventFrame , "BOTTOMRIGHT" , 11 , 0 );
            end
            GRM_UI.GRM_Mouseover:Hide();
            GRM.BuildAltGroupingScrollFrame( GRM_G.CurrentCalendarName );
        end
        if not GRM_UI.GRM_Mouseover.GRM_ExtraAltDetailsArrowButton:IsMouseOver() then
            GRM.RestoreTooltip();
        end
    end

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript ( "OnShow" , GRM_UI.AltGroupingBorderFrame_OnShow );

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript ( "OnHide" , function()
        GRM_G.AltSideWindowFreeze = false;
    end);

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript ( "OnKeyDown" , function ( self , key )
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput ( false );
                self:Hide();
            end
        elseif key == "ESCAPE" then
            self:Hide();
        end
    end);

    -- Logic for initializing the sort lists of the alt grouping shift-click side frams
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript ( "OnMouseDown" , function ( self , button )
        if button == "LeftButton" then
            local needsRefresh = false;

            local setValue = function ( int )
                if GRM_G.altDetailsControl[1] ~= int then
                    GRM_G.altDetailsControl = { int , true };
                else
                    if GRM_G.altDetailsControl[2] then
                        GRM_G.altDetailsControl[2] = false;
                    else
                        GRM_G.altDetailsControl[2] = true;
                    end
                end
            end

            if self.GRM_AltGroupingName:IsMouseOver ( 1 , -1 , -1 , 1 ) then
                setValue ( 1 );
                needsRefresh = true;
            elseif self.GRM_AltGroupingLastOnline:IsMouseOver ( 1 , -1 , -1 , 1 ) then
                setValue ( 2 );
                needsRefresh = true;
            elseif self.GRM_AltGroupingLevel:IsMouseOver ( 1 , -1 , -1 , 1 ) then
                setValue ( 3 );
                needsRefresh = true;
            elseif self.GRM_AltGroupingRank:IsMouseOver ( 1 , -1 , -1 , 1 ) then
                setValue ( 4 );
                needsRefresh = true;
            end

            if needsRefresh then
                GRM.BuildAltGroupingScrollFrame( GRM_G.currentName );
            end
        end
    end);

    if not isManualUpdate then
        GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript ( "OnUpdate" , function ( self , elapsed )
            self.timer2 = self.timer2 + elapsed;
            self.timer1 = self.timer1 + elapsed;
            if self.timer2 > 0.05 then
                if ( self.GRM_AltGroupingName:IsMouseOver ( 1 , -1 , -1 , 1 ) or self.GRM_AltGroupingLastOnline:IsMouseOver ( 1 , -1 , -1 , 1 ) or self.GRM_AltGroupingLevel:IsMouseOver ( 1 , -1 , -1 , 1 ) or self.GRM_AltGroupingRank:IsMouseOver ( 1 , -1 , -1 , 1 ) ) then
                    if not self.GRM_AltGroupHeaderTooltip:IsVisible() then
                        self.GRM_AltGroupHeaderTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                        self.GRM_AltGroupHeaderTooltip:AddLine( GRM.L ( "Click to Sort" ) );
                        self.GRM_AltGroupHeaderTooltip:Show();
                    end;
                elseif self.GRM_AltGroupHeaderTooltip:IsVisible() then
                    self.GRM_AltGroupHeaderTooltip:Hide();
                end

                if self.timer1 > 300 then
                    GRM.BuildAltGroupingScrollFrame( GRM_G.currentName );      -- Rebuild every 5 min just in case changes.
                    self.timer1 = 0;
                end
                self.timer2 = 0;
            end
        end);
    end

end

-- Method:              GRM.RosterFrame()
-- What it Does:        Acts as the OnUpdate handler for hiding the frame when necessary and keeping the player presence status and time in zone up to date.
-- Purpose:             Quality of Life UI controls!
GRM.RosterFrame = function()
    if GRM.GetGuild() then

        if GRM_G.pause and not GRM_UI.GRM_Mouseover:IsVisible() and not GRM_UI.MemberDetailFrame:IsVisible() then

            if not GRM_UI.MemberDetailFrame:IsVisible() then
                GRM_G.pause = false;
            end

        end

        -- Ensure pinned to correct window.
        if not GRM_G.pause and not CommunitiesFrame.MemberList.ScrollBox:IsMouseOver(4, -20, -4, 30)then

            if not GRM_UI.GRM_Mouseover:IsVisible() or
                (
                    GRM_UI.GRM_Mouseover:IsVisible() and
                    CommunitiesFrame and
                    not CommunitiesFrame.MemberList.ScrollBox:IsMouseOver(4, -20, -4, 30) and
                    not DropDownList1MenuBackdrop:IsMouseOver(2, -2, -2, 2) and
                    not StaticPopup1:IsMouseOver(2, -2, -2, 2) and
                    not GRM_UI.GRM_Mouseover:IsMouseOver(1, -1, -30, 1) and
                    not GRM_UI.GRM_Mouseover.GRM_CoreAltFrame:IsMouseOver(5, 5, 5, 35) and
                    not GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:IsMouseOver(1, 1,
                        1, 3)
                ) then 
                    GRM.ClearAllFrames(true); -- If player is moused over side window, it will not hide it!
            end
        end

        local player = GRM.GetPlayer(GRM_G.currentName);
        if player then

            -- updates zone change info on the fly, as well as online status.
            if (time() - GRM_G.CommunitiesUpdateTimer) > 5 then

                local memberInfo = GRM.GetClubMemberInfo(player.name, GRM_G.gClubID);
                if memberInfo then
                    player.isOnline = GRM.IsPresenceOnline(memberInfo.presence);

                    if player.zone ~= memberInfo.zone then
                        player.zone = memberInfo.zone;
                        player.timeEnteredZone = time(); -- Resets the time
                    end

                end

                GRM_G.CommunitiesUpdateTimer = time();
            end

            -- Keep this data onUpdate handled...
            if player.isOnline or GRM_G.currentName == GRM_G.addonUser then

                if not GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:IsVisible() then
                    if player.zone ~= nil then
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone);
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetText(
                            GRM.Time.GetTimePassedInZone(player.timeEnteredZone));
                    end
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Show();
                end

                -- ACTIVE
                if player.isOnline and player.status == 0 then
                    if GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:GetText() ~= GRM_G.Status[1] then
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetTextColor(0.12, 1.0, 0.0, 1.0);
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetText(GRM_G.Status[1]);
                    end

                    -- AFK
                elseif player.status == 1 then
                    if GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:GetText() ~= GRM_G.Status[4] then
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetTextColor(1.0, 0.96, 0.41, 1.0);
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetText(GRM_G.Status[4]);
                    end

                    -- BUSY
                elseif player.status == 2 then
                    if GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:GetText() ~= GRM_G.Status[5] then
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetTextColor(0.77, 0.12, 0.23, 1.0);
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetText(GRM_G.Status[5]);
                    end
                end
                if not GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:Show();
                end

                -- MOBILE only
            elseif player.isMobile then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetTextColor(0.87, 0.44, 0.0, 1.0);
                GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetText(GRM_G.Status[2]);
                if not GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:Show();
                end

            elseif not player.isOnline then
                if GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:GetText() ~= GRM_G.Status[3] then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetTextColor(0.5, 0.5, 0.5, 1.0);
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:SetText(GRM_G.Status[3]);
                end
                if not GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:Show();
                end

            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailPlayerStatus:Hide(); -- Don't know what to do!
            end
        else
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Hide();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Hide();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Hide();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Hide();
        end

        if (CommunitiesFrame and not CommunitiesFrame:IsVisible()) then
            GRM.ClearAllFrames(true); -- Reset frames and hide metadata frame...
        end
    end

end

-- Method:          GRM.AltButtonPos(int)
-- What it Does:    Returns the horizontal and vertical coordinates for the button position on frame
-- Purpose:         To adjust the position of the AddAlt button based on the number of alts.
GRM.AltButtonPos = function(index)
    local result;
    if index == 0 then
        result = {2, -16};
    elseif index == 1 then
        result = {32, -20};
    elseif index == 2 then
        result = {-32, -37};
    elseif index == 3 then
        result = {32, -37};
    elseif index == 4 then
        result = {-32, -54};
    elseif index == 5 then
        result = {32, -54};
    elseif index == 6 then
        result = {-32, -71};
    elseif index == 7 then
        result = {32, -71};
    elseif index == 8 then
        result = {-32, -88};
    elseif index == 9 then
        result = {32, -88};
    elseif index == 10 then
        result = {-32, -103};
    elseif index == 11 then
        result = {32, -103};
    else -- is 12+ alts
        result = {-32, -120};
    end
    return result;
end

-- Method:          GRM.GetLevelRange()
-- What it Does:    Returns a text string of the current level range
-- Purpose:         Clean and clear reporting to the player what levels will be reported to the log.
GRM.GetLevelRange = function()
    local result = "";

    if GRM.S().recordLevelUp then
        result = "|cffffd100" .. GRM.L("Reporting:") .. "|r|cff00ccff";
        local initialNumber = "";
        local caps = {10, 20, 30, 40, 50, 60, 70, 80, 90};
        local addon = "";

        local atLeastOne = false;
        if GRM.S().levelReportMin == GRM_G.LvlCap and GRM.S().levelFilters[#GRM.S().levelFilters] then
            initialNumber = tostring(GRM_G.LvlCap);
            atLeastOne = true;
        elseif GRM.S().levelReportMin < GRM_G.LvlCap then
            initialNumber = GRM.S().levelReportMin .. "-" .. GRM_G.LvlCap;
            atLeastOne = true;
        end

        local count = 0;
        for i = 1, #GRM.S().levelFilters do
            if GRM.S().levelFilters[i] and GRM.S().levelReportMin > caps[i] then
                -- This is a standalone number...
                if count == 0 then
                    addon = caps[i];
                    count = 1;
                else
                    addon = addon .. " , " .. caps[i];
                end
            elseif GRM.S().levelReportMin <= caps[i] then
                break
            end
        end
        if addon ~= "" then
            result = result .. " " .. addon;
            if atLeastOne then
                result = result .. " , " .. initialNumber;
            end
        elseif atLeastOne then
            result = result .. " " .. initialNumber;
        else
            result = GRM.L("No Levels to Report to Log");
        end
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetTextColor(
            0, 0.82, 1, 1);
    else
        result = GRM.L("No Levels to Report to Log");
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetTextColor(
            1, 0, 0, 1);
    end

    return result;
end

-- Method:          GRM.CopyFromJoinDate()
-- What it Does:    Imports the promo date from a verified Join Date
-- Purpose:         Just another tool to ease player abilities for setting dates
GRM.CopyFromJoinDate = function()
    local player = GRM.GetPlayer(GRM_G.currentName);

    if player then
        -- Set it to rank history
        local tStamp = GRM.Util.DeepCopyArray(player.joinDateHist[1]);
        player.rankHist[1][1] = player.rankName;
        player.rankHist[1][2] = tStamp[1];
        player.rankHist[1][3] = tStamp[2];
        player.rankHist[1][4] = tStamp[3];
        player.rankHist[1][5] = tStamp[4];
        player.rankHist[1][6] = time();
        player.rankHist[1][7] = true
        player.rankHist[1][8] = 1;

        player.promoteDateUnknown = false;

        if player.isOnline then
            if player.zone ~= nil then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone); -- Zone
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetText(GRM.Time.GetTimePassedInZone(
                    player.timeEnteredZone)); -- Time Passed
            end
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Show();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Show();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Show();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Show();
        end

        GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " ..
                                                                                GRM_UI.GRM_Mouseover
                                                                                    .GRM_JoinDateText:GetText());
        GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Hide();
        GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();

        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().syncRank;
            if GRM.S().exportAllRanks then
                syncRankFilter = GuildControlGetNumRanks() - 1;
            end
            GRMsync.SendMessage("GRM_SYNC",
                "GRM_PD?" .. syncRankFilter .. "?" .. player.name .. "?" .. tostring(player.rankHist[1][5]) .. "?" ..
                    tostring(player.rankHist[1][6]), "GUILD");
        end

        GRM_UI.Unpause();
        -- Update Audit Frames.
        GRM_UI.RefreshSelectFrames(false, true, false, true, true, true);
    end

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
end

-- Method:          GRM.CopyFromPromoDate()
-- What it Does:    Imports the join date from a verified Promo Date
-- Purpose:         Just another tool to ease player abilities for setting dates
GRM.CopyFromPromoDate = function()
    local player = GRM.GetPlayer(GRM_G.currentName);
    local showBdayText = false;
    local rankButton = false;
    local formatBdayStamp = "";

    if player then

        local tStamp = GRM.Util.DeepCopyArray(player.rankHist[1]);
        player.joinDateHist[1][1] = tStamp[2];
        player.joinDateHist[1][2] = tStamp[3];
        player.joinDateHist[1][3] = tStamp[4];
        player.joinDateHist[1][4] = tStamp[5];
        player.joinDateHist[1][5] = time();
        player.joinDateHist[1][6] = true;
        player.joinDateHist[1][7] = 1;

        player.joinDateUnknown = false;

        local birthdayInfo = GRM.GetBirthday ( player );

        if birthdayInfo.date[1] ~= 0 then
            showBdayText = true;
            formatBdayStamp = GRM.Time.FormatTimeStamp( { birthdayInfo.date[1] , birthdayInfo.date[2] }, false, true);
        end

        local joinDate = GRM.Time.FormatTimeStamp({player.joinDateHist[1][1], player.joinDateHist[1][2],
                                              player.joinDateHist[1][3]}, false);

        -- Update timestamp to officer note.
        GRM.AddTimeStampToNote( player.name, player.GUID , joinDate);

        player.anniversaryAnnounced = false; -- Gotta Reset the "reported already" boolean!
        GRM.RemoveFromCalendarQue(player.name, 1, nil);

        if player.rankHist[1][2] == 0 and not player.promoteDateUnknown then
            rankButton = true;
        end

        -- Need player index to get this info.
        if player.isOnline then
            if player.zone ~= nil then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone); -- Zone
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetText(GRM.Time.GetTimePassedInZone(
                    player.timeEnteredZone)); -- Time Passed
            end
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Show();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Show();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Show();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Show();
        end

        -- Let's send the changes out as well!
        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().syncRank;
            if GRM.S().exportAllRanks then
                syncRankFilter = GuildControlGetNumRanks() - 1;
            end
            GRMsync.SendMessage("GRM_SYNC",
                "GRM_JD?" .. syncRankFilter .. "?" .. player.name .. "?" .. player.joinDateHist[1][4] .. "?" ..
                    tostring(player.joinDateHist[1][5]), "GUILD");
        end

        GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Hide();
        GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetText(joinDate)
        GRM_UI.GRM_Mouseover.GRM_JoinDateText:Show();
        if rankButton then
            GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Show();
        else
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();
        end

        -- Birthday Logic restoration
        if GRM.S().showBDay and not GRM_UI.GRM_Mouseover.GRM_BirthdayText:IsVisible() and
            not GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:IsVisible() then
            if showBdayText then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Hide();
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetText(formatBdayStamp);
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Show();
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:Hide();
            end
        end

        GRM_UI.Unpause();
        -- Update the Audit Frames!
        GRM_UI.RefreshSelectFrames(false, true, false, true, true, true);

    end

    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
end

-----------------------------------
--- Player Window Edit Logic ------
-----------------------------------

-- Method:          GRM.IsMouseOverAltButton()
-- What it Does:    Returns true if players is over any of the alt listing names
-- Purpose:         So when a player right-clicks the mouseOver screen, it can either let you know you are already over an AltName Button, so no need to do more work
--                  Or, if you aren't, then you can check to see if you are moused over the other fontstrings.
GRM.IsMouseOverAltButton = function()
    local result = false;

    for i = 1, #GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame
        .allFrameButtons do
        if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame
            .allFrameButtons[i][1]:IsMouseOver() then
            result = true;
            break
        end
    end
    return result;
end

-- Method:          GRM.GetSelectedName()
-- What it Does:    Returns a table with the name of the player, the altName, and the guild.
-- Puspose:         To easily pass the info on without having to use a global variable, and set one function to all right click logic on the main window.
GRM.GetSelectedName = function(name)
    local focusName, altName, isMain = nil, nil, false;

    if name then
        focusName = name;
        altName = name;

        if GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:IsVisible() then
            isMain = true;
        end
    end

    return {focusName, altName, isMain};
end

-- Method:          GRM.MouseOverClearAllTooltips()
-- What it Does:    Hides all GRM tooltips
-- Purpose:         When using right-click context menu it makes sense to clear any tooltip as window appears.
GRM.MouseOverClearAllTooltips = function()
    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankToolTip:Hide();
    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateToolTip:Hide();
    GRM_UI.GRM_Mouseover.GRM_MemberDetailServerNameToolTip:Hide();
    GRM_UI.GRM_Mouseover.GRM_MemberDetailNotifyStatusChangeTooltip:Hide();
    GRM_UI.GRM_Mouseover.GRM_BirthdayTooltip:Hide();
end

-- Method:          GRM.SetAltAsMainDropDownMenuLogic ( table )
-- What it Does:    using the right click dropdown menu, it sets the given chosen name as the main
-- Purpose:         Bring in customizability and flexibility and ease of configuration to the player
GRM.SetAltAsMainDropDownMenuLogic = function(altDetails)
    local timestamp = time();

    if altDetails[1] ~= altDetails[2] then

        if GRM.GetPlayer(altDetails[2]) then
            GRM.SetMain(altDetails[2], timestamp);

            -- Now send Comm to sync details.
            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().syncRank;
                if GRM.S().exportAllRanks then
                    syncRankFilter = GuildControlGetNumRanks() - 1;
                end
                GRMsync.SendMessage("GRM_SYNC", "GRM_MAIN?" .. syncRankFilter .. "?" .. altDetails[2] .. "?" ..
                    tostring(timestamp), "GUILD");
            end
        end
    else
        if GRM.GetPlayer(altDetails[1]) then

            GRM.SetMain(altDetails[1], timestamp);
            if not GRM_UI.GRM_DropDownList1AttachmentFrame.pausedPreviously then
                GRM_UI.Unpause();
            end

            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().syncRank;
                if GRM.S().exportAllRanks then
                    syncRankFilter = GuildControlGetNumRanks() - 1;
                end
                GRMsync.SendMessage("GRM_SYNC", "GRM_MAIN?" .. syncRankFilter .. "?" .. altDetails[1] .. "?" ..
                    tostring(timestamp), "GUILD");
            end
        end
    end
    GRM_UI.RefreshSelectFrames(false, true, false, false, true, false, true);

    GRM.Report(GRM.L("{name} is now set as \"main\"", GRM.GetClassifiedName(altDetails[2], true)));
end

-- Method:          GRM.DemoteMainToAltDropDownMenuLogic ( table )
-- What it Does:    Demotes a player from main and sets them as alt and configures the UI to reflect it
-- Purpose:         Flexibility and quality of life for the player
GRM.DemoteMainToAltDropDownMenuLogic = function(altDetails)
    local timestamp = time();

    if altDetails[1] ~= altDetails[2] then
        GRM.DemotePlayerFromMain(altDetails[2]);

        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().syncRank;
            if GRM.S().exportAllRanks then
                syncRankFilter = GuildControlGetNumRanks() - 1;
            end
            GRMsync.SendMessage("GRM_SYNC",
                "GRM_RMVMAIN?" .. syncRankFilter .. "?" .. altDetails[2] .. "?" .. tostring(timestamp), "GUILD");
        end
    else
        -- No need to set as main yet... let's set player to main here.
        local player = GRM.GetPlayer(altDetails[1]);
        if player then
            GRM.DemotePlayerFromMain(altDetails[1]);
            if not GRM_UI.GRM_DropDownList1AttachmentFrame.pausedPreviously then
                GRM_UI.Unpause();
            end

            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().syncRank;
                if GRM.S().exportAllRanks then
                    syncRankFilter = GuildControlGetNumRanks() - 1;
                end
                GRMsync.SendMessage("GRM_SYNC", "GRM_RMVMAIN?" .. syncRankFilter .. "?" .. altDetails[1] .. "?" ..
                    tostring(timestamp), "GUILD");
            end
        end
    end

    GRM_UI.RefreshSelectFrames(false, true, false, false, true, false, true);

    GRM.Report(GRM.L("{name} is no longer set as \"main\"", GRM.GetClassifiedName(altDetails[2], true)));
end

-- Method:          GRM.BuildAltGroupingScrollFrame( string )
-- What it Does:    It builds the alt groupings info on mouseover with shift pressed
-- Purpose:         For quick look at the alt info...
GRM.BuildAltGroupingScrollFrame = function(currentName)
    local scrollHeight = 0;
    local scrollWidth = 315;
    local buffer = 9;
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
        .GRM_AltGroupingScrollFrameSlider:SetValue(0);

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.AllFrameFontstrings =
        GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
            .AllFrameFontstrings or {}; -- Create a table for the Buttons.
    -- Building all the fontstrings.
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrameTitle:SetText(
        GRM_G.CurrentCalendarHexCode .. GRM.L("{name}'s Alts", GRM.SlimName(currentName)));

    if GRM.GetPlayer(currentName) then

        -- Collect all the alt names and sort them.
        local listOfAlts = GRM.GetSortedAltNamesWithDetails(currentName);
        local mainFound = false;
        for i = 1, #listOfAlts do -- The +1 is for the player so they can count themselves too...
            -- if font string is not created, do so.
            if not GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .AllFrameFontstrings[i] then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                    .AllFrameFontstrings[i] = {GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                                               GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                                               GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                                               GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")};
            end

            local AltName = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                .GRM_AltGroupingScrollChildFrame.AllFrameFontstrings[i][1];
            local AltLvl = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                               .GRM_AltGroupingScrollChildFrame.AllFrameFontstrings[i][2];
            local AltRank = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                .GRM_AltGroupingScrollChildFrame.AllFrameFontstrings[i][3];
            local AltLastOnline = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                      .GRM_AltGroupingScrollChildFrame.AllFrameFontstrings[i][4];

            local altClassRGB = GRM.GetClassColorRGB(listOfAlts[i][3], false);

            AltName:SetText(GRM.SlimName(listOfAlts[i][1]));
            AltName:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9);
            AltName:SetJustifyH("LEFT");
            AltName:SetTextColor(altClassRGB[1], altClassRGB[2], altClassRGB[3], 1);

            AltLvl:SetText(listOfAlts[i][2]);
            AltLvl:SetWidth(75);
            AltLvl:SetWordWrap(false);
            AltLvl:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9);
            AltLvl:SetJustifyH("CENTER");

            AltRank:SetText(GuildControlGetRankName(listOfAlts[i][4] + 1));
            AltRank:SetWidth(75);
            AltRank:SetWordWrap(false);
            AltRank:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9);
            AltRank:SetJustifyH("CENTER");

            AltLastOnline:SetWidth(100);
            AltLastOnline:SetWordWrap(false);
            AltLastOnline:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9);

            -- Last Online
            if listOfAlts[i][9] then
                AltLastOnline:SetText(GRM.L("Online"));
                AltLastOnline:SetTextColor(0.12, 1.0, 0.0, 1.0);
            else
                AltLastOnline:SetText(GRM.Time.HoursReport(listOfAlts[i][10]));
                AltLastOnline:SetTextColor(1, 1, 1, 1.0);
            end

            local stringHeight = AltLastOnline:GetStringHeight();

            -- Now let's pin it!
            if i == 1 then
                AltName:SetPoint("TOPLEFT", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame, "TOPLEFT", 14, -5);
                AltLvl:SetPoint("TOP", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame, "TOP", -60, -5);
                AltRank:SetPoint("TOP", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame, "TOP", 10, -5);
                AltLastOnline:SetPoint("TOP", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                    .GRM_AltGroupingScrollChildFrame, "TOP", 98, -5);

                scrollHeight = scrollHeight + stringHeight;
            else
                AltName:SetPoint("TOPLEFT",
                    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                        .AllFrameFontstrings[i - 1][1], "BOTTOMLEFT", 0, -buffer);
                AltLvl:SetPoint("TOP",
                    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                        .AllFrameFontstrings[i - 1][2], "BOTTOM", 0, -buffer);
                AltRank:SetPoint("TOP",
                    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                        .AllFrameFontstrings[i - 1][3], "BOTTOM", 0, -buffer);
                AltLastOnline:SetPoint("TOP",
                    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                        .AllFrameFontstrings[i - 1][4], "BOTTOM", 0, -buffer);
                scrollHeight = scrollHeight + stringHeight + buffer;
            end
            -- Main tag
            if listOfAlts[i][5] then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                    .GRM_MainTag:SetPoint("TOP", AltName, "BOTTOM");
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                    .GRM_MainTag:Show();
                mainFound = true;
            end

            AltName:Show();
            AltLvl:Show();
            AltRank:Show();
            AltLastOnline:Show();
        end

        if not mainFound then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame.GRM_MainTag:Hide();
        end

        -- Hides all the additional strings... if necessary
        for i = #listOfAlts + 1, #GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
            .GRM_AltGroupingScrollChildFrame.AllFrameFontstrings do
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .AllFrameFontstrings[i][1]:Hide();
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .AllFrameFontstrings[i][2]:Hide();
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .AllFrameFontstrings[i][3]:Hide();
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .AllFrameFontstrings[i][4]:Hide();
        end

        -- Update the size -- it either grows or it shrinks!
        GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame:SetSize(
            scrollWidth, scrollHeight);

        -- Set Slider Parameters ( has to be done after the above details are placed )
        local scrollMax = (scrollHeight - 105) + (buffer);
        if scrollMax < 0 then
            scrollMax = 0;
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .GRM_AltGroupingScrollFrameSlider:Hide();
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:EnableMouseWheel(
                false);
        else
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .GRM_AltGroupingScrollFrameSlider:SetMinMaxValues(0, scrollMax);
            -- Mousewheel Scrolling Logic
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:EnableMouseWheel(
                true);
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:SetScript(
                "OnMouseWheel", function(_, delta)
                    local current = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                        .GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:GetValue();

                    if delta < 0 and current < scrollMax then
                        if IsControlKeyDown() then
                            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                .GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetValue(current + 60);
                        else
                            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                .GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetValue(current + 20);
                        end
                    elseif delta > 0 and current > 1 then
                        if IsControlKeyDown() then
                            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                .GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetValue(current - 60);
                        else
                            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
                                .GRM_AltGroupingScrollChildFrame.GRM_AltGroupingScrollFrameSlider:SetValue(current - 20);
                        end
                    end
                end);
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame
                .GRM_AltGroupingScrollFrameSlider:Show();
        end
    end
end

-- Method:          GRM.BuildAutoCompleteAltSelectionScrollFrame ( table )
-- What it Does:    The add alt list is now a scroll frame rather than 6 static choices...
-- Purpose:         Quality of life improvement on selecting players to add to alt. Just makes it easier to find matches.
GRM.BuildAutoCompleteAltSelectionScrollFrame = function(listOfAlts)
    local buttonCap = GRM_G.MaxAltAutoCompleteList;
    local numButtons = #listOfAlts;
    if numButtons > buttonCap then
        numButtons = buttonCap;
    end
    GRM_G.NumberAltInSelection = numButtons;

    local scrollHeight = 0;
    local scrollWidth = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:GetWidth() - 10;

    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons =
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons or {}; -- Create a table for the Buttons.
    for i = 1, numButtons do -- The +1 is for the player so they can count themselves too...
        -- if font string is not created, do so.
        if not GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame
            .AllButtons[i] then
            local tempButton = CreateFrame("Button", "AltSelection" .. i, GRM_UI.GRM_Mouseover
                .GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame); -- Names each Button 1 increment up
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")};
        end

        local button = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame
                           .AllButtons[i][1];
        local buttonText = GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame
                               .GRM_AddAltScrollChildFrame.AllButtons[i][2];

        button:SetSize(149, 18.5);
        button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");

        local classColor = GRM.GetClassColorRGB(listOfAlts[i][2], false);
        buttonText:SetTextColor(classColor[1], classColor[2], classColor[3]);
        buttonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
        buttonText:SetJustifyH("LEFT");
        buttonText:SetText(listOfAlts[i][1] .. GRM.GetAltTag(listOfAlts[i][3]));
        buttonText:SetPoint("LEFT", button);

        if i == 1 then
            button:SetPoint("TOP", GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame
                .GRM_AddAltScrollChildFrame, "TOP", 0, 0);
        else
            button:SetPoint("TOPLEFT", GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame
                .GRM_AddAltScrollChildFrame.AllButtons[i - 1][1], "BOTTOMLEFT", 0, 0);
        end
        -- Build height
        scrollHeight = scrollHeight + button:GetHeight();
        -- Set button logic...
        button:SetScript("OnClick", function(_, key)
            if key == "LeftButton" then

                local result = GRM.RemoveMainAltTags(GRM_UI.GRM_Mouseover.GRM_CoreAltFrame
                                                         .GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i][2]:GetText())

                if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:GetText() ==
                    result then

                    GRM_UI.AddAltSideFrameLogic(GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame
                                                    .GRM_AddAltEditBox);

                else
                    GRM_G.currentHighlightIndex = i;
                    result = GRM.RemoveMainAltTags(result);
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetText(
                        result);
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetFocus();
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:SetCursorPosition(
                        #GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:GetText());
                    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:HighlightText(
                        #GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltEditBox:GetText() +
                            1);
                    GRM.AddAltAutoComplete();
                end

            end
        end);
        button:Show();
    end
    -- Hide unused buttons...
    for i = numButtons + 1, #GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame
        .GRM_AddAltScrollChildFrame.AllButtons do
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i][1]:Hide();
    end
    -- Reset the highlight...

    -- Configure Slider
    GRM.ConfigureSlider(GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrame,
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame,
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollFrameSlider, scrollWidth,
        scrollHeight, 84, true)
end

-- Method:          GRM.ResetAutoCompleteHighlights()
-- What it Does:    Resets all highlights and disables except for the one selected
-- Purpose:         Quality of life visual controls...
GRM.ResetAutoCompleteHighlights = function()
    for i = 1, #GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame
        .AllButtons do
        if i ~= GRM_G.currentHighlightIndex then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[i][1]:UnlockHighlight();
        end
    end
end

-- Method:          GRM.BuildCustomNoteScrollFrame ( string )
-- What it Does:    Builds the custom note scroll frame
-- Purpose:         To have a customizable scrollable scrollframe!!!
GRM.BuildCustomNoteScrollFrame = function(customNote)
    if GRM_G.previousNote ~= customNote then
        GRM_G.previousNote = customNote;
        local scrollHeight = 0;
        local scrollWidth = 123;

        if customNote == "" and
            not GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
            customNote = GRM.L("Click here to set Custom Notes");
        end
        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText(customNote);

        -- Slight delay needed before you can do a GetHeight()
        C_Timer.After(0.05, function()
            scrollHeight = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetHeight();
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetSize(scrollWidth,
                scrollHeight + 10);

            local scrollMax = (scrollHeight - 80) + GRM_G.FontModifier + 5;
            if scrollMax < 0 then
                scrollMax = 0;
            end
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetMinMaxValues(
                0, scrollMax);
            -- Mousewheel Scrolling Logic
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:EnableMouseWheel(true);
            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetScript(
                "OnMouseWheel", function(_, delta)
                    local current = GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame
                                        .GRM_CustomNoteScrollFrameSlider:GetValue();

                    if IsShiftKeyDown() and delta > 0 then
                        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(
                            0);
                    elseif IsShiftKeyDown() and delta < 0 then
                        GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(
                            scrollMax);
                    elseif delta < 0 and current < scrollMax then
                        if IsControlKeyDown() then
                            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(
                                current + 60);
                        else
                            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(
                                current + 20);
                        end
                    elseif delta > 0 and current > 1 then
                        if IsControlKeyDown() then
                            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(
                                current - 60);
                        else
                            GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(
                                current - 20);
                        end
                    end
                end);
        end);
    end
end

------------------------------------
---- BEGIN OF FRAME/UI LOGIC -------
---- General Framebuild Methods ----
------------------------------------

-- Method:          GRM.SetJoinDate( string , int , int , int )
-- What it Does:    Sets the player's join date properly, be it the first time, a modified time, or an edit.
-- Purpose:         For so many uses! Anniversary tracking, for editing the date, and so on...
GRM.SetJoinDate = function(name, dayJoined, monthJoined, yearJoined)
    name = name or GRM_G.currentName;
    dayJoined = dayJoined or tonumber(GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected.GRM_DayText:GetText());
    monthJoined = monthJoined or GRM.Time.Enums.months_full_name[GRML.OrigL( GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected.GRM_MonthText:GetText())];
    yearJoined = yearJoined or tonumber(GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected.GRM_YearText:GetText());

    if GRM.Time.IsValidSubmitDate(dayJoined, monthJoined, yearJoined, GRM.Time.IsLeapYear(yearJoined)) then
        local rankButton = false;
        local showBdayText = false;
        local formatBdayStamp = "";
        local player = GRM.GetPlayer(name);

        if player then

            -- For metadata tracking
            if GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:GetText() == GRM.L("Edit Join Date") or
                player.joinDateHist[1][1] == 0 then
                table.remove(player.joinDateHist, 1); -- Removing previous instance to replace
            end

            table.insert(player.joinDateHist, 1,
                {dayJoined, monthJoined, yearJoined,
                 GRM.Time.ConvertToStandardFormatDate(dayJoined, monthJoined, yearJoined), time(), true, 1});

            -- If it was unKnown before
            player.joinDateUnknown = false;

            local birthdayInfo = GRM.GetBirthday(player);
            if birthdayInfo.date[1] ~= 0 then
                showBdayText = true;
                formatBdayStamp = GRM.Time.FormatTimeStamp({ birthdayInfo.date[1] , birthdayInfo.date[2] }, false, true);
            end

            -- For UI
            local finalTStamp = GRM.Time.FormatTimeStamp({dayJoined, monthJoined, yearJoined}, false, false, false);
            GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetText(finalTStamp);

            -- Update timestamp to note.
            GRM.AddTimeStampToNote( name , player.GUID , finalTStamp);

            player.anniversaryAnnounced = false; -- Gotta Reset the "reported already" boolean!
            GRM.RemoveFromCalendarQue(name, 1, nil);

            GRM_UI.RefreshSelectFrames(false, true, false, false, false, true);

            if player.rankHist[1][2] == 0 and not player.promoteDateUnknown then
                rankButton = true;
            end

            -- Need player index to get this info.
            if player.isOnline then
                if player.zone ~= nil then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone); -- Zone
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetText(
                        GRM.Time.GetTimePassedInZone(player.timeEnteredZone)); -- Time Passed
                end
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Show();
            end

            -- Let's send the changes out as well!
            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().syncRank;
                if GRM.S().exportAllRanks then
                    syncRankFilter = GuildControlGetNumRanks() - 1;
                end

                GRMsync.SendMessage("GRM_SYNC",
                    "GRM_JD?" .. syncRankFilter .. "?" .. name .. "?" .. player.joinDateHist[1][4] .. "?" ..
                        tostring(player.joinDateHist[1][5]), "GUILD");

            end
        end

        GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Hide();
        GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Hide();
        GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Hide();
        GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:Hide();
        GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:Hide();
        GRM_UI.GRM_Mouseover.GRM_JoinDateText:Show();
        if rankButton then
            GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Show();
        else
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();
        end

        -- Birthday Logic restoration
        if GRM.S().showBDay and not GRM_UI.GRM_Mouseover.GRM_BirthdayText:IsVisible() and
            not GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:IsVisible() then
            if showBdayText then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Hide();
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetText(formatBdayStamp);
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Show();
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:Hide();
            end
        end

        -- Show if there are alts to unify join dates
        if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
            if GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint("LEFT",
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton, "RIGHT", 0, 0);
            elseif GRM_UI.GRM_Mouseover.GRM_JoinDateText:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint("LEFT",
                    GRM_UI.GRM_Mouseover.GRM_JoinDateText, "RIGHT", 8, -0.5);
            end
            GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Show();
        else
            GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Hide();
        end

        GRM_UI.Unpause();
        -- Update the Audit Frames!
        GRM_UI.RefreshSelectFrames(false, true, false, true, true, true);
    end
end

-- Method:          GRM.PlayerHasJoinDate ( string )
-- What it Does:    Returns true if the current selected player has a listed Join Date, with the given JoinDate
-- Purpose:         For the Join Date selection, this will let us know if an option to sync to the selected player's join date should be given.
GRM.PlayerHasJoinDate = function(playerName)
    local result = {false, ""};
    local player = GRM.GetPlayer(playerName);

    if player then
        if #player.joinDateHist[1][4] > 1 then -- Player Has a join date!
            result = {true,
                      GRM.Time.FormatTimeStamp(
                {player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]}, false, false)};
        end
    end
    return result;
end

-- Method:          GRM.SetPromoDate()
-- What it Does:    Set's the date the player was promoted to the current rank
-- Purpose:         Date tracking and control of rank promotions.
GRM.SetPromoDate = function(name, day, month, year, isManual)
    name = name or GRM_G.currentName;
    day = day or tonumber(GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected.GRM_DayText:GetText());
    month = month or GRM.Time.Enums.months_full_name[GRML.OrigL( GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected.GRM_MonthText:GetText())];
    year = year or tonumber(GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected.GRM_YearText:GetText());

    if GRM.Time.IsValidSubmitDate(day, month, year, GRM.Time.IsLeapYear(year)) then
        local player = GRM.GetPlayer(name);

        if player then

            -- Promo Save Data
            player.rankHist[1][1] = player.rankName;
            player.rankHist[1][2] = day;
            player.rankHist[1][3] = month;
            player.rankHist[1][4] = year;
            player.rankHist[1][5] = GRM.Time.ConvertToStandardFormatDate(day, month, year);
            player.rankHist[1][6] = time();
            player.rankHist[1][7] = true;
            player.rankHist[1][8] = 1;

            -- If player had it set to "unknown before"
            player.promoteDateUnknown = false;

            if name == GRM_G.currentName and GRM_UI.GRM_Mouseover:IsVisible() then

                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " ..
                                                                                        GRM.Time.FormatTimeStamp(
                        {player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]}, false));

                if player.isOnline then
                    if player.zone ~= nil then
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone); -- Zone
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetText(
                            GRM.Time.GetTimePassedInZone(player.timeEnteredZone)); -- Time Passed
                    end
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Show();
                end
            end

            if not isManual then
                -- Send the details out for others to pickup!
                if GRM.S().syncEnabled then
                    local syncRankFilter = GRM.S().syncRank;
                    if GRM.S().exportAllRanks then
                        syncRankFilter = GuildControlGetNumRanks() - 1;
                    end
                    GRMsync.SendMessage("GRM_SYNC",
                        "GRM_PD?" .. syncRankFilter .. "?" .. name .. "?" .. tostring(player.rankHist[1][5]) .. "?" ..
                            tostring(player.rankHist[1][6]), "GUILD");
                end
            end
        end

        if name == GRM_G.currentName and GRM_UI.GRM_Mouseover:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Hide();
            GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Hide();
            GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Hide();
            GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:Hide();
            GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:Hide();
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();

            GRM_UI.Unpause();
            -- Update Audit Frames.
            GRM_UI.RefreshSelectFrames(false, true, false, true, true, true);
        end
    end
end

-- Method:          GRM.DateSubmitCancelResetLogic( boolean , string , boolean , string )
-- What it Does:    Resets the logic on what occurs with the cancel button, since it will have multiple uses.
-- Purpose:         Resource efficiency. No need to make new buttons for everything! This reuses the button, just resets the click logic in join date submit cancel event.
GRM.DateSubmitCancelResetLogic = function(isUnknown, date, isAudit, playerName)
    local buttonText = GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:GetText();
    local joinDateText = GRM.L("Set Join Date");
    local promoDateText = GRM.L("Set Promo Date");
    local bDayDateText = GRM.L("Set Birthday");
    local editDateText = GRM.L("Edit Promo Date");
    local editJoinText = GRM.L("Edit Join Date");
    local name = GRM_G.currentName;
    local showJoinText = false;
    local showBdayText = false;
    local formatBdayStamp = "";

    -- For the audit
    if isAudit then
        if date == "join" then
            buttonText = joinDateText;
        elseif date == "promo" then
            buttonText = promoDateText;
        elseif date == "bday" then
            buttonText = bDayDateText;
        end
    end

    -- To save values properly.
    if isAudit and playerName ~= nil then
        name = playerName;
    end

    local player = GRM.GetPlayer(name);
    -- Need player index to get this info.

    if player then
        if player.name == GRM_G.currentName then
            if (player.promoteDateUnknown or player.rankHist[1][7]) then
                GRM_G.rankDateSet = true;
            end
            if player.joinDateUnknown or #player.joinDateHist[1][4] > 1 then
                showJoinText = true;
            end

            if isUnknown and date == "bday" then
                GRM.SetBirthdayInfo ( player , nil , nil , nil , nil , true );
            end

            local birthdayInfo = GRM.GetBirthday ( player );

            if birthdayInfo.unknown or birthdayInfo.date[1] ~= 0 then
                showBdayText = true;
                if not birthdayInfo.unknown then
                    formatBdayStamp = GRM.Time.FormatTimeStamp({ birthdayInfo.date[1] , birthdayInfo.date[2] }, false, true);
                else
                    formatBdayStamp = GRM.L("Unknown");
                end
            end
        end

        if isUnknown then
            if date == "join" then
                player.joinDateUnknown = true;
            elseif date == "promo" then
                player.promoteDateUnknown = true
                if player.name == GRM_G.currentName then
                    GRM_G.rankDateSet = true;
                end
            end
        end

        if not isAudit or (GRM_UI.GRM_Mouseover:IsVisible() and GRM_G.currentName == playerName) then
            if player.isOnline then
                if player.zone ~= nil then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone); -- Zone
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetText(
                        GRM.Time.GetTimePassedInZone(player.timeEnteredZone)); -- Time Passed
                end
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Show();
            end
        end
    end

    -- Determine which information needs to repopulate.
    if GRM_UI.GRM_Mouseover:IsVisible() and name == GRM_G.currentName then

        -- Join Date
        if joinDateText == buttonText or editJoinText == buttonText then
            if isUnknown and date == "join" then
                GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetText(GRM.L("Unknown"));
                GRM_UI.GRM_Mouseover.GRM_JoinDateText:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Hide();
            else
                if buttonText == editJoinText then
                    GRM_UI.GRM_Mouseover.GRM_JoinDateText:Show();
                else
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Show();
                end
            end

            -- Promo Date
        elseif buttonText == promoDateText then
            if not isUnknown then
                GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Show();
            elseif date == "promo" then
                GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Hide();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " ..
                                                                                        GRM.L("Unknown"));
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();
            end

            if name == GRM_G.currentName then
                if showJoinText then
                    GRM_UI.GRM_Mouseover.GRM_JoinDateText:Show();
                else
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Show();
                end
            end

            -- promo Date - Edit
        elseif buttonText == editDateText then
            if isUnknown and date == "promo" then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " ..
                                                                                        GRM.L("Unknown"));
            end
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();
        end
        -- Birthday Logic
        if GRM.S().showBDay and not GRM_UI.GRM_Mouseover.GRM_BirthdayText:IsVisible() and
            not GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:IsVisible() then
            if showBdayText then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Hide();
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetText(formatBdayStamp);
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Show();
                GRM_UI.GRM_Mouseover.GRM_BirthdayText:Hide();
            end
        end

        -- RANK PROMO DATE
        if not GRM_G.rankDateSet then --- Promotion has never been recorded!
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
            GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Show();
        else
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();
        end

        if not isAudit then
            GRM_UI.Unpause();
        end
    end

    if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
        if GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
            GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint("LEFT", GRM_UI.GRM_Mouseover
                .GRM_MemberDetailJoinDateButton, "RIGHT", 0, 0);
        elseif GRM_UI.GRM_Mouseover.GRM_JoinDateText:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
            GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint("LEFT", GRM_UI.GRM_Mouseover
                .GRM_JoinDateText, "RIGHT", 8, -0.5);
        end
        GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Show();
    else
        GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Hide();
    end

    -- Close the rest
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:Hide();
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:Hide();
end

-- Method:          GRM.SetDateButtonConfiguration ( int )
-- What it Does:    Formats the date submit configuration of buttons for clean submission
-- Purpose:         Only some date inputs need ALL, including the year. Birthday only needs day and month.
GRM.SetDateButtonConfiguration = function(formatNum)
    if formatNum == 1 then
        if GRM_G.formatNumber ~= formatNum then
            GRM_G.formatNumber = formatNum;

            -- Formatting
            GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetPoint("TOP",
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt, "BOTTOM", -86.5, -4);
            GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetPoint("TOP", GRM_UI.GRM_Mouseover
                .GRM_MonthDropDownMenuSelected, "BOTTOM", -22, -3);
            GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:SetPoint("LEFT", GRM_UI.GRM_Mouseover
                .GRM_SetUnknownButton, "RIGHT", 6, 0);

        end
        GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Show();
        GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:Show();
    elseif formatNum == 2 then
        if GRM_G.formatNumber ~= formatNum then
            GRM_G.formatNumber = formatNum;

            -- Formatting
            GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:SetPoint("TOP",
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt, "BOTTOM", -20, -4);
            GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetPoint("TOP", GRM_UI.GRM_Mouseover
                .GRM_MonthDropDownMenuSelected, "BOTTOM", -86.5, -3);
            GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:SetPoint("LEFT", GRM_UI.GRM_Mouseover
                .GRM_SetUnknownButton, "RIGHT", 3, 0);

        end
        GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Hide();
        GRM_UI.GRM_Mouseover.GRM_SetUnknownButton:Show();
    end

    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Show();
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Show();
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:Show();
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:Show();
end

-- Method:          GRM.GetRecordedDate ( string )
-- What it Does:    Returns either today's date, if no date of the corresponding date is stored, or, returns the date of the stored item
-- Purpose:         Continuity on editing dates and presenting dates.
GRM.GetRecordedDate = function(buttonName)
    local month, day, currentYear = select(2, GRM.Time.GetTodaysDate());
    local player = GRM.GetPlayer(GRM_G.currentName);

    if buttonName == "PromoRank" and not player.promoteDateUnknown and player.rankHist[1][7] then
        day = player.rankHist[1][2];
        month = player.rankHist[1][3];
        currentYear = player.rankHist[1][4];
    elseif buttonName == "JoinDate" and not player.joinDateUnknown and player.joinDateHist[1][1] > 0 then
        day = player.joinDateHist[1][1];
        month = player.joinDateHist[1][2];
        currentYear = player.joinDateHist[1][3];
    elseif buttonName == "Birthday" then
        local birthdayInfo = GRM.GetBirthday( player );
        if not birthdayInfo.unknown and birthdayInfo.date[1] ~= 0 then
            day = birthdayInfo.date[1];
            month = birthdayInfo.date[2];
        end
    end

    return day, month, currentYear;
end

-- Method:          GRM.SetDateSelectFrame( string , frameObject, string )
-- What it Does:    On Clicking the "Set Join Date" button this logic presents itself
-- Purpose:         Handle the event to modify when a player joined the guild. This is useful for anniversary date tracking.
--                  It is also necessary because upon starting the addon, it is unknown a person's true join date. This allows the gleader to set a general join date.
GRM.SetDateSelectFrame = function(buttonName)
    local day, month, currentYear = GRM.GetRecordedDate(buttonName);
    local months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October",
                    "November", "December"};
    local formatNumber = 0;

    -- Day
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected.GRM_DayText:SetText(day);
    GRM_G.dayIndex = day;

    -- Month
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected.GRM_MonthText:SetText(GRM.L(months[month]));
    GRM_G.monthIndex = month;

    -- Year
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected.GRM_YearText:SetText(currentYear);
    GRM_G.yearIndex = currentYear;

    -- Set function of the buttons to corresponding action.
    if buttonName == "PromoRank" then
        formatNumber = 1;

        GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetText(GRM.L("Set Promo Date"));
        GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" and not GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenu:IsVisible() then
                GRM.SetPromoDate();
            end
        end);
    elseif buttonName == "JoinDate" then
        formatNumber = 1;
        GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetText(GRM.L("Set Join Date"));
        GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                GRM.SetJoinDate();
            end
        end);
    elseif buttonName == "Birthday" then
        formatNumber = 2;
        GRM_UI.GRM_Mouseover.GRM_DateSubmitButtonTxt:SetText(GRM.L("Set Birthday"));
        GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                GRM.SetBirthdayFrameLogic();
            end
        end);
    end

    GRM.SetDateButtonConfiguration(formatNumber);
end

-- Method:          GRM.SetGroupInviteButton ( string )
-- What it Does:    Invites a selected guildie to your group
-- Purpose:         Continuity on previous Blizz default frames to these
GRM.SetGroupInviteButton = function(handle)

    local SetTooltip = function( show )
        if show then
            GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:SetScript ( "OnEnter" , function( self )
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine ( GRM.L ( "Unable to invite. You are grouped without privileges." ) );
                GameTooltip:Show();
            end);

        else
            GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:SetScript ( "OnEnter" , nil );
        end

        -- To keep from getting a perma tooltip, keep this not wrapped.
        GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);
    end

    local setButtonAction = function()
        -- Player is not in any group, thus inviting them will create new group.

        GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                C_PartyInfo.InviteUnit(handle);
            end
        end);

        SetTooltip ( false );
    end

    if GetNumGroupMembers() > 0 then -- If > 0 then player is in either a raid or a party. (1 will show if in an instance by oneself)
        local isGroupLeader = UnitIsGroupLeader("PLAYER"); -- Party or Group
        local isInRaidWithAssist = UnitIsGroupAssistant("PLAYER", LE_PARTY_CATEGORY_HOME); -- Player Has Assist in Raid group

        if isGroupLeader or isInRaidWithAssist then -- Player has the ability to invite to group
            setButtonAction();
        else -- Player is in a group but does not have invite privileges
            SetTooltip ( true );
        end
    else
        setButtonAction();
    end

    if GRM_UI.GRM_Mouseover.GRM_GroupInviteButton.GRM_GroupInviteButtonText:GetText() ~= nil then
        GRM_UI.ScaleFontStringToObjectSize(true, GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:GetWidth(),
            GRM_UI.GRM_Mouseover.GRM_GroupInviteButton.GRM_GroupInviteButtonText, 4);
    end
end

-- Method:              GRM.ClearPromoDateHistory ( string , bool )
-- What it Does:        Purges history of promotions as if they had just joined the guild.
-- Purpose:             Editing ability in case of user error.
GRM.ClearPromoDateHistory = function(name, isUnknown, member)
    local player = member or GRM.GetPlayer(name);

    if player then
        -- Ok, let's clear the history now!
        if not isUnknown then
            GRM_G.rankDateSet = false;
        end
        player.rankHist = nil;
        player.rankHist = {{player.rankName, 0, 0, 0, "0", 0, false, 1}};

        player.promoteDateUnknown = false;

        if name == GRM_G.currentName and GRM_UI.GRM_Mouseover:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
            if not isUnknown then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
                GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Show();
            end
        end
    end
end

-- Method:              GRM.ClearJoinDateHistory ( string )
-- What it Does:        Clears the player's history on when they joined/left/rejoined the guild to be as if they were  a new member
-- Purpose:             Micromanagement of toons metadata.
GRM.ClearJoinDateHistory = function(name, isUnknown, member)
    local player = member or GRM.GetPlayer(name);

    if player then
        -- Ok, let's clear the history now!
        player.joinDateHist = nil;
        player.joinDateHist = {{0, 0, 0, "0", 0, false, 1}};
        player.joinDateUnknown = false;
        if name == GRM_G.currentName and GRM_UI.GRM_Mouseover:IsVisible() then
            GRM_UI.GRM_Mouseover.GRM_JoinDateText:Hide();
            GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
            if not isUnknown then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Show();
            end

            if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
                if GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint("LEFT",
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton, "RIGHT", 0, 0);
                elseif GRM_UI.GRM_Mouseover.GRM_JoinDateText:IsVisible() then
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:ClearAllPoints();
                    GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:SetPoint("LEFT",
                        GRM_UI.GRM_Mouseover.GRM_JoinDateText, "RIGHT", 8, -0.5);
                end
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_SyncDateArrowButton:Hide();
            end
        end
    end
end

-- Method:              GRM.ResetPlayerMetaData ( string )
-- What it Does:        Purges all metadata from an alt up to that point and resets them as if they were just added to the guild roster
-- Purpose:             Metadata player management. QoL feature if ever needed.
GRM.ResetPlayerMetaData = function(playerName)
    local guildData = GRM.GetGuild();

    if guildData[playerName] then
        GRM.Report(GRM.L("{name}'s saved data has been wiped!", GRM.GetClassifiedName(playerName)));

        local member = {};
        local player = GRM.GetPlayer ( playerName );
        local name, sex = GRM.GetFullNameClubMember(player.GUID);

        if name and name ~= "" then
            print("Fixing Player")
            member.name = name;
            member.rankName = player.rankName;
            member.rankIndex = player.rankIndex; -- Subtract one due to legacy changes - it used to start at index 0 until 8.0
            member.level = player.level;
            member.note = player.note;

            member.officerNote = ""; -- Officer note will be "nil" if not an officer, so setting it to empty string
            if GRM.CanViewOfficerNote() and player.officerNote then
                member.officerNote = player.officerNote;
            end

            member.class = player.class
            member.lastOnline = player.lastOnline
            member.lastOnlineTime = player.lastOnlineTime
            member.zone = player.zone
            member.achievementPoints = player.achievementPoints
            member.rep = player.rep
            member.status = player.status
            member.isOnline = player.isOnline
            member.GUID = player.GUID
            member.race = player.race
            member.sex = sex
            member.rosterSelection = GRM.GetRosterSelectionID(member.name,member.GUID) -- This can be updated
            member.faction = player.faction

            if GRM_G.BuildVersion > GRM_ENUM.BUILD.BFA then
                member.MythicScore = player.MythicScore
            end

            if GRM.IsHardcoreActive() then
                member.HC = player.HC
            end
        end

        if GRM.PlayerHasAlts(player) then
            GRM.RemovePlayerFromAltGroup(playerName, 0, false, true, false, true);
        end

        GRM_GuildMemberHistory_Save[GRM_G.guildName][playerName] = nil; -- Remove the player!

        if member.name ~= nil then
            GRM.AddMemberRecord(member, false, nil) -- Re-Add the player!
        end

        GRM_UI.GRM_Mouseover:Hide();
        GRM.GuildRoster();
    end
end

-- Method:          GRM.FactionIcon ( ind );
-- What it Does:    Returns the Horde and Alliance faction colors
-- Purpose:         In 10.1 cross faction guilds became a thing, so this allows players to tag with a faction symbol.
GRM.FactionIcon = function(index)

    -- If server isn't returning the faction...
    if not index then
        if GRM_G.BuildVersion >= GRM_ENUM.BUILD.DF then -- DragonFlight allowed x-faction guilds in 10.1
            GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:Hide();
            GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:Hide();
            return;
        else
            index = GRM_G.faction;  -- Default to base faction for texture
        end
    end

    if GRM.S().showFaction and not (index == -1) then
        if index == 0 then
            GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:Show();
            GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:Hide();
        else
            GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:Show();
            GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:Hide();
        end
    else
        GRM_UI.GRM_Mouseover.GRM_HordeIconTexture:Hide();
        GRM_UI.GRM_Mouseover.GRM_AllianceIconTexture:Hide();
    end
end

-- Method:          GRM.DeathStatus ( playerObject , bool )
-- What it Does:    Controls the texture visibility in the mouseover window
-- Purpose:         Hardcore mode support indicates player is DEAD.
GRM.DeathStatus = function( player , isDead , timestamp )
    if isDead or ( GRM_G.HardcoreActive and player.HC.isDead ) then

        if isDead then
            GRM_UI.GRM_Mouseover.GRM_DeathTexture:SetTexture ( "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\deleted.png" );
            GRM_UI.GRM_Mouseover.GRM_ClearDeathButton:Hide();
        else
            GRM_UI.GRM_Mouseover.GRM_DeathTexture:SetTexture ( "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\dead.png" );
            GRM_UI.GRM_Mouseover.GRM_ClearDeathButton:Show();
        end
        GRM_UI.GRM_Mouseover.GRM_DeathTexture:Show();

        if not isDead or ( isDead and timestamp ) then
            local time = {};
            if player then
                time = { player.HC.timeOfDeath[1] , player.HC.timeOfDeath[2] , player.HC.timeOfDeath[3] };
            elseif timestamp and #timestamp == 8 then
                local day , month , year = GRM.Time.ParseStandardFormatDate ( timestamp );
                if day then
                    time = { day , month , year };
                end
            end

            if #time > 0 then

                GRM_UI.GRM_Mouseover.GRM_RIPtext:SetText(GRM.L("R.I.P. - {custom1}", nil, nil, nil,
                    GRM.Time.FormatTimeStamp({time[1], time[2], time[3]})));
                GRM_UI.GRM_Mouseover.GRM_RIPtext:SetTextColor(GRM.S().logColor[15][1], GRM.S().logColor[15][2],
                    GRM.S().logColor[15][3]);
                GRM_UI.GRM_Mouseover.GRM_RIPtext:Show();
            end
        else
            GRM_UI.GRM_Mouseover.GRM_RIPtext:Hide();
        end
    else
        GRM_UI.GRM_Mouseover.GRM_DeathTexture:Hide();
        GRM_UI.GRM_Mouseover.GRM_ClearDeathButton:Hide();
        GRM_UI.GRM_Mouseover.GRM_RIPtext:Hide();
    end
end

-- Method:          GRM.ClearAllFrames( boolean )
-- What it Does:    Ensures frames are properly reset upon frame reload...
-- Purpose:         Logic time-saver for minimal costs... why check status of them all when you can just disable and build anew on each reload?
GRM.ClearAllFrames = function(includingMeta)
    if includingMeta then
        if GRM_UI.GRM_Mouseover:IsVisible() then
            GRM_UI.GRM_Mouseover:Hide();
            GRM_G.currentName = "";
        end
    end
    GRM_UI.GRM_Mouseover.GRM_MonthDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_YearDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_DayDropDownMenuSelected:Hide();
    GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:Hide();
    GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:Hide();
    GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_ConfirmCustomNoteButton:Hide();
    GRM_UI.GRM_Mouseover.GRM_CancelCustomNoteButton:Hide();
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_OfficerNoteTooltip:Hide();
    GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Hide();
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide();
    GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:Hide();
end

-- Method:          GRM.ClearResetFramesOnTabChange()
-- What it Does:    Resets the frames when you are tabbing back and forth
-- Purpose:         Cleaner UI transition experience. Also, no need to keep player name up when the roster screen is gone.
GRM.ClearResetFramesOnTabChange = function()
    if GRM_UI.GRM_Mouseover:IsVisible() then
        GRM_UI.GRM_Mouseover:Hide() -- this will also trigger to clear all frames GRM.ClearAllFrames()
    end

    if GRM_UI.MemberDetailFrame and GRM_UI.MemberDetailFrame:IsVisible() then
        GRM_UI.MemberDetailFrame:Hide();
    end
end

-- Method:          GRM.SubFrameCheck()
-- What it Does:    Checks the core main frames, if they are open... and hides them
-- Purpose:         Questionable at this time... I might rewrite it with just 4 lines... It serves its purpose now
GRM.SubFrameCheck = function()
    -- wipe the frames...
    if GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:IsVisible() then
        GRM_UI.GRM_Mouseover.GRM_DateSubmitCancelButton:Click();
    end
    if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:IsVisible() then
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_AddAltEditFrame:Hide();
    end
    if GRM_UI.GRM_Mouseover.GRM_NoteCount:IsVisible() then
        GRM_UI.GRM_Mouseover.GRM_NoteCount:Hide();
    end
    if GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:IsVisible() then
        GRM_UI.GRM_Mouseover.GRM_MacroToolIgnoreListSettingsFrame:Hide();
    end
    GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:Hide();
    GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:Hide();
    GRM_UI.GRM_Mouseover.GRM_SyncJoinDateSideFrame:Hide();
end

-- Method:          GRM.SelectPlayerOnRoster ( string )
-- What it Does:    If the guild roster window is open, this will jump to the player anywhere in the roster, online or offline, and bring up their metadata window
-- Purpose:         Useful for when a player wants to click and alt rather than have to scan through the roster for them.
GRM.SelectPlayerOnRoster = function(playerName)
    if GRM_UI.MemberDetailFrame:IsVisible() then
        GRM_UI.MemberDetailFrame:Hide();
    end

    GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:ClearFocus();
    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
    GRM_G.currentName = playerName;
    GRM_G.pause = false;
    GRM.ClearAllFrames(false);
    GRM.PopulateMemberDetails(playerName);
    GRM_G.pause = true;
end

-- Method:          GRM.DateUntrustedTag ( bool )
-- What it Does:    Adds a tag in front of a date indicating it is not valid. Returns also the boolean of if it is trusted or not.
-- Purpose:         Notify you that you may need to manually update the date.
GRM.DateUntrustedTag = function(isVerified)
    local result = "";

    if not isVerified then
        result = "|cffff0000!!|r";
    end

    return result;
end

-- Method:          GRM.PromoRankTooltip ( frame )
-- What it Does:    Processes the logic for this specific tooltip in the player rank window and populates player rank promotion history
-- Purpose:         Keep code clean and management and compartmentalized on the mouseover tooltip window.
GRM.PromoRankTooltip = function(self)
    if GRM.GetMouseFocus(self) and self.GRM_MemberDetailRankToolTip:IsVisible() ~= true and not StaticPopup1:IsVisible() and
        not DropDownList1:IsVisible() and self.GRM_MemberDetailRankDateTxt:IsVisible() == true and
        not GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:IsVisible() and
        self.GRM_MemberDetailRankDateTxt:IsMouseOver(1, -1, -1, 1) == true then

        self.GRM_MemberDetailRankToolTip:SetOwner(self.GRM_MemberDetailRankDateTxt, "ANCHOR_BOTTOMRIGHT");
        self.GRM_MemberDetailRankToolTip:AddLine("|cFFFFFFFF" .. GRM.L("Rank History"));

        local player = GRM.GetPlayer(GRM_G.currentName);
        if player then
            -- Now, let's build the tooltip
            if self.GRM_MemberDetailRankDateTxt:GetText() == GRM.L("Promoted:") .. " " .. GRM.L("Unknown") then
                self.GRM_MemberDetailRankToolTip:AddDoubleLine("|cFFFF0000" .. GRM.L("Time at Rank:"), GRM.L("Unknown"));
                self.GRM_MemberDetailRankToolTip:AddDoubleLine(" ", " ");
            elseif player.rankHist[1][1] ~= 0 then

                local header = "";
                for i = 1, #player.rankHist do

                    -- If on the last set...
                    if i == 1 then

                        local timeAtRank = GRM.L("Unknown");
                        if #player.rankHist[1][5] > 1 then
                            timeAtRank = GRM.Time.GetTimePassedUsingTableOrString({player.rankHist[1][2],
                                                                              player.rankHist[1][3],
                                                                              player.rankHist[1][4]})[4];
                        elseif not player.promoteDateUnknown then
                            timeAtRank = GRM.L("Not Set");
                        end

                        self.GRM_MemberDetailRankToolTip:AddDoubleLine("|cFFFF0000" .. GRM.L("Time at Rank:"),
                            timeAtRank);
                        self.GRM_MemberDetailRankToolTip:AddDoubleLine(" ", " ");

                        if #player.rankHist[1][5] > 1 and not player.rankHist[1][7] then
                            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L(
                                "The {name} tag indicates a date must be verified to sync", "|CFFFF0000!!|r"));
                            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L(
                                "To confirm or edit the date, right click the date, edit, and submit"), 1, 0.84, 0, true);
                            self.GRM_MemberDetailRankToolTip:AddLine(" ");
                            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L(
                                "If the date is accurate, right click and select 'Confirm Date'"), 1, 0.84, 0, true);
                            self.GRM_MemberDetailRankToolTip:AddDoubleLine(" ", " ");
                        end

                    end

                    if player.rankHist[i][8] == 3 then --  "Left Guild"
                        header = GRM.L("Left Guild");
                    else
                        header = player.rankHist[i][1];
                    end

                    self.GRM_MemberDetailRankToolTip:AddDoubleLine(header .. ":",
                        GRM.DateUntrustedTag(player.rankHist[i][7]) ..
                            GRM.Time.FormatTimeStamp({player.rankHist[i][2], player.rankHist[i][3], player.rankHist[i][4]},
                                false, false), 0.38, 0.67, 1.0);
                end
            end
            self.GRM_MemberDetailRankToolTip:AddLine(" ");
            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L("Right-Click to Edit"));
        end

        self.GRM_MemberDetailRankToolTip:Show();
    elseif not GRM.GetMouseFocus(self) or
        (self.GRM_MemberDetailRankToolTip:IsVisible() == true and
            self.GRM_MemberDetailRankDateTxt:IsMouseOver(1, -1, -1, 1) ~= true) then
        self.GRM_MemberDetailRankToolTip:Hide();
        self.GRM_MemberDetailServerNameToolTip:Hide();
    end
end

-- Method:          GRM.JoinDateTooltip ( frame )
-- What it Does:    Builds the tooltip for when mousing over the guild join date history
-- Purpose:         Keep code clean and compartmentalized
GRM.JoinDateTooltip = function(self)
    if GRM.GetMouseFocus(self) and self.GRM_MemberDetailJoinDateToolTip:IsVisible() ~= true and
        not StaticPopup1:IsVisible() and self.GRM_JoinDateText:IsVisible() == true and
        not GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:IsVisible() and
        self.GRM_JoinDateText:IsMouseOver(1, -1, -1, 1) == true then

        self.GRM_MemberDetailJoinDateToolTip:SetOwner(self.GRM_JoinDateText, "ANCHOR_BOTTOMRIGHT");
        self.GRM_MemberDetailJoinDateToolTip:AddLine("|cFFFFFFFF" .. GRM.L("Membership History"));
        local joinedHeader;
        local msg = "";

        local player = GRM.GetPlayer(GRM_G.currentName);
        if player then
            -- Ok, let's build the tooltip now.
            if self.GRM_JoinDateText:GetText() == GRM.L("Unknown") then
                self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(GRM.L("Joined:"), GRM.L("Unknown"));
                self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(" ", " ");
            else
                for i = 1, #player.joinDateHist do -- Starting with most recent join which will be at end of array.
                    if i == 1 then
                        self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine("|cFFFF0000" .. GRM.L("Time as Member:"),
                            GRM.Time.GetTimePlayerHasBeenMember(player.name));

                        if #player.joinDateHist > 0 then
                            local totalJoins = math.floor(#player.joinDateHist / 2) + (#player.joinDateHist % 2);
                            local total = GRM.L("Times in Guild: {num}", nil, nil, totalJoins);

                            if GRM.IsGuildEE(GRM_G.guildName) then
                                if GRM.IsPlayerEE(GRM_G.currentName) then
                                    total = GRM_G.listOfPlayers[GRM_G.currentName] .. ": " .. totalJoins;
                                else
                                    total = GRM_G.listOfGuilds[GRM_G.guildName] .. ": " .. totalJoins;
                                end
                            end

                            self.GRM_MemberDetailJoinDateToolTip:AddLine(total, 1, 0, 0);
                        end

                        self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(" ", " ");

                        if string.find(self.GRM_JoinDateText:GetText(), "!!", 1, true) ~= nil then
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L(
                                "The {name} tag indicates a date must be verified to sync", "|CFFFF0000!!|r"));
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L(
                                "To confirm or edit the date, right click the date, edit, and submit"), 1, 0.84, 0, true);
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(" ");
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L(
                                "If the date is accurate, right click and select 'Confirm Date'"), 1, 0.84, 0, true);
                            self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(" ", " ");
                        end
                    end

                    if player.joinDateHist[i][7] == 2 then
                        joinedHeader = GRM.L("Left:");
                    elseif i == #player.joinDateHist then
                        joinedHeader = GRM.L("Joined:");
                    else
                        joinedHeader = GRM.L("Rejoined:");
                    end
                    if player.joinDateHist[i][1] == 0 then
                        msg = GRM.L("Unknown");
                    else
                        msg = GRM.DateUntrustedTag(player.joinDateHist[i][6]) ..
                                  GRM.Time.FormatTimeStamp(
                                {player.joinDateHist[i][1], player.joinDateHist[i][2], player.joinDateHist[i][3]}, false);
                    end
                    self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(joinedHeader, msg, 0.38, 0.67, 1.0);
                    -- If player once left, then this will add the line for it.
                end
            end
            self.GRM_MemberDetailJoinDateToolTip:AddLine(" ");
            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L("Right-Click to Edit"));
        end
        self.GRM_MemberDetailJoinDateToolTip:Show();
    elseif not GRM.GetMouseFocus(self) or (self.GRM_JoinDateText:IsMouseOver(1, -1, -1, 1) ~= true and
        (self.GRM_MemberDetailJoinDateToolTip:IsVisible() or self.GRM_MemberDetailServerNameToolTip:IsVisible())) then
        self.GRM_MemberDetailJoinDateToolTip:Hide();
        self.GRM_MemberDetailServerNameToolTip:Hide();
    end
end

-- Method:          GRM.PlayerNameTooltip( frame )
-- What it Does:    Builds tooltip when mousing over the player name
-- Purpose:         Compartmentalizing the code for cleanliness, like previous tooltip logic
GRM.PlayerNameTooltip = function(self)
    if not GRM_UI.GRM_Mouseover.GRM_altDropDownOptions:IsVisible() and not StaticPopup1:IsVisible() and
        self.GRM_MemberDetailNameText:IsMouseOver(1, -1, -1, 1) and GRM.GetMouseFocus(self) then
        -- Get Class Color
        local textR, textG, textB = self.GRM_MemberDetailNameText:GetTextColor();

        -- Build the tooltip
        self.GRM_MemberDetailServerNameToolTip:SetOwner(self.GRM_JoinDateText, "ANCHOR_CURSOR");
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM_G.currentName, textR, textG, textB);

        local player = GRM.GetPlayer(GRM_G.currentName);

        if player and player.race ~= "" and player.sex ~= 0 then
            self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{name} {name2}", C_CreatureInfo.GetRaceInfo(
                GRM_G.raceIDEnum[player.race]).raceName, GRM.GetSex(player.sex)), 1, 1, 1);
        end

        self.GRM_MemberDetailServerNameToolTip:AddLine(" ");
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{custom1} to Copy Name to Chat", nil, nil, nil,
            "|CFFE6CC7F" .. GRM.L("Shift-Click") .. "|r"));
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{custom1} to Search the Log for Player", nil, nil, nil,
             "|CFFE6CC7F" .. GRM.L("Ctrl-Shift-Click") .. "|r"));
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{custom1} for Additional Options", nil, nil, nil,
            "|CFFE6CC7F" .. GRM.L("Right-Click") .. "|r"));
        self.GRM_MemberDetailServerNameToolTip:Show();
    else
        self.GRM_MemberDetailServerNameToolTip:Hide();
    end
end

-- Method:          GRM.AltNameTooltip ( frame )
-- What it Does:    Populates the alt info tooltip
-- Purpose:         Useful info for player, keeps code clean.
GRM.AltNameTooltip = function(self)

    local player = GRM.GetPlayer(GRM_G.currentName);

    if (GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame
        .allFrameButtons ~= nil and
        #GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame
            .allFrameButtons > 0 and
        GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame
            .allFrameButtons[1][1]:IsVisible()) and not StaticPopup1:IsVisible() and
        not self.GRM_altDropDownOptions:IsVisible() and
        not (self.GRM_YearDropDownMenu:IsVisible() and self.GRM_YearDropDownMenu:IsMouseOver()) and
        not (self.GRM_DayDropDownMenu:IsVisible() and self.GRM_DayDropDownMenu:IsMouseOver()) then

        if not self.GRM_ExtraAltDetailsArrowButton:IsMouseOver(1, -1, -1, 1) then

            GRM_G.tempAltName = "";

            if player then

                local listOfAlts = GRM.GetListOfAlts(player);
                local color = {};
                local AltTT = self.GRM_MemberDetailServerNameToolTip;
                local isOver = false;

                if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame.GRM_CoreAltScrollChildFrame
                    .allFrameButtons ~= nil then
                    for i = 1, #GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame
                        .GRM_CoreAltScrollChildFrame.allFrameButtons do
                        if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame
                            .GRM_CoreAltScrollChildFrame.allFrameButtons[i][1]:IsVisible() and
                            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame
                                .GRM_CoreAltScrollChildFrame.allFrameButtons[i][1]:IsMouseOver(1, -1, -1, 1) and
                            GRM.GetMouseFocus(
                                GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame
                                    .GRM_CoreAltScrollChildFrame.allFrameButtons[i][1]) and listOfAlts[i] and
                            listOfAlts[i][1] then

                            GRM_G.tempAltName = listOfAlts[i][1];
                            color = GRM.GetClassColorRGB(listOfAlts[i][2], false)
                            AltTT:SetOwner(GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrame
                                               .GRM_CoreAltScrollChildFrame.allFrameButtons[i][1], "ANCHOR_CURSOR");
                            AltTT:AddLine(listOfAlts[i][1], color[1], color[2], color[3]);
                            AltTT:AddLine(" ");
                            AltTT:AddLine(GRM.L("{custom1} to Copy Name to Chat", nil, nil, nil,
                                "|CFFE6CC7F" .. GRM.L("Shift-Click") .. "|r"));
                            AltTT:AddLine(GRM.L("{custom1} for Additional Options", nil, nil, nil,
                                "|CFFE6CC7F" .. GRM.L("Right-Click") .. "|r"));
                            AltTT:AddLine(GRM.L("{custom1} to open Player Window", nil, nil, nil,
                                "|CFFE6CC7F" .. GRM.L("Ctrl-Click") .. "|r"))
                            AltTT:AddLine(GRM.L("{custom1} to Search the Log for Player", nil, nil, nil,
                                "|CFFE6CC7F" .. GRM.L("Ctrl-Shift-Click") .. "|r"));
                            isOver = true;
                            break
                        end
                    end
                end

                if isOver and not self.GRM_altDropDownOptions:IsVisible() then
                    AltTT:Show();
                elseif self.GRM_altDropDownOptions:IsVisible() and
                    not self.GRM_MemberDetailNameText:IsMouseOver(1, -1, -1, 1) then
                    AltTT:Hide();
                end
            end
        end

        local player = GRM.GetPlayer(GRM_G.currentName);
        if GRM_UI.GRM_Mouseover.GRM_CoreAltFrame:IsMouseOver(5, 5, 5, 35) and player and
            GRM.GetNumAlts(player.altGroup) >= 12 then
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Show();
        else
            GRM_UI.GRM_Mouseover.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Hide();
        end

        if self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:IsMouseOver(10, 1, 1, 30) and
            select(2, self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:GetMinMaxValues()) > 0 then
            self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Show();
        else
            self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide();
        end

    else
        if not self.GRM_MemberDetailNameText:IsMouseOver(1, -1, -1, 1) then
            self.GRM_MemberDetailServerNameToolTip:Hide();
        end
    end

    if GRM.PlayerHasAlts(player) then

        if not self.GRM_ExtraAltDetailsArrowButton:IsVisible() then
            self.GRM_ExtraAltDetailsArrowButton:Show();
        end

    else
        if self.GRM_ExtraAltDetailsArrowButton:IsVisible() then
            self.GRM_ExtraAltDetailsArrowButton:Hide();
        end
    end
end

-- Method:          GRM.CustomNoteSlider ( parentFrameOfSlider )
-- What it Does:    Controls logic of mouseover of the custom note frame within the OnUpdate of the mouseover
-- Purpose:         Show the scrollSlider, but only if necessary
GRM.CustomNoteSlider = function( self )
    if self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:IsMouseOver(10, 1, 1, 30) and
    select(2, self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:GetMinMaxValues()) > 0 then
        self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Show();
    else
        self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide();
    end
end

-- Method:          GRM.PlayerStatusNotificationTooltip ( Frame )
-- What it Does:    Builds notification tooltip to let player know they can view player status updates
-- Purpose:         Useful info for the player
GRM.PlayerStatusNotificationTooltip = function(self)
    if GRM.GetMouseFocus(self) and self.GRM_MemberDetailPlayerStatus:IsMouseOver(1, -1, -1, 1) and
        not GRM_UI.GRM_Mouseover.GRM_MouseOverStatusFrame:IsVisible() then
        self.GRM_MemberDetailNotifyStatusChangeTooltip:SetOwner(self.GRM_MemberDetailPlayerStatus, "ANCHOR_CURSOR");
        self.GRM_MemberDetailNotifyStatusChangeTooltip:AddLine("|cFFFFFFFF" ..
                                                                   GRM.L(
                "|CFFE6CC7FRight-Click|r to Set Notification of Status Change"));

        self.GRM_MemberDetailNotifyStatusChangeTooltip:Show();
    else
        self.GRM_MemberDetailNotifyStatusChangeTooltip:Hide();
    end
end

-- Method:          GRM.EditBdayTooltip ( self )
-- What it Does:    Provides a tooltip on the text so player knows they can edit it.
-- Purpose:         Clean code!
GRM.EditBdayTooltip = function(self)
    if not self.GRM_BirthdayTooltip:IsVisible() and GRM.GetMouseFocus(self) and self.GRM_BirthdayText:IsVisible() and
        self.GRM_BirthdayText:IsMouseOver(1, -1, -1, 1) and
        not GRM_UI.GRM_Mouseover.GRM_MouseOverDateStatusFrame:IsVisible() then
        self.GRM_BirthdayTooltip:SetOwner(self.GRM_BirthdayText, "ANCHOR_CURSOR");
        self.GRM_BirthdayTooltip:AddLine(GRM.L("Right-Click to Edit"));

        self.GRM_BirthdayTooltip:Show();
    elseif not GRM.GetMouseFocus(self) or
        (self.GRM_BirthdayTooltip:IsVisible() and not self.GRM_BirthdayText:IsMouseOver(1, -1, -1, 1)) then
        self.GRM_BirthdayTooltip:Hide();
    end
end

-- Method:          GRM.MemberDetailToolTips ( self , float )
-- What it Does:    Populates the tooltips on the "OnUpdate" check for the core Member Detail frame
-- Purpose:         UI Feature
-- Note:            self = GRM_UI.GRM_Mouseover
GRM.MemberDetailToolTips = function(self, elapsed)
    GRM_UI.GRM_Mouseover.timer = GRM_UI.GRM_Mouseover.timer + elapsed;
    if GRM_UI.GRM_Mouseover.timer >= 0.075 then
        if IsInGuild() then

            -- PROMO DATE TEXT
            -- Only populate and show tooltip if mouse is over text frame and it is not already visible.
            GRM.PromoRankTooltip(self);

            -- JOIN DATE TEXT
            GRM.JoinDateTooltip(self);

            -- PLAYER NAME TEXT
            GRM.PlayerNameTooltip(self);

            -- ALT NAMES
            GRM.AltNameTooltip(self);

            -- Custom Note Slider
            GRM.CustomNoteSlider ( self )

            -- PLAYER STATUS
            GRM.PlayerStatusNotificationTooltip(self);

            -- EDIT TOOLTIPS
            GRM.EditBdayTooltip(self);

            if GRM_G.pause then
                GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_WindowIsLockedText:Hide();
            end
        end
        GRM_UI.GRM_Mouseover.timer = 0;
    end
end

-- Method:          GRM.GRM.PopulateMemberDetails ( string , memberTable , bool )
-- What it Does:    Builds the details for the core MemberInfoFrame
-- Purpose:         Iterate on each mouseover... Furthermore, this is being kept in "Local" for even the most infinitesimal cost-saving on resources
--                  by not indexing it in a table. Buried in it will be mostly non-compartmentalized logic, few function calls.
GRM.PopulateMemberDetails = function( handle, memberInfo , doubleCopy )
    if handle ~= "" and handle ~= nil and GRM_G.guildName ~= "" and IsInGuild() then -- If the handle is failed to be returned, it is returned as an empty string. Just logic to not populate if on failure.
        GRM_G.rankDateSet = false; -- resetting tracker

        local player = GRM.GetPlayer(handle);
        if player then

            local zone, online = "", false;
            if memberInfo and memberInfo.guid ~= nil then
                zone = memberInfo.zone;
                if GRM.IsPresenceOnline(memberInfo.presence) then
                    online = true;
                else
                    online = false;
                end
            else
                local member = GRM.GetClubMemberInfo(handle, GRM_G.gClubID);
                if member then
                    zone = member.zone;
                    online = GRM.IsPresenceOnline(member.presence);
                end
            end

            if not doubleCopy then
                if zone ~= nil and zone ~= "" then
                    player.isOnline = online;
                    if player.zone ~= zone then
                        player.timeEnteredZone = time(); -- Resets the time
                    end
                    player.zone = zone;
                end
            end

            --- CLASS
            local class;
            if memberInfo then
                class = C_CreatureInfo.GetClassInfo(memberInfo.classID).classFile;
            else
                class = player.class;
            end

            local classColors = GRM.GetClassColorRGB( class );
            GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:SetTextColor(classColors[1], classColors[2],
                classColors[3], 1.0);

            -- FACTION ICON
            GRM.FactionIcon( player.faction );

            local note;
            if memberInfo then
                note = memberInfo.memberNote;
            else
                note = player.note;
            end

            -- HARDCORE MODE
            if not doubleCopy then
                GRM.DeathStatus(player);
            else
                if not note then
                    note = "";
                end
                GRM.DeathStatus ( nil , true , string.match ( note , "%[D%]-(%d+)" ) );
            end

            -- PLAYER NAME
            -- Let's scale the name too!
            GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:SetText(GRM.SlimName(handle));
            local nameHeight = 16;
            GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:SetFont(GRM_G.FontChoice,
                GRM_G.FontModifier + nameHeight); -- Reset size back to 16 just in case previous fontstring was altered
            while (GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:GetWidth() > 120) do
                nameHeight = nameHeight - 0.1;
                GRM_UI.GRM_Mouseover.GRM_MemberDetailNameText:SetFont(GRM_G.FontChoice,
                    GRM_G.FontModifier + nameHeight);
            end

            -- IS MAIN
            if not doubleCopy and GRM.IsMain ( player.name ) then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText:Hide();
            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailMainText:Hide();

                if not doubleCopy and GRM.PlayerIsAnAlt(player) then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText:Show();
                else
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailAltText:Hide();
                end
            end

            --- LEVEL
            local levelAndMythicText = "";
            local level;
            if memberInfo then
                level = memberInfo.level;
            else
                level = player.level;
            end

            if GRM.S().showLevel then

                if not GRM.S().showLevelMaxOnly or (GRM.S().showLevelMaxOnly and level < GRM_G.LvlCap) then
                    if GRML.Languages[GRM.S().selectedLang] == "Russian" or GRML.Languages[GRM.S().selectedLang] ==
                        "Korean" then
                        levelAndMythicText = tostring(level) .. GRM.L("Level: ");
                    else
                        levelAndMythicText = GRM.L("Level: ") .. level;
                    end
                end
            end

            -- MYTHINC+ SCORE
            if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA and GRM.S().showMythicRating and level == GRM_G.LvlCap then

                local mythicScore;
                if memberInfo and memberInfo.overallDungeonScore then
                    mythicScore = memberInfo.overallDungeonScore;
                elseif player.MythicScore then
                    mythicScore = player.MythicScore;
                else
                    mythicScore = 0;
                end

                if levelAndMythicText ~= "" then
                    levelAndMythicText = levelAndMythicText .. " | " .. GRM.L("M+ Rating:") .. "  " ..
                                             GRM.GetMythicRatingToMatchRaiderIO(mythicScore) ..
                                             mythicScore .. "|r";
                else
                    levelAndMythicText = GRM.L("M+ Rating:") .. "  " ..
                                             GRM.GetMythicRatingToMatchRaiderIO(mythicScore) ..
                                             mythicScore .. "|r";
                end
            end

            GRM_UI.GRM_Mouseover.GRM_MemberDetailLevel:SetText(levelAndMythicText);

            -- Rank Text Info...
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt:SetText("\"" .. player.rankName .. "\"");
            GRM_UI.GRM_Mouseover.GRM_MemberDetailRankTxt:Show();

            -- ZONE INFORMATION
            if not GRM_UI.GRM_Mouseover.GRM_DateSubmitButton:IsVisible() then
                if not doubleCopy and player.isOnline then
                    if player.zone ~= nil then
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone); -- Zone
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:SetText(
                            GRM.Time.GetTimePassedInZone(player.timeEnteredZone)); -- Time Passed
                    end
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Show();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Show();
                else
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoText:Hide();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoZoneText:Hide();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText1:Hide();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailMetaZoneInfoTimeText2:Hide();
                end

                -- RANK PROMO DATE
                if not doubleCopy and player.promoteDateUnknown then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " ..
                                                                                            GRM.L("Unknown"));
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();
                    GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Hide();
                    GRM_G.rankDateSet = true;
                else
                    if doubleCopy or #player.rankHist[1][5] == 1 then --- Promotion has never been recorded!
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Hide();
                        GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Show();
                    else
                        GRM_UI.GRM_Mouseover.GRM_SetPromoDateButton:Hide();
                        GRM_G.rankDateSet = true;
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:SetText(GRM.DateUntrustedTag(
                            player.rankHist[1][7]) .. GRM.L("Promoted:") .. " " .. GRM.Time.FormatTimeStamp(
                                {player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]}, false, false));
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailRankDateTxt:Show();
                    end
                end

                -- JOIN DATE
                if not doubleCopy and player.joinDateUnknown then
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Hide();
                    GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetText(GRM.L("Unknown"));
                    GRM_UI.GRM_Mouseover.GRM_JoinDateText:Show();
                else
                    if doubleCopy or player.joinDateHist[1][1] == 0 then
                        GRM_UI.GRM_Mouseover.GRM_JoinDateText:Hide();
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Show();
                    else
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailJoinDateButton:Hide();

                        GRM_UI.GRM_Mouseover.GRM_JoinDateText:SetText(GRM.DateUntrustedTag(
                            player.joinDateHist[1][6]) .. GRM.Time.FormatTimeStamp( {player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]}, false) );
                        GRM_UI.GRM_Mouseover.GRM_JoinDateText:Show();
                    end
                end

                -- Birthday
                if not doubleCopy and GRM.S().showBDay then
                    -- Title should always be here
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText:Show();

                    local birthdayInfo = GRM.GetBirthday( player );
                    if birthdayInfo.unknown then
                        GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Hide();
                        GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetText(GRM.L("Unknown"));
                        GRM_UI.GRM_Mouseover.GRM_BirthdayText:Show();
                    else
                        -- Checking button vs text
                        if birthdayInfo.date[1] ~= 0 then
                            GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Hide();
                            GRM_UI.GRM_Mouseover.GRM_BirthdayText:SetText(GRM.Time.FormatTimeStamp(
                                { birthdayInfo.date[1] , birthdayInfo.date[2] }, false, true));
                            GRM_UI.GRM_Mouseover.GRM_BirthdayText:Show();
                        else
                            GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Show();
                            GRM_UI.GRM_Mouseover.GRM_BirthdayText:Hide();
                        end
                    end
                else
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayButton:Hide();
                    GRM_UI.GRM_Mouseover.GRM_BirthdayText:Hide();
                    GRM_UI.GRM_Mouseover.GRM_MemberDetailBirthdayTitleText:Hide();
                end
            end

            -- PLAYER NOTE AND OFFICER NOTE EDIT BOXES
            if not GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:HasFocus() and
                not GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:HasFocus() and
                not GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
                
                local finalNote = "";
                local finalONote = "";
                local canModifyPublicNote = (not GRM_G.BuildHasRestrictions)
                if canModifyPublicNote then
                    finalNote = GRM.L("Click here to set a Public Note");
                    finalONote = GRM.L("Click here to set an Officer's Note");
                else
                    finalNote = GRM.L("Public Note not set");
                    finalONote = GRM.L("Officer Note not Set");
                end

                GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:Hide();
                GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:Hide();

                -- Set Public Note if is One
                if note and note ~= "" then
                    finalNote = note;
                end

                GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetText(finalNote);

                if canModifyPublicNote then
                    if ( GRM.CanEditPublicNote() or handle == GRM_G.addonUser ) then
                        if finalNote ~= GRM.L("Click here to set a Public Note") then
                            GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetText(finalNote);
                        else
                            GRM_UI.GRM_Mouseover.GRM_PlayerNoteEditBox:SetText("");
                        end
                    elseif finalNote == GRM.L("Click here to set a Public Note") then
                        GRM_UI.GRM_Mouseover.GRM_noteFontString1:SetText(GRM.L(
                            "Unable to Edit Public Note at Rank"));
                    end
                end

                local officerNote;
                if memberInfo then
                    officerNote = memberInfo.officerNote;

                    -- Accomodating for an error in Classic era build where officer note not showing.
                    if not officerNote and GRM_G.BuildVersion < GRM_ENUM.BUILD.CATA then
                        officerNote = select ( 8 , GRM.GetGuildRosterInfo_ClassicMethod(player.name , false , player.GUID ) );
                    end
                else
                    officerNote = player.officerNote;
                end

                -- Set O Note
                if GRM.CanViewOfficerNote() == true then

                    if officerNote and officerNote ~= "" then
                        finalONote = officerNote;
                    end

                    if canModifyPublicNote and finalONote == GRM.L("Click here to set an Officer's Note") and not GRM.CanEditOfficerNote() then
                        finalONote = GRM.L("Unable to Edit Officer Note at Rank");
                    end

                    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetText(finalONote);

                    if canModifyPublicNote and finalONote ~= GRM.L("Click here to set an Officer's Note") then
                        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetText(finalONote);

                        -- Accomodate the mouseover error in classic not showing officer note
                        if GRM_UI.MemberDetailFrame:IsVisible() and finalONote ~= "" then
                            GRM_UI.MemberDetailFrame.OfficerNoteBackground.OfficerNoteText:SetText( finalONote );
                        end
                    else
                        GRM_UI.GRM_Mouseover.GRM_PlayerOfficerNoteEditBox:SetText("");
                    end
                else
                    GRM_UI.GRM_Mouseover.GRM_noteFontString2:SetText(GRM.L(
                        "Unable to View Officer Note at Rank"));
                end

                -- Custom Note CheckBox
                if not doubleCopy and player.customNote[1] then
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetChecked(
                        true);
                else
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetChecked(
                        false);
                end
                if GRM.S().syncEnabled and GRM.S().syncCustomNote then
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:Enable();
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox
                        .GRM_CustomNoteMetaCheckBoxText:SetTextColor(1.0, 0.82, 0.0, 1.0);
                else
                    -- sync is disabled, so disable the button...
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox
                        .GRM_CustomNoteMetaCheckBoxText:SetTextColor(0.5, 0.5, 0.5, 1);
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:Disable();
                end
                -- Set Custom Note details
                local cNote = "";
                if not doubleCopy then
                    cNote = player.customNote[4];
                end
                GRM.BuildCustomNoteScrollFrame( cNote );
                if GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
                    GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
                end

                GRM_UI.GRM_Mouseover.GRM_noteFontString2:Show();
                GRM_UI.GRM_Mouseover.GRM_noteFontString1:Show();

            end

            -- Last Online
            if not doubleCopy and player.isOnline then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt:SetText(GRM.L("Online"));
            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailLastOnlineTxt:SetText(GRM.Time.HoursReport(player.lastOnlineTime));
            end

            -- Reputation
            if not doubleCopy and GRM.S().viewGuildRep and GRM_G.BuildVersion >= GRM_ENUM.BUILD.CATA then -- Cataclysm feature added
                GRM_UI.GRM_Mouseover.GRM_ReputationLevelText:SetText(GRM.GetReputationTextLevel(
                    player.guildRep, true));
                GRM_UI.GRM_Mouseover.GRM_ReputationLevelText:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_ReputationLevelText:Hide();
            end

            -- Group Invite Button -- Setting script here
            if not doubleCopy and player.isOnline and handle ~= GRM_G.addonUser and
                not GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
                GRM.SetGroupInviteButton(handle);
                GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:Show();
                GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:ClearAllPoints();
                GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:SetPoint("LEFT",
                    GRM_UI.GRM_Mouseover.GRM_GroupInviteButton, "RIGHT", 5, 0);
                GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:Show();
            elseif not doubleCopy and ( not player.isOnline or handle == GRM_G.addonUser ) then
                GRM_UI.GRM_Mouseover.GRM_GroupInviteButton:Hide();

                if handle ~= GRM_G.addonUser and
                    not GRM_UI.GRM_Mouseover.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
                    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:ClearAllPoints();
                    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:SetPoint("BOTTOMLEFT",
                        GRM_UI.GRM_Mouseover, "BOTTOMLEFT", 15, 13);
                    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:Show();
                else
                    GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:Hide();
                end
            elseif doubleCopy then
                GRM_UI.GRM_Mouseover.GRM_SafeFromRulesButton:Hide();
            end

            -- IF PLAYER WAS PREVIOUSLY BANNED AND REJOINED
            -- Player was previous banned and rejoined logic! This will unban the player.
            local isGuildieBanned = false;
            if not doubleCopy then
                isGuildieBanned = player.bannedInfo[1];
            end

            if isGuildieBanned and handle ~= GRM_G.addonUser then
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton:SetScript("OnClick",
                    function(_, button)
                        if button == "LeftButton" then
                            local epochTimeStamp = time();

                            GRM.RemoveBan(handle, true, GRM_G.addonUser, epochTimeStamp);

                            -- Send the unban out for sync'd players
                            GRM.RemoveBanSendSyncMessage(player.name, epochTimeStamp);

                            -- Message
                            local classColorHex = GRM.GetClassColorRGB(player.class, true)
                            GRM.Report(GRM.L("{name} has been Removed from the Ban List.",
                                classColorHex .. player.name .. "|r"));
                        end
                    end);

                GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:Show();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton:Show();
            else
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedText1:Hide();
                GRM_UI.GRM_Mouseover.GRM_MemberDetailBannedIgnoreButton:Hide();
            end

            -- ALTS
            if not doubleCopy then
                GRM.PopulateAltFrames(handle);
            end

            -- Font note handling
            GRM_UI.ReconfigureNoteFonts();

        end
    end
end