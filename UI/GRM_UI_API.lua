-- UI BUILDING API

--LIST OF UI API

-- GRM_UI.CreateCoreFrame
-- GRM_UI.CreateButton
-- GRM_UI.CreateEditBox
-- GRM_UI.CreateString
-- GRM_UI.CreateCheckBox
-- GRM_UI.CreateOptionsSlider
-- GRM_UI.CreateHybridScrollFrame
-- GRM_UI.CreateDropDownMenu

GRM_UI = {};    -- Global Access

-----------------------
-- UI API HELPERS -----
-----------------------

-- Method:          CreateTooltipFromTable ( table )
-- What it Does:    Creates a tooltip either single or double line
-- Purpose:         Ease of creating tooltips
-- Usage:           CreateTooltipFromTable ( { 1 , "Test" } )
--                  CreateTooltipFromTable ( { 1 , "Test" } , { 1 , Ghost } )
--                  CreateTooltipFromTable ( { 2 , "Double" , "Line" , 1 , 0.8 , 0 , 1 , 0 , 0 } )
local CreateTooltipFromTable = function ( self , ... )
    local lines = {...};

    if #lines > 0 then
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );

        for i = 1 , #lines do
            if lines[i][1] == 1 then
                for i = 1 , #lines do
                    if lines[i][3] then
                        GameTooltip:AddLine( lines[i][2] , lines[i][3] , lines[i][4] , lines[i][5] );
                    else
                        GameTooltip:AddLine( lines[i][2] );
                    end
                end
            -- 2 = Double line
            elseif lines[i][1] == 2 then
                for i = 1 , #lines do
                    -- Coloring for both lines
                    if lines[i][4] and lines[i][7] then
                        GameTooltip:AddDoubleLine( lines[i][2] , lines[i][3] , lines[i][4] , lines[i][5] , lines[i][6] , lines[i][7] , lines[i][8] , lines[i][9] );
                    -- Only coloring for first line
                    elseif lines[i][4] then
                        GameTooltip:AddDoubleLine( lines[i][2] , lines[i][3] , lines[i][4] , lines[i][5] , lines[i][6] );
                    -- only coloring for second line
                    elseif lines[i][7] then
                        GameTooltip:AddDoubleLine( lines[i][2] , lines[i][3] , lines[i][7] , lines[i][8] , lines[i][9] );
                    -- No specific coloring.
                    else
                        GameTooltip:AddLine( lines[i][2] , lines[i][3] );
                    end
                end
            end

        end

        GameTooltip:Show();
    end
end

---------------------------------------
------ FRAME CREATION AND INIT --------
---------------------------------------

-- Formatting stuff
local buildVersion = select ( 4 , GetBuildInfo() );
local CheckButtonTemplate = "InterfaceOptionsCheckButtonTemplate";

if buildVersion < 100000 then
    CheckButtonTemplate = "OptionsSmallCheckButtonTemplate";
end

