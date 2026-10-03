local ColorPicker = {};
GRM_UI.ColorPicker = ColorPicker;

-- ColorPicker Controls
GRM_G.MainTagColor = false;
GRM_G.MainTagHexCode = "";
GRM_G.mainTag = "";
GRM_G.altTag = "";
GRM_G.CurrentTagColorBox = 0;

GRM_G.NicknameTagColor = false;
GRM_G.NickTagHexCode = "";
GRM_G.nickTag = "";

ColorPicker.CreateColorPicker = function(name, parent, anchorFrame, colorTableKey)
    local picker = CreateFrame("Frame", name, parent, BackdropTemplateMixin and "BackdropTemplate")
    picker:SetSize(18, 18)
    picker:SetPoint("LEFT", anchorFrame, "RIGHT", 10, 0)
    picker:SetBackdrop(GRM_UI_Util.GetBackdrop(3))
    picker.ConnectedTo = "";

    GRM.CreateTexture(picker, "GRM_OptionsTexture", "ARTWORK", true)
    
    picker:SetScript("OnShow", function(self)
        self.GRM_OptionsTexture:SetPoint("CENTER", self)
        self.GRM_OptionsTexture:SetSize(15, 15)
        local c = GRM.S()[self.ConnectedTo]
        self.GRM_OptionsTexture:SetColorTexture(c.r, c.g, c.b, 1.0)
    end)

    picker:SetScript("OnHide", function(self)
        self.ConnectedTo = "";
    end)

    picker:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            GRM.RestoreTooltip()
            local c = GRM.S()[self.ConnectedTo]
            GRM_UI.ShowCustomColorPicker(c.r, c.g, c.b, 1.0, (colorTableKey == "mainTagColor" and 98 or 99)) -- 98 for Main, 99 for Nickname
            
            -- Standard sizing logic
            if GRM.IsAddOnLoaded("ColorPickerPlus") then
                GRM_UI.ColorPickerFrame:SetSize(380, 380)
            elseif GRM.IsAddOnLoaded("ColorPickerAdvanced") then
                GRM_UI.ColorPickerFrame.hasOpacity = true;
                GRM_UI.ColorPickerFrame.opacity = 1
            elseif GRM.IsAddOnLoaded("ElvUI") then
                GRM_UI.ColorPickerFrame:SetSize(345, 240)
            else
                GRM_UI.ColorPickerFrame:SetSize(305, 230)
            end
        end
    end)

    picker:SetScript("OnEnter", function(self)
        GRM_UI.SetTooltipScale()
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        GameTooltip:AddLine("|CFFE6CC7F" .. GRM.L("Click") .. "|r - " .. GRM.L("Customize Color"))
        GameTooltip:Show()
    end)

    picker:SetScript("OnLeave", GRM.RestoreTooltip)
end

-- Method:          ColorPicker.ShowCustomColorPicker ( float , float , float , float , int , function )
-- What it Does:    Established some default values for the colorpicker frame, and then shows it
-- Purpose:         One, to configure the color picker frames, and /grmtwo, to create a universally recyclable function for all potential future colorpicker options as well.
ColorPicker.ShowCustomColorPicker = function ( r , g , b , a , setting )

    if not GRM_UI.ColorPickerFrame.visited then
        if GRM_UI.ColorPickerFrame.Content then
            GRM_UI.ColorPickerFrame.Content.ColorSwatchOriginal:SetColorTexture ( r , g , b );
            GRM_UI.ColorPickerFrame.Content.ColorPicker:SetColorRGB ( r , g , b );
        else
            ColorPickerFrame:SetColorRGB ( r , g , b );
        end
        GRM_UI.ColorPickerFrame.previousValues = { r , g , b , a };
        GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:Hide();

        if setting == 98 then
            GRM_G.MainTagColor = true
        else
            GRM_G.CurrentTagColorBox = setting;
        end

        if not GRM_UI.ColorPickerFrame:IsVisible() then
            GRM_UI.ColorPickerFrame:Show();
        else
            ColorPicker.ColorPicker_OnShow();
        end
    else
        GRM.SetConfirmationWindow ( ReloadUI , GRM.L ( "To access the color wheel, due to a compatibility issue that began in 10.2.5, you will need to reload the UI. Do you wish to reload now?" ) , nil , { 350 , 120 } );
    end
