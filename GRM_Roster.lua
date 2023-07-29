
-- Creating a new Guild Roster window
GRM_R = {};

-- Method:          GRM_R.BuildRosterFrames()
-- What it Does:    Initiates building of all o the Custom GRM Guild Roster window
-- Purpose:         Provide players more controls than default communities offers.
GRM_R.BuildRosterFrames = function ()

    local coreSize = 855;
    local coreHybridSize = 800;
    local anchorFrame1;

    if GRM_G.BuildVersion >= 80000 then
        coreSize = coreSize + 90;
        coreHybridSize = coreHybridSize + 90;
    end

    GRM_UI.CreateCoreFrame ( "GRM_RosterFrame" , GRM_UI , UIParent , coreSize , 525 , "TranslucentFrameTemplate" , true , { "CENTER" , UIParent , "CENTER" , 0 , 300 } , "MEDIUM" , true , true );
    GRM_UI.GRM_RosterFrame.SortType = 3;
    GRM_UI.GRM_RosterFrame.FormerSortType = 3;
    GRM_UI.GRM_RosterFrame:Hide();    

    if not GRM_UI.GRM_RosterFrame:GetScript("OnShow") then
        GRM_UI.GRM_RosterFrame:SetScript ( "OnShow" , function()
            GRM_R.RefreshRosterName();
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider.ThumbTexture:Show()
            GRM_UI.GRM_MemberDetailMetaData:Hide();
        end)
    end
    
    -- Must buiold hybrid first since columns will be pinned to it. 
    GRM_UI.CreateHybridScrollFrame ( "GRM_RosterFrameScrollFrame" , GRM_UI.GRM_RosterFrame , coreHybridSize , 400 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame , "BOTTOMLEFT" , 5 , 5 } , "TranslucentFrameTemplate" , GRM_R.BuildGuildRoster );

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameTitle" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Guild Roster" ) , 18 , { "TOP" , GRM_UI.GRM_RosterFrame , "TOP" , 0 , -17 } );
    
    -- Level
    GRM_UI.CreateButton ( "GRM_RosterColumnLvl" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Lvl" ) , 40 , 22 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameBorder, "TOPLEFT" , 10 , -3 } , GRM_R.SortLevel , "GameFontWhite" , 13 , "LEFT" , nil , -3  );

    -- Name
    GRM_UI.CreateButton ( "GRM_RosterColumnName" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Name" ) , 170 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnLvl, "RIGHT" , -1.5 , 0 } , GRM_R.SortNames , "GameFontWhite" , 13 , "LEFT" , nil , -3 );

    -- Last Online
    GRM_UI.CreateButton ( "GRM_RosterColumnLastOnline" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Last Online" ) , 150 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnName, "RIGHT" , -1.5 , 0 } , GRM_R.SortLastOnline , "GameFontWhite" , 13 , "LEFT" , nil , -3  );

    -- Rank
    GRM_UI.CreateButton ( "GRM_RosterColumnRank" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Rank" ) , 125 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnLastOnline, "RIGHT" , -1.5 , 0 } , GRM_R.SortRank , "GameFontWhite" , 13 , "LEFT" , nil , -3  );

    if GRM_G.BuildVersion >= 80000 then
        -- M+
        GRM_UI.CreateButton ( "GRM_RosterColumnMythicPlus" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "M+ Score" ) , 90 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnRank, "RIGHT" , -1.5 , 0 } , GRM_R.SortMythicScore , "GameFontWhite" , 13 , "LEFT" , nil , -3  );
        anchorFrame1 = GRM_UI.GRM_RosterFrame.GRM_RosterColumnMythicPlus;
    else
        anchorFrame1 = GRM_UI.GRM_RosterFrame.GRM_RosterColumnRank;
    end

    -- Note
    GRM_UI.CreateButton ( "GRM_RosterColumnNote" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Note" ) , 150 , 22 , { "LEFT" , anchorFrame1, "RIGHT" , -1.5 , 0 } , GRM_R.SortNote , "GameFontWhite" , 13 , "LEFT" , nil , -3 );

    -- OfficerNote
    GRM_UI.CreateButton ( "GRM_RosterColumnOfficerNote" , GRM_UI.GRM_RosterFrame , "ColumnDisplayButtonTemplate" , GRM.L ( "Officer's Note" ) , 150 , 22 , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnNote, "RIGHT" , -1.5 , 0 } , GRM_R.SortOfficerNote , "GameFontWhite" , 13 , "LEFT" , nil , -3 );
    
    -- Right click menu
    GRM_UI.CreateCoreFrame ( "GRM_RosterFrameDropDown" , GRM_UI.GRM_RosterFrame , nil , 110 , 177 , BackdropTemplateMixin and "BackdropTemplate" , false , nil , "FULLSCREEN_DIALOG" , false , true );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName = "";
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick = false

    GRM_UI.GRM_RosterFrame:SetScript ( "OnHide" , function()
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
    end)

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownName" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "GameFontNormal" , "" , 13 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "TOPLEFT" , 7 , -7 } , 100 , nil , "LEFT" , false );

    -- Promote
    GRM_UI.CreateButton ( "GRM_RosterDropDownPromote" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , "" , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName , "BOTTOMLEFT" , 0 , -1 } , nil , "GameFontWhite" , 12 , "LEFT" , 5 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:SetHitRectInsets ( -10 , 0 , -15 , -15 );  -- Necessary for :IsMouseOver() on the left side, to not hide

    -- Demote
    GRM_UI.CreateButton ( "GRM_RosterDropDownDemote" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , "" , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote , "BOTTOMLEFT" , 0 , -3 } , nil , "GameFontWhite" , 12 , "LEFT" , 5 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:SetHitRectInsets ( -10 , 0 , -15 , -15 );

    -- Kick
    GRM_UI.CreateButton ( "GRM_RosterDropDownKick" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Kick" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote , "BOTTOMLEFT" , 0 , -3 } , GRM_R.KickPlayer , "GameFontWhite" , 12 , "LEFT" , 5 );

    -- Divider
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownDivider" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "GameFontWhite" , "__________" , 12 , { "TOP" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick , "BOTTOM" , 0 , -10} , 100 , nil , "CENTER" , false );

    -- Whisper
    GRM_UI.CreateButton ( "GRM_RosterDropDownWhisper" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Whisper" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownDivider , "BOTTOMLEFT" , 0 , -5 } , GRM_R.RosterRightClickWhisper , "GameFontWhite" , 12 , "LEFT" , 5 );

    -- Cancel
    GRM_UI.CreateButton ( "GRM_RosterDropDownCancel" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Cancel" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownWhisper , "BOTTOMLEFT" , 0 , -3 } , GRM_R.RosterRightClickCancel , "GameFontWhite" , 12 , "LEFT" , 5 );

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
            GRM_R.BuildPromotionRankSelectionDropDown( self );
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
            GRM_R.BuildDemotionRankSelectionDropDown( self );
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

        GRM_UI.CreateButton ( "GRM_RosterDropDownRankButton" .. i , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank , nil , "" , ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:GetWidth() - 5 ) , 20 , points , GRM_R.RankSelection , "GameFontWhite" , 12 , "LEFT" , 10 , 0 );

        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton" .. i]:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank["GRM_RosterDropDownRankButton" .. i].destinationRank = 0;
    end

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:SetScript ( "OnHide" , function()
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Hide();
    end);

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetScript ( "OnLeave" , function( self )

        if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:IsMouseOver() and not GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:IsMouseOver() and not GRM_R.IsOverAnyRankSelectionButtons() then
            self:Hide();
        end        

    end)

    -- SEARCH EDIT BOX
    GRM_UI.CreateEditBox ( "GRM_RosterFrameNameEditBox" , GRM_UI.GRM_RosterFrame , "InputBoxTemplate" , 165 , 30 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnName , "TOPLEFT" , 5 , 2 } , "CENTER" , nil , 50 , false , GRM_R.NameSearchTT , GRM_R.TooltipReset , GRM_R.RefreshRosterName , true );

    -- Guild Roster Search Title
    GRM_UI.CreateString ( "GRM_RosterFrameNameEditBoxText" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Player Search" ) , 16 , { "BOTTOM" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox , "TOP" , 0 , 3 } , 155 , nil , "CENTER" , false );

    -- NOTE SEARCH EDIT BOX
    GRM_UI.CreateEditBox ( "GRM_RosterNoteEditBox" , GRM_UI.GRM_RosterFrame , "InputBoxTemplate" , 220 , 30 , { "BOTTOM" , GRM_UI.GRM_RosterFrame.GRM_RosterColumnNote , "TOPRIGHT" , 0 , 5 } , "LEFT" , nil , 31 , false , GRM_R.NoteSearchTT , GRM_R.TooltipReset , GRM_R.RefreshRosterName , true );

    -- Note Search Title
    GRM_UI.CreateString ( "GRM_RosterNoteEditBoxText" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Note Search" ) , 16 , { "BOTTOM" , GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox , "TOP" , 0 , 3 } , 225 , nil , "CENTER" , false );

    GRM_R.ClearPlayerSearch = function()
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:SetText("");
    end
    GRM_R.ClearNoteSearch = function()
        GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:SetText("");
    end
    
end

-- Method:          GRM_R.ResetColumnTextColors()
-- What it Does:    It changes the columm header text to emphasize where the sorting is happening.
-- Purpose:         Quality of life feature so you can know what is being sorted.
GRM_R.ResetColumnTextColors = function()

    local columnHeaders = { 
        { min = 1 , max = 2 , column = "GRM_RosterColumnName" } ,
        { min = 3 , max = 4 , column = "GRM_RosterColumnLastOnline" } , 
        { min = 5 , max = 6 , column = "GRM_RosterColumnRank" } , 
        { min = 7 , max = 8 , column = "GRM_RosterColumnLvl" } , 
        { min = 9 , max = 10 , column = "GRM_RosterColumnMythicPlus" } , 
        { min = 11 , max = 12 , column = "GRM_RosterColumnNote" } , 
        { min = 13 , max = 14 , column = "GRM_RosterColumnOfficerNote" } 
    };
    
    local function lookupValue ( input )
        local result = "";
        for _ , entry in ipairs ( columnHeaders ) do
            if input >= entry.min and input <= entry.max then
                result = entry.column;
                break;
            end
        end
        return result;
    end

    local sortFrame1 = lookupValue ( GRM_UI.GRM_RosterFrame.SortType );
    local sortFrame2 = lookupValue ( GRM_UI.GRM_RosterFrame.FormerSortType );

    -- Set back to white all default column text
    for _ , entry in ipairs ( columnHeaders ) do

        if entry.column ~= sortFrame1 and entry.column ~= sortFrame2 and ( entry.column ~= "GRM_RosterColumnMythicPlus" or GRM_G.BuildVersion >= 80000 ) then
            GRM_UI.GRM_RosterFrame[entry.column][entry.column.. "Text" ]:SetTextColor ( 1 , 1 , 1 );
        end

    end

    -- Set to color the selected columns
    GRM_UI.GRM_RosterFrame[sortFrame1][sortFrame1.. "Text" ]:SetTextColor ( 0 , 0.8 , 1 );
    if ( GRM_UI.GRM_RosterFrame.SortType == 5 or GRM_UI.GRM_RosterFrame.SortType == 6 ) and GRM_UI.GRM_RosterFrame.FormerSortType < 11 then
        GRM_UI.GRM_RosterFrame[sortFrame2][sortFrame2.. "Text" ]:SetTextColor ( 0 , 0.8 , 1 );
    elseif sortFrame1 ~= sortFrame2 then
        GRM_UI.GRM_RosterFrame[sortFrame2][sortFrame2.. "Text" ]:SetTextColor ( 1 , 1 , 1 );
    end

end

-- Method:          GRM_R.IsOverAnyRankSelectionButtons()
-- What it Does:    Returns true if over any mouseover button, for hide/show purposes/
-- Purpose:         Quality of life UI controls.
GRM_R.IsOverAnyRankSelectionButtons = function()
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

-- Method:          GRM_R.BuildPromotionRankSelectionDropDown ( buttonObject )
-- What it Does:    Builds the rankPromotionWindow
-- Purpose:         Easily give people ability to bump ranks with menus.
GRM_R.BuildPromotionRankSelectionDropDown = function ( buttonFrame )
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

-- Method:          GRM_R.BuildDemotionRankSelectionDropDown ( buttonObject )
-- What it Does:    Builds the rankDemotionWindow
-- Purpose:         Easily give people ability to bump ranks with menus.
GRM_R.BuildDemotionRankSelectionDropDown = function ( buttonFrame )
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

-- Method:          GRM_R.RankSelection ( buttonObject )
-- What it Does:    Determines to use the demote or promote logic
-- Purpose:         Quality of life feature
GRM_R.RankSelection = function( button )
    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote then
        GRM_R.PromotePlayer ( button )
    elseif GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.demote then
        GRM_R.DemotePlayer ( button )
    end
end

-- Method:          GRM_R.PromotePlayer ( button )
-- What it Does:    Takes the player to be promoted and builds macr otool
-- Purpose:         Quality of life feature for the custom guild roster
GRM_R.PromotePlayer = function ( button )
    local promoEntries = GRM.BuildCustomPromoteEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false , button );

    if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
        GRM_UI.GRM_ToolCoreFrame:Show();
    end

    GRM_UI.GRM_ToolCoreFrame.GRM_PromoTab:Click();
    GRM_UI.RefreshManagementTool( false , false , true , promoEntries );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_R.DemotePlayer ( button )
-- What it Does:    Takes the player to be Demoted and builds macro otool
-- Purpose:         Quality of life feature for the custom guild roster
GRM_R.DemotePlayer = function( button )
    local demoteEntries = GRM.BuildCustomDemoteEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false , button );

    if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
        GRM_UI.GRM_ToolCoreFrame:Show();
    end
    GRM_UI.GRM_ToolCoreFrame.GRM_DemoteTab:Click();

    GRM_UI.RefreshManagementTool( false , false , true , demoteEntries );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end


-- Method:          GRM_R.KickPlayer()
-- What it Does:    Takes the player to be kicked, builds it for the macro tool, and builds the macro
-- Purpose:         Quality of Life ease of taking advantage of the macro tool
GRM_R.KickPlayer = function()
    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick then
        local kickEntries = GRM.BuildCustomKickEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false );

        if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
            GRM_UI.GRM_ToolCoreFrame:Show();
        end
        GRM_UI.GRM_ToolCoreFrame.GRM_KickTab:Click();

        GRM_UI.RefreshManagementTool( false , false , true , kickEntries );
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
    end
end


-- Method:          GRM_R.SortNames( buttonObject , bool )
-- What it Does:    Sorts all of the names ascending or descending in the guild
-- Purpose:         For the Guild roster
GRM_R.SortNames = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType > 2 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 1;
        elseif GRM_UI.GRM_RosterFrame.SortType == 1 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 2;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 1;
        end
    end
    local members = GRM.GetAllMembersAsArray ( nameSearch , noteSearch );
    
    if GRM_UI.GRM_RosterFrame.SortType == 1 then
        sort ( members , function ( a , b ) return a.name < b.name end );
    else
        sort ( members , function ( a , b ) return a.name > b.name end );
    end

    GRM_R.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_R.SortLastOnline( buttonObject , bool )
-- What it Does:    Sorts all of the players by last online, longest or shortes
-- Purpose:         For the Guild roster
GRM_R.SortLastOnline = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
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

    local members = GRM.GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 3 then
        sort ( members , function ( a , b ) return a.lastOnline < b.lastOnline end );
    else
        sort ( members , function ( a , b ) return a.lastOnline > b.lastOnline end );
    end

    GRM_R.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_R.SortMythicScore ( buttonObject, bool )
-- What it Does:    Sorts the players by M+ Score
-- Purpose:         For the GRM Guild Roster
GRM_R.SortMythicScore = function ( _ , keepType )
    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 9 and GRM_UI.GRM_RosterFrame.SortType ~= 10 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 9;
        elseif GRM_UI.GRM_RosterFrame.SortType == 9 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 10;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 9;
        end
    end

    local members = GRM.GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 9 then
        sort ( members , function ( a , b ) return a.MythicScore > b.MythicScore end );
    else
        sort ( members , function ( a , b ) return a.MythicScore < b.MythicScore end );
    end

    GRM_R.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_R.SortNote ( buttonObject , bool )
-- What it Does:    Sorts all of the names ascending or descending in the guild
-- Purpose:         For the Guild roster
GRM_R.SortNote = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 11 and GRM_UI.GRM_RosterFrame.SortType ~= 12 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 11;
        elseif GRM_UI.GRM_RosterFrame.SortType == 11 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 12;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 11;
        end
    end
    local members = GRM.GetAllMembersAsArray ( nameSearch , noteSearch );
    
    if GRM_UI.GRM_RosterFrame.SortType == 11 then
        sort ( members , function ( a , b ) return a.note < b.note end );
    else
        sort ( members , function ( a , b ) return a.note > b.note end );
    end

    GRM_R.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_R.SortOfficerNote ( buttonObject , bool )
-- What it Does:    Sorts all of the names ascending or descending in the guild
-- Purpose:         For the Guild roster
GRM_R.SortOfficerNote = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 13 and GRM_UI.GRM_RosterFrame.SortType ~= 14 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 13;
        elseif GRM_UI.GRM_RosterFrame.SortType == 13 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 14;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 13;
        end
    end
    local members = GRM.GetAllMembersAsArray ( nameSearch , noteSearch );
    
    if GRM_UI.GRM_RosterFrame.SortType == 13 then
        sort ( members , function ( a , b ) return a.officerNote < b.officerNote end );
    else
        sort ( members , function ( a , b ) return a.officerNote > b.officerNote end );
    end

    GRM_R.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_R.SortRank( buttonObject , bool )
-- What it Does:    Sorts all of the names by guild rank, highest to lowest.
-- Purpose:         For the Guild roster
GRM_R.SortRank = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 5 and GRM_UI.GRM_RosterFrame.SortType ~= 6 then
            if GRM_UI.GRM_RosterFrame.SortType < 5 or ( GRM_UI.GRM_RosterFrame.SortType > 6 and GRM_UI.GRM_RosterFrame.SortType < 11 ) then
                GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            end
            GRM_UI.GRM_RosterFrame.SortType = 5;
        elseif GRM_UI.GRM_RosterFrame.SortType == 5 then
            GRM_UI.GRM_RosterFrame.SortType = 6;
        elseif GRM_UI.GRM_RosterFrame.SortType == 6 then
            GRM_UI.GRM_RosterFrame.FormerSortType = 6;      -- After the 3rd press it no longer includes the previous name or level sorting.
            GRM_UI.GRM_RosterFrame.SortType = 5;
        end
    end

    local members = GRM.GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 5 then
        sort ( members , function ( a , b ) return a.rankIndex < b.rankIndex end );
    else
        sort ( members , function ( a , b ) return a.rankIndex > b.rankIndex end );
    end

    -- Sort names alphabetically, within each rank
    if GRM_UI.GRM_RosterFrame.FormerSortType == 1 then
        members = GRM_R.SortAlphabeticallyWithinRank ( members , 1 );
    -- Sort names alphabetically, within each rank
    elseif GRM_UI.GRM_RosterFrame.FormerSortType == 2 then
        members = GRM_R.SortAlphabeticallyWithinRank ( members , 2 );
    elseif GRM_UI.GRM_RosterFrame.FormerSortType == 3 then
        members = GRM_R.SortLastOnlineWithinRank ( members , 3 );
    elseif GRM_UI.GRM_RosterFrame.FormerSortType == 4 then
        members = GRM_R.SortLastOnlineWithinRank ( members , 4 );
    -- Sort names by max level decending, within each rank
    elseif GRM_UI.GRM_RosterFrame.FormerSortType == 7 then
        members = GRM_R.SortByLevelWithinRank ( members , 7 );
        -- Sort names by max level ascending, within each rank
    elseif GRM_UI.GRM_RosterFrame.FormerSortType == 8 then
        members = GRM_R.SortByLevelWithinRank ( members , 8 );
           -- Sort names by max level ascending, within each rank
    elseif GRM_UI.GRM_RosterFrame.FormerSortType == 9 then
        members = GRM_R.SortByMythicWithinRank ( members , 9 );
           -- Sort names by max level ascending, within each rank
    elseif GRM_UI.GRM_RosterFrame.FormerSortType == 10 then
        members = GRM_R.SortByMythicWithinRank ( members , 10 );
    end

    GRM_R.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_R.SortAlphabeticallyWithinRank ( table, int )
-- What it Does:    Takes the already sorted table, then sub-sorts the ranks alphabetically ascending or descending
-- Purpose:         Greater control of sorting on the roster.
GRM_R.SortAlphabeticallyWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        -- Working on same rank group
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        -- rank group has changed, or we are on the final rank
        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 1 then
                sort ( rankGrouping , function ( a , b ) return a.name < b.name end );
            elseif sortType == 2 then
                sort ( rankGrouping , function ( a , b ) return a.name > b.name end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortLastOnlineWithinRank ( table, int )
-- What it Does:    Takes the already sorted table, then sub-sorts the ranks by last online ascending or descending
-- Purpose:         Greater control of sorting on the roster.
GRM_R.SortLastOnlineWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        -- Working on same rank group
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        -- rank group has changed, or we are on the final rank
        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 3 then
                sort ( rankGrouping , function ( a , b ) return a.lastOnline < b.lastOnline end );
            elseif sortType == 4 then
                sort ( rankGrouping , function ( a , b ) return a.lastOnline > b.lastOnline end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByLevelWithinRank ( table, int )
-- What it Does:    Takes the already sorted table, then sub-sorts the ranks by level ascending or descending
-- Purpose:         Greater control of sorting on the roster.
GRM_R.SortByLevelWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        -- Working on same rank group
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        -- rank group has changed, or we are on the final rank
        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 7 then
                sort ( rankGrouping , function ( a , b ) return a.level > b.level end );
            elseif sortType == 8 then
                sort ( rankGrouping , function ( a , b ) return a.level < b.level end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByMythicWithinRank ( table, int )
-- What it Does:    Takes the already sorted table, then sub-sorts the ranks by Mythic Score ascending or descending
-- Purpose:         Greater control of sorting on the roster.
GRM_R.SortByMythicWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        -- Working on same rank group
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        -- rank group has changed, or we are on the final rank
        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 9 then
                sort ( rankGrouping , function ( a , b ) return a.MythicScore > b.MythicScore end );
            elseif sortType == 10 then
                sort ( rankGrouping , function ( a , b ) return a.MythicScore < b.MythicScore end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortLevel( buttonObject , bool )
-- What it Does:    Sorts all of the names by player level, highest to lowest or reverse
-- Purpose:         For the Guild roster
GRM_R.SortLevel = function ( _ , keepType )

    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();
    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 7 and GRM_UI.GRM_RosterFrame.SortType ~= 8 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 7;
        elseif GRM_UI.GRM_RosterFrame.SortType == 7 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 8;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 7;
        end
    end

    local members = GRM.GetAllMembersAsArray ( nameSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 7 then
        sort ( members , function ( a , b ) return a.level > b.level end );
    else
        sort ( members , function ( a , b ) return a.level < b.level end );
    end

    GRM_R.BuildGuildRoster ( true , true , members );
end

-- Method:          GRM_R.RosterRightClickCancel()
-- What it Does:    Hides the right click context menu in the custom GRM Guild Roster
-- Purpose:         Passthrough function for the button build tool
GRM_R.RosterRightClickCancel = function()
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_R.RosterRightClickWhisper()
-- What it Does:    Initializes a whisper to the given player
-- Purpose:         To give the player the ability to easily right click-whisper someone.
GRM_R.RosterRightClickWhisper = function()

    ChatFrame1EditBox:SetFocus()
    ChatFrame1EditBox:Insert ( "/w " .. GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName .. " " );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_R.RefreshRosterName()
-- What it Does:    Refreshes the guild custom roster
-- Purpose:         Refresh the frame without resorting...
GRM_R.RefreshRosterName = function ()

    if GRM_UI.GRM_RosterFrame.SortType < 3 then
        GRM_R.SortNames ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 3 or GRM_UI.GRM_RosterFrame.SortType == 4 then
        GRM_R.SortLastOnline ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 5 or GRM_UI.GRM_RosterFrame.SortType == 6 then
        GRM_R.SortRank ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 7 or GRM_UI.GRM_RosterFrame.SortType == 8 then
        GRM_R.SortLevel ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 9 or GRM_UI.GRM_RosterFrame.SortType == 10 then
        GRM_R.SortMythicScore ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 11 or GRM_UI.GRM_RosterFrame.SortType == 12 then
        GRM_R.SortNote ( nil , true );
    elseif GRM_UI.GRM_RosterFrame.SortType == 13 or GRM_UI.GRM_RosterFrame.SortType == 14 then
        GRM_R.SortOfficerNote( nil , true );
    end

end

-- Method:          GRM_R.BuildGuildRoster ( bool , bool , table )
-- What it Does:    Updates the Queued scrollframe as needed
-- Purpose:         UX of the GRM mass kick tool
GRM_R.BuildGuildRoster = function ( showAll , fullRefresh , entries )
    local hybridScrollFrameButtonCount = 15;
    local buttonHeight = 25;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetWidth() - 5;
    if showAll and fullRefresh then

        if entries then
            GRM_UI.GRM_RosterFrame.Entries = entries
        else
            GRM_R.SortNames();
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
                local button2 = CreateFrame ( "Button" , "Button2TT_" .. i , button );
                local button3 = CreateFrame ( "Button" , "Button3TT_" .. i , button );
                GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i] = {
                    button ,
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- Level
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- Name
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- Last Online
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),       -- Rank
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),       -- Mythic+
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),       -- Note
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),       -- Officer Note
                    button2,    -- Button for mouseover "OnEnter" for tooltip of note
                    button3     -- Same, but for officer note

                };

                button = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i][1];
                if i == 1 then
                    button:SetPoint ( "TOP" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , "TOP" , 9 , 7 );
                else 
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                button:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );
                GRM_R.BuildGuildRosterButtons ( i  , false );
                
            end
        end

        if i >= ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount + 1 ) and i <= GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset then
            GRM_R.SetGuildRosterValues ( i - ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount ) , i );
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
        GRM_R.RosterShiftDown , GRM_R.RosterShiftUp , hybridScrollFrameButtonCount
    );

    GRM_R.ResetColumnTextColors();
