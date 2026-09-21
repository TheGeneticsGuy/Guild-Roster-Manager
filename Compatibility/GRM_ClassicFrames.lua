
-- Expansion compatibility Frames
-- I only wish to maintain one Codebase, not 2. Foundational compatibility built with expansion in mind.

GRM_UI.EstablishClassicFrames = function()

    if GRM_G.BuildVersion >= 10000 then

        GRM_UI.MemberDetailFrame = CommunitiesFrame.GuildMemberDetailFrame;

        -- MOTD and GuildInfo Window
        GRM_UI.CommunitiesGuildTextEditFrame = CommunitiesGuildTextEditFrame;
        GRM_UI.MOTDEditBox = CommunitiesGuildTextEditFrame.Container.ScrollFrame.EditBox;
        GRM_UI.GuildInfoEditBox = CommunitiesGuildTextEditFrame.Container.ScrollFrame.EditBox;
        GRM_UI.GuildDetailsFrameEditMOTDButton = CommunitiesFrameGuildDetailsFrameInfo.EditMOTDButton;
        GRM_UI.GuildDetailsGuildInformationButton = CommunitiesFrameGuildDetailsFrameInfo.EditDetailsButton;

    end

end