local NamesTab = {};
GRM_UI.NamesTab = NamesTab;

local isLoaded = false;

-- Dropdown Data
local mainFormatOptions = {
    "Smashy (Do not modify chat)",
    "Smashy <A> (Arkaan <M>)",
    "Smashy <A>",
    "Smashy (Arkaan)",
    "Smashy <Arkaan>"
}

local nickFormatOptions = {
    "Smashy (Boss)",
    "Smashy <Boss>",
    "Smashy ~Boss~",
    "*Boss* (Replace Character Name)"
}

local function OnNickFormatSelected(index)
    GRM.S().nicknameFormat = index
    NamesTab.UpdateText()
end

local function OnMainFormatSelected(index)
    GRM.S().nameFormat = index
    NamesTab.UpdateText()
end

local function AppendNickScript(self)
    GRM.S().ShowNicknameToAll = self:GetChecked()
end

NamesTab.BuildNamesTab = function()
    local optionsFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame;  

    GRM_UI.CreateCoreFrame("GRM_NamesOptionsFrame", optionsFrame, nil, GRM_ENUM.OPTIONS_SIZE.W, GRM_ENUM.OPTIONS_SIZE.H, nil, false, {"BOTTOMLEFT", "BOTTOMLEFT", 0, 0}, nil, false, false)
    local namesOptionsFrame = optionsFrame.GRM_NamesOptionsFrame

    ---------------------------------------
    -- SECTION 1 - MAIN / ALT FORMATTING --
    ---------------------------------------
    
    -- Title & Description
    GRM_UI.CreateString("GRM_NameOptionsTitle", namesOptionsFrame, "GameFontNormal", GRM.L("Main and Alt Formatting") .. ":", 20,
                        {"TOPLEFT", namesOptionsFrame, "TOPLEFT", 18, -30}, nil, {0.0, 0.8, 1.0})
    GRM_UI.CreateString("GRM_NameOptionsDesc", namesOptionsFrame, "GameFontWhite", GRM.L("How should an Alt appear in chat when they don't have a Nickname?"),
                        12, {"TOPLEFT", namesOptionsFrame.GRM_NameOptionsTitle, "BOTTOMLEFT", 5, -10})
    GRM_UI.CreateDropDownMenu("GRM_MainFormatDD", namesOptionsFrame, nil, {"TOPLEFT", namesOptionsFrame.GRM_NameOptionsDesc, "BOTTOMLEFT", 0, -15},
                              {220, 25}, mainFormatOptions, 12, {1, 1, 1}, nil, nil, OnMainFormatSelected, nil, nil, true)
    
    -- Live Preview & Color Picker
    GRM_UI.CreateString("GRM_MainLivePreview", namesOptionsFrame, "GameFontWhite", "", 12, {"LEFT", namesOptionsFrame.GRM_MainFormatDDSelected, "RIGHT", 15, 0})
    GRM_UI.ColorPicker.CreateColorPicker("GRM_MainColorPicker", namesOptionsFrame, namesOptionsFrame.GRM_MainLivePreview, "mainTagColor")

    -------------------------------------
    -- SECTION 2 - Nickname Formatting --
    -------------------------------------

    -- Title & Description
    GRM_UI.CreateString("GRM_NickOptionsTitle", namesOptionsFrame, "GameFontNormal", GRM.L("Nickname Formatting") .. ":", 20,
                       {"TOPLEFT", namesOptionsFrame.GRM_MainFormatDDSelected, "BOTTOMLEFT", -5, -40}, nil, {0.0, 0.8, 1.0})
    GRM_UI.CreateString("GRM_NickOptionsDesc", namesOptionsFrame, "GameFontWhite",
                        GRM.L("If a player has a Nickname, how should they appear in chat? (Overrides Main/Alt format)"), 12,
                       {"TOPLEFT", namesOptionsFrame.GRM_NickOptionsTitle, "BOTTOMLEFT", 5, -10})
    GRM_UI.CreateDropDownMenu("GRM_NickFormatDD", namesOptionsFrame, nil, {"TOPLEFT", namesOptionsFrame.GRM_NickOptionsDesc, "BOTTOMLEFT", 0, -15},
                              {220, 25}, nickFormatOptions, 12, {1, 1, 1}, nil, nil, OnNickFormatSelected, nil, nil, true)
    
    -- Live Preview & Color Picker
    GRM_UI.CreateString("GRM_NickLivePreview", namesOptionsFrame, "GameFontWhite", "", 12, {"LEFT", namesOptionsFrame.GRM_NickFormatDDSelected, "RIGHT", 15, 0})
    GRM_UI.ColorPicker.CreateColorPicker("GRM_NickColorPicker", namesOptionsFrame, namesOptionsFrame.GRM_NickLivePreview, "nicknameTagColor")

    ------------------------------------
    -- SECTION 3 - Behavioral Setting --
    ------------------------------------

    GRM_UI.CreateString("GRM_NickBehaviorTitle", namesOptionsFrame, "GameFontNormal", GRM.L("Global Behavior") .. ":", 16,
                       {"TOPLEFT", namesOptionsFrame.GRM_NickFormatDDSelected, "BOTTOMLEFT", -5, -40}, nil, {0.0, 0.8, 1.0})
    GRM_UI.CreateCheckBox("GRM_ShowNicknameToAll", namesOptionsFrame, nil, nil,
                         {"TOPLEFT", namesOptionsFrame.GRM_NickBehaviorTitle, "BOTTOMLEFT", 0, -10},
                          AppendNickScript, GRM.L("Append My Public Nickname to My Guild Messages"), "GameFontNormal", 12)


    if not isLoaded then
        namesOptionsFrame:SetScript("OnShow", function()
            GRM_G.SettingsTabFocus = GRM_ENUM.OPTIONS_TABS.NAMES
            GRM_UI.GRM_RosterChangeLogFrame.GRM_RosterChangeLogFrameReScale:Show()
        end)

        -------------
        -- HELPERS --
        -------------

        NamesTab.GetPreviewString = function(type, index)
            local toon = "Smashy"
            local main = "Arkaan"
            local nick = "Boss"
            local altTag = GRM.GetCurrentAltTag()
            local mainTag = GRM.GetCurrentMainTag()
            
            local c1 = GRM.Core.RGBToHex(GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b)
            local c2 = GRM.Core.RGBToHex(GRM.S().nicknameTagColor.r, GRM.S().nicknameTagColor.g, GRM.S().nicknameTagColor.b)
            local reset = "|r"

            if type == "MAIN" then
                if index == 1 then return "[Guild] [" .. toon .. "]: Hello!" end
                if index == 2 then return "[Guild] [" .. toon .. " " .. c1 .. altTag .. reset .. " " .. c1 .. "(" .. main .. " " .. mainTag .. ")" .. reset .. "]: Hello!" end
                if index == 3 then return "[Guild] [" .. toon .. " " .. c1 .. altTag .. reset .. "]: Hello!" end
                if index == 4 then return "[Guild] [" .. toon .. " " .. c1 .. "(" .. main .. ")" .. reset .. "]: Hello!" end
                if index == 5 then return "[Guild] [" .. toon .. " " .. c1 .. "<" .. main .. ">" .. reset .. "]: Hello!" end
            elseif type == "NICK" then
                if index == 1 then return "[Guild] [" .. toon .. " " .. c2 .. "(" .. nick .. ")" .. reset .. "]: Hello!" end
                if index == 2 then return "[Guild] [" .. toon .. " " .. c2 .. "<" .. nick .. ">" .. reset .. "]: Hello!" end
                if index == 3 then return "[Guild] [" .. toon .. " " .. c2 .. "~" .. nick .. "~" .. reset .. "]: Hello!" end
                if index == 4 then return "[Guild] [" .. c2 .. "*" .. nick .. "*" .. reset .. "]: Hello!" end
            end
            return ""
        end

        




    end





    -- Trigger the text update function to set initial states
    NamesTab.UpdateText()
