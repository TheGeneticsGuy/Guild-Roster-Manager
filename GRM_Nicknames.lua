local NN = {}
GRM.NN = NN;

local nicknameLimit = 20;

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
        editedDetails = { "" , { 0, 0, 0 } , 0}, -- day, month, year
        bypassAltGroup = includeBypassAltGroup -- { bypassBool, nameWhoChanged, epoch }
    };
end

-- Method:          NN.GetNickname ( string )
-- What it Does:    Returns the nickname based on the global share settings and alt group status.
-- Purpose:         Centralized getter to handle the logic of individual vs shared nicknames.
NN.GetNickname = function ( name )
    local player = GRM.GetPlayer ( name );
    if player then

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
    end

    return "";
end

-- Method:          NN.SetNickname ( string , string , string , int , bool )
-- What it Does:    Sets the nickname to either the player or the group based on settings.
-- Purpose:         To apply identity changes across the database.
NN.SetNickname = function ( playerName , newNick , setterName , epochStamp , isSync )

    if #newNick > nicknameLimit then
        GRM.Report(GRM.L("Player Nicknames must be no longer than {num} letters in length" ) );
        return;
    end

    local player = GRM.GetPlayer ( playerName );
    if player then

        local timestamp = GRM.Time.GetTimestamp(); -- { day, month, year }
        setterName = setterName or GRM_G.addonUser;
        epochStamp = epochStamp or time();
        local nickname = player.nicknameDetails.nickname;
        local addingAltGroupNN = false;

        player.nicknameDetails.nickname = newNick
        player.nicknameDetails.editedDetails = { setterName , { timestamp[1] , timestamp[2] , timestamp[3] } , epochStamp };
        
        if GRM.S().shareNickToAlts and player.altGroup ~= "" and not player.nicknameDetails.bypassAltGroup[1] then
            local alts = GRM.GetAltGroup( player.altGroup )
            if alts then
                if #alts > 1 then
                    addingAltGroupNN = true;
                end
                alts.nicknameDetails.nickname = newNick;
                alts.nicknameDetails.editedDetails = GRM.DeepCopyArray(player.nicknameDetails.editedDetails);

                -- Need to pass on the nickname to all in the alt group as well.
                for i = 1 , #alts do
                    if alts[i].name ~= player.name then
                        local altPlayer = GRM.GetPlayer(alts[i].name);
                        if altPlayer and not altPlayer.nicknameDetails.bypassAltGroup[1] then
                            altPlayer.nicknameDetails.nickname = newNick;
                            altPlayer.nicknameDetails.editedDetails = GRM.DeepCopyArray(player.nicknameDetails.editedDetails);
                        end
                    end
                end
            else
                player.altGroup = "";
            end
        else
            -- Ensure individual structure exists
            if not player.nicknameDetails then player.nicknameDetails = NN.CreateNickObject() end
            dataLocation = player.nicknameDetails;
        end

        if not isSync and GRM.S().syncEnabled then
            local standardFormat = GRM.Time.ConvertToStandardFormatDate(timestamp[1] , timestamp[2] , timestamp[3]);
            GRMsync.SendMessage ( "GRM_NICK_ADD" , playerName .. "?" .. newNick .. "?" .. setterName .. "?" .. standardFormat .. "?" .. tostring(epochStamp) );

            -- Add to Chat
            local classColor = GRM.GetStringClassColorByName ( playerName );
            local coloredPlayer = classColor .. playerName .. "|r";
            local coloredNick = classColor .. nickname .. "|r";
            local setter = GRM.GetClassifiedName ( setterName );

            -- Report to Chat
            if addingAltGroupNN then
                GRM.Report ( GRM.L ( "{name} has added the shared nickname for {name2} and all alts ({custom1})" , setter , coloredPlayer , nil , coloredNick ) );
            else
                GRM.Report ( GRM.L ( "{name} has added {name2}'s nickname ({custom1})" , setter , coloredPlayer , nil , coloredNick) );
            end

            GRM_UI.RefreshSelectFrames ( true , true , false , false , true , false , true );
        end

    end
end

