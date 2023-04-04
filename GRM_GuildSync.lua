
-- For Sync controls!
-- Author: Arkaan... aka "The Genetics Guy"
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
GRMsyncGlobals.InitializeTime = 0;                  -- to ensure no crossover talk and double requests for leadership establishment.

-- For players queing to by sync'd to share data!
-- If a player requests a leader sync, they are added to this que. This is so the leader can just add them to que
-- in the case that they may be syncing with another player already. Depending on the amount of data transferring, and the size of the guild, sync can take some time due to the 4kb/sec cap for ALL addons.
-- Based on server response time, per person. At least, initially. Live Sync updates happen near instantly.
GRMsyncGlobals.SyncQue = {};

-- Collected Tables of Data when received from the player
GRMsyncGlobals.JDReceivedTemp = {};
GRMsyncGlobals.PDReceivedTemp = {};
GRMsyncGlobals.BanReceivedTemp = {};
GRMsyncGlobals.AltReceivedTemp = {};
GRMsyncGlobals.MainReceivedTemp = {};
GRMsyncGlobals.CustomNoteReceivedTemp = {};
GRMsyncGlobals.BirthdayReceivedTemp = {};

-- Tables of the changes -- Leader will collect and store them here from all players before broadcasting the changes out, and then resetting them.
-- By compiling all changes first, and THEN checking, it saves an insane amount of resources rather than passing on every new piece received.
GRMsyncGlobals.JDChanges = {};
GRMsyncGlobals.PDChanges = {};
GRMsyncGlobals.BanChanges = {};
GRMsyncGlobals.AltMainChanges = {};
GRMsyncGlobals.CustomNoteChanges = {};
GRMsyncGlobals.BDayChanges = {};
GRMsyncGlobals.FinalCorrectAltList = {};
GRMsyncGlobals.FinalAltListReeceived = {};

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
GRMsyncGlobals.timeOfLastSyncCompletion = 0;
-- For more efficient sync tracking
GRMsyncGlobals.SyncCountJD = 1;             -- For Join Date loop
GRMsyncGlobals.SyncCountPD = 1;             -- For Promo Date loop
GRMsyncGlobals.SyncCountAltAdd = 1;
GRMsyncGlobals.SyncCountAltAdd2 = 1;
GRMsyncGlobals.SyncCountMain = 1;
GRMsyncGlobals.SyncCountCustom = 1;
GRMsyncGlobals.SyncCountBday = 1;
GRMsyncGlobals.SyncCountBan = 1;
GRMsyncGlobals.SyncCountAdd1 = 1;
GRMsyncGlobals.SyncCountAdd2 = 1;
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
GRMsyncGlobals.StartMessage = false;
GRMsyncGlobals.errorCheckEnabled = false;   -- To know when to reactivate the recursive loop or not.
GRMsyncGlobals.ErrorCheckControl = false;   -- For quick exit of the sync
GRMsyncGlobals.TimeSinceLastSyncAction = 0; -- Evertime sync action occurs, timer is reset!
GRMsyncGlobals.ErrorCD = 5;                -- 5 seconds delay... if no action detected, sync failed and it will retrigger...
GRMsyncGlobals.dateSentComplete = false;    -- If player is not designated leader, this boolean is used to exit the error check loop.
GRMsyncGlobals.syncTempDelay = false;
GRMsyncGlobals.syncTempDelay2 = false;
GRMsyncGlobals.finalSyncDataCount = 1;
GRMsyncGlobals.finalSyncDataBanCount = 1;
GRMsyncGlobals.finalSyncProgress = { false , false , false , false , false , false , false }; -- on each of the tables, if submitted fully
GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;
GRMsyncGlobals.TempRoster = {};
GRMsyncGlobals.TempAltRoster = {};
GRMsyncGlobals.altTempRosterCleanedup = false;

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
GRMsyncGlobals.altSyncCompleted = false;

-- Version check
GRMsyncGlobals.CompatibleAddonUsers = {};

-- Custom pseudo hash values
GRMsyncGlobals.HashValuesReceived = { {} , {} , {} , {} , {} , {} , {} };      -- resets to array of 7 arrays.
GRMsyncGlobals.DatabaseMarkers = {};
GRMsyncGlobals.DatabaseExactIndexes = {};
GRMsyncGlobals.SyncProgress = { false , false , false , false , false , false , false , true }; -- 8 is completion and always true
GRMsyncGlobals.SyncTracker = {};
GRMsyncGlobals.senderBanRankReq = 0;
GRMsyncGlobals.MarkerC = 1;
GRMsyncGlobals.MarkerD = 1;

-- Results
GRMsyncGlobals.updateCount = 0;             -- Number of items updated in this sync.
GRMsyncGlobals.updatesEach = { 0 , 0 , 0 , 0 , 0 , 0 , 0 };

-- Tables to hold data in array format, sorted - to maintain compatibility with sync system with new data structures
GRMsyncGlobals.guildData = {};
GRMsyncGlobals.formerGuildData = {};
GRMsyncGlobals.guildAltData = {};

GRMsyncGlobals.firstSyncOccurred = false;
GRMsyncGlobals.offline = false;

-- SYNC INTEGRITY CHECK VALUES
GRMsyncGlobals.NumExpectedAlts = 0;

-- Refresh Frame Control for Audit
GRMsyncGlobals.refreshCount = 0;
GRMsyncGlobals.refreshCountTimer = 0;

-- Sync Queue
GRMsyncGlobals.WaitingInQue = true;
GRMsyncGlobals.WaitingInQueTimer = time();

-- Sync Tracking
GRMsyncGlobals.BanValue = 0;
GRMsyncGlobals.syncComplete = false;
GRMsyncGlobals.syncCompleteTimer = 0;
GRMsyncGlobals.TrackerData = {};
GRMsyncGlobals.syncFailed = false;
GRMsyncGlobals.trackerPoint = "";
GRMsyncGlobals.finishResetDelay = false;
GRMsyncGlobals.totalEstTime = 0;
GRMsyncGlobals.progStart = 0;

-- Prefixes for tagging info as it is sent and picked up across server channel to other players in guild.
GRMsyncGlobals.listOfPrefixes = { 

    -- Main Sync Prefix...  rest will be text form
    "GRM_SYNC"
};

-- Sync UI
GRMsyncGlobals.UILoaded = false;

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
-- Purpose:         This is due to there being a 1.28Mb cap within the first 20 seconds that drops to a tiny 4Kb/s If the player can burst most of the info right away on logon, then sync can be quite fast. Otherwise it needs to be hard throttled to prevent player disconnect
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
        GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
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
    GRMsyncGlobals.LeadSyncProcessing = false;
    GRMsyncGlobals.IsElectedLeader = false;
    GRMsyncGlobals.DesignatedLeader = "";
    GRMsyncGlobals.ElectTimeOnlineTable = {};
    GRMsyncGlobals.currentlySyncing = false;
    GRMsyncGlobals.ElectionProcessing = false;
    GRMsyncGlobals.SyncQue = {};
    GRMsyncGlobals.InitializeTime = 0;
    GRMsyncGlobals.firstSync = true
    GRMsyncGlobals.refreshCount = 0;
    GRMsyncGlobals.WaitingInQue = false;
    GRMsyncGlobals.StartMessage = false;

end

-- Resetting after broadcasting the changes.
GRMsync.ResetReportTables = function()
    GRMsyncGlobals.JDChanges = {};
    GRMsyncGlobals.PDChanges = {};
    GRMsyncGlobals.BanChanges = {};
    GRMsyncGlobals.AltMainChanges = {};
    GRMsyncGlobals.CustomNoteChanges = {};
    GRMsyncGlobals.BDayChanges = {};
    GRMsyncGlobals.FinalCorrectAltList = {};
    GRMsyncGlobals.FinalAltListReeceived = {};
end

-- In case of mid-cycling reset, this resets all the temp tables.
GRMsync.ResetTempTables = function()
    GRMsyncGlobals.JDReceivedTemp = {};
    GRMsyncGlobals.PDReceivedTemp = {};
    GRMsyncGlobals.BanReceivedTemp = {};
    GRMsyncGlobals.AltReceivedTemp = {};
    GRMsyncGlobals.MainReceivedTemp = {};
    GRMsyncGlobals.CustomNoteReceivedTemp = {};
    GRMsyncGlobals.BirthdayReceivedTemp = {};
    GRMsyncGlobals.HashValuesReceived = { {} , {} , {} , {} , {} , {} , {} };
    GRMsyncGlobals.DatabaseMarkers = {};
    GRMsyncGlobals.DatabaseExactIndexes = {};
    GRMsyncGlobals.SyncProgress = { false , false , false , false , false , false , false , true };
    GRMsyncGlobals.finalSyncProgress = { false , false , false , false , false , false , false };
    GRMsyncGlobals.updatesEach = { 0 , 0 , 0 , 0 , 0 , 0 , 0 };
    GRMsyncGlobals.MarkerC = 1;
    GRMsyncGlobals.MarkerD = 1;
    -- Sync Expected number of values
    GRMsyncGlobals.NumExpectedAlts = 0;
end

----------------------------------------
------- SYNC PROGRESS TRACKING ---------
----------------------------------------

    -- GRMsyncGlobals.DatabaseExactIndexes
    -- 1 = JD
    -- 2 = PD
    -- 3 = alt
    -- 4 = main
    -- 5 = customNote
    -- 6 = bday
    -- 7 = ban


-- Method:          GRMsync.ResetSyncTracker)_
-- What it Does:    Resets all the sync status/tracker values
-- Purpose:         Quality of life feature to keep track of syncing information.
GRMsync.ResetSyncTracker = function()

    GRMsyncGlobals.SyncTracker.TriggeringSync = false;
    GRMsyncGlobals.SyncTracker.EstablishingLeader = false;
    GRMsyncGlobals.SyncTracker.buildingHashes = false;
    GRMsyncGlobals.SyncTracker.sendingHashes = false;
    GRMsyncGlobals.SyncTracker.calculating = false;
    GRMsyncGlobals.SyncTracker.jd = false;
    GRMsyncGlobals.SyncTracker.pd = false;
    GRMsyncGlobals.SyncTracker.alts = false;
    GRMsyncGlobals.SyncTracker.mains = false;
    GRMsyncGlobals.SyncTracker.customNotes = false;
    GRMsyncGlobals.SyncTracker.banData = false;
    GRMsyncGlobals.SyncTracker.compareMains = false;
    GRMsyncGlobals.SyncTracker.compareAlts = false;
    GRMsyncGlobals.SyncTracker.finalJD = false;
    GRMsyncGlobals.SyncTracker.finalPD = false;
    GRMsyncGlobals.SyncTracker.finalAlts = false;
    GRMsyncGlobals.SyncTracker.finalCustom = false;
    GRMsyncGlobals.SyncTracker.finalBan = false;
    GRMsyncGlobals.SyncTracker.bdays = false;
    GRMsyncGlobals.SyncTracker.finalMain = false;
    GRMsyncGlobals.SyncTracker.finalBdays = false;
    GRMsyncGlobals.SyncTracker.finish = false;

    if GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar then
        GRM_API.ResetProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 1 , 0 , 0 } , false );
    end

    if not GRMsyncGlobals.currentlySyncing then
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Not Currentlly Syncing" ) );
    end

    GRMsyncGlobals.BanValue = 0;
    GRMsyncGlobals.syncFailed = false;
    GRMsyncGlobals.trackerPoint = "";
    GRMsyncGlobals.finishResetDelay = false;
    GRMsyncGlobals.totalEstTime = 0;
    GRMsyncGlobals.progStart = 0;

    GRMsync.InitializeTrackerData();    -- Resets the tracking

end

-- Method:          GRMsyncGlobals.ProgressControl ( string )
-- What it Does:    In the sync progress, it sets all points to TRUE that happened prior
-- Purpose:         Because the sync attempts to be efficient, it only syncs data that needs to be sync, thus some points will be skipped. For the tracking purpose, it is useful to just identify those prior sync points as "true" and completed if it skips.
GRMsyncGlobals.ProgressControl = function ( point )

    local syncOrder = { ["JD"] = 6 , ["PD"] = 7 , ["ALT"] = 8 , ["MAIN"] = 9 , ["CUSTOMNOTE"] = 10 , ["BAN"] = 11 , ["COMPAREMAINS"] = 12 , ["COMPAREALTS"] = 13 , ["FINALJD"] = 14 , ["FINALPD"] = 15 ,  ["FINALALT"] = 16 , ["FINALCUSTOM"] = 17 , ["FINALBAN"] = 18 , ["BDAYS"] = 19 , ["FINALMAIN"] = 20 , ["FINALBDAYS"] = 21 , ["FINISH"] = 22 };

    local progress = { 
        "TriggeringSync" ,
        "EstablishingLeader" ,
        "buildingHashes" ,
        "sendingHashes" ,
        "calculating" ,
        "jd" ,
        "pd" ,
        "alts" ,
        "mains" ,
        "customNotes" ,
        "banData" ,
        "compareMains" ,
        "compareAlts" ,
        "finalJD" ,
        "finalPD" ,
        "finalAlts" ,
        "finalCustom" ,
        "finalBan" ,
        "bdays" ,
        "finalMain" ,
        "finalBdays" ,
        "finish"
    };

    if syncOrder [point] ~= nil then
        for i = 1 , #progress + 5 do
            if i <= syncOrder [point] then
                GRMsyncGlobals.SyncTracker[progress[i]] = true;
            else
                break;
            end
        end
    end

end

-- Method:          GRMsync.CalculateTotalSyncVolume()
-- What it Does:    Calculates the sync data total number of items
-- Purpose:         To attempt to track the progress of the sync by giving weights to each type of data syncing.
GRMsync.CalculateTotalSyncVolume = function()
    GRMsyncGlobals.SyncTracker.calculating = true;

    local total = 0;
    local result = {};
    local initLength = 10;
    local totalSeconds = 0;
    local secondsSoFar = 0;
    
    for i = 1 , #GRMsyncGlobals.DatabaseExactIndexes do
        if i == 3 then
            total = total + ( #GRMsyncGlobals.DatabaseExactIndexes[i] * 3);
        elseif i == 4 then
            total = total + ( #GRMsyncGlobals.DatabaseExactIndexes[i] * 2);
        elseif i == 5 then
            total = total + ( #GRMsyncGlobals.DatabaseExactIndexes[i] * 4);
        elseif i == 7 then
            total = total + ( #GRMsyncGlobals.DatabaseExactIndexes[i] * 3);
        else
            total = total + #GRMsyncGlobals.DatabaseExactIndexes[i];
        end
    end

    result.JD = {};
    result.PD = {};
    result.ALT = {};
    result.MAIN = {};
    result.CUSTOMNOTE = {};
    result.BDAY = {};
    result.BAN = {};

    -- Give weight to each section based on the total  #GRMsyncGlobals.DatabaseExactIndexes[1] / total = JD weight %
    -- Also, each point is the finalDestination precent, so an accumulation of all previous -- The index 2 of the array is the total number ofitems. This will help estimate the time needed to sync this info.
    
    if total ~= 0 then
        if #GRMsyncGlobals.DatabaseExactIndexes[1] > 0 then
            result.JD = { math.floor ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[1] / total ) * 100 ) + 0.5 ) , GRMsync.SyncTimeEstimation ( "JD" , #GRMsyncGlobals.DatabaseExactIndexes[1] ) , 0 };
            if result.JD[1] > 0 and result.JD[1] < initLength then    -- Just for quality of life - can't have it go backwards in time.
                result.JD[1] = initLength;
            end
            result.JD[3] = totalSeconds + result.JD[2]      -- Position 3 helps mark where in passed time this percent should lie
            totalSeconds = totalSeconds + result.JD[2];
        else
            result.JD = { 0 , 0 , totalSeconds };
        end

        if #GRMsyncGlobals.DatabaseExactIndexes[2] > 0 then
            result.PD = { math.floor ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[2] / total ) * 100 ) + 0.5 ) + result.JD[1] , GRMsync.SyncTimeEstimation ( "PD" , #GRMsyncGlobals.DatabaseExactIndexes[2] ) , 0 };
            if result.PD[1] > 0 and result.PD[1] < initLength then
                result.PD[1] = initLength;
            end
            result.PD[3] = totalSeconds + result.PD[2]
            totalSeconds = totalSeconds + result.PD[2];
        else
            result.PD = { 0 , 0 , totalSeconds };
        end

        if #GRMsyncGlobals.DatabaseExactIndexes[3] > 0 then
            result.ALT = { math.floor ( ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[3] * 3) / total ) * 100 ) + 0.5 ) + result.PD[1] , GRMsync.SyncTimeEstimation ( "ALT" , #GRMsyncGlobals.DatabaseExactIndexes[3] ) , 0 };
            if result.ALT[1] > 0 and result.ALT[1] < initLength then
                result.ALT[1] = initLength;
            end
            result.ALT[3] = totalSeconds + result.ALT[2]
            totalSeconds = totalSeconds + result.ALT[2];
        else
            result.ALT = { 0 , 0 , totalSeconds };
        end

        if #GRMsyncGlobals.DatabaseExactIndexes[4] > 0 then
            result.MAIN = { math.floor ( ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[4] * 2 ) / total ) * 100 ) + 0.5 ) + result.ALT[1] , GRMsync.SyncTimeEstimation ( "MAIN" , #GRMsyncGlobals.DatabaseExactIndexes[4] ) , 0 };
            if result.MAIN[1] > 0 and result.MAIN[1] < initLength then
                result.MAIN[1] = initLength;
            end
            result.MAIN[3] = totalSeconds + result.MAIN[2]
            totalSeconds = totalSeconds + result.MAIN[2];
        else
            result.MAIN = { 0 , 0 , totalSeconds };
        end

        if #GRMsyncGlobals.DatabaseExactIndexes[5] > 0 then
            result.CUSTOMNOTE = { math.floor ( ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[5] * 4) / total ) * 100 ) + 0.5 ) + result.MAIN[1] , GRMsync.SyncTimeEstimation ( "CUSTOMNOTE" , #GRMsyncGlobals.DatabaseExactIndexes[5] ) , 0 };
            if result.CUSTOMNOTE[1] > 0 and result.CUSTOMNOTE[1] < initLength then
                result.CUSTOMNOTE[1] = initLength;
            end
            result.CUSTOMNOTE[3] = totalSeconds + result.CUSTOMNOTE[2]
            totalSeconds = totalSeconds + result.CUSTOMNOTE[2];
        else
            result.CUSTOMNOTE = { 0 , 0 , totalSeconds };
        end
        
        if #GRMsyncGlobals.DatabaseExactIndexes[7] > 0 then
            result.BAN = { math.floor ( ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[7] * 3 ) / total ) * 100 ) + 0.5 ) + result.CUSTOMNOTE[1] , GRMsync.SyncTimeEstimation ( "BAN" , #GRMsyncGlobals.DatabaseExactIndexes[7] ) , 0 };
            if result.BAN[1] > 0 and result.BAN[1] < initLength then
                result.BAN[1] = initLength;
            end
            result.BAN[3] = totalSeconds + result.BAN[2]
            totalSeconds = totalSeconds + result.BAN[2];
        else
            result.BAN = { 0 , 0 , totalSeconds };
        end

        if #GRMsyncGlobals.DatabaseExactIndexes[6] > 0 then
            result.BDAY = { math.floor ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[6] / total ) * 100 ) + 0.5 ) + result.BAN[1] , GRMsync.SyncTimeEstimation ( "BDAY" , #GRMsyncGlobals.DatabaseExactIndexes[6] ) , 0 };

            result.BDAY[3] = totalSeconds + result.BDAY[2]
            totalSeconds = totalSeconds + result.BDAY[2];
        else
            result.BDAY = { 0 , 0 , totalSeconds };
        end

    end

    return result , totalSeconds;
end

-- Method:          GRMsync.SendTrackerCalculation()
-- What it Does:    Sends over the calculated tracker data points for progress bar.
-- Purpose:         To ensure both sync players' progress bar alligns, as well as the fact that the non Sync Leader calculates this all whilst the syncer just sends their data over. This ensures that the sync leader has calculated progression timers as well.
GRMsync.SendTrackerCalculation = function()
    local result = "";

    -- JD
    result = GRMsyncGlobals.TrackerData.JD[1] .. "?" .. GRMsyncGlobals.TrackerData.JD[2] .."?" .. GRMsyncGlobals.TrackerData.JD[3] .. "?";

    -- PD
    result = result .. GRMsyncGlobals.TrackerData.PD[1] .. "?" .. GRMsyncGlobals.TrackerData.PD[2] .. "?" .. GRMsyncGlobals.TrackerData.PD[3] .. "?";
    
    -- ALT
    result = result .. GRMsyncGlobals.TrackerData.ALT[1] .. "?" .. GRMsyncGlobals.TrackerData.ALT[2] .. "?" .. GRMsyncGlobals.TrackerData.ALT[3] .. "?";

    -- MAIN
    result = result .. GRMsyncGlobals.TrackerData.MAIN[1] .. "?" .. GRMsyncGlobals.TrackerData.MAIN[2] .. "?" .. GRMsyncGlobals.TrackerData.MAIN[3] .. "?";

    -- CUSTOMNOTE
    result = result .. GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] .. "?" .. GRMsyncGlobals.TrackerData.CUSTOMNOTE[2] .. "?" .. GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] .. "?";

    -- BDAY
    result = result .. GRMsyncGlobals.TrackerData.BDAY[1] .. "?" .. GRMsyncGlobals.TrackerData.BDAY[2] .. "?" .. GRMsyncGlobals.TrackerData.BDAY[3] .. "?";

    -- BAN
    result = result .. GRMsyncGlobals.TrackerData.BAN[1] .. "?" .. GRMsyncGlobals.TrackerData.BAN[2] .. "?" .. GRMsyncGlobals.TrackerData.BAN[3] .. "?";

    result = result .. GRMsyncGlobals.totalEstTime;

    local msg = GRM_G.PatchDayString .. "?GRM_TRACKER?" .. GRM.S().syncRank .. "?" .. result;

    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.DesignatedLeader );
end

-- Method:          GRMsync.InitializeTrackerData()
-- What it Does:    Initializes the tables
-- Purpose:         Compartmentalize this reusable reset.
GRMsync.InitializeTrackerData = function()
    GRMsyncGlobals.TrackerData.JD = {};
    GRMsyncGlobals.TrackerData.PD = {};
    GRMsyncGlobals.TrackerData.ALT = {};
    GRMsyncGlobals.TrackerData.MAIN = {};
    GRMsyncGlobals.TrackerData.CUSTOMNOTE = {};
    GRMsyncGlobals.TrackerData.BDAY = {};
    GRMsyncGlobals.TrackerData.BAN = {};
end

-- Method:          GRMsync.CollectTrackerCalculation ( string )
-- What it Does:    Parses the given messages and saves them to the tracker data table
-- Purpose:         Ensure sync progress is unified between 2 players.
GRMsync.CollectTrackerCalculation = function ( msg )
    GRM_G.MatchPattern22 = GRM_G.MatchPattern22 or GRM.BuildComPattern ( 22 , "?" , false );

    GRMsync.InitializeTrackerData();

    GRMsyncGlobals.TrackerData.JD[1] , GRMsyncGlobals.TrackerData.JD[2] , GRMsyncGlobals.TrackerData.JD[3] , GRMsyncGlobals.TrackerData.PD[1] , GRMsyncGlobals.TrackerData.PD[2] , GRMsyncGlobals.TrackerData.PD[3] , GRMsyncGlobals.TrackerData.ALT[1] , GRMsyncGlobals.TrackerData.ALT[2] , GRMsyncGlobals.TrackerData.ALT[3] , GRMsyncGlobals.TrackerData.MAIN[1] , GRMsyncGlobals.TrackerData.MAIN[2] , GRMsyncGlobals.TrackerData.MAIN[3] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[2] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] , GRMsyncGlobals.TrackerData.BDAY[1] , GRMsyncGlobals.TrackerData.BDAY[2] , GRMsyncGlobals.TrackerData.BDAY[3] , GRMsyncGlobals.TrackerData.BAN[1] , GRMsyncGlobals.TrackerData.BAN[2] , GRMsyncGlobals.TrackerData.BAN[3] , GRMsyncGlobals.totalEstTime = GRM.ParseComMsg ( msg , GRM_G.MatchPattern22 );  -- Ban needs to be pared when added.

    for _ , y in pairs ( GRMsyncGlobals.TrackerData ) do
        for i = 1 , #y do
            y[i] = tonumber ( y[i] );
        end
    end

    GRMsyncGlobals.totalEstTime = tonumber ( GRMsyncGlobals.totalEstTime );
    
end

-- Method:          GRMsync.SyncTimeEstimation ( string , int )
-- What it Does:    Calculates the time per block to sync
-- Purpose:         For relatively accurate sync tracker reporting.
GRMsync.SyncTimeEstimation = function ( dataType , total )
    local seconds = 0;

    local list = { "JD" , "PD" , "ALT" , "MAIN" , "CUSTOMNOTE" , "BDAY" };

    if dataType == "JD" or dataType == "PD" or dataType == "BDAY" or dataType == "MAIN" then

        -- 2 second delay everytime there is a throttle, so add these.
        seconds = seconds + ( math.floor ( ( total / 30 ) + 1 ) );

    elseif dataType == "ALT" then
        seconds = seconds + ( math.floor ( ( total / 10 ) + 1 ) * 3 );

    elseif dataType == "CUSTOMNOTE" then
        seconds = seconds + ( math.floor ( ( total / 5 ) + 1 ) * 5 );

    end

    return seconds;
end

-- Method:          GRMsync.SyncProgressPoint();
-- What it Does:    All of the points of the sync are tracked and this reveals the point of where the sync status currently is.
-- Purpose:         Quality of Life feature for tracking progress as sync is going.
GRMsync.SyncProgressPoint = function()

    local statusPoint = "";
    local progressTracker = { 
        "TriggeringSync" ,
        "EstablishingLeader" ,
        "buildingHashes" ,
        "sendingHashes" ,
        "calculating" ,
        "jd" ,
        "pd" ,
        "alts" ,
        "mains" ,
        "customNotes" ,
        "banData" ,
        "compareMains" ,
        "compareAlts" ,
        "finalJD" ,
        "finalPD" ,
        "finalAlts" ,
        "finalCustom" ,
        "finalBan" ,
        "bdays" ,
        "finalMain" ,
        "finalBdays" ,
        "finish"
    }

    for i = 1 , #progressTracker do

        -- Sync is not complete
        if not GRMsyncGlobals.SyncTracker[progressTracker[i]] then

            if i > 1 then
                statusPoint = progressTracker[i - 1];
            end
            break;
        end

        if i == #progressTracker then
            -- Progress is complete!
            statusPoint = progressTracker[i];   -- "finish"
        end

    end

    return statusPoint;
end

-- Method:          GRMsync.LiveTracking();
-- What it Does:    Checks status of the window and updates the info.
-- Purpose:         Quality of life feature.
GRMsync.LiveTracking = function()

    if GRM.S().syncEnabled then

        if GRM_G.InGroup then
            GRMsync.ResetSyncTracker();
            GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Disabled While Player is Grouped" ) );

        elseif GRMsyncGlobals.SyncTracker.finish and not GRMsyncGlobals.finishResetDelay then
            GRMsyncGlobals.finishResetDelay = true;
            GRMsync.ProgressCompleteReport();

        elseif not GRMsyncGlobals.SyncTracker.TriggeringSync and not GRMsyncGlobals.currentlySyncing and not GRMsyncGlobals.finishResetDelay then

            GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Not Currentlly Syncing" ) );
            
        end

    else

        GRMsync.ResetSyncTracker();
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Sync is Currently Disabled" ) );

    end
        
end

