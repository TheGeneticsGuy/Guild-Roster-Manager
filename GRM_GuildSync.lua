
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

-- SYNC START AND STOP CONTROLS

-- SYNC PROCEDURAL ORDERING CONTROLS PER SYNC
GRMsyncGlobals.CurrentSyncPlayer = "";
GRMsyncGlobals.CurrentSyncPlayerRankID = 0;
GRMsyncGlobals.CurrentLeaderRankID = 0;
GRMsyncGlobals.syncRankFilter = 0
GRMsyncGlobals.syncRankCustomNoteFilter = 0;
GRMsyncGlobals.firstSync = true;
GRMsyncGlobals.currentlySyncing = false;
GRMsyncGlobals.timeOfLastSyncCompletion = 0;

-- error protection escapes
GRMsyncGlobals.TimeSinceLastSyncAction = 0;
GRMsyncGlobals.AnnounceDelay = 0;
GRMsyncGlobals.StartMessage = false;
GRMsyncGlobals.errorCheckEnabled = false;   -- To know when to reactivate the recursive loop or not.
GRMsyncGlobals.ErrorCheckControl = false;   -- For quick exit of the sync
GRMsyncGlobals.ErrorCD = 5;                 -- 5 seconds delay... if no action detected, sync failed and it will retrigger...
GRMsyncGlobals.dateSentComplete = false;    -- If player is not designated leader, this boolean is used to exit the error check loop.
GRMsyncGlobals.syncTempDelay = false;
GRMsyncGlobals.numGuildRanks = 0;

-- Custom note controls (Live sync, retro sync, and self-update, all of which can happen simultaneously so need different controls for each to avoid unlocking gates at inopportune times, even if low probability
GRMsyncGlobals.HalfSyncLive = false;
GRMsyncGlobals.HalfSyncMsgLive = "";

-- Throttle, size, and byte controls 3556
GRMsyncGlobals.sizeModifier = 8;        -- prefix size 8 bytes
GRMsyncGlobals.normalMessage = 3556     -- Normal message size, when it reaches the limit, it resets... -- 14 full messages at 254 bytes each.
GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
GRMsyncGlobals.minFPS = 20;             -- if the player has low FPS the cut the throttlecap in half.
GRMsyncGlobals.throttleTimerUpdate = 0;
GRMsyncGlobals.timeAtLogin = time();
GRMsyncGlobals.SyncCount = 0;               -- 2 because index begins at 2 in the table, as index 1 is the guild name
GRMsyncGlobals.reloadControl = false;
GRMsyncGlobals.ThrottleDelay = 1.25;           -- 1.25 seconds between bursts.

-- Throttle compatibility with ChatThrottleLib - GRM will prioritize all other addons that send comms data so as not to pollute the global space
GRMsyncGlobals.CTLEnabled = false;
GRMsyncGlobals.ChatThrottleDelay = 0;

-- Version check
GRMsyncGlobals.CompatibleAddonUsers = {};

-- Custom pseudo hash values
GRMsyncGlobals.PreCheckHashValues = {};
GRMsyncGlobals.HashValuesReceived = { {} , {} , {} , {} , {} , {} };
GRMsyncGlobals.DatabaseMarkers = {};
GRMsyncGlobals.SyncPath = { false , false , false , false , false , false };
GRMsyncGlobals.SyncProgress = { false , false , false , false , false , false , true }; -- 7 is completion and always true
GRMsyncGlobals.SyncTracker = {};
GRMsyncGlobals.senderBanRankReq = 0;
GRMsyncGlobals.senderMaxRankReq = 0;
GRMsyncGlobals.senderRankRequirement = 0;
GRMsyncGlobals.senderCustRankReq = 0;

-- Results
GRMsyncGlobals.updateCount = 0;                             -- Number of items updated in this sync.
GRMsyncGlobals.updatesEach = { 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }; -- JoinDates , promotionDates, alts, customNote, bday , Ban, unban, banEdits

-- Tables to hold data in array format, sorted - to maintain compatibility with sync system with new data structures
GRMsyncGlobals.guildData = {};
GRMsyncGlobals.formerGuildData = {};
GRMsyncGlobals.guildAltData = {};

-- Refresh Frame Control for Audit
GRMsyncGlobals.refreshCount = 0;
GRMsyncGlobals.refreshCountTimer = 0;

-- Sync Queue
GRMsyncGlobals.WaitingInQue = true;
GRMsyncGlobals.WaitingInQueTimer = time();

-- Sync Tracking
GRMsyncGlobals.syncComplete = false;
GRMsyncGlobals.syncCompleteTimer = 0;
GRMsyncGlobals.TrackerData = {};
GRMsyncGlobals.syncFailed = false;
GRMsyncGlobals.trackerPoint = "";
GRMsyncGlobals.finishResetDelay = false;
GRMsyncGlobals.totalEstTime = 0;
GRMsyncGlobals.progStart = 0;

-- Tables of the changes -- Leader will collect and store them here from all players before broadcasting the changes out, and then resetting them.
-- By compiling all changes first, and THEN checking, it saves an insane amount of resources rather than passing on every new piece received.
GRMsyncGlobals.JDChanges = {};
GRMsyncGlobals.PDChanges = {};
GRMsyncGlobals.BanChanges = {};
GRMsyncGlobals.AltChangesNoGroup = {};
GRMsyncGlobals.AltChangesMainOnly = {};
GRMsyncGlobals.AltChangesFullGroup = {};
GRMsyncGlobals.CustomNoteChanges = {};
GRMsyncGlobals.BDayChanges = {};
GRMsyncGlobals.FinalAltListReceived = {};


-- Collected Tables of Data when received from the player
GRMsyncGlobals.JDReceivedNoDetailsTemp = {};
GRMsyncGlobals.PDReceivedNoDetailsTemp = {};
GRMsyncGlobals.AltReceivedNoDetailsTemp = {};
GRMsyncGlobals.CustReceivedNoDetailsTemp = {};
GRMsyncGlobals.BanReceivedNoDetailsTemp = {};
GRMsyncGlobals.BdayReceivedNoDetailsTemp = {};

GRMsyncGlobals.JDReceivedTemp = {};
GRMsyncGlobals.PDReceivedTemp = {};
GRMsyncGlobals.BanReceivedTemp = {};
GRMsyncGlobals.BanReceivedTemp2 = {};
GRMsyncGlobals.BanReceivedTempFinal = {};
GRMsyncGlobals.AltReceivedTemp = {};
GRMsyncGlobals.AltReceivedTemp.NoGroup = {};
GRMsyncGlobals.AltReceivedTemp.MainOnly = {};
GRMsyncGlobals.AltReceivedTemp.AltGroups = {};
GRMsyncGlobals.CustomNoteReceivedTemp = {};
GRMsyncGlobals.CustomNoteReceivedTemp2 = {};
GRMsyncGlobals.CustomNoteReceivedTempFinal = {};
GRMsyncGlobals.CustomNoteReceievedLiveTemp = {};
GRMsyncGlobals.BirthdayReceivedTemp = {};

-- Sync Integrity
GRMsyncGlobals.messageTree = {};                        -- Include the table of sent messages - if any messages lost they can be recalled here.
GRMsyncGlobals.messageTree.JD = {};
GRMsyncGlobals.messageTree.JDF = {};
GRMsyncGlobals.messageTree.PD = {};
GRMsyncGlobals.messageTree.PDF = {};
GRMsyncGlobals.messageTree.ALT = {};
GRMsyncGlobals.messageTree.ALTF = {};
GRMsyncGlobals.messageTree.CUST = {};
GRMsyncGlobals.messageTree.CUSTF = {};
GRMsyncGlobals.messageTree.BAN = {};
GRMsyncGlobals.messageTree.BANF = {};
GRMsyncGlobals.messageTree.BDAY = {};
GRMsyncGlobals.messageTree.BDAYF = {};
GRMsyncGlobals.messageIndexesReceived = {};             -- Include table of messages received. Array of ints.
GRMsyncGlobals.messageIndexesReceived.JD = {};
GRMsyncGlobals.messageIndexesReceived.JDF = {};
GRMsyncGlobals.messageIndexesReceived.PD = {};
GRMsyncGlobals.messageIndexesReceived.PDF = {};
GRMsyncGlobals.messageIndexesReceived.ALT = {};
GRMsyncGlobals.messageIndexesReceived.ALTF = {};
GRMsyncGlobals.messageIndexesReceived.CUST = {};
GRMsyncGlobals.messageIndexesReceived.CUSTF = {};
GRMsyncGlobals.messageIndexesReceived.BAN = {};
GRMsyncGlobals.messageIndexesReceived.BANF = {};
GRMsyncGlobals.messageIndexesReceived.BDAY = {};
GRMsyncGlobals.messageIndexesReceived.BDAYF = {};
GRMsyncGlobals.messageTree.JDFINAL = {};                -- Final sent messages stored
GRMsyncGlobals.messageTree.PDFINAL = {};
GRMsyncGlobals.messageTree.ALTFINAL = {};
GRMsyncGlobals.messageTree.CUSTFINAL = {};
GRMsyncGlobals.messageTree.BANFINAL = {};
GRMsyncGlobals.messageTree.BDAYFINAL = {};
GRMsyncGlobals.messageIndexesReceived.JDFINAL = {};     -- Final sent messages received
GRMsyncGlobals.messageIndexesReceived.PDFINAL = {};
GRMsyncGlobals.messageIndexesReceived.ALTFINAL = {};
GRMsyncGlobals.messageIndexesReceived.CUSTFINAL = {};
GRMsyncGlobals.messageIndexesReceived.BANFINAL = {};
GRMsyncGlobals.messageIndexesReceived.BDAYFINAL = {};
GRMsyncGlobals.MissingRequest = {};                     -- Stores indexes of the missing messages req
GRMsyncGlobals.MissingRequest.JDF = {};
GRMsyncGlobals.MissingRequest.JD = {};
GRMsyncGlobals.MissingRequest.PDF = {};
GRMsyncGlobals.MissingRequest.PD = {};
GRMsyncGlobals.MissingRequest.ALTF = {};
GRMsyncGlobals.MissingRequest.ALT = {};
GRMsyncGlobals.MissingRequest.CUSTF = {};
GRMsyncGlobals.MissingRequest.CUST = {};
GRMsyncGlobals.MissingRequest.BANF = {};
GRMsyncGlobals.MissingRequest.BAN = {};
GRMsyncGlobals.MissingRequest.BDAYF = {};
GRMsyncGlobals.MissingRequest.BDAY = {};
GRMsyncGlobals.MissingRequest.JDFINAL = {};
GRMsyncGlobals.MissingRequest.PDFINAL = {};
GRMsyncGlobals.MissingRequest.ALTFINAL = {};
GRMsyncGlobals.MissingRequest.CUSTFINAL = {};
GRMsyncGlobals.MissingRequest.BANFINAL = {};
GRMsyncGlobals.MissingRequest.BDAYFINAL = {};

-- Precheck Holder
GRMsyncGlobals.preCheckResult = {};
GRMsyncGlobals.FinalMsgCommCount = {};
GRMsyncGlobals.FinaBdayCommCount = {};

-- Live Alt Syn
GRMsyncGlobals.AltSyncReceived = {};

-- Prefixes for tagging info as it is sent and picked up across server channel to other players in guild.
-- To avoid prefix pollution, GRM will only create minimal prefix use, and then add a secondary prefix to be parsed at the head of the sent string.
GRMsyncGlobals.listOfPrefixes = {
    -- Core Sync Prefix.
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
        C_Timer.After ( 30 , function()           -- For some reason you can get disconnected shortly after loading screen as throttle is MUCH lower.
            GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
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
-- This throttles it down by 0.5 or it resets them. Weird anomaly but thoroughly tested
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
-- Purpose:         This is due to a cap of there being a tiny 4Kb/s otherwise a player disconnect, and also an interesting discovery of an enhanced throttle eveen
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
                GRMsyncGlobals.ThrottleCap = GRMsyncGlobals.normalMessage;
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
    GRMsyncGlobals.errorCheckEnabled = false;
end

-- Resetting after broadcasting the changes.
GRMsync.ResetReportTables = function()
    GRMsyncGlobals.JDChanges = {};
    GRMsyncGlobals.PDChanges = {};
    GRMsyncGlobals.BanChanges = {};
    GRMsyncGlobals.AltChangesNoGroup = {};
    GRMsyncGlobals.AltChangesMainOnly = {};
    GRMsyncGlobals.AltChangesFullGroup = {};
    GRMsyncGlobals.CustomNoteChanges = {};
    GRMsyncGlobals.BDayChanges = {};
    GRMsyncGlobals.FinalAltListReceived = {};
    GRMsyncGlobals.messageTree.JD = {};
    GRMsyncGlobals.messageTree.JDF = {};
    GRMsyncGlobals.messageTree.PD = {};
    GRMsyncGlobals.messageTree.PDF = {};
    GRMsyncGlobals.messageTree.ALT = {};
    GRMsyncGlobals.messageTree.ALTF = {};
    GRMsyncGlobals.messageTree.CUST = {};
    GRMsyncGlobals.messageTree.CUSTF = {};
    GRMsyncGlobals.messageTree.BAN = {};
    GRMsyncGlobals.messageTree.BANF = {};
    GRMsyncGlobals.messageTree.BDAY = {};
    GRMsyncGlobals.messageTree.BDAYF = {};
    GRMsyncGlobals.messageTree.JDFINAL = {};
    GRMsyncGlobals.messageTree.PDFINAL = {};
    GRMsyncGlobals.messageTree.ALTFINAL = {};
    GRMsyncGlobals.messageTree.CUSTFINAL = {};
    GRMsyncGlobals.messageTree.BANFINAL = {};
    GRMsyncGlobals.messageTree.BDAYFINAL = {};
    GRMsyncGlobals.messageIndexesReceived.JD = {};
    GRMsyncGlobals.messageIndexesReceived.JDF = {};
    GRMsyncGlobals.messageIndexesReceived.PD = {};
    GRMsyncGlobals.messageIndexesReceived.PDF = {};
    GRMsyncGlobals.messageIndexesReceived.ALT = {};
    GRMsyncGlobals.messageIndexesReceived.ALTF = {};
    GRMsyncGlobals.messageIndexesReceived.CUST = {};
    GRMsyncGlobals.messageIndexesReceived.CUSTF = {};
    GRMsyncGlobals.messageIndexesReceived.BAN = {};
    GRMsyncGlobals.messageIndexesReceived.BANF = {};
    GRMsyncGlobals.messageIndexesReceived.BDAY = {};
    GRMsyncGlobals.messageIndexesReceived.BDAYF = {};
    GRMsyncGlobals.messageIndexesReceived.JDFINAL = {};
    GRMsyncGlobals.messageIndexesReceived.PDFINAL = {};
    GRMsyncGlobals.messageIndexesReceived.ALTFINAL = {};
    GRMsyncGlobals.messageIndexesReceived.CUSTFINAL = {};
    GRMsyncGlobals.messageIndexesReceived.BANFINAL = {};
    GRMsyncGlobals.messageIndexesReceived.BDAYFINAL = {};
    GRMsyncGlobals.MissingRequest.JDF = {};
    GRMsyncGlobals.MissingRequest.JD = {};
    GRMsyncGlobals.MissingRequest.PDF = {};
    GRMsyncGlobals.MissingRequest.PD = {};
    GRMsyncGlobals.MissingRequest.ALTF = {};
    GRMsyncGlobals.MissingRequest.ALT = {};
    GRMsyncGlobals.MissingRequest.CUSTF = {};
    GRMsyncGlobals.MissingRequest.CUST = {};
    GRMsyncGlobals.MissingRequest.BANF = {};
    GRMsyncGlobals.MissingRequest.BAN = {};
    GRMsyncGlobals.MissingRequest.JDFINAL = {};
    GRMsyncGlobals.MissingRequest.PDFINAL = {};
    GRMsyncGlobals.MissingRequest.ALTFINAL = {};
    GRMsyncGlobals.MissingRequest.CUSTFINAL = {};
    GRMsyncGlobals.MissingRequest.BANFINAL = {};
    GRMsyncGlobals.MissingRequest.BDAYFINAL = {};
    GRMsyncGlobals.preCheckResult = {};
    GRMsyncGlobals.FinalMsgCommCount = {};
    GRMsyncGlobals.FinaBdayCommCount = {};
end

-- In case of mid-cycling reset, this resets all the temp tables.
GRMsync.ResetTempTables = function()
    GRMsyncGlobals.JDReceivedNoDetailsTemp = {};
    GRMsyncGlobals.PDReceivedNoDetailsTemp = {};
    GRMsyncGlobals.AltReceivedNoDetailsTemp = {};
    GRMsyncGlobals.CustReceivedNoDetailsTemp = {};
    GRMsyncGlobals.BanReceivedNoDetailsTemp = {};
    GRMsyncGlobals.BdayReceivedNoDetailsTemp = {};
    GRMsyncGlobals.JDReceivedTemp = {};
    GRMsyncGlobals.PDReceivedTemp = {};
    GRMsyncGlobals.BanReceivedTemp = {};
    GRMsyncGlobals.BanReceivedTemp2 = {};
    GRMsyncGlobals.BanReceivedTempFinal = {};
    GRMsyncGlobals.AltReceivedTemp.NoGroup = {};
    GRMsyncGlobals.AltReceivedTemp.MainOnly = {};
    GRMsyncGlobals.AltReceivedTemp.AltGroups = {};
    GRMsyncGlobals.CustomNoteReceivedTemp = {};
    GRMsyncGlobals.CustomNoteReceivedTemp2 = {};
    GRMsyncGlobals.CustomNoteReceivedTempFinal = {};
    GRMsyncGlobals.BirthdayReceivedTemp = {};
    GRMsyncGlobals.PreCheckHashValues = {};
    GRMsyncGlobals.DatabaseMarkers = {};
    GRMsyncGlobals.SyncPath = { false , false , false , false , false , false };
    GRMsyncGlobals.SyncProgress = { false , false , false , false , false , false , true };
    GRMsyncGlobals.updateCount = 0;
    GRMsyncGlobals.updatesEach = { 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 };

    -- Major data - by setting it to nil it wipese the whole memory reference, not just overwrites it. This can trigger
    -- the Blizz Lua built-in auto garbage collection sooner with that much data floating around with no memory reference to it.
    GRMsyncGlobals.guildData = nil;
    GRMsyncGlobals.formerGuildData = nil;
    GRMsyncGlobals.guildAltData = nil;
    GRMsyncGlobals.guildData = {};
    GRMsyncGlobals.formerGuildData = {};
    GRMsyncGlobals.guildAltData = {};
end

----------------------------------------
------- SYNC PROGRESS TRACKING ---------
----------------------------------------

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
    GRMsyncGlobals.SyncTracker.altData = false;
    GRMsyncGlobals.SyncTracker.customNotes = false;
    GRMsyncGlobals.SyncTracker.banData = false;
    GRMsyncGlobals.SyncTracker.compareAlts = false;
    GRMsyncGlobals.SyncTracker.finalJD = false;
    GRMsyncGlobals.SyncTracker.finalPD = false;
    GRMsyncGlobals.SyncTracker.finalAlts = false;
    GRMsyncGlobals.SyncTracker.finalCustom = false;
    GRMsyncGlobals.SyncTracker.finalBan = false;
    GRMsyncGlobals.SyncTracker.bdays = false;
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

    local syncOrder = { ["JD"] = 6 , ["PD"] = 7 , ["ALT"] = 8 , ["CUSTOMNOTE"] = 9 , ["BAN"] = 10 , ["COMPAREALTS"] = 11 , ["FINALJD"] = 12 , ["FINALPD"] = 13 ,  ["FINALALT"] = 14 , ["FINALCUSTOM"] = 15 , ["FINALBAN"] = 16 , ["BDAYS"] = 17 , ["FINALBDAYS"] = 18 , ["FINISH"] = 19 };

    local progress = {
        "TriggeringSync" ,
        "EstablishingLeader" ,
        "buildingHashes" ,
        "sendingHashes" ,
        "calculating" ,
        "jd" ,
        "pd" ,
        "alts" ,
        "customNotes" ,
        "banData" ,
        "compareAlts" ,
        "finalJD" ,
        "finalPD" ,
        "finalAlts" ,
        "finalCustom" ,
        "finalBan" ,
        "bdays" ,
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

-- -- Method:          GRMsync.CalculateTotalSyncVolume()
-- -- What it Does:    Calculates the sync data total number of items
-- -- Purpose:         To attempt to track the progress of the sync by giving weights to each type of data syncing.
-- GRMsync.CalculateTotalSyncVolume = function()
--     GRMsyncGlobals.SyncTracker.calculating = true;

--     local total = 0;
--     local result = {};
--     local initLength = 10;
--     local totalSeconds = 0;

--     for i = 1 , #GRMsyncGlobals.DatabaseExactIndexes do
--         if i == 3 then
--             total = total + ( #GRMsyncGlobals.DatabaseExactIndexes[i] * 3);
--         elseif i == 4 then
--             total = total + ( #GRMsyncGlobals.DatabaseExactIndexes[i] * 4);
--         elseif i == 6 then
--             total = total + ( #GRMsyncGlobals.DatabaseExactIndexes[i] * 2);
--         else
--             total = total + #GRMsyncGlobals.DatabaseExactIndexes[i];
--         end
--     end

--     result.JD = {};
--     result.PD = {};
--     result.ALT = {};
--     result.CUSTOMNOTE = {};
--     result.BDAY = {};
--     result.BAN = {};

--     -- Give weight to each section based on the total  #GRMsyncGlobals.DatabaseExactIndexes[1] / total = JD weight %
--     -- Also, each point is the finalDestination precent, so an accumulation of all previous -- The index 2 of the array is the total number ofitems. This will help estimate the time needed to sync this info.

--     if total ~= 0 then
--         if #GRMsyncGlobals.DatabaseExactIndexes[1] > 0 then
--             result.JD = { math.floor ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[1] / total ) * 100 ) + 0.5 ) , GRMsync.SyncTimeEstimation ( "JD" , #GRMsyncGlobals.DatabaseExactIndexes[1] ) , 0 };
--             if result.JD[1] > 0 and result.JD[1] < initLength then    -- Just for quality of life - can't have it go backwards in time.
--                 result.JD[1] = initLength;
--             end
--             result.JD[3] = totalSeconds + result.JD[2]      -- Position 3 helps mark where in passed time this percent should lie
--             totalSeconds = totalSeconds + result.JD[2];
--         else
--             result.JD = { 0 , 0 , totalSeconds };
--         end

--         if #GRMsyncGlobals.DatabaseExactIndexes[2] > 0 then
--             result.PD = { math.floor ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[2] / total ) * 100 ) + 0.5 ) + result.JD[1] , GRMsync.SyncTimeEstimation ( "PD" , #GRMsyncGlobals.DatabaseExactIndexes[2] ) , 0 };
--             if result.PD[1] > 0 and result.PD[1] < initLength then
--                 result.PD[1] = initLength;
--             end
--             result.PD[3] = totalSeconds + result.PD[2]
--             totalSeconds = totalSeconds + result.PD[2];
--         else
--             result.PD = { 0 , 0 , totalSeconds };
--         end

--         if #GRMsyncGlobals.DatabaseExactIndexes[3] > 0 then
--             result.ALT = { math.floor ( ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[3] * 3) / total ) * 100 ) + 0.5 ) + result.PD[1] , GRMsync.SyncTimeEstimation ( "ALT" , #GRMsyncGlobals.DatabaseExactIndexes[3] ) , 0 };
--             if result.ALT[1] > 0 and result.ALT[1] < initLength then
--                 result.ALT[1] = initLength;
--             end
--             result.ALT[3] = totalSeconds + result.ALT[2]
--             totalSeconds = totalSeconds + result.ALT[2];
--         else
--             result.ALT = { 0 , 0 , totalSeconds };
--         end

--         if #GRMsyncGlobals.DatabaseExactIndexes[4] > 0 then
--             result.CUSTOMNOTE = { math.floor ( ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[4] * 4) / total ) * 100 ) + 0.5 ) + result.PD[1] , GRMsync.SyncTimeEstimation ( "CUSTOMNOTE" , #GRMsyncGlobals.DatabaseExactIndexes[4] ) , 0 };
--             if result.CUSTOMNOTE[1] > 0 and result.CUSTOMNOTE[1] < initLength then
--                 result.CUSTOMNOTE[1] = initLength;
--             end
--             result.CUSTOMNOTE[3] = totalSeconds + result.CUSTOMNOTE[2]
--             totalSeconds = totalSeconds + result.CUSTOMNOTE[2];
--         else
--             result.CUSTOMNOTE = { 0 , 0 , totalSeconds };
--         end

--         if #GRMsyncGlobals.DatabaseExactIndexes[6] > 0 then
--             result.BAN = { math.floor ( ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[6] * 3 ) / total ) * 100 ) + 0.5 ) + result.CUSTOMNOTE[1] , GRMsync.SyncTimeEstimation ( "BAN" , #GRMsyncGlobals.DatabaseExactIndexes[6] ) , 0 };
--             if result.BAN[1] > 0 and result.BAN[1] < initLength then
--                 result.BAN[1] = initLength;
--             end
--             result.BAN[3] = totalSeconds + result.BAN[2]
--             totalSeconds = totalSeconds + result.BAN[2];
--         else
--             result.BAN = { 0 , 0 , totalSeconds };
--         end

--         if #GRMsyncGlobals.DatabaseExactIndexes[5] > 0 then
--             result.BDAY = { math.floor ( ( ( #GRMsyncGlobals.DatabaseExactIndexes[5] / total ) * 100 ) + 0.5 ) + result.BAN[1] , GRMsync.SyncTimeEstimation ( "BDAY" , #GRMsyncGlobals.DatabaseExactIndexes[5] ) , 0 };

--             result.BDAY[3] = totalSeconds + result.BDAY[2]
--             totalSeconds = totalSeconds + result.BDAY[2];
--         else
--             result.BDAY = { 0 , 0 , totalSeconds };
--         end

--     end

--     return result , totalSeconds;
-- end

-- -- Method:          GRMsync.SendTrackerCalculation()
-- -- What it Does:    Sends over the calculated tracker data points for progress bar.
-- -- Purpose:         To ensure both sync players' progress bar alligns, as well as the fact that the non Sync Leader calculates this all whilst the syncer just sends their data over. This ensures that the sync leader has calculated progression timers as well.
-- GRMsync.SendTrackerCalculation = function()
--     local result = "";

--     -- JD
--     result = GRMsyncGlobals.TrackerData.JD[1] .. "?" .. GRMsyncGlobals.TrackerData.JD[2] .."?" .. GRMsyncGlobals.TrackerData.JD[3] .. "?";

--     -- PD
--     result = result .. GRMsyncGlobals.TrackerData.PD[1] .. "?" .. GRMsyncGlobals.TrackerData.PD[2] .. "?" .. GRMsyncGlobals.TrackerData.PD[3] .. "?";

--     -- ALT
--     result = result .. GRMsyncGlobals.TrackerData.ALT[1] .. "?" .. GRMsyncGlobals.TrackerData.ALT[2] .. "?" .. GRMsyncGlobals.TrackerData.ALT[3] .. "?";

--     -- CUSTOMNOTE
--     result = result .. GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] .. "?" .. GRMsyncGlobals.TrackerData.CUSTOMNOTE[2] .. "?" .. GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] .. "?";

--     -- BDAY
--     result = result .. GRMsyncGlobals.TrackerData.BDAY[1] .. "?" .. GRMsyncGlobals.TrackerData.BDAY[2] .. "?" .. GRMsyncGlobals.TrackerData.BDAY[3] .. "?";

--     -- BAN
--     result = result .. GRMsyncGlobals.TrackerData.BAN[1] .. "?" .. GRMsyncGlobals.TrackerData.BAN[2] .. "?" .. GRMsyncGlobals.TrackerData.BAN[3] .. "?";

--     result = result .. GRMsyncGlobals.totalEstTime;

--     local msg = "GRM_TRACKER?" .. GRM.S().syncRank .. "?" .. result;

--     GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
--     GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.DesignatedLeader );
-- end

-- Method:          GRMsync.InitializeTrackerData()
-- What it Does:    Initializes the tables
-- Purpose:         Compartmentalize this reusable reset.
GRMsync.InitializeTrackerData = function()
    GRMsyncGlobals.TrackerData.JD = {};
    GRMsyncGlobals.TrackerData.PD = {};
    GRMsyncGlobals.TrackerData.ALT = {};
    GRMsyncGlobals.TrackerData.CUSTOMNOTE = {};
    GRMsyncGlobals.TrackerData.BDAY = {};
    GRMsyncGlobals.TrackerData.BAN = {};
end

-- Method:          GRMsync.ParseComMsg ( msg )
-- What it Does:    Returns the matches to the given pattern
-- Purpose:         More easily manage comm messages cleaner.
GRMsync.ParseComMsg = function ( msg , pattern )
    return string.match ( msg , pattern );
end

-- -- Method:          GRMsync.CollectTrackerCalculation ( string )
-- -- What it Does:    Parses the given messages and saves them to the tracker data table
-- -- Purpose:         Ensure sync progress is unified between 2 players.
-- GRMsync.CollectTrackerCalculation = function ( msg )
--     GRM_G.MatchPattern19 = GRM_G.MatchPattern19 or GRM.BuildComPattern ( 19 , "?" , false );

--     GRMsync.InitializeTrackerData();

--     GRMsyncGlobals.TrackerData.JD[1] , GRMsyncGlobals.TrackerData.JD[2] , GRMsyncGlobals.TrackerData.JD[3] , GRMsyncGlobals.TrackerData.PD[1] , GRMsyncGlobals.TrackerData.PD[2] , GRMsyncGlobals.TrackerData.PD[3] , GRMsyncGlobals.TrackerData.ALT[1] , GRMsyncGlobals.TrackerData.ALT[2] , GRMsyncGlobals.TrackerData.ALT[3] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[2] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] , GRMsyncGlobals.TrackerData.BDAY[1] , GRMsyncGlobals.TrackerData.BDAY[2] , GRMsyncGlobals.TrackerData.BDAY[3] , GRMsyncGlobals.TrackerData.BAN[1] , GRMsyncGlobals.TrackerData.BAN[2] , GRMsyncGlobals.TrackerData.BAN[3] , GRMsyncGlobals.totalEstTime = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern19 );  -- Ban needs to be pared when added.

--     for _ , y in pairs ( GRMsyncGlobals.TrackerData ) do
--         for i = 1 , #y do
--             y[i] = tonumber ( y[i] );
--         end
--     end

--     GRMsyncGlobals.totalEstTime = tonumber ( GRMsyncGlobals.totalEstTime );

-- end

-- Method:          GRMsync.SyncTimeEstimation ( string , int )
-- What it Does:    Calculates the time per block to sync
-- Purpose:         For relatively accurate sync tracker reporting.
GRMsync.SyncTimeEstimation = function ( dataType , total )
    local seconds = 0;

    if dataType == "JD" or dataType == "PD" or dataType == "BDAY" then

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
        "customNotes" ,
        "banData" ,
        "compareAlts" ,
        "finalJD" ,
        "finalPD" ,
        "finalAlts" ,
        "finalCustom" ,
        "finalBan" ,
        "bdays" ,
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
                GRM.SlashCommandSync();
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

    if GRMsyncGlobals.currentlySyncing then
        -- Logic to exit a sync faster if someone goes offline
        if GRMsyncGlobals.SyncOK then
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
        GRMsync.InitializeRankRestrictionCheck();
        GRMsync.SendMessage ( "GRM_SYNC" , "GRM_WHOISLEADER?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. tostring ( GRM.S().syncRank ) .. "?" .. tostring ( GRMsyncGlobals.syncRankFilter ) .. "?" .. tostring ( GRM.S().syncRankCustom ) , GRMsyncGlobals.channelName );
    end

end

-- Method:          GRMsync.LeaderRespond ( string )
-- What it Does:    The new leader will respond out "I AM LEADER" and everyone set him as leader.
-- Purpose:         Sync leadership controls. Election should happen each time for optimal sync leader this is why it is ONLY default if the person is already syncing and you are just adding them to sync que.
GRMsync.LeaderRespond = function ( msg )

    GRM_G.MatchPattern4 = GRM_G.MatchPattern4 or GRM.BuildComPattern ( 4 , "?" , false );
    local banRankRestriction , maxRankRestriction , syncRankRestriction , customRankRestriction = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern4 );

    -- If someone is a leader already, and they are syncing, you don't want to interrupt that.
    if GRMsyncGlobals.currentlySyncing and GRMsyncGlobals.IsElectedLeader then

        GRMsyncGlobals.DesignatedLeader = GRM_G.addonUser;
        GRMsyncGlobals.IsElectedLeader = true
        GRMsyncGlobals.IsLeaderRequested = true;
        GRMsyncGlobals.LeadershipEstablished = true;
        GRMsyncGlobals.ElectionProcessing = false;

        if GRMsyncGlobals.SyncOK then
            GRMsync.InitializeRankRestrictionCheck();
            local msg = "GRM_IAMLEADER?" .. GRM.S().syncRank .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. tostring ( GRM.S().syncRank ) .. "?" .. tostring ( GRMsyncGlobals.syncRankFilter ) .. "?" .. tostring ( GRM.S().syncRankCustom );
            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
            GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.channelName );
        end
    elseif not GRMsyncGlobals.currentlySyncing then
        GRMsyncGlobals.senderBanRankReq = tonumber ( banRankRestriction );
        GRMsyncGlobals.senderMaxRankReq = tonumber ( maxRankRestriction );
        GRMsyncGlobals.senderRankRequirement = tonumber ( syncRankRestriction );
        GRMsyncGlobals.senderCustRankReq = tonumber ( customRankRestriction );
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
    local syncRankRestriction = 0;
    local syncMaxRestriction = 0;
    local customRankRestriction = 0;

    if GRM.TableLength ( GRMsyncGlobals.ElectTimeOnlineTable ) > 0 then
        local c = 1;

        for name , data in pairs ( GRMsyncGlobals.ElectTimeOnlineTable ) do
            if c == 1 then
                highestName = name;
                highestTime = data[1];
                topRank = data[2];
                banRankRestriction = data[3];
                syncMaxRestriction = data[4]
                syncRankRestriction = data[5];
                customRankRestriction = data[6];
                c = c + 1;
            end

            if data[2] < topRank or ( data[2] == topRank and data[1] < highestTime ) then -- Higher guild rank (lower index), or if same rank, who was on the longest - less means on longer
                highestName = name;
                highestTime = data[1]
                topRank = data[2];
                banRankRestriction = data[3];
                syncMaxRestriction = data[4]
                syncRankRestriction = data[5];
                customRankRestriction = data[6];

            end
        end

        GRMsync.InitializeRankRestrictionCheck();
        local rankString = banRankRestriction .. "?" .. syncMaxRestriction .. "?" .. syncRankRestriction .. "?" .. customRankRestriction;
        -- Send Message out
        if GRMsyncGlobals.SyncOK then
            GRMsync.SendMessage ( "GRM_SYNC" , "GRM_NEWLEADER?" .. GRM.S().syncRank .. "?" .. highestName .. "?" .. rankString , GRMsyncGlobals.channelName );
        end
        -- Establishing leader.
        C_Timer.After ( 0.5 , function()
            GRMsync.SetLeader ( highestName , true , rankString );
        end);

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
        GRMsync.SendMessage ( "GRM_SYNC" , "GRM_ELECT?" .. GRM.S().syncRank .. "?" .. "" , GRMsyncGlobals.channelName );
    end
    -- Let's give it a time delay to receive responses. 3 seconds.
    C_Timer.After ( 2.5 , GRMsync.ReviewElectResponses );
end

-- Method:          GRMsync.SendElectionInfo()
-- What it Does:    Sends the time logged in or addon sync was enabled
-- Purpose:         For voting, to determine who was online the longest.
GRMsync.SendElectionInfo = function()
    if not GRMsyncGlobals.ElectionProcessing then
        if GRMsyncGlobals.SyncOK then
            GRMsync.InitializeRankRestrictionCheck();
            GRMsync.SendMessage ( "GRM_SYNC" , "GRM_ELECTINFO?" .. GRM.S().syncRank .. "?" .. GRM_G.addonUser .. "?" .. tostring ( GRMsyncGlobals.timeAtLogin ) .. "?" .. tostring ( GRM.GetPlayer ( GRM_G.addonUser ).rankIndex ) .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. tostring ( GRM.S().syncRank ) .. "?" .. tostring ( GRMsyncGlobals.syncRankFilter ) .. "?" .. tostring ( GRM.S().syncRankCustom ) , GRMsyncGlobals.channelName );
        end
    end
end

-- Method:          GRMsync.RegisterTimeStamps( string )
-- What it Does:    Adds the player's name and timestamp for election
-- Purpose:         Need to aggregate all the player data for voting!
GRMsync.RegisterTimeStamps = function ( msg )
    -- Adding { timestamp , name } to the list of people giving their time... 3 second response time valid only.
    GRM_G.MatchPattern7 = GRM_G.MatchPattern7 or GRM.BuildComPattern ( 7 , "?" , false );
    local name , timeAtLogin , rankIndex , banRankRestriction , maxRankRestriction , syncRankRestriction , customRankRestriction = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern7 );

    GRMsyncGlobals.ElectTimeOnlineTable[name] = { tonumber ( timeAtLogin ) , tonumber ( rankIndex ) , tonumber ( banRankRestriction ) , tonumber ( maxRankRestriction ) , tonumber ( syncRankRestriction ) , tonumber ( customRankRestriction ) };
end