end

-- Some addons have changed the frames completely, this removes GRM's extra frames.
ColorPicker.ColorPicker_OnShow = function()
    local OptionsFrame = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame;

    if GRM_G.MainTagColor or GRM_G.CurrentTagColorBox > 0 then

        GRM_UI.ColorPickerFrame.GRM_ColorPickerButtonConfirm:Show();
        GRM_UI.ColorPickerFrame.GRM_ColorPickerButtonCancel:Show();

        if GRM.IsAddOnLoaded ( "ColorPickerAdvanced" ) or GRM.IsAddOnLoaded ( "ColorPickerPlus" ) or GRM.IsAddOnLoaded ( "ElvUI" ) then
            OptionsFrame.GRM_ColorPickerR:Hide();
            OptionsFrame.GRM_ColorPickerB:Hide();
            OptionsFrame.GRM_ColorPickerG:Hide();
        else
            local r , g , b = GRM_UI.ColorPickerFrame:GetColorRGB();
            OptionsFrame.GRM_ColorPickerR:SetText ( math.floor ( r * 255 ) );
            OptionsFrame.GRM_ColorPickerR:Show();
            OptionsFrame.GRM_ColorPickerG:SetText ( math.floor ( g * 255 ) );
            OptionsFrame.GRM_ColorPickerG:Show();
            OptionsFrame.GRM_ColorPickerB:SetText ( math.floor ( b * 255 ) );
            OptionsFrame.GRM_ColorPickerB:Show();
        end
    else
        GRM_UI.ColorPickerFrame.visited = true;
        GRM_UI.ColorPickerFrame.GRM_ColorPickerButtonConfirm:Hide();
        GRM_UI.ColorPickerFrame.GRM_ColorPickerButtonCancel:Hide();
        OptionsFrame.GRM_ColorPickerR:Hide();
        OptionsFrame.GRM_ColorPickerB:Hide();
        OptionsFrame.GRM_ColorPickerG:Hide();
    end

    if GRM_UI.ColorPickerFrame:GetHeight() < 275 then
        C_Timer.After ( 0.05 , function()
            GRM_UI.ColorPickerFrame:SetHeight(275);
        end)
    end
end

local ColorPickHideScript = function()

    if GRM_G.MainTagColor or GRM_G.CurrentTagColorBox > 0 then

        if GRM_G.MainTagColor then
            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame.GRM_OptionsTexture:SetColorTexture ( GRM_UI.ColorPickerFrame.previousValues[1] , GRM_UI.ColorPickerFrame.previousValues[2] , GRM_UI.ColorPickerFrame.previousValues[3] , GRM_UI.ColorPickerFrame.previousValues[4] );
            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetTextColor ( GRM_UI.ColorPickerFrame.previousValues[1] , GRM_UI.ColorPickerFrame.previousValues[2] , GRM_UI.ColorPickerFrame.previousValues[3] , GRM_UI.ColorPickerFrame.previousValues[4] );

        elseif GRM_G.CurrentTagColorBox > 0 then
            GRM_UI.UpdateLogFilterTextColor ( GRM_UI.ColorPickerFrame.previousValues[1] , GRM_UI.ColorPickerFrame.previousValues[2] , GRM_UI.ColorPickerFrame.previousValues[3] , GRM_G.CurrentTagColorBox );
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame[ "colorBoxTexture" .. GRM_G.CurrentTagColorBox ]:SetColorTexture ( GRM_UI.ColorPickerFrame.previousValues[1] , GRM_UI.ColorPickerFrame.previousValues[2] , GRM_UI.ColorPickerFrame.previousValues[3] , 1 );
        end

        GRM_G.MainTagColor = false;
        GRM_G.CurrentTagColorBox = 0;
    end
