-- Method:          GRM.GetAuditEntries ()
-- What it Does:    Determines which grouping to import for sorted Audit list
-- Purpose:         Audit UX feature controls for sorting.
GRM.GetAuditEntries = function()
    local typeOfSort = GRM_G.AuditSortType;
    local result = {};
    if typeOfSort == nil or typeOfSort == 1 then
        result = GRM.GetAllGuildiesInOrder(true, true);
    elseif typeOfSort == 2 then
        result = GRM.GetAllGuildiesInOrder(true, false);
    elseif typeOfSort == 3 then
        result = GRM.GetAllGuildiesInJoinDateOrder(true, true);
    elseif typeOfSort == 4 then
        result = GRM.GetAllGuildiesInJoinDateOrder(true, false);
    elseif typeOfSort == 5 then
        result = GRM.GetAllGuildiesInPromoDateOrder(true, true);
    elseif typeOfSort == 6 then
        result = GRM.GetAllGuildiesInPromoDateOrder(true, false);
    elseif typeOfSort == 7 then
        result = GRM.GetAllMainsAndAltsInOrder(true);
    elseif typeOfSort == 8 then
        result = GRM.GetAllMainsAndAltsInOrder(false);
    elseif typeOfSort == 9 then
        result = GRM.GetAllGuildiesByBirthdayDateOrder(true, true);
    elseif typeOfSort == 10 then
        result = GRM.GetAllGuildiesByBirthdayDateOrder(true, false);
    end
    return result;
end

-- Method:          GRM.GetAutoCompleteNamesForAudit ( string )
-- What it Does:    Updates the audit list to be shown as those to match the search box
-- Purpose:         Search for guildies
GRM.GetAutoCompleteNamesForAudit = function(searchString)
    local matches = GRM.GetAutoCompleteMatches(GRM.GetAllCurrentAndFormerGuildies(true, false), searchString)
    local listOfGuildies = {};
    local isComplete = true;
    local joinDate = "";
    local promoDate = "";
    local mainStatus = "";
    local classColors = {};
    local birthDate = "";

    for i = 1, #matches do
        -- proper name format
        joinDate, promoDate, mainStatus, isComplete, classColors, birthDate = GRM.GetAuditLinePlayervalues(
            matches[i][1], isComplete);

        table.insert(listOfGuildies, {matches[i][1], joinDate, promoDate, mainStatus, classColors, birthDate});
    end

    sort(listOfGuildies, function(a, b)
        return a[1] < b[1]
    end);

    return listOfGuildies
end

-- Method:          GRM.SetAuditValues ( int , int )
-- What it Does:    Builds the values of the given line in the audit window
-- Purpose:         Quality of life feature.
GRM.SetAuditValues = function(ind, ind2)
    local line = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind];
    local ok = {0, 0.77, 0.063};
    local notOk = {0.64, 0.102, 0.102};
    local unknown = {1.0, 0.647, 0};
    local color = {};

    local getColor = function(text)
        local result = {};
        if text == GRM.L("No Date Set") or text == GRM.L("Main or Alt?") then
            result = notOk;
        elseif text == GRM.L("Unknown") then
            result = unknown;
        else
            result = ok;
        end
        return result;
    end

    -- Player Name
    line[2]:SetText(GRM_G.AuditEntries[ind2][1]);
    line[2]:SetTextColor(GRM_G.AuditEntries[ind2][5][1], GRM_G.AuditEntries[ind2][5][2], GRM_G.AuditEntries[ind2][5][3],
        1);

    -- Join Date
    line[3]:SetText(GRM_G.AuditEntries[ind2][2]);
    color = getColor(GRM_G.AuditEntries[ind2][2]);
    line[3]:SetTextColor(color[1], color[2], color[3]);

    -- Promotion Date
    line[4]:SetText(GRM_G.AuditEntries[ind2][3]);
    color = getColor(GRM_G.AuditEntries[ind2][3]);
    line[4]:SetTextColor(color[1], color[2], color[3]);

    -- Birthdate
    line[5]:SetText(GRM_G.AuditEntries[ind2][6]);
    color = getColor(GRM_G.AuditEntries[ind2][6]);
    line[5]:SetTextColor(color[1], color[2], color[3]);

    -- Main/Alt Status
    line[6]:SetText(GRM_G.AuditEntries[ind2][4]);
    color = getColor(GRM_G.AuditEntries[ind2][4]);
    line[6]:SetTextColor(color[1], color[2], color[3]);

    -- Update the tooltip if underlying data changes
    if GameTooltip:IsVisible() and
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][1]:IsMouseOver() then
        GRM.UpdateAuditTooltip(ind);
    end
end

-- Method:          GRM.AuditHybridShiftDown()
-- What it Does:    Shifts all the values DOWN one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.AuditHybridShiftDown = function()
    if #GRM_G.AuditEntries > 16 then
        local buttons = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons;
        local MouseOverButton = 0;

        -- Shift them down...
        for i = 1, #buttons - 1 do

            -- Header Line
            buttons[i][2]:SetText(buttons[i + 1][2]:GetText());
            buttons[i][2]:SetTextColor(buttons[i + 1][2]:GetTextColor(buttons[i + 1][2]:GetText()));
            buttons[i][3]:SetText(buttons[i + 1][3]:GetText());
            buttons[i][3]:SetTextColor(buttons[i + 1][3]:GetTextColor(buttons[i + 1][3]:GetText()));
            buttons[i][4]:SetText(buttons[i + 1][4]:GetText());
            buttons[i][4]:SetTextColor(buttons[i + 1][4]:GetTextColor(buttons[i + 1][4]:GetText()));
            buttons[i][5]:SetText(buttons[i + 1][5]:GetText());
            buttons[i][5]:SetTextColor(buttons[i + 1][5]:GetTextColor(buttons[i + 1][5]:GetText()));
            buttons[i][6]:SetText(buttons[i + 1][6]:GetText());
            buttons[i][6]:SetTextColor(buttons[i + 1][6]:GetTextColor(buttons[i + 1][6]:GetText()));

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.AuditSetLastValue();
        if MouseOverButton > 0 then
            GRM.UpdateAuditTooltip(MouseOverButton);
        end
    end
