
-- Creating a new Guild Roster window

-- Method:          GRM_UI.BuildRosterFrames()
-- What it Does:    Initiates building of all o the Custom GRM Guild Roster window
-- Purpose:         Provide players more controls than default communities offers.
GRM_UI.BuildRosterFrames = function ()

    GRM_UI.CreateCoreFrame ( "GRM_RosterFrame" , GRM_UI , UIParent , 530 , 525 , "TranslucentFrameTemplate" , true , { "CENTER" , UIParent , "CENTER" , 0 , 300 } , "MEDIUM" , true , true );
    GRM_UI.GRM_RosterFrame.SortType = 3;
    GRM_UI.GRM_RosterFrame:Hide();    

    GRM_UI.GRM_RosterFrame:SetScript ( "OnShow" , function()
        GRM_UI.RefreshRosterName();
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider.ThumbTexture:Show()
        GRM_UI.GRM_MemberDetailMetaData:Hide();
    end)

    GRM_UI.GRM_RosterFrame:SetScript ( "OnHide" , function()
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
    end)
    
    -- Must buiold hybrid first since columns will be pinned to it. 
    GRM_UI.CreateHybridScrollFrame ( "GRM_RosterFrameScrollFrame" , GRM_UI.GRM_RosterFrame , 500 , 400 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame , "BOTTOMLEFT" , 5 , 5 } , "TranslucentFrameTemplate" , GRM_UI.BuildGuildRoster );

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameTitle" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Guild Roster" ) , 18 , { "TOP" , GRM_UI.GRM_RosterFrame , "TOP" , 0 , -17 } );

    -- Level
    GRM_UI.CreateButton ( "GRM_RosterColumnLvl" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Lvl" ) , 40 , 22 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameBorder, "TOPLEFT" , 10 , -3 } , GRM_UI.SortLevel , "GameFontWhite" , 13 , "LEFT" , nil , nil  );

    -- Name
    GRM_UI.CreateButton ( "GRM_RosterColumnName" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Name" ) , 170 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnLvl, "RIGHT" , -1.5 , 0 } , GRM_UI.SortNames , "GameFontWhite" , 13 , "LEFT" , nil , nil );

    -- Last Online
    GRM_UI.CreateButton ( "GRM_RosterColumnLastOnline" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Last Online" ) , 150 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnName, "RIGHT" , -1.5 , 0 } , GRM_UI.SortLastOnline , "GameFontWhite" , 13 , "LEFT" , nil , nil  );

    -- Rank
    GRM_UI.CreateButton ( "GRM_RosterColumnRank" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Rank" ) , 125 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnLastOnline, "RIGHT" , -1.5 , 0 } , GRM_UI.SortRank , "GameFontWhite" , 13 , "LEFT" , nil , nil  );

    
    -- Right click menu
    GRM_UI.CreateCoreFrame ( "GRM_RosterFrameDropDown" , GRM_UI.GRM_RosterFrame , nil , 110 , 177 , BackdropTemplateMixin and "BackdropTemplate" , false , nil , "FULLSCREEN_DIALOG" , false , true );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName = "";
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick = false

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownName" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "GameFontNormal" , "" , 13 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "TOPLEFT" , 7 , -7 } , 100 , nil , "LEFT" , false );

    -- Promote
    GRM_UI.CreateButton ( "GRM_RosterDropDownPromote" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , "" , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName , "BOTTOMLEFT" , 0 , -1 } , nil , "GameFontWhite" , 12 , "LEFT" , 5 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:SetHitRectInsets ( -10 , 0 , -15 , -15 );  -- Necessary for :IsMouseOver() on the left side, to not hide

    -- Demote
    GRM_UI.CreateButton ( "GRM_RosterDropDownDemote" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , "" , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote , "BOTTOMLEFT" , 0 , -3 } , nil , "GameFontWhite" , 12 , "LEFT" , 5 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:SetHitRectInsets ( -10 , 0 , -15 , -15 );

    -- Kick
    GRM_UI.CreateButton ( "GRM_RosterDropDownKick" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Kick" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote , "BOTTOMLEFT" , 0 , -3 } , GRM_UI.KickPlayer , "GameFontWhite" , 12 , "LEFT" , 5 );

    -- Divider
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownDivider" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "GameFontWhite" , "__________" , 12 , { "TOP" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick , "BOTTOM" , 0 , -10} , 100 , nil , "CENTER" , false );

    -- Whisper
    GRM_UI.CreateButton ( "GRM_RosterDropDownWhisper" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Whisper" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownDivider , "BOTTOMLEFT" , 0 , -5 } , GRM_UI.RosterRightClickWhisper , "GameFontWhite" , 12 , "LEFT" , 5 );

    -- Cancel
    GRM_UI.CreateButton ( "GRM_RosterDropDownCancel" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Cancel" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownWhisper , "BOTTOMLEFT" , 0 , -3 } , GRM_UI.RosterRightClickCancel , "GameFontWhite" , 12 , "LEFT" , 5 );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:SetHighlightTexture ( 
        "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownWhisper:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownCancel:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );

    -- Tooltip Promote
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:SetScript ( "OnEnter" , function( self )
    
        if GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks == 0 then
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            if CanGuildPromote() then
                GameTooltip:AddLine( GRM.L ( "Unable to Promote players at this rank" ) );
            else
                GameTooltip:AddLine( GRM.L ( "No Rank Permission to Promote" ) );
            end
            GameTooltip:Show();
        else
            GRM_UI.BuildPromotionRankSelectionDropDown( self );
        end
    end);
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()

        if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:IsMouseOver() then
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Hide();
        end

    end)

    -- Tooltip Demote
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:SetScript ( "OnEnter" , function( self )
    
        if GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks == 0 then
            
            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );

            if CanGuildDemote() then
                GameTooltip:AddLine( GRM.L ( "Unable to Demote players at this rank" ) );
            else
                GameTooltip:AddLine( GRM.L ( "No Rank Permission to Demote" ) );
            end
            GameTooltip:Show();

        else
            GRM_UI.BuildDemotionRankSelectionDropDown( self );
        end
    end);
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip()

        if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:IsMouseOver() then
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Hide();
        end

    end)
    
    -- Tooltip Kick
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick:SetScript ( "OnEnter" , function( self )
    
        if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick then

            GRM_UI.SetTooltipScale()
            GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
            if CanGuildRemove() then
                GameTooltip:AddLine( GRM.L ( "Unable to kick players at this rank" ) );
            else
                GameTooltip:AddLine( GRM.L ( "No Rank Permission to Kick" ) );
            end
            GameTooltip:Show();

        end
    end);
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick:SetScript ( "OnLeave" , function()
        GRM.RestoreTooltip();
    end)

    -- Rank selection - Right click menu
    GRM_UI.CreateCoreFrame ( "GRM_RosterFrameDropDownRank" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , 135 , 210 , BackdropTemplateMixin and "BackdropTemplate" , false , nil , "FULLSCREEN_DIALOG" , false , true );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Hide();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetHitRectInsets ( -10 , -10 , -10 , -10 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote = false;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote = false;

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownRankText" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank , "GameFontNormal" , "" , 12 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank , "TOPLEFT" , 7 , -7 } , 125 , nil , "LEFT" , false );

    -- Set the 9 possible rank options
    local points = { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.GRM_RosterFrameDropDownRankText , "BOTTOMLEFT" , 0 , -8 };
    for i = 1 , 9 do
        if i > 1 then
            points = { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton" .. ( i-1 )] , "BOTTOMLEFT" , 0 , -1 };
        end

        GRM_UI.CreateButton ( "GRM_RosterDropDownRankButton" .. i , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank , nil , "" , ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:GetWidth() - 5 ) , 20 , points , GRM_UI.RankSelection , "GameFontWhite" , 12 , "LEFT" , 10 , 0 );

        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton" .. i]:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton" .. i].destinationRank = 0;
    end

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:SetScript ( "OnHide" , function()
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Hide();
    end);

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetScript ( "OnLeave" , function( self )

        if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:IsMouseOver() and not GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:IsMouseOver() and not GRM.IsOverAnyRankSelectionButtons() then
            self:Hide();
        end        

    end)

    -- SEARCH EDIT BOX
    GRM_UI.CreateEditBox ( "GRM_RosterFrameNameEditBox" , GRM_UI.GRM_RosterFrame , "InputBoxTemplate" , 165 , 30 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnName , "TOPLEFT" , 5 , 2 } , "CENTER" , nil , 50 , false , GRM_UI.NameSearchTT , GRM.RestoreTooltip , GRM_UI.RefreshRosterName );

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameNameEditBoxText" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Player Search" ) , 16 , { "BOTTOM" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox , "TOP" , 0 , 3 } , 155 , nil , "CENTER" , false );

end

-- Method:          GRM.IsOverAnyRankSelectionButtons()
-- What it Does:    Returns true if over any mouseover button, for hide/show purposes/
-- Purpose:         Quality of life UI controls.
GRM.IsOverAnyRankSelectionButtons = function()
    local result = false;

    if not ( GetMouseFocus() == nil ) and not ( GetMouseFocus():GetName() == nil ) then
        local name = GetMouseFocus():GetName();
        

        for i = 1 , 9 do
            if name == ( "GRM_RosterDropDownRankButton" .. i ) then
                result = true;
                break;
            end
        end
    end

    return result;
end

-- Method:          GRM_UI.BuildPromotionRankSelectionDropDown ( buttonObject )
-- What it Does:    Builds the rankPromotionWindow
-- Purpose:         Easily give people ability to bump ranks with menus.
GRM_UI.BuildPromotionRankSelectionDropDown = function ( buttonFrame )
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.GRM_RosterFrameDropDownRankText:SetText ( GRM.L ( "Promote Player to:" ) );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:ClearAllPoints();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetPoint ( "BOTTOMRIGHT" , buttonFrame , "BOTTOMLEFT" , -6 , -20 );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote = true;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.demote = false;
    
    for i = 1 , 9 do
        
        if i <= GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks then
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]["GRM_RosterDropDownRankButton"..i.."Text"]:SetText ( GuildControlGetRankName ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex - GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks + i ) );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]:Show();
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i].destinationRank = ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex - GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks + i ) - 1;
        else
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]["GRM_RosterDropDownRankButton"..i.."Text"]:SetText ( "" );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]:Hide();
        end

    end

    local height = 60;
    height = height + ( ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks - 1 ) * 21 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetHeight ( height );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Show();