end

local ColorPickerHide = function()
    GRM_UI.ColorPickerFrame:Hide();
end

-- Method:          ColorSelectFrameTextureUpdate()
-- What it Does:    When on the ColorPickerWindow from the Options, this is the logic that updates on the fly and saves the colors as you go.
-- Purpose:         To establish the proper RGB coloring of the text in the General options tab
local ColorSelectFrameTextureUpdate = function()
    local r , g , b = GRM_UI.ColorPickerFrame:GetColorRGB();
    local OptionsFrame = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame;

    -- Texture Box
    if GRM_G.MainTagColor and OptionsFrame.GRM_GeneralOptionsFrame:IsVisible() then
        OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame.GRM_OptionsTexture:SetColorTexture ( r , g , b , 1 );
        -- color for the box AND the dropdown selection on tag format
        OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetTextColor ( r , g , b , 1 );

    elseif GRM_G.CurrentTagColorBox > 0 then
        GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame[ "colorBoxTexture" .. GRM_G.CurrentTagColorBox ]:SetColorTexture ( r , g , b , 1 );
        GRM_UI.UpdateLogFilterTextColor ( r , g , b , GRM_G.CurrentTagColorBox );

    end

    if OptionsFrame.GRM_ColorPickerR:IsVisible() then
        OptionsFrame.GRM_ColorPickerR:SetText ( math.floor ( r * 255 ) );
        OptionsFrame.GRM_ColorPickerR:Show();
        OptionsFrame.GRM_ColorPickerG:SetText ( math.floor ( g * 255 ) );
        OptionsFrame.GRM_ColorPickerG:Show();
        OptionsFrame.GRM_ColorPickerB:SetText ( math.floor ( b * 255 ) );
        OptionsFrame.GRM_ColorPickerB:Show();
    end
end

local ColorPickScript = function()
    if GRM_G.MainTagColor or GRM_G.CurrentTagColorBox > 0 then
        local r , g , b = GRM_UI.ColorPickerFrame:GetColorRGB();
        GRM_UI.ColorPickerFrame.previousValues = { r , g , b , 1 };
        if GRM_G.MainTagColor then

            GRM.S().mainTagColor.r = r;
            GRM.S().mainTagColor.g = g;
            GRM.S().mainTagColor.b = b;
            GRM.RefreshMainTagHexCode();
            GRM_UI.NamesTab.UpdateTagOptionsText();
            -- Update the dropdown window color too
            GRM_UI.GRM_CoreFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetTextColor ( r , g , b , 1 );

        elseif GRM_G.CurrentTagColorBox > 0 then
            GRM.S().logColor[GRM_G.CurrentTagColorBox][1] = r;
            GRM.S().logColor[GRM_G.CurrentTagColorBox][2] = g;
            GRM.S().logColor[GRM_G.CurrentTagColorBox][3] = b;

            if GRM_G.CurrentTagColorBox == 15 and GRM_G.HardcoreActive then
                GRM_G.HardcoreHexCode = GRM.rgbToHex ( { GRM.ConvertRGBScale ( r , true ) , GRM.ConvertRGBScale ( g , true ) , GRM.ConvertRGBScale ( b , true ) } );
            end

            GRM_UI.UpdateLogFilterTextColor ( r , g , b , GRM_G.CurrentTagColorBox );
            GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame[ "colorBoxTexture" .. GRM_G.CurrentTagColorBox ]:SetColorTexture ( r , g , b , 1 );

            GRM.BuildLogComplete ( true , true , true );
        end
    end
    GRM_UI.ColorPickerFrame:Hide();
end