end

-- =======================================================
-- UPDATE FUNCTION (Called on load and when dropdowns/colors change)
-- =======================================================
NamesTab.UpdateText = function()
    local frame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame
    if not frame then return end

    -- Sync Checkboxes
    frame.GRM_ShowNicknameToAll:SetChecked(GRM.S().ShowNicknameToAll)

    -- Force the Dropdown text to match the current DB selection (vital for when the UI first loads)
    -- Main/Alt Options array hardcoded here just for the labels
    local mainOpts = {"Smashy (Do not modify chat)", "Smashy <A> (Arkaan <M>)", "Smashy <A>", "Smashy (Arkaan)", "Smashy <Arkaan>"}
    local nickOpts = {"Smashy (Boss)", "Smashy <Boss>", "Smashy ~Boss~", "*Boss* (Replace Character Name)"}
    
    frame.GRM_MainFormatDDSelected.GRM_MainFormatDDSelectedText:SetText(mainOpts[GRM.S().nameFormat] or mainOpts[2])
    frame.GRM_NickFormatDDSelected.GRM_NickFormatDDSelectedText:SetText(nickOpts[GRM.S().nicknameFormat] or nickOpts[1])

    -- Update Live Previews
    frame.GRM_MainLivePreview:SetText(NamesTab.GetPreviewString("MAIN", GRM.S().nameFormat))
    frame.GRM_NickLivePreview:SetText(NamesTab.GetPreviewString("NICK", GRM.S().nicknameFormat))
    
    -- Ensure Color Pickers update if colors changed
    if frame.GRM_MainColorPicker:IsVisible() then
        frame.GRM_MainColorPicker:GetScript("OnShow")(frame.GRM_MainColorPicker)
    end
    if frame.GRM_NickColorPicker:IsVisible() then
        frame.GRM_NickColorPicker:GetScript("OnShow")(frame.GRM_NickColorPicker)
    end