end

-- Method:          GRM.AuditHybridShiftUp()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.AuditHybridShiftUp = function()
    if #GRM_G.AuditEntries > 16 then
        local buttons = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons;
        local MouseOverButton = 0;

        for i = #buttons, 2, -1 do

            buttons[i][2]:SetText(buttons[i - 1][2]:GetText());
            buttons[i][2]:SetTextColor(buttons[i - 1][2]:GetTextColor(buttons[i - 1][2]:GetText()));
            buttons[i][3]:SetText(buttons[i - 1][3]:GetText());
            buttons[i][3]:SetTextColor(buttons[i - 1][3]:GetTextColor(buttons[i - 1][3]:GetText()));
            buttons[i][4]:SetText(buttons[i - 1][4]:GetText());
            buttons[i][4]:SetTextColor(buttons[i - 1][4]:GetTextColor(buttons[i - 1][4]:GetText()));
            buttons[i][5]:SetText(buttons[i - 1][5]:GetText());
            buttons[i][5]:SetTextColor(buttons[i - 1][5]:GetTextColor(buttons[i - 1][5]:GetText()));
            buttons[i][6]:SetText(buttons[i - 1][6]:GetText());
            buttons[i][6]:SetTextColor(buttons[i - 1][6]:GetTextColor(buttons[i - 1][6]:GetText()));

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.AuditSetFirstValue();
        if MouseOverButton > 0 then
            GRM.UpdateAuditTooltip(MouseOverButton);
        end
    end
end

-- Method:          GRM.AuditSetLastValue()
-- What it Does:    Sets the last value of the hybridscrollframe backups at position 16
-- Purpose:         Clean scrolling
GRM.AuditSetLastValue = function()
    GRM.SetAuditValues(#GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons,
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset);
end

-- Method:          GRM.AuditSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe backups at position 1
-- Purpose:         Clean scrolling
GRM.AuditSetFirstValue = function()
    GRM.SetAuditValues(1, GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset -
        #GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons + 1);
end

-- Method:          GRM.UpdateAuditTooltip()
-- What it Does:    Sets the tooltip for the audit window
-- Purpose:         Make it clear the QoL controls.
GRM.UpdateAuditTooltip = function(ind)
    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner(
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][1],
        "ANCHOR_CURSOR");
    GameTooltip:AddLine(GRM.GetClassifiedName(GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame
                                                  .AllAuditButtons[ind][2]:GetText(), false));

    GameTooltip:AddLine(GRM.L("{custom1} to open Player Window", nil, nil, nil,
        "|CFFE6CC7F" .. GRM.L("Ctrl-Click") .. "|r"));
    GameTooltip:AddLine(GRM.L("{custom1} to Search the Log for Player", nil, nil, nil,
        "|CFFE6CC7F" .. GRM.L("Ctrl-Shift-Click") .. "|r"));
    GameTooltip:AddLine(GRM.L("{custom1} for Additional Options", nil, nil, nil,
        "|CFFE6CC7F" .. GRM.L("Right-Click") .. "|r"));

    -- Check for the tag
    if string.find(
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][3]:GetText(),
        "!!", 1, true) ~= nil or
        string.find(
            GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][4]:GetText(),
            "!!", 1, true) ~= nil then
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine(GRM.L("The {name} tag indicates a date must be verified to sync", "|CFFFF0000!!|r"));
        GameTooltip:AddLine(GRM.L(
            "To confirm or edit the date, open the player window, right click the date, edit, and submit"));
    end
    GameTooltip:Show();
end

