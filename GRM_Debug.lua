--------------------------------------
-------- DEBUGGING -------------------
--------------------------------------

local Debug = {};
GRM.Debug = Debug;

-- Method:          Debug.DebugConfig( string )
-- What it Does:    Enables debugging logging
-- Purpose:         To help debug issues of course, by logging them.
Debug.DebugConfig = function(command)
    if GRM_G.DebugEnabled and not string.find(command, " ") then
        GRM_G.DebugEnabled = false;
        GRM.Report(GRM.L("GRM Debugging Disabled."));
    else
        if GRM_G.DebugEnabled then
            local number = GRM.Trim(string.sub(command, string.find(command, " ") + 1));
            if string.find(command, " ") ~= nil and tonumber(number) ~= nil then
                Debug.DebugLog(tonumber(number));
            else
                GRM.Report(GRM.L("Error: Debug Command not recognized.") .. "\n" .. GRM.L("Format: \"/grm debug 10\""));
            end
        else
            GRM_G.DebugEnabled = true;
            GRM.Report(GRM.L("GRM Debugging Enabled.") .. "\n" ..
                           GRM.L("Please type \"/grm debug 10\" to report 10 events (or any number)"));
            if #GRM_G.currentAddonUsers > 0 and GRM.S().syncEnabled then
                GRM.Report(GRM.L(
                    "You may want to temporarily disable SYNC in the options if you are debugging another feature."));
            end
        end
    end
end

-- Method:          Debug.DebugLog ( int )
-- What it Does:    Prints out the Debug Log the last X number of items that occurred before logging off or disconnecting.
-- Purpose:         Occasionally disconnects happen. This will let me know what happened!
Debug.DebugLog = function(numToShow)
    local index;
    if numToShow < 0 or #GRM_G.DebugLog - numToShow < 0 then
        index = 0;
        numToShow = #GRM_G.DebugLog;
    else
        index = #GRM_G.DebugLog - numToShow;
    end

    GRM.Report(string.upper(GRM.L("Debugger Start") .. ": " .. numToShow .. "/" .. #GRM_G.DebugLog));
    for i = index + 1, #GRM_G.DebugLog do
        GRM.Report(GRM_G.DebugLog[i]);
    end
end

-- Method:          Debug.AddDebugMessage ( string )
-- What it Does:    Addes messages of recent events to debug log...
-- Purpose:         Debugging tracking
Debug.AddDebugMessage = function(msg)
    -- To prevent too large of a debug log...
    if msg == "" then
        msg = "Empty Msg";
    end
    if #GRM_G.DebugLog < 250 then
        table.insert(GRM_G.DebugLog, time() .. ": " .. msg);
    else
        local tempLog = {};
        for i = #GRM_G.DebugLog - 50, #GRM_G.DebugLog do
            table.insert(tempLog, time() .. ": " .. GRM_G.DebugLog[i]);
        end
        GRM_G.DebugLog = tempLog;
        table.insert(GRM_G.DebugLog, msg);
    end
end

-- Method:          Debug.DebugMessages()
-- What it Does:    Enables debugging messages
-- Purpose:         Get rid of need of 2 sets of programs... just enable and disable.
Debug.DebugMessages = function()
    if GRM_G.DebugMsgEnabled then
        GRM_G.DebugMsgEnabled = false;
        GRM.Report(GRM.L("Debugging Enabled"));
    else
        GRM_G.DebugMsgEnabled = true;
        GRM.Report(GRM.L("Debugging Disabled"));
    end
end
