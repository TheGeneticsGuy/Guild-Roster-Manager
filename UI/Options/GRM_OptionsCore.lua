
local OptionsCore = {};
GRM_UI.OptionsCore = OptionsCore;

-- Method:          OptionsCore.ConfigureSelectAllCheckButtons()
-- What it Does:    Checks if they are all true, and if so, auto checks the selectAll button
-- Purpose:         UX
OptionsCore.ConfigureSelectAllCheckButtons = function()
    local count = 0;
    local count2 = 0;

    for x in pairs ( GRM.S().toLog ) do
        if GRM.S().toLog[x] then
            count = count + 1;
        end
    end

    for x in pairs ( GRM.S().toChat ) do
        if GRM.S().toChat[x] then
            count2 = count2 + 1;
        end
    end

    GRM_UI.GRM_RosterChangeLogFrame.GRM_RosterCheckAllLogButton:SetChecked ( count == GRM.GetNumKeyedEntries ( GRM.S().toLog ) );
    GRM_UI.GRM_RosterCheckBoxSideFrame.GRM_RosterCheckAllChatButton:SetChecked ( count2 == GRM.GetNumKeyedEntries ( GRM.S().toChat ) );
end

-- Method:          OptionsCore.BuildLogFilterSideFrame()
-- What it Does:    Builds the side roster checkboxes properly
-- Purpose:         Front end UI log filtering.
OptionsCore.BuildLogFilterSideFrame = function()
    local toLog = GRM.S().toLog
    local toChat = GRM.S().toChat
    local LogFrame = GRM_UI.GRM_RosterChangeLogFrame
    local ChatSideFrame = GRM_UI.GRM_RosterCheckBoxSideFrame

    -- Direct Assignments for Log (Left Side)
    LogFrame.GRM_RosterJoinedCheckButton:SetChecked(toLog.joined)
    LogFrame.GRM_RosterLeveledChangeCheckButton:SetChecked(toLog.leveled)
    LogFrame.GRM_RosterInactiveReturnCheckButton:SetChecked(toLog.inactiveReturn)
    LogFrame.GRM_RosterPromotionChangeCheckButton:SetChecked(toLog.promotion)
    LogFrame.GRM_RosterDemotionChangeCheckButton:SetChecked(toLog.demotion)
    LogFrame.GRM_RosterNoteChangeCheckButton:SetChecked(toLog.note)
    LogFrame.GRM_RosterOfficerNoteChangeCheckButton:SetChecked(toLog.officerNote)
    LogFrame.GRM_RosterCustomNoteChangeCheckButton:SetChecked(toLog.customNote)
    LogFrame.GRM_RosterNameChangeCheckButton:SetChecked(toLog.nameChange)
    LogFrame.GRM_RosterRankRenameCheckButton:SetChecked(toLog.rankRename)
    LogFrame.GRM_RosterEventCheckButton:SetChecked(toLog.eventAnnounce)
    LogFrame.GRM_RosterLeftGuildCheckButton:SetChecked(toLog.left)
    LogFrame.GRM_RosterRecommendationsButton:SetChecked(toLog.recommend)
    LogFrame.GRM_RosterBannedPlayersButton:SetChecked(toLog.banned)

    -- Direct Assignments for Chat (Right Side)
    ChatSideFrame.GRM_RosterJoinedChatCheckButton:SetChecked(toChat.joined)
    ChatSideFrame.GRM_RosterLeveledChatCheckButton:SetChecked(toChat.leveled)
    ChatSideFrame.GRM_RosterInactiveReturnChatCheckButton:SetChecked(toChat.inactiveReturn)
    ChatSideFrame.GRM_RosterPromotionChatCheckButton:SetChecked(toChat.promotion)
    ChatSideFrame.GRM_RosterDemotionChatCheckButton:SetChecked(toChat.demotion)
    ChatSideFrame.GRM_RosterNoteChatCheckButton:SetChecked(toChat.note)
    ChatSideFrame.GRM_RosterOfficerNoteChatCheckButton:SetChecked(toChat.officerNote)
    ChatSideFrame.GRM_RosterCustomNoteChatCheckButton:SetChecked(toChat.customNote)
    ChatSideFrame.GRM_RosterNameChangeChatCheckButton:SetChecked(toChat.nameChange)
    ChatSideFrame.GRM_RosterRankRenameChatCheckButton:SetChecked(toChat.rankRename)
    ChatSideFrame.GRM_RosterEventChatCheckButton:SetChecked(toChat.eventAnnounce)
    ChatSideFrame.GRM_RosterLeftGuildChatCheckButton:SetChecked(toChat.left)
    ChatSideFrame.GRM_RosterRecommendationsChatButton:SetChecked(toChat.recommend)
    ChatSideFrame.GRM_RosterBannedPlayersButtonChatButton:SetChecked(toChat.banned)

    if GRM_G.HardcoreActive then
        ChatSideFrame.GRM_HardcoreToLogCheckbox:SetChecked(toLog.death)
        ChatSideFrame.GRM_HardcoreToChatCheckbox:SetChecked(toChat.death)
    end

    OptionsCore.ConfigureSelectAllCheckButtons()
