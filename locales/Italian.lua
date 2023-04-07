
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

GRML.Italian = function()

	-- Auto Localized (Only use this on Client languages)
    GRM_L["Friend"] = FRIEND;

	-- SET YOUR OWN CUSTOM SLASH COMMAND FOR GRM
	GRM_L["/XXXX"] = true                           -- /grm will always work, now you can make your own acronym that fits your language. Example: GRM_L["/XXXX"] = "/грм" - Now, if you type /грм it will work in-game

	GRM_L["German"] = "Tedesco"
	GRM_L["English"] = "Inglese"
	GRM_L["French"] = "Francese"
	GRM_L["Italian"] = "Italiano"
	GRM_L["Russian"] = "Russo"
	GRM_L["SpanishMX"] = "Spagnolo (MX)"
	GRM_L["SpanishEU"] = "Spagnolo (EU)"
	GRM_L["Portuguese"] = "Portoghese (EU)"
	GRM_L["PortugueseBR"] = "Portoghese (BR)"
	GRM_L["Korean"] = "Coreano"
	GRM_L["MandarinCN"] = "Cinese mandarino"
	GRM_L["MandarinTW"] = "Mandarino Taiwan"
	GRM_L["Dutch"] = "Olandese"
	GRM_L["Danish"] = "Danese"

	-- PLAYER MAIN ROSTER DETAILS WINDOW
	GRM_L["Level: "] = "Livello: "
	GRM_L["Level"] = "Livello"
	GRM_L["Note:"] = "Nota:"
	GRM_L["Note"] = "Nota"
	GRM_L["Officer's Note:"] = "Nota degli ufficiali:"
	GRM_L["Officer's Note"] = "Nota degli ufficiali"
	GRM_L["Zone:"] = "Zona:"
	GRM_L["(main)"] = "(main)"
	GRM_L["( Main )"] = "( Main )"                               -- Context: This one is used on player data window, the other is smaller used in the alts list...
	GRM_L["Set as Main"] = "Imposta come Main"
	GRM_L["Set as Alt"] = "Imposta come Alt"
	GRM_L["Remove"] = "Rimuovi"
	GRM_L["Please Type the Name of the alt"] = "Per favore, scrivi il nome dell'Alt"
	GRM_L["Promoted:"] = "Promosso il:"
	GRM_L["Unknown"] = "Sconosciuta"                                                                 -- Context: The date of their promotion is "Unknown"
	GRM_L["Click here to set a Public Note"] = "Clicca per impostare una Nota Pubblica"
	GRM_L["Unable to Edit Public Note at Rank"] = "Grado troppo basso per modificare una Nota Pubblica"
	GRM_L["Click here to set an Officer's Note"] = "Clicca per impostare una Nota Ufficiali"
	GRM_L["Unable to Edit Officer Note at Rank"] = "Grado troppo basso per modificare una Nota degli Ufficiali"
	GRM_L["Unable to View Officer Note at Rank"] = "Grado troppo basso per visualizzare una Nota degli Ufficiali"
	GRM_L["Online"] = "Online"
	GRM_L["( Active )"] = "( Attivo )"                       -- I included the parentheses here as I am not sure if any languages abstain from them, or use other notation. Feel free to remove if necessary
	GRM_L["( AFK )"] = "( AFK )"
	GRM_L["( Busy )"] = "( Occupato )"
	GRM_L["( Mobile )"] = "( Chat Remota )"
	GRM_L["( Offline )"] = "( Offline )"
	GRM_L["Set Join Date"] = "Imposta"
	GRM_L["Edit Promo Date"] = "Imposta"
	GRM_L["Edit Join Date"] = "Modifica data"
	GRM_L["Set Promo Date"] = "Modifica data"
	GRM_L["No Invite"] = "Nessun invito"
	GRM_L["Group Invite"] = "Invita in gruppo"
	GRM_L["Date Promoted?"] = "Data promozione?"
	GRM_L["Last Online"] = "Ultimo accesso"
	GRM_L["Time In:"] = "Da:"                            -- Context: "Time In" the current zone...
	GRM_L["Date Joined"] = "Data entrata"
	GRM_L["Join Date?"] = "Data di entrata?"
	GRM_L["Player Was Previously Banned!"] = "Giocatore Bannato precedentemente!" --WIP
	GRM_L["Ignore Ban"] = "Ignora Ban"
	GRM_L["Player Alts"] = "Alt del Giocatore"
	GRM_L["Add Alt"] = "Aggiungi Alt"
	GRM_L["Choose Alt"] = "Scegli Alt"
	GRM_L["Guild Log"] = "Registro di Gilda"
	GRM_L["Guild"] = "Gilda"

	-- TOOLTIPS
	GRM_L["Rank History"] = "Cronologia Gradi" 
	GRM_L["Time at Rank:"] = "Questo Grado da:" --WIP
	GRM_L["Right-Click to Edit"] = "Click destro per modificare"
	GRM_L["Left Guild"] = "Ha lasciato la Gilda"
	GRM_L["Membership History"] = "Cronologia del giocatore"
	GRM_L["Joined:"] = "Entrato il:"                             -- as in "Joined" the guild      --WIP
	GRM_L["Joined"] = "È Entrato"
	GRM_L["Left:"] = "Ha Lasciato:"                               -- as in, "Left" the guild
	GRM_L["Rejoined:"] = "È Rientrato il:"                           -- as in, "Rejoined" the guild
	GRM_L["Rejoined"] = "È Rientrato il"
	GRM_L["Reset Data!"] = "Resetta Dati!"
	GRM_L["Notify When Player is Active"] = "Manda una notifica quando il giocatore torna attivo"
	GRM_L["Notify When Player Goes Offline"] = "Manda una notifica quando il giocatore va Offline"
	GRM_L["Notify When Player Comes Online"] = "Manda una notifica quando il giocatore torna Online"
	GRM_L["Edit Date"] = "Modifica Data"
	GRM_L["Clear History"] = "Cancella Cronologia"
	GRM_L["Options"] = "Opzioni" --"Impostazioni"

	-- LOG
	GRM_L["LOG"] = "REGISTRO"                                                     -- Context - The guild Log shorthand for the tab
	GRM_L["Guild Roster Event Log"] = "Registro Eventi"
	GRM_L["Clear Log"] = "Pulisci Registro" -- Maybe "Cancella registro" is better?
	GRM_L["Really Clear the Guild Log?"] = "Vuoi davvero cancellare il Registro di Gilda?"
	GRM_L["{name} KICKED {name2} from the Guild!"] = "{name} ha RIMOSSO {name2} dalla Gilda!"
	GRM_L["kicked"] = "rimosso"
	GRM_L["{name} has Left the guild"] = "{name} ha lasciato la Gilda"
	GRM_L["{name} has BANNED {name2} and all linked alts from the guild!"] = "{name} ha bannato {name2} e tutti gli Alt collegati dalla Gilda!"
	GRM_L["{name} has BANNED {name2} from the guild!"] = "{name} ha bannato {name2} dalla gilda!"
	GRM_L["Reason Banned:"] = "Bannato per:"
	GRM_L["has Left the guild"] = "ha lasciato la gilda"                                      -- Context: PlayerName "has left the guild"
	GRM_L["ALTS IN GUILD:"] = "ALT IN GILDA"                                          -- Context: This appears If a person leaves the guild and there are still alts in the guild. It is like - "ALTS IN GUILD: Arkaan, Chris, Matt, and 4 others.""
	GRM_L["Player no longer on Server"] = "Giocatore non più sul server"
	GRM_L["{name} PROMOTED {name2} from {custom1} to {custom2}"] = "{name} ha PROMOSSO {name2} da {custom1} a {custom2}"
	GRM_L["{name} has been PROMOTED from {custom1} to {custom2}"] = "{name}è stato PROMOSSO da {custom1} a {custom2}"
	GRM_L["{name} DEMOTED {name2} from {custom1} to {custom2}"] = "{name} ha RETROCESSO {name2} da {custom1} a {custom2}"
	GRM_L["{name} has been DEMOTED from {custom1} to {custom2}"] = "{name}è stato RETROCESSO da {custom1} a {custom2}"
	GRM_L["(+ {num} More)"] = "e altri {num}"                                          -- Context: Referencing num of alts if player leaves guild, that are stil in it. Example "ALTS IN GUILD: Christ, Matt, Sarah (and 4 more)"
	GRM_L["{name} has Been in the Guild {num} Times Before"] = "{name} è stato in gilda {num} volte"
	GRM_L["{name} is Returning for the First Time."] = "{name} è rientrato in gilda per la prima volta"
	GRM_L["None Given"] = "Nessuna"                                              -- Context: No reason given for player ban. This is displayed when a player was banned, but the addon users did not input a reason why.
	GRM_L["WARNING!"] = "ATTENZIONE!"                                                -- Context: WARNING - banned player rejoined the guild!
	GRM_L["{name} REJOINED the guild but was previously BANNED!"] = "{name} è rientrato in gilda dopo essere stato bannato!"
	GRM_L["(Invited by: {name})"] = "(Invitato da: {name})"
	GRM_L["Invited By: {name}"] = "Invitato da: {name}"
	GRM_L["Date of Ban:"] = "Bannato il:"
	GRM_L["Date Originally Joined:"] = "Data Originale di entrata" 
	GRM_L["Old Guild Rank:"] = "Vecchio Grado:"
	GRM_L["Additional Notes:"] = "Note aggiuntive:"
	GRM_L["{name} has REINVITED {name2} to the guild"] = "{name} ha reinvitato {name2} in gilda"
	GRM_L["(LVL: {num})"] = "(LVL: {num})"						                                     -- Context: LVL means Player Level - so Ex: (LVL: 110)
	GRM_L["{name} has REJOINED the guild"] = "{name} è rientrato in gilda"
	GRM_L["{name} has JOINED the guild!"] = "{name} si è unito alla gilda!"
	GRM_L["Date Left:"] = "Data di uscita:"
	GRM_L["{name} has Leveled to {num}"] = "{name} è salito al {num}"
	GRM_L["(+{num} levels)"] = "(+{num} livelli)"                                        -- Context: Person gained more than one level, hence the plural
	GRM_L["(+{num} level)"] = "(+{num} livello)"                                          -- Context: Person gains a level, just one level.
	GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Added"] = "Nota Pubblica \"{custom1}\" per {name} aggiunta"          -- Of note, the \" in the text here will just appear as " in-game. The \" notation is telling the program not to end the string, but to include quotation
	GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Removed"] = "Nota Pubblica \"{custom1}\" di {name} rimossa"
	GRM_L["{name}'s PUBLIC Note: \"{custom1}\" to \"{custom2}\""] = "Nota Pubblica di {name} cambiata da \"{custom1}\" a \"{custom2}\""   -- Context: "Arkaan's PUBLIC Note: "ilvl 920" to "Beast Mode ilvl 960""  -- Changing of the note. custom1 = old note, custom2 = new note
	GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Added"] = "Nota degli Ufficiali \"{custom1}\" per {name} aggiunta"
	GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Removed"] = "Nota degli Ufficiali \"{custom1}\" di {name} rimossa"
	GRM_L["{name}'s OFFICER Note: \"{custom1}\" to \"{custom2}\""] = "Nota degli Ufficiali di {name} cambiata da \"{custom1}\" a \"{custom2}\"" 
	GRM_L["Guild Rank Renamed from {custom1} to {custom2}"] = "Grado di gilda rinominato da {custom1} a {custom2}"
	GRM_L["{name} has Name-Changed to {name2}"] = "{name} ha cambiato nome in {name2}"
	GRM_L["{name} has Come ONLINE after being INACTIVE for {num}"] = "{name} è tornato Online dopo essere stato Inattivo per {num}"
	GRM_L["{name} has been OFFLINE for {num}. Kick Recommended!"] = "{name} è Offline da {num}. Consigliata Rimozione dalla Gilda"
	GRM_L["({num} ago)"] = "({num} fa)"                                              -- Context: (5 minutes ago) or (5 months 24 days ago) -- the {num} will automatically include the time-passed date.
	GRM_L["{name}'s Guild has Name-Changed to \"{name2}\""] = "Il nome della Gilda è stato cambiato da {name} a \"{name2}\""
	GRM_L["Promotions"] = "Promozioni"
	GRM_L["Demotions"] = "Retrocessioni"

	-- EVENTS WINDOW
	GRM_L["EVENTS"] = "EVENTI"                                         -- Events tab
	GRM_L["{name}'s Anniversary!"] = "Anneversario di {name}!"
	GRM_L["Please Select Event to Add to Calendar"] = "Per favore seleziona un Evento da aggiungere al Calendario"
	GRM_L["Event Calendar Manager"] = "Gestore del Calendario"
	GRM_L["Event:"] = "Evento:"
	GRM_L["Description:"] = "Descrizione:"
	GRM_L["Add to\nCalendar"] = "Aggiungi al\nCalendario"
	GRM_L["Ignore Event"] = "Ignora\nEvento"
	GRM_L["No Player Event Has Been Selected"] = "Nessun evento relativo a un giocatore è stato selezionato"  --WIP
	GRM_L["Event Added to Calendar: {custom1}"] = "Evento aggiunto al Calendario: {custom1}"              -- Custom1 = the title of the event, like "Arkaan's Anniversary"
	GRM_L["No Calendar Events to Add"] = "Nessun Evento da aggiungere"
	GRM_L["{name}'s event has already been added to the calendar!"] = "L'evento di {name} è già stato aggiunto al Calendario!"
	GRM_L["Please wait {num} more seconds to Add Event to the Calendar!"] = "Per favore, aspetta altri {num} per aggiungere l'Evento al Calendario"
	GRM_L["{name}'s Event Removed From the Queue!"] = "Evento di {name} rimosso dall'elenco"
	GRM_L["Full Description:"] = "Descirzione Completa"

	-- BAN WINDOW
	GRM_L["BAN LIST"] = "LISTA BAN"                                        -- Ban List Tab
	GRM_L["Reason Banned?"] = "Bannato per?"
	GRM_L["Click \"YES\" When Done"] = "Clicca \"SÌ\" quando hai fatto"                         -- Of note, the \" is how you notate for quotations to actually appear. Adjust as needed
	GRM_L["Select a Player"] = "Seleziona un Giocatore"
	GRM_L["Player Selected"] = "Giocatore selezionato"
	GRM_L["{name}(Still in Guild)"] = "{name}(è ancora in Gilda)"
	GRM_L["(Still in Guild)"] = "(è ancora in Gilda)"
	GRM_L["No Ban Reason Given"] = "Nessuna motivazione data per il Ban"
	GRM_L["Total Banned:"] = "Totale Bannati:"
	GRM_L["Rank"] = "Grado"
	GRM_L["Ban Date"] = "Data Ban"
	GRM_L["No Players Have Been Banned from Your Guild"] = "Nessun giocatore è stato Bannato dalla Gilda"
	GRM_L["Remove Ban"] = "Rimuovi Ban"
	GRM_L["Add Player to Ban List"] = "Aggiungi un giocatore alla Lista Ban"
	GRM_L["Server:"] = "Reame:"
	GRM_L["Class:"] = "Classe:"
	GRM_L["Reason:"] = "Motivo:"
	GRM_L["It is |CFFFF0000CRITICAL|r the player's name and server are spelled correctly for accurate tracking and notifications."] = "|CFFFF0000È ESTREMAMENTE IMPORTANTE|r che il nome del giocatore e del server siano scritti correttamente per un tracciamento accurato e per le notifiche."
	GRM_L["Submit Ban"] = "Conferma Ban"
	GRM_L["Confirm"] = "Conferma"
	GRM_L["Cancel"] = "Annulla"
	GRM_L["Add"] = "Aggiungi"                                         -- Context: "Add" player to ban list
	GRM_L["Confirm Ban for the Following Player?"] = "Confermi il Ban per il seguente Giocatore?"
	GRM_L["Please Enter a Valid Player Name"] = "Per favore, inserisci un nome giocatore valido"            -- Player Name
	GRM_L["Please Enter a Valid Server Name"] = "Per favore, inserisci un nome di un server valido"            -- Server Name
	GRM_L["Please Select a Player to Unban!"] = "Per favore, seleziona il giocatore da sbannare"
	GRM_L["{name} - Ban List"] = "{name} - Lista Ban"                          -- Context: "GuildName - Ban List"
	GRM_L["No Reason Given"] = "Nessuna motivazione"

	-- ADDON USERS WINDOW
	GRM_L["SYNC USERS"] = "SINCRONIZZA"
	GRM_L["Ok!"] = "Ok!"
	GRM_L["Their Rank too Low"] = "Ha un Grado troppo basso"
	GRM_L["Your Rank too Low"] = "Il tuo Grado è troppo basso"
	GRM_L["Outdated Version"] = "Versione troppo vecchia"
	GRM_L["You Need Updated Version"] = "Hai bisogno di una versione aggiornata"
	GRM_L["Player Sync Disabled"] = "Sincronizzazione con gli altri giocatori disabilitata"
	GRM_L["No Guildie Online With Addon."] = "Nessun gildano Online ha questo Add-on"
	GRM_L["ONE Person is Online. Recommend It!"] = "UNA persona è Online. Raccomandalo!"
	GRM_L["{num} others are Online! Recommend It!"] = "{num} persone sono Online. Consiglia di installare questo add-on!"
	GRM_L["GRM Sync Info"] = "Informazioni di Sincronizzazione"
	GRM_L["Ver: {custom1}"] = "Ver: {custom1}"                                  -- Context:  Ver: R1.125  - Ver is short for Version
	GRM_L["Name:"] = "Nome:"
	GRM_L["Version"] = "Versione:"
	GRM_L["Sync"] = "Sincronizzazione"	
	GRM_L["Your Sync is Currently Disabled"] = "La Sincronizzazione è disabilitata"

	-- OPTIONS WINDOW
	GRM_L["Scanning Roster:"] = "Scansione Elenco:"
	GRM_L["Guild Rank Restricted:"] = "Impostazioni limitate dal grado:" --WIP
	GRM_L["Sync:"] = "Sincronizzazione:"
	-- Options window -- of note, these are very concise statements. They may need to be adjusted properly in the Options window for proper spacing, so verify they look ok after translating.
	GRM_L["Slash Commands"] = "Comandi da chat"
	GRM_L["Trigger scan for changes manually"] = "Attiva manualmente la scansione per trovare cambiamenti"
	GRM_L["Trigger sync one time manually"] = "Attiva manualmente una singola sincronizzazione"
	GRM_L["Centers all Windows"] = "Centra tutte le finestre"
	GRM_L["Slash command info"] = "Informazioni sui comandi da chat"
	GRM_L["Resets ALL data"] = "Resetta tutti i dati"
	GRM_L["Report addon ver"] = "Riporta la versione dell'add-on"                                    -- Ver is short for Version
	GRM_L["Resets Guild data"] = "Resetta i dati della Gilda"
	GRM_L["Show at Logon"] = "Mostra all'avvio"
	GRM_L["Only Show if Log Changes"] = "Mostra Solo se ci sono cambiamenti nel Registro"

	-- This do need to be translated still
	GRM_L["Before Scan Timer"] = "Controlla cambiamenti ogni"     -- Context: "Scan for Changes Every 10 Seconds" -- There will be a number added here and may require custom positioning, so please provide full statement and Arkaan will allign
	GRM_L["After Scan Timer"] = "Secondi"    --"Seconds"
	GRM_L["Before Inactive Timer"] = "Notifica il ritorno di un Inattivo se è stato Offline per almeno"--"Report Inactive Return if Player Offline"
	GRM_L["After Inactive Timer"] = "Giorni"  --"Days"

	GRM_L["Reactivating SCAN for Guild Member Changes..."] = "Analisi dei cambiamenti nell'elenco di gilda riattivata"
	GRM_L["Deactivating SCAN of Guild Member Changes..."] = "Analisi dei cambiamenti nell'elenco di gilda disattivata"
	GRM_L["Please choose a scan interval {num} seconds or higher!"] = "Per favore, scegli un intervallo di {num} secondi o più!"
	GRM_L["{num} is too Low!"] = "{num} è troppo basso!"
	GRM_L["The Current Lvl Cap is {num}."] = "L'attuale livello massimo è {num}"
	GRM_L["Kick Inactive Player Reminder at"] = "Promemoria rimozione giocatori inattivi dopo"        -- Context: "Kick Inactive Player Reminder at X Months" - Again, allignment will need to be adjusted for options UI, so please post
	GRM_L["Please choose a month between 1 and 99"] = "Per favore scegli un mese tra 1 e 99"
	GRM_L["Please choose a month between 0 and 99"] = "Per favore scegli un mese tra 0 e 99" 
	GRM_L["Sync BAN List With Guildies at Rank"] = "Sincronizza la Lista Ban solo con gildani"     -- Context: "Sync Ban List with Guildies at Rank [DROPDOWNMENU OF RANKS] or Higher" - Please show where dropdown menu should be pinned
	GRM_L["or Higher"] = "o più alto"                               -- Context: Look at the above statement. Show where this needs to go in regards to dropdown menu of rank selection in Options
	GRM_L["Restore Defaults"] = "Predefinito"
	GRM_L["Please choose between 1 and 180 days!"] = "Per favore, scegli tra 1 e 180 giorni!"
	GRM_L["Announce Events"] = "Annuncia gli Eventi con"                         -- Context: "Announce Events X number of days in advance" -- the X is the editbox to modify number of days. Please include the location of where to pin that.
	GRM_L["Days in Advance"] = "Giorni in anticipo"
	GRM_L["Please choose between 1 and 28 days!"] = "Per favore, scegli tra 1 e 28 giorni!"
	GRM_L["Add Events to Calendar"] = "Aggiungi Eventi al Calendario"
	GRM_L["SYNC Changes With Guildies at Rank"] = "Sincronizza i cambiamenti solo con gildani"     -- Context: at Rank [DROPDOWNRANKSELECTION] or Higher. - Please note where to place dropdown box in the position of the sentence.
	GRM_L["Reactivating Data SYNC with Guildies..."] = "Riattivazione Sincronizzazione con i gildani"
	GRM_L["Deactivating Data SYNC with Guildies..."] = "Disattivazione Sincronizzazione con i gildani"
	GRM_L["Display Sync Update Messages"] = "Visualizza i messaggi di aggiornamento della Sincronizzazione"
	GRM_L["Only Sync With Up-to-Date Addon Users"] = "Sincronizza solo con utenti che hanno l'Add-on aggiornato"
	GRM_L["Leveled"] = "Livelli"
	GRM_L["Inactive Return"] = "Ritorno Inattivi"
	GRM_L["resetall"] = "resetta tutto"
	GRM_L["resetguild"] = "resetta gilda"
	--Side chat/log controls - Of note, limited spacing
	GRM_L["Name Change"] = "Cambio nome"
	GRM_L["Rank Renamed"] = "Grado rinominato"
	GRM_L["Event Announce"] = "Annuncio Evento"
	GRM_L["Left"] = "Ha lasciato"                        -- Context: As in, "Left" the guild...
	GRM_L["Recommendations"] = "Raccomandazioni"
	GRM_L["Banned"] = "Bannato"
	GRM_L["To Chat:"] = "In Chat:"                    -- Context: "To Chat Message frame -- in regards to announcing events like when a player leveled"
	GRM_L["To Log:"] = "Nel Registro:"                     -- Context: To show it in the guild log.
	GRM_L["Display Changes"] = "Mostra Cambiamenti"
	GRM_L["Show 'Main' Name in Chat"] = "Mostra il nome del \"Main\" in chat"


	-- AUDIT WINDOW
	GRM_L["AUDIT"] = "VERIFICA"                                              -- Audit Tab name
	GRM_L["No Date Set"] = "Nessuna data"
	GRM_L["Main"] = "Main"
	GRM_L["Main or Alt?"] = "Main o Alt?"
	GRM_L["Alt"] = "Alt"
	GRM_L["Total Incomplete: {num} / {custom1}"] = "Totale Incompleti: {num} / {custom1}"                 -- Context: Total incomplete: 50 / 100    (50 out of 100)
	GRM_L["Mains:\n{num}"] = "Main:\n{num}"                                        -- Context: Number of "main" toons
	GRM_L["Unique Accounts:\n{num}"] = "Account Unici:\n{num}"
	GRM_L["All Complete"] = "Tutto Completo"                                        -- Context: All dates have been added and are known, thus it states it is "All Complete"
	GRM_L["Set Incomplete to Unknown"] = "Imposta data come Sconosciuta"                          -- Context: Implied to set ALL incomplete to unknown
	GRM_L["Clear All Unknown"] = "Cancella tutti gli Sconosciuta"
	GRM_L["Please Wait {num} more Seconds"] = "Per favore, aspetta altri {num} Secondi"
	GRM_L["Guild Data Audit"] = "Verifica dei dati di Gilda"
	GRM_L["Name"] = "Nome"
	GRM_L["Join Date"] = "Data di Entrata"
	GRM_L["Promo Date"] = "Data Promozione"
	GRM_L["Main/Alt"] = "Main/Alt"
	GRM_L["Only Show Incomplete Guildies"] = "Mostra solo gildani Incompleti"

	-- ADDON SYSTEM MESSAGES
	GRM_L["Guild Roster Manager"] = "Guild Roster Manager"
	GRM_L["GRM:"] = "GRM:"                                                                -- Abbreviation for "Guild Roster Manager"
	GRM_L["(Ver:"] = "(Ver:"                                                               -- Ver: is short for Version:
	GRM_L["GRM Updated:"] = "GRM Aggiornato:"
	GRM_L["Configuring Guild Roster Manager for {name} for the first time."] = "Configurazione di Guild Roster Manager per {name} per la prima volta"
	GRM_L["Notification Set:"] = "Notifica impostata:"
	GRM_L["Report When {name} is ACTIVE Again!"] = "Riceverai una notifica quando {name} tornerà ATTIVO"
	GRM_L["Report When {name} Comes Online!"] = "Riceverai una notifica quando {name} tornerà ONLINE"
	GRM_L["Report When {name} Goes Offline!"] = "Riceverai una notifica quando {name} andrà OFFLINE"
	GRM_L["A new version of Guild Roster Manager is Available!"] = "Una nuova Versione del Guild Roster Manager è disponibile!"
	GRM_L["Please Upgrade!"] = "Per favore, fai l'Aggiornamento!"
	GRM_L["Player Does Not Have a Time Machine!"] = "I Giocatori non hanno una Macchina del Tempo!"
	GRM_L["Please choose a valid DAY"] = "Per favore scegli un GIORNO valido"
	GRM_L["{name} has been Removed from the Ban List."] = "{name} è stato rimosso dalla Lista Ban"
	GRM_L["Scanning for Guild Changes Now. One Moment..."] = "Scansione dei cambiamenti in corso. Un momento..."
	GRM_L["Initializing Sync Action. One Moment..."] = "Inizializzazione della sincronizzazione. Un momento..."
	GRM_L["No Players Currently Online to Sync With..."] = "Non ci sono giocatori Online con cui sincronizzarsi"
	GRM_L["SYNC is currently not possible! Unable to Sync with guildies when guild chat is restricted."] = "Non è possibile sincronizzare! Impossibile sincronizzare quando la chat di gilda è limitata"
	GRM_L["Manual Scan Complete"] = "Scansione Manuale completata"
	GRM_L["Analyzing guild for the first time..."] = "Prima scansione della gilda..."
	GRM_L["Building Profiles on ALL \"{name}\" members"] = "Costruzione profili di tutti i membri di \"{name}\""                -- {name} will be the Guild Name, for context
	GRM_L["NOTIFICATION:"] = "NOTIFICA:"                                               -- Context:  "Notification: Player is no longer AFK"
	GRM_L["{name} is now ONLINE!"] = "{name} è ONLINE!"
	GRM_L["{name} is now OFFLINE!"] = "{name} è andato OFFLINE!"
	GRM_L["{name} is No Longer AFK or Busy!"] = "{name} è tornato Disponibile!" 
	GRM_L["{name} is No Longer AFK or Busy, but they Went OFFLINE!"] = "{name} non è più AFK o Occupato, ma è andato OFFLINE!"
	GRM_L["Player should try to obtain group invite privileges."] = "Per favore, cerca di ottenere la possibilità di invitare in gruppo"
	GRM_L["{name}'s saved data has been wiped!"] = "I dati di {name} sono stati cancellati!"
	GRM_L["Wiping all Saved Roster Data Account Wide! Rebuilding from Scratch..."] = "Cancellazione di tutti i dati dell'account! Ricostruzione da zero..." --WIP
	GRM_L["Wiping all saved Guild data! Rebuilding from scratch..."] = "Cancellazione di tutti i dati della gilda! Ricostruzione da zero..." --WIP
	GRM_L["There are No Log Entries to Delete, silly {name}!"] = "Non ci sono Voci del Registro da cancellare"
	GRM_L["Guild Log has been RESET!"] = "Il Registro di Gilda è stato RESETTATO!"
	GRM_L["{name} is now set as \"main\""] = "{name} è stato impostato come \"main\""
	GRM_L["{name} is no longer set as \"main\""] = "{name} non è più impostato come \"main\""
	GRM_L["Reset All of {name}'s Data?"] = "Vuoi resettare tutti i dati di {name}?"

	-- /grm help
	GRM_L["Opens Guild Log Window"] = "Apre la finestra del Registro di Gilda"
	GRM_L["Resets ALL saved data"] = "Resetta TUTTI i dati"
	GRM_L["Resets saved data only for current guild"] = "Resetta i dati per la gilda corrente"
	GRM_L["Re-centers the Log window"] = "Centra la finestra del Registro"
	GRM_L["Triggers manual re-sync if sync is enabled"] = "Effettua manualmente la sincronizzazione se è abilitata"
	GRM_L["Does a one-time manual scan for changes"] = "Effettua una singola scansione dei cambiamenti "
	GRM_L["Displays current Addon version"] = "Mostra la versione corrente dell'Add-on"
	GRM_L["WARNING! Complete hard wipe, including settings, as if addon was just installed."] = "ATTENZIONE! Rimozione completa di tutti i dati, comprese le impostazioni, come se l'Add-On fosse stato appena installato";

	-- General Misc UI
	GRM_L["Really Clear All Account-Wide Saved Data?"] = "Vuoi davvero cancellare tutti i dati dell'account?"
	GRM_L["Really Clear All Guild Saved Data?"] = "Vuoi davvero cancellare tutti i dati della gilda?"
	GRM_L["Yes!"] = "Sì!"
	GRM_L["Ban Player?"] = "Bannare il Giocatore?"
	GRM_L["Ban the Player's {num} alts too?"] = "Vuoi bannare anche i {num} Alt?"      	-- Plural number of alts
	GRM_L["Ban the Player's {num} alt too?"] = "Vuoi bannare anche l'Alt?"     			-- Singular number of alts, just 1
	GRM_L["Please Click \"Yes\" to Ban the Player!"] = "Per favore, Clicca \"Sì\" per Bannare il Giocatore!"

	-- Sync Messages
	GRM_L["{name} updated {name2}'s Join Date."] = "{name} ha aggiornato la data di entrata di {name2}."
	GRM_L["{name} updated {name2}'s Promotion Date."] = "{name} ha aggiornato la data di promozione di {name2}."
	GRM_L["\"{custom1}\" event added to the calendar by {name}"] = "L'evento \"{custom1}\" è stato aggiunto al calendario da {name}"
	GRM_L["{name} updated {name2}'s list of Alts."] = "{name} ha aggiornato la lista degli Alt di {name2}."
	GRM_L["{name} removed {name2} from {custom1}'s list of Alts."] = "{name} ha rimosso {name2} dalla lista degli Alt di {custom1}."
	GRM_L["{name} set {name2} to be 'Main'"] = "{name} ha impostato {name2} come \"Main\""
	GRM_L["{name} has changed {name2} to be listed as an 'alt'"] = "{name} ha impostato {name2} come \"Alt\""
	GRM_L["{name} has Removed {name2} from the Ban List."] = "{name} ha rimosso {name2} dalla Lista Ban."
	GRM_L["{name} has been BANNED from the guild!"] = "{name} è stato BANNATO dalla Gilda!"
	GRM_L["{name} has been UN-BANNED from the guild!"] = "{name} è stato SBANNATO!"
	GRM_L["Initiating Sync with {name} Instead!"] = "Sincronizzazione con {name} iniziata"
	GRM_L["Sync Failed with {name}..."] = "Sincronizzazione con {name} fallita..."
	GRM_L["The Player Appears to Be Offline."] = "Sembra che il giocatore sia Offline" 
	GRM_L["Syncing Data With Guildies Now..."] = "Sincronizzazione con i gildani in corso..."
	GRM_L["(Loading screens may cause sync to fail)"] = "(Le schermate di caricamento possono causare il fallimento della sincronizzazione)"
	GRM_L["Sync With Guildies Complete..."] = "Sincronizzazione con i gildani completa..."

	-- ERROR MESSAGES
	GRM_L["Notification Has Already Been Arranged..."] = "Le notifiche sono già state impostate"
	GRM_L["Failed to add alt for unknown reason. Try closing Roster window and retrying!"] = "Aggiunta dell'Alt fallita per una ragione sconosciuta. Prova a chiudere l'elenco e ripova!"
	GRM_L["{name} is Already Listed as an Alt."] = "{name} è già impostato come Alt!"
	GRM_L["{name} cannot become their own alt!"] = "{name} non può essere Alt di se stesso!"
	GRM_L["Player Cannot Add Themselves as an Alt"] = "I giocatori non possono aggiungersi come Alt"
	GRM_L["Player Not Found"] = "Giocatore non trovato"
	GRM_L["Please try again momentarily... Updating the Guild Event Log as we speak!"] = "Per favore riprova tra un momento... sto aggiornando il registro mentra parliamo!"
	GRM_L["Invalid Command: Please type '/grm help' for More Info!"] = "Comando non valido: per favore, scrivi \"/grm help\" o \"/grm aiuto\" per altre informazioni!"
	GRM_L["{name} is not currently in a guild. Unable to Proceed!"] = "{name} non è in una gilda. Impossibile procedere!"
	GRM_L["Addon does not currently support more than 75 alts!"] = "Non è possibile impostare più di 75 Alt!"
	GRM_L["Please choose a VALID character to set as an Alt"] = "Per favore, scegli un personaggio VALIDO da impostare come Alt"
	GRM_L["Please choose a character to set as alt."] = "Per favore scegli un personaggio da impostare come Alt"
	GRM_L["GRM ERROR:"] = "ERRORE DI GRM:"
	GRM_L["Com Message too large for server"] = "Messaggio troppo grande per il server" --WIP                   -- Context: "Com message" is short-hand for "Communications message" - this is a technical error on syncing data.
	GRM_L["Prefix:"] = "Prefisso:"
	GRM_L["Msg:"] = "Msg:"                                                -- Context: Msg is short for Message
	GRM_L["Unable to register prefix > 16 characters: {name}"] = "Impossibile registrare il prefisso > di 16 caratteri: {name}"   -- Context: The {name} is the string code for the prefix. This is for debugging.

	--SLASH COMMANDS
	-- These are generally written in general shorthand. The original commands will ALWAYS work, but if there is one that makes more sense in your language, please feel free to modify
	GRM_L["clearall"] = "clearall"                        -- Context: In regards, "Clear All" saved data account wide 
	GRM_L["clearguild"] = "clearguild"                      -- Context: In regards, "Clear All" saved data from ONLY the current guild.
	GRM_L["hardreset"] = "hardreset"                       -- Context: In regards, "Hard Reset" ALL data account wide, including wiping player settings
	GRM_L["help"] = "aiuto"                            -- Context: "help" with info on the how to use addon
	GRM_L["version"] = "versione"                         -- Context: "version" of the addon
	GRM_L["center"] = "centra"                          -- Context: "center" the movable addon window back to center of screen
	GRM_L["sync"] = "sync"                            -- Context: "sync" the data between players one time now.
	GRM_L["scan"] = "scan"                            -- Context: "scan" for guild roster changes one time now.

	-- CLASSES
	GRM_L["Deathknight"] = "Cavaliere della Morte"
	GRM_L["Demonhunter"] = "Cacciatore di Demoni"
	GRM_L["Druid"] = "Druido"
	GRM_L["Hunter"] = "Cacciatore"
	GRM_L["Mage"] = "Mago"
	GRM_L["Monk"] = "Monaco"
	GRM_L["Paladin"] = "Paladino"
	GRM_L["Priest"] = "Sacerdote"
	GRM_L["Rogue"] = "Ladro"
	GRM_L["Shaman"] = "Sciamano"
	GRM_L["Warlock"] = "Stregone"
	GRM_L["Warrior"] = "Guerriero"
	-- TIME AND DATES
	GRM_L["1 Mar"] = "1 Mar"                           -- This date is used in a specific circumstance. If someone's anniversary/bday landed on a leap year (Feb 29th), it defaults to the 1st of March on non-leap year
	-- Full Month Name
	GRM_L["January"] = "Gennaio"
	GRM_L["February"] = "Febbraio"
	GRM_L["March"] = "Marzo"
	GRM_L["April"] = "Aprile"
	GRM_L["May"] = "Maggio"
	GRM_L["June"] = "Giugno"
	GRM_L["July"] = "Luglio"
	GRM_L["August"] = "Agosto"
	GRM_L["September"] = "Settembre"
	GRM_L["October"] = "Ottobre"
	GRM_L["November"] = "Novembre"
	GRM_L["December"] = "Dicembre"
	-- Shorthand Month
	GRM_L["Jan"] = "Gen"
	GRM_L["Feb"] = "Feb"
	GRM_L["Mar"] = "Mar"
	GRM_L["Apr"] = "Apr"
	GRM_L["Jun"] = "Giu"
	GRM_L["Jul"] = "Lug"
	GRM_L["Aug"] = "Ago"
	GRM_L["Sep"] = "Set"
	GRM_L["Oct"] = "Ott"
	GRM_L["Nov"] = "Nov"
	GRM_L["Dec"] = "Dic"
	-- Time Notifcation
	GRM_L["Seconds"] = "Secondi"
	GRM_L["Second"] = "Secondo"
	GRM_L["Minutes"] = "Minuti"
	GRM_L["Minute"] = "Minuto"
	GRM_L["Hours"] = "Ore"
	GRM_L["Hour"] = "Ora"
	GRM_L["Days"] = "Giorni"
	GRM_L["Day"] = "Giorno"
	GRM_L["Months"] = "Mesi"
	GRM_L["Month"] = "Mese"
	GRM_L["HourBreak"] = ":"            -- Context, in English, and many languages, 11am = 11:00 -- or in French, 11h00   - the hour break is the ":" or the "h" 

	GRM_L["am"] = "am"
	GRM_L["pm"] = "pm"
	GRM_L["24HR_Notation"] = "";        -- if someone is using 24hr time notation in your country, instead of 12hr, how do you notate it? In English, there is no am/pm (though "hours" is technically right, but unnecessary)

	GRM_L["{num} year"] = "{num} anno"
	GRM_L["{num} years"] = "{num} anni"
	GRM_L["{num} month"] = "{num} mese"
	GRM_L["{num} months"] = "{num} mesi"
	GRM_L["{num} day"] = "{num} giorno"
	GRM_L["{num} days"] = "{num} giorni"
	GRM_L["< 1 day"] = "< 1 giorno"

	GRM_L["{num} yr"] = "{num} anno"
	GRM_L["{num} yrs"] = "{num} anni"
	GRM_L["{num} mo"] = "{num} mese"
	GRM_L["{num} mos"] = "{num} mesi"
	GRM_L["{num} hr"] = "{num} ora"
	GRM_L["{num} hrs"] = "{num} ore"
	GRM_L["< 1 hour"] = "< 1 ora"
	GRM_L["{num} {custom1}"] = "{num} {custom1}"     -- Context: This is a placeholder for ANY generic time data -- Ex:  "1 year" or "15 months" - The translation is set this is just to set the orientation of the number properly.
		--

	-- MISC Punctuation
	GRM_L[","] = ","                               -- I know in some Asia languages, a comma is not used, but something similar, for example.

	-- Updates 1.126
	GRM_L["General"] = "Generale"
	GRM_L["General:"] = "Generale:"
	GRM_L["Scan"] = "Scansione"
	GRM_L["Help"] = "Aiuto"
	GRM_L["UI"] = "UI"                              -- UI for User Interface. Abbreviation for changing custom UI featuers, like coloring of <M> main
	GRM_L["Officer"] = "Ufficiale"                         -- as in, "Officer" rank
	GRM_L["Open Addon Window"] = "Apri la finestra dell'Add-on"
	GRM_L["Sync Addon Settings on All Alts in Same Guild"] = "Sincronizza le impostazioni dell'Add-on per tutti gli Alt nella stessa gilda"
	GRM_L["Show Minimap Button"] = "Mostra il bottone sulla minimappa"
	GRM_L["Player is Not Currently in a Guild"] = "Il giocatore non è attualmente in una gilda"
	-- tooltips
	GRM_L["|CFFE6CC7FClick|r to open GRM"] = "|CFFE6CC7FClicca|r per aprire GRM"                         -- Please maintain the color coding
	GRM_L["|CFFE6CC7FRight-Click|r to Reset to 100%"] = "|CFFE6CC7FClick destro|r per reimpostare al 100%"               -- for the Options slider tooltip
	GRM_L["|CFFE6CC7FRight-Click|r to Set Notification of Status Change"] = "|CFFE6CC7Click destro|r per impostare le notifiche del cambio di stato"
	-- tooltip end
	GRM_L["GRM"] = "GRM"
	GRM_L["Include Unknown as Incomplete"] = "Includi Sconosciuto tra gli Incompleti"                          -- Context: Unknown in the Audit Tab will be hidden if filtering out complete players
	GRM_L["You Do Not Have Permission to Add Events to Calendar"] = "Non hai i permessi per aggiungere eventi al calendario"
	GRM_L["Please Select Which Join Date to Sync"] = "Per favore, seleziona con quale data di entrata sincronizzare"
	GRM_L["Sync All Alts to {name}'s Join Date"] = "Sincronizza tutti gli Alt con la data di entrata di {name}"
	GRM_L["Sync All Alts to the Earliest Join Date: {name}"] = "Sincronizza tutti gli Alt alla data meno recente: {name}"
	GRM_L["Sync All Alts to {name}'s |cffff0000(main)|r Join Date"] = "Sincronizza tutti gli Alt alla data di entrata del |cffff0000(main)|r di {name}"  -- The coloring ensures that "(main)" maintains the RED color. Please keep it consistent if relevant to your language.
	GRM_L["Join Date of All Alts is Currently Synced"] = "La data di entrata di tutti gli Alt è sincronizzata"

	-- Update 1.130
	GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button."] = "|CFFE6CC7FCtrl-Shift-Clicca|r per nascondere questo bottone."
	GRM_L["Invited By:"] = "Invitato da:"
	GRM_L["Error: Guild Not Found..."] = "Errore: Gilda non trovata..."
	GRM_L["Debugger Start"] = "Inizio Debug";

	-- Update 1.136
	GRM_L["Backup Point Removed for Guild \"{name}\""] = "Punto di ripristino per la gilda \"{name}\" rimosso"
	GRM_L["Backup Point Restored for Guild \"{name}\""] = "Ripristino effettuato per la gilda \"{name}\""
	GRM_L["Backup Point Set for Guild \"{name}\""] = "Punto di ripristino per la gilda \"{name}\" creato"
	GRM_L["Backup"] = "Backup"
	GRM_L["Horde"] = "Orda"
	GRM_L["Alliance"] = "Alleanza"
	GRM_L["Creation Date"] = "Data creazione"
	GRM_L["Members"] = "Membri"
	GRM_L["None"] = "Nessuno"
	GRM_L["Restore"] = "Ripristina"
	GRM_L["Set Backup"] = "Imposta Backup"
	GRM_L["Memory Usage: {num} MB"] = "Memoria utilizzata: {num} MB"          -- MB references the number of MegaBytes of memory used.

	-- Update 1.137
	GRM_L["GRM: Unable to Create Backup for a Guild With Unknown Creation Date! Log into that guild on any alt to update old database."] = "GRM: è impossibile creare un Backup senza sapere la data di creazione della Gilda! Entra con un qualsiasi Alt in gilda per aggiornare il database."
	GRM_L["Really restore {name} Backup Point?"] = "Vuoi davvero tornare al punto di ripristino {name}"
	GRM_L["Check All"] = "Seleziona tutto"

	-- Update 1.139
	GRM_L["Right-Click for options to remove this guild from the addon database completely"] = "Click destro per rimuovere completamente questa gilda dalla memoria dell'dd-on"
	GRM_L["Player Cannot Purge the Guild Data they are Currently In!!!"] = "Un giocatore non può rimuovere i dati della gilda in cui si trova!"
	GRM_L["To reset your current guild data type '/grm clearguild'"] = "Per resettare i dati della gilda corrente, scrivi '/grm clearguild'"
	GRM_L["Click Here to Remove all traces of this guild, or hit ESC"] = "Clicca per rimuovere ogni traccia di questa gilda, oppure premi ESC"
	GRM_L["{name} has been removed from the database."] = "{name} è stato rimosso dalla memoria"              -- The Guild Name has been removed from the database

	-- update 1.141
	GRM_L["Only Restrict Incoming Player Data to Rank Threshold, not Outgoing"] = "Limita, in base al grado, solo i dati in ingresso, non in uscita"
	GRM_L["Total Entries: {num}"] = "Voci totali: {num}"
	GRM_L["Search Filter"] = "Cerca nel Registro"

	-- update 1.142
	GRM_L["Choose Color:"] = "Scegli colore"
	GRM_L["Format:"] = "Formato"
	GRM_L["RGB Values Must be Between 1 and 255."] = "I valori RGB devono essere compresi tra 1 e 255."

	-- Update 1.143
	GRM_L["The Log is Currently Empty for This Guild"] = "Il registro di questa gilda è vuoto"
	GRM_L["Building Log for Export..."] = "Creazione Registro da esportare..."
	GRM_L["Open Log Tools"] = "Apri Strumenti Registro"
	GRM_L["Hide Log Tools"] = "Nascondi Strumenti Registro"
	GRM_L["Numbered Lines"] = "Linee numerate"
	GRM_L["Export Log"] = "Esporta Registro"
	GRM_L["Clear Lines:"] = "Elimina righe da"
	GRM_L["Enable Ctrl-Shift-Click Line Removal"] = "Abilita la rimozione con Ctrl-Shift-Click"
	GRM_L["To"] = "a"                                     -- Clear Lines:  50 To 100     -- It stands between 2 edit boxes as its own fontstring, so work with that.
	GRM_L["Confirm Clear"] = "Conferma elimina"
	GRM_L["Please Select Range of Lines from the Log You Wish to Remove"] = "Per favore, seleziona l'intervallo di righe che desideri rimuovere"
	GRM_L["Please put the lowest number in the first box"] = "Per favore, inserisci il numero più basso nella prima casella"
	GRM_L["Line selection is not valid"] = "Selezione righe non valida"
	GRM_L["Really Clear lines {custom1} to {custom2}?"] = "Vuoi davvero eliminare le righe da {custom1} a {custom2}? "
	GRM_L["Enabling Line Numbers... Please choose within the given range"] = "Sto abilitando il numero delle righe... Per favore, scegli dei valori nell'intervallo"
	GRM_L["Ctrl-C to Copy <> Ctrl-P to Paste <> Ctrl-A to Select All"] = "Ctrl-C copia <> Ctrl-P incolla <> Ctrl-A seleziona tutto"
	GRM_L["Language Selection:"] = "Seleziona linguaggio:"
	GRM_L["{num} phrases still need translation to {name}"] = "{num} frasi ancora da tradurre in italiano"                  -- Ex: 300 phrases still need translation to German

	-- update 1.145
	GRM_L["You currently are at {num} non-Battletag friends. To fully take advantage of all of GRM features, please consider clearing some room."] = "Attualmente hai {num} amici non Battle-tag. Per sfruttare appieno le funzioni di GRM considera di fare un po' di spazio."

	-- Update 1.146
	GRM_L["Really Clear line {num}?"] = "Vuoi davvero eliminare la riga {num}"
	GRM_L["Font has been Reset to DEFAULT."] = "Il carattere è stato reimpostato"
	GRM_L["Font Selection:"] = "Seleziona carattere:"
	GRM_L["Font Scale:"] = "Dimensione carattere:"
	GRM_L["Example"] = "Esempio"
	GRM_L["Right-Click to Reset to 100%"] = "Click destro per reimpostare al 100%"

	-- Update 1.147
	GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Search the Log for Player"] = "|CFFE6CC7FCtrl-Shift-Click|r per cercare il player nel Registro"

	-- Update 1.1480
	GRM_L["Custom Notes:"] = "Nota Personalizzata:"
	GRM_L["GRM Debugging Enabled."] = "Debug GRM abilitato"
	GRM_L["GRM Debugging Disabled."] = "Debug GRM disabilitato"
	GRM_L["Please type \"/grm debug 10\" to report 10 events (or any number)"] = "Per favore, scrivi \"/grm debug 10\" per un rapporto di 10 eventi (o un altro numero)"       -- Please keep the \"/grm debug 10)\" in-tact for slash command to work
	GRM_L["Format: \"/grm debug 10\""] = "Formato: \"/grm debug 10\""                                                                  -- "" Likewise
	GRM_L["Error: Debug Command not recognized."] = "Error: comando di debug non riconosciuto."
	GRM_L["You may want to temporarily disable SYNC in the options if you are debugging another feature."] = "Potresti voler disattivare la sincronizzazione se stai facendo debug di qualcos'altro"
	GRM_L["Sync Custom Notes"] = "Sincronizza le Note Personalizzate"
	GRM_L["Default Custom Note Rank Minimum"] = "Grado minimo Predefinito per sincronizzare"
	GRM_L["Reset Default Custom Note Restrictions for ALL Guildies"] = "Reimposta le restrizioni Predefinite per TUTTI i gildani"
	GRM_L["Reset"] = "Reimposta"
	GRM_L["|CFF00CCFFDefault Selection For All Players"] = "|CFF00CCFFImpostazione predefinita per tutti i giocatori"
	GRM_L["Click here to set Custom Notes"] = "Clicca per impostare una Nota Personalizzata"
	GRM_L["|CFF00CCFFCustom Note Defaults:"] = "|CFF00CCFFNota Personalizzata predefinita:"
	GRM_L["|CFFE6CC7FLeft-Click|r to re-enable custom note sync for all"] = "|CFFE6CC7FClick Sinistro|r per riabilitare la sincronizzazione\ndelle Note Personalizzate per tutti"
	GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Added"] = "{name} ha modificato la Nota Personalizzata di {name2}: \"{custom1}\" è stato aggiunto"
	GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Removed"] = "{name} ha modificato la Nota Personalizzata di {name2}: \"{custom1}\" è stato rimosso"
	GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" to \"{custom2}\""] = "{name} ha modificato la Nota Personalizzata di {name2} da \"{custom1}\" a \"{custom2}\""
	GRM_L["Custom Note"] = "Nota Personalizzata"
	GRM_L["|CFFE6CC7FClick|r to Change Rank Restriction"] = "|CFFE6CC7FClicca|r per cambiare le restrizioni sul Grado"
	GRM_L["|CFFE6CC7FClick|r to Change Day"] = "|CFFE6CC7FClicca|r per cambiare il Giorno"
	GRM_L["|CFFE6CC7FClick|r to Change Month"] = "|CFFE6CC7FClicca|r per cambiare il Mese";
	GRM_L["|CFFE6CC7FClick|r to Change Year"] = "|CFFE6CC7FClicca|r per cambiare l'Anno";
	GRM_L["Edited by {name}"] = "Modificata da {name}"
	GRM_L["Note Removed by {name}"] = "Nota rimossa da {name}"
	GRM_L["|CFFFF0000Player No Longer in Guild"] = "|CFFFF0000Giocatore non più in Gilda"
	GRM_L["|CFF00CCFFMinimum Rank to Sync: Player Data, Ban List"] = "|CFF00CCFFGrado Minimo per sincronizzare: Dati Giocatori, Lista Ban"
	GRM_L["Warning! Ban List rank threshold is below the overall sync rank. Changing from \"{name}\" to \"{name2}\""] = "Attenzione! Il grado per modificare la Lista Ban è più basso di quello generale di sincronizzazione. Lo sto cambiando da \"{name}\" a \"{name2}\""
	GRM_L["|CFF00CCFFSync filter can be set tighter for the Ban List"] = "|CFF00CCFFI filtri della sincronizzazione possono essere più ristretti per la Lista Ban"
	GRM_L["Warning! Unable to select a Ban List rank below \"{name}\""] = "Attenzione! Impossibile selezionare il grado per la Lista Ban al di sotto di \"{name}\""
	GRM_L["Setting to match core filter rank"] = "Impostata per corrispondere al Grado del filtro principale" --WIP

	-- R1.1482
	GRM_L["Shift-Click Name On Roster Also Works"] = "Oppure fai Shift-Click sul nome nell'elenco "
	GRM_L["Tooltip Scale:"] = "Dimensione Tooltip:"
	GRM_L["|CFFE6CC7FLeft-Click|r to Change the Language"] = "|CFFE6CC7FClicca|r per cambiare la Lingua"
	GRM_L["|CFFE6CC7FLeft-Click|r to Change Display Format"] = "|CFFE6CC7FClicca|r per cambiare il Formato"
	GRM_L["|CFFE6CC7FLeft-Click|r to Change the Font"] = "|CFFE6CC7FClicca|r per cambiare il Carattere"

	-- R1.1490
	GRM_L["Unable to properly locate guild for backup"] = "Impossibile trovare una gilda per il backup" --WIP

	-- R1.1500
	GRM_L["Unique accounts pull from the server is known to be faulty"] = "L'importazione degli account dai server ha dei problemi,"
	GRM_L["Use only as an estimate. Hopefully Blizz fixes this soon"] = "utilizzala solo come stima. Si spera che la Blizzard risolva presto"
	GRM_L["{name}'s Birthday!"] = "Compleanno di {name}!"
	GRM_L["Add Upcoming Events to the Calendar"] = "Aggiungi gli eventi imminenti al Calendario"
	GRM_L["Player rank unable to add events to calendar"] = "I giocatori con questo grado non possono aggiungere eventi al calendario"
	GRM_L["Anniversaries, Birthdays, and Other Events can be added with permission"] = "Anniversari, Compleanni, ed altri eventi possono essere aggiunti con il permesso" --WIP

	-- R1.1510
	GRM_L["Check the \"Sync Users\" tab to find out why!"] = "Controlla la scheda \"Sincronizza\" per capire perché!"
	GRM_L["Time as Member:"] = "Membro da:"
	GRM_L["|CFFE6CC7FClick|r to select player event"] = "|CFFE6CC7FClicca|r per selezionare un evento"
	GRM_L["Timestamp Format:"] = "Formato Data e Ora"
	GRM_L["Hour Format:"] = "Formato Orario"
	GRM_L["24 Hour"] = "24 Ore"
	GRM_L["12 Hour (am/pm)"] = "12 Ore (am/pm)"
	GRM_L["Enable Fade on Tab Change"] = "Abilita la dissolvenza sul cambio scheda"
	GRM_L["Confirm Custom Note"] = "Conferma Nota Personalizzata"
	
	-- R1.1520
	GRM_L["A new rank has been added to the guild!"] = "Un nuovo grado è stato aggiunto alla gilda!"
	GRM_L["{num} new ranks have been added to the guild!"] = "{num} nuovi gradi sono stati aggiunti alla gilda!"
	GRM_L["The guild has removed a rank!"] = "Un grado è stato rimosso dalla gilda!"
	GRM_L["{num} guild ranks have been removed!" ] = "{num} gradi sono stati rimossi!"
	GRM_L["Edit Ban"] = "Modifica\nBan"
	GRM_L["Please Select a Player to Edit their Ban!"] = "Per favore, seleziona un giocatore per modificare il Ban!"
	GRM_L["Update Ban"] = "Aggiorna Ban"
	GRM_L["{name}'s Ban Info has Been Updated!"] = "Le informazioni sul Ban di {name} sono state aggiornate!"
	
	-- R1.1530
	GRM_L["{name} plays the {custom1} class, not {custom2}."] = "{name} gioca un {custom1}, non un {custom2}."             -- Example: Arkaan plays the Hunter class, not Paladin.
	GRM_L["{num} Items Updated"] = "{num} voci sono state aggiornate"
	GRM_L["You Currently Have Disabled Adding Events to Calendar"] = "La possibilità di aggiungere eventi al calendario è disabilitata"

	-- R1.20
	GRM_L["|CFFE6CC7FHold Shift|r to view more alt details."] = "|CFFE6CC7FTieni premuto Shift|r per vedere più dettagli sull'alt."                -- "Hold Shift to view more alt details" is the phrase, but the |CFF|r is the text coloring hex code. Please keep it in there on the keyboard command coloring
	GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7FClicca|r per vedere più dettagli sull'alt."
	GRM_L["{custom1} to keep alt details open."] = "{custom1} per tenere la finestra dei dettagli aperta."               -- The same can be said here. ^^
	GRM_L["|CFFE6CC7FClick|r to flip player name ordering"] = "|CFFE6CC7FClicca|r per capovolgere l'ordine dei nomi" --WIP                 -- and the reset...
	GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Newest"] = "|CFFE6CC7FClicca|r per ordinare le date di entrata dalla più recente"
	GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Oldest"] = "|CFFE6CC7FClicca|r per ordinare le date di entrata dalla più vecchia"
	GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Newest"] = "|CFFE6CC7FClicca|r per ordinare le date di promozione dalla più recente"
	GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Oldest"] = "|CFFE6CC7FClicca|r per ordinare le date di promozione dalla più vecchia"
	GRM_L["|CFFE6CC7FClick|r to sort all Mains first"] = "|CFFE6CC7FClicca|r per ordinare mettendo prima tutti i Main"
	GRM_L["|CFFE6CC7FClick|r to sort all Alts first."] = "|CFFE6CC7FClicca|r per ordinare mettendo prima tutti gli Alt."
	GRM_L["{name}'s Alts"] = "Alt di {Name}"                                   -- Like "Arkaan's Alts"
	GRM_L["GRM window will open when combat ends."] = "La finestra di GRM si aprirà alla fine del combattimento"
	
	-- R1.24
	GRM_L["This also will change the <Alt> format to match"] = "Anche il formato degli <Alt> verrà cambiato"
	GRM_L["M"] = "M"                                           -- Of note, the "M" is short for "Main" and this is the reference to the main tag on alts in guild chat. For use in the Main tagging <M> (M) etc...
	GRM_L["A"] = "A"          

	-- R1.25
	GRM_L["Include \"Joined:\" tag with the date."] = "Utilizza la tag \"Entrato il:\" assieme alla data"                                          -- the \" is so you include the qutoations in the actual text. You need them or it closes the phrase.
	GRM_L["GRM Auto-Detect! {name} has joined the guild and will be set as Main"] = "GRM Auto-Detect! {name} è entrato in gilda ed è stato impostato come Main"            -- Main auto-detect message

	-- R1.26
	GRM_L["Click to Disable Sync of Custom Note"] = "Clicca per disattivare la sincronizzazione delle Note Personalizzate"
	GRM_L["Click to Enable Sync of Custom Note"] = "Clicca per attivare la sincronizzazione delle Note Personalizzate"

	-- R1.27
	GRM_L["Show Border on Public, Officer, and Custom Notes"] = "Mostra il bordo nelle note Pubbliche, Ufficiali, e Personalizzate"

	-- R1.28
	GRM_L["Public Note:"] = "Nota Pubblica:"
	GRM_L["Officer Note:"] = "Nota Ufficiali:"
	GRM_L["Public Note"] = "Nota Pubblica"
	GRM_L["Officer Note"] = "Nota Ufficiali"
	GRM_L["Show Public, Officer, and Custom Notes on Log Entries of Left Players"] = true
	GRM_L["Hard Reset"] = "Reset Totale"
	GRM_L["Hard reset of ALL GRM data, account-wide. Game will reload!"] = "Reset TOTALE dei dati di GRM, per tutto l'account.\n Il gioco verrà ricaricato!"
	GRM_L["Only recommend to kick if all player linked alts exceed max time"] = "Raccomanda di rimuovere solo se tutti gli alt del giocatore superano il tempo massimo"
	GRM_L["Your Guild Leader Has Set Sync Restrictions to {name} or Higher"] = "Il Capo Gilda ha impostato le restrizioni per la sincronizzazione a {name} o più"
	GRM_L["Unable to Change Rank. Guild Leader has set restriction to {name} or higher"] = "Impossibile cambiare il Grado. Il Capo Gilda ha impostato le restrizioni a {name} o più"    -- Like Initiate or higher
	GRM_L["Unable to Change Rank. Guild Leader has set restriction level."] = "Impossibile cambiare il Grado. Il Capo Gilda ha impostato delle restrizioni"
	GRM_L["Force Settings with Guild Info Tags"] = "Tag per forzare le impostazioni dalle info di Gilda"
	GRM_L["Database Still Loading. GRM will open automatically when finished."] = "Il database si sta caricando. GRM si aprirà automaticamente quando il caricamento è finito."

	-- R1.29
	GRM_L["The highlighted character is not valid for messages. Please remove."] = "Il carattere evidenziato non è utilizzabile nei messaggi. Per favore rimuovilo."
	GRM_L["Not all characters are valid. Please remove any non-text characters."] = "Ci sono dei caratteri che non sono validi. Per favore rimuovi tutti i caratteri non di testo" --WIP
	GRM_L["Kick macro created. Press \"CTRL-SHIFT-K\" to kick all of {name}'s alts"] = "Macro per rimuovere creata. Premi \"CTRL-SHIFT-K\" per cacciare tutti gli alt di {name}"
	GRM_L["Kick the Player's {num} alts too?"] = "Vuoi rimuovere anche gli alt? ({num} alt)"       -- Plural
	GRM_L["Kick the Player's {num} alt too?"] = "Vuoi rimuovere anche l'alt?"        -- Not Plural  - "Kick the Player's 1 alt too?"
	GRM_L["Ban and Kick the Player's {num} alts too?"] = "Vuoi bannare e rimuovere anche gli alt? ({num} alt)"
	GRM_L["Ban and Kick the Player's {num} alt too?"] = "Vuoi bannare e rimuovere anche l'alt?"


	-- R1.30
	GRM_L["Sync With {name} is Complete..."] = "La sincronizzazione con {name} è completa..."
	GRM_L["|CFFE6CC7FLeft-Click|r and drag to move this button."] = "|CFFE6CC7FLeft-Clicca|r e trascina per spostare questo tasto."
	GRM_L["{custom1} and drag to move this button anywhere."] = "{custom1} e trascina per spostare questo tasto ovunque."
	GRM_L["MOTD:"] = "MDG:"       -- Message Of The Day = M.O.T.D = MOTD - 
	GRM_L["minimap"] = "minimappa"

	-- R1.31
	GRM_L["Show 'Main' Tag on both Mains and Alts in Chat"] = "Mostra la tag \"Main\" in chat sia per i Main che per gli Alt"

	-- R1.32
	GRM_L["GRM has moved the Guild Leader setting restriction codes to the Guild Info tab."] = "GRM ha spostato le impostazioni delle restrizioni per i Capo Gilda nella finestra delle informazioni della Gilda"
	GRM_L["Please make room for them and re-add."] = "Per favore, fai spazio e poi invita di nuovo"
	GRM_L["Your Guild Leader Has Set BAN Sync Restrictions to {name} or Higher"] = "Il Capo Gilda ha impostato la restrizione della sincronizzazione dei BAN a {name} o più"
	GRM_L["Your Guild Leader Has Set CUSTOM NOTE Sync Restrictions to {name} or Higher"] = "Il Capo Gilda ha impostato la restrizione della sincronizzazione delle NOTE PERSONALIZZATE a {name} o più"

	-- R1.33
	GRM_L["Macro will auto-remove after {num} seconds."] = "La macro si cancellerà in {num} secondi."
	GRM_L["UI Controls"] = "Impostazioni UI"
	GRM_L["UI Configuration:"] = "Configurazione UI"
	GRM_L["Show Character Guild Reputation"] = "Mostra la Reputazione di Gilda del personaggio"
	GRM_L["Show Guild Member Birthdays"] = "Mostra i Compleanni dei membri di Gilda"
	GRM_L["Set Birthday"] = "Imposta"
	GRM_L["Edit Birthday"] = "Modifica"
	GRM_L["Remove Date"] = "Rimuovi Data"             -- Clear Birthday shorthand
	GRM_L["Birthday"] = "Compleanno"
	GRM_L["Only Announce Birthdays and Anniversaries if Listed as 'Main'"] = "Annuncia i compleanni e gli anniversari solo dei Main"
	GRM_L["{name} will be celebrating {num} year in the Guild!"] = "{name} sta per compiere {num} anno in Gilda!"            -- {custom1} will reference the DATE. Ex: "Arkaan will be celebrating 1 year in the Guild! ( 1 May )" - SINGULAR
	GRM_L["{name} will be celebrating {num} years in the Guild!"] = "{name} sta per compiere {num} anni in Gilda!"           -- Same thing but PLURAL - "years" in stead of "year"
	GRM_L["No player's currently available to sync {name}'s Guild Data..."] = "Nessun giocatore disponibile per sincronizzare i dati di {name}"
	GRM_L["{name} has set {name2}'s Birthday: {custom1}"] = "{name} ha impostato il compleanno di {name2} al: {custom1}"                  -- custom note is the date like "12 Dec"
	GRM_L["{name}'s Birthday has been set: {custom1}"] = "Il compleanno di {name} è stato impostato al: {custom1}"
	GRM_L["Sync Birthdays"] = "Sincronizza Compleanni"
	
	-- R1.34
	GRM_L["Debugging Enabled"] = "Debugging Abilitato"
	GRM_L["Debugging Disabled"] = "Debugging Disabilitato"
	GRM_L["{num} is not a valid day of the month! It must be a number between 1 and 31"] = "{num} non è un giorno del mese valido! Deve essere un numero tra 1 e 31"
	GRM_L["{num} is not a valid index of the month of the year! It must be a number between 1 and 12"] = "{num} non è un numero valido per i mesi! Deve essere un numero tra 1 e 12"
	GRM_L["The day cannot be {num}. It must be a number between 1 and 31"] = "Il giorno non può essere {num}. Deve essere un numero tra 1 e 31"
	GRM_L["The month cannont be {num}. must be a number between 1 and 12"] = "Il mese non può essere {num}. Deve essere un numero tra 1 e 12"
	GRM_L["{num} birthdays have been reset."] = "{num} compleanni sono stati reimpostati"
	GRM_L["No player was found to have that birthday."] = "Non sono stati trovati giocatori con quel compleanno"

	-- R1.35
	GRM_L["Your Guild Leader Has Set Join Dates to only be added to the {name}"] = "Il Capo Gilda ha impostato il salvataggio delle date di entrata nelle {name}"         -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...
	GRM_L["Warning - Global Controls:"] = "Attenzione - Controlli globali:"
	GRM_L["Sync Restrictions Globally Changed to {name} or Higher"] = "Tutte le restrizioni della sincronizzazione cambiate a {name} o più"
	GRM_L["BAN Sync Restrictions Globally Changed to {name} or Higher"] = "Tutte le restrizioni della sincronizzazione dei BAN cambiate a {name} o più"
	GRM_L["CUSTOM NOTE Sync Restrictions Globally Changed to {name} or Higher"] = "Tutte le restrizioni della sincronizzazione delle NOTE PERSONALIZZATE cambiate a {name} o più"
	GRM_L["Join Dates Globally Changed to only be added to the {name}"] = "Le date di entrata verranno salvate solo nelle {name}"
	GRM_L["Unable to Modify. Global setting is set to the {name}"] = "Impossibile modificare. La data può essere aggiunta solo nelle {name}"                           -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...

	-- R1.37
	GRM_L["No Action Configured"] = "Nessuna azione impostata"
	GRM_L["OLD LOG"] = "VECCHIO REGISTRO"
	GRM_L["CHANGES"] = "CAMBIAMENTI"
	GRM_L["Sync has failed to start. Please try again!"] = "La sincronizzazione non si è avviata. Per favore prova di nuovo!"
	GRM_L["Please wait {num} more seconds before manually initiating the sync process again."] = "Aspetta {num} secondi in più prima di iniziare di nuovo la sincronizzazione"

	-- R1.39
	GRM_L["Only Report if there are no Active Alts in the Group"] = "Avvisami solo se non ci sono Alt Attivi"
	GRM_L["Level Filter Minimum:"] = "Livello minimo del filtro:"                                -- As in player level
	GRM_L["Report Milestones:"] = "Segnala i Traguardi:"
	GRM_L["Report Level Up Changes"] = "Segnala gli avanzamenti di livello"
	GRM_L["Reporting:"] = "Segnala:"
	GRM_L["Unable to disable level cap tracking. Please disable ALL tracking to turn off."] = "Impossibile disabilitare il monitoraggio del livello massimo. Per disattivarlo disabilita il tracciamento di tutti i cambi di livello."
	GRM_L["No Levels to Report to Log"] = "Nessun livello verrà segnalato nel Registro"
	GRM_L["{name} has Surpassed their Level {num} Milestone and is Now {custom1}"] = "{name} ha superato il Traguardo del {num} ed è {num1}"
	GRM_L["{name} has Reached their Level {num} Milestone"] = "{name} ha raggiunto il Traguardo del livello {num}"
	GRM_L["{name}'s Ban has been Updated by {name2}!"] = "{name2} ha aggiornato il BAN di {name}"
	GRM_L["{name} has Updated {name2}'s BAN and also BANNED all linked alts from the guild!"] = "{name} ha aggiornato il BAN di {name2} ed ha Bannato anche tutti i suoi Alt in gilda!"
	GRM_L["One moment, GRM is still being configured."] = "Un momento, GRM si sta ancora configurando"
	GRM_L["Press ENTER to complete"] = "Premi\nINVIO per completare"
	GRM_L["Player Was Banned By: {name}"] = "Giocatore Bannato da: {name}"
	GRM_L["|cffff0000WARNING!!!|r {num} BANNED players are currently in the guild."] = "|cffff0000ATTENZIONE!!!|r {num} giocatori Bannati sono ancora in gilda!"     -- plural
	GRM_L["|cffff0000WARNING!!!|r {num} BANNED player is currently in the guild."] = "|cffff0000ATTENZIONE!!!|r {num} giocatore Bannato è ancora in gilda!"        -- Singular  -- please keep the color coding... this keeps the Warning in red
	
	-- R1.41  
	GRM_L["Auto-Focus the search box"] = "Auto-focus della casella di ricerca"
	GRM_L["This will skip the first time if set to load on logon"] = "Non funzionerà all'avvio, se l'impostazione \"Mostra all'avvio\" è attivata"  -- Referring to the auto-focusing on the search box, this is a tooltip helper
	GRM_L["Please enter a valid level between 1 and {num}"] = "Per favore, inserisci un livello tra 1 e {num}"
	GRM_L["Player's Main: {name}"] = "Main: {name}"

	-- R1.43
	GRM_L["One moment, requesting additional details on {name} from the server. Ban List will soon update."] = "Un momento, sto richiedendo altri dettagli su {name} al server. La lista dei Ban verrà aggiornata a breve."
	GRM_L["Unable to identify {name}. Ensure your spelling is accurate! Otherwise, they may have left the server."] = "Impossibile identificare {name}. Controlla di aver scritto il nome correttamente! In caso contrario, {name} potrebbe non essere più nel server."
	GRM_L["(Unable to Identify)"] = "(Impossibile identificare)"                                                                    -- As in, unable to identify on the server, they possibly server transferred off but are still on ban list
	GRM_L["|CFFE6CC7FClick|r to select player class"] = "|CFFE6CC7FClicca|r per selezionare la classe del giocatore"
	GRM_L["|CFFE6CC7FClick|r to select player's realm."] = "|CFFE6CC7FClicca|r per selezionare il reame del giocatore"
	GRM_L["All Connected Realms are available to choose."] = "Tutti i Reami connessi sono disponibili per la scelta"
	GRM_L["{num} players were found to have the same name. Please manually select which connected realm the player you wish to ban is on."] = "Trovati {num} giocatori con lo stesso nome. Per favore seleziona a quale reame appartiene il giocatore che vuoi bannare."
	GRM_L["Click or Press TAB to cycle through each step."] = "Clicca o premi Tab per scorrere tra le opzioni"
	GRM_L["Former and Current Members"] = "Ex e attuali membri"
	GRM_L["No Matches Found. Add a Custom New Player or Match"] = "Nessun riscontro trovato." --WIP      -- as in, autocomplete typing matching
	
	--1.50
	GRM_L["{name}'s alt grouping has had their Birthday removed by: {name2}"] = "Il compleanno del gruppo di alt di {name} è stato rimosso da {name2}"
	GRM_L["{name}'s Birthday has been removed by: {name2}"] = "Il compleanno di {name} è stato rimosso da {name2}"
	GRM_L["Click to Sort"] = "Clicca per riordinare"
	GRM_L["No Updates"] = "Nessun aggiornamento"
	GRM_L["Timestamp Formatting has been Globally Set to: < {name} >"] = "Il formato di data e ora è stato impostato globalmente come: < {name} >"
	GRM_L["Your Guild Leader Has Globally Set the Timestamp Formatting to: < {name} >"] = "Il tuo capogilda ha impostato globalmente il formato di data e ora come: < {name} >"
	GRM_L["Unable to Modify. Global setting is set to :   {name}"] = "Impossibile modificare. Le impostazioni globali sono: < {name} >"

	-- If ppossible, try to maintain the allignment of the numbers, but only if it makes sense.
	GRM_L["{num}{custom1}: Join Dates"] = "{num}{custom1}: Date di entrata"
	GRM_L["{num}{custom1}: Promo Dates"] = "{num}{custom1}: Date di promozione"
	GRM_L["{num}{custom1}: Alts"] = "{num}{custom1}: Alt"
	GRM_L["{num}{custom1}: Main Tags"] = "{num}{custom1}: Main"
	GRM_L["{num}{custom1}: Custom Notes"] = "{num}{custom1}: Note Personalizzate"
	GRM_L["{num}{custom1}: Birthdays"] = "{num}{custom1}: Compleanni"
	
	-- 1.52
	GRM_L["Times in Guild: {num}"] = "In Gilda da: {num}"
		
		-- 1.56
	-- More slash commands
	GRM_L["kick"] = "rimuovi"
	GRM_L["ban"] = "ban"
	GRM_L["audit"] = "verifica"
	GRM_L["log" ] = "registro"
	GRM_L["event"] = "evento"
	GRM_L["events"] = "eventi"
	GRM_L["users"] = "utenti"
	GRM_L["syncusers"] = "sincro"
	GRM_L["opt"] = "opz"
	GRM_L["option"] = "opzione"
	GRM_L["options"] = "opzioni"

	GRM_L["GRM Date"] = "Data GRM"
	GRM_L["Note Date"] = "Data Nota"
	GRM_L["Status"] = "Status"
	GRM_L["Refresh"] = "Aggiorna"
	GRM_L["Clear Selection"] = "Annulla selezione"  --WIP
	GRM_L["Fix all mismatched note dates with GRM saved date"] = "Sostituisci tutte le date delle note non corrispondenti con le date salvate da GRM"
	GRM_L["Fix selected mismatched note dates with GRM saved date"] = "Sostituisci le date delle note non corrispondenti selezionate con le date di GRM"
	GRM_L["Fix all mismatched GRM dates with the note date"] = "Sostituisci tutte le date salvate da GRM non corrispondenti con le date delle note"
	GRM_L["Fix selected mismatched GRM dates with the note date"] = "Sostituisci le date di GRM non corrispondenti selezionate con le date delle note"
	GRM_L["Import all missing join dates from the note date"] = "Importa tutte le date di entrata mancanti dalle note"
	GRM_L["Import selected missing join dates from the note date"] = "Importa le date di entrata mancanti selezionate dalle note"
	GRM_L["Add all missing saved dates to the {name}"] = "Aggiungi tutte le date salvate mancanti alle {name}"
	GRM_L["Add selected missing saved dates to {name}"] = "Aggiungi le date salvate mancanti selezionate alle {name}"
	GRM_L["Clear all join dates from incorrect note locations"] = "Cancella tutte le date di entrata dal tipo di nota sbagliata"
	GRM_L["Clear selected join dates from incorrect note locations"] = "Cancella le date di entrata selezionate dal tipo di nota sbagliata"
	GRM_L["Not Found"] = "Non trovato"
	GRM_L["Not Set"] = "Non impostato"
	GRM_L["Complete"] = "Completo"
	GRM_L["Multiple"] = "Multiplo"
	GRM_L["Location"] = "Posizione"

	-- JD tool button actions and tooltips
	GRM_L["|CFFE6CC7FShift-Click|r Second Button to Select All In-Between"] = "|CFFE6CC7FShift-Click|r un secondo giocatore per selezionare anche quelli in mezzo"
	GRM_L["|CFFE6CC7FClick|r to select player"] = "|CFFE6CC7FClicca|r per selezionare un giocatore"
	GRM_L["Only Show Players With Incomplete Status"] = "Mostra solo i giocatori con status incompleto"
	GRM_L["{num} Join Dates Need Attention"] = "{num} date di entrata necessitano attenzione "             -- In other words, "155 join dates need attention" as an example
	GRM_L["Do you really want to remove the join dates from notes other than the {name}?"] = "Vuoi davvero rimuovere le date di entrata da tutte le note tranne le {name}?"
	GRM_L["Do you really want to fix mismatched dates using the note?"] = "Vuoi davvero sostituire le date non corrispondenti utilizzando le note?"
	GRM_L["Do you really want to fix note dates using the saved GRM dates?"] = "Vuoi davvero sostituire le date non corrispondenti utilizzando le date di GRM?"
	GRM_L["Do you really want to add the missing join dates to the {name}?"] = "Vuoi davvero aggiungere le date di entrata mancanti alle {name}?"  -- add the missing join dates to the default note name - like "... to the Officer Note?"
	GRM_L["Auto-adding join dates to the {name} is disabled. Do you still wish to continue?"] = "L'aggiunta automatica di date alle {name} è disabilitata. Vuoi continuare comunque?"    -- Just as above
	GRM_L["There are currently {num} mismatched dates to fix"] = "Ci sono {num} date non corrispondenti da sistemare"
	GRM_L["There are currently no mismatched dates that need to be fixed."] = "Non ci sono date non corrispondenti da sistemare" --WIP
	GRM_L["There are currently no dates that need to be imported."] = "Non ci sono date da importare"
	GRM_L["There are currently no dates that can be added to the default note."] = "Non ci sono date da aggiungere alle note predefinite"
	GRM_L["There are currently no dates that need to be removed from incorrect notes"] = "Non ci sono date da rimuovere dal tipo di nota sbagliato"
	GRM_L["There are currently {num} players who have join dates listed in the incorrect note"] = "Ci sono {num} giocatori con la data di entrata nella nota sbagliata"
	GRM_L["Warning! Your function is extremely limited without officer permissions"] = "Attenzione! Le funzionalità sono estramamente limitate senza i permessi da ufficiale"
	GRM_L["Advanced Join Date Tool" ] = "Strumento avanzato per le date di entrata"

	-- JD tool reasons
	GRM_L["Mismatched dates"] = "Date non corrispondenti"
	GRM_L["Matching date found in wrong note location"] = "Data corrispondente trovata nel tipo di nota sbagliato"
	GRM_L["Date not added to note"] = "Data non aggiunta alla nota"
	GRM_L["Mismatched dates, and found in wrong note location"] = "Data non corrispondente trovata nel tipo sbagliato di nota"
	GRM_L["Mismatched date found in multiple locations, including correct"] = "Data non corrispondente trovata in più note, compresa quella corretta" --WIP
	GRM_L["Mismatched date found in multiple incorrect note locations"] = "Data non corrispondente trovata in più tipi di nota sbagliati"
	GRM_L["Matching date found in multiple incorrect note locations"] = "Data corrispondente trovata in più tipi di nota sbagliati"
	GRM_L["Matching date found in multiple locations, including correct"] = "Data non corrispondente trovata in più note, compresa quella corretta"  --WIP
	GRM_L["Date found in incorrect note, but not yet imported"] = "Data trovata nel tipo di nota sbagliata, ma non ancora importata"
	GRM_L["Date found in multiple incorrect notes, but not yet imported"] = "Data trovata in più tipi di nota sbagliati, ma non ancora importata"
	GRM_L["Date found in multiple locations, including correct, but not yet imported"] = "Data trovata in più note, compresa quella corretta, ma non ancora importata"
	GRM_L["Date found in correct note location, but not yet imported"] = "Data trovata nel tipo di nota corretto, ma non ancora importata"

	-- More misc.
	GRM_L["The \"{name}\" and \"{name2}\" tags have globally been set to be added to join date note entries."] = "I tag \"{name}\" e \"{name2}\" sono stati impostati per essere aggiunti alle note"
	GRM_L["The \"{name}\" and \"{name2}\" tags have globally been disabled from adding to join date note entries."] = "I tag \"{name}\" e \"{name2}\" sono stati impostati per NON essere aggiunti alle note"
	GRM_L["Your rank has changed. Re-evaluating sync permissions."] = "Il tuo grado è cambiato. Rivalutando i permessi di sincronizzazione"

	-- 1.57
	GRM_L["Full Log Message:"] = "Messaggio completo:"
	GRM_L["Log Entry Tooltip"] = "Tooltip voci registro"
	GRM_L["1 entry has been removed from the log"] = "1 voce è stata rimossa dal registro"
	GRM_L["{num} entries have been removed from the log"] = "{num} voci sono state rimosse dal registro"

	-- 1.58
	GRM_L["|CFFE6CC7FCtrl-Click|r to open the Old Guild Roster Window"] = "|CFFE6CC7FCtrl-Clicca|r per utilizzare la vecchia versione dell'elenco di gilda"

	-- 1.59
	GRM_L["Adding the Join Date cannot be disabled due to the global setting"] = "È impossibile disabilitare l'inserimento della data di entrata a causa delle impostazioni globali"
	GRM_L["Due to your current rank, you will be unable to add Join Date Timestamps"] = "A causa del tuo grado attuale non potrai aggiungere le date di Entrata"
	GRM_L["Warning! Due to your rank you will be unable to add Join Date timestamps to the {name}"] = "Attenzione! A causa del tuo grado attuale non potrai aggiungere le date di Entrata alle {name}"
	GRM_L["Unable to Modify Format:  {name}"] = "Impossibile modificare il formato: {name}"
	GRM_L["Show Mouseover"] = "Mostra al passaggio del mouse"
	GRM_L["Unable to create GRM hotkey macro. You currently are at the cap of {num} macros."] = "Impossibile creare la macro per la scorciatoia di GRM. Hai raggiunto il cap di {num} macro."

	-- 1.60
	GRM_L["Really remove {name} Backup Point?"] = "Stai rimuovendo il Backup della gilda \"[name]\". Sei sicuro?"     -- The {name} is the guildName

	-- 1.63
	GRM_L["Disabled"] = "Disabilitato"
	GRM_L["|CFFE6CC7FClick|r to sort Birthdays January to December"] = "|CFFE6CC7FClicca|r per ordinare i Compleanni da Gennaio a Dicembre"
	GRM_L["|CFFE6CC7FClick|r to sort Birthdays December to January"] = "|CFFE6CC7FClicca|r per ordinare i Compleanni da Dicembre a Gennaio"

	-- 1.64
	GRM_L["Chat Window for All GRM Messages:"] = true
	GRM_L["\"{name}\" Chat Window\nDo you wish to create it?" ] = true              -- the \n indicates a line break.
	GRM_L["GRM will automatically send messages to the \"{name}\" window if you close this one."] = true
	GRM_L["Channel Settings Are Character Specific and Will Not Be Sync'd"] = true

	-- 1.66
	GRM_L["Custom Join Tag:"] = true
	GRM_L["Custom Rejoin Tag:"] = true
		-- Join Tag
	GRM_L["Custom Join Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = true
	GRM_L["Custom Join Tag has been changed from \"{name}\" to \"{name2}\""] = true
	GRM_L["Custom Join Tag has been set to \"{name}\""] = true
	GRM_L["Your Guild Leader has changed the Custom Join Tag from \"{name}\" to \"{name2}\""] = true
	GRM_L["Your Guild Leader has set the Custom Join Tag to \"{name}\""] = true
		-- Rejoin Tag
	GRM_L["Custom Rejoin Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = true
	GRM_L["Custom Rejoin Tag has been changed from \"{name}\" to \"{name2}\""] = true
	GRM_L["Custom Rejoin Tag has been set to \"{name}\""] = true
	GRM_L["Your Guild Leader has changed the Custom Rejoin Tag from \"{name}\" to \"{name2}\""] = true
	GRM_L["Your Guild Leader has set the Custom Rejoin Tag to \"{name}\""] = true

		-- 1.67
	-- Note, lots of plural/singular forms here for just a superior user experience, albeit a bit of extra work
	GRM_L["Kick"] = true
	GRM_L["Promote"] = true
	GRM_L["Demote"] = true
	GRM_L["Macro:"] = true
	GRM_L["Macro Size: {num}/255"] = true        -- "Macro Size: 242/255"
	GRM_L["Action"] = true
	GRM_L["Ignored Action:"] = true                 -- As in, the action being ignored, be it kick or promote or demote. 
	GRM_L["Click to Build Macro"] = true
	GRM_L["No Current Names to Add"] = true
	GRM_L["No Names to Add to the Macro"] = true
	GRM_L["Hot Key: {name}"] = true
	GRM_L["Permissions"] = true
	GRM_L["Player rank change detected, re-checking permissions and rebuilding GRM Macro Tool."] = true
	GRM_L["Click to remove selected names from the macro"] = true           -- Plural form of statement
	GRM_L["Click to remove selected name from the macro"] = true            -- Singular form of statement
	GRM_L["Click to remove selected names from Ignore List"] = true         -- Plural
	GRM_L["Click to remove selected name from Ignore List"] = true          -- Singular
	GRM_L["No names selected to remove from macro"] = true
	GRM_L["No names selected to remove from Ignore List"] = true
	GRM_L["Macro is currently empty"] = true
	GRM_L["{num} players removed from the macro"] = true                    -- plural form of the statement
	GRM_L["{num} player was removed from the macro"] = true                 -- singular form of the statement
	GRM_L["{num} players removed from the Ignored List"] = true
	GRM_L["{num} player was removed from Ignore List"] = true
	GRM_L["There are no names currently selected to be removed from the Ignore List."] = true
	GRM_L["There are no names currently selected to be removed from the macro."] = true
	GRM_L["The macro is not yet built. Please click the button to create the macro."] = true
	GRM_L["Nothing to clear"] = true
	GRM_L["There are currently no names to add"] = true
	GRM_L["There are currently no names to remove"] = true
	GRM_L["Rules"] = true
	GRM_L["Please choose a day between 1 and 99"] = true
	GRM_L["Please choose a day between 0 and 99"] = true
	GRM_L["Pressing the ESC key will also clear all lines"] = true
	GRM_L["Player's rank does not have permission to remove others from the guild"] = true
	GRM_L["Player's rank does not have permission to promote others in the guild"] = true
	GRM_L["Player's rank does not have permission to demote others in the guild"] = true
	GRM_L["Queued Actions"] = true
	GRM_L["Current Actions"] = true
	GRM_L["View Ignore List"] = true
	GRM_L["No players are currently safe from recommendations"] = true
	GRM_L["1 player is on the safe list."] = true
	GRM_L["{num} players are on the safe list."] = true
	GRM_L["1 action is being ignored."] = true
	GRM_L["{num} actions are being ignored."] = true
	GRM_L["No current actions are being ignored"] = true
	GRM_L["Actions Ignored:"] = true
	GRM_L["Total Queued:"] = true
	GRM_L["Ignored Players Safe From Action"] = true
	GRM_L["Only show players with ignored action"] = true
	GRM_L["No players on Ignore List"] = true
	GRM_L["No players to select. 1 player filtered"] = true                     -- Singular
	GRM_L["No players to select. {num} players filtered"] = true                -- Plural
	GRM_L["There are no names to select. 1 player is filtered"] = true          -- these 2 statements might seem redundant, but often the text on a button is more short hand. This gives a cleaner statement in the chat. Useful for translating in some languages that need a bit more room to be more clear.
	GRM_L["There are no names to select. {num} players are filtered"] = true
	GRM_L["Really remove selected player from the ignore list?"] = true
	GRM_L["Really remove the {num} selected players from the ignore list?"] = true
	GRM_L["Do you really wish to clear all players from the Ignore List?"] = true
	GRM_L["There are currently no players on the Ignore List"] = true
	GRM_L["Remove all players from Ignore List"] = true
	GRM_L["Ignored Players: {num}"] = true
	GRM_L["Tool"] = true                                            -- /grm tool
	GRM_L["Macro Tool"] = true
	GRM_L["Macro Tool: {num}"] = true

	-- CLASSIC
	GRM_L["Social"] = true
	GRM_L["Roster"] = true
	GRM_L["Feature is disabled in WoW Classic"] = true
	GRM_L["Feature is disabled in TBC Classic"] = true          -- Just laying groundwork now in case Blizz ever releases it. Calendar was not added until WOTLK
	GRM_L["(Classic)"] = true       -- tooltip tag that shows only on the minimap mosueover version tooltip in Classic

	-- 1.69
	GRM_L["Importing dates must be done in a compatible format"] = true
	GRM_L["The date selection in OPTIONS shows all supported"] = true
	GRM_L["Headers, like \"Joined,\" are supported"] = true
	GRM_L["To confirm or edit the date, open the player window, right click the date, edit, and submit"] = true        --The "!!" tags are the {name}
	GRM_L["To confirm or edit the date, right click the date, edit, and submit"] = true     -- Slightly shorter explanation if already on player window
	GRM_L["The {name} tag indicates a date must be verified to sync"] = true

	-- 1.70
	GRM_L["GRM has errored due to a previous incompatible build with Classic that was enabled. Click YES to reload UI and fix the issue"] = true

	-- 1.71
	GRM_L["(Disabled in Classic)"] = true           -- For the Options... rather than removing them all

	-- 1.73
	GRM_L["{name} is no longer in the Guild!"] = true       -- There should really be 3 options. They got kicked, they left on their own, or if not found in the event log, they are just no longer in the guild
	GRM_L["is no longer in the Guild!"] = true              -- THIS MUST MATCH THE PREVIOUS LINE with missing name.
	GRM_L["Applying update patches... one moment."] = true
	GRM_L["Update Complete... {num} patches applied."] = true   -- Plural
	GRM_L["Update Complete... 1 patch applied."] = true         -- Singular version
	GRM_L["Disabling will also hide the Birthday info on the roster mouseover window"] = true       -- Enable/disable birthday chekbox on UI Options and the Audit windoppw
	GRM_L["To avoid addon taint/blocking errors  Classic, the player must manually open the Guild Roster tab the first time."] = true          -- Classic only message for players explaining why window cannot open automatically.
	GRM_L["Confirm Date"] = true
	GRM_L["If the date is accurate, right click and select 'Confirm Date'"] = true

		-- 1.74
	GRM_L["Class Colorize Names in Guild Member Alerts"] = true
	GRM_L["All player custom notes re-enabled for sync and their checkboxes set."] = true
    
    -- 1.75
    GRM_L["!note"] = true               -- !note in English will always work. This gives you the option of creating your own key to register a public note.
    GRM_L["No officer online to set {name}'s note"] = true
    GRM_L["No officer is currently online to update your note"] = true
    GRM_L["Allow Guild Members to Type \"!note\" to Set Their Own Public Note"] = true
    GRM_L["Enabled"] = true         -- As in, the opposite of Disabled
    GRM_L["'!note' trigger has been globally ENABLED"] = true
    GRM_L["'!note' trigger has been globally DISABLED"] = true

    -- 1.76
    GRM_L["Same Rank"] = true                                                                   -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Higher Rank"] = true                                                                 -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Limited Features. There is no Calendar in Classic"] = true                           -- Events Tab top warning
    GRM_L["This only affects settings for your current guild: {name}"] = true                   -- Tooltip for Options > General > Sync settings to all alts in same guild
    GRM_L["GC"] = true                                                                          -- Options window, acronym for "Global Controls" and will be adjacent to all settings that have global controls
    GRM_L["*GC = Global Control - Use Guild Info to Force Setting For All"] = true              -- Top left Options window
    GRM_L["Set Global Controls"] = true                                                      -- Options > Officer Tab > Bottom left export button
    GRM_L["Global Control Values Set in Guild Info"] = true                                     -- Export GuildInfo tool tooltip
    GRM_L["Configure your settings. Click to set in Guild Info"] = true                                    -- Tooltip line 2- same as above
    GRM_L["Unable to add globals controls to GuildInfo. There is not enough room."] = true      -- If export of globals is not able to complete
    GRM_L["Global controls exported to the guild info note. Updating..."] = true                -- Success in exporting
    GRM_L["Your rank cannot edit the Guild Info"] = true                                              -- Mouseover tooltip helper for people without MOTD edit access
    GRM_L["All global controls are already set. You must Edit or Remove the settings manually in the guild Info."] = true;
    GRM_L["Do you really want to wipe all GRM data and settings account-wide?"] = true
    GRM_L["Are you sure your settings are configured and ready for global controls?"] = true
    GRM_L["Players the same rank or higher will not be shown"] = true
	GRM_L["Macro"] = true       -- For the slash command  /grm tool or /grm macro - same thing
	
	-- 1.77
	GRM_L["Add Custom Rule"] = true         -- Kick Macro Tool - custom rule button right side
	GRM_L["Former Members"] = true          -- Export tool
	GRM_L["Data Export"] = true
	GRM_L["*Max Export is 500 Log Entries at a Time"] = true
	GRM_L["*Max Export is 500 Members at a Time"] = true
	GRM_L["*Max Export is 500 Former Members at a Time"] = true
	GRM_L["*Export obeys the current log display filters"] = true
	GRM_L["Select Line Range:"] = true
	GRM_L["Select Member Range:"] = true
	GRM_L["Export Selection"] = true
	GRM_L["Export Next {num}"] = true       -- As in, "Export next 500" names or log lines
	GRM_L["Export Prev {num}"] = true       -- As in, Export Previous name
	GRM_L["Total Members: {num}"] = true
	GRM_L["Total Former Members: {num}"] = true
	GRM_L["Class"] = true                       -- As in Class Name, there is currently a "Class:" we need one with the colon
	GRM_L["Guild Rep"] = true                   -- Guild Faction reputation (abbreviated)
	GRM_L["Last Online (Days)"] = true
	GRM_L["Spreadsheet Headers"] = true
	GRM_L["Auto Include Headers"] = true        -- Auto include headers on the export frame, as in the column headers for each category on member and former mebers
	GRM_L["These will only be included if exporting from the top of the table"] = true      -- tooltip for the auto-Included export checkbutton
	GRM_L["Export"] = true
	GRM_L["This will be rounded to the nearest day"] = true
	GRM_L["Clearing Log Export. A filter setting has been changed."] = true             -- If the filter settings have been modified, the export string should be cleared and re-done
	GRM_L["No Tag"] = true                                                              -- Main Tag
	GRM_L["Delimiter:"] = true                                                          -- Delimiter selection for Export window
	GRM_L["The selected delimiter will be removed from all notes on export"] = true
	GRM_L["Choose thoughtfully"] = true
	GRM_L["{name}'s note has been updated!"] = true
	GRM_L["Locked. Press ESC"] = true                                        -- Mouseover Locked text in top right.
	GRM_L["|CFFE6CC7FClick|r to Select for Removal"] = true
    GRM_L["Feel free to recommend a delimiter you wish to use to the author"] = true
    GRM_L["Export Tool"] = true
    GRM_L["Opens the Data Export Tool"] = true
    GRM_L["Opens the Advanced Macro Tool"] = true
	
	-- 1.78
    GRM_L["Hurray!"] = true                                                              -- A short cheer! Like "Yay!" except "Hurray!"
	GRM_L["{name} has Reached the {num} Level Cap! {custom1}"] = true                  -- Arkaan has Reached the 120 Level Cap! Hurray!
	
	-- 1.80
	GRM_L["Core Window:"] = true
	GRM_L["Mouseover Player Details:"] = true
	GRM_L["Macro Tool:"] = true
	GRM_L["Export Tool:"] = true
	GRM_L["Audit Join Date Tool:"] = true
	GRM_L["GRM UI Scale"] = true
	GRM_L["Right-Click to Reset"] = true
	GRM_L["Open the Mouseover Window to see immediate scaling changes"] = true
	GRM_L["Open the Macro Tool Window to see immediate scaling changes"] = true
	GRM_L["The Export Tool is connected to the Core window scaling"] = true
	GRM_L["This provides additional scaling controls on just this window"] = true
	GRM_L["Open the Export Tool Window to see immediate scaling changes"] = true
	GRM_L["WARNING: Clear the text box before re-scaling or you may lock up your system"] = true
	GRM_L["Resets ALL settings, not just the ones on this page"] = true
	GRM_L["Open MouseOver"] = true
	GRM_L["Open Macro Tool"] = true
	GRM_L["Open Export Tool"] = true
	GRM_L["Open Join Date Tool"] = true
	
	-- 1.81
    GRM_L["Race"] = true
    GRM_L["Sex"] = true
    GRM_L["Male"] = true
	GRM_L["Female"] = true
	GRM_L["{name} {name2}"] = true          -- This might seem weird, but the format is "Race Sex" In other words, "Orc Male" or "Nightborne Female" and so on. Adjust how you see fit, it appears in the mouseover tooltip on the player name
	
	-- 1.82
    GRM_L["Disabled While Player is Grouped"] = true
    GRM_L["SYNC is currently disabled while you are grouped. Due to server restricted addon to addon talk data caps, and in an effort to avoid clogging up the shared global comm space of all addons, sync will be temporarily restricted while grouped."] = true


	-- 1.84
    GRM_L["The note is too long. Only the first {num} characters will be set."] = true
    GRM_L["Apply Only to Selected Ranks"] = true
    GRM_L["Unable to create hotkey macro. Player is currently in combat and action is restricted. It will auto-build once out of combat."] = true
    GRM_L["No player data found, recommend full removal."] = true
    GRM_L["OR"] = true      -- "Or" as in  This OR that  Use this button OR that button -- Advanced JD audit tool.
    GRM_L["Use Promo Date"] = true
    GRM_L["Use Join Date"] = true
    GRM_L["Send to Promo Date"] = true
    GRM_L["Send to Join Date"] = true
    GRM_L["(Press Tab to Cycle)"] = true
    GRM_L["(Press Enter to Select)"] = true
    GRM_L["Setting join date to destination index {num} is not valid. Value must be between 0 and 3. Setting to default of Officer Note."] = true
    GRM_L["Join Dates Globally Changed to no longer be added to the note when a player joins the guild"] = true
    GRM_L["Your Guild Leader has disabled adding join dates to player notes"] = true
    GRM_L["Unable to Modify. Global setting DISABLES adding the join date automatically. "] = true
    GRM_L["General Sync"] = true
    GRM_L["Ban Sync"] = true
    GRM_L["Custom Sync"] = true
    GRM_L["Auto Join date"] = true
    GRM_L["Include Headers"] = true;
    GRM_L["Join Header"] = true;
    GRM_L["ReJoin Header"] = true;
    GRM_L["!note Control"] = true
    GRM_L["You need to clear {num} characters to fit the control tags"] = true
    GRM_L["A new format exists for global settings controls."] = true
    GRM_L["Go to GRM window > Options > Officer Tab > \"Set Global Controls\""] = true
    GRM_L["Remove the old format when all guildies have updated properly. You may wish to leave it in Guild Info until then."] = true
    GRM_L["It may take up to 60 seconds for other guild members to detect the changes and update."] = true
    GRM_L["Ctrl-Shift-Click"] = true
    GRM_L["Resets only the settings on this page"] = true
    GRM_L["Resets only the Export Settings"] = true
    GRM_L["Resets all Macro Tool Rules and Settings"] = true
    GRM_L["Are you sure you want to reset all Macro Tool Rules and Settings?"] = true
    GRM_L["Export settings to unify sync controls, timestamp format, and so on with your officers and members."] = true
    GRM_L["Consult with your guild leader and export settings to unify sync controls, timestamp format, and so on."] = true
    GRM_L["Global controls have not yet been set!"] = true
    GRM_L["Include Birthdays as Incomplete"] = true
    GRM_L["Make room and transfer before clearing"] = true
    GRM_L["1 player has a join date listed in the incorrect note. The default location is full"] = true             -- Singular (Join Date Audit tool - bottom button mouseover) - rare tooltip use
    GRM_L["{num} players have join dates listed in the incorrect note. The default location is full"] = true        -- Plural (same)
    GRM_L["Otherwise, {num} notes are ready to be cleared from the incorrect location"] = true                      -- Plural (same tooltip)
    GRM_L["Otherwise, 1 note is ready to be cleared from the incorrect location"] = true                            -- Plural (same tooltip)
    GRM_L["There are currently {num} dates that can be added to the {name}"] = "Ci sono {num} date da aggiungere alle {name}";
    GRM_L["The previous action still has 1 recommended task. It is advised to do that first."] = true               -- Singular
    GRM_L["The previous action still has {num} recommended tasks. It is advised to do those first."] = true         -- Plural
	GRM_L["Step {num}"] = true
	
	-- 1.86
	GRM_L["What tags look like:"] = true
    GRM_L["Add Join Date to:"] = "Aggiungi la data di entrata a:"
	
	-- R1.87
    GRM_L["|CFFE6CC7FLeft-Click|r to Disable Rule"] = true
    GRM_L["|CFFE6CC7FLeft-Click|r to Enable Rule"] = true
    GRM_L["Edit"] = true
    GRM_L["|CFFE6CC7FClick|r to Change the Rule Name"] = true
    GRM_L["Apply to All Ranks"] = true
    GRM_L["Please select at least 1 RANK to apply this rule to."] = true
    GRM_L["Apply to All Levels"] = true
    GRM_L["Apply Only to Level Range"] = true
    GRM_L["Level Range:"] = true
    GRM_L["{num} to {custom1}"] = true          -- Example: "Level Range: 100 to 120"
    GRM_L["1 to {num}"] = true                  -- Same principle.
    GRM_L["Require Text Match"] = true
    GRM_L["Click to Set"] = true
    GRM_L["Inactivity:"] = true
    GRM_L["Notify if inactive for {num} {name}" ] = true       -- Notify if inactive for 15 Days  or Notify if inactive for 10 Months
    GRM_L["Rule Filter: {name}"] = true
    GRM_L["Ranks:"] = true
    GRM_L["All Ranks"] = true
    GRM_L["Note Match:"] = true
    GRM_L["Please Set a Name for this Rule. It can be 1 to 25 characters in length."] = true
    GRM_L["This will also clear all of your saved rules."] = true
    GRM_L["Within Level Range: {num} - {custom1}"] = true               -- Qued macro tool tooltip
    GRM_L["Note match: {name}"] = true                                  -- Same
    GRM_L["Matching Rank"] = true                                       -- ''
    GRM_L["Right-Click|r to Edit or Remove custom rule"] = true         -- Please keep the '|r' immediately after the click info - as it indicates a text color change point
	GRM_L["|CFFE6CC7FClick|r to Change"] = true
    GRM_L["(Applies Only to Classic)"] = true           -- For the Options... rather than removing them all
	
	-- R1.88
    -- Group Info Module
    GRM_L["GRM Info"] = true
    GRM_L["GRM Group Info"] = true
    GRM_L["Group Info"] = true
    GRM_L["Click to Lock Info Window"] = true
    GRM_L["Guildies: {num}"] = true
    GRM_L["Former Guildies: {num}"] = true
    GRM_L["Other {name} Members: {num}"] = true           -- "Other Zul'jin Members: 5"  - basically just your realm name. This can be useful to know who in your raid is your realm as you can trade more freely.
    GRM_L["Other Connected Realm Members: {num}"] = true
    GRM_L["Total in Group: {num}"] = true
    GRM_L["Date Left"] = true
    GRM_L["1 Alt Still in Guild"] = true
    GRM_L["{num} Alts Still in Guild"] = true
    GRM_L["Known Alts:"] = true
    GRM_L["Close Enough to Trade"] = true
    GRM_L["Plugins"] = true         -- plural
    GRM_L["Plugin"] = true          -- Singular
    GRM_L["Module"] = true
    GRM_L["GRM Optional Modules"] = true
    GRM_L["Enable Module"] = true
    GRM_L["Show Interactable Distance Indicator"] = true
    GRM_L["No GRM Modules Currently Installed"] = true
    GRM_L["Custom Color"] = true
    GRM_L["{name} is listed as the Main"] = true
    GRM_L["Kick Banned in Guild"] = true
    GRM_L["Kick macro created. Press Hotkey to Remove Banned Players Still in Guild"] = true
    GRM_L["Easily remove all Banned players still in the Guild with the Macro Tool"] = true
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you remove all custom channels."] = true
	GRM_L["Multi-Channel support. Just separate with commas"] = true
	GRM_L["Disable tooltip. Only show popout window."] = true

	-- R1.89
    GRM_L["GRM API Error:"] = true
    GRM_L["The guild name \"{name}\" cannot be found in the database. Ensure proper formatting."] = true
    GRM_L["The player name \"{name}\" cannot be found in the database. Ensure proper spelling."] = true
    GRM_L["Unable to change officer notes at current rank"] = true
    GRM_L["Player is not currently in a Guild"] = true
    GRM_L["Mains Only"] = true
    GRM_L["Alts Only"] = true
    GRM_L["Custom Public Notes:"] = true        -- Updated from "Custom Notes"
    GRM_L["Leave unchecked to export every member of the guild"] = true
    GRM_L["Only the 10 most recent rank changes will be included"] = true
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} 1 time to complete all actions"] = true
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} {num} times to complete all actions"] = true
    GRM_L["This only affects GRM tooltips"] = true
    GRM_L["Unable to remove players from the guild at current rank."] = true
    GRM_L["Unable to promote players within the guild at current rank."] = true
    GRM_L["Unable to demote players within the guild at current rank."] = true
    GRM_L["Feature disabled."] = true
    GRM_L["Does NOT apply to Ban List"] = "Non si applica alla Lista Ban"
    GRM_L["This only applies to Alt/Main Groupings, Join Dates, Promotion Dates, Birthdates, and Custom Notes."] = true
    GRM_L["Custom Notes can be Restricted Further Below"] = true
    GRM_L["All ranks will receive the outgoing player data. Only players of the selected rank or higher can modify and share that data."] = true
    GRM_L["Always open to selected tab:"] = true
    GRM_L["{num} guild members have incomplete info."] = true
    GRM_L["Just 1 guild member still has incomplete info. Great job!"] = true
    GRM_L["No Audit Necessary! Great Work!"] = true
    GRM_L["GRM Audit Report:"] = true                                                               -- Appears after the player's first sync that game secssion.
    GRM_L["100% complete. Great work!"] = true
    GRM_L["{num}% complete."] = true
    GRM_L["Only 1 member with incomplete data."] = true     -- singular phrase
    GRM_L["{num} members with incomplete data."] = true     -- plural version of it
    GRM_L["Colorize Names on Roster and Chat Window to Match Class"] = true
    GRM_L["Only Match Empty Notes"] = true
    -- macro Tool
    GRM_L["Empty Note match: {name}"] = true
    GRM_L["Empty Notes"] = true
    GRM_L["Public"] = true
    GRM_L["Custom"] = true
    GRM_L["Apply Rules to:"] = true         -- Macro tool rule (top selection)
    GRM_L["All"] = true                     -- As in, apply to everyone.
    GRM_L["Player is an Alt"] = true
    GRM_L["Player is a Main"] = true
    GRM_L["This only applies to KNOWN alts. Unconfigured will be excluded."] = true
    GRM_L["Main/Alt: {name}"] = true
    GRM_L["Kick Players at Selected Rank(s) after"] = true
    GRM_L["Use Cautiously. Applies to all at rank, regardless of being active or inactive."] = true
    GRM_L["This will only apply to players with verified promotion dates."] = true
    GRM_L["Time at Rank: {name}"] = true
    GRM_L["Notify if at Rank for {num} {name}"] = true      -- "Notify if at Rank for 30 Days" or "Notify if at Rank for 12 Months" 
    GRM_L["Player Guild Rep is"] = true         -- Ex: "Player Guild Rep is < Honored" or "Player Guild Rep is = Neutral"  -- Dropdown selection options immediately follow this line. If ordering of boxes before the line would be better, please inform me and I can accomadate your localization efforts
    GRM_L["|CFFE6CC7FClick|r to Change Rep"] = true
    GRM_L["Guild Rep:"] = true
    GRM_L["Guild Rep lower than {name}"] = true
    GRM_L["Guild Rep equal to {name}"] = true
    GRM_L["Guild Rep higher than {name}"] = true
    GRM_L["Rep: {name} - {name2}"] = true
    GRM_L["Custom Log Entry Message"] = true
    GRM_L["Press ENTER to Save"] = true
    GRM_L["{name} matches {num} macro tool rules. Kick Recommended!"] = true
    GRM_L["{name} matches {num} macro tool rule. Kick Recommended!"] = true
    -- Classic Only
    GRM_L["Shift Rank Up"] = true
    GRM_L["The Guild Rank \"{name}\" has Shifted up from rank {num} to {custom1}"] = true
    GRM_L["The Guild Rank \"{name}\" has Shifted lower from rank {num} to {custom1}"] = true
    GRM_L["After shifting the rank up by 1, the window will automatically close"] = true
    GRM_L["After shifting the down by 1, the window will automatically close"] = true
    GRM_L["Addon restrictions require manual selection of guild rank"] = true
    GRM_L["Shift Rank Down"] = true

	-- R1.90
    GRM_L["GRM WARNING!!! FAILURE TO LOAD THIS KEY: {name}\nPLEASE REPORT TO ADDON DEV! THANK YOU!"] = true
    GRM_L["Sync is disabled for {num} seconds after logging in. Please wait {custom1} seconds longer."] = true      -- if sync is triggered after logon too soon
    GRM_L["Type '/grm sync' to initiate a one-time sync."] = true
    -- Due to language differences on the edit box, this is to explain where to put the edit box. In Englist it will appear: "Auto Trigger Sync [ 30 ] Seconds After Logging On" - Please place the edit box in the appropriate position for your translation.
    GRM_L["Before Auto Trigger"] = "Auto Trigger Sync"                  
    GRM_L["After Auto Trigger"] = "Seconds After Logging On"
	GRM_L["Report When Other Members Have Outdated Versions"] = true
	
	-- Macro Tool update promote/demote
    -- R1.92
    GRM_L["Inactive"] = true
    GRM_L["Promote Player if at Rank for"] = true
    GRM_L["Demote Player if Inactive for"] = true
    GRM_L["Apply Promotions Regardless of Activity"] = true
    GRM_L["Apply Only to Active Players"] = true
    GRM_L["Player is considered inactive if offline for"] = true
    GRM_L["Ignore inactivity if at least one player linked alt is active"] = true
    GRM_L["Promote to Rank:"] = true
    GRM_L["Demote to Rank:"] = true
    GRM_L["Only recommend to Demote if all player linked alts exceed max time"] = true
    GRM_L["Unable to promote players to this rank"] = true                                                                                  -- etc...
    GRM_L["Unable to demote players to this rank"] = true
    GRM_L["Unable to promote players at this rank."] = true
    GRM_L["Unable to demote players from this rank."] = true
    GRM_L["Unable to kick players at this rank"] = true
    GRM_L["Unable to promote players at this rank to \"{name}\""] = true
    GRM_L["Unable to demote players at this rank to \"{name}\""] = true
    GRM_L["Disable chat log spam while using the Macro Tool"] = true
    GRM_L["When you are ready to Promote the player, press the Hot-Key {name} 1 time to complete all actions"] = true           -- Similar entries demote/promote plura/singular versions
    GRM_L["When you are ready to Demote the player, press the Hot-Key {name} 1 time to complete all actions"] = true                -- ''
    GRM_L["When you are ready to Promote the players, press the Hot-Key {name} {num} times to complete all actions"] = true         -- ''
    GRM_L["When you are ready to Demote the players, press the Hot-Key {name} {num} times to complete all actions"] = true          -- ''

    -- Mouseover tooltip on the macro button on the roster
    GRM_L["Players to Kick:"] = true
    GRM_L["Players to Promote:"] = true
    GRM_L["Players to Demote:"] = true

    GRM_L["Hello {custom1}"] = true

    -- Consideration for plural/singular
    GRM_L["Player has been at rank for more than {num} Day"] = true
    GRM_L["Player has been at rank for more than {num} Days"] = true
    GRM_L["Player has been at rank for more than {num} Month"] = true
    GRM_L["Player has been at rank for more than {num} Months"] = true

    -- Promote?Demote tooltup updates on the rules
    GRM_L["Time at Rank:"] = true
    GRM_L["Destination Rank:"] = true
    GRM_L["# Moves:"] = true        -- This is shorthand in American English for "Number of Ranks:" - This is top right on macro tool promote/demote - indicating the number of ranks player needs to be promoted or demoted
    GRM_L["Notify if at current rank for {num} {name}" ] = true
    
    -- Macro Tool Log reporting
    GRM_L["{name} matches {num} macro tool rules. Promotion Recommended!"] = true     -- I know, a little redundancy here, but I don't want to go back to the kick rules above and modify for all. Just copy/paste the first sentence for each singular/plural.
    GRM_L["{name} matches {num} macro tool rule. Promotion Recommended!"] = true
    GRM_L["{name} matches {num} macro tool rules. Demotion Recommended!"] = true
    GRM_L["{name} matches {num} macro tool rule. Demotion Recommended!"] = true
	
	-- 1.921
    -- These are going to be used to cleanup some of the string formatting in the future
    GRM_L["Click"] = true                   -- Referencing a mouse click
    GRM_L["Ctrl-Click"] = true              -- Ctrl = Control
    GRM_L["Alt-Click"] = true
    GRM_L["Shift-Click"] = true
    GRM_L["Ctrl-Shift-Click"] = true
    GRM_L["Alt-Shiift-Click"] = true
	GRM_L["Right-Click"] = "Right-Clicca"
	GRM_L["Ctrl-Left-Click"] = true
    
    GRM_L["{custom1} to add player to all 3 macro tool ignore lists" ] = true           -- custom1 = "Ctrl-Click"  - it is basically a macro action
    GRM_L["{custom1} to remove player from all 3 macro tool ignore lists"] = true
    GRM_L["{custom1} to push ignore list settings to {name}'s alts"] = true
    GRM_L["Type \"{name} {name2}\" to Bring Up Macro Tool. {custom1} also work."] = true         -- This is how it looks in final form in English - "Type "/grm macro" to Bring Up Macro Tool (tool, kick, promote, demote also work)""
    GRM_L["Kick Rules"] = true
    GRM_L["Promote Rules"] = true
    GRM_L["Demote Rules"] = true
    GRM_L["Macro Rule Ignore Lists"] = true
    GRM_L["Select categories you wish the player to be ignored"] = true
    GRM_L["Ignoring"] = true
    GRM_L["Monitoring"] = true
    GRM_L["Macro Rules"] = true
    GRM_L["{name}'s alts now share the same macro rule ignore settings."] = true
    GRM_L["{name} or Press ESC"] = true
    GRM_L["Please choose a day between {num} and {custom1}"] = true         -- Example: "Please choose a day between 1 and 999"
    GRM_L["Reactivate monitoring after {num} days."] = true
    GRM_L["Set Days:"] = true
    GRM_L["Configured: {custom1}"] = true
    GRM_L["Time Left: {custom1}"] = true
    GRM_L["{name} is now being monitored by the kick macro rules after being on the ignore list for {num} days."] = true
    GRM_L["{name} is now being monitored by the promote macro rules after being on the ignore list for {num} days."] = true
    GRM_L["{name} is now being monitored by the demote macro rules after being on the ignore list for {num} days."] = true
    GRM_L["WARNING! Unchecking this setting will reset the timer upon re-enabling."] = true
    GRM_L["Year"] = true
    GRM_L["Years"] = true
    GRM_L["This note will appear with the log notification when a player meets this rule's conditions."] = true
    GRM_L["Demotion Macro Limitation!!! Unable to demote {name} due to multiple players in the guild with the same name, though different realms. Please demote manually."] = true
    GRM_L["Due to limitations with macros a player can only move 1 rank at a time."] = true
	GRM_L["Disabled at Current Rank"] = true
	
	-- 1.922
    GRM_L["Verifying Macro Changes. One moment."] = true
    GRM_L["Not all macro changes validated. One moment..."] = true
    GRM_L["Macro rank changes have been validated!"] = true
    GRM_L["Warning! Macro changes were not able to be validated. Please verify expected results before using the macro tool further."] = true

	-- 1.93
    GRM_L["Customize Color"] = true
    GRM_L["GRM has detected that FGI is blocking system messages and cannot function properly without them. Do you want to enable them?"] = true        -- FGI is in reference to the "Fast Guild Invite" addon...
    GRM_L["GRM has detected that System Messages are disabled and cannot function properly without them. Do you want to enable them?"] = true
    GRM_L["System Messages have been enabled and GRM should now function properly."] = true
    GRM_L["Officer Only Access"] = true   -- Tooltip on the advanced join date tool button
    GRM_L["Player no longer has officer access. Advanced Join Date Tool has been closed."] = true
    GRM_L["{custom1} to open Player Window"] = "{custom1} per aprire la finestra del giocatore"
	GRM_L["{custom1} for Additional Options"] = "{custom1} per altre opzioni"

	--1.93
    GRM_L["Please Note: To permanently enable system messages, you must manually re-enable them in your chat window general settings"] = true
    GRM_L["Unable to notify yourself if you go offline."] = true
    GRM_L["{custom1} to sync join date among all alts in grouping."] = true
    GRM_L["Total Patch Time:"] = true
    GRM_L["Do you really want to import the join date for the selected player?"] = true
    GRM_L["Do you really want to import the join date for the {num} selected players?"] = true
    GRM_L["Do you really want to import the join date for 1 player?"] = true
    GRM_L["Do you really want to import the join date for {num} players?"] = true
    GRM_L["Dates to be imported: {num}"] = true
    GRM_L["{num} join dates have not been imported yet! Do that first!"] = true
    GRM_L["1 player's join date has not been imported yet! Do that first!"] = true
    GRM_L["It is recommended to follow the steps in order"] = true
    GRM_L["It's {name}'s Birthday today!!!"] = true
    GRM_L["Announce if Player's Birthday when they Login."] = true
    GRM_L["Happy Birthday, {name}!"] = true
    GRM_L["This event has not yet been added to the calender. Are you sure?"] = true
    GRM_L["{num} events have not yet been added to the calendar. Are you sure?"] = true
    GRM_L["There are no events listed here to remove."] = true
    GRM_L["All events have been removed."] = true
    GRM_L["Ignore All Events"] = true
    GRM_L["Day:"] = true        -- Events window title header on list
    GRM_L["Copy"] = true        -- Macro tool - copying
    GRM_L["There are {num} players in your guild on dead accounts."] = true
    GRM_L["There is 1 player in your guild on a dead account."] = true
    GRM_L["Click CONFIRM to review the names, IGNORE to remove this pop-up permanently, or CANCEL to be reminded next session."] = true
    GRM_L["Would you like to remove them?"] = true
    GRM_L["You can re-check in the future by typing '/grm dead'"] = true
    GRM_L["Ignore"] = true
    GRM_L["Dead Account"] = true
    GRM_L["Kicking {name}'s alts"] = true
    GRM_L["Kicking Banned Player"] = true
    
    GRM_L["Open any GRM window: {name}, {name2}, {custom1}, etc."] = true
    GRM_L["Does a one-time check for dead accounts"] = true
    GRM_L["Dead player accounts found: {num}"] = true
    GRM_L["Rule Sync Enabled"] = true
    GRM_L["Rule Sync Disabled"] = true
    GRM_L["Created By: {name}"] = true          -- Macro rule tooltip
    GRM_L["{name}'s Kick Rule {num}"] = true
    GRM_L["{name}'s Promote Rule {num}"] = true
    GRM_L["{name}'s Demote Rule {num}"] = true
    GRM_L["Sync: {name}"] = true
    GRM_L["Macro Rules Sync Result:"] = true
    GRM_L["Kick Rules Added: {num}"] = true
    GRM_L["Kick Rules Removed: {num}"] = true
    GRM_L["Promote Rules Added: {num}"] = true
    GRM_L["Promote Rules Removed: {num}"] = true
    GRM_L["Demote Rules Added: {num}"] = true
    GRM_L["Demote Rules Removed: {num}"] = true
    GRM_L["Macro Rule Sync:"] = true
    GRM_L["Kick Rule \"{name}\" Removed by {name2}"] = true
    GRM_L["Promote Rule \"{name}\" Removed by {name2}"] = true
    GRM_L["Demote Rule \"{name}\" Removed by {name2}"] = true
    GRM_L["Reject"] = true
    GRM_L["Please confirm that the guild \"{name}\" has been renamed to \"{name2}\"."] = true
    GRM_L["Possible Guild Name Change Detected. {num}% match."] = true
    GRM_L["Player Search"] = true
    GRM_L["Search to find a player quicker"] = true

    -- Additonal slash command
    GRM_L["dead"] = true            -- slash command for checking dead names
    GRM_L["deadnames"] = true       -- slash command for checking dead names
    GRM_L["TabName"] = true
	GRM_L["Add unique player GUID to chat window to copy"] = true
	GRM_L["Achievement Announce"] = ACHIEVEMENT
	GRM_L["Only Guild Members with GRM installed will see."] = true
    
	-- R1.935
    GRM_L["Search"] = "Cerca" -- This is the global string for "Search"
    
    -- R1.936
    GRM_L["Use '{name} search PlayerName' to also find guild members"] = true
    GRM_L["{custom1} to Copy Name to Chat"] = true  -- "Shift-Click to Copy Name to Chat" is the default

	-- R1.944
    GRM_L["Promote Player if in Guild for"] = true
    GRM_L["Time in Guild: {name}"] = true
    GRM_L["Time in Guild:"] = true
    GRM_L["Notify if a member for at least {num} {name}"] = true
    GRM_L["Player has been a member for more than {num} Day"] = true
    GRM_L["Player has been a member for more than {num} Days"] = true
    GRM_L["Player has been a member for more than {num} Month"] = true
    GRM_L["Player has been a member for more than {num} Months"] = true
    GRM_L["Ignore Rule With Text Match"] = true
    GRM_L["This only searches the officer note for the safe tag"] = true
    GRM_L["Examples of simple tags:"] = true
    GRM_L["Do Not Kick" ] = true
    GRM_L["[S]"] = true  -- While this is just a tag, it is short for the word "Safe"
    GRM_L["Safe"] = true
    GRM_L["Must be an exact match"] = true
    GRM_L["No safe tag '{name}' in officer note"] = true
    GRM_L["Safe Text Match:"] = true

    -- R1.946
    GRM_L["GRM Tools" ] = true
    GRM_L["Style Choices:"] = true
    GRM_L["Applies only to date format used for note"] = true
    
    -- R1.947
    GRM_L["Currently syncing with {name}. Please wait until after sync completes to activate again."] = true
    GRM_L["Be Informed When GRM is out of date."] = true
    GRM_L["This only reports to chat once per session."] = true
    GRM_L["Player GUID"] = true
    GRM_L["Remove Alt-Code Letters From Names"] = true
    GRM_L["Only Show Players Currently Online"] = true
    GRM_L["{name} matches rules for a promotion and is currently online."] = true
    GRM_L["{name} matches rules for a demotion and is currently online."] = true
    GRM_L["Please choose a valid Month"] = true
    GRM_L["Warcraft was not released until 2004. Please choose a valid year."] = true

	--R1.953
    GRM_L["{name} has rejoined their original alt group."] = true
    
    --R1.96
    GRM_L["Not Currentlly Syncing"] = true;
    GRM_L["Sync with {name} Successful"] = true
    GRM_L["Sync failed at this point:"] = true
    GRM_L["Sync with {name} next."] = true
    GRM_L["Sync is Currently Disabled"] = true
    GRM_L["Sync has failed..."] = true
    GRM_L["Start Sync"] = true
    GRM_L["Initializing Sync"] = true
    GRM_L["Initializing Sync. One Moment..."] = true
    GRM_L["No Member is Available to Sync"] = true
    GRM_L["Outgoing Ban Data Restricted"] = true
    GRM_L["Incoming Ban Data Restricted"] = true
    GRM_L["Sync Ok, but their rank is too low to make changes."] = true
    GRM_L["Sync Ok, but your rank is too low to sync your changes."] = true
    GRM_L["Their Rank is too Low. All data is restricted."] = true
    GRM_L["Your Rank is too Low. Player is restricting all data."] = true
    GRM_L["Sync is Currently Disabled. Do you wish to re-enable?"] = true
    GRM_L["SYNC DATA"] = true       -- AddonUsers Tab in Options
    GRM_L["Players"] = true
    GRM_L["Bans"] = true
    GRM_L["Details"] = true
    GRM_L["Syncing all player data."] = true
    GRM_L["Syncing all data except ban list. Player rank is too low."] = true
    GRM_L["Syncing all data except ban list. Your rank is too low."] = true
    GRM_L["Currently Syncing With: {name}"] = true
    GRM_L["{num}{custom1}: Bans"] = true
    GRM_L["Sync has begun after waiting in queue for {num} seconds"] = true
    GRM_L["Not Determined"] = true  -- Ban List

end