end

-- Expose GetPreviewString so it can be called from UpdateText
NamesTab.GetPreviewString = function(type, index)
    local toon = "Smashy"
    local main = "Arkaan"
    local nick = "Boss"
    local altTag = GRM.GetCurrentAltTag()
    local mainTag = GRM.GetCurrentMainTag()
    
    local c1 = GRM.Core.RGBToHex(GRM.S().mainTagColor.r, GRM.S().mainTagColor.g, GRM.S().mainTagColor.b)
    local c2 = GRM.Core.RGBToHex(GRM.S().nicknameTagColor.r, GRM.S().nicknameTagColor.g, GRM.S().nicknameTagColor.b)
    local reset = "|r"

    if type == "MAIN" then
        if index == 1 then return "[Guild] [" .. toon .. "]: Hello!" end
        if index == 2 then return "[Guild] [" .. toon .. " " .. c1 .. altTag .. reset .. " " .. c1 .. "(" .. main .. " " .. mainTag .. ")" .. reset .. "]: Hello!" end
        if index == 3 then return "[Guild] [" .. toon .. " " .. c1 .. altTag .. reset .. "]: Hello!" end
        if index == 4 then return "[Guild] [" .. toon .. " " .. c1 .. "(" .. main .. ")" .. reset .. "]: Hello!" end
        if index == 5 then return "[Guild] [" .. toon .. " " .. c1 .. "<" .. main .. ">" .. reset .. "]: Hello!" end
    elseif type == "NICK" then
        if index == 1 then return "[Guild] [" .. toon .. " " .. c2 .. "(" .. nick .. ")" .. reset .. "]: Hello!" end
        if index == 2 then return "[Guild] [" .. toon .. " " .. c2 .. "<" .. nick .. ">" .. reset .. "]: Hello!" end
        if index == 3 then return "[Guild] [" .. toon .. " " .. c2 .. "~" .. nick .. "~" .. reset .. "]: Hello!" end
        if index == 4 then return "[Guild] [" .. c2 .. "*" .. nick .. "*" .. reset .. "]: Hello!" end
    end
    return ""