end

-- Method:          GRM_UI.BuildDemotionRankSelectionDropDown ( buttonObject )
-- What it Does:    Builds the rankDemotionWindow
-- Purpose:         Easily give people ability to bump ranks with menus.
GRM_UI.BuildDemotionRankSelectionDropDown = function ( buttonFrame )
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.GRM_RosterFrameDropDownRankText:SetText ( GRM.L ( "Demote Player to:" ) );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote = false;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.demote = true;

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:ClearAllPoints();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetPoint ( "TOPRIGHT" , buttonFrame , "TOPLEFT" , -6 , 15 );

    for i = 1 , 9 do
        
        if i <= GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks then

            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]["GRM_RosterDropDownRankButton"..i.."Text"]:SetText ( GuildControlGetRankName ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex + 1 + i ) );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]:Show();
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i].destinationRank = ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex + i );
        else
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]["GRM_RosterDropDownRankButton"..i.."Text"]:SetText ( "" );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton"..i]:Hide();
        end

    end

    local height = 60;
    height = height + ( ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks - 1 ) * 21 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetHeight ( height );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Show();
end

-- Method:          GRM_UI.RankSelection ( buttonObject )
-- What it Does:    Determines to use the demote or promote logic
-- Purpose:         Quality of life feature
GRM_UI.RankSelection = function( button )
    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote then
        --
        GRM_UI.PromotePlayer ( button )
    elseif GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.demote then
        GRM_UI.DemotePlayer ( button )
    end
