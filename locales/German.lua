
-- INSTRUCTIONS FOR LOCALIZATION

-- 1 ) Please avoid the "SYSTEM MESSAGES" as those are necessary for the addon code to properly identify and parse them. those are already complete.
-- 2 ) Any statement that "= true" needs to still be translated. Just remove the 'true' and replace it with the proper translation, in quotations
--     Please include the {name} for where the player names should appear, as well as the few instances {num} needs to be included (referring to number)
-- 3 ) If appropriate, in the context of the sentence, please keep the spacing properly.
-- 4 ) Report any issues to Arkaan on CurseForge or Discord. -- You can also find me Battle.net @  DNADissector#1958   (US)
-- 5 ) THANK YOU SO MUCH FOR ADDING THIS TRANSLATION WORK!!! I will ensure you are mentioned in the release notes and at the top of this header for your contribution

-- Data insert points:
--  {name} and {name2}
--  {num}
--  {custom1} and {custom2}

    -- EXAMPLE NOTATION (English to Spanish)

    -- GRM_L["{name}'s Anniversary!"] = "Aniversario de {name}"

-- WARNING!!!
-- DO NOT UPDATE GRM IF YOU HAVE NOT BACKED UP YOUR TRANSLATION WORK!!! Twitch and other services will overwrite your work without warning when they update!!!
-- WARNING!!!

    ---------------------------------
    -- BEGIN TRANSLATION WORK HERE --
    ---------------------------------

GRML.German = function()

    -- Auto Localized (Only use this on Client languages)
    GRM_L["Friend"] = FRIEND;

    -- SET YOUR OWN CUSTOM SLASH COMMAND FOR GRM
    GRM_L["/XXXX"] = true   -- /grm will always work -- now you can make your own acronym that fits your language. Example: GRM_L["/XXXX"] = "/грм" - Now, if you type /грм it will work in-game
    GRM_L["/YYYY"] = true;  -- /roster              -- This is the custom GRM roster

    GRM_L["German"] = "Deutsch"
    GRM_L["English"] = "Englisch"
    GRM_L["French"] = "Französisch"
    GRM_L["Italian"] = "Italienisch"
    GRM_L["Russian"] = "Russisch"
    GRM_L["SpanishMX"] = "Spanisch (Mexiko)"
    GRM_L["SpanishEU"] = "Spanisch (EU)"
    GRM_L["Portuguese"] = "Portugiesisch"
    GRM_L["PortugueseBR"] = "Portugiesisch (Brasilien)"
    GRM_L["Korean"] = "Koreanisch"
    GRM_L["MandarinCN"] = "Mandarin (China)"
    GRM_L["MandarinTW"] = "Mandarin (Taiwan)"
    GRM_L["Dutch"] = "Holländisch"
    GRM_L["Danish"] = "Dänisch"

    -- PLAYER MAIN ROSTER DETAILS WINDOW
    GRM_L["Level: "] = "Stufe: "
    GRM_L["Level"] = "Stufe"
    GRM_L["Note:"] = "Notiz:"
    GRM_L["Note"] = "Notiz"
    GRM_L["Officer's Note:"] = "Offiziersnotiz:"
    GRM_L["Officer's Note"] = "Offiziersnotiz"
    GRM_L["Zone:"] = "Zone:"
    GRM_L["(main)"] = "Main"
    GRM_L["( Main )"] = "Main"                                -- Context: This one is used on player data window, the other is smaller used in the alts list...
    GRM_L["Set as Main"] = "Als Main setzen"
    GRM_L["Set as Alt"] = "Als Twink setzen"
    GRM_L["Remove"] = "Entfernen"
    GRM_L["Please Type the Name of the alt"] = "Bitte den Namen des Twinks eingeben"
    GRM_L["Promoted:"] = "Befördert:"
    GRM_L["Unknown"] = "unbekannt"                                                                 -- Context: The date of their promotion is "Unknown"
    GRM_L["Click here to set a Public Note"] = "Hier öffentliche Notiz eintragen"
    GRM_L["Unable to Edit Public Note at Rank"] = "Rang ist zu niedrig, um die öffentliche Notiz zu ändern"
    GRM_L["Click here to set an Officer's Note"] = "Hier Offiziersnotiz eintragen"
    GRM_L["Unable to Edit Officer Note at Rank"] = "Rang ist zu niedrig, um die öffentliche Notiz zu ändern"
    GRM_L["Unable to View Officer Note at Rank"] = "Rang ist zu niedrig, um die öffentliche Notiz zu sehen"
    GRM_L["Online"] = "online"
    GRM_L["( Active )"] = "aktiv"                       -- I included the parentheses here as I am not sure if any languages abstain from them, or use other notation. Feel free to remove if necessary
    GRM_L["( AFK )"] = "AFK"
    GRM_L["( Busy )"] = "DND"
    GRM_L["( Mobile )"] = "Handy"
    GRM_L["( Offline )"] = "offline"
    GRM_L["Set Join Date"] = "Beitrittsdatum\nsetzen"
    GRM_L["Edit Promo Date"] = "Beförderungsdatum\nändern"
    GRM_L["Edit Join Date"] = "Beitrittsdatum\nändern"
    GRM_L["Set Promo Date"] = "Beförderungsdatum\nsetzen"
    GRM_L["Group Invite"] = "Gruppeneinladung"
    GRM_L["Date Promoted?"] = "Beförderungsdatum?"
    GRM_L["Last Online"] = "zuletzt online"
    GRM_L["Time In:"] = "Zeit in Zone:"                            -- Context: "Time In" the current zone...
    GRM_L["Date Joined"] = "Beigetreten"
    GRM_L["Join Date?"] = "Beigetreten?"
    GRM_L["Player Was Previously Banned!"] = "Spieler war gebannt!"
    GRM_L["Ignore Ban"] = "Bann ignorieren"
    GRM_L["Player Alts"] = "Twinks"
    GRM_L["Add Alt"] = "Twink hinzufügen"
    GRM_L["Choose Alt"] = "Twink auswählen"
    GRM_L["Guild Log"] = "Guild Log"
    GRM_L["Guild"] = "Gilde"

    -- TOOLTIPS
    GRM_L["Rank History"] = "Rang-Verlauf"
    GRM_L["Time at Rank:"] = "Zeit auf Rang"
    GRM_L["Right-Click to Edit"] = "Rechtsklick zum Ändern"
    GRM_L["Left Guild"] = "hat die Gilde verlassen"
    GRM_L["Membership History"] = "Mitgliedschafts-Verlauf"
    GRM_L["Joined:"] = "Beigetreten"                             -- as in "Joined" the guild
    GRM_L["Joined"] = "Beigetreten"
    GRM_L["Left:"] = "verlassen"                               -- as in, "Left" the guild
    GRM_L["Rejoined:"] = "Wiedereintritt:"                           -- as in, "Rejoined" the guild
    GRM_L["Rejoined"] = "Wiedereintritt"
    GRM_L["Reset Data!"] = "Daten verwerfen!"
    GRM_L["Notify When Player is Active"] = "Benachrichtigen, wenn Spieler nicht mehr AFK ist"
    GRM_L["Notify When Player Goes Offline"] = "Benachrichtigen, wenn Spieler sich ausloggt"
    GRM_L["Notify When Player Comes Online"] = "Benachrichtigen, wenn Spieler sich einloggt"
    GRM_L["Edit Date"] = "Datum ändern"
    GRM_L["Clear History"] = "Verlauf löschen"
    GRM_L["Options"] = "Optionen"

    -- LOG
    GRM_L["LOG"] = "LOG"                                                     -- Context - The guild Log shorthand for the tab
    GRM_L["Guild Roster Event Log"] = "Guild Roster Event Verlauf"
    GRM_L["Clear Log"] = "Verlauf löschen"
    GRM_L["{name} KICKED {name2} from the Guild!"] = "{name} hat {name2} aus der Gilde geworfen!"
    GRM_L["kicked"] = "geworfen"
    GRM_L["{name} has Left the guild"] = "{name} hat die Gilde verlassen"
    GRM_L["{name} has BANNED {name2} and all linked alts from the guild!"] = "{name} hat {name2} und alle verbundenen Twinks aus der Gilde VERBANNT!"
    GRM_L["{name} has BANNED {name2} from the guild!"] = "{name} hat {name2} aus der Gilde VERBANNT!"
    GRM_L["Reason Banned:"] = "Bann-Grund:"
    GRM_L["has Left the guild"] = "hat die Gilde verlassen"                                      -- Context: PlayerName "has left the guild"
    GRM_L["ALTS IN GUILD:"] = "Twinks in der Gilde:"                                          -- Context: This appears If a person leaves the guild and there are still alts in the guild. It is like - "ALTS IN GUILD: Arkaan, Chris, Matt, and 4 others.""
    GRM_L["Player no longer on Server"] = "Spieler ist nicht mehr auf dem Server"
    GRM_L["{name} PROMOTED {name2} from {custom1} to {custom2}"] = "{name} hat {name2} von {custom1} zu {custom2} BEFÖRDERT"
    GRM_L["{name} has been PROMOTED from {custom1} to {custom2}"] = "{name} wurde von {custom1} zu {custom2} BEFÖRDERT"
    GRM_L["{name} DEMOTED {name2} from {custom1} to {custom2}"] = "{name} hat {name2} von {custom1} zu {custom2} DEGRADIERT"
    GRM_L["{name} has been DEMOTED from {custom1} to {custom2}"] = "{name} wurde von {custom1} zu {custom2} DEGRADIERT"
    GRM_L["(+ {num} More)"] = "(+ {num} mehr)"                                          -- Context: Referencing num of alts if player leaves guild, that are stil in it. Example "ALTS IN GUILD: Christ, Matt, Sarah (and 4 more)"
    GRM_L["{name} has Been in the Guild {num} Times Before"] = "{name} war bereits {num} mal in der Gilde"
    GRM_L["{name} is Returning for the First Time."] = "{name} kehrt zum ersten Mal zurück in die Gilde"
    GRM_L["None Given"] = "Kein Grund angegeben"                                              -- Context: No reason given for player ban. This is displayed when a player was banned, but the addon users did not input a reason why.
    GRM_L["WARNING!"] = "ACHTUNG!"                                                -- Context: WARNING - banned player rejoined the guild!
    GRM_L["{name} REJOINED the guild but was previously BANNED!"] = "{name} ist zurück in der Gilde, wurde aber vorher GEBANNT!"
    GRM_L["(Invited by: {name})"] = "(eingeladen von: {name})"
    GRM_L["Invited By: {name}"] = "eingeladen von: {name}"
    GRM_L["Date of Ban:"] = "Bann-Datum"
    GRM_L["Date Originally Joined:"] = "Datum des ersten Beitritts:"
    GRM_L["Old Guild Rank:"] = "Alter Gildenrang:"
    GRM_L["Additional Notes:"] = "zusätzliche Notizen:"
    GRM_L["{name} has REINVITED {name2} to the guild"] = "{name} hat {name2} WIEDER in die Gilde EINGELADEN"
    GRM_L["(LVL: {num})"] = "(Lvl: {num})"                                            -- Context: LVL means Player Level - so Ex: (LVL: 110)
    GRM_L["{name} has REJOINED the guild"] = "{name} ist der Gilde erneut beigetreten"
    GRM_L["{name} has JOINED the guild!"] = "{name} ist der Gilde BEIGETRETEN"
    GRM_L["Date Left:"] = "Austrittsdatum:"
    GRM_L["{name} has Leveled to {num}"] = "{name} hat Level {num} erreicht"
    GRM_L["(+{num} levels)"] = "(+{num} Level)"                                         -- Context: Person gained more than one level, hence the plural
    GRM_L["(+{num} level)"] = "(+{num} Level)"                                          -- Context: Person gains a level, just one level.
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Added"] = "Öffentliche Notiz von {name}: \"{custom1}\" hinzugefügt"           -- Of note, the \" in the text here will just appear as " in-game. The \" notation is telling the program not to end the string, but to include quotation
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Removed"] = "Öffentliche Notiz von {name}: \"{custom1}\" wurde gelöscht"
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" to \"{custom2}\""] = "Öffentliche Notiz von {name}: \"{custom1}\" geändert zu \"{custom2}\""    -- Context: "Arkaan's PUBLIC Note: "ilvl 920" to "Beast Mode ilvl 960""  -- Changing of the note. custom1 = old note, custom2 = new note
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Added"] = "Offiziersotiz von {name}: \"{custom1}\" hinzugefügt"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Removed"] = "Offiziersnotiz von {name}: \"{custom1}\" wurde gelöscht"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" to \"{custom2}\""] = "Offiziersnotiz von {name}: \"{custom1}\" geändert zu \"{custom2}\""
    GRM_L["Guild Rank Renamed from {custom1} to {custom2}"] = "Gildenrang {custom1} wurde umbenannt zu {custom2}"
    GRM_L["{name} has Name-Changed to {name2}"] = "Spieler {name} hat seinen Namen zu {name2} geändert"
    GRM_L["{name} has Come ONLINE after being INACTIVE for {num}"] = "Spieler {name} kam ONLINE, nachdem er für {num} INAKTIV war"
    GRM_L["{name} has been OFFLINE for {num}. Kick Recommended!"] = "{name} war für {num} OFFLINE. Kick empfohlen!"
    GRM_L["({num} ago)"] = "vor {num}"                                             -- Context: (5 minutes ago) or (5 months 24 days ago) -- the {num} will automatically include the time-passed date.
    GRM_L["{name}'s Guild has Name-Changed to \"{name2}\""] = "Der Gildenname {name} wurde in \"{name2}\" geändert."
    GRM_L["Promotions"] = "Beförderungen"
    GRM_L["Demotions"] = "Degradierungen"

    -- EVENTS WINDOW
    GRM_L["EVENTS"] = "EREIGNISSE"                                          -- Events tab
    GRM_L["{name}'s Anniversary!"] = "{name} hat Jahrestag!"
    GRM_L["{name}'s Birthday!"] = "{name} hat Geburtstag!"
    GRM_L["Event Calendar Manager"] = "Ereignismanager"
    GRM_L["Event:"] = "Ereignis:"
    GRM_L["Description:"] = "Beschreibung:"
    GRM_L["Add to\nCalendar"] = "Zum\nKalender\nhinzufügen"
    GRM_L["Ignore Event"] = "Ignoriere Ereignis"
    GRM_L["No Player Event Has Been Selected"] = "Kein Ereignis ausgewählt"
    GRM_L["Event Added to Calendar: {custom1}"] = "Ereignis zum Kalender hinzugefügt: {custom1}"              -- Custom1 = the title of the event, like "Arkaan's Anniversary"
    GRM_L["Please Select Event to Add to Calendar"] = "Wähle ein Ereignis aus, um einen Kalendereintrag zu erstellen"
    GRM_L["No Calendar Events to Add"] = "Keine Ereignisse zu erstellen"
    GRM_L["{name}'s event has already been added to the calendar!"] = "Ereignis von {name} wurde bereits zum Kalender hinzugefügt!"
    GRM_L["Please wait {num} more seconds to Add Event to the Calendar!"] = "Bitte warte {num} Sekunden, bis du das Ereignis im Kalender erstellst!"
    GRM_L["{name}'s Event Removed From the Queue!"] = "Ereignis von {name} aus der Liste entfernt!"
    GRM_L["Full Description:"] = "Beschreibung:"

    -- BAN WINDOW
    GRM_L["BAN LIST"] = "BANNLISTE"                                        -- Ban List Tab
    GRM_L["Reason Banned?"] = "Grund?"
    GRM_L["Click \"YES\" When Done"] = "Klicke \"JA\", wenn fertig"                         -- Of note, the \" is how you notate for quotations to actually appear. Adjust as needed
    GRM_L["Select a Player"] = "Wähle einen Charakter aus"
    GRM_L["Player Selected"] = "Ausgewählt:"
    GRM_L["{name}(Still in Guild)"] = "{name} (in der Gilde)"
    GRM_L["(Still in Guild)"] = "(in der Gilde)"
    GRM_L["No Ban Reason Given"] = "Kein Grund angegeben"
    GRM_L["Total Banned:"] = "Gebannte Charaktere:"
    GRM_L["Rank"] = "Rang"
    GRM_L["Ban Date"] = "Datum"
    GRM_L["No Players Have Been Banned from Your Guild"] = "Keine Charakter wurden aus der Gilde verbannt"
    GRM_L["Remove Ban"] = "Bann aufheben"
    GRM_L["Add Player to Ban List"] = "Charakter zur Bannliste hinzufügen"
    GRM_L["Server:"] = "Server:"
    GRM_L["Class:"] = "Klasse:"
    GRM_L["Reason:"] = "Grund:"
    GRM_L["It is |CFFFF0000CRITICAL|r the player's name and server are spelled correctly for accurate tracking and notifications."] = "|CFFFF0000WICHTIG:|r Charaktername und Server müssen unbedingt korrekt geschrieben sein!"
    GRM_L["Submit Ban"] = "Bannen"
    GRM_L["Confirm"] = "Bestätigen"
    GRM_L["Cancel"] = "Abbrechen"
    GRM_L["Add"] = "Hinzufügen"                                         -- Context: "Add" player to ban list
    GRM_L["Confirm Ban for the Following Player?"] = "Möchtest du diesen Charakter wirklich bannen?"
    GRM_L["Please Enter a Valid Player Name"] = "Gültigen Charakternamen eingeben."            -- Player Name
    GRM_L["Please Enter a Valid Server Name"] = "Gültigen Servernamen eingeben."            -- Server Name
    GRM_L["Please Select a Player to Unban!"] = "Bitte wähle einen Charakter aus."
    GRM_L["{name} - Ban List"] = "{name} - Bannliste"                           -- Context: "GuildName - Ban List"
    GRM_L["No Reason Given"] = "Kein Grund angegeben"

    -- ADDON USERS WINDOW
    GRM_L["SYNC USERS"] = "SYNC"
    GRM_L["Ok!"] = "Sync OK"
    GRM_L["Their Rank too Low"] = "Gildenrang des Spielers ist zu niedrig"
    GRM_L["Your Rank too Low"] = "Teilt Änderungen nur mit höheren Rängen"
    GRM_L["Outdated Version"] = "Veraltete Version"
    GRM_L["You Need Updated Version"] = "Du musst GRM aktualisieren"
    GRM_L["Player Sync Disabled"] = "Spieler-Sync deaktiviert"
    GRM_L["No Guildie Online With Addon."] = "Keine Spieler mit Addon online"
    GRM_L["ONE Person is Online. Recommend It!"] = "EIN Spieler ist online. Empfiehl ihm GRM!"
    GRM_L["{num} others are Online! Recommend It!"] = "{num} andere Spieler sind online! Empfiehl ihnen GRM!"
    GRM_L["GRM Sync Info"] = "GRM Sync Info"
    GRM_L["Ver: {custom1}"] = "Version: {custom1}"                                 -- Context:  Ver: R1.125  - Ver is short for Version
    GRM_L["Name:"] = "Name"
    GRM_L["Version"] = "Version"
    GRM_L["Sync"] = "Sync"
    GRM_L["Your Sync is Currently Disabled"] = "Die Sync mit anderen Spielern ist momentan deaktiviert"

    -- OPTIONS WINDOW
    GRM_L["Public Note"] = "Öffentliche Notiz"
    GRM_L["Scanning Roster:"] = "Scan:"
    GRM_L["Guild Rank Restricted:"] = "Durch Gildenrang beschränkte Einstellungen:"
    GRM_L["Sync:"] = "Sync:"
    -- Options window -- of note, these are very concise statements. They may need to be adjusted properly in the Options window for proper spacing, so verify they look ok after translating.
    GRM_L["Slash Commands"] = "Slash-Befehle"
    GRM_L["Trigger scan for changes manually"] = "Starte manuellen Scan nach Änderungen"
    GRM_L["Trigger sync one time manually"] = "Starte einmalige manuelle Sync"
    GRM_L["Centers all Windows"] = "Alle Fenster zentrieren"
    GRM_L["Slash command info"] = "Slash-Befehle im Chatfenster ausgeben"
    GRM_L["Resets ALL data"] = "ALLE Daten verwerfen"
    GRM_L["Report addon ver"] = "Ausgabe der installierten Version"                                    -- Ver is short for Version
    GRM_L["Resets Guild data"] = "Gildendaten verwerfen"
    GRM_L["Show at Logon"] = "Zeige Fenster als Pop-up beim Login"
    GRM_L["Only Show if Log Changes"] = "Nur bei Änderungen anzeigen"

    GRM_L["Before Scan Timer"] = "Alle"               -- Context: "Scan for Changes Every 10 Seconds" -- There will be a number added here and may require custom positioning, so please provide full statement and Arkaan will allign
    GRM_L["After Scan Timer"] = "Sekunden nach Änderungen scannen"

    GRM_L["Before Inactive Timer"] = "Melde Rückkehr nach"
    GRM_L["After Inactive Timer"] = "Tagen Inaktivität."

    GRM_L["Reactivating SCAN for Guild Member Changes..."] = "Scan nach Änderungen |cff00FF00aktiviert|r"
    GRM_L["Deactivating SCAN of Guild Member Changes..."] = "Scan nach Änderungen |cffFF0000deaktiviert|r"
    GRM_L["Please choose a scan interval {num} seconds or higher!"] = "Bitte ein Scanintervall von mindestens {num} Sekunden wählen"
    GRM_L["{num} is too Low!"] = "{num} ist zu klein!"
    GRM_L["The Current Lvl Cap is {num}."] = "Das aktuelle Maximallevel ist {num}"
    GRM_L["Kick Inactive Player Reminder at"] = "Erinnerung zum Kicken inaktiver Spieler ab"        -- Context: "Kick Inactive Player Reminder at X Months" - Again, allignment will need to be adjusted for options UI, so please post
    GRM_L["Please choose a month between 1 and 999"] = "Bitte eine Zahl zwischen 1 und 999 auswählen!"
    GRM_L["Please choose a month between 0 and 999"] = "Bitte eine Zahl zwischen 0 und 999 auswählen!"
    GRM_L["Sync BAN List With Guildies at Rank"] = "Bannliste teilen mit"     -- Context: "Sync Ban List with Guildies at Rank [DROPDOWNMENU OF RANKS] or Higher" - Please show where dropdown menu should be pinned
    GRM_L["or Higher"] = "oder höher"                               -- Context: Look at the above statement. Show where this needs to go in regards to dropdown menu of rank selection in Options
    GRM_L["Restore Defaults"] = "Auf Standard\nzurücksetzen"
    GRM_L["Please choose between 1 and 180 days!"] = "Bitte eine Zahl zwischen 1 und 180 auswählen!"
    GRM_L["Announce Events"] = "Ereignisse"                         -- Context: "Announce Events X number of days in advance" -- the X is the editbox to modify number of days. Please include the location of where to pin that.
    GRM_L["Days in Advance"] = "Tage vorher ankündigen"
    GRM_L["Add Events to Calendar"] = "Ereignisse zum Kalender hinzufügen"
    GRM_L["SYNC Changes With Guildies at Rank"] = "Änderungen teilen mit"      -- Context: at Rank [DROPDOWNRANKSELECTION] or Higher. - Please note where to place dropdown box in the position of the sentence.
    GRM_L["Reactivating Data SYNC with Guildies..."] = "Synchronisation der Änderungen |cff00FF00aktiviert|r"
    GRM_L["Deactivating Data SYNC with Guildies..."] = "Synchronisation der Änderungen |cffFF0000deaktiviert|r"
    GRM_L["Display Sync Update Messages"] = "Updatemeldungen für GRM anzeigen"
    GRM_L["Only Sync With Up-to-Date Addon Users"] = "Nur mit Mitgliedern synchronisieren, die die aktuelle Version von GRM installiert haben"

    GRM_L["Leveled"] = "Leveländerungen"
    GRM_L["Inactive Return"] = "Wieder aktiv"
    GRM_L["resetall"] = "resetall"
    GRM_L["resetguild"] = "resetguild"
    --Side chat/log controls - Of note, limited spacing
    GRM_L["Name Change"] = "Namensänderungen"
    GRM_L["Rank Renamed"] = "Rang umbenannt"
    GRM_L["Event Announce"] = "Ereignisse"
    GRM_L["Left"] = "Austritte"                        -- Context: As in, "Left" the guild...
    GRM_L["Recommendations"] = "Erinnerungen"
    GRM_L["Banned"] = "Banne"
    GRM_L["To Chat:"] = "Im Chat"                    -- Context: "To Chat Message frame -- in regards to announcing events like when a player leveled"
    GRM_L["To Log:"] = "Im Log"                     -- Context: To show it in the guild log.
    GRM_L["Display Changes"] = "Änderungen anzeigen"

    -- AUDIT WINDOW
    GRM_L["AUDIT"] = "PRÜFUNG"                                               -- Audit Tab name
    GRM_L["No Date Set"] = "Kein Datum"
    GRM_L["Main"] = "Main"
    GRM_L["Main or Alt?"] = "Main oder Twink?"
    GRM_L["Alt"] = "Twink"
    GRM_L["Total Incomplete: {num} / {custom1}"] = "Unvollständig {num} von {custom1}"                 -- Context: Total incomplete: 50 / 100    (50 out of 100)
    GRM_L["Mains:\n{num}"] = "Mains:\n{num}"                                                                  -- Context: Number of "main" toons
    GRM_L["Unique Accounts:\n{num}"] = "Accounts:\n{num}"
    GRM_L["All Complete"] = "Alles komplett"                                                                -- Context: All dates have been added and are known, thus it states it is "All Complete"
    GRM_L["Set Incomplete to Unknown"] = "Ändere \"kein Datum\" zu \"unbekannt\""                           -- Context: Implied to set ALL incomplete to unknown
    GRM_L["Clear All Unknown"] = "Ändere \"unbekannt\" zu \"kein Datum\""
    GRM_L["Please Wait {num} more Seconds"] = "Bitte warte {num} Sekunden"
    GRM_L["Guild Data Audit"] = "Überprüfung der Gildendaten"
    GRM_L["Name"] = "Name"
    GRM_L["Join Date"] = "Beitritt"
    GRM_L["Promo Date"] = "Beförderung"
    GRM_L["Main/Alt"] = "Main/Twink"
    GRM_L["Only Show Incomplete Guildies"] = "Nur unvollständige Einträge anzeigen"

    -- ADDON SYSTEM MESSAGES
    GRM_L["Guild Roster Manager"] = "Guild Roster Manager"
    GRM_L["GRM:"] = "GRM:"                                                                -- Abbreviation for "Guild Roster Manager"
    GRM_L["(Ver:"] = "Version:"                                                               -- Ver: is short for Version:
    GRM_L["GRM Updated:"] = "GRM aktualisiert:"
    GRM_L["Configuring Guild Roster Manager for {name} for the first time."] = "Erstmalige Konfiguration von Guild Roster Manager für {name}"
    GRM_L["Notification Set:"] = "Benachrichtigung eingestellt:"
    GRM_L["Report When {name} is ACTIVE Again!"] = "Meldung, wenn {name} nicht mehr AFK ist!"
    GRM_L["Report When {name} Comes Online!"] = "Meldung, wenn {name} online kommt!"
    GRM_L["Report When {name} Goes Offline!"] = "Meldung, wenn {name} offline geht!"
    GRM_L["A new version of Guild Roster Manager is Available!"] = "Eine neue Version von Guild Roster Manager ist verfügbar!"
    GRM_L["Please Upgrade!"] = "Bitte aktualisieren!"
    GRM_L["Player Does Not Have a Time Machine!"] = "Spieler hat keine Zeitmaschine!"
    GRM_L["Please choose a valid DAY"] = "Bitte einen gültigen Tag wählen"
    GRM_L["{name} has been Removed from the Ban List."] = "{name} wurde von der Bannliste entfernt."
    GRM_L["Scanning for Guild Changes Now. One Moment..."] = "Scanne nach Änderungen. Bitte warten..."
    GRM_L["Initializing Sync Action. One Moment..."] = "Starte Synchronisation. Bitte warten..."
    GRM_L["No Players Currently Online to Sync With..."] = "Es sind keine Spieler online, mit denen du Änderungen synchronisieren kannst."
    GRM_L["SYNC is currently not possible! Unable to Sync with guildies when guild chat is restricted."] = "Synchronisation nicht möglich, wenn der Gildenchat eingeschränkt ist."
    GRM_L["Manual Scan Complete"] = "Manueller Scan nach Änderungen abgeschlossen"
    GRM_L["Analyzing guild for the first time..."] = "Erstmalige Analyse der Gilde..."
    GRM_L["Building Profiles on ALL \"{name}\" members"] = "Erstelle Profile für alle Mitglieder von \"{name}\""                 -- {name} will be the Guild Name, for context
    GRM_L["NOTIFICATION:"] = "BENACHRICHTIGUNG:"                                               -- Context:  "Notification: Player is no longer AFK"
    GRM_L["{name} is now ONLINE!"] = "{name} ist jetzt |cff00FF00online|r!"
    GRM_L["{name} is now OFFLINE!"] = "{name} ist jetzt |cffFF0000offline|r!"
    GRM_L["{name} is No Longer AFK or Busy!"] = "{name} ist nicht mehr |cffFFFF00AFK|r!"
    GRM_L["{name} is No Longer AFK or Busy, but they Went OFFLINE!"] = "{name} ist nun |cffFF0000online|r und nicht mehr |cffFFFF00AFK|r!"
    GRM_L["{name}'s saved data has been wiped!"] = "Die gespeicherten Daten von {name} wurden gelöscht!"

    GRM_L["Wiping all Saved Roster Data Account Wide! Rebuilding from Scratch..."] = "Alle gespeicherten Daten werden gelöscht! Kompletter Neuaufbau wird durchgeführt..."
    GRM_L["Wiping all saved Guild data! Rebuilding from scratch..."] = "Alle gespeicherten Gildendaten werden gelöscht! Kompletter Neuaufbau wird durchgeführt..."
    GRM_L["There are No Log Entries to Delete, silly {name}!"] = "Es sind keine Log-Einträge zum Löschen vorhanden!"
    GRM_L["Guild Log has been RESET!"] = "Gildenlog wurde gelöscht!"
    GRM_L["{name} is now set as \"main\""] = "{name} ist nun als \"Main\" gesetzt"
    GRM_L["{name} is no longer set as \"main\""] = "{name} ist nicht mehr als \"Main\" gesetzt"
    GRM_L["Reset All of {name}'s Data?"] = "Möchtest du alle Daten von {name} löschen?"

    -- /grm help
    GRM_L["Opens Guild Log Window"] = "Öffnet das Guild Roster Manager-Fenster"
    GRM_L["Resets ALL saved data"] = "Löscht alle gespeicherten Daten"
    GRM_L["Resets saved data only for current guild"] = "Löscht alle Daten der aktuellen Gilde"
    GRM_L["Re-centers the Log window"] = "Zentriert alle Fenster"
    GRM_L["Triggers manual re-sync if sync is enabled"] = "Startet eine manuelle Synchronisation"
    GRM_L["Does a one-time manual scan for changes"] = "Startet einen einmaligen Scan nach Änderungen"
    GRM_L["Displays current Addon version"] = "Zeigt die installierte Version des Addons an"
    GRM_L["WARNING! Complete hard wipe, including settings, as if addon was just installed."] = "WARNUNG! Löscht alle Daten und Einstellungen und setzt das Addon in den Werkszustand zurück.";

    -- General Misc UI
    GRM_L["Really Clear All Account-Wide Saved Data?"] = "Möchtest du wirklich alle accountweit gespeicherten Daten löschen?"
    GRM_L["Really Clear All Guild Saved Data?"] = "Möchtest du wirklich alle Gildendaten löschen?"
    GRM_L["Yes!"] = "Ja!"
    GRM_L["Ban Player?"] = "Spieler bannen?"
    GRM_L["Ban the Player's {num} alts too?"] = "Auch die {num} dazugehörigen Twinks bannen?"      -- Plural number of alts
    GRM_L["Ban the Player's {num} alt too?"] = "Auch den dazugehörigen Twink bannen?"     -- Singular number of alts, just 1
    GRM_L["Please Click \"Yes\" to Ban the Player!"] = "Bitte drücke \"Ja\" um den Charakter zu bannen!"

    -- Sync Messages
    GRM_L["{name} updated {name2}'s Join Date."] = "{name} hat das Beitrittsdatum von {name2} aktualisiert"
    GRM_L["{name} updated {name2}'s Promotion Date."] = "{name} hat das Beförderungsdatum von {name2} aktualisiert"
    GRM_L["\"{custom1}\" event added to the calendar by {name}"] = "\"{custom1}\" Ereignis wurde von {name} im Kalender erstellt."
    GRM_L["{name} updated {name2}'s list of Alts."] = "{name} hat die Twinks von {name} aktualisiert"
    GRM_L["{name} removed {name2} from {custom1}'s list of Alts."] = "{name} hat {name2} von der Liste der Twinks von {custom1} entfernt."
    GRM_L["{name} set {name2} to be 'Main'"] = "{name} hat {name2} als Main gesetzt."
    GRM_L["{name} has changed {name2} to be listed as an 'alt'"] = "{name} hat {name2} als Twink gesetzt."
    GRM_L["{name} has Removed {name2} from the Ban List."] = "{name} hat {name2} von der Bannliste entfernt."
    GRM_L["{name} has been BANNED from the guild!"] = "{name} wurde aus der Gilde |cffFF0000verbannt|r!"
    GRM_L["{name} has been UN-BANNED from the guild!"] = "{name} ist nicht mehr länger aus der Gilde verbannt!"
    GRM_L["Initiating Sync with {name} Instead!"] = "Starte stattdessen Synchronisation mit {name}!"
    GRM_L["Sync Failed with {name}..."] = "Synchronisation mit {name} gescheitert..."
    GRM_L["The Player Appears to Be Offline."] = "Der Spieler scheint offline zu sein."
    GRM_L["Syncing Data With Guildies Now..."] = "Synchronisiere jetzt mit Mitgliedern..."
    GRM_L["(Loading screens may cause sync to fail)"] = "(Ladebildschirme können die Sync abbrechen)"
    GRM_L["Sync With Guildies Complete..."] = "Synchronisation abgeschlossen!"

    -- ERROR MESSAGES
    GRM_L["Notification Has Already Been Arranged..."] = "Benachrichtigung wurde bereits eingestellt..."
    GRM_L["Player Cannot Add Themselves as an Alt"] = "Spieler können sich nicht selbst als Twinks hinzufügen"
    GRM_L["Player Not Found"] = "Spieler nicht gefunden"
    GRM_L["Please try again momentarily... Updating the Guild Event Log as we speak!"] = "Bitte versuch es in einem Moment noch einmal. Aktualisiere gerade."
    GRM_L["Invalid Command: Please type '/grm help' for More Info!"] = "Ungültiger Befehl. Bitte gib '/grm help' für mehr Infos ein."
    GRM_L["{name} is not currently in a guild. Unable to Proceed!"] = "{name} ist momentan in einer Gilde. Kann nicht fortfahren!"
    GRM_L["Addon does not currently support more than 75 alts!"] = "Addon unterstützt momentan nicht mehr, als 75 Twinks. (o.O!)"
    GRM_L["Please choose a VALID character to set as an Alt"] = "Bitte einen gültigen Spieler auswählen"
    GRM_L["Please choose a character to set as alt."] = "Bitte einen Spieler auswählen, um ihn als Twink einzutragen."
    GRM_L["GRM ERROR:"] = "GRM FEHLER:"
    GRM_L["Com Message too large for server"] = "Nachricht ist zu lang für den Server"                    -- Context: "Com message" is short-hand for "Communications message" - this is a technical error on syncing data.
    GRM_L["Prefix:"] = "Präfix:"
    GRM_L["Msg:"] = "Nachricht:"                                                -- Context: Msg is short for Message
    GRM_L["Unable to register prefix > 16 characters: {name}"] = "Kann Präfix nicht registrieren, maximal 16 Buchstaben: {name}"   -- Context: The {name} is the string code for the prefix. This is for debugging.

    --SLASH COMMANDS
    -- These are generally written in general shorthand. The original commands will ALWAYS work, but if there is one that makes more sense in your language, please feel free to modify
    GRM_L["clearall"] = "clearall"                         -- Context: In regards, "Clear All" saved data account wide
    GRM_L["clearguild"] = "clearguild"                     -- Context: In regards, "Clear All" saved data from ONLY the current guild.
    GRM_L["hardreset"] = "hardreset"                       -- Context: In regards, "Hard Reset" ALL data account wide, including wiping player settings
    GRM_L["help"] = "hilfe"                                -- Context: "help" with info on the how to use addon
    GRM_L["version"] = "version"                           -- Context: "version" of the addon
    GRM_L["center"] = "zentrieren"                         -- Context: "center" the movable addon window back to center of screen
    GRM_L["sync"] = "sync"                                 -- Context: "sync" the data between players one time now.
    GRM_L["scan"] = "scan"                                 -- Context: "scan" for guild roster changes one time now.

    -- CLASSES
    GRM_L["Deathknight"] = "Todesritter"
    GRM_L["Demonhunter"] = "Dämonenjäger"
    GRM_L["Druid"] = "Druide"
    GRM_L["Hunter"] = "Jäger"
    GRM_L["Mage"] = "Magier"
    GRM_L["Monk"] = "Mönch"
    GRM_L["Paladin"] = "Paladin"
    GRM_L["Priest"] = "Priester"
    GRM_L["Rogue"] = "Schurke"
    GRM_L["Shaman"] = "Schamane"
    GRM_L["Warlock"] = "Hexenmeister"
    GRM_L["Warrior"] = "Krieger"

