local ColorPicker = {};
GRM_UI.ColorPicker = ColorPicker;

-- Method:          ColorPicker.Open ( float , float , float , function )
-- What it Does:    Opens the WoW Color picker seamlessly across all WoW Client Versions
-- Purpose:         A universal wrapper that fires the callback dynamically as the color wheel moves.
ColorPicker.Open = function(r, g, b, onColorChangeCallback)
    
    -- Fires when user drags mouse or hits cancel
    local function ColorCallback(restore)
        local newR, newG, newB
        if restore then
            -- User hit "Cancel", restore original color
            newR, newG, newB = unpack(restore)
        else
            -- User is picking a new color
            newR, newG, newB = ColorPickerFrame:GetColorRGB()
        end
        
        if onColorChangeCallback then
            onColorChangeCallback(newR, newG, newB)
        end
    end

    -- RETAIL (10.2.5+)
    if ColorPickerFrame.SetupColorPickerAndShow then
        local info = {
            r = r, g = g, b = b,
            swatchFunc = function() ColorCallback() end,
            cancelFunc = function() ColorCallback({r, g, b}) end,
            hasOpacity = false,
        }
        ColorPickerFrame:SetupColorPickerAndShow(info)

    -- CLASSIC CLIENTS
    else
        ColorPickerFrame.func = function() ColorCallback() end
        ColorPickerFrame.cancelFunc = function(restore) ColorCallback(restore) end
        ColorPickerFrame.previousValues = {r, g, b}
        ColorPickerFrame:SetColorRGB(r, g, b)
        ColorPickerFrame:Show()
    end

    -- -- Compatibility resizing
    -- if GRM.IsAddOnLoaded("ColorPickerPlus") then
    --     ColorPickerFrame:SetSize(380, 380)
    -- elseif GRM.IsAddOnLoaded("ColorPickerAdvanced") then
    --     ColorPickerFrame.hasOpacity = true;
    --     ColorPickerFrame.opacity = 1
    -- elseif GRM.IsAddOnLoaded("ElvUI") then
    --     ColorPickerFrame:SetSize(345, 240)
    -- else
    --     ColorPickerFrame:SetSize(305, 230)
    -- end
end

-- Method:          ColorPicker.CreateColorBox(string, frame, int, table, float, float, float, function)
-- What it Does:    Creates a universal, clickable color swatch box.
-- Purpose:         Instantly generates a color picker box without needing custom tracking variables. Hooks Blizz default color box
ColorPicker.CreateColorBox = function(name, parentFrame, size, points, initialR, initialG, initialB, onColorUpdateCallback)
    if not parentFrame[name] then
        parentFrame[name] = CreateFrame("Frame", name, parentFrame, BackdropTemplateMixin and "BackdropTemplate")
        parentFrame[name]:SetSize(size, size)
        parentFrame[name]:SetPoint(points[1], points[2], points[3], points[4], points[5])
        parentFrame[name]:SetBackdrop(GRM_UI_Util.GetBackdrop(3)) -- Frameless

        GRM.CreateTexture(parentFrame[name], "texture", "ARTWORK", true)
        parentFrame[name].texture:SetPoint("CENTER", parentFrame[name])
        parentFrame[name].texture:SetSize(size - 3, size - 3)
        parentFrame[name].texture.r = initialR
        parentFrame[name].texture.g = initialG
        parentFrame[name].texture.b = initialB

        parentFrame[name]:SetScript("OnEnter", function(self)
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:AddLine("|CFFE6CC7F" .. GRM.L("Click") .. "|r - " .. GRM.L("Customize Color"))
            GameTooltip:Show()
        end)
        
        parentFrame[name]:SetScript("OnLeave", GRM.RestoreTooltip)

        parentFrame[name]:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" then
                GRM.RestoreTooltip()
                ColorPicker.Open(self.texture.r, self.texture.g, self.texture.b, function(newR, newG, newB)
                    -- Update the local texture instantly
                    self.texture:SetColorTexture(newR, newG, newB, 1.0)
                    self.texture.r = newR
                    self.texture.g = newG
                    self.texture.b = newB
                    
                    -- Trigger UI logic passed in
                    if onColorUpdateCallback then
                        onColorUpdateCallback(newR, newG, newB)
                    end 
                end)
            end
        end)
    end

    -- Set the initial color
    parentFrame[name].texture:SetColorTexture(initialR, initialG, initialB, 1.0)