-- Method:          GRM.RefreshAuditFrames( bool , bool )
-- What it Does:    Updates the audit frames when called
-- Purpose:         Audit frames are useful so the leader or player can do an easy visual check of the entire guild on what is needed.
GRM.RefreshAuditFrames = function(showAll, fullRefresh, searchString)
    local hybridScrollFrameButtonCount = 17;
    local buttonHeight = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollFrame:GetHeight() / 17;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollFrame:GetWidth() - 5;

    if showAll and fullRefresh then
        GRM_G.AuditEntries = GRM.GetAuditEntries();
        GRM_G.AuditEntryTotals = GRM.GetIncompleteGuildDataCounts();
        -- numBdayUnknown , numBdayNoDate

        -- Only show the "complete" guildies in the list.
        if GRM.S().onlyShowIncomplete then
            local isFound;
            for i = #GRM_G.AuditEntries, 1, -1 do
                isFound = false;
                for j = 1, #GRM_G.AuditEntryTotals[6] do
                    if GRM_G.AuditEntryTotals[6][j] == GRM_G.AuditEntries[i][1] then
                        isFound = true;
                        break
                    end
                end
                if not isFound then
                    table.remove(GRM_G.AuditEntries, i);
                end
            end
        end
    elseif not showAll then
        GRM_G.AuditEntries = GRM.GetAutoCompleteNamesForAudit(searchString);
    end

    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons =
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons or {};
    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset =
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset or
            (hybridScrollFrameButtonCount);

    if GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset < hybridScrollFrameButtonCount then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset = hybridScrollFrameButtonCount;
    elseif GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset >
        hybridScrollFrameButtonCount and GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset >
        #GRM_G.AuditEntries then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset = #GRM_G.AuditEntries;
    end

    for i = 1, #GRM_G.AuditEntries do
        -- Build HybridScrollFrame Buttons
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[i] then

                local button = CreateFrame("Button", "GRMAuditCoreButton_" .. i,
                    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame);
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[i] = {button,
                                                                                                               button:CreateFontString(
                    nil, "OVERLAY", "GameFontWhiteTiny"), button:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                                                                                                               button:CreateFontString(
                    nil, "OVERLAY", "GameFontWhiteTiny"), button:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                                                                                                               button:CreateFontString(
                    nil, "OVERLAY", "GameFontWhiteTiny")};

                button = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[i][1];
                if i == 1 then
                    button:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame,
                        "TOP", 0, 0);
                else
                    button:SetPoint("TOPLEFT", GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame
                        .AllAuditButtons[i - 1][1], "BOTTOMLEFT", 0, 0);
                end

                button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
                button:SetSize(buttonWidth, buttonHeight);
                GRM.BuildAuditScrollButtons(i);

            end
        end

        if i >=
            (GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset -
                hybridScrollFrameButtonCount + 1) and i <=
            GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset then
            GRM.SetAuditValues(i -
                                   (GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset -
                                       hybridScrollFrameButtonCount), i);
            GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[i -
                (GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.Offset -
                    hybridScrollFrameButtonCount)][1]:Show();
        end

        -- Slider Height is controlled by tallying how many of these are necessary
        scrollHeight = scrollHeight + buttonHeight;
    end

    -- Hide unused buttons...
    for i = #GRM_G.AuditEntries + 1, #GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame
        .AllAuditButtons do
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[i][1]:Hide();
    end

    GRM_UI.SetHybridScrollFrameSliderParameters(GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame,
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollFrame, GRM_UI.GRM_CoreFrame
            .GRM_AuditFrame.GRM_AuditScrollFrameSlider, buttonWidth, buttonHeight, scrollHeight, #GRM_G.AuditEntries,
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons,
        GRM.AuditHybridShiftDown, GRM.AuditHybridShiftUp, hybridScrollFrameButtonCount);

    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditFrameText5:SetText(GRM.L(
        "Total Incomplete: {num} / {custom1}", nil, nil, GRM_G.AuditEntryTotals[5], GRM.G_Util.GetNumGuildies()));
    GRM_UI.ScaleFontStringToObjectSize(true, 190, GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditFrameText5, 2);
    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditFrameText5:Show();
    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditFrameText8:SetText(
        GRM.L("Mains:\n{num}", nil, nil, GRM.GetNumMains()));
    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditFrameText8:Show();
    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditFrameText7:SetText(
        GRM.L("Unique Accounts:\n{num}", nil, nil, GRM_G.numAccounts));
    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditFrameText7:Show();
    if (GRM_G.AuditEntryTotals[1] + GRM_G.AuditEntryTotals[2]) == 0 then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetJoinUnkownButton.GRM_SetJoinUnkownButtonText:SetText(
            GRM.L("All Complete"));
    elseif GRM_G.AuditEntryTotals[2] > 0 then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetJoinUnkownButton.GRM_SetJoinUnkownButtonText:SetText(
            GRM.L("Set Incomplete to Unknown"));
    else
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetJoinUnkownButton.GRM_SetJoinUnkownButtonText:SetText(
            GRM.L("Clear All Unknown"));
    end

    if (GRM_G.AuditEntryTotals[3] + GRM_G.AuditEntryTotals[4]) == 0 then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetPromoUnkownButton.GRM_SetPromoUnkownButtonText:SetText(
            GRM.L("All Complete"));
    elseif GRM_G.AuditEntryTotals[4] > 0 then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetPromoUnkownButton.GRM_SetPromoUnkownButtonText:SetText(
            GRM.L("Set Incomplete to Unknown"));
    else
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetPromoUnkownButton.GRM_SetPromoUnkownButtonText:SetText(
            GRM.L("Clear All Unknown"));
    end

    if (GRM_G.AuditEntryTotals[7] + GRM_G.AuditEntryTotals[8]) == 0 then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetBdayUnkownButton.GRM_SetBdayUnkownButtonText:SetText(
            GRM.L("All Complete"));
    elseif GRM_G.AuditEntryTotals[8] > 0 then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetBdayUnkownButton.GRM_SetBdayUnkownButtonText:SetText(
            GRM.L("Set Incomplete to Unknown"));
    else
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_SetBdayUnkownButton.GRM_SetBdayUnkownButtonText:SetText(
            GRM.L("Clear All Unknown"));
    end

    if GRM.S().includeBirthdaysInAudit then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditBirthdayToggleButton:SetChecked(true);
    end

    if GRM.GetNumUnverifiedJoinDates() > 0 and GRM.CanEditOfficerNote() then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_VerifyAllJoinButton:Show();
    else
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_VerifyAllJoinButton:Hide();
    end

    if GRM.GetNumUnverifiedPromoDates() > 0 and GRM.CanEditOfficerNote() then
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_VerifyAllRankButton:Show();
    else
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_VerifyAllRankButton:Hide();
    end

    GRM_UI.RefreshAuditTab(GRM_UI.GRM_CoreFrame.GRM_GuildAuditTab);
