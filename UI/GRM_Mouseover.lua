

local f;

--------------------------
-- CONTEXT MENU BUILDER --
--------------------------
local function ShowContextMenu(anchor, title, buttons)
    local cm = f.ContextMenu
    if not cm then
        GRM_UI.CreateCoreFrame("ContextMenu", f, nil, 100, 100, BackdropTemplateMixin and "BackdropTemplate", false, nil, "FULLSCREEN_DIALOG", false, false)
        cm = f.ContextMenu
        cm:SetBackdrop(GRM_UI.noteBackdrop2)
        
        GRM_UI.CreateString("Title", cm, "GameFontNormalSmall", "", 11, {"TOPLEFT", cm, "TOPLEFT", 7, -13}, nil, nil, "LEFT", false)
        GRM_UI.CreateString("Divider", cm, "GameFontWhiteTiny", "__", 11, {"BOTTOMLEFT", cm, "BOTTOMLEFT", 7, 30}, nil, nil, "LEFT", false)
        
        GRM_UI.CreateButton("CancelButton", cm, nil, GRM.L("Cancel"), 90, 26, {"BOTTOMLEFT", cm, "BOTTOMLEFT", 7, 4}, function() cm:Hide(); GRM_UI.Unpause() end, "GameFontWhiteTiny", 11, "LEFT")
        cm.CancelButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
        
        cm:SetScript("OnKeyDown", function(self, key)
            if not GRM_G.inCombat then
                self:SetPropagateKeyboardInput(true)
                if key == "ESCAPE" then
                    self:SetPropagateKeyboardInput(false)
                    self:Hide()
                end
            elseif key == "ESCAPE" then
                self:Hide()
            end
        end)
        
        cm.Buttons = {}
    end

    cm:Hide()
    cm:ClearAllPoints()
    cm:SetPoint(anchor[1], anchor[2], anchor[3], anchor[4], anchor[5])
    cm.Title:SetText(title)
    
    local maxWidth = math.max(93, cm.Title:GetStringWidth() + 15, cm.CancelButton.CancelButtonText:GetStringWidth() + 15)
    
    local yOffset = -22
    for i, btnInfo in ipairs(buttons) do
        local btn = cm.Buttons[i]
        if not btn then
            local btnName = "MenuButton" .. i
            GRM_UI.CreateButton(btnName, cm, nil, "", 90, 26, {"TOPLEFT", cm, "TOPLEFT", 7, yOffset}, nil, "GameFontWhiteTiny", 11, "LEFT")
            btn = cm[btnName]
            btn:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
            cm.Buttons[i] = btn
        end
        
        btn:SetPoint("TOPLEFT", cm, "TOPLEFT", 7, yOffset)
        btn[btn:GetName() .. "Text"]:SetText(btnInfo.text)
        btn:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                btnInfo.onClick()
            end
        end)
        
        maxWidth = math.max(maxWidth, btn[btn:GetName() .. "Text"]:GetStringWidth() + 15)
        btn:Show()
        yOffset = yOffset - 26
    end
    
    for i = #buttons + 1, #cm.Buttons do
        cm.Buttons[i]:Hide()
    end
    
    cm.CancelButton:SetWidth(maxWidth)
    for i = 1, #buttons do
        cm.Buttons[i]:SetWidth(maxWidth)
        GRM.NormalizeHitRects(cm.Buttons[i], cm.Buttons[i][cm.Buttons[i]:GetName() .. "Text"], maxWidth)
    end
    
    cm.Divider:SetPoint("BOTTOMLEFT", cm.CancelButton, "TOPLEFT", 0, -2)
    
    local totalHeight = math.abs(yOffset) + 26 + 10
    cm:SetSize(maxWidth + 14, totalHeight)
    cm:Show()
end

-------------------------------------
---- CONTEXT MENU LOGIC ACTIONS -----
-------------------------------------

local function ResetPlayerMetaData(playerName)
    local guildData = GRM.GetGuild()
    if guildData[playerName] then
        GRM.Report(GRM.L("{name}'s saved data has been wiped!", GRM.GetClassifiedName(playerName)))
        local member = {}
        local player = GRM.GetPlayer(playerName)
        local name, sex = GRM.GetFullNameClubMember(player.GUID)

        if name and name ~= "" then
            member.name = name;
            member.rankName = player.rankName;
            member.rankIndex = player.rankIndex
            member.level = player.level;
            member.note = player.note
            member.officerNote = player.officerNote or ""
            member.class = player.class;
            member.lastOnline = player.lastOnline
            member.lastOnlineTime = player.lastOnlineTime;
            member.zone = player.zone
            member.achievementPoints = player.achievementPoints
             member.rep = player.rep
            member.status = player.status;
            member.isOnline = player.isOnline
            member.GUID = player.GUID;
            member.race = player.race
            member.sex = sex;
            member.rosterSelection =
            GRM.GetRosterSelectionID(member.name, member.GUID)
            member.faction = player.faction
            if GRM_G.BuildVersion > GRM_ENUM.BUILD.BFA then
                member.MythicScore = player.MythicScore
            end
            if GRM.IsHardcoreActive() then
                member.HC = player.HC
            end
        end

        if GRM.PlayerHasAlts(player) then
            GRM.RemovePlayerFromAltGroup(playerName, 0, false, true, false, true)
        end
        GRM_GuildMemberHistory_Save[GRM_G.guildName][playerName] = nil

        if member.name ~= nil then
            GRM.AddMemberRecord(member, false, nil)
        end
        f:Hide()
        GRM.GuildRoster()
    end
end

local function ConfigureRightClickPlayerNameWindow()
    local buttons = {}
    
    if not GRM_G.selectedName[3] then
        table.insert(buttons, { text = GRM.L("Set as Main"), onClick = function()
            if GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:IsVisible() then
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:Hide()
            end
            GRM_UI.SetAltAsMainDropDownMenuLogic(GRM_G.selectedName)
            f.ContextMenu:Hide()
        end})
    else
        table.insert(buttons, { text = GRM.L("Set as Alt"), onClick = function()
            if GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:IsVisible() then
                GRM_UI.GRM_CoreFrame.GRM_AuditFrame.GRM_AuditWindowDropDownFrame:Hide()
            end
            GRM_UI.DemoteMainToAltDropDownMenuLogic(GRM_G.selectedName)
            f.ContextMenu:Hide()
        end})
    end
    
    table.insert(buttons, { text = GRM.L("Reset Data!"), onClick = function()
        local altDetails = GRM_G.selectedName
        GRM_UI.GRM_RosterConfirmFrameText:SetText( GRM.L("Reset All of {name}'s Data?", GRM.GetClassifiedName(altDetails[1], true)))
        GRM_UI.GRM_RosterConfirmYesButtonText:SetText( GRM.L("Yes!") )
        GRM_UI.GRM_RosterConfirmYesButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                GRM.ResetPlayerMetaData(altDetails[1])
                GRM_UI.GRM_RosterConfirmFrame:Hide()
                GRM_UI.RefreshSelectFrames(false, true, true, true, true, true)
            end
        end)
        GRM_UI.GRM_RosterConfirmFrame:Show()
        f.ContextMenu:Hide()
        f.GRM_SyncJoinDateSideFrame:Hide()
    end})
    
    ShowContextMenu({"TOPRIGHT", f.GRM_MemberDetailNameText, "BOTTOM", 0, 0}, GRM.SlimName(GRM_G.selectedName[2]), buttons)
    GRM_G.pause = true
end

local function ConfigureStatusRightClickMenu()
    local statusText = f.GRM_MemberDetailPlayerStatus:GetText()
    local buttons = {}
    
    if statusText == GRM_G.Status[1] or statusText == GRM_G.Status[2] then
        table.insert(buttons, { text = GRM.L("Notify When Player Goes Offline"), onClick = function() GRM.AddPlayerStatusCheck(GRM_G.selectedName[1], 3); f.ContextMenu:Hide(); GRM_UI.Unpause() end })
    elseif statusText == GRM_G.Status[3] then
        table.insert(buttons, { text = GRM.L("Notify When Player Comes Online"), onClick = function() GRM.AddPlayerStatusCheck(GRM_G.selectedName[1], 2); f.ContextMenu:Hide(); GRM_UI.Unpause() end })
    elseif statusText == GRM_G.Status[4] or statusText == GRM_G.Status[5] then
        table.insert(buttons, { text = GRM.L("Notify When Player is Active"), onClick = function() GRM.AddPlayerStatusCheck(GRM_G.selectedName[1], 1); f.ContextMenu:Hide(); GRM_UI.Unpause() end })
        table.insert(buttons, { text = GRM.L("Notify When Player Goes Offline"), onClick = function() GRM.AddPlayerStatusCheck(GRM_G.selectedName[1], 3); f.ContextMenu:Hide(); GRM_UI.Unpause() end })
    end
    
    if #buttons > 0 then
        ShowContextMenu({"TOPLEFT", f.GRM_MemberDetailPlayerStatus, "BOTTOM", 0, 0}, GRM.L("Options"), buttons)
        GRM_G.pause = true
    end
end

-- Confirm Dates (Called from Context Menus)
local function ConfirmPromoDate()
    local name = GRM_G.currentName
    local player = GRM.GetPlayer(name)

    if player and player.rankHist[1][2] ~= 0 then
        player.rankHist[1][6] = time()
        player.rankHist[1][7] = true
        player.promoteDateUnknown = false
        f.GRM_MemberDetailRankDateTxt:SetText(string.gsub(f.GRM_MemberDetailRankDateTxt:GetText(), "!!", ""))

        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
            GRMsync.SendMessage("GRM_SYNC", "GRM_PD?" .. syncRankFilter .. "?" .. name .. "?" .. tostring(player.rankHist[1][5]) .. "?" .. tostring(player.rankHist[1][6]), "GUILD")
        end
    end

    GRM_UI.Unpause()
    GRM_UI.RefreshSelectFrames(false, true, false, true, true, true)
end

local function CopyFromJoinDate()
    local player = GRM.GetPlayer(GRM_G.currentName)
    if player then
        local tStamp = GRM.Util.DeepCopyArray(player.joinDateHist[1])
        player.rankHist[1][1] = player.rankName
        player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4] = tStamp[1], tStamp[2], tStamp[3]
        player.rankHist[1][5] = tStamp[4]
        player.rankHist[1][6] = time()
        player.rankHist[1][7] = true
        player.rankHist[1][8] = 1

        player.promoteDateUnknown = false

        if player.isOnline then
            if player.zone ~= nil then
                f.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone)
                f.GRM_ZoneInfoTime2:SetText(GRM.Time.GetTimePassedInZone(player.timeEnteredZone))
            end
            f.GRM_ZoneInfoText:Show(); f.GRM_MemberDetailMetaZoneInfoZoneText:Show()
            f.GRM_ZoneInfoTime1:Show(); f.GRM_ZoneInfoTime2:Show()
        end

        f.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " .. f.GRM_JoinDateText:GetText())
        f.GRM_SetPromoDateButton:Hide()
        f.GRM_MemberDetailRankDateTxt:Show()

        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
            GRMsync.SendMessage("GRM_SYNC", "GRM_PD?" .. syncRankFilter .. "?" .. player.name .. "?" .. tostring(player.rankHist[1][5]) .. "?" .. tostring(player.rankHist[1][6]), "GUILD")
        end

        GRM_UI.Unpause()
        GRM_UI.RefreshSelectFrames(false, true, false, true, true, true)
    end
    if f.ContextMenu then f.ContextMenu:Hide() end
end

local function ConfigurePromoteDateRightClickMenu()
    local player = GRM.GetPlayer(GRM_G.currentName)
    if not player then 
        return
    end
    
    local buttons = {}
    table.insert(buttons, { text = GRM.L("Edit Date"), onClick = function()
        f.GRM_SetPromoDateButton:Click()
        f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetText(GRM.L("Edit Promo Date"))
        f.ContextMenu:Hide()
        f.GRM_MemberDetailRankDateTxt:Hide()
    end})
    
    table.insert(buttons, { text = GRM.L("Clear History"), onClick = function()
        GRM_UI.ClearPromoDateHistory(player.name, player.promoteDateUnknown, player)
        f.ContextMenu:Hide()
    end})
    
    if not player.promoteDateUnknown and not player.rankHist[1][7] then
        table.insert(buttons, { text = GRM.L("Confirm Date"), onClick = function()
            ConfirmPromoDate()
            f.ContextMenu:Hide()
        end})
        
        if player.rankHist[1][6] and not player.joinDateUnknown then
            table.insert(buttons, { text = GRM.L("Use Join Date"), onClick = function()
                CopyFromJoinDate()
                f.ContextMenu:Hide()
            end})
        end
    end
    
    ShowContextMenu({"TOPRIGHT", f.GRM_MemberDetailRankDateTxt, "BOTTOM", 0, 0}, GRM.L("Options"), buttons)
    GRM_G.pause = true
end

local function ConfirmJoinDate()
    local name = GRM_G.currentName
    local player = GRM.GetPlayer(name)

    if player and player.joinDateHist[1][1] ~= 0 then
        player.joinDateHist[1][5] = time()
        player.joinDateHist[1][6] = true
        player.joinDateHist[1][7] = 1
        player.joinDateUnknown = false
        f.GRM_JoinDateText:SetText(string.gsub(f.GRM_JoinDateText:GetText(), "!!", ""))

        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
            GRMsync.SendMessage("GRM_SYNC", "GRM_JD?" .. syncRankFilter .. "?" .. name .. "?" .. tostring(player.joinDateHist[1][4]) .. "?" .. tostring(player.joinDateHist[1][5]), "GUILD")
        end
    end

    GRM_UI.Unpause()
    GRM_UI.RefreshSelectFrames(false, true, false, true, true, true)
end

local function CopyFromPromoDate()
    local player = GRM.GetPlayer(GRM_G.currentName)
    local showBdayText, rankButton = false, false
    local formatBdayStamp = ""

    if player then
        local tStamp = GRM.Util.DeepCopyArray(player.rankHist[1])
        player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3] = tStamp[2], tStamp[3], tStamp[4]
        player.joinDateHist[1][4] = tStamp[5]
        player.joinDateHist[1][5] = time()
        player.joinDateHist[1][6] = true
        player.joinDateHist[1][7] = 1

        player.joinDateUnknown = false

        local birthdayInfo = GRM.GetBirthday(player)
        if birthdayInfo.date[1] ~= 0 then
            showBdayText = true
            formatBdayStamp = GRM.Time.FormatTimeStamp({ birthdayInfo.date[1], birthdayInfo.date[2] }, false, true)
        end

        local joinDate = GRM.Time.FormatTimeStamp({player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]}, false)
        GRM.AddTimeStampToNote(player.name, player.GUID, joinDate)

        player.anniversaryAnnounced = false
        GRM.RemoveFromCalendarQue(player.name, 1, nil)

        if player.rankHist[1][2] == 0 and not player.promoteDateUnknown then rankButton = true end

        if player.isOnline then
            if player.zone ~= nil then
                f.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone)
                f.GRM_ZoneInfoTime2:SetText(GRM.Time.GetTimePassedInZone(player.timeEnteredZone))
            end
            f.GRM_ZoneInfoText:Show(); f.GRM_MemberDetailMetaZoneInfoZoneText:Show()
            f.GRM_ZoneInfoTime1:Show(); f.GRM_ZoneInfoTime2:Show()
        end

        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
            GRMsync.SendMessage("GRM_SYNC", "GRM_JD?" .. syncRankFilter .. "?" .. player.name .. "?" .. player.joinDateHist[1][4] .. "?" .. tostring(player.joinDateHist[1][5]), "GUILD")
        end

        f.GRM_MemberDetailJoinDateButton:Hide()
        f.GRM_JoinDateText:SetText(joinDate)
        f.GRM_JoinDateText:Show()

        if rankButton then f.GRM_SetPromoDateButton:Show() else f.GRM_MemberDetailRankDateTxt:Show() end

        if GRM.S().showBDay and not f.GRM_BirthdayText:IsVisible() and not f.GRM_MemberDetailBirthdayButton:IsVisible() then
            if showBdayText then
                f.GRM_MemberDetailBirthdayButton:Hide()
                f.GRM_BirthdayText:SetText(formatBdayStamp)
                f.GRM_BirthdayText:Show()
            else
                f.GRM_MemberDetailBirthdayButton:Show()
                f.GRM_BirthdayText:Hide()
            end
        end

        GRM_UI.Unpause()
        GRM_UI.RefreshSelectFrames(false, true, false, true, true, true)
    end
    if f.ContextMenu then f.ContextMenu:Hide() end
end

local function ConfigureJoinDateRightClickMenu()
    local player = GRM.GetPlayer(GRM_G.currentName)
    if not player then return end
    
    local buttons = {}
    table.insert(buttons, { text = GRM.L("Edit Date"), onClick = function()
        f.GRM_MemberDetailJoinDateButton:Click()
        f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetText(GRM.L("Edit Join Date"))
        f.ContextMenu:Hide()
        f.GRM_MemberDetailRankDateTxt:Hide()
        f.GRM_JoinDateText:Hide()
        f.GRM_SyncDateArrowButton:Hide()
    end})
    
    table.insert(buttons, { text = GRM.L("Clear History"), onClick = function()
        player.joinDateUnknown = false
        GRM_UI.ClearJoinDateHistory(player.name, player.joinDateUnknown, player)
        f.ContextMenu:Hide()
    end})
    
    if not player.joinDateUnknown and not player.joinDateHist[1][6] then
        table.insert(buttons, { text = GRM.L("Confirm Date"), onClick = function()
            ConfirmJoinDate()
            f.ContextMenu:Hide()
        end})
        
        if player.rankHist[1][7] and not player.promoteDateUnknown then
            table.insert(buttons, { text = GRM.L("Use Promo Date"), onClick = function()
                CopyFromPromoDate()
                f.ContextMenu:Hide()
            end})
        end
    end
    
    ShowContextMenu({"TOPRIGHT", f.GRM_JoinDateText, "BOTTOM", 0, 0}, GRM.L("Options"), buttons)
    GRM_G.pause = true
end

local function ConfigureBirthDayRightClickMenu()
    local player = GRM.GetPlayer(GRM_G.currentName)
    if not player then return end
    
    local buttons = {}
    table.insert(buttons, { text = GRM.L("Edit Date"), onClick = function()
        f.GRM_BirthdayText:Hide()
        f.GRM_MemberDetailBirthdayButton:Click()
        f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetText(GRM.L("Edit Birthday"))
        f.ContextMenu:Hide()
    end})
    
    table.insert(buttons, { text = GRM.L("Remove Date"), onClick = function()
        GRM.ResetBirthdayForAltGroup(player.name, time(), false, nil, false)
        GRM_UI.RefreshSelectFrames(false, true, false, false, true, true)
        f.ContextMenu:Hide()
    end})
    
    ShowContextMenu({"TOPRIGHT", f.GRM_BirthdayText, "BOTTOM", 0, 0}, GRM.L("Options"), buttons)
    GRM_G.pause = true
end

local function GetMonthList()
    local result = {}
    for i = 1 , 12 do
        result[i] = GRM.L(GRM_ENUM.MONTHS[i])
    end
    return result
end

local function GetDayList()
    local list = {}
    for i = 1, 31 do
        table.insert(list, tostring(i))
    end
    return list
end

local function GetYearList()
    local list = {}
    local _, _, currentYear = select(2, GRM.Time.GetTodaysDate())
    -- Range from WoW launch year to current year
    for i = currentYear, 2004, -1 do
        table.insert(list, tostring(i))
    end
    return list
end

-- Closes overlapping dropdowns when you click one
local CloseOtherDateDropdowns = function(ind)
    if ind ~= 1 then f.GRM_MonthDropDownMenu:Hide() end
    if ind ~= 2 then f.GRM_DayDropDownMenu:Hide() end
    if ind ~= 3 then f.GRM_YearDropDownMenu:Hide() end
end

local function ResetDeath()
    local player = GRM.GetPlayer(GRM_G.currentName)
    local clearDeath = false
    if player then
        local noteToCheck = player.note
        if GRM_G.BuildHasRestrictions then noteToCheck = player.customNote[4] end

        if noteToCheck:find("%[" .. GRM.L("D") .. "%]") then
            if not GRM_G.BuildHasRestrictions then
                if GRM.CanEditPublicNote() then
                    local newNote = string.gsub(noteToCheck:gsub("%[" .. GRM.L("D") .. "%]%-%d%d%d%d%d%d%d%d", ""), "%[" .. GRM.L("D") .. "%]", "")
                    newNote = GRM.Util.Trim(newNote)

                    if newNote ~= noteToCheck then
                        local i = GRM.GetRosterSelectionID(player.name, player.GUID)
                        if i then
                            local simpleName = GRM.GetStringClassColorByName(player.name) .. GRM.SlimName(player.name) .. "|r"
                            local logReportWithTime, logReport = GRM.GetNoteChangeString(simpleName, noteToCheck, newNote, GRM.Time.GetTimestamp())

                            if GRM.S().toChat.note then GRM.Log.PrintLog({4, logReport}) end
                            GRM.Log.AddLog({4, logReportWithTime, simpleName, noteToCheck, newNote, GRM.Time.GetTimestamp()})
                            player.note = newNote
                            GRM.SetNote(player.GUID, newNote, true, i)
                            clearDeath = true
                        end
                    end
                else
                    GRM.Report(GRM.L("The \"{custom1}\" indicates the player is dead.", nil, nil, nil, "[" .. GRM.L("D") .. "]") .. "\n" .. GRM.L("Your rank does not have permission to remove the tag."), GRM.S().logColor[15][1], GRM.S().logColor[15][2], GRM.S().logColor[15][3])
                end
            else
                local newNote = string.gsub(noteToCheck:gsub("%[" .. GRM.L("D") .. "%]%-%d%d%d%d%d%d%d%d", ""), "%[" .. GRM.L("D") .. "%]", "")
                newNote = GRM.Util.Trim(newNote)

                if newNote ~= noteToCheck then
                    player.customNote[2] = time()
                    player.customNote[3] = GRM_G.addonUser
                    player.customNote[4] = newNote
                    GRM.RecordCustomNoteChanges(newNote, noteToCheck, GRM_G.addonUser, player.name, true)
                end
            end
        else
            clearDeath = true
        end

        if clearDeath then
            player.HC.isDead = false
            player.HC.timeOfDeath = {0, 0, 0, 0, 0, false}
            GRM.Report(GRM.L("{name} is no longer reported as Dead.", GRM.GetClassifiedName(player.name, true)), GRM.S().logColor[15][1], GRM.S().logColor[15][2], GRM.S().logColor[15][3])
            if f:IsVisible() then
                GRM_UI.ClearAllFrames(false)
                GRM_UI.PopulateMemberDetails(GRM_G.currentName)
            end
            GRM_UI.RefreshSelectFrames(true, true, false, true, true, false)
        end
    end
end

-- Method:          ConfigureOnlineStatusText()
-- What it Does:    So you don't need to reprocess this over and over, it translates it all just one time.
-- Purpose:         Just resource saving.
local function ConfigureOnlineStatusText()
    local list = {"( Active )", "( Mobile )", "( Offline )", "( AFK )", "( Busy )"};

    for i = 1, #list do
        GRM_G.Status[i] = GRM.L(list[i]);
    end

end

-- RECONFIGURE FONTS LOGIC
local function ReconfigureNoteFonts()
    f.GRM_PlayerNoteWindow.GRM_noteFontString1:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12)
    f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12)
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetFontObject("GameFontWhite")
    if not GRM_G.BuildHasRestrictions then
        f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetFontObject("GameFontWhite")
        f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetFontObject("GameFontWhite")
    end
end

local function ReEnableSubIgnoreOption(button, text, editBox)
    button:Enable(); editBox:Enable()
    text:SetTextColor(1, 0.82, 0); editBox:SetTextColor(1, 1, 1)
end

local function DisableSubIgnoreOption(button, text, editBox)
    button:Disable(); editBox:Disable()
    text:SetTextColor(0.5, 0.5, 0.5); editBox:SetTextColor(0.5, 0.5, 0.5)
end

