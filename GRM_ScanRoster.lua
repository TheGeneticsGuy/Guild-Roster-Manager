-- For all scanning of the roster and the live updates of the roster as they occur.

local Scan = {};
GRM.Scan = Scan;

-- Method:          Scan.NoLivecheck()
-- What it Does:    It compares the live Check event table if a live scan is going, and it ignores checking roster
-- Purpose:         To prevent overlap reporting erroneously to the log.
Scan.NoLivecheck = function()
    local result = true;

    for _, group in pairs(GRM_G.LiveScanningBlock) do
        for i = 1, #group do
            if group[i] then
                result = false;
            end
        end
    end

    return result;
end

-- Method:          Scan.LogPrecheck()
-- What it Does:    Controls when to give the go ahead to scan the roster if an event triggers
-- Purpose:         It can be a bit spammy in pulling data from the server if it calls too frequently. This controls that.
Scan.LogPrecheck = function()
    if (not GRM_G.inCombat and ((time() - GRM_G.ScanControl) >= GRM_G.DefaultMinScanTime) and Scan.NoLivecheck()) or
        GRM_G.OnFirstLoad then
        C_Timer.After(0.2, function()
            if (((time() - GRM_G.ScanControl) >= GRM_G.DefaultMinScanTime) and Scan.NoLivecheck() and #GRM.LiveScanQue ==
                0) or GRM_G.OnFirstLoad then
                if not GRM_G.CurrentlyScanning then

                    Scan.BuildNewRoster();

                end
            end
        end);
    end
end

-- Method:          GRM.RosterPreCheck()
-- What it Does:    Controls when to give the go ahead to scan the roster if an event triggers
-- Purpose:         It can be a bit spammy in pulling data from the server if it calls too frequently. This controls that.
Scan.RosterPreCheck = function()
    if (((time() - GRM_G.ScanControl) >= GRM_G.DefaultMinScanTime) and Scan.NoLivecheck()) or GRM_G.OnFirstLoad then
        C_Timer.After(0.1, function()
            if (((time() - GRM_G.ScanControl) >= GRM_G.DefaultMinScanTime) and Scan.NoLivecheck()) or GRM_G.OnFirstLoad then
                if not GRM_G.CurrentlyScanning then
                    Scan.BuildNewRoster();
                end
            end
        end);
    end
end

-- Method:          Scan.StartScanProtect()
-- What it Does:    Adds a scan protection to clear the scan process if it hangs
-- Purpose:         Prevent odd anomalies or lag from killing scan that session by refreshing it.
Scan.StartScanProtect = function()
    if GRM_G.CurrentlyScanning and not GRM_G.ScanProcessing then
        GRM_G.ScanProcessing = true;

        if (time() - GRM_G.ScanTimer) > 15 then
            -- Scan broke some how - Let's kill switch it
            GRM_G.changeHappenedExitScan = true
            if Scan.ScanKillSwitch() then
                return
            end
        end

    elseif not GRM_G.CurrentlyScanning then
        GRM_G.ScanProcessing = false;
    end
end

-- Method:          Scan.BuildNewRoster( bool )
-- What it does:    Rebuilds the roster to check against for any changes.
-- Purpose:         To track for guild changes of course!
Scan.BuildNewRoster = function( forceScan )
    -- Prevent overlapping scans
    if not forceScan then
        if GRM_G.CurrentlyScanning or Scan.ScanKillSwitch() or GRM_G.MacroInProgress then
            return;
        end
    end

    -- Just cancel if not in a guild
    if not IsInGuild() then
        GRM_G.guildName = "";
        GRM_G.gClubID = 0;
        return;
    end

    GRM_G.CurrentlyScanning = true;
    GRM_G.ScanTimer = time();
    GRM_G.ScanControl = time();
    Scan.StartScanProtect();

    C_Timer.After ( 0.1 , function()
        Scan.BuildRosterClassicMethod();
    end);
end

-- Method:          Scan.CleanUpNameRepeatedServer ( string )
-- What it Does:    Detects if the server has given it the name-server error bug by repeating the server name and returns
--                  a cleaned up version of the name
-- Purpose:         Bandaid Blizz's bug til they fix it.
Scan.CleanUpNameRepeatedServer = function( name )

    local _ , count = name:gsub("-","-"); -- Not actually replacing, just getting count so replacing with itself.
    if count > 1 then
        local fixedName = name:match("^([^%-]+%-[^%-]+)");
        return fixedName;
    end

    return name;
end

-- Method:          Scan.BuildRosterClassicMethod([int], [table], [table], [int] , table)
-- What it Does:    Builds the roster using GetGuildRosterInfo, throttled.
-- Purpose:         Avoid script timeouts during the initial roster build phase, particularly for large guilds
Scan.BuildRosterClassicMethod = function(startIndex, roster, orderedRoster, count , liveRosterSnapshot )

    -- Leave an exit if player quits guild in middle of scan
    if not IsInGuild() then
        GRM_G.CurrentlyScanning = false;
        return
    end

    local delay = 0.1;
    startIndex = startIndex or 1;
    roster = roster or {};
    orderedRoster = orderedRoster or {};
    count = count or 0; -- Track duplicate GUIDs count

    if not liveRosterSnapshot then
        liveRosterSnapshot = {};
        for i = 1 , GRM.G_Util.GetNumGuildies() do
            liveRosterSnapshot[i] = {GetGuildRosterInfo(i)};
            local years, months, days, hours = GetGuildRosterLastOnline(i);
            liveRosterSnapshot[i][18] = { years or 0, months or 0, days or 0, hours or 0 };
        end

        C_Timer.After (delay, function()
            Scan.BuildRosterClassicMethod ( startIndex, roster, orderedRoster, count , liveRosterSnapshot );
        end)
        return
    end

    local chunkSize = 100; -- Can likely be higher than community API, but still worth throttling
    local processedCount = 0;
    local startTime = debugprofilestop();

    for i = startIndex, math.min(startIndex + chunkSize - 1, #liveRosterSnapshot) do
        local name = Scan.CleanUpNameRepeatedServer(liveRosterSnapshot[i][1]);
        local rank = liveRosterSnapshot[i][2];
        local rankInd = liveRosterSnapshot[i][3];
        local level = liveRosterSnapshot[i][4];
        local zone = liveRosterSnapshot[i][6];
        local note = liveRosterSnapshot[i][7];
        local officerNote = liveRosterSnapshot[i][8];
        local online = liveRosterSnapshot[i][9];
        local status = liveRosterSnapshot[i][10];
        local class =liveRosterSnapshot[i][11];
        local achievementPoints = liveRosterSnapshot[i][12];
        local isMobile = liveRosterSnapshot[i][14];
        local rep = liveRosterSnapshot[i][16];
        local GUID = liveRosterSnapshot[i][17];
        local lastOnline = GRM.Time.CalculateTotalHours( { liveRosterSnapshot[i][18][1] , liveRosterSnapshot[i][18][2] , liveRosterSnapshot[i][18][3] , liveRosterSnapshot[i][18][4] } );
        local lastOnlineTime = { liveRosterSnapshot[i][18][1] , liveRosterSnapshot[i][18][2] , liveRosterSnapshot[i][18][3] , liveRosterSnapshot[i][18][4] };

        -- Basic check if name is valid before proceeding
        if name and name ~= "" and GUID then
            table.insert(orderedRoster, name); -- Add to ordered list regardless of duplicates for now

            if name == GRM_G.addonUser and not GRM_G.playerRankID then
                GRM_G.playerRankID = rankInd;
            end

            if GRM_G.liveAddedToons[name] then
                GRM_G.liveAddedToons[name] = nil; -- No longer needed on this list since they are confirmed in guild.
            end

            local processThisMember = true;

            if roster[name] then
                -- Handle potential duplicates based on GUID/Hardcore status
                if GUID ~= roster[name].GUID then

                    if  Scan.GetNewerAccountByGUID( roster[name].GUID , GUID ) == GUID then
                        if GRM_G.HardcoreActive then

                            GRM.HC.SetPlayerAsDeadByGUID ( roster[name].GUID , roster[name].lastOnline , name , roster[name].note );
                        end
                        -- We will overwrite roster[name] below
                    else
                        -- The player at index i is the older/dead one. Mark them dead if Hardcore.
                        if GRM_G.HardcoreActive then

                            GRM.HC.SetPlayerAsDeadByGUID ( GUID , lastOnline , name , note );
                        end
                        processThisMember = false;
                    end
                    count = count + 1; -- Increment duplicate count (as one was discarded)
                end
            end

            if processThisMember and not roster[name] then

                -- Add or overwrite the member data
                roster[name] = {}; -- For easy referencing.
                roster[name].name = name
                roster[name].rankName = rank;
                roster[name].rankIndex = rankInd;
                roster[name].level = level;
                roster[name].note = note or "";
                roster[name].officerNote = officerNote or "";
                roster[name].class = class;
                roster[name].isOnline = online;
                roster[name].isMobile = isMobile;
                roster[name].zone = zone;
                roster[name].achievementPoints = achievementPoints;
                roster[name].rep = rep;
                roster[name].status = status;
                roster[name].GUID = GUID;
                roster[name].lastOnline = lastOnline;
                roster[name].lastOnlineTime = lastOnlineTime;
                roster[name].rosterSelection = i; -- Store original index if needed
                roster[name].MythicScore = 0;   -- Placeholder

            end
        end
        processedCount = processedCount + 1;

        -- Check if throttle needed by hitting check size OR by time past
        if processedCount >= chunkSize or (debugprofilestop() - startTime) > 40000 then
             C_Timer.After(delay, function()
                Scan.BuildRosterClassicMethod(i + 1, roster, orderedRoster, count , liveRosterSnapshot);
            end);
            return;
        end

    end -- End of for loop for this chunk

    local nextIndex = startIndex + processedCount;
    if nextIndex <= #liveRosterSnapshot then
        -- Schedule the next chunk
        C_Timer.After(delay, function()
            Scan.BuildRosterClassicMethod(nextIndex, roster, orderedRoster, count , liveRosterSnapshot);
        end);
        return;
    else
        -- Finished processing all members with GetGuildRosterInfo
        -- Now, clean up liveKickedToons based on the *final* roster
        for memberName in pairs(GRM_G.liveKickedToons) do
            if not roster[memberName] then
                GRM_G.liveKickedToons[memberName] = nil; -- Confirmed kicked
            end
        end

        Scan.UpdateRosterWithCommunitiesAPI( roster, orderedRoster , count );
    end
end

-- Method:          Scan.GetClubMemberTable()
-- What it Does:    Returns the full club member data
-- Purpose:         Easy access using Club Communities API
Scan.GetClubMemberTable = function()
    local members = C_Club.GetClubMembers(GRM_G.gClubID);
    local clubMemberTable = {};
    for i = 1 , #members do
        local member = C_Club.GetMemberInfo(GRM_G.gClubID, members[i])

        table.insert ( clubMemberTable , member );
    end

    return clubMemberTable;
end

-- Method:          Scan.GetGuildMemberIndexTable()
-- What it Does:    Quickly builds a member reference table by GUID of the roster index location
-- Purpose:         Avoid big O n^2 notation by building the table in one loop for reference rather than looping check each player.
Scan.GetGuildMemberIndexTable = function()
    local roster = {};
    for i = 1, GRM.G_Util.GetNumGuildies() do
        local player_guid = select ( 17 , GetGuildRosterInfo(i) );
        if player_guid then
            roster[player_guid] = i;
        end
    end
    return roster;
end

-- Method:          Scan.UpdateRosterWithCommunitiesAPI ( table , table, int , table , int )
-- What it Does:    Throttles the querying of the data by the Communities C_Club API. This server call seems much slower and can overload if too fast.
-- Purpose:         Avoid stutter.
Scan.UpdateRosterWithCommunitiesAPI = function( roster, orderedRoster , count , members , index )
    -- Leave an exit if player quits guild in middle of scan
    if not IsInGuild() then
        GRM_G.CurrentlyScanning= false;
        return
    end

    local chunkSize = 100;
    local delay = 0.1;
    local processedCount = 0;
    index = index or 1;
    members = members or Scan.GetClubMemberTable();

    local memberInfo;
    local player;
    local sex

    while index <= #members do
        memberInfo = members[index];

        if memberInfo and memberInfo.guid and memberInfo.name then
            -- local name , sex = GRM.GetFullNameClubMember(memberInfo.guid);
            local name = GRM.AppendServerNameSimple(memberInfo.name);   -- Appends server name if it matters
            player = roster[name];
            if player and player.GUID == memberInfo.guid then

                -- Add Mythic Score if applicable
                if GRM_G.BuildVersion >= 80000 and memberInfo.overallDungeonScore then
                    player.MythicScore = memberInfo.overallDungeonScore;
                end

                -- faction
                player.faction = memberInfo.faction;

                -- race
                player.race = memberInfo.race

                -- sex
                player.sex = GRM.GetPlayerSex(memberInfo.guid); -- This will return nil if unable to determine

                -- Player last online status
                if not player.lastOnline then
                    player.lastOnline = GRM.Time.CalculateTotalHours( {memberInfo.lastOnlineYear or 0, memberInfo.lastOnlineMonth or 0, memberInfo.lastOnlineDay or 0, player.lastOnlineHour or 0}, memberInfo.isOnline);
                    player.lastOnlineTime = {memberInfo.lastOnlineYear or 0, memberInfo.lastOnlineMonth or 0, memberInfo.lastOnlineDay or 0, memberInfo.lastOnlineHour or 0};
                end

                -- PROFESSIONS
                if memberInfo.profession2ID and memberInfo.profession2Rank then
                    player.prof1 = { memberInfo.profession2ID , memberInfo.profession2Rank };
                else
                    player.prof1 = { 0 , 0 };   -- Resetting the profession
                end

                if memberInfo.profession2ID and memberInfo.profession2Rank then
                    player.prof2 = { memberInfo.profession1ID , memberInfo.profession1Rank };
                else
                    player.prof2 = { 0 , 0 };   -- Resetting the profession
                end

            end
        end

        index = index + 1;
        processedCount = processedCount + 1;

        -- WoW's actual limit is variable, but I am aiming well below to be safe.
        if processedCount >= chunkSize then
            -- Schedule the next chunk
            C_Timer.After ( delay , function()
                Scan.UpdateRosterWithCommunitiesAPI ( roster, orderedRoster , count , members , index );
            end);
            return
        end
    end

    Scan.FinalizeRosterBuild ( roster, orderedRoster , count );
end

-- Method:          Scan.FinalizeRosterBuild( table, table, int )
-- What it Does:    Performs the final checks and processing after roster data is gathered.
-- Purpose:         To complete the scan cycle after operations.
Scan.FinalizeRosterBuild = function( roster, orderedRoster, count )
    -- For some reason, on occasion the entire guild DB doesn't load on the full server query...
    -- Check if the built roster size matches expected size (minus duplicates counted)
    local expectedSize = GRM.G_Util.GetNumGuildies() - count;
    local actualSize = GRM.Util.TableLength(roster);

    if actualSize ~= expectedSize then
        if GRM_G.DebugEnabled then
            print(string.format("GRM: Roster size mismatch. Expected ~%d, Got %d. Retrying scan soon.", expectedSize, actualSize));
        end
        C_Timer.After(5, function()
            GRM_G.CurrentlyScanning = false;
            Scan.BuildNewRoster();
        end);
        return;
    end

    for memberName in pairs(GRM_G.liveKickedToons) do
        if not roster[memberName] then
            GRM_G.liveKickedToons[memberName] = nil; -- Player kicked is confirmed not showing up in guild.
        end
    end
    local atLeastOneOverall = (next(roster) ~= nil);
    if atLeastOneOverall and GRM_G.guildName ~= nil and GRM_G.guildName ~= "" then

        if not GRM.GetGuild() then
            Scan.BuildNewGuildOrNameChange(roster);
        else
            -- Normal processing for an existing, found guild
            GRM.G_Util.CheckGuildRanks(); -- Ensure this is safe to call now
            C_Timer.After ( 0.1 , function()
                Scan.BaseScanningComplete_MoveToChanges( roster , orderedRoster );
            end);
        end
    else
        -- Case where no members were found or guild name is missing
        if GRM_G.DebugEnabled then
            print("GRM: Finalizing roster build, but no members found or guild name missing.");
        end
        GRM_G.CurrentlyScanning = false; -- Allow next scan attempt later
    end
end

-- Method:          Scan.BaseScanningComplete_MoveToChanges( table , table )
-- What it Does:    Allows the scanning for recommendations to be completely asynchronously and thne only to move on to here when done
-- Purpose:         Prevent overload and stuttering in game when processing large guilds with many macro rules.
Scan.BaseScanningComplete_MoveToChanges = function( roster , orderedRoster )
    -- Only moves forward once Async Recommendations scan process is finished.
    if Scan.currentScanState and Scan.currentScanState.isRunning then
        C_Timer.After(0.1 , function()
            Scan.BaseScanningComplete_MoveToChanges(roster , orderedRoster);
        end);
        return;
    end

    GRM_G.ThrottleControlNum = 1;   -- Reset throttle control if needed for CheckPlayerChanges
    GRM_G.newPlayers = {};          -- Reset for CheckPlayerChanges
    GRM_G.leavingPlayers = {};

    GRM.GuildRoster();
    QueryGuildEventLog();

    -- Sort the ordered roster *before* passing to CheckPlayerChanges
    sort(orderedRoster);

    C_Timer.After(0.1, function()
        Scan.CheckPlayerChanges(roster, orderedRoster, 1);
    end);

end

-- Method:          Scan.BuildNewGuildOrNameChange ( table )
-- What it Does:    Guild namechange detection
-- Purpose:         Determine if it is a guild nameChange and if so, to convert DB to new name without losing everything.
Scan.BuildNewGuildOrNameChange = function(roster )

    local guildNameChanged, currentGuildName, oldGuildName = Scan.GuildNameChanged(GRM_G.guildName);

    if not forceRebuild and guildNameChanged then
        Scan.ProcessGuildNameChange(currentGuildName, oldGuildName);

    else
        GRM.Report("\n" .. GRM.L("Guild Roster Manager") .. "\n" .. GRM.L("Analyzing guild for the first time...") ..
                       "\n" .. GRM.L("Building Profiles on ALL \"{name}\" members", GRM.SlimName(GRM_G.guildName)) ..
                       "\n\n");
        -- This reiterates over this, because sometimes it can have a delay. This ensures it is secure.

        local clubID = C_Club.GetGuildClubId();

        if not GRM.GetGuild() then
            GRM_GuildMemberHistory_Save[GRM_G.guildName] = {};
            GRM_GuildMemberHistory_Save[GRM_G.guildName]["grmName"] = GRM_G.guildName;
            GRM_GuildMemberHistory_Save[GRM_G.guildName]["grmCreationDate"] = GRM_G.guildCreationDate or "";
            GRM_GuildMemberHistory_Save[GRM_G.guildName]["grmNumRanks"] = GuildControlGetNumRanks() or 0;
            GRM_GuildMemberHistory_Save[GRM_G.guildName]["grmClubID"] = clubID or 0;

            GRM_PlayersThatLeftHistory_Save[GRM_G.guildName] = {};

            -- Configure and initialize the backup tables.
            GRM_GuildDataBackup_Save[GRM_G.guildName] = {};
            GRM_GuildDataBackup_Save[GRM_G.guildName].guildCreationDate = GRM_G.guildCreationDate;
            GRM_GuildDataBackup_Save[GRM_G.guildName].numGuildies = 0;
            GRM_GuildDataBackup_Save[GRM_G.guildName].date = {0,0,0};
            GRM_GuildDataBackup_Save[GRM_G.guildName].epochDate = 0;
            GRM_GuildDataBackup_Save[GRM_G.guildName].alts = {};

            GRM_Restore_Members[GRM_G.guildName] = {};
            GRM_Restore_FormerMembers[GRM_G.guildName] = {};
            GRM_Restore_Log[GRM_G.guildName] = {};


            -- Make sure guild is not already added.
            if not GRM_PlayerListOfAlts_Save[GRM_G.guildName] then
                GRM_PlayerListOfAlts_Save[GRM_G.guildName] = {};
            end

            -- Log table
            if GRM_LogReport_Save[GRM_G.guildName] == nil then
                GRM_LogReport_Save[GRM_G.guildName] = {};
            end

            -- Calendar table
            GRM_CalendarAddQue_Save[GRM_G.guildName] = {};

            if GRM_Alts[GRM_G.guildName] == nil then
                GRM_Alts[GRM_G.guildName] = {};
            end

            for player in pairs(roster) do
                -- Build the guild and add each player
                GRM.AddMemberRecord(roster[player], false, nil);
                if GRM_GuildMemberHistory_Save[GRM_G.guildName][player] ~= nil then
                    GRM_GuildMemberHistory_Save[GRM_G.guildName][player].lastOnline = roster[player].lastOnline; -- Setting Timestamp for the first time only.
                    GRM_GuildMemberHistory_Save[GRM_G.guildName][player].lastOnlineTime = roster[player].lastOnlineTime;
                end
            end

            -- Add new guild
            GRM_AddonSettings_Save[GRM_G.guildName] = {};

            -- Load the Default Settings
            for i = 0, GRM_G.SettingsPages do
                GRM.SetDefaultAddonSettings(GRM_AddonSettings_Save[GRM_G.guildName], i);
            end

            if GRM.IsAddOnLoaded("epgp") and GRM.S().joinDateDestination ~= 3 then
                GRM.S().joinDateDestination = 2;
            end

            GRM.GuildSpecificConfigurations();
            GRM_UI.ReloadAllFrames(true, false);

            if not GRM_G.MainHookConfigured then
                GRM.MessageHookControl();
            end

        end
    end
    GRM_G.CurrentlyScanning = false;
    GRM_G.ScanControl = 0; -- Since updating the guild, we will reset this back to zero as it never actually scanned the guild. Thsi resolves that.
end

-- Method:          Scan.ProcessGuildNameChange ( string , string )
-- What it Does:    Changes the guildName
-- Purpose:         Allows use of compartmentalizing the guildNameChange so a popupWindow can confirm
Scan.ProcessGuildNameChange = function(currentGuildName, oldGuildName)

    GRM_PlayersThatLeftHistory_Save[currentGuildName] = {};
    GRM_PlayersThatLeftHistory_Save[currentGuildName] = GRM.Util.DeepCopyArray(GRM_PlayersThatLeftHistory_Save[oldGuildName]);
    GRM_PlayersThatLeftHistory_Save[oldGuildName] = nil;

    GRM_GuildMemberHistory_Save[currentGuildName] = {};
    GRM_GuildMemberHistory_Save[currentGuildName] = GRM.Util.DeepCopyArray(GRM_GuildMemberHistory_Save[oldGuildName]);
    GRM_GuildMemberHistory_Save[currentGuildName].grmName = currentGuildName;
    GRM_GuildMemberHistory_Save[oldGuildName] = nil;

    GRM_PlayerListOfAlts_Save[currentGuildName] = {};
    GRM_PlayerListOfAlts_Save[currentGuildName] = GRM.Util.DeepCopyArray(GRM_PlayerListOfAlts_Save[oldGuildName]);
    GRM_PlayerListOfAlts_Save[oldGuildName] = nil;

    GRM_LogReport_Save[currentGuildName] = {};
    GRM_LogReport_Save[currentGuildName] = GRM.Util.DeepCopyArray(GRM_LogReport_Save[oldGuildName]);
    GRM_LogReport_Save[oldGuildName] = nil;

    GRM_CalendarAddQue_Save[currentGuildName] = {};
    GRM_CalendarAddQue_Save[currentGuildName] = GRM.Util.DeepCopyArray(GRM_CalendarAddQue_Save[oldGuildName]);
    GRM_CalendarAddQue_Save[oldGuildName] = nil;

    GRM_Alts[currentGuildName] = GRM.Util.DeepCopyArray(GRM_Alts[oldGuildName]);
    GRM_Alts[oldGuildName] = nil;

    -- Also need to change the guild's name in the saved database...
    if GRM_GuildDataBackup_Save[oldGuildName].date[1] ~= 0 then
        GRM_Restore_Members[oldGuildName].grmName = currentGuildName;
    end

    GRM_GuildDataBackup_Save[currentGuildName] = {};
    GRM_GuildDataBackup_Save[currentGuildName] = GRM.Util.DeepCopyArray(GRM_GuildDataBackup_Save[oldGuildName]);
    GRM_GuildDataBackup_Save[oldGuildName] = nil;

    GRM_Restore_Members[currentGuildName] = GRM.Util.DeepCopyArray(GRM_Restore_Members[oldGuildName]);
    GRM_Restore_Members[oldGuildName] = nil;

    GRM_Restore_FormerMembers[currentGuildName] = GRM.Util.DeepCopyArray(GRM_Restore_FormerMembers[oldGuildName]);
    GRM_Restore_FormerMembers[oldGuildName] = nil;

    GRM_Restore_Log[currentGuildName] = GRM.Util.DeepCopyArray(GRM_Restore_Log[oldGuildName]);
    GRM_Restore_Log[oldGuildName] = nil;

    local tempName = GRM.GetStringClassColorByName(GRM_G.addonUser) .. GRM.SlimName(GRM_G.addonUser) .. "|r";
    local logEntryWithTime, logEntry = GRM.GetGuildNameChangeString(tempName, GRM.SlimName(currentGuildName),
        GRM.Time.GetTimestamp());

    GRM.PrintLog({15, logEntry});
    GRM.Log.AddLog({15, logEntryWithTime, tempName, GRM.SlimName(currentGuildName), GRM.Time.GetTimestamp()},
        currentGuildName);
end

-- Method:          Scan.GuildNameChanged( string )
-- What it Does:    Returns true if the player's guild is the same, it just changed its name
-- Purpose:         Good to know... what a pain it would be if you had to reset all of your settings
Scan.GuildNameChanged = function(currentGuildName)
    local result = false;
    local oldGuildName = "";

    if GRM_GuildMemberHistory_Save[currentGuildName] == nil or (GRM_GuildMemberHistory_Save[currentGuildName] ~= nil and GRM_GuildMemberHistory_Save[currentGuildName].grmClubID ~= GRM_G.gClubID) then
        for guild in pairs(GRM_GuildMemberHistory_Save) do
            if GRM_GuildMemberHistory_Save[guild].grmClubID == GRM_G.gClubID then
                result = true;
                oldGuildName = guild;
            end
        end
    end

    return result, currentGuildName, oldGuildName;
end

-- Method:          Scan.CheckPlayerChanges ( array , array , ind , guildTable )
-- What it Does:    Scans through guild roster and re-checks for any  (Will only fire if guild is found!)
-- Purpose:         Keep whoever uses the addon in the know instantly of what is going and changing in the guild.
Scan.CheckPlayerChanges = function(roster, orderedRoster, ind, guildData)

    if GRM_G.S.scanEnabled or GRM_G.OnFirstLoad or GRM_G.ManualScanEnabled then

        guildData = guildData or GRM.GetGuild();
        local newPlayerFound;
        local player = {};
        local updatedPlayer = {};
        local c = 0;
        local max = 150;

        if not guildData then
            GRM_G.changeHappenedExitScan = true; -- Forces the kill switch.
        end

        if Scan.ScanKillSwitch() then -- Necessary in case you purge guild in middle of scan
            return;
        end

        for i = ind, #orderedRoster do

            newPlayerFound = true;
            player = guildData[orderedRoster[i]];
            updatedPlayer = roster[orderedRoster[i]];

            if player then

                -- Compare GUIDs not just names
                if player.GUID == updatedPlayer.GUID or
                    (player.isTransfer and updatedPlayer.name == player.name and updatedPlayer.class == player.class) then -- In case someone deleted a toon, then joined a new toon with same name, need to confirm it is the same.

                    newPlayerFound = false;
                    Scan.CheckLogChanges(updatedPlayer, player, orderedRoster[i]);
                    Scan.CheckRosterChanges(updatedPlayer, player, orderedRoster[i]);

                else
                    -- This means same name found, but different GUIDs, so different toon.
                    -- Player found in existing database - they need to be added to leaving players, then need to import the new player.
                    newPlayerFound = true;

                    GRM.Log.AddLeftOrKickEntry(Scan.RecordKickChanges(player.name, GRM.SlimName(player.name),
                        GRM.Time.GetTimestamp()));

                end
            end

            -- NEW PLAYER FOUND! (Maybe)
            if newPlayerFound then
                if not GRM_G.liveKickedToons[updatedPlayer.name] then
                    table.insert(GRM_G.newPlayers, updatedPlayer);
                end
            end

            c = c + 1;
            if c == max and i ~= #orderedRoster then
                C_Timer.After(0.25, function()
                    Scan.CheckPlayerChanges(roster, orderedRoster, i + 1, guildData);
                end);
                return;
            end

        end

        guildData = Scan.CheckLogJoinOrLeave(roster, guildData);

        -- OK, let's close this out!!!!!
        -- Seeing if any upcoming notable events, like anniversaries/birthdays
        Scan.CheckPlayerEvents();
        Scan.ScanRecommendationsList_Async( true ); -- Ensure this is safe

    else
        -- Seeing if any upcoming notable events, like anniversaries/birthdays
        Scan.CheckPlayerEvents();
        Scan.ScanRecommendationsList_Async( true ); -- Ensure this is safe

    end
end

-- Method:          Scan.FinishedScan()
-- What it Does:    Wraps up the scan of the roster
-- Purpose:         Communication
Scan.FinishedScan = function()
    Scan.FinalReport();

    -- Disable manual scan if activated.
    if GRM_G.ManualScanEnabled and GRM_UI.GRM_ToolCoreFrame.MacroSuccess then
        GRM_G.ManualScanEnabled = false;
        GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("Manual Scan Complete"), 1.0, 0.84, 0);
    end

    if GRM_G.ManualScanEnabled and not GRM_UI.GRM_ToolCoreFrame.MacroSuccess then
        GRM_G.ManualScanEnabled = false;
        GRM.ValidateMacroRecordingSuccess(true);
    end
