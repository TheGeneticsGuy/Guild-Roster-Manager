-- For Sync controls!
-- Author: Arkaan... aka "TheGenomeWhisperer"
-- To hold all Sync Methods/Functions

GRMsync = {};

-- All Sync Globals
GRMsyncGlobals = {};

GRMsyncGlobals.channelName = "GUILD";
GRMsyncGlobals.DatabaseLoaded = false;
GRMsyncGlobals.RulesSet = false;
GRMsyncGlobals.LeadSyncProcessing = false;
GRMsyncGlobals.SyncOK = true;

-- Establishing leadership controls.
GRMsyncGlobals.IsLeaderRequested = false;
GRMsyncGlobals.LeadershipEstablished = false;
GRMsyncGlobals.IsElectedLeader = false;
GRMsyncGlobals.DesignatedLeader = "";
GRMsyncGlobals.ElectTimeOnlineTable = {};
GRMsyncGlobals.ElectionProcessing = false;
GRMsyncGlobals.AllLeadersNeutral = {};              -- Due to various privilege variation, this collects all leaders of all privilege ranks, then selects the leader at highest index, meaning lowest rank.
GRMsyncGlobals.InitializeTime = 0;                  -- to ensure no crossover talk and double requests for leadership establishment.

-- For players queing to by sync'd to share data!
-- If a player requests a leader sync, they are added to this que. This is so the leader can just add them to que
-- in the case that they may be syncing with another player already. Depending on the amount of data transferring, and the size of the guild, sync can take anywhere from 1-5 seconds
-- Based on server response time, per person. At least, initially. Live Sync updates happen near instantly.
GRMsyncGlobals.SyncQue = {};

-- Collected Tables of Data when received from the player
GRMsyncGlobals.JDReceivedTemp = {};
GRMsyncGlobals.PDReceivedTemp = {};
GRMsyncGlobals.BanReceivedTemp = {};
GRMsyncGlobals.AltReceivedTemp = {};
GRMsyncGlobals.AltRemReceivedTemp = {};
GRMsyncGlobals.MainReceivedTemp = {};
GRMsyncGlobals.CustomNoteReceivedTemp = {};
GRMsyncGlobals.BirthdayReceivedTemp = {};

-- Tables of the changes -- Leader will collect and store them here from all players before broadcasting the changes out, and then resetting them.
-- By compiling all changes first, and THEN checking, it saves an insane amount of resources rather than passing on every new piece received.
GRMsyncGlobals.JDChanges = {};
GRMsyncGlobals.PDChanges = {};
GRMsyncGlobals.BanChanges = {};
GRMsyncGlobals.AltAddChanges = {};
GRMsyncGlobals.AltRemoveChanges = {};
GRMsyncGlobals.AltMainChanges = {};
GRMsyncGlobals.CustomNoteChanges = {};
GRMsyncGlobals.BDayChanges = {};

-- SYNC START AND STOP CONTROLS
-- These are used to verify the expected number of packets of info arrived.
GRMsyncGlobals.ReceivingData = false;
GRMsyncGlobals.NumPlayerDataExpected = 0;

-- SYNC PROCEDURAL ORDERING CONTROLS PER SYNC
GRMsyncGlobals.CurrentSyncPlayer = "";
GRMsyncGlobals.CurrentSyncPlayerRankID = -1;
GRMsyncGlobals.CurrentSyncPlayerRankRequirement = -1;
GRMsyncGlobals.CurrentLeaderRankID = -1;
GRMsyncGlobals.firstSync = true;
GRMsyncGlobals.currentlySyncing = false;
GRMsyncGlobals.JDSyncComplete = false               
GRMsyncGlobals.SyncCount7 = 1;
GRMsyncGlobals.SyncCountBan = 2;              -- For the ban list sync.
GRMsyncGlobals.timeOfLastSyncCompletion = 0;
GRMsyncGlobals.AddLeftPlayerCount = 0;      -- Tracking how many manual adds there are.
-- For more efficient sync tracking
GRMsyncGlobals.SyncCountJD = 1;             -- For Join Date loop
GRMsyncGlobals.SyncCountPD = 1;             -- For Promo Date loop
GRMsyncGlobals.SyncCountAltAdd = 1;
GRMsyncGlobals.SyncCountAltRem = 1;
GRMsyncGlobals.SyncCountMain = 1;
GRMsyncGlobals.SyncCountCustom = 1;
GRMsyncGlobals.SyncCountBday = 1;
GRMsyncGlobals.BanCount = 2;
GRMsyncGlobals.BanListLongCount = 1;
GRMsyncGlobals.AltSendIsFinished = true;
GRMsyncGlobals.AltSendIsFinished2 = true;
-- error protection escapes
GRMsyncGlobals.SyncJDDelay = 0;
GRMsyncGlobals.SyncPDDelay = 0;
GRMsyncGlobals.SyncAltDelay = 0;
GRMsyncGlobals.SyncBanDelay = 0;
GRMsyncGlobals.SyncMainDelay = 0;
GRMsyncGlobals.SyncCustomDelay = 0;
GRMsyncGlobals.SyncBdayDelay = 0;
GRMsyncGlobals.AnnounceDelay = 0;

GRMsyncGlobals.TimeSinceLastSyncAction = 0; -- Evertime sync action occurs, timer is reset!
GRMsyncGlobals.ErrorCD = 10;                -- 10 seconds delay... if no action detected, sync failed and it will retrigger...
GRMsyncGlobals.numSyncAttempts = 0;         -- If sync fails, it will retry 1 time. This is the counter for attempts.
GRMsyncGlobals.dateSentComplete = false;    -- If player is not designated leader, this boolean is used to exit the error check loop.
GRMsyncGlobals.errorCheckEnabled = false;   -- To know when to reactivate the recursive loop or not.
GRMsyncGlobals.syncTempDelay = false;
GRMsyncGlobals.syncTempDelay2 = false;
GRMsyncGlobals.finalSyncDataCount = 1;
GRMsyncGlobals.finalSyncDataBanCount = 1;
GRMsyncGlobals.finalSyncProgress = { false , false , false , false , false , false , false , false };        -- on each of the tables, if submitted fully
GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;
GRMsyncGlobals.TempRoster = {};
GRMsyncGlobals.altTempRosterCleanedup = false;
GRMsyncGlobals.tempListForLongReason = {};

-- Custom note controls (Live sync, retro sync, and self-update, all of which can happen simultaneously so need different controls for each to avoid unlocking gates at inopportune times, even if low probability
GRMsyncGlobals.HalfMsg = false;
GRMsyncGlobals.HalfSyncup = false;
GRMsyncGlobals.HalfSyncLive = false;
GRMsyncGlobals.HalfMsgTemp = "";
GRMsyncGlobals.HalfSyncupMsg = ""
GRMsyncGlobals.HalfSyncMsgLive = "";

-- Throttle, size, and byte controls 3556
GRMsyncGlobals.sizeModifier = 8;        -- prefix size 8 bytes
GRMsyncGlobals.burstMessage = 3556   -- deprecated
GRMsyncGlobals.normalMessage = 3556     -- Normal message size, when it reaches the limit, it resets... -- 14 full messages at 254 bytes each.
GRMsyncGlobals.normalMessageModifier1 = 3556;
GRMsyncGlobals.burstSent = false;
GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.burstMessage;
GRMsyncGlobals.minFPS = 20;             -- if the player has low FPS the cut the throttlecap in half.
GRMsyncGlobals.throttleTimerUpdate = 0;
GRMsyncGlobals.timeAtLogin = time();
GRMsyncGlobals.SyncCount = 0;               -- 2 because index begins at 2 in the table, as index 1 is the guild name
GRMsyncGlobals.reloadControl = false;
GRMsyncGlobals.CustomNoteLarge = false;     -- for carryover indication that the next message expected is addional stuff from the log
GRMsyncGlobals.ThrottleDelay = 1.25;           -- 1.25 seconds between bursts.
-- Throttle compatibility with ChatThrottleLib
GRMsyncGlobals.CTLEnabled = false;
GRMsync.ChatThrottleDelay = 0;

-- Version check
GRMsyncGlobals.CompatibleAddonUsers = {};

-- Custom pseudo hash values
GRMsyncGlobals.HashValuesReceived = { {} , {} , {} , {} , {} , {} , {} };      -- resets to array of 7 arrays.
GRMsyncGlobals.DatabaseMarkers = {};
GRMsyncGlobals.DatabaseExactIndexes = {};
GRMsyncGlobals.SyncProgress = { false , false , false , false , false , false , false , true }; -- 8 is completion and always true
GRMsyncGlobals.BansCheckFinished = false;
GRMsyncGlobals.senderBanRankReq = 0;
GRMsyncGlobals.preCheckControl = { 1 , 1 };

-- Results
GRMsyncGlobals.updateCount = 0;             -- Number of items updated in this sync.
GRMsyncGlobals.upatesEach = { 0 , 0 , 0 , 0 , 0 , 0 };

-- Tables to hold data in array format, sorted - to maintain compatibility with sync system with new data structures
GRMsyncGlobals.guildData = {};
GRMsyncGlobals.formerGuildData = {};

GRMsyncGlobals.firstSyncOccurred = false;

-- For sync control measures on player details, so leader can be determined on who has been online the longest. In other words, for the leadership selecting algorithm
-- when determining the tiers for syncing, it is ideal to select the leader who has been online the longest, as they most-likely have encountered the most current amount of information.
GRMsyncGlobals.firstMessageReceived = false;

-- Prefixes for tagging info as it is sent and picked up across server channel to other players in guild.
GRMsyncGlobals.listOfPrefixes = { 

    -- Main Sync Prefix...  rest will be text form
    "GRM_SYNC"
};

-- SYNC THROTTLING SCRIPT HANDLERS
local InstanceManager = CreateFrame ( "frame" );
InstanceManager.OnUpdateDelay = 0;
InstanceManager.StatusFlip = 1;
InstanceManager.isFirstLoad = true;
InstanceManager:RegisterEvent ( "ZONE_CHANGED_NEW_AREA" );
InstanceManager:SetScript ( "OnEvent" , function()
    if not InstanceManager.isFirstLoad then
        GRMsyncGlobals.ThrottleCap = 500;     -- Throttle it down to about 1/10th the base speed for 30 seconds on entering a new zone, lest it can kick you
        C_Timer.After ( 30 , function()
            if InstanceManager.StatusFlip == 2 then
                GRMsyncGlobals.ThrottleCap = ( GRMsyncGlobals.normalMessage * 0.5 );
            else
                GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
            end
        end);
    else
        InstanceManager.isFirstLoad = false;        -- This is so it skips the first one upon logging in the game.
    end
end);

-- Keeps track of the framerate as the lower the framerate, as in, less than 20FPS, it can hamper the ability to send messages without disconnecting.
-- This throttles it down by 0.5 or it resets them.
InstanceManager:SetScript ( "OnUpdate" , function ( self , elapsed )
    self.OnUpdateDelay = self.OnUpdateDelay + elapsed;
    if self.OnUpdateDelay < 0.08 then
        return;
    end
    self.OnUpdateDelay = 0;
    local framerate = GetFramerate();
    if framerate < GRMsyncGlobals.minFPS and self.StatusFlip < 2 then
        self.StatusFlip = 2;
        GRMsyncGlobals.ThrottleCap = ( GRMsyncGlobals.ThrottleCap * 0.5 );
    elseif framerate >= GRMsyncGlobals.minFPS and self.StatusFlip > 1 then
        self.StatusFlip = 1;
        GRMsyncGlobals.ThrottleCap = ( GRMsyncGlobals.ThrottleCap * 2 );
    end
end);

-- Method:          GRMsync.MessageThrottleUpdate ( frame , float )
-- What it Does:    Changes the throttle cap to the much lower default cap after the player has entered the world for 15 seconds.
-- Purpose:         This is due to there being a 1.28Mb cap within the first 20 seconds that drops to a tiny 5Kb/s If the player can burst most of the info right away on logon, then sync can be quite fast. Otherwise it needs to be hard throttled to prevent player disconnect
GRMsync.MessageThrottleUpdate = function ( self , elapsed )
    if not GRMsyncGlobals.reloadControl then
        GRMsyncGlobals.throttleTimerUpdate = GRMsyncGlobals.throttleTimerUpdate + elapsed;
        if GRMsyncGlobals.throttleTimerUpdate > 0.8 then
            
            if ( time() - GRMsyncGlobals.timeAtLogin ) >= 15 then
                if InstanceManager.StatusFlip == 2 then
                    GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage * 0.5;
                else
                    GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
                end
                -- Unregister the OnUpdate here...
                self:SetScript ( "OnUpdate" , nil );
            elseif ( time() - GRMsyncGlobals.timeAtLogin ) <= 5 then
                if InstanceManager.StatusFlip == 2 then
                    GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage * 0.5;
                else
                    GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
                end
            else
                GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.burstMessage;
            end
            
            GRMsyncGlobals.throttleTimerUpdate = 0;
        end
    else
        GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage * GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncSpeed;
        if InstanceManager.StatusFlip == 2 then
            GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.ThrottleCap * 0.5
        end
        -- Unregister the OnUpdate here...
        self:SetScript ( "OnUpdate" , nil );
    end
end

-- Method:          GRMsync.ResetDefaultValuesOnSyncReEnable()
-- What it Does:    Sets values to default, as if just logging back in.
-- Purpose:         For sync to properly work, default startup values need to be reset.
GRMsync.ResetDefaultValuesOnSyncReEnable = function()
    GRMsyncGlobals.DatabaseLoaded = false;
    GRMsyncGlobals.RulesSet = false;
    GRMsyncGlobals.IsLeaderRequested = false;
    GRMsyncGlobals.LeadershipEstablished = false;
    GRMsyncGlobals.IsElectedLeader = false;
    GRMsyncGlobals.DesignatedLeader = "";
    GRMsyncGlobals.ElectTimeOnlineTable = nil;
    GRMsyncGlobals.ElectTimeOnlineTable = {};
    GRMsyncGlobals.currentlySyncing = false;
    GRMsyncGlobals.ElectionProcessing = false;
    GRMsyncGlobals.SyncQue = {};
    GRMsyncGlobals.AllLeadersNeutral = nil;
    GRMsyncGlobals.AllLeadersNeutral = {};
    GRMsyncGlobals.InitializeTime = 0;
    
end

-- Resetting after broadcasting the changes.
GRMsync.ResetReportTables = function()
    GRMsyncGlobals.JDChanges = {};
    GRMsyncGlobals.PDChanges = {};
    GRMsyncGlobals.BanChanges = {};
    GRMsyncGlobals.AltAddChanges = {};
    GRMsyncGlobals.AltRemoveChanges = {};
    GRMsyncGlobals.AltMainChanges = {};
    GRMsyncGlobals.CustomNoteChanges = {};
    GRMsyncGlobals.BDayChanges = {};
end

-- In case of mid-cycling reset, this resets all the temp tables.
GRMsync.ResetTempTables = function()
    GRMsyncGlobals.JDReceivedTemp = {};
    GRMsyncGlobals.PDReceivedTemp = {};
    GRMsyncGlobals.BanReceivedTemp = {};
    GRMsyncGlobals.AltReceivedTemp = {};
    GRMsyncGlobals.AltRemReceivedTemp = {};
    GRMsyncGlobals.MainReceivedTemp = {};
    GRMsyncGlobals.CustomNoteReceivedTemp = {};
    GRMsyncGlobals.BirthdayReceivedTemp = {};
    GRMsyncGlobals.HashValuesReceived = { {} , {} , {} , {} , {} , {} , {} };
    GRMsyncGlobals.DatabaseMarkers = {};
    GRMsyncGlobals.DatabaseExactIndexes = {};
    GRMsyncGlobals.SyncProgress = { false , false , false , false , false , false , false , true };
    GRMsyncGlobals.BansCheckFinished = false;
    GRMsyncGlobals.upatesEach = { 0 , 0 , 0 , 0 , 0 , 0 };
    GRMsyncGlobals.preCheckControl = { 1 , 1 };
end

-- For use on doing a hard reset on sync. This is useful like if the addon user themselves changes rank and permissions change. Things would be wonky without force a hard reset of privileges.
GRMsync.TriggerFullReset = function()
    GRMsync.ResetDefaultValuesOnSyncReEnable();
    GRMsync.ResetReportTables();
    GRMsync.ResetTempTables();
    GRMsyncGlobals.SyncOK = true;
end

-- Useful indexing enum
local allClassesEnum = { ["DEATHKNIGHT"] = 1 , ["DEMONHUNTER"] = 2 , ["DRUID"] = 3 , ["HUNTER"] = 4 , ["MAGE"] = 5 , ["MONK"] = 6 , ["PALADIN"] = 7 , ["PRIEST"] = 8 , ["ROGUE"] = 9 ,["SHAMAN"] = 10 , ["WARLOCK"] = 11 , ["WARRIOR"] = 12 }

--------------------------
----- FUNCTIONS ----------
--------------------------

-- Method:          GRMsync.WaitTilDatabaseLoads()
-- What it Does:    Sets the player's guild ranking by index of rank
-- Purpose:         This is important for addon talk to not get info from ranks too low.
GRMsync.WaitTilDatabaseLoads = function()
    if IsInGuild() and GRM_G.guildName == "" then
        C_Timer.After ( 1 , GRMsync.WaitTilDatabaseLoads );
        return
    else
        GRMsyncGlobals.DatabaseLoaded = true;
    end
    GRMsync.BuildSyncNetwork();
end

-- method:          GRMsync.SlimDate ( string )
-- What it Does:    Returns the string with the hour/min taken off the end.
-- Purpose:         For SYNCing, the only important piece of info on the timestamp is the date, and comparing it is the same. I don't want sync to trigger over and over
--                  Because the hour/min is off on the sync when that is unimportant info, at least in this context.
GRMsync.SlimDate  = function ( date )
    if date ~= "" then
        date = string.sub ( date , 1 , string.find( date , "'" ) + 2 );
    end
    return date;
end

-------------------------------------
----- ESTABLISH SYNC LEADERSHIP -----
-----        BY ELECTION        -----
-------------------------------------

-- Method:          GRMsync.InquireLeader()
-- What it Does:    On logon, or activation of sync alg, it requests in the guild channel if a leader is online.
-- Purpose:         Step 1 of sync algorithm in determining leader.
GRMsync.InquireLeader = function()
    GRMsyncGlobals.IsLeaderRequested = true;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_WHOISLEADER?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. "" , GRMsyncGlobals.channelName );
    end

    -- Check for number of leaders after 3 sec.
    C_Timer.After ( 4.1 , function()
        if #GRMsyncGlobals.AllLeadersNeutral > 0 then
            if #GRMsyncGlobals.AllLeadersNeutral == 1 then
                GRMsync.SetLeader ( GRMsyncGlobals.AllLeadersNeutral[1] );
            else
                -- Determine the rank now...
                local highestIndex = GRM.GetGuildMemberRankID ( GRMsyncGlobals.AllLeadersNeutral[1] );
                local index = 1;
                local newIndex;
                -- Going to set the sync leader to be the lowest rank'd (highest index).
                -- The reason this is necessary is because it will prevent you from syncing with higher rank officers that might restrict sync
                -- with lower ranks, thus you will not sync with lower rank, then sync with higher rank, bypassing rank restrictions.
                -- You choose to sync with lower ranks, it will default to only sync with lower ranks.
                for i = 2 , #GRMsyncGlobals.AllLeadersNeutral do
                    newIndex = GRM.GetGuildMemberRankID ( GRMsyncGlobals.AllLeadersNeutral[1] );
                    if newIndex > highestIndex then
                        highestIndex = newIndex;
                        index = i;
                    end
                end

                -- Ok, let's set the new leader!
                GRMsync.SetLeader ( GRMsyncGlobals.AllLeadersNeutral[index] );
            end
        end
    end);
end

-- Method:          GRMsync.InquireLeaderRespond ( string )
-- What it Does:    The new leader will respond out "I AM LEADER" and everyone set him as leader. No need to set as leader as it would have already been done at this point.
-- Purpose:         Sync leadership controls.
GRMsync.InquireLeaderRespond = function ()
    GRMsyncGlobals.IsLeaderRequested = true;
    GRMsyncGlobals.LeadershipEstablished = true;
    GRMsyncGlobals.ElectionProcessing = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_IAMLEADER?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. "" , GRMsyncGlobals.channelName );
    end
    if not GRMsyncGlobals.reloadControl then
        C_Timer.After ( 4.1 , GRMsync.InitiateDataSync );
    else
        GRMsyncGlobals.reloadControl = false;
    end
end

-- Method:          GRMsync.ReviewElectResponses ()
-- What it Does:    Reviews timestamps of all online people with addon, and if there is no leader, it elects a new leader.
-- Purpose:         Leadership needs to be established to ensure clean syncing.
GRMsync.ReviewElectResponses = function()
    if #GRMsyncGlobals.ElectTimeOnlineTable > 1 then
        local highestName = GRM_G.addonUser;
        local highestTime = GRMsyncGlobals.timeAtLogin;
        local time = time();

        -- Let's determine who has been online the longest.
        for i = 1 , #GRMsyncGlobals.ElectTimeOnlineTable do
            if ( time - GRMsyncGlobals.ElectTimeOnlineTable[i][1] ) > ( time - highestTime ) then
                highestTime = GRMsyncGlobals.ElectTimeOnlineTable[i][1];
                highestName = GRMsyncGlobals.ElectTimeOnlineTable[i][2];
            end
        end

        -- Send Message out
        if GRMsyncGlobals.SyncOK then
            GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_NEWLEADER?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. highestName , GRMsyncGlobals.channelName );
        end
        -- Establishing leader.
        GRMsync.SetLeader ( highestName );
        

    elseif #GRMsyncGlobals.ElectTimeOnlineTable == 1 then
        -- One result will be established as leader. No need to compare.
        -- Identifying new leader!
        if GRMsyncGlobals.SyncOK then
            GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_NEWLEADER?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. GRMsyncGlobals.ElectTimeOnlineTable[1][2] , GRMsyncGlobals.channelName );
        end
        -- Sending message out.
        GRMsync.SetLeader ( GRMsyncGlobals.ElectTimeOnlineTable[1][2] );
        
    else
        -- Abort sync since it was only temporary, and there is no one to sync with.
        if GRM_G.TemporarySync then
            GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncEnabled = false;
            GRM_G.TemporarySync = false;
            GRMsync.MessageTracking:UnregisterAllEvents()
            GRMsync.ResetDefaultValuesOnSyncReEnable();         -- Reset values to default, so that it resyncs if player re-enables.
            GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncCheckButton:SetChecked ( false );
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "No Players Currently Online to Sync With. Re-Disabling Sync..." ) );
        else
            -- ZERO RESPONSES! No one else online! -- No need to data sync and go further!
            GRMsyncGlobals.DesignatedLeader = GRM_G.addonUser;
            GRMsyncGlobals.IsElectedLeader = true;
            
            -- if no leader was found, and it is just me, do a random check again within the next 10-45 seconds.
            GRMsyncGlobals.LeadSyncProcessing = true;
            GRMsyncGlobals.IsLeaderRequested = false;
            C_Timer.After ( math.random ( 10 , 45 ) , GRMsync.EstablishLeader );
        end
    end
    
    -- RESET TABLE!
    GRMsyncGlobals.ElectionProcessing = false;
    GRMsyncGlobals.ElectTimeOnlineTable = nil;
    GRMsyncGlobals.ElectTimeOnlineTable = {};

end


-- Method:          GRMsync.RequestElection()
-- What it Does:    To person who just logged in or reactivated syncing, it sends out a request to elect a leader if no leader identified.
-- Purpose:         Need to get time responses from all players to determine who has been online the longest, which will likely have the best data.
GRMsync.RequestElection = function()
    GRMsyncGlobals.ElectionProcessing = true;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_ELECT?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. "" , GRMsyncGlobals.channelName );
    end
    -- Let's give it a time delay to receive responses. 3 seconds.
    C_Timer.After ( 4.1 , GRMsync.ReviewElectResponses );
end


-- Method:          GRMsync.SendTimeForElection()
-- What it Does:    Sends the time logged in or addon sync was enabled
-- Purpose:         For voting, to determine who was online the longest.
GRMsync.SendTimeForElection = function()
    if not GRMsyncGlobals.ElectionProcessing then
        if GRMsyncGlobals.SyncOK then
            GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_TIMEONLINE?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. GRM_G.addonUser .. "?" .. tostring ( GRMsyncGlobals.timeAtLogin ) , GRMsyncGlobals.channelName );
        end
    end
end

-- Method:          GRMsync.RegisterTimeStamps( string )
-- What it Does:    Adds the player's name and timestamp for election
-- Purpose:         Need to aggregate all the player data for voting!
GRMsync.RegisterTimeStamps = function ( msg )
    -- Adding { timestamp , name } to the list of people giving their time... 3 second response time valid only.
    table.insert ( GRMsyncGlobals.ElectTimeOnlineTable , { tonumber ( string.sub ( msg , string.find ( msg , "?" ) + 1 ) ) , string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) } );
end

-- Method:          GRMsync.ElectedLeader ( string )
-- What it Does:    Established the elected leader based on message received.
-- Purpose:         Final step in designating a leader!
GRMsync.ElectedLeader = function ( msg )
    -- Message should just be the name, so no need to parse.
    GRMsync.SetLeader ( msg );
end

-- Method:          GRMsync.EstablishLeader()
-- What it Does:    Controls the algorithm flow for syncing data between players by establishing leader.
-- Purpose:         To have a healthy, lightweight, efficient syncing addon.
GRMsync.EstablishLeader = function()
    if time() - GRMsyncGlobals.InitializeTime > 15 then
        GRMsyncGlobals.InitializeTime = time();
        -- "Who is the leader?"
        if not GRMsyncGlobals.IsLeaderRequested then
            GRMsync.InquireLeader();
        end

        C_Timer.After ( 3 , function ()
            -- No responses, no leader! Setup an election for the leader!
            if not GRMsyncGlobals.LeadershipEstablished then
                GRMsync.RequestElection();
            end    
        end);
    end
end

-- Method:          GRMsync.TriggerChatThrottleDelay()
-- What it Does:    If it detects that the ChatThrottleLib Ace library ques up messages, GRM will delay its own message sending for a minimum of 2 seconds
-- Purpose:         Since syncing data on guild member info is not high priority over most other addons, this ensures that Ace library sync data always is --                  prioritized. Their own internal delay is 0.8 seconds, so by force a 2 second delay in GRM by putting my data at cap, it ensures their
--                  On Update handler sees the message spam has cleared...
GRMsync.TriggerChatThrottleDelay = function()
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.ThrottleCap + 1; 
end

-- Method:          GRMsync.HookComms()
-- What it Does:    Hooks the SendAddonMessage function so if any other addon uses it I can see
-- Purpose:         Global outgoing data cap is shared among all addons. To prevent disconnects it is important to know how much overhead other addons are using.
GRMsync.HookComms = function()
    
    hooksecurefunc ( C_ChatInfo , "SendAddonMessage" , function( prefix , msg )
        if prefix ~= "GRM_SYNC" then
            if type ( msg ) == "string" then
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + #prefix;
            else
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + 255;
            end
        end
    end);

    GRMsyncGlobals.CTL = _G.ChatThrottleLib;
        
    -- CODED BLOCK 
    if GRMsyncGlobals.CTL then
        GRMsyncGlobals.CTLEnabled = true;
        

        hooksecurefunc ( _G.ChatThrottleLib, "Enqueue", function()
            if time() - GRMsync.ChatThrottleDelay >= 2 then

                GRMsync.TriggerChatThrottleDelay();
                GRMsync.ChatThrottleDelay = time();
            end
        end);
    end
    
end

-- Method:          GRMsync.SetLeader ( string )
-- What it Does:    If message received, designates the sender as the leader
-- Purpose:         Need to designate a leader!
GRMsync.SetLeader = function ( leader )
    -- Error protection
    if string.find ( leader , "-" ) == nil then
        if GRM.IsMergedRealmServer() then
            local listOfGuildiesOnline = GRM.GetAllGuildiesOnline( true );
            for i = 1 , #listOfGuildiesOnline do
                if GRM.SlimName ( listOfGuildiesOnline[i] ) == leader then
                    leader = listOfGuildiesOnline[i];
                    break;
                end
            end
        else
            leader = leader .. "-" .. GRM_G.realmName;      -- Not a merged realm, so just add the server, since you are both on it.
        end
    end

    if leader ~= GRM_G.addonUser and leader ~= GRMsyncGlobals.DesignatedLeader then
        GRMsyncGlobals.DesignatedLeader = leader;
        GRMsyncGlobals.LeadershipEstablished = true;
        GRMsyncGlobals.ElectionProcessing = false;

        -- Non leader sends request to sync
        if GRMsyncGlobals.SyncOK and not GRMsyncGlobals.reloadControl then
            GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_REQUESTSYNC?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. "" , GRMsyncGlobals.channelName );
            if not GRMsyncGlobals.syncTempDelay then
                -- Disable sync again if necessary!
                if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks and GRMsyncGlobals.firstMessageReceived ) then
                    
                    if GRM_G.TemporarySync then
                        GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Manually Syncing Data With Guildies Now... One Time Only." ) );
                    elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                        GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Syncing Data With Guildies Now..." ) .. "\n" .. GRM.L ( "(Loading screens may cause sync to fail)" ) );
                    end
                else
                    if not GRMsyncGlobals.firstMessageReceived then
                        GRMsyncGlobals.firstMessageReceived = true;
                        GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "No Addon Users Currently Compatible for FULL Sync." ) .. "\n" .. GRM.L ( "Check the \"Sync Users\" tab to find out why!" ) );
                        if #GRM_G.currentAddonUsers > 0 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
                            GRM.Report ( "     " .. GRM.L ( "You will still share some outgoing data with the guild" ) );
                        end
                    end
                end
            end
        else
            GRMsyncGlobals.reloadControl = false;
        end
    elseif leader == GRM_G.addonUser then
        GRMsyncGlobals.DesignatedLeader = leader;
        GRMsyncGlobals.LeadershipEstablished = true;
        GRMsyncGlobals.IsElectedLeader = true;
        GRMsyncGlobals.ElectionProcessing = false;

        -- Initiate data sync
        -- After time delay to receive responses, intiate sync after vote... 3 sec. delay. Everyone else request to sync.
        if not GRMsyncGlobals.reloadControl then
            C_Timer.After ( 1 , GRMsync.InitiateDataSync );
        else
            GRMsyncGlobals.reloadControl = false;
        end
    end    
end

-------------------------------
---- MESSAGE SENDING ----------
-------------------------------