end



-- local NamesTab = {};
-- GRM_UI.NamesTab = NamesTab;

-- NamesTab.BuildNamesTab = function()
--     if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame then

--         -- BUILD NAMES OPTIONS PAGE
--         NamesTab.MainOrNicknameCheckButton = function(self)
--             if self:GetChecked() then
--                 GRM.S().showMainName = true;
--             else
--                 GRM.S().showMainName = false;
--             end
--         end

--         NamesTab.GRM_ShowMainAltTagsButtonScript = function( self )
--             if self:GetChecked() then
--                 GRM.S().useMainTag = true;
--             else
--                 GRM.S().useMainTag = false;
--             end
--         end

--         NamesTab.GRM_ShowNicknameButtonScript = function( self )
--             if self:GetChecked() then
--                 GRM.S().showNickname = true;
--                 NamesTab.EnableNicknameOptions(true);
--             else
--                 GRM.S().showNickname = false;
--                 NamesTab.EnableNicknameOptions(false);
--             end
--         end

--         NamesTab.GRM_ShowNicknameInsteadButtonScript = function( self )
--             if self:GetChecked() then
--                 GRM.S().showNicknameNotMain = true;
--             else
--                 GRM.S().showNicknameNotMain = false;
--             end
--         end

--         NamesTab.NicknameInsteadTT = function(self)
--             GRM_UI.SetTooltipScale();
--             GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
--             GameTooltip:AddLine ( GRM.L ( "Main name will still show if no nickname has been set" ) );
--             GameTooltip:Show();
--         end

--         NamesTab.GRM_AppendNicknameScript = function( self )
--             if self:GetChecked() then
--                 GRM.S().ShowNicknameToAll = true;
--             else
--                 GRM.S().ShowNicknameToAll = false;
--             end
--         end

--         NamesTab.GRM_ShareNicknameButtonScript = function( self )
--             if self:GetChecked() then
--                 GRM.S().shareNickToAlts = true;
--             else
--                 GRM.S().shareNickToAlts = false;
--             end
--         end

--         NamesTab.UpdateTagOptionsText = function()
--             local nameOpts = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame;

--             nameOpts.GRM_ShowMainAltTagsButton.GRM_ShowMainAltTagsButtonText:SetText(GRM.L ( "Show both {name} and {name2} tags in Chat" , GRM.GetCurrentMainTag() , GRM.GetCurrentAltTag() ));
--             GRM.NormalizeHitRects(nameOpts.GRM_ShowMainAltTagsButton, nameOpts.GRM_ShowMainAltTagsButton.GRM_ShowMainAltTagsButtonText);
--         end

--         NamesTab.EnableNicknameOptions = function( enable )
--             local nameOpts = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame
--             if enable then
--                 nameOpts.GRM_ShowNicknameInsteadButton:Enable();
--                 nameOpts.GRM_ShowNicknameInsteadButton.GRM_ShowNicknameInsteadButtonText:SetTextColor(1,0.82,0);
--                 nameOpts.GRM_ShowNicknameToAll:Enable();
--                 nameOpts.GRM_ShowNicknameToAll.GRM_ShowNicknameToAllText:SetTextColor(1,0.82,0);
--             else
--                 nameOpts.GRM_ShowNicknameInsteadButton:Disable();
--                 nameOpts.GRM_ShowNicknameInsteadButton.GRM_ShowNicknameInsteadButtonText:SetTextColor(0.5,0.5,0.5);
--                 nameOpts.GRM_ShowNicknameToAll:Disable();
--                 nameOpts.GRM_ShowNicknameToAll.GRM_ShowNicknameToAllText:SetTextColor(0.5,0.5,0.5);
--             end
--         end
        
--     end