-- Method:          GRMsync.TimeDelayResetTracker()
-- What it Does:    Upon sync completion, it just refreshes it back to start
-- Purpose:         No need for it to say sync successful indefinitely.
GRMsync.TimeDelayResetTracker = function()
    if GRMsyncGlobals.syncCompleteTimer == 0 then
        GRMsyncGlobals.syncCompleteTimer = time();

        C_Timer.After ( 8 , function()
            GRMsyncGlobals.syncComplete = false;
            GRMsyncGlobals.syncCompleteTimer = 0;
            if GRMsyncGlobals.SyncTracker.finish then
                GRMsync.ResetSyncTracker();
                GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:Hide();
                GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();
            end
        end);
    end
end

-- Method:          GRMsync.ProgressCompleteReport()0
-- What it Does:    Reports Sync Completion and cleans up frames for it
-- Purpose:         Reusable code.
GRMsync.ProgressCompleteReport = function ()
    -- This will hold the sync complete message on the frame for 10 seconds;
    GRMsync.TimeDelayResetTracker();
    
end

GRMsync.SyncTrackerOnShow = function()

    if GRMsyncGlobals.syncFailed then
        -- Change texture to RED
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Sync has failed..." ) );
        if GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:IsVisible() then
            GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Hide();    -- This will logic OnShow
        end
        if not GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:IsVisible() then
            GRM_API.ResetProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 1 , 0 , 0 } , false );
            GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:Show();
        end

        GRM_API.ResetProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 1 , 0 , 0 } , false );

    else

        if GRMsyncGlobals.SyncTracker.TriggeringSync then
            
            if GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:IsVisible() then
                GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Hide();    -- This will logic OnShow
            end
            if not GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:IsVisible() then
                GRM_API.ResetProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 1 , 0 , 0 } , false );
                GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:Show();
            end

            local progressPoint = GRMsync.SyncProgressPoint();

            local name = "";
            if GRMsyncGlobals.IsElectedLeader then
                name = GRMsyncGlobals.CurrentSyncPlayer;
            else
                name = GRMsyncGlobals.DesignatedLeader;
            end
            
            if GRMsyncGlobals.SyncTracker.finish then
                GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Sync with {name} Successful" , GRM.GetClassifiedName ( name ) ) );
                GRM_API.SetProgressBarColor ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 0.42 , 0.92 , 1 } );
                GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , 0 );

            else

                -- If at least syncing join dates - no longer initializing
                if not GRMsyncGlobals.SyncTracker.jd then

                    GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Initializing Sync. One Moment..." ) );
                    GRM_API.ResetProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 1 , 0 , 0 } , false );

                else
                    --- SYNC IS IN PROGRESS

                    GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Currently Syncing With: {name}" , GRM.GetClassifiedName ( name ) ) );

                    GRM_API.SetProgressBarColor ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , { 1 , 0 , 0 } );
                    -- GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , syncProgress[GRMsyncGlobals.trackerPoint][1] , syncProgress[GRMsyncGlobals.trackerPoint][2] );
                    
                end
                
            end

        else
            GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Not Currentlly Syncing" ) );
            if not GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:IsVisible() then
                GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Show();    -- This will logic OnShow
            end
        end
    end
end

-- Method:          GRMsync.LoadSyncUI()
-- What it Does:    Loads the sync progress tracker's UI
-- Purpose:         To keep these as on-demand load only.
GRMsync.LoadSyncUI = function()

    if not GRMsyncGlobals.UILoaded then

        GRM_UI.GRM_SyncTrackerWindow = CreateFrame ( "Frame" , "GRM_SyncTrackerWindow" , UIParent , BackdropTemplateMixin and "BackdropTemplate" );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerCloseButton = CreateFrame ( "Button" , "GRM_SyncTrackerCloseButton" , GRM_UI.GRM_SyncTrackerWindow , "UIPanelCloseButton");
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText = GRM_UI.GRM_SyncTrackerWindow:CreateFontString ( nil , "OVERLAY" , "GameFontNormalTiny" );

        -- INITIALIZING FRAME VALUES
        GRM_UI.GRM_SyncTrackerWindow.timer = 0;
        GRM_UI.GRM_SyncTrackerWindow:SetPoint ( "CENTER" , UIParent );
        GRM_UI.GRM_SyncTrackerWindow:SetFrameStrata ( "MEDIUM" );
        GRM_UI.GRM_SyncTrackerWindow:SetSize ( 375 , 60 );
        GRM_UI.GRM_SyncTrackerWindow:EnableMouse ( true );
        GRM_UI.GRM_SyncTrackerWindow:SetMovable ( true );
        GRM_UI.GRM_SyncTrackerWindow:SetUserPlaced ( true );
        GRM_UI.GRM_SyncTrackerWindow:SetToplevel ( true );
        GRM_UI.GRM_SyncTrackerWindow:SetBackdrop ( GRM_UI.noteBackdrop2 );
        GRM_UI.GRM_SyncTrackerWindow:RegisterForDrag ( "LeftButton" );
        GRM_UI.GRM_SyncTrackerWindow:SetScript ( "OnDragStart" , GRM_UI.GRM_SyncTrackerWindow.StartMoving );
        GRM_UI.GRM_SyncTrackerWindow:SetScript ( "OnDragStop" , function()
            GRM_UI.GRM_SyncTrackerWindow:StopMovingOrSizing();
            GRM_UI.SaveSyncTrackerPosition();
        end);
        GRM_UI.GRM_SyncTrackerWindow:Hide();

        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton = CreateFrame ( "Button" , "GRM_SyncTrackerWindowButton" , GRM_UI.GRM_SyncTrackerWindow , "GameMenuButtonTemplate" );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:SetPoint ( "BOTTOM" , GRM_UI.GRM_SyncTrackerWindow , "BOTTOM" , 0 , 10 );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:SetSize ( 100 , 25 );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:Hide();

        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton.GRM_SyncTrackerWindowButtonText = GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:CreateFontString ( nil , "OVERLAY" , "GameFontNormal" );

        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton.GRM_SyncTrackerWindowButtonText:SetPoint ( "CENTER" , GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton.GRM_SyncTrackerWindowButtonText:SetText ( GRM.L ( "Start Sync" ) )
        
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerCloseButton:SetPoint ( "TOPRIGHT" , GRM_UI.GRM_SyncTrackerWindow , "TOPRIGHT" , -1 , -2 );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerCloseButton:SetSize ( 18 , 18 );

        GRM_UI.CoreSyncTrackerInit();

        -- Progress tracker
        GRM_API.CreateNewProgressBar ( GRM_UI.GRM_SyncTrackerWindow , "GRM_SyncProgressBar" , GRM_UI.GRM_SyncTrackerWindow:GetWidth() - 70 , 18 , { 1 , 0 , 0 } );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:SetPoint ( "BOTTOMLEFT" , GRM_UI.GRM_SyncTrackerWindow , "BOTTOMLEFT" , 50 , 10 );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar.GRM_SyncProgressBarTexture:SetSize ( 1 , 20 );
        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:Hide();

        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetPoint ( "TOP" , GRM_UI.GRM_SyncTrackerWindow , "TOP" , 0 , -8 );
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetJustifyH ( "CENTER" );
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetWidth ( GRM_UI.GRM_SyncTrackerWindow:GetWidth() - 30 );
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetTextColor ( 0.64 , 0.102 , 0.102 );
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Not Currentlly Syncing" ) );
        
        -- FRAME SCRIPTS
        GRM_UI.GRM_SyncTrackerWindow:SetScript ( "OnUpdate" , function ( self , elapsed )

            self.timer = self.timer + elapsed;
            if self.timer >= 1 then
                GRMsync.LiveTracking();
            end

        end);

        GRM_UI.GRM_SyncTrackerWindow:SetScript ( "OnShow" , function()
            GRMsync.SyncTrackerOnShow();
        end);

        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:SetScript ( "OnClick" , function( self , button )
            if button == "LeftButton" then
                self:Hide();
                GRMsync.ResetSyncTracker();
                GRM.SyncCommandScan();
            end
        end);

        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:SetScript ( "OnHide" , function()
            if not GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:IsVisible() then
                GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:Show();
            end
        end);

        GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton:SetScript ( "OnShow" , function()
            GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar:Hide();
        end);

        GRMsync.ResetSyncTracker();
        GRMsyncGlobals.UILoaded = true;
    end

    -- Kept outside of brackets so they can be recalled if font adjustments as needed.
    GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 14 );
    GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar.GRM_SyncProgressBarText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    GRM_UI.GRM_SyncTrackerWindow.GRM_SyncTrackerWindowButton.GRM_SyncTrackerWindowButtonText:SetFont ( GRM_G.FontChoice , GRM_G.FontModifier + 12 );
    
end

---------------------------------
------- END PROGRESS TRACKING ---
---------------------------------


-- For use on doing a hard reset on sync. This is useful like if the addon user themselves changes rank and permissions change. Things would be wonky without force a hard reset of privileges.
GRMsync.TriggerFullReset = function()
    GRMsync.ResetDefaultValuesOnSyncReEnable();
    GRMsync.ResetReportTables();
    GRMsync.ResetTempTables();
    GRMsyncGlobals.SyncOK = true;
end

--------------------------
----- FUNCTIONS ----------
--------------------------

-- Method:          GRMsync.WaitTilDatabaseLoads ( bool )
-- What it Does:    Sets the player's guild ranking by index of rank
-- Purpose:         This is important for addon talk to not get info from ranks too low.
GRMsync.WaitTilDatabaseLoads = function( forMacro )
    if IsInGuild() and GRM_G.guildName == "" then
        C_Timer.After ( 1 , function()
            GRMsync.WaitTilDatabaseLoads ( forMacro )
        end);
        return
    else
        GRMsyncGlobals.DatabaseLoaded = true;
    end
    GRMsync.BuildSyncNetwork ( forMacro );
end

-- Method:          GRMsync.EndSync ( boolean )
-- What it Does:    Forces the error check to kill the sync immediately
-- Purpose:         If something happens and sync needs to fail, this is how it happens.
GRMsync.EndSync = function ( sendMessage )
    sendMessage = sendMessage or false;
    if GRMsyncGlobals.currentlySyncing then
        -- Logic to exit a sync faster if someone goes offline
        if GRMsyncGlobals.SyncOK then
            GRMsyncGlobals.offline = true;
            GRMsyncGlobals.firstSync = true
            GRMsyncGlobals.SyncOK = false;
            GRMsyncGlobals.ErrorCheckControl = true;
            GRMsync.ErrorCheck ( true , sendMessage );
            C_Timer.After ( 2 , function()
                GRMsyncGlobals.SyncOK = true;
            end);
        end
    end
end

-------------------------------------
----- ESTABLISH SYNC LEADERSHIP -----
-----        BY ELECTION        -----
-------------------------------------

-- Method:          GRMsync.InquireLeader()
-- What it Does:    On logon, or activation of sync alg, it requests in the guild channel if a leader is online.
-- Purpose:         Step 1 of sync algorithm in determining leader.
GRMsync.InquireLeader = function()
    
    if GRMsyncGlobals.SyncOK then
        GRMsyncGlobals.IsLeaderRequested = true;
        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_WHOISLEADER?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?" , GRMsyncGlobals.channelName );

    end

end

-- Method:          GRMsync.LeaderRespond ( string , int )
-- What it Does:    The new leader will respond out "I AM LEADER" and everyone set him as leader.
-- Purpose:         Sync leadership controls. Election should happen each time for optimal sync leader this is why it is ONLY default if the person is already syncing and you are just adding them to sync que.
GRMsync.LeaderRespond = function ( sender , banRankRestriction )

    -- If someone is a leader already, and they are syncing, you don't want to interrupt that.
    if GRMsyncGlobals.currentlySyncing and GRMsyncGlobals.IsElectedLeader then

        GRMsyncGlobals.DesignatedLeader = GRM_G.addonUser;
        GRMsyncGlobals.IsElectedLeader = true
        GRMsyncGlobals.IsLeaderRequested = true;
        GRMsyncGlobals.LeadershipEstablished = true;
        GRMsyncGlobals.ElectionProcessing = false;

        if GRMsyncGlobals.SyncOK then
            local msg = GRM_G.PatchDayString .. "?GRM_IAMLEADER?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?";
            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
            GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.channelName );

        end
    elseif not GRMsyncGlobals.currentlySyncing then
        GRMsyncGlobals.senderBanRankReq = banRankRestriction;
    end
end

-- Method:          GRMsync.ReviewElectResponses ()
-- What it Does:    Reviews timestamps of all online people with addon, and if there is no leader, it elects a new leader.
-- Purpose:         Leadership needs to be established to ensure clean syncing.
GRMsync.ReviewElectResponses = function()
    local highestName = "";
    local highestTime = 0;
    local topRank = 0;
    local banRankRestriction = 0;

    if GRM.TableLength ( GRMsyncGlobals.ElectTimeOnlineTable ) > 0 then
        local c = 1;
        
        for name , data in pairs ( GRMsyncGlobals.ElectTimeOnlineTable ) do
            if c == 1 then
                highestName = name;
                highestTime = data[1];
                topRank = data[2];
                banRankRestriction = data[3];
                c = c + 1;
            end

            if data[2] < topRank or ( data[2] == topRank and data[1] < highestTime ) then -- Higher guild rank (lower index), or fi same rank, who was on the longest - less means on longer
                highestName = name;
                highestTime = data[1]
                topRank = data[2];
                banRankRestriction = data[3];

            end

        end

        -- Send Message out
        if GRMsyncGlobals.SyncOK then
            GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_NEWLEADER?" .. GRM.S().syncRank .. "?" .. highestName .. "?" .. banRankRestriction , GRMsyncGlobals.channelName );
        end
        -- Establishing leader.
        GRMsync.SetLeader ( highestName , true , banRankRestriction );
        
    else
        -- Abort sync since it was only temporary, and there is no one to sync with.
        GRMsyncGlobals.DesignatedLeader = GRM_G.addonUser;
        GRMsyncGlobals.IsElectedLeader = true;
        GRMsyncGlobals.IsLeaderRequested = false;
    end
    
    -- RESET TABLE!
    GRMsyncGlobals.ElectionProcessing = false;
    GRMsyncGlobals.ElectTimeOnlineTable = {};

end

-- Method:          GRMsync.RequestElection()
-- What it Does:    To person who just logged in or reactivated syncing, it sends out a request to elect a leader if no leader identified.
-- Purpose:         Need to get time responses from all players to determine who has been online the longest, which will likely have the best data.
GRMsync.RequestElection = function()
    GRMsyncGlobals.ElectionProcessing = true;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_ELECT?" .. GRM.S().syncRank .. "?" .. "" , GRMsyncGlobals.channelName );
    end
    -- Let's give it a time delay to receive responses. 3 seconds.
    C_Timer.After ( 4 , GRMsync.ReviewElectResponses );
end

-- Method:          GRMsync.SendElectionInfo()
-- What it Does:    Sends the time logged in or addon sync was enabled
-- Purpose:         For voting, to determine who was online the longest.
GRMsync.SendElectionInfo = function()
    if not GRMsyncGlobals.ElectionProcessing then
        if GRMsyncGlobals.SyncOK then
            GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_ELECTINFO?" .. GRM.S().syncRank .. "?" .. GRM_G.addonUser .. "?" .. tostring ( GRMsyncGlobals.timeAtLogin ) .. "?" .. tostring ( GRM.GetPlayer ( GRM_G.addonUser ).rankIndex ) .. "?" .. tostring ( GRM.S().syncRankBanList ) , GRMsyncGlobals.channelName );
        end
    end
end

-- Method:          GRMsync.RegisterTimeStamps( string )
-- What it Does:    Adds the player's name and timestamp for election
-- Purpose:         Need to aggregate all the player data for voting!
GRMsync.RegisterTimeStamps = function ( msg )
    -- Adding { timestamp , name } to the list of people giving their time... 3 second response time valid only.
    GRM_G.MatchPattern4 = GRM_G.MatchPattern4 or GRM.BuildComPattern ( 4 , "?" , false );
    local name , timeAtLogin , rankIndex , banRankRestriction = GRM.ParseComMsg ( msg , GRM_G.MatchPattern4 );

    GRMsyncGlobals.ElectTimeOnlineTable[name] = { tonumber ( timeAtLogin ) , tonumber ( rankIndex ) , tonumber ( banRankRestriction ) };
end

-- Method:          GRMsync.ElectedLeader ( string )
-- What it Does:    Established the elected leader based on message received.
-- Purpose:         Final step in designating a leader!
GRMsync.ElectedLeader = function ( msg )
    -- Message should just be the name, so no need to parse.
    GRM_G.MatchPattern2 = GRM_G.MatchPattern2 or GRM.BuildComPattern ( 2 , "?" , false );
    local leader , banRankRestriction = GRM.ParseComMsg ( msg , GRM_G.MatchPattern2 );
    banRankRestriction = tonumber ( banRankRestriction );
    GRMsyncGlobals.senderBanRankReq = banRankRestriction;

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

    GRMsyncGlobals.DesignatedLeader = leader;
    GRMsyncGlobals.IsElectedLeader = false;
    GRMsyncGlobals.LeadershipEstablished = true;
    if leader == GRM_G.addonUser then
        GRMsyncGlobals.IsElectedLeader = true;
    end
    
end

-- Method:          GRMsync.EstablishLeader()
-- What it Does:    Controls the algorithm flow for syncing data between players by establishing leader.
-- Purpose:         To have a healthy, lightweight, efficient syncing addon.
GRMsync.EstablishLeader = function()
    if time() - GRMsyncGlobals.InitializeTime >= 10 then

        GRMsyncGlobals.SyncTracker.EstablishingLeader = true;

        GRMsyncGlobals.InitializeTime = time();
        -- "Who is the leader?"
        if not GRMsyncGlobals.IsLeaderRequested then
            GRMsync.InquireLeader();

        end

        C_Timer.After ( 4.5 , function ()

            if not GRMsyncGlobals.reloadControl then
                -- No responses, no leader! Setup an election for the leader!
                if not GRMsyncGlobals.LeadershipEstablished then
                    GRMsync.RequestElection();
                else
                    if GRMsyncGlobals.DesignatedLeader ~= GRM_G.addonUser then
                        GRMsyncGlobals.LeadSyncProcessing = false;

                        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_REQUESTSYNC?" .. GRM.S().syncRank .. "?" .. "" , GRMsyncGlobals.DesignatedLeader );

                        if not GRMsyncGlobals.StartMessage then
                            GRMsync.SyncTriggerMessage ( GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader ) );
                        end
                    end
                end
            else
                GRMsyncGlobals.reloadControl = false;
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

    GRMsyncGlobals.CTL = _G.ChatThrottleLib; -- For compatibility as not to overribe ACE Lib for syncing
        
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

-- Method:          GRMsync.SetLeader ( string , bool , int )
-- What it Does:    If message received, designates the sender as the leader
-- Purpose:         Need to designate a leader!
GRMsync.SetLeader = function ( leader , initiateSync , banRankRestriction )
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

    GRMsyncGlobals.DesignatedLeader = leader;
    GRMsyncGlobals.LeadershipEstablished = true;
    GRMsyncGlobals.ElectionProcessing = false;
    GRMsyncGlobals.SyncTracker.EstablishingLeader = true;

    if banRankRestriction then
        GRMsyncGlobals.senderBanRankReq = banRankRestriction;
    end

    if initiateSync then
        if leader ~= GRM_G.addonUser then
            GRMsyncGlobals.IsElectedLeader = false;
            -- Non leader sends request to sync
            if GRMsyncGlobals.SyncOK and ( GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or GRM.S().exportAllRanks ) then
                if not GRMsyncGlobals.reloadControl then
                    GRMsyncGlobals.LeadSyncProcessing = false;

                    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_REQUESTSYNC?" .. GRM.S().syncRank .. "?" .. "" , GRMsyncGlobals.DesignatedLeader );
                    
                   if not GRMsyncGlobals.StartMessage then
                        GRMsync.SyncTriggerMessage ( GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader ) );
                   end

                else
                    GRMsyncGlobals.reloadControl = false;
                end
            else
                GRMsync.EndSync();
            end
        elseif leader == GRM_G.addonUser then
            GRMsyncGlobals.DesignatedLeader = leader;
            GRMsyncGlobals.LeadershipEstablished = true;
            GRMsyncGlobals.IsElectedLeader = true;
            GRMsyncGlobals.ElectionProcessing = false;

            -- Initiate data sync
            table.insert ( GRMsyncGlobals.SyncQue , sender );
            C_Timer.After ( 1 , GRMsync.InitiateDataSync );
        end
    end    
end

-- Method:          GRMsync.SyncTriggerMessage( string )
-- What it Does:    Triggers just the message
-- Purpose:         Easy reporting start of sync process after leader election.
GRMsync.SyncTriggerMessage = function ( name )
   GRMsyncGlobals.StartMessage = true;
    if not GRMsyncGlobals.syncTempDelay then
        GRMsyncGlobals.SyncTracker.TriggeringSync = true;
        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Currently Syncing With: {name}" , name ) );
        
        if GRM.S().syncChatEnabled then
            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Syncing Data With Guildies Now..." ) .. "\n" .. GRM.L ( "(Loading screens may cause sync to fail)" ) );
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
    if (#msg + #prefix) >= 255 then
        GRM.Report( GRM.L ( "GRM ERROR:" ) .. " " .. GRM.L ( "Com Message too large for server" ) .. " (" .. (#msg + #prefix) .. ")\n" .. GRM.L ( "Prefix:" ) .. " " .. prefix .. "\n" .. GRM.L ( "Msg:" ) .. " " .. msg );
    elseif msg == "" and prefix == "GRM_SYNC" then
        return
    else
        if GRM_G.DebugEnabled then
            GRM.AddDebugMessage ( msg );
        end

        if type ~= "GUILD" then
            C_ChatInfo.SendAddonMessage ( prefix , msg , "WHISPER" , type );
        else
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

    GRM_G.MatchPattern7 = GRM_G.MatchPattern7 or GRM.BuildComPattern ( 7 , "?" , false );

    local playerName , epochTimeOfChange , day , month , year , epochStamp , noteDestination = GRM.ParseComMsg ( msg , GRM_G.MatchPattern7 );

    epochStamp = tonumber ( epochStamp );
    epochTimeOfChange = tonumber ( epochTimeOfChange );
    day = tonumber ( day );
    month = tonumber ( month );
    year = tonumber ( year );

    -- set the timestamp
    local joinDate = GRM.FormatTimeStamp ( { day , month , year } );
    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];

    if player then
        -- Let's see if there was a change
        if player.joinDateHist[1][5] < epochTimeOfChange then

            player.joinDateHist[1][1] = day;
            player.joinDateHist[1][2] = month;
            player.joinDateHist[1][3] = year;
            player.joinDateHist[1][4] = epochStamp;
            player.joinDateHist[1][5] = epochTimeOfChange
            player.joinDateHist[1][6] = true;
            player.joinDateHist[1][7] = 1;
        
            -- Gotta update the event tracker date too!
            player.events[1][1][1] = day;
            player.events[1][1][2] = month;
            player.events[1][1][3] = year;
            player.events[1][2] = false;  -- Gotta Reset the "reported already" boolean!
            GRM.RemoveFromCalendarQue ( player.name , 1 , nil );
        
            -- In case of Unknown
            player.joinDateUnknown = false;
        
            -- Report the updates!
            if GRM.S().syncChatEnabled and not isSyncUpdate then
                
                GRM.Report ( GRM.L ( "{name} updated {name2}'s Join Date." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( playerName , true ) ) );
            end
        
            -- Updating count of changes
            if isSyncUpdate then
                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                GRMsyncGlobals.updatesEach[1] = GRMsyncGlobals.updatesEach[1] + 1;
            end
            
            -- Live update if any frames visible so player does not need to close and reopen for updates.
            if GRM_UI.GRM_MemberDetailMetaData ~= nil and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == playerName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_JoinDateText:SetText ( joinDate );
                    if GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailJoinDateButton:IsVisible() then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailJoinDateButton:Hide();                
                end
                GRM_UI.GRM_MemberDetailMetaData.GRM_JoinDateText:Show();
        
                if noteDestination == "1" then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_noteFontString2:SetText ( joinDate );
                    GRM_UI.GRM_MemberDetailMetaData.GRM_PlayerOfficerNoteEditBox:SetText ( joinDate );
                elseif noteDestination == "2" then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_noteFontString1:SetText ( joinDate );
                    GRM_UI.GRM_MemberDetailMetaData.GRM_PlayerNoteEditBox:SetText ( joinDate );
                elseif noteDestination == "3" then
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

    GRM_G.MatchPattern6 = GRM_G.MatchPattern6 or GRM.BuildComPattern ( 6 , "?" , false );

    local playerName , day , month , year , epochDate , epochTimeOfChange = GRM.ParseComMsg ( msg , GRM_G.MatchPattern6 );
    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];

    if player then

        epochTimeOfChange = tonumber ( epochTimeOfChange );
        epochDate = tonumber ( epochDate );
        day = tonumber ( day );
        month = tonumber ( month );
        year = tonumber ( year );
        
        if player.rankHist[1][6] < epochTimeOfChange then
            player.rankHist[1][2] = day;  -- day
            player.rankHist[1][3] = month;  -- month
            player.rankHist[1][4] = year;  -- year
            player.rankHist[1][5] = epochDate;
            player.rankHist[1][6] = epochTimeOfChange
            player.rankHist[1][7] = true;
            player.promoteDateUnknown = false;           
            
            -- Report the updates!
            if GRM.S().syncChatEnabled and not isSyncUpdate then
                GRM.Report ( GRM.L ( "{name} updated {name2}'s Promotion Date." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( player.name , true ) ) );
            end

            -- Updating count of changes
            if isSyncUpdate then
                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                GRMsyncGlobals.updatesEach[2] = GRMsyncGlobals.updatesEach[2] + 1;
            end

            -- If the player is on the same frames, update them too!
            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == player.name then
                if GRM_UI.GRM_MemberDetailMetaData.GRM_SetPromoDateButton:IsVisible() then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_SetPromoDateButton:Hide();
                end

                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailRankDateTxt:SetText ( GRM.L ( "Promoted:" ) .. " " .. GRM.FormatTimeStamp ( { day , month , year } , false ) );
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

    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local name , title , index = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );
    index = tonumber ( index );


    if GRM.IsOnAnnouncementList ( name , index , title ) then
        -- Remove from the list
        GRM.RemoveFromCalendarQue ( name , index , title );

        -- Refresh the frame!
        if GRM_UI.GRM_RosterChangeLogFrame.GRM_EventsFrame:IsVisible() then
            GRM.RefreshAddEventFrame();
        end
        -- Send chat update info.
        if GRM.S().syncChatEnabled then
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

    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local name , altName , altNameEpochTime = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );
    local addToAltsGroup = false;

    altNameEpochTime = tonumber ( altNameEpochTime );

    if name ~= altName then         -- To avoid spam message to all players...

        local alt = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ altName ];

        if alt and altNameEpochTime >= alt.altGroupModified then

            addToAltsGroup = GRM.AddAlt ( name , altName , false , altNameEpochTime );

            C_Timer.After ( 1 , function() 
                GRM.SyncBirthdayWithNewAlt ( name , altName , addToAltsGroup );
        
                if GRM.S().syncChatEnabled then
                    GRM.Report ( GRM.L ( "{name} updated {name2}'s list of Alts." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( name , true ) ) );
                end
        
                if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                    GRM.RefreshAuditFrames ( true , true );
                end
            end);
        end
    end
end

