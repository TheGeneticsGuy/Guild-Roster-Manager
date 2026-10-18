GRM_Chat = {};

-- Chat Message Controls
GRM_G.Chat = {};
GRM_G.MainHookConfigured = false;

local UnconfirmedChatTabs = {};

-- Method:          MissingChatTabs ( table )
-- What it Does:    Informs the player of the missing custom chat channels and asks for permission to rebuild
-- Purpose:         There is an occasional issue of custom chat channels disappearing, not sure why. This adapts to it.
--                  The channels disappearing on occasion can even happen with all addons disabled.
local function MissingChatTabs(channels)
    if #channels > 0 then

        local createChatWindows = function()
            
            for i = 1 , #channels do
                if GRM_G.Compat.ChattynatorLoaded then
                    GRM.chattynator.CreateChattynatorTab(channels[i]);
                else
                    local frame = FCF_OpenNewWindow(channels[i] , true);
                    FCF_CopyChatSettings(frame, DEFAULT_CHAT_FRAME);
                    table.insert ( GRM_G.Chat , frame );
                    FCF_DockUpdate();
                end
            end

            local updateText = ""
            if #channels == 1 then
                updateText = GRM.L ("The missing GRM channel has been recreated.")
            else
                updateText = GRM.L ( "The {num} missing GRM channels have been recreated" , nil,nil,#channels);
            end
            GRM.Report ( updateText );
        end

        local resetChatToDefault = function()
            local reportMsg = "";
            if #channels < #GRM.S().reportChannel then
                -- This means only some channels missing
                for i = 1 , #channels do
                    for j = #GRM.S().reportChannel , 1 , -1 do
                        if GRM.S().reportChannel[j] == channels[i] then
                            table.remove ( GRM.S().reportChannel , j );
                            break;
                        end
                    end
                end

                -- Let's re-establish the used channels
                GRM_Chat.SetReportWindow();
                local channels = GRM.S().reportChannel[1];
                for i = 1 , #GRM.S().reportChannel do
                    channels = channels .. ", " .. GRM.S().reportChannel[i];
                end
                reportMsg = GRM.L ( "GRM will now only send messages to the following channels:" ) .. " " .. channels;
            else
                GRM.S().reportChannel = {};
                GRM_G.Chat = {DEFAULT_CHAT_FRAME};
                reportMsg = GRM.L ( "GRM will now send all messages to the default \"{name}\" channel" , DEFAULT_CHAT_FRAME.name);
            end

            GRM.Report( reportMsg );
        end

        local text = "";
        local buttonText = "";
        if #channels == 1 then
            text = GRM.L ( "\"{name}\" Custom Chat Window for GRM appears to be missing." , channels[1] ) .. "\n\n" .. GRM.L ( "Would you like to recreate this chat window for messages unique to the GRM addon?" );
            buttonText = GRM.L ( "Add Channel" );
        else
            local missingChannels = channels[1];
            for i = 2 ,#channels do
                missingChannels = missingChannels .. ", " .. channels[i];
            end
            text = GRM.L ( "The following Custom Chat Windows for GRM appear to be missing:" ) .. "\n" .. missingChannels .. "\n\n" .. GRM.L ("Would you like to recreate these chat windows for messages unique to the GRM addon?" );
            buttonText = GRM.L ("Add Channels" );
        end

        local cancelButtonText = "";

        -- Quality of life, let's get that cancel button to say clear messaging
        if #channels == 1 then
            if #GRM.S().reportChannel == 1 then
                cancelButtonText = GRM.L ( "Set to {name}" , DEFAULT_CHAT_FRAME.name );
            elseif #GRM.S().reportChannel == 2 then
                local channelDef = "";
                if GRM.S().reportChannel[1] == channels[1] then
                    channelDef = GRM.S().reportChannel[2];
                else
                    channelDef = GRM.S().reportChannel[1];
                end
                cancelButtonText = GRM.L ( "Keep Only {name}" , channelDef )
            else
                -- Multiple tabs still found
                cancelButtonText = GRM.L ("Ignore Missing");
            end
        else
            if #channels == #GRM.S().reportChannel then
                cancelButtonText = GRM.L ( "Set to {name}" , DEFAULT_CHAT_FRAME.name );
            elseif #GRM.S().reportChannel == 3 then
                -- This means 2 missing and 1 is not.
                -- The one not found in the channels will be what's not missing
                local found = false;
                for i = 1, #GRM.S().reportChannel do
                    found = false;
                    for j = 1 , #channels do
                        if channels[j] == GRM.S().reportChannel[i] then
                            found = true;
                            break;
                        end
                    end
                    if not found then
                        cancelButtonText = GRM.L ( "Keep Only {name}" , GRM.S().reportChannel[i] );
                        break;
                    end
                end
            else
                -- Multiple tabs still found
                cancelButtonText = GRM.L ("Ignore Missing");
            end
        end
        GRM.InitiateConfirmFrame( text, createChatWindows , buttonText, cancelButtonText , resetChatToDefault, true , 350 , 175 , true);
    end
end

-- Method:          GRM.CleanupUnusedChannels(table)
-- What it Does:    Checks if the channel is still one listed. If not, removes it
-- Purpose:         Quality control for the use of custom channels. Ensures cleanup when channels removed.
local function CleanupUnusedChannels(channels)
    local isEstablished;

    -- Remove ones not in the Channel List
    for i = #GRM.S().reportChannel, 1, -1 do
        isEstablished = false;

        for j = 1, #channels do
            if channels[j] == GRM.S().reportChannel[i] then
                isEstablished = true;
                break
            end
        end

        if not isEstablished then
            table.remove(GRM.S().reportChannel, i);
        end
    end

    for i = #GRM_G.Chat, 1, -1 do
        isEstablished = false;

        for j = 1, #GRM.S().reportChannel do
            if GRM_G.Chat[i].name == GRM.S().reportChannel[j] then
                isEstablished = true;
                break
            end
        end

        if not isEstablished then
            table.remove(GRM_G.Chat, i);
        end
    end
end

-- Method:          IsValidChannelName ( string )
-- What it Does:    Determines the number of characters, not byte string lenght, as that is not accurate, and returns true if it is 31 characters or less. Numbers within channel names IS compatible.
-- Purpose:         So the player who is inputing channel names can determine if his are valid.
local function IsValidChannelName(name)
    local result = true;

    if GRM.Util.UTF8Len(name) > 31 then -- Length of Max Characters is 31
        result = false;
    end

    return result
end

-- Method:          ParseMultiChannelString ( string )
-- What it Does:    Takes the string delimited by commas and parsed all the words into a table
-- Purpose:         Particularly for managing multiple channels to send info to
local function ParseMultiChannelString(channels)

    channels = GRM.Util.Trim(channels);
    local result = {};
    local ind = string.find(channels, ",", 1, true);
    local tableName = "";

    if #channels > 0 then

        while ind ~= nil and #channels > 0 do

            tableName = GRM.Util.Trim(string.sub(channels, 1, ind - 1));

            -- Is Valid Name?
            if IsValidChannelName(tableName) then
                table.insert(result, tableName);
            end

            channels = string.sub(channels, ind + 1);
            ind = string.find(channels, ",", 1, true);

            -- No comma on the end
            if ind == nil and #channels > 0 then
                tableName = GRM.Util.Trim(channels);

                -- Is Valid Name?
                if IsValidChannelName(tableName) then
                    table.insert(result, tableName);
                end

            end

        end

        if #result == 0 and ind == nil then
            table.insert(result, GRM.Util.Trim(channels));
        end

    end

    return result;
end

-- Method:          GRM_Chat.CreateChatTabs()
-- What it Does:    Using the created listed of channels in the General Options, it creates the tabs if they do not exist in a Que, with a confirmation box
-- Purpose:         UX quality control
GRM_Chat.CreateChatTabs = function()
    local customName = UnconfirmedChatTabs[1];

    if GRM_G.Compat.ChattynatorLoaded then
        GRM.chattynator.CreateChattynatorTab(customName);
        GRM.chattynator.CleanupChattynatorTabs();
    else
        -- Core Blizzard logic to create a new window
        local frame = FCF_OpenNewWindow(customName , true);     -- True is necessary to keep Blizz from default SAY,YELL, GUILD, etc to channel

        -- Now we configure them
        FCF_CopyChatSettings(frame, DEFAULT_CHAT_FRAME);
        FCF_DockUpdate();
        -- GRM actions - Add the names and set the reporting logic to GRM database
        GRM_Chat.AddReportChannel(customName, frame, false);
    end

    -- Update the options editbox
    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetText(
        GRM_UI.GeneralTab.BuildMultiChannelString());

    -- Helpful message to players
    if #GRM.S().reportChannel == 1 and #UnconfirmedChatTabs == 1 then
        GRM.Report(GRM.L("GRM will automatically send messages to the \"{name}\" window if you close this one.",
            DEFAULT_CHAT_FRAME.name));
    elseif #GRM.S().reportChannel > 1 then
        GRM.Report(GRM.L(
            "GRM will automatically send messages to the \"{name}\" window if you remove all custom channels.",
            DEFAULT_CHAT_FRAME.name));
    end

    -- Close the window...
    GRM_UI.GRM_RosterConfirmFrame:Hide();

    table.remove(UnconfirmedChatTabs, 1);

    -- recursively repeat this as needed
    if #UnconfirmedChatTabs > 0 then
        GRM.InitiateConfirmFrame(
            GRM.L("\"{name}\" Chat Window\nDo you wish to create it?", UnconfirmedChatTabs[1]),
            GRM_Chat.CreateChatTabs(), nil, nil, GRM_Chat.CancelChatTabCreation, true);
    end
end

-- Method:          GRM_Chat.CancelChatTabCreation()
-- What it Does:    Cancels this action, and removes the channel tab name
-- Purpose:         UX quality control
GRM_Chat.CancelChatTabCreation = function()
    if #GRM.S().reportChannel == 0 then
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetText(
            DEFAULT_CHAT_FRAME.name);
    else
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetText(
            GRM_UI.GeneralTab.BuildMultiChannelString());
    end
    table.remove(UnconfirmedChatTabs, 1);
    if #UnconfirmedChatTabs > 0 then
        GRM.InitiateConfirmFrame(
            GRM.L("\"{name}\" Chat Window\nDo you wish to create it?", UnconfirmedChatTabs[1]),
            GRM_Chat.CreateChatTabs(), nil, nil, GRM_Chat.CancelChatTabCreation, true);
    end
end

-- Method:          GRM_Chat.SetReportWindow()
-- What it Does:    Sets the addon reporting to a specified custom channel
-- Purpose:         Allow flexibility to send GRM reports to a custom channel so you don't miss anything.
GRM_Chat.SetReportWindow = function(count)
    local isEstablished = false;
    local chatFrame;
    count = count or 1;
    local removedChannels = {};

    if not IsInGuild() then
        GRM_G.Chat = {DEFAULT_CHAT_FRAME};
        return;
    end

    if not GRM_G.Compat.ChattynatorInitialized then
        GRM_G.Compat.ChattynatorInitialized = true;
        GRM.chattynator.IsChattynatorLoaded();  -- Establishes Chattynator Compatibility
    end

    for i = #GRM.S().reportChannel, 1, -1 do
        isEstablished = false;

        if GRM_G.Compat.ChattynatorLoaded then
            local wIndex, tIndex, tabName = GRM.chattynator.GetChattynatorTab(GRM.S().reportChannel[i]);
            if wIndex and tIndex then
                isEstablished = true;
                GRM.chattynator.SetReportChannel(wIndex, tIndex, tabName);
            end
        else
            for j = 1, #CHAT_FRAMES do
                chatFrame = _G[CHAT_FRAMES[j]];

                if chatFrame ~= nil and chatFrame.name == GRM.S().reportChannel[i] then
                    -- Custom frame writte, custom frame found! Now, let's see if there is a tab

                    if _G[CHAT_FRAMES[j] .. "Tab"]:IsVisible() then
                        isEstablished = true;

                        GRM_Chat.AddReportChannel(nil, chatFrame, true); -- Just adds it to the GRM_G.Chat
                        break
                    end

                end
            end
        end

        if not isEstablished then
            if count < 5 then
                C_Timer.After(2, function()
                    count = count + 1;
                    GRM_Chat.SetReportWindow(count); -- Some redundancy before I go and start removing channels.
                    return;
                end);
            else
                -- After 10 seconds of trying...
                table.insert(removedChannels , GRM.S().reportChannel[i])
            end
        end
    end

    -- Let's initialize all the Chattynator channels that exist
    if GRM_G.Compat.ChattynatorLoaded then
        GRM.chattynator.InitializeTabsForGRM();
    end

    if #removedChannels > 0 then
        MissingChatTabs(removedChannels);
        return;
    end

    if #GRM.S().reportChannel == 0 then
        GRM_G.Chat = {DEFAULT_CHAT_FRAME};
    end
end

-- Method:          GRM_Chat.AddReportChannel ( string , object , bool )
-- What it Does:    Adds the custom channel to the saved data so it can be stored on each subsequent session
-- Purpose:         Quality of Life control to user to report info to more than 1 window.
GRM_Chat.AddReportChannel = function(name, newFrame, onlyFrame)
    local isFound = false;

    if not onlyFrame then
        for i = 1, #GRM.S().reportChannel do
            if GRM.S().reportChannel[i] == name then
                isFound = true;
                break
            end
        end

        if not isFound then
            table.insert(GRM.S().reportChannel, name);
        end

        isFound = false;
    end

    if newFrame then

        for i = 1, #GRM_G.Chat do
            if GRM_G.Chat[i] == newFrame then
                isFound = true;
                break
            end
        end

        if not isFound then
            table.insert(GRM_G.Chat, newFrame);
        end
    end
end

-- Method:          GRM_Chat.EstablishNewCustomReportWindow();
-- What it Does:    Takes a new custom one and determines if there is a window, and if there is no window asks the player if they wish to create a GRM channel
-- Purpose:         Quality of Life feature for creating custom Window to send reports to.
GRM_Chat.EstablishNewCustomReportWindow = function(channelNames)
    local isEstablished = false;
    local chatFrame;
    local channels = ParseMultiChannelString(channelNames);
    UnconfirmedChatTabs = {};

    -- No need to do the work if it is already set to default
    if #channels > 0 then
        -- Let's Confirm the frames

        for i = 1, #channels do
            isEstablished = false;

            if GRM_G.Compat.ChattynatorLoaded then
                local wIndex, tIndex, tabName = GRM.chattynator.GetChattynatorTab(channels[i]);
                if wIndex and tIndex then
                    isEstablished = true;
                    GRM.chattynator.SetReportChannel(wIndex, tIndex, tabName);
                end
            else
                for j = 1, #CHAT_FRAMES do
                    chatFrame = GetClickFrame(CHAT_FRAMES[j]);

                    if chatFrame and chatFrame.name == channels[i] then
                        -- Custom frame writte, custom frame found! Now, let's see if there is a tab

                        if GetClickFrame(chatFrame:GetName() .. "Tab"):IsVisible() then
                            isEstablished = true;
                            GRM_Chat.AddReportChannel(channels[i], chatFrame, false);
                            break
                        end

                    end
                end
            end

            if not isEstablished then
                table.insert(UnconfirmedChatTabs, channels[i]); -- These are custom chat tabs that don't exist yet and need to be built. Storing them so they can be qued up.
            else
                if GRM_G.Compat.ChattynatorLoaded then
                    GRM_Chat.AddReportChannel(channels[i], nil, false); -- Just adds it to the GRM_G.Chat
                else
                    for j = 1, #CHAT_FRAMES do
                        chatFrame = GetClickFrame(CHAT_FRAMES[j]);

                        if chatFrame and chatFrame.name == channels[i] then
                            GRM_Chat.AddReportChannel(channels[i], chatFrame, false);
                            break;

                        end
                    end
                end
            end
        end

        if #UnconfirmedChatTabs > 0 then
            -- Popup window logic...
            if #UnconfirmedChatTabs == 1 then
                GRM.InitiateConfirmFrame(GRM.L("\"{name}\" Chat Window\nDo you wish to create it?",
                UnconfirmedChatTabs[1]), GRM_Chat.CreateChatTabs, nil, nil, GRM_Chat.CancelChatTabCreation, true);
            else
                 local createMultipleTabs = function()
                    for i = 1 , #UnconfirmedChatTabs do
                        if GRM_G.Compat.ChattynatorLoaded then
                            GRM.chattynator.CreateChattynatorTab(UnconfirmedChatTabs[i]);
                        else
                            local frame = FCF_OpenNewWindow(UnconfirmedChatTabs[i] , true);
                            FCF_CopyChatSettings(frame, DEFAULT_CHAT_FRAME);
                            table.insert ( GRM_G.Chat , frame );
                            FCF_DockUpdate();
                        end
                    end
                    UnconfirmedChatTabs = {};
                    GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ReportDestinationEditBox:SetText(GRM_UI.GeneralTab.BuildMultiChannelString());

                    if GRM_G.Compat.ChattynatorLoaded then
                        GRM.chattynator.CleanupChattynatorTabs();
                    end
                end
                local missingChannels = UnconfirmedChatTabs[1];
                for i = 2 ,#UnconfirmedChatTabs do
                    missingChannels = missingChannels .. ", " .. UnconfirmedChatTabs[i];
                end
                local text = GRM.L ( "The following Custom Chat Windows for GRM appear to be missing:" ) .. "\n" .. missingChannels .. "\n\n" .. GRM.L ("Would you like to recreate these chat windows for messages unique to the GRM addon?" );
                GRM.InitiateConfirmFrame(text, createMultipleTabs, nil, nil, nil, true, 350 , 175 , false);

            end
        end
    else
        GRM.S().reportChannel = {};
        GRM_G.Chat = {DEFAULT_CHAT_FRAME};
    end

    CleanupUnusedChannels(channels);
end