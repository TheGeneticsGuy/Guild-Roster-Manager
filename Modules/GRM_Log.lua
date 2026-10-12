local Log = {};
GRM.Log = Log;

--------------------------
-- BUILD AND REPORT LOG --
--------------------------

-- Method:          GetMessageRGB( int )
-- What it Does:    Returns the 3 RGB colors colors based on the given index on a 1.0 scale
-- Purpose:         Save on code when need color call. I also did this as a 3 argument return, rather than a single array, just as a proof of concept
--                  since this whole project was also a bit of a Lua learning moment.
local GetMessageRGB = function(index)
    local r = 0;
    local g = 0;
    local b = 0;

    if index == 1 then -- Promotion
        r = GRM.S().logColor[4][1];
        g = GRM.S().logColor[4][2];
        b = GRM.S().logColor[4][3];
    elseif index == 2 then -- Demotion
        r = GRM.S().logColor[5][1];
        g = GRM.S().logColor[5][2];
        b = GRM.S().logColor[5][3];
    elseif index == 3 then -- Leveled
        r = GRM.S().logColor[2][1];
        g = GRM.S().logColor[2][2];
        b = GRM.S().logColor[2][3];
    elseif index == 4 then -- Note
        r = GRM.S().logColor[6][1];
        g = GRM.S().logColor[6][2];
        b = GRM.S().logColor[6][3];
    elseif index == 5 then -- OfficerNote
        r = GRM.S().logColor[7][1];
        g = GRM.S().logColor[7][2];
        b = GRM.S().logColor[7][3];
    elseif index == 6 then -- Rank Rename
        r = GRM.S().logColor[10][1];
        g = GRM.S().logColor[10][2];
        b = GRM.S().logColor[10][3];
    elseif index == 7 or index == 8 then -- Join/Rejoin
        r = GRM.S().logColor[1][1];
        g = GRM.S().logColor[1][2];
        b = GRM.S().logColor[1][3];
    elseif index == 9 or index == 17 or index == 20 or index == 21 then -- Ban and Unbans
        r = GRM.S().logColor[14][1];
        g = GRM.S().logColor[14][2];
        b = GRM.S().logColor[14][3];
    elseif index == 10 then -- Left Guild
        r = GRM.S().logColor[12][1];
        g = GRM.S().logColor[12][2];
        b = GRM.S().logColor[12][3];
    elseif index == 11 then -- NameChange
        r = GRM.S().logColor[9][1];
        g = GRM.S().logColor[9][2];
        b = GRM.S().logColor[9][3];
    elseif index == 12 or index == 18 or index == 98 or index == 99 then -- WhiteText
        r = 1.0;
        g = 1.0;
        b = 1.0;
    elseif index == 13 then -- Rejoining Player Warning (RED)
        r = 0.4;
        g = 0.71;
        b = 0.9;
    elseif index == 14 then -- Return from inactivity
        r = GRM.S().logColor[3][1];
        g = GRM.S().logColor[3][2];
        b = GRM.S().logColor[3][3];
    elseif index == 15 then -- Event Announcement
        r = GRM.S().logColor[11][1];
        g = GRM.S().logColor[11][2];
        b = GRM.S().logColor[11][3];
    elseif index == 16 or index == 22 or index == 23 or index == 25 then -- Recommendations
        r = GRM.S().logColor[13][1];
        g = GRM.S().logColor[13][2];
        b = GRM.S().logColor[13][3];
    elseif index == 19 then -- Custom Note
        r = GRM.S().logColor[8][1];
        g = GRM.S().logColor[8][2];
        b = GRM.S().logColor[8][3];
    elseif index == 24 then -- Death Report
        r = GRM.S().logColor[15][1];
        g = GRM.S().logColor[15][2];
        b = GRM.S().logColor[15][3];
    end

    return r, g, b;
end

-- Method:          RemoveItemFromLog ( index , bool , bool )
-- What it Does:    Finds the matching string in the log, and removes it from the tempFiltered Log and the core log.
-- Purpose:         For quick log cleanup.
-- Notes:           Worth mentioning, one of the reasons it is handled this way is because you want to clear the lines but not do a full refresh of the log, which takes
--                  processing, but more importantly, resets the slider to the top. This allows you to clear as you move and continue on.
local RemoveItemFromLog = function(index, buildLog, buildComplete)

    local tempIndex = GRM_G.fullLogMatch[index][5]; -- This is identifying index. If repeated, it is a multi-line input to the log entry.
    local tempText = GRM_G.fullLogMatch[index][6];

    local i = 1;
    local isFound = false;

    -- Remove it from the tempLog
    while i <= #GRM_G.fullLogMatch and (not isFound or (isFound and GRM_G.fullLogMatch[i][5] == tempIndex)) do
        if GRM_G.fullLogMatch[i][5] == tempIndex then
            isFound = true;
            table.remove(GRM_G.fullLogMatch, i);
        else
            i = i + 1;
        end
    end

    -- Shift all values by 1, since we are removing
    if i > 1 then
        for j = (i - 1), #GRM_G.fullLogMatch do
            GRM_G.fullLogMatch[j][5] = GRM_G.fullLogMatch[j][5] - 1;
        end
    end

    -- Remove from core.
    for i = #GRM.GetLog(), 1, -1 do
        if GRM.GetLog()[i][2] == tempText then
            table.remove(GRM.GetLog(), i);
            break
        end
    end

    if buildLog and GRM_UI.GRM_CoreFrame.GRM_LogFrame:IsVisible() then
        GRM_G.LogNumbersColorUpdate = true;
        Log.BuildLogComplete(true, buildComplete);
    end