-- Method:          GRM_UI.CreateCoreFrame ( string, frame, frame, int, int, bool, string, table, bool, string )
-- What it Does:    Builds a frame for use in the GRM addon.
-- Purpose:         Reusable tool to build frames easily, and initialize them.
GRM_UI.CreateCoreFrame = function ( name , parentFrame , globalParent , width , height , templateName ,
                                    isMovable , points , strata , addCloseButton , includeEscapeAction )

    if parentFrame[name] then
        return;
    end

    local finalFrame = {};
    local point = parentFrame;

    if globalParent then
        parentFrame[name] = CreateFrame ( "Frame" , name , globalParent , templateName );
        point = globalParent;

    else
        parentFrame[name] = CreateFrame ( "Frame" , name , parentFrame , templateName );
    end

    -- By pressing the ESC key the window closes.
    if includeEscapeAction then
        parentFrame[name]:SetScript ( "OnKeyDown" , function ( self , key )
            if not GRM_G.inCombat then
                self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
                if key == "ESCAPE" then
                    self:SetPropagateKeyboardInput ( false );
                    self:Hide();
                end
            elseif key == "ESCAPE" then
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

    if isMovable and not finalFrame:IsMouseEnabled() then
        finalFrame:EnableMouse ( true );
        finalFrame:SetMovable ( true );
        finalFrame:SetToplevel ( true );
        finalFrame:SetMovable ( "LeftButton" );
        finalFrame:SetScript ( "OnDragStart" , function()
            if GRM.GetMouseFocus( finalFrame ) then
                finalFrame:StartMoving();
            end
        end);
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

-- Method:          GRM_UI.CreateString ( string , frame , string , string , int , { R,G,B} , text , int , bool )
-- What it Does:    Creates a font string with given parameters
-- Purpose:         Reusable font string creation tool.
GRM_UI.CreateString = function ( name, parentFrame, template, text, fontSize, points, Width, textColor, alignment, wrappable )

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

    -- For some reason when you do a "SetFont" it doesn't take the first time, maybe too soon after creating the fontstring frame, I am not certain
    -- Reprocess in 1 second
    if math.floor ( select ( 2 , parentFrame[name]:GetFont() ) + 0.5 ) ~= math.floor ( ( GRM_G.FontModifier + fontSize ) + 0.5 ) then
        C_Timer.After ( 1 , function()
            GRM_UI.CreateString ( name , parentFrame , template , text , fontSize , points , Width , textColor , alignment , wrappable );
        end);
    end

end

-- Method:          GRM_UI.CreateButton ( string , frame , string , string , int , int , table , function , string , int , string , int , int , function or table , function )
-- What it Does:    Creates a button using whatever template you wish, as well as the added string
-- Purpose:         Reusable CreateButton tool
GRM_UI.CreateButton = function ( name, parentFrame, template, text, width, height, points,
                                 buttonScript, textTemplate, fontSize, alignment, pointModifier,
                                 heightModifier, toolTipScript, toolTipClearScript )
    local fontStringText = name.."Text";
    
    if not parentFrame[name] then

        local indent = pointModifier or 0;
        local heightM = heightModifier or 0;

        -- Default sizing for radial buttons
        if template == "UIRadioButtonTemplate" and not width then
            width = 16;
            height = 16;
        end

        parentFrame[name] = CreateFrame ( "Button" , name , parentFrame , template );
        parentFrame[name]:SetSize ( width , height );
        parentFrame[name]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );

        if text and not textTemplate then
            textTemplate = "GameFontWhite";
        end

        if textTemplate then
            parentFrame[name][fontStringText] = parentFrame[name]:CreateFontString ( nil , "OVERLAY" , textTemplate );
            parentFrame[name][fontStringText]:SetPoint ( "CENTER" , parentFrame[name] , "CENTER" , indent , heightM );
            parentFrame[name][fontStringText]:SetWidth ( width - 5 );
            parentFrame[name][fontStringText]:SetSpacing ( 1 );
            parentFrame[name][fontStringText]:SetWordWrap ( false );
            if alignment then
                parentFrame[name][fontStringText]:SetJustifyH ( alignment );
            else
                parentFrame[name][fontStringText]:SetJustifyH ( "LEFT" );
            end
        end

        if buttonScript then
            parentFrame[name]:SetScript ( "OnClick" , function( self , button )

                if button == "LeftButton" then
                    buttonScript( self );
                end
            end);
        end

        -- SCRIPTS
        if toolTipScript then

            if type ( toolTipScript ) == "function" then
                parentFrame[name]:SetScript ( "OnEnter" , function( self )
                    toolTipScript( self );
                end);
            else
                parentFrame[name]:SetScript ( "OnEnter" , function ( self )
                    CreateTooltipFromTable ( self , toolTipScript )
                end);
            end

            parentFrame[name]:SetScript ( "OnLeave" , function()
                if toolTipClearScript then
                    toolTipClearScript();
                else
                    GameTooltip:Hide();
                end
            end);
        end


    end

    if text and textTemplate then
        fontSize = fontSize or 12;

        parentFrame[name][fontStringText]:SetText ( text );
        parentFrame[name][fontStringText]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );
    end

end