end

-- Method:          Scan.CheckLogChanges ( table , table )
-- What it Does:    Checks the player changes that can be cross-referenced from the log
-- Purpose:         Compartmentalize the scan
Scan.CheckLogChanges = function(updatedPlayer, player)
    if updatedPlayer.rankIndex ~= player.rankIndex then -- This checks to see if guild just changed the name of a rank.

        local added = false;
        local dateArray = GRM.Time.GetTimestamp();
        local epochTime = time();
        local logEntryroster = {};
        local rankShift = false;
        local needsUpdate = false;

        if GRM_G.numRanksHasChanged then

            if updatedPlayer.rankIndex == (player.rankIndex + GRM_G.rankChangeShift) then -- number of ranks added or removed - shift up or down.
                -- Adjust new rank index - make rank change good.
                if updatedPlayer.rankName == player.rankName then
                    player.rankIndex = updatedPlayer.rankIndex; -- Saving new rank Index Info
                    rankShift = true;
                    -- No need to ad
                end
            end
        end

        -- Promotion Obtained
        if updatedPlayer.rankIndex < player.rankIndex then

            if not GRM_G.livePromotedToons[updatedPlayer.name] and not GRM_G.liveDemotedToons[updatedPlayer.name] then
                needsUpdate = true;

                added, logEntryroster = Scan.GetGuildEventString(2, updatedPlayer.name, player.rankName,
                    updatedPlayer.rankName, nil, false);
                if added then
                    dateArray = logEntryroster[6][3];
                end
                Scan.RecordChanges(2, updatedPlayer, player, logEntryroster, dateArray);

            end

            -- Demotion Obtained
        elseif updatedPlayer.rankIndex > player.rankIndex then

            if not GRM_G.livePromotedToons[updatedPlayer.name] and not GRM_G.liveDemotedToons[updatedPlayer.name] then
                needsUpdate = true;
                added, logEntryroster = Scan.GetGuildEventString(1, updatedPlayer.name, player.rankName,
                    updatedPlayer.rankName, nil, false);
                if added then
                    dateArray = logEntryroster[6][3];
                end

                if updatedPlayer.rankName ~= player.rankName then

                    Scan.RecordChanges(9, updatedPlayer, player, logEntryroster, dateArray);
                end
            end
        end

        if needsUpdate then
            local oldRankIndex = tonumber(player.rankIndex); -- By setting it tonumber it returns a new memory reference.

            player.rankName = updatedPlayer.rankName; -- Saving new rank Info
            player.rankIndex = updatedPlayer.rankIndex; -- Saving new rank Index Info

            -- Clear if set to unknown
            player.promoteDateUnknown = false;

            -- For SYNC
            local isVerified = false;
            local verifiedTime = 0;
            local standardTime = "";

            if added then
                dateArray = logEntryroster[6][3];
                standardTime = logEntryroster[6][2];
            else
                standardTime = GRM.Time.ConvertToStandardFormatDate(dateArray[1], dateArray[2], dateArray[3]);
            end

            if added then
                isVerified = true;
                verifiedTime = epochTime;
            end

            if not rankShift then
                if #player.rankHist[1][5] == 1 then

                    player.rankHist[1][1] = player.rankName;
                    player.rankHist[1][2] = dateArray[1];
                    player.rankHist[1][3] = dateArray[2];
                    player.rankHist[1][4] = dateArray[3];
                    player.rankHist[1][5] = standardTime;
                    player.rankHist[1][6] = verifiedTime
                    player.rankHist[1][7] = isVerified;
                    player.rankHist[1][8] = 1;

                else
                    table.insert(player.rankHist, 1, {player.rankName, dateArray[1], dateArray[2], dateArray[3], standardTime,
                                                      verifiedTime, isVerified, 1});
                end

                -- Update the player index if it is the player themselves that received the change in rank.
                if updatedPlayer.name == GRM_G.addonUser then
                    Scan.AddonPlayerRankChange(updatedPlayer.rankIndex);
                    GRM_G.silenceOfficerNoteReporting, GRM_G.silenceOfficerTimer = Scan.SilenceOfficerNoteReport(
                        oldRankIndex, updatedPlayer.rankIndex);
                end
            end
        end

    elseif updatedPlayer.rankName ~= player.rankName and updatedPlayer.rankIndex == player.rankIndex then

        player.rankName = updatedPlayer.rankName; -- Saving new Info
        if #player.rankHist[1][5] > 0 then
            player.rankHist[1][1] = updatedPlayer.rankName; -- Adjusting the historical name if
            -- We are just renaming the rank in the history - nothing else.
        end

    elseif GRM_G.livePromotedToons[updatedPlayer.name] or GRM_G.liveDemotedToons[updatedPlayer.name] then

        -- Rank is the same now, let's remove them from promote or demote list.
        GRM_G.livePromotedToons[updatedPlayer.name] = nil;
        GRM_G.liveDemotedToons[updatedPlayer.name] = nil;

    end
end