end

-- Method:          GRM_R.BuildGuildRosterButtons ( int , boolean )
-- What it Does:    Initiates the buttons and their values for each line of custom roster
-- Purpose:         Create a smooth scrolling experience in the GRM kick window
GRM_R.BuildGuildRosterButtons = function ( ind , isResizeAction )
    local coreButton = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1];
    local buttonText1 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][2];
    local buttonText2 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3];
    local buttonText3 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][4];
    local buttonText4 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][5];
    local buttonText5 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][6];
    local buttonText6 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][7];
    local buttonText7 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][8];
    local buttonTTNote = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][9];
    local buttonTTNote2 = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][10];

    -- Name
    buttonText1:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText2:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText3:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText4:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText5:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText6:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );
    buttonText7:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 11 );

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

        -- Mythic+
        if GRM_G.BuildVersion >= 80000 then
            buttonText5:SetPoint ( "LEFT" , buttonText4 , "RIGHT" , 9 , 0 );
            buttonText5:SetJustifyH ( "LEFT" );
            buttonText5:SetWidth ( 80 )
            buttonText5:SetWordWrap ( false );

            buttonText6:SetPoint ( "LEFT" , buttonText5 , "RIGHT" , 9 , 0 );
        else
            buttonText6:SetPoint ( "LEFT" , buttonText4 , "RIGHT" , 9 , 0 );
        end
        
        buttonText6:SetJustifyH ( "LEFT" );
        buttonText6:SetWidth ( 140 )
        buttonText6:SetWordWrap ( false );

        buttonText7:SetPoint ( "LEFT" , buttonText6 , "RIGHT" , 9 , 0 );
        buttonText7:SetJustifyH ( "LEFT" );
        buttonText7:SetWidth ( 140 )
        buttonText7:SetWordWrap ( false );

        buttonTTNote:SetPoint ( "LEFT" , buttonText6 , "LEFT" , 1 , 0 );
        buttonTTNote:SetSize ( 150 , coreButton:GetHeight() );
        buttonTTNote2:SetPoint ( "LEFT" , buttonTTNote , "RIGHT" , 0 , 0 );
        buttonTTNote2:SetSize ( 150 , coreButton:GetHeight() );

        coreButton:EnableMouse ( true );
        coreButton:RegisterForDrag ( "LeftButton" );

        buttonTTNote:EnableMouse ( true );
        buttonTTNote:RegisterForDrag ( "LeftButton" );

        buttonTTNote2:EnableMouse ( true );
        buttonTTNote2:RegisterForDrag ( "LeftButton" );
        
        -- Setup draggable conditions
        coreButton:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_RosterFrame:StartMoving();
        end);
        coreButton:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_RosterFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( GRM_UI.GRM_RosterFrame );
        end);
        buttonTTNote:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_RosterFrame:StartMoving();
        end);
        buttonTTNote:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_RosterFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( GRM_UI.GRM_RosterFrame );
        end);
        buttonTTNote2:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_RosterFrame:StartMoving();
        end);
        buttonTTNote2:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_RosterFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( GRM_UI.GRM_RosterFrame );
        end);
        
        local ButtonClickFunction = function( button , buttonType )
            local playerName = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3]:GetText();

            if buttonType == "LeftButton" then
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
                
            elseif buttonType == "RightButton" then
                GRM_UI.RestoreTooltipScale();
                GameTooltip:Hide();

                local player = GRM.GetPlayer ( playerName );
                GRM_G.playerRankID = GRM.GetGuildMemberRankID ( GRM_G.addonUser );

                if player then

                    -- Set Name
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName = playerName;
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName:SetText ( GRM.SlimName ( playerName ) );
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName:SetTextColor ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3]:GetTextColor() );

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
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:SetPoint ( "TOPRIGHT" , button , "TOPLEFT" , -10 , 0 );
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Show();

                else
                    GRM_R.RefreshRosterName();
                end

            end
        end

        coreButton:SetScript ( "OnMouseDown" , function ( self , button )
            ButtonClickFunction ( self , button );
        end);

        -- Create Tooltip
        if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip then
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip = CreateFrame ( "GameTooltip" , "GRM_RosterFrameNoteTooltip" , nil , "GameTooltipTemplate" );

            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:SetScale ( 0.65 );

        end

        coreButton:SetScript ( "OnEnter" , function ()
            GRM_R.UpdateGuildRosterTooltip( ind );
        end);

        coreButton:SetScript ( "OnLeave" , function()
            GRM.RestoreTooltip();
        end);

        buttonTTNote:SetScript ( "OnEnter" , function ( self )
            GRM_R.UpdateNoteText ( self , ind , 7 );
            GRM_R.UpdateGuildRosterTooltip( ind );
        end);

        buttonTTNote:SetScript ( "OnLeave" , function()
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Hide();
            coreButton:UnlockHighlight();
        end);
        
        buttonTTNote:SetScript ( "OnMouseDown" , function ( _ , button )
            ButtonClickFunction ( coreButton , button );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Hide();
        end);

        buttonTTNote2:SetScript ( "OnEnter" , function ( self )
            GRM_R.UpdateNoteText ( self , ind , 8 );
            GRM_R.UpdateGuildRosterTooltip( ind );
        end);

        buttonTTNote2:SetScript ( "OnLeave" , function()
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Hide();
            coreButton:UnlockHighlight();
        end);

        buttonTTNote2:SetScript ( "OnMouseDown" , function ( _ , button )
            ButtonClickFunction ( coreButton , button );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Hide();
        end);

    end