end

-- Method:          AddOldLogHeader()
-- What it Does:    Returns the string of the Old Log header
-- Purpose:         Cleaner Log reporting.
local AddOldLogHeader = function()
    return ("|cffffd600----------   " .. GRM.L("OLD LOG") .. "  ----------|r");
end

-- Method:          AddNewChangesHeader()
-- What it Does:    Returns the string of the "Changes" header since last logged in the log
-- Purpose:         Cleaner log reporting
local AddNewChangesHeader = function()
    return ("|cffffd600----------  " .. GRM.L("CHANGES") .. "  ----------|r")
end

-- Method:          Log.PrintLog ( array )
-- What it Does:    Sets the color of the string to be reported to the frame (typically chat frame, or to the Log Report frame)
-- Purpose:         Color coding log and chat frame reporting.
Log.PrintLog = function(logReport)

    if logReport[2] ~= "" and logReport[2] ~= nil then
        GRM.ReportLocationCheck();

        for i = 1, #GRM_G.Chat do
            if (logReport[1] == 1) then -- Promoted
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[4][1], GRM.S().logColor[4][2],
                    GRM.S().logColor[4][3]);
            elseif (logReport[1] == 2) then -- Demoted
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[5][1], GRM.S().logColor[5][2],
                    GRM.S().logColor[5][3]);
            elseif (logReport[1] == 3) then -- Leveled
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[2][1], GRM.S().logColor[2][2],
                    GRM.S().logColor[2][3]);
            elseif (logReport[1] == 4) then -- Note
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[6][1], GRM.S().logColor[6][2],
                    GRM.S().logColor[6][3]);
            elseif (logReport[1] == 5) then -- Officer Note
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[7][1], GRM.S().logColor[7][2],
                    GRM.S().logColor[7][3]);
            elseif (logReport[1] == 6) then -- Rank Renamed
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[10][1], GRM.S().logColor[10][2],
                    GRM.S().logColor[10][3]);
            elseif (logReport[1] == 7) or (logReport[1] == 8) then -- Join and Rejoin!
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[1][1], GRM.S().logColor[1][2],
                    GRM.S().logColor[1][3]);
            elseif (logReport[1] == 9) or (logReport[1] == 17) or (logReport[1] == 20) or (logReport[1] == 21) then -- WARNING BANNED PLAYER REJOIN!
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[14][1], GRM.S().logColor[14][2],
                    GRM.S().logColor[14][3]);
            elseif (logReport[1] == 10) then -- Left the guild
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[12][1], GRM.S().logColor[12][2],
                    GRM.S().logColor[12][3]);
            elseif (logReport[1] == 11) then -- Namechanged
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[9][1], GRM.S().logColor[9][2],
                    GRM.S().logColor[9][3]);
            elseif (logReport[1] == 12) or (logReport[1] == 18) or (logReport[1] == 98) or (logReport[1] == 99) then -- WHITE TEXT IGNORE RGB COLORING
                GRM_G.Chat[i]:AddMessage(logReport[2], 1.0, 1.0, 1.0);
            elseif (logReport[1] == 13) then -- Rejoining PLayer Custom Note Report - returning player warning
                GRM_G.Chat[i]:AddMessage(logReport[2], 0.4, 0.71, 0.9);
            elseif (logReport[1] == 14) then -- Player has returned from inactivity
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[3][1], GRM.S().logColor[3][2],
                    GRM.S().logColor[3][3]);
            elseif (logReport[1] == 15) then -- For event notifications like upcoming anniversaries.
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[11][1], GRM.S().logColor[11][2],
                    GRM.S().logColor[11][3]);
            elseif (logReport[1] == 16) or (logReport[1] == 22) or (logReport[1] == 23) or (logReport[1] == 25) then -- For Recommendations On Macro Tool
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[13][1], GRM.S().logColor[13][2],
                    GRM.S().logColor[13][3]);
            elseif (logReport[1] == 19) then -- For Custom Note
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[8][1], GRM.S().logColor[8][2],
                    GRM.S().logColor[8][3]);
            elseif (logReport[1] == 24) then -- For Custom Note
                GRM_G.Chat[i]:AddMessage(logReport[2], GRM.S().logColor[15][1], GRM.S().logColor[15][2],
                    GRM.S().logColor[15][3]);
            end
        end
    end
end

-- Method:          Log.ClearAllLogLinesWithinRange ( int , int )
-- What it Does:    Parse through all of the fontstrings visible, then matches them to the log and purges them
-- Purpose:         For log cleanup and UI features for the user
Log.ClearAllLogLinesWithinRange = function(start, stop)

    if start == 0 then
        start = 1;
    end

    local totalCount = stop - start + 1;
    local log = GRM_G.fullLogMatch;
    local index = 0;

    for i = 1, #log do
        if index ~= log[i][4] and log[i][5] >= start and log[i][5] <= stop then
            index = log[i][4]
            -- Next entry!
            table.remove(GRM.GetLog(), log[i][4]);
            -- You need to keep incrementing because the table will be shrinking.

        elseif log[i][5] > stop then
            break -- easy escape to not process everything!
        end
    end

    GRM_G.CurrentTotalCount = GRM_G.CurrentTotalCount - totalCount;

    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_NumEntriesText:SetText(GRM.L(
        "Total Entries: {num}", nil, nil, GRM_G.CurrentTotalCount));

    if totalCount == 1 then
        GRM.Report(GRM.L("1 entry has been removed from the log"));
    else
        GRM.Report(GRM.L("{num} entries have been removed from the log", nil, nil, totalCount));
    end