-- Method:          Scan.CheckRosterChanges ( table , table , string )
-- What it Does:    Checks the player changes that are found by scanning roster, that are not in Guild Event Log
-- Purpose:         Compartmentalize the scanning for efficiency.
Scan.CheckRosterChanges = function(updatedPlayer, player, rosterName)
    -- Level
    if updatedPlayer.level ~= player.level then
        if updatedPlayer.level > player.level and GRM.S().recordLevelUp then
            local needsToRecord = false;
            local mileStones = {10, 20, 30, 40, 50};
            local level = 0;

            if GRM.S().levelReportMin <= updatedPlayer.level then
                needsToRecord = true
            else
                for i = (#mileStones), 1, -1 do
                    if updatedPlayer.level >= mileStones[i] and GRM.S().levelFilters[i] and player.level < mileStones[i] then
                        needsToRecord = true;
                        level = mileStones[i];
                        break
                    end
                end
            end
            if needsToRecord then
                Scan.RecordChanges(4, updatedPlayer, player, level, GRM.Time.GetTimestamp());
            end
        end
        player.level = updatedPlayer.level; -- Saving new Info
    end

    -- Check if we have the [D] tag and if relevant.
    if GRM_G.HardcoreActive and not player.HC.isDead and ( updatedPlayer.note:find("%[" .. GRM.L("D") .. "%]") or updatedPlayer.note:find("%[D%]") ) then
        local time = updatedPlayer.note:match("%[" .. GRM.L("D") .. "%]%-(%d%d%d%d%d%d%d%d)");
        local day, month, year;
        local dateArray = GRM.Time.GetTimestamp();
        dateArray[6] = false;

        if time and tonumber(time) ~= nil then
            day, month, year = GRM.Time.ParseStandardFormatDate(time);
            if day ~= "" then
                dateArray[1] = day;
                dateArray[2] = month;
                dateArray[3] = year;
                player.HC.timeOfDeath[6] = true
                dateArray[6] = true;
            end
        end

        -- Ok, set death status
        player.HC.isDead = true;
        player.HC.timeOfDeath[1] = dateArray[1];
        player.HC.timeOfDeath[2] = dateArray[2];
        player.HC.timeOfDeath[3] = dateArray[3];
        player.HC.timeOfDeath[4] = dateArray[4];
        player.HC.timeOfDeath[5] = dateArray[5];

        Scan.RecordChanges(14, updatedPlayer, nil, nil, dateArray)
    end

    -- Note
    if updatedPlayer.note ~= player.note then
        -- Let's first compare the notes... make sure they are not the same
        local isDifferent = true;
        local newNote, oldNote = "", "";

        if GetCVar("profanityFilter") == "1" then -- The profanity filter is on!
            newNote = Scan.NormalizeMatureWords(updatedPlayer.note);
            oldNote = Scan.NormalizeMatureWords(player.note);
        else
            newNote = updatedPlayer.note;
            oldNote = player.note;
        end

        if newNote == oldNote then
            isDifferent = false;
        end

        if isDifferent then
            Scan.RecordChanges( 5, updatedPlayer, player, nil, GRM.Time.GetTimestamp() );
            player.note = updatedPlayer.note;
            -- Update metaframe
            if GRM_UI.GRM_MemberDetailroster ~= nil and GRM_UI.GRM_MemberDetailroster:IsVisible() and GRM_G.currentName ==
                updatedPlayer.name then
                if updatedPlayer.note == "" then
                    if ( GRM.CanEditPublicNote() or (GRM_G.currentName == GRM_G.addonUser) ) then
                        GRM_UI.GRM_MemberDetailroster[rosterName].GRM_noteFontString1:SetText(GRM.L(
                            "Click here to set a Public Note"));
                    else
                        GRM_UI.GRM_MemberDetailroster[rosterName].GRM_noteFontString1:SetText(GRM.L(
                            "Unable to Edit Public Note at Rank"));
                    end
                else
                    GRM_UI.GRM_MemberDetailroster[rosterName].GRM_noteFontString1:SetText(updatedPlayer.note);
                end
                GRM_UI.GRM_MemberDetailroster[rosterName].GRM_PlayerNoteEditBox:SetText(updatedPlayer.note);
            end
        end
    end

    -- Officer Note
    if GRM.CanViewOfficerNote() and updatedPlayer.officerNote ~= player.officerNote then
        if updatedPlayer.officerNote == nil or player.officerNote == nil then
            player.officerNote = updatedPlayer.officerNote;
        else
            local isDifferent = true;
            local newNote, oldNote = "", "";

            if GetCVar("profanityFilter") == "1" then -- The profanity filter is on!
                newNote = Scan.NormalizeMatureWords(updatedPlayer.officerNote);
                oldNote = Scan.NormalizeMatureWords(player.officerNote);
            else
                newNote = updatedPlayer.officerNote;
                oldNote = player.officerNote;
            end

            if newNote == oldNote then
                isDifferent = false;
            end

            if isDifferent then
                -- Guild Leader! Let's check their officer note for changes for settings!
                Scan.RecordChanges(6, updatedPlayer, player, nil, GRM.Time.GetTimestamp());
                player.officerNote = updatedPlayer.officerNote;
            end
        end
        if GRM_UI.GRM_MemberDetailroster ~= nil and GRM_UI.GRM_MemberDetailroster:IsVisible() and GRM_G.currentName ==
            updatedPlayer.name then
            if updatedPlayer.officerNote == "" then
                if GRM.CanEditOfficerNote() then
                    GRM_UI.GRM_MemberDetailroster[rosterName].GRM_noteFontString2:SetText(GRM.L(
                        "Click here to set an Officer's Note"));
                else
                    GRM_UI.GRM_MemberDetailroster[rosterName].GRM_noteFontString2:SetText(GRM.L(
                        "Unable to Edit Officer Note at Rank"));
                end
            else
                GRM_UI.GRM_MemberDetailroster[rosterName].GRM_noteFontString2:SetText(updatedPlayer.officerNote);
            end
            GRM_UI.GRM_MemberDetailroster[rosterName].GRM_PlayerOfficerNoteEditBox:SetText(updatedPlayer.officerNote);
        end
        player.officerNote = updatedPlayer.officerNote;
    end

    -- Class Change - fix error or future class change redundancy if they ever implemented
    if updatedPlayer.class ~= player.class then
        player.class = updatedPlayer.class;
        -- TO DO IF EVER IMPLEMENTED
        -- UPDATE THE ALT INFO CLASS AS WELL IF NEED TO CHANGE.
    end

    -- Recommendations for Offline Kicks
    if updatedPlayer.lastOnline and player.lastOnline ~= updatedPlayer.lastOnline then

        -- Report inactive returns
        if GRM.S().reportInactiveReturn and player.lastOnline >= GRM.S().inactiveHours and updatedPlayer.lastOnline <
            GRM.S().inactiveHours and player.lastOnline > updatedPlayer.lastOnline then -- Player has logged in after having been inactive for greater than given time

            local needsToReport = true;

            local alts = GRM.GetAltNamesList(player);
            -- No need to report if any player's alts are active still...
            if #alts > 0 and GRM.S().allAltRequirement then
                if GRM.IsAnyAltActive(alts) then
                    needsToReport = false;
                end
            end

            if needsToReport then

                Scan.RecordChanges(13, updatedPlayer.name, player.lastOnlineTime, nil, GRM.Time.GetTimestamp()); -- Recording the change in hours to log
            end
        end

        player.lastOnline = updatedPlayer.lastOnline; -- Set new hours since last login.
    elseif not player.lastOnline then
        player.lastOnline = 1;
    end

    if updatedPlayer.lastOnlineTime and player.lastOnlineTime ~= updatedPlayer.lastOnlineTime then
        player.lastOnlineTime = updatedPlayer.lastOnlineTime;
    elseif not player.lastOnlineTime then
        player.lastOnlineTime = {0,0,0,1};  -- 1 hr placeholder
    end

    -- Just straight update these everytime... No need for change check
    if (updatedPlayer.isOnline and player.zone ~= updatedPlayer.zone) or GRM_G.OnFirstLoad then
        player.timeEnteredZone = time(); -- Resetting the time on hitting this zone.
    end

    -- Add Mythic Score if applicable
    if GRM_G.BuildVersion >= 80000 and updatedPlayer.MythicScore and player.MythicScore ~= updatedPlayer.MythicScore then
        player.MythicScore = updatedPlayer.MythicScore;
    elseif not player.MythicScore then
        player.MythicScore = 0;
    end

    -- Add Faction if applicable (WoW since DF)
    if updatedPlayer.faction and player.faction ~= updatedPlayer.faction then
        player.faction = updatedPlayer.faction;
    elseif not player.faction then
        player.faction = GRM_G.faction
    end

    if updatedPlayer.race and GRM_G.raceIDEnum[player.race] ~= updatedPlayer.race then
        local race = C_CreatureInfo.GetRaceInfo ( updatedPlayer.race );
        if race and race.clientFileString then
            player.race = race.clientFileString;
        else
            player.race = "Human";  -- Temporary Placeholder - probably won't happen unless server is laggy
        end
    elseif not player.race then
        player.race = "Human";  -- placeholder til next scan
    end

    if updatedPlayer.sex and player.sex ~= updatedPlayer.sex then
        player.sex = updatedPlayer.sex;
    elseif not player.sex then
        player.sex = 2; -- Default = male, just temp placeholder
    end

    -- Add Professions
    if not player.prof1 or #player.prof1 == 0 then
        player.prof1 = { 0 , 0 };
    end
    if not player.prof2 or #player.prof2 == 0 then
        player.prof2 = { 0 , 0 };
    end

    if updatedPlayer.prof1 then
        if player.prof1[1] ~= updatedPlayer.prof1[1] then
            player.prof1[1] = updatedPlayer.prof1[1];
        end
        if player.prof1[2] ~= updatedPlayer.prof1[2] then
            player.prof1[2] = updatedPlayer.prof1[2];
        end
    elseif player.prof1[1] ~= 0 then
        player.prof1 = { 0 , 0 };   -- Resetting the profession
    end

    if updatedPlayer.prof2 then
        if player.prof2[1] ~= updatedPlayer.prof2[1] then
            player.prof2[1] = updatedPlayer.prof2[1];
        end
        if player.prof2[2] ~= updatedPlayer.prof2[2] then
            player.prof2[2] = updatedPlayer.prof2[2];
        end
    elseif player.prof2[1] ~= 0 then
        player.prof2 = { 0 , 0 };   -- Resetting the profession
    end

    if player.zone ~= updatedPlayer.zone then
        player.zone = updatedPlayer.zone; -- zone
    end
    if player.achievementPoints ~= updatedPlayer.achievementPoints then
        player.achievementPoints = updatedPlayer.achievementPoints; -- Achievement pts
    end
    if player.isMobile ~= updatedPlayer.isMobile then
        player.isMobile = updatedPlayer.isMobile; -- isMobile
    end
    if player.guildRep ~= updatedPlayer.rep then
        player.guildRep = updatedPlayer.rep; -- Guild Reputation
    end
    if player.isOnline ~= updatedPlayer.isOnline then
        player.isOnline = updatedPlayer.isOnline; -- online Status
    end
    if player.status ~= updatedPlayer.status then
        player.status = updatedPlayer.status; -- Active Status
    end

    -- No need to keep this info once player has been imported.
    if player.isTransfer then
        player.isTransfer = nil;
    end
end

-- Method:          Scan.CheckLogJoinOrLeave ( table )
-- What it Does:    Registers if a player as joined or left the guild and builds the string after making changes
-- Purpose:         Control flow of log information in updating GRM.
Scan.CheckLogJoinOrLeave = function(roster, data)

    local guildData = data;

    -- Scan the roster for missing names...
    for _, member in pairs(guildData) do
        if type(member) == "table" then
            if roster[member.name] == nil then -- It exists in the existing database, but the updated one it is missing, thus implying player is no longer in the guild.
                table.insert(GRM_G.leavingPlayers, member);
            end
        end
    end

    -- Final check on players that left the guild to see if they are namechanges.GRM.CanViewOfficerNote
    local playerNotMatched = true;
    if #GRM_G.leavingPlayers > 0 and #GRM_G.newPlayers > 0 then
        for k = 1, #GRM_G.leavingPlayers do
            playerNotMatched = true;

            for j = 1, #GRM_G.newPlayers do
                if (GRM_G.leavingPlayers[k] ~= nil and GRM_G.newPlayers[j] ~= nil) and GRM_G.leavingPlayers[k].GUID ==
                    GRM_G.newPlayers[j].GUID then -- COMPARING GUID
                    playerNotMatched = false; -- In other words, player was found, but it's a namechange!!!!!
                    -- Match Found!!!
                    Scan.RecordChanges(12, GRM_G.newPlayers[j], GRM_G.leavingPlayers[k], nil,
                        GRM.Time.GetTimestamp());

                    -- We need to change the name EVERYWHERE!!!
                    for member in pairs(guildData) do
                        if type(guildData[member]) == "table" then
                            if GRM_G.leavingPlayers[k].GUID == guildData[member].GUID then -- Mathching the Leaving player to historical index so it can be identified and new name stored.

                                -- Need to remove him from list of alts IF he has a lot of alts...
                                GRM.ChangePlayerNameInAltGrouping(GRM_G.leavingPlayers[k].name, GRM_G.newPlayers[j].name);

                                -- Group Info module -- update player Name change as well
                                if GRM_GroupInfo_Save ~= nil then
                                    GRM_GroupInfo_Save[GRM_G.newPlayers[j].name] = {};
                                    GRM_GroupInfo_Save[GRM_G.newPlayers[j].name] = GRM.Util.DeepCopyArray(
                                        GRM_GroupInfo_Save[GRM_G.leavingPlayers[k].name]);
                                    GRM_GroupInfo_Save[GRM_G.leavingPlayers[k].name] = nil;
                                end

                                guildData[GRM_G.newPlayers[j].name] = {};
                                guildData[GRM_G.newPlayers[j].name] = GRM.Util.DeepCopyArray(
                                    guildData[GRM_G.leavingPlayers[k].name]);
                                guildData[GRM_G.newPlayers[j].name].name = GRM_G.newPlayers[j].name; -- Need to update this new name too!
                                guildData[GRM_G.leavingPlayers[k].name] = nil;
                                break
                            end
                        end
                    end
                    -- since namechange identified, also need to remove name from GRM_G.newPlayers array now.
                    if #GRM_G.newPlayers == 1 then
                        GRM_G.newPlayers = {}; -- Clears the array of the one name.
                    else
                        table.remove(GRM_G.newPlayers, j);
                    end
                    break
                end
            end

            -- Player not matched! For sure this player has left the guild!
            if playerNotMatched then
                Scan.RecordChanges(11, GRM_G.leavingPlayers[k], GRM_G.leavingPlayers[k], nil,
                    GRM.Time.GetTimestamp());
            end
        end

    elseif #GRM_G.leavingPlayers > 0 then
        for i = 1, #GRM_G.leavingPlayers do
            Scan.RecordChanges(11, GRM_G.leavingPlayers[i], GRM_G.leavingPlayers[i], nil, GRM.Time.GetTimestamp());
        end
    end

    if #GRM_G.newPlayers > 0 then
        for i = 1, #GRM_G.newPlayers do
            Scan.RecordChanges(10, GRM_G.newPlayers[i], nil, nil, GRM.Time.GetTimestamp());
        end
    end

    -- Now that we have collected all the players to be kicked... Let's not spam the log with alt info by parsing it properly.
    if #GRM_G.TempLeftGuildPlaceholder > 0 then
        for i = 1, #GRM_G.TempLeftGuildPlaceholder do
            GRM.Log.AddLeftOrKickEntry(Scan.RecordKickChanges(GRM_G.TempLeftGuildPlaceholder[i][1],
                GRM_G.TempLeftGuildPlaceholder[i][3], GRM_G.TempLeftGuildPlaceholder[i][4]));
        end
    end

    return guildData;
end

-- Method:          Scan.RecordKickChanges ( string , boolean , array , string , bool )
-- What it Does:    Records and logs the changes for when a guildie either is KICKED or leaves the guild
-- Purpose:         Having its own function saves on repeating a lot of code here.
Scan.RecordKickChanges = function(unitName, playerWasKicked, dateArray, officerThatKicked , refresh_macro_tool )
    local date_table = GRM.Time.GetTimestamp();
    local timeEpoch = time();
    local oldMemberData = GRM.GetFormerMembers();
    local player = GRM.GetPlayer(unitName);
    local classColorCode = GRM.GetStringClassColorByName(unitName);
    local timePassed = GRM.Time.GetTimePlayerHasBeenMember(unitName);
    local added = false;
    local logEntryMetaData = {};
    local listOfAlts = {};
    local tempStorage = {(classColorCode .. unitName .. "|r"), playerWasKicked, timePassed};
    local isNoLongerOnServer = false;
    local playerLevel = 0;
    local customNote = "";
    local stringFound = false;
    local standardDate = "";
    -- Live detection
    if officerThatKicked ~= nil then
        added = true;
        logEntryMetaData =
        {
            true,
            GRM.GetStringClassColorByName(officerThatKicked) .. GRM.FormatName(officerThatKicked) .. "|r",
            (classColorCode .. unitName .. "|r"),
            -- Let's manually add the timestamp
            { GRM.Time.FormatTimeStamp ( {date_table[1], date_table[2], date_table[3]} , false , false ) .. " " .. GRM.Time.GetFormatTime(date_table[4], date_table[5]) , time() , date_table }
        };
        -- Guild Event Log Detection
    else
        added, logEntryMetaData = Scan.GetGuildEventString(3, unitName); -- Kicked from the guild.
        if logEntryMetaData[1] then
            -- added = true
            date_table = logEntryMetaData[4][3];
            standardDate = logEntryMetaData[4][2];
            stringFound = true;
            if logEntryMetaData[3] ~= nil then
                tempStorage[2] = true;
            else
                tempStorage[2] = false;
            end
        end

    end

    -- metaData = 4
    table.insert(tempStorage, logEntryMetaData); -- index 4

    -- Finding Player's record for removal of current guild and adding to the Left Guild table.
    if player then
        -- Found!
        if player.customNote[4] ~= "" then
            customNote = player.customNote[4];
        end

        if standardDate == "" then
            standardDate = GRM.Time.ConvertToStandardFormatDate(date_table[1], date_table[2], date_table[3]);
        end

        if #player.rankHist[1][5] == 1 then

            player.rankHist[1][1] = player.rankName;
            player.rankHist[1][2] = date_table[1];
            player.rankHist[1][3] = date_table[2];
            player.rankHist[1][4] = date_table[3];
            player.rankHist[1][5] = standardDate;
            player.rankHist[1][6] = 0
            player.rankHist[1][7] = false;
            player.rankHist[1][8] = 1;

        end

        if #player.joinDateHist[1][4] == 1 then
            player.joinDateHist[1][1] = date_table[1];
            player.joinDateHist[1][2] = date_table[2];
            player.joinDateHist[1][3] = date_table[3];
            player.joinDateHist[1][4] = standardDate;
            player.joinDateHist[1][5] = 0
            player.joinDateHist[1][6] = false;
            player.joinDateHist[1][7] = 1;
        end

        table.insert(player.rankHist, 1,
            {player.rankName, date_table[1], date_table[2], date_table[3], standardDate, timeEpoch, true, 3}); -- 3 means left guild
        table.insert(player.joinDateHist, 1, {date_table[1], date_table[2], date_table[3], standardDate, timeEpoch, true, 2});

        -- If not banned, then let's ensure we reset his data.
        if not player.bannedInfo[1] then
            player.bannedInfo[1] = false;
            player.bannedInfo[2] = 0;
            player.bannedInfo[3] = false;
            player.bannedInfo[4] = "";
            player.reasonBanned = "";
        end

        -- Adding to LeftGuild Player history library
        oldMemberData[unitName] = {};
        oldMemberData[unitName] = GRM.Util.DeepCopyArray(player);

        playerLevel = oldMemberData[unitName].level;

        local main, GUID, class = GRM.GetAltGroupMain(oldMemberData[unitName].altGroup, true);

        -- I don't want to set the main history to be themselves because if they rejoin the guild later, with themselves set as main that could be irrelevant because things change...
        if main ~= "" and main ~= unitName then
            oldMemberData[unitName].mainAtTimeOfLeaving = {main, GUID, class};
        end

        -- Removing it from the alt list
        local altGroup = GRM.GetAltGroup(player.altGroup);
        if GRM.PlayerHasAlts(player) then

            -- Let's add them to the end of the report
            local alts = GRM.Util.DeepCopyArray(GRM.GetListOfAlts(player, true));
            local isFound = false;

            -- Ok, for lookup if they ever rejoin
            oldMemberData[unitName].altsAtTimeOfLeaving = alts;

            for m = 1, #alts do
                isFound = false;

                -- Only do this if on a scan, not a live detection.
                if officerThatKicked == nil then
                    -- Verify the alt is not on the kick list already;
                    for r = 1, #GRM_G.TempLeftGuildPlaceholder do
                        if GRM_G.TempLeftGuildPlaceholder[r][1] == alts[m][1] then
                            isFound = true;
                            break
                        end
                    end
                end

                if not isFound then
                    table.insert(listOfAlts, GRM.GetClassifiedName(alts[m][1], true));
                end
            end

            -- -- Let's overwrite the listOfAts
            if refresh_macro_tool == nil then
                refresh_macro_tool = true
            end

            GRM.RemovePlayerFromAltGroup(unitName, 0, false, refresh_macro_tool , false , true);

            -- Set alt to main if it is only one left.
            if GRM.IsFormerMemberMain(oldMemberData[unitName]) and #alts == 1 then
                local tempEpochTime = 1;
                if added then
                    tempEpochTime = timeEpoch;
                end

                GRM.SetMain(alts[1][1], tempEpochTime);
            end

            if altGroup then

                GRM.RemoveAltGroup(player.altGroup);
                oldMemberData[unitName].altGroup = "";
            end

        elseif player.altGroup ~= "" then

            GRM.RemoveAltGroup(player.altGroup);
            oldMemberData[unitName].altGroup = "";
        end

        oldMemberData[unitName].altGroup = "";
        -- removing from active member library
        GRM_GuildMemberHistory_Save[GRM_G.guildName][unitName] = nil;

    end
    table.insert(tempStorage, listOfAlts); -- index 5

    local mainName, playerHasAlts = GRM.GetFormattedMainName(unitName, false);
    if mainName ~= "" and mainName ~= unitName and playerHasAlts then
        -- Ok, if they have no mainName, let's check the left player's list for matches..
        table.insert(tempStorage, GRM.GetClassifiedName(mainName, true)); -- index 6

    else
        table.insert(tempStorage, ""); -- index 6
    end

    -- Now, let's add their officer/public notes.
    local p, o = "", "";
    if GRM.S().addNotesToLeft then
        player = oldMemberData[unitName];
        if player then
            if (player.note ~= nil and player.note ~= "") then
                p = player.note;
            end
            if (player.officerNote ~= nil and player.officerNote ~= "" and GRM.CanViewOfficerNote()) then
                o = player.officerNote;
            end
        end
    end
    -- Let's get it added to the log
    return tempStorage[1], tempStorage[2], tempStorage[3], tempStorage[4], tempStorage[5], tempStorage[6], p, o,
        dateArray, added, isNoLongerOnServer, playerLevel, customNote;
end

-- Method           Scan.RecordChanges( int , table , table )
-- What it does:    Builds all the changes, sorts them, then adds them to change report
-- Purpose:         Consolidation of data for final output report.
Scan.RecordChanges = function(indexOfInfo, member, memberOldInfo, logEntryMetaData, dateArray)

    if Scan.ScanKillSwitch() then -- Necessary in case you purge guild in middle of scan
        return;
    end

    local simpleName = "";
    if type(member) == "string" then
        simpleName = GRM.GetStringClassColorByName(member) .. GRM.SlimName(member) .. "|r";
    elseif indexOfInfo ~= 10 then
        simpleName = GRM.GetStringClassColorByName(member.name) .. GRM.SlimName(member.name) .. "|r";
    else
        simpleName = GRM.GetClassColorRGB(member.class, true) .. GRM.SlimName(member.name) .. "|r";
    end

    -- 2 = Guild Rank Promotion
    if indexOfInfo == 2 then
        local goodToAdd = true;
        if logEntryMetaData[1] then

            -- Ok, ranks are same name - does this mean the rank itself has shifted, or that there are ranks with the same name?
            -- Well, let's see if there are 2 ranks the same name..
            if logEntryMetaData[4] == logEntryMetaData[5] then
                local c = 0;
                for i = 1, GuildControlGetNumRanks() do
                    if GuildControlGetRankName(i) == logEntryMetaData[4] then
                        c = c + 1;
                    end
                end

                if c == 1 then
                    goodToAdd = false;
                end
            end
            if goodToAdd then
                GRM.Log.AddPromotionDateTempLogEntry(logEntryMetaData[1], logEntryMetaData[2], logEntryMetaData[3],
                    logEntryMetaData[4], logEntryMetaData[5], logEntryMetaData[6][3]);
            end
        else
            if memberOldInfo.rankName == member.rankName then
                local c = 0;
                for i = 1, GuildControlGetNumRanks() do
                    if GuildControlGetRankName(i) == memberOldInfo.rankName then
                        c = c + 1;
                    end
                end

                if c == 1 then
                    goodToAdd = false; -- This means there aren't multiple of same rank
                end
            end

            if goodToAdd then
                GRM.Log.AddPromotionDateTempLogEntry(logEntryMetaData[1], nil, simpleName, memberOldInfo.rankName,
                    member.rankName, dateArray);
            end
        end

        -- 9 = Guild Rank Demotion
    elseif indexOfInfo == 9 then

        local goodToAdd = true;
        if logEntryMetaData[1] then

            -- Ok, ranks are same name - does this mean the rank itself has shifted, or that there are ranks with the same name?
            -- Well, let's see if there are 2 ranks the same name..
            if logEntryMetaData[4] == logEntryMetaData[5] then
                local c = 0;
                for i = 1, GuildControlGetNumRanks() do
                    if GuildControlGetRankName(i) == logEntryMetaData[4] then
                        c = c + 1;
                    end
                end

                if c == 1 then
                    goodToAdd = false;
                end
            end

            if goodToAdd then
                GRM.Log.AddDemotionDateTempLogEntry(logEntryMetaData[1], logEntryMetaData[2], logEntryMetaData[3],
                    logEntryMetaData[4], logEntryMetaData[5], logEntryMetaData[6][3]);
            end
        else
            if memberOldInfo.rankName == member.rankName then
                local c = 0;
                for i = 1, GuildControlGetNumRanks() do
                    if GuildControlGetRankName(i) == memberOldInfo.rankName then
                        c = c + 1;
                    end
                end

                if c == 1 then
                    goodToAdd = false;
                end
            end

            if goodToAdd then
                GRM.Log.AddDemotionDateTempLogEntry(logEntryMetaData[1], nil, simpleName, memberOldInfo.rankName,
                    member.rankName, dateArray);
            end
        end

        -- 4 = level
    elseif indexOfInfo == 4 then
        GRM.Log.AddLeveledTempLogEntry(simpleName, logEntryMetaData, member.level, (member.level - memberOldInfo.level),
            dateArray, (member.level == GRM_G.LvlCap), member.name);

        -- 5 = note
    elseif indexOfInfo == 5 then
        GRM.Log.AddNoteTempLogEntry(simpleName, memberOldInfo.note, member.note, dateArray)
        -- 6 = officerNote
    elseif indexOfInfo == 6 then
        GRM.Log.AddOfficerNoteTempLogEntry(simpleName, memberOldInfo.officerNote, member.officerNote, dateArray);

        -- 8 = Guild Rank Name Changed to something else
    elseif indexOfInfo == 8 then
        GRM.Log.AddRankRenameEntry(nil, memberOldInfo.rankName, member.rankName, dateArray);

        -- 10 = New Player
    elseif indexOfInfo == 10 then
        -- Check against old member list first to see if returning player!
        Scan.RecordJoinChanges(member, simpleName, false, dateArray);

        -- 11 = Player Left
    elseif indexOfInfo == 11 then
        table.insert(GRM_G.TempLeftGuildPlaceholder, {member.name, simpleName, false, dateArray});

        -- 12 = NameChanged
    elseif indexOfInfo == 12 then
        local colorHex = GRM.GetClassColorRGB(memberOldInfo.class, true);
        GRM.Log.AddNameChangeTempLogEntry ((colorHex .. simpleName .. "|r"),
            (colorHex .. GRM.SlimName(memberOldInfo.name) .. "|r"), dateArray);

        -- 13 = Inactive Members Return!
    elseif indexOfInfo == 13 then
        GRM.Log.AddInactiveReturnTempLogEntry(simpleName, GRM.Time.HoursReport(memberOldInfo), dateArray);

    elseif indexOfInfo == 14 then
        GRM.Log.AddHardcoreDeathEntry(member.name, member.class, member.level, dateArray);
    end
end

-- Method:          Scan.RecordJoinChanges ( array , string , boolean , array , boolean )
-- What it Does:    Checks and records the new player changes... are they a returning player or completely new. Were they previously banned?
-- Purpose:         Keep the methods clean by compartmentalizing this rather lengthy function. It is also useful to not double the code as this will be called to on a live tracked event.
Scan.RecordJoinChanges = function(member, simpleName, liveJoinDetected, dateArray)
    -- Check against old member list first to see if returning player!
    local rejoin = false;
    -- Use default dates, since these are auto-tagged, you don't want your data to overwrite any others, so set it as OLD...
    local added, logEntryMetaData = Scan.GetGuildEventString(4, member.name, nil, nil, member.class, liveJoinDetected); -- For determining who did the invite.
    local date_table = GRM.Time.GetTimestamp();  -- Placeholder
    local timeStandard = "";
    local tempJoinStorage = {};
    local player;

    if added then
        timeStandard = logEntryMetaData[4][2];
        date_table = logEntryMetaData[4][3];
        tempJoinStorage = {logEntryMetaData[1], logEntryMetaData[2], logEntryMetaData[3], logEntryMetaData[4][3]};
    else
        tempJoinStorage = {false, nil, simpleName, dateArray};
        timeStandard = GRM.Time.ConvertToStandardFormatDate(date_table[1], date_table[2], date_table[3]);
    end

    -- It may not be registering in the log yet, but since it was live, we know this is now. Count it as added
    if not added and liveJoinDetected then
        added = true;
    end

    rejoin, member, simpleName, date_table, tempJoinStorage =
        Scan.IsRejoinAndSetDetails(member, simpleName, date_table, liveJoinDetected, tempJoinStorage, logEntryMetaData)

    if not rejoin then
        -- New Guildie. NOT a rejoin!
        local timeS = GRM.Time.FormatTimeStamp(date_table, false, false, GRM.S().globalDateFormat);
        local finalTStamp = "";
        local tempNote = "";
        local currentOfficerNote = tostring(member.officerNote);
        local currentPublicNote = tostring(member.note);
        local noteIsSet = false;
        local officerNoteIsSet = false;
        if GRM.S().includeTag then
            finalTStamp = GRM_G.customHeaderJoin .. " " .. timeS;
        else
            finalTStamp = timeS;
        end

        if added and GRM.S().addTimestampToNote and GRM.S().joinDateDestination < 3 then
            -- In case of index shift, let's re-get roster selection
            local verifyName = GetGuildRosterInfo(member.rosterSelection);
            local rosterSelection = 0;
            if verifyName == member.name then
                rosterSelection = member.rosterSelection;
            else
                rosterSelection = GRM.GetRosterSelectionID ( member.name , member.GUID );
            end

            if not rosterSelection then
                return; -- Sort of an edge case, but it can happen. Let's skip it. It will catch it on the next scan.
            end

            local name , _ , _ , _ , _ , _ , note , oNote = GetGuildRosterInfo(rosterSelection);

            if name == member.name then
                if not note then
                    note = "";
                end
                if not oNote then
                    oNote = "";
                end

                if GRM.S().joinDateDestination == 1 then
                    if GRM.CanEditOfficerNote() then
                        tempNote = finalTStamp .. " " .. GRM.RemoveDateFromNote(oNote);
                        if oNote == "" or GRM.GetNumLetters(tempNote) <= GRM_G.MaxOfficerNoteSize then
                            GuildRosterSetOfficerNote(rosterSelection, tempNote);
                            officerNoteIsSet = true
                            if liveJoinDetected then
                                member.officerNote = tempNote;
                            end
                        end
                    end
                elseif GRM.S().joinDateDestination == 2 then
                    if GRM.CanEditPublicNote() then
                        tempNote = finalTStamp .. " " .. GRM.RemoveDateFromNote(note);
                        if note == "" or GRM.GetNumLetters(tempNote) <= GRM_G.MaxPublicNoteSize then
                            GuildRosterSetPublicNote(rosterSelection, tempNote);
                            noteIsSet = true;
                            if liveJoinDetected then
                                member.note = tempNote;
                            end
                        end
                    end
                end
                -- Of note, cannot do adding custom note yet here because that relies on them being in the database. Profile needs to be built first which happens in a moment
            end
        end
        -- Adding to global saved array, adding to report
        GRM.AddMemberRecord(member, false, nil);

        -- now we can add the custom note
        if added and GRM.S().addTimestampToNote and GRM.S().joinDateDestination == 3 then
            GRM.SetJoinDateToCustomNote(member.name, finalTStamp);
        end

        if officerNoteIsSet or noteIsSet then
            finalTStamp = tempNote;
        end

        if not liveJoinDetected then

            GRM.Log.AddJoinEntry(tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3], tempJoinStorage[4],
                tempJoinStorage[5], tempJoinStorage[6]);
        else

            if GRM.S().toChat.joined then
                GRM.PrintLog({8,
                              select(2,
                    GRM.GetJoinOrRejoinString(tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3],
                        tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6]))});
            end
            GRM.Log.AddLog({8,
                        GRM.GetJoinOrRejoinString(tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3],
                tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6]), tempJoinStorage[1], tempJoinStorage[2],
                        tempJoinStorage[3], tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6]})
        end

        player = GRM.GetPlayer(member.name);
        -- adding join date to history and rank date.
        if player then

            local epochTimeStamp = 0;

            if added then
                epochTimeStamp = time();
            end

            player.anniversaryAnnounced = false;

            -- Add the tempTimeStamp to officer note... this avoids report spam
            -- Promo Date stamp
            if added then
                -- Clear if set to unknown
                player.promoteDateUnknown = false;

                if player.joinDateHist[1][3] == 0 then
                    player.joinDateHist[1][1] = date_table[1];
                    player.joinDateHist[1][2] = date_table[2];
                    player.joinDateHist[1][3] = date_table[3];
                    player.joinDateHist[1][4] = timeStandard;
                    player.joinDateHist[1][5] = epochTimeStamp;
                    player.joinDateHist[1][6] = added;
                    player.joinDateHist[1][7] = 1;
                else
                    table.insert(player.joinDateHist, 1, {date_table[1], date_table[2], date_table[3], timeStandard, epochTimeStamp, added, 1});
                end

            else
                -- Clear if set to unknown
                player.promoteDateUnknown = false;

                if player.joinDateHist[1][4] == 3 then
                    player.joinDateHist[1][1] = date_table[1];
                    player.joinDateHist[1][2] = date_table[2];
                    player.joinDateHist[1][3] = date_table[3];
                    player.joinDateHist[1][4] = timeStandard
                    player.joinDateHist[1][5] = 0
                    player.joinDateHist[1][6] = false;
                    player.joinDateHist[1][7] = 1;
                else
                    table.insert(player.joinDateHist, 1, {date_table[1], date_table[2], date_table[3],
                    timeStandard, 0, false, 1});
                end

            end

            -- Promo Date
            if #player.rankHist[1][5] == 1 then
                player.rankHist[1][1] = GuildControlGetRankName(GuildControlGetNumRanks()); -- Always lowest rank on new join
                player.rankHist[1][2] = date_table[1];
                player.rankHist[1][3] = date_table[2];
                player.rankHist[1][4] = date_table[3];
                player.rankHist[1][5] = timeStandard;
                player.rankHist[1][6] = epochTimeStamp;
                player.rankHist[1][7] = added
                player.rankHist[1][8] = 1;
            else
                table.insert(player.rankHist, 1, {GuildControlGetRankName(GuildControlGetNumRanks()), date_table[1], date_table[2], date_table[3],
                     timeStandard, epochTimeStamp, added, 1});
            end

            if not liveJoinDetected and added then
                if currentOfficerNote == nil or currentOfficerNote == "" then
                    if GRM.S().addTimestampToNote then
                        if GRM.S().joinDateDestination == 1 and GRM.CanEditOfficerNote() and
                            (player.officerNote == "" or player.officerNote == nil) then
                            player.officerNote = finalTStamp;
                        elseif GRM.S().joinDateDestination == 2 and GRM.CanEditPublicNote() and
                            (player.note == "" or player.note == nil) then
                            player.note = finalTStamp;
                        elseif GRM.S().joinDateDestination == 3 then
                            GRM.SetJoinDateToCustomNote(member.name, finalTStamp);
                        end
                    end

                elseif currentOfficerNote ~= nil and currentOfficerNote ~= "" then
                    if GRM.S().addTimestampToNote then
                        if GRM.S().joinDateDestination == 1 and GRM.CanEditOfficerNote() and
                            (player.officerNote == "" or player.officerNote == nil) then
                            player.officerNote = currentOfficerNote;
                        elseif GRM.S().joinDateDestination == 2 and GRM.CanEditPublicNote() and
                            (player.note == "" or player.note == nil) then
                            player.note = currentPublicNote;
                        elseif GRM.S().joinDateDestination == 3 then
                            GRM.SetJoinDateToCustomNote(member.name, finalTStamp);
                        end
                    end
                end
            end

            -- Let's check the notes
            if added then
                if noteIsSet and not liveJoinDetected and member.note ~= "" then
                    -- Add the public note!
                    GRM.Log.AddNoteTempLogEntry(GRM.GetClassifiedName(member.name, true), "", member.note,
                        GRM.Time.GetTimestamp());

                end
                -- Officer Note
                if officerNoteIsSet and not liveJoinDetected and member.officerNote ~= "" then
                    -- Add the Officer note!
                    GRM.Log.AddOfficerNoteTempLogEntry(GRM.GetClassifiedName(member.name, true), "", member.officerNote,
                        GRM.Time.GetTimestamp());
                end
            end

            if epochTimeStamp == 0 then
                epochTimeStamp = time();
            end

            -- Promotion Info
            if member.rankIndex < (GuildControlGetNumRanks() - 1) then
                -- Promotion Obtained since joining!
                local nameOfBaseRank = GuildControlGetRankName(GuildControlGetNumRanks());
                local added, logEntryMetaData = Scan.GetGuildEventString( 2, member.name, nameOfBaseRank, member.rankName,
                    liveJoinDetected);

                -- I don't want to have an instance where I have the promotion date in the log but the join date is too old os it has fallen off,
                -- Thus, if the exact join date cannot be determined, it will set the promotion date to be no different.

                -- Clear if set to unknown
                player.promoteDateUnknown = false;

                -- For SYNC
                if #player.rankHist[1][5] == 1 or player.rankHist[1][6] == 0 then

                    player.rankHist[1][1] = member.rankName;
                    player.rankHist[1][2] = date_table[1];
                    player.rankHist[1][3] = date_table[2];
                    player.rankHist[1][4] = date_table[3];
                    player.rankHist[1][5] = timeStandard;
                    player.rankHist[1][6] = epochTimeStamp;
                    player.rankHist[1][7] = added;
                    player.rankHist[1][8] = 1;

                else

                    if not player.rankHist[1][7] then
                        player.rankHist[1][7] = true;
                    end

                    table.insert(player.rankHist, 1,
                        {player.rankName, date_table[1], date_table[2], date_table[3],
                        timeStandard, epochTimeStamp, added, 1});
                end

                player.rankName = member.rankName; -- Saving new rank Info
                player.rankIndex = member.rankIndex; -- Saving new rank Index Info

                -- Ok data is saved! Now let's report it to the log...

                if logEntryMetaData[1] then
                    GRM.Log.AddPromotionDateTempLogEntry(logEntryMetaData[1], logEntryMetaData[2], logEntryMetaData[3],
                        logEntryMetaData[4], logEntryMetaData[5], logEntryMetaData[6][3]);
                else
                    GRM.Log.AddPromotionDateTempLogEntry(logEntryMetaData[1], nil, GRM.GetClassifiedName(member.name, true),
                        nameOfBaseRank, member.rankName, dateArray);
                end
            end
        end
    end

    -- This happened live and is 100% verified
    player = GRM.GetPlayer(member.name);
    if liveJoinDetected and player then

        local tStamp = GRM.Util.DeepCopyArray(player.joinDateHist[1]);
        player.joinDateHist[1][5] = tonumber(tStamp[5]);
        player.joinDateHist[1][6] = true;
        player.rankHist[1][6] = tonumber(tStamp[5]);
        player.rankHist[1][7] = true;

    end

    -- Live detection it refreshes the logs, not on first scan check on logon.
    if liveJoinDetected then
        GRM_UI.RefreshSelectFrames(true, true, true, true, true, true);
    end