-- Method:          NN.RemoveNickname ( string , string , array, int , bool )
-- What it Does:    Clears the nickname from the player and/or the alt group based on settings.
-- Purpose:         To provide a clean way to purge nicknames while maintaining history/sync integrity.
NN.RemoveNickname = function ( playerName , removerName , timestamp, epochStamp , isSync )
    local player = GRM.GetPlayer ( playerName );
    
    if player then
        removerName = removerName or GRM_G.addonUser;
        timestamp = timestamp or GRM.Time.GetTimestamp(); -- { day, month, year }
        epochStamp = epochStamp or time();
        local nickname = player.nicknameDetails.nickname;
        local removingAltGroupNN = false;
       
        player.nicknameDetails.nickname = "";
        player.nicknameDetails.editedDetails = { removerName , { timestamp[1] , timestamp[2] , timestamp[3] } , epochStamp };

        -- Clear Group Nickname record (If sharing is enabled and not bypassed)
        if GRM.S().shareNickToAlts and player.altGroup ~= "" and not player.nicknameDetails.bypassAltGroup[1] then
            local alts = GRM.GetAltGroup ( player.altGroup );
            if alts then
                if #alts > 1 then
                    removingAltGroupNN = true
                end
                alts.nicknameDetails.nickname = "";
                alts.nicknameDetails.editedDetails = GRM.DeepCopyArray ( player.nicknameDetails.editedDetails );

                for i = 1 , #alts do
                    if alts[i].name ~= player.name then
                        local altPlayer = GRM.GetPlayer(alts[i].name);
                        if altPlayer and not altPlayer.nicknameDetails.bypassAltGroup[1] then
                            altPlayer.nicknameDetails.nickname = "";
                            altPlayer.nicknameDetails.editedDetails = GRM.DeepCopyArray(player.nicknameDetails.editedDetails);
                        end
                    end
                end
            else
                player.altGroup = "";
            end
        end

        if not isSync and GRM.S().syncEnabled then
            -- Sync the nickname change to others
            local standardFormat = GRM.Time.ConvertToStandardFormatDate(timestamp[1] , timestamp[2] , timestamp[3]);
            GRMsync.SendMessage ( "GRM_NICK_RM" , playerName .. "?" .. removerName .. "?" .. standardFormat .. "?" .. tostring(epochStamp) );

            local classColor = GRM.GetStringClassColorByName ( playerName );
            local coloredPlayer = classColor .. playerName .. "|r";
            local coloredNick = classColor .. nickname .. "|r";
            local setter = GRM.GetClassifiedName ( removerName );

            -- Report to Chat
            if removingAltGroupNN then
                GRM.Report ( GRM.L ( "{name} has removed the shared nickname for {name2} and all alts ({custom1})" , setter , coloredPlayer , nil , coloredNick ) );
            else
                GRM.Report ( GRM.L ( "{name} has removed {name2}'s nickname ({custom1})" , setter , coloredPlayer , nil , coloredNick) );
            end

            -- Refresh frames
            GRM_UI.RefreshSelectFrames ( true , true , false , false , true , false , true );
        end
    end
end

-- Method:          NN.IsNicknameFormatValid ( string )
-- What it Does:    Validates the nickname for length (UTF-8 aware) and ensures no forbidden special characters that might mess up regex parsing.
-- Purpose:         To prevent UI injection (via pipe character) and ensure compatibility across all localized clients.
NN.IsNicknameFormatValid = function ( nickname )
    if not nickname or nickname == "" then
        return false; 
    end
    -- Using GRM.UTF8Len ensures that a Chinese character or a Russian letter counts as 1, 
    -- even though they take up 2-3 bytes.
    local length = GRM.UTF8Len ( nickname );
    
    if length > 20 then
        GRM.Report ( GRM.L ( "Nickname is too long. Max {num} letters.", nil, nil , nicknameLimit ) );
        return false;
    end

    -- FORBIDDEN CHARACTER CHECK (The "Pipe" |)
    -- In WOW, the pipe character is used for escape sequences (colors, textures, links) Should be avoided.
    -- Allowing in nicknames could break UI - This gets it's own special check
    if string.find ( nickname , "|" ) then
        GRM.Report ( GRM.L ( "Invalid Character: \"|\" is not allowed." ) );
        return false;
    end

    -- Due to the improbability of writing unique localization conditions for all languages, I am just blocking very specific symbols that
    -- can cause issues when trying to report, due to their special use status.
    local forbiddenSymbols = { "@", "#", "$", "%", "^", "&", "*", "(", ")", "+", "=", "{", "}", "[", "]", "<", ">", "/", "\\", "?", "~" };
    
    for i = 1 , #forbiddenSymbols do
        if string.find ( nickname , forbiddenSymbols[i] , 1 , true ) then
            GRM.Report ( GRM.L ( "Nicknames cannot contain special symbols like \'{name}\'" , forbiddenSymbols[i] ) );
            return false;
        end
    end

    -- CONTROL CHARACTERS
    -- This prevents non-printable characters or "Alt-code" junk that messes up alignment.
    for i = 1 , #nickname do
        local c = string.byte ( nickname , i );
        if ( c < 32 and c ~= 10 and c ~= 13 ) or c == 127 then -- EX 127 == DEL
            GRM.Report ( GRM.L ( "Nickname contains invalid hidden characters." ) );
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