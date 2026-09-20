local DD = {};
GRM_UI.DD = DD;

-- Method:          DD.InitializeDropDownDay()
-- What it Does:    Initializes the Drop Down "Day" select window with values based on selected month
-- Purpose:         UI feature for easy date select.
DD.InitializeDropDownDay = function()
    local shortMonth = 30;
    local longMonth = 31;
    local febMonth = 28;
    local leapYear = 29;
    local yearDate = 0;

    yearDate = GRM_G.yearIndex;
    local isDateALeapyear = GRM.Time.IsLeapYear(yearDate);
    local numDays;

    if GRM_G.monthIndex == 1 or GRM_G.monthIndex == 3 or GRM_G.monthIndex == 5 or GRM_G.monthIndex == 7 or
        GRM_G.monthIndex == 8 or GRM_G.monthIndex == 10 or GRM_G.monthIndex == 12 then
        numDays = longMonth;
    elseif GRM_G.monthIndex == 2 and isDateALeapyear then
        numDays = leapYear;
    elseif GRM_G.monthIndex == 2 then
        numDays = febMonth;
    else
        numDays = shortMonth;
    end

    -- populating the frames!
    local buffer = 3;
    local height = 0;
    GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons =
        GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons or {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons do
        GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons[i][1]:Hide();
    end

    for i = 1, numDays do
        if not GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "DayOfTheMonth" .. i,
                GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu);
            GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons[i] = {tempButton,
                                                                              tempButton:CreateFontString(nil,
                "OVERLAY", "GameFontWhiteTiny")}
        end

        local DayButtons = GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons[i][1];
        local DayButtonsText = GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons[i][2];
        DayButtons:SetWidth(24);
        DayButtons:SetHeight(10);
        DayButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        DayButtonsText:SetText(i);
        DayButtonsText:SetWidth(25);
        DayButtonsText:SetWordWrap(false);
        DayButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9);
        DayButtonsText:SetPoint("CENTER", DayButtons);
        DayButtonsText:SetJustifyH("CENTER");

        if i == 1 then
            DayButtons:SetPoint("TOP", GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu, 0, -7);
            height = height + DayButtons:GetHeight();
        else
            DayButtons:SetPoint("TOP", GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu.Buttons[i - 1][1], "BOTTOM",
                0, -buffer);
            height = height + DayButtons:GetHeight() + buffer;
        end

        DayButtons:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                GRM_G.dayIndex = i;
                GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenuSelected.GRM_DayText:SetText(DayButtonsText:GetText());
                GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu:Hide();
                GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenuSelected:Show();
            end
        end);

        DayButtons:Show();
    end
    GRM_UI.GRM_MemberDetailMetaData.GRM_DayDropDownMenu:SetHeight(height + 15);
end

-- Method:          DD.InitializeDropDownYear()
-- What it Does:    Initializes the year select drop-down OnDropMenuClick
-- Purpose:         Easy way to set when player joined the guild.
DD.InitializeDropDownYear = function()
    -- Year Drop Down
    local currentYear = select(4, GRM.Time.GetTodaysDate());
    local yearStamp = currentYear;

    -- populating the frames!
    local buffer = 2;
    local height = 0;
    GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons =
        GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons or {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons do
        GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons[i][1]:Hide();
    end

    -- Game wasn't released until early 2004
    for i = 1, currentYear - 2003 do
        if not GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "YearIndexButton" .. i,
                GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu);
            GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons[i] = {tempButton,
                                                                               tempButton:CreateFontString(nil,
                "OVERLAY", "GameFontWhiteTiny")}
        end

        local YearButtons = GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons[i][1];
        local YearButtonsText = GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons[i][2];
        YearButtons:SetWidth(40);
        YearButtons:SetHeight(10);
        YearButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        YearButtonsText:SetText(yearStamp);
        YearButtonsText:SetWidth(32);
        YearButtonsText:SetWordWrap(false);
        YearButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9);
        YearButtonsText:SetPoint("CENTER", YearButtons);
        YearButtonsText:SetJustifyH("CENTER");

        if i == 1 then
            YearButtons:SetPoint("TOP", GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu, 0, -7);
            height = height + YearButtons:GetHeight();
        else
            YearButtons:SetPoint("TOP", GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu.Buttons[i - 1][1],
                "BOTTOM", 0, -buffer);
            height = height + YearButtons:GetHeight() + buffer;
        end

        YearButtons:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                local yearSelected = GRM.Time.GetCurrentCalendarTime().year + 1 - i;
                GRM_G.yearIndex = yearSelected;
                GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenuSelected.GRM_YearText:SetText(
                    YearButtonsText:GetText());
                GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu:Hide();
                GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenuSelected:Show();
            end
        end);
        yearStamp = yearStamp - 1 -- Descending the year by 1
        YearButtons:Show();
    end
    GRM_UI.GRM_MemberDetailMetaData.GRM_YearDropDownMenu:SetHeight(height + 15);

end

