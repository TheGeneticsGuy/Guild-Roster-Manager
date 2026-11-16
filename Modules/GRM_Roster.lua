-- Creating a new Guild Roster window
local GRM_R = {};

-- Master Column Definitions
local ColumnDefs = {
    { id = "lvl",        header = "GRM_RosterColumnLvl",         width = 40,  textIdx = 2,  sortMin = 7,  sortMax = 8,  sortFunc = "SortLevel",       labelKey = "Lvl" },
    { id = "name",       header = "GRM_RosterColumnName",        width = 200, textIdx = 3,  sortMin = 1,  sortMax = 2,  sortFunc = "SortNames",       labelKey = "Name", required = true },
    { id = "nickname",   header = "GRM_RosterColumnNickname",    width = 160, textIdx = 13, sortMin = 17, sortMax = 18, sortFunc = "SortNickname",    labelKey = "Nickname" },
    { id = "lastOnline", header = "GRM_RosterColumnLastOnline",  width = 150, textIdx = 4,  sortMin = 3,  sortMax = 4,  sortFunc = "SortLastOnline",  labelKey = "Last Online" },
    { id = "rank",       header = "GRM_RosterColumnRank",        width = 125, textIdx = 5,  sortMin = 5,  sortMax = 6,  sortFunc = "SortRank",        labelKey = "Rank" },
    { id = "mplus",      header = "GRM_RosterColumnMythicPlus",  width = 90,  textIdx = 6,  sortMin = 9,  sortMax = 10, sortFunc = "SortMythicScore", labelKey = "M+ Score", bfaOnly = true },
    { id = "note",       header = "GRM_RosterColumnNote",        width = 150, textIdx = 7,  sortMin = 11, sortMax = 12, sortFunc = "SortNote",        labelKey = "Note",           ttIdx = 10, isNote = true },
    { id = "onote",      header = "GRM_RosterColumnOfficerNote", width = 150, textIdx = 8,  sortMin = 13, sortMax = 14, sortFunc = "SortOfficerNote", labelKey = "Officer's Note", ttIdx = 11, isNote = true },
    { id = "cnote",      header = "GRM_RosterColumnCustomNote",  width = 150, textIdx = 9,  sortMin = 15, sortMax = 16, sortFunc = "SortCustomNote",  labelKey = "Custom Note",    ttIdx = 12, isNote = true },
    -- Optional Columns (Start in Unused by default!)
    { id = "class",      header = "GRM_RosterColumnClass",       width = 110, textIdx = 14, sortMin = 19, sortMax = 20, sortFunc = "SortClass",       labelKey = "Class" },
    { id = "race",       header = "GRM_RosterColumnRace",        width = 115, textIdx = 15, sortMin = 21, sortMax = 22, sortFunc = "SortRace",        labelKey = "Race" },
    { id = "joinDate",   header = "GRM_RosterColumnJoinDate",    width = 115, textIdx = 16, sortMin = 23, sortMax = 24, sortFunc = "SortJoinDate",    labelKey = "Join Date" },
    { id = "bday",       header = "GRM_RosterColumnBirthday",    width = 105, textIdx = 17, sortMin = 25, sortMax = 26, sortFunc = "SortBirthday",    labelKey = "Birthday" },
    { id = "rep",        header = "GRM_RosterColumnReputation",  width = 115, textIdx = 18, sortMin = 27, sortMax = 28, sortFunc = "SortReputation",  labelKey = "Reputation", cataOnly = true },
};

local ColumnDefById = {};

for _, def in ipairs(ColumnDefs) do
    ColumnDefById[def.id] = def;
end

-- Helper: Checks if a column is supported in the current game expansion
local function IsColumnSupported(def)
    if not def then
        return false
    end
    if def.bfaOnly and GRM_G.BuildVersion < GRM_ENUM.BUILD.BFA then
        return false
    end
    if def.cataOnly and GRM_G.BuildVersion < GRM_ENUM.BUILD.CATA then
        return false
    end
    return true;
end

-- Returns the default ordered array of column IDs (Optional columns stay in Unused by default)
local function GetDefaultRosterColumns()
    if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA then
        return { "lvl", "name", "nickname", "lastOnline", "rank", "mplus", "note", "onote", "cnote" };
    else
        return { "lvl", "name", "nickname", "lastOnline", "rank", "note", "onote", "cnote" };
    end
end

-- Ensures GRM.S().rosterColumns is initialized and valid for the current game build
local function EnsureRosterColumnsValid()
    if not GRM.S() then
        return GetDefaultRosterColumns()
    end
    if type(GRM.S().rosterColumns) ~= "table" or #GRM.S().rosterColumns == 0 then
        GRM.S().rosterColumns = GetDefaultRosterColumns();
    end

    local validList = {};
    local seen = {};
    local hasName = false;

    for _, id in ipairs(GRM.S().rosterColumns) do
        local def = ColumnDefById[id];
        if def and not seen[id] and IsColumnSupported(def) then
            table.insert(validList, id);
            seen[id] = true;
            if id == "name" then
                hasName = true
            end
        end
    end

    if not hasName then
        table.insert(validList, 1, "name");
    end

    GRM.S().rosterColumns = validList;
    return validList;
end

-- Helper: Smart Nickname Comparator (keeps players WITH nicknames at the top, and empty nicknames at the bottom)
local function CompareNicknames(a, b, isAscending)
    local nickA = (a.nickname and a.nickname ~= "") and string.lower(a.nickname) or nil;
    local nickB = (b.nickname and b.nickname ~= "") and string.lower(b.nickname) or nil;

    if nickA and not nickB then
        return true
    end
    if not nickA and nickB then
        return false
    end
    if not nickA and not nickB then
        return a.name < b.name
    end
    if nickA == nickB then
        return a.name < b.name
    end

    if isAscending then
        return nickA < nickB;
    else
        return nickA > nickB;
    end
end

-- Helper: Smart Nullable Value Comparator (keeps valid values at the top, and nil/unknown values at the bottom)
local function CompareNullableValues(valA, valB, nameA, nameB, isAscending)
    if valA ~= nil and valB == nil then
        return true
    end
    if valA == nil and valB ~= nil then
        return false
    end
    if valA == nil and valB == nil then
        return nameA < nameB
    end
    if valA == valB then
        return nameA < nameB
    end

    if isAscending then
        return valA < valB;
    else
        return valA > valB;
    end
end

-- Method:          GRM_UI.LoadRosterFrame()
GRM_UI.LoadRosterFrame = function( firstLoad )
    if not GRM_G.RosterFrameInitialized then
        if IsInGuild() then
            if not GRM_G.currentlyPatching and GRM.GetGuild() and GRM.S() then
                GRM_UI.BuildRosterFrames();
                GRM_G.RosterFrameInitialized = true;

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
        if GRM.GetGuild() and GRM.S() then
            GRM_UI.GRM_RosterFrame:Show();
        else
            GRM.Report ( GRM.L ( "One moment, GRM is still being configured." ) );
        end
    end
end

-- Method:          GRM_UI.InitializeRosterLoadButton ( frame , table , table , table )
GRM_UI.InitializeRosterLoadButton = function ( parentFrame , points , size , textureSize )
    parentFrame.GRM_RosterTab = CreateFrame ( "Button" , "GRM_RosterTab" , parentFrame , "UIPanelButtonGrayTemplate" );
    GRM.CreateTexture ( parentFrame.GRM_RosterTab , "GRM_RosterIconTexture" , "OVERLAY" , false );

    parentFrame.GRM_RosterTab:SetSize ( size[1] , size[2] );
    parentFrame.GRM_RosterTab:SetPoint ( points[1] , points[2] , points[3] , points[4] , points[5] );
    parentFrame.GRM_RosterTab.GRM_RosterIconTexture:SetPoint ( "CENTER" , parentFrame.GRM_RosterTab , "CENTER" , 2.5 , -1.5 );

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
            GRM_UI.LoadRosterFrame();
        end
    end);
end

