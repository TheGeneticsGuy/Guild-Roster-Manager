-- UI BUILDING API

GRM_UI = {};
---------------------------------------
------ FRAME CREATION AND INIT --------
---------------------------------------

-- Method:          GRM_UI.CreateCoreFrame ( string , frame , frame , int , int , bool , string , table , bool , string )
-- What it Does:    Builds a frame for use in the GRM addon.
-- Purpose:         Reusable tool to build frames easily, and initialize them.
GRM_UI.CreateCoreFrame = function ( name , parentFrame , globalParent , width , height , templateName , isMovable , points , strata , addCloseButton , inCludeEscapeAction )

    if not parentFrame[name] then
        local finalFrame = {};
        local point = parentFrame;

        if globalParent then
            parentFrame[name] = CreateFrame ( "Frame" , name , globalParent , templateName );
            point = globalParent;

        else
            parentFrame[name] = CreateFrame ( "Frame" , name , parentFrame , templateName );
        end

        -- By pressing the ESC key the window closes.
        if inCludeEscapeAction then
            parentFrame[name]:SetScript ( "OnKeyDown" , function ( self , key )

                self:SetPropagateKeyboardInput ( true );
                if key == "ESCAPE" then
                    self:SetPropagateKeyboardInput ( false );
                    self:Hide();
                end
        
            end);
        end

        finalFrame = parentFrame[name];
        finalFrame:SetSize ( width , height );

        if points then
            finalFrame:SetPoint ( points[1] , point , points[2] , points[3] , points[4] );
        end        

        if strata then
            finalFrame:SetFrameStrata ( strata );
        end

        if isMovable then
            finalFrame:EnableMouse ( true );
            finalFrame:SetMovable ( true );
            finalFrame:SetToplevel ( true );
            finalFrame:RegisterForDrag ( "LeftButton" );
            finalFrame:SetScript ( "OnDragStart" , finalFrame.StartMoving );
            finalFrame:SetScript ( "OnDragStop" , function()
                finalFrame:StopMovingOrSizing();
                GRM_UI.SaveFramePosition( finalFrame );
            end);
        end

        if addCloseButton then
            local closeButtonName = name .. "CloseButton";
            finalFrame[closeButtonName] = CreateFrame( "Button" , closeButtonName , finalFrame , "UIPanelCloseButton" );
            finalFrame[closeButtonName]:SetPoint( "TOPRIGHT" , finalFrame , -1 , -1 );
        end

    end

end

-- Method:          GRM_UI.CreateString ( string , frame , string , string , int , { R,G,B} , text , int , bool )
-- What it Does:    Creates a font string with given parameters
-- Purpose:         Reusable font string creation tool.
GRM_UI.CreateString = function ( name , parentFrame , template , text , fontSize , points , Width , textColor , alignment , wrappable )

    if not parentFrame[name] then
        parentFrame[name] = parentFrame:CreateFontString ( nil , "OVERLAY" , template );
        parentFrame[name]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );

        if textColor then
            parentFrame[name]:SetTextColor ( textColor[1] , textColor[2] , textColor[3] );
        end
    
        if alignment then
            parentFrame[name]:SetJustifyH ( alignment );       -- Default is LEFT alignment
        end
    
        if Width then
            parentFrame[name]:SetWidth ( Width );
        end
    
        if wrappable then
            parentFrame[name]:SetWordWrap ( true );
            parentFrame[name]:SetSpacing ( 1 );
        else
            parentFrame[name]:SetWordWrap ( false );
        end
    end
    
    parentFrame[name]:SetText ( text );
    parentFrame[name]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );

end

-- Method:          GRM_UI.CreateButton ( string , frame , string , string , int , int , table , function , string , int , string , int )
-- What it Does:    Creates a button using whatever template you wish, as well as the added string
-- Purpose:         Reusable CreateButton tool
GRM_UI.CreateButton = function ( name , parentFrame , template , text , width , height , points , buttonScript , textTemplate , fontSize , alignment , pointModifier , heightModifier )

    local fontStringText = name.."Text";
    local indent = pointModifier or 10;
    local heightM = heightModifier or -5;

    if not parentFrame[name] then
        parentFrame[name] = CreateFrame ( "Button" , name , parentFrame , template );
        parentFrame[name]:SetSize ( width , height );
        parentFrame[name]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );
        parentFrame[name][fontStringText] = parentFrame[name]:CreateFontString ( nil , "OVERLAY" , textTemplate );
        parentFrame[name][fontStringText]:SetPoint ( "LEFT" , parentFrame[name] , "LEFT" , indent , heightM );
        parentFrame[name][fontStringText]:SetWidth ( width - 5 );
        parentFrame[name][fontStringText]:SetSpacing ( 1 );
        parentFrame[name][fontStringText]:SetWordWrap ( false );
        if alignment then
            parentFrame[name][fontStringText]:SetJustifyH ( alignment );
        else
            parentFrame[name][fontStringText]:SetJustifyH ( "LEFT" );
        end

        if buttonScript then
            parentFrame[name]:SetScript ( "OnClick" , function( self , button )
            
                if button == "LeftButton" then
                    buttonScript( self );
                end
            end);
        end
    end

    parentFrame[name][fontStringText]:SetText ( text );
    parentFrame[name][fontStringText]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );

end

-- Method:          GRM_UI.CreateHybridScrollFrame ( string , frame , int , int , string , int )
-- What it Does:    Builds out the frames for a Hybrid Scroll Frame
-- Purpose:         Cleanup code with reusable tool.
GRM_UI.CreateHybridScrollFrame = function ( scrollFrameName , parentFrame , width , height , points , template , refreshFunction )
    -- Build core frames to hold data and scroll

    if not parentFrame[scrollFrameName] then
        local borderName = scrollFrameName .. "Border";
        local childName = scrollFrameName .. "Child";
        local sliderName = scrollFrameName .. "Slider";
        parentFrame[scrollFrameName] = CreateFrame ( "ScrollFrame" , scrollFrameName , parentFrame );
        parentFrame[borderName] = CreateFrame ( "Frame" , borderName , parentFrame , template );
        parentFrame[childName] = CreateFrame ( "Frame" , childName );
        parentFrame[sliderName] = CreateFrame ( "Slider" , sliderName , parentFrame[scrollFrameName] , "UIPanelScrollBarTrimTemplate" );

        -- Scroll Frame Details
        parentFrame[borderName]:SetSize ( width , height );
        parentFrame[borderName]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );
        parentFrame[scrollFrameName]:SetSize ( width - 18 , height - 25 );
        parentFrame[scrollFrameName]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );
        parentFrame[scrollFrameName]:SetScrollChild ( parentFrame[childName] );
        parentFrame[scrollFrameName]:SetHitRectInsets ( 0 , -24 , 0 , 0 );

        parentFrame[childName]:EnableMouse ( true );
        parentFrame[childName]:RegisterForDrag ( "LeftButton" );
        parentFrame[childName]:SetScript ( "OnDragStart" , function( self )
            if GetMouseFocus() == self then
                parentFrame:StartMoving();
            end
        end);

        parentFrame[childName]:SetScript ( "OnDragStop" , function()
            parentFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( parentFrame );
        end);

        parentFrame.Entries = {}; -- Create for list

        -- Slider Parameters
        parentFrame[sliderName]:SetOrientation( "VERTICAL" );
        parentFrame[sliderName]:SetSize ( 21 , height - 44 );
        parentFrame[sliderName]:SetPoint ( "TOPLEFT" , parentFrame[borderName] , "TOPRIGHT" , -5 , -25 );
        parentFrame[sliderName]:SetValueStep ( 25 );
        parentFrame[sliderName]:SetStepsPerPage ( ( ( height - 25 ) / 25 ) )
        parentFrame[sliderName].currentV = 0;
        parentFrame[sliderName]:SetScript( "OnValueChanged" , function( self , value )
            GRM.HybridScrollOnValueChangedConfig (
                self , value , parentFrame[childName] , parentFrame[scrollFrameName] , ( ( height - 25 ) / 25 ) , 25 , refreshFunction , parentFrame.Entries
            );

        end);
        parentFrame[sliderName]:SetValue( 0 );      -- Triggers value change
    end

end

-- Method:          GRM_UI.CreateEditBox ( string , frameObject, string , int , int , table , string , table , int , bool , function , function , function )
-- What it Does     Creates and configures the macro tool
-- Purpose:         Reusable tool to build editBoxes
GRM_UI.CreateEditBox = function ( name , parentFrame , template , width , height , points , alignment , textColor , maxLetters , numbersOnly , toolTipScript , ToolTipClearLogic , textChangedFunction , createClearButton )

    if not parentFrame[name] then
        parentFrame[name] = CreateFrame( "EditBox" , name , parentFrame , template );
        parentFrame[name]:ClearFocus();
        parentFrame[name].tempText = "";

        parentFrame[name]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );
        parentFrame[name]:SetSize ( width , height );
        parentFrame[name]:SetTextInsets ( 2 , 3 , 3 , 2 );
        parentFrame[name]:EnableMouse( true );
        parentFrame[name]:SetAutoFocus( false );

        if alignment then
            parentFrame[name]:SetJustifyH ( alignment );
        else
            parentFrame[name]:SetJustifyH ( "LEFT" );
        end

        if textColor then
            parentFrame[name]:SetTextColor ( textColor[1] , textColor[2] , textColor[3] );
        else
            parentFrame[name]:SetTextColor ( 1 , 1 , 1 );
        end

        if maxLetters then
            parentFrame[name]:SetMaxLetters ( maxLetters );
        end
        
        if numbersOnly then
            parentFrame[name]:SetNumeric ( true );
        else
            parentFrame[name]:SetNumeric ( false );
        end

        -- SCRIPTS
        if toolTipScript then
            parentFrame[name]:SetScript ( "OnEnter" , function( self )
                toolTipScript ( self );
            end);
        end
        parentFrame[name]:SetScript ( "OnLeave" , function()
            if ToolTipClearLogic then
                ToolTipClearLogic();
            else
                GameTooltip:Hide();
            end
        end);  
    
        parentFrame[name]:SetScript ( "OnEscapePressed" , function ( self )
            self:SetText ( parentFrame[name].tempText );
            self:ClearFocus();
        end);
    
        parentFrame[name]:SetScript ( "OnEnterPressed" , function ( self )
            self:ClearFocus();
        end);

        parentFrame[name]:SetScript ( "OnHide" , function ( self )
            parentFrame[name].tempText = "";
            self:SetText ( "" );
        end);

        parentFrame[name]:SetScript ( "OnEditFocusGained" , function ( self )
            self:HighlightText ( 0 );
            self:SetCursorPosition ( 0 );
            
            if ToolTipClearLogic then
                ToolTipClearLogic();
            else
                GameTooltip:Hide();
            end
        end);

        parentFrame[name]:SetScript ( "OnEditFocusLost" , function ( self )
            self:HighlightText ( 0 , 0 );
            self:SetText ( GRM.Trim ( self:GetText() ) );
    
            if self:GetText() == "" and textChangedFunction then
                textChangedFunction();
            end
    
            parentFrame[name].tempText = self:GetText();
        end)
    
        if textChangedFunction then
            parentFrame[name]:SetScript ( "OnTextChanged" , function ( self )
                textChangedFunction();
            end);
        end
    
        if createClearButton then
            local buttonName = name .. "ClearButton";
            local ClearButton = function()
                parentFrame[name]:SetText("");
                parentFrame[name]:ClearFocus();
                parentFrame[name][buttonName]:Hide(); 
            end

            GRM_UI.CreateButton ( buttonName , parentFrame[name] , nil , "X" , (height * 0.7) , (height * 0.7) , { "LEFT" , parentFrame[name] , "RIGHT" , 1 , 3 } , ClearButton , "GameFontWhite" , ( (height * 0.7) / 1.75 ) , "CENTER" , 2 );

            parentFrame[name][buttonName]:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );

            parentFrame[name][buttonName]:SetScript ( "OnEnter" , function ( self )
                self:LockHighlight();
            end);
            parentFrame[name][buttonName]:SetScript ( "OnLeave" , function ( self )
                self:UnlockHighlight();
            end);
            parentFrame[name]:SetScript ( "OnShow" , function ( self )
                if self:GetText() ~= "" then
                    self[buttonName]:Show();
                else
                    self[buttonName]:Hide();
                end
            end);
            parentFrame[name]:HookScript ( "OnTextChanged" , function( self )
                if self:GetText() ~= "" then
                    self[buttonName]:Show();
                else
                    self[buttonName]:Hide();
                end
            end);

        end
    end
end

-- Method:          GRM_UI.SaveFramePosition ( frameObject )
-- What it Does:    Stores the frame save position
-- Purpose:         Reusable code for saving frame positions and storing them between sessions.
GRM_UI.SaveFramePosition = function ( frame )
    local framePOS = { ["GRM_RosterFrame"] = "RosterFramePOS" };
    local side1, _ , side2 , point1 , point2 = frame:GetPoint();
    local savePoints = framePOS[frame:GetName()];

    if savePoints then
        GRM.S()[savePoints][1] = side1;
        GRM.S()[savePoints][2] = side2;
        GRM.S()[savePoints][3] = point1;
        GRM.S()[savePoints][4] = point2;
    end
    
end
