GRML.TranslationStatusEnum = {
    English = true,
    German = false,
    French = false,
    Italian = false,
    Russian = false,
    SpanishMX = false,
    SpanishEU = false,
    Portuguese = false,
    PortugueseBR = false,
    Korean = false,
    MandarinCN = false,
    MandarinTW = false,
    Dutch = false,
    Danish = false
}

GRML.Languages = {
    "English",
    "German",
    "French",
    "Italian",
    "Russian",
    "SpanishMX",
    "SpanishEU",
    "Portuguese",
    "PortugueseBR",
    "Korean",
    "MandarinCN",
    "MandarinTW",
    "Dutch",
    "Danish"
}

-- Method:          GetFontNameFromLocation ( string )
-- What it does:    Parses out the name of the font from the file
-- Purpose:         To be able to identify any font...
local function GetFontNameFromLocation( fontFileLocation )
    local result = "";
    for i = #fontFileLocation , 1 , -1 do
        if string.sub ( fontFileLocation , i , i ) == "\\" then
            result = string.sub ( fontFileLocation , i + 1 , string.find ( fontFileLocation , "%." ) - 1 );
            break;
        end
    end
    result = string.gsub ( result , "_" , "" );
    return result;
end

GRML.FontNames = {
    "Default(" .. GetFontNameFromLocation ( STANDARD_TEXT_FONT ) .. ")",
    "Blizz FrizQT",
    "Blizz FrizQT(Cyr)",
    "Blizz Korean",
    "Blizz MandarinCN",
    "Blizz MandarinTW",
    "Action Man",
    "Ancient",
    "Bitter",
    "Cardinal",
    "Continuum",
    "Expressway",
    "Merriweather",
    "PT Sans",
    "Roboto",
    "Avant Garde Bold",
    "Nunito Xtra Bold"
}

GRML.LoadLanguage = function(index)
    GRML[GRML.Languages[index]]()
end

GRML.listOfFonts = {
    -------------------
    -- DEFAULT FONTS
    -------------------
    STANDARD_TEXT_FONT,
    -- Non-Cyrillic Friendly
    "Fonts\\FRIZQT__.TTF",
    -- Cyrillic Friendly
    "Fonts\\FRIZQT___CYR.TTF",
    -- Asian Character Friendly (and Cyrillic)
    -- Korean
    "Fonts\\2002.TTF",
    -- Simplified Chinese
    "Fonts\\ARKai_T.TTF",
    -- Traditional Chines
    "Fonts\\blei00d.TTF",

    ---------------
    -- CUSTOM FONTS (so far none are Asian character friendly)
    ---------------
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Action_Man.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Ancient.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Bitter-Regular.OTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Cardinal.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Continuum_Medium.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Expressway.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Merriweather-Regular.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\PT_Sans_Narrow.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Roboto-Regular.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\AvantGarde_Bold.TTF",
    "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Nunito-ExtraBold.TTF"
}

-- Method:          ConfigureAlternativeSlashCommands()
-- What it Does:    Allows the creation of custom slash command.
-- purpose:         Localization reasons.
local function ConfigureAlternativeSlashCommands()
    if GRM_L["/XXXX"]~= true then
        SLASH_GRM2 = GRM_L ["/XXXX"];
        GRM.SlashCommandActions(string.gsub(GRM_L["/XXXX"], "/", "" ));
    end

    if GRM_L["/YYYY"] ~= true then
        SLASH_ROSTER2 = GRM_L["/YYYY"];
        GRM.SlashCommandRosterActions(string.gsub(GRM_L["/YYYY"], "/", "" ));
    end
end

-- Method:          SetFontModifier()
-- What it Does:    Since different custom fonts represent font height differently, this normalizes the fonts, relatively close
-- Purpose:         Consistency, as some fonts would be super tiny otherwise.
local function SetFontModifier()
    -- Reset it...
    GRM_G.FontModifier = 0;
    local modifier = 0;
    if GRM.S() then
        modifier = GRM.S().fontModifier;
    end
    if GRM_G.FontChoice == "Fonts\\ARKai_T.TTF" then                             -- China
        GRM_G.FontModifier = 0.5;
    elseif GRM_G.FontChoice == "FONTS\\blei00d.TTF" then                         -- Taiwan
        GRM_G.FontModifier = 2;
    elseif GRM_G.FontChoice == "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Action_Man.TTF" then
        GRM_G.FontModifier = 1;
    elseif GRM_G.FontChoice == "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Ancient.TTF" then
        GRM_G.FontModifier = 2;
    elseif GRM_G.FontChoice == "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Cardinal.TTF" then
        GRM_G.FontModifier = 2;
    elseif GRM_G.FontChoice == "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Continuum_Medium.TTF" then
        GRM_G.FontModifier = 1;
    elseif GRM_G.FontChoice == "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Expressway.TTF" then
        GRM_G.FontModifier = 1;
    elseif GRM_G.FontChoice == "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\PT_Sans_Narrow.TTF" then
        GRM_G.FontModifier = 2;
    elseif GRM_G.FontChoice == "Interface\\AddOns\\Guild_Roster_Manager\\media\\fonts\\Roboto-Regular.TTF" then
        GRM_G.FontModifier = 1;
    end
    GRM_G.FontModifier = GRM_G.FontModifier + modifier;