end

-- Method:          GRM_R.UpdateGuildRosterTooltip ( int )
-- What it Does:    Sets the tooltip for the Custom GRM scrollframe in the GRM kick tool
-- Purpose:         Make it clear the QoL controls.
GRM_R.UpdateGuildRosterTooltip = function ( ind )
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

-- Method:          GRM_R.UpdateNoteText ( int , int )
-- What it Does:    Updates the tooltip on the GRM Roster
-- Purpose:         As you scroll the tooltip should update.
GRM_R.UpdateNoteText = function ( button , ind , index2 )
    local text = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][index2]:GetText();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1]:LockHighlight();

    if text and text ~= "" then
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:SetOwner ( button , "ANCHOR_CURSOR" );
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:SetText( text , 1 , 1 , 1 , 1 , true);
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Show();
    end
end

-- Method:          GRM_UI.NameSearchTT( frameObject )
-- What it Does:    Builds tooltip for search box
-- Purpose:         To be re-used, so adding to a function
GRM_R.NameSearchTT = function ( frameObject )
    GRM_UI.SetTooltipScale()
    GameTooltip:SetOwner ( frameObject , "ANCHOR_CURSOR" );
    GameTooltip:AddLine( GRM.L ( "Search to find a player quicker" ) );
    GameTooltip:Show();