-- Method:          GRMsync.SendMessage ( string , string , string , int )
-- What it Does:    Sends an invisible message over a specified channel that a player cannot see, but an addon can read.
-- Purpose:         Necessary function for cross-talk between players using addon.
GRMsync.SendMessage = function ( prefix , msg , type )
    if GRMsyncGlobals.SyncOK then
        if (#msg + #prefix) >= 255 then
            GRM.Report( GRM.L ( "GRM ERROR:" ) .. " " .. GRM.L ( "Com Message too large for server" ) .. " (" .. (#msg + #prefix) .. ")\n" .. GRM.L ( "Prefix:" ) .. " " .. prefix .. "\n" .. GRM.L ( "Msg:" ) .. " " .. msg );
        elseif msg == "" and prefix == "GRM_SYNC" then
            return
        else
            if GRM_G.DebugEnabled then
                GRM.AddDebugMessage ( msg );
            end
            C_ChatInfo.SendAddonMessage ( prefix , msg , type );
        end
    end
end

--------------------------------
---- LIVE MESSAGE SCRIPTS ------
--------------------------------

-- Method:          GRMsync.CheckJoinDateChange ( string )
-- What it Does:    Parses the details of the message to be usable, and then uses that info to see if it is different than current info, and if it is, then enacts changes.
-- Purpose:         To sync player join dates properly.
GRMsync.CheckJoinDateChange = function( msg , sender , prefix )
    -- To avoid spamminess
    local isSyncUpdate = false;
    if prefix == "GRM_JDSYNCUP" then
        isSyncUpdate = true;
    end

    GRM_G.CheckJoinDatePattern = GRM_G.CheckJoinDatePattern or GRM.BuildComPattern ( 6 , "?" , false );

    local playerName , joinDate , finalTStamp , finalEpochStamp , epochTimeOfChange , noteDestination = GRM.ParseComMsg ( msg , GRM_G.CheckJoinDatePattern );
    finalEpochStamp = tonumber ( finalEpochStamp );
    epochTimeOfChange = tonumber ( epochTimeOfChange );

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];
    if player ~= nil then
        -- Let's see if there was a change
        if player.verifiedJoinDate[2] < epochTimeOfChange then
            -- do a null check... will be same as button text
            if player.joinDate[ #player.joinDate ] ~= nil or #player.joinDate > 0 then
                table.remove ( player.joinDate , #player.joinDate );  -- Removing previous instance to replace
                table.remove ( player.joinDateEpoch , #player.joinDateEpoch ); 
            end
            table.insert( player.joinDate , finalTStamp );     -- oldJoinDate
            table.insert( player.joinDateEpoch , finalEpochStamp ) ;   -- oldJoinDateMeta
            
            -- For sync
            player.verifiedJoinDate[1] = finalTStamp;
            player.verifiedJoinDate[2] = epochTimeOfChange;
        
            -- Gotta update the event tracker date too!
            local date = GRM.ConvertGenericTimestampToIntValues ( string.sub ( joinDate , 9 ) );
            player.events[1][1][1] = date[1];
            player.events[1][1][2] = date[2];
            player.events[1][1][3] = date[3];
            player.events[1][2] = false;  -- Gotta Reset the "reported already" boolean!
            GRM.RemoveFromCalendarQue ( player.name , 1 , nil );
        
            -- In case of Unknown
            player.joinDateUnknown = false;
        
            -- Report the updates!
            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and not isSyncUpdate then
                
                GRM.Report ( GRM.L ( "{name} updated {name2}'s Join Date." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( playerName , true ) ) );
            end
        
            -- Updating count of changes
            if isSyncUpdate then
                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                GRMsyncGlobals.upatesEach[1] = GRMsyncGlobals.upatesEach[1] + 1;
            end
            
            -- Live update if any frames visible so player does not need to close and reopen for updates.
            if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == playerName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_JoinDateText:SetText ( string.sub ( joinDate , 9 ) );
                    if GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailJoinDateButton:IsVisible() then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailJoinDateButton:Hide();                
                end
                GRM_UI.GRM_MemberDetailMetaData.GRM_JoinDateText:Show();
        
                if noteDestination == "officer" then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_noteFontString2:SetText ( joinDate );
                    GRM_UI.GRM_MemberDetailMetaData.GRM_PlayerOfficerNoteEditBox:SetText ( joinDate );
                elseif noteDestination == "public" then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_noteFontString1:SetText ( joinDate );
                    GRM_UI.GRM_MemberDetailMetaData.GRM_PlayerNoteEditBox:SetText ( joinDate );
                elseif noteDestination == "custom" then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText ( joinDate );
                end
            end
        
            if not isSyncUpdate and GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                GRM.RefreshAuditFrames ( true , true );
            end
        end
    end
end

-- Method           GRMsync.CheckPromotionDateChange ( string , string )
-- What it Does:    Checks if received info is different than current, then updates it
-- Purpose:         Data sharing between guildies carrying the addon
GRMsync.CheckPromotionDateChange = function ( msg , sender , prefix )
    -- To avoid spamminess
    local isSyncUpdate = false;
    if prefix == "GRM_PDSYNCUP" then
        isSyncUpdate = true;
    end

    GRM_G.CheckPromoDatePattern = GRM_G.CheckPromoDatePattern or GRM.BuildComPattern ( 3 , "?" , false );

    local playerName , promotionDate , epochTimeOfChange = GRM.ParseComMsg ( msg , GRM_G.CheckPromoDatePattern );
    epochTimeOfChange = tonumber ( epochTimeOfChange );
    local slimDate = GRM.GetCleanTimestamp ( promotionDate );       -- remove the timestamp

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];
    if player ~= nil then
        if player.verifiedPromoteDate[2] < epochTimeOfChange then
            player.rankHistory[#player.rankHistory][2] = slimDate;
            player.rankHistory[#player.rankHistory][3] = GRM.TimeStampToEpoch ( slimDate , true );

            -- For SYNC
            player.verifiedPromoteDate[1] = slimDate;
            player.verifiedPromoteDate[2] = epochTimeOfChange;
            player.promoteDateUnknown = false;
            
            -- Report the updates!
            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and not isSyncUpdate then
                GRM.Report ( GRM.L ( "{name} updated {name2}'s Promotion Date." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( player.name , true ) ) );
            end

            -- Updating count of changes
            if isSyncUpdate then
                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                GRMsyncGlobals.upatesEach[2] = GRMsyncGlobals.upatesEach[2] + 1;
            end

            -- If the player is on the same frames, update them too!
            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == player.name then
                if GRM_UI.GRM_MemberDetailMetaData.GRM_SetPromoDateButton:IsVisible() then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_SetPromoDateButton:Hide();
                end

                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailRankDateTxt:SetText ( GRM.L ( "Promoted:" ) .. " " .. GRM.Trim ( string.sub ( slimDate , 1 , 10) ) );
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailRankDateTxt:Show();
            end

            if not isSyncUpdate and GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                GRM.RefreshAuditFrames ( true , true );
            end

        end
    end
end

-- Method:          GRMsync.EventAddedToCalendarCheck ( string , string )
-- What it Does:    Checks to see if player has the event already in que. If it is, then remove it.
-- Purpose:         Cleanliness. If it is removed from one person's list, it is removed from all!
GRMsync.EventAddedToCalendarCheck = function ( msg , sender )

    GRM_G.CheckAddToCalendarPattern = GRM_G.CheckAddToCalendarPattern or GRM.BuildComPattern ( 3 , "?" , false );
    local name , title , index = GRM.ParseComMsg ( msg , GRM_G.CheckAddToCalendarPattern );
    index = tonumber ( index );


    if GRM.IsOnAnnouncementList ( name , index , title ) then
        -- Remove from the list
        GRM.RemoveFromCalendarQue ( name , index , title );

        -- Refresh the frame!
        if GRM_UI.GRM_RosterChangeLogFrame.GRM_EventsFrame:IsVisible() then
            GRM.RefreshAddEventFrame();
        end
        -- Send chat update info.
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
            GRM.Report ( GRM.L ( "\"{custom1}\" event added to the calendar by {name}" , GRM.GetClassifiedName ( sender , true ) , nil , nil , title ) );
        end
    end
end

-------------------------------------------
-------- ALT UPDATE COMMS -----------------
-------------------------------------------


-- Method:          GRMsync.CheckAddAltChange ( string , string , string )
-- What it Does:    Adds the alt as well to your list, if it is not already added
-- Purpose:         Additional chcecks required to avoid message spamminess, but basically to sync alt lists on adding.
GRMsync.CheckAddAltChange = function ( msg , sender , prefix )
    -- To avoid spamminess
    local isSyncUpdate = false;
    if prefix == "GRM_ALTSYNCUP" then
        isSyncUpdate = true;
    end

    GRM_G.CheckAddAltPattern = GRM_G.CheckAddAltPattern or GRM.BuildComPattern ( 3 , "?" , false );
    local name , altName , altNameEpochTime = GRM.ParseComMsg ( msg , GRM_G.CheckAddAltPattern );
    altNameEpochTime = tonumber ( altNameEpochTime );
    local abortUpdate = false;

    if name ~= altName then         -- To avoid spam message to all players...
       
        -- Verify player is not already on someone else's list...
        local isFound = false;
        local isFound2 = false;
        local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ altName ];
        
        if player ~= nil then
            if #player.alts > 0 then
                local listOfAlts = player.alts;
        
                for m = 1 , #listOfAlts do                                              -- Let's quickly verify that this is not a repeat alt add.
                    if listOfAlts[m][1] == name then                                    
                        isFound = true;
                        break;
                    end
                end
        
                -- Check if removed from list
                if not isFound then
                    for h = 1 , #player.removedAlts do
                        if player.removedAlts[h][1] == name then
                            -- match found! Let's see what is more up to date!
                            if altNameEpochTime < player.removedAlts[h][6] then
                                -- This alt update is OLDER and more outdated... this prevents update!
                                abortUpdate = true;
                            end
                            break;
                        end
                    end
                    if not abortUpdate then
                        for h = 1 , #player.alts do
                            if player.alts[h][1] == name then
                                -- match found! Let's see what is more up to date!
                                if altNameEpochTime < player.alts[h][6] then
                                    -- This alt update is OLDER and more outdated... this prevents update!
                                    abortUpdate = true;
                                end
                                break;
                            end
                        end
                    end
                end
        
            else
                player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ name ];
                if player ~= nil then
                        
                    local listOfAlts = player.alts;
                    if #listOfAlts > 0 then                                                                 -- There is more than 1 alt for new alt to be added to
                        
                        for i = 1 , #listOfAlts do                                                          -- Cycle through previously known alt names to add new on each, one by one.
                            if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ listOfAlts[i][1] ] ~= nil then
                                -- Now, make sure it is not a repeat add!
                                for m = 1 , #listOfAlts do                                              -- Let's quickly verify that this is not a repeat alt add.
                                    if listOfAlts[m][1] == altName then
                                        isFound2 = true;
                                        break;
                                    end
                                end
                            end
                            if isFound2 then
                                break;
                            end
                        end
        
                        for h = 1 , #player.removedAlts do
                            if player.removedAlts[h][1] == altName then
                                -- match found! Let's see what is more up to date!
                                if altNameEpochTime < player.removedAlts[h][6] then
                                    -- This alt update is OLDER and more outdated... this prevents update!
                                    abortUpdate = true;
                                end
                                break;
                            end
                        end
                        if not abortUpdate then
                            for h = 1 , #player.alts do
                                if player.alts[h][1] == name then
                                    -- match found! Let's see what is more up to date!
                                    if altNameEpochTime < player.alts[h][6] then
                                        -- This alt update is OLDER and more outdated... this prevents update!
                                        abortUpdate = true;
                                    end
                                    break;
                                end
                            end
                        end
                    end
                end
            end
        end
        
        if not isFound and not isFound2 and not abortUpdate then
            if isSyncUpdate then
                GRM.AddAltTest ( name , altName , true , altNameEpochTime );
            else
                GRM.AddAltTest ( name , altName , false , 0 );
            end
            C_Timer.After ( 1 , function() 
                GRM.SyncBirthdayWithNewAlt ( altName );
        
                if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and not isSyncUpdate then
                    GRM.Report ( GRM.L ( "{name} updated {name2}'s list of Alts." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( name , true ) ) );
                end
        
                -- Updating count of changes
                if isSyncUpdate then
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                    GRMsyncGlobals.upatesEach[3] = GRMsyncGlobals.upatesEach[3] + 1;
                end
        
                if not isSyncUpdate and GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                    GRM.RefreshAuditFrames ( true , true );
                end
            end);
        end
    end
end


-- Method:          GRMsync.CheckRemoveAltChange ( string , string , string )
-- What it Does:    Syncs the removal of an alt between all ONLINE players
-- Purpose:         Sync data between online players.
GRMsync.CheckRemoveAltChange = function ( msg , sender , prefix )
    -- To avoid spamminess
    local isSyncUpdate = false;
    if prefix == "GRM_REMSYNCUP" then
        isSyncUpdate = true;
    end

    GRM_G.CheckRemoveAltPattern = GRM_G.CheckRemoveAltPattern or GRM.BuildComPattern ( 3 , "?" , false );
    local name , altName , altChangeTimeStamp = GRM.ParseComMsg ( msg , GRM_G.CheckRemoveAltPattern );
    altChangeTimeStamp = tonumber ( altChangeTimeStamp );

    local count = 0;
    local abortUpdate = false;
    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local player = guildData[ name ];

    -- Checking if alt is to be removed... establishing number of alts.
    if player ~= nil then
        count = #player.alts;

        -- determine if need to abort... most recent change. Since we are going through each player sequentially, this ensures the first sync info doesn't override everyone's data if 2 player's have different pieces of info.
        if count > 0 then
            for j = 1 , count do
                if player.alts[j][1] == altName then
                    if player.alts[j][6] > altChangeTimeStamp then   -- If the player's current info is more recent (greater number = more recent epoch time), no need to remove. Sync will happen soon.
                        abortUpdate = true;
                    end
                    break;
                end
            end
        end
    end
    
    if not abortUpdate then
        
        if isSyncUpdate then
            GRM.RemoveAltTest ( altName , true , altChangeTimeStamp );
        else
            GRM.RemoveAltTest ( altName , false , 0 );
        end
        
        if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == altName then       -- If the alt being removed is being dumped from the list of alts, but the Sync person is on that frame...
            -- if main, we will hide this.
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();

            -- Now, let's hide all the alts
            player = guildData[ altName ];
            if player ~= nil then
                GRM.PopulateAltFrames ( altName );
            end
        end

        -- if alts are ZERO, it implies the person is going 1 to zero and this player was not sync'd with them in count. If
        -- alts are less, then you are ensuring that one was actually removed.
        if count == 0 or count > #guildData[name].alts then
            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and not isSyncUpdate then
                
                GRM.Report ( GRM.L ( "{name} removed {name2}'s from {custom1}'s list of Alts." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( altName , true ) , nil , GRM.GetClassifiedName ( name , true ) ) );
            end

            -- Updating count of changes
            if isSyncUpdate then
                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                GRMsyncGlobals.upatesEach[3] = GRMsyncGlobals.upatesEach[3] + 1;
            end

            if not isSyncUpdate and GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                GRM.RefreshAuditFrames ( true , true );
            end
        end
    end
end


-- Method:          GRMsync.CheckAltMainChange ( string , string )
-- What it Does:    Syncs Main selection control between players
-- Purpose:         Sync data between players LIVE
GRMsync.CheckAltMainChange = function ( msg , sender )

    GRM_G.CheckAltMainPattern = GRM_G.CheckAltMainPattern or GRM.BuildComPattern ( 2 , "?" , false );
    local name , mainName = GRM.ParseComMsg ( msg , GRM_G.CheckAltMainPattern );

    GRM.SetMainTest ( mainName , false , 0 );

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ mainName ];

    -- We need to add the timestamps our selves as well! In the main program, the timestamps are only triggered on manually clicking and adding/removing
    if player ~= nil then
        player.mainStatusChangeTime = time();
    end

    -- Need to ensure "main" tag populates correctly.
    if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
        if not GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName == mainName then
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Show();
        elseif GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName ~= mainName then
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
        end
    end

    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
        GRM.Report ( GRM.L ( "{name} set {name2} to be 'Main'" , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( mainName , true ) ) );
    end

    if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
        GRM.RefreshAuditFrames ( true , true );
    end
end


-- Method:          GRMsync.CheckMainSyncChange ( string )
-- What it Does:    Syncs the MAIN status among all online guildies who have addon installed and are proper rank
-- Purpose:         Keep player MAINS sync'd properly!
GRMsync.CheckMainSyncChange = function ( msg )

    GRM_G.CheckMainSyncPattern = GRM_G.CheckMainSyncPattern or GRM.BuildComPattern ( 3 , "?" , false );
    local mainName , mainStatus , mainChangeTimestamp = GRM.ParseComMsg ( msg , GRM_G.CheckMainSyncPattern );
    mainChangeTimestamp = tonumber ( mainChangeTimestamp );
    local abortMainChange = false;

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ mainName ];
    if player ~= nil then
        if player.mainStatusChangeTime > mainChangeTimestamp or tostring ( player.isMain ) == mainStatus then        -- if the most-recent event is my own, I will ignore the sync message.
            abortMainChange = true;
        end
    end

    if not abortMainChange then 
        if mainStatus == "true" then
            -- Set the player as Main
            GRM.SetMainTest ( mainName , true , mainChangeTimestamp );
            -- Need to ensure "main" tag populates correctly if window is open.
            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
                if not GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName == mainName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Show();
                end
            end
        else
            -- remove from being main.
            GRM.DemoteFromMainTest ( mainName );
            -- Udate the UI!
            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == mainName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
            end
        end

        -- Updating count of changes
        GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
        GRMsyncGlobals.upatesEach[4] = GRMsyncGlobals.upatesEach[4] + 1;
    end
end


-- Method:          GRMsync.CheckAltMainToAltChange ( string , string )
-- What it Does:    If a player is demoted from main to alt, it syncs that change with everyone
-- Purpose:         Sync data between players LIVE
GRMsync.CheckAltMainToAltChange = function ( msg , sender )

    GRM_G.CheckAltMainToAltPattern = GRM_G.CheckAltMainToAltPattern or GRM.BuildComPattern ( 2 , "?" , false );
    local name , mainName = GRM.ParseComMsg ( msg , GRM_G.CheckAltMainToAltPattern );

    GRM.DemoteFromMainTest ( mainName );

    if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
        if GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName == mainName then
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
        end
    end
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
        GRM.Report ( GRM.L ( "{name} has changed {name2} to be listed as an 'alt'" , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( mainName , true ) ) );
    end

    if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
        GRM.RefreshAuditFrames ( true , true );
    end
end

-- Method:          GRMsync.CheckCustomNoteChange ( string , string )
-- What it Does:    It updates the Custom Note as needed, live
-- Purpose:         Sync the information between guildies live, as well as obey the filtering rules between clients.
GRMsync.CheckCustomNoteChange = function ( msg , sender )
    -- No need to do all the work if custom note sync disabled!
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncCustomNote then

        if not GRMsyncGlobals.HalfSyncLive and string.find ( msg , "&X&" , 1 , true ) ~= nil then
            GRMsyncGlobals.HalfSyncLive = true;
            GRMsyncGlobals.HalfSyncMsgLive = string.sub ( msg , 1 , string.find ( msg , "&X&" , 1 , true ) - 1 );
        else

            GRM_G.CheckCustomNotePattern = GRM_G.CheckCustomNotePattern or GRM.BuildComPattern ( 4 , "?#" , false );
            local senderControlRankRequirement , playerName , timeStamp;
            local customNote = "";
            senderControlRankRequirement , playerName , timeStamp , msg = GRM.ParseComMsg ( msg , GRM_G.CheckCustomNotePattern );
            senderControlRankRequirement = tonumber ( senderControlRankRequirement );
            timeStamp = tonumber ( timeStamp );
            
            if GRMsyncGlobals.HalfSyncLive then
                GRMsyncGlobals.HalfSyncLive = false;
                if string.find ( msg , "&X&" , 1 , true ) ~= nil then
                    customNote = GRMsyncGlobals.HalfSyncMsgLive .. string.sub ( msg , 1 , string.find ( msg , "&X&" , 1 , true ) - 1 );
                else
                    -- Message seems to have been lost...
                    return;
                end
            else
                customNote = msg;
            end

            if customNote == "X&&X" then
                customNote = "";
            end

            -- Check for changes!
            local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];
            if player ~= nil then
                -- No need to check if this one note has sync turned off
                if player.customNote[1] then
                    -- Player identified... now we need to find out what sync restriction you have on them.
                    if senderControlRankRequirement < GRM_G.playerRankID then
                        return;
                    else
                        -- Rank restrictions are good, now let's see if the note is different!
                        if customNote ~= player.customNote[6] then
                            local oldNote = player.customNote[6];
                            player.customNote[2] = timeStamp;
                            player.customNote[3] = sender;
                            player.customNote[6] = customNote;
                            -- Handle Log reporting logic here... 
                            GRM.RecordCustomNoteChanges ( player.customNote[6] , oldNote , sender , player.name , true )
                        end
            
                        -- Update the UI proper
                        if GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:IsVisible() and playerName == GRM_G.currentName then
                            GRM_G.OriginalEditBoxValue = player.customNote[6];  -- This needs to be set to handle the OnEditFocusLost logic..
                            if customNote == "" then
                                GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText ( GRM.L ( "Click here to set Custom Notes" ) );
                                GRM_G.OriginalEditBoxValue = GRM.L ( "Click here to set Custom Notes" );
                            else
                                GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText ( player.customNote[6] );
                            end
                            GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
                        end
                    end
                end
            end
        end
    end
end

-- Method:          GRMsync.CheckCustomNoteSyncChange ( string , bool )
-- What it Does:    For use in the Retroactive non-live sync, it checks and compares custom notes and applies the most current one
-- Purpose:         For updating and syncing the custom notes!!!
GRMsync.CheckCustomNoteSyncChange = function ( msg , isReceivedSync )
    -- No need to check if sync is disable for custo notes :D
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncCustomNote then

        if not GRMsyncGlobals.HalfSyncup and string.find ( msg , "&X&" , 1 , true ) ~= nil then
            GRMsyncGlobals.HalfSyncup = true;
            GRMsyncGlobals.HalfSyncupMsg = string.sub ( msg , 1 , string.find ( msg , "&X&" , 1 , true ) - 1 );
        else

            GRM_G.CheckCustomNoteSyncPattern = GRM_G.CheckCustomNoteSyncPattern or GRM.BuildComPattern ( 5 , "~X~" , false );
            local senderControlRankRequirement , playerName , timeStamp , editorName;
            local customNote = "";
            senderControlRankRequirement , playerName , timeStamp , editorName , msg = GRM.ParseComMsg ( msg , GRM_G.CheckCustomNoteSyncPattern );
            senderControlRankRequirement = tonumber ( senderControlRankRequirement );
            timeStamp = tonumber ( timeStamp );

            if GRMsyncGlobals.HalfSyncup then
                GRMsyncGlobals.HalfSyncup = false;
                if string.find ( msg , "&X&" , 1 , true ) ~= nil then
                    customNote = GRMsyncGlobals.HalfSyncupMsg .. string.sub ( msg , 1 , string.find ( msg , "&X&" , 1 , true ) - 1 );
                else
                    -- Message seems to have been lost...
                    return;
                end
            else
                customNote = msg;
            end

            if customNote == "X&&X" then
                customNote = "";
            end

            -- Check for changes!
            local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];
            if player ~= nil then
                -- Player identified... now we need to find out what sync restriction you have on them.
                if player.customNote[1] then
                    if ( isReceivedSync and senderControlRankRequirement < GRM_G.playerRankID ) then
                        return;
                    else
                        if player.customNote[2] < timeStamp and timeStamp ~= 0 then
                            -- Rank restrictions are good, now let's see if the note is different!
                            if customNote ~= player.customNote[6] then
                                local oldNote = player.customNote[6];
                                player.customNote[2] = timeStamp;
                                player.customNote[3] = editorName;
                                player.customNote[6] = customNote;
                                -- Handle Log reporting logic here... 
                                GRM.RecordCustomNoteChanges ( customNote , oldNote , editorName , playerName , false )

                                -- Updating count of changes
                                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                                GRMsyncGlobals.upatesEach[5] = GRMsyncGlobals.upatesEach[5] + 1;
                            end
                
                            -- Update the UI proper
                            if GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:IsVisible() and playerName == GRM_G.currentName then
                                GRM_G.OriginalEditBoxValue = player.customNote[6];  -- This needs to be set to handle the OnEditFocusLost logic..
                                if customNote == "" then
                                    GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText ( GRM.L ( "Click here to set Custom Notes" ) );
                                    GRM_G.OriginalEditBoxValue = GRM.L ( "Click here to set Custom Notes" );
                                else
                                    GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:SetText ( player.customNote[6] );
                                end
                                GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Method:          GRMsync.CheckBirthdayChange ( string , string , boolean )
-- What it Does:    Checks the live received change on the Birthday details
-- Purpose:         All birthday info to be shared.
GRMsync.CheckBirthdayChange = function ( msg , sender , isFullSync )
    -- No sense in doing the work if option is disabled...
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncBDays then
        local name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
        local day = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
        local month = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
        local date = "";
        if string.sub ( msg , 1 , 1 ) ~= "?" then
            date = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        end
        local timestamp = tonumber ( string.sub ( msg , string.find ( msg , "?" ) + 1 ) );

        GRM.SetBirthday ( name , day , month , 1 , date , timestamp , true , sender , isFullSync );
    end
end

-- Method:          GRMsync.CheckBirthdayRemoveChange ( string , string )
-- What it Does:    Coordinates birthdate removal when signalled from another player
-- Purpose:         Keep birthdates aligned and live sync'd when removing as well
GRMsync.CheckBirthdayRemoveChange = function ( msg , sender )
    local result = GRM.GetWordArrayFromString ( msg , "?" );
    local name = result[1];
    local timeStamp = tonumber ( result[2] );

    GRM.ResetBirthdayForAltGroup ( name , true , timeStamp , sender );
end


-- Method:          GRMsync.CheckBanListChange ( string , string )
-- What it Does:    If a player is banned, then it broadcasts the bane to the rest of the players, so they can update their info.
-- Purpose:         It is far more useful if more than one person maintains a BAN list...
GRMsync.CheckBanListChange = function ( msg , sender )

    GRM_G.CheckBanListPattern = GRM_G.CheckBanListPattern or GRM.BuildComPattern ( 5 , "?" , false );
    local name , banAlts , reason , class , guid = GRM.ParseComMsg ( msg , GRM_G.CheckBanListPattern );

    local timeEpoch = time();
    local isAnEdit = false;

    if reason == GRM.L ( "None Given" ) then
        reason = "";
    end

    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local leftGuildData = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local player = guildData[ name ];
    
    -- First things first, let's find player!
    local isFound = false;
    local banSet = false;
    if player ~= nil then
        -- The initial ban of the player.
        isFound = true;
        if player.bannedInfo[1] then
            isAnEdit = true;
        else
            player.bannedInfo[1] = true;
        end
        player.bannedInfo[2] = timeEpoch;
        player.bannedInfo[3] = false;
        player.bannedInfo[4] = sender;
        player.reasonBanned = reason;
    
        -- Next thing is IF alts are to be banned, this will ban them all as well!
        if banAlts == "true" then
            local listOfAlts = player.alts;
            if #listOfAlts > 0 then
                for s = 1 , #listOfAlts do
                    banSet = false;
                    -- Need to search data the guildData and the nonGuildData...
                    player = guildData[ listOfAlts[s][1] ]
                    if player ~= nil and player.name ~= GRM_G.addonUser then
                        banSet = true;
                        -- Banning the alts one by one in the for loop
                        player.bannedInfo[1] = true;
                        player.bannedInfo[2] = timeEpoch;
                        player.bannedInfo[3] = false;
                        player.bannedInfo[4] = sender;
                        player.reasonBanned = reason;
                    end
    
                    -- if not found, then let's check the left players as well.
                    if not banSet then
                        player = leftGuildData[ listOfAlts[s][1] ]
                        if player ~= nil and player.name ~= GRM_G.addonUser then
    
                            -- Banning the alts one by one in the for loop
                            player.bannedInfo[1] = true;
                            player.bannedInfo[2] = timeEpoch;
                            player.bannedInfo[3] = false;
                            player.bannedInfo[4] = sender;
                            player.reasonBanned = reason;
    
                        end
                    end
                end
            end
        end
    end
    
    -- let's check the left player's on live sync
    if not isFound then
        player = leftGuildData[ name ]
        if player ~= nil then
            isFound = true;
            if player.bannedInfo[1] then
                isAnEdit = true;
            else
                player.bannedInfo[1] = true;
            end
            player.bannedInfo[2] = timeEpoch;
            player.bannedInfo[3] = false;
            player.bannedInfo[4] = sender;
            player.reasonBanned = reason;
    
            if banAlts == "true" then
                local listOfAlts = player.alts;
                if #listOfAlts > 0 then
                    for s = 1 , #listOfAlts do
                        banSet = false;
                        -- Need to search data the guildData and the nonGuildData...
                        player = guildData[ listOfAlts[s][1] ];
                        if player ~= nil and player.name ~= GRM_G.addonUser then
                            banSet = true;
                            -- Banning the alts one by one in the for loop
                            player.bannedInfo[1] = true;
                            player.bannedInfo[2] = timeEpoch;
                            player.bannedInfo[3] = false;
                            player.bannedInfo[4] = sender;
                            player.reasonBanned = reason;
                        end
    
                        -- if not found, then let's check the left players as well.
                        if not banSet then
                            player = leftGuildData[ listOfAlts[s][1] ];
                            if player ~= nil and player.name ~= GRM_G.addonUser then
    
                                -- Banning the alts one by one in the for loop
                                player.bannedInfo[1] = true;
                                player.bannedInfo[2] = timeEpoch;
                                player.bannedInfo[3] = false;
                                player.bannedInfo[4] = sender;
                                player.reasonBanned = reason;
                                
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- OMG, if player is still not found... this is a brand new name added
    if not isFound then
        -- Add ban of in-guild guildie with notification!!!
        if guid == "X" then
            guid = "";
        end
        local memberInfoToAdd = {};

        memberInfoToAdd.name = name                                             -- 1
        memberInfoToAdd.rankName = ( "< " .. GRM.L ( "Unknown" ) .. " >" );     -- 2
        memberInfoToAdd.rankIndex = 99;                                         -- 3 (It needs to be 1 less to match when compared to the guildRosterInfo call )
        memberInfoToAdd.level = 1;                                              -- 4
        memberInfoToAdd.note = "";                                              -- 5
        if GRM.CanViewOfficerNote() then -- Officer Note permission to view.
            memberInfoToAdd.officerNote = "";                                   -- 6
        else
            memberInfoToAdd.officerNote = nil; -- Set Officer note to nil if needed due to memberInfoToAdd not being able to view. - If it is set to "" then memberInfoToAdd will think it is changing.
        end
        memberInfoToAdd.class = class;                                          -- 7
        memberInfoToAdd.lastOnline = 1;                                         -- 8 Time since they last logged in in hours.
        memberInfoToAdd.zone = "";                                              -- 9
        memberInfoToAdd.achievementPoints = 100;                                -- 10    
        memberInfoToAdd.isMobile = false;                                       -- 11
        memberInfoToAdd.rep = 4;                                                -- 12
        memberInfoToAdd.isOnline = false;                                       -- 13
        memberInfoToAdd.status = 0;                                             -- 14
        memberInfoToAdd.GUID = guid;                                            -- 15
        memberInfoToAdd.race = "";                                              -- 16
        memberInfoToAdd.sex = 1;                                                -- 17
        memberInfoToAdd.rosterSelection = 0;                                    -- 18
        
        GRM.AddMemberToLeftPlayers ( memberInfoToAdd , time() , time() - 5000 , sender );
        -- Now, let's implement the ban!
        player = leftGuildData[ name ];
        if player ~= nil then
            player.bannedInfo[1] = true;
            player.bannedInfo[2] = timeEpoch;
            player.bannedInfo[3] = false;
            player.bannedInfo[4] = sender;
            player.reasonBanned = reason;
        end
    
    end
    
    -- Add ban info to the log.
    local classCode = GRM.GetClassColorRGB ( class , true );
    local bannedName = classCode .. GRM.SlimName ( name ) .. "|r";
    local banningName = GRM.GetClassifiedName ( sender , true );
    
    local banAllAlts = false;
    if banAlts == "true" then
        banAllAlts = true;
    end
    local logEntryWithTime , logEntry = GRM.GetBanLogUpdateAndEditString ( banAllAlts , isAnEdit , banningName , bannedName , reason , select ( 2 , GRM.GetTimestamp() ) );
    GRM.AddLog ( { 20 , logEntryWithTime , banAllAlts , isAnEdit , banningName , bannedName , reason , select ( 2 , GRM.GetTimestamp() ) } );
    
    -- Report the change to chat window...
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser]["toChat"].banned then
        GRM.Report ( logEntry );
    end
    
    if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
        GRM.BuildLogComplete( true , true );
    end
    
    -- Refresh Frames!
    if GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame:IsVisible() then
        GRM.RefreshBanListFrames();
    end