end

-- Method:          ReprocessStrings()
-- What it Does:    Reprocesses On Demand loaded strings
-- Purpose:         Assist in localization on the fly. Houses all string reprocess functions.
local function ReprocessStrings()
    GRM.Export.BuildExportStrings();
end

-- Method:          GRML.SetNewLanguage ( int , boolean , boolean )
-- What it Does:    It establishes both the appropriate region font, and a modifier for the Mandarin text
-- Purpose:         To be able to have an in-game UI option to change the player language.
GRML.SetNewLanguage = function ( index , firstLoad , resetAllDefaults )
    local font = 1;
    if GRM.S() then
        font = GRM.S().selectedFont;
    end
    GRML.LoadLanguage(index);
    GRM_G.FontChoice = GRML.listOfFonts[font];
    SetFontModifier();
    if firstLoad then
        GRM_UI.ReloadAllFrames( false , false );
    else
        GRM_UI.ReloadAllFrames ( true , resetAllDefaults );
    end

    -- This will eventually replace all the
    if not firstLoad then
        ReprocessStrings();
    end

    -- Allow implementation of custom slash command.
    ConfigureAlternativeSlashCommands();
end

-- Method:          GRML.SetNewFont( int )
-- What it Does:    Establishes a new font
-- Purpose:         More player customization controls!!!
GRML.SetNewFont = function( index )
    GRM_G.FontChoice = GRML.listOfFonts[index];
    SetFontModifier();
    GRM_UI.ReloadAllFrames( true , false );

    -- This will eventually replace all the
    ReprocessStrings();
end

-- Method:          GRML.GetFontChoice() -- Not necessary for the most part as I can use "STANDARD_TEXT_FONT" - but, just in case...
-- What it Does:    Selects the proper font for the given locale of the addon user.
-- Purpose:         To ensure no ???? are in place and all characters are accounted for.
GRML.GetFontChoiceIndex = function( localizationIndex , selectedFont )
    local result = 1;
    local fontIndex = selectedFont or GRM.S().selectedFont;

    if fontIndex ~= 1 then
        if ( localizationIndex < 5 or ( localizationIndex > 5 and localizationIndex < 10 ) or result > 13 ) then
            result = 2
        else
            result = fontIndex;
        end
        -- For Russian, need Cyrilic compatible font.
        if localizationIndex == 5 and GRM_G.Region ~= "ruRU" then
            -- Russian Cyrilic
            result = 3;
        elseif localizationIndex == 10 and GRM_G.Region ~= "koKR" then
            -- Korean
            result = 4;
        elseif localizationIndex == 11 and GRM_G.Region ~= "zhCN" then
            -- Mandarin Chines
            result = 5;
        elseif localizationIndex == 12 and GRM_G.Region ~= "zhTW" then
            -- Taiwanese
            result = 6;
        end
    else
        result = 1;
    end
    return result;
end

-- Method:          GRML.GetNumberUntranslatedLines ( int )
-- What it Does:    It returns the number of language lines that need to be translated
-- Purpose:         To help reach out to the community to build an effort for crowdsupport for translation efforts.
GRML.GetNumberUntranslatedLines = function ( languageIndex )
    local result = 0;
    -- index 1 will always result as 0 since it is written native in English
    if languageIndex > 1 then
        for _ , y in pairs ( GRM_L ) do
            if y == true then
                result = result + 1;
            end
        end
    end
    return result;
end

-- Method:          GRML.OrigL ( string )
-- What it Does:    Takes a hash result and returns the key. It's essentially a dictionary lookup in reverse
-- Purpose:         Some of the code needs to be localized only on the front end, but the backend code is based on some English variables
--                  This allows the localized data to be presented to the user, but on the backend to cycle back to the hash key for parse analysis.
GRML.OrigL = function(localizedString)
    local result = localizedString;
    -- if it is not nil, then we know we already have the OrigL
    if GRM_L[localizedString] == nil then
        for key, y in pairs(GRM_L) do
            if y == localizedString then
                result = key;
                break
            end
        end
    end
    return result;
end