-- TIME AND DATES
    GRM_L["1 Mar"] = "1. März"                           -- This date is used in a specific circumstance. If someone's anniversary/bday landed on a leap year (Feb 29th), it defaults to the 1st of March on non-leap year
    -- Full Month Name
    GRM_L["January"] = "Januar"
    GRM_L["February"] = "Februar"
    GRM_L["March"] = "März"
    GRM_L["April"] = "April"
    GRM_L["May"] = "Mai"
    GRM_L["June"] = "Juni"
    GRM_L["July"] = "Juli"
    GRM_L["August"] = "August"
    GRM_L["September"] = "September"
    GRM_L["October"] = "Oktober"
    GRM_L["November"] = "November"
    GRM_L["December"] = "Dezember"
    -- Shorthand Month
    GRM_L["Jan"] = "Jan"
    GRM_L["Feb"] = "Feb"
    GRM_L["Mar"] = "Mär"
    GRM_L["Apr"] = "Apr"
    -- Removed May here as the short name is equal to the long name
    GRM_L["Jun"] = "Jun"
    GRM_L["Jul"] = "Jul"
    GRM_L["Aug"] = "Aug"
    GRM_L["Sep"] = "Sep"
    GRM_L["Oct"] = "Okt"
    GRM_L["Nov"] = "Nov"
    GRM_L["Dec"] = "Dez"
    -- Time Notifcation
    GRM_L["Seconds"] = "Sekunden"
    GRM_L["Second"] = "Sekunde"
    GRM_L["Minutes"] = "Minuten"
    GRM_L["Minute"] = "Minute"
    GRM_L["Hours"] = "Stunden"
    GRM_L["Hour"] = "Stunde"
    GRM_L["Days"] = "Tage"
    GRM_L["Day"] = "Tag"
    GRM_L["Months"] = "Monate"
    GRM_L["Month"] = "Monat"
    GRM_L["HourBreak"] = ":"

    GRM_L["am"] = "am"
    GRM_L["pm"] = "pm"
    GRM_L["24HR_Notation"] = ""

    GRM_L["{num} year"] = "{num} Jahr"
    GRM_L["{num} years"] = "{num} Jahre"
    GRM_L["{num} month"] = "{num} Monat"
    GRM_L["{num} months"] = "{num} Monate"
    GRM_L["{num} day"] = "{num} Tag"
    GRM_L["{num} days"] = "{num} Tage"
    GRM_L["< 1 day"] = "< 1 Tag"

    GRM_L["{num} yr"] = "{num} J"
    GRM_L["{num} yrs"] = "{num} J"
    GRM_L["{num} mo"] = "{num} M"
    GRM_L["{num} mos"] = "{num} M"
    GRM_L["{num} hr"] = "{num} Std"
    GRM_L["{num} hrs"] = "{num} Std"
    GRM_L["< 1 hour"] = "< 1 Stunde"
    GRM_L["{num} {custom1}"] = true                 -- Context: This is a placeholder for ANY generic time data -- Ex:  "1 year" or "15 months" - - The translation is already set, this is just to set the orientation of the number properly.

    -- MISC Punctuation
    GRM_L[","] = ","                               -- I know in some Asia languages, a comma is not used, but something similar, for example.

    -- Updates 1.126
    GRM_L["General"] = "Allgemein"
    GRM_L["General:"] = "Allgemein:"
    GRM_L["Scan"] = "Scan"
    GRM_L["Help"] = "Hilfe"
    GRM_L["UI"] = "Interface"                              -- UI for User Interface. Abbreviation for changing custom UI featuers, like coloring of <M> main
    GRM_L["Officer"] = "Offizier"                        -- as in, "Officer" rank
    GRM_L["Open Addon Window"] = "Öffne Addon-Fenster"
    GRM_L["Sync Addon Settings on All Alts in Same Guild"] = "Addon-Einstellungen für alle Twinks in der gleichen Gilde übernehmen"
    GRM_L["Show Minimap Button"] = "Zeige Minimap-Knopf"
    GRM_L["Player is Not Currently in a Guild"] = "Spieler ist momentan in keiner Gilde"
    -- tooltips
    GRM_L["|CFFE6CC7FClick|r to open GRM"] = "|CFFE6CC7FKlicken|r, um GRM zu öffnen"                           -- Please maintain the color coding
    GRM_L["|CFFE6CC7FRight-Click|r to Reset to 100%"] = "|CFFE6CC7FRechtsklicken|r, um auf 100% zurückzusetzen"                -- for the Options slider tooltip
    GRM_L["|CFFE6CC7FRight-Click|r to Set Notification of Status Change"] = "|CFFE6CC7FRechtsklicken|r, um eine Benachrichtigung zu erhalten, wenn der Status sich ändert"
    -- tooltip end
    GRM_L["GRM"] = "GRM"
    GRM_L["Include Unknown as Incomplete"] = "Unbekannt als unvollständig anzeigen"                           -- Context: Unknown in the Audit Tab will be hidden if filtering out complete players
    GRM_L["You Do Not Have Permission to Add Events to Calendar"] = "Du hast keine Rechte, um Ereignisse im Kalender zu erstellen"
    GRM_L["Please Select Which Join Date to Sync"] = "Bitte Beitrittsdatum zum teilen auswählen"
    GRM_L["Sync All Alts to {name}'s Join Date"] = "Allen Twinks das Beitrittsdatum von {name} übertragen"
    GRM_L["Sync All Alts to the Earliest Join Date: {name}"] = "Allen Twinks das früheste Beitrittsdatum übertragen: {name}"
    GRM_L["Sync All Alts to {name}'s |cffff0000(main)|r Join Date"] = "Allen Twinks das Beitrittsdatum übertragen: {name}|cffff0000(Main)"   -- The coloring ensures that "(main)" maintains the RED color. Please keep it consistent if relevant to your language.
    GRM_L["Join Date of All Alts is Currently Synced"] = "Beitrittsdaten aller Twinks sind übertragen"

    -- Update 1.130
    GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button."] = "|CFFE6CC7FSTRG-Shift-Klicken|r, um diesen Knopf zu verstecken"
    GRM_L["Invited By:"] = "Eingeladen von:"
    GRM_L["Error: Guild Not Found..."] = "Fehler: Gilde nicht gefunden..."
    GRM_L["Debugger Start"] = "Starte Debugger";

    -- Update 1.136
    GRM_L["Backup Point Removed for Guild \"{name}\""] = "Backup für Gilde \"{name}\" entfernt"
    GRM_L["Backup Point Restored for Guild \"{name}\""] = "Backup für Gilde \"{name}\" wiederhergestellt"
    GRM_L["Backup Point Set for Guild \"{name}\""] = "Backup für Gilde \"{name}\" gesetzt"
    GRM_L["Backup"] = "Backup"
    GRM_L["Horde"] = "Horde"
    GRM_L["Alliance"] = "Allianz"
    GRM_L["Creation Date"] = "Erstellungsdatum"
    GRM_L["Members"] = "Mitglieder"
    GRM_L["None"] = "leer"
    GRM_L["Restore"] = "Wiederherstellen"
    GRM_L["Set Backup"] = "Backup erstellen"
    GRM_L["Memory Usage: {num} MB"] = "genutzter Speicher: {num} MB"          -- MB references the number of MegaBytes of memory used.

    -- Update 1.137
    GRM_L["GRM: Unable to Create Backup for a Guild With Unknown Creation Date! Log into that guild on any alt to update old database."] = "Kann kein Backup für eine Gilde ohne Erstellungsdatum anlegen. Bitte logge auf einen Char in der Gilde, um veraltete Daten zu aktualisieren."
    GRM_L["Really restore {name} Backup Point?"] = "Wirklich {name} wiederherstellen?"
    GRM_L["Check All"] = "Alle auswählen"

    -- Update 1.139
    GRM_L["Right-Click for options to remove this guild from the addon database completely"] = "Rechtsklicken, um diese Gilde komplett aus der Datenbank zu entfernen"
    GRM_L["Player Cannot Purge the Guild Data they are Currently In!!!"] = "Du kannst nicht die Daten einer Gilde aufräumen, in der du gerade drin bist!"
    GRM_L["To reset your current guild data type '/grm clearguild'"] = "Um deine momentanen Gildendaten zurückzusetzen, tippe '/grm clearguild'"
    GRM_L["Click Here to Remove all traces of this guild, or hit ESC"] = "Hier klicken, um alle Spuren dieser Gilde zu beseitigen, ansonsten ESC drücken"
    GRM_L["{name} has been removed from the database."] = "{name} wurde aus der Datenbank gelöscht."              -- The Guild Name has been removed from the database

    -- update 1.141
    GRM_L["Only Restrict Incoming Player Data to Rank Threshold, not Outgoing"] = "Begrenze nur eingehende Spielerdaten mit dem Rang, nicht ausgehende"
    GRM_L["Total Entries: {num}"] = "Einträge: {num}"
    GRM_L["Search Filter"] = "Suche"

    -- update 1.142
    GRM_L["Choose Color:"] = "Farbe:"
    GRM_L["Format:"] = "Format:"
    GRM_L["RGB Values Must be Between 1 and 255."] = "RGB-Werte müssen zwischen 1 und 255 liegen."

    -- Update 1.143
    GRM_L["The Log is Currently Empty for This Guild"] = "Im Moment keine Einträge in dieser Gilde"
    GRM_L["Building Log for Export..."] = "Erstelle Log für Export"
    GRM_L["Open Log Tools"] = "Zeige Log-Werkzeuge"
    GRM_L["Hide Log Tools"] = "Verstecke Log-Werkzeuge"
    GRM_L["Numbered Lines"] = "Zeilen nummerieren"
    GRM_L["Export Log"] = "Exportiere Log"
    GRM_L["Clear Lines:"] = "Lösche Zeilen:"
    GRM_L["Enable Ctrl-Shift-Click Line Removal"] = "Erlaube STRG-Shift-Klick, um Zeilen zu löschen"
    GRM_L["To"] = "bis"                                      -- Clear Lines:  50 To 100     -- It stands between 2 edit boxes as its own fontstring, so work with that.
    GRM_L["Confirm Clear"] = "Löschen bestätigen"
    GRM_L["Please Select Range of Lines from the Log You Wish to Remove"] = "Wähle Zeilen aus, die du löschen möchtest"
    GRM_L["Please put the lowest number in the first box"] = "Bitte schreibe die niedrigere Zahl in das erste Feld"
    GRM_L["Line selection is not valid"] = "Ungültige Zeilenauswahl"
    GRM_L["Really Clear lines {custom1} to {custom2}?"] = "Wirklich Zeilen {custom1} bis {custom2} löschen?"
    GRM_L["Enabling Line Numbers... Please choose within the given range"] = "Aktiviere nummerierte Zeilen...Bitte wähle aus den Vorhandenen"
    GRM_L["Ctrl-C to Copy <> Ctrl-P to Paste <> Ctrl-A to Select All"] = "STRG+C zum Kopieren <> STRG+V zum Einfügen <> STRG+A un alles auszuwählen"
    GRM_L["Language Selection:"] = "Sprache:"
    GRM_L["{num} phrases still need translation to {name}"] = "{num} Sätze müssen noch übersetzt werden"                  -- Ex: 300 phrases still need translation to German

    -- update 1.145
    GRM_L["You currently are at {num} non-Battletag friends. To fully take advantage of all of GRM features, please consider clearing some room."] = "Du hast momentan {num} Freunde (nicht Battle-net Freunde!). Um alle Funktionen von GRM nutzen zu können, musst du bitte einen Freund entfernen."

    -- Update 1.146
    GRM_L["Really Clear line {num}?"] = "Wirklich Zeile {num} löschen?"
    GRM_L["Font has been Reset to DEFAULT."] = "Schriftart zurückgesetzt"
    GRM_L["Font Selection:"] = "Schriftart:"
    GRM_L["Font Scale:"] = "Schriftgröße:"
    GRM_L["Example"] = "Beispiel"
    GRM_L["Right-Click to Reset to 100%"] = "Rechtsklicken, um auf 100% zurückzusetzen"

    -- Update 1.147
    GRM_L["{custom1} to Search the Log for Player"] = "{custom1}, um das Log nach diesem Spieler zu durchsuchen"

    -- Update 1.148
    GRM_L["Custom Notes:"] = "Eigene Notizen:"
    GRM_L["GRM Debugging Enabled."] = "GRM Debugging aktiviert"
    GRM_L["GRM Debugging Disabled."] = "GRM Debugging deaktiviert"
    GRM_L["Please type \"/grm debug 10\" to report 10 events (or any number)"] = "Gib \"/grm debug 10\" ein, um die letzten 10 Einträge auszugeben (oder jede andere Zahl)"        -- Please keep the \"/grm debug 10)\" in-tact for slash command to work
    GRM_L["Format: \"/grm debug 10\""] = "Format: \"/grm debug 10\""                                                                  -- "" Likewise
    GRM_L["Error: Debug Command not recognized."] = "Fehler: Debug-Befehl unbekannt"
    GRM_L["You may want to temporarily disable SYNC in the options if you are debugging another feature."] = "Deaktiviere eventuell den Sync, während du andere Inhalte debugst"
    GRM_L["Sync Custom Notes"] = "Teile eigene Notizen"
    GRM_L["Default Custom Note Rank Minimum"] = "Mindestrang zum Teilen:"
    GRM_L["Reset Default Custom Note Restrictions for ALL Guildies"] = "Setze Beschränkungen für ALLE Mitglieder auf Standard zurück"
    GRM_L["Reset"] = "zurücksetzen"
    GRM_L["|CFF00CCFFDefault Selection For All Players"] = "|CFF00CCFFStandardauswahl für alle Spieler"
    GRM_L["Click here to set Custom Notes"] = "Klicke, um Eigene Notizen einzutragen"
    GRM_L["|CFF00CCFFCustom Note Defaults:"] = "|CFF00CCFFEigene Notizen Einstellungen:"
    GRM_L["|CFFE6CC7FLeft-Click|r to re-enable custom note sync for all"] = "|CFFE6CC7FLINKS-Klicken|r, um Sync-Einstellung für eigene Notizen zurückzusetzen"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Added"] = "{name} hat die eigenen Notizen von {name2} geändert: \"{custom1}\" hinzugefügt"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Removed"] = "{name} hat die eigenen Notizen von {name2} geändert: \"{custom1}\" gelöscht"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" to \"{custom2}\""] = "{name} hat die eigenen Notizen von {name2} geändert: \"{custom1}\" geändert zu \"{custom2}\""
    GRM_L["Custom Note"] = "Eigene Notiz"
    GRM_L["|CFFE6CC7FClick|r to Change Rank Restriction"] = "|CFFE6CC7FKlicken|r, um Rang-Beschränkungen zu ändern"
    GRM_L["|CFFE6CC7FClick|r to Change Day"] = "|CFFE6CC7FKlicken|r, um Tag zu ändern"
    GRM_L["|CFFE6CC7FClick|r to Change Month"] = "|CFFE6CC7FKlicken|r, um Monat zu ändern";
    GRM_L["|CFFE6CC7FClick|r to Change Year"] = "|CFFE6CC7FKlicken|r, um Jahr zu ändern";
    GRM_L["Edited by {name}"] = "Geändert von: {name}"
    GRM_L["Note Removed by {name}"] = "Notiz gelöscht von: {name}"
    GRM_L["|CFFFF0000Player No Longer in Guild"] = "|CFFFF0000Spieler nicht mehr in der Gilde"
    GRM_L["|CFF00CCFFMinimum Rank to Sync: Player Data, Ban List"] = "|CFF00CCFFMinimaler Rang, um folgendes zu teilen: Spielerdaten, Bannliste"
    GRM_L["Warning! Ban List rank threshold is below the overall sync rank. Changing from \"{name}\" to \"{name2}\""] = "Warnung! Bannlisten-Rang-Beschränkung ist unter der Allgemeinen Rang-Beschränkung! Wechsle von \"{name}\" zu \"{name2}\""
    GRM_L["|CFF00CCFFSync filter can be set tighter for the Ban List"] = "|CFF00CCFFSync-Filter für die Bannliste kann angepasst werden"
    GRM_L["Warning! Unable to select a Ban List rank below \"{name}\""] = "Warnung! Kann keinen Rang unter \"{name}\" für die Bannliste setzen"
    GRM_L["Setting to match core filter rank"] = "Zum Ändern muss der Rang zum Änderungen teilen (oben) zunächst geändert werden"

    -- R1.1482
    GRM_L["Shift-Click Name On Roster Also Works"] = "Shift-Klick auf einen Namen in der Liste geht auch"
    GRM_L["Tooltip Scale:"] = "Tooltip Skalierung"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Language"] = "|CFFE6CC7FKlicken|r, um die Sprache zu ändern"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change Display Format"] = "|CFFE6CC7FKlicken|r, um Anzeigeformat zu ändern"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Font"] = "|CFFE6CC7FKlicken|r, um die Schriftart zu ändern"

    -- R1.1490
    GRM_L["Unable to properly locate guild for backup"] = "Kann keine Gilde für Backup finden"

    -- R1.1500
    GRM_L["Unique accounts pull from the server is known to be faulty"] = "Serverabfrage für die Accounts ist fehlerhaft"
    GRM_L["Use only as an estimate. Hopefully Blizz fixes this soon"] = "Nutze diese Zahl nur als Schätzung. Wir hoffen auf einen Fix von Blizz"
    GRM_L["Add Upcoming Events to the Calendar"] = "Füge anstehende Ereignisse dem Kalender hinzu"
    GRM_L["Player rank unable to add events to calendar"] = "Gildenrang zu niedrig, um Ereignisse im Kalender anzulegen"
    GRM_L["Anniversaries, Birthdays, and Other Events can be added with permission"] = "Jahrestage, Geburtstage und andere Ereignisse können mit Erlaubnis angelegt werden"

    -- R1.1510
    GRM_L["Check the \"Sync Users\" tab to find out why!"] = "Schaue in den \"Sync-Tab\", um herauszufinden, warum"
    GRM_L["Time as Member:"] = "Zeit als Mitglied:"
    GRM_L["|CFFE6CC7FClick|r to select player event"] = "|CFFE6CC7FKlicken|r, um Spieler-Event auszuwählen"
    GRM_L["Timestamp Format:"] = "Datumsformat:"
    GRM_L["Hour Format:"] = "Zeitformat:"
    GRM_L["24 Hour"] = "24 Stunden"
    GRM_L["12 Hour (am/pm)"] = "12 Stunden"                             -- removed the am/pm due to spacing. Context prob just fine
    GRM_L["Confirm Custom Note"] = "Bestätige Eigene Notiz"
    GRM_L["Enable Fade on Tab Change"] = "Aktiviere Verblassen bei Tabwechsel"

    -- R1.1520
    GRM_L["A new rank has been added to the guild!"] = "Ein neuer Rang wurde der Gilde hinzugefügt!"
    GRM_L["{num} new ranks have been added to the guild!"] = "{num} neue Ränge wurden der Gilde hinzugefügt!"
    GRM_L["The guild has removed a rank!"] = "Ein Rang wurde der Gilde entfernt!"
    GRM_L["{num} guild ranks have been removed!" ] = "{num} Ränge wurden der Gilde entfernt!"
    GRM_L["Edit Ban"] = "Bann bearbeiten"
    GRM_L["Please Select a Player to Edit their Ban!"] = "Bitte einen Spieler auswählen, um seinen Bann zu bearbeiten!"
    GRM_L["Update Ban"] = "Bann aktualisiert"
    GRM_L["{name}'s Ban Info has Been Updated!"] = "Bann-Info von {name} aktualisiert!"

    -- R1.1530
    GRM_L["{name} plays the {custom1} class, not {custom2}."] = "{name} spielt {custom1},  nicht {custom2}."             -- Example: Arkaan plays the Hunter class, not Paladin.
    GRM_L["{num} Items Updated"] = "{num} Gegenstände aktualisiert"
    GRM_L["You Currently Have Disabled Adding Events to Calendar"] = "Du hast es momentan deaktiviert, Kalenderereignisse zu erstellen"

    -- R1.20
    GRM_L["|CFFE6CC7FHold Shift|r to view more alt details."] = "|CFFE6CC7FHalte Shift|r, um mehr Twink-Details zu sehen."               -- "Hold Shift to view more alt details" is the phrase, but the |CFF|r is the text coloring hex code. Please keep it in there on the keyboard command coloring
    GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7FKlicke|r, um mehr Twink-Details zu sehen."
    GRM_L["{custom1} to keep alt details open."] = "{custom1}, um die Twink-Details offen zu lassen"               -- The same can be said here. ^^
    GRM_L["|CFFE6CC7FClick|r to flip player name ordering"] = "|CFFE6CC7FKlicke|r, um die Sortierreihenfolge umzudrehen"                  -- and the reset...
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Newest"] = "|CFFE6CC7FKlicke|r, um Neueste Eintrittsdaten oben zu sehen"
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Oldest"] = "|CFFE6CC7FKlicke|r, um Älteste Eintrittsdaten oben zu sehen"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Newest"] = "|CFFE6CC7FKlicke|r, um Neueste Beförderungen oben zu sehen"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Oldest"] = "|CFFE6CC7FKlicke|r, um Älteste Beförderungen oben zu sehen"
    GRM_L["|CFFE6CC7FClick|r to sort all Mains first"] = "|CFFE6CC7FKlicke|r, um alle Mains zuerst zu sehen"
    GRM_L["|CFFE6CC7FClick|r to sort all Alts first."] = "|CFFE6CC7FKlicke|r, um alle Twinks zuerst zu sehen"
    GRM_L["{name}'s Alts"] = "Twinks von {name}"                                            -- Like "Arkaan's Alts"
    GRM_L["GRM window will open when combat ends."] = "GRM wird geöffnet, wenn der Kampf zu Ende ist."

    -- R1.24
    GRM_L["This also will change the <Alt> format to match"] = "Dies ändert auch das <Twink>-Format entsprechend"
    GRM_L["M"] = "M"                                           -- Anmerkung: "M" für Main ist universell verständlich.
    GRM_L["A"] = "T"                                            -- Anmerkung: "T" für "Twink" wäre die logische deutsche Abkürzung für Alt.

    -- R1.25
    GRM_L["Include \"Joined:\" tag with the date."] = "Füge den \"Beigetreten:\"-Tag zum Datum hinzu."
    GRM_L["GRM Auto-Detect! {name} has joined the guild and will be set as Main"] = "GRM Auto-Erkennung! {name} ist der Gilde beigetreten und wird als Main gesetzt"

    -- R1.26
    GRM_L["Click to Disable Sync of Custom Note"] = "Klicken, um die Synchronisation der eigenen Notiz zu deaktivieren"
    GRM_L["Click to Enable Sync of Custom Note"] = "Klicken, um die Synchronisation der eigenen Notiz zu aktivieren"

    -- R1.27
    GRM_L["Show Border on Public, Officer, and Custom Notes"] = "Rahmen bei öffentlichen, Offiziers- und eigenen Notizen anzeigen"

    -- R1.28
    GRM_L["Public Note:"] = "Öffentliche Notiz:"
    GRM_L["Officer Note:"] = "Offiziersnotiz:"
    GRM_L["Officer Note"] = "Offiziersnotiz" -- This was already translated, but included for completeness from your list.
    GRM_L["Show Public, Officer, and Custom Notes on Log Entries of Left Players"] = "Öffentliche, Offiziers- & eigene Notizen bei Austritten im Log anzeigen"
    GRM_L["Hard Reset"] = "Hard Reset"
    GRM_L["Hard reset of ALL GRM data, account-wide. Game will reload!"] = "Hard Reset ALLER GRM-Daten, accountweit. Das Spiel wird neu geladen!"
    GRM_L["Only recommend to kick if all player linked alts exceed max time"] = "Kick nur empfehlen, wenn alle Twinks des Spielers die maximale Zeit überschreiten"
    GRM_L["Your Guild Leader Has Set Sync Restrictions to {name} or Higher"] = "Dein Gildenleiter hat die Sync-Beschränkungen auf {name} oder höher festgelegt"
    GRM_L["Unable to Change Rank. Guild Leader has set restriction to {name} or higher"] = "Rang kann nicht geändert werden. Gildenleiter hat die Beschränkung auf {name} oder höher gesetzt"
    GRM_L["Unable to Change Rank. Guild Leader has set restriction level."] = "Rang kann nicht geändert werden. Gildenleiter hat eine Beschränkungsstufe festgelegt."
    GRM_L["Force Settings with Guild Info Tags"] = "Einstellungen mit Gildeninfo-Tags erzwingen"
    GRM_L["Database Still Loading. GRM will open automatically when finished."] = "Datenbank lädt noch. GRM öffnet sich automatisch, wenn fertig."

    -- R1.29
    GRM_L["The highlighted character is not valid for messages. Please remove."] = "Das markierte Zeichen ist für Nachrichten ungültig. Bitte entfernen."
    GRM_L["Not all characters are valid. Please remove any non-text characters."] = "Nicht alle Zeichen sind gültig. Bitte entferne alle Sonderzeichen."
    GRM_L["Kick macro created. Press \"CTRL-SHIFT-K\" to kick all of {name}'s alts"] = "Kick-Makro erstellt. Drücke \"STRG-SHIFT-K\", um alle Twinks von {name} zu kicken"
    GRM_L["Kick the Player's {num} alts too?"] = "Auch die {num} Twinks des Spielers kicken?"
    GRM_L["Kick the Player's {num} alt too?"] = "Auch den Twink des Spielers kicken?"
    GRM_L["Ban and Kick the Player's {num} alts too?"] = "Auch die {num} Twinks des Spielers bannen und kicken?"
    GRM_L["Ban and Kick the Player's {num} alt too?"] = "Auch den Twink des Spielers bannen und kicken?"

    -- R1.30
    GRM_L["Sync With {name} is Complete..."] = "Synchronisation mit {name} abgeschlossen..."
    GRM_L["|CFFE6CC7FLeft-Click|r and drag to move this button."] = "|CFFE6CC7FLinksklick|r und ziehen, um diesen Button zu verschieben."
    GRM_L["{custom1} and drag to move this button anywhere."] = "{custom1} und ziehen, um diesen Button zu verschieben."
    GRM_L["MOTD:"] = "NdT:" -- Nachricht des Tages
    GRM_L["minimap"] = "minimap"

    -- R1.31
    GRM_L["Show 'Main' Tag on both Mains and Alts in Chat"] = "Zeige 'Main'-Tag bei Mains und Twinks im Chat"

    -- R1.32
    GRM_L["GRM has moved the Guild Leader setting restriction codes to the Guild Info tab."] = "GRM hat die Einstellungscodes des Gildenleiters in den Gildeninfo-Tab verschoben."
    GRM_L["Please make room for them and re-add."] = "Bitte schaffe Platz dafür und füge sie erneut hinzu."
    GRM_L["Your Guild Leader Has Set BAN Sync Restrictions to {name} or Higher"] = "Dein Gildenleiter hat die BANN-Sync-Beschränkungen auf {name} oder höher festgelegt"
    GRM_L["Your Guild Leader Has Set CUSTOM NOTE Sync Restrictions to {name} or Higher"] = "Dein Gildenleiter hat die EIGENE-NOTIZ-Sync-Beschränkungen auf {name} oder höher festgelegt"

    -- R1.33
    GRM_L["Macro will auto-remove after {num} seconds."] = "Makro wird nach {num} Sekunden automatisch entfernt."
    GRM_L["UI Controls"] = "UI-Steuerung"
    GRM_L["UI Configuration:"] = "UI-Konfiguration:"
    GRM_L["Show Character Guild Reputation"] = "Gildenruf des Charakters anzeigen"
    GRM_L["Show Guild Member Birthdays"] = "Geburtstage von Gildenmitgliedern anzeigen"
    GRM_L["Set Birthday"] = "Geburtstag setzen"
    GRM_L["Edit Birthday"] = "Geburtstag bearbeiten"
    GRM_L["Remove Date"] = "Datum entfernen"
    GRM_L["Birthday"] = "Geburtstag"
    GRM_L["Only Announce Birthdays and Anniversaries if Listed as 'Main'"] = "Geburtstage und Jahrestage nur für 'Mains' ankündigen"
    GRM_L["{name} will be celebrating {num} year in the Guild!"] = "{name} feiert das {num}. Jahr in der Gilde!"
    GRM_L["{name} will be celebrating {num} years in the Guild!"] = "{name} feiert {num} Jahre in der Gilde!"
    GRM_L["No player's currently available to sync {name}'s Guild Data..."] = "Kein Spieler verfügbar, um die Gildendaten von {name} zu synchronisieren..."
    GRM_L["{name} has set {name2}'s Birthday: {custom1}"] = "{name} hat den Geburtstag von {name2} gesetzt: {custom1}"
    GRM_L["{name}'s Birthday has been set: {custom1}"] = "Der Geburtstag von {name} wurde gesetzt: {custom1}"

    -- R1.34
    GRM_L["Debugging Enabled"] = "Debugging aktiviert"
    GRM_L["Debugging Disabled"] = "Debugging deaktiviert"
    GRM_L["{num} is not a valid day of the month! It must be a number between 1 and 31"] = "{num} ist kein gültiger Tag des Monats! Es muss eine Zahl zwischen 1 und 31 sein"
    GRM_L["{num} is not a valid index of the month of the year! It must be a number between 1 and 12"] = "{num} ist kein gültiger Monat des Jahres! Es muss eine Zahl zwischen 1 und 12 sein"
    GRM_L["The day cannot be {num}. It must be a number between 1 and 31"] = "Der Tag kann nicht {num} sein. Es muss eine Zahl zwischen 1 und 31 sein"
    GRM_L["The month cannont be {num}. must be a number between 1 and 12"] = "Der Monat kann nicht {num} sein. Es muss eine Zahl zwischen 1 und 12 sein"
    GRM_L["{num} birthdays have been reset."] = "{num} Geburtstage wurden zurückgesetzt."
    GRM_L["No player was found to have that birthday."] = "Kein Spieler mit diesem Geburtstag gefunden."

    -- R1.35
    GRM_L["Your Guild Leader Has Set Join Dates to only be added to the {name}"] = "Dein Gildenleiter hat festgelegt, dass Beitrittsdaten nur zur {name} hinzugefügt werden"
    GRM_L["Warning - Global Controls:"] = "Achtung - Globale Steuerung:"
    GRM_L["Sync Restrictions Globally Changed to {name} or Higher"] = "Sync-Beschränkungen global auf {name} oder höher geändert"
    GRM_L["BAN Sync Restrictions Globally Changed to {name} or Higher"] = "BANN-Sync-Beschränkungen global auf {name} oder höher geändert"
    GRM_L["CUSTOM NOTE Sync Restrictions Globally Changed to {name} or Higher"] = "EIGENE-NOTIZ-Sync-Beschränkungen global auf {name} oder höher geändert"
    GRM_L["Join Dates Globally Changed to only be added to the {name}"] = "Beitrittsdaten werden global nur noch zur {name} hinzugefügt"
    GRM_L["Unable to Modify. Global setting is set to the {name}"] = "Kann nicht geändert werden. Globale Einstellung ist auf {name} gesetzt"

    -- R1.37
    GRM_L["No Action Configured"] = "Keine Aktion konfiguriert"
    GRM_L["OLD LOG"] = "ALTES LOG"
    GRM_L["CHANGES"] = "ÄNDERUNGEN"
    GRM_L["Sync has failed to start. Please try again!"] = "Synchronisation konnte nicht gestartet werden. Bitte erneut versuchen!"
    GRM_L["Please wait {num} more seconds before manually initiating the sync process again."] = "Bitte warte noch {num} Sekunden, bevor du die Synchronisation erneut manuell startest."

    -- R1.39
    GRM_L["Only Report if there are no Active Alts in the Group"] = "Nur melden, wenn keine aktiven Twinks in der Gruppe sind"
    GRM_L["Level Filter Minimum:"] = "Mindestlevel-Filter:"
    GRM_L["Report Milestones:"] = "Meilensteine melden:"
    GRM_L["Report Level Up Changes"] = "Levelaufstiege melden"
    GRM_L["Reporting:"] = "Meldungen:"
    GRM_L["Unable to disable level cap tracking. Please disable ALL tracking to turn off."] = "Tracking für Max-Level kann nicht deaktiviert werden. Bitte ALLES Tracking deaktivieren."
    GRM_L["No Levels to Report to Log"] = "Keine Level zum Melden im Log"
    GRM_L["{name} has Surpassed their Level {num} Milestone and is Now {custom1}"] = "{name} hat den Level-{num}-Meilenstein überschritten und ist jetzt {custom1}"
    GRM_L["{name} has Reached their Level {num} Milestone"] = "{name} hat den Level-{num}-Meilenstein erreicht"
    GRM_L["{name}'s Ban has been Updated by {name2}!"] = "Der Bann von {name} wurde von {name2} aktualisiert!"
    GRM_L["{name} has Updated {name2}'s BAN and also BANNED all linked alts from the guild!"] = "{name} hat den BANN von {name2} aktualisiert und auch alle Twinks verbannt!"
    GRM_L["One moment, GRM is still being configured."] = "Einen Moment, GRM wird noch konfiguriert."
    GRM_L["Player Was Banned By: {name}"] = "Spieler wurde gebannt von: {name}"
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED players are currently in the guild."] = "|cffff0000ACHTUNG!!!|r {num} GEBANNTE Spieler sind aktuell in der Gilde."
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED player is currently in the guild."] = "|cffff0000ACHTUNG!!!|r {num} GEBANNTER Spieler ist aktuell in der Gilde."

    -- R1.41
    GRM_L["Auto-Focus the search box"] = "Suchfeld automatisch fokussieren"
    GRM_L["This will skip the first time if set to load on logon"] = "Wird beim ersten Mal übersprungen, wenn 'Bei Login laden' aktiv ist"
    GRM_L["Please enter a valid level between 1 and {num}"] = "Bitte gib ein gültiges Level zwischen 1 und {num} ein"
    GRM_L["Player's Main: {name}"] = "Main des Spielers: {name}"

    -- R1.43
    GRM_L["One moment, requesting additional details on {name} from the server. Ban List will soon update."] = "Moment, frage Details zu {name} vom Server an. Bannliste wird gleich aktualisiert."
    GRM_L["Unable to identify {name}. Ensure your spelling is accurate and the correct realm is selected!"] = "Kann {name} nicht identifizieren. Achte auf korrekte Schreibweise und Realm!"
    GRM_L["(Unable to Identify)"] = "(Unbekannt)"
    GRM_L["|CFFE6CC7FClick|r to select player class"] = "|CFFE6CC7FKlicken|r, um die Spielerklasse auszuwählen"
    GRM_L["|CFFE6CC7FClick|r to select player's realm."] = "|CFFE6CC7FKlicken|r, um den Realm des Spielers auszuwählen."
    GRM_L["All Connected Realms are available to choose."] = "Alle verbundenen Realms stehen zur Auswahl."
    GRM_L["{num} players were found to have the same name. Please manually select the player's realm"] = "{num} Spieler mit demselben Namen gefunden. Bitte wähle den Realm manuell aus."
    GRM_L["Click or Press TAB to cycle through each step."] = "Klicken oder TAB drücken, um durch die Schritte zu wechseln."
    GRM_L["Former and Current Members"] = "Ehemalige und aktuelle Mitglieder"
    GRM_L["No Matches Found. Add a Custom New Player or Match"] = "Keine Treffer. Füge einen neuen Spieler hinzu."

    --1.50
    GRM_L["{name}'s alt grouping has had their Birthday removed by: {name2}"] = "Der Geburtstag der Twink-Gruppe von {name} wurde von {name2} entfernt"
    GRM_L["{name}'s Birthday has been removed by: {name2}"] = "Der Geburtstag von {name} wurde von {name2} entfernt"
    GRM_L["Click to Sort"] = "Klicken zum Sortieren"
    GRM_L["No Updates"] = "Keine Updates"
    GRM_L["Timestamp Formatting has been Globally Set to: < {name} >"] = "Zeitstempel-Format wurde global auf < {name} > gesetzt"
    GRM_L["Your Guild Leader Has Globally Set the Timestamp Formatting to: < {name} >"] = "Dein Gildenleiter hat das Zeitstempel-Format global auf < {name} > gesetzt"
    GRM_L["Unable to Modify. Global setting is set to :   {name}"] = "Kann nicht geändert werden. Globale Einstellung ist: {name}"

    -- 1.52
    GRM_L["Times in Guild: {num}"] = "Male in Gilde: {num}"

    -- 1.56
    -- More slash commands
    GRM_L["kick"] = "kick"
    GRM_L["ban"] = "ban"
    GRM_L["audit"] = "prüfung"
    GRM_L["log"] = "log"
    GRM_L["event"] = "event"
    GRM_L["events"] = "ereignisse"
    GRM_L["users"] = "user"
    GRM_L["syncusers"] = "syncuser"
    GRM_L["opt"] = "opt"
    GRM_L["option"] = "option"
    GRM_L["options"] = "optionen"

    GRM_L["GRM Date"] = "GRM-Datum"
    GRM_L["Note Date"] = "Notiz-Datum"
    GRM_L["Status"] = "Status"
    GRM_L["Refresh"] = "Aktualisieren"
    GRM_L["Clear Selection"] = "Auswahl löschen"
    GRM_L["Fix all mismatched note dates with GRM saved date"] = "Alle falschen Notiz-Daten mit GRM-Datum korrigieren"
    GRM_L["Fix selected mismatched note dates with GRM saved date"] = "Ausgewählte falsche Notiz-Daten mit GRM-Datum korrigieren"
    GRM_L["Fix all mismatched GRM dates with the note date"] = "Alle falschen GRM-Daten mit Notiz-Datum korrigieren"
    GRM_L["Fix selected mismatched GRM dates with the note date"] = "Ausgewählte falsche GRM-Daten mit Notiz-Datum korrigieren"
    GRM_L["Import all missing join dates from the note date"] = "Alle fehlenden Beitrittsdaten aus Notizen importieren"
    GRM_L["Import selected missing join dates from the note date"] = "Ausgewählte fehlende Beitrittsdaten aus Notizen importieren"
    GRM_L["Add all missing saved dates to the {name}"] = "Alle fehlenden Daten zu {name} hinzufügen"
    GRM_L["Add selected missing saved dates to {name}"] = "Ausgewählte fehlende Daten zu {name} hinzufügen"
    GRM_L["Clear all join dates from incorrect note locations"] = "Alle Beitrittsdaten aus falschen Notizen entfernen"
    GRM_L["Clear selected join dates from incorrect note locations"] = "Ausgewählte Beitrittsdaten aus falschen Notizen entfernen"
    GRM_L["Not Found"] = "Nicht gefunden"
    GRM_L["Not Set"] = "Nicht gesetzt"
    GRM_L["Complete"] = "Vollständig"
    GRM_L["Multiple"] = "Mehrere"
    GRM_L["Location"] = "Ort"

    -- JD tool button actions and tooltips
    GRM_L["|CFFE6CC7FShift-Click|r Second Button to Select All In-Between"] = "|CFFE6CC7FShift-Klick|r auf zweiten Button wählt alle dazwischen aus"
    GRM_L["|CFFE6CC7FClick|r to select player"] = "|CFFE6CC7FKlicken|r, um Spieler auszuwählen"
    GRM_L["Only Show Players With Incomplete Status"] = "Nur Spieler mit unvollständigem Status anzeigen"
    GRM_L["{num} Join Dates Need Attention"] = "{num} Beitrittsdaten benötigen Aufmerksamkeit"
    GRM_L["Do you really want to remove the join dates from notes other than the {name}?"] = "Möchtest du wirklich Beitrittsdaten aus anderen Notizen als {name} entfernen?"
    GRM_L["Do you really want to fix mismatched dates using the note?"] = "Möchtest du wirklich falsche Daten mit der Notiz korrigieren?"
    GRM_L["Do you really want to fix note dates using the saved GRM dates?"] = "Möchtest du wirklich Notiz-Daten mit den GRM-Daten korrigieren?"
    GRM_L["Do you really want to add the missing join dates to the {name}?"] = "Möchtest du wirklich die fehlenden Beitrittsdaten zu {name} hinzufügen?"
    GRM_L["Auto-adding join dates to the {name} is disabled. Do you still wish to continue?"] = "Automatisches Hinzufügen zu {name} ist deaktiviert. Fortfahren?"
    GRM_L["There are currently {num} mismatched dates to fix"] = "Es gibt aktuell {num} falsche Daten zu korrigieren"
    GRM_L["There are currently no mismatched dates that need to be fixed."] = "Es gibt aktuell keine falschen Daten zu korrigieren."
    GRM_L["There are currently no dates that need to be imported."] = "Es gibt aktuell keine Daten zum Importieren."
    GRM_L["There are currently no dates that can be added to the default note."] = "Es können aktuell keine Daten zur Standard-Notiz hinzugefügt werden."
    GRM_L["There are currently no dates that need to be removed from incorrect notes"] = "Es müssen aktuell keine Daten aus falschen Notizen entfernt werden"
    GRM_L["There are currently {num} players who have join dates listed in the incorrect note"] = "Bei {num} Spielern stehen Beitrittsdaten in der falschen Notiz"
    GRM_L["Warning! Your function is extremely limited without officer permissions"] = "Achtung! Deine Funktion ist ohne Offiziersrechte stark eingeschränkt"
    GRM_L["Advanced Join Date Tool"] = "Erweitertes Beitrittsdatum-Werkzeug"

    -- JD tool reasons
    GRM_L["Mismatched dates"] = "Falsche Daten"
    GRM_L["Matching date found in wrong note location"] = "Richtiges Datum in falscher Notiz gefunden"
    GRM_L["Date not added to note"] = "Datum nicht zur Notiz hinzugefügt"
    GRM_L["Mismatched dates, and found in wrong note location"] = "Falsches Datum, in falscher Notiz gefunden"
    GRM_L["Mismatched date found in multiple locations, including correct"] = "Falsches Datum an mehreren Orten gefunden, inkl. richtigem"
    GRM_L["Mismatched date found in multiple incorrect note locations"] = "Falsches Datum an mehreren falschen Orten gefunden"
    GRM_L["Matching date found in multiple incorrect note locations"] = "Richtiges Datum an mehreren falschen Orten gefunden"
    GRM_L["Matching date found in multiple locations, including correct"] = "Richtiges Datum an mehreren Orten gefunden, inkl. richtigem"
    GRM_L["Date found in incorrect note, but not yet imported"] = "Datum in falscher Notiz gefunden, aber noch nicht importiert"
    GRM_L["Date found in multiple incorrect notes, but not yet imported"] = "Datum in mehreren falschen Notizen gefunden, aber noch nicht importiert"
    GRM_L["Date found in multiple locations, including correct, but not yet imported"] = "Datum an mehreren Orten gefunden, inkl. richtigem, aber nicht importiert"
    GRM_L["Date found in correct note location, but not yet imported"] = "Datum in richtiger Notiz gefunden, aber noch nicht importiert"

    -- More misc.
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been set to be added to join date note entries."] = "Die Tags \"{name}\" und \"{name2}\" wurden global für Beitrittsnotizen aktiviert."
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been disabled from adding to join date note entries."] = "Die Tags \"{name}\" und \"{name2}\" wurden global für Beitrittsnotizen deaktiviert."
    GRM_L["Your rank has changed. Re-evaluating sync permissions."] = "Dein Rang hat sich geändert. Überprüfe Sync-Berechtigungen neu."

    -- 1.57
    GRM_L["Full Log Message:"] = "Vollständige Log-Nachricht:"
    GRM_L["Log Entry Tooltip"] = "Log-Eintrag Tooltip"
    GRM_L["1 entry has been removed from the log"] = "1 Eintrag wurde aus dem Log entfernt"
    GRM_L["{num} entries have been removed from the log"] = "{num} Einträge wurden aus dem Log entfernt"

    -- 1.59
    GRM_L["Adding the Join Date cannot be disabled due to the global setting"] = "Hinzufügen des Beitrittsdatums kann wegen globaler Einstellung nicht deaktiviert werden"
    GRM_L["Due to your current rank, you will be unable to add Join Date Timestamps"] = "Aufgrund deines Ranges kannst du keine Beitrittsdaten-Zeitstempel hinzufügen"
    GRM_L["Warning! Due to your rank you will be unable to add Join Date timestamps to the {name}"] = "Achtung! Aufgrund deines Ranges kannst du keine Zeitstempel zur {name} hinzufügen"
    GRM_L["Unable to Modify Format:  {name}"] = "Format kann nicht geändert werden: {name}"
    GRM_L["Show Mouseover"] = "Bei Mouseover anzeigen"
    GRM_L["Unable to create GRM hotkey macro. You currently are at the cap of {num} macros."] = "GRM-Hotkey-Makro kann nicht erstellt werden. Du hast das Maximum von {num} Makros erreicht."

    -- 1.60
    GRM_L["Really remove {name} Backup Point?"] = "Backup-Punkt für {name} wirklich entfernen?"

    -- 1.63
    GRM_L["Disabled"] = "Deaktiviert"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays January to December"] = "|CFFE6CC7FKlicken|r, um Geburtstage von Januar bis Dezember zu sortieren"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays December to January"] = "|CFFE6CC7FKlicken|r, um Geburtstage von Dezember bis Januar zu sortieren"

    -- 1.64
    GRM_L["Chat Window for All GRM Messages:"] = "Chatfenster für alle GRM-Nachrichten:"
    GRM_L["\"{name}\" Chat Window\nDo you wish to create it?" ] = "\"{name}\" Chatfenster\nMöchtest du es erstellen?"
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you close this one."] = "GRM sendet Nachrichten automatisch an das \"{name}\"-Fenster, wenn du dieses schließt."
    GRM_L["Channel Settings Are Character Specific and Will Not Be Sync'd"] = "Kanaleinstellungen sind charakterspezifisch und werden nicht synchronisiert"

    -- 1.66
    GRM_L["Custom Join Tag:"] = "Eigener Beitritts-Tag:"
    GRM_L["Custom Rejoin Tag:"] = "Eigener Wiederbeitritts-Tag:"
        -- Join Tag
    GRM_L["Custom Join Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "Eigener Beitritts-Tag \"{name}\" kann nicht gesetzt werden, da er {num} Zeichen hat. Max. ist {custom1}."
    GRM_L["Custom Join Tag has been changed from \"{name}\" to \"{name2}\""] = "Eigener Beitritts-Tag wurde von \"{name}\" zu \"{name2}\" geändert"
    GRM_L["Custom Join Tag has been set to \"{name}\""] = "Eigener Beitritts-Tag wurde auf \"{name}\" gesetzt"
    GRM_L["Your Guild Leader has changed the Custom Join Tag from \"{name}\" to \"{name2}\""] = "Dein Gildenleiter hat den Beitritts-Tag von \"{name}\" zu \"{name2}\" geändert"
    GRM_L["Your Guild Leader has set the Custom Join Tag to \"{name}\""] = "Dein Gildenleiter hat den Beitritts-Tag auf \"{name}\" gesetzt"
        -- Rejoin Tag
    GRM_L["Custom Rejoin Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "Eigener Wiederbeitritts-Tag \"{name}\" kann nicht gesetzt werden, da er {num} Zeichen hat. Max. ist {custom1}."
    GRM_L["Custom Rejoin Tag has been changed from \"{name}\" to \"{name2}\""] = "Eigener Wiederbeitritts-Tag wurde von \"{name}\" zu \"{name2}\" geändert"
    GRM_L["Custom Rejoin Tag has been set to \"{name}\""] = "Eigener Wiederbeitritts-Tag wurde auf \"{name}\" gesetzt"
    GRM_L["Your Guild Leader has changed the Custom Rejoin Tag from \"{name}\" to \"{name2}\""] = "Dein Gildenleiter hat den Wiederbeitritts-Tag von \"{name}\" zu \"{name2}\" geändert"
    GRM_L["Your Guild Leader has set the Custom Rejoin Tag to \"{name}\""] = "Dein Gildenleiter hat den Wiederbeitritts-Tag auf \"{name}\" gesetzt"

        -- 1.67
    GRM_L["Kick"] = "Kicken"
    GRM_L["Promote"] = "Befördern"
    GRM_L["Demote"] = "Degradieren"
    GRM_L["Macro:"] = "Makro:"
    GRM_L["Macro Size: {num}/255"] = "Makrogröße: {num}/255"
    GRM_L["Action"] = "Aktion"
    GRM_L["Ignored Action:"] = "Ignorierte Aktion:"
    GRM_L["Click to Build Macro"] = "Klicken, um Makro zu erstellen"
    GRM_L["No Current Names to Add"] = "Keine Namen zum Hinzufügen"
    GRM_L["No Names to Add to the Macro"] = "Keine Namen zum Makro hinzuzufügen"
    GRM_L["Hot Key: {name}"] = "Hotkey: {name}"
    GRM_L["Permissions"] = "Berechtigungen"
    GRM_L["Player rank change detected, re-checking permissions and rebuilding GRM Macro Tool."] = "Rangänderung erkannt, Berechtigungen werden geprüft und Makro-Werkzeug neu erstellt."
    GRM_L["Click to remove selected names from the macro"] = "Klicken, um ausgewählte Namen aus dem Makro zu entfernen"
    GRM_L["Click to remove selected name from the macro"] = "Klicken, um ausgewählten Namen aus dem Makro zu entfernen"
    GRM_L["Click to remove selected names from Ignore List"] = "Klicken, um ausgewählte Namen von der Ignorier-Liste zu entfernen"
    GRM_L["Click to remove selected name from Ignore List"] = "Klicken, um ausgewählten Namen von der Ignorier-Liste zu entfernen"
    GRM_L["No names selected to remove from macro"] = "Keine Namen zum Entfernen aus dem Makro ausgewählt"
    GRM_L["No names selected to remove from Ignore List"] = "Keine Namen zum Entfernen von der Ignorier-Liste ausgewählt"
    GRM_L["Macro is currently empty"] = "Makro ist derzeit leer"
    GRM_L["{num} players removed from the macro"] = "{num} Spieler aus dem Makro entfernt"
    GRM_L["{num} player was removed from the macro"] = "1 Spieler wurde aus dem Makro entfernt"
    GRM_L["{num} players removed from the Ignored List"] = "{num} Spieler von der Ignorier-Liste entfernt"
    GRM_L["{num} player was removed from Ignore List"] = "1 Spieler wurde von der Ignorier-Liste entfernt"
    GRM_L["There are no names currently selected to be removed from the Ignore List."] = "Es sind keine Namen zum Entfernen von der Ignorier-Liste ausgewählt."
    GRM_L["There are no names currently selected to be removed from the macro."] = "Es sind keine Namen zum Entfernen aus dem Makro ausgewählt."
    GRM_L["The macro is not yet built. Please click the button to create the macro."] = "Das Makro wurde noch nicht erstellt. Bitte klicke, um es zu erstellen."
    GRM_L["Nothing to clear"] = "Nichts zum Löschen"
    GRM_L["There are currently no names to add"] = "Derzeit keine Namen zum Hinzufügen"
    GRM_L["There are currently no names to remove"] = "Derzeit keine Namen zum Entfernen"
    GRM_L["Rules"] = "Regeln"
    GRM_L["Please choose a day between 1 and 99"] = "Bitte wähle einen Tag zwischen 1 und 99"
    GRM_L["Please choose a day between 0 and 99"] = "Bitte wähle einen Tag zwischen 0 und 99"
    GRM_L["Pressing the ESC key will also clear all lines"] = "Drücken von ESC löscht ebenfalls alle Zeilen"
    GRM_L["Player's rank does not have permission to remove others from the guild"] = "Der Rang des Spielers hat keine Berechtigung, andere aus der Gilde zu entfernen"
    GRM_L["Player's rank does not have permission to promote others in the guild"] = "Der Rang des Spielers hat keine Berechtigung, andere zu befördern"
    GRM_L["Player's rank does not have permission to demote others in the guild"] = "Der Rang des Spielers hat keine Berechtigung, andere zu degradieren"
    GRM_L["Queued Actions"] = "Aktionen in Warteschlange"
    GRM_L["Current Actions"] = "Aktuelle Aktionen"
    GRM_L["View Ignore List"] = "Ignorier-Liste anzeigen"
    GRM_L["No players are currently safe from recommendations"] = "Keine Spieler sind derzeit vor Empfehlungen geschützt"
    GRM_L["1 player is on the safe list."] = "1 Spieler ist auf der Schutzliste."
    GRM_L["{num} players are on the safe list."] = "{num} Spieler sind auf der Schutzliste."
    GRM_L["1 action is being ignored."] = "1 Aktion wird ignoriert."
    GRM_L["{num} actions are being ignored."] = "{num} Aktionen werden ignoriert."
    GRM_L["No current actions are being ignored"] = "Keine Aktionen werden derzeit ignoriert"
    GRM_L["Actions Ignored:"] = "Ignorierte Aktionen:"
    GRM_L["Total Queued:"] = "Gesamt in Queue:"
    GRM_L["Ignored Players Safe From Action"] = "Ignorierte Spieler (sicher vor Aktion)"
    GRM_L["Only show players with ignored action"] = "Nur Spieler mit ignorierter Aktion anzeigen"
    GRM_L["No players on Ignore List"] = "Keine Spieler auf der Ignorier-Liste"
    GRM_L["No players to select. 1 player filtered"] = "Keine Spieler wählbar. 1 Spieler gefiltert"
    GRM_L["No players to select. {num} players filtered"] = "Keine Spieler wählbar. {num} Spieler gefiltert"
    GRM_L["There are no names to select. 1 player is filtered"] = "Keine Namen wählbar. 1 Spieler wird gefiltert."
    GRM_L["There are no names to select. {num} players are filtered"] = "Keine Namen wählbar. {num} Spieler werden gefiltert."
    GRM_L["Really remove selected player from the ignore list?"] = "Ausgewählten Spieler wirklich von der Ignorier-Liste entfernen?"
    GRM_L["Really remove the {num} selected players from the ignore list?"] = "Die {num} ausgewählten Spieler wirklich von der Ignorier-Liste entfernen?"
    GRM_L["Do you really wish to clear all players from the Ignore List?"] = "Möchtest du wirklich alle Spieler von der Ignorier-Liste entfernen?"
    GRM_L["There are currently no players on the Ignore List"] = "Derzeit keine Spieler auf der Ignorier-Liste"
    GRM_L["Remove all players from Ignore List"] = "Alle Spieler von Ignorier-Liste entfernen"
    GRM_L["Ignored Players: {num}"] = "Ignorierte Spieler: {num}"
    GRM_L["Tool"] = "werkzeug"
    GRM_L["Macro Tool"] = "Makro-Werkzeug"
    GRM_L["Macro Tool: {num}"] = "Makro-Werkzeug: {num}"

    -- CLASSIC
    GRM_L["Social"] = "Soziales"
    GRM_L["Roster"] = "Liste"
    GRM_L["Feature is disabled in WoW Classic"] = "Funktion in WoW Classic deaktiviert"
    GRM_L["Feature is disabled in TBC Classic"] = "Funktion in TBC Classic deaktiviert"
    GRM_L["(Classic)"] = "(Classic)"

    -- 1.69
    GRM_L["Importing dates must be done in a compatible format"] = "Daten müssen in einem kompatiblen Format importiert werden"
    GRM_L["The date selection in OPTIONS shows all supported"] = "Die Datumsauswahl in den OPTIONEN zeigt alle unterstützten Formate"
    GRM_L["Headers, like \"Joined,\" are supported"] = "Überschriften, wie \"Beigetreten:\", werden unterstützt"
    GRM_L["To confirm or edit the date, open the player window, right click the date, edit, and submit"] = "Zum Bestätigen/Bearbeiten das Spielerfenster öffnen, Rechtsklick auf das Datum, bearbeiten und absenden"
    GRM_L["To confirm or edit the date, right click the date, edit, and submit"] = "Zum Bestätigen/Bearbeiten, Rechtsklick auf das Datum, bearbeiten und absenden"
    GRM_L["The {name} tag indicates a date must be verified to sync"] = "Der {name}-Tag zeigt an, dass ein Datum zum Synchronisieren bestätigt werden muss"

    -- 1.70
    GRM_L["GRM has errored due to a previous incompatible build with Classic that was enabled. Click YES to reload UI and fix the issue"] = "GRM-Fehler durch inkompatiblen Classic-Build. Klicke JA, um die UI neuzuladen und das Problem zu beheben"

    -- 1.71
    GRM_L["(Disabled in Classic)"] = "(In Classic deaktiviert)"

    -- 1.73
    GRM_L["{name} is no longer in the Guild!"] = "{name} ist nicht mehr in der Gilde!"
    GRM_L["is no longer in the Guild!"] = "ist nicht mehr in der Gilde!"
    GRM_L["Applying update patches... one moment."] = "Wende Update-Patches an... einen Moment."
    GRM_L["Update Complete... {num} patches applied."] = "Update abgeschlossen... {num} Patches angewendet."
    GRM_L["Update Complete... 1 patch applied."] = "Update abgeschlossen... 1 Patch angewendet."
    GRM_L["Disabling will also hide the Birthday info on the roster mouseover window"] = "Deaktivieren versteckt auch die Geburtstags-Infos im Roster-Tooltip"
    GRM_L["Confirm Date"] = "Datum bestätigen"
    GRM_L["If the date is accurate, right click and select 'Confirm Date'"] = "Wenn das Datum korrekt ist, rechtsklicke und wähle 'Datum bestätigen'"

        -- 1.74
    GRM_L["Class Colorize Names in Guild Member Alerts"] = "Namen in Gilden-Meldungen klassenfarbig markieren"
    GRM_L["All player custom notes re-enabled for sync and their checkboxes set."] = "Alle eigenen Notizen wieder für Sync aktiviert und Checkboxen gesetzt."

    -- 1.75
    GRM_L["!note"] = "!notiz"
    GRM_L["No officer online to set {name}'s note"] = "Kein Offizier online, um die Notiz von {name} zu setzen"
    GRM_L["No officer is currently online to update your note"] = "Kein Offizier ist online, um deine Notiz zu aktualisieren"
    GRM_L["Allow Guild Members to Type \"!note notehere\" to Set Their Own Public Note"] = "Mitgliedern erlauben, \"!notiz Text\" zu tippen, um ihre öffentliche Notiz zu setzen"
    GRM_L["Enabled"] = "Aktiviert"
    GRM_L["'!note' trigger has been globally ENABLED"] = "'!notiz'-Auslöser wurde global AKTIVIERT"
    GRM_L["'!note' trigger has been globally DISABLED"] = "'!notiz'-Auslöser wurde global DEAKTIVIERT"

    -- 1.76
    GRM_L["Same Rank"] = "Gleicher Rang"
    GRM_L["Higher Rank"] = "Höherer Rang"
    GRM_L["Limited Features. There is no Calendar in Classic"] = "Begrenzte Funktionen. Es gibt keinen Kalender in Classic."
    GRM_L["This only affects settings for your current guild: {name}"] = "Dies betrifft nur Einstellungen für deine aktuelle Gilde: {name}"
    GRM_L["GC"] = "GS"
    GRM_L["*GC = Global Control - Use Guild Info to Force Setting For All"] = "*GS = Globale Steuerung - Nutze Gildeninfo, um Einstellungen für alle zu erzwingen"
    GRM_L["Set Global Controls"] = "Globale Steuerung setzen"
    GRM_L["Global Control Values Set in Guild Info"] = "Globale Steuerungswerte in Gildeninfo gesetzt"
    GRM_L["Configure your settings. Click to set in Guild Info"] = "Einstellungen konfigurieren. Klicken, um in Gildeninfo zu setzen."
    GRM_L["Unable to add globals controls to GuildInfo. There is not enough room."] = "Globale Steuerung kann nicht zur Gildeninfo hinzugefügt werden. Nicht genug Platz."
    GRM_L["Global controls exported to the guild info note. Updating..."] = "Globale Steuerung in Gildeninfo exportiert. Aktualisiere..."
    GRM_L["Your rank cannot edit the Guild Info"] = "Dein Rang kann die Gildeninfo nicht bearbeiten"
    GRM_L["All global controls are already set. You must Edit or Remove the settings manually in the guild Info."] = "Alle globalen Steuerungen sind bereits gesetzt. Du musst sie manuell in der Gildeninfo bearbeiten/entfernen."
    GRM_L["Do you really want to wipe all GRM data and settings account-wide?"] = "Möchtest du wirklich alle GRM-Daten und Einstellungen accountweit löschen?"
    GRM_L["Are you sure your settings are configured and ready for global controls?"] = "Bist du sicher, dass deine Einstellungen für die globale Steuerung konfiguriert und bereit sind?"
    GRM_L["Players the same rank or higher will not be shown"] = "Spieler mit gleichem oder höherem Rang werden nicht angezeigt"
    GRM_L["Macro"] = "makro"

    -- 1.77
    GRM_L["Add Custom Rule"] = "Eigene Regel hinzufügen"
    GRM_L["Former Members"] = "Ehemalige Mitglieder"
    GRM_L["Data Export"] = "Datenexport"
    GRM_L["*Max Export is 500 Log Entries at a Time"] = "*Maximal 500 Log-Einträge auf einmal exportieren"
    GRM_L["*Max Export is 500 Members at a Time"] = "*Maximal 500 Mitglieder auf einmal exportieren"
    GRM_L["*Max Export is 500 Former Members at a Time"] = "*Maximal 500 ehemalige Mitglieder auf einmal exportieren"
    GRM_L["*Export obeys the current log display filters"] = "*Export beachtet die aktuellen Log-Filter"
    GRM_L["Select Line Range:"] = "Zeilenbereich auswählen:"
    GRM_L["Select Member Range:"] = "Mitgliederbereich auswählen:"
    GRM_L["Export Selection"] = "Auswahl exportieren"
    GRM_L["Export Next {num}"] = "Nächste {num} exportieren"
    GRM_L["Export Prev {num}"] = "Vorherige {num} exportieren"
    GRM_L["Total Members: {num}"] = "Mitglieder gesamt: {num}"
    GRM_L["Total Former Members: {num}"] = "Ehemalige gesamt: {num}"
    GRM_L["Class"] = "Klasse"
    GRM_L["Guild Rep"] = "Gildenruf"
    GRM_L["Last Online (Days)"] = "Zuletzt online (Tage)"
    GRM_L["Spreadsheet Headers"] = "Tabellen-Überschriften"
    GRM_L["Auto Include Headers"] = "Überschriften autom. einfügen"
    GRM_L["These will only be included if exporting from the top of the table"] = "Diese werden nur beim Export vom Anfang der Tabelle eingefügt"
    GRM_L["Export"] = "Export"
    GRM_L["This will be rounded to the nearest day"] = "Dies wird auf den nächsten Tag gerundet"
    GRM_L["Clearing Log Export. A filter setting has been changed."] = "Log-Export wird gelöscht. Eine Filter-Einstellung wurde geändert."
    GRM_L["No Tag"] = "Kein Tag"
    GRM_L["Delimiter:"] = "Trennzeichen:"
    GRM_L["The selected delimiter will be removed from all notes on export"] = "Das gewählte Trennzeichen wird beim Export aus allen Notizen entfernt"
    GRM_L["Choose thoughtfully"] = "Wähle mit Bedacht"
    GRM_L["{name}'s note has been updated!"] = "Die Notiz von {name} wurde aktualisiert!"
    GRM_L["Locked. Press ESC"] = "Gesperrt. Drücke ESC"
    GRM_L["|CFFE6CC7FClick|r to Select for Removal"] = "|CFFE6CC7FKlicken|r, um zum Entfernen auszuwählen"
    GRM_L["Feel free to recommend a delimiter you wish to use to the author"] = "Schlage dem Autor gerne ein Trennzeichen vor, das du verwenden möchtest"
    GRM_L["Export Tool"] = "Export-Werkzeug"
    GRM_L["Opens the Data Export Tool"] = "Öffnet das Datenexport-Werkzeug"
    GRM_L["Opens the Advanced Macro Tool"] = "Öffnet das erweiterte Makro-Werkzeug"

    -- 1.78
    GRM_L["Hurray!"] = "Hurra!"
    GRM_L["{name} has Reached the {num} Level Cap! {custom1}"] = "{name} hat die Max-Stufe {num} erreicht! {custom1}"

    -- 1.80
    GRM_L["Core Window:"] = "Hauptfenster:"
    GRM_L["Mouseover Player Details:"] = "Mouseover Spielerdetails:"
    GRM_L["Macro Tool:"] = "Makro-Werkzeug:"
    GRM_L["Export Tool:"] = "Export-Werkzeug:"
    GRM_L["Audit Join Date Tool:"] = "Beitrittsdatum-Prüfung:"
    GRM_L["Right-Click to Reset"] = "Rechtsklick zum Zurücksetzen"
    GRM_L["WARNING: Clear the text box before re-scaling or you may lock up your system"] = "ACHTUNG: Leere das Textfeld vor dem Skalieren, sonst könnte dein System einfrieren"
    GRM_L["Resets ALL settings, not just the ones on this page"] = "Setzt ALLE Einstellungen zurück, nicht nur die auf dieser Seite"
    GRM_L["Open MouseOver"] = "Mouseover öffnen"
    GRM_L["Open Macro Tool"] = "Makro-Werkzeug öffnen"
    GRM_L["Open Export Tool"] = "Export-Werkzeug öffnen"
    GRM_L["Open Join Date Tool"] = "Beitrittsdatum-Werkzeug öffnen"

    -- 1.81
    GRM_L["Race"] = "Volk"
    GRM_L["Sex"] = "Geschlecht"
    GRM_L["Male"] = "Männlich"
    GRM_L["Female"] = "Weiblich"
    GRM_L["{name} {name2}"] = "{name} {name2}" -- e.g. "Ork Männlich"

    -- 1.82
    GRM_L["Disabled While Player is Grouped"] = "Deaktiviert, während Spieler in Gruppe ist"
    GRM_L["SYNC is currently disabled while you are grouped. Due to server restricted addon to addon talk data caps, and in an effort to avoid clogging up the shared global comm space of all addons, sync will be temporarily restricted while grouped."] = "SYNC ist deaktiviert, während du in einer Gruppe bist. Aufgrund von Server-Datenlimits für Addon-Kommunikation wird die Synchronisation vorübergehend eingeschränkt, um den globalen Kommunikationskanal nicht zu überlasten."

    -- 1.84
    GRM_L["The note is too long. Only the first {num} characters will be set."] = "Die Notiz ist zu lang. Nur die ersten {num} Zeichen werden gesetzt."
    GRM_L["Apply Only to Selected Ranks"] = "Nur auf ausgewählte Ränge anwenden"
    GRM_L["Unable to create hotkey macro. Player is currently in combat and action is restricted. It will auto-build once out of combat."] = "Hotkey-Makro kann nicht erstellt werden. Spieler ist im Kampf. Es wird nach dem Kampf automatisch erstellt."
    GRM_L["No player data found, recommend full removal."] = "Keine Spielerdaten gefunden, vollständige Entfernung empfohlen."
    GRM_L["OR"] = "ODER"
    GRM_L["Use Promo Date"] = "Beförderungsdatum nutzen"
    GRM_L["Use Join Date"] = "Beitrittsdatum nutzen"
    GRM_L["Send to Promo Date"] = "An Beförderungsdatum senden"
    GRM_L["Send to Join Date"] = "An Beitrittsdatum senden"
    GRM_L["(Press Tab to Cycle)"] = "(Tab zum Wechseln)"
    GRM_L["(Press Enter to Select)"] = "(Enter zum Auswählen)"
    GRM_L["Setting join date to destination index {num} is not valid. Value must be between 0 and 3. Setting to default of Officer Note."] = "Zielindex {num} für Beitrittsdatum ungültig. Wert muss zwischen 0-3 liegen. Setze auf Standard Offiziersnotiz."
    GRM_L["Join Dates Globally Changed to no longer be added to the note when a player joins the guild"] = "Beitrittsdaten werden global nicht mehr zur Notiz bei Gildenbeitritt hinzugefügt."
    GRM_L["Your Guild Leader has disabled adding join dates to player notes"] = "Dein Gildenleiter hat das Hinzufügen von Beitrittsdaten zu Notizen deaktiviert."
    GRM_L["Unable to Modify. Global setting DISABLES adding the join date automatically. "] = "Änderung nicht möglich. Globale Einstellung DEAKTIVIERT das automatische Hinzufügen."
    GRM_L["General Sync"] = "Allgemeiner Sync"
    GRM_L["Ban Sync"] = "Bann-Sync"
    GRM_L["Custom Sync"] = "Eigener Sync"
    GRM_L["Auto Join date"] = "Autom. Beitrittsdatum"
    GRM_L["Include Headers"] = "Überschriften einfügen";
    GRM_L["Join Header"] = "Beitritts-Überschrift";
    GRM_L["ReJoin Header"] = "Wiederbeitritts-Überschrift";
    GRM_L["!note Control"] = "!notiz-Steuerung"
    GRM_L["You need to clear {num} characters to fit the control tags"] = "Du musst {num} Zeichen freimachen, um die Steuerungs-Tags unterzubringen."
    GRM_L["A new format exists for global settings controls."] = "Es gibt ein neues Format für globale Einstellungs-Steuerungen."
    GRM_L["Go to GRM window > Options > Officer Tab > \"Set Global Controls\""] = "Gehe zu GRM > Optionen > Offizier > \"Globale Steuerung setzen\""
    GRM_L["Remove the old format when all guildies have updated properly. You may wish to leave it in Guild Info until then."] = "Entferne das alte Format, wenn alle Mitglieder aktualisiert haben. Lasse es ggf. solange in der Gildeninfo."
    GRM_L["It may take up to 60 seconds for other guild members to detect the changes and update."] = "Es kann bis zu 60 Sekunden dauern, bis andere Mitglieder die Änderungen erkennen und aktualisieren."
    GRM_L["Resets only the settings on this page"] = "Setzt nur die Einstellungen auf dieser Seite zurück"
    GRM_L["Resets only the Export Settings"] = "Setzt nur die Export-Einstellungen zurück"
    GRM_L["Resets all Macro Tool Rules and Settings"] = "Setzt alle Makro-Werkzeug-Regeln und Einstellungen zurück"
    GRM_L["Are you sure you want to reset all Macro Tool Rules and Settings?"] = "Möchtest du wirklich alle Makro-Werkzeug-Regeln und Einstellungen zurücksetzen?"
    GRM_L["Export settings to unify sync controls, timestamp format, and so on with your officers and members."] = "Exportiere Einstellungen, um Sync-Steuerung, Zeitstempel-Format usw. mit Offizieren und Mitgliedern zu vereinheitlichen."
    GRM_L["Consult with your guild leader and export settings to unify sync controls, timestamp format, and so on."] = "Sprich mit deinem Gildenleiter und exportiere Einstellungen, um Sync-Steuerung, Zeitstempel-Format usw. zu vereinheitlichen."
    GRM_L["Global controls have not yet been set!"] = "Globale Steuerungen wurden noch nicht gesetzt!"
    GRM_L["Include Birthdays as Incomplete"] = "Geburtstage als unvollständig einstufen"
    GRM_L["Make room and transfer before clearing"] = "Platz schaffen und übertragen vor dem Löschen"
    GRM_L["1 player has a join date listed in the incorrect note."] = "1 Spieler hat ein Beitrittsdatum in der falschen Notiz."
    GRM_L["{num} players have join dates listed in the incorrect note."] = "{num} Spieler haben Beitrittsdaten in der falschen Notiz."
    GRM_L["Otherwise, {num} notes are ready to be cleared from the incorrect location"] = "Andernfalls können {num} Notizen vom falschen Ort entfernt werden."
    GRM_L["Otherwise, 1 note is ready to be cleared from the incorrect location"] = "Andernfalls kann 1 Notiz vom falschen Ort entfernt werden."
    GRM_L["There are currently {num} dates that can be added to the {name}"] = "Derzeit können {num} Daten zu {name} hinzugefügt werden."
    GRM_L["The previous action still has 1 recommended task. It is advised to do that first."] = "Die vorherige Aktion hat noch 1 empfohlene Aufgabe. Es wird geraten, diese zuerst zu erledigen."
    GRM_L["The previous action still has {num} recommended tasks. It is advised to do those first."] = "Die vorherige Aktion hat noch {num} empfohlene Aufgaben. Es wird geraten, diese zuerst zu erledigen."
    GRM_L["Step {num}"] = "Schritt {num}"

    -- 1.86
    GRM_L["What tags look like:"] = "So sehen die Tags aus:"
    GRM_L["Add Join Date to:"] = "Füge Beitrittsdatum hinzu:"

    -- R1.87
    GRM_L["|CFFE6CC7FLeft-Click|r to Disable Rule"] = "|CFFE6CC7FLinksklick|r, um Regel zu deaktivieren"
    GRM_L["|CFFE6CC7FLeft-Click|r to Enable Rule"] = "|CFFE6CC7FLinksklick|r, um Regel zu aktivieren"
    GRM_L["Edit"] = "Bearbeiten"
    GRM_L["|CFFE6CC7FClick|r to Change the Rule Name"] = "|CFFE6CC7FKlicken|r, um den Regelnamen zu ändern"
    GRM_L["Apply to All Ranks"] = "Auf alle Ränge anwenden"
    GRM_L["Please select at least 1 RANK to apply this rule to."] = "Bitte wähle mindestens 1 RANG aus, auf den diese Regel angewendet wird."
    GRM_L["Apply to All Levels"] = "Auf alle Level anwenden"
    GRM_L["Apply Only to Level Range"] = "Nur auf Levelbereich anwenden"
    GRM_L["Level Range:"] = "Levelbereich:"
    GRM_L["{num} to {custom1}"] = "{num} bis {custom1}"
    GRM_L["1 to {num}"] = "1 bis {num}"
    GRM_L["Require Text Match"] = "Nur mit Text-Match"
    GRM_L["Click to Set"] = "Klicken zum Setzen"
    GRM_L["Inactivity:"] = "Inaktivität:"
    GRM_L["Notify if inactive for {num} {name}" ] = "Melden, wenn inaktiv für {num} {name}"
    GRM_L["Rule Filter: {name}"] = "Regelfilter: {name}"
    GRM_L["Ranks:"] = "Ränge:"
    GRM_L["All Ranks"] = "Alle Ränge"
    GRM_L["Note Match:"] = "Notiz-Übereinstimmung:"
    GRM_L["Please Set a Name for this Rule. It can be 1 to 30 characters in length."] = "Bitte gib einen Namen für diese Regel ein (1-30 Zeichen)."
    GRM_L["This will also clear all of your saved rules."] = "Dies wird auch alle deine gespeicherten Regeln löschen."
    GRM_L["Within Level Range: {num} - {custom1}"] = "Innerhalb Levelbereich: {num} - {custom1}"
    GRM_L["Note match: {name}"] = "Notiz-Übereinstimmung: {name}"
    GRM_L["Matching Rank"] = "Passender Rang"
    GRM_L["Right-Click|r to Edit or Remove custom rule"] = "Rechtsklick|r, um Regel zu bearbeiten/entfernen"
    GRM_L["(Applies Only to Classic)"] = "(Gilt nur für Classic)"

    -- R1.88
    -- Group Info Module
    GRM_L["GRM Info"] = "GRM-Info"
    GRM_L["GRM Group Info"] = "GRM-Gruppeninfo"
    GRM_L["Group Info"] = "Gruppeninfo"
    GRM_L["Click to Lock Info Window"] = "Klicken, um Infofenster zu sperren"
    GRM_L["Guildies: {num}"] = "Gildies: {num}"
    GRM_L["Former Guildies: {num}"] = "Ehemalige: {num}"
    GRM_L["Other {name} Members: {num}"] = "Andere {name}-Mitglieder: {num}"
    GRM_L["Total in Group: {num}"] = "Gesamt in Gruppe: {num}"
    GRM_L["Date Left"] = "Austrittsdatum"
    GRM_L["1 Alt Still in Guild"] = "1 Twink noch in der Gilde"
    GRM_L["{num} Alts Still in Guild"] = "{num} Twinks noch in der Gilde"
    GRM_L["Known Alts:"] = "Bekannte Twinks:"
    GRM_L["Close Enough to Trade"] = "Nah genug zum Handeln"
    GRM_L["Plugins"] = "Plugins"
    GRM_L["Plugin"] = "Plugin"
    GRM_L["Module"] = "Modul"
    GRM_L["GRM Optional Modules"] = "Optionale GRM-Module"
    GRM_L["Enable Module"] = "Modul aktivieren"
    GRM_L["Show Interactable Distance Indicator"] = "Interaktions-Entfernungsanzeige zeigen"
    GRM_L["No GRM Modules Currently Installed"] = "Keine GRM-Module derzeit installiert"
    GRM_L["Custom Color"] = "Eigene Farbe"
    GRM_L["{name} is listed as the Main"] = "{name} ist als Main eingetragen"
    GRM_L["Kick Banned in Guild"] = "Gebannte in Gilde kicken"
    GRM_L["Kick macro created. Press Hotkey to Remove Banned Players Still in Guild"] = "Kick-Makro erstellt. Drücke Hotkey, um gebannte Spieler zu entfernen."
    GRM_L["Easily remove all Banned players still in the Guild with the Macro Tool"] = "Entferne einfach alle gebannten Spieler mit dem Makro-Werkzeug."
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you remove all custom channels."] = "GRM sendet Nachrichten an \"{name}\", wenn du alle eigenen Kanäle entfernst."
    GRM_L["Multi-Channel support. Just separate with commas"] = "Multi-Kanal-Unterstützung. Einfach mit Kommas trennen."
    GRM_L["Disable tooltip. Only show popout window."] = "Tooltip deaktivieren. Nur Popout-Fenster anzeigen."

    -- R1.89 (Already one translated, here's the other)
    GRM_L["GRM API Error:"] = "GRM API-Fehler:"
    GRM_L["The guild name \"{name}\" cannot be found in the database. Ensure proper formatting."] = "Gildenname \"{name}\" nicht in Datenbank gefunden. Achte auf das Format."
    GRM_L["The player name \"{name}\" cannot be found in the database. Ensure proper spelling."] = "Spielername \"{name}\" nicht in Datenbank gefunden. Achte auf die Schreibweise."
    GRM_L["Unable to change officer notes at current rank"] = "Kann Offiziersnotizen mit aktuellem Rang nicht ändern"
    GRM_L["Mains Only"] = "Nur Mains"
    GRM_L["Alts Only"] = "Nur Twinks"
    GRM_L["Custom Public Notes:"] = "Eigene öffentliche Notizen:"
    GRM_L["Leave unchecked to export every member of the guild"] = "Leer lassen, um jedes Mitglied zu exportieren"
    GRM_L["Only the 10 most recent rank changes will be included"] = "Nur die 10 neuesten Rangänderungen werden einbezogen"
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} 1 time to complete all actions"] = "Wenn du bereit bist, die Spieler zu entfernen, drücke den Hotkey {name} 1 Mal"
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} {num} times to complete all actions"] = "Wenn du bereit bist, die Spieler zu entfernen, drücke den Hotkey {name} {num} Mal"
    GRM_L["This only affects GRM tooltips"] = "Dies betrifft nur GRM-Tooltips"
    GRM_L["Unable to remove players from the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler aus der Gilde entfernen."
    GRM_L["Unable to promote players within the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler befördern."
    GRM_L["Unable to demote players within the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler degradieren."
    GRM_L["Feature disabled."] = "Funktion deaktiviert."
    GRM_L["This only applies to Alt/Main Groupings, Join Dates, Promotion Dates, Birthdates, and Custom Notes."] = "Gilt nur für Twink/Main-Gruppen, Beitritts-/Beförderungsdaten, Geburtstage und eigene Notizen."
    GRM_L["Custom Notes can be Restricted Further Below"] = "Eigene Notizen können unten weiter eingeschränkt werden"
    GRM_L["All ranks will receive the outgoing player data. Only players of the selected rank or higher can modify and share that data."] = "Alle Ränge erhalten die Daten. Nur Spieler des gewählten Rangs oder höher können sie ändern und teilen."
    GRM_L["Always open to selected tab:"] = "Immer mit diesem Tab öffnen:"
    GRM_L["{num} guild members have incomplete info."] = "{num} Gildenmitglieder haben unvollständige Infos."
    GRM_L["Just 1 guild member still has incomplete info. Great job!"] = "Nur noch 1 Gildenmitglied mit unvollständigen Infos. Super!"
    GRM_L["No Audit Necessary! Great Work!"] = "Keine Prüfung nötig! Tolle Arbeit!"
    GRM_L["GRM Audit Report:"] = "GRM Prüfungsbericht:"
    GRM_L["100% complete. Great work!"] = "100% vollständig. Tolle Arbeit!"
    GRM_L["{num}% complete."] = "{num}% vollständig."
    GRM_L["Only 1 member with incomplete data."] = "Nur 1 Mitglied mit unvollständigen Daten."
    GRM_L["{num} members with incomplete data."] = "{num} Mitglieder mit unvollständigen Daten."
    GRM_L["Colorize Names in Chat Window to Match Class"] = "Namen im Chatfenster klassenfarbig markieren"
    GRM_L["Only Match Empty Notes"] = "Nur leere Notizen abgleichen"
    -- macro Tool
    GRM_L["Empty Note match: {name}"] = "Leere Notiz-Übereinstimmung: {name}"
    GRM_L["Empty Notes"] = "Leere Notizen"
    GRM_L["Public"] = "Öffentlich"
    GRM_L["Custom"] = "Eigene"
    GRM_L["Apply Rules to:"] = "Regeln anwenden auf:"
    GRM_L["All"] = "Alle"
    GRM_L["Player is an Alt"] = "Spieler ist ein Twink"
    GRM_L["Player is a Main"] = "Spieler ist ein Main"
    GRM_L["This only applies to KNOWN alts. Unconfigured will be excluded."] = "Gilt nur für BEKANNTE Twinks. Nicht konfigurierte werden ignoriert."
    GRM_L["Main/Alt: {name}"] = "Main/Twink: {name}"
    GRM_L["Kick Players at Selected Rank(s) after"] = "Spieler auf Rang(s) kicken nach"
    GRM_L["Use Cautiously. Applies to all at rank, regardless of being active or inactive."] = "Vorsichtig verwenden. Gilt für alle auf dem Rang, egal ob aktiv oder inaktiv."
    GRM_L["This will only apply to players with verified promotion dates."] = "Gilt nur für Spieler mit bestätigtem Beförderungsdatum."
    GRM_L["Time at Rank: {name}"] = "Zeit auf Rang: {name}"
    GRM_L["Notify if at Rank for {num} {name}"] = "Melden, wenn auf Rang für {num} {name}"
    GRM_L["Player Guild Rep is"] = "Gildenruf des Spielers ist"
    GRM_L["|CFFE6CC7FClick|r to Change Rep"] = "|CFFE6CC7FKlicken|r, um Ruf zu ändern"
    GRM_L["Guild Rep:"] = "Gildenruf:"
    GRM_L["Guild Rep lower than {name}"] = "Gildenruf niedriger als {name}"
    GRM_L["Guild Rep equal to {name}"] = "Gildenruf gleich {name}"
    GRM_L["Guild Rep higher than {name}"] = "Gildenruf höher als {name}"
    GRM_L["Rep: {name} - {name2}"] = "Ruf: {name} - {name2}"
    GRM_L["Custom Log Entry Message"] = "Eigene Log-Eintrag-Nachricht"
    GRM_L["Press ENTER to Save"] = "ENTER zum Speichern"
    GRM_L["{name} matches {num} macro tool rules. Kick Recommended!"] = "{name} passt zu {num} Makro-Regeln. Kick empfohlen!"
    GRM_L["{name} matches {num} macro tool rule. Kick Recommended!"] = "{name} passt zu 1 Makro-Regel. Kick empfohlen!"
    -- Classic Only
    GRM_L["Shift Rank Up"] = "Rang hochstufen"
    GRM_L["The Guild Rank \"{name}\" has Shifted up from rank {num} to {custom1}"] = "Gildenrang \"{name}\" wurde von Rang {num} auf {custom1} hochgestuft"
    GRM_L["The Guild Rank \"{name}\" has Shifted lower from rank {num} to {custom1}"] = "Gildenrang \"{name}\" wurde von Rang {num} auf {custom1} runtergestuft"
    GRM_L["After shifting the rank up by 1, the window will automatically close"] = "Nach dem Hochstufen um 1 schließt sich das Fenster automatisch"
    GRM_L["After shifting the down by 1, the window will automatically close"] = "Nach dem Runterstufen um 1 schließt sich das Fenster automatisch"
    GRM_L["Addon restrictions require manual selection of guild rank"] = "Addon-Einschränkungen erfordern manuelle Rangauswahl"
    GRM_L["Shift Rank Down"] = "Rang runterstufen"

    -- R1.90
    GRM_L["GRM WARNING!!! FAILURE TO LOAD THIS KEY: {name}\nPLEASE REPORT TO ADDON DEV! THANK YOU!"] = "GRM WARNUNG!!! FEHLER BEIM LADEN DES KEYS: {name}\nBITTE DEM ADDON-ENTWICKLER MELDEN! DANKE!"
    GRM_L["Sync is disabled for {num} seconds after logging in. Please wait {custom1} seconds longer."] = "Sync ist für {num} Sekunden nach dem Login deaktiviert. Bitte warte noch {custom1} Sekunden."
    GRM_L["Type '/grm sync' to initiate a one-time sync."] = "Tippe '/grm sync' für eine einmalige Synchronisation."
    -- Due to language differences on the edit box, this is to explain where to put the edit box. In English it will appear: "Auto Trigger Sync [ 30 ] Seconds After Logging On" - Please place the edit box in the appropriate position for your translation.
    GRM_L["Before Auto Trigger"] = "Sync automatisch starten"
    GRM_L["After Auto Trigger"] = "Sekunden nach dem Einloggen"
    GRM_L["Report When Other Members Have Outdated Versions"] = "Melden, wenn andere Mitglieder veraltete Versionen haben"

    -- Macro Tool update promote/demote
    -- R1.92
    GRM_L["Inactive"] = "Inaktiv"
    GRM_L["Promote Player if at Rank for"] = "Spieler befördern, wenn auf Rang für"
    GRM_L["Demote Player if Inactive for"] = "Spieler degradieren, wenn inaktiv für"
    GRM_L["Apply Promotions Regardless of Activity"] = "Beförderungen unabhängig von Aktivität anwenden"
    GRM_L["Apply Only to Active Players"] = "Nur auf aktive Spieler anwenden"
    GRM_L["Player is considered inactive if offline for"] = "Spieler gilt als inaktiv, wenn offline für"
    GRM_L["Ignore inactivity if at least one player linked alt is active"] = "Inaktivität ignorieren, wenn mind. ein Twink aktiv ist"
    GRM_L["Promote to Rank:"] = "Befördern zu Rang:"
    GRM_L["Demote to Rank:"] = "Degradieren zu Rang:"
    GRM_L["Only recommend to Demote if all player linked alts exceed max time"] = "Degradierung nur empfehlen, wenn alle Twinks die max. Zeit überschreiten"
    GRM_L["Unable to promote players to this rank"] = "Spieler können nicht auf diesen Rang befördert werden"
    GRM_L["Unable to demote players to this rank"] = "Spieler können nicht auf diesen Rang degradiert werden"
    GRM_L["Unable to promote players at this rank."] = "Spieler auf diesem Rang können nicht befördert werden."
    GRM_L["Unable to demote players from this rank."] = "Spieler auf diesem Rang können nicht degradiert werden."
    GRM_L["Unable to kick players at this rank"] = "Spieler auf diesem Rang können nicht gekickt werden"
    GRM_L["Unable to promote players at this rank to \"{name}\""] = "Spieler auf diesem Rang können nicht zu \"{name}\" befördert werden"
    GRM_L["Unable to demote players at this rank to \"{name}\""] = "Spieler auf diesem Rang können nicht zu \"{name}\" degradiert werden"
    GRM_L["Disable chat log spam while using the Macro Tool"] = "Chat-Spam bei Nutzung des Makro-Werkzeugs deaktivieren"
    GRM_L["When you are ready to Promote the player, press the Hot-Key {name} 1 time to complete all actions"] = "Wenn du bereit bist, den Spieler zu befördern, drücke den Hotkey {name} 1 Mal"
    GRM_L["When you are ready to Demote the player, press the Hot-Key {name} 1 time to complete all actions"] = "Wenn du bereit bist, den Spieler zu degradieren, drücke den Hotkey {name} 1 Mal"
    GRM_L["When you are ready to Promote the players, press the Hot-Key {name} {num} times to complete all actions"] = "Wenn du bereit bist, die Spieler zu befördern, drücke den Hotkey {name} {num} Mal"
    GRM_L["When you are ready to Demote the players, press the Hot-Key {name} {num} times to complete all actions"] = "Wenn du bereit bist, die Spieler zu degradieren, drücke den Hotkey {name} {num} Mal"

    -- Mouseover tooltip on the macro button on the roster
    GRM_L["Players to Kick:"] = "Spieler zum Kicken:"
    GRM_L["Players to Promote:"] = "Spieler zum Befördern:"
    GRM_L["Players to Demote:"] = "Spieler zum Degradieren:"

    GRM_L["Hello {custom1}"] = "Hallo {custom1}"

    -- Consideration for plural/singular
    GRM_L["Player has been at rank for more than {num} Day"] = "Spieler ist seit mehr als {num} Tag auf dem Rang"
    GRM_L["Player has been at rank for more than {num} Days"] = "Spieler ist seit mehr als {num} Tagen auf dem Rang"
    GRM_L["Player has been at rank for more than {num} Month"] = "Spieler ist seit mehr als {num} Monat auf dem Rang"
    GRM_L["Player has been at rank for more than {num} Months"] = "Spieler ist seit mehr als {num} Monaten auf dem Rang"

    -- Promote?Demote tooltup updates on the rules
    GRM_L["Destination Rank:"] = "Zielrang:"
    GRM_L["# Moves:"] = "Stufen:"
    GRM_L["Notify if at current rank for {num} {name}" ] = "Melden, wenn auf Rang für {num} {name}"

    -- Macro Tool Log reporting
    GRM_L["{name} matches {num} macro tool rules. Promotion Recommended!"] = "{name} passt zu {num} Makro-Regeln. Beförderung empfohlen!"
    GRM_L["{name} matches {num} macro tool rule. Promotion Recommended!"] = "{name} passt zu 1 Makro-Regel. Beförderung empfohlen!"
    GRM_L["{name} matches {num} macro tool rules. Demotion Recommended!"] = "{name} passt zu {num} Makro-Regeln. Degradierung empfohlen!"
    GRM_L["{name} matches {num} macro tool rule. Demotion Recommended!"] = "{name} passt zu 1 Makro-Regel. Degradierung empfohlen!"

    -- 1.921
    GRM_L["Click"] = "Klick"
    GRM_L["Ctrl-Click"] = "Strg-Klick"
    GRM_L["Alt-Click"] = "Alt-Klick"
    GRM_L["Shift-Click"] = "Shift-Klick"
    GRM_L["Ctrl-Shift-Click"] = "Strg-Shift-Klick"
    GRM_L["Alt-Shiift-Click"] = "Alt-Shift-Klick"
    GRM_L["Right-Click"] = "Rechtsklick"
    GRM_L["Ctrl-Left-Click"] = "Strg-Linksklick"

    GRM_L["{custom1} to add player to all 3 macro tool ignore lists" ] = "{custom1}, um Spieler zu allen 3 Makro-Ignorier-Listen hinzuzufügen"
    GRM_L["{custom1} to remove player from all 3 macro tool ignore lists"] = "{custom1}, um Spieler von allen 3 Makro-Ignorier-Listen zu entfernen"
    GRM_L["{custom1} to push ignore list settings to {name}'s alts"] = "{custom1}, um Ignorier-Einstellungen auf die Twinks von {name} zu übertragen"
    GRM_L["Type \"{name} {name2}\" to Bring Up Macro Tool. {custom1} also work."] = "Tippe \"{name} {name2}\", um das Makro-Werkzeug zu öffnen. {custom1} funktionieren auch."
    GRM_L["Kick Rules"] = "Kick-Regeln"
    GRM_L["Promote Rules"] = "Beförderungs-Regeln"
    GRM_L["Demote Rules"] = "Degradierungs-Regeln"
    GRM_L["Macro Rule Ignore Lists"] = "Makro-Regel Ignorier-Listen"
    GRM_L["Select categories you wish the player to be ignored"] = "Wähle Kategorien, in denen der Spieler ignoriert werden soll"
    GRM_L["Ignoring"] = "Ignoriert"
    GRM_L["Monitoring"] = "Überwacht"
    GRM_L["Macro Rules"] = "Makro-Regeln"
    GRM_L["{name}'s alts now share the same macro rule ignore settings."] = "Die Twinks von {name} teilen nun dieselben Makro-Regel Ignorier-Einstellungen."
    GRM_L["{name} or Press ESC"] = "{name} oder drücke ESC"
    GRM_L["Please choose a day between {num} and {custom1}"] = "Bitte wähle einen Tag zwischen {num} und {custom1}"
    GRM_L["Reactivate monitoring after {num} days."] = "Überwachung nach {num} Tagen reaktivieren."
    GRM_L["Set Days:"] = "Tage festlegen:"
    GRM_L["Configured: {custom1}"] = "Konfiguriert: {custom1}"
    GRM_L["Time Left: {custom1}"] = "Verbleibende Zeit: {custom1}"
    GRM_L["{name} is now being monitored by the kick macro rules after being on the ignore list for {num} days."] = "{name} wird nach {num} Tagen auf der Ignorier-Liste nun von den Kick-Makro-Regeln überwacht."
    GRM_L["{name} is now being monitored by the promote macro rules after being on the ignore list for {num} days."] = "{name} wird nach {num} Tagen auf der Ignorier-Liste nun von den Beförderungs-Makro-Regeln überwacht."
    GRM_L["{name} is now being monitored by the demote macro rules after being on the ignore list for {num} days."] = "{name} wird nach {num} Tagen auf der Ignorier-Liste nun von den Degradierungs-Makro-Regeln überwacht."
    GRM_L["WARNING! Unchecking this setting will reset the timer upon re-enabling."] = "WARNUNG! Deaktivieren dieser Einstellung setzt den Timer beim Reaktivieren zurück."
    GRM_L["Year"] = "Jahr"
    GRM_L["Years"] = "Jahre"
    GRM_L["This note will appear with the log notification when a player meets this rule's conditions."] = "Diese Notiz erscheint mit der Log-Meldung, wenn ein Spieler die Regelbedingungen erfüllt."
    GRM_L["Due to limitations with macros a player can only move 1 rank at a time."] = "Aufgrund von Makro-Einschränkungen kann ein Spieler nur 1 Rang auf einmal verschoben werden."
    GRM_L["Disabled at Current Rank"] = "Auf aktuellem Rang deaktiviert"

    -- 1.922
    GRM_L["Verifying Macro Changes. One moment."] = "Überprüfe Makro-Änderungen. Einen Moment."
    GRM_L["Not all macro changes validated. One moment..."] = "Nicht alle Makro-Änderungen validiert. Einen Moment..."
    GRM_L["Macro rank changes have been validated!"] = "Makro-Rangänderungen wurden validiert!"
    GRM_L["Warning! Macro changes were not able to be validated. Please verify expected results before using the macro tool further."] = "Warnung! Makro-Änderungen konnten nicht validiert werden. Bitte überprüfe die Ergebnisse, bevor du fortfährst."

    -- 1.93 (and onward to the end)
    GRM_L["Customize Color"] = "Farbe anpassen"
    GRM_L["Officer Only Access"] = "Nur für Offiziere"
    GRM_L["Player no longer has officer access. Advanced Join Date Tool has been closed."] = "Spieler hat keinen Offiziers-Zugriff mehr. Erweitertes Beitrittsdatum-Werkzeug geschlossen."
    GRM_L["{custom1} to open Player Window"] = "{custom1}, um Spielerfenster zu öffnen"
    GRM_L["{custom1} for Additional Options"] = "{custom1} für zusätzliche Optionen"
    GRM_L["Unable to notify yourself if you go offline."] = "Du kannst dich nicht selbst benachrichtigen, wenn du offline gehst."
    GRM_L["{custom1} to sync join date among all alts in grouping."] = "{custom1}, um Beitrittsdatum für alle Twinks der Gruppe zu synchronisieren."
    GRM_L["Total Patch Time:"] = "Gesamte Patch-Zeit:"
    GRM_L["Do you really want to import the join date for the selected player?"] = "Möchtest du das Beitrittsdatum für den ausgewählten Spieler wirklich importieren?"
    GRM_L["Do you really want to import the join date for the {num} selected players?"] = "Möchtest du das Beitrittsdatum für die {num} ausgewählten Spieler wirklich importieren?"
    GRM_L["Do you really want to import the join date for 1 player?"] = "Möchtest du das Beitrittsdatum für 1 Spieler wirklich importieren?"
    GRM_L["Do you really want to import the join date for {num} players?"] = "Möchtest du das Beitrittsdatum für {num} Spieler wirklich importieren?"
    GRM_L["Dates to be imported: {num}"] = "Zu importierende Daten: {num}"
    GRM_L["{num} join dates have not been imported yet! Do that first!"] = "{num} Beitrittsdaten wurden noch nicht importiert! Mach das zuerst!"
    GRM_L["1 player's join date has not been imported yet! Do that first!"] = "Das Beitrittsdatum von 1 Spieler wurde noch nicht importiert! Mach das zuerst!"
    GRM_L["It is recommended to follow the steps in order"] = "Es wird empfohlen, die Schritte in der richtigen Reihenfolge zu befolgen."
    GRM_L["It's {name}'s Birthday today!!!"] = "{name} hat heute Geburtstag!!!"
    GRM_L["Announce if Player's Birthday when they Login."] = "Geburtstag des Spielers beim Login ankündigen."
    GRM_L["Happy Birthday, {name}!"] = "Alles Gute zum Geburtstag, {name}!"
    GRM_L["This event has not yet been added to the calender. Are you sure?"] = "Dieses Ereignis wurde noch nicht zum Kalender hinzugefügt. Sicher?"
    GRM_L["{num} events have not yet been added to the calendar. Are you sure?"] = "{num} Ereignisse wurden noch nicht zum Kalender hinzugefügt. Sicher?"
    GRM_L["There are no events listed here to remove."] = "Hier sind keine Ereignisse zum Entfernen aufgelistet."
    GRM_L["All events have been removed."] = "Alle Ereignisse wurden entfernt."
    GRM_L["Ignore All Events"] = "Alle Ereignisse ignorieren"
    GRM_L["Day:"] = "Tag:"
    GRM_L["Copy"] = "Kopieren"
    GRM_L["There are {num} players in your guild on dead accounts."] = "Es gibt {num} Spieler in deiner Gilde mit toten Accounts."
    GRM_L["There is 1 player in your guild on a dead account."] = "Es gibt 1 Spieler in deiner Gilde mit einem toten Account."
    GRM_L["Click CONFIRM to review the names, IGNORE to remove this pop-up permanently, or CANCEL to be reminded next session."] = "Klicke BESTÄTIGEN, um die Namen zu prüfen, IGNORIEREN, um das Pop-up dauerhaft zu entfernen, oder ABBRECHEN für eine Erinnerung."
    GRM_L["Would you like to remove them?"] = "Möchtest du sie entfernen?"
    GRM_L["You can re-check in the future by typing '/grm dead'"] = "Du kannst zukünftig mit '/grm tot' erneut prüfen."
    GRM_L["Ignore"] = "Ignorieren"
    GRM_L["Dead Account"] = "Toter Account"
    GRM_L["Kicking {name}'s alts"] = "Kicke die Twinks von {name}"
    GRM_L["Kicking Banned Player"] = "Kicke gebannten Spieler"
    GRM_L["Open any GRM window: {name}, {name2}, {custom1}, etc."] = "Öffne ein GRM-Fenster: {name}, {name2}, {custom1}, etc."
    GRM_L["Does a one-time check for dead accounts"] = "Einmalige Prüfung auf tote Accounts"
    GRM_L["Dead player accounts found: {num}"] = "Tote Spieler-Accounts gefunden: {num}"
    GRM_L["Rule Sync Enabled"] = "Regel-Sync aktiviert"
    GRM_L["Rule Sync Disabled"] = "Regel-Sync deaktiviert"
    GRM_L["Created By: {name}"] = "Erstellt von: {name}"
    GRM_L["{name}'s Kick Rule {num}"] = "Kick-Regel {num} von {name}"
    GRM_L["{name}'s Promote Rule {num}"] = "Beförderungs-Regel {num} von {name}"
    GRM_L["{name}'s Demote Rule {num}"] = "Degradierungs-Regel {num} von {name}"
    GRM_L["Kick Rule {num}"] = "Kick-Regel {num}"
    GRM_L["Sync: {name}"] = "Sync: {name}"
    GRM_L["Macro Rules Sync Result:"] = "Ergebnis Makro-Regel-Sync:"
    GRM_L["Kick Rules Added: {num}"] = "Kick-Regeln hinzugefügt: {num}"
    GRM_L["Kick Rules Removed: {num}"] = "Kick-Regeln entfernt: {num}"
    GRM_L["Promote Rules Added: {num}"] = "Beförderungs-Regeln hinzugefügt: {num}"
    GRM_L["Promote Rules Removed: {num}"] = "Beförderungs-Regeln entfernt: {num}"
    GRM_L["Demote Rules Added: {num}"] = "Degradierungs-Regeln hinzugefügt: {num}"
    GRM_L["Demote Rules Removed: {num}"] = "Degradierungs-Regeln entfernt: {num}"
    GRM_L["Macro Rule Sync:"] = "Makro-Regel-Sync:"
    GRM_L["Kick Rule \"{name}\" Removed by {name2}"] = "Kick-Regel \"{name}\" von {name2} entfernt"
    GRM_L["Promote Rule \"{name}\" Removed by {name2}"] = "Beförderungs-Regel \"{name}\" von {name2} entfernt"
    GRM_L["Demote Rule \"{name}\" Removed by {name2}"] = "Degradierungs-Regel \"{name}\" von {name2} entfernt"
    GRM_L["Reject"] = "Ablehnen"
    GRM_L["Player Search"] = "Spielersuche"
    GRM_L["Search to find a player quicker"] = "Suchen, um einen Spieler schneller zu finden"
    GRM_L["dead"] = "tot"
    GRM_L["deadnames"] = "totechars"
    GRM_L["TabName"] = "Tab-Name"
    GRM_L["Add unique player GUID to chat window to copy"] = "Einzigartige Spieler-GUID zum Kopieren ins Chatfenster einfügen"
    GRM_L["Achievement Announce"] = ACHIEVEMENT
    GRM_L["Only Guild Members with GRM installed will see."] = "Nur Gildenmitglieder mit installiertem GRM werden dies sehen."

    -- R1.935
    GRM_L["Search"] = "Suchen" -- This is the global string for "Search"

    -- R1.936
    GRM_L["Use '{name} search PlayerName' to also find guild members"] = "Nutze '{name} suche Spielername', um auch Gildenmitglieder zu finden"
    GRM_L["{custom1} to Copy Name to Chat"] = "{custom1}, um Namen in den Chat zu kopieren"

    -- R1.944
    GRM_L["Promote Player if in Guild for"] = "Spieler befördern, wenn in Gilde für"
    GRM_L["Time in Guild: {name}"] = "Zeit in Gilde: {name}"
    GRM_L["Time in Guild:"] = "Zeit in Gilde:"
    GRM_L["Notify if a member for at least {num} {name}"] = "Melden, wenn Mitglied für mind. {num} {name}"
    GRM_L["Player has been a member for more than {num} Day"] = "Spieler ist seit mehr als {num} Tag Mitglied"
    GRM_L["Player has been a member for more than {num} Days"] = "Spieler ist seit mehr als {num} Tagen Mitglied"
    GRM_L["Player has been a member for more than {num} Month"] = "Spieler ist seit mehr als {num} Monat Mitglied"
    GRM_L["Player has been a member for more than {num} Months"] = "Spieler ist seit mehr als {num} Monaten Mitglied"
    GRM_L["Ignore Rule With Text Match"] = "Bei Text-Match ignorieren"
    GRM_L["This only searches the officer note for the safe tag"] = "Dies durchsucht nur die Offiziersnotiz nach dem Schutz-Tag"
    GRM_L["Examples of simple tags:"] = "Beispiele für einfache Tags:"
    GRM_L["Do Not Kick" ] = "Nicht kicken"
    GRM_L["[S]"] = "[S]"  -- "S" für "Sicher" ist passend
    GRM_L["Safe"] = "Sicher"
    GRM_L["Must be an exact match"] = "Muss exakt übereinstimmen"
    GRM_L["No safe tag '{name}' in officer note"] = "Kein Schutz-Tag '{name}' in Offiziersnotiz"
    GRM_L["Safe Text Match:"] = "Schutz-Text-Übereinstimmung:"

    -- R1.946
    GRM_L["GRM Tools" ] = "GRM-Werkzeuge"
    GRM_L["Style Choices:"] = "Stil-Optionen:"
    GRM_L["Applies only to date format used for note"] = "Gilt nur für das Datumsformat in der Notiz"

    -- R1.947
    GRM_L["Currently syncing with {name}. Please wait until after sync completes to activate again."] = "Synchronisiere mit {name}. Bitte warten, bis der Sync fertig ist, um erneut zu aktivieren."
    GRM_L["Be Informed When GRM is out of date."] = "Informiert werden, wenn GRM veraltet ist."
    GRM_L["This only reports to chat once per session."] = "Dies wird nur einmal pro Sitzung im Chat gemeldet."
    GRM_L["Player GUID"] = "Spieler-GUID"
    GRM_L["Remove Alt-Code Letters From Names"] = "Alt-Code-Buchstaben aus Namen entfernen"
    GRM_L["Only Show Players Currently Online"] = "Nur online befindliche Spieler anzeigen"
    GRM_L["{name} matches rules for a promotion and is currently online."] = "{name} erfüllt die Regeln für eine Beförderung und ist online."
    GRM_L["{name} matches rules for a demotion and is currently online."] = "{name} erfüllt die Regeln für eine Degradierung und ist online."
    GRM_L["Please choose a valid Month"] = "Bitte wähle einen gültigen Monat"
    GRM_L["Warcraft was not released until 2004. Please choose a valid year."] = "Warcraft wurde erst 2004 veröffentlicht. Bitte wähle ein gültiges Jahr."

    --R1.953
    GRM_L["{name} has rejoined their original alt group."] = "{name} ist seiner ursprünglichen Twink-Gruppe wieder beigetreten."

    --R1.96
    GRM_L["Not Currentlly Syncing"] = "Synchronisiert derzeit nicht";
    GRM_L["Sync with {name} Successful"] = "Sync mit {name} erfolgreich"
    GRM_L["Sync failed at this point:"] = "Sync an diesem Punkt fehlgeschlagen:"
    GRM_L["Sync with {name} next."] = "Als Nächstes mit {name} synchronisieren."
    GRM_L["Sync is Currently Disabled"] = "Sync ist derzeit deaktiviert"
    GRM_L["Sync has failed..."] = "Sync fehlgeschlagen..."
    GRM_L["Start Sync"] = "Sync starten"
    GRM_L["Initializing Sync"] = "Initialisiere Sync"
    GRM_L["Initializing Sync. One Moment..."] = "Initialisiere Sync. Einen Moment..."
    GRM_L["No Member is Available to Sync"] = "Kein Mitglied zum Synchronisieren verfügbar"
    GRM_L["Outgoing Ban Data Restricted"] = "Ausgehende Bann-Daten eingeschränkt"
    GRM_L["Incoming Ban Data Restricted"] = "Eingehende Bann-Daten eingeschränkt"
    GRM_L["Sync Ok, but their rank is too low to make changes."] = "Sync Ok, aber ihr Rang ist zu niedrig für Änderungen."
    GRM_L["Sync Ok, but your rank is too low to sync your changes."] = "Sync Ok, aber dein Rang ist zu niedrig für Änderungen."
    GRM_L["Their Rank is too Low. All data is restricted."] = "Ihr Rang ist zu niedrig. Alle Daten sind eingeschränkt."
    GRM_L["Your Rank is too Low. Player is restricting all data."] = "Dein Rang ist zu niedrig. Spieler schränkt alle Daten ein."
    GRM_L["Sync is Currently Disabled. Do you wish to re-enable?"] = "Sync ist deaktiviert. Möchtest du ihn reaktivieren?"
    GRM_L["SYNC DATA"] = "DATEN SYNCRONISIEREN"
    GRM_L["Players"] = "Spieler"
    GRM_L["Bans"] = "Banns"
    GRM_L["Details"] = "Details"
    GRM_L["Syncing all player data."] = "Synchronisiere alle Spielerdaten."
    GRM_L["Syncing all data except ban list. Player rank is too low."] = "Synchronisiere alle Daten außer Bannliste. Rang des Spielers zu niedrig."
    GRM_L["Syncing all data except ban list. Your rank is too low."] = "Synchronisiere alle Daten außer Bannliste. Dein Rang ist zu niedrig."
    GRM_L["Currently Syncing With: {name}"] = "Synchronisiere derzeit mit: {name}"
    GRM_L["Sync has begun after waiting in queue for {num} seconds"] = "Sync hat nach {num} Sekunden in der Warteschlange begonnen"
    GRM_L["Not Determined"] = "Nicht ermittelt"

    --R1.97
    GRM_L["You are added to the sync queue. Position: {num}"] = "Du wurdest zur Sync-Warteschlange hinzugefügt. Position: {num}"
    GRM_L["Sync Queue Position Update: {num}"] = "Update Sync-Warteschlange: Position {num}"
    GRM_L["Data has been transferred from the old Guild \"{name}\""] = "Daten wurden von der alten Gilde \"{name}\" transferiert"
    GRM_L["Restore Date:"] = "Gesichert am:"
    GRM_L["Guild Name"] = "Gildenname"
    GRM_L["Sync with {name} complete."] = "Sync mit {name} abgeschlossen."
    GRM_L["Transfer Data"] = "Daten transferieren"
    GRM_L["Please confirm that \"{name}\" has transferred. Clicking YES will import all guild data."] = "Bitte bestätige den Transfer von \"{name}\". Klick auf JA importiert alle Gildendaten."
    GRM_L["Set Restore Point"] = "Sichern"
    GRM_L["Guild Transfer Tool"] = "Gildentransfer-Werkzeug"
    GRM_L["Transfer Tool Guide"] = "Anleitung Transfer-Werkzeug"
    GRM_L["Step-by-Step guide on how to use transfer tool"] = "Schritt-für-Schritt-Anleitung für das Transfer-Werkzeug"
    GRM_L["Step {num}:"] = "Schritt {num}:"
    GRM_L["Click \"Set Restore Point\" to the guild you are currently in (remove save first if one already exists)."] = "Klicke \"Wiederherstellungspunkt setzen\" für deine aktuelle Gilde (ggf. alten Speicherpunkt zuerst löschen)."
    GRM_L["Initiate the guild transfer process."] = "Starte den Gildentransfer-Prozess."
    GRM_L["Log into the new guild on the new server."] = "Logge dich in die neue Gilde auf dem neuen Server ein."
    GRM_L["Open the Restore Tab again and click \"Transfer Data\" from your old guild. Confirm YES."] = "Öffne den Wiederherstellen-Tab erneut und klicke auf \"Daten transferieren\" von deiner alten Gilde. Bestätige mit JA."
    GRM_L["If you are satisfied with the transfer, remove the restore point to lower memory use next session."] = "Wenn du zufrieden bist, entferne den Wiederherstellungspunkt, um den Speicherverbrauch zu senken."
    GRM_L["Ensure that the new guild rank structure is identical to the previous (name changes are fine)."] = "Stelle sicher, dass die neue Gildenrang-Struktur identisch zur alten ist (Namensänderungen sind ok)."
    GRM_L["Transferred from old server"] = "Von altem Server transferiert"
    GRM_L["{name} has transferred servers and REJOINED the Guild."] = "{name} hat den Server transferiert und ist der Gilde ERNEUT BEIGETRETEN."
    GRM_L["Group Info Module is Outdated."] = "Gruppeninfo-Modul ist veraltet."

    -- R1.972
    GRM_L["Show Player Level"] = "Spielerlevel anzeigen"
    GRM_L["Show Mythic+ Rating"] = "Mythic+ Wertung anzeigen"
    GRM_L["M+ Rating:" ] = "M+ Wertung:"
    GRM_L["Do Not Show if at Max Level {num}"] = "Nicht auf Max-Level {num} anzeigen"
    GRM_L["Not on Server"] = "Nicht auf dem Server"
    GRM_L["Mythic+ rating will only appear on members at max level {num}."] = "Mythic+ Wertung wird nur bei Mitgliedern auf Max-Level {num} angezeigt."

    -- R1.973
    GRM_L["You are currently syncing. Please wait until sync completes to transfer the guild data."] = "Du synchronisierst gerade. Bitte warte, bis der Sync fertig ist, um die Gildendaten zu transferieren."
    GRM_L["Mythic+ Score"] = "Mythic+ Score"
    GRM_L["Show Member Faction"] = "Fraktion des Mitglieds anzeigen"
    GRM_L["Faction"] = "Fraktion"
    GRM_L["Alts:"] = "Twinks:"

    -- R1.975
    GRM_L["Export a full list of names in the queue."] = "Exportiere eine vollständige Liste der Namen in der Warteschlange."

    -- R1.977
    GRM_L["Guild Roster"] = "Gildenliste"
    GRM_L["GRM Custom Guild Roster"] = "Eigene GRM-Gildenliste"
    GRM_L["Unable to Promote players at this rank"] = "Spieler dieses Ranges können nicht befördert werden"
    GRM_L["Unable to Demote players at this rank"] = "Spieler dieses Ranges können nicht degradiert werden"
    GRM_L["No Rank Permission to Kick"] = "Keine Rangberechtigung zum Kicken";
    GRM_L["No Rank Permission to Demote"] = "Keine Rangberechtigung zum Degradieren";
    GRM_L["No Rank Permission to Promote"] = "Keine Rangberechtigung zum Befördern";
    GRM_L["Promote Player to:"] = "Spieler befördern zu:"
    GRM_L["Demote Player to:"] = "Spieler degradieren zu:"
    GRM_L["Lvl"] = "Lvl"
    GRM_L["Opens Custom Guild Roster Window"] = "Öffnet das eigene Gildenlisten-Fenster"
    GRM_L["{custom1} to Open"] = "{custom1} zum Öffnen";
    GRM_L["{custom1} to Promote, Demote, or Kick"] = "{custom1} zum Befördern, Degradieren oder Kicken"
    GRM_L["Whisper"] = "Flüstern"
    GRM_L["{custom1} to Whisper"] = "{custom1} zum Flüstern"

    -- R1.979
    GRM_L["{name}'s Settings"] = "Einstellungen von {name}"
    GRM_L["Reserved for GRM Macro Tool Usage. Please do not delete."] = "Reserviert für das GRM-Makro-Werkzeug. Bitte nicht löschen."
    GRM_L["Verify Promotion Dates"] = "Beförderungsdaten bestätigen"
    GRM_L["Verify Join Dates"] = "Beitrittsdaten bestätigen"
    GRM_L["Number of Unverified Promotion Dates: {num}"] = "Anzahl unbestätigter Beförderungsdaten: {num}"
    GRM_L["Number of Unverified Join Dates: {num}"] = "Anzahl unbestätigter Beitrittsdaten: {num}"
    GRM_L["Verify Only if Within Number of Days:"] = "Nur bestätigen, wenn innerhalb von Tagen:"
    GRM_L["Confirm All"] = "Alle bestätigen"
    GRM_L["Only Confirm Dates Within {num} Days"] = "Nur Daten innerhalb von {num} Tagen bestätigen"
    GRM_L["1 Promotion Date Has Been Confirmed."] = "1 Beförderungsdatum wurde bestätigt.";
    GRM_L["{num} Promotion Dates Have Been Confirmed."] = "{num} Beförderungsdaten wurden bestätigt."
    GRM_L["1 Join Date Has Been Confirmed."] = "1 Beitrittsdatum wurde bestätigt.";
    GRM_L["{num} Join Dates Have Been Confirmed."] = "{num} Beitrittsdaten wurden bestätigt."
    GRM_L["Searching Log..."] = "Durchsuche Log..."

    -- R1.990
    GRM_L["M+ Score" ] = "M+ Score"
    GRM_L["Search Public, Officer, and Custom Notes"] = "Öffentliche, Offiziers- & eigene Notizen durchsuchen"
    GRM_L["Note Search"] = "Notiz-Suche"
    GRM_L["Tips"] = "Tipps"
    GRM_L["Hold the CONTROL key down to scroll 3x the speed"] = "Halte die STRG-Taste für 3x Scroll-Geschwindigkeit"
    GRM_L["Hold the SHIFT key down to scroll instantly to the top or bottom"] = "Halte die SHIFT-Taste, um sofort nach oben/unten zu scrollen"

    -- R1.981
    GRM_L["Player Level Range:"] = "Spieler-Levelbereich:"

    -- R1.982
    GRM_L["Announce Member Join Date Anniversaries."] = "Jahrestage von Mitgliedern ankündigen."
    GRM_L["Announce Player Birthdates."] = "Geburtstage von Spielern ankündigen."
    GRM_L["Anniversaries, Birthdays, and Other Events can be viewed."] = "Jahrestage, Geburtstage und andere Ereignisse können angesehen werden."
    GRM_L["Please confirm the removal of {num} events."] = "Bitte die Entfernung von {num} Ereignissen bestätigen."
    GRM_L["Show Offline Members"] = "Offline-Mitglieder anzeigen"
    GRM_L["{num}/{custom1} Online"] = "{num}/{custom1} Online"
    GRM_L["Hide Options"] = "Optionen verbergen"
    GRM_L["Show Options"] = "Optionen anzeigen"
    GRM_L["Show Mains"] = "Mains anzeigen"
    GRM_L["Show Alts"] = "Twinks anzeigen"
    GRM_L["Show Tag"] = "Tag anzeigen"
    GRM_L["Group Alts With Main"] = "Twinks mit Main gruppieren"
    GRM_L["If enabled, sorting will be based on the Mains"] = "Wenn aktiviert, wird nach den Mains sortiert"
    GRM_L["Rows:"] = "Zeilen:"
    GRM_L["{num} Rows"] = "{num} Zeilen"
    GRM_L["Right-Click to Reset to {num} Rows"] = "Rechtsklick für {num} Zeilen"
    GRM_L["Mythic+ Rating is"] = "Mythic+ Wertung ist"
    GRM_L["Mythic+ Rating:"] = "Mythic+ Wertung:"
    GRM_L["Mythic+ Rating: {num}"] = "Mythic+ Wertung: {num}"
    GRM_L["Mythic+ Rating greater or equal to {num}"] = "Mythic+ Wertung größer/gleich {num}"
    GRM_L["Mythic+ Rating equal to {num}"] = "Mythic+ Wertung gleich {num}"
    GRM_L["Mythic+ Rating less than {num}"] = "Mythic+ Wertung kleiner als {num}"

    -- R1.983
    GRM_L["Special Rules that don't fit nicely into the other categories."] = "Spezialregeln, die nicht in die anderen Kategorien passen."
    GRM_L["Special"] = "Spezial"
    GRM_L["Special Rules Not Available at Current Rank"] = "Spezialregeln auf aktuellem Rang nicht verfügbar"
    GRM_L["Add Special Rule"] = "Spezialregel hinzufügen"
    GRM_L["The \"Special\" rules bypass any safe and ignore restrictions."] = "Die \"Spezial\"-Regeln umgehen alle Schutz- und Ignorier-Beschränkungen."
    GRM_L["Unable to promote or demote players within the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler befördern oder degradieren."
    GRM_L["Special Rule Match:"] = "Spezialregel-Übereinstimmung:"

    -- R1.984
    GRM_L["Edit Hot Key"] = "Hotkey ändern"
    GRM_L["Clear"] = "Löschen"
    GRM_L["Start Building Your Hot Key"] = "Beginne, deinen Hotkey zu erstellen"
    GRM_L["Control"] = "Steuerung"
    GRM_L["Shift"] = "Shift"
    GRM_L["Confirm New Hot Key?"] = "Neuen Hotkey bestätigen?"
    GRM_L["Please Build Your Hot Key First"] = "Bitte erstelle zuerst deinen Hotkey"
    GRM_L["Control key is already added."] = "Strg-Taste wurde bereits hinzugefügt."
    GRM_L["Shift key is already added."] = "Shift-Taste wurde bereits hinzugefügt."
    GRM_L["Please add only 1 character"] = "Bitte nur 1 Zeichen hinzufügen"
    GRM_L["Hot Key is the Same"] = "Hotkey ist derselbe"
    GRM_L["Please add final key"] = "Bitte füge die letzte Taste hinzu"
    GRM_L["Final Key"] = "Letzte Taste"
    GRM_L["WARNING! Keybind is already in use for \"{name}\"."] = "WARNUNG! Tastenbelegung wird bereits für \"{name}\" verwendet."

    -- R1.986
    GRM_L["D"] = "T" -- T for "Tot"
    GRM_L["Classic Hardcore Mode"] = "Classic Hardcore-Modus"
    GRM_L["Hardcore"] = "Hardcore"
    GRM_L["Include Date Player Died"] = "Todesdatum des Spielers einfügen"
    GRM_L["Add Death Indicator Tag to Player Note"] = "Todes-Tag zur Spielernotiz hinzufügen"
    GRM_L["Hardcore Deaths"] = "Hardcore-Tode"
    GRM_L["{name} has died at level {num}."] = "{name} ist auf Level {num} gestorben."
    GRM_L["Player is Still Alive"] = "Spieler lebt noch"
    GRM_L["{name} is no longer reported as Dead."] = "{name} wird nicht mehr als tot gemeldet."
    GRM_L["The \"{custom1}\" indicates the player is dead." ] = "Das \"{custom1}\" zeigt an, dass der Spieler tot ist."
    GRM_L["Your rank does not have permission to remove the tag."] = "Dein Rang hat keine Berechtigung, den Tag zu entfernen."
    GRM_L["R.I.P. - {custom1}"] = "R.I.P. - {custom1}"
    GRM_L["Dead"] = "Tot"
    GRM_L["Total Deaths Recorded: {num}"] = "Gesamte Tode aufgezeichnet: {num}"
    GRM_L["Time of Death"] = "Todeszeitpunkt"
    GRM_L["Sort Deaths:"] = "Tode sortieren:"
    GRM_L["*Max Export is 500 Recorded Deaths at a Time"] = "*Maximal 500 aufgezeichnete Tode auf einmal exportieren"

    -- R1.988
    GRM_L["In-combat. Hiding all GRM windows"] = "Im Kampf. Verberge alle GRM-Fenster."
    GRM_L["Auto-Hide all GRM windows when entering combat."] = "Alle GRM-Fenster im Kampf automatisch verbergen."

    -- R1.9902
    GRM_L["Unable to kick or promote or demote players within the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler kicken, befördern oder degradieren."
    GRM_L["Unable to kick or demote players within the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler kicken oder degradieren."
    GRM_L["Unable to kick or promote players within the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler kicken oder befördern."
    GRM_L["Unable to kick players within the guild at current rank."] = "Kann mit aktuellem Rang keine Spieler kicken."
    GRM_L["Please Select Special Macro Rule"] = "Bitte wähle eine Spezial-Makro-Regel"
    GRM_L["Alt Group Rank Sync"] = "Twink-Gruppen-Rang-Sync"
    GRM_L["Repeated Inactivity Monitor"] = "Monitor für wiederholte Inaktivität"

    -- R1.9904
    GRM_L["If disabled, a one time scan is still done at login or reload."] = "Wenn deaktiviert, wird beim Login/Reload trotzdem ein einmaliger Scan durchgeführt."

    -- R1.9906
    GRM_L["To access the color wheel, due to a compatibility issue that began in 10.2.5, you will need to reload the UI. Do you wish to reload now?"] = "Um auf das Farbrad zuzugreifen, musst du aufgrund eines Kompatibilitätsproblems seit 10.2.5 die UI neuladen. Möchtest du jetzt neuladen?"

    -- R1.9907
    GRM_L["Alt Group Rule {num}"] = "Twink-Gruppen-Regel {num}"
    GRM_L["Promote/Demote Alts to Same Rank as Main"] = "Twinks auf denselben Rang wie Main befördern/degradieren"
    GRM_L["Promote/Demote Alts to Rank:"] = "Zielrang für Twinks:"
    GRM_L["Promote Alts to Same Rank as Main"] = "Twinks auf denselben Rang wie Main befördern"
    GRM_L["Promote Alts to Rank:"] = "Twinks befördern zu Rang:"
    GRM_L["Please Choose a Destination Rank for Alts."] = "Bitte wähle einen Zielrang für Twinks."
    GRM_L["Apply to Mains at:"] = "Auf Mains anwenden bei:"
    GRM_L["Only Selected Ranks"] = "Nur ausgewählte Ränge"
    GRM_L["Ignore if Offline for:"] = "Ignorieren, wenn offline für:"
    GRM_L["{custom1} to Change."] = "{custom1} zum Ändern."
    GRM_L["Sync Alts to Main:"] = "Twinks mit Main synchronisieren:"
    GRM_L["Main's Rank: {name}"] = "Rang des Mains: {name}"
    GRM_L["Alt's Rank: {name}"] = "Rang des Twinks: {name}"
    GRM_L["Destination Rank: {name}"] = "Zielrang: {name}"
    GRM_L["Up 1 Rank"] = "1 Rang hoch"
    GRM_L["Up {num} Ranks"] = "{num} Ränge hoch"
    GRM_L["Down 1 Rank"] = "1 Rang runter"
    GRM_L["Down {num} Ranks"] = "{num} Ränge runter"
    GRM_L["Ignore Alt Promotion if Offline for {num} {name}"] = "Twink-Beförderung ignorieren, wenn offline für {num} {name}"
    GRM_L["No Restrictions"] = "Keine Beschränkungen"
    GRM_L["Special Rule"] = "Spezialregel"
    GRM_L["{num} Players are Ready for {name}."] = "{num} Spieler sind bereit für {name}."
    GRM_L["1 Player is Ready for {name}."] = "1 Spieler ist bereit für {name}."
    GRM_L["Promotion"] = "Beförderung"
    GRM_L["Demotion"] = "Degradierung"
    GRM_L["Disable Demote Option. Only Promote Players"] = "Degradierungs-Option deaktivieren. Nur Spieler befördern."
    GRM_L["Unable to Move Alts to this Rank"] = "Twinks können nicht auf diesen Rang verschoben werden";

    -- R1.9909
    GRM_L["When you are ready to Move the player, press the Hot-Key {name} 1 time to complete all actions"] = "Wenn du bereit bist, den Spieler zu verschieben, drücke den Hotkey {name} 1 Mal"
    GRM_L["When you are ready to move the players, press the Hot-Key {name} {num} times to complete all actions"] = "Wenn du bereit bist, die Spieler zu verschieben, drücke den Hotkey {name} {num} Mal"

    -- R1.99094
    GRM_L["For GRM to log guild member deaths, you will need to join the \"{name}\" channel. Do you wish to join?"] = "Damit GRM Tode von Gildenmitgliedern loggen kann, musst du dem Kanal \"{name}\" beitreten. Möchtest du beitreten?"
    GRM_L["You will not be asked this again."] = "Du wirst nicht erneut gefragt."
    GRM_L["Please note, GRM will now track the deaths behind the scenes. If you wish to see the full server message, you will need to manually enable in the General Chat Settings."] = "Bitte beachte, GRM verfolgt die Tode nun im Hintergrund. Um die volle Servernachricht zu sehen, aktiviere sie in den allgemeinen Chat-Einstellungen."
    GRM_L["Join \"{name}\" Channel to Track Deaths"] = "Kanal \"{name}\" beitreten, um Tode zu verfolgen"
    GRM_L["HardcoreDeaths"] = "HardcoreTode"
    GRM_L["Configuring channel... one moment."] = "Konfiguriere Kanal... einen Moment."

    -- R1.9911
    GRM_L["Data collected. Ban list updated."] = "Daten gesammelt. Bannliste aktualisiert."
    GRM_L["Birthday set for {name} and {num} alt: {custom1}"] = "Geburtstag für {name} und {num} Twink gesetzt: {custom1}"
    GRM_L["Birthday set for {name} and {num} alts: {custom1}"] = "Geburtstag für {name} und {num} Twinks gesetzt: {custom1}"
    GRM_L["{name} has set {name2}'s Birthday, and {num} alt: {custom1}"] = "{name} hat den Geburtstag von {name2} und {num} Twink gesetzt: {custom1}"
    GRM_L["{name} has set {name2}'s Birthday, and {num} alts: {custom1}"] = "{name} hat den Geburtstag von {name2} und {num} Twinks gesetzt: {custom1}"
    GRM_L["{name}'s Birthday has been removed."] = "Der Geburtstag von {name} wurde entfernt."
    GRM_L["{name}'s alt grouping has had their Birthday removed"] = "Der Geburtstag der Twink-Gruppe von {name} wurde entfernt"
    GRM_L["{name} added {name2} to {custom1}'s list of Alts."] = "{name} hat {name2} zur Twink-Liste von {custom1} hinzugefügt."
    GRM_L["{name} added to {name2}'s list of Alts."] = "{name} wurde zur Twink-Liste von {name2} hinzugefügt."
    GRM_L["{name} has been removed from {name2}'s list of Alts."] = "{name} wurde von der Twink-Liste von {name2} entfernt."
    GRM_L["{name} has updated {name2}'s custom public note"] = "{name} hat die eigene öffentliche Notiz von {name2} aktualisiert"
    GRM_L["UnBans"] = "Entbannungen"
    GRM_L["Ban Edits"] = "Bann-Änderungen"
    GRM_L["Join Dates"] = "Beitrittsdaten"
    GRM_L["Promo Dates"] = "Beförderungsdaten"
    GRM_L["Alts/Mains"] = "Twinks/Mains"
    GRM_L["Custom Notes"] = "Eigene Notizen"
    GRM_L["Birthdays"] = "Geburtstage"
    GRM_L["Normalized Realm Names is Acceptable" ] = "Normalisierte Realm-Namen sind zulässig"
    GRM_L["Example: \'Aerie Peak\' or \'AeriePeak\'"] = "Beispiel: 'Aegwynn' oder 'Aegwynn'"
    GRM_L["Banned Player in Group: {name} - Identify Verified and Ban List Updated"] = "Gebannter Spieler in Gruppe: {name} - Identität geprüft und Bannliste aktualisiert"
    GRM_L["{name}'s Profile Succcessfully Updated!"] = "Profil von {name} erfolgreich aktualisiert!"
    GRM_L["All {name} Region Realms"] = "Alle Realms der Region {name}"
    GRM_L["Important Notice!!!"] = "Wichtiger Hinweis!!!"
    GRM_L["Due to the implementation of x-realm guilds, when banning players from servers other than your own, important identification data cannot be obtained. To bypass this limitation, add the ban when still grouped with the player, or while you are targeting them."] = "Wegen serverübergreifender Gilden können beim Bannen von Spielern anderer Server wichtige ID-Daten nicht erfasst werden. Umgehe dies, indem du den Bann hinzufügst, während du mit dem Spieler in einer Gruppe oder ihn im Ziel hast."
    GRM_L["This only applies to players who have never been a member of your guild and are not on your personal realm ({name})."] = "Dies gilt nur für Spieler, die nie Mitglied deiner Gilde waren und nicht auf deinem Realm ({name}) sind."
    GRM_L["Remind Me Next Time"] = "Nächstes Mal erinnern"
    GRM_L["Acknowledge"] = "Bestätigen"
    GRM_L["Unfortunately, {name} was not able to be identified. You must be grouped or targeting the player to obtain server identification details."] = "Leider konnte {name} nicht identifiziert werden. Du musst mit dem Spieler in einer Gruppe sein oder ihn im Ziel haben."
    GRM_L["Enable All"] = "Alle aktivieren"
    GRM_L["Disable All"] = "Alle deaktivieren"

    --R1.9914
    -- PROFESSION TRACKING DETAILS
    GRM_L["BS"] = "Schmied"
    GRM_L["LW"] = "Lederer"
    GRM_L["Alc"] = "Alchi"
    GRM_L["Herb"] = "Kräuter"
    GRM_L["Mine"] = "Bergbau"
    GRM_L["TL"] = "Schneider"
    GRM_L["Eng"] = "Ingi"
    GRM_L["Ench"] = "VZ"
    GRM_L["Skin"] = "Kürschner"
    GRM_L["JC"] = "Juwe"
    GRM_L["Insc"] = "Inschrift"
    GRM_L["Classic"] = "Classic"
    GRM_L["Classic Era, HC, and SOD"] = "Classic Ära, HC und SoD"
    GRM_L["Classic Professions"] = "Classic-Berufe"
    GRM_L["Auto Set and Update Profession Details to Player Notes"] = "Berufsdetails automatisch in Spielernotizen setzen & aktualisieren"
    GRM_L["Display Settings"] = "Anzeigeeinstellungen"
    GRM_L["Format (If same rank):"] = "Format (bei gleichem Rang):"
    GRM_L["Details will only be added to the note if space is available."] = "Details werden nur zur Notiz hinzugefügt, wenn Platz vorhanden ist."
    GRM_L["Profession Update Report"] = "Berufs-Update-Bericht"
    GRM_L["Update will only occur once per session to avoid note change spam."] = "Update erfolgt nur einmal pro Sitzung, um Notiz-Spam zu vermeiden."
    GRM_L["No Professions Have Changed"] = "Keine Berufe haben sich geändert"
    GRM_L["Total Notes Updated with Profession Details: {num}"] = "Gesamtzahl der mit Berufsdetails aktualisierten Notizen: {num}"
    GRM_L["Total Notes not able to update: {num}"] = "Notizen, die nicht aktualisiert werden konnten: {num}"
    GRM_L["Click to View All Names"] = "Klicken, um alle Namen anzuzeigen"
    GRM_L["Report Details to Chat if Professions Updated"] = "Details im Chat melden, wenn Berufe aktualisiert wurden"
    GRM_L["Note too long: Free up {num} characters"] = "Notiz zu lang: Gib {num} Zeichen frei"
    GRM_L["Click to Continue - {num} Members Remaining"] = "Klicken zum Fortfahren - {num} Mitglieder übrig"
    GRM_L["Choose Destination:"] = "Ziel auswählen:"
    GRM_L["Click to Set\nProfession Details"] = "Klicken, um\nBerufsdetails\nzu setzen"
    GRM_L["This will add or update available profession details to every member's {name}."] = "Dies fügt Berufsdetails zur {name} jedes Mitglieds hinzu oder aktualisiert sie."
    GRM_L["Auto-update will occur once per session, shortly after logging in. You will not need to click this button again."] = "Auto-Update erfolgt einmal pro Sitzung nach dem Login. Du musst diesen Knopf nicht erneut klicken."
    GRM_L["Auto-update is disabled. This will only update your notes a single time"] = "Auto-Update ist deaktiviert. Dies aktualisiert deine Notizen nur einmalig."
    GRM_L["Cancel Auto-Update"] = "Auto-Update abbrechen"
    GRM_L["Only Available in Classic Era"] = "Nur in Classic Ära verfügbar"
    GRM_L["Only Available for Officers"] = "Nur für Offiziere verfügbar"
    GRM_L["One moment. Processing profession data..."] = "Einen Moment. Verarbeite Berufsdaten..."
    GRM_L["Update profession ranks (Classic Era Only)"] = "Berufs-Ränge aktualisieren (nur Classic Ära)"
    GRM_L["Prof"] = "berufe"
    GRM_L["Realm Name"] = "Realmname"
    GRM_L["{name} is no longer in the guild"] = "{name} ist nicht mehr in der Gilde"
    GRM_L["{custom1} Entry to Open Player Window"] = "{custom1}, um das Spielerfenster zu öffnen"

    -- R1.99142
    GRM_L["On higher ranked alt"] = "Auf höherrangigem Twink"
    GRM_L["{num} player can be kicked by higher ranked alt {name}"] = "1 Spieler kann von höherrangigem Twink {name} gekickt werden"
    GRM_L["{num} players can be kicked by higher ranked alt {name}"] = "{num} Spieler können von höherrangigem Twink {name} gekickt werden"
    GRM_L["{num} player can be promoted by higher ranked alt {name}"] = "1 Spieler kann von höherrangigem Twink {name} befördert werden"
    GRM_L["{num} players can be promoted by higher ranked alt {name}"] = "{num} Spieler können von höherrangigem Twink {name} befördert werden"
    GRM_L["{num} player can be demoted by higher ranked alt {name}"] = "1 Spieler kann von höherrangigem Twink {name} degradiert werden"
    GRM_L["{num} players can be demoted by higher ranked alt {name}"] = "{num} Spieler können von höherrangigem Twink {name} degradiert werden"
    GRM_L["{num} player is ready to shift ranks by higher ranked alt {name}"] = "1 Spieler ist bereit für Rangverschiebung durch höherrangigen Twink {name}"
    GRM_L["{num} players are ready to shift ranks by higher ranked alt {name}"] = "{num} Spieler sind bereit für Rangverschiebung durch höherrangigen Twink {name}"

    -- R1.99152
    GRM_L["Unable to kick these alts:"] = "Diese Twinks können nicht gekickt werden:"

    -- R1.99161
    GRM_L["One Time Notice"] = "Einmaliger Hinweis";
    GRM_L["Blizzard re-introduced the Classic roster, which you currently have enabled. GRM features will be limited. The communities roster will give you access to all of GRM's features."] = "Blizzard hat die Classic-Liste wieder eingeführt, die du aktiviert hast. GRM-Funktionen sind eingeschränkt. Die Community-Liste gibt dir Zugriff auf alle GRM-Funktionen.";
    GRM_L["Would you like to enable the communities roster?"] = "Möchtest du die Community-Liste aktivieren?"
    GRM_L["Communities Roster is now Enabled."] = "Community-Liste ist jetzt aktiviert."

    -- R1.99165
    GRM_L["Player is Already in this Alt Group"] = "Spieler ist bereits in dieser Twink-Gruppe"

    -- R1.99170
    GRM_L["Unable to invite. You are grouped without privileges."] = "Einladen nicht möglich. Du bist ohne Berechtigungen in einer Gruppe."

    -- R1.992
    GRM_L["This will remove the profession details from all player notes: public, officer, and custom."] = "Dies entfernt die Berufsdetails aus allen Spielernotizen: öffentlich, Offizier und eigene."
    GRM_L["Do you wish to continue?"] = "Möchtest du fortfahren?"
    GRM_L["Click to Remove All Profession Notes"] = "Klicken, um alle Berufsnotizen zu entfernen"
    GRM_L["{num} notes have had profession details removed."] = "{num} Notizen wurden von Berufsdetails befreit."
    -- Main/Alt Display Settings
    GRM_L["Alt, Main, and Nickname settings"] = "Twink-, Main- und Spitznamen-Einstellungen"
    GRM_L["Names"] = "Namen"
    GRM_L["Main and Alt Formatting"] = "Main- und Twink-Formatierung"
    GRM_L["Show both {name} and {name2} tags in Chat"] = "Zeige {name} und {name2} - Tags im Chat"
    GRM_L["Show Main Name in Chat"] = "Zeige Main-Namen im Chat"
    -- Nickname Settings
    GRM_L["Nicknames"] = "Spitznamen"
    GRM_L["Show Nickname in Chat"] = "Zeige Spitznamen im Chat"
    GRM_L["Share Nickname Across All Grouped Alts"] = "Spitznamen über alle Twinks der Gruppe teilen"
    GRM_L["Append My Public Nickname to My Guild Messages"] = "Meinen öffentlichen Spitznamen an meine Gildennachrichten anhängen"
    GRM_L["Show Nickname instead of Main name"] = "Spitznamen anstelle des Main-Namens anzeigen"
    GRM_L["Main name will still show if no nickname has been set"] = "Main-Name wird weiterhin angezeigt, wenn kein Spitzname gesetzt ist"
    -- Custom Chat Window Settings
    GRM_L["Would you like to recreate this chat window for messages unique to the GRM addon?"] = "Möchtest du dieses Chatfenster für GRM-spezifische Nachrichten neu erstellen?"
    GRM_L["\"{name}\" Custom Chat Window for GRM appears to be missing."] = "Das eigene GRM-Chatfenster \"{name}\" scheint zu fehlen."
    GRM_L["The following Custom Chat Windows for GRM appear to be missing:"] = "Die folgenden eigenen GRM-Chatfenster scheinen zu fehlen:"
    GRM_L["Would you like to recreate these chat windows for messages unique to the GRM addon?"] = "Möchtest du diese Chatfenster für GRM-spezifische Nachrichten neu erstellen?"
    GRM_L["Add Channel"] = "Kanal hinzufügen"
    GRM_L["Add Channels"] = "Kanäle hinzufügen"
    GRM_L["Set to {name}"] = "Auf {name} setzen"
    GRM_L["Keep Only {name}"] = "Nur {name} behalten"
    GRM_L["GRM will now send all messages to the default \"{name}\" channel"] = "GRM sendet nun alle Nachrichten an den Standardkanal \"{name}\""
    GRM_L["The missing GRM channel has been recreated."] = "Der fehlende GRM-Kanal wurde neu erstellt."
    GRM_L["The {num} missing GRM channels have been recreated"] = "Die {num} fehlenden GRM-Kanäle wurden neu erstellt."
    GRM_L["GRM will now only send messages to the following channels:"] = "GRM sendet Nachrichten nun nur noch an folgende Kanäle:"
    GRM_L["Ignore Missing"] = "Fehlende ignorieren"
    -- Macro Rule Settings
    GRM_L["Search Public, Officer, and Custom Notes for Safe tag"] = "Suche Schutz-Tag in allen Notizen"
    GRM_L["Re-scanning roster for rule match."] = "Scanne Liste erneut auf Regel-Übereinstimmung."
    -- MISC
    GRM_L["Pending Feature"] = "Funktion in Entwicklung"

    -- 1.9926
    GRM_L["Add Message to Note After Demotion"] = "Nachricht nach Degradierung zur Notiz hinzufügen"
    GRM_L["GRM will append the message to existing note if room."] = "GRM hängt die Nachricht an die Notiz an, wenn Platz ist."
    GRM_L["However, if there is not enough room, the message will not be added."] = "Wenn jedoch nicht genug Platz ist, wird die Nachricht nicht hinzugefügt."
    GRM_L["Enable to forcibly overwrite existing note when not enough room for both."] = "Aktivieren, um Notiz zu überschreiben, wenn nicht genug Platz für beides ist."
    GRM_L["Force Overwrite"] = "Überschreiben erzwingen"
    GRM_L["{rank}"] = "{rang}"
    GRM_L["Add the bracket \'{rank}\' anywhere in message to insert former rank."] = "Füge die Klammer '{rang}' irgendwo ein, um den früheren Rang einzufügen."
    GRM_L["Ex: - Rank: {rank}"] = "Bsp: - Rang: {rang}"
    GRM_L["Max Length: {num} letters, including rank name"] = "Max. Länge: {num} Buchstaben, inkl. Rangname"

    -- 1.9931
    GRM_L["Warning!"] = "Warnung!"
    GRM_L["Your guild Log has {num} entries. Warcraft addons are limited in how much data can be stored. GRM provides this warning as a cushion to help ensure this is never broken as it would result in a catastrophic overflow error that will potentially destroy the GRM save file."] = "Dein Gilden-Log hat {num} Einträge. WoW-Addons haben begrenzten Speicherplatz. GRM warnt dich, um einen katastrophalen Überlauffehler zu vermeiden, der deine GRM-Speicherdatei zerstören könnte."
    GRM_L["You are currently storing {num} log entries across {custom1} guilds, taking up approximately {custom2}% of the addon's storage capacity."] = "Du speicherst derzeit {num} Log-Einträge in {custom1} Gilden, was ca. {custom2}% der Speicherkapazität des Addons ausmacht."
    GRM_L["You are currently storing {num} log entries in your guild, taking up approximately {custom1}% of the addon's storage capacity."] = "Du speicherst derzeit {num} Log-Einträge in deiner Gilde, was ca. {custom1}% der Speicherkapazität des Addons ausmacht."
    GRM_L["To Cleanup the log, if you wish to keep the data, please go to the export window by typing `/grm export` and copying the log to an external document. Then, on the log page, click on the 'Open Log Tools' button on the right side."] = "Um das Log zu bereinigen, gehe mit '/grm export' zum Exportfenster, kopiere das Log in ein externes Dokument und klicke dann im Log auf 'Log-Werkzeuge öffnen'."
    GRM_L["You are at risk for GRM data loss. It is CRITICAL this is handled imediately. Click OK to acknowledge. You will not be warned again."] = "Es besteht die Gefahr von GRM-Datenverlust. Es ist KRITISCH, dies sofort zu beheben. Klicke OK zur Bestätigung. Du wirst nicht erneut gewarnt."
    GRM_L["You are nearing max GRM storage limit. It is CRITICAL this is handled soon. Click OK to acknowledge."] = "Du näherst dich dem GRM-Speicherlimit. Es ist KRITISCH, dies bald zu beheben. Klicke OK zur Bestätigung."
    GRM_L["Press OK to acknowledge and you will not be reminded again until you are at {num}% capacity."] = "Drücke OK zur Bestätigung. Du wirst erst bei {num}% Kapazität erneut erinnert."

    -- 1.9933
    GRM_L["Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to Kick will remove {num} player(s) you currently have queued up for rank changes."] = "Warnung! Du kannst Beförderungen/Degradierungen nicht mit Kick-Makros kombinieren. Wählst du einen Spieler zum Kicken aus, werden {num} Spieler aus der Warteschlange für Rangänderungen entfernt."
    GRM_L["Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to {custom1} will remove {num} player(s) you currently have qued up to kick."] = "Warnung! Du kannst Beförderungen/Degradierungen nicht mit Kick-Makros kombinieren. Wählst du einen Spieler für {custom1} aus, werden {num} Spieler aus der Kick-Warteschlange entfernt."

    -- 1.99342
    GRM_L["Sync is temporarily disabled until the first scan of the guild roster has completed. It has been {num} seconds since logging in."] = "Sync ist temporär deaktiviert, bis der erste Scan der Gildenliste abgeschlossen ist. {num} Sekunden seit dem Login vergangen."
    GRM_L["Given the unusually long time of {num} seconds and sync is still not availble, GRM may not be loading properly. If you are experiencing any Lua errors, please report then to the official GRM Discord channel."] = "Nach {num} Sekunden ist der Sync immer noch nicht verfügbar, GRM lädt möglicherweise nicht richtig. Bitte melde Lua-Fehler im offiziellen GRM-Discord."

    -- 1.99344
    GRM_L["Not in Guild"] = "Nicht in Gilde"

    -- 1.99345
    GRM_L["Copy this link to use a web app to Export the contents of your log to a Text, CRV, or JSON file"] = true
    GRM_L["Use Web App"] = true
    GRM_L["Total Alts"] = true
    GRM_L["No Main Set"] = true
    GRM_L["Alts in Group"] = true
    GRM_L["Total Alt Groups Over Limit of {num}: {custom1}"] = true
    GRM_L["Limit must be at least 1 or greater."] = true
    GRM_L["The web app can extract your GRM logs to Text, CSV, or JSON"] = true
    GRM_L["Alt Group Limit Audit"] = true
    GRM_L["None Found"] = true
    GRM_L["altlimit"] = true        -- Slash command for alt group limit audit (original Eng always works, so feel free to change)

    -- 1.99346
    GRM_L["View Official GRM Website"] = true
    GRM_L["Want to learn more about GRM, check out the FAQ, changelog, and receive general tips and tricks? Check out the website!"] = true
    GRM_L["Check out the new GRM website"] = true

    -- 1.99347
    GRM_L["Expansion Change Detected - Updating player server IDs..."] = true
    GRM_L["Database updated with new server IDs!"] = true

    -- 1.99372
    GRM_L["No"] = true
    GRM_L["Loading..."] = true


    -- 1.99373
    GRM_L["Standard"] = true
    GRM_L["Move Anywhere"] = true

    -- 1.99374
    GRM_L["Addons Restricted while engaged in PVP. GRM initialization will continue when the {name} ends."] = true
    GRM_L["Addons Restricted while engaged in a Boss Fight. GRM initialization will continue when the combat ends"] = true
    GRM_L["Addons are no longer restricted. Continuing GRM initialization now."] = true
    GRM_L["Please specify a number limit after the altlimit command."] = true
    GRM_L["Nickname is too long. Max {num} letters."] = true
    GRM_L["Invalid Character: \"|\" is not allowed."] = true
    GRM_L["Nicknames cannot contain special symbols like \'{name}\'"] = true
    GRM_L["Nickname contains invalid hidden characters." ] = true
    GRM_L["{name} has removed the shared nickname for {name2} and all alts ({custom1})"] = true
    GRM_L["{name} has removed {name2}'s nickname ({custom1})"] = true
    GRM_L["{name} has added the shared nickname for {name2} and all alts ({custom1})"] = true
    GRM_L["{name} has added {name2}'s nickname ({custom1})"] = true

    -- 1.99383
    GRM_L["Apply to Max Level Only"] = true
    GRM_L["Copy this text anywhere into the Guild Info window (preferably the end)."] = true
    GRM_L["Addon currently restricted by the server from reading Guild Info. Please adjust the settings when addon is not restricted to update global controls."] = true
    GRM_L["Addon currently restricted by the server from reading Guild Info. Please wait to export the global control text when addon is not restricted."] = true
    GRM_L["Get Join Date"] = true
    GRM_L["Copy the Join date to add to your note (Ctrl-C)"] = true
    GRM_L["{name}'s Join Date is not yet Established."] = true
    GRM_L["{name}'s Join Date is NOT VERIFIED. Please verify join date before adding."] = true
    GRM_L["FEATURE DISABLED - Addons restricted from editing Public or Officer notes with Midnight 12.0.1 Launch"] = true
    GRM_L["Public Note not set"] = true
    GRM_L["Officer Note not Set"] = true
    GRM_L["API restricted by Blizzard - Public note editing not possible."] = true
    GRM_L["API restricted by Blizzard - Officer note editing not possible."] = true
    GRM_L["(Unavailable in Retail)"] = true
    GRM_L["The Global Control string in your guild info needs to be updated. GRM no longer has the ability to do it. Please type /grm and go to the Options and Officer tab to re-obtain a new control text string to manually copy over."] = true

    -- 1.99384
    GRM_L["NOTICE - Note Editing Restrictions Active - Unable to Edit"] = true
    GRM_L["Public Note Locations:"] = true
    GRM_L["Officer Note Locations:"] = true
    GRM_L["Due to addon limitations, the {num} public or officer notes cannot be edited automatically. You must edit manually."] = true
    GRM_L["Disregard notes located in Public or Officer notes"] = true
    GRM_L["Addons Restrcited in current state. Functionality Limited. GRM initialization will continue soon."] = true

    -- R1.99386
    GRM_L["Unable to Retrieve. Addons currently restricted."] = true
    GRM_L["The Log is already empty."] = true
    GRM_L["Only the visible non-filtered log entries will be cleared. Do you really wish to delete the {num} log entries?"] = true
    GRM_L["Only the currently filtered {num} log entries will be removed."] = true
    
end

    -- THANK YOU @Nehry for this full translation up to R1.20
    -- TY @Mythos for cleaning up translation work done up to R1.88