local function SetGroupInviteButton(handle)
    local SetTooltip = function(show)
        if show then
            f.GRM_GroupInviteButton:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
                GameTooltip:AddLine(GRM.L("Unable to invite. You are grouped without privileges."))
                GameTooltip:Show()
            end)
        else
            f.GRM_GroupInviteButton:SetScript("OnEnter", nil)
        end
        f.GRM_GroupInviteButton:SetScript("OnLeave", GRM.RestoreTooltip)
    end

    local setButtonAction = function()
        f.GRM_GroupInviteButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then C_PartyInfo.InviteUnit(handle) end
        end)
        SetTooltip(false)
    end

    if GetNumGroupMembers() > 0 then
        if UnitIsGroupLeader("PLAYER") or UnitIsGroupAssistant("PLAYER", LE_PARTY_CATEGORY_HOME) then
            setButtonAction()
        else
            SetTooltip(true)
        end
    else
        setButtonAction()
    end

    if f.GRM_GroupInviteButton.GRM_GroupInviteButtonText:GetText() ~= nil then
        GRM_UI.ScaleFontStringToObjectSize(true, f.GRM_GroupInviteButton:GetWidth(), f.GRM_GroupInviteButton.GRM_GroupInviteButtonText, 4)
    end
end


-----------------------------------
---- CORE MOUSEOVER MODULE --------
-----------------------------------

GRM_UI.InitializeMouseover = function(isManualUpdate)
    GRM_G.BuildHasRestrictions = false; -- TO DO - Remove this
    -- Core Frame
    GRM_UI.CreateCoreFrame("GRM_Mouseover", GRM_UI , UIParent, 400, 438, "TranslucentFrameTemplate", false, nil, nil, true, false)
    GRM_UI.GRM_Mouseover.timer = 0
    f = GRM_UI.GRM_Mouseover
    f:Hide()
    f:EnableMouse(true)
    f:SetToplevel(true)
    f.alts = {}

    -- Group Invite
    GRM_UI.CreateButton("GRM_GroupInviteButton", f, "GameMenuButtonTemplate", GRM.L("Group Invite"), 93, 26, {"BOTTOMLEFT", f, "BOTTOMLEFT", 16, 13}, nil, "GameFontWhiteTiny", 11, "CENTER")

    -- Safe From Rules
    GRM_UI.CreateButton("GRM_SafeFromRulesButton", f, "GameMenuButtonTemplate", GRM.L("Macro Rules"), 93, 26, {"LEFT", f.GRM_GroupInviteButton, "RIGHT", 5, 0}, nil, "GameFontWhiteTiny", 11, "CENTER")
    GRM_UI.ScaleFontStringToObjectSize(true, f.GRM_SafeFromRulesButton:GetWidth(), f.GRM_SafeFromRulesButton.GRM_SafeFromRulesButtonText, 2)

    -- Populating Frames with FontStrings
    GRM_UI.CreateString("GRM_MemberDetailNameText", f, "GameFontNormalLarge", "", 21, {"TOP", f, "TOP", 0, -30})
    GRM_UI.CreateString("GRM_MemberDetailMainText", f, "GameFontWhiteTiny", GRM.L("( Main )"), 10, {"BOTTOM", f.GRM_MemberDetailNameText, "TOP", 0, 2}, nil, {1.0, 0.0, 0.0})
    GRM_UI.CreateString("GRM_MemberDetailAltText", f, "GameFontWhiteTiny", "( " .. GRM.L("Alt") .. " )", 10, {"BOTTOM", f.GRM_MemberDetailNameText, "TOP", 0, 2}, nil, {1.0, 0.5, 0.5})
    
    GRM_UI.CreateString("GRM_MemberDetailLevel", f, "GameFontNormalSmall", "", 11, {"TOP", f.GRM_MemberDetailNameText, "BOTTOM", 0, -4})
    GRM_UI.CreateString("GRM_MemberDetailRankTxt", f, "GameFontNormal", "", 18, {"TOP", f.GRM_MemberDetailLevel, "BOTTOM", 0, -2}, nil, {0.90, 0.80, 0.50})
    GRM_UI.CreateString("GRM_MemberDetailRankDateTxt", f, "GameFontNormalSmall", "", 11, {"TOP", f.GRM_MemberDetailRankTxt, "BOTTOM", 0, -4}, nil, {1, 1, 1})
    
    GRM_UI.CreateButton("GRM_SetPromoDateButton", f, "GameMenuButtonTemplate", GRM.L("Date Promoted"), 119, 24, {"TOP", f.GRM_MemberDetailRankTxt, "BOTTOM", 0, -4}, nil, "GameFontWhiteTiny", 12, "CENTER")
    GRM_UI.ScaleFontStringToObjectSize(true, f.GRM_SetPromoDateButton:GetWidth(), f.GRM_SetPromoDateButton.GRM_SetPromoDateButtonText, 2)

    -- Dropdowns
    GRM_UI.CreateDropDownMenu("GRM_MonthDropDown", f, nil, {"TOP", f.GRM_MemberDetailRankTxt, "BOTTOM", -86.5, -4}, {110, 24}, GetMonthList(), 13, {1,1,1},
                              {1, GRM.L("|CFFE6CC7FClick|r to Change Month")}, GRM.RestoreTooltip, function(idx) GRM_G.monthIndex = idx end, nil, nil, true,
                              function() CloseOtherDateDropdowns(1) end, 4)
    
    GRM_UI.CreateDropDownMenu("GRM_DayDropDown", f, nil, {"LEFT", f.GRM_MonthDropDownSelected, "RIGHT", 5, 0}, {40, 24}, GetDayList(), 13, {1,1,1},
                              {1, GRM.L("|CFFE6CC7FClick|r to Change Day")}, GRM.RestoreTooltip, function(idx) GRM_G.dayIndex = tonumber(GetDayList()[idx]) end, nil, nil, true,
                              function() CloseOtherDateDropdowns(2) end, 4)

    GRM_UI.CreateDropDownMenu("GRM_YearDropDown", f, nil, {"LEFT", f.GRM_DayDropDownSelected, "RIGHT", 5, 0}, {110, 24}, GetYearList(), 13, {1,1,1},
                             {1, GRM.L("|CFFE6CC7FClick|r to Change Year")}, GRM.RestoreTooltip, function(idx) GRM_G.yearIndex = tonumber(GetYearList()[idx]) end, nil, nil, true,
                             function() CloseOtherDateDropdowns(3) end, 4)
    
    -- Date Submit/Cancel/Unknown
    GRM_UI.CreateButton("GRM_DateSubmitButton", f, "UIPanelButtonTemplate", "", 98.5, 22, {"TOP", f.GRM_MonthDropDownSelected, "BOTTOM", -26, -3}, nil, "GameFontWhiteTiny", 10.5, "CENTER")
    f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetSpacing(0);
    f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetWordWrap(true)
    
    GRM_UI.CreateButton("GRM_SetUnknownButton", f, "GameMenuButtonTemplate", GRM.L("Unknown"), 98.5, 22, {"LEFT", f.GRM_DateSubmitButton, "RIGHT", 6, 0}, nil, "GameFontWhiteTiny", 10.5, "CENTER")
    GRM_UI.CreateButton("GRM_DateSubmitCancelButton", f, "UIPanelButtonTemplate", GRM.L("Cancel"), 98.5, 22, {"LEFT", f.GRM_SetUnknownButton, "RIGHT", 6, 0}, nil, "GameFontWhiteTiny", 10.5, "CENTER")

    -- Member Info
    GRM_UI.CreateString("GRM_MemberDetailDateJoinedTitleTxt", f, "GameFontNormalSmall", GRM.L("Date Joined"), 12, {"TOPRIGHT", f, "TOPRIGHT", -10, -32}, 106, nil, "CENTER")
    f.GRM_MemberDetailDateJoinedTitleTxt:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12, "THICKOUTLINE")
    GRM_UI.CreateButton("GRM_MemberDetailJoinDateButton", f, "GameMenuButtonTemplate", GRM.L("Join Date?"), 106, 22.5, {"TOP", f.GRM_MemberDetailDateJoinedTitleTxt, "BOTTOM", -2, -2}, nil, "GameFontWhiteTiny", 11, "CENTER")
    GRM_UI.ScaleFontStringToObjectSize(true, f.GRM_MemberDetailJoinDateButton:GetWidth(), f.GRM_MemberDetailJoinDateButton.GRM_MemberDetailJoinDateButtonText, 2)
    GRM_UI.CreateString("GRM_JoinDateText", f, "GameFontWhiteTiny", "", 11, {"TOP", f.GRM_MemberDetailDateJoinedTitleTxt, "BOTTOM", -3, -2})
    
    GRM_UI.CreateString("GRM_MemberDetailBirthdayTitleText", f, "GameFontNormalSmall", GRM.L("Birthday"), 12, {"TOP", f.GRM_MemberDetailJoinDateButton, "BOTTOM", 0, -5})
    f.GRM_MemberDetailBirthdayTitleText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12, "THICKOUTLINE")
    GRM_UI.CreateButton("GRM_MemberDetailBirthdayButton", f, "GameMenuButtonTemplate", GRM.L("Set Birthday"), 106, 22.5, {"TOP", f.GRM_MemberDetailBirthdayTitleText, "BOTTOM", 0, 0}, nil, "GameFontWhiteTiny", 10, "CENTER")
    f.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText:SetWidth(100);
    f.GRM_MemberDetailBirthdayButton.GRM_MemberDetailBirthdayButtonText:SetWordWrap(true)
    GRM_UI.CreateString("GRM_BirthdayText", f, "GameFontWhiteTiny", "", 11, {"TOP", f.GRM_MemberDetailBirthdayTitleText, "BOTTOM", -1.5, -2}, 89, nil, "CENTER")
    f.GRM_BirthdayText:Hide()

    -- Last Online / Status
    GRM_UI.CreateString("GRM_MemberDetailLastOnlineTitleTxt", f, "GameFontNormalSmall", GRM.L("Last Online"), 12, {"TOPLEFT", f, "TOPLEFT", 8, -32}, 106, nil, "CENTER")
    f.GRM_MemberDetailLastOnlineTitleTxt:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12, "THICKOUTLINE")
    GRM_UI.CreateString("GRM_MemberDetailLastOnlineTxt", f, "GameFontWhiteTiny", "", 10, {"TOP", f.GRM_MemberDetailLastOnlineTitleTxt, "BOTTOM", -2, -2}, 86, nil, "CENTER")
    GRM_UI.CreateString("GRM_MemberDetailPlayerStatus", f, "GameFontNormalSmall", "", 12, {"TOP", f.GRM_MemberDetailLastOnlineTxt, "BOTTOM", 0, -18}, 100, nil, "CENTER")

    -- Reputation
    GRM_UI.CreateString("GRM_ReputationLevelText", f, "GameFontWhiteTiny", "", 11, {"BOTTOM", f.GRM_MemberDetailDateJoinedTitleTxt, "TOP", -2, 3})

    -- Locked Message
    GRM_UI.CreateString("GRM_WindowIsLockedText", f, "GameFontWhiteTiny", GRM.L("Locked. Press ESC"), 10, {"BOTTOMRIGHT", f, "TOPRIGHT", -5, -4}, nil, {1, 0, 0})
    f.GRM_WindowIsLockedText:Hide()

    -- Zone Info
    GRM_UI.CreateString("GRM_ZoneInfoTime1", f, "GameFontNormalSmall", GRM.L("Time In:") .. " ", 11, {"BOTTOMLEFT", f.GRM_MemberDetailNoteTitle, "TOPLEFT", 5, 15})
    GRM_UI.CreateString("GRM_ZoneInfoTime2", f, "GameFontWhiteTiny", "", 11, {"LEFT", f.GRM_ZoneInfoTime1, "RIGHT", 2, 0})
    GRM_UI.CreateString("GRM_ZoneInfoText", f, "GameFontNormalSmall", GRM.L("Zone:"), 12, {"BOTTOMLEFT", f.GRM_ZoneInfoTime1, "TOPLEFT", -5, 2})
    f.GRM_ZoneInfoText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12, "THICKOUTLINE")
    GRM_UI.CreateString("GRM_MemberDetailMetaZoneInfoZoneText", f, "GameFontWhiteTiny", "", 12, {"LEFT", f.GRM_ZoneInfoText, "RIGHT", 2, 0})

    -- Note Windows
    GRM_UI.CreateCoreFrame("GRM_PlayerNoteWindow", f, nil, 166, 53, BackdropTemplateMixin and "BackdropTemplate", false, {"LEFT", f, "LEFT", 15, 10}, nil, false, false)
    f.GRM_PlayerNoteWindow:SetPoint("LEFT", f, "LEFT", 15, 10)
    GRM_UI.CreateString("GRM_MemberDetailNoteTitle", f.GRM_PlayerNoteWindow, "GameFontNormalSmall", GRM.L("Note:"), 11, {"BOTTOMLEFT" , f.GRM_PlayerNoteWindow , "TOPLEFT" , 5 , 0 }, 159, nil, "LEFT")
    GRM_UI.CreateString("GRM_noteFontString1", f.GRM_PlayerNoteWindow, "GameFontWhite", "", 12, {"TOPLEFT", f.GRM_PlayerNoteWindow, "TOPLEFT", 8, -7}, 143, nil, "LEFT", true)
    f.GRM_PlayerNoteWindow.GRM_noteFontString1:SetMaxLines(3)

    GRM_UI.CreateEditBox("GRM_PlayerNoteEditBox", f.GRM_PlayerNoteWindow, nil, 166, 60, {"TOP", f.GRM_PlayerNoteWindow, "TOP", 0, 0}, "LEFT", {1,1,1}, 31, false)
    f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetMultiLine(true);
    f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetTextInsets(8, 9, 9, 8);
    f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetFrameStrata("HIGH");
    f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:Hide()
    
    GRM_UI.CreateCoreFrame("GRM_PlayerOfficerNoteWindow", f, nil, 166, 53, BackdropTemplateMixin and "BackdropTemplate", false, {"RIGHT", f, "RIGHT", -15, 10}, nil, false, false)
    f.GRM_PlayerOfficerNoteWindow:SetPoint("RIGHT", f, "RIGHT", -15, 10)
    GRM_UI.CreateString("GRM_MemberDetailONoteTitle", f.GRM_PlayerOfficerNoteWindow, "GameFontNormalSmall", GRM.L("Officer's Note:"), 11, {"BOTTOMLEFT" , f.GRM_PlayerOfficerNoteWindow , "TOPLEFT" , 5 , 0}, 159, nil, "LEFT")
    GRM_UI.CreateString("GRM_noteFontString2", f.GRM_PlayerOfficerNoteWindow, "GameFontWhite", "", 12, {"TOPLEFT", f.GRM_PlayerOfficerNoteWindow, "TOPLEFT", 8, -7}, 143, nil, "LEFT", true)
    f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:SetMaxLines(3)
    
    GRM_UI.CreateEditBox("GRM_PlayerOfficerNoteEditBox", f.GRM_PlayerOfficerNoteWindow, nil, 166, 60, {"TOP", f.GRM_PlayerOfficerNoteWindow, "TOP", 0, 0}, "LEFT", {1,1,1}, 31, false)
    f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetMultiLine(true);
    f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetTextInsets(8, 9, 9, 8);
    f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetFrameStrata("HIGH");
    f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:Hide()

    GRM_UI.CreateString("GRM_NoteCount", f, "GameFontWhite", "", 11, {"TOPRIGHT", f.GRM_PlayerNoteWindow, "TOPRIGHT", -6, 8})

    -- Custom Note
    GRM_UI.CreateCoreFrame("GRM_CustomNoteEditBoxFrame", f, nil, 166, 113, BackdropTemplateMixin and "BackdropTemplate", false, {"TOPLEFT", f.GRM_PlayerNoteWindow, "BOTTOMLEFT", 0, -10}, nil, false, false)
    f.GRM_CustomNoteEditBoxFrame:SetPoint("TOPLEFT", f.GRM_PlayerNoteWindow, "BOTTOMLEFT", 0, -10)
    GRM_UI.CreateString("GRM_CustomNoteEditBoxText", f.GRM_CustomNoteEditBoxFrame, "GameFontNormal", GRM.L("Custom Public Notes:"), 11, {"BOTTOMLEFT", f.GRM_CustomNoteEditBoxFrame, "TOPLEFT", 5, 0}, nil, nil, "LEFT")
    GRM_UI.CreateString("GRM_CustomNoteTextCount", f.GRM_CustomNoteEditBoxFrame, "GameFontWhiteTiny", "", 11, {"LEFT", f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBoxText, "RIGHT", 5, 0})
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:Hide()
    GRM_UI.CreateCheckBox("GRM_CustomNoteSyncMetaCheckBox", f.GRM_CustomNoteEditBoxFrame, "InterfaceOptionsCheckButtonTemplate", {26,26}, {"TOPLEFT", f.GRM_CustomNoteEditBoxFrame, "BOTTOMLEFT", 35, 2}, nil, "Sync:", "GameFontNormalSmall", 11)
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteSyncMetaCheckBoxText:ClearAllPoints();
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteSyncMetaCheckBoxText:SetPoint("RIGHT", f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox, "LEFT", 0, 1.5)

    GRM_UI.CreateEditBox("GRM_CustomNoteEditBox", f.GRM_CustomNoteEditBoxFrame, nil, 159, 106, {"TOPLEFT", f.GRM_CustomNoteEditBoxFrame, "TOPLEFT", 2, -1.5}, "LEFT", {1,1,1}, GRM_G.MaxCustomNoteSize, false)
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetMultiLine(true); f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetTextInsets(7, -10, 10, 6)

    GRM_UI.CreateButton("GRM_ConfirmCustomNoteButton", f, "GameMenuButtonTemplate", GRM.L("Confirm"), 80, 22, {"TOPRIGHT", f.GRM_CustomNoteEditBoxFrame, "BOTTOM", -2.5, -22}, nil, "GameFontWhiteTiny", 12, "CENTER")
    GRM_UI.CreateButton("GRM_CancelCustomNoteButton", f, "GameMenuButtonTemplate", GRM.L("Cancel"), 80, 22, {"TOPLEFT", f.GRM_CustomNoteEditBoxFrame, "BOTTOM", 2.5, -22}, nil, "GameFontWhiteTiny", 12, "CENTER")
    f.GRM_ConfirmCustomNoteButton:Hide(); f.GRM_CancelCustomNoteButton:Hide()

    --- Scroll Frame for Custom Note
    GRM_UI.CreateScrollFrame("GRM_CustomNoteScrollFrame", f.GRM_CustomNoteEditBoxFrame, 163, 98, {"BOTTOM", f.GRM_CustomNoteEditBoxFrame, "BOTTOM", 1, 5}, "GRM_CustomNoteEditBox", true,
                             "GRM_CustomNoteScrollFrameSlider", GRM_G.SliderTemplate, {16, 78}, {"LEFT", f.GRM_CustomNoteEditBoxFrame, "RIGHT", 2, 0})
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide()

    if not GRM.S() or GRM.S().showBorders then
        f.GRM_PlayerNoteWindow:SetBackdrop ( GRM_UI.noteBackdrop );
        f.GRM_PlayerOfficerNoteWindow:SetBackdrop ( GRM_UI.noteBackdrop );
        f.GRM_CustomNoteEditBoxFrame:SetBackdrop ( GRM_UI.noteBackdrop );
    else
        f.GRM_PlayerNoteWindow:SetBackdrop ( GRM_UI.framelessBackdrop );
        f.GRM_PlayerOfficerNoteWindow:SetBackdrop ( GRM_UI.framelessBackdrop );
        f.GRM_CustomNoteEditBoxFrame:SetBackdrop ( GRM_UI.framelessBackdrop );
    end

    -- Tooltips
    f.GRM_MemberDetailRankToolTip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailRankToolTip" , f , "GameTooltipTemplate" );
    f.GRM_MemberDetailJoinDateToolTip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailJoinDateToolTip" , f , "GameTooltipTemplate" );
    f.GRM_MemberDetailServerNameToolTip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailServerNameToolTip" , f , "GameTooltipTemplate" );
    f.GRM_MemberDetailNotifyStatusChangeTooltip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailNotifyStatusChangeTooltip" , f , "GameTooltipTemplate" );
    f.GRM_MemberDetailNJDSyncTooltip = CreateFrame ( "GameTooltip" , "GRM_MemberDetailNJDSyncTooltip" , f , "GameTooltipTemplate" );
    f.GRM_OfficerNoteTooltip = CreateFrame ( "GameTooltip" , "GRM_OfficerNoteTooltip" , nil , "GameTooltipTemplate" );
    f.GRM_OfficerNoteTooltip:SetScale ( 0.65 );
    f.GRM_BirthdayTooltip = CreateFrame ( "GameTooltip" , "GRM_BirthdayTooltip" , f , "GameTooltipTemplate" );
    
    f.GRM_MemberDetailRankToolTip:Hide()
    f.GRM_MemberDetailJoinDateToolTip:Hide()
    f.GRM_MemberDetailServerNameToolTip:Hide()
    f.GRM_MemberDetailNotifyStatusChangeTooltip:Hide()
    f.GRM_MemberDetailNJDSyncTooltip:Hide()
    f.GRM_OfficerNoteTooltip:Hide()
    f.GRM_BirthdayTooltip:Hide()

    -- Sync Join Date Side Frame Options
    GRM_UI.CreateCoreFrame("GRM_SyncJoinDateSideFrame", f, nil, 438, 146, "TranslucentFrameTemplate", false, {"TOPLEFT", f, "TOPRIGHT", -7, 0}, "HIGH", false, true)
    local JoinDateSideFrame = f.GRM_SyncJoinDateSideFrame
    JoinDateSideFrame.timer = 0
    JoinDateSideFrame:Hide()
    
    GRM_UI.CreateString("GRM_SyncJoinDateText", JoinDateSideFrame, "GameFontNormalSmall", GRM.L("Please Select Which Join Date to Sync"), 12, {"TOP", JoinDateSideFrame, "TOP", 0, -15}, 379, nil, "CENTER")
    JoinDateSideFrame.GRM_SyncJoinDateText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12, "THICKOUTLINE")
    
    GRM_UI.CreateButton("GRM_JDOldestButton", JoinDateSideFrame, nil, "", 366, 24, {"TOPLEFT", JoinDateSideFrame, "TOPLEFT", 10, -25}, nil, "GameFontNormal", 11, "LEFT", 10)
    JoinDateSideFrame.GRM_JDOldestButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
    
    GRM_UI.CreateButton("GRM_JDMainButton", JoinDateSideFrame, nil, "", 366, 24, {"TOPLEFT", JoinDateSideFrame.GRM_JDOldestButton, "BOTTOMLEFT", 0, 0}, nil, "GameFontNormal", 11, "LEFT", 10)
    JoinDateSideFrame.GRM_JDMainButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
    
    GRM_UI.CreateButton("GRM_JDSelectedPlayerButton", JoinDateSideFrame, nil, "", 366, 24, {"TOPLEFT", JoinDateSideFrame.GRM_JDMainButton, "BOTTOMLEFT", 0, 0}, nil, "GameFontNormal", 11, "LEFT", 10)
    JoinDateSideFrame.GRM_JDSelectedPlayerButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
    
    GRM_UI.CreateButton("GRM_JDSyncCancelButton", JoinDateSideFrame, nil, GRM.L("Cancel"), 366, 24, {"BOTTOMLEFT", JoinDateSideFrame, "BOTTOMLEFT", 10, 10}, function() GRM_UI.PopulateMemberDetails(GRM_G.currentName); JoinDateSideFrame:Hide() end, "GameFontNormal", 11, "LEFT", 10)
    JoinDateSideFrame.GRM_JDSyncCancelButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")

    -- Arrow popup textures
    GRM_UI.CreateButton("GRM_SyncDateArrowButton", f, "UIPanelScrollUpButtonTemplate", "", 12, 12, {"LEFT", f.GRM_JoinDateText, "RIGHT", 8, -0.5})
    f.GRM_SyncDateArrowButton:GetNormalTexture():SetRotation(-1.57)
    f.GRM_SyncDateArrowButton:GetPushedTexture():SetRotation(-1.57)
    
    GRM_UI.CreateButton("GRM_ExtraAltDetailsArrowButton", f, "UIPanelScrollUpButtonTemplate", "", 12, 12, {"TOPRIGHT", f.GRM_PlayerOfficerNoteWindow, "BOTTOMRIGHT", 0, -2})
    f.GRM_ExtraAltDetailsArrowButton:GetNormalTexture():SetRotation(-1.57)
    f.GRM_ExtraAltDetailsArrowButton:GetPushedTexture():SetRotation(-1.57)

    -- Heads-up text if player was previously banned
    GRM_UI.CreateButton("GRM_MemberDetailBannedIgnoreButton", f, "GameMenuButtonTemplate", GRM.L("Ignore Ban"), 113, 22, {"BOTTOMLEFT", f, "TOPLEFT", 0, -2}, nil, "GameFontWhiteTiny", 11, "CENTER")
    GRM_UI.CreateString("GRM_MemberDetailBannedText1", f, "GameFontNormalSmall", GRM.L("WARNING!") .. "\n" .. GRM.L("Player Was Previously Banned!"), 11, {"BOTTOMLEFT", f.GRM_MemberDetailBannedIgnoreButton, "TOPLEFT", 0, 2}, 400, {1.0, 0.0, 0.0}, "LEFT", true)

    -- ALT FRAMES!!!
    GRM_UI.CreateCoreFrame("GRM_CoreAltFrame", f, nil, 170, 150, nil, false, {"TOP", f.GRM_PlayerOfficerNoteWindow, "BOTTOM", 0, -10}, nil, false, false)
    f.GRM_CoreAltFrame:SetPoint("TOP", f.GRM_PlayerOfficerNoteWindow, "BOTTOM", 0, -10)
    GRM_UI.CreateScrollFrame("GRM_CoreAltScrollFrame", f.GRM_CoreAltFrame, 170, 140, {"TOP", f.GRM_CoreAltFrame, "TOP", 0, -2}, "GRM_CoreAltScrollChildFrame", false, "GRM_CoreAltScrollFrameSlider",
                             GRM_G.SliderTemplate, {16, 109}, {"TOPLEFT", f.GRM_CoreAltFrame.GRM_CoreAltScrollFrame, "TOPRIGHT", 10, -13})
    f.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Hide()

    local altSlider = f.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider
    altSlider:SetOrientation("VERTICAL")
    altSlider:SetValue(0)
    altSlider:Hide()
    GRM_UI_Util.BuildSliderTextures(altSlider)

    -- ADD ALT EDIT FRAME
    GRM_UI.CreateCoreFrame("GRM_AddAltEditFrame", f.GRM_CoreAltFrame, nil, 173 + (#GRM_G.realmName * 3.5), 226, "TranslucentFrameTemplate", false,
                          {"BOTTOMLEFT", f, "BOTTOMRIGHT", -7, 0}, nil, true, false)
    local AddAltEditFrame = f.GRM_CoreAltFrame.GRM_AddAltEditFrame
    AddAltEditFrame:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", -7, 0)
    AddAltEditFrame:Hide()
    AddAltEditFrame:SetToplevel(true)
    
    GRM_UI.CreateScrollFrame("GRM_AddAltScrollFrame", AddAltEditFrame, AddAltEditFrame:GetWidth() - 10, 111.75, {"TOP", AddAltEditFrame.GRM_AddAltEditBox, "BOTTOM", 2, 0},
                             "GRM_AddAltScrollChildFrame", false, "GRM_AddAltScrollFrameSlider", GRM_G.SliderTemplate, {18, 95}, {"LEFT",
                             AddAltEditFrame.GRM_AddAltScrollFrame, "RIGHT", -2.5, 0})
    
    local aafSlider = AddAltEditFrame.GRM_AddAltScrollFrameSlider
    aafSlider:SetOrientation("VERTICAL"); aafSlider:SetValue(0)
    aafSlider:SetScript("OnValueChanged", function(self) AddAltEditFrame.GRM_AddAltScrollFrame:SetVerticalScroll(self:GetValue()) end)
    GRM_UI_Util.BuildSliderTextures(aafSlider)
    
    GRM_UI.CreateString("GRM_AddAltTitleText", AddAltEditFrame, "GameFontNormalSmall", GRM.L("Choose Alt"), 14.5, {"TOP", AddAltEditFrame, "TOP", 0, -15})
    if not isManualUpdate then AddAltEditFrame.GRM_AddAltTitleText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 14.5, "THICKOUTLINE") end
    
    GRM_UI.CreateString("GRM_AddAltEditFrameTextBottom", AddAltEditFrame, "GameFontWhiteTiny", GRM.L("(Press Enter to Select)") .. "\n" .. GRM.L("(Press Tab to Cycle)"), 11,
                        {"BOTTOMLEFT", AddAltEditFrame, "BOTTOMLEFT", 15, 13}, nil, {0.5, 0.5, 0.5}, "LEFT", true)
    GRM_UI.CreateString("GRM_AddAltEditFrameHelpText", AddAltEditFrame, "GameFontNormalSmall", "", 11, {"CENTER", AddAltEditFrame, "CENTER", 0, 0}, 146, {1, 0, 0}, nil, true)
    GRM_UI.CreateString("GRM_AddAltEditFrameHelpText2", AddAltEditFrame, "GameFontWhiteTiny", GRM.L("Shift-Click Name On Roster Also Works"), 11, {"BOTTOM", AddAltEditFrame, "BOTTOM", 0, 30}, 146, nil, nil, true)

    GRM_UI.CreateEditBox("GRM_AddAltEditBox", AddAltEditFrame, "InputBoxTemplate", 126 + (#GRM_G.realmName * 3.5), 25, {"TOP", AddAltEditFrame.GRM_AddAltTitleText, "BOTTOM", 0, -2}, "LEFT", {1,1,1}, 40, false)
    AddAltEditFrame.GRM_AddAltScrollFrame:SetPoint("TOP", AddAltEditFrame.GRM_AddAltEditBox, "BOTTOM", 2, 0)
    
    GRM_UI.CreateString("GRM_altFrameTitleText", f.GRM_CoreAltFrame, "GameFontNormalSmall", GRM.L("Player Alts"), 12, {"BOTTOM", f.GRM_CoreAltFrame, "TOP", 0, -2})
    f.GRM_CoreAltFrame.GRM_altFrameTitleText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 12, "THICKOUTLINE")

    GRM_UI.CreateButton("GRM_AddAltButton2", f.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame, "GameMenuButtonTemplate", GRM.L("Add Alt"), 86, 20,
                       {"CENTER", f.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame, "CENTER", 0, 0}, nil, "GameFontWhiteTiny", 11, "CENTER")
    GRM_UI.ScaleFontStringToObjectSize(true, f.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame.GRM_AddAltButton2:GetWidth(), f.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame.GRM_AddAltButton2.GRM_AddAltButton2Text, 2)

    -- ALT GROUP SCROLL FRAME
    GRM_UI.CreateCoreFrame("GRM_AltGroupingScrollBorderFrame", GRM_UI.GRM_Mouseover , UIParent, 340, 150, "TranslucentFrameTemplate", false, nil, "HIGH", true, false)
    local altGroupBorderFrame = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
    altGroupBorderFrame.timer1 = 0
    altGroupBorderFrame.timer2 = 0
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetClampedToScreen(true)
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide()
    GRM_UI.CreateString("GRM_AltGroupingScrollBorderFrameTitle", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "GameFontNormal", "", 16, {"BOTTOM", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "TOP", 0, -3})
    
    GRM_UI.CreateScrollFrame("GRM_AltGroupingScrollFrame", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, 320, 110, {"BOTTOM", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "BOTTOM", 0, 10},
                             "GRM_AltGroupingScrollChildFrame", false, "GRM_AltGroupingScrollFrameSlider", "UIPanelScrollBarTrimTemplate", {20, 85},
                             {"TOPLEFT", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame, "TOPRIGHT", -1.5, -14.5})

    GRM_UI.CreateString("GRM_MainTag", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame, "GameFontWhiteTiny", GRM.L("(main)"), 7, {"CENTER", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollChildFrame, "CENTER", 0, 0}, nil, {1.0, 0.0, 0.0})
    GRM_UI.CreateString("GRM_AltGroupingName", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "GameFontNormal", GRM.L("Name"), 10, {"TOPLEFT", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "TOPLEFT", 25, -15})
    GRM_UI.CreateString("GRM_AltGroupingLevel", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "GameFontNormal", GRM.L("Level"), 10, {"TOP", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "TOP", -60, -15}, 75, nil, "CENTER")
    GRM_UI.CreateString("GRM_AltGroupingRank", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "GameFontNormal", GRM.L("Rank"), 10, {"TOP", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "TOP", 8, -15}, 75, nil, "CENTER")
    GRM_UI.CreateString("GRM_AltGroupingLastOnline", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "GameFontNormal", GRM.L("Last Online"), 10, {"TOP", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "TOP", 98, -15}, 75, nil, "CENTER")
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupHeaderTooltip = CreateFrame("GameTooltip", "GRM_AltGroupHeaderTooltip", GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame, "GameTooltipTemplate")

    -- Horde/Ally icons
    GRM.CreateTexture(f, "GRM_HordeIconTexture", "BORDER", false)
    f.GRM_HordeIconTexture:SetPoint("BOTTOM", f.GRM_MemberDetailLastOnlineTitleTxt, "TOP", 0, -2)
    f.GRM_HordeIconTexture:SetTexture("Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\Horde_Icon.blp")
    f.GRM_HordeIconTexture:SetSize(22, 22)

    GRM.CreateTexture(f, "GRM_AllianceIconTexture", "BORDER", false)
    f.GRM_AllianceIconTexture:SetPoint("BOTTOM", f.GRM_MemberDetailLastOnlineTitleTxt, "TOP", 0, -2)
    f.GRM_AllianceIconTexture:SetTexture("Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\Alliance_Icon.blp")
    f.GRM_AllianceIconTexture:SetSize(22, 22)

    -- Hardcore Death Texture
    GRM_UI.CreateButton("GRM_ClearDeathButton", f, "UIPanelButtonTemplate", GRM.L("Player is Still Alive"), 200, 22, {"TOP", f, "BOTTOM", 0, 1}, ResetDeath, "GameFontWhite", 12)
    GRM_UI.CreateString("GRM_RIPtext", f, "GameFontNormal", "", 15, {"BOTTOM", f, "TOP", 0, 0}, nil, nil, "CENTER", false)

    GRM.CreateTexture(f, "GRM_DeathTexture", "ARTWORK", false)
    f.GRM_DeathTexture:SetPoint("CENTER", f, "CENTER", 0, 0)
    f.GRM_DeathTexture:SetTexture("Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\dead.png")
    f.GRM_DeathTexture:SetSize(350, 350)

    -- Member Mouseover window - macro tool checkbox frame
    GRM_UI.CreateCoreFrame("GRM_MacroToolIgnoreListSettingsFrame", f, nil, 400, 235, "TranslucentFrameTemplate", false, {"TOPLEFT", f, "BOTTOMLEFT", 0, 2}, nil, true, true)
    local IgnoreMacroFrame = f.GRM_MacroToolIgnoreListSettingsFrame
    IgnoreMacroFrame.modifier = 32
    IgnoreMacroFrame.Timer = 1
    IgnoreMacroFrame.currentName = ""
    
    GRM_UI.CreateString("GRM_ListFilterHeadingText", IgnoreMacroFrame, "GameFontNormalSmall", GRM.L("Macro Rule Ignore Lists"), 16, {"TOP", IgnoreMacroFrame, "TOP", 0, -12})
    GRM_UI.CreateString("GRM_ListFilterHeadingText2", IgnoreMacroFrame, "GameFontNormalSmall", GRM.L("Select categories you wish the player to be ignored"), 11, {"TOP", IgnoreMacroFrame.GRM_ListFilterHeadingText, "BOTTOM", 0, -2}, 372, {1,1,1}, "CENTER", true)
    
    GRM_UI.CreateCheckBox("GRM_IgnoreListFrameKickCheckBox", IgnoreMacroFrame, "InterfaceOptionsCheckButtonTemplate", {26, 26}, {"TOPLEFT", IgnoreMacroFrame, "TOPLEFT", 12, -43}, nil, GRM.L("Kick Rules"), "GameFontNormalSmall", 11)
    GRM_UI.CreateString("GRM_IgnoreListFrameKickCheckBoxText2", IgnoreMacroFrame, "GameFontNormalSmall", "", 11, {"RIGHT", IgnoreMacroFrame.GRM_IgnoreListFrameKickCheckBox, "RIGHT", 253, 0}, nil, nil, "RIGHT")
    GRM_UI.CreateCheckBox("GRM_IgnoreListKickTimeExpireButton", IgnoreMacroFrame, "InterfaceOptionsCheckButtonTemplate", {26, 26}, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListFrameKickCheckBox, "BOTTOMRIGHT", -10, -1}, nil, "", "GameFontNormalSmall", 11)
    GRM_UI.CreateString("GRM_IgnoreListKickTimeExpireButtonDateSetText", IgnoreMacroFrame, "GameFontNormalSmall", "", 9, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton.GRM_IgnoreListKickTimeExpireButtonText, "BOTTOMLEFT", 0, -7}, nil, {0.9, 0.8, 0.5}, "LEFT")
    GRM_UI.CreateString("GRM_IgnoreListKickTimeExpireButtonTimeLeftText", IgnoreMacroFrame, "GameFontNormalSmall", "", 9, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText, "BOTTOMLEFT", 0, -6}, nil, {0.9, 0.8, 0.5}, "LEFT")
    GRM_UI.CreateEditBox("GRM_IgnoreListKickTimeExpireEditBox", IgnoreMacroFrame, "InputBoxTemplate", 33, 29, {"LEFT", IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton.GRM_IgnoreListKickTimeExpireButtonText, "RIGHT", 8, 0}, nil, {1,0,0}, 3, true)
    
    -- Promote
    GRM_UI.CreateCheckBox("GRM_IgnoreListFramePromoteCheckBox", IgnoreMacroFrame, "InterfaceOptionsCheckButtonTemplate", {26, 26}, {"TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton, "BOTTOMLEFT", 10, -1}, nil, GRM.L("Promote Rules"), "GameFontNormalSmall", 11)
    GRM_UI.CreateString("GRM_IgnoreListFramePromoteCheckBoxText2", IgnoreMacroFrame, "GameFontNormalSmall", "", 11, {"RIGHT", IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox, "RIGHT", 253, 0}, nil, nil, "RIGHT")
    GRM_UI.CreateCheckBox("GRM_IgnoreListPromoteTimeExpireButton", IgnoreMacroFrame, "InterfaceOptionsCheckButtonTemplate", {26, 26}, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox, "BOTTOMRIGHT", -10, -1}, nil, "", "GameFontNormalSmall", 11)
    GRM_UI.CreateString("GRM_IgnoreListPromoteTimeExpireButtonDateSetText", IgnoreMacroFrame, "GameFontNormalSmall", "", 9, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton.GRM_IgnoreListPromoteTimeExpireButtonText, "BOTTOMLEFT", 0, -7}, nil, {0.9, 0.8, 0.5}, "LEFT")
    GRM_UI.CreateString("GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText", IgnoreMacroFrame, "GameFontNormalSmall", "", 9, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText, "BOTTOMLEFT", 0, -6}, nil, {0.9, 0.8, 0.5}, "LEFT")
    GRM_UI.CreateEditBox("GRM_IgnoreListPromoteTimeExpireEditBox", IgnoreMacroFrame, "InputBoxTemplate", 33, 29, {"LEFT", IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton.GRM_IgnoreListPromoteTimeExpireButtonText, "RIGHT", 8, 0}, nil, {1,0,0}, 3, true)

    -- Demote
    GRM_UI.CreateCheckBox("GRM_IgnoreListFrameDemoteCheckBox", IgnoreMacroFrame, "InterfaceOptionsCheckButtonTemplate", {26, 26}, {"TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton, "BOTTOMLEFT", 10, -1}, nil, GRM.L("Demote Rules"), "GameFontNormalSmall", 11)
    GRM_UI.CreateString("GRM_IgnoreListFrameDemoteCheckBoxText2", IgnoreMacroFrame, "GameFontNormalSmall", "", 11, {"RIGHT", IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox, "RIGHT", 253, 0}, nil, nil, "RIGHT")
    GRM_UI.CreateCheckBox("GRM_IgnoreListDemoteTimeExpireButton", IgnoreMacroFrame, "InterfaceOptionsCheckButtonTemplate", {26, 26}, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox, "BOTTOMRIGHT", -10, -1}, nil, "", "GameFontNormalSmall", 11)
    GRM_UI.CreateString("GRM_IgnoreListDemoteTimeExpireButtonDateSetText", IgnoreMacroFrame, "GameFontNormalSmall", "", 9, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton.GRM_IgnoreListDemoteTimeExpireButtonText, "BOTTOMLEFT", 0, -7}, nil, {0.9, 0.8, 0.5}, "LEFT")
    GRM_UI.CreateString("GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText", IgnoreMacroFrame, "GameFontNormalSmall", "", 9, {"TOPLEFT", IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText, "BOTTOMLEFT", 0, -6}, nil, {0.9, 0.8, 0.5}, "LEFT")
    GRM_UI.CreateEditBox("GRM_IgnoreListDemoteTimeExpireEditBox", IgnoreMacroFrame, "InputBoxTemplate", 33, 29, {"LEFT", IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton.GRM_IgnoreListDemoteTimeExpireButtonText, "RIGHT", 8, 0}, nil, {1,0,0}, 3, true)

    -- =============================================================
    -- ALL POST-CREATION SCRIPT LOGIC
    -- =============================================================

    if not isManualUpdate then
        GRM_UI.InitializeMouseoverUI_Logic()
    end

    ConfigureOnlineStatusText()
    ReconfigureNoteFonts()
    