--     GRM_UI.CreateCoreFrame ( "GRM_NamesOptionsFrame" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame , nil , GRM_ENUM.OPTIONS_SIZE.W, GRM_ENUM.OPTIONS_SIZE.H , nil , false , { "BOTTOMLEFT" ,  "BOTTOMLEFT" , 0 , 0 } , nil , false , false );
--     local namesOptionsFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame

--     GRM_UI.CreateString ( "GRM_NameOptionsTitle" , namesOptionsFrame , "GameFontNormal" , GRM.L ( "Main and Alt Formatting" ) .. ":" , 20 , { "TOPLEFT" , namesOptionsFrame , "TOPLEFT" , 18 , - 30 } , nil , { 0.0 , 0.8 , 1.0 } );

--     GRM_UI.CreateCheckBox ( "GRM_ShowMainAltTagsButton" , namesOptionsFrame , nil , nil , { "TOPLEFT" , namesOptionsFrame.GRM_NameOptionsTitle , "BOTTOMLEFT" , -4 , -4 } , NamesTab.GRM_ShowMainAltTagsButtonScript , "" , "GameFontNormal" , 12 );

--     GRM_UI.CreateCheckBox ( "GRM_ShowMainNameCheckButton" , namesOptionsFrame , nil , nil , { "TOPLEFT" , namesOptionsFrame.GRM_ShowMainAltTagsButton , "BOTTOMLEFT" , 0 , -6 } , NamesTab.MainOrNicknameCheckButton , GRM.L ("Show Main Name in Chat") , "GameFontNormal" , 12 );

--     GRM_UI.CreateString ( "GRM_NicknameOptionsTitle" , namesOptionsFrame , "GameFontNormal" , GRM.L ( "Nicknames" ) .. ":" , 20 , { "TOPLEFT" , namesOptionsFrame.GRM_ShowMainNameCheckButton , "BOTTOMLEFT" , 4 , - 10 } , nil , { 0.0 , 0.8 , 1.0 } );

--     GRM_UI.CreateString ( "GRM_NicknameOptionsPending" , namesOptionsFrame , "GameFontNormal" , "(" .. string.upper(GRM.L ( "Pending Feature" )).. ")" , 14 , { "LEFT" , namesOptionsFrame.GRM_NicknameOptionsTitle , "RIGHT" , 15 , 0 } , nil , { 1 , 0 , 0 } );

--     GRM_UI.CreateCheckBox ( "GRM_ShowNicknameButton" , namesOptionsFrame , nil , nil , { "TOPLEFT" , namesOptionsFrame.GRM_NicknameOptionsTitle , "BOTTOMLEFT" , -4 , -4 } , NamesTab.GRM_ShowNicknameButtonScript , GRM.L ( "Show Nickname in Chat") , "GameFontNormal" , 12 );

--     GRM_UI.CreateCheckBox ( "GRM_ShowNicknameInsteadButton" , namesOptionsFrame , nil , nil , { "TOPLEFT" , namesOptionsFrame.GRM_ShowNicknameButton , "BOTTOMRIGHT" , 0 , -6 } , NamesTab.GRM_ShowNicknameInsteadButtonScript , GRM.L ( "Show Nickname instead of Main name") , "GameFontNormal" , 12 , NamesTab.NicknameInsteadTT , GRM.RestoreTooltip );

--     GRM_UI.CreateCheckBox ( "GRM_ShowNicknameToAll" , namesOptionsFrame , nil , nil , { "TOPLEFT" , namesOptionsFrame.GRM_ShowNicknameInsteadButton , "BOTTOMLEFT" , 0 , -6 } , NamesTab.GRM_AppendNicknameScript , GRM.L ("Append My Public Nickname to My Guild Messages" ) , "GameFontNormal" , 12 );

