-- Export Player Details logic

local Export = {};
GRM.Export = Export;

-- Export controls
GRM_G.ExportCap = 500; -- On exporting guild player details and exporting the guild log, max lines.
GRM_G.CounterCap = 0; -- Basically either the size of the log, or the size of the number of guildies, or size of number of left guildies.

-- Method:          Export.ExportMemberDetailsHeaders()
-- What it Does:    Creates a Headers Export
-- Purpose:         So player can easily build export headers for the data.
Export.ExportMemberDetailsHeaders = function(returnString)
    local scrollWidth = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:GetWidth() - 3;
    local headerOrder = {"name", "rank", "level", "class", "race", "sex", "lastOnline", "mainAlt", "alts", "joinDate",
                         "promoteDate", "rankHist", "bday", "rep", "note", "oNote", "cNote", "mythicScore", "faction", "realm" ,
                         "GUID"};

    local headers = {GRM.L("Name"), GRM.L("Rank"), GRM.L("Level"), GRM.L("Class"), GRM.L("Race"), GRM.L("Sex"),
                     GRM.L("Last Online (Days)"), GRM.L("Main/Alt"), GRM.L("Player Alts"), GRM.L("Join Date"),
                     GRM.L("Promo Date"), GRM.L("Rank History"), GRM.L("Birthday"), GRM.L("Guild Rep"),
                     GRM.L("Public Note"), GRM.L("Officer Note"), GRM.L("Custom Note"), GRM.L("Mythic+ Score"),
                     GRM.L("Faction"), GRM.L ("Realm Name") ,GRM.L("Player GUID")};

    local delimiter = "";
    if GRM.S().exportDelimiter[1] then
        delimiter = GRM.S().exportDelimiter[2];
    end

    local completeString = "";
    -- Build the string
    for i = 1, #headerOrder do

        if GRM.S().exportFilters[headerOrder[i]] then
            if ((headerOrder[i] ~= "rep" and headerOrder[i] ~= "mythicScore") or
                ((headerOrder[i] == "rep" and GRM_G.BuildVersion >= 40000) or
                    (headerOrder[i] == "mythicScore" and GRM_G.BuildVersion >= 80000))) then
                completeString = completeString .. headers[i] .. delimiter;
            end
        end
    end

    if #completeString > 0 then
        local modifier = 1;

        if delimiter == "||" or delimiter == "\\t" or delimiter == "::" then
            modifier = 2;
        end
        completeString = string.sub(completeString, 1, #completeString - modifier); -- eliminate the last delimiter
    end

    if not returnString and completeString ~= "" then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText(completeString);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HighlightText(0);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:Show();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();
        C_Timer.After(2, function()
            Export.ExportScrollSliderConfigure(scrollWidth);
        end);

    elseif returnString then
        return completeString;
    end
end

-- Method:          Export.BuildExportMemberDetails( int , string , string )
-- What it Does:    Exports the player details as a text stirng with a delimitter
-- Purpose:         Allow the player to easily export the information.
Export.BuildExportMemberDetails = function(currentMembers, specificGuild)
    local scrollWidth = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:GetWidth() - 3;
    local completeString = "";
    local delimiter = "";
    if GRM.S().exportDelimiter[1] then
        delimiter = GRM.S().exportDelimiter[2];
    end
    local altList = {};
    local alts = {};
    local altString = "";
    local playerDetails = "";

    local sex = "";
    local separator = ",";
    if delimiter == separator then
        separator = ";";
    end
    local rankHistory = "";
    local name = "";
    local currentRoster, formerRoster;

    -- Build the arrays to use.
    if specificGuild ~= nil then
        currentRoster, formerRoster = GRM.convertToArrayFormat(true, false, specificGuild);
    else
        currentRoster, formerRoster = GRM.convertToArrayFormat(true, false);
    end

    local roster = currentRoster;

    if not currentMembers then
        roster = formerRoster;
    end

    local num1 = tonumber(GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:GetText());
    local num2 = tonumber(GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:GetText());
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText("");
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSize(scrollWidth, 12); -- Default Size at one line

    local mainOnly, altOnly = false, false;

    -- For alt and main only filtering.
    local isValidMainOrAlt = function ( player )
        local isMain = false;

        if GRM.S().exportFilters.MainOrAlt then

            if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
                isMain = GRM.IsMain ( player.name );

            elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
                isMain = GRM.IsFormerMemberMain ( player );
            end

            if mainOnly and not isMain then
                return false;

            elseif altOnly then

                local isAlt = false;

                if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
                    isAlt = GRM.PlayerIsAnAlt ( player );
                elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
                    isAlt = GRM.IsFormerMemberAnAlt ( player );
                end

                if isMain or ( not isMain and not isAlt ) then
                    return false;
                end
            end

        end

        return true
    end
     -- Validates if it should be added to the string based on the conditions
     local isValid = function(player)
        local result = true;

        if player.level < GRM.S().ExportLevelRange[1] or player.level > GRM.S().ExportLevelRange[2] then
            result = false;
        end

        return result;
    end

    -- Cleanup the list to just mains/alts first.
    if GRM.S().exportFilters.MainOrAlt then
        mainOnly = GRM.S().exportFilters.mainOnly;

        if not GRM.S().exportFilters.mainOnly then
            altOnly = true;
        end

        -- Let's cleanup the list.
        for i = #roster , 1 , -1 do
            if not isValidMainOrAlt ( roster[i] ) then
                table.remove( roster , i );
            end
        end
    end

    if GRM.S().columnHeaders and num1 == 1 then
        completeString = Export.ExportMemberDetailsHeaders(true) .. "\n";
    end
    if num1 == 0 then
        num1 = 1;
    end

    for i = num1, num2 do
        playerDetails = "";
        sex = "";
        if num1 <= #roster then

            if isValid(roster[i]) then

                if GRM.S().exportFilters.name then

                    name = GRM.SlimName ( roster[i].name );

                    if GRM.S().specialCharRemoval then
                        name = GRM.RemoveSpecialCharacters(name);
                    end

                    playerDetails = playerDetails .. name .. delimiter; -- name
                end
                if GRM.S().exportFilters.rank then
                    playerDetails = playerDetails .. roster[i].rankName .. delimiter; -- rank
                end
                if GRM.S().exportFilters.level then
                    playerDetails = playerDetails .. roster[i].level .. delimiter; -- level
                end
                if GRM.S().exportFilters.class then
                    playerDetails = playerDetails .. GRM.GetClassName(roster[i].class) .. delimiter; -- class
                end
                if GRM.S().exportFilters.race then
                    if roster[i].race and roster[i].race ~= "" and GRM_G.raceIDEnum[roster[i].race] ~= nil then
                        playerDetails = playerDetails ..
                                            C_CreatureInfo.GetRaceInfo(GRM_G.raceIDEnum[roster[i].race]).raceName ..
                                            delimiter; -- Race
                    else
                        playerDetails = playerDetails .. GRM.L("Unknown") .. delimiter;
                    end
                end
                if GRM.S().exportFilters.sex then
                    if roster[i].sex ~= 1 then
                        sex = GRM.GetSex(roster[i].sex);
                        playerDetails = playerDetails .. sex .. delimiter; -- Sex
                    else
                        playerDetails = playerDetails .. GRM.L("Unknown") .. delimiter;
                    end
                end
                if GRM.S().exportFilters.lastOnline then
                    if roster[i].lastOnline < 24 then
                        playerDetails = playerDetails .. GRM.Round(roster[i].lastOnline / 24, 2) .. delimiter; -- Last Online  (in days, round to 2)
                    else
                        playerDetails = playerDetails .. math.floor((roster[i].lastOnline / 24) + 0.5) .. delimiter; -- keep it rounded to the nearest integer
                    end
                end

                -- Determine main status
                local isMain
                if currentMembers then
                    isMain = GRM.IsMain(roster[i].name);
                else
                    isMain = GRM.IsFormerMemberMain(roster[i]);
                end

                if GRM.S().exportFilters.mainAlt then -- Main or Alt

                    if isMain then
                        playerDetails = playerDetails .. GRM.L("Main") .. delimiter;
                    else
                        local isAlt;
                        if currentMembers then
                            isAlt = GRM.PlayerIsAnAlt(roster[i]);
                        else
                            isAlt = GRM.IsFormerMemberAnAlt(roster[i]);
                        end

                        if isAlt then
                            playerDetails = playerDetails .. GRM.L("Alt") .. delimiter;
                        else
                            playerDetails = playerDetails .. delimiter;
                        end
                    end
                end
                if GRM.S().exportFilters.alts then -- Player Alts

                    if (currentMembers and GRM.PlayerHasAlts(roster[i])) or
                        (not currentMembers and GRM.LeftPlayerHasAlts(roster[i])) then

                        if currentMembers then
                            alts = GRM.GetListOfAlts(roster[i]);
                        else
                            alts = roster[i].altsAtTimeOfLeaving;
                        end

                        altList = {};
                        altString = "";

                        for j = 1, #alts do
                            table.insert(altList, alts[j][1]);

                            if not isMain and (currentMembers and alts[j][1] == GRM.GetAltGroupMain(roster[i].altGroup)) or
                                (not currentMembers and #roster[i].mainAtTimeOfLeaving > 0 and alts[j][1] ==
                                    roster[i].mainAtTimeOfLeaving[1]) then
                                altList[#altList] = altList[#altList] .. GRM.L("(main)");
                            end
                        end
                        sort(altList);

                        for j = 1, #altList do
                            if j < #altList then
                                altString = altString .. altList[j] .. separator;
                            else
                                altString = altString .. altList[j]; -- No need to add a comma at the end of the list
                            end
                        end

                        playerDetails = playerDetails .. altString .. delimiter;
                    else
                        playerDetails = playerDetails .. delimiter;
                    end
                end
                if GRM.S().exportFilters.joinDate then -- Join Date
                    if roster[i].joinDateUnknown then
                        playerDetails = playerDetails .. GRM.L("Unknown") .. delimiter;
                    else
                        local pos = 1;
                        if roster[i].joinDateHist[1][7] == 2 then -- Date left
                            pos = 2;
                        end

                        if #roster[i].joinDateHist[pos][4] == 1 then
                            playerDetails = playerDetails .. delimiter;
                        else
                            playerDetails = playerDetails .. (GRM.DateUntrustedTag(roster[i].joinDateHist[pos][6]) ..
                                                GRM.Time.FormatTimeStamp(
                                    {roster[i].joinDateHist[pos][1], roster[i].joinDateHist[pos][2],
                                     roster[i].joinDateHist[pos][3]}, false)) .. delimiter;
                        end
                    end
                end
                if GRM.S().exportFilters.promoteDate then -- Promo Date
                    if roster[i].promoteDateUnknown then
                        playerDetails = playerDetails .. GRM.L("Unknown") .. delimiter;
                    else

                        local pos = 1;
                        if roster[i].rankHist[1][8] == 2 then -- Date left
                            pos = 2;
                        end

                        if #roster[i].rankHist[pos][5] == 1 then --- Promotion has never been recorded!
                            playerDetails = playerDetails .. delimiter;
                        else
                            playerDetails = playerDetails .. (GRM.DateUntrustedTag(roster[i].rankHist[pos][7]) ..
                                                GRM.Time.FormatTimeStamp(
                                    {roster[i].rankHist[pos][2], roster[i].rankHist[pos][3], roster[i].rankHist[pos][4]},
                                    false)) .. delimiter;
                        end
                    end
                end
                if GRM.S().exportFilters.rankHist then -- Rank History
                    rankHistory = GRM.GetRankHistory(roster[i], delimiter);
                    if #rankHistory == 0 then
                        playerDetails = playerDetails .. delimiter
                    else
                        playerDetails = playerDetails .. rankHistory .. delimiter;
                    end
                end
                if GRM.S().exportFilters.bday then -- Birthday
                    if roster[i].birthdayUnknown then
                        playerDetails = playerDetails .. GRM.L("Unknown") .. delimiter;
                    else
                        -- Checking button vs text
                        if roster[i].events[2][1][1] ~= 0 then
                            playerDetails = playerDetails .. GRM.Time.FormatTimeStamp( { roster[i].events[2][1][1] , roster[i].events[2][1][2] } , false, true) ..
                                                delimiter;
                        else
                            playerDetails = playerDetails .. delimiter;
                        end
                    end
                end -- Rep
                if GRM.S().exportFilters.rep and GRM_G.BuildVersion >= 40000 then
                    playerDetails = playerDetails .. GRM.GetReputationTextLevel(roster[i].guildRep, false) .. delimiter;
                end
                if GRM.S().exportFilters.note then -- Public Note
                    if roster[i].note ~= nil and roster[i].note ~= "" then
                        playerDetails = playerDetails .. string.gsub(roster[i].note, delimiter, "") .. delimiter;
                    else
                        playerDetails = playerDetails .. delimiter;
                    end
                end
                if GRM.S().exportFilters.oNote then -- Officer Note
                    if GRM.CanViewOfficerNote() and roster[i].officerNote ~= nil and roster[i].officerNote ~= "" then
                        playerDetails = playerDetails .. string.gsub(roster[i].officerNote, delimiter, "") .. delimiter;
                    else
                        playerDetails = playerDetails .. delimiter;
                    end
                end
                if GRM.S().exportFilters.cNote then -- Custom Note
                    if roster[i].customNote[4] ~= "" then
                        playerDetails = playerDetails ..
                                            string.gsub(string.gsub(roster[i].customNote[4], "\n", separator),
                                delimiter, "") .. delimiter;
                    else
                        playerDetails = playerDetails .. delimiter;
                    end
                end
                if GRM.S().exportFilters.mythicScore and GRM_G.BuildVersion >= 80000 then -- Mythic+ Score
                    if roster[i].MythicScore then
                        playerDetails = playerDetails .. roster[i].MythicScore .. delimiter;
                    else
                        playerDetails = playerDetails .. "0" .. delimiter;
                    end
                end
                if GRM.S().exportFilters.faction then -- faction, Alliance or Horde

                    -- Due to old conversion placeholder of -1 was added in a patch.
                    if roster[i].faction == -1 and GRM_G.BuildVersion < 100000 then
                        roster[i].faction = GRM_G.faction;
                    end

                    if roster[i].faction == 0 then
                        playerDetails = playerDetails .. GRM.L("Horde") .. delimiter;
                    elseif roster[i].faction == 1 then
                        playerDetails = playerDetails .. GRM.L("Alliance") .. delimiter;
                    else
                        playerDetails = playerDetails .. GRM.L("Unknown") .. delimiter;
                    end

                end

                if GRM.S().exportFilters.realm then -- Realm Name
                    playerDetails = playerDetails .. string.match ( roster[i].name , "-(.+)" ) .. delimiter;
                end

                if GRM.S().exportFilters.GUID then -- GUID
                    playerDetails = playerDetails .. roster[i].GUID .. delimiter;
                end

                if #playerDetails > 0 then
                    local modifier = 1;

                    if delimiter == "||" or delimiter == "\\t" or delimiter == "::" then
                        modifier = 2;
                    end
                    playerDetails = string.sub(playerDetails, 1, #playerDetails - modifier); -- eliminate the last delimiter
                    if i < num2 then
                        completeString = completeString .. playerDetails .. "\n";
                    else
                        completeString = completeString .. playerDetails; -- Don't need to add the line break at the end.
                    end
                end
            end
        else
            break
        end
    end

    if completeString ~= "" then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HighlightText(0);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:Show();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText(completeString);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();

        C_Timer.After(2, function()
            Export.ExportScrollSliderConfigure(scrollWidth);
        end);
    end
end

-- Method:          Export.DelimiterFix ( string , bool )
-- What it Does:    Replaces any commas with a semicolon
-- Purpose:         To allow comma delimiter in the export details
Export.DelimiterFix = function(entry, isComma)
    local result = "";

    if isComma then
        result = string.gsub(entry, ",", ";"); -- Use semicolon in place of all commas if player is using comma as delimiter
    else
        result = entry;
    end

    return result;
end

-- Method:          Export.BuildExportAnyText ( string )
-- What it Does:    Opens the export window and pastes whatever text this function is fed into there
-- Purpose:         Allow easy copying of various data.
Export.BuildExportAnyText = function(stringToExport)
    local scrollWidth = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:GetWidth() - 3;

    -- Reset the text
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText("");
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSize(scrollWidth, 12); -- Default Size at one line

    if stringToExport ~= "" then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText(stringToExport);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HighlightText(0);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:Show();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();
        C_Timer.After(2, function()
            Export.ExportScrollSliderConfigure(scrollWidth);
        end);
    end
end

----------------------------------
----- EXPORT FRAMAES AND UI ------
----------------------------------

-- Method:          Export.BuildExportLogFrame()
-- What it Does:    Exactly as named... adds the entire guild log from the given guild, parses out the coloring, and makes it easy to copy and paste it
-- Purpose:         To allow players the ability to export their logs to a file somewhere to keep their system from getting too clutters.
Export.BuildExportLogFrame = function()
    local scrollWidth = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:GetWidth() - 3;
    local completeString = "";
    local limit = 0;
    local delimiter = "";
    if GRM.S().exportDelimiter[1] then
        delimiter = GRM.S().exportDelimiter[2];
    end

    -- To be able to use comma as delimiter we will need to substitue something else in place of comma.
    local isComma = false;
    if delimiter == "," then
        isComma = true;
    end

    local num1 = tonumber(GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:GetText());
    local num2 = tonumber(GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:GetText());
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText("");
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSize(scrollWidth, 12); -- Default Size at one line

    local log = GRM_G.fullLogMatch;

    if #log > 0 then

        limit = num2;

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:SetText(GRM.L("Building Log for Export..."));

        local i = num1;
        local newCount = true;
        local j;

        -- Need to find a starting point.
        if i <= limit then
            for k = i, #log do
                if log[k][5] == num1 then
                    j = k;
                    break
                end
            end
        end

        local additionalNotes = false;
        local entry = "";

        while i <= limit do
            newCount = true;
            additionalNotes = false;
            while j <= #log and (log[j][5] == i or log[j][5] == 0) do

                if newCount and j <= #log and log[j][5] ~= 0 then
                    newCount = false;
                    entry = Export.DelimiterFix(log[j][2], isComma);

                    if i == 1 then --
                        if GRM.S().showLineNumbers then

                            if additionalNotes or
                                (not additionalNotes and string.find(entry, GRM.L("Additional Notes:"), 1, true) ~= nil) then -- Don't want to delimit breakup the custom note
                                additionalNotes = true;
                                completeString = completeString .. i .. ") " .. GRM.RemoveStringColoring(entry);
                            else
                                completeString = completeString .. i .. ") " .. GRM.RemoveStringColoring(entry) ..
                                                     delimiter;
                            end
                        else
                            completeString = completeString .. GRM.RemoveStringColoring(entry) .. delimiter;
                        end
                    else
                        if GRM.S().showLineNumbers then

                            if additionalNotes or
                                (not additionalNotes and string.find(entry, GRM.L("Additional Notes:"), 1, true) ~= nil) then -- Don't want to delimit breakup the custom note
                                additionalNotes = true;
                                completeString = completeString .. "\n" .. i .. ") " .. GRM.RemoveStringColoring(entry);
                            else
                                completeString =
                                    completeString .. "\n" .. i .. ") " .. GRM.RemoveStringColoring(entry) .. delimiter;
                            end
                        else
                            completeString = completeString .. "\n" .. GRM.RemoveStringColoring(entry) .. delimiter;
                        end
                    end
                else
                    if log[j][5] ~= 0 then
                        entry = Export.DelimiterFix(log[j][2], isComma);

                        if additionalNotes or
                            (not additionalNotes and string.find(entry, GRM.L("Additional Notes:"), 1, true) ~= nil) then
                            additionalNotes = true;
                            if string.find(entry, GRM.L("Additional Notes:"), 1, true) ~= nil then
                                completeString = completeString .. GRM.RemoveStringColoring(entry) .. delimiter;
                            else
                                completeString = completeString .. GRM.RemoveStringColoring(entry);
                            end
                        else
                            completeString = completeString .. GRM.RemoveStringColoring(entry) .. delimiter;
                        end
                    end
                end
                -- if j == #log or ( log[j+1] ~= nil and log[j+1][5] ~= i ) then
                --     completeString = string.sub ( completeString , 1 , #completeString - 1 );    -- Remove delimiter???
                -- end
                j = j + 1;

            end

            i = i + 1;
        end
    end

    if limit == 0 then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:SetText(GRM.L("The Log is Currently Empty for This Guild"));
    end
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Show();
    if completeString ~= "" then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText(completeString);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HighlightText(0);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:Show();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();
        C_Timer.After(2, function()
            Export.ExportScrollSliderConfigure(scrollWidth);
        end);
    end
end

-- Method:          Export.BuildExportDelimiterDropdownMenu()
-- What it Does:    Builds the dropdown menu values for the delimiters on the export window
-- Purpose:         Allow Delimiter Selection
Export.BuildExportDelimiterDropdownMenu = function()
    local delimiters = {";", "~", ",", "::", "||", "\\t"};
    local buffer = 6;
    local height = 0;

    -- Initiate the buttons holder
    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons =
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons or {};

    for i = 1, #GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons do
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons[i][1]:Hide();
    end

    for i = 1, #delimiters do
        if not GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons[i] then
            local tempButton = CreateFrame("Button", "GRM_DelimiterButton" .. i,
                GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu);
            GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons[i] = {tempButton,
                                                                                    tempButton:CreateFontString(nil,
                "OVERLAY", "GameFontWhiteTiny")}
        end

        local DelimiterButton = GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons[i][1];
        local DelimiterButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons[i][2];
        DelimiterButton:SetWidth(60);
        DelimiterButton:SetHeight(16);
        DelimiterButton:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");

        DelimiterButtonText:SetText("|cffffd600\"|r " .. delimiters[i] .. " |cffffd600\"|r");
        DelimiterButtonText:SetTextColor(0.0, 0.8, 1.0, 1.0);
        DelimiterButtonText:SetWidth(55);
        DelimiterButtonText:SetWordWrap(false);
        DelimiterButtonText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 16);
        DelimiterButtonText:SetPoint("CENTER", DelimiterButton);
        DelimiterButtonText:SetJustifyH("CENTER");

        if i == 1 then
            DelimiterButton:SetPoint("TOP", GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu, 0, -7);
            height = height + DelimiterButton:GetHeight();
        else
            DelimiterButton:SetPoint("TOP", GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons[i - 1][1],
                "BOTTOM", 0, -buffer);
            height = height + DelimiterButton:GetHeight() + buffer;
        end

        DelimiterButton:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                local parsedNumber = tonumber(string.match(self:GetName(), "(%d+)"));

                GRM.S().exportDelimiter[2] = GRM.Trim(string.gsub(
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu.Buttons[parsedNumber][2]:GetText(),
                    "|cffffd600\"|r", ""));

                GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected.GRM_DelimiterDropdownMenuText:SetText(
                    DelimiterButtonText:GetText());
                GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:Hide();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:Show();
            end
        end);
        DelimiterButton:Show();
    end
    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:SetHeight(height + 15);
end

-- Method:          Export.ExportScrollSliderConfigure ( int , float )
-- What it Does:    Used in the building of the xport frame for the log. This sets the slider values.
-- Purpose:         Kept seperate so it can run recrusively on re-checking if necessary.
Export.ExportScrollSliderConfigure = function(scrollWidth)
    local scrollHeight = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:GetHeight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSize(scrollWidth, scrollHeight + 10);
    local scrollMax = (scrollHeight - (GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:GetHeight() - 5)) +
                          GRM_G.FontModifier + 12;
    if scrollMax < 0 then
        scrollMax = 0;
    end
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetMinMaxValues(0, scrollMax);
    -- Mousewheel Scrolling Logic
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:EnableMouseWheel(true);
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:SetScript("OnMouseWheel", function(_, delta)
        local current = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:GetValue();

        if IsShiftKeyDown() and delta > 0 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue(0);
        elseif IsShiftKeyDown() and delta < 0 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue(scrollMax);
        elseif delta < 0 and current < scrollMax then
            if IsControlKeyDown() then
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue(current + 60);
            else
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue(current + 20);
            end
        elseif delta > 0 and current > 1 then
            if IsControlKeyDown() then
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue(current - 60);
            else
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue(current - 20);
            end
        end
    end);
end

-- Method:          Export.ResetExportLogSettingsOnChange()
-- What it Does:    If a filter has been changed on the log settings, and the export window is open, this clears it.
-- Purpose:         Keep the export consistent.
Export.ResetExportLogSettingsOnChange = function()
    if GRM_UI.GRM_ExportLogBorderFrame and GRM_UI.GRM_ExportLogBorderFrame:IsVisible() and GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 1 then

        if #GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:GetText() > 0 then
            GRM.Report ( GRM.L ( "Clearing Log Export. A filter setting has been changed." ) );
        end
        Export.SetExportTabHighlights();
    end
end

local resetEditBox = function()
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText ( "" );
    if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HasFocus() then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:ClearFocus();
    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue ( 0 );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetMinMaxValues ( 0 , 0 );
end
local setInitialValues = function()
    if GRM_G.CounterCap > 0 then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetText ( "1" );

        -- Now, figure out top value
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( GRM_G.CounterCap );
        if GRM_G.CounterCap > GRM_G.ExportCap then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( tostring ( GRM_G.ExportCap ) );
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( tostring ( GRM_G.CounterCap ) );
        end
    else
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetText ( "0" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( "0" );
    end
end

-- method:          Export.SetExportTabHighlights()
-- What it Does:    Locks the selected tab highlighted
-- Purpose:         UX feature
Export.SetExportTabHighlights = function()

    Export.SetExportFilters();

    if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 1 then
        resetEditBox();

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:LockHighlight();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:UnlockHighlight();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:UnlockHighlight();
        if GRM_G.HardcoreActive then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:UnlockHighlight();
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_GuildDataExportFiltersFrame:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame:Show();

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:Hide();

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:Hide();

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Log Entries at a Time" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetText ( GRM.L ( "Select Line Range:" ) );

        if GRM_G.HardcoreActive then
            Export.ExportHardcoreOptions( false );
        end

        GRM_G.CounterCap = #GRM.GetLog();

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText , "BOTTOMLEFT" , 8 , -25 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Entries: {num}" , nil , nil , GRM_G.CounterCap ) );

        setInitialValues();

        Export.SetExportButtonText();

    elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
        Export.ResetExportLevelRange();
        Export.LoadExportMembertab();

    elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
        Export.ResetExportLevelRange();
        Export.LoadExportFormerMembertab();

    elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 then
        Export.LoadExportDeathsTab( true );

    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected.GRM_DelimiterDropdownMenuText:SetText ( GRM.S().exportDelimiter[2] );
end

-- Setting the checkboxes in the export filter
Export.SetExportFilters = function()

    local totalCheckBoxes = 23;

    if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 or GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then

        if GRM.S().exportFilters.name then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1:SetChecked(true);
        end
        if GRM.S().exportFilters.rank then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2:SetChecked(true);
        end
        if GRM.S().exportFilters.level then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3:SetChecked(true);
        end
        if GRM.S().exportFilters.class then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4:SetChecked(true);
        end
        if GRM.S().exportFilters.lastOnline then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5:SetChecked(true);
        end
        if GRM.S().exportFilters.mainAlt then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6:SetChecked(true);
        end
        if GRM.S().exportFilters.joinDate then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7:SetChecked(true);
        end
        if GRM.S().exportFilters.promoteDate then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8:SetChecked(true);
        end
        if GRM.S().exportFilters.bday then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9:SetChecked(true);
        end
        if GRM.S().exportFilters.rep then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:SetChecked(true);
        end
        if GRM.S().exportFilters.note then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11:SetChecked(true);
        end
        if GRM.S().exportFilters.oNote then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12:SetChecked(true);
        end
        if GRM.S().exportFilters.cNote then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13:SetChecked(true);
        end
        if GRM.S().exportFilters.alts then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14:SetChecked(true);
        end
        if GRM.S().exportFilters.race then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15:SetChecked(true);
        end
        if GRM.S().exportFilters.sex then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16:SetChecked(true);
        end
        if GRM.S().exportFilters.MainOrAlt then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17:SetChecked(true);
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Enable();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetTextColor ( 1 , 0.82 , 0 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Enable();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetTextColor ( 1 , 0.82 , 0 );
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Disable();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Disable();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
        end
        if GRM.S().exportFilters.rankHist then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18:SetChecked(true);
        end
        if GRM.S().exportFilters.Realm then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilterRealm:SetChecked(true);
        end
        if GRM.S().exportFilters.GUID then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20:SetChecked(true);
        end
        if GRM.S().specialCharRemoval then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetChecked(true);
        end
        if GRM.S().exportFilters.mythicScore then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:SetChecked(true);
        end
        if GRM.S().exportFilters.faction then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23:SetChecked(true);
        end

        if GRM.S().exportFilters.mainOnly then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:SetChecked ( true );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:SetChecked ( false );
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:SetChecked ( false );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:SetChecked ( true );
        end

        if Export.CheckButtonsAllChecked() then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:SetChecked ( true );
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:SetChecked ( false );
        end

        for i = 1 , totalCheckBoxes do
            if i ~= 19 then
                _G[ "GRM_ExportFilter" .. i ]:Show();
            end
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilterRealm:Show();

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Show();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Show();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:Show();

    else
        for i = 1 , totalCheckBoxes do
            if i ~= 19 then
                _G[ "GRM_ExportFilter" .. i ]:Hide();
            end
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilterRealm:Hide();

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:Hide();
    end
end

-- Method:          Export.CheckButtonsAllChecked()
-- What it Does:    Returns true if all the export member list details check buttons are checked.
-- Purpose:         For the check all or uncheck all button
Export.CheckButtonsAllChecked = function()
    local result = true;

    for x in pairs ( GRM.S().exportFilters ) do
        if not GRM.S().exportFilters[x] then

            if ( x == "rep" and GRM_G.BuildVersion < 40000 ) or ( x == "mythicScore" and GRM_G.BuildVersion < 80000 ) then
                result = true;
            else
                result = false;
                break;
            end

        end
    end

    return result;
end

-- Method:          Export.ProcessExportLevelRange ( buttonFrame , int )
-- What it Does:    Configures the levle range properly based on user input
-- Purpose:         Ensure clean frame building and quality user experience
Export.ProcessExportLevelRange = function( button , buttonNum )

    if buttonNum == 1 then
        local newLevel = button:GetText();
        local box2Level;

        -- Lower Range
        if newLevel and newLevel ~= "" then

            newLevel = tonumber ( newLevel );

            if not ( GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 ) then
                box2Level = GRM.S().ExportLevelRange[2];
            else
                box2Level = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:GetText();
                if not box2Level or ( box2Level == "" ) then
                    box2Level = GRM_G.LvlCap ;
                else
                    box2Level = tonumber ( box2Level );
                end
            end

            if newLevel == 0 then
                newLevel = 1;
            end

            if box2Level == 999 then
                box2Level = GRM_G.LvlCap ;
            end

            -- Lower range cannot be > than higher range, so it will match if you change
            if newLevel > box2Level then
                newLevel = box2Level;
            end
            if not ( GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 ) then
                if newLevel == GRM_G.LvlCap  then
                    GRM.S().ExportLevelRange[1] = 999;
                else
                    GRM.S().ExportLevelRange[1] = newLevel;
                end
            end

            button.tempText = tostring ( newLevel );
            button:SetText ( newLevel );

        end

    elseif buttonNum == 2 then
        -- Upper Range
        local newLevel = button:GetText();
        local box1Level;

        if not newLevel or ( newLevel == "" ) then
            button:SetText ( tostring ( GRM_G.LvlCap  ) ); -- Resets back to 1
            button.tempText = tostring ( GRM_G.LvlCap  );
            if not ( GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 ) then
                GRM.S().ExportLevelRange[2] = 999;
            end
        else
            newLevel = tonumber ( newLevel );
            if not ( GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 ) then
                box1Level = GRM.S().ExportLevelRange[1];
            else
                box1Level = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:GetText();
                if not box1Level or ( box1Level == "" ) then
                    box1Level = 1;
                else
                    box1Level = tonumber ( box1Level );
                end
            end

            if box1Level == 999 then
                box1Level = GRM_G.LvlCap ;
            end

            -- Make sure it is not LESS than
            if box1Level > newLevel then
                newLevel = box1Level;
            end

            if newLevel > GRM_G.LvlCap  then
                newLevel = GRM_G.LvlCap ;
            end

            if not ( GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 ) then
                if newLevel == GRM_G.LvlCap  then
                    GRM.S().ExportLevelRange[2] = 999;
                else
                    GRM.S().ExportLevelRange[2] = newLevel;
                end
            end

            button.tempText = tostring ( newLevel );
            button:SetText ( newLevel );
        end
    end
end

-- Method:          Export.ResetExportLevelRange()
-- What it Does:    Sets the level range to the edit boxes
-- Purpose:         UX
Export.ResetExportLevelRange = function()
    local lower = GRM.S().ExportLevelRange[1];
    local upper = GRM.S().ExportLevelRange[2];
    if upper == 999 then
        upper = GRM_G.LvlCap ;
    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetText( lower );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.tempText = tostring ( lower );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetText( upper );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.tempText = tostring ( upper );
end

-- Method:          Export.LoadExportMembertab()
-- What it Does:    Sets the values of the member tab for export
-- Purpose:         UX
Export.LoadExportMembertab = function()
    resetEditBox();

    -- Highlights
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:LockHighlight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:UnlockHighlight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:UnlockHighlight();

    if GRM_G.HardcoreActive then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:UnlockHighlight();
    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_GuildDataExportFiltersFrame:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Members at a Time" ) );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetText ( GRM.L ( "Select Member Range:" ) );

    if GRM.S().columnHeaders then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetChecked ( true );
    else
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetChecked ( false );
    end

    if GRM.S().specialCharRemoval then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetChecked ( true );
    else
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetChecked ( false );
    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:Show();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:Show();

    if GRM_G.HardcoreActive then
        Export.ExportHardcoreOptions( false );
    end

    GRM_G.CounterCap = Export.CountTotalMembersThatMatch();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText , "BOTTOMLEFT" , 8 , -25 );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Members: {num}" , nil , nil , GRM_G.CounterCap ) );

    setInitialValues();
    Export.SetExportButtonText();

end

-- Method:          Export.LoadExportFormerMembertab()
-- What it Does:    Loads the export details for the mmeber data tab
-- Purpose:         UX
Export.LoadExportFormerMembertab = function()
    resetEditBox();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:LockHighlight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:UnlockHighlight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:UnlockHighlight();
    if GRM_G.HardcoreActive then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:UnlockHighlight();
    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_GuildDataExportFiltersFrame:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();

    if GRM.S().columnHeaders then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetChecked ( true );
    else
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetChecked ( false );
    end

    if GRM.S().specialCharRemoval then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetChecked ( true );
    else
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetChecked ( false );
    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:Show();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:Show();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Former Members at a Time" ) );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetText ( GRM.L ( "Select Member Range:" ) );

    if GRM_G.HardcoreActive then
        Export.ExportHardcoreOptions( false );
    end

    GRM_G.CounterCap = Export.CountTotalMembersThatMatch();
    --
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText , "BOTTOMLEFT" , 8 , -25 );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Former Members: {num}" , nil , nil , GRM_G.CounterCap ) );

    setInitialValues();
    Export.SetExportButtonText();
end

-- Method:          Export.LoadExportDeathsTab ( bool )
-- What it Does:    Builds the Deaths tab frames properly based on settings.
-- Purpose:         UX
Export.LoadExportDeathsTab = function( refreshLevelRange )
    resetEditBox();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Recorded Deaths at a Time" ) );

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:LockHighlight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:UnlockHighlight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:UnlockHighlight();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:UnlockHighlight();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_GuildDataExportFiltersFrame:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();

    if refreshLevelRange then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetText ( 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.tempText = "1";
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetText ( GRM_G.LvlCap  );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.tempText = tostring ( GRM_G.LvlCap  );
    end

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:Show();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:Show();

    if GRM.S().specialCharRemoval then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetChecked ( true );
    else
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetChecked ( false );
    end
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:Show();

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:Hide();
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:Hide();

    Export.ExportHardcoreOptions( true );

    for i = 1 , 4 do
        if GRM.S().exportHardcoreSort == i then
            GRM_UI.GRM_ExportLogBorderFrame["GRM_ExportHardcoreRadial" .. i]:SetChecked( true );
        else
            GRM_UI.GRM_ExportLogBorderFrame["GRM_ExportHardcoreRadial" .. i]:SetChecked( false );
        end
    end

    GRM_G.CounterCap = Export.GetHardcoreDeaths ( true );
    --
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText , "BOTTOMLEFT" , 8 , -25 );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Deaths Recorded: {num}" , nil , nil , GRM_G.CounterCap ) );

    setInitialValues();
    Export.SetExportButtonText();
end

-- Method:          Export.GetHardcoreDeaths( bool )
-- What it Does:    Reports back the integer count number of deaths
-- Purpose:         Useful for counting the number dead
-- NOTE             Set on global GRM_UI table for access from the UI
Export.GetHardcoreDeaths = function( useLevelFilter )

    if not useLevelFilter then
        return GRM.HC.GatherAllDeaths();
    else
        local lower = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:GetText();
        local upper = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:GetText();
        if lower ~= "" then
            lower = tonumber ( lower );
        else
            lower = 1;
        end
        if upper ~= "" then
            upper = tonumber ( upper );
        else
            upper = GRM_G.LvlCap;
        end

        local deaths = GRM.HC.GatherAllDeaths ( { lower , upper } );

        return #deaths , deaths;
    end
end

-- Method:          Export.BuildExportDeaths()
-- What it Does:    Builds the list of names to be exported to the Export Log window
-- Purpose:         Export the hardcore mode death lists...
Export.BuildExportDeaths = function()
    local scrollWidth = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:GetWidth() - 3;
    local completeString = "";
    local delimiter = "";
    local playerDetails = "";
    local name = "";

    if GRM.S().exportDelimiter[1] then
        delimiter = GRM.S().exportDelimiter[2];
    end

    -- Build the arrays to use.
    local deaths = GRM.HC.GetAllDeathsSorted();

    local num1 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:GetText() );
    local num2 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:GetText() );

    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText ( "" );
    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSize ( scrollWidth , 12 );   -- Default Size at one line

    for i = num1 , num2 do
        playerDetails = "";

        if num1 <= #deaths then

            -- Build the string
            -- Name:
            name = deaths[i].name;
            if GRM.S().specialCharRemoval then
                name = GRM.RemoveSpecialCharacters ( name );
            end

            playerDetails = playerDetails .. name .. delimiter;

            -- Level:
            playerDetails = playerDetails .. deaths[i].level .. delimiter;

            -- Level:
            playerDetails = playerDetails .. deaths[i].class .. delimiter;

            -- TimeOfDeath =
            playerDetails = playerDetails .. deaths[i].date .. delimiter;


            if #playerDetails > 0 then
                local modifier = 1;

                if delimiter == "||" or delimiter == "\\t" or delimiter == "::" then
                    modifier = 2;
                end
                playerDetails = string.sub ( playerDetails , 1 , #playerDetails - modifier );  -- eliminate the last delimiter
                if i < num2 then
                    completeString = completeString .. playerDetails .. "\n";
                else
                    completeString = completeString .. playerDetails;               -- Don't need to add the line break at the end.
                end
            end

        else
            break;
        end
    end

    if completeString ~= "" then
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HighlightText ( 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:Show();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText ( completeString );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();

        C_Timer.After ( 2 , function()
            Export.ExportScrollSliderConfigure( scrollWidth );
        end);
    end
end

-- Method:          Export.ExportButtonLogic()
-- What it Does:    Clears focus on the eidt boxes, if any, then builds the export frame
-- Purpose:         UX
Export.ExportButtonLogic = function()

    if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 1 then
        Export.BuildExportLogFrame();
    elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
        Export.BuildExportMemberDetails ( true );
    elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
        Export.BuildExportMemberDetails ( false );
    elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 then
        Export.BuildExportDeaths();
    end

end

-- Method:          Export.CountTotalMembersThatMatch()
-- What it Does:    Returns the number of people that match for export
-- Purpose:         Great controls for export.
Export.CountTotalMembersThatMatch = function()
    local mainOnly , altOnly = false , false;
    local count = 0;

    if GRM.S().exportFilters.MainOrAlt then
        mainOnly = GRM.S().exportFilters.mainOnly;

        if not GRM.S().exportFilters.mainOnly then
            altOnly = true;
        end
    end

    -- Validates if it should be added to the string based on the conditions
    local isValid = function ( player )
        local result = true;
        local isMain = false;

        if GRM.S().exportFilters.MainOrAlt then

            if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
                isMain = GRM.IsMain ( player.name );

            elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
                isMain = GRM.IsFormerMemberMain ( player );
            end

            if mainOnly and not isMain then
                result = false;

            elseif altOnly then

                local isAlt = false;

                if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
                    isAlt = GRM.PlayerIsAnAlt ( player );
                elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
                    isAlt = GRM.IsFormerMemberAnAlt ( player );
                end

                if isMain or ( not isMain and not isAlt ) then
                    result = false;
                end
            end

        end

        if player.level < GRM.S().ExportLevelRange[1] or player.level > GRM.S().ExportLevelRange[2] then
            result = false;
        end

        return result;
    end

    local guildData = {};
    if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
        guildData = GRM.GetGuild();
    elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
        guildData = GRM.GetFormerMembers();
    end

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if isValid ( player ) then
                count = count + 1;
            end
        end
    end

    return count;
end

-- Method:              Export.ExportRangeEditBox1 ( frame )
-- What it Does:        Configures the Export values of the edit boxes
-- Purpose:             UX
Export.ExportRangeEditBox1 = function( editBox )
    local num1 = tonumber ( editBox:GetText() );
    local num2 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:GetText() );

    if GRM_G.CounterCap > 0 then

        if num1 == nil or num1 == 0 then
            num1 = 1;
            editBox:SetText ( "1" );
        end
            -- Number is too high.
        if num1 > GRM_G.CounterCap then
            editBox:SetText ( tostring ( GRM_G.CounterCap ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( tostring ( GRM_G.CounterCap ) );
            num1 = GRM_G.CounterCap;

            -- Box 1 > box 2
        elseif num1 > num2 then
            if ( num1 + GRM_G.ExportCap - 1 ) > GRM_G.CounterCap then
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( tostring ( GRM_G.CounterCap ) );
                num2 = GRM_G.CounterCap;
            else
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( tostring ( num1 + GRM_G.ExportCap - 1 ) );
                num2 = ( num1 + GRM_G.ExportCap - 1 );
            end
        end

        if num1 < num2 and ( ( num2 - ( GRM_G.ExportCap - 1 ) ) > num1 ) then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( tostring ( num1 + GRM_G.ExportCap - 1 ) );
        end

    else
        editBox:SetText ( "0" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( "0" );
    end

    Export.SetExportButtonText();
end

-- Method:              Export.ExportRangeEditBox2 ( frame )
-- What it Does:        Configures the Export values of the edit boxes
-- Purpose:             UX
Export.ExportRangeEditBox2 = function( editBox )
    local num1 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:GetText() );
    local num2 = tonumber ( editBox:GetText() );

    if GRM_G.CounterCap > 0 then

        if num2 == nil then
            if num1 + GRM_G.ExportCap - 1 > GRM_G.CounterCap then
                editBox:SetText ( GRM_G.CounterCap );
                num2 = GRM_G.CounterCap;
            else
                editBox:SetText ( tostring ( num1 + GRM_G.ExportCap - 1 ) );
                num2 = ( num1 + GRM_G.ExportCap - 1 );
            end
        elseif num2 == 0 then
            num2 = 1;
        end

            -- Entered # is too high
        if num2 > GRM_G.CounterCap then
            editBox:SetText ( tostring ( GRM_G.CounterCap ) );
            num2 = GRM_G.CounterCap;

            -- need to reset number 1 box now
        elseif num2 < num1 then
            if ( num2 - GRM_G.ExportCap - 1 ) < 0 then
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetText ( "1" );
                num1 = 1;
            else
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetText ( tostring ( num2 - GRM_G.ExportCap - 1 ) );
                num1 = ( num2 - GRM_G.ExportCap - 1 );
            end
        end

        --Check if the gap isn't too big.
        if num1 < num2 and ( ( num2 - ( GRM_G.ExportCap - 1 ) ) > num1 ) then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetText ( tostring ( num2 - ( GRM_G.ExportCap - 1 ) ) );
        end

    else
        editBox:SetText ( "0" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetText ( "0" );
    end

    Export.SetExportButtonText();
end

-- Method:          Export.SetExportButtonText()
-- What it Does:    Builds dynamic text explanations for the export buttons on the fly
-- Purpose:         UX
Export.SetExportButtonText = function()

    if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:IsVisible() then
        local num1 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:GetText() );
        local num2 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:GetText() );
        -- Set Initial Text values

        -- Previous
        if num1 ~= nil then
            if num1 < 2 then
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButtonText:SetText ( GRM.L ( "Export Prev {num}" , nil , nil , "0" ) );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton:Disable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton.Value = 0;
            else
                -- We know num1 > 1
                if ( num1 - GRM_G.ExportCap ) >= 1 then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButtonText:SetText ( GRM.L ( "Export Prev {num}" , nil , nil , GRM_G.ExportCap ) );
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton.Value = GRM_G.ExportCap;
                else
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButtonText:SetText ( GRM.L ( "Export Prev {num}" , nil , nil , ( num1 - 1 ) ) );
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton.Value = ( num1 - 1 )
                end

                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton:Enable();
            end
        end

        -- Next
        if num2 ~= nil then
            if GRM_G.CounterCap > num2 then

                if ( num2 + ( GRM_G.ExportCap - 1 ) ) <= GRM_G.CounterCap then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButtonText:SetText ( GRM.L ( "Export Next {num}" , nil , nil , GRM_G.ExportCap ) );
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton.Value = GRM_G.ExportCap;
                else
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButtonText:SetText ( GRM.L ( "Export Next {num}" , nil , nil , ( GRM_G.CounterCap - num2 ) ) );
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton.Value = ( GRM_G.CounterCap - num2 );
                end
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton:Enable();
            else
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButtonText:SetText ( GRM.L ( "Export Next {num}" , nil , nil , "0" ) );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton:Disable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton.Value = 0;
            end
        end
    end

end

--------------------------
---- ON DEMAND FRAMES ----
--------------------------

-- Method:          Export.LoadExportUI( bool )
-- What it Does:    Controls load of Export frames
-- Purpose:         Load only on-demand.
Export.LoadExportUI = function( isManualUpdate )

    -- Build the core unconfiguired frames
    if not GRM_UI.GRM_ExportLogBorderFrame then
        -- LOG EXPORT AND TOOLS
        GRM_UI.GRM_ExportLogBorderFrame = CreateFrame ( "Frame" , "GRM_ExportLogBorderFrame" , UIParent , "TranslucentFrameTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame = CreateFrame ( "Frame" , "GRM_ExportLogScrollBorderFrame" , GRM_UI.GRM_ExportLogBorderFrame , "TranslucentFrameTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_BorderFrameCloseButton = CreateFrame ( "Button" , "GRM_BorderFrameCloseButton" , GRM_UI.GRM_ExportLogBorderFrame , "UIPanelCloseButton" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox = CreateFrame ( "EditBox" , "GRM_ExportLogFrameEditBox" , GRM_UI.GRM_ExportLogBorderFrame );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterText = GRM_UI.GRM_ExportLogBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        -- SCROLL FRAME
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame = CreateFrame ( "ScrollFrame" , "GRM_ExportLogScrollFrame" , GRM_UI.GRM_ExportLogBorderFrame );
        -- CONTENT FRAME (Child Frame)
        -- SLIDER
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider = CreateFrame ( "Slider" , "GRM_ExportLogScrollFrameSlider" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame , "UIPanelScrollBarTrimTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        -- Export Frame tabs
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab = CreateFrame ( "Button" , "GRM_ExportLogTab" , GRM_UI.GRM_ExportLogBorderFrame , "MinimalTabTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTabText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportLogText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab = CreateFrame ( "Button" , "GRM_ExportGuildDataTab" , GRM_UI.GRM_ExportLogBorderFrame , "MinimalTabTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTabText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab = CreateFrame ( "Button" , "GRM_ExportLeftGuildDataTab" , GRM_UI.GRM_ExportLogBorderFrame , "MinimalTabTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTabText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab = CreateFrame ( "Button" , "GRM_ExportDeathsTab" , GRM_UI.GRM_ExportLogBorderFrame , "MinimalTabTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTabText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        --Export controls Text
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportDataHeaderText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:CreateFontString ( nil , "OVERLAY" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:CreateFontString ( nil , "OVERLAY" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_GuildDataExportFiltersFrame = CreateFrame( "Frame" , "GRM_GuildDataExportFiltersFrame" , GRM_UI.GRM_ExportLogBorderFrame );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame = CreateFrame( "Frame" , "GRM_LogExportFiltersFrame" , GRM_UI.GRM_ExportLogBorderFrame );

        -- GENERIC EXPORT
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1 = CreateFrame ( "EditBox" , "GRM_ExportRangeEditBox1" , GRM_UI.GRM_ExportLogBorderFrame , "InputBoxTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2 = CreateFrame ( "EditBox" , "GRM_ExportRangeEditBox2" , GRM_UI.GRM_ExportLogBorderFrame , "InputBoxTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1 = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2.GRM_ExportRangeText2 = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        -- Export Level Range
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1 = CreateFrame ( "EditBox" , "GRM_ExportLevelRangeEditBox1" , GRM_UI.GRM_ExportLogBorderFrame , "InputBoxTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2 = CreateFrame ( "EditBox" , "GRM_ExportLevelRangeEditBox2" , GRM_UI.GRM_ExportLogBorderFrame , "InputBoxTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.GRM_ExportLevelRangeText1 = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.GRM_ExportLevelRangeText2 = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton = CreateFrame ( "Button" , "GRM_ExportSelectedRangeButton" , GRM_UI.GRM_ExportLogBorderFrame , "UIPanelButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton = CreateFrame ( "Button" , "GRM_ExportNextRangeButton" , GRM_UI.GRM_ExportLogBorderFrame , "UIPanelButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton = CreateFrame ( "Button" , "GRM_ExportPreviousRangeButton" , GRM_UI.GRM_ExportLogBorderFrame , "UIPanelButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton = CreateFrame ( "Button" , "GRM_ExportMemberDetailsHeadersButton" , GRM_UI.GRM_ExportLogBorderFrame , "UIPanelButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        -- LOG EXPORT
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText = GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        -- EXPORT CHECKBUTTONS
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton = CreateFrame ( "CheckButton" , "GRM_ExportAutoIncludeHeadersCheckButton" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton.GRM_ExportAutoIncludeHeadersCheckButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1 = CreateFrame ( "CheckButton" , "GRM_ExportFilter1" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1.GRM_ExportFilter1Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2 = CreateFrame ( "CheckButton" , "GRM_ExportFilter2" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2.GRM_ExportFilter2Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3 = CreateFrame ( "CheckButton" , "GRM_ExportFilter3" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3.GRM_ExportFilter3Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4 = CreateFrame ( "CheckButton" , "GRM_ExportFilter4" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4.GRM_ExportFilter4Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5 = CreateFrame ( "CheckButton" , "GRM_ExportFilter5" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5.GRM_ExportFilter5Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6 = CreateFrame ( "CheckButton" , "GRM_ExportFilter6" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6.GRM_ExportFilter6Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7 = CreateFrame ( "CheckButton" , "GRM_ExportFilter7" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7.GRM_ExportFilter7Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8 = CreateFrame ( "CheckButton" , "GRM_ExportFilter8" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8.GRM_ExportFilter8Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9 = CreateFrame ( "CheckButton" , "GRM_ExportFilter9" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9.GRM_ExportFilter9Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10 = CreateFrame ( "CheckButton" , "GRM_ExportFilter10" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2 = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11 = CreateFrame ( "CheckButton" , "GRM_ExportFilter11" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12 = CreateFrame ( "CheckButton" , "GRM_ExportFilter12" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13 = CreateFrame ( "CheckButton" , "GRM_ExportFilter13" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14 = CreateFrame ( "CheckButton" , "GRM_ExportFilter14" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14.GRM_ExportFilter14Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15 = CreateFrame ( "CheckButton" , "GRM_ExportFilter15" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15.GRM_ExportFilter15Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16 = CreateFrame ( "CheckButton" , "GRM_ExportFilter16" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16.GRM_ExportFilter16Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17 = CreateFrame ( "CheckButton" , "GRM_ExportFilter17" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1 = CreateFrame ( "CheckButton" , "GRM_ExportFilter17_Radial1" , GRM_UI.GRM_ExportLogBorderFrame , "UIRadioButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2 = CreateFrame ( "CheckButton" , "GRM_ExportFilter17_Radial2" , GRM_UI.GRM_ExportLogBorderFrame , "UIRadioButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton = CreateFrame ( "CheckButton" , "GRM_ExportSelectAllButton" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18 = CreateFrame ( "CheckButton" , "GRM_ExportFilter18" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18.GRM_ExportFilter18Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20 = CreateFrame ( "CheckButton" , "GRM_ExportFilter20" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21 = CreateFrame ( "CheckButton" , "GRM_ExportFilter21" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21.GRM_ExportFilter21Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22 = CreateFrame ( "CheckButton" , "GRM_ExportFilter22" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2 = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23 = CreateFrame ( "CheckButton" , "GRM_ExportFilter23" , GRM_UI.GRM_ExportLogBorderFrame , "InterfaceOptionsCheckButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        -- Delimiter Dropdown for Export
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected = CreateFrame ( "Frame" , "GRM_DelimiterDropdownMenuSelected" , GRM_UI.GRM_ExportLogBorderFrame , "InsetFrameTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected.GRM_DelimiterDropdownMenuText = GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu = CreateFrame ( "Frame" , "GRM_DelimiterDropdownMenu" , GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected , "InsetFrameTemplate" );

        -- Export Reset Defaults Button
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton = CreateFrame ( "Button" , "GRM_ExportResetOptionsButton" , GRM_UI.GRM_ExportLogBorderFrame , "UIPanelButtonTemplate" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButtonText = GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        --------------------------
        -- FRAME CONFIGURATIONS --
        --------------------------

        GRM_UI.GRM_ExportLogBorderFrame:ClearAllPoints();
        GRM_UI.GRM_ExportLogBorderFrame:SetPoint ( "CENTER" , UIParent );
        GRM_UI.GRM_ExportLogBorderFrame:SetSize ( 1100 , 540 );
        GRM_UI.GRM_ExportLogBorderFrame:SetToplevel ( true );
        GRM_UI.GRM_ExportLogBorderFrame:SetMovable ( true );
        GRM_UI.GRM_ExportLogBorderFrame:EnableMouse ( true );
        GRM_UI.GRM_ExportLogBorderFrame:RegisterForDrag ( "LeftButton" );
        GRM_UI.GRM_ExportLogBorderFrame:SetScript ( "OnDragStart" , GRM_UI.GRM_ExportLogBorderFrame.StartMoving );
        GRM_UI.GRM_ExportLogBorderFrame:SetScript ( "OnDragStop" , GRM_UI.GRM_ExportLogBorderFrame.StopMovingOrSizing );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_BorderFrameCloseButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ExportLogBorderFrame , "TOPRIGHT" , 2, 1 );
        GRM_UI.GRM_ExportLogBorderFrame.TabPosition = 1;

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton:SetPoint ( "BOTTOMRIGHT" , GRM_UI.GRM_ExportLogBorderFrame , "BOTTOMRIGHT" , -35 , 15 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton:SetSize ( 130 , 30 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButtonText:SetWordWrap ( true );
        GRM_UI.ScaleFontStringToObjectSize ( true , 130 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButtonText , 2 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton:SetScript ( "OnClick" , function( _ , button )
            if button == "LeftButton" then
                GRM.ResetDefaultSettings( 9 );
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton:SetScript ( "OnEnter" , function ( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "Resets only the Export Settings" ) );
            GameTooltip:AddLine( "|CFFE6CC7F" .. GRM.L ( "Ctrl-Shift-Click" ) .. "|r - " .. GRM.L ( "Resets ALL settings, not just the ones on this page" ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButton:SetScript ( "OnLeave" , function ()
            GRM.RestoreTooltip()
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame:SetSize ( 550 , 350 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_ExportLogBorderFrame , "TOPRIGHT" , -35 , -50 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_BorderFrameCloseButton:SetWidth ( 30 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportLogText:SetPoint ( "TOP" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame , 0 , 15 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:Hide();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSize ( 527 , 321 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetAutoFocus ( false );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:ClearFocus();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetMultiLine ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:EnableMouse ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetFontObject ( "GameFontWhiteTiny" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetSpacing ( 2 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetTextInsets ( 2 , 3 , 3 , 2 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:SetScrollChild ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox );
        -- Slider Parameters
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:SetSize ( 532 , 326 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:SetPoint (  "Bottom" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame , "BOTTOM" , 3 , 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:SetHitRectInsets ( 0 , -30 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetOrientation ( "VERTICAL" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetSize ( 20 , 307 )
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame , "TOPRIGHT" , -5 , -22 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue ( 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValueStep ( 20 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetStepsPerPage ( 14 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetScript ( "OnValueChanged" , function ( self )
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrame:SetVerticalScroll ( self:GetValue() );
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:SetSize ( 120 , 25 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:SetHighlightTexture ( "Interface\\Buttons\\ButtonHilight-Square" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame , "TOPLEFT" , 25 , - 48 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTabText:SetWidth ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:GetWidth() - 5 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:SetSize ( 120 , 25 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:SetHighlightTexture ( "Interface\\Buttons\\ButtonHilight-Square" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab , "RIGHT" , 1 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTabText:SetWidth ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:GetWidth() - 5 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:SetSize ( 120 , 25 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:SetHighlightTexture ( "Interface\\Buttons\\ButtonHilight-Square" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab , "RIGHT" , 1 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTabText:SetWidth ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:GetWidth() - 5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTabText:SetWordWrap ( true );

        if GRM_G.HardcoreActive then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:SetSize ( 120 , 25 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:SetHighlightTexture ( "Interface\\Buttons\\ButtonHilight-Square" );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab , "RIGHT" , 1 , 0 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTabText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTabText:SetWidth ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:GetWidth() - 5 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTabText:SetWordWrap ( true );
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:Hide()
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_GuildDataExportFiltersFrame:SetSize ( 362 , 315 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_GuildDataExportFiltersFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame:SetSize ( 362 , 315 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab , "BOTTOMLEFT" , 0 , -5 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportDataHeaderText:SetPoint ( "BOTTOM" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab , "TOP" , 0 , 8 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportDataHeaderText:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab , "BOTTOMLEFT" , 1 , -7 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetTextColor ( 1 , 0 , 0 , 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetWidth ( 350 )
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetSpacing ( 1 );

        -- Export Log Filters and Details
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText:SetTextColor ( 1 , 0 , 0 , 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText:SetWidth ( 350 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText:SetSpacing ( 1 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText , "BOTTOMLEFT" , 1 , -10 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2.GRM_ExportRangeText2:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1 , "RIGHT" , 8 , 0 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.GRM_ExportLevelRangeText1:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected , "RIGHT" , 30 , 0 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.GRM_ExportLevelRangeText2:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1 , "RIGHT" , 8 , 0 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetWidth ( 180 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetJustifyH ( "LEFT" );

        -- Delimiter Dropdown Menu
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterText:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterText:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton , "BOTTOMLEFT" , 10 , -25 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:SetSize ( 60 , 30 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterText , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:SetFrameStrata ( "DIALOG" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:SetPoint ( "TOP" , GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected , "BOTTOM" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:SetWidth ( 60 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:SetFrameStrata ( "DIALOG" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected.GRM_DelimiterDropdownMenuText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected.GRM_DelimiterDropdownMenuText:SetTextColor ( 0.0 , 0.8 , 1.0 , 1.0 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "The selected delimiter will be removed from all notes on export" ) );
            GameTooltip:AddLine ( GRM.L ( "Choose thoughtfully" ) );
            GameTooltip:AddLine( GRM.L ( "Feel free to recommend a delimiter you wish to use to the author" ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip()
        end);


        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:SetScript ( "OnKeyDown" , function ( self , key )
            if not GRM_G.inCombat then
                self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
                if key == "ESCAPE" then
                    self:SetPropagateKeyboardInput ( false );
                    self:Hide();
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:Show();
                end
            elseif key == "ESCAPE" then
                self:Hide();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:Show();
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:SetScript ( "OnShow" , function()
            GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:Hide();
        end)

        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected:SetScript ( "OnMouseDown" , function( _ , button )
            if button == "LeftButton" then
                if  GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:IsVisible() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:Hide();
                else
                    Export.BuildExportDelimiterDropdownMenu();
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:Show();
                end
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenu:SetScript ( "OnShow" , function()
            if GameTooltip:IsVisible() then
                GRM.RestoreTooltip();
            end
        end);

        --Generic buttons
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1 , "BOTTOMLEFT" , -2 , -10 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton:SetSize ( 140 , 40 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:ClearFocus();
                elseif GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:ClearFocus();
                elseif GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:ClearFocus();
                elseif GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:ClearFocus();
                end
                Export.ExportButtonLogic();
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton:SetSize ( 140 , 40 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton.Value = 0;
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                -- Make sure focus is cleared...
                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:ClearFocus();
                end
                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:ClearFocus();
                end

                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButton:IsEnabled() then

                    -- Setting button value logic.
                    local num2 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:GetText() );
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetText ( num2 + 1 );

                    -- Trigger a 2nd time to auto-set the logic on the numbering
                    Export.ExportRangeEditBox1( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1 );

                    -- the final log export.
                    Export.ExportButtonLogic();
                end
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton:SetSize ( 140 , 40 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton.Value = 0;
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then

                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:ClearFocus();
                end
                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:HasFocus() then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:ClearFocus();
                end

                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButton:IsEnabled() then

                    -- Setting button value logic.
                    local num1 = tonumber ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:GetText() );
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetText ( num1 - 1 );

                    -- Trigger a 2nd time to auto-set the logic on the numbering
                    Export.ExportRangeEditBox2( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2 );

                    -- the final log export.
                    Export.ExportButtonLogic();
                end

            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollBorderFrame , "BOTTOMLEFT" , 5 , -5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:SetSize ( 175 , 30 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                Export.ExportMemberDetailsHeaders( false );
            end
        end);
        GRM_UI.ScaleFontStringToObjectSize ( true , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton:GetWidth() , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButtonText , 2 );

        -- EXPORT CHECKBUTTONS
        -- 15 of them so far!
        -------------------------

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButton , "RIGHT" , 5 , 10 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21.GRM_ExportFilter21Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21 , "RIGHT" , 2 , 0 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21.GRM_ExportFilter21Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().specialCharRemoval = true;
            else
                GRM.S().specialCharRemoval = false;
            end

            if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 then
                local num = GRM.S().exportHardcoreSort;
                GRM_UI.HardcoreExportSave ( num );
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21 , "BOTTOMLEFT" , 0 , -1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton.GRM_ExportAutoIncludeHeadersCheckButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().columnHeaders = true;
            else
                GRM.S().columnHeaders = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "These will only be included if exporting from the top of the table" ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text:SetWidth ( 105 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text:SetSpacing ( 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text:SetWordWrap ( true );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.mythicScore = true;
            else
                GRM.S().exportFilters.mythicScore = false;
            end
        end);

        if GRM_G.BuildVersion < 80000 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:Disable();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetPoint ( "TOP" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text , "BOTTOM" , 0 , -1 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetWidth ( 105 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetJustifyH ( "LEFT" );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetSpacing ( 1 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetWordWrap ( false );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetTextColor ( 1 , 0 , 0 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:Show();
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:Hide();
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text:SetWidth ( 105 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text:SetSpacing ( 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text:SetWordWrap ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.faction = true;
            else
                GRM.S().exportFilters.faction = false;
            end
        end);

        GRM_UI.ExportFilterRealm = function ( button )
            if button:GetChecked() then
                GRM.S().exportFilters.realm = true;
            else
                GRM.S().exportFilters.realm = false;
            end
        end

        GRM_UI.CreateCheckBox ( "GRM_ExportFilterRealm" , GRM_UI.GRM_ExportLogBorderFrame , nil , nil , { "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23 , "BOTTOMLEFT" , 0 , -4 } , GRM_UI.ExportFilterRealm , GRM.L ( "Realm Name" ) , "GameFontNormal" , 12 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilterRealm , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text:SetWidth ( 105 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text:SetSpacing ( 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text:SetWordWrap ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.GUID = true;
            else
                GRM.S().exportFilters.GUID = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton , "BOTTOMLEFT" , 0 , -60 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1.GRM_ExportFilter1Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1 , "RIGHT" , 2 , 0 );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.name = true;
            else
                GRM.S().exportFilters.name = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2.GRM_ExportFilter2Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.rank = true;
            else
                GRM.S().exportFilters.rank = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3.GRM_ExportFilter3Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.level = true;
            else
                GRM.S().exportFilters.level = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4.GRM_ExportFilter4Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.class = true;
            else
                GRM.S().exportFilters.class = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15.GRM_ExportFilter15Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.race = true;
            else
                GRM.S().exportFilters.race = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16.GRM_ExportFilter16Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.sex = true;
            else
                GRM.S().exportFilters.sex = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5.GRM_ExportFilter5Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.lastOnline = true;
            else
                GRM.S().exportFilters.lastOnline = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "This will be rounded to the nearest day" ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip()
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1 , "RIGHT" , 125 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6.GRM_ExportFilter6Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.mainAlt = true;
            else
                GRM.S().exportFilters.mainAlt = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7.GRM_ExportFilter7Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.joinDate = true;
            else
                GRM.S().exportFilters.joinDate = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8.GRM_ExportFilter8Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.promoteDate = true;
            else
                GRM.S().exportFilters.promoteDate = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18.GRM_ExportFilter18Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.rankHist = true;
            else
                GRM.S().exportFilters.rankHist = false;
            end
            if GameTooltip:IsVisible() then
                GRM.RestoreTooltip();
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "Only the 10 most recent rank changes will be included" ) );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip()
        end);


        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9.GRM_ExportFilter9Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.bday = true;
            else
                GRM.S().exportFilters.bday = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.rep = true;
            else
                GRM.S().exportFilters.rep = false;
            end
        end);

        if GRM_G.BuildVersion < 40000 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:Disable();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text , "BOTTOMLEFT" , 0 , -1 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetWidth ( 105 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetJustifyH ( "LEFT" );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetSpacing ( 1 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetWordWrap ( false );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetTextColor ( 1 , 0 , 0 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:Show();
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:Hide();
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6 , "RIGHT" , 125 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text:SetWidth ( 105 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text:SetSpacing ( 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text:SetWordWrap ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.note = true;
            else
                GRM.S().exportFilters.note = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text:SetWidth ( 105 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text:SetSpacing ( 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text:SetWordWrap ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.oNote = true;
            else
                GRM.S().exportFilters.oNote = false;
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:SetWidth ( 105 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:SetJustifyH ( "LEFT" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:SetSpacing ( 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:SetWordWrap ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.cNote = true;
            else
                GRM.S().exportFilters.cNote = false;
            end
        end);

        if GRM_G.LocalizedIndex == 5 then -- Russian
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13:SetScript ( "OnEnter" , function( self )
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:GetText() );
                GameTooltip:Show();
            end);
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13:SetScript ( "OnLeave" , function()
                GRM.RestoreTooltip()
            end);
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14:SetHitRectInsets( 0 , -75 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14.GRM_ExportFilter14Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.alts = true;
            else
                GRM.S().exportFilters.alts = false;
            end
        end);

        Export.ConfigureTotalMembers = function()
            if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
                Export.LoadExportMembertab();
            elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
                Export.LoadExportFormerMembertab();
            end
        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20 , "BOTTOMLEFT" , 0 , -4 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17:SetHitRectInsets( 0 , 0 , 0 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.MainOrAlt = true;
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Enable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Enable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetTextColor ( 1 , 0.82 , 0 );
            else
                GRM.S().exportFilters.MainOrAlt = false;
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Disable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Disable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
            end
            if GameTooltip:IsVisible() then
                GRM.RestoreTooltip();
            end

            Export.ConfigureTotalMembers();

        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM.L ( "Leave unchecked to export every member of the guild" ) );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip()
        end)

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17 , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.mainOnly = true;
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:SetChecked ( false );
            else
                self:SetChecked ( true );
            end
            Export.ConfigureTotalMembers();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1 , "BOTTOMLEFT" , 0 , -2 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2 , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:SetScript ( "OnClick", function( self )
            if self:GetChecked() then
                GRM.S().exportFilters.mainOnly = false;
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:SetChecked ( false );
            else
                self:SetChecked ( true );
            end
            Export.ConfigureTotalMembers();
        end);

        -- HARDCORE
        if GRM_G.HardcoreActive then

            GRM_UI.CreateString ( "GRM_ExportHardcoreSortText" , GRM_UI.GRM_ExportLogBorderFrame , "GameFontNormal" , GRM.L ( "Sort Deaths:" ) , 16 , { "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButton ,"BOTTOMLEFT" , 10 , -60 } );

            GRM_UI.HardcoreExportSave = function ( buttonNum )
                GRM.S().exportHardcoreSort = buttonNum;

                if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:GetText() ~= "" then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetText ( "" );
                    if GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:HasFocus() then
                        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:ClearFocus();
                    end

                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetValue ( 0 );
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogScrollFrameSlider:SetMinMaxValues ( 0 , 0 );
                    Export.BuildExportDeaths();
                end

            end

            GRM_UI.CreateRadialButtons ( "GRM_ExportHardcore" , GRM_UI.GRM_ExportLogBorderFrame , nil , { GRM.L ( "Name" ) , GRM.L ( "Level" ) , GRM.L ( "Class" ) , GRM.L ( "Time of Death" ) } , { "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportHardcoreSortText , "BOTTOMLEFT" , 0 , -5 } , true , true , 12 , nil , GRM_UI.HardcoreExportSave )

            -- Method:          Export.ExportHardcoreOptions( bool )
            -- What it Does:    Controls logic of showing this 4th tab or not, based on if in HC mode
            -- Purpose:         UX but exclusively for Classic HC
            Export.ExportHardcoreOptions = function( toShow )
                if toShow then
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportHardcoreSortText:Show();
                    for i = 1 , 4 do
                        GRM_UI.GRM_ExportLogBorderFrame["GRM_ExportHardcoreRadial" .. i]:Show();
                    end
                else
                    GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportHardcoreSortText:Hide();
                    for i = 1 , 4 do
                        GRM_UI.GRM_ExportLogBorderFrame["GRM_ExportHardcoreRadial" .. i]:Hide();
                    end
                end
            end

        end

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:SetPoint ( "TOPLEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5 , "BOTTOMLEFT" , 0 , -5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton , "RIGHT" , 2 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetTextColor ( 0 , 0.8 , 1 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetWidth ( 100 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetWordWrap ( false );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetSpacing ( 0.5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetJustifyH ( "LEFT" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:SetScript ( "OnClick" , function ( self )
            if self:GetChecked() then

                -- check all
                -- Setting values to be true
                for x in pairs ( GRM.S().exportFilters ) do

                    if x == "rep" then
                        if GRM_G.BuildVersion >= 40000 then
                            GRM.S().exportFilters.rep = true;
                            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:SetChecked ( true );
                        else
                            GRM.S().exportFilters.rep = false;
                            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10:SetChecked ( false );
                        end
                    elseif x == "mythicScore" then
                        if GRM_G.BuildVersion >= 80000 then
                            GRM.S().exportFilters.mythicScore = true;
                            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:SetChecked ( true );
                        else
                            GRM.S().exportFilters.mythicScore = false;
                            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22:SetChecked ( false );
                        end
                    else
                        GRM.S().exportFilters[x] = true;
                    end

                end

                -- Checking UI buttons
                for i = 1 , 23 do
                    if i ~= 19 and i ~= 21 then

                        if ( ( i ~= 10 and i ~= 22 ) or ( i == 10 and GRM_G.BuildVersion >= 40000 ) or ( i == 22 and GRM_G.BuildVersion >= 80000 ) ) then
                            _G[ "GRM_ExportFilter" .. i ]:SetChecked ( true );
                        end
                    end
                end

                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilterRealm:SetChecked ( true );

                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Enable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetTextColor ( 1 , 0.82 , 0 );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Enable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetTextColor ( 1 , 0.82 , 0 );

            else

                -- check all
                -- Setting values to be true
                for x in pairs ( GRM.S().exportFilters ) do
                    GRM.S().exportFilters[x] = false;
                end

                -- Checking UI buttons
                for i = 1 , 23 do
                    if i ~= 19 and i ~= 21 then
                        _G[ "GRM_ExportFilter" .. i ]:SetChecked ( false );
                    end
                end

                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilterRealm:SetChecked ( false );

                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1:Disable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2:Disable();
                GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetTextColor ( 0.5 , 0.5 , 0.5 );
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:GetText() );
            GameTooltip:Show();
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip()
        end);

        GRM_UI.GRM_ExportLogBorderFrame:SetScript ( "OnKeyDown" , function ( self , key )
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

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                if GRM_UI.GRM_ExportLogBorderFrame.TabPosition ~= 1 then
                    GRM_UI.GRM_ExportLogBorderFrame.TabPosition = 1;
                    Export.SetExportTabHighlights();
                end
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTab:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                if GRM_UI.GRM_ExportLogBorderFrame.TabPosition ~= 2 then
                    GRM_UI.GRM_ExportLogBorderFrame.TabPosition = 2;
                    Export.SetExportTabHighlights();
                end
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTab:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                if GRM_UI.GRM_ExportLogBorderFrame.TabPosition ~= 3 then
                    GRM_UI.GRM_ExportLogBorderFrame.TabPosition = 3;
                    Export.SetExportTabHighlights();
                end
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTab:SetScript ( "OnClick" , function ( _ , button )
            if button == "LeftButton" then
                if GRM_UI.GRM_ExportLogBorderFrame.TabPosition ~= 4 then
                    GRM_UI.GRM_ExportLogBorderFrame.TabPosition = 4;
                    Export.SetExportTabHighlightsWW();
                end
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetScript ( "OnEscapePressed" , function ( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetScript ( "OnEnterPressed" , function ( self )
            self:ClearFocus();
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText( 0 );
        end);
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogFrameEditBox:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText( 0 , 0 );
        end);

        GRM_UI.GRM_ExportLogBorderFrame:SetScript ( "OnShow" , Export.SetExportTabHighlights );

        -- Extra Log Options Editboxes
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetSize ( 65 , 18 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1 , "RIGHT" , 12 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetNumeric ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetMaxLetters ( 5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:ClearFocus();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetAutoFocus( false )
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetTextInsets( 2 , 3 , 3 , 2 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetFontObject ( "GameFontWhite" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:EnableMouse( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetSize ( 65 , 18 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2.GRM_ExportRangeText2 , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetNumeric ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetMaxLetters ( 5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:ClearFocus();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetAutoFocus( false )
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetTextInsets( 2 , 3 , 3 , 2 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetFontObject ( "GameFontWhite" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:EnableMouse( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetJustifyH ( "CENTER" );

        -- Export level range
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetSize ( 65 , 18 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.GRM_ExportLevelRangeText1 , "RIGHT" , 12 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetNumeric ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetMaxLetters ( 3 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:ClearFocus();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetAutoFocus( false )
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetTextInsets( 2 , 3 , 3 , 2 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetFontObject ( "GameFontWhite" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:EnableMouse( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetSize ( 65 , 18 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetPoint ( "LEFT" , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.GRM_ExportLevelRangeText2 , "RIGHT" , 10 , 0 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetNumeric ( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetMaxLetters (3 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:ClearFocus();
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetAutoFocus( false )
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetTextInsets( 2 , 3 , 3 , 2 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetFontObject ( "GameFontWhite" );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:EnableMouse( true );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetJustifyH ( "CENTER" );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.tempText = "";
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.tempText = "";


        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetScript ( "OnEditFocusLost" , function ( self )

            Export.ProcessExportLevelRange ( self , 1 );

            if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
                Export.LoadExportMembertab();
            elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
                Export.LoadExportFormerMembertab();
            elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 then
                Export.LoadExportDeathsTab( false );
            end

            self:HighlightText ( 0 , 0 );
            self.tempText = self:GetText();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetScript ( "OnShow" , function ( self )
            if not ( GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 ) then
                local lower = GRM.S().ExportLevelRange[1];

                self:SetText( tostring ( lower ) );
                self.tempText = tostring ( lower );
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetScript ( "OnEscapePressed" , function( self )
            self:SetText ( self.tempText );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetScript ( "OnEnterPressed" , function( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetScript ( "OnEditFocusLost" , function ( self )

            Export.ProcessExportLevelRange ( self , 2 );

            if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
                Export.LoadExportMembertab();
            elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
                Export.LoadExportFormerMembertab();
            elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 then
                Export.LoadExportDeathsTab( false );
            end

            self:HighlightText ( 0 , 0 );
            self.tempText = self:GetText();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetScript ( "OnEscapePressed" , function( self )
            self:SetText ( self.tempText );
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1:SetFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetScript ( "OnEnterPressed" , function( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2:SetScript ( "OnShow" , function ( self )
            if not ( GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 ) then
                local topLevel = GRM.S().ExportLevelRange[2];
                if GRM.S().ExportLevelRange[2] == 999 then
                    topLevel = GRM_G.LvlCap ;
                end

                self:SetText( tostring ( topLevel ) );
                self.tempText = tostring ( topLevel );
            end
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            Export.ExportRangeEditBox1 ( self );
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetScript ( "OnEscapePressed" , function( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText( 0 );
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetScript ( "OnEnterPressed" , function( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText( 0 , 0 );
            Export.ExportRangeEditBox2 ( self );
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetScript ( "OnEscapePressed" , function( self )
            self:ClearFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText( 0 );
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1:SetFocus();
        end);

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2:SetScript ( "OnEnterPressed" , function( self )
            self:ClearFocus();
        end);

        isManualUpdate = true;   -- need to set as true to ensure text gets configured first time.
        -- Need to scale it properly
        GRM_UI.SetAllWindowScales ( true , "export" );
    end

    if isManualUpdate then
        Export.BuildExportStrings();
    end
end

-- Method:          Export.BuildExportStrings()
-- What it Does:    Builds the string and the sets font details
-- Purpose:         Allows for player to adjust font/text/localization on the fly so keeping wrapped in its own function allows it to be processed without the blaot of the other UI details.
Export.BuildExportStrings = function()
    if GRM_UI.GRM_ExportLogBorderFrame then
        -- TEXT LOCALIZATION AND FONT CHANGES ON DEMAND
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportResetOptionsButtonText:SetText ( GRM.L ( "Restore Defaults" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportLogText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportLogText:SetText ( GRM.L ( "Ctrl-C to Copy <> Ctrl-P to Paste <> Ctrl-A to Select All" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 16 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLoadingText:SetText ( GRM.L ( "Building Log for Export..." ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTabText:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTabText:SetText ( GRM.L ( "Guild Log" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTabText:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportGuildDataTabText:SetText ( GRM.L ( "Members" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTabText:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLeftGuildDataTabText:SetText ( GRM.L ( "Former Members" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportDataHeaderText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportDataHeaderText:SetText ( GRM.L ( "Data Export" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_LogExportFiltersFrame.GRM_ExportLogObeysFiltersText:SetText ( GRM.L ( "*Export obeys the current log display filters" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetText ( GRM.L ( "Clear Lines:" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 11.5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2.GRM_ExportRangeText2:SetText ( GRM.L ( "To" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox2.GRM_ExportRangeText2:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 11.5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportMemberDetailsHeadersButtonText:SetText ( GRM.L ( "Spreadsheet Headers" ) );

        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.GRM_ExportLevelRangeText1:SetText ( GRM.L ( "Level Range:" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox1.GRM_ExportLevelRangeText1:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 13 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.GRM_ExportLevelRangeText2:SetText ( GRM.L ( "To" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLevelRangeEditBox2.GRM_ExportLevelRangeText2:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 11.5 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterText:SetText ( GRM.L ( "Delimiter:" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_DelimiterDropdownMenuSelected.GRM_DelimiterDropdownMenuText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 16 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButtonText:SetText ( GRM.L ( "Export Selection" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton.GRM_ExportAutoIncludeHeadersCheckButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton.GRM_ExportAutoIncludeHeadersCheckButtonText:SetText ( GRM.L ( "Auto Include Headers" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportAutoIncludeHeadersCheckButton.GRM_ExportAutoIncludeHeadersCheckButtonText );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21.GRM_ExportFilter21Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21.GRM_ExportFilter21Text:SetText ( GRM.L ( "Remove Alt-Code Letters From Names" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter21.GRM_ExportFilter21Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text:SetText ( GRM.L ( "Mythic+ Score" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text:SetText ( GRM.L ( "Faction" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter23.GRM_ExportFilter23Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text:SetText ( GRM.L ( "Player GUID" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter20.GRM_ExportFilter20Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1.GRM_ExportFilter1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter1.GRM_ExportFilter1Text:SetText ( GRM.L ( "Name" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2.GRM_ExportFilter2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter2.GRM_ExportFilter2Text:SetText ( GRM.L ( "Rank" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3.GRM_ExportFilter3Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter3.GRM_ExportFilter3Text:SetText ( GRM.L ( "Level" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4.GRM_ExportFilter4Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter4.GRM_ExportFilter4Text:SetText ( GRM.L ( "Class" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15.GRM_ExportFilter15Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter15.GRM_ExportFilter15Text:SetText ( GRM.L ( "Race" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16.GRM_ExportFilter16Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter16.GRM_ExportFilter16Text:SetText ( GRM.L ( "Sex" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5.GRM_ExportFilter5Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter5.GRM_ExportFilter5Text:SetText ( GRM.L ( "Last Online" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6.GRM_ExportFilter6Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter6.GRM_ExportFilter6Text:SetText ( GRM.L ( "Main/Alt" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7.GRM_ExportFilter7Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter7.GRM_ExportFilter7Text:SetText ( GRM.L ( "Join Date" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8.GRM_ExportFilter8Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter8.GRM_ExportFilter8Text:SetText ( GRM.L ( "Promo Date" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18.GRM_ExportFilter18Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter18.GRM_ExportFilter18Text:SetText ( GRM.L ( "Rank History" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9.GRM_ExportFilter9Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter9.GRM_ExportFilter9Text:SetText ( GRM.L ( "Birthday" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text:SetText ( GRM.L ( "Guild Rep" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text:SetText ( GRM.L ( "Public Note" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter11.GRM_ExportFilter11Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text:SetText ( GRM.L ( "Officer Note" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter12.GRM_ExportFilter12Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text:SetText ( GRM.L ( "Custom Note" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter13.GRM_ExportFilter13Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14.GRM_ExportFilter14Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter14.GRM_ExportFilter14Text:SetText ( GRM.L ( "Player Alts" ) );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text:SetText ( GRM.L ( "Mains Only" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial1Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text:SetText ( GRM.L ( "Alts Only" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2 , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter17_Radial2Text );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText:SetText ( "> " .. GRM.L ( "Check All" ) );
        GRM.NormalizeHitRects ( GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton , GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectAllButton.GRM_ExportSelectAllButtonText );

        if GRM_G.LocalizedIndex == 5 then -- Russian
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10.5 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10.5 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 10.5 );
        else
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportSelectedRangeButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportNextRangeButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportPreviousRangeButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
        end

        if GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 1 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Log Entries at a Time" ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetText ( GRM.L ( "Select Line Range:" ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Entries: {num}" , nil , nil , GRM_G.CounterCap ) );
        elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 2 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Members at a Time" ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetText ( GRM.L ( "Select Member Range:" ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Members: {num}" , nil , nil , GRM_G.CounterCap ) );
        elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 3 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Former Members at a Time" ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportRangeEditBox1.GRM_ExportRangeText1:SetText ( GRM.L ( "Select Member Range:" ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Former Members: {num}" , nil , nil , GRM_G.CounterCap ) );
        elseif GRM_UI.GRM_ExportLogBorderFrame.TabPosition == 4 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportSizeMaxText:SetText ( GRM.L ( "*Max Export is 500 Recorded Deaths at a Time" ) );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportLogTab.GRM_ExportTotalSizeText:SetText ( GRM.L ( "Total Deaths Recorded: {num}" , nil , nil , GRM_G.CounterCap ) );
        end

        -- GUild Rep - Disabled in all  Classic builds prior to Cataclysm
        if GRM_G.BuildVersion < 40000 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter10.GRM_ExportFilter10Text2:SetText ( GRM.L ( "(Disabled in Classic)" ) );
        end

        -- Disabled in All Classic Builds
        if GRM_G.BuildVersion < 80000 then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 9 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportFilter22.GRM_ExportFilter22Text2:SetText ( GRM.L ( "(Disabled in Classic)" ) );
        end

        if GRM_G.HardcoreActive then
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTabText:SetFont( GRM_G.FontChoice , GRM_G.FontModifier + 10 );
            GRM_UI.GRM_ExportLogBorderFrame.GRM_ExportDeathsTabText:SetText ( GRM.L ( "Hardcore Deaths" ) );
        end

        Export.SetExportButtonText();

    end
end