-- Method:          GRMsync.ElectedLeader ( string )
-- What it Does:    Established the elected leader based on message received.
-- Purpose:         Final step in designating a leader!
GRMsync.ElectedLeader = function ( msg )
    -- Message should just be the name, so no need to parse.
    GRM_G.MatchPattern5 = GRM_G.MatchPattern5 or GRM.BuildComPattern ( 5 , "?" , false );
    local leader , banRankRestriction , maxRankRestriction , syncRankRestriction , customRankRestriction = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern5 );
    GRMsyncGlobals.senderBanRankReq = tonumber ( banRankRestriction );
    GRMsyncGlobals.senderMaxRankReq = tonumber ( maxRankRestriction );
    GRMsyncGlobals.senderRankRequirement = tonumber ( syncRankRestriction );
    GRMsyncGlobals.senderCustRankReq = tonumber ( customRankRestriction );

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
        -- GRMsyncGlobals.SyncTracker.EstablishingLeader = true;

        GRMsyncGlobals.InitializeTime = time();
        -- "Who is the leader?"
        if not GRMsyncGlobals.IsLeaderRequested then
            GRMsync.InquireLeader();
        end

        C_Timer.After ( 2.5 , function ()
            -- No responses, no leader! Setup an election for the leader!
            if not GRMsyncGlobals.LeadershipEstablished then
                GRMsync.RequestElection();
            else
                if GRMsyncGlobals.DesignatedLeader ~= GRM_G.addonUser then
                    GRMsyncGlobals.LeadSyncProcessing = false;

                    GRMsync.SendMessage ( "GRM_SYNC" , "GRM_REQUESTSYNC?" .. GRM.S().syncRank .. "?" .. "" , GRMsyncGlobals.DesignatedLeader );

                    if not GRMsyncGlobals.StartMessage then
                        GRMsync.SyncTriggerMessage ( GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader ) );
                    end
                end
            end

        end);
    end
end

-- Method:          GRMsync.SetLeader ( string , bool , string )
-- What it Does:    If message received, designates the sender as the leader
-- Purpose:         Need to designate a leader!
GRMsync.SetLeader = function ( leader , initiateSync , msg )
    GRM_G.MatchPattern4 = GRM_G.MatchPattern4 or GRM.BuildComPattern ( 4 , "?" , false );
    local banRankRestriction , maxRankRestriction , syncRankRestriction , customRankRestriction = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern4 );
    GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;

    GRMsyncGlobals.DesignatedLeader = leader;
    GRMsyncGlobals.LeadershipEstablished = true;
    GRMsyncGlobals.ElectionProcessing = false;
    -- GRMsyncGlobals.SyncTracker.EstablishingLeader = true;

    if banRankRestriction then
        GRMsyncGlobals.senderBanRankReq = tonumber ( banRankRestriction );
    end

    if syncRankRestriction then
        GRMsyncGlobals.senderRankRequirement = tonumber ( syncRankRestriction );
    end

    if maxRankRestriction then
        GRMsyncGlobals.senderMaxRankReq = tonumber ( maxRankRestriction );
    end

    if customRankRestriction then
        GRMsyncGlobals.senderCustRankReq = tonumber ( customRankRestriction );
    end

    if initiateSync then
        if leader ~= GRM_G.addonUser then
            GRMsyncGlobals.IsElectedLeader = false;
            -- Non leader sends request to sync
            if GRMsyncGlobals.SyncOK and ( GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() ) then
                GRMsyncGlobals.LeadSyncProcessing = false;
                GRMsync.SendMessage ( "GRM_SYNC" , "GRM_REQUESTSYNC?" .. GRMsyncGlobals.syncRankFilter .. "?" , GRMsyncGlobals.DesignatedLeader );

                if not GRMsyncGlobals.StartMessage then
                    GRMsync.SyncTriggerMessage ( GRM.GetClassifiedName ( GRMsyncGlobals.DesignatedLeader ) );
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
            -- table.insert ( GRMsyncGlobals.SyncQue , sender );
            C_Timer.After ( 1 , GRMsync.InitiateDataSync );
        end
    end
end

------------------
-- END ELECTION --
------------------


-- Method:          GRMsync.TriggerChatThrottleDelay()
-- What it Does:    If it detects that the ChatThrottleLib Ace library ques up messages, GRM will delay its own message sending for a minimum of 1 second
-- Purpose:         Since syncing data on guild member info is not high priority over most other addons, this ensures that Ace library sync data always is --                  prioritized. Their own internal delay is 0.8 seconds, so by force a 1 second delay in GRM by putting my data at cap, it ensures their
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
            if time() - GRMsyncGlobals.ChatThrottleDelay >= 2 then

                GRMsync.TriggerChatThrottleDelay();
                GRMsyncGlobals.ChatThrottleDelay = time();
            end
        end);
    end

end

-- Method:          GRMsync.SyncTriggerMessage( string )
-- What it Does:    Triggers just the message
-- Purpose:         Easy reporting start of sync process after leader election.
GRMsync.SyncTriggerMessage = function ( name )
   GRMsyncGlobals.StartMessage = true;
    if not GRMsyncGlobals.syncTempDelay then
        GRMsync.InitializeRankRestrictionCheck();
        -- GRMsyncGlobals.SyncTracker.TriggeringSync = true;
        -- GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Currently Syncing With: {name}" , name ) );

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

-- Method:          GRMsync.CheckJoinDateChange ( string/table , string , string  )
-- What it Does:    Parses the details of the message to be usable, and then uses that info to see if it is different than current info, and if it is, then enacts changes.
-- Purpose:         To sync player join dates properly.
GRMsync.CheckJoinDateChange = function( msg , sender , prefix )
    -- To avoid spamminess
    local isSyncUpdate = false;
    if prefix == "GRM_JDSYNCUP" then
        isSyncUpdate = true;
    end

    local playerName = "";
    local standardDate = "";
    local epochTimeOfChange = 0;
    local indReceived;

    if type ( msg ) == "table" then
        playerName = msg[1];
        standardDate = msg[2];
        epochTimeOfChange = msg[3];

    else

        if isSyncUpdate then
            msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
            table.insert ( GRMsyncGlobals.messageIndexesReceived.JDFINAL , tonumber ( indReceived ) );
        end

        GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );

        playerName , standardDate , epochTimeOfChange = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern3 );

    end

    -- set the timestamp
    local day , month , year = GRM.ParseStandardFormatDate ( standardDate );
    local player = GRM.GetPlayer ( playerName );

    if player then

        epochTimeOfChange = tonumber ( epochTimeOfChange );
        -- Let's see if there was a change
        if day ~= 0 and ( player.joinDateHist[1][5] <= epochTimeOfChange or not player.joinDateHist[1][6] ) then

            player.joinDateHist[1][1] = day;
            player.joinDateHist[1][2] = month;
            player.joinDateHist[1][3] = year;
            player.joinDateHist[1][4] = standardDate;
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
            if GRM_UI.GRM_MemberDetailMetaData and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == playerName then
                GRM.PopulateMemberDetails ( GRM_G.currentName );
            end

            if not isSyncUpdate then
                GRM_UI.RefreshSelectFrames ( false , true , false , false , true , true );
            end
        end
    end
end

-- Method           GRMsync.CheckPromotionDateChange ( string/table , string , string )
-- What it Does:    Checks if received info is different than current, then updates it
-- Purpose:         Data sharing between guildies carrying the addon
GRMsync.CheckPromotionDateChange = function ( msg , sender , prefix )
    -- To avoid spamminess
    local isSyncUpdate = false;
    if prefix == "GRM_PDSYNCUP" then
        isSyncUpdate = true;
    end

    local playerName = "";
    local standardDate = "";
    local epochTimeOfChange = 0;
    local indReceived;

    if type ( msg ) == "table" then
        playerName = msg[1];
        standardDate = msg[2];
        epochTimeOfChange = msg[3];
    else

        if isSyncUpdate then
            msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
            table.insert ( GRMsyncGlobals.messageIndexesReceived.PDFINAL , tonumber ( indReceived ) );
        end

        GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
        playerName , standardDate , epochTimeOfChange  = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern3 );
    end

    local player = GRM.GetPlayer ( playerName );
    local day , month , year = GRM.ParseStandardFormatDate ( standardDate );

    if player then

        epochTimeOfChange = tonumber ( epochTimeOfChange );

        if day ~= 0 and ( player.rankHist[1][6] <= epochTimeOfChange or not player.rankHist[1][7] ) then -- Overwrite it if note verified
            player.rankHist[1][2] = day;  -- day
            player.rankHist[1][3] = month;  -- month
            player.rankHist[1][4] = year;  -- year
            player.rankHist[1][5] = standardDate;
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
                GRM.PopulateMemberDetails ( GRM_G.currentName );
            end

            if not isSyncUpdate then
                GRM_UI.RefreshSelectFrames ( false , true , false , false , true , true );
            end

        end
    end
end

-- Method:          GRMsync.EventAddedToCalendarCheck ( string , string )
-- What it Does:    Checks to see if player has the event already in que. If it is, then remove it.
-- Purpose:         Cleanliness. If it is removed from one person's list, it is removed from all!
GRMsync.EventAddedToCalendarCheck = function ( msg , sender )

    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local name , title , index = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern3 );
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

-- Method:          GRMsync.CheckFinalAltMainAndNotGroupChanges ( string or table , string , bool )
-- What it Does:    Sets the alt data properly.
-- Purpose:         Properly configure alt and main status.
GRMsync.CheckFinalAltMainAndNotGroupChanges = function ( msg , prefix , myData )
    local name = "";
    local timeModified = 0;
    local indReceived = 0;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    if myData then
        name = msg[1];
        timeModified = msg[2];
    else
        GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
        name , timeModified , indReceived = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern3 );
        timeModified = tonumber ( timeModified );
        table.insert ( GRMsyncGlobals.messageIndexesReceived.ALTFINAL , tonumber ( indReceived ) );
    end

    if prefix == "GRM_ALTSYNCUP1" then

        -- If they are a main then remove them from being main
        GRM.RemovePlayerFromAltGroup ( name , timeModified , false , false , true );
        GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
        GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;

    elseif prefix == "GRM_ALTSYNCUP2" then

        GRM.RemovePlayerFromAltGroup ( name , 0 , true , false , true );        -- Remove from alt group, preserve main status. If you were not already a main this will resolve that.
        GRM.SetMain ( name , timeModified );
        GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
        GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;

    end
end

-- Method:          GRMsync.CheckFinalAltFullGroupChanges ( string/table , string , int , bool )
-- What it Does:    Collects the final alt data
-- Purpose:         Sync data integrity
GRMsync.CheckFinalAltFullGroupChanges = function ( msg , prefix , numAlts , myData )

    local name = "";
    local main = "";
    local timeModified = 0;
    local indReceived = 0;

    -- if not GRMsyncGlobals.SyncTracker.altData then
    --     GRMsyncGlobals.ProgressControl ( "ALT" );
    -- end

    if prefix == "GRM_ALTSYNCUP3" then

        if myData then
            name = msg[1];
            main = msg.main;
            timeModified = msg.timeModified;
        else
            GRM_G.MatchPattern5 = GRM_G.MatchPattern5 or GRM.BuildComPattern ( 5 , "?" , false );
            name , main , timeModified , numAlts , indReceived = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern5 );
            timeModified = tonumber ( timeModified );
            numAlts = tonumber ( numAlts );
            table.insert ( GRMsyncGlobals.messageIndexesReceived.ALTFINAL , tonumber ( indReceived ) );
        end

        GRMsyncGlobals.FinalAltListReceived[name] = {};
        GRMsyncGlobals.FinalAltListReceived[name].alts = {};
        GRMsyncGlobals.FinalAltListReceived[name].main = main;
        GRMsyncGlobals.FinalAltListReceived[name].timeModified = timeModified;
        GRMsyncGlobals.FinalAltListReceived[name].numAlts = numAlts;

    elseif prefix == "GRM_ALTSYNCUP4" then
        local alts = {};

        if myData then
            alts = msg;
            name = msg[1];
        else

            -- Add the message index received
            msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
            name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
            msg = GRM.Next ( msg );

            -- Only add it to received IF the prior message was added, that way both can be NOT received to be re-sent.
            if GRMsyncGlobals.FinalAltListReceived[name] then
                table.insert ( GRMsyncGlobals.messageIndexesReceived.ALTFINAL , tonumber ( indReceived ) );
                alts = GRMsync.ParseAllSeparatedItems ( msg , "?" );
            end
        end

        if GRMsyncGlobals.FinalAltListReceived[name] then

            for i = 1 , #alts do
                if alts[i] ~= name then
                    table.insert ( GRMsyncGlobals.FinalAltListReceived[name].alts , alts[i] );
                end
            end

            sort(GRMsyncGlobals.FinalAltListReceived[name].alts);
        end
    end

end

-- Method:          GRMsync.CheckAddAltChange ( string , string )
-- What it Does:    Adds the alt as well to your list, if it is not already added
-- Purpose:         Additional chcecks required to avoid message spamminess, but basically to sync alt lists on adding.
GRMsync.CheckAddAltChange = function ( msg , sender )

    local altData = GRMsync.ParseAllSeparatedItems ( msg );
    local headerTag = altData[1];
    local leadName = altData[2];
    local main = "";
    local numAlts = 0;
    local index = 0;

    if headerTag == "S" then
        if altData[3] ~= "#" then
            main = altData[3];
        end

        timestamp = tonumber ( altData[4] );
        GRMsyncGlobals.AltSyncReceived[leadName] = nil; -- Wipe the old from memory
        GRMsyncGlobals.AltSyncReceived[leadName] = {};
        GRMsyncGlobals.AltSyncReceived[leadName].main = main;
        GRMsyncGlobals.AltSyncReceived[leadName].timeModified = tonumber ( altData[4] );
        GRMsyncGlobals.AltSyncReceived[leadName].numAlts = tonumber ( altData[5] );
        GRMsyncGlobals.AltSyncReceived[leadName].nameToAdd = altData[6];
        GRMsyncGlobals.AltSyncReceived[leadName].currentName = altData[7];
        index = 8;

    elseif headerTag == "##" then   -- This table doesn't have all of the same
        index = 3;
    end

    if GRMsyncGlobals.AltSyncReceived[leadName] then

        for i = index , #altData do
            if altData[i] ~= "X" then
                table.insert ( GRMsyncGlobals.AltSyncReceived[leadName] , altData[i] );
            else
                -- At the end... if at the end, let's do work
                table.insert ( GRMsyncGlobals.AltSyncReceived[leadName] , leadName );       -- Add the lead name to the table.
                sort(GRMsyncGlobals.AltSyncReceived[leadName]);

                -- NOW, we process the changes!!!
                if GRMsync.IsAltGroupSameExceptToonToAdd ( GRMsyncGlobals.AltSyncReceived[leadName] ) then

                    local playerToAdd = GRM.GetPlayer( GRMsyncGlobals.AltSyncReceived[leadName].nameToAdd );
                    local playerInGroup = GRM.GetPlayer( GRMsyncGlobals.AltSyncReceived[leadName][1] );

                    if playerToAdd and playerInGroup then
                        GRM.AddPlayerToAltGroup ( playerToAdd , playerInGroup.altGroup , GRMsyncGlobals.AltSyncReceived[leadName].timeModified , ( GRMsyncGlobals.AltSyncReceived[leadName].nameToAdd == GRMsyncGlobals.AltSyncReceived[leadName].main ) , true )

                        if GRM.S().syncChatEnabled then
                            GRM.Report ( GRM.L ( "{name} added {name2} to {custom1}'s list of Alts." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( GRMsyncGlobals.AltSyncReceived[leadName].nameToAdd , true ) , nil , GRM.GetClassifiedName ( GRMsyncGlobals.AltSyncReceived[leadName].currentName , true ) ) );
                        end

                    end
                else
                    -- Add player back to table.
                    table.insert ( GRMsyncGlobals.AltSyncReceived[leadName] , GRMsyncGlobals.AltSyncReceived[leadName].nameToAdd );
                    sort ( GRMsyncGlobals.AltSyncReceived[leadName] );

                    GRMsync.ProcessFullAltGroupChange ( leadName , GRMsyncGlobals.AltSyncReceived[leadName] );

                    if GRM.S().syncChatEnabled then
                        GRM.Report ( GRM.L ( "{name} updated {name2}'s list of Alts." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( GRMsyncGlobals.AltSyncReceived[leadName].currentName , true ) ) );
                    end

                    -- Clear it from memory
                    GRMsyncGlobals.AltSyncReceived[leadName] = nil;
                end
                -- REFRESH THE UI
                GRM_UI.RefreshSelectFrames ( false , true , false , false , true , true , true );
            end
        end
    end
end

-- Method:          GRMsync.IsAltGroupSameExceptToonToAdd ( altTable )
-- What it Does:    Checks if an alt group is the same. IF an alt group is the same, then it just adds the player to that alt group
-- Purpose:         The other method of rebuilding a new alt group from scratch, if the alt groups are very dividied is much more work than just adding 1 toon.
GRMsync.IsAltGroupSameExceptToonToAdd = function ( newAltGroup )

    -- Now, remove the name to be added. This will make the alt groups to be aligned if the same
    for i = 1 , #newAltGroup do
        if newAltGroup[i] == newAltGroup.nameToAdd then
            table.remove ( newAltGroup , i );
            break;
        end
    end

    local currentAltGroup = GRM.GetAltGroup ( GRM.GetPlayer( newAltGroup[1] ).altGroup );
    if currentAltGroup then
        sort ( currentAltGroup , function ( a , b ) return a.name < b.name end );

        -- Before looping through, we can quickly determine these are NOT aligned if size is different.
        if #newAltGroup == #currentAltGroup then

            for i = 1 , #newAltGroup do
                if newAltGroup[i] ~= currentAltGroup[i].name then       -- Do not need to do nested for loop since both tables same length and sorted, so should be in same position
                    return false;
                end
            end
            -- If you got to the end here, then you can return true;
            return true;
        end
    end
    return false;
end

-- Method:          GRMsync.ProcessFullAltGroupChange ( string , table )
-- What it Does:    Determines exactly the details of the alt group and sets them properly
-- Purpose:         Ensure accuracy of sync'd alt groups.
GRMsync.ProcessFullAltGroupChange = function ( leadName , finalAltGroup )
    local guildData = GRM.GetGuild();           -- Use current guild, not preliminary sync guild data as it will be updated
    local currentAltGroup;
    local player;
    local groupID = "";

    currentAltGroup = GRM.GetAltGroup ( guildData[leadName].altGroup );

    -- VERIFICATION CHECK TO PREVENT ERRORS
    if currentAltGroup then
        if not GRM.IsPlayerInAltGroup( guildData[leadName].altGroup , leadName ) then
            -- Problem here... player has an altGroup data point, but player is NOT in the alt Group.
            if #currentAltGroup == 0 then
                -- REMOVE ALT GROUP COMPLETELY
                GRM.RemoveAltGroup ( guildData[leadName].altGroup , 0 );
            end

            guildData[leadName].altGroup = "";
            currentAltGroup = nil;
        end
    end

    if currentAltGroup then
        GRM.RemovePlayerFromAltGroup ( leadName , 0 , false , false , true );
        GRM.CreateAltGroup ( leadName , ( finalAltGroup.main == leadName ) , finalAltGroup.timeModified );
        groupID = guildData[leadName].altGroup;

        for i = 2 , #finalAltGroup do
            player = GRM.GetPlayer ( finalAltGroup[i] )
            GRM.RemovePlayerFromAltGroup ( finalAltGroup[i] , 0 , false , false , true );
            GRM.AddPlayerToAltGroup ( player , groupID , finalAltGroup.timeModified , ( finalAltGroup.main == finalAltGroup[i] ) );

        end
    else
        -- If not already in an alt group, then all I need to do is create the alt group
        -- After creating, then cycle through all names in alts and add them.
        GRM.CreateAltGroup ( leadName , ( finalAltGroup.main == leadName ) , finalAltGroup.timeModified ); -- name , setAsMain , epochTimeStamp
        groupID = guildData[leadName].altGroup;

        for i = 2 , #finalAltGroup do   -- Lead name at position 1, so we can skip
            GRM.RemovePlayerFromAltGroup ( finalAltGroup[i] , 0 , false , false , true ); -- need to remove in case they are a main, as it messes with the add alt logic.
            player = GRM.GetPlayer ( finalAltGroup[i] )
            GRM.AddPlayerToAltGroup ( player , groupID , finalAltGroup.timeModified , ( finalAltGroup.main == finalAltGroup[i] ) );
        end
    end
end

-- Method:          GRMsync.CheckRemoveAltChange ( string , string , string )
-- What it Does:    Syncs the removal of an alt between all ONLINE players
-- Purpose:         Sync data between online players.
GRMsync.CheckRemoveAltChange = function ( msg , sender )
    -- To avoid spamminess

    GRM_G.MatchPattern3 = GRM_G.MatchPattern3 or GRM.BuildComPattern ( 3 , "?" , false );
    local altName , altChangeTimeStamp , name = "" , 0 , "";

    altName , altChangeTimeStamp , name = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern3 );
    altChangeTimeStamp = tonumber ( altChangeTimeStamp );

    local alt = GRM.GetPlayer ( altName );

    if alt and altChangeTimeStamp >= GRM.GetAltGroupTimeStamp ( alt.altGroup ) then

        if GRM.PlayerHasAlts ( alt ) then
            local isRemoved;

            if alt.altGroup ~= "" then
                isRemoved = false;
            end
            GRM.RemovePlayerFromAltGroup ( altName , altChangeTimeStamp , false , false , false )

            if GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_G.currentName == altName then       -- If the alt being removed is being dumped from the list of alts, but the Sync person is on that frame..
                GRM.PopulateMemberDetails ( GRM_G.currentName );
            end
            GRM_UI.RefreshSelectFrames ( false , true , false , false , true , true , true );

            if isRemoved == false and alt.altGroup == "" then
                isRemoved = true;
            end

            if isRemoved then
                if GRM.S().syncChatEnabled then

                    GRM.Report ( GRM.L ( "{name} removed {name2} from {custom1}'s list of Alts." , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( altName , true ) , nil , GRM.GetClassifiedName ( name , true ) ) );
                end
            end
        else
            alt.altGroupModified = altChangeTimeStamp;    -- More up to date timestamp will absorb it
        end
    end
end



-- Method:          GRMsync.CheckSetMainChange ( string , string )
-- What it Does:    Syncs Main selection control between players
-- Purpose:         Sync data between players LIVE
GRMsync.CheckSetMainChange = function ( msg , sender )

    GRM_G.MatchPattern2 = GRM_G.MatchPattern2 or GRM.BuildComPattern ( 2 , "?" , false );
    local name , timestamp = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern2 );

    GRM.SetMain ( name , tonumber ( timestamp ) );

    local player = GRM.GetPlayer ( name );

    -- We need to add the timestamps our selves as well! In the main program, the timestamps are only triggered on manually clicking and adding/removing
    if player then

        if GRM.S().syncChatEnabled then
            GRM.Report ( GRM.L ( "{name} set {name2} to be 'Main'" , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( name , true ) ) );
        end

        GRM_UI.RefreshSelectFrames ( false , true , false , false , true , false , true );
    end

end

-- Method:          GRMsync.CheckDemoteFromMainChange ( string , string )
-- What it Does:    If a player is demoted from main to alt, it syncs that change with everyone
-- Purpose:         Sync data between players LIVE
GRMsync.CheckDemoteFromMainChange = function ( msg , sender )

    GRM_G.MatchPattern2 = GRM_G.MatchPattern2 or GRM.BuildComPattern ( 2 , "?" , false );
    local name , timestamp = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern2 );

    timestamp = tonumber ( timestamp );
    GRM.DemotePlayerFromMain ( name , timestamp );

    if GRM.S().syncChatEnabled then
        GRM.Report ( GRM.L ( "{name} has changed {name2} to be listed as an 'alt'" , GRM.GetClassifiedName ( sender , true ) , GRM.GetClassifiedName ( name , true ) ) );
    end

    GRM_UI.RefreshSelectFrames ( false , true , false , false , true , false , true );
end

-- Method:          GRMsync.CheckCustomNoteSyncChange ( string , string , bool )
-- What it Does:    For use in the Retroactive non-live sync, it checks and compares custom notes and applies the most current one
-- Purpose:         For updating and syncing the custom notes!!!
GRMsync.CheckCustomNoteSyncChange = function ( msg , prefix , isReceived )
    -- No need to check if sync is disable for custo notes :D
    if GRM.S().syncCustomNote then

        local name = "";
        local timeStampOfChange = 0;
        local whoEdited = "";
        local customNote = "";
        local indReceived;
        local values = {};
        local readyToProcess = false;

        if type ( msg ) == "table" then
            name = msg[1];
            timeStampOfChange = msg[2];
            whoEdited = msg[3];
            customNote = msg[4];
            readyToProcess = true;

        else
            msg , indReceived = msg:match ( "(.+)%~|~(%d+)$" );   -- Parse out the msg num
            values = GRMsync.ParseAllSeparatedItems( msg , "~|~" );

            if prefix == "GRM_CUSTSYNCUP1" then
                table.insert ( GRMsyncGlobals.messageIndexesReceived.CUSTFINAL , tonumber ( indReceived ) );

                name = values[1];
                timeStampOfChange = tonumber ( values[2] );
                whoEdited = values[3];
                customNote = values[4];

                if customNote == "#" then
                    customNote = "";
                end
                readyToProcess = true;

            elseif prefix == "GRM_CUSTSYNCUP2" then
                table.insert ( GRMsyncGlobals.messageIndexesReceived.CUSTFINAL , tonumber ( indReceived ) );

                name = values[1];
                timeStampOfChange = tonumber ( values[2] );
                whoEdited = values[3];
                customNote = values[4];

                if customNote == "#" then       -- This shouldn't ever apply in theory, since this is the string that is 99 chars in length
                    customNote = "";
                end

                GRMsyncGlobals.CustomNoteReceivedTempFinal[name] = { timeStampOfChange , whoEdited , customNote }

            elseif prefix == "GRM_CUSTSYNCUP3" then
                name = values[1];
                local customNote2 = values[2];

                if GRMsyncGlobals.CustomNoteReceivedTempFinal[name] then
                    table.insert ( GRMsyncGlobals.messageIndexesReceived.CUSTFINAL , tonumber ( indReceived ) );

                    timeStampOfChange = GRMsyncGlobals.CustomNoteReceivedTempFinal[name][1];
                    whoEdited = GRMsyncGlobals.CustomNoteReceivedTempFinal[name][2];
                    customNote = GRMsyncGlobals.CustomNoteReceivedTempFinal[name][3] .. customNote2;
                    readyToProcess = true;
                end

            end
        end

        if readyToProcess then
            -- Check for changes!
            local player = GRM.GetPlayer ( name );

            if player then
                -- Player identified... now we need to find out what sync restriction you have on them.
                if player.customNote[1] then
                    if ( isReceivedSync and GRMsyncGlobals.senderCustRankReq < GRM_G.playerRankID ) then
                        return;
                    else
                        if player.customNote[2] <= timeStampOfChange then
                            -- Rank restrictions are good, now let's see if the note is different!
                            if customNote ~= player.customNote[4] then
                                local oldNote = tostring ( player.customNote[4] );
                                player.customNote[2] = timeStampOfChange;
                                player.customNote[3] = whoEdited;
                                player.customNote[4] = customNote;
                                -- Handle Log reporting logic here...
                                GRM.RecordCustomNoteChanges ( customNote , oldNote , whoEdited , name , false )

                                -- Updating count of changes
                                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                                GRMsyncGlobals.updatesEach[4] = GRMsyncGlobals.updatesEach[4] + 1;
                            end
                            -- doing this because even though the note might not have been changed, I want to update the timestamp and who edited.
                            player.customNote[2] = timeStampOfChange;
                            player.customNote[3] = whoEdited;

                            -- Update the UI proper
                            if name == GRM_G.currentName  and GRM_UI.GRM_MemberDetailMetaData:IsVisible() and GRM_UI.GRM_MemberDetailMetaData.GRM_ConfirmCustomNoteButton:IsVisible() then
                                GRM_UI.RefreshSelectFrames ( false , false , false , false , false , false , true );
                            end

                            if prefix == "GRM_CUSTSYNCUP3" then
                                GRMsyncGlobals.CustomNoteReceivedTempFinal[name] = nil;
                            end
                        end
                    end
                end
            end
        end
    end
end


-- Method:          GRMsync.CheckCustomNoteChange ( string , string , string )
-- What it Does:    It updates the Custom Note as needed, live
-- Purpose:         Sync the information between guildies live, as well as obey the filtering rules between clients.
GRMsync.CheckCustomNoteChange = function ( msg , sender , prefix )
    if GRM.S().syncCustomNote then

        local name = "";
        local timeStampOfChange = 0;
        local whoEdited = "";
        local customNote = "";
        local values = GRMsync.ParseAllSeparatedItems( msg , "~|~" );
        local readyToProcess = false;

        if prefix == "GRM_CNOTE1" then

            name = values[1];
            timeStampOfChange = tonumber ( values[2] );
            whoEdited = sender;
            customNote = values[3];

            if customNote == "#" then
                customNote = "";
            end
            readyToProcess = true;

        elseif prefix == "GRM_CNOTE2" then

            name = values[1];
            timeStampOfChange = tonumber ( values[2] );
            whoEdited = sender;
            customNote = values[3];

            if customNote == "#" then       -- This shouldn't ever apply in theory, since this is the string that is 99 chars in length
                customNote = "";
            end

            GRMsyncGlobals.CustomNoteReceievedLiveTemp[name] = { timeStampOfChange , sender , customNote }

        elseif prefix == "GRM_CNOTE3" then
            name = values[1];
            local customNote2 = values[2];

            if GRMsyncGlobals.CustomNoteReceievedLiveTemp[name] then

                timeStampOfChange = GRMsyncGlobals.CustomNoteReceievedLiveTemp[name][1];
                whoEdited = GRMsyncGlobals.CustomNoteReceievedLiveTemp[name][2];
                customNote = GRMsyncGlobals.CustomNoteReceievedLiveTemp[name][3] .. customNote2;
                readyToProcess = true;
            end

        end

        if readyToProcess then
            -- Check for changes!
            local player = GRM.GetPlayer ( name );

            if player then
                -- Player identified... now we need to find out what sync restriction you have on them.
                if player.customNote[1] and player.customNote[2] <= timeStampOfChange then
                    -- Rank restrictions are good, now let's see if the note is different!
                    if customNote ~= player.customNote[4] then
                        local oldNote = tostring ( player.customNote[4] );
                        player.customNote[2] = timeStampOfChange;
                        player.customNote[3] = whoEdited;
                        player.customNote[4] = customNote;
                        -- Handle Log reporting logic here...
                        GRM.RecordCustomNoteChanges ( customNote , oldNote , whoEdited , name , false )

                        if GRM.S().syncChatEnabled then
                            GRM.Report ( GRM.L ( "{name} has updated {name2}'s custom public note" , GRM.GetClassifiedName ( sender , false ) , GRM.GetClassifiedName ( player.name , false ) ) .. "\n\n|cFFFFFFFF" .. customNote );
                        end

                        GRM.BuildCustomNoteScrollFrame ( player.customNote[4] );
                        if GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:HasFocus() then
                            GRM_UI.GRM_MemberDetailMetaData.GRM_CustomNoteEditBoxFrame.GRM_CustomNoteEditBox:ClearFocus();
                        end
                    end
                    -- doing this because even though the note might not have been changed, I want to update the timestamp and who edited.
                    player.customNote[2] = timeStampOfChange;
                    player.customNote[3] = whoEdited;

                    if prefix == "GRM_CNOTE3" then
                        GRMsyncGlobals.CustomNoteReceievedLiveTemp[name] = nil;
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
    GRM_G.MatchPattern5 = GRM_G.MatchPattern5 or GRM.BuildComPattern ( 5 , "?" , false );
    local name , day , month , date , timestamp = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern5 );

    GRM.SetBirthday ( name , tonumber (day) , tonumber ( month ) , 1 , date , tonumber ( timestamp ) , true , sender , isFullSync );
end

-- Method:          GRMsync.CheckBirthdayForSync (string or table)
-- What it Does:    Takes the birthday received info and updates the database
-- Purpose:         Updating and syncing birthday data
GRMsync.CheckBirthdayForSync = function ( data )

    local name = ""
    local timestamp;
    local month = 0;
    local day = 0;
    local year = 0;
    local date = "";

    if type ( data ) == "string" then

        local indReceived = "";
        data , indReceived = data:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
        table.insert ( GRMsyncGlobals.messageIndexesReceived.BDAYFINAL , tonumber ( indReceived ) );

        GRM_G.MatchPattern4 = GRM_G.MatchPattern4 or GRM.BuildComPattern ( 4 , "?" , false );
        name , timestamp , day , month = GRMsync.ParseComMsg ( data , GRM_G.MatchPattern4 );

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
        GRM.ResetBirthdayForAltGroup ( name , timestamp , false , nil , true );
    end
end

-- Method:          GRMsync.CheckBirthdayRemoveChange ( string , string )
-- What it Does:    Coordinates birthdate removal when signalled from another player
-- Purpose:         Keep birthdates aligned and live sync'd when removing as well
GRMsync.CheckBirthdayRemoveChange = function ( msg , sender )
    local result = GRM.GetWordArrayFromString ( msg , "?" );
    local name = result[1];
    local timeStamp = tonumber ( result[2] );

    GRM.ResetBirthdayForAltGroup ( name , timeStamp , false , sender , false );
end

-- Method:          GRMsync.CheckBanListChange ( string , string )
-- What it Does:    If a player is banned, then it broadcasts the bane to the rest of the players, so they can update their info.
-- Purpose:         It is far more useful if more than one person maintains a BAN list...
GRMsync.CheckBanListChange = function ( msg , sender )

    -- name , epochTimeStamp , reason , class , guid , banAlts
    local values = GRMsync.ParseAllSeparatedItems( msg , "~|~" );
    local name = values[1]
    local epochTimeStamp = tonumber ( values[2] );
    local reason = values[3];
    local class = values[4];
    local guid = values[5];
    local banAlts = false;

    if values[6] == "true" then
        banAlts = true;
    end

    if reason == "###" then
        reason = "";
    end

    if guid == "#" then
        guid = "";
    end

    local banSet = false;
    local isAnEdit = false;
    local isFormerMember = false;
    local timeArray = select ( 2 , GRM.GetTimestamp() );
    local player = GRM.GetPlayer ( name );

    if not player then
        player = GRM.GetFormerPlayer ( name );
        isFormerMember = true;
    end

    -- First things first, let's find player!
    if player then
        -- The initial ban of the player.
        if player.bannedInfo[1] then
            isAnEdit = true;
        else
            player.bannedInfo[1] = true;
        end
        player.bannedInfo[2] = epochTimeStamp;
        player.bannedInfo[3] = false;
        player.bannedInfo[4] = sender;
        player.reasonBanned = reason;

        -- Next thing is IF alts are to be banned, this will ban them all as well!
        if banAlts == true then

            local listOfAlts = {};
            local playerAlt = {};
            if isFormerMember then
                listOfAlts = player.altsAtTimeOfLeaving; -- Alts table is stored when they leave, in case of return or in this case, banning
            else
                listOfAlts = GRM.GetListOfAlts ( player , false );
            end

            if #listOfAlts > 0 then
                for i = 1 , #listOfAlts do
                    -- Need to search data the guildData and the nonGuildData...
                    playerAlt = GRM.GetPlayer ( listOfAlts[i][1] );
                    if not playerAlt then
                        playerAlt = GRM.GetFormerPlayer ( listOfAlts[i][1] );
                    end

                    if playerAlt and playerAlt.name ~= GRM_G.addonUser then
                        -- Banning the alts one by one in the for loop
                        playerAlt.bannedInfo[1] = true;
                        playerAlt.bannedInfo[2] = epochTimeStamp;
                        playerAlt.bannedInfo[3] = false;
                        playerAlt.bannedInfo[4] = sender;
                        playerAlt.reasonBanned = reason;
                    end
                end
            end
        end

    -- OMG, if player is still not found... this is a brand new name added
    else

        local memberInfoToAdd = {};

        memberInfoToAdd.name = name                                             -- 1
        memberInfoToAdd.rankName = "";                                          -- 2
        memberInfoToAdd.rankIndex = 99;                                         -- 3 (It needs to be 1 less to match when compared to the guildRosterInfo call )
        memberInfoToAdd.level = 1;                                              -- 4
        memberInfoToAdd.note = "";                                              -- 5
        memberInfoToAdd.officerNote = "";
        memberInfoToAdd.class = class;                                          -- 7
        memberInfoToAdd.lastOnline = 1;                                         -- 8 Time since they last logged in in hours.
        memberInfoToAdd.lastOnlineTime = { 0 , 0 , 0 , 1 };
        memberInfoToAdd.zone = "";                                              -- 9
        memberInfoToAdd.achievementPoints = 100;                                -- 10
        memberInfoToAdd.rep = 4;                                                -- 12
        memberInfoToAdd.isOnline = false;                                       -- 13
        memberInfoToAdd.status = 3;                                             -- 14
        memberInfoToAdd.GUID = guid;                                            -- 15
        memberInfoToAdd.race = "";                                              -- 16
        memberInfoToAdd.sex = 1;                                                -- 17
        memberInfoToAdd.rosterSelection = 0;                                    -- 18]
        memberInfoToAdd.faction = GRM_G.faction;

        if GRM_G.BuildVersion >= 80000 then
            memberInfoToAdd.MythicScore = 0;
        end

        GRM.AddMemberToLeftPlayers ( memberInfoToAdd , timeArray , GRM.ConvertToStandardFormatDate ( timeArray[1] , timeArray[2] , timeArray[3]) , 0 , sender , true );

        -- Now, let's implement the ban!
        player = GRM.GetFormerPlayer ( name );
        if player then
            player.bannedInfo[1] = true;
            player.bannedInfo[2] = epochTimeStamp;
            player.bannedInfo[3] = false;
            player.bannedInfo[4] = sender;
            player.reasonBanned = reason;
        end

    end

    -- Add ban info to the log.
    local classCode = GRM.GetClassColorRGB ( class , true );
    local bannedName = classCode .. GRM.SlimName ( name ) .. "|r";
    local playerWhoBanned = GRM.GetClassifiedName ( sender , true );

    local logEntryWithTime , logEntry = GRM.GetBanLogUpdateAndEditString ( banAlts , isAnEdit , playerWhoBanned , bannedName , reason , timeArray );
    GRM.AddLog ( { 20 , logEntryWithTime , banAlts , isAnEdit , playerWhoBanned , bannedName , reason , timeArray } );

    -- Report the change to chat window...
    if GRM.S().syncChatEnabled and GRM.S().toChat.banned then
        GRM.Report ( logEntry );
    end

    GRM_UI.RefreshSelectFrames ( true , false , true , false , false , false , true );