end

-- Method:          GRM_UI.PromotePlayer ( button )
-- What it Does:    Takes the player to be promoted and builds macr otool
-- Purpose:         Quality of life feature for the custom guild roster
GRM_UI.PromotePlayer = function ( button )
    local promoEntries = GRM.BuildCustomPromoteEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false , button );

    if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
        GRM_UI.GRM_ToolCoreFrame:Show();
    end

    GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:Click();
    GRM_UI.RefreshManagementTool( false , false , true , promoEntries );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_UI.DemotePlayer ( button )
-- What it Does:    Takes the player to be Demoted and builds macro otool
-- Purpose:         Quality of life feature for the custom guild roster
GRM_UI.DemotePlayer = function( button )
    local demoteEntries = GRM.BuildCustomDemoteEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false , button );

    if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
        GRM_UI.GRM_ToolCoreFrame:Show();
    end
    GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:Click();

    GRM_UI.RefreshManagementTool( false , false , true , demoteEntries );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end


-- Method:          GRM_UI.KickPlayer()
-- What it Does:    Takes the player to be kicked, builds it for the macro tool, and builds the macro
-- Purpose:         Quality of Life ease of taking advantage of the macro tool
GRM_UI.KickPlayer = function()
    local kickEntries = GRM.BuildCustomKickEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false );

    if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
        GRM_UI.GRM_ToolCoreFrame:Show();
    end
    GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:Click();

    GRM_UI.RefreshManagementTool( false , false , true , kickEntries );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end