end

-- Method:          GRM_UI.NoteSearchTT( frameObject )
-- What it Does:    Builds tooltip for search box
-- Purpose:         To be re-used, so adding to a function
GRM_R.NoteSearchTT = function ( frameObject )
    GRM_UI.SetTooltipScale()
    GameTooltip:SetOwner ( frameObject , "ANCHOR_CURSOR" );
    GameTooltip:AddLine( GRM.L ( "Search Public and Officer Notes" ) );
    GameTooltip:Show();
end

-- Method:          GRM_UI.RestoreTooltip()
-- What it Does:    Closes tooltip
-- Purpose:         To be re-used, so adding to a function
GRM_R.TooltipReset = function()
    GRM.RestoreTooltip();
end

-- Method:          GRM_R.SetGuildRosterValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
-- Purpose:         Hybrid ScrollFrame tool
GRM_R.SetGuildRosterValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind];

    -- Player Name
    line[2]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].level );
    line[3]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].name );
    line[3]:SetTextColor ( GRM_UI.GRM_RosterFrame.Entries[ind2].classColor[1] , GRM_UI.GRM_RosterFrame.Entries[ind2].classColor[2] , GRM_UI.GRM_RosterFrame.Entries[ind2].classColor[3] );
    line[4]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].hoursReport );
    if GRM_UI.GRM_RosterFrame.Entries[ind2].hoursReport == GRM.L ( "Online" ) then
        line[4]:SetTextColor( 0.12 , 1 , 0 );
    else
        line[4]:SetTextColor ( 1 , 1 , 1);
    end
    line[5]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].rankName );

    if GRM_G.BuildVersion >= 80000 then
        line[6]:SetText ( GRM.GetMythicRatingToMatchRaiderIO ( GRM_UI.GRM_RosterFrame.Entries[ind2].MythicScore ) .. GRM_UI.GRM_RosterFrame.Entries[ind2].MythicScore );
    end

    line[7]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].note );
    line[8]:SetText ( GRM_UI.GRM_RosterFrame.Entries[ind2].officerNote );

    -- Update the tooltip if underlying data changes
    if GameTooltip:IsVisible() and GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1]:IsMouseOver() then 
        GRM_R.UpdateGuildRosterTooltip ( ind );
    end

    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:IsVisible() and GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1]:IsMouseOver() then
        if GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][9]:IsMouseOver() then
            GRM_R.UpdateNoteText ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][9] , ind , 7 );
        elseif GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][10]:IsMouseOver() then  
            GRM_R.UpdateNoteText ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][10] , ind , 8 );
        end
    end