-- Method:          DD.InitializeDropDownMonth(self,level)
-- What it Does:    Initializes month drop select menu
-- Purpose:         Date select for Officer Note "Join Date"
DD.InitializeDropDownMonth = function()
    -- Month Drop Down
    local months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October",
                    "November", "December"};

    -- populating the frames!
    local buffer = 3;
    local height = 0;
    GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons =
        GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons or {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons do
        GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons[i][1]:Hide();
    end

    for i = 1, #months do
        if not GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "monthIndex" .. i,
                GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu);
            GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons[i] = {tempButton,
                                                                                tempButton:CreateFontString(nil,
                "OVERLAY", "GameFontWhiteTiny")}
        end

        local MonthButtons = GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons[i][1];
        local MonthButtonsText = GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons[i][2];
        MonthButtons:SetWidth(83);
        MonthButtons:SetHeight(10);
        MonthButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        MonthButtonsText:SetText(GRM.L(months[i]));
        MonthButtonsText:SetWidth(83);
        MonthButtonsText:SetWordWrap(false);
        MonthButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9);
        MonthButtonsText:SetPoint("CENTER", MonthButtons);
        MonthButtonsText:SetJustifyH("CENTER");

        if i == 1 then
            MonthButtons:SetPoint("TOP", GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu, 0, -7);
            height = height + MonthButtons:GetHeight();
        else
            MonthButtons:SetPoint("TOP", GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu.Buttons[i - 1][1],
                "BOTTOM", 0, -buffer);
            height = height + MonthButtons:GetHeight() + buffer;
        end

        MonthButtons:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                GRM_G.monthIndex = i;
                GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenuSelected.GRM_MonthText:SetText(
                    MonthButtonsText:GetText());
                GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu:Hide();
                GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenuSelected:Show();
            end
        end);

        MonthButtons:Show();
    end
    GRM_UI.GRM_MemberDetailMetaData.GRM_MonthDropDownMenu:SetHeight(height + 15);
end

-- Method:          DD.PopulateOptionsRankDropDown()
-- What it Does:    Adds all the guild ranks to the drop down menu
-- Purpose:         UI Feature
DD.PopulateOptionsRankDropDown = function()
    -- populating the frames!
    local buffer = 3;
    local height = 0;
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons or
            {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu
        .Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons[i][1]:Hide();
    end

    local i = 1;
    for count = 1, GuildControlGetNumRanks() do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu
            .Buttons[i] then
            local tempButton = CreateFrame("Button", "rankIndex" .. i, GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                .GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local RankButtons = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterSyncRankDropDownMenu.Buttons[i][1];
        local RankButtonsText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                    .GRM_RosterSyncRankDropDownMenu.Buttons[i][2];
        RankButtons:SetWidth(110);
        RankButtons:SetHeight(11);
        RankButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        RankButtonsText:SetText(GuildControlGetRankName(count));
        RankButtonsText:SetWidth(110);
        RankButtonsText:SetWordWrap(false);
        RankButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12);
        RankButtonsText:SetPoint("CENTER", RankButtons);
        RankButtonsText:SetJustifyH("CENTER");
        RankButtonsText:SetTextColor(0, 0.8, 1, 1);

        if i == 1 then
            RankButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterSyncRankDropDownMenu, 0, -7);
            height = height + RankButtons:GetHeight();
        else
            RankButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterSyncRankDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + RankButtons:GetHeight() + buffer;
        end

        RankButtons:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelected:Show();
                local selectedRank = GRM.GetRankIndex(GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                                                          .GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelectedText:GetText(),
                    self);
                local isRestricted, rankIndex = GRM.IsSyncRankGuildLeaderRestricted(2);

                -- Now, are they different? If they are different, that is a problem!
                if not isRestricted or CanEditGuildInfo() or (isRestricted and rankIndex == selectedRank) then
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                        .GRM_RosterSyncRankDropDownSelectedText:SetText(RankButtonsText:GetText());
                    GRM.S().syncRank = selectedRank;

                    GRM.Global.UpdateGuildInfoWithNewValue(2, selectedRank, true);

                    -- ban list check
                    if GRM.S().syncRank < GRM.S().syncRankBanList then
                        GRM.Report(GRM.L(
                            "Warning! Ban List rank threshold is below the overall sync rank. Changing from \"{name}\" to \"{name2}\"",
                            GuildControlGetRankName(GRM.S().syncRankBanList + 1), RankButtonsText:GetText()));

                        -- Saving the data
                        GRM.S().syncRankBanList = GRM.S().syncRank;
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                            .GRM_RosterBanListDropDownSelectedText:SetText(RankButtonsText:GetText());

                        GRM.Global.UpdateGuildInfoWithNewValue(3, GRM.S().syncRank, true);

                    end

                    -- Retrigger active addon users... Very important to know permissions
                    if not GRM_UI.GRM_RosterChangeLogFrame.GRM_AddonUsersFrame:IsVisible() then
                        GRM.RegisterGuildAddonUsersRefresh();
                    end

                    -- Let's re-initiate syncing!
                    if GRM.S().syncEnabled and not GRMsyncGlobals.currentlySyncing and GRM_G.HasAccessToGuildChat then
                        GRMsync.TriggerFullReset();
                        -- Now, let's add a brief delay, 3 seconds, to trigger sync again
                        C_Timer.After(3, GRMsync.Initialize);
                    end
                    -- Determine if player has access to guild chat or is in restricted chat rank
                    GRM_G.HasAccessToOfficerChat = false;
                    GRM.Util.RegisterGuildChatPermission();
                else
                    -- Report to player about Guild Leader restriction
                    GRM.ReportRankRestriction(rankIndex);
                end
            end
        end);
        RankButtons:Show();
        i = i + 1;
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu:SetHeight(
        height + 15);
end

