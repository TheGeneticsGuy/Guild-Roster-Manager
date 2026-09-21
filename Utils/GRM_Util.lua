local Util = {};
GRM.Util = Util;

-- Method:          Util.TableLength ( table )
-- What it Does:    Returns the integer count of how many items in the given list
-- Purpose:         Since Lua does not provide a simple count on tables, this is a reusable tool
Util.TableLength = function(list)
    local count = 0;

    for _ in pairs(list) do
        count = count + 1;
    end

    return count;
end

-- Method:          Util.DeepCopyArray(array)
-- What it Does:    Makes a Deep copy, including all children, recursively, so as to create a new memory reference of the array
-- Purpose:         In most languages, including Lua, you cannot just copy a table. It copies the reference and changes made to new table and references the memory to being the same, even if they have different variable names
--                  So, to truly create a unique reference to an array, so if you edit one it doesn't edit both, you need to do a true copy. This basically creates a new empty array and imports each value
--                  to the table. Backups would not be possible without this code right here.
Util.DeepCopyArray = function(tableToCopy)
    local copy;
    if type(tableToCopy) == 'table' then
        copy = {};
        for orig_key, orig_value in next, tableToCopy, nil do
            copy[Util.DeepCopyArray(orig_key)] = Util.DeepCopyArray(orig_value); -- This recursive action is essentially taking every multi-D array value and it keeps digging til it builds every layer of multi-dimensional array
        end
        setmetatable(copy, Util.DeepCopyArray(getmetatable(tableToCopy)));
    else
        copy = tableToCopy; -- Imported data was not a table... just return orig. value - error protection
    end
    return copy;
end

-- Method:          Util.RegisterGuildChatPermission()
-- What it Does:    Initiates attempt to determine player has access to proper channel
-- Purpose:         If guild chat channel is restricted then sync cannot be enabled either...
Util.RegisterGuildChatPermission = function()
    GRM_G.HasAccessToGuildChat = C_GuildInfo.CanSpeakInGuildChat();
    if GRM.CanEditOfficerNote() then
        GRM_G.HasAccessToOfficerChat = true;
    end
end

local function CountTableElements(tbl, visited)
    if type(tbl) ~= "table" then
        return 0
    end

    visited = visited or {}
    if visited[tbl] then
        return 0
    end
    visited[tbl] = true

    local count = 0
    for _, v in pairs(tbl) do
        count = count + 1 -- Count the key-value pair
        if type(v) == "table" then
            count = count + CountTableElements(v, visited) -- Recursive into nested tables
        end
    end

    return count
end

local format_with_commas = function(n)
  local formatted = tostring(n)
  local k
  while true do
    formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
    if k == 0 then break end
  end
  return formatted
end

-- Method:          GetLogCountAllGuilds()
-- What it Does:    Returns the integer count of all logs and number guilds
-- Purpose:         Important messaging to prevent stack overflow data limits.
local GetLogCountAllGuilds = function()
    local count = 0;
    local numGuilds = 0;
    for _,log in pairs(GRM_LogReport_Save) do
        count = count + #log;
        numGuilds = numGuilds + 1;
    end

    return count , numGuilds;
end