end

-- Method:          GRM_R.RosterShiftDown()
-- What it Does:    Shifts all the values DOWN one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM_R.RosterShiftDown = function()
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

            if GRM_G.BuildVersion >= 80000 then
                buttons[i][6]:SetText( buttons[i+1][6]:GetText() );
                buttons[i][6]:SetTextColor ( buttons[i+1][6]:GetTextColor ( buttons[i+1][6]:GetText() ) );
            end

            buttons[i][7]:SetText( buttons[i+1][7]:GetText() );
            buttons[i][7]:SetTextColor ( buttons[i+1][7]:GetTextColor ( buttons[i+1][7]:GetText() ) );

            buttons[i][8]:SetText( buttons[i+1][8]:GetText() );
            buttons[i][8]:SetTextColor ( buttons[i+1][8]:GetTextColor ( buttons[i+1][8]:GetText() ) );

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM_R.RosterSetLastValue();
        if MouseOverButton > 0 then
            GRM_R.UpdateGuildRosterTooltip ( MouseOverButton );

            if GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:IsVisible() then
                if GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][9]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][9] , MouseOverButton , 7 );
                elseif GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][10]:IsMouseOver() then  
                    GRM_R.UpdateNoteText ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][10] , MouseOverButton , 8 );
                end
            end
        end
    end
