
-- Expansion compatibility Frames
-- I only wish to maintain one Codebase, not 2. Foundational compatibility built with expansion in mind.

GRM_UI.EstablishClassicFrames = function()

    if GRM_G.BuildVersion < 80000 then
        -- Vanilla WOW
        if GRM_G.BuildVersion > 10000 then
            -- Guild Roster Frames
            GRM_UI.GuildRosterContainerScrollChild = GuildListScrollFrameScrollChildFrame;
            GRM_UI.GuildRosterFrame = GuildFrame;
            if GUILDMEMBERS_TO_DISPLAY then
                GRM_UI.ContainerButtonCount = GUILDMEMBERS_TO_DISPLAY;
            else
                GRM_UI.ContainerButtonCount = 16;
            end
            GRM_UI.OldRosterButtonName = "GuildFrameButton";
            GRM_UI.GuildRosterContainer = GuildListScrollFrame;
            GRM_UI.MemberDetailFrame = GuildMemberDetailFrame;
            GRM_UI.MemberDetailFrameClassic = GuildMemberDetailFrame;
            GRM_UI.MemberDetailFrame.RemoveButton = GuildMemberRemoveButton;
            GRM_UI.MemberDetailFrame.Name = GuildMemberDetailName;

            -- MOTD and GuildInfo Window
            GRM_UI.CommunitiesGuildTextEditFrame = StaticPopup1;
            GRM_UI.GuildInfoFrame = GuildInfoFrame;
            GRM_UI.MOTDEditBox = StaticPopup1EditBox;
            GRM_UI.GuildInfoEditBox = GuildInfoEditBox;
            GRM_UI.GuildDetailsFrameEditMOTDButton = GuildMOTDEditButton;
            GRM_UI.GuildDetailsGuildInformationButton = GuildFrameGuildInformationButton;
            
        end

        -- Cata
        if GRM_G.BuildVersion >= 40000 then
            GRM_UI.ContainerButtonCount = 16;
            GRM_UI.OldRosterButtonName = "GuildRosterContainerButton";
            GRM_UI.GuildRosterContainer = GuildRosterContainer;

        end

    elseif GRM_G.BuildVersion >= 80000 then

        GRM_UI.MemberDetailFrame = CommunitiesFrame.GuildMemberDetailFrame;
        GRM_UI.MemberDetailFrame.RemoveButton = CommunitiesFrame.GuildMemberDetailFrame.RemoveButton;
        GRM_UI.MemberDetailFrame.Name = CommunitiesFrame.GuildMemberDetailFrame.Name;

        -- MOTD and GuildInfo Window
        GRM_UI.CommunitiesGuildTextEditFrame = CommunitiesGuildTextEditFrame;
        GRM_UI.GuildInfoFrame = CommunitiesGuildTextEditFrame;                                  -- While in Retail this is a shared window now, 2 globals need to be set due to it being 2 copies in Classic
        GRM_UI.MOTDEditBox = CommunitiesGuildTextEditFrame.Container.ScrollFrame.EditBox;
        GRM_UI.GuildInfoEditBox = CommunitiesGuildTextEditFrame.Container.ScrollFrame.EditBox;
        GRM_UI.GuildDetailsFrameEditMOTDButton = CommunitiesFrameGuildDetailsFrameInfo.EditMOTDButton;
        GRM_UI.GuildDetailsGuildInformationButton = CommunitiesFrameGuildDetailsFrameInfo.EditDetailsButton;

    end

end