end

-- Method:          OptionsCore.RefreshOptionsUI()
-- What it Does:    Rebuilds the frames that hold the guild event log...
-- Purpose:         Easy access. Useful to rebuild frames on the fly at times, particularly if a player rank changes, just in case he receives/loses various permissions.
OptionsCore.RefreshOptionsUI = function()
    local S = GRM.S()
    local OptionsFrame  = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
    local GenOpts       = OptionsFrame.GRM_GeneralOptionsFrame
    local OfficerOpts   = OptionsFrame.GRM_OfficerOptionsFrame
    local UXOpts        = OptionsFrame.GRM_UXOptionsFrame
    local GRM_ScanningOptionsFrame      = OptionsFrame.GRM_ScanningOptionsFrame
    local SyncOpts      = OptionsFrame.GRM_SyncOptionsFrame
    local NamesOpts     = OptionsFrame.GRM_NamesOptionsFrame
    local LogOpts       = GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame

    -- Helper function to handle Enable/Disable states and text coloring
    local function SetUIState(element, textElement, isEnabled, activeR, activeG, activeB)
        if isEnabled then
            element:Enable()
            if textElement then
                textElement:SetTextColor(activeR or 1.0, activeG or 0.82, activeB or 0.0, 1.0)
            end
        else
            element:Disable()
            if textElement then
                textElement:SetTextColor(0.5, 0.5, 0.5, 1.0)
            end
        end
    end
    
    -- General Options
    GenOpts.GRM_RosterLoadOnLogonCheckButton:SetChecked(S.viewOnLoad)
    GenOpts.GRM_RosterLoadOnLogonChangesCheckButton:SetChecked(S.onlyViewIfChanges)
    GenOpts.GRM_SyncCompatibilityMessageButton:SetChecked(S.syncCompatibilityMsg)
    GenOpts.GRM_SyncAllSettingsCheckButton:SetChecked(S.syncSettings)
    GenOpts.GRM_ShowMinimapButton:SetChecked(S.minimapEnabled)
    GenOpts.GRM_AchievementAnnounceButton:SetChecked(S.achievements)
    GenOpts.GRM_DefaultTabSelectionButton:SetChecked(S.defaultTabSelection[1])

    -- Officer Options
    OfficerOpts.GRM_RosterAddTimestampCheckButton:SetChecked(S.addTimestampToNote)
    OfficerOpts.GRM_RosterReportAddEventsToCalendarButton:SetChecked(S.allowEventsToCalendar)
    OfficerOpts.GRM_AddJoinedTagButton:SetChecked(S.includeTag)
    OfficerOpts.GRM_NoteTagFeatureCheckButton:SetChecked(S.noteSetEnabled)

    -- UX Options
    UXOpts.GRM_ColorizeSystemMessagesCheckButton:SetChecked(S.colorizeNames)
    UXOpts.GRM_ShowLevelCheckButton:SetChecked(S.showLevel)
    UXOpts.GRM_ShowLevelCheckButton2:SetChecked(S.showLevelMaxOnly)
    UXOpts.GRM_ShowFactionCheckButton:SetChecked(S.showFaction)
    UXOpts.GRM_FadeCheckButton:SetChecked(S.useFade)
    UXOpts.GRM_ReputationToggleButton:SetChecked(S.viewGuildRep)
    UXOpts.GRM_NoteBordersButton:SetChecked(S.showBorders)
    UXOpts.GRM_BirthdayToggleButton:SetChecked(S.showBDay)
    UXOpts.GRM_ColorizePlayerNamesButton:SetChecked(S.colorizeClassicRosterNames)
    UXOpts.GRM_AutoHideFramesInCombatCheckButton:SetChecked(S.hideFramesInCombat)
    
    -- Sync Options
    SyncOpts.GRM_RosterSyncCheckButton:SetChecked(S.syncEnabled)
    SyncOpts.GRM_RosterNotifyOnChangesCheckButton:SetChecked(S.syncChatEnabled)
    SyncOpts.GRM_RosterSyncBanList:SetChecked(S.syncBanList)
    SyncOpts.GRM_SyncAllRestrictReceiveButton:SetChecked(S.exportAllRanks)
    SyncOpts.GRM_AutoTriggerSyncCheckButton:SetChecked(S.autoTriggerSync)
    SyncOpts.GRM_CustomNoteSyncCheckBox:SetChecked(S.syncCustomNote)

    -- Scanning Options
    GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButton:SetChecked(S.reportInactiveReturn)
    GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton:SetChecked(S.allAltRequirement)
    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButton:SetChecked(S.calendarAnnouncements)
    GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton:SetChecked(S.onlyAnnounceForMain)
    GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce:SetChecked(S.bdayAnnounce)
    GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce:SetChecked(S.annivAnnounce)
    GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButton:SetChecked(S.AnnounceBdayOnLogin)
    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton:SetChecked(S.scanEnabled)
    GRM_ScanningOptionsFrame.GRM_LevelRecordButton:SetChecked(S.recordLevelUp)
    GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButton:SetChecked(S.addNotesToLeft)

    -- Names Options
    NamesOpts.GRM_ShowMainAltTagsButton:SetChecked(S.useMainTag)
    NamesOpts.GRM_ShowMainNameCheckButton:SetChecked(S.showMainName)
    NamesOpts.GRM_ShowNicknameButton:SetChecked(S.showNickname)
    NamesOpts.GRM_ShowNicknameInsteadButton:SetChecked(S.showNicknameNotMain)
    NamesOpts.GRM_ShowNicknameToAll:SetChecked(S.ShowNicknameToAll)
    NamesOpts.GRM_ShareNicknamesButton:SetChecked(S.shareNickToAlts)

    -- ================
    -- DEPENDENCY LOGIC
    -- ================
    
    SetUIState(OfficerOpts.GRM_AddJoinedTagButton, OfficerOpts.GRM_AddJoinedTagButtonText, S.addTimestampToNote)
    SetUIState(GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton, GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButtonText, S.reportInactiveReturn)
    SetUIState(UXOpts.GRM_ShowLevelCheckButton2, UXOpts.GRM_ShowLevelCheckButton2Text, S.showLevel)
    
    SetUIState(OfficerOpts.GRM_RosterReportAddEventsToCalendarButton, OfficerOpts.GRM_RosterReportAddEventsToCalendarButtonText, S.calendarAnnouncements)
    SetUIState(GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton, GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText, S.calendarAnnouncements)
    SetUIState(GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce, GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText, S.calendarAnnouncements)
    SetUIState(GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce, GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText, S.calendarAnnouncements)
    
    SetUIState(GenOpts.GRM_RosterLoadOnLogonChangesCheckButton, GenOpts.GRM_RosterLoadOnLogonChangesCheckButtonText, S.viewOnLoad)

    -- Sync Settings have more custom colorizing
    SetUIState(SyncOpts.GRM_RosterNotifyOnChangesCheckButton, SyncOpts.GRM_RosterNotifyOnChangesCheckButtonText, S.syncEnabled)
    SetUIState(SyncOpts.GRM_RosterSyncBanList, SyncOpts.GRM_RosterSyncBanListText, S.syncEnabled)
    if S.syncEnabled then SyncOpts.GRM_RosterSyncBanListText3:SetTextColor(1.0, 0.82, 0.0, 1.0) else SyncOpts.GRM_RosterSyncBanListText3:SetTextColor(0.5, 0.5, 0.5, 1) end
    
    SetUIState(SyncOpts.GRM_SyncAllRestrictReceiveButton, SyncOpts.GRM_SyncAllRestrictReceiveButtonText, S.syncEnabled)
    SetUIState(SyncOpts.GRM_AutoTriggerSyncCheckButton, SyncOpts.GRM_AutoTriggerSyncCheckButtonText, S.syncEnabled)
    if S.syncEnabled then SyncOpts.GRM_AutoTriggerSyncCheckButtonText2:SetTextColor(1.0, 0.82, 0.0, 1.0) else SyncOpts.GRM_AutoTriggerSyncCheckButtonText2:SetTextColor(0.5, 0.5, 0.5, 1) end
    
    SetUIState(OptionsFrame.GRM_AutoTriggerTimeEditBox, OptionsFrame.GRM_AutoTriggerTimeOverlayNote.GRM_AutoTriggerTimeOverlayNoteText, S.syncEnabled, 1.0, 0.0, 0.0) -- Note red color
    SetUIState(SyncOpts.GRM_CustomNoteSyncCheckBox, SyncOpts.GRM_CustomNoteSyncCheckBoxText, S.syncEnabled)

    -- Custom Note Sync
    SetUIState(SyncOpts.GRM_CustomRankResetButton, SyncOpts.GRM_DefaultCustomRankText, S.syncEnabled and S.syncCustomNote)
    if S.syncEnabled and S.syncCustomNote then
        SyncOpts.GRM_DefaultCustomRankText2:SetTextColor(1.0, 0.82, 0.0, 1.0)
    else
        SyncOpts.GRM_DefaultCustomRankText2:SetTextColor(0.5, 0.5, 0.5, 1)
    end

    -- ====================
    -- BUILD SPECIFIC LOGIC
    -- ====================

    -- Mythic Rating (M+ didn't occur until BFA)
    local isBFA_OrLater = GRM_G.BuildVersion >= 80000
    if not isBFA_OrLater then
        UXOpts.GRM_ShowMythicRatingButton:SetChecked(false)
    end
    SetUIState(UXOpts.GRM_ShowMythicRatingButton, UXOpts.GRM_ShowMythicRatingButtonText, isBFA_OrLater)

    -- Settings Owner Text
    if S.syncSettings then
        -- Guild Settings
        OptionsFrame.settingsOwner:SetText(GRM.L("{name}'s Settings", GRM.SlimName(GRM_G.guildName)))
    else
        -- Not in a guild, user settings
        OptionsFrame.settingsOwner:SetText(GRM.L("{name}'s Settings", GRM.SlimName(GRM_G.addonUser)))
    end
    
    -- Minimap Type
    if GenOpts.GRM_MinimapTypeButtonRadial1 then
        GenOpts.GRM_MinimapTypeButtonRadial1:SetChecked(S.minimapType == 1)
        GenOpts.GRM_MinimapTypeButtonRadial2:SetChecked(S.minimapType == 2)
    end

    -- Nicknames
    GRM_UI.NamesTab.EnableNicknameOptions(S.showNickname)

    -- Add Events To Calendar permission check
    local canAddCalendar = GRM_G.BuildVersion >= 30000 and CanEditGuildEvent()
    if not canAddCalendar then 
        OfficerOpts.GRM_RosterReportAddEventsToCalendarButton:SetChecked(false)
    end
    SetUIState(OfficerOpts.GRM_RosterReportAddEventsToCalendarButton, OfficerOpts.GRM_RosterReportAddEventsToCalendarButtonText, canAddCalendar)

    -- =============
    -- LEVEL FILTERS
    -- =============
    GRM_UI.ScanTab.SetLevelLogOptions()
    
    -- Mapping checkboxes to texts, boolean settings, and level thresholds
    -- This will be expanded if we ever go beyond MoP Classic
    local lvlFilters = {
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter1Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter1Text,  val = S.levelFilters[1], min = 10 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter2Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter2Text,  val = S.levelFilters[2], min = 20 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter3Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter3Text,  val = S.levelFilters[3], min = 30 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter4Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter4Text,  val = S.levelFilters[4], min = 40 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter5Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter5Text,  val = S.levelFilters[5], min = 50 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter6Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter6Text,  val = S.levelFilters[6], min = 60 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter7Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter7Text,  val = S.levelFilters[7], min = 70 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter8Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter8Text,  val = S.levelFilters[8], min = 80 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter9Button,  txt = GRM_ScanningOptionsFrame.GRM_LevelFilter9Text,  val = S.levelFilters[9], min = 25 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter85Button, txt = GRM_ScanningOptionsFrame.GRM_LevelFilter85Text, val = S.levelFilters[10], min = 85 },
        { btn = GRM_ScanningOptionsFrame.GRM_LevelFilter90Button, txt = GRM_ScanningOptionsFrame.GRM_LevelFilter90Text, val = S.levelFilters[11], min = 90 },
    }

    -- Helper to apply the logic to a single filter
    local function ConfigLvlFilter(fData, isVisible, isEnabled)
        if not isVisible then
            fData.btn:Hide()
            return
        end
        fData.btn:Show()

        if isEnabled then
            fData.btn:Enable()
            -- Checked state assignment
            fData.btn:SetChecked(fData.val)
            -- Blue if selected or min level met, else red
            if fData.val or S.levelReportMin <= fData.min then
                fData.txt:SetTextColor(0.0, 0.8, 1.0, 1.0)
            else
                fData.txt:SetTextColor(1.0, 0.0, 0.0, 1.0)
            end
        else
            fData.btn:Disable()
            fData.txt:SetTextColor(0.5, 0.5, 0.5, 1.0)
        end
    end

    -- Process visibility and enabled states
    local enableLvl = S.recordLevelUp
    
    if enableLvl then
        GRM_ScanningOptionsFrame.GRM_MinLevelText2:SetTextColor(1.0, 0.82, 0, 1)
        GRM_ScanningOptionsFrame.GRM_MinLevelText3:SetTextColor(1.0, 0.82, 0, 1)
    else
        GRM_ScanningOptionsFrame.GRM_MinLevelText2:SetTextColor(0.5, 0.5, 0.5, 1)
        GRM_ScanningOptionsFrame.GRM_MinLevelText3:SetTextColor(0.5, 0.5, 0.5, 1)
    end

    for i, fData in ipairs(lvlFilters) do
        local vis, en = true, enableLvl
        
        -- Filter index maps to specific expansion checks (indices 1-6 are always visible)
        if i >= 3 and i <= 6 and GRM_G.SOD and (GRM_G.LvlCap == 40 or GRM_G.LvlCap == 50) then 
            en = false 
        end
        if i >= 5 and i <= 6 and GRM_G.SOD and GRM_G.LvlCap == 60 then 
            en = false 
        end
        
        if i == 7 then vis = (GRM_G.BuildVersion >= 20000 and GRM_G.BuildVersion < 90000) or GRM_G.BuildVersion >= 100000 end
        if i == 8 then vis = (GRM_G.BuildVersion >= 30000 and GRM_G.BuildVersion < 90000) or GRM_G.BuildVersion >= 110000 end
        if i == 9 then vis = (GRM_G.SOD and GRM_G.LvlCap == 25) end
        if i == 10 then vis = (GRM_G.BuildVersion >= 40000 and GRM_G.BuildVersion < 90000) end
        if i == 11 then vis = (GRM_G.BuildVersion >= 50000 and GRM_G.BuildVersion < 90000) or GRM_G.BuildVersion >= 120000 end
        
        ConfigLvlFilter(fData, vis, en)
    end

    GRM_ScanningOptionsFrame.GRM_LevelRange:SetText(GRM.GetLevelRange())
    GRM_UI.NamesTab.UpdateTagOptionsText()

    -- ====================
    -- SLIDERS & EDIT BOXES
    -- ====================
    
    GenOpts.GRM_FontSizeSlider.Slider:SetValue((S.fontModifier * 10) + 100)
    GenOpts.GRM_FontSizeSliderText2:SetText(math.floor(GenOpts.GRM_FontSizeSlider.Slider:GetValue() + 0.5) .. "%")
    GenOpts.GRM_FontSizeSliderText3:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 14)
    
    if not GameTooltip:IsVisible() then
        GRM_G.toolTipScale = GameTooltip:GetScale()
    end
    
    GenOpts.GRM_TooltipScaleSlider.Slider:SetValue((((S.tooltipSize - 0.8) / 0.02) * 5) + 50)
    GenOpts.GRM_TooltipScaleSliderText2:SetText(math.floor(GenOpts.GRM_TooltipScaleSlider.Slider:GetValue() + 0.5) .. "%")
    
    LogOpts.GRM_LogFontSizeSlider.Slider:SetValue((S.logFontSize * 10) + 100)
    LogOpts.GRM_LogFontSizeSlider.GRM_LogFontSizeSliderText2:SetText(math.floor(LogOpts.GRM_LogFontSizeSlider.Slider:GetValue() + 0.5) .. "%")

    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNoteText:SetText(S.eventAdvanceDays)
    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote.GRM_RosterTimeIntervalOverlayNoteText:SetText(S.scanDelay)
    GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNoteText:SetText(math.floor(S.inactiveHours / 24))
    
    if S.levelReportMin == 0 then
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetText(1)
    else
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetText(S.levelReportMin)
    end

    -- Toggle EditBox/Overlay visibility
    if GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:IsVisible() then
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:Hide()
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:Show()
    end
    if GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:IsVisible() then
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:Hide()
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:Show()
    end

    OfficerOpts.GRM_CustomTagJoinEditBox:SetText(GRM_G.customHeaderJoin)
    OfficerOpts.GRM_CustomTagREJoinEditBox:SetText(GRM_G.customHeaderRejoin)

    -- ====================
    -- FINAL CONFIGURATIONS
    -- ====================
    
    GRM_UI.RefreshLogExtraOptions = function()
        LogOpts.GRM_LogShowLinesCheckButton:SetChecked(S.showLineNumbers)
        LogOpts.GRM_LogEnableRmvClickCheckButton:SetChecked(S.shiftClickRemove)
        LogOpts.GRM_LogShowTooltipCheckButton:SetChecked(S.showTooltip)
        LogOpts.GRM_SearchAutoFocusCheckButton:SetChecked(S.autoFocusSearch)

        LogOpts.GRM_LogExtraEditBox1:SetText(0)
        LogOpts.GRM_LogExtraEditBox2:SetText(0)
        LogOpts.GRM_LogFontSizeSlider.Slider:SetValue((S.logFontSize * 10) + 100)

        OptionsCore.BuildLogFilterSideFrame()
    end

    GRM_UI.OfficerTab.ConfigureJoinDateLocation()

    if not GRM_G.HardcoreActive then
        SetUIState(OptionsFrame.GRM_ClassicOptionsFrame.GRM_DeathsChannelEnabledCheckbox, OptionsFrame.GRM_ClassicOptionsFrame.GRM_DeathsChannelEnabledCheckbox.GRM_DeathsChannelEnabledCheckboxText, false)
        SetUIState(OptionsFrame.GRM_ClassicOptionsFrame.GRM_HardcoreAddTagCheckbox, OptionsFrame.GRM_ClassicOptionsFrame.GRM_HardcoreAddTagCheckbox.GRM_HardcoreAddTagCheckboxText, false)
        SetUIState(OptionsFrame.GRM_ClassicOptionsFrame.GRM_HardcoreAddTimeCheckbox, OptionsFrame.GRM_ClassicOptionsFrame.GRM_HardcoreAddTimeCheckbox.GRM_HardcoreAddTimeCheckboxText, false)
    else
        GRM_UI.ConfigureHCOptions()
    end
    
    GRM_UI.ConfigureClassicProfessionOptions((GRM_G.BuildVersion < 100000 and not S.ProfFullyDisabled))
    GRM_UI.RefreshLogExtraOptions()
    GRM_UI.ReportDestination(GenOpts.GRM_ReportDestinationEditBox)
    GRM_UI.DD.CreateOptionsRankDropDown()
end