-- Global Types0

GRM_ENUM = {};

GRM_ENUM.FACTION = {
    ["Horde"] = 0,
    ["Alliance"] = 1,
    ["Neutral"] = 2
};

GRM_ENUM.OPTIONS_TABS = {
    MISC = 0,
    GENERAL = 1,
    SCAN = 2,
    SYNC = 3,
    OFFICER = 4,
    BACKUP = 5,
    HELP = 6,
    UI = 7,
    LOG = 8,
    EXPORT = 9,
    KICK = 10,
    PROMOTE = 11,
    DEMOTE = 12,
    AUDIT = 13,
    SPECIAL = 14,
    MODULES = 15,
    CLASSIC = 16,
    NAMES = 17,
    TOTAL = 17  -- For easy reference
}

GRM_ENUM.OPTIONS_SIZE = {
    W = 600.0,
    H = 480.0
}

GRM_ENUM.BUILD = {              -- Features Added
    ["CLASSICERA"]  = 10000,
    ["FOREVER"]     = 16000,
    ["TBC"]         = 20000,
    ["WOTLK"]       = 30000,    -- Calendar, LFG, achievements, DK Class
    ["CATA"]        = 40000,    -- Guild Rep
    ["MOP"]         = 50000,    -- Monk Class
    ["WOD"]         = 60000,
    ["LEGION"]      = 70000,    -- Demon Hunter class
    ["BFA"]         = 80000,    -- Public note restricted edits to own note, Mythic Score
    ["SL"]          = 90000,
    ["DF"]          = 100000,   -- Profession system overhaul, Cross Faction guilds, Minimap changes, Evoker Class
    ["TWW"]         = 110000,
    ["MIDNIGHT"]    = 120000,   -- Secret Variables and addon restrictions - Also affecting FOREVER
    ["TLT"]         = 130000
}

GRM_ENUM.MONTHS = { "January" , "February" , "March" , "April" , "May" , "June" , "July" , "August" , "September" , "October" , "November" , "December" }

GRM_ENUM.DAYS_BEFORE_MONTH = {
    [1] = 0,
    [2] = 31,
    [3] = 59,
    [4] = 90,
    [5] = 120,
    [6] = 151,
    [7] = 181,
    [8] = 212,
    [9] = 243,
    [10] = 273,
    [11] = 304,
    [12] = 334
};
GRM_ENUM.DAYS_IN_MONTH = {
    [1] = 31,
    [2] = 28, -- Will adjust for leap years as needed
    [3] = 31,
    [4] = 30,
    [5] = 31,
    [6] = 30,
    [7] = 31,
    [8] = 31,
    [9] = 30,
    [10] = 31,
    [11] = 30,
    [12] = 31
}

GRM_ENUM.CLASSES = {"Deathknight", "Demonhunter", "Druid", "Evoker", "Hunter", "Mage", "Monk", "Paladin", "Priest",
                    "Rogue", "Shaman", "Warlock", "Warrior"};