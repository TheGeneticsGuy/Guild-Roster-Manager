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

-- Method:          NN.GetNickname ( string, playerObject )
-- What it Does:    Returns the player nickname
NN.GetNickname = function ( playerName, player )
    player = player or GRM.GetPlayer ( playerName );
    if not player then
        return ""
    end

    if not player.nickInfo then
        player.nickInfo = NN.CreateNickObject();
    end

    return player.nickInfo.nickname
end

-- Get the nickname which has been class colorized
NN.GetColorizedNickname = function (playerName, player)
    player = player or GRM.GetPlayer(playerName)
    if not player then
        return
    end

    local nickname = NN.GetNickname(nil, player)

    if nickname ~= "" then
        nickname = GRM.GetClassColorRGB(player.class, true) .. nickname .. "|r"
    end

    return nickname
end

-- Method:          NN.PlayerHasNickname ( string )
-- What it Does:    Returns boolean if the player has a custom nickname set
NN.PlayerHasNickname = function(playerName)
    local nick = NN.GetNickname(playerName)
    return (nick and nick ~= "")
end

-- Method:          NN.SyncNickChangeToAltGroup(table, bool)
-- What it Does:    Persists the player's nickname to the whole altGroup
NN.SyncNickChangeToAltGroup = function( player, onlyChangeShareSetting )
    if player then
        local group = GRM.GetAltGroup ( player.altGroup );
        if group and #group > 1 then

            for i = 1 , #group do
                if group[i].name ~= player.name then
                    local altPlayer = GRM.GetPlayer(group[i].name);
                    if altPlayer then
                        if not onlyChangeShareSetting then
                            altPlayer.nickInfo = GRM.Util.DeepCopyArray(player.nickInfo);
                        else
                            altPlayer.nickInfo.editedDetails = GRM.Util.DeepCopyArray(player.nickInfo.editedDetails);
                            altPlayer.nickInfo.shareNickAmongAlts = player.nickInfo.shareNickAmongAlts;
                        end
                        
                    end
                end
            end

        end
    end
end

-- Method:          NN.SetNickname ( table , string , bool, bool,  string , int , table, bool  )
-- What it Does:    Sets the nickname to either the player or the group based on settings.
-- Purpose:         To apply identity changes across the database.
NN.SetNickname = function ( player , newNick , shareNickAmongAlts, shareSettingChanged, setterName, date, epochStamp, isSync )

    if not player or (not shareSettingChanged and not NN.IsNicknameFormatValid(newNick)) then
        return;
    end

    epochStamp = epochStamp or time();
    date = date or GRM.Time.GetTimestamp(); -- { day, month, year }
    local editedDetails = { setterName , { date[1] , date[2] , date[3] } , epochStamp };
    local originalName = "";
    local isRemove = false;

    -- Backup
    if not player.nickInfo then 
        player.nickInfo = NN.CreateNickObject()
    else
        originalName = player.nickInfo.nickname
    end
    local onlyChangeShareSetting = player.nickInfo.shareNickAmongAlts; -- Set before overwriting.

    if shareSettingChanged and newNick == "X" then
        player.nickInfo.shareNickAmongAlts = shareNickAmongAlts
        player.nickInfo.editedDetails = editedDetails;
    else
        player.nickInfo.nickname = newNick
        player.nickInfo.editedDetails = editedDetails;
        player.nickInfo.shareNickAmongAlts = shareNickAmongAlts;

        if #originalName > 0 and #newNick == 0 then
            isRemove = true
        end
    end

    -- Spread the nicknames
    -- Both of these are circumstantial and could be true
    if shareNickAmongAlts then
        NN.SyncNickChangeToAltGroup(player, false);
    elseif onlyChangeShareSetting then
        NN.SyncNickChangeToAltGroup(player, true);
    end

    if not isSync then
        
        -- Sync the data
        if GRM.S().syncEnabled then
            local removeBit = isRemove and "1" or "0"; -- Represents false bit
            local standardFormat = GRM.Time.ConvertToStandardFormatDate(date[1] , date[2] , date[3]);
            local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
            local msg = "GRM_NN?" .. syncRankFilter .. "?" .. player.name .. "?" .. newNick .. "?" .. GRMsync.SetBit(shareNickAmongAlts) .. "?" ..
                        setterName .. "?" .. standardFormat .. "?" .. tostring(epochStamp) .. "?" .. removeBit .. "?" .. GRMsync.SetBit(shareSettingChanged)
            GRMsync.SendMessage("GRM_SYNC", msg , "GUILD");
        end

        -- Add to Chat
        local classColor = GRM.GetStringClassColorByName ( player.name );
        local coloredPlayer = classColor .. GRM.FormatName(player.name) .. "|r";
        
        -- Report to Chat
        if shareSettingChanged and newNick == "X" then
            GRM.Report ( GRM.L ( "Nickname sharing for ({name}) has been {name2}.", coloredPlayer, shareNickAmongAlts and GRM.L("Enabled") or GRM.L("Disabled") ) );
        else
            local coloredNick = classColor .. newNick .. "|r";
            if shareNickAmongAlts and GRM.PlayerHasAlts(player) then
                GRM.Report ( GRM.L ( "A shared nickname ({name}) has been set to {name2}'s alt group." , coloredNick, coloredPlayer ) );
            else
                GRM.Report ( GRM.L ( "A nickname ({name}) has been set to {name2}" , coloredNick, coloredPlayer) );
            end
            GRM_UI.RefreshSelectFrames ( true , true , false , false , true , false , true );
        end
    end