ColorPicker.InitializeColorPicker = function()
    -- Build the base frame out
    if not GRM_UI.ColorPickerFrame then
        local OptionsFrame = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame;

        GRM_UI.ColorPickerFrame = ColorPickerFrame;
        GRM_UI.ColorPickerFrame.colorTimer = 0;
        GRM_UI.ColorPickerFrame.visited = false;  -- Only change if non GRM visit
        OptionsFrame.GRM_ColorPickerR = CreateFrame ( "EditBox" , "GRM_ColorPickerR" , GRM_UI.ColorPickerFrame , BackdropTemplateMixin and "BackdropTemplate" );
        OptionsFrame.GRM_ColorPickerG = CreateFrame ( "EditBox" , "GRM_ColorPickerG" , GRM_UI.ColorPickerFrame , BackdropTemplateMixin and "BackdropTemplate" );
        OptionsFrame.GRM_ColorPickerB = CreateFrame ( "EditBox" , "GRM_ColorPickerB" , GRM_UI.ColorPickerFrame , BackdropTemplateMixin and "BackdropTemplate" );
        OptionsFrame.GRM_ColorPickerR.GRM_R_Text = OptionsFrame.GRM_ColorPickerR:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
        OptionsFrame.GRM_ColorPickerG.GRM_G_Text = OptionsFrame.GRM_ColorPickerG:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
        OptionsFrame.GRM_ColorPickerB.GRM_B_Text = OptionsFrame.GRM_ColorPickerB:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );

           -- Color window... let's make it moveable!
        GRM_UI.ColorPickerFrame:EnableMouse ( true );
        GRM_UI.ColorPickerFrame:SetMovable ( true );
        GRM_UI.ColorPickerFrame:RegisterForDrag ( "LeftButton" );
        GRM_UI.ColorPickerFrame:SetScript ( "OnDragStart" , function()
            if GRM.ColorPickerFrame(3):IsMouseOver( 0.5 , -0.5 , -0.5 , 0.5 ) and not GRM.ColorPickerFrame(2):IsMouseOver( 1 , -1 , -1 , 1 ) then
                GRM_UI.ColorPickerFrame:StartMoving();
            end
        end);
        GRM_UI.ColorPickerFrame:SetScript ( "OnDragStop" , GRM_UI.ColorPickerFrame.StopMovingOrSizing );

        GRM_UI.ColorPickerFrame:HookScript ( "OnHide" , ColorPickHideScript )
        -- Fill in the edit boxes
        GRM_UI.ColorPickerFrame:HookScript ( "OnShow" , ColorPicker.ColorPicker_OnShow );

        GRM_UI.ColorPickerFrame:HookScript ( "OnMouseDown" , function()
            if GRM_G.MainTagColor or GRM_G.CurrentTagColorBox > 0 then

                if OptionsFrame.GRM_ColorPickerR:IsVisible() then
                    if not OptionsFrame.GRM_ColorPickerB:IsMouseOver( 1 , -1 , -1 , 1 ) and
                       not OptionsFrame.GRM_ColorPickerG:IsMouseOver( 1 , -1 , -1 , 1 ) and
                       not OptionsFrame.GRM_ColorPickerR:IsMouseOver( 1 , -1 , -1 , 1 ) then
                           OptionsFrame.GRM_ColorPickerB:ClearFocus();
                           OptionsFrame.GRM_ColorPickerG:ClearFocus();
                           OptionsFrame.GRM_ColorPickerR:ClearFocus();
                    end
                end
            end
        end);

        GRM_UI.ColorPickerFrame:HookScript ( "OnUpdate" , function ( self , elapsed )
            self.colorTimer = self.colorTimer + elapsed;

            if self.colorTimer > 0.05 then

                if ( GRM_G.MainTagColor or GRM_G.CurrentTagColorBox > 0 ) and
                  not OptionsFrame.GRM_ColorPickerB:HasFocus() and
                  not OptionsFrame.GRM_ColorPickerG:HasFocus() and
                  not OptionsFrame.GRM_ColorPickerR:HasFocus() then
                    ColorSelectFrameTextureUpdate();
                  end
                self.colorTimer = 0;
            end
        end);

        -- Let's also establish the RGB editboxes
        OptionsFrame.GRM_ColorPickerB.GRM_B_Text:SetPoint ( "BOTTOMLEFT" , GRM.ColorPickerFrame(2) , "BOTTOM" , 135 , 10 );
        OptionsFrame.GRM_ColorPickerB.GRM_B_Text:SetText ( "B" );
        OptionsFrame.GRM_ColorPickerG.GRM_G_Text:SetPoint ( "BOTTOM" , OptionsFrame.GRM_ColorPickerB.GRM_B_Text , "TOP" , 0 , 5 );
        OptionsFrame.GRM_ColorPickerG.GRM_G_Text:SetText ( "G" );
        OptionsFrame.GRM_ColorPickerR.GRM_R_Text:SetPoint ( "BOTTOM" , OptionsFrame.GRM_ColorPickerG.GRM_G_Text , "TOP" , 0 , 5 );
        OptionsFrame.GRM_ColorPickerR.GRM_R_Text:SetText ( "R" );
        OptionsFrame.GRM_ColorPickerR:SetSize ( 42 , 18 );
        OptionsFrame.GRM_ColorPickerR:SetPoint ( "Left" , OptionsFrame.GRM_ColorPickerR.GRM_R_Text , "RIGHT" , 3 , 0 );
        OptionsFrame.GRM_ColorPickerR:SetAutoFocus ( false );
        OptionsFrame.GRM_ColorPickerR:ClearFocus();
        OptionsFrame.GRM_ColorPickerR:SetTextInsets( 5 , 5 , 3 , 3 );
        OptionsFrame.GRM_ColorPickerR:SetFontObject ( "GameFontNormal" );
        OptionsFrame.GRM_ColorPickerR:EnableMouse( true );
        OptionsFrame.GRM_ColorPickerR:SetJustifyH ( "LEFT" );
        OptionsFrame.GRM_ColorPickerR:SetNumeric ( true );
        OptionsFrame.GRM_ColorPickerR:SetMaxLetters ( 3 );
        OptionsFrame.GRM_ColorPickerR:SetBackdrop ( GRM_UI.noteBackdrop2 );

        OptionsFrame.GRM_ColorPickerR:SetScript ( "OnEscapePressed" , function ( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            self:ClearFocus();
        end);

        OptionsFrame.GRM_ColorPickerR:SetScript ( "OnEnterPressed" , function ( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
                GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "RGB Values Must be Between 1 and 255." ) );
            end
            local getVal = function()
                return
                    tonumber ( OptionsFrame.GRM_ColorPickerR:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerG:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerB:GetText() ) / 255
            end
            GRM_UI.ColorPickerFrame.Content.ColorSwatchOriginal:SetColorTexture ( getVal() );
            GRM_UI.ColorPickerFrame.Content.ColorPicker:SetColorRGB ( getVal() );
            self:ClearFocus();
        end);

        OptionsFrame.GRM_ColorPickerR:SetScript ( "OnEditFocusGained" , function( self )
            self:HighlightText ( 0 );
        end);
        OptionsFrame.GRM_ColorPickerR:SetScript ( "OnEditFocusLost" , function( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            self:HighlightText ( 0 , 0 );
        end);
        OptionsFrame.GRM_ColorPickerR:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            local getVal = function()
                return
                    tonumber ( OptionsFrame.GRM_ColorPickerR:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerG:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerB:GetText() ) / 255
            end
            GRM_UI.ColorPickerFrame.Content.ColorSwatchOriginal:SetColorTexture ( getVal() );
            GRM_UI.ColorPickerFrame.Content.ColorPicker:SetColorRGB ( getVal() );
            ColorSelectFrameTextureUpdate();
            if IsShiftKeyDown() then
                OptionsFrame.GRM_ColorPickerB:SetFocus();
            else
                OptionsFrame.GRM_ColorPickerG:SetFocus();
            end
        end);

        OptionsFrame.GRM_ColorPickerB:SetSize ( 42 , 18 );
        OptionsFrame.GRM_ColorPickerB:SetPoint ( "Left" , OptionsFrame.GRM_ColorPickerB.GRM_B_Text , "RIGHT" , 4 , 0 );
        OptionsFrame.GRM_ColorPickerB:SetAutoFocus ( false );
        OptionsFrame.GRM_ColorPickerB:ClearFocus();
        OptionsFrame.GRM_ColorPickerB:SetTextInsets( 5 , 5 , 3 , 3 );
        OptionsFrame.GRM_ColorPickerB:SetFontObject ( "GameFontNormal" );
        OptionsFrame.GRM_ColorPickerB:EnableMouse( true );
        OptionsFrame.GRM_ColorPickerB:SetJustifyH ( "LEFT" );
        OptionsFrame.GRM_ColorPickerB:SetNumeric ( true );
        OptionsFrame.GRM_ColorPickerB:SetMaxLetters ( 3 );
        OptionsFrame.GRM_ColorPickerB:SetBackdrop ( GRM_UI.noteBackdrop2 );

        OptionsFrame.GRM_ColorPickerB:SetScript ( "OnEscapePressed" , function ( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            self:ClearFocus();
        end);

        OptionsFrame.GRM_ColorPickerB:SetScript ( "OnEnterPressed" , function ( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
                GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "RGB Values Must be Between 1 and 255." ) );
            end
            local getVal = function()
                return
                    tonumber ( OptionsFrame.GRM_ColorPickerR:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerG:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerB:GetText() ) / 255
            end
            GRM_UI.ColorPickerFrame.Content.ColorSwatchOriginal:SetColorTexture ( getVal() );
            GRM_UI.ColorPickerFrame.Content.ColorPicker:SetColorRGB ( getVal() );
            self:ClearFocus();
        end);

        OptionsFrame.GRM_ColorPickerB:SetScript ( "OnEditFocusGained" , function( self )
            self:HighlightText ( 0 );
        end);
        OptionsFrame.GRM_ColorPickerB:SetScript ( "OnEditFocusLost" , function( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            self:HighlightText ( 0 , 0 );
        end);
        OptionsFrame.GRM_ColorPickerB:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            local getVal = function()
                return
                    tonumber ( OptionsFrame.GRM_ColorPickerR:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerG:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerB:GetText() ) / 255
            end
            GRM_UI.ColorPickerFrame.Content.ColorSwatchOriginal:SetColorTexture ( getVal() );
            GRM_UI.ColorPickerFrame.Content.ColorPicker:SetColorRGB ( getVal() );
            ColorSelectFrameTextureUpdate();
            if IsShiftKeyDown() then
                OptionsFrame.GRM_ColorPickerG:SetFocus();
            else
                OptionsFrame.GRM_ColorPickerR:SetFocus();
            end
        end);

        OptionsFrame.GRM_ColorPickerG:SetSize ( 42 , 18 );
        OptionsFrame.GRM_ColorPickerG:SetPoint ( "Left" , OptionsFrame.GRM_ColorPickerG.GRM_G_Text , "RIGHT" , 3 , 0 );
        OptionsFrame.GRM_ColorPickerG:SetAutoFocus ( false );
        OptionsFrame.GRM_ColorPickerG:ClearFocus();
        OptionsFrame.GRM_ColorPickerG:SetTextInsets( 5 , 5 , 3 , 3 );
        OptionsFrame.GRM_ColorPickerG:SetFontObject ( "GameFontNormal" );
        OptionsFrame.GRM_ColorPickerG:EnableMouse( true );
        OptionsFrame.GRM_ColorPickerG:SetJustifyH ( "LEFT" );
        OptionsFrame.GRM_ColorPickerG:SetNumeric ( true );
        OptionsFrame.GRM_ColorPickerG:SetMaxLetters ( 3 );
        OptionsFrame.GRM_ColorPickerG:SetBackdrop ( GRM_UI.noteBackdrop2 );

        OptionsFrame.GRM_ColorPickerG:SetScript ( "OnEscapePressed" , function ( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            self:ClearFocus();
        end);

        OptionsFrame.GRM_ColorPickerG:SetScript ( "OnEnterPressed" , function ( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
                GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "RGB Values Must be Between 1 and 255." ) );
            end
            local getVal = function()
                return
                    tonumber ( OptionsFrame.GRM_ColorPickerR:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerG:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerB:GetText() ) / 255
            end
            GRM_UI.ColorPickerFrame.Content.ColorSwatchOriginal:SetColorTexture ( getVal() );
            GRM_UI.ColorPickerFrame.Content.ColorPicker:SetColorRGB ( getVal() );
            self:ClearFocus();
        end);

        OptionsFrame.GRM_ColorPickerG:SetScript ( "OnEditFocusGained" , function( self )
            self:HighlightText ( 0 );
        end);
        OptionsFrame.GRM_ColorPickerG:SetScript ( "OnEditFocusLost" , function( self )
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            self:HighlightText ( 0 , 0 );
        end);
        OptionsFrame.GRM_ColorPickerG:SetScript ( "OnTabPressed" , function ( self )
            self:ClearFocus();
            if self:GetText() == "" then
                self:SetText( "0" );
            elseif tonumber ( self:GetText() ) > 255 then
                self:SetText( "255" );
            end
            local getVal = function()
                return
                    tonumber ( OptionsFrame.GRM_ColorPickerR:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerG:GetText() ) / 255 ,
                    tonumber ( OptionsFrame.GRM_ColorPickerB:GetText() ) / 255
            end
            GRM_UI.ColorPickerFrame.Content.ColorSwatchOriginal:SetColorTexture ( getVal() );
            GRM_UI.ColorPickerFrame.Content.ColorPicker:SetColorRGB ( getVal() );
            ColorSelectFrameTextureUpdate();
            if IsShiftKeyDown() then
                OptionsFrame.GRM_ColorPickerR:SetFocus();
            else
                OptionsFrame.GRM_ColorPickerB:SetFocus();
            end
        end);
    end

    -- New Colorpickerframebuttons
    local w,h = GRM.ColorPickerFrame(1):GetSize();
    local left,pinFrame,right,x,y = GRM.ColorPickerFrame(1):GetPoint();
    GRM_UI.CreateButton ( "GRM_ColorPickerButtonConfirm" , GRM_UI.ColorPickerFrame , "UIPanelButtonTemplate" ,
                          GRM.L ( "Confirm" ) , w-15 , h , { left , pinFrame , right , x , y } , ColorPickScript ,
                          "GameFontNormal" , 13 , "CENTER" );
    GRM_UI.ColorPickerFrame.GRM_ColorPickerButtonConfirm:SetFrameStrata("FULLSCREEN");

    w,h = GRM.ColorPickerFrame(4):GetSize();
    left,pinFrame,right,x,y = GRM.ColorPickerFrame(4):GetPoint();
    GRM_UI.CreateButton ( "GRM_ColorPickerButtonCancel" , GRM_UI.ColorPickerFrame , "UIPanelButtonTemplate" ,
                          GRM.L ( "Cancel" ), w-15 , h , { left , pinFrame , right , x , y } , ColorPickerHide ,
                          "GameFontNormal" , 13 , "CENTER" );
    GRM_UI.ColorPickerFrame.GRM_ColorPickerButtonCancel:SetFrameStrata("FULLSCREEN");

    local OptionsFrame = GRM_UI.GRM_CoreFrame.GRM_OptionsFrame;
    OptionsFrame.GRM_ColorPickerR.GRM_R_Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 16 );
    OptionsFrame.GRM_ColorPickerG.GRM_G_Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 16 );
    OptionsFrame.GRM_ColorPickerB.GRM_B_Text:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 16 );
    
    
    

end