-- Method:          DD.PopulateBanListOptionsDropDown()
-- What it Does:    Adds all the guild ranks to the drop down menu for ban changes
-- Purpose:         UI Feature in options - greater control to keep sync of ban list to officers only, whilst allowing great sync with all guildies.
DD.PopulateBanListOptionsDropDown = function()
    -- populating the frames!
    local buffer = 3;
    local height = 0;
    local color1 = {1, 0, 0};
    local color2 = {0, 0.8, 1};

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons or
            {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu
        .Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons[i][1]:Hide();
    end

    local i = 1;
    for count = 1, GuildControlGetNumRanks() do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu
            .Buttons[i] then
            local tempButton = CreateFrame("Button", "rankIndex" .. i, GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                .GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local RankButtons = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterBanListDropDownMenu.Buttons[i][1];
        local RankButtonsText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                    .GRM_RosterBanListDropDownMenu.Buttons[i][2];
        RankButtons:SetWidth(110);
        RankButtons:SetHeight(11);
        RankButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        RankButtonsText:SetText(GuildControlGetRankName(count));
        RankButtonsText:SetWidth(110);
        RankButtonsText:SetWordWrap(false);
        RankButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12);
        RankButtonsText:SetPoint("CENTER", RankButtons);
        RankButtonsText:SetJustifyH("CENTER");
        if i - 1 <= GRM.S().syncRank then
            RankButtonsText:SetTextColor(color2[1], color2[2], color2[3], 1);
        else
            RankButtonsText:SetTextColor(color1[1], color1[2], color1[3], 1);
        end

        if i == 1 then
            RankButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterBanListDropDownMenu, 0, -7);
            height = height + RankButtons:GetHeight();
        else
            RankButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterBanListDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + RankButtons:GetHeight() + buffer;
        end

        RankButtons:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelected:Show();
                local selectedRank = GRM.GetRankIndex(GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                                                          .GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelectedText:GetText(),
                    self);
                local isRestricted, rankIndex = GRM.IsSyncRankGuildLeaderRestricted(3);

                -- Now, are they different? If they are different, that is a problem!
                if not isRestricted or CanEditGuildInfo() or (isRestricted and rankIndex == selectedRank) then

                    if GRM.S().syncRank < selectedRank then

                        GRM.S().syncRankBanList = GRM.S().syncRank;
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                            .GRM_RosterBanListDropDownSelectedText:SetText(
                            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterSyncRankDropDownSelectedText:GetText());
                        GRM.Report(GRM.L("Warning! Unable to select a Ban List rank below \"{name}\"",
                            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterSyncRankDropDownSelectedText:GetText()) .. "\n" ..
                                       GRM.L("Setting to match core filter rank"));

                        GRM.Global.UpdateGuildInfoWithNewValue(3, GRM.S().syncRank, true);
                    else
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                            .GRM_RosterBanListDropDownSelectedText:SetText(RankButtonsText:GetText());
                        GRM.S().syncRankBanList = selectedRank;

                        GRM.Global.UpdateGuildInfoWithNewValue(3, selectedRank, true);
                    end

                    -- Re-trigger addon users permissions
                    if not GRM_UI.GRM_RosterChangeLogFrame.GRM_AddonUsersFrame:IsVisible() then
                        GRM.RegisterGuildAddonUsersRefresh();
                    end

                    -- Let's re-initiate syncing!
                    if GRM.S().syncEnabled and GRM.S().syncBanList and not GRMsyncGlobals.currentlySyncing and
                        GRM_G.HasAccessToGuildChat then
                        GRMsync.TriggerFullReset();
                        -- Now, let's add a brief delay, 3 seconds, to trigger sync again
                        C_Timer.After(3, GRMsync.Initialize);
                    end
                else
                    -- Report to player about Guild Leader restriction
                    GRM.ReportRankRestriction(rankIndex);
                end
            end
        end);
        RankButtons:Show();
        i = i + 1;
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu:SetHeight(
        height + 15);
end

-- Method:          DD.PopulateDefaultDropDownRankMenu()
-- What it Does:    Adds all the guild ranks to the drop down menu for custom default
-- Purpose:         UI Feature in options - greater control to keep custom note sync display on each character neat.
DD.PopulateDefaultDropDownRankMenu = function()
    -- populating the frames!
    local buffer = 3;
    local height = 0;
    local color2 = {0, 0.8, 1};
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu.Buttons or
            {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu
        .Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu.Buttons[i][1]:Hide();
    end

    local i = 1;
    for count = 1, GuildControlGetNumRanks() do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu
            .Buttons[i] then
            local tempButton = CreateFrame("Button", "rankIndex" .. i, GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                .GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu
                .Buttons[i] = {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local RankButtons = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_DefaultCustomRankDropDownMenu.Buttons[i][1];
        local RankButtonsText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                    .GRM_DefaultCustomRankDropDownMenu.Buttons[i][2];
        RankButtons:SetWidth(110);
        RankButtons:SetHeight(11);
        RankButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        RankButtonsText:SetText(GuildControlGetRankName(count));
        RankButtonsText:SetWidth(110);
        RankButtonsText:SetWordWrap(false);
        RankButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12);
        RankButtonsText:SetPoint("CENTER", RankButtons);
        RankButtonsText:SetJustifyH("CENTER");
        RankButtonsText:SetTextColor(color2[1], color2[2], color2[3], 1);

        if i == 1 then
            RankButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_DefaultCustomRankDropDownMenu, 0, -7);
            height = height + RankButtons:GetHeight();
        else
            RankButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_DefaultCustomRankDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + RankButtons:GetHeight() + buffer;
        end

        RankButtons:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelected:Show();
                local selectedRank = GRM.GetRankIndex(GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                                                          .GRM_SyncOptionsFrame.GRM_DefaultCustomSelectedText:GetText(),
                    self);
                local isRestricted, rankIndex = GRM.IsSyncRankGuildLeaderRestricted(4);

                -- Now, are they different? If they are different, that is a problem!
                if not isRestricted or CanEditGuildInfo() or (isRestricted and rankIndex == selectedRank) then

                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelectedText:SetText(
                        RankButtonsText:GetText());
                    GRM.S().syncRankCustom = selectedRank;
                    GRM.Global.UpdateGuildInfoWithNewValue(4, selectedRank, true);

                else
                    -- Report to player about Guild Leader restriction
                    GRM.ReportRankRestriction(rankIndex);
                end
            end
        end);
        RankButtons:Show();
        i = i + 1;
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu:SetHeight(
        height + 15);
