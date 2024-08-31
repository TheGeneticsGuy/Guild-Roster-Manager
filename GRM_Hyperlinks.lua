
local HL = {}
local HyperLinksInitialized = false;

-- Globals
GRM.HL = HL;

-- Method:          HL.InitializeHyperlinks()
-- What it Does:    Iniitializes the chat window to support hyperlinks
-- Purpose:         Create a way to set hyperlinks so players can easily access some GRM features by clicking the chat window on occasion.
HL.InitializeHyperlinks = function()

    if not HyperLinksInitialized then
        HyperLinksInitialized = true;

    -- Hook into the chat frame to capture the click
        for i = 1, NUM_CHAT_WINDOWS do
            local chatFrame = _G["ChatFrame"..i]
            if chatFrame:GetScript("OnHyperlinkClick") then
                chatFrame.OriginalOnHyperlinkClick = chatFrame:GetScript( "OnHyperlinkClick" )
            end
            chatFrame:SetScript ( "OnHyperlinkClick" , HL.HyperlinkClick )
        end

    end
end

-- Method:          HL.GenerateHyperlink ( string , string , [string] , string , [string] )
-- What it Does:    Returns a hyperlink of text built with your parameters.
-- Purpose:         Useful for custom actions through hyperlinks in chat.
HL.GenerateHyperlink = function ( linkType , arg1 , arg2 , text , textColorHex )
    if not linkType or not arg1 then
        return;
    end

    HL.InitializeHyperlinks();

    textColorHex = textColorHex or "00ff00";

    local hyperlinkText = "|H" .. linkType .. ":" .. arg1;

    if arg2 and arg2 ~= "" then
        hyperlinkText = hyperlinkText .. ":" .. arg2;
    end

    hyperlinkText = hyperlinkText .. "|h|cff" .. textColorHex .. "[" .. text .. "]|r|h";

    return hyperlinkText;
end

-- Method:          HL.HyperlinkClick ( ... )
-- What it Does:    Activates the action of the hyperlink clicked for all GRM hyperlinks.
-- Purpose:         Quality of life for GRM
HL.HyperlinkClick = function ( self , link , text , button )

    if button == "LeftButton" then
        local linkType , arg1  = strsplit( ":" , link );

        if linkType == "GRM" then

            if arg1 == "openPlayer" then
                -- Call the function to open your window here
                GRM.OpenPlayerWindow ( string.match ( string.match ( text , "%[(.-)%]" ) , "|cff%x%x%x%x%x%x(.-)|r$" ) );   -- Double regex match to keep it easier to read

            elseif arg1 == "profReport" then
                GRM.Prof.ReportPlayersNotUpdated();

            end
        else
            self:OriginalOnHyperlinkClick( link , text , button)
        end
    end
end