-- Method:          GRM_UI.SortNames( buttonObject , bool )
-- What it Does:    Sorts all of the names ascending or descending in the guild
-- Purpose:         For the Guild roster
GRM_UI.SortNames = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    if nameSearch == "" then
        nameSearch = nil;
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType > 2 then
            GRM_UI.GRM_RosterFrame.SortType = 1;
        elseif GRM_UI.GRM_RosterFrame.SortType == 1 then
            GRM_UI.GRM_RosterFrame.SortType = 2;
        else
            GRM_UI.GRM_RosterFrame.SortType = 1;
        end
    end

    local members = GRM.GetAllMembersAsArray ( nameSearch );
    
    if GRM_UI.GRM_RosterFrame.SortType == 1 then
        sort ( members , function ( a , b ) return a.name < b.name end );
    else
        sort ( members , function ( a , b ) return a.name > b.name end );
    end

    GRM_UI.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_UI.SortLastOnline( buttonObject , bool )
-- What it Does:    Sorts all of the players by last online, longest or shortes
-- Purpose:         For the Guild roster
GRM_UI.SortLastOnline = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    if nameSearch == "" then
        nameSearch = nil;
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 3 and GRM_UI.GRM_RosterFrame.SortType ~= 4 then
            GRM_UI.GRM_RosterFrame.SortType = 3;
        elseif GRM_UI.GRM_RosterFrame.SortType == 3 then
            GRM_UI.GRM_RosterFrame.SortType = 4;
        else
            GRM_UI.GRM_RosterFrame.SortType = 3;
        end
    end

    local members = GRM.GetAllMembersAsArray ( nameSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 3 then
        sort ( members , function ( a , b )     return a.lastOnline < b.lastOnline end );
    else
        sort ( members , function ( a , b ) return a.lastOnline > b.lastOnline end );
    end

    GRM_UI.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_UI.SortRank( buttonObject , bool )
-- What it Does:    Sorts all of the names by guild rank, highest to lowest.
-- Purpose:         For the Guild roster
GRM_UI.SortRank = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    if nameSearch == "" then
        nameSearch = nil;
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 5 and GRM_UI.GRM_RosterFrame.SortType ~= 6 then
            GRM_UI.GRM_RosterFrame.SortType = 5;
        elseif GRM_UI.GRM_RosterFrame.SortType == 5 then
            GRM_UI.GRM_RosterFrame.SortType = 6;
        else
            GRM_UI.GRM_RosterFrame.SortType = 5;
        end
    end

    local members = GRM.GetAllMembersAsArray ( nameSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 5 then
        sort ( members , function ( a , b ) return a.rankIndex < b.rankIndex end );
    else
        sort ( members , function ( a , b ) return a.rankIndex > b.rankIndex end );
    end

    GRM_UI.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_UI.SortLevel( buttonObject , bool )
-- What it Does:    Sorts all of the names by player level, highest to lowest or reverse
-- Purpose:         For the Guild roster
GRM_UI.SortLevel = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    if nameSearch == "" then
        nameSearch = nil;
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 7 and GRM_UI.GRM_RosterFrame.SortType ~= 8 then
            GRM_UI.GRM_RosterFrame.SortType = 7;
        elseif GRM_UI.GRM_RosterFrame.SortType == 7 then
            GRM_UI.GRM_RosterFrame.SortType = 8;
        else
            GRM_UI.GRM_RosterFrame.SortType = 7;
        end
    end

    local members = GRM.GetAllMembersAsArray ( nameSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 7 then
        sort ( members , function ( a , b ) return a.level > b.level end );
    else
        sort ( members , function ( a , b ) return a.level < b.level end );
    end

    GRM_UI.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_UI.RosterRightClickCancel()
-- What it Does:    Hides the right click context menu in the custom GRM Guild Roster
-- Purpose:         Passthrough function for the button build tool
GRM_UI.RosterRightClickCancel = function()
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_UI.RosterRightClickWhisper()
-- What it Does:    Initializes a whisper to the given player
-- Purpose:         To give the player the ability to easily right click-whisper someone.
GRM_UI.RosterRightClickWhisper = function()

    ChatFrame1EditBox:SetFocus()
    ChatFrame1EditBox:Insert ( "/w " .. GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName .. " " );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_UI.RefreshRosterName()
-- What it Does:    Refreshes the guild custom roster
-- Purpose:         Refresh the frame without resorting...
GRM_UI.RefreshRosterName = function ()

    if GRM_UI.GRM_RosterFrame.SortType < 3 then
        GRM_UI.SortNames ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 3 or GRM_UI.GRM_RosterFrame.SortType == 4 then
        GRM_UI.SortLastOnline ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 5 or GRM_UI.GRM_RosterFrame.SortType == 6 then
        GRM_UI.SortRank ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 7 or GRM_UI.GRM_RosterFrame.SortType == 8 then
        GRM_UI.SortLevel ( nil , true );
    end

end

-- Method:          GRM.BuildQueuedScrollFrame( bool , bool )
-- What it Does:    Updates the Queued scrollframe as needed
-- Purpose:         UX of the GRM mass kick tool
GRM_UI.BuildGuildRoster = function ( showAll , fullRefresh , entries )
    local hybridScrollFrameButtonCount = 15;
    local buttonHeight = 25;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetWidth() - 5;
    if showAll and fullRefresh then

        if entries then
            GRM_UI.GRM_RosterFrame.Entries = entries
        else
            GRM_UI.SortNames();
        end
    end

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons or {};
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset or ( hybridScrollFrameButtonCount );

    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset < hybridScrollFrameButtonCount then
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset = hybridScrollFrameButtonCount;
    elseif GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset > hybridScrollFrameButtonCount and GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset > #GRM_UI.GRM_RosterFrame.Entries then
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset = #GRM_UI.GRM_RosterFrame.Entries;
    end

    for i = 1 , #GRM_UI.GRM_RosterFrame.Entries do
        -- Build HybridScrollFrame Buttons
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i] then

                local button = CreateFrame ( "Button" , "Button1_" .. i , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild );
                GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i] = {
                    button ,
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- Level
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- Name
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- Last Online
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" )       -- Rank
                };

                button = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i][1];
                if i == 1 then
                    button:SetPoint ( "TOP" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , "TOP" , 9 , 7 );
                else 
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                button:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );
                GRM.BuildGuildRosterButtons ( i  , false );
                
            end
        end

        if i >= ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount + 1 ) and i <= GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset then
            GRM.SetGuildRosterValues ( i - ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount ) , i );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i - ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount )][1]:Show();
        end
        
        -- Slider Height is controlled by tallying how many of these are necessary
        scrollHeight = scrollHeight + buttonHeight;
    end

    -- Hide unused buttons...
    for i = #GRM_UI.GRM_RosterFrame.Entries + 1 , #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons do
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i][1]:Hide();
    end

    GRM.SetHybridScrollFrameSliderParameters ( 
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider, 
        buttonWidth , buttonHeight , scrollHeight , #GRM_UI.GRM_RosterFrame.Entries , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons , 
        GRM.RosterShiftDown , GRM.RosterShiftUp , hybridScrollFrameButtonCount
    );