--     GRM_UI.CreateCheckBox ( "GRM_ShareNicknamesButton" , namesOptionsFrame , nil , nil , { "TOPRIGHT" , namesOptionsFrame.GRM_ShowNicknameToAll , "BOTTOMLEFT" , 0 , -6 } , NamesTab.GRM_ShareNicknameButtonScript , GRM.L ( "Share Nickname Across All Grouped Alts" ) , "GameFontNormal" , 12 );

--     if not namesOptionsFrame.configured then
--         namesOptionsFrame.configured = true;
--         namesOptionsFrame:SetScript ( "OnShow" , function()
--             GRM_G.SettingsTabFocus = GRM_ENUM.OPTIONS_TABS.NAMES;
--             GRM_UI.GRM_RosterChangeLogFrame.GRM_RosterChangeLogFrameReScale:Show();
--         end);
--     end

--     if not namesOptionsFrame.GRM_ColorSelectOptionsFrame then
--         namesOptionsFrame.GRM_ColorSelectOptionsFrame = CreateFrame ( "Frame" , "GRM_ColorSelectOptionsFrame" , namesOptionsFrame , BackdropTemplateMixin and "BackdropTemplate" );

--         GRM.CreateTexture ( namesOptionsFrame.GRM_ColorSelectOptionsFrame , "GRM_OptionsTexture" , "ARTWORK" , true );
--         namesOptionsFrame.GRM_ColorSelectOptionsFrame:SetBackdrop ( {
--             bgFile = nil,
--             edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
--             tile = true,
--             tileSize = 32,
--             edgeSize = 9,
--             insets = { left = -2 , right = -2 , top = -3 , bottom = -2 }
--         } );

--         namesOptionsFrame.GRM_MainTagFormatText = namesOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
--         -- Main Name Format
--         namesOptionsFrame.GRM_MainTagFormatSelected = CreateFrame ( "Frame" , "GRM_MainTagFormatSelected" , namesOptionsFrame , "InsetFrameTemplate" );
--         namesOptionsFrame.GRM_MainTagFormatSelected:Hide();
--         namesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText = namesOptionsFrame.GRM_MainTagFormatSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
--         namesOptionsFrame.GRM_MainTagFormatMenu = CreateFrame ( "Frame" , "GRM_MainTagFormatMenu" , namesOptionsFrame.GRM_MainTagFormatSelected , "InsetFrameTemplate" );


--         -- COLOR PICKER!!!
--         namesOptionsFrame.GRM_ColorSelectOptionsFrame:SetPoint ( "LEFT" , namesOptionsFrame.GRM_MainTagFormatSelected , "RIGHT" , 5 , 0 );
--         namesOptionsFrame.GRM_ColorSelectOptionsFrame:SetSize ( 18 , 18 );

--         -- color box texture
--         namesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnShow" , function( self )
--             self.GRM_OptionsTexture:SetPoint ( "CENTER" , self );
--             self.GRM_OptionsTexture:SetSize( 15 , 15 );
--             namesOptionsFrame.GRM_ColorSelectOptionsFrame.GRM_OptionsTexture:SetColorTexture ( GRM.S().mainTagColor.r , GRM.S().mainTagColor.g , GRM.S().mainTagColor.b , 1.0 );
--         end);

--         namesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnMouseDown" , function ( _ , button )
--             if button == "LeftButton" then
--                 GRM.RestoreTooltip();
--                 GRM_UI.ColorPicker.ShowCustomColorPicker ( GRM.S().mainTagColor.r , GRM.S().mainTagColor.g , GRM.S().mainTagColor.b , 1.0 , 98 );
--                 if GRM.IsAddOnLoaded ( "ColorPickerPlus" ) then
--                     GRM_UI.ColorPickerFrame:SetSize ( 380 , 380 );
--                 elseif GRM.IsAddOnLoaded ( "ColorPickerAdvanced" ) then
--                     GRM_UI.ColorPickerFrame.hasOpacity = true;
--                     GRM_UI.ColorPickerFrame.opacity = 1;
--                 elseif GRM.IsAddOnLoaded ( "ElvUI" ) then
--                     GRM_UI.ColorPickerFrame:SetSize ( 345 , 240 );
--                 else
--                     GRM_UI.ColorPickerFrame:SetSize ( 305 , 230 );
--                 end
--             end
--         end);