-- Method:          GRM_UI.CreateRadialButtons ( string , string , string , table , table , bool , bool , int , table )
-- What it Does:    Builds a table of linked radial buttons
-- Purpose:         Ease of creating radial buttons for options.
GRM_UI.CreateRadialButtons = function ( name, parentFrame, template, textForEachButton, pointsFirstButton,
                                        sortHorizontal, buttonTextRight, fontSize, textColor, saveVariableLogic )

    template = template or "UIRadioButtonTemplate";

    local previousName = "";
    local previousText = "";
    local numRadialButtons = #textForEachButton;

    for i = 1 , numRadialButtons do
        local buttonName = name .. "Radial" .. i;
        local buttonText = buttonName.."Text";

        if not parentFrame[buttonName] then
            parentFrame[buttonName] = CreateFrame ( "CheckButton" , buttonName , parentFrame , template );
            parentFrame[buttonName][buttonText] = parentFrame[buttonName]:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

            if textColor then
                parentFrame[buttonName][buttonText]:SetTextColor ( textColor[1] , textColor[2] , textColor[3] );
            end

            if buttonTextRight then
                parentFrame[buttonName][buttonText]:SetPoint ( "LEFT" , parentFrame[buttonName] , "RIGHT" , 2 , 0 );
            else
                parentFrame[buttonName][buttonText]:SetPoint ( "RIGHT" , parentFrame[buttonName] , "LEFT" , -2 , 0 );
            end

            if i == 1 then
                parentFrame[buttonName]:SetPoint ( pointsFirstButton[1] , pointsFirstButton[2] , pointsFirstButton[3] , pointsFirstButton[4] , pointsFirstButton[5] );
            else
                if sortHorizontal then
                    if buttonTextRight then
                        parentFrame[buttonName]:SetPoint ( "LEFT" , parentFrame[previousName][previousText] , "RIGHT" , 10 , 0 );
                    else

                        parentFrame[buttonName][buttonText]:SetText ( textForEachButton[i] );
                        parentFrame[buttonName][buttonText]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );

                        parentFrame[buttonName]:SetPoint ( "LEFT" , parentFrame[previousName] , "RIGHT" , parentFrame[buttonName][buttonText]:GetWidth() + 10 , 0 );
                    end
                else
                    parentFrame[buttonName]:SetPoint ( "TOPLEFT" , parentFrame[previousName] , "BOTTOMLEFT" , 0 , -6 );
                end
            end

            parentFrame[buttonName]:SetScript ( "OnClick" , function ( self , button )

                if button == "LeftButton" then
                    if self:GetChecked() then

                        -- Uncheck the other buttons. This LINKS them together.
                        for j = 1 , numRadialButtons do
                            if j ~= i then
                                parentFrame[name .. "Radial" .. j]:SetChecked ( false );
                            end
                        end

                        if saveVariableLogic then
                            saveVariableLogic ( i );    -- Includes the number of the button clicked
                        end
                    else
                        self:SetChecked ( true );
                    end
                end

            end);

            previousName = buttonName;
            previousText = buttonText;
        end

        parentFrame[buttonName][buttonText]:SetText ( textForEachButton[i] );
        parentFrame[buttonName][buttonText]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );

        if buttonTextRight then
            GRM.NormalizeHitRects ( parentFrame[buttonName] , parentFrame[buttonName][buttonText] );
        else
            GRM.NormalizeHitRects ( parentFrame[buttonName] , parentFrame[buttonName][buttonText] , nil , true );
        end
    end

end

-- Method:          GRM_UI.CreateCheckBox ( string , frame , string , array , array , function , string , string , int , function , function )
-- What it Does:    Builds out the frames for a Hybrid Scroll Frame
-- Purpose:         Cleanup code with reusable tool.
GRM_UI.CreateCheckBox = function ( name, parentFrame, template, size, points, buttonScript, text,
                                   textTemplate, fontSize, toolTipScript, toolTipClearScript )

    local fontStringText = name.."Text";

    if not parentFrame[name] then
        local checkBoxTemplate = template or CheckButtonTemplate;

        parentFrame[name] = CreateFrame ( "CheckButton" , name , parentFrame , checkBoxTemplate );
        if size then
            parentFrame[name]:SetSize ( size[1] , size[2] );
        end
        parentFrame[name]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );

        parentFrame[name][fontStringText] = parentFrame[name]:CreateFontString ( nil , "OVERLAY" , textTemplate );
        parentFrame[name][fontStringText]:SetPoint ( "LEFT" , parentFrame[name] , "RIGHT" , 2 , 0 );
        parentFrame[name][fontStringText]:SetWordWrap ( false );
        parentFrame[name][fontStringText]:SetJustifyH ( "LEFT" );

        if buttonScript then
            parentFrame[name]:SetScript ( "OnClick" , function( self , button )

                if button == "LeftButton" then
                    buttonScript( self );
                end
            end);
        end

        -- SCRIPTS
        if toolTipScript then
            parentFrame[name]:SetScript ( "OnEnter" , function( self )
                toolTipScript( self );
            end);

            parentFrame[name]:SetScript ( "OnLeave" , function()
                if toolTipClearScript then
                    toolTipClearScript();
                else
                    GameTooltip:Hide();
                end
            end);
        end

    end

    parentFrame[name][fontStringText]:SetText ( text );
    parentFrame[name][fontStringText]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );
    GRM.NormalizeHitRects ( parentFrame[name] , parentFrame[name][fontStringText] );

