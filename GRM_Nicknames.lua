local NN = {}
GRM.NN = NN;

local NICKNAME_LIMIT = 20;
local NICKNAME_MIN = 2;

------------------------------
----- Nicknames Feature ------
------------------------------

-- Method:          NN.CreateNickObject()
-- What it Does:    Returns a default nickname data object.
-- Purpose:         To ensure consistent data structures.
NN.CreateNickObject = function()
    local nickInfo = { 
        nickname = "",
        editedDetails = { "" , { 0, 0, 0 } , 0}, -- editedBy, {day, month, year}, epochTime
        shareNickAmongAlts = true
    };

    return nickInfo;
end

-- Method:          NN.GetNickname ( string )
-- What it Does:    Returns the player nickname
NN.GetNickname = function ( playerName )
    local player = GRM.GetPlayer ( playerName );
    local nickname = "";
    if player then

        if not player.nickInfo then
            player.nickInfo = NN.CreateNickObject();
        end

        nickname = player.nickInfo.nickname;
    end

    return nickname;
end

-- Method:          NN.SyncNickChangeToAltGroup(string, table)
-- What it Does:    Persists the player's nickname to the whole altGroup
NN.SyncNickChangeToAltGroup = function( playerName, player )
    player = player or GRM.GetPlayer ( playerName );
    if player then

        local group = GRM.GetAltGroup ( player.altGroup );
        if group and #group > 1 then

            for i = 1 , #group do
                if group[i].name ~= player.name then
                    local altPlayer = GRM.GetPlayer(group[i].name);
                    if altPlayer then
                        altPlayer.nickInfo = GRM.Util.DeepCopyArray(player.nickInfo);
                    end
                end
            end

        end
    end
end

-- Method:          NN.SetNickname ( string , string , bool,  string , int , table, bool  )
-- What it Does:    Sets the nickname to either the player or the group based on settings.
-- Purpose:         To apply identity changes across the database.
NN.SetNickname = function ( playerName , newNick , shareNickAmongAlts, setterName, epochStamp , timeStamp, isNonLiveSync )

    if not NN.IsNicknameFormatValid(newNick) then
        return;
    end

    local player = GRM.GetPlayer ( playerName );
    if player then
        local addingAltGroupNN = false;
        epochStamp = epochStamp or time();
        timestamp = timeStamp or GRM.Time.GetTimestamp(); -- { day, month, year }
        local editedDetails = { setterName , { timestamp[1] , timestamp[2] , timestamp[3] } , epochStamp };
        
        -- Backup
        if not player.nickInfo then 
            player.nickInfo = NN.CreateNickObject()
        end
        
        player.nickInfo.nickname = newNick
        player.nickInfo.editedDetails = editedDetails;
        player.nickInfo.shareNickAmongAlts = shareNickAmongAlts;

        -- Spread the nicknames
        if shareNickAmongAlts then
            NN.SyncNickChangeToAltGroup(player.name , player);
        end

        if not isNonLiveSync then
            
            -- Sync the data
            if GRM.S().syncEnabled then
                local isRemove = "0"; -- Represents false bit
                local standardFormat = GRM.Time.ConvertToStandardFormatDate(timestamp[1] , timestamp[2] , timestamp[3]);
                GRMsync.SendMessage ( "GRM_NN" , playerName .. "?" .. newNick .. "?" .. setterName .. "?" .. isRemove .. "?" .. GRMsync.SetBit(shareNickAmongAlts) .. "?" .. standardFormat .. "?" .. tostring(epochStamp) );
            end

            -- Add to Chat
            local classColor = GRM.GetStringClassColorByName ( playerName );
            local coloredPlayer = classColor .. GRM.FormatName(playerName) .. "|r";
            local coloredNick = classColor .. newNick .. "|r";

            -- Report to Chat
            if shareNickAmongAlts and GRM.PlayerHasAlts(player) then
                GRM.Report ( GRM.L ( "A shared nickname ({name}) has been added to {name2}'s alt group." , coloredNick, coloredPlayer ) );
            else
                GRM.Report ( GRM.L ( "A nickname ({name}) has been added to {name2}" , coloredNick, coloredPlayer) );
            end

            GRM_UI.RefreshSelectFrames ( true , true , false , false , true , false , true );
        end
    end
end