--         namesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnEnter" , function( self )
--             GRM_UI.SetTooltipScale();
--             GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
--             GameTooltip:AddLine( "|CFFE6CC7F" .. GRM.L ( "Click" ) .. "|r - " .. GRM.L ( "Customize Color" ) );
--             GameTooltip:Show();
--         end);

--         namesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnLeave" , function()
--             GRM.RestoreTooltip();
--         end)

--         -- Main Format settings
--         namesOptionsFrame.GRM_MainTagFormatText:SetPoint ( "LEFT" , namesOptionsFrame.GRM_ShowMainAltTagsButton.GRM_ShowMainAltTagsButtonText , "RIGHT" , 18 , 0 );
--         namesOptionsFrame.GRM_MainTagFormatSelected:SetPoint ( "LEFT" , namesOptionsFrame.GRM_MainTagFormatText , "RIGHT" , 1.0 , 1.5 );
--         namesOptionsFrame.GRM_MainTagFormatSelected:SetSize (  90 , 18 );
--         namesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetPoint ( "CENTER" , namesOptionsFrame.GRM_MainTagFormatSelected );
--         namesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetWidth ( 130 );
--         namesOptionsFrame.GRM_MainTagFormatMenu:SetPoint ( "TOP" , namesOptionsFrame.GRM_MainTagFormatSelected , "BOTTOM" );
--         namesOptionsFrame.GRM_MainTagFormatMenu:SetWidth ( 90 );
--         namesOptionsFrame.GRM_MainTagFormatMenu:SetFrameStrata ( "DIALOG" );

--         namesOptionsFrame.GRM_MainTagFormatMenu:SetScript ( "OnKeyDown" , function ( self , key )
--             if not GRM_G.inCombat then
--                 self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
--                 if key == "ESCAPE" then
--                     self:SetPropagateKeyboardInput ( false );
--                     self:Hide();
--                     namesOptionsFrame.GRM_MainTagFormatSelected:Show();
--                 end
--             elseif key == "ESCAPE" then
--                 self:Hide();
--                 namesOptionsFrame.GRM_MainTagFormatSelected:Show();
--             end
--         end);

--         namesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnShow" , function()
--             namesOptionsFrame.GRM_MainTagFormatMenu:Hide();
--         end)

--         namesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnMouseDown" , function( _ , button )
--             if button == "LeftButton" then
--                 if  namesOptionsFrame.GRM_MainTagFormatMenu:IsVisible() then
--                     namesOptionsFrame.GRM_MainTagFormatMenu:Hide();
--                 else
--                     GRM_UI.DD.PopulateMainTagDropdown();
--                     namesOptionsFrame.GRM_MainTagFormatMenu:Show();
--                 end
--             end
--         end);

--         namesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnEnter" , function( self )
--             if not namesOptionsFrame.GRM_MainTagFormatMenu:IsVisible() and not namesOptionsFrame.GRM_MainTagFormatMenu:IsVisible() then
--                 GRM_UI.SetTooltipScale();
--                 GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
--                 GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r to Change Display Format" ) );
--                 GameTooltip:AddLine( GRM.L ( "This also will change the <Alt> format to match" ) );
--                 GameTooltip:Show();
--             end
--         end);

--         namesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnLeave" , function()
--             GRM.RestoreTooltip();
--         end)
--     end

--     NamesTab.UpdateText();
-- end

-- -- Efficient text loading and configuring
-- NamesTab.UpdateText = function()
--     local namesOptionsFrame = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame
--     NamesTab.UpdateTagOptionsText();
--     -- Set font and text
--     namesOptionsFrame.GRM_MainTagFormatText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
--     namesOptionsFrame.GRM_MainTagFormatText:SetText ( "|cffff0000<>|r " .. GRM.L ( "Format:" ) );
--     namesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
-- end