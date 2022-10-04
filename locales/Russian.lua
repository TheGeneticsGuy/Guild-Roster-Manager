
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

GRML.Russian = function()

    -- Auto Localized (Only use this on Client languages)
    GRM_L["Friend"] = FRIEND;

     -- SET YOUR OWN CUSTOM SLASH COMMAND FOR GRM
    GRM_L["/XXXX"] = "/грм"            -- /grm will always work, now you can make your own acronym that fits your language. Example: GRM_L["/XXXX"] = "/грм" - Now, if you type /грм it will work in-game

    GRM_L["German"] = "Немецкий"
	GRM_L["English"] = "Английский"
	GRM_L["French"] = "Французский"
	GRM_L["Italian"] = "Итальянский"
	GRM_L["Russian"] = "Русский"
	GRM_L["SpanishMX"] = "Испанский (Мексика)"
	GRM_L["SpanishEU"] = "Испанский (ЕС)"
    GRM_L["Portuguese"] = "Португальский (ЕС)"
    GRM_L["PortugueseBR"] = "Португальский (Бр)"
	GRM_L["Korean"] = "Корейский"
	GRM_L["MandarinCN"] = "Мандарин (Китай)"
    GRM_L["MandarinTW"] = "Мандарин (Тайвань)"
    GRM_L["Dutch"] = "Нидерландский"
    GRM_L["Danish"] = "Датский"

     -- PLAYER MAIN ROSTER DETAILS WINDOW
    GRM_L["Level: "] = "-го уровня"
    GRM_L["Level"] = "-го уровня"
    GRM_L["Note:"] = "Заметка:"
    GRM_L["Note"] = "Заметка"
    GRM_L["Officer's Note:"] = "Офицерская заметка:"
    GRM_L["Officer's Note"] = "Офицерская заметка"
    GRM_L["Zone:"] = "Зона:"
    GRM_L["(main)"] = "(Мейн)"
    GRM_L["( Main )"] = "( Мейн )"                    -- Context: This one is used on player data window, the other is smaller used in the alts list...
    GRM_L["Set as Main"] = "Выбрать как Мейна"
    GRM_L["Set as Alt"] = "Выбрать как твинка"
    GRM_L["Remove"] = "Удалить"
    GRM_L["Please Type the Name of the alt"] = "Введите имя твинка"
    GRM_L["Promoted:"] = "Повышен:"
    GRM_L["Unknown"] = "Неизвестно"                                                                 -- Context: The date of their promotion is "Unknown"
    GRM_L["Click here to set a Public Note"] = "Нажмите, для записи Публичной заметки"
    GRM_L["Unable to Edit Public Note at Rank"] = "Невозможно изменить публичную заметку для этого звания"
    GRM_L["Click here to set an Officer's Note"] = "Нажмите, для записи Офицерской заметки"
    GRM_L["Unable to Edit Officer Note at Rank"] = "Невозможно изменить офицерскую заметку для этого звания"
    GRM_L["Unable to View Officer Note at Rank"] = "Невозможно просмотреть офицерскую заметку для этого звания"
    GRM_L["Online"] = "Онлайн"
    GRM_L["( Active )"] = "Играет"                       -- I included the parentheses here as I am not sure if any languages abstain from them, or use other notation. Feel free to remove if necessary
    GRM_L["( AFK )"] = "АФК"
    GRM_L["( Busy )"] = "Занят"
    GRM_L["( Mobile )"] = "Мобильный"
    GRM_L["( Offline )"] = "Не в сети"
    GRM_L["Set Join Date"] = "Уст. дату"
    GRM_L["Edit Promo Date"] = "Редактировать дату"
    GRM_L["Edit Join Date"] = "Редактировать дату"
    GRM_L["Set Promo Date"] = "Уст. дату"
    GRM_L["No Invite"] = "Не пригласить :("
    GRM_L["Group Invite"] = "Пригласить в группу"
    GRM_L["Date Promoted?"] = "Дата повышения?"
    GRM_L["Last Online"] = "Посл. онлайн"
    GRM_L["Time In:"] = "Время в зоне:"            -- Context: "Time In" the current zone...
    GRM_L["Date Joined"] = "Дата вербовки"
    GRM_L["Join Date?"] = "Выберите дату"
    GRM_L["Player Was Previously Banned!"] = "Игрок уже забанен!"
    GRM_L["Ignore Ban"] = "Игнорировать бан"
    GRM_L["Player Alts"] = "Твинки игрока"
    GRM_L["Add Alt"] = "Добавить твинка"
    GRM_L["Choose Alt"] = "Выберите твинка"
    GRM_L["Guild Log"] = "Гильд. Журнал"
    GRM_L["Guild"] = "Гильдия"

     -- TOOLTIPS
    GRM_L["Rank History"] = "История званий" 
    GRM_L["Time at Rank:"] = "Время в звании:"
    GRM_L["Right-Click to Edit"] = "ПКМ для изменений"
    GRM_L["Left Guild"] = "Покинул гильдию"
    GRM_L["Membership History"] = "История членства"
    GRM_L["Joined:"] = "Присоединяется:"                             -- as in "Joined" the guild
    GRM_L["Joined"] = "Присоединяется"
    GRM_L["Left:"] = "Покинул:"                            	-- as in, "Left" the guild
    GRM_L["Rejoined:"] = "Вернулся:"                         -- as in, "Rejoined" the guild
    GRM_L["Rejoined"] = "Вернулся"
    GRM_L["Reset Data!"] = "Сбросить данные"
    GRM_L["Notify When Player is Active"] = "Уведомлять, когда игрок в игре"
    GRM_L["Notify When Player Goes Offline"] = "Уведомлять, когда игрок выходит из игры"
    GRM_L["Notify When Player Comes Online"] = "Уведомлять, когда игрок входит в игру"
    GRM_L["Edit Date"] = "Изменить дату"
    GRM_L["Clear History"] = "Очистить историю"
    GRM_L["Options"] = "Опции"
            
     -- LOG
    GRM_L["LOG"] = "Журнал"                -- Context - The guild Log shorthand for the tab
    GRM_L["Guild Roster Event Log"] = "Журнал событий"
    GRM_L["Clear Log"] = "Очистить журнал"
    GRM_L["Really Clear the Guild Log?"] = "Уверены, что хотите очистить журнал гильдии?"
    GRM_L["{name} KICKED {name2} from the Guild!"] = "{name} ИСКЛЮЧИЛ игрока {name2} из гильдии"
    GRM_L["kicked"] = "исключен"
    GRM_L["{name} has Left the guild"] = "{name} вышел из гильдии"
    GRM_L["{name} has BANNED {name2} and all linked alts from the guild!"] = "{name} ЗАБАНИЛ игрока {name2} и всех его твинков в гильдие"
    GRM_L["{name} has BANNED {name2} from the guild!"] = "{name} ЗАБАНИЛ игрока {name2} в гильдии"
    GRM_L["Reason Banned:"] = "Причина БАНа"
    GRM_L["has Left the guild"] = "покинул гильдию"       -- Context: PlayerName "has left the guild"
    GRM_L["ALTS IN GUILD:"] = "Твинков в гильдии:"    -- Context: This appears If a person leaves the guild and there are still alts in the guild. It is like - "ALTS IN GUILD: Arkaan, Chris, Matt, and 4 others.""
    GRM_L["Player no longer on Server"] = "Игрок больше не на сервере"
    GRM_L["{name} PROMOTED {name2} from {custom1} to {custom2}"] = "{name} ПОВЫСИЛ {name2} из {custom1} в {custom2}"
    GRM_L["{name} has been PROMOTED from {custom1} to {custom2}"] = "{name} был ПОВЫШЕН из {custom1} в {custom2}"
    GRM_L["{name} DEMOTED {name2} from {custom1} to {custom2}"] = "{name} РАЗЖАЛОВАЛ {name2} из {custom1} в {custom2}"
    GRM_L["{name} has been DEMOTED from {custom1} to {custom2}"] = "{name} был РАЗЖАЛОВАН из {custom1} в {custom2}"
    GRM_L["(+ {num} More)"] = "(и {num} других)"    -- Context: Referencing num of alts if player leaves guild, that are stil in it. Example "ALTS IN GUILD: Christ, Matt, Sarah (and 4 more)"
    GRM_L["{name} has Been in the Guild {num} Times Before"] = "{name} был в гильдии {num} назад"
    GRM_L["{name} is Returning for the First Time."] = "{name} Вернулся в первый раз."
    GRM_L["None Given"] = "Без причины "                                             -- Context: No reason given for player ban. This is displayed when a player was banned, but the addon users did not input a reason why.
    GRM_L["WARNING!"] = "ВНИМАНИЕ!"    -- Context: WARNING - banned player rejoined the guild!
    GRM_L["{name} REJOINED the guild but was previously BANNED!"] = "{name} ВЕРНУЛСЯ в гильдию, но ранее был ЗАБАНЕН!"
    GRM_L["(Invited by: {name})"] = "(Пригласил: {name})"
    GRM_L["Invited By: {name}"] = "Пригласил: {name}"
    GRM_L["Date of Ban:"] = "Дата БАНа:"
    GRM_L["Date Originally Joined:"] = "Дата первого вступления:"
    GRM_L["Old Guild Rank:"] = "Старое звание:"
    GRM_L["Additional Notes:"] = "Дополнительные заметки"
    GRM_L["{name} has REINVITED {name2} to the guild"] = "{name} был повторно приглашен игроком {name} в гильдию"
    GRM_L["(LVL: {num})"] = "(УРОВЕНЬ: {num})"     -- Context: LVL means Player Level - so Ex: (LVL: 110)
    GRM_L["{name} has REJOINED the guild"] = "{name} Вернулся в гильдию"
    GRM_L["{name} has JOINED the guild!"] = "{name} Присоединяется к гильдии"
    GRM_L["Date Left:"] = "Дата выхода:"
    GRM_L["{name} has Leveled to {num}"] = "{name} повысил уровень до {num}"
    GRM_L["(+{num} levels)"] = "(+{num} уровней)"                                        -- Context: Person gained more than one level, hence the plural
    GRM_L["(+{num} level)"] = "(+{num} уровень)"                                         -- Context: Person gains a level, just one level.
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Added"] = "ПУБЛИЧНАЯ заметка \"{custom1}\" игрока {name} добавлена"           -- Of note, the \" in the text here will just appear as " in-game. The \" notation is telling the program not to end the string, but to include quotation
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Removed"] = "ПУБЛИЧНАЯ заметка \"{custom1}\" игрока {name} удалена"
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" to \"{custom2}\""] = "ПУБЛИЧНАЯ заметка \"{custom1}\" игрока {name} изменена на \"{custom2}\""    -- Context: "Arkaan's PUBLIC Note: "ilvl 920" to "Beast Mode ilvl 960""  -- Changing of the note. custom1 = old note, custom2 = new note
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Added"] = "ОФИЦЕРСКАЯ заметка \"{custom1}\" игрока {name} добавлена"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Removed"] = "ОФИЦЕРСКАЯ заметка \"{custom1}\" игрока {name} удалена"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" to \"{custom2}\""] = "ОФИЦЕРСКАЯ заметка \"{custom1}\" игрока {name} изменена на \"{custom2}\""
    GRM_L["Guild Rank Renamed from {custom1} to {custom2}"] = "Гильдейское звание переименовано с {custom1} на {custom2}"
    GRM_L["{name} has Name-Changed to {name2}"] = "{name} переименовано на {name2}"
    GRM_L["{name} has Come ONLINE after being INACTIVE for {num}"] = "{name} ВЕРНУЛСЯ игру после ОТСУТСТВИЯ втечение {num}"
    GRM_L["{name} has been OFFLINE for {num}. Kick Recommended!"] = "{name} был ОФФЛАЙН в течении {num}. Рекомендуется исключить!"
    GRM_L["({num} ago)"] = "{num} спустя"    -- Context: (5 minutes ago) or (5 months 24 days ago) -- the {num} will automatically include the time-passed date.
    GRM_L["{name}'s Guild has Name-Changed to \"{name2}\""] = "Гильдия \"{name}\" изменила имя на \"{name2}\""
    GRM_L["Promotions"] = "Повышение"
    GRM_L["Demotions"] = "Разжалование"
	
     -- EVENTS WINDOW
    GRM_L["EVENTS"] = ("События")                                          -- Events tab
    GRM_L["{name}'s Anniversary!"] = ("{name}'s Юбилей!")
    GRM_L["{name}'s Birthday!"] = ("День рождения {name}!")
    GRM_L["Please Select Event to Add to Calendar"] = ("Выберите событие")
    GRM_L["No Calendar Events to Add"] = ("Нет добавленных событий")
    GRM_L["Event Calendar Manager"] = ("Настройка событий")
    GRM_L["Event:"] = ("Событие")
    GRM_L["Description:"] = ("Описание")
    GRM_L["Add to\nCalendar"] = ("Добавить в\nкалендарь ")
    GRM_L["Ignore Event"] = ("Игнор события")
    GRM_L["No Player Event Has Been Selected"] = ("Событие игрока не выбрано")
    GRM_L["Event Added to Calendar: {custom1}"] = ("Событие добавлено в календарь: {custom1}")            -- Custom1 = the title of the event, like "Arkaan's Anniversary"
    GRM_L["Please Select Event to Add to Calendar"] = ("Пожалуста выберите событие для добавление в календарь")
    GRM_L["No Calendar Events to Add"] = ("Нет событий для добавления")
    GRM_L["{name}'s event has already been added to the calendar!"] = ("Событие {name} уже добавлено в каленьдарь")
    GRM_L["Please wait {num} more seconds to Add Event to the Calendar!"] = ("Подождите {num} секунд, чтобы добавить событие в календарь")
    GRM_L["{name}'s Event Removed From the Queue!"] =("{name} событие удалено")
    GRM_L["Full Description:"] = ("Полное описание:")

    -- BAN WINDOW
    GRM_L["BAN LIST"] = "Бан лист"                                        -- Ban List Tab
    GRM_L["Reason Banned?"] = "Причина Бана?"
    GRM_L["Click \"YES\" When Done"] = "Нажмите \"ДА\" по окончании"     -- Of note, the \" is how you notate for quotations to actually appear. Adjust as needed
    GRM_L["Select a Player"] = "Выберите игрока"
    GRM_L["Player Selected"] = "Выбранный игрок"
    GRM_L["{name}(Still in Guild)"] = "{name}(еще в гильдии)"
    GRM_L["(Still in Guild)"] = "(еще в гильдии)"
    GRM_L["No Ban Reason Given"] = "Забанен без причины"
    GRM_L["Total Banned:"] = "Всего забанено:"
    GRM_L["Rank"] = "Звание"
    GRM_L["Ban Date"] = "Дата Бана"
    GRM_L["No Players Have Been Banned from Your Guild"] = "Нет забаненых игроков"
    GRM_L["Remove Ban"] = "Снять бан"
    GRM_L["Add Player to Ban List"] = "Выберите игрока в список банов"
    GRM_L["Server:"] = "Сервер:"
    GRM_L["Class:"] = "Класс:"
    GRM_L["Reason:"] = "Причина:"
    GRM_L["It is |CFFFF0000CRITICAL|r the player's name and server are spelled correctly for accurate tracking and notifications."] = "|CFFFF0000ВАЖНО|r ввести существующие имя и сервер для отслеживания и оповещения"
    GRM_L["Submit Ban"] = "Отправить бан"
    GRM_L["Confirm"] = "Подтвердить"
    GRM_L["Cancel"] = "Отмена"
    GRM_L["Add"] = "Добавить"            -- Context: "Add" player to ban list
    GRM_L["Confirm Ban for the Following Player?"] = "Подтвердить бан для следующего игрока?"
    GRM_L["Please Enter a Valid Player Name"] = "Введите действующее имя игрока"     -- Player Name
    GRM_L["Please Enter a Valid Server Name"] = "Введите действующий сервер игрока"    -- Server Name
    GRM_L["Please Select a Player to Unban!"] = "Выберите игрока для разбана!"
    GRM_L["{name} - Ban List"] = "{name} - БАН лист"       -- Context: "GuildName - Ban List"
    GRM_L["No Reason Given"] = "Без причины"
	
    -- ADDON USERS WINDOW
    GRM_L["SYNC USERS"] = "Синх. Юзеров"
    GRM_L["Ok!"] = "Окей!"
    GRM_L["Their Rank too Low"] = "Их звания слишком низкие"
    GRM_L["Your Rank too Low"] = "Ваше звание слишком низкое"
    GRM_L["Outdated Version"] = "Устаревшая версия"
    GRM_L["You Need Updated Version"] = "Вам нужно обновить версию"
    GRM_L["Player Sync Disabled"] = "Синхронизация с игроками отключена"
    GRM_L["No Guildie Online With Addon."] = "На данный момент в гильдии нет игроков с аддоном"
    GRM_L["ONE Person is Online. Recommend It!"] = "Один человек в сети без аддона"
    GRM_L["{num} others are Online! Recommend It!"] = "{num} игроков сейчас в сети без аддона, посоветуй установить его ^^"
    GRM_L["GRM Sync Info"] = "ГРМ Инфо о синхронизации"
    GRM_L["Ver: {custom1}"] = "Версия: {custom1}"  -- Context:  Ver: R1.125  - Ver is short for Version
    GRM_L["Name:"] = "Имя:"
    GRM_L["Version"] = "Версия:"
    GRM_L["Sync"] = "Синх"
    GRM_L["Your Sync is Currently Disabled"] = "Ваша синхронизация в настоящее время отключена"

    -- OPTIONS WINDOW
    GRM_L["Scanning Roster:"] = "Сканирование журнала"
    GRM_L["Guild Rank Restricted:"] = "Только для офицеров:"
    GRM_L["Sync:"] = "Синхронизация:"
    -- Options window -- of note, these are very concise statements. They may need to be adjusted properly in the Options window for proper spacing, so verify they look ok after translating.
    GRM_L["Slash Commands"] = "Команды в чате"
    GRM_L["Trigger scan for changes manually"] = "Принудительный запуск сканирования"
    GRM_L["Trigger sync one time manually"] = "Принудительный запуск синхронизации"
    GRM_L["Centers all Windows"] = "Центрировать все окна"
    GRM_L["Slash command info"] = "Доп. команды чата"
    GRM_L["Resets ALL data"] = "Удалить все данные"
    GRM_L["Report addon ver"] = "Сообщить версию аддона"                     -- Ver is short for Version
    GRM_L["Resets Guild data"] = "Удалить гильдейские данные"
    GRM_L["Show at Logon"] = "Открывать при входе"
    GRM_L["Only Show if Log Changes"] = "Только при изменении в журнале"
    
    -- This do need to be translated still
    GRM_L["Before Scan Timer"] = "Сканировать каждые"                  -- Context: "Scan for Changes Every 10 Seconds" -- There will be a number added here and may require custom positioning, so please provide full statement and Arkaan will allign
    GRM_L["After Scan Timer"] = "Секунд"
    GRM_L["Before Inactive Timer"] = "Уведомлять, если игрок оффлайн"
    GRM_L["After Inactive Timer"] = "дней."

     GRM_L["Reactivating SCAN for Guild Member Changes..."] = "Реактивация сканирования для поиска изменений в гильдии у игроков..."
    GRM_L["Deactivating SCAN of Guild Member Changes..."] = "Деактивация сканирования для поиска изменений в гильдии у игроков..."
    GRM_L["Please choose a scan interval {num} seconds or higher!"] = "Пожалуйста выберите интервал сканирования {num} секунд или больше!"
    GRM_L["{num} is too Low!"] = "{num} слишком мало!"
    GRM_L["The Current Lvl Cap is {num}."] = "Текущий предел уровня {num}."
    GRM_L["Kick Inactive Player Reminder at"] = "Исключать игрока, неактивного в течении"      -- Context: "Kick Inactive Player Reminder at X Months" - Again, allignment will need to be adjusted for options UI, so please post
    GRM_L["Please choose a month between 1 and 99"] = "Пожалуйста, выберите месяц от 1 до 99"
    GRM_L["Sync BAN List With Guildies at Rank"] = "Синх. БАН лист с согильдейцами звания"     -- Context: "Sync Ban List with Guildies at Rank [DROPDOWNMENU OF RANKS] or Higher" - Please show where dropdown menu should be pinned
    GRM_L["or Higher"] = "или выше"                               -- Context: Look at the above statement. Show where this needs to go in regards to dropdown menu of rank selection in Options
    GRM_L["Restore Defaults"] = "Сбросить настройки"
    GRM_L["Please choose between 1 and 180 days!"] = "Пожалуйста, выберите интервал от 1 до 180 дней!"
    GRM_L["Announce Events"] = "Анонс событий за"    -- Context: "Announce Events X number of days in advance" -- the X is the editbox to modify number of days. Please include the location of where to pin that.
    GRM_L["Days in Advance"] = "дней."
    GRM_L["Please choose between 1 and 28 days!"] = "Пожалуйста, выберите интервал от 1 до 28 дней!"
    GRM_L["Add Events to Calendar"] = "Добавлять события в календарь"
    GRM_L["SYNC Changes With Guildies at Rank"] = "Синхронизировать с согильдейцами звания"      -- Context: at Rank [DROPDOWNRANKSELECTION] or Higher. - Please note where to place dropdown box in the position of the sentence.
    GRM_L["Reactivating Data SYNC with Guildies..."] = "Реактивация синхронизации данных в гильдиях..."
    GRM_L["Deactivating Data SYNC with Guildies..."] = "Деактивация синхронизации данных в гильдиях..."
    GRM_L["Display Sync Update Messages"] = "Отображать сообщения о синхронизации"
    GRM_L["Only Sync With Up-to-Date Addon Users"] = "Синхронизироваться ТОЛЬКО с пользователями ПОСЛЕДНЕЙ версией аддона"
    GRM_L["Leveled"] = "ЛВЛ Ап"
    GRM_L["Inactive Return"] = "Возвращ. неактив."
    GRM_L["resetall"] = "СбросВсе"
    GRM_L["resetguild"] = "СбросГИ"
    --Side chat/log controls - Of note, limited spacing
    GRM_L["Name Change"] = "Смена имени"
    GRM_L["Rank Renamed"] = "Переим. звания"
    GRM_L["Event Announce"] = "Анонс события"
    GRM_L["Left"] = "Покинул"                        -- Context: As in, "Left" the guild...
    GRM_L["Recommendations"] = "Рекомендации"
    GRM_L["Banned"] = "БАН"
    GRM_L["To Chat:"] = "В Чате"                    -- Context: "To Chat Message frame -- in regards to announcing events like when a player leveled"
    GRM_L["To Log:"] = "В журнале"                    -- Context: To show it in the guild log.
    GRM_L["Display Changes"] = "Отображение изменений"
    GRM_L["Syncing too fast may cause disconnects!"] = "Очень быстрая синх. может привести к дисконекту!"
    GRM_L["Speed:"] = "Скорость:"                     -- Context: Speed that the sync takes place.
    GRM_L["Show 'Main' Name in Chat"] = "Писать имя 'Мейна' в чате"
	
     -- AUDIT WINDOW
    GRM_L["AUDIT"] = "Аудит"                            -- Audit Tab name
    GRM_L["No Date Set"] = "НЕТ даты"
    GRM_L["Main"] = "Мейн"
    GRM_L["Main or Alt?"] = "Мейн или Твинк?"
    GRM_L["Alt"] = "Твинк"
    GRM_L["Total Incomplete: {num} / {custom1}"] = "Всего незаполненых: {num} / {custom1}" -- Context: Total incomplete: 50 / 100    (50 out of 100)
    GRM_L["Mains:\n{num}"] = "Мейнов:\n{num}"        -- Context: Number of "main" toons
    GRM_L["Unique Accounts:\n{num}"] = "Уникальных акк-ов:\n{num}"
    GRM_L["All Complete"] = "Все заполнено"                                       -- Context: ц
    GRM_L["Set Incomplete to Unknown"] = "Заменить неполные на \"Неизвестно\"" -- Context: Implied to set ALL incomplete to unknown
    GRM_L["Clear All Unknown"] = "Отчистить все \"Неизвестно\""
    GRM_L["Please Wait {num} more Seconds"] = "Подождите еще {num} секунд"
    GRM_L["Guild Data Audit"] = "Аудит членов гильдии"
    GRM_L["Name"] = "Имя"
    GRM_L["Join Date"] = "Дата вступления"
    GRM_L["Promo Date"] = "Дата повышения"
    GRM_L["Main/Alt"] = "Мейн/твинк"
    GRM_L["Only Show Incomplete Guildies"] = "Только неполные записи"

   -- ADDON SYSTEM MESSAGES
    GRM_L["Guild Roster Manager"] = "Guild Roster Manager"
    GRM_L["GRM:"] = "ГРМ:"                                                                -- Abbreviation for "Guild Roster Manager"
    GRM_L["(Ver:"] = "(Версия:"                                                               -- Ver: is short for Version:
    GRM_L["GRM Updated:"] = "ГРМ обновлен:"
    GRM_L["Configuring Guild Roster Manager for {name} for the first time."] = "Настройка ГРМ для {name} в первый раз."
    GRM_L["Notification Set:"] = "Уведомление установлено:"
    GRM_L["Report When {name} is ACTIVE Again!"] = "Сообщать, когда {name} снова будет АКТИВНЫМ!"
    GRM_L["Report When {name} Comes Online!"] = "Сообщать, когда {name} снова будет в сети!"
    GRM_L["Report When {name} Goes Offline!"] = "Сообщать, когда {name} снова будет не в сети!"
    GRM_L["A new version of Guild Roster Manager is Available!"] = "Новая версия ГРМ доступна!"
    GRM_L["Please Upgrade!"] = "Пожалуйста обновитесь!"
    GRM_L["Player Does Not Have a Time Machine!"] = "У игрока нет машины времени ;)"
    GRM_L["Please choose a valid DAY"] = "Пожалуйста, выберите правильный день"
    GRM_L["{name} has been Removed from the Ban List."] = "{name} был удален из запрещенного списка."
    GRM_L["Scanning for Guild Changes Now. One Moment..."] = "Сканирование гильдии на изменения. Один момент..."
    GRM_L["Breaking current Sync with {name}."] = "Синхронизация с {name} прервана!"
    GRM_L["Breaking current Sync with the Guild..."] = "Прервана текущая синхронизация с гильдией..."
    GRM_L["Initializing Sync Action. One Moment..."] = "Инициализация синхронизации. Один момент..."
    GRM_L["No Players Currently Online to Sync With..."] = "В настоящее время нет игроков в игре для синхронизации..."
    GRM_L["No Addon Users Currently Compatible for FULL Sync."] = "В настоящее время нет игроков с аддоном для полной синхронизации"
    GRM_L["SYNC is currently not possible! Unable to Sync with guildies when guild chat is restricted."] = "Синхронизация в настоящее время невозможна! Невозможно синхронизироваться с гильдией, когда чат гильдии недоступен."
    GRM_L["Manual Scan Complete"] = "Ручное сканирование завершено"
    GRM_L["Analyzing guild for the first time..."] = "Инициализируем первый анализ гильдии..."
    GRM_L["Building Profiles on ALL \"{name}\" members"] = "Создание профилей для ВСЕХ \"{name}\" участников "                 -- {name} will be the Guild Name, for context
    GRM_L["NOTIFICATION:"] = "Оповещение:"                                               -- Context:  "Notification: Player is no longer AFK"
    GRM_L["{name} is now ONLINE!"] = "{name} вошел в игру!"
    GRM_L["{name} is now OFFLINE!"] = "{name} вышел из игры!"
    GRM_L["{name} is No Longer AFK or Busy!"] = "Вернулся из АФК"
    GRM_L["{name} is No Longer AFK or Busy, but they Went OFFLINE!"] = "Вернулся из АФК и вышел из сети"
    GRM_L["Player should try to obtain group invite privileges."] = "Игрок должен получить привилегии группового приглашения."
    GRM_L["{name}'s saved data has been wiped!"] = "Данные пользователя {name} удалены!"
    GRM_L["Wiping all Saved Roster Data Account Wide! Rebuilding from Scratch..."] = "Полная очистка всей учетной записи сохраненных данных реестра! Восстановление с нуля..."
    GRM_L["Wiping all saved Guild data! Rebuilding from scratch..."] = "Удаление всех сохраненных данных гильдии! Восстановление с нуля..."
    GRM_L["There are No Log Entries to Delete, silly {name}!"] = "Нет записей журнала для удаления, глупыш {name} :P"
    GRM_L["Guild Log has been RESET!"] = "Журнал гильдии был сброшен!"
    GRM_L["{name} is now set as \"main\""] = "Игрок {name} назначен \"Мейном\""
    GRM_L["{name} is no longer set as \"main\""] = "{name} больше не является \"Мейном\""
    GRM_L["Reset All of {name}'s Data?"] = "Сбросить все данные {name}?"
    
    -- /grm help
    GRM_L["Opens Guild Log Window"] = "Открыть окно гильдейского журнала"
    GRM_L["Resets ALL saved data"] = "Сбросить все сохраненные данные"
    GRM_L["Resets saved data only for current guild"] = "Сбросить все данные только для текущей гильдии"
    GRM_L["Re-centers the Log window"] = "Отцентровать окно журнала"
    GRM_L["Triggers manual re-sync if sync is enabled"] = "Запускает повторную синхронизацию вручную, если синхронизация включена"
    GRM_L["Does a one-time manual scan for changes"] = "Выполняет одноразовое сканирование вручную на предмет изменений"
    GRM_L["Displays current Addon version"] = "Отображает текущую версию аддона"
    GRM_L["WARNING! Complete hard wipe, including settings, as if addon was just installed."] = "ПРЕДУПРЕЖДЕНИЕ! Полный сброс, включая все настройки, до состояния только что установленного аддона.";

    -- General Misc UI
    GRM_L["Really Clear All Account-Wide Saved Data?"] = "Вы действительно хотите очистить все сохраненные данные учетной записи?"
    GRM_L["Really Clear All Guild Saved Data?"] = "Вы действительно хотите очистить все сохраненные данные гильдии?"
    GRM_L["Yes!"] = "Да!"
    GRM_L["Ban Player?"] = "ЗаБАНить игрока?"
    GRM_L["Ban the Player's {num} alts too?"] = "ЗаБАНить также {num} твинков?"        -- Plural number of alts
    GRM_L["Ban the Player's {num} alt too?"] = "ЗаБАНить также {num} твинка?"     -- Singular number of alts, just 1
    GRM_L["Please Click \"Yes\" to Ban the Player!"] = "Нажмите \"Да!\", чтобы заБАНить игрока!"

    -- Sync Messages
    GRM_L["{name} updated {name2}'s Join Date."] = "{name} обновил дату вступления игрока {name2}."
    GRM_L["{name} updated {name2}'s Promotion Date."] = "{name} обновил дату повышения игрока {name2}."
    GRM_L["\"{custom1}\" event added to the calendar by {name}"] = "\"{custom1}\" событие добавлено игроком {name}"
    GRM_L["{name} updated {name2}'s list of Alts."] = "{name} обновил список твинков игрока {name2}."
    GRM_L["{name} removed {name2} from {custom1}'s list of Alts."] = "{name} очистил список твинков игрока {name2} {custom1}."
    GRM_L["{name} set {name2} to be 'Main'"] = "{name} изменил {name2} на 'Мейна'"
    GRM_L["{name} has changed {name2} to be listed as an 'alt'"] = "{name} изменил {name2}, на 'Твинка'"
    GRM_L["{name} has Removed {name2} from the Ban List."] = "{name} удалил игрока {name2} из бан листа."
    GRM_L["{name} has been BANNED from the guild!"] = "Игрок {name} был забанен в гильдии!"
    GRM_L["{name} has been UN-BANNED from the guild!"] = "Игрок {name} был разбанен в гильдии!"
    GRM_L["Initiating Sync with {name} Instead!"] = "Инициализация синхронизации с игроком {name}"
    GRM_L["Sync Failed with {name}..."] = "Неудачная синхронизация с игроком {name}"
    GRM_L["The Player Appears to Be Offline."] = "Игрок отключен от сети."
    GRM_L["There Might be a Problem With Their Sync"] = "Проблема может быть с их синхронизацией"
    GRM_L["While not ideal, Ask Them to /reload to Fix It and Please Report the Issue to Addon Creator"] = "Хотя это и не идеально, попросите их ввести команду /reload, чтобы исправить это, и сообщите о проблеме создателю аддона."
    GRM_L["Manually Syncing Data With Guildies Now... One Time Only."] = "Ручная синхронизация данных с гильдиями..."
    GRM_L["Syncing Data With Guildies Now..."] = "Синхронизация данных с гильдией..."
    GRM_L["(Loading screens may cause sync to fail)"] = "(Загрузочные экраны могут вызвать сбой синхронизации)"
    GRM_L["Sync With Guildies Complete..."] = "Синхронизация с гильдией завершена..."
    GRM_L["Manual Sync With Guildies Complete..."] = "Ручная синхронизация с гильдией завершена..."
    GRM_L["No Players Currently Online to Sync With. Re-Disabling Sync..."] = "В настоящее время нет игроков в сети для синхронизации. Повторное отключение синхронизации..."
    GRM_L["{name} tried to Sync with you, but their addon is outdated."] = "{name} пытался выполнить синхронизацию с вами, но его аддон устарел."
    GRM_L["Remind them to update!"] = "Попросите его обновится!"

    
    -- ERROR MESSAGES
    GRM_L["Notification Has Already Been Arranged..."] = "Уведомление уже организовано..."
    GRM_L["Failed to add alt for unknown reason. Try closing Roster window and retrying!"] = "Не удалось добавить твинка по неизвестной причине. Попробуйте закрыть окно списка и повторите попытку!"
    GRM_L["{name} is Already Listed as an Alt."] = "{name} уже назначен твинком"
    GRM_L["{name} cannot become their own alt!"] = "{name} не может стать своим собственным твинком!"
    GRM_L["Player Cannot Add Themselves as an Alt"] = "Игрок не может добавить себя в качестве твинка"
    GRM_L["Player Not Found"] = "Игрок не найден"
    GRM_L["Please try again momentarily... Updating the Guild Event Log as we speak!"] = "Пожалуйста, попробуйте еще раз... Обновляем журнал событий гильдии, пока вы это читаете :)"
    GRM_L["Invalid Command: Please type '/grm help' for More Info!"] = "Неверная команда: для получения дополнительной информации введите '/grm help'!"
    GRM_L["{name} is not currently in a guild. Unable to Proceed!"] = "{name} в настоящее время не состоит в гильдии. Невозможно продолжить!"
    GRM_L["Addon does not currently support more than 75 alts!"] = "Аддон на данный момент поддерживает не более 75 твинков!"
    GRM_L["Please choose a VALID character to set as an Alt"] = "Пожалуйста, выберите верного персонажа, чтобы установить его как твинка"
    GRM_L["Please choose a character to set as alt."] = "Выберите персонажа, которого нужно установить как твинка."
    GRM_L["GRM ERROR:"] = "ГРМ ОШИБКА:"
    GRM_L["Com Message too large for server"] = "Коммуникационное сообщение слишком большое для сервера"                    -- Context: "Com message" is short-hand for "Communications message" - this is a technical error on syncing data.
    GRM_L["Prefix:"] = "Префикс:"
    GRM_L["Msg:"] = "Сообщение:"                                               -- Context: Msg is short for Message
    GRM_L["Unable to register prefix > 16 characters: {name}"] = "Невозможно зарегистрировать префикс >16 символов персонажа: {name}"   -- Context: The {name} is the string code for the prefix. This is for debugging.

	
    --SLASH COMMANDS
    -- These are generally written in general shorthand. The original commands will ALWAYS work, but if there is one that makes more sense in your language, please feel free to modify
    GRM_L["clearall"] = "Сброс Все"                       -- Context: In regards, "Clear All" saved data account wide 
    GRM_L["clearguild"] = "Сброс ГИ"                      -- Context: In regards, "Clear All" saved data from ONLY the current guild.
    GRM_L["hardreset"] = "Полный сброс"                       -- Context: In regards, "Hard Reset" ALL data account wide, including wiping player settings
    GRM_L["help"] = "Помощь"                            -- Context: "help" with info on the how to use addon
    GRM_L["version"] = "Версия"                         -- Context: "version" of the addon
    GRM_L["center"] = "Центр"                          -- Context: "center" the movable addon window back to center of screen
    GRM_L["sync"] = "Синх"                            -- Context: "sync" the data between players one time now.
    GRM_L["scan"] = "Скан"                            -- Context: "scan" for guild roster changes one time now.

      -- CLASSES
    GRM_L["Deathknight"] = "Рыцарь смерти"
    GRM_L["Demonhunter"] = "Охотник на демонов"
    GRM_L["Druid"] = "Друид"
    GRM_L["Hunter"] = "Охотник"
    GRM_L["Mage"] = "Маг"
    GRM_L["Monk"] = "Монах"
    GRM_L["Paladin"] = "Паладин"
    GRM_L["Priest"] = "Жрец"
    GRM_L["Rogue"] = "Разбойник"
    GRM_L["Shaman"] = "Шаман"
    GRM_L["Warlock"] = "Чернокнижник"
    GRM_L["Warrior"] = "Воин"

    -- TIME AND DATES
    GRM_L["1 Mar"] = "1 мар"                           -- This date is used in a specific circumstance. If someone's anniversary/bday landed on a leap year (Feb 29th), it defaults to the 1st of March on non-leap year
    -- Full Month Name
    GRM_L["January"] = "Январь"
    GRM_L["February"] = "Февраль"
    GRM_L["March"] = "Март"
    GRM_L["April"] = "Апрель"
    GRM_L["May"] = "Май"
    GRM_L["June"] = "Июнь"
    GRM_L["July"] = "Июль"
    GRM_L["August"] = "Август"
    GRM_L["September"] = "Сентябрь"
    GRM_L["October"] = "Октябрь"
    GRM_L["November"] = "Ноябрь"
    GRM_L["December"] = "Декабрь"
    -- Shorthand Month
    GRM_L["Jan"] = "янв"
    GRM_L["Feb"] = "фев"
    GRM_L["Mar"] = "мар"
    GRM_L["Apr"] = "апр"
    GRM_L["May"] = "май"
    GRM_L["Jun"] = "июнь"
    GRM_L["Jul"] = "июль"
    GRM_L["Aug"] = "авг"
    GRM_L["Sep"] = "сен"
    GRM_L["Oct"] = "окт"
    GRM_L["Nov"] = "ноя"
    GRM_L["Dec"] = "дек"
    -- Time Notifcation
    GRM_L["Seconds"] = "Секунд"
    GRM_L["Second"] = "Секунда"
    GRM_L["Minutes"] = "Минут"
    GRM_L["Minute"] = "Минута"
    GRM_L["Hours"] = "Часов"
    GRM_L["Hour"] = "Час"
    GRM_L["Days"] = "Дней"
    GRM_L["Day"] = "День"
    GRM_L["Months"] = "Месяцев"
    GRM_L["Month"] = "Месяц"
    GRM_L["HourBreak"] = ":"            -- Context, in English, and many languages, 11am = 11:00 -- or in French, 11h00   - the hour break is the ":" or the "h" 

    GRM_L["am"] = "am"
    GRM_L["pm"] = "рm"
    GRM_L["24HR_Notation"] = "";        -- if someone is using 24hr time notation in your country, instead of 12hr, how do you notate it? In English, there is no am/pm (though "hours" is technically right, but unnecessary)

    GRM_L["{num} year"] = "{num} год"
    GRM_L["{num} years"] = "{num} лет"
    GRM_L["{num} month"] = "{num} месяца"
    GRM_L["{num} months"] = "{num} месяцев"
    GRM_L["{num} day"] = "{num} день"
    GRM_L["{num} days"] = "{num} дней"
    GRM_L["< 1 day"] = "< 1 дня"

    GRM_L["{num} yr"] = "{num} год"
    GRM_L["{num} yrs"] = "{num} лет"
    GRM_L["{num} mo"] = "{num} мес."
    GRM_L["{num} mos"] = "{num} мес."
    GRM_L["{num} hr"] = "{num} час"
    GRM_L["{num} hrs"] = "{num} час."
    GRM_L["< 1 hour"] = "< 1 часа"
    GRM_L["{num} {custom1}"] = "{num} {custom1}"     -- Context: This is a placeholder for ANY generic time data -- Ex:  "1 year" or "15 months" - The translation is set this is just to set the orientation of the number properly.

    -- MISC Punctuation
    GRM_L[","] = ","                             -- I know in some Asia languages, a comma is not used, but something similar, for example.

    -- Updates 1.126
    GRM_L["General"] = "Основные"
    GRM_L["General:"] = "Основные:"
    GRM_L["Scan"] = "Скан"
    GRM_L["Help"] = "Помощь"
    GRM_L["UI"] = "UI"                              -- UI for User Interface. Abbreviation for changing custom UI featuers, like coloring of <M> main
    GRM_L["Officer"] = "Офицерская"                        -- as in, "Officer" rank
    GRM_L["Open Addon Window"] = "Открыть окно Аддона"
    GRM_L["Sync Addon Settings on All Alts in Same Guild"] = "Сохранить настройки для всех альтов в гильдии"
    GRM_L["Show Minimap Button"] = "Показывать иконку около миникарты"
    GRM_L["Player is Not Currently in a Guild"] = "Игрок не состоит в гильдии"
    -- tooltips
    GRM_L["|CFFE6CC7FClick|r to open GRM"] = "|CFFE6CC7FЛКМ|r для открытия ГРМ"                           -- Please maintain the color coding
    GRM_L["|CFFE6CC7FRight-Click|r to Reset to 100%"] = "|CFFE6CC7FПКМ|r для сброса до 100%"                -- for the Options slider tooltip
    GRM_L["|CFFE6CC7FRight-Click|r to Set Notification of Status Change"] = "|CFFE6CC7FПКМ|r для установки уведомления об изменении статуса"
    -- tooltip end
    GRM_L["GRM"] = "ГРМ"
    GRM_L["Include Unknown as Incomplete"] = "Считать \"Неизвестно\" как неполные" -- Context: Unknown in the Audit Tab will be hidden if filtering out complete players
    GRM_L["You Do Not Have Permission to Add Events to Calendar"] = "У тебя не прав для создания события в календаре"
    GRM_L["Please Select Which Join Date to Sync"] = "Пожалуйста, выберите дату присоединения для синхронизации"
    GRM_L["Sync All Alts to {name}'s Join Date"] = "Синхронизировать всех твинков с датой присоединения {name}"
    GRM_L["Sync All Alts to the Earliest Join Date: {name}"] = "Синхронизировать всех твинков с самой ранней датой присоединения: {name}"
    GRM_L["Sync All Alts to {name}'s |cffff0000(main)|r Join Date"] = "Синхронизировать всех твинков игрока {name} |cffff0000(main)|r с датой присоединения"  -- The coloring ensures that "(main)" maintains the RED color. Please keep it consistent if relevant to your language.
    GRM_L["Join Date of All Alts is Currently Synced"] = "Дата присоединения всех твинков в настоящее время синхронизирована"

    -- Update 1.130
    GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button."] = "|CFFE6CC7FCtrl-Shift-ЛКМ|r для скрытия этой кнопки."
    GRM_L["Invited By:"] = "Пригласил:"
    GRM_L["Error: Guild Not Found..."] = "Ошибка: гильдия не найдена."
    GRM_L["Debugger Start"] = "Запуск Дебаггера";

    -- Update 1.136
    GRM_L["Backup Point Removed for Guild \"{name}\""] = "Резервная точка для гильдии удалена игроком \"{name}\""
    GRM_L["Backup Point Restored for Guild \"{name}\""] = "Резервная точка для гильдии восстановлена игроком \"{name}\""
    GRM_L["Backup Point Set for Guild \"{name}\""] = "Резервная точка для гильдии изменена игроком \"{name}\""
    GRM_L["Backup"] = "Бэкап"
    GRM_L["Horde"] = "Орда"
    GRM_L["Alliance"] = "Альянс"
    GRM_L["Creation Date"] = "Дата создания"
    GRM_L["Members"] = "Участников"
    GRM_L["Backup {num}:"] = "Бэкап {num}:"           -- As in, the number of backups... so "Backup 1:"
    GRM_L["None"] = "None"
    GRM_L["Restore"] = "Восстановить"
    GRM_L["Set Backup"] = "Создать бэкап"
    GRM_L["Memory Usage: {num} MB"] = "Памяти использовано: {num} MB"          -- MB references the number of MegaBytes of memory used.

    -- Update 1.137
    GRM_L["GRM: Unable to Create Backup for a Guild With Unknown Creation Date! Log into that guild on any alt to update old database."] = "ГРМ: невозможно создать резервную копию гильдии с неизвестной датой создания! Войдите в эту гильдию с любого твинка, чтобы обновить старую базу данных."
    GRM_L["Enable Auto-Backup Once Every"] = "Включить автобекап каждые"
    GRM_L["Auto {num}:"] = "Авто {num}:"
    GRM_L["Please Choose a Time Interval Between 1 and 99 Days!"] = "Пожалуйста, выберите временной интервал от 1 до 99 дней!"
    GRM_L["Really restore {name} Backup Point?"] = "Вы действительно хотите восстановить бэкап игрока {name}?" 
    GRM_L["Check All"] = "Выбрать все"

    -- Update 1.139
    GRM_L["Right-Click for options to remove this guild from the addon database completely"] = "Щелкните правой кнопкой мыши, чтобы увидеть варианты полного удаления этой гильдии из базы данных аддона."
    GRM_L["Player Cannot Purge the Guild Data they are Currently In!!!"] = "Игрок не может очистить данные гильдии, в которой он находится!!!"
    GRM_L["To reset your current guild data type '/grm clearguild'"] = "Чтобы сбросить текущий тип данных гильдии '/ grm clearguild'"
    GRM_L["Click Here to Remove all traces of this guild, or hit ESC"] = "Нажмите здесь, чтобы удалить все следы этой гильдии, или нажмите ESC"
    GRM_L["{name} has been removed from the database."] = "{name} был удален из базы данных."            -- The Guild Name has been removed from the database

    -- update 1.141
    GRM_L["Only Restrict Incoming Player Data to Rank Threshold, not Outgoing"] = "Не принимать данные от игроков, ниже данного звания"
    GRM_L["Total Entries: {num}"] = "Всего записей: {num}"
    GRM_L["Search Filter"] = "Поиск"

    -- update 1.142w
    GRM_L["Choose Color:"] = "Выбор цвета:"
    GRM_L["Format:"] = "Формат:"
    GRM_L["M"] = "M"           -- Of note, the "M" is short for "Main" and this is the reference to the main tag on alts in guild chat.
    GRM_L["RGB Values Must be Between 1 and 255."] = "Значения RGB должны быть от 1 до 255."

    -- Update 1.143
    GRM_L["The Log is Currently Empty for This Guild"] = "Журнал этой гильдии пока пуст"
    GRM_L["Building Log for Export..."] = "Создание лога для экспорта"
    GRM_L["Open Log Tools"] = "Открыть настройки"
    GRM_L["Hide Log Tools"] = "Закрыть настройки"
    GRM_L["Numbered Lines"] = "Нумерация строк"
    GRM_L["Export Log"] = "Экспорт журнала"
    GRM_L["Clear Lines:"] = "Очистить с"
    GRM_L["Enable Ctrl-Shift-Click Line Removal"] = "Включить \"Ctrl-Shift-ЛКМ\" для удаления"
    GRM_L["To"] = "по"                                      -- Clear Lines:  50 To 100     -- It stands between 2 edit boxes as its own fontstring, so work with that.
    GRM_L["Confirm Clear"] = "Очистить"
    GRM_L["Please Select Range of Lines from the Log You Wish to Remove"] = "Выберите диапазон строк из журнала, которые вы хотите удалить"
    GRM_L["Please put the lowest number in the first box"] = "Пожалуйста, введите наименьшее число в первое поле"
    GRM_L["Line selection is not valid"] = "Выбранные строки не верны"
    GRM_L["Really Clear lines {custom1} to {custom2}?"] = "Вы действительно хотите очистить строки с {custom1} по {custom2}?"
    GRM_L["Enabling Line Numbers... Please choose within the given range"] = "Включение номеров строк ... Пожалуйста, выберите из указанного диапазона"
    GRM_L["Ctrl-C to Copy <> Ctrl-P to Paste <> Ctrl-A to Select All"] = "Ctrl-C для копирования <> Ctrl-V для вставки <> Ctrl-A выбрать всё"
    GRM_L["Language Selection:"] = "Выбор языка:"
    GRM_L["{num} phrases still need translation to {name}"] = "{num} фраз нуждаются в переводе на {name}" -- Ex: 300 phrases still need translation to German

    -- update 1.145
    GRM_L["You currently are at {num} non-Battletag friends. To fully take advantage of all of GRM features, please consider clearing some room."] = "В настоящее время у вас {num} друзей, без Battletag'a. Чтобы в полной мере воспользоваться всеми функциями ГРМ, рассмотрите возможность освобождения места."

    -- Update 1.146
    GRM_L["Really Clear line {num}?"] = "Вы действительно хотите очистить строку {num}?"
    GRM_L["Font has been Reset to DEFAULT."] = "Шрифт был сброшен на по умолчанию."
    GRM_L["Font Selection:"] = "Выбор шрифта:"
    GRM_L["Font Scale:"] = "Размер шрифта:"
    GRM_L["Example"] = "Пример"
    GRM_L["Right-Click to Reset to 100%"] = "|CFFE6CC7FПКМ|r для сброса до 100%"

    -- Update 1.147
    GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Search the Log for Player"] = "|CFFE6CC7FCtrl-Shift-ЛКМ|r для поиска игрока в журнале"

    -- Update 1.1480
    GRM_L["Custom Notes:"] = "Доп Заметка:"
    GRM_L["GRM Debugging Enabled."] = "ГРМ Отладка включена."
    GRM_L["GRM Debugging Disabled."] = "ГРМ Отладка отключена."
    GRM_L["Please type \"/grm debug 10\" to report 10 events (or any number)"] = "Пожалуйста, введите \"/grm debug 10\", чтобы посмотреть отчет о 10 событиях (или измените цифру для просмотра нужного количества)"        -- Please keep the \"/grm debug 10)\" in-tact for slash command to work
    GRM_L["Format: \"/grm debug 10\""] = "Формат: \"/grm debug 10\""                                                                  -- "" Likewise
    GRM_L["Error: Debug Command not recognized."] = "Ошибка: команда отладки не распознана."
    GRM_L["You may want to temporarily disable SYNC in the options if you are debugging another feature."] = "Вы можете временно отключить синхронизацию в параметрах, если вы отлаживаете другую функцию."
    GRM_L["Sync Custom Notes"] = "Синхронизировать Пользовательские заметки"
    GRM_L["Default Custom Note Rank Minimum"] = "Минимальное звание для импорта Пользовательских заметок"
    GRM_L["Reset Default Custom Note Restrictions for ALL Guildies"] = "Сбросить минимальное звание для импорта Доп.Заметками для всей ГИ"
    GRM_L["Reset"] = "Сбросить"
    GRM_L["|CFF00CCFFDefault Selection For All Players"] = "|CFF00CCFFПо умолчанию для всех игроков"
    GRM_L["Click here to set Custom Notes"] = "Нажмите, для установки пользовательской заметки"
    GRM_L["|CFF00CCFFCustom Note Defaults:"] = "|CFF00CCFFПользовательские заметки по умолчанию"
    GRM_L["|CFFE6CC7FLeft-Click|r to re-enable custom note sync for all"] = "|CFFE6CC7FЛКМ|r чтобы повторно включить синхронизацию пользовательских заметок для всех"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Added"] = "{name} добавил пользовательскую заметку игроку {name2}: \"{custom1}\""
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Removed"] = "{name} удалил пользовательскую заметку игроку {name2}: \"{custom1}\""
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" to \"{custom2}\""] = "{name} изменил пользовательскую заметку игроку {name2}: с \"{custom1}\" на \"{custom2}\""
    GRM_L["Custom Note"] = "Пользовательская заметка"
    GRM_L["|CFFE6CC7FClick|r to Change Rank Restriction"] = "|CFFE6CC7FЛКМ|r чтобы изменить ограничение звания"
    GRM_L["|CFFE6CC7FClick|r to Change Day"] = "|CFFE6CC7FЛКМ|r чтобы выбрать ДЕНЬ" 
    GRM_L["|CFFE6CC7FClick|r to Change Month"] = "|CFFE6CC7FЛКМ|r чтобы выбрать МЕСЯЦ" 
    GRM_L["|CFFE6CC7FClick|r to Change Year"] = "|CFFE6CC7FЛКМ|r чтобы выбрать ГОД" 
    GRM_L["Edited by {name}"] = "Изменено игроком {name}"
    GRM_L["Note Removed by {name}"] = "Заметка удалена игроком {name}"
    GRM_L["|CFFFF0000Player No Longer in Guild"] = "|CFFFF0000Игрок больше не в гильдии"
    GRM_L["|CFF00CCFFMinimum Rank to Sync: Player Data, Ban List"] = "Минимальное звание для синхронизации: данных игроков и списка запретов"
    GRM_L["Warning! Ban List rank threshold is below the overall sync rank. Changing from \"{name}\" to \"{name2}\""] = "Предупреждение! Пороговое значение рейтинга запрещенного списка ниже общего рейтинга синхронизации. Переход с \"{name}\" на \"{name2}\""
    GRM_L["|CFF00CCFFSync filter can be set tighter for the Ban List"] = "Фильтр синхронизации можно установить более жестко для бан листа"
    GRM_L["Warning! Unable to select a Ban List rank below \"{name}\""] = "Предупреждение! Невозможно выбрать звание бан листа ниже \"{name}\""
    GRM_L["Setting to match core filter rank"] = "Настройка для соответствия званию основного фильтра"

    -- R1.1482
    GRM_L["Shift-Click Name On Roster Also Works"] = "Shift+ПКМ по имени работает"
    GRM_L["Tooltip Scale:"] = "Размер подсказки"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Language"] = "|CFFE6CC7FЛКМ|r для выбора языка"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change Display Format"] = "|CFFE6CC7FЛКМ|r для выбора формата"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Font"] = "|CFFE6CC7FЛКМ|r для выбора шрифта"

    -- R1.1490
    GRM_L["You will still share some outgoing data with the guild"] = "Вы по-прежнему будете делиться исходящими данными с гильдией"
    GRM_L["Unable to properly locate guild for backup"] = "Невозможно правильно найти гильдию для резервного копирования"

    -- R1.1500
    GRM_L["Unique accounts pull from the server is known to be faulty"] = "Известно, что получение уникальных учетных записей с сервера ошибочно"
    GRM_L["Use only as an estimate. Hopefully Blizz fixes this soon"] = "Используйте только как оценку. Надеюсь, Blizz скоро это исправит"
    GRM_L["Add Upcoming Events to the Calendar"] = "Добавить предстоящие события в календарь"
    GRM_L["Player rank unable to add events to calendar"] = "Звание игрока недостаточно чтобы добавлять события в календарь"
    GRM_L["Anniversaries, Birthdays, and Other Events can be added with permission"] = "Годовщины, дни рождения и другие события могут быть добавлены с разрешения"

    -- R1.1510
    GRM_L["Check the \"Sync Users\" tab to find out why!"] = "Проверьте вкладку \"Синхронизация пользователей \", чтобы узнать почему!"
    GRM_L["Time as Member:"] = "Время членства"
    GRM_L["|CFFE6CC7FClick|r to select player event"] = "|CFFE6CC7FЛКМ|r для выбора события игрока"
    GRM_L["Timestamp Format:"] = "Формат даты:"
    GRM_L["Hour Format:"] = "Формат времени:"
    GRM_L["24 Hour"] = "24 часа"
    GRM_L["12 Hour (am/pm)"] = "12 часов (am/pm)"
    GRM_L["Enable Fade on Tab Change"] = "Включить плавное переключение вкладок"
    GRM_L["Confirm Custom Note"] = "Подтвердить Доп.Заметку"

    -- R1.1520
    GRM_L["A new rank has been added to the guild!"] = "В гильдии добавлено новое звание!" 
    GRM_L["{num} new ranks have been added to the guild!"] = "{num} в гильдию добавлены новые звания!"
    GRM_L["The guild has removed a rank!"] = "В гильдии удалено звание!"
    GRM_L["{num} guild ranks have been removed!" ] = "{num} в гильдии удалены звания!"
    GRM_L["Edit Ban"] = "Редакт. БАН"
    GRM_L["Please Select a Player to Edit their Ban!"] = "Пожалуйста, выберите игрока, чтобы изменить его бан!"
    GRM_L["Update Ban"] = "Обновить бан"
    GRM_L["{name}'s Ban Info has Been Updated!"] = "{name} информация о бане была обновлена!"

    -- R1.1530
    GRM_L["{name} plays the {custom1} class, not {custom2}."] = "{name} играет за {custom1}, а не {custom2}."             -- Example: Arkaan plays the Hunter class, not Paladin.
    GRM_L["{num} Items Updated"] = "{num} предмет обновлен"
    GRM_L["You Currently Have Disabled Adding Events to Calendar"] = "В настоящее время вы отключили добавление событий в календарь"

    -- R1.20
    GRM_L["|CFFE6CC7FHold Shift|r to view more alt details."] = "|CFFE6CC7FЗажмите Shift|r чтобы посмотреть дополнительные сведения о твинках. "               -- "Hold Shift to view more alt details" is the phrase, but the |CFF|r is the text coloring hex code. Please keep it in there on the keyboard command coloring
    GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7FЛКМ|r чтобы посмотреть дополнительные сведения о твинках.."
    GRM_L["{custom1} to keep alt details open."] = "{custom1}, чтобы не открывать альтернативные сведения."               -- The same can be said here. ^^
    GRM_L["|CFFE6CC7FClick|r to flip player name ordering"] = "|CFFE6CC7FЛКМ|r для изменения порядка имен игроков"                  -- and the reset...
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Newest"] = "|CFFE6CC7FЛКМ|r сортировать даты присоединения по самым новым"
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Oldest"] = "|CFFE6CC7FЛКМ|r сортировать даты присоединения по самым старым"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Newest"] = "|CFFE6CC7FЛКМ|r сортировать даты повышения по самым новым"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Oldest"] = "|CFFE6CC7FЛКМ|r сортировать даты повышения по самым старым"
    GRM_L["|CFFE6CC7FClick|r to sort all Mains first"] = "|CFFE6CC7FЛКМ|r для сортировки всех Мейнов первыми"
    GRM_L["|CFFE6CC7FClick|r to sort all Alts first."] = "|CFFE6CC7FЛКМ|r для сортировки всех твинков первыми"
    GRM_L["{name}'s Alts"] = "Твинки {name}"          -- Like "Arkaan's Alts"
    GRM_L["GRM window will open when combat ends."] = "Окно ГРМ откроется по окончанию боя."
	
    -- R1.24
    GRM_L["This also will change the <Alt> format to match"] = "Это также изменит формат <Твинк> для соответствия"
    GRM_L["A"] = "Тв"           

    -- R1.25
    GRM_L["Include \"Joined:\" tag with the date."] = "Включите тег \"Присоединяется:\" с датой."                                    -- the \" is so you include the qutoations in the actual text. You need them or it closes the phrase.
    GRM_L["GRM Auto-Detect! {name} has joined the guild and will be set as Main"] = "ГРМ Автообнаружение! {name} вступил в гильдию и будет назначен Мейном"            -- Main auto-detect message

    -- R1.26
    GRM_L["Click to Disable Sync of Custom Note"] = "Нажмите, чтобы отключить синхронизацию пользовательской заметки"
    GRM_L["Click to Enable Sync of Custom Note"] = "Нажмите, чтобы включить синхронизацию пользовательской заметки"

    -- R1.27
    GRM_L["Show Border on Public, Officer, and Custom Notes"] = "Показать границу в публичных, офицерских и пользовательских заметках"

    -- R1.28
    GRM_L["Public Note:"] = "Публичная заметка:"
    GRM_L["Officer Note:"] = "Офицерская заметка:"
    GRM_L["Public Note"] = "Публичная заметка"
    GRM_L["Officer Note"] = "Офицерская заметка"
    GRM_L["Show Public, Officer, and Custom Notes on Log Entries of Left Players"] = "Отображение публичных, офицерских и пользовательских заметок в записях журнала вышедших игроков"
    GRM_L["Hard Reset"] = "Полный сброс"
    GRM_L["Hard reset of ALL GRM data, account-wide. Game will reload!"] = "Полный сброс ВСЕХ данных ГРМ для всей учетной записи. Игра перезагрузится!"
    GRM_L["Only recommend to kick if all player linked alts exceed max time"] = "Рекомендовать только исключение, если все игроки связанные с твинками превышают максимальное время"
    GRM_L["Your Guild Leader Has Set Sync Restrictions to {name} or Higher"] = "Лидер вашей гильдии установил ограничения синхронизации на {name} или выше"
    GRM_L["Unable to Change Rank. Guild Leader has set restriction to {name} or higher"] = "Невозможно изменить звание. Лидер гильдии установил ограничение до {name} или выше"     -- Like Initiate or higher
    GRM_L["Unable to Change Rank. Guild Leader has set restriction level."] = "Невозможно изменить звание. Лидер гильдии установил уровень ограничения."
    GRM_L["Force Settings with Guild Info Tags"] = "Принудительные настройки с помощью тегов в информации о гильдии"
    GRM_L["Database Still Loading. GRM will open automatically when finished."] = "База данных все еще загружается. ГРМ откроется автоматически по завершении."

    -- R1.29
    GRM_L["The highlighted character is not valid for messages. Please remove."] = "Введенный символ недопустим для сообщений. Пожалуйста, удалите."
    GRM_L["Not all characters are valid. Please remove any non-text characters."] = "Не все символы корректны. Удалите все нетекстовые символы."
    GRM_L["Kick macro created. Press \"CTRL-SHIFT-K\" to kick all of {name}'s alts"] = "Создан макрос для исключения. Нажмите \"CTRL-SHIFT-K\", чтобы удалить всех твинков игрока {name}."
    GRM_L["Kick the Player's {num} alts too?"] = "Исключить {num} твинков игрока тоже?"       -- Plural
    GRM_L["Kick the Player's {num} alt too?"] = "Исключить {num} твинка игрока тоже?"      -- Not Plural  - "Kick the Player's 1 alt too?"
    GRM_L["Ban and Kick the Player's {num} alts too?"] = "Исключить и забанить {num} твинков игрока тоже?"
    GRM_L["Ban and Kick the Player's {num} alt too?"] = "Исключить и забанить {num} твинка игрока тоже?"

    -- R1.30
    GRM_L["Sync With {name} is Complete..."] = "Синхронизация с {name} завершена..."
    GRM_L["|CFFE6CC7FLeft-Click|r and drag to move this button."] = "|CFFE6CC7FЛКМ|r и перемещайте эту кнопку."
    GRM_L["|CFFE6CC7FCtrl-Left-Click|r and drag to move this button anywhere."] = "|CFFE6CC7FCtrl-ЛКМ|r и перемещайте эту кнопку куда угодно."
    GRM_L["MOTD:"] = "Сообщение дня"      -- Message Of The Day = M.O.T.D = MOTD - 
    GRM_L["minimap"] = "Миникарта"

    -- R1.31
    GRM_L["Show 'Main' Tag on both Mains and Alts in Chat"] = "Показывать 'Мейн' и 'Твинк' тег в чате"

    -- R1.32
    GRM_L["GRM has moved the Guild Leader setting restriction codes to the Guild Info tab."] = "ГРМ переместил коды ограничений настройки лидера гильдии на вкладку «Информация о гильдии»."
    GRM_L["Please make room for them and re-add."] = "Пожалуйста, освободите для них место и добавьте заново."
    GRM_L["Your Guild Leader Has Set BAN Sync Restrictions to {name} or Higher"] = "Ваш Лидер гильдии установил ограничения на синхронизацию банов на {name} или выше"
    GRM_L["Your Guild Leader Has Set CUSTOM NOTE Sync Restrictions to {name} or Higher"] = "Ваш Лидер гильдии установил ограничения на синхронизацию Пользовательсих заметок на {name} или выше"

    -- R1.33
    GRM_L["Macro will auto-remove after {num} seconds."] = "Макрос будет автоматически удален через {num} секунд."
    GRM_L["UI Controls"] = "Управление интерфейсом"
    GRM_L["UI Configuration:"] = "Конфигурация интерфейса:"
    GRM_L["Show Character Guild Reputation"] = "Показать репутацию персонажа в гильдии"
    GRM_L["Show Guild Member Birthdays"] = "Показать дни рождения членов гильдии"
    GRM_L["Set Birthday"] = "Установить день рождения"
    GRM_L["Edit Birthday"] = "Изменить день рождения"			
    GRM_L["Remove Date"] = "Удалить дату"            -- Clear Birthday shorthand
    GRM_L["Birthday"] = "День рождения"
    GRM_L["Only Announce Birthdays and Anniversaries if Listed as 'Main'"] = "Объявлять дни рождения и годовщины только в том случае, если персонаж указан как 'Мейн'"
    GRM_L["{name} will be celebrating {num} year in the Guild!"] = "{name} будет отмечать {num} год в Гильдии!"            -- {custom1} will reference the DATE. Ex: "Arkaan will be celebrating 1 year in the Guild! ( 1 May )" - SINGULAR
    GRM_L["{name} will be celebrating {num} years in the Guild!"] = "{name} будет отмечать {num} лет в Гильдии!"          -- Same thing but PLURAL - "years" in stead of "year"
    GRM_L["No player's currently available to sync {name}'s Guild Data..."] = "В настоящее время нет доступных игроков для синхронизации данных гильдии {name}..."
    GRM_L["{name} has set {name2}'s Birthday: {custom1}"] = "{name} установил день рождения {name2}: {custom1}"                  -- custom note is the date like "12 Dec"
    GRM_L["{name}'s Birthday has been set: {custom1}"] = "Установлен день рождения игрока {name}: {custom1}"
    GRM_L["Sync Birthdays"] = "Синхронизировать дни рождения"

    -- R1.34
    GRM_L["Debugging Enabled"] = "Отладка включена"
    GRM_L["Debugging Disabled"] = "Отладка отключена"
    GRM_L["{num} is not a valid day of the month! It must be a number between 1 and 31"] = "{num} не является допустимым днем месяца! Это должно быть число от 1 до 31."
    GRM_L["{num} is not a valid index of the month of the year! It must be a number between 1 and 12"] = "{num} не является допустимым индексом месяца в году! Это должно быть число от 1 до 12."
    GRM_L["The day cannot be {num}. It must be a number between 1 and 31"] = "День не может быть {num}. 'Это должно быть число от 1 до 31' ."
    GRM_L["The month cannont be {num}. must be a number between 1 and 12"] = "Месяц не может быть {num}. должно быть число от 1 до 12"
    GRM_L["{num} birthdays have been reset."] = "{num} дней рождений были сброшены."
    GRM_L["No player was found to have that birthday."] = "Не было найдено ни одного игрока, у которого день рождения."

    -- R1.35
    GRM_L["Your Guild Leader Has Set Join Dates to only be added to the {name}"] = "Ваш лидер гильдии назначил даты присоединения только к {name}"         -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...
    GRM_L["Warning - Global Controls:"] = "Предупреждение - Глобальный контроль:"
    GRM_L["Sync Restrictions Globally Changed to {name} or Higher"] = "Глобальные ограничения синхронизации изменены на {name} или выше"
    GRM_L["BAN Sync Restrictions Globally Changed to {name} or Higher"] = "Глобальные ограничения на синхронизацию банов изменены на {name} или выше"
    GRM_L["CUSTOM NOTE Sync Restrictions Globally Changed to {name} or Higher"] = "Глобальные ограничения на синхронизацию пользовательских заметок изменены на {name} или выше"
    GRM_L["Join Dates Globally Changed to only be added to the {name}"] = "Даты присоединения глобально изменены: добавляются только в {name}"
    GRM_L["Unable to Modify. Global setting is set to the {name}"] = "Невозможно изменить. Глобальная настройка установлена на {name}"                           -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...
    
    -- R1.37
    GRM_L["No Action Configured"] = "Действие не настроено"
    GRM_L["OLD LOG"] = "Старый лог"
    GRM_L["CHANGES"] = "Изменения пока вас не было"
    GRM_L["Sync has failed to start. Please try again!"] = "Синхронизация не началась. Пожалуйста, попробуйте еще раз!"
    GRM_L["Please wait {num} more seconds before manually initiating the sync process again."] = "Подождите еще {num} секунд перед повторным запуском процесса синхронизации вручную."

    -- R1.39
    GRM_L["Only Report if there are no Active Alts in the Group"] = "Сообщать только, если в группе нет активных твинков"
    GRM_L["Level Filter Minimum:"] = "Минимальный уровень фильтра:"                              -- As in player level
    GRM_L["Report Milestones:"] = "Сообщать рубежи:"
    GRM_L["Report Level Up Changes"] = "Сообщать об изменении уровня"
    GRM_L["Reporting:"] = "Отчет:"
    GRM_L["Unable to disable level cap tracking. Please disable ALL tracking to turn off."] = "Невозможно отключить отслеживание максимального уровня. Пожалуйста, отключите ВСЕ отслеживание, чтобы выключить."
    GRM_L["No Levels to Report to Log"] = "Нет уровней для регистрации в журнале"
    GRM_L["{name} has Surpassed their Level {num} Milestone and is Now {custom1}"] = "{name} превысил свой уровень {num} и теперь {custom1}"
    GRM_L["{name} has Reached their Level {num} Milestone"] = "{name} достиг своего уровня {num}"
    GRM_L["{name}'s Ban has been Updated by {name2}!"] = "Бан пользователя {name} был обновлен {name2}!"
    GRM_L["{name} has Updated {name2}'s BAN and also BANNED all linked alts from the guild!"] = "{name} обновил бан {name2}, а также забанил всех связанных твинков из гильдии!"
    GRM_L["One moment, GRM is still being configured."] = "Минутку, ГРМ все еще настраивается."
    GRM_L["Press ENTER to complete"] = "Нажмите ENTER для завершения"
    GRM_L["Player Was Banned By: {name}"] = "Персонаж был забанен игроком: {name}"
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED players are currently in the guild."] = "|cffff0000ВНИМАНИЕ!!!|r {num} забаненные игроки в настоящее время состоят в гильдии."     -- plural
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED player is currently in the guild."] = "|cffff0000ВНИМАНИЕ!!!|r {num} забаненный игрок в настоящее время состоит в гильдии."        -- Singular  -- please keep the color coding... this keeps the Warning in red
    
    -- R1.41
    GRM_L["{num} metadata profiles are being built for people previously in the guild. The data is being requested, but this may take some time."] = "Профили метаданных {num} создаются для людей, ранее состоявших в гильдии. Данные запрашиваются, но это может занять некоторое время."                   -- PLURAL
    GRM_L["One metadata profile is being built for a player previously in the guild. The data is being requested, but this may take some time."] = "Один профиль метаданных создается для игрока, ранее состоявшего в гильдии. Данные запрашиваются, но это может занять некоторое время."           -- SINGULAR, same line.
    GRM_L["Auto-Focus the search box"] = "Автофокусировка окна поиска"
    GRM_L["This will skip the first time if set to load on logon"] = "Это будет пропущено в первый раз, если установлено для загрузки при входе в систему"  -- Referring to the auto-focusing on the search box, this is a tooltip helper
    GRM_L["Please enter a valid level between 1 and {num}"] = "Введите допустимый уровень от 1 до {num}"
    GRM_L["Player's Main: {name}"] = "Мейн игрока: {name}"
    
    -- R1.43
    GRM_L["One moment, requesting additional details on {name} from the server. Ban List will soon update."] = "Минутку, запрос дополнительных сведений о {name} с сервера. Список банов скоро будет обновлен."
    GRM_L["Unable to identify {name}. Ensure your spelling is accurate! Otherwise, they may have left the server."] = "Невозможно идентифицировать {name}. Убедитесь, что вы написали правильно! В противном случае он мог покинуть сервер."
    GRM_L["(Unable to Identify)"] = "(Невозможно идентифицировать)"                                                                   -- As in, unable to identify on the server, they possibly server transferred off but are still on ban list
    GRM_L["|CFFE6CC7FClick|r to select player class"] = "|CFFE6CC7FЛКМ|r для выбора класса игрока"
    GRM_L["|CFFE6CC7FClick|r to select player's realm."] = "|CFFE6CC7FЛКМ|r для выбора реалма игрока."
    GRM_L["All Connected Realms are available to choose."] = "Все подключенные реалмы доступны для выбора."
    GRM_L["{num} players were found to have the same name. Please manually select which connected realm the player you wish to ban is on."] = "Было обнаружено, что у {num} игроков такое же имя. Пожалуйста, выберите вручную, в каком подключенном игровом мире находится игрок, которого вы хотите заблокировать."
    GRM_L["Click or Press TAB to cycle through each step."] = "Щелкните или нажмите клавишу TAB, чтобы просмотреть каждый шаг."
    GRM_L["Former and Current Members"] = "Бывшие и текущие участники"
    GRM_L["No Matches Found. Add a Custom New Player or Match"] = "Совпадений не найдено. Добавить нового игрока"       -- as in, autocomplete typing matching
    
    --1.50
    GRM_L["{name}'s alt grouping has had their Birthday removed by: {name2}"] = "День рождения для твинко группы пользователя {name} удалена: {name2}"
    GRM_L["{name}'s Birthday has been removed by: {name2}"] = "День рождения {name} удален: {name2}"
    GRM_L["Click to Sort"] = "Нажмите, чтобы отсортировать"
    GRM_L["No Updates"] = "Изменений не обнаружено"
    GRM_L["Timestamp Formatting has been Globally Set to: < {name} >"] = "Форматирование метки времени было глобально установлено на: <{name}>"
    GRM_L["Your Guild Leader Has Globally Set the Timestamp Formatting to: < {name} >"] = "Лидер вашей гильдии глобально установил форматирование метки времени на: <{name}>"
    GRM_L["Unable to Modify. Global setting is set to :   {name}"] = "Невозможно изменить. Глобальная настройка установлена на: {name}"

    -- If ppossible, try to maintain the allignment of the numbers, but only if it makes sense.
    GRM_L["{num}{custom1}: Join Dates"] = "{num}{custom1}: Даты входа"
    GRM_L["{num}{custom1}: Promo Dates"] = "{num}{custom1}: Даты обьявлений"
    GRM_L["{num}{custom1}: Alts"] = "{num}{custom1}: Твинки"
    GRM_L["{num}{custom1}: Main Tags"] = "{num}{custom1}: Тег Мейна"
    GRM_L["{num}{custom1}: Custom Notes"] = "{num}{custom1}: Пользовательские заметки"
    GRM_L["{num}{custom1}: Birthdays"] = "{num}{custom1}: Дни рождения"

    -- 1.52
    GRM_L["Times in Guild: {num}"] = "Время в гильдии: {num}"
    
    -- 1.56
    -- More slash commands
    GRM_L["kick"] = "Кик"
    GRM_L["ban"] = "Бан"
    GRM_L["audit"] = "Аудит"
    GRM_L["log" ] = "Журнал"
    GRM_L["event"] = "Событие"
    GRM_L["events"] = "События"
    GRM_L["users"] = "Пользователи"
    GRM_L["syncusers"] = "Синхронизация пользователей"
    GRM_L["opt"] = "Выбрать"
    GRM_L["option"] = "Опция"
    GRM_L["options"] = "Опции"

    GRM_L["GRM Date"] = "ГРМ дата"
    GRM_L["Note Date"] = "Дата заметки"
    GRM_L["Status"] = "Статус"
    GRM_L["Refresh"] = "Обновить"
    GRM_L["Clear Selection"] = "Очистить выбранное"
    GRM_L["Fix all mismatched note dates with GRM saved date"] = "Исправьте все несовпадающие даты заметок с сохраненной датой ГРМ"
    GRM_L["Fix selected mismatched note dates with GRM saved date"] = "Исправить выбранные несоответствующие даты заметок с сохраненной датой ГРМ"
    GRM_L["Fix all mismatched GRM dates with the note date"] = "Исправьте все несовпадающие даты ГРМ с датой заметки"
    GRM_L["Fix selected mismatched GRM dates with the note date"] = "Исправьте выбранные несоответствующие даты ГРМ с датой заметки"
    GRM_L["Import all missing join dates from the note date"] = "Импортировать все отсутствующие даты присоединения из даты записи";
    GRM_L["Import selected missing join dates from the note date"] = "Импортировать выбранные отсутствующие даты присоединения из даты записи"
    GRM_L["Add all missing saved dates to the {name}"] = "Добавьте все отсутствующие сохраненные даты в {name}";
    GRM_L["Add selected missing saved dates to {name}"] = "Добавить выбранные отсутствующие сохраненные даты в {name}"
    GRM_L["Clear all join dates from incorrect note locations"] = "Удалить все даты присоединения из неправильных мест для заметок"
    GRM_L["Clear selected join dates from incorrect note locations"] = "Удалить выбранные даты присоединения из неправильных мест для заметок"
    GRM_L["Not Found"] = "Не найдено"
    GRM_L["Not Set"] = "Не выбранно"
    GRM_L["Complete"] = "Завершить"
    GRM_L["Multiple"] = "Множественный"
    GRM_L["Location"] = "Расположение"

    -- JD tool button actions and tooltips
    GRM_L["|CFFE6CC7FShift-Click|r Second Button to Select All In-Between"] = "|CFFE6CC7FShift-Клик|r Вторая кнопка для выбора всего промежуточного"
    GRM_L["|CFFE6CC7FClick|r to select player"] = "|CFFE6CC7FКлик|r для выбора игрока"
    GRM_L["Only Show Players With Incomplete Status"] = "Показывать только игроков с неполным статусом"
    GRM_L["{num} Join Dates Need Attention"] = "{num} дат регистраций требуют внимания"             -- In other words, "155 join dates need attention" as an example
    GRM_L["Do you really want to remove the join dates from notes other than the {name}?"] = "Вы действительно хотите удалить даты присоединения из других заметок, кроме {name}?"
    GRM_L["Do you really want to fix mismatched dates using the note?"] = "Вы действительно хотите исправить несовпадающие даты с помощью заметки?"
    GRM_L["Do you really want to fix note dates using the saved GRM dates?"] = "Вы действительно хотите исправить даты заметок, используя сохраненные даты ГРМ?"
    GRM_L["Do you really want to add the missing join dates to the {name}?"] = "Вы действительно хотите добавить недостающие даты присоединения к {name}?  "                   -- add the missing join dates to the default note name - like "... to the Officer Note?"
    GRM_L["Auto-adding join dates to the {name} is disabled. Do you still wish to continue?"] = "Автоматическое добавление дат присоединения к {name} отключено. Вы все еще хотите продолжить?"    -- Just as above
    GRM_L["There are currently {num} mismatched dates to fix"] = "В настоящее время необходимо исправить несоответствующие даты: {num}"
    GRM_L["There are currently no mismatched dates that need to be fixed."] = "В настоящее время нет несовпадающих дат, которые необходимо исправить."
    GRM_L["There are currently no dates that need to be imported."] = "В настоящее время нет дат, которые нужно импортировать."
    GRM_L["There are currently no dates that can be added to the default note."] = "В настоящее время нет дат, которые можно добавить в заметку по умолчанию."
    GRM_L["There are currently no dates that need to be removed from incorrect notes"] = "В настоящее время нет дат, которые нужно удалить из неправильных заметок"
    GRM_L["There are currently {num} players who have join dates listed in the incorrect note"] = "В настоящее время есть {num} игроков, даты присоединения которых указаны в неправильном примечании."
    GRM_L["Warning! Your function is extremely limited without officer permissions"] = "Предупреждение! Ваша функция чрезвычайно ограничена без разрешения офицера"
    GRM_L["Advanced Join Date Tool" ] = "Расширенный инструмент даты регистрации"

    -- JD tool reasons
    GRM_L["Mismatched dates"] = "Несоответствующие даты"
    GRM_L["Matching date found in wrong note location"] = "Соответствующая дата найдена не в том месте заметки"
    GRM_L["Date not added to note"] = "Дата не добавлена в заметку"
    GRM_L["Mismatched dates, and found in wrong note location"] = "Несовпадающие даты и обнаружены в неправильном месте заметки"
    GRM_L["Mismatched date found in multiple locations, including correct"] = "Несоответствующая дата обнаружена в нескольких местах, включая правильную"
    GRM_L["Mismatched date found in multiple incorrect note locations"] = "Несоответствующая дата обнаружена в нескольких неправильных местах записи"
    GRM_L["Matching date found in multiple incorrect note locations"] = "Соответствующая дата найдена в нескольких неправильных местах записи"
    GRM_L["Matching date found in multiple locations, including correct"] = "Соответствующая дата найдена в нескольких местах, включая правильные"
    GRM_L["Date found in incorrect note, but not yet imported"] = "Дата найдена в неправильной заметке, но еще не импортирована"
    GRM_L["Date found in multiple incorrect notes, but not yet imported"] = "Дата найдена в нескольких неверных заметках, но еще не импортирована"
    GRM_L["Date found in multiple locations, including correct, but not yet imported"] = "Дата найдена в нескольких местах, включая правильную, но еще не импортированную"
    GRM_L["Date found in correct note location, but not yet imported"] = "Дата найдена в правильном месте заметки, но еще не импортирована"

    -- More misc.
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been set to be added to join date note entries."] = "Теги \"{name}\" и \"{name2}\" глобально настроены для добавления в записи примечаний к дате присоединения."
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been disabled from adding to join date note entries."] = "Теги \"{name}\" и \"{name2}\" глобально отключены от добавления в записи примечаний к дате присоединения."
    GRM_L["Your rank has changed. Re-evaluating sync permissions."] = "Ваше звание изменилось. Переоценка разрешений на синхронизацию."
    
    -- 1.57
    GRM_L["Full Log Message:"] = "Сообщение полного журнала:"
    GRM_L["Log Entry Tooltip"] = "Подсказка о записи в журнале"
    GRM_L["1 entry has been removed from the log"] = "1 запись удалена из журнала"
    GRM_L["{num} entries have been removed from the log"] = "{num} записей(си) были удалены из журнала"
    
    -- 1.58
    GRM_L["|CFFE6CC7FCtrl-Click|r to open the Old Guild Roster Window"] = "|CFFE6CC7FCtrl-Клик|r, чтобы открыть окно состава старой версии гильдии"
    
    -- 1.59
    GRM_L["Adding the Join Date cannot be disabled due to the global setting"] = "Добавление даты присоединения нельзя отключить из-за глобальной настройки"
    GRM_L["Due to your current rank, you will be unable to add Join Date Timestamps"] = "Из-за вашего текущего ранга вы не сможете добавлять отметки времени для даты присоединения."
    GRM_L["Warning! Due to your rank you will be unable to add Join Date timestamps to the {name}"] = "Предупреждение! Из-за вашего ранга вы не сможете добавлять отметки времени даты присоединения к {name}"
    GRM_L["Unable to Modify Format:  {name}"] = "Невозможно изменить формат: {имя}"
    GRM_L["Show Mouseover"] = "Показать по курсору"
    GRM_L["Unable to create GRM hotkey macro. You currently are at the cap of {num} macros."] = "Невозможно создать макрос горячих клавиш ГРМ. В настоящее время у вас максимальное количество макросов: {num}."
    
    -- 1.60
    GRM_L["Really remove {name} Backup Point?"] = "Действительно удалить точку резервного копирования {name}?"      -- The {name} is the guildName
    
    -- 1.63
    GRM_L["Disabled"] = "Отключен"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays January to December"] = "|CFFE6CC7FКлик|r для сортировки дней рождений с января по декабрь"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays December to January"] = "|CFFE6CC7FКлик|r для сортировки дней рождений с декабря по январь"
    
    -- 1.64
    GRM_L["Chat Window for All GRM Messages:"] = "Окно чата для всех сообщений ГРМ:"
    GRM_L["\"{name}\" Chat Window\nDo you wish to create it?" ] = "\"{name}\" Окно чата\nВы хотите его создать?"              -- the \n indicates a line break.
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you close this one."] = "ГРМ автоматически отправит сообщения в окно \"{name}\", если вы закроете это окно."
    GRM_L["Channel Settings Are Character Specific and Will Not Be Sync'd"] = "Настройки канала зависят от конкретного персонажа и не синхронизируются"
    
    -- 1.66
    GRM_L["Custom Join Tag:"] = "Пользовательский тег присоединения:\n"
    GRM_L["Custom Rejoin Tag:"] = "Пользовательский тег повторного присоединения:\n"
        -- Join Tag
    GRM_L["Custom Join Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "Пользовательский тег даты присоединения \"{name}\" не может быть установлен, так как он состоит из {num} символов. Максимальное значение: {custom1}."
    GRM_L["Custom Join Tag has been changed from \"{name}\" to \"{name2}\""] = "Пользовательский тег соединения изменен с \"{name}\" на \"{name2}\""
    GRM_L["Custom Join Tag has been set to \"{name}\""] = "Пользовательский тег присоединения установлен на \"{name}\""
    GRM_L["Your Guild Leader has changed the Custom Join Tag from \"{name}\" to \"{name2}\""] = "Ваш лидер гильдии изменил пользовательский тег присоединения с \"{name}\" на \"{name2}\""
    GRM_L["Your Guild Leader has set the Custom Join Tag to \"{name}\""] = "Ваш лидер гильдии установил для настраиваемого тега присоединения значение \"{name}\""
        -- Rejoin Tag
    GRM_L["Custom Rejoin Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "Пользовательский тег даты повторного присоединения \"{name}\" не может быть установлен, так как он состоит из {num} символов. Максимальное значение: {custom1}."
    GRM_L["Custom Rejoin Tag has been changed from \"{name}\" to \"{name2}\""] = "Пользовательский тег повторного присоединения изменен с \"{name}\" на \"{name2}\""
    GRM_L["Custom Rejoin Tag has been set to \"{name}\""] = "Пользовательский тег повторного присоединения установлен на \"{name}\""
    GRM_L["Your Guild Leader has changed the Custom Rejoin Tag from \"{name}\" to \"{name2}\""] = "Ваш лидер гильдии изменил пользовательский тег для повторного присоединения с \"{name}\" на \"{name2}\""
    GRM_L["Your Guild Leader has set the Custom Rejoin Tag to \"{name}\""] = "Ваш лидер гильдии установил для настраиваемого тега повторного присоединения значение \"{name}\""
    
     -- 1.67
    -- Note, lots of plural/singular forms here for just a superior user experience, albeit a bit of extra work
    GRM_L["Kick"] = "Кик"
    GRM_L["Promote"] = "Повышение"
    GRM_L["Demote"] = "Понижение"
    GRM_L["Macro:"] = "Макроc:"
    GRM_L["Macro Size: {num}/255"] = "Размер макроса: {num}/255"         -- "Macro Size: 242/255"
    GRM_L["Action"] = "Действие"
    GRM_L["Ignored Action:"] = "Игнорированное действие"                 -- As in, the action being ignored, be it kick or promote or demote. 
    GRM_L["Click to Build Macro"] = "Клик для создания макроса"
    GRM_L["No Current Names to Add"] = "Нет подходящих имен для добавления"
    GRM_L["No Names to Add to the Macro"] = "Нет имен для добавления к макросу"
    GRM_L["Hot Key: {name}"] = "Горячая клавиша: {name}"
    GRM_L["Permissions"] = "Возможные действия"
    GRM_L["Player rank change detected, re-checking permissions and rebuilding GRM Macro Tool."] = "Обнаружено изменение рейтинга игроков, повторная проверка разрешений и восстановление ГРМ макро-тулза."
    GRM_L["Click to remove selected names from the macro"] = "Нажмите, чтобы удалить выбранные имена из макроса"           -- Plural form of statement
    GRM_L["Click to remove selected name from the macro"] = "Нажмите, чтобы удалить выбранное имя из макроса"           -- Singular form of statement
    GRM_L["Click to remove selected names from Ignore List"] = "Нажмите, чтобы удалить выбранные имена из списка игнорирования"         -- Plural
    GRM_L["Click to remove selected name from Ignore List"] = "Нажмите, чтобы удалить выбранное имя из списка игнорирования"          -- Singular
    GRM_L["No names selected to remove from macro"] = "Имена для удаления из макроса не выбраны"
    GRM_L["No names selected to remove from Ignore List"] = "Имена не выбраны для удаления из списка игнорирования"
    GRM_L["Macro is currently empty"] = "Макрос в настоящее время пуст"
    GRM_L["{num} players removed from the macro"] = "{num} игроков удалены из макроса"                    -- plural form of the statement
    GRM_L["{num} player was removed from the macro"] = "{num} игрок был удален из макроса"                 -- singular form of the statement
    GRM_L["{num} players removed from the Ignored List"] = "{num} игроков удалены из списка игнорируемых"
    GRM_L["{num} player was removed from Ignore List"] = "{num} игрок удален из списка игнорирования"
    GRM_L["There are no names currently selected to be removed from the Ignore List."] = "В настоящее время нет выбранных имен для удаления из списка игнорирования."
    GRM_L["There are no names currently selected to be removed from the macro."] = "В данный момент нет выбранных имен для удаления из макроса."
    GRM_L["The macro is not yet built. Please click the button to create the macro."] = "Макрос еще не построен. Нажмите кнопку, чтобы создать макрос."
    GRM_L["Nothing to clear"] = "Нечего очищать"
    GRM_L["There are currently no names to add"] = "В настоящее время нет имен для добавления"
    GRM_L["There are currently no names to remove"] = "В настоящее время нет имен для удаления"
    GRM_L["Rules"] = "Правила"
    GRM_L["Please choose a day between 1 and 99"] = "Пожалуйста, выберите от 1 до 99 дней"
    GRM_L["Pressing the ESC key will also clear all lines"] = "Нажатие клавиши ESC также очищает все строки"
    GRM_L["Player's rank does not have permission to remove others from the guild"] = "Ранг игрока не позволяет удалять других из гильдии"
    GRM_L["Player's rank does not have permission to promote others in the guild"] = "Ранг игрока не позволяет повышать других игроков в гильдии"
    GRM_L["Player's rank does not have permission to demote others in the guild"] = "Ранг игрока не позволяет понижать в звании."
    GRM_L["Queued Actions"] = "Действия в очереди"
    GRM_L["Current Actions"] = "Текущие действия"
    GRM_L["View Ignore List"] = "Просмотреть список игнорирования"
    GRM_L["No players are currently safe from recommendations"] = "В настоящее время никто из игроков не застрахован от рекомендаций"
    GRM_L["1 player is on the safe list."] = "1 игрок находится в безопасном списке."
    GRM_L["{num} players are on the safe list."] = "{num} игроков находятся в безопасном списке."
    GRM_L["1 action is being ignored."] = "1 действие игнорируется."
    GRM_L["{num} actions are being ignored."] = "{num} действий игнорируются."
    GRM_L["No current actions are being ignored"] = "Никакие текущие действия не игнорируются"
    GRM_L["Actions Ignored:"] = "Действия игнорируются:"
    GRM_L["Total Queued:"] = "Всего в очереди:"
    GRM_L["Ignored Players Safe From Action"] = "Игнорируемые игроки защищены от действий"
    GRM_L["Only show players with ignored action"] = "Показывать только игроков с проигнорированными действиями"
    GRM_L["No players on Ignore List"] = "В списке игнорирования нет игроков"
    GRM_L["No players to select. 1 player filtered"] = "Нет игроков для выбора. 1 игрок отфильтрован"                     -- Singular
    GRM_L["No players to select. {num} players filtered"] = "Нет игроков для выбора. Отфильтровано {num} игроков"                -- Plural
    GRM_L["There are no names to select. 1 player is filtered"] = "Нет имен для выбора. 1 игрок отфильтрован"         -- these 2 statements might seem redundant, but often the text on a button is more short hand. This gives a cleaner statement in the chat. Useful for translating in some languages that need a bit more room to be more clear.
    GRM_L["There are no names to select. {num} players are filtered"] = "Нет имен для выбора. {num} игроков отфильтрованы"
    GRM_L["Really remove selected player from the ignore list?"] = "Действительно удалить выбранного игрока из списка игнорирования?"
    GRM_L["Really remove the {num} selected players from the ignore list?"] = "Действительно удалить {num} выбранных игроков из списка игнорирования?"
    GRM_L["Do you really wish to clear all players from the Ignore List?"] = "Вы действительно хотите удалить всех игроков из списка игнорирования?"
    GRM_L["There are currently no players on the Ignore List"] = "В настоящее время в списке игнорирования нет игроков"
    GRM_L["Remove all players from Ignore List"] = "Удалить всех игроков из списка игнорирования"
    GRM_L["Ignored Players: {num}"] = "Игнорируемые игроки: {num}"
    GRM_L["Tool"] = "Инструмент"                                          -- /grm tool
    GRM_L["Macro Tool"] = "Макро-тулз"
    GRM_L["Macro Tool: {num}"] = "Макро-тулз: {num}"

    -- CLASSIC
    GRM_L["Social"] = "Социальное"
    GRM_L["Roster"] = "Состав"
    GRM_L["Feature is disabled in WoW Classic"] = "Функция отключена в WoW Classic"
    GRM_L["Feature is disabled in TBC Classic"] = "Функция отключена в WoW TBC"        -- Just laying groundwork now in case Blizz ever releases it. Calendar was not added until WOTLK
    GRM_L["(Classic)"] = "(Класика)"       -- tooltip tag that shows only on the minimap mosueover version tooltip in Classic
    
    -- 1.69
    GRM_L["Importing dates must be done in a compatible format"] = "Даты импорта должны быть выполнены в совместимом формате."
    GRM_L["The date selection in OPTIONS shows all supported"] = "Выбор даты в опциях показывает все поддерживаемые"
    GRM_L["Headers, like \"Joined,\" are supported"] = "Заголовки, такие как \"Входит\", поддерживаются."
    GRM_L["To confirm or edit the date, open the player window, right click the date, edit, and submit"] = "Чтобы подтвердить или изменить дату, откройте окно игрока, щелкните дату правой кнопкой мыши, отредактируйте и отправьте."        --The "!!" tags are the {name}
    GRM_L["To confirm or edit the date, right click the date, edit, and submit"] = "Чтобы подтвердить или изменить дату, щелкните дату правой кнопкой мыши, отредактируйте и отправьте     -- Slightly shorter explanation if already on player window"
    GRM_L["The {name} tag indicates a date must be verified to sync"] = "Тег {name} указывает, что дату необходимо подтвердить для синхронизации."

    -- 1.70
    GRM_L["GRM has errored due to a previous incompatible build with Classic that was enabled. Click YES to reload UI and fix the issue"] = "В ГРМ возникла ошибка из-за того, что предыдущая сборка несовместима с включенной классической версией. Нажмите ДА, чтобы перезагрузить пользовательский интерфейс и устранить проблему."

    -- 1.71
    GRM_L["(Disabled in Classic)"] = "(Отключено в классической версии)"           -- For the Options... rather than removing them all

    -- 1.73
    GRM_L["{name} is no longer in the Guild!"] = "{name} больше не состоит в Гильдии!"       -- There should really be 3 options. They got kicked, they left on their own, or if not found in the event log, they are just no longer in the guild
    GRM_L["is no longer in the Guild!"] = "больше не в гильдии!"              -- THIS MUST MATCH THE PREVIOUS LINE with missing name.
    GRM_L["Applying update patches... one moment."] = "Применяем патчи обновления... минутку."
    GRM_L["Update Complete... {num} patches applied."] = "Обновление завершено... Применено патчей: {num}."   -- Plural
    GRM_L["Update Complete... 1 patch applied."] = "Обновление завершено... Применен 1 патч."         -- Singular version
    GRM_L["Disabling will also hide the Birthday info on the roster mouseover window"] = "Отключение также скроет информацию о дне рождения в окне наведения курсора."       -- Enable/disable birthday chekbox on UI Options and the Audit windoppw
    GRM_L["To avoid addon taint/blocking errors in Classic, the player must manually open the Guild Roster tab the first time."] = "Чтобы избежать ошибок/блокировки аддонов в Classic, игрок должен вручную открыть вкладку «Список гильдии» в первый раз."          -- Classic only message for players explaining why window cannot open automatically.
    GRM_L["Confirm Date"] = "Подтвердить дату"
    GRM_L["If the date is accurate, right click and select 'Confirm Date'"] = "Если дата точная, щелкните правой кнопкой мыши и выберите «Подтвердить дату»."
    
     -- 1.74
    GRM_L["Class Colorize Names in Guild Member Alerts"] = "Раскрашивание имен классов в оповещениях членов гильдии"
    GRM_L["All player custom notes re-enabled for sync and their checkboxes set."] = "Все пользовательские заметки игрока повторно включены для синхронизации, и их флажки установлены."
    
    -- 1.75
    GRM_L["!note"] = "!note"               -- !note in English will always work. This gives you the option of creating your own key to register a public note.
    GRM_L["No officer online to set {name}'s note"] = "Нет в сети офицера, который мог бы добавить заметку {name}"
    GRM_L["No officer is currently online to update your note"] = "В настоящее время нет офицеров, которые могли бы обновить вашу заметку"
    GRM_L["Allow Guild Members to Type \"!note\" to Set Their Own Public Note"] = "Разрешить членам гильдии набирать \"!note\" для создания собственной публичной заметки"
    GRM_L["Enabled"] = "Включено"         -- As in, the opposite of Disabled
    GRM_L["'!note' trigger has been globally ENABLED"] = "Триггер '!note' глобально ВКЛЮЧЕН"
    GRM_L["'!note' trigger has been globally DISABLED"] = "Триггер '!note' глобально ОТКЛЮЧЕН"

    -- 1.76
    GRM_L["Same Rank"] = "Тот же ранг"                                                                   -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Higher Rank"] = "Более высокий ранг"                                                                 -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Limited Features. There is no Calendar in Classic"] = "Ограниченные возможности. В классической версии нет календаря"                         -- Events Tab top warning
    GRM_L["This only affects settings for your current guild: {name}"] = "Это влияет только на настройки вашей текущей гильдии: {name}"                   -- Tooltip for Options > General > Sync settings to all alts in same guild
    GRM_L["GC"] = "ГК"                                                                          -- Options window, acronym for "Global Controls" and will be adjacent to all settings that have global controls
    GRM_L["*GC = Global Control - Use Guild Info to Force Setting For All"] = "*ГК = Глобальный контроль - Используйте информацию о гильдии для принудительной настройки для всех"              -- Top left Options window
    GRM_L["Set Global Controls"] = "Установить ГК"                                                      -- Options > Officer Tab > Bottom left export button
    GRM_L["Global Control Values Set in Guild Info"] = "Значения глобального контроля, установленные в информации о гильдии"                                     -- Export GuildInfo tool tooltip
    GRM_L["Configure your settings. Click to set in Guild Info"] = "Настройте свои параметры. Нажмите, чтобы добавить теги в информацию о гильдии"                                    -- Tooltip line 2- same as above
    GRM_L["Unable to add globals controls to GuildInfo. There is not enough room."] = "Невозможно добавить глобальные элементы управления в информацию о гильдии. Недостаточно места."      -- If export of globals is not able to complete
    GRM_L["Global controls exported to the guild info note. Updating..."] = "Глобальные элементы управления экспортированы в информационную заметку гильдии. Обновление..."                -- Success in exporting
    GRM_L["Your rank cannot edit the Guild Info"] = "Ваш ранг не может редактировать информацию о гильдии"                                              -- Mouseover tooltip helper for people without MOTD edit access
    GRM_L["All global controls are already set. You must Edit or Remove the settings manually in the guild Info."] = "Все глобальные элементы управления уже установлены. Вы должны изменить или удалить настройки вручную в информации о гильдии.";
    GRM_L["Do you really want to wipe all GRM data and settings account-wide?"] = "Вы действительно хотите стереть все данные и настройки ГРМ для всей учетной записи?"
    GRM_L["Are you sure your settings are configured and ready for global controls?"] = "Вы уверены, что ваши настройки настроены и готовы к глобальному контролю?"
    GRM_L["Players the same rank or higher will not be shown"] = "Игроки Вашего ранга или выше не будут отображаться"
    GRM_L["Macro"] = "Макро"       -- For the slash command  /grm tool or /grm macro - same thing

    	-- 1.77
	GRM_L["Add Custom Rule"] = "Добавить условие"         -- Kick Macro Tool - custom rule button right side
	GRM_L["Former Members"] = "Бывшие члены"          -- Export tool
	GRM_L["Data Export"] = "Экспорт данных"
	GRM_L["*Max Export is 500 Log Entries at a Time"] = "*Максимальный экспорт - 500 записей журнала за раз"
	GRM_L["*Max Export is 500 Members at a Time"] = "*Максимальный экспорт - 500 участников за раз"
	GRM_L["*Max Export is 500 Former Members at a Time"] = "*Максимальный экспорт - 500 бывших участников за раз"
	GRM_L["*Export obeys the current log display filters"] = "*Экспорт подчиняется фильтрам отображения текущего журнала"
	GRM_L["Select Line Range:"] = "Выберите диапазон строк:"
	GRM_L["Select Member Range:"] = "Выберите диапазон членов:"
	GRM_L["Export Selection"] = "Экспорт выделенного"
	GRM_L["Export Next {num}"] = "Экспорт следующего {num}"       -- As in, "Export next 500" names or log lines
	GRM_L["Export Prev {num}"] = "Экспорт предыдущего {num}"       -- As in, Export Previous name
	GRM_L["Total Members: {num}"] = "Всего участников: {num}"
	GRM_L["Total Former Members: {num}"] = "Всего бывших участников: {number}"
	GRM_L["Class"] = "Класс"                       -- As in Class Name, there is currently a "Class:" we need one with the colon
	GRM_L["Guild Rep"] = "Репутация в гильдии"                  -- Guild Faction reputation (abbreviated)
	GRM_L["Last Online (Days)"] = "Последний онлайн (дни)"
	GRM_L["Spreadsheet Headers"] = "Заголовки электронных таблиц"
	GRM_L["Auto Include Headers"] = "Автоматически включать заголовки"        -- Auto include headers on the export frame, as in the column headers for each category on member and former mebers
	GRM_L["These will only be included if exporting from the top of the table"] = "Они будут включены только в случае экспорта из верхней части таблицы."      -- tooltip for the auto-Included export checkbutton
	GRM_L["Export"] = "Экспорт"
	GRM_L["This will be rounded to the nearest day"] = "Будет округлено до ближайшего дня."
	GRM_L["Clearing Log Export. A filter setting has been changed."] = "Очистка экспорта журнала. Изменен параметр фильтра."             -- If the filter settings have been modified, the export string should be cleared and re-done
	GRM_L["No Tag"] = "Без тега"                                                              -- Main Tag
	GRM_L["Delimiter:"] = "Разделитель:"                                                         -- Delimiter selection for Export window
	GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7FCКлик|r, для просмотра дополнительных сведений."                         -- Calendar tooltip
	GRM_L["The selected delimiter will be removed from all notes on export"] = "Выбранный разделитель будет удален из всех заметок при экспорте"
	GRM_L["Choose thoughtfully"] = "Выбирайте осторожнее"
	GRM_L["{name}'s note has been updated!"] = "Заметка пользователя {name} обновлена!"
	GRM_L["Locked. Press ESC"] = "Заблокированно. Нажмите ESC"                                        -- Mouseover Locked text in top right.
	GRM_L["{num} guild members have outdated GRM versions"] = "У {num} членов гильдии устаревшие версии ГРМ"                      -- Player sync with another is outdated
    GRM_L["|CFFE6CC7FClick|r to Select for Removal"] = "|CFFE6CC7FКлик|r чтобы выбрать для удаления"
    GRM_L["Feel free to recommend a delimiter you wish to use to the author"] = "Вы можете порекомендовать автору разделитель, который хотите использовать."
    GRM_L["Export Tool"] = "Инструмент экспорта"
    GRM_L["Opens the Data Export Tool"] = "Открывает инструмент экспорта данных"
    GRM_L["Opens the Advanced Macro Tool"] = "Открывает продвинутый макро тулз"
    
    -- 1.78
    GRM_L["Hurray!"] = "Ура!"                                                              -- A short cheer! Like "Yay!" except "Hurray!"
    GRM_L["{name} has Reached the {num} Level Cap! {custom1}"] = "{name} достиг максимального уровня {num}! {custom1}"                 -- Arkaan has Reached the 120 Level Cap! Hurray!

    -- 1.80
    GRM_L["Core Window:"] = "Основное окно:"
    GRM_L["Mouseover Player Details:"] = "Сведения об игроке при наведении указателя мыши:"
    GRM_L["Macro Tool:"] = "Инструмент макроса:"
    GRM_L["Export Tool:"] = "Инструмент экспорта:"
    GRM_L["Audit Join Date Tool:"] = "Инструмент проверки даты регистрации:"
    GRM_L["GRM UI Scale"] = "ГРМ UI Масштаб"
    GRM_L["Right-Click to Reset"] = "Щелкните правой кнопкой мыши для сброса"
    GRM_L["Open the Mouseover Window to see immediate scaling changes"] = "Откройте окно наведения мыши, чтобы увидеть немедленные изменения масштабирования"
    GRM_L["Open the Macro Tool Window to see immediate scaling changes"] = "Откройте окно инструментов макроса, чтобы увидеть немедленные изменения масштабирования."
    GRM_L["The Export Tool is connected to the Core window scaling"] = "Инструмент экспорта связан с масштабированием основного окна"
    GRM_L["This provides additional scaling controls on just this window"] = "Это обеспечивает дополнительные элементы управления масштабированием только в этом окне."
    GRM_L["Open the Export Tool Window to see immediate scaling changes"] = "Откройте окно инструмента экспорта, чтобы увидеть немедленные изменения масштабирования."
    GRM_L["WARNING: Clear the text box before re-scaling or you may lock up your system"] = "ВНИМАНИЕ: очистите текстовое поле перед изменением масштаба, иначе вы можете заблокировать систему."
    GRM_L["Resets ALL settings, not just the ones on this page"] = "Сбрасывает ВСЕ настройки, а не только те, что на этой странице"
    GRM_L["Open MouseOver"] = "Открыть MouseOver"
    GRM_L["Open Macro Tool"] = "Открыть инструмент макроса"
    GRM_L["Open Export Tool"] = "Открыть инструмент экспорта"
    GRM_L["Open Join Date Tool"] = "Открыть инструмент даты регистрации"

    -- 1.81
    GRM_L["Race"] = "Расса"
    GRM_L["Sex"] = "Пол"
    GRM_L["Male"] = "Мужчина"
    GRM_L["Female"] = "Женщина"
    GRM_L["{name} {name2}"] = "{name} {name2}"          -- This might seem weird, but the format is "Race Sex" In other words, "Orc Male" or "Nightborne Female" and so on. Adjust how you see fit, it appears in the mouseover tooltip on the player name
    
    -- 1.82
    GRM_L["Disabled While Player is Grouped"] = "Отключено, пока вы в группе"
    GRM_L["SYNC is currently disabled while you are grouped. Due to server restricted addon to addon talk data caps, and in an effort to avoid clogging up the shared global comm space of all addons, sync will be temporarily restricted while grouped."] = "Синхронизация в настоящее время отключена, пока вы в группе. Из-за ограниченного сервером надстройки для ограничений данных разговоров надстройки и во избежание засорения общего глобального пространства связи всех надстроек синхронизация будет временно ограничена пока вы находитесь в группе/рейде."

     -- 1.84
     GRM_L["The note is too long. Only the first {num} characters will be set."] = "Заметка слишком длинная. Будут установлены только первые {число} символов."
     GRM_L["Apply Only to Selected Ranks"] = "Применить только к выбранным званиям"
     GRM_L["Unable to create hotkey macro. Player is currently in combat and action is restricted. It will auto-build once out of combat."] = "Невозможно создать макрос горячих клавиш. Игрок сейчас находится в бою, и действия ограничены. Он будет автоматически построен после выхода из боя."
     GRM_L["No player data found, recommend full removal."] = "Данные игрока не найдены, рекомендуется полное удаление."
     GRM_L["OR"] = "или"      -- "Or" as in  This OR that  Use this button OR that button -- Advanced JD audit tool.
     GRM_L["Use Promo Date"] = "Использовать ату события"
     GRM_L["Use Join Date"] = "Использовать дату присоединения"
     GRM_L["Send to Promo Date"] = "Отправить на дату события"
     GRM_L["Send to Join Date"] = "Отправить на дату присоединения"
     GRM_L["(Press Tab to Cycle)"] = "(Нажмите Tab для цикла)"
     GRM_L["(Press Enter to Select)"] = "(Нажмите Enter, чтобы выбрать)"
     GRM_L["Setting join date to destination index {num} is not valid. Value must be between 0 and 3. Setting to default of Officer Note."] = "Установка даты присоединения для целевого индекса {num} недопустима. Значение должно быть от 0 до 3. Значение по умолчанию из офицерской заметки."
     GRM_L["Join Dates Globally Changed to no longer be added to the note when a player joins the guild"] = "Даты присоединения глобально изменены: теперь они больше не будут добавляться в заметку, когда игрок присоединяется к гильдии."
     GRM_L["Your Guild Leader has disabled adding join dates to player notes"] = "Ваш лидер гильдии отключил добавление дат присоединения к заметкам игроков"
     GRM_L["Unable to Modify. Global setting DISABLES adding the join date automatically. "] = "Невозможно изменить. Глобальная настройка отключает автоматическое добавление даты присоединения."
     GRM_L["General Sync"] = "Общая синхронизация"
     GRM_L["Ban Sync"] = "Бан синхронизация"
     GRM_L["Custom Sync"] = "Пользовательская синхронизация"
     GRM_L["Auto Join date"] = "Дата автоматического присоединения"
     GRM_L["Include Headers"] = "Включить заголовки";
     GRM_L["Join Header"] = "Присоединиться к заголовку";
     GRM_L["ReJoin Header"] = "Перезаход в ги";
     GRM_L["!note Control"] = "!note контроль"
     GRM_L["You need to clear {num} characters to fit the control tags"] = "Необходимо очистить символы {num}, чтобы они соответствовали тегам управления."
     GRM_L["A new format exists for global settings controls."] = "Для элементов управления глобальными настройками существует новый формат."
     GRM_L["Go to GRM window > Options > Officer Tab > \"Set Global Controls\""] = "Перейдите в окно ГРМ> Параметры> вкладка Офицер> \"Установить глобальные элементы управления\""
     GRM_L["Remove the old format when all guildies have updated properly. You may wish to leave it in Guild Info until then."] = "Удалите старый формат, когда все гильдии обновятся должным образом. Вы можете оставить его в информации о гильдии до тех пор."
     GRM_L["It may take up to 60 seconds for other guild members to detect the changes and update."] = "Другим членам гильдии может потребоваться до 60 секунд, чтобы обнаружить изменения и обновить."
     GRM_L["Ctrl-Shift-Click"] = "Ctrl-Shift-Клик"
     GRM_L["Resets only the settings on this page"] = "Сбросить только настройки на этой странице"
     GRM_L["Resets only the Export Settings"] = "Сбросить только настройки экспорта"
     GRM_L["Resets all Macro Tool Rules and Settings"] = "Сбросить все правила и настройки макросов"
     GRM_L["Are you sure you want to reset all Macro Tool Rules and Settings?"] = "Вы уверены, что хотите сбросить все правила и настройки макросов?"
     GRM_L["Export settings to unify sync controls, timestamp format, and so on with your officers and members."] = "Параметры экспорта для унификации элементов управления синхронизацией, формата отметок времени и т.п. с вашими офицерами и участниками."
     GRM_L["Consult with your guild leader and export settings to unify sync controls, timestamp format, and so on."] = "Проконсультируйтесь с лидером гильдии и настройте параметры экспорта, чтобы унифицировать элементы управления синхронизацией, формат метки времени и т.п."
     GRM_L["Global controls have not yet been set!"] = "Глобальные элементы управления еще не установлены!"
     GRM_L["Include Birthdays as Incomplete"] = "Включить дни рождения как неполные"
     GRM_L["Make room and transfer before clearing"] = "Освободите место и перенесите перед очисткой"
     GRM_L["1 player has a join date listed in the incorrect note. The default location is full"] = "Дата присоединения у одного игрока указана в неправильном примечании. Местоположение по умолчанию заполнено "            -- Singular (Join Date Audit tool - bottom button mouseover) - rare tooltip use
     GRM_L["{num} players have join dates listed in the incorrect note. The default location is full"] = "Даты присоединения {num} игроков указаны в неправильном примечании. Местоположение по умолчанию заполнено"       -- Plural (same)
     GRM_L["Otherwise, {num} notes are ready to be cleared from the incorrect location"] = "В противном случае {num} заметок можно будет удалить из неправильного места."                     -- Plural (same tooltip)
     GRM_L["Otherwise, 1 note is ready to be cleared from the incorrect location"] = "В противном случае одна заметка готова к удалению из неправильного места."                           -- Plural (same tooltip)
     GRM_L["There are currently {num} dates that can be added to the {name}"] = "В настоящее время есть {num} дат, которые можно добавить к {name}"
     GRM_L["The previous action still has 1 recommended task. It is advised to do that first."] = "Предыдущее действие по-прежнему имеет одну рекомендуемую задачу. Рекомендуется сделать это в первую очередь."               -- Singular
     GRM_L["The previous action still has {num} recommended tasks. It is advised to do those first."] = "В предыдущем действии все еще есть рекомендуемые задачи: {num}. Рекомендуется сделать это в первую очередь."         -- Plural
     GRM_L["Step {num}"] = "Шаг {num}"                                                                                      -- Like Step 1 , Step 2 , etc.

     -- 1.86
    GRM_L["What tags look like:"] = "Как выглядят теги:"
    GRM_L["Add Join Date to:"] = "Добавлять дату вербовки в:"
     
    -- R1.87
    GRM_L["|CFFE6CC7FLeft-Click|r to Disable Rule"] = "|CFFE6CC7FНажмите ЛКМ|r для выключения правила"
    GRM_L["|CFFE6CC7FLeft-Click|r to Enable Rule"] = "|CFFE6CC7FНажмите ЛКМ|r для включения правила"
    GRM_L["Edit"] = "Изменить"
    GRM_L["|CFFE6CC7FClick|r to Change the Rule Name"] = "|CFFE6CC7FНажмите|r для изменения имени правила"
    GRM_L["Apply to All Ranks"] = "Применить ко всем званиям"
    GRM_L["Please select at least 1 RANK to apply this rule to."] = "Выберите хотя бы одно звание, к которому будет применяться это правило."
    GRM_L["Apply to All Levels"] = "Применить ко всем уровням"
    GRM_L["Apply Only to Level Range"] = "Применить только к диапазону уровней"
    GRM_L["Level Range:"] = "Диапазон уровней:"
    GRM_L["{num} to {custom1}"] = "от {num} до {custom1}"          -- Example: "Level Range: 100 to 120"
    GRM_L["1 to {num}"] = "1 до {num}"                  -- Same principle.
    GRM_L["Require Text Match"] = "Соответствие текста"
    GRM_L["Click to Set"] = "Нажмите, чтобы установить"
    GRM_L["Inactivity:"] = "Бездействие:"
    GRM_L["Notify if inactive for {num} {name}" ] = "Уведомлять, если неактивен {num} {name}"       -- Notify if inactive for 15 Days  or Notify if inactive for 10 Months
    GRM_L["Rule Filter: {name}"] = "Правило: {name}"
    GRM_L["Ranks:"] = "Звания:"
    GRM_L["All Ranks"] = "Все звания"
    GRM_L["Note Match:"] = "Соответствие заметки:"
    GRM_L["Please Set a Name for this Rule. It can be 1 to 25 characters in length."] = "Задайте имя для этого правила. Длина может составлять от 1 до 25 символов."
    GRM_L["This will also clear all of your saved rules."] = "Это также очистит все ваши сохраненные правила."
    GRM_L["Within Level Range: {num} - {custom1}"] = "В пределах диапазона уровней: {num} - {custom1}"               -- Qued macro tool tooltip
    GRM_L["Note match: {name}"] = "Соответствие заметки: {name}"                               -- Same
    GRM_L["Matching Rank"] = "Соответствующее звание"                                       -- ''
    GRM_L["Right-Click|r to Edit or Remove custom rule"] = "Щелкните ПКМ|r, чтобы изменить или удалить пользовательское правило"         -- Please keep the '|r' immediately after the click info - as it indicates a text color change point
    GRM_L["|CFFE6CC7FClick|r to Change"] = "|CFFE6CC7FНажмите|r для изменения"
    GRM_L["(Applies Only to Classic)"] = "(Только для классической версии)"           -- For the Options... rather than removing them all
    
    -- R1.88
    -- Group Info Module
    GRM_L["GRM Info"] = "ГРМ Информация"
    GRM_L["GRM Group Info"] = "ГРМ Информация о группе"
    GRM_L["Group Info"] = "Информация о группе"
    GRM_L["Click to Lock Info Window"] = "Нажмите, чтобы заблокировать информационное окно"
    GRM_L["Guildies: {num}"] = "Гильдии: {num}"
    GRM_L["Former Guildies: {num}"] = "Бывшие гильдии: {num}"
    GRM_L["Other {name} Members: {num}"] = "Другие {name} Участники: {num}"           -- "Other Zul'jin Members: 5"  - basically just your realm name. This can be useful to know who in your raid is your realm as you can trade more freely.
    GRM_L["Other Connected Realm Members: {num}"] = "Другие подключенные участники сервера: {num}"
    GRM_L["Total in Group: {num}"] = "Всего в группе: {num}"
    GRM_L["Date Left"] = "Дата выхода"
    GRM_L["1 Alt Still in Guild"] = "1 Твинк все еще в гильдии"
    GRM_L["{num} Alts Still in Guild"] = "{num} Твинк все еще в гильдии"
    GRM_L["Known Alts:"] = "Известные твинки:"
    GRM_L["Close Enough to Trade"] = "Достаточно близко для обмена"
    GRM_L["Plugins"] = "Плагины"         -- plural
    GRM_L["Plugin"] = "Плагин"          -- Singular
    GRM_L["Module"] = "Модуль"
    GRM_L["GRM Optional Modules"] = "Дополнительные модули ГРМ"
    GRM_L["Enable Module"] = "Включить модуль"
    GRM_L["Show Interactable Distance Indicator"] = "Показать интерактивный индикатор расстояния"
    GRM_L["No GRM Modules Currently Installed"] = "В настоящее время модули для ГРМ не установлены"
    GRM_L["Custom Color"] = "Пользовательский цвет"
    GRM_L["{name} is listed as the Main"] = "{name} указан как Мейн"
    GRM_L["Kick Banned in Guild"] = "Исключить забаненного в гильдии"
    GRM_L["Kick macro created. Press Hotkey to Remove Banned Players Still in Guild"] = "Создан макрос исключения. Нажмите горячую клавишу, чтобы удалить забаненных игроков, которые все еще находящихся в гильдии"
    GRM_L["Easily remove all Banned players still in the Guild with the Macro Tool"] = "Легко удалите всех забаненных игроков, которые все еще находятся в гильдии, с помощью макро-тулза."
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you remove all custom channels."] = "ГРМ будет автоматически отправлять сообщения в окно \"{name}\", если вы удалите все пользовательские каналы."
    GRM_L["Multi-Channel support. Just separate with commas"] = "Многоканальная поддержка. Просто разделите запятыми"

    -- R1.89
    GRM_L["GRM API Error:"] = "ГРМ АПИ ошибка:"
    GRM_L["The guild name \"{name}\" cannot be found in the database. Ensure proper formatting."] = "Название гильдии \"{name}\" не найдено в базе данных. Убедитесь в правильности написания."
    GRM_L["The player name \"{name}\" cannot be found in the database. Ensure proper spelling."] = "Имя игрока \"{name}\" не найдено в базе данных. Убедитесь в правильности написания."
    GRM_L["Unable to change officer notes at current rank"] = "Невозможно изменить заметки офицера в текущем звании"
    GRM_L["Player is not currently in a Guild"] = "Игрок в настоящее время не состоит в гильдии"
    GRM_L["Mains Only"] = "Только Мейны"
    GRM_L["Alts Only"] = "Только Твинки"
    GRM_L["Custom Public Notes:"] = "Пользовательская заметка:"        -- Updated from "Custom Notes"
    GRM_L["Leave unchecked to export every member of the guild"] = "Не ставьте галочку, чтобы экспортировать каждого члена гильдии"
    GRM_L["Only the 10 most recent rank changes will be included"] = "Будут включены только 10 последних изменений званий."
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} 1 time to complete all actions"] = "Когда вы будете готовы исключить игроков, нажмите горячую клавишу {name} 1 раз, чтобы завершить все действия."
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} {num} times to complete all actions"] = "Когда вы будете готовы  исключать игроков, нажмите горячую клавишу {name} {num} раз, чтобы завершить все действия."
    GRM_L["This only affects GRM tooltips"] = "Это влияет только на всплывающие подсказки ГРМ."
    GRM_L["Unable to remove players from the guild at current rank."] = "Невозможно исключать игроков из гильдии на текущем звании."
    GRM_L["Unable to promote players within the guild at current rank."] = "Невозможно повышать игроков в гильдии с текущим званием."
    GRM_L["Unable to demote players within the guild at current rank."] = "Невозможно понизить уровень игроков в гильдии на текущем звании."
    GRM_L["Feature disabled."] = "Функция отключена."
    GRM_L["Does NOT apply to Ban List"] = "Не применяется к списку банов"
    GRM_L["This only applies to Alt/Main Groupings, Join Dates, Promotion Dates, Birthdates, and Custom Notes."] = "Это относится только к Твинк/Мейн группам, датам присоединения, датам повышения, дням рождения и пользовательским заметкам."
    GRM_L["Custom Notes can be Restricted Further Below"] = "Пользовательские заметки могут быть ограничены ниже"
    GRM_L["All ranks will receive the outgoing player data. Only players of the selected rank or higher can modify and share that data."] = "Все звания получат исходящие данные игрока. Только игроки с выбранным званием или выше могут изменять эти данные и делиться ими."
    GRM_L["Always open to selected tab:"] = "Всегда открывать на выбранной вкладке:"
    GRM_L["{num} guild members have incomplete info."] = "{num} членов гильдии не имеют полной информации."
    GRM_L["Just 1 guild member still has incomplete info. Great job!"] = "Только 1 член гильдии все еще не имеет полной информации. Прекрасная работа!"
    GRM_L["No Audit Necessary! Great Work!"] = "Аудит не требуется! Отличная работа!"
    GRM_L["GRM Audit Report:"] = "Отчет об аудите:"                                                               -- Appears after the player's first sync that game secssion.
    GRM_L["100% complete. Great work!"] = "Выполнено на 100%. Отличная работа!"
    GRM_L["{num}% complete."] = "заполнено информации {num}%."
    GRM_L["Only 1 member with incomplete data."] = "Только 1 игрок с неполными данными."     -- singular phrase
    GRM_L["{num} members with incomplete data."] = "{num} игрока(ов) с неполными данными."     -- plural version of it
    GRM_L["Colorize Names on Roster and Chat Window to Match Class"] = "Раскрасить имена в списке и окне чата, чтобы они соответствовали классу"
    GRM_L["Only Match Empty Notes"] = "Учитывать только пустые заметки"
    -- macro Tool
    GRM_L["Empty Note match: {name}"] = "Пустая {name} заметка"
    GRM_L["Empty Notes"] = "Пустые заметки"
    GRM_L["Public"] = "Публичная"
    GRM_L["Custom"] = "Пользовательская"
    GRM_L["Apply Rules to:"] = "Применить правила к:"         -- Macro tool rule (top selection)
    GRM_L["All"] = "Все"                     -- As in, apply to everyone.
    GRM_L["Player is an Alt"] = "Игрок - Твинк"
    GRM_L["Player is a Main"] = "Игрок - Мейн"
    GRM_L["This only applies to KNOWN alts. Unconfigured will be excluded."] = "Это относится только к ИЗВЕСТНЫМ альтам. Ненастроенные будут исключены."
    GRM_L["Main/Alt: {name}"] = "Мейн/Твинк: {name}"
    GRM_L["Kick Players at Selected Rank(s) after"] = "Кикать игроков в выбранных званиях после"
    GRM_L["Use Cautiously. Applies to all at rank, regardless of being active or inactive."] = "Используйте осторожно. Применяется ко всем в звании, независимо от того, активен он или нет."
    GRM_L["This will only apply to players with verified promotion dates."] = "Это будет применяться только для игроков с проверенными датами продвижения."
    GRM_L["Time at Rank: {name}"] = "Время в звании: {name}"
    GRM_L["Notify if at Rank for {num} {name}"] = "Сообщите, если в звании для {num} {name}"      -- "Notify if at Rank for 30 Days" or "Notify if at Rank for 12 Months" 
    GRM_L["Player Guild Rep is"] = "Гильдейская репутация игрока"         -- Ex: "Player Guild Rep is < Honored" or "Player Guild Rep is = Neutral"  -- Dropdown selection options immediately follow this line. If ordering of boxes before the line would be better, please inform me and I can accomadate your localization efforts
    GRM_L["|CFFE6CC7FClick|r to Change Rep"] = "|CFFE6CC7FЛКМ|r для изменения репутации"
    GRM_L["Guild Rep:"] = "Гильдейская репутация:"
    GRM_L["Guild Rep lower than {name}"] = "Гильдейская репутация ниже, чем {name}"
    GRM_L["Guild Rep equal to {name}"] = "Гильдейская репутация равна {name}"
    GRM_L["Guild Rep higher than {name}"] = "Гильдейская репутация выше, чем {name}"
    GRM_L["Rep: {name} - {name2}"] = "Реп: {name} - {name2}"
    GRM_L["Custom Log Entry Message"] = "Пользовательское сообщение записи журнала"
    GRM_L["Press ENTER to Save"] = "Нажмите ENTER, чтобы сохранить"
    GRM_L["{name} matches {num} macro tool rules. Kick Recommended!"] = "{name} соответствует  правилам макротулза {num}. Исключение рекомендуется!"
    GRM_L["{name} matches {num} macro tool rule. Kick Recommended!"] = "{name} соответствует правилу макротулза {num}. Исключение рекомендуется!"
    -- Classic Only
    GRM_L["Shift Rank Up"] = "Сдвинуть ранг вверх"
    GRM_L["The Guild Rank \"{name}\" has Shifted up from rank {num} to {custom1}"] = "Ранг гильдии \"{name}\" поднялся с ранга {num} на {custom1}"
    GRM_L["The Guild Rank \"{name}\" has Shifted lower from rank {num} to {custom1}"] = "Ранг гильдии \"{name}\" сдвинулся с ранга {num} на {custom1}."
    GRM_L["After shifting the rank up by 1, the window will automatically close"] = "После сдвига звания на 1, окно автоматически закроется."
    GRM_L["After shifting the down by 1, the window will automatically close"] = "После сдвига вниз на 1, окно автоматически закроется."
    GRM_L["Addon restrictions require manual selection of guild rank"] = "Ограничения аддонов требуют ручного выбора ранга гильдии"
    GRM_L["Shift Rank Down"] = "Сдвинуть ранг вниз"
    
    -- R1.90
    GRM_L["Suggestions on kick filters? Submit to Discord"] = "Предложение по кик-фильтрам? Поделись этим в нашем Discord канале."
    GRM_L["GRM WARNING!!! FAILURE TO LOAD THIS KEY: {name}\nPLEASE REPORT TO ADDON DEV! THANK YOU!"] = "ГРМ Внимание!!! Ошибка загрузки этого ключа: {name}\nПожалуйста сообщите об этом разработчику аддона! Спасибо!"
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
    GRM_L["Suggestions on promote filters? Submit to Discord"] = true                                                                       -- promote
    GRM_L["Suggestions on demote filters? Submit to Discord"] = true                                                                        -- demote
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
    GRM_L["Click"] = "Клик"                   -- Referencing a mouse click
    GRM_L["Ctrl-Click"] = "Ctrl-Клик"              -- Ctrl = Control
    GRM_L["Alt-Click"] = true
    GRM_L["Shift-Click"] = true
    GRM_L["Ctrl-Shift-Click"] = true
    GRM_L["Alt-Shiift-Click"] = true
    GRM_L["Right-Click"] = "Щелкните правой кнопкой мыши"
    
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
    GRM_L["There was an error with a {name} rule: \"{name2}\""] = true
    GRM_L["Please report to addon creator the following variables were missing: {custom1}"] = true
    GRM_L["Customize Color"] = true
    GRM_L["GRM has detected that FGI is blocking system messages and cannot function properly without them. Do you want to enable them?"] = true        -- FGI is in reference to the "Fast Guild Invite" addon...
    GRM_L["GRM has detected that System Messages are disabled and cannot function properly without them. Do you want to enable them?"] = true
    GRM_L["System Messages have been enabled and GRM should now function properly."] = true
    GRM_L["Officer Only Access"] = true   -- Tooltip on the advanced join date tool button
    GRM_L["Player no longer has officer access. Advanced Join Date Tool has been closed."] = true
    GRM_L["{custom1} to open Player Window"] = true
    GRM_L["{custom1} for Additional Options"] = "{custom1}, для просмотра дополнительных параметров."
    
    
end

-- Anazing work Максим#0406 on Discord - Incredible work, really!
