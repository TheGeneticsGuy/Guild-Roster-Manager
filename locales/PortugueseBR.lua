
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

GRML.PortugueseBR = function()

    -- Auto Localized (Only use this on Client languages)
    GRM_L["Friend"] = FRIEND;

    -- SET YOUR OWN CUSTOM SLASH COMMAND FOR GRM
    GRM_L["/XXXX"] = true                           -- /grm will always work, now you can make your own acronym that fits your language. Example: GRM_L["/XXXX"] = "/грм" - Now, if you type /грм it will work in-game

    GRM_L["German"] = "Alemão"
	GRM_L["English"] = "Inglês"
	GRM_L["French"] = "Francês"
	GRM_L["Italian"] = "Italiano"
	GRM_L["Russian"] = "Russo"
	GRM_L["SpanishMX"] = "Espanhol (MX)"
	GRM_L["SpanishEU"] = "Espanhol (EU)"
    GRM_L["Portuguese"] = "Português (EU)"
    GRM_L["PortugueseBR"] = "Português (BR)"
	GRM_L["Korean"] = "Coreano"
	GRM_L["MandarinCN"] = "Mandarim (China)"
    GRM_L["MandarinTW"] = "Mandarim (Taiwan)"
    GRM_L["Dutch"] = "Holandês"
    GRM_L["Danish"] = "Dinamarquês"

    -- PLAYER MAIN ROSTER DETAILS WINDOW DONE
    GRM_L["Level: "] = "Nível: "
    GRM_L["Level"] = "Nível"
    GRM_L["Note:"] = "Nota:"
    GRM_L["Note"] = "Nota"
    GRM_L["Officer's Note:"] = "Nota de Oficial:"
    GRM_L["Officer's Note"] = "Nota de Oficial"
    GRM_L["Zone:"] = "Zona:"
    GRM_L["(main)"] = true
    GRM_L["( Main )"] = true                                -- Context: This one is used on player data window, the other is smaller used in the alts list...
    GRM_L["Set as Main"] = "Setar como Main"
    GRM_L["Set as Alt"] = "Setar como Alt"
    GRM_L["Remove"] = "Remover"
    GRM_L["Please Type the Name of the alt"] = "Por Favor digite o Nome do Alt"
    GRM_L["Promoted:"] = "Promovido:"
    GRM_L["Unknown"] = "Desconhecido"                                                                -- Context: The date of their promotion is "Unknown"
    GRM_L["Click here to set a Public Note"] = "Clique aqui para setar a Nota Pública"
    GRM_L["Unable to Edit Public Note at Rank"] = "Não é possível editar a Nota Pública no Cargo" 
    GRM_L["Click here to set an Officer's Note"] = "Clique aqui para setar a Nota de Officer"
    GRM_L["Unable to Edit Officer Note at Rank"] = "Não é possível editar a Nota de Officer no Cargo"
    GRM_L["Unable to View Officer Note at Rank"] = "Não é possível ver a Nota de Officer no Cargo"
    GRM_L["Online"] = true
    GRM_L["( Active )"] = "( Ativo )"                       -- I included the parentheses here as I am not sure if any languages abstain from them, or use other notation. Feel free to remove if necessary
    GRM_L["( AFK )"] = true
    GRM_L["( Busy )"] = "( Ocupado )"
    GRM_L["( Mobile )"] = "( Móvel )"
    GRM_L["( Offline )"] = true
    GRM_L["Set Join Date"] = "Setar Data de Entrada" 
    GRM_L["Edit Promo Date"] = "Editar Data de Promoção"
    GRM_L["Edit Join Date"] = "Editar Data de Entrada"
    GRM_L["Set Promo Date"] = "Setar Data de Promoção"
    GRM_L["No Invite"] = "Sem Invite"
    GRM_L["Group Invite"] = "Invite de Grupo"
    GRM_L["Date Promoted?"] = "Data que foi Promovido?"
    GRM_L["Last Online"] = "Última vez online"
    GRM_L["Time In:"] = true                            -- Context: "Time In" the current zone...
    GRM_L["Date Joined"] = "Data que Entrou"
    GRM_L["Join Date?"] = "Data que Entrou?"
    GRM_L["Player Was Previously Banned!"] = "Jogador foi Banido Anteriormente!"
    GRM_L["Ignore Ban"] = "Ignorar Ban"
    GRM_L["Player Alts"] = "Alts do Jogador"
    GRM_L["Add Alt"] = "Adc Alt"
    GRM_L["Choose Alt"] = "Escolher Alt"
    GRM_L["Guild Log"] = "Registro"
    GRM_L["Guild"] = "Guilda"

    -- TOOLTIPS DONE
    GRM_L["Rank History"] = "Histórico de Cargo" 
    GRM_L["Time at Rank:"] = "Tempo no Cargo:"
    GRM_L["Right-Click to Edit"] = "Clique com o Direito para Editar"
    GRM_L["Left Guild"] = "Saiu da Guilda"
    GRM_L["Membership History"] = "Histórico de Membro"
    GRM_L["Joined:"] = "Entrou:"                             -- as in "Joined" the guild
    GRM_L["Joined"] = "Entrou"
    GRM_L["Left:"] = "Saiu:"                               -- as in, "Left" the guild
    GRM_L["Rejoined:"] = "Retornou:"                           -- as in, "Rejoined" the guild
    GRM_L["Rejoined"] = "Retornou" 
    GRM_L["Reset Data!"] = "Resetar Dados!"
    GRM_L["Notify When Player is Active"] = "Notificar Quando Jogador está Ativo"
    GRM_L["Notify When Player Goes Offline"] = "Notificar Quando Jogador Estiver Offline"
    GRM_L["Notify When Player Comes Online"] = "Notificar Quando Jogador Estiver Online"
    GRM_L["Edit Date"] = "Editar Data"
    GRM_L["Clear History"] = "Limpar Histórico"
    GRM_L["Options"] = "Opções"
            
    -- LOG DONE
    GRM_L["LOG"] = "REGISTRO"                                                     -- Context - The guild Log shorthand for the tab
    GRM_L["Guild Roster Event Log"] = "Registro de Eventos"
    GRM_L["Clear Log"] = "Limpar Registro"
    GRM_L["Really Clear the Guild Log?"] = "Quer mesmo Limpar o Registro da Guilda?"
    GRM_L["{name} KICKED {name2} from the Guild!"] = "{name} EXPULSOU {name2} da Guilda!"
    GRM_L["kicked"] = "expulso"
    GRM_L["{name} has Left the guild"] = "{name} Saiu da guilda"
    GRM_L["{name} has BANNED {name2} and all linked alts from the guild!"] = "{name} BANIU {name2} e todos os alts interligados da guilda!"
    GRM_L["{name} has BANNED {name2} from the guild!"] = "{name} BANIU {name2} da guilda!" 
    GRM_L["Reason Banned:"] = "Razão do Banimento:"
    GRM_L["has Left the guild"] = "Saiu da guilda"                                     -- Context: PlayerName "has left the guild"
    GRM_L["ALTS IN GUILD:"] = "ALTS NA GUILDA:"                                          -- Context: This appears If a person leaves the guild and there are still alts in the guild. It is like - "ALTS IN GUILD: Arkaan, Chris, Matt, and 4 others.""
    GRM_L["Player no longer on Server"] = "Jogador não está mais no Servidor"
    GRM_L["{name} PROMOTED {name2} from {custom1} to {custom2}"] = "{name} PROMOVEU {name2} de {custom1} para {custom2}"
    GRM_L["{name} has been PROMOTED from {custom1} to {custom2}"] = "{name} foi PROMOVIDO de {custom1} para {custom2}"
    GRM_L["{name} DEMOTED {name2} from {custom1} to {custom2}"] = "{name} REBAIXOU {name2} de {custom1} para {custom2}"
    GRM_L["{name} has been DEMOTED from {custom1} to {custom2}"] = "{name} foi REBAIXADO de {custom1} para {custom2}"
    GRM_L["(+ {num} More)"] = "(+ Mais {num})"                                          -- Context: Referencing num of alts if player leaves guild, that are stil in it. Example "ALTS IN GUILD: Christ, Matt, Sarah (and 4 more)"
    GRM_L["{name} has Been in the Guild {num} Times Before"] = "{name} Esteve na Guilda {num} Vezes Antes"
    GRM_L["{name} is Returning for the First Time."] = "{name} está Retornando pela Primeira Vez."
    GRM_L["None Given"] = "Não Informado"                                              -- Context: No reason given for player ban. This is displayed when a player was banned, but the addon users did not input a reason why.
    GRM_L["WARNING!"] = "AVISO!"                                               -- Context: WARNING - banned player rejoined the guild!
    GRM_L["{name} REJOINED the guild but was previously BANNED!"] = "{name} RETORNOU a guilda mas foi BANIDO anteriormente!"
    GRM_L["(Invited by: {name})"] = "(Convidado por: {name})"
    GRM_L["Invited By: {name}"] = "Comvidado Por: {name}"
    GRM_L["Date of Ban:"] = "Data do Ban:"
    GRM_L["Date Originally Joined:"] = "Data de Entrada Original:"
    GRM_L["Old Guild Rank:"] = "Velho Cargo de Guilda:"
    GRM_L["Additional Notes:"] = "Nota Adicional:"
    GRM_L["{name} has REINVITED {name2} to the guild"] = "{name} RECONVIDOU {name2} para a guilda"
    GRM_L["(LVL: {num})"] = true                                            -- Context: LVL means Player Level - so Ex: (LVL: 110)
    GRM_L["{name} has REJOINED the guild"] = "{name} REENTROU na guilda"
    GRM_L["{name} has JOINED the guild!"] = "{name} ENTROU na guilda!"
    GRM_L["Date Left:"] = "Data de Saída:"
    GRM_L["{name} has Leveled to {num}"] = "{name} subiu de Nível para {num}"
    GRM_L["(+{num} levels)"] = "(+{num} níveis)"                                        -- Context: Person gained more than one level, hence the plural
    GRM_L["(+{num} level)"] = "(+{num} nível)"                                         -- Context: Person gains a level, just one level.
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Added"] = "Nota PÚBLICA de {name}: \"{custom1}\" foi Adicionada"           -- Of note, the \" in the text here will just appear as " in-game. The \" notation is telling the program not to end the string, but to include quotation
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Removed"] = "Nota PÚBLICA de {name}: \"{custom1}\" foi Removida"  
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" to \"{custom2}\""] = "Nota PÚBLICA de {name}: \"{custom1}\" para \"{custom2}\""    -- Context: "Arkaan's PUBLIC Note: "ilvl 920" to "Beast Mode ilvl 960""  -- Changing of the note. custom1 = old note, custom2 = new note
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Added"] = "Nota de Oficial de {name}: \"{custom1}\" foi Adicionada"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Removed"] = "Nota de Oficial de {name}: \"{custom1}\" foi Removida"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" to \"{custom2}\""] = "Nota de Oficial de {name}: \"{custom1}\" para \"{custom2}\""
    GRM_L["Guild Rank Renamed from {custom1} to {custom2}"] = "Cargo de Guilda Renomeado de {custom1} para {custom2}"
    GRM_L["{name} has Name-Changed to {name2}"] = "{name} Mudou de Nome para {name2}"
    GRM_L["{name} has Come ONLINE after being INACTIVE for {num}"] = "{name} está ONLINE depois de ficar INATIVO por {num}"
    GRM_L["{name} has been OFFLINE for {num}. Kick Recommended!"] = "{name} esteve OFFLINE por {num}. Expulsão Recomendada!"
    GRM_L["({num} ago)"] = "({num} atrás)"                                             -- Context: (5 minutes ago) or (5 months 24 days ago) -- the {num} will automatically include the time-passed date.
    GRM_L["{name}'s Guild has Name-Changed to \"{name2}\""] = "A Guilda de {name} Mudou de Nome para \"{name2}\""
    GRM_L["Promotions"] = "Promoções"
    GRM_L["Demotions"] = "Rebaixamentos"

    -- EVENTS WINDOW DONE
    GRM_L["EVENTS"] = "EVENTOS"                                          -- Events tab
    GRM_L["{name}'s Anniversary!"] = "Aniversário de {name}!"
    GRM_L["{name}'s Birthday!"] = "Dia do Aniversário de {name}!"
    GRM_L["Event Calendar Manager"] = "Gerenciador de Eventos do Calendário"
    GRM_L["Event:"] = "Evento:"
    GRM_L["Description:"] = "Descrição:"
    GRM_L["Add to\nCalendar"] = "Adicionar ao\nCalendário"
    GRM_L["Ignore Event"] = "Ignorar Evento"
    GRM_L["No Player Event Has Been Selected"] = "Nenhum evento de Jogador foi Selecionado"
    GRM_L["Event Added to Calendar: {custom1}"] = "Evento Adicionado ao Calendário: {custom1}"              -- Custom1 = the title of the event, like "Arkaan's Anniversary"
    GRM_L["Please Select Event to Add to Calendar"] = "Por Favor Selecione o Evento á ser Adicionado ao Calendário"
    GRM_L["No Calendar Events to Add"] = "Nenhum Evento de Calendário para Adicionar"
    GRM_L["{name}'s event has already been added to the calendar!"] = "o evento de {name} já foi adicionado ao calendário!"
    GRM_L["Please wait {num} more seconds to Add Event to the Calendar!"] = "Por Favor espere mais {num} segundos para Adicionar Evento ao Calendário!"
    GRM_L["{name}'s Event Removed From the Queue!"] = true
    GRM_L["Full Description:"] = "Descrição Total:"

    -- BAN WINDOW DONE
    GRM_L["BAN LIST"] = "LISTA DE BANS"                                        -- Ban List Tab
    GRM_L["Reason Banned?"] = "Banido Por?"
    GRM_L["Click \"YES\" When Done"] = "Clique \"SIM\" Quando Terminar"                        -- Of note, the \" is how you notate for quotations to actually appear. Adjust as needed
    GRM_L["Select a Player"] = "Selecione o Jogador"
    GRM_L["Player Selected"] = "Jogador Selecionado"
    GRM_L["{name}(Still in Guild)"] = "{name}(Ainda na Guilda)"
    GRM_L["(Still in Guild)"] = "(Ainda na Guilda)"
    GRM_L["No Ban Reason Given"] = "Não foi dada Razão de Ban"
    GRM_L["Total Banned:"] = "Total de Banidos:"
    GRM_L["Rank"] = "Cargo"
    GRM_L["Ban Date"] = "Data do Ban"
    GRM_L["No Players Have Been Banned from Your Guild"] = "Nenhum Jogador Foi Banido da Sua Guilda"
    GRM_L["Remove Ban"] = "Remover Ban"
    GRM_L["Add Player to Ban List"] = "Adicionar Jogador á Lista de Ban"
    GRM_L["Server:"] = "Servidor:"
    GRM_L["Class:"] = "Classe:"
    GRM_L["Reason:"] = "Razão:"
    GRM_L["It is |CFFFF0000CRITICAL|r the player's name and server are spelled correctly for accurate tracking and notifications."] = "É |CFFFF0000VITAL|r que o nome do jogador e do servidor estejam digitados corretamente para um rastreamento preciso e notificações."
    GRM_L["Submit Ban"] = "Enviar Ban"
    GRM_L["Confirm"] = "Confirmar"
    GRM_L["Cancel"] = "Cancelar"
    GRM_L["Add"] = "Adicionar"                                         -- Context: "Add" player to ban list
    GRM_L["Confirm Ban for the Following Player?"] = "Confirmar Ban para o Seguinte Jogador?"
    GRM_L["Please Enter a Valid Player Name"] = "Por Favor Entre com um Nome Válido de Jogador"            -- Player Name
    GRM_L["Please Enter a Valid Server Name"] = "Por Favor Entre com um Nome Válido de Servidor"             -- Server Name
    GRM_L["Please Select a Player to Unban!"] = "Por Favor Selecione um Jogador para Desbanir!"
    GRM_L["{name} - Ban List"] = "{name} - Lista de Ban"                           -- Context: "GuildName - Ban List"
    GRM_L["No Reason Given"] = "Não Informado"

    -- ADDON USERS WINDOW DONE
    GRM_L["Ok!"] = true
    GRM_L["Their Rank too Low"] = "Cargos Deles é Muito Baixo"
    GRM_L["Your Rank too Low"] = "Seu Cargo é Muito Baixo"
    GRM_L["Outdated Version"] = "Versão Desatualizada"
    GRM_L["You Need Updated Version"] = "Precisa da Versão Atualizada"
    GRM_L["Player Sync Disabled"] = "Sincronização de Player Desativada"
    GRM_L["No Guildie Online With Addon."] = "Ninguém na Guilda Online com o Addon."
    GRM_L["ONE Person is Online. Recommend It!"] = "UMA Pessoa está Online. Recomende!"
    GRM_L["{num} others are Online! Recommend It!"] = "Outros {num} estão Online! Recomende!"
    GRM_L["GRM Sync Info"] = "Informações de Sincronização do GRM"
    GRM_L["Ver: {custom1}"] = true                                  -- Context:  Ver: R1.125  - Ver is short for Version
    GRM_L["Name:"] = "Nome:"
    GRM_L["Version"] = "Versão"
    GRM_L["Sync"] = "Sincronia"
    GRM_L["Your Sync is Currently Disabled"] = "Sua Sincronização está Desativada no Momento"

    -- OPTIONS WINDOW DONE
    GRM_L["Public Note"] = "Nota Pública "
    GRM_L["Scanning Roster:"] = "Escaniando Lista:"
    GRM_L["Guild Rank Restricted:"] = "Restrito á Cargo da Guilda:"
    GRM_L["Sync:"] = "Sincronia:"
    -- Options window -- of note, these are very concise statements. They may need to be adjusted properly in the Options window for proper spacing, so verify they look ok after translating.
    GRM_L["Slash Commands"] = "Comandos de Barra"
    GRM_L["Trigger scan for changes manually"] = "Acionar scan para mudanças manualmente"
    GRM_L["Trigger sync one time manually"] = "Acionar sincronia manualmente uma vez"
    GRM_L["Centers all Windows"] = "Centralizar todas as Janelas"
    GRM_L["Slash command info"] = "Informação sobre os Comandos de Barra"
    GRM_L["Resets ALL data"] = "Reseta TODOS os dados"
    GRM_L["Report addon ver"] = "Relata a versão do addon"                                    -- Ver is short for Version
    GRM_L["Resets Guild data"] = "Reseta os dados da Guilda"
    GRM_L["Show at Logon"] = "Mostrar ao Entrar"
    GRM_L["Only Show if Log Changes"] = "Só Mostrar caso o Registro Mude"
    
    -- This do need to be translated still
    GRM_L["Before Scan Timer"] = "Scan for Changes Every"                  -- Context: "Scan for Changes Every 10 Seconds" -- There will be a number added here and may require custom positioning, so please provide full statement and Arkaan will allign
    GRM_L["After Scan Timer"] = "Seconds"
    GRM_L["Before Inactive Timer"] = "Report Inactive Return if Player Offline"
    GRM_L["After Inactive Timer"] = "Days"

    GRM_L["Reactivating SCAN for Guild Member Changes..."] = "Reativando SCAN para alterações de membros da guilda ..."
    GRM_L["Deactivating SCAN of Guild Member Changes..."] = "Desativando SCAN para alterações de membros da guilda ..."
    GRM_L["Please choose a scan interval {num} seconds or higher!"] = "Por Favor escolha um intervalo de scan de {num} segundos ou mais!"
    GRM_L["{num} is too Low!"] = "{num} é muito Baixo!"
    GRM_L["The Current Lvl Cap is {num}."] = "O Limite Atual de Nível é {num}."
    GRM_L["Kick Inactive Player Reminder at"] = "Lembrar de Banir Jogador Inativo em"        -- Context: "Kick Inactive Player Reminder at X Months" - Again, allignment will need to be adjusted for options UI, so please post
    GRM_L["Please choose a month between 1 and 99"] = "Por Favor escolha um mês entre 1 e 99"
    GRM_L["Please choose a month between 0 and 99"] = "Por Favor escolha um mês entre 0 e 99"
    GRM_L["Sync BAN List With Guildies at Rank"] = "Sincronizar Lista de BANS com membros no Cargo"    -- Context: "Sync Ban List with Guildies at Rank [DROPDOWNMENU OF RANKS] or Higher" - Please show where dropdown menu should be pinned
    GRM_L["or Higher"] = "ou Maior"                               -- Context: Look at the above statement. Show where this needs to go in regards to dropdown menu of rank selection in Options
    GRM_L["Restore Defaults"] = "Restaurar Configurações"
    GRM_L["Please choose between 1 and 180 days!"] = "Por Favor escolha entre 1 e 180 dias!"
    GRM_L["Announce Events"] = "Anunciar Eventos"                         -- Context: "Announce Events X number of days in advance" -- the X is the editbox to modify number of days. Please include the location of where to pin that.
    GRM_L["Days in Advance"] = "Dias Antes"
    GRM_L["Please choose between 1 and 28 days!"] = "Por Favor escolha entre 1 e 28 dias!"
    GRM_L["Add Events to Calendar"] = "Adicionar Eventos ao Calendário"
    GRM_L["SYNC Changes With Guildies at Rank"] = "SINCRONIZAR Mudanças Com Membros no Cargo"      -- Context: at Rank [DROPDOWNRANKSELECTION] or Higher. - Please note where to place dropdown box in the position of the sentence.
    GRM_L["Reactivating Data SYNC with Guildies..."] = "Reativando SINCRONIA de Dados com Membros..."
    GRM_L["Deactivating Data SYNC with Guildies..."] = "Desativando SINCRONIA de Dados com Membros..."
    GRM_L["Display Sync Update Messages"] = "Exibir Mensagens de Atualização de Sincronização"
    GRM_L["Only Sync With Up-to-Date Addon Users"] = "Sincronizar Apenas com Usuários do Addon Mais Atual"
    GRM_L["Leveled"] = "Subiu de Nível"
    GRM_L["Inactive Return"] = "Retorno Inativo"
    GRM_L["resetall"] = "resetetudo"
    GRM_L["resetguild"] = "reseteguilda"
    --Side chat/log controls - Of note, limited spacing
    GRM_L["Name Change"] = "Mudança de Nome"
    GRM_L["Rank Renamed"] = "Cargo Renomeado"
    GRM_L["Event Announce"] = "Anúncio de Evento"
    GRM_L["Left"] = "Saiu"                        -- Context: As in, "Left" the guild...
    GRM_L["Recommendations"] = "Recomendações"
    GRM_L["Banned"] = "Banido"
    GRM_L["To Chat:"] = "Para Chat:"                   -- Context: "To Chat Message frame -- in regards to announcing events like when a player leveled"
    GRM_L["To Log:"] = "Para Registro:"                    -- Context: To show it in the guild log.
    GRM_L["Display Changes"] = "Exibir Alterações"
    GRM_L["Show 'Main' Name in Chat"] = "Mostrar Nome do 'Main' no Chat"

    -- AUDIT WINDOW DONE
    GRM_L["AUDIT"] = true                                               -- Audit Tab name
    GRM_L["No Date Set"] = "Sem Data Setada"
    GRM_L["Main"] = true
    GRM_L["Main or Alt?"] = "Main ou Alt?"
    GRM_L["Alt"] = true
    GRM_L["Total Incomplete: {num} / {custom1}"] = "Total Incompletos: {num} / {custom1}"                -- Context: Total Incomplete: 50 / 100    (50 out of 100)
    GRM_L["Mains:\n{num}"] = true                                        -- Context: Number of "main" toons
    GRM_L["Unique Accounts:\n{num}"] = "Contas Únicas:\n{num}"
    GRM_L["All Complete"] = "Tudo Concluído"                                        -- Context: All dates have been added and are known, thus it states it is "All Complete"
    GRM_L["Set Incomplete to Unknown"] = "Setar Incompletos para Desconhecido"                          -- Context: Implied to set ALL incomplete to unknown
    GRM_L["Clear All Unknown"] = "Limpar Todos Desconhecidos"
    GRM_L["Please Wait {num} more Seconds"] = "Por Favor Espere mais {num} Segundos"
    GRM_L["Guild Data Audit"] = "Audit de Dados da Guilda"
    GRM_L["Name"] = "Nome"
    GRM_L["Join Date"] = "Entrada"
    GRM_L["Promo Date"] = "Promovido"
    GRM_L["Main/Alt"] = true
    GRM_L["Only Show Incomplete Guildies"] = "Apenas Exibir Membros Incompletos"

    -- ADDON SYSTEM MESSAGES
    GRM_L["Guild Roster Manager"] = true
    GRM_L["GRM:"] = true                                                                -- Abbreviation for "Guild Roster Manager"
    GRM_L["(Ver:"] = true                                                               -- Ver: is short for Version:
    GRM_L["GRM Updated:"] = true
    GRM_L["Configuring Guild Roster Manager for {name} for the first time."] = true
    GRM_L["Notification Set:"] = true
    GRM_L["Report When {name} is ACTIVE Again!"] = true
    GRM_L["Report When {name} Comes Online!"] = true
    GRM_L["Report When {name} Goes Offline!"] = true
    GRM_L["A new version of Guild Roster Manager is Available!"] = true
    GRM_L["Please Upgrade!"] = true
    GRM_L["Player Does Not Have a Time Machine!"] = true
    GRM_L["Please choose a valid DAY"] = true
    GRM_L["{name} has been Removed from the Ban List."] = true
    GRM_L["Scanning for Guild Changes Now. One Moment..."] = true
    GRM_L["Initializing Sync Action. One Moment..."] = true
    GRM_L["No Players Currently Online to Sync With..."] = true
    GRM_L["SYNC is currently not possible! Unable to Sync with guildies when guild chat is restricted."] = true
    GRM_L["Manual Scan Complete"] = true
    GRM_L["Analyzing guild for the first time..."] = true
    GRM_L["Building Profiles on ALL \"{name}\" members"] = true                 -- {name} will be the Guild Name, for context
    GRM_L["NOTIFICATION:"] = true                                               -- Context:  "Notification: Player is no longer AFK"
    GRM_L["{name} is now ONLINE!"] = true
    GRM_L["{name} is now OFFLINE!"] = true
    GRM_L["{name} is No Longer AFK or Busy!"] = true
    GRM_L["{name} is No Longer AFK or Busy, but they Went OFFLINE!"] = true
    GRM_L["Player should try to obtain group invite privileges."] = true
    GRM_L["{name}'s saved data has been wiped!"] = true
    GRM_L["Wiping all Saved Roster Data Account Wide! Rebuilding from Scratch..."] = true
    GRM_L["Wiping all saved Guild data! Rebuilding from scratch..."] = true
    GRM_L["There are No Log Entries to Delete, silly {name}!"] = true
    GRM_L["Guild Log has been RESET!"] = true
    GRM_L["{name} is now set as \"main\""] = true
    GRM_L["{name} is no longer set as \"main\""] = true
    GRM_L["Reset All of {name}'s Data?"] = true
    
    -- /grm help done
    GRM_L["Opens Guild Log Window"] = "Abre Janela de Registros da Guilda"
    GRM_L["Resets ALL saved data"] = "Reseta TODOS os dados salvos"
    GRM_L["Resets saved data only for current guild"] = "Reseta dados salvos somente para a guilda atual"
    GRM_L["Re-centers the Log window"] = "Re-centra a janela de Registro"
    GRM_L["Triggers manual re-sync if sync is enabled"] = "Desencadeia re-sincronia manual se a sincronia estiver habilitada"
    GRM_L["Does a one-time manual scan for changes"] = "Faz uma varredura manual única em busca de alterações"
    GRM_L["Displays current Addon version"] = "Exibe versão atual do Addon"
    GRM_L["WARNING! Complete hard wipe, including settings, as if addon was just installed."] = "AVISO! limpeza completa, incluindo configurações, como se o addon tivesse acabado de ser instalado."

    -- General Misc UI Done
    GRM_L["Really Clear All Account-Wide Saved Data?"] = "Realmente Limpar Todos os Dados Salvos de Todas as Contas?"
    GRM_L["Really Clear All Guild Saved Data?"] = "Realmente Limpar Todos os Dados Salvos da Guilda?"
    GRM_L["Yes!"] = "Sim!"
    GRM_L["Ban Player?"] = "Banir Jogador?"
    GRM_L["Ban the Player's {num} alts too?"] = "Banir os {num} alts do Jogador também?"      -- Plural number of alts
    GRM_L["Ban the Player's {num} alt too?"] = "Banir o {num} alt do Jogador também?"     -- Singular number of alts, just 1
    GRM_L["Please Click \"Yes\" to Ban the Player!"] = "Por Favor Clique \"Sim\" para Banir o Jogador!"

    -- Sync Messages Done
    GRM_L["{name} updated {name2}'s Join Date."] = "{name} atualizou o Dia de Entrada de {name2}."
    GRM_L["{name} updated {name2}'s Promotion Date."] = "{name} atualizou o Dia de Promoção de {name2}"
    GRM_L["\"{custom1}\" event added to the calendar by {name}"] = "\"{custom1}\" evento adicionado ao calendário por {name}"
    GRM_L["{name} updated {name2}'s list of Alts."] = "{name} atualizou a lista de Alts de {name2}."
    GRM_L["{name} removed {name2} from {custom1}'s list of Alts."] = "{name} removeu {name2} da lista de Alts de {custom1}."
    GRM_L["{name} set {name2} to be 'Main'"] = "{name} setou {name2} como 'Main'"
    GRM_L["{name} has changed {name2} to be listed as an 'alt'"] = "{name} mudou {name2} para ser listado como 'alt'"
    GRM_L["{name} has Removed {name2} from the Ban List."] = "{name} Removeu {name2} da Lista de Bans."
    GRM_L["{name} has been BANNED from the guild!"] = "{name} foi BANIDO da guilda!"
    GRM_L["{name} has been UN-BANNED from the guild!"] = "{name} foi DESBANIDO da guilda!"
    GRM_L["Initiating Sync with {name} Instead!"] = "Em vez disso, Iniciando Sincronização com {name}!"
    GRM_L["Sync Failed with {name}..."] = "Sincronia com {name} Falhou..."
    GRM_L["The Player Appears to Be Offline."] = "O Jogador Parece Estar Offline."
    GRM_L["Manually Syncing Data With Guildies Now... One Time Only."] = "Sincronizando Dados Manualmente com Membros Agora... Apenas uma vez."
    GRM_L["Syncing Data With Guildies Now..."] = "Sincronizando Dados com Membros Agora..."
    GRM_L["(Loading screens may cause sync to fail)"] = "(Telas de carregamento podem causar falha na sincronização)"
    GRM_L["Sync With Guildies Complete..."] = "Sincronia Com Membros Completa..."
    GRM_L["Manual Sync With Guildies Complete..."] = "Sincronia Manual Com Membros Completa..."
    GRM_L["No Players Currently Online to Sync With. Re-Disabling Sync..."] = "Nenhum Jogador Atualmente Online para Sincronizar Com. Desabilitando Sincronia..."

    -- ERROR MESSAGES DONE
    GRM_L["Notification Has Already Been Arranged..."] = "A notificação Já Foi Arrumada..."
    GRM_L["Failed to add alt for unknown reason. Try closing Roster window and retrying!"] = "Falhou ao adicionar alt por razões desconhecidas. Tente fechar a janela da Lista e tente de novo!"
    GRM_L["{name} is Already Listed as an Alt."] = "{name} Já está Listado como Alt."
    GRM_L["{name} cannot become their own alt!"] = "{name} não pode ser seu próprio alt!"
    GRM_L["Player Cannot Add Themselves as an Alt"] = "Jogador Não Pode se Adicionar como um Alt"
    GRM_L["Player Not Found"] = "Jogador Não Encontrado"
    GRM_L["Please try again momentarily... Updating the Guild Event Log as we speak!"] = "Por Favor, tente novamente momentaneamente... Atualizando o Registro de Eventos da Guilda enquanto falamos!"
    GRM_L["Invalid Command: Please type '/grm help' for More Info!"] = "Comando Inválido: Por Favor digite '/grm help' para Obter Mais Informações!"
    GRM_L["{name} is not currently in a guild. Unable to Proceed!"] = "{name} não está atualmente em uma guilda. Não é Possível Continuar!"
    GRM_L["Addon does not currently support more than 75 alts!"] = "Atualmente, o addon não suporta mais de 75 alts!"
    GRM_L["Please choose a VALID character to set as an Alt"] = "Por Favor escolha um personagem VÁLIDO para setar como Alt"
    GRM_L["Please choose a character to set as alt."] = "Por Favor escolha um personagem para setar como Alt"
    GRM_L["GRM ERROR:"] = "ERRO GRM:"
    GRM_L["Com Message too large for server"] = "Mensagem de comunicação muito grande para o servidor"                   -- Context: "Com message" is short-hand for "Communications message" - this is a technical error on syncing data.
    GRM_L["Prefix:"] = "Prefixo:"
    GRM_L["Msg:"] = true                                                -- Context: Msg is short for Message
    GRM_L["Unable to register prefix > 16 characters: {name}"] = "Não foi possível registrar o prefixo > 16 caracteres: {name}"   -- Context: The {name} is the string code for the prefix. This is for debugging.

    --SLASH COMMANDS
    -- These are generally written in general shorthand. The original commands will ALWAYS work, but if there is one that makes more sense in your language, please feel free to modify
    GRM_L["clearall"] = "limparcontas"                        -- Context: In regards, "Clear All" saved data account wide 
    GRM_L["clearguild"] = "limparguilda"                      -- Context: In regards, "Clear All" saved data from ONLY the current guild.
    GRM_L["hardreset"] = "formatar"                       -- Context: In regards, "Hard Reset" ALL data account wide, including wiping player settings
    GRM_L["help"] = "ajuda"                            -- Context: "help" with info on the how to use addon
    GRM_L["version"] = "versão"                         -- Context: "version" of the addon
    GRM_L["center"] = "centralizar"                          -- Context: "center" the movable addon window back to center of screen
    GRM_L["sync"] = "sincronizar"                            -- Context: "sync" the data between players one time now.
    GRM_L["scan"] = true                            -- Context: "scan" for guild roster changes one time now.

    -- CLASSES
    GRM_L["Deathknight"] = "Cavaleiro da Morte"
    GRM_L["Demonhunter"] = "Caçador de Demônios"
    GRM_L["Druid"] = "Druida"
    GRM_L["Hunter"] = "Caçador"
    GRM_L["Mage"] = "Mago"
    GRM_L["Monk"] = "Monge"
    GRM_L["Paladin"] = "Paladino"
    GRM_L["Priest"] = "Sacerdote"
    GRM_L["Rogue"] = "Ladino"
    GRM_L["Shaman"] = "Xamã"
    GRM_L["Warlock"] = "Bruxo"
    GRM_L["Warrior"] = "Guerreiro"

    -- TIME AND DATES
    GRM_L["1 Mar"] = "1 mar"                           -- This date is used in a specific circumstance. If someone's anniversary/bday landed on a leap year (Feb 29th), it defaults to the 1st of March on non-leap year
    -- Full Month Name
    GRM_L["January"] = "Janeiro"
    GRM_L["February"] = "Fevereiro"
    GRM_L["March"] = "Março"
    GRM_L["April"] = "Abril"
    GRM_L["May"] = "Maio"
    GRM_L["June"] = "Junho"
    GRM_L["July"] = "Jul"
    GRM_L["August"] = "Agosto"
    GRM_L["September"] = "Setembro"
    GRM_L["October"] = "Out"
    GRM_L["November"] = "Novembro"
    GRM_L["December"] = "Dezembro"
    -- Shorthand Month
    GRM_L["Jan"] = "Jan"
    GRM_L["Feb"] = "Fev"
    GRM_L["Mar"] = "Mar"
    GRM_L["Apr"] = "Abr"
    GRM_L["May"] = "Mai"
    GRM_L["Jun"] = "Jun"
    GRM_L["Jul"] = "Jul"
    GRM_L["Aug"] = "Ago"
    GRM_L["Sep"] = "Set"
    GRM_L["Oct"] = "Out"
    GRM_L["Nov"] = "Nov"
    GRM_L["Dec"] = "Dez"
    -- Time Notifcation
    GRM_L["Seconds"] = "Segundos"
    GRM_L["Second"] = "Segundo"
    GRM_L["Minutes"] = "Minutos"
    GRM_L["Minute"] = "Minuto"
    GRM_L["Hours"] = "Horas"
    GRM_L["Hour"] = "Hora"
    GRM_L["Days"] = "Dias"
    GRM_L["Day"] = "Dia"
    GRM_L["Months"] = "Mêses"
    GRM_L["Month"] = "Mês"
    GRM_L["HourBreak"] = ":"            -- Context, in English, and many languages, 11am = 11:00 -- or in French, 11h00   - the hour break is the ":" or the "h" 

    GRM_L["am"] = true
    GRM_L["pm"] = true
    GRM_L["24HR_Notation"] = "";        -- if someone is using 24hr time notation in your country, instead of 12hr, how do you notate it? In English, there is no am/pm (though "hours" is technically right, but unnecessary)

    GRM_L["{num} year"] = "{num} ano"
    GRM_L["{num} years"] = "{num} anos"
    GRM_L["{num} month"] = "{num} mês"
    GRM_L["{num} months"] = "{num} mêses"
    GRM_L["{num} day"] = "{num} dia"
    GRM_L["{num} days"] = "{num} dias"
    GRM_L["< 1 day"] = "< 1 dia"

    GRM_L["{num} an"] = true
    GRM_L["< 1 hour"] = "< 1 hora"
    GRM_L["{num} {custom1}"] = true     -- Context: This is a placeholder for ANY generic time data -- Ex:  "1 year" or "15 months" - The translation is set this is just to set the orientation of the number properly.

    -- MISC Punctuation
    GRM_L[","] = true                               -- I know in some Asia languages, a comma is not used, but something similar, for example.

    -- Updates 1.126
    GRM_L["General"] = "Geral"
    GRM_L["General:"] = "Geral:"
    GRM_L["Scan"] = true
    GRM_L["Help"] = "Ajuda"
    GRM_L["UI"] = true                             -- UI for User Interface. Abbreviation for changing custom UI featuers, like coloring of <M> main
    GRM_L["Officer"] = "Oficial"                         -- as in, "Officer" rank
    GRM_L["Open Addon Window"] = "Abrir Janela do Addon"
    GRM_L["Sync Addon Settings on All Alts in Same Guild"] = "Sincronizar Configurações de Addon em Todos os Alts na Mesma Guilda"
    GRM_L["Show Minimap Button"] = "Mostrar Botão do Minimapa"
    GRM_L["Player is Not Currently in a Guild"] = "O Jogador Não está Atualmente em uma Guilda"
    -- tooltips
    GRM_L["|CFFE6CC7FClick|r to open GRM"] = "|CFFE6CC7FClique|r para abrir o GRM"                          -- Please maintain the color coding
    GRM_L["|CFFE6CC7FRight-Click|r to Reset to 100%"] = "|CFFE6CC7FClique com o Direito|r para Resetar para 100%"                -- for the Options slider tooltip
    GRM_L["|CFFE6CC7FRight-Click|r to Set Notification of Status Change"] = "|CFFE6CC7FClique com o Direito|r para Setar Notificações de Mudança de Status"
    -- tooltip end
    GRM_L["GRM"] = true
    GRM_L["Include Unknown as Incomplete"] = "Incluir Desconhecido como Incompleto"                           -- Context: Unknown in the Audit Tab will be hidden if filtering out complete players
    GRM_L["You Do Not Have Permission to Add Events to Calendar"] = "Você Não Tem Permissão para Adicionar Eventos no Calendário"
    GRM_L["Please Select Which Join Date to Sync"] = "Por Favor Selecione Qual Data de Entrada para Sincronizar"
    GRM_L["Sync All Alts to {name}'s Join Date"] = "Sincronizar Todos os Alts para a Data de Entrada de {name}"
    GRM_L["Sync All Alts to the Earliest Join Date: {name}"] = "Sincronizar Todos os Alts para a Data de Entrada mais Antiga: {name}"
    GRM_L["Sync All Alts to {name}'s |cffff0000(main)|r Join Date"] = "Sincronizar Todos os Alts para a Data de Entrada de {name} |cffff0000(main)|r"  -- The coloring ensures that "(main)" maintains the RED color. Please keep it consistent if relevant to your language.
    GRM_L["Join Date of All Alts is Currently Synced"] = "Data de Entrada de Todos os Alts está Sincronizado Currently Synced"

    -- Update 1.130
    GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button."] = "|CFFE6CC7FCtrl-Shift-Clique|r para Esconder esse Botão."
    GRM_L["Invited By:"] = "Convidado Por:"
    GRM_L["Error: Guild Not Found..."] = "Erro: Guilda Não Encontrada..."
    GRM_L["Debugger Start"] = "Iniciar o Depurador";

    -- Update 1.136
    GRM_L["Backup Point Removed for Guild \"{name}\""] = "Ponto de Backup Removido para Guilda \"{name}\""
    GRM_L["Backup Point Restored for Guild \"{name}\""] = "Ponto de Backup Restaurado para Guilda \"{name}\""
    GRM_L["Backup Point Set for Guild \"{name}\""] = "Ponto de Backup Setado para Guilda \"{name}\""
    GRM_L["Backup"] = true
    GRM_L["Horde"] = "Horda"
    GRM_L["Alliance"] = "Aliança"
    GRM_L["Creation Date"] = "Data de Criação"
    GRM_L["Members"] = "Membros"
    GRM_L["Backup {num}:"] = true           -- As in, the number of backups... so "Backup 1:"
    GRM_L["None"] = "Nenhum"
    GRM_L["Restore"] = "Restaurar"
    GRM_L["Set Backup"] = "Setar Backup"
    GRM_L["Memory Usage: {num} MB"] = "Memória Usada: {num} MB"         -- MB references the number of MegaBytes of memory used.

    -- Update 1.137
    GRM_L["GRM: Unable to Create Backup for a Guild With Unknown Creation Date! Log into that guild on any alt to update old database."] = "GRM: Não foi Possível Criar Backup para uma Guilda com Data de Criação Desconhecida! Entre nessa guilda em qualquer alt para atualizar o banco de dados antigo."
    GRM_L["Enable Auto-Backup Once Every"] = "Habilitar Auto-Backup Uma Vez Á Cada"
    GRM_L["Auto {num}:"] = true
    GRM_L["Please Choose a Time Interval Between 1 and 99 Days!"] = "Por Favor Escolha um Intervalo de Tempo Entre 1 e 99 Dias!"
    GRM_L["Really restore {name} Backup Point?"] = "Realmente restaurar o Ponto de Backup {name}?"
    GRM_L["Check All"] = "Marcar Tudo"

    -- Update 1.139
    GRM_L["Right-Click for options to remove this guild from the addon database completely"] = "Clique com o Direito para opções de remover esta guilda do banco de dados do addon completamente"
    GRM_L["Player Cannot Purge the Guild Data they are Currently In!!!"] = "Jogador Não Pode Expurgar a Guilda que ele está Atualmente!!!"
    GRM_L["To reset your current guild data type '/grm clearguild'"] = "Para resetar os dados atuais da guilda digite '/grm clearguild'"
    GRM_L["Click Here to Remove all traces of this guild, or hit ESC"] = "Clique Aqui para Remover todos os traços dessa guilda, ou aperte ESC"
    GRM_L["{name} has been removed from the database."] = "{name} foi removido do banco de dados."              -- The Guild Name has been removed from the database

    -- update 1.141
    GRM_L["Only Restrict Incoming Player Data to Rank Threshold, not Outgoing"] = true
    GRM_L["Total Entries: {num}"] = "Total de Entradas: {num}"
    GRM_L["Search Filter"] = "Filtro de Pesquisa"

    -- update 1.142
    GRM_L["Choose Color:"] = "Escolha a Cor:"
    GRM_L["Format:"] = "Formato:"
    GRM_L["RGB Values Must be Between 1 and 255."] = "Valores RGB Devem estar Entre 1 e 255."

    -- Update 1.143
    GRM_L["The Log is Currently Empty for This Guild"] = "O Registro está Atualmente Vazio para Essa Guilda"
    GRM_L["Building Log for Export..."] = "Montando Registro para Exportar..."
    GRM_L["Open Log Tools"] = "Abrir Ferramentas do Registro"
    GRM_L["Hide Log Tools"] = "Esconder Ferramentas do Registro"
    GRM_L["Numbered Lines"] = "Linhas Numeradas"
    GRM_L["Export Log"] = "Exportar Registro"
    GRM_L["Clear Lines:"] = "Limpar Linhas:"
    GRM_L["Enable Ctrl-Shift-Click Line Removal"] = "Habilitar Ctrl-Shift-Click para Remoção de Linhas"
    GRM_L["To"] = "Á"                                     -- Clear Lines:  50 To 100     -- It stands between 2 edit boxes as its own fontstring, so work with that.
    GRM_L["Confirm Clear"] = "Confirmar Limpeza"
    GRM_L["Please Select Range of Lines from the Log You Wish to Remove"] = "Por Favor Selecione o Intervalo de Linhas do Registro Que Deseja Remover"
    GRM_L["Please put the lowest number in the first box"] = "Por Favor ponha o número mais baixo na primeira caixa"
    GRM_L["Line selection is not valid"] = "Seleção de Linha inválida"
    GRM_L["Really Clear lines {custom1} to {custom2}?"] = "Realmente Limpar linhas {custom1} para {custom2}?"
    GRM_L["Enabling Line Numbers... Please choose within the given range"] = "Habilitando Números de Linha ... Por favor, escolha dentro do intervalo especificado"
    GRM_L["Ctrl-C to Copy <> Ctrl-P to Paste <> Ctrl-A to Select All"] = "Ctrl-C para Copiar <> Ctrl-P para Colar <> Ctrl-A para Selecionar Tudo"
    GRM_L["Language Selection:"] = "Seleção de Idiomas:"
    GRM_L["{num} phrases still need translation to {name}"] = "{num} frases ainda precisam de tradução para o {name}"                  -- Ex: 300 phrases still need translation to German

    -- update 1.145
    GRM_L["You currently are at {num} non-Battletag friends. To fully take advantage of all of GRM features, please consider clearing some room."] = "Você tem atualmente {num} amigos sem Battletag. Para se aproveitar totalmente de todas as funcionalidades do GRM, por favor considere abrir espaço."

    -- Update 1.146
    GRM_L["Really Clear line {num}?"] = "Realmente Limpar linha {num}?"
    GRM_L["Font has been Reset to DEFAULT."] = "Fonte foi Resetada para PADRÃO."
    GRM_L["Font Selection:"] = "Seleção de Fonte:"
    GRM_L["Font Scale:"] = "Escala da Fonte:"
    GRM_L["Example"] = "Exemplo"
    GRM_L["Right-Click to Reset to 100%"] = "Clique com o Direito para Resetar para 100%"

    -- Update 1.147
    GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Search the Log for Player"] = "|CFFE6CC7FCtrl-Shift-Click|r para Procurar Registro pelo Jogador"

    -- Update 1.1480
    GRM_L["Custom Notes:"] = "Notas Customizadas:"
    GRM_L["GRM Debugging Enabled."] = "Depurador do GRM Habilitado."
    GRM_L["GRM Debugging Disabled."] = "Depurador do GRM Desabilitado."
    GRM_L["Please type \"/grm debug 10\" to report 10 events (or any number)"] = "Por Favor digite \"/grm debug 10\" para relatar 10 eventos (ou qualquer número)"        -- Please keep the \"/grm debug 10)\" in-tact for slash command to work
    GRM_L["Format: \"/grm debug 10\""] = "Formato: \"/grm debug 10\""                                                                 -- "" Likewise
    GRM_L["Error: Debug Command not recognized."] = "Erro: Comando de Depuração não reconhecido."
    GRM_L["You may want to temporarily disable SYNC in the options if you are debugging another feature."] = "Você pode querer desabilitar temporariamente a SINCRONIA em opções se você estiver depurando outro recurso."
    GRM_L["Sync Custom Notes"] = "Notas Customizadas de Sincronia"
    GRM_L["Default Custom Note Rank Minimum"] = "Cargo Padrão Mínimo para Notas Customizadas"
    GRM_L["Reset Default Custom Note Restrictions for ALL Guildies"] = "Resetar Restrição de Nota Customizada para TODOS (Membros)"
    GRM_L["Reset"] = "Resetar"
    GRM_L["|CFF00CCFFDefault Selection For All Players"] = "|CFF00CCFFSeleção Padrão para Todos os Jogadores"
    GRM_L["Click here to set Custom Notes"] = "Clique aqui para setar Notas Customizadas"
    GRM_L["|CFF00CCFFCustom Note Defaults:"] = "|CFF00CCFFPadrões de Notas Customizáveis:"
    GRM_L["|CFFE6CC7FLeft-Click|r to re-enable custom note sync for all"] = "|CFFE6CC7FLeft-Clique|r para re-habilitar sincronia de notas customizáveis para todos"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Added"] = "{name} modificou a nota CUSTOMIZADA DE {name2}: \"{custom1}\" foi Adicionada"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Removed"] = "{name} modificou a nota CUSTOMIZADA DE {name2}: \"{custom1}\" foi Removida"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" to \"{custom2}\""] = "{name} modificou a nota CUSTOMIZADA DE {name2}: \"{custom1}\" para \"{custom2}\""
    GRM_L["Custom Note"] = "Nota Customizada"
    GRM_L["|CFFE6CC7FClick|r to Change Rank Restriction"] = "|CFFE6CC7FClique|r para Mudar a Restrição de Rank"
    GRM_L["|CFFE6CC7FClick|r to Change Day"] = "|CFFE6CC7FClique|r para Mudar o Dia"
    GRM_L["|CFFE6CC7FClick|r to Change Month"] = "|CFFE6CC7FClique|r para Mudar o Mês"
    GRM_L["|CFFE6CC7FClick|r to Change Year"] = "|CFFE6CC7FClique|r para Mudar o Ano"
    GRM_L["Edited by {name}"] = "Editado por {name}"
    GRM_L["Note Removed by {name}"] = "Nota Removida por {name}"
    GRM_L["|CFFFF0000Player No Longer in Guild"] = "|CFFFF0000Jogador Não Está Mais na Guilda"
    GRM_L["|CFF00CCFFMinimum Rank to Sync: Player Data, Ban List"] = "|CFF00CCFFCargo Mínimo para Sincronia: Dados de Jogador, Lista de Ban"
    GRM_L["Warning! Ban List rank threshold is below the overall sync rank. Changing from \"{name}\" to \"{name2}\""] = "Aviso! O limite de cargos da Lista de Ban está abaixo da sincronia geral de cargos. Mudando de \"{name}\" para \"{name2}\""
    GRM_L["|CFF00CCFFSync filter can be set tighter for the Ban List"] = "|CFF00CCFFO filtro de sincronia pode ser setado com mais precisão para a Lista de Ban"
    GRM_L["Warning! Unable to select a Ban List rank below \"{name}\""] = "Aviso! Não foi possível selecionar um cargo da Lista de Ban abaixo \"{name}\""
    GRM_L["Setting to match core filter rank"] = "Setando para corresponder com o filtro principal de cargos"

    -- R1.1482
    GRM_L["Shift-Click Name On Roster Also Works"] = "Shift-Clique no Nome Da Lista Também Funciona="
    GRM_L["Tooltip Scale:"] = true
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Language"] = "|CFFE6CC7FClique com O Esquerdo|r para Mudar o Idioma"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change Display Format"] = "|CFFE6CC7FClique com O Esquerdo|r para Mudar o Formato de Exibição"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Font"] = "|CFFE6CC7FClique com O Esquerdo|r para Mudar a Fonte"

    -- R1.1490
    GRM_L["Unable to properly locate guild for backup"] = "Incapaz de localizar corretamente a guilda para backup"

    -- R1.1500
    GRM_L["Unique accounts pull from the server is known to be faulty"] = "Puxar contas únicas do servidor é conhecido por ter falhas"
    GRM_L["Use only as an estimate. Hopefully Blizz fixes this soon"] = "Use apenas como uma estimativa. Espero que a Blizz conserte isso em breve"
    GRM_L["Add Upcoming Events to the Calendar"] = "Adicionar Próximos Eventos ao Calendário"
    GRM_L["Player rank unable to add events to calendar"] = "Cargo de Jogador incapaz de adicionar eventos ao calendário"
    GRM_L["Anniversaries, Birthdays, and Other Events can be added with permission"] = "Aniversários e Outros Eventos podem ser adicionados com permissão"

    -- R1.1510
    GRM_L["Check the \"Sync Users\" tab to find out why!"] = "Cheque a aba \"Sinc Usuários\" para saber o porque!"
    GRM_L["Time as Member:"] = "Tempo como Membro:"
    GRM_L["|CFFE6CC7FClick|r to select player event"] = "| CFFE6CC7FClique|r para selecionar o evento do jogador"
    GRM_L["Timestamp Format:"] = "Formato Data/Hora:"
    GRM_L["Hour Format:"] = "Formato da Hora:"
    GRM_L["24 Hour"] = "24 Horas"
    GRM_L["12 Hour (am/pm)"] = "12 Horas (am/pm)"
    GRM_L["Enable Fade on Tab Change"] = "Habilitar Ocultar Ao Mudar de Aba"
    GRM_L["Confirm Custom Note"] = "Confirmar Nota Customizada"

    -- R1.1520
    GRM_L["A new rank has been added to the guild!"] = "Um novo cargo foi adicionado a guilda!"
    GRM_L["{num} new ranks have been added to the guild!"] = "{num} novos cargos foram adicionados a guilda!"
    GRM_L["The guild has removed a rank!"] = "A guilda removeu um cargo!"
    GRM_L["{num} guild ranks have been removed!" ] = "{num} cargos da guilda foram removidos!"
    GRM_L["Edit Ban"] = "Editar Ban"
    GRM_L["Please Select a Player to Edit their Ban!"] = "Por Favor Selecione um Jogador para Editar o seu Ban!"
    GRM_L["Update Ban"] = "Atualizar Ban"
    GRM_L["{name}'s Ban Info has Been Updated!"] = "A informação de Ban de {name} Foi Atualizada!!"

    -- R1.1530
    GRM_L["{name} plays the {custom1} class, not {custom2}."] = "{name} joga a classe de {custom1}, não {custom2}."            -- Example: Arkaan plays the Hunter class, not Paladin.
    GRM_L["{num} Items Updated"] = "{num} Itens Atualizados"
    GRM_L["You Currently Have Disabled Adding Events to Calendar"] = "No momento, Você Desabilitou Adicionar Eventos ao Calendário"
    
    -- R1.20
    GRM_L["|CFFE6CC7FHold Shift|r to view more alt details."] = "|CFFE6CC7FSegure Shift|r para ver mais detalhes do alt."                -- "Hold Shift to view more alt details" is the phrase, but the |CFF|r is the text coloring hex code. Please keep it in there on the keyboard command coloring
    GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7FClique|r para ver mais detalhes do alt."
    GRM_L["{custom1} to keep alt details open."] = "{custom1} para manter detalhes do alt aberto."              -- The same can be said here. ^^
    GRM_L["|CFFE6CC7FClick|r to flip player name ordering"] = "|CFFE6CC7FClique|r para girar a ordem de nomes de player"                  -- and the reset...
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Newest"] = "|CFFE6CC7FClique|r para ordenar Datas de Entrada pela mais nova"
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Oldest"] = "|CFFE6CC7FClique|r para ordenar Datas de Entrada pela mais antiga"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Newest"] = "|CFFE6CC7FClique|r para ordenar Datas de Promoção pela mais Nova"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Oldest"] = "|CFFE6CC7FClique|r para ordenar Datas de Promoção pela mais Antiga"
    GRM_L["|CFFE6CC7FClick|r to sort all Mains first"] = "|CFFE6CC7FClique|r para ordenar todos os Mains primeiro"
    GRM_L["|CFFE6CC7FClick|r to sort all Alts first."] = "|CFFE6CC7FClique|r para ordenar todos os Alts primeiro"
    GRM_L["{name}'s Alts"] = "Alts de {name}"                                   -- Like "Arkaan's Alts"
    GRM_L["GRM window will open when combat ends."] = "Janela do GRM vai abrir quando sair de combate."

    -- R1.24
    GRM_L["This also will change the <Alt> format to match"] = true
    GRM_L["M"] = true                                           -- Of note, the "M" is short for "Main" and this is the reference to the main tag on alts in guild chat. For use in the Main tagging <M> (M) etc...
    GRM_L["A"] = true           

    -- R1.25
    GRM_L["Include \"Joined:\" tag with the date."] = true                                          -- the \" is so you include the qutoations in the actual text. You need them or it closes the phrase.
    GRM_L["GRM Auto-Detect! {name} has joined the guild and will be set as Main"] = "Auto-Detecção do GRM! {name} entrou na guilda e vai ser setado como Main"            -- Main auto-detect message

    -- R1.26
    GRM_L["Click to Disable Sync of Custom Note"] = "Clique para Desabilitar Sincronia da Nota Customizada"
    GRM_L["Click to Enable Sync of Custom Note"] = "Clique para Habilitar Sincronia da Nota Customizada"
	
    -- R1.27
    GRM_L["Show Border on Public, Officer, and Custom Notes"] = "Mostrar Borda em Notas Públicas, Oficiais e Customizadas"

    -- R1.28
    GRM_L["Public Note:"] = "Nota Pública:"
    GRM_L["Officer Note:"] = "Nota Oficial:"
    GRM_L["Officer Note"] = "Nota Oficial"
    GRM_L["Show Public, Officer, and Custom Notes on Log Entries of Left Players"] = true
    GRM_L["Hard Reset"] = "Reset Total"
    GRM_L["Hard reset of ALL GRM data, account-wide. Game will reload!"] = "Reset total de TODOS os dados do GRM. O jogo será recarregado!"
    GRM_L["Only recommend to kick if all player linked alts exceed max time"] = "Apenas recomendar expulsar se todos os alts vinculados do jogador excederem o tempo máximo"
    GRM_L["Your Guild Leader Has Set Sync Restrictions to {name} or Higher"] = "Seu Líder da Guilda Setou as Restrições de Sincronia para {name} ou Maior"
    GRM_L["Unable to Change Rank. Guild Leader has set restriction to {name} or higher"] = "Não foi possível Mudar o Cargo. Líder da Guilda setou a restrição para {name} ou maior"     -- Like Initiate or higher
    GRM_L["Unable to Change Rank. Guild Leader has set restriction level."] = "Não foi possível Mudar o Cargo. Líder da Guilda setou um nível de restrição"
    GRM_L["Force Settings with Guild Info Tags"] = "Forçar Configurações com Tags de Informações da Guilda"
    GRM_L["Database Still Loading. GRM will open automatically when finished."] = "Banco de Dados ainda Carregando. GRM vai abrir automaticamente quando terminar."

    -- R1.29
    GRM_L["The highlighted character is not valid for messages. Please remove."] = "O caractér destacado não é válido para mensagens. Por Favor remova."
    GRM_L["Not all characters are valid. Please remove any non-text characters."] = "Nem todos os caractéres são válidos. Por Favor remova quaisquer caractéres que não sejam de texto."
    GRM_L["Kick macro created. Press \"CTRL-SHIFT-K\" to kick all of {name}'s alts"] = "Macro de Expulsar criada. Pressione \"CTRL-SHIFT-K\" para expulsar todos os alts de {name}"
    GRM_L["Kick the Player's {num} alts too?"] = "Expulsar os {num} alts do Jogador também?"       -- Plural
    GRM_L["Kick the Player's {num} alt too?"] = "Expulsar o {num} alt do Jogador também?"       -- Not Plural  - "Kick the Player's 1 alt too?"
    GRM_L["Ban and Kick the Player's {num} alts too?"] = "Banir e Expulsar os {num} alts do Jogador também?"
    GRM_L["Ban and Kick the Player's {num} alt too?"] = "Banir e Expulsar o {num} alt do Jogador também?"

    -- R1.30
    GRM_L["Sync With {name} is Complete..."] = "Sincronização Com {name} está Completa..."
    GRM_L["|CFFE6CC7FLeft-Click|r and drag to move this button."] = "|CFFE6CC7FClique com o Esquerdo|r e arraste para mover esse botão."
    GRM_L["|CFFE6CC7FCtrl-Left-Click|r and drag to move this button anywhere."] = "|CFFE6CC7FCtrl-Left-Clique|r e arraste para mover esse botão pra qualquer lugar."
    GRM_L["MOTD:"] = true       -- Message Of The Day = M.O.T.D = MOTD - 
    GRM_L["minimap"] = "minimapa"

    -- R1.31
    GRM_L["Show 'Main' Tag on both Mains and Alts in Chat"] = "Mostrar Tag 'Main' em ambos Mains e Alts no Chat"

    -- R1.32
    GRM_L["GRM has moved the Guild Leader setting restriction codes to the Guild Info tab."] = "O GRM moveu os códigos de restrição de configuração do Líder da Guilda para a aba de Informações da Guilda."
    GRM_L["Please make room for them and re-add."] = "Por favor, abra espaço para mais e adicione novamente."
    GRM_L["Your Guild Leader Has Set BAN Sync Restrictions to {name} or Higher"] = "Seu Líder da Guilda Setou Restrições de Sincronia de BAN para {name} ou Maior"
    GRM_L["Your Guild Leader Has Set CUSTOM NOTE Sync Restrictions to {name} or Higher"] = "Seu Líder da Guilda Setou Restrições de Sincronia de NOTAS CUSTOMIZADAS para {name} ou Maior"

    -- R1.33
    GRM_L["Macro will auto-remove after {num} seconds."] = "Macro vai se auto-remover depois de {num} segundos."
    GRM_L["UI Controls"] = "Controles da UI"
    GRM_L["UI Configuration:"] = "Configuração da UI"
    GRM_L["Show Character Guild Reputation"] = "Mostrar Reputação do Personagem na Guilda"
    GRM_L["Show Guild Member Birthdays"] = "Mostrar Aniversários dos Membros da Guilda"
    GRM_L["Set Birthday"] = "Setar Aniversário"
    GRM_L["Edit Birthday"] = "Editar Aniversário"
    GRM_L["Remove Date"] = "Remover Data"            -- Clear Birthday shorthand
    GRM_L["Birthday"] = "Aniversário"
    GRM_L["Only Announce Birthdays and Anniversaries if Listed as 'Main'"] = "Somente Anunciar Aniversários se Listado como 'Main'"
    GRM_L["{name} will be celebrating {num} year in the Guild!"] = "{name} vai estar celebrando {num} ano de Guilda!"           -- {custom1} will reference the DATE. Ex: "Arkaan will be celebrating 1 year in the Guild! ( 1 May )" - SINGULAR
    GRM_L["{name} will be celebrating {num} years in the Guild!"] = "{name} vai estar celebrando {num} anos de Guilda!"             -- Same thing but PLURAL - "years" in stead of "year"
    GRM_L["No player's currently available to sync {name}'s Guild Data..."] = "Nenhum jogador disponível no momento para sincronizar os Dados de Guilda de {name}..."
    GRM_L["{name} has set {name2}'s Birthday: {custom1}"] = "{name} setou o Aniversário de {name2}: {custom1}"                  -- custom note is the date like "12 Dec"
    GRM_L["{name}'s Birthday has been set: {custom1}"] = "O Aniversário de {name} foi setado: {custom1}"
    GRM_L["Sync Birthdays"] = "Sincronizar Aniversários"

    -- R1.34
    GRM_L["Debugging Enabled"] = "Depurador Habilitado"
    GRM_L["Debugging Disabled"] = "Depurador Desabilitado"
    GRM_L["{num} is not a valid day of the month! It must be a number between 1 and 31"] = "{num} não é um dia válido do mês! Deve ser um número entre 1 e 31"
    GRM_L["{num} is not a valid index of the month of the year! It must be a number between 1 and 12"] = "{num} não é um índice válido do mês do ano! Deve ser um número entre 1 e 12"
    GRM_L["The day cannot be {num}. It must be a number between 1 and 31"] = "O dia não pode ser {num}. Deve ser um número entre 1 e 31"
    GRM_L["The month cannont be {num}. must be a number between 1 and 12"] = "O mês não pode ser {num}. Deve ser um número entre 1 e 12"
    GRM_L["{num} birthdays have been reset."] = "{num} aniversários foram resetados."
    GRM_L["No player was found to have that birthday."] = "Nenhum jogador com esse aniversário foi encontrado."

    -- R1.35
    GRM_L["Your Guild Leader Has Set Join Dates to only be added to the {name}"] = "Seu Líder da Guilda Setou Datas de Entrada para serem adicionadas apenas a {nome}"        -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...
    GRM_L["Warning - Global Controls:"] = "Aviso - Controles Globais:"
    GRM_L["Sync Restrictions Globally Changed to {name} or Higher"] = "Restrições de Sincronia foram Mudadas Globalmente para {name} ou Maior"
    GRM_L["BAN Sync Restrictions Globally Changed to {name} or Higher"] = "Restrições de Sincronia de BAN foram Mudadas Globalmente para {name} ou Maior"
    GRM_L["CUSTOM NOTE Sync Restrictions Globally Changed to {name} or Higher"] = "Restrições de Sincronia de NOTAS CUSTOMIZADAS foram Mudadas Globalmente para {name} ou Maior"
    GRM_L["Join Dates Globally Changed to only be added to the {name}"] = "Datas de Entrada foram Mudadas Globalmente para somente serem adicionadas a {name} ou Maior"
    GRM_L["Unable to Modify. Global setting is set to the {name}"] = "Não foi Possível Modificar. Configuração Global está setada para {name}"                           -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...
    
    -- R1.37
    GRM_L["No Action Configured"] = "Nenhuma Ação Configurada"
    GRM_L["OLD LOG"] = "VELHO REGISTRO"
    GRM_L["CHANGES"] = "MUDANÇAS"
    GRM_L["Sync has failed to start. Please try again!"] = "Sincronia falhou ao iniciar. Por Favor tente de novo!"
    GRM_L["Please wait {num} more seconds before manually initiating the sync process again."] = "Por Favor espere mais {num} segundos antes de iniciar manualmente o processo de sincronia de novo."

    -- R1.39
    GRM_L["Only Report if there are no Active Alts in the Group"] = "Relatar Apenas se não houver Alts Ativos no Grupo"
    GRM_L["Level Filter Minimum:"] = "Nível mínimo do filtro:"                                -- As in player level
    GRM_L["Report Milestones:"] = "Relatar Marcos Históricos"
    GRM_L["Report Level Up Changes"] = "Relatar Alterações de Nível"
    GRM_L["Reporting:"] = "Relatando:"
    GRM_L["Unable to disable level cap tracking. Please disable ALL tracking to turn off."] = "Não foi possível desativar o rastreamento de limite de nível. Por Favor Desative TODO o rastreamento para desativar."
    GRM_L["No Levels to Report to Log"] = "Não há Níveis pra Relatar para o Log"
    GRM_L["{name} has Surpassed their Level {num} Milestone and is Now {custom1}"] = "{name} Ultrapassou seu Nível {num} de Marco Histórico e Agora é {custom1}"
    GRM_L["{name} has Reached their Level {num} Milestone"] = "{name} Alcançou seu Nível {num} de Marco Histórico"
    GRM_L["{name}'s Ban has been Updated by {name2}!"] = "O Ban de {name} foi Atualizado por {name2}!"
    GRM_L["{name} has Updated {name2}'s BAN and also BANNED all linked alts from the guild!"] = "{name} Atualizou o BAN de {name2} e também BANIU todos os alts vinculados da guilda!"
    GRM_L["One moment, GRM is still being configured."] = "Um momento, o GRM ainda está sendo configurado."
    GRM_L["Press ENTER to complete"] = "Pressione ENTER para completar"
    GRM_L["Player Was Banned By: {name}"] = "Jogador Foi Banido Por: {name}"
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED players are currently in the guild."] = "|cffff0000AVISO!!!|r {num} jogadores BANIDOS estão atualmente na guilda."     -- plural
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED player is currently in the guild."] = "|cffff0000AVISO!!!|r {num} jogador BANIDO esta atualmente na guilda."       -- Singular  -- please keep the color coding... this keeps the Warning in red
    
    -- R1.41
    GRM_L["{num} metadata profiles are being built for people previously in the guild. The data is being requested, but this may take some time."] = "{num} perfis de metadados estão sendo criados para pessoas previamente na guilda. Os dados estão sendo solicitados, mas isso pode levar algum tempo."                 -- PLURAL
    GRM_L["One metadata profile is being built for a player previously in the guild. The data is being requested, but this may take some time."] = "{num} perfil de metadados esta sendo criado para um jogador previamente na guilda. Os dados estão sendo solicitados, mas isso pode levar algum tempo."           -- SINGULAR, same line.
    GRM_L["Auto-Focus the search box"] = "Auto-Focar a caixa de pesquisa"
    GRM_L["This will skip the first time if set to load on logon"] = "Isso pulará a primeira vez se definido para carregar ao entrar"  -- Referring to the auto-focusing on the search box, this is a tooltip helper
    GRM_L["Please enter a valid level between 1 and {num}"] = "Por Favor entre com um nível válido entre 1 e {num}"
    GRM_L["Player's Main: {name}"] = "Main do Jogador: {name}"

    -- R1.43
    GRM_L["One moment, requesting additional details on {name} from the server. Ban List will soon update."] = "Um momento, solicitando detalhes adicionais sobre {name} no servidor. A Lista de Ban será atualizada em breve."
    GRM_L["Unable to identify {name}. Ensure your spelling is accurate! Otherwise, they may have left the server."] = "Não Foi Possível Identificar {name}. Verifique se a ortografia está correta! Caso contrário, ele podem ter saído do servidor."
    GRM_L["(Unable to Identify)"] = "(Não Foi Possível Identificar)"                                                                    -- As in, unable to identify on the server, they possibly server transferred off but are still on ban list
    GRM_L["|CFFE6CC7FClick|r to select player class"] = "|CFFE6CC7FClique|r para selecionar a classe do jogador"
    GRM_L["|CFFE6CC7FClick|r to select player's realm."] = "|CFFE6CC7FClique|r para selecionar o reino do jogador."
    GRM_L["All Connected Realms are available to choose."] = "Todos os Reinos Conectados estão disponíveis para escolha."
    GRM_L["{num} players were found to have the same name. Please manually select which connected realm the player you wish to ban is on."] = "{num} jogadores foram achados com o mesmo nome. Selecione manualmente em qual reino conectado o jogador que você deseja banir está."
    GRM_L["Click or Press TAB to cycle through each step."] = "Clique ou Pressione TAB para percorrer cada etapa."
    GRM_L["Former and Current Members"] = "Membros Antigos e Atuais"
    GRM_L["No Matches Found. Add a Custom New Player or Match"] = "Nenhuma correspondência encontrada. Adicione um Novo Jogador Personalizado ou Correspondência"       -- as in, autocomplete typing matching
    
    --1.50
    GRM_L["{name}'s alt grouping has had their Birthday removed by: {name2}"] = "O agrupamento de alts de {name} teve seu Aniversário removido por: {name2}"
    GRM_L["{name}'s Birthday has been removed by: {name2}"] = "O Aniversário de {name} foi removido por: {name2}"
    GRM_L["Click to Sort"] = "Clique para Classificar"
    GRM_L["No Updates"] = "Sem Atualizações"
    GRM_L["Timestamp Formatting has been Globally Set to: < {name} >"] = "A Formatação de Data/Hora foi setada Globalmente para: <{name}>"
    GRM_L["Your Guild Leader Has Globally Set the Timestamp Formatting to: < {name} >"] = "Seu Líder da Guilda Setou Globalmente o Formato Data/Hora para: < {name} >"
    GRM_L["Unable to Modify. Global setting is set to :   {name}"] = "Não Foi Possível Modificar. Configuração Global está setada para :   {name}"

    -- If ppossible, try to maintain the allignment of the numbers, but only if it makes sense.
    GRM_L["{num}{custom1}: Join Dates"] = "{num}{custom1}: Datas de Entrada"
    GRM_L["{num}{custom1}: Promo Dates"] = "{num}{custom1}: Datas de Promoção"
    GRM_L["{num}{custom1}: Alts"] = true
    GRM_L["{num}{custom1}: Main Tags"] = "{num}{custom1}: Tags de Main"
    GRM_L["{num}{custom1}: Custom Notes"] = "{num}{custom1}: Notas Customizadas"
    GRM_L["{num}{custom1}: Birthdays"] = "{num}{custom1}: Aniversários"
    
    -- 1.52
    GRM_L["Times in Guild: {num}"] = "Vezes na Guilda: {num}"
    
    -- 1.56
    -- More slash commands
    GRM_L["kick"] = "expulsar"
    GRM_L["ban"] = true
    GRM_L["audit"] = true
    GRM_L["log" ] = "registro"
    GRM_L["event"] = "evento"
    GRM_L["events"] = "eventos"
    GRM_L["users"] = "usuários"
    GRM_L["syncusers"] = "sincusuários"
    GRM_L["opt"] = "opc"
    GRM_L["option"] = "opção"
    GRM_L["options"] = "opções"

    GRM_L["GRM Date"] = "Data do GRM"
    GRM_L["Note Date"] = "Data da Nota"
    GRM_L["Status"] = true
    GRM_L["Refresh"] = "Renovar"
    GRM_L["Clear Selection"] = "Limpar Seleção"
    GRM_L["Fix all mismatched note dates with GRM saved date"] = "Corrijir todas as datas de notas incompatíveis com a data salva do GRM"
    GRM_L["Fix selected mismatched note dates with GRM saved date"] = "Corrijir as datas de notas selecionadas incompatíveis com a data salva do GRM"
    GRM_L["Fix all mismatched GRM dates with the note date"] = "Corrijir todas as datas do GRM incompatíveis com a data da nota"
    GRM_L["Fix selected mismatched GRM dates with the note date"] = "Corrijir as datas selecionadas do GRM incompatíveis com a data da nota"
    GRM_L["Import all missing join dates from the note date"] = "Importar todas as datas de entrada que faltam da data da nota"
    GRM_L["Import selected missing join dates from the note date"] = "Importar datas de entrada selecionadas que faltam da data da nota"
    GRM_L["Add all missing saved dates to the {name}"] = "Adicionar todas as datas salvas que faltam á {nome}"
    GRM_L["Add selected missing saved dates to {name}"] = "Adicionar as datas selecionadas salvas que faltam á {nome}"
    GRM_L["Clear all join dates from incorrect note locations"] = "Limpar todas as datas de entrada dos locais incorretos nas notas"
    GRM_L["Clear selected join dates from incorrect note locations"] = "Limpar datas de entrada selecionadas dos locais incorretos nas notas"
    GRM_L["Not Found"] = "Não Encontrado"
    GRM_L["Not Set"] = "Não Setado"
    GRM_L["Complete"] = "Completo"
    GRM_L["Multiple"] = "Múltiplo"
    GRM_L["Location"] = "Localização"

    -- JD tool button actions and tooltips
    GRM_L["|CFFE6CC7FShift-Click|r Second Button to Select All In-Between"] = "| CFFE6CC7FShift-Clique | r o Segundo Botão para Selecionar Todos os Itens Intermediários"
    GRM_L["|CFFE6CC7FClick|r to select player"] = "|CFFE6CC7FClique|r para selecionar jogador"
    GRM_L["Only Show Players With Incomplete Status"] = "Somente Mostrar Jogadores Com Status Incompleto"
    GRM_L["{num} Join Dates Need Attention"] = "{num} Datas de Entrada Precisam de Atenção"            -- In other words, "155 join dates need attention" as an example
    GRM_L["Do you really want to remove the join dates from notes other than the {name}?"] = "Deseja mesmo remover as datas de entrada de outras notas que não sejam {nome}?"
    GRM_L["Do you really want to fix mismatched dates using the note?"] = "Deseja mesmo corrigir datas incompatíveis usando a nota?"
    GRM_L["Do you really want to fix note dates using the saved GRM dates?"] = "Deseja mesmo corrigir datas de nota usando as datas salvas no GRM?"
    GRM_L["Do you really want to add the missing join dates to the {name}?"] = "Deseja mesmo adicionar as datas de entrada que faltam para {name}?"                    -- add the missing join dates to the default note name - like "... to the Officer Note?"
    GRM_L["Auto-adding join dates to the {name} is disabled. Do you still wish to continue?"] = "Auto-adicionar datas de entrada para {name} está desabilitado. Deseja continuar?"    -- Just as above
    GRM_L["There are currently {num} mismatched dates to fix"] = "No momento, há {num} datas incompatíveis para corrigir"
    GRM_L["There are currently no mismatched dates that need to be fixed."] = "No momento, não há datas incompatíveis para corrigir."
    GRM_L["There are currently no dates that need to be imported."] = "No momento, não há datas para importar."
    GRM_L["There are currently no dates that can be added to the default note."] = "No momento, não há datas para adicionar a nota padrão."
    GRM_L["There are currently no dates that need to be removed from incorrect notes"] = "No momento, não há datas para remover de notas incorretas"
    GRM_L["There are currently {num} players who have join dates listed in the incorrect note"] = "No momento, há {num} jogadores com data de entrada listada na nota incorreta"
    GRM_L["Warning! Your function is extremely limited without officer permissions"] = "Aviso! Sua função é extremamente limitada sem permissões de oficial"
    GRM_L["Advanced Join Date Tool" ] = "Ferramenta de Data de Entrada Avançada"

    -- JD tool reasons
    GRM_L["Mismatched dates"] = "Datas Incompatíveis"
    GRM_L["Matching date found in wrong note location"] = "Data Compatível achada em local errado da nota"
    GRM_L["Date not added to note"] = "Data não adicionada a nota"
    GRM_L["Mismatched date found in multiple locations, including correct"] = "Data Incompatível achada em locais múltiplos, inclusive o certo"
    GRM_L["Mismatched date found in multiple incorrect note locations"] = "Data Incompatível achada em múltiplos locais incorretos de nota"
    GRM_L["Matching date found in multiple incorrect note locations"] = "Data Compatível achada em múltiplos locais errados da nota"
    GRM_L["Matching date found in multiple locations, including correct"] = "Data Compatível achada em locais múltiplos, inclusive o certo"
    GRM_L["Date found in incorrect note, but not yet imported"] = "Data encontrada em nota errada, mas ainda não importada"
    GRM_L["Date found in multiple incorrect notes, but not yet imported"] = "Data encontrada em múltiplas notas erradas, mas ainda não importada"
    GRM_L["Date found in multiple locations, including correct, but not yet imported"] = "Data encontrada em múltiplos locais, inclusive o certo, mas ainda não importada"
    GRM_L["Date found in correct note location, but not yet imported"] = "Data encontrada em local correto da nota, mas ainda não importada"

    -- More misc.
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been set to be added to join date note entries."] = "As tags \"{name}\" e \"{name2}\" foram setadas globalmente para serem adicionadas aos registros de dia de entrada da nota."
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been disabled from adding to join date note entries."] = "As tags \"{name}\" e \"{name2}\" foram desabilitadas globalmente de serem adicionadas aos registros de dia de entrada da nota."
    GRM_L["Your rank has changed. Re-evaluating sync permissions."] = "Seu cargo foi alterado. Reavaliando permissões de sincronização."
    
    -- 1.57
    GRM_L["Full Log Message:"] = "Mensagem de Log Completa:"
    GRM_L["Log Entry Tooltip"] = true
    GRM_L["1 entry has been removed from the log"] = "1 entrada foi removida do registro"
    GRM_L["{num} entries have been removed from the log"] = "{num} entradaa foram removidas do registro"
    
    -- 1.58
    GRM_L["|CFFE6CC7FCtrl-Click|r to open the Old Guild Roster Window"] = "|CFFE6CC7FCtrl-Clique|r para abrir a Janela Antiga de Lista da Guilda"
    
    -- 1.59
    GRM_L["Adding the Join Date cannot be disabled due to the global setting"] = "Adicionar a Data de Entrada não pode ser desativada devido à configuração global"
    GRM_L["Due to your current rank, you will be unable to add Join Date Timestamps"] = "Devido à seu cargo atual, você não poderá adicionar Data/Hora do Dia de Entrada"
    GRM_L["Warning! Due to your rank you will be unable to add Join Date timestamps to the {name}"] = "Aviso! Devido à seu cargo atual, você não poderá adicionar Datas/Horas do Dia de Entrada para {name}"
    GRM_L["Unable to Modify Format:  {name}"] = "Não foi Possível Modificar o Formato: {name}"
    GRM_L["Show Mouseover"] = "Mostrar Mouseover"
    GRM_L["Unable to create GRM hotkey macro. You currently are at the cap of {num} macros."] = "Não foi possível criar a macro de teclas de atalho do GRM. No momento, você está no limite de {num} macros."
    
    -- 1.60
    GRM_L["Really remove {name} Backup Point?"] = "Deseja mesmo remover o Ponto de Backup de {name}?"      -- The {name} is the guildName
    
    -- 1.63
    GRM_L["Disabled"] = "Desabilitado"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays January to December"] = "|CFFE6CC7FClique|r para ordenar os Aniversários de Janeiro para Dezembro"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays December to January"] = "|CFFE6CC7FClique|r para ordenar os Aniversários de Dezembro para Janeiro"
    
    -- 1.64
    GRM_L["Chat Window for All GRM Messages:"] = "Janela de Chat para TODAS as Mensagens do GRM:"
    GRM_L["\"{name}\" Chat Window\nDo you wish to create it?" ] = "Janela de Chat \"{name}\"\nDeseja criá-la?"              -- the \n indicates a line break.
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you close this one."] = "O GRM enviará automaticamente mensagens para a janela \"{name}\" se você fechar esta."
    GRM_L["Channel Settings Are Character Specific and Will Not Be Sync'd"] = "As configurações de Canal São Específicas de Personagens e Não Serão Sincronizadas "
    
    -- 1.66
    GRM_L["Custom Join Tag:"] = "Tag de Entrada Custom:"
    GRM_L["Custom Rejoin Tag:"] = "Tag de Retorno Custom:"
        -- Join Tag
    GRM_L["Custom Join Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "A Tag Customizada de Data de Entrada \"{nome}\" não pode ser setada, pois possui {num} caractéres. O máximo é {custom1}."
    GRM_L["Custom Join Tag has been changed from \"{name}\" to \"{name2}\""] = "A Tag Customizada de Entrada foi mudada de \"{name}\" para \"{name2}\""
    GRM_L["Custom Join Tag has been set to \"{name}\""] = "A Tag Customizada de Entrada foi setada para \"{name}\""
    GRM_L["Your Guild Leader has changed the Custom Join Tag from \"{name}\" to \"{name2}\""] = "Seu Líder da Guilda mudou A Tag Customizada de Entrada de \"{name}\" para \"{name2}\""
    GRM_L["Your Guild Leader has set the Custom Join Tag to \"{name}\""] = "Seu Líder da Guilda setou A Tag Customizada de Entrada para \"{name}\""
        -- Rejoin Tag
    GRM_L["Custom Rejoin Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "A Tag Customizada de Data de Retorno \"{nome}\" não pode ser setada, pois possui {num} caractéres. O máximo é {custom1}."
    GRM_L["Custom Rejoin Tag has been changed from \"{name}\" to \"{name2}\""] = "A Tag Customizada de Retorno foi mudada de \"{name}\" para \"{name2}\""
    GRM_L["Custom Rejoin Tag has been set to \"{name}\""] = "A Tag Customizada de Retorno foi setada para \"{name}\""
    GRM_L["Your Guild Leader has changed the Custom Rejoin Tag from \"{name}\" to \"{name2}\""] = "Seu Líder da Guilda mudou A Tag Customizada de Retorno de \"{name}\" para \"{name2}\""
    GRM_L["Your Guild Leader has set the Custom Rejoin Tag to \"{name}\""] = "Seu Líder da Guilda setou A Tag Customizada de Retorno para \"{name}\""
    
     -- 1.67
    -- Note, lots of plural/singular forms here for just a superior user experience, albeit a bit of extra work
    GRM_L["Kick"] = "Expulsar"
    GRM_L["Promote"] = "Promover"
    GRM_L["Demote"] = "Rebaixar"
    GRM_L["Macro:"] = true
    GRM_L["Macro Size: {num}/255"] = "Tamanho da Macro: {num}/255"        -- "Macro Size: 242/255"
    GRM_L["Action"] = "Ação"
    GRM_L["Ignored Action:"] = "Ação Ignorada:"                -- As in, the action being ignored, be it kick or promote or demote. 
    GRM_L["Click to Build Macro"] = "Clique para Criar a Macro"
    GRM_L["No Current Names to Add"] = "Nenhum Nome para Adicionar"
    GRM_L["No Names to Add to the Macro"] = "Nenhum Nome para Adicionar a Macro"
    GRM_L["Hot Key: {name}"] = "Tecla de Atalho: {name}"
    GRM_L["Permissions"] = "Permissões"
    GRM_L["Player rank change detected, re-checking permissions and rebuilding GRM Macro Tool."] = "Mudança de Cargo de Jogador detectada, verificando novamente as permissões e reconstruindo a Ferramenta de Macro do GRM."
    GRM_L["Click to remove selected names from the macro"] = "Clique para remover os nomes selecionados da macro"          -- Plural form of statement
    GRM_L["Click to remove selected name from the macro"] = "Clique para remover o nome selecionado da macro"           -- Singular form of statement
    GRM_L["Click to remove selected names from Ignore List"] = "Clique para remover os nomes selecionados da Lista de Ignore"        -- Plural
    GRM_L["Click to remove selected name from Ignore List"] = "Clique para remover o nome selecionado da Lista de Ignore"          -- Singular
    GRM_L["No names selected to remove from macro"] = "Nenhum nome selecionado para remover da macro"
    GRM_L["No names selected to remove from Ignore List"] = "Nenhum nome selecionado para remover da Lista de Ignore"
    GRM_L["Macro is currently empty"] = "No momento, a Macro está vazia."
    GRM_L["{num} players removed from the macro"] = "{num} jogadores removidos da macro"                   -- plural form of the statement
    GRM_L["{num} player was removed from the macro"] = "{num} jogador removido da macro"                 -- singular form of the statement
    GRM_L["{num} players removed from the Ignored List"] = "{num} jogadores removidos da Lista de Ignore"
    GRM_L["{num} player was removed from Ignore List"] = "{num} jogador removido da Lista de Ignore"
    GRM_L["There are no names currently selected to be removed from the Ignore List."] = "No momento, não há nomes selecionados para serem removidos da Lista de Ignore."
    GRM_L["There are no names currently selected to be removed from the macro."] = "No momento, não há nomes selecionados para serem removidos da macro."
    GRM_L["The macro is not yet built. Please click the button to create the macro."] = "A macro ainda não foi criada. Clique no botão para criar a macro."
    GRM_L["Nothing to clear"] = "Nada para limpar"
    GRM_L["There are currently no names to add"] = "No momento, não há nomes para adicionar"
    GRM_L["There are currently no names to remove"] = "No momento, não há nomes para remover"
    GRM_L["Rules"] = "Regras"
    GRM_L["Please choose a day between 1 and 99"] = "Por Favor selecione um dia entre 1 e 99"
    GRM_L["Please choose a day between 0 and 99"] = "Por Favor selecione um dia entre 0 e 99"
    GRM_L["Pressing the ESC key will also clear all lines"] = "Pressionar ESC também vai limpar todas as linhas"
    GRM_L["Player's rank does not have permission to remove others from the guild"] = "O Cargo do Jogador não tem permissão de remover os outros da guilda"
    GRM_L["Player's rank does not have permission to promote others in the guild"] = "O Cargo do Jogador não tem permissão de promover os outros na guilda"
    GRM_L["Player's rank does not have permission to demote others in the guild"] = "O Cargo do Jogador não tem permissão de rebaixar os outros na guilda"
    GRM_L["Queued Actions"] = "Ações na Fila"
    GRM_L["Current Actions"] = "Ações Atuais"
    GRM_L["View Ignore List"] = "Ver Lista de Ignore"
    GRM_L["No players are currently safe from recommendations"] = "Nenhum jogador está a salvo de recomendações"
    GRM_L["1 player is on the safe list."] = "1 jogador está na lista segura."
    GRM_L["{num} players are on the safe list."] = "{num} jogadores estão na lista segura."
    GRM_L["1 action is being ignored."] = "1 ação está sendo ignorada."
    GRM_L["{num} actions are being ignored."] = "{num} ações estão sendo ignoradas."
    GRM_L["No current actions are being ignored"] = "Nenhuma ação está sendo ignorada"
    GRM_L["Actions Ignored:"] = "Ações Ignoradas:"
    GRM_L["Total Queued:"] = "Total na Fila:"
    GRM_L["Ignored Players Safe From Action"] = "Jogadores Ignorados a Salvo Da Ação"
    GRM_L["Only show players with ignored action"] = "Mostrar apenas jogadores com ação de ignorar"
    GRM_L["No players on Ignore List"] = "Não há jogadores na Lista de Ignore"
    GRM_L["No players to select. 1 player filtered"] = "Nenhum jogador para selecionar. 1 jogador filtrado"                     -- Singular
    GRM_L["No players to select. {num} players filtered"] = "Nenhum jogador para selecionar. {num} jogadores filtrados"                -- Plural
    GRM_L["There are no names to select. 1 player is filtered"] = "Não há nomes para selecionar. 1 jogador está sendo filtrado"         -- these 2 statements might seem redundant, but often the text on a button is more short hand. This gives a cleaner statement in the chat. Useful for translating in some languages that need a bit more room to be more clear.
    GRM_L["There are no names to select. {num} players are filtered"] = "Não há nomes para selecionar. {num} jogadores estão sendo filtrados"
    GRM_L["Really remove selected player from the ignore list?"] = "Deseja mesmo remover o jogador selecionado da lista de ignore?"
    GRM_L["Really remove the {num} selected players from the ignore list?"] = "Deseja mesmo remover os {num} jogadores selecionados da lista de ignore?"
    GRM_L["Do you really wish to clear all players from the Ignore List?"] = "Deseja mesmo limpar todos os jogadores da Lista de Ignore?"
    GRM_L["There are currently no players on the Ignore List"] = "No momento, não há jogadores na Lista de Ignore"
    GRM_L["Remove all players from Ignore List"] = "Remover todos os jogadores da Lista de Ignore"
    GRM_L["Ignored Players: {num}"] = "Jogadores Ignorados: {num}"
    GRM_L["Tool"] = "Ferramenta"                                           -- /grm tool
    GRM_L["Macro Tool"] = "Ferramenta de Macro"
    GRM_L["Macro Tool: {num}"] = "Ferramenta de Macro: {num}"

    -- CLASSIC
    GRM_L["Social"] = true
    GRM_L["Roster"] = "Lista"
    GRM_L["Feature is disabled in WoW Classic"] = "Recurso desativado no WoW Clássico"
    GRM_L["Feature is disabled in TBC Classic"] = "Recurso desativado no TBC Clássico"          -- Just laying groundwork now in case Blizz ever releases it. Calendar was not added until WOTLK
    GRM_L["(Classic)"] = "(Clássico)"       -- tooltip tag that shows only on the minimap mosueover version tooltip in Classic
    
    -- 1.69
    GRM_L["Importing dates must be done in a compatible format"] = "Importar datas deve ser feito em um formato compatível"
    GRM_L["The date selection in OPTIONS shows all supported"] = "A seleção da data em OPÇÕES mostra todos as suportadas"
    GRM_L["Headers, like \"Joined,\" are supported"] = "Cabeçalhos, como \"Entrou\" são suportados"
    GRM_L["To confirm or edit the date, open the player window, right click the date, edit, and submit"] = "Para confirmar ou editar a data, abra a janela do jogador, clique com o direito na data, edite, e envie"        --The "!!" tags are the {name}
    GRM_L["To confirm or edit the date, right click the date, edit, and submit"] = "Para confirmar ou editar a data, clique com o direito na data, edite, e envie"    -- Slightly shorter explanation if already on player window
    GRM_L["The {name} tag indicates a date must be verified to sync"] = "A tag {name} indica que uma data deve ser verificada para sincronizar"
   
    -- 1.70
    GRM_L["GRM has errored due to a previous incompatible build with Classic that was enabled. Click YES to reload UI and fix the issue"] = "O GRM apresentou um erro devido a uma build incompatível anterior com o Clássico que foi habilitada. Clique em SIM para recarregar a UI e corrigir o problema"

    -- 1.71
    GRM_L["(Disabled in Classic)"] = "(Desabilitado no Clássico)"          -- For the Options... rather than removing them all
	
	-- 1.73
    GRM_L["{name} is no longer in the Guild!"] = "{name} não está mais na Guilda!"       -- There should really be 3 options. They got kicked, they left on their own, or if not found in the event log, they are just no longer in the guild
    GRM_L["is no longer in the Guild!"] = "não está mais na Guilda!"              -- THIS MUST MATCH THE PREVIOUS LINE with missing name.
    GRM_L["Applying update patches... one moment."] = "Aplicando patches de atualização... um momento."
    GRM_L["Update Complete... {num} patches applied."] = "Atualização Completa... {num} patches aplicados."  -- Plural
    GRM_L["Update Complete... 1 patch applied."] = "Atualização Completa... 1 patch aplicado."        -- Singular version
    GRM_L["Disabling will also hide the Birthday info on the roster mouseover window"] = "Desativar também ocultará as informações de Aniversário na janela de mouseover da lista"     -- Enable/disable birthday chekbox on UI Options and the Audit windoppw
    GRM_L["To avoid addon taint/blocking errors in Classic, the player must manually open the Guild Roster tab the first time."] = "Para evitar erros de contaminação/bloqueio do addon no Clássico, o jogador deve abrir manualmente a aba da Lista da Guilda pela primeira vez."          -- Classic only message for players explaining why window cannot open automatically.
    GRM_L["Confirm Date"] = "Confirmar Data"
    GRM_L["If the date is accurate, right click and select 'Confirm Date'"] = "Se a data estiver precisa, clique com o direito e selecione 'Confirmar Data'"

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
	GRM_L["|CFFE6CC7FClick|r to view more alt details."] = true                         -- Calendar tooltip
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
    GRM_L["There are currently {num} dates that can be added to the {name}"] =  "No momento, há {num} datas para adicionar a {name}."
    GRM_L["The previous action still has 1 recommended task. It is advised to do that first."] = true               -- Singular
    GRM_L["The previous action still has {num} recommended tasks. It is advised to do those first."] = true         -- Plural
    GRM_L["Step {num}"] = true
    
    -- 1.86
    GRM_L["What tags look like:"] = true
    GRM_L["Add Join Date to:"] = "Adicionar Data de Entrada para:"
    
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
    GRM_L["Does NOT apply to Ban List"] = "NÃO se aplica para Lista de Bans"
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
    GRM_L["Unable to promote players to this rank"] = true
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
    GRM_L["Click"] = "Clique"                   -- Referencing a mouse click
    GRM_L["Ctrl-Click"] = "Ctrl-Clique"              -- Ctrl = Control
    GRM_L["Alt-Click"] = true
    GRM_L["Shift-Click"] = true
    GRM_L["Ctrl-Shift-Click"] = true
    GRM_L["Alt-Shiift-Click"] = true
    GRM_L["Right-Click"] = "Clique com o Direito"
    
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
    GRM_L["{custom1} to open Player Window"] = "{custom1} para abrir a Janela do Jogador"
    GRM_L["{custom1} for Additional Options"] = "{custom1} para Opções Adicionais"

    --1.93
    GRM_L["Please Note: To permanently enable system messages, you must manually re-enable them in your chat window general settings"] = true
    GRM_L["Unable to notify yourself if you go offline."] = true
    GRM_L["{custom1} to sync join date among all alts in grouping."] = true
    GRM_L["Total Patch Time:"] = true
    GRM_L["Applying {num} patches."] = true
    GRM_L["Applying 1 patch."] = true
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
    GRM_L["Search"] = "Procurar" -- This is the global string for "Search"
    
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

end
