GRM_Name = {};

-- Method:          GRM_Name.GetFormattedNameString ( toonName, mainName, nickname, isMain )
-- What it Does:    Returns the perfectly formatted and colorized string based on the player's settings for nickname and main/alt tags
-- Purpose:         Universal formatter for Chat Hooks and UI Live Previews.
GRM_Name.GetFormattedNameString = function(toonName, mainName, nickname, isMain)
    local s = GRM.S()
    local altTag = GRM.GetCurrentAltTag()
    local mainTag = GRM.GetCurrentMainTag()
    
    local c1 = GRM.rgbToHex({s.mainTagColor.r, s.mainTagColor.g, s.mainTagColor.b})
    local c2 = GRM.rgbToHex({s.nicknameTagColor.r, s.nicknameTagColor.g, s.nicknameTagColor.b})
    local reset = "|r"

    -- 1. NICKNAME FORMATTING
    if nickname and nickname ~= "" then
        if isMain then
            local f = s.nicknameFormatMain
            if f == 1 then return toonName .. " " .. c2 .. "(" .. nickname .. ")" .. reset end
            if f == 2 then return toonName .. " " .. c2 .. "<" .. nickname .. ">" .. reset end
            if f == 3 then return toonName .. " " .. c2 .. "~" .. nickname .. "~" .. reset end
            if f == 4 then return c2 .. "*" .. nickname .. "*" .. reset end
        else
            local f = s.nicknameFormatAlt
            -- For Alts with Nicknames, they might want to see the Main's name too!
            if f == 1 then return toonName .. " " .. c2 .. "(" .. nickname .. ")" .. reset end
            if f == 2 then return toonName .. " " .. c2 .. "<" .. nickname .. ">" .. reset end
            if f == 3 then return c2 .. "*" .. nickname .. "*" .. reset end
            if f == 4 then return toonName .. " " .. c2 .. "(" .. nickname .. ")" .. reset .. " " .. c1 .. "<" .. mainName .. ">" .. reset end
            if f == 5 then return c2 .. "*" .. nickname .. "*" .. reset .. " " .. c1 .. "<" .. mainName .. ">" .. reset end
        end
    end

    -- 2. STANDARD FORMATTING (No Nickname)
    if isMain then
        local f = s.nameFormatMain
        if f == 1 then return toonName end
        if f == 2 then return toonName .. " " .. c1 .. mainTag .. reset end
        if f == 3 then return toonName .. " " .. c1 .. "<" .. mainName .. ">" .. reset end
    else
        local f = s.nameFormatAlt
        if f == 1 then return toonName end
        if f == 2 then return toonName .. " " .. c1 .. altTag .. reset .. " " .. c1 .. "(" .. mainName .. " " .. mainTag .. ")" .. reset end
        if f == 3 then return toonName .. " " .. c1 .. altTag .. reset end
        if f == 4 then return toonName .. " " .. c1 .. "(" .. mainName .. ")" .. reset end
        if f == 5 then return toonName .. " " .. c1 .. "<" .. mainName .. ">" .. reset end
    end

    return toonName -- Absolute fallback
end