end

-- VERY LIMITED SPECIFIC CASE USE
-- Method:          DD.CreateDD ( frame , fontstring , frame , int , string  int ,  array , function() )
-- What it Does:    It creates a dropdown menu given the specific variables
-- Purpose:         To create a generic, reusable dropdown menus
DD.CreateDD = function(SelectedFrame, Menu, fontSize, buttonHeight, fontModifier, textList, logic)
    -- populating the frames!
    local buffer = 3;
    local height = 0;
    Menu.Buttons = Menu.Buttons or {};

    -- Resetting the buttons!
    for i = 1, #Menu.Buttons do
        Menu.Buttons[i][1]:Hide();
    end

    for i = 1, #textList do
        if not Menu.Buttons[i] then
            local tempButton = CreateFrame("Button", Menu:GetName() .. "_" .. i, Menu);
            Menu.Buttons[i] = {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local RankButtons = Menu.Buttons[i][1];
        local RankButtonsText = Menu.Buttons[i][2];
        RankButtons:SetWidth(SelectedFrame:GetWidth() - 5);
        RankButtons:SetHeight(buttonHeight);
        RankButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        RankButtonsText:SetText(textList[i]);
        RankButtonsText:SetWidth(SelectedFrame:GetWidth() - 20);
        RankButtonsText:SetWordWrap(false);
        RankButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + fontSize, fontModifier);
        RankButtonsText:SetPoint("CENTER", RankButtons);
        RankButtonsText:SetJustifyH("CENTER");

        if i == 1 then
            RankButtons:SetPoint("TOP", Menu, 0, -7);
            height = height + RankButtons:GetHeight();
        else
            RankButtons:SetPoint("TOP", Menu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + RankButtons:GetHeight() + buffer;
        end

        RankButtons:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                logic(self, i, RankButtonsText);
            end
        end);
        RankButtons:Show();
    end
    Menu:SetHeight(height + 15);
end

-- Method:          DD.PopulateClassDropDownMenu()
-- What it Does:    Adds all the player CLASSES to the drop down menu
-- Purpose:         This is useful for player selection of the class when manually adding a player's info to the metadata, like adding someone to a ban list.
DD.PopulateClassDropDownMenu = function()
    -- populating the frames!
    local buffer = 3;
    local height = 0;
    GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons or {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons[i][1]:Hide();
    end

    local j = 1;

    for i = 1, #AllClasses do

        if (AllClasses[i] ~= "Deathknight" and AllClasses[i] ~= "Monk" and AllClasses[i] ~= "Demonhunter" and
            AllClasses[i] ~= "Evoker") or ((AllClasses[i] == "Deathknight" and GRM_G.BuildVersion >= 30000) or
            (AllClasses[i] == "Monk" and GRM_G.BuildVersion >= 50000) or
            (AllClasses[i] == "Demonhunter" and GRM_G.BuildVersion >= 70000) or
            (AllClasses[i] == "Evoker" and GRM_G.BuildVersion >= 100000)) then

            local class = string.upper(AllClasses[i]);
            local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class];

            if classColor then

                local className = GRM.GetClassName(class);

                if not GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu
                    .Buttons[i] then
                    local tempButton = CreateFrame("Button", "ClassButton" .. j, GRM_UI.GRM_RosterChangeLogFrame
                        .GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu);
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons[j] =
                        {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
                    if j == 1 then
                        GRM_G.DropDownHighlightLockIndex = 1;
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu
                            .Buttons[j][1]:LockHighlight();
                    end
                end

                local ClassButtons = GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                                         .GRM_AddBanDropDownMenu.Buttons[j][1];
                local ClassButtonsText = GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                                             .GRM_AddBanDropDownMenu.Buttons[j][2];

                ClassButtons:SetWidth(110);
                ClassButtons:SetHeight(11);
                ClassButtons:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
                ClassButtonsText:SetText(className);
                ClassButtonsText:SetTextColor(classColor.r, classColor.g, classColor.b, 1);
                ClassButtonsText:SetWidth(110);
                ClassButtonsText:SetWordWrap(false);
                ClassButtonsText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 10);
                ClassButtonsText:SetPoint("CENTER", ClassButtons);
                ClassButtonsText:SetJustifyH("CENTER");

                if j == 1 then
                    ClassButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                        .GRM_AddBanDropDownMenu, 0, -7);
                    height = height + ClassButtons:GetHeight();
                else
                    ClassButtons:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                        .GRM_AddBanDropDownMenu.Buttons[j - 1][1], "BOTTOM", 0, -buffer);
                    height = height + ClassButtons:GetHeight() + buffer;
                end

                ClassButtons:SetScript("OnClick", function(_, button)
                    if button == "LeftButton" then
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                            .GRM_AddBanDropDownClassSelectedText:SetText(ClassButtonsText:GetText());
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                            .GRM_AddBanDropDownClassSelectedText:SetTextColor(classColor.r, classColor.g, classColor.b,
                            1);
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu:Hide();
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                            .GRM_AddBanDropDownClassSelected:Show();
                        GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanReasonEditBox:SetFocus();
                        GRM_G.tempAddBanClass = class;
                    end
                end);
                ClassButtons:Show();
                j = j + 1;
            end
        end
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu:SetHeight(height + 15);
end