end

-- Method:          GRMsync.CheckUnbanListChangeLive()
-- What it Does:    Removes the given player from the ban list
-- Purpose:         to sync ban information live. Of note, I NEED to build all the for loops here because the timestamps must be compared.
GRMsync.CheckUnbanListChangeLive = function ( msg , sender )
    local name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
    local isInGuild = false;

    -- The other method is built for all the logic...
    GRM.BanListUnban ( name , sender );

    -- Message
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
        if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][name] ~= nil then
            isInGuild = true;
        end
        if not isInGuild then
            name = GRM.GetClassifiedName ( name , true )
        else
            name = GRM.GetStringClassColorByName ( name ) .. GRM.SlimName ( name ) .. "|r"
        end

        local logReportWithTime , logReport = GRM.GetUnBanString ( GRM.GetClassifiedName ( sender , true ) , name , select ( 2 , GRM.GetTimestamp() ) );

        GRM.AddLog ( { 21 , logReportWithTime , GRM.GetClassifiedName ( sender , true ) , name , select ( 2 , GRM.GetTimestamp() ) } );

        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser]["toChat"].banned then
            GRM.Report ( logReport );
        end

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
            GRM.BuildLogComplete( true , true );
        end
    end
end

-- Method:          GRMsync.BanManagementPlayersThatLeft ( string , string , sender )
-- What it Does:    Bans or Unbans a player on the "PlayersThatLeft" global save file
-- Purpose:         Syncing bans and unbans between players...
GRMsync.BanManagementPlayersThatLeft = function ( msg , prefix , sender )
    -- To avoid spamminess
    local isSyncUpdate = false;
    if prefix == "GRM_BANSYNCUP" then
        isSyncUpdate = true;
    end

    GRM_G.CheckBanManagementPattern = GRM_G.CheckBanManagementPattern or GRM.BuildComPattern ( 5 , "?" , false );
    local name , timeStampEpoch , banStatus , reason , personWhoBanned = GRM.ParseComMsg ( msg , GRM_G.CheckBanManagementPattern );
    timeStampEpoch = tonumber ( timeStampEpoch );

    local abortBanChange = false;
    local banner = personWhoBanned;

    if personWhoBanned == "X" then
        personWhoBanned = sender;
        banner = "";
    end

    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local leftGuildData = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local player = leftGuildData[ name ];
    
    if reason == GRM.L ( "No Reason Given" ) then
        reason = "";
    end

    local isFound = false;
    local isAnEdit = false;

    if player ~= nil then
        isFound = true;
        if ( banStatus == "ban" and ( not player.bannedInfo[1] or ( player.bannedInfo[1] and timeStampEpoch > player.bannedInfo[2] ) ) ) or ( banStatus == "unban" and player.bannedInfo[1] ) then
            -- Ok, let's see if it is a ban or an unban!
            if banStatus == "ban" then
                isAnEdit = false;
                if ( banStatus == "ban" and ( not player.bannedInfo[1] or ( player.bannedInfo[1] and timeStampEpoch > player.bannedInfo[2] ) ) ) then
                    isAnEdit = true;
                end
                -- if player has been unbanned, let's check timestamps to see which is more recent.
                if player.bannedInfo[3] and player.bannedInfo[2] > timeStampEpoch then
                    abortBanChange = true;
                else
                    player.bannedInfo[1] = true;
                    player.bannedInfo[2] = timeStampEpoch;
                    player.bannedInfo[3] = false;
                    player.bannedInfo[4] = banner;
                    player.reasonBanned = reason;
                end
            else
                -- Cool, player is being unbanned! "unban"
    
                if player.bannedInfo[1] and player.bannedInfo[2] > timeStampEpoch then
                    abortBanChange = true;
                else    
                    if player.bannedInfo[1] then
                        player.bannedInfo[3] = true;
                    end
                    player.bannedInfo[1] = false;
                    player.bannedInfo[2] = timeStampEpoch;
                    player.bannedInfo[4] = banner;
                    player.reasonBanned = "";
                end
            end
    
            -- Add ban info to the log.
            -- Report the updates!
            if not abortBanChange then
                
                local colorCode = GRM.GetClassColorRGB ( player.class , true );
                local tempName = colorCode .. GRM.SlimName ( name ) .. "|r";
    
                local banEditMsgWithTime , banEditMsg = GRM.GetBanStatusSyncString ( banStatus , isAnEdit , tempName , GRM.GetClassifiedName ( personWhoBanned , true ) , reason , select ( 2 , GRM.GetTimestamp() ) );
                
                GRM.AddLog ( { 21 , banEditMsgWithTime , banStatus , isAnEdit , tempName , GRM.GetClassifiedName ( personWhoBanned , true ) , reason , select ( 2 , GRM.GetTimestamp() ) } );
    
                -- Send update to chat window!
                if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and not isSyncUpdate and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser]["toChat"].banned then
                    GRM.Report ( banEditMsg );
                end
            end
        end
    end
    
    -- Player was not found, let's check current in-guild players!
    if not isFound then
        player = guildData[ name ];
        if player ~= nil then
            if ( banStatus == "ban" and ( not player.bannedInfo[1] or ( player.bannedInfo[1] and timeStampEpoch > player.bannedInfo[2] ) ) ) or ( banStatus == "unban" and player.bannedInfo[1] ) then
                isAnEdit = false;
                if ( banStatus == "ban" and ( not player.bannedInfo[1] or ( player.bannedInfo[1] and timeStampEpoch > player.bannedInfo[2] ) ) ) then
                    isAnEdit = true;
                end
                -- Ok, let's see if it is a ban or an unban!
                if banStatus == "ban" then
                    -- if player has been unbanned, let's check timestamps to see which is more recent.
                    if player.bannedInfo[3] and player.bannedInfo[2] > timeStampEpoch then
                        abortBanChange = true;
                    else
                        player.bannedInfo[1] = true;
                        player.bannedInfo[2] = timeStampEpoch;
                        player.bannedInfo[3] = false;
                        player.bannedInfo[4] = banner;
                        player.reasonBanned = reason;
                    end
                else
                    -- Cool, player is being unbanned! "unban"
    
                    if player.bannedInfo[1] and player.bannedInfo[2] > timeStampEpoch then
                        abortBanChange = true;
                    else    
                        if player.bannedInfo[1] then
                            player.bannedInfo[3] = true;
                        end
                        player.bannedInfo[1] = false;
                        player.bannedInfo[2] = timeStampEpoch;
                        player.bannedInfo[4] = banner;
                        player.reasonBanned = "";
                    end
                end
    
                -- Add ban info to the log.
                -- Report the updates!
                if not abortBanChange then
                    local colorCode = GRM.GetClassColorRGB ( player.class , true );
                    local tempName = colorCode .. GRM.SlimName ( name ) .. "|r";
                    
                    local banEditMsgWithTime , banEditMsg = GRM.GetBanStatusSyncString ( banStatus , isAnEdit , tempName , GRM.GetClassifiedName ( personWhoBanned , true ) , reason , select ( 2 , GRM.GetTimestamp() ) );
                    
                    GRM.AddLog ( { 21 , banEditMsgWithTime , banStatus , isAnEdit , tempName , GRM.GetClassifiedName ( personWhoBanned , true ) , reason , select ( 2 , GRM.GetTimestamp() ) } );
    
                    -- Send update to chat window!
                    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and not isSyncUpdate and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser]["toChat"].banned then
                        GRM.Report ( banEditMsg );
                    end
                end
            end
        end
    end

    -- Update the live frames too!
    if GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame:IsVisible() then
        GRM.RefreshBanListFrames();
    end

end

--------------------------------
--- Default Mewsage Functions --
--------------------------------

-- Method:          GRMsync.RegisterPrefix( string )
-- What it Does:    To do an addon info send over a channel, the prefix first needs to be registered.
-- Purpose:         For player to player addon talk.
GRMsync.RegisterPrefix = function ( prefix )

    -- Prefix can't be more than 16 characters
    if #prefix > 16 then
        error ( GRM.L ( "GRM ERROR:" ) .. " " .. GRM.L ( "Unable to register prefix > 16 characters: {name}" , prefix ) );
    end
    C_ChatInfo.RegisterAddonMessagePrefix ( prefix );
end

-- Method:          GRMsync.RegisterPrefixes()
-- What it Does:    Registers the tages for all of the messages, so the addon recognizes and knows to pick them up
-- Purpose:         Prefixes need to be registered to the server to be usable for addon to addon talk.
GRMsync.RegisterPrefixes = function( listOfPrefixes )
    for i = 1 , #listOfPrefixes do 
        GRMsync.RegisterPrefix ( listOfPrefixes[i] );
    end
end

-- Method:          GRMsync.IsPrefixVerified ( string )
-- What it Does:    Returns true if received prefix is listed in this addon's
-- Purpose:         Control the spam in case of other prefixes received from other addons in guild channel.
GRMsync.IsPrefixVerified = function( prefix )
    local result = false;
    for i = 1 , #GRMsyncGlobals.listOfPrefixes do
        if GRMsyncGlobals.listOfPrefixes[i] == prefix then
            result = true;
            break;
        end
    end
    return result;
end



-------------------------------
-------------------------------
------ SYNC ALGORITHM ---------
-------------------------------
------ RETROACTIVE SYNC -------
-------------------------------
-------------------------------

------------PSUEDO-------------
----- HASH FUNCTIONS FOR ------
---- COMPARISON EFFICIENCY ----
-------------------------------

-- Method:          GRMsync.GetCustomPseudoHash()
-- What it Does:    Checks the database and creates an array of values representing sections of the database...
-- Purpose:         Player A creates their values, player B creates theirs, they are compared, the sections not equal are the portions that need to be sync'd.
-- Note:            Cust note has some limits due to the extra tighter sync throttles that are unique to each player and thus it is still only broken into incrememnts appropriate for it.
GRMsync.GetCustomPseudoHash = function()
    local guildData = GRMsyncGlobals.guildData;
    local leftData = GRMsyncGlobals.formerGuildData;
    local monthEnum = { Jan = 1 , Feb = 2 , Mar = 3 , Apr = 4 , May = 5 , Jun = 6 , Jul = 7 , Aug = 8 , Sep = 9 , Oct = 10 , Nov = 11 , Dec = 12 };
    local jd1 , pd1 , alt1 , main1 , ban1 , cust1 , bday1 = 0 , 0 , 0 , 0 , 0 , 0 , 0;
    local jd2 , pd2 , alt2 , main2 , ban2 , cust2 , bday2 = {} , {} , {} , {} , {} , {} , {};
    
    local date = "";
    local guidVal = 0;
    local byteVal = 0;

    local day = 0;
    local month = 0;
    local year = 0;

    local getHashPrecision = function ( rNum1 , rString2 )
        table.insert ( rString2 , tostring ( rNum1 ) );
        rNum1 = 0;          -- reset the count
        return rNum1 , rString2;
    end

    local player;
    for i = 1 , #guildData do
        player = guildData[i];

        byteVal = GRM.ConvertStringToVal ( player.name );                  -- Get the byte of the first character of the first name... Adds increased uniqueness to the string
        guidVal = GRM.ConvertGUIDToVal ( player.GUID );

        -- JD data
        if not player.joinDateUnknown and #player.joinDate > 0 and player.verifiedJoinDate[1] ~= "" and player.verifiedJoinDate[1] ~= nil and player.verifiedJoinDate[2] ~= 978375660 then
            date = player.verifiedJoinDate[1];
            
            day = tonumber ( string.sub ( date , 1 , string.find ( date , " " ) - 1 ) );
            month = monthEnum[string.sub ( date , string.find ( date , " " ) + 1 , string.find ( date , " " ) + 3 ) ];
            year = tonumber ( string.sub ( date , string.find ( date , "'" ) + 1 , string.find ( date , "'" ) + 2 ) );
            jd1 = jd1 + day + month + year + byteVal + guidVal;
            -- This adds the day + 2-digit year + byte value of name + guid 3-digit byte val
        end
        jd1 , jd2 = getHashPrecision ( jd1 , jd2 );

        -- PD data
        if not player.promoteDateUnknown and player.verifiedPromoteDate[1] ~= "" and player.verifiedPromoteDate[1] ~= nil and player.verifiedPromoteDate[2] ~= 978375660 then
            date = player.verifiedPromoteDate[1];

            day = tonumber ( string.sub ( date , 1 , string.find ( date , " " ) - 1 ) );
            month = monthEnum[string.sub ( date , string.find ( date , " " ) + 1 , string.find ( date , " " ) + 3 ) ];
            year = tonumber ( string.sub ( date , string.find ( date , "'" ) + 1 , string.find ( date , "'" ) + 2 ) );

            pd1 = pd1 + day + month + year + byteVal + guidVal;
            -- This adds the day + monthIndex + 2-digit year + byte value
        end

        pd1 , pd2 = getHashPrecision ( pd1 , pd2 );

        -- Alt Add Data
        if #player.alts > 0 then
            for j = 1 , #player.alts do
                alt1 = alt1 + string.byte ( player.alts[j][1] ) + string.byte ( string.sub ( player.alts[j][1] , #player.alts[j][1] ) ) + #player.alts[j][1]; -- add first and last char bytes + char byte + length
            end
            alt1 = alt1 + byteVal + guidVal;
        end
        alt1 , alt2 = getHashPrecision ( alt1 , alt2 );

        -- Main Data
        if player.isMain then
            main1 = main1 + byteVal + guidVal;
            -- This adds the first name byte value, the index value of their class, and the value of player rank
        end
        main1 , main2 = getHashPrecision ( main1 , main2 );

        -- Ban Data
        if player.bannedInfo[1] then
            -- player is banned and still in the guild.
            ban1 = ban1 + byteVal + guidVal;
        end

        -- Custom Note Data
        if #player.customNote[6] > 0 then
            cust1 = cust1 + GRM.ConvertStringToVal ( player.customNote[3] ) + #player.customNote[6] + byteVal;
        end
        cust1 , cust2 = getHashPrecision ( cust1 , cust2 );
        
        -- Bday Data
        if player.events[2][4] > 0 then
            bday1 = bday1 + player.events[2][1][1] + player.events[2][1][2] + byteVal;
        end
        bday1 , bday2 = getHashPrecision ( bday1 , bday2 );
    end

    -- Add the remaining ban data
    for i = 1 , #leftData do
            player = leftData[i];
            if player.bannedInfo[1] then
                byteVal = GRM.ConvertStringToVal ( player.name );                  -- Get the byte of the first character of the first name... Adds increased uniqueness to the string
                ban1 = ban1 + byteVal;
            end
    end
    table.insert ( ban2 , ban1 );

    return { jd2 , pd2 , alt2 , main2 , ban2 , cust2 , bday2 };
end

-- Method:          GRMsync.BuildMessagePreCheck()
-- What it Does:    Compiles the hash into an array of strings
-- Purpose:         To create a format for comparison for easy sending.
GRMsync.BuildMessagePreCheck = function()
    local values = GRMsync.GetCustomPseudoHash();
    local tags = { "JD" , "PD" , "ALT" , "MAIN" , "BAN" , "CUST" , "BDAY" };
    local result = {};
    local temp = "";
    local preTemp = "";
    local commMsgHeader = GRM_G.PatchDayString .. "?GRM_PHASH?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1] .. "?";
    local c;

    for i = 1 , #values do

        -- new DB item
        c = 1;
        result[i] = {};

        while c <= #values[i] do

            -- new comms msg
            temp = "";
            if i == 5 then
                preTemp = commMsgHeader .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) .. "?" .. tags[i] .. "?";
            else
                preTemp = commMsgHeader .. tags[i] .. "?";
            end

            for j = c , #values[i] do
                preTemp = preTemp .. values[i][j] .. "?";

                if ( #preTemp + GRMsyncGlobals.sizeModifier ) < 255 then
                    c = c + 1;
                    temp = preTemp;
                else
                    break;
                end
            end
            table.insert ( result[i] , temp );
        end

    end

    return result;
end

-- Method:          GRMsync.BuildLeaderPreCheckString()
-- What it Does:    Builds a string for the sync leader a lighter representation of which blocks to to consider
-- Purpose:         When minimal data is sent from the player to the sync leader, it is wise for the sync leader to also know which blocks need to be checked
--                  so it doesn't scan through the full database looking for the comparisons. This sends back a representation of which blocks to send.
GRMsync.BuildLeaderPreCheckString = function()
    local tags = { "JD" , "PD" , "ALT" , "MAIN" , "BAN" , "CUST" , "BDAY" };
    local result = {};
    local temp = "";
    local preTemp = "";
    local value = 0;
    local c;    -- count
    local commMsgHeader = GRM_G.PatchDayString .. "?GRM_PHASHL?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.DesignatedLeader .. "?";

    for i = 1 , #GRMsyncGlobals.DatabaseMarkers do
        c = 1;  -- new Database item, let's reset the count
        result[i] = {};

        while c <= #GRMsyncGlobals.DatabaseMarkers[i] do
            -- new comm msg
            temp = "";
            preTemp = commMsgHeader .. tags[i] .. "?";

            for j = c , #GRMsyncGlobals.DatabaseMarkers[i] do
                if GRMsyncGlobals.DatabaseMarkers[i][j] then
                    value = 1;
                else
                    value = 0;
                end
                preTemp = preTemp .. tostring ( value );

                if ( #preTemp + GRMsyncGlobals.sizeModifier ) < 255 then
                    c = c + 1;
                    temp = preTemp;
                else
                    break;
                end
            end
            table.insert ( result[i] , temp );
        end
    end
    return result;
end

-- Method:          GRMsync.SendLeaderDatabaseMarkers( table )
-- What it Does:    Builds the strings and sends them for the sync leader to compare
-- Purpose:         No need for the leader to process everything in terms of database block markers when you already have. Just sends the results.
GRMsync.SendLeaderDatabaseMarkers = function( markers )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local databaseMarkers = markers or GRMsync.BuildLeaderPreCheckString();
    for i = GRMsyncGlobals.preCheckControl[1] , #databaseMarkers do
        for j = GRMsyncGlobals.preCheckControl[2] , #databaseMarkers[i] do

            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #databaseMarkers[i][j] + GRMsyncGlobals.sizeModifier;

            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;
                GRMsyncGlobals.preCheckControl[1] = i;
                GRMsyncGlobals.preCheckControl[2] = j;
                GRMsyncGlobals.SyncCount = 0; 
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendLeaderDatabaseMarkers ( databaseMarkers );
                end);       -- Add a delay on packet sending.
                return;
            else
                GRMsync.SendMessage ( "GRM_SYNC" , databaseMarkers[i][j] , GRMsyncGlobals.channelName );
            end
        end
        GRMsyncGlobals.preCheckControl[2] = 1;
    end
    GRMsyncGlobals.syncTempDelay = false;
    GRMsyncGlobals.preCheckControl = { 1 , 1 };
    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_PHASHL?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.DesignatedLeader .. "?FINISH?" , GRMsyncGlobals.channelName );
end

-- Method:          GRMsync.SendNonLeaderDatabaseMarkers( table )
-- What it Does:    Builds the strings and sends them for the non sync leader to compare
-- Purpose:         Efficiency
GRMsync.SendNonLeaderDatabaseMarkers = function ( markers )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local databaseMarkers = markers or GRMsync.BuildMessagePreCheck();
    for i = GRMsyncGlobals.preCheckControl[1] , #databaseMarkers do
        for j = GRMsyncGlobals.preCheckControl[2] , #databaseMarkers[i] do

            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #databaseMarkers[i][j] + GRMsyncGlobals.sizeModifier;

            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;
                GRMsyncGlobals.preCheckControl[1] = i;
                GRMsyncGlobals.preCheckControl[2] = j;
                GRMsyncGlobals.SyncCount = 0; 
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendNonLeaderDatabaseMarkers ( databaseMarkers );
                end);       -- Add a delay on packet sending.
                return;
            else
                GRMsync.SendMessage ( "GRM_SYNC" , databaseMarkers[i][j] , GRMsyncGlobals.channelName );
            end
        end
        GRMsyncGlobals.preCheckControl[2] = 1;
    end
    GRMsyncGlobals.syncTempDelay = false;
    GRMsyncGlobals.preCheckControl = { 1 , 1 };
    if not GRMsyncGlobals.errorCheckEnabled then
        GRMsyncGlobals.errorCheckEnabled = true;
        C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );
    end
    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_PHASH?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1] .. "?FINISH?" , GRMsyncGlobals.channelName );
    
end

-- Method:          GRMsync.BuildLeaderDatabaseMarkers ( string )
-- What it Does:    Takes the string of received values usually like "JD?10101010111001", parses out that tag, converts the string of numebrs into an array, converts 1 to true, and 0 to false
--                  and then sets the Sync leaders DatabaseMarkers appropriately
-- Purpose:         So the sync leader can also see what is needed to be compared without needeing to reprocess all.
GRMsync.BuildLeaderDatabaseMarkers = function( received )
    local tagEnum = { JD = 1 , PD = 2 , ALT = 3 , MAIN = 4 , BAN = 5 , CUST = 6 , BDAY = 7 };
    local index = tagEnum [ string.sub ( received , 1 , string.find ( received , "?" ) - 1 ) ];
    received = string.sub ( received , string.find ( received , "?" ) + 1 );

    local DBresults = GRM.ConvertStringNumArrayToBoolArray ( GRM.StringToCharArray ( received ) );
  
    if not GRMsyncGlobals.DatabaseMarkers[index] then
        GRMsyncGlobals.DatabaseMarkers[index] = {};
    end

    -- merge the tables
    for i = 1 , #DBresults do
        table.insert ( GRMsyncGlobals.DatabaseMarkers[index] , DBresults[i] );
    end
end

-- Method:          GRMsync.SetReceivedHashValue ( string )
-- What it Does:    Converts the received sendAddonMessage string to an array of the values
-- Purpose:         For easier comparison of own database to received.
GRMsync.SetReceivedHashValue = function ( hashReceived )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local resultReceived = {};
    local tagEnum = { JD = 1 , PD = 2 , ALT = 3 , MAIN = 4 , BAN = 5 , CUST = 6 , BDAY = 7 };
    local index = tagEnum [ string.sub ( hashReceived , 1 , string.find ( hashReceived , "?" ) - 1 ) ];
    hashReceived = string.sub ( hashReceived , string.find ( hashReceived , "?" ) + 1 );

    while string.find ( hashReceived , "?" ) ~= nil do
        table.insert ( resultReceived , string.sub ( hashReceived , 1 , string.find ( hashReceived , "?" ) - 1 ) );
        hashReceived = string.sub ( hashReceived , string.find ( hashReceived , "?" ) + 1 );
    end
    
    if not GRMsyncGlobals.HashValuesReceived[index] then
        GRMsyncGlobals.HashValuesReceived[index] = {};
    end

    -- merging the tables
    for i = 1 , #resultReceived do
        table.insert ( GRMsyncGlobals.HashValuesReceived[index] , resultReceived[i] );
    end
end

-- Method:          GRMsync.CompareDatabaseMarkers()
-- What it Does:    Builds Boolean arrays for database comparison marks... True = database section the same; False = database section needs syncup
-- Purpose:         Improve sync performance.
GRMsync.CompareDatabaseMarkers = function ()
    local temp = {};
    local HashValuesMine = GRMsync.GetCustomPseudoHash();
    local isSame = false;
    local result = {};

    for i = 1 , #HashValuesMine do
        temp = {};
        if i ~= 5 or ( i == 5 and GRM_G.playerRankID <= GRMsyncGlobals.senderBanRankReq and GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) then

            for j = 1 , #HashValuesMine[i] do
                isSame = false;

                    if GRMsyncGlobals.HashValuesReceived[i][j] ~= nil then
                        if GRMsyncGlobals.HashValuesReceived[i][j] == tostring ( HashValuesMine[i][j] ) then
                            isSame = true;
                        end
                    else
                        isSame = true;      -- technically not true, but we are missing a value here so impossible to know and to check would cause an error. Possible player joined right in the middle of this check.
                    end

                table.insert ( temp , isSame );
            end

        elseif i == 5 then
            table.insert ( temp , true );
        end
        result[i] = temp;
    end
    return result;
end

-- Method:          GRMsync.SyncIsNecessary()
-- What it Does:    It initializes the database markers for knowing where to send the data, and returns true if sync is necessary
-- Purpose:         Kick start refined sync algorithm for improved speed.
GRMsync.SyncIsNecessary = function()
    GRMsyncGlobals.DatabaseMarkers = GRMsync.CompareDatabaseMarkers();
    return GRMsync.SyncProgressInitialize();
end

-- Method:          GRMsync.SyncProgressInitialize()
-- What it Does:    Initializes the SyncProgress array which is a boolean gate for each section to sync
-- Purpose:         Efficiency in syncing data of course!
GRMsync.SyncProgressInitialize = function()
    local result = false;

    for i = 1 , #GRMsyncGlobals.DatabaseMarkers do

        if i ~= 5 or ( i == 5 and ( ( GRMsyncGlobals.IsElectedLeader and GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) or ( not GRMsyncGlobals.IsElectedLeader and GRM_G.playerRankID <= GRMsyncGlobals.senderBanRankReq ) ) ) then

            for j = 1 , #GRMsyncGlobals.DatabaseMarkers[i] do
                if not GRMsyncGlobals.DatabaseMarkers[i][j] then
                    result = true;
                    GRMsyncGlobals.SyncProgress[i] = true;
                    break;
                end
            end

        end
    end
    return result;
end

-- Method:          GRMsync.NextSyncStep()
-- What it Does:    Activates the appropriate sync data packet dump collection, for time saving.
-- Purpose:         Cleanly execute sharing and syncing data in a minimalistic way.
GRMsync.NextSyncStep = function( nextStep )
    local actions = { GRMsync.SendJDPackets , GRMsync.SendPDPackets , GRMsync.SendAddAltPackets , GRMsync.SendMainPackets,
                    GRMsync.SendBANPackets , GRMsync.SendCustomNotePackets , GRMsync.SendBDayPackets , GRMsync.SendCompletionMsg }
    for i = nextStep , #GRMsyncGlobals.SyncProgress do
        if GRMsyncGlobals.SyncProgress[i] then
            if GRM_G.DebugEnabled then
                if i == 1 then
                    GRM.Report ("Sending JD")
                elseif i == 2 then
                    GRM.Report ("Sending PD")
                elseif i == 3 then
                    GRM.Report ("Sending Alt")
                elseif i == 4 then
                    GRM.Report ("Sending Main")
                elseif i == 5 then
                    GRM.Report ("Sending Ban")
                elseif i == 6 then
                    GRM.Report ("Sending Cust")
                elseif i == 7 then
                    GRM.Report ("Sending bday")
                else
                    GRM.Report ("Done Sending")
                end
            end

            if i == 5 then
                GRMsyncGlobals.SyncCountBan = GRM.GetNumStoredFormerMembers ( GRM_G.guildName , GRM_G.F );
                GRMsyncGlobals.SyncCount7 = GRM.GetNumGuildiesInGuild ( GRM_G.guildName , GRM_G.F );
            elseif i == 6 then
                if GRM.IsAnyCustomNoteLarge() then
                    if  GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessage then
                        GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessageModifier1;
                    end
                end
            end
            actions[i]();
            break;
        end
    end
end

-- Method:          GRMsync.BuildDatabaseCheckArray ( int )
-- What it Does:    Builds an array of int integers that will be used to cycle through the database on what needs to be checked
-- Purpose:         Efficiently sync data
GRMsync.BuildDatabaseCheckArray = function ( index )
    local result = {};

    if GRMsyncGlobals.DatabaseMarkers[index] ~= nil and #GRMsyncGlobals.DatabaseMarkers[index] ~= nil then
        for i = 1 , #GRMsyncGlobals.DatabaseMarkers[index] do
            if not GRMsyncGlobals.DatabaseMarkers[index][i] then
                table.insert ( result , i );
            end
        end
    -- else
    --     GRM.Report ( "Please report this error to GRM Creator. In-Combat error, unable to pull some data from server during sync." ); This is a theoretical circumstance where player is in the middle of a sync, does a call to server to build a profile for a player no longer in the guild but they are on a ban list (received from a nother), and then the server fails to deliver anything due to being in combat. In theory I could just sync all the metadata from the other player, but I was saving the comms channels by just having them query the server for it with the given GUID. However, if in combat for some reason the server returns a nil. It's sort of an edge case however since sync typically occurs shortly after logging in and most people don't need to join
    end
    return result;