end

-- Method:          GRM.UnlockAuditButtonHighlights ( object )
-- What it Does:    Unlocks all button highlights not clicked
-- Purpose:         UX
GRM.UnlockAuditButtonHighlights = function()
    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons do
        GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[i][1]:UnlockHighlight();
    end
end

-- Method:          GRM.BuildAuditScrollButtons ( int )
-- What it Does:    Initiates the buttons and their values for each line of the audit hybridscrollframe
-- Purpose:         Create a smooth scrolling experience in the audit window
GRM.BuildAuditScrollButtons = function(ind, isResizeAction)
    local coreButton = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][2];
    local buttonText2 = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][3];
    local buttonText3 = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][4];
    local buttonText4 = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][5];
    local buttonText5 = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][6];

    -- 566 width

    -- Name
    buttonText1:SetPoint("LEFT", coreButton, "LEFT", 5, 0);
    buttonText1:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
    buttonText1:SetJustifyH("LEFT");
    buttonText1:SetWidth(142)
    buttonText1:SetWordWrap(false);

    -- Join Date
    buttonText2:SetPoint("LEFT", buttonText1, "RIGHT", 0, 0);
    buttonText2:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
    buttonText2:SetWidth(105);
    buttonText2:SetJustifyH("CENTER");
    buttonText2:SetWordWrap(false);

    -- Promo Date
    buttonText3:SetPoint("LEFT", buttonText2, "RIGHT", 0, 0);
    buttonText3:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
    buttonText3:SetWidth(105);
    buttonText3:SetJustifyH("CENTER");
    buttonText3:SetWordWrap(false);

    -- Birthday
    buttonText4:SetPoint("LEFT", buttonText3, "RIGHT", 0, 0);
    buttonText4:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
    buttonText4:SetWidth(105);
    buttonText4:SetJustifyH("CENTER");
    buttonText4:SetWordWrap(false);

    -- Main/Alt
    buttonText5:SetPoint("LEFT", buttonText4, "RIGHT", -10, 0);
    buttonText5:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
    buttonText5:SetWidth(105);
    buttonText5:SetJustifyH("CENTER");
    buttonText5:SetWordWrap(false);

    if not isResizeAction then

        coreButton:EnableMouse(true);
        coreButton:RegisterForDrag("LeftButton");

        -- Setup draggable conditions
        coreButton:SetScript("OnDragStart", function()
            GRM_UI.GRM_CoreFrame:StartMoving();
        end);
        coreButton:SetScript("OnDragStop", function()
            GRM_UI.GRM_CoreFrame:StopMovingOrSizing();
            GRM_UI.SaveCorePosition();
        end);

        coreButton:SetScript("OnMouseDown", function(self, button)
            local playerName =
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditScrollChildFrame.AllAuditButtons[ind][2]:GetText();

            if button == "LeftButton" then
                if IsControlKeyDown() then
                    if IsShiftKeyDown() then
                        GRM.RestoreTooltip();
                        GRM_UI.GRM_CoreFrame.GRM_LogTab:Click();
                        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox:SetText(GRM.SlimName(playerName));
                    else
                        GRM.OpenPlayerWindow(playerName);
                    end
                end

            elseif button == "RightButton" then
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame.name = playerName;
                GRM.RestoreTooltip();

                local buttonMsg = "";

                local player = GRM.GetPlayer(playerName);
                if player then
                    if not GRM.IsMain(player.name) then
                        buttonMsg = GRM.L("Set as Main");
                    else
                        buttonMsg = GRM.L("Set as Alt");
                    end
                end

                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame
                    .GRM_AuditWindowDropDownFrameText:SetText(GRM.GetClassifiedName(playerName, false));
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame
                    .GRM_AuditWindowDropDownAltMainButton.GRM_AuditWindowDropDownAltMainButtonText:SetText(buttonMsg);
                local size = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame
                                 .GRM_AuditWindowDropDownFrameText:GetWidth() + 25;

                if size < 110 then
                    size = 110;
                end

                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:SetWidth(size);
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:ClearAllPoints();
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:SetPoint("LEFT", self,
                    "RIGHT", -15, 0);

                size = GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:GetWidth();
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame
                    .GRM_AuditWindowDropDownAltMainButton:SetWidth(
                    GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:GetWidth() - 15);
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame
                    .GRM_AuditWindowDropDownCancelButton:SetWidth(size - 5);
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:Show();

                GRM.UnlockAuditButtonHighlights();
                self:LockHighlight();
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:SetScript("OnHide",
                    function()
                        self:UnlockHighlight();
                    end);

            end
        end);

        coreButton:SetScript("OnEnter", function()
            GRM.UpdateAuditTooltip(ind);
        end);

        coreButton:SetScript("OnLeave", function()
            GRM.RestoreTooltip();
        end);
    end
end

