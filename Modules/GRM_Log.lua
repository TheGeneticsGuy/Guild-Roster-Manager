local Log = {};
GRM.Log = Log;


-------------------------------------------
------- BUILD LOG ENTRY STORAGE FORMATS ---
-------------------------------------------

-- Method:          Log.AddPromotionDateTempLogEntry ( bool , string , string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddPromotionDateTempLogEntry = function(foundInLog, player1, player2, initRank, finRank, date)
    table.insert(GRM_G.TempLogPromotion,
        {1, GRM.GetPromotionLogString(foundInLog, player1, player2, initRank, finRank, date), foundInLog, player1,
         player2, initRank, finRank, date});
end

-- Method:          Log.AddDemotionDateTempLogEntry ( bool , string , string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddDemotionDateTempLogEntry = function(foundInLog, player1, player2, initRank, finRank, date)
    table.insert(GRM_G.TempLogDemotion,
        {2, GRM.GetDemotionLogString(foundInLog, player1, player2, initRank, finRank, date), foundInLog, player1,
         player2, initRank, finRank, date});
end

-- Method:          Log.AddLeveledTempLogEntry ( string , int , int , int , array , bool )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddLeveledTempLogEntry = function(simpleName, milestoneLevel, level, numGained, date, levelCap, fullName)
    table.insert(GRM_G.TempLogLeveled,
        {3, GRM.GetLeveledString(simpleName, milestoneLevel, level, numGained, date, levelCap, fullName), simpleName,
         milestoneLevel, level, numGained, date, levelCap, fullName});
end

-- Method:          Log.AddNoteTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddNoteTempLogEntry = function(simpleName, oldNote, newNote, date)
    table.insert(GRM_G.TempLogNote,
        {4, GRM.GetNoteChangeString(simpleName, oldNote, newNote, date), simpleName, oldNote, newNote, date});
end

-- Method:          Log.AddOfficerNoteTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddOfficerNoteTempLogEntry = function(simpleName, oldNote, newNote, date)
    table.insert(GRM_G.TempLogONote, {5, GRM.GetOfficerNoteChangeString(simpleName, oldNote, newNote, date), simpleName,
                                      oldNote, newNote, date});
end

-- Method:          Log.AddInactiveReturnTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddInactiveReturnTempLogEntry = function(simpleName, hoursReport, date)
    table.insert(GRM_G.TempInactiveReturnedLog,
        {14, GRM.GetInactiveReturnString(simpleName, hoursReport, date), simpleName, hoursReport, date});
end

-- Method:          Log.AddNameChangeTempLogEntry ( string , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddNameChangeTempLogEntry = function(simpleName, oldName, date)
    table.insert(GRM_G.TempNameChanged,
        {11, GRM.GetNameChangeString(simpleName, oldName, date), simpleName, oldName, date});
end

-- Method:          Log.AddBanRejoinEntry ( ... )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddBanRejoinEntry = function(foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
    numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined, origRank, customNote,
    isTransfer)
    table.insert(GRM_G.TempBannedRejoin, {9,
                                          GRM.GetJoinOrRejoinString(foundInLog, player1, player2, date, isRejoin,
        playerLevel, previousName, numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined,
        origRank, customNote, isTransfer), foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
                                          numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo,
                                          dateOriginallyJoined, origRank, customNote, playerLevel, isTransfer});
end

-- Method:          Log.AddNormalRejoinEntry ( ... )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddNormalRejoinEntry = function(foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
    numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined, origRank, customNote,
    isTransfer)
    table.insert(GRM_G.TempRejoin, {7,
                                    GRM.GetJoinOrRejoinString(foundInLog, player1, player2, date, isRejoin, playerLevel,
        previousName, numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined, origRank,
        customNote, isTransfer), foundInLog, player1, player2, date, isRejoin, playerLevel, previousName,
                                    numTimesInGuild, isBanned, reasonBanned, dateLeft, howLongAgo, dateOriginallyJoined,
                                    origRank, customNote, playerLevel, isTransfer});

end

-- Method:          Log.AddJoinEntry ( bool , string , string , array , bool , int )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddJoinEntry = function(foundInLog, player1, player2, date, isRejoin, playerLevel)
    table.insert(GRM_G.TempNewMember,
        {8, GRM.GetJoinOrRejoinString(foundInLog, player1, player2, date, isRejoin, playerLevel), foundInLog, player1,
         player2, date, isRejoin, playerLevel});
end

-- Method:          Log.AddEventEntry ( int , string , string , int , bool , string , array , int )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventEntry = function(eventIndex, fullName, class, eventDay, eventMonthIndex, isLeapYear, date, numYears)
    if eventMonthIndex then
        table.insert(GRM_G.TempEventReport,
            {15, GRM.GetEventString(eventIndex, fullName, class, eventDay, eventMonthIndex, isLeapYear, date, numYears),
            eventIndex, fullName, class, eventDay, eventMonthIndex, isLeapYear, date, numYears});
    end
end

-- Method:          Log.AddHardcoreDeathEntry ( int , string , string , int , int , int , int )
-- What it Does:    Adds an entry for reporting to the log on Hardcore Mode deaths
-- Purpose:         Enable reporting to the log
Log.AddHardcoreDeathEntry = function(fullName, class, level, date)
    table.insert(GRM_G.TempDeathReport,
        {24, GRM.GetDeathString(fullName, class, level, date), fullName, class, level, date})
end

-- Method:          Log.AddRankRenameEntry ( int , string , string , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddRankRenameEntry = function(rankNum, oldRank, newRank, date)
    table.insert(GRM_G.TempRankRename,
        {6, GRM.GetRankRenamedString(rankNum, oldRank, newRank, date), rankNum, oldRank, newRank, date});
end

-- Method:          Log.AddEventRecommendKickTempLogEntry ( string , int , array , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendKickTempLogEntry = function(name, numRules, date, ruleNames)
    table.insert(GRM_G.TempEventRecommendKickReport,
        {16, GRM.GetRecommendKickString(name, numRules, date, ruleNames), name, numRules, date, ruleNames});
end

-- Method:          Log.AddEventRecommendPromotionLogEntry ( string , int , array , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendPromotionLogEntry = function(name, numRules, date, ruleNames)
    table.insert(GRM_G.TempEventRecommendPromotionReport, {22,
                                                           GRM.GetPromotionRecommendString(name, numRules, date,
        ruleNames), name, numRules, date, ruleNames});
end

-- Method:          Log.AddEventRecommendDemotionLogEntry ( string , int , array , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendDemotionLogEntry = function(name, numRules, date, ruleNames)
    table.insert(GRM_G.TempEventRecommendDemotionReport,
        {23, GRM.GetDemotionRecommendString(name, numRules, date, ruleNames), name, numRules, date, ruleNames});
end

-- Method:          Log.AddEventRecommendSpecialLogEntry ( int , array )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddEventRecommendSpecialLogEntry = function(promoteCount, demoteCount, date)
    table.insert(GRM_G.TempEventRecommendSpecialReport,
        {25, GRM.GetSpecialRecommendString(promoteCount, demoteCount, date), promoteCount, demoteCount, date});
end

-- Method:          Log.AddLeftOrKickEntry ( string , bool , string , array , array , string , string , string , array , bool )
-- What it Does     Stores a temp log entry that will later be added in the final report with the pre-processed string
-- Purpose:         By adding all the metadata the string can be re-processed if the player changes their preferred date format or language.
Log.AddLeftOrKickEntry = function(unitName, playerWasKicked, timePassed, logEntryMetaData, listOfAlts, mainName,
    publicNote, officerNote, date, isFoundInEventLog, _, playerLevel, customNote)
    table.insert(GRM_G.TempLeftGuild, {10,
                                       GRM.GetLeftOrKickString(unitName, playerWasKicked, timePassed, logEntryMetaData,
        listOfAlts, mainName, publicNote, officerNote, date, isFoundInEventLog, nil, nil, playerLevel, customNote),
                                       unitName, playerWasKicked, timePassed, logEntryMetaData, listOfAlts, mainName,
                                       publicNote, officerNote, date, isFoundInEventLog, playerLevel, false, customNote});
end

-- Method:          Log.AddLog( list , string )
-- What it Does:    Adds a simple list to the Logreport that includes the indexcode for color, and the included changes as a string
-- Purpose:         For ease in adding to the core log.
Log.AddLog = function(logEntry, name)
    local guildName = name or GRM_G.guildName;
    if logEntry ~= nil and GRM_LogReport_Save[guildName] then
        table.insert(GRM_LogReport_Save[guildName], logEntry);
    end
end