end

-- Method:          GRMsync.CheckUnbanListChangeLive()
-- What it Does:    Removes the given player from the ban list
-- Purpose:         to sync ban information live. Of note, I NEED to build all the for loops here because the timestamps must be compared.
GRMsync.CheckUnbanListChangeLive = function ( msg , sender )
    local name = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
    local epochTimeStamp = tonumber ( GRM.Next ( msg ) );

    -- The other method is built for all the logic...
    GRM.BanListUnban ( name , sender , epochTimeStamp );

    -- Message
    if GRM.S().syncChatEnabled then
        if GRM.GetPlayer ( name ) then
            name = GRM.GetStringClassColorByName ( name ) .. GRM.SlimName ( name ) .. "|r";
        else
            name = GRM.GetClassifiedName ( name , true );
        end

        local logReportWithTime , logReport = GRM.GetUnBanString ( GRM.GetClassifiedName ( sender , true ) , name , select ( 2 , GRM.GetTimestamp() ) );

        GRM.AddLog ( { 21 , logReportWithTime , GRM.GetClassifiedName ( sender , true ) , name , select ( 2 , GRM.GetTimestamp() ) } );

        if GRM.S().syncChatEnabled and GRM.S().toChat.banned then
            GRM.Report ( logReport );
        end

        GRM_UI.RefreshSelectFrames ( true , false , true , false , false , false , true );
    end
end

-- Method:          GRMsync.BanManagement ( string or table , string , string )
-- What it Does:    Updates the ban data while syncing.
-- Purpose:         Syncing bans and unbans between players...
GRMsync.BanManagement = function ( msg , prefix , sender )

    -- { playerName , banTimeEpoch , banType , playerWhoBanned , rankName , rankIndex , level , classIndex , standardDate , originalJoinEpoch , GUID , reason }
    local playerName , banTimeEpoch , banType , playerWhoBanned , rankName , rankIndex , level , classIndex , standardDate , originalJoinEpoch , GUID , reason , indReceived;
    local banStatus = "ban";
    local values = {};
    local dataIsReady = false;
    local formerPlayer = false;

    if type ( msg ) == "string" then
        msg , indReceived = msg:match ( "(.+)%~|~(%d+)$" );     -- Parse out the msg num
        values = GRMsync.ParseAllSeparatedItems( msg , "~|~" );
    else
        values = msg;
    end

    if prefix == "GRM_BANSYNCUP1" or prefix == "GRM_BANSYNCUP2" then
        formerPlayer = true

        if indReceived then
            table.insert ( GRMsyncGlobals.messageIndexesReceived.BANFINAL , tonumber ( indReceived ) );
        end

        playerName = values[1];
        banTimeEpoch = tonumber ( values[2] );
        banType = values[3];
        playerWhoBanned = values[4];
        rankName = values[5];
        rankIndex = tonumber ( values[6] );
        level = tonumber ( values[7] );
        classIndex = tonumber ( values[8] );
        standardDate = values[9];
        originalJoinEpoch = tonumber ( values[10] );
        GUID = values[11];

        if GUID == "#" then
            GUID = "";
        else
            GUID = "Player-" .. GUID;
        end

        if playerWhoBanned == "#" then
            playerWhoBanned = "";
        end

        if rankName == "##" then
            rankName = "";
        end

        if prefix == "GRM_BANSYNCUP1" then        -- All data was contained in a single message
            reason = values[12];
            if reason == "###" then
                reason = "";
            end
            dataIsReady = true;

        elseif prefix == "GRM_BANSYNCUP2" then    -- The Reason was not yet included
            table.insert ( GRMsyncGlobals.BanReceivedTempFinal , { playerName , banTimeEpoch , banType , "" , playerWhoBanned } );
        end

        -- Need to add them to player former members or update the file
        GRMsync.UpdateLeftPlayerInfo ( { playerName , rankName , rankIndex , level , classIndex , standardDate , originalJoinEpoch , GUID } );

    elseif prefix == "GRM_BANSYNCUP3" or prefix == "GRM_BANSYNCUP6" then
        if prefix == "GRM_BANSYNCUP3" then
            formerPlayer = true;
        end

        playerName = values[1];
        reason = values[2];
        if reason == "###" then
            reason = "";
        end

        for i = #GRMsyncGlobals.BanReceivedTempFinal , 1 , -1 do        -- Start from the end since it is assumed the last entry was added at end
            if GRMsyncGlobals.BanReceivedTempFinal[i][1] == playerName then
                table.insert ( GRMsyncGlobals.messageIndexesReceived.BANFINAL , tonumber ( indReceived ) );

                dataIsReady = true;
                -- Player name already set
                banTimeEpoch = GRMsyncGlobals.messageIndexesReceived.BANFINAL[i][2];
                banType = GRMsyncGlobals.messageIndexesReceived.BANFINAL[i][3];
                -- Reason is already set
                playerWhoBanned = GRMsyncGlobals.messageIndexesReceived.BANFINAL[i][5];

                break;
            end
        end

    elseif prefix == "GRM_BANSYNCUP4" or prefix == "GRM_BANSYNCUP5" then

        if indReceived then
            table.insert ( GRMsyncGlobals.messageIndexesReceived.BANFINAL , tonumber ( indReceived ) );
        end

        playerName = values[1];
        banTimeEpoch = tonumber ( values[2] );
        banType = values[3];
        playerWhoBanned = values[4];

        if prefix == "GRM_BANSYNCUP4" then
            reason = values[5];
            if reason == "###" then
                reason = "";
            end
            dataIsReady = true;
        else
            table.insert ( GRMsyncGlobals.BanReceivedTempFinal , { playerName , banTimeEpoch , banType , "" , playerWhoBanned } );
        end
    end

    if dataIsReady then
        local player;
        local isAnEdit = false;
        if formerPlayer then
            player = GRM.GetFormerPlayer ( playerName );
        else
            player = GRM.GetPlayer ( playerName );
        end

        if player then

            if banTimeEpoch >= player.bannedInfo[2] then
                -- Ok, let's see if it is a ban or an unban!
                isAnEdit = false;
                if banType == "1" then

                    if player.bannedInfo[1] then
                        isAnEdit = true;
                        addLog = true;
                    end

                    if isAnEdit and player.reasonBanned == reason then
                        addLog = false;
                    end

                    player.bannedInfo[1] = true;
                    player.bannedInfo[2] = banTimeEpoch;
                    player.bannedInfo[3] = false;
                    player.bannedInfo[4] = playerWhoBanned;
                    player.reasonBanned = reason;

                    if not isAnEdit or ( isAnEdit and addLog ) then
                        if not isAnEdit then
                            GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                            GRMsyncGlobals.updatesEach[6] = GRMsyncGlobals.updatesEach[6] + 1;
                        else
                            GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                            GRMsyncGlobals.updatesEach[8] = GRMsyncGlobals.updatesEach[8] + 1;
                        end
                    end

                elseif banType == "2" then
                    -- Cool, player is being unbanned! "unban"
                    banStatus = "no ban";

                    if player.bannedInfo[3] then
                        isAnEdit = true;
                        addLog = true;
                    elseif player.bannedInfo[1] then        -- Only count if it is a ban or unban, not if just adding an outdated ban.
                        addLog = true;
                    end

                    if isAnEdit and player.reasonBanned == reason then
                        addLog = false;
                    end

                    player.bannedInfo[1] = false;
                    player.bannedInfo[2] = banTimeEpoch;
                    player.bannedInfo[3] = true;
                    player.bannedInfo[4] = playerWhoBanned;
                    player.reasonBanned = "";

                    if not isAnEdit or ( isAnEdit and addLog ) then
                        if not isAnEdit then
                            GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                            GRMsyncGlobals.updatesEach[7] = GRMsyncGlobals.updatesEach[7] + 1;
                        else
                            GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                            GRMsyncGlobals.updatesEach[8] = GRMsyncGlobals.updatesEach[8] + 1;
                        end
                    end
                end

                -- Add ban info to the log.
                -- Report the updates!
                if ( not player.class or player.class == "" ) and player.GUID ~= "" and player.GUID ~= nil then
                    player.class = GRM.GetPlayerClassByGUID ( player.GUID );
                    if player.class == "" or player.class == nil then
                        -- try again
                        player.class = GRM.GetPlayerClassByGUID ( player.GUID );
                        if not player.class or player.class == "" then
                            player.class = "HUNTER";        -- This shouldn't ever happen, but this is edge case if server fails to respond. Placholder class is set.
                        end
                    end
                elseif player.GUID == nil then
                    player.GUID = "";
                end

                if addLog then
                    local colorCode = GRM.GetClassColorRGB ( player.class , true );
                    local tempName = colorCode .. GRM.FormatName ( player.name ) .. "|r";

                    local banEditMsgWithTime = GRM.GetBanStatusSyncString ( banStatus , isAnEdit , tempName , GRM.GetClassifiedName ( playerWhoBanned , false ) , reason , select ( 2 , GRM.GetTimestamp() ) );

                    -- unban = 21 , ban = 20
                    if banType == "1" then

                        GRM.AddLog ( { 20 , banEditMsgWithTime , false , isAnEdit , tempName , GRM.GetClassifiedName ( playerWhoBanned , false ) , reason , select ( 2 , GRM.GetTimestamp() ) } );

                    elseif banType == "2" then

                        GRM.AddLog ( { 21 , banEditMsgWithTime , tempName , GRM.GetClassifiedName ( playerWhoBanned , false ) , reason , select ( 2 , GRM.GetTimestamp() ) } );
                    end
                end
            end
        end
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

-- Method:          GRMsync.IsCompatibleToShareData ( bool , bool , bool , bool , bool , bool )
-- What it Does:    Returns true if player meets sync requirements
-- Purpose:         Critical gate check to control the flow of information. The normal data share might diverge as ALL might be outgoing, but the final
--                  may be more restricted as the sync leader may be sending some outgoing information, but not returning their own.
GRMsync.IsCompatibleToShareData = function ( allNormal , isCustom , isBan , finalNormal , finalCustom , finalBan )

    if allNormal then
        if ( ( GRM.S().exportAllRanks or GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank ) and GRM_G.playerRankID <= GRMsyncGlobals.senderRankRequirement ) then
            return true;
        end

    elseif isCustom then
        if ( ( GRM.S().exportAllRanks or GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankCustom ) and GRM_G.playerRankID <= GRMsyncGlobals.syncRankCustomNoteFilter ) then
            return true;
        end

    elseif isBan then
        if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankBanList and GRM_G.playerRankID <= GRMsyncGlobals.senderBanRankReq ) then
            return true;
        end

    elseif finalNormal then
        if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank and GRM_G.playerRankID <= GRMsyncGlobals.senderRankRequirement ) then
            return true;
        end

    elseif finalCustom then
        if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankCustom and GRM_G.playerRankID <= GRMsyncGlobals.syncRankCustomNoteFilter ) then
            return true;
        end
    elseif finalBan then
        if ( GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankBanList and GRM_G.playerRankID <= GRMsyncGlobals.senderBanRankReq ) then
            return true;
        end
    end

    return false;
end

-- Method:          GRMsync.GetCustomPseudoHash( bool )
-- What it Does:    Checks the database and creates an array of values representing sections of the database...
-- Purpose:         Player A creates their values, player B creates theirs, they are compared, the sections not equal are the portions that need to be sync'd.
-- Note:            Cust note has some limits due to the extra tighter sync throttles that are unique to each player and thus it is still only broken into incrememnts appropriate for it.
GRMsync.GetCustomPseudoHash = function( dataRequested )

    -- So this can be pulled without a sync being processed
    if #GRMsyncGlobals.guildData == 0 then
        GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData , GRMsyncGlobals.guildAltData = GRM.convertToArrayFormat( true , true );
    end

    local guildData = GRMsyncGlobals.guildData;
    local altData = GRMsyncGlobals.guildAltData;
    local jd1 , pd1 , alt1 , cust1 , bday1 , ban1 = 0 , 0 , 0 , 0 , 0 , 0;
    local jd2 , pd2 , alt2 , cust2 , bday2 , ban2 = {} , {} , {} , {} , {} , {};
    local totalHashSum = 0;

    local data = { ["join"] = 1 , ["promote"] = 2 , ["alt"] = 3 , ["custom"] = 4 , ["bday"] = 5 , ["ban"] = 6 };
    local specificData = data[dataRequested];

    -- GRMsyncGlobals.SyncTracker.buildingHashes = true;

    local getHashPrecision = function ( rNum1 , rString2 )
        table.insert ( rString2 , tostring ( rNum1 ) );
        rNum1 = 0;          -- reset the count
        return rNum1 , rString2;
    end

    local player;
    GRMsync.RefreshPlayerRankIDs();

    -- Join Dates
    if ( not specificData or specificData == 1 ) and GRMsync.IsCompatibleToShareData( true ) then
        for i = 1 , #guildData do
            player = guildData[i];
            if not player.GUID then
                player.GUID = "";
            end

            if player.joinDateHist[1][6] then
                -- day + month + year + name byteVal + GUID byteVal;
                jd1 = jd1 + player.joinDateHist[1][1] + player.joinDateHist[1][2] + player.joinDateHist[1][3] + GRMsync.ConvertStringToVal ( player.name ) + GRMsync.ConvertGUIDToVal ( player.GUID );
            end
        end

        jd2.compareHash = jd1;
        jd2.list = GRMsync.GetListOfPlayersWithVerifiedJoinDates( GRMsyncGlobals.guildData );   -- Needs to run in separate loop when doing a change comparison.
    else
        jd2.compareHash = 0;
        jd2.list = {};
    end

    -- Promotion Dates
    if ( not specificData or specificData == 2 ) and GRMsync.IsCompatibleToShareData( true ) then
        for i = 1 , #guildData do
            player = guildData[i];
            if not player.GUID then
                player.GUID = "";
            end

            if player.rankHist[1][7] then
                -- day + month + year + name byteVal + GUID byteVal;
                pd1 = pd1 + player.rankHist[1][2] + player.rankHist[1][3] + player.rankHist[1][4] + GRMsync.ConvertStringToVal ( player.name ) + GRMsync.ConvertGUIDToVal ( player.GUID );
            end
        end

        pd2.compareHash = pd1;
        pd2.list = GRMsync.GetListOfPlayersWIthVerifiedPromoteDates( GRMsyncGlobals.guildData );   -- Needs to run in separate loop when doing a change comparison.
    else
        pd2.compareHash = 0;
        pd2.list = {};
    end

    -- Alt details
    if ( not specificData or specificData == 3 ) and GRMsync.IsCompatibleToShareData( true ) then
        local altGroup;
        for i = 1 , #guildData do
            player = guildData[i];

            if player.altGroup == "" then
                if player.altGroupLeft > 0 then
                    alt1 = alt1 + 5 + GRMsync.ConvertStringToVal ( player.name );
                else
                    alt1 = alt1 + 10 + GRMsync.ConvertStringToVal ( player.name );
                end
            else
                altGroup = altData[player.altGroup];
                if altGroup then
                    for i = 1 , #altGroup do
                        alt1 = alt1 + GRMsync.ConvertStringToVal ( altGroup[i].name );
                    end
                    alt1 = alt1 + GRMsync.ConvertStringToVal ( altGroup.main ) + GRMsync.ConvertStringToVal ( player.name );
                end
            end
        end
        alt2.compareHash = alt1;
        alt2.list = GRMsync.GetListPlayersWithAltTimeStamp ( GRMsyncGlobals.guildData , GRMsyncGlobals.guildAltData );
    else
        alt2.compareHash = 0;
        alt2.list = {};
    end

    -- Custom Notes
    if ( not specificData or specificData == 4 ) and GRMsync.IsCompatibleToShareData ( false , true ) then
        for i = 1 , #guildData do
            player = guildData[i];

            -- Custom Note Data
            if player.customNote[1] and player.customNote[2] > 0 then
                -- player Who Modified Byteval + note ByteVal + name ByteVale
                cust1 = cust1 + GRMsync.ConvertStringToVal ( player.customNote[3] ) + GRMsync.ConvertStringToVal ( player.customNote[4] ) + GRMsync.ConvertStringToVal ( player.name );
            end
        end
        cust2.compareHash = cust1;
        cust2.list = GRMsync.GetListOfPlayersWithCustomNotesModified( GRMsyncGlobals.guildData );
    else
        cust2.compareHash = 0;
        cust2.list = {};
    end

    -- Bday data
    if ( not specificData or specificData == 5 ) and GRMsync.IsCompatibleToShareData( true ) then
        for i = 1 , #guildData do
            player = guildData[i];

            if player.events[2][4] > 0 then
                bday1 = bday1 + player.events[2][1][1] + player.events[2][1][2] + GRMsync.ConvertStringToVal ( player.name );
            end
        end
        bday2.compareHash = bday1;
        bday2.list = GRMsync.GetListOfPlayersWithModifiedBdays( GRMsyncGlobals.guildData );
    else
        bday2.compareHash = 0;
        bday2.list = {};
    end

    -- Ban Data
    if ( not specificData or specificData == 6 ) and GRMsync.IsCompatibleToShareData( false , false , true ) then
        local bans = {};

        bans = GRMsync.GetListBannedAndUnbannedPlayers ( { GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData } );

        for i = 1 , #bans do
            ban1 = ban1 + GRMsync.ConvertStringToVal ( bans[i][1] ) + bans[i][2] + GRMsync.ConvertStringToVal ( bans[i][3] ) + GRMsync.ConvertStringToVal ( bans[i][4] )
        end

        ban2.compareHash = ban1;
        ban2.list = bans;
    else
        ban2.compareHash = 0;
        ban2.list = {};
    end

    if not specificData then
        totalHashSum = ( jd2.compareHash or 0 ) + ( pd2.compareHash or 0 ) + ( alt2.compareHash or 0 ) + ( cust2.compareHash or 0 ) + ( bday2.compareHash or 0 ) + ( ban2.compareHash or 0 ); -- Need to be in parentheses for truthy logic to work
    end


    return { jd2 , pd2 , alt2 , cust2 , bday2 , ban2 , totalHashSum };
end

-- Method:          GRMsync.RefreshPlayerRankIDs()
-- What it Does:    Refreshes the rank IDs
-- Purpose:         Useful for preliminary check when checking the ban restrictions, or other restrictions that might apply.
GRMsync.RefreshPlayerRankIDs = function()
    if not GRMsyncGlobals.IsElectedLeader then
        GRMsyncGlobals.CurrentSyncPlayer = GRMsyncGlobals.DesignatedLeader;
        GRMsyncGlobals.CurrentSyncPlayerRankID = GRM.GetGuildMemberRankID ( GRMsyncGlobals.DesignatedLeader );
    else
        GRMsyncGlobals.CurrentSyncPlayer = GRMsyncGlobals.SyncQue[1];
        GRMsyncGlobals.CurrentSyncPlayerRankID = GRM.GetGuildMemberRankID ( GRMsyncGlobals.SyncQue[1] );
    end
end

-- Method:          GRMsync.GetListOfPlayersWithVerifiedJoinDates ( table , bool )
-- What it Does:    Returns the list of all players who have verified join dates.
-- Purpose:         Ensure the proper syncing of join dates by providing an accurate list.
GRMsync.GetListOfPlayersWithVerifiedJoinDates = function( guildData , getFullProfile )
    local list = {};

    for i = 1 , #guildData do
        if guildData[i].joinDateHist[1][6] and guildData[i].joinDateHist[1][1] ~= 0 then
            if not getFullProfile then
                table.insert ( list , { guildData[i].name , guildData[i].joinDateHist[1][5] } );   -- { name , timestamp }
            else
                table.insert ( list , { guildData[i].name , guildData[i].joinDateHist[1][4] , guildData[i].joinDateHist[1][5] } );  -- { name , standardTime  , timestamp }
            end
        end
    end

    return list;
end

-- Method:          GRMsync.GetListOfPlayersWIthVerifiedPromoteDates ( table , bool )
-- What it Does:    Returns the list of all players who have verified promotion dates.
-- Purpose:         Ensure the proper syncing of join dates by providing an accurate list.
GRMsync.GetListOfPlayersWIthVerifiedPromoteDates = function( guildData , getFullProfile )
    local list = {};

    for i = 1 , #guildData do
        if guildData[i].rankHist[1][7] and guildData[i].rankHist[1][2] ~= 0 then
            if not getFullProfile then
                table.insert ( list , { guildData[i].name , guildData[i].rankHist[1][6] } );   -- { name , timestamp }
            else
                table.insert ( list , { guildData[i].name , guildData[i].rankHist[1][5] , guildData[i].rankHist[1][6] } );  -- { name , standardTime  , timestamp }
            end
        end
    end

    return list;
end

-- Method:          GRMsync.GetListPlayersWithAltTimeStamp();
-- What it Does:    Returns the names of all players in the guild who are in an alt group or removed from one, and adds timestamp
-- Purpose:         Much slimmer data to send on a precheck.
GRMsync.GetListPlayersWithAltTimeStamp = function( guildData , altGroups , replaceTime )
    guildData = guildData or GRMsyncGlobals.guildData;
    altGroups = altGroups or GRMsyncGlobals.guildAltData;
    local result = {};
    local alts = {};
    local player;
    local int;
    local timeStamp = 0;

    for i = 1 , #guildData do
        player = guildData[i];
        if player.altGroup ~= "" or player.altGroupLeft > 0 then    -- if player is in a group, or if not, they are removed from a group
            if player.altGroup ~= "" then
                alts = altGroups[player.altGroup];
                if alts then
                    if not replaceTime then
                        timeStamp = alts.timeModified;
                    else
                        timeStamp = 2;
                    end

                    table.insert ( result , { player.name , timeStamp })
                end
            else
                if not replaceTime then
                    timeStamp = player.altGroupLeft;
                else
                    timeStamp = 2;
                end

                table.insert ( result , { player.name , timeStamp } );
            end
        end
    end

    return result;
end

-- Method:          GRMsync.GetListOfPlayersWithCustomNotesModified ( table , bool )
-- What it Does:    Returns the names of all players in the guild with modified customNotes
-- Purpose:         Control the flow of sync data.
GRMsync.GetListOfPlayersWithCustomNotesModified = function( guildData , getFullProfile )
    local list = {};

    for i = 1 , #guildData do
        if guildData[i].customNote[1] and guildData[i].customNote[2] > 0 then
            if not getFullProfile then
                table.insert ( list , { guildData[i].name , guildData[i].customNote[2] } );   -- { name , timestamp }
            else
                table.insert ( list , { guildData[i].name , guildData[i].customNote[2] , guildData[i].customNote[3] , guildData[i].customNote[4] } );   -- { name , timestamp , whoEdited , customNote }
            end
        end
    end

    return list;
end

-- Method:          GRMsync.GetListOfPlayersWithModifiedBdays ( table , bool )
-- What it Does:    Returns the names of all players in the guild with modified bdays
-- Purpose:         Control the flow of sync data.
GRMsync.GetListOfPlayersWithModifiedBdays = function( guildData , getFullProfile )
    local list = {};

    for i = 1 , #guildData do
        if guildData[i].events[2][4] > 0 then
            if not getFullProfile then
                table.insert ( list , { guildData[i].name , guildData[i].events[2][4] } );   -- { name , timestamp }
            else
                table.insert ( list , { guildData[i].name , guildData[i].events[2][4] , guildData[i].events[2][1][1] , guildData[i].events[2][1][2] , guildData[i].altGroup } );   -- { name , timestamp , day , month , altGroup }
            end
        end
    end

    return list;
end

-- Method:          GRMsync.GetListBannedAndUnbannedPlayers ( guildData , bool )
-- What it Does:    Pulls the list of all players banned and unbanned.
-- Purpose:         For sync use - only need to compare timestamp. If not the same, then will tag it as needed to be shown.
GRMsync.GetListBannedAndUnbannedPlayers = function( data , getFullProfile )
    -- data = { guildData , leftGuildData } -- temp files to scan through.
    local result = {};
    local data = data or { GRM.GetGuild() , GRM.GetFormerMembers() };

    local banType;
    local playerData;
    local classIndex;
    local rankName;
    local rankIndex;
    local GUID;
    local standardDate;
    local epochOriginalTimestamp;

    if data then
        -- In a linear array, not in linked table
        for i = 1 , #data do
            for j = 1 , #data[i] do
                if data[i][j].bannedInfo[1] or data[i][j].bannedInfo[3] then
                    -- Banned or Unbanned

                    if not getFullProfile then
                        table.insert ( result , { data[i][j].name , data[i][j].bannedInfo[2] , data[i][j].reasonBanned , data[i][j].GUID } );   -- name and timestamp is all that is needed
                    else
                        banType = "1";
                        if data[i][j].bannedInfo[3] then
                            banType = "2";  -- unbanned
                        end

                        playerData = {};        -- Reset

                        if i == 2 then      -- Former Guildie

                            if data[i][j].class == nil or data[i][j].class == "" then
                                classIndex = 3;        -- zero so it is just 1 char long.
                            else
                                classIndex = tostring ( GRM_G.classFileIDEnum[ data[i][j].class ] )
                            end
                            if not classIndex then
                                classIndex = 3;
                            end

                            rankName = data[i][j].rankName;
                            rankIndex = data[i][j].rankIndex;
                            GUID = data[i][j].GUID;
                            if not GUID then
                                GUID = ""
                            end

                            epochOriginalTimestamp = 0;
                            if data[i][j].joinDateHist[1][6] then   -- Verified
                                epochOriginalTimestamp = data[i][j].joinDateHist[1][5];
                            end

                            standardDate = "";
                            if #data[i][j].joinDateHist[1][4] == 8 then
                                standardDate = data[i][j].joinDateHist[1][4];
                            else
                                local dates = select ( 2 , GRM.GetTimestamp() );
                                epochOriginalTimestamp = 0;         -- Ensures that both are aligned so it will be unverified.
                                standardDate = GRM.ConvertToStandardFormatDate ( dates[1] , dates[2] , dates[3] );
                            end

                            playerData = { rankName , rankIndex , data[i][j].level , classIndex , standardDate , epochOriginalTimestamp , GUID };
                        end

                        -- Prepping for the ban final changes to be sent.
                        table.insert ( result , {
                            data[i][j].name,
                            data[i][j].bannedInfo[2],
                            banType,
                            data[i][j].reasonBanned,
                            data[i][j].bannedInfo[4],
                            playerData
                            }
                        )
                    end
                end
            end
        end
    end

    sort ( result , function ( a , b ) return a[1] < b[1] end ); -- Alphabetize the names

    return result;
end

-- Method:          GRMsync.ConvertGUIDToVal ( string )
-- What it Does:    Converts the string into a byteValue sum
-- Purpose:         To create a unique identifier in smaller form. It should also be noted that this only handles the Blizzard format of a GUID as if it uses
--                  special unicode characters it will not unique value it correctly and a different method should be used. This is strictly for the Warcraft player GUID format valueing.
GRMsync.ConvertGUIDToVal = function ( guid )

    guid = string.gsub ( guid , "Player%-%d+%-" , "" );
    local byteArray = { string.byte ( guid , 1 , -1 ) };
    local result = 0;

    for i = 1 , #byteArray do
        result = result + byteArray[i];
    end
    return result;
end

-- Method:          GRMsync.ConvertStringToVal ( string )
-- What it Does:    Creates a Unique Identifier with the player
-- Purpose:         For purposes of creating a unique ID hash.
GRMsync.ConvertStringToVal = function ( name )
    name = name or "";
    local result = 0;
    local nameByteArray = { string.byte ( name , 1 , -1 ) };
    for i = 1 , #nameByteArray do
        result = result + nameByteArray[i];
    end
    return result;
end

-- Method:          GRMsync.SendOverallDataHashes()
-- What it Does:    Sends the message of all your hashes, to determine which data boxes are aligned
-- Purpose:         Sync speed and efficiency. It doesn't make sense to do a massive compare when you can do minimal at first.
GRMsync.SendOverallDataHashes = function ()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    GRMsync.PreCheckHashValues = GRMsync.GetCustomPseudoHash();

    local msg = "GRM_PREHASHALL?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsync.PreCheckHashValues[1].compareHash .. "?" .. GRMsync.PreCheckHashValues[2].compareHash .. "?" .. GRMsync.PreCheckHashValues[3].compareHash .. "?" .. GRMsync.PreCheckHashValues[4].compareHash .. "?" .. GRMsync.PreCheckHashValues[5].compareHash .. "?" .. GRMsync.PreCheckHashValues[6].compareHash .. "?" .. GRMsync.PreCheckHashValues[7];
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;

    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );        -- No need to consider loop delay as minimal data has been shared at this point. Still count it.
end

-- Method:          GRMsync.BoolToInt ( bool )
-- What it Does:    Returns either a 1 or zero, representing true/false, but in a char
-- Purpose:         Make the message slimmer.
GRMsync.BoolToInt = function ( result )
    if result == true then
        return "1";
    end
    return "0";
end

-- Method:          GRMsync.CompareOverallHashes ( string )
-- What it Does:    Collects the overall hashes for all database points
-- Purpose:         Do an initial check to keep sync process lean.
GRMsync.CompareOverallHashes = function( msg , syncMessage )

    if not syncMessage then
        GRM_G.MatchPattern7 = GRM_G.MatchPattern7 or GRM.BuildComPattern ( 7 , "?" , false );

        local jdHash , pdHash , altHash , custHash , bdayHash , banHash , totalHash = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern7 );
        GRMsync.PreCheckHashValues = GRMsync.GetCustomPseudoHash();     -- Collect my hash values
        syncMessage = "GRM_PREALLRESULT?" .. GRMsyncGlobals.numGuildRanks

        -- Start with overall database comparison.
        if tonumber ( totalHash ) == GRMsync.PreCheckHashValues[7] then
            syncMessage = syncMessage .. "?000000"; -- "Zeros represent FALSE or no need to send"
        else
            GRMsyncGlobals.SyncPath = { tonumber ( jdHash ) ~= GRMsync.PreCheckHashValues[1].compareHash , tonumber ( pdHash ) ~= GRMsync.PreCheckHashValues[2].compareHash , tonumber ( altHash ) ~= GRMsync.PreCheckHashValues[3].compareHash , tonumber ( custHash ) ~= GRMsync.PreCheckHashValues[4].compareHash , tonumber ( bdayHash ) ~= GRMsync.PreCheckHashValues[5].compareHash , tonumber ( banHash ) ~= GRMsync.PreCheckHashValues[6].compareHash };

            syncMessage = syncMessage .. "?" .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[1] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[2] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[3] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[4] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[5] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[6] );
        end
    end

    if ( GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier ) >= GRMsyncGlobals.ThrottleCap then
        GRMsyncGlobals.SyncCount = 0;
        GRMsync.CompareOverallHashes ( msg , syncMessage );
        return;
    else
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
    end
end

-- Method:          GRMsync.SetSyncPathway ( string )
-- What it Does:    Sets the sync pathway to determine which blocks of code are necssary, separated by join dates, promotion, alt, custom note, etc... If no data sync is needed, then finishes the sync
-- Purpose:         Determine if sync is necessasry EARLY in the process, and if so, which portions need to be sync'd so not all needs to be compared.
GRMsync.SetSyncPathway = function( msg )
    local syncIsNecessary = false;
    for i = 1 , #msg do
        GRMsyncGlobals.SyncPath[i] = ( msg:sub ( i , i ) == '1' );     -- if it == 1 then it is true, else false
        if GRMsyncGlobals.SyncPath[i] then
            syncIsNecessary = true;
        end
    end

    if syncIsNecessary then
        -- Now we send the sync data necessary
        GRMsync.ReviewAndSendPrecheckData();
    else
        -- End Sync
        GRMsync.FinalSyncComplete();
    end
end

-- Method:          GRMsync.UpdateSyncPathway ( string )
-- What it Does:    Updates the sync pathway if there were changes made after the precheck
-- Purpose:         Sync efficiency. Smart to modify the path as more information from the precheck of hash data is received.
GRMsync.UpdateSyncPathway = function ( msg )
    for i = 1 , #msg do
        GRMsyncGlobals.SyncPath[i] = ( msg:sub ( i , i ) == '1' );     -- if it == 1 then it is true, else false
    end
end

-- Method:          GRMsync.ReviewAndSendPrecheckData ( table )
-- What it Does:    Sends the PreCheckData over to compare databases
-- Purpose:         Smaller amount of code to determine who needs data updated.
GRMsync.ReviewAndSendPrecheckData = function( completedPath )
    completedPath = completedPath or { false , false , false , false , false , false }; -- 5 would be bdays b ut skip for now
    -- Join Dates
    if not completedPath[1] and GRMsyncGlobals.SyncPath[1] then
        GRMsync.SendPrecheckData ( completedPath , 1 );
        return;
    end
    completedPath[1] = true;

    -- Promo Dates
    if not completedPath[2] and GRMsyncGlobals.SyncPath[2] then
        GRMsync.SendPrecheckData ( completedPath , 2 );
        return;
    end
    completedPath[2] = true;

    -- Alt and Mains
    if not completedPath[3] and GRMsyncGlobals.SyncPath[3] then
        GRMsync.SendPrecheckData ( completedPath , 3 );
        return;
    end
    completedPath[3] = true;

    -- Custom Notes
    if not completedPath[4] and GRMsyncGlobals.SyncPath[4] then
        GRMsync.SendPrecheckData ( completedPath , 4 );
        return;
    end
    completedPath[4] = true;

    -- Skip bdays for now as we want to process at very end

    -- Bans
    if not completedPath[6] and GRMsyncGlobals.SyncPath[6] then
        GRMsync.SendPrecheckData ( completedPath , 6 );
        return;
    end
    completedPath[6] = true;
    GRMsync.SendMessage ( "GRM_SYNC" , "GRM_FINALPRE?" .. GRMsyncGlobals.syncRankFilter .. "?" , GRMsyncGlobals.CurrentSyncPlayer );
end

-- Method:          GRMsync.SendPrecheckData ( table , int )
-- What it Does:    Sends all the precheck info for qualifying for sync
-- Purpose:         More efficient syncing.
GRMsync.SendPrecheckData = function ( completedPath , dataInd , index , special )
    local syncHeader = { "GRM_RECJDPRE?" , "GRM_RECPDPRE?" , "GRM_RECALTPRE?" , "GRM_RECCUSTPRE?" , "GRM_RECBDAYPRE?" , "GRM_RECBANPRE?" };

    index = index or 1;
    local players = GRMsync.PreCheckHashValues[dataInd].list        -- From PseudoCustomHash
    local syncFilter = GRMsyncGlobals.syncRankFilter;
    if dataInd == 4 then
        syncFilter = GRM.S().syncRankCustom;
    elseif dataInd == 6 then
        syncFilter = GRM.S().syncRankBanList;
    end
    local syncMessage = syncHeader[dataInd] .. syncFilter;
    local tempMessage = "";
    local messageReady;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    for i = index , #players do
        messageReady = false;

        if GRMsyncGlobals.SyncOK then

            -- Expand the string more... Fill up the full 255 characters for efficiency.
            if ( #tempMessage + GRMsyncGlobals.sizeModifier ) < 255 then
                tempMessage = syncMessage .. "?" .. players[i][1] .. "?" .. players[i][2];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier ) < 255 then       -- + 1 for the ? divider before messageCount
                    syncMessage = tempMessage;
                    if i == #players then
                        messageReady = true;
                    end
                else
                    messageReady = true;
                    -- Hold this value over...
                    tempMessage = syncHeader[dataInd] .. syncFilter .. "?" .. players[i][1] .. "?" .. players[i][2];
                    -- Need to send it out as it will not re-loop
                    if i == #players then
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMessage + GRMsyncGlobals.sizeModifier;
                        GRMsync.SendMessage ( "GRM_SYNC" , tempMessage , GRMsyncGlobals.CurrentSyncPlayer );
                    end
                end
            end

            -- Send message
            if messageReady or ( i == #players ) then
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
                syncMessage = tempMessage;
            end

            -- Check if there needs to be a throttled delay
            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;
                index = i;
                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendPrecheckData ( completedPath , dataInd , index , special );
                end);       -- Add a delay on packet sending.
                return;
            end
        end
    end
    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        if not special then
            completedPath[dataInd] = true;
            GRMsync.ReviewAndSendPrecheckData ( completedPath );
        else
            local msg = "GRM_FINALPRE2?" .. GRMsyncGlobals.syncRankFilter .. "?";
            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
            GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
        end
    else
        return;
    end
end