end

GRM_UI.InitializeMouseoverUI_Logic = function()
    f.GRM_MouseoverCloseButton:HookScript("OnClick", function(_, button)
        if button == "LeftButton" then
            if not GRM_UI.MemberDetailFrame:IsVisible() then GRM_G.pause = false end
        end
    end);
    GRM_UI.SetCloseButtonTooltip(f.GRM_MouseoverCloseButton)

    f:SetScript("OnUpdate", GRM.MemberDetailToolTips)
    f:SetScript("OnKeyDown", function(self, key)
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput(true)
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput(false)
                if not GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then
                    if not GRM_UI.MemberDetailFrame:IsVisible() then
                        if GRM_G.pause then GRM_G.pause = false else self:Hide() end
                    else
                        GRM_UI.MemberDetailFrame:Hide()
                    end
                else
                    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide()
                end
            end
        else
            if not GRM_UI.MemberDetailFrame:IsVisible() then
                if GRM_G.pause then GRM_G.pause = false else self:Hide() end
            else
                GRM_UI.MemberDetailFrame:Hide()
            end
        end
    end);

    local function IsMouseOverAltButton()
        local result = false
        for i = 1, #f.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame.allFrameButtons do
            if f.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame.allFrameButtons[i][1]:IsMouseOver() then
                result = true; break
            end
        end
        return result
    end

    local function GetSelectedName(name)
        local focusName, altName, isMain = nil, nil, false
        if name then
            focusName, altName = name, name
            if f.GRM_MemberDetailMainText:IsVisible() then isMain = true end
        end
        return {focusName, altName, isMain}
    end

    local function MouseOverClearAllTooltips()
        f.GRM_MemberDetailRankToolTip:Hide()
        f.GRM_MemberDetailJoinDateToolTip:Hide()
        f.GRM_MemberDetailServerNameToolTip:Hide()
        f.GRM_MemberDetailNotifyStatusChangeTooltip:Hide()
        f.GRM_BirthdayTooltip:Hide()
    end

    -- For Fontstring logic handling (Right Click Context Menus hook)
    f:SetScript("OnMouseDown", function(_, button)
        if button == "RightButton" then
            if not IsMouseOverAltButton() then 
                local isOnActionableText = false
                local contextMenu = 0

                if f.GRM_MemberDetailNameText:IsMouseOver(2, -2, -2, 2) then
                    isOnActionableText, contextMenu = true, 1
                elseif f.GRM_MemberDetailPlayerStatus:IsVisible() and f.GRM_MemberDetailPlayerStatus:IsMouseOver(2, -2, -2, 2) then
                    isOnActionableText, contextMenu = true, 2
                elseif f.GRM_MemberDetailRankDateTxt:IsVisible() and f.GRM_MemberDetailRankDateTxt:IsMouseOver(2, -2, -2, 2) then
                    isOnActionableText, contextMenu = true, 3
                elseif f.GRM_JoinDateText:IsVisible() and f.GRM_JoinDateText:IsMouseOver(2, -2, -2, 2) then
                    isOnActionableText, contextMenu = true, 4
                elseif f.GRM_BirthdayText:IsVisible() and f.GRM_BirthdayText:IsMouseOver(2, -2, -2, 2) then
                    isOnActionableText, contextMenu = true, 5
                end

                if isOnActionableText then
                    GRM_G.selectedName = GetSelectedName(GRM_G.currentName)
                else
                    GRM_G.selectedName = GetSelectedName()
                end

                if GRM_G.selectedName[1] then 
                    MouseOverClearAllTooltips()
                    if contextMenu == 1 then
                        ConfigureRightClickPlayerNameWindow()
                    elseif contextMenu == 2 then
                        ConfigureStatusRightClickMenu()
                    elseif contextMenu == 3 then
                        ConfigurePromoteDateRightClickMenu()
                    elseif contextMenu == 4 then
                        ConfigureJoinDateRightClickMenu()
                    elseif contextMenu == 5 then
                        ConfigureBirthDayRightClickMenu()
                    end
                end
            end
        elseif button == "LeftButton" then
            if not IsShiftKeyDown() then
                if f.GRM_MemberDetailServerNameToolTip:IsVisible() and not f.GRM_MemberDetailNameText:IsMouseOver(2, -2, -2, 2) then
                    if GRM_G.tempAltName ~= "" then
                        GRM_UI.SelectPlayerOnRoster(GRM_G.tempAltName)
                    end
                end
            else
                if f.GRM_MemberDetailNameText:IsMouseOver(2, -2, -2, 2) then GRM_G.tempAltName = GRM_G.currentName end
                if GRM_G.tempAltName and GRM_G.tempAltName ~= "" then
                    GRM.GR_Roster_Click(GRM_G.tempAltName)
                    GRM_G.tempAltName = ""
                end
            end
        end
    end);

    f:SetScript("OnHide", function()
        GRM_UI.ClearAllFrames(false)
        if not GRM_UI.MemberDetailFrame:IsVisible() then
            GRM_G.pause = false
        else
            if GRM_G.pause then
                if GRM_UI.MemberDetailFrame then GRM_UI.MemberDetailFrame.LockedFrameText:Show() end
            end
        end
    end);

    f:SetScript("OnShow", function()
        local configured1 = false
        if GRM_UI.MemberDetailFrame and not GRM_UI.MemberDetailFrame.LockedFrameText then
            GRM_UI.CreateString("LockedFrameText", GRM_UI.MemberDetailFrame, "GameFontWhiteTiny", GRM.L("Locked. Press ESC"), 13, {"BOTTOMRIGHT", GRM_UI.MemberDetailFrame, "TOPRIGHT", -5, 0}, nil, {1,0,0})
            GRM_UI.MemberDetailFrame.LockedFrameText:Hide()
            
            GRM_UI.MemberDetailFrame:HookScript("OnHide", function()
                if not f:IsVisible() then GRM_G.pause = false end
                GRM_UI.GRM_GetJoinDateButton:Hide()
            end);
            GRM_UI.MemberDetailFrame:HookScript("OnShow", function()
                GRM_UI.GRM_GetJoinDateButton:Show()
            end);
        else
            configured1 = true
        end

        if configured1 then GRM_UI.MemberDetailFrame.LockedFrameText:Hide() end
    end);
    
    local JoinDateSideFrame = f.GRM_SyncJoinDateSideFrame
    JoinDateSideFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timer = self.timer + elapsed
        if self.timer > 2 then
            if not GRM.PlayerOrAltHasJD(GRM_G.currentName) then
                self:Hide()
            end
            self.timer = 0
        end
    end)
    
    JoinDateSideFrame.GRM_JDOldestButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            GRM.SyncJoinDateUsingEarliest()
            GRM_UI.PopulateMemberDetails(GRM_G.currentName)
            JoinDateSideFrame:Hide()
        end
    end);

    local function PlayerHasJoinDate(playerName)
        local result = {false, ""}
        local player = GRM.GetPlayer(playerName)
        if player and #player.joinDateHist[1][4] > 1 then
            result = {true, GRM.Time.FormatTimeStamp({player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]}, false, false)}
        end
        return result
    end

    JoinDateSideFrame:SetScript("OnShow", function(self)
        local count = 0
        local mainName = ""
        local playerHasJD = PlayerHasJoinDate(GRM_G.currentName)
        local oldestPlayerAndDate, oldestDate = GRM.GetAltWithOldestJoinDate(GRM_G.currentName)
        local mainHasJD = {}

        if f.GRM_MemberDetailMainText:IsVisible() then
            mainName = GRM_G.currentName
        else mainName = GRM.GetPlayerMain(GRM_G.currentName)
        end
        if mainName and mainName ~= "" and mainName ~= GRM_G.currentName then
            mainHasJD = PlayerHasJoinDate(mainName)
        end

        self.GRM_JDOldestButtonText:SetText(">  " .. GRM.L("Sync All Alts to the Earliest Join Date: {name}", GRM.GetClassifiedName(oldestPlayerAndDate, true)) .. " |CFFFF0000- " .. oldestDate)

        if mainName and mainName ~= "" and mainName ~= GRM_G.currentName and oldestPlayerAndDate ~= mainName and mainHasJD[1] then
            self.GRM_JDMainButtonText:SetText(">  " .. GRM.L("Sync All Alts to {name}'s |cffff0000(main)|r Join Date", GRM.GetClassifiedName(mainName, true)) .. " |CFFFF0000- " .. mainHasJD[2])
            self.GRM_JDMainButton:SetScript("OnClick", function(_, button)
                if button == "LeftButton" then
                    GRM.SyncJoinDateUsingMain(); GRM_UI.PopulateMemberDetails(GRM_G.currentName); JoinDateSideFrame:Hide()
                end
            end);
            self.GRM_JDMainButton:Show(); count = count + 1
        elseif oldestPlayerAndDate ~= GRM_G.currentName and playerHasJD[1] then
            self.GRM_JDMainButtonText:SetText(">  " .. GRM.L("Sync All Alts to {name}'s Join Date", GRM.GetClassifiedName(GRM_G.currentName, true)) .. " |CFFFF0000- " .. playerHasJD[2])
            self.GRM_JDMainButton:SetScript("OnClick", function(_, button)
                if button == "LeftButton" then
                    GRM.SyncJoinDateUsingCurrentSelected(); GRM_UI.PopulateMemberDetails(GRM_G.currentName); JoinDateSideFrame:Hide()
                end
            end);
            self.GRM_JDMainButton:Show(); count = count + 2
        end

        if count == 0 then
            self.GRM_JDMainButton:Hide(); self.GRM_JDSelectedPlayerButton:Hide()
            self:SetSize(439, 93)
        elseif count == 2 then
            self.GRM_JDSelectedPlayerButton:Hide()
            self:SetSize(439, 119)
        elseif count == 1 then
            if oldestPlayerAndDate[1] ~= GRM_G.currentName and playerHasJD[1] then
                self:SetSize(439, 146)
                self.GRM_JDSelectedPlayerButtonText:SetText(">  " .. GRM.L("Sync All Alts to {name}'s Join Date", GRM.GetClassifiedName(GRM_G.currentName, true)) .. " |CFFFF0000- " .. playerHasJD[2])
                self.GRM_JDSelectedPlayerButton:SetScript("OnClick", function(self2, button)
                    if button == "LeftButton" then
                        GRM.SyncJoinDateUsingCurrentSelected(); GRM_UI.PopulateMemberDetails(GRM_G.currentName); self2:Hide()
                    end
                end);
                self.GRM_JDSelectedPlayerButton:Show()
            else
                self:SetSize(439, 119)
                self.GRM_JDSelectedPlayerButton:Hide()
            end
        end
    end);

    JoinDateSideFrame:SetScript("OnKeyDown", function(self, key)
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput(true)
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput(false);
                self:Hide()
            end
        elseif key == "ESCAPE" then
            self:Hide()
        end
    end)

    local function GetRecordedDate(buttonName)
        local month, day, currentYear = select(2, GRM.Time.GetTodaysDate())
        local player = GRM.GetPlayer(GRM_G.currentName)

        if buttonName == "PromoRank" and not player.promoteDateUnknown and player.rankHist[1][7] then
            day, month, currentYear = player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]
        elseif buttonName == "JoinDate" and not player.joinDateUnknown and player.joinDateHist[1][1] > 0 then
            day, month, currentYear = player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]
        elseif buttonName == "Birthday" then
            local birthdayInfo = GRM.GetBirthday(player)
            if not birthdayInfo.unknown and birthdayInfo.date[1] ~= 0 then
                day, month = birthdayInfo.date[1], birthdayInfo.date[2]
            end
        end
        return day, month, currentYear
    end

    local function SetJoinDate(name, dayJoined, monthJoined, yearJoined)
        name = name or GRM_G.currentName
        dayJoined = dayJoined or tonumber(f.GRM_DayDropDownSelected.GRM_DayDropDownSelectedText:GetText())
        monthJoined = monthJoined or GRM.Time.Enums.months_full_name[GRML.OrigL(f.GRM_MonthDropDownSelected.GRM_MonthDropDownSelectedText:GetText())]
        yearJoined = yearJoined or tonumber(f.GRM_YearDropDownSelected.GRM_YearDropDownSelectedText:GetText())

        if GRM.Time.IsValidSubmitDate(dayJoined, monthJoined, yearJoined, GRM.Time.IsLeapYear(yearJoined)) then
            local rankButton, showBdayText = false, false
            local formatBdayStamp = ""
            local player = GRM.GetPlayer(name)

            if player then
                if f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:GetText() == GRM.L("Edit Join Date") or player.joinDateHist[1][1] == 0 then
                    table.remove(player.joinDateHist, 1)
                end

                table.insert(player.joinDateHist, 1, {dayJoined, monthJoined, yearJoined, GRM.Time.ConvertToStandardFormatDate(dayJoined, monthJoined, yearJoined), time(), true, 1})
                player.joinDateUnknown = false

                local birthdayInfo = GRM.GetBirthday(player)
                if birthdayInfo.date[1] ~= 0 then
                    showBdayText = true
                    formatBdayStamp = GRM.Time.FormatTimeStamp({ birthdayInfo.date[1], birthdayInfo.date[2] }, false, true)
                end

                local finalTStamp = GRM.Time.FormatTimeStamp({dayJoined, monthJoined, yearJoined}, false, false, false)
                f.GRM_JoinDateText:SetText(finalTStamp)
                GRM.AddTimeStampToNote(name, player.GUID, finalTStamp)

                player.anniversaryAnnounced = false
                GRM.RemoveFromCalendarQue(name, 1, nil)

                GRM_UI.RefreshSelectFrames(false, true, false, false, false, true)

                if player.rankHist[1][2] == 0 and not player.promoteDateUnknown then
                    rankButton = true
                end

                if player.isOnline then
                    if player.zone ~= nil then
                        f.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone)
                        f.GRM_ZoneInfoTime2:SetText(GRM.Time.GetTimePassedInZone(player.timeEnteredZone))
                    end
                    f.GRM_ZoneInfoText:Show(); f.GRM_MemberDetailMetaZoneInfoZoneText:Show()
                    f.GRM_ZoneInfoTime1:Show(); f.GRM_ZoneInfoTime2:Show()
                end

                if GRM.S().syncEnabled then
                    local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
                    GRMsync.SendMessage("GRM_SYNC", "GRM_JD?" .. syncRankFilter .. "?" .. name .. "?" .. player.joinDateHist[1][4] .. "?" .. tostring(player.joinDateHist[1][5]), "GUILD")
                end
            end

            f.GRM_DayDropDownSelected:Hide(); f.GRM_MonthDropDownSelected:Hide(); f.GRM_YearDropDownSelected:Hide()
            f.GRM_DateSubmitCancelButton:Hide(); f.GRM_DateSubmitButton:Hide(); f.GRM_SetUnknownButton:Hide()
            f.GRM_JoinDateText:Show()
            
            if rankButton then f.GRM_SetPromoDateButton:Show() else f.GRM_MemberDetailRankDateTxt:Show() end

            if GRM.S().showBDay and not f.GRM_BirthdayText:IsVisible() and not f.GRM_MemberDetailBirthdayButton:IsVisible() then
                if showBdayText then
                    f.GRM_MemberDetailBirthdayButton:Hide()
                    f.GRM_BirthdayText:SetText(formatBdayStamp)
                    f.GRM_BirthdayText:Show()
                else
                    f.GRM_MemberDetailBirthdayButton:Show()
                    f.GRM_BirthdayText:Hide()
                end
            end

            if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
                if f.GRM_MemberDetailJoinDateButton:IsVisible() then
                    f.GRM_SyncDateArrowButton:ClearAllPoints()
                    f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_MemberDetailJoinDateButton, "RIGHT", 0, 0)
                elseif f.GRM_JoinDateText:IsVisible() then
                    f.GRM_SyncDateArrowButton:ClearAllPoints()
                    f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_JoinDateText, "RIGHT", 8, -0.5)
                end
                f.GRM_SyncDateArrowButton:Show()
            else
                f.GRM_SyncDateArrowButton:Hide()
            end

            GRM_UI.Unpause()
            GRM_UI.RefreshSelectFrames(false, true, false, true, true, true)
        end
    end

    local function SetPromoDate(name, day, month, year, isManual)
        name = name or GRM_G.currentName
        day = day or tonumber(f.GRM_DayDropDownSelected.GRM_DayDropDownSelectedText:GetText())
        month = month or GRM.Time.Enums.months_full_name[GRML.OrigL(f.GRM_MonthDropDownSelected.GRM_MonthDropDownSelectedText:GetText())]
        year = year or tonumber(f.GRM_YearDropDownSelected.GRM_YearDropDownSelectedText:GetText())

        if GRM.Time.IsValidSubmitDate(day, month, year, GRM.Time.IsLeapYear(year)) then
            local player = GRM.GetPlayer(name)

            if player then
                player.rankHist[1][1] = player.rankName
                player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4] = day, month, year
                player.rankHist[1][5] = GRM.Time.ConvertToStandardFormatDate(day, month, year)
                player.rankHist[1][6] = time()
                player.rankHist[1][7] = true
                player.rankHist[1][8] = 1

                player.promoteDateUnknown = false

                if name == GRM_G.currentName and f:IsVisible() then
                    f.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " .. GRM.Time.FormatTimeStamp({player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]}, false))

                    if player.isOnline then
                        if player.zone ~= nil then
                            f.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone)
                            f.GRM_ZoneInfoTime2:SetText(GRM.Time.GetTimePassedInZone(player.timeEnteredZone))
                        end
                        f.GRM_ZoneInfoText:Show(); f.GRM_MemberDetailMetaZoneInfoZoneText:Show()
                        f.GRM_ZoneInfoTime1:Show(); f.GRM_ZoneInfoTime2:Show()
                    end
                end

                if not isManual and GRM.S().syncEnabled then
                    local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
                    GRMsync.SendMessage("GRM_SYNC", "GRM_PD?" .. syncRankFilter .. "?" .. name .. "?" .. tostring(player.rankHist[1][5]) .. "?" .. tostring(player.rankHist[1][6]), "GUILD")
                end
            end

            if name == GRM_G.currentName and f:IsVisible() then
                f.GRM_DayDropDownSelected:Hide(); f.GRM_MonthDropDownSelected:Hide(); f.GRM_YearDropDownSelected:Hide()
                f.GRM_DateSubmitCancelButton:Hide(); f.GRM_DateSubmitButton:Hide(); f.GRM_SetUnknownButton:Hide()
                f.GRM_MemberDetailRankDateTxt:Show()

                GRM_UI.Unpause()
                GRM_UI.RefreshSelectFrames(false, true, false, true, true, true)
            end
        end
    end

    local function SetDateButtonConfiguration(formatNum)
        if formatNum == 1 then
            if GRM_G.formatNumber ~= formatNum then
                GRM_G.formatNumber = formatNum
                f.GRM_MonthDropDownSelected:SetPoint("TOP", f.GRM_MemberDetailRankTxt, "BOTTOM", -86.5, -4)
                f.GRM_DateSubmitButton:SetPoint("TOP", f.GRM_MonthDropDownSelected, "BOTTOM", -22, -3)
                f.GRM_DateSubmitCancelButton:SetPoint("LEFT", f.GRM_SetUnknownButton, "RIGHT", 6, 0)
            end
            f.GRM_YearDropDownSelected:Show()
            f.GRM_SetUnknownButton:Show()
        elseif formatNum == 2 then
            if GRM_G.formatNumber ~= formatNum then
                GRM_G.formatNumber = formatNum
                f.GRM_MonthDropDownSelected:SetPoint("TOP", f.GRM_MemberDetailRankTxt, "BOTTOM", -20, -4)
                f.GRM_DateSubmitButton:SetPoint("TOP", f.GRM_MonthDropDownSelected, "BOTTOM", -86.5, -3)
                f.GRM_DateSubmitCancelButton:SetPoint("LEFT", f.GRM_SetUnknownButton, "RIGHT", 3, 0)
            end
            f.GRM_YearDropDownSelected:Hide()
            f.GRM_SetUnknownButton:Show()
        end
        f.GRM_DayDropDownSelected:Show()
        f.GRM_MonthDropDownSelected:Show()
        f.GRM_DateSubmitButton:Show()
        f.GRM_DateSubmitCancelButton:Show()
    end

    local function SetDateSelectFrame(buttonName)
        local day, month, currentYear = GetRecordedDate(buttonName)
        local months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
        local formatNumber = 0

        f.GRM_DayDropDownSelected.GRM_DayDropDownSelectedText:SetText(day); GRM_G.dayIndex = day
        f.GRM_MonthDropDownSelected.GRM_MonthDropDownSelectedText:SetText(GRM.L(months[month])); GRM_G.monthIndex = month
        f.GRM_YearDropDownSelected.GRM_YearDropDownSelectedText:SetText(currentYear); GRM_G.yearIndex = currentYear

        if buttonName == "PromoRank" then
            formatNumber = 1
            f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetText(GRM.L("Set Promo Date"))
            f.GRM_DateSubmitButton:SetScript("OnClick", function(_, button)
                if button == "LeftButton" and not f.GRM_MonthDropDownMenu:IsVisible() then
                    SetPromoDate()
                end
            end)
        elseif buttonName == "JoinDate" then
            formatNumber = 1
            f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetText(GRM.L("Set Join Date"))
            f.GRM_DateSubmitButton:SetScript("OnClick", function(_, button)
                if button == "LeftButton" then
                    SetJoinDate()
                end
            end)
        elseif buttonName == "Birthday" then
            formatNumber = 2
            f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:SetText(GRM.L("Set Birthday"))
            f.GRM_DateSubmitButton:SetScript("OnClick", function(_, button)
                if button == "LeftButton" then GRM.SetBirthdayFrameLogic() end
            end)
        end
        SetDateButtonConfiguration(formatNumber)
    end

    -- Rank Drop down submit and cancel
    f.GRM_SetPromoDateButton:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            self:Hide()
            GRM.SetDateSelectFrame("PromoRank")
            GRM_G.pause = true
        end
    end);
    f.GRM_SetPromoDateButton:SetScript("OnShow", function() f.GRM_MemberDetailRankDateTxt:Hide() end);

    f.GRM_SetUnknownButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" and not f.GRM_DayDropDownMenu:IsVisible() then
            local buttonText = f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:GetText()
            if buttonText == GRM.L("Set Join Date") or buttonText == GRM.L("Edit Join Date") then
                GRM_UI.ClearJoinDateHistory(GRM_G.currentName, true)
                GRM_UI.DateSubmitCancelResetLogic(true, "join", false, nil)
            elseif buttonText == GRM.L("Set Promo Date") or buttonText == GRM.L("Edit Promo Date") then
                GRM_UI.ClearPromoDateHistory(GRM_G.currentName, true)
                GRM_UI.DateSubmitCancelResetLogic(true, "promo", false, nil)
            elseif not f.GRM_MonthDropDownMenu:IsVisible() and (buttonText == GRM.L("Set Birthday") or buttonText == GRM.L("Edit Birthday")) then
                GRM.ResetBirthdayForAltGroup(GRM_G.currentName, 0, true, nil, false)
                GRM_UI.DateSubmitCancelResetLogic(true, "bday", false, nil)
            end

            GRM_UI.RefreshSelectFrames(false, true, false, false, false, false)

            if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
                if f.GRM_MemberDetailJoinDateButton:IsVisible() then
                    f.GRM_SyncDateArrowButton:ClearAllPoints()
                    f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_MemberDetailJoinDateButton, "RIGHT", 0, 0)
                elseif f.GRM_JoinDateText:IsVisible() then
                    f.GRM_SyncDateArrowButton:ClearAllPoints()
                    f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_JoinDateText, "RIGHT", 8, -0.5)
                end
                f.GRM_SyncDateArrowButton:Show()
            else
                f.GRM_SyncDateArrowButton:Hide()
            end
        end
    end);

    f.GRM_SetUnknownButton:SetScript("OnEnter", function(self)
        GRM_UI.SetTooltipScale()
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        GameTooltip:AddLine(f.GRM_SetUnknownButton.GRM_SetUnknownButtonText:GetText())
        GameTooltip:Show()
    end)
    f.GRM_SetUnknownButton:SetScript("OnLeave", GRM.RestoreTooltip);

    f.GRM_DateSubmitCancelButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" and not f.GRM_YearDropDownMenu:IsVisible() then
            GRM_UI.DateSubmitCancelResetLogic(false, nil, false, nil)
        end
    end);
    f.GRM_DateSubmitCancelButton:SetScript("OnEnter", function(self)
        GRM_UI.SetTooltipScale()
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        GameTooltip:AddLine(f.GRM_DateSubmitCancelButton.GRM_DateSubmitCancelButtonText:GetText())
        GameTooltip:Show()
    end)
    f.GRM_DateSubmitCancelButton:SetScript("OnLeave", GRM.RestoreTooltip);

    -- SYNC DATE ARROW 
    f.GRM_SyncDateArrowButton:SetScript("OnEnter", function(self)
        if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
            f.GRM_MemberDetailNJDSyncTooltip:SetOwner(self, "ANCHOR_CURSOR")
            if GRM.IsAltJoinDatesSynced(GRM_G.currentName) then
                f.GRM_MemberDetailNJDSyncTooltip:AddLine(GRM.L("Join Date of All Alts is Currently Synced"))
            else
                f.GRM_MemberDetailNJDSyncTooltip:AddLine(GRM.L("{custom1} to sync join date among all alts in grouping.", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Click") .. "|r"))
            end
            f.GRM_MemberDetailNJDSyncTooltip:Show()
        end
    end);

    f.GRM_SyncDateArrowButton:SetScript("Onleave", function() f.GRM_MemberDetailNJDSyncTooltip:Hide() end);
    f.GRM_SyncDateArrowButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            if not f.GRM_SyncJoinDateSideFrame:IsVisible() then
                if GRM.PlayerOrAltHasJD(GRM_G.currentName) and not GRM.IsAltJoinDatesSynced(GRM_G.currentName) then
                    f.GRM_MemberDetailNJDSyncTooltip:Hide()
                    GRM_G.pause = true
                    f.GRM_SyncJoinDateSideFrame:Show()
                end
            else
                f.GRM_SyncJoinDateSideFrame:Hide()
            end
        end
    end);

    -- ALT DETAILS ARROW 
    f.GRM_ExtraAltDetailsArrowButton:SetScript("OnEnter", function()
        if not GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner(f.GRM_ExtraAltDetailsArrowButton, "ANCHOR_CURSOR")
            GameTooltip:AddLine(GRM.L("{custom1} to keep alt details open.", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Click") .. "|r"))
            GameTooltip:Show()
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Show()
            GRM_G.pause = true
        end
    end);

    f.GRM_ExtraAltDetailsArrowButton:SetScript("OnLeave", function()
        if not GRM_G.AltSideWindowFreeze then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide()
            GRM_G.pause = false
        end
        GRM.RestoreTooltip()
    end);

    f.GRM_ExtraAltDetailsArrowButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            if GRM_G.AltSideWindowFreeze and GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide()
            else
                if not GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:IsVisible() then GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Show() end
                GRM_G.pause = true
                GRM_G.AltSideWindowFreeze = true
                GRM.RestoreTooltip()
            end
        end
    end);

    f.GRM_MemberDetailJoinDateButton:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            self:Hide()
            if f.GRM_MemberDetailRankDateTxt:IsVisible() then
                f.GRM_MemberDetailRankDateTxt:Hide()
            elseif f.GRM_SetPromoDateButton:IsVisible() then
                f.GRM_SetPromoDateButton:Hide()
            end
            if f.GRM_SyncDateArrowButton:IsVisible() then
                f.GRM_SyncDateArrowButton:Hide()
            end

            GRM.SetDateSelectFrame("JoinDate")
            f.GRM_SyncJoinDateSideFrame:Hide()
            GRM_G.pause = true
        end
    end);

    f.GRM_MemberDetailBirthdayButton:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            self:Hide()
            if f.GRM_MemberDetailRankDateTxt:IsVisible() then
                f.GRM_MemberDetailRankDateTxt:Hide()
            elseif f.GRM_SetPromoDateButton:IsVisible() then
                f.GRM_SetPromoDateButton:Hide()
            end
            
            GRM.SetDateSelectFrame("Birthday")
            f.GRM_SyncJoinDateSideFrame:Hide()
            GRM_G.pause = true
        end
    end);

    if not GRM_G.BuildHasRestrictions then
        local defNotes = {
            defaultNote = GRM.L("Click here to set a Public Note"),
            defaultONote = GRM.L("Click here to set an Officer's Note"),
            tempNote = "",
            finalNote = ""
        }

        f.GRM_PlayerNoteWindow:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and GRM.CanEditPublicNote() or GRM_G.currentName == GRM_G.addonUser then
                f.GRM_NoteCount:SetPoint("TOPRIGHT", self, -6, 8)
                GRM_G.pause = true
                f.GRM_PlayerNoteWindow.GRM_noteFontString1:Hide()
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus()
                f.GRM_NoteCount:Hide()
                defNotes.tempNote = f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:GetText()
                if defNotes.tempNote ~= defNotes.defaultONote and defNotes.tempNote ~= "" then
                    defNotes.finalNote = defNotes.tempNote
                else
                    defNotes.finalNote = ""
                end
                f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetText(defNotes.finalNote)
                f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:Show()

                f.GRM_NoteCount:SetText(f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:GetNumLetters() .. "/31")
                f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:Show()
                f.GRM_NoteCount:Show()
                f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:Hide()
            end
        end);

        f.GRM_PlayerOfficerNoteWindow:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and GRM.CanEditOfficerNote() then
                f.GRM_NoteCount:SetPoint("TOPRIGHT", self, -6, 8)
                GRM_G.pause = true
                f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:Hide()
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus()
                defNotes.tempNote = f.GRM_PlayerNoteWindow.GRM_noteFontString1:GetText()
                if defNotes.tempNote ~= defNotes.defaultNote and defNotes.tempNote ~= "" then
                    defNotes.finalNote = defNotes.tempNote
                else
                    defNotes.finalNote = ""
                end
                f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetText(defNotes.finalNote)
                f.GRM_PlayerNoteWindow.GRM_noteFontString1:Show()

                f.GRM_NoteCount:SetText(f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:GetNumLetters() .. "/31")
                f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:Show()
                f.GRM_NoteCount:Show()
                f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:Hide()

                if f.GRM_OfficerNoteTooltip:IsVisible() then f.GRM_OfficerNoteTooltip:Hide() end
            end
        end);

        GRM_UI.PlayerPublicNoteEditBox = function()
            f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:Hide()
            f.GRM_NoteCount:Hide()
            defNotes.tempNote = f.GRM_PlayerNoteWindow.GRM_noteFontString1:GetText()
            if defNotes.tempNote ~= defNotes.defaultNote and defNotes.tempNote ~= "" then defNotes.finalNote = defNotes.tempNote else defNotes.finalNote = "" end
            f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetText(defNotes.finalNote)
            f.GRM_PlayerNoteWindow.GRM_noteFontString1:Show()
            if not f.GRM_DateSubmitButton:IsVisible() then GRM_UI.Unpause() end
        end

        f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetScript("OnEscapePressed", GRM_UI.PlayerPublicNoteEditBox)
        f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetScript("OnEditFocusLost", function(self) self:Hide(); f.GRM_PlayerNoteWindow.GRM_noteFontString1:Show() end)
        f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetScript("OnEditFocusLost", function(self) self:Hide(); f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:Show() end)

        f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetScript("OnTextChanged", function(self) f.GRM_NoteCount:SetText(self:GetNumLetters() .. "/31") end)
        f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetScript("OnEnterPressed", function(self)
            local playerDetails = { newNote = self:GetText(), name = GRM_G.currentName }
            local player = GRM.GetPlayer(playerDetails.name)

            if player then
                local h = GRM.GetRosterSelectionID(playerDetails.name, player.GUID)
                if h then
                    local publicNote = select(7, GetGuildRosterInfo(h)) or ""
                    if not GRM_G.BuildHasRestrictions and publicNote ~= playerDetails.newNote and (GRM.CanEditPublicNote() or GRM_G.currentName == GRM_G.addonUser) then
                        player.note = playerDetails.newNote
                        GRM.SetNote(player.GUID, playerDetails.newNote, true, h)
                        if GRM_G.CurrentlyScanning then GRM_G.changeHappenedExitScan = true end

                        local simpleName = GRM.GetStringClassColorByName(playerDetails.name) .. GRM.SlimName(playerDetails.name) .. "|r"
                        local logReportWithTime, logReport = GRM.GetNoteChangeString(simpleName, publicNote, playerDetails.newNote, GRM.Time.GetTimestamp())

                        if GRM.S().toChat.note then GRM.Log.PrintLog({4, logReport}) end
                        GRM.Log.AddLog({4, logReportWithTime, simpleName, publicNote, playerDetails.newNote, GRM.Time.GetTimestamp()})

                        local theNote = ""
                        if #playerDetails.newNote == 0 then
                            f.GRM_PlayerNoteWindow.GRM_noteFontString1:SetText(defNotes.defaultNote)
                            theNote = defNotes.defaultNote
                        else
                            f.GRM_PlayerNoteWindow.GRM_noteFontString1:SetText(playerDetails.newNote)
                            theNote = playerDetails.newNote
                        end
                        self:SetText(playerDetails.newNote)

                        if GRM.SlimName(CommunitiesFrame.GuildMemberDetailFrame.Name:GetText()) == GRM.SlimName(GRM_G.currentName) then
                            if CommunitiesFrame.GuildMemberDetailFrame.NoteBackground.PersonalNoteText and CommunitiesFrame.GuildMemberDetailFrame.NoteBackground.PersonalNoteText:IsVisible() then
                                CommunitiesFrame.GuildMemberDetailFrame.NoteBackground.PersonalNoteText:SetText(theNote)
                            end
                        end
                        if GRM_UI.GRM_AuditJDTool:IsVisible() then GRM.AuditRefresh(true) end
                        GRM_UI.RefreshSelectFrames(true, false, false, false, true, false)
                    end
                end
            end
            self:Hide(); f.GRM_NoteCount:Hide(); f.GRM_PlayerNoteWindow.GRM_noteFontString1:Show()
            if not f.GRM_DateSubmitButton:IsVisible() then GRM_UI.Unpause() end
        end);

        GRM_UI.EscapeOfficerNoteEditBox = function()
            f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:Hide()
            f.GRM_NoteCount:Hide()
            defNotes.tempNote = f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:GetText()
            if defNotes.tempNote ~= defNotes.defaultONote and defNotes.tempNote ~= "" then defNotes.finalNote = defNotes.tempNote else defNotes.finalNote = "" end
            f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetText(defNotes.finalNote)
            f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:Show()
            if not f.GRM_DateSubmitButton:IsVisible() then GRM_UI.Unpause() end
        end

        f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetScript("OnEscapePressed", GRM_UI.EscapeOfficerNoteEditBox)
        f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetScript("OnTextChanged", function(self) f.GRM_NoteCount:SetText(self:GetNumLetters() .. "/31") end)
        f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetScript("OnEnterPressed", function(self)
            local playerDetails = { newNote = self:GetText(), name = GRM_G.currentName }
            local player = GRM.GetPlayer(playerDetails.name)

            if player then
                local h = GRM.GetRosterSelectionID(playerDetails.name, player.GUID)
                if h then
                    local officerNote = select(8, GetGuildRosterInfo(h)) or ""
                    if not GRM_G.BuildHasRestrictions and officerNote ~= playerDetails.newNote and GRM.CanEditOfficerNote() then
                        player.officerNote = playerDetails.newNote
                        GRM.SetNote(player.GUID, playerDetails.newNote, false, h)
                        if GRM_G.CurrentlyScanning then GRM_G.changeHappenedExitScan = true end

                        local simpleName = GRM.GetStringClassColorByName(playerDetails.name) .. GRM.SlimName(playerDetails.name) .. "|r"
                        local logReportWithTime, logReport = GRM.GetOfficerNoteChangeString(simpleName, officerNote, playerDetails.newNote, GRM.Time.GetTimestamp())

                        if GRM.S().toChat.officerNote then GRM.Log.PrintLog({5, logReport}) end
                        GRM.Log.AddLog({5, logReportWithTime, simpleName, officerNote, playerDetails.newNote, GRM.Time.GetTimestamp()})

                        local theNote = ""
                        if #playerDetails.newNote == 0 then
                            f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:SetText(defNotes.defaultONote)
                            theNote = defNotes.defaultONote
                        else
                            f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:SetText(playerDetails.newNote)
                            theNote = playerDetails.newNote
                        end
                        self:SetText(playerDetails.newNote)

                        if GRM_UI.MemberDetailFrame:IsVisible() then
                            if GRM.SlimName(CommunitiesFrame.GuildMemberDetailFrame.Name:GetText()) == GRM.SlimName(GRM_G.currentName) then
                                GRM_UI.MemberDetailFrame.OfficerNoteBackground.OfficerNoteText:SetText(theNote)
                            end
                        end
                        if GRM_UI.GRM_AuditJDTool:IsVisible() then GRM.AuditRefresh(true) end
                        GRM_UI.RefreshSelectFrames(true, false, false, false, true, false)
                    end
                end
            end
            self:Hide(); f.GRM_NoteCount:Hide(); f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:Show()
            if not f.GRM_DateSubmitButton:IsVisible() then GRM_UI.Unpause() end
        end);
    end

    local IgnoreMacroFrame = f.GRM_MacroToolIgnoreListSettingsFrame
    GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow = function()
        local ruleEnum = { [false] = "|CFF00CCFF" .. GRM.L("Monitoring") .. "|r", [true] = "|CFFFF0000" .. GRM.L("Ignoring") .. "|r" }
        local disabled = "|CFFFF0000" .. GRM.L("Disabled at Current Rank") .. "|r"
        local color1, color2, color3 = "", "", ""
        local baseHeight = 245
        local player = GRM.GetPlayer(GRM_G.currentName)
        IgnoreMacroFrame.currentName = GRM_G.currentName

        if not player.safeList then player.safeList = GRM.GenerateSafeListForPlayer() end
        GRM.ValidateIgnoreExpireDates(player)

        if player.safeList.kick[1] then
            IgnoreMacroFrame.GRM_IgnoreListFrameKickCheckBox:SetChecked(true)
            ReEnableSubIgnoreOption(IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonText, IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox)
            color1 = "|CFF00CCFF"
        else
            IgnoreMacroFrame.GRM_IgnoreListFrameKickCheckBox:SetChecked(false)
            color1 = "|CFF7F7F7F"
            DisableSubIgnoreOption(IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonText, IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox)
        end

        if player.safeList.promote[1] then
            IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:SetChecked(true)
            ReEnableSubIgnoreOption(IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonText, IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox)
            color2 = "|CFF00CCFF"
        else
            IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:SetChecked(false)
            DisableSubIgnoreOption(IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonText, IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox)
            color2 = "|CFF7F7F7F"
        end

        if player.safeList.demote[1] then
            IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:SetChecked(true)
            ReEnableSubIgnoreOption(IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonText, IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox)
            color3 = "|CFF00CCFF"
        else
            IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:SetChecked(false)
            DisableSubIgnoreOption(IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonText, IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox)
            color3 = "|CFF7F7F7F"
        end

        if player.safeList.kick[2] then
            IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton:SetChecked(true)
            IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:ClearAllPoints()

            if player.safeList.kick[1] then
                local date, timeLeft = "", ""
                if player.safeList.kick[4] > 0 then
                    date = GRM.Time.EpochToDateFormat(player.safeList.kick[4] - (player.safeList.kick[3] * 86400))
                    timeLeft = GRM.Time.GetTimePassedInZone(nil, player.safeList.kick[4] - time(), true)
                end
                IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:SetText(GRM.L("Configured: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. date .. "|r"))
                IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:SetText(GRM.L("Time Left: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. timeLeft .. "|r"))

                IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:Show()
                IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:Show()
                baseHeight = baseHeight + IgnoreMacroFrame.modifier
                IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:SetPoint("TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton, "BOTTOMLEFT", 10, -(1 + IgnoreMacroFrame.modifier))
            else
                IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:Hide()
                IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:Hide()
                IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:SetPoint("TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton, "BOTTOMLEFT", 10, -1)
            end
        else
            IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton:SetChecked(false)
            IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:ClearAllPoints()
            IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:SetPoint("TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton, "BOTTOMLEFT", 10, -1)
            IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonDateSetText:Hide()
            IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:Hide()
        end

        if player.safeList.promote[2] then
            IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton:SetChecked(true)
            IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:ClearAllPoints()

            if player.safeList.promote[1] then
                local date, timeLeft = "", ""
                if player.safeList.promote[4] > 0 then
                    date = GRM.Time.EpochToDateFormat(player.safeList.promote[4] - (player.safeList.promote[3] * 86400))
                    timeLeft = GRM.Time.GetTimePassedInZone(nil, player.safeList.promote[4] - time(), true)
                end
                IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:SetText(GRM.L("Configured: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. date .. "|r"))
                IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:SetText(GRM.L("Time Left: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. timeLeft .. "|r"))

                IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:Show()
                IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:Show()
                baseHeight = baseHeight + IgnoreMacroFrame.modifier
                IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:SetPoint("TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton, "BOTTOMLEFT", 10, -(1 + IgnoreMacroFrame.modifier))
            else
                IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:Hide()
                IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:Hide()
                IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:SetPoint("TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton, "BOTTOMLEFT", 10, -1)
            end
        else
            IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton:SetChecked(false)
            IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:ClearAllPoints()
            IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:SetPoint("TOPRIGHT", IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton, "BOTTOMLEFT", 10, -1)
            IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonDateSetText:Hide()
            IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:Hide()
        end

        if player.safeList.demote[2] then
            IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton:SetChecked(true)
            if player.safeList.demote[1] then
                local date, timeLeft = "", ""
                if player.safeList.demote[4] > 0 then
                    date = GRM.Time.EpochToDateFormat(player.safeList.demote[4] - (player.safeList.demote[3] * 86400))
                    timeLeft = GRM.Time.GetTimePassedInZone(nil, player.safeList.demote[4] - time(), true)
                end
                IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:SetText(GRM.L("Configured: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. date .. "|r"))
                IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:SetText(GRM.L("Time Left: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. timeLeft .. "|r"))

                IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:Show()
                IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:Show()
                baseHeight = baseHeight + IgnoreMacroFrame.modifier
            else
                IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:Hide()
                IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:Hide()
            end
        else
            IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton:SetChecked(false)
            IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonDateSetText:Hide()
            IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:Hide()
        end

        local kickMsg, promoteMsg, demoteMsg = "", "", ""
        if CanGuildRemove() then kickMsg = ruleEnum[player.safeList.kick[1]] else kickMsg = disabled end
        if CanGuildPromote() then promoteMsg = ruleEnum[player.safeList.promote[1]] else promoteMsg = disabled end
        if CanGuildDemote() then demoteMsg = ruleEnum[player.safeList.demote[1]] else demoteMsg = disabled end

        IgnoreMacroFrame.GRM_IgnoreListFrameKickCheckBoxText2:SetText(kickMsg)
        IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBoxText2:SetText(promoteMsg)
        IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBoxText2:SetText(demoteMsg)

        IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox:SetText(player.safeList.kick[3])
        IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonText:SetText(GRM.L("Reactivate monitoring after {num} days.", nil, nil, color1 .. player.safeList.kick[3] .. "|r") .. "  " .. GRM.L("Set Days:"))
        GRM.NormalizeHitRects(IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonText)
        IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetText(player.safeList.promote[3])
        IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonText:SetText(GRM.L("Reactivate monitoring after {num} days.", nil, nil, color2 .. player.safeList.promote[3] .. "|r") .. "  " .. GRM.L("Set Days:"))
        GRM.NormalizeHitRects(IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonText)
        IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetText(player.safeList.demote[3])
        IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonText:SetText(GRM.L("Reactivate monitoring after {num} days.", nil, nil, color3 .. player.safeList.demote[3] .. "|r") .. "  " .. GRM.L("Set Days:"))
        GRM.NormalizeHitRects(IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton, IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonText)

        IgnoreMacroFrame:SetHeight(baseHeight)
    end

    local function MacroIgnoreCheckBoxesFrame_OnUpdate(self, elapsed)
        self.Timer = self.Timer + elapsed
        if self.Timer >= 1 then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:IsVisible() and player.safeList.kick[4] > 0 then
                IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButtonTimeLeftText:SetText(GRM.L("Time Left: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. GRM.Time.GetTimePassedInZone(nil, player.safeList.kick[4] - time(), true) .. "|r"))
            end
            if IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:IsVisible() and player.safeList.promote[4] > 0 then
                IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButtonTimeLeftText:SetText(GRM.L("Time Left: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. GRM.Time.GetTimePassedInZone(nil, player.safeList.promote[4] - time(), true) .. "|r"))
            end
            if IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:IsVisible() and player.safeList.demote[4] > 0 then
                IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButtonTimeLeftText:SetText(GRM.L("Time Left: {custom1}", nil, nil, nil, "|CFFFFFFFF" .. GRM.Time.GetTimePassedInZone(nil, player.safeList.demote[4] - time(), true) .. "|r"))
            end
            if (time() >= player.safeList.kick[4]) or (time() >= player.safeList.kick[4]) or (time() >= player.safeList.kick[4]) then
                GRM.ValidateIgnoreExpireDates(player)
            end
            self.Timer = 0
        end
    end

    IgnoreMacroFrame:SetScript("OnKeyDown", function(self, key)
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput(true)
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput(false);
                self:Hide()
            end
        elseif key == "ESCAPE" then
            self:Hide()
        end
    end);

    IgnoreMacroFrame:SetScript("OnUpdate", MacroIgnoreCheckBoxesFrame_OnUpdate)
    IgnoreMacroFrame:SetScript("OnHide", function() GRM.VerifySafeList(); IgnoreMacroFrame.currentName = "" end)

    IgnoreMacroFrame.GRM_IgnoreListFrameKickCheckBox:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if self:GetChecked() then
                player.safeList.kick[1] = true
            else
                player.safeList.kick[1] = false
            end
            GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow()
            GRM.RefreshAllMacroToolFrames()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                GRM.TriggerIgnoredQueuedWindowRefresh()
            end
        end
    end);

    IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton:SetScript("OnClick", function(self)
        local player = GRM.GetPlayer(GRM_G.currentName)
        if self:GetChecked() then
            if not player.safeList.kick[2] then
                player.safeList.kick[2] = true
                if player.safeList.kick[3] > 0 then
                    player.safeList.kick[4] = time() + (player.safeList.kick[3] * 86400)
                end
            end
        else
            if player.safeList.kick[2] then
                player.safeList.kick[2] = false;
                GRM.RestoreTooltip()
            end
        end
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow()
    end);

    IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton:SetScript("OnEnter", function(self)
        local player = GRM.GetPlayer(GRM_G.currentName)
        if player.safeList.kick[2] and player.safeList.kick[4] > 0 then
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:AddLine(GRM.L("WARNING! Unchecking this setting will reset the timer upon re-enabling."))
            GameTooltip:Show()
        end
    end);
    IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireButton:SetScript("OnLeave", GRM.RestoreTooltip);

    IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox:SetScript("OnEscapePressed", function(self) self:SetText(IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox.value); self:ClearFocus() end);
    IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox:SetScript("OnEnterPressed", function(self)
        local numDays = tonumber(self:GetText())
        if numDays > 0 and numDays < 1000 then
            local player = GRM.GetPlayer(GRM_G.currentName)
            player.safeList.kick[3] = numDays
            player.safeList.kick[4] = time() + (numDays * 86400)
            IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox.value = numDays
        else
            GRM.Report(GRM.L("Please choose a day between {num} and {custom1}", nil, nil, 1, 999))
        end
        self:ClearFocus()
    end);
    IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0); self:SetText(IgnoreMacroFrame.GRM_IgnoreListKickTimeExpireEditBox.value); GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow() end);

    IgnoreMacroFrame.GRM_IgnoreListFramePromoteCheckBox:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if self:GetChecked() then
                player.safeList.promote[1] = true
            else
                player.safeList.promote[1] = false
            end
            GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow()
            GRM.RefreshAllMacroToolFrames()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                GRM.TriggerIgnoredQueuedWindowRefresh()
            end
        end
    end);

    IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton:SetScript("OnClick", function(self)
        local player = GRM.GetPlayer(GRM_G.currentName)
        if self:GetChecked() then
            if not player.safeList.promote[2] then
                player.safeList.promote[2] = true
                if player.safeList.promote[3] > 0 then
                    player.safeList.promote[4] = time() + (player.safeList.promote[3] * 86400)
                end
            end
        else
            if player.safeList.promote[2] then
                player.safeList.promote[2] = false;
                GRM.RestoreTooltip()
            end
        end
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow()
    end);

    IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton:SetScript("OnEnter", function(self)
        local player = GRM.GetPlayer(GRM_G.currentName)
        if player.safeList.promote[2] and player.safeList.promote[4] > 0 then
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:AddLine(GRM.L("WARNING! Unchecking this setting will reset the timer upon re-enabling."))
            GameTooltip:Show()
        end
    end);
    IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireButton:SetScript("OnLeave", GRM.RestoreTooltip);

    IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetScript("OnEscapePressed", function(self) self:SetText(IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox.value); self:ClearFocus() end);
    IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetScript("OnEnterPressed", function(self)
        local numDays = tonumber(self:GetText())
        if numDays > 0 and numDays < 1000 then
            local player = GRM.GetPlayer(GRM_G.currentName)
            player.safeList.promote[3] = numDays
            player.safeList.promote[4] = time() + (numDays * 86400)
            IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox.value = numDays
        else
            GRM.Report(GRM.L("Please choose a day between {num} and {custom1}", nil, nil, 1, 999))
        end
        self:ClearFocus()
    end);
    IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0); self:SetText(IgnoreMacroFrame.GRM_IgnoreListPromoteTimeExpireEditBox.value); GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow() end);

    IgnoreMacroFrame.GRM_IgnoreListFrameDemoteCheckBox:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if self:GetChecked() then
                player.safeList.demote[1] = true
            else
                player.safeList.demote[1] = false
            end
            GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow()
            GRM.RefreshAllMacroToolFrames()
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then
                GRM.TriggerIgnoredQueuedWindowRefresh()
            end
        end
    end);

    IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton:SetScript("OnClick", function(self)
        local player = GRM.GetPlayer(GRM_G.currentName)
        if self:GetChecked() then
            if not player.safeList.demote[2] then
                player.safeList.demote[2] = true
                if player.safeList.demote[3] > 0 then
                    player.safeList.demote[4] = time() + (player.safeList.demote[3] * 86400)
                end
            end
        else
            if player.safeList.demote[2] then
                player.safeList.demote[2] = false;
                GRM.RestoreTooltip()
            end
        end
        GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow()
    end);

    IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton:SetScript("OnEnter", function(self)
        local player = GRM.GetPlayer(GRM_G.currentName)
        if player.safeList.demote[2] and player.safeList.demote[4] > 0 then
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:AddLine(GRM.L("WARNING! Unchecking this setting will reset the timer upon re-enabling."))
            GameTooltip:Show()
        end
    end);
    IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireButton:SetScript("OnLeave", GRM.RestoreTooltip);

    IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetScript("OnEscapePressed", function(self) self:SetText(IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox.value); self:ClearFocus() end);
    IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetScript("OnEnterPressed", function(self)
        local numDays = tonumber(self:GetText())
        if numDays > 0 and numDays < 1000 then
            local player = GRM.GetPlayer(GRM_G.currentName)
            player.safeList.demote[3] = numDays
            player.safeList.demote[4] = time() + (numDays * 86400)
            IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox.value = numDays
        else
            GRM.Report(GRM.L("Please choose a day between {num} and {custom1}", nil, nil, 1, 999))
        end
        self:ClearFocus()
    end);
    IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0); self:SetText(IgnoreMacroFrame.GRM_IgnoreListDemoteTimeExpireEditBox.value); GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow() end);

    local function SetIgnoreCheckButtonTooltip()
        local player = GRM.GetPlayer(GRM_G.currentName)
        if player and player.altGroup ~= nil then
            local safeList = player.safeList or GRM.GenerateSafeListForPlayer()
            local ruleEnum = { [false] = "|CFF00CCFF" .. GRM.L("Monitoring") .. "|r", [true] = "|CFFFF0000" .. GRM.L("Ignoring") .. "|r" }
            local numSafeLists = GRM.HowManySafeListsIsPlayerOn(player)
            local disabled = "|CFFFF0000" .. GRM.L("Disabled at Current Rank") .. "|r"
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner(f.GRM_SafeFromRulesButton, "ANCHOR_CURSOR")

            local kickMsg = CanGuildRemove() and ruleEnum[safeList.kick[1]] or disabled
            local promoteMsg = CanGuildPromote() and ruleEnum[safeList.promote[1]] or disabled
            local demoteMsg = CanGuildDemote() and ruleEnum[safeList.demote[1]] or disabled

            GameTooltip:AddLine(GRM.L("Macro Tool:"))
            GameTooltip:AddDoubleLine(GRM.L("Kick Rules"), kickMsg)
            GameTooltip:AddDoubleLine(GRM.L("Promote Rules"), promoteMsg)
            GameTooltip:AddDoubleLine(GRM.L("Demote Rules"), demoteMsg)
            GameTooltip:AddLine(" ")

            if numSafeLists < 3 then
                GameTooltip:AddLine(GRM.L("{custom1} to add player to all 3 macro tool ignore lists", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Ctrl-Click") .. "|r"))
            end
            if numSafeLists > 0 then
                GameTooltip:AddLine(GRM.L("{custom1} to remove player from all 3 macro tool ignore lists", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Alt-Click") .. "|r"))
            end
            if GRM.PlayerHasAlts(player) then
                GameTooltip:AddLine(GRM.L("{custom1} to push ignore list settings to {name}'s alts", GRM.GetClassifiedName(GRM_G.currentName, true), nil, nil, "|CFFE6CC7F" .. GRM.L("Ctrl-Shift-Click") .. "|r"))
            end

            local macroText = GRM_L["/XXXX"] ~= true and GRM_L["/XXXX"] or "/grm"
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(GRM.L("Type \"{name} {name2}\" to Bring Up Macro Tool. {custom1} also work.", macroText, string.lower(GRM.L("Macro")), nil, "\n" .. string.lower(GRM.L("Tool")) .. ", " .. string.lower(GRM.L("Kick")) .. ", " .. string.lower(GRM.L("Promote")) .. ", " .. string.lower(GRM.L("Demote"))))
            GameTooltip:Show()
        end
    end

    local function SetAllMacroIgnoreFilters(player, isEnabled)
        player.safeList = player.safeList or GRM.GenerateSafeListForPlayer()
        for list in pairs(player.safeList) do player.safeList[list][1] = isEnabled end
    end

    local function SyncAltsToSameIgnoreFilters(player)
        if GRM.PlayerHasAlts(player) then
            local group = GRM.GetGuildAlts()[player.altGroup]
            player.safeList = player.safeList or GRM.GenerateSafeListForPlayer()
            if group then
                for i = 1, #group do
                    local alt = GRM.GetPlayer(group[i].name)
                    if alt ~= nil then
                        local safeList = GRM.Util.DeepCopyArray(player.safeList)
                        alt.safeList = safeList
                        GRM.VerifySafeList(alt)
                    end
                end
            end
            GRM.VerifySafeList(player)
        end
    end
    
    f.GRM_SafeFromRulesButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if IsControlKeyDown() then
                if IsShiftKeyDown() then
                    SyncAltsToSameIgnoreFilters(player)
                    GRM.Report(GRM.L("{name}'s alts now share the same macro rule ignore settings.", GRM.GetClassifiedName(player.name, true)))
                    GRM.RefreshAllMacroToolFrames()
                else
                    SetAllMacroIgnoreFilters(player, true)
                    SetIgnoreCheckButtonTooltip()
                    GRM.RefreshAllMacroToolFrames()
                end
            elseif IsAltKeyDown() then
                SetAllMacroIgnoreFilters(player, false)
                SetIgnoreCheckButtonTooltip()
                GRM.RefreshAllMacroToolFrames()
            else
                if not IgnoreMacroFrame:IsVisible() then IgnoreMacroFrame:Show(); GRM_G.pause = true else IgnoreMacroFrame:Hide() end
                GRM.RestoreTooltip()
            end
            if GRM_UI.GRM_ToolCoreFrame.GRM_ToolIgnoreListFrame:IsVisible() then GRM.TriggerIgnoredQueuedWindowRefresh() end
            if IgnoreMacroFrame:IsVisible() then GRM_UI.MacroIgnoreCheckBoxesFrame_OnShow() end
        end
    end);

    f.GRM_SafeFromRulesButton:SetScript("OnEnter", SetIgnoreCheckButtonTooltip)
    f.GRM_SafeFromRulesButton:SetScript("OnLeave", GRM.RestoreTooltip)

    local function ResetCustomNoteSyncTooltip()
        GRM_UI.SetTooltipScale()
        GameTooltip:SetOwner(f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox, "ANCHOR_CURSOR")
        local script = f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:GetChecked() and GRM.L("Click to Disable Sync of Custom Note") or GRM.L("Click to Enable Sync of Custom Note")
        GameTooltip:AddLine(script)
        GameTooltip:Show()
    end

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if player then
                if self:GetChecked() then
                    player.customNote[1] = true; ResetCustomNoteSyncTooltip()
                else
                    player.customNote[1] = false; ResetCustomNoteSyncTooltip()
                end
            end
        end
    end);

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetScript("OnEnter", ResetCustomNoteSyncTooltip)
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetScript("OnLeave", GRM.RestoreTooltip)

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript("OnEditFocusGained", function(self)
        GRM_G.OriginalEditBoxValue = self:GetText()
        f.GRM_NoteCount:Hide(); f.GRM_MonthDropDownMenu:Hide()
        GRM.RestoreTooltip()
        GRM_G.pause = true
        if self:GetText() == GRM.L("Click here to set Custom Notes") then
            self:SetText("")
        end
        f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:SetText(self:GetNumLetters() .. "/150")
        f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:Show()
        f.GRM_GroupInviteButton:Hide(); f.GRM_ConfirmCustomNoteButton:Show(); f.GRM_CancelCustomNoteButton:Show(); f.GRM_SafeFromRulesButton:Hide()
    end);

    GRM_UI.CustomNoteEditBoxOnFocusLost = function(isForced)
        local player = GRM.GetPlayer(GRM_G.currentName)
        if isForced or (not (f.GRM_ConfirmCustomNoteButton:IsVisible() and f.GRM_ConfirmCustomNoteButton:IsMouseOver() and
                        IsMouseButtonDown(1)) or (GRM.Util.Trim(f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetText()) == player.customNote[4])) then
            f.GRM_ConfirmCustomNoteButton:Hide()
            f.GRM_CancelCustomNoteButton:Hide()
            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText(GRM_G.OriginalEditBoxValue)
            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus()
            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:Hide()

            if GRM_G.currentName ~= GRM_G.addonUser then
                f.GRM_SafeFromRulesButton:Show()
                if player.isOnline then
                    SetGroupInviteButton(GRM_G.currentName)
                    f.GRM_GroupInviteButton:Show()
                end
            end
            GRM_UI.BuildCustomNoteScrollFrame(GRM_G.OriginalEditBoxValue)
            if not f.GRM_DateSubmitButton:IsVisible() then
                GRM_UI.Unpause()
            end
        end
    end

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript("OnEditFocusLost", function() GRM_UI.CustomNoteEditBoxOnFocusLost() end)

    local MaxValue = 0
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript("OnTextChanged", function(self)
        if self:HasFocus() then
            local numLetters = self:GetNumLetters()
            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteTextCount:SetText(numLetters .. "/150")

            GRM_UI.BuildCustomNoteScrollFrame(self:GetText())
            local max = select(2, f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:GetMinMaxValues())
            if max > 0 and numLetters > 0 then
                local cursorPosition = f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetCursorPosition()
                if cursorPosition == numLetters then
                    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(max)
                else
                    if max - MaxValue > 15 then
                        f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetValue(math.floor((cursorPosition / f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetMaxLetters()) * max))
                    end
                end
            end
        end
    end);

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript("OnEscapePressed", function() GRM_UI.CustomNoteEditBoxOnFocusLost() end)
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript("OnEnterPressed", function()
        local newString = f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetText()
        local cursorPosition = f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:GetCursorPosition()
        f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText(string.sub(newString, 1, cursorPosition) .. "\n" .. string.sub(newString, cursorPosition + 1))
        f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetCursorPosition(cursorPosition + 1)
    end)

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript("OnEnter", function(self)
        if not self:HasFocus() then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if player and player.customNote[3] ~= "" then
                local isFound = GRM.GetPlayer(player.customNote[3]) ~= nil
                GRM_UI.SetTooltipScale()
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
                local noteDisplay = ""
                if isFound then
                    if player.customNote[4] == "" then
                        noteDisplay = GRM.L("Note Removed by {name}", GRM.GetClassifiedName(player.customNote[3], false))
                    else
                        noteDisplay = GRM.L("Edited by {name}", GRM.GetClassifiedName(player.customNote[3], false))
                    end
                    GameTooltip:AddLine(noteDisplay)
                else
                    GameTooltip:AddLine(GRM.L("Edited by {name}", player.customNote[3] .. " (" .. GRM.L("|CFFFF0000Player No Longer in Guild") .. ")"))
                end
                GameTooltip:AddLine(GRM.Time.EpochToDateFormat(player.customNote[2]))
                GameTooltip:Show()
            end
        end
    end);

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetScript("OnLeave", GRM.RestoreTooltip)

    f.GRM_CustomNoteEditBoxFrame:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:Show()
            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetFocus()
        end
    end);

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetScrollChild(f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox)
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:EnableMouseWheel(true)
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetScript("OnValueChanged", function(self)
        f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetVerticalScroll(self:GetValue())
    end);

    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:SetScript("OnShow", function(self)
        local tempVal = self:GetValue()
        if tempVal == 0 then
            self:SetValue(20); self:SetValue(tempVal)
        else
            self:SetValue(0); self:SetValue(tempVal)
        end
    end);   

    f.GRM_ConfirmCustomNoteButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            GRM.SetCustomNote()
            if GRM_UI.GRM_AuditJDTool:IsVisible() then
                GRM.AuditRefresh(true)
            end
            GRM_UI.RefreshSelectFrames(false, false, false, false, true, false, true)
        end
    end)
    f.GRM_ConfirmCustomNoteButton:SetScript("OnEnter", function(self) GRM_UI.SetTooltipScale(); GameTooltip:SetOwner(self, "ANCHOR_CURSOR"); GameTooltip:AddLine(GRM.L("Confirm Custom Note")); GameTooltip:Show() end);
    f.GRM_ConfirmCustomNoteButton:SetScript("OnLeave", GRM.RestoreTooltip);
    f.GRM_CancelCustomNoteButton:SetScript("Onclick", function(_, button) if button == "LeftButton" then f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus() end end);

    local AddAltEditFrame = f.GRM_CoreAltFrame.GRM_AddAltEditFrame
    local function AddAltButtonControls(_, button)
        if button == "LeftButton" then
            local player = GRM.GetPlayer(GRM_G.currentName)
            if player then
                if GRM.GetNumAlts(player.altGroup) >= 75 then
                    GRM.Report(GRM.L("Addon does not currently support more than 75 alts!"))
                else
                    GRM_G.pause = true
                    AddAltEditFrame.GRM_AddAltEditBox:SetAutoFocus(true)
                    AddAltEditFrame.GRM_AddAltEditBox:SetText("")
                    GRM.AddAltAutoComplete()
                    AddAltEditFrame:Show()
                    AddAltEditFrame.GRM_AddAltEditBox:SetAutoFocus(false)
                    AddAltEditFrame.GRM_AddAltEditBox:SetFocus()
                end
            end
        end
    end

    local aafSlider = AddAltEditFrame.GRM_AddAltScrollFrameSlider
    AddAltEditFrame:SetScript("OnHide", function()
        aafSlider:SetValue(0)
        GRM_G.currentHighlightIndex = 0
    end);

    f.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame.GRM_AddAltButton2:SetScript("OnClick", AddAltButtonControls)
    AddAltEditFrame.GRM_AddAltEditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
    AddAltEditFrame.GRM_AddAltEditBox:SetScript("OnChar", function() GRM.AddAltAutoComplete() end);

    local function SetAddAltSliderValue()
        if GRM_G.currentHighlightIndex < 7 then aafSlider:SetValue(0)
        elseif GRM_G.currentHighlightIndex > 6 and GRM_G.currentHighlightIndex < 13 then aafSlider:SetValue(84)
        elseif GRM_G.currentHighlightIndex > 12 and GRM_G.currentHighlightIndex < 19 then aafSlider:SetValue(168)
        elseif GRM_G.currentHighlightIndex > 18 and GRM_G.currentHighlightIndex < 25 then aafSlider:SetValue(252)
        elseif GRM_G.currentHighlightIndex > 24 and GRM_G.currentHighlightIndex < 31 then aafSlider:SetValue(select(2, aafSlider:GetMinMaxValues())) end
    end

    local function AddAltSelectionControls(_, key)
        local notSet = true
        local buttons = AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons
        local i = GRM_G.currentHighlightIndex

        if key == "DOWN" or (key ~= "UP" and not IsShiftKeyDown()) then
            if i == 1 and notSet then
                if (i + 1) <= #buttons and buttons[i + 1][1]:IsVisible() then
                    GRM_G.currentHighlightIndex = 2
                    buttons[i][1]:UnlockHighlight()
                    buttons[i + 1][1]:LockHighlight()
                    notSet = false
                end
            else
                if (i + 1) <= #buttons and buttons[i + 1][1]:IsVisible() then
                    GRM_G.currentHighlightIndex = i + 1
                    buttons[i][1]:UnlockHighlight()
                    buttons[i + 1][1]:LockHighlight()
                    notSet = false
                    SetAddAltSliderValue()
                else
                    GRM_G.currentHighlightIndex = 1
                    buttons[i][1]:UnlockHighlight()
                    buttons[1][1]:LockHighlight()
                    notSet = false
                    aafSlider:SetValue(0)
                end
            end
        elseif key == "UP" or (key ~= "DOWN" and IsShiftKeyDown()) then
            if i == 1 and notSet then
                if buttons[GRM_G.NumberAltInSelection][1]:IsVisible() then
                    GRM_G.currentHighlightIndex = GRM_G.NumberAltInSelection
                    buttons[i][1]:UnlockHighlight()
                    buttons[GRM_G.NumberAltInSelection][1]:LockHighlight()
                    notSet = false
                    aafSlider:SetValue(select(2, aafSlider:GetMinMaxValues()))
                end
            else
                GRM_G.currentHighlightIndex = i - 1
                buttons[i][1]:UnlockHighlight()
                buttons[i - 1][1]:LockHighlight()
                notSet = false
                SetAddAltSliderValue()
            end
        end
    end

    AddAltEditFrame.GRM_AddAltEditBox:SetScript("OnKeyDown", function(self, key)
        if key == "BACKSPACE" then
            local text = self:GetText()
            if text ~= nil and #text > 0 then
                self:SetText(string.sub(text, 0, #text - 1))
            end
            GRM.AddAltAutoComplete()
            self:SetText(text)
        elseif key == "DOWN" or key == "UP" or key == "TAB" then
            AddAltSelectionControls(self, key)
        end
    end);

    AddAltEditFrame:SetScript("OnKeyDown", function(self, key)
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput(true)
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput(false); self:Hide()
            end
        elseif key == "ESCAPE" then
            self:Hide()
        end
    end);

    GRM_UI.SendFullAltGroup = function(currentName, nameToAdd, timestamp, index, player, alts)
        index = index or 2
        local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
        local endCap = "?X"
        player = player or GRM.GetPlayer(nameToAdd)

        if player then
            alts = alts or GRM.GetAltGroup(player.altGroup)
            local main = ""
            local msg = ""
            local tempMsg = ""

            if alts and GRM.IsPlayerInAltGroup(player.altGroup, currentName) then
                main = alts.main == "" and "#" or alts.main
                for i = index, #alts do
                    if i == 2 then
                        msg = "GRM_ADDALT?" .. syncRankFilter .. "?S?" .. alts[1].name .. "?" .. main .. "?" .. timestamp .. "?" .. tostring(#alts-1) .. "?" .. nameToAdd .. "?" .. currentName
                    elseif msg == "" then
                        msg = "GRM_ADDALT?" .. syncRankFilter .. "?##?" .. alts[1].name
                    end

                    tempMsg = msg .. "?" .. alts[i].name

                    if (#tempMsg + GRMsyncGlobals.sizeModifier + #endCap) < 255 then
                        msg = tempMsg
                    else
                        -- Do not add the new name, just send the msg
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier
                        GRMsync.SendMessage("GRM_SYNC", msg, "GUILD")
                        msg = "GRM_ADDALT?" .. syncRankFilter .. "?##?" .. alts[1].name .. "?" .. alts[i].name
                    end

                    -- If at the end of the alt Group, we need to send, even if not a full string.
                    if i == #alts then
                        msg = msg .. endCap
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier
                        GRMsync.SendMessage("GRM_SYNC", msg, "GUILD")
                    end

                    -- Check if there needs to be a throttled delay
                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        index = i
                        if i == #alts then
                            index = index + 1
                        end

                        GRMsyncGlobals.SyncCount = 0
                        C_Timer.After(GRMsyncGlobals.ThrottleDelay, function()
                            GRM_UI.SendFullAltGroup(currentName, nameToAdd, timestamp, index, player, alts)
                        end)
                        return
                    end
                end
            end
        end
    end

    local function AddAltSideFrameLogic(editBox)
        local currentText = editBox:GetText()
        if AddAltEditFrame.GRM_AddAltEditFrameHelpText:IsVisible() and (AddAltEditFrame.GRM_AddAltEditFrameHelpText:GetText() == GRM.L("Player Not Found") or AddAltEditFrame.GRM_AddAltEditFrameHelpText:GetText() == GRM.L("Player Cannot Add Themselves as an Alt") or AddAltEditFrame.GRM_AddAltEditFrameHelpText:GetText() == GRM.L("Player is Already in this Alt Group")) then
            if GRM.SlimName(GRM_G.currentName) == currentText or GRM_G.currentName == currentText then
                GRM.Report(GRM.L("Player Cannot Add Themselves as an Alt"))
            elseif f.alts[currentText] then
                GRM.Report(GRM.L("Player is Already in this Alt Group"))
            end
            GRM.Report(GRM.L("Please choose a VALID character to set as an Alt"))
        else
            if currentText ~= nil and currentText ~= "" then
                local addToAltsGroup = false
                local nameToAdd = GRM.RemoveMainAltTags(AddAltEditFrame.GRM_AddAltScrollChildFrame.AllButtons[GRM_G.currentHighlightIndex][2]:GetText())

                if editBox:GetText() ~= nameToAdd then
                    editBox:SetText(nameToAdd)
                else
                    local timestamp = time()
                    addToAltsGroup = GRM.AddAlt(GRM_G.currentName, nameToAdd, timestamp)
                    GRM.SyncBirthdayWithNewAlt(GRM_G.currentName, nameToAdd, addToAltsGroup, timestamp)

                    GRM_UI.RefreshSelectFrames(false, true, false, true, true, true, true)
                    if GRM.S().syncEnabled then
                        GRM_UI.SendFullAltGroup(GRM_G.currentName, nameToAdd, timestamp)
                    end

                    editBox:ClearFocus()
                    AddAltEditFrame:Hide()

                    if GRM_UI.GRM_LoadToolButton:IsVisible() then
                        GRM_UI.RefreshToolButtonsOnUpdate_Async(false, false)
                    end
                    GRM.Report(GRM.L("{name} added to {name2}'s list of Alts.", GRM.GetClassifiedName(nameToAdd, true), GRM.GetClassifiedName(GRM_G.currentName, true)))
                end
            else
                GRM.Report(GRM.L("Please choose a character to set as alt."))
            end
        end
    end

    AddAltEditFrame.GRM_AddAltEditBox:SetScript("OnEnterPressed", function(self)
        if self:HasFocus() then
            AddAltSideFrameLogic(self)
        end
    end);

    GRM_UI.BuildAutoCompleteAltSelectionScrollFrame = function(listOfAlts)
        local buttonCap = GRM_G.MaxAltAutoCompleteList
        local numButtons = math.min(#listOfAlts, buttonCap)
        GRM_G.NumberAltInSelection = numButtons

        local scrollHeight = 0
        local AddAltEditFrame = f.GRM_CoreAltFrame.GRM_AddAltEditFrame
        local scrollWidth = AddAltEditFrame:GetWidth() - 10
        local child = AddAltEditFrame.GRM_AddAltScrollChildFrame

        child.AllButtons = child.AllButtons or {}

        for i = 1, numButtons do
            if not child.AllButtons[i] then
                local tempButton = CreateFrame("Button", "AltSelection" .. i, child)
                child.AllButtons[i] = {tempButton, tempButton:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")}
            end

            local button = child.AllButtons[i][1]
            local buttonText = child.AllButtons[i][2]

            button:SetSize(149, 18.5)
            button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")

            local classColor = GRM.GetClassColorRGB(listOfAlts[i][2], false)
            buttonText:SetTextColor(classColor[1], classColor[2], classColor[3])
            buttonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11)
            buttonText:SetJustifyH("LEFT")
            buttonText:SetText(listOfAlts[i][1] .. GRM.GetAltTag(listOfAlts[i][3]))
            buttonText:SetPoint("LEFT", button)

            if i == 1 then
                button:SetPoint("TOP", child, "TOP", 0, 0)
            else
                button:SetPoint("TOPLEFT", child.AllButtons[i - 1][1], "BOTTOMLEFT", 0, 0)
            end
            
            scrollHeight = scrollHeight + button:GetHeight()
            
            button:SetScript("OnClick", function(_, key)
                if key == "LeftButton" then
                    local result = GRM.RemoveMainAltTags(child.AllButtons[i][2]:GetText())
                    if AddAltEditFrame.GRM_AddAltEditBox:GetText() == result then
                        AddAltSideFrameLogic(AddAltEditFrame.GRM_AddAltEditBox)
                    else
                        GRM_G.currentHighlightIndex = i
                        result = GRM.RemoveMainAltTags(result)
                        AddAltEditFrame.GRM_AddAltEditBox:SetText(result)
                        AddAltEditFrame.GRM_AddAltEditBox:SetFocus()
                        AddAltEditFrame.GRM_AddAltEditBox:SetCursorPosition(#AddAltEditFrame.GRM_AddAltEditBox:GetText())
                        AddAltEditFrame.GRM_AddAltEditBox:HighlightText(#AddAltEditFrame.GRM_AddAltEditBox:GetText() + 1)
                        GRM.AddAltAutoComplete()
                    end
                end
            end)
            button:Show()
        end
        
        for i = numButtons + 1, #child.AllButtons do
            child.AllButtons[i][1]:Hide()
        end

        GRM.ConfigureSlider(AddAltEditFrame.GRM_AddAltScrollFrame, child, AddAltEditFrame.GRM_AddAltScrollFrameSlider, scrollWidth, scrollHeight, 84, true)
    end

    local function BuildAltGroupingScrollFrame(currentName)
        local scrollHeight = 0
        local scrollWidth = 315
        local buffer = 9

        local borderFrame = GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame
        local child = borderFrame.GRM_AltGroupingScrollChildFrame
        local slider = borderFrame.GRM_AltGroupingScrollFrameSlider

        slider:SetValue(0)
        child.AllFrameFontstrings = child.AllFrameFontstrings or {}
        
        borderFrame.GRM_AltGroupingScrollBorderFrameTitle:SetText(GRM_G.CurrentCalendarHexCode .. GRM.L("{name}'s Alts", GRM.SlimName(currentName)))

        if GRM.GetPlayer(currentName) then
            local listOfAlts = GRM.GetSortedAltNamesWithDetails(currentName)
            local mainFound = false
            
            for i = 1, #listOfAlts do
                if not child.AllFrameFontstrings[i] then
                    child.AllFrameFontstrings[i] = {
                        child:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                        child:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                        child:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),
                        child:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")
                    }
                end

                local AltName = child.AllFrameFontstrings[i][1]
                local AltLvl = child.AllFrameFontstrings[i][2]
                local AltRank = child.AllFrameFontstrings[i][3]
                local AltLastOnline = child.AllFrameFontstrings[i][4]
                local altClassRGB = GRM.GetClassColorRGB(listOfAlts[i][3], false)

                AltName:SetText(GRM.SlimName(listOfAlts[i][1]))
                AltName:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9)
                AltName:SetJustifyH("LEFT")
                AltName:SetTextColor(altClassRGB[1], altClassRGB[2], altClassRGB[3], 1)

                AltLvl:SetText(listOfAlts[i][2])
                AltLvl:SetWidth(75); AltLvl:SetWordWrap(false); AltLvl:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9); AltLvl:SetJustifyH("CENTER")

                AltRank:SetText(GuildControlGetRankName(listOfAlts[i][4] + 1))
                AltRank:SetWidth(75); AltRank:SetWordWrap(false); AltRank:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9); AltRank:SetJustifyH("CENTER")

                AltLastOnline:SetWidth(100); AltLastOnline:SetWordWrap(false); AltLastOnline:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 9)

                if listOfAlts[i][9] then
                    AltLastOnline:SetText(GRM.L("Online"))
                    AltLastOnline:SetTextColor(0.12, 1.0, 0.0, 1.0)
                else
                    AltLastOnline:SetText(GRM.Time.HoursReport(listOfAlts[i][10]))
                    AltLastOnline:SetTextColor(1, 1, 1, 1.0)
                end

                local stringHeight = AltLastOnline:GetStringHeight()

                if i == 1 then
                    AltName:SetPoint("TOPLEFT", child, "TOPLEFT", 14, -5)
                    AltLvl:SetPoint("TOP", child, "TOP", -60, -5)
                    AltRank:SetPoint("TOP", child, "TOP", 10, -5)
                    AltLastOnline:SetPoint("TOP", child, "TOP", 98, -5)
                    scrollHeight = scrollHeight + stringHeight
                else
                    AltName:SetPoint("TOPLEFT", child.AllFrameFontstrings[i - 1][1], "BOTTOMLEFT", 0, -buffer)
                    AltLvl:SetPoint("TOP", child.AllFrameFontstrings[i - 1][2], "BOTTOM", 0, -buffer)
                    AltRank:SetPoint("TOP", child.AllFrameFontstrings[i - 1][3], "BOTTOM", 0, -buffer)
                    AltLastOnline:SetPoint("TOP", child.AllFrameFontstrings[i - 1][4], "BOTTOM", 0, -buffer)
                    scrollHeight = scrollHeight + stringHeight + buffer
                end

                if listOfAlts[i][5] then
                    child.GRM_MainTag:SetPoint("TOP", AltName, "BOTTOM")
                    child.GRM_MainTag:Show()
                    mainFound = true
                end

                AltName:Show(); AltLvl:Show(); AltRank:Show(); AltLastOnline:Show()
            end

            if not mainFound then child.GRM_MainTag:Hide() end

            for i = #listOfAlts + 1, #child.AllFrameFontstrings do
                child.AllFrameFontstrings[i][1]:Hide(); child.AllFrameFontstrings[i][2]:Hide()
                child.AllFrameFontstrings[i][3]:Hide(); child.AllFrameFontstrings[i][4]:Hide()
            end

            child:SetSize(scrollWidth, scrollHeight)

            local scrollMax = (scrollHeight - 105) + buffer
            if scrollMax < 0 then
                scrollMax = 0
                slider:Hide()
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:EnableMouseWheel(false)
            else
                slider:SetMinMaxValues(0, scrollMax)
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:EnableMouseWheel(true)
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.GRM_AltGroupingScrollFrame:SetScript("OnMouseWheel", function(_, delta)
                    local current = slider:GetValue()
                    if delta < 0 and current < scrollMax then
                        slider:SetValue(current + (IsControlKeyDown() and 60 or 20))
                    elseif delta > 0 and current > 1 then
                        slider:SetValue(current - (IsControlKeyDown() and 60 or 20))
                    end
                end)
                slider:Show()
            end
        end
    end

    -- Alt Grouping Frame Handlers
    local function AltGroupingBorderFrame_OnShow()
        if AddAltEditFrame:IsVisible() then AddAltEditFrame:Hide() end
        GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame.timer2 = 0
        if f:IsMouseOver() then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:ClearAllPoints()
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", -1, 0)
            BuildAltGroupingScrollFrame(GRM_G.currentName)
        elseif CalendarViewEventFrame and CalendarViewEventFrame:IsVisible() and CalendarViewEventFrame:IsMouseOver() then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:ClearAllPoints()
            if GRM.IsAddOnLoaded("LOIHCal") and not LOIHCalDB.config.overlay then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint("TOP", LOIHCal_Container, "BOTTOM", 0, -50)
            else
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint("BOTTOMLEFT", CalendarViewEventFrame, "BOTTOMRIGHT", 11, 0)
            end
            f:Hide()
            BuildAltGroupingScrollFrame(GRM_G.CurrentCalendarName)
        elseif CalendarCreateEventFrame and CalendarCreateEventFrame:IsVisible() and CalendarCreateEventFrame:IsMouseOver() then
            GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:ClearAllPoints()
            if GRM.IsAddOnLoaded("LOIHCal") and not LOIHCalDB.config.overlay then
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint("TOP", LOIHCal_Container, "BOTTOM", 0, -50)
            else
                GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetPoint("BOTTOMLEFT", CalendarCreateEventFrame, "BOTTOMRIGHT", 11, 0)
            end
            f:Hide()
            BuildAltGroupingScrollFrame(GRM_G.CurrentCalendarName)
        end
        if not f.GRM_ExtraAltDetailsArrowButton:IsMouseOver() then
            GRM.RestoreTooltip()
        end
    end

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript("OnShow", AltGroupingBorderFrame_OnShow)
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript("OnHide", function() GRM_G.AltSideWindowFreeze = false end)

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript("OnKeyDown", function(self, key)
        if not GRM_G.inCombat then
            self:SetPropagateKeyboardInput(true)
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput(false);
                self:Hide()
            end
        elseif key == "ESCAPE" then
            self:Hide()
        end
    end)

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            local needsRefresh = false
            local setValue = function(int)
                if GRM_G.altDetailsControl[1] ~= int then
                    GRM_G.altDetailsControl = {int, true}
                else
                    GRM_G.altDetailsControl[2] = not GRM_G.altDetailsControl[2]
                end
            end

            if self.GRM_AltGroupingName:IsMouseOver(1, -1, -1, 1) then setValue(1); needsRefresh = true
            elseif self.GRM_AltGroupingLastOnline:IsMouseOver(1, -1, -1, 1) then setValue(2); needsRefresh = true
            elseif self.GRM_AltGroupingLevel:IsMouseOver(1, -1, -1, 1) then setValue(3); needsRefresh = true
            elseif self.GRM_AltGroupingRank:IsMouseOver(1, -1, -1, 1) then setValue(4); needsRefresh = true end

            if needsRefresh then BuildAltGroupingScrollFrame(GRM_G.currentName) end
        end
    end)

    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timer2 = self.timer2 + elapsed
        self.timer1 = self.timer1 + elapsed
        if self.timer2 > 0.05 then
            if (self.GRM_AltGroupingName:IsMouseOver(1, -1, -1, 1) or self.GRM_AltGroupingLastOnline:IsMouseOver(1, -1, -1, 1) or self.GRM_AltGroupingLevel:IsMouseOver(1, -1, -1, 1) or self.GRM_AltGroupingRank:IsMouseOver(1, -1, -1, 1)) then
                if not self.GRM_AltGroupHeaderTooltip:IsVisible() then
                    self.GRM_AltGroupHeaderTooltip:SetOwner(self, "ANCHOR_CURSOR")
                    self.GRM_AltGroupHeaderTooltip:AddLine(GRM.L("Click to Sort"))
                    self.GRM_AltGroupHeaderTooltip:Show()
                end
            elseif self.GRM_AltGroupHeaderTooltip:IsVisible() then
                self.GRM_AltGroupHeaderTooltip:Hide()
            end

            if self.timer1 > 300 then
                BuildAltGroupingScrollFrame(GRM_G.currentName)
                self.timer1 = 0
            end
            self.timer2 = 0
        end
    end)
end

-----------------------------------
---- CORE HELPER LOGIC ------------
-----------------------------------

GRM_UI.SetAltAsMainDropDownMenuLogic = function(altDetails)
    local timestamp = time()
    if altDetails[1] ~= altDetails[2] then
        if GRM.GetPlayer(altDetails[2]) then
            GRM.SetMain(altDetails[2], timestamp)
            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
                GRMsync.SendMessage("GRM_SYNC", "GRM_MAIN?" .. syncRankFilter .. "?" .. altDetails[2] .. "?" .. tostring(timestamp), "GUILD")
            end
        end
    else
        if GRM.GetPlayer(altDetails[1]) then
            GRM.SetMain(altDetails[1], timestamp)
            if not GRM_UI.GRM_DropDownList1AttachmentFrame.pausedPreviously then GRM_UI.Unpause() end
            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
                GRMsync.SendMessage("GRM_SYNC", "GRM_MAIN?" .. syncRankFilter .. "?" .. altDetails[1] .. "?" .. tostring(timestamp), "GUILD")
            end
        end
    end
    GRM_UI.RefreshSelectFrames(false, true, false, false, true, false, true)
    GRM.Report(GRM.L("{name} is now set as \"main\"", GRM.GetClassifiedName(altDetails[2], true)))
end

GRM_UI.DemoteMainToAltDropDownMenuLogic = function(altDetails)
    local timestamp = time()
    if altDetails[1] ~= altDetails[2] then
        GRM.DemotePlayerFromMain(altDetails[2])
        if GRM.S().syncEnabled then
            local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
            GRMsync.SendMessage("GRM_SYNC", "GRM_RMVMAIN?" .. syncRankFilter .. "?" .. altDetails[2] .. "?" .. tostring(timestamp), "GUILD")
        end
    else
        local player = GRM.GetPlayer(altDetails[1])
        if player then
            GRM.DemotePlayerFromMain(altDetails[1])
            if not GRM_UI.GRM_DropDownList1AttachmentFrame.pausedPreviously then GRM_UI.Unpause() end
            if GRM.S().syncEnabled then
                local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
                GRMsync.SendMessage("GRM_SYNC", "GRM_RMVMAIN?" .. syncRankFilter .. "?" .. altDetails[1] .. "?" .. tostring(timestamp), "GUILD")
            end
        end
    end
    GRM_UI.RefreshSelectFrames(false, true, false, false, true, false, true)
    GRM.Report(GRM.L("{name} is no longer set as \"main\"", GRM.GetClassifiedName(altDetails[2], true)))
end

GRM_UI.BuildCustomNoteScrollFrame = function(customNote)
    if GRM_G.previousNote ~= customNote then
        GRM_G.previousNote = customNote
        local scrollHeight = 0
        local scrollWidth = 123
        local cBox = f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox
        local cSlider = f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider

        if customNote == "" and not cBox:HasFocus() then
            customNote = GRM.L("Click here to set Custom Notes")
        end
        cBox:SetText(customNote)

        C_Timer.After(0.05, function()
            scrollHeight = cBox:GetHeight()
            cBox:SetSize(scrollWidth, scrollHeight + 10)

            local scrollMax = (scrollHeight - 80) + GRM_G.FontModifier + 5
            if scrollMax < 0 then scrollMax = 0 end
            cSlider:SetMinMaxValues(0, scrollMax)

            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:EnableMouseWheel(true)
            f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:SetScript("OnMouseWheel", function(_, delta)
                local current = cSlider:GetValue()
                if IsShiftKeyDown() and delta > 0 then
                    cSlider:SetValue(0)
                elseif IsShiftKeyDown() and delta < 0 then
                    cSlider:SetValue(scrollMax)
                elseif delta < 0 and current < scrollMax then
                    cSlider:SetValue(current + (IsControlKeyDown() and 60 or 20))
                elseif delta > 0 and current > 1 then
                    cSlider:SetValue(current - (IsControlKeyDown() and 60 or 20))
                end
            end)
        end)
    end
end

GRM_UI.DateSubmitCancelResetLogic = function(isUnknown, date, isAudit, playerName)
    local buttonText = f.GRM_DateSubmitButton.GRM_DateSubmitButtonText:GetText()
    local joinDateText, promoDateText, bDayDateText = GRM.L("Set Join Date"), GRM.L("Set Promo Date"), GRM.L("Set Birthday")
    local editDateText, editJoinText = GRM.L("Edit Promo Date"), GRM.L("Edit Join Date")
    local name = GRM_G.currentName
    local showJoinText, showBdayText = false, false
    local formatBdayStamp = ""

    if isAudit then
        if date == "join" then
            buttonText = joinDateText
        elseif date == "promo" then
            buttonText = promoDateText
        elseif date == "bday" then
            buttonText = bDayDateText
        end
    end

    if isAudit and playerName ~= nil then
        name = playerName
    end

    local player = GRM.GetPlayer(name)
    if player then
        if player.name == GRM_G.currentName then
            if (player.promoteDateUnknown or player.rankHist[1][7]) then
                GRM_G.rankDateSet = true
            end
            if player.joinDateUnknown or #player.joinDateHist[1][4] > 1 then
                showJoinText = true
            end

            if isUnknown and date == "bday" then
                GRM.SetBirthdayInfo(player, nil, nil, nil, nil, true)
            end

            local birthdayInfo = GRM.GetBirthday(player)
            if birthdayInfo.unknown or birthdayInfo.date[1] ~= 0 then
                showBdayText = true
                if not birthdayInfo.unknown then
                    formatBdayStamp = GRM.Time.FormatTimeStamp({ birthdayInfo.date[1], birthdayInfo.date[2] }, false, true)
                else
                    formatBdayStamp = GRM.L("Unknown")
                end
            end
        end

        if isUnknown then
            if date == "join" then player.joinDateUnknown = true
            elseif date == "promo" then
                player.promoteDateUnknown = true
                if player.name == GRM_G.currentName then
                    GRM_G.rankDateSet = true
                end
            end
        end

        if not isAudit or (f:IsVisible() and GRM_G.currentName == playerName) then
            if player.isOnline then
                if player.zone ~= nil then
                    f.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone)
                    f.GRM_ZoneInfoTime2:SetText(GRM.Time.GetTimePassedInZone(player.timeEnteredZone))
                end
                f.GRM_ZoneInfoText:Show(); f.GRM_MemberDetailMetaZoneInfoZoneText:Show()
                f.GRM_ZoneInfoTime1:Show(); f.GRM_ZoneInfoTime2:Show()
            end
        end
    end

    if f:IsVisible() and name == GRM_G.currentName then
        if joinDateText == buttonText or editJoinText == buttonText then
            if isUnknown and date == "join" then
                f.GRM_JoinDateText:SetText(GRM.L("Unknown"))
                f.GRM_JoinDateText:Show(); f.GRM_MemberDetailJoinDateButton:Hide()
            else
                if buttonText == editJoinText then
                    f.GRM_JoinDateText:Show() else
                        f.GRM_MemberDetailJoinDateButton:Show()
                    end
            end
        elseif buttonText == promoDateText then
            if not isUnknown then f.GRM_SetPromoDateButton:Show()
            elseif date == "promo" then
                f.GRM_SetPromoDateButton:Hide()
                f.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " .. GRM.L("Unknown"))
                f.GRM_MemberDetailRankDateTxt:Show()
            end

            if name == GRM_G.currentName then
                if showJoinText then
                    f.GRM_JoinDateText:Show()
                else
                    f.GRM_MemberDetailJoinDateButton:Show()
                end
            end
        elseif buttonText == editDateText then
            if isUnknown and date == "promo" then
                f.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " .. GRM.L("Unknown"))
            end
            f.GRM_MemberDetailRankDateTxt:Show()
        end

        if GRM.S().showBDay and not f.GRM_BirthdayText:IsVisible() and not f.GRM_MemberDetailBirthdayButton:IsVisible() then
            if showBdayText then
                f.GRM_MemberDetailBirthdayButton:Hide()
                f.GRM_BirthdayText:SetText(formatBdayStamp)
                f.GRM_BirthdayText:Show()
            else
                f.GRM_MemberDetailBirthdayButton:Show()
                f.GRM_BirthdayText:Hide()
            end
        end

        if not GRM_G.rankDateSet then
            f.GRM_MemberDetailRankDateTxt:Hide(); f.GRM_SetPromoDateButton:Show()
        else
            f.GRM_MemberDetailRankDateTxt:Show()
        end

        if not isAudit then
            GRM_UI.Unpause()
        end
    end

    if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
        if f.GRM_MemberDetailJoinDateButton:IsVisible() then
            f.GRM_SyncDateArrowButton:ClearAllPoints()
            f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_MemberDetailJoinDateButton, "RIGHT", 0, 0)
        elseif f.GRM_JoinDateText:IsVisible() then
            f.GRM_SyncDateArrowButton:ClearAllPoints()
            f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_JoinDateText, "RIGHT", 8, -0.5)
        end
        f.GRM_SyncDateArrowButton:Show()
    else
        f.GRM_SyncDateArrowButton:Hide()
    end

    f.GRM_MonthDropDownSelected:Hide(); f.GRM_YearDropDownSelected:Hide(); f.GRM_DayDropDownSelected:Hide()
    f.GRM_DateSubmitButton:Hide(); f.GRM_DateSubmitCancelButton:Hide(); f.GRM_SetUnknownButton:Hide()
end

GRM_UI.ClearPromoDateHistory = function(name, isUnknown, member)
    local player = member or GRM.GetPlayer(name)
    if player then
        if not isUnknown then GRM_G.rankDateSet = false end
        player.rankHist = {{player.rankName, 0, 0, 0, "0", 0, false, 1}}
        player.promoteDateUnknown = false

        if name == GRM_G.currentName and f:IsVisible() then
            if f.ContextMenu then f.ContextMenu:Hide() end
            if not isUnknown then
                f.GRM_MemberDetailRankDateTxt:Hide()
                f.GRM_SetPromoDateButton:Show()
            end
        end
    end
end

GRM_UI.ClearJoinDateHistory = function(name, isUnknown, member)
    local player = member or GRM.GetPlayer(name)
    if player then
        player.joinDateHist = {{0, 0, 0, "0", 0, false, 1}}
        player.joinDateUnknown = false

        if name == GRM_G.currentName and f:IsVisible() then
            f.GRM_JoinDateText:Hide()
            if f.ContextMenu then f.ContextMenu:Hide() end
            if not isUnknown then f.GRM_MemberDetailJoinDateButton:Show() end

            if GRM.PlayerOrAltHasJD(GRM_G.currentName) then
                if f.GRM_MemberDetailJoinDateButton:IsVisible() then
                    f.GRM_SyncDateArrowButton:ClearAllPoints()
                    f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_MemberDetailJoinDateButton, "RIGHT", 0, 0)
                elseif f.GRM_JoinDateText:IsVisible() then
                    f.GRM_SyncDateArrowButton:ClearAllPoints()
                    f.GRM_SyncDateArrowButton:SetPoint("LEFT", f.GRM_JoinDateText, "RIGHT", 8, -0.5)
                end
                f.GRM_SyncDateArrowButton:Show()
            else
                f.GRM_SyncDateArrowButton:Hide()
            end
        end
    end
end

GRM_UI.ClearAllFrames = function(includingMeta)
    if includingMeta then
        if f:IsVisible() then f:Hide(); GRM_G.currentName = "" end
    end
    f.GRM_MonthDropDownSelected:Hide(); f.GRM_YearDropDownSelected:Hide(); f.GRM_DayDropDownSelected:Hide()
    f.GRM_DateSubmitButton:Hide(); f.GRM_DateSubmitCancelButton:Hide(); f.GRM_SetUnknownButton:Hide()
    f.GRM_NoteCount:Hide(); f.GRM_CoreAltFrame:Hide()
    if f.ContextMenu then f.ContextMenu:Hide() end
    f.GRM_CoreAltFrame.GRM_AddAltEditFrame:Hide()
    f.GRM_SyncJoinDateSideFrame:Hide()
    f.GRM_ConfirmCustomNoteButton:Hide(); f.GRM_CancelCustomNoteButton:Hide()
    GRM_UI.GRM_Mouseover.GRM_AltGroupingScrollBorderFrame:Hide()
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus()
    f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:ClearFocus(); f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:ClearFocus()
    f.GRM_OfficerNoteTooltip:Hide()
    f.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Hide()
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide()
    f.GRM_MacroToolIgnoreListSettingsFrame:Hide()
end

GRM_UI.SelectPlayerOnRoster = function(playerName)
    if GRM_UI.MemberDetailFrame:IsVisible() then
        GRM_UI.MemberDetailFrame:Hide()
    end
    f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:ClearFocus();
    f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:ClearFocus()
    f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus()
    GRM_G.currentName = playerName
    GRM_G.pause = false
    GRM_UI.ClearAllFrames(false)
    GRM_UI.PopulateMemberDetails(playerName)
    GRM_G.pause = true
end

GRM_UI.DateUntrustedTag = function(isVerified)
    return not isVerified and "|cffff0000!!|r" or ""
end

local function JoinDateTooltip(self)
    if GRM.GetMouseFocus(self) and not self.GRM_MemberDetailJoinDateToolTip:IsVisible() and
        not StaticPopup1:IsVisible() and self.GRM_JoinDateText:IsVisible() and
        not (self.ContextMenu and self.ContextMenu:IsVisible()) and self.GRM_JoinDateText:IsMouseOver(1, -1, -1, 1) then

        self.GRM_MemberDetailJoinDateToolTip:SetOwner(self.GRM_JoinDateText, "ANCHOR_BOTTOMRIGHT")
        self.GRM_MemberDetailJoinDateToolTip:AddLine("|cFFFFFFFF" .. GRM.L("Membership History"))
        local joinedHeader, msg = "", ""

        local player = GRM.GetPlayer(GRM_G.currentName)
        if player then
            if self.GRM_JoinDateText:GetText() == GRM.L("Unknown") then
                self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(GRM.L("Joined:"), GRM.L("Unknown"))
                self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(" ", " ")
            else
                for i = 1, #player.joinDateHist do
                    if i == 1 then
                        self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine("|cFFFF0000" .. GRM.L("Time as Member:"), GRM.Time.GetTimePlayerHasBeenMember(player.name))

                        if #player.joinDateHist > 0 then
                            local totalJoins = math.floor(#player.joinDateHist / 2) + (#player.joinDateHist % 2)
                            local total = GRM.L("Times in Guild: {num}", nil, nil, totalJoins)

                            if GRM.IsGuildEE(GRM_G.guildName) then
                                if GRM.IsPlayerEE(GRM_G.currentName) then total = GRM_G.listOfPlayers[GRM_G.currentName] .. ": " .. totalJoins
                                else total = GRM_G.listOfGuilds[GRM_G.guildName] .. ": " .. totalJoins end
                            end
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(total, 1, 0, 0)
                        end
                        self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(" ", " ")

                        if string.find(self.GRM_JoinDateText:GetText(), "!!", 1, true) ~= nil then
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L("The {name} tag indicates a date must be verified to sync", "|CFFFF0000!!|r"))
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L("To confirm or edit the date, right click the date, edit, and submit"), 1, 0.84, 0, true)
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(" ")
                            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L("If the date is accurate, right click and select 'Confirm Date'"), 1, 0.84, 0, true)
                            self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(" ", " ")
                        end
                    end

                    if player.joinDateHist[i][7] == 2 then joinedHeader = GRM.L("Left:")
                    elseif i == #player.joinDateHist then joinedHeader = GRM.L("Joined:")
                    else joinedHeader = GRM.L("Rejoined:") end

                    if player.joinDateHist[i][1] == 0 then msg = GRM.L("Unknown")
                    else msg = GRM_UI.DateUntrustedTag(player.joinDateHist[i][6]) .. GRM.Time.FormatTimeStamp({player.joinDateHist[i][1], player.joinDateHist[i][2], player.joinDateHist[i][3]}, false) end
                    
                    self.GRM_MemberDetailJoinDateToolTip:AddDoubleLine(joinedHeader, msg, 0.38, 0.67, 1.0)
                end
            end
            self.GRM_MemberDetailJoinDateToolTip:AddLine(" ")
            self.GRM_MemberDetailJoinDateToolTip:AddLine(GRM.L("Right-Click to Edit"))
        end
        self.GRM_MemberDetailJoinDateToolTip:Show()
    elseif not GRM.GetMouseFocus(self) or (not self.GRM_JoinDateText:IsMouseOver(1, -1, -1, 1) and (self.GRM_MemberDetailJoinDateToolTip:IsVisible() or self.GRM_MemberDetailServerNameToolTip:IsVisible())) then
        self.GRM_MemberDetailJoinDateToolTip:Hide(); self.GRM_MemberDetailServerNameToolTip:Hide()
    end
end

local function PlayerNameTooltip(self)
    if not (self.ContextMenu and self.ContextMenu:IsVisible()) and not StaticPopup1:IsVisible() and self.GRM_MemberDetailNameText:IsMouseOver(1, -1, -1, 1) and GRM.GetMouseFocus(self) then
        local textR, textG, textB = self.GRM_MemberDetailNameText:GetTextColor()
        self.GRM_MemberDetailServerNameToolTip:SetOwner(self.GRM_JoinDateText, "ANCHOR_CURSOR")
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM_G.currentName, textR, textG, textB)

        local player = GRM.GetPlayer(GRM_G.currentName)
        if player and player.race ~= "" and player.sex ~= 0 then
            self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{name} {name2}", C_CreatureInfo.GetRaceInfo(GRM_G.raceIDEnum[player.race]).raceName, GRM.GetSex(player.sex)), 1, 1, 1)
        end

        self.GRM_MemberDetailServerNameToolTip:AddLine(" ")
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{custom1} to Copy Name to Chat", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Shift-Click") .. "|r"))
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{custom1} to Search the Log for Player", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Ctrl-Shift-Click") .. "|r"))
        self.GRM_MemberDetailServerNameToolTip:AddLine(GRM.L("{custom1} for Additional Options", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Right-Click") .. "|r"))
        self.GRM_MemberDetailServerNameToolTip:Show()
    else
        self.GRM_MemberDetailServerNameToolTip:Hide()
    end
end

local function AltNameTooltip(self)
    local player = GRM.GetPlayer(GRM_G.currentName)
    local childButtons = self.GRM_CoreAltFrame.GRM_CoreAltScrollChildFrame.allFrameButtons

    if (childButtons ~= nil and #childButtons > 0 and childButtons[1][1]:IsVisible()) and not StaticPopup1:IsVisible() and
        not (self.ContextMenu and self.ContextMenu:IsVisible()) and
        not (self.GRM_YearDropDownMenu:IsVisible() and self.GRM_YearDropDownMenu:IsMouseOver()) and
        not (self.GRM_DayDropDownMenu:IsVisible() and self.GRM_DayDropDownMenu:IsMouseOver()) then

        if not self.GRM_ExtraAltDetailsArrowButton:IsMouseOver(1, -1, -1, 1) then
            GRM_G.tempAltName = ""
            if player then
                local listOfAlts = GRM.GetListOfAlts(player)
                local color = {}
                local AltTT = self.GRM_MemberDetailServerNameToolTip
                local isOver = false

                if childButtons ~= nil then
                    for i = 1, #childButtons do
                        if childButtons[i][1]:IsVisible() and childButtons[i][1]:IsMouseOver(1, -1, -1, 1) and GRM.GetMouseFocus(childButtons[i][1]) and listOfAlts[i] and listOfAlts[i][1] then
                            GRM_G.tempAltName = listOfAlts[i][1]
                            color = GRM.GetClassColorRGB(listOfAlts[i][2], false)
                            AltTT:SetOwner(childButtons[i][1], "ANCHOR_CURSOR")
                            AltTT:AddLine(listOfAlts[i][1], color[1], color[2], color[3])
                            AltTT:AddLine(" ")
                            AltTT:AddLine(GRM.L("{custom1} to Copy Name to Chat", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Shift-Click") .. "|r"))
                            AltTT:AddLine(GRM.L("{custom1} for Additional Options", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Right-Click") .. "|r"))
                            AltTT:AddLine(GRM.L("{custom1} to open Player Window", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Ctrl-Click") .. "|r"))
                            AltTT:AddLine(GRM.L("{custom1} to Search the Log for Player", nil, nil, nil, "|CFFE6CC7F" .. GRM.L("Ctrl-Shift-Click") .. "|r"))
                            isOver = true
                            break
                        end
                    end
                end

                if isOver and not (self.ContextMenu and self.ContextMenu:IsVisible()) then
                    AltTT:Show()
                elseif (self.ContextMenu and self.ContextMenu:IsVisible()) and not self.GRM_MemberDetailNameText:IsMouseOver(1, -1, -1, 1) then
                    AltTT:Hide()
                end
            end
        end

        if self.GRM_CoreAltFrame:IsMouseOver(5, 5, 5, 35) and player and GRM.GetNumAlts(player.altGroup) >= 12 then
            self.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Show()
        else
            self.GRM_CoreAltFrame.GRM_CoreAltScrollFrameSlider:Hide()
        end

        if self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:IsMouseOver(10, 1, 1, 30) and select(2, self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:GetMinMaxValues()) > 0 then
            self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Show()
        else
            self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide()
        end

    else
        if not self.GRM_MemberDetailNameText:IsMouseOver(1, -1, -1, 1) then self.GRM_MemberDetailServerNameToolTip:Hide() end
    end

    if GRM.PlayerHasAlts(player) then
        if not self.GRM_ExtraAltDetailsArrowButton:IsVisible() then self.GRM_ExtraAltDetailsArrowButton:Show() end
    else
        if self.GRM_ExtraAltDetailsArrowButton:IsVisible() then self.GRM_ExtraAltDetailsArrowButton:Hide() end
    end
end

local function CustomNoteSlider(self)
    if self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrame:IsMouseOver(10, 1, 1, 30) and select(2, self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:GetMinMaxValues()) > 0 then
        self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Show()
    else
        self.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteScrollFrameSlider:Hide()
    end
end

local function PlayerStatusNotificationTooltip(self)
    if GRM.GetMouseFocus(self) and self.GRM_MemberDetailPlayerStatus:IsMouseOver(1, -1, -1, 1) and not (self.ContextMenu and self.ContextMenu:IsVisible()) then
        self.GRM_MemberDetailNotifyStatusChangeTooltip:SetOwner(self.GRM_MemberDetailPlayerStatus, "ANCHOR_CURSOR")
        self.GRM_MemberDetailNotifyStatusChangeTooltip:AddLine("|cFFFFFFFF" .. GRM.L("|CFFE6CC7FRight-Click|r to Set Notification of Status Change"))
        self.GRM_MemberDetailNotifyStatusChangeTooltip:Show()
    else
        self.GRM_MemberDetailNotifyStatusChangeTooltip:Hide()
    end
end

local function EditBdayTooltip(self)
    if not self.GRM_BirthdayTooltip:IsVisible() and GRM.GetMouseFocus(self) and self.GRM_BirthdayText:IsVisible() and
        self.GRM_BirthdayText:IsMouseOver(1, -1, -1, 1) and not (self.ContextMenu and self.ContextMenu:IsVisible()) then
        self.GRM_BirthdayTooltip:SetOwner(self.GRM_BirthdayText, "ANCHOR_CURSOR")
        self.GRM_BirthdayTooltip:AddLine(GRM.L("Right-Click to Edit"))
        self.GRM_BirthdayTooltip:Show()
    elseif not GRM.GetMouseFocus(self) or (self.GRM_BirthdayTooltip:IsVisible() and not self.GRM_BirthdayText:IsMouseOver(1, -1, -1, 1)) then
        self.GRM_BirthdayTooltip:Hide()
    end
end

local function PromoRankTooltip(self)
    if GRM.GetMouseFocus(self) and not self.GRM_MemberDetailRankToolTip:IsVisible() and not StaticPopup1:IsVisible() and
        not DropDownList1:IsVisible() and self.GRM_MemberDetailRankDateTxt:IsVisible() and
        not (self.ContextMenu and self.ContextMenu:IsVisible()) and self.GRM_MemberDetailRankDateTxt:IsMouseOver(1, -1, -1, 1) then

        self.GRM_MemberDetailRankToolTip:SetOwner(self.GRM_MemberDetailRankDateTxt, "ANCHOR_BOTTOMRIGHT")
        self.GRM_MemberDetailRankToolTip:AddLine("|cFFFFFFFF" .. GRM.L("Rank History"))

        local player = GRM.GetPlayer(GRM_G.currentName)
        if player then
            if self.GRM_MemberDetailRankDateTxt:GetText() == GRM.L("Promoted:") .. " " .. GRM.L("Unknown") then
                self.GRM_MemberDetailRankToolTip:AddDoubleLine("|cFFFF0000" .. GRM.L("Time at Rank:"), GRM.L("Unknown"))
                self.GRM_MemberDetailRankToolTip:AddDoubleLine(" ", " ")
            elseif player.rankHist[1][1] ~= 0 then
                local header = ""
                for i = 1, #player.rankHist do
                    if i == 1 then
                        local timeAtRank = GRM.L("Unknown")
                        if #player.rankHist[1][5] > 1 then
                            timeAtRank = GRM.Time.GetTimePassedUsingTableOrString({player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]})[4]
                        elseif not player.promoteDateUnknown then
                            timeAtRank = GRM.L("Not Set")
                        end

                        self.GRM_MemberDetailRankToolTip:AddDoubleLine("|cFFFF0000" .. GRM.L("Time at Rank:"), timeAtRank)
                        self.GRM_MemberDetailRankToolTip:AddDoubleLine(" ", " ")

                        if #player.rankHist[1][5] > 1 and not player.rankHist[1][7] then
                            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L("The {name} tag indicates a date must be verified to sync", "|CFFFF0000!!|r"))
                            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L("To confirm or edit the date, right click the date, edit, and submit"), 1, 0.84, 0, true)
                            self.GRM_MemberDetailRankToolTip:AddLine(" ")
                            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L("If the date is accurate, right click and select 'Confirm Date'"), 1, 0.84, 0, true)
                            self.GRM_MemberDetailRankToolTip:AddDoubleLine(" ", " ")
                        end
                    end

                    header = player.rankHist[i][8] == 3 and GRM.L("Left Guild") or player.rankHist[i][1]
                    self.GRM_MemberDetailRankToolTip:AddDoubleLine(header .. ":", GRM_UI.DateUntrustedTag(player.rankHist[i][7]) .. GRM.Time.FormatTimeStamp({player.rankHist[i][2], player.rankHist[i][3], player.rankHist[i][4]}, false, false), 0.38, 0.67, 1.0)
                end
            end
            self.GRM_MemberDetailRankToolTip:AddLine(" ")
            self.GRM_MemberDetailRankToolTip:AddLine(GRM.L("Right-Click to Edit"))
        end
        self.GRM_MemberDetailRankToolTip:Show()
    elseif not GRM.GetMouseFocus(self) or (self.GRM_MemberDetailRankToolTip:IsVisible() and not self.GRM_MemberDetailRankDateTxt:IsMouseOver(1, -1, -1, 1)) then
        self.GRM_MemberDetailRankToolTip:Hide(); self.GRM_MemberDetailServerNameToolTip:Hide()
    end
end

GRM.MemberDetailToolTips = function(self, elapsed)
    self.timer = self.timer + elapsed
    if self.timer >= 0.075 then
        if IsInGuild() then
            PromoRankTooltip(self)
            JoinDateTooltip(self)
            PlayerNameTooltip(self)
            AltNameTooltip(self)
            CustomNoteSlider(self)
            PlayerStatusNotificationTooltip(self)
            EditBdayTooltip(self)
        end
        self.timer = 0
    end
end

local function FactionIcon(index)
    if not index then
        if GRM_G.BuildVersion >= GRM_ENUM.BUILD.DF then
            f.GRM_AllianceIconTexture:Hide(); f.GRM_HordeIconTexture:Hide(); return
        else
            index = GRM_G.faction
        end
    end

    if GRM.S().showFaction and index ~= -1 then
        if index == 0 then
            f.GRM_HordeIconTexture:Show(); f.GRM_AllianceIconTexture:Hide()
        else
            f.GRM_AllianceIconTexture:Show(); f.GRM_HordeIconTexture:Hide()
        end
    else
        f.GRM_HordeIconTexture:Hide(); f.GRM_AllianceIconTexture:Hide()
    end
end

local function DeathStatus(player, isDead, timestamp)
    if isDead or (GRM_G.HardcoreActive and player.HC.isDead) then
        if isDead then
            f.GRM_DeathTexture:SetTexture("Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\deleted.png")
            f.GRM_ClearDeathButton:Hide()
        else
            f.GRM_DeathTexture:SetTexture("Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\dead.png")
            f.GRM_ClearDeathButton:Show()
        end
        f.GRM_DeathTexture:Show()

        if not isDead or (isDead and timestamp) then
            local time = {}
            if player then
                time = {player.HC.timeOfDeath[1], player.HC.timeOfDeath[2], player.HC.timeOfDeath[3]}
            elseif timestamp and #timestamp == 8 then
                local day, month, year = GRM.Time.ParseStandardFormatDate(timestamp)
                if day then time = {day, month, year} end
            end

            if #time > 0 then
                f.GRM_RIPtext:SetText(GRM.L("R.I.P. - {custom1}", nil, nil, nil, GRM.Time.FormatTimeStamp({time[1], time[2], time[3]})))
                f.GRM_RIPtext:SetTextColor(GRM.S().logColor[15][1], GRM.S().logColor[15][2], GRM.S().logColor[15][3])
                f.GRM_RIPtext:Show()
            end
        else
            f.GRM_RIPtext:Hide()
        end
    else
        f.GRM_DeathTexture:Hide(); f.GRM_ClearDeathButton:Hide(); f.GRM_RIPtext:Hide()
    end
end

GRM_UI.PopulateMemberDetails = function(handle, memberInfo, doubleCopy)
    if handle ~= "" and handle ~= nil and GRM_G.guildName ~= "" and IsInGuild() then
        GRM_G.rankDateSet = false

        local player = GRM.GetPlayer(handle)
        if not player then return end

        -- Player Details
        local zone, online = "", false
        if memberInfo and memberInfo.guid ~= nil then
            zone = memberInfo.zone
            online = GRM.IsPresenceOnline(memberInfo.presence)
        else
            local member = GRM.GetClubMemberInfo(handle, GRM_G.gClubID)
            if member then
                zone = member.zone
                online = GRM.IsPresenceOnline(member.presence)
            end
        end

        -- Top-right lock indication
        if GRM_G.pause then
            f.GRM_WindowIsLockedText:Show()
        else
            f.GRM_WindowIsLockedText:Hide()
        end

        if not doubleCopy and zone ~= nil and zone ~= "" then
            player.isOnline = online
            if player.zone ~= zone then player.timeEnteredZone = time() end
            player.zone = zone
        end

        local class = memberInfo and C_CreatureInfo.GetClassInfo(memberInfo.classID).classFile or player.class
        local classColors = GRM.GetClassColorRGB(class)
        f.GRM_MemberDetailNameText:SetTextColor(classColors[1], classColors[2], classColors[3], 1.0)
        FactionIcon(player.faction)

        local note = memberInfo and memberInfo.memberNote or player.note
        if not doubleCopy then DeathStatus(player) else DeathStatus(nil, true, string.match(note or "", "%[D%]-(%d+)")) end

        f.GRM_MemberDetailNameText:SetText(GRM.SlimName(handle))
        local nameHeight = 16
        f.GRM_MemberDetailNameText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + nameHeight)
        while (f.GRM_MemberDetailNameText:GetWidth() > 120) do
            nameHeight = nameHeight - 0.1
            f.GRM_MemberDetailNameText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + nameHeight)
        end

        if not doubleCopy and GRM.IsMain(player.name) then
            f.GRM_MemberDetailMainText:Show(); f.GRM_MemberDetailAltText:Hide()
        else
            f.GRM_MemberDetailMainText:Hide()
            if not doubleCopy and GRM.PlayerIsAnAlt(player) then f.GRM_MemberDetailAltText:Show() else f.GRM_MemberDetailAltText:Hide() end
        end

        local levelAndMythicText = ""
        local level = memberInfo and memberInfo.level or player.level
        if GRM.S().showLevel and (not GRM.S().showLevelMaxOnly or (GRM.S().showLevelMaxOnly and level < GRM_G.LvlCap)) then
            if GRML.Languages[GRM.S().selectedLang] == "Russian" or GRML.Languages[GRM.S().selectedLang] == "Korean" then
                levelAndMythicText = tostring(level) .. GRM.L("Level: ")
            else
                levelAndMythicText = GRM.L("Level: ") .. level
            end
        end

        if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA and GRM.S().showMythicRating and level == GRM_G.LvlCap then
            local mythicScore = memberInfo and memberInfo.overallDungeonScore or player.MythicScore or 0
            local mStr = GRM.L("M+ Rating:") .. "  " .. GRM.GetMythicRatingToMatchRaiderIO(mythicScore) .. mythicScore .. "|r"
            levelAndMythicText = levelAndMythicText ~= "" and levelAndMythicText .. " | " .. mStr or mStr
        end

        f.GRM_MemberDetailLevel:SetText(levelAndMythicText)
        f.GRM_MemberDetailRankTxt:SetText("\"" .. player.rankName .. "\"")
        f.GRM_MemberDetailRankTxt:Show()

        if not f.GRM_DateSubmitButton:IsVisible() then
            if not doubleCopy and player.isOnline then
                if player.zone ~= nil then
                    f.GRM_MemberDetailMetaZoneInfoZoneText:SetText(player.zone)
                    f.GRM_ZoneInfoTime2:SetText(GRM.Time.GetTimePassedInZone(player.timeEnteredZone))
                end
                f.GRM_ZoneInfoText:Show(); f.GRM_MemberDetailMetaZoneInfoZoneText:Show()
                f.GRM_ZoneInfoTime1:Show(); f.GRM_ZoneInfoTime2:Show()
            else
                f.GRM_ZoneInfoText:Hide(); f.GRM_MemberDetailMetaZoneInfoZoneText:Hide()
                f.GRM_ZoneInfoTime1:Hide(); f.GRM_ZoneInfoTime2:Hide()
            end

            if not doubleCopy and player.promoteDateUnknown then
                f.GRM_MemberDetailRankDateTxt:SetText(GRM.L("Promoted:") .. " " .. GRM.L("Unknown"))
                f.GRM_MemberDetailRankDateTxt:Show(); f.GRM_SetPromoDateButton:Hide()
                GRM_G.rankDateSet = true
            else
                if doubleCopy or #player.rankHist[1][5] == 1 then
                    f.GRM_MemberDetailRankDateTxt:Hide(); f.GRM_SetPromoDateButton:Show()
                else
                    f.GRM_SetPromoDateButton:Hide()
                    GRM_G.rankDateSet = true
                    f.GRM_MemberDetailRankDateTxt:SetText(GRM_UI.DateUntrustedTag(player.rankHist[1][7]) .. GRM.L("Promoted:") .. " " .. GRM.Time.FormatTimeStamp({player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]}, false, false))
                    f.GRM_MemberDetailRankDateTxt:Show()
                end
            end

            if not doubleCopy and player.joinDateUnknown then
                f.GRM_MemberDetailJoinDateButton:Hide()
                f.GRM_JoinDateText:SetText(GRM.L("Unknown"))
                f.GRM_JoinDateText:Show()
            else
                if doubleCopy or player.joinDateHist[1][1] == 0 then
                    f.GRM_JoinDateText:Hide(); f.GRM_MemberDetailJoinDateButton:Show()
                else
                    f.GRM_MemberDetailJoinDateButton:Hide()
                    f.GRM_JoinDateText:SetText(GRM_UI.DateUntrustedTag(player.joinDateHist[1][6]) .. GRM.Time.FormatTimeStamp({player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]}, false))
                    f.GRM_JoinDateText:Show()
                end
            end

            if not doubleCopy and GRM.S().showBDay then
                f.GRM_MemberDetailBirthdayTitleText:Show()
                local birthdayInfo = GRM.GetBirthday(player)
                if birthdayInfo.unknown then
                    f.GRM_MemberDetailBirthdayButton:Hide()
                    f.GRM_BirthdayText:SetText(GRM.L("Unknown"))
                    f.GRM_BirthdayText:Show()
                else
                    if birthdayInfo.date[1] ~= 0 then
                        f.GRM_MemberDetailBirthdayButton:Hide()
                        f.GRM_BirthdayText:SetText(GRM.Time.FormatTimeStamp({ birthdayInfo.date[1], birthdayInfo.date[2] }, false, true))
                        f.GRM_BirthdayText:Show()
                    else
                        f.GRM_MemberDetailBirthdayButton:Show(); f.GRM_BirthdayText:Hide()
                    end
                end
            else
                f.GRM_MemberDetailBirthdayButton:Hide(); f.GRM_BirthdayText:Hide(); f.GRM_MemberDetailBirthdayTitleText:Hide()
            end
        end

        if not f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:HasFocus() and not f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:HasFocus() and not f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
            local finalNote = ""
            local finalONote = ""
            local canModifyPublicNote = (not GRM_G.BuildHasRestrictions)
            if canModifyPublicNote then
                finalNote = GRM.L("Click here to set a Public Note")
                finalONote = GRM.L("Click here to set an Officer's Note")
            else
                finalNote = GRM.L("Public Note not set")
                finalONote = GRM.L("Officer Note not Set")
            end

            f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:Hide(); f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:Hide()

            if note and note ~= "" then finalNote = note end
            f.GRM_PlayerNoteWindow.GRM_noteFontString1:SetText(finalNote)

            if canModifyPublicNote then
                if (GRM.CanEditPublicNote() or handle == GRM_G.addonUser) then
                    if finalNote ~= GRM.L("Click here to set a Public Note") then f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetText(finalNote) else f.GRM_PlayerNoteWindow.GRM_PlayerNoteEditBox:SetText("") end
                elseif finalNote == GRM.L("Click here to set a Public Note") then
                    f.GRM_PlayerNoteWindow.GRM_noteFontString1:SetText(GRM.L("Unable to Edit Public Note at Rank"))
                end
            end

            local officerNote = memberInfo and memberInfo.officerNote or player.officerNote
            if memberInfo and not officerNote and GRM_G.BuildVersion < GRM_ENUM.BUILD.CATA then
                officerNote = select(8, GRM.GetGuildRosterInfo_ClassicMethod(player.name, false, player.GUID))
            end

            if GRM.CanViewOfficerNote() == true then
                if officerNote and officerNote ~= "" then finalONote = officerNote end
                if canModifyPublicNote and finalONote == GRM.L("Click here to set an Officer's Note") and not GRM.CanEditOfficerNote() then
                    finalONote = GRM.L("Unable to Edit Officer Note at Rank")
                end
                f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:SetText(finalONote)
                if canModifyPublicNote and finalONote ~= GRM.L("Click here to set an Officer's Note") then
                    f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetText(finalONote)
                    if GRM_UI.MemberDetailFrame:IsVisible() and finalONote ~= "" then
                        GRM_UI.MemberDetailFrame.OfficerNoteBackground.OfficerNoteText:SetText(finalONote)
                    end
                else
                    f.GRM_PlayerOfficerNoteWindow.GRM_PlayerOfficerNoteEditBox:SetText("")
                end
            else
                f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:SetText(GRM.L("Unable to View Officer Note at Rank"))
            end

            if not doubleCopy and player.customNote[1] then
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetChecked(true)
            else
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:SetChecked(false)
            end
            
            if GRM.S().syncEnabled and GRM.S().syncCustomNote then
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:Enable()
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteSyncMetaCheckBoxText:SetTextColor(1.0, 0.82, 0.0, 1.0)
            else
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox.GRM_CustomNoteSyncMetaCheckBoxText:SetTextColor(0.5, 0.5, 0.5, 1)
                f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteSyncMetaCheckBox:Disable()
            end

            local cNote = not doubleCopy and player.customNote[4] or ""
            GRM_UI.BuildCustomNoteScrollFrame(cNote)
            if f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus() end
            f.GRM_PlayerOfficerNoteWindow.GRM_noteFontString2:Show(); f.GRM_PlayerNoteWindow.GRM_noteFontString1:Show()
        end

        if not doubleCopy and player.isOnline then f.GRM_MemberDetailLastOnlineTxt:SetText(GRM.L("Online"))
        else f.GRM_MemberDetailLastOnlineTxt:SetText(GRM.Time.HoursReport(player.lastOnlineTime)) end

        if not doubleCopy and GRM.S().viewGuildRep and GRM_G.BuildVersion >= GRM_ENUM.BUILD.CATA then
            f.GRM_ReputationLevelText:SetText(GRM.GetReputationTextLevel(player.guildRep, true))
            f.GRM_ReputationLevelText:Show()
        else
            f.GRM_ReputationLevelText:Hide()
        end

        if not doubleCopy and player.isOnline and handle ~= GRM_G.addonUser and not f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
            SetGroupInviteButton(handle)
            f.GRM_GroupInviteButton:Show()
            f.GRM_SafeFromRulesButton:ClearAllPoints()
            f.GRM_SafeFromRulesButton:SetPoint("LEFT", f.GRM_GroupInviteButton, "RIGHT", 5, 0)
            f.GRM_SafeFromRulesButton:Show()
        elseif not doubleCopy and (not player.isOnline or handle == GRM_G.addonUser) then
            f.GRM_GroupInviteButton:Hide()
            if handle ~= GRM_G.addonUser and not f.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
                f.GRM_SafeFromRulesButton:ClearAllPoints()
                f.GRM_SafeFromRulesButton:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 15, 13)
                f.GRM_SafeFromRulesButton:Show()
            else
                f.GRM_SafeFromRulesButton:Hide()
            end
        elseif doubleCopy then
            f.GRM_SafeFromRulesButton:Hide()
        end

        local isGuildieBanned = not doubleCopy and player.bannedInfo[1] or false
        if isGuildieBanned and handle ~= GRM_G.addonUser then
            f.GRM_MemberDetailBannedIgnoreButton:SetScript("OnClick", function(_, button)
                if button == "LeftButton" then
                    local epochTimeStamp = time()
                    GRM.RemoveBan(handle, true, GRM_G.addonUser, epochTimeStamp)
                    GRM.RemoveBanSendSyncMessage(player.name, epochTimeStamp)
                    GRM.Report(GRM.L("{name} has been Removed from the Ban List.", GRM.GetClassifiedName(player.name, true)))
                end
            end)
            f.GRM_MemberDetailBannedText1:Show(); f.GRM_MemberDetailBannedIgnoreButton:Show()
        else
            f.GRM_MemberDetailBannedText1:Hide(); f.GRM_MemberDetailBannedIgnoreButton:Hide()
        end

        if not doubleCopy then
            GRM.PopulateAltFrames(handle)
        end
        ReconfigureNoteFonts()
    end
end