-- Method:          Util.WarnTableSize()
-- What it Does:    Establishes the warning message to addon users of reaching addon data limits
-- Purpose:         If total storage capacity in GRM tables were to reach 32-bit limits a stack overflow
--                  could theoretically cause Blizzard to destroy the addon save file.
Util.WarnTableSize = function()
    local log = GRM.GetLog();
    local processed = false;

    if log then
        local size = #log;
        local maxSize = 100000;
        local totalAllGuilds , totalGuilds = GetLogCountAllGuilds();
        local percent = GRM.Round( (totalAllGuilds / maxSize) * 100 , 2 );
        local nextWarning = 75;
        local LogSizeWarning = Util.DeepCopyArray(GRM.S().LogSizeWarning)

        local updateLogWarning = function()
            GRM.S().LogSizeWarning = LogSizeWarning;
        end

        if percent >= 50 and not LogSizeWarning[1] then
            LogSizeWarning[1] = true;
            processed = true;
        elseif percent < 50 then
            LogSizeWarning[1] = false;
        end
        if percent >= 75 and not LogSizeWarning[2] then
            LogSizeWarning[2] = true;
            nextWarning = 90;
            processed = true;
        elseif percent < 75 then
            LogSizeWarning[2] = false;
        end
        if percent >= 90 and not LogSizeWarning[3] then
            LogSizeWarning[3] = true;
            nextWarning = 100;
            processed = true;
        elseif percent < 90 then
            LogSizeWarning[3] = false;
        end
        if percent >= 100 and not LogSizeWarning[4] then
            LogSizeWarning[4] = true;
            nextWarning = 110;
            processed = true;
        elseif percent < 100 then
            LogSizeWarning[4] = false;
        end

        -- need to add the warning
        if processed then

            local message = GRM.L("Warning!") .. "\n|CFFFFFFFF" .. GRM.L ( "Your guild Log has {num} entries. Warcraft addons are limited in how much data can be stored. GRM provides this warning as a cushion to help ensure this is never broken as it would result in a catastrophic overflow error that will potentially destroy the GRM save file." , nil , nil , format_with_commas(size) );
            local messagePart2 = "";

            if totalGuilds == 1 then
                messagePart2 = GRM.L ( "You are currently storing {num} log entries in your guild, taking up approximately {custom1}% of the addon's storage capacity." , nil , nil , format_with_commas(size) , percent );
            else
                messagePart2 = GRM.L ( "You are currently storing {num} log entries across {custom1} guilds, taking up approximately {custom2}% of the addon's storage capacity." , nil , nil , format_with_commas(totalAllGuilds) , totalGuilds , percent );
            end

            local messagePart3 = GRM.L ( "To Cleanup the log, if you wish to keep the data, please go to the export window by typing `/grm export` and copying the log to an external document. Then, on the log page, click on the \'Open Log Tools\' button on the right side." )
            local messagePart4 = "";

            if nextWarning > 100 then
                messagePart4 = GRM.L ( "You are at risk for GRM data loss. It is CRITICAL this is handled imediately. Click OK to acknowledge. You will not be warned again." );
            elseif nextWarning == 100 then
                messagePart4 = GRM.L ( "You are nearing max GRM storage limit. It is CRITICAL this is handled soon. Click OK to acknowledge." );
            elseif nextWarning <= 90 then
                messagePart4 = GRM.L ( "Press OK to acknowledge and you will not be reminded again until you are at {num}% capacity." , nil , nil , nextWarning );
            end

            local finalMsg = message .. "\n\n" .. messagePart2 .. "\n\n" .. messagePart3 .. "\n\n" .. messagePart4;
            GRM.InitiateConfirmFrame( finalMsg, updateLogWarning , GRM.L ( "Ok!" ) , GRM.L ("Ignore") , nil, nil , 500 , 300 , false );

            GRM.InitiateEditBoxPopup( GRM.WebApps.GetWebAppURL("extract") , GRM.L("Copy this link to use a web app to Export the contents of your log to a Text, CRV, or JSON file") );

        end
    end
end

-- Method:          Util.IsValidName(string)
-- What it Does:    Returns true if the name only contains valid characters in it... based on ASCII numeric values
-- Purpose:         When player is manually adding someone to the player data, we need ot ensure only proper characters are allowed.
Util.IsValidName = function(name)
    local result = true;
    name = Util.Trim(name); -- In case any whitespace before or after...
    for i = 1, #name do
        -- As a stopgap until I scan for all fonts, let's check this.
        local char = string.sub(name, i, i);
        -- local byteValue = string.byte ( char );
        if tonumber(char) ~= nil or char == " " or char == "\\" or char == "\n" or char == ":" or char == "(" or char ==
            "$" or char == "%" or char == "/" then
            return false;
        end

    end
    return result;
end

-- Method:          Util.UTF8char ( int , int )
-- What it Does:    Returns the number of bytes used by the UTF8 value
-- Purpose:         So as to maintain character count compatibility for all languages.
Util.UTF8char = function(s, i)
    i = i or 1

    local c = string.byte(s, i);

    -- byte 1
    if c > 0 and c <= 127 then
        -- UTF8-1
        return 1

        -- byte 2
    elseif c >= 194 and c <= 223 then
        return 2

        -- byte 3
    elseif c >= 224 and c <= 239 then
        return 3

        -- byte 4
    elseif c >= 240 and c <= 244 then
        return 4
    end

end

-- Method:          Util.UTF8Len ( string )
-- What it Does:    Returns the length of an input string.
-- Purpose:         So the addon can read the proper character length of text no matter the language.
Util.UTF8Len = function(s)

    local pos = 1
    local bytes = string.len(s)
    local len = 0

    while pos <= bytes do
        len = len + 1
        pos = pos + Util.UTF8char(s, pos)
    end

    return len