end

-- Method:          GRM.BuildKickQueuedScrollButtons ( int , boolean )
-- What it Does:    Initiates the buttons and their values for each line of the Queued window of the GRM kick tool's hybridscrollframe
-- Purpose:         Create a smooth scrolling experience in the GRM kick window
GRM.BuildGuildRosterButtons = function ( ind , isResizeAction )
    local coreButton = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][2];
    local buttonText2 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3];
    local buttonText3 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][4];
    local buttonText4 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][5];

    -- Name
    buttonText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText4:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

    -- Actions don't need to be run more than once.
    if not isResizeAction then

        buttonText1:SetPoint ( "LEFT" , coreButton , "LEFT" , 9 , 0 );
        buttonText1:SetJustifyH ( "LEFT" );
        buttonText1:SetWidth ( 30 )
        buttonText1:SetWordWrap ( false );

        buttonText2:SetPoint ( "LEFT" , buttonText1 , "RIGHT" , 9 , 0 );
        buttonText2:SetJustifyH ( "LEFT" );
        buttonText2:SetWidth ( 160 )
        buttonText2:SetWordWrap ( false );

        buttonText3:SetPoint ( "LEFT" , buttonText2 , "RIGHT" , 9 , 0 );
        buttonText3:SetJustifyH ( "LEFT" );
        buttonText3:SetWidth ( 140 )
        buttonText3:SetWordWrap ( false );

        buttonText4:SetPoint ( "LEFT" , buttonText3 , "RIGHT" , 9 , 0 );
        buttonText4:SetJustifyH ( "LEFT" );
        buttonText4:SetWidth ( 120 )
        buttonText4:SetWordWrap ( false );

        coreButton:EnableMouse ( true );
        coreButton:RegisterForDrag ( "LeftButton" );

        -- Setup draggable conditions
        coreButton:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_RosterFrame:StartMoving();
        end);
        coreButton:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_RosterFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( GRM_UI.GRM_RosterFrame );
        end);

        coreButton:SetScript ( "OnMouseDown" , function ( self , button )
            local playerName = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3]:GetText();

            if button == "LeftButton" then
                if IsShiftKeyDown() and IsControlKeyDown() then
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                    -- If Core GRM window is not open, let's open it!
                    if not GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
                        GRM_UI.GRM_RosterChangeLogFrame:Show();
                    end
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogTab:Click();
                    GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame.GRM_LogEditBox:SetText( GRM.SlimName ( playerName ) );
                elseif IsShiftKeyDown() then
                    GRM.GR_Roster_Click ( playerName );

                elseif IsControlKeyDown() then
                    GRM.OpenPlayerWindow( playerName );
                end
                
            elseif button == "RightButton" then
                GRM_UI.RestoreTooltipScale();
                GameTooltip:Hide();

                local player = GRM.GetPlayer ( playerName );
                GRM_G.playerRankID = GRM.GetGuildMemberRankID ( GRM_G.addonUser );

                if player then

                    -- Set Name
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName = playerName;
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName:SetText ( GRM.SlimName ( playerName ) );
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName:SetTextColor ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][2]:GetTextColor() );

                    -- Promote
                    if player.rankIndex <= ( GRM_G.playerRankID + 1 ) or player.rankIndex == 0 then  -- Not able to promote rank that is the same or one below, as you cannot promote to your own rank.
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetText ( GRM.L ( "Promote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetTextColor ( 1 , 0 , 0 );

                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks = 0;
                    else
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetText ( "<  " .. GRM.L ( "Promote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetTextColor ( 1 , 1 , 1 );

                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks = player.rankIndex - ( GRM_G.playerRankID + 1 )
                    end

                    -- Demote
                    if player.rankIndex <= GRM_G.playerRankID or player.rankIndex == ( GuildControlGetNumRanks() - 1 ) then  -- Not able to demote
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetText ( GRM.L ( "Demote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetTextColor ( 1 , 0 , 0 );

                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks = 0;
                    else
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetText ( "<  " .. GRM.L ( "Demote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetTextColor ( 1 , 1 , 1 );

                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks = ( GuildControlGetNumRanks() - 1 ) - player.rankIndex;
                    end

                    -- For reference, store current rank
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex = player.rankIndex;

                    -- Kick
                    if player.rankIndex > GRM_G.playerRankID then
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick = true;
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick.GRM_RosterDropDownKickText:SetTextColor ( 1 , 1 , 1 );
                    else
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick = false;
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick.GRM_RosterDropDownKickText:SetTextColor ( 1 , 0 , 0 );
                    end
                    
                    
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:ClearAllPoints();
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:SetPoint ( "TOPRIGHT" , self , "TOPLEFT" , -10 , 0 );
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Show();

                else
                    GRM_UI.RefreshRosterName();
                end

            end

        end);            

        coreButton:SetScript ( "OnEnter" , function ()
            GRM.UpdateGuildRosterTooltip( ind );
        end);

        coreButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);
    end
end

-- Method:          GRM.UpdateGuildRosterTooltip ( int )
-- What it Does:    Sets the tooltip for the Custom GRM scrollframe in the GRM kick tool
-- Purpose:         Make it clear the QoL controls.
GRM.UpdateGuildRosterTooltip = function ( ind )
    local playerName = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3]:GetText();
    local player = GRM.GetPlayer ( playerName );

    if player then

        playerName = GRM.GetClassifiedName ( playerName , true );

        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1] , "ANCHOR_LEFT" );
        GameTooltip:AddLine ( playerName );
        GameTooltip:AddLine ( " " );
        GameTooltip:AddLine ( GRM.L ( "{custom1} to open Player Window" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Click" ) .. "|r" ) );
        GameTooltip:AddLine ( GRM.L ( "{custom1} to Search the Log for Player" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Ctrl-Shift-Click" ) .. "|r" ) );

        if CanGuildPromote() or CanGuildDemote() or CanGuildRemove() then
            GameTooltip:AddLine ( GRM.L ( "{custom1} to Promote, Demote, or Kick" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Right-Click" ) .. "|r" ) );
        else
            GameTooltip:AddLine ( GRM.L ( "{custom1} to Whisper" , nil , nil , nil , "|CFFE6CC7F" .. GRM.L ( "Right-Click" ) .. "|r" ) );
        end
        GameTooltip:Show();

    end    

end

-- Method:          GRM.SetGuildRosterValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Hybrid ScrollFrame tool
GRM.SetGuildRosterValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind];

    -- Player Name
    line[2]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].level );
    line[3]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].name );
    line[3]:SetTextColor ( GRM_UI.GRM_RosterFrame.Entries[ind2].classColor[1] , GRM_UI.GRM_RosterFrame.Entries[ind2].classColor[2] , GRM_UI.GRM_RosterFrame.Entries[ind2].classColor[3] );
    line[4]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].hoursReport );
    line[5]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].rankName );

    -- Update the tooltip if underlying data changes
    if GameTooltip:IsVisible() and GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1]:IsMouseOver() then 
        GRM.UpdateGuildRosterTooltip ( ind );
    end