-- Method:          GRMsync.CollectPreCheckData ( string , string )
-- What it Does:    Collects the precheck ALT data
-- Purpose:         Syncing and improved efficiency
GRMsync.CollectPreCheckData = function ( msg , prefix )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local name = "";
    local timeStampOfChange = 0;
    local dataIndex = { ["GRM_RECJDPRE"] = 1 , ["GRM_RECPDPRE"] = 2 , ["GRM_RECALTPRE"] = 3 , ["GRM_RECCUSTPRE"] = 4 , ["GRM_RECBDAYPRE"] = 5 , ["GRM_RECBANPRE"] = 6 };
    local ind = dataIndex[prefix];

    local receivedValues = GRMsync.ParseAllSeparatedItems ( msg );

    for i = 1 , #receivedValues , 2 do
        name = receivedValues[i];
        timeStampOfChange = tonumber ( receivedValues[i+1]);
        GRMsyncGlobals.HashValuesReceived[ind][name] = timeStampOfChange;
    end

end

-- Method:          GRMsync.Convert2DArrayToDictionary ( table )
-- What it Does:    Converts a simple 2D array into a dictionary, where the first index becomes dictionary reference and 2nd index is the data
-- Purpose:         Useful to simplify the code a bit when just checking if something exists in a table rather than cycling through in a for loop.
GRMsync.Convert2DArrayToDictionary = function ( array )
    local result = {};
    for i = 1 , #array do
        result[array[i][1]] = array[i][2];
    end
    return result
end

-- Method:          GRMsync.ContinueSyncInCategory ( int )
-- What it Does:    Determines if there is a reason sync should be continued in this category. Reutrns true if compatible
-- Purpose:         In some cases, let's say a player who is too low rank makes their own changes so you cannot sync with them. This will now
--                  be aware of this anomaly when you have no data to share with them, but they send you mismatched data. Whilst you know not to confirm their
--                  changes, it is time wasting to send comms back and forth when you can just check the DB if the ONLY updates you have are from them, and
--                  their rank is too low to accept. Just end that category now.
GRMsync.ContinueSyncInCategory = function( ind )

    local IsCompatibleEnum = {};
    if ind ~= 4 then

        IsCompatibleEnum[ind] = function()
            return { GRMsync.IsCompatibleToShareData ( false , false , false , true ) , ( ( GRM.S().exportAllRanks or GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRank ) and GRM_G.playerRankID <= GRMsyncGlobals.senderMaxRankReq ) };
        end

    else

        IsCompatibleEnum[ind] = function()
            return { GRMsync.IsCompatibleToShareData ( false , false , false , false , true ) , ( ( GRM.S().exportAllRanks or GRMsyncGlobals.CurrentSyncPlayerRankID <= GRM.S().syncRankCustom ) and GRM_G.playerRankID <= GRMsyncGlobals.senderCustRankReq ) };
        end

    end


    for i = 1 , #GRMsyncGlobals.DatabaseMarkers[ind] do
        if GRMsyncGlobals.DatabaseMarkers[ind][i][2] == 2 then
            break;
        end

        if i == #GRMsyncGlobals.DatabaseMarkers[ind] and not IsCompatibleEnum[ind]()[1] then
            -- No break has occurred, thus we have only encounted digit 1, which means the received data is more recent. However, sync should
            -- NOT move forward if the person is too low rank for you to accept their changes. That is just wasting time.
            return false;
        end
    end

    for i = 1 , #GRMsyncGlobals.DatabaseMarkers[ind] do
        if GRMsyncGlobals.DatabaseMarkers[ind][i][2] == 1 then
            break;
        end

        if i == #GRMsyncGlobals.DatabaseMarkers[ind] and not IsCompatibleEnum[ind]()[2] then
            -- No break has occurred, thus we have only encounted digit 2, which means my data is more recent. However, sync should
            -- NOT move forward if the person is too low rank for you to accept their changes. That is just wasting time.
            return false;
        end
    end

    return true;
end

-- Method:          GRMsync.CompareListDBMarkers( int )
-- What it Does:    Checks the list, compares names and timestamps for syncing and determines by tagging who is more recent result.
-- Purpose:         To do a precheck of the players syncing's list for efficiency
GRMsync.CompareListDBMarkers = function( index )
    local players = GRMsync.Convert2DArrayToDictionary ( GRMsync.PreCheckHashValues[index].list );
    local result = {};

    -- Compare received table
    for name , timeOfChange in pairs ( GRMsyncGlobals.HashValuesReceived[index] ) do
        if not players[name] then
            table.insert ( result , { name , 1 } );             -- 1 indicates it the received data, 2 indicates my own data.
        else
            if players[name] ~= timeOfChange then
                if players[name] < timeOfChange then             -- The received change is greater, thus more recent.
                    table.insert ( result , { name , 1 } );
                else
                    table.insert ( result , { name , 2 } );     -- My ban changes are current.
                end
            end
            players[name] = nil;     -- No longer need to have this in the list as it has been considered.
        end
    end

    -- All these names remaining will be ones the other player does not have as I did not receive them
    for name in pairs ( players ) do
        table.insert ( result , { name , 2 } );
    end

    return result;
end

-- Method:          GRMsync.CompareBdayDataMarkers()
-- What it Does:    Compares the hash received to my own to make a determination where the bday lists may differ
-- Purpose:         Recheck bday hashes only.
GRMsync.CompareBdayDataMarkers = function()
    local result = {};
    local HashValuesMine = GRMsync.GetCustomPseudoHash( false , true , false )[5];
    local isSame = false;

    for i = 1 , #HashValuesMine do
        isSame = false;

        if GRMsyncGlobals.HashValuesReceived[i] ~= nil then
            if GRMsyncGlobals.HashValuesReceived[i] == tostring ( HashValuesMine[i] ) then
                isSame = true;
            end

        else
            isSame = true;
        end

        table.insert ( result , isSame );
    end
    return result;
end

-- Method:          GRMsync.ProcessBdayDataAndContinue()
-- What it Does:    Determines if sync of bday data is good to continue after processing Precheck hashes
-- Purpose:         Sync efficiency. Give sync an early escape to end after analyzing precheck bday data
GRMsync.ProcessBdayDataAndContinue = function()
    GRMsyncGlobals.guildData = nil;
    GRMsyncGlobals.guildData = GRM.convertToArrayFormat( false , false );
    GRMsync.PreCheckHashValues[5] = GRMsync.GetCustomPseudoHash( "bday" )[5];
    GRMsyncGlobals.DatabaseMarkers[5] = GRMsync.CompareListDBMarkers( 5 );

    GRMsyncGlobals.SyncPath[5] = GRMsync.ContinueSyncInCategory(5);
    local needsUpdatedPath
    if not GRMsyncGlobals.SyncPath[5] then
        needsUpdatedPath = true;
    end

    local delay = 0;
    if needsUpdatedPath then
        local syncMessage = "GRM_PREALLRESULT2?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[1] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[2] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[3] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[4] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[5] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[6] )
        delay = 0.5;    -- Ensures this arrives first by adding a delay
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );

        -- Let's now do a check to see if the sync process needs is still necessary.
        for i = 1 , #GRMsyncGlobals.SyncPath do
            if GRMsyncGlobals.SyncPath[i] then
                break;
            end

            if i == #GRMsyncGlobals.SyncPath then
                -- All options false. Sync no longer necessary
                GRMsync.FinalBdayMessagesVerifiedSendComplete();
                return;
            end
        end
    end

    C_Timer.After ( delay , function()
        GRMsync.SendBdayPacketsNotMine();
    end);
end

-- Method:          GRMsync.ProcessPreCheckDataAndBeginSync()
-- What it Does:    Processes the precheck data and sets the database markers or the actual data that is latest
-- Purpose:         Part of the sync process and efficiency.
GRMsync.ProcessPreCheckDataAndBeginSync = function()

    local needsUpdatedPath = false;
    for i = 1 , 6 do
        if i ~= 5 and GRMsyncGlobals.SyncPath[i] then -- If no alts to update.
            GRMsyncGlobals.DatabaseMarkers[i] = GRMsync.CompareListDBMarkers( i );
            sort ( GRMsyncGlobals.DatabaseMarkers[i] , function ( a , b ) return a[1] < b[1] end );

            if i ~= 6 then
                GRMsyncGlobals.SyncPath[i] = GRMsync.ContinueSyncInCategory(i);
                if not GRMsyncGlobals.SyncPath[i] then
                    needsUpdatedPath = true;
                end
            end
        end
    end

    local delay = 0;
    if needsUpdatedPath then
        local syncMessage = "GRM_PREALLRESULT2?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[1] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[2] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[3] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[4] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[5] ) .. GRMsync.BoolToInt ( GRMsyncGlobals.SyncPath[6] )
        delay = 0.5;    -- Ensures this arrives first by adding a delay
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );

        -- Let's now do a check to see if the sync process needs is still necessary.
        for i = 1 , #GRMsyncGlobals.SyncPath do
            if GRMsyncGlobals.SyncPath[i] then
                break;
            end

            if i == #GRMsyncGlobals.SyncPath then
                -- All options false. Sync no longer necessary
                GRMsync.FinalBdayMessagesVerifiedSendComplete();
                return;
            end
        end
    end

    C_Timer.After ( delay , function()
        GRMsync.BeginSyncSteps();
    end);
end

-- Method:          GRMsync.BeginSyncSteps()
-- What it Does:    Controls the flow of sync starting
-- Purpose:         Ensure data integrity.
GRMsync.BeginSyncSteps = function()
    -- Build the values first

    -- GRMsyncGlobals.TrackerData , GRMsyncGlobals.totalEstTime = GRMsync.CalculateTotalSyncVolume();
    -- GRMsync.SendTrackerCalculation();
    -- GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , GRMsyncGlobals.totalEstTime );
    -- GRMsyncGlobals.progStart = time();

    -- Now, determine where to start in database.
    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
        GRMsync.NextSyncStep();
    end);
end

-- Method:          GRMsync.NextSyncStep( table )
-- What it Does:    Activates the appropriate sync data packet dump collection, for time saving.
-- Purpose:         Cleanly execute sharing and syncing data in a minimalistic way, in specified order. DO NOT ADJUST ORDER as some things require review prior to next step.
GRMsync.NextSyncStep = function( completedPath )

    completedPath = completedPath or { false , false , false , false , false , false };

    if not completedPath[1] and GRMsyncGlobals.SyncPath[1] then
        GRMsync.SendJDPacketsNotMine( completedPath );
        return;
    end
    completedPath[1] = true;

    if not completedPath[2] and GRMsyncGlobals.SyncPath[2] then
        GRMsync.SendPDPacketsNotMine( completedPath );
        return;
    end
    completedPath[2] = true;

    if not completedPath[3] and GRMsyncGlobals.SyncPath[3] then
        GRMsync.SendAltNamesNotMine( completedPath );
        return;
    end
    completedPath[3] = true;

    if not completedPath[4] and GRMsyncGlobals.SyncPath[4] then
        GRMsync.SendCUSTPacketsNotMine( completedPath );
        return;
    end
    completedPath[4] = true;

    if not completedPath[6] and GRMsyncGlobals.SyncPath[6] then
        GRMsync.SendBanNamesNotMine( completedPath );
        return;
    end
    completedPath[6] = true;

    GRMsync.SendCompletionMsg()
end

-- Method:          GRMsync.SendCompletionMsg ()
-- What it Does:    Builds a message to be sent to the sync Leader which states the player is done sending data, and it sends which types it sent over, thus keeping the analysis lean
-- Purpose:         Speed speed SPEED!!!
GRMsync.SendCompletionMsg = function()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    -- This string is reordered for legacy code reasons in change 1.50 that I just do not wish to have to restructure. Minor adaptation

    local msg = "GRM_STOP?" .. GRMsyncGlobals.syncRankFilter .. "?" .. #GRMsyncGlobals.messageTree.JDF .. "?" .. #GRMsyncGlobals.messageTree.JD .. "?" .. #GRMsyncGlobals.messageTree.PDF .. "?" .. #GRMsyncGlobals.messageTree.PD .. "?" .. #GRMsyncGlobals.messageTree.ALTF .. "?" .. #GRMsyncGlobals.messageTree.ALT .. "?" .. #GRMsyncGlobals.messageTree.CUSTF .. "?" .. #GRMsyncGlobals.messageTree.CUST .. "?" .. #GRMsyncGlobals.messageTree.BANF .. "?" .. #GRMsyncGlobals.messageTree.BAN;
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.CurrentSyncPlayer );
    -- Need to Disable error checking now as you will stop communicating with the designated leader
end

-- Method:          GRMsync.SendBDAYCompletion()
-- What it Does:    Sends the sync leader a confirmation that all bday info has been sent and all data will now be stopped
-- Purpose:         Control flow of sync process
GRMsync.SendBDAYCompletion = function()
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    local msg = "GRM_STOP2?" .. GRMsyncGlobals.syncRankFilter .. "?" .. #GRMsyncGlobals.messageTree.BDAYF .. "?" .. #GRMsyncGlobals.messageTree.BDAY;

    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.CurrentSyncPlayer );
end

---------------------------------------
------- END OF HAS CONTROL LOGIC ------
---------------------------------------

-------------------------------
--- SENDING DATA --------------
-------------------------------

-- Method:          GRMsync.GetNumDigits ( int )
-- What it Does:    Returns the num of integers in a given string
-- Purpose:         Useful for sync purposes to ensure the the length of the count is considered.
GRMsync.GetNumDigits = function ( x )
    x = math.abs ( x );     -- Remove the negative sign if necessary.
    return #tostring ( x );
end