end

-- Method:          Util.GetNumLetters ( text )
-- What it Does:    Returns the character count of the numLetters of a text string
-- Purpose:         Compatibility with ALL languages
Util.GetNumLetters = function(text)
    local c = 0;

    if text ~= nil then
        c = GRM.UTF8Len(text);
    end

    return c;
end

-- Method:          Util.CapitalizeFirst ( string )
-- What it Does:    Formats the string properly to have the first letter of the word/name capitalized
-- Purpose:         Cleanup formatting of a name to prevent human error protection.
Util.CapitalizeFirst = function(text)
    local count = 1;
    local byteCount = text:byte(1);
    if byteCount == 195 or byteCount == 165 or byteCount == 208 then -- Special cahracters some can be 2 bytes in length and they are given a value of 195 or 165 in Lua return
        count = 2;
    end

    if GRM.S().selectedLang < 9 then
        text = string.upper(string.sub(text, 1, count)) .. string.sub(text, count + 1);
    end
    return text;
end

-- Method:          Util.FormatInputName ( string )
-- What it Does:    Formats the name to proper pronoun form, but only if a non Asian character language
-- Purpose:         Huaman error protection on player input.
Util.FormatInputName = function(name)

    if string.find(name, " ") ~= nil then
        -- space found, multi word!!!
        local tempName = string.lower(name);
        local result = "";
        local number = select(2, string.gsub(tempName, "%s", ""));

        for i = 1, number do
            result = result .. Util.CapitalizeFirst(string.sub(tempName, 1, string.find(tempName, " ") - 1) .. " ");
            tempName = string.sub(tempName, string.find(tempName, " ") + 1);
            if i == number then
                result = result .. Util.CapitalizeFirst(tempName);
            end
        end
        name = result;
    else
        name = Util.CapitalizeFirst(name);
    end
    local byteCount = name:byte(1);
    local count = 1;
    if byteCount == 195 or byteCount == 165 or byteCount == 208 then -- Special cahracters some can be 2 bytes in length and they are given a value of 195 or 165 in Lua return
        count = 2;
    end
    if GRM.S().selectedLang < 9 and not string.find(name, " ") then
        name = string.sub(name, 1, count) .. string.lower(string.sub(name, count + 1));
    end
    return name;
end

-- Method:          Util.Capitalize ( string )
-- What it Does:    Takes the first letter of a word and capitalizes it, whilst lowercasing the rest
-- Purpose:         Proper formatting of names.
Util.Capitalize = function(word)
    word = string.lower(word);
    return (word:gsub("^%l", string.upper))
end

-- Method:          Util.Title ( string )
-- What it Does:    It capitalizes the first letter of every word
-- Purpose:         I really like how "Title()" works in python and wanted to replicate it in GRM for ease of use,
--                  particularly when custom typing realm names, to assist, when banning.
Util.Title = function(words)
    local capitalized = {};
    if not words then
        return "" -- Return an empty string to avoid any weird UI errors
    end

    for word in words:gmatch("%S+") do
        table.insert(capitalized, Util.Capitalize(word));
    end

    return table.concat(capitalized, " ");
end

-- Method           Util.Trim ( string )
-- What it Does:    Removes the white space at front and at tail of string.
-- Purpose:         Cleanup strings for ease of logic control, as needed.
Util.Trim = function(str)
    if str == nil then
        return nil;
    else
        return (str:gsub("^%s*(.-)%s*$", "%1"));
    end
end

-- Method:          Util.NormalizeRealmName ( string )
-- What it Does:    It removes any hyphens in names, or spaces. This is how all the realm names appear on players in the DB
-- Purpose:         Unfortunatelly the built-in API for normalized realms only returns the connected realms, which is not very helpful post 11.0 x-server guilds.
Util.NormalizeRealmName = function(realmName)
    if realmName then
        realmName = string.gsub(string.gsub(realmName, "-", ""), "%s+", "");
    end
    return realmName
end
 
-- Method:          Util.GetWordArrayFromString ( string , string )
-- What it Does:    Returns an array of words or items that were divided by characters
-- Purpose:         Cleanup code for parsing back the sendAddonMessage strings.
Util.GetWordArrayFromString = function(text, divider)
    local result = {};
    while string.find(text, divider) ~= nil do
        table.insert(result, string.sub(text, 1, string.find(text, divider) - 1));
        text = string.sub(text, string.find(text, divider) + 1);
    end
    if #text > 0 then
        table.insert(result, text);
    end
    return result;
end