-- Method:          DD.PopulateDefaultTabDropdown()
-- What it Does:    Creates a dropdown menu including options to choose from the GRM tabs as to which is default
-- Purpose:         Quality of Life preference control option
DD.PopulateDefaultTabDropdown = function()
    local buffer = 3;
    local height = 0;
    local tabChoices = {GRM.L("LOG"), GRM.L("EVENTS"), GRM.L("BAN LIST"), GRM.L("SYNC USERS"),
                        string.upper(GRM.L("Options")), GRM.L("AUDIT")};

    -- Initiate the buttons holder
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu.Buttons or {};

    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu.Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu.Buttons[i][1]:Hide();
    end

    for i = 1, #tabChoices do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "DefaultTabButton" .. i, GRM_UI.GRM_RosterChangeLogFrame
                .GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local TabButton = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu
                              .Buttons[i][1];
        local TabButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                                  .GRM_DefaultTabMenu.Buttons[i][2];
        TabButton:SetWidth(105);
        TabButton:SetHeight(11);
        TabButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        TabButtonText:SetText(tabChoices[i]);
        TabButtonText:SetWidth(105);
        TabButtonText:SetWordWrap(false);
        TabButtonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9.5);
        TabButtonText:SetPoint("CENTER", TabButton);
        TabButtonText:SetJustifyH("CENTER");

        if i == 1 then
            TabButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_DefaultTabMenu, 0, -7);
            height = height + TabButton:GetHeight();
        else
            TabButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_DefaultTabMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + TabButton:GetHeight() + buffer;
        end

        TabButton:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                GRM.S().defaultTabSelection[2] = tonumber(string.match(self:GetName(), "%d+"));
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected
                    .GRM_DefaultTabSelectedText:SetText(TabButtonText:GetText());
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:Show();
            end
        end);
        TabButton:Show();
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabMenu:SetHeight(height + 15);
end

-- Method:          DD.PopulateLanguageDropdown()
-- What it Does:    Populates a dropdown select menu with all of the available languages to choose from...
-- Purpose:         To give the player the option to manually select and change which language the addon is using.
DD.PopulateLanguageDropdown = function()
    local buffer = 3;
    local height = 0;
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu.Buttons or {};

    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu
        .Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu.Buttons[i][1]:Hide();
    end

    for i = 1, #GRML.Languages do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "GRM_Language_" .. i, GRM_UI.GRM_RosterChangeLogFrame
                .GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local LangButton = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                               .GRM_LanguageDropDownMenu.Buttons[i][1];
        local LangButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                                   .GRM_LanguageDropDownMenu.Buttons[i][2];
        LangButton:SetWidth(110);
        LangButton:SetHeight(11);
        LangButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        LangButtonText:SetText(GRM.L(GRML.Languages[i]));
        LangButtonText:SetWidth(105);
        LangButtonText:SetWordWrap(false);
        LangButtonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 10);
        LangButtonText:SetPoint("CENTER", LangButton);
        LangButtonText:SetJustifyH("CENTER");

        if i == 1 then
            LangButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_LanguageDropDownMenu, 0, -7);
            height = height + LangButton:GetHeight();
        else
            LangButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_LanguageDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + LangButton:GetHeight() + buffer;
        end

        LangButton:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                local parsedNumber = tonumber(string.match(self:GetName(), "(%d+)"));
                GRM.S().selectedLang = parsedNumber;
                GRM_G.LocalizedIndex = parsedNumber;
                GRM.S().selectedFont = GRML.GetFontChoiceIndex(parsedNumber);
                GRML.SetNewLanguage(GRM.S().selectedLang, false, false);

                local HourFormat = {GRM.L("24 Hour"), GRM.L("12 Hour (am/pm)")};
                local tabChoices = {GRM.L("LOG"), GRM.L("EVENTS"), GRM.L("BAN LIST"), GRM.L("SYNC USERS"),
                                    string.upper(GRM.L("Options")), GRM.L("AUDIT")};

                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected
                    .GRM_LanguageSelectedText:SetText(GRM.L(GRML.Languages[parsedNumber]));
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected
                    .GRM_FontSelectedText:SetText(GRML.FontNames[GRM.S().selectedFont]);
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected
                    .GRM_FontSelectedText:SetFont(GRML.listOfFonts[GRM.S().selectedFont], GRM_G.FontModifier + 11);
                local month, day, year = select(2, GRM.Time.GetTodaysDate());
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected
                    .GRM_NonGlobalTimestampSelectedText:SetText(
                    GRM.Time.FormatTimeStamp({day, month, year}, false, false, GRM.S().dateFormat));
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected
                    .GRM_DefaultTabSelectedText:SetText(tabChoices[GRM.S().defaultTabSelection[2]]);
                if GRM.S().twentyFourHrScale then
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected
                        .GRM_24HrSelectedText:SetText(HourFormat[1]);
                else
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected
                        .GRM_24HrSelectedText:SetText(HourFormat[2]);
                end

                -- Macro Tool open
                if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame:IsVisible() then
                    local matchString = GRM.L("Click to Set");
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLog and
                        #GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg > 0 then
                        matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.customLogMsg;
                    end
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox:SetText(matchString);
                    GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_CustomLogMessageEditBox.stringPattern =
                        matchString;

                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.isMonths then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected
                            .GRM_TimeScaleSelectedText:SetText(GRM.L("Months"));
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_TimeScaleSelected
                            .GRM_TimeScaleSelectedText:SetText(GRM.L("Days"));
                    end
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rankSpecialIsMonths then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected
                            .GRM_KickEvenIfActiveTimeSelectedText:SetText(GRM.L("Months"));
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_KickEvenIfActiveTimeSelected
                            .GRM_KickEvenIfActiveTimeSelectedText:SetText(GRM.L("Days"));
                    end
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.repFilter then
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected
                            .GRM_GuildRepRanksSelectedText:SetText(
                            GRM.GetReputationTextLevel(GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep, true));
                    else
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_GuildRepRanksSelected
                            .GRM_GuildRepRanksSelectedText:SetText(
                            GRM.GetReputationTextLevel(GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.rep, false));
                    end
                    if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.noteMatch then
                        if GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString == "" then
                            matchString = GRM.L("Click to Set");
                        else
                            matchString = GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.rule.matchingString;
                        end

                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox:SetText(matchString);
                        GRM_UI.GRM_ToolCoreFrame.GRM_ToolCustomRulesFrame.GRM_NoteSearchEditBox.stringPattern =
                            matchString;
                    end
                end

                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:Show();
                GRM_UI.ElvUIReset = true;
                GRM_UI.ElvUIReset2 = true;
                -- Check the language count!
                local count = GRML.GetNumberUntranslatedLines(GRM.S().selectedLang);
                if GRM_G.Region == "enUS" then
                    count = count - 10;
                end
                if count > 0 and not GRML.TranslationStatusEnum[GRML.Languages[GRM.S().selectedLang]] then
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:SetText(
                        GRM.L("{num} phrases still need translation to {name}",
                            GRM.L(GRML.Languages[GRM.S().selectedLang]), nil, count));
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:Show();
                else
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageCountText:Hide();
                end

                if GRM.IsAddOnLoaded("AddOnSkins") then
                    GRM_UI.GRM_RosterChangeLogFrame:Hide();
                    GRM_UI.GRM_RosterChangeLogFrame:Show();
                    if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
                        GRM_UI.GRM_MemberDetailMetaData:Hide();
                        GRM_G.pause = true;
                        GRM_UI.GRM_MemberDetailMetaData:Show();
                    end
                end

                if parsedNumber == GRM_G.LocalizedIndex then
                    GRM.Report(GRM.L("Font has been Reset to DEFAULT."));
                end
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_ScanningOptionsFrame.GRM_LevelRange:SetText(
                    GRM.GetLevelRange());

                -- Let's reprocess the language!
                GRM.ReprocessAllLogEntriesToCurrentLanguage();

                if #GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons > 0 then
                    GRM.ResetLogStringPoints(GRM.S().showLineNumbers);
                end
            end
        end);
        LangButton:Show();
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageDropDownMenu:SetHeight(height +
                                                                                                                    15);