end

-- Method:          GRM_UI.CreateHybridScrollFrame ( string , frame , int , int , string , int )
-- What it Does:    Builds out the frames for a Hybrid Scroll Frame
-- Purpose:         Cleanup code with reusable tool.
GRM_UI.CreateHybridScrollFrame = function ( scrollFrameName, parentFrame, width, height, points,
                                            template, refreshFunction, configureSteps )
    -- Build core frames to hold data and scroll
    if parentFrame[scrollFrameName] then
        return
    end

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
    parentFrame[scrollFrameName]:SetPoint ( points[1] , points[2] , points[3] , points[4] + 2 , points[5] + 10 );
    parentFrame[scrollFrameName]:SetScrollChild ( parentFrame[childName] );
    parentFrame[scrollFrameName]:SetHitRectInsets ( 0 , -24 , 0 , 0 );

    parentFrame[childName]:EnableMouse ( true );
    parentFrame[childName]:RegisterForDrag ( "LeftButton" );
    parentFrame[childName]:SetScript ( "OnDragStart" , function( self )
        if GRM.GetMouseFocus( self ) then
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
    parentFrame[sliderName].currentV = 0;

    if configureSteps then
        parentFrame[sliderName]:SetValueStep ( 25 );
        parentFrame[sliderName]:SetStepsPerPage ( ( ( height - 25 ) / 25 ) )
        parentFrame[sliderName]:SetScript( "OnValueChanged" , function( self , value )
            GRM_UI.HybridScrollOnValueChangedConfig (
                self , value , parentFrame[childName] , parentFrame[scrollFrameName] , ( ( height - 25 ) / 25 ) , 25 , refreshFunction , parentFrame.Entries
            );
        end);
    end
    parentFrame[sliderName]:SetValue( 0 );      -- Triggers value change

end

-- Method:          GRM_UI.CreateEditBox ( string , frameObject, string , int , int , table , string , table , int , bool , function , function , function )
-- What it Does     Creates and configures the macro tool
-- Purpose:         Reusable tool to build editBoxes
GRM_UI.CreateEditBox = function ( name, parentFrame, template, width, height, points, alignment, textColor, maxLetters,
                                  numbersOnly, toolTipScript, ToolTipClearLogic, textChangedFunction, createClearButton,
                                  trimWhiteSpace, enterPressedLogic )

    if parentFrame[name] then
        return
    end

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

        if trimWhiteSpace then
            self:SetText ( GRM.Util.Trim ( self:GetText() ) );
        end

        if self:GetText() == "" and textChangedFunction then
            textChangedFunction();
        end

        if enterPressedLogic then
            enterPressedLogic()
        end

        parentFrame[name].tempText = self:GetText();
    end)

    if textChangedFunction then
        parentFrame[name]:SetScript ( "OnTextChanged" , function ()
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

-- Method:          GRM_UI.CreateOptionsSlider ( string , frameObject, string , table , int , int , int , int , string , int , string , function , function , function )
-- What it Does     Creates and configures an options slider
-- Purpose:         Reusable tool to build options sliders
GRM_UI.CreateOptionsSlider = function ( name, parentFrame, template, points, min, max, steps, fontSize, textTitle,
                                        defaultValue, textTemplate, valueChangeScript, toolTipScript, toolTipClearScript,
                                        mouseUpLogic, includeLowHigh )

    local fontStringTextValue = name.."Text2";

    if not parentFrame[name] then
        local fontStringTextTitle = name.."Text";

        parentFrame[name] = CreateFrame ( "Slider" , name , parentFrame , template );
        parentFrame[name]:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );
        parentFrame[name].Slider:SetMinMaxValues ( min , max );
        parentFrame[name].Slider:SetObeyStepOnDrag ( true );
        parentFrame[name].Slider:SetValueStep ( steps );

        parentFrame[name].Slider[fontStringTextTitle] = parentFrame[name].Slider:CreateFontString ( nil , "OVERLAY" , textTemplate );
        parentFrame[name].Slider[fontStringTextValue] = parentFrame[name].Slider:CreateFontString ( nil , "OVERLAY" , textTemplate );

        parentFrame[name].Slider[fontStringTextTitle]:SetPoint ( "RIGHT" , parentFrame[name].Slider , "LEFT" , -5 , 0 );
        parentFrame[name].Slider[fontStringTextTitle]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );
        parentFrame[name].Slider[fontStringTextTitle]:SetText ( textTitle );
        parentFrame[name].Slider[fontStringTextValue]:SetPoint ( "LEFT" , parentFrame[name].Slider , "RIGHT" , 5 , 0 );
        
        parentFrame[name].Slider:SetScript ( "OnValueChanged" , function( _ , value )
            valueChangeScript ( value );
            if GameTooltip:IsVisible() then
                GRM.RestoreTooltip();
            end
        end);

        parentFrame[name].Slider:SetScript ( "OnMouseUp" , function ( self , button )
            if button == "RightButton" then
                self:SetValue ( defaultValue ); -- Right is to reset
            end
            mouseUpLogic();
        end);

        if toolTipScript then

            if type ( toolTipScript ) == "function" then
                parentFrame[name].Slider:SetScript ( "OnEnter" , function( self )
                    toolTipScript( self );
                end);
            else
                parentFrame[name].Slider:SetScript ( "OnEnter" , function ( self )
                    CreateTooltipFromTable ( self , toolTipScript );
                end);
            end

            parentFrame[name].Slider:SetScript ( "OnLeave" , function()
                if toolTipClearScript then
                    toolTipClearScript();
                else
                    GameTooltip:Hide();
                end
            end);
        end

        if not includeLowHigh and parentFrame[name].Forward then
            parentFrame[name].Forward:Hide()
            parentFrame[name].Back:Hide()
        end

    end

    parentFrame[name].Slider[fontStringTextValue]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );
    parentFrame[name].Slider[fontStringTextValue]:SetText ( tostring ( defaultValue ) );