-- Method:          GRM.GetIncompleteGuildDataCounts()
-- What it Does:    Scans over the guild for audit and retrieves the data on what is and is not missing. This is to be used for audit reporting
-- Purpose:         For player info and better control over their guild's data completeness...
GRM.GetIncompleteGuildDataCounts = function()
    local numJoinUnknown = 0;
    local numJoinNoDate = 0;
    local numPromoUnknown = 0;
    local numPromoNoDate = 0;
    local numBdayNoDate, numBdayUnknown = 0, 0;
    local count2 = 0; -- This is the overall count of how many "incomplete"
    local isComplete = true;
    local listOfIncompleteNames = {};
    local guildData = GRM.GetGuild();

    for _, player in pairs(guildData) do
        if type(player) == "table" then
            isComplete = true;

            if not player.joinDateHist[1][6] then
                if player.joinDateUnknown then
                    numJoinUnknown = numJoinUnknown + 1;
                    if GRM.S().unknownIsComplete then
                        isComplete = false;
                    end
                else
                    numJoinNoDate = numJoinNoDate + 1;
                    isComplete = false;
                end
            end

            -- Promo Date
            if not player.rankHist[1][7] then
                if player.promoteDateUnknown then
                    numPromoUnknown = numPromoUnknown + 1;
                    if GRM.S().unknownIsComplete then
                        isComplete = false;
                    end
                else
                    numPromoNoDate = numPromoNoDate + 1;
                    isComplete = false;
                end
            end

            -- Birthdays
            local birthdayInfo = GRM.GetBirthday ( player );
            if birthdayInfo.date[1] == 0 then
                if birthdayInfo.unknown then
                    numBdayUnknown = numBdayUnknown + 1;
                    if GRM.S().unknownIsComplete and GRM.S().includeBirthdaysInAudit then
                        isComplete = false;
                    end
                else
                    numBdayNoDate = numBdayNoDate + 1;
                    if GRM.S().includeBirthdaysInAudit then
                        isComplete = false;
                    end
                end
            end

            local altGroup = GRM.GetAltGroup(player.altGroup);

            if (not GRM.IsMain(player.name) and not altGroup) or (altGroup and altGroup.main == "") then
                isComplete = false;
            end

            if not isComplete or not GRM.S().onlyShowIncomplete then
                if not isComplete then
                    count2 = count2 + 1;
                    table.insert(listOfIncompleteNames, player.name);
                end
            end
        end
    end
    return {numJoinUnknown, numJoinNoDate, numPromoUnknown, numPromoNoDate, count2, listOfIncompleteNames,
            numBdayUnknown, numBdayNoDate};
end

-- Method:          GRM.AuditRefresh()
-- What it Does:    Refreshes and updates all the frames in the audit JD tool
-- Purpose:         Easy refresh management for UX
GRM.AuditRefresh = function(fullRefresh)
    if GRM.S().JDAuditToolFilter then
        GRM_UI.GRM_AuditJDTool.GRM_AuditJDToolCheckBox:SetChecked(true);
    end

    if GRM_G.BuildHasRestrictions and GRM.S().JDAuditToolIgnoreProtected then
        GRM_UI.GRM_AuditJDTool.GRM_AuditJDToolIgnoreProtectedButton:SetChecked(true);
    end


    GRM.RefreshJDAuditToolFrames(not GRM.S().JDAuditToolFilter, fullRefresh);
end

-- Method:          GRM.GetAuditLinePlayervalues ( array , boolean )
-- What it Does:    Collections the JoinDateText, the Promo, and the main Status text for use of the audit window
-- Purpose:         Easily callable function for reuse in parsing player data for the audit system.
GRM.GetAuditLinePlayervalues = function(data, isComplete)
    local joinDate, promoDate, mainStatus = "", "", "";
    local classColors = {};
    local player;

    if type(data) == "string" then
        player = GRM.GetPlayer(data);
    else
        player = data;
    end

    -- Join date
    if #player.joinDateHist[1][4] == 1 then
        if player.joinDateUnknown then
            joinDate = GRM.L("Unknown");
            if GRM.S().unknownIsComplete then
                isComplete = false;
            end
        else
            joinDate = GRM.L("No Date Set");
            isComplete = false;
        end
    else
        joinDate = GRM_UI.DateUntrustedTag(player.joinDateHist[1][6]) ..
                       GRM.Time.FormatTimeStamp(
                {player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]}, false);
    end

    -- Promo Date
    if player.promoteDateUnknown then
        promoDate = GRM.L("Unknown");
        if GRM.S().unknownIsComplete then
            isComplete = false;
        end
    elseif #player.rankHist[1][5] == 1 then
        promoDate = GRM.L("No Date Set");
        isComplete = false;
    else
        promoDate = GRM_UI.DateUntrustedTag(player.rankHist[1][7]) ..
                        GRM.Time.FormatTimeStamp({player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]}, false);
    end

    -- Main or Alt
    if GRM.IsMain(player.name) then
        mainStatus = (GRM.L("Main"));
    else
        -- Ok, they are not the main... do they have alts? If they have alts, we should see if one of them is listed as main.
        local group = GRM.GetAltGroup(player.altGroup);
        if group then -- Player is in an alt group...

            -- No one is listed as "main" in alt grouping.
            if group.main == "" then
                mainStatus = GRM.L("Main or Alt?");
                isComplete = false;
            else
                mainStatus = GRM.L("Alt");
            end
        else
            mainStatus = GRM.L("Main or Alt?");
            isComplete = false;
        end
    end

    -- Class Color
    classColors = GRM.GetClassColorRGB(player.class);

    -- Birthdate
    local birthDate = "";
    local birthdayInfo = GRM.GetBirthday(player);

    if birthdayInfo.date[1] == 0 then
        if birthdayInfo.unknown then
            birthDate = GRM.L("Unknown");
            if GRM.S().unknownIsComplete then
                isComplete = false;
            end
        else
            birthDate = GRM.L("No Date Set");
            isComplete = false;
        end
    else
        birthDate = GRM.Time.FormatTimeStamp({ birthdayInfo.date[1] , birthdayInfo.date[2] } , false,
            true);
    end

    -- Whether to even bother including them in the audit
    if not GRM.S().includeBirthdaysInAudit then
        isComplete = false;
    end

    return joinDate, promoDate, mainStatus, isComplete, classColors, birthDate;