end

-- Method:          DD.PopulateFontDropdown()
-- What it Does:    Builds the font dropdown box
-- Purpose:         Give the user more customizability over the addon.
DD.PopulateFontDropdown = function()
    local buffer = 3;
    local height = 0;
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu.Buttons or {};

    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu.Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu.Buttons[i][1]:Hide();
    end

    for i = 1, #GRML.FontNames do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "GRM_Font" .. i, GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame
                .GRM_GeneralOptionsFrame.GRM_FontDropDownMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local FontButton = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu
                               .Buttons[i][1];
        local FontButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                                   .GRM_FontDropDownMenu.Buttons[i][2];
        local additionalModifier = 0;
        if i == 4 then -- China
            additionalModifier = 0.5;
        elseif i == 5 then -- Taiwan
            additionalModifier = 2;
        elseif i == 6 then -- Action Man
            additionalModifier = 1;
        elseif i == 7 then -- Ancient
            additionalModifier = 2;
        elseif i == 9 then -- Cardinal
            additionalModifier = 2;
        elseif i == 10 then -- Continuum
            additionalModifier = 1;
        elseif i == 11 then -- Espressway
            additionalModifier = 1;
        elseif i == 13 then -- PT Sans
            additionalModifier = 2;
        elseif i == 14 then -- Roboto
            additionalModifier = 1;
        end
        FontButton:SetWidth(110);
        FontButton:SetHeight(11);
        FontButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        FontButtonText:SetText(GRML.FontNames[i]);
        FontButtonText:SetWidth(105);
        FontButtonText:SetWordWrap(false);
        FontButtonText:SetFont(GRML.listOfFonts[i], GRM_G.FontModifier + additionalModifier + 10);
        FontButtonText:SetPoint("CENTER", FontButton);
        FontButtonText:SetJustifyH("CENTER");

        if i == 1 then
            FontButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_FontDropDownMenu, 0, -7);
            height = height + FontButton:GetHeight();
        else
            FontButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_FontDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + FontButton:GetHeight() + buffer;
        end

        FontButton:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                local parsedNumber = tonumber(string.match(self:GetName(), "(%d+)"));

                GRM.S().selectedFont = parsedNumber;
                GRML.SetNewFont(parsedNumber);
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected
                    .GRM_FontSelectedText:SetText(FontButtonText:GetText());
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected
                    .GRM_FontSelectedText:SetFont(GRML.listOfFonts[parsedNumber], GRM_G.FontModifier + 11);
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:Show();

                -- Additional frame check...
                GRM_UI.ElvUIReset = true;
                GRM_UI.ElvUIReset2 = true;
                if GRM.IsAddOnLoaded("AddOnSkins") then
                    GRM_UI.GRM_RosterChangeLogFrame:Hide();
                    GRM_UI.GRM_RosterChangeLogFrame:Show();
                    if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
                        GRM_UI.GRM_MemberDetailMetaData:Hide();
                        GRM_G.pause = true;
                        GRM_UI.GRM_MemberDetailMetaData:Show();
                    end
                end
            end
        end);
        FontButton:Show();
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontDropDownMenu:SetHeight(height + 15);
end