-- Method:          GRMsync.CollectAltFinalSyncData ( msg )
-- What it Does:    Collects the alt data received and holds it until ready to compare all
-- Purpose:         Sync alt data - this is necessary as each alt arrives one at a time so need all of them to full compare lists.
GRMsync.CollectAltFinalSyncData = function ( msg , isLeader )

    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local name , altName , altGroupModified = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );
    altGroupModified = tonumber ( altGroupModified );

    -- Now, we need to determine what to do with given list
    if GRMsyncGlobals.FinalAltListReeceived[name] == nil then
        GRMsyncGlobals.FinalAltListReeceived[name] = {};
        GRMsyncGlobals.FinalAltListReeceived[name].altGroupModified = altGroupModified;
    end

    -- This tag indicates no alts
    if altName ~= "###" then
        local isFound = false;
        for i = 1 , #GRMsyncGlobals.FinalAltListReeceived[name] do
            if GRMsyncGlobals.FinalAltListReeceived[name][i] == altName then
                isFound = true;
                break;
            end
        end

        if not isFound then
            table.insert ( GRMsyncGlobals.FinalAltListReeceived[name] , altName );
        end
    end

end

-- Method:          GRMsync.IsListTheSame ( table , table )
-- What it Does:    Compares 2 string tables and returns true if both are identical. They do not need to be ordered.
-- Purpose:         For the count of things updated.
GRMsync.IsListTheSame = function ( alts , currentList )
    local result = true;
    local isFound = false;

    if #alts == 0 and #currentList == 0 then
        return result;  -- quick exit if both are empty
    elseif #alts ~= #currentList then
        result = false;
    else
        -- Same number on each list
        for i = 1 , #alts do
            isFound = false;
            for j = 1 , #currentList do

                if alts[i] == currentList[j][1] then
                    isFound = true;
                end

            end

            if not isFound then
                result = false;
                break;
            end

        end

        -- If result is STILL true
        for i = 1 , #currentList do
            isFound = false;
            for j = 1 , #alts do

                if currentList[i][1] == alts[j] then
                    isFound = true;
                end

            end

            if not isFound then
                result = false;
                break;
            end

        end

    end

    return result;
end

-- Method:          GRMsync.ConvertToNamesList ( table )
-- What it Does:    Takes all the keys of the table and places them all into a sorted array
-- Purpose:         Usefeulness when sending nested loops to sort through an indexed array rather than a keyed table.
GRMsync.ConvertToNamesList = function ( list )

    local result = {};

    for name in pairs ( list ) do
        table.insert ( result , name );
    end

    sort ( result );

    return result;
end
-- GRMsync.ClearAltGroupsthatMatch ( GRMsyncGlobals.FinalCorrectAltList , GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ] , GRMsyncGlobals.guildAltData );
-- GRMsync.ClearAltGroupsthatMatch ( GRMsyncGlobals.FinalAltListReeceived , GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ] , GRMsyncGlobals.guildAltData );
-- Method:          GRMsync.ClearAltGroupsthatMatch ( table , table , table )
-- What it Does:    Cleans up the final list of alts so you don't process logic of adding/removing if groups already are the same.
-- Purpose:         Keep the data sync'd properly.
GRMsync.ClearAltGroupsthatMatch = function ( currentList , guildData , altData )
    local finalList = finalL or {};
    local currentAlts = {};

    -- Scan through all on the current final list

    local orderedList = GRM.ConvertTableTo2DArray ( currentList , true );
    local repeatedName = false;
    for i = #orderedList , 1 , -1 do

        repeatedName = false;
        -- First, make sure name is not already on the list.
        for name , alts in pairs ( finalList ) do
            for j = 1 , #alts do
                if orderedList[i][1] == alts[j] then
                    repeatedName = true;
                    break;
                end
            end

            if repeatedName then
                break;
            end
        end

        if not repeatedName then

            currentAlts = GRM.GetListOfAlts ( guildData[orderedList[i][1]] , false , altData );

            if not GRMsync.IsListTheSame ( orderedList[i][2] , currentAlts ) then
                -- Let's add to finalList
                finalList[orderedList[i][1]] = GRM.DeepCopyArray ( orderedList[i][2] );

            end
        end

    end

    return finalList;
end

-- Method:          GRMsync.CheckAddAltSyncChange ( table , iint )
-- What it Does:    Compares lists and you use which is most current
-- Purpose:         Ensuring the alt groupings are most accurate.
GRMsync.CheckAddAltSyncChange = function ( finalList , countExpected )

    if countExpected == GRM.TableLength ( finalList ) then
        -- Now, we need to update the current database
        local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ]
        local altData = GRMsyncGlobals.guildAltData;
        local player = {};
        local currentAlts = {};
        local timing = 0;
        local onList = false;
        local addToAltsGroup = false; 

        finalList = GRMsync.ClearAltGroupsthatMatch ( finalList , guildData , altData );

        for name , alts in pairs ( finalList ) do
            
            player = guildData[name];

            if player then
                -- Ok, collect the alts so we can compare.
                currentAlts = GRM.GetListOfAlts ( guildData[name] , false );

                if not GRMsyncGlobals.IsElectedLeader and not GRMsync.IsListTheSame ( alts , currentAlts ) then
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                    GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;
                end
                
                -- First thing, scan through the master list and compare to current list. Any alts NOT on the master are to be removed

                if #alts > 0 then
                    -- Ok there are alts to be added/removed

                    if #currentAlts > 0 then
                        -- Both have alts

                        -- Step 1
                        -- If any alt is on the current list and NOT on the master list, then remove it
                        for i = 1 , #currentAlts do
                            onList = false;
                            for j = 1 , #alts do

                                if currentAlts[i][1] == alts[j] then

                                    onList = true;
                                    break;
                                end

                            end

                            if not onList then
                                -- Current alt should be removed as it is NOT on master list
                                if finalList[currentAlts[i]] ~= nil then
                                    timing = finalList[currentAlts[i][1]].altGroupModified;
                                else
                                    timing = finalList[name].altGroupModified;
                                end

                                GRM.RemoveAlt ( currentAlts[i][1] , true , timing );
                            end
                        end

                        -- Step 2:
                        -- Now, if any alt is missing from the master list, we add it.
                        for i = 1 , #alts do
                            onList = false;
                            for j = 1 , #currentAlts do

                                if alts[i] == currentAlts[j][1] then

                                    onList = true;
                                    break;
                                end

                            end

                            if not onList then
                                addToAltsGroup = GRM.AddAlt ( name , alts[i] , true , finalList[name].altGroupModified );
                                GRM.SyncBirthdayWithNewAlt ( name , alts[i] , addToAltsGroup );
                            end
                        end

                    else
                        -- Master list has alts and the current list doesn't, so we are just going to add all from the master list
                        for i = 1 , #alts do
                            addToAltsGroup = GRM.AddAlt ( name , alts[i] , true , finalList[name].altGroupModified );
                            GRM.SyncBirthdayWithNewAlt ( name , alts[i] , addToAltsGroup );
                        end

                    end

                else
                    -- Remove all current alts not supposed to be on the list

                    if not GRMsyncGlobals.IsElectedLeader then
                        GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                        GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;
                    end

                    for i = 1 , #currentAlts do

                        if finalList[currentAlts[i][1]] ~= nil then
                            timing = finalList[currentAlts[i][1]].altGroupModified;
                        else
                            timing = finalList[name].altGroupModified;
                        end
                        GRM.RemoveAlt ( currentAlts[i][1] , true , timing );
                    end

                end

            end

        end

    else
        -- Error in the alt sync data...
        if GRM_G.DebugEnabled then
            print ( "GRM: Alt sync error. " .. countExpected .. " alts expedcted, but only received " .. GRM.TableLength ( finalList ) );
        end
    end
end

-- Method:          GRMsync.CheckRemoveAltChange ( string , string , string )
-- What it Does:    Syncs the removal of an alt between all ONLINE players
-- Purpose:         Sync data between online players.
GRMsync.CheckRemoveAltChange = function ( msg , sender )
    -- To avoid spamminess
    local isSyncUpdate = false;
    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local altName , altChangeTimeStamp , name = "" , 0 , "";

    altName , altChangeTimeStamp , name = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );
    altChangeTimeStamp = tonumber ( altChangeTimeStamp );

    local alt = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ altName ];

    if alt and altChangeTimeStamp >= alt.altGroupModified then

        if GRM.PlayerHasAlts ( alt ) then
            local isRemoved;

            if alt.altGroup ~= "" then
                isRemoved = false;
            end

            if isSyncUpdate then
                GRM.RemoveAlt ( altName , true , altChangeTimeStamp );
            else
                GRM.RemoveAlt ( altName , false , altChangeTimeStamp );
            end

            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == altName then       -- If the alt being removed is being dumped from the list of alts, but the Sync person is on that frame...
                -- if main, we will hide this.
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();

                GRM.PopulateAltFrames ( altName );
            end

            if isRemoved == false and alt.altGroup == "" then
                isRemoved = true;
            end

            if isRemoved then
                if GRM.S().syncChatEnabled and not isSyncUpdate then
                    
                    GRM.Report ( GRM.L ( "{name} removed {name2} from {custom1}'s list of Alts." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( altName , true ) , nil , GRM.GetClassifiedName ( name , true ) ) );
                end

                if not isSyncUpdate and GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
                    GRM.RefreshAuditFrames ( true , true );
                end
            end
        else
            alt.altGroupModified = altChangeTimeStamp;    -- More up to date timestamp will absorb it.
        end
    end
end

-- Method:          GRMsync.CheckAltMainChange ( string , string )
-- What it Does:    Syncs Main selection control between players
-- Purpose:         Sync data between players LIVE
GRMsync.CheckAltMainChange = function ( msg , sender )

    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local name , mainName , timestamp = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );

    timestamp = tonumber ( timestamp );

    GRM.SetMain ( mainName , timestamp );

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ mainName ];

    -- We need to add the timestamps our selves as well! In the main program, the timestamps are only triggered on manually clicking and adding/removing
    if player then
        player.mainStatusChangeTime = timestamp;

        -- Need to ensure "main" tag populates correctly.
        if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
            if not GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName == mainName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Show();
            elseif GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName ~= mainName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
            end
        end

        if GRM.S().syncChatEnabled then
            GRM.Report ( GRM.L ( "{name} set {name2} to be 'Main'" , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( mainName , true ) ) );
        end

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
            GRM.RefreshAuditFrames ( true , true );
        end
    end
    
end

-- Method:          GRMsync.CheckMainSyncChange ( string/table )
-- What it Does:    Syncs the MAIN status among all online guildies who have addon installed and are proper rank
-- Purpose:         Keep player MAINS sync'd properly!
GRMsync.CheckMainSyncChange = function ( msg )

    local mainName , mainStatus , mainChangeTimestamp = "" , false , 0;

    if type (msg) == "table" then

        mainName = msg[1];
        mainStatus = tostring ( msg[2] );
        mainChangeTimestamp = msg[3];

    else

        GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
        mainName , mainStatus , mainChangeTimestamp = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );
        mainChangeTimestamp = tonumber ( mainChangeTimestamp );

    end

    local player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ mainName ];

    if player then
        if tostring ( player.isMain ) ~= mainStatus then
            -- Updating count of changes
            GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
            GRMsyncGlobals.updatesEach[4] = GRMsyncGlobals.updatesEach[4] + 1;
        end

        if mainStatus == "true" then
            -- Set the player as Main
            GRM.SetMain ( mainName , mainChangeTimestamp );
            -- Need to ensure "main" tag populates correctly if window is open.
            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
                if not GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName == mainName then
                    GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Show();
                end
            end
        else
            -- remove from being main.
            GRM.DemoteFromMain ( mainName , mainChangeTimestamp );
            -- Udate the UI!
            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == mainName then
                GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
            end
        end
    end
end


-- Method:          GRMsync.CheckAltMainToAltChange ( string , string )
-- What it Does:    If a player is demoted from main to alt, it syncs that change with everyone
-- Purpose:         Sync data between players LIVE
GRMsync.CheckAltMainToAltChange = function ( msg , sender )

    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local name , mainName , timestamp = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );

    timestamp = tonumber ( timestamp );
    GRM.DemoteFromMain ( mainName , timestamp );

    if GRM_UI.GRM_MemberDetailMetaData:IsVisible() then
        if GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:IsVisible() and GRM_G.currentName == mainName then
            GRM_UI.GRM_MemberDetailMetaData.GRM_MemberDetailMainText:Hide();
        end
    end
    if GRM.S().syncChatEnabled then
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
    if GRM.S().syncCustomNote then

        if not GRMsyncGlobals.HalfSyncLive and string.find ( msg , "&X&" , 1 , true ) ~= nil then
            GRMsyncGlobals.HalfSyncLive = true;
            GRMsyncGlobals.HalfSyncMsgLive = string.sub ( msg , 1 , string.find ( msg , "&X&" , 1 , true ) - 1 );
        else

            GRM_G.MatchPattern4 = GRM_G.MatchPattern4 or GRM.BuildComPattern ( 4 , "?#" , false );
            local senderControlRankRequirement , playerName , timeStamp;
            local customNote = "";
            senderControlRankRequirement , playerName , timeStamp , msg = GRM.ParseComMsg ( msg , GRM_G.MatchPattern4 );
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
            if player then
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
    if GRM.S().syncCustomNote then

        if not GRMsyncGlobals.HalfSyncup and string.find ( msg , "&X&" , 1 , true ) ~= nil then
            GRMsyncGlobals.HalfSyncup = true;
            GRMsyncGlobals.HalfSyncupMsg = string.sub ( msg , 1 , string.find ( msg , "&X&" , 1 , true ) - 1 );
        else

            GRM_G.MatchPattern5 = GRM_G.MatchPattern5 or GRM.BuildComPattern ( 5 , "~X~" , false );

            local senderControlRankRequirement , playerName , timeStamp , editorName;
            local customNote = "";
            senderControlRankRequirement , playerName , timeStamp , editorName , msg = GRM.ParseComMsg ( msg , GRM_G.MatchPattern5 );
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
            if player then
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
                                GRMsyncGlobals.updatesEach[5] = GRMsyncGlobals.updatesEach[5] + 1;
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
    if GRM.S().syncBDays then
        local name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        msg = GRM.Next ( msg );
        local day = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = GRM.Next ( msg );
        local month = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = GRM.Next ( msg );
        local date = "";
        if string.sub ( msg , 1 , 1 ) ~= "?" then
            date = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        end
        local timestamp = tonumber ( GRM.Next ( msg ) );

        GRM.SetBirthday ( name , day , month , 1 , date , timestamp , true , sender , isFullSync );
    end
end

-- Method:          GRMsync.CheckBirthdayForSync (string or table)
-- What it Does:    Takes the birthday received info and updates the database
-- Purpose:         Updating and syncing birthday data
GRMsync.CheckBirthdayForSync = function ( data )

    if GRM.S().syncBDays then

        local name = ""
        local timestamp;
        local month = 0;
        local day = 0;
        local year = 0;
        local date = "";

        if type ( data ) == "string" then
            GRM_G.MatchPattern4 = GRM_G.MatchPattern4 or GRM.BuildComPattern ( 4 , "?" , false );
            name , timestamp , day , month = GRM.ParseComMsg ( data , GRM_G.MatchPattern4 );

            timestamp = tonumber ( timestamp );
            day = tonumber (day);
            month = tonumber(month);

        else
            name = data[1];
            timestamp = data[2];
            day = data[3];
            month = data[4];
        end

        year = select ( 4 , GRM.GetTodaysDate() );

        if day > 0 and month > 0 then

            date = GRM.GetTimestampFromTable ( { day , month , year } ) -- Places current year as placeholder
            
            GRM.SetBirthday ( name , day , month , 1 , date , timestamp , nil , nil , true );
        else
            GRM.ResetBirthdayForAltGroup ( name , false , 0 , nil , false );
        end

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

    GRM_G.MatchPattern5 = GRM_G.MatchPattern5 or GRM.BuildComPattern ( 5 , "?" , false );
    local name , banAlts , reason , class , guid = GRM.ParseComMsg ( msg , GRM_G.MatchPattern5 );

    local timeEpoch = time();
    local isAnEdit = false;

    if reason == GRM.L ( "None Given" ) then
        reason = "";
    end

    local guildData = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local leftGuildData = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ];
    local altData = GRMsyncGlobals.guildAltData;
    local player = guildData[ name ];
    
    -- First things first, let's find player!
    local isFound = false;
    local banSet = false;
    if player then
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
            local listOfAlts = GRM.GetListOfAlts ( player , false , altData );
            if #listOfAlts > 0 then
                for i = 1 , #listOfAlts do
                    banSet = false;
                    -- Need to search data the guildData and the nonGuildData...
                    player = guildData[ listOfAlts[i][1] ]
                    if player and player.name ~= GRM_G.addonUser then
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
                        player = leftGuildData[ listOfAlts[i][1] ]
                        if player and player.name ~= GRM_G.addonUser then
    
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
        if player then
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
                local listOfAlts = GRM.GetListOfAlts ( player , false , altData );
                if #listOfAlts > 0 then
                    for s = 1 , #listOfAlts do
                        banSet = false;
                        -- Need to search data the guildData and the nonGuildData...
                        player = guildData[ listOfAlts[s][1] ];
                        if player and player.name ~= GRM_G.addonUser then
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
                            if player and player.name ~= GRM_G.addonUser then
    
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
        memberInfoToAdd.rankName = "";                                          -- 2
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
        
        local _ , timeArray = GRM.EpochToDateFormat ( time() );
        GRM.AddMemberToLeftPlayers ( memberInfoToAdd , timeArray , time() , time() - 5000 , sender );

        -- Now, let's implement the ban!
        player = leftGuildData[ name ];
        if player then
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
    if GRM.S().syncChatEnabled and GRM.S()["toChat"].banned then
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
    if GRM.S().syncChatEnabled then
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

        if GRM.S().syncChatEnabled and GRM.S()["toChat"].banned then
            GRM.Report ( logReport );
        end

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
            GRM.BuildLogComplete( true , true );
        end
    end
end

-- Method:          GRMsync.BanManagement ( string or table , string , string )
-- What it Does:    Updates the ban data while syncing.
-- Purpose:         Syncing bans and unbans between players...
GRMsync.BanManagement = function ( msg , prefix , sender )

    local playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID , banTimeEpoch , banType , reason , playerWhoBanned;
    local banStatus = "ban";
    local addLog = false;
    
    if prefix == "GRM_BANSYNCUPX" then
        GRM_G.MatchPattern12 = GRM_G.MatchPattern12 or GRM.BuildComPattern ( 12 , "?" , false );

        playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID , banTimeEpoch , banType , reason , playerWhoBanned = GRM.ParseComMsg ( msg , GRM_G.MatchPattern12 );

        rankIndex = tonumber ( rankIndex );
        level = tonumber ( level );
        classIndex = tonumber ( classIndex );
        joinDateEpoch = tonumber ( joinDateEpoch );
        originalJoinEpoch = tonumber ( originalJoinEpoch );
        banTimeEpoch = tonumber ( banTimeEpoch );

        if reason == "X" then
            reason = "";
        else
            reason = string.gsub ( reason , "##" , "?" );   -- Returning the punctuation as this is user-input.
        end

        if playerWhoBanned == "X" then
            playerWhoBanned = sender;
        end

        if GUID == "X" then
            GUID = "";
        end

        if rankIndex == 99 or rankName == "###" then
            rankName = "";
            rankIndex = 99
        end

        GRMsync.UpdateLeftPlayerInfo ( { playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID } );

    else
        playerName = msg[1];
        banTimeEpoch = tonumber ( msg[2] );
        banType = msg[3];
        reason = msg[4];
        playerWhoBanned = msg[7]

        if reason == "X" then
            reason = "";
        end

        if playerWhoBanned == "X" then
            playerWhoBanned = sender;
        end

    end

    local player = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];
    local isAnEdit = false;
    
    if not player then
        player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][ playerName ];
    end

    if player then

        if banTimeEpoch > player.bannedInfo[2] then
            -- Ok, let's see if it is a ban or an unban!
            isAnEdit = false;
            if banType == "1" then

                if player.bannedInfo[1] then
                    isAnEdit = true;
                    addLog = true;
                else
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                    GRMsyncGlobals.updatesEach[7] = GRMsyncGlobals.updatesEach[7] + 1;
                end
                
                player.bannedInfo[1] = true;
                player.bannedInfo[2] = banTimeEpoch;
                player.bannedInfo[3] = false;
                player.bannedInfo[4] = playerWhoBanned;
                player.reasonBanned = reason;
                
            elseif banType == "2" then
                -- Cool, player is being unbanned! "unban"
                banStatus = "no ban";

                if player.bannedInfo[3] then
                    isAnEdit = true;
                    addLog = true;
                elseif player.bannedInfo[1] then        -- Only count if it is a ban or unban, not if just adding an outdated ban.
                    addLog = true;
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                    GRMsyncGlobals.updatesEach[7] = GRMsyncGlobals.updatesEach[7] + 1;
                end

                player.bannedInfo[1] = false;
                player.bannedInfo[2] = banTimeEpoch;
                player.bannedInfo[3] = true;
                player.bannedInfo[4] = playerWhoBanned;
                player.reasonBanned = "";
            end
    
            -- Add ban info to the log.
            -- Report the updates!
            if ( not player.class or player.class == "" ) and player.GUID ~= "" and player.GUID ~= nil then
                player.class = GRM.GetPlayerClassByGUID ( player.GUID );

                if player.class == "" or player.class == nil then
                    player.class = "HUNTER";        -- This shouldn't ever happen, but this is edge case if server fails to respond. Placholder class is set.
                end
            elseif player.GUID == nil then
                playuer.GUID = "";
            end

            if addLog then
                local colorCode = GRM.GetClassColorRGB ( player.class , true );
                local tempName = colorCode .. GRM.FormatName ( player.name ) .. "|r";

                local banEditMsgWithTime , banEditMsg = GRM.GetBanStatusSyncString ( banStatus , isAnEdit , tempName , GRM.GetClassifiedName ( playerWhoBanned , false ) , reason , select ( 2 , GRM.GetTimestamp() ) );
                
                -- unban = 21 , ban = 20
                if banType == "1" then

                    GRM.AddLog ( { 20 , banEditMsgWithTime , false , isAnEdit , tempName , GRM.GetClassifiedName ( playerWhoBanned , false ) , reason , select ( 2 , GRM.GetTimestamp() ) } );

                elseif banType == "2" then

                    GRM.AddLog ( { 21 , banEditMsgWithTime , tempName , GRM.GetClassifiedName ( playerWhoBanned , false ) , reason , select ( 2 , GRM.GetTimestamp() ) } );
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
    local altData = GRMsyncGlobals.guildAltData;
    local monthEnum = { Jan = 1 , Feb = 2 , Mar = 3 , Apr = 4 , May = 5 , Jun = 6 , Jul = 7 , Aug = 8 , Sep = 9 , Oct = 10 , Nov = 11 , Dec = 12 };
    local jd1 , pd1 , alt1 , main1 , ban1 , cust1 , bday1 = 0 , 0 , 0 , 0 , 0 , 0 , 0;
    local jd2 , pd2 , alt2 , main2 , ban2 , cust2 , bday2 = {} , {} , {} , {} , {} , {} , {};
    
    local date = "";
    local guidVal = 0;
    local byteVal = 0;

    local day = 0;
    local month = 0;
    local year = 0;

    GRMsyncGlobals.SyncTracker.buildingHashes = true;

    local getHashPrecision = function ( rNum1 , rString2 )
        table.insert ( rString2 , tostring ( rNum1 ) );
        rNum1 = 0;          -- reset the count
        return rNum1 , rString2;
    end

    local player;
    for i = 1 , #guildData do
        player = guildData[i];

        byteVal = GRM.ConvertStringToVal ( GRM.SlimName ( player.name ) );                  -- Get the byte of the first character of the first name... Adds increased uniqueness to the string
        if not player.GUID then
            player.GUID = "";
        end
        guidVal = GRM.ConvertGUIDToVal ( player.GUID );

        -- JD data
        if not player.joinDateUnknown and player.joinDateHist[1][6] then
            
            day = player.joinDateHist[1][1];
            month = player.joinDateHist[1][2];
            year = player.joinDateHist[1][3];
            if year > 2000 then
                year = year - 2000;
            end
            jd1 = jd1 + day + month + year + byteVal + guidVal;
            -- This adds the day + 2-digit year + byte value of name + guid 3-digit byte val
        end
        jd1 , jd2 = getHashPrecision ( jd1 , jd2 );

        -- PD data
        if not player.promoteDateUnknown and player.rankHist[1][7] then

            day = player.rankHist[1][2];
            month = player.rankHist[1][3];
            year = player.rankHist[1][4];

            if year > 2000 then
                year = year - 2000;
            end

            pd1 = pd1 + day + month + year + byteVal + guidVal;
            -- This adds the day + monthIndex + 2-digit year + byte value
        end

        pd1 , pd2 = getHashPrecision ( pd1 , pd2 );

        -- Alt Add Data
        local alts = GRM.GetListOfAlts ( player , false , altData );
        if #alts > 0 then
            for j = 1 , #alts do
                alt1 = alt1 + string.byte ( alts[j][1] ) + string.byte ( string.sub ( alts[j][1] , #alts[j][1] ) ) + #alts[j][1]; -- add first and last char bytes + char byte + length
            end
            alt1 = alt1 + byteVal + guidVal;
        end
        alt1 , alt2 = getHashPrecision ( alt1 , alt2 );

        -- Main Data
        if player.isMain then
            main1 = "1";
        else
            main1 = "0";
        end
        table.insert ( main2 , main1 )

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

    -- Ban Info
    -- List and total byteValue
    local bans = GRM.GetListBannedAndUnbannedPlayers ( { GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData } );
    for i = 1 , #bans do
        ban1 = ban1 + GRM.ConvertStringToVal ( bans[i][1] ) + bans[i][2];
    end

    ban2 = { ban1 , bans };

    return { jd2 , pd2 , alt2 , main2 , cust2 , bday2 , ban2 };
end

-- Method:          GRMsync.BuildMessagePreCheck()
-- What it Does:    Compiles the hash into an array of strings
-- Purpose:         To create a format for comparison for easy sending.
GRMsync.BuildMessagePreCheck = function()
    local values = GRMsync.GetCustomPseudoHash();
    local tags = { "JD" , "PD" , "ALT" , "MAIN" , "CUST" , "BDAY" , "BAN" };
    local result = {};
    local temp = "";
    local preTemp = "";
    local commMsgHeader = GRM_G.PatchDayString .. "?GRM_PHASH?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1] .. "?";
    local commMsgHeaderBan = GRM_G.PatchDayString .. "?GRM_PHASHBAN?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1] .. "?";
    local c;

    GRMsyncGlobals.SyncTracker.sendingHashes = true;
    
    -- Everything but Ban Values
    for i = 1 , ( #values - 1 ) do

        -- new DB item
        c = 1;

        result[i] = {};

        while c <= #values[i] do

            -- new comms msg
            temp = "";
            preTemp = commMsgHeader .. tags[i] .. "?";

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

    -- Ban Values
    result[7] = {};
    for j = 1 , #values[7][2] do

        temp = commMsgHeaderBan .. values[7][1] .. "?" .. values[7][2][j][1] .. "--" .. tostring ( values[7][2][j][2] ) .. "?";

        table.insert ( result[7] , temp );
    end

    return result;
end

-- Method:          GRMsync.BuildLeaderPreCheckString()
-- What it Does:    Builds a string for the sync leader a lighter representation of which blocks to to consider
-- Purpose:         When minimal data is sent from the player to the sync leader, it is wise for the sync leader to also know which blocks need to be checked
--                  so it doesn't scan through the full database looking for the comparisons. This sends back a representation of which blocks to send.
GRMsync.BuildLeaderPreCheckString = function()
    local tags = { "JD" , "PD" , "ALT" , "MAIN" , "CUST" , "BDAY" , "BAN" };
    local result = {};
    local temp = "";
    local preTemp = "";
    local value = 0;
    local c;    -- count
    local commMsgHeader = GRM_G.PatchDayString .. "?GRM_PHASHL?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.DesignatedLeader .. "?";
    local commMsgHeaderBan = GRM_G.PatchDayString .. "?GRM_PHASHLBAN?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.DesignatedLeader .. "?";

    for i = 1 , #GRMsyncGlobals.DatabaseMarkers do
        c = 1;  -- new Database item, let's reset the count
        result[i] = {};

        if i < 7 then
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
        else

            while c <= #GRMsyncGlobals.DatabaseMarkers[i] do
                -- new comm msg
                temp = "";
                preTemp = commMsgHeaderBan;

                for j = c , #GRMsyncGlobals.DatabaseMarkers[i] do

                    preTemp = preTemp .. GRMsyncGlobals.DatabaseMarkers[i][j] .. "?";

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
    end
    return result;
end

-- Method:          GRMsync.SendDatabaseMarkersToLeader( table )
-- What it Does:    Builds the strings and sends them for the sync leader to compare
-- Purpose:         No need for the leader to process everything in terms of database block markers when you already have. Just sends the results.
GRMsync.SendDatabaseMarkersToLeader = function( markers )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local databaseMarkers = markers or GRMsync.BuildLeaderPreCheckString();

    if not GRMsyncGlobals.SyncTracker.sendingHashes then
        GRMsyncGlobals.SyncTracker.sendingHashes = true;
    end

    for i = GRMsyncGlobals.MarkerC , #databaseMarkers do
        

        for j = GRMsyncGlobals.MarkerD , #databaseMarkers[i] do
            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #databaseMarkers[i][j] + GRMsyncGlobals.sizeModifier;

            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                GRMsyncGlobals.SyncCount = 0; 
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendDatabaseMarkersToLeader ( databaseMarkers );
                end);       -- Add a delay on packet sending.
                return;
            else
                GRMsync.SendMessage ( "GRM_SYNC" , databaseMarkers[i][j] , GRMsyncGlobals.DesignatedLeader );
            end
            GRMsyncGlobals.MarkerD = GRMsyncGlobals.MarkerD + 1;
        end

        GRMsyncGlobals.MarkerC = GRMsyncGlobals.MarkerC + 1;
        GRMsyncGlobals.MarkerD = 1;
    end
    GRMsyncGlobals.syncTempDelay = false;
    GRMsyncGlobals.MarkerC = 1;
    GRMsyncGlobals.MarkerD = 1;

    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_PHASHL?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.DesignatedLeader .. "?FINISH?" , GRMsyncGlobals.DesignatedLeader );
end

-- Method:          GRMsync.SendNonLeaderDatabaseMarkers( table )
-- What it Does:    Builds the strings and sends them for the non sync leader to compare
-- Purpose:         Efficiency
GRMsync.SendNonLeaderDatabaseMarkers = function ( markers , ind1 , ind2 )

    if not GRMsyncGlobals.SyncTracker.sendingHashes then
        GRMsyncGlobals.SyncTracker.sendingHashes = true;
    end

    if GRMsyncGlobals.SyncQue[1] ~= nil then

        if not GRMsyncGlobals.SyncTracker.sendingHashes then
            GRMsyncGlobals.SyncTracker.sendingHashes = true;
        end

        GRMsyncGlobals.TimeSinceLastSyncAction = time();
        local databaseMarkers = markers or GRMsync.BuildMessagePreCheck();

        for i = GRMsyncGlobals.MarkerC , #databaseMarkers do

            for j = GRMsyncGlobals.MarkerD , #databaseMarkers[i] do

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #databaseMarkers[i][j] + GRMsyncGlobals.sizeModifier;

                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;
                    GRMsyncGlobals.SyncCount = 0;

                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendNonLeaderDatabaseMarkers ( databaseMarkers );
                    end);       -- Add a delay on packet sending.
                    return;

                else
                    GRMsync.SendMessage ( "GRM_SYNC" , databaseMarkers[i][j] , GRMsyncGlobals.CurrentSyncPlayer );
                end

                GRMsyncGlobals.MarkerD = GRMsyncGlobals.MarkerD + 1;
            end
            GRMsyncGlobals.MarkerC = GRMsyncGlobals.MarkerC + 1;
            GRMsyncGlobals.MarkerD = 1;
        end
        GRMsyncGlobals.syncTempDelay = false;

        if not GRMsyncGlobals.errorCheckEnabled and not GRMsyncGlobals.ErrorCheckControl then

            GRMsyncGlobals.errorCheckEnabled = true;
            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );

        elseif GRMsyncGlobals.ErrorCheckControl then

            if not GRMsyncGlobals.errorCheckEnabled then
                GRMsyncGlobals.errorCheckEnabled = true;
            end

            GRMsyncGlobals.ErrorCheckControl = false;
        end

        GRMsyncGlobals.MarkerC = 1;
        GRMsyncGlobals.MarkerD = 1

        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_PHASH?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1] .. "?FINISH?" , GRMsyncGlobals.CurrentSyncPlayer );

    end
    