-- Method:          GRMsync.SendJDPacketsNotMine ( table , int , int )
-- What it Does:    Sends the names of the players with join data who are more current than mine, but I have no exact details on them
-- Purpose:         Efficiency in syncing
GRMsync.SendJDPacketsNotMine = function( completedPath , messageCount , index )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.altData then
    --     GRMsyncGlobals.ProgressControl ( "JD" );
    -- end

    -- Increment next message
    messageCount = messageCount or 1;
    index = index or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local syncMessage = "";
    local tempMessage = "";
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[1];

    for i = index , #dataIndexes do

        if GRMsyncGlobals.SyncOK then

            if dataIndexes[i][2] == 1 then

                if syncMessage == "" then
                    syncMessage =  "GRM_JDSYNCF?".. GRMsyncGlobals.syncRankFilter;
                end

                tempMessage = syncMessage .. "?" .. dataIndexes[i][1];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.JDF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_JDSYNCF?".. GRMsyncGlobals.syncRankFilter .. "?" .. dataIndexes[i][1];
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if i == #dataIndexes then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.JDF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;

                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendJDPacketsNotMine ( completedPath , messageCount , index );
                    end);
                    return;
                end
            elseif i == #dataIndexes and syncMessage ~= "" then

                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.JDF[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
            end
        else
            return;
        end
    end

    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendJDPackets( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.SendJDPackets( table , int , int , table )
-- What it Does:    Sends the full JD data over of players I have
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendJDPackets = function( completedPath , messageCount , index , players )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    messageCount = messageCount or 1;
    index = index or 1;

    local syncMessage = "";
    local tempMessage = "";

    players = players or GRMsync.BuildJoinDatesForSync();

    for i = index , #players do

        if GRMsyncGlobals.SyncOK then

            if syncMessage == "" then
                syncMessage = "GRM_JDSYNC?" .. GRMsyncGlobals.syncRankFilter;
            end

            tempMessage = syncMessage .. "?" .. players[i][1] .. "?" .. players[i][2] .. "?" .. players[i][3];

            if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
            else
                -- Do not add the new name, just send the syncMessage
                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.JD[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                messageCount = messageCount + 1;

                syncMessage = "GRM_JDSYNC?" .. GRMsyncGlobals.syncRankFilter .. "?" .. players[i][1] .. "?" .. players[i][2] .. "?" .. players[i][3];
            end

            -- If at the end of the alt Group, we need to send, even if not a full string.
            if i == #players then
                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.JD[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                messageCount = messageCount + 1;

                syncMessage = "";
            end

            -- Check if there needs to be a throttled delay
            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                index = i;

                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendJDPackets ( completedPath , messageCount , index , players );
                end);
                return;
            end
        else
            return;
        end
    end
    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        completedPath[1] = true;
        GRMsync.NextSyncStep ( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.BuildJoinDatesForSync()
-- What it Does:    Creates a specialized alt table for sync purposes
-- Purpose:         Breaking them into categories makes it easier syncing/parsing
GRMsync.BuildJoinDatesForSync = function()
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[1];
    local guildData = GRMsyncGlobals.guildData;
    local playersWithJoinDates = {};

    -- Cycle through the names that need to be sent.
    for i = 1 , #dataIndexes do
        if dataIndexes[i][2] == 2 then -- Indicates I do have data

            -- Cycle through guild data to find them. This is now in array format, remember, so that arrays align.
            for j = 1, #guildData do
                if guildData[j].name == dataIndexes[i][1] then
                    if guildData[j].joinDateHist[1][6] then

                        table.insert ( playersWithJoinDates , { guildData[j].name , guildData[j].joinDateHist[1][4] , guildData[j].joinDateHist[1][5] } );    -- Name, standardDate "YYYYMMDD", epochTimestamp

                    end
                    break;
                end
            end

        end
    end

    return playersWithJoinDates;
end

-- Method:          GRMsync.SendPDPacketsNotMine ( table , int , int )
-- What it Does:    Sends the names of the players with promotion data who are more current than mine, but I have no exact details on them
-- Purpose:         Efficiency in syncing
GRMsync.SendPDPacketsNotMine = function( completedPath , messageCount , index )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.altData then
    --     GRMsyncGlobals.ProgressControl ( "PD" );
    -- end

    -- Increment next message
    messageCount = messageCount or 1;
    index = index or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local syncMessage = "";
    local tempMessage = "";
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[2];

    for i = index , #dataIndexes do

        if GRMsyncGlobals.SyncOK then

            if dataIndexes[i][2] == 1 then

                if syncMessage == "" then
                    syncMessage =  "GRM_PDSYNCF?".. GRMsyncGlobals.syncRankFilter;
                end

                tempMessage = syncMessage .. "?" .. dataIndexes[i][1];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.PDF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_PDSYNCF?".. GRMsyncGlobals.syncRankFilter .. "?" .. dataIndexes[i][1];
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if i == #dataIndexes then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.PDF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;

                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendPDPacketsNotMine ( completedPath , messageCount , index );
                    end);
                    return;
                end
            elseif i == #dataIndexes and syncMessage ~= "" then

                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.PDF[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
            end
        else
            return;
        end
    end

    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendPDPackets( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.SendPDPackets( table , int , int , table )
-- What it Does:    Sends the full PD data over of players I have
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendPDPackets = function( completedPath , messageCount , index , players )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    messageCount = messageCount or 1;
    index = index or 1;

    local syncMessage = "";
    local tempMessage = "";

    players = players or GRMsync.BuildPromoteDatesForSync();

    for i = index , #players do

        if GRMsyncGlobals.SyncOK then

            if syncMessage == "" then
                syncMessage = "GRM_PDSYNC?" .. GRMsyncGlobals.syncRankFilter;
            end

            tempMessage = syncMessage .. "?" .. players[i][1] .. "?" .. players[i][2] .. "?" .. players[i][3];

            if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
            else
                -- Do not add the new name, just send the syncMessage
                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.PD[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                messageCount = messageCount + 1;

                syncMessage = "GRM_PDSYNC?" .. GRMsyncGlobals.syncRankFilter .. "?" .. players[i][1] .. "?" .. players[i][2] .. "?" .. players[i][3];
            end

            -- If at the end of the alt Group, we need to send, even if not a full string.
            if i == #players then
                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.PD[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                messageCount = messageCount + 1;

                syncMessage = "";
            end

            -- Check if there needs to be a throttled delay
            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                index = i;

                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendPDPackets ( completedPath , messageCount , index , players );
                end);
                return;
            end
        else
            return;
        end
    end
    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        completedPath[2] = true;
        GRMsync.NextSyncStep ( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.BuildPromoteDatesForSync()
-- What it Does:    Creates a specialized alt table for sync purposes
-- Purpose:         Breaking them into categories makes it easier syncing/parsing
GRMsync.BuildPromoteDatesForSync = function()
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[2];
    local guildData = GRMsyncGlobals.guildData;
    local playersWithPromoteDates = {};

    -- Cycle through the names that need to be sent.
    for i = 1 , #dataIndexes do
        if dataIndexes[i][2] == 2 then -- Indicates I do have data

            -- Cycle through guild data to find them. This is now in array format, remember, so that arrays align.
            for j = 1, #guildData do
                if guildData[j].name == dataIndexes[i][1] then
                    if guildData[j].rankHist[1][7] and GRMsync.ValidatePromoteDataForSync( guildData[j].rankHist ) then

                        table.insert ( playersWithPromoteDates , { guildData[j].name , guildData[j].rankHist[1][5] , guildData[j].rankHist[1][6] } );    -- Name, standardDate "YYYYMMDD", epochTimestamp

                    end
                    break;
                end
            end

        end
    end

    return playersWithPromoteDates;
end

-- Method:          GRMsync.ValidatePromoteDataForSync ( list )
-- What it Does:    Fixes the standard date if not properly formatted and returns if validated
-- Purpose:         Data sync integrity
GRMsync.ValidatePromoteDataForSync = function( rankHist )
    local validated = false;

    if #rankHist[1][5] > 1 then
        if #rankHist[1][5] > 8 then
            if rankHist[1][2] > 0 and rankHist[1][3] > 0 and rankHist[1][4] > 0 then
                rankHist[1][5] = GRM.ConvertToStandardFormatDate ( rankHist[1][2] , rankHist[1][3] , rankHist[1][4] );
                validated = true;
            else
                validated = false;
            end
        elseif #rankHist[1][5] == 8 then
            validated = true;
        end
    elseif rankHist[1][2] > 0 and rankHist[1][3] > 0 and rankHist[1][4] > 0 then
        rankHist[1][5] = GRM.ConvertToStandardFormatDate ( rankHist[1][2] , rankHist[1][3] , rankHist[1][4] );
        validated = true;
    end

    if not validated then
        rankHist = { { player.rankName , 0 , 0 , 0 , "0" , 0 , false , 1 } };
    end

    return validated
end

-- Method:          GRMsync.SendAltNamesNotMine ( table , int , int )
-- What it Does:    Sends the names of the players who are more current than mine, but I have no exact details on them
-- Purpose:         Efficiency in syncing
GRMsync.SendAltNamesNotMine = function( completedPath , messageCount , index )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.altData then
    --     GRMsyncGlobals.ProgressControl ( "ALT" );
    -- end

    -- Increment next message
    messageCount = messageCount or 1;
    index = index or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    local syncMessage = "";
    local tempMessage = "";
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[3];

    for i = index , #dataIndexes do

        if GRMsyncGlobals.SyncOK then

            if dataIndexes[i][2] == 1 then

                if syncMessage == "" then
                    syncMessage =  "GRM_ALTSYNCF?".. GRMsyncGlobals.syncRankFilter;
                end

                tempMessage = syncMessage .. "?" .. dataIndexes[i][1];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALTF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_ALTSYNCF?".. GRMsyncGlobals.syncRankFilter .. "?" .. dataIndexes[i][1];
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if i == #dataIndexes then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALTF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;

                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendAltNamesNotMine ( completedPath , messageCount , index );
                    end);
                    return;
                end
            elseif i == #dataIndexes and syncMessage ~= "" then

                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.ALTF[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
            end
        else
            return;
        end
    end

    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendAltPacketsNoGroupAndMainOnly( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.SendAltPacketsFullDetails( table , int , int , int , string )
-- What it Does:    Compartmentalizes the Add Alt logorithm to send the data controlled, fills the packets to max characters, and sends and if it hits throttle cap, resets.
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendAltPacketsNoGroupAndMainOnly = function( completedPath , messageCount , index , groupNum , altGroups )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.alts then
    --     GRMsyncGlobals.ProgressControl ( "ALT" );
    -- end

    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    messageCount = messageCount or 1;
    index = index or 1;
    groupNum = groupNum or 1;   -- Determine which table to select.

    local syncMessage = "";
    local tempMessage = "";

    if not altGroups then
        altGroups = GRMsync.BuildAltGroupsForSync();    -- { playersNotInGroup , playersOnlyMain , playersAltGroups };
    end

    if GRMsyncGlobals.SyncOK then
        if groupNum == 1 then

            for i = index , #altGroups[1] do

                if GRMsyncGlobals.SyncOK then

                    if syncMessage == "" then
                        syncMessage = "GRM_ALTSYNC1?" .. GRMsyncGlobals.syncRankFilter;
                    end

                    tempMessage = syncMessage .. "?" .. altGroups[1][i][1] .. "?" .. altGroups[1][i][2];

                    if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                        syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                    else
                        -- Do not add the new name, just send the syncMessage
                        syncMessage = syncMessage .. "?" .. messageCount;
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                        messageCount = messageCount + 1;

                        syncMessage = "GRM_ALTSYNC1?" .. GRMsyncGlobals.syncRankFilter .. "?" .. altGroups[1][i][1] .. "?" .. altGroups[1][i][2];
                    end

                    -- If at the end of the alt Group, we need to send, even if not a full string.
                    if i == #altGroups[1] then
                        syncMessage = syncMessage .. "?" .. messageCount;
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                        messageCount = messageCount + 1;

                        syncMessage = "";
                    end

                    -- Check if there needs to be a throttled delay
                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.syncTempDelay = true;

                        index = i;

                        GRMsyncGlobals.SyncCount = 0;
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRMsync.SendAltPacketsNoGroupAndMainOnly ( completedPath , messageCount , index , groupNum , altGroups );
                        end);
                        return;
                    end
                else
                    return;
                end
            end
            index = 1;
        end

        groupNum = 2;
        syncMessage = "";
        for i = index , #altGroups[2] do

            if GRMsyncGlobals.SyncOK then

                if syncMessage == "" then
                    syncMessage = "GRM_ALTSYNC2?" .. GRMsyncGlobals.syncRankFilter;
                end

                tempMessage = syncMessage .. "?" .. altGroups[2][i][1] .. "?" .. altGroups[2][i][2];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_ALTSYNC2?" .. GRMsyncGlobals.syncRankFilter .. "?" .. altGroups[2][i][1] .. "?" .. altGroups[2][i][2];
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if i == #altGroups[2] then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendAltPacketsNoGroupAndMainOnly ( completedPath , messageCount , index , groupNum , altGroups );
                    end);
                    return;
                end
            else
                return;
            end
        end
    else
        return;
    end

    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendAltGroupsFullDetails ( completedPath , altGroups[3] , messageCount );
    else
        return;
    end
end

-- Method:          GRMsync.SendAltGroupsFullDetails ( table , table , int , int , int , int )
-- What it Does:    Sends the full details of these alt groups to the other player as these are the most current according to timestamp comparison
-- Purpose:         Efficient syncing.
GRMsync.SendAltGroupsFullDetails = function ( completedPath , altGroups , messageCount , index , index2 , groupNum )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.alts then
    --     GRMsyncGlobals.ProgressControl ( "ALT" );
    -- end

    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    messageCount = messageCount or 1;
    index = index or 1;
    index2 = index2 or 2;   -- 2 as index 1 will always be leader
    groupNum = groupNum or 1;

    local syncMessage = "";
    local tempMessage = "";
    local main = "";

    -- First move, send over all the altGroups with the lead name, mainName, and timestamp.
    -- Second move, send over all the alts with the lead name at the front of the tag.
    if groupNum == 1 then
        for i = index , #altGroups do

            if GRMsyncGlobals.SyncOK then

                if syncMessage == "" then
                    syncMessage = "GRM_ALTSYNC3?" .. GRMsyncGlobals.syncRankFilter;
                end

                if altGroups[i].main == "" then
                    main = "#";
                else
                    main = altGroups[i].main;
                end

                tempMessage = syncMessage .. "?" .. altGroups[i][1] .. "?" .. main .. "?" .. altGroups[i].timeModified;

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_ALTSYNC3?" .. GRMsyncGlobals.syncRankFilter .. "?" .. altGroups[i][1] .. "?" .. main .. "?" .. altGroups[i].timeModified;
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if i == #altGroups then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;

                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendAltGroupsFullDetails ( completedPath , altGroups , messageCount , index , index2 , groupNum );
                    end);
                    return;
                end
            else
                return;
            end
        end
        index = 1;
    end

    groupNum = 2;
    syncMessage = "";

    for i = index , #altGroups do
        for j = index2 , #altGroups[i] do
            if GRMsyncGlobals.SyncOK then

                if syncMessage == "" then
                    syncMessage = "GRM_ALTSYNC4?" .. GRMsyncGlobals.syncRankFilter .. "?" .. altGroups[i][1];
                end

                tempMessage = syncMessage .. "?" .. altGroups[i][j];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_ALTSYNC4?" .. GRMsyncGlobals.syncRankFilter .. "?" .. altGroups[i][1] .. "?" .. altGroups[i][j];
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if j == #altGroups[i] then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALT[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                    index2 = 2;
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    if j == #altGroups[i] then
                        index = i + 1;
                    else
                        index = i;
                        index2 = j;
                    end
                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendAltGroupsFullDetails ( completedPath , altGroups , messageCount , index , index2 , groupNum );
                    end);
                    return;
                end
            else
                return;
            end
        end
    end

    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        completedPath[3] = true;
        GRMsync.NextSyncStep ( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.BuildAltGroupsForSync()
-- What it Does:    Creates a specialized alt table for sync purposes
-- Purpose:         Breaking them into categories makes it easier syncing/parsing
GRMsync.BuildAltGroupsForSync = function()
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[3];
    local altGroups = GRMsyncGlobals.guildAltData;
    local guildData = GRMsyncGlobals.guildData;
    local namesAlreadyProcessed = {};
    local playersNotInGroup = {};
    local playersOnlyMain = {};
    local playersAltGroups = {};

    -- Get the groupID easily.
    local GetAltGroup = function ( groupID )
        if groupID and altGroups[groupID] then
            return altGroups[groupID];
        end
        return;     -- Return nil if no alt group.
    end

    -- Variables to carry player data
    local altGroup = {};

    -- Cycle through the names that need to be sent.
    for i = 1 , #dataIndexes do
        if not namesAlreadyProcessed[dataIndexes[i][1]] and ( dataIndexes[i][2] == 2 ) then

            -- Cycle through guild data to find them. This is now in array format, remember, so that arrays align.
            for j = 1, #guildData do
                if guildData[j].name == dataIndexes[i][1] then
                    altGroup = GetAltGroup ( guildData[j].altGroup );

                    if altGroup then
                        if #altGroup > 1 then
                            -- More than 1 alt
                            for k = 1 , #altGroup do

                                if k == 1 then
                                    table.insert ( playersAltGroups , {} );
                                    playersAltGroups[#playersAltGroups].main = altGroup.main;
                                    playersAltGroups[#playersAltGroups].timeModified = altGroup.timeModified;
                                end

                                -- Add each player to the alt Group
                                table.insert ( playersAltGroups[#playersAltGroups] , altGroup[k].name );
                                namesAlreadyProcessed[altGroup[k].name] = true;
                            end

                        elseif #altGroup == 1 and guildData[j].name == altGroup.main then
                            table.insert ( playersOnlyMain , { guildData[j].name , altGroup.timeModified } );
                            namesAlreadyProcessed[dataIndexes[i][1]] = true;
                        end

                    elseif guildData[j].altGroupLeft > 0 then
                        table.insert ( playersNotInGroup , { guildData[j].name , guildData[j].altGroupLeft } );
                        namesAlreadyProcessed[dataIndexes[i][1]] = true;
                    end

                    break;
                end
            end

        end
    end

    return { playersNotInGroup , playersOnlyMain , playersAltGroups };
end



-- Method:          GRMsync.SendCUSTPacketsNotMine ( table , int , int )
-- What it Does:    Sends the names of the players with promotion data who are more current than mine, but I have no exact details on them
-- Purpose:         Efficiency in syncing
GRMsync.SendCUSTPacketsNotMine = function( completedPath , messageCount , index )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.altData then
    --     GRMsyncGlobals.ProgressControl ( "CUST" );
    -- end

    -- Increment next message
    messageCount = messageCount or 1;
    index = index or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local syncMessage = "";
    local tempMessage = "";
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[4];

    for i = index , #dataIndexes do

        if GRMsyncGlobals.SyncOK then

            if dataIndexes[i][2] == 1 then

                if syncMessage == "" then
                    syncMessage =  "GRM_CUSTSYNCF?".. GRMsyncGlobals.syncRankFilter;
                end

                tempMessage = syncMessage .. "?" .. dataIndexes[i][1];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.CUSTF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_CUSTSYNCF?".. GRMsyncGlobals.syncRankFilter .. "?" .. dataIndexes[i][1];
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if i == #dataIndexes then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.CUSTF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;

                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendCUSTPacketsNotMine ( completedPath , messageCount , index );
                    end);
                    return;
                end
            elseif i == #dataIndexes and syncMessage ~= "" then

                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.CUSTF[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
            end
        else
            return;
        end
    end

    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendCustomNotePackets( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.SendCustomNotePackets( table , int , int , table )
-- What it Does:    Sends the full Custom Note data over of players I have
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendCustomNotePackets = function( completedPath , messageCount , index , players )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    messageCount = messageCount or 1;
    index = index or 1;

    local syncMessage = "";
    local customNote = "";
    local customNote2 = "";
    local prefix = "GRM_CUSTSYNC1?"

    players = players or GRMsync.BuildCustomNotesForSync();     -- { Name, epochTime, whoEdited, CustomNote }

    for i = index , #players do
        prefix = "GRM_CUSTSYNC1?"

        if GRMsyncGlobals.SyncOK then
            customNote = "";
            customNote2 = "";

            if players[i][4] == "" then
                customNote = "#";
            else
                customNote = players[i][4];
            end

            if #customNote > 99 then
                prefix = "GRM_CUSTSYNC2?"
                customNote2 = string.sub ( customNote , 100 );
                customNote = string.sub ( customNote , 1 , 99 );
            end

            -- Delimiters must be unique and not likely in a custom note
            syncMessage = prefix .. GRMsyncGlobals.syncRankFilter .. "?" .. players[i][1] .. "~|~" .. tostring ( players[i][2] ) .. "~|~" .. players[i][3] .. "~|~" .. customNote .. "~|~" .. messageCount;

            -- ALWAYS SEND
            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
            GRMsyncGlobals.messageTree.CUST[messageCount] = syncMessage;
            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
            messageCount = messageCount + 1;

            if customNote2 ~= "" then
                syncMessage = "GRM_CUSTSYNC3?" .. GRMsyncGlobals.syncRankFilter .. "?" .. players[i][1] .. "~|~" .. customNote2;
                syncMessage = syncMessage .. "~|~" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.CUST[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                messageCount = messageCount + 1;
            end

            -- Check if there needs to be a throttled delay
            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                index = i + 1;

                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendCustomNotePackets ( completedPath , messageCount , index , players );
                end);
                return;
            end
        else
            return;
        end
    end
    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        completedPath[4] = true;
        GRMsync.NextSyncStep ( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.BuildCustomNotesForSync()
-- What it Does:    Creates a specialized alt table for sync purposes
-- Purpose:         Breaking them into categories makes it easier syncing/parsing
GRMsync.BuildCustomNotesForSync = function()
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[4];
    local guildData = GRMsyncGlobals.guildData;
    local playersWithCustomNotes = {};

    -- Cycle through the names that need to be sent.
    for i = 1 , #dataIndexes do
        if dataIndexes[i][2] == 2 then -- Indicates I do have data

            -- Cycle through guild data to find them. This is now in array format, remember, so that arrays align.
            for j = 1, #guildData do
                if guildData[j].name == dataIndexes[i][1] then

                    if guildData[j].customNote[1] and guildData[j].customNote[2] ~= 0 then

                        table.insert ( playersWithCustomNotes , { guildData[j].name , guildData[j].customNote[2] , guildData[j].customNote[3] , guildData[j].customNote[4] } );    -- Name, epochTime, whoEdited, CustomNote

                    end
                    break;
                end
            end

        end
    end

    return playersWithCustomNotes;
end

-- Method:          GRMsync.SendBdayPacketsNotMine ( table , int , int )
-- What it Does:    Sends the names of the players with Bday data who are more current than mine, but I have no exact details on them
-- Purpose:         Efficiency in syncing
GRMsync.SendBdayPacketsNotMine = function( completedPath , messageCount , index )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.altData then
    --     GRMsyncGlobals.ProgressControl ( "BDAYS" );
    -- end

    -- Increment next message
    messageCount = messageCount or 1;
    index = index or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local syncMessage = "";
    local tempMessage = "";
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[5];

    for i = index , #dataIndexes do

        if GRMsyncGlobals.SyncOK then

            if dataIndexes[i][2] == 1 then

                if syncMessage == "" then
                    syncMessage =  "GRM_BDAYSYNCF?".. GRMsyncGlobals.syncRankFilter;
                end

                tempMessage = syncMessage .. "?" .. dataIndexes[i][1];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                    syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
                else
                    -- Do not add the new name, just send the syncMessage
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.BDAYF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_BDAYSYNCF?".. GRMsyncGlobals.syncRankFilter .. "?" .. dataIndexes[i][1];
                end

                -- If at the end of the alt Group, we need to send, even if not a full string.
                if i == #dataIndexes then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.BDAYF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "";
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;

                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendBdayPacketsNotMine ( completedPath , messageCount , index );
                    end);
                    return;
                end
            elseif i == #dataIndexes and syncMessage ~= "" then

                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.PDF[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
            end
        else
            return;
        end
    end

    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendBDayPackets( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.SendBDayPackets( table , int , int , table )
-- What it Does:    Sends the full PD data over of players I have
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendBDayPackets = function( completedPath , messageCount , index , players  )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    messageCount = messageCount or 1;
    index = index or 1;

    local syncMessage = "";
    local tempMessage = "";

    players = players or GRMsync.BuildBdayDatesForSync();

    for i = index , #players do

        if GRMsyncGlobals.SyncOK then

            if syncMessage == "" then
                syncMessage = "GRM_BDSYNC?" .. GRMsyncGlobals.syncRankFilter;
            end
            -- Name, epochTimestamp day , month
            tempMessage = syncMessage .. "?" .. players[i][1] .. "?" .. players[i][2] .. "?" .. players[i][3] .. "?" .. players[i][4];

            if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                syncMessage = tempMessage;  -- Strung is still small, keep building it. Otherwise, send the syncMessage
            else
                -- Do not add the new name, just send the syncMessage
                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.BDAY[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                messageCount = messageCount + 1;

                syncMessage = "GRM_BDSYNC?" .. GRMsyncGlobals.syncRankFilter .. "?" .. players[i][1] .. "?" .. players[i][2] .. "?" .. players[i][3] .. "?" .. players[i][4];
            end

            -- If at the end of the alt Group, we need to send, even if not a full string.
            if i == #players then
                syncMessage = syncMessage .. "?" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.BDAY[messageCount] = syncMessage;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                messageCount = messageCount + 1;

                syncMessage = "";
            end

            -- Check if there needs to be a throttled delay
            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                index = i;

                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendBDayPackets ( completedPath , messageCount , index , players );
                end);
                return;
            end
        else
            return;
        end
    end
    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendBDAYCompletion();
    else
        return;
    end
end

-- Method:          GRMsync.BuildBdayDatesForSync()
-- What it Does:    Creates a specialized alt table for sync purposes
-- Purpose:         Breaking them into categories makes it easier syncing/parsing
GRMsync.BuildBdayDatesForSync = function()
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[5];
    local guildData = GRMsyncGlobals.guildData;
    local playersWithBdays = {};

    -- Cycle through the names that need to be sent.
    for i = 1 , #dataIndexes do
        if dataIndexes[i][2] == 2 then -- Indicates I do have data

            -- Cycle through guild data to find them. This is now in array format, remember, so that arrays align.
            for j = 1, #guildData do
                if guildData[j].name == dataIndexes[i][1] then
                    if guildData[j].events[2][4] > 0 then

                        table.insert ( playersWithBdays , { guildData[j].name , guildData[j].events[2][4] , guildData[j].events[2][1][1] , guildData[j].events[2][1][2] } );    -- Name, epochTimestamp day , month
                    end
                    break;
                end
            end

        end
    end

    return playersWithBdays;
end

-- Method:          GRMsync.SendBanNamesNotMine ( table , int , int )
-- What it Does:    Broadcasts to the leader all Ban information
-- Purpose:         Data sync
GRMsync.SendBanNamesNotMine = function ( completedPath , messageCount , index )
    -- Progress tracking
    -- if not GRMsyncGlobals.SyncTracker.banData then
    --     GRMsyncGlobals.ProgressControl ( "BAN" );
    -- end
    -- Increment next message
    messageCount = messageCount or 1;
    index = index or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    local syncMessage = "";
    local tempMessage = "";
    local dataIndexes = GRMsyncGlobals.DatabaseMarkers[6];

    for i = index , #dataIndexes do

        if GRMsyncGlobals.SyncOK then

            if dataIndexes[i][2] == 1 then

                if syncMessage == "" then
                    syncMessage = "GRM_BANSYNCF?".. tostring ( GRM.S().syncRankBanList );
                end

                tempMessage = syncMessage .. "?" .. dataIndexes[i][1];

                if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then

                    syncMessage = tempMessage;

                else
                    -- Message is full, let's send it.
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.BANF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.DesignatedLeader );
                    messageCount = messageCount + 1;

                    syncMessage = "GRM_BANSYNCF?".. tostring ( GRM.S().syncRankBanList ) .. "?" .. dataIndexes[i][1];
                end

                if i == #dataIndexes then
                    syncMessage = syncMessage .. "?" .. messageCount;
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.BANF[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
                    messageCount = messageCount + 1;
                end

                -- Check if there needs to be a throttled delay
                if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                    GRMsyncGlobals.syncTempDelay = true;

                    index = i;

                    GRMsyncGlobals.SyncCount = 0;
                    C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                        GRMsync.SendBanNamesNotMine ( completedPath , messageCount , index );
                    end);
                    return;
                end
            end
        else
            return;
        end
    end
    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        GRMsync.SendBanPacketsFullDetails( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.SendBanPacketsFullDetails( table , int , int )
-- What it Does:    Sends the full PD data over of players I have
-- Purpose:         Control the flow of data to prevent player disconnect on sending sync data
GRMsync.SendBanPacketsFullDetails = function( completedPath , messageCount , index  )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    messageCount = messageCount or 1;
    index = index or 1;

    local syncMessage = "";
    local syncMessage2 = "";
    local tempMessage = "";
    local tempMessage2 = "";
    local reasonMsg = "";
    local prefix = "";

    players = players or GRMsync.BuildBanNamesForSync();

    for i = index , #players do
        syncMessage = "";
        syncMessage2 = "";

        if GRMsyncGlobals.SyncOK then

            if players[i][1] then   -- If Former member -- Former will be 1,2,3
                prefix = "GRM_BANSYNC1?"
            else                    -- Current Member   -- Current will be 4,5,6
                prefix = "GRM_BANSYNC4?";
            end

            -- Name, epochTimestamp day , month
            if players[i][1] then   -- { formerMember , player.name , class , rankName , rankIndex , tostring ( player.level ) , joinDateStandardFormat , oldJoinDateMeta , GUID , banType , tostring ( player.bannedInfo[2] ) , playerWhoBanned , reason }
                tempMessage = prefix .. tostring ( GRM.S().syncRankBanList ) .. "?";
                tempMessage2 = players[i][2] .. "~|~" .. players[i][3] .. "~|~" .. players[i][4] .. "~|~" .. players[i][5] .. "~|~" .. players[i][6] .. "~|~" .. players[i][7] .. "~|~" .. players[i][8] .. "~|~" .. players[i][9] .. "~|~" .. players[i][10] .. "~|~" .. players[i][11] .. "~|~" .. players[i][12];
                reasonMsg = "~|~" .. players[i][13];

                if ( #tempMessage + #tempMessage2 + #reasonMsg + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 3 ) < 255 then
                    -- Good to send!!!
                    syncMessage = tempMessage .. tempMessage2 .. reasonMsg .. "~|~" .. messageCount;
                else
                    -- The reason message is too long, so we need to send separate.
                    syncMessage = "GRM_BANSYNC2?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. tempMessage2 .. "~|~" .. messageCount;
                    syncMessage2 = "GRM_BANSYNC3?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. players[i][2] .. "~|~" ..reasonMsg;
                end
            else
                -- Since they are already in the guild, need limited data. -- name , banType , bannedEpochTimestamp , whoBanned , reasonBanned
                tempMessage = prefix .. tostring ( GRM.S().syncRankBanList ) .. "?";
                tempMessage2 = players[i][2] .. "~|~" .. players[i][10] .. "~|~" .. players[i][11] .. "~|~" .. players[i][12];
                reasonMsg = "~|~" .. players[i][13];

                if ( #tempMessage + #tempMessage2 + #reasonMsg + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 3 ) < 255 then
                    -- Good to send!!!
                    syncMessage = tempMessage .. tempMessage2 .. reasonMsg .. "~|~" .. messageCount;
                else
                    -- The reason message is too long, so we need to send separate.
                    syncMessage = "GRM_BANSYNC5?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. tempMessage2 .. "~|~" .. messageCount;
                    syncMessage2 = "GRM_BANSYNC6?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. players[i][2] .. "~|~" ..reasonMsg;
                end
            end

            -- Now, we send the messages.
            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
            GRMsyncGlobals.messageTree.BAN[messageCount] = syncMessage;
            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
            messageCount = messageCount + 1;

            if syncMessage2 ~= "" then
                syncMessage2 = syncMessage2 .. "~|~" .. messageCount;
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage2 + GRMsyncGlobals.sizeModifier;
                GRMsyncGlobals.messageTree.BAN[messageCount] = syncMessage2;
                GRMsync.SendMessage ( "GRM_SYNC" , syncMessage2 , GRMsyncGlobals.CurrentSyncPlayer );
                messageCount = messageCount + 1;
            end

            -- Check if there needs to be a throttled delay
            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                index = i + 1;

                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendBanPacketsFullDetails ( completedPath , messageCount , index );
                end);
                return;
            end
        else
            return;
        end
    end
    -- Close the Data stream
    GRMsyncGlobals.syncTempDelay = false;
    if GRMsyncGlobals.SyncOK then
        completedPath[6] = true;
        GRMsync.NextSyncStep ( completedPath );
    else
        return;
    end
end

-- Method:          GRMsync.BuildBanNamesForSync()
-- What it Does:    Builds the full names DB to send the ban packets - only sending my data for names that don't match up
-- Purpose:         Sync efficiency.
GRMsync.BuildBanNamesForSync = function()
    local guildData = GRMsyncGlobals.guildData;
    local leftGuildData = GRMsyncGlobals.formerGuildData;
    local banNames = GRMsyncGlobals.DatabaseMarkers[6];
    local finalBanNames = {};
    local player;
    local playerIndex;
    local formerMember;

    local classIndex = "";
    local oldJoinDateMeta = "";
    local GUID = "";
    local banType = "";
    local reason = "";
    local playerWhoBanned = "";
    local rankName = "";
    local rankIndex = "";
    local joinDateStandardFormat = "";

    -- Cycle through the names that need to be sent.
    for i = 1 , #banNames do
        if banNames[i][2] == 2 then -- Indicates I do have data

            -- Cycle through guild data to find them. This is now in array format, remember, so that arrays align.
            playerIndex = GRM.GetIndexOfPlayerOnList ( guildData , banNames[i][1] );

            if not playerIndex then
                playerIndex = GRM.GetIndexOfPlayerOnList ( leftGuildData , banNames[i][1] );
                if playerIndex then
                    player = leftGuildData[playerIndex];
                    formerMember = true;
                end
            else
                player = guildData[playerIndex];
                formerMember = false;
            end

            if player then

                -- CLASS
                if player.class == nil or player.class == "" then
                    classIndex = "0";        -- zero so it is just 1 char long. For some reason some old legacy bug had some classes not showing
                else
                    classIndex = tostring ( GRM_G.classFileIDEnum[ player.class ] )
                end
                if not classIndex then
                    classIndex = "0";
                end

                -- OLD META EPOCH
                if player.joinDateHist[1][6] and player.joinDateHist[1][5] ~= 0 then
                    joinDateStandardFormat = player.joinDateHist[1][4];
                    oldJoinDateMeta = tostring ( player.joinDateHist[1][5] );
                elseif player.rankHist[1][7] and player.rankHist[1][6] ~= 0 then  -- If join date is missing, but promotion isn't - for whatever reason, using promo date instead since verified
                    joinDateStandardFormat = player.rankHist[1][5];
                    oldJoinDateMeta = tostring ( player.rankHist[1][6] );
                elseif player.joinDateHist[1][1] > 0 and #player.joinDateHist[1][4] == 8 then   -- Date is NOT verified, but there is a placeholder date thus no epoch stamp
                    joinDateStandardFormat = player.joinDateHist[1][4];
                    oldJoinDateMeta = "0";
                else                                -- No join data at all - just add nothing
                    oldJoinDateMeta = "0";
                    joinDateStandardFormat = "0";
                end

                -- GUID
                GUID = player.GUID;
                if player.GUID == "" or player.GUID == nil then
                    GUID = "#";
                    if player.GUID == nil then
                        player.GUID = "";
                    end
                elseif string.find ( GUID , "Player-.+" ) then
                    GUID = string.sub ( player.GUID , 8 )
                end

                -- BANTYPE
                if player.bannedInfo[1] then
                    banType = "1";      -- Banned
                elseif player.bannedInfo[3] then
                    banType = "2";      -- Unbanned
                end

                -- REASON FOR BAN
                if player.reasonBanned == "" or player.reasonBanned == nil then
                    reason = "###";
                else
                    reason = player.reasonBanned;
                end

                -- PERSON WHO BANNED
                if player.bannedInfo[4] == "" or player.bannedInfo[4] == nil then
                    playerWhoBanned = "#";
                else
                    playerWhoBanned = player.bannedInfo[4];
                end

                -- rankIndex
                rankIndex = tostring ( player.rankIndex );

                -- rankName
                if rankIndex == "99" then
                    rankName = "##"
                else
                    rankName = player.rankName;
                end

                table.insert ( finalBanNames , { formerMember , player.name , classIndex , rankName , rankIndex , tostring ( player.level ) , joinDateStandardFormat , oldJoinDateMeta , GUID , banType , tostring ( player.bannedInfo[2] ) , playerWhoBanned , reason } )

            end

        end
    end
    sort ( finalBanNames , function ( a , b ) return a[2] < b[2] end );
    return finalBanNames;
end

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

        if forceStop or ( GRMsyncGlobals.currentlySyncing and ( time() - GRMsyncGlobals.TimeSinceLastSyncAction ) >= GRMsyncGlobals.ErrorCD ) and GRMsyncGlobals.CurrentSyncPlayer then
            -- Check if player is offline...
            local msg = "";
            if not ( GRMsyncGlobals.CurrentSyncPlayer or GRMsyncGlobals.CurrentSyncPlayer == "" ) then
                msg = GRM.L ( "Sync has failed..." );
            else
                msg = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer , true ) );
            end

            GRMsyncGlobals.syncFailed = true
            GRMsyncGlobals.firstSync = true;
            GRMsyncGlobals.TimeSinceLastSyncAction = time();

            -- We already tried to sync, now aboard to 2nd.
            if GRMsyncGlobals.CurrentSyncPlayer and GRMsyncGlobals.CurrentSyncPlayer ~= "" and GRM.IsGuildieOnline ( GRMsyncGlobals.CurrentSyncPlayer ) then

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
                GRMsync.SendMessage ( "GRM_SYNC" , "GRM_ENDSYNC?" , GRMsyncGlobals.CurrentSyncPlayer );
            end

        elseif GRMsyncGlobals.currentlySyncing and #GRMsyncGlobals.SyncQue > 0 and not GRMsyncGlobals.ErrorCheckControl then

            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );

        elseif GRMsyncGlobals.ErrorCheckControl then
            GRMsyncGlobals.ErrorCheckControl = false;
        end

    elseif forceStop or not GRMsyncGlobals.dateSentComplete then

        if forceStop or ( GRMsyncGlobals.currentlySyncing and ( time() - GRMsyncGlobals.TimeSinceLastSyncAction ) >= GRMsyncGlobals.ErrorCD ) then

            local playerIsOnline = GRM.IsGuildieOnline ( GRMsyncGlobals.DesignatedLeader );

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
                GRMsync.SendMessage ( "GRM_SYNC" , "GRM_ENDSYNC?" , GRMsyncGlobals.CurrentSyncPlayer );
            end

        elseif GRMsyncGlobals.currentlySyncing and not GRMsyncGlobals.ErrorCheckControl then

            C_Timer.After ( GRMsyncGlobals.ErrorCD , GRMsync.ErrorCheck );

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
            msg = "GRM_BUSY?" .. GRMsyncGlobals.syncRankFilter .. "?" .. tostring ( i - 1 );

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

-- Method:          GRMsync.InitializeRankRestrictionCheck()
-- What it Does:    Sets the rank filter level to either be the sync rank, or for all outgoing data, the full number of ranks from the guild, depending on setting
-- Purpose:         Allow player to control their data sharing.
GRMsync.InitializeRankRestrictionCheck = function()
    GRMsyncGlobals.syncRankFilter = GRM.S().syncRank;
    GRMsyncGlobals.syncRankCustomNoteFilter = GRM.S().syncRankCustom;
    if GRM.S().exportAllRanks then
        GRMsyncGlobals.syncRankFilter = GRMsyncGlobals.numGuildRanks;
        GRMsyncGlobals.syncRankCustomNoteFilter = GRMsyncGlobals.numGuildRanks;
    end
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
                    GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData , GRMsyncGlobals.guildAltData = GRM.convertToArrayFormat( true , true ); -- Now, we set arrays of the data.
                    GRMsyncGlobals.TimeSinceLastSyncAction = time();

                    if GRMsync.IsPlayerDataSyncCompatibleWithAnyOnline() or GRM.S().exportAllRanks then
                        GRMsync.InitializeRankRestrictionCheck();
                        -- GRMsyncGlobals.SyncTracker.TriggeringSync = true;
                        -- GRMsyncGlobals.SyncTracker.EstablishingLeader = true;
                        -- GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Currently Syncing With: {name}" , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer ) ) );

                        if GRM.S().syncChatEnabled and GRMsyncGlobals.firstSync then
                            GRM.Report ( GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Syncing Data With Guildies Now..." ) .. "\n" .. GRM.L ( "(Loading screens may cause sync to fail)" ) );
                        end
                    end

                    GRMsyncGlobals.firstSync = false;
                    local msg = "GRM_REQJDDATA?" .. GRMsyncGlobals.numGuildRanks .. "?" .. GRMsyncGlobals.SyncQue[1];
                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );

                    -- Build Hash Comparison string
                    -- Initializing
                    -- GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 10 , 5 );
                    C_Timer.After ( 1 , function()

                        if not GRMsyncGlobals.errorCheckEnabled then
                            GRMsync.ErrorCheck();
                            GRMsyncGlobals.errorCheckEnabled = true;
                        end

                        GRMsync.SendOverallDataHashes();
                    end);

                else
                    return;
                end

            else
                GRMsyncGlobals.currentlySyncing = false;
                GRMsyncGlobals.errorCheckEnabled = false;
                GRMsyncGlobals.guildData = {};          -- Clearing the sync DB backup as it is a lot of info to just have sitting in memory
                GRMsyncGlobals.formerGuildData = {};
                GRMsyncGlobals.guildAltData = {};

                if #GRMsyncGlobals.SyncQue > 1 then
                    local msg = GRM.L ( "GRM:" ) .. " " .. GRM.L ( "Sync Failed with {name}..." , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] , true ) );
                    table.remove ( GRMsyncGlobals.SyncQue , 1 );
                    if GRM.S().syncChatEnabled then
                        GRM.Report ( msg .. "\n" .. GRM.L ( "The Player Appears to Be Offline." ) .. "\n" .. GRM.L ( "Initiating Sync with {name} Instead!" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
                    end
                    GRMsync.SendQueUpdate();

                    GRMsyncGlobals.currentlySyncing = false;
                    C_Timer.After ( 3 , function()
                        -- GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Currently Syncing With: {name}" , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
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
                    -- if not GRMsyncGlobals.SyncTracker.finish then
                    --     GRMsyncGlobals.ProgressControl ( "FINISH" );
                    -- end
                    GRM_UI.RefreshSelectFrames ( true , true , true , true , true , true );
                end
            end
        end
    end
end

-- Method:          GRMsync.SubmitFinalJoinDateData ( int , int )
-- What it Does:    Sends the final Join Date data
-- Purpose:         Sync Data
GRMsync.SubmitFinalJoinDateData = function( messageCount , index )
    index = index or 1;
    messageCount = messageCount or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    -- BAN changes sync!
    if #GRMsyncGlobals.JDChanges > 0 then
        local msg = "";

        -- if not GRMsyncGlobals.SyncTracker.finalJD then
        --     GRMsyncGlobals.ProgressControl ( "FINALJD" );
        -- end

        for i = index , #GRMsyncGlobals.JDChanges do
            msg = "";

            if GRMsyncGlobals.SyncOK then

                if not GRMsyncGlobals.JDChanges[i][4] then
                    -- { name , standardTimeStamp , epochTimeStamp }
                    if GRMsync.IsCompatibleToShareData ( false , false , false , true ) then
                        GRMsync.CheckJoinDateChange ( GRMsyncGlobals.JDChanges[i] , nil , "GRM_JDSYNCUP" );
                    end
                else
                    msg = "GRM_JDSYNCUP?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.JDChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.JDChanges[i][2] ) .. "?" .. GRMsyncGlobals.JDChanges[i][3] .. "?" .. messageCount;

                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.JDFINAL[messageCount] = msg;
                    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
                    messageCount = messageCount + 1;

                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;

                        index = i + 1;

                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRMsync.SubmitFinalJoinDateData( messageCount , index );
                        end);
                        return;
                    end
                end
            else
                return;
            end
            GRM.AuditRefreshTracker();
        end
    end

    -- if GRMsyncGlobals.TrackerData.JD[1] then
    --     GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.JD[1] , GRMsyncGlobals.TrackerData.JD[3] );
    -- end

    GRMsync.SubmitFinalPromoDateData();
end

-- Method:          GRMsync.SubmitFinalPromoDateData ( int , int )
-- What it Does:    Sends the final Promote Date data
-- Purpose:         Sync Data
GRMsync.SubmitFinalPromoDateData = function( messageCount , index )
    index = index or 1;
    messageCount = messageCount or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    -- BAN changes sync!
    if #GRMsyncGlobals.PDChanges > 0 then
        local msg = "";

        -- if not GRMsyncGlobals.SyncTracker.finalPD then
        --     GRMsyncGlobals.ProgressControl ( "FINALPD" );
        -- end

        for i = index , #GRMsyncGlobals.PDChanges do
            msg = "";

            if GRMsyncGlobals.SyncOK then

                if not GRMsyncGlobals.PDChanges[i][4] then

                    -- { name , standardTimeStamp , epochTimeStamp }
                    if GRMsync.IsCompatibleToShareData ( false , false , false , true ) then
                        GRMsync.CheckPromotionDateChange ( GRMsyncGlobals.PDChanges[i] , nil , "GRM_PDSYNCUP" );
                    end

                else

                    msg = "GRM_PDSYNCUP?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.PDChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.PDChanges[i][2] ) .. "?" .. GRMsyncGlobals.PDChanges[i][3] .. "?" .. messageCount;

                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.PDFINAL[messageCount] = msg;
                    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
                    messageCount = messageCount + 1;

                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;

                        index = i + 1;

                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRMsync.SubmitFinalPromoDateData( messageCount , index );
                        end);
                        return;
                    end
                end
            else
                return;
            end
            GRM.AuditRefreshTracker();
        end
    end

    -- if GRMsyncGlobals.TrackerData.PD[1] then
    --     GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.PD[1] , GRMsyncGlobals.TrackerData.PD[3] );
    -- end

    GRMsync.SubmitFinalAltNoGroupAndMainOnly();
end

-- Method:          GRMsync.SubmitFinalAltNoGroupAndMainOnly ( int , int , int )
-- What it Does:    Sends the final alt details, just the ones not in a group and the ones only as main
-- Purpose:         Syncing alt data.
GRMsync.SubmitFinalAltNoGroupAndMainOnly = function ( messageCount , index , position )
    messageCount = messageCount or 1;
    index = index or 1;
    position = position or 1;

    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local msg = "";

    -- if not GRMsyncGlobals.SyncTracker.finalAlts then
    --     GRMsyncGlobals.ProgressControl ( "FINALALT" );
    -- end

    if position == 1 and #GRMsyncGlobals.AltChangesNoGroup > 0 then

        for i = index , #GRMsyncGlobals.AltChangesNoGroup do
            msg = "";

            if GRMsyncGlobals.SyncOK then

                if not GRMsyncGlobals.AltChangesNoGroup[i][3] then
                    if GRMsync.IsCompatibleToShareData ( false , false , false , true ) then
                        GRMsync.CheckFinalAltMainAndNotGroupChanges ( GRMsyncGlobals.AltChangesNoGroup[i] , "GRM_ALTSYNCUP1" , true );
                    end
                else
                    msg = "GRM_ALTSYNCUP1?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.AltChangesNoGroup[i][1] .. "?" .. tostring ( GRMsyncGlobals.AltChangesNoGroup[i][2] ) .. "?" .. messageCount;

                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.ALTFINAL[messageCount] = msg;
                    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
                    messageCount = messageCount + 1;

                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()

                            index = i + 1;

                            GRMsync.SubmitFinalAltNoGroupAndMainOnly( messageCount , index , position );
                        end);
                        return;
                    end
                end
            else
                return;
            end
            GRM.AuditRefreshTracker();
        end
    end
    position = 2;

    if #GRMsyncGlobals.AltChangesMainOnly > 0 then
        -- if not GRMsyncGlobals.SyncTracker.finalAlts then
        --     GRMsyncGlobals.ProgressControl ( "FINALALT" );
        -- end

        for i = index , #GRMsyncGlobals.AltChangesMainOnly do
            msg = "";

            if GRMsyncGlobals.SyncOK then

                if not GRMsyncGlobals.AltChangesMainOnly[i][3] then
                    if GRMsync.IsCompatibleToShareData ( false , false , false , true ) then
                        GRMsync.CheckFinalAltMainAndNotGroupChanges ( GRMsyncGlobals.AltChangesMainOnly[i] , "GRM_ALTSYNCUP2" , true );
                    end
                else
                    msg = "GRM_ALTSYNCUP2?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.AltChangesMainOnly[i][1] .. "?" .. tostring ( GRMsyncGlobals.AltChangesMainOnly[i][2] ) .. "?" .. messageCount;

                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;

                    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
                    GRMsyncGlobals.messageTree.ALTFINAL[messageCount] = msg;
                    messageCount = messageCount + 1;

                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()

                            index = i + 1;

                            GRMsync.SubmitFinalAltNoGroupAndMainOnly( messageCount , index , position );
                        end);
                        return;
                    end
                end
            else
                return;
            end
            GRM.AuditRefreshTracker();
        end
    end

    if not GRMsyncGlobals.SyncOK then
        return;
    end

    -- if GRMsyncGlobals.TrackerData.ALT[1] then
    --     GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.ALT[1] , GRMsyncGlobals.TrackerData.ALT[3] );
    -- end

    GRMsync.SubmitFinalAltFullGroups( messageCount );
end

-- Method:          GRMsync.SubmitFinalAltFullGroups ( int , int , int , int )
-- What it Does:    Submits the full alt group details
-- Purpose:         Properly send data
GRMsync.SubmitFinalAltFullGroups = function( messageCount , index , index2 , position )
    messageCount = messageCount or 1;
    index = index or 1;
    index2 = index2 or 2;
    position = position or 1;

    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local syncMessage = "";
    local tempMessage = "";
    local main = "";

    -- if not GRMsyncGlobals.SyncTracker.finalAlts then
    --     GRMsyncGlobals.ProgressControl ( "FINALALT" );
    -- end

    if position == 1 and #GRMsyncGlobals.AltChangesFullGroup > 0 then

        for i = index , #GRMsyncGlobals.AltChangesFullGroup do

            if GRMsyncGlobals.SyncOK then

                if GRMsyncGlobals.AltChangesFullGroup[i][1].main == "" then
                    main = "#";
                else
                    main = GRMsyncGlobals.AltChangesFullGroup[i][1].main;
                end

                -- if not, then it is not my date, thus I need to update.
                if not GRMsyncGlobals.AltChangesFullGroup[i][2] then
                    if GRMsync.IsCompatibleToShareData ( false , false , false , true ) then
                        GRMsync.CheckFinalAltFullGroupChanges ( GRMsyncGlobals.AltChangesFullGroup[i][1] , "GRM_ALTSYNCUP3" , #GRMsyncGlobals.AltChangesFullGroup[i][1] - 1 , true );
                    end
                else
                    syncMessage = "GRM_ALTSYNCUP3?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.AltChangesFullGroup[i][1][1] .. "?" .. main .. "?" .. GRMsyncGlobals.AltChangesFullGroup[i][1].timeModified .. "?" .. tostring ( #GRMsyncGlobals.AltChangesFullGroup[i][1] - 1 ) .. "?" .. messageCount;

                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;

                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );

                    GRMsyncGlobals.messageTree.ALTFINAL[messageCount] = syncMessage;
                    messageCount = messageCount + 1;
                    syncMessage = "";

                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;
                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()

                            index = i + 1;

                            GRMsync.SubmitFinalAltFullGroups( messageCount , index , index2 , position );
                        end);
                        return;
                    end
                end
            else
                return;
            end
            index = 1;
        end
    end
    position = 2;

    if #GRMsyncGlobals.AltChangesFullGroup > 0 then
        for i = index , #GRMsyncGlobals.AltChangesFullGroup do

            if not GRMsyncGlobals.AltChangesFullGroup[i][2] then
                if GRMsync.IsCompatibleToShareData ( false , false , false , true ) then
                    GRMsync.CheckFinalAltFullGroupChanges ( GRMsyncGlobals.AltChangesFullGroup[i][1] , "GRM_ALTSYNCUP4" , #GRMsyncGlobals.AltChangesFullGroup[i][1] - 1 , true );
                end
            else

                for j = index2 , #GRMsyncGlobals.AltChangesFullGroup[i][1] do
                    if GRMsyncGlobals.SyncOK then

                        if syncMessage == "" then
                            syncMessage = "GRM_ALTSYNCUP4" .. "?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.AltChangesFullGroup[i][1][1];
                        end

                        tempMessage = syncMessage .. "?" .. GRMsyncGlobals.AltChangesFullGroup[i][1][j];

                        if ( #tempMessage + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 1 ) < 255 then
                            syncMessage = tempMessage;
                        else
                            -- Do not add the new name, just send the syncMessage
                            syncMessage = syncMessage .. "?" .. messageCount;
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsyncGlobals.messageTree.ALTFINAL[messageCount] = syncMessage;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
                            messageCount = messageCount + 1;

                            syncMessage = "GRM_ALTSYNCUP4" .. "?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.AltChangesFullGroup[i][1][1] .. "?" .. GRMsyncGlobals.AltChangesFullGroup[i][1][j];
                        end

                        -- If at the end of the alt Group, we need to send, even if not a full string.
                        if j == #GRMsyncGlobals.AltChangesFullGroup[i][1] then
                            syncMessage = syncMessage .. "?" .. messageCount;
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                            GRMsyncGlobals.messageTree.ALTFINAL[messageCount] = syncMessage;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
                            messageCount = messageCount + 1;

                            syncMessage = "";
                            index2 = 2;
                        end

                        -- Check if there needs to be a throttled delay
                        if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                            GRMsyncGlobals.syncTempDelay = true;

                            if j == #GRMsyncGlobals.AltChangesFullGroup[i][1] then
                                index = i + 1;
                            else
                                index = i;
                                index2 = j; -- j was already set to 2 otherwise
                            end

                            GRMsyncGlobals.SyncCount = 0;
                            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                                GRMsync.SubmitFinalAltFullGroups ( messageCount , index , index2 , position );
                            end);
                            return;
                        end
                    else
                        return;
                    end
                end
            end
        end
    end
    GRMsync.ProcessFinalAltChanges();     -- Can process now since I have them.
    GRMsync.SubmitFinalCustNoteData();
end

-- Method:          GRMsync.ProcessFinalAltChanges()
-- What it Does:    Processing the final sync changes
-- Purpose:         Finalyzing sync changes
GRMsync.ProcessFinalAltChanges = function( sendCompletedMsg )

    local guildData = GRM.GetGuild();           -- Use current guild, not preliminary sync guild data as it will be updated
    local currentAltGroup;
    local player;
    local groupID = "";

    for leadName , finalAltGroup in pairs ( GRMsyncGlobals.FinalAltListReceived ) do

        if #finalAltGroup.alts == finalAltGroup.numAlts then  -- Validate all sync data arrived.
            currentAltGroup = GRM.GetAltGroup ( guildData[leadName].altGroup );

            -- VERIFICATION CHECK TO PREVENT ERRORS
            if currentAltGroup then
                if not GRM.IsPlayerInAltGroup( guildData[leadName].altGroup , leadName ) then
                    -- Problem here... player has an altGroup data point, but player is NOT in the alt Group.
                    if #currentAltGroup == 0 then
                        -- REMOVE ALT GROUP COMPLETELY
                        GRM.RemoveAltGroup ( guildData[leadName].altGroup , 0 );
                    end

                    guildData[leadName].altGroup = "";
                    currentAltGroup = nil;
                end
            end

            if currentAltGroup then

                GRM.RemovePlayerFromAltGroup ( leadName , 0 , false , false , true );
                GRM.CreateAltGroup ( leadName , ( finalAltGroup.main == leadName ) , finalAltGroup.timeModified );
                groupID = GRM.GetPlayer ( leadName ).altGroup;
                GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;

                for i = 1 , #finalAltGroup.alts do
                    player = GRM.GetPlayer ( finalAltGroup.alts[i] )

                    GRM.RemovePlayerFromAltGroup ( finalAltGroup.alts[i] , 0 , false , false , true );
                    GRM.AddPlayerToAltGroup ( player , groupID , finalAltGroup.timeModified , ( finalAltGroup.main == finalAltGroup.alts[i] ) );
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                    GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;
                end
            else
                -- If not already in an alt group, then all I need to do is create the alt group
                -- After creating, then cycle through all names in alts and add them.
                GRM.CreateAltGroup ( leadName , ( finalAltGroup.main == leadName ) , finalAltGroup.timeModified ); -- name , setAsMain , epochTimeStamp
                groupID = GRM.GetPlayer ( leadName ).altGroup;

                for i = 1 , #finalAltGroup.alts do

                    GRM.RemovePlayerFromAltGroup ( finalAltGroup.alts[i] , 0 , false , false , true ); -- need to remove in case they are a main, as it messes with the add alt logic.
                    player = GRM.GetPlayer ( finalAltGroup.alts[i] )
                    GRM.AddPlayerToAltGroup ( player , groupID , finalAltGroup.timeModified , ( finalAltGroup.main == finalAltGroup.alts[i] ) );
                    GRMsyncGlobals.updateCount = GRMsyncGlobals.updateCount + 1;
                    GRMsyncGlobals.updatesEach[3] = GRMsyncGlobals.updatesEach[3] + 1;
                end
            end
        end
    end

    if GRM.TableLength ( GRMsyncGlobals.FinalAltListReceived ) > 0 then
        GRMsync.UnifyBirthdaysAmongAltGroups();
    end
    if sendCompletedMsg then
        local msg = "GRM_ALTPROCESSED?" .. GRMsyncGlobals.syncRankFilter .. "?";
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
        GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
    end

end

-- Method:          GRMsync.UnifyBirthdaysAmongAltGroups()
-- What it Does:    Unifies the birthdates of the alt groups
-- Purpose:         Ensures the latest bday data is updated
GRMsync.UnifyBirthdaysAmongAltGroups = function()
    local alts = GRM.GetGuildAlts();
    local guildData = GRM.GetGuild();
    local newest = { "" , 0 , 0 , 0 };  -- { name , day , month , customDescription , epochTimeStamp }
    local player;
    local hasBdaySet = false;
    local needToRemoveFromQue = false;

    for altGroupID , altGroup in pairs ( alts ) do
        hasBdaySet = false;
        newest = { "" , 0 , 0 , "" , 0 };

        if #altGroup > 1 then
            for i = 1 , #altGroup do
                player = guildData[ altGroup[i].name ];
                if player and player.events[2][4] > 0 and player.events[2][4] > newest[2] then
                    newest = { player.name , player.events[2][1][1] , player.events[2][1][2] , player.events[2][3] , player.events[2][4] };
                    hasBdaySet = true;
                end
            end
        end

        if hasBdaySet then
            for i = 1 , #altGroup do
                if altGroup[i].name ~= newest[1] then
                    player = GRM.GetPlayer ( altGroup[i].name );

                    needToRemoveFromQue = false

                    if player.events[2][1][1] ~= newest[2] then
                        needToRemoveFromQue = true;
                        player.events[2][1][1] = newest[2];
                        player.events[2][2] = false;        -- Have it re-report if timestamp is getting updated - but only date
                    end
                    if player.events[2][1][2] ~= newest[3] then
                        needToRemoveFromQue = true;
                        player.events[2][1][2] = newest[3];
                        player.events[2][2] = false;        -- Have it re-report if timestamp is getting updated - but only date
                    end
                    if player.events[2][3] ~= newest[4] then
                        needToRemoveFromQue = true;
                        player.events[2][3] = newest[4];
                    end
                    if player.events[2][4] ~= newest[5] then
                        needToRemoveFromQue = true;
                        player.events[2][4] = newest[5];
                    end

                    if needToRemoveFromQue then
                        if player.birthdayUnknown then
                            player.birthdayUnknown = false
                        end
                        GRM.RemoveFromCalendarQue ( player.name , 2 , nil );
                    end
                end
            end
        end

    end
end

-- Method:          GRMsync.SubmitFinalCustNoteData( int , int );
-- What it Does:    Processes the final result of the sync details
-- Purpose:         Sync data
GRMsync.SubmitFinalCustNoteData = function( messageCount , index )
    index = index or 1;
    messageCount = messageCount or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    -- BAN changes sync!
    if #GRMsyncGlobals.CustomNoteChanges > 0 then
        local syncMessage = "";
        local customNote = "";
        local customNote2 = "";
        local prefix = "";

        -- if not GRMsyncGlobals.SyncTracker.finalCust then
        --     GRMsyncGlobals.ProgressControl ( "FINALCUST" );
        -- end

        for i = index , #GRMsyncGlobals.CustomNoteChanges do       -- { playerName , timeStampOfChange , whoEdited , customNote , isMyData }
            syncMessage = "";
            customNote = "";
            customNote2 = "";
            prefix = "GRM_CUSTSYNCUP1?" -- indicates the custom note is less than 100 chars

            if GRMsyncGlobals.SyncOK then

                if not GRMsyncGlobals.CustomNoteChanges[i][5] then

                    -- { name , epochTimeStamp , standardTimeStamp }
                    if GRMsync.IsCompatibleToShareData ( false , false , false , false , true ) then
                        GRMsync.CheckCustomNoteSyncChange ( GRMsyncGlobals.CustomNoteChanges[i] , nil , false );
                    end

                else

                    if GRMsyncGlobals.CustomNoteChanges[i][4] == "" then
                        customNote = "#";
                    else
                        customNote = GRMsyncGlobals.CustomNoteChanges[i][4];
                    end

                    if #customNote > 99 then
                        prefix = "GRM_CUSTSYNCUP2?"      -- This will indicate that the remaining message is coming still
                        customNote2 = string.sub ( customNote , 100 );
                        customNote = string.sub ( customNote , 1 , 99 );
                    end
                    -- playerName , timeStampOfChange , whoEdited , customNote , messageCount
                    syncMessage = prefix .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.CustomNoteChanges[i][1] .. "~|~" .. tostring ( GRMsyncGlobals.CustomNoteChanges[i][2] ) .. "~|~" .. GRMsyncGlobals.CustomNoteChanges[i][3] .. "~|~" .. customNote .. "~|~" .. messageCount;

                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.CUSTFINAL[messageCount] = syncMessage;
                    GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
                    messageCount = messageCount + 1;

                    if customNote2 ~= "" then
                        syncMessage = "GRM_CUSTSYNCUP3?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.CustomNoteChanges[i][1] .. "~|~" .. customNote2  .. "~|~" .. messageCount;
                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsyncGlobals.messageTree.CUSTFINAL[messageCount] = syncMessage;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
                        messageCount = messageCount + 1;
                    end

                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;

                        index = i + 1;

                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRMsync.SubmitFinalCustNoteData( messageCount , index );
                        end);
                        return;
                    end
                end
            else
                return;
            end
        end
    end

    -- if GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] then
    --     GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] );
    -- end

    GRMsync.SubmitFinalBansData();