end

-- Method:          GRM.RosterShiftDown()
-- What it Does:    Shifts all the values DOWN one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.RosterShiftDown = function()
    if #GRM_UI.GRM_RosterFrame.Entries > 13 then
        local buttons = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons;
        local MouseOverButton = 0;

        -- Shift them down...
        for i = 1 , #buttons - 1 do

            -- Header Line
            buttons[i][2]:SetText( buttons[i+1][2]:GetText() );
            buttons[i][2]:SetTextColor ( buttons[i+1][2]:GetTextColor ( buttons[i+1][2]:GetText() ) );
            buttons[i][3]:SetText( buttons[i+1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i+1][3]:GetTextColor ( buttons[i+1][3]:GetText() ) );
            buttons[i][4]:SetText( buttons[i+1][4]:GetText() );
            buttons[i][4]:SetTextColor ( buttons[i+1][4]:GetTextColor ( buttons[i+1][4]:GetText() ) );
            buttons[i][5]:SetText( buttons[i+1][5]:GetText() );
            buttons[i][5]:SetTextColor ( buttons[i+1][5]:GetTextColor ( buttons[i+1][5]:GetText() ) );

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.RosterSetLastValue();
        if MouseOverButton > 0 then
            GRM.UpdateGuildRosterTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.RosterShiftUp()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM.RosterShiftUp = function()
    if #GRM_UI.GRM_RosterFrame.Entries > 13 then
        local buttons = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons;
        local MouseOverButton = 0;

        for i = #buttons , 2 , -1 do

            buttons[i][2]:SetText( buttons[i-1][2]:GetText() );
            buttons[i][2]:SetTextColor ( buttons[i-1][2]:GetTextColor ( buttons[i-1][2]:GetText() ) );
            buttons[i][3]:SetText( buttons[i-1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i-1][3]:GetTextColor ( buttons[i-1][3]:GetText() ) );
            buttons[i][4]:SetText( buttons[i-1][4]:GetText() );
            buttons[i][4]:SetTextColor ( buttons[i-1][4]:GetTextColor ( buttons[i-1][4]:GetText() ) );
            buttons[i][5]:SetText( buttons[i-1][5]:GetText() );
            buttons[i][5]:SetTextColor ( buttons[i-1][5]:GetTextColor ( buttons[i-1][5]:GetText() ) );

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM.RosterSetFirstValue();
        if MouseOverButton > 0 then
            GRM.UpdateGuildRosterTooltip ( MouseOverButton );
        end
    end
