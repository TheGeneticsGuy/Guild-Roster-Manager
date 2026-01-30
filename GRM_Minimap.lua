-- GRM's Minimap Philosophy
-- GRM overall has a general philsophy of ZERO dependencies on other addons or libraries.
-- However, if the user has LibDataBroker and LibDBIcon already installed for other addons, I am not opposed to using it, as it is good.
-- But, I don't want GRM to ever be reliant on these libraries. As such, GRM has it's own custom minimap button as well that can be
-- used instead, so if you prefer to keep the GRM minimap button as a custom one, it will be slightly enhanced and allow you to place it ANYWHERE.
-- However, by allowing support of the minimap icon data broker, all of those addons that use it can still be compatible with GRM as well.

local MinimapGRM = {};
local blizzMinimap = _G.Minimap;
GRM_MinimapPosition.hide = GRM_MinimapPosition.hide or false;

GRM.MinimapGRM = MinimapGRM;

-- Method:          MinimapGRM.MainWindowOpenLogic()
-- What it Does:    Logic to open GRM's main window from minimap button click
-- Purpose:         To handle the various conditions for opening GRM's main window, notably I don't want it opening
--                  before the initialization of all frames and data is completed, which only takes a few seconds.
MinimapGRM.MainWindowOpenLogic = function()
    if IsShiftKeyDown() and IsControlKeyDown() then

        MinimapGRM:Hide();
        GRM.S().minimapEnabled = false;
        GRM_MinimapPosition.hide = true;

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton ~= nil and GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton:IsVisible() then
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_GeneralOptionsFrame.GRM_ShowMinimapButton:SetChecked ( false );
        end
    else
        if GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
            GRM_UI.GRM_RosterChangeLogFrame:Hide();
        else

            if IsInGuild() then
                if ( time() - GRMsyncGlobals.timeAtLogin ) > 5 or GRM_G.MinimapOk then
                    if not GRM_G.minmapButtonDelay then
                        GRM.DelayMinimapButtonOpen ( false , false );
                    end
                else
                    GRM.Report ( GRM.L ( "One moment, GRM is still being configured." ) );
                end
            else
                GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Player is Not Currently in a Guild" ) );
            end
        end
    end
end

-- Method:          MinimapOnEnter( tooltip )
-- What it Does:    Handles the tooltip display when hovering over the minimap button
-- Purpose:         To provide users with information about GRM when they hover over the minimap button
local MinimapOnEnter = function ( tooltip )

    if IsInGuild() then
        local versionLine = "|CFF00CCFF" .. GRM.L ( "GRM" ) .. " " .. GRM_G.Version:match ( "R(.+)" ) .. ( GRM_G.Beta and " - Beta" or "" );

        if GRM_G.BuildVersion < GRM_G.RetailBaseBuild then
            versionLine = versionLine .. " " .. GRM.L ( "(Classic)" );
        end

        tooltip:AddLine( versionLine );
        tooltip:AddLine( GRM.L ( "|CFFE6CC7FClick|r to open GRM" ) );
        tooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r and drag to move this button." ) );
        tooltip:AddLine( GRM.L ( "|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button." ) );

        local MOTD = GetGuildRosterMOTD();
        if MOTD ~= "" and MOTD ~= nil then
            MOTD = GRM_UI.WrapText ( GRM.Trim ( MOTD ) , 65 );
            tooltip:AddLine ( " " );
            tooltip:AddLine ( "|CFFFF0000" .. GRM.L ( "MOTD:" ) );
            tooltip:AddLine ( MOTD );
        end
        tooltip:AddLine ( " " );
        tooltip:AddLine ( "|CFF00CCFF" .. string.format ( "%d/%d |r" , GRM.G_Util.GetNumGuildiesOnline() , GRM.G_Util.GetNumGuildies() ) .. GRM.L( "Online" ) );
        
        -- Tooltip update:
        if not ( ( time() - GRMsyncGlobals.timeAtLogin ) > 5 or GRM_G.MinimapOk ) then
            tooltip:AddLine(" ");
            tooltip:AddLine(GRM.L ( "One moment, GRM is still being configured." ));
        end
    else
        tooltip:AddLine ( GRM.L ( "Not in Guild" ) );
    end
end

-- Method:          MinimapButtonClick( _ , button )
-- What it Does:    Handles clicks on the minimap button
-- Purpose:         To open GRM's main window on left click
local MinimapButtonClick = function ( _ , button )
    if button == "LeftButton" then
        MinimapGRM.MainWindowOpenLogic();
    end
end