end

-- Method:          Scan.IsRejoinAndSetDetails ( table , string , table , bool , array )
-- What it Does:    Checks the left player meta data, to the new player joining, and determins if they are rejoining, and if so, if they were banned
--                  It also manages setting the new officer/public note join date, if player uses said feature.
-- Purpose:         Special feature, scanning for changes, live tracking updates as player joins as well... and compartmentalizing this long function.
Scan.IsRejoinAndSetDetails = function(member, simpleName, date_table, liveJoinDetected, tempJoinStorage,
    logEntryMetaData)
    local oldMemberData = GRM.GetFormerMembers();
    if not oldMemberData then
        return;
    end

    local useTimeStamp = false;
    local timeStamp = {};

    tempJoinStorage[5] = false; -- is a rejoin
    tempJoinStorage[6] = 0; -- Player Level
    tempJoinStorage[7] = ""; -- The previousName
    tempJoinStorage[8] = 0; -- Number of Times in Guild
    tempJoinStorage[9] = false; -- IsBanned
    tempJoinStorage[10] = ""; -- reasonBanned
    tempJoinStorage[11] = ""; -- date left
    tempJoinStorage[12] = -1; -- How Long Ago
    tempJoinStorage[13] = ""; -- Date originally joined
    tempJoinStorage[14] = {}; -- Original Rank.
    tempJoinStorage[15] = ""; -- Custom Notes
    tempJoinStorage[16] = false; -- Guild transfer - Rejoin

    for _, player in pairs(oldMemberData) do -- Number of players that have left the guild
        if type(player) == "table" then

            if member.GUID == player.GUID or
                ((player.isTransfer or player.GUID == "") and member.name == player.name and member.class ==
                    player.class) then -- GUID comparison check - cannot rely purely on the name.
                tempJoinStorage[5] = true;
                -- MATCH FOUND - Player is RETURNING to the guild!
                -- Player has name-changed?
                if member.name ~= player.name then
                    local classColorString = GRM.GetClassColorRGB(player.class, true);

                    -- For the logging
                    tempJoinStorage[7] = (classColorString .. GRM.FormatName(player.name) .. "|r");
                    -- Update the banned player's name
                    player.name = member.name;
                end

                -- number of times in the guild
                tempJoinStorage[8] = math.floor(#player.joinDateHist / 2) + (#player.joinDateHist % 2);

                if date_table[1] ~= 0 then
                    timeStamp = date_table;
                    useTimeStamp = true;
                else
                    timeStamp = GRM.Time.GetTimestamp();
                end

                -- Universal Rejoin data whether banned or not
                -- Date player left the guild
                if #player.joinDateHist[1][4] > 1 then

                    tempJoinStorage[11] = { player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3] };
                end

                -- How long ago that was
                if #player.joinDateHist[1][4] > 1 and tempJoinStorage[10] ~= "" then
                    tempJoinStorage[12] = player.joinDateHist[1][4];
                end
                -- Date originally joined the guild the first time ever
                tempJoinStorage[13] = {player.joinDateHist[#player.joinDateHist][1],
                                       player.joinDateHist[#player.joinDateHist][2],
                                       player.joinDateHist[#player.joinDateHist][3]};
                -- Set original Rank
                tempJoinStorage[14] = player.rankHist[1][1]

                -- Set Custom Note details
                if player.customNote[4] ~= "" then
                    tempJoinStorage[15] = player.customNote[4];
                end

                if player.isTransfer then
                    tempJoinStorage[16] = true;
                end

                -- isBanned
                local index = 0;
                if player.bannedInfo[1] then
                    index = 9;
                    tempJoinStorage[9] = true;
                    tempJoinStorage[10] = player.reasonBanned;

                    if not liveJoinDetected then
                        -- Written fully out, not as necessary, but to make the next section easier to work with with specific named arguments rather than 16 indexes of an array
                        GRM.Log.AddBanRejoinEntry(tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3],
                            tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6], tempJoinStorage[7],
                            tempJoinStorage[8], tempJoinStorage[9], tempJoinStorage[10], tempJoinStorage[11],
                            tempJoinStorage[12], tempJoinStorage[13], tempJoinStorage[14], tempJoinStorage[15],
                            tempJoinStorage[16]);
                    else
                        useTimeStamp = true;
                    end
                else
                    index = 7;
                    -- No Ban found, player just returning!
                    -- Set member level
                    tempJoinStorage[6] = member.level;

                    if not liveJoinDetected then
                        -- Written fully out, not as necessary, but to make the next section easier to work with with specific named arguments rather than 16 indexes of an array
                        GRM.Log.AddNormalRejoinEntry(tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3],
                            tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6], tempJoinStorage[7],
                            tempJoinStorage[8], tempJoinStorage[9], tempJoinStorage[10], tempJoinStorage[11],
                            tempJoinStorage[12], tempJoinStorage[13], tempJoinStorage[14], tempJoinStorage[15],
                            tempJoinStorage[16]);
                    else
                        useTimeStamp = true;
                    end
                end

                -- Needs to be reported immediately rather than waiting.
                if liveJoinDetected then
                    if GRM.S().toChat.joined then
                        GRM.PrintLog({index,
                                      select(2,
                            GRM.GetJoinOrRejoinString(tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3],
                                tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6], tempJoinStorage[7],
                                tempJoinStorage[8], tempJoinStorage[9], tempJoinStorage[10], tempJoinStorage[11],
                                tempJoinStorage[12], tempJoinStorage[13], tempJoinStorage[14], tempJoinStorage[15],
                                tempJoinStorage[16]))});
                    end
                    GRM.Log.AddLog({index,
                                GRM.GetJoinOrRejoinString(tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3],
                        tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6], tempJoinStorage[7],
                        tempJoinStorage[8], tempJoinStorage[9], tempJoinStorage[10], tempJoinStorage[11],
                        tempJoinStorage[12], tempJoinStorage[13], tempJoinStorage[14], tempJoinStorage[15],
                        tempJoinStorage[16]), tempJoinStorage[1], tempJoinStorage[2], tempJoinStorage[3],
                                tempJoinStorage[4], tempJoinStorage[5], tempJoinStorage[6], tempJoinStorage[7],
                                tempJoinStorage[8], tempJoinStorage[9], tempJoinStorage[10], tempJoinStorage[11],
                                tempJoinStorage[12], tempJoinStorage[13], tempJoinStorage[14], tempJoinStorage[15],
                                tempJoinStorage[16]});

                end

                -- Adding timestamp to new Player.
                local noteIsSet = false;
                local officerNoteIsSet = false;
                if not player.isTransfer and GRM.S().addTimestampToNote and useTimeStamp then
                    local index;
                    local rosterSelection = GRM.GetRosterSelectionID ( member.name , member.GUID );

                    if rosterSelection and rosterSelection ~= 0 then
                        index = rosterSelection;
                    end

                    if index then
                        local name , _ , _ , _ , _ , _ , note , oNote , _ , _ , _ , _ , _ , _ , _ , _ , guid  = GetGuildRosterInfo(rosterSelection);

                        if not note then
                            note = "";
                        end
                        if not oNote then
                            oNote = "";
                        end

                        if name == member.name then
                            local timeS;
                            if not tempJoinStorage[1] then
                                timeS = GRM.Time.FormatTimeStamp(GRM.Time.GetTimestamp(), false, false,
                                    GRM.S().globalDateFormat);
                            else
                                timeS = GRM.Time.FormatTimeStamp(timeStamp, false, false, GRM.S().globalDateFormat);
                            end

                            local noteDate = "";
                            local tempNote = "";
                            if GRM.S().includeTag then
                                noteDate = GRM_G.customHeaderRejoin .. " " .. timeS;
                            else
                                noteDate = timeS;
                            end

                            if GRM.S().joinDateDestination == 1 then
                                if GRM.CanEditOfficerNote() then

                                    tempNote = noteDate .. " " .. GRM.RemoveDateFromNote(oNote);

                                    if oNote == "" or GRM.GetNumLetters(tempNote) <= GRM_G.MaxOfficerNoteSize then

                                        officerNoteIsSet = true;
                                        GuildRosterSetOfficerNote(rosterSelection, tempNote);

                                        if GRM_G.currentName == member.name then
                                            GRM_UI.GRM_MemberDetailMetaData.GRM_noteFontString2:SetText(tempNote);
                                            GRM_UI.GRM_MemberDetailMetaData.GRM_PlayerOfficerNoteEditBox:SetText(
                                                tempNote);
                                        end

                                        if liveJoinDetected then
                                            member.officerNote = tempNote
                                        end

                                    end
                                end
                            elseif GRM.S().joinDateDestination == 2 then
                                if GRM.CanEditPublicNote() then
                                    tempNote = noteDate .. " " .. GRM.RemoveDateFromNote(note);
                                    if note == "" or GRM.GetNumLetters(tempNote) <= GRM_G.MaxPublicNoteSize then
                                        noteIsSet = true;
                                        GuildRosterSetPublicNote(rosterSelection, tempNote);

                                        if GRM_G.currentName == player.name then
                                            GRM_UI.GRM_MemberDetailMetaData.GRM_noteFontString1:SetText(tempNote);
                                            GRM_UI.GRM_MemberDetailMetaData.GRM_PlayerNoteEditBox:SetText(tempNote);
                                        end

                                        if liveJoinDetected then
                                            member.note = tempNote
                                        end

                                    end
                                end
                            elseif GRM.S().joinDateDestination == 3 then
                                GRM.SetJoinDateToCustomNote(player.name, noteDate);
                            end

                        end
                    end

                    -- treat it like restoring the player, not rejoining them.
                    -- Restore their player notes.
                elseif player.isTransfer then
                    local index;
                    if rosterSelection and rosterSelection ~= 0 then
                        index = member.rosterSelection;
                    end

                    if index then
                        local note, oNote = select(7, GetGuildRosterInfo(rosterSelection));
                        if not note then
                            note = "";
                        end
                        if not oNote then
                            oNote = "";
                        end

                        if GRM.CanEditPublicNote() and player.note and player.note ~= "" and player.note ~= note then
                            GuildRosterSetPublicNote(rosterSelection, player.note);
                            member.note = player.note;
                        end
                        if GRM.CanEditOfficerNote() and player.officerNote and player.officerNote ~= "" and
                            player.officerNote ~= oNote then
                            GuildRosterSetOfficerNote(rosterSelection, player.officerNote);
                            member.officerNote = player.officerNote;
                        end
                    end
                end

                -- Make sure to include the officer and public notes if necessary as well for new players
                -- Public note
                if noteIsSet and not liveJoinDetected then
                    -- Add the public note!
                    if member.note ~= "" then
                        GRM.Log.AddNoteTempLogEntry(GRM.GetClassifiedName(member.name, true), "", member.note,
                            GRM.Time.GetTimestamp());
                    end
                end

                -- Officer Note
                if officerNoteIsSet and not liveJoinDetected then
                    -- Add the Officer note!
                    if member.officerNote ~= "" then
                        player.officerNote = member.officerNote;
                    end
                end
                -- Make sure the namechange is adjusted in the database or you will get a double report
                GRM.AddMemberRecord(member, true, GRM.Util.DeepCopyArray(player), liveJoinDetected, logEntryMetaData);

                if liveJoinDetected and GRM.AddRejoinToAltGroup(GRM.GetPlayer(member.name), player.isTransfer) then
                    GRM.Report(GRM.L("{name} has rejoined their original alt group.",
                        GRM.GetClassColorRGB(member.class, true) .. GRM.FormatName(member.name) .. "|r"));
                end

                -- Removing Player from LeftGuild History (Yes, they will be re-added upon leaving the guild.)
                GRM_PlayersThatLeftHistory_Save[GRM_G.guildName][member.name] = nil;
                local returningPlayer = GRM.GetPlayer(member.name);

                -- It must be done AFTER the record has been added
                -- Promotion Info
                if not returningPlayer.isTransfer and not liveJoinDetected then
                    if member.rankIndex < (GuildControlGetNumRanks() - 1) then
                        -- Promotion Obtained since joining!
                        local epochTime = time();
                        local nameOfBaseRank = GuildControlGetRankName(GuildControlGetNumRanks());
                        local added, logEntryMetaData = Scan.GetGuildEventString(2, member.name, nameOfBaseRank,
                            member.rankName);
                        local dates = {};

                        -- I don't want to have an instance where I have the promotion date in the log but the join date is too old os it has fallen off,
                        -- Thus, if the exact join date cannot be determined, it will set the promotion date to be no different.
                        if useTimeStamp then

                            -- Ok data is saved! Now let's report it to the log...
                            if added then
                                dates = logEntryMetaData[6][3];
                            else
                                dates = GRM.Time.GetTimestamp();
                                logEntryMetaData = {logEntryMetaData[1], nil, simpleName, nameOfBaseRank,
                                                    member.rankName, {dates}}; -- Mostly redundant - only need true/false statement in index 1
                            end
                        end

                        returningPlayer.rankName = member.rankName; -- Saving new rank Info
                        returningPlayer.rankIndex = member.rankIndex; -- Saving new rank Index Info

                        local isVerified = false;
                        local verifiedEpoch = 0;

                        if added then
                            isVerified = true;
                            verifiedEpoch = epochTime;
                        end

                        if not returningPlayer.rankHist[1][7] then

                            returningPlayer.rankHist[1][1] = returningPlayer.rankName;
                            returningPlayer.rankHist[1][2] = dates[1];
                            returningPlayer.rankHist[1][3] = dates[2];
                            returningPlayer.rankHist[1][4] = dates[3];
                            returningPlayer.rankHist[1][5] =
                                GRM.Time.ConvertToStandardFormatDate(dates[1], dates[2], dates[3]);

                            -- verified or not
                            returningPlayer.rankHist[1][6] = verifiedEpoch
                            returningPlayer.rankHist[1][7] = isVerified;
                            returningPlayer.rankHist[1][8] = 1;

                        else
                            table.insert(returningPlayer.rankHist, 1,
                                {returningPlayer.rankName, dates[1], dates[2], dates[3],
                                 GRM.Time.ConvertToStandardFormatDate(dates[1], dates[2], dates[3]), verifiedEpoch,
                                 isVerified, 1});
                        end

                        returningPlayer.promoteDateUnknown = false;

                        -- Ok data is saved! Now let's report it to the log...
                        if added then
                            GRM.Log.AddPromotionDateTempLogEntry(logEntryMetaData[1], logEntryMetaData[2],
                                logEntryMetaData[3], logEntryMetaData[4], logEntryMetaData[5], logEntryMetaData[6][3]);
                        else
                            GRM.Log.AddPromotionDateTempLogEntry(logEntryMetaData[1], nil, simpleName, nameOfBaseRank,
                                member.rankName, GRM.Time.GetTimestamp());
                        end
                    elseif returningPlayer.rankHist[1] and returningPlayer.rankHist[1][2] ~= 0 then
                        returningPlayer.rankHist[1][7] = true;
                    end
                end
                break
            end
        end
    end

    -- Set the level if not joining.
    if not tempJoinStorage[5] then
        tempJoinStorage[6] = member.level;
    end

    return tempJoinStorage[5], member, simpleName, date_table, tempJoinStorage
