

-- LOCALIZATION ENUMS AND LOGIC

-- Table used for lookup, to determine the extent of the translation work compelted or not. This will be used as a quick lookup reference rather than parsing and counting the entire dictionaries
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

-- Array that holds all the initialization functions to load the dictionary of each language.
GRML.LoadLanguage = {
    GRML.English,
    GRML.German,
    GRML.French,
    GRML.Italian,
    GRML.Russian,
    GRML.SpanishMX,
    GRML.SpanishEU,
    GRML.Portuguese,
    GRML.PortugueseBR,
    GRML.Korean,
    GRML.MandarinCN,
    GRML.MandarinTW,
    GRML.Dutch,
    GRML.Danish
}

-- Method:          GRML.GetFontNameFromLocation ( string )
-- What it does:    Parses out the name of the font from the file
-- Purpose:         To be able to identify any font...
GRML.GetFontNameFromLocation = function ( fontFileLocation )
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
    "Default(" .. GRML.GetFontNameFromLocation ( STANDARD_TEXT_FONT ) .. ")",
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

GRML.listOfFonts = {
    -------------------
    -- DEFAULT FONTS
    -------------------
    STANDARD_TEXT_FONT,
    -- Non-Cyrillic Friendly
    "FONTS\\FRIZQT__.TTF",
    -- Cyrillic Friendly
    "FONTS\\FRIZQT___CYR.TTF",
    -- Asian Character Friendly (and Cyrillic)
    -- Korean
    "FONTS\\2002.TTF",
    -- Simplified Chinese
    "FONTS\\ARKai_T.TTF",
    -- Traditional Chines
    "FONTS\\blei00d.TTF",
    
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

-- Method:          GRM.ConfigureAlternativeSlashCommands()
-- What it Does:    Allows the creation of custom slash command.
-- purpose:         Localization reasons.
GRM.ConfigureAlternativeSlashCommands = function()
    if GRM.L ( "/XXXX" ) ~= true then
        SLASH_GRM2 = GRM.L ( "/XXXX" );
    end

    if GRM.L ( "/YYYY" ) ~= true then
        SLASH_ROSTER2 = GRM.L ( "/YYYY" );
    end
end

-- Method:          GRML.SetNewLanguage ( int , boolean , boolean )
-- What it Does:    It establishes both the appropriate region font, and a modifier for the Mandarin text
-- Purpose:         To be able to have an in-game UI option to change the player language.
GRML.SetNewLanguage = function ( index , firstLoad , resetAllDefaults )
    local font = 1;
    if GRM.S() then
        font = GRM.S().selectedFont;
    end 
    GRML.LoadLanguage[index]();
    GRM_G.FontChoice = GRML.listOfFonts[font];
    GRML.SetFontModifier();
    if firstLoad then
        GRM_UI.ReloadAllFrames( false , false );
    else
        GRM_UI.ReloadAllFrames ( true , resetAllDefaults );
    end

    -- Allow implementation of custom slash command.
    GRM.ConfigureAlternativeSlashCommands();
end

-- Method:          GRML.SetFontModifier()
-- What it Does:    Since different custom fonts represent font height differently, this normalizes the fonts, relatively close
-- Purpose:         Consistency, as some fonts would be super tiny otherwise.
GRML.SetFontModifier = function()
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

-- Method:          GRML.SetNewFont( int )
-- What it Does:    Establishes a new font
-- Purpose:         More player customization controls!!!
GRML.SetNewFont = function( index )
    GRM_G.FontChoice = GRML.listOfFonts[index];
    GRML.SetFontModifier();
    GRM_UI.ReloadAllFrames( true , false );
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

----------------------------------------------
-------- LOCALIZATION SYSTEM MESSAGES --------
-------- DO NOT CHANGE THESE! THEY ARE--------
-------- DIRECT FROM THE SERVER!!!!!! --------
----------------------------------------------

-- All of these values are static and cannot be changed by the addon as they are system messages based on the player's language settings. Whilst they can manually change the language they are 
-- using for the addon, they cannot adjust the language of the WOW client without exiting WOW and adjusting the settings in the Battle.net launcher settings. This is not possible from within game so these values will
-- be static and are used for identifying and parsing system message events.

-- German Defaults
if GRM_G.Region == "deDE" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 2;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "aus der Gilde geworfen."
    GRM_L["joined the guild."] = "Gilde angeschlossen."
    GRM_L["left the guild."] = "hat die Gilde verlassen."
    GRM_L["has promoted"] = "befördert."
    GRM_L["has demoted"] = "degradiert."
    GRM_L["Professions"] = "Berufe"  
    GRM_L["added to friends"] = "zur Kontaktliste hinzugefügt."
    GRM_L["is already your friend"] = "ist bereits einer Eurer Kontakte."
    GRM_L["Player not found."] = "Spieler nicht gefunden."
    GRM_L["has come online."] = "ist jetzt online."
    GRM_L["has gone offline."] = "ist jetzt offline."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Todesritter"
    GRM_L["R_Demonhunter"] = "Dämonenjäger"
    GRM_L["R_Druid"] = "Druide"
    GRM_L["R_Hunter"] = "Jäger"
    GRM_L["R_Mage"] = "Magier"
    GRM_L["R_Monk"] = "Mönch"
    GRM_L["R_Paladin"] = "Paladin"
    GRM_L["R_Priest"] = "Priester"
    GRM_L["R_Rogue"] = "Schurke"
    GRM_L["R_Shaman"] = "Schamane"
    GRM_L["R_Warlock"] = "Hexenmeister"
    GRM_L["R_Warrior"] = "Krieger"

    GRM_L["Neutral"] = "Neutral"
    GRM_L["Friendly"] = "Freundlich"
    GRM_L["Honored"] = "Wohlwollend"
    GRM_L["Revered"] = "Respektvoll"
    GRM_L["Exalted"] = "Ehrfürchtig"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "Gilde & Communitys"

    GRML.LoadLanguage[2]();

-- French Defaults
elseif GRM_G.Region == "frFR" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 3;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "a été renvoyé"
    GRM_L["joined the guild."] = "rejoint la guilde."
    GRM_L["left the guild."] = "a quitté la guilde."
    GRM_L["has promoted"] = "a promu"
    GRM_L["has demoted"] = "a rétrogradé"
    GRM_L["Professions"] = "Métiers"
    GRM_L["added to friends"] = "fait maintenant partie de vos contacts."
    GRM_L["is already your friend"] = "est déjà dans votre liste de contacts."
    GRM_L["Player not found."] = "Joueur introuvable."
    GRM_L["has come online."] = "vient de se connecter."
    GRM_L["has gone offline."] = "vient de se déconnecter."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Chevalier de la mort"
    GRM_L["R_Demonhunter"] = "Chasseur de démons"
    GRM_L["R_Druid"] = "Druide"
    GRM_L["R_Hunter"] = "Chasseur"
    GRM_L["R_Mage"] = "Mage"
    GRM_L["R_Monk"] = "Moine"
    GRM_L["R_Paladin"] = "Paladin"
    GRM_L["R_Priest"] = "Prêtre"
    GRM_L["R_Rogue"] = "Voleur"
    GRM_L["R_Shaman"] = "Chaman"
    GRM_L["R_Warlock"] = "Démoniste"
    GRM_L["R_Warrior"] = "Guerrier"

    GRM_L["Neutral"] = "Neutre"
    GRM_L["Friendly"] = "Amical"
    GRM_L["Honored"] = "Honoré"
    GRM_L["Revered"] = "Révéré"
    GRM_L["Exalted"] = "Exalté"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "Guilde et communautés"

    GRML.LoadLanguage[3]();

-- Italian Defaults
elseif GRM_G.Region == "itIT" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 4;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "stato cacciato dalla"
    GRM_L["joined the guild."] = "si unisce alla gilda."
    GRM_L["left the guild."] = "lascia la gilda."
    GRM_L["has promoted"] = "al grado"
    GRM_L["has demoted"] = " degrada "
    GRM_L["Professions"] = "Professioni"
    GRM_L["added to friends"] = "all'elenco amici."   
    GRM_L["is already your friend"] = "è già nell'elenco amici."
    GRM_L["Player not found."] = "Personaggio non trovato."
    GRM_L["has come online."] = "è ora online."
    GRM_L["has gone offline."] = "è ora offline."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Cavaliere della Morte"
    GRM_L["R_Demonhunter"] = "Cacciatore di Demoni"
    GRM_L["R_Druid"] = "Druido"
    GRM_L["R_Hunter"] = "Cacciatore"
    GRM_L["R_Mage"] = "Mago"
    GRM_L["R_Monk"] = "Monaco"
    GRM_L["R_Paladin"] = "Paladino"
    GRM_L["R_Priest"] = "Sacerdote"
    GRM_L["R_Rogue"] = "Ladro"
    GRM_L["R_Shaman"] = "Sciamano"
    GRM_L["R_Warlock"] = "Stregone"
    GRM_L["R_Warrior"] = "Guerriero"

    GRM_L["Neutral"] = "Neutrale"
    GRM_L["Friendly"] = "Amichevole"
    GRM_L["Honored"] = "Onorato"
    GRM_L["Revered"] = "Riverito"
    GRM_L["Exalted"] = "Osannato"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "Gilda e comunità"

    GRML.LoadLanguage[4]();

-- Russian Defaults
elseif GRM_G.Region == "ruRU" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 5;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "исключает из гильдии "
    GRM_L["joined the guild."] = "к гильдии."
    GRM_L["left the guild."] = "покидает гильдию."
    GRM_L["has promoted"] = " производит "
    GRM_L["has demoted"] = " разжалует "
    GRM_L["Professions"] = "Профессии"
    GRM_L["added to friends"] = " в список друзей."
    GRM_L["is already your friend"] = "уже есть в вашем списке друзей."
    GRM_L["Player not found."] = "Игрок не найден."
    GRM_L["has come online."] = "входит в игровой мир."
    GRM_L["has gone offline."] = "выходит из игрового мира."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Рыцарь смерти"
    GRM_L["R_Demonhunter"] = "Охотник на демонов"
    GRM_L["R_Druid"] = "Друид"
    GRM_L["R_Hunter"] = "Охотник"
    GRM_L["R_Mage"] = "Маг"
    GRM_L["R_Monk"] = "Монах"
    GRM_L["R_Paladin"] = "Паладин"
    GRM_L["R_Priest"] = "Жрец"
    GRM_L["R_Rogue"] = "Разбойник"
    GRM_L["R_Shaman"] = "Шаман"
    GRM_L["R_Warlock"] = "Чернокнижник"
    GRM_L["R_Warrior"] = "Воин"

    GRM_L["Neutral"] = "Равнодушие"
    GRM_L["Friendly"] = "Дружелюбие"
    GRM_L["Honored"] = "Уважение"
    GRM_L["Revered"] = "Почтение"
    GRM_L["Exalted"] = "Превознесение"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "Гильдия и сообщества"

    GRML.LoadLanguage[5]();

    -- Spanish (MX) Defaults
elseif GRM_G.Region == "esMX" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 6;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "ha sido expulsado"
    GRM_L["joined the guild."] = "a la hermandad."
    GRM_L["left the guild."] = "ha abandonado la hermandad."
    GRM_L["has promoted"] = "ha ascendido"
    GRM_L["has demoted"] = "ha degradado"
    GRM_L["Professions"] = "Profesiones"
    GRM_L["added to friends"] = "añadido como amigo."
    GRM_L["is already your friend"] = "ya está en tu lista de amigos."
    GRM_L["Player not found."] = "No se ha encontrado al jugador."
    GRM_L["has come online."] = "se ha conectado."
    GRM_L["has gone offline."] = "se ha desconectado."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Caballero de la Muerte"
    GRM_L["R_Demonhunter"] = "Cazador de demonios"
    GRM_L["R_Druid"] = "Druida"
    GRM_L["R_Hunter"] = "Cazador"
    GRM_L["R_Mage"] = "Mago"
    GRM_L["R_Monk"] = "Monje"
    GRM_L["R_Paladin"] = "Paladín"
    GRM_L["R_Priest"] = "Sacerdote"
    GRM_L["R_Rogue"] = "Pícaro"
    GRM_L["R_Shaman"] = "Chamán"
    GRM_L["R_Warlock"] = "Brujo"
    GRM_L["R_Warrior"] = "Guerrero"

    GRM_L["Neutral"] = "Neutral"
    GRM_L["Friendly"] = "Amistoso"
    GRM_L["Honored"] = "Honorable"
    GRM_L["Revered"] = "Venerado"
    GRM_L["Exalted"] = "Exaltado"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "Hermandad y comunidades"

    GRML.LoadLanguage[6]();

    -- Spanish (EU) Defaults
elseif GRM_G.Region == "esES" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 7;
    GRM_L["has been kicked"] = "ha sido expulsado"
    GRM_L["joined the guild."] = "a la hermandad."
    GRM_L["left the guild."] = "ha abandonado la hermandad."
    GRM_L["has promoted"] = "ha ascendido"
    GRM_L["has demoted"] = "ha degradado"
    GRM_L["Professions"] = "Profesiones"
    GRM_L["added to friends"] = "añadido como amigo."
    GRM_L["is already your friend"] = "en tu lista de amigos."
    GRM_L["Player not found."] = "No se ha encontrado al jugador."
    GRM_L["has come online."] = "se ha conectado."
    GRM_L["has gone offline."] = "se ha desconectado."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Caballero de la Muerte"
    GRM_L["R_Demonhunter"] = "Cazador de demonios"
    GRM_L["R_Druid"] = "Druida"
    GRM_L["R_Hunter"] = "Cazador"
    GRM_L["R_Mage"] = "Mago"
    GRM_L["R_Monk"] = "Monje"
    GRM_L["R_Paladin"] = "Paladín"
    GRM_L["R_Priest"] = "Sacerdote"
    GRM_L["R_Rogue"] = "Pícaro"
    GRM_L["R_Shaman"] = "Chamán"
    GRM_L["R_Warlock"] = "Brujo"
    GRM_L["R_Warrior"] = "Guerrero"

    GRM_L["Neutral"] = "Neutral"
    GRM_L["Friendly"] = "Amistoso"
    GRM_L["Honored"] = "Honorable"
    GRM_L["Revered"] = "Venerado"
    GRM_L["Exalted"] = "Exaltado"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "Hermandad y comunidades"

    GRML.LoadLanguage[7]();

-- Portuguese Defaults
elseif GRM_G.Region == "ptBR" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 8;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "foi expulso da"
    GRM_L["joined the guild."] = "entrou na guilda."
    GRM_L["left the guild."] = "saiu da guilda."
    GRM_L["has promoted"] = " promoveu "
    GRM_L["has demoted"] = " rebaixou "
    GRM_L["Professions"] = "Profissões"
    GRM_L["added to friends"] = "adicionado à lista de amigos."
    GRM_L["is already your friend"] = "já está na lista de amigos."
    GRM_L["Player not found."] = "Jogador não encontrado."
    GRM_L["has come online."] = "se conectou."
    GRM_L["has gone offline."] = "se desconectou."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Cavaleiro da Morte"
    GRM_L["R_Demonhunter"] = "Caçador de Demônios"
    GRM_L["R_Druid"] = "Druida"
    GRM_L["R_Hunter"] = "Caçador"
    GRM_L["R_Mage"] = "Mago"
    GRM_L["R_Monk"] = "Monge"
    GRM_L["R_Paladin"] = "Paladino"
    GRM_L["R_Priest"] = "Sacerdote"
    GRM_L["R_Rogue"] = "Ladino"
    GRM_L["R_Shaman"] = "Xamã"
    GRM_L["R_Warlock"] = "Bruxo"
    GRM_L["R_Warrior"] = "Guerreiro"

    GRM_L["Neutral"] = "Tolerado"
    GRM_L["Friendly"] = "Respeitado"
    GRM_L["Honored"] = "Honrado"
    GRM_L["Revered"] = "Reverenciado"
    GRM_L["Exalted"] = "Exaltado"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "Guilda e Comunidades"

    GRML.LoadLanguage[8]();

    -- Korean Defaults
elseif GRM_G.Region == "koKR" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 9;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "길드에서 추방했습니다."
    GRM_L["joined the guild."] = "님이 길드에 가입했습니다"
    GRM_L["left the guild."] = true
    GRM_L["has promoted"] = "로 올렸습니다."
    GRM_L["has demoted"] = "로 내렸습니다."
    GRM_L["Professions"] = "전문 기술"
    GRM_L["added to friends"] = "님이 친구 목록에 등록되었습니다."
    GRM_L["is already your friend"] = "님은 이미 친구 목록에 있습니다."
    GRM_L["Player not found."] = "플레이어를 찾을 수 없습니다."
    GRM_L["has come online."] = "님이 게임에 접속했습니다."
    GRM_L["has gone offline."] = "님이 게임을 종료했습니다."

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "죽음의 기사"
    GRM_L["R_Demonhunter"] = "악마사냥꾼"
    GRM_L["left the guild."] = "님이 길드를 탈퇴했습니다."
    GRM_L["R_Druid"] = "드루이드"
    GRM_L["R_Hunter"] = "사냥꾼"
    GRM_L["R_Mage"] = "마법사"
    GRM_L["R_Monk"] = "수도사"
    GRM_L["R_Paladin"] = "성기사"
    GRM_L["R_Priest"] = "사제"
    GRM_L["R_Rogue"] = "도적"
    GRM_L["R_Shaman"] = "주술사"
    GRM_L["R_Warlock"] = "흑마법사"
    GRM_L["R_Warrior"] = "전사"

    GRM_L["Neutral"] = "중립적"
    GRM_L["Friendly"] = "약간 우호적"
    GRM_L["Honored"] = "우호적"
    GRM_L["Revered"] = "매우 우호적"
    GRM_L["Exalted"] = "확고한 동맹"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "길드 & 커뮤니티"

    GRML.LoadLanguage[9]();

    -- Mandarin Chinese (CN) Defaults
elseif GRM_G.Region == "zhCN" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 10;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "开除出公会。"
    GRM_L["joined the guild."] = "加入了公会。"
    GRM_L["left the guild."] = "离开了公会。"
    GRM_L["has promoted"] = "晋升为"
    GRM_L["has demoted"] = "降职为"
    GRM_L["Professions"] = "专业"
    GRM_L["added to friends"] = "已被加入好友名单"
    GRM_L["is already your friend"] = "已经在你的好友名单中了"
    GRM_L["Player not found."] = "没有找到玩家。"
    GRM_L["has come online."] = "上线了。"
    GRM_L["has gone offline."] = "下线了。"

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "死亡骑士"
    GRM_L["R_Demonhunter"] = "恶魔猎手"
    GRM_L["R_Druid"] = "德鲁伊"
    GRM_L["R_Hunter"] = "猎人"
    GRM_L["R_Mage"] = "法师"
    GRM_L["R_Monk"] = "武僧"
    GRM_L["R_Paladin"] = "圣骑士"
    GRM_L["R_Priest"] = "牧师"
    GRM_L["R_Rogue"] = "潜行者"
    GRM_L["R_Shaman"] = "萨满祭司"
    GRM_L["R_Warlock"] = "术士"
    GRM_L["R_Warrior"] = "战士"

    GRM_L["Neutral"] = "中立"
    GRM_L["Friendly"] = "友善"
    GRM_L["Honored"] = "尊敬"
    GRM_L["Revered"] = "崇敬"
    GRM_L["Exalted"] = "崇拜"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "公會和社群"

    GRML.LoadLanguage[10]();

-- Mandarin Chinese (TW) Defaults
elseif GRM_G.Region == "zhTW" then
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 11;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = "踢出公會。"
    GRM_L["joined the guild."] = "加入了公會。"
    GRM_L["left the guild."] = "離開了公會。"
    GRM_L["has promoted"] = "晉升為"
    GRM_L["has demoted"] = "降職為"
    GRM_L["Professions"] = "專業技能"
    GRM_L["added to friends"] = "已被加入好友名單。"
    GRM_L["is already your friend"] = "已經在你的好友名單中了"
    GRM_L["Player not found."] = "找不到該玩家。"
    GRM_L["has come online."] = "上線了。"
    GRM_L["has gone offline."] = "下線了。"

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "死亡騎士"
    GRM_L["R_Demonhunter"] = "惡魔獵人"
    GRM_L["R_Druid"] = "德魯伊"
    GRM_L["R_Mage"] = "法師"
    GRM_L["R_Monk"] = "武僧"
    GRM_L["R_Paladin"] = "聖騎士"
    GRM_L["R_Hunter"] = "獵人"
    GRM_L["R_Priest"] = "牧師"
    GRM_L["R_Rogue"] = "盜賊"
    GRM_L["R_Shaman"] = "薩滿"
    GRM_L["R_Warlock"] = "術士"
    GRM_L["R_Warrior"] = "戰士"

    GRM_L["Neutral"] = "中立"
    GRM_L["Friendly"] = "友好"
    GRM_L["Honored"] = "尊敬"
    GRM_L["Revered"] = "崇敬"
    GRM_L["Exalted"] = "崇拜"

    -- Interface default translations
    GRM_L["Guild & Communities"] = "公会与社区"

    GRML.LoadLanguage[11]();

-- English Defaults
elseif GRM_G.Region == "enUS" or GRM_G.Region == "enGB" or not GRM_G.Localized then         -- In case the Region is not found at this point, just default it to English.
    GRM_G.Localized = true
    GRM_G.LocalizedIndex = 1;
    -- SYSTEM MESSAGES (DO NOT CHANGE THESE!!!! They are used for the back-end code to recognize for parsing info out, not for player UI
    GRM_L["has been kicked"] = true
    GRM_L["joined the guild."] = true
    GRM_L["left the guild."] = true
    GRM_L["has promoted"] = true
    GRM_L["has demoted"] = true
    GRM_L["Professions"] = true
    GRM_L["added to friends"] = true
    GRM_L["is already your friend"] = true
    GRM_L["Player not found."] = true
    GRM_L["has come online."] = true
    GRM_L["has gone offline."] = true

    -- CLASSES - R Specific
    GRM_L["R_Deathknight"] = "Death Knight"
    GRM_L["R_Demonhunter"] = "Demon Hunter"
    GRM_L["R_Druid"] = "Druid"
    GRM_L["R_Hunter"] = "Hunter"
    GRM_L["R_Mage"] = "Mage"
    GRM_L["R_Monk"] = "Monk"
    GRM_L["R_Paladin"] = "Paladin"
    GRM_L["R_Priest"] = "Priest"
    GRM_L["R_Rogue"] = "Rogue"
    GRM_L["R_Shaman"] = "Shaman"
    GRM_L["R_Warlock"] = "Warlock"
    GRM_L["R_Warrior"] = "Warrior"

    -- REPUTATION
    GRM_L["Neutral"] = true
    GRM_L["Friendly"] = true
    GRM_L["Honored"] = true
    GRM_L["Revered"] = true
    GRM_L["Exalted"] = true

    -- Interface default translations
    GRM_L["Guild & Communities"] = true

    GRML.LoadLanguage[1]();
end