end

-- Method:          GRMsync.BuildLeaderDatabaseMarkers ( string , bool )
-- What it Does:    Takes the string of received values usually like "JD?10101010111001", parses out that tag, converts the string of numebrs into an array, converts 1 to true, and 0 to false
--                  and then sets the Sync leaders DatabaseMarkers appropriately
-- Purpose:         So the sync leader can also see what is needed to be compared without needeing to reprocess all.
GRMsync.BuildLeaderDatabaseMarkers = function( received , isBan )
    local tagEnum = { JD = 1 , PD = 2 , ALT = 3 , MAIN = 4 , CUST = 5 , BDAY = 6 };
    local index;
    local DBresults;
    
    if not isBan then
        
        local tag = ( string.sub ( received , 1 , string.find ( received , "?" ) - 1 ) );
        index = tagEnum [ tag ];
        received = GRM.Next ( received );
        DBresults = GRM.ConvertStringNumArrayToBoolArray ( GRM.StringToCharArray ( received ) );
        -- merge the tables

        if not GRMsyncGlobals.DatabaseMarkers[index] then
            GRMsyncGlobals.DatabaseMarkers[index] = {};
        end

        for i = 1 , #DBresults do
            table.insert ( GRMsyncGlobals.DatabaseMarkers[index] , DBresults[i] );
        end
    else
        index = 7;
        received = GRM.Next ( received );
        
        if not GRMsyncGlobals.DatabaseMarkers[index] then
            GRMsyncGlobals.DatabaseMarkers[index] = {};
        end

        local name = "";
        while string.find ( received , "?" ) ~= nil do
            name = string.sub ( received , 1 , string.find ( received , "?" ) - 1 );
            received = string.sub ( received , string.find ( received , "?" ) + 1 );

            table.insert ( GRMsyncGlobals.DatabaseMarkers[index] , name );
        end

    end   
    
end

-- Method:          GRMsync.SetReceivedHashValue ( string , bool )
-- What it Does:    Converts the received sendAddonMessage string to an array of the values
-- Purpose:         For easier comparison of own database to received.
GRMsync.SetReceivedHashValue = function ( hashReceived , isBan )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local resultReceived = {};
    local tagEnum = { JD = 1 , PD = 2 , ALT = 3 , MAIN = 4 , CUST = 5 , BDAY = 6 };
    local index;
    local banValue = 0;
    local name , num = "" , 0;

    if not isBan then
        local tag = ( string.sub ( hashReceived , 1 , string.find ( hashReceived , "?" ) - 1 ) );
        index = tagEnum [ tag ];

        hashReceived = GRM.Next ( hashReceived );
        
        
        while hashReceived and string.find ( hashReceived , "?" ) ~= nil do
            table.insert ( resultReceived , string.sub ( hashReceived , 1 , string.find ( hashReceived , "?" ) - 1 ) );
            hashReceived = GRM.Next ( hashReceived );
            if hashReceived == "?" then
                break;
            end
        end
    else
        index = 7;
        banValue = tonumber ( string.sub ( hashReceived , 1 , string.find ( hashReceived , "?" ) - 1 ) );
        hashReceived = GRM.Next ( hashReceived );
        name = string.sub ( hashReceived , 1 , string.find ( hashReceived , "%-%-" ) - 1 );
        num = tonumber ( string.match ( hashReceived , "%-%-(%d+)" ) );

        table.insert ( resultReceived , banValue );
        table.insert ( resultReceived , { name , num } );
    end
    
    if not GRMsyncGlobals.HashValuesReceived[index] then
        GRMsyncGlobals.HashValuesReceived[index] = {};
    end

    -- merging the tables
    for i = 1 , #resultReceived do
        if i > 1 or not isBan or ( isBan and i == 1 and #GRMsyncGlobals.HashValuesReceived[index] == 0 ) then
            table.insert ( GRMsyncGlobals.HashValuesReceived[index] , resultReceived[i] );
        end
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
    local banPermissions = ( GRM_G.playerRankID <= GRMsyncGlobals.senderBanRankReq and GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankBanList );
    local bans = {};

    -- Databases do not currently align... Need another roster scan to align the changes.
    if #GRMsyncGlobals.HashValuesReceived ~= #HashValuesMine then
        return nil;
    end

    for i = 1 , #HashValuesMine do
        temp = {};
        if i < 7 then

            for j = 1 , #HashValuesMine[i] do
                isSame = false;

                if GRMsyncGlobals.HashValuesReceived[i][j] ~= nil then
                    if GRMsyncGlobals.HashValuesReceived[i][j] == tostring ( HashValuesMine[i][j] ) then
                        isSame = true;
                    end

                else
                    isSame = true;      -- technically not true, but we are missing a value here so impossible to know and to check would cause an error. Possible player joined right in the middle of this check... though scanning is disabled, there is a split moment it can fall in in the millisecond delay between coms of the 2 players... so rare, but possible. Just defaults to check it just in case.
                end

                table.insert ( temp , isSame );
            end

        end
        result[i] = temp;
    end

    -- Compare ban information now...
    if HashValuesMine[7][1] ~= GRMsyncGlobals.HashValuesReceived[7][1] then
        -- Has values differ, now let's see which are different.

        local isFound = false;
        for i = 1 , #HashValuesMine[7][2] do
            isFound = false;

            for j = 2 , #GRMsyncGlobals.HashValuesReceived[7] do

                if GRMsyncGlobals.HashValuesReceived[7][j][1] == HashValuesMine[7][2][i][1] then
                    if GRMsyncGlobals.HashValuesReceived[7][j][2] ~= HashValuesMine[7][2][i][2] then   -- Epoch times differ, need sync
                        bans[GRMsyncGlobals.HashValuesReceived[7][j][1]] = {};
                    end
                    isFound = true;
                    break;
                end
            end

            if not isFound then
                bans[HashValuesMine[7][2][i][1]] = {};
            end
        end

        for i = 2 , #GRMsyncGlobals.HashValuesReceived[7] do
            isFound = false;
            for j = 1 , #HashValuesMine[7][2] do

                if not bans[HashValuesMine[7][2][j][1]] and HashValuesMine[7][2][j][1] == GRMsyncGlobals.HashValuesReceived[7][i][1] then
                    if HashValuesMine[7][2][j][2] ~= GRMsyncGlobals.HashValuesReceived[7][i][2] then   -- Epoch times differ, need sync
                        bans[HashValuesMine[7][2][j][1]] = {};
                    end
                    isFound = true;
                    break;
                end
            end

            if not isFound and not bans[GRMsyncGlobals.HashValuesReceived[7][i][1]] then
                bans[GRMsyncGlobals.HashValuesReceived[7][i][1]] = {};
            end
        end

        result[7] = GRM.ConvertTableToArray ( bans );
        
    else
        result[7] = {};
    end

    return result;
end

-- Method:          GRMsync.SyncIsNecessary()
-- What it Does:    It initializes the database markers for knowing where to send the data, and returns true if sync is necessary
-- Purpose:         Kick start refined sync algorithm for improved speed.
GRMsync.SyncIsNecessary = function()
    GRMsyncGlobals.DatabaseMarkers = GRMsync.CompareDatabaseMarkers();
    if not GRMsyncGlobals.DatabaseMarkers then
        GRMsyncGlobals.DatabaseMarkers = {};
        return false;
    end

    return GRMsync.SyncProgressInitialize();
end

-- Method:          GRMsync.SyncProgressInitialize()
-- What it Does:    Initializes the SyncProgress array which is a boolean gate for each section to sync
-- Purpose:         Efficiency in syncing data of course!
GRMsync.SyncProgressInitialize = function()
    local result = false;
    local banPermissions = ( ( GRMsyncGlobals.IsElectedLeader and GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankBanList ) or ( not GRMsyncGlobals.IsElectedLeader and GRM_G.playerRankID <= GRMsyncGlobals.senderBanRankReq ) );

    for i = 1 , #GRMsyncGlobals.DatabaseMarkers do

        if i < 7 then

            for j = 1 , #GRMsyncGlobals.DatabaseMarkers[i] do
                if not GRMsyncGlobals.DatabaseMarkers[i][j] then
                    result = true;

                    -- Some messy code needed to be reorganized
                    if i < 6 then                                   -- Join, Promote, Alt, Main , Custom
                        GRMsyncGlobals.SyncProgress[i] = true;
                    elseif i == 6 then                              -- Bday
                        GRMsyncGlobals.SyncProgress[7] = true;
                    end
                    break;

                end
            end

        end
    end

    if banPermissions and #GRMsyncGlobals.DatabaseMarkers[7] > 0 then
        result = true;
        GRMsyncGlobals.SyncProgress[6] = true; 

    else
        GRMsyncGlobals.SyncProgress[6] = false; 
    end

    return result;
end

-- Method:          GRMsync.NextSyncStep( int )
-- What it Does:    Activates the appropriate sync data packet dump collection, for time saving.
-- Purpose:         Cleanly execute sharing and syncing data in a minimalistic way, in specified order. DO NOT ADJUST ORDER as some things require review prior to next step.
GRMsync.NextSyncStep = function( nextStep )
    local actions = { GRMsync.SendJDPackets , GRMsync.SendPDPackets , GRMsync.SendAddAltPackets , GRMsync.SendMainPackets , GRMsync.SendCustomNotePackets , GRMsync.SendBANPackets , GRMsync.SendCompletionMsg , GRMsync.SendBDayPackets }

    for i = nextStep , #GRMsyncGlobals.SyncProgress do
        if ( i == 7 and GRMsyncGlobals.SyncProgress[8] ) or ( i ~= 7 and GRMsyncGlobals.SyncProgress[i] ) then
            
            if i == 5 then -- Custom Note
                if GRM.IsAnyCustomNoteLarge() then
                    if GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessage then
                        GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessageModifier1;
                    end
                end
            else
                GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
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

        if index ~= 7 then

            for i = 1 , #GRMsyncGlobals.DatabaseMarkers[index] do
                if not GRMsyncGlobals.DatabaseMarkers[index][i] then
                    table.insert ( result , i );
                end

            end
        else
            result = GRMsyncGlobals.DatabaseMarkers[index];
        end
    end
    return result;
end

-- Method:          GRMsync.BuildFullCheckArray()
-- What it Does:    Compiles the full array of int values representing exact database indexes.
-- Purpose:         Sync efficiency!!!
GRMsync.BuildFullCheckArray = function()
    for i = 1 , 7 do
        GRMsyncGlobals.DatabaseExactIndexes[i] = GRMsync.BuildDatabaseCheckArray(i);
    end
end
-- Join, Promote, Alt, Main , Custom , BAN  BDAY
-- Method:          GRMsync.SendCompletionMsg ()
-- What it Does:    Builds a message to be sent to the sync Leader which states the player is done sending data, and it sends which types it sent over, thus keeping the analysis lean
-- Purpose:         Speed speed SPEED!!!
GRMsync.SendCompletionMsg = function()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    -- This string is reordered for legacy code reasons in change 1.50 that I just do not wish to have to restructure. Minor adaptation

    local msg = GRM_G.PatchDayString .. "?GRM_STOP?" .. GRM.S().syncRank .. "?" .. ( tostring ( GRMsyncGlobals.SyncProgress[1] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[2] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[3] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[4] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[5] ) .. "?" .. tostring ( GRMsyncGlobals.SyncProgress[6] ) );

    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.DesignatedLeader );
    -- Need to Disable error checking now as you will stop communicating with the designated leader

    if GRMsyncGlobals.DatabaseExactIndexes[4] == nil or GRMsyncGlobals.DatabaseExactIndexes[6] == nil then
        GRMsync.BuildFullCheckArray();
    end

    if #GRMsyncGlobals.DatabaseExactIndexes[4] == 0 and #GRMsyncGlobals.DatabaseExactIndexes[6] == 0 then
        GRMsyncGlobals.dateSentComplete = true; 
    end
end

-- Method:          GRMsync.SendBDAYCompletion()
-- What it Does:    Sends the sync leader a confirmation that all bday info has been sent and all data will now be stopped
-- Purpose:         Control flow of sync process
GRMsync.SendBDAYCompletion = function()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    local msg = GRM_G.PatchDayString .. "?GRM_STOP2?" .. GRM.S().syncRank .. "?";

    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.DesignatedLeader );

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

        -- Progress tracking
        if not GRMsyncGlobals.SyncTracker.jd then
            GRMsyncGlobals.ProgressControl ( "JD" );
        end

        GRMsyncGlobals.SyncJDDelay = time();
        -- Initiate Data sending
        GRMsyncGlobals.dateSentComplete = false;
        GRMsyncGlobals.TimeSinceLastSyncAction = time(); 

        -- Messages need to be throttled, but sending them under controls.
        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
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
                
                if guildData[dataIndexes[1][i]].joinDateHist[1][6] then
                    hasAtLeastOne = true;
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?" .. guildData[dataIndexes[1][i]].name .. "?" .. guildData[dataIndexes[1][i]].joinDateHist[1][4] .. "?" .. guildData[dataIndexes[1][i]].joinDateHist[1][5];

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == #dataIndexes[1] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_JDSYNC?" .. syncRankFilter .. "?" .. guildData[dataIndexes[1][i]].name .. "?" .. guildData[dataIndexes[1][i]].joinDateHist[1][4] .. "?" .. guildData[dataIndexes[1][i]].joinDateHist[1][5];
                            -- Need to send it out as it will not re-loop
                            if i == #dataIndexes[1] then
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.DesignatedLeader );
                            end
                        end
                    end
                end

                -- Send message
                if messageReady or ( hasAtLeastOne and i == #dataIndexes[1] ) then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
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
            else
                GRMsync.EndSync();
                return;
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

        -- Progress tracking
        if not GRMsyncGlobals.SyncTracker.pd then
            GRMsyncGlobals.ProgressControl ( "PD" );
        end

        GRMsyncGlobals.SyncPDDelay = time();
        -- Initiate Data sending
        GRMsyncGlobals.TimeSinceLastSyncAction = time();
    
        -- Messages need to be throttled, but sending them under controls.
        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
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

                if guildData[exactIndexes[2][i]].rankHist[1][7] and guildData[exactIndexes[2][i]].rankHist[1][6] ~= 0 then
                    hasAtLeastOne = true;
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then

                        tempMessage = syncMessage .. "?" .. guildData[exactIndexes[2][i]].name .. "?" .. guildData[exactIndexes[2][i]].rankHist[1][5] .. "?" .. guildData[exactIndexes[2][i]].rankHist[1][6];

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;

                            if i == #exactIndexes[2] then
                                messageReady = true;
                            end

                        else
                            messageReady = true;
                            
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_PDSYNC?" .. syncRankFilter .. "?" .. guildData[exactIndexes[2][i]].name .. "?" .. guildData[exactIndexes[2][i]].rankHist[1][5] .. "?" .. guildData[exactIndexes[2][i]].rankHist[1][6];

                            -- If we are in the last index it won't loop back around, so we need to send it now...
                            if i == #exactIndexes[2] then
                                -- This will be sent
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.DesignatedLeader );
                            end

                        end
                    end
                end

                -- Send message
                if messageReady or ( hasAtLeastOne and i == #exactIndexes[2] ) then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
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
            else
                GRMsync.EndSync();
                return;
            end
        end
        
        -- Close the Data stream
        GRMsyncGlobals.SyncCountPD = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 3 );
        else
            GRMsync.EndSync();
            return;
        end
    end
end

-- Method:          GRMsync.SendAddAltPackets()
-- What it Does:    Compartmentalizes the Add Alt logorithm to send the data controlled, fills the packets to max characters, and sends and if it hits throttle cap, resets.
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendAddAltPackets = function()
    if time() - GRMsyncGlobals.SyncAltDelay >= 0.9 then

        -- Progress tracking
        if not GRMsyncGlobals.SyncTracker.alts then
            GRMsyncGlobals.ProgressControl ( "ALT" );
        end

        GRMsyncGlobals.SyncAltDelay = time();
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        -- Message controls for throttle considerations and packing them fully...
        local syncMessage = "";
        local tempMessage = "";
        local tempMessage2 = GRM_G.PatchDayString .. "?GRM_ALTADDSYNC?" .. syncRankFilter;
        local tempMessage3 = "";
        local tempMessage4 = "";
        local messageReady;
        local i = GRMsyncGlobals.SyncCountAltAdd;
        local hasAtLeastOne = false;
        local alts = {};
        local endCheck = false;

        -- Set the tables to new memory index to prevent stutter...
        if GRMsyncGlobals.AltSendIsFinished then
            GRMsyncGlobals.TempRoster = GRM.DeepCopyArray ( GRMsyncGlobals.guildData );     -- I will be editiing the other one so needs to be made.
            GRMsyncGlobals.TempAltRoster = GRM.DeepCopyArray ( GRMsyncGlobals.guildAltData ); -- reset the alt Roster
            GRMsyncGlobals.AltSendIsFinished = false;
            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendAddAltPackets );
            return;
        end
        -- name , altGroupModified , alts...
        if not GRMsyncGlobals.syncTempDelay2  then

            local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
            -- Messages need to be throttled, but sending them under controls.
            -- Note "&" represents the start of a new toon's alts list in the same string.
            while i <= #exactIndexes[3] do
                messageReady = false;
                hasAtLeastOne = true
                endCheck = false;

                if GRMsyncGlobals.SyncOK then

                    tempMessage = tempMessage2 .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].altGroupModified );

                    if GRM.GetNumAlts ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].altGroup ) > 0 then   -- Player does have alts, let's build the list

                        alts = GRM.GetListOfAlts ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]] , false , GRMsyncGlobals.TempAltRoster );
                        
                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then

                            for j = GRMsyncGlobals.SyncCountAltAdd2 , #alts do
                                endCheck = false;
                                -- Temp store current build of message
                                tempMessage3 = tempMessage;

                                -- Add the alt...
                                tempMessage4 = tempMessage .. "?" .. alts[j][1];

                                if #tempMessage4 + GRMsyncGlobals.sizeModifier >= 255 then
                                    -- Loop back around
                                    syncMessage = tempMessage3;
                                    endCheck = true;

                                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;

                                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                                    
                                    -- Since only in the nested for loop, not the higher while loop, need to rebuild message start.
                                    tempMessage = tempMessage2 .. "?" .. GRMsyncGlobals.TempRoster[exactIndexes[3][i]].name .. "?" .. tostring ( GRMsyncGlobals.TempRoster[exactIndexes[3][i]].altGroupModified ) .. "?" .. alts[j][1];
                    
                                    -- Check if there needs to be a throttled delay
                                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                                        GRMsyncGlobals.syncTempDelay = true;
                                        GRMsyncGlobals.SyncCountAltAdd = i;
                                        GRMsyncGlobals.SyncCountAltAdd2 = j;
                                        GRMsyncGlobals.SyncCount = 0;
                                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendAddAltPackets );       -- Add a 1 second delay on packet sending.
                                        return;
                                    end

                                else
                                    tempMessage = tempMessage4;
                                end

                                if j == #alts then

                                    if endCheck then
                                        syncMessage = tempMessage;
                                    else
                                        syncMessage = tempMessage4;
                                    end                                  
                                    
                                    messageReady = true;

                                end

                            end
                        end
                    else
                        -- No Alts to send, so send an empty player with altGroupModified timestamp
                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            messageReady = true;
                            syncMessage = tempMessage;
                        end
                    end

                    if ( messageReady or ( hasAtLeastOne and i == #exactIndexes[3] ) ) and syncMessage ~= "" then

                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );

                    end

                    -- Check if there needs to be a throttled delay
                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.syncTempDelay = true;
                        GRMsyncGlobals.SyncCountAltAdd = i;
                        GRMsyncGlobals.SyncCount = 0;
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendAddAltPackets );       -- Add a 1 second delay on packet sending.
                        return;
                    end
                else
                    GRMsync.EndSync();
                    return;
                end
                -- Progress the while loop
                i = i + 1;
                GRMsyncGlobals.SyncCountAltAdd2 = 1;
            end

        end

        GRMsyncGlobals.SyncCountAltAdd = 1;
        GRMsyncGlobals.SyncCountAltAdd2 = 1;
        GRMsyncGlobals.syncTempDelay = false;
        GRMsyncGlobals.syncTempDelay2 = false;
        GRMsyncGlobals.AltSendIsFinished = true;
        GRMsyncGlobals.AltSendIsFinished2 = true;
        GRMsyncGlobals.TempRoster = nil;
        GRMsyncGlobals.TempRoster = {};
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 4 );
        else
            GRMsync.EndSync();
            return;
        end
    end
end

-- Method:          GRMsync.SendMainPackets()
-- What it Does:    Broadcasts to the leader all MAIN information
-- Purpose:         Data sync
GRMsync.SendMainPackets = function()
    if time() - GRMsyncGlobals.SyncMainDelay >= 0.9 then
        -- Progress tracking
        if not GRMsyncGlobals.SyncTracker.mains then
            GRMsyncGlobals.ProgressControl ( "MAIN" );
        end

        GRMsyncGlobals.SyncMainDelay = time();
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        -- Messages need to be throttled, but sending them under controls.
        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end
        local syncMessage = GRM_G.PatchDayString .. "?GRM_MAINSYNC?" .. syncRankFilter;
        local tempMessage = "";
        local messageReady;
        local isPlayerMain = "0";
        local hasAtLeastOne = false;

        local guildData = GRMsyncGlobals.guildData;
        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;

        for i = GRMsyncGlobals.SyncCountMain , #exactIndexes[4] do
            messageReady = false;
            if GRMsyncGlobals.SyncOK then
                isPlayerMain = "0";       -- Kept as a string rather than a boolean so it can be passed as a comm over the server without needing to cast it to a string.
                if guildData[exactIndexes[4][i]].isMain then
                    isPlayerMain = "1";
                end
                if guildData[exactIndexes[4][i]].isMain or guildData[exactIndexes[4][i]].mainStatusChangeTime ~= 0 then
                    -- Expand the string more... Fill up the full 255 characters for efficiency.
                    hasAtLeastOne = true;

                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?" .. guildData[exactIndexes[4][i]].name  .. "?" .. tostring ( guildData[exactIndexes[4][i]].mainStatusChangeTime ) .. "?" .. isPlayerMain;

                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                            syncMessage = tempMessage;
                            if i == #exactIndexes[4] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            -- Hold this value over...
                            tempMessage = GRM_G.PatchDayString .. "?GRM_MAINSYNC?" .. syncRankFilter .. "?" .. guildData[exactIndexes[4][i]].name  .. "?" .. tostring ( guildData[exactIndexes[4][i]].mainStatusChangeTime ) .. "?" .. isPlayerMain;

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
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
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
            else
                GRMsync.EndSync();
                return;
            end
        end
        -- Close the Data stream
        GRMsyncGlobals.SyncCountMain = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 5 );
        else
            GRMsync.EndSync();
            return;
        end
    end
end