end

-- Method:          Scan.CheckPlayerEvents ( bool )
-- What it Does:    Scans through all players'' "events" of the given guild and updates if any are pending
-- Purpose:         Event Management for Anniversaries, Birthdays, and Custom Events
Scan.CheckPlayerEvents = function( rescanning )

    if not GRMsyncGlobals.currentlySyncing and ( not GRM_G.ReScanningEvents or rescanning ) then

        -- including anniversary, birthday , and custom
        local month, day, year = select(2, GRM.Time.GetTodaysDate());

        -- Quickly cleanup the list if necessary
        GRM.CleanupEventsFromplayers();
        local guildData = GRM.GetGuild();
        local cleanupHappened = false;
        local count = 0;

        if guildData then
            for _, player in pairs(guildData) do
                if type(player) == "table" then

                    cleanupHappened , count = Scan.CheckPlayerAnniversary ( player , day , month, year , count );

                    cleanupHappened , count = Scan.CheckPlayerBirthday ( player , day , month , year , cleanupHappened , count );

                    playerSlimName = GRM.SlimName(player.name);
                    if count == 10 then
                        break;
                    end
                end
            end

            if cleanupHappened then
                GRM_UI.RefreshSelectFrames(false, false, false, false, false, true);
            end

            if count == 10 then
                GRM_G.ReScanningEvents = true;
                C_Timer.After ( 5 , function()
                    Scan.CheckPlayerEvents ( true );
                    return;
                end);
            end

        end

        GRM_G.ReScanningEvents = false;
    end
end

-- Method:          Scan.CheckPlayerAnniversary ( playerTable , int , int , int , int )
-- What it Does:    Checks the player if their anniversary is coming up
-- Purpose:         To inform the player when someone's anniversary is up
Scan.CheckPlayerAnniversary = function( player , day , month , year , count )
    local cleanupHappened = false;

    if GRM.S().annivAnnounce then

        if player.joinDateHist[1][6] then   -- No need to move on and check anniversary for unverified dates.
            if not player.anniversaryAnnounced then
                local description = "";
                local title = "";
                local eventDay = player.joinDateHist[1][1];
                local eventMonthIndex = player.joinDateHist[1][2];
                local eventYear = player.joinDateHist[1][3];
                local daysTil = GRM.Time.GetDaysBetweenDates({day, month, year},{eventDay, eventMonthIndex, eventYear});
                local count = 0;

                -- Not reported AND there is a day recorded...
                if eventDay ~= 0 and (not GRM.S().onlyAnnounceForMain or GRM.IsMain(player.name) ) then


                    -- Now, let's check if it needs to be reported!
                    if GRM.S().calendarAnnouncements and daysTil <= GRM.S().eventAdvanceDays then

                        -- YES! It needs reporting! It is within the threshold!
                        -- Configure some of the dates
                        local numYears = year - eventYear;
                        if month == 12 and eventMonthIndex == 1 then
                            numYears = numYears + 1;
                        end

                        local isLeapYear = GRM.Time.IsLeapYear(eventYear);

                        if (eventDay == 29 and eventMonthIndex == 2) and not isLeapYear then -- If anniversary happened on leap year date, and the current year is NOT a leap year, then put it on 1 Mar.
                            eventDay = 1;
                            eventMonthIndex = 3;
                        end

                        -- Join Date Anniversary -- Let's see if player has it set to ONLY announce anniversary event on Calendar for a player's "main"
                        if numYears ~= 0 then

                            title = GRM.L("{name}'s Anniversary!", GRM.FormatName(player.name));
                            description = GRM.GetAnniversaryLogReport(player.name, player.class, numYears)
                            GRM.Log.AddEventEntry (1, player.name, player.class, eventDay, eventMonthIndex,
                                isLeapYear, GRM.Time.GetTimestamp(), numYears);

                        end

                        -- Now, let's add it to the calendar!!!
                        if description ~= "" then
                            local finalYear = year;
                            if month == 12 and eventMonthIndex == 1 then
                                finalYear = finalYear + 1;
                            end

                            if (GRM_G.BuildVersion < 30000 or ( GRM_G.BuildVersion >= 30000 and not GRM.IsCalendarEventAlreadyAdded(player.name, title, eventDay, eventMonthIndex, finalYear, r ) ) ) and not GRM.IsOnAnnouncementList(player.name, 1, title) then


                                GRM.InsertNewEvent (player.name, title, eventDay, eventMonthIndex, finalYear,
                                    description, 1);

                                cleanupHappened = true;
                                count = count + 1;

                            end
                        end
                        -- This has been reported, save it!
                        player.anniversaryAnnounced = true;
                    end

                    -- Resetting the event report to false if parameters meet
                elseif player.anniversaryAnnounced then -- It is still true! Event has been reported! Let's check if time has passed sufficient to wipe it to false

                    if (daysTil > GRM.S().eventAdvanceDays) or (GRM.S().onlyAnnounceForMain and not GRM.IsMain(player.name)) then -- Event is behind us now
                        player.anniversaryAnnounced = false;
                        GRM.ResetPlayerEvent(player.name, 1, title);
                        cleanupHappened = true;

                    end
                end
            end
        elseif player.anniversaryAnnounced then
            player.anniversaryAnnounced = false;
        end

    elseif player.anniversaryAnnounced then
        player.anniversaryAnnounced = false;
        GRM.ResetPlayerEvent(player.name, 1, "");
        cleanupHappened = true;
    end
    return cleanupHappened , count;
end

-- Method:          Scan.CheckPlayerBirthday ( playerTable , int , int , int , bool , int )
-- What it Does:    Checks if the birthday of a player is up and coming
-- Purpose:         Reporting to log and to event calendar.
Scan.CheckPlayerBirthday = function ( player , day , month , year , cleanupHappened , count )
    if cleanupHappened == nil then
        cleanupHappened = false;
    end

    local birthdayInfo = GRM.GetBirthday(player);

    if GRM.S().bdayAnnounce then

        if birthdayInfo.date[1] > 0 then   -- No need to move on and check anniversary for unverified dates.
            if not birthdayInfo.announced then
                local description = "";
                local title = "";
                local eventDay = birthdayInfo.date[1];
                local eventMonthIndex = birthdayInfo.date[2];
                local eventYear = year;

                local daysTil = GRM.Time.GetDaysBetweenDates({day, month, year},{eventDay, eventMonthIndex, eventYear});
                local count = 0;

                -- Not reported AND there is a day recorded...
                if eventDay ~= 0 and (not GRM.S().onlyAnnounceForMain or GRM.IsMain(player.name) ) then

                    -- Now, let's check if it needs to be reported!
                    if GRM.S().calendarAnnouncements and daysTil <= GRM.S().eventAdvanceDays then

                        -- YES! It needs reporting! It is within the threshold!

                        local isLeapYear = GRM.Time.IsLeapYear(eventYear);

                        if (eventDay == 29 and eventMonthIndex == 2) and not isLeapYear then -- If birthday happened on leap year date, and the current year is NOT a leap year, then put it on 1 Mar.
                            eventDay = 1;
                            eventMonthIndex = 3;
                        end

                        title = GRM.L("{name}'s Birthday!", GRM.FormatName(player.name));
                        description = GRM.GetBirthdayLogReport(player.name, player.class)
                        GRM.Log.AddEventEntry(2, player.name, player.class, eventDay, eventMonthIndex,
                            isLeapYear, GRM.Time.GetTimestamp());

                        -- Now, let's add it to the calendar!!!
                        if description ~= "" then
                            local finalYear = year;
                            if month == 12 and eventMonthIndex == 1 then
                                finalYear = finalYear + 1;
                            end

                            if (GRM_G.BuildVersion < 30000 or ( GRM_G.BuildVersion >= 30000 and not GRM.IsCalendarEventAlreadyAdded(player.name, title, eventDay, eventMonthIndex, finalYear, 2 ) ) ) and not GRM.IsOnAnnouncementList(player.name, 2 , title) then


                                GRM.InsertNewEvent (player.name, title, eventDay, eventMonthIndex, finalYear,
                                    description, 2);

                                cleanupHappened = true;
                                count = count + 1;

                            end
                        end
                        -- This has been reported, save it!
                        birthdayInfo.announced = true;
                    end

                    -- Resetting the event report to false if parameters meet
                elseif birthdayInfo.announced then -- It is still true! Event has been reported! Let's check if time has passed sufficient to wipe it to false

                    if (daysTil > GRM.S().eventAdvanceDays) or (GRM.S().onlyAnnounceForMain and not GRM.IsMain(player.name)) then -- Event is behind us now
                        birthdayInfo.announced = false;
                        GRM.ResetPlayerEvent(player.name, 2, title);
                        cleanupHappened = true;

                    end
                end
            end
        elseif birthdayInfo.announced then
            birthdayInfo.announced = false;
        end

    elseif birthdayInfo.announced then
        birthdayInfo.announced = false;
        GRM.ResetPlayerEvent(player.name, 2, "");
        cleanupHappened = true;
    end

    return cleanupHappened , count;
end

-- Method:          Scan.FinalReport()
-- What it Does:    Organizes flow of final report and send it to chat frame and to the logReport.
-- Purpose:         Clean organization for presentation.
Scan.FinalReport = function()
    if Scan.ScanKillSwitch() then -- Necessary in case you purge guild in middle of scan
        return;
    end

    -- For extra tracking info to display if the left player is on the server anymore...
    if #GRM_G.TempLeftGuild > 0 then
        -- need to build the names of those leaving for insert...

        local names = {};
        for i = 1, #GRM_G.leavingPlayers do
            table.insert(names, {GRM_G.leavingPlayers[i].name, GRM_G.leavingPlayers[i].GUID}); -- Name and GUID
        end
        -- Establishing the players that left but are still on the server
        GRM.SetPlayersGUIDStillValid(names);
    end

    Scan.FullReportCheck();

    -- Let's go through the Left Players.
    if #GRM_G.TempLeftGuild > 0 then
        C_Timer.After(0.5, function()
            Scan.FinalLeftPlayersReport();
        end);
    else
        C_Timer.After(0.1, function()
            local needToReport = ( time() - GRM_UI.GRM_ToolCoreFrame.HKProcessed ) > 5;
            Scan.FinalReportInformation(needToReport);
        end);
    end