end

-- Method:          GRM.GetAllGuildiesInOrder ( boolean , boolean )
-- What it Does:    Returns a sorted string array of all guildies
-- Purpose:         Useful to have an alphabetized list of guildies :)
GRM.GetAllGuildiesInOrder = function(fullNameNeeded, fromAtoZ)
    if not GRM.IsCalendarEventEditOpen() then
        GRM.GuildRoster();
    end
    local listOfGuildies = {};
    local joinDate = "";
    local promoDate = "";
    local mainStatus = "";
    local isComplete = true;
    local classColors = {};
    local birthDate = "";
    local name = "";
    local guild = GRM.GetGuild();

    for _, player in pairs(guild) do
        if type(player) == "table" then
            -- proper name format
            name = player.name;

            if not fullNameNeeded then
                name = GRM.SlimName(name);
            end

            joinDate, promoDate, mainStatus, isComplete, classColors, birthDate =
                GRM.GetAuditLinePlayervalues(player, isComplete);

            table.insert(listOfGuildies, {name, joinDate, promoDate, mainStatus, classColors, birthDate});
        end
    end

    sort(listOfGuildies, function(a, b)
        return a[1] < b[1]
    end);

    if not fromAtoZ then
        local tempList = {};
        for i = #listOfGuildies, 1, -1 do
            table.insert(tempList, listOfGuildies[i]);
        end
        listOfGuildies = tempList;
    end
    return listOfGuildies, isComplete;
end

-- Method:          GRM.GetAllGuildiesInJoinDateOrder ( boolean , boolean )
-- What it Does:    Returns a sorted string array of all guildies in either ascending or descending order of when they joined the guild.
-- Purpose:         For sorting the audit window and keeping track of guildies...
GRM.GetAllGuildiesInJoinDateOrder = function(fullNameNeeded, newFirst)
    local result = {};
    local listOfGuildiesWithDates = {};
    local listOfGuildiesWithUnknownDates = {};
    local name = "";
    local joinDate = "";
    local promoDate = "";
    local mainStatus = "";
    local isComplete = true;
    local classColors = {};
    local birthDate = "";
    local guild = GRM.GetGuild();

    for _, player in pairs(guild) do
        if type(player) == "table" then
            joinDate, promoDate, mainStatus, isComplete, classColors, birthDate =
                GRM.GetAuditLinePlayervalues(player, isComplete);

            if #player.joinDateHist[1][4] > 1 then

                local standardTime = tonumber(player.joinDateHist[1][4]);

                -- find a proper place to sort
                if #listOfGuildiesWithDates == 0 then -- the first one can be a straight insert
                    table.insert(listOfGuildiesWithDates,
                        {player.name, standardTime, joinDate, promoDate, mainStatus, classColors, birthDate});
                else
                    -- parse through the dates, new First... (number will be larger)
                    local j = 1;
                    while j <= #listOfGuildiesWithDates and standardTime < listOfGuildiesWithDates[j][2] do
                        j = j + 1;
                    end
                    if j == #listOfGuildiesWithDates + 1 then
                        table.insert(listOfGuildiesWithDates, {player.name, standardTime, joinDate, promoDate,
                                                               mainStatus, classColors, birthDate});
                    else
                        table.insert(listOfGuildiesWithDates, j, {player.name, standardTime, joinDate, promoDate,
                                                                  mainStatus, classColors, birthDate});
                    end
                end
            else
                table.insert(listOfGuildiesWithUnknownDates,
                    {player.name, joinDate, promoDate, mainStatus, classColors, birthDate});
            end
        end
    end

    -- Sort the unknowns to be added at the end
    sort(listOfGuildiesWithUnknownDates, function(a, b)
        return a[1] < b[1]
    end);

    if not newFirst then
        -- need to reverse
        for i = #listOfGuildiesWithDates, 1, -1 do
            name = listOfGuildiesWithDates[i][1];
            if not fullNameNeeded then
                name = GRM.SlimName(name);
            end

            table.insert(result,
                {name, listOfGuildiesWithDates[i][3], listOfGuildiesWithDates[i][4], listOfGuildiesWithDates[i][5],
                 listOfGuildiesWithDates[i][6], listOfGuildiesWithDates[i][7]});

        end
    else
        for i = 1, #listOfGuildiesWithDates do
            name = listOfGuildiesWithDates[i][1];
            if not fullNameNeeded then
                name = GRM.SlimName(name);
            end

            table.insert(result,
                {name, listOfGuildiesWithDates[i][3], listOfGuildiesWithDates[i][4], listOfGuildiesWithDates[i][5],
                 listOfGuildiesWithDates[i][6], listOfGuildiesWithDates[i][7]});
        end
    end

    -- let's add the sorted unknowns to the end now as well.
    for i = 1, #listOfGuildiesWithUnknownDates do

        name = listOfGuildiesWithUnknownDates[i][1];
        if not fullNameNeeded then
            name = GRM.SlimName(name);
        end

        table.insert(result, {name, listOfGuildiesWithUnknownDates[i][2], listOfGuildiesWithUnknownDates[i][3],
                              listOfGuildiesWithUnknownDates[i][4], listOfGuildiesWithUnknownDates[i][5],
                              listOfGuildiesWithUnknownDates[i][6]});
    end
    return result, isComplete;