end

-- Method:          GRMsync.BuildFullCheckArray()
-- What it Does:    Compiles the full array of int values representing exact database indexes.
-- Purpose:         Sync efficiency!!!
GRMsync.BuildFullCheckArray = function()
    for i = 1 , 7 do
        if i == 5 then
            GRMsyncGlobals.DatabaseExactIndexes[i] = nil;
        else
            GRMsyncGlobals.DatabaseExactIndexes[i] = GRMsync.BuildDatabaseCheckArray(i);
        end
    end
end

-- Method:          GRMsync.SendCompletionMsg()
-- What it Does:    Builds a message to be sent to the sync Leader which states the player is done sending data, and it sends which types it sent over, thus keeping the analysis lean
-- Purpose:         Speed speed SPEED!!!
GRMsync.SendCompletionMsg = function()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    -- This string is reordered for legacy code reasons in change 1.50 that I just do not wish to have to restructure. Minor adaptation
    local result = tostring ( GRMsyncGlobals.SyncProgress[1] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[2] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[5] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[4] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[3] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[6] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[7] ) .. "?";
    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_STOP?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. result  , GRMsyncGlobals.channelName );
    -- Need to Disable error checking now as you will stop communicating with the designated leader
    GRMsyncGlobals.dateSentComplete = true;
end


---------------------------------------
------- END OF HAS CONTROL LOGIC ------
---------------------------------------

-------------------------------
---- ITERATING CONTROLS -------
-------------------------------

GRMsync.storeTablePosition = function ( dataTable )
    local k, v = nil, nil;
    return function()
        k, v = next ( dataTable , k );
        return k, v;
    end
end


-------------------------------
------- NON-LEADER FORWARD ----
-------------------------------
-- Method:          GRMsync.SendJDPackets()
-- What it Does:    Broadcasts to the leader all join date information
-- Purpose:         Data sync
GRMsync.SendJDPackets = function()
    if time() - GRMsyncGlobals.SyncJDDelay >= 0.9 then
        GRMsyncGlobals.SyncJDDelay = time();
        -- Initiate Data sending
        GRMsyncGlobals.dateSentComplete = false;
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        -- Messages need to be throttled, but sending them under controls.
        local syncRankFilter = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end
        local syncMessage = GRM_G.PatchDayString .. "?GRM_JDSYNC?" .. syncRankFilter;
        local tempMessage = "";
        local messageReady;
        local guildData = GRMsyncGlobals.guildData;
        local hasAtLeastOne = false;
        local dataIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    
        for i = GRMsyncGlobals.SyncCountJD , #dataIndexes[1] do
            messageReady = false;
            if GRMsyncGlobals.SyncOK then
                
                if guildData[dataIndexes[1][i]].verifiedJoinDate[2] ~= 0 then
                    hasAtLeastOne = true;
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?" .. guildData[dataIndexes[1][i]].name .. "?" .. guildData[dataIndexes[1][i]].verifiedJoinDate[2] .. "?" .. guildData[dataIndexes[1][i]].verifiedJoinDate[1];

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == #dataIndexes[1] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_JDSYNC?" .. syncRankFilter .. "?" .. guildData[dataIndexes[1][i]].name .. "?" .. guildData[dataIndexes[1][i]].verifiedJoinDate[2] .. "?" .. guildData[dataIndexes[1][i]].verifiedJoinDate[1];
                            -- Need to send it out as it will not re-loop
                            if i == #dataIndexes[1] then
                                syncMessage = tempMessage;
                            end
                        end
                    end
                end

                -- Send message
                if messageReady or ( hasAtLeastOne and i == #dataIndexes[1] ) then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                    syncMessage = tempMessage;
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;
                    GRMsyncGlobals.SyncCountJD = i;
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendJDPackets );       -- Add a delay on packet sending.
                    return;
                end
            end
        end
        -- Close the Data stream
        GRMsyncGlobals.SyncCountJD = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 2 );
        end
    end
end

-- Method:          GRMsync.SendPDPackets()
-- What it Does:    Broadcasts to the leader all promo date information
-- Purpose:         Data sync
GRMsync.SendPDPackets = function()
    if time() - GRMsyncGlobals.SyncPDDelay >= 0.9 then
        GRMsyncGlobals.SyncPDDelay = time();
        -- Initiate Data sending
        GRMsyncGlobals.TimeSinceLastSyncAction = time();
    
        -- Messages need to be throttled, but sending them under controls.
        local syncRankFilter = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end
        local syncMessage = GRM_G.PatchDayString .. "?GRM_PDSYNC?" .. syncRankFilter;
        local tempMessage = "";
        local messageReady;
        local guildData = GRMsyncGlobals.guildData;
        local hasAtLeastOne = false;
        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

        for i = GRMsyncGlobals.SyncCountPD , #exactIndexes[2] do
            messageReady = false;
            if GRMsyncGlobals.SyncOK then

                if guildData[exactIndexes[2][i]].verifiedPromoteDate[2] ~= nil and guildData[exactIndexes[2][i]].verifiedPromoteDate[2] ~= 0 then
                    hasAtLeastOne = true;
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?" .. guildData[exactIndexes[2][i]].name .. "?" .. guildData[exactIndexes[2][i]].verifiedPromoteDate[2] .. "?" .. guildData[exactIndexes[2][i]].verifiedPromoteDate[1];

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == #exactIndexes[2] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_PDSYNC?" .. syncRankFilter .. "?" .. guildData[exactIndexes[2][i]].name .. "?" .. guildData[exactIndexes[2][i]].verifiedPromoteDate[2] .. "?" .. guildData[exactIndexes[2][i]].verifiedPromoteDate[1];
                            -- If we are in the last index it won't loop back around, so we need to send it now...
                            if i == #exactIndexes[2] then
                                syncMessage = tempMessage;
                                -- This will be sent
                            end
                        end
                    end
                end

                -- Send message
                if messageReady or ( hasAtLeastOne and i == #exactIndexes[2] ) then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                    syncMessage = tempMessage;
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;
                    GRMsyncGlobals.SyncCountPD = i;
                    GRMsyncGlobals.SyncCount = 0; 
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendPDPackets );       -- Add a delay on packet sending.
                    return;
                end
            end
        end
        
        -- Close the Data stream
        GRMsyncGlobals.SyncCountPD = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 3 );
        end
    end
end

-- Method:          GRMsync.SendAddAltPackets ()
-- What it Does:    Compartmentalizes the Add Alt logorithm to send the data controlled, fills the packets to max characters, and sends and if it hits throttle cap, resets.
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendAddAltPackets = function()
    local syncRankFilter = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
        syncRankFilter = GRMsyncGlobals.numGuildRanks;
    end
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    -- Message controls for throttle considerations and packing them fully...
    local syncMessage = GRM_G.PatchDayString .. "?GRM_ALTADDSYNC?" .. syncRankFilter;
    local tempMessage = "";
    local tempMessage2 = "";
    local tempMessage3 = "";
    local tempMessage4 = "";
    local messageReady;
    local i = GRMsyncGlobals.SyncCountAltAdd;
    local hasAtLeastOne = false;

    -- Set the tables to new memory index to prevent stutter...
    if GRMsyncGlobals.AltSendIsFinished then
        GRMsyncGlobals.TempRoster = GRM.DeepCopyArray ( GRMsyncGlobals.guildData );     -- I will be editiing this so needs to be made.
        GRMsyncGlobals.AltSendIsFinished = false;
        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendAddAltPackets );
        return;
    end
    
    if not GRMsyncGlobals.syncTempDelay2  then

        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
        -- Messages need to be throttled, but sending them under controls.
        -- Note "&" represents the start of a new toon's alts list in the same string.
        while i <= #exactIndexes[3] do
            messageReady = false;
            if GRMsyncGlobals.SyncOK then
                if #GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts > 0 then
                    hasAtLeastOne = true
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        -- add new player
                        tempMessage = syncMessage .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name;
                        tempMessage4 = tempMessage .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[1][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[1][6] )
                        -- Add all the alts...
                        tempMessage2 = "";
                        for j = 1 , #GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts do
                            if j == 1 and ( #tempMessage4 + GRMsyncGlobals.sizeModifier ) >= 255 then
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                                tempMessage = GRM_G.PatchDayString .. "?GRM_ALTADDSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name;
                            else
                                
                                -- To temp store the value;
                                tempMessage3 = tempMessage;

                                -- Add the alt...
                                tempMessage = tempMessage .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[j][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[j][6] );

                                -- String without the header for carryover.
                                tempMessage2 = tempMessage2 .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[j][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[j][6] );
                                
                                -- Need to check... One player might have too many alts altogether. That is ok! Just send out, reset!
                                if #tempMessage + GRMsyncGlobals.sizeModifier >= 255 then
                                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage3 + GRMsyncGlobals.sizeModifier;
                                    GRMsync.SendMessage ( "GRM_SYNC" , tempMessage3 , GRMsyncGlobals.channelName );
                                    -- reset the string
                                    tempMessage = GRM_G.PatchDayString .. "?GRM_ALTADDSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[j][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].alts[j][6] );
                                    tempMessage2 = "";
                                end
                            end
                        end
                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == #exactIndexes[3] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_ALTADDSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. tempMessage2; -- Don't need the extra "?" divider since no header...
                        end
                    end
                else
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?0";
                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == #exactIndexes[3] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_ALTADDSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?0";
                        end
                    end
                end

                -- Send message
                if messageReady or ( hasAtLeastOne and i == #exactIndexes[3] ) then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                    syncMessage = tempMessage;
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;
                    GRMsyncGlobals.SyncCountAltAdd = i;
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendAddAltPackets );       -- Add a 1 second delay on packet sending.
                    return;
                end
            end
            -- Progress the while loop
            i = i + 1;
        end
    end
    GRMsync.SendRemoveAltPackets ( syncRankFilter );
end

-- Method:          GRMsync.SendRemoveAltPackets ( int )
-- What it Does:    Compartmentalizes the Remove Alt logorithm to send the data controlled, fills the packets to max characters, and sends and if it hits throttle cap, resets.
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendRemoveAltPackets = function ( syncRankFilter )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    -- -- Removed Alts Table...
    local syncMessage = GRM_G.PatchDayString .. "?GRM_ALTREMSYNC?" .. syncRankFilter;
    local tempMessage = "";
    local tempMessage2 = "";
    local tempMessage3 = "";
    local tempMessage4 = "";
    local messageReady;
    local hasAtLeastOne = false;

    if GRMsyncGlobals.AltSendIsFinished2 then
        GRMsyncGlobals.TempRoster = nil;
        GRMsyncGlobals.TempRoster = {};
        GRMsyncGlobals.TempRoster = GRM.DeepCopyArray ( GRMsyncGlobals.guildData ); -- reset the roster
        GRMsyncGlobals.AltSendIsFinished2 = false;
        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
            GRMsync.SendRemoveAltPackets ( syncRankFilter );
        end);
        return;
    end

    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    if exactIndexes[3] == nil then
        exactIndexes[3] = {};
    end

    for i = GRMsyncGlobals.SyncCountAltRem , #exactIndexes[3] do
        messageReady = false;
        if GRMsyncGlobals.SyncOK then
            if #GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts > 0 then
                hasAtLeastOne = true;
                if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                    tempMessage = syncMessage .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name;
                    tempMessage4 = tempMessage .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[1][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[1][6] )
                    -- Add all the alts...
                    tempMessage2 = "";
                    for j = 1 , #GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts do
                        if j == 1 and ( #tempMessage4 + GRMsyncGlobals.sizeModifier ) >= 255 then
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                            tempMessage = GRM_G.PatchDayString .. "?GRM_ALTREMSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name;
                        else
                            -- To temp store the value;
                            tempMessage3 = tempMessage;

                            tempMessage = tempMessage .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[j][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[j][6] );
                            -- String without the header for carryover.
                            tempMessage2 = tempMessage2 .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[j][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[j][6] );

                            -- Need to check... One player might have too many alts removed. That is ok! Just send out, reset!
                            if #tempMessage + GRMsyncGlobals.sizeModifier >= 255 then
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage3 + GRMsyncGlobals.sizeModifier;
                                GRMsync.SendMessage ( "GRM_SYNC" , tempMessage3 , GRMsyncGlobals.channelName );
                                -- reset the string
                                tempMessage = GRM_G.PatchDayString .. "?GRM_ALTREMSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[j][1] .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].removedAlts[j][6] );
                                tempMessage2 = "";
                            end
                        end
                    end
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        syncMessage = tempMessage;
                        if i == #exactIndexes[3] then
                            messageReady = true;
                        end
                    else
                        messageReady = true;
                        -- Hold this value over...
                        tempMessage = GRM_G.PatchDayString .. "?GRM_ALTREMSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]][1] .. tempMessage2; -- Don't need the extra "?" divider since no header...
                    end
                end
            else
                if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                    tempMessage = syncMessage .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?0";
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        syncMessage = tempMessage;
                        if i == #exactIndexes[3] then
                            messageReady = true;
                        end
                    else
                        messageReady = true;
                        -- Hold this value over...
                        tempMessage = GRM_G.PatchDayString .. "?GRM_ALTREMSYNC?" .. syncRankFilter .. "?&" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?0";
                    end
                end
            end

            -- Send message
            if messageReady or ( hasAtLeastOne and #exactIndexes[3] == i ) then
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                syncMessage = tempMessage;
            end

            -- Check if there needs to be a throttled delay
            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;
                GRMsyncGlobals.syncTempDelay2 = true;
                GRMsyncGlobals.SyncCountAltRem = i;
                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendRemoveAltPackets ( syncRankFilter );
                end);
                return;
            end
        end
    end
    GRMsync.SendAltPackets();
end

-- Method:          GRMsync.SendAltPackets()
-- What it Does:    Broadcasts to the leader all ALT information
-- Purpose:         Data sync
GRMsync.SendAltPackets = function()
    GRMsyncGlobals.SyncCountAltAdd = 1;
    GRMsyncGlobals.SyncCountAltRem = 1;
    GRMsyncGlobals.syncTempDelay = false;
    GRMsyncGlobals.syncTempDelay2 = false;
    GRMsyncGlobals.AltSendIsFinished = true;
    GRMsyncGlobals.AltSendIsFinished2 = true;
    GRMsyncGlobals.TempRoster = nil;
    GRMsyncGlobals.TempRoster = {};
    if GRMsyncGlobals.SyncOK then
        GRMsync.NextSyncStep ( 4 );
    end
end

-- Method:          GRMsync.SendMainPackets()
-- What it Does:    Broadcasts to the leader all MAIN information
-- Purpose:         Data sync
GRMsync.SendMainPackets = function()
    if time() - GRMsyncGlobals.SyncMainDelay >= 0.9 then
        GRMsyncGlobals.SyncMainDelay = time();
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        -- Messages need to be throttled, but sending them under controls.
        local syncRankFilter = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end
        local syncMessage = GRM_G.PatchDayString .. "?GRM_MAINSYNC?" .. syncRankFilter;
        local tempMessage = "";
        local messageReady;
        local isPlayerMain = false;
        local hasAtLeastOne = false;

        local guildData = GRMsyncGlobals.guildData;
        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

        for i = GRMsyncGlobals.SyncCountMain , #exactIndexes[4] do
            messageReady = false;
            if GRMsyncGlobals.SyncOK then
                isPlayerMain = "false";       -- Kept as a string rather than a boolean so it can be passed as a comm over the server without needing to cast it to a string.
                if guildData[exactIndexes[4][i]].isMain then
                    isPlayerMain = "true";
                end
                if guildData[exactIndexes[4][i]].isMain or guildData[exactIndexes[4][i]].mainStatusChangeTime ~= 0 then
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?" .. guildData[exactIndexes[4][i]].name  .. "?" .. tostring ( guildData[exactIndexes[4][i]].mainStatusChangeTime) .. "?" .. isPlayerMain;

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == #exactIndexes[4] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_MAINSYNC?" .. syncRankFilter .. "?" .. guildData[exactIndexes[4][i]].name  .. "?" .. tostring ( guildData[exactIndexes[4][i]].mainStatusChangeTime) .. "?" .. isPlayerMain;

                            -- If we are in the last index it won't loop back around, so we need to send it now...
                            if i == #exactIndexes[4] then
                                syncMessage = tempMessage;
                            end
                        end
                    end
                end

                -- Send message
                if messageReady or ( hasAtLeastOne and i == #exactIndexes[4] ) then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                    syncMessage = tempMessage;
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;
                    GRMsyncGlobals.SyncCountMain = i;
                    GRMsyncGlobals.SyncCount = 0; 
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendMainPackets );       -- Add a delay on packet sending.
                    return;
                end
            end
        end
        -- Close the Data stream
        GRMsyncGlobals.SyncCountMain = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 5 );
        end
    end
end

-- Method:          GRMsync.BanPacketsThrottleControl ( int )
-- What it Does:    Re-trigger ban loop if necessary to prevent breaking throttle.
-- Purpose:         There seems to be an as yet unidentified edge case reported on the ban breaking throttle limits and I have been unable to
--                  on-hand test this with the people having the issue so this is just a brute force method layer of protection only to prevent it, as a stop-gap solution for
GRMsync.BanPacketsThrottleControl = function ( isFirst , i )
    GRMsyncGlobals.syncTempDelay = true;
    if isFirst then
        GRMsyncGlobals.SyncCountBan = i;
    else
        GRMsyncGlobals.SyncCount7 = i;
    end
    GRMsyncGlobals.SyncCount = 0;
    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendBANPackets );       -- Add a 1 second delay on packet sending.
end

-- Method:          GRMsync.SendBANPackets()
-- What it Does:    Broadcasts to the leader all Ban information
-- Purpose:         Data sync
GRMsync.SendBANPackets = function()
    if time() - GRMsyncGlobals.SyncBanDelay >= 0.9 then
        GRMsyncGlobals.SyncBanDelay = time();
        -- Initiate Data sending
        GRMsyncGlobals.TimeSinceLastSyncAction = time();
        -- For sync error check help
        local tempMsg = GRM_G.PatchDayString .. "?GRM_BANSYNC4?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. " ?";
        local guildData = GRMsyncGlobals.guildData;
        local leftGuildData = GRMsyncGlobals.formerGuildData;

        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg + GRMsyncGlobals.sizeModifier;
        GRMsync.SendMessage ( "GRM_SYNC" , tempMsg , GRMsyncGlobals.channelName );    
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncBanList then

                -- Messages need to be throttled, but sending them under controls.
            local syncMessage = GRM_G.PatchDayString .. "?GRM_BANSYNC?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList );
            local errorSyncCheckMsg = GRM_G.PatchDayString .. "?GRM_BANSYNC2?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList );
            local tempMessage = "";
            local tempMessage2 = "";
            local tempMessage3 = "";
            local messageReady;
            local timeStampOfBanChange;
            local msgTag;
            local reason = "";
            local playerWhoBanned = "";
            local errorProtectionCount = 0;
            
            for i = GRMsyncGlobals.SyncCountBan , 1 , -1 do
                messageReady = false;

                timeStampOfBanChange = tostring ( leftGuildData[i].bannedInfo[2] );
                msgTag = "ban";
                -- Let's see if someone was unbanned.
                if leftGuildData[i].bannedInfo[3] then
                    msgTag = "unban";
                elseif not leftGuildData[i].bannedInfo[1] and not leftGuildData[i].bannedInfo[3] then
                    msgTag = "noban";
                end
                
                if GRMsyncGlobals.SyncOK then
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then

                        if leftGuildData[i].reasonBanned == "" or leftGuildData[i].reasonBanned == nil then
                            reason = GRM.L ( "No Reason Given" );
                        else
                            reason = leftGuildData[i].reasonBanned;
                        end
                        if leftGuildData[i].bannedInfo[4] == "" or leftGuildData[i].bannedInfo[4] == nil then
                            playerWhoBanned = "X";
                        else
                            playerWhoBanned = leftGuildData[i].bannedInfo[4];
                        end
                        if msgTag == "ban" or msgTag == "unban" then
                            
                            -- # will represent the GRM_BanSync2 - that player needs to be added to the database...]
                            local class = leftGuildData[i].class;
                            if class == nil or class == "" then
                                class = "0";        -- zero so it is just 1 char long.
                            else
                                class = tostring ( allClassesEnum[ class ] )
                            end
                            local guid = leftGuildData[i].GUID;
                            if guid == "" or guid == nil then
                                guid = "X";
                            end

                            local oldJoinDateMeta = 0;
                            if leftGuildData[i].verifiedJoinDate[1] == "" and leftGuildData[i].rankHistory[1] ~= nil and leftGuildData[i].rankHistory[1][3] ~= nil and leftGuildData[i].rankHistory[1][3] > 0 then    -- redundancy due to old databases...
                                -- Just use the first promo date if that is the case
                                oldJoinDateMeta = leftGuildData[i].rankHistory[1][3];
                            else
                                oldJoinDateMeta = leftGuildData[i].leftGuildEpoch[#leftGuildData[i].leftGuildEpoch];    -- Just set it to the left guild Date.
                            end

                            tempMessage3 = "?#" .. leftGuildData[i].name .. "?" .. tostring ( leftGuildData[i].rankIndex ) .. "?" .. tostring ( leftGuildData[i].level ) .. "?" .. class .. "?" .. tostring ( leftGuildData[i].leftGuildEpoch[#leftGuildData[i].leftGuildEpoch] ) .. "?" .. tostring ( oldJoinDateMeta ) .. "?" .. guid .. "?&" .. leftGuildData[i].name .. "?" .. timeStampOfBanChange .. "?" .. msgTag .. "?" .. reason .. "?" .. playerWhoBanned;

                            tempMessage = syncMessage .. tempMessage3;

                            -- partial string for carryover without the header
                            tempMessage2 = tempMessage3;
                        else
                            tempMessage = syncMessage .. "?&" .. leftGuildData[i].name .. "?" .. timeStampOfBanChange .. "?" .. msgTag .. "?" .. reason .. "?" .. playerWhoBanned;

                            tempMessage2 = "?&" .. leftGuildData[i].name .. "?" .. timeStampOfBanChange .. "?" .. msgTag .. "?" .. reason .. "?" .. playerWhoBanned;                        
                        end

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == 2 then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_BANSYNC?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) .. tempMessage2;
                            -- If we are in the last index it won't loop back around, so we need to send it now...
                            if i == 2 then
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                errorProtectionCount = errorProtectionCount + 1;
                                GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.channelName );
                            end
                        end
                    else
                        -- ??
                    end

                    -- Send message
                    if messageReady then
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        errorProtectionCount = errorProtectionCount + 1;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                        syncMessage = tempMessage;
                    end

                    -- Check if there needs to be a throttled delay
                    if ( GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap ) or errorProtectionCount > 12 then
                        GRMsync.BanPacketsThrottleControl ( true , i );
                        return;
                    end
                end
            end
            -- reset values to new list...
            syncMessage = GRM_G.PatchDayString .. "?GRM_BANSYNC2?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList );
            tempMessage = "";
            -- if I get here... let's do the in-guild sync too!
            for i = GRMsyncGlobals.SyncCount7 , 1 , -1 do
                messageReady = false;

                timeStampOfBanChange = tostring ( guildData[i].bannedInfo[2] );
                msgTag = "ban";
                -- Let's see if someone was unbanned.
                if guildData[i].bannedInfo[3] then
                    msgTag = "unban";
                elseif not guildData[i].bannedInfo[1] and not guildData[i].bannedInfo[3] then
                    msgTag = "noban";
                end

                if guildData[i].bannedInfo[4] == "" or guildData[i].bannedInfo[4] == nil then
                    playerWhoBanned = "X";
                else
                    playerWhoBanned = guildData[i].bannedInfo[4];
                end

                if GRMsyncGlobals.SyncOK then
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then

                        if msgTag == "ban" or msgTag == "unban" then
                            -- % will represent the GRM_BanSync2 - that player needs to be added to the database...]
                            tempMessage = syncMessage .. "?" .. guildData[i].name .. "?" .. timeStampOfBanChange .. "?" .. msgTag .. "?" .. guildData[i].reasonBanned .. "?" .. playerWhoBanned;
                        end

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            if tempMessage ~= "" then
                                syncMessage = tempMessage;
                            end
                            if i == 2 and not ( syncMessage == errorSyncCheckMsg ) then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_BANSYNC2?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) .. "?" .. guildData[i].name .. "?" .. timeStampOfBanChange .. "?" .. msgTag .. "?" .. guildData[i].reasonBanned .. "?" .. playerWhoBanned;

                            -- If we are in the last index it won't loop back around, so we need to send it now...
                            if i == 2 and not tempMessage == ( errorSyncCheckMsg ) then
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                errorProtectionCount = errorProtectionCount + 1;
                                GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.channelName );
                            end
                        end
                    end
                    -- Send message
                    if messageReady then
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        if syncMessage ~= errorSyncCheckMsg then
                            errorProtectionCount = errorProtectionCount + 1;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                        end
                        syncMessage = tempMessage;
                    end

                    -- Check if there needs to be a throttled delay
                    if ( GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap ) or errorProtectionCount > 12 then
                        GRMsync.BanPacketsThrottleControl ( false , i );
                        return;
                    end
                end
            end
        end
        -- Close the Data stream
        GRMsyncGlobals.SyncCountBan = #GRMsyncGlobals.formerGuildData;
        GRMsyncGlobals.SyncCount7 = #GRMsyncGlobals.guildData;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 6 );
        end
    end
end

-- Method:          GRMsync.SendCustomNotePackets()
-- What it Does:    Broadcasts to the leader all CUSTOM NOTES set to sync
-- Purpose:         Data sync for custom notes!!!!
GRMsync.SendCustomNotePackets = function()
    if time() - GRMsyncGlobals.SyncCustomDelay >= 0.9 then 
        GRMsyncGlobals.SyncCustomDelay = time();
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        local syncMessage = GRM_G.PatchDayString .. "?GRM_CUSTSYNC?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankCustom;
        local tempMessage = "";
        local messageReady = false;
        local dataShouldBeSent = false;
        local guildData = GRMsyncGlobals.guildData;
        local bigMessagePart2 = "";
        local tempMsg3 = "";
        local hasAtLeastOne = false;
        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
        local customNote;

        for i = GRMsyncGlobals.SyncCountCustom , #exactIndexes[6] do
            messageReady = false;
            dataShouldBeSent = false;
            if GRMsyncGlobals.SyncOK then
                if guildData[exactIndexes[6][i]].customNote[1] and guildData[exactIndexes[6][i]].customNote[2] ~= 0 then
                    dataShouldBeSent = true;
                    hasAtLeastOne = true;
                end

                -- Expand the string more... Fill up the full 255 characters for efficiency.
                if dataShouldBeSent then

                    customNote = guildData[exactIndexes[6][i]].customNote[6];
                    if customNote == "" then
                        customNote = "X&&X";
                    end

                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?" .. guildData[exactIndexes[6][i]].customNote[4] .. "?#" .. guildData[exactIndexes[6][i]].name .. "?#" .. tostring ( guildData[exactIndexes[6][i]].customNote[2] ) .. "?#" .. guildData[exactIndexes[6][i]].customNote[3] .. "?#" .. customNote;
                        if ( #tempMessage + GRMsyncGlobals.sizeModifier < 255 ) then
                            syncMessage = tempMessage;
                            if i == #exactIndexes[6] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            tempMsg3 = GRM_G.PatchDayString .. "?GRM_CUSTSYNC?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankCustom .. "?" .. guildData[exactIndexes[6][i]].customNote[4] .. "?#" .. guildData[exactIndexes[6][i]].name .. "?#" .. tostring ( guildData[exactIndexes[6][i]].customNote[2] ) .. "?#" .. guildData[exactIndexes[6][i]].customNote[3];
                            -- Hold this value over...                            
                            if #customNote > 100 and not GRMsyncGlobals.CustomNoteLarge then
                                tempMessage = tempMsg3 .. "?#" .. string.sub ( customNote , 1 , #customNote - 50 ) .. "?^?";
                                GRMsyncGlobals.CustomNoteLarge = true;
                                bigMessagePart2 = string.sub ( customNote , #customNote - 49 ) .. "?^?";
                            else
                                tempMessage = tempMsg3 .. "?#" .. customNote;
                            end
                            -- If we are in the last index it won't loop back around, so we need to send it now...
                            if i == #exactIndexes[6] then
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.channelName );
                    
                                -- Send the 2nd part of the string if it needs to be split.
                                if GRMsyncGlobals.CustomNoteLarge then
                                    tempMessage = tempMsg3 .. "?#" .. bigMessagePart2;
                                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                    GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.channelName );
                                    GRMsyncGlobals.CustomNoteLarge = false;
                                end
                                break;
                            end
                        end
                    end

                    -- Send message
                    if ( messageReady and dataShouldBeSent ) or ( hasAtLeastOne and i == #exactIndexes[6]) then
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                        syncMessage = tempMessage;
                        -- In case custom note goes over due to larger server names - message needs to be split.
                        if GRMsyncGlobals.CustomNoteLarge then
                            -- Sending first half of the message.
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                            syncMessage = tempMsg3 .. "?#" .. bigMessagePart2;
                            -- Sending Second half of the message.
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );

                            -- Reset to base values of first loop as not carrying over any data.
                            GRMsyncGlobals.CustomNoteLarge = false;
                            tempMessage = "";
                            syncMessage = GRM_G.PatchDayString .. "?GRM_CUSTSYNC?" .. GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
                        end
                    end

                    -- Check if there needs to be a throttled delay
                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.syncTempDelay = true;
                        GRMsyncGlobals.SyncCountCustom = i;
                        GRMsyncGlobals.SyncCount = 0; 
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendCustomNotePackets );       -- Add a delay on packet sending.
                        return;
                    end
                end
            end
        end
        -- Close the Data stream
        GRMsyncGlobals.SyncCountCustom = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessageModifier1 then
            GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
        end
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 7 );
        end
    end
end

-- Method:          GRMsync.RemoveAltGroupingFromList ( miltiD-array , array )
-- What it Does:    Looks at the list of alts given and removes them from the list because they will have their data shared.
-- Purpose:         Only 1 birthday point of an alt grouping needs be shared since they sync. No need to waste resources.
GRMsync.RemoveAltGroupingFromList = function ( name , listOfAlts , list )
    -- Remove name from the list... this is all about process saving.
    for i = #list , 1 , -1 do
        if list[i] == name then
            table.remove ( list , i );
            break;
        end
    end
    for i = 1 , #listOfAlts do
        for j = #list , 1 , -1 do
            if listOfAlts[i][1] == list[j] then
                table.remove ( list , j );
                break;
            end
        end
    end
    return list;
