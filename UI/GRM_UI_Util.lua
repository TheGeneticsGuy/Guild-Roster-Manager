-- General UI Helpers
GRM_UI_Util = {};

-- Method:          GRM_UI_Util.GetBackdrop ( int )
-- What it Does:    Returns from a list of backdrops
-- Purpose:         Reusable backdrops for cleaner UI code.
GRM_UI_Util.GetBackdrop = function ( index )

    -- Formerly called in GRM GRM_UI.noteBackdrop2
    if index == 1 then
        return {
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background" ,
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 32,
            edgeSize = 8,
            insets = { left = 2 , right = 2 , top = 3 , bottom = 2 }
        }

    -- Formerly called in GRM GRM_UI.noteBackdrop3
    elseif index == 2 then
        return {
            bgFile = nil,
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 32,
            edgeSize = 6,
            insets = { left = 2 , right = 2 , top = 3 , bottom = 1 }
        }

    -- Formerly called in GRM GRM_UI.framelessBackdrop
    elseif index == 3 then
        return {
            bgFile = nil,
            edgeFile = "",
            tile = true,
            tileSize = 32,
            edgeSize = 9,
            insets = { left = -2 , right = -2 , top = -3 , bottom = -2 }
        }

    end

    -- Default return if you get here (notebackdrop1)
    return {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background" ,
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 18,
        insets = { left = 5 , right = 5 , top = 5 , bottom = 5 }
    }
end

----------------------------------------
--- MATHEMATICAL PLACEMENT OF FRAMES ---
----------------------------------------

-- Method:          GRM_UI_Util.GetCheckboxPinNumber ( int , int )
-- What it Does:    Returns the bottom left checkbox depending on the number of checkboxes and rows. For example, if there are 9
--                  checkboxes in rows of 3 checkboxes per row, I want to pin to bottom left checkbox, which is the first checkbox
--                  on the 3rd row, or checkbox number 7
-- Purpose:         Be bale to have dynamic access to building checkbox or button grids of any size, for example in GRM use, a guild
--                  might have 10 ranks, or it might have 5 ranks. If I build a checkbox grid of all the ranks, I need to know which
--                  row to pin my next frame to properly.
-- Usage:           Useful in grid design of checkboxes
GRM_UI_Util.GetCheckboxPinNumber = function ( numCheckboxes , numberPerRow )

    local r = numCheckboxes % numberPerRow;
    local result = 0;

    if r == 0 then
        result = numCheckboxes - ( numberPerRow - 1 );
    else
        result = numCheckboxes - r  + 1
    end

    return result
end

------------------------------
-- GENERAL HELPERS -----------
------------------------------

-- Method:          GRM_UI_Util.WrapText ( string , int )
-- What it Does:    Wraps text based on the given string if it is too long
-- Purpose:         To control the visual aspect of really long string on mouseovers and so on.
GRM_UI_Util.WrapText = function ( text , maxLength )
    local result = "";
    local maxOverUnder = 25;

    if #text > maxLength then
        local remainingText = text;
        local frontSpace = -1;
        local lastSpace = -1;
        local breakIndex = maxLength; -- Default unless other factors apply

        while #remainingText > maxLength do

            frontSpace = -1;
            lastSpace = -1;
            breakIndex = maxLength; -- Default unless other factors apply

            -- Scan through and find the closes space before and closest after.
            for i = 1 , #remainingText do
                if string.sub ( remainingText , i , i ) == " " then
                    if i <= maxLength then
                        frontSpace = i;
                    elseif i > maxLength and lastSpace == -1 then
                        lastSpace = i;
                        break;  -- We found the first space AFTER the maxLength, so we can be done.
                    end
                end
            end

            if frontSpace == -1 or lastSpace == -1 then
                if frontSpace > -1 and lastSpace == -1 then
                    if frontSpace >= ( maxLength - maxOverUnder ) then    -- Don't want to
                        breakIndex = frontSpace;
                    end
                elseif frontSpace == -1 and lastSpace > -1 then
                    if lastSpace <= ( maxLength + maxOverUnder ) then
                        breakIndex = lastSpace;
                    end
                end
            else
                -- Both have a value
                if ( maxLength - frontSpace ) <= ( lastSpace - maxLength ) then
                    if frontSpace >= ( maxLength - maxOverUnder ) then    -- Don't want to
                        breakIndex = frontSpace;
                    end
                else
                    if lastSpace <= ( maxLength + maxOverUnder ) then
                        breakIndex = lastSpace;
                    end
                end
            end

            result = result .. remainingText:sub ( 1 , breakIndex - 1 ) .. "\n";
            remainingText = remainingText:sub ( breakIndex + 1 );

            if #remainingText <= maxLength then
                result = result .. remainingText;
            end

        end
    else
        result = text;
    end

    return result;