end

-- Method:          Scan.FinalLeftPlayersReport()
-- What it Does:    Adds reporting extra info to end of the log string
-- Purpose:         Compartmentalize the log reporting code to be cleaner.
Scan.FinalLeftPlayersReport = function()

    if Scan.ScanKillSwitch() then -- Necessary in case you purge guild in middle of scan
        return;
    end

    if GRM_G.OnFirstLoad then
        GRM_G.ChangesFoundOnLoad = true;
    end
    -- Let's compare our left players now...
    local isMatched = false;
    for i = 1, #GRM_G.leavingPlayers do
        isMatched = false;
        for j = 1, #GRM_G.playersStillOnServer do
            if GRM_G.leavingPlayers[i].name == GRM_G.playersStillOnServer[j] then
                isMatched = true;
                -- now let's match it to propper tempLeft table
                break
            end
        end

        local timePassed = GRM.Time.GetTimePlayerHasBeenMember(GRM_G.leavingPlayers[i].name);
        if timePassed ~= "" then
            timePassed = ("|cFFFFFFFF" .. GRM.L("Time as Member:") .. " " .. timePassed .. "|r");
        end
        -- if not isMatched then (player not on friends list... this means that the player has left the server or namechanged)
        if not isMatched then

            for m = 1, #GRM_G.TempLeftGuild do
                if string.find(GRM_G.TempLeftGuild[m][2], GRM.L("Player no longer on Server")) == nil and
                    (string.find(GRM_G.TempLeftGuild[m][2], GRM.L("has Left the guild")) ~= nil or
                        string.find(GRM_G.TempLeftGuild[m][2], GRM.L("is no longer in the Guild!")) ~= nil) and
                    string.find(GRM_G.TempLeftGuild[m][2], GRM.SlimName(GRM_G.leavingPlayers[i].name)) ~= nil then
                    if string.find(GRM_G.TempLeftGuild[m][2], GRM.L("ALTS IN GUILD:")) ~= nil then
                        local index2 = select(2, string.find(GRM_G.TempLeftGuild[m][2], "\n"));
                        if timePassed ~= "" then
                            GRM_G.TempLeftGuild[m][2] = string.sub(GRM_G.TempLeftGuild[m][2], 1, index2 - 1) ..
                                                            " |CFFFF0000(" .. GRM.L("Player no longer on Server") ..
                                                            ")|CFF808080" ..
                                                            string.sub(GRM_G.TempLeftGuild[m][2], index2) .. "\n" ..
                                                            timePassed;
                        else
                            GRM_G.TempLeftGuild[m][2] = string.sub(GRM_G.TempLeftGuild[m][2], 1, index2 - 1) ..
                                                            " |CFFFF0000(" .. GRM.L("Player no longer on Server") ..
                                                            ")|CFF808080" ..
                                                            string.sub(GRM_G.TempLeftGuild[m][2], index2);
                        end
                    else
                        if timePassed ~= "" then
                            GRM_G.TempLeftGuild[m][2] = GRM_G.TempLeftGuild[m][2] .. " |CFFFF0000(" ..
                                                            GRM.L("Player no longer on Server") .. ")\n" .. timePassed;
                        else
                            GRM_G.TempLeftGuild[m][2] = GRM_G.TempLeftGuild[m][2] .. " |CFFFF0000(" ..
                                                            GRM.L("Player no longer on Server") .. ")";
                        end
                    end
                    GRM_G.TempLeftGuild[m][12] = true;
                    break
                end
            end
        else
            -- Player is still on the server, just no longer in the guild
            for m = 1, #GRM_G.TempLeftGuild do
                if string.find(GRM_G.TempLeftGuild[m][2], GRM.L("has Left the guild")) ~= nil and
                    string.find(GRM_G.TempLeftGuild[m][2], GRM.SlimName(GRM_G.leavingPlayers[i].name)) ~= nil then
                    if timePassed ~= "" then
                        GRM_G.TempLeftGuild[m][2] = GRM_G.TempLeftGuild[m][2] .. " (" .. timePassed .. ")";
                    else
                        GRM_G.TempLeftGuild[m][2] = GRM_G.TempLeftGuild[m][2];
                    end
                    break
                end
            end

            for m = 1, #GRM_G.TempLeftGuild do
                if string.find(GRM_G.TempLeftGuild[m][2], GRM.L("kicked")) ~= nil and
                    string.find(GRM_G.TempLeftGuild[m][2], GRM.SlimName(GRM_G.leavingPlayers[i].name)) ~= nil then
                    if timePassed ~= "" then
                        GRM_G.TempLeftGuild[m][2] = GRM_G.TempLeftGuild[m][2] .. " (" .. timePassed .. ")";
                    else
                        GRM_G.TempLeftGuild[m][2] = GRM_G.TempLeftGuild[m][2];
                    end
                    break
                end
            end
        end

    end

    -- sending to log
    for i = 1, #GRM_G.TempLeftGuild do
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        GRM.Log.AddLog(GRM_G.TempLeftGuild[i]);
    end

    C_Timer.After(0, function()
        Scan.FinalReportInformation(true);
    end);
end

-- Method:          Scan.FinalReportInformation( bool )
-- What it Does:    Cleans up the scan from all the remaining info and reports
-- Purpose:         Compartmentalize the wrap up part of the scan
Scan.FinalReportInformation = function(needToReport)

    -- Clear the changes.
    Scan.ResetTempLogs();

    if GRM_G.OnFirstLoad then
        local S = (type(GRM.S) == "function") and GRM.S() or GRM.S
        if S and S.viewOnLoad then
            if (not S.onlyViewIfChanges) or GRM_G.ChangesFoundOnLoad then
                if GRM_UI and GRM_UI.GRM_RosterChangeLogFrame then
                    GRM_UI.GRM_RosterChangeLogFrame:Show()
                end
            end
        end

    Scan.AnnounceIfBirthday()
    Scan.CheckForDeadAccounts(false)
    GRM.Util.WarnTableSize()
    GRM.Prof.AutoStartProfessionUpdate()