-- Method:          GRMsync.SendBANPackets()
-- What it Does:    Broadcasts to the leader all Ban information
-- Purpose:         Data sync
GRMsync.SendBANPackets = function()
    if time() - GRMsyncGlobals.SyncBanDelay >= 0.9 then

        -- Progress tracking
        if not GRMsyncGlobals.SyncTracker.banData then
            GRMsyncGlobals.ProgressControl ( "BAN" );
        end

        GRMsyncGlobals.SyncBanDelay = time();
        -- Initiate Data sending
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        -- One for former, one for current members.
        local messageHeader = GRM_G.PatchDayString .. "?GRM_BANSYNC?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList );
        local messageHeader2 = GRM_G.PatchDayString .. "?GRM_BANSYNCX?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList );
        local messageHeader3 = GRM_G.PatchDayString .. "?GRM_BANSYNCXX?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList );
        local messageHeader4 = GRM_G.PatchDayString .. "?GRM_BANSYNCSP?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList );
        local messageHeader5 = GRM_G.PatchDayString .. "?GRM_BANSYNCSPX?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList );
        local syncMessage = "";
        local tempMessage = "";
        local messageReady;
        local guildData = GRMsyncGlobals.guildData;
        local leftGuildData = GRMsyncGlobals.formerGuildData;
        local banNames = GRMsyncGlobals.DatabaseExactIndexes[7];
        local j;

        -- Banned info to send.
        local timeStampOfBanChange = "";
        local banType = "3";  -- 1 = ban , 2 = unban , 3 = noBan  -- string format for sending
        local reason = "";
        local playerWhoBanned = "";
        local class = "";
        local GUID = "";
        local formerMember = false;
        local rankName = "";
        local msg = "";

        for i = GRMsyncGlobals.SyncCountBan , #banNames do
            messageReady = false;
            local player;

            if GRMsyncGlobals.SyncOK then

                j = GRM.GetIndexOfPlayerOnList ( guildData , banNames[i] );

                if not j then
                    j = GRM.GetIndexOfPlayerOnList ( leftGuildData , banNames[i] );
                    if j then
                        player = leftGuildData[j];
                        formerMember = true;
                    end
                else
                    player = guildData[j];
                    formerMember = false;
                end

                if player then

                    -- CLASS
                    if player.class == nil or player.class == "" then
                        class = "0";        -- zero so it is just 1 char long.
                    else
                        class = tostring ( GRM_G.classFileIDEnum[ player.class ] )
                    end
                    if not class then
                        class = "0";
                    end

                    -- OLD META EPOCH
                    oldJoinDateMeta = 0;
                    if player.joinDateHist[1][4] > 0 then
                        oldJoinDateMeta = player.joinDateHist[1][4];
                    elseif player.rankHist[1][5] > 0 then
                        oldJoinDateMeta = player.rankHist[1][5]; -- for some reason no join leave data recorded so default
                    end

                    -- GUID
                    GUID = player.GUID;
                    if player.GUID == "" or player.GUID == nil then
                        GUID = "X";

                        if player.GUID == nil then
                            player.GUID = "";
                        end
                    elseif string.find ( GUID , "Player-.+" ) then
                        GUID = string.match ( player.GUID , "Player-(.+)" );
                    end
                    
                    -- BANTYPE
                    if player.bannedInfo[1] then
                        banType = "1";
                    elseif player.bannedInfo[3] then
                        banType = "2";
                    else
                        banType = "3";
                    end

                    -- REASON FOR BAN
                    if player.reasonBanned == "" or player.reasonBanned == nil then
                        reason = "X";
                    else
                        reason = string.gsub ( player.reasonBanned , "?" , "##" );  -- Need to preserve ? for unpacking
                    end

                    -- PERSON WHO BANNED
                    if player.bannedInfo[4] == "" or player.bannedInfo[4] == nil then
                        playerWhoBanned = "X";
                    else
                        playerWhoBanned = player.bannedInfo[4];
                    end

                    -- name , rankName , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID , banTimeEpoch , banType , reason , playerWhoBanned
                    -- NOTE - RANKNAME used instead of rank index on bans so the historical name will be that. The rank index can change overtime if order of ranks is manipulated.

                    if formerMember then

                        rankName = player.rankName;
                        if player.rankIndex == 99 then
                            rankName = "###";
                        end

                        msg = player.name .. "?" .. rankName .. "?" .. tostring ( player.rankIndex ) ..  "?" .. tostring ( player.level ) .. "?" .. class .. "?" .. tostring ( player.joinDateHist[1][4] ) .. "?" .. tostring ( oldJoinDateMeta ) .. "?" .. GUID .. "?" .. tostring ( player.bannedInfo[2] ) .. "?" .. banType .. "?" .. reason .. "?" .. playerWhoBanned;


                        tempMessage = messageHeader .. "?" .. msg;

                    else

                        msg = player.name .. "?" .. tostring ( player.bannedInfo[2] ) .. "?" .. banType .. "?" .. reason .. "?" .. playerWhoBanned;
                        tempMessage = messageHeader2 .. "?" .. msg;
                        
                    end

                    if ( #tempMessage + GRMsyncGlobals.sizeModifier ) < 255 then
                        syncMessage = tempMessage;
                        messageReady = true;

                    else
                        
                        if formerMember then

                            msg = messageHeader4 .. "?" .. player.name .. "?" .. tostring ( player.rankIndex ) ..  "?" .. tostring ( player.level ) .. "?" .. class .. "?" .. tostring ( player.joinDateHist[1][4] ) .. "?" .. tostring ( oldJoinDateMeta ) .. "?" .. GUID .. "?" .. tostring ( player.bannedInfo[2] ) .. "?" .. banType .. "?";

                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                            GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.DesignatedLeader );

                            tempMessage = messageHeader5 .. "?" .. player.name .. "?" .. reason .. "?" .. playerWhoBanned;

                        else

                            -- Possibly reason is too long, just slim it -- I don't know how this could happen, so this is semi redundant, but just in case.
                            reason = string.sub ( reason , 1 , #reason - ( ( #tempMessage + GRMsyncGlobals.sizeModifier ) - 254 ) );

                            tempMessage = messageHeader2 .. "?" .. player.name .. "?" .. tostring ( player.bannedInfo[2] ) .. "?" .. banType .. "?" .. reason .. "?" .. playerWhoBanned;
                        end

                        if ( #tempMessage + GRMsyncGlobals.sizeModifier ) < 255 then
                            syncMessage = tempMessage;
                            messageReady = true;

                        end
                    end
                else
                    syncMessage = messageHeader3 .. "?" .. banNames[i];
                    messageReady = true;
                end

                -- Send message
                if messageReady then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    syncMessage = "";
                    tempMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;
                    GRMsyncGlobals.SyncCountBan = i + 1;    -- Always + 1 because it will send the message everytime.
                    GRMsyncGlobals.SyncCount = 0; 
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendPDPackets );       -- Add a delay on packet sending.
                    return;
                end
            else
                GRMsync.EndSync();
                return;
            end
        end
        
        -- Close the Data stream
        GRMsyncGlobals.SyncCountBan = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 7 );
        else
            GRMsync.EndSync();
            return;
        end
    end
end

-- Method:          GRMsync.SendCustomNotePackets()
-- What it Does:    Broadcasts to the leader all CUSTOM NOTES set to sync
-- Purpose:         Data sync for custom notes!!!!
GRMsync.SendCustomNotePackets = function()
    if time() - GRMsyncGlobals.SyncCustomDelay >= 0.9 then

        -- Progress tracking
        if not GRMsyncGlobals.SyncTracker.customNotes then
            GRMsyncGlobals.ProgressControl ( "CUSTOMNOTE" );
        end

        GRMsyncGlobals.SyncCustomDelay = time();
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        local syncMessage = GRM_G.PatchDayString .. "?GRM_CUSTSYNC?" .. GRM.S().syncRankCustom;
        local tempMessage = "";
        local messageReady = false;
        local dataShouldBeSent = false;
        local guildData = GRMsyncGlobals.guildData;
        local bigMessagePart2 = "";
        local tempMsg3 = "";
        local hasAtLeastOne = false;
        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
        local customNote;

        for i = GRMsyncGlobals.SyncCountCustom , #exactIndexes[5] do
            messageReady = false;
            dataShouldBeSent = false;
            if GRMsyncGlobals.SyncOK then
                if guildData[exactIndexes[5][i]].customNote[1] and guildData[exactIndexes[5][i]].customNote[2] ~= 0 then
                    dataShouldBeSent = true;
                    hasAtLeastOne = true;
                end

                -- Expand the string more... Fill up the full 255 characters for efficiency.
                if dataShouldBeSent then

                    customNote = guildData[exactIndexes[5][i]].customNote[6];
                    if customNote == "" then
                        customNote = "X&&X";
                    end

                    if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                        tempMessage = syncMessage .. "?" .. guildData[exactIndexes[5][i]].customNote[4] .. "?#" .. guildData[exactIndexes[5][i]].name .. "?#" .. tostring ( guildData[exactIndexes[5][i]].customNote[2] ) .. "?#" .. guildData[exactIndexes[5][i]].customNote[3] .. "?#" .. customNote;
                        if ( #tempMessage + GRMsyncGlobals.sizeModifier < 255 ) then
                            syncMessage = tempMessage;
                            if i == #exactIndexes[5] then
                                messageReady = true;
                            end
                        else
                            messageReady = true;
                            tempMsg3 = GRM_G.PatchDayString .. "?GRM_CUSTSYNC?" .. GRM.S().syncRankCustom .. "?" .. guildData[exactIndexes[5][i]].customNote[4] .. "?#" .. guildData[exactIndexes[5][i]].name .. "?#" .. tostring ( guildData[exactIndexes[5][i]].customNote[2] ) .. "?#" .. guildData[exactIndexes[5][i]].customNote[3];
                            -- Hold this value over...                            
                            if #customNote > 100 and not GRMsyncGlobals.CustomNoteLarge then
                                tempMessage = tempMsg3 .. "?#" .. string.sub ( customNote , 1 , #customNote - 50 ) .. "?^?";
                                GRMsyncGlobals.CustomNoteLarge = true;
                                bigMessagePart2 = string.sub ( customNote , #customNote - 49 ) .. "?^?";
                            else
                                tempMessage = tempMsg3 .. "?#" .. customNote;
                            end
                            -- If we are in the last index it won't loop back around, so we need to send it now...
                            if i == #exactIndexes[5] then
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.DesignatedLeader );
                    
                                -- Send the 2nd part of the string if it needs to be split.
                                if GRMsyncGlobals.CustomNoteLarge then
                                    tempMessage = tempMsg3 .. "?#" .. bigMessagePart2;
                                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                                    GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.DesignatedLeader );
                                    GRMsyncGlobals.CustomNoteLarge = false;
                                end
                                break;
                            end
                        end
                    end

                    -- Send message
                    if ( messageReady and dataShouldBeSent ) or ( hasAtLeastOne and i == #exactIndexes[5]) then
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                        syncMessage = tempMessage;
                        -- In case custom note goes over due to larger server names - message needs to be split.
                        if GRMsyncGlobals.CustomNoteLarge then
                            -- Sending first half of the message.
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                            syncMessage = tempMsg3 .. "?#" .. bigMessagePart2;
                            -- Sending Second half of the message.
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );

                            -- Reset to base values of first loop as not carrying over any data.
                            GRMsyncGlobals.CustomNoteLarge = false;
                            tempMessage = "";
                            syncMessage = GRM_G.PatchDayString .. "?GRM_CUSTSYNC?" .. GRM.S().syncRank;
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
            else
                GRMsync.EndSync();
                return;
            end
        end
        -- Close the Data stream
        GRMsyncGlobals.SyncCountCustom = 1;
        GRMsyncGlobals.syncTempDelay = false;
        if GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessageModifier1 then
            GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
        end
        if GRMsyncGlobals.SyncOK then
            GRMsync.NextSyncStep ( 6 );
        else
            GRMsync.EndSync();
            return;
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
GRMsync.SendBDayPackets = function()
    if time() - GRMsyncGlobals.SyncBdayDelay >= 0.9 then
        -- Progress tracking
        if not GRMsyncGlobals.SyncTracker.bdays then
            GRMsyncGlobals.ProgressControl ( "BDAYS" );
        end

        GRMsyncGlobals.SyncBdayDelay = time();
        GRMsyncGlobals.TimeSinceLastSyncAction = time();

        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end

        local syncMessage = GRM_G.PatchDayString .. "?GRM_BDSYNC?" .. syncRankFilter;
        local tempMessage = "";
        local messageReady;
        local guildData = GRMsyncGlobals.guildData;
        local hasAtLeastOne = false;
        local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
        local timeOfChange = 0;
        local day = 0;
        local month = 0;

        if exactIndexes[6] == nil then
            GRMsync.BuildFullCheckArray();
            exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
        end

        if exactIndexes[6] ~= nil then

            for i = GRMsyncGlobals.SyncCountBday , #exactIndexes[6] do
                messageReady = false;
                if GRMsyncGlobals.SyncOK then

                    if guildData[exactIndexes[6][i]].events[2][4] > 0 then  -- This means a birthdate has either been added or removed
                        hasAtLeastOne = true;

                        -- Expand the string more... Fill up the full 255 characters for efficiency.
                        if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then

                            -- name .. timeOfChange .. day .. month (do not need year for bday
                            tempMessage = syncMessage .. "?" .. guildData[exactIndexes[6][i]].name .. "?" .. guildData[exactIndexes[6][i]].events[2][4] .. "?" .. guildData[exactIndexes[6][i]].events[2][1][1] .. "?" .. guildData[exactIndexes[6][i]].events[2][1][2];

                            if #tempMessage + GRMsyncGlobals.sizeModifier < 255 then
                                syncMessage = tempMessage;
                                if i == #exactIndexes[6] then
                                    messageReady = true;
                                end
                            else
                                messageReady = true;
                                -- Hold this value over...
                                tempMessage = GRM_G.PatchDayString .. "?GRM_BDSYNC?" .. syncRankFilter .. "?" .. guildData[exactIndexes[6][i]].name .. "?" .. guildData[exactIndexes[6][i]].events[2][4] .. "?" .. guildData[exactIndexes[6][i]].events[2][1][1] .. "?" .. guildData[exactIndexes[6][i]].events[2][1][2];

                                -- If we are in the last index it won't loop back around, so we need to send it now...
                                if i == #exactIndexes[6] then
                                    syncMessage = tempMessage;
                                    -- This will be sent
                                end
                            end
                        end
                    end

                    -- Send message
                    if messageReady or ( hasAtLeastOne and i == #exactIndexes[6] ) then
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                        syncMessage = tempMessage;
                    end

                    -- Check if there needs to be a throttled delay
                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.syncTempDelay = true;
                        GRMsyncGlobals.SyncCountBday = i;
                        GRMsyncGlobals.SyncCount = 0; 
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SendBDayPackets );       -- Add a delay on packet sending.
                        return;
                    end
                else
                    GRMsync.EndSync();
                    return;
                end
            end
            
            -- Close the Data stream
            GRMsyncGlobals.SyncCountBday = 1;
            GRMsyncGlobals.syncTempDelay = false;
            if GRMsyncGlobals.SyncOK then
                GRMsync.SendBDAYCompletion();
            else
                GRMsync.EndSync();
                return;
            end
        else
            GRMsyncGlobals.SyncCountBday = 1;
            GRMsyncGlobals.syncTempDelay = false;
            if GRMsyncGlobals.SyncOK then
                GRMsync.SendBDAYCompletion();
            else
                GRMsync.EndSync();
                return;
            end
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

-- Method:          GRMsync.ErrorCheck( boolean , boolean )
-- What it Does:    On the giver ErrorCD interval, determines if sync has failed by time since last sync action has occcurred. 0
-- Purpose:         To exit out the sync attempt and retry in an efficiennt non, time-wasting way.
GRMsync.ErrorCheck = function ( forceStop , sendMessage )
    if not GRM.IsCalendarEventEditOpen() then
        GRM.GuildRoster();
    end

    -- Sync Leader logic
    if GRMsyncGlobals.DesignatedLeader == GRM_G.addonUser then
        
        if forceStop or ( GRMsyncGlobals.currentlySyncing and ( time() - GRMsyncGlobals.TimeSinceLastSyncAction ) >= GRMsyncGlobals.ErrorCD ) then
            -- Check if player is offline...
            local playerIsOnline = GRM.IsGuildieOnline ( GRMsyncGlobals.CurrentSyncPlayer );
            local msg = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer , true ) );
            GRMsyncGlobals.syncFailed = true

            GRMsyncGlobals.offline = false;
            GRMsyncGlobals.firstSync = true;
            GRMsyncGlobals.TimeSinceLastSyncAction = time();

            -- We already tried to sync, now aboard to 2nd.
            if playerIsOnline then

                table.remove ( GRMsyncGlobals.SyncQue , 1 );
                GRMsyncGlobals.currentlySyncing = false;
                GRMsyncGlobals.errorCheckEnabled = false;
                GRMsyncGlobals.firstSync = true 
                -- Sync failed, this is 2nd attempt, AND, another person is in que.
                
                if GRM_G.DebugEnabled then
                    GRM.Report ( GRM.L ( "Sync failed at this point:" .. " " .. GRMsync.SyncProgressPoint() ) );
                end
                
                if #GRMsyncGlobals.SyncQue > 0 then
                    GRM.RegisterGuildAddonUsersRefresh();
                    C_Timer.After ( 4.1 , function()
                        if GRM.S().syncChatEnabled then
                            if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() then
                                GRM.Report ( msg .. "\n" .. GRM.L ( "Initiating Sync with {name} Instead!" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
                            end
                        end
                        GRMsync.InitiateDataSync();
                    end);
                -- Sync failed, this is 2nd attempt, but no one else is in the que. Just end it.
                else
                    if GRM.S().syncChatEnabled then
                        GRM.Report ( msg );
                    end
                    
                    GRMsyncGlobals.currentlySyncing = false;
                    GRMsyncGlobals.ProgressControl ( "FINISH");
                end  

            else

                table.remove ( GRMsyncGlobals.SyncQue , 1 );

                GRMsyncGlobals.currentlySyncing = false;
                GRMsyncGlobals.errorCheckEnabled = false;

                GRM.RegisterGuildAddonUsersRefresh();
                C_Timer.After ( 4.1 , function()
                    if #GRMsyncGlobals.SyncQue > 0 then
                        if GRM.S().syncChatEnabled then
                            GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) .. "\n" .. GRM.L ( "Initiating Sync with {name} Instead!" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
                        end

                        GRMsync.SendQueUpdate();
                        
                        GRMsyncGlobals.currentlySyncing = false;
                        C_Timer.After ( 3 , function()
                            GRMsync.InitiateDataSync();
                        end);
                    else
                        if GRM.S().syncChatEnabled then
                            GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) );
                        end
                        GRMsyncGlobals.currentlySyncing = false;
                        GRMsyncGlobals.syncFailed = true;
                        GRMsyncGlobals.ProgressControl ( "FINISH");
                    end
                end);

            end

            if sendMessage then
                GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_ENDSYNC?" , GRMsyncGlobals.CurrentSyncPlayer );
            end

        elseif GRMsyncGlobals.currentlySyncing and #GRMsyncGlobals.SyncQue > 0 and not GRMsyncGlobals.ErrorCheckControl then

            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );

        elseif GRMsyncGlobals.ErrorCheckControl then

            GRMsyncGlobals.ErrorCheckControl = false;

        end

    elseif forceStop or not GRMsyncGlobals.dateSentComplete then
        
        if forceStop or ( GRMsyncGlobals.currentlySyncing and ( time() - GRMsyncGlobals.TimeSinceLastSyncAction ) >= GRMsyncGlobals.ErrorCD ) then

            local playerIsOnline = GRM.IsGuildieOnline ( GRMsyncGlobals.DesignatedLeader );

            GRMsyncGlobals.offline = false;
            GRMsyncGlobals.firstSync = true;
            GRMsyncGlobals.currentlySyncing = false;
            GRMsyncGlobals.TimeSinceLastSyncAction = time();

            local msg = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader , true ) );

            GRMsyncGlobals.syncFailed = true
            GRMsyncGlobals.ProgressControl ( "FINISH"); 

            if not playerIsOnline then
                if GRM.S().syncChatEnabled then
                    GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) );
                end
            else
                GRM.Report ( msg );

                if GRM_G.DebugEnabled then
                    GRM.Report ( GRM.L ( "Sync failed at this point:" .. " " .. GRMsync.SyncProgressPoint() ) );
                end

            end

            if sendMessage then
                GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_ENDSYNC?" , GRMsyncGlobals.DesignatedLeader );
            end

        elseif GRMsyncGlobals.currentlySyncing and not GRMsyncGlobals.ErrorCheckControl then

            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck ); 

        elseif GRMsyncGlobals.ErrorCheckControl then
            GRMsyncGlobals.ErrorCheckControl = true; 
        end
    else
        -- This condition can occur if the data has been sent, and then the receiving player/leader compiling it and syncing
        -- with other guildies goes offline, you will indefinitely   be waiting, and it will say you are indefinitely syncing.
        -- This offers an escape
        local tempTime = ( time() - GRMsyncGlobals.TimeSinceLastSyncAction );
        if tempTime >= GRMsyncGlobals.ErrorCD and tempTime > GRMsyncGlobals.ErrorCD * 2 then
            local playerIsOnline = GRM.IsGuildieOnline ( GRMsyncGlobals.DesignatedLeader );
            if not playerIsOnline then
                if GRM.S().syncChatEnabled then
                    GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader ) ) .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) );
                end

                GRMsyncGlobals.currentlySyncing = false;
                GRMsyncGlobals.syncFailed = true;
                GRMsyncGlobals.ProgressControl ( "FINISH");
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