end

-- name , day , month , date , timestamp
-- Method:          GRMsync.SendBDayPackets()
-- What it Does:    Broadcasts to the leader all CUSTOM NOTES set to sync
-- Purpose:         Data sync for custom notes!!!!
GRMsync.SendBDayPackets = function( listOfRemainingToons )
    if time() - GRMsyncGlobals.SyncBdayDelay >= 0.9 then 
        GRMsyncGlobals.SyncBdayDelay = time();
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        local syncRankFilter = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end
        local syncMessage = GRM_G.PatchDayString .. "?GRM_BDSYNC?" .. syncRankFilter;
        local tempMessage = "";
        local messageReady;
        local guildData = GRMsyncGlobals.guildData;
        local list = listOfRemainingToons or GRM.GetAllGuildiesInOrder ( true , true );     -- No need to cycle through them all, just go by alt grouping...
        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
        
        for i = GRMsyncGlobals.SyncCountBday , #exactIndexes[7] do
            for j = #list , 1 , -1 do
                if guildData[exactIndexes[7][i]].name == list[j] or ( i == #exactIndexes[7] and j == #list ) then      -- Match to the list... Alt grouping not yet found!
                    messageReady = false;
                    if GRMsyncGlobals.SyncOK then          
                        
                        -- Expand the string more... Fill up the full 255 characters for efficiency.
                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            if guildData[exactIndexes[7][i]].events[2][4] ~= 0 then
                                tempMessage = syncMessage .. "?" .. guildData[exactIndexes[7][i]].name .. "?" .. tostring ( guildData[exactIndexes[7][i]].events[2][1][1] ) .. "?" .. tostring ( guildData[exactIndexes[7][i]].events[2][1][2] ) .. "?" .. guildData[exactIndexes[7][i]].events[2][3] .. "?" .. tostring ( guildData[exactIndexes[7][i]].events[2][4] );
                                -- let's cleanup the alt grouping then shall we!
                                list = GRMsync.RemoveAltGroupingFromList ( guildData[exactIndexes[7][i]].name , guildData[exactIndexes[7][i]].alts , list );
                            end

                            if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                                if tempMessage ~= "" then
                                    syncMessage = tempMessage;
                                end

                                if i == #exactIndexes[7] and syncMessage ~= ( GRM_G.PatchDayString .. "?GRM_BDSYNC?" .. syncRankFilter ) then
                                    messageReady = true;
                                end
                            else
                                messageReady = true;
                                -- Hold this value over...
                                tempMessage = GRM_G.PatchDayString .. "?GRM_BDSYNC?" .. syncRankFilter .. "?" .. guildData[exactIndexes[7][i]].name .. "?" .. tostring ( guildData[exactIndexes[7][i]].events[2][1][1] ) .. "?" .. tostring ( guildData[exactIndexes[7][i]].events[2][1][2] ) .. "?" .. guildData[exactIndexes[7][i]].events[2][3] .. "?" .. tostring ( guildData[exactIndexes[7][i]].events[2][4] );
                                -- Need to send it out as it will not re-loop
                                if i == #exactIndexes[7] then
                                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                    GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.channelName );
                                end
                            end
                        end

                        -- Send message
                        if messageReady then
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.channelName );
                            syncMessage = tempMessage;
                        end

                        -- Check if there needs to be a throttled delay
                        if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                            GRMsyncGlobals.syncTempDelay = true;
                            GRMsyncGlobals.SyncCountBday = i;
                            GRMsyncGlobals.SyncCount = 0;
                            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()         -- Add a 1 second delay on packet sending.
                                GRMsync.SendBDayPackets ( list )
                            end);
                            return;
                        end
                    end
                    break;
                end
            end
        end

        -- Close the Data stream
        GRMsyncGlobals.SyncCountBday = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 8 );
        end
    end
end

-- Initiate Data sending
GRMsyncGlobals.dateSentComplete = false;
GRMsyncGlobals.TimeSinceLastSyncAction = time();

-------------------------------
----- LEADER COLLECTION -------
----- AND ANALYSIS ------------ 
-------------------------------

-- Method:          GRMsync.ErrorCheck()
-- What it Does:    On the giver ErrorCD interval, determines if sync has failed by time since last sync action has occcurred. 
-- Purpose:         To exit out the sync attempt and retry in an efficiennt non, time-wasting way.
GRMsync.ErrorCheck = function()
    if not GRM.IsCalendarEventEditOpen() then
        GRM.GuildRoster();
    end
    if GRMsyncGlobals.DesignatedLeader == GRM_G.addonUser then
        if GRMsyncGlobals.currentlySyncing and ( time() - GRMsyncGlobals.TimeSinceLastSyncAction ) >= GRMsyncGlobals.ErrorCD then

            -- Check if player is offline...
            local playerIsOnline = GRM.IsGuildieOnline ( GRMsyncGlobals.CurrentSyncPlayer );
            local msg = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer , true ) );
            -- We already tried to sync, now aboard to 2nd.
            if playerIsOnline then
                if GRMsyncGlobals.numSyncAttempts == 1 then
                    table.remove ( GRMsyncGlobals.SyncQue , 1 );
                    GRMsyncGlobals.numSyncAttempts = 0;
                    GRMsyncGlobals.currentlySyncing = false;
                    GRMsyncGlobals.errorCheckEnabled = false;
                    -- Sync failed, this is 2nd attempt, AND, another person is in que.
                    
                    if #GRMsyncGlobals.SyncQue > 0 then
                        GRM.RegisterGuildAddonUsersRefresh();
                        C_Timer.After ( 4.1 , function()
                            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                                if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                                    GRM.Report ( msg .. "\n" .. GRM.L ( "Initiating Sync with {name} Instead!" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
                                end
                            end
                            GRMsync.InitiateDataSync();
                        end);
                    -- Sync failed, this is 2nd attempt, but no one else is in the que. Just end it.
                    else
                        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                            if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                                GRM.Report ( msg );
                            end
                        end
                        GRMsyncGlobals.currentlySyncing = false;
                    end   
                elseif #GRMsyncGlobals.SyncQue > 0 then
                    GRMsyncGlobals.numSyncAttempts = GRMsyncGlobals.numSyncAttempts + 1;
                    GRMsyncGlobals.currentlySyncing = false;
                    GRMsyncGlobals.errorCheckEnabled = false;
                    GRMsync.InitiateDataSync();
                end
            else
                table.remove ( GRMsyncGlobals.SyncQue , 1 );
                GRMsyncGlobals.numSyncAttempts = 0;
                GRMsyncGlobals.currentlySyncing = false;
                GRMsyncGlobals.errorCheckEnabled = false;
                if #GRMsyncGlobals.SyncQue > 0 then
                    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                            GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) .. "\n" .. GRM.L ( "Initiating Sync with {name} Instead!" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
                        end
                    end
                    GRMsync.InitiateDataSync();
                else
                    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                            GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) );
                        end
                    end
                    GRMsyncGlobals.currentlySyncing = false;
                end
            end
        elseif GRMsyncGlobals.currentlySyncing and #GRMsyncGlobals.SyncQue > 0 then
            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );
        end
    elseif not GRMsyncGlobals.dateSentComplete then
        if GRMsyncGlobals.currentlySyncing and ( time() - GRMsyncGlobals.TimeSinceLastSyncAction ) >= GRMsyncGlobals.ErrorCD then
            local playerIsOnline = GRM.IsGuildieOnline ( GRMsyncGlobals.DesignatedLeader );
            local msg = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader , true ) );
            if GRMsyncGlobals.numSyncAttempts == 0 then
                if not playerIsOnline then
                    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                            GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) );
                        end
                    end
                else
                    GRMsyncGlobals.numSyncAttempts = GRMsyncGlobals.numSyncAttempts + 1;
                end
                GRMsync.TriggerFullReset();
                -- Now, let's add a brief delay, 15 seconds, to trigger sync again
                C_Timer.After ( 15 , function()
                    if not GRMsyncGlobals.currentlySyncing then
                        GRMsync.Initialize();
                    end
                end);
            else
                if not playerIsOnline then
                    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                            GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) );
                        end
                    end
                    GRMsync.TriggerFullReset();
                    -- Now, let's add a brief delay, 15 seconds, to trigger sync again
                    C_Timer.After ( 15 , function()
                        if not GRMsyncGlobals.currentlySyncing then
                            GRMsync.Initialize();
                        end
                    end);
                else
                    GRMsyncGlobals.numSyncAttempts = 0;
                    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                            GRM.Report ( msg .. "\n" .. GRM.L ( "There Might be a Problem With Their Sync" ) .. "\n" .. GRM.L ( "While not ideal, Ask Them to /reload to Fix It and Please Report the Issue to Addon Creator" ) );
                        end
                        GRMsyncGlobals.currentlySyncing = false;
                    end
                end
            end
        elseif GRMsyncGlobals.currentlySyncing then
            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );  
        end
    else
        -- This condition can occur if the data has been sent, and then the receiving player/leader compiling it and syncing
        -- with other guildies goes offline, you will indefinitely be waiting, and it will say you are indefinitely syncing.
        -- This offers an escape
        local tempTime = ( time() - GRMsyncGlobals.TimeSinceLastSyncAction );
        if tempTime >= GRMsyncGlobals.ErrorCD and tempTime > GRMsyncGlobals.ErrorCD * 2 then
            local playerIsOnline = GRM.IsGuildieOnline ( GRMsyncGlobals.DesignatedLeader );
            if not playerIsOnline then
                if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                    GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader ) ) .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) );
                end
                GRMsync.TriggerFullReset();
                -- Now, let's add a brief delay, 11,1 seconds, to trigger sync again
                C_Timer.After ( 15 , function()
                    if not GRMsyncGlobals.currentlySyncing then
                        GRMsync.TriggerFullReset();
                        GRMsync.Initialize();
                    end
                end);
            end
        end
        GRMsyncGlobals.errorCheckEnabled = false;
        GRMsyncGlobals.currentlySyncing = false;
    end
end

-- Method:          GRMsync.IsPlayerDataSyncCompatible ( string )
-- What it Does:    Returns true if the given player is "Ok!" to sync with
-- Purpose:         Useful in certain occasions to know whether to convey information to user or not.
GRMsync.IsPlayerDataSyncCompatible = function( playerName )
    local result = false;
    
    for i = 1 , #GRM_G.currentAddonUsers do
        if GRM_G.currentAddonUsers[i][1] == playerName then
            if GRM_G.currentAddonUsers[i][2] == "Ok!" then
                result = true;
            end
            break;
        end
    end
    return result;
end

-- Method:          GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline ()
-- What it Does:    Returns true if any user with the addon installed, not specific, is greenlit "Ok!" to sync with
-- Purpose:         Useful in certain occasions to know whether to convey information. Example: Behind the scenes there is a sync leader, if the sync leader is not set
--                  to sync with anyone else, but the other players are sync together, the sync leader still acts as a mediary and participates in the process, but just does not
--                  absorb any of the updates, only passes them on between the players. Well, it will be confusing to the player, who has restricted sync to certain ranks, if they are
--                  told in message that they are now syncing with others, even though they are not (though they are again, mediary processing info behind the scenes for others if elected leader)
GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline = function()
    local result = false;
    for i = 1 , #GRM_G.currentAddonUsers do
        if GRM_G.currentAddonUsers[i][2] == "Ok!" then
            result = true;
            break;
        end
    end
    return result;
end

-- Method:          GRMsync.ReportAuditMessage()
-- What it Does:    Reports a Message to chat indicating how much of the GRM profile data is complete on members of the whole guild
-- Purpose:         Useful report to act as a reminder after sync completes.
GRMsync.ReportAuditMessage = function()
    local numIncomplete = GRM.GetIncompleteGuildDataCounts()[5];
    local message = "";
    local percentComplete = 100 - ( math.floor ( ( numIncomplete / GRM.GetNumGuildies() ) * 100 ) );
    
    if numIncomplete == 0 then
        message = GRM.L ( "100% complete. Great work!" );
    elseif numIncomplete == 1 then
        message = GRM.L ( "{num}% complete." , nil , nil , percentComplete ) .. " " .. GRM.L ( "Only 1 member with incomplete data." );
    else
        message = GRM.L ( "{num}% complete." , nil , nil , percentComplete ) .. " " .. GRM.L ( "{num} members with incomplete data." , nil , nil , numIncomplete );
    end

    GRM.Report ( "\n|CFFFF0000" .. GRM.L ( "GRM Audit Report:" ) .. "|r " .. message );
end

-- Method:          GRMsync.InitiateDataSync()
-- What it Does:    Begins the sync process going throug hthe sync que
-- Purpose:         To Sync data!
GRMsync.InitiateDataSync = function ()
    if not GRM.IsCalendarEventEditOpen() then
        GRM.GuildRoster();
    end
    GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;
    if not GRMsyncGlobals.currentlySyncing then
        GRMsyncGlobals.LeadSyncProcessing = false;
        -- First step, let's check Join Date Changes! Kickstart the fun!
        if #GRMsyncGlobals.SyncQue > 0 then
            -- Let's make sure the currentSyncPlayer is still online, as some time may have passed since we last checked.
            if GRM.IsGuildieOnline ( GRMsyncGlobals.SyncQue[1] ) then
                GRMsyncGlobals.currentlySyncing = true;
                GRMsyncGlobals.CurrentSyncPlayer = GRMsyncGlobals.SyncQue[1];
                GRMsyncGlobals.CurrentSyncPlayerRankID = GRM.GetGuildMemberRankID ( GRMsyncGlobals.SyncQue[1] );
                GRMsyncGlobals.CurrentLeaderRankID = GRM.GetGuildMemberRankID ( GRM_G.addonUser );
                if GRMsyncGlobals.SyncOK then
                    GRMsync.ResetReportTables();
                    GRMsync.ResetTempTables();
                    GRM.convertToArrayFormat(); -- Now, we set arrays of the data.
                    
                    GRMsyncGlobals.TimeSinceLastSyncAction = time();

                    if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks and GRMsyncGlobals.firstMessageReceived ) then
                        
                        if GRM_G.TemporarySync then
                            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Manually Syncing Data With Guildies Now... One Time Only." ) );
                        elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled and GRMsyncGlobals.firstSync then
                            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Syncing Data With Guildies Now..." ) .. "\n" .. GRM.L ( "(Loading screens may cause sync to fail)" ) );
                        end
                    else
                        if not GRMsyncGlobals.firstMessageReceived then
                            GRMsyncGlobals.firstMessageReceived = true;
                            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "No Addon Users Currently Compatible for FULL Sync." ) .. "\n" .. GRM.L ( "Check the \"Sync Users\" tab to find out why!" )  );
                            if #GRM_G.currentAddonUsers > 0 and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
                                GRM.Report ( "     " .. GRM.L ( "You will still share some outgoing data with the guild" ) );
                            end
                        end
                    end
                    GRMsyncGlobals.firstSync = false;
                    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_REQJDDATA?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1] , GRMsyncGlobals.channelName );

                    -- Build Hash Comparison string
                    GRMsync.SendNonLeaderDatabaseMarkers();
                end

                if not GRM.IsCalendarEventEditOpen() then
                    GRM.GuildRoster();
                end
                
            else
                table.remove ( GRMsyncGlobals.SyncQue , 1 );
                GRMsyncGlobals.numSyncAttempts = 0;
                GRMsyncGlobals.currentlySyncing = false;
                GRMsyncGlobals.errorCheckEnabled = false;
                if #GRMsyncGlobals.SyncQue > 0 then
                    GRMsync.InitiateDataSync();
                else
                    GRMsyncGlobals.firstSync = true;
                    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
                            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync With Guildies Complete..." ) );
                            GRMsync.ReportAuditMessage();
                        end
                        GRMsyncGlobals.timeOfLastSyncCompletion = time();
                    end
                    if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                        GRM.RefreshAuditFrames ( true , true );
                    end
                    if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
                        GRM_G.LogNumbersColorUpdate = true;
                        GRM.BuildLogComplete( true , true );
                    end

                    if GRM_UI.GRM_ToolCoreFrame:IsVisible() then
                        GRM_UI.RefreshManagementTool();
                    end
                    
                    if GRM_UI.GRM_LoadToolButton:IsVisible() then
                        GRM_UI.RefreshToolButtonsOnUpdate();
                    end
                end
            end
        end
    end
end

-- Method:          GRMsync.SubmitFinalSyncData()
-- What it Does:    Sends out the mandatory updates to all online (they won't if the change is already there)
-- Purpose:         So leader can send out current, updated sync info.
GRMsync.SubmitFinalSyncData = function()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local msg = "";
    local tempMsg1 = "";
    -- Ok send of the Join Date updates!
    if #GRMsyncGlobals.JDChanges > 0 and not GRMsyncGlobals.finalSyncProgress[1] then
        local joinDate = "";
        local finalTStamp = "";
        local finalEpochStamp = "";
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.JDChanges do

            joinDate = ( "Joined: " .. GRMsyncGlobals.JDChanges[i][3] );
            finalTStamp = ( string.sub ( joinDate , 9 ) .. " 12:01am" );
            finalEpochStamp = tostring ( GRM.TimeStampToEpoch ( joinDate , true ) );
            
            -- Send a change to everyone!
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then

                msg = GRMsyncGlobals.JDChanges[i][1] .. "?" .. joinDate .. "?" .. finalTStamp .. "?" .. finalEpochStamp .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][2] ) .. "?none";

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_JDSYNCUP?" .. GRMsyncGlobals.JDChanges[i][4] .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][5] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg  , GRMsyncGlobals.channelName );
                -- Do my own changes too if the rank is appropriate...
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckJoinDateChange ( msg , "" , "GRM_JDSYNCUP" );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        GRMsyncGlobals.finalSyncProgress[1] = true;
    end
    -- Promo date sync!
    if #GRMsyncGlobals.PDChanges > 0 and not GRMsyncGlobals.finalSyncProgress[2] then
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.PDChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then
                
                msg = GRMsyncGlobals.PDChanges[i][1] .. "?" .. GRMsyncGlobals.PDChanges[i][3] .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][2] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_PDSYNCUP?" .. GRMsyncGlobals.PDChanges[i][4] .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][5] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , "GUILD"); 
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckPromotionDateChange ( msg , "" , "GRM_PDSYNCUP" );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        GRMsyncGlobals.finalSyncProgress[2] = true;
    end
    -- BAN changes sync!
    if #GRMsyncGlobals.BanChanges > 0 and not GRMsyncGlobals.finalSyncProgress[3] then
        local playerWhoBanned = "";
        for i = GRMsyncGlobals.finalSyncDataBanCount , #GRMsyncGlobals.BanChanges do
            GRMsyncGlobals.finalSyncDataBanCount = GRMsyncGlobals.finalSyncDataBanCount + 1;
            if GRMsyncGlobals.SyncOK then
                playerWhoBanned = GRMsyncGlobals.BanChanges[i][7];
                if playerWhoBanned == "" then
                    playerWhoBanned = "X";
                end
                msg = GRMsyncGlobals.BanChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.BanChanges[i][2] ) .. "?" .. GRMsyncGlobals.BanChanges[i][3] .. "?" .. GRMsyncGlobals.BanChanges[i][4] .. "?" .. playerWhoBanned;

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_BANSYNCUP?" .. GRMsyncGlobals.BanChanges[i][5] .. "?" .. tostring ( GRMsyncGlobals.BanChanges[i][6] ) .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;
                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.channelName );
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then                    
                    GRMsync.BanManagementPlayersThatLeft ( msg , "GRM_BANSYNCUP" , GRM_G.addonUser );  -- backupName In Case empty... for EDITS. Shouldn't be an issue but addresses a couple of edge cases.
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataBanCount = 1;
        GRMsyncGlobals.finalSyncProgress[3] = true;
    end
    -- ALT changes sync for adding alts!
    if #GRMsyncGlobals.AltRemoveChanges > 0 and not GRMsyncGlobals.finalSyncProgress[4] then
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.AltRemoveChanges do  -- ( playerName , altName )
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then

                msg = GRMsyncGlobals.AltRemoveChanges[i][1] .. "?" .. GRMsyncGlobals.AltRemoveChanges[i][2] .. "?" .. tostring ( GRMsyncGlobals.AltRemoveChanges[i][3] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_REMSYNCUP?" .. GRMsyncGlobals.AltRemoveChanges[i][4] .. "?" .. tostring ( GRMsyncGlobals.AltRemoveChanges[i][5] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.channelName );
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then                    
                    GRMsync.CheckRemoveAltChange ( msg , "" , "GRM_REMSYNCUP" );                    
                end                    
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        GRMsyncGlobals.finalSyncProgress[4] = true;
    end
    -- ALT changes sync for adding alts!
    if #GRMsyncGlobals.AltAddChanges > 0 and not GRMsyncGlobals.finalSyncProgress[5] then
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.AltAddChanges do  -- ( playerName , altName )
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then
                msg = GRMsyncGlobals.AltAddChanges[i][1] .. "?" .. GRMsyncGlobals.AltAddChanges[i][2] .. "?" .. tostring ( GRMsyncGlobals.AltAddChanges[i][3] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_ALTSYNCUP?" .. GRMsyncGlobals.AltAddChanges[i][4] .. "?" .. tostring ( GRMsyncGlobals.AltAddChanges[i][5] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.channelName );
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckAddAltChange ( msg , "" , "GRM_ALTSYNCUP" );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
            -- Now my data!
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        GRMsyncGlobals.finalSyncProgress[5] = true;
    end

    -- MAIN STATUS CHECK!
    if #GRMsyncGlobals.AltMainChanges > 0 and not GRMsyncGlobals.finalSyncProgress[6] then
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.AltMainChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then

                msg = GRMsyncGlobals.AltMainChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.AltMainChanges[i][2] ) .. "?" .. tostring ( GRMsyncGlobals.AltMainChanges[i][3] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_MAINSYNCUP?" .. GRMsyncGlobals.AltMainChanges[i][4] .. "?" .. tostring ( GRMsyncGlobals.AltMainChanges[i][5] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.channelName );
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckMainSyncChange ( msg );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        if GRM.IsAnyCustomNoteLarge() then
            if  GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessage then
                GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessageModifier1;
            end
        end
        GRMsyncGlobals.finalSyncProgress[6] = true;
    end

    -- CUSTOM NOTE CHECK!
    if #GRMsyncGlobals.CustomNoteChanges > 0 and not GRMsyncGlobals.finalSyncProgress[7] then
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.CustomNoteChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then
                msg = GRMsyncGlobals.CustomNoteChanges[i][4] .. "~X~" .. GRMsyncGlobals.CustomNoteChanges[i][1] .. "~X~" .. tostring ( GRMsyncGlobals.CustomNoteChanges[i][2] ) .. "~X~" .. GRMsyncGlobals.CustomNoteChanges[i][3] .. "~X~" .. GRMsyncGlobals.CustomNoteChanges[i][5];

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_CUSTSYNCUP?" .. GRMsyncGlobals.CustomNoteChanges[i][6] .. "?" .. tostring ( GRMsyncGlobals.CustomNoteChanges[i][7] ) .. "?";

                -- Split the message!!!
                if ( #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier ) > 254 then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + ( #tempMsg1 * 2 ) + ( #msg - 50 ) + ( #GRMsyncGlobals.CustomNoteChanges[i][5] - 49 ) + ( GRMsyncGlobals.sizeModifier * 2 );
                    -- First, sending last half of message
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. string.sub ( GRMsyncGlobals.CustomNoteChanges[i][5] , #GRMsyncGlobals.CustomNoteChanges[i][5] - 49 ) .. "&X&" , GRMsyncGlobals.channelName );
                    -- Second, sending full details and first portion of message.
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. string.sub ( msg , 1 , #msg - 50 ) .. "&X&" , GRMsyncGlobals.channelName );
                else
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.channelName );
                end
                
                
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankCustom and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckCustomNoteSyncChange ( msg , false );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        if GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessageModifier1 then
            GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
        end
        GRMsyncGlobals.finalSyncProgress[7] = true;
    end

    -- BIRTHDAY CHECK!
    if #GRMsyncGlobals.BDayChanges > 0 and not GRMsyncGlobals.finalSyncProgress[8] then
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.BDayChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then

                msg = GRMsyncGlobals.BDayChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][2] ) .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][3] ) .. "?" .. GRMsyncGlobals.BDayChanges[i][4] .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][5] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_BDSYNCUP?" .. GRMsyncGlobals.BDayChanges[i][6] .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][7] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;
                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.channelName )
                -- Do my own changes too!
                if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncBDays and ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckBirthdayChange ( msg , nil , true );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        GRMsyncGlobals.finalSyncProgress[8] = true;
    end

    -- Ok all done! Reset the tables!
    GRMsync.ResetReportTables();
    GRMsyncGlobals.finalSyncDataCount = 1;
    GRMsyncGlobals.finalSyncDataBanCount = 1;
    GRMsyncGlobals.finalSyncProgress = { false , false , false , false , false , false , false , false };
    -- Do a quick check if anyone else added themselves to the que in the last millisecond, and if so, REPEAT!
    -- Setup repeat here.
    -----------------------------------
    local nameOfCurrentSyncSender = GRMsyncGlobals.SyncQue[1];

    -- This will be reset if sync is being retriggered.
    if nameOfCurrentSyncSender ~= nil then
        local tempMsg = GRM_G.PatchDayString .. "?GRM_COMPLETE?" .. GRMsyncGlobals.numGuildRanks .. "?" .. nameOfCurrentSyncSender;
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg + GRMsyncGlobals.sizeModifier;
        GRMsync.SendMessage ( "GRM_SYNC" , tempMsg , GRMsyncGlobals.channelName );

        -- We made it... remove from the syncQue
        table.remove ( GRMsyncGlobals.SyncQue , 1 );
        GRMsyncGlobals.numSyncAttempts = 0;
        if #GRMsyncGlobals.SyncQue > 0 then
            GRMsyncGlobals.currentlySyncing = false;
            GRMsync.InitiateDataSync();
        else
            -- Disable sync again if necessary!
            GRMsync.ReportSyncCompletion ( nameOfCurrentSyncSender , true );
            GRMsyncGlobals.firstSync = true;
        end
    end
end

-- need to send GUID data as well
-- Method:          GRMsync.UpdateLeftPlayerInfo ( string )
-- What it Does:    If a player needs to ban or unban a player, it cannot do so if they are not on their list, as maybe it was a person that left the guild before they had addon installed or before they joined> this fixes the gap
-- Purpose:         To maintain a ban list properly, even for those who installed the addon later, or joined the guild later. The "Left Players" would not have them stored. This syncs that, but ONLY as needed, not all left players
--                  as this prevents left player storage bloat unnecessarily and only syncs the banned or unbanned ones.
GRMsync.UpdateLeftPlayerInfo = function ( msg , partialParsed )
    -- (name , rank, rankID, level , class , leftguilddate, leftguildEpochMeta , oldJoinDate, oldJoinDateMeta)
    local name , rankID , level , classIndex , leftGuildMeta , oldJoinDateMeta , guid;
    local AllClasses = { "Deathknight" , "Demonhunter" , "Druid" , "Hunter" , "Mage" , "Monk" , "Paladin" , "Priest" , "Rogue" , "Shaman" , "Warlock" , "Warrior" };
    -- Ok, let's check if this player is already known...
    name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

    local player = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][GRM_G.guildName][ name ];

    if player == nil then

        if partialParsed then

            rankID = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            level = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            classIndex = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            leftGuildMeta = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            oldJoinDateMeta = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

            guid = "";
            if string.find ( msg , "?" ) ~= nil then
                guid = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            else
                guid = msg;
            end
            
        else

            GRM_G.UpdateLeftPlayerInfoPattern = GRM_G.UpdateLeftPlayerInfoPattern or GRM.BuildComPattern ( 6 , "?" , false );
            rankID , level , classIndex , leftGuildMeta , oldJoinDateMeta , guid = GRM.ParseComMsg ( msg , GRM_G.UpdateLeftPlayerInfoPattern );
            rankID = tonumber ( rankID );
            level = tonumber ( level );
            classIndex = tonumber ( classIndex );
            leftGuildMeta = tonumber ( leftGuildMeta );
            oldJoinDateMeta = tonumber ( oldJoinDateMeta );
        
        end

        if guid == "X" then
            guid = "";
        end
        local class = "";
        if classIndex == 0 or classIndex == nil or classIndex == "" then
            return;
        else
            class = string.upper ( AllClasses [ classIndex ] );
        end
        -- let's build the memberInfoArray!
        -- After class, all info is generic filler info.

        local memberInfoToAdd = {};

        memberInfoToAdd.name = name                                             -- 1

        if rankID == 99 then
            memberInfoToAdd.rankName = ( "< " .. GRM.L ( "Unknown" ) .. " >" );
            memberInfoToAdd.rankIndex = 99;
        else
            memberInfoToAdd.rankName = GuildControlGetRankName ( rankID + 1 );  -- 2
            memberInfoToAdd.rankIndex = rankID;
        end
                                             -- 3 (It needs to be 1 less to match when compared to the guildRosterInfo call )
        memberInfoToAdd.level = level;                                          -- 4
        memberInfoToAdd.note = "";                                              -- 5
        if GRM.CanViewOfficerNote() then -- Officer Note permission to view.
            memberInfoToAdd.officerNote = "";                                   -- 6
        else
            memberInfoToAdd.officerNote = nil; -- Set Officer note to nil if needed due to memberInfoToAdd not being able to view. - If it is set to "" then memberInfoToAdd will think it is changing.
        end
        memberInfoToAdd.class = class;                                          -- 7
        memberInfoToAdd.lastOnline = 1;                                         -- 8 Time since they last logged in in hours.
        memberInfoToAdd.zone = "";                                              -- 9
        memberInfoToAdd.achievementPoints = 100;                                -- 10    
        memberInfoToAdd.isMobile = false;                                       -- 11
        memberInfoToAdd.rep = 4;                                                -- 12
        memberInfoToAdd.isOnline = false;                                       -- 13
        memberInfoToAdd.status = 0;                                             -- 14
        memberInfoToAdd.GUID = guid;                                            -- 15
        memberInfoToAdd.race = "";                                              -- 16
        memberInfoToAdd.sex = 1;                                                -- 17
        memberInfoToAdd.rosterSelection = 0;                                    -- 18
        
        GRMsyncGlobals.AddLeftPlayerCount = GRMsyncGlobals.AddLeftPlayerCount + 1;

        GRM.AddMemberToLeftPlayers ( memberInfoToAdd , leftGuildMeta , oldJoinDateMeta , nil );
    end
end