end

-- Method:          GRM_UI_Util.ScaleButtonToFontStringSize ( buttonObject , fontstringObject , int)
-- What it Does:    Determines the width of the string, the increases the width of the button so it doesn't overlap, with buffer
-- Purpose:         UI Quality of Life
GRM_UI_Util.ScaleButtonToFontStringSize = function ( button, fontstring , spacingOnEachSide )
    local finalSize = fontstring:GetWidth() + (spacingOnEachSide * 4);
    local buttonWidth = button:GetWidth();

    if buttonWidth < finalSize then
        button:SetWidth ( finalSize );
    end
    return finalSize;
end

-- Method:          GRM_UI_Util.BuildSliderTextures ( sliderFrame )
-- What it Does:    Adds the texture ends to the outside of the input slider frame
-- Purpose:         Blizz deprecated some frame designs I like so this modifies and adds my own custom design using
--                  a texture made by ChatGPT for me.
GRM_UI_Util.BuildSliderTextures = function ( slider )

    local size = slider:GetWidth();

    slider.bg = slider:CreateTexture ( nil , "BACKGROUND" );
    slider.bg:SetAllPoints(slider);
    slider.bg:SetTexture ( "Interface\\DialogFrame\\UI-DialogBox-Background" );
    slider.bg:SetDrawLayer("BACKGROUND");

    slider.top = slider:CreateTexture( nil, "BORDER", nil, 1)
    slider.top:SetTexture("Interface\\AddOns\\Guild_Roster_Manager\\media\\icons\\sliderEnd.png")  -- Use a custom rounded texture
    slider.top:SetWidth(size);
    slider.top:SetHeight(size)
    slider.top:SetPoint("BOTTOM", slider, "TOP" , 0 , -1);
    slider.top:SetRotation ( math.pi );

    slider.bot = slider:CreateTexture( nil, "BORDER", nil, 1)
    slider.bot:SetTexture("Interface\\AddOns\\Guild_Roster_Manager\\media\\icons\\sliderEnd.png")  -- Use a custom rounded texture
    slider.bot:SetWidth(size);
    slider.bot:SetHeight(size)
    slider.bot:SetPoint("TOP", slider, "BOTTOM" , 0 , 1 );

    slider.topTextureFrame = CreateFrame ( "FRAME" , nil , slider );
    slider.topTextureFrame:SetWidth(size);
    slider.topTextureFrame:SetHeight(size)
    slider.topTextureFrame:SetPoint( "TOP", slider.top, "TOP" );
    slider.topTextureFrame:EnableMouse ( true );

    slider.botTextureFrame = CreateFrame ( "FRAME" , nil , slider );
    slider.botTextureFrame:SetWidth(size);
    slider.botTextureFrame:SetHeight(size)
    slider.botTextureFrame:SetPoint( "TOP", slider.bot, "TOP" );
    slider.botTextureFrame:EnableMouse ( true );

    slider.NineSlice:Hide()

    slider.botTextureFrame:SetScript( "OnMouseDown" , function( _ , button)
        if button == "LeftButton" then
            local currentValue = slider:GetValue();
            local max = select ( 2 , slider:GetMinMaxValues() );

            if currentValue < max then
                local value = currentValue + 15;
                if value > max then
                    value = max;
                end
                slider:SetValue ( value );
            end
        end
    end)

    slider.topTextureFrame:SetScript( "OnMouseDown" , function( _ , button)
        if button == "LeftButton" then
            local currentValue = slider:GetValue()
            local min = slider:GetMinMaxValues();

            if currentValue > min then
                local value = currentValue - 15;
                if value < min then
                    value = min;
                end

                slider:SetValue ( value );
            end

        end
    end)
end