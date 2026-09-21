local ScanTab = {}
GRM_UI.ScanTab = ScanTab

ScanTab.BuildScanTab = function()
    if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame.Configured then
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame.Configured = true

        local GRM_ScanningOptionsFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame;

        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton:SetPoint ( "TOPLEFT" , GRM_ScanningOptionsFrame.OptionsScanDetailsText , "BOTTOMLEFT" , -4 , -4 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton , "RIGHT" , 2 , 0 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText2:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText , "RIGHT" , 37.5 , 0 );
        
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton:SetScript ( "OnClick", function()
            if GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton:GetChecked() then
                GRM.S().scanEnabled = true;
                GRM_G.S.scanEnabled = true;
                GRM.Report ( GRM.L ( "Reactivating SCAN for Guild Member Changes..." ) );

                GRM.GuildRoster();
                GRM_G.IntegrityTackingEnabled = false;
                GRM.TriggerTrackingCheck();
            else
                GRM.S().scanEnabled = false;
                GRM_G.S.scanEnabled = false;
                GRM_G.changeHappenedExitScan = true;
                GRM_G.CurrentlyScanning = false;
                GRM.Report ( GRM.L ( "Deactivating SCAN of Guild Member Changes..." ) );
            end
        end);

        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton:SetScript( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "If disabled, a one time scan is still done at login or reload." ) );
            GameTooltip:Show();
        end);
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip()
        end);

        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText , "RIGHT" , 1.0 , 0 )
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:SetFrameStrata ( "HIGH" );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:SetSize ( 35 , 22 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote.GRM_RosterTimeIntervalOverlayNoteText:SetPoint ( "CENTER" , GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote.GRM_RosterTimeIntervalOverlayNoteText:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        local delay = 30;
        if GRM.S() then
            delay = GRM.S().scanDelay;
        end
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote.GRM_RosterTimeIntervalOverlayNoteText:SetText ( delay );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText , "RIGHT" , 5 , 0 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetSize ( 30 , 22 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetMaxLetters ( 3 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetNumeric ( true );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetFontObject ( "GameFontNormal" );
        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:EnableMouse ( true );

        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:SetScript ( "OnMouseDown" , function ( self , button )
            if button == "LeftButton" then
                if GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:IsEnabled() then
                    self:Hide();
                    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetText ( "" );
                    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:Show()
                end
            end
        end);

        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetScript ( "OnEscapePressed" , function( self )
            self:Hide();
            GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:Show();
        end);

        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetScript ( "OnEnterPressed" , function( self )
            local numSeconds = tonumber ( self:GetText() );
            if numSeconds >= 20 then
                GRM.S().scanDelay = numSeconds;
                GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote.GRM_RosterTimeIntervalOverlayNoteText:SetText ( numSeconds );
                self:Hide();
                GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:Show();

                -- Reset the integrity check
                GRM_G.TimeAtCompletion = time();
                GRM.GuildRoster();
            else
                GRM.Report ( GRM.L ( "Please choose a scan interval {num} seconds or higher!" , nil , nil , 20 ) .. " " .. GRM.L ( "{num} is too Low!" , nil , nil , numSeconds ) );
            end
        end);

        GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:SetScript ( "OnEditFocusLost" , function()
            GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalEditBox:Hide();
            GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote:Show();
        end)

        -- Level filtering
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_MinLevelText3 , "RIGHT" , 1.0 , 0 )
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:SetFrameStrata ( "HIGH" );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:SetSize ( 35 , 22 );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetPoint ( "CENTER" , GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_MinLevelText3 , "RIGHT" , 5 , 0 );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetSize ( 30 , 22 );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetMaxLetters ( 3 );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetNumeric ( true );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetTextColor ( 0 , 0.82 , 1 , 1.0 );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetFontObject ( "GameFontNormal" );
        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:EnableMouse ( true );

        GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:SetScript ( "OnMouseDown" , function ( self , button )
            if button == "LeftButton" then
                if GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:IsEnabled() then
                    self:Hide();
                    GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetText ( "" );
                    GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:Show()
                end
            end
        end);

        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetScript ( "OnEscapePressed" , function( self )
            self:Hide();
            GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:Show();
        end);

        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetScript ( "OnEnterPressed" , function( self )
            local level = tonumber ( self:GetText() );
            if level ~= nil then
                if level < 2 then
                    GRM.S().levelReportMin = 1;
                    GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetText ( 1 );
                    ScanTab.SetLevelLogOptions();
                elseif level > GRM_G.LvlCap  then
                    GRM.S().levelReportMin = GRM_G.LvlCap ;
                    GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetText ( GRM_G.LvlCap  );
                    ScanTab.SetLevelLogOptions();
                    GRM.Report ( GRM.L ( "The Current Lvl Cap is {num}." , nil , nil , GRM_G.LvlCap  ) );
                else
                    GRM.S().levelReportMin = level;
                    GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetText ( level );
                    ScanTab.SetLevelLogOptions();
                end
                self:Hide();
                GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:Show();
                GRM.BuildLogComplete( true , true , true );
            else
                GRM.Report ( GRM.L ( "Please enter a valid level between 1 and {num}" , nil , nil , GRM_G.LvlCap  ) );
            end
        end);

        GRM_ScanningOptionsFrame.GRM_RosterMinLvlEditBox:SetScript ( "OnEditFocusLost" , function( self )
            self:Hide();
            GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNote:Show();
        end)

        -- Report Inactive Recommendation.
        GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButton:SetPoint ( "TOPLEFT" , GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton , "BOTTOMLEFT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButton , "RIGHT" , 2 , 0 );
        GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText2:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText , "RIGHT" , 32 , 0 );
        GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().reportInactiveReturn = true;
                GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton:Enable();
                GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButtonText:SetTextColor ( 1.0 , 0.82 , 0.0 , 1.0 );
            else
                GRM.S().reportInactiveReturn = false;
                GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton:Disable();
                GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButtonText:SetTextColor ( 0.5 , 0.5 , 0.5 , 1 );
            end
        end);

        GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton:SetPoint ( "TOPLEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButton , "BOTTOMRIGHT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().allAltRequirement = true;
            else
                GRM.S().allAltRequirement = false;
            end
        end);
        GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButtonText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton , "RIGHT" , 2 , 0 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText , "RIGHT" , 0.5 , 0 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:SetFrameStrata ( "HIGH" );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:SetSize ( 30 , 22 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNoteText:SetPoint ( "CENTER" , GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNoteText:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        local inactiveHRS = 336;
        if GRM.S() then
            inactiveHRS = GRM.S().inactiveHours;
        end
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNoteText:SetText ( math.floor ( inactiveHRS / 24 ) );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetPoint( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText , "RIGHT" , 5 , 0 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetSize ( 25 , 22 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetMaxLetters ( 3 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetNumeric ( true );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetFontObject ( "GameFontNormal" );
        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:EnableMouse( true );


        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:SetScript ( "OnMouseDown" , function ( self , button )
            if button == "LeftButton" then
                self:Hide();
                GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetText ( "" );
                GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:Show();
            end
        end);

        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetScript ( "OnEscapePressed" , function( self )
            self:Hide();
            GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:Show();
        end);

        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetScript ( "OnEnterPressed" , function( self )
            local numDays = tonumber ( self:GetText() );
            if numDays > 0 and numDays < 181 then
                GRM.S().inactiveHours = numDays * 24;
                GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNoteText:SetText ( numDays );
                self:Hide();
                GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:Show();
            else
                GRM.Report ( GRM.L ( "Please choose between 1 and 180 days!" ) );
            end
        end);

        GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnEditBox:SetScript ( "OnEditFocusLost" , function( self )
            self:Hide();
            GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNote:Show();
        end)

        -- Add Event Options on Announcing...
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButton:SetPoint ( "TOPRIGHT" , GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton , "BOTTOMLEFT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButton , "RIGHT" , 2 , 0 );
        
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText2:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText , "RIGHT" , 32 , 0 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().calendarAnnouncements = true;
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_RosterReportAddEventsToCalendarButton:Enable();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_RosterReportAddEventsToCalendarButtonText:SetTextColor ( 1.0 , 0.82 , 0.0 , 1.0 );

                GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton:Enable();
                GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetTextColor ( 1.0 , 0.82 , 0.0 , 1.0 );

                GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce:Enable();
                GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetTextColor ( 1.0 , 0.82 , 0.0 , 1.0 );

                GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce:Enable();
                GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetTextColor ( 1.0 , 0.82 , 0.0 , 1.0 );

            else
                GRM.S().calendarAnnouncements = false;
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_RosterReportAddEventsToCalendarButton:Enable();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_RosterReportAddEventsToCalendarButtonText:SetTextColor ( 1.0 , 0.82 , 0.0 , 1.0 );

                GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton:Disable();
                GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetTextColor ( 0.5 , 0.5 , 0.5 , 1.0 );

                GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce:Disable();
                GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetTextColor ( 0.5 , 0.5 , 0.5 , 1.0 );

                GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce:Disable();
                GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetTextColor ( 0.5 , 0.5 , 0.5 , 1.0 );

            end
        end);

        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText , "RIGHT" , 0.5 , 0 )
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:SetFrameStrata ( "HIGH" );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:SetSize ( 30 , 22 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNoteText:SetPoint ( "CENTER" , GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNoteText:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        local eventAdvDays = 14;
        if GRM.S() then
            eventAdvDays = GRM.S().eventAdvanceDays
        end
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNoteText:SetText ( eventAdvDays ) ;
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetPoint( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText , "RIGHT" , 5 , 0 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetSize ( 25 , 22 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetMaxLetters ( 2 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetNumeric ( true );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetTextColor ( 1.0 , 0 , 0 , 1.0 );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetFontObject ( "GameFontNormal" );
        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:EnableMouse( true );

        local EventsEditBox = function()

            local text = GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:GetText();
            if text and text ~= "" then

                local numDays = tonumber ( text );
                if numDays > 0 and numDays < 100 then

                    GRM.S().eventAdvanceDays = numDays;
                    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNoteText:SetText ( numDays );
                    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:Hide();
                    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:Show();

                end
            end
        end

        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:SetScript ( "OnMouseDown" , function( self , button )
            if button == "LeftButton" then
                self:Hide();
                GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetText ( "" );
                GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:Show();
            end
        end);

        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetScript ( "OnEscapePressed" , function( self )
            self:Hide();
            GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNote:Show();
        end);

        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetScript ( "OnEnterPressed" , function()
            EventsEditBox();
        end);

        GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsEditBox:SetScript ( "OnEditFocusLost" , function()
            EventsEditBox();
        end)

        GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce:SetPoint ( "TOPLEFT" , GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButton , "BOTTOMRIGHT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce , "RIGHT" , 2 , 0)
        GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetWordWrap ( true );
        GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetSpacing ( 0.5 );
        GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetJustifyH ( "LEFT" );
        
        GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().annivAnnounce = true;
            else
                GRM.S().annivAnnounce = false;
            end
        end);

        GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce:SetPoint ( "TOPLEFT" , GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce , "BOTTOMLEFT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce , "RIGHT" , 2 , 0)
        GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetWordWrap ( true );
        GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetSpacing ( 0.5 );
        GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetJustifyH ( "LEFT" );

        GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().bdayAnnounce = true;
            else
                GRM.S().bdayAnnounce = false;
            end
        end);

        -- Only announce Anniversaries of Player who is designated "main"
        GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton:SetPoint ( "TOPLEFT" , GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce , "BOTTOMLEFT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton , "RIGHT" , 2 , 0)
        GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetWordWrap ( true );
        GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetSpacing ( 0.5 );
        GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetJustifyH ( "LEFT" );
        GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetWidth ( GRM_ScanningOptionsFrame:GetWidth() - 75 );
        GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().onlyAnnounceForMain = true;
            else
                GRM.S().onlyAnnounceForMain = false;
            end
            GRM.Scan.CheckPlayerEvents();
        end);

        GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButton:SetPoint ( "TOPRIGHT" , GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton , "BOTTOMLEFT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButtonText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButton , "RIGHT" , 2 , 0)
        GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButtonText:SetWordWrap ( true );
        GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButtonText:SetSpacing ( 0.5 );

        GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().AnnounceBdayOnLogin = true;
            else
                GRM.S().AnnounceBdayOnLogin = false;
            end
            if not GRM_G.CurrentlyScanning then
                GRM.Scan.CheckPlayerEvents();
            end
        end);

        -- Show public/officer ntoe on joining and leaving players.
        GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButton:SetPoint ( "TOPLEFT" , GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButton , "BOTTOMLEFT" , 0 , -6 );
        GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText:SetPoint ( "LEFT" , GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButton , "RIGHT" , 2 , 0)
        GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText:SetWordWrap ( true );
        GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText:SetSpacing ( 0.5 );
        GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText:SetJustifyH ( "LEFT" );
        GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText:SetWidth ( GRM_ScanningOptionsFrame:GetWidth() - 50);

        GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().addNotesToLeft = true;
            else
                GRM.S().addNotesToLeft = false;
            end
            if not GRM_G.CurrentlyScanning then
                GRM.Scan.CheckPlayerEvents();
            end
        end);

        -- LEVEL FILTER SETTINGS
        local filterDefinitions = {
            { idx = 1,  lvl = 10, btnName = "GRM_LevelFilter1Button" },
            { idx = 2,  lvl = 20, btnName = "GRM_LevelFilter2Button" },
            { idx = 9,  lvl = 25, btnName = "GRM_LevelFilter9Button", condition = function() return GRM_G.SOD and GRM_G.LvlCap == 25 end },
            { idx = 3,  lvl = 30, btnName = "GRM_LevelFilter3Button", condition = function() return not (GRM_G.SOD and GRM_G.LvlCap < 30) end },
            { idx = 4,  lvl = 40, btnName = "GRM_LevelFilter4Button", condition = function() return not (GRM_G.SOD and GRM_G.LvlCap < 40) end },
            { idx = 5,  lvl = 50, btnName = "GRM_LevelFilter5Button", condition = function() return not (GRM_G.SOD and GRM_G.LvlCap < 50) end },
            { idx = 6,  lvl = 60, btnName = "GRM_LevelFilter6Button", condition = function() return not (GRM_G.SOD and GRM_G.LvlCap < 60) end },
            { idx = 7,  lvl = 70, btnName = "GRM_LevelFilter7Button", condition = function() return (GRM_G.BuildVersion >= 20000 and GRM_G.BuildVersion < 90000) or GRM_G.BuildVersion >= 100000 end },
            { idx = 8,  lvl = 80, btnName = "GRM_LevelFilter8Button", condition = function() return (GRM_G.BuildVersion >= 30000 and GRM_G.BuildVersion < 90000) or GRM_G.BuildVersion >= 110000 end },
            { idx = 10, lvl = 85, btnName = "GRM_LevelFilter85Button",condition = function() return (GRM_G.BuildVersion >= 40000 and GRM_G.BuildVersion < 90000) end },
            { idx = 11, lvl = 90, btnName = "GRM_LevelFilter90Button",condition = function() return (GRM_G.BuildVersion >= 50000 and GRM_G.BuildVersion < 90000) or GRM_G.BuildVersion >= 120000 end }
        }

        ScanTab.LevelFiltersData = {}

        -- ========================
        -- DYNAMIC CREATION & SETUP
        -- ========================

        for _, def in ipairs(filterDefinitions) do
            local btn = CreateFrame("CheckButton", def.btnName, GRM_ScanningOptionsFrame, "InterfaceOptionsCheckButtonTemplate")
            local txt = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            
            txt:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12)
            txt:SetText(tostring(def.lvl))
            btn:SetHitRectInsets(0, 0, 0, 0)
            
            -- Map to GRM_ScanningOptionsFrame directly
            GRM_ScanningOptionsFrame[def.btnName] = btn
            GRM_ScanningOptionsFrame[def.btnName:gsub("Button", "Text")] = txt
            
            -- Assign OnClick
            btn:SetScript("OnClick", function(self)
                ScanTab.ConfigureLevelFilterButton(self, txt, def.idx, def.lvl)
            end)
            
            -- Store in persistent array for fast access
            table.insert(ScanTab.LevelFiltersData, {
                idx = def.idx,
                lvl = def.lvl,
                btn = btn,
                txt = txt,
                condition = def.condition
            })
        end

        -- ======
        -- LAYOUT
        -- ======
        GRM_ScanningOptionsFrame.GRM_LevelRecordButton:SetPoint("TOPLEFT", GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButton, "BOTTOMLEFT", 0, -6)
        GRM_ScanningOptionsFrame.GRM_MinLevelText:SetPoint("LEFT", GRM_ScanningOptionsFrame.GRM_LevelRecordButton, "RIGHT", 2, 0)
        GRM_ScanningOptionsFrame.GRM_MinLevelText3:SetPoint("TOPLEFT", GRM_ScanningOptionsFrame.GRM_MinLevelText, "BOTTOMLEFT", 1, -20)
        GRM_ScanningOptionsFrame.GRM_MinLevelText2:SetPoint("TOPLEFT", GRM_ScanningOptionsFrame.GRM_MinLevelText3, "BOTTOMLEFT", -1, -20)
        GRM_ScanningOptionsFrame.GRM_LevelRange:SetPoint("LEFT", GRM_ScanningOptionsFrame.GRM_MinLevelText3, "RIGHT", 43, 0)
        GRM_ScanningOptionsFrame.GRM_LevelRange:SetTextColor(1.0, 0, 0, 1)

        -- Main toggle button logic
        GRM_ScanningOptionsFrame.GRM_LevelRecordButton:SetScript("OnClick", function(self)
            GRM.S().recordLevelUp = self:GetChecked()
            ScanTab.SetLevelLogOptions()
        end)

        -- The function that updates the entire filter UI state
        ScanTab.SetLevelLogOptions = function()
            local isEnabled = GRM.S().recordLevelUp

            -- Color the Headers
            local headerColor = isEnabled and {1.0, 0.82, 0, 1} or {0.5, 0.5, 0.5, 1}
            GRM_ScanningOptionsFrame.GRM_MinLevelText2:SetTextColor(unpack(headerColor))
            GRM_ScanningOptionsFrame.GRM_MinLevelText3:SetTextColor(unpack(headerColor))

            -- Dynamic Auto-Anchoring starting point
            local lastAnchor = GRM_ScanningOptionsFrame.GRM_MinLevelText2
            local xOffsetText = 4

            for _, fData in ipairs(ScanTab.LevelFiltersData) do
                -- Evaluate visibility based on current game build (SoD, Retail, Cata, etc.)
                local isVisible = (not fData.condition) or fData.condition()

                if isVisible then
                    fData.btn:Show()
                    fData.txt:Show()

                    -- Auto-Layout! Anchor from left to right
                    -- If a middle level is hidden (like level 30 on SoD), the next one seamlessly anchors to last viisble one
                    fData.txt:ClearAllPoints()
                    fData.txt:SetPoint("LEFT", lastAnchor, "RIGHT", xOffsetText, 0)
                    fData.btn:ClearAllPoints()
                    fData.btn:SetPoint("LEFT", fData.txt, "RIGHT", -2, 0)
                    
                    -- Prepare anchor for the next filter in the loop
                    lastAnchor = fData.btn
                    xOffsetText = 4 

                    -- Enable/Disable Logic
                    if isEnabled then
                        fData.btn:Enable()
                        fData.btn:SetChecked(GRM.S().levelFilters[fData.idx])

                        if GRM.S().levelFilters[fData.idx] or GRM.S().levelReportMin <= fData.lvl then
                            fData.txt:SetTextColor(0.0, 0.8, 1.0, 1.0) -- Active
                        else
                            fData.txt:SetTextColor(1.0, 0.0, 0.0, 1.0) -- Inactive
                        end
                    else
                        fData.btn:Disable()
                        fData.txt:SetTextColor(0.5, 0.5, 0.5, 1.0) -- Disabled
                    end
                else
                    fData.btn:Hide()
                    fData.txt:Hide()
                end
            end

            GRM_ScanningOptionsFrame.GRM_LevelRange:SetText(GRM.GetLevelRange())
        end

        -- Logic for individual filter checkbox clicks
        ScanTab.ConfigureLevelFilterButton = function(button, buttonText, filterIndex, filterLevel)
            if button:GetChecked() then
                GRM.S().levelFilters[filterIndex] = true
                buttonText:SetTextColor(0.0, 0.8, 1.0, 1.0)
            else
                -- Only allow unchecking if this is NOT the absolute level cap
                if GRM_G.LvlCap > filterLevel then
                    GRM.S().levelFilters[filterIndex] = false
                    if GRM.S().levelReportMin > filterLevel then
                        buttonText:SetTextColor(1.0, 0.0, 0.0, 1.0)
                    end
                else
                    -- Prevent unchecking the level cap - just design preference. Level cap cannot be disabled
                    button:SetChecked(true) 
                end
            end
            GRM_ScanningOptionsFrame.GRM_LevelRange:SetText(GRM.GetLevelRange())
        end

        -- =====================
        -- TOOLTIP CONFIGURATION
        -- =====================
        ScanTab.ConfigureLevelFilterMaxTooltip = function()
            local maxLvlButton = nil
            local highestLvl = 0

            -- Dynamically find the highest visible level button for this WoW client
            for _, fData in ipairs(ScanTab.LevelFiltersData) do
                local isVisible = (not fData.condition) or fData.condition()
                if isVisible and fData.lvl > highestLvl then
                    highestLvl = fData.lvl
                    maxLvlButton = fData.btn
                end
            end

            if maxLvlButton then
                maxLvlButton:SetScript("OnEnter", function(self)
                    GRM_UI.SetTooltipScale()
                    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
                    GameTooltip:AddLine(GRM.L("Unable to disable level cap tracking. Please disable ALL tracking to turn off."))
                    GameTooltip:Show()
                end)
                maxLvlButton:SetScript("OnLeave", function()
                    GRM.RestoreTooltip()
                end)
            end
        end

        -- Run it to set the tooltip on init
        ScanTab.ConfigureLevelFilterMaxTooltip()
        
    end

    ScanTab.UpdateText();
end

ScanTab.UpdateText = function()
    local GRM_ScanningOptionsFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame;

    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText:SetText ( GRM.L ( "Before Scan Timer" ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButton , GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText );
    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalCheckButtonText2:SetText ( GRM.L ( "After Scan Timer" ) );
    GRM_ScanningOptionsFrame.GRM_RosterTimeIntervalOverlayNote.GRM_RosterTimeIntervalOverlayNoteText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterMinLvlOverlayNoteText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText:SetText ( GRM.L ( "Before Inactive Timer" ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButton , GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText );
    GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterReportInactiveReturnButtonText2:SetText ( GRM.L ( "After Inactive Timer" ) );
    GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButtonText:SetText ( GRM.L ( "Only Report if there are no Active Alts in the Group" ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButton , GRM_ScanningOptionsFrame.GRM_ReportInactivesOnlyIfAllButtonText );
    GRM_ScanningOptionsFrame.GRM_ReportInactiveReturnOverlayNoteText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText:SetText ( GRM.L ( "Announce Events" ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButton , GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText );
    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsCheckButtonText2:SetText ( GRM.L ( "Days in Advance" ) );
    GRM_ScanningOptionsFrame.GRM_RosterReportUpcomingEventsOverlayNoteText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText:SetText ( GRM.L ( "Announce Member Join Date Anniversaries." ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounce , GRM_ScanningOptionsFrame.GRM_ScanOptionsAnniversaryAnnounceText );
    GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText:SetText ( GRM.L ( "Announce Player Birthdates." ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounce , GRM_ScanningOptionsFrame.GRM_ScanOptionsBirthdayAnnounceText );
    GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText:SetText ( GRM.L ( "Only Announce Birthdays and Anniversaries if Listed as 'Main'" ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButton , GRM_ScanningOptionsFrame.GRM_RosterMainOnlyCheckButtonText );
    GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButtonText:SetJustifyH ( "LEFT" );
    GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButtonText:SetText ( GRM.L ( "Announce if Player's Birthday when they Login." ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButton , GRM_ScanningOptionsFrame.GRM_AnnounceBdaysOnLoginButtonText );
    GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText:SetText ( GRM.L ( "Show Public, Officer, and Custom Notes on Log Entries of Left Players" ) );
    GRM.NormalizeHitRects ( GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButton , GRM_ScanningOptionsFrame.GRM_ShowNotesOnLeavingPlayerButtonText );
    GRM_ScanningOptionsFrame.GRM_MinLevelText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12)
    GRM_ScanningOptionsFrame.GRM_MinLevelText:SetText(GRM.L("Report Level Up Changes"))
    GRM.NormalizeHitRects(GRM_ScanningOptionsFrame.GRM_LevelRecordButton, GRM_ScanningOptionsFrame.GRM_MinLevelText)
    GRM_ScanningOptionsFrame.GRM_MinLevelText3:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12)
    GRM_ScanningOptionsFrame.GRM_MinLevelText3:SetText(GRM.L("Level Filter Minimum:"))
    GRM_ScanningOptionsFrame.GRM_MinLevelText2:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12)
    GRM_ScanningOptionsFrame.GRM_MinLevelText2:SetText(GRM.L("Report Milestones:"))
    GRM_ScanningOptionsFrame.GRM_LevelRange:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12)
end