end


    GRM_UI.RefreshSelectFrames(needToReport, true, false, false, true, (#GRM_G.TempEventReport > 0));

    if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
        GRM.PopulateMemberDetails(GRM_G.currentName);
    end

    -- Report on the live changes collected while this scan was occurring.
    if #GRM.LiveScanQue > 0 then
        GRM.ProcessLiveScanQue();
    end

    GRM_G.OnFirstLoad = false;
    GRM_G.numRanksHasChanged = false;
    GRM_G.rankChangeShift = 0;
    GRM_G.CurrentlyScanning = false;
    GRM_G.changeHappenedExitScan = false;
    if GRM_G.silenceOfficerNoteReporting and (time() - GRM_G.silenceOfficerTimer >= 10) then -- On a live rank change the first check the notes will not be updated. it can take as long as 10 seconds for server to refresh...
        GRM_G.silenceOfficerNoteReporting = false;
    end
end

-- Method:          Scan.AnnounceIfBirthday ( string )
-- What it Does:    Announces to chat that it is the player's bday when they login or when first logging on.
-- Purpose:         So you will have the knowledge to say happy birthday when someone logs in!
Scan.AnnounceIfBirthday = function(msg)
    if not GRM.S().AnnounceBdayOnLogin then
        return;
    end

    local names = {}
    local player;

    if msg then
        names = {GRM.AppendServerName(select(3, msg:find("|Hplayer:([^:]*)(.-)|h%[.-%]|h")))}; -- Parses name out, then formats it to show server for DB reasons.
    else
        names = GRM.G_Util.GetListOfOnlinePlayers();
    end

    if GRM.GetGuild() then
        local month, day = select(2, GRM.Time.GetTodaysDate());
        local color = GRM.S().logColor[11];

        for i = 1, #names do
            -- Is Player in the guild?
            if not GRM_DailyAnnounce[names[i]] then
                player = GRM.GetPlayer(names[i]);
                if player then
                    -- First, check if bday even configured
                    local birthdayInfo = GRM.GetBirthday( player );
                    if birthdayInfo then
                        -- Birthday is set, now we compare!
                        if birthdayInfo.date[1] == day and birthdayInfo.date[2] == month then

                            -- Only announce if necessary
                            if not GRM_DailyAnnounce[player.name] then
                                GRM_DailyAnnounce[player.name] = true;

                                GRM.Report(GRM.L("It's {name}'s Birthday today!!!",
                                    GRM.GetClassifiedName(names[i], true)), color[1], color[2], color[3]);
                            end

                        end
                    end
                end
            end
        end
    end
end

-- Method:          Scan.CheckForDeadAccounts( bool )
-- What it Does:    Scans the roster for dead account names and then gives you the option to kick them
-- Purpose:         Quality of life feature for maintenance reasons of a roster.
Scan.CheckForDeadAccounts = function(isManual)

    -- if not CanGuildRemove() then
    --     return;
    -- end

    local customKickList = {};
    local hours = 4320; -- Equals 180 days - presumably someone with account deleted. This is just a buffer because sometimes names get flagged for rename for TOS violation but are still active.
    local ind = 0;

    for _, player in pairs(GRM.GetGuild()) do
        if type(player) == "table" then
            if (not player.deadNameIgnore or isManual) and player.lastOnline >= hours and
                string.match(GRM.SlimName(player.name), "%d") ~= nil then -- Needs to just be first name because servers may have numbers in them, like Area52, but the player name cannot.

                table.insert(customKickList, {player.name});
                ind = #customKickList;
                customKickList[ind].name = player.name;
                customKickList[ind].class = GRM.GetClassColorRGB(player.class);
                customKickList[ind].lastOnline = player.lastOnline;
                customKickList[ind].action = GRM.L("Kick");
                customKickList[ind].macro = "/gremove";
                customKickList[ind].isHighlighted = false;
                customKickList[ind].mainName = GRM.GetFormattedMainName(player, true);
                customKickList[ind].customMsg = GRM.L("Dead Account");
                customKickList[ind].isMain = false;
                customKickList[ind].isAlt = false;
                customKickList[ind].tab = false;

            end
        end
    end

    if #customKickList > 0 then

        sort(customKickList, function(a, b)
            return a[1] < b[1]
        end);

        local kickDeadNames = function()
            if not GRM_UI.GRM_ToolCoreFrame or (GRM_UI.GRM_ToolCoreFrame and not GRM_UI.GRM_ToolCoreFrame:IsVisible()) then
                GRM_G.RosterRightClickControl = true;
                GRM_UI.GRM_ToolCoreFrame:Show();
            end

            GRM_R.ConfigureMacroForRightClick( 1 , customKickList);
        end

        local ignoreDeadNames = function()

            local player;
            for i = 1, #customKickList do
                player = GRM.GetPlayer(customKickList[i].name);
                if player then
                    player.deadNameIgnore = true;
                end
            end

            GRM.Report(GRM.L("You can re-check in the future by typing '/grm dead'"));
        end

        local numDeadMsg = "";
        if #customKickList > 1 then
            numDeadMsg = GRM.L("There are {num} players in your guild on dead accounts.", nil, nil,
                #customKickList) .. " " .. GRM.L("Would you like to remove them?");
        else
            numDeadMsg = GRM.L("There is 1 player in your guild on a dead account.") .. " " ..
                             GRM.L("Would you like to remove them?");
        end

        GRM.SetConfirmationWindow( kickDeadNames, numDeadMsg .. "\n\n" .. GRM.L(
            "Click CONFIRM to review the names, IGNORE to remove this pop-up permanently, or CANCEL to be reminded next session."),
            ignoreDeadNames, {320, 200})
    end
    return customKickList;
end

-- Method:          Scan.FullReportCheck()
-- What it Does:    Reports to the chat and log the changes
-- Purpose:         By keeping this in a separate function it can be used in the final report, and be forced in a forced kill of the scan if necessary.
Scan.FullReportCheck = function()
    -- Cleanup the notes for reporting
    -- Join Dates Cleaned up First
    if #GRM_G.TempNewMember > 0 then
        local tempTable = {};
        for i = 1, #GRM_G.TempNewMember do
            if string.find(GRM_G.TempNewMember[i][2], GRM.L("Invited By:")) ~= nil then
                table.insert(tempTable, 1, GRM_G.TempNewMember[i]);
            else
                table.insert(tempTable, GRM_G.TempNewMember[i]);
            end
        end
        GRM_G.TempNewMember = tempTable;
    end

    -- No need to spam the chat window when logging in.
    if not GRM_G.OnFirstLoad then

        if #GRM_G.TempBannedRejoin > 0 and GRM.S().toChat.joined then

            for i = 1, #GRM_G.TempBannedRejoin do
                GRM.PrintLog(GRM_G.TempBannedRejoin[i]);
            end
        end

        if #GRM_G.TempNameChanged > 0 and GRM.S().toChat.nameChange then

            for i = 1, #GRM_G.TempNameChanged do
                GRM.PrintLog(GRM_G.TempNameChanged[i]);
            end
        end

        if #GRM_G.TempLogPromotion > 0 and GRM.S().toChat.promotion then

            for i = 1, #GRM_G.TempLogPromotion do
                GRM.PrintLog(GRM_G.TempLogPromotion[i]);
            end
        end

        if #GRM_G.TempLogDemotion > 0 and GRM.S().toChat.demotion then

            for i = 1, #GRM_G.TempLogDemotion do
                GRM.PrintLog(GRM_G.TempLogDemotion[i]);
            end
        end

        if #GRM_G.TempRejoin > 0 and GRM.S().toChat.joined then

            for i = 1, #GRM_G.TempRejoin do
                GRM.PrintLog(GRM_G.TempRejoin[i]); -- Same Comments on down
            end
        end

        if #GRM_G.TempNewMember > 0 and GRM.S().toChat.joined then

            for i = 1, #GRM_G.TempNewMember do
                GRM.PrintLog(GRM_G.TempNewMember[i]); -- Send to print to chat window
            end
        end

        if #GRM_G.TempInactiveReturnedLog > 0 and GRM.S().toChat.inactiveReturn then

            for i = 1, #GRM_G.TempInactiveReturnedLog do
                GRM.PrintLog(GRM_G.TempInactiveReturnedLog[i]);
            end
        end

        if #GRM_G.TempRankRename > 0 and GRM.S().toChat.rankRename then

            for i = 1, #GRM_G.TempRankRename do
                GRM.PrintLog(GRM_G.TempRankRename[i]);
            end
        end
        if #GRM_G.TempLogLeveled > 0 and GRM.S().toChat.leveled then
            for i = 1, #GRM_G.TempLogLeveled do
                GRM.PrintLog(GRM_G.TempLogLeveled[i]);
            end
        end

        if #GRM_G.TempLogNote > 0 and GRM.S().toChat.note then

            for i = 1, #GRM_G.TempLogNote do
                GRM.PrintLog(GRM_G.TempLogNote[i]);
            end
        end

        if not GRM_G.silenceOfficerNoteReporting and #GRM_G.TempLogONote > 0 and GRM.S().toChat.officerNote then

            for i = 1, #GRM_G.TempLogONote do
                GRM.PrintLog(GRM_G.TempLogONote[i]);
            end
        end

        if #GRM_G.TempEventReport > 0 and GRM.S().toChat.eventAnnounce then

            for i = 1, #GRM_G.TempEventReport do
                GRM.PrintLog(GRM_G.TempEventReport[i]);
            end
        end

        if #GRM_G.TempEventRecommendKickReport > 0 and GRM.S().toChat.recommend and ( not GRM_UI.GRM_ToolCoreFrame:IsVisible() or (GRM_UI.GRM_ToolCoreFrame:IsVisible() and not GRM.S().disableMacroToolLogSpam ) ) then

            for i = 1, #GRM_G.TempEventRecommendKickReport do
                GRM.PrintLog(GRM_G.TempEventRecommendKickReport[i]);
            end
        end

        if #GRM_G.TempEventRecommendPromotionReport > 0 and GRM.S().toChat.recommend and ( not GRM_UI.GRM_ToolCoreFrame:IsVisible() or (GRM_UI.GRM_ToolCoreFrame:IsVisible() and not GRM.S().disableMacroToolLogSpam ) ) then

            for i = 1, #GRM_G.TempEventRecommendPromotionReport do
                GRM.PrintLog(GRM_G.TempEventRecommendPromotionReport[i]);
            end
        end

        if #GRM_G.TempEventRecommendDemotionReport > 0 and GRM.S().toChat.recommend and ( not GRM_UI.GRM_ToolCoreFrame:IsVisible() or (GRM_UI.GRM_ToolCoreFrame:IsVisible() and not GRM.S().disableMacroToolLogSpam ) ) then

            for i = 1, #GRM_G.TempEventRecommendDemotionReport do
                GRM.PrintLog(GRM_G.TempEventRecommendDemotionReport[i]);
            end
        end

        if #GRM_G.TempEventRecommendSpecialReport > 0 and GRM.S().toChat.recommend and ( not GRM_UI.GRM_ToolCoreFrame:IsVisible() or (GRM_UI.GRM_ToolCoreFrame:IsVisible() and not GRM.S().disableMacroToolLogSpam ) ) then

            for i = 1, #GRM_G.TempEventRecommendSpecialReport do
                GRM.PrintLog(GRM_G.TempEventRecommendSpecialReport[i]);
            end
        end

        if #GRM_G.TempDeathReport > 0 and GRM.S().toChat.death then

            for i = 1, #GRM_G.TempDeathReport do
                GRM.PrintLog(GRM_G.TempDeathReport[i]);
            end
        end
    end

    -- OK, NOW LET'S REPORT TO LOG FRAME IN REVERSE ORDER!!!

    if #GRM_G.TempEventRecommendKickReport > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempEventRecommendKickReport do
            GRM.Log.AddLog(GRM_G.TempEventRecommendKickReport[i]);
        end
    end

    if #GRM_G.TempEventRecommendPromotionReport > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempEventRecommendPromotionReport do
            GRM.Log.AddLog(GRM_G.TempEventRecommendPromotionReport[i]);
        end
    end

    if #GRM_G.TempEventRecommendDemotionReport > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempEventRecommendDemotionReport do
            GRM.Log.AddLog(GRM_G.TempEventRecommendDemotionReport[i]);
        end
    end

    if #GRM_G.TempEventRecommendSpecialReport > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempEventRecommendSpecialReport do
            GRM.Log.AddLog(GRM_G.TempEventRecommendSpecialReport[i]);
        end
    end

    if #GRM_G.TempEventReport > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempEventReport do
            GRM.Log.AddLog(GRM_G.TempEventReport[i]);
        end
    end

    if not GRM_G.silenceOfficerNoteReporting and #GRM_G.TempLogONote > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempLogONote do
            GRM.Log.AddLog(GRM_G.TempLogONote[i]);
        end
    end

    if #GRM_G.TempLogNote > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempLogNote do
            GRM.Log.AddLog(GRM_G.TempLogNote[i]);
        end
    end

    if #GRM_G.TempLogLeveled > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempLogLeveled do
            GRM.Log.AddLog(GRM_G.TempLogLeveled[i]);
        end
    end

    if #GRM_G.TempRankRename > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempRankRename do
            GRM.Log.AddLog(GRM_G.TempRankRename[i]);
        end
    end

    if #GRM_G.TempRejoin > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempRejoin do
            GRM.Log.AddLog(GRM_G.TempRejoin[i]);
        end
    end

    if #GRM_G.TempNewMember > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempNewMember do
            GRM.Log.AddLog(GRM_G.TempNewMember[i]); -- Adding to the Log of Events
        end
    end

    if #GRM_G.TempLogDemotion > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempLogDemotion do
            GRM.Log.AddLog(GRM_G.TempLogDemotion[i]);
        end
    end

    if #GRM_G.TempLogPromotion > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempLogPromotion do
            GRM.Log.AddLog(GRM_G.TempLogPromotion[i]);
        end
    end

    if #GRM_G.TempNameChanged > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempNameChanged do
            GRM.Log.AddLog(GRM_G.TempNameChanged[i]);
        end
    end

    if #GRM_G.TempInactiveReturnedLog > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempInactiveReturnedLog do
            GRM.Log.AddLog(GRM_G.TempInactiveReturnedLog[i]);
        end
    end

    if #GRM_G.TempBannedRejoin > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempBannedRejoin do
            GRM.Log.AddLog(GRM_G.TempBannedRejoin[i]);
        end
    end

    if #GRM_G.TempDeathReport > 0 then
        needToReport = true;
        if GRM_G.OnFirstLoad then
            GRM_G.ChangesFoundOnLoad = true;
        end
        for i = 1, #GRM_G.TempDeathReport do
            GRM.Log.AddLog(GRM_G.TempDeathReport[i]);
        end
    end
end

-- Method:          Scan.ResetTempLogs()
-- What it Does:    Empties the arrays of the reporting logs
-- Purpose:         Logs are used to build changes in the guild and then to cleanly report them in order.
Scan.ResetTempLogs = function()
    GRM_G.TempNewMember = {};
    GRM_G.TempInactiveReturnedLog = {};
    GRM_G.TempLogPromotion = {};
    GRM_G.TempLogDemotion = {};
    GRM_G.TempLogLeveled = {};
    GRM_G.TempLogNote = {};
    GRM_G.TempLogONote = {};
    GRM_G.TempRankRename = {};
    GRM_G.TempRejoin = {};
    GRM_G.TempBannedRejoin = {};
    GRM_G.TempLeftGuild = {};
    GRM_G.TempLeftGuildPlaceholder = {};
    GRM_G.TempNameChanged = {};
    GRM_G.TempEventReport = {};
    GRM_G.TempEventRecommendKickReport = {};
    GRM_G.TempEventRecommendPromotionReport = {};
    GRM_G.TempEventRecommendDemotionReport = {};
    GRM_G.TempEventRecommendSpecialReport = {};
    GRM_G.TempDeathReport = {};
end

-- Method:          Scan.AnyReportsRemaining()
-- What it Does:    Returns true if there is any report that has not been given
-- Purpose:         Quick way to bypass a lot of code checks, as well as to know if a report needs to be re-checked if it was ended prematurely for some various reason. Basically, prevents lost reports in the event of killscan being activated
Scan.AnyReportsRemaining = function()
    local reportTables = {GRM_G.TempNewMember, GRM_G.TempInactiveReturnedLog, GRM_G.TempLogPromotion,
                          GRM_G.TempLogDemotion, GRM_G.TempLogLeveled, GRM_G.TempLogNote, GRM_G.TempLogONote,
                          GRM_G.TempRankRename, GRM_G.TempRejoin, GRM_G.TempBannedRejoin, GRM_G.TempLeftGuild,
                          GRM_G.TempLeftGuildPlaceholder, GRM_G.TempNameChanged, GRM_G.TempEventReport,
                          GRM_G.TempEventRecommendKickReport, GRM_G.TempEventRecommendPromotionReport,
                          GRM_G.TempEventRecommendDemotionReport, GRM_G.TempEventRecommendSpecialReport,
                          GRM_G.TempDeathReport};

    for i = 1, #reportTables do
        if #reportTables[i] > 0 then
            return true;
        end
    end
    return false;
end

--------------------
--- SCAN HELPERS ---
--------------------

-- Method:          Scan.ScanKillSwitch()
-- What it Does:    In case you quit a guild in the middle of a scan, this will purge it.
Scan.ScanKillSwitch = function()
    if GRM_G.changeHappenedExitScan or not IsInGuild() then
        -- Ensures any logged changes do get reported right away.
        if Scan.AnyReportsRemaining() then
            Scan.FullReportCheck();
            Scan.ResetTempLogs();
        end

        GRM_G.changeHappenedExitScan = false;
        GRM_G.silenceOfficerNoteReporting = false;
        GRM_G.CurrentlyScanning = false;
        GRM_G.OnFirstLoad = false;
        GRM_G.numRanksHasChanged = false;
        GRM_G.rankChangeShift = 0;
        return true;
    else
        return false;
    end
end

-- Method:          Scan.AddonPlayerRankChange ( index )
-- What it Does:    If the player's rank is changed, it does a re-check on permissions and sets up sync again.
-- purpose:         Need to update personal details immediately so sync can be processed.
Scan.AddonPlayerRankChange = function(newRankIndex)

    local needsUpdate = false;
    local needsToSync = false;
    if not GRM_G.playerRankID then
        GRM_G.playerRankID = GRM.G_Util.GetGuildMemberRankID ( GRM_G.addonUser );
    end

    if newRankIndex ~= GRM_G.playerRankID then
        needsUpdate = true;
    end

    if newRankIndex < GRM_G.playerRankID then
        needsToSync = true;
    end

    GRM_G.playerRankID = newRankIndex;
    GRM.RegisterMessage(); -- Update everyone else's settings

    if GRM_UI.GRM_RosterChangeLogFrame:IsVisible() then
        GRM_UI.BuildLogFrames();
    end

    -- Determine if player has access to guild chat or is in restricted chat rank - need to recheck with rank change.
    GRM_G.HasAccessToOfficerChat = false;
    GRM.Util.RegisterGuildChatPermission();

    if GRM_UI.GRM_ToolCoreFrame ~= nil and GRM_UI.GRM_ToolCoreFrame:IsVisible() then
        if needsUpdate then
            GRM.Report(GRM.L("GRM:") .. " " ..
                           GRM.L("Player rank change detected, re-checking permissions and rebuilding GRM Macro Tool."));
        end
        GRM_UI.RefreshManagementTool();
    end

    -- Let's do a resync check as well... If permissions have changed, we should resync check em.
    -- First, RESET all..
    if needsToSync and GRM.S().syncEnabled and not GRMsyncGlobals.currentlySyncing and GRM_G.HasAccessToGuildChat and
        not GRM_G.OnFirstLoad then
        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
            GRMsync.TriggerFullReset();
            GRM.Report(GRM.L("GRM:") .. " " .. GRM.L("Your rank has changed. Re-evaluating sync permissions."));
            C_Timer.After(3, GRMsync.Initialize); -- Now, let's add a brief delay, 3 seconds, to trigger sync again
        end
    end
end

-- Method:          Scan.GetNewerAccountByGUID ( string , string
-- What it Does:    Returns the GUID that is created more recently by comparing the values of the player
-- Purpose:         For double copies of players, it is easy to quickly determine which account is most current.
-- Notes:           GUID's by Blizz are numerical integer stamps converted to hexadecimals so easy to reverse engineer
Scan.GetNewerAccountByGUID = function ( guid1 , guid2 )
    if guid1 and guid2 and guid1 ~= guid2 then
        local guidPattern = "Player%-5099%-(%x+)";
        local match1 = string.match( guid1, guidPattern );
        local match2 = string.match( guid2, guidPattern );

        if match1 and match2 then
            -- Now, let's convert the hexadecimal to a number. Use the "tonumber" with base 16 for hex to int conversion
            local num1 = tonumber ( match1 , 16 );
            local num2 = tonumber ( match2 , 16 );

            if num1 > num2 then
                return guid1;
            else
                return guid2;
            end
        end
    end
    return;
end

-- Method:          Scan.GetRuleNameMatches ( table )
-- What it Does:    Returns an array of strings of the given player's matching ruels
-- Purpose:         Log reporting
Scan.GetRuleNameMatches = function(player)
    local result = {};

    for i = #player, 1, -1 do
        table.insert(result, player[i][1]);
    end

    return result;
end

-- === State variable for the scanning process ===
Scan.currentScanState = nil

-- === Main entry point for scanning recommendations ===
-- Method:          Scan.ScanRecommendationsList_Async( bool )
-- What it Does:    Scans through all of the macro rules for matches against the guild players
-- Purpose:         Efficient, Async similated behavior to break the process into chunks to ensure
--                  no stutter on the main thread.
Scan.ScanRecommendationsList_Async = function( scanCheck )
    if Scan.currentScanState and Scan.currentScanState.isRunning then
        return
    end

    GRM.RuleIntegrityCheck(); -- Validate rules before starting

    -- Hourly refresh check (original logic)
    if GRM_G.OnFirstLoad or ( (time() - GRM_G.HoursTilRecommendRefresh) > 3599 ) then
        GRM_G.HoursTilRecommendRefresh = time();
        Scan.RefreshNumberOfHoursTilRecommend();
    end

    -- Initialize the state for the chunked processing
    Scan.currentScanState = {
        isRunning = true,
        stage = "INIT_KICK", -- Starting stage
        chunkSize = 50,      -- Process 50 players/recommendations per C_Timer.After cycle

        allGuildPlayerNames = nil, -- Will hold result of GRM.G_Util.GetSortedPlayerNames()
        guildPlayerIndex = 1,     -- Index for iterating allGuildPlayerNames when FETCHING candidates

        -- Accumulated results from rule processing for each category
        kickRecommendationList = {},
        kickRuleDisabledList = {}, -- Players for whom kick rules are disabled

        promotionRecommendationList = {},
        promotionRuleDisabledList = {},

        demotionRecommendationList = {},
        demotionRuleDisabledList = {},

        specialRecommendationList = {},
        specialRuleDisabledList = {},

        -- For iterating through the accumulated recommendation lists or allGuildPlayerNames (for clearing flags)
        processingList = nil,      -- Points to one of the above
        processingIndex = 1,       -- Index for current chunk within processingList or allGuildPlayerNames
        currentRuleDisabledList = nil, -- Holds the ruleDisabledList for the category currently being cleared

        tempNamesForMarking = {}, -- Used to track names identified in the current recommendation category

        -- Counters for special recommendations summary log
        specialPromoteCountTotal = 0,
        specialDemoteCountTotal = 0,
        specialUnannouncedPromote = 0,
        specialUnannouncedDemote = 0,
    }

    -- Get all player names once at the beginning
    Scan.currentScanState.allGuildPlayerNames = GRM.G_Util.GetSortedPlayerNames()
    if #Scan.currentScanState.allGuildPlayerNames <= 1 then
        Scan.currentScanState.isRunning = false
        return
    end

    -- Start the first processing cycle
    C_Timer.After(0, function() Scan.ProcessNextMacroRuleChunk( scanCheck ) end)
end

-- === Core chunk processing function ===
-- Method:          Scan.ProcessNextMacroRuleChunk( bool )
-- What it Does:    Used to handle the asynchronous scanning of all of the macro rule matches
-- Purpose:         Since Lua is all run in the "main thread" and is not multi-threaded, this could cause
--                  stutter when processing a large amount of data, so instead it is better to process it
--                  all in smaller "chunks." This functions helps control the flow of that processing.
Scan.ProcessNextMacroRuleChunk = function( scanCheck )
    local state = Scan.currentScanState
    -- Exit if no active scan or state is lost
    if not state or not state.isRunning then return end

    local player -- Reusable variable for player object
    local ruleNames -- Reusable variable for rule names list

    -- Helper to safely get player object
    local function getPlayerSafe(name)
        return GRM.GetPlayer(name)
    end

    -- Helper to advance to the next major category (Kick -> Promote -> Demote -> Special -> Finish)
    local function advanceToNextMajorStage(nextMajorStage)
        state.guildPlayerIndex = 1          -- Reset for fetching candidates for the new category
        state.processingIndex = 1           -- Reset for processing the new list or clearing flags
        state.tempNamesForMarking = {}      -- Clear for the new category
        state.currentRuleDisabledList = nil -- Clear disabled list from previous category
        state.stage = nextMajorStage
        C_Timer.After(0, function()
            Scan.ProcessNextMacroRuleChunk ( scanCheck );
        end); -- Schedule next step
    end

    -- Helper to transition from fetching candidates to processing the accumulated list
    local function transitionToProcessingCandidates(recommendationList, ruleDisabledListForCategory, nextProcessingStage, nextClearingStageAfterProcessing)
        state.processingList = recommendationList
        state.currentRuleDisabledList = ruleDisabledListForCategory -- Store for use in the clearing stage
        state.processingIndex = 1
        state.tempNamesForMarking = {} -- Prepare for marking players in this category
        state.nextStageAfterProcessingCandidates = nextClearingStageAfterProcessing -- Remember where to go after this
        state.stage = nextProcessingStage
        C_Timer.After(0, function()
            Scan.ProcessNextMacroRuleChunk ( scanCheck );
        end);
    end

    -- Helper to transition from processing recommendations to clearing flags for that category
    local function transitionToClearingFlags()
        state.processingIndex = 1 -- Reset for iterating allGuildPlayerNames
        state.stage = state.nextStageAfterProcessingCandidates -- Move to the designated clearing stage
        C_Timer.After(0, function()
            Scan.ProcessNextMacroRuleChunk ( scanCheck );
        end);
    end

    ------------------------------------
    -- KICK RECOMMENDATIONS STAGES
    ------------------------------------
    if state.stage == "INIT_KICK" then
        if CanGuildRemove() and #state.allGuildPlayerNames > 0 then
            state.kickRecommendationList = {}
            state.kickRuleDisabledList = {}
            state.guildPlayerIndex = 1 -- Start fetching from the beginning of the guild list
            state.stage = "KICK_FETCH_CANDIDATES_CHUNK"
            -- Fall through to KICK_FETCH_CANDIDATES_CHUNK in the same cycle if desired, or schedule:
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            advanceToNextMajorStage("INIT_PROMOTION"); return
        end
    end

    if state.stage == "KICK_FETCH_CANDIDATES_CHUNK" then
        local chunkRecs, _, chunkDisabled = GRM.GetKickNamesByFilterRulesChunk(state.allGuildPlayerNames, state.guildPlayerIndex, state.chunkSize)

        if chunkRecs then -- Append new recommendations
            for _, rec in ipairs(chunkRecs) do table.insert(state.kickRecommendationList, rec) end
        end
        if chunkDisabled then -- Merge disabled lists
            for name, val in pairs(chunkDisabled) do state.kickRuleDisabledList[name] = val end
        end

        state.guildPlayerIndex = state.guildPlayerIndex + state.chunkSize -- Move to next chunk of guild members
        if state.guildPlayerIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
            Scan.ProcessNextMacroRuleChunk ( scanCheck );
                end);
            return -- More guild members to process for rules
        else
            -- All guild members processed for kick rules
            transitionToProcessingCandidates(state.kickRecommendationList, state.kickRuleDisabledList, "KICK_PROCESS_CANDIDATES_CHUNK", "KICK_CLEAR_FLAGS_CHUNK"); return
        end
    end

    if state.stage == "KICK_PROCESS_CANDIDATES_CHUNK" then
        -- Process a chunk of the accumulated kickRecommendationList
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.processingList) do
            local rec = state.processingList[i]
            state.tempNamesForMarking[rec.name] = true -- Mark this player as on the current kick list
            ruleNames = Scan.GetRuleNameMatchesChunk(rec) -- Get rule names for logging
            player = getPlayerSafe(rec.name)

            if player and not player.recommendToKick then
                player.recommendToKick = true
                GRM.Log.AddEventRecommendKickTempLogEntry(GRM.GetClassifiedName(rec.name, true), #rec, GRM.Time.GetTimestamp(), ruleNames)
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk

        if state.processingIndex <= #state.processingList then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return -- More recommendations to process
        else
            transitionToClearingFlags(); return
        end
    end

    if state.stage == "KICK_CLEAR_FLAGS_CHUNK" then
        -- Iterate through all guild members to clear flags if rule disabled or removed
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.allGuildPlayerNames) do
            local playerName = state.allGuildPlayerNames[i]
            player = getPlayerSafe(playerName)

            if player and player.recommendToKick and not state.tempNamesForMarking[player.name] then
                player.recommendToKick = false
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk

        if state.processingIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return -- More guild members to check for flag clearing
        else
            -- Finished clearing kick flags, move to next major category
            advanceToNextMajorStage("INIT_PROMOTION"); return
        end
    end

    ------------------------------------
    -- PROMOTION RECOMMENDATIONS STAGES (Structure mirrors KICK)
    ------------------------------------
    if state.stage == "INIT_PROMOTION" then
        if CanGuildPromote() and #state.allGuildPlayerNames > 0 then
            state.promotionRecommendationList = {}
            state.promotionRuleDisabledList = {}
            state.guildPlayerIndex = 1
            state.stage = "PROMOTION_FETCH_CANDIDATES_CHUNK"
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            advanceToNextMajorStage("INIT_DEMOTION"); return
        end
    end

    if state.stage == "PROMOTION_FETCH_CANDIDATES_CHUNK" then
        local chunkRecs, _, chunkDisabled = GRM.GetPromoteAndDemoteNamesByFilterRulesChunk(2, state.allGuildPlayerNames, state.guildPlayerIndex, state.chunkSize)
        if chunkRecs then for _, rec in ipairs(chunkRecs) do table.insert(state.promotionRecommendationList, rec) end end
        if chunkDisabled then for name, val in pairs(chunkDisabled) do state.promotionRuleDisabledList[name] = val end end

        state.guildPlayerIndex = state.guildPlayerIndex + state.chunkSize
        if state.guildPlayerIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            transitionToProcessingCandidates(state.promotionRecommendationList, state.promotionRuleDisabledList, "PROMOTION_PROCESS_CANDIDATES_CHUNK", "PROMOTION_CLEAR_FLAGS_CHUNK"); return
        end
    end

    if state.stage == "PROMOTION_PROCESS_CANDIDATES_CHUNK" then
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.processingList) do
            local rec = state.processingList[i]
            state.tempNamesForMarking[rec.name] = true
            ruleNames = Scan.GetRuleNameMatchesChunk(rec)
            player = getPlayerSafe(rec.name)
            if player and not player.recommendToPromote then
                player.recommendToPromote = true
                GRM.Log.AddEventRecommendPromotionLogEntry(GRM.GetClassifiedName(rec.name, true), #rec, GRM.Time.GetTimestamp(), ruleNames)
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk
        if state.processingIndex <= #state.processingList then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            transitionToClearingFlags(); return
        end
    end

    if state.stage == "PROMOTION_CLEAR_FLAGS_CHUNK" then
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.allGuildPlayerNames) do
            local playerName = state.allGuildPlayerNames[i]
            player = getPlayerSafe(playerName)
            if player and player.recommendToPromote and not state.tempNamesForMarking[player.name] then
                player.recommendToPromote = false
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk
        if state.processingIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            advanceToNextMajorStage("INIT_DEMOTION"); return
        end
    end

    ------------------------------------
    -- DEMOTION RECOMMENDATIONS STAGES (Structure mirrors KICK/PROMOTION)
    ------------------------------------
    if state.stage == "INIT_DEMOTION" then
        if CanGuildDemote() and #state.allGuildPlayerNames > 0 then
            state.demotionRecommendationList = {}
            state.demotionRuleDisabledList = {}
            state.guildPlayerIndex = 1
            state.stage = "DEMOTION_FETCH_CANDIDATES_CHUNK"
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            advanceToNextMajorStage("INIT_SPECIAL"); return
        end
    end

    if state.stage == "DEMOTION_FETCH_CANDIDATES_CHUNK" then
        local chunkRecs, _, chunkDisabled = GRM.GetPromoteAndDemoteNamesByFilterRulesChunk(3, state.allGuildPlayerNames, state.guildPlayerIndex, state.chunkSize)
        if chunkRecs then for _, rec in ipairs(chunkRecs) do table.insert(state.demotionRecommendationList, rec) end end
        if chunkDisabled then for name, val in pairs(chunkDisabled) do state.demotionRuleDisabledList[name] = val end end

        state.guildPlayerIndex = state.guildPlayerIndex + state.chunkSize
        if state.guildPlayerIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            transitionToProcessingCandidates(state.demotionRecommendationList, state.demotionRuleDisabledList, "DEMOTION_PROCESS_CANDIDATES_CHUNK", "DEMOTION_CLEAR_FLAGS_CHUNK"); return
        end
    end

    if state.stage == "DEMOTION_PROCESS_CANDIDATES_CHUNK" then
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.processingList) do
            local rec = state.processingList[i]
            state.tempNamesForMarking[rec.name] = true
            ruleNames = Scan.GetRuleNameMatchesChunk(rec)
            player = getPlayerSafe(rec.name)
            if player and not player.recommendToDemote then
                player.recommendToDemote = true
                GRM.Log.AddEventRecommendDemotionLogEntry(GRM.GetClassifiedName(rec.name, true), #rec, GRM.Time.GetTimestamp(), ruleNames)
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk
        if state.processingIndex <= #state.processingList then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            transitionToClearingFlags(); return
        end
    end

    if state.stage == "DEMOTION_CLEAR_FLAGS_CHUNK" then
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.allGuildPlayerNames) do
            local playerName = state.allGuildPlayerNames[i]
            player = getPlayerSafe(playerName)
            if player and player.recommendToDemote and not state.tempNamesForMarking[player.name] then
                player.recommendToDemote = false
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk
        if state.processingIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            advanceToNextMajorStage("INIT_SPECIAL"); return
        end
    end

    ------------------------------------
    -- SPECIAL RECOMMENDATIONS STAGES (Slightly different processing logic)
    ------------------------------------
    if state.stage == "INIT_SPECIAL" then
        if CanGuildDemote() and CanGuildPromote() and #state.allGuildPlayerNames > 0 then
            state.specialRecommendationList = {}
            state.specialRuleDisabledList = {} -- If GRM_UI.GetNamesBySpecialRulesChunk returns it
            state.guildPlayerIndex = 1
            -- Reset counters for the summary log
            state.specialPromoteCountTotal = 0
            state.specialDemoteCountTotal = 0
            state.specialUnannouncedPromote = 0
            state.specialUnannouncedDemote = 0
            state.stage = "SPECIAL_FETCH_CANDIDATES_CHUNK"
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            advanceToNextMajorStage("FINISH"); return
        end
    end

    if state.stage == "SPECIAL_FETCH_CANDIDATES_CHUNK" then
        local chunkRecs, _, chunkDisabled = GRM_UI.GetNamesBySpecialRulesChunk(state.allGuildPlayerNames, state.guildPlayerIndex, state.chunkSize)
        if chunkRecs then for _, rec in ipairs(chunkRecs) do table.insert(state.specialRecommendationList, rec) end end
        if chunkDisabled then for name, val in pairs(chunkDisabled) do state.specialRuleDisabledList[name] = val end end

        state.guildPlayerIndex = state.guildPlayerIndex + state.chunkSize
        if state.guildPlayerIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            transitionToProcessingCandidates(state.specialRecommendationList, state.specialRuleDisabledList, "SPECIAL_PROCESS_CANDIDATES_CHUNK", "SPECIAL_CLEAR_FLAGS_CHUNK"); return
        end
    end

    if state.stage == "SPECIAL_PROCESS_CANDIDATES_CHUNK" then
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.processingList) do
            local rec = state.processingList[i] -- rec has .name and .action ("Promote" or "Demote")
            state.tempNamesForMarking[rec.name] = true
            player = getPlayerSafe(rec.name)
            if player then
                if rec.action == "Promote" then
                    if not player.recommendSpecial then
                        player.recommendSpecial = true
                        state.specialUnannouncedPromote = state.specialUnannouncedPromote + 1
                    end
                    state.specialPromoteCountTotal = state.specialPromoteCountTotal + 1
                elseif rec.action == "Demote" then
                    if not player.recommendSpecial then
                        player.recommendSpecial = true
                        state.specialUnannouncedDemote = state.specialUnannouncedDemote + 1
                    end
                    state.specialDemoteCountTotal = state.specialDemoteCountTotal + 1
                end
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk

        if state.processingIndex <= #state.processingList then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            -- Log summary after all special candidates are processed (original logic)
            if state.specialUnannouncedPromote > 0 or state.specialUnannouncedDemote > 0 then
                GRM.Log.AddEventRecommendSpecialLogEntry(state.specialPromoteCountTotal, state.specialDemoteCountTotal, GRM.Time.GetTimestamp())
            end
            transitionToClearingFlags(); return
        end
    end

    if state.stage == "SPECIAL_CLEAR_FLAGS_CHUNK" then
        local processedInChunk = 0
        for i = state.processingIndex, math.min(state.processingIndex + state.chunkSize - 1, #state.allGuildPlayerNames) do
            local playerName = state.allGuildPlayerNames[i]
            player = getPlayerSafe(playerName)
            if player and player.recommendSpecial and not state.tempNamesForMarking[player.name] then
                player.recommendSpecial = false
            end
            processedInChunk = processedInChunk + 1
        end
        state.processingIndex = state.processingIndex + processedInChunk
        if state.processingIndex <= #state.allGuildPlayerNames then
            C_Timer.After(0, function()
                Scan.ProcessNextMacroRuleChunk ( scanCheck );
            end);
            return
        else
            advanceToNextMajorStage("FINISH"); return
        end
    end

    ------------------------------------
    -- FINISH STAGE
    ------------------------------------
    if state.stage == "FINISH" then
        state.isRunning = false
        Scan.currentScanState = nil; -- Clearing for garbage collection as it's a LOT of data
        if GRM_G.FullMacroToolRefresh then
            GRM_G.FullMacroToolRefresh = false;
            GRM_UI.FullMacroToolRefresh();
        end

        if scanCheck then
            Scan.FinishedScan();
        end
        return
    end
    -- Fallback: Should not be reached if all stages correctly transition..
    GRM_G.FullMacroToolRefresh = false;
    state.isRunning = false -- Halt to prevent infinite loops on unknown state
    Scan.currentScanState = nil;
end

Scan.GetRuleNameMatchesChunk = function(playerRec)
    local result = {};
    if type(playerRec) == "table" then
        -- Iterate from the first rule up to the total number of rules.
        -- #playerRec should correctly give the count of elements in the array part.
        for i = 1, #playerRec do
            if playerRec[i] and type(playerRec[i]) == "table" and type(playerRec[i][1]) == "string" then
                table.insert(result, playerRec[i][1]);
            end
        end
    end
    return result;
end

---------------------------
--- SCAN UTILITIES --------
---------------------------

-- method:          Scan.RefreshNumberOfHoursTilRecommend()
-- What it Does:    Rebuilds the time on the recommends for the macro tool and the log.
-- Purpose:         Resource saving. No need to process over and over everytime it is looked at unless a change is made.
Scan.RefreshNumberOfHoursTilRecommend = function()
    if GRM.S() then
        GRM_G.NumberOfHoursTilRecommend.kick = {};
        GRM_G.NumberOfHoursTilRecommend.kickActive = {};
        GRM_G.NumberOfHoursTilRecommend.promote = {};
        GRM_G.NumberOfHoursTilRecommend.demote = {};
        GRM_G.NumberOfHoursTilRecommend.special = {};

        local validateFormat = function(exactRule, defaultMonths)

            if type(exactRule.numDaysOrMonths) ~= "number" then
                exactRule.numDaysOrMonths = 12;
                exactRule.isMonths = true;
            end

            if not exactRule.rankSpecialNumDaysOrMonths then
                exactRule.rankSpecialNumDaysOrMonths = defaultMonths;
            end

            return exactRule;
        end

        for ruleName, rule in pairs(GRM.S().kickRules) do
            if rule.activityFilter then -- Only need to add if this part is enabled.
                GRM_G.NumberOfHoursTilRecommend.kick[ruleName] = 0;

                rule = validateFormat(rule, 12);

                if rule.isMonths then
                    GRM_G.NumberOfHoursTilRecommend.kick[ruleName] = GRM.Time.GetNumHoursTilRecommend(rule.numDaysOrMonths);
                else
                    GRM_G.NumberOfHoursTilRecommend.kick[ruleName] = (rule.numDaysOrMonths * 24);
                end
            end

            if rule.applyEvenIfActiive then
                GRM_G.NumberOfHoursTilRecommend.kickActive[ruleName] = 0;
                if rule.rankSpecialIsMonths then
                    GRM_G.NumberOfHoursTilRecommend.kickActive[ruleName] = GRM.Time.GetNumHoursTilRecommend(
                        rule.rankSpecialNumDaysOrMonths);
                else
                    GRM_G.NumberOfHoursTilRecommend.kickActive[ruleName] = (rule.rankSpecialNumDaysOrMonths * 24);
                end
            end
        end

        for ruleName, rule in pairs(GRM.S().promoteRules) do
            if rule.activityFilter then -- Only need to add if this part is enabled.
                GRM_G.NumberOfHoursTilRecommend.promote[ruleName] = {};
                GRM_G.NumberOfHoursTilRecommend.promote[ruleName].hours = 0;

                rule = validateFormat(rule, 3);

                if rule.isMonths then
                    GRM_G.NumberOfHoursTilRecommend.promote[ruleName].hours = GRM.Time.GetNumHoursTilRecommend(
                        rule.numDaysOrMonths);
                else
                    GRM_G.NumberOfHoursTilRecommend.promote[ruleName].hours = (rule.numDaysOrMonths * 24);
                end

                if not rule.regardlessOfActivity then
                    GRM_G.NumberOfHoursTilRecommend.promote[ruleName].inactive = 0;
                    if rule.rankSpecialIsMonths then
                        GRM_G.NumberOfHoursTilRecommend.promote[ruleName].inactive = GRM.Time.GetNumHoursTilRecommend(
                            rule.rankSpecialNumDaysOrMonths);
                    else
                        GRM_G.NumberOfHoursTilRecommend.promote[ruleName].inactive =
                            (rule.rankSpecialNumDaysOrMonths * 24);
                    end
                end

            end
        end

        for ruleName, rule in pairs(GRM.S().demoteRules) do
            if rule.activityFilter then -- Only need to add if this part is enabled.
                GRM_G.NumberOfHoursTilRecommend.demote[ruleName] = {};
                GRM_G.NumberOfHoursTilRecommend.demote[ruleName].hours = 0;

                rule = validateFormat(rule);

                if rule.isMonths then
                    GRM_G.NumberOfHoursTilRecommend.demote[ruleName].hours = GRM.Time.GetNumHoursTilRecommend(
                        rule.numDaysOrMonths);
                else
                    GRM_G.NumberOfHoursTilRecommend.demote[ruleName].hours = (rule.numDaysOrMonths * 24);
                end

            end
        end

        for ruleName, rule in pairs(GRM.S().specialRules) do
            if rule.activityFilter then -- Only need to add if this part is enabled.
                GRM_G.NumberOfHoursTilRecommend.special[ruleName] = {};
                GRM_G.NumberOfHoursTilRecommend.special[ruleName].hours = 0;

                rule = validateFormat(rule);

                if rule.isMonths then
                    GRM_G.NumberOfHoursTilRecommend.special[ruleName].hours = GRM.Time.GetNumHoursTilRecommend(
                        rule.numDaysOrMonths);
                else
                    GRM_G.NumberOfHoursTilRecommend.special[ruleName].hours = (rule.numDaysOrMonths * 24);
                end
            end
        end

    end
end

-- Method:          Scan.GetGuildEventString ( int , string , string )
-- What it Does:    Gets more exact info from the actual Guild Event Log ( can only be queried once per 10 seconds) as a string
-- Purpose:         This parses more exact info, like "who" did the kicking, or "who" invited who, and so on.
Scan.GetGuildEventString = function(index, playerName, initRank, finRank, class, liveJoinDetected)
    -- index 1 = demote , 2 = promote , 3 = remove/quit , 4 = invite/join
    local added = false;
    local eventType = {"demote", "promote", "invite", "join", "quit", "remove"};
    local logEntryMetaData = {false};

    QueryGuildEventLog();

    if index == 1 or index == 2 then
        for i = GetNumGuildEvents(), 1, -1 do
            local typeEvent, p1, p2, _, year, month, day, hour = GetGuildEventInfo(i);
            if p1 ~= nil then ---or eventType [ 2 ] == type ) and ( p2 ~= nil and p2 == playerName ) and p1 ~= nil then
                if index == 1 and eventType[1] == typeEvent and p2 ~= nil and
                    (p2 == playerName or p2 == GRM.SlimName(playerName)) then -- DEMOTIONS
                    p1 = GRM.GetStringClassColorByName(p1) .. GRM.SlimName(p1) .. "|r";
                    p2 = GRM.GetStringClassColorByName(p2) .. GRM.SlimName(p2) .. "|r";
                    logEntryMetaData = {true, p1, p2, initRank, finRank,
                                        GRM.Time.GetTimestampBasedOnTimePassed({day, month, year, hour})};
                    added = true;
                    break
                elseif index == 2 and eventType[2] == typeEvent and p2 ~= nil and
                    (p2 == playerName or p2 == GRM.SlimName(playerName)) then -- PROMOTIONS
                    p1 = GRM.GetStringClassColorByName(p1) .. GRM.SlimName(p1) .. "|r";
                    p2 = GRM.GetStringClassColorByName(p2) .. GRM.SlimName(p2) .. "|r";
                    logEntryMetaData = {true, p1, p2, initRank, finRank,
                                        GRM.Time.GetTimestampBasedOnTimePassed({day, month, year, hour})};
                    added = true;
                    break
                end
            end
        end

        -- Remove or Quit
    elseif index == 3 then
        local notFound = true;
        for i = GetNumGuildEvents(), 1, -1 do
            local typeEvent, p1, p2, _, year, month, day, hour = GetGuildEventInfo(i);
            if p1 ~= nil then
                if eventType[5] == typeEvent or eventType[6] == typeEvent then -- Quit or Kicked

                    -- KICKED
                    if eventType[6] == typeEvent and p2 ~= nil and
                        (p2 == playerName or p2 == GRM.SlimName(playerName)) then
                        p1 = GRM.GetStringClassColorByName(p1) .. GRM.SlimName(p1) .. "|r";
                        p2 = GRM.GetStringClassColorByName(p2) .. GRM.SlimName(p2) .. "|r";
                        logEntryMetaData = {true, p1, p2,
                                            GRM.Time.GetTimestampBasedOnTimePassed({day, month, year, hour})};
                        added = true;
                        notFound = false;

                        -- QUIT
                    elseif eventType[5] == typeEvent and (p1 == playerName or p1 == GRM.SlimName(playerName)) then
                        -- FOUND!
                        p1 = GRM.GetStringClassColorByName(playerName) .. GRM.SlimName(playerName) .. "|r";
                        logEntryMetaData = {true, p1, nil,
                                            GRM.Time.GetTimestampBasedOnTimePassed({day, month, year, hour})};
                        added = true;
                        notFound = false;
                    end
                    if notFound ~= true then
                        break
                    end
                end
            end
        end
        -- Invite
    elseif index == 4 then
        for i = GetNumGuildEvents(), 1, -1 do
            local typeEvent, p1, p2, _, year, month, day, hour = GetGuildEventInfo(i);
            if eventType[3] == typeEvent and p1 ~= nil and p2 ~= nil and
                (p2 == playerName or p2 == GRM.SlimName(playerName)) then -- invite
                p1 = GRM.GetStringClassColorByName(p1) .. GRM.SlimName(p1) .. "|r";
                p2 = GRM.GetClassColorRGB(class, true) .. GRM.SlimName(p2) .. "|r";
                logEntryMetaData = {true, p1, p2, GRM.Time.GetTimestampBasedOnTimePassed({day, month, year, hour})};
                added = true;
                break
            end
        end

        -- JOINED but no invite data
        -- Possibly player joined but no record of *WHO* invited them
        if not added then

            if not liveJoinDetected then

                for i = GetNumGuildEvents(), 1, -1 do
                    local typeEvent, p1, _, _, year, month, day, hour = GetGuildEventInfo(i); -- p1 = the player who joined
                    if eventType[4] == typeEvent and p1 ~= nil and
                        (p1 == playerName or p1 == GRM.SlimName(playerName)) then -- invite
                        p1 = GRM.GetClassColorRGB(class, true) .. GRM.SlimName(p1) .. "|r";
                        logEntryMetaData = {true, nil, p1,
                                            GRM.Time.GetTimestampBasedOnTimePassed({day, month, year, hour})};
                        added = true;
                        break
                    end
                end

            else
                -- Build it on today's date.
                local hour, minutes = GetGameTime();
                local time = GRM.Time.GetFormatTime(hour, minutes);
                local month, day, year = select(2, GRM.Time.GetTodaysDate());
                playerName = GRM.GetClassColorRGB(class, true) .. GRM.SlimName(playerName) .. "|r";
                local timestamp =
                    day .. " " .. GRM.Time.Enums.ind_to_month_abbrev[month] .. " '" .. tostring(year - 2000) .. " " .. time;
                logEntryMetaData = {true, nil, playerName,
                                    {timestamp, GRM.Time.ConvertToStandardFormatDate(day, month, year),
                                        {day, month, year}}};
                added = true;
            end
        end
    end

    return added, logEntryMetaData;