end

-- Method:          GRMsync.SubmitFinalBansData ( int , int )
-- What it Does:    Sends the final ban data
-- Purpose:         Sync Data
GRMsync.SubmitFinalBansData = function( messageCount , index )
    index = index or 1;
    messageCount = messageCount or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    -- BAN changes sync!
    if #GRMsyncGlobals.BanChanges > 0 then

        -- if not GRMsyncGlobals.SyncTracker.finalBan then
        --     GRMsyncGlobals.ProgressControl ( "FINALBAN" );
        -- end

        if GRMsync.IsCompatibleToShareData ( false , false , false , false , false , true ) then

            local syncMessage = "";
            local syncMessage2 = "";
            local tempMessage = "";
            local tempMessage2 = "";
            local prefix = "";

            local reasonMsg = "";
            local playerWhoBanned = "";
            local rankName = "";
            local rankIndex = "";
            local joinDateStandardFormat = "";
            local reason = "";

            for i = index , #GRMsyncGlobals.BanChanges do
                syncMessage = "";
                syncMessage2 = "";

                if GRMsyncGlobals.SyncOK then

                    -- playerData = { rankName , rankIndex , level , classIndex , standardDate , originalJoinEpoch , GUID };
                    -- BanChanges = { playerName , banTimeEpoch , banType , reason , playerWhoBanned , playerData , myData } );

                    if #GRMsyncGlobals.BanChanges[i][6] > 0 then        -- formerMember - fullPlayerDetails 1,2,3
                        prefix = "GRM_BANSYNCUP1";
                    else                                                -- Current member - Syncup 4,5,6
                        prefix = "GRM_BANSYNCUP4";
                    end

                    if not GRMsyncGlobals.BanChanges[i][7] then
                        -- NOT LEADER'S DATA, thus leader should update.
                        -- Leader needs to update the received data, but no reason to send back.
                        if prefix == "GRM_BANSYNCUP1" then
                            GRMsync.BanManagement ( { GRMsyncGlobals.BanChanges[i][1] , GRMsyncGlobals.BanChanges[i][2] , GRMsyncGlobals.BanChanges[i][3] , GRMsyncGlobals.BanChanges[i][5] , GRMsyncGlobals.BanChanges[i][6][1] , GRMsyncGlobals.BanChanges[i][6][2] , GRMsyncGlobals.BanChanges[i][6][3] , GRMsyncGlobals.BanChanges[i][6][4] , GRMsyncGlobals.BanChanges[i][6][5] , GRMsyncGlobals.BanChanges[i][6][6] , GRMsyncGlobals.BanChanges[i][6][7] , GRMsyncGlobals.BanChanges[i][4] } , prefix , GRMsyncGlobals.CurrentSyncPlayer );

                        elseif prefix == "GRM_BANSYNCUP4" then
                            GRMsync.BanManagement ( { GRMsyncGlobals.BanChanges[i][1] , GRMsyncGlobals.BanChanges[i][2] , GRMsyncGlobals.BanChanges[i][3] , GRMsyncGlobals.BanChanges[i][5] , GRMsyncGlobals.BanChanges[i][4] } , prefix , GRMsyncGlobals.CurrentSyncPlayer );
                        end

                    else

                        if prefix == "GRM_BANSYNCUP1" then

                            GUID = GRMsyncGlobals.BanChanges[i][6][7];
                            if GUID == "" then
                                GUID = "#";
                            else
                                GUID = string.sub ( GUID , 8 )
                            end

                            reason = GRMsyncGlobals.BanChanges[i][4];
                            if reason == "" then
                                reason = "###";
                            end

                            playerWhoBanned = GRMsyncGlobals.BanChanges[i][5];
                            if playerWhoBanned == "" then
                                playerWhoBanned = "#";
                            end

                            rankIndex = GRMsyncGlobals.BanChanges[i][6][2];
                            if rankIndex == 99 then
                                rankName = "##";
                            else
                                rankName = GRMsyncGlobals.BanChanges[i][6][1];
                            end

                            -- { playerName , banTimeEpoch , banType , playerWhoBanned , rankName , rankIndex , level , classIndex , standardDate , originalJoinEpoch , GUID , reason }
                            tempMessage = prefix .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?";
                            tempMessage2 = GRMsyncGlobals.BanChanges[i][1] .. "~|~" .. GRMsyncGlobals.BanChanges[i][2] .. "~|~" .. GRMsyncGlobals.BanChanges[i][3] .. "~|~" .. playerWhoBanned .. "~|~" .. rankName .. "~|~" .. rankIndex .. "~|~" .. GRMsyncGlobals.BanChanges[i][6][3] .. "~|~" .. GRMsyncGlobals.BanChanges[i][6][4] .. "~|~" .. GRMsyncGlobals.BanChanges[i][6][5] .. "~|~" .. GRMsyncGlobals.BanChanges[i][6][6] .. "~|~" .. GUID;
                            reasonMsg = "~|~" .. reason;

                            if ( #tempMessage + #tempMessage2 + #reasonMsg + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 3 ) < 255 then
                                syncMessage = tempMessage .. tempMessage2 .. reasonMsg .. "~|~" .. messageCount;
                            else
                                syncMessage = "GRM_BANSYNCUP2?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. tempMessage2 .. "~|~" .. messageCount;
                                syncMessage2 = "GRM_BANSYNCUP3?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. players[i][2] .. "~|~" ..reasonMsg;
                            end

                        elseif prefix == "GRM_BANSYNCUP4" then
                            playerWhoBanned = GRMsyncGlobals.BanChanges[i][5];
                            if playerWhoBanned == "" then
                                playerWhoBanned = "#";
                            end

                            reason = GRMsyncGlobals.BanChanges[i][4];
                            if reason == "" then
                                reason = "###";
                            end

                            tempMessage = prefix .. "?" .. tostring ( GRM.S().syncRankBanList ) .. "?";
                            tempMessage2 = GRMsyncGlobals.BanChanges[i][1] .. "~|~" .. GRMsyncGlobals.BanChanges[i][2] .. "~|~" .. GRMsyncGlobals.BanChanges[i][3] .. "~|~" .. playerWhoBanned;
                            reasonMsg = "~|~" .. reason;

                            if ( #tempMessage + #tempMessage2 + #reasonMsg + GRMsyncGlobals.sizeModifier + GRMsync.GetNumDigits(messageCount) + 3 ) < 255 then
                                syncMessage = tempMessage .. tempMessage2 .. reasonMsg .. "~|~" .. messageCount;
                            else
                                syncMessage = "GRM_BANSYNCUP5?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. tempMessage2 .. "~|~" .. messageCount;
                                syncMessage2 = "GRM_BANSYNCUP6?" .. tostring ( GRM.S().syncRankBanList ) .. "?" .. players[i][2] .. "~|~" ..reasonMsg;
                            end

                        end

                        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage + GRMsyncGlobals.sizeModifier;
                        GRMsyncGlobals.messageTree.BANFINAL[messageCount] = syncMessage;
                        GRMsync.SendMessage ( "GRM_SYNC" , syncMessage , GRMsyncGlobals.CurrentSyncPlayer );
                        messageCount = messageCount + 1;

                        if syncMessage2 ~= "" then
                            syncMessage2 = syncMessage2 .. "~|~" .. messageCount;
                            GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #syncMessage2 + GRMsyncGlobals.sizeModifier;
                            GRMsyncGlobals.messageTree.BANFINAL[messageCount] = syncMessage2;
                            GRMsync.SendMessage ( "GRM_SYNC" , syncMessage2 , GRMsyncGlobals.CurrentSyncPlayer );
                            messageCount = messageCount + 1;
                        end

                        if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                            GRMsyncGlobals.syncTempDelay = true;

                            index = i + 1;

                            GRMsyncGlobals.SyncCount = 0;
                            C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                                GRMsync.SubmitFinalBansData ( messageCount , index );
                            end);
                            return;
                        end

                    end

                else
                    return;
                end
            end
        end
    end
    GRMsync.SendDataCompletionMsg();
end

-- Method:          GRMsync.SendDataCompletionMsg()
-- What it Does:    Sendds the details of how many messages sent
-- Purpose:         Sync integrity so messages can be resent
GRMsync.SendDataCompletionMsg = function()
    local msg = "GRM_FINALSTOP?" .. GRMsyncGlobals.syncRankFilter .. "?" .. #GRMsyncGlobals.messageTree.JDFINAL .. "?" .. #GRMsyncGlobals.messageTree.PDFINAL .. "?" .. #GRMsyncGlobals.messageTree.ALTFINAL .. "?" .. #GRMsyncGlobals.messageTree.CUSTFINAL .. "?" .. #GRMsyncGlobals.messageTree.BANFINAL;
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.CurrentSyncPlayer );
end

-- Method:          GRMsync.SubmitFinalSyncData()
-- What it Does:    Sends out the mandatory updates to all online (they won't if the change is already there)
-- Purpose:         So leader can send out current, updated sync info.
GRMsync.SubmitFinalSyncData = function ()

    if not GRMsyncGlobals.SyncPath[5] then -- 5 = birthdays. However, they would have been already been sent if there were NO alt changes.
        -- no bday
        GRMsync.FinalSyncComplete();
    else
        local former = {};
        GRMsyncGlobals.guildData = nil;
        GRMsyncGlobals.guildData , former , GRMsyncGlobals.guildAltData = GRM.convertToArrayFormat( false , true );           -- Reprocess the guild with the new alt changes
        GRMsync.PreCheckHashValues[5] = GRMsync.GetCustomPseudoHash( "bday" )[5];       -- Set the hash values for precheck
        GRMsync.SendPrecheckData ( nil , 5 , nil , true );                              -- Sending the full Bday Hash values precheck
    end
end

-- Method:          GRMsync.SubmitFinalBdayData( int , int )
-- What it Does:    Sends out all of the current birthday info as determined by sync process
-- Purpose:         Sync birthdate info
GRMsync.SubmitFinalBdayData = function ( messageCount , index )
    index = index or 1;
    messageCount = messageCount or 1;
    GRMsyncGlobals.TimeSinceLastSyncAction = time();

    -- BAN changes sync!
    if #GRMsyncGlobals.BDayChanges > 0 then
        local msg = "";

        -- if not GRMsyncGlobals.SyncTracker.finalPD then
        --     GRMsyncGlobals.ProgressControl ( "FINALPD" );
        -- end

        for i = index , #GRMsyncGlobals.BDayChanges do
            msg = "";

            if GRMsyncGlobals.SyncOK then
                if not GRMsyncGlobals.BDayChanges[i][5] then
                    if GRMsync.IsCompatibleToShareData ( false , false , false , true ) then
                        GRMsync.CheckBirthdayForSync ( GRMsyncGlobals.BDayChanges[i] );
                    end

                else
                    msg = "GRM_BDSYNCUP?" .. GRMsyncGlobals.syncRankFilter .. "?" .. GRMsyncGlobals.BDayChanges[i][1] .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][2] ) .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][3] ) .. "?" .. tostring ( GRMsyncGlobals.BDayChanges[i][4] ) .. "?" .. messageCount;

                    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                    GRMsyncGlobals.messageTree.BDAYFINAL[messageCount] = msg;
                    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer )
                    messageCount = messageCount + 1;

                    if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                        GRMsyncGlobals.SyncCount = 0;

                        index = i + 1;

                        C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                            GRMsync.SubmitFinalBdayData( messageCount , index );
                        end);
                        return;
                    end
                end
            else
                return;
            end
            GRM.AuditRefreshTracker();
        end
    end

    -- if GRMsyncGlobals.TrackerData.BDAY[1] then
    --     GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.BDAY[1] , GRMsyncGlobals.TrackerData.BDAY[3] );
    -- end
    GRMsync.SendDataCompletionMsgBday();
end

-- Method:          GRMsync.SendDataCompletionMsg()
-- What it Does:    Sendds the details of how many messages sent
-- Purpose:         Sync integrity so messages can be resent
GRMsync.SendDataCompletionMsgBday = function()
    local msg = "GRM_FINALSTOP2?" .. GRMsyncGlobals.syncRankFilter .. "?" .. #GRMsyncGlobals.messageTree.BDAYFINAL;
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.CurrentSyncPlayer );
end

-- Method:          GRMsync.FinalBdayMessagesVerifiedSendComplete()
-- What it Does:    It sends the verification back to the Sync leader to confirm end of the sync process
-- Purpose:         The sync leader is the one who initiates sync completion.
GRMsync.FinalBdayMessagesVerifiedSendComplete = function()
    local msg = "GRM_FINALSTOP3?" .. GRMsyncGlobals.syncRankFilter .. "?";
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
    GRMsync.SendMessage ( "GRM_SYNC" , msg  , GRMsyncGlobals.DesignatedLeader );
