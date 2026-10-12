GRM_Name = {};

local IsNameColorized = function(name)
    return name:find("^|cff") ~= nil
end

-- Helper to grab the bracket wrapper
local WrapByTag = function(text, index)
    if index == 1 then return "<" .. text .. ">" end
    if index == 2 then return "(" .. text .. ")" end
    if index == 3 then return "[" .. text .. "]" end
    return text
end

-- Wrapping nickname with the proper tag
local WrapByNickTag = function(text, index)
    if index == 1 then return "~" .. text .. "~" end
    if index == 2 then return "**" .. text .. "**" end
    if index == 3 then return "*" .. text .. "*" end
    return text
end

-- Helper on main tag
local GetCurrentMainTag = function()
    return GRM_G.TagHexCode .. GRM_Name.GetMainTags(false, GRM.S().mainTagIndex) .. "|r";
end

-- Herlper on alt tag
local GetCurrentAltTag = function()
    return GRM_G.TagHexCode .. GRM_Name.GetAltTags(false, GRM.S().mainTagIndex) .. "|r";
end

-- Method:          GRM_Name.GetFormattedNameString
-- What it Does:    Builds the chat string dynamically based on the 4 dropdown settings.
GRM_Name.GetFormattedNameString = function(toonName, mainName, nickname, isMain, index)
    local s = GRM.S()

    toonName = IsNameColorized(toonName) and toonName or GRM.GetClassifiedName(toonName,false)
    mainName = IsNameColorized(mainName) and mainName or GRM.GetClassifiedName(mainName,false)
    nickname = IsNameColorized(nickname) and nickname or GRM.GetClassifiedName(nickname,false)

    local nickHex = GRM.GetStringClassColorByName(nickname)
    
    local c1 = GRM.Util.rgbToHex({s.mainTagColor.r, s.mainTagColor.g, s.mainTagColor.b})
    local c2 = GRM.Util.rgbToHex({s.nicknameTagColor.r, s.nicknameTagColor.g, s.nicknameTagColor.b})
    local reset = "|r"

    local M = GRM_Name.GetMainTags(false, s.mainTagIndex)
    local A = GRM_Name.GetAltTags(false, s.altTagIndex)
    
    local colM = M ~= "" and (c1 .. M .. reset) or ""
    local colA = A ~= "" and (c1 .. A .. reset) or ""
    
    local nochange = " (" .. GRM.L("Tagging Disabled") .. ")"
    local noNickname = " (" .. GRM.L("Nickname Disabled") .. ")"
    local result = ""

    -- 1. NICKNAME FORMATTING
    if nickname and nickname ~= "" then
        local nickStr = c2 .. WrapByNickTag(nickname, s.nickTagIndex) .. reset
        local wrapMain = c1 .. WrapByTag(mainName, s.mainTagIndex) .. reset

        if isMain then
            local f = index or s.nicknameFormatMain
            
            if f == 1 then result = nickStr .. " " .. wrapMain
            elseif f == 2 then result = nickStr .. " " .. c1 .. mainName .. " " .. M .. reset
            elseif f == 3 then result = mainName .. " " .. nickStr
            elseif f == 4 then result = wrapMain .. " " .. nickStr
            elseif f == 5 then result = mainName .. " " .. colM .. " " .. nickStr
            elseif f == 6 then result = nickStr .. " " .. colM
            elseif f == 7 then result = nickStr
            elseif f == 8 then result = toonName .. noNickname end
        else
            local f = index or s.nicknameFormatAlt
            if f == 1 then result = nickStr .. " " .. c1 .. toonName .. " " .. A .. reset
            elseif f == 2 then result = toonName .. " " .. nickStr
            elseif f == 3 then result = toonName .. " " .. colA .. " " .. nickStr
            elseif f == 4 then result = nickStr .. " " .. wrapMain
            elseif f == 5 then result = nickStr .. " " .. c1 .. mainName .. " " .. M .. reset
            elseif f == 6 then result = nickStr .. " " .. colA
            elseif f == 7 then result = nickStr
            elseif f == 8 then result = toonName .. noNickname end
        end

    -- 2. STANDARD FORMATTING
    else
        if isMain then
            local f = index or s.nameFormatMain
            local wrapMain = c1 .. WrapByTag(toonName, s.mainTagIndex) .. reset

            if f == 1 then result = toonName .. " " .. colM
            elseif f == 2 then result = wrapMain
            elseif f == 3 then result = toonName .. nochange end
        else
            local f = index or s.nameFormatAlt
            local wrapMain = c1 .. WrapByTag(mainName, s.mainTagIndex) .. reset

            if f == 1 then result = toonName .. " " .. wrapMain
            elseif f == 2 then result = toonName .. " " .. c1 .. mainName .. " " .. M .. reset
            elseif f == 3 then result = toonName .. " " .. colA .. " " .. c1 .. mainName .. " " .. M .. reset
            elseif f == 4 then result = toonName .. " " .. colA
            elseif f == 5 then result = toonName .. nochange end
        end
    end

    -- Trim any double spaces that might occur if tags are empty ("")
    return GRM.Util.Trim(string.gsub(result, "  ", " "))
end

-- Method:          GRM_Name.RefreshTagHexCode()
-- What it Does:    Reconverts the RGB values, scales then, then converts to hexcode
-- Purpose:         So, this only needs to be configured one time on load, or when the player updates the settings.
GRM_Name.RefreshTagHexCode = function()
    GRM_G.TagHexCode = GRM.Util.rgbToHex({GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b});
    GRM_G.mainTag = GetCurrentMainTag();
    GRM_G.altTag = GetCurrentAltTag();
end

-- Helper for fetching the pure tag
GRM_Name.GetMainTags = function(returnTable, index)
    local tags = { "<" .. GRM.L("M") .. ">", "(" .. GRM.L("M") .. ")", "[" .. GRM.L("M") .. "]" }
    return returnTable and tags or tags[index]
end

GRM_Name.GetAltTags = function(returnTable, index)
    local tags = { "<" .. GRM.L("A") .. ">", "(" .. GRM.L("A") .. ")", "[" .. GRM.L("A") .. "]" }
    return returnTable and tags or tags[index]
end

GRM_Name.GetNickTags = function(returnTable, index)
    local s = GRM.S()
    local playerClass = select(2,UnitClass("player"));
    local nickHex = GRM.Util.rgbToHex({s.nicknameTagColor.r, s.nicknameTagColor.g, s.nicknameTagColor.b})
    local reset = "|r"
    local nickName = GRM.GetClassColorRGB("WARRIOR" ~= playerClass and "WARRIOR" or "HUNTER", true) .. GRM.L("Nickname") .. reset
    local tags = {  nickHex .. "~" .. nickName .. "~" .. reset,
                    nickHex .. "**" .. nickName .. "**" .. reset,
                    nickHex .. "*" .. nickName .. "*" .. reset
                 }
    return returnTable and tags or tags[index]
end

-- Method:          GRM.RemoveMainAltTags ( string )
-- What it Does:    takes the name, and parses out both the string coloring and the main tag. There is ALWAYS hexcode, so "|" can be found.
-- Purpose:         Add Alt window has the tags added, this just retroactively removes them.
GRM.RemoveMainAltTags = function(text)
    local index = string.find(text, "|")
    if index ~= nil then
        text = string.sub(text, 1, index - 1);
    end
    return GRM.Util.Trim(text);
end