end

-- Method:          GRM_R.RosterShiftUp()
-- What it Does:    Shifts all the values up one line to give the illusion of scrolling when in reality this is just a hybrid scrollframe
-- Purpose:         Clean scrolling
GRM_R.RosterShiftUp = function() 
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

            if GRM_G.BuildVersion >= 80000 then
                buttons[i][6]:SetText( buttons[i-1][6]:GetText() );
                buttons[i][6]:SetTextColor ( buttons[i-1][6]:GetTextColor ( buttons[i-1][6]:GetText() ) );
            end

            buttons[i][7]:SetText( buttons[i-1][7]:GetText() );
            buttons[i][7]:SetTextColor ( buttons[i-1][7]:GetTextColor ( buttons[i-1][7]:GetText() ) );

            buttons[i][8]:SetText( buttons[i-1][8]:GetText() );
            buttons[i][8]:SetTextColor ( buttons[i-1][8]:GetTextColor ( buttons[i-1][8]:GetText() ) );

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM_R.RosterSetFirstValue();
        if MouseOverButton > 0 then
            GRM_R.UpdateGuildRosterTooltip ( MouseOverButton );

            if GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:IsVisible() then
                if GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][9]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][9] , MouseOverButton , 7 );
                elseif GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][10]:IsMouseOver() then  
                    GRM_R.UpdateNoteText ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[MouseOverButton][10] , MouseOverButton , 8 );
                end
            end

        end
    end
