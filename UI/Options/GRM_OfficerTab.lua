local OfficerTab = {}
GRM_UI.OfficerTab = OfficerTab

-- Method:          OfficerTab.ConfigureJoinDateLocation()
-- What it Does:    Configures the front-end UI in the options, including enabling/disabling if you have officer permissions, and basing the selection properly
-- Purpose:         UI Configuration on load.
OfficerTab.ConfigureJoinDateLocation = function()
    local officerOpts = GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_OfficerOptionsFrame

    if GRM.S().joinDateDestination < 2 then
        officerOpts.GRM_RosterAddTimestampRadioButton1:SetChecked ( true );
        officerOpts.GRM_RosterAddTimestampRadioButton2:SetChecked ( false );
        officerOpts.GRM_RosterAddTimestampRadioButton3:SetChecked ( false );

    elseif GRM.S().joinDateDestination == 2 then
        officerOpts.GRM_RosterAddTimestampRadioButton1:SetChecked ( false );
        officerOpts.GRM_RosterAddTimestampRadioButton2:SetChecked ( true );
        officerOpts.GRM_RosterAddTimestampRadioButton3:SetChecked ( false );

    elseif GRM.S().joinDateDestination == 3 then
        officerOpts.GRM_RosterAddTimestampRadioButton1:SetChecked ( false );
        officerOpts.GRM_RosterAddTimestampRadioButton2:SetChecked ( false );
        officerOpts.GRM_RosterAddTimestampRadioButton3:SetChecked ( true );
    end

    GRM_UI.AdjustTextColoring ( GRM.S().joinDateDestination );

    if GRM.S().addTimestampToNote and not ( GRM.S().joinDateDestination == 0 ) then
        officerOpts.GRM_RosterAddTimestampCheckButton:SetChecked ( true );
        GRM_UI.EnableNoteDestinationButtons();
    else
        officerOpts.GRM_RosterAddTimestampCheckButton:SetChecked ( false );
    end

    if not GRM.S().addTimestampToNote then
        GRM_UI.DisableNoteDestinationButtons();
    end

    if GRM.S().includeTag then
        officerOpts.GRM_AddJoinedTagButton:SetChecked ( true );
    else
        officerOpts.GRM_AddJoinedTagButton:SetChecked ( false );
    end
end


OfficerTab.UpdateText = function()
-- Pending

end