end

-- Method:          BuildDropDownOptions ( stringArray , frame , frame , fontstring , RGBArray , int , function , function , function )
-- What it Does:    Builds the logic and text of the actual popout dropdown menu.
-- Puropose:        Compartmentalize some of the code. Rather than keep it all in the CreateDropDowm function
local BuildDropDownOptions = function( list, dropDownMenu, dropDownMenuSelected, dropDownMenuSelectedText, textColor,
                                        fontSize, optionalSelectFunction, optionalListUpdateFunction, optionalTextFilteringFunction )
    local buffer = 6;
    local height = 0;
    local name = dropDownMenu:GetName();

    if optionalListUpdateFunction then
        list = optionalListUpdateFunction();
    end

    -- Initiate the buttons holder
    dropDownMenu.Buttons = dropDownMenu.Buttons or {};

    for i = 1 , #dropDownMenu.Buttons do
        dropDownMenu.Buttons[i][1]:Hide();
    end

    for i = 1 , #list do
        if not dropDownMenu.Buttons[i] then
            local tempButton = CreateFrame ( "Button" , name .. "Button" .. i , dropDownMenu );
            dropDownMenu.Buttons[i] = { tempButton , tempButton:CreateFontString ( nil , "OVERLAY" , "GameFontWhite" ) }
        end

        local button = dropDownMenu.Buttons[i][1];
        local buttonText = dropDownMenu.Buttons[i][2];
        button:SetWidth ( dropDownMenu:GetWidth() );
        button:SetHeight ( fontSize );
        button:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );

        buttonText:SetText ( list[i] );
        buttonText:SetTextColor ( textColor[1] , textColor[2] , textColor[3] );
        buttonText:SetWidth ( dropDownMenu:GetWidth() - 5 );
        buttonText:SetWordWrap ( false );
        buttonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );
        buttonText:SetPoint ( "CENTER" , button );
        buttonText:SetJustifyH ( "CENTER" );

        if i == 1 then
            button:SetPoint ( "TOP" , dropDownMenu , 0 , -7 );
            height = height + button:GetHeight();
        else
            button:SetPoint ( "TOP" , dropDownMenu.Buttons[i - 1][1] , "BOTTOM" , 0 , -buffer );
            height = height + button:GetHeight() + buffer;
        end

        button:SetScript ( "OnClick" , function( _ , button )
            if button == "LeftButton" then
                local tempResult = GRM.Util.DeepCopyArray ( dropDownMenu.result );   -- Making a copy incase need to restore
                dropDownMenu.result = { buttonText:GetText() , i };
                dropDownMenuSelectedText:SetText ( buttonText:GetText() );
                dropDownMenu:Hide();
                dropDownMenuSelected:Show();

                if optionalSelectFunction then
                    optionalSelectFunction( i , tempResult );    -- Include the selection index
                end
            end
        end);

        button:Show();
    end
    dropDownMenu:SetHeight ( height + 15 );

    if optionalTextFilteringFunction then
        optionalTextFilteringFunction();
    end