end
-- Method:          GRMsync.FinalSyncComplete()
-- What it Does:    Completes the sync and moves on to the next player requesting sync who maybe just logged on
-- Purpose:         Control sync properly.
GRMsync.FinalSyncComplete = function()
    -- Ok all done! Reset the tables!
    GRMsync.ResetReportTables();
    GRMsyncGlobals.dateSentComplete = false;

    -----------------------------------

    local nameOfCurrentSyncSender = GRMsyncGlobals.SyncQue[1];
    -- This will be reset if sync is being retriggered.
    if nameOfCurrentSyncSender ~= nil then
        local tempMsg = "GRM_COMPLETE?" .. GRMsyncGlobals.numGuildRanks .. "?" .. nameOfCurrentSyncSender;
        GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #tempMsg + GRMsyncGlobals.sizeModifier;
        GRMsync.SendMessage ( "GRM_SYNC" , tempMsg , nameOfCurrentSyncSender );

        -- We made it... remove from the syncQue
        if #GRMsyncGlobals.SyncQue > 1 then
            table.remove ( GRMsyncGlobals.SyncQue , 1 );

            if GRM.S().syncChatEnabled then
                GRM.Report ( GRM.L ( "Sync with {name} complete." , GRM.GetClassifiedName ( nameOfCurrentSyncSender ) ) );
                GRM.Report ( GRM.L ( "Sync with {name} next." , GRM.GetClassifiedName ( GRMsyncGlobals.SyncQue[1] ) ) );
            end

            -- if GRM_UI.GRM_SyncTrackerWindow:IsVisible() then
            --     GRM_UI.GRM_SyncTrackerWindow.SyncTrackerText:SetText ( GRM.L ( "Sync with {name} Successful" , GRM.GetClassifiedName ( GRMsyncGlobals.CurrentSyncPlayer ) ) );
            --     GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , 0.5 , { 0.42 , 0.92 , 1 } );
            -- end

            GRMsync.SendQueUpdate();
            C_Timer.After ( 3 , function()
                GRMsyncGlobals.currentlySyncing = false;
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

-- Method:          GRMsync.UpdateLeftPlayerInfo ( table )
-- What it Does:    If a player needs to ban or unban a player, it cannot do so if they are not on their list, as maybe it was a person that left the guild before they had addon installed or before they joined> this fixes the gap
-- Purpose:         To maintain a ban list properly, even for those who installed the addon later, or joined the guild later. The "Left Players" would not have them stored. This syncs that, but ONLY as needed, not all left players
--                  as this prevents left player storage bloat unnecessarily and only syncs the banned or unbanned ones.
GRMsync.UpdateLeftPlayerInfo = function ( playerData )

    local playerName = playerData[1];
    local rankName = playerData[2];
    local rankIndex = playerData[3];
    local level = playerData[4];
    local classIndex = playerData[5];
    local standardDate = playerData[6];
    local originalJoinEpoch = playerData[7];
    local GUID = playerData[8];

    -- Ok, let's check if this player is already known...
    local player = GRM.GetFormerPlayer ( playerName );

    if not player then

        local class = "";
        if classIndex == 0 then
            if C_PlayerInfo.GUIDIsPlayer ( GUID ) then
                class = GRM.GetPlayerClassByGUID ( GUID );
                if not class then
                    class = GRM.GetPlayerClassByGUID ( GUID );
                    if not class then
                        class = "";     -- Call it twice because sometimes server returns nil on the efirst call for some reason.
                        classIndex = 3;
                    end
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
        memberInfoToAdd.officerNote = "";
        memberInfoToAdd.class = class;                                          -- 7
        memberInfoToAdd.lastOnline = 1;                                         -- 8 Time since they last logged in in hours.
        memberInfoToAdd.lastOnlineTime = { 0 , 0 , 0 , 1 };
        memberInfoToAdd.zone = "";                                              -- 9
        memberInfoToAdd.achievementPoints = 100;                                -- 10
        memberInfoToAdd.rep = 4;                                                -- 12
        memberInfoToAdd.isOnline = false;                                       -- 13
        memberInfoToAdd.status = 3;                                             -- 14
        memberInfoToAdd.GUID = GUID;                                            -- 15
        memberInfoToAdd.race = "";                                              -- 16
        memberInfoToAdd.sex = 1;                                                -- 17
        memberInfoToAdd.rosterSelection = 0;                                    -- 18
        memberInfoToAdd.faction = GRM_G.faction;

        if GRM_G.BuildVersion >= 80000 then
            memberInfoToAdd.MythicScore = 0;
        end

        local day , month , year = GRM.ParseStandardFormatDate ( standardDate );
        GRM.AddMemberToLeftPlayers ( memberInfoToAdd , {day , month , year} , standardDate , originalJoinEpoch , nil , true );

        -- Need to be added to the temp tables to during sync.
        local player = GRM.GetFormerPlayer ( playerName );
        if player then
            table.insert ( GRMsyncGlobals.formerGuildData , player );
            sort ( GRMsyncGlobals.formerGuildData , function ( a , b ) return a.name < b.name end );
        end
    end
end

-- Method:          GRMsync.CollectBanData ( string , string )
-- What it Does:    Collects all of the ban sync data before analysis.
-- Purpose:         Need to aggregate the data so one only needs to parse through the tables once, rather than on each new piece of info added. Far more efficient.
GRMsync.CollectBanData = function ( msg , prefix )

    local indReceived = "";
    msg , indReceived = msg:match ( "(.+)%~|~(%d+)$" );   -- Parse out the msg num

    values = GRMsync.ParseAllSeparatedItems( msg , "~|~" );

    local playerName , classIndex , rankName , rankIndex , level , standardDate , originalJoinEpoch , GUID , banType , banTimeInEpoch , playerWhoBanned , reason;

    -- BAN/UNBAN scan of LEFT players
    if prefix == "GRM_BANSYNC1" or prefix == "GRM_BANSYNC2" then
        table.insert ( GRMsyncGlobals.messageIndexesReceived.BAN , tonumber ( indReceived ) );
        -- if not GRMsyncGlobals.SyncTracker.banData then
        --     GRMsyncGlobals.ProgressControl ( "BAN" );
        -- end
        playerName = values[1];
        classIndex = tonumber ( values[2] );
        rankName = values[3];
        rankIndex = tonumber ( values[4] );
        level = tonumber ( values[5] );
        standardDate = values[6];
        originalJoinEpoch = tonumber ( values[7] );
        GUID = values[8];
        banType = values[9];
        banTimeEpoch = tonumber ( values[10] );
        playerWhoBanned = values[11];

            -- Need some kind of placeholder standard date
        if standardDate == "0" then
            local dates = select ( 2 , GRM.GetTimestamp() );
            standardDate = GRM.ConvertToStandardFormatDate ( dates[1] , dates[2] , dates[3] );
        end

        if rankName == "##" then
            rankName = "";
        end

        if GUID == "#" then
            GUID = "";
        else
            GUID = "Player-" .. GUID;
        end

        if playerWhoBanned == "#" then
            playerWhoBanned = "";
        end
        local playerData = { rankName , rankIndex , level , classIndex , standardDate , originalJoinEpoch , GUID };

        if prefix == "GRM_BANSYNC1" then        -- All data was contained in a single message
            reason = values[12];
            if reason == "###" then
                reason = "";
            end

            table.insert ( GRMsyncGlobals.BanReceivedTemp , { playerName , banTimeEpoch , banType , reason , playerWhoBanned , playerData } );
        elseif prefix == "GRM_BANSYNC2" then    -- The Reason was not yet included
            table.insert ( GRMsyncGlobals.BanReceivedTemp2 , { playerName , banTimeEpoch , banType , "" , playerWhoBanned , playerData } );
        end
        -- Need to add them to player former members or update the file
        GRMsync.UpdateLeftPlayerInfo ( { playerName , rankName , rankIndex , level , classIndex , standardDate , originalJoinEpoch , GUID } );

    elseif prefix == "GRM_BANSYNC3" or prefix == "GRM_BANSYNC6" then
        playerName = values[1];
        reason = values[2];
        if reason == "###" then
            reason = "";
        end

        for i = #GRMsyncGlobals.BanReceivedTemp2 , 1 , -1 do        -- Start from the end since it is assumed the last entry was added at end
            if GRMsyncGlobals.BanReceivedTemp2[i][1] == playerName then
                table.insert ( GRMsyncGlobals.messageIndexesReceived.BAN , tonumber ( indReceived ) );  -- Only add received if player found - as such both get re-sent.
                GRMsyncGlobals.BanReceivedTemp2[i][4] = reason;
                table.insert ( GRMsyncGlobals.BanReceivedTemp , GRMsyncGlobals.BanReceivedTemp2[i] );
                break;
            end
        end

    elseif prefix == "GRM_BANSYNC4" or prefix == "GRM_BANSYNC5" then
        table.insert ( GRMsyncGlobals.messageIndexesReceived.BAN , tonumber ( indReceived ) );
        -- if not GRMsyncGlobals.SyncTracker.banData then
        --     GRMsyncGlobals.ProgressControl ( "BAN" );
        -- end
        playerName = values[1];
        banType = values[2];
        banTimeEpoch = tonumber ( values[3] );
        playerWhoBanned = values[4];

        if playerWhoBanned == "X" then
            playerWhoBanned = "";
        end

        if prefix == "GRM_BANSYNC4" then        -- All data was contained in a single message
            reason = values[5];
            if reason == "###" then
                reason = "";
            end

            table.insert ( GRMsyncGlobals.BanReceivedTemp , { playerName , banTimeEpoch , banType , reason , playerWhoBanned , {} } );
        elseif prefix == "GRM_BANSYNC5" then    -- The Reason was not yet included
            table.insert ( GRMsyncGlobals.BanReceivedTemp2 , { playerName , banTimeEpoch , banType , "" , playerWhoBanned , {} } );
        end

    end
end

-- Method:          GRMsync.CollectDataPacketsF ( string , string )
-- What it Does:    Collects the names of all the players sent who the player has no details on and adds to received array
-- Purpose:         When comparing data this helps determine whose data to accept.
GRMsync.CollectDataPacketsF = function ( msg , prefix )

    local dataTypes = { ["GRM_JDSYNCF"] = { "JD" , "JDF" , "JDReceivedNoDetailsTemp" } , ["GRM_PDSYNCF"] = { "PD" , "PDF" , "PDReceivedNoDetailsTemp" } , ["GRM_ALTSYNCF"] = { "ALT" , "ALTF" , "AltReceivedNoDetailsTemp" } , ["GRM_CUSTSYNCF"] = { "CUSTOMNOTE" , "CUSTF" , "CustReceivedNoDetailsTemp" } ,  ["GRM_BANSYNCF"] = { "BAN" , "BANF" , "BanReceivedNoDetailsTemp" } , ["GRM_BDAYSYNCF"] = { "BDAYS" , "BDAYF" , "BdayReceivedNoDetailsTemp" }  };

    if dataTypes[prefix] then
        local selection = dataTypes[prefix];
        local name = "";
        local indReceived = "";
        local values = {};

        -- if not GRMsyncGlobals.SyncTracker[selection[1]] then
        -- GRMsyncGlobals.ProgressControl ( selection[1] );
        -- end

        -- Add the message index received
        local indReceived = "";
        msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
        table.insert ( GRMsyncGlobals.messageIndexesReceived[selection[2]] , tonumber ( indReceived ) );

        values = GRMsync.ParseAllSeparatedItems( msg );

        for i = 1 , #values do
            table.insert ( GRMsyncGlobals[selection[3]] , values[i] );
        end
    end
end

-- Method:          GRMsync.CollectData ( string , string )
-- What it Does:    Collects all of the sync data before analysis.
-- Purpose:         Need to aggregate the data so one only needs to parse through the tables once, rather than on each new piece of info added. Far more efficient.
GRMsync.CollectData = function ( msg , prefix )

    local dataTypes = { ["GRM_JDSYNC"] = { "JD" , "JDReceivedTemp" } , ["GRM_PDSYNC"] = { "PD" , "PDReceivedTemp" } };

    if dataTypes[prefix] then
        local selection = dataTypes[prefix];
        local name = "";
        local standardTime = "";
        local timeStampOfChange = 0;
        local values = {};

        -- if not GRMsyncGlobals.SyncTracker[selection[1]] then
        -- GRMsyncGlobals.ProgressControl ( selection[1] );
        -- end

        -- Add the message index received
        local indReceived = "";
        msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
        table.insert ( GRMsyncGlobals.messageIndexesReceived[selection[1]] , tonumber ( indReceived ) );

        values = GRMsync.ParseAllSeparatedItems( msg );

        for i = 1 , #values , 3 do
            name = values[i];
            standardTime = values[i+1]
            timeStampOfChange = tonumber ( values[i+2] );
            table.insert ( GRMsyncGlobals[selection[2]] , { name , standardTime , timeStampOfChange } ); --
        end
    end
end

-- Method:          GRMsync.CollectAltAddData ( string , string )
-- What it Does:    Compiles the alt ADD data into a temp file
-- Purpose:         For use of syncing. Need to compile all data from a single player before analyzing it.
GRMsync.CollectAltAddData = function ( msg , prefix )
    local name = "";
    local indReceived = "";
    local timeStampOfChange = 0;
    local main = "";
    local values = {};

    if prefix == "GRM_ALTSYNC1" or prefix == "GRM_ALTSYNC2" then

        -- if not GRMsyncGlobals.SyncTracker.altData then
        --     GRMsyncGlobals.ProgressControl ( "ALT" );
        -- end

        -- Add the message index received
        indReceived = "";
        msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
        table.insert ( GRMsyncGlobals.messageIndexesReceived.ALT , tonumber ( indReceived ) );

        timeStampOfChange = 0;
        values = GRMsync.ParseAllSeparatedItems( msg );

        for i = 1 , #values , 2 do
            name = values[i];
            timeStampOfChange = tonumber ( values[i+1] );

            if prefix == "GRM_ALTSYNC1" then
                table.insert ( GRMsyncGlobals.AltReceivedTemp.NoGroup , { name , timeStampOfChange } );
            elseif prefix == "GRM_ALTSYNC2" then
                table.insert ( GRMsyncGlobals.AltReceivedTemp.MainOnly , { name , timeStampOfChange } );
            end
        end

        -- Only do at end of parsing all
        if prefix == "GRM_ALTSYNC1" then
            sort ( GRMsyncGlobals.AltReceivedTemp.NoGroup , function ( a , b ) return a[1] < b[1] end );
        elseif prefix == "GRM_ALTSYNC2" then
            sort ( GRMsyncGlobals.AltReceivedTemp.MainOnly , function ( a , b ) return a[1] < b[1] end );
        end

    elseif prefix == "GRM_ALTSYNC3" then

        -- if not GRMsyncGlobals.SyncTracker.altData then
        --     GRMsyncGlobals.ProgressControl ( "ALT" );
        -- end

        -- Add the message index received
        indReceived = "";
        msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
        table.insert ( GRMsyncGlobals.messageIndexesReceived.ALT , tonumber ( indReceived ) );
        main = "";

        values = GRMsync.ParseAllSeparatedItems( msg );

        for i = 1 , #values , 3 do
            name = values[i];
            main = values[i+1];
            timeStampOfChange = tonumber ( values[i+2] );

            if main == "#" then
                main = "";
            end
            GRMsyncGlobals.AltReceivedTemp.AltGroups[name] = {};
            GRMsyncGlobals.AltReceivedTemp.AltGroups[name].main = main;
            GRMsyncGlobals.AltReceivedTemp.AltGroups[name].timeModified = timeStampOfChange;
        end

    elseif prefix == "GRM_ALTSYNC4" then

        -- if not GRMsyncGlobals.SyncTracker.altData then
        --     GRMsyncGlobals.ProgressControl ( "ALT" );
        -- end

        -- Add the message index received
        indReceived = "";
        msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num

        values = GRMsync.ParseAllSeparatedItems( msg );
        local leadName = values[1];

        if GRMsyncGlobals.AltReceivedTemp.AltGroups[leadName] then
            table.insert ( GRMsyncGlobals.messageIndexesReceived.ALT , tonumber ( indReceived ) ); -- Only add if prior table was received.
            for i = 2 , #values do  -- Start at index 2 since index 1 is always the leadName
                name = values[i];
                table.insert ( GRMsyncGlobals.AltReceivedTemp.AltGroups[leadName] , name );
            end
        end

    end
end

-- Method:          GRMsync.CollectCustomNoteData ( string , string )
-- What it Does:    Collects the custom note sync date from currentsyncplayer
-- Purpose:         To be able to collect for easy parsing the custom note changes on a retroactive sync.
GRMsync.CollectCustomNoteData = function ( msg , prefix )

    local name = "";
    local timeStampOfChange = 0;
    local whoEdited = "";
    local customNote = "";
    local values = {};

    -- if not GRMsyncGlobals.SyncTracker.customNotes then
    --     GRMsyncGlobals.ProgressControl ( "CUSTOMNOTE" );
    -- end

    -- Add the message index received
    local indReceived = "";
    msg , indReceived = msg:match ( "(.+)%~|~(%d+)$" );   -- Parse out the msg num

    values = GRMsync.ParseAllSeparatedItems( msg , "~|~" );

    if prefix == "GRM_CUSTSYNC1" then
        table.insert ( GRMsyncGlobals.messageIndexesReceived.CUST , tonumber ( indReceived ) );

        name = values[1];
        timeStampOfChange = tonumber ( values[2] );
        whoEdited = values[3];
        customNote = values[4];
        if customNote == "#" then
            customNote = "";
        end
        table.insert ( GRMsyncGlobals.CustomNoteReceivedTemp , { name , timeStampOfChange , whoEdited , customNote } );

    elseif prefix == "GRM_CUSTSYNC2" then
        table.insert ( GRMsyncGlobals.messageIndexesReceived.CUST , tonumber ( indReceived ) );

        name = values[1];
        timeStampOfChange = tonumber ( values[2] );
        whoEdited = values[3];
        customNote = values[4];
        if customNote == "#" then
            customNote = "";
        end

        table.insert ( GRMsyncGlobals.CustomNoteReceivedTemp2 , { name , timeStampOfChange , whoEdited , customNote } );

    elseif prefix == "GRM_CUSTSYNC3" then -- Take the custom note and merge it with the already added customNote.
        name = values[1];
        customNote = values[2];

        for i = 1 , #GRMsyncGlobals.CustomNoteReceivedTemp2 do
            if GRMsyncGlobals.CustomNoteReceivedTemp2[i][1] == name then
                -- Only add the index if the name is found
                table.insert ( GRMsyncGlobals.messageIndexesReceived.CUST , tonumber ( indReceived ) );

                GRMsyncGlobals.CustomNoteReceivedTemp2[i][4] = GRMsyncGlobals.CustomNoteReceivedTemp2[i][4] .. customNote;

                -- Now that we are confirmed as having received both halfs, we can add to main temp
                table.insert ( GRMsyncGlobals.CustomNoteReceivedTemp , GRMsyncGlobals.CustomNoteReceivedTemp2[i] );
                break;
            end
        end
    end
end

-- Method:          GRMsync.CollectBirthdayData ( string )
-- What it Does:    Collects the Birthday data during a sync
-- Purpose:         For controlling the flow of sync'd data
GRMsync.CollectBirthdayData = function ( msg )
    local name , timeOfChange , day , month = "" , 0 , 0 , 0;

    -- if not GRMsyncGlobals.SyncTracker.bdays then
    --     GRMsyncGlobals.ProgressControl ( "BDAYS" );
    -- end

    -- Add the message index received
    local indReceived = "";
    msg , indReceived = msg:match ( "(.+)%?(%d+)$" );   -- Parse out the msg num
    table.insert ( GRMsyncGlobals.messageIndexesReceived.BDAY , tonumber ( indReceived ) );

    local values = GRMsync.ParseAllSeparatedItems( msg );

    for i = 1 , #values , 4 do
        name = values[i];
        timeOfChange = tonumber ( values[i+1] );
        day = tonumber ( values[i+2] );
        month = tonumber ( values[i+3] );

        table.insert ( GRMsyncGlobals.BirthdayReceivedTemp , { name , timeOfChange , day , month } );
    end
end

-- Method:          GRMsync.CheckingJDChanges()
-- What it Does:    After receiving ALL of the Join Date info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingJDChanges = function ()
    local players = GRMsync.BuildValidatedJoinDatesForSync();
    local namesAdded = {};

    -- Add the player's data to the banChanges
    for j = #GRMsyncGlobals.JDReceivedTemp , 1 , -1  do
        for i = 1 , #players do
            if players[i][1] == GRMsyncGlobals.JDReceivedTemp[j][1] and players[i][2] >= GRMsyncGlobals.JDReceivedTemp[j][2] then -- Ban Match
                table.insert ( GRMsyncGlobals.JDChanges , { players[i][1] , players[i][2] , players[i][3] , true } );  -- Final position bool - if my data -- { name , timestamp , standardTime }
                table.remove ( GRMsyncGlobals.JDReceivedTemp , j );
                namesAdded[players[i][1]] = {};
                break;
            end
        end
    end

    for i = 1 , #GRMsyncGlobals.JDReceivedTemp do   -- { name , timestamp , standardTime , myData }
        table.insert ( GRMsyncGlobals.JDChanges , { GRMsyncGlobals.JDReceivedTemp[i][1] , GRMsyncGlobals.JDReceivedTemp[i][2] , GRMsyncGlobals.JDReceivedTemp[i][3] , false } );
        namesAdded[GRMsyncGlobals.JDReceivedTemp[i][1]] = {};
    end

    for i = 1 , #players do
        if not namesAdded[players[i][1]] then
            namesAdded[players[i][1]] = {};
            table.insert ( GRMsyncGlobals.JDChanges , { players[i][1] , players[i][2] , players[i][3] , true } );
        end
    end
end

-- Method:          GRMsync.CheckingPDChanges()
-- What it Does:    After receiving ALL of the Join Date info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingPDChanges = function ()
    local players = GRMsync.BuildValidatedPromoteDatesForSync();
    local namesAdded = {};

    -- Add the player's data to the banChanges
    for j = #GRMsyncGlobals.PDReceivedTemp , 1 , -1  do
        for i = 1 , #players do
            if players[i][1] == GRMsyncGlobals.PDReceivedTemp[j][1] and players[i][2] >= GRMsyncGlobals.PDReceivedTemp[j][2] then -- Ban Match
                table.insert ( GRMsyncGlobals.PDChanges , { players[i][1] , players[i][2] , players[i][3] , true } );  -- Final position bool - if my data
                table.remove ( GRMsyncGlobals.PDReceivedTemp , j );
                namesAdded[players[i][1]] = {};
                break;
            end
        end
    end

    for i = 1 , #GRMsyncGlobals.PDReceivedTemp do
        table.insert ( GRMsyncGlobals.PDChanges , { GRMsyncGlobals.PDReceivedTemp[i][1] , GRMsyncGlobals.PDReceivedTemp[i][2] , GRMsyncGlobals.PDReceivedTemp[i][3] , false } );
        namesAdded[GRMsyncGlobals.PDReceivedTemp[i][1]] = {};
    end

    for i = 1 , #players do
        if not namesAdded[players[i][1]] then
            namesAdded[players[i][1]] = {};
            table.insert ( GRMsyncGlobals.PDChanges , { players[i][1] , players[i][2] , players[i][3] , true } );
        end
    end
end

-- Method:          GRMsync.CheckingALTChanges()
-- What it Does:    Compares the Leader's data to the received's data
-- Purpose:         Let's analyze the alt lists to setup for final sync
GRMsync.CheckingALTChanges = function()
    local altData = GRMsync.BuildValidatedAltGroupsForSync();  -- { playersNotInGroup , playersOnlyMain , playersAltGroups };
    namesAdded = {};
    -- No Group is most current data
    for i = #GRMsyncGlobals.AltReceivedTemp.NoGroup , 1 , -1 do
        for j = 1 , #altData[1] do
            if altData[1][j][1] == GRMsyncGlobals.AltReceivedTemp.NoGroup[i][1] and altData[1][j][2] >= GRMsyncGlobals.AltReceivedTemp.NoGroup[i][2] then   -- >= because weird edge case if someone manually edits their DB without changing timestamp.
                table.insert ( GRMsyncGlobals.AltChangesNoGroup , { altData[1][j][1] , altData[1][j][2] , true } );
                table.remove ( GRMsyncGlobals.AltReceivedTemp.NoGroup , j );
                namesAdded[altData[1][j][1]] = {};
                break;
            end
        end
    end

    -- Add the remaining sent, which means only the other player has record
    for i = 1 , #GRMsyncGlobals.AltReceivedTemp.NoGroup do
        table.insert ( GRMsyncGlobals.AltChangesNoGroup , { GRMsyncGlobals.AltReceivedTemp.NoGroup[i][1] , GRMsyncGlobals.AltReceivedTemp.NoGroup[i][2] , false } );
        namesAdded[GRMsyncGlobals.AltReceivedTemp.NoGroup[i][1]] = {};
    end

    -- Now, add my own, I may have zero received in temp as other play does not have these alts. Add mine.
    for i = 1 , #altData[1] do
        if not namesAdded[altData[1][i][1]] then
            namesAdded[altData[1][i][1]] = {};
            table.insert ( GRMsyncGlobals.AltChangesNoGroup , { altData[1][i][1] , altData[1][i][2] , true } );
        end
    end

    sort ( GRMsyncGlobals.AltChangesNoGroup , function ( a , b ) return a[1] < b[1] end );

    -- Player has no alts, but is listed as a main
    for i = #GRMsyncGlobals.AltReceivedTemp.MainOnly , 1 , -1 do
        for j = 1 , #altData[2] do
            if altData[2][j][1] == GRMsyncGlobals.AltReceivedTemp.MainOnly[i][1] and altData[2][j][2] >= GRMsyncGlobals.AltReceivedTemp.MainOnly[i][2] then   -- >= because weird edge case if someone manually edits their DB without changing timestamp.
                table.insert ( GRMsyncGlobals.AltChangesMainOnly , { altData[2][j][1] , altData[2][j][2] , true } );
                table.remove ( GRMsyncGlobals.AltReceivedTemp.MainOnly , j );
                namesAdded[altData[2][j][1]] = {};
                break;
            end
        end
    end

    for i = 1 , #GRMsyncGlobals.AltReceivedTemp.MainOnly do
        table.insert ( GRMsyncGlobals.AltChangesMainOnly , { GRMsyncGlobals.AltReceivedTemp.MainOnly[i][1], GRMsyncGlobals.AltReceivedTemp.MainOnly[i][2] , false } );
        namesAdded[GRMsyncGlobals.AltReceivedTemp.MainOnly[i][1]] = {};
    end

    for i = 1 , #altData[2] do
        if not namesAdded[altData[2][i][1]] then
            namesAdded[altData[2][i][1]] = {};
            table.insert ( GRMsyncGlobals.AltChangesMainOnly , { altData[2][i][1] , altData[2][i][2] , true } );
        end
    end

    sort ( GRMsyncGlobals.AltChangesMainOnly , function ( a , b ) return a[1] < b[1] end );

    local isFound = false;
    -- I can't just compare alt groups now easily. It is possible a toon in a more recent updated alt group on one side, has someone set as main only more
    -- recently on the other player's account, so i need to go through all of the alt groups received and remove any names already processed.

    -- STEP 1: Remove names from alt groups that have already been processed. Received data, then my own.
    for leadName , receivedgroup in pairs ( GRMsyncGlobals.AltReceivedTemp.AltGroups ) do
        table.insert ( receivedgroup , 1 , leadName );

        for i = #receivedgroup , 1 , -1 do                               -- Cycle through received alt group
            if namesAdded[receivedgroup[i]] then
                table.remove ( receivedgroup , i );
            end
        end

        if #receivedgroup < 2 then
            GRMsyncGlobals.AltReceivedTemp.AltGroups[leadName] = nil;

        elseif namesAdded[leadName] then
            GRMsyncGlobals.AltReceivedTemp.AltGroups[receivedgroup[1]] = receivedgroup; -- Still is valid group, just minus those players
        end

    end

    for i = #altData[3] , 1 , -1 do
        for j = #altData[3][i] , 1 , -1 do
            if namesAdded[altData[3][i][j]] then
                table.remove ( altData[3][i] , j );
            end
        end
        if #altData[3][i] < 2 then
            table.remove ( altData[3] , i );
        end
    end

    local isFound = false;
    -- STEP 2: Determine if my data is more recent.
    for leadName , receivedgroup in pairs ( GRMsyncGlobals.AltReceivedTemp.AltGroups ) do
        isfound = false;
        for i = 1 , #receivedgroup do                               -- Cycle through received alt group
            for j = 1 , #altData[3] do                              -- Cycle through all of my alt groups
                for k = 1 , #altData[3][j] do                       -- Cycle through all group alt data, each list of alts
                    if receivedgroup[i] == altData[3][j][k] then
                        isFound = true;
                        if altData[3][j].timeModified >= receivedgroup.timeModified and #altData[3][j] > 1 then

                            table.insert ( GRMsyncGlobals.AltChangesFullGroup , { altData[3][j] , true } );
                            for r = 1 , #altData[3][j] do
                                namesAdded[altData[3][j][r]] = {};
                            end

                            for r = #receivedgroup , 1 , -1 do
                                if namesAdded[receivedgroup[r]] then
                                    table.remove ( receivedgroup , r );
                                end
                            end
                            -- Need to re-add the received group as some toons in the group might still be valid. Don't want to purge the whole group.
                            if #receivedgroup > 1 then
                                GRMsyncGlobals.AltReceivedTemp.AltGroups[receivedgroup[1]] = receivedgroup;
                            end
                            if receivedgroup[1] ~= leadName then        -- If the leadName is the same then you would add it above, then purge it.
                                GRMsyncGlobals.AltReceivedTemp.AltGroups[leadName] = nil;
                            end
                            altData[3][j] = nil;
                        end
                        break;
                    end
                end
                if isFound then
                    break;
                end
            end
            if isFound then
                break;
            end
        end
    end

    -- STEP 3: Add the details of the received groups
    for leadName , altGroup in pairs ( GRMsyncGlobals.AltReceivedTemp.AltGroups ) do

        for i = #altGroup , 1 , -1 do
            if namesAdded[altGroup[i]] then
                table.remove ( altGroup , i );
            end
        end

        if #altGroup > 1 then
            for i = 1 , #altGroup do
                namesAdded[altGroup[i]] = {}
            end

            table.insert ( GRMsyncGlobals.AltChangesFullGroup , { altGroup , false } );
        end
    end

    -- STEP 4: Add details of any remaining groups
    for i = 1 , #altData[3] do
        for j = #altData[3][i] , 1 , -1 do
            if namesAdded[altData[3][i][j]] then
                table.remove ( altData[3][i] , j );
            end
        end

        if #altData[3][i] > 1 then
            table.insert ( GRMsyncGlobals.AltChangesFullGroup , { altData[3][i] , true } );
        end
    end

    sort ( GRMsyncGlobals.AltChangesFullGroup , function ( a , b ) return a[1][1] < b[1][1] end );

end

-- Method:          GRMsync.CheckingCustomNoteChanges()
-- What it Does:    After receiving ALL of the Join Date info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingCustomNoteChanges = function ()
    local players = GRMsync.BuildValidatedCustomNotesForSync();
    local namesAdded = {};

    -- Add the player's data to the banChanges
    for j = #GRMsyncGlobals.CustomNoteReceivedTemp , 1 , -1  do
        for i = 1 , #players do
            if players[i][1] == GRMsyncGlobals.CustomNoteReceivedTemp[j][1] and players[i][2] >= GRMsyncGlobals.CustomNoteReceivedTemp[j][2] then -- Ban Match
                table.insert ( GRMsyncGlobals.CustomNoteChanges , { players[i][1] , players[i][2] , players[i][3] , players[i][4] , true } );  -- playerName , timeStampOfChange , whoEdited , customNote
                table.remove ( GRMsyncGlobals.CustomNoteReceivedTemp , j );
                namesAdded[players[i][1]] = {};
                break;
            end
        end
    end

    for i = 1 , #GRMsyncGlobals.CustomNoteReceivedTemp do
        table.insert ( GRMsyncGlobals.CustomNoteChanges , { GRMsyncGlobals.CustomNoteReceivedTemp[i][1] , GRMsyncGlobals.CustomNoteReceivedTemp[i][2] , GRMsyncGlobals.CustomNoteReceivedTemp[i][3] , GRMsyncGlobals.CustomNoteReceivedTemp[i][4] , false } );
        namesAdded[GRMsyncGlobals.CustomNoteReceivedTemp[i][1]] = {};
    end

    for i = 1 , #players do
        if not namesAdded[players[i][1]] then
            namesAdded[players[i][1]] = {};
            table.insert ( GRMsyncGlobals.CustomNoteChanges , { players[i][1] , players[i][2] , players[i][3] , players[i][4] , true } );
        end
    end
end

-- Method:          GRMsync.CheckingBANChanges()
-- What it Does:    After receiving ALL of the Ban info, it parses through and checks for new updates/changes
-- Purpose:         For syncing the data properly to people if update is needed!
GRMsync.CheckingBANChanges = function ()
    if GRM.S().syncBanList then
        local banDetails = GRMsync.BuildValidatedBanProfilesForSync();
        local namesAdded = {};

        -- Add the player's data to the banChanges
        for j = #GRMsyncGlobals.BanReceivedTemp , 1 , -1  do
            for i = 1 , #banDetails do
                if banDetails[i][1] == GRMsyncGlobals.BanReceivedTemp[j][1] and banDetails[i][2] >= GRMsyncGlobals.BanReceivedTemp[j][2] then -- Ban Match
                    table.insert ( GRMsyncGlobals.BanChanges , { banDetails[i][1] , banDetails[i][2] , banDetails[i][3] , banDetails[i][4] , banDetails[i][5] , banDetails[i][6] , true } );  -- Final position bool - if my data
                    table.remove ( GRMsyncGlobals.BanReceivedTemp , j );
                    namesAdded[banDetails[i][1]] = {};
                    break;
                end
            end
        end

        for i = 1 , #GRMsyncGlobals.BanReceivedTemp do
            table.insert ( GRMsyncGlobals.BanChanges , { GRMsyncGlobals.BanReceivedTemp[i][1] , GRMsyncGlobals.BanReceivedTemp[i][2] , GRMsyncGlobals.BanReceivedTemp[i][3] , GRMsyncGlobals.BanReceivedTemp[i][4] , GRMsyncGlobals.BanReceivedTemp[i][5] , GRMsyncGlobals.BanReceivedTemp[i][6] , false } );
            namesAdded[GRMsyncGlobals.BanReceivedTemp[i][1]] = {};
        end

        for i = 1 , #banDetails do
            if not namesAdded[banDetails[i][1]] then
                namesAdded[banDetails[i][1]] = {};
                table.insert ( GRMsyncGlobals.BanChanges , { banDetails[i][1] , banDetails[i][2] , banDetails[i][3] , banDetails[i][4] , banDetails[i][5] , banDetails[i][6] , true } );
            end
        end
    end
end

-- Method:          GRMsync.BuildValidatedJoinDatesForSync()
-- What it Does:    Builds validated join dates after doing prechecks, for changes check
-- Purpose:         Proper syncing of data.
GRMsync.BuildValidatedJoinDatesForSync = function()
    sort ( GRMsyncGlobals.JDReceivedNoDetailsTemp );    -- Will be more efficient to order it
    local dataIndexes = GRMsyncGlobals.JDReceivedNoDetailsTemp;
    local namesAlreadyProcessed = {};
    local data = GRMsync.GetListOfPlayersWithVerifiedJoinDates ( GRMsyncGlobals.guildData , true );
    local finalList = {};

    for i = 1 , #dataIndexes do         -- Scan through the ALTF data
        if not namesAlreadyProcessed[dataIndexes[i]] then
            for j = 1 , #data do
                if dataIndexes[i] == data[j][1] then
                    table.insert ( finalList , { data[j][1] , data[j][2] , data[j][3] } );   -- { name , standardTimestamp , Epoch}
                    namesAlreadyProcessed[data[j][1]] = {};
                    break;
                end
            end

        end
    end

    return finalList;
end

-- Method:          GRMsync.BuildValidatedPromoteDatesForSync()
-- What it Does:    Builds validated Promote dates after doing prechecks, for changes check
-- Purpose:         Proper syncing of data.
GRMsync.BuildValidatedPromoteDatesForSync = function()
    sort ( GRMsyncGlobals.PDReceivedNoDetailsTemp );    -- Will be more efficient to order it
    local dataIndexes = GRMsyncGlobals.PDReceivedNoDetailsTemp;
    local namesAlreadyProcessed = {};
    local data = GRMsync.GetListOfPlayersWIthVerifiedPromoteDates ( GRMsyncGlobals.guildData , true );
    local finalList = {};

    for i = 1 , #dataIndexes do         -- Scan through the ALTF data
        if not namesAlreadyProcessed[dataIndexes[i]] then
            for j = 1 , #data do
                if dataIndexes[i] == data[j][1] then
                    table.insert ( finalList , { data[j][1] , data[j][2] , data[j][3] } );   -- { name , standardTimestamp , Epoch}
                    namesAlreadyProcessed[data[j][1]] = {};
                    break;
                end
            end

        end
    end

    return finalList;
end

-- Method:          GRMsync.BuildValidatedCustomNotesForSync()
-- What it Does:    Builds validated Custom Notes after doing prechecks, for changes check
-- Purpose:         Proper syncing of data.
GRMsync.BuildValidatedCustomNotesForSync = function()
    sort ( GRMsyncGlobals.CustReceivedNoDetailsTemp );    -- Will be more efficient to order it
    local dataIndexes = GRMsyncGlobals.CustReceivedNoDetailsTemp;
    local namesAlreadyProcessed = {};
    local data = GRMsync.GetListOfPlayersWithCustomNotesModified ( GRMsyncGlobals.guildData , true );
    local finalList = {};

    for i = 1 , #dataIndexes do         -- Scan through the ALTF data
        if not namesAlreadyProcessed[dataIndexes[i]] then
            for j = 1 , #data do
                if dataIndexes[i] == data[j][1] then
                    table.insert ( finalList , { data[j][1] , data[j][2] , data[j][3] , data[j][4] } );   -- { name , epochTimestamp , whoEdited , customNote }
                    namesAlreadyProcessed[data[j][1]] = {};
                    break;
                end
            end

        end
    end

    return finalList;
end

-- Method:          GRMsync.BuildValidatedBdayDatesForSync()
-- What it Does:    Builds validated Bday dates after doing prechecks, for changes check
-- Purpose:         Proper syncing of data.
GRMsync.BuildValidatedBdayDatesForSync = function()
    sort ( GRMsyncGlobals.BdayReceivedNoDetailsTemp );    -- Will be more efficient to order it
    local dataIndexes = GRMsyncGlobals.BdayReceivedNoDetailsTemp;
    local namesAlreadyProcessed = {};
    local data = GRMsync.GetListOfPlayersWithModifiedBdays ( GRMsyncGlobals.guildData , true );
    local finalList = {};

    for i = 1 , #dataIndexes do         -- Scan through the ALTF data
        if not namesAlreadyProcessed[dataIndexes[i]] then
            for j = 1 , #data do
                if dataIndexes[i] == data[j][1] then
                    table.insert ( finalList , { data[j][1] , data[j][2] , data[j][3] , data[j][4] , data[j][5]} );   -- { name , epochTimestamp , day , month , altGroupID }
                    namesAlreadyProcessed[data[j][1]] = {};
                    break;
                end
            end

        end
    end

    return finalList;
end

-- Method:          GRMsync.BuildValidatedBanProfilesForSync()
-- What it Does:    Builds validated Ban Profiles after doing prechecks, for changes check
-- Purpose:         Proper syncing of data.
GRMsync.BuildValidatedBanProfilesForSync = function()
    sort ( GRMsyncGlobals.BanReceivedNoDetailsTemp );    -- Will be more efficient to order it
    local dataIndexes = GRMsyncGlobals.BanReceivedNoDetailsTemp;
    local namesAlreadyProcessed = {};
    local data = GRMsync.GetListBannedAndUnbannedPlayers ( { GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData } , true );
    local finalList = {};

    for i = 1 , #dataIndexes do         -- Scan through the ALTF data
        if not namesAlreadyProcessed[dataIndexes[i]] then
            for j = 1 , #data do
                if dataIndexes[i] == data[j][1] then
                    table.insert ( finalList , { data[j][1] , data[j][2] , data[j][3] , data[j][4] , data[j][5] , data[j][6] } );   -- { name , banTimeEpoch , banType , reason , playerWhoBanned , formerPlayerDataTable }
                    namesAlreadyProcessed[data[j][1]] = {};
                    break;
                end
            end

        end
    end

    return finalList;
end

-- Method:          GRMsync.BuildValidatedAltGroupsForSync()
-- What it Does:    Creates a specialized alt table for sync purposes
-- Purpose:         Breaking them into categories makes it easier syncing/parsing
GRMsync.BuildValidatedAltGroupsForSync = function()

    GRMsyncGlobals.DatabaseMarkers[3] = GRMsync.GetListPlayersWithAltTimeStamp ( GRMsyncGlobals.guildData , GRMsyncGlobals.guildAltData , true );  -- Need to process first
    sort ( GRMsyncGlobals.AltReceivedNoDetailsTemp );    -- Will be more efficient to order it
    local dataIndexes = GRMsyncGlobals.AltReceivedNoDetailsTemp;
    local namesAlreadyProcessed = {};
    local playersNotInGroup = {};
    local playersOnlyMain = {};
    local altData = GRMsync.BuildAltGroupsForSync();
    local playersAltGroups = {};
    local finalTable = { playersNotInGroup , playersOnlyMain , playersAltGroups };

    -- Variables to carry player data
    local altGroup = {};
    local index = 0;

    for i = 1 , #dataIndexes do         -- Scan through the ALTF data
        index = 0;
        if not namesAlreadyProcessed[dataIndexes[i]] then
            for j = 1 , #altData do         -- Scan through the 1=NotInGroup, 2 = OnlyMain , 3=fullAltGroups

                for k = 1 , #altData[j] do  -- scan through all players in above group.

                    if j < 3 then
                        if dataIndexes[i] == altData[j][k][1] then
                            index = j;
                        end
                    elseif j == 3 then
                        for h = 1 , #altData[j][k] do
                            if dataIndexes[i] == altData[j][k][h] then    -- Alt group is nested
                                index = j;
                            end
                        end
                    end

                    if index > 0 then
                        if index < 3 then
                            table.insert ( finalTable[j] , { altData[j][k][1] , altData[j][k][2] } );   -- Add name and epoch timestamp
                            namesAlreadyProcessed[dataIndexes[i]] = true;
                        elseif index == 3 then
                            table.insert ( finalTable[j] , altData[j][k] );                             -- Add full alt group, include all names, main, epoch timestamp
                            for r = 1 , #altData[j][k] do
                                namesAlreadyProcessed[altData[j][k][r]] = true;
                            end
                        end
                        break;
                    end
                end

                if index > 0 then
                    break;
                end
            end
        end
    end

    return finalTable;
end

-- Method:          GRMsync.CheckingBdayChanges()
-- What it Does:    Establishes what needs to be kept and what needs to be removed
-- Purpose:         Controlling the flow of the sync info!
GRMsync.CheckingBdayChanges = function()
    local guildData = GRMsyncGlobals.guildData;
    local altData = GRMsyncGlobals.guildAltData;
    local players = GRMsync.BuildValidatedBdayDatesForSync();
    sort ( players , function ( a , b ) return a[1] < b[1] end );
    local namesAdded = {};
    local altGroup = {};
    local member = {}

    for i = #GRMsyncGlobals.BirthdayReceivedTemp , 1 , -1 do

        if not namesAdded[GRMsyncGlobals.BirthdayReceivedTemp[i][1]] then
            for j = 1 , #players do
                -- Adding { name , epochTimestamp , day , month , isMyData }
                if players[j][1] == GRMsyncGlobals.BirthdayReceivedTemp[i][1] and players[j][2] >= GRMsyncGlobals.BirthdayReceivedTemp[i][2] then
                    table.insert ( GRMsyncGlobals.BDayChanges , { players[j][1] , players[j][2] , players[j][3] , players[j][4] , true } );  -- Final position bool - if my data
                    table.remove ( GRMsyncGlobals.BirthdayReceivedTemp , j );
                    namesAdded[players[j][1]] = {};

                    -- Now, we go to the alt group and add everyone in the alt Group.
                    -- Since the bday is shared across an alt group, only really need to review the bday of 1 player in alt group
                    if players[j][5] ~= "" then         -- Player alt Group confirmed
                        altGroup = altData[players[j][5]];
                        if altGroup then
                            for k = 1 , #altGroup do
                                if altGroup[k].name ~= players[j][1] then
                                    namesAdded[altGroup[k].name] = {};
                                    -- Now, need to see if any member of the alt Group has a more recent
                                end
                            end
                        end
                    end
                    break;
                end
            end
        else
            -- Part of an alt group - let's remove
            table.remove ( GRMsyncGlobals.BirthdayReceivedTemp , i );
        end
    end

    for j = #GRMsyncGlobals.BirthdayReceivedTemp , 1 , -1 do

        if not namesAdded[GRMsyncGlobals.BirthdayReceivedTemp[j][1]] then
            table.insert ( GRMsyncGlobals.BDayChanges , { GRMsyncGlobals.BirthdayReceivedTemp[j][1] , GRMsyncGlobals.BirthdayReceivedTemp[j][2] , GRMsyncGlobals.BirthdayReceivedTemp[j][3] , GRMsyncGlobals.BirthdayReceivedTemp[j][4] , false } );
            namesAdded[GRMsyncGlobals.BirthdayReceivedTemp[j][1]] = {};

            for i = 1 , #guildData do
                if guildData[i].name == GRMsyncGlobals.BirthdayReceivedTemp[j][1] and guildData[i].altGroup ~= "" then
                    altGroup = altData[guildData[i].altGroup];
                    if altGroup then
                        for k = 1 , #altGroup do
                            if altGroup[k].name ~= GRMsyncGlobals.BirthdayReceivedTemp[j][1] then
                                namesAdded[altGroup[k].name] = {};
                            end
                        end
                    end
                end
            end
        else
            -- Part of an alt group - let's remove
            table.remove ( GRMsyncGlobals.BirthdayReceivedTemp , j );
        end

    end

    for i = 1 , #players do
        if not namesAdded[players[i][1]] then
            namesAdded[players[i][1]] = {};
            table.insert ( GRMsyncGlobals.BDayChanges , { players[i][1] , players[i][2] , players[i][3] , players[i][4] , true } );

            for j = 1 , #guildData do
                if guildData[j].name == players[i][1] and guildData[j].altGroup ~= "" then
                    altGroup = altData[guildData[j].altGroup];
                    if altGroup then
                        for k = 1 , #altGroup do
                            if altGroup[k].name ~= players[i][1] then
                                namesAdded[altGroup[k].name] = {};
                            end
                        end
                    end
                end
            end

        end
    end
    GRMsync.SubmitFinalBdayData();
end

-----------------------------------------
------ MISSING MESSAGES FUNCTIONS -------
-------- TO BE RESENT/PROCESSED ---------
-----------------------------------------

-- Method:          GRMsync.ConvertIntStringToArray ( string )
-- What it Does:    Converts a long string of ints separated by ? into an array of ints
-- Purpose:         Parse a string of any size all the ints.
GRMsync.ConvertIntStringToArray = function( text )
    local result = {};
    for num in text:gmatch ( "%d+" ) do
        table.insert ( result , tonumber( num ) );
    end
    return result;
end

-- Method:          GRMsync.ParseAllSeparatedItems ( string , string/char )
-- What it Does:    Returns a string array of all the items parsed
-- Purse:           Cleaner code when syncing.
GRMsync.ParseAllSeparatedItems = function ( text , delimiter )
    local result = {};
    delimiter = delimiter or "?";
    if text and type(text)== "string" then
        for item in text:gmatch ( "[^".. delimiter .. "]+" ) do
            table.insert ( result , item );
        end
    end
    return result;
end

-- Method:          CollectMissingMsgRequest ( string )
-- What it Does:    Collects the request for missing messages
-- Prupose:         Sync integrity.
GRMsync.CollectMissingMsgRequest = function( msg , prefix )
    local group = { ["GRM_REQMISJDF"] = "JDF" , ["GRM_REQMISJD"] = "JD" , ["GRM_REQMISPDF"] = "PD" , ["GRM_REQMISPD"] = "PD" , ["GRM_REQMISALTF"] = "ALTF" , ["GRM_REQMISALT"] = "ALT" , ["GRM_REQMISCUSTF"] = "CUSTF" , ["GRM_REQMISCUST"] = "CUST" , ["GRM_REQMISBANF"] = "BANF" , ["GRM_REQMISBAN"] = "BAN" , ["GRM_REQMISBDAYF"] = "BDAYF" , ["GRM_REQMISBDAY"] = "BDAY" , ["GRM_REQJDFIN"] = "JDFINAL" , ["GRM_REQPDFIN"] = "PDFINAL" , ["GRM_REQALTFIN"] = "ALTFINAL" , ["GRM_REQCUSTFIN"] = "CUSTFINAL" , ["GRM_REQBANFIN"] = "BANFINAL" , ["GRM_REQBDAYFIN"] = "BDAYFINAL" };

    if #GRMsyncGlobals.MissingRequest[group[prefix]] == 0 then
        GRMsyncGlobals.MissingRequest[group[prefix]] = GRMsync.ConvertIntStringToArray ( msg );
    else
        -- More than one message so we need to append to end of array
        local intArray = GRMsync.ConvertIntStringToArray ( msg );
        for i = 1 , #intArray do
            table.insert ( GRMsyncGlobals.MissingRequest[group[prefix]] , intArray[i] );
        end
    end
end

-- Method:          GRMsync.SendRequestsForMissingMessages ( table , int , bool )
-- What it does:    Converts the missing messages list to a string to be able to send.
-- Purpose:         Sync data integrity... don't need to repeate sync data.
GRMsync.SendRequestsForMissingMessages = function( missingMessages , index1 , finalData , BDayPreCheck , finalBday , index2 )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local prefixes = {};

    if finalData then
        prefixes = { "GRM_REQJDFIN" , "GRM_REQPDFIN" , "GRM_REQALTFIN" , "GRM_REQCUSTFIN" , "GRM_REQBANFIN" };
    elseif BDayPreCheck then
        prefixes = { "GRM_REQMISBDAYF" , "GRM_REQMISBDAY" };
    elseif finalBday then
        prefixes = { "GRM_REQBDAYFIN" };
    else
        prefixes = { "GRM_REQMISJDF" , "GRM_REQMISJD" , "GRM_REQMISPDF" , "GRM_REQMISPD" , "GRM_REQMISALTF" , "GRM_REQMISALT" , "GRM_REQMISCUSTF" , "GRM_REQMISCUST" , "GRM_REQMISBANF" , "GRM_REQMISBAN" };
    end

    local msg = "";
    local tempMsg = "";
    index1 = index1 or 1;
    index2 = index2 or 1;

    for i = index1 , #missingMessages do
        msg = prefixes[i] .. "?" .. GRMsyncGlobals.syncRankFilter;  -- Set the prefix header

        for j = index2 , #missingMessages[i] do
            tempMsg = msg .. "?" .. missingMessages[i][j];               -- Add the numbers that correspond to the missing messages

            if ( #tempMsg + GRMsyncGlobals.sizeModifier ) < 255 then
                msg = tempMsg;
            else
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
                -- Don't incrememnt up the index
                msg = prefixes[i] .. "?" .. GRMsyncGlobals.syncRankFilter .. "?" .. missingMessages[i][j];
            end

            if j == #missingMessages[i] then
                -- End of table
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
                index2 = 1;
            end

            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                if j == #missingMessages[i] then
                    index1 = i + 1;
                else
                    index = i;
                    index2 = j;
                end

                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendRequestsForMissingMessages ( missingMessages , index1 , finalData , BDayPreCheck , finalBday , index2 );
                end);
                return;
            end

        end
    end
    local prefix = "GRM_MISFIN?";
    if finalData then
        prefix = "GRM_MISFIN2?";

    elseif BDayPreCheck then
        prefix = "GRM_MISFIN3?";

    elseif finalBday then
        prefix = "GRM_MISFIN4?";

    end

    msg = prefix .. GRMsyncGlobals.syncRankFilter .. "?";
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
end

-- Method:          GRMsync.SendMissingMessages ( bool , bool , int , int )
-- What it Does:    Seeds the missing messages in a controlled manner
-- Purpose:         Sync integrity
GRMsync.SendMissingMessages = function( sendFinal , sendBdayPreCheck , sendBdayFinal , index1 , index2 )
    GRMsyncGlobals.TimeSinceLastSyncAction = time();
    local group = { "JDF" , "JD" , "PDF" , "PD" , "ALTF" , "ALT" , "CUSTF" , "CUST" , "BANF" , "BAN" };
    if sendFinal then
        group = { "JDFINAL" , "PDFINAL" , "ALTFINAL" , "CUSTFINAL" , "BANFINAL" };
    elseif sendBdayPreCheck then
        group = { "BDAYF" , "BDAY" };
    elseif sendBdayFinal then
        group = { "BDAYFINAL" };
    end
    index1 = index1 or 1;
    index2 = index2 or 1;
    local ind = "";
    local msg = "";

    for i = index1 , #group do
        ind = group[i];
        for j = index2 , #GRMsyncGlobals.MissingRequest[ind] do

            if GRMsyncGlobals.messageTree[ind][GRMsyncGlobals.MissingRequest[ind][j]] then
                msg = GRMsyncGlobals.messageTree[ind][GRMsyncGlobals.MissingRequest[ind][j]];
                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
                GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
            end

            if GRMsyncGlobals.SyncCount + 254 > GRMsyncGlobals.ThrottleCap then
                GRMsyncGlobals.syncTempDelay = true;

                -- Increment as needed
                if j == #GRMsyncGlobals.MissingRequest[ind] then
                    index1 = i + 1;
                    index2 = 1;
                else
                    index1 = i;
                    index2 = j + 1;
                end

                GRMsyncGlobals.SyncCount = 0;
                C_Timer.After ( GRMsyncGlobals.ThrottleDelay , function()
                    GRMsync.SendMissingMessages ( sendFinal , sendBdayPreCheck , sendBdayFinal , index1 , index2 );
                end);
                return;
            end
        end
        index2 = 1;
    end

    local prefix = "GRM_MISSENT?";
    if sendFinal then
        prefix = "GRM_MISSENT2?";
    elseif sendBdayPreCheck then
        prefix = "GRM_MISSENT3?";
    elseif sendBdayFinal then
        prefix = "GRM_MISSENT4?";
    end

    msg = prefix .. GRMsyncGlobals.syncRankFilter .. "?";
    GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg + GRMsyncGlobals.sizeModifier;
    GRMsync.SendMessage ( "GRM_SYNC" , msg , GRMsyncGlobals.CurrentSyncPlayer );
end

-- Method:          GRMsync.SortReceivedMessageIndexes()
-- What it Does:    Sorts all the indexes received so if therer were missing, it now properly resorts them back
-- Purpose:         In case I decide it is worth it to cycle back and do a recheck.
GRMsync.SortReceivedMessageIndexes = function()
    for _ , group in pairs ( GRMsyncGlobals.messageIndexesReceived ) do
        sort ( group );
    end
end

-- Method:          GRMsync.ValidateReSentMessages()
-- What it Does:    Validates that all missing messages have been received.
-- Purpose:         Sync integrity before moving forward.
GRMsync.ValidateReSentMessages = function()
    GRMsync.SortReceivedMessageIndexes();

    local missingMessages , count = GRMsync.AnyMessagesMissing ( GRMsyncGlobals.preCheckResult[1] , GRMsyncGlobals.preCheckResult[2] , GRMsyncGlobals.preCheckResult[3] , GRMsyncGlobals.preCheckResult[4] , GRMsyncGlobals.preCheckResult[5] , GRMsyncGlobals.preCheckResult[6] , GRMsyncGlobals.preCheckResult[7] , GRMsyncGlobals.preCheckResult[8] , GRMsyncGlobals.preCheckResult[9] , GRMsyncGlobals.preCheckResult[10] );

    if count > 0 then
        -- if #missingMessages[4] > 0 then
        -- end

    end

    GRMsync.PreCheckChanges();
end

-- Method:          GRMsync.ValidateReSentMessagesFinal()
-- What it Does:    Validates the messages requested have been received
-- Purpose:         Data integrity.
GRMsync.ValidateReSentMessagesFinal = function()
    local missingMessages , count = GRMsync.AnyMessagesMissingFinal ( GRMsyncGlobals.FinalMsgCommCount[1] , GRMsyncGlobals.FinalMsgCommCount[2] , GRMsyncGlobals.FinalMsgCommCount[3] , GRMsyncGlobals.FinalMsgCommCount[4] , GRMsyncGlobals.FinalMsgCommCount[5] );
        -- JD, PD, ALT, BAN
    if count > 0 then
       -- Not sure if I want to try to issue a recheck again or just move on...

    end

    -- Process alt groups
    GRMsync.ProcessFinalAltChanges( true );
end

-- Method:          GRMsync.ValidateReSentMessagesBday ( bool )
-- What it Does:    Validates messages have arrived after a re-request
-- Purpose:         Data integrity. Lowers chance of losing data.
GRMsync.ValidateReSentMessagesBday = function ( isPrecheck )
    local missingMessages , count = {} , 0;
    if isPrecheck then
        missingMessages , count = GRMsync.AnyMessagesMissingBDAY ( isPrecheck , GRMsyncGlobals.FinaBdayCommCount[1] , GRMsyncGlobals.FinaBdayCommCount[2] );
    else
        missingMessages , count = GRMsync.AnyMessagesMissingBDAY ( isPrecheck , GRMsyncGlobals.FinaBdayCommCount[1] );
    end

    if count > 0 then
        -- Still missing messages

    end

    if isPrecheck then
        GRMsync.CheckChanges ( "BDAY" );
    else
        GRMsync.FinalBdayMessagesVerifiedSendComplete();
    end
end



-- Method:          GRMsync.MessageDeliveryCheck ( string )
-- What it Does:    Integrity check on received messages and determines if any are lost to request them again
-- Purpose:         Sync integrity. Critical to know if missing alt groups.
GRMsync.MessageDeliveryCheck = function ( msg )
    GRM_G.MatchPattern10 = GRM_G.MatchPattern10 or GRM.BuildComPattern ( 10 , "?" , false );
    local numJDF , numJD , numPDF , numPD , numALTF , numALT , numCUSTF , numCUST , numBANF , numBAN = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern10 );

    numJDF = tonumber ( numJDF );
    numJD = tonumber ( numJD );
    numPDF = tonumber ( numPDF );
    numPD = tonumber ( numPD );
    numALTF = tonumber ( numALTF );
    numALT = tonumber ( numALT );
    numCUSTF = tonumber ( numCUSTF );
    numCUST = tonumber ( numCUST );
    numBANF = tonumber ( numBANF );
    numBAN = tonumber ( numBAN );
    GRMsyncGlobals.preCheckResult = { numJDF , numJD , numPDF , numPD , numALTF , numALT , numCUSTF , numCUST , numBANF , numBAN };

    local missingMessages , count = GRMsync.AnyMessagesMissing ( numJDF , numJD , numPDF , numPD , numALTF , numALT , numCUSTF , numCUST , numBANF , numBAN );

    if count > 0 then
        GRMsync.SendRequestsForMissingMessages ( missingMessages );

    else
        GRMsync.PreCheckChanges();
    end
end

-- Method:          GRMsync.MessageDeliveryCheckFINAL ( string )
-- What it Does:    Integrity check on received messages and determines if any are lost to request them again
-- Purpose:         Sync integrity. Critical to know if missing alt groups.
GRMsync.MessageDeliveryCheckFINAL = function ( msg )
    GRM_G.MatchPattern5 = GRM_G.MatchPattern5 or GRM.BuildComPattern ( 5 , "?" , false );
    local jdFinal , pdFinal , altFinal , custFinal , banFinal = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern5 );

    jdFinal = tonumber ( jdFinal );
    pdFinal = tonumber ( pdFinal );
    altFinal = tonumber ( altFinal );
    custFinal = tonumber ( custFinal );
    banFinal = tonumber ( banFinal );

    GRMsyncGlobals.FinalMsgCommCount = { jdFinal , pdFinal , altFinal , custFinal , banFinal };

    local missingMessages , count = GRMsync.AnyMessagesMissingFinal ( jdFinal , pdFinal , altFinal , custFinal , banFinal );

    if count > 0 then
        GRMsync.SendRequestsForMissingMessages ( missingMessages , nil , true );
    else
        GRMsync.ProcessFinalAltChanges( true );
    end
end

