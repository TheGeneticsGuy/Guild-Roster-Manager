local DD = {};
GRM_UI.DD = DD;

-- Method:          DD.PopulateOptionsRankDropDown()
-- What it Does:    Adds all the guild ranks to the drop down menu
-- Purpose:         UI Feature
DD.PopulateOptionsRankDropDown = function()
    -- populating the frames!
    local buffer = 3;
    local height = 0;
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons =
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons or
            {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu
        .Buttons do
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons[i][1]:Hide();
    end

    local i = 1;
    for count = 1, GuildControlGetNumRanks() do
        if not GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu
            .Buttons[i] then
            local tempButton = CreateFrame("Button", "rankIndex" .. i, GRM_UI.GRM_CoreFrame.GRM_OptionsFrame
                .GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu);
            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local RankButtons = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterSyncRankDropDownMenu.Buttons[i][1];
        local RankButtonsText = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
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
            RankButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterSyncRankDropDownMenu, 0, -7);
            height = height + RankButtons:GetHeight();
        else
            RankButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterSyncRankDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + RankButtons:GetHeight() + buffer;
        end

        RankButtons:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu:Hide();
                GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelected:Show();
                local selectedRank = GRM.GetRankIndex(GRM_UI.GRM_CoreFrame.GRM_OptionsFrame
                                                          .GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelectedText:GetText(),
                    self);
                local isRestricted, rankIndex = GRM.Global.IsSyncRankGuildLeaderRestricted(2);

                -- Now, are they different? If they are different, that is a problem!
                if not isRestricted or CanEditGuildInfo() or (isRestricted and rankIndex == selectedRank) then
                    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
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
                        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                            .GRM_RosterBanListDropDownSelectedText:SetText(RankButtonsText:GetText());

                        GRM.Global.UpdateGuildInfoWithNewValue(3, GRM.S().syncRank, true);

                    end

                    -- Retrigger active addon users... Very important to know permissions
                    if not GRM_UI.GRM_CoreFrame.GRM_AddonUsersFrame:IsVisible() then
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
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownMenu:SetHeight(
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

    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons =
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons or
            {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu
        .Buttons do
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons[i][1]:Hide();
    end

    local i = 1;
    for count = 1, GuildControlGetNumRanks() do
        if not GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu
            .Buttons[i] then
            local tempButton = CreateFrame("Button", "rankIndex" .. i, GRM_UI.GRM_CoreFrame.GRM_OptionsFrame
                .GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu);
            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu.Buttons[i] =
                {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local RankButtons = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterBanListDropDownMenu.Buttons[i][1];
        local RankButtonsText = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
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
            RankButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterBanListDropDownMenu, 0, -7);
            height = height + RankButtons:GetHeight();
        else
            RankButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_RosterBanListDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + RankButtons:GetHeight() + buffer;
        end

        RankButtons:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu:Hide();
                GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelected:Show();
                local selectedRank = GRM.GetRankIndex(GRM_UI.GRM_CoreFrame.GRM_OptionsFrame
                                                          .GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelectedText:GetText(),
                    self);
                local isRestricted, rankIndex = GRM.Global.IsSyncRankGuildLeaderRestricted(3);

                -- Now, are they different? If they are different, that is a problem!
                if not isRestricted or CanEditGuildInfo() or (isRestricted and rankIndex == selectedRank) then

                    if GRM.S().syncRank < selectedRank then

                        GRM.S().syncRankBanList = GRM.S().syncRank;
                        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                            .GRM_RosterBanListDropDownSelectedText:SetText(
                            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterSyncRankDropDownSelectedText:GetText());
                        GRM.Report(GRM.L("Warning! Unable to select a Ban List rank below \"{name}\"",
                            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_RosterSyncRankDropDownSelectedText:GetText()) .. "\n" ..
                                       GRM.L("Setting to match core filter rank"));

                        GRM.Global.UpdateGuildInfoWithNewValue(3, GRM.S().syncRank, true);
                    else
                        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                            .GRM_RosterBanListDropDownSelectedText:SetText(RankButtonsText:GetText());
                        GRM.S().syncRankBanList = selectedRank;

                        GRM.Global.UpdateGuildInfoWithNewValue(3, selectedRank, true);
                    end

                    -- Re-trigger addon users permissions
                    if not GRM_UI.GRM_CoreFrame.GRM_AddonUsersFrame:IsVisible() then
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
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownMenu:SetHeight(
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
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu.Buttons =
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu.Buttons or
            {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu
        .Buttons do
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu.Buttons[i][1]:Hide();
    end

    local i = 1;
    for count = 1, GuildControlGetNumRanks() do
        if not GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu
            .Buttons[i] then
            local tempButton = CreateFrame("Button", "rankIndex" .. i, GRM_UI.GRM_CoreFrame.GRM_OptionsFrame
                .GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu);
            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu
                .Buttons[i] = {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
        end

        local RankButtons = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                                .GRM_DefaultCustomRankDropDownMenu.Buttons[i][1];
        local RankButtonsText = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
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
            RankButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_DefaultCustomRankDropDownMenu, 0, -7);
            height = height + RankButtons:GetHeight();
        else
            RankButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame
                .GRM_DefaultCustomRankDropDownMenu.Buttons[i - 1][1], "BOTTOM", 0, -buffer);
            height = height + RankButtons:GetHeight() + buffer;
        end

        RankButtons:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu:Hide();
                GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelected:Show();
                local selectedRank = GRM.GetRankIndex(GRM_UI.GRM_CoreFrame.GRM_OptionsFrame
                                                          .GRM_SyncOptionsFrame.GRM_DefaultCustomSelectedText:GetText(),
                    self);
                local isRestricted, rankIndex = GRM.Global.IsSyncRankGuildLeaderRestricted(4);

                -- Now, are they different? If they are different, that is a problem!
                if not isRestricted or CanEditGuildInfo() or (isRestricted and rankIndex == selectedRank) then

                    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelectedText:SetText(
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
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomRankDropDownMenu:SetHeight(
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
    GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons =
        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons or {};

    -- Resetting the buttons!
    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons do
        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons[i][1]:Hide();
    end

    local j = 1;

    for i = 1, #AllClasses do

        if (AllClasses[i] ~= "Deathknight" and AllClasses[i] ~= "Monk" and AllClasses[i] ~= "Demonhunter" and
            AllClasses[i] ~= "Evoker") or ((AllClasses[i] == "Deathknight" and GRM_G.BuildVersion >= GRM_ENUM.BUILD.WOTLK) or
            (AllClasses[i] == "Monk" and GRM_G.BuildVersion >= GRM_ENUM.BUILD.MOP) or
            (AllClasses[i] == "Demonhunter" and GRM_G.BuildVersion >= GRM_ENUM.BUILD.LEGION) or
            (AllClasses[i] == "Evoker" and GRM_G.BuildVersion >= GRM_ENUM.BUILD.DF)) then

            local class = string.upper(AllClasses[i]);
            local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class];

            if classColor then

                local className = GRM.GetClassName(class);

                if not GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu
                    .Buttons[i] then
                    local tempButton = CreateFrame("Button", "ClassButton" .. j, GRM_UI.GRM_CoreFrame
                        .GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu);
                    GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu.Buttons[j] =
                        {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
                    if j == 1 then
                        GRM_G.DropDownHighlightLockIndex = 1;
                        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu
                            .Buttons[j][1]:LockHighlight();
                    end
                end

                local ClassButtons = GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                                         .GRM_AddBanDropDownMenu.Buttons[j][1];
                local ClassButtonsText = GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
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
                    ClassButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                        .GRM_AddBanDropDownMenu, 0, -7);
                    height = height + ClassButtons:GetHeight();
                else
                    ClassButtons:SetPoint("TOP", GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                        .GRM_AddBanDropDownMenu.Buttons[j - 1][1], "BOTTOM", 0, -buffer);
                    height = height + ClassButtons:GetHeight() + buffer;
                end

                ClassButtons:SetScript("OnClick", function(_, button)
                    if button == "LeftButton" then
                        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                            .GRM_AddBanDropDownClassSelectedText:SetText(ClassButtonsText:GetText());
                        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                            .GRM_AddBanDropDownClassSelectedText:SetTextColor(classColor.r, classColor.g, classColor.b,
                            1);
                        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu:Hide();
                        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame
                            .GRM_AddBanDropDownClassSelected:Show();
                        GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanReasonEditBox:SetFocus();
                        GRM_G.tempAddBanClass = class;
                    end
                end);
                ClassButtons:Show();
                j = j + 1;
            end
        end
    end
    GRM_UI.GRM_CoreFrame.GRM_CoreBanListFrame.GRM_AddBanFrame.GRM_AddBanDropDownMenu:SetHeight(height + 15);
end

-- Method:          DD.PopulateTimestampFormatDropDown()
-- What it Does:    Builds a dropdown menu displaying the various format options
-- Purpose:         To give the player the ability to adjust timestamp formats
DD.PopulateTimestampFormatDropDown = function()
    local buffer = 4;
    local height = 0;
    local dropDownMenu;
    local selectedFrame;
    local selectedText;
    local nameText = "";

    dropDownMenu = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelectedDropDownMenu;
    selectedFrame = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected;
    selectedText = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected.GRM_TimestampSelectedText;
    nameText = "GRM_timeStampButton"

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
        timeStampButton:Show();
    end
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelectedDropDownMenu:SetHeight(height + 15);
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

    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelectedText:SetText(
        setRankName);
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelectedText:SetText(
        setRankNameBanList);
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelectedText:SetText(
        setCustomDefaultName);

    local month, day, year = select(2, GRM.Time.GetTodaysDate());
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected
        .GRM_TimestampSelectedText:SetText(GRM.Time.FormatTimeStamp({day, month, year}, false, false,
        GRM.S().globalDateFormat));

    -- Now that initial values set, let's display them!
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncRankDropDownSelected:Show();
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterBanListDropDownSelected:Show();
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_DefaultCustomSelected:Show();
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame.GRM_TimestampSelected:Show();
end