end

-- Method:          GRM.RosterSetLastValue()
-- What it Does:    Sets the last value of the hybridscrollframe backups at position 16
-- Purpose:         Clean scrolling
GRM.RosterSetLastValue = function()
    GRM.SetGuildRosterValues ( #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset );
end

-- Method:          GRM.RosterSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe backups at position 1
-- Purpose:         Clean scrolling
GRM.RosterSetFirstValue = function()
    GRM.SetGuildRosterValues ( 1 , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons + 1 );
end

-- Method:          GRM.LoadRosterFrame()
-- What it Does:    Initializes load of the RosterFrame first time, and opens/closes it on subsequent uses.
-- Purpose:         Control load and use of Roster Frame.
GRM.LoadRosterFrame = function()
    if not GRM_G.RosterFrameInitialized then

        if IsInGuild() then
            if GRM.GetGuild() then
                GRM_UI.BuildRosterFrames();
                GRM_G.RosterFrameInitialized = true;

                -- Load saved position
                GRM_UI.GRM_RosterFrame:ClearAllPoints();
                if GRM.S().RosterFramePOS[1] == "" then
                    GRM_UI.GRM_RosterFrame:SetPoint ( "CENTER" , UIParent , "CENTER" , 0 , 0 );
                else
                    GRM_UI.GRM_RosterFrame:SetPoint ( GRM.S().RosterFramePOS[1] , UIParent , GRM.S().RosterFramePOS[2] , GRM.S().RosterFramePOS[3] , GRM.S().RosterFramePOS[4] );
                end
                
                GRM_UI.GRM_RosterFrame:Show();
            else
                GRM.Report ( GRM.L ( "One moment, GRM is still being configured." ) );
            end
        else
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Player is Not Currently in a Guild" ) );
        end

    elseif GRM_UI.GRM_RosterFrame:IsVisible() then
        GRM_UI.GRM_RosterFrame:Hide();

    else

        if GRM.GetGuild() then
            GRM_UI.GRM_RosterFrame:Show();
        else
            GRM.Report ( GRM.L ( "One moment, GRM is still being configured." ) );
        end
        
    end
end

-- Method:          GRM.InitializeRosterLoadButton ( frame , table , table , table )
-- What it Does:    Initializes the frames to load the roster button
-- Purpose:         So I can build this button for all versions of WOW and their various guild frameworks without repeating the code.
GRM_UI.InitializeRosterLoadButton = function ( parentFrame , points , size , textureSize )
    parentFrame.GRM_RosterTab = CreateFrame ( "Button" , "GRM_RosterTab" , parentFrame , "UIPanelButtonGrayTemplate" );
    GRM.CreateTexture ( parentFrame.GRM_RosterTab , "GRM_RosterIconTexture" , "OVERLAY" , false );

    parentFrame.GRM_RosterTab:SetSize ( size[1] , size[2] );
    parentFrame.GRM_RosterTab:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );

    if GRM_G.BuildVersion >= 80000 then
        parentFrame.GRM_RosterTab.GRM_RosterIconTexture:SetPoint ( "CENTER" , parentFrame.GRM_RosterTab , "CENTER" , 2.5 , -1.5 );
    else
        parentFrame.GRM_RosterTab.GRM_RosterIconTexture:SetPoint ( "CENTER" , parentFrame.GRM_RosterTab , "CENTER" , 0 , 0 );
    end

    parentFrame.GRM_RosterTab.GRM_RosterIconTexture:SetTexture ( "Interface\\AddOns\\Guild_Roster_Manager\\media\\Icons\\GRM_Logo.blp" );
    parentFrame.GRM_RosterTab.GRM_RosterIconTexture:SetWidth ( textureSize[1] );
    parentFrame.GRM_RosterTab.GRM_RosterIconTexture:SetHeight ( textureSize[2] );

    parentFrame.GRM_RosterTab:SetScript ( "OnEnter" , function ( self )
        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
        if IsInGuild() then
            local slashCommand = "/roster";
            if GRM_L["/YYYY"] ~= true then
                slashCommand = GRM_L["/YYYY"];
            end
            GameTooltip:AddLine ( GRM.L ( "GRM Custom Guild Roster" ) );
            GameTooltip:AddLine ( GRM.L ( "{custom1} to Open" , nil , nil , nil , slashCommand ) );
        else
            GameTooltip:AddLine ( GRM.L ( "Player is Not Currently in a Guild" ) );
        end

        GameTooltip:Show();
    end);
    parentFrame.GRM_RosterTab:SetScript ( "OnLeave" , function ()
        GRM.RestoreTooltip()
    end);

    parentFrame.GRM_RosterTab:SetScript ( "OnClick" , function ( _ , button)
        if button == "LeftButton" then
            GRM.LoadRosterFrame();
        end
    end);

end