end

-- Method:          NN.RemoveNickname ( table , bool, bool string , array, int , bool )
-- What it Does:    Clears the nickname from the player and/or the alt group based on settings.
-- Purpose:         To provide a clean way to purge nicknames while maintaining history/sync integrity.
NN.RemoveNickname = function ( player, removeNickFromAlts, shareSettingChanged, removerName, date, epochStamp, isSync )
    if not player then
        return
    end

    epochStamp = epochStamp or time();
    date = date or GRM.Time.GetTimestamp(); -- { day, month, year }
    local editedDetails = { removerName , { date[1] , date[2] , date[3] } , epochStamp };
    
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
        NN.SyncNickChangeToAltGroup(player , false);
    end

    if not isSync then
        
        -- Sync the data
        if GRM.S().syncEnabled then
            local isRemove = "1"; -- Represents true bit
            local standardFormat = GRM.Time.ConvertToStandardFormatDate(date[1] , date[2] , date[3]);
            local syncRankFilter = GRM.S().exportAllRanks and (GuildControlGetNumRanks() - 1) or GRM.S().syncRank
            local msg = "GRM_NN?" .. syncRankFilter .. "?" .. player.name .. "?x?" .. GRMsync.SetBit(player.nickInfo.shareNickAmongAlts) .. "?" ..
                        removerName .. "?" .. standardFormat .. "?" .. tostring(epochStamp) .. "?" .. isRemove .. "?" .. GRMsync.SetBit(shareSettingChanged)
            GRMsync.SendMessage("GRM_SYNC", msg, "GUILD");
        end

        -- Add to Chat
        local coloredPlayer = GRM.GetClassifiedName(player.name);
        local coloredRemover = GRM.GetClassifiedName(removerName);

        -- Report to Chat
        if isShared and GRM.PlayerHasAlts(player) then
            GRM.Report ( GRM.L ( "{name} has removed the shared nickname from {name2}'s alt group." , coloredRemover, coloredPlayer ) );
        else
            GRM.Report ( GRM.L ( "{name} has removed {name2}'s nickname." , coloredRemover, coloredPlayer) );
        end

        GRM_UI.RefreshSelectFrames ( true , true , false , false , true , false , true );
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

    if length > NICKNAME_LIMIT then
        GRM.Report(GRM.L("Player Nicknames must be no longer than {num} letters in length", nil, nil, NICKNAME_LIMIT ) );
        return;
    end

    if length < NICKNAME_MIN then
        GRM.Report(GRM.L("Player Nicknames must be at least {num} characters in length", nil, nil, NICKNAME_MIN ) );
        return;
    end
    
    -- Forbidden chars
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


-- Enhanced permissions controls - currently treated as public info
-- tooltips - show nicnkname when hovering over player in the 3D world
-- Add nicknames to export feature
-- Analytics - % of guild with nicknames
-- searchable nickname in the roster
-- /nick! can be enabled or disabled