end

-- Method:          GRM_UI.CreateDropDownMenu ( string , frame , string , array , intArray , stringArray , int , floatArray , function , function , function , function , bool )
-- What it Does:    It creates a unique, new, dropDownMenu given the variables
-- Purpose:         To create a generic, reusable dropdown menus
GRM_UI.CreateDropDownMenu = function ( name, parentFrame, template, point, size, list, fontSize ,
                                       textColor, toolTipScript, toolTipClearScript, optionalSelectFunction,
                                       optionalListUpdateFunction, optionalTextFilteringFunction, includeEscapeAction )

    local selectedFrame = name .. "Selected";
    local selectedFrameText = selectedFrame .. "Text";
    local fontSize = fontSize or 16;

    if not parentFrame[selectedFrame] then
        local template = template or "BackdropTemplate"
        local menuFrame = name .. "Menu";
        local textColor = textColor or { 1 , 1 , 1 };

        local BuildDropDown = function()
            BuildDropDownOptions( list , parentFrame[menuFrame], parentFrame[selectedFrame], parentFrame[selectedFrame][selectedFrameText],
                                         textColor, fontSize, optionalSelectFunction, optionalListUpdateFunction, optionalTextFilteringFunction );
        end

        -- Delimiter Dropdown for Export
        parentFrame[selectedFrame] = CreateFrame ( "Frame" , selectedFrame , parentFrame , BackdropTemplateMixin and template );
        parentFrame[selectedFrame][selectedFrameText] = parentFrame[selectedFrame]:CreateFontString ( nil , "OVERLAY" , "GameFontWhite" );
        parentFrame[menuFrame] = CreateFrame ( "Frame" , menuFrame , parentFrame[selectedFrame] , template );
        parentFrame[menuFrame].result = { list[1] , 1 }; -- Default Selection { textName, index }

        -- Point
        parentFrame[selectedFrame]:SetPoint ( point[1] , point[2] , point[3] , point[4] , point[5] );

        -- Aesthetics
        if size then
            parentFrame[selectedFrame]:SetSize ( size[1] , size[2] );
            parentFrame[menuFrame]:SetWidth ( size[1] );
        else
            parentFrame[selectedFrame]:SetSize ( 60 , 30 );
            parentFrame[menuFrame]:SetWidth ( 60 );
        end

        parentFrame[selectedFrame]:SetFrameStrata ( "DIALOG" );
        parentFrame[selectedFrame]:SetBackdrop ( GRM_UI_Util.GetBackdrop(1) );
        parentFrame[selectedFrame][selectedFrameText]:SetPoint ( "CENTER" , parentFrame[selectedFrame] );
        parentFrame[selectedFrame][selectedFrameText]:SetTextColor ( textColor[1] , textColor[2] , textColor[3] );
        parentFrame[menuFrame]:SetFrameStrata ( "DIALOG" );
        parentFrame[menuFrame]:SetPoint ( "TOP" , parentFrame[selectedFrame] , "BOTTOM" );
        parentFrame[menuFrame]:SetBackdrop ( GRM_UI_Util.GetBackdrop(1) );

        -- Function and logic
        if toolTipScript then

            if type ( toolTipScript ) == "function" then
                parentFrame[selectedFrame]:SetScript ( "OnEnter" , function( self )
                    toolTipScript( self );
                end);
            else
                parentFrame[selectedFrame]:SetScript ( "OnEnter" , function ( self )
                    CreateTooltipFromTable ( self , toolTipScript );
                end);
            end

            parentFrame[selectedFrame]:SetScript ( "OnLeave" , function()
                if toolTipClearScript then
                    toolTipClearScript();
                else
                    GameTooltip:Hide();
                end
            end);
        end

        if includeEscapeAction then
            parentFrame[menuFrame]:SetScript ( "OnKeyDown" , function ( self , key )
                if not GRM_G.inCombat then
                    self:SetPropagateKeyboardInput ( true );      -- Ensures keyboard access will default to the main chat window on / or Enter. UX feature.
                    if key == "ESCAPE" then
                        self:SetPropagateKeyboardInput ( false );
                        self:Hide();
                        parentFrame[selectedFrame]:Show();
                    end
                elseif key == "ESCAPE" then
                    self:Hide();
                    parentFrame[selectedFrame]:Show();
                end
            end);
        end

        parentFrame[selectedFrame]:SetScript ( "OnShow" , function()
            parentFrame[menuFrame]:Hide();
        end)

        parentFrame[selectedFrame]:SetScript ( "OnMouseDown" , function( _ , button )
            if button == "LeftButton" then
                if parentFrame[menuFrame]:IsVisible() then
                    parentFrame[menuFrame]:Hide();
                else
                    BuildDropDown();
                    parentFrame[menuFrame]:Show();
                end
            end
        end);

        parentFrame[menuFrame]:SetScript ( "OnShow" , function()
            if GameTooltip:IsVisible() then
                if toolTipClearScript then
                    toolTipClearScript();
                else
                    GameTooltip:Hide();
                end
            end
        end);
        BuildDropDown();
    end
    parentFrame[selectedFrame][selectedFrameText]:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + fontSize );
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