-- Method:          GRMsync.SendQueUpdate()
-- What it Does:    Sends an update on to each person sync'd with but is an queue
-- Purpose:         For people to keep tabs on syncing progress
GRMsync.SendQueUpdate = function()

    if #GRMsyncGlobals.SyncQue > 1 then
        local msg = "";
        for i = 2 , #GRMsyncGlobals.SyncQue do
            msg = GRM_G.PatchDayString .. "?GRM_BUSY?" .. GRM.S().syncRank .. "?" .. tostring ( i - 1 );

            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
            GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.SyncQue[i] );
        end
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
        if GRM_G.currentAddonUsers[i][9] then
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
    local val = ( numIncomplete / GRM.GetNumGuildies() ) * 100;
    if val < 1 and val > 0 then
        val = 1;
    end
    local percentComplete = 100 - ( math.floor ( val ) );
    
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
-- What it Does:    Begins the sync process going through the sync que
-- Purpose:         To Sync data!
GRMsync.InitiateDataSync = function ()
    if not GRM.IsCalendarEventEditOpen() then
        GRM.GuildRoster();
    end
    GRMsyncGlobals.LeadSyncProcessing = false;

    GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;
    if not GRMsyncGlobals.currentlySyncing then
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
                    GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData , GRMsyncGlobals.guildAltData = GRM.convertToArrayFormat(); -- Now, we set arrays of the data.
                    
                    GRMsyncGlobals.TimeSinceLastSyncAction = time();

                    if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or GRM.S().exportAllRanks then

                        GRMsyncGlobals.SyncTracker.TriggeringSync = true;
                        GRMsyncGlobals.SyncTracker.EstablishingLeader = true;
                        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Currently Syncing With: {name}" , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer ) ) );

                        if GRM.S().syncChatEnabled and GRMsyncGlobals.firstSync then
                            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Syncing Data With Guildies Now..." ) .. "\n" .. GRM.L ( "(Loading screens may cause sync to fail)" ) );
                        end
                    end

                    GRMsyncGlobals.firstSync = false;
                    GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_REQJDDATA?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1] , GRMsyncGlobals.CurrentSyncPlayer );

                    -- Build Hash Comparison string
                    -- Initializing 
                    GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 10 , 5 );
                    GRMsync.SendNonLeaderDatabaseMarkers();

                else
                    GRMsync.EndSync();
                    return;
                end
                
            else

                GRMsyncGlobals.currentlySyncing = false;
                GRMsyncGlobals.errorCheckEnabled = false;
                GRMsyncGlobals.guildData = {};          -- Clearing the sync DB backup as it is a lot of info to just have sitting in memory
                GRMsyncGlobals.formerGuildData = {};
                GRMsyncGlobals.guildAltData = {};

                if #GRMsyncGlobals.SyncQue > 1 then

                    table.remove ( GRMsyncGlobals.SyncQue , 1 );
                    if GRM.S().syncChatEnabled then
                        GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) .. "\n" .. GRM.L ( "Initiating Sync with {name} Instead!" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
                    end
                    GRMsync.SendQueUpdate();
        
                    GRMsyncGlobals.currentlySyncing = false;
                    C_Timer.After ( 3 , function()
                        GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Currently Syncing With: {name}" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
                        GRMsync.InitiateDataSync();
                    end);
                else

                    table.remove ( GRMsyncGlobals.SyncQue , 1 );
                    GRMsyncGlobals.firstSync = true;
                    GRM_G.slashCommandSyncTimer = time();
                    GRMsyncGlobals.timeOfLastSyncCompletion = time();

                    if GRM.S().syncChatEnabled then
                        if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or GRM.S().exportAllRanks then
                            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync With Guildies Complete..." ) );
                            GRMsync.ReportAuditMessage();
                        end
                        
                    end

                    -- Progress tracking
                    if not GRMsyncGlobals.SyncTracker.finish then
                        GRMsyncGlobals.ProgressControl ( "FINISH" );
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
                    if GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame:IsVisible() then
                        GRM.RefreshBanListFrames();
                    end
                end
            end
        end
    end
end

-- Method:          GRMsync.SubmitFinalSyncData()
-- What it Does:    Sends out the mandatory updates to all online (they won't if the change is already there)
-- Purpose:         So leader can send out current, updated sync info.
GRMsync.SubmitFinalSyncData = function ()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local msg = "";
    local tempMsg1 = ""; 

    -- Ok send of the Join Date updates!
    if not GRMsyncGlobals.finalSyncProgress[1] and #GRMsyncGlobals.JDChanges > 0 then

        if not GRMsyncGlobals.SyncTracker.finalJD then
            GRMsyncGlobals.ProgressControl ( "FINALJD" );
        end

        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.JDChanges do
            
            -- Send a change to everyone!
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then

                msg = GRMsyncGlobals.JDChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][2] ) .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][3] ) .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][4] ) .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][5] ) .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][6] ) .. "?0";

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_JDSYNCUP?" .. GRMsyncGlobals.JDChanges[i][7] .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][8] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg  , GRMsyncGlobals.CurrentSyncPlayer );
                -- Do my own changes too if the rank is appropriate...
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckJoinDateChange ( msg , "" , "GRM_JDSYNCUP" );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            else
                GRMsync.EndSync();
                return;
            end
            GRM.AuditRefreshTracker();
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        GRMsyncGlobals.finalSyncProgress[1] = true;
    end

    if not GRMsyncGlobals.SyncOK then
        GRMsync.EndSync();
        return;
    end

    if GRMsyncGlobals.TrackerData.JD[1] then
        GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.JD[1] , GRMsyncGlobals.TrackerData.JD[3] );
    end

    -- Promo date sync!
    if not GRMsyncGlobals.finalSyncProgress[2] and #GRMsyncGlobals.PDChanges > 0 then

        if not GRMsyncGlobals.SyncTracker.finalPD then
            GRMsyncGlobals.ProgressControl ( "FINALPD" );
            -- GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , GRMsyncGlobals.totalEstTime );
        end

        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.PDChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then

                msg = GRMsyncGlobals.PDChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][2] ) .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][3] ) .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][4] ) .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][5] ) .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][6] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_PDSYNCUP?" .. GRMsyncGlobals.PDChanges[i][7] .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][8] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.CurrentSyncPlayer ); 
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckPromotionDateChange ( msg , "" , "GRM_PDSYNCUP" );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            else
                GRMsync.EndSync();
                return;
            end
            GRM.AuditRefreshTracker();
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        GRMsyncGlobals.finalSyncProgress[2] = true;
    end

    if not GRMsyncGlobals.SyncOK then
        GRMsync.EndSync();
        return;
    end

    if GRMsyncGlobals.TrackerData.PD[1] then
        GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.PD[1] , GRMsyncGlobals.TrackerData.PD[3] );
    end


    -- ALT changes sync for adding alts!
    if not GRMsyncGlobals.finalSyncProgress[3] and GRM.TableLength ( GRMsyncGlobals.FinalCorrectAltList ) > 0 then

        local syncName = ""
        local syncRank = 0;
        local altGroupModified = 0;
        local finalList = GRMsync.ConvertToNamesList ( GRMsyncGlobals.FinalCorrectAltList );
        local toon = {};

        if not GRMsyncGlobals.SyncTracker.finalAlts then
            GRMsyncGlobals.ProgressControl ( "FINALALT" );
        end

        for i = GRMsyncGlobals.SyncCountAdd1 , #finalList do

            syncName = "";
            syncRank = 0;
            toon = GRMsyncGlobals.FinalCorrectAltList[finalList[i]]

            if toon.finished == nil then

                if GRMsyncGlobals.SyncOK then

                    syncName = toon.syncControl[1];
                    syncRank = toon.syncControl[2];
                    altGroupModified = toon.altGroupModified;

                    -- Sync controls
                    tempMsg1 = GRM_G.PatchDayString .. "?GRM_ALTSYNCUP?" .. syncName .. "?" .. tostring ( syncRank ) .. "?";

                    if #toon > 0 then

                        for j = GRMsyncGlobals.SyncCountAdd2 , #toon do

                            if GRMsyncGlobals.SyncOK then

                                msg = tempMsg1 .. finalList[i] .. "?" .. toon[j] .. "?" .. tostring ( altGroupModified );

                                GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );

                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                                -- Do my own changes too!
                                
                                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                                    GRMsyncGlobals.SyncCount = 0;
                                    GRMsyncGlobals.SyncCountAdd2 = j + 1;
                                    GRMsyncGlobals.SyncCountAdd1 = i;
                                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                                    return;
                                end

                            else
                                GRMsync.EndSync();
                                return;
                            end

                        end

                    else
                        -- NO ALTS - just send notice to remove
                        msg = finalList[i] .. "?###?" .. tostring ( altGroupModified );

                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.CurrentSyncPlayer );
                        -- Do my own changes too!
                        
                        if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                            GRMsyncGlobals.SyncCount = 0;
                            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                            return;
                        end

                    end
                else
                    GRMsync.EndSync();
                    return;
                end
            end

            GRMsyncGlobals.SyncCountAdd2 = 1;
            toon.finished = true;
        end

        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
            syncRankFilter = GuildControlGetNumRanks() - 1;
        end

        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_FINALALTSYNCUP?" .. tostring ( GRM.TableLength ( GRMsyncGlobals.FinalCorrectAltList ) ) .. "?" .. GRMsyncGlobals.DesignatedLeader .. "?" .. tostring ( syncRankFilter ) .. "?" , GRMsyncGlobals.CurrentSyncPlayer );

        if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
            GRMsync.CheckAddAltSyncChange ( GRMsyncGlobals.FinalCorrectAltList , GRM.TableLength ( GRMsyncGlobals.FinalCorrectAltList ) );
        end

        if GRM.IsAnyCustomNoteLarge() then
            if  GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessage then
                GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessageModifier1;
            end
        end

        GRMsyncGlobals.SyncCountAdd1 = 1;
        GRMsyncGlobals.SyncCountAdd2 = 1;
        GRMsyncGlobals.finalSyncProgress[3] = true;
        
    end

    if not GRMsyncGlobals.SyncOK then
        GRMsync.EndSync();
        return;
    end

    if GRMsyncGlobals.TrackerData.ALT[1] then
        GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.ALT[1] , GRMsyncGlobals.TrackerData.ALT[3] );
    end

    -- CUSTOM NOTE CHECK!
    if not GRMsyncGlobals.finalSyncProgress[4] and #GRMsyncGlobals.CustomNoteChanges > 0 then

        if not GRMsyncGlobals.SyncTracker.finalCustom then
            GRMsyncGlobals.ProgressControl ( "FINALCUSTOM" );
        end

        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.CustomNoteChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then
                msg = GRMsyncGlobals.CustomNoteChanges[i][4] .. "~X~" .. GRMsyncGlobals.CustomNoteChanges[i][1] .. "~X~" .. tostring ( GRMsyncGlobals.CustomNoteChanges[i][2] ) .. "~X~" .. GRMsyncGlobals.CustomNoteChanges[i][3] .. "~X~" .. GRMsyncGlobals.CustomNoteChanges[i][5];

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_CUSTSYNCUP?" .. GRMsyncGlobals.CustomNoteChanges[i][6] .. "?" .. tostring ( GRMsyncGlobals.CustomNoteChanges[i][7] ) .. "?";

                -- Split the message!!!
                if ( #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier ) > 254 then
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + ( #tempMsg1 * 2 ) + ( #msg - 50 ) + ( #GRMsyncGlobals.CustomNoteChanges[i][5] - 49 ) + ( GRMsyncGlobals.sizeModifier * 2 );
                    -- First, sending last half of message
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. string.sub ( GRMsyncGlobals.CustomNoteChanges[i][5] , #GRMsyncGlobals.CustomNoteChanges[i][5] - 49 ) .. "&X&" , GRMsyncGlobals.CurrentSyncPlayer );
                    -- Second, sending full details and first portion of message.
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. string.sub ( msg , 1 , #msg - 50 ) .. "&X&" , GRMsyncGlobals.CurrentSyncPlayer );
                else
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.CurrentSyncPlayer );
                end
                
                
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankCustom and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckCustomNoteSyncChange ( msg , false );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                    return;
                end
            else
                GRMsync.EndSync();
                return;
            end
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
        if GRMsyncGlobals.ThrottleCap == GRMsyncGlobals.normalMessageModifier1 then
            GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
        end
        GRMsyncGlobals.finalSyncProgress[4] = true;
    end

    if not GRMsyncGlobals.SyncOK then
        GRMsync.EndSync();
        return;
    end

    if GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] then
        GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] );
    end

    -- BAN changes sync!
    if not GRMsyncGlobals.finalSyncProgress[5] and #GRMsyncGlobals.BanChanges > 0 then
        local playerWhoBanned , reason = "" , "";
        local result = {};
        local header = "";
        local prefix = "";

        if not GRMsyncGlobals.SyncTracker.finalBan then
            GRMsyncGlobals.ProgressControl ( "FINALBAN" );
        end

        if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then

            for i = GRMsyncGlobals.finalSyncDataBanCount , #GRMsyncGlobals.BanChanges do
                GRMsyncGlobals.finalSyncDataBanCount = GRMsyncGlobals.finalSyncDataBanCount + 1;
                msg = "";

                if GRMsyncGlobals.SyncOK then

                    if not GRMsyncGlobals.BanChanges[i][9] then
                        -- Leader needs to update the received data, but no reason to send back.
                        GRMsync.BanManagement ( GRMsyncGlobals.BanChanges[i] , "GRM_BANSYNCUP" , GRMsyncGlobals.CurrentSyncPlayer );
                    else
                        -- Leader needs to send the player their ban data.
                        -- Build initial ban info string.

                        reason = GRMsyncGlobals.BanChanges[i][4]
                        if reason == "" then
                            reason = "x";
                        else
                            reason = string.gsub ( reason , "?" , "##" );
                        end

                        playerWhoBanned = GRMsyncGlobals.BanChanges[i][7];
                        if playerWhoBanned == "" then
                            playerWhoBanned = "X";
                        end

                        if #GRMsyncGlobals.BanChanges[i][8] > 0 then
                            prefix = "?GRM_BANSYNCUPX?";
                            msg = GRMsyncGlobals.BanChanges[i][1] .. "?" .. GRMsyncGlobals.BanChanges[i][8][1] .. "?" .. GRMsyncGlobals.BanChanges[i][8][2] ..  "?" .. GRMsyncGlobals.BanChanges[i][8][3] .. "?" .. GRMsyncGlobals.BanChanges[i][8][4] .. "?" .. GRMsyncGlobals.BanChanges[i][8][5] .. "?" .. GRMsyncGlobals.BanChanges[i][8][6] .. "?" .. GRMsyncGlobals.BanChanges[i][8][7] .. "?" .. tostring ( GRMsyncGlobals.BanChanges[i][2] ) .. "?" .. GRMsyncGlobals.BanChanges[i][3] .. "?" .. reason .. "?" .. playerWhoBanned;

                        else
                            prefix = "?GRM_BANSYNCUP?";

                            msg = GRMsyncGlobals.BanChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.BanChanges[i][2] ) .. "?" .. GRMsyncGlobals.BanChanges[i][3] .. "?" .. reason .. "?" .. playerWhoBanned;

                        end

                        header = GRM_G.PatchDayString .. prefix .. GRMsyncGlobals.BanChanges[i][5] .. "?" .. tostring ( GRMsyncGlobals.BanChanges[i][6] ) .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?";
                        msg = header .. msg;

                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );

                        if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                            GRMsyncGlobals.SyncCount = 0;
                            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalSyncData );
                            return;
                        end
                    end

                else
                    GRMsync.EndSync();
                    return;
                end
            end
        end
        GRMsyncGlobals.finalSyncDataBanCount = 1;
        GRMsyncGlobals.finalSyncProgress[5] = true;
    end

    -- Mains or BDAYs
    if GRMsyncGlobals.DatabaseExactIndexes[4] == nil or GRMsyncGlobals.DatabaseExactIndexes[6] == nil then
        GRMsync.BuildFullCheckArray();
    end

    if #GRMsyncGlobals.DatabaseExactIndexes[4] == 0 and #GRMsyncGlobals.DatabaseExactIndexes[6] == 0 then -- 4 = Main , 6 = Bday 
        -- no bday or main data
        GRMsync.FinalSyncComplete();
    else
        -- Need to request bday Data
        local syncRankFilter = GRM.S().syncRank;
        if GRM.S().exportAllRanks then
            syncRankFilter = GRMsyncGlobals.numGuildRanks;
        end
        GRMsync.SendMessage ( "GRM_SYNC" , GRM_G.PatchDayString .. "?GRM_REQBFINALDATA?" .. tostring ( GRMsyncGlobals.numGuildRanks ) .. "?" , GRMsyncGlobals.CurrentSyncPlayer );
    end

end

-- Method:          GRMsync.SubmitFinalMainData()
-- What it Does:    Sends the final details on the correct current mains
-- Purpose:         Ensure main/alts are all accurate
GRMsync.SubmitFinalMainData = function()
    -- MAIN STATUS CHECK!
    local msg = "";
    local tempMsg1 = "";
    if not GRMsyncGlobals.SyncTracker.finalMain then
        GRMsyncGlobals.ProgressControl ( "FINALMAIN" );
    end

    if #GRMsyncGlobals.AltMainChanges > 0 then


        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.AltMainChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;
            if GRMsyncGlobals.SyncOK then

                msg = GRMsyncGlobals.AltMainChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.AltMainChanges[i][2] ) .. "?" .. tostring ( GRMsyncGlobals.AltMainChanges[i][3] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_MAINSYNCUP?" .. GRMsyncGlobals.AltMainChanges[i][4] .. "?" .. tostring ( GRMsyncGlobals.AltMainChanges[i][5] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.CurrentSyncPlayer );
                -- Do my own changes too!
                if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) and GRMsyncGlobals.AltMainChanges[i][6] then
                    GRMsync.CheckMainSyncChange ( { GRMsyncGlobals.AltMainChanges[i][1] , GRMsyncGlobals.AltMainChanges[i][2] , GRMsyncGlobals.AltMainChanges[i][3] } );
                end
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalMainData );
                    return;
                end
            else
                GRMsync.EndSync();
                return;
            end
            GRM.AuditRefreshTracker();
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
    end

    GRMsyncGlobals.finalSyncProgress[6] = true;

    if GRMsyncGlobals.TrackerData.MAIN[1] then
        GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.MAIN[1] , GRMsyncGlobals.TrackerData.MAIN[3] );
    end

    GRMsync.SubmitFinalBdayData();
end

-- Method:          GRMsync.SubmitFinalBdayData()
-- What it Does:    Sends out all of the current birthday info as determined by sync process
-- Purpose:         Sync birthdate info
GRMsync.SubmitFinalBdayData = function()
    -- BIRTHDAY CHECK!
    local msg = "";
    local tempMsg1 = "";

    if not GRMsyncGlobals.SyncTracker.finalBdays then
        GRMsyncGlobals.ProgressControl ( "FINALBDAYS" );
    end

    if not GRMsyncGlobals.finalSyncProgress[7] and #GRMsyncGlobals.BDayChanges > 0 then
        for i = GRMsyncGlobals.finalSyncDataCount , #GRMsyncGlobals.BDayChanges do
            GRMsyncGlobals.finalSyncDataCount = GRMsyncGlobals.finalSyncDataCount + 1;

            if GRMsyncGlobals.SyncOK then
                -- name ? timestamp ? month ? day
                msg = GRMsyncGlobals.BDayChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][2] ) .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][3] ) .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][4] );

                tempMsg1 = GRM_G.PatchDayString .. "?GRM_BDSYNCUP?" .. GRMsyncGlobals.BDayChanges[i][5] .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][6] ) .. "?";

                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg1 + #msg + GRMsyncGlobals.sizeModifier;

                GRMsync.SendMessage ( "GRM_SYNC" , tempMsg1 .. msg , GRMsyncGlobals.CurrentSyncPlayer )

                -- Do my own changes too!
                if GRM.S().syncBDays and ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRMsyncGlobals.CurrentSyncPlayerRankRequirement >= GRMsyncGlobals.CurrentLeaderRankID ) then
                    GRMsync.CheckBirthdayForSync ( { GRMsyncGlobals.BDayChanges[i][1] , GRMsyncGlobals.BDayChanges[i][2] , GRMsyncGlobals.BDayChanges[i][3] , GRMsyncGlobals.BDayChanges[i][4] } );
                end

                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , GRMsync.SubmitFinalBdayData );
                    return;
                end
            else
                GRMsync.EndSync();
                return;

            end
            GRM.AuditRefreshTracker();
        end
        GRMsyncGlobals.finalSyncDataCount = 1;
    end

    if GRMsyncGlobals.TrackerData.BDAY[1] then
        GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.BDAY[1] , GRMsyncGlobals.TrackerData.BDAY[3] );
    end

    GRMsyncGlobals.finalSyncProgress[7] = true;
    GRMsync.FinalSyncComplete();
end

-- Method:          GRMsync.FinalSyncComplete()
-- What it Does:    Completes the sync and moves on to the next player requesting sync who maybe just logged on
-- Purpose:         Control sync properly.
GRMsync.FinalSyncComplete = function()
    -- Ok all done! Reset the tables!
    GRMsync.ResetReportTables();
    GRMsyncGlobals.finalSyncDataCount = 1;
    GRMsyncGlobals.finalSyncDataBanCount = 1;
    GRMsyncGlobals.finalSyncProgress = { false , false , false , false , false , false , false };
    -- Do a quick check if anyone else added themselves to the que in the last millisecond, and if so, REPEAT!
    -- Setup repeat here.
    -----------------------------------
    local nameOfCurrentSyncSender = GRMsyncGlobals.SyncQue[1];

    -- This will be reset if sync is being retriggered.
    if nameOfCurrentSyncSender ~= nil then
        local tempMsg = GRM_G.PatchDayString .. "?GRM_COMPLETE?" .. GRMsyncGlobals.numGuildRanks .. "?" .. nameOfCurrentSyncSender;
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg + GRMsyncGlobals.sizeModifier;
        GRMsync.SendMessage ( "GRM_SYNC" , tempMsg , GRMsyncGlobals.CurrentSyncPlayer );

        -- We made it... remove from the syncQue
        if #GRMsyncGlobals.SyncQue > 1 then
            table.remove ( GRMsyncGlobals.SyncQue , 1 );

            if GRM.S().syncChatEnabled then
                GRM.Report ( GRM.L ( "Sync with {name} complete." , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer ) ) );
                GRM.Report ( GRM.L ( "Sync with {name} next." , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
            end

            if GRM_UI.GRM_SyncTrackerWindow:IsVisible() then
                GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Sync with {name} Successful" , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer ) ) );
                GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , 0.5 , { 0.42 , 0.92 , 1 } );
            end

            GRMsync.SendQueUpdate();
        
            GRMsyncGlobals.currentlySyncing = false;
            C_Timer.After ( 3 , function()
                GRMsync.InitiateDataSync();
            end);
        else
            table.remove ( GRMsyncGlobals.SyncQue , 1 );
            -- Disable sync again if necessary!
            GRMsync.ReportSyncCompletion ( nameOfCurrentSyncSender , true );
            GRMsyncGlobals.firstSync = true;
        end
    end
end

-- need to send GUID data as well
-- Method:          GRMsync.UpdateLeftPlayerInfo ( table )
-- What it Does:    If a player needs to ban or unban a player, it cannot do so if they are not on their list, as maybe it was a person that left the guild before they had addon installed or before they joined> this fixes the gap
-- Purpose:         To maintain a ban list properly, even for those who installed the addon later, or joined the guild later. The "Left Players" would not have them stored. This syncs that, but ONLY as needed, not all left players
--                  as this prevents left player storage bloat unnecessarily and only syncs the banned or unbanned ones.
GRMsync.UpdateLeftPlayerInfo = function ( playerData )
    local playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID;

    if type ( playerData ) == "table" then

        playerName = playerData[1];
        rankName = playerData[2];
        rankIndex = playerData[3];
        level = playerData[4];
        classIndex = playerData[5];
        joinDateEpoch = playerData[6];
        originalJoinEpoch = playerData[7];
        GUID = playerData[8];

    else
        
        GRM_G.MatchPattern6 = GRM_G.MatchPattern6 or GRM.BuildComPattern ( 6 , "?" , false );
        playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID = GRM.ParseComMsg ( playerData , GRM_G.MatchPattern6 );

        rankIndex = tonumber ( rankIndex );
        level = tonumber ( level );
        classIndex = tonumber ( classIndex );
        joinDateEpoch = tonumber ( joinDateEpoch );
        originalJoinEpoch = tonumber ( originalJoinEpoch );

        if GUID == "X" then
            GUID = "";
        end
        
    end
    -- Ok, let's check if this player is already known...
    local player = GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][GRM_G.guildName][ playerName ];

    if not player then

        if GUID == "X" then
            GUID = "";
        end

        local class = "";
        
        if classIndex == 0 then
            if C_PlayerInfo.GUIDIsPlayer ( GUID ) then
                class = GRM.GetPlayerClassByGUID ( GUID );
                if not class then
                    class = "";
                end
            else
                classIndex = 3;
            end
        end
        
        if class == "" then
            class = C_CreatureInfo.GetClassInfo ( classIndex ).classFile;
        end

        -- let's build the MemberInfo Table!!
        -- After class, all info is generic filler info.
        local memberInfoToAdd = {};

        memberInfoToAdd.name = playerName;

        if rankIndex == 99 then
            memberInfoToAdd.rankName = "";
            memberInfoToAdd.rankIndex = 99;
        else
            memberInfoToAdd.rankName = rankName;
            memberInfoToAdd.rankIndex = rankIndex;
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
        memberInfoToAdd.GUID = GUID;                                            -- 15
        memberInfoToAdd.race = "";                                              -- 16
        memberInfoToAdd.sex = 1;                                                -- 17
        memberInfoToAdd.rosterSelection = 0;                                    -- 18
        
        local _ , timeArray = GRM.EpochToDateFormat ( joinDateEpoch );
        GRM.AddMemberToLeftPlayers ( memberInfoToAdd , timeArray , joinDateEpoch , originalJoinEpoch , nil );

        -- Need to be added to the temp tables to during sync.  
        if GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][GRM_G.guildName][ playerName ] then
            table.insert ( GRMsyncGlobals.formerGuildData , GRM_PlayersThatLeftHistory_Save[ GRM_G.F ][GRM_G.guildName][ playerName ] );
            sort ( GRMsyncGlobals.formerGuildData , function ( a , b ) return a.name < b.name end );
        end
    end
end

-- Method:          GRMsync.CollectData ( string , string )
-- What it Does:    Collects all of the sync data before analysis.
-- Purpose:         Need to aggregate the data so one only needs to parse through the tables once, rather than on each new piece of info added. Far more efficient.
GRMsync.CollectData = function ( msg , prefix )
    local name = "";
    local timeStampOfChange = 0;
    local addLeftPlayerSubstring = "";
    local day , month , year , dateInEpoch = 0 , 0 , 0 , 0;
    local date = {};

    -- JOIN DATE
    if prefix == "GRM_JDSYNC" then

        if not GRMsyncGlobals.SyncTracker.jd then
            GRMsyncGlobals.ProgressControl ( "JD" );
        end

        while string.find ( msg , "?" ) ~= nil do
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = GRM.Next ( msg );
            dateInEpoch = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = GRM.Next ( msg );

            if string.find ( msg , "?" ) ~= nil then
                timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                msg = GRM.Next ( msg );
            else
                timeStampOfChange = tonumber ( msg );
            end
            date = select ( 2 , GRM.EpochToDateFormat ( dateInEpoch ) ); -- Convert Epoch stamp to actual date
            

            table.insert ( GRMsyncGlobals.JDReceivedTemp , { name , timeStampOfChange , date[1] , date[2] , date[3] , dateInEpoch , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement } );
        end
    
    -- PROMO DATE
    elseif prefix == "GRM_PDSYNC" then

        if not GRMsyncGlobals.SyncTracker.pd then
            GRMsyncGlobals.ProgressControl ( "PD" );
        end

        while string.find ( msg , "?" ) ~= nil do
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = GRM.Next ( msg );
            dateInEpoch = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = GRM.Next ( msg );

            if string.find ( msg , "?" ) ~= nil then
                timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                msg = GRM.Next ( msg );
            else
                timeStampOfChange = tonumber ( msg );
            end
            date = select ( 2 , GRM.EpochToDateFormat ( dateInEpoch ) ); -- Convert Epoch stamp to actual date

            table.insert ( GRMsyncGlobals.PDReceivedTemp , { name , date[1] , date[2] , date[3] , dateInEpoch , timeStampOfChange , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement} );
        end
    
    -- BAN/UNBAN scan of LEFT players
    elseif prefix == "GRM_BANSYNC" or prefix == "GRM_BANSYNCSP" then
        if not GRMsyncGlobals.SyncTracker.banData then
            GRMsyncGlobals.ProgressControl ( "BAN" );
        end

        if prefix == "GRM_BANSYNC" then
            GRM_G.MatchPattern12 = GRM_G.MatchPattern12 or GRM.BuildComPattern ( 12 , "?" , false );

            local playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID , banTimeEpoch , banType , reason , playerWhoBanned = GRM.ParseComMsg ( msg , GRM_G.MatchPattern12 );

            if reason == "X" then
                reason = "";
            else
                reason = string.gsub ( reason , "##" , "?" );   -- Returning the punctuation as this is user-input.
            end
    
            if playerWhoBanned == "X" then
                playerWhoBanned = "";
            end

        else
            GRM_G.MatchPattern10 = GRM_G.MatchPattern10 or GRM.BuildComPattern ( 10 , "?" , false );

            local playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID , banTimeEpoch , banType = GRM.ParseComMsg ( msg , GRM_G.MatchPattern10 );
        end

        rankIndex = tonumber ( rankIndex );
        level = tonumber ( level );
        classIndex = tonumber ( classIndex );
        joinDateEpoch = tonumber ( joinDateEpoch );
        originalJoinEpoch = tonumber ( originalJoinEpoch );
        banTimeEpoch = tonumber ( banTimeEpoch );
        

        if GUID == "X" then
            GUID = "";
        else
            GUID = "Player-" .. GUID;
        end

        if rankIndex == 99 or rankName == "###" then
            rankName = "";
            rankIndex = 99
        end

        if prefix == "GRM_BANSYNC" then
            table.insert ( GRMsyncGlobals.BanReceivedTemp , { playerName , banTimeEpoch , banType , reason , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement , playerWhoBanned  , true } );

        else
            table.insert ( GRMsyncGlobals.BanReceivedTemp , { playerName , banTimeEpoch , banType , "" , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement , ""  , true } );
        end

        GRMsync.UpdateLeftPlayerInfo ( { playerName , rankName , rankIndex , level , classIndex , joinDateEpoch , originalJoinEpoch , GUID } );

    elseif prefix == "GRM_BANSYNCSPX" then
        if not GRMsyncGlobals.SyncTracker.banData then
            GRMsyncGlobals.ProgressControl ( "BAN" );
        end

        GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );

        local playerName , reason , playerWhoBanned = GRM.ParseComMsg ( msg , GRM_G.MatchPattern3 );

        if reason == "X" then
            reason = "";
        else
            reason = string.gsub ( reason , "##" , "?" );   -- Returning the punctuation as this is user-input.
        end

        if playerWhoBanned == "X" then
            playerWhoBanned = "";
        end

        -- Need to find the placement
        for i = 1 , #GRMsyncGlobals.BanReceivedTemp do
            if GRMsyncGlobals.BanReceivedTemp[i][1] == playerName then
                GRMsyncGlobals.BanReceivedTemp[i][4] = reason;
                GRMsyncGlobals.BanReceivedTemp[i][7]= playerWhoBanned;
                break;
            end
        end

        -- Note, the reason for 2 separate bans, is if this is a FORMER member, then additional metadata needs to be sync'd as the player may not have them in their former member DB. This is of the CURRENT MEMBERS>
    elseif prefix == "GRM_BANSYNCX" then
        if not GRMsyncGlobals.SyncTracker.banData then
            GRMsyncGlobals.ProgressControl ( "BAN" );
        end

        GRM_G.MatchPattern5 = GRM_G.MatchPattern5 or GRM.BuildComPattern ( 5 , "?" , false );

        local playerName , banTimeEpoch , banType , reason , playerWhoBanned = GRM.ParseComMsg ( msg , GRM_G.MatchPattern5 );

        banTimeEpoch = tonumber ( banTimeEpoch );

        if reason == "X" then
            reason = "";
        else
            reason = string.gsub ( reason , "##" , "?" );   -- Returning the punctuation as this is user-input.
        end

        if playerWhoBanned == "X" then
            playerWhoBanned = "";
        end

        table.insert ( GRMsyncGlobals.BanReceivedTemp , { playerName , banTimeEpoch , banType , reason , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement , playerWhoBanned , false } );

    elseif prefix == "GRM_BANSYNCXX" then

        if not GRMsyncGlobals.SyncTracker.banData then
            GRMsyncGlobals.ProgressControl ( "BAN" );
        end

        local playerName = msg;
        local player;
        local j;
        local banType;

        j = GRM.GetIndexOfPlayerOnList ( GRMsyncGlobals.guildData , playerName );

        if not j then
            j = GRM.GetIndexOfPlayerOnList ( GRMsyncGlobals.formerGuildData , playerName );
            if j then
                player = GRMsyncGlobals.formerGuildData[j];
                formerMember = true;
            end
        else
            player = GRMsyncGlobals.guildData[j];
            formerMember = false;
        end

        if player then

            if player.bannedInfo[1] then
                banType = "1";
            elseif player.bannedInfo[3] then
                banType = "2";
            else
                banType = "3";
            end

            table.insert ( GRMsyncGlobals.BanReceivedTemp , { player.name , player.bannedInfo[2] , banType , player.reasonBanned , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement , player.bannedInfo[4] , formerMember } );
        end

    -- MAIN STATUS
    elseif prefix == "GRM_MAINSYNC" then
        local mainStatus = "";
        local mainResult = false;

        if not GRMsyncGlobals.SyncTracker.mains then
            GRMsyncGlobals.ProgressControl ( "MAIN" );
        end

        while string.find ( msg , "?" ) ~= nil do
            mainResult = false;
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = GRM.Next ( msg );
            timeStampOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = GRM.Next ( msg );

            if string.find ( msg , "?" ) ~= nil then
                mainStatus = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                msg = GRM.Next ( msg );
            else
                mainStatus = msg;
            end
            -- Let's convert that string to boolean
            if mainStatus == "1" then
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

    if not GRMsyncGlobals.SyncTracker.customNotes then
        GRMsyncGlobals.ProgressControl ( "CUSTOMNOTE" );
    end
    
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
    local name , timeOfChange , day , month = "" , 0 , 0 , 0;

    if not GRMsyncGlobals.SyncTracker.bdays then
        GRMsyncGlobals.ProgressControl ( "BDAYS" );
    end

    while string.find ( msg , "?" ) ~= nil and msg ~= "" do
        name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        msg = GRM.Next ( msg );
        timeOfChange = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = GRM.Next ( msg );
        day = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = GRM.Next ( msg );

        if string.find ( msg , "?" ) ~= nil then
            month = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
            msg = GRM.Next ( msg );
        else
            month = tonumber ( msg );
        end

        if GRMsyncGlobals.BirthdayReceivedTemp[name] == nil then
            GRMsyncGlobals.BirthdayReceivedTemp[name] = {};
            GRMsyncGlobals.BirthdayReceivedTemp[name] = { timeOfChange , day , month , GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement };
        end
    end