MinimapGRM.CreateMiniMapWithLibDataBroker = function()
    local MinimapDataBroker = LibStub("LibDataBroker-1.1", true)
    MinimapGRM.LibDBIconMinimap = MinimapDataBroker and LibStub("LibDBIcon-1.0", true)

    if MinimapDataBroker then
        MinimapGRM.LDB = MinimapDataBroker:NewDataObject ( "Guild_Roster_Manager", {
            type  = "data source",
            icon = "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\MageTower_Icon.blp",
            label = GRM.L("Guild Roster Manager"),
            text = GRM.L ("Loading..."),
            OnClick = MinimapButtonClick,
            OnTooltipShow = MinimapOnEnter,
        } );

        if MinimapGRM.LibDBIconMinimap then
            MinimapGRM.LibDBIconMinimap:Register("Guild_Roster_Manager", MinimapGRM.LDB, GRM_MinimapPosition )

            MinimapGRM.UpdateMinimapLabel = function()
                if IsInGuild() then
                    local numOnline = GRM.G_Util.GetNumGuildiesOnline()
                    local numTotal = GRM.G_Util.GetNumGuildies()

                    if numTotal and numTotal > 0 then
                        MinimapGRM.LDB.label = GRM.L("Online");
                        MinimapGRM.LDB.text = string.format ( "|CFF00CCFF%d/%d" , numOnline , numTotal );
                    end
                else
                    MinimapGRM.LDB.label = GRM.L ("GRM");
                    MinimapGRM.LDB.text = GRM.L ( "Not in Guild" );
                end
            end
            -- Initialize
            MinimapGRM.UpdateMinimapLabel();
            MinimapGRM.LibDBIconMinimap:Hide("Guild_Roster_Manager");
        end
    end
end