-- Method:          DD.PopulateTimestampFormatDropDown()
-- What it Does:    Builds a dropdown menu displaying the various format options
-- Purpose:         To give the player the ability to adjust timestamp formats
DD.PopulateTimestampFormatDropDown = function(nonGlobal)
    local buffer = 4;
    local height = 0;
    local dropDownMenu;
    local selectedFrame;
    local selectedText;
    local nameText = "";

    if nonGlobal then
        dropDownMenu = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                           .GRM_NonGlobalTimestampSelectedDropDownMenu;
        selectedFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                            .GRM_NonGlobalTimestampSelected;
        selectedText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                           .GRM_NonGlobalTimestampSelected.GRM_NonGlobalTimestampSelectedText;
        nameText = "GRM_timeStampNonGlobalButton"
    else
        dropDownMenu = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame
                           .GRM_TimestampSelectedDropDownMenu;
        selectedFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected;
        selectedText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected
                           .GRM_TimestampSelectedText;
        nameText = "GRM_timeStampButton"
    end

    dropDownMenu.Buttons = dropDownMenu.Buttons or {};

    for i = 1, #dropDownMenu do
        dropDownMenu.Buttons[i][1]:Hide();
    end

    local month, day, year = select(2, GRM.Time.GetTodaysDate());

    for i = 1, 17 do
        if not dropDownMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", nameText .. i, dropDownMenu);
            dropDownMenu.Buttons[i] = {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end
        local timeStampButton = dropDownMenu.Buttons[i][1];
        local timeStampButtonText = dropDownMenu.Buttons[i][2];
        timeStampButton:SetWidth(110);
        timeStampButton:SetHeight(11);
        timeStampButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        timeStampButtonText:SetText(GRM.Time.FormatTimeStamp({day, month, year}, false, false, i));
        timeStampButtonText:SetWidth(105);
        timeStampButtonText:SetWordWrap(false);
        timeStampButtonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
        timeStampButtonText:SetPoint("CENTER", timeStampButton, 5, 0);
        timeStampButtonText:SetJustifyH("LEFT");

        if i == 1 then
            timeStampButton:SetPoint("TOP", dropDownMenu, 0, -7);
            height = height + timeStampButton:GetHeight();
        else
            timeStampButton:SetPoint("TOP", dropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + timeStampButton:GetHeight() + buffer;
        end

        if nonGlobal then
            timeStampButton:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then
                    local parsedNumber = tonumber(string.match(self:GetName(), "(%d+)"));

                    GRM.S().dateFormat = parsedNumber;
                    -- if not GRM.IsSyncRankGuildLeaderRestricted then
                    --     GRM.S().globalDateFormat = parsedNumber;  -- Set global if not set.

                    -- end
                    GRM.ReprocessAllLogEntriesToCurrentLanguage();
                    selectedText:SetText(timeStampButtonText:GetText());
                    dropDownMenu:Hide();
                    selectedFrame:Show();
                end
            end);
        else
            timeStampButton:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then
                    local parsedNumber = tonumber(string.match(self:GetName(), "(%d+)"));

                    GRM.S().globalDateFormat = parsedNumber;
                    GRM.Global.UpdateGuildInfoWithNewValue(1, parsedNumber, true);
                    GRM.ReprocessAllLogEntriesToCurrentLanguage();

                    selectedText:SetText(timeStampButtonText:GetText());
                    dropDownMenu:Hide();
                    selectedFrame:Show();
                end
            end);
        end
        timeStampButton:Show();
    end
    if nonGlobal then
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
            .GRM_NonGlobalTimestampSelectedDropDownMenu:SetHeight(height + 15);
    else
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelectedDropDownMenu:SetHeight(
            height + 15);
    end
end

-- Method:          DD.Populate24HrDropDown()
-- What it Does:    Builds the 2 options in 24 hr timescale vs 12 hr
-- Purpose:         To give the player the option to set it to a 12hr scale or 24hr scale.
DD.Populate24HrDropDown = function()
    local buffer = 4;
    local height = 0;
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu.Buttons or
            {};

    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu
        .Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu.Buttons[i][1]:Hide();
    end

    local HourFormat = {GRM.L("24 Hour"), GRM.L("12 Hour (am/pm)")};

    for i = 1, 2 do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu
            .Buttons[i] then
            local tempButton = CreateFrame("Button", "GRM_HrButton" .. i, GRM_UI.GRM_RosterChangeLogFrame
                .GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu
                .Buttons[i] = {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end
        local HrButton = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                             .GRM_24HrSelectedDropDownMenu.Buttons[i][1];
        local HrButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                                 .GRM_24HrSelectedDropDownMenu.Buttons[i][2];
        HrButton:SetWidth(110);
        HrButton:SetHeight(11);
        HrButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        HrButtonText:SetText(HourFormat[i]);
        HrButtonText:SetWidth(105);
        HrButtonText:SetWordWrap(false);
        HrButtonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
        HrButtonText:SetPoint("CENTER", HrButton);
        HrButtonText:SetJustifyH("CENTER");

        if i == 1 then
            HrButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_24HrSelectedDropDownMenu, 0, -7);
            height = height + HrButton:GetHeight();
        else
            HrButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame
                .GRM_24HrSelectedDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + HrButton:GetHeight() + buffer;
        end

        HrButton:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                local parsedNumber = tonumber(string.match(self:GetName(), "(%d+)"));

                if parsedNumber == 1 then
                    GRM.S().twentyFourHrScale = true;
                else
                    GRM.S().twentyFourHrScale = false;
                end
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected
                    .GRM_24HrSelectedText:SetText(HrButtonText:GetText());
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:Show();
                GRM.ReprocessAllLogEntriesToCurrentLanguage();
            end
        end);
        HrButton:Show();
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelectedDropDownMenu:SetHeight(
        height + 15);
end