end

-- Method:          GRM_R.RosterSetLastValue()
-- What it Does:    Sets the last value of the hybridscrollframe backups at position 16
-- Purpose:         Clean scrolling
GRM_R.RosterSetLastValue = function()
    GRM_R.SetGuildRosterValues ( #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset );
end

-- Method:          GRM_R.RosterSetFirstValue()
-- What it Does:    Sets the first value of the hybridscrollframe backups at position 1
-- Purpose:         Clean scrolling
GRM_R.RosterSetFirstValue = function()
    GRM_R.SetGuildRosterValues ( 1 , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons + 1 );
end

-- Method:          GRM_R.LoadRosterFrame()
-- What it Does:    Initializes load of the RosterFrame first time, and opens/closes it on subsequent uses.
-- Purpose:         Control load and use of Roster Frame.
GRM_R.LoadRosterFrame = function( firstLoad )
    if not GRM_G.RosterFrameInitialized then

        if IsInGuild() then
            if GRM.GetGuild() then
                GRM_R.BuildRosterFrames();
                GRM_G.RosterFrameInitialized = true;

                -- Load saved position
                GRM_UI.GRM_RosterFrame:ClearAllPoints();
                if GRM.S().RosterFramePOS[1] == "" then
                    GRM_UI.GRM_RosterFrame:SetPoint ( "CENTER" , UIParent , "CENTER" , 0 , 0 );
                else
                    GRM_UI.GRM_RosterFrame:SetPoint ( GRM.S().RosterFramePOS[1] , UIParent , GRM.S().RosterFramePOS[2] , GRM.S().RosterFramePOS[3] , GRM.S().RosterFramePOS[4] );
                end
                
                if not firstLoad then
                    GRM_UI.GRM_RosterFrame:Show();
                end
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

-- Method:          GRM_R.InitializeRosterLoadButton ( frame , table , table , table )
-- What it Does:    Initializes the frames to load the roster button
-- Purpose:         So I can build this button for all versions of WOW and their various guild frameworks without repeating the code.
GRM_R.InitializeRosterLoadButton = function ( parentFrame , points , size , textureSize )
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
            GRM_R.LoadRosterFrame();
        end
    end);

end