end

-- Method:          GRM.GetAllGuildiesInPromoDateOrder ( boolean , boolean )
-- What it Does:    Returns a sorted string array of all guildies in either ascending or descending order of when they were promoted last in the guild.
-- Purpose:         For sorting the audit window and keeping track of guildies...
GRM.GetAllGuildiesInPromoDateOrder = function(fullNameNeeded, newFirst)
    local result = {};
    local listOfGuildiesWithDates = {};
    local listOfGuildiesWithUnknownDates = {};
    local name = "";
    local joinDate = "";
    local promoDate = "";
    local mainStatus = "";
    local isComplete = true;
    local classColors = {};
    local birthDate = "";
    local guild = GRM.GetGuild();

    for _, player in pairs(guild) do
        if type(player) == "table" then
            joinDate, promoDate, mainStatus, isComplete, classColors, birthDate =
                GRM.GetAuditLinePlayervalues(player, isComplete);

            if #player.rankHist[1][5] > 1 and #player.rankHist[1][5] > 8 then
                if player.rankHist[1][2] ~= 0 and player.rankHist[1][3] ~= 0 and player.rankHist[1][4] ~= 0 then
                    player.rankHist[1][5] = GRM.Time.ConvertToStandardFormatDate ( player.rankHist[1][2] , player.rankHist[1][3] , player.rankHist[1][4] );

                else
                    player.rankHist = { { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 } };
                end
            end

            if #player.rankHist[1][5] > 1 then
                -- find a proper place to sort
                local standardTime = tonumber(player.rankHist[1][5]);

                if #listOfGuildiesWithDates == 0 then -- the first one can be a straight insert
                    table.insert(listOfGuildiesWithDates,
                        {player.name, standardTime, joinDate, promoDate, mainStatus, classColors, birthDate});
                else
                    -- parse through the dates, new First... (number will be larger)
                    local j = 1;
                    while j <= #listOfGuildiesWithDates and standardTime < listOfGuildiesWithDates[j][2] do
                        j = j + 1;
                    end
                    if j == #listOfGuildiesWithDates + 1 then
                        table.insert(listOfGuildiesWithDates, {player.name, standardTime, joinDate, promoDate,
                                                               mainStatus, classColors, birthDate});
                    else
                        table.insert(listOfGuildiesWithDates, j, {player.name, standardTime, joinDate, promoDate,
                                                                  mainStatus, classColors, birthDate});
                    end
                end
            else
                table.insert(listOfGuildiesWithUnknownDates,
                    {player.name, joinDate, promoDate, mainStatus, classColors, birthDate});
            end
        end
    end

    -- Sort the unknowns to be added at the end
    sort(listOfGuildiesWithUnknownDates, function(a, b)
        return a[1] < b[1]
    end);

    if not newFirst then
        -- need to reverse
        for i = #listOfGuildiesWithDates, 1, -1 do

            name = listOfGuildiesWithDates[i][1];
            if not fullNameNeeded then
                name = GRM.SlimName(name);
            end
            table.insert(result,
                {name, listOfGuildiesWithDates[i][3], listOfGuildiesWithDates[i][4], listOfGuildiesWithDates[i][5],
                 listOfGuildiesWithDates[i][6], listOfGuildiesWithDates[i][7]});

        end
    else
        for i = 1, #listOfGuildiesWithDates do

            name = listOfGuildiesWithDates[i][1];
            if not fullNameNeeded then
                name = GRM.SlimName(name);
            end
            table.insert(result,
                {name, listOfGuildiesWithDates[i][3], listOfGuildiesWithDates[i][4], listOfGuildiesWithDates[i][5],
                 listOfGuildiesWithDates[i][6], listOfGuildiesWithDates[i][7]});

        end
    end

    -- let's add the sorted unknowns to the end now as well.
    for i = 1, #listOfGuildiesWithUnknownDates do
        name = listOfGuildiesWithUnknownDates[i][1];
        if not fullNameNeeded then
            name = GRM.SlimName(name);
        end

        table.insert(result, {name, listOfGuildiesWithUnknownDates[i][2], listOfGuildiesWithUnknownDates[i][3],
                              listOfGuildiesWithUnknownDates[i][4], listOfGuildiesWithUnknownDates[i][5],
                              listOfGuildiesWithUnknownDates[i][6]});
    end
    return result, isComplete;
end