-- Method:          GRMsync.MessageDeliveryCheckBDAY ( string )
-- What it Does:    Integrity check on received messages and determines if any are lost to request them again
-- Purpose:         Sync integrity. Critical to know if missing alt groups.
GRMsync.MessageDeliveryCheckBDAY = function ( msg , isPrecheck )
    local bdayF , bday , bdayFinal = "" , "" , "";
    local missingMessages , count = {} , 0;

    if isPrecheck then
        GRM_G.MatchPattern2 = GRM_G.MatchPattern2 or GRM.BuildComPattern ( 2 , "?" , false );
        bdayF , bday = GRMsync.ParseComMsg ( msg , GRM_G.MatchPattern2 );
        bdayF = tonumber ( bdayF );
        bday = tonumber ( bday );
        GRMsyncGlobals.FinaBdayCommCount = { bdayF , bday };
        missingMessages , count = GRMsync.AnyMessagesMissingBDAY ( isPrecheck , bdayF , bday );
    else
        bdayFinal = tonumber ( msg );
        GRMsyncGlobals.FinaBdayCommCount = nil;             -- Wipe the previous bdayF data
        GRMsyncGlobals.FinaBdayCommCount = { bdayFinal };
        missingMessages , count = GRMsync.AnyMessagesMissingBDAY ( isPrecheck , bdayFinal );
    end

    if count > 0 then
        if isPrecheck then
            -- Precheck BDAY Data
            GRMsync.SendRequestsForMissingMessages ( missingMessages , nil , false , true , false );
        else
            -- Final sent BDAY Change Data
            GRMsync.SendRequestsForMissingMessages ( missingMessages , nil , false , false , true );
        end
    else

        if isPrecheck then
            GRMsync.CheckChanges ( "BDAY" );
        else
            -- Final data was sent, confirmed to have arrived, let's finish.
            GRMsync.FinalBdayMessagesVerifiedSendComplete();
        end
    end
end

-- Method:          GRMsync.DetermineMissingMessages ( int , table )
-- What it Does:    Determins which messages are missing...
-- Purpose:         To ensure all missing messages are received.
GRMsync.DetermineMissingMessages = function ( numSent , received )
    local missing = {};
    local count = 0;

    if #received == 0 and numSent > 0 then      -- For if all messages are missing
        count = numSent;
        for i = 1 , numSent do
            table.insert ( missing , i );
        end

    else

        -- First check missing at the start...
        if #received > 0 and received[1] > 1 then
            for i = 1 , received[1] - 1 do
                table.insert ( missing , i );
                count = count + 1;
            end
        end

        for i = 2 , #received do
            if received[i] > received[i - 1] + 1 then
                for j = ( received[i - 1] + 1 ) , received[i] - 1 do
                    table.insert ( missing , j );
                    count = count + 1;
                end
            end
        end

        -- Missing numbers at the very end of the table
        if #received > 0 and numSent > received[#received] then
            for i = received[#received] + 1 , numSent do
                table.insert ( missing , i )
                count = count + 1;
            end
        end
    end

    return missing , count;
end

-- Method:          GRMsync.AnyMessagesMissing ( int , int , int , int , int , int )
-- What it Does:    Builds the table of all the missing message
-- Purpose:         Sync integrity. Any lost messages can be sync'd
GRMsync.AnyMessagesMissing = function( numJDF , numJD , numPDF , numPD , numALTF , numALT , numCUSTF , numCUST , numBANF , numBAN )
    local missingMessages = { {} , {} , {} , {} , {} , {} , {} , {} , {} , {} }; -- Each nested table will include the array numbers of missed messages.
    local count = 0;
    local total = 0;

    if #GRMsyncGlobals.messageIndexesReceived.JDF ~= numJDF then
        sort ( GRMsyncGlobals.messageIndexesReceived.JDF );
        missingMessages[1] , count = GRMsync.DetermineMissingMessages ( numJDF , GRMsyncGlobals.messageIndexesReceived.JDF );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.JD ~= numJD then
        sort ( GRMsyncGlobals.messageIndexesReceived.JD );
        missingMessages[2] , count = GRMsync.DetermineMissingMessages ( numJD , GRMsyncGlobals.messageIndexesReceived.JD );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.PDF ~= numPDF then
        sort ( GRMsyncGlobals.messageIndexesReceived.PDF );
        missingMessages[3] , count = GRMsync.DetermineMissingMessages ( numPDF , GRMsyncGlobals.messageIndexesReceived.PDF );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.PD ~= numPD then
        sort ( GRMsyncGlobals.messageIndexesReceived.PD );
        missingMessages[4] , count = GRMsync.DetermineMissingMessages ( numPD , GRMsyncGlobals.messageIndexesReceived.PD );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.ALTF ~= numALTF then
        sort ( GRMsyncGlobals.messageIndexesReceived.ALTF );
        missingMessages[5] , count = GRMsync.DetermineMissingMessages ( numALTF , GRMsyncGlobals.messageIndexesReceived.ALTF );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.ALT ~= numALT then
        sort ( GRMsyncGlobals.messageIndexesReceived.ALT );
        missingMessages[6] , count = GRMsync.DetermineMissingMessages ( numALT , GRMsyncGlobals.messageIndexesReceived.ALT );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.CUSTF ~= numCUSTF then
        sort ( GRMsyncGlobals.messageIndexesReceived.CUSTF );
        missingMessages[7] , count = GRMsync.DetermineMissingMessages ( numCUSTF , GRMsyncGlobals.messageIndexesReceived.CUSTF );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.CUST ~= numCUST then
        sort ( GRMsyncGlobals.messageIndexesReceived.CUST );
        missingMessages[8] , count = GRMsync.DetermineMissingMessages ( numCUST , GRMsyncGlobals.messageIndexesReceived.CUST );
        total = total + count;
    end


    if #GRMsyncGlobals.messageIndexesReceived.BANF ~= numBANF then
        sort ( GRMsyncGlobals.messageIndexesReceived.BANF );
        missingMessages[9] , count = GRMsync.DetermineMissingMessages ( numBANF , GRMsyncGlobals.messageIndexesReceived.BANF );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.BAN ~= numBAN then
        sort ( GRMsyncGlobals.messageIndexesReceived.BAN );
        missingMessages[10] , count = GRMsync.DetermineMissingMessages ( numBAN , GRMsyncGlobals.messageIndexesReceived.BAN );
        total = total + count;
    end

    return missingMessages , total;
end

-- Method:          GRMsync.AnyMessagesMissingFinal ( int , int , int , int )
-- What it Does:    Builds the table of all the missing message
-- Purpose:         Sync integrity. Any lost messages can be sync'd
GRMsync.AnyMessagesMissingFinal = function( jdFinal , pdFinal , altFinal , custFinal , banFinal )
    local missingMessages = { {} , {} , {} , {} , {} }; -- Each nested table will include the array numbers of missed messages.
    local count = 0;
    local total = 0;

    if #GRMsyncGlobals.messageIndexesReceived.JDFINAL ~= jdFinal then
        sort ( GRMsyncGlobals.messageIndexesReceived.JDFINAL );
        missingMessages[1] , count = GRMsync.DetermineMissingMessages ( jdFinal , GRMsyncGlobals.messageIndexesReceived.JDFINAL );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.PDFINAL ~= pdFinal then
        sort ( GRMsyncGlobals.messageIndexesReceived.PDFINAL );
        missingMessages[2] , count = GRMsync.DetermineMissingMessages ( pdFinal , GRMsyncGlobals.messageIndexesReceived.PDFINAL );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.ALTFINAL ~= altFinal then
        sort ( GRMsyncGlobals.messageIndexesReceived.ALTFINAL );
        missingMessages[3] , count = GRMsync.DetermineMissingMessages ( altFinal , GRMsyncGlobals.messageIndexesReceived.ALTFINAL );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.CUSTFINAL ~= custFinal then
        sort ( GRMsyncGlobals.messageIndexesReceived.CUSTFINAL );
        missingMessages[4] , count = GRMsync.DetermineMissingMessages ( custFinal , GRMsyncGlobals.messageIndexesReceived.CUSTFINAL );
        total = total + count;
    end

    if #GRMsyncGlobals.messageIndexesReceived.BANFINAL ~= banFinal then
        sort ( GRMsyncGlobals.messageIndexesReceived.BANFINAL );
        missingMessages[5] , count = GRMsync.DetermineMissingMessages ( banFinal , GRMsyncGlobals.messageIndexesReceived.BANFINAL );
        total = total + count;
    end

    return missingMessages , total;
end

-- Method:          GRMsync.AnyMessagesMissingBDAY ( bool , int , int )
-- What it Does:    Returns an array for the missing messages of each group as well as total count
-- Purpose:         To help determine if data was lost in sync and can re-request the data.
GRMsync.AnyMessagesMissingBDAY = function( isPrecheck , bdayF , bday )
    local missingMessages = { {} }; -- Each nested table will include the array numbers of missed messages.
    if isPrecheck then
        table.insert ( missingMessages , {} );
    end

    local count = 0;
    local total = 0;

    if isPrecheck then
        if #GRMsyncGlobals.messageIndexesReceived.BDAYF ~= bdayF then
            sort ( GRMsyncGlobals.messageIndexesReceived.BDAYF );
            missingMessages[1] , count = GRMsync.DetermineMissingMessages ( bdayF , GRMsyncGlobals.messageIndexesReceived.BDAYF );
            total = total + count;
        end

        if #GRMsyncGlobals.messageIndexesReceived.BDAY ~= bday then
            sort ( GRMsyncGlobals.messageIndexesReceived.BDAY );
            missingMessages[2] , count = GRMsync.DetermineMissingMessages ( bday , GRMsyncGlobals.messageIndexesReceived.BDAY );
            total = total + count;
        end
    else
        if #GRMsyncGlobals.messageIndexesReceived.BDAYFINAL ~= bdayF then
            sort ( GRMsyncGlobals.messageIndexesReceived.BDAYFINAL );
            missingMessages[1] , count = GRMsync.DetermineMissingMessages ( bdayF , GRMsyncGlobals.messageIndexesReceived.BDAYFINAL );
            total = total + count;
        end
    end

    return missingMessages , total;
end

--------------------------
--- END MISSING CHECK ----
--------------------------

-- Method:          GRMsync.PreCheckChanges()
-- What it Does:    Controls the flow of changes. No need to checkForChanges if player has only sent minimal data
-- Purpose:         A leaner sync algorithm!
GRMsync.PreCheckChanges = function ()
    if GRMsyncGlobals.SyncPath[1] then
        GRMsync.CheckChanges ( "JD" );
    end
    if GRMsyncGlobals.SyncPath[2] then
        GRMsync.CheckChanges ( "PD" );
    end
    if GRMsyncGlobals.SyncPath[3] then
        GRMsync.CheckingALTChanges();
    end
    if GRMsyncGlobals.SyncPath[4] then
        GRMsync.CheckChanges ( "CUSTOM" );
    end
    if GRMsyncGlobals.SyncPath[6] then
        GRMsync.CheckChanges ( "BAN" );
    end

    GRMsync.SubmitFinalJoinDateData();      -- First step of final submission
end

-- Method:          GRMsync.CheckChanges ( string )
-- What it Does:    Checks to see if the received data and the leader's data is different and then adds the most recent changes to update que
-- Purpose:         Retroactive Sync Procedure fully defined here in this method. MUCH WORK!
GRMsync.CheckChanges = function ( msg )
    -----------------------------
    -- For Join Date checking!
    -----------------------------
    if msg == "JD" then
        GRMsync.CheckingJDChanges();

    -----------------------------
    -- For Promo Date checking!
    -----------------------------
    elseif msg == "PD" then
        GRMsync.CheckingPDChanges();

    -----------------------------
    -- For Custom Note checking!
    -----------------------------
    elseif msg == "CUSTOM" then
        GRMsync.CheckingCustomNoteChanges();

    -----------------------------
    --- FOR BAN STATUS CHECK ----
    -----------------------------
    elseif msg == "BAN" then
        GRMsync.CheckingBANChanges();

    -----------------------------
    -- For BIRTHDAY checking!
    -----------------------------
    elseif msg == "BDAY" then
        GRMsync.CheckingBdayChanges();
    end

end
-- /run GRMsyncGlobals.updatesEach= {148 , 127 , 131,6,48,16,9,16};GRMsync.ReportResults()
-- What it Does:    Builds the string of all results and reports it to chat window
-- Purpose:         Give player information on what has been updated.
GRMsync.ReportResults = function()
    local results = "";


    local addedSpace = function ( count , maxSpaces )
        local spaceCount = ( maxSpaces - GRMsync.GetNumDigits ( count ) ) + 1   -- Always need at least 1 space
        local result = "";
        for i = 1 , spaceCount do
            result = result .. " ";
        end
        if spaceCount > 2 then
            result = result .. "  ";
        end
        return result;
    end

    -- -- Determine the number of spaces
    -- numDigits = GRMsync.GetNumDigits ( GRMsyncGlobals.updatesEach[i] );
    --     if numDigits > totalSpace then
    --         totalSpaces = totalSpaces;
    local numDigits = 0;
    local totalSpaces = 1;
    for i = 1 , #GRMsyncGlobals.updatesEach do
        numDigits = GRMsync.GetNumDigits ( GRMsyncGlobals.updatesEach[i] );
        if numDigits > totalSpaces then
            totalSpaces = numDigits;
        end
    end

    -- Now, set the maxSpaces gap

    for i = 1 , ( #GRMsyncGlobals.updatesEach - 1 ) do -- Subtracting 1 since I am doing mains out of order

        if i == 1 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "Join Dates" );
        elseif i == 2 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "Promo Dates" );
        elseif i == 3 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "Alts/Mains" );
        elseif i == 4 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "Custom Notes" );
        elseif i == 5 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "Birthdays" );
        elseif i == 6 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "Bans" );
        elseif i == 7 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "UnBans" );
        elseif i == 8 and GRMsyncGlobals.updatesEach[i] > 0 then
            results = results .. "\n" .. GRM.L ( "{num}{custom1}: " , nil , nil , GRMsyncGlobals.updatesEach[i] , addedSpace ( GRMsyncGlobals.updatesEach[i] , totalSpaces ) ) .. GRM.L ( "Ban Edits" );
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
            -- if not GRMsyncGlobals.SyncTracker.finish then
            --     GRMsyncGlobals.ProgressControl ( "FINISH" );
            -- end

            GRM.Report ( announce );
            GRMsync.ReportResults();
            GRMsync.ReportAuditMessage();

            -- GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , 0.5 , { 0.42 , 0.92 , 1 } );

            GRMsyncGlobals.syncComplete = true;
            GRM_G.slashCommandSyncTimer = time();

        end

        GRM_UI.RefreshSelectFrames ( true , true , true , false , true , true );

        if GRM_UI.GRM_LoadToolButton:IsVisible() then
            GRM_UI.RefreshToolButtonsOnUpdate();
        end

        GRMsyncGlobals.errorCheckEnabled = false;
        GRMsyncGlobals.AnnounceDelay = time();
    end
    GRMsync.TriggerFullReset();
end

-- Method:          GRM.AuditRefreshTracker( bool )
-- What it Does:    Every 100 updates it sends the audit an update request. Due to sync speed limitations, this is just an internal throttle on updating the audit
-- Purpose:         Quality of life audit update when syncing.
GRM.AuditRefreshTracker = function ( force )
    if not force then
        GRMsyncGlobals.refreshCount = GRMsyncGlobals.refreshCount + 1;
        GRMsyncGlobals.refreshCountTimer = time();
    end
    if ( ( GRMsyncGlobals.refreshCount % 50 ) == 0 or force ) then
        GRM_UI.RefreshSelectFrames ( false , true , false , false , false , false );
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
    local altName = GRM.Next ( msg );
    GRM.RemovePlayerFromAltGroup ( altName , 0 , false , false );
end

-------------------------------
------ INITIALIZING -----------
-------------------------------

-- Rather than have locals rebuild and reset over and over and over everytime it is called, now keep them in this local table for endless reuse.
local comms = {};
comms.isFound = false;
comms.prefix2 = "";
comms.senderRankRequirement = nil;
comms.senderRankRequirement = 0;

-- For each call to more easily validate the custom 2ndary prefixes
-- Rather than set GRM to validate more than 1 prefix on the server, GRM doesn't cloudy the global space and only uses a single prefix, and adds its own custom 2ndary prefixes at beginning of each message string.
local commsLive = { ["GRM_JD"] = true , ["GRM_PD"] = true , ["GRM_ADDALT"] = true , ["GRM_AC"] = true , ["GRM_RMVALT"] = true , ["GRM_MAIN"] = true , ["GRM_RMVMAIN"] = true , ["GRM_BDAY"] = true , ["GRM_BDAYREM"] = true };

local commsPreCheck = { ["GRM_PREHASHALL"] = true , ["GRM_PREALLRESULT"] = true , ["GRM_PREALLRESULT2"] = true , ["GRM_RECJDPRE"] = true , ["GRM_RECPDPRE"] = true , ["GRM_RECALTPRE"] = true , ["GRM_RECCUSTPRE"] = true , ["GRM_FINALPRE"] = true , ["GRM_FINALPRE2"] = true , ["GRM_RECBDAYPRE"] = true , ["GRM_RECBANPRE"] = true }

local commsSyncUp = { ["GRM_JDSYNCUP"] = true , ["GRM_PDSYNCUP"] = true , ["GRM_BDSYNCUP"] = true };

local dataPackets = { ["GRM_JDSYNCF"] = true , ["GRM_PDSYNCF"] = true , ["GRM_ALTSYNCF"] = true , ["GRM_CUSTSYNCF"] = true , ["GRM_BDAYSYNCF"] = true };

local altSyncUp = { ["GRM_ALTSYNC1"] = true ,  ["GRM_ALTSYNC2"] = true ,  ["GRM_ALTSYNC3"] = true ,  ["GRM_ALTSYNC4"] = true };

local banSync = { ["GRM_BAN"] = true , ["GRM_UNBAN"] = true , ["GRM_BANSYNCF"] = true };
local banSyncUp = { ["GRM_BANSYNCUP1"] = true , ["GRM_BANSYNCUP2"] = true , ["GRM_BANSYNCUP3"] = true , ["GRM_BANSYNCUP4"] = true , ["GRM_BANSYNCUP5"] = true , ["GRM_BANSYNCUP6"] = true };
local banPackets = { ["GRM_BANSYNC1"] = true , ["GRM_BANSYNC2"] = true , ["GRM_BANSYNC3"] = true , ["GRM_BANSYNC4"] = true , ["GRM_BANSYNC5"] = true , ["GRM_BANSYNC6"] = true };

local commsLead = { ["GRM_WHOISLEADER"] = true , ["GRM_IAMLEADER"] = true , ["GRM_ELECT"] = true , ["GRM_ELECTINFO"] = true , ["GRM_NEWLEADER"] = true , ["GRM_STARTMSG"] = true };

local commsMissing = { ["GRM_REQMISJDF"] = true , ["GRM_REQMISJD"] = true , ["GRM_REQMISPDF"] = true , ["GRM_REQMISPD"] = true , ["GRM_REQMISALTF"] = true , ["GRM_REQMISBDAY"] = true , ["GRM_REQMISCUSTF"] = true , ["GRM_REQMISCUST"] = true , ["GRM_REQMISBANF"] = true , ["GRM_REQMISBAN"] = true , ["GRM_REQMISBDAYF"] = true , ["GRM_REQJDFIN"] = true , ["GRM_REQPDFIN"] = true , ["GRM_REQALTFIN"] = true , ["GRM_REQCUSTFIN"] = true , ["GRM_REQBANFIN"] = true , ["GRM_REQBDAYFIN"] = true };

local macroSync = { ["GRM_MACRO_T"] = true , ["GRM_Macro_SK"] = true , ["GRM_Macro_SP"] = true , ["GRM_Macro_SD"] = true , ["GRM_Macro_RK"] = true , ["GRM_Macro_RP"] = true , ["GRM_Macro_RD"] = true , ["GRM_Macro_LK"] = true , ["GRM_Macro_LP"] = true , ["GRM_Macro_LD"] = true , ["GRM_Macro_PQ"] = true , ["GRM_Macro_FN"] = true , ["GRM_Macro_XX"] = true , ["GRM_Macro_MK"] = true , ["GRM_Macro_MP"] = true , ["GRM_Macro_MD"] = true , ["GRM_MISSINGCHECK"] = true }; -- Received, sentKick , sentPromote , sentDemote , sentCustom

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

            if event == "CHAT_MSG_ADDON" and ( channel == GRMsyncGlobals.channelName or channel == "WHISPER" ) and GRMsync.IsPrefixVerified ( prefix ) then     -- Don't need to register my own prefixes.

                -- Sender must not equal themselves...
                if sender ~= GRM_G.addonUser then

                    -- First, see if they are on compatible list.
                    comms.isFound = false;
                    if GRMsyncGlobals.CompatibleAddonUsers[sender] then
                        comms.isFound = true;
                    else
                        return;     -- No need to carry on. Player is not compatible to sync with.
                    end

                    comms.prefix2 = string.match ( msg , "^(.-)%?" );
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

                    -- To cleanup Lua errors from very old versions trying to communicate...
                    comms.senderRankRequirement = nil;
                    if string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) ~= nil then

                        comms.senderRankRequirement = tonumber ( string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 ) );
                        if comms.senderRankRequirement == nil then
                            -- ABORT
                            return
                        end
                    else
                        return;
                    end

                    comms.senderRankID = GRM.GetGuildMemberRankID ( sender );
                    if not GRM_G.playerRankID then    -- Configure only first time
                        GRM_G.playerRankID = GRM.GetGuildMemberRankID ( GRM_G.addonUser );
                    end

                    -- Rank controls
                    if ( commsLive[comms.prefix2] or commsSyncUp[comms.prefix2] ) and ( comms.senderRankRequirement < GRM_G.playerRankID or comms.senderRankID > GRM.S().syncRank ) then
                        return

                    elseif ( comms.prefix2 == "GRM_CNOTE1" or comms.prefix2 == "GRM_CNOTE2" or comms.prefix2 == "GRM_CNOTE3" or comms.prefix2 == "GRM_CUSTSYNCUP1" or comms.prefix2 == "GRM_CUSTSYNCUP2" or comms.prefix2 == "GRM_CUSTSYNCUP3" ) and ( comms.senderRankID > GRM.S().syncRankCustom or comms.senderRankRequirement < GRM_G.playerRankID ) then
                        return

                    elseif ( not GRMsyncGlobals.IsElectedLeader and not commsLead[comms.prefix2] and sender ~= GRMsyncGlobals.DesignatedLeader ) and ( comms.senderRankID > GRM.S().syncRank or comms.senderRankRequirement < GRM_G.playerRankID ) then        -- If player's rank is below settings threshold, ignore message.
                        return

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
                        GRMsync.CheckAddAltChange ( msg , sender );

                    -- For Removing an alt!
                    elseif comms.prefix2 == "GRM_RMVALT" then
                        GRMsync.CheckRemoveAltChange ( msg , sender );

                    -- For declaring who is to be "main"
                    elseif comms.prefix2 == "GRM_MAIN" then
                        GRMsync.CheckSetMainChange ( msg , sender );

                    -- For demoting from main -- basically to set as no mains.
                    elseif comms.prefix2 == "GRM_RMVMAIN" then
                        GRMsync.CheckDemoteFromMainChange ( msg , sender );

                    elseif comms.prefix2 == "GRM_CNOTE1" or comms.prefix2 == "GRM_CNOTE2" or comms.prefix2 == "GRM_CNOTE3" then
                        GRMsync.CheckCustomNoteChange ( msg , sender , comms.prefix2 );

                    elseif comms.prefix2 == "GRM_BDAY" then
                        GRMsync.CheckBirthdayChange ( msg , sender , false )

                    elseif comms.prefix2 == "GRM_BDAYREM" then
                        GRMsync.CheckBirthdayRemoveChange ( msg , sender )

                    -- I want to accept LIVE changes, but not core sync changes.
                    elseif not GRM_G.InGroup then

                        -- For ensuring ban information is controlled!
                        if ( banSync[comms.prefix2] or banSyncUp[comms.prefix2] or banPackets[comms.prefix2] ) and GRM.S().syncBanList then

                            if ( comms.senderRankID > GRM.S().syncRankBanList or comms.senderRankRequirement < GRM_G.playerRankID ) then
                                -- Abort
                                return;
                            else
                                GRMsyncGlobals.TimeSinceLastSyncAction = time();

                                if comms.prefix2 == "GRM_BAN" then
                                    GRMsync.CheckBanListChange ( msg , sender );                        -- For live ban occurences

                                elseif comms.prefix2 == "GRM_UNBAN" then
                                    GRMsync.CheckUnbanListChangeLive ( msg , sender );                  -- For live unban occurrences

                                elseif comms.prefix2 == "GRM_BANSYNCF" then
                                    GRMsync.CollectDataPacketsF ( msg , comms.prefix2 );
                                                      -- For collecting sync data...

                                elseif banSyncUp[comms.prefix2] then
                                    GRMsync.BanManagement ( msg , comms.prefix2 , sender );    -- For sync analysis final report changes!

                                elseif banPackets[comms.prefix2] then
                                    GRMsync.CollectBanData ( msg , comms.prefix2 );

                                end
                            end
                        --------------------------------------------
                        -------- RETROACTIVE SYNC TRACKING ---------
                        --------------------------------------------

                        -- In response to asking "Who is the leader" then ONLY THE LEADER will respond.
                        elseif comms.prefix2 == "GRM_WHOISLEADER" then
                            GRMsync.LeaderRespond ( msg );

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
                                local msg = "GRM_BUSY?" .. GRMsyncGlobals.syncRankFilter .. "?" .. tostring ( #GRMsyncGlobals.SyncQue - 1 );
                                GRMsyncGlobals.SyncCount = GRMsyncGlobals.SyncCount + #msg;
                                GRMsync.SendMessage ( "GRM_SYNC" , msg , sender );
                            end

                        elseif comms.prefix2 == "GRM_BUSY" then
                            GRMsync.BusyMessage ( tonumber ( msg ) );

                            -- PLAYER DATA REQ FROM LEADERS
                        -- Leader has requesated your Join Date Data!
                        elseif comms.prefix2 == "GRM_REQJDDATA" and msg == GRM_G.addonUser and not GRMsyncGlobals.currentlySyncing then
                            GRMsync.DataRequestStart();

                        -- elseif comms.prefix2 == "GRM_TRACKER" then
                        --     GRMsync.CollectTrackerCalculation ( msg );
                        --     GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , GRMsyncGlobals.totalEstTime );
                        --     GRMsyncGlobals.progStart = time();

                        -- Pseudo Hash for comparison
                        elseif commsPreCheck[comms.prefix2] then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();

                            if comms.prefix2 == "GRM_PREHASHALL" then
                                GRMsync.CompareOverallHashes( msg )

                            elseif comms.prefix2 == "GRM_PREALLRESULT" then
                                GRMsync.SetSyncPathway( msg )

                            elseif comms.prefix2 == "GRM_PREALLRESULT2" then
                                GRMsync.UpdateSyncPathway( msg )

                            elseif comms.prefix2 == "GRM_RECALTPRE" or comms.prefix2 == "GRM_RECJDPRE" or comms.prefix2 == "GRM_RECPDPRE" or comms.prefix2 == "GRM_RECCUSTPRE" or comms.prefix2 == "GRM_RECBDAYPRE" or comms.prefix2 == "GRM_RECBANPRE" then
                                GRMsync.CollectPreCheckData( msg , comms.prefix2 );

                            elseif comms.prefix2 == "GRM_FINALPRE" then
                                GRMsync.ProcessPreCheckDataAndBeginSync();

                            elseif comms.prefix2 == "GRM_FINALPRE2" then
                                GRMsync.ProcessBdayDataAndContinue();
                            end

                        -- Final data sent, let's analyze now.
                        elseif comms.prefix2 == "GRM_STOP" and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.MessageDeliveryCheck ( msg );

                        elseif comms.prefix2 == "GRM_FINALSTOP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.MessageDeliveryCheckFINAL ( msg );

                        elseif comms.prefix2 == "GRM_FINALSTOP2" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.MessageDeliveryCheckBDAY ( msg , false );

                        elseif comms.prefix2 == "GRM_FINALSTOP3" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.FinalSyncComplete();

                        elseif comms.prefix2 == "GRM_STOP2" and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.MessageDeliveryCheckBDAY ( msg , true );
                            -- Check for missing Bday Messages??

                        -- Collect all data before checking for changes!
                        elseif ( comms.prefix2 == "GRM_JDSYNC" or comms.prefix2 == "GRM_PDSYNC" ) and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectData ( msg , comms.prefix2 );

                        elseif dataPackets[comms.prefix2] and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectDataPacketsF ( msg , comms.prefix2 );

                        -- For ALT ADD DATA
                        elseif altSyncUp[comms.prefix2] and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectAltAddData ( msg , comms.prefix2 );

                        -- for CUSTOM NOTE Data
                        elseif ( comms.prefix2 == "GRM_CUSTSYNC1" or comms.prefix2 == "GRM_CUSTSYNC2" or comms.prefix2 == "GRM_CUSTSYNC3" ) and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectCustomNoteData ( msg , comms.prefix2 );

                        -- Birthday Data
                        elseif comms.prefix2 == "GRM_BDSYNC" and sender == GRMsyncGlobals.CurrentSyncPlayer then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectBirthdayData ( msg )

                        -- AFTER DATA RECEIVED AND ANALYZED, SEND UPDATES!!!
                        -- THESE WILL HEAD TO THE SAME METHODS AS LIVE SYNC, WITH A COUPLE CHANGES BASED ON UNIQUE MESSAGE HEADER.
                        -- Sync the Join Dates!
                        elseif comms.prefix2 == "GRM_JDSYNCUP" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();

                            -- if not GRMsyncGlobals.SyncTracker.finalJD then
                            --     GRMsyncGlobals.ProgressControl ( "FINALJD" );
                            --     if GRMsyncGlobals.TrackerData.JD[1] then
                            --         GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.JD[1] , GRMsyncGlobals.TrackerData.JD[3] );
                            --     end
                            -- end

                            GRMsync.CheckJoinDateChange ( msg , nil , comms.prefix2 );
                            GRM.AuditRefreshTracker();

                        -- Sync the Promo Dates!
                        elseif comms.prefix2 == "GRM_PDSYNCUP" then

                            -- if not GRMsyncGlobals.SyncTracker.finalPD then
                            --     GRMsyncGlobals.ProgressControl ( "FINALPD" );

                            --     if GRMsyncGlobals.TrackerData.PD[1] then
                            --         GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.PD[1] , GRMsyncGlobals.TrackerData.PD[3] );
                            --     end
                            -- end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckPromotionDateChange ( msg , sender , comms.prefix2 );
                            GRM.AuditRefreshTracker();

                        -- Final sync of ALT player info
                        elseif comms.prefix2 == "GRM_ALTSYNCUP1" or comms.prefix2 == "GRM_ALTSYNCUP2" then

                            -- if not GRMsyncGlobals.SyncTracker.finalAlts then
                            --     GRMsyncGlobals.ProgressControl ( "FINALALT" );
                            -- end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckFinalAltMainAndNotGroupChanges ( msg , comms.prefix2 , false );

                        elseif comms.prefix2 == "GRM_ALTSYNCUP3" or comms.prefix2 == "GRM_ALTSYNCUP4" then

                            -- if not GRMsyncGlobals.SyncTracker.finalAlts then
                            --     GRMsyncGlobals.ProgressControl ( "FINALALT" );
                            -- end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckFinalAltFullGroupChanges ( msg , comms.prefix2 , nil , false );

                        -- Final sync on Custom Note Changes
                        elseif comms.prefix2 == "GRM_CUSTSYNCUP1" or comms.prefix2 == "GRM_CUSTSYNCUP2" or comms.prefix2 == "GRM_CUSTSYNCUP3" then

                            -- if not GRMsyncGlobals.SyncTracker.finalCustom then
                            --     GRMsyncGlobals.ProgressControl ( "FINALCUSTOM" );
                            --     if GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] then
                            --         GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.CUSTOMNOTE[1] , GRMsyncGlobals.TrackerData.CUSTOMNOTE[3] );
                            --     end
                            -- end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckCustomNoteSyncChange ( msg , comms.prefix2 , true );

                        -- Final sync on Birthdays
                        elseif comms.prefix2 == "GRM_BDSYNCUP" then

                            -- if not GRMsyncGlobals.SyncTracker.finalBdays then
                            --     GRMsyncGlobals.ProgressControl ( "FINALBDAYS" );
                            --     if GRMsyncGlobals.TrackerData.BDAY[1] then
                            --         GRM_API.CheckPoint ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , GRMsyncGlobals.TrackerData.BDAY[1] , GRMsyncGlobals.TrackerData.BDAY[3] );
                            --     end
                            -- end

                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CheckBirthdayForSync ( msg );
                            GRM.AuditRefreshTracker();

                        -- Final Announce!!!
                        elseif comms.prefix2 == "GRM_COMPLETE" then
                            if msg == GRM_G.addonUser then
                                GRMsyncGlobals.TimeSinceLastSyncAction = time();
                                GRMsyncGlobals.currentlySyncing = false;
                                GRMsyncGlobals.dateSentComplete = true;
                                GRMsync.ReportSyncCompletion ( GRMsyncGlobals.DesignatedLeader , true );
                            end

                        -- ERROR PROTECTIONS!!
                        elseif comms.prefix2 == "GRM_RMVERR" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.RemoveAltErrorFix( msg );

                        -- Collect request of missing info
                        elseif commsMissing[comms.prefix2] then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.CollectMissingMsgRequest ( msg , comms.prefix2 );

                        elseif comms.prefix2 == "GRM_MISFIN" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.SendMissingMessages( false );

                        elseif comms.prefix2 == "GRM_MISFIN2" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.SendMissingMessages( true );

                        elseif comms.prefix2 == "GRM_MISFIN3" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.SendMissingMessages( false , true );

                        elseif comms.prefix2 == "GRM_MISFIN4" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.SendMissingMessages( false , false , true );

                        elseif comms.prefix2 == "GRM_MISSENT" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.ValidateReSentMessages();

                        elseif comms.prefix2 == "GRM_MISSENT2" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.ValidateReSentMessagesFinal();

                        elseif comms.prefix2 == "GRM_MISSENT3" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.ValidateReSentMessagesBday( true );

                        elseif comms.prefix2 == "GRM_MISSENT4" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.ValidateReSentMessagesBday( false );

                        elseif comms.prefix2 == "GRM_ALTPROCESSED" then
                            GRMsyncGlobals.TimeSinceLastSyncAction = time();
                            GRMsync.SubmitFinalSyncData();

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
    local delay = 0;
    -- Initialize the error check now as you are now the front of the que being currently sync'd
    if not GRM.IsCalendarEventEditOpen() then
        GRM.GuildRoster();
        delay = 0.5;
    end

    -- Delay is necessary as it can take a moment for server to send the updated roster details.
    C_Timer.After ( delay , function()
        GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;
        -- Establish Database as an array
        GRMsyncGlobals.guildData , GRMsyncGlobals.formerGuildData , GRMsyncGlobals.guildAltData = GRM.convertToArrayFormat( true , true ); -- Now, we set arrays of the data.

        if not GRMsyncGlobals.errorCheckEnabled then
            GRMsync.ErrorCheck();
            GRMsyncGlobals.errorCheckEnabled = true;
        else
            GRMsyncGlobals.ErrorCheckControl = false;
        end

        if GRMsyncGlobals.WaitingInQue then
            GRMsyncGlobals.WaitingInQue = false;
            GRM.Report ( GRM.L ( "Sync has begun after waiting in queue for {num} seconds" , nil , nil , time() - GRMsyncGlobals.WaitingInQueTimer ) );
        end

        -- GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 10 , 5 );
    end);
end

-- Method:          GRMsync.BuildSyncNetwork()
-- What it Does:    Step by step of my in-house sync algorithm custom built for this addon. Step by step it goes!
-- Purpose:         Control the work-flow of establishing the sync infrastructure. This will not maintain it, just builds the initial rules and the server-side channel of communication between players using the addon. Furthermore, by compartmentalizing it, it controls the flow of actions allowing a recursive check over the algorithm for flawless timing, and not moving ahead until the proper parameters are first met.
GRMsync.BuildSyncNetwork = function( forMacro , requestForTime )
    -- Rank necessary to be established to keep'
    if IsInGuild() then
        if not GRMsyncGlobals.DatabaseLoaded then
            GRMsync.WaitTilDatabaseLoads ( forMacro );
            return;
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
            return;
        end

        if forMacro then
            if requestForTime then
                GRM.MacroSyncSendTime();
            end
            return;
        end

        if GRMsyncGlobals.DatabaseLoaded and GRMsyncGlobals.RulesSet and not GRMsyncGlobals.LeadershipEstablished and not GRMsyncGlobals.LeadSyncProcessing then

            if GRMsyncGlobals.reloadControl and ( time() - GRMsyncGlobals.timeOfLastSyncCompletion ) >= 5 then
                GRMsyncGlobals.reloadControl = false;
            else
                if not GRM_G.InGroup then
                    GRMsyncGlobals.LeadSyncProcessing = true;
                    GRMsync.EstablishLeader();
                end
            end
        end
    end
end

-- ON LOADING!!!!!!!
-- Method:          GRMsync.Initialize()
-- what it Does:    Houses the initial configuration of the sync process
-- Purpose:         Act as gatekeeper for sync
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
                GRMsyncGlobals.numGuildRanks = GuildControlGetNumRanks() - 1;

                if GRM_G.playerRankID then
                    GRMsync.BuildSyncNetwork();
                end

            else

                GRM.Report ( GRM.L ( "Sync is disabled for {num} seconds after logging in. Please wait {custom1} seconds longer." , nil , nil , GRM.S().syncDelay , ( GRM.S().syncDelay - ( time() - GRMsyncGlobals.timeAtLogin ) ) ) );

            end
        end
    end
end

GRMsync.HookComms();