end

-- Method:          Scan.SilenceOfficerNoteReport ( int , int )
-- What it Does:    Returns true if officer rank change needs to be reported, if a player has been promoted to officer or demoted.
-- Purpose:         The officerNote is hidden from non-officers, so on changing to an officer, it now appears as if officer notes have been added, but they are only now just visible
--                  This ensures that the log doesn't spam that the notes have all been added... or, if demoted from officer, that they all have been removed.
Scan.SilenceOfficerNoteReport = function(oldRankIndex, updatedRankIndex)
    local timer = time();
    if (not GRM.IsOfficerRankByIndex(oldRankIndex) and GRM.IsOfficerRankByIndex(updatedRankIndex)) or
        (GRM.IsOfficerRankByIndex(oldRankIndex) and not GRM.IsOfficerRankByIndex(updatedRankIndex)) then
        return true, timer;
    end
    return false, timer;
end

-- Method:          Scan.GetMatureFilterNormalizedString ( int )
-- What it Does:    Returns a string with the number of special characters for mature language filter normalization
-- Purpose:         Blizz seems to have a rolling string of special characters that can be inconsistent on how it censors the curse/mature words, and so string compare
--                  can be inconsistently comparing to different variations of special characters on server calls. This resolves that by normalizing curse word representation to the
--                  addon and all 5 letter words will be same string, and all 4 letter words will be same string and so on.
Scan.GetMatureFilterNormalizedString = function(numChars)
    local matureFilterTable = {"$", "%", "^", "&", "*", "!", "@", "#"};
    local result = "";

    while #result < numChars do
        for i = 1, #matureFilterTable do
            result = result .. matureFilterTable[i]; -- Add the chair and build the string...
            if #result >= numChars then -- It is the correct size now, let's break it.
                break
            end
        end
    end

    return result;
end

-- Method:          Scan.NormalizeMatureWords ( string )
-- What it Does:    Searches a string for Blizz's implementation of various curse word censoring and then overwrites it with a normalized curseword string
-- Purpose:         For comparing strings properly as the curse word censoring with the "Mature Langue Filter" is inconsistent from the server...
Scan.NormalizeMatureWords = function(text)
    local matureFilterTable = {"$", "%", "^", "&", "*", "!", "@", "#"};
    local index = 1;
    local count = 1; -- Count must make it to 3 or else we break

    while index <= #text do
        local restart = false;
        for i = index, #text do -- No need to parse the final 2 as curse word must be 3 letters +
            local char = string.sub(text, i, i); -- Parse out the char to compare to match...
            for j = 1, #matureFilterTable do
                if char == matureFilterTable[j] then
                    -- POTENTIAL MATCH
                    -- So far, one letter is matching! Let us determine where the next matching letter as well (word must be at least 3 letters, up to 8)
                    count = 1;
                    for r = i + 1, #text do
                        local isMatch = false; -- There MUST be a match or we break this and then compare to count... if it is greater than or equal to 3, then we have a curse word
                        local char2 = string.sub(text, r, r); -- Parse out the char to compare to match...
                        for s = 1, #matureFilterTable do
                            if char2 == matureFilterTable[s] then
                                isMatch = true;
                                count = count + 1;
                                break
                            end
                        end
                        if not isMatch or r == #text then
                            restart = true;
                            if count >= 3 then
                                -- MATCH FOUND!!! CURSE WORD IDENTIFIED!!!
                                text = (string.sub(text, 1, i - 1) .. Scan.GetMatureFilterNormalizedString(count) ..
                                           string.sub(text, i + count));
                            end
                            break
                        end
                    end
                    break
                end
            end
            index = index + 1;
            -- Let's break the loop and pickup where we leftoff...
            if restart then
                index = i + count; -- We might jump a few characters here...
                break
            end
        end
    end
    return text;
end
