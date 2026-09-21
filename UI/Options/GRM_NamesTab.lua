-- Pending Code
local NamesTab = {};
GRM_UI.NamesTab = NamesTab;

GRM_UI.BuildNamesTab = function()
    if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame then

        -- BUILD NAMES OPTIONS PAGE
        GRM_UI.MainOrNicknameCheckButton = function(self)
            if self:GetChecked() then
                GRM.S().showMainName = true;
            else
                GRM.S().showMainName = false;
            end
        end

        GRM_UI.GRM_ShowMainAltTagsButtonScript = function( self )
            if self:GetChecked() then
                GRM.S().useMainTag = true;
            else
                GRM.S().useMainTag = false;
            end
        end

        GRM_UI.GRM_ShowNicknameButtonScript = function( self )
            if self:GetChecked() then
                GRM.S().showNickname = true;
                GRM_UI.EnableNicknameOptions(true);
            else
                GRM.S().showNickname = false;
                GRM_UI.EnableNicknameOptions(false);
            end
        end

        GRM_UI.GRM_ShowNicknameInsteadButtonScript = function( self )
            if self:GetChecked() then
                GRM.S().showNicknameNotMain = true;
            else
                GRM.S().showNicknameNotMain = false;
            end
        end

        GRM_UI.NicknameInsteadTT = function(self)
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine ( GRM.L ( "Main name will still show if no nickname has been set" ) );
            GameTooltip:Show();
        end

        GRM_UI.GRM_AppendNicknameScript = function( self )
            if self:GetChecked() then
                GRM.S().ShowNicknameToAll = true;
            else
                GRM.S().ShowNicknameToAll = false;
            end
        end

        GRM_UI.GRM_ShareNicknameButtonScript = function( self )
            if self:GetChecked() then
                GRM.S().shareNickToAlts = true;
            else
                GRM.S().shareNickToAlts = false;
            end
        end

        GRM_UI.UpdateTagOptionsText = function()
            local text = GRM.L ( "Show both {name} and {name2} tags in Chat" , GRM.GetCurrentMainTag() , GRM.GetCurrentAltTag() );
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowMainAltTagsButton.GRM_ShowMainAltTagsButtonText:SetText(text);
            GRM.NormalizeHitRects(GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowMainAltTagsButton,GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowMainAltTagsButton.GRM_ShowMainAltTagsButtonText);
        end

        GRM_UI.EnableNicknameOptions = function( enable )
            if enable then
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameInsteadButton:Enable();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameInsteadButton.GRM_ShowNicknameInsteadButtonText:SetTextColor(1,0.82,0);
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameToAll:Enable();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameToAll.GRM_ShowNicknameToAllText:SetTextColor(1,0.82,0);
            else
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameInsteadButton:Disable();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameInsteadButton.GRM_ShowNicknameInsteadButtonText:SetTextColor(0.5,0.5,0.5);
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameToAll:Disable();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameToAll.GRM_ShowNicknameToAllText:SetTextColor(0.5,0.5,0.5);
            end
        end
    end

    GRM_UI.CreateCoreFrame ( "GRM_NamesOptionsFrame" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame , nil , 600 , 480 , nil , false , { "BOTTOMLEFT" ,  "BOTTOMLEFT" , 0 , 0 } , nil , false , false );

    GRM_UI.CreateString ( "GRM_NameOptionsTitle" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , "GameFontNormal" , GRM.L ( "Main and Alt Formatting" ) .. ":" , 20 , { "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , "TOPLEFT" , 18 , - 30 } , nil , { 0.0 , 0.8 , 1.0 } );

    GRM_UI.CreateCheckBox ( "GRM_ShowMainAltTagsButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_NameOptionsTitle , "BOTTOMLEFT" , -4 , -4 } , GRM_UI.GRM_ShowMainAltTagsButtonScript , "" , "GameFontNormal" , 12 );

    GRM_UI.CreateCheckBox ( "GRM_ShowMainNameCheckButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowMainAltTagsButton , "BOTTOMLEFT" , 0 , -6 } , GRM_UI.MainOrNicknameCheckButton , GRM.L ("Show Main Name in Chat") , "GameFontNormal" , 12 );

    GRM_UI.CreateString ( "GRM_NicknameOptionsTitle" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , "GameFontNormal" , GRM.L ( "Nicknames" ) .. ":" , 20 , { "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowMainNameCheckButton , "BOTTOMLEFT" , 4 , - 10 } , nil , { 0.0 , 0.8 , 1.0 } );

    GRM_UI.CreateString ( "GRM_NicknameOptionsPending" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , "GameFontNormal" , "(" .. string.upper(GRM.L ( "Pending Feature" )).. ")" , 14 , { "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_NicknameOptionsTitle , "RIGHT" , 15 , 0 } , nil , { 1 , 0 , 0 } );

    GRM_UI.CreateCheckBox ( "GRM_ShowNicknameButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_NicknameOptionsTitle , "BOTTOMLEFT" , -4 , -4 } , GRM_UI.GRM_ShowNicknameButtonScript , GRM.L ( "Show Nickname in Chat") , "GameFontNormal" , 12 );

    GRM_UI.CreateCheckBox ( "GRM_ShowNicknameInsteadButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameButton , "BOTTOMRIGHT" , 0 , -6 } , GRM_UI.GRM_ShowNicknameInsteadButtonScript , GRM.L ( "Show Nickname instead of Main name") , "GameFontNormal" , 12 , GRM_UI.NicknameInsteadTT , GRM.RestoreTooltip );

    GRM_UI.CreateCheckBox ( "GRM_ShowNicknameToAll" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameInsteadButton , "BOTTOMLEFT" , 0 , -6 } , GRM_UI.GRM_AppendNicknameScript , GRM.L ("Append My Public Nickname to My Guild Messages" ) , "GameFontNormal" , 12 );

    GRM_UI.CreateCheckBox ( "GRM_ShareNicknamesButton" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , nil , nil , { "TOPRIGHT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowNicknameToAll , "BOTTOMLEFT" , 0 , -6 } , GRM_UI.GRM_ShareNicknameButtonScript , GRM.L ( "Share Nickname Across All Grouped Alts" ) , "GameFontNormal" , 12 );

    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame:SetScript ( "OnShow" , function()
        GRM_G.SettingsTabFocus = GRM_ENUM.OPTIONS_TABS.NAMES;
        GRM_UI.GRM_RosterChangeLogFrame.GRM_RosterChangeLogFrameReScale:Show();
    end);

    if not GRM_ColorSelectOptionsFrame then
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame = CreateFrame ( "Frame" , "GRM_ColorSelectOptionsFrame" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , BackdropTemplateMixin and "BackdropTemplate" );

        GRM.CreateTexture ( GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame , "GRM_OptionsTexture" , "ARTWORK" , true );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame:SetBackdrop ( {
            bgFile = nil,
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 32,
            edgeSize = 9,
            insets = { left = -2 , right = -2 , top = -3 , bottom = -2 }
        } );

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame:CreateFontString ( nil , "OVERLAY" , "GameFontNormalSmall" );
        -- Main Name Format
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected = CreateFrame ( "Frame" , "GRM_MainTagFormatSelected" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame , "InsetFrameTemplate" );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:Hide();
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu = CreateFrame ( "Frame" , "GRM_MainTagFormatMenu" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected , "InsetFrameTemplate" );


        -- COLOR PICKER!!!
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected , "RIGHT" , 5 , 0 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame:SetSize ( 18 , 18 );

        -- color box texture
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnShow" , function( self )
            self.GRM_OptionsTexture:SetPoint ( "CENTER" , self );
            self.GRM_OptionsTexture:SetSize( 15 , 15 );
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame.GRM_OptionsTexture:SetColorTexture ( GRM.S().mainTagColor.r , GRM.S().mainTagColor.g , GRM.S().mainTagColor.b , 1.0 );
        end);

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnMouseDown" , function ( _ , button )
            if button == "LeftButton" then
                GRM.RestoreTooltip();
                GRM_UI.ShowCustomColorPicker ( GRM.S().mainTagColor.r , GRM.S().mainTagColor.g , GRM.S().mainTagColor.b , 1.0 , 98 );
                if GRM.IsAddOnLoaded ( "ColorPickerPlus" ) then
                    GRM_UI.ColorPickerFrame:SetSize ( 380 , 380 );
                elseif GRM.IsAddOnLoaded ( "ColorPickerAdvanced" ) then
                    GRM_UI.ColorPickerFrame.hasOpacity = true;
                    GRM_UI.ColorPickerFrame.opacity = 1;
                elseif GRM.IsAddOnLoaded ( "ElvUI" ) then
                    GRM_UI.ColorPickerFrame:SetSize ( 345 , 240 );
                else
                    GRM_UI.ColorPickerFrame:SetSize ( 305 , 230 );
                end
            end
        end);

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnEnter" , function( self )
            GRM_UI.SetTooltipScale();
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            GameTooltip:AddLine( "|CFFE6CC7F" .. GRM.L ( "Click" ) .. "|r - " .. GRM.L ( "Customize Color" ) );
            GameTooltip:Show();
        end);

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ColorSelectOptionsFrame:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end)

        -- Main Format settings
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatText:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_ShowMainAltTagsButton.GRM_ShowMainAltTagsButtonText , "RIGHT" , 18 , 0 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:SetPoint ( "LEFT" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatText , "RIGHT" , 1.0 , 1.5 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:SetSize (  90 , 18 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetPoint ( "CENTER" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetWidth ( 130 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:SetPoint ( "TOP" , GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected , "BOTTOM" );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:SetWidth ( 90 );
        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:SetFrameStrata ( "DIALOG" );

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:SetScript ( "OnKeyDown" , function ( self , key )
            if not GRM_G.inCombat then
                self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
                if key == "ESCAPE" then
                    self:SetPropagateKeyboardInput ( false );
                    self:Hide();
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:Show();
                end
            elseif key == "ESCAPE" then
                self:Hide();
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:Show();
            end
        end);

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnShow" , function()
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:Hide();
        end)

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnMouseDown" , function( _ , button )
            if button == "LeftButton" then
                if  GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:IsVisible() then
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:Hide();
                else
                    GRM_UI.DD.PopulateMainTagDropdown();
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:Show();
                end
            end
        end);

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnEnter" , function( self )
            if not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:IsVisible() and not GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatMenu:IsVisible() then
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
                GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r to Change Display Format" ) );
                GameTooltip:AddLine( GRM.L ( "This also will change the <Alt> format to match" ) );
                GameTooltip:Show();
            end
        end);

        GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end)
    end

    -- Set font and text
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatText:SetText ( "|cffff0000<>|r " .. GRM.L ( "Format:" ) );
    GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_NamesOptionsFrame.GRM_MainTagFormatSelected.GRM_TagText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );









end