-- Method:          MinimapGRM.CreateCustomMinimapButton()
-- What it Does:    Creates GRM's custom minimap button without the use of any libraries.
-- Purpose:         To provide a minimap button for GRM that does not rely on any external libraries.
MinimapGRM.CreateCustomMinimapButton = function()
    -- MINIMAP BUTTON if creating from scratch.
    MinimapGRM.CustomMinimap = CreateFrame ( "Button" , "GRM_CustomMinimap" , UIParent );
    GRM.CreateTexture ( MinimapGRM.CustomMinimap , "CustomMinimapIcon" , "BORDER" , false );
    GRM.CreateTexture ( MinimapGRM.CustomMinimap , "CustomMinimapBorder" , "OVERLAY" , false );

    MinimapGRM.CustomMinimap:EnableMouse ( true );
    MinimapGRM.CustomMinimap:SetMovable ( false );
    MinimapGRM.CustomMinimap:SetFrameStrata ( "HIGH" );
    MinimapGRM.CustomMinimap:SetWidth ( 33 );
    MinimapGRM.CustomMinimap:SetHeight ( 33 );
    MinimapGRM.CustomMinimap:SetHighlightTexture ( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" );
    MinimapGRM.CustomMinimap.CustomMinimapIcon:SetPoint ( "CENTER" , MinimapGRM.CustomMinimap , -2 , 1 );
    MinimapGRM.CustomMinimap.CustomMinimapIcon:SetTexture ( "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\MageTower_Icon.blp" );
    MinimapGRM.CustomMinimap.CustomMinimapIcon:SetWidth ( 20 );
    MinimapGRM.CustomMinimap.CustomMinimapIcon:SetHeight ( 20 );
    MinimapGRM.CustomMinimap.CustomMinimapBorder:SetWidth ( 52 );
    MinimapGRM.CustomMinimap.CustomMinimapBorder:SetHeight ( 52 );
    MinimapGRM.CustomMinimap.CustomMinimapBorder:SetPoint ( "TOPLEFT" , MinimapGRM.CustomMinimap );
    MinimapGRM.CustomMinimap.CustomMinimapBorder:SetTexture ( "Interface\\Minimap\\MiniMap-TrackingBorder" );
    MinimapGRM.CustomMinimap:Hide();

    MinimapGRM.CustomMinimapUpdatePos = function()
        MinimapGRM.CustomMinimap:ClearAllPoints()
        
        if not GRM.S().customPos then
            
            if GRM.S().minimapRad then
                radius = GRM.S().minimapRad
            else
                if GRM_G.BuildVersion >= 100000 then 
                    radius = 105;
                else
                    radius = 80;
                end
            end

            -- Calculating coordinates based on Center anchoring
            local angle = math.rad(GRM.S().minimapPos or 345)
            
            local x = math.cos(angle) * radius
            local y = math.sin(angle) * radius

            -- Anchor CENTER to CENTER. 
            MinimapGRM.CustomMinimap:SetPoint("CENTER", Minimap, "CENTER", x, y)
        else
            -- Free floating position
            MinimapGRM.CustomMinimap:ClearAllPoints();
            MinimapGRM.CustomMinimap:SetPoint(GRM.S().minimapCustomPos[1], UIParent, GRM.S().minimapCustomPos[2], GRM.S().minimapRad, GRM.S().minimapPos)
        end
    end

    -- Method:          MinimapGRM.ResetMinimapPositionToDefault()
    -- What it Does:    Sets the minimap icon back to default position.
    -- Purpose:         In case player drags the minimap off screen...
    MinimapGRM.ResetMinimapPositionToDefault = function()

        if GRM_G.BuildVersion >= 100000 then
            GRM.S().minimapRad = 105;
        else
            GRM.S().minimapRad = 80;
        end
        GRM.S().minimapPos = 345;
        GRM.S().customPos = false;
        MinimapGRM.CustomMinimapUpdatePos();
    end

    MinimapGRM.CustomMinimapDuringDrag = function()
        local x , y = GetCursorPosition()
        local scale = blizzMinimap:GetEffectiveScale();
        local xmin , ymin = blizzMinimap:GetLeft() , blizzMinimap:GetBottom();

        x = xmin - x / scale + 70;
        y = y / scale - ymin - 70;

        local vector = math.deg ( math.atan2 ( y , x ) );
        if vector < 0 then
            vector = vector + 360
        end

        GRM.S().minimapPos = vector;
        MinimapGRM.CustomMinimapUpdatePos();
    end


    MinimapGRM.CustomMinimapDuringDrag = function()
        local mx, my = GetCursorPosition()
        local scale = Minimap:GetEffectiveScale()
        
        -- Getting the center of the Minimap in scaled coordinates
        local cx, cy = Minimap:GetCenter()
        
        -- Normalize cursor position to the same scale as the Minimap
        mx = mx / scale
        my = my / scale
        
        -- Calculate the angle. 
        -- atan2(y, x) gives the angle. Subtract center from mouse to get delta.
        local rad = math.atan2(my - cy, mx - cx)
        local degrees = math.deg(rad)
        
        -- Save the angle
        GRM.S().minimapPos = degrees
        
        -- Update the button position immediately
        MinimapGRM.CustomMinimapUpdatePos()
    end

    MinimapGRM.CustomMinimap:RegisterForDrag ( "LeftButton" );
    MinimapGRM.CustomMinimap:SetScript ( "OnDragStart" , function ( self )
        if not GRM.S().customPos and not IsControlKeyDown() then
            -- Circular motion.
            self:SetScript ( "OnUpdate" , MinimapGRM.CustomMinimapDuringDrag );
        elseif not IsControlKeyDown() then
            -- Reset Position
            MinimapGRM.ResetMinimapPositionToDefault();
        else
            -- Draggable anywhere.
            MinimapGRM.CustomMinimap:SetMovable ( true );
            GRM.S().customPos = true;
            self:StartMoving();
        end
    end);

    MinimapGRM.CustomMinimap:SetScript ( "OnDragStop" , function ( self )
        self:SetScript ( "OnUpdate" , nil );
        self:StopMovingOrSizing();
        if GRM.S().customPos then
            local side1, _ , side2 , point1 , point2 = MinimapGRM.CustomMinimap:GetPoint();
            GRM.S().minimapCustomPos[1] = side1;
            GRM.S().minimapCustomPos[2] = side2;
            GRM.S().minimapRad = point1;
            GRM.S().minimapPos = point2;
        end
        MinimapGRM.CustomMinimap:SetMovable ( false );
    end)

    MinimapGRM.CustomMinimap:SetScript ( "OnEnter" , function ( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_LEFT" );
        if IsInGuild() then
            local versionLine = "|CFF00CCFF" .. GRM.L ( "GRM" ) .. " " .. GRM_G.Version:match ( "R(.+)" ) .. ( GRM_G.Beta and " - Beta" or "" );
            if GRM_G.BuildVersion < GRM_G.RetailBaseBuild then
                versionLine = versionLine .. " " .. GRM.L ( "(Classic)" );
            end
            GameTooltip:AddLine ( versionLine );
            GameTooltip:AddLine ( GRM.L ( "|CFFE6CC7FClick|r to open GRM" ) );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FLeft-Click|r and drag to move this button." ) );
            GameTooltip:AddLine( GRM.L ( "{custom1} and drag to move this button anywhere." , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Left-Click" ) .. "|r" ) );
            GameTooltip:AddLine( GRM.L ( "|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button." ) );


            local MOTD = GetGuildRosterMOTD();
            if MOTD ~= "" and MOTD ~= nil then
                MOTD = GRM_UI.WrapText ( GRM.Trim ( MOTD ) , 65 );
                GameTooltip:AddLine ( " " );
                GameTooltip:AddLine ( "|CFFFF0000" .. GRM.L ( "MOTD:" ) );
                GameTooltip:AddLine ( MOTD );
                GameTooltip:AddLine ( " " );
            end
            GameTooltip:AddLine ( " " );
            GameTooltip:AddLine ( "|CFF00CCFF" .. string.format ( "%d/%d |r" , GRM.G_Util.GetNumGuildiesOnline() , GRM.G_Util.GetNumGuildies() ) .. GRM.L( "Online" ) );

            -- Tooltip update:
            if not ( ( time() - GRMsyncGlobals.timeAtLogin ) > 5 or GRM_G.MinimapOk ) then
                GameTooltip:AddLine(" ");
                GameTooltip:AddLine(GRM.L ( "One moment, GRM is still being configured." ));
            end
            
        else
            GameTooltip:AddLine ( GRM.L ( "Not in Guild" ) );
        end
        GameTooltip:Show();
    end)

    MinimapGRM.CustomMinimap:SetScript ( "OnLeave" , GRM.RestoreTooltip );
    MinimapGRM.CustomMinimap:SetScript ( "OnClick" , MinimapButtonClick );
    GRM.S().minimapRad = GRM.S().minimapRad or 80;
    GRM.S().minimapPos = GRM.S().minimapPos or 345;
    MinimapGRM.CustomMinimapUpdatePos();
end

-- Method:          MinimapGRM.GRM_MinimapButtonInit()
-- What it Does:    Initializes the minimap button based on user settings and guild status
-- Purpose:         To set up the minimap button for GRM when the addon is loaded
MinimapGRM.GRM_MinimapButtonInit = function()
    if IsInGuild() then

        if not MinimapGRM.CustomMinimap then
            MinimapGRM.LDB = nil;

            if LibStub and LibStub("LibDataBroker-1.1", true ) and LibStub("LibDBIcon-1.0", true) then
                -- Broker Compatibility
                MinimapGRM.CreateMiniMapWithLibDataBroker();
            end
            MinimapGRM.CreateCustomMinimapButton(); -- Always Create this one... but we will hide both initially.
            MinimapGRM.SetSelectedMinimap ( GRM.S().minimapType, true );

            -- Initialise defaults if not present
            if GRM.S().minimapEnabled == false then
                MinimapGRM.Hide();
                GRM_MinimapPosition.hide = true;
            else
                MinimapGRM.Show();
                GRM_MinimapPosition.hide = false;
            end
        else
            if GRM.S().minimapEnabled then
                MinimapGRM.Show();
                GRM_MinimapPosition.hide = false;
            else
                MinimapGRM.Hide();
                GRM_MinimapPosition.hide = true;
            end
        end
    end

end

-- Method:          MinimapGRM.Hide()
-- What it Does:    Hides the minimap button, whether custom or LibDBIcon
-- Purpose:         To provide a way to hide the minimap button when the user chooses to
MinimapGRM.Hide = function()
    if MinimapGRM.GRM_MinimapButton then
        MinimapGRM.GRM_MinimapButton:Hide ( "Guild_Roster_Manager" );
    end
end

-- Method:          MinimapGRM.Show()
-- What it Does:    Shows the minimap button, whether custom or LibDBIcon
-- Purpose:         To provide a way to show the minimap button when the user chooses to
MinimapGRM.Show = function()
    if MinimapGRM.GRM_MinimapButton then
        MinimapGRM.GRM_MinimapButton:Show ("Guild_Roster_Manager" );
    end
end

-- Method:          MinimapGRM.SetSelectedMinimap( choice , bool )
-- What it Does:    Sets the minimap button type based on user choice
-- Purpose:         To allow users to choose between the custom minimap button or the LibDB
MinimapGRM.SetSelectedMinimap = function( choice , force )
    if choice == 2 and ( GRM.S().minimapType ~= 2 or force ) then
        MinimapGRM.Hide();
        GRM.S().minimapType = 2;
        MinimapGRM.GRM_MinimapButton = MinimapGRM.CustomMinimap;
        if GRM.S().minimapEnabled then
            MinimapGRM.Show();
        end
    elseif choice == 1 then
        if MinimapGRM.LibDBIconMinimap and ( GRM.S().minimapType ~= 1 or force ) then
            MinimapGRM.Hide();
            GRM.S().minimapType = 1;
            MinimapGRM.GRM_MinimapButton = MinimapGRM.LibDBIconMinimap
            if GRM.S().minimapEnabled then
                MinimapGRM.Show();
            end
        elseif not MinimapGRM.LibDBIconMinimap and GRM.S().minimapType == 1 then
            -- I don't want to overwrite the settings if they just disabled an addon temporarily. So keep it as 2
            MinimapGRM.GRM_MinimapButton = MinimapGRM.CustomMinimap;
            if GRM.S().minimapEnabled then
                MinimapGRM.Show();
            end
        end
    end
end