-------------------------------------
-- CUSTOM POPUP FRAMES AND DIALOGS --
-------------------------------------

-- Method:          GRM.InitiateEditBoxPopup ( string , string. function )
-- What it Does:    Opens the custom popup edit box with the given text and title
-- Purpose:         Reusable popup edit box for various inputs for player to copy
GRM.InitiateEditBoxPopup = function( editBoxText , TitleText, optionalOnCloseFunction , size )
    if not GRM_UI.GRM_CustomPopupFrame:IsVisible() and editBoxText and TitleText then
        size = size or {400, 120};
        GRM_UI.GRM_CustomPopupFrame.GRM_PopupEditBox:SetText ( editBoxText );
        GRM_UI.GRM_CustomPopupFrame.GRM_PopupTitleText:SetText ( TitleText );
        GRM_UI.GRM_CustomPopupFrame:SetSize( size[1], size[2] )
        

        if optionalOnCloseFunction then
            GRM_UI.GRM_CustomPopupFrame:SetScript ( "OnHide" , function(self)
                optionalOnCloseFunction();
                self:SetScript ( "OnHide" , nil ); -- Remove from running again
            end);
        end
        
        GRM_UI.GRM_CustomPopupFrame:Show();
    end
end

--------------------------------------------
-------- HYBRID SCROLLFRAME TEMPLATES ------
--------------------------------------------

-- Method:          HybridControl( sliderTable )
-- What it Does:    Sets a gate check that lasts for 0.1 seconds
-- Purpose:         So that when the slider value changes, it ignores double work when an "OnMouseWheel" handler is also activated.
local HybridControl = function(slider)
    slider.HybridControlBool = true;
    C_Timer.After(0.1, function()
        slider.HybridControlBool = false;
    end);
end

