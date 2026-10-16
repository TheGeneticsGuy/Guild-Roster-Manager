-- Global Types0

GRM_ENUM = {};

GRM_ENUM.OPTIONS_TABS = {
    GENERAL = 1,
    SYNC = 2,
    OFFICER = 3,
    SCAN = 4,
    UI = 5,
    NAMES = 6,
    CLASSIC = 7,
    MODULES = 8,
    LOGTOOLS = 9,
    EXPORT = 10
}

GRM_ENUM.OPTIONS_SIZE = {
    W = 600.0,
    H = 480.0
}

GRM_ENUM.BUILD = {              -- Features Added
    ["CLASSICERA"]  = 10000,
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