end

-- Method:          GRMsync.CollectAltAddData ( string )
-- What it Does:    Compiles the alt ADD data into a temp file
-- Purpose:         For use of syncing. Need to compile all data from a single player before analyzing it.
GRMsync.CollectAltAddData = function ( msg )
    local altGroupModified;
    local altName = "";
    local needsToAdd = false;
    local name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
    msg = GRM.Next ( msg );

    if not GRMsyncGlobals.SyncTracker.alts then
        GRMsyncGlobals.ProgressControl ( "ALT" );
    end

    if string.find ( msg , "?" ) == nil then
        altGroupModified = tonumber ( msg );
    else
        altGroupModified = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
        msg = GRM.Next ( msg );

        if string.find ( msg , "?" ) == nil then
            needsToAdd = true;
        end

    end

    GRMsyncGlobals.AltReceivedTemp[name] = GRMsyncGlobals.AltReceivedTemp[name] or {};
    GRMsyncGlobals.AltReceivedTemp[name].altGroupModified = altGroupModified;

    if needsToAdd then
        table.insert ( GRMsyncGlobals.AltReceivedTemp[name] , msg );
    end

    -- First, let's isolate the player...
    while string.find ( msg , "?" ) ~= nil do -- if only the leader name is sent, but not the alt, we need to break here

        altName = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
        msg = GRM.Next ( msg );

        table.insert ( GRMsyncGlobals.AltReceivedTemp[name] , altName );

        if string.find ( msg , "?" ) == nil and msg ~= "" then
            table.insert ( GRMsyncGlobals.AltReceivedTemp[name] , msg );
        end
        
    end

    sort ( GRMsyncGlobals.AltReceivedTemp[name] );  -- Just to clean it up a bit in case of reviewing the data
end

-- Method:          GRMsync.CheckingJDChanges ( int )
-- What it Does:    After receiving ALL of the Join date data, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingJDChanges = function ( syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local isFound = false;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    local changeData;

    for j = 1 , #exactIndexes[1] do
        isFound = false;
        for i = 1 , #GRMsyncGlobals.JDReceivedTemp do
            if guildData[exactIndexes[1][j]].name == GRMsyncGlobals.JDReceivedTemp[i][1] then
                isFound = true;
                -- Ok player identified, now let's compare data.
                changeData = {};

                if not guildData[exactIndexes[1][j]].joinDateHist[1][6] then
                    changeData = GRMsyncGlobals.JDReceivedTemp[i];

                else

                    if guildData[exactIndexes[1][j]].joinDateHist[1][5] < GRMsyncGlobals.JDReceivedTemp[i][5] then
                        -- Received Data happened more recently! Need to update change!
                        changeData = GRMsyncGlobals.JDReceivedTemp[i];
                    -- Adding my own data, as it is more current
                    else
                        changeData = { guildData[exactIndexes[1][j]].name , guildData[exactIndexes[1][j]].joinDateHist[1][5] , guildData[exactIndexes[1][j]].joinDateHist[1][1] , guildData[exactIndexes[1][j]].joinDateHist[1][2] , guildData[exactIndexes[1][j]].joinDateHist[1][3] , guildData[exactIndexes[1][j]].joinDateHist[1][4] , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                    end     

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
                break;
            end
        end 
        if not isFound and guildData[exactIndexes[1][j]].joinDateHist[1][6] then
            table.insert ( GRMsyncGlobals.JDChanges , { guildData[exactIndexes[1][j]].name , guildData[exactIndexes[1][j]].joinDateHist[1][5] , guildData[exactIndexes[1][j]].joinDateHist[1][1] , guildData[exactIndexes[1][j]].joinDateHist[1][2] , guildData[exactIndexes[1][j]].joinDateHist[1][3] , guildData[exactIndexes[1][j]].joinDateHist[1][4] , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
        end
    end
    -- Wiping the temp file!
    -- From here, request should be sent out for PDSYNC!
    GRMsyncGlobals.JDReceivedTemp = {};
end

-- Method:          GRMsync.CheckingPDChanges ( int )
-- What it Does:    After receiving ALL of the promo date data, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingPDChanges = function ( syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local isFound = false;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    local changeData = {};

    for j = 1 , #exactIndexes[2] do
        isFound = false;
        for i = 1 , #GRMsyncGlobals.PDReceivedTemp do
            if guildData[exactIndexes[2][j]].name == GRMsyncGlobals.PDReceivedTemp[i][1] then
                isFound = true;
                changeData = {};

                if not guildData[exactIndexes[2][j]].rankHist[1][7] then
                    changeData = GRMsyncGlobals.PDReceivedTemp[i];

                else
                    
                    if guildData[exactIndexes[2][j]].rankHist[1][6] < GRMsyncGlobals.PDReceivedTemp[i][5] then
                        -- Received Data happened more recently! Need to update change!
                        changeData = GRMsyncGlobals.PDReceivedTemp[i];         -- In other words, don't add my own data, add the received data.
                    -- Adding my own data, as it is more current
                    else
                        changeData = { guildData[exactIndexes[2][j]].name , guildData[exactIndexes[2][j]].rankHist[1][2] , guildData[exactIndexes[2][j]].rankHist[1][3] , guildData[exactIndexes[2][j]].rankHist[1][4] , guildData[exactIndexes[2][j]].rankHist[1][5] , guildData[exactIndexes[2][j]].rankHist[1][6] , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                    end
                end

                -- Need to check if change has not already been added, or if another player added info that is more recent! (Might need review for increased performance)
                local needToAdd = true;
                for r = #GRMsyncGlobals.PDChanges , 1 , -1 do
                    if changeData[1] == GRMsyncGlobals.PDChanges[r][1] then
                        -- If dates are the same, no need to change em!
                        if changeData[2] <= GRMsyncGlobals.PDChanges[r][6] then
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
                break;
            end
        end
        if not isFound and guildData[exactIndexes[2][j]].rankHist[1][7] then
            table.insert ( GRMsyncGlobals.PDChanges , { guildData[exactIndexes[2][j]].name , guildData[exactIndexes[2][j]].rankHist[1][2] , guildData[exactIndexes[2][j]].rankHist[1][3] , guildData[exactIndexes[2][j]].rankHist[1][4] , guildData[exactIndexes[2][j]].rankHist[1][5] , guildData[exactIndexes[2][j]].rankHist[1][6] , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
        end
    end
    -- Wipe the data!
    GRMsyncGlobals.PDReceivedTemp = {};
end

-- Method:          GRMsync.CheckingBANChanges ()
-- What it Does:    After receiving ALL of the Ban info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingBANChanges = function ()
    local guildData = GRMsyncGlobals.guildData;
    local leftGuildData = GRMsyncGlobals.formerGuildData;

    -- Skip this all if player restrict ban list sync
    if GRM.S().syncBanList then -- { name , timeStampOfBanChange , banStatus , reason }

        local isFound = false;
        local j = 0;
        local banType = "3";
        local formerMember = true;
        local playerData = {};
        local classIndex = "0";
        local oldJoinDateMeta = 0;
        local rankNme = "";
        local rankIndex = 9;
        local GUID = "";

        for i = 1 , #GRMsyncGlobals.BanReceivedTemp do

            local player;
            formerMember = true;
            playerData = {};
            classIndex = "0";

            -- Former
            if GRMsyncGlobals.BanReceivedTemp[i][8] then
                j = GRM.GetIndexOfPlayerOnList ( leftGuildData , GRMsyncGlobals.BanReceivedTemp[i][1] );
                if j then
                    player = leftGuildData[j];
                    formerMember = true;
                end
            else
                j = GRM.GetIndexOfPlayerOnList ( guildData , GRMsyncGlobals.BanReceivedTemp[i][1] );
                if j then
                    player = guildData[j];
                    formerMember = false;
                end
            end

            if player then

                    -- determine which data is more current
                if player.bannedInfo[2] >= GRMsyncGlobals.BanReceivedTemp[i][2] then

                    if player.bannedInfo[1] then
                        banType = "1";
                    elseif player.bannedInfo[3] then
                        banType = "2";
                    else
                        banType = "3";
                    end

                    if formerMember then
                        -- In other words -- my data is more current AND this is a former player -- other player may not have them in their DB. Sending data for them to add meta data.

                        -- CLASS
                        if player.class == nil or player.class == "" then
                            classIndex = "0";        -- zero so it is just 1 char long.
                        else
                            classIndex = tostring ( GRM_G.classFileIDEnum[ player.class ] )
                        end
                        if not classIndex then
                            classIndex = "0";
                        end

                        -- OLD META EPOCH
                        oldJoinDateMeta = 0;
                        if player.joinDateHist[1][4] > 0 then
                            oldJoinDateMeta = player.joinDateHist[1][4];
                        elseif player.rankHist[1][5] > 0 then
                            oldJoinDateMeta = player.rankHist[1][5]; -- for some reason no join leave data recorded so default
                        end

                        rankName = player.rankName;
                        rankIndex = player.rankIndex;
                        if rankName == "" or player.rankIndex == 99 then
                            rankName = "###"
                            rankIndex = 99;
                        end

                        local GUID = player.GUID;
                        if player.GUID == nil or player.GUID == "" then
                            player.GUID = "";
                            GUID = "X"
                        end

                        playerData = { rankName , tostring ( rankIndex ) , tostring ( player.level ) , classIndex , tostring ( player.joinDateHist[1][4] ) , tostring ( oldJoinDateMeta ) , GUID }
                    end

                    table.insert ( GRMsyncGlobals.BanChanges , { player.name , player.bannedInfo[2] , banType , player.reasonBanned , GRMsyncGlobals.DesignatedLeader , GRM.S().syncRankBanList , player.bannedInfo[4] , playerData , true } );  -- Final position bool - if leader data
                else
                    table.insert ( GRMsyncGlobals.BanChanges , { GRMsyncGlobals.BanReceivedTemp[i][1] , GRMsyncGlobals.BanReceivedTemp[i][2] , GRMsyncGlobals.BanReceivedTemp[i][3] , GRMsyncGlobals.BanReceivedTemp[i][4] , GRMsyncGlobals.BanReceivedTemp[i][5] , GRMsyncGlobals.BanReceivedTemp[i][6] , GRMsyncGlobals.BanReceivedTemp[i][7] , playerData , false } );

                end

            end

        end
    end
end

-- Method:          GRMsync.CheckingMAINChanges ( int , int )
-- What it Does:    After receiving ALL of the Main info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingMAINChanges = function ( syncRankFilter )
    local guildData = GRMsyncGlobals.guildData;
    local isFound = false;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    local changeData;

    -- Progress Control
    if not GRMsyncGlobals.SyncTracker.compareMains then
        GRMsyncGlobals.ProgressControl ( "COMPAREMAINS" );
    end
    
    for j = 1 , #exactIndexes[4] do
        isFound = false;
        for i = 1 , #GRMsyncGlobals.MainReceivedTemp do

            if guildData[exactIndexes[4][j]].name == GRMsyncGlobals.MainReceivedTemp[i][1] then
                isFound = true;
                -- Alright, now let's see if our data matches up!
                if guildData[exactIndexes[4][j]].mainStatusChangeTime ~= GRMsyncGlobals.MainReceivedTemp[i][3] then
                    -- If it does, then do nothing... however, if it does not, do the following...
                    changeData = {};

                    if guildData[exactIndexes[4][j]].mainStatusChangeTime < GRMsyncGlobals.MainReceivedTemp[i][3] then
                        addReceived = true;         -- In other words, don't add my own data, add the received data.
                        changeData = GRMsyncGlobals.MainReceivedTemp[i];
                        table.insert ( GRMsyncGlobals.MainReceivedTemp[i] , true ); -- Add that the leader needs to update.
                    else
                        changeData = { guildData[exactIndexes[4][j]].name , guildData[exactIndexes[4][j]].isMain , guildData[exactIndexes[4][j]].mainStatusChangeTime , GRMsyncGlobals.DesignatedLeader , syncRankFilter , false };
                    end
                    table.insert ( GRMsyncGlobals.AltMainChanges , changeData );
                end                        
                break;
            end
        end

        -- Not received any data to compare, so we know that our data is most current.
        if not isFound and guildData[exactIndexes[4][j]].mainStatusChangeTime ~= 0 then
            table.insert ( GRMsyncGlobals.AltMainChanges , { guildData[exactIndexes[4][j]].name , guildData[exactIndexes[4][j]].isMain , guildData[exactIndexes[4][j]].mainStatusChangeTime , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
        end

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

    if exactIndexes[5] ~= nil then
        for j = 1 , #exactIndexes[5] do
            isFound = false;
            for i = 1 , #GRMsyncGlobals.CustomNoteReceivedTemp  do
                if guildData[exactIndexes[5][j]].name == GRMsyncGlobals.CustomNoteReceivedTemp[i][1] then
                    
                    isFound = true;
                    local addReceived = false;      -- AM I going to add received data, or my own. One or the other needs to be added for sync
                    if ( guildData[exactIndexes[5][j]].customNote[2] < GRMsyncGlobals.CustomNoteReceivedTemp[i][2] ) or not guildData[exactIndexes[5][j]].customNote[1] then
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
                        local customNote = guildData[exactIndexes[5][j]].customNote[6];
                        if customNote == "" then
                            customNote = "X&&X";
                        end
                        changeData = { guildData[exactIndexes[5][j]].name , guildData[exactIndexes[5][j]].customNote[2] , guildData[exactIndexes[5][j]].customNote[3] , guildData[exactIndexes[5][j]].customNote[4] , customNote , GRMsyncGlobals.DesignatedLeader , syncRankFilter };
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
            if not isFound and guildData[exactIndexes[5][j]].customNote[1] and guildData[exactIndexes[5][j]].customNote[2] ~= 0 then
                local customNote = guildData[exactIndexes[5][j]].customNote[6];
                if customNote == "" then
                    customNote = "X&&X";
                end
                table.insert ( GRMsyncGlobals.CustomNoteChanges , { guildData[exactIndexes[5][j]].name , guildData[exactIndexes[5][j]].customNote[2] , guildData[exactIndexes[5][j]].customNote[3] , guildData[exactIndexes[5][j]].customNote[4] , customNote , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
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
    local needToAddMyData = false;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    local player;

    -- No need to check my data if I am not going to share it. I must just accept their data and pass it along. I just wont' absorb it and then people will rely on their filters.
    if GRM.S().syncBDays then
        -- Just checking my own data first...
        for i = 1 , #exactIndexes[6] do

            player = guildData[exactIndexes[6][i]];

            if GRMsyncGlobals.BirthdayReceivedTemp[player.name] then

                -- First, let's see if the current leader has a bday
                if player.events[2][4] > 0 then
                    -- Leader has a modified bday on master list

                    if GRMsyncGlobals.BirthdayReceivedTemp[player.name][1] > 0 then
                        -- Both have birthdays.

                        if player.events[2][4] > GRMsyncGlobals.BirthdayReceivedTemp[player.name][1] then
                            -- Master list is most current
                            table.insert ( GRMsyncGlobals.BDayChanges , { player.name , player.events[2][4] , player.events[2][1][1] , player.events[2][1][2] , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );

                        else
                            -- received list is most current
                            table.insert ( GRMsyncGlobals.BDayChanges , { player.name , GRMsyncGlobals.BirthdayReceivedTemp[player.name][1] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][2] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][3] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][4] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][5] } );
                        end

                    else
                        -- Only the leader has an alt with a modified bday - Add leader's master list bday info
                        table.insert ( GRMsyncGlobals.BDayChanges , { player.name , player.events[2][4] , player.events[2][1][1] , player.events[2][1][2] , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );

                    end


                elseif GRMsyncGlobals.BirthdayReceivedTemp[player.name][1] > 0 then
                    -- received has a modified bday but the master list does not - add the received's list beday info
                    table.insert ( GRMsyncGlobals.BDayChanges , { player.name , GRMsyncGlobals.BirthdayReceivedTemp[player.name][1] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][2] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][3] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][4] , GRMsyncGlobals.BirthdayReceivedTemp[player.name][5] } );


                end
            
            elseif player.events[2][4] > 0 then
                -- This means the received player did not have a modified bday for this toon, so we keep the master list
                table.insert ( GRMsyncGlobals.BDayChanges , { player.name , player.events[2][4] , player.events[2][1][1] , player.events[2][1][2] , GRMsyncGlobals.DesignatedLeader , syncRankFilter } );
            end

        end

    else
        -- Just accept all the changes since you are not comparing to your own data...
        for name in pairs ( GRMsyncGlobals.BirthdayReceivedTemp ) do
            table.insert ( GRMsyncGlobals.BDayChanges , { name , GRMsyncGlobals.BirthdayReceivedTemp[name][1] , GRMsyncGlobals.BirthdayReceivedTemp[name][2] , GRMsyncGlobals.BirthdayReceivedTemp[name][3] , GRMsyncGlobals.BirthdayReceivedTemp[name][4] , GRMsyncGlobals.BirthdayReceivedTemp[name][5] } );
        end
    end

    -- Now, we cleanup the birthday send since the alt lists should be good now.
    local alts;
    local player;
    local count = #GRMsyncGlobals.BDayChanges

    while count > 0 do

        player = GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][GRMsyncGlobals.BDayChanges[count][1]];

        if player then

            alts = GRM.GetListOfAlts ( player , false );

            -- Synce the bday is propagated to all in the alt grouping, I only need to send for one in the alt grouping
            -- Let's remove all alts from the "final list" of bday changes and only send out for the 1
            for j = 1 , #alts do
                for k = #GRMsyncGlobals.BDayChanges , 1 , -1 do
                    if GRMsyncGlobals.BDayChanges[k][1] == alts[j][1] then
                        table.remove ( GRMsyncGlobals.BDayChanges , k );
                        count = count - 1;
                        break;
                    end
                end
            end
        end
        count = count - 1;                
    end

    GRMsyncGlobals.finalSyncDataCount = 1;
    GRMsyncGlobals.BirthdayReceivedTemp = {};
    GRMsync.SubmitFinalMainData();
end

-- Method:          GRMsync.CompareAltLists()
-- What it Does:    Compares the Leader's data to the received's data
-- Purpose:         Let's analyze the alt lists!
GRMsync.CompareAltLists = function()
    -- Ok, first things first, I need to compile both tables

    -- Progress tracking
    if not GRMsyncGlobals.SyncTracker.compareAlts then
        GRMsyncGlobals.ProgressControl ( "COMPAREALTS" );
    end
    
    local leaderListOfAlts = {};
    local syncRankFilter = GRM.S().syncRank;
    if GRM.S().exportAllRanks then
        syncRankFilter = GuildControlGetNumRanks() - 1;
    end

    local guildData = GRMsyncGlobals.guildData;
    local altData = GRMsyncGlobals.guildAltData;
    local exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    local alts = {};
    local main = "";
    local onList = false;
    local epochTimestamp = 0;
    local ind = 0;
    GRMsyncGlobals.altSyncCompleted = false;

    if exactIndexes[3] == nil then
        GRMsync.BuildFullCheckArray();
        exactIndexes = GRMsyncGlobals.DatabaseExactIndexes;
    end

    -- Let's first get the leader's alt data to compare.
    if exactIndexes[3] ~= nil then

        for j = 1 , #exactIndexes[3] do

            -- Add a position for each mismatched name
            GRMsyncGlobals.FinalCorrectAltList[guildData[exactIndexes[3][j]].name] = {};

            -- initializing empty tables for each of the leader's players
            leaderListOfAlts[guildData[exactIndexes[3][j]].name] = {};

            alts = GRM.GetListOfAlts ( guildData[exactIndexes[3][j]] , false , altData );

            -- Build leader alt Tables for easier coding
            if #alts > 0 then
                for i = 1 , #alts do

                    if i == 1 then
                        leaderListOfAlts[guildData[exactIndexes[3][j]].name].altGroupModified = alts[i][3];
                    end

                    table.insert ( leaderListOfAlts[guildData[exactIndexes[3][j]].name] , alts[i][1] ); -- AN extra step, but easier to follow in the code.
                end
                sort ( leaderListOfAlts[guildData[exactIndexes[3][j]].name] );

            else
                leaderListOfAlts[guildData[exactIndexes[3][j]].name].altGroupModified = guildData[exactIndexes[3][j]].altGroupModified;
            end

        end

        local InsertName = function ( listAlreadyAdded , name )

            local isFound = false;

            for i = 1 , #listAlreadyAdded do
                if listAlreadyAdded[i] == name then
                    isFound = true;
                    break;
                end
            end

            if not isFound then
                table.insert ( listAlreadyAdded , name );
            end

            return listAlreadyAdded;
        end
        -- Now we can compare!!!

        ----------------------------------------------
        ----- CHECKING AGAINST LEADER'S DATA  --------
        ----------------------------------------------0

        -- Scan through leaders alts - This should be sufficient as the leader's indexes of differences has already been compared.
        for name , leaderAlts in pairs ( leaderListOfAlts ) do

            -- Scan through received alts
            if GRMsyncGlobals.AltReceivedTemp[name] ~= nil then  -- If it did == nil, it would indicate a failure in the sync process

                -- Compare received list to master list - master list is held by "leader"
                if #GRMsyncGlobals.AltReceivedTemp[name] > 0 then
                    -- Let's determine who has the more current information.
                    
                    if  #leaderAlts > 0 then
                        -- Master list also has alts, so let's see which was added more recently

                        if GRMsyncGlobals.AltReceivedTemp[name].altGroupModified > leaderListOfAlts[name].altGroupModified then
                            -- Received alts grouping is MORE current than master list

                            -- Add all received alts
                            for i = 1 , #GRMsyncGlobals.AltReceivedTemp[name] do

                                if i == 1 then
                                    GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = GRMsyncGlobals.AltReceivedTemp[name].altGroupModified;
                                    GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement };
                                end

                                GRMsyncGlobals.FinalCorrectAltList[name] = InsertName ( GRMsyncGlobals.FinalCorrectAltList[name] , GRMsyncGlobals.AltReceivedTemp[name][i] );

                            end

                        else
                            -- Master list alt grouping is MORE current that the received list
                            -- Add all master alts
                            for i = 1 , #leaderAlts do

                                if i == 1 then
                                    GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = leaderListOfAlts[name].altGroupModified;
                                    GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                                end

                                GRMsyncGlobals.FinalCorrectAltList[name] = InsertName ( GRMsyncGlobals.FinalCorrectAltList[name] , leaderAlts[i] );

                            end

                        end

                    else
                        -- Master list has no alts, so we need to determine if the received is more current

                        if GRMsyncGlobals.AltReceivedTemp[name].altGroupModified > leaderListOfAlts[name].altGroupModified then

                            -- Received is more current
                            -- Add all received alts
                            for i = 1 , #GRMsyncGlobals.AltReceivedTemp[name] do

                                if i == 1 then
                                    GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = GRMsyncGlobals.AltReceivedTemp[name].altGroupModified;
                                    GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement };
                                end

                                GRMsyncGlobals.FinalCorrectAltList[name] = InsertName ( GRMsyncGlobals.FinalCorrectAltList[name] , GRMsyncGlobals.AltReceivedTemp[name][i] );

                            end
                            
                        else

                            -- Update the timestamp
                            GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = leaderListOfAlts[name].altGroupModified;
                            GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.DesignatedLeader , syncRankFilter };

                        end

                    end

                elseif #leaderAlts > 0 then
                    -- Received has no alts, but leader does, on the master list

                    if leaderListOfAlts[name].altGroupModified > GRMsyncGlobals.AltReceivedTemp[name].altGroupModified then

                        -- - Add all leader alts from master list
                        for i = 1 , #leaderAlts do

                            if i == 1 then
                                GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = leaderListOfAlts[name].altGroupModified;
                                GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.DesignatedLeader , syncRankFilter };
                            end

                            GRMsyncGlobals.FinalCorrectAltList[name] = InsertName ( GRMsyncGlobals.FinalCorrectAltList[name] , leaderAlts[i] );

                        end
                        
                    else

                        -- Update the timestamp
                        GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = GRMsyncGlobals.AltReceivedTemp[name].altGroupModified;
                        GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement };

                    end

                else
                    -- Neither has alts   GRMsyncGlobals.AltReceivedTemp[name]
                    if GRMsyncGlobals.AltReceivedTemp[name].altGroupModified >= leaderListOfAlts[name].altGroupModified then

                        GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = GRMsyncGlobals.AltReceivedTemp[name].altGroupModified;
                        GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.CurrentSyncPlayer , GRMsyncGlobals.CurrentSyncPlayerRankRequirement };

                    else

                        GRMsyncGlobals.FinalCorrectAltList[name].altGroupModified = leaderListOfAlts[name].altGroupModified;
                        GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.DesignatedLeader , syncRankFilter };

                    end

                end

            else
                GRMsyncGlobals.FinalCorrectAltList[name].syncControl = { GRMsyncGlobals.DesignatedLeader , syncRankFilter };
            end

        end

        -- Leader Count
        local listOfAlts = {};
        for name , alts in pairs ( GRMsyncGlobals.FinalCorrectAltList ) do
            
            if GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][name] then
                -- Ok, collect the alts so we can compare.
                listOfAlts = GRM.GetListOfAlts ( GRM_GuildMemberHistory_Save[ GRM_G.F ][ GRM_G.guildName ][name] , false , GRM_Alts[GRM_G.guildName] )
                if not GRMsync.IsListTheSame ( alts , listOfAlts ) then
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                    GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;
                end
            end
        end

        GRMsyncGlobals.altSyncCompleted = true;
    else
        GRMsyncGlobals.altSyncCompleted = false;
    end

end

-- Method:          GRMsync.PreCheckChanges( string )
-- What it Does:    Controls the flow of changes. No need to checkForChanges if player has only sent minimal data
-- Purpose:         A leaner sync algorithm!
GRMsync.PreCheckChanges = function ( msg )
    local lists = { "JD" , "PD" , "MAIN" , "ALTS" , "CUSTOM" , "BAN" };

    GRM_G.MatchPattern6 = GRM_G.MatchPattern6 or GRM.BuildComPattern ( 6 , "?" , false );
    local jd , pd , alt , main , custom , ban = GRM.ParseComMsg ( msg , GRM_G.MatchPattern6 );

    if jd == "true" then
        GRMsync.CheckChanges ( "JD" );
    end
    if pd == "true" then
        GRMsync.CheckChanges ( "PD" );
    end
    if main == "true" then
        GRMsync.CheckChanges ( "MAIN" );
    end
    if alt == "true" then
        GRMsync.CompareAltLists();

        if not GRMsyncGlobals.altSyncCompleted then
            -- HUGE ISSUE HERE - THIS IS PROTECTION
            GRMsync.EndSync();
            return
        end
    end
    if custom == "true" then
        GRMsync.CheckChanges ( "CUSTOM" );
    end
    if ban == "true" then
        GRMsync.CheckChanges ( "BAN" );
    end

    GRMsync.SubmitFinalSyncData();
