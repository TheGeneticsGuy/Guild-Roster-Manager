local NN = {}
GRM.NN = NN;

------------------------------
----- Nicknames Feature ------
------------------------------

-- Method:          NN.CreateNickObject( bool )
-- What it Does:    Returns a default nickname data object.
-- Purpose:         To ensure consistent data structures.
NN.CreateNickObject = function( includeBypassAltGroup )
    includeBypassAltGroup = includeBypassAltGroup or nil;
    return { 
        nickname = "",
        nickenabled = true ,
        editedDetails = { "" , { 0, 0, 0 } , 0},
        bypassAltGroup = includeBypassAltGroup
    };
end

-- Method:          NN.GetNickname ( string )
-- What it Does:    Returns the nickname based on the global share settings and alt group status.
-- Purpose:         Centralized getter to handle the logic of individual vs shared nicknames.
NN.GetNickname = function ( name )
    local player = GRM.GetPlayer ( name );
    if not player then return "" end

    -- Check if sharing is enabled and player is in a group
    if GRM.S().shareNickToAlts and player.altGroup ~= "" then
        local group = GRM.GetAltGroup ( player.altGroup );
        if group and group.nicknameDetails and group.nicknameDetails.nickname ~= "" then
            return group.nicknameDetails.nickname;
        end
    end

    -- Fallback to individual player nickname
    if player.nicknameDetails and player.nicknameDetails.nickname ~= "" then
        return player.nicknameDetails.nickname;
    end

    return "";
end

-- Method:          NN.SetNickname ( string , string , string , bool )
-- What it Does:    Sets the nickname to either the player or the group based on settings.
-- Purpose:         To apply identity changes across the database.
-- NN.SetNickname = function ( targetName , newNick , setterName , isSync )
--     local player = GRM.GetPlayer ( targetName );
--     if not player then return end

--     local timestamp = GRM.Time.GetTimestamp(); -- { day, month, year }
--     local setter = setterName or GRM_G.addonUser;

--     local dataLocation;
    
--     if GRM.S().shareNickToAlts and player.altGroup ~= "" then
--         dataLocation = GRM.GetAltGroup( player.altGroup ).nicknameDetails;
--     else
--         -- Ensure individual structure exists
--         if not player.nicknameDetails then player.nicknameDetails = NN.CreateNickObject() end
--         dataLocation = player.nicknameDetails;
--     end

--     dataLocation.nickname = newNick;
--     dataLocation.editedDetails = { setter , { timestamp[3] , timestamp[2] , timestamp[1] } };

--     -- Sync logic would follow here...
--     if not isSync then
--         -- GRMsync logic call
--     end
-- end

-- -- Method:          NN.ValidateNickname ( string )
-- -- What it Does:    Returns true if the nickname meets length and profanity requirements.
-- -- Purpose:         UX safety and preventing roster bloat.
-- NN.ValidateNickname = function ( nickname )
--     if nickname == "" then return true end -- Clearing a name is valid

--     -- Length check (WoW names are 12, nicknames can be 16 for flavor)
--     if GRM.UTF8Len( nickname ) > 16 then
--         GRM.Report ( GRM.L ( "Nickname is too long. Max 16 characters." ) );
--         return false;
--     end

--     -- Unique check (Optional - as per your roadmap)
--     -- This would require a loop through GRM.GetGuild()

--     return true;
-- end

-- ---------------------------
-- -- CHAT REPLACEMENT
-- ---------------------------

-- -- Method:          NN.ChatFilter ( table , string , string , ... )
-- -- What it Does:    Injects nicknames into the chat frame messages.
-- -- Purpose:         The "Replacement" part of the feature.
-- NN.ChatFilter = function ( self , event , msg , author , ... )
--     if not GRM.S().showNickname then return false , msg , author , ... end

--     local fullName = GRM.AppendServerName ( author );
--     local nick = NN.GetNickname ( fullName );

--     if nick ~= "" then
--         local display;
--         if GRM.S().nameFormat == 1 then -- Nickname (RealName)
--             display = nick .. " (" .. GRM.SlimName(author) .. ")";
--         else -- Just Nickname
--             display = nick;
--         end
        
--         -- Note: Actual implementation requires more complex string manipulation 
--         -- to handle player links (|Hplayer:name|h) to ensure clicks still work.
--     end

--     return false , msg , author , ...
-- end

-- validation
-- permissions
   -- Treat it as public info but only changes accepted from leadership
-- History
  -- Who set the nickname
  -- Log of the last 3 nicknames
-- Client-side name replacement (chatframe_addmessageeventfilter)
-- tooltips - show nicnkname when hovering over player in the 3D world
-- Broadcast to all GRM users when nickname is set "PlayerName is now known as Nick!"
-- Officer nickname approval queue?
-- Add nicknames to export feature
-- Alt overrides allowed
-- Options - show dedicated UI example of what the name will look like
-- Restrict same nickname?? If it already exists, cannot be used
-- Analytics - % of guild with nicknames
-- searchable nickname in the roster

-- Name format: "RealName (Nickname): or just Nickname:"
-- nick! can be enabled or disabled
-- Blacklist for offensive nicknames