-- Method:          GRMsync.UpdateCurrentPlayerInfo ( string )
-- What it Does:    For players that have ban information, and are still currently in the guild, this updates them
-- Purpose:         Some outliers may encounter this situation. This just buttons up the hatches nicely.
GRMsync.UpdateCurrentPlayerInfo = function ( msg )

    GRM_G.UpdateCurrentPlayerInfoPattern = GRM_G.UpdateCurrentPlayerInfoPattern or GRM.BuildComPattern ( 5 , "?" , false );
    local name , tag , timestamp , reason , unbanner = GRM.ParseComMsg ( msg , GRM_G.UpdateCurrentPlayerInfoPattern );
    timestamp = tonumber ( timestamp );

    if unbanner == "X" then
        unbanner = "";
    end

    if tag == "ban" then
        GRM.SyncAddCurrentPlayerBan ( name , timestamp , reason , unbanner )
    elseif tag == "unban" then
        GRM.SyncRemoveCurrentPlayerBan ( name , timestamp , unbanner );
    end

    if GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame:IsVisible() then
        GRM.RefreshBanListFrames();
    end
end

-- Method:          GRMsync.UpdateCurrentPlayerBanReason ( string )
-- What it Does:    Occasionally a ban reason won't fit on a single string for sync comms, so we send it independently, and this updates it.
-- Purpose:         Sync speed efficiency.
GRMsync.UpdateCurrentPlayerBanReason = function ( msg )

    GRM_G.UpdateCurrentPlayerBanReasonPattern = GRM_G.UpdateCurrentPlayerBanReasonPattern or GRM.BuildComPattern ( 3 , "?" , false );
    local name , reason , banner = GRM.ParseComMsg ( msg , GRM_G.UpdateCurrentPlayerBanReasonPattern );

    if banner == "X" then
        banner = "";
    end

    GRM.ChangeCurrentPlayerBanReason ( name , reason , banner );
end