-- Method:          GRM.GetAllMainsAndAltsInOrder ( boolean )
-- What it Does:    Returns the guild roster sorted with either mains first or alts alphebatized, then alphabetizes the rest.
-- Purpose:         Auditing the roster and sorting!
GRM.GetAllMainsAndAltsInOrder = function(mainsFirst)
    local result = {};
    local listOfMains = {};
    local listOfAlts = {};
    local listOfNeither = {};
    local joinDate = "";
    local promoDate = "";
    local mainStatus = "";
    local isComplete = true;
    local classColors = {};
    local birthDate = "";
    local guild = GRM.GetGuild();

    for _, player in pairs(guild) do
        if type(player) == "table" then
            joinDate, promoDate, mainStatus, isComplete, classColors, birthDate =
                GRM.GetAuditLinePlayervalues(player, isComplete);
            local group = GRM.GetAltGroup(player.altGroup);

            if GRM.IsMain(player.name) then
                table.insert(listOfMains, {player.name, joinDate, promoDate, mainStatus, classColors, birthDate}); -- Can just add if main.

            elseif group then -- if not main, but you do have alts, scan through the alts to see if they are a main.

                if group.main ~= "" then
                    table.insert(listOfAlts, {player.name, joinDate, promoDate, mainStatus, classColors, birthDate});
                else
                    table.insert(listOfNeither, {player.name, joinDate, promoDate, mainStatus, classColors, birthDate});
                end
            else
                table.insert(listOfNeither, {player.name, joinDate, promoDate, mainStatus, classColors, birthDate});
            end
        end
    end

    sort(listOfMains, function(a, b)
        return a[1] < b[1]
    end);
    sort(listOfAlts, function(a, b)
        return a[1] < b[1]
    end);
    sort(listOfNeither, function(a, b)
        return a[1] < b[1]
    end);

    -- Combine the tables...
    if mainsFirst then
        result = listOfMains;
        for i = 1, #listOfAlts do
            table.insert(result, listOfAlts[i]);
        end
    else
        result = listOfAlts;
        for i = 1, #listOfMains do
            table.insert(result, listOfMains[i]);
        end
    end

    for i = 1, #listOfNeither do
        table.insert(result, listOfNeither[i]);
    end
    return result, isComplete;
end

-- Method:          GRM.GetAllGuildiesByBirthdayDateOrder ( boolean , boolean )
-- What it Does:    Returns a sorted string array of all guildies in either ascending or descending order of when their birthday is
-- Purpose:         For sorting the audit window and keeping track of guildies...
GRM.GetAllGuildiesByBirthdayDateOrder = function(fullNameNeeded, newFirst)
    local result = {};
    local listOfGuildiesWithDates = {};
    local listOfGuildiesWithUnknownDates = {};
    local name = "";
    local joinDate = "";
    local promoDate = "";
    local mainStatus = "";
    local isComplete = true;
    local classColors = {};
    local birthdate = "";
    local guild = GRM.GetGuild();

    for _, player in pairs(guild) do
        if type(player) == "table" then
            joinDate, promoDate, mainStatus, isComplete, classColors, birthdate =
                GRM.GetAuditLinePlayervalues(player, isComplete);

            if GRM.S().includeBirthdaysInAudit then

                local birthdayInfo = GRM.GetBirthday(player);
                if birthdayInfo.date[1] ~= 0 then
                    -- find a proper place to sort
                    local timestamp = GRM_ENUM.DAYS_BEFORE_MONTH[birthdayInfo.date[2]] + birthdayInfo.date[1];

                    if #listOfGuildiesWithDates == 0 then -- the first one can be a straight insert
                        table.insert(listOfGuildiesWithDates,
                            {player.name, timestamp, joinDate, promoDate, mainStatus, classColors, birthdate});
                    else
                        -- parse through the dates, new First... (number will be larger)
                        local j = 1;
                        while j <= #listOfGuildiesWithDates and timestamp < listOfGuildiesWithDates[j][2] do
                            j = j + 1;
                        end
                        if j == #listOfGuildiesWithDates + 1 then
                            table.insert(listOfGuildiesWithDates, {player.name, timestamp, joinDate, promoDate,
                                                                   mainStatus, classColors, birthdate});
                        else
                            table.insert(listOfGuildiesWithDates, j, {player.name, timestamp, joinDate, promoDate,
                                                                      mainStatus, classColors, birthdate});
                        end
                    end
                else
                    table.insert(listOfGuildiesWithUnknownDates,
                        {player.name, joinDate, promoDate, mainStatus, classColors, birthdate});
                end
            else
                -- Birthdays are disabled...
                table.insert(listOfGuildiesWithUnknownDates,
                    {player.name, joinDate, promoDate, mainStatus, classColors, birthdate});
            end
        end
    end

    -- Sort the unknowns to be added at the end
    sort(listOfGuildiesWithUnknownDates, function(a, b)
        return a[1] < b[1]
    end);

    if not newFirst then
        -- need to reverse
        for i = #listOfGuildiesWithDates, 1, -1 do

            name = listOfGuildiesWithDates[i][1];
            if not fullNameNeeded then
                name = GRM.SlimName(name);
            end
            table.insert(result,
                {name, listOfGuildiesWithDates[i][3], listOfGuildiesWithDates[i][4], listOfGuildiesWithDates[i][5],
                 listOfGuildiesWithDates[i][6], listOfGuildiesWithDates[i][7]});

        end
    else
        for i = 1, #listOfGuildiesWithDates do

            name = listOfGuildiesWithDates[i][1];
            if not fullNameNeeded then
                name = GRM.SlimName(name);
            end
            table.insert(result,
                {name, listOfGuildiesWithDates[i][3], listOfGuildiesWithDates[i][4], listOfGuildiesWithDates[i][5],
                 listOfGuildiesWithDates[i][6], listOfGuildiesWithDates[i][7]});

        end
    end

    -- let's add the sorted unknowns to the end now as well.
    for i = 1, #listOfGuildiesWithUnknownDates do
        name = listOfGuildiesWithUnknownDates[i][1];
        if not fullNameNeeded then
            name = GRM.SlimName(name);
        end

        table.insert(result, {name, listOfGuildiesWithUnknownDates[i][2], listOfGuildiesWithUnknownDates[i][3],
                              listOfGuildiesWithUnknownDates[i][4], listOfGuildiesWithUnknownDates[i][5],
                              listOfGuildiesWithUnknownDates[i][6]});
    end
    return result, isComplete;
end