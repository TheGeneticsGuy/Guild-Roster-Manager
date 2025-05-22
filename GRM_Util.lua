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