end

-- Method:          GRMsync.CheckChanges ( string )
-- What it Does:    Checks to see if the received data and the leader's data is different and then adds the most recent changes to update que
-- Purpose:         Retroactive Sync Procedure fully defined here in this method. MUCH WORK!
GRMsync.CheckChanges = function ( msg )
    local syncRankFilter = GRM.S().syncRank;
    if msg ~= "BAN" then
        if GRM.S().exportAllRanks then
            syncRankFilter = GuildControlGetNumRanks() - 1;
        end
    end

    if GRMsyncGlobals.DatabaseExactIndexes[1] == nil then
        GRMsync.BuildFullCheckArray();
    end

    -----------------------------
    -- For Join Date checking!
    -----------------------------
    if msg == "JD" then
        GRMsync.CheckingJDChanges ( syncRankFilter );

    -----------------------------
    -- For Promo Date checking!
    -----------------------------
    elseif msg == "PD" then
        GRMsync.CheckingPDChanges ( syncRankFilter );

    -----------------------------
    -- For Main Change checking!
    -----------------------------
    elseif msg == "MAIN" then
        GRMsync.CheckingMAINChanges ( syncRankFilter );

    -----------------------------
    -- For Custom Note checking!
    -----------------------------
    elseif msg == "CUSTOM" then
        GRMsync.CheckingCustomNoteChanges ( syncRankFilter );

    -----------------------------
    --- FOR BAN STATUS CHECK ----
    -----------------------------
    elseif msg == "BAN" then
        GRMsync.CheckingBANChanges ();

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

    for i = 1 , #GRMsyncGlobals.updatesEach do
        if i == 1 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Join Dates" , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] ) );
        elseif i == 2 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Promo Dates" , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] ) );
        elseif i == 3 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Alts" , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] ) );
        elseif i == 4 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Main Tags" , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] ) );
        elseif i == 5 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Custom Notes" , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] ) );
        elseif i == 6 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Birthdays" , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] ) );
        elseif i == 7 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: Bans" , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] ) );
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
        if GRM.S().syncChatEnabled and ( GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or GRM.S().exportAllRanks ) then
            local announce = "";
            
            if GRM.S().syncChatEnabled then

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

            -- Progress tracking
            if not GRMsyncGlobals.SyncTracker.finish then
                GRMsyncGlobals.ProgressControl ( "FINISH" );
            end

            GRM.Report ( announce );
            GRMsync.ReportResults();
            GRMsync.ReportAuditMessage();

            GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , 0.5 , { 0.42 , 0.92 , 1 } );

            GRMsyncGlobals.syncComplete = true;
            GRM_G.slashCommandSyncTimer = time();
            
        end

        if GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
            GRM.RefreshAuditFrames ( true , true );
        end
        if GRM_UI.GRM_RosterChangeLogFrame.GRM_LogFrame:IsVisible() then
            GRM_G.LogNumbersColorUpdate = true;
            GRM.BuildLogComplete( true , true );
        end
        if GRM_UI.GRM_RosterChangeLogFrame.GRM_CoreBanListFrame:IsVisible() then
            GRM.RefreshBanListFrames();
        end

        if GRM_UI.GRM_ToolCoreFrame:IsVisible() then
            GRM_UI.RefreshManagementTool();
        end
        
        if GRM_UI.GRM_LoadToolButton:IsVisible() then
            GRM_UI.RefreshToolButtonsOnUpdate();
        end
        GRMsyncGlobals.updateCount = 0;
        GRMsyncGlobals.updatesEach = { 0 , 0 , 0 , 0 , 0 , 0 , 0 };
        GRMsyncGlobals.errorCheckEnabled = false;
        GRMsyncGlobals.currentlySyncing = false;

        GRMsyncGlobals.AnnounceDelay = time();
    end
end

-- Method:          GRM.AuditRefreshTracker( bool )
-- What it Does:    Every 100 updates it sends the audit an update request. Due to sync speed limitations, this is just an internal throttle on updating the audit
-- Purpose:         Quality of life audit update when syncing.
GRM.AuditRefreshTracker = function ( force )
    if not force then
        GRMsyncGlobals.refreshCount = GRMsyncGlobals.refreshCount + 1;
        GRMsyncGlobals.refreshCountTimer = time();
    end
    if ( ( GRMsyncGlobals.refreshCount % 50 ) == 0 or force ) and GRM_UI.GRM_RosterChangeLogFrame.GRM_AuditFrame:IsVisible() then
        GRM.RefreshAuditFrames ( true , true );
    end
    if not force then
        C_Timer.After ( 3 , function()
            if ( time() - GRMsyncGlobals.refreshCountTimer ) >= 3 then
                GRM.AuditRefreshTracker ( true );
            end
        end);
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
    local altName = GRM.Next ( msg );

    GRM.RemoveAlt ( altName , false , 0 );
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

-- For eash call to.
local commsLive = { ["GRM_JD"] = true , ["GRM_PD"] = true , ["GRM_ADDALT"] = true , ["GRM_AC"] = true , ["GRM_RMVALT"] = true , ["GRM_MAIN"] = true , ["GRM_RMVMAIN"] = true , ["GRM_BDAY"] = true , ["GRM_BDAYREM"] = true };
local commsSyncUp = { ["GRM_JDSYNCUP"] = true , ["GRM_PDSYNCUP"] = true , ["GRM_ALTSYNCUP"] = true , ["GRM_MAINSYNCUP"] = true , ["GRM_BDSYNCUP"] = true , ["GRM_BANSYNCUP"] = true , ["GRM_BANSYNCUPX"] = true , ["GRM_FINALALTSYNCUP"] = true };
local commsLead = { ["GRM_WHOISLEADER"] = true , ["GRM_IAMLEADER"] = true , ["GRM_ELECT"] = true , ["GRM_ELECTINFO"] = true , ["GRM_NEWLEADER"] = true , ["GRM_STARTMSG"] = true };
local macroSync = { ["GRM_MACRO_T"] = true , ["GRM_Macro_SK"] = true , ["GRM_Macro_SP"] = true , ["GRM_Macro_SD"] = true , ["GRM_Macro_RK"] = true , ["GRM_Macro_RP"] = true , ["GRM_Macro_RD"] = true , ["GRM_Macro_LK"] = true , ["GRM_Macro_LP"] = true , ["GRM_Macro_LD"] = true , ["GRM_Macro_PQ"] = true , ["GRM_Macro_FN"] = true , ["GRM_Macro_XX"] = true , ["GRM_Macro_MK"] = true , ["GRM_Macro_MP"] = true , ["GRM_Macro_MD"] = true }; -- Received, sentKick , sentPromote , sentDemote , sentCustom

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
        if not IsInGuild() then
            self:UnregisterAllEvents();
        else

            if event == "CHAT_MSG_ADDON" and ( channel == GRMsyncGlobals.channelName or channel == "WHISPER" ) and GRMsync.IsPrefixVerified ( prefix ) then     -- Don't need to register my own sends.

                -- Sender must not equal themselves...
                if sender ~= GRM_G.addonUser then
                    
                    -- Version Control Check First....
                    -- First, see if they are on compatible list.
                    comms.isFound = false;
                    if GRMsyncGlobals.CompatibleAddonUsers[sender] then
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
                            if comms.versionCheckEpoch < GRM_G.PatchDay then                   -- if the player sending data to you has an older version (smaller epoch number)                       
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
                    msg = GRM.Next ( msg );
                    comms.prefix2 = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                    if comms.prefix2 == "GRM_ENDSYNC" then
                        GRMsync.EndSync ( false );
                        return;
                    end

                    -- See GRM_Macro_Tool.lua for the functions
                    if macroSync[comms.prefix2] then
                        GRM.MacroSync ( string.match ( msg , "%a+?(.+)" ) , comms.prefix2 , sender );
                        return; -- no need to move forward if we are working the macro sync logic here.
                    end

                    -- At this point forward is strictly Member data syncing and if disabled just return
                    if not GRM.S().syncEnabled then
                        return;
                    end

                    msg = GRM.Next ( msg );
                    -- Determine if this is a retroactive sync message, or a live sync.
                    if comms.prefix2 == "GRM_JDSYNCUP" or ( commsSyncUp[comms.prefix2] or comms.prefix2 == "GRM_CUSTSYNCUP" ) then

                        if comms.prefix2 == "GRM_FINALALTSYNCUP" then
                            GRMsyncGlobals.NumExpectedAlts = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                            msg = GRM.Next ( msg );
                        end
                        sender = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                        msg = GRM.Next ( msg );

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
                        return;
                    end
                    comms.senderRankID = GRM.GetGuildMemberRankID ( sender );
                    
                    -- Sender is not the designatedleader then return... Higher means lower in-game... 1 = guild leader; 10 = lowest initiate rank. So, if rank is higher than the restricted, it won't work. -- if the comms.senderRankRequirement is lower than the receiving player, then that means it won't sync either.
                    -- of note, leadership role will not be rank restricted, but it will send out restricted data with rank tags on it so others know not to sync it or not. In the meantime the leader will build a temporary database to parry against during sync
                    -- This allows all sync information to be shared, but capable of being restricted by the sending party.
                    if ( commsLive[comms.prefix2] or commsSyncUp[comms.prefix2] ) and ( comms.senderRankRequirement < GRM_G.playerRankID or comms.senderRankID > GRM.S().syncRank ) then
                        return

                    elseif ( comms.prefix2 == "GRM_CNOTE" or comms.prefix2 == "GRM_CUSTSYNCUP" ) and ( comms.senderRankRequirement < GRM_G.playerRankID or comms.senderRankID > GRM.S().syncRankCustom ) then
                        return

                    elseif ( not GRMsyncGlobals.IsElectedLeader and not commsLead[comms.prefix2] and sender ~= GRMsyncGlobals.DesignatedLeader ) and ( comms.senderRankID > GRM.S().syncRank or comms.senderRankRequirement < GRM_G.playerRankID ) then        -- If player's rank is below settings threshold, ignore message.
                        return
                    
                    elseif comms.abortSync and not comms.isFound then
                
                        return;
                    end
                    -- parsing out the rankRequirementOfSender
                    msg = GRM.Next ( msg );
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
                        GRMsync.CheckRemoveAltChange ( msg , sender );
                
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
                    elseif not GRM_G.InGroup then

                        -- For ensuring ban information is controlled!
                        if ( comms.prefix2 == "GRM_BAN" or comms.prefix2 == "GRM_UNBAN" or comms.prefix2 == "GRM_BANSYNCUP" or comms.prefix2 == "GRM_BANSYNCUPX" or comms.prefix2 == "GRM_BANSYNC" or comms.prefix2 == "GRM_BANSYNCX" or comms.prefix2 == "GRM_BANSYNCXX" or comms.prefix2 == "GRM_BANSYNCSP" or comms.prefix2 == "GRM_BANSYNCSPX" ) and GRM.S().syncBanList then
                            if tonumber ( msg ) == nil then -- Error protection on some edge cases for older versions talking to each other.
                                local senderBanControlRankRequirement = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                                msg = GRM.Next ( msg );
                                -- Should that be the player name, or should it be a name parsed from the sender??? -- Might need to investigate
                                if ( comms.senderRankID > GRM.S().syncRankBanList or senderBanControlRankRequirement < GRM.GetGuildMemberRankID ( GRM_G.addonUser ) ) then
                                    -- Abort
                                    return;
                                else
                                    if comms.prefix2 == "GRM_BAN" then
                                        GRMsync.CheckBanListChange ( msg , sender );                        -- For live ban occurences
                                    elseif comms.prefix2 == "GRM_UNBAN" then
                                        GRMsync.CheckUnbanListChangeLive ( msg , sender );                  -- For live unban occurrences
                                    elseif comms.prefix2 == "GRM_BANSYNCUP" or comms.prefix2 == "GRM_BANSYNCUPX" then
                                        GRMsync.BanManagement ( msg , comms.prefix2 , sender );    -- For sync analysis final report changes!
                                        GRMsyncGlobals.TimeSinceLastSyncAction = time();
                                    elseif comms.prefix2 == "GRM_BANSYNC" or comms.prefix2 == "GRM_BANSYNCX" or comms.prefix2 == "GRM_BANSYNCXX" or comms.prefix2 == "GRM_BANSYNCSP" or comms.prefix2 == "GRM_BANSYNCSPX" then

                                        GRMsyncGlobals.TimeSinceLastSyncAction = time();                    -- For collecting sync data...
                                        GRMsync.CollectData ( msg , comms.prefix2 );
                                    end
                                end
                            end           
                        elseif comms.prefix2 == "GRM_ADDLEFT" then
                            GRMsync.UpdateLeftPlayerInfo ( msg , false );
                                        
                        --------------------------------------------
                        -------- RETROACTIVE SYNC TRACKING ---------
                        --------------------------------------------

                        -- In response to asking "Who is the leader" then ONLY THE LEADER will respond.
                        elseif comms.prefix2 == "GRM_WHOISLEADER" then
                            GRMsync.LeaderRespond ( sender , tonumber ( msg ) );

                        -- Updates who is the LEADER to sync with!
                        elseif comms.prefix2 == "GRM_IAMLEADER" then
                            GRMsync.SetLeader ( sender , false , msg );

                        elseif comms.prefix2 == "GRM_ELECT" then
                            GRMsync.SendElectionInfo();

                        -- For sending timestamps out!
                        elseif comms.prefix2 == "GRM_ELECTINFO" and not GRMsyncGlobals.LeadershipEstablished then -- Only the person who sent the inquiry will bother reading these... flow control...
                            GRMsync.RegisterTimeStamps ( msg );
                            
                        -- For establishing the new leader after an election
                        elseif comms.prefix2 == "GRM_NEWLEADER" then
                            GRMsync.ElectedLeader ( msg )
                        
                        -- LEADERSHIP ESTABLISHED, NOW LET'S SYNC COMMS!

                        -- Only the leader will hear this message!
                        elseif comms.prefix2 == "GRM_REQUESTSYNC" and GRMsyncGlobals.IsElectedLeader then
                            -- Ensure it is not a double add...
                            
                            -- Ensure not already requested -- shouldn't happen, but redundancy.
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

                            if not GRMsyncGlobals.currentlySyncing then
                                GRMsync.InitiateDataSync();

                            elseif ( #GRMsyncGlobals.SyncQue - 1 ) > 0 then
                                local msg = GRM_G.PatchDayString .. "?GRM_BUSY?" .. GRM.S().syncRank .. "?" .. tostring ( #GRMsyncGlobals.SyncQue - 1 );

                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
                                GRMsync.SendMessage ( "GRM_SYNC" , msg , sender );

                            end

                        elseif comms.prefix2 == "GRM_BUSY" then
                            GRMsync.BusyMessage ( tonumber ( msg ) );
                            
                            -- PLAYER DATA REQ FROM LEADERS
                        -- Leader has requesated your Join Date Data!
                        elseif comms.prefix2 == "GRM_REQJDDATA" and msg == GRM_G.addonUser and not GRMsyncGlobals.currentlySyncing then
                            GRMsync.DataRequestStart();

                        elseif comms.prefix2 == "GRM_TRACKER" then
                            GRMsync.CollectTrackerCalculation ( msg );
                            GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , GRMsyncGlobals.totalEstTime );
                            GRMsyncGlobals.progStart = time();

                        elseif comms.prefix2 == "GRM_REQBFINALDATA" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            -- Refresh the groups
                            GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData , GRMsyncGlobals.guildAltData = GRM.convertToArrayFormat(); -- Now, we refresh the arrays
                            GRMsync.NextSyncStep( 8 );

                        -- Pseudo Hash for comparison
                        elseif comms.prefix2 == "GRM_PHASH" or comms.prefix2 == "GRM_PHASHBAN" or comms.prefix2 == "GRM_PHASHL" or comms.prefix2 == "GRM_PHASHLBAN" then

                            if comms.prefix2 == "GRM_PHASH" or comms.prefix2 == "GRM_PHASHBAN" then

                                if string.sub ( msg , 1 , string.find ( msg , "?" ) -1 ) == GRM_G.addonUser and GRMsyncGlobals.currentlySyncing then

                                    msg = GRM.Next ( msg );

                                    if not string.find ( msg , "FINISH" , 1 , true ) then
                                        if comms.prefix2 == "GRM_PHASHBAN" then
                                            GRMsync.SetReceivedHashValue ( msg , true );
                                        else
                                            GRMsync.SetReceivedHashValue ( msg , false );
                                        end
                                    else

                                        -- Establish Database as an array
                                        GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData , GRMsyncGlobals.guildAltData = GRM.convertToArrayFormat(); -- Now, we set arrays of the data.
                                        if GRMsync.SyncIsNecessary() then

                                            -- Sends leaders the database markers for sync purposes.
                                            GRMsync.SendDatabaseMarkersToLeader();
                                            -- Build the values first
                                            GRMsync.BuildFullCheckArray();

                                            GRMsyncGlobals.TrackerData , GRMsyncGlobals.totalEstTime = GRMsync.CalculateTotalSyncVolume();
                                            GRMsync.SendTrackerCalculation();
                                            GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , GRMsyncGlobals.totalEstTime );
                                            GRMsyncGlobals.progStart = time();

                                            
                                            -- Now, determine where to start in database.
                                            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                                                GRMsync.NextSyncStep ( 1 );
                                            end);

                                        else
                                            GRMsync.SendCompletionMsg();
                                        end
                                    end
                                end

                            elseif ( comms.prefix2 == "GRM_PHASHL" or comms.prefix2 == "GRM_PHASHLBAN" ) then

                                if  string.sub ( msg , 1 , string.find ( msg , "?" ) -1 ) == GRM_G.addonUser and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then

                                    if not string.find ( msg , "FINISH" , 1 , true ) then
                                        if comms.prefix2 == "GRM_PHASHLBAN" then
                                            GRMsync.BuildLeaderDatabaseMarkers ( msg , true );
                                        else
                                            GRMsync.BuildLeaderDatabaseMarkers ( string.sub ( string.match ( msg , "?%a+.+" ) , 2 ) , false );
                                        end
                                    else
                                        GRMsync.BuildFullCheckArray();
                                    end
                                end
                            end

                        -- Final data sent, let's analyze now.
                        elseif comms.prefix2 == "GRM_STOP" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.PreCheckChanges ( msg );

                        elseif comms.prefix2 == "GRM_STOP2" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckChanges ("BDAY");

                        -- Collect all data before checking for changes!
                        elseif ( comms.prefix2 == "GRM_JDSYNC" or comms.prefix2 == "GRM_PDSYNC" or comms.prefix2 == "GRM_MAINSYNC" ) and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectData ( msg , comms.prefix2 );

                        -- For ALT ADD DATA
                        elseif comms.prefix2 == "GRM_ALTADDSYNC" and GRMsyncGlobals.IsElectedLeader and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectAltAddData ( msg );

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

                            if not GRMsyncGlobals.SyncTracker.finalJD then
                                GRMsyncGlobals.ProgressControl ( "FINALJD" );
                                if GRMsyncGlobals.TrackerData.JD[1] then
                                    GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.JD[1] , GRMsyncGlobals.TrackerData.JD[3] );
                                end
                            end

                            GRMsync.CheckJoinDateChange ( msg , sender , comms.prefix2 );
                            GRM.AuditRefreshTracker();

                        -- Sync the Promo Dates!
                        elseif comms.prefix2 == "GRM_PDSYNCUP" then

                            if not GRMsyncGlobals.SyncTracker.finalPD then
                                GRMsyncGlobals.ProgressControl ( "FINALPD" );
                                if GRMsyncGlobals.TrackerData.PD[1] then
                                    GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.PD[1] , GRMsyncGlobals.TrackerData.PD[3] );
                                end
                            end
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckPromotionDateChange ( msg , sender , comms.prefix2 );
                            GRM.AuditRefreshTracker();

                        -- Final sync of ALT player info
                        elseif comms.prefix2 == "GRM_ALTSYNCUP" then

                            if not GRMsyncGlobals.SyncTracker.finalAlts then
                                GRMsyncGlobals.ProgressControl ( "FINALALT" );
                            end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectAltFinalSyncData ( msg , false );

                        -- Final sync of ALT player Info - confirmation to compare data
                        elseif comms.prefix2 == "GRM_FINALALTSYNCUP" then

                            if not GRMsyncGlobals.SyncTracker.finalAlts then
                                GRMsyncGlobals.ProgressControl ( "FINALALT" );
                                if GRMsyncGlobals.TrackerData.ALT[1] then
                                    GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.ALT[1] , GRMsyncGlobals.TrackerData.ALT[3] );
                                end
                            end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckAddAltSyncChange ( GRMsyncGlobals.FinalAltListReeceived , GRMsyncGlobals.NumExpectedAlts );
                        
                        -- Final sync on Main Status
                        elseif comms.prefix2 == "GRM_MAINSYNCUP" then

                            if not GRMsyncGlobals.SyncTracker.finalMain then
                                GRMsyncGlobals.ProgressControl ( "FINALMAIN" );
                                if GRMsyncGlobals.TrackerData.MAIN[1] then
                                    GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.MAIN[1] , GRMsyncGlobals.TrackerData.MAIN[3] );
                                end
                            end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckMainSyncChange ( msg );
                            GRM.AuditRefreshTracker();

                        -- Final sync on Custom Note Changes
                        elseif comms.prefix2 == "GRM_CUSTSYNCUP" then

                            if not GRMsyncGlobals.SyncTracker.finalCustom then
                                GRMsyncGlobals.ProgressControl ( "FINALCUSTOM" );
                                if GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] then
                                    GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] );
                                end
                            end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckCustomNoteSyncChange ( msg , true );

                        -- Final sync on Birthdays
                        elseif comms.prefix2 == "GRM_BDSYNCUP" then

                            if not GRMsyncGlobals.SyncTracker.finalBdays then
                                GRMsyncGlobals.ProgressControl ( "FINALBDAYS" );
                                if GRMsyncGlobals.TrackerData.BDAY[1] then
                                    GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.BDAY[1] , GRMsyncGlobals.TrackerData.BDAY[3] );
                                end
                            end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckBirthdayForSync ( msg );
                            GRM.AuditRefreshTracker();

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

-- Method:          GRMsync.BusyMessage ( int )
-- What it Does:    Reports on the current position in the que
-- Purpose:         It is important to know why the person's sync is not triggering immediately.
GRMsync.BusyMessage = function ( positionInQue )
    
    if not GRMsyncGlobals.WaitingInQue then
        GRM.Report ( GRM.L ( "You are added to the sync queue. Position: {num}" , nil , nil , positionInQue ) );
        GRMsyncGlobals.WaitingInQue = true;
        GRMsyncGlobals.WaitingInQueTimer = time();
    else
        GRM.Report ( GRM.L ( "Sync Queue Position Update: {num}" , nil , nil , positionInQue ) );
    end
        
end

-- Method:          GRMsync.DataRequestStart()
-- What it Does:    Initializes eveyrthing necessary for error check controls
-- Purpose:         Compartmentalizes the main prefix message function for comms.
GRMsync.DataRequestStart = function()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            -- Start forwarding Join Date data...
    GRMsyncGlobals.currentlySyncing = true;
    -- Initialize the error check now as you are now the front of the que being currently sync'd
    if not GRM.IsCalendarEventEditOpen() then
        GRM.GuildRoster();
    end

    GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;

    if not GRMsyncGlobals.ErrorChcekControl then
        C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );
    else
        if not GRMsyncGlobals.errorCheckEnabled then
            GRMsyncGlobals.errorCheckEnabled = true;
        end
        GRMsyncGlobals.ErrorCheckControl = false;
    end

    if GRMsyncGlobals.WaitingInQue then
        GRMsyncGlobals.WaitingInQue = false;
        GRM.Report ( GRM.L ( "Sync has begun after waiting in queue for {num} seconds" , nil , nil , time() - GRMsyncGlobals.WaitingInQueTimer ) );
    end

    GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 10 , 5 );
end

-- Method:          GRMsync.BuildSyncNetwork()
-- What it Does:    Step by step of my in-house sync algorithm custom built for this addon. Step by step it goes!
-- Purpose:         Control the work-flow of establishing the sync infrastructure. This will not maintain it, just builds the initial rules and the server-side channel of communication between players using the addon. Furthermore, by compartmentalizing it, it controls the flow of actions allowing a recursive check over the algorithm for flawless timing, and not moving ahead until the proper parameters are first met.
GRMsync.BuildSyncNetwork = function( forMacro , requestForTime )
    -- Rank necessary to be established to keep'
    if IsInGuild() then
        if not GRMsyncGlobals.DatabaseLoaded then
            GRMsync.WaitTilDatabaseLoads ( forMacro );
        end

        -- Let's get the party started! Establishing rules then communication should be good to go!
        if GRMsyncGlobals.DatabaseLoaded and not GRMsyncGlobals.RulesSet then
            GRMsync.RegisterCommunicationProtocols();
        end

        -- Redundancy in case it fails to load.
        if GRMsyncGlobals.DatabaseLoaded and not GRMsyncGlobals.RulesSet then
            C_Timer.After ( 0.5 , function()
                GRMsync.BuildSyncNetwork ( forMacro , requestForTime )
            end);
        end

        if forMacro then
            if requestForTime then
                GRM.MacroSyncSendTime();
            end
            return;
        end
        
        -- We need to set leadership at this point.
        if not GRM_G.InGroup then
            if GRMsyncGlobals.DatabaseLoaded and GRMsyncGlobals.RulesSet and not GRMsyncGlobals.LeadershipEstablished and not GRMsyncGlobals.LeadSyncProcessing then

                if GRMsyncGlobals.reloadControl then
                    C_Timer.After ( 10 , function()
                        GRMsyncGlobals.reloadControl = false;
                    end);                      
                end

                GRMsyncGlobals.LeadSyncProcessing = true;
                GRMsync.EstablishLeader();
                -- Reset the reload control 1blocker...
                
            end
        end
    end
end

-- ON LOADING!!!!!!!
-- Event Tracking
GRMsync.Initialize = function()
    if GRMsyncGlobals.SyncOK then
        if GRM.S().syncEnabled and IsInGuild() and GRM_G.HasAccessToGuildChat then

            if not GRMsyncGlobals.UILoaded then
                GRMsync.LoadSyncUI();
            end
            
            if ( time() - GRMsyncGlobals.timeAtLogin ) >= GRM.S().syncDelay then
                GRMsync.TriggerFullReset();
                GRM.RegisterGuildAddonUsersRefresh();
                GRMsyncGlobals.LeadSyncProcessing = false;
                GRMsyncGlobals.errorCheckEnabled = false;
                GRMsync.MessageTracking = GRMsync.MessageTracking or CreateFrame ( "Frame" , "GRMsyncMessageTracking" );
                GRM_G.playerRankID = GRM.GetGuildMemberRankID ( GRM_G.addonUser );

                GRMsync.BuildSyncNetwork();

            else

                GRM.Report ( GRM.L ( "Sync is disabled for {num} seconds after logging in. Please wait {custom1} seconds longer." , nil , nil , GRM.S().syncDelay , ( GRM.S().syncDelay - ( time() - GRMsyncGlobals.timeAtLogin ) ) ) );

            end
        end
    end
end

GRMsync.HookComms();