end

-- Method:          LogSetLastValue()
-- What it Does:    Triggers the setting fo all values at index 40 of the core log
-- Purpose:         On the single line shift, you end up with 1 on the edge that needs to be built
local LogSetLastValue = function()
    SetLogValues(#GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons,
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset);
end

-- Method:          LogSetFirstValue()
-- What it Does:    Triggers the setting fo all values at index 1 of the core Log
-- Purpose:         On the single line shift, you end up with 1 on the edge that needs to be built
local LogSetFirstValue = function()
    SetLogValues(1, GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset -
        #GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons + 1);
end

-- Method:          LogToolHybridShiftDown()
-- What it Does:    Shifts all the values down one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
local LogToolHybridShiftDown = function()
    if #GRM_G.fullLogMatch > 25 then
        local fontStrings = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons;
        local MouseOverButton = 0;
        -- Shift them down...
        for i = 1, #fontStrings - 1 do
            fontStrings[i][2]:SetText(fontStrings[i + 1][2]:GetText());
            fontStrings[i][2]:SetTextColor(fontStrings[i + 1][2]:GetTextColor(fontStrings[i + 1][2]:GetText()));
            fontStrings[i][3]:SetText(fontStrings[i + 1][3]:GetText());
            fontStrings[i][3]:SetTextColor(fontStrings[i + 1][3]:GetTextColor(fontStrings[i + 1][3]:GetText()));
            fontStrings[i][4] = fontStrings[i + 1][4]

            if MouseOverButton == 0 and fontStrings[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end
        GRM.LogSetLastValue();
        if MouseOverButton > 0 then
            Log.RefreshLogTooltip(fontStrings[MouseOverButton][1]);
        end
    end
end

-- Method:          LogToolHybridShiftUP()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
local LogToolHybridShiftUP = function()
    if #GRM_G.fullLogMatch > 25 then
        local fontStrings = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons;
        local MouseOverButton = 0;
        -- Shift them down...
        for i = #fontStrings, 2, -1 do
            fontStrings[i][2]:SetText(fontStrings[i - 1][2]:GetText());
            fontStrings[i][2]:SetTextColor(fontStrings[i - 1][2]:GetTextColor(fontStrings[i - 1][2]:GetText()));
            fontStrings[i][3]:SetText(fontStrings[i - 1][3]:GetText());
            fontStrings[i][3]:SetTextColor(fontStrings[i - 1][3]:GetTextColor(fontStrings[i - 1][3]:GetText()));
            fontStrings[i][4] = fontStrings[i - 1][4]
            -- Configure new SetPoints due to varying string sizes

            if MouseOverButton == 0 and fontStrings[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end
        LogSetFirstValue();
        if MouseOverButton > 0 then
            Log.RefreshLogTooltip(fontStrings[MouseOverButton][1]);
        end
    end
end

-- Method:          SetLogValues ( int , int )
-- What it Does:    Sets the fontstring values for the lineNumber count and the actual strings for display
-- Purpose:         So we have a functioning hybrid scrollframe on the core log.
local SetLogValues = function(indString, indLog)
    if indString <= #GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons then

        local logFontString = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame
                                  .AllButtons[indString][2];
        local logCount =
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[indString][3];
        local logEntry = GRM_G.fullLogMatch[indLog][2];
        local r, g, b = GetMessageRGB(GRM_G.fullLogMatch[indLog][1]);
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[indString][4] =
            indLog;

        -- Reset the sizing based on settings
        if GRM.S().showLineNumbers then

            if GRM_G.fullLogMatch[indLog][1] == 98 then
                logCount:SetTextColor(1, 1, 1, 0);
                GRM_G.OldLogHeaderIsOn = true;
            elseif GRM_G.fullLogMatch[indLog][1] == 97 then
                logCount:SetTextColor(1, 1, 1, 0);
            elseif GRM_G.fullLogMatch[indLog][3] and
                not (indLog > 1 and GRM_G.fullLogMatch[indLog][4] == GRM_G.fullLogMatch[indLog - 1][4] and
                    GRM_G.fullLogMatch[indLog - 1][1] ~= 97) then -- if true it should be red, indicating selection
                logCount:SetTextColor(1, 0, 0, 1);
            elseif indLog > 1 and GRM_G.fullLogMatch[indLog][4] == GRM_G.fullLogMatch[indLog - 1][4] and
                GRM_G.fullLogMatch[indLog - 1][1] ~= 97 then
                -- Hide the count
                logCount:SetTextColor(1, 1, 1, 0);
            else
                logCount:SetTextColor(1, 1, 1, 1);
            end

            logCount:SetText(GRM_G.fullLogMatch[indLog][5] .. ")");
            logCount:Show();
            if GRM_G.OldLogHeaderIsOn and indLog > (#GRM.GetLog() - GRM_G.IndexOfLastLogEntry) then
                indLog = indLog - 1;
            end
        else
            logCount:Hide();
        end

        logFontString:SetTextColor(r, g, b, 1);
        logFontString:SetText(logEntry);
        logFontString:Show();

        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[indString][1]:Show();

        if GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:IsVisible() and
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[indString][1]:IsMouseOver() then
            Log.RefreshLogTooltip(GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame
                                      .AllButtons[indString][1]);
        end
    end
end

-- Method:          GetOperatorsFromText ( string )
-- What it Does:    Adds operator controls to the search strings of the log
-- Purpose:         Quality of life improvement on searching the log
local GetOperatorsFromText = function(text)
    local operators = {};
    local operatorControls = {string.char(124)};

    for i = 1, #operatorControls do
        if string.find(text, operatorControls[i], 1, true) ~= nil then
            table.insert(operators, i);
            -- text = string.gsub ( text , operatorControls[i] , "" );     -- Clear Operator after having been found
        end
    end

    return GRM.Util.Trim(text), operators;
end

-- Helper to avoid re-creation on every recursion
local addLogEntry = function(tempLog, text, uneditedText, ind, point, count)
    local newlinePos = string.find(text, "\n", 1, true)
    while newlinePos do
        table.insert(tempLog, {
            ind, 
            string.sub(text, 1, newlinePos - 1), 
            false, 
            point, 
            count, 
            uneditedText
        })
        text = string.sub(text, newlinePos + 1)
        newlinePos = string.find(text, "\n", 1, true)
    end
    table.insert(tempLog, {ind, text, false, point, count, uneditedText})
    return tempLog
end

-- Method:          Log.GetSearchLog ( bool , string , int , table , int )
-- What it Does:    Pre-builds all the values to display based on the various filter parameters.
-- Purpose:         Make building a hybridscrollframe for the log that much simpler, and keeps it from reprocessing over and over.
Log.GetSearchLog = function(isSearch, searchString, currentPosition, finalResult, TotalC)
    local result = finalResult or {}
    local needsToAddSearchString = false
    local trueString = false
    local index = 0
    local logTxt = ""
    local totalCount = TotalC or 0
    local gLog = GRM.GetLog()
    local c = 0

    if not gLog then
        return
    end

    -- Set possible first Entry
    if not currentPosition and GRM_G.ChangesFoundOnLoad and GRM_G.FirstTimeViewed and GRM_G.IndexOfLastLogEntry < #gLog and
        #gLog > 0 and GRM_G.IndexOfLastLogEntry ~= #gLog then
        table.insert(result, {97, " ", false, 0, 0, AddNewChangesHeader()})
        table.insert(result, {97, AddNewChangesHeader(), false, 0, 0, AddNewChangesHeader()})
    end

    local i = currentPosition or #gLog
    local changesEndAdded = false

    while i > 0 and (not isSearch or (isSearch and c < 5000)) do
        trueString = false
        needsToAddSearchString = false
        
        if GRM_G.FirstTimeViewed and GRM_G.ChangesFoundOnLoad and not changesEndAdded and GRM_G.IndexOfLastLogEntry <
            #gLog and #gLog > 0 and i == GRM_G.IndexOfLastLogEntry and GRM_G.IndexOfLastLogEntry ~= #gLog then

            -- OLD LOG HEADER
            table.insert(result, {98, AddOldLogHeader(), false, 0, 0, AddOldLogHeader()})
            table.insert(result, {98, " ", false, 0, 0, AddOldLogHeader()})
            changesEndAdded = true
        else
            index = gLog[i][1]
            logTxt = gLog[i][2]

            -- Process search parameter
            if isSearch and #searchString > 0 and string.find(logTxt, "\000", 1, true) == nil then
                local lowerTxt = string.lower(logTxt)

                -- Operator search integration
                if string.sub(searchString, 1, 1) == "^" then
                    local opSearch = GetOperatorsFromText(string.sub(searchString, 2))
                    local cleanedTxt = string.gsub(lowerTxt, "|r", "")
                    if string.find(cleanedTxt, opSearch, 1, true) ~= nil then
                        needsToAddSearchString = true
                    end
                else
                    -- Normal search
                    local cleanedTxt = string.gsub(lowerTxt, "|r", "")
                    
                    -- Try direct matching first (highly efficient)
                    if string.find(cleanedTxt, searchString, 1, true) ~= nil then
                        needsToAddSearchString = true
                    else
                        --  Only fallback to purging special characters if direct search yields no results
                        local noSpecialChars = GRM.RemoveSpecialCharacters(cleanedTxt)
                        if string.find(noSpecialChars, searchString, 1, true) ~= nil then
                            needsToAddSearchString = true
                        end
                    end
                end
            end

            -- Determine if entry matches index filters
            if index == 1 and GRM.S().toLog.promotion then
                trueString = true
            elseif index == 2 and GRM.S().toLog.demotion then
                trueString = true
            elseif index == 3 and GRM.S().toLog.leveled then
                if gLog[i][5] then
                    if gLog[i][5] >= GRM.S().levelReportMin then
                        trueString = true
                    end 
                else
                    local num = ""
                    if string.find(logTxt, "***", 1, true) == nil then
                        num = string.match(logTxt, " (%d+) %(")
                    else
                        -- Fixed potential nil global error (changed logText to logTxt)
                        num = string.match(logTxt, "(%d+)\124r[^\124]+\124c%x+%*%*%*")
                    end
                    if tonumber(num) and tonumber(num) >= GRM.S().levelReportMin then
                        trueString = true
                    end
                end
            elseif index == 4 and GRM.S().toLog.note then
                trueString = true
            elseif index == 5 and GRM.S().toLog.officerNote then
                trueString = true
            elseif index == 6 and GRM.S().toLog.rankRename then
                trueString = true
            elseif (index == 7 or index == 8) and GRM.S().toLog.joined then
                trueString = true
            elseif index == 10 and GRM.S().toLog.left then
                trueString = true
            elseif index == 11 and GRM.S().toLog.nameChange then
                trueString = true
            elseif index == 14 and GRM.S().toLog.inactiveReturn then
                trueString = true
            elseif index == 15 and GRM.S().toLog.eventAnnounce then
                trueString = true
            elseif (index == 16 or index == 22 or index == 23 or index == 25) and GRM.S().toLog.recommend then
                trueString = true
            elseif (index == 17 or index == 18 or index == 20 or index == 21) and GRM.S().toLog.banned then
                trueString = true
            elseif (index == 9 or index == 12 or index == 13) and GRM.S().toLog.joined then
                trueString = true
            elseif index == 24 and GRM.S().toLog.death then
                trueString = true
            elseif index == 19 and GRM.S().toLog.customNote then
                trueString = true
            end

            if trueString then
                if (isSearch and needsToAddSearchString) or (not isSearch) then
                    totalCount = totalCount + 1
                    result = addLogEntry(result, logTxt, logTxt, index, i, totalCount)
                end
            end
            i = i - 1
            c = c + 1
        end
    end

    if isSearch and i > 0 then
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox.GRM_LogSearchPendingText:Show()
        C_Timer.After(0.1, function()
            Log.GetSearchLog(isSearch, searchString, i, result, totalCount)
        end)
        return
    elseif isSearch and i == 0 and currentPosition ~= nil then
        Log.BuildLog("", true, true, result, totalCount)
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox.GRM_LogSearchPendingText:Hide()
        return
    end

    return result, totalCount
end

-- Method:          Log.SetColoredLines()
-- What it Does:    Sets all of the instances in the temp filtered log as true or false, indicating which lines should be red or not.
-- Purpose:         Line coloring!!!
Log.SetColoredLines = function()
    local number = tonumber(
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame.GRM_LogExtraEditBox1:GetText());
    local number2 = tonumber(
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame.GRM_LogExtraEditBox2:GetText());
    local clearAll = false;

    if (number2 < number) then
        clearAll = true;
    end

    if not (number == 0 and number == number2) and number <= number2 or clearAll then
        for i = 1, #GRM_G.fullLogMatch do
            if not clearAll and GRM_G.fullLogMatch[i][5] >= number and GRM_G.fullLogMatch[i][5] <= number2 then
                GRM_G.fullLogMatch[i][3] = true;
            else
                GRM_G.fullLogMatch[i][3] = false
            end
        end
    end
end

-- Method:          Log.BuildLogComplete()
-- What it Does:    Checks the editbox and sees whether to build the log normal, or to auto-rebuild the log based on the custom text filter.
-- Purpose:         The Call to rebuild the log is done about 50 times. This cleans up the code bloat.
Log.BuildLogComplete = function(UIControl, fullRefresh , logByPass )
    if GRM_UI.GRM_CoreFrame:IsVisible() and ( ( GRM_G.logBypass or logByPass ) or GRM_G.logUpdatedCount ~= #GRM.GetLog() ) then
        GRM_G.logUpdatedCount = #GRM.GetLog();  -- No need to refresh if log hasn't changed...
        GRM_G.logBypass = false;

        if GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox:GetText() ~= "" and
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox:GetText() ~= GRM.L("Search Filter") then
            Log.BuildLog(GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox:GetText(), fullRefresh);
        else
            Log.BuildLog(nil, fullRefresh);
        end

        -- Set Focus on the bar automatically...
        if GRM.S().autoFocusSearch and not GRM_G.OnFirstLoad and not UIControl and not GRM_G.SearchFocusControl then
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox:SetFocus();
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox:SetText("");
        end
    end
end

-- Method:          Log.BuildLog( string , bool , bool , bool , table , int )
-- What it Does:    Builds the guildLog frame details for the scrollframe
-- Purpose:         You aren't tracking all of that info for nothing!
Log.BuildLog = function( searchString , fullRefresh , delayedSearch , fullLogMatch , TotalCount )
    local isSearch = false;
    local hybridScrollFrameButtonCount = 29; -- Exactly 25 buttons
    local buttonHeight = 17.138
    local buttonWidth = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollFrame:GetWidth() - 5;

    if not delayedSearch then
        if searchString ~= nil and type(searchString) == "string" then
            searchString = string.lower(searchString); -- Remove case sensitivity
            isSearch = true;
        end

        -- Only rebuild the log if necessary based on new parameters.
        if fullRefresh then
            GRM_G.fullLogMatch, GRM_G.CurrentTotalCount = Log.GetSearchLog ( isSearch , searchString );
        end
    else
        GRM_G.fullLogMatch = fullLogMatch;
        GRM_G.CurrentTotalCount = TotalCount;
    end

    if GRM_G.fullLogMatch == nil then
        return;
    end

    local log = GRM_G.fullLogMatch;

    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset =
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset or
            hybridScrollFrameButtonCount;

    if GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset <
        hybridScrollFrameButtonCount then
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset =
            hybridScrollFrameButtonCount;
    elseif GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset >
        hybridScrollFrameButtonCount and
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset > #log then
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset = #log;
    end

    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons =
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons or {};

    for i = 1, #log do
        -- Build HybridScrollFrame Buttons
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i] then
                local button = CreateFrame("Button", "LogButton" .. i, GRM_UI.GRM_CoreFrame.GRM_LogFrame
                    .GRM_RosterChangeLogScrollChildFrame);
                GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i] =
                    { button, button:CreateFontString(nil), button:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny"),0 };

                if i == 1 then
                    button:SetPoint("TOP",
                        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame, "TOP", -1, 0);
                else
                    button:SetPoint("TOPLEFT", GRM_UI.GRM_CoreFrame.GRM_LogFrame
                        .GRM_RosterChangeLogScrollChildFrame.AllButtons[i - 1][1], "BOTTOMLEFT", 0, 0);
                end

                Log.BuildCoreLogFontstrings(i, buttonHeight, buttonWidth);
            end
        end

        if (i >=
            (GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset -
                hybridScrollFrameButtonCount + 1) and i <=
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.Offset) then
            SetLogValues(i -
                                 (GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame
                                     .Offset - hybridScrollFrameButtonCount), i);
        end
    end

    -- Remove the buffer on one of them due to the top not needing it.
    -- Hide unused buttons...
    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons do
        if i > #log then
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][1]:Hide();
        else
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][1]:Show();
        end
    end

    local DatabaseAvailable = function()
        local result = true;

        if GRM_G.fullLogMatch == nil then
            result = false;
        end

        return result;
    end

    GRM_UI.SetHybridScrollFrameSliderParameters(GRM_UI.GRM_CoreFrame.GRM_LogFrame
                                                 .GRM_RosterChangeLogScrollChildFrame, GRM_UI.GRM_CoreFrame
        .GRM_LogFrame.GRM_RosterChangeLogScrollFrame, GRM_UI.GRM_CoreFrame.GRM_LogFrame
        .GRM_RosterChangeLogScrollFrameSlider, buttonWidth, buttonHeight, buttonHeight * #log, #log,
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons,
        LogToolHybridShiftDown, LogToolHybridShiftUP, hybridScrollFrameButtonCount, DatabaseAvailable);

    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_NumEntriesText:SetText(GRM.L(
        "Total Entries: {num}", nil, nil, GRM_G.CurrentTotalCount));
end

-- Method:          Log.BuildCoreLogFontstrings ( int , float , int )
-- What it Does:    Initiates the fontstring values for the Core Log
-- Purpose:         Compartmentalize the code for easier call back to.
Log.BuildCoreLogFontstrings = function(ind, size, buttonWidth, isResizeAction)
    local button = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[ind][1];
    local logFontString =
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[ind][2];
    local logCount = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[ind][3];
    local modifier = 7;
    local stringWidth = buttonWidth - 5
    if GRM.S().showLineNumbers then
        modifier = 8.5;
        stringWidth = buttonWidth - 45
        logFontString:SetPoint("LEFT", button, "LEFT", 36, 0)
    else
        logFontString:SetPoint("LEFT", button, "LEFT", 0, 0)
    end

    logCount:SetPoint("LEFT", button, "LEFT", 0, 0);
    logCount:SetJustifyH("LEFT");
    logCount:SetWidth(35);
    logCount:SetTextColor(1, 1, 1);
    logCount:SetWordWrap(false);
    logCount:SetFont(GRM_G.FontChoice, GRM.S().logFontSize + size - modifier);

    logFontString:SetJustifyH("LEFT");
    logFontString:SetWidth(stringWidth);
    logFontString:SetWordWrap(false);

    logFontString:SetFont(GRM_G.FontChoice, GRM.S().logFontSize + size - modifier);

    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip.GRM_LogTooltipText1:SetFont(GRM_G.FontChoice, GRM.S()
        .logFontSize + size - modifier);

    if not isResizeAction then
        button:SetSize(buttonWidth, size);
        button:RegisterForDrag("LeftButton");

        -- Tooltips
        button:SetScript("OnEnter", function(self)
            Log.RefreshLogTooltip(self);
        end);
        button:SetScript("OnLeave", function()
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:Hide();
        end);
        button:SetScript("OnDragStart", function()
            GRM_UI.GRM_CoreFrame:StartMoving();
        end);
        button:SetScript("OnDragStop", function()
            GRM_UI.GRM_CoreFrame:StopMovingOrSizing();
            GRM_UI.SaveCorePosition();
        end);

        -- Log One Click Behavior
        button:SetScript("OnClick", function(self, buttonClicked)
            if buttonClicked == "LeftButton" then
                if IsControlKeyDown() and IsShiftKeyDown() and GRM.S().shiftClickRemove and
                    not GRM_UI.GRM_RosterConfirmFrame:IsVisible() then
                    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame
                        .AllButtons do
                        if GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][1] ==
                            self then
                            if GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame
                                .AllButtons[i][1]:IsMouseOver() then
                                RemoveItemFromLog(GRM_UI.GRM_CoreFrame.GRM_LogFrame
                                                          .GRM_RosterChangeLogScrollChildFrame.AllButtons[i][4], true,
                                    true);
                            end
                            break
                        end
                    end

                -- CTRL-Click on opening the player window
                elseif IsControlKeyDown() then
                    local names = {};
                    local text = logFontString:GetText();
                    local fullName = "";

                    for name in text:gmatch ( "|cff%x%x%x%x%x%x(.-)|r" ) do
                        if not name:find ( "%d" ) and not name:find ( "*" ) and not name:find ( GRM.L ( "Hurray!" ) ) then
                            table.insert ( names , { name } );
                        end
                    end

                    if #names > 0 then
                        local ind = 1;
                        if #names > 1 then
                            ind = 2;        -- The 2nd name is the one with action against them so player should open that window
                        end

                        if string.find ( names[ind][1] , "-" ) then
                            fullName = names[ind][1];
                        else
                            local realm = GRM.GetPlayerServer ( names[ind][1] );
                            if realm and realm ~= "" then
                                fullName = names[ind][1] .. "-" .. realm;
                            else
                                fullName = names[ind][1];
                            end
                        end

                        if fullName and fullName ~= "" and string.find ( fullName , "-" ) and GRM.GetPlayer ( fullName ) then
                            GRM.OpenPlayerWindow ( fullName );

                        elseif fullName ~= "" and not GRM.GetPlayer ( fullName ) then
                            GRM.Report ( GRM.L ( "{name} is no longer in the guild" , names[ind][1] ) );
                        end
                    end
                end
            end
        end);
    end
end

-- Method:          Log.RefreshLogTooltip()
-- What it Does:    Refreshes the tooltip of the button moused over in the log that has text that is too long
-- Purpose:         Enhanced log features
Log.RefreshLogTooltip = function(button)
    if GRM.S().showTooltip then
        for i = 1, #GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons do
            if GRM_G.fullLogMatch == nil then
                break
            else
                if GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][1] ==
                    button then
                    local text = GRM_G.fullLogMatch[GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][4]][6];

                    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip.GRM_LogTooltipText1:SetText(text);
                    local width =
                        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip.GRM_LogTooltipText1:GetWidth();

                    local r, g, b = GetMessageRGB(GRM_G.fullLogMatch[GRM_UI.GRM_CoreFrame.GRM_LogFrame
                                                          .GRM_RosterChangeLogScrollChildFrame.AllButtons[i][4]][1]);
                    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:SetOwner(button, "ANCHOR_CURSOR");
                    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:AddLine("|CFFE6CC7F" ..
                                                                                            GRM.L("Full Log Message:"));
                    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:AddLine(" ");

                    if width >
                        (GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][2]:GetWidth() +
                            200) then
                        local index = string.find(text, "%s", math.floor(#text / 2));
                        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:AddLine(string.sub(text, 1, index),
                            r, g, b);
                        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:AddLine(string.sub(text, index + 1),
                            r, g, b);
                    else
                        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:AddLine(text, r, g, b);
                    end

                    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip:Show();
                    break
                end
            end
        end
    end
end

-- Method:          Log.ResetLogStringPoints ( bool )
-- What it Does:    Sets point of all the built fontstrings to account for spacing needed for the count or not and resets the size width
-- Purpose:         Aesthetics on the log
Log.ResetLogStringPoints = function(countEnabled)
    local position = 0;
    local modifier = 7;
    if GRM.S().showLineNumbers then
        modifier = 8.5;
    end
    local width = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollFrame:GetWidth() - 10;
    if countEnabled then
        position = 36;
        width = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollFrame:GetWidth() - 50;
    end

    for i = 1, #GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons do
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][2]:SetPoint(
            "LEFT", GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][1],
            "LEFT", position, 0);
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][2]:SetWidth(width);
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][2]:SetFont(
            GRM_G.FontChoice, GRM.S().logFontSize + 17.08 - modifier);
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_RosterChangeLogScrollChildFrame.AllButtons[i][3]:SetFont(
            GRM_G.FontChoice, GRM.S().logFontSize + 17.08 - modifier);
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogTooltip.GRM_LogTooltipText1:SetFont(GRM_G.FontChoice,
            GRM.S().logFontSize + 17.08 - modifier);
    end