-- Method:          DD.CreateOptionsRankDropDown()
-- What it Does:    Builds the final rank drop down product for options panel
-- Purpose:         UI Feature for options to be able to filter who you will accept shared data from.
DD.CreateOptionsRankDropDown = function()
    DD.PopulateOptionsRankDropDown();
    DD.PopulateBanListOptionsDropDown();
    DD.PopulateDefaultDropDownRankMenu();

    local numRanks = GuildControlGetNumRanks() - 1;
    local HourFormat = {GRM.L("24 Hour"), GRM.L("12 Hour (am/pm)")};
    local tabChoices = {GRM.L("LOG"), GRM.L("EVENTS"), GRM.L("BAN LIST"), GRM.L("SYNC USERS"),
                        string.upper(GRM.L("Options")), GRM.L("AUDIT")};

    -- General sync restriction
    if GRM.S().syncRank > numRanks then -- There's been a change since the player last logged in...
        GRM.S().syncRank = numRanks;
        GRM.Global.UpdateGuildInfoWithNewValue(2, numRanks, true);
    end
    -- Ban List Sync restriction
    if GRM.S().syncRankBanList > numRanks then -- There's been a change since the player last logged in...
        GRM.S().syncRankBanList = numRanks;
        GRM.Global.UpdateGuildInfoWithNewValue(3, numRanks, true);
    end
    -- Custom Note Sync Restriction
    if GRM.S().syncRankCustom > numRanks then -- There's been a change since the player last logged in...
        GRM.S().syncRankCustom = numRanks;
        GRM.Global.UpdateGuildInfoWithNewValue(4, numRanks, true);
    end

    local setRankName = GuildControlGetRankName(GRM.S().syncRank + 1);
    local setRankNameBanList = GuildControlGetRankName(GRM.S().syncRankBanList + 1);
    local setCustomDefaultName = GuildControlGetRankName(GRM.S().syncRankCustom + 1);

    if setRankName == nil or setRankName == "" then
        setRankName = GuildControlGetRankName(1) -- Default it to guild leader. This scenario could happen if the rank was removed or you change guild but still have old settings.
    end
    if setRankNameBanList == nil or setRankNameBanList == "" then
        setRankNameBanList = GuildControlGetRankName(1) -- Default it to guild leader. This scenario could happen if the rank was removed or you change guild but still have old settings.
    end

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelectedText:SetText(
        setRankName);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelectedText:SetText(
        setRankNameBanList);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelectedText:SetText(
        setCustomDefaultName);

    local TagText = GRM.GetMainTags(false, GRM.S().mainTagIndex);
    if TagText == "" then
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetText(
            GRM.L("No Tag"));
    else
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetText(
            TagText);
    end

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetTextColor(
        GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b, 1);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected
        .GRM_LanguageSelectedText:SetText(GRM.L(GRML.Languages[GRM.S().selectedLang]));

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame
        .GRM_OptionsTexture:SetColorTexture(GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b, 1);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected.GRM_FontSelectedText:SetFont(
        GRM_G.FontChoice, GRM_G.FontModifier + 11);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected.GRM_FontSelectedText:SetText(
        GRML.FontNames[GRM.S().selectedFont]);
    local month, day, year = select(2, GRM.Time.GetTodaysDate());
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected
        .GRM_TimestampSelectedText:SetText(GRM.Time.FormatTimeStamp({day, month, year}, false, false,
        GRM.S().globalDateFormat));
    if GRM.S().twentyFourHrScale then
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText:SetText(
            HourFormat[1]);
    else
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected.GRM_24HrSelectedText:SetText(
            HourFormat[2]);
    end

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected
        .GRM_DefaultTabSelectedText:SetText(tabChoices[GRM.S().defaultTabSelection[2]]);
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected
        .GRM_NonGlobalTimestampSelectedText:SetText(GRM.Time.FormatTimeStamp({day, month, year}, false, false,
        GRM.S().dateFormat));

    -- Now that initial values set, let's display them!
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_LanguageSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_FontSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_24HrSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_DefaultTabSelected:Show();
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_NonGlobalTimestampSelected:Show();
end

-- Method:          DD.PopulateMainTagDropdown()
-- What it Does:    Creates a dropdown menu including options to choose from for main tag formatting in guild chat
-- Purpose:         Options, options, options! Customization to make it pleasing for all players in the formatting.
DD.PopulateMainTagDropdown = function()
    local buffer = 3;
    local height = 0;
    local tagChoices = GRM.GetMainTags(true);
    -- Initiate the buttons holder
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons =
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons or {};

    for i = 1, #GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons do
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons[i][1]:Hide();
    end

    for i = 1, #tagChoices do
        if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "MainTagOption" .. i, GRM_UI.GRM_RosterChangeLogFrame
                .GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu);
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local TagButton = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu
                              .Buttons[i][1];
        local TagButtonText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons[i][2];
        TagButton:SetWidth(85);
        TagButton:SetHeight(11);
        TagButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
        if i == 7 then
            TagButtonText:SetText(GRM.L("No Tag"));
        else
            TagButtonText:SetText(tagChoices[i]);
        end
        TagButtonText:SetTextColor(GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b, 1);
        TagButtonText:SetWidth(85);
        TagButtonText:SetWordWrap(false);
        TagButtonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 10);
        TagButtonText:SetPoint("CENTER", TagButton);
        TagButtonText:SetJustifyH("CENTER");

        if i == 1 then
            TagButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu, 0, -7);
            height = height + TagButton:GetHeight();
        else
            TagButton:SetPoint("TOP", GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + TagButton:GetHeight() + buffer;
        end

        TagButton:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                local parsedNumber = tonumber(string.match(self:GetName(), "(%d+)"));

                GRM.S().mainTagIndex = parsedNumber;
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected
                    .GRM_TagText:SetText(TagButtonText:GetText());
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected
                    .GRM_TagText:SetTextColor(GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b, 1);
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:Show();

                GRM_G.mainTag = GRM.GetCurrentMainTag();
                GRM_G.altTag = GRM.GetCurrentAltTag();
                GRM_UI.UpdateTagOptionsText();
            end
        end);
        TagButton:Show();
    end
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:SetHeight(height + 15);
end