end

-- Build the Color Editboxes for the log options frame
ColorPicker.BuildAllSideFrameColorBoxes = function()
    local parentFrame = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame
    
    if not parentFrame.colorBoxFrame1 then
        local colorBuildCount = GRM_G.HardcoreActive and 15 or 14

        for i = 1, colorBuildCount do
            local name = "colorBoxFrame" .. i
            local c = GRM.S().logColor[i]
            local points = {}
            
            if i == 1 then
                points = {"LEFT", GRM_UI.GRM_RosterCheckBoxSideFrame.GRM_RosterJoinedChatCheckButton, "RIGHT", 32, 0}
            else
                points = {"TOPLEFT", parentFrame["colorBoxFrame" .. (i - 1)], "BOTTOMLEFT", 0, -6}
            end

            -- Create he box.
            ColorPicker.CreateColorBox(name, parentFrame, 18, points, c[1], c[2], c[3], function(r, g, b)
                
                -- Update live as user drags the wheel
                
                -- Save to Database
                GRM.S().logColor[i][1] = r
                GRM.S().logColor[i][2] = g
                GRM.S().logColor[i][3] = b
                
                -- Hardcore hex specific
                if i == 15 and GRM_G.HardcoreActive then
                    GRM_G.HardcoreHexCode = GRM.rgbToHex({GRM.ConvertRGBScale(r, true), GRM.ConvertRGBScale(g, true), GRM.ConvertRGBScale(b, true)})
                end

                -- Update the text label visually
                ColorPicker.UpdateLogFilterTextColor(r, g, b, i)
            end)
        end

        -- Header Text
        parentFrame.GRM_ColorBoxPickText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        parentFrame.GRM_ColorBoxPickText:SetPoint("BOTTOM", parentFrame.colorBoxFrame1, "TOP", 0, 1)
        parentFrame.GRM_ColorBoxPickText:SetWidth(60)
        parentFrame.GRM_ColorBoxPickText:SetWordWrap(true)
        parentFrame.GRM_ColorBoxPickText:SetJustifyH("CENTER")
    end

    ColorPicker.RefreshLogColorOptions()
    parentFrame.GRM_ColorBoxPickText:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 10)
    parentFrame.GRM_ColorBoxPickText:SetText(GRM.L("Custom Color"))
end

ColorPicker.RefreshLogColorOptions = function()
    local colors = GRM.S().logColor;
    for i = 1, #colors do
        if i ~= 15 or (i == 15 and GRM_G.HardcoreActive) then
            -- We just trigger our custom API widget to update itself!
            local box = GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogExtraOptionsFrame["colorBoxFrame" .. i]
            box.texture:SetColorTexture(colors[i][1], colors[i][2], colors[i][3], 1.0)
            ColorPicker.UpdateLogFilterTextColor(colors[i][1], colors[i][2], colors[i][3], i)
        end
    end
end

-- Method:          ColorPicker.UpdateLogFilterTextColor()
-- What it Does:    Updates the log filter text coloring as well, along with the color boxes
-- Purpose:         UX
ColorPicker.UpdateLogFilterTextColor = function ( r , g , b , ind )

    local text = {
        GRM_UI.GRM_CoreFrame.GRM_RosterJoinedCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterLeveledChangeCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterInactiveReturnCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterPromotionChangeCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterDemotionChangeCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterNoteChangeCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterOfficerNoteChangeCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterCustomNoteChangeCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterNameChangeCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterRankRenameCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterEventCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterLeftGuildCheckButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterRecommendationsButtonText,
        GRM_UI.GRM_CoreFrame.GRM_RosterBannedPlayersButtonText
    };

    if GRM_G.HardcoreActive then
        table.insert ( text , GRM_UI.GRM_RosterCheckBoxSideFrame.GRM_HardcoreToLogCheckbox.GRM_HardcoreToLogCheckboxText );

    end

    text[ind]:SetTextColor ( r , g , b , 1 );
end