end

-------------------------------------------
------- BUILD LOG ENTRY STORAGE FORMATS ---
-------------------------------------------

-- Method:          Log.AddPromotionDateTempLogEntry ( bool , string , string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddPromotionDateTempLogEntry = function(foundInLog, player1, player2, initRank, finRank, date)
    table.insert(GRM_G.TempLogPromotion,
        {1, GRM.GetPromotionLogString(foundInLog, player1, player2, initRank, finRank, date), foundInLog, player1,
         player2, initRank, finRank, date});
end

-- Method:          Log.AddDemotionDateTempLogEntry ( bool , string , string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddDemotionDateTempLogEntry = function(foundInLog, player1, player2, initRank, finRank, date)
    table.insert(GRM_G.TempLogDemotion,
        {2, GRM.GetDemotionLogString(foundInLog, player1, player2, initRank, finRank, date), foundInLog, player1,
         player2, initRank, finRank, date});
end

-- Method:          Log.AddLeveledTempLogEntry ( string , int , int , int , array , bool )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddLeveledTempLogEntry = function(simpleName, milestoneLevel, level, numGained, date, levelCap, fullName)
    table.insert(GRM_G.TempLogLeveled,
        {3, GRM.GetLeveledString(simpleName, milestoneLevel, level, numGained, date, levelCap, fullName), simpleName,
         milestoneLevel, level, numGained, date, levelCap, fullName});
end

-- Method:          Log.AddNoteTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddNoteTempLogEntry = function(simpleName, oldNote, newNote, date)
    table.insert(GRM_G.TempLogNote,
        {4, GRM.GetNoteChangeString(simpleName, oldNote, newNote, date), simpleName, oldNote, newNote, date});
end

-- Method:          Log.AddOfficerNoteTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddOfficerNoteTempLogEntry = function(simpleName, oldNote, newNote, date)
    table.insert(GRM_G.TempLogONote, {5, GRM.GetOfficerNoteChangeString(simpleName, oldNote, newNote, date), simpleName,
                                      oldNote, newNote, date});
end

-- Method:          Log.AddInactiveReturnTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddInactiveReturnTempLogEntry = function(simpleName, hoursReport, date)
    table.insert(GRM_G.TempInactiveReturnedLog,
        {14, GRM.GetInactiveReturnString(simpleName, hoursReport, date), simpleName, hoursReport, date});
end

-- Method:          Log.AddNameChangeTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddNameChangeTempLogEntry = function(simpleName, oldName, date)
    table.insert(GRM_G.TempNameChanged,
        {11, GRM.GetNameChangeString(simpleName, oldName, date), simpleName, oldName, date});
end

-- Method:          Log.AddBanRejoinEntry ( ... )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddBanRejoinEntry = function(foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
    numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined, origRank, customNote,
    isTransfer)
    table.insert(GRM_G.TempBannedRejoin, {9,
                                          GRM.GetJoinOrRejoinString(foundInLog, player1, player2, date, isRejoin,
        playerLevel, previousName, numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined,
        origRank, customNote, isTransfer), foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
                                          numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo,
                                          dateOriginallyJoined, origRank, customNote, playerLevel, isTransfer});
end

-- Method:          Log.AddNormalRejoinEntry ( ... )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddNormalRejoinEntry = function(foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
    numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined, origRank, customNote,
    isTransfer)
    table.insert(GRM_G.TempRejoin, {7,
                                    GRM.GetJoinOrRejoinString(foundInLog, player1, player2, date, isRejoin, playerLevel,
        previousName, numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined, origRank,
        customNote, isTransfer), foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
                                    numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined,
                                    origRank, customNote, playerLevel, isTransfer});

end

-- Method:          Log.AddJoinEntry ( bool , string , string , array , bool , int )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddJoinEntry = function(foundInLog, player1, player2, date, isRejoin, playerLevel)
    table.insert(GRM_G.TempNewMember,
        {8, GRM.GetJoinOrRejoinString(foundInLog, player1, player2, date, isRejoin, playerLevel), foundInLog, player1,
         player2, date, isRejoin, playerLevel});
end

-- Method:          Log.AddEventEntry ( int , string , string , int , bool , string , array , int )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventEntry = function(eventIndex, fullName, class, eventDay, eventMonthIndex, isLeapYear, date, numYears)
    if eventMonthIndex then
        table.insert(GRM_G.TempEventReport,
            {15, GRM.GetEventString(eventIndex, fullName, class, eventDay, eventMonthIndex, isLeapYear, date, numYears),
            eventIndex, fullName, class, eventDay, eventMonthIndex, isLeapYear, date, numYears});
    end
end

-- Method:          Log.AddHardcoreDeathEntry ( int , string , string , int , int , int , int )
-- What it Does:    Adds an entry for reporting to the log on Hardcore Mode deaths
-- Purpose:         Enable reporting to the log
Log.AddHardcoreDeathEntry = function(fullName, class, level, date)
    table.insert(GRM_G.TempDeathReport,
        {24, GRM.GetDeathString(fullName, class, level, date), fullName, class, level, date})
end

-- Method:          Log.AddRankRenameEntry ( int , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddRankRenameEntry = function(rankNum, oldRank, newRank, date)
    table.insert(GRM_G.TempRankRename,
        {6, GRM.GetRankRenamedString(rankNum, oldRank, newRank, date), rankNum, oldRank, newRank, date});
end

-- Method:          Log.AddEventRecommendKickTempLogEntry ( string , int , array , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendKickTempLogEntry = function(name, numRules, date, ruleNames)
    table.insert(GRM_G.TempEventRecommendKickReport,
        {16, GRM.GetRecommendKickString(name, numRules, date, ruleNames), name, numRules, date, ruleNames});
end

-- Method:          Log.AddEventRecommendPromotionLogEntry ( string , int , array , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendPromotionLogEntry = function(name, numRules, date, ruleNames)
    table.insert(GRM_G.TempEventRecommendPromotionReport, {22,
                                                           GRM.GetPromotionRecommendString(name, numRules, date,
        ruleNames), name, numRules, date, ruleNames});
end

-- Method:          Log.AddEventRecommendDemotionLogEntry ( string , int , array , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendDemotionLogEntry = function(name, numRules, date, ruleNames)
    table.insert(GRM_G.TempEventRecommendDemotionReport,
        {23, GRM.GetDemotionRecommendString(name, numRules, date, ruleNames), name, numRules, date, ruleNames});
end

-- Method:          Log.AddEventRecommendSpecialLogEntry ( int , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendSpecialLogEntry = function(promoteCount, demoteCount, date)
    table.insert(GRM_G.TempEventRecommendSpecialReport,
        {25, GRM.GetSpecialRecommendString(promoteCount, demoteCount, date), promoteCount, demoteCount, date});
end

-- Method:          Log.AddLeftOrKickEntry ( string , bool , string , array , array , string , string , string , array , bool )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddLeftOrKickEntry = function(unitName, playerWasKicked, timePassed, logEntryMetaData, listOfAlts, mainName,
    publicNote, officerNote, date, isFoundInEventLog, _, playerLevel, customNote)
    table.insert(GRM_G.TempLeftGuild, {10,
                                       GRM.GetLeftOrKickString(unitName, playerWasKicked, timePassed, logEntryMetaData,
        listOfAlts, mainName, publicNote, officerNote, date, isFoundInEventLog, nil, nil, playerLevel, customNote),
                                       unitName, playerWasKicked, timePassed, logEntryMetaData, listOfAlts, mainName,
                                       publicNote, officerNote, date, isFoundInEventLog, playerLevel, false, customNote});
end

-- Method:          Log.AddLog( list , string )
-- What it Does:    Adds a simple list to the Logreport that includes the indexcode for color, and the included changes as a string
-- Purpose:         For ease in adding to the core log.
Log.AddLog = function(logEntry, name)
    local guildName = name or GRM_G.guildName;
    if logEntry ~= nil and GRM_LogReport_Save[guildName] then
        table.insert(GRM_LogReport_Save[guildName], logEntry);
    end
end