-- Method:          NN.RemoveNickname ( string , string , array, int , bool )
-- What it Does:    Clears the nickname from the player and/or the alt group based on settings.
-- Purpose:         To provide a clean way to purge nicknames while maintaining history/sync integrity.
NN.RemoveNickname = function ( playerName , removerName , removeNickFromAlts , timestamp, epochStamp , isNonLiveSync )
    local player = GRM.GetPlayer ( playerName );
    if player then
        local addingAltGroupNN = false;
        epochStamp = epochStamp or time();
        timestamp = timeStamp or GRM.Time.GetTimestamp(); -- { day, month, year }
        local editedDetails = { removerName , { timestamp[1] , timestamp[2] , timestamp[3] } , epochStamp };
        
        -- Backup
        if not player.nickInfo then 
            player.nickInfo = NN.CreateNickObject()
        end
        local isShared = player.nickInfo.shareNickAmongAlts;
        
        player.nickInfo.nickname = ""
        player.nickInfo.editedDetails = editedDetails;
        player.nickInfo.shareNickAmongAlts = removeNickFromAlts;

        -- Spread the nicknames
        if removeNickFromAlts then
            NN.SyncNickChangeToAltGroup(player.name , player);
        end

        if not isNonLiveSync then
            
            -- Sync the data
            if GRM.S().syncEnabled then
                local isRemove = "1"; -- Represents true bit
                local standardFormat = GRM.Time.ConvertToStandardFormatDate(timestamp[1] , timestamp[2] , timestamp[3]);
                GRMsync.SendMessage ( "GRM_NN" , playerName .. "?" .. newNick .. "?" .. removerName .. "?" .. isRemove .. "?"
                                    .. GRMsync.SetBit(removeNickFromAlts) .. "?" .. standardFormat .. "?" .. tostring(epochStamp) );
            end

            -- Add to Chat
            local coloredPlayer = GRM.GetClassifiedName(player.name);
            local coloredRemover = GRM.GetClassifiedName(removerName);

            -- Report to Chat
            if isShared and GRM.PlayerHasAlts(player) then
                GRM.Report ( GRM.L ( "{name} has removed a shared nickname from {name2} and all their alts." , coloredRemover, coloredPlayer ) );
            else
                GRM.Report ( GRM.L ( "{name} has removed {name2}'s nickname." , coloredRemover, coloredPlayer) );
            end

            GRM_UI.RefreshSelectFrames ( true , true , false , false , true , false , true );
        end
    end
end

-- Method:          NN.IsNicknameFormatValid ( string )
-- What it Does:    Validates the nickname format properly.
NN.IsNicknameFormatValid = function ( nickname )
    if not nickname or nickname == "" then
        return false; 
    end
    -- GRM.Util.UTF8Len because certain chars, like Chinese/Russian can take up to 2 or 3 bytes.
    local length = GRM.Util.UTF8Len ( nickname );

    if #length > NICKNAME_LIMIT then
        GRM.Report(GRM.L("Player Nicknames must be no longer than {num} letters in length", nil, nil, NICKNAME_LIMIT ) );
        return;
    end

    if #length < NICKNAME_MIN then
        GRM.Report(GRM.L("Player Nicknames must be at least {num} characters in length", nil, nil, NICKNAME_MIN ) );
        return;
    end
    
    -- FORBIDDEN CHARACTER CHECK
    if string.find ( nickname , "|" ) then
        GRM.Report ( GRM.L ( "Invalid Character: \"|\" is not allowed when making a nickname." ) );
        return false;
    end

    -- Due to the near impossibility of writing unique conditions for all languages, I am just blocking very specific symbols that
    -- can cause issues when trying to report, due to their special use status.
    local forbiddenSymbols = { "@", "#", "$", "%", "^", "&", "*", "(", ")", "+", "=", "{", "}", "[", "]", "<", ">", "/", "\\", "?", "~" };
    
    for i = 1 , #forbiddenSymbols do
        if string.find ( nickname , forbiddenSymbols[i] , 1 , true ) then
            GRM.Report ( GRM.L ( "Nicknames cannot contain special symbols like \'{name}\'" , forbiddenSymbols[i] ) );
            return false;
        end
    end

    return true;
end

---------------------------
-- NICKNAME SYNC
---------------------------

NN.NickNamesSync = function( msg , prefix)
    print("SYNC RECEIVED: " .. prefix .. " - " .. msg);
end



-- validation
-- permissions
   -- Treat it as public info but only changes accepted from leadership
-- History
  -- Who set the nickname
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
-- Blacklist for offensive nicknames -- maybe not necessary as officers will manage since I log who makes it

-- Sync Comes
-- GRM_NN          -- Live nickname add/remove -- ALMOST COMPLETE
-- GRM_NNSYNCUP     -- Final data send  -- GRMsync.CheckNickNameChanges
-- GRM_RECNNPRE    -- Initiali Precheck Vals -- GRMsync.CollectPreCheckData
-- GRM_NNSYNCF      -- Sending actual NN Data NON alt groups - GRMsync.CollectDataPacketsF
-- GRM_REQ_NNF     -- ResendMissingF  -- GRMsync.CollectMissingMsgRequest(msg, prefix2)
-- GRM_REQNNFIN    -- ResendMissingAgain -- GRMsync.CollectMissingMsgRequest(msg, prefix2)

-- NOTES - Fixed a sync bug where alt data could bypass the sync restrictions entirely if someone made changes.

-- Need to purge all altGroup.nicknameDetails from all alt groups  