-- Method:          GRM_UI.ConfigureMacroForRightClick ( int , table )
GRM_UI.ConfigureMacroForRightClick = function ( tabNum , entries )
    GRM_UI.GRM_ToolCoreFrame.TabPosition = tabNum;
    C_Timer.After ( 0.1 , function()
        GRM_UI.ConfigureToolTab();
        if GRM_UI.GRM_ToolCoreFrame.rightClickMode and #GRM_UI.GRM_ToolCoreFrame.QueuedEntries > 0 then
            if ( entries[1].action == "Kick" and GRM_UI.GRM_ToolCoreFrame.QueuedEntries[1].action == "Kick" ) or (
                ( entries[1].action == "Promote" or entries[1].action == "Demote" ) and ( GRM_UI.GRM_ToolCoreFrame.QueuedEntries[1].action == "Promote" or GRM_UI.GRM_ToolCoreFrame.QueuedEntries[1].action == "Demote" ) ) then

                for i = 1, #entries do
                    table.insert(GRM_UI.GRM_ToolCoreFrame.QueuedEntries , entries[i] );
                end
                entries = GRM_UI.GRM_ToolCoreFrame.QueuedEntries;
            else
                local msg = "";
                if entries[1].action == "Kick" then
                    msg = GRM.L ( "Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to Kick will remove {num} player(s) you currently have queued up for rank changes." , nil , nil , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries ) .. "\n\n" .. GRM.L ( "Do you wish to continue?" );
                elseif entries[1].action == "Promote" or entries[1].action == "Demote" then
                    msg = GRM.L ( "Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to {custom1} will remove {num} player(s) you currently have qued up to kick.", nil , nil , #GRM_UI.GRM_ToolCoreFrame.QueuedEntries , entries[1].action ) .. "\n\n" .. GRM.L ( "Do you wish to continue?" );
                end
                local confirmLogic = function()
                    GRM_UI.GRM_ToolCoreFrame.rightClickMode = true;
                    GRM_UI.RefreshManagementTool( entries );
                end

                GRM.SetConfirmationWindow(confirmLogic, msg, nil, { 400 , 175 });
                return;
            end
        end
        GRM_UI.GRM_ToolCoreFrame.rightClickMode = true;
        GRM_UI.RefreshManagementTool( entries );
    end)
end

-- Method:          GRM_UI.BuildRosterFrames( bool )
-- What it Does:    Initiates building of all of the Custom GRM Guild Roster window
-- Purpose:         Provide players more controls than default communities offers.
GRM_UI.BuildRosterFrames = function ( isManualUpdate )
    local coreSize = 1175;
    local coreHybridSize = 1120;

    if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA then
        coreSize = coreSize + 90;
        coreHybridSize = coreHybridSize + 90;
    end

    GRM_UI.CreateCoreFrame ( "GRM_RosterFrame" , GRM_UI , UIParent , coreSize , 525 , "TranslucentFrameTemplate" , false , { "CENTER" , UIParent , "CENTER" , 0 , 300 } , "MEDIUM" , true , true );
    GRM_UI.GRM_RosterFrame.SortType = 3;
    GRM_UI.GRM_RosterFrame.FormerSortType = 3;

    if not GRM_UI.GRM_RosterFrame.Loaded then
        GRM_UI.GRM_RosterFrame.Loaded = true;
        GRM_UI.GRM_RosterFrame:Hide();
    end

    -- So it can be called in AddonSkins
    GRM_UI.RosterFrameSetScript = function()
        GRM_R.LayoutRosterColumns();
        GRM_UI.RefreshRosterName();
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider.ThumbTexture:Show()
        GRM_UI.GRM_Mouseover:Hide();

        GRM_R.ConfigureRosterOptions();
    end

    if not isManualUpdate and not GRM_UI.GRM_RosterFrame:GetScript("OnShow") then
        GRM_UI.GRM_RosterFrame:SetScript ( "OnShow" , GRM_UI.RosterFrameSetScript )
    end

    -- This will query the guild log to trigger, which triggers the roster to be updated every 10 seconds
    if not GRM_UI.GRM_RosterFrame.isHooked then
        GRM_UI.GRM_RosterFrame.isHooked = true;
        GRM_UI.GRM_RosterFrame.timer = 0;

        GRM_UI.GRM_RosterFrame:SetScript ( "OnUpdate" , function ( self , elapsed )
            self.timer = self.timer + elapsed;
            if self.timer >= 10 then
                GRM.GuildRoster();
                QueryGuildEventLog();
                self.timer = 0;
            end
        end)
    end

    -- Options Menu
    GRM_UI.CreateCoreFrame ( "GRM_RosterOptions" , GRM_UI.GRM_RosterFrame , nil , coreSize , 90 , "TranslucentFrameTemplate" , false , { "TOP" , "BOTTOM" , 0 , 8 } , "FULLSCREEN_DIALOG" , false , false );

    -- Must build hybrid first since columns will be pinned to it.
    GRM_UI.CreateHybridScrollFrame ( "GRM_RosterFrameScrollFrame" , GRM_UI.GRM_RosterFrame , coreHybridSize , 400 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame , "BOTTOMLEFT" , 5 , 5 } , "TranslucentFrameTemplate" , GRM_R.BuildGuildRoster , false );

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameTitle" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Guild Roster" ) , 18 , { "TOP" , GRM_UI.GRM_RosterFrame , "TOP" , 0 , -17 } );

    -- Create All Column Header Buttons from Registry
    for _, def in ipairs(ColumnDefs) do
        GRM_UI.CreateButton (
            def.header,
            GRM_UI.GRM_RosterFrame,
            "ColumnDisplayButtonTemplate",
            GRM.L(def.labelKey),
            def.width,
            22,
            { "BOTTOMLEFT", GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameBorder, "TOPLEFT", 10, -3 },
            GRM_R[def.sortFunc],
            "GameFontWhite",
            13,
            "LEFT",
            10,
            -3
        );
    end

    -- Right click menu
    GRM_UI.CreateCoreFrame ( "GRM_RosterFrameDropDown" , GRM_UI.GRM_RosterFrame , nil , 110 , 177 , BackdropTemplateMixin and "BackdropTemplate" , false , nil , "FULLSCREEN_DIALOG" , false , true );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName = "";
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.rankIndex = 0;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick = false

    if not isManualUpdate then
        GRM_UI.GRM_RosterFrame:SetScript ( "OnHide" , function()
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
            if GRM_UI.GRM_RosterFrame.GRM_RosterColumnConfig then
                GRM_UI.GRM_RosterFrame.GRM_RosterColumnConfig:Hide();
            end
        end)
    end

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownName" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "GameFontNormal" , "" , 13 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "TOPLEFT" , 7 , -7 } , 100 , nil , "LEFT" , false );

    -- Promote
    GRM_UI.CreateButton ( "GRM_RosterDropDownPromote" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , "" , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName , "BOTTOMLEFT" , 0 , -1 } , nil , "GameFontWhite" , 12 , "LEFT" , 5 , -5 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:SetHitRectInsets ( -10 , 0 , -15 , -15 );

    -- Demote
    GRM_UI.CreateButton ( "GRM_RosterDropDownDemote" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , "" , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote , "BOTTOMLEFT" , 0 , -3 } , nil , "GameFontWhite" , 12 , "LEFT" , 5 , -5 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote:SetHitRectInsets ( -10 , 0 , -15 , -15 );

    -- Kick
    GRM_UI.CreateButton ( "GRM_RosterDropDownKick" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Kick" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote , "BOTTOMLEFT" , 0 , -3 } , GRM_R.KickPlayer , "GameFontWhite" , 12 , "LEFT" , 5 , -5 );

    -- Divider
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownDivider" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , "GameFontWhite" , "__________" , 12 , { "TOP" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownKick , "BOTTOM" , 0 , -10} , 100 , nil , "CENTER" , false );

    -- Whisper
    GRM_UI.CreateButton ( "GRM_RosterDropDownWhisper" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Whisper" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownDivider , "BOTTOMLEFT" , 0 , -5 } , GRM_R.RosterRightClickWhisper , "GameFontWhite" , 12 , "LEFT" , 5 , -5 );

    -- Cancel
    GRM_UI.CreateButton ( "GRM_RosterDropDownCancel" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , GRM.L ( "Cancel" ) , 100 , 22 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownWhisper , "BOTTOMLEFT" , 0 , -3 } , GRM_R.RosterRightClickCancel , "GameFontWhite" , 12 , "LEFT" , 5 , -5 );

    if not isManualUpdate then
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
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
    end

    -- Rank selection - Right click menu
    GRM_UI.CreateCoreFrame ( "GRM_RosterFrameDropDownRank" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown , nil , 135 , 210 , BackdropTemplateMixin and "BackdropTemplate" , false , nil , "FULLSCREEN_DIALOG" , false , true );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Hide();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetBackdrop ( GRM_UI.noteBackdrop2 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetHitRectInsets ( -10 , -10 , -10 , -10 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote = false;
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.demote = false;

    -- Guild Roster Title
    GRM_UI.CreateString ( "GRM_RosterFrameDropDownRankText" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank , "GameFontNormal" , "" , 12 , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank , "TOPLEFT" , 7 , -7 } , 125 , nil , "LEFT" , false );

    if not isManualUpdate then
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
    end

    -- SEARCH EDIT BOXES (Pinned near outer edges of ScrollFrameBorder so they never collide with "Guild Roster" title!)
    GRM_UI.CreateEditBox ( "GRM_RosterFrameNameEditBox" , GRM_UI.GRM_RosterFrame , "InputBoxTemplate" , 165 , 30 , { "BOTTOMLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameBorder , "TOPLEFT" , 15 , 21 } , "CENTER" , nil , 50 , false , GRM_R.NameSearchTT , GRM_R.TooltipReset , GRM_UI.RefreshRosterName , true , true );
    GRM_UI.CreateString ( "GRM_RosterFrameNameEditBoxText" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Player Search" ) , 16 , { "BOTTOM" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox , "TOP" , 0 , 3 } , 155 , nil , "CENTER" , false );

    GRM_UI.CreateEditBox ( "GRM_RosterNoteEditBox" , GRM_UI.GRM_RosterFrame , "InputBoxTemplate" , 200 , 30 , { "BOTTOMRIGHT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameBorder , "TOPRIGHT" , -15 , 21 } , "LEFT" , nil , 31 , false , GRM_R.NoteSearchTT , GRM_R.TooltipReset , GRM_UI.RefreshRosterName , true , false );
    GRM_UI.CreateString ( "GRM_RosterNoteEditBoxText" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , GRM.L ( "Note Search" ) , 16 , { "BOTTOM" , GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox , "TOP" , 0 , 3 } , 205 , nil , "CENTER" , false );

    -- Show Offline Checkbox
    GRM_UI.CreateCheckBox ( "GRM_RosterShowOfflineCheckBox" , GRM_UI.GRM_RosterFrame , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterFrame , "TOPLEFT" , 15 , -15 } , GRM_R.ShowOfflineLogic , GRM.L ( "Show Offline Members" ) , "GameFontNormal" , 11 );

    -- Member Count
    GRM_UI.CreateString ( "GRM_RosterMemberCount" , GRM_UI.GRM_RosterFrame , "GameFontNormal" , "" , 11 , { "TOPRIGHT" , GRM_UI.GRM_RosterFrame , "TOPRIGHT" , -30 , -20 } );

    -- Show Options Button
    GRM_UI.CreateButton ( "GRM_RosterOptionsButton" , GRM_UI.GRM_RosterFrame , "UIPanelScrollUpButtonTemplate" , nil , 20 , 20 , { "BOTTOMRIGHT" , GRM_UI.GRM_RosterFrame , "BOTTOMLEFT" , 0 , 8 } , GRM_R.OpenRosterOptions , nil , nil , nil , 10 , -5 , GRM_R.OpenRosterOptionsButtonTT , GRM_R.TooltipReset );

    -- Show Mains Checkbox
    GRM_UI.CreateCheckBox ( "GRM_RosterOptionsShowMains" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , "TOPLEFT" , 15 , -15 } , GRM_R.ShowMainsLogic , GRM.L ( "Show Mains" ) , "GameFontNormal" , 11 );

    -- Show Alts Checkbox
    GRM_UI.CreateCheckBox ( "GRM_RosterOptionsShowAlts" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , nil , nil , { "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMains , "BOTTOMLEFT" , 0 , -6 } , GRM_R.ShowAltsLogic , GRM.L ( "Show Alts" ) , "GameFontNormal" , 11 );

   -- Show Main Tag Checkbox
    GRM_UI.CreateCheckBox ( "GRM_RosterOptionsShowMainTag" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , nil , nil , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMains , "RIGHT" , 70 , 0 } , GRM_R.ShowMainTag , GRM.L ( "Show Tag" ) , "GameFontNormal" , 11 );

    -- Show Alt Tag Checkbox
    GRM_UI.CreateCheckBox ( "GRM_RosterOptionsShowAltTag" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , nil , nil , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAlts , "RIGHT" , 70 , 0 } , GRM_R.ShowAltTag , GRM.L ( "Show Tag" ) , "GameFontNormal" , 11 );

    -- Group by Main Checkbox
    GRM_UI.CreateCheckBox ( "GRM_RosterOptionsGroupByMain" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , nil , nil , { "LEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag , "RIGHT" , 70 , 0 } , GRM_R.GroupByMainLogic , GRM.L ( "Group Alts With Main" ) , "GameFontNormal" , 11 , GRM_R.GroupByMainTT , GRM_R.TooltipReset );

    -- Number of Rows Options Slider
    GRM_UI.CreateOptionsSlider( "GRM_RowsCountSlider" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , "MinimalSliderWithSteppersTemplate" , { "RIGHT" , GRM_UI.GRM_RosterFrame.GRM_RosterOptions , "RIGHT" , -325 , 0 } , 10 , 40 , 1 , 11 , GRM.L ( "Rows:" ) , 18 ,  "GameFontNormal"  , GRM_R.NumRowsSliderLogic, GRM_R.NumRowsSliderTT , GRM_R.TooltipReset  ,GRM_R.SliderMouseUpLogic , false )

    -- ==============================================
    -- 2-TIER HORIZONTAL DRAG-AND-DROP COLUMN MANAGER
    -- ==============================================
    GRM_UI.CreateButton (
        "GRM_RosterOptionsColumnsButton",
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions,
        "UIPanelButtonTemplate",
        GRM.L("Columns Manager"),
        145,
        24,
        { "TOPLEFT", GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain, "BOTTOMLEFT", 0, -4 },
        GRM_R.ToggleColumnConfigMenu,
        "GameFontNormal",
        11,
        "CENTER"
    );

    GRM_UI.CreateCoreFrame (
        "GRM_RosterColumnConfig",
        GRM_UI.GRM_RosterFrame,
        nil,
        900,
        155,
        BackdropTemplateMixin and "BackdropTemplate" or "TranslucentFrameTemplate",
        false,
        nil,
        "FULLSCREEN_DIALOG",
        true,
        true
    );
    local colCfg = GRM_UI.GRM_RosterFrame.GRM_RosterColumnConfig;
    colCfg:ClearAllPoints();
    colCfg:SetPoint("TOP", GRM_UI.GRM_RosterFrame.GRM_RosterOptions, "BOTTOM", 0, -2);
    colCfg:SetBackdrop(GRM_UI_Util.GetBackdrop(4));
    colCfg:SetClampedToScreen(true);

    -- Section Headers
    GRM_UI.CreateString("GRM_ColCfgActiveTitle", colCfg, "GameFontNormal", GRM.L("Active Columns") .. " |cffffffff- (" .. GRM.L("Drag Left/Right to Reorder  •  Click to Remove") .. ")|r", 12, { "TOPLEFT", colCfg, "TOPLEFT", 18, -14 }, nil, { 0.0, 0.8, 1.0 });
    GRM_UI.CreateString("GRM_ColCfgUnusedTitle", colCfg, "GameFontNormal", GRM.L("Unused Columns") .. " |cffffffff- (" .. GRM.L("Click to Add  •  Or Drag Up into Active Row") .. ")|r", 12, { "TOPLEFT", colCfg, "TOPLEFT", 18, -82 }, nil, { 1.0, 0.82, 0.0 });

    -- Clear & Default Action Buttons (Top-Right of Manager)
    GRM_UI.CreateButton(
        "GRM_ColCfgClearBtn",
        colCfg,
        "UIPanelButtonTemplate",
        GRM.L("Clear Optional"),
        105,
        20,
        { "TOPRIGHT", colCfg, "TOPRIGHT", -135, -10 },
        function()
            GRM.S().rosterColumns = { "name" };
            GRM_R.LayoutRosterColumns();
            GRM_R.UpdateColumnConfigUI();
            GRM_UI.RefreshRosterName(true);
        end,
        "GameFontNormal",
        10,
        "CENTER"
    );

    GRM_UI.CreateButton(
        "GRM_ColCfgDefaultBtn",
        colCfg,
        "UIPanelButtonTemplate",
        GRM.L("Reset Default"),
        100,
        20,
        { "TOPRIGHT", colCfg, "TOPRIGHT", -30, -10 },
        function()
            GRM.S().rosterColumns = GetDefaultRosterColumns();
            GRM_R.LayoutRosterColumns();
            GRM_R.UpdateColumnConfigUI();
            GRM_UI.RefreshRosterName(true);
        end,
        "GameFontNormal",
        10,
        "CENTER"
    );

    -- GUARD: Only create the Dividers, Pill Buttons, and Drag Ghost ONCE!
    if not colCfg.initialized then
        colCfg.initialized = true;
        colCfg:Hide();

        -- Floating Drag Badge (Follows cursor when dragging a column button)
        colCfg.DragGhost = CreateFrame("Button", nil, colCfg, "UIPanelButtonTemplate");
        colCfg.DragGhost:SetSize(90, 24);
        colCfg.DragGhost:SetFrameStrata("TOOLTIP");
        colCfg.DragGhost:SetAlpha(0.85);
        colCfg.DragGhost.Text = colCfg.DragGhost:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
        colCfg.DragGhost.Text:SetPoint("CENTER", colCfg.DragGhost, "CENTER", 0, 0);
        colCfg.DragGhost:Hide();

        -- Create Drop Divider Bars ("|") for the Active Row (10 slots for up to 9 columns)
        colCfg.Dividers = {};
        for i = 1, #ColumnDefs + 1 do
            local div = CreateFrame("Frame", nil, colCfg);
            div:SetSize(10, 26);
            div.Bar = div:CreateTexture(nil, "OVERLAY");
            div.Bar:SetSize(2, 22);
            div.Bar:SetPoint("CENTER", div, "CENTER", 0, 0);
            div.Bar:SetColorTexture(0.35, 0.35, 0.35, 0.7);
            div:Hide();
            colCfg.Dividers[i] = div;
        end

        -- Create Draggable/Clickable Column Pill Buttons for each ColumnDef
        colCfg.ColButtons = {};
        for _, def in ipairs(ColumnDefs) do
            local btn = CreateFrame("Button", "GRM_ColMgrBtn_" .. def.id, colCfg, "UIPanelButtonTemplate");
            btn:SetHeight(24);
            btn.colId = def.id;
            btn.Text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
            btn.Text:SetPoint("CENTER", btn, "CENTER", 0, 0);

            btn:SetScript("OnMouseDown", function(self, button)
                -- Early return if unsupported (like Reputations prior to Cata)
                if self.isUnsupported then
                    return
                end
                if button == "LeftButton" and self:IsEnabled() then
                    local cx, cy = GetCursorPosition();
                    colCfg.dragSourceBtn = self;
                    colCfg.dragStartX = cx;
                    colCfg.dragStartY = cy;
                    colCfg.isDragging = false;
                    colCfg.dropIndex = nil;
                end
            end);

            btn:SetScript("OnMouseUp", function(self, button)
                if button == "LeftButton" and colCfg.dragSourceBtn == self then
                    local wasDragging = colCfg.isDragging;
                    local targetDropIdx = colCfg.dropIndex;

                    colCfg.dragSourceBtn = nil;
                    colCfg.isDragging = false;
                    colCfg.dropIndex = nil;
                    colCfg.DragGhost:Hide();

                    if wasDragging and targetDropIdx then
                        GRM_R.MoveOrInsertColumn(self.colId, targetDropIdx);
                    else
                        -- Always toggle if it was a click (or if drag ended before a drop index was chosen)
                        GRM_R.ToggleColumnActive(self.colId);
                    end
                end
            end);

            btn:SetScript("OnEnter", function(self)
                if colCfg.isDragging then return end
                GRM_UI.SetTooltipScale();
                GameTooltip:SetOwner(self, "ANCHOR_TOP");
                GameTooltip:AddLine(GRM.L(def.labelKey), 0, 0.8, 1);
                if def.bfaOnly and GRM_G.BuildVersion < GRM_ENUM.BUILD.BFA then
                    GameTooltip:AddLine(GRM.L("Only available in Battle for Azeroth or later."), 1, 0.3, 0.3);
                elseif def.cataOnly and GRM_G.BuildVersion < GRM_ENUM.BUILD.CATA then
                    GameTooltip:AddLine(GRM.L("Only available in Cataclysm or later."), 1, 0.3, 0.3);
                elseif self.isActiveCol then
                    GameTooltip:AddLine(GRM.L("Drag Left/Right to reorder this column."), 1, 0.82, 0);
                    if def.required then
                        GameTooltip:AddLine(GRM.L("Name column is required and cannot be removed."), 0.7, 0.7, 0.7);
                    else
                        GameTooltip:AddLine(GRM.L("Click to remove and move to Unused."), 0.8, 0.8, 0.8);
                    end
                else
                    GameTooltip:AddLine(GRM.L("Click to add to Active Columns (or drag into position above)."), 0.2, 1, 0.2);
                end
                GameTooltip:Show();
            end);

            btn:SetScript("OnLeave", function()
                GRM.RestoreTooltip();
            end);

            colCfg.ColButtons[def.id] = btn;
        end

        -- Live Drag Tracking & Drop-Bar Highlighting
        colCfg:SetScript("OnUpdate", function(self)
            local srcBtn = self.dragSourceBtn;
            if not srcBtn then return end

            local cx, cy = GetCursorPosition();
            local uiScale = self:GetEffectiveScale();

            if not self.isDragging then
                -- 15-pixel threshold so normal clicks never accidentally trigger drag mode!
                if math.abs(cx - self.dragStartX) > 15 or math.abs(cy - self.dragStartY) > 15 then
                    self.isDragging = true;
                    GRM.RestoreTooltip();
                    self.DragGhost:SetWidth(srcBtn:GetWidth());
                    self.DragGhost.Text:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
                    self.DragGhost.Text:SetText(srcBtn.Text:GetText());
                    self.DragGhost:Show();
                    srcBtn:SetAlpha(0.35);
                    -- Do NOT return here! Fall through immediately so self.dropIndex is always valid!
                else
                    return;
                end
            end

            -- Position the floating ghost button on the cursor
            self.DragGhost:ClearAllPoints();
            self.DragGhost:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cx / uiScale, cy / uiScale);

            -- Find which "|" divider in the Active Row is closest to the cursor X
            local cursorFrameX = cx / uiScale;
            local activeCols = EnsureRosterColumnsValid();
            local numDivs = #activeCols + 1;
            local bestIdx = 1;
            local bestDist = 999999;

            for i = 1, numDivs do
                local div = self.Dividers[i];
                if div and div:IsShown() then
                    local divCenter = div:GetCenter();
                    if divCenter then
                        local dist = math.abs(cursorFrameX - divCenter);
                        if dist < bestDist then
                            bestDist = dist;
                            bestIdx = i;
                        end
                    end
                end
            end

            self.dropIndex = bestIdx;

            -- Highlight the target "|" drop bar in bright green!
            for i = 1, numDivs do
                local div = self.Dividers[i];
                if div and div:IsShown() then
                    if i == bestIdx then
                        div.Bar:SetSize(4, 28);
                        div.Bar:SetColorTexture(0.0, 1.0, 0.4, 1.0);
                    else
                        div.Bar:SetSize(2, 20);
                        div.Bar:SetColorTexture(0.4, 0.4, 0.4, 0.65);
                    end
                end
            end
        end);
    end

    GRM_R.LayoutRosterColumns();
    GRM_R.UpdateColumnConfigUI();
end

-- Method:          GRM_R.ToggleColumnConfigMenu()
-- What it Does:    Opens or closes the live column configurator menu
GRM_R.ToggleColumnConfigMenu = function()
    local colCfg = GRM_UI.GRM_RosterFrame.GRM_RosterColumnConfig;
    if colCfg:IsVisible() then
        colCfg:Hide();
    else
        GRM_R.UpdateColumnConfigUI();
        colCfg:Show();
    end
end

-- Method:          GRM_R.ToggleColumnActive( string )
-- What it Does:    Called when clicking (without dragging) a column button to move it between Active and Unused
GRM_R.ToggleColumnActive = function(colId)
    local activeCols = EnsureRosterColumnsValid();
    local def = ColumnDefById[colId];
    if not IsColumnSupported(def) then return end

    local foundIdx = nil;
    for i, id in ipairs(activeCols) do
        if id == colId then
            foundIdx = i;
            break;
        end
    end

    if foundIdx then
        if def.required then
            GRM_R.UpdateColumnConfigUI();
            return;
        end
        table.remove(activeCols, foundIdx);
    else
        table.insert(activeCols, colId);
    end

    GRM_R.LayoutRosterColumns();
    GRM_R.UpdateColumnConfigUI();
    GRM_UI.RefreshRosterName(true);
end

-- Method:          GRM_R.MoveOrInsertColumn( string, int )
-- What it Does:    Moves an active column or inserts an unused column into the exact "|" drop slot!
GRM_R.MoveOrInsertColumn = function(colId, targetDropIdx)
    local activeCols = EnsureRosterColumnsValid();
    local def = ColumnDefById[colId];
    if not IsColumnSupported(def) then
        GRM_R.UpdateColumnConfigUI();
        return;
    end

    local currentIdx = nil;
    for i, id in ipairs(activeCols) do
        if id == colId then
            currentIdx = i;
            break;
        end
    end

    if currentIdx then
        local newIdx = targetDropIdx;
        if newIdx > currentIdx then
            newIdx = newIdx - 1;
        end
        newIdx = math.max(1, math.min(#activeCols, newIdx));

        if newIdx == currentIdx then
            GRM_R.ToggleColumnActive(colId);
            return;
        end

        table.remove(activeCols, currentIdx);
        table.insert(activeCols, newIdx, colId);
    else
        targetDropIdx = math.max(1, math.min(#activeCols + 1, targetDropIdx));
        table.insert(activeCols, targetDropIdx, colId);
    end

    GRM_R.LayoutRosterColumns();
    GRM_R.UpdateColumnConfigUI();
    GRM_UI.RefreshRosterName(true);
end

-- Helper: Visually greys out or restores a UIPanelButtonTemplate while keeping OnEnter tooltips active!
local function SetColButtonVisualEnabled(btn, isSupported)
    btn.isUnsupported = not isSupported;
    if btn.SetMotionScriptsWhileDisabled then
        btn:SetMotionScriptsWhileDisabled(true);
    end

    if isSupported then
        btn:Enable();
        if btn.Left then btn.Left:SetDesaturated(false) end
        if btn.Middle then btn.Middle:SetDesaturated(false) end
        if btn.Right then btn.Right:SetDesaturated(false) end
        if btn:GetNormalTexture() then btn:GetNormalTexture():SetDesaturated(false) end
    else
        -- Disable button click/push animations, desaturate textures, but allow mouseover tooltips!
        btn:Disable();
        if btn.Left then btn.Left:SetDesaturated(true) end
        if btn.Middle then btn.Middle:SetDesaturated(true) end
        if btn.Right then btn.Right:SetDesaturated(true) end
        if btn:GetNormalTexture() then btn:GetNormalTexture():SetDesaturated(true) end
    end
end

-- Method:          GRM_R.UpdateColumnConfigUI()
-- What it Does:    Layouts the Active Row and Unused Row (grouping disabled columns on the far left!)
GRM_R.UpdateColumnConfigUI = function()
    local colCfg = GRM_UI.GRM_RosterFrame and GRM_UI.GRM_RosterFrame.GRM_RosterColumnConfig;
    if not colCfg or not colCfg.initialized then return end

    local activeCols = EnsureRosterColumnsValid();
    local activeSet = {};
    for _, id in ipairs(activeCols) do
        activeSet[id] = true;
    end

    for i = 1, #colCfg.Dividers do
        colCfg.Dividers[i]:Hide();
    end
    for _, def in ipairs(ColumnDefs) do
        if colCfg.ColButtons[def.id] then
            colCfg.ColButtons[def.id]:Hide();
        end
    end

    -- 1. Layout Top Row: | [1 Lvl] | [2 Name] | [3 Nickname] | ...
    local prevAnchor = nil;
    local activeRowWidth = 14;

    for i, id in ipairs(activeCols) do
        local def = ColumnDefById[id];
        local btn = colCfg.ColButtons[id];
        local div = colCfg.Dividers[i];

        if def and btn and div then
            div:ClearAllPoints();
            if i == 1 then
                div:SetPoint("TOPLEFT", colCfg, "TOPLEFT", 14, -37);
            else
                div:SetPoint("LEFT", prevAnchor, "RIGHT", 3, 0);
            end
            div.Bar:SetSize(2, 20);
            div.Bar:SetColorTexture(0.4, 0.4, 0.4, 0.65);
            div:Show();

            btn:ClearAllPoints();
            btn:SetPoint("LEFT", div, "RIGHT", 3, 0);
            btn:SetAlpha(1.0);
            SetColButtonVisualEnabled(btn, true);
            btn.isActiveCol = true;
            btn.Text:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
            btn.Text:SetText("|cff00ccff" .. i .. "|r " .. GRM.L(def.labelKey));
            btn.Text:SetTextColor(1.0, 0.82, 0.0, 1.0);

            local btnW = math.max(54, math.ceil(btn.Text:GetStringWidth()) + 18);
            btn:SetWidth(btnW);
            btn:Show();

            activeRowWidth = activeRowWidth + 10 + 6 + btnW;
            prevAnchor = btn;
        end
    end

    local lastDiv = colCfg.Dividers[#activeCols + 1];
    if lastDiv and prevAnchor then
        lastDiv:ClearAllPoints();
        lastDiv:SetPoint("LEFT", prevAnchor, "RIGHT", 3, 0);
        lastDiv.Bar:SetSize(2, 20);
        lastDiv.Bar:SetColorTexture(0.4, 0.4, 0.4, 0.65);
        lastDiv:Show();
        activeRowWidth = activeRowWidth + 14;
    end

    local maxUnusedRowWidth = math.max(720, activeRowWidth);

    -- 2. Collect Unused Columns: Group Disabled/Unsupported columns on the FAR LEFT first, then usable columns!
    local orderedUnusedDefs = {};
    for _, def in ipairs(ColumnDefs) do
        if not activeSet[def.id] and not IsColumnSupported(def) then
            table.insert(orderedUnusedDefs, def);
        end
    end
    for _, def in ipairs(ColumnDefs) do
        if not activeSet[def.id] and IsColumnSupported(def) then
            table.insert(orderedUnusedDefs, def);
        end
    end

    -- 3. Layout Bottom Tray: Unused Columns
    local prevUnused = nil;
    local currentLineWidth = 18;
    local maxUsedUnusedWidth = 18;
    local numUnusedLines = 1;

    for _, def in ipairs(orderedUnusedDefs) do
        local btn = colCfg.ColButtons[def.id];
        if btn then
            local isSupported = IsColumnSupported(def);
            btn:SetAlpha(1.0);
            btn.isActiveCol = false;
            btn.Text:SetFont(GRM_G.FontChoice, GRM_G.FontModifier + 11);
            btn.Text:SetText(GRM.L(def.labelKey));

            SetColButtonVisualEnabled(btn, isSupported);
            if isSupported then
                btn.Text:SetTextColor(0.85, 0.85, 0.85, 1.0);
            else
                btn.Text:SetTextColor(0.45, 0.45, 0.45, 1.0);
            end

            local btnW = math.max(54, math.ceil(btn.Text:GetStringWidth()) + 18);
            btn:SetWidth(btnW);

            btn:ClearAllPoints();
            if not prevUnused then
                btn:SetPoint("TOPLEFT", colCfg, "TOPLEFT", 18, -106);
                currentLineWidth = 18 + btnW;
            elseif (currentLineWidth + 6 + btnW) > maxUnusedRowWidth then
                numUnusedLines = 2;
                btn:SetPoint("TOPLEFT", colCfg, "TOPLEFT", 18, -134);
                currentLineWidth = 18 + btnW;
            else
                btn:SetPoint("LEFT", prevUnused, "RIGHT", 6, 0);
                currentLineWidth = currentLineWidth + 6 + btnW;
            end

            if currentLineWidth > maxUsedUnusedWidth then
                maxUsedUnusedWidth = currentLineWidth;
            end

            btn:Show();
            prevUnused = btn;
        end
    end

    local requiredWidth = math.max(760, activeRowWidth + 20, maxUsedUnusedWidth + 20);
    colCfg:SetWidth(requiredWidth);
    colCfg:SetHeight(numUnusedLines > 1 and 172 or 148);
end

-- Method:          GRM_R.LayoutRosterColumns()
-- What it Does:    Dynamically anchors active column headers, row fontstrings, and resizes the Roster window live WITHOUT changing scale!
GRM_R.LayoutRosterColumns = function()
    if not GRM_UI.GRM_RosterFrame then return end

    local activeCols = EnsureRosterColumnsValid();
    local activeSet = {};
    for _, id in ipairs(activeCols) do
        activeSet[id] = true;
    end

    -- 1. Hide inactive Column Headers
    for _, def in ipairs(ColumnDefs) do
        local headerBtn = GRM_UI.GRM_RosterFrame[def.header];
        if headerBtn and not activeSet[def.id] then
            headerBtn:Hide();
        end
    end

    -- 2. Anchor active Column Headers left-to-right and calculate total width
    local prevHeader = nil;
    local totalColumnsWidth = 0;
    local anyNoteActive = false;

    for i, id in ipairs(activeCols) do
        local def = ColumnDefById[id];
        local headerBtn = GRM_UI.GRM_RosterFrame[def.header];
        if def and headerBtn then
            headerBtn:ClearAllPoints();
            headerBtn:SetWidth(def.width);
            if i == 1 then
                headerBtn:SetPoint("BOTTOMLEFT", GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameBorder, "TOPLEFT", 10, -3);
                totalColumnsWidth = totalColumnsWidth + def.width;
            else
                headerBtn:SetPoint("LEFT", prevHeader, "RIGHT", -1.5, 0);
                totalColumnsWidth = totalColumnsWidth + (def.width - 1.5);
            end
            headerBtn:Show();
            prevHeader = headerBtn;

            if def.isNote then
                anyNoteActive = true;
            end
        end
    end

    -- 3. Show/Hide Note Search Box depending on whether any Note column is enabled
    if GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox then
        if anyNoteActive then
            GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:Show();
            GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBoxText:Show();
        else
            GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:Hide();
            GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBoxText:Hide();
        end
    end

    -- 4. Resize the Roster Frame, ScrollFrame, and Options Bar (Minimum coreSize = 760 so it lines up with Column Manager & Options Bar!)
    local minHybridWidth = 705; -- 705 + 55 = 760 minimum coreSize!
    local coreHybridSize = math.max(minHybridWidth, totalColumnsWidth + 20);
    local coreSize = coreHybridSize + 55;

    -- Read current user scale without changing it!
    local currentScale = 1.0;
    if GRM.S() and GRM.S().UIScaling and type(GRM.S().UIScaling[6]) == "table" and GRM.S().UIScaling[6][3] then
        currentScale = GRM.S().UIScaling[6][3];
    end

    -- Bypass OnSizeChanged in GRM_UI.RescaleFrame so changing column width NEVER triggers rescaling!
    GRM_UI.GRM_RosterFrame.ignoreSizeChange = true;
    GRM_UI.GRM_RosterFrame.baseWidth = coreSize;
    GRM_UI.GRM_RosterFrame.baseHeight = 525;
    GRM_UI.GRM_RosterFrame:SetSize(coreSize * currentScale, 525 * currentScale);
    if GRM_UI.GRM_RosterFrame.scrollFrame then
        GRM_UI.GRM_RosterFrame.scrollFrame:SetSize(coreSize, 525);
    end
    GRM_UI.GRM_RosterFrame.GRM_RosterOptions:SetWidth(coreSize);
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameBorder:SetWidth(coreHybridSize);
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:SetWidth(coreHybridSize - 18);

    if GRM.S() and GRM.S().UIScaling then
        GRM.S().UIScaling[6] = { math.floor(coreSize * currentScale + 0.5), math.floor(525 * currentScale + 0.5), currentScale };
    end
    GRM_UI.GRM_RosterFrame.ignoreSizeChange = false;

    -- 5. Re-anchor Row FontStrings for all instantiated scroll rows and refresh their values
    local scrollChild = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild;
    local allButtons = scrollChild and scrollChild.AllButtons;
    if allButtons then
        local buttonWidth = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetWidth() - 5;
        local hybridCount = GRM.S().numRosterRows or 18;
        local offset = scrollChild.Offset or hybridCount;

        for rowIdx = 1, #allButtons do
            GRM_R.LayoutSingleRosterRow(allButtons[rowIdx], activeCols, activeSet, buttonWidth);

            local entryIdx = offset - hybridCount + rowIdx;
            if rowIdx <= hybridCount and GRM_UI.GRM_RosterFrame.Entries and GRM_UI.GRM_RosterFrame.Entries[entryIdx] then
                GRM_R.SetGuildRosterValues(rowIdx, entryIdx);
            end
        end
    end
end

-- Helper: Layouts a single row's FontStrings and Note Tooltip buttons to match the active column order
GRM_R.LayoutSingleRosterRow = function(rowTable, activeCols, activeSet, buttonWidth)
    if not rowTable then return end
    local coreButton = rowTable[1];
    if buttonWidth then
        coreButton:SetWidth(buttonWidth);
    end

    -- Hide inactive FontStrings and Note Tooltip overlays
    for _, def in ipairs(ColumnDefs) do
        local fs = rowTable[def.textIdx];
        if fs and not activeSet[def.id] then
            fs:Hide();
        end
        if def.ttIdx and rowTable[def.ttIdx] and not activeSet[def.id] then
            rowTable[def.ttIdx]:Hide();
        end
    end

    -- Anchor active FontStrings left-to-right so their spacing matches the Headers identically!
    local prevFS = nil;
    for i, id in ipairs(activeCols) do
        local def = ColumnDefById[id];
        local fs = def and rowTable[def.textIdx];
        if def and fs then
            fs:ClearAllPoints();
            local fsWidth = def.width - 10.5;
            if i == #activeCols then
                fsWidth = math.max(25, def.width - 16);
            end
            fs:SetWidth(fsWidth);
            fs:SetJustifyH("LEFT");
            fs:SetWordWrap(false);

            if i == 1 then
                fs:SetPoint("LEFT", coreButton, "LEFT", 9, 0);
            else
                fs:SetPoint("LEFT", prevFS, "RIGHT", 9, 0);
            end
            fs:Show();
            prevFS = fs;

            -- Pin Note Tooltip overlay button directly over its own FontString!
            if def.ttIdx and rowTable[def.ttIdx] then
                local ttBtn = rowTable[def.ttIdx];
                ttBtn:ClearAllPoints();
                ttBtn:SetPoint("LEFT", fs, "LEFT", 0, 0);
                ttBtn:SetSize(def.width, coreButton:GetHeight());
                ttBtn:Show();
            end
        end
    end
end

-- Method:          GRM_R.ResetColumnTextColors()
-- What it Does:    It changes the column header text to emphasize where the sorting is happening.
-- Purpose:         Quality of life feature so you can know what is being sorted.
GRM_R.ResetColumnTextColors = function()

    local columnHeaders = {
        { min = 1 ,  max = 2 ,  column = "GRM_RosterColumnName" } ,
        { min = 3 ,  max = 4 ,  column = "GRM_RosterColumnLastOnline" } ,
        { min = 5 ,  max = 6 ,  column = "GRM_RosterColumnRank" } ,
        { min = 7 ,  max = 8 ,  column = "GRM_RosterColumnLvl" } ,
        { min = 9 ,  max = 10 , column = "GRM_RosterColumnMythicPlus" } ,
        { min = 11 , max = 12 , column = "GRM_RosterColumnNote" } ,
        { min = 13 , max = 14 , column = "GRM_RosterColumnOfficerNote" },
        { min = 15 , max = 16 , column = "GRM_RosterColumnCustomNote" },
        { min = 17 , max = 18 , column = "GRM_RosterColumnNickname" },
        { min = 19 , max = 20 , column = "GRM_RosterColumnClass" },
        { min = 21 , max = 22 , column = "GRM_RosterColumnRace" },
        { min = 23 , max = 24 , column = "GRM_RosterColumnJoinDate" },
        { min = 25 , max = 26 , column = "GRM_RosterColumnBirthday" },
        { min = 27 , max = 28 , column = "GRM_RosterColumnReputation" }
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
        local colBtn = GRM_UI.GRM_RosterFrame[entry.column];
        if colBtn and entry.column ~= sortFrame1 and entry.column ~= sortFrame2 then
            colBtn[entry.column.. "Text" ]:SetTextColor ( 1 , 1 , 1 );
        end
    end

    -- Set to color the selected columns
    if sortFrame1 ~= "" and GRM_UI.GRM_RosterFrame[sortFrame1] then
        GRM_UI.GRM_RosterFrame[sortFrame1][sortFrame1.. "Text" ]:SetTextColor ( 0 , 0.8 , 1 );
    end
    if sortFrame2 ~= "" and GRM_UI.GRM_RosterFrame[sortFrame2] then
        if ( GRM_UI.GRM_RosterFrame.SortType == 5 or GRM_UI.GRM_RosterFrame.SortType == 6 ) and GRM_UI.GRM_RosterFrame.FormerSortType ~= 5 and GRM_UI.GRM_RosterFrame.FormerSortType ~= 6 then
            GRM_UI.GRM_RosterFrame[sortFrame2][sortFrame2.. "Text" ]:SetTextColor ( 0 , 0.8 , 1 );
        elseif sortFrame1 ~= sortFrame2 then
            GRM_UI.GRM_RosterFrame[sortFrame2][sortFrame2.. "Text" ]:SetTextColor ( 1 , 1 , 1 );
        end
    end

end

-- Method:          GRM_R.IsOverAnyRankSelectionButtons()
GRM_R.IsOverAnyRankSelectionButtons = function()
    local frame;
    local name = "";

    if GetMouseFoci then
        frame = GetMouseFoci();
        if frame[1] then
            name = frame[1]:GetName();
        end
    else
        frame = GetMouseFocus();
        if frame then
            name = frame:GetName();
        end
    end

    if name and name ~= "" then
        for i = 1 , 9 do
            if name == "GRM_RosterDropDownRankButton" .. i then
                return true;
            end
        end
    end

    return false;
end

-- Method:          GRM_R.BuildPromotionRankSelectionDropDown ( buttonObject )
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

    local height = 60 + ( ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks - 1 ) * 21 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetHeight ( height );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Show();
end

-- Method:          GRM_R.BuildDemotionRankSelectionDropDown ( buttonObject )
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

    local height = 60 + ( ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks - 1 ) * 21 );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:SetHeight ( height );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank:Show();
end

-- Method:          GRM_R.RankSelection ( buttonObject )
GRM_R.RankSelection = function( button )
    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.promote then
        GRM_R.PromotePlayer ( button )
    elseif GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownRank.demote then
        GRM_R.DemotePlayer ( button )
    end
end

-- Method:          GRM_R.PromotePlayer ( button )
GRM_R.PromotePlayer = function ( button )
    local promoEntries = GRM.BuildCustomPromoteEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false , button );

    if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
        GRM_G.RosterRightClickControl = true;
        GRM_UI.GRM_ToolCoreFrame:Show();
    end

    GRM_UI.ConfigureMacroForRightClick( 2 , promoEntries);
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_R.DemotePlayer ( button )
GRM_R.DemotePlayer = function( button )
    local demoteEntries = GRM.BuildCustomDemoteEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false , button );

    if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
        GRM_G.RosterRightClickControl = true;
        GRM_UI.GRM_ToolCoreFrame:Show();
    end

    GRM_UI.ConfigureMacroForRightClick ( 3 , demoteEntries );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_R.KickPlayer()
GRM_R.KickPlayer = function()
    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.canKick then
        local kickEntries = GRM.BuildCustomKickEntries ( { GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName } , false );

        if not GRM_UI.GRM_ToolCoreFrame or ( GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible() ) then
            GRM_G.RosterRightClickControl = true;
            GRM_UI.GRM_ToolCoreFrame:Show();
        end

        GRM_UI.ConfigureMacroForRightClick( 1 , kickEntries );
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
    end
end

-- Method:          GRM_R.RefreshOnlineStatus();
GRM_R.RefreshOnlineStatus = function( guildData )
    local count = 0;

    if guildData then
        local members = C_Club.GetClubMembers ( GRM_G.gClubID );
        if not GRM.issecretvalue(members) then
            local player = {};
            local fullName = "";

            for i = 1 , #members do
                player = C_Club.GetMemberInfo ( GRM_G.gClubID , members[i] );
                fullName = GRM.GetFullNameClubMember ( player.guid );

                if guildData[fullName] then
                    guildData[fullName].isOnline = ( player.presence ~= 3 and player.presence ~= 0 );
                    if guildData[fullName].isOnline then
                        count = count + 1;
                    end
                end
            end
            GRM_UI.GRM_RosterFrame.GRM_RosterMemberCount:SetText ( GRM.L ( "{num}/{custom1} Online" , nil , nil , count , GRM.G_Util.GetNumGuildies() ) );
        end
    end
end

-- Method:          GRM_R.GetNameSearch()
GRM_R.GetNameSearch = function()
    local nameSearch = GRM_UI.GRM_RosterFrame.GRM_RosterFrameNameEditBox:GetText();

    if nameSearch == "" then
        nameSearch = nil;
    else
        nameSearch = string.lower ( GRM.RemoveSpecialCharacters ( nameSearch ) );
    end
    return nameSearch;
end

local toonsAdded = {};
local mainsShown = {};
-- Method:          GetAllMembersAsArray( string , string )
-- What it Does:    Returns an unsorted list of all guild members as an array, as well as some accompanying details.
local function GetAllMembersAsArray( nameSearch , noteSearch )
    local result = {};
    local guildData = GRM.GetGuild();
    local addPlayer;
    toonsAdded = {};
    mainsShown = {};

    -- Refresh the online status for accuracy
    GRM_R.RefreshOnlineStatus ( guildData );

    addPlayer = function ( player , altAdd )
        local tempPlayer = {};
        local toAdd = false;

        if GRM.S().showRosterOffline or ( not GRM.S().showRosterOffline and player.isOnline ) then
            local playerNickname = (GRM.NN and GRM.NN.GetNickname(nil, player)) or "";

            local matchesNameOrNick = (not nameSearch)
                or string.find ( string.lower ( GRM.RemoveSpecialCharacters ( player.name ) ) , nameSearch , 1 , true )
                or string.find ( string.lower ( player.name ) , nameSearch , 1 , true )
                or ( playerNickname ~= "" and (
                    string.find ( string.lower ( GRM.RemoveSpecialCharacters ( playerNickname ) ) , nameSearch , 1 , true )
                    or string.find ( string.lower ( playerNickname ) , nameSearch , 1 , true )
                ) );

            local matchesNote = (not noteSearch)
                or string.find ( string.lower ( GRM.RemoveSpecialCharacters ( player.note ) ) , noteSearch , 1 , true )
                or string.find ( string.lower ( player.note ) , noteSearch , 1 , true )
                or string.find ( string.lower ( GRM.RemoveSpecialCharacters ( player.customNote[4] ) ) , noteSearch , 1 , true )
                or string.find ( string.lower ( player.customNote[4] ) , noteSearch , 1 , true )
                or ( GRM.CanEditOfficerNote() and (
                    string.find ( string.lower ( GRM.RemoveSpecialCharacters ( player.officerNote ) ) , noteSearch , 1 , true )
                    or string.find ( string.lower ( player.officerNote ) , noteSearch , 1 , true )
                ) );

            if matchesNameOrNick and matchesNote then
                if GRM.IsMain ( player.name ) then
                    tempPlayer.isMain = true;
                    tempPlayer.isAlt = false;
                else
                    tempPlayer.isMain = false;

                    if player.altGroup == "" then
                        tempPlayer.isAlt = false;
                    else
                        tempPlayer.isAlt = true;
                        local main = GRM.GetPlayerMain ( player.name );
                        if main and main ~= "" then
                            tempPlayer.mainName = main;
                        end
                    end
                end

                if ( not GRM.S().showMains and tempPlayer.isMain ) or ( not GRM.S().showAlts and tempPlayer.isAlt ) then
                    return false;
                end

                if GRM.S().showMains and GRM.S().groupByMain and not altAdd then
                    if tempPlayer.isAlt and not nameSearch then
                        toAdd = false;
                    else
                        if tempPlayer.isMain then
                            if GRM.PlayerHasAlts ( player ) then
                                tempPlayer.alts = {};
                                local alts = GRM.GetAltNamesList ( player );
                                local addAlt , altDetails;

                                for i = 1 , #alts do
                                    addAlt , altDetails = addPlayer ( guildData[alts[i]] , true );

                                    if addAlt then
                                        toonsAdded[altDetails.name] = true;
                                        altDetails.mainName = player.name;
                                        table.insert ( tempPlayer.alts , altDetails );
                                    end
                                end
                            end
                        end
                        toAdd = true;
                    end
                else
                    toAdd = true;
                end

                if toAdd then
                    tempPlayer.name = player.name;
                    tempPlayer.nickname = playerNickname;
                    tempPlayer.rankName = player.rankName;
                    tempPlayer.rankIndex = player.rankIndex;
                    tempPlayer.lastOnline = player.lastOnline;
                    tempPlayer.classColor = GRM.GetClassColorRGB ( player.class , false );
                    tempPlayer.level = player.level;
                    tempPlayer.note = player.note;
                    tempPlayer.customNote = player.customNote[4];

                    -- Class & Race
                    tempPlayer.className = (GRM.GetClassName and GRM.GetClassName(player.class)) or player.class or "";
                    tempPlayer.raceName = player.race or "";

                    -- Join Date (Blank "" if unset; only shows "Unknown" if player.joinDateUnknown is explicitly true)
                    local jdText = "";
                    local jdSort = nil;
                    if player.joinDateUnknown then
                        jdText = GRM.L("Unknown");
                    elseif type(player.joinDateHist) == "table" and #player.joinDateHist > 0 then
                        local jd = player.joinDateHist[#player.joinDateHist];
                        local d, m, y;
                        if type(jd.date) == "table" then
                            d, m, y = tonumber(jd.date[1]), tonumber(jd.date[2]), tonumber(jd.date[3]);
                        else
                            d, m, y = tonumber(jd[1]), tonumber(jd[2]), tonumber(jd[3]);
                        end
                        if d and m and y and d > 0 and m > 0 and y > 0 then
                            jdText = GRM.Time.FormatTimeStamp({ d, m, y }, false, false, GRM.S().dateFormat);
                            jdSort = (jd[4] and tonumber(jd[4]) and tonumber(jd[4]) > 0) and tonumber(jd[4]) or ((y * 10000) + (m * 100) + d);
                        end
                    end
                    tempPlayer.joinDateText = jdText;
                    tempPlayer.joinDateSort = jdSort;

                    -- Birthday (Uses GRM.GetBirthday and omits the year via FormatTimeStamp(..., false, true))
                    local bdayText = "";
                    local bdaySort = nil;
                    local birthdayInfo = GRM.GetBirthday(player);
                    if birthdayInfo then
                        if birthdayInfo.unknown then
                            bdayText = GRM.L("Unknown");
                        elseif birthdayInfo.date and birthdayInfo.date[1] ~= 0 then
                            bdayText = GRM.Time.FormatTimeStamp({ birthdayInfo.date[1], birthdayInfo.date[2] }, false, true);
                            bdaySort = (tonumber(birthdayInfo.date[2]) * 100) + tonumber(birthdayInfo.date[1]);
                        end
                    end
                    tempPlayer.bdayText = bdayText;
                    tempPlayer.bdaySort = bdaySort;

                    -- Guild Reputation (Cataclysm+)
                    local rawRep = player.reputation or player.rep or player.guildRep;
                    local repText = "";
                    local repSort = nil;
                    if type(rawRep) == "number" and rawRep > 0 then
                        repSort = rawRep;
                        if GRM.GetReputationTextLevel then
                            repText = GRM.GetReputationTextLevel(rawRep, true) or tostring(rawRep);
                        else
                            repText = _G["FACTION_STANDING_LABEL" .. rawRep] or tostring(rawRep);
                        end
                    elseif type(rawRep) == "string" and rawRep ~= "" then
                        repText = rawRep;
                        repSort = rawRep;
                    end
                    tempPlayer.repText = repText;
                    tempPlayer.repSort = repSort;

                    if GRM_G.HardcoreActive then
                        tempPlayer.isDead = player.HC.isDead and true or false;
                    end

                    if GRM.CanEditOfficerNote() then
                        tempPlayer.officerNote = player.officerNote;
                    else
                        tempPlayer.officerNote = "";
                    end
                    if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA then
                        tempPlayer.MythicScore = player.MythicScore;
                    end

                    if not player.isOnline then
                        tempPlayer.hoursReport = GRM.Time.HoursReport ( player.lastOnlineTime );
                    else
                        tempPlayer.hoursReport = GRM.L ( "Online" );
                        tempPlayer.lastOnline = 0;
                    end
                end
            end
        end

        return toAdd , GRM.Util.DeepCopyArray ( tempPlayer );
    end

    local toAdd , playerDetails;
    local mains = GRM.GetListOfGuildMains();
    local player;

    for i = 1, #mains do
        player = GRM.GetPlayer(mains[i]);
        if player then
            toAdd , playerDetails = addPlayer ( player );

            if toAdd then
                toonsAdded[playerDetails.name] = true;
                mainsShown[playerDetails.name] = true;
                table.insert ( result , playerDetails );
            end
        end
    end

    for _ , player in pairs ( guildData ) do
        if type ( player ) == "table" then
            if not GRM.IsMain(player.name) and not toonsAdded[player.name] then
                toAdd , playerDetails = addPlayer ( player );

                if toAdd then
                    table.insert ( result , playerDetails );
                end
            end
        end
    end

    return result;
end

-- Method:          GRM_R.SortNames( buttonObject , bool , bool )
GRM_R.SortNames = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

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
    local members = GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 1 then
        sort ( members , function ( a , b ) return a.name < b.name end );
    else
        sort ( members , function ( a , b ) return a.name > b.name end );
    end

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                if GRM_UI.GRM_RosterFrame.SortType == 1 then
                    sort ( members[i].alts , function ( a , b ) return a.name < b.name end );
                else
                    sort ( members[i].alts , function ( a , b ) return a.name > b.name end );
                end

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.SortNickname( buttonObject , bool , bool )
-- What it Does:    Sorts all of the players by Nickname (players with nicknames first, empty nicknames at bottom)
GRM_R.SortNickname = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 17 and GRM_UI.GRM_RosterFrame.SortType ~= 18 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 17;
        elseif GRM_UI.GRM_RosterFrame.SortType == 17 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 18;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 17;
        end
    end

    local members = GetAllMembersAsArray ( nameSearch , noteSearch );
    local isAscending = (GRM_UI.GRM_RosterFrame.SortType == 17);

    sort ( members , function ( a , b ) return CompareNicknames(a, b, isAscending) end );

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                sort ( members[i].alts , function ( a , b ) return CompareNicknames(a, b, isAscending) end );

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Generic helper for single-level sorting on the 5 new optional columns
local function SortByOptionalColumn(minType, maxType, keepType, reSizeButtons, compareFunc)
    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();
    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower(GRM.RemoveSpecialCharacters(noteSearch));
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= minType and GRM_UI.GRM_RosterFrame.SortType ~= maxType then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = minType;
        elseif GRM_UI.GRM_RosterFrame.SortType == minType then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = maxType;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = minType;
        end
    end

    local members = GetAllMembersAsArray(nameSearch, noteSearch);
    local isAscending = (GRM_UI.GRM_RosterFrame.SortType == minType);

    sort(members, function(a, b) return compareFunc(a, b, isAscending) end);

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                sort(members[i].alts, function(a, b) return compareFunc(a, b, isAscending) end);
                for j = 1, #members[i].alts do
                    table.insert(members, i + j, members[i].alts[j]);
                end
                i = i + #members[i].alts;
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster(true, true, members, reSizeButtons);
end

GRM_R.SortClass = function(_, keepType, reSizeButtons)
    SortByOptionalColumn(19, 20, keepType, reSizeButtons, function(a, b, isAsc)
        return CompareNullableValues(a.className ~= "" and string.lower(a.className) or nil, b.className ~= "" and string.lower(b.className) or nil, a.name, b.name, isAsc);
    end);
end

GRM_R.SortRace = function(_, keepType, reSizeButtons)
    SortByOptionalColumn(21, 22, keepType, reSizeButtons, function(a, b, isAsc)
        return CompareNullableValues(a.raceName ~= "" and string.lower(a.raceName) or nil, b.raceName ~= "" and string.lower(b.raceName) or nil, a.name, b.name, isAsc);
    end);
end

GRM_R.SortJoinDate = function(_, keepType, reSizeButtons)
    SortByOptionalColumn(23, 24, keepType, reSizeButtons, function(a, b, isAsc)
        return CompareNullableValues(a.joinDateSort, b.joinDateSort, a.name, b.name, isAsc);
    end);
end

GRM_R.SortBirthday = function(_, keepType, reSizeButtons)
    SortByOptionalColumn(25, 26, keepType, reSizeButtons, function(a, b, isAsc)
        return CompareNullableValues(a.bdaySort, b.bdaySort, a.name, b.name, isAsc);
    end);
end

GRM_R.SortReputation = function(_, keepType, reSizeButtons)
    SortByOptionalColumn(27, 28, keepType, reSizeButtons, function(a, b, isAsc)
        return CompareNullableValues(a.repSort, b.repSort, a.name, b.name, isAsc);
    end);
end

-- Method:          GRM_R.SortLastOnline( buttonObject , bool , bool )
GRM_R.SortLastOnline = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

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

    local members = GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 3 then
        sort ( members , function ( a , b ) return a.lastOnline < b.lastOnline end );
    else
        sort ( members , function ( a , b ) return a.lastOnline > b.lastOnline end );
    end

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                if GRM_UI.GRM_RosterFrame.SortType == 3 then
                    sort ( members[i].alts , function ( a , b ) return a.lastOnline < b.lastOnline end );
                else
                    sort ( members[i].alts , function ( a , b ) return a.lastOnline > b.lastOnline end );
                end

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.SortMythicScore ( buttonObject, bool , bool )
GRM_R.SortMythicScore = function ( _ , keepType , reSizeButtons )
    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

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

    local members = GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 9 then
        sort ( members , function ( a , b ) return a.MythicScore > b.MythicScore end );
    else
        sort ( members , function ( a , b ) return a.MythicScore < b.MythicScore end );
    end

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                if GRM_UI.GRM_RosterFrame.SortType == 9 then
                    sort ( members[i].alts , function ( a , b ) return a.MythicScore > b.MythicScore end );
                else
                    sort ( members[i].alts , function ( a , b ) return a.MythicScore < b.MythicScore end );
                end

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.SortNote ( buttonObject , bool , bool )
GRM_R.SortNote = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

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
    local members = GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 11 then
        sort ( members , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.note ) ) < string.lower ( GRM.Util.Trim ( b.note ) ) end );
    else
        sort ( members , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.note ) ) > string.lower ( GRM.Util.Trim ( b.note ) ) end );
    end

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                if GRM_UI.GRM_RosterFrame.SortType == 11 then
                    sort ( members[i].alts , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.note ) ) < string.lower ( GRM.Util.Trim ( b.note ) ) end );
                else
                    sort ( members[i].alts , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.note ) ) > string.lower ( GRM.Util.Trim ( b.note ) ) end );
                end

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.SortOfficerNote ( buttonObject , bool , bool )
GRM_R.SortOfficerNote = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

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
    local members = GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 13 then
        sort ( members , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.officerNote ) ) < string.lower ( GRM.Util.Trim ( b.officerNote ) ) end );
    else
        sort ( members , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.officerNote ) ) > string.lower ( GRM.Util.Trim ( b.officerNote ) ) end );
    end

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                if GRM_UI.GRM_RosterFrame.SortType == 13 then
                    sort ( members[i].alts , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.officerNote ) ) < string.lower ( GRM.Util.Trim ( b.officerNote ) ) end );
                else
                    sort ( members[i].alts , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.officerNote ) ) > string.lower ( GRM.Util.Trim ( b.officerNote ) ) end );
                end

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.SortCustomNote ( buttonObject , bool , bool )
GRM_R.SortCustomNote = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 15 and GRM_UI.GRM_RosterFrame.SortType ~= 16 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 15;
        elseif GRM_UI.GRM_RosterFrame.SortType == 15 then
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 16;
        else
            GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            GRM_UI.GRM_RosterFrame.SortType = 15;
        end
    end
    local members = GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 15 then
        sort ( members , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.customNote ) ) < string.lower ( GRM.Util.Trim ( b.customNote ) ) end );
    else
        sort ( members , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.customNote ) ) > string.lower ( GRM.Util.Trim ( b.customNote ) ) end );
    end

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                if GRM_UI.GRM_RosterFrame.SortType == 15 then
                    sort ( members[i].alts , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.customNote ) ) < string.lower ( GRM.Util.Trim ( b.customNote ) ) end );
                else
                    sort ( members[i].alts , function ( a , b ) return string.lower ( GRM.Util.Trim ( a.customNote ) ) > string.lower ( GRM.Util.Trim ( b.customNote ) ) end );
                end

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.SortRank( buttonObject , bool , bool )
GRM_R.SortRank = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();
    local noteSearch = GRM_UI.GRM_RosterFrame.GRM_RosterNoteEditBox:GetText();

    if noteSearch == "" then
        noteSearch = nil;
    else
        noteSearch = string.lower ( GRM.RemoveSpecialCharacters ( noteSearch ) );
    end

    if not keepType then
        if GRM_UI.GRM_RosterFrame.SortType ~= 5 and GRM_UI.GRM_RosterFrame.SortType ~= 6 then
            if GRM_UI.GRM_RosterFrame.SortType < 5 or ( GRM_UI.GRM_RosterFrame.SortType > 6 and GRM_UI.GRM_RosterFrame.SortType <= 18 ) then
                GRM_UI.GRM_RosterFrame.FormerSortType = GRM_UI.GRM_RosterFrame.SortType;
            end
            GRM_UI.GRM_RosterFrame.SortType = 5;
        elseif GRM_UI.GRM_RosterFrame.SortType == 5 then
            GRM_UI.GRM_RosterFrame.SortType = 6;
        elseif GRM_UI.GRM_RosterFrame.SortType == 6 then
            GRM_UI.GRM_RosterFrame.FormerSortType = 6;
            GRM_UI.GRM_RosterFrame.SortType = 5;
        end
    end

    local members = GetAllMembersAsArray ( nameSearch , noteSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 5 then
        sort ( members , function ( a , b ) return a.rankIndex < b.rankIndex end );
    else
        sort ( members , function ( a , b ) return a.rankIndex > b.rankIndex end );
    end

    if #members > 0 then
        if GRM_UI.GRM_RosterFrame.FormerSortType == 1 then
            members = GRM_R.SortAlphabeticallyWithinRank ( members , 1 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 2 then
            members = GRM_R.SortAlphabeticallyWithinRank ( members , 2 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 3 then
            members = GRM_R.SortLastOnlineWithinRank ( members , 3 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 4 then
            members = GRM_R.SortLastOnlineWithinRank ( members , 4 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 7 then
            members = GRM_R.SortByLevelWithinRank ( members , 7 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 8 then
            members = GRM_R.SortByLevelWithinRank ( members , 8 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 9 then
            members = GRM_R.SortByMythicWithinRank ( members , 9 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 10 then
            members = GRM_R.SortByMythicWithinRank ( members , 10 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 11 then
            members = GRM_R.SortByNoteWithinRank ( members , 11 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 12 then
            members = GRM_R.SortByNoteWithinRank ( members , 12 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 13 then
            members = GRM_R.SortByOfficerNoteWithinRank ( members , 13 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 14 then
            members = GRM_R.SortByOfficerNoteWithinRank ( members , 14 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 15 then
            members = GRM_R.SortByCustomNoteWithinRank ( members , 15 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 16 then
            members = GRM_R.SortByCustomNoteWithinRank ( members , 16 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 17 then
            members = GRM_R.SortByNicknameWithinRank ( members , 17 );
        elseif GRM_UI.GRM_RosterFrame.FormerSortType == 18 then
            members = GRM_R.SortByNicknameWithinRank ( members , 18 );
        end

        if GRM.S().groupByMain then
            local i = 1;
            while i <= #members do
                if members[i].alts and #members[i].alts > 0 then
                    if GRM_UI.GRM_RosterFrame.SortType == 5 then
                        sort ( members[i].alts , function ( a , b ) return a.rankIndex < b.rankIndex end );
                    else
                        sort ( members[i].alts , function ( a , b ) return a.rankIndex > b.rankIndex end );
                    end

                    for j = 1 , #members[i].alts do
                        table.insert ( members , i + j , members[i].alts[j] );
                    end
                    i = i + #members[i].alts
                    members[i].alts = nil;
                end
                i = i + 1;
            end
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.SortAlphabeticallyWithinRank ( table, int )
GRM_R.SortAlphabeticallyWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 1 then
                sort ( rankGrouping , function ( a , b ) return a.name < b.name end );
            elseif sortType == 2 then
                sort ( rankGrouping , function ( a , b ) return a.name > b.name end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByNicknameWithinRank ( table, int )
GRM_R.SortByNicknameWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};
    local isAscending = (sortType == 17);

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            sort ( rankGrouping , function ( a , b ) return CompareNicknames(a, b, isAscending) end );
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortLastOnlineWithinRank ( table, int )
GRM_R.SortLastOnlineWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 3 then
                sort ( rankGrouping , function ( a , b ) return a.lastOnline < b.lastOnline end );
            elseif sortType == 4 then
                sort ( rankGrouping , function ( a , b ) return a.lastOnline > b.lastOnline end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByLevelWithinRank ( table, int )
GRM_R.SortByLevelWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 7 then
                sort ( rankGrouping , function ( a , b ) return a.level > b.level end );
            elseif sortType == 8 then
                sort ( rankGrouping , function ( a , b ) return a.level < b.level end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByMythicWithinRank ( table, int )
GRM_R.SortByMythicWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 9 then
                sort ( rankGrouping , function ( a , b ) return a.MythicScore > b.MythicScore end );
            elseif sortType == 10 then
                sort ( rankGrouping , function ( a , b ) return a.MythicScore < b.MythicScore end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByNoteWithinRank ( table, int )
GRM_R.SortByNoteWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 11 then
                sort ( rankGrouping , function ( a , b ) return string.lower ( GRM.Util.Trim( a.note ) ) < string.lower ( GRM.Util.Trim( b.note ) ) end );
            elseif sortType == 12 then
                sort ( rankGrouping , function ( a , b ) return string.lower ( GRM.Util.Trim( a.note ) ) > string.lower ( GRM.Util.Trim( b.note ) ) end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByOfficerNoteWithinRank ( table, int )
GRM_R.SortByOfficerNoteWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 13 then
                sort ( rankGrouping , function ( a , b ) return string.lower ( GRM.Util.Trim( a.officerNote ) ) < string.lower ( GRM.Util.Trim( b.officerNote ) ) end );
            elseif sortType == 14 then
                sort ( rankGrouping , function ( a , b ) return string.lower ( GRM.Util.Trim( a.officerNote ) ) > string.lower ( GRM.Util.Trim( b.officerNote ) ) end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortByCustomNoteWithinRank ( table, int )
GRM_R.SortByCustomNoteWithinRank = function ( members , sortType )
    local result = {};
    local currentRank = members[1].rankIndex;
    local rankGrouping = {};

    for i = 1 , #members do
        if members[i].rankIndex == currentRank then
            table.insert ( rankGrouping , members[i] );
        end

        if members[i].rankIndex ~= currentRank or i == #members then
            if sortType == 15 then
                sort ( rankGrouping , function ( a , b ) return string.lower ( GRM.Util.Trim( a.customNote ) ) < string.lower ( GRM.Util.Trim( b.customNote ) ) end );
            elseif sortType == 16 then
                sort ( rankGrouping , function ( a , b ) return string.lower ( GRM.Util.Trim( a.customNote ) ) > string.lower ( GRM.Util.Trim( b.customNote ) ) end );
            end
            for j = 1 , #rankGrouping do
                table.insert ( result , GRM.Util.DeepCopyArray ( rankGrouping[j] ) );
            end

            currentRank = members[i].rankIndex;
            rankGrouping = {};
            table.insert ( rankGrouping , members[i] );
        end
    end

    return result;
end

-- Method:          GRM_R.SortLevel( buttonObject , bool , bool )
GRM_R.SortLevel = function ( _ , keepType , reSizeButtons )

    local nameSearch = GRM_R.GetNameSearch();

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

    local members = GetAllMembersAsArray ( nameSearch );

    if GRM_UI.GRM_RosterFrame.SortType == 7 then
        sort ( members , function ( a , b ) return a.level > b.level end );
    else
        sort ( members , function ( a , b ) return a.level < b.level end );
    end

    if GRM.S().groupByMain then
        local i = 1;
        while i <= #members do
            if members[i].alts and #members[i].alts > 0 then
                if GRM_UI.GRM_RosterFrame.SortType == 7 then
                    sort ( members[i].alts , function ( a , b ) return a.level > b.level end );
                else
                    sort ( members[i].alts , function ( a , b ) return a.level < b.level end );
                end

                for j = 1 , #members[i].alts do
                    table.insert ( members , i + j , members[i].alts[j] );
                end
                i = i + #members[i].alts
                members[i].alts = nil;
            end
            i = i + 1;
        end
    end

    GRM_R.BuildGuildRoster ( true , true , members , reSizeButtons );
end

-- Method:          GRM_R.RosterRightClickCancel()
-- What it Does:    Hides the right click context menu in the custom GRM Guild Roster
GRM_R.RosterRightClickCancel = function()
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_R.RosterRightClickWhisper()
-- What it Does:    Initializes a whisper to the given player
GRM_R.RosterRightClickWhisper = function()
    ChatFrame_SendTell ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName );
    ChatFrame1EditBox:SetCursorPosition ( 0 );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown:Hide();
end

-- Method:          GRM_UI.RefreshRosterName( bool )
-- What it Does:    Refreshes the guild custom roster without changing sort direction
GRM_UI.RefreshRosterName = function ( reSizeButtons )

    if GRM_UI.GRM_RosterFrame.SortType < 3 then
        GRM_R.SortNames ( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 3 or GRM_UI.GRM_RosterFrame.SortType == 4 then
        GRM_R.SortLastOnline ( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 5 or GRM_UI.GRM_RosterFrame.SortType == 6 then
        GRM_R.SortRank ( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 7 or GRM_UI.GRM_RosterFrame.SortType == 8 then
        GRM_R.SortLevel ( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 9 or GRM_UI.GRM_RosterFrame.SortType == 10 then
        GRM_R.SortMythicScore ( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 11 or GRM_UI.GRM_RosterFrame.SortType == 12 then
        GRM_R.SortNote ( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 13 or GRM_UI.GRM_RosterFrame.SortType == 14 then
        GRM_R.SortOfficerNote( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 15 or GRM_UI.GRM_RosterFrame.SortType == 16 then
        GRM_R.SortCustomNote( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 17 or GRM_UI.GRM_RosterFrame.SortType == 18 then
        GRM_R.SortNickname( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 19 or GRM_UI.GRM_RosterFrame.SortType == 20 then
        GRM_R.SortClass( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 21 or GRM_UI.GRM_RosterFrame.SortType == 22 then
        GRM_R.SortRace( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 23 or GRM_UI.GRM_RosterFrame.SortType == 24 then
        GRM_R.SortJoinDate( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 25 or GRM_UI.GRM_RosterFrame.SortType == 26 then
        GRM_R.SortBirthday( nil , true , reSizeButtons );
    elseif GRM_UI.GRM_RosterFrame.SortType == 27 or GRM_UI.GRM_RosterFrame.SortType == 28 then
        GRM_R.SortReputation( nil , true , reSizeButtons );
    end

end

-- Method:          GRM_R.BuildGuildRoster ( bool , bool , table , bool )
-- What it Does:    Updates the Roster HybridScrollFrame as needed
GRM_R.BuildGuildRoster = function ( showAll , fullRefresh , entries , reSizeButtons )
    local hybridScrollFrameButtonCount = GRM.S().numRosterRows;
    local buttonHeight = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetHeight() / hybridScrollFrameButtonCount;
    local scrollHeight = 0;
    local buttonWidth = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetWidth() - 5;

    if hybridScrollFrameButtonCount <= 15 then
        GRM_UI.GRM_RosterFrame.fontModifier = -1;
    elseif hybridScrollFrameButtonCount <= 20 then
        GRM_UI.GRM_RosterFrame.fontModifier = 0;
    elseif hybridScrollFrameButtonCount <= 25 then
        GRM_UI.GRM_RosterFrame.fontModifier = 1;
    elseif hybridScrollFrameButtonCount <= 30 then
        GRM_UI.GRM_RosterFrame.fontModifier = 2;
    else
        GRM_UI.GRM_RosterFrame.fontModifier = 3;
    end

    if GRM_G.HardcoreActive then
        GRM_G.HardcoreHexCode = GRM.Util.rgbToHex ( { GRM.S().logColor[15][1], GRM.S().logColor[15][2] , GRM.S().logColor[15][3] } );
    end

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
        if i <= hybridScrollFrameButtonCount then
            if not GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i] then

                local button = CreateFrame ( "Button" , "Button1_" .. i , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild );
                local button2 = CreateFrame ( "Button" , "Button2TT_" .. i , button );
                local button3 = CreateFrame ( "Button" , "Button3TT_" .. i , button );
                local button4 = CreateFrame ( "Button" , "Button4TT_" .. i , button );
                GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i] = {
                    button ,
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [2] Level
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [3] Name
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [4] Last Online
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [5] Rank
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [6] Mythic+
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [7] Note
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [8] Officer Note
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [9] Custom Note
                    button2,                                                                -- [10] Note Tooltip Button
                    button3,                                                                -- [11] Officer Note Tooltip Button
                    button4,                                                                -- [12] Custom Note Tooltip Button
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [13] Nickname
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [14] Class
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [15] Race
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [16] Join Date
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" ),      -- [17] Birthday
                    button:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" )       -- [18] Reputation
                };

                button = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i][1];
                if i == 1 then
                    button:SetPoint ( "TOP" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , "TOP" , 9 , 0 );
                else
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                button:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );
                GRM_UI.BuildGuildRosterButtons ( i  , false );

            elseif reSizeButtons then
                local button = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i][1];
                if i == 1 then
                    button:ClearAllPoints();
                    button:SetPoint ( "TOP" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , "TOP" , 9 , 0 );
                else
                    button:ClearAllPoints();
                    button:SetPoint ( "TOPLEFT" , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i-1][1] , "BOTTOMLEFT" , 0 , 0 );
                end

                button:SetHighlightTexture ( "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight" );
                button:SetSize ( buttonWidth , buttonHeight );
                GRM_UI.BuildGuildRosterButtons ( i  , false );
            end
        end

        if i >= ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount + 1 ) and i <= GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset then
            if GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i - ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount )] then
                GRM_R.SetGuildRosterValues ( i - ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount ) , i );
                GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i - ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - hybridScrollFrameButtonCount )][1]:Show();
            end
        end

        scrollHeight = scrollHeight + buttonHeight;
    end

    -- Hide unused buttons...
    local numButtons = #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons;
    if numButtons > GRM.S().numRosterRows then
        numButtons = GRM.S().numRosterRows;
    end

    for i = #GRM_UI.GRM_RosterFrame.Entries + 1 , #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons do
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[i][1]:Hide();
    end

    GRM_UI.SetHybridScrollFrameSliderParameters (
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider,
        buttonWidth , buttonHeight , scrollHeight , #GRM_UI.GRM_RosterFrame.Entries , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons ,
        GRM_R.RosterShiftDown , GRM_R.RosterShiftUp , hybridScrollFrameButtonCount
    );

    GRM_R.ResetColumnTextColors();
end

-- Method:          GRM_UI.BuildGuildRosterButtons ( int , boolean )
-- What it Does:    Initiates the buttons and their values for each line of custom roster
GRM_UI.BuildGuildRosterButtons = function ( ind , isResizeAction )
    local rowTable = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind];
    local coreButton = rowTable[1];
    local buttonText1 = rowTable[2];
    local buttonText2 = rowTable[3];
    local buttonText3 = rowTable[4];
    local buttonText4 = rowTable[5];
    local buttonText5 = rowTable[6];
    local buttonText6 = rowTable[7];
    local buttonText7 = rowTable[8];
    local buttonText8 = rowTable[9];
    local buttonTTNote = rowTable[10];
    local buttonTTNote2 = rowTable[11];
    local buttonTTNote3 = rowTable[12];
    local buttonTextNick = rowTable[13];

    local fontSize = GRM_G.FontModifier + 11 - GRM_UI.GRM_RosterFrame.fontModifier;
    for _, fsIdx in ipairs({ 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 16, 17, 18 }) do
        if rowTable[fsIdx] then
            rowTable[fsIdx]:SetFont(GRM_G.FontChoice, fontSize);
        end
    end

    -- Layout columns dynamically according to user's saved column order
    local activeCols = EnsureRosterColumnsValid();
    local activeSet = {};
    for _, id in ipairs(activeCols) do activeSet[id] = true end
    GRM_R.LayoutSingleRosterRow(rowTable, activeCols, activeSet);

    if not isResizeAction then
        coreButton:EnableMouse ( true );
        coreButton:RegisterForDrag ( "LeftButton" );

        buttonTTNote:EnableMouse ( true );
        buttonTTNote:RegisterForDrag ( "LeftButton" );

        buttonTTNote2:EnableMouse ( true );
        buttonTTNote2:RegisterForDrag ( "LeftButton" );

        buttonTTNote3:EnableMouse ( true );
        buttonTTNote3:RegisterForDrag ( "LeftButton" );

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
        buttonTTNote3:SetScript ( "OnDragStart" , function()
            GRM_UI.GRM_RosterFrame:StartMoving();
        end);
        buttonTTNote3:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_RosterFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( GRM_UI.GRM_RosterFrame );
        end);

        local ButtonClickFunction = function( button , buttonType )
            local playerName = GRM.RemoveMainAltTags ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3]:GetText() );

            if buttonType == "LeftButton" then
                if IsShiftKeyDown() and IsControlKeyDown() then
                    GRM_UI.RestoreTooltipScale();
                    GameTooltip:Hide();
                    if not GRM_UI.GRM_CoreFrame:IsVisible() then
                        GRM_UI.GRM_CoreFrame:Show();
                    end
                    GRM_UI.GRM_CoreFrame.GRM_LogTab:Click();
                    GRM_UI.GRM_CoreFrame.GRM_LogFrame.GRM_LogEditBox:SetText( GRM.SlimName ( playerName ) );
                elseif IsShiftKeyDown() then
                    GRM.GR_Roster_Click ( playerName );
                elseif IsControlKeyDown() then
                    GRM.OpenPlayerWindow( playerName );
                end

            elseif buttonType == "RightButton" then
                GRM_UI.RestoreTooltipScale();
                GameTooltip:Hide();

                local player = GRM.GetPlayer ( playerName );
                GRM_G.playerRankID = GRM.G_Util.GetGuildMemberRankID ( GRM_G.addonUser );

                if player then
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.playerName = playerName;
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName:SetText ( GRM.SlimName ( playerName ) );
                    GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterFrameDropDownName:SetTextColor ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3]:GetTextColor() );

                    -- Promote
                    if player.rankIndex <= ( GRM_G.playerRankID + 1 ) or player.rankIndex == 0 then
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetText ( GRM.L ( "Promote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetTextColor ( 1 , 0 , 0 );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks = 0;
                    else
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetText ( "<  " .. GRM.L ( "Promote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownPromote.GRM_RosterDropDownPromoteText:SetTextColor ( 1 , 1 , 1 );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numPromoteRanks = player.rankIndex - ( GRM_G.playerRankID + 1 )
                    end

                    -- Demote
                    if player.rankIndex <= GRM_G.playerRankID or player.rankIndex == ( GuildControlGetNumRanks() - 1 ) then
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetText ( GRM.L ( "Demote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetTextColor ( 1 , 0 , 0 );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks = 0;
                    else
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetText ( "<  " .. GRM.L ( "Demote" ) );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.GRM_RosterDropDownDemote.GRM_RosterDropDownDemoteText:SetTextColor ( 1 , 1 , 1 );
                        GRM_UI.GRM_RosterFrame.GRM_RosterFrameDropDown.numDemoteRanks = ( GuildControlGetNumRanks() - 1 ) - player.rankIndex;
                    end

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
                    GRM_UI.RefreshRosterName();
                end
            end
        end

        coreButton:SetScript ( "OnMouseDown" , function ( self , button )
            ButtonClickFunction ( self , button );
        end);

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
            GRM.RestoreTooltip();
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
            GRM.RestoreTooltip();
        end);

        buttonTTNote2:SetScript ( "OnMouseDown" , function ( _ , button )
            ButtonClickFunction ( coreButton , button );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Hide();
        end);

        buttonTTNote3:SetScript ( "OnEnter" , function ( self )
            GRM_R.UpdateNoteText ( self , ind , 9 );
            GRM_R.UpdateGuildRosterTooltip( ind );
        end);

        buttonTTNote3:SetScript ( "OnLeave" , function()
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Hide();
            coreButton:UnlockHighlight();
            GRM.RestoreTooltip();
        end);

        buttonTTNote3:SetScript ( "OnMouseDown" , function ( _ , button )
            ButtonClickFunction ( coreButton , button );
            GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Hide();
        end);
    end
end

-- Method:          GRM_R.UpdateGuildRosterTooltip ( int )
-- What it Does:    Sets the tooltip for the Custom GRM Roster (Shows full Name-Server and Nickname below it!)
GRM_R.UpdateGuildRosterTooltip = function ( ind )
    local playerName = GRM.RemoveMainAltTags ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][3]:GetText() );
    local player = GRM.GetPlayer ( playerName );

    if player then
        -- Pass false so full Name-Server is preserved in the tooltip!
        local fullColoredName = GRM.GetClassifiedName ( player.name , false );
        local nickname = (GRM.NN and GRM.NN.GetNickname(nil, player)) or "";

        GRM_UI.SetTooltipScale();
        GameTooltip:SetOwner ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1] , "ANCHOR_LEFT" );
        GameTooltip:AddLine ( fullColoredName );

        if nickname ~= "" then
            local nickHex = "|cff00ccff";
            if GRM.S() and GRM.S().nicknameTagColor then
                nickHex = GRM.Util.rgbToHex({ GRM.S().nicknameTagColor.r, GRM.S().nicknameTagColor.g, GRM.S().nicknameTagColor.b });
            end
            GameTooltip:AddLine ( GRM.L ( "Nickname" ) .. ": " .. nickHex .. nickname .. "|r" , 1 , 0.82 , 0 );
        end

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

-- Method:          GRM_R.UpdateNoteText ( button , int , int )
GRM_R.UpdateNoteText = function ( button , ind , index2 )
    local text = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][index2]:GetText();
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind][1]:LockHighlight();

    if text and text ~= "" then
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:SetOwner ( button , "ANCHOR_CURSOR" );
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:SetText( text , 1 , 1 , 1 , 1 , true);
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:Show();
    end
end

-- Method:          GRM_R.NameSearchTT( frameObject )
GRM_R.NameSearchTT = function ( frameObject )
    GRM_UI.SetTooltipScale()
    GameTooltip:SetOwner ( frameObject , "ANCHOR_CURSOR" );
    GameTooltip:AddLine( GRM.L ( "Search by Player Name or Nickname" ) );
    GameTooltip:Show();
end

-- Method:          GRM_R.NoteSearchTT( frameObject )
GRM_R.NoteSearchTT = function ( frameObject )
    GRM_UI.SetTooltipScale()
    GameTooltip:SetOwner ( frameObject , "ANCHOR_CURSOR" );
    GameTooltip:AddLine( GRM.L ( "Search Public, Officer, and Custom Notes" ) );
    GameTooltip:Show();
end

-- Method:          GRM_R.TooltipReset()
GRM_R.TooltipReset = function()
    GRM.RestoreTooltip();
end

-- Method:          GRM_R.SetGuildRosterValues ( int , int )
-- What it Does:    Builds the values of the given line in the window
GRM_R.SetGuildRosterValues = function ( ind , ind2 )
    local line = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons[ind];
    local entry = GRM_UI.GRM_RosterFrame.Entries[ind2];
    local name = "";

    if line and entry then
        line[2]:SetText ( entry.level );

        -- Player Name
        if entry.isMain then
            if GRM.S().showMainTags then
                name = entry.name .. " " .. GRM_G.mainTag;
            else
                name = entry.name;
            end
        elseif entry.isAlt then
            if GRM.S().showAltTags then
                name = entry.name .. " " .. GRM_G.altTag;
            else
                name = entry.name;
            end
        else
            name = entry.name;
        end

        -- Alt Indentation when Grouped by Main
        if GRM.S().showMains and GRM.S().groupByMain and entry.isAlt and entry.mainName and mainsShown[entry.mainName] then
            name = "     " .. name;
        end

        if GRM_G.HardcoreActive and entry.isDead then
            name = name .. " " .. GRM_G.HardcoreHexCode .. "[" .. GRM.L ( "Dead" ) .. "]|r"
        end

        line[3]:SetText ( name );
        line[3]:SetTextColor ( entry.classColor[1] , entry.classColor[2] , entry.classColor[3] );

        -- Nickname Column ([13])
        line[13]:SetText ( entry.nickname or "" );
        line[13]:SetTextColor ( entry.classColor[1] , entry.classColor[2] , entry.classColor[3] );

        line[4]:SetText ( entry.hoursReport );
        if entry.hoursReport == GRM.L ( "Online" ) then
            line[4]:SetTextColor( 0.12 , 1 , 0 );
        else
            line[4]:SetTextColor ( 1 , 1 , 1);
        end
        line[5]:SetText ( entry.rankName );

        if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA then
            line[6]:SetText ( GRM.GetMythicRatingToMatchRaiderIO ( entry.MythicScore ) .. entry.MythicScore );
        end

        line[7]:SetText ( entry.note );
        line[8]:SetText ( entry.officerNote );
        line[9]:SetText ( entry.customNote );

        -- Update the tooltip if underlying data changes
        if GameTooltip:IsVisible() and line[1]:IsMouseOver() then
            GRM_R.UpdateGuildRosterTooltip ( ind );
        end

        if GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:IsVisible() and line[1]:IsMouseOver() then
            if line[10]:IsMouseOver() then
                GRM_R.UpdateNoteText ( line[10] , ind , 7 );
            elseif line[11]:IsMouseOver() then
                GRM_R.UpdateNoteText ( line[11] , ind , 8 );
            elseif line[12]:IsMouseOver() then
                GRM_R.UpdateNoteText ( line[12] , ind , 9 );
            end
        end

        -- Optional Columns ([14] Class, [15] Race, [16] Join Date, [17] Birthday, [18] Reputation)
        line[14]:SetText ( entry.className or "" );
        line[14]:SetTextColor ( entry.classColor[1] , entry.classColor[2] , entry.classColor[3] );

        line[15]:SetText ( entry.raceName or "" );
        line[15]:SetTextColor ( 1 , 1 , 1 );

        line[16]:SetText ( entry.joinDateText or "" );
        line[16]:SetTextColor ( 1 , 1 , 1 );

        line[17]:SetText ( entry.bdayText or "" );
        line[17]:SetTextColor ( 1 , 1 , 1 );

        line[18]:SetText ( entry.repText or "" );
        line[18]:SetTextColor ( 1 , 1 , 1 );
    end
end

-- Method:          GRM_R.RosterShiftDown()
GRM_R.RosterShiftDown = function()
    if #GRM_UI.GRM_RosterFrame.Entries > 13 then
        local buttons = GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons;
        local MouseOverButton = 0;

        for i = 1 , #buttons - 1 do
            buttons[i][2]:SetText( buttons[i+1][2]:GetText() );
            buttons[i][2]:SetTextColor ( buttons[i+1][2]:GetTextColor ( buttons[i+1][2]:GetText() ) );
            buttons[i][3]:SetText( buttons[i+1][3]:GetText() );
            buttons[i][3]:SetTextColor ( buttons[i+1][3]:GetTextColor ( buttons[i+1][3]:GetText() ) );
            buttons[i][4]:SetText( buttons[i+1][4]:GetText() );
            buttons[i][4]:SetTextColor ( buttons[i+1][4]:GetTextColor ( buttons[i+1][4]:GetText() ) );
            buttons[i][5]:SetText( buttons[i+1][5]:GetText() );
            buttons[i][5]:SetTextColor ( buttons[i+1][5]:GetTextColor ( buttons[i+1][5]:GetText() ) );

            if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA then
                buttons[i][6]:SetText( buttons[i+1][6]:GetText() );
                buttons[i][6]:SetTextColor ( buttons[i+1][6]:GetTextColor ( buttons[i+1][6]:GetText() ) );
            end

            buttons[i][7]:SetText( buttons[i+1][7]:GetText() );
            buttons[i][7]:SetTextColor ( buttons[i+1][7]:GetTextColor ( buttons[i+1][7]:GetText() ) );

            buttons[i][8]:SetText( buttons[i+1][8]:GetText() );
            buttons[i][8]:SetTextColor ( buttons[i+1][8]:GetTextColor ( buttons[i+1][8]:GetText() ) );

            buttons[i][9]:SetText( buttons[i+1][9]:GetText() );
            buttons[i][9]:SetTextColor ( buttons[i+1][9]:GetTextColor ( buttons[i+1][9]:GetText() ) );

            for _, colIdx in ipairs({ 13, 14, 15, 16, 17, 18 }) do
                buttons[i][colIdx]:SetText( buttons[i+1][colIdx]:GetText() );
                buttons[i][colIdx]:SetTextColor( buttons[i+1][colIdx]:GetTextColor() );
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM_R.RosterSetLastValue();
        if MouseOverButton > 0 then
            GRM_R.UpdateGuildRosterTooltip ( MouseOverButton );

            if GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:IsVisible() then
                if buttons[MouseOverButton][10]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( buttons[MouseOverButton][10] , MouseOverButton , 7 );
                elseif buttons[MouseOverButton][11]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( buttons[MouseOverButton][11] , MouseOverButton , 8 );
                elseif buttons[MouseOverButton][12]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( buttons[MouseOverButton][12] , MouseOverButton , 9 );
                end
            end
        end
    end
end

-- Method:          GRM_R.RosterShiftUp()
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

            if GRM_G.BuildVersion >= GRM_ENUM.BUILD.BFA then
                buttons[i][6]:SetText( buttons[i-1][6]:GetText() );
                buttons[i][6]:SetTextColor ( buttons[i-1][6]:GetTextColor ( buttons[i-1][6]:GetText() ) );
            end

            buttons[i][7]:SetText( buttons[i-1][7]:GetText() );
            buttons[i][7]:SetTextColor ( buttons[i-1][7]:GetTextColor ( buttons[i-1][7]:GetText() ) );

            buttons[i][8]:SetText( buttons[i-1][8]:GetText() );
            buttons[i][8]:SetTextColor ( buttons[i-1][8]:GetTextColor ( buttons[i-1][8]:GetText() ) );

            buttons[i][9]:SetText( buttons[i-1][9]:GetText() );
            buttons[i][9]:SetTextColor ( buttons[i-1][9]:GetTextColor ( buttons[i-1][9]:GetText() ) );

            for _, colIdx in ipairs({ 13, 14, 15, 16, 17, 18 }) do
                buttons[i][colIdx]:SetText( buttons[i-1][colIdx]:GetText() );
                buttons[i][colIdx]:SetTextColor( buttons[i-1][colIdx]:GetTextColor() );
            end

            if MouseOverButton == 0 and buttons[i][1]:IsMouseOver() then
                MouseOverButton = i;
            end
        end

        GRM_R.RosterSetFirstValue();
        if MouseOverButton > 0 then
            GRM_R.UpdateGuildRosterTooltip ( MouseOverButton );

            if GRM_UI.GRM_RosterFrame.GRM_RosterFrameNoteTooltip:IsVisible() then
                if buttons[MouseOverButton][10]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( buttons[MouseOverButton][10] , MouseOverButton , 7 );
                elseif buttons[MouseOverButton][11]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( buttons[MouseOverButton][11] , MouseOverButton , 8 );
                elseif buttons[MouseOverButton][12]:IsMouseOver() then
                    GRM_R.UpdateNoteText ( buttons[MouseOverButton][12] , MouseOverButton , 9 );
                end
            end
        end
    end
end

-- Method:          GRM_R.RosterSetLastValue()
GRM_R.RosterSetLastValue = function()
    local numButtons = #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons;
    if numButtons > GRM.S().numRosterRows then
        numButtons = GRM.S().numRosterRows;
    end

    GRM_R.SetGuildRosterValues ( numButtons , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset );
end

-- Method:          GRM_R.RosterSetFirstValue()
GRM_R.RosterSetFirstValue = function()
    local numButtons = #GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.AllButtons;
    if numButtons > GRM.S().numRosterRows then
        numButtons = GRM.S().numRosterRows;
    end

    GRM_R.SetGuildRosterValues ( 1 , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild.Offset - numButtons + 1 );
end

-- Method:          GRM_R.ShowOfflineLogic ( buttonObject )
GRM_R.ShowOfflineLogic = function ( button )
    if button:GetChecked() then
        GRM.S().showRosterOffline = true;
    else
        GRM.S().showRosterOffline = false;
        if GRM.S().groupByMain then
            GRM.S().groupByMain = false;
            GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain:SetChecked ( false );
        end
    end
    GRM_UI.RefreshRosterName();
end

-- Method:          GRM_R.OpenRosterOptions()
GRM_R.OpenRosterOptions = function()
    if GRM_UI.GRM_RosterFrame.GRM_RosterOptions:IsVisible() then
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:Hide();
        if GRM_UI.GRM_RosterFrame.GRM_RosterColumnConfig then
            GRM_UI.GRM_RosterFrame.GRM_RosterColumnConfig:Hide();
        end
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetNormalTexture():SetRotation ( math.pi );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetPushedTexture():SetRotation ( math.pi );
    else
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:Show();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetNormalTexture():SetRotation ( 0 );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetPushedTexture():SetRotation ( 0 );
    end
    GRM_R.TooltipReset();
end

-- Method:          GRM_R.OpenRosterOptionsButtonTT( frame )
GRM_R.OpenRosterOptionsButtonTT = function( self )
    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );

    if self:IsVisible() then
        GameTooltip:AddLine( GRM.L ( "Hide Options" ) );
    else
        GameTooltip:AddLine( GRM.L ( "Show Options" ) );
    end

    GameTooltip:Show();
end

-- Method:          GRM_R.ShowMainsLogic ( buttonObject )
GRM_R.ShowMainsLogic = function ( button )
    if button:GetChecked() then
        GRM.S().showMains = true;

        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag:Enable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain:Enable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag.GRM_RosterOptionsShowMainTagText:SetTextColor ( 1 , 0.8 , 0 );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain.GRM_RosterOptionsGroupByMainText:SetTextColor ( 1 , 0.8 , 0 );
    else
        GRM.S().showMains = false;
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag:Disable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain:Disable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag.GRM_RosterOptionsShowMainTagText:SetTextColor ( 0.5 , 0.5 , 0.5 );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain.GRM_RosterOptionsGroupByMainText:SetTextColor ( 0.5 , 0.5 , 0.5 );
    end
    GRM_UI.RefreshRosterName();
end

-- Method:          GRM_R.ShowAltsLogic ( buttonObject )
GRM_R.ShowAltsLogic = function ( button )
    if button:GetChecked() then
        GRM.S().showAlts = true;
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag:Enable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag.GRM_RosterOptionsShowAltTagText:SetTextColor ( 1 , 0.8 , 0 );
    else
        GRM.S().showAlts = false;
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag:Disable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag.GRM_RosterOptionsShowAltTagText:SetTextColor ( 0.5 , 0.5 , 0.5 );
    end
    GRM_UI.RefreshRosterName();
end

-- Method:          GRM_R.ShowMainTag ( buttonObject )
GRM_R.ShowMainTag = function ( button )
    GRM.S().showMainTags = button:GetChecked() and true or false;
    GRM_UI.RefreshRosterName();
end

-- Method:          GRM_R.ShowAltTag ( buttonObject )
GRM_R.ShowAltTag = function ( button )
    GRM.S().showAltTags = button:GetChecked() and true or false;
    GRM_UI.RefreshRosterName();
end

-- Method:          GRM_R.GroupByMainLogic ( buttonObject )
GRM_R.GroupByMainLogic = function ( button )
    if button:GetChecked() then
        GRM.S().groupByMain = true;

        if not GRM.S().showRosterOffline then
            GRM.S().showRosterOffline = true;
            GRM_UI.GRM_RosterFrame.GRM_RosterShowOfflineCheckBox:SetChecked ( true );
        end
    else
        GRM.S().groupByMain = false;
    end
    GRM_UI.RefreshRosterName();
    GRM_R.TooltipReset();
end

-- Method:          GRM_R.GroupByMainTT( frame )
GRM_R.GroupByMainTT = function( self )
    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
    GameTooltip:AddLine( GRM.L ( "If enabled, sorting will be based on the Mains" ) );
    GameTooltip:Show();
end

-- Method:          GRM_R.NumRowsSliderLogic ( int )
GRM_R.NumRowsSliderLogic = function ( value )
    GRM.S().numRosterRows = value;
    GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RowsCountSlider.Slider.GRM_RowsCountSliderText2:SetText ( GRM.L ( "{num} Rows" , nil , nil , value ) );

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetValueStep ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetHeight() / GRM.S().numRosterRows );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetStepsPerPage ( GRM.S().numRosterRows )
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetScript( "OnValueChanged" , function( self , value )
        GRM_UI.HybridScrollOnValueChangedConfig (
            self , value , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame , GRM.S().numRosterRows , ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetHeight() / GRM.S().numRosterRows ) , GRM_R.BuildGuildRoster , GRM_UI.GRM_RosterFrame.Entries
        );
    end);

    GRM_UI.RefreshRosterName( true );
end

-- Method:          GRM_R.NumRowsSliderTT( frameTable )
GRM_R.NumRowsSliderTT = function( self )
    GRM_UI.SetTooltipScale();
    GameTooltip:SetOwner ( self , "ANCHOR_CURSOR" );
    GameTooltip:AddLine( GRM.L ( "Right-Click to Reset to {num} Rows" , nil , nil , 18 ) );
    GameTooltip:Show();
end

-- Method:          GRM_R.SliderMouseUpLogic()
GRM_R.SliderMouseUpLogic = function()
    if GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:GetValue() ~= 0 then
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetValue( 0 );
    else
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetValue( 1 );
        GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetValue( 0 );
    end
end

-- Method:          GRM_R.ConfigureRosterOptions()
GRM_R.ConfigureRosterOptions = function()

    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetValueStep ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetHeight() / GRM.S().numRosterRows );
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetStepsPerPage ( GRM.S().numRosterRows )
    GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameSlider:SetScript( "OnValueChanged" , function( self , value )
        GRM_UI.HybridScrollOnValueChangedConfig (
            self , value , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrameChild , GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame , GRM.S().numRosterRows , ( GRM_UI.GRM_RosterFrame.GRM_RosterFrameScrollFrame:GetHeight() / GRM.S().numRosterRows ) , GRM_R.BuildGuildRoster , GRM_UI.GRM_RosterFrame.Entries
        );
    end);

    if not GRM_UI.GRM_RosterFrame:IsMouseEnabled() then
        GRM_UI.GRM_RosterFrame:EnableMouse ( true );
        GRM_UI.GRM_RosterFrame:SetMovable ( true );
        GRM_UI.GRM_RosterFrame:SetToplevel ( true );
        GRM_UI.GRM_RosterFrame:RegisterForDrag ( "LeftButton" );
        GRM_UI.GRM_RosterFrame:SetScript ( "OnDragStart" , function( self )
            if GRM.GetMouseFocus( self ) then
                GRM_UI.GRM_RosterFrame:StartMoving();
            end
        end);

        GRM_UI.GRM_RosterFrame:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_RosterFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( GRM_UI.GRM_RosterFrame );
        end);
    end

    if not GRM_UI.GRM_RosterFrame.GRM_RosterOptions:IsMouseEnabled() then
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:EnableMouse ( true );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:RegisterForDrag ( "LeftButton" );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:SetScript ( "OnDragStart" , function( self )
            if GRM.GetMouseFocus( self ) then
                GRM_UI.GRM_RosterFrame:StartMoving();
            end
        end);

        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_RosterFrame:StopMovingOrSizing();
            GRM_UI.SaveFramePosition ( GRM_UI.GRM_RosterFrame );
        end);
    end

    GRM_UI.GRM_RosterFrame.GRM_RosterShowOfflineCheckBox:SetChecked ( GRM.S().showRosterOffline );

    if GRM.S().showRosterOptions then
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:Show();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetNormalTexture():SetRotation ( 0 );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetPushedTexture():SetRotation ( 0 );
    else
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions:Hide();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetNormalTexture():SetRotation ( math.pi );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptionsButton:GetPushedTexture():SetRotation ( math.pi );
    end

    if GRM.S().showMains then
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMains:SetChecked ( true );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag:Enable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain:Enable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag.GRM_RosterOptionsShowMainTagText:SetTextColor ( 1 , 0.8 , 0 );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain.GRM_RosterOptionsGroupByMainText:SetTextColor ( 1 , 0.8 , 0 );
    else
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMains:SetChecked ( false );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag:Disable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain:Disable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag.GRM_RosterOptionsShowMainTagText:SetTextColor ( 0.5 , 0.5 , 0.5 );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain.GRM_RosterOptionsGroupByMainText:SetTextColor ( 0.5 , 0.5 , 0.5 );
    end

    if GRM.S().showAlts then
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAlts:SetChecked ( true );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag:Enable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag.GRM_RosterOptionsShowAltTagText:SetTextColor ( 1 , 0.8 , 0 );
    else
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAlts:SetChecked ( false );
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag:Disable();
        GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag.GRM_RosterOptionsShowAltTagText:SetTextColor ( 0.5 , 0.5 , 0.5 );
    end

    GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowMainTag:SetChecked ( GRM.S().showMainTags );
    GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsShowAltTag:SetChecked ( GRM.S().showAltTags );
    GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RosterOptionsGroupByMain:SetChecked ( GRM.S().groupByMain );

    GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RowsCountSlider.Slider:SetValue ( GRM.S().numRosterRows );
    GRM_UI.GRM_RosterFrame.GRM_RosterOptions.GRM_RowsCountSlider.Slider.GRM_RowsCountSliderText2:SetText ( GRM.L ( "{num} Rows" , nil , nil , GRM.S().numRosterRows ) );

    GRM_R.LayoutRosterColumns();
    GRM_R.UpdateColumnConfigUI();
end