-- Method:          GRM_UI.SetHybridScrollFrameSliderParameters (frame , frame , frame , int , int , int , int , arrayOfButtons , function , function , int , function )
-- What it Does:    Acts as a template for all future hybrid scrollframe configuration of the slider logic on mousewheel scrolling and so on
-- Purpose:         Clean, repeatable code that can be used in conjunction with all other large scrollframes
GRM_UI.SetHybridScrollFrameSliderParameters = function(childFrame, HscrollFrame, HscrollFrameSlider, buttonW, buttonH,
    scrollH, totalEntries, buttons, logicFunction1, logicFunction2, totalPotentialButtons, optionalLogic)

    local maxButtons = #buttons;
    if totalPotentialButtons < maxButtons then
        maxButtons = totalPotentialButtons;
    end

    childFrame:SetSize(buttonW, HscrollFrame:GetHeight());

    local scrollMax = (scrollH - HscrollFrame:GetHeight());
    if scrollMax < 0 or totalEntries <= totalPotentialButtons then
        scrollMax = 0;
    else
        scrollMax = scrollMax + buttonH;
    end

    if HscrollFrameSlider.Slider then
        HscrollFrameSlider = HscrollFrameSlider.Slider;
    end

    HscrollFrameSlider:SetMinMaxValues(0, scrollMax);

    if scrollMax > 0 then
        HscrollFrame:EnableMouseWheel(true);
    else
        HscrollFrame:EnableMouseWheel(false);
    end

    if scrollMax > 0 then
        HscrollFrame:SetScript("OnMouseWheel", function(_, delta)

            if optionalLogic ~= nil then
                if not optionalLogic() then
                    return;
                end
            end

            if totalEntries > 0 then
                HybridControl(HscrollFrameSlider);
                local current = HscrollFrameSlider:GetValue();

                -- Scroll Down
                if delta < 0 and current < scrollMax then
                    if IsControlKeyDown() then
                        HscrollFrameSlider.HybridControlBool = false;
                        if IsShiftKeyDown() then
                            HscrollFrameSlider:SetValue(current + (buttonH * 12));
                        else
                            HscrollFrameSlider:SetValue(current + (buttonH * 3));
                        end
                    elseif IsShiftKeyDown() then
                        HscrollFrameSlider.HybridControlBool = false;
                        HscrollFrameSlider:SetValue(select(2, HscrollFrameSlider:GetMinMaxValues()));
                    else
                        HscrollFrameSlider:SetValue(current + buttonH);
                    end

                    -- Scroll Up
                elseif delta > 0 and current > 1 then
                    if IsControlKeyDown() then
                        HscrollFrameSlider.HybridControlBool = false;
                        if IsShiftKeyDown() then
                            HscrollFrameSlider:SetValue(current - (buttonH * 12));
                        else
                            HscrollFrameSlider:SetValue(current - (buttonH * 3));
                        end
                    elseif IsShiftKeyDown() then
                        HscrollFrameSlider.HybridControlBool = false;
                        HscrollFrameSlider:SetValue(0);
                    else
                        HscrollFrameSlider:SetValue(current - buttonH);
                    end
                end

                if HscrollFrameSlider.HybridControlBool then
                    -- Scroll Down
                    if delta < 0 and childFrame.Offset < totalEntries then
                        childFrame.Offset = childFrame.Offset + 1;
                        logicFunction1();

                        -- Scroll Up
                    elseif delta > 0 and childFrame.Offset > maxButtons then
                        childFrame.Offset = childFrame.Offset - 1;
                        logicFunction2();
                    end
                end
            end
        end);
    end
end

-- Method:          GRM_UI.HybridScrollOnValueChangedConfig ( slider , float , scrollchildframe , scrollframe , int , int , function , array )
-- What it Does:    In conjunction with the GRM_UI.HybridScrollOnValueChangedConfig() tool, manage the hybridscrollframe functionality of the given frames
-- Purpose:         Reusable framework for hybrid scrollframes in this addon's style.
GRM_UI.HybridScrollOnValueChangedConfig = function(HscrollFrameSlider, value, scrollChildFrame, scrollFrame, numButtons,
    stepSize, refreshFunction, dataArray)
    local maxSize = 0
    local arraySize = #dataArray;

    if value > HscrollFrameSlider.currentV then
        if HscrollFrameSlider.HybridControlBool and scrollFrame:GetVerticalScroll() < maxSize then
            scrollFrame:SetVerticalScroll(value);
        else
            if not HscrollFrameSlider.HybridControlBool then
                if value >= maxSize and scrollFrame:GetVerticalScroll() < maxSize then
                    scrollFrame:SetVerticalScroll(maxSize);
                end
                scrollChildFrame.Offset = math.floor((value / stepSize)) + numButtons;
                -- Prevent overlap errors
                if scrollChildFrame.Offset > arraySize then
                    scrollChildFrame.Offset = arraySize;
                end
                refreshFunction(true, false);
            end
        end
    else
        if HscrollFrameSlider.HybridControlBool and scrollFrame:GetVerticalScroll() > 0 and value <= maxSize then
            scrollFrame:SetVerticalScroll(value);
        else
            if not HscrollFrameSlider.HybridControlBool then

                if value == 0 and scrollFrame:GetVerticalScroll() <= maxSize then
                    scrollFrame:SetVerticalScroll(0);
                end

                scrollChildFrame.Offset = math.floor((value / stepSize)) + numButtons;
                -- Prevent overlap errors
                if scrollChildFrame.Offset > arraySize then
                    scrollChildFrame.Offset = arraySize;
                end
                refreshFunction(true, false);
            end
        end
    end
    HscrollFrameSlider.currentV = value;
end