-- Method:          GRMsync.CollectData ( string , string )
-- What it Does:    Collects all of the sync data before analysis.
-- Purpose:         Need to aggregate the data so one only needs to parse through the tables once, rather than on each new piece of info added. Far more efficient.
GRMsync.CollectData = function ( msg , prefix )
    local name = "";
    local timeStampOfChange = 0;
    local addLeftPlayerSubstring = "";
    local banStatus = "";
    local reason = "";
    local personWhoBanned = "";

    -- JOIN DATE
    if prefix == "GRM_JDSYNC" then
        local joinDate = "";
        while string.find ( msg , "?" ) ~= nil do
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

            if string.find ( msg , "?" ) ~= nil then
                joinDate = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            else
                joinDate = msg;
            end
            if timeStampOfChange ~= 978375660 then          -- to fix an old sync bug...
                table.insert ( GRMsyncGlobals.JDReceivedTemp , { name , timeStampOfChange , GRMsync.SlimDate ( joinDate ) , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement } );
            end
        end
    
    -- PROMO DATE
    elseif prefix == "GRM_PDSYNC" then
        local promoDate = "";
        while string.find ( msg , "?" ) ~= nil do
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

            if string.find ( msg , "?" ) ~= nil then
                promoDate = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            else
                promoDate = msg;
            end
            if timeStampOfChange ~= 978375660 then      -- This is a placeholder sync value for inaccurate promo date data cause it could not be gleamed from the log. This is so people who
                                                        --  have not logged on in a long time don't just update all the promo dates to the date of login and then overwrite everyone's data because it seems newer.
                table.insert ( GRMsyncGlobals.PDReceivedTemp , { name , timeStampOfChange , promoDate , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement } );
            end
        end
    
    -- BAN/UNBAN scan of LEFT players
    elseif prefix == "GRM_BANSYNC" then
        if string.sub( msg , #msg , #msg ) == "?" then
            msg = string.sub ( msg , 1 , #msg - 1 );
        end
        while string.find ( msg , "?" ) ~= nil do
            -- saves me the hassle of debugging that elusive issue... one day.
            if string.sub ( msg , 1 , 1 ) == "?" then
                msg = string.sub ( msg , 2 );
            end
            -- this will be GRM_BANSYNC2 originally... Need to add the player to left player's list...
            if string.sub ( msg , 1 , 1 ) == "#" then
                addLeftPlayerSubstring = string.sub ( msg , 2 , string.find ( msg , "&" ) - 1 );    -- Starting at 2 eliminates the # symbol.
                GRMsync.UpdateLeftPlayerInfo ( addLeftPlayerSubstring , true );
                msg = string.sub ( msg , string.find ( msg , "&" ) + 1 );
            end
            if string.sub ( msg , 1 , 1 ) == "&" then
                name = string.sub ( msg , 2 , string.find ( msg , "?" ) - 1 );          -- eliminates the &
            else
                name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            end

            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            banStatus = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            reason = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

            if string.find ( msg , "?" ) ~= nil then
                personWhoBanned = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            else
                personWhoBanned = msg;
            end
            if personWhoBanned == "X" then
                personWhoBanned = "";
            end

            table.insert ( GRMsyncGlobals.BanReceivedTemp , { name , timeStampOfChange , banStatus , reason , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement , personWhoBanned } );
        end

    -- BAN/UNBAN scan of players still in guild.
    elseif prefix == "GRM_BANSYNC2" then
        while string.find ( msg , "?" ) ~= nil do
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );          -- eliminates the &
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            banStatus = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            reason = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

            if string.find ( msg , "?" ) ~= nil then
                personWhoBanned = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            else
                personWhoBanned = msg;
            end
            if personWhoBanned == "X" then
                personWhoBanned = "";
            end
            table.insert ( GRMsyncGlobals.BanReceivedTemp , { name , timeStampOfChange , banStatus , reason , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement , personWhoBanned } );
        end

    -- MAIN STATUS
    elseif prefix == "GRM_MAINSYNC" then
        local mainStatus = "";
        local mainResult = false;
        while string.find ( msg , "?" ) ~= nil do
            mainResult = false;
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

            if string.find ( msg , "?" ) ~= nil then
                mainStatus = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            else
                mainStatus = msg;
            end
            -- Let's convert that string to boolean
            if mainStatus == "true" then
                mainResult = true;
            end
            table.insert ( GRMsyncGlobals.MainReceivedTemp , { name , mainResult , timeStampOfChange , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement } );
        end
    end
end

-- Method:          GRMsync.CollectCustomNoteAction ( string )
-- What it Does:    Collects the custom note sync date from currentsyncplayer
-- Purpose:         To be able to collect for easy parsing the custom note changes on a retroactive sync.
GRMsync.CollectCustomNoteAction = function ( msg )
    local senderControlRankRequirement = 0;
    local playerName = "";
    local timeStampOfChange = 0;
    local noteAuthor = "";
    local customNote = "";
    
    while string.find ( msg , "?#" , 1 , true ) ~= nil and msg ~= "" do
        senderControlRankRequirement = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?#" , 1 , true ) - 1 ) );
        if senderControlRankRequirement == nil then
            -- Add DEBUG log here... possible error message...
            return
        end
        msg = string.sub ( msg , string.find ( msg , "?#" , 1 , true ) + 2 );
        playerName = string.sub ( msg , 1 , string.find ( msg , "?#" , 1 , true ) - 1 );
        msg = string.sub ( msg , string.find ( msg , "?#" , 1 , true ) + 2 );
        timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?#" , 1 , true ) - 1 ) );
        msg = string.sub ( msg , string.find ( msg , "?#" , 1 , true ) + 2 );
        noteAuthor = string.sub ( msg , 1 , string.find ( msg , "?#" , 1 , true ) - 1 );
        msg = string.sub ( msg , string.find ( msg , "?#" , 1 , true ) + 2 );

        if not GRMsyncGlobals.HalfMsg then
            if string.find ( msg , "?#" , 1 , true ) ~= nil then
                customNote = string.sub ( msg , 1 , string.find ( msg , "?" , 1 , true ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" , 1 , true ) + 1 );
            else
                if string.find ( msg , "?^?" , 1 , true ) ~= nil then
                    GRMsyncGlobals.HalfMsg = true;
                    GRMsyncGlobals.HalfMsgTemp = string.sub ( msg , 1 , string.find ( msg , "?^?" , 1 , true ) - 1 );
                else
                    customNote = msg;
                end
            end
        else
            GRMsyncGlobals.HalfMsg = false;
            if string.find ( msg , "?^?" , 1 , true ) ~= nil then
                customNote = GRMsyncGlobals.HalfMsgTemp .. string.sub ( msg , 1 , string.find ( msg , "?^?" , 1 , true ) - 1 );
            else
                -- Error!!! Second portion of note never arrived!
                return;
            end
        end

        if not GRMsyncGlobals.HalfMsg then
            
            table.insert ( GRMsyncGlobals.CustomNoteReceivedTemp , { playerName , timeStampOfChange , noteAuthor , senderControlRankRequirement , customNote , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement } );
        end
    end    
end

-- Method:          GRMsync.CollectBirthdayData ( string )
-- What it Does:    Collects the Birthday data during a sync
-- Purpose:         For controlling the flow of sync'd data
GRMsync.CollectBirthdayData = function ( msg )
    local name = "";
    local day , month , timestamp;
    local date = "";

    while string.find ( msg , "?" ) ~= nil and msg ~= "" do
        name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
        day = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
        month = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
        date = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

        if string.find ( msg , "?" ) ~= nil then
            timestamp = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
        else
            timestamp = tonumber ( msg );
        end

        table.insert ( GRMsyncGlobals.BirthdayReceivedTemp , { name , day , month , date , timestamp , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement } );
    end
end

-- Method:          GRMsync.CollectAltAddData ( string )
-- What it Does:    Compiles the alt ADD data into a temp file
-- Purpose:         For use of syncing. Need to compile all data from a single player before analyzing it.
GRMsync.CollectAltAddData = function ( msg )
    local name = "";
    local index = -1;
    local timestampResult;
    local altName = "";
    
    -- this is for an edge case...
    if tonumber ( string.sub ( msg , #msg , #msg ) ) == nil then
        msg = msg .. "?0";
    end
    -- First, let's isolate the player...
    while string.find ( msg , "&" ) ~= nil and string.find ( msg , "?" ) ~= nil do -- if only the leader name is sent, but not the alt, we need to break here
        
        if string.sub ( msg , 1 , 1 ) == "&" then
            name = string.sub ( msg , 2 , string.find ( msg , "?" ) - 1 );      -- position 2 eliminates the "&"
        else
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        end
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

        -- Checking to see player is not already added (they shouldn't be, but acts as protection on cross talk on addons in rare circumstances)
        index = -1;
        for i = 1 , #GRMsyncGlobals.AltReceivedTemp do
            if GRMsyncGlobals.AltReceivedTemp[i][1] == name then
                index = i;
                break;
            end
        end

        if index == -1 then
            table.insert ( GRMsyncGlobals.AltReceivedTemp , { name , {} } ); 
        end

        -- Ok, let's see if there are alts to be added!
        if string.sub ( msg , 1 , 1 ) ~= "0" then      
            -- Ok, let's add the alt info!
            -- Player was just added, so you know it is at the end of the table in the last index.
            -- Sets insert point in table.
            if index == -1 then
                index = #GRMsyncGlobals.AltReceivedTemp;
            end

            -- Now parse out the rest of the alts...
            while string.find ( msg , "?" ) ~= nil and string.sub ( msg , 1 , 1 ) ~= "&" do

                
                altName = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

                -- This protects against older version from breaking new way alt data is sync'd
                if string.find ( msg , "?" ) == nil then
                    timestampResult = tonumber ( msg );
                else
                    timestampResult = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                end
                -- Error Protection
                if timestampResult == nil then
                    timestampResult = 0;
                end
                table.insert ( GRMsyncGlobals.AltReceivedTemp[ index ][2] , { altName , timestampResult } );
            end
        else
            -- No adds, let's move on to the next player...
            if  string.find ( msg , "&" ) ~= nil then
                -- more players are still needed to be parsed from the string.
                -- Parse out the "0?" and leave the "&NAME"
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            end
        end
    end
end

-- Method:          GRMsync.CollectAltRemData ( string )
-- What it Does:    Compiles the received data from a player about their alt configurations
-- Purtpose:        For syncing
GRMsync.CollectAltRemData = function ( msg )
    local name = "";
    local index = -1;
    local timestampResult;
    local altName = "";
    if tonumber ( string.sub ( msg , #msg , #msg ) ) == nil then
        msg = msg .. "?0";
    end
    -- First, let's isolate the player...
    while string.find ( msg , "&" ) ~= nil and string.find ( msg , "?" ) ~= nil do
        if string.sub ( msg , 1 , 1 ) == "&" then
            name = string.sub ( msg , 2 , string.find ( msg , "?" ) - 1 );      -- position 2 eliminates the "&"
        else
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        end
        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

        -- Checking to see player is not already added (they shouldn't be, but acts as protection on cross talk on addons in rare circumstances)
        index = -1;
        for i = 1 , #GRMsyncGlobals.AltRemReceivedTemp do
            if GRMsyncGlobals.AltRemReceivedTemp[i][1] == name then
                index = i;
                break;
            end
        end

        if index == -1 then
            table.insert ( GRMsyncGlobals.AltRemReceivedTemp , { name , {} } ); 
        end

        -- Ok, let's see if there are alts to be added!
        if string.sub ( msg , 1 , 1 ) ~= "0" then      
            -- Ok, let's add the alt info!
            -- Player was just added, so you know it is at the end of the table in the last index.
            -- Sets insert point in table.
            if index == -1 then
                index = #GRMsyncGlobals.AltRemReceivedTemp;
            end

            -- Now parse out the rest of the alts...
            while string.find ( msg , "?" ) ~= nil and string.sub ( msg , 1 , 1 ) ~= "&" do
                altName = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

                -- This protects against older version from breaking new way alt data is sync'd
                if string.find ( msg , "?" ) == nil then
                    timestampResult = tonumber ( msg );
                else
                    timestampResult = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                end

                -- Error Protection
                if timestampResult == nil then
                    timestampResult = 0;
                end
                table.insert ( GRMsyncGlobals.AltRemReceivedTemp[ index ][2] , { altName , timestampResult } );
            end
        else
            -- No adds, let's move on to the next player...
            if  string.find ( msg , "&" ) ~= nil then
                -- more players are still needed to be parsed from the string.
                -- Parse out the "0?" and leave the "&NAME"
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            end
        end
    end
end

----- HUGE ERROR!!! I AM NOT CHECKING FINAL TABLES< ONLY INITIAL TEMP TABLES!!! NEED TO FIX!!!!!!!

-- GRM>AddAlt = if player being added is already an alt it should abort or else it messes up the main and linkage.
-- PROBLEM -- Removed alt is removing each individual previous alt rather than the alts removing him...
-- Method:          GRMsync.AddToProperAltTable ( string , string , int , boolean )
-- What it Does:    Verifies that the alt needs to be added to the finalized data... or removed.
-- Purpose:         Sync control for alt management.                                                                    
GRMsync.AddToProperAltTable = function ( name , altName , timeStamp , toAddAlt , syncName , syncRankRestrictID )
    local needsAdding = true;
    local isAlreadyAdded = false;
    -- POSSIBLY ADDING!
    if toAddAlt then
    -- If I am going to add it, then make sure it is not on the finalized Remove table, and if it is, compare timestamps
    -- if it IS to be added to the final ADD table, then ensure it is not already there as well!
        if #GRMsyncGlobals.AltRemoveChanges > 0 then
            for i = #GRMsyncGlobals.AltRemoveChanges , 1 , -1 do
                if ( GRMsyncGlobals.AltRemoveChanges[i][1] == name and GRMsyncGlobals.AltRemoveChanges[i][2] == altName ) or ( GRMsyncGlobals.AltRemoveChanges[i][1] == altName and GRMsyncGlobals.AltRemoveChanges[i][2] == name ) then
                    -- Ok, match is found! We need to check timestamps now!
                    if timeStamp < GRMsyncGlobals.AltRemoveChanges[i][3] then
                        -- This means that the player set to be added is actually set to be removed by a more recent entry!
                        needsAdding = false;
                    else
                        -- Since it was found in the table, and the incoming data is more recent, then it also needs to be removed from the removeChanges table because it needs to be added...
                        table.remove ( GRMsyncGlobals.AltRemoveChanges , i );
                    end
                    break;
                end
            end
        end

        -- Confirmed, it is definitely a change to be added!
        if needsAdding then
            -- Before we add it, let's first verify it is not already in the table!
            if #GRMsyncGlobals.AltAddChanges > 0 then
                for i = 1 , #GRMsyncGlobals.AltAddChanges do
                    if GRMsyncGlobals.AltAddChanges[i][1] == name and GRMsyncGlobals.AltAddChanges[i][2] == altName then
                        -- Player info has already been determined through scanning another player's update info!
                        isAlreadyAdded = true;
                        break;
                    end
                end
            end

            if not isAlreadyAdded then
                -- Add it here!
                table.insert ( GRMsyncGlobals.AltAddChanges , { name , altName , timeStamp , syncName , syncRankRestrictID } );
            end
        end

    -- POSSIBLY REMOVING!
    else
    -- If it is to be removed, ensure it is not already on the ADD table, and if it is, compare timestamps.
    -- IF it IS certain to be removed, ensure that it is not already on the Remove table to avoid double adds.
        if #GRMsyncGlobals.AltAddChanges > 0 then
            for i = #GRMsyncGlobals.AltAddChanges , 1 , -1 do
                if ( GRMsyncGlobals.AltAddChanges[i][1] == name and GRMsyncGlobals.AltAddChanges[i][2] == altName ) or ( GRMsyncGlobals.AltAddChanges[i][1] == altName and GRMsyncGlobals.AltAddChanges[i][2] == name ) then
                    -- Ok, match is found! We need to check timestamps now!
                    if timeStamp < GRMsyncGlobals.AltAddChanges[i][3] then
                        -- This means that the player set to be added is actually set to be removed by a more recent entry!
                        needsAdding = false;
                    else
                        -- Since it was found in the table, and the incoming data is more recent, then it also needs to be removed from the removeChanges table
                        table.remove ( GRMsyncGlobals.AltAddChanges , i );
                    end
                    break;
                end
            end
        end

         -- Confirmed, it is definitely a change to be added to REMOVE table
        if needsAdding then
            -- Before we add it, let's first verify it is not already in the table!
            
            if #GRMsyncGlobals.AltRemoveChanges > 0 then
                for i = 1 , #GRMsyncGlobals.AltRemoveChanges do
                    if GRMsyncGlobals.AltRemoveChanges[i][1] == name and GRMsyncGlobals.AltRemoveChanges[i][2] == altName then
                        -- Player info has already been determined through scannign another player's update info!
                        isAlreadyAdded = true;
                        break;
                    end
                end
            end

            if not isAlreadyAdded then
                -- Add it here!
                table.insert ( GRMsyncGlobals.AltRemoveChanges , { name , altName , timeStamp , syncName , syncRankRestrictID } );
            end
        end
    end
end

-- Method:          GRMsync.CheckingJDChanges ( int , int )
-- What it Does:    After receiving ALL of the Join date data, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingJDChanges = function ( currentTime , syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    -- Reminder: GRMsyncGlobals.JDReceivedTemp[i] = { name , timeStampOfChange , GRMsync.SlimDate ( joinDate ) , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement
    local isFound = false;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

    for j = 1 , #exactIndexes[1] do
        isFound = false;
        for i = 1 , #GRMsyncGlobals.JDReceivedTemp do
            if guildData[exactIndexes[1][j]].name == GRMsyncGlobals.JDReceivedTemp[i][1] then
                isFound = true;
                -- Ok player identified, now let's compare data.
                local parsedDate = GRMsync.SlimDate ( guildData[exactIndexes[1][j]].verifiedJoinDate[1] );
                if parsedDate ~= GRMsyncGlobals.JDReceivedTemp[i][3] then
                    -- Player dates don't match! Let's compare timestamps to see how made the most recent change, then sync data to that!
                    
                    local addReceived = false;      -- AM I going to add received data, or my own. One or the other needs to be added for sync
                    if ( currentTime - guildData[exactIndexes[1][j]].verifiedJoinDate[2] ) > ( currentTime - GRMsyncGlobals.JDReceivedTemp[i][2] ) then
                        -- Received Data happened more recently! Need to update change!
                        addReceived = true;         -- In other words, don't add my own data, add the received data.
                    end

                    -- Setting the change data properly.
                    local changeData;
                    -- Adding Received from other player
                    if addReceived then
                        changeData = GRMsyncGlobals.JDReceivedTemp[i];
                    
                    -- Adding my own data, as it is more current
                    else
                        changeData = { guildData[exactIndexes[1][j]].name , guildData[exactIndexes[1][j]].verifiedJoinDate[2] , parsedDate , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                    end

                    -- Need to check if change has not already been added, or if another player added info that is more recent! (Might need review for increased performance)
                    local needToAdd = true;
                    for r = #GRMsyncGlobals.JDChanges , 1 , -1 do
                        if changeData[1] == GRMsyncGlobals.JDChanges[r][1] then
                            -- If dates are the same, no need to change em!
                            if changeData[2] <= GRMsyncGlobals.JDChanges[r][2] then
                                needToAdd = false;
                            end

                            -- If needToAdd is still true, then we need to remove the old index.
                            if needToAdd then
                                table.remove ( GRMsyncGlobals.JDChanges , r );
                            end
                        end
                    end

                    -- Now let's add it!
                    if needToAdd then
                        table.insert ( GRMsyncGlobals.JDChanges , changeData );
                    end
                end
                break;
            end
        end
        if not isFound and guildData[exactIndexes[1][j]].verifiedJoinDate[2] ~= 0 and guildData[exactIndexes[1][j]].verifiedJoinDate[1] ~= "" then
            table.insert ( GRMsyncGlobals.JDChanges , { guildData[exactIndexes[1][j]].name , guildData[exactIndexes[1][j]].verifiedJoinDate[2] , GRMsync.SlimDate ( guildData[exactIndexes[1][j]].verifiedJoinDate[1] ) , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
        end
    end
    -- Wiping the temp file!
    -- From here, request should be sent out for PDSYNC!
    GRMsyncGlobals.JDReceivedTemp = {};
end

-- Method:          GRMsync.CheckingPDChanges ( int , int )
-- What it Does:    After receiving ALL of the promo date data, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingPDChanges = function ( currentTime , syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local isFound = false;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

    for j = 1 , #exactIndexes[2] do
        isFound = false;
        for i = 1 , #GRMsyncGlobals.PDReceivedTemp do
            if guildData[exactIndexes[2][j]].name == GRMsyncGlobals.PDReceivedTemp[i][1] then
                isFound = true;
                if guildData[exactIndexes[2][j]].verifiedPromoteDate[1] ~= GRMsyncGlobals.PDReceivedTemp[i][3] then

                    local addReceived = false;      -- AM I going to add received data, or my own. One or the other needs to be added for sync
                    if ( currentTime - guildData[exactIndexes[2][j]].verifiedPromoteDate[2] ) > ( currentTime - GRMsyncGlobals.PDReceivedTemp[i][2] ) then
                        -- Received Data happened more recently! Need to update change!
                        addReceived = true;         -- In other words, don't add my own data, add the received data.
                    end

                    -- Setting the change data properly.
                    local changeData;
                    -- Adding Received from other player
                    if addReceived then
                        changeData = GRMsyncGlobals.PDReceivedTemp[i];
                    
                    -- Adding my own data, as it is more current
                    else
                        changeData = { guildData[exactIndexes[2][j]].name , guildData[exactIndexes[2][j]].verifiedPromoteDate[2] , guildData[exactIndexes[2][j]].verifiedPromoteDate[1] , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                    end

                    -- Need to check if change has not already been added, or if another player added info that is more recent! (Might need review for increased performance)
                    local needToAdd = true;
                    for r = #GRMsyncGlobals.PDChanges , 1 , -1 do
                        if changeData[1] == GRMsyncGlobals.PDChanges[r][1] then
                            -- If dates are the same, no need to change em!
                            if changeData[2] <= GRMsyncGlobals.PDChanges[r][2] then
                                needToAdd = false;
                            end

                            -- If needToAdd is still true, then we need to remove the old index.
                            if needToAdd then
                                table.remove ( GRMsyncGlobals.PDChanges , r );
                            end
                        end
                    end

                    -- If needToAdd is still true, then we need to remove the old index.
                    if needToAdd then
                        table.insert ( GRMsyncGlobals.PDChanges , changeData );
                    end
                end
                break;
            end
        end
        if not isFound and guildData[exactIndexes[2][j]].verifiedPromoteDate[2] ~= 0 and guildData[exactIndexes[2][j]].verifiedPromoteDate[1] ~= "" then
            table.insert ( GRMsyncGlobals.PDChanges , { guildData[exactIndexes[2][j]].name , guildData[exactIndexes[2][j]].verifiedPromoteDate[2] , guildData[exactIndexes[2][j]].verifiedPromoteDate[1] , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
        end
    end
    -- Wipe the data!
    GRMsyncGlobals.PDReceivedTemp = {};
end

-- Method:          GRMsync.CheckingBANChanges ( int , int )
-- What it Does:    After receiving ALL of the Ban info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingBANChanges = function ( currentTime , syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local leftGuildData = GRMsyncGlobals.formerGuildData;

    -- Skip this all if player restrict ban list sync
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncBanList then -- { name , timeStampOfBanChange , banStatus , reason }
        local isFound;
        -- Let's check my own changes now...
        -- First, left players...
        local tag = "";
        local reason = "";
        local tempReasonForLength = "";
        local personWhoBanned = "";
        local tempPlayer;

        -- Checking Left Players here of my own database to the receieved
        for i = 1 , #leftGuildData do
            isFound = false;
            if leftGuildData[i].bannedInfo[1] or leftGuildData[i].bannedInfo[3] then  -- if banned or unbanned is on my playersThatLeft...
                if leftGuildData[i].bannedInfo[1] then
                    tag = "ban";
                elseif leftGuildData[i].bannedInfo[3] then
                    tag = "unban";
                end
                if leftGuildData[i].bannedInfo[4] == "" or leftGuildData[i].bannedInfo[4] == nil then
                    personWhoBanned = "X";
                else
                    personWhoBanned = leftGuildData[i].bannedInfo[4];
                end

                local tempPlayer = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ leftGuildData[i].name ];

                if tempPlayer == nil then
                    -- Player was not found on the ban list
                    reason = leftGuildData[i].reasonBanned;
                    if reason == "" then
                        reason = GRM.L ( "No Reason Given" );
                    end
                    if tag == "ban" or tag == "unban" then
                        table.insert ( GRMsyncGlobals.BanReceivedTemp , { leftGuildData[i].name , 0 , tag , reason , GRM_G.addonUser , syncRankFilter , "" } );  -- Possibly set to "noban" to avoid overrides?
                    end

                    local class = leftGuildData[i].class;
                    if class == nil or class == "" then
                        class = "0";        -- zero so it is just 1 char long.
                    else
                        class = tostring ( allClassesEnum[ class ] )
                    end
                    local guid = leftGuildData[i].GUID;
                    if guid == "" then
                        guid = "X";
                    end

                    local oldJoinDateMeta = 0;
                    if leftGuildData[i].verifiedJoinDate[1] == "" and leftGuildData[i].rankHistory[1] ~= nil and leftGuildData[i].rankHistory[1][3] ~= nil and leftGuildData[i].rankHistory[1][3] > 0 then    -- redundancy due to old databases...
                        -- Just use the first promo date if that is the case
                        oldJoinDateMeta = leftGuildData[i].rankHistory[1][3];
                    else
                        oldJoinDateMeta = leftGuildData[i].leftGuildEpoch[#leftGuildData[i].leftGuildEpoch];    -- Just set it to the left guild Date.
                    end
                    
                    -- Send request to ADD player w/ban or unban status.
                    local tempMessage = GRM_G.PatchDayString .. "?GRM_ADDLEFT?" .. GRMsyncGlobals.numGuildRanks .. "?" .. leftGuildData[i].name .. "?" .. tostring ( leftGuildData[i].rankIndex ) .. "?" .. tostring ( leftGuildData[i].level ) .. "?" .. class .. "?" .. tostring ( leftGuildData[i].leftGuildEpoch[#leftGuildData[i].leftGuildEpoch] ) .. "?" .. tostring ( oldJoinDateMeta ) .. "?" .. guid;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier + 254;
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.channelName );    -- (name , rank, rankID, level , class , leftguildEpochMeta , OldJoinDateMeta , banStatus , guid)
                    
                    if GRMsyncGlobals.SyncCount > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;      -- Resets this and we will recheck.
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRMsync.CheckingBANChanges ( currentTime , syncRankFilter );
                        end);
                        return;
                    end
                else
                    isFound = true;
                end
            end
        end

        -- Now, let's check current players!
        for i = GRMsyncGlobals.BanCount , #guildData do
            if guildData[i].bannedInfo[1] or guildData[i].bannedInfo[3] then  -- if banned or unbanned is on my playersThatLeft...
                isFound = false;
                if guildData[i].bannedInfo[1] then
                    tag = "ban";
                elseif guildData[i].bannedInfo[3] then
                    tag = "unban";
                end
                if guildData[i].bannedInfo[4] == "" or guildData[i].bannedInfo[4] == nil then
                    personWhoBanned = "X";
                else
                    personWhoBanned = guildData[i].bannedInfo[4];
                end
                for j = 1 , #GRMsyncGlobals.BanReceivedTemp do
                    if guildData[i].name == GRMsyncGlobals.BanReceivedTemp[j][1] then         -- Potential flaw? Need to check if ban or unban incase of both?
                        isFound = true;
                        break;
                    end
                end

                if not isFound then
                    reason = guildData[i].reasonBanned;
                    if reason == "" then
                        reason = GRM.L ( "No Reason Given" );
                    end

                    table.insert ( GRMsyncGlobals.BanChanges , { guildData[i].name , guildData[i].bannedInfo[2] , tag , reason , GRMsyncGlobals.DesignatedLeader , syncRankFilter , guildData[i].bannedInfo[4] } );
                    -- Since I received no ban info at all on this player, be it ban or unban, yet I have info, I should send it out.

                    -- Player was not found on the ban list
                    tempReasonForLength = GRM_G.PatchDayString .. "?GRM_ADDCUR?" .. GRMsyncGlobals.numGuildRanks .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) .. "?" .. guildData[i].name .. "?" .. tag .. "?" .. tostring ( guildData[i].bannedInfo[2] ) .. "?" .. personWhoBanned  .. "?";

                    if ( #tempReasonForLength + #reason + 8 ) >= 255 then -- 8 represents the GRM_SYNC Prefix length
                        -- We need to snip off the reason partially to shorten it...
                        table.insert ( GRMsyncGlobals.tempListForLongReason , GRM_G.PatchDayString .. "?GRM_RSN?" .. GRMsyncGlobals.numGuildRanks .. "?" .. tostring ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList ) .. "?" .. guildData[i].name .. reason .. "?" .. personWhoBanned );

                        -- elminate the reason, we'll send the full one in a moment.
                        reason = GRM.L ( "No Reason Given" );
                    end
                    -- Send request to ADD player w/ban or unban status.

                    local tempMessage = tempReasonForLength .. reason;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier + 254;
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.channelName );    -- (name , ban/unban , timestamp of ban change)
                    if GRMsyncGlobals.SyncCount > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 254; -- to account for auto sending 1. Little wiggle cushion room here.
                        GRMsyncGlobals.BanCount = i + 1;
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRMsync.CheckingBANChanges ( currentTime , syncRankFilter );
                        end);
                        return;
                    end
                end
            end
        end

        -- Ok, now the BanReceivedTemp list is complete, and player properly added to LeftPlayer's list if necessary.
        local fData = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
        local gData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];

        for i = 1 , #GRMsyncGlobals.BanReceivedTemp do

            tempPlayer = fData[ GRMsyncGlobals.BanReceivedTemp[i][1] ];
            if tempPlayer ~= nil then
                isFound = true;
                -- Let's first check if they have diff. info.
                if GRMsyncGlobals.BanReceivedTemp[i][3] ~= "noban" or ( GRMsyncGlobals.BanReceivedTemp[i][3] == "noban" and ( tempPlayer.bannedInfo[1] or tempPlayer.bannedInfo[3] ) ) then
                    local banStatus = false;
                    if GRMsyncGlobals.BanReceivedTemp[i][3] == "ban" then
                        banStatus = true;
                    end
                    if banStatus ~= tempPlayer.bannedInfo[1] or GRMsyncGlobals.BanReceivedTemp[i][4] ~= tempPlayer.reasonBanned or GRMsyncGlobals.BanReceivedTemp[i][5] == GRM_G.addonUser then
                        local addReceived = false;      -- AM I going to add received data, or my own. One or the other needs to be added for sync
                        if tempPlayer.bannedInfo[2] < GRMsyncGlobals.BanReceivedTemp[i][2] then
                            -- Received Data happened more recently! Need to update change!
                            addReceived = true;         -- In other words, don't add my own data, add the received data.
                        end

                        local changeData;
                        -- Adding Received from other playerZ--[[z]]
                        if addReceived then
                            changeData = GRMsyncGlobals.BanReceivedTemp[i];
                        -- Adding my own data, as it is more current
                        else
                            local msgTag = "ban";
                            if tempPlayer.bannedInfo[3] then
                                msgTag = "unban"
                            end
                            changeData = { tempPlayer.name , tempPlayer.bannedInfo[2] , msgTag , tempPlayer.reasonBanned , GRMsyncGlobals.DesignatedLeader , syncRankFilter , tempPlayer.bannedInfo[4] };
                        end
                        -- Let's see if already indexed by another player!
                        local needToAdd = true;
                        for r = #GRMsyncGlobals.BanChanges , 1 , -1 do
                            if changeData[1] == GRMsyncGlobals.BanChanges[r][1] then
                                -- If bans are going to be the same, no need to change!
                                if changeData[3] == GRMsyncGlobals.BanChanges[r][3] or ( currentTime - changeData[2] ) > ( currentTime - GRMsyncGlobals.BanChanges[2] ) then -- If difference found, but the other change was more recent, no need to add.
                                    needToAdd = false;
                                end

                                -- If needToAdd is still true, then we need to remove the old index.
                                if needToAdd then
                                    table.remove ( GRMsyncGlobals.BanChanges , r );
                                end
                            end
                        end
                        if needToAdd then
                            table.insert ( GRMsyncGlobals.BanChanges , changeData );
                        end
                    end
                end
            end

            -- if not IsFound then...
            if tempPlayer == nil then
                tempPlayer = gData[ GRMsyncGlobals.BanReceivedTemp[i][1] ];

                if tempPlayer ~= nil then
                    -- Let's first check if they have diff. info.
                    if GRMsyncGlobals.BanReceivedTemp[i][3] ~= "noban" or ( GRMsyncGlobals.BanReceivedTemp[i][3] == "noban" and ( tempPlayer.bannedInfo[1] or tempPlayer.bannedInfo[3] ) ) then
                        local banStatus = false;
                        if GRMsyncGlobals.BanReceivedTemp[i][3] == "ban" then
                            banStatus = true;
                        end

                        if banStatus ~= tempPlayer.bannedInfo[1] then
                            local addReceived = false;      -- AM I going to add received data, or my own. One or the other needs to be added for sync
                            if ( currentTime - tempPlayer.bannedInfo[2] ) > ( currentTime - GRMsyncGlobals.BanReceivedTemp[i][2] ) then
                                -- Received Data happened more recently! Need to update change!
                                addReceived = true;         -- In other words, don't add my own data, add the received data.
                            end

                            local changeData;
                            -- Adding Received from other playerZ--[[z]]
                            if addReceived then
                                changeData = GRMsyncGlobals.BanReceivedTemp[i];
                            
                            -- Adding my own data, as it is more current
                            else
                                local msgTag = "ban";
                                if tempPlayer.bannedInfo[3] then
                                    msgTag = "unban"
                                end
                                changeData = { tempPlayer.name , tempPlayer.bannedInfo[2] , msgTag , tempPlayer.reasonBanned , GRMsyncGlobals.DesignatedLeader , syncRankFilter , tempPlayer.bannedInfo[4] };
                            end
                            -- Let's see if already indexed by another player!
                            local needToAdd = true;
                            for r = #GRMsyncGlobals.BanChanges , 1 , -1 do
                                if changeData[1] == GRMsyncGlobals.BanChanges[r][1] then
                                    -- If bans are going to be the same, no need to change!
                                    if changeData[3] == GRMsyncGlobals.BanChanges[r][3] or ( currentTime - changeData[2] ) > ( currentTime - GRMsyncGlobals.BanChanges[2] ) then -- If difference found, but the other change was more recent, no need to add.
                                        needToAdd = false;
                                    end

                                    -- If needToAdd is still true, then we need to remove the old index.
                                    if needToAdd then
                                        table.remove ( GRMsyncGlobals.BanChanges , r );
                                    end
                                end
                            end

                            -- If needToAdd is still true, then we need to remove the old index.
                            if needToAdd then
                                table.insert ( GRMsyncGlobals.BanChanges , changeData );
                            end
                        end
                    end
                end
            end
        end
        -- Ok send comms for the lengthy reasons...
        GRMsync.tempListLongReasonManagement();
        GRMsyncGlobals.BansCheckFinished = true;
        GRMsyncGlobals.BanReceivedTemp = {};
        GRMsyncGlobals.BanCount = 2;
    else
        GRMsyncGlobals.BanReceivedTemp = {};
    end
end

-- Method:          GRMsync.tempListLongReasonManagement()
-- What it Does:    For lengthy comms, due to the limit, they are broken up into this array and sent at the end
-- Purpose:         To allow lengthy input on the Ban reasons...
GRMsync.tempListLongReasonManagement = function()
    for i = GRMsyncGlobals.BanListLongCount , #GRMsyncGlobals.tempListForLongReason do
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #GRMsyncGlobals.tempListForLongReason[i] + GRMsyncGlobals.sizeModifier;
        if GRMsyncGlobals.SyncCount > GRMsyncGlobals.ThrottleCap then
            GRMsyncGlobals.SyncCount = 0;
            GRMsyncGlobals.BanListLongCount = i;
            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                GRMsync.tempListLongReasonManagement();
            end);
            return;
        else
            GRMsync.SendMessage ( "GRM_SYNC" , GRMsyncGlobals.tempListForLongReason[i] , GRMsyncGlobals.channelName );
        end
    end
    GRMsyncGlobals.BanListLongCount = 1;
    GRMsyncGlobals.tempListForLongReason = {};
end

-- Method:          GRMsync.CheckingMAINChanges ( int , int )
-- What it Does:    After receiving ALL of the Main info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingMAINChanges = function ( currentTime , syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local isFound = false;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    
    for j = 1 , #exactIndexes[4] do
        isFound = false;
        for i = 1 , #GRMsyncGlobals.MainReceivedTemp do

            if guildData[exactIndexes[4][j]].name == GRMsyncGlobals.MainReceivedTemp[i][1] then
                isFound = true;
                -- Alright, now let's see if our data matches up!
                if guildData[exactIndexes[4][j]].isMain ~= GRMsyncGlobals.MainReceivedTemp[i][2] then
                    -- If it does, then do nothing... however, if it does, do the following...
                    local addReceived = false;      -- AM I going to add received data, or my own. One or the other needs to be added for sync

                    if ( currentTime - guildData[exactIndexes[4][j]].mainStatusChangeTime ) > ( currentTime - GRMsyncGlobals.MainReceivedTemp[i][3] ) then
                        addReceived = true;         -- In other words, don't add my own data, add the received data.
                    end

                    local changeData;
                    -- Adding Received from other player
                    if addReceived then
                        changeData = GRMsyncGlobals.MainReceivedTemp[i];
                        -- Adding my own data, as it is more current
                    else
                        changeData = { guildData[exactIndexes[4][j]].name , guildData[exactIndexes[4][j]].isMain , guildData[exactIndexes[4][j]].mainStatusChangeTime , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                    end

                    -- Need to check if change has not already been added, or if another player added info that is more recent! (Might need review for increased performance)
                    local needToAdd = true;
                    for r = #GRMsyncGlobals.AltMainChanges , 1 , -1 do
                        if changeData[1] == GRMsyncGlobals.AltMainChanges[r][1] then        -- Player matched! Already added to the "Main" table!
                            -- If main status is the same, no need to change em!
                            if changeData[2] == GRMsyncGlobals.AltMainChanges[r][2] or ( currentTime - changeData[3] ) > ( currentTime - GRMsyncGlobals.AltMainChanges[3] ) then
                                needToAdd = false;
                            end

                            -- If needToAdd is still true, then we need to remove the old index.
                            if needToAdd then
                                table.remove ( GRMsyncGlobals.AltMainChanges , r );
                            end
                        end
                    end

                    -- Now let's add it!
                    if needToAdd then
                        table.insert ( GRMsyncGlobals.AltMainChanges , changeData );
                    end
                end                        
                break;
            end
        end

        if not isFound and guildData[exactIndexes[4][j]].mainStatusChangeTime ~= 0 then
            table.insert ( GRMsyncGlobals.AltMainChanges , { guildData[exactIndexes[4][j]].name , guildData[exactIndexes[4][j]].isMain , guildData[exactIndexes[4][j]].mainStatusChangeTime , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
        end

    end

    -- Now, let's purge repeats, as only 1 of an alt-grouping needs to be modified.
    local listToRemove = {};

    for i = 1 , #GRMsyncGlobals.AltMainChanges do                                                                                                                                       -- Cycle through all results.
        if GRMsyncGlobals.AltMainChanges[i][2] then                -- Only need to cycle through the alts where they are set to be listed as main, not demoted.
            
            local tempAlt = guildData[ GRMsyncGlobals.AltMainChanges[i][1] ];
            if tempAlt ~= nil then
                local altList = tempAlt.alts;
                -- Now that I have the altList, I should see if any of them match this main
                for r = 1 , #altList do
                    for s = 1 , #GRMsyncGlobals.AltMainChanges do
                        if altList[r][1] == GRMsyncGlobals.AltMainChanges[s][1] then
                            table.insert ( listToRemove , altList[r][1] );

                            break;
                        end
                    end
                end
            end
        end
    end
    -- Let's purge the changes!
    while #listToRemove > 0 do
        for i = 1 , #GRMsyncGlobals.AltMainChanges do
            if GRMsyncGlobals.AltMainChanges[i][1] == listToRemove[1] then
                table.remove ( GRMsyncGlobals.AltMainChanges , i );
                break;
            end
        end
        table.remove ( listToRemove , 1 );
    end
    
    -- Resetting the temp tables!
    GRMsyncGlobals.MainReceivedTemp = {};
end


-- Method:          GRMsync.CheckingCustomNoteChanges ( int , int )
-- What it Does:    After receiving ALL of the CustomNote info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingCustomNoteChanges = function ( syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local isFound;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

    if exactIndexes[6] ~= nil then
        for j = 1 , #exactIndexes[6] do
            isFound = false;
            for i = 1 , #GRMsyncGlobals.CustomNoteReceivedTemp  do
                if guildData[exactIndexes[6][j]].name == GRMsyncGlobals.CustomNoteReceivedTemp[i][1] then
                    
                    isFound = true;
                    local addReceived = false;      -- AM I going to add received data, or my own. One or the other needs to be added for sync
                    if ( guildData[exactIndexes[6][j]].customNote[2] < GRMsyncGlobals.CustomNoteReceivedTemp[i][2] ) or not guildData[exactIndexes[6][j]].customNote[1] then
                        -- Received Data happened more recently! Need to update change!
                        addReceived = true;         -- In other words, don't add my own data, add the received data.
                    end

                    -- Setting the change data properly.
                    local changeData;
                    -- Adding Received from other player
                    -- 
                    if addReceived then
                        changeData = GRMsyncGlobals.CustomNoteReceivedTemp[i];
                    -- Adding my own data, as it is more current
                    else
                        local customNote = guildData[exactIndexes[6][j]].customNote[6];
                        if customNote == "" then
                            customNote = "X&&X";
                        end
                        changeData = { guildData[exactIndexes[6][j]].name , guildData[exactIndexes[6][j]].customNote[2] , guildData[exactIndexes[6][j]].customNote[3] , guildData[exactIndexes[6][j]].customNote[4] , customNote , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                    end

                    -- Need to check if change has not already been added, or if another player added info that is more recent! (Might need review for increased performance)
                    local needToAdd = true;
                    for r = #GRMsyncGlobals.CustomNoteChanges , 1 , -1 do
                        if changeData[1] == GRMsyncGlobals.CustomNoteChanges[r][1] then
                            -- If dates are the same, no need to change em!
                            if changeData[2] < GRMsyncGlobals.CustomNoteChanges[r][2] then
                                needToAdd = false;
                            end

                            -- If needToAdd is still true, then we need to remove the old index.
                            if needToAdd then
                                table.remove ( GRMsyncGlobals.CustomNoteChanges , r );
                            end
                        end
                    end

                    -- If needToAdd is still true, then we need to remove the old index.
                    if needToAdd then
                        table.insert ( GRMsyncGlobals.CustomNoteChanges , changeData );
                    end
                    break;
                end
            end
            if not isFound and guildData[exactIndexes[6][j]].customNote[1] and guildData[exactIndexes[6][j]].customNote[2] ~= 0 then
                local customNote = guildData[exactIndexes[6][j]].customNote[6];
                if customNote == "" then
                    customNote = "X&&X";
                end
                table.insert ( GRMsyncGlobals.CustomNoteChanges , { guildData[exactIndexes[6][j]].name , guildData[exactIndexes[6][j]].customNote[2] , guildData[exactIndexes[6][j]].customNote[3] , guildData[exactIndexes[6][j]].customNote[4] , customNote , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
            end
        end
    end
    -- guildData = guildData;
    GRMsyncGlobals.CustomNoteReceivedTemp = {};
end

-- Method:          GRMsync.CheckingBdayChanges ( int )
-- What it Does:    Establishes what needs to be kept and what needs to be removed
-- Purpose:         Controlling the flow of the sync info!
GRMsync.CheckingBdayChanges = function ( syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local changeData = {};
    local isFound = false;
    local needToAddMyData = false;
    local list = GRM.GetAllGuildiesInOrder ( true , true );
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

    -- No need to check my data if I am not going to share it. I must just accept their data and pass it along. I just wont' absorb it and then people will rely on their filters.
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncBDays then
        -- Just checking my own data first...
        for j = 1 , #exactIndexes[7] do
            for i = #list , 1 , -1 do
                if guildData[exactIndexes[7][j]].name == list[i][1] then
                    if guildData[exactIndexes[7][j]].events[2][4] ~= 0 then       -- Birthday set!
                        -- Cleanup the list to save on additional parses
                        list = GRMsync.RemoveAltGroupingFromList ( guildData[exactIndexes[7][j]].name , guildData[exactIndexes[7][j]].alts , list );
                        -- Reset this data for the loop find.
                        changeData = {};
                        isFound = false;
                        needToAddMyData = false;
                        -- Now, let's see what is best data. Mine, or received player's
                        for i = #GRMsyncGlobals.BirthdayReceivedTemp , 1 , -1 do
                            if guildData[exactIndexes[7][j]].name == GRMsyncGlobals.BirthdayReceivedTemp[i][1] then
                                -- Let's check who has more current data...
                                isFound = true;
                                if guildData[exactIndexes[7][j]].events[2][4] >= GRMsyncGlobals.BirthdayReceivedTemp[i][5] then     -- syncLeader Data more current, though both had birthdays set...
                                    if guildData[exactIndexes[7][j]].events[2][4] > GRMsyncGlobals.BirthdayReceivedTemp[i][5] then
                                        needToAddMyData = true;
                                    end
                                else
                                    changeData = GRMsyncGlobals.BirthdayReceivedTemp[i];
                                end
                                table.remove ( GRMsyncGlobals.BirthdayReceivedTemp , i );-- We've dealt with this now and it can be removed.
                                break;
                            end
                        end
                        -- If my data has a birthdate, but I have not seen any from other players...
                        if not isFound or needToAddMyData then
                            -- Do an altName check
                            local isFound = false;
                            for k = 1 , #guildData[exactIndexes[7][j]].alts do
                                isFound = false;
                                for m = 1 , #GRMsyncGlobals.BirthdayReceivedTemp do
                                    if guildData[exactIndexes[7][j]].alts[k][1] == GRMsyncGlobals.BirthdayReceivedTemp[m][1] then
                                        -- Alt Name Found in temp database!
                                        isFound = true;
                                        break;
                                    end
                                end
                                if isFound then
                                    break;
                                end
                            end

                            if not isFound then
                                changeData = { guildData[exactIndexes[7][j]].name , guildData[exactIndexes[7][j]].events[2][1][1] , guildData[exactIndexes[7][j]].events[2][1][2] , guildData[exactIndexes[7][j]].events[2][3] , guildData[exactIndexes[7][j]].events[2][4] , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                            end
                        end

                        if #changeData ~= 0 then
                            table.insert ( GRMsyncGlobals.BDayChanges , changeData );
                        end
                    end

                    break;
                end
            end
        end

        -- Now check the received
        for j = 2 , #exactIndexes[7] do
            for i = 1 , #GRMsyncGlobals.BirthdayReceivedTemp do
                if guildData[exactIndexes[7][j]].name== GRMsyncGlobals.BirthdayReceivedTemp[i][1] then
                    needToAddMyData = false;
                    changeData = {};

                    if guildData[exactIndexes[7][j]].events[2][4] ~= 0 and guildData[exactIndexes[7][j]].events[2][4] >= GRMsyncGlobals.BirthdayReceivedTemp[i][5] then
                        if guildData[exactIndexes[7][j]].events[2][4] > GRMsyncGlobals.BirthdayReceivedTemp[i][5] then
                            changeData = { guildData[exactIndexes[7][j]][1] , guildData[exactIndexes[7][j]].events[2][1][1] , guildData[exactIndexes[7][j]].events[2][1][2] , guildData[exactIndexes[7][j]].events[2][3] , guildData[exactIndexes[7][j]].events[2][4] , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                        end
                    else
                        changeData = GRMsyncGlobals.BirthdayReceivedTemp[i];
                    end
    
                    if #changeData ~= 0 then
                        table.insert ( GRMsyncGlobals.BDayChanges , changeData );
                    end

                    break;
                end
            end
        end
    else
        -- Just accept all the changes since you are not comparing to your own data...
        GRMsyncGlobals.BDayChanges = GRMsyncGlobals.BirthdayReceivedTemp;
    end
    -- Wipe the data!
    -- Final step of the sync process! Let's submit the final changes!!!
    GRMsyncGlobals.BirthdayReceivedTemp = {};
end

-- Method:          GRMsync.CheckAltChanges()
-- What it Does:    Compares the Leader's data to the received's data
-- Purpose:         Let's analyze the alt lists!
GRMsync.CheckAltChanges = function()
-- Ok, first things first, I need to compile both tables
    local leaderListOfAlts = {};
    local leaderListOfRemovedAlts = {};

    local syncRankFilter = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
        syncRankFilter = GuildControlGetNumRanks() - 1;
    end

    local guildData = GRMsyncGlobals.guildData;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

    -- Let's first get the leader's alt data to compare.
    for j = 1 , #exactIndexes[3] do

        -- initializing empty tables for each of the leader's players
        table.insert ( leaderListOfAlts , { guildData[exactIndexes[3][j]].name , {} } );
        table.insert ( leaderListOfRemovedAlts , { guildData[exactIndexes[3][j]].name , {} } );

        -- Build leader alt Tables for easier coding
        for i = 1 , #guildData[exactIndexes[3][j]].alts do
            table.insert ( leaderListOfAlts[ #leaderListOfAlts ][2] , { guildData[exactIndexes[3][j]].alts[i][1] , guildData[exactIndexes[3][j]].alts[i][6] } ); -- AN extra step, but easier to follow in the code.
        end
                
        -- Building leader removed alt tables.
        for i = 1 , #guildData[exactIndexes[3][j]].removedAlts do
            table.insert ( leaderListOfRemovedAlts[ #leaderListOfRemovedAlts ][2] , { guildData[exactIndexes[3][j]].removedAlts[i][1] , guildData[exactIndexes[3][j]].removedAlts[i][6] } ); -- AN extra step, but easier to follow in the code.
        end
    end
    -- Now we can compare!!!
    
    ----------------------------------------------
    ----- CHECKING AGAINST LEADER'S DATA  --------
    ----------------------------------------------
    for i = 1 , #leaderListOfAlts do                                                                -- Cycling through every single player in the guild in leader's database

        for j = 1 , #GRMsyncGlobals.AltReceivedTemp do                                              -- Cycling through the alt list of guildie to receive comparative info!
            if leaderListOfAlts[i][1] == GRMsyncGlobals.AltReceivedTemp[j][1] then                  -- We have a match! Let's compare the alt tables of both players now.

                -- First, check if any missing.
                -- Checking if all of leader's data is found in received's
                local altIsMatched = false;

                -- STEP 1: LEADER DATA!!!!
                -- Comparing alt lists held by leader...
                for r = 1 , #leaderListOfAlts[i][2] do
                    altIsMatched = false;
                    for s = 1 , #GRMsyncGlobals.AltReceivedTemp[j][2] do
                        if leaderListOfAlts[i][2][r][1] == GRMsyncGlobals.AltReceivedTemp[j][2][s][1] then
                            altIsMatched = true;
                            -- if true, it's a match, move on!
                            break;
                        end
                    end

                    -- No match, potentially need to add to Received, or be removed from leader! Must compare timestamps!
                    if not altIsMatched then            -- No match was found. In other words, the leader has an alt listed, but the received player does not!

                        -- Ok, the ONLY way to know what is the correct course of action:
                        -- If I am going to ADD this, I must do 2 things. First, check if the receiving player has them on the removed list, and if so, Second, compare timestamps to know proper action
                        local addLeadersData = false;
                        local syncPlayerEpoch = -1;
                        for m = 1 , #GRMsyncGlobals.AltRemReceivedTemp do
                            if GRMsyncGlobals.AltRemReceivedTemp[m][1] == leaderListOfAlts[i][1] then -- Ok, an alt has been removed by the receiving player "currentSyncPlayer" - we don't yet know if the alt we are looking for is the removed one

                                -- If there are no added values, no need to do extra work!
                                if #GRMsyncGlobals.AltRemReceivedTemp[m][2] > 0 then

                                    local altRemMatched = false;
                                    for n = 1 , #GRMsyncGlobals.AltRemReceivedTemp[m][2] do
                                        if GRMsyncGlobals.AltRemReceivedTemp[m][2][n][1] == leaderListOfAlts[i][2][r][1] then           -- Leader's alt DID match the removed!!! Must compare timestamps!!!
                                            altRemMatched = true;
                                            -- We have a match! Must see which was the more current event!!!
                                            if GRMsyncGlobals.AltRemReceivedTemp[m][2][n][2] < leaderListOfAlts[i][2][r][2] then
                                                -- Leader's time is most recent!!!
                                                addLeadersData = true;
                                            else
                                                addLeadersData = false;
                                                syncPlayerEpoch = GRMsyncGlobals.AltRemReceivedTemp[m][2][n][2];
                                            end
                                            break;
                                        end
                                    end

                                    if not altRemMatched then           -- Leader's alt was not found among received's removed data.
                                        addLeadersData = true;
                                    end
                                else
                                    addLeadersData = true;              -- No need to do any work if the received's data has ZERO removed players to begin with!
                                end

                                    break;
                            end
                        end

                        if addLeadersData then
                            -- Alt is to be added.
                            GRMsync.AddToProperAltTable ( leaderListOfAlts[i][1] , leaderListOfAlts[i][2][r][1] , leaderListOfAlts[i][2][r][2] , true , GRMsyncGlobals.DesignatedLeader , syncRankFilter );
                        else
                            -- Alt is to be removed.
                            GRMsync.AddToProperAltTable ( leaderListOfAlts[i][1] , leaderListOfAlts[i][2][r][1] , syncPlayerEpoch , false , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement );
                        end
                    end

                end
                altIsMatched = false;

                -- STEP2: RECEIVED DATA
                -- Comparing alt lists held by received...
                for r = 1 , #GRMsyncGlobals.AltReceivedTemp[j][2] do
                    altIsMatched = false;
                    for s = 1 , #leaderListOfAlts[i][2] do
                        if leaderListOfAlts[i][2][s][1] == GRMsyncGlobals.AltReceivedTemp[j][2][r][1] then
                            altIsMatched = true;
                            -- if true, it's a match, move on!
                            break;
                        end
                    end

                    -- No match, potentially need to add to leader, or be removed from received! Must compare timestamps!
                    if not altIsMatched then            -- No match was found. In other words, the received has an alt listed, but the leader does not!
                
                        local addReceivedAltData = false;
                        local epochStampLeader = -1;
                        -- Ok, the ONLY way to know what is the correct course of action:
                        -- If I am going to ADD this, I must do 2 things. First, check if the leader has them on the removed list, and if so, Second, compare timestamps to know proper action (whichever was most recent.)

                        for m = 1 , #leaderListOfRemovedAlts do
                            if leaderListOfRemovedAlts[m][1] == GRMsyncGlobals.AltReceivedTemp[j][1] then -- Ok, an alt has been removed by leader... we know this now. We don't yet know if the alt we are looking for is the one removed

                                -- If there are no added values, no need to do extra work!
                                if #leaderListOfRemovedAlts[m][2] > 0 then

                                    local altRemMatched = false;
                                    for n = 1 , #leaderListOfRemovedAlts[m][2] do
                                        if leaderListOfRemovedAlts[m][2][n][1] == GRMsyncGlobals.AltReceivedTemp[j][2][r][1] then           -- Received's alt DID match the removed!!! Must compare timestamps!!!
                                            
                                            altRemMatched = true;
                                            -- We have a match! Must see which was the more current event!!!
                                            if GRMsyncGlobals.AltReceivedTemp[j][2][r][2] < leaderListOfRemovedAlts[m][2][n][2] then
                                                -- Alt's time is most recent!!!
                                                addReceivedAltData = false;
                                                epochStampLeader = leaderListOfRemovedAlts[m][2][n][2];
                                            else
                                                addReceivedAltData = true;
                                            end
                                            break;
                                        end
                                    end

                                    if not altRemMatched then           -- Leader's alt was not found among received's removed data.
                                        addReceivedAltData = true;
                                    end

                                else
                                    addReceivedAltData = true;              -- No need to do any work if the received's data has ZERO removed players to begin with!                                            
                                end

                                break;
                            end
                        end
                        if addReceivedAltData then
                            GRMsync.AddToProperAltTable ( GRMsyncGlobals.AltReceivedTemp[j][1] , GRMsyncGlobals.AltReceivedTemp[j][2][r][1] , GRMsyncGlobals.AltReceivedTemp[j][2][r][2] , true , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement );
                        else
                            GRMsync.AddToProperAltTable ( GRMsyncGlobals.AltReceivedTemp[j][1] , GRMsyncGlobals.AltReceivedTemp[j][2][r][1] , epochStampLeader , false , GRMsyncGlobals.DesignatedLeader , syncRankFilter );
                        end                                
                    end
                end

                break;
            end
        end
    end

    GRMsyncGlobals.AltReceivedTemp = {};
    GRMsyncGlobals.AltRemReceivedTemp = {};
end

-- Method:          GRMsync.PreCheckChanges( string )
-- What it Does:    Controls the flow of changes. No need to checkForChanges if player has only sent minimal data
-- Purpose:         A leaner sync algorithm!
GRMsync.PreCheckChanges = function ( msg , banSyncCheck )
    local lists = { "JD" , "PD" , "BAN" , "MAIN" , "" ,  "CUSTOM" , "BDAY" };

    if not banSyncCheck then
        for i = 1 , #lists do
            if string.sub ( msg , 1 , string.find ( msg , "?" ) -1 ) == "true" then
                if i ~= 5 then
                    GRMsync.CheckChanges ( lists[i] );
                else
                    GRMsync.CheckAltChanges();
                end
            elseif i == 3 then
                GRMsyncGlobals.BansCheckFinished = true;
            end
            if i < #lists then
                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
            end
        end
    end

    if not GRMsyncGlobals.BansCheckFinished then
        C_Timer.After ( 1 , function()
            GRMsync.PreCheckChanges ( "" , true );
        end);
        return;
    end
    GRMsync.SubmitFinalSyncData();
end

-- Method:          GRMsync.CheckChanges ( string , string )
-- What it Does:    Checks to see if the received data and the leader's data is different and then adds the most recent changes to update que
-- Purpose:         Retroactive Sync Procedure fully defined here in this method. MUCH WORK!
GRMsync.CheckChanges = function ( msg )
    local currentTime = time();

    local syncRankFilter = GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank;
    if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks then
        syncRankFilter = GuildControlGetNumRanks() - 1;
    end

    if GRMsyncGlobals.DatabaseExactIndexes[1] == nil then
        GRMsync.BuildFullCheckArray();
    end

    -----------------------------
    -- For Join Date checking!
    -----------------------------
    if msg == "JD" then
        GRMsync.CheckingJDChanges ( currentTime , syncRankFilter );

    -----------------------------
    -- For Promo Date checking!
    -----------------------------
    elseif msg == "PD" then
        GRMsync.CheckingPDChanges ( currentTime , syncRankFilter );

    -----------------------------
    --- FOR BAN STATUS CHECK ----
    -----------------------------
    elseif msg == "BAN" then
        GRMsync.CheckingBANChanges ( currentTime , syncRankFilter );

    -----------------------------
    -- For Main Change checking!
    -----------------------------
    elseif msg == "MAIN" then
        GRMsync.CheckingMAINChanges ( currentTime , syncRankFilter );

    -----------------------------
    -- For Custom Note checking!
    -----------------------------
    elseif msg == "CUSTOM" then
        GRMsync.CheckingCustomNoteChanges ( syncRankFilter );
    
    -----------------------------
    -- For BIRTHDAY checking!
    -----------------------------
    elseif msg == "BDAY" then
        GRMsync.CheckingBdayChanges ( syncRankFilter );
    end
end

-- Method:          GRMsync.ReportResults()
-- What it Does:    Builds the string of all results and reports it to chat window
-- Purpose:         Give player information on what has been updated.
GRMsync.ReportResults = function()
    local results = "";
    
    local addedSpace = function ( num )
        if num < 10 then
            return "  ";
        elseif num < 100 then
            return " ";
        else
            return "";
        end
    end

    for i = 1 , #GRMsyncGlobals.upatesEach do
        if i == 1 and GRMsyncGlobals.upatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Join Dates" , nil , nil , GRMsyncGlobals.upatesEach[i] , addedSpace ( GRMsyncGlobals.upatesEach[i] ) );
        elseif i == 2 and GRMsyncGlobals.upatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Promo Dates" , nil , nil , GRMsyncGlobals.upatesEach[i] , addedSpace ( GRMsyncGlobals.upatesEach[i] ) );
        elseif i == 3 and GRMsyncGlobals.upatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Alts" , nil , nil , GRMsyncGlobals.upatesEach[i] , addedSpace ( GRMsyncGlobals.upatesEach[i] ) );
        elseif i == 4 and GRMsyncGlobals.upatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Main Tags" , nil , nil , GRMsyncGlobals.upatesEach[i] , addedSpace ( GRMsyncGlobals.upatesEach[i] ) );
        elseif i == 5 and GRMsyncGlobals.upatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Custom Notes" , nil , nil , GRMsyncGlobals.upatesEach[i] , addedSpace ( GRMsyncGlobals.upatesEach[i] ) );
        elseif i == 6 and GRMsyncGlobals.upatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Birthdays" , nil , nil , GRMsyncGlobals.upatesEach[i] , addedSpace ( GRMsyncGlobals.upatesEach[i] ) );
        end
    end
    -- For extra aesthetics.
    if #results > 0 then
        results = results .. "\n";
    end
    GRM.Report ( results );
end

-- Method:          GRMsync.ReportSyncCompletion ( string , boolean )
-- What it Does:    Reports to the chat that the sync is complete a more custom sync message, with the player's name, or more specifically, of all guildies.
-- Purpose:         Cleaner reporting.
GRMsync.ReportSyncCompletion = function ( currentSyncer , finalAnnounce )
    if time() - GRMsyncGlobals.AnnounceDelay > 5 then
        if ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled or GRM_G.TemporarySync ) and ( GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].exportAllRanks ) then
            local announce = "";
            
            if GRM_G.TemporarySync and finalAnnounce then
                GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncEnabled = false;
                GRM_G.TemporarySync = false;
                GRMsync.MessageTracking:UnregisterAllEvents();
                GRMsync.ResetDefaultValuesOnSyncReEnable();         -- Reset values to default, so that it resyncs if player re-enables.
                GRM_UI.GRM_RosterChangeLogFrame.GRM_OptionsFrame.GRM_SyncOptionsFrame.GRM_RosterSyncCheckButton:SetChecked ( false );
                announce = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Manual Sync With Guildies Complete..." );
            elseif GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then

                if finalAnnounce then
                    announce = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync With Guildies Complete..." , currentSyncer );
                else
                    announce = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync With {name} is Complete..." , currentSyncer );
                end
            end
            GRMsyncGlobals.timeOfLastSyncCompletion = time();

            if GRMsyncGlobals.updateCount > 0 then
                announce = announce .. " (" .. GRM.L ( "{num} Items Updated" , nil , nil , GRMsyncGlobals.updateCount ) .. ")";
            else
                announce = announce .. " (" .. GRM.L ( "No Updates" ) .. ")";
            end
            GRM.Report ( announce );
            GRMsync.ReportResults();
            GRMsync.ReportAuditMessage();
        end

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
            GRM.RefreshAuditFrames ( true , true );
        end
        if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
            GRM_G.LogNumbersColorUpdate = true;
            GRM.BuildLogComplete( true , true );
        end

        if GRM_UI.GRM_ToolCoreFrame:IsVisible() then
            GRM_UI.RefreshManagementTool();
        end
        
        if GRM_UI.GRM_LoadToolButton:IsVisible() then
            GRM_UI.RefreshToolButtonsOnUpdate();
        end

        local playerCount = GRMsyncGlobals.AddLeftPlayerCount;
        if playerCount > 0 then
            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncChatEnabled then
                C_Timer.After ( 2 , function()
                    if playerCount > 1 then
                        GRM.Report ( GRM.L ( "{num} metadata profiles are being built for people previously in the guild. The data is being requested, but this may take some time." , nil , nil , playerCount ) );
                    else    
                        GRM.Report ( GRM.L ( "One metadata profile is being built for a player previously in the guild. The data is being requested, but this may take some time." ) );
                    end
                end);
            end
        end

        GRMsyncGlobals.updateCount = 0;
        GRMsyncGlobals.upatesEach = { 0 , 0 , 0 , 0 , 0 , 0 };
        GRMsyncGlobals.AddLeftPlayerCount = 0;
        GRMsyncGlobals.errorCheckEnabled = false;
        GRMsyncGlobals.currentlySyncing = false;

        GRMsyncGlobals.AnnounceDelay = time();
    end
end

-----------------------------------
---- ERROR PROTECTIONS ON SYNC ----
-----------------------------------

-- Method:          GRMsync.RemoveAltErrorFix( string )
-- What it Does:    Sends a remove main exception, in case player sends info telling them to add an alt, yet the alt does not exist.
-- Purpose:         Information control from corrupted, bad, or nefarious data, jarbled old verison. This is to keep me from asking players to reset their data in case it happens.
--                  I COULD ask them to just reset it, but I gave my word I would never do that once the addon went live. This is just backup so I can stick to my word.
GRMsync.RemoveAltErrorFix = function( msg )
    local name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
    local altName = string.sub ( msg , string.find ( msg , "?" ) + 1 );

    GRM.RemoveAltTest ( altName , false , 0 );
end

-------------------------------
------ INITIALIZING -----------
-------------------------------

-- Rather than have locals rebuild and reset over and over and over everytime it is called, now keep them in this local table for endless reuse.
local comms = {};
comms.isFound = false;
comms.abortSync = false;
comms.versionCheckEpoch = 0;
comms.prefix2 = "";
comms.senderRankRequirement = nil;
comms.senderRankRequirement = 0;

-- Method:          GRMsync.RegisterCommunicationProtocols()
-- What it Does:    Establishes the channel communication rules for sending and receiving
-- Purpose:         Need to make rules to get this to behave properly!
GRMsync.RegisterCommunicationProtocols = function()
    GRMsync.MessageTracking:RegisterEvent ( "CHAT_MSG_ADDON" );
    GRMsync.MessageTracking:SetScript ( "OnUpdate" , GRMsync.MessageThrottleUpdate );
    -- Register used prefixes!
    GRMsync.RegisterPrefixes ( GRMsyncGlobals.listOfPrefixes );

    -- Setup tracking...
    GRMsync.MessageTracking:SetScript ( "OnEvent" , function( self , event , prefix , msg , channel , sender )
        if not GRMsyncGlobals.SyncOK or not IsInGuild() then
            self:UnregisterAllEvents();
        else

            if event == "CHAT_MSG_ADDON" and channel == GRMsyncGlobals.channelName and GRMsync.IsPrefixVerified ( prefix ) then     -- Don't need to register my own sends.

                -- Sender must not equal themselves...
                if sender ~= GRM_G.addonUser then
                    
                    -- Version Control Check First....
                    -- First, see if they are on compatible list.
                    comms.isFound = false;
                    if GRMsyncGlobals.CompatibleAddonUsers[sender] ~= nil then
                        comms.isFound = true;
                    end

                    -- See if they are on the incompatible list.
                    comms.abortSync = false;
                    comms.versionCheckEpoch = 0;
                    if not comms.isFound then

                        -- If you make it to this point, it means the player is not on the compatible list, and they are not on the incompatible list, they have never been checked...
                        -- Let's do it now!
                        -- Due to older verisons... need to check if this is nil. It will be nil for many. To prevent Lua error/crash.
                        if tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) ) ~= nil then
                            comms.versionCheckEpoch = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncSameVersion and comms.versionCheckEpoch < GRM_G.PatchDay then                   -- if the player sending data to you has an older version (smaller epoch number)                       
                                comms.abortSync = true;
                            else
                                GRMsyncGlobals.CompatibleAddonUsers[sender] = {};
                            end
                        else
                            -- Older versions are incompatible, regardless of setting...
                            comms.abortSync = true;
                        end                            
                    end
                    
                    -- Let's strip out the version timestamp of the sender, as well as the custom prefix.
                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                    comms.prefix2 = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );

                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                    -- Determine if this is a retroactive sync message, or a live sync.
                    if comms.prefix2 == "GRM_JDSYNCUP" or comms.prefix2 == "GRM_PDSYNCUP" or comms.prefix2 == "GRM_ALTSYNCUP" or comms.prefix2 == "GRM_REMSYNCUP" or comms.prefix2 == "GRM_MAINSYNCUP" or comms.prefix2 == "GRM_CUSTSYNCUP" or comms.prefix2 == "GRM_BDSYNCUP" or comms.prefix2 == "GRM_BANSYNCUP" then
                        sender = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                    end
                    -- To cleanup Lua errors from very old versions trying to communicate...
                    comms.senderRankRequirement = nil;
                    if string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) ~= nil then

                        comms.senderRankRequirement = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                        if comms.senderRankRequirement == nil then
                            -- ABORT
                            return
                        end
                        if sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.CurrentSyncPlayerRankRequirement = comms.senderRankRequirement;
                        end
                    else
                        if not GRM_G.SyncOutdatedReport then
                            GRM_G.SyncOutdatedReport = true
                            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncCompatibilityMsg then
                                -- If this is nil, you are getting spammed from player with VERY old version
                                GRM.Report ( "|cff00c8ff" .. GRM.L ( "GRM:" ) .. " |cffffffff" .. GRM.L ( "{name} tried to Sync with you, but their addon is outdated." , GRM.GetClassifiedName ( sender , true ) ) .. "\n|cffff0044" .. GRM.L ( "Remind them to update!" ) );
                                local count = GRM.GetNumAddonUsersOutdated();
                                if count > 1 then
                                    GRM.Report ( GRM.L ( "{num} guild members have outdated GRM versions" , nil , nil , count ) );
                                end
                            end
                        end
                        return;
                    end
                    comms.senderRankID = GRM.GetGuildMemberRankID ( sender );
                    -- Sender is not the designatedleader then return... Higher means lower in-game... 1 = guild leader; 10 = lowest initiate rank. So, if rank is higher than the restricted, it won't work. -- if the comms.senderRankRequirement is lower than the receiving player, then that means it won't sync either.
                    -- of note, leadership role will not be rank restricted, but it will send out restricted data with rank tags on it so others know not to sync it or not. In the meantime the leader will build a temporary database to parry against during sync
                    -- This allows all sync information to be shared, but capable of being restricted by the sending party.
                    if ( comms.prefix2 == "GRM_JD" or comms.prefix2 == "GRM_PD" or comms.prefix2 == "GRM_ADDALT" or comms.prefix2 == "GRM_AC" or comms.prefix2 == "GRM_RMVALT" or comms.prefix2 == "GRM_MAIN" or comms.prefix2 == "GRM_RMVMAIN" or comms.prefix2 == "GRM_BDAY" or comms.prefix2 == "GRM_BDAYREM" or comms.prefix2 == "GRM_JDSYNCUP" or comms.prefix2 == "GRM_PDSYNCUP" or comms.prefix2 == "GRM_ALTSYNCUP" or comms.prefix2 == "GRM_REMSYNCUP" or comms.prefix2 == "GRM_MAINSYNCUP" or comms.prefix2 == "GRM_BDSYNCUP" or comms.prefix2 == "GRM_BANSYNCUP" ) and ( comms.senderRankRequirement < GRM_G.playerRankID or comms.senderRankID > GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank ) then
                        return

                    elseif ( comms.prefix2 == "GRM_CNOTE" or comms.prefix2 == "GRM_CUSTSYNCUP" ) and ( comms.senderRankRequirement < GRM_G.playerRankID or comms.senderRankID > GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankCustom ) then
                        return

                    elseif ( not GRMsyncGlobals.IsElectedLeader and ( comms.prefix2 ~= "GRM_WHOISLEADER" and comms.prefix2 ~= "GRM_IAMLEADER" and comms.prefix2 ~= "GRM_ELECT" and comms.prefix2 ~= "GRM_TIMEONLINE" and comms.prefix2 ~= "GRM_NEWLEADER" ) and sender ~= GRMsyncGlobals.DesignatedLeader ) and ( comms.senderRankID > GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRank or comms.senderRankRequirement < GRM_G.playerRankID ) then        -- If player's rank is below settings threshold, ignore message.
                        return
                    
                    elseif comms.abortSync and not comms.isFound then
                        -- placing the comms.abortSync notification AFTER the rank check to avoid confusion and not get the error message if someone is not proper sync rank.
                        if not GRM_G.SyncOutdatedReport then
                            GRM_G.SyncOutdatedReport = true
                            if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncCompatibilityMsg then
                                -- If this is nil, you are getting spammed from player with VERY old version
                                GRM.Report ( "|cff00c8ff" .. GRM.L ( "GRM:" ) .. " |cffffffff" .. GRM.L ( "{name} tried to Sync with you, but their addon is outdated." , GRM.GetClassifiedName ( sender , true ) ) .. "\n|cffff0044" .. GRM.L ( "Remind them to update!" ) );
                                local count = GRM.GetNumAddonUsersOutdated();
                                if count > 1 then
                                    GRM.Report ( GRM.L ( "{num} guild members have outdated GRM versions" , nil , nil , count ) );
                                end
                            end
                        end
                        return;
                    end
                    -- parsing out the rankRequirementOfSender
                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                    ------------------------------------------
                    ----------- LIVE UPDATE TRACKING ---------
                    ------------------------------------------
                    -- Varuious Prefix Logic handling now...
                    if comms.prefix2 == "GRM_JD" then
                        GRMsync.CheckJoinDateChange ( msg , sender , comms.prefix2 );
                    
                    -- On a Promotion Date Edit
                    elseif comms.prefix2 == "GRM_PD" then
                        GRMsync.CheckPromotionDateChange ( msg , sender , comms.prefix2 );

                    -- If person added to Calendar... this event occurs.
                    elseif comms.prefix2 == "GRM_AC" then
                        GRMsync.EventAddedToCalendarCheck ( msg , sender );
                    
                    -- For adding an alt!
                    elseif comms.prefix2 == "GRM_ADDALT" then
                        GRMsync.CheckAddAltChange ( msg , sender , comms.prefix2 );
                
                    -- For Removing an alt!
                    elseif comms.prefix2 == "GRM_RMVALT" then
                        GRMsync.CheckRemoveAltChange ( msg , sender , comms.prefix2 );
                
                    -- For declaring who is to be "main"
                    elseif comms.prefix2 == "GRM_MAIN" then
                        GRMsync.CheckAltMainChange ( msg , sender );
                
                    -- For demoting from main -- basically to set as no mains.
                    elseif comms.prefix2 == "GRM_RMVMAIN" then
                        GRMsync.CheckAltMainToAltChange ( msg , sender );

                    elseif comms.prefix2 == "GRM_CNOTE" then
                        GRMsync.CheckCustomNoteChange ( msg , sender );

                    elseif comms.prefix2 == "GRM_BDAY" then
                        GRMsync.CheckBirthdayChange ( msg , sender , false )

                    elseif comms.prefix2 == "GRM_BDAYREM" then
                        GRMsync.CheckBirthdayRemoveChange ( msg , sender )

                    -- I want to accept LIVE changes, but not core sync changes.
                    elseif not IsInGroup() then

                        -- For ensuring ban information is controlled!
                        if ( comms.prefix2 == "GRM_BAN" or comms.prefix2 == "GRM_UNBAN" or comms.prefix2 == "GRM_BANSYNCUP" or comms.prefix2 == "GRM_BANSYNC" or comms.prefix2 == "GRM_BANSYNC2" or comms.prefix2 == "GRM_ADDCUR" or comms.prefix2 == "GRM_RSN") and GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncBanList then
                            if tonumber ( msg ) == nil then -- Error protection on some edge cases for older versions talking to each other.
                                local senderBanControlRankRequirement = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                                msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                                -- Should that be the player name, or should it be a name parsed from the sender??? -- Might need to investigate
                                if ( comms.senderRankID > GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncRankBanList or senderBanControlRankRequirement < GRM.GetGuildMemberRankID ( GRM_G.addonUser ) ) then
                                    -- Abort
                                    return;
                                else
                                    if comms.prefix2 == "GRM_BAN" then
                                        GRMsync.CheckBanListChange ( msg , sender );                        -- For live ban occurences
                                    elseif comms.prefix2 == "GRM_UNBAN" then
                                        GRMsync.CheckUnbanListChangeLive ( msg , sender );                  -- For live unban occurrences
                                    elseif comms.prefix2 == "GRM_BANSYNCUP" then
                                        GRMsync.BanManagementPlayersThatLeft ( msg , comms.prefix2 , sender );    -- For sync analysis final report changes!
                                        GRMsyncGlobals.TimeSinceLastSyncAction = time();
                                    elseif comms.prefix2 == "GRM_BANSYNC" then
                                        GRMsyncGlobals.TimeSinceLastSyncAction = time();                    -- For collecting sync data...
                                        GRMsync.CollectData ( msg , comms.prefix2 );
                                    elseif comms.prefix2 == "GRM_BANSYNC2" then
                                        GRMsyncGlobals.TimeSinceLastSyncAction = time();                    -- For collecting sync data...
                                        GRMsync.CollectData ( msg , comms.prefix2 );
                                    elseif comms.prefix2 == "GRM_ADDCUR" then
                                        GRMsyncGlobals.TimeSinceLastSyncAction = time();
                                        GRMsync.UpdateCurrentPlayerInfo ( msg );                            -- For some outlier circumstances of people that have rejoined, or been manually made as banned but are still in guild.
                                    elseif comms.prefix2 == "GRM_RSN" then
                                        GRMsyncGlobals.TimeSinceLastSyncAction = time();
                                        GRMsync.UpdateCurrentPlayerBanReason ( msg );
                                    end
                                end
                            end
                        elseif comms.prefix2 == "GRM_BANSYNC4" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();                    -- In case lots of data to cycle through, this is just a checkin with the sync leader to let you know its still sending data.                        
                        elseif comms.prefix2 == "GRM_ADDLEFT" then
                            GRMsync.UpdateLeftPlayerInfo ( msg , false );
                                        
                        --------------------------------------------
                        -------- RETROACTIVE SYNC TRACKING ---------
                        --------------------------------------------

                        -- In response to asking "Who is the leader" then ONLY THE LEADER will respond.
                        elseif comms.prefix2 == "GRM_WHOISLEADER" and GRMsyncGlobals.IsElectedLeader then
                                GRMsync.InquireLeaderRespond();

                        -- Updates who is the LEADER to sync with!
                        elseif comms.prefix2 == "GRM_IAMLEADER" then
                            table.insert ( GRMsyncGlobals.AllLeadersNeutral , sender );
                            GRMsync.SetLeader ( GRMsyncGlobals.AllLeadersNeutral[1] );
                            -- This is a case when a player is not a leader, then becomes a leader, this should be cleared after a moment to keep that open.
                            C_Timer.After ( 5 , function()
                                GRMsyncGlobals.AllLeadersNeutral = nil;
                                GRMsyncGlobals.AllLeadersNeutral = {};
                            end);
                        -- For an election...
                        elseif comms.prefix2 == "GRM_ELECT" then
                            GRMsync.SendTimeForElection ();

                        -- For sending timestamps out!
                        elseif comms.prefix2 == "GRM_TIMEONLINE" and not GRMsyncGlobals.LeadershipEstablished then -- Only the person who sent the inquiry will bother reading these... flow control...
                            GRMsync.RegisterTimeStamps ( msg );
                            
                        -- For establishing the new leader after an election
                        elseif comms.prefix2 == "GRM_NEWLEADER" then
                            GRMsync.ElectedLeader ( msg )
                        
                        -- LEADERSHIP ESTABLISHED, NOW LET'S SYNC COMMS!

                        -- Only the leader will hear this message!
                        elseif comms.prefix2 == "GRM_REQUESTSYNC" and GRMsyncGlobals.IsElectedLeader then
                            -- Ensure it is not a double add...
                            comms.isFound = false;
                            for i = 1 , #GRMsyncGlobals.SyncQue do
                                if GRMsyncGlobals.SyncQue[i] == sender then
                                    comms.isFound = true;
                                    break;
                                end
                            end
                            if not comms.isFound then
                                table.insert ( GRMsyncGlobals.SyncQue , sender );
                            end
                        
                            -- Redundancies... for some cleanup of edge cases where leader sync failed, or got trapped.
                            C_Timer.After ( 15 , function()
                                if ( GRMsyncGlobals.currentlySyncing and ( time() - GRMsyncGlobals.TimeSinceLastSyncAction ) >= 12.5 ) or ( not GRMsyncGlobals.currentlySyncing and #GRMsyncGlobals.SyncQue > 0 ) then
                                    GRMsyncGlobals.currentlySyncing = false;
                                    GRMsyncGlobals.errorCheckEnabled = false;
                                    if GRMsync ~= nil then
                                        GRMsync.InitiateDataSync();
                                    end
                                end
                            end)

                            -- PLAYER DATA REQ FROM LEADERS
                        -- Leader has requesated your Join Date Data!
                        elseif comms.prefix2 == "GRM_REQJDDATA" and msg == GRM_G.addonUser and not GRMsyncGlobals.currentlySyncing then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            -- Start forwarding Join Date data...
                            GRMsyncGlobals.currentlySyncing = true;
                            -- Initialize the error check now as you are now the front of the que being currently sync'd
                            if not GRM.IsCalendarEventEditOpen() then
                                GRM.GuildRoster();
                            end
                            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );
                            GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;
                        -- Pseudo Hash for comparison
                        elseif comms.prefix2 == "GRM_PHASH" or comms.prefix2 == "GRM_PHASHL" then
                            if comms.prefix2 == "GRM_PHASH" then
                                if string.sub ( msg , 1 , string.find ( msg , "?" ) -1 ) == GRM_G.addonUser and GRMsyncGlobals.currentlySyncing then
                                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );

                                    if string.sub ( msg , string.find ( msg , "?" ) + 1 , string.find ( msg , "?" ) + 3 ) == "BAN" then 
                                        GRMsyncGlobals.senderBanRankReq = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                                        msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                                    end

                                    if not string.find ( msg , "FINISH" , 1 , true ) then  
                                        GRMsync.SetReceivedHashValue ( msg );
                                    else
                                            -- Establish Database as an array
                                        GRM.convertToArrayFormat(); -- Now, we set array...

                                        if GRMsync.SyncIsNecessary() then

                                            -- Sends leaders the database markers for sync purposes.
                                            GRMsync.SendLeaderDatabaseMarkers();
                                            -- Build the values first
                                            GRMsync.BuildFullCheckArray();
                                            -- Now, determine where to start in database.
                                            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                                                GRMsync.NextSyncStep ( 1 );
                                            end);
                                        else
                                            GRMsync.SendCompletionMsg( false );
                                        end
                                    end
                                end

                            elseif comms.prefix2 == "GRM_PHASHL" and string.sub ( msg , 1 , string.find ( msg , "?" ) -1 ) == GRM_G.addonUser and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then

                                if not string.find ( msg , "FINISH" , 1 , true ) then
                                    GRMsync.BuildLeaderDatabaseMarkers ( string.sub ( msg , string.find ( msg , "?" ) + 1 ) );
                                else
                                    GRMsync.BuildFullCheckArray();
                                end
                            end

                        -- Final data sent, let's analyze now.
                        elseif comms.prefix2 == "GRM_STOP" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.PreCheckChanges ( msg );

                        -- Collect all data before checking for changes!
                        elseif ( comms.prefix2 == "GRM_JDSYNC" or comms.prefix2 == "GRM_PDSYNC" or comms.prefix2 == "GRM_MAINSYNC" ) and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectData ( msg , comms.prefix2 );

                        -- For ALT ADD DATA
                        elseif comms.prefix2 == "GRM_ALTADDSYNC" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectAltAddData ( msg );

                        -- For ALT REMOVE DATA
                        elseif comms.prefix2 == "GRM_ALTREMSYNC" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectAltRemData ( msg );
                        -- for CUSTOM NOTE Data
                        elseif comms.prefix2 == "GRM_CUSTSYNC" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then 
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectCustomNoteAction ( msg );
                        -- Birthday Data
                        elseif comms.prefix2 == "GRM_BDSYNC" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then 
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectBirthdayData ( msg )

                        -- AFTER DATA RECEIVED AND ANALYZED, SEND UPDATES!!!
                        -- THESE WILL HEAD TO THE SAME METHODS AS LIVE SYNC, WITH A COUPLE CHANGES BASED ON UNIQUE MESSAGE HEADER.
                        -- Sync the Join Dates!
                        elseif comms.prefix2 == "GRM_JDSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckJoinDateChange ( msg , sender , comms.prefix2 );

                        -- Sync the Promo Dates!
                        elseif comms.prefix2 == "GRM_PDSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckPromotionDateChange ( msg , sender , comms.prefix2 );

                        -- Final sync of ALT player info
                        elseif comms.prefix2 == "GRM_ALTSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckAddAltChange ( msg , sender , comms.prefix2 );

                        -- Final sync of Removing alts
                        elseif comms.prefix2 == "GRM_REMSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckRemoveAltChange ( msg , sender , comms.prefix2 );
                        
                        -- Final sync on Main Status
                        elseif comms.prefix2 == "GRM_MAINSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckMainSyncChange ( msg );

                        -- Final sync on Custom Note Changes
                        elseif comms.prefix2 == "GRM_CUSTSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckCustomNoteSyncChange ( msg , true );

                        -- Final sync on Birthdays
                        elseif comms.prefix2 == "GRM_BDSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckBirthdayChange ( msg , nil , true );

                        -- Final Announce!!!
                        elseif comms.prefix2 == "GRM_COMPLETE" then
                            if msg == GRM_G.addonUser then
                                GRMsyncGlobals.TimeSinceLastSyncAction = time();
                                GRMsyncGlobals.currentlySyncing = false;
                                GRMsync.ReportSyncCompletion ( GRMsyncGlobals.DesignatedLeader , true );
                            end

                        -- ERROR PROTECTIONS!!
                        elseif comms.prefix2 == "GRM_RMVERR" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.RemoveAltErrorFix( msg );
                        end
                    end
                end
            end
        end
    end);

    GRMsyncGlobals.RulesSet = true;
end

-- Method:          GRMsync.BuildSyncNetwork()
-- What it Does:    Step by step of my in-house sync algorithm custom built for this addon. Step by step it goes!
-- Purpose:         Control the work-flow of establishing the sync infrastructure. This will not maintain it, just builds the initial rules
--                  and the server-side channel of communication between players using the addon. Furthermore, by compartmentalizing it, it controls the flow of actions
--                  allowing a recursive check over the algorithm for flawless timing, and not moving ahead until the proper parameters are first met.
GRMsync.BuildSyncNetwork = function()
    -- Rank necessary to be established to keep'
    if IsInGuild() then
        if not GRMsyncGlobals.DatabaseLoaded then
            GRMsync.WaitTilDatabaseLoads();
        end

        -- Let's get the party started! Establishing rules then communication should be good to go!
        if GRMsyncGlobals.DatabaseLoaded and not GRMsyncGlobals.RulesSet then
            GRMsync.RegisterCommunicationProtocols();
        end

        -- Redundancy in case it fails to load.
        if GRMsyncGlobals.DatabaseLoaded and not GRMsyncGlobals.RulesSet then
            C_Timer.After ( 0.5 , GRMsync.BuildSyncNetwork );
        end
        
        -- We need to set leadership at this point.
        if not IsInGroup() then
            if GRMsyncGlobals.DatabaseLoaded and GRMsyncGlobals.RulesSet and not GRMsyncGlobals.LeadershipEstablished and not GRMsyncGlobals.LeadSyncProcessing then
                GRMsyncGlobals.LeadSyncProcessing = true;
                GRMsync.EstablishLeader();
                -- Reset the reload control blocker...
                if GRMsyncGlobals.reloadControl then
                    C_Timer.After ( 10 , function()
                        GRMsyncGlobals.reloadControl = false;
                    end);
                end
            end
        end
    end
end

-- ON LOADING!!!!!!!
-- Event Tracking
GRMsync.Initialize = function()
    if GRMsyncGlobals.SyncOK then
        if GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncEnabled and IsInGuild() and GRM_G.HasAccessToGuildChat then
            if ( time() - GRMsyncGlobals.timeAtLogin ) >= GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncDelay then
                GRMsync.TriggerFullReset();
                GRM.RegisterGuildAddonUsersRefresh();
                GRMsyncGlobals.LeadSyncProcessing = false;
                GRMsyncGlobals.errorCheckEnabled = false;
                GRMsync.MessageTracking = GRMsync.MessageTracking or CreateFrame ( "Frame" , "GRMsyncMessageTracking" );
                GRM_G.playerRankID = GRM.GetGuildMemberRankID ( GRM_G.addonUser );
                GRMsync.BuildSyncNetwork();
            else
                GRM.Report ( GRM.L ( "Sync is disabled for {num} seconds after logging in. Please wait {custom1} seconds longer." , nil , nil , GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncDelay , ( GRM_AddonSettings_Save[GRM_G.F][GRM_G.addonUser].syncDelay - ( time() - GRMsyncGlobals.timeAtLogin ) ) ) );
            end
        end
    end
end

GRMsync.HookComms();

