
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

GRML.MandarinCN = function()

    -- Auto Localized (Only use this on Client languages)
    GRM_L["Friend"] = FRIEND;

    -- SET YOUR OWN CUSTOM SLASH COMMAND FOR GRM
    GRM_L["/XXXX"] = true   -- /grm will always work -- now you can make your own acronym that fits your language. Example: GRM_L["/XXXX"] = "/грм" - Now, if you type /грм it will work in-game
    GRM_L["/YYYY"] = true;  -- /roster              -- This is the custom GRM roster

    GRM_L["German"] = "Deutsch 德语"
	GRM_L["English"] = "English 英语"
	GRM_L["French"] = "Français 法语"
	GRM_L["Italian"] = "Italiano 意大利语"
	GRM_L["Russian"] = "Русский 俄语"
	GRM_L["SpanishMX"] = "Español(MX) 西班牙语（墨西哥）"
	GRM_L["SpanishEU"] = "Español(EU) 西班牙语（欧洲）"
    GRM_L["Portuguese"] = "Português(EU) 葡萄牙语（欧洲）"
    GRM_L["PortugueseBR"] = "Português(BR) 葡萄牙语（巴西）"
	GRM_L["Korean"] = "한국어 韩语"
	GRM_L["MandarinCN"] = "简体中文"
    GRM_L["MandarinTW"] = "繁體中文"
    GRM_L["Dutch"] = "Nederlands 荷兰语"
    GRM_L["Danish"] = "dansk 丹麦语"

    -- PLAYER MAIN ROSTER DETAILS WINDOW
    GRM_L["Level: "] = "等级"
    GRM_L["Level"] = "等级"
    GRM_L["Note:"] = "备注："
    GRM_L["Note"] = "备注"
    GRM_L["Officer's Note:"] = "官员备注:"
    GRM_L["Officer's Note"] = "官员备注"
    GRM_L["Zone:"] = "地区："
    GRM_L["(main)"] = "(主号)"
    GRM_L["( Main )"] = "( 主号 )"                                -- Context: This one is used on player data window, the other is smaller used in the alts list...
    GRM_L["Set as Main"] = "设为主号"
    GRM_L["Set as Alt"] = "设为小号"
    GRM_L["Remove"] = "移除"
    GRM_L["Please Type the Name of the alt"] = "请输入小号角色名"
    GRM_L["Promoted:"] = "会阶提升："
    GRM_L["Unknown"] = "未知"                                                                -- Context: The date of their promotion is "Unknown"
    GRM_L["Click here to set a Public Note"] = "点击此处设置公共备注"
    GRM_L["Unable to Edit Public Note at Rank"] = "无权限修改公共备注"
    GRM_L["Click here to set an Officer's Note"] = "点击此处设置官员备注"
    GRM_L["Unable to Edit Officer Note at Rank"] = "无权限修改官员备注"
    GRM_L["Unable to View Officer Note at Rank"] = "无权限查看官员备注"
    GRM_L["Online"] = "在线"
    GRM_L["( Active )"] = "( 活跃 )"                       -- I included the parentheses here as I am not sure if any languages abstain from them, or use other notation. Feel free to remove if necessary
    GRM_L["( AFK )"] = "( 离开 )"
    GRM_L["( Busy )"] = "( 忙碌 )"
    GRM_L["( Mobile )"] = "( 移动端 )"
    GRM_L["( Offline )"] = "( 离线 )"
    GRM_L["Set Join Date"] = "设置加入日期"
    GRM_L["Edit Promo Date"] = "修改会阶提升日期"
    GRM_L["Edit Join Date"] = "修改加入日期"
    GRM_L["Set Promo Date"] = "设置会阶提升日期"
    GRM_L["Group Invite"] = "小队邀请"
    GRM_L["Date Promoted?"] = "会阶提升日期?"
    GRM_L["Last Online"] = "上一次在线"
    GRM_L["Time In:"] = "已在该地区:"                           -- Context: "Time In" the current zone...
    GRM_L["Date Joined"] = "加入日期"
    GRM_L["Join Date?"] = "加入日期?"
    GRM_L["Player Was Previously Banned!"] = "该玩家曾被拉黑!"
    GRM_L["Ignore Ban"] = "忽略禁止"
    GRM_L["Player Alts"] = "玩家的小号"
    GRM_L["Add Alt"] = "添加小号"
    GRM_L["Choose Alt"] = "选择小号"
    GRM_L["Guild Log"] = "公会日志"
    GRM_L["Guild"] = "公会"

    -- TOOLTIPS
    GRM_L["Rank History"] = "会阶历史"
    GRM_L["Right-Click to Edit"] = "右键编辑"
    GRM_L["Left Guild"] = "离开公会"
    GRM_L["Membership History"] = "成员历史"
    GRM_L["Joined:"] = "加入于:"                            -- as in "Joined" the guild
    GRM_L["Joined"] = "加入"
    GRM_L["Left:"] = "离开于:"                              -- as in, "Left" the guild
    GRM_L["Rejoined:"] = "重新加入于:"                          -- as in, "Rejoined" the guild
    GRM_L["Rejoined"] = "重新加入"
    GRM_L["Reset Data!"] = "重置数据!"
    GRM_L["Notify When Player is Active"] = "当玩家活跃时发送通知"
    GRM_L["Notify When Player Goes Offline"] = "当玩家下线时发送通知"
    GRM_L["Notify When Player Comes Online"] = "当玩家上线时发送通知"
    GRM_L["Edit Date"] = "编辑日期"
    GRM_L["Clear History"] = "清除历史"
    GRM_L["Options"] = "选项"

    -- LOG
    GRM_L["LOG"] = "日志"                                                    -- Context - The guild Log shorthand for the tab
    GRM_L["Guild Roster Event Log"] = "成员变动日志"
    GRM_L["Clear Log"] = "清除日志"
    GRM_L["Really Clear the Guild Log?"] = "确认清除公会日志?"
    GRM_L["{name} KICKED {name2} from the Guild!"] = "{name} 已将 {name2} 开除出公会!"
    GRM_L["kicked"] = "已开除"
    GRM_L["{name} has Left the guild"] = "{name} 离开了公会"
    GRM_L["{name} has BANNED {name2} and all linked alts from the guild!"] = "{name} 已将 {name2} 及其所有小号加入黑名单!"
    GRM_L["{name} has BANNED {name2} from the guild!"] = "{name} 已将 {name2} 加入黑名单!"
    GRM_L["Reason Banned:"] = "拉黑原因:"
    GRM_L["has Left the guild"] = "离开了公会"                                     -- Context: PlayerName "has left the guild"
    GRM_L["ALTS IN GUILD:"] = "仍在公会中的小号:"                                         -- Context: This appears If a person leaves the guild and there are still alts in the guild. It is like - "ALTS IN GUILD: Arkaan, Chris, Matt, and 4 others.""
    GRM_L["Player no longer on Server"] = "玩家已不在该服务器"
    GRM_L["{name} PROMOTED {name2} from {custom1} to {custom2}"] = "{name} 将 {name2} 的会阶从 {custom1} 提升至 {custom2}"
    GRM_L["{name} has been PROMOTED from {custom1} to {custom2}"] = "{name} 的会阶已从 {custom1} 提升至 {custom2}"
    GRM_L["{name} DEMOTED {name2} from {custom1} to {custom2}"] = "{name} 将 {name2} 的会阶从 {custom1} 降级至 {custom2}"
    GRM_L["{name} has been DEMOTED from {custom1} to {custom2}"] = "{name} 的会阶已从 {custom1} 降级至 {custom2}"
    GRM_L["(+ {num} More)"] = "(及另外 {num} 个)"                                         -- Context: Referencing num of alts if player leaves guild, that are stil in it. Example "ALTS IN GUILD: Christ, Matt, Sarah (and 4 more)"
    GRM_L["{name} has Been in the Guild {num} Times Before"] = "{name} 已 {num} 次重新加入过公会"
    GRM_L["{name} is Returning for the First Time."] = "{name} 首次重新加入公会。"
    GRM_L["None Given"] = "未给出"                                             -- Context: No reason given for player ban. This is displayed when a player was banned, but the addon users did not input a reason why.
    GRM_L["WARNING!"] = "警告!"                                               -- Context: WARNING - banned player rejoined the guild!
    GRM_L["{name} REJOINED the guild but was previously BANNED!"] = "{name} 重新加入了公会但该玩家曾在黑名单中!"
    GRM_L["(Invited by: {name})"] = "(邀请人: {name})"
    GRM_L["Invited By: {name}"] = "邀请人: {name}"
    GRM_L["Date of Ban:"] = "加入黑名单日期:"
    GRM_L["Date Originally Joined:"] = "首次加入公会日期:"
    GRM_L["Old Guild Rank:"] = "曾经的公会会阶:"
    GRM_L["Additional Notes:"] = "额外备注:"
    GRM_L["{name} has REINVITED {name2} to the guild"] = "{name} 邀请了 {name2} 重新加入公会"
    GRM_L["(LVL: {num})"] = "(等级: {num})"                                           -- Context: LVL means Player Level - so Ex: (LVL: 110)
    GRM_L["{name} has REJOINED the guild"] = "{name} 重新加入了公会"
    GRM_L["{name} has JOINED the guild!"] = "{name} 加入了公会!"
    GRM_L["Date Left:"] = "离开公会日期:"
    GRM_L["{name} has Leveled to {num}"] = "{name} 的等级已提升至 {num}"
    GRM_L["(+{num} levels)"] = "(+{num} 级)"                                        -- Context: Person gained more than one level, hence the plural
    GRM_L["(+{num} level)"] = "(+{num} 级)"                                         -- Context: Person gains a level, just one level.
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Added"] = "{name}的公共备注被添加: \"{custom1}\""          -- Of note, the \" in the text here will just appear as " in-game. The \" notation is telling the program not to end the string, but to include quotation
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Removed"] = "{name}的公共备注: \"{custom1}\" 被移除"
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" to \"{custom2}\""] = "{name}的公共备注: \"{custom1}\" 被改为 \"{custom2}\""   -- Context: "Arkaan's PUBLIC Note: "ilvl 920" to "Beast Mode ilvl 960""  -- Changing of the note. custom1 = old note, custom2 = new note
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Added"] = "{name}的官员备注被添加: \"{custom1}\""
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Removed"] = "{name}的官员备注: \"{custom1}\" 被移除"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" to \"{custom2}\""] = "{name}的官员备注: \"{custom1}\" 被改为 \"{custom2}\""
    GRM_L["Guild Rank Renamed from {custom1} to {custom2}"] = "会阶名称 {custom1} 被改为 {custom2}"
    GRM_L["{name} has Name-Changed to {name2}"] = "{name} 已改名为 {name2}"
    GRM_L["{name} has Come ONLINE after being INACTIVE for {num}"] = "{name} 在离线 {num} 后重新上线"
    GRM_L["{name} has been OFFLINE for {num}. Kick Recommended!"] = "{name} 已离线 {num}。建议开除!"
    GRM_L["({num} ago)"] = "({num} 前)"                                            -- Context: (5 minutes ago) or (5 months 24 days ago) -- the {num} will automatically include the time-passed date.
    GRM_L["{name}'s Guild has Name-Changed to \"{name2}\""] = "{name}的公会已改名为 \"{name2}\""
    GRM_L["Promotions"] = "升阶"
    GRM_L["Demotions"] = "降阶"

    -- EVENTS WINDOW
    GRM_L["EVENTS"] = "活动"                                         -- Events tab
    GRM_L["Event Calendar Manager"] = "活动日历管理"
    GRM_L["Event:"] = "活动:"
    GRM_L["Description:"] = "描述:"
    GRM_L["Add to\nCalendar"] = "添加至日历"
    GRM_L["Ignore Event"] = "忽略活动"
    GRM_L["No Player Event Has Been Selected"] = "未选择玩家活动"
    GRM_L["Event Added to Calendar: {custom1}"] = "活动{custom1}已添加至日历"             -- Custom1 = the title of the event, like "Arkaan's Anniversary"
    GRM_L["Please Select Event to Add to Calendar"] = "请选择活动添加至日历"
    GRM_L["No Calendar Events to Add"] = "无活动可添加"
    GRM_L["{name}'s event has already been added to the calendar!"] = "{name}的活动已经添加至日历!"
    GRM_L["Please wait {num} more seconds to Add Event to the Calendar!"] = "请等待{num}秒后再添加活动至日历!"
    GRM_L["{name}'s Event Removed From the Queue!"] = "{name}的活动已从队列中移除!"
    GRM_L["Full Description:"] = "完整描述:"

    -- BAN WINDOW
    GRM_L["BAN LIST"] = "黑名单"                                       -- Ban List Tab
    GRM_L["Reason Banned?"] = "拉黑理由?"
    GRM_L["Click \"YES\" When Done"] = "完成后点击\"是\""                        -- Of note, the \" is how you notate for quotations to actually appear. Adjust as needed
    GRM_L["Select a Player"] = "选择一名玩家"
    GRM_L["Player Selected"] = "已选择玩家"
    GRM_L["{name}(Still in Guild)"] = "{name}(仍是公会成员)"
    GRM_L["(Still in Guild)"] = "(仍是公会成员)"
    GRM_L["No Ban Reason Given"] = "无拉黑理由"
    GRM_L["Total Banned:"] = "完全拉黑:"
    GRM_L["Rank"] = "会阶"
    GRM_L["Ban Date"] = "拉黑日期"
    GRM_L["No Players Have Been Banned from Your Guild"] = "公会黑名单中暂无玩家"
    GRM_L["Remove Ban"] = "从黑名单移除"
    GRM_L["Add Player to Ban List"] = "将玩家加入黑名单"
    GRM_L["Server:"] = "服务器:"
    GRM_L["Class:"] = "职业:"
    GRM_L["Reason:"] = "原因:"
    GRM_L["It is |CFFFF0000CRITICAL|r the player's name and server are spelled correctly for accurate tracking and notifications."] = "为了追踪及通知的准确性，请|CFFFF0000确认|r 输入的是正确的角色及服务器名称。"
    GRM_L["Submit Ban"] = "提交拉黑"
    GRM_L["Confirm"] = "确认"
    GRM_L["Cancel"] = "取消"
    GRM_L["Add"] = "添加"                                        -- Context: "Add" player to ban list
    GRM_L["Confirm Ban for the Following Player?"] = "确认将下列玩家加入黑名单?"
    GRM_L["Please Enter a Valid Player Name"] = "请输入正确的角色名"           -- Player Name
    GRM_L["Please Enter a Valid Server Name"] = "请输入正确的服务器名称"           -- Server Name
    GRM_L["Please Select a Player to Unban!"] = "请选择一名玩家从黑名单中移除!"
    GRM_L["{name} - Ban List"] = "{name} - 黑名单"                          -- Context: "GuildName - Ban List"
    GRM_L["No Reason Given"] = "未给出理由"

    -- ADDON USERS WINDOW
    GRM_L["SYNC USERS"] = "同步用户"
    GRM_L["Ok!"] = "确定!"
    GRM_L["Their Rank too Low"] = "他们的会阶过低"
    GRM_L["Your Rank too Low"] = "你的会阶过低"
    GRM_L["Outdated Version"] = "版本过期"
    GRM_L["You Need Updated Version"] = "请更新版本"
    GRM_L["Player Sync Disabled"] = "玩家同步未开启"
    GRM_L["No Guildie Online With Addon."] = "无在线公会玩家安装此插件。"
    GRM_L["ONE Person is Online. Recommend It!"] = "一位玩家在线，请推荐这个插件!"
    GRM_L["{num} others are Online! Recommend It!"] = "{num}位玩家在线，请推荐这个插件!"
    GRM_L["GRM Sync Info"] = "GRM同步信息"
    GRM_L["Ver: {custom1}"] = "版本: {custom1}"                                 -- Context:  Ver: R1.125  - Ver is short for Version
    GRM_L["Name:"] = "名字:"
    GRM_L["Version"] = "版本"
    GRM_L["Sync"] = "同步"
    GRM_L["Your Sync is Currently Disabled"] = "你的同步未开启"

    -- OPTIONS WINDOW
    GRM_L["Scanning Roster:"] = "扫描公会名单:"
    GRM_L["Guild Rank Restricted:"] = "会阶限制:"
    GRM_L["Sync:"] = "同步:"
    -- Options window -- of note, these are very concise statements. They may need to be adjusted properly in the Options window for proper spacing, so verify they look ok after translating.
    GRM_L["Slash Commands"] = "命令项"
    GRM_L["Trigger scan for changes manually"] = "手动开始扫描新变动"
    GRM_L["Trigger sync one time manually"] = "手动开始单次同步"
    GRM_L["Centers all Windows"] = "将所有窗口居中"
    GRM_L["Slash command info"] = "命令项信息"
    GRM_L["Resets ALL data"] = "重置所有数据"
    GRM_L["Report addon ver"] = "报告插件版本"                                   -- Ver is short for Version
    GRM_L["Resets Guild data"] = "重置公会数据"
    GRM_L["Show at Logon"] = "登录后显示"
    GRM_L["Only Show if Log Changes"] = "只在有新日志时显示"

    -- This do need to be translated still
    GRM_L["Before Scan Timer"] = "每"                  -- Context: "Scan for Changes Every 10 Seconds" -- There will be a number added here and may require custom positioning, so please provide full statement and Arkaan will allign
    GRM_L["After Scan Timer"] = "秒扫描变动"
    GRM_L["Before Inactive Timer"] = "当离线超过"
    GRM_L["After Inactive Timer"] = "天的玩家上线时发送通告"

    GRM_L["Reactivating SCAN for Guild Member Changes..."] = "正在重启扫描公会成员变动..."
    GRM_L["Deactivating SCAN of Guild Member Changes..."] = "正在关闭扫描公会成员变动..."
    GRM_L["Please choose a scan interval {num} seconds or higher!"] = "请选择不少于{num}秒的扫描间隔时长!"
    GRM_L["{num} is too Low!"] = "{num}太短了!"
    GRM_L["The Current Lvl Cap is {num}."] = "当前等级上限为{num}。"
    GRM_L["Kick Inactive Player Reminder at"] = true        -- Context: "Kick Inactive Player Reminder at X Months" - Again, allignment will need to be adjusted for options UI, so please post
    GRM_L["Please choose a month between 1 and 999"] = "选择的月数需在1到999之间"
    GRM_L["Please choose a month between 0 and 999"] = "选择的月数需在0到999之间"
    GRM_L["Sync BAN List With Guildies at Rank"] = "同步成员黑名单，会阶为"    -- Context: "Sync Ban List with Guildies at Rank [DROPDOWNMENU OF RANKS] or Higher" - Please show where dropdown menu should be pinned
    GRM_L["or Higher"] = "或以上"                              -- Context: Look at the above statement. Show where this needs to go in regards to dropdown menu of rank selection in Options
    GRM_L["Restore Defaults"] = "恢复默认设置"
    GRM_L["Please choose between 1 and 180 days!"] = "选择的天数需在1到180之间"
    GRM_L["Announce Events"] = "提前"                        -- Context: "Announce Events X number of days in advance" -- the X is the editbox to modify number of days. Please include the location of where to pin that.
    GRM_L["Days in Advance"] = "天通告活动"
    GRM_L["Add Events to Calendar"] = "添加活动至日历"
    GRM_L["SYNC Changes With Guildies at Rank"] = "同步成员变动，会阶为"     -- Context: at Rank [DROPDOWNRANKSELECTION] or Higher. - Please note where to place dropdown box in the position of the sentence.
    GRM_L["Reactivating Data SYNC with Guildies..."] = "正在重启同步公会成员..."
    GRM_L["Deactivating Data SYNC with Guildies..."] = "正在关闭同步公会成员..."
    GRM_L["Display Sync Update Messages"] = "显示同步更新信息"
    GRM_L["Only Sync With Up-to-Date Addon Users"] = "只与使用最新版本插件的用户同步"
    GRM_L["Leveled"] = "等级"
    GRM_L["Inactive Return"] = "长时离线回归"
    GRM_L["resetall"] = true
    GRM_L["resetguild"] = true
    --Side chat/log controls - Of note, limited spacing
    GRM_L["Name Change"] = "名字变更"
    GRM_L["Rank Renamed"] = "会阶改名"
    GRM_L["Event Announce"] = "活动通知"
    GRM_L["Left"] = "离开"                       -- Context: As in, "Left" the guild...
    GRM_L["Recommendations"] = "推荐"
    GRM_L["Banned"] = "拉黑"
    GRM_L["To Chat:"] = "在聊天框中:"                   -- Context: "To Chat Message frame -- in regards to announcing events like when a player leveled"
    GRM_L["To Log:"] = "在日志中:"                    -- Context: To show it in the guild log.
    GRM_L["Display Changes"] = "显示变更"

    -- AUDIT WINDOW
    GRM_L["AUDIT"] = "详单"                                              -- Audit Tab name
    GRM_L["No Date Set"] = "日期未设定"
    GRM_L["Main"] = "主号"
    GRM_L["Main or Alt?"] = "主号还是小号?"
    GRM_L["Alt"] = "小号"
    GRM_L["Total Incomplete: {num} / {custom1}"] = "信息不完整: {num} / {custom1}"                -- Context: Total incomplete: 50 / 100    (50 out of 100)
    GRM_L["Mains:\n{num}"] = "主号:\n{num}"                                       -- Context: Number of "main" toons
    GRM_L["Unique Accounts:\n{num}"] = "游戏账号:\n{num}"
    GRM_L["All Complete"] = "信息完整"                                       -- Context: All dates have been added and are known, thus it states it is "All Complete"
    GRM_L["Set Incomplete to Unknown"] = "将信息不完整设为未知"                          -- Context: Implied to set ALL incomplete to unknown
    GRM_L["Clear All Unknown"] = "清除所有未知"
    GRM_L["Please Wait {num} more Seconds"] = "请等待{num}秒"
    GRM_L["Guild Data Audit"] = "公会信息详单"
    GRM_L["Name"] = "名字"
    GRM_L["Join Date"] = "加入日期"
    GRM_L["Promo Date"] = "晋升日期"
    GRM_L["Main/Alt"] = "主号/小号"
    GRM_L["Only Show Incomplete Guildies"] = "只显示信息不完整成员"

    -- ADDON SYSTEM MESSAGES
    GRM_L["Guild Roster Manager"] = true
    GRM_L["GRM:"] = true                                                                -- Abbreviation for "Guild Roster Manager"
    GRM_L["(Ver:"] = "(版本号:"                                                              -- Ver: is short for Version:
    GRM_L["GRM Updated:"] = "GRM已更新:"
    GRM_L["Configuring Guild Roster Manager for {name} for the first time."] = "为{name}首次配置Guild Roster Manager"
    GRM_L["Notification Set:"] = "通告已设置:"
    GRM_L["Report When {name} is ACTIVE Again!"] = "当{name}再次活跃时通告!"
    GRM_L["Report When {name} Comes Online!"] = "当{name}上线时通告!"
    GRM_L["Report When {name} Goes Offline!"] = "当{name}下线时通告!"
    GRM_L["A new version of Guild Roster Manager is Available!"] = "Guild Roster Manager已发布新版本!"
    GRM_L["Please Upgrade!"] = "请更新!"
    GRM_L["Player Does Not Have a Time Machine!"] = "玩家没有时间机器!"
    GRM_L["Please choose a valid DAY"] = "请选择可用的日期"
    GRM_L["{name} has been Removed from the Ban List."] = "{name}已从黑名单中移除。"
    GRM_L["Scanning for Guild Changes Now. One Moment..."] = "正在扫描公会变动，请稍后..."
    GRM_L["Initializing Sync Action. One Moment..."] = "正在启动同步功能，请稍后..."
    GRM_L["No Players Currently Online to Sync With..."] = "无在线玩家可同步..."
    GRM_L["SYNC is currently not possible! Unable to Sync with guildies when guild chat is restricted."] = "同步不可用! 当公会聊天受限时无法与公会成员同步。"
    GRM_L["Manual Scan Complete"] = "手动扫描完成"
    GRM_L["Analyzing guild for the first time..."] = "首次分析公会..."
    GRM_L["Building Profiles on ALL \"{name}\" members"] = "为\"{name}\"所有成员创建档案"                -- {name} will be the Guild Name, for context
    GRM_L["NOTIFICATION:"] = "通知:"                                              -- Context:  "Notification: Player is no longer AFK"
    GRM_L["{name} is now ONLINE!"] = "{name}上线了!"
    GRM_L["{name} is now OFFLINE!"] = "{name}下线了!"
    GRM_L["{name} is No Longer AFK or Busy!"] = "{name}不再处于离开或忙碌状态!"
    GRM_L["{name} is No Longer AFK or Busy, but they Went OFFLINE!"] = "{name}不再处于离开或忙碌状态，并已下线！"
    GRM_L["{name}'s saved data has been wiped!"] = "{name}的数据已被清除!"
    GRM_L["Wiping all Saved Roster Data Account Wide! Rebuilding from Scratch..."] = "正在清除账号的所有成员信息! 重新建立数据库..."
    GRM_L["Wiping all saved Guild data! Rebuilding from scratch..."] = "正在清除所有公会信息! 重新建立数据库..."
    GRM_L["There are No Log Entries to Delete, silly {name}!"] = "没有日志项可以删除, {name}好笨哦!"
    GRM_L["Guild Log has been RESET!"] = "公会日志已重置!"
    GRM_L["{name} is now set as \"main\""] = "{name}已被设为\"主号\""
    GRM_L["{name} is no longer set as \"main\""] = "{name}不再是\"主号\""
    GRM_L["Reset All of {name}'s Data?"] = "重置{name}的所有数据?"

    -- /grm help
    GRM_L["Opens Guild Log Window"] = "打开公会日志窗口"
    GRM_L["Resets ALL saved data"] = "重置所有已保存的信息"
    GRM_L["Resets saved data only for current guild"] = "只重置当前公会的已保存信息"
    GRM_L["Re-centers the Log window"] = "将公会日志窗口居中"
    GRM_L["Triggers manual re-sync if sync is enabled"] = "如果同步已开启，则手动启动重同步"
    GRM_L["Does a one-time manual scan for changes"] = "执行单次变更扫描"
    GRM_L["Displays current Addon version"] = "显示当前插件版本"
    GRM_L["WARNING! Complete hard wipe, including settings, as if addon was just installed."] = "警告! 重置所有数据，包括设置，恢复出厂。"

    -- General Misc UI
    GRM_L["Really Clear All Account-Wide Saved Data?"] = "确定要清除此账号下的所有数据?"
    GRM_L["Really Clear All Guild Saved Data?"] = "确定要清除所有公会数据?"
    GRM_L["Yes!"] = "是!"
    GRM_L["Ban Player?"] = "拉黑玩家?"
    GRM_L["Ban the Player's {num} alts too?"] = "同时拉黑此玩家的{num}个小号?"     -- Plural number of alts
    GRM_L["Ban the Player's {num} alt too?"] = "同时拉黑此玩家的{num}个小号?"    -- Singular number of alts, just 1
    GRM_L["Please Click \"Yes\" to Ban the Player!"] = "点击\"是\"以拉黑此玩家!"

    -- Sync Messages
    GRM_L["{name} updated {name2}'s Join Date."] = "{name}更新了{name2}的加入日期。"
    GRM_L["{name} updated {name2}'s Promotion Date."] = "{name}更新了{name2}的晋升日期。"
    GRM_L["\"{custom1}\" event added to the calendar by {name}"] = "\"{custom1}\"活动已被{name}添加至日历"
    GRM_L["{name} updated {name2}'s list of Alts."] = "{name}更新了{name2}的小号信息。"
    GRM_L["{name} removed {name2} from {custom1}'s list of Alts."] = "{name}将{name2}从{custom1}的小号中移除。"
    GRM_L["{name} set {name2} to be 'Main'"] = "{name}将{name2}设为主号。"
    GRM_L["{name} has changed {name2} to be listed as an 'alt'"] = "{name}将{name2}设为小号。"
    GRM_L["{name} has Removed {name2} from the Ban List."] = "{name}将{name2}从黑名单中移除。"
    GRM_L["{name} has been BANNED from the guild!"] = "{name}已被公会拉黑!"
    GRM_L["{name} has been UN-BANNED from the guild!"] = "{name}已被公会取消拉黑!"
    GRM_L["Initiating Sync with {name} Instead!"] = "与{name}开始同步!"
    GRM_L["Sync Failed with {name}..."] = "与{name}的同步失败..."
    GRM_L["The Player Appears to Be Offline."] = "玩家已离线。"
    GRM_L["Syncing Data With Guildies Now..."] = "正在与公会成员同步数据..."
    GRM_L["(Loading screens may cause sync to fail)"] = "(载入界面可能导致同步失败)"
    GRM_L["Sync With Guildies Complete..."] = "与公会成员同步数据完成..."

    -- ERROR MESSAGES
    GRM_L["Notification Has Already Been Arranged..."] = "通告已经被整理..."
    GRM_L["Player Cannot Add Themselves as an Alt"] = "玩家无法将自己添加为小号"
    GRM_L["Player Not Found"] = "未找到玩家"
    GRM_L["Please try again momentarily... Updating the Guild Event Log as we speak!"] = "正在更新公会活动日志，请稍后再试!"
    GRM_L["Invalid Command: Please type '/grm help' for More Info!"] = "无效的命令: 请输入'/grm help'以获得更多信息!"
    GRM_L["{name} is not currently in a guild. Unable to Proceed!"] = "{name}不在一个公会中。进程终止!"
    GRM_L["Addon does not currently support more than 75 alts!"] = "插件最多只能支持75个小号!"
    GRM_L["Please choose a VALID character to set as an Alt"] = "请选择一个有效的角色为小号。"
    GRM_L["Please choose a character to set as alt."] = "请选择一个角色为小号。"
    GRM_L["GRM ERROR:"] = "GRM错误:"
    GRM_L["Com Message too large for server"] = "通讯信息量超出服务器负载"                   -- Context: "Com message" is short-hand for "Communications message" - this is a technical error on syncing data.
    GRM_L["Prefix:"] = "前缀:"
    GRM_L["Msg:"] = "信息:"                                               -- Context: Msg is short for Message
    GRM_L["Unable to register prefix > 16 characters: {name}"] = "无法注册前缀>16个字符: {name}"  -- Context: The {name} is the string code for the prefix. This is for debugging.

    --SLASH COMMANDS
    -- These are generally written in general shorthand. The original commands will ALWAYS work, but if there is one that makes more sense in your language, please feel free to modify
    GRM_L["clearall"] = true                        -- Context: In regards, "Clear All" saved data account wide
    GRM_L["clearguild"] = true                      -- Context: In regards, "Clear All" saved data from ONLY the current guild.
    GRM_L["hardreset"] = true                       -- Context: In regards, "Hard Reset" ALL data account wide, including wiping player settings
    GRM_L["help"] = true                            -- Context: "help" with info on the how to use addon
    GRM_L["version"] = true                         -- Context: "version" of the addon
    GRM_L["center"] = true                          -- Context: "center" the movable addon window back to center of screen
    GRM_L["sync"] = true                            -- Context: "sync" the data between players one time now.
    GRM_L["scan"] = true                            -- Context: "scan" for guild roster changes one time now.

    -- CLASSES
    GRM_L["Deathknight"] = "死亡骑士"
    GRM_L["Demonhunter"] = "恶魔猎手"
    GRM_L["Druid"] = "德鲁伊"
    GRM_L["Hunter"] = "猎人"
    GRM_L["Mage"] = "法师"
    GRM_L["Monk"] = "武僧"
    GRM_L["Paladin"] = "圣骑士"
    GRM_L["Priest"] = "牧师"
    GRM_L["Rogue"] = "潜行者"
    GRM_L["Shaman"] = "萨满祭司"
    GRM_L["Warlock"] = "术士"
    GRM_L["Warrior"] = "战士"

    -- TIME AND DATES
    GRM_L["1 Mar"] = "3月1日"                           -- This date is used in a specific circumstance. If someone's anniversary/bday landed on a leap year (Feb 29th), it defaults to the 1st of March on non-leap year
    -- Full Month Name
    GRM_L["January"] = "一月"
    GRM_L["February"] = "二月"
    GRM_L["March"] = "三月"
    GRM_L["April"] = "四月"
    GRM_L["May"] = "五月"
    GRM_L["June"] = "六月"
    GRM_L["July"] = "七月"
    GRM_L["August"] = "八月"
    GRM_L["September"] = "九月"
    GRM_L["October"] = "十月"
    GRM_L["November"] = "十一月"
    GRM_L["December"] = "十二月"
    -- Shorthand Month
    GRM_L["Jan"] = "一月"
    GRM_L["Feb"] = "二月"
    GRM_L["Mar"] = "三月"
    GRM_L["Apr"] = "四月"
    GRM_L["May"] = "五月"
    GRM_L["Jun"] = "六月"
    GRM_L["Jul"] = "七月"
    GRM_L["Aug"] = "八月"
    GRM_L["Sep"] = "九月"
    GRM_L["Oct"] = "十月"
    GRM_L["Nov"] = "十一月"
    GRM_L["Dec"] = "十二月"

    -- Time Notifcation
    GRM_L["Seconds"] = "秒"
    GRM_L["Second"] = "秒"
    GRM_L["Minutes"] = "分"
    GRM_L["Minute"] = "分"
    GRM_L["Hours"] = "小时"
    GRM_L["Hour"] = "小时"
    GRM_L["Days"] = "天"
    GRM_L["Day"] = "天"
    GRM_L["Months"] = "月"
    GRM_L["Month"] = "月"
    GRM_L["HourBreak"] = ":"            -- Context, in English, and many languages, 11am = 11:00 -- or in French, 11h00   - the hour break is the ":" or the "h"

    GRM_L["am"] = "上午"
    GRM_L["pm"] = "下午"
    GRM_L["24HR_Notation"] = "";        -- if someone is using 24hr time notation in your country, instead of 12hr, how do you notate it? In English, there is no am/pm (though "hours" is technically right, but unnecessary)

    GRM_L["{num} year"] = "{num}年"
    GRM_L["{num} years"] = "{num}年"
    GRM_L["{num} month"] = "{num}个月"
    GRM_L["{num} months"] = "{num}个月"
    GRM_L["{num} day"] = "{num}天"
    GRM_L["{num} days"] = "{num}天"
    GRM_L["< 1 day"] = "< 1天"

    GRM_L["{num} yr"] = "{num}年"
    GRM_L["{num} yrs"] = "{num}年"
    GRM_L["{num} mo"] = "{num}个月"
    GRM_L["{num} mos"] = "{num}个月"
    GRM_L["{num} hr"] = "{num}小时"
    GRM_L["{num} hrs"] = "{num}小时"
    GRM_L["< 1 hour"] = "< 1小时"
    GRM_L["{num} {custom1}"] = true     -- Context: This is a placeholder for ANY generic time data -- Ex:  "1 year" or "15 months" - The translation is set this is just to set the orientation of the number properly.

    -- MISC Punctuation
    GRM_L[","] = true                               -- I know in some Asia languages, a comma is not used, but something similar, for example.

    -- Updates 1.126
    GRM_L["General"] = "综合"
    GRM_L["General:"] = "综合:"
    GRM_L["Scan"] = "扫描"
    GRM_L["Help"] = "帮助"
    GRM_L["UI"] = "界面"                             -- UI for User Interface. Abbreviation for changing custom UI featuers, like coloring of <M> main
    GRM_L["Officer"] = "官员"                        -- as in, "Officer" rank
    GRM_L["Open Addon Window"] = "打开插件窗口"
    GRM_L["Sync Addon Settings on All Alts in Same Guild"] = "为所有在公会中的小号同步插件设定"
    GRM_L["Show Minimap Button"] = "显示小地图按键"
    GRM_L["Player is Not Currently in a Guild"] = "玩家不在一个公会中"
    -- tooltips
    GRM_L["|CFFE6CC7FClick|r to open GRM"] = "|CFFE6CC7F点击|r以打开GRM"                          -- Please maintain the color coding
    GRM_L["|CFFE6CC7FRight-Click|r to Reset to 100%"] = "|CFFE6CC7F右击|r以重置为100%"               -- for the Options slider tooltip
    GRM_L["|CFFE6CC7FRight-Click|r to Set Notification of Status Change"] = "|CFFE6CC7F右击|r以设定状态变化通告"
    -- tooltip end
    GRM_L["GRM"] = true
    GRM_L["Include Unknown as Incomplete"] = "将未知作为信息不完整"                          -- Context: Unknown in the Audit Tab will be hidden if filtering out complete players
    GRM_L["You Do Not Have Permission to Add Events to Calendar"] = "你没有在日历中添加活动的权限"
    GRM_L["Please Select Which Join Date to Sync"] = "请选择同步一个加入日期"
    GRM_L["Sync All Alts to {name}'s Join Date"] = "将{name}的加入日期同步给所有小号"
    GRM_L["Sync All Alts to the Earliest Join Date: {name}"] = "将{name}最早的加入日期同步给所有小号"
    GRM_L["Sync All Alts to {name}'s |cffff0000(main)|r Join Date"] = "将{name}|cffff0000(主号)|r的加入日期同步给所有小号" -- The coloring ensures that "(main)" maintains the RED color. Please keep it consistent if relevant to your language.
    GRM_L["Join Date of All Alts is Currently Synced"] = "所有小号的啊加入日期已同步"

    -- Update 1.130
    GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button."] = "|CFFE6CC7FCtrl-Shift左键|r以隐藏此按钮"
    GRM_L["Invited By:"] = "邀请人:"
    GRM_L["Error: Guild Not Found..."] = "错误: 未找到公会..."
    GRM_L["Debugger Start"] = "开始调试"

    -- Update 1.136
    GRM_L["Backup Point Removed for Guild \"{name}\""] = "\"{name}\"公会的备份点已移除"
    GRM_L["Backup Point Restored for Guild \"{name}\""] = "\"{name}\"公会的备份点已恢复"
    GRM_L["Backup Point Set for Guild \"{name}\""] = "\"{name}\"公会的备份点已建立"
    GRM_L["Backup"] = "备份"
    GRM_L["Horde"] = "部落"
    GRM_L["Alliance"] = "联盟"
    GRM_L["Creation Date"] = "创建日期"
    GRM_L["Members"] = "成员"
    GRM_L["None"] = "无"
    GRM_L["Restore"] = "恢复"
    GRM_L["Set Backup"] = "建立备份"
    GRM_L["Memory Usage: {num} MB"] = "内存占用: {num} MB"         -- MB references the number of MegaBytes of memory used.

    -- Update 1.137
    GRM_L["GRM: Unable to Create Backup for a Guild With Unknown Creation Date! Log into that guild on any alt to update old database."] = "GRM: 公会创建日期未知，无法建立备份! 请登录任何在该公会的角色以更新旧数据库。"
    GRM_L["Really restore {name} Backup Point?"] = "确认要从{name}备份点恢复?"
    GRM_L["Check All"] = "全选"

    -- Update 1.139
    GRM_L["Right-Click for options to remove this guild from the addon database completely"] = "右键以显示将此公会从数据库中抹除的选项"
    GRM_L["Player Cannot Purge the Guild Data they are Currently In!!!"] = "请先退出当前公会再进行数据抹除!!!"
    GRM_L["To reset your current guild data type '/grm clearguild'"] = "请输入'/grm clearguild'以重置当前公会数据"
    GRM_L["Click Here to Remove all traces of this guild, or hit ESC"] = "点击此处删除该公会所有信息, 或按ESC"
    GRM_L["{name} has been removed from the database."] = "{name}已从数据库中移除。"             -- The Guild Name has been removed from the database

    -- update 1.141
    GRM_L["Only Restrict Incoming Player Data to Rank Threshold, not Outgoing"] = "会阶限制只作用于传入的数据，不作用于传出的数据"
    GRM_L["Total Entries: {num}"] = "总计条目: {num}"
    GRM_L["Search Filter"] = "搜索过滤"

    -- update 1.142
    GRM_L["Choose Color:"] = "选择颜色:"
    GRM_L["Format:"] = "格式:"
    GRM_L["RGB Values Must be Between 1 and 255."] = "RGB值必须在1到255之间。"

    -- Update 1.143
    GRM_L["The Log is Currently Empty for This Guild"] = "此公会的日志为空"
    GRM_L["Building Log for Export..."] = "正在为导出建立日志..."
    GRM_L["Open Log Tools"] = "打开日志工具"
    GRM_L["Hide Log Tools"] = "隐藏日志工具"
    GRM_L["Numbered Lines"] = "计数行"
    GRM_L["Export Log"] = "导出日志"
    GRM_L["Clear Lines:"] = "清除行:"
    GRM_L["Enable Ctrl-Shift-Click Line Removal"] = "启用Ctrl-Shift-Click清除行"
    GRM_L["To"] = "至"                                     -- Clear Lines:  50 To 100     -- It stands between 2 edit boxes as its own fontstring, so work with that.
    GRM_L["Confirm Clear"] = "确认清除"
    GRM_L["Please Select Range of Lines from the Log You Wish to Remove"] = "请选择清除日志行的范围"
    GRM_L["Please put the lowest number in the first box"] = "请在第一格中输入最小值"
    GRM_L["Line selection is not valid"] = "选择的行不可用"
    GRM_L["Really Clear lines {custom1} to {custom2}?"] = "确认清除{custom1}至{custom2}行?"
    GRM_L["Enabling Line Numbers... Please choose within the given range"] = "启用行计数... 请在该范围中选择"
    GRM_L["Ctrl-C to Copy <> Ctrl-P to Paste <> Ctrl-A to Select All"] = "按Ctrl-C复制 <> 按Ctrl-P粘贴 <> 按Ctrl-A全选"
    GRM_L["Language Selection:"] = "选择语言:"
    GRM_L["{num} phrases still need translation to {name}"] = "仍有{num}条字句需要被翻译成{name}"                 -- Ex: 300 phrases still need translation to German

    -- update 1.145
    GRM_L["You currently are at {num} non-Battletag friends. To fully take advantage of all of GRM features, please consider clearing some room."] = "你目前有{num}位非战网好友。如需使用GRM的所有功能, 请清除部分。"

    -- Update 1.146
    GRM_L["Really Clear line {num}?"] = "确认清除第{num}行?"
    GRM_L["Font has been Reset to DEFAULT."] = "字体已重置。"
    GRM_L["Font Selection:"] = "选择字体:"
    GRM_L["Font Scale:"] = "字体大小:"
    GRM_L["Example"] = "示例"
    GRM_L["Right-Click to Reset to 100%"] = "右键点击重设为100%"

    -- Update 1.147
    GRM_L["{custom1} to Search the Log for Player"] = "按{custom1}在日志中搜索玩家"

    -- Update 1.1480
    GRM_L["Custom Notes:"] = "自定义备注:"
    GRM_L["GRM Debugging Enabled."] = "启用GRM调试"
    GRM_L["GRM Debugging Disabled."] = "禁用GRM调试"
    GRM_L["Please type \"/grm debug 10\" to report 10 events (or any number)"] = "请输入\"/grm debug 10\"以显示10条报告 (或输入其他数值)"       -- Please keep the \"/grm debug 10)\" in-tact for slash command to work
    GRM_L["Format: \"/grm debug 10\""] = "格式: \"/grm debug 10\""                                                                 -- "" Likewise
    GRM_L["Error: Debug Command not recognized."] = "错误: 未知调试命令。"
    GRM_L["You may want to temporarily disable SYNC in the options if you are debugging another feature."] = "调试其他功能时请在设置中禁用同步。"
    GRM_L["Sync Custom Notes"] = "同步自定义备注"
    GRM_L["Default Custom Note Rank Minimum"] = "可自定义备注的最低会阶"
    GRM_L["Reset Default Custom Note Restrictions for ALL Guildies"] = "为所有成员重置默认可自定义备注的权限"
    GRM_L["Reset"] = "重置"
    GRM_L["|CFF00CCFFDefault Selection For All Players"] = "|CFF00CCFF选择默认会阶"
    GRM_L["Click here to set Custom Notes"] = "点击此处设置自定义备注"
    GRM_L["|CFF00CCFFCustom Note Defaults:"] = "|CFF00CCFF默认自定义备注:"
    GRM_L["|CFFE6CC7FLeft-Click|r to re-enable custom note sync for all"] = "|CFFE6CC7F左键点击|r以重新开启所有成员的自定义备注同步"
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Added"] = "{name}添加了{name2}的自定义备注: \"{custom1}\""
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" was Removed"] = "{name}移除了{name2}的自定义备注: \"{custom1}\""
    GRM_L["{name} modified {name2}'s CUSTOM Note: \"{custom1}\" to \"{custom2}\""] = "{name}将{name2}的自定义备注从\"{custom1}\"修改为\"{custom2}\""
    GRM_L["Custom Note"] = "自定义备注"
    GRM_L["|CFFE6CC7FClick|r to Change Rank Restriction"] = "|CFFE6CC7F点击|r以修改会阶限制"
    GRM_L["|CFFE6CC7FClick|r to Change Day"] = "|CFFE6CC7F点击|r以修改日期"
    GRM_L["|CFFE6CC7FClick|r to Change Month"] = "|CFFE6CC7F点击|r以修改月份"
    GRM_L["|CFFE6CC7FClick|r to Change Year"] = "|CFFE6CC7F点击|r以修改年份"
    GRM_L["Edited by {name}"] = "修改人：{name}"
    GRM_L["Note Removed by {name}"] = "备注被{name}移除"
    GRM_L["|CFFFF0000Player No Longer in Guild"] = "|CFFFF0000玩家不是公会成员"
    GRM_L["|CFF00CCFFMinimum Rank to Sync: Player Data, Ban List"] = "|CFF00CCFF同步此会阶以上: 玩家数据、黑名单"
    GRM_L["Warning! Ban List rank threshold is below the overall sync rank. Changing from \"{name}\" to \"{name2}\""] = "警告! 黑名单最低会阶低于同步会阶，将\"{name}\"改为\"{name2}\""
    GRM_L["|CFF00CCFFSync filter can be set tighter for the Ban List"] = "|CFF00CCFF可为黑名单单独设置同步过滤"
    GRM_L["Warning! Unable to select a Ban List rank below \"{name}\""] = "警告! 黑名单会阶无法低于\"{name}\""
    GRM_L["Setting to match core filter rank"] = "设置与核心会阶过滤相同"

    -- R1.1482
    GRM_L["Shift-Click Name On Roster Also Works"] = "也可以Shift点击名单中的名字"
    GRM_L["Tooltip Scale:"] = "鼠标提示尺寸:"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Language"] = "|CFFE6CC7F左键点击|r修改语言"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change Display Format"] = "|CFFE6CC7F左键点击|r修改显示格式"
    GRM_L["|CFFE6CC7FLeft-Click|r to Change the Font"] = "|CFFE6CC7F左键点击|r修改字体"

    -- R1.1490
    GRM_L["Unable to properly locate guild for backup"] = "无法正确定位公会以备份"

    -- R1.1500
    GRM_L["Unique accounts pull from the server is known to be faulty"] = "从服务器获取的战网账号有几率出错"
    GRM_L["Use only as an estimate. Hopefully Blizz fixes this soon"] = "仅作为估算用，希望暴雪尽快修复"
    GRM_L["{name}'s Anniversary!"] = "{name}的入会周年日!"
    GRM_L["{name}'s Birthday!"] = "{name}的生日!"
    GRM_L["Add Upcoming Events to the Calendar"] = "将活动添加至日历"
    GRM_L["Player rank unable to add events to calendar"] = "玩家没有添加活动的权限"
    GRM_L["Anniversaries, Birthdays, and Other Events can be added with permission"] = "有权限的玩家可以添加入会周年日、生日及其他活动"

    -- R1.1510
    GRM_L["Check the \"Sync Users\" tab to find out why!"] = "检查\"同步用户\"标签以查明原因!"
    GRM_L["Time as Member:"] = "入会时长:"
    GRM_L["|CFFE6CC7FClick|r to select player event"] = "|CFFE6CC7F点击|r以选择玩家活动"
    GRM_L["Timestamp Format:"] = "时间戳格式:"
    GRM_L["Hour Format:"] = "小时格式:"
    GRM_L["24 Hour"] = "24小时"
    GRM_L["12 Hour (am/pm)"] = "12小时 (上午/下午)"
    GRM_L["Enable Fade on Tab Change"] = "启用切换标签时淡入淡出效果"
    GRM_L["Confirm Custom Note"] = "确认自定义备注"

    -- R1.1520
    GRM_L["A new rank has been added to the guild!"] = "公会新增了1个会阶!"
    GRM_L["{num} new ranks have been added to the guild!"] = "公会新增了{num}个会阶!"
    GRM_L["The guild has removed a rank!"] = "公会移除了1个会阶!"
    GRM_L["{num} guild ranks have been removed!" ] = "公会移除了{num}个会阶!"
    GRM_L["Edit Ban"] = "编辑黑名单状态"
    GRM_L["Please Select a Player to Edit their Ban!"] = "选择一个玩家以编辑其黑名单状态!"
    GRM_L["Update Ban"] = "更新黑名单状态"
    GRM_L["{name}'s Ban Info has Been Updated!"] = "{name}的黑名单状态已更新!"

    -- R1.1530
    GRM_L["{name} plays the {custom1} class, not {custom2}."] = "{name}的职业是{custom1}而非{custom2}."            -- Example: Arkaan plays the Hunter class, not Paladin.
    GRM_L["{num} Items Updated"] = "{num}个物品已更新"
    GRM_L["You Currently Have Disabled Adding Events to Calendar"] = "向日历添加活动功能已禁用"

    -- R1.20
    GRM_L["|CFFE6CC7FHold Shift|r to view more alt details."] = "|CFFE6CC7F按住Shift|r显示更多小号信息。"               -- "Hold Shift to view more alt details" is the phrase, but the |CFF|r is the text coloring hex code. Please keep it in there on the keyboard command coloring
    GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7F点击|r显示更多小号信息。"
    GRM_L["{custom1} to keep alt details open."] = "{custom1}以保持显示小号信息。"              -- The same can be said here. ^^
    GRM_L["|CFFE6CC7FClick|r to flip player name ordering"] = "|CFFE6CC7F点击|r按照玩家名称反向排列"                -- and the reset...
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Newest"] = "|CFFE6CC7F点击|r按照加入日期由新到旧排列"
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Oldest"] = "|CFFE6CC7F点击|r按照加入日期由旧到新排列"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Newest"] = "|CFFE6CC7F点击|r按照晋升日期由新到旧排列"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Oldest"] = "|CFFE6CC7F点击|r按照晋升日期由旧到新排列"
    GRM_L["|CFFE6CC7FClick|r to sort all Mains first"] = "|CFFE6CC7F点击|r按照主号优先排列"
    GRM_L["|CFFE6CC7FClick|r to sort all Alts first."] = "|CFFE6CC7F点击|r按照小号优先排列"
    GRM_L["{name}'s Alts"] = "{name}的小号"                                  -- Like "Arkaan's Alts"
    GRM_L["GRM window will open when combat ends."] = "GRM窗口会在离开战斗后打开。"

    -- R1.24
    GRM_L["This also will change the <Alt> format to match"] = "此选项也会改变<小号>格式"
    GRM_L["M"] = "主"                                           -- Of note, the "M" is short for "Main" and this is the reference to the main tag on alts in guild chat. For use in the Main tagging <M> (M) etc...
    GRM_L["A"] = "小"

    -- R1.25
    GRM_L["Include \"Joined:\" tag with the date."] = true                                        -- the \" is so you include the qutoations in the actual text. You need them or it closes the phrase.
    GRM_L["GRM Auto-Detect! {name} has joined the guild and will be set as Main"] = "GRM自动检测：{name}加入了公会，此角色已被设为主号。"           -- Main auto-detect message

    -- R1.26
    GRM_L["Click to Disable Sync of Custom Note"] = "点击以禁用自定义备注同步"
    GRM_L["Click to Enable Sync of Custom Note"] = "点击以启用自定义备注同步"

    -- R1.27
    GRM_L["Show Border on Public, Officer, and Custom Notes"] = "为公共备注、官员备注及自定义备注添加边框"

    -- R1.28
    GRM_L["Public Note:"] = "公共备注:"
    GRM_L["Officer Note:"] = "官员备注:"
    GRM_L["Public Note"] = "公共备注"
    GRM_L["Officer Note"] = "官员备注"
    GRM_L["Show Public, Officer, and Custom Notes on Log Entries of Left Players"] = "在日志中显示离开公会成员的公共备注、官员备注及自定义备注"
    GRM_L["Hard Reset"] = "强制重置"
    GRM_L["Hard reset of ALL GRM data, account-wide. Game will reload!"] = "为此账号强制重置所有GRM数据，游戏将重载！"
    GRM_L["Only recommend to kick if all player linked alts exceed max time"] = "建议只在该玩家的小号超出最大数量时才将其踢出。"
    GRM_L["Your Guild Leader Has Set Sync Restrictions to {name} or Higher"] = "只有 {name} 及以上的会阶成员才能同步。"
    GRM_L["Unable to Change Rank. Guild Leader has set restriction to {name} or higher"] = "无法更改会阶，此功能只开放给 {name} 及以上会阶的成员。"    -- Like Initiate or higher
    GRM_L["Unable to Change Rank. Guild Leader has set restriction level."] = "无法更改会阶，此功能为限制开放。"
    GRM_L["Force Settings with Guild Info Tags"] = "强制按照公会信息修改设置"
    GRM_L["Database Still Loading. GRM will open automatically when finished."] = "读取数据库中，GRM将在读取完毕后自动打开。"

    -- R1.29
    GRM_L["The highlighted character is not valid for messages. Please remove."] = "信息中无法含有高亮部分字符，请移除。"
    GRM_L["Not all characters are valid. Please remove any non-text characters."] = "含有无效字符，请移除任何非文字字符。"
    GRM_L["Kick macro created. Press \"CTRL-SHIFT-K\" to kick all of {name}'s alts"] = "踢出宏已创建。按 \"CTRL-SHIFT-K\" 以将 {name} 的所有小号踢出公会。"
    GRM_L["Kick the Player's {num} alts too?"] = "要将此玩家的 {num} 个小号一同踢出吗？"      -- Plural
    GRM_L["Kick the Player's {num} alt too?"] = "要将此玩家的 {num} 个小号一同踢出吗？"       -- Not Plural  - "Kick the Player's 1 alt too?"
    GRM_L["Ban and Kick the Player's {num} alts too?"] = "要将此玩家的 {num} 个小号一同加入黑名单并踢出吗？"
    GRM_L["Ban and Kick the Player's {num} alt too?"] = "要将此玩家的 {num} 个小号一同加入黑名单并踢出吗？"

    -- R1.30
    GRM_L["Sync With {name} is Complete..."] = "与 {name} 的同步已完成..."
    GRM_L["|CFFE6CC7FLeft-Click|r and drag to move this button."] = "|CFFE6CC7F点击|r 并拖动此按钮。"
    GRM_L["{custom1} and drag to move this button anywhere."] = "{custom1} 并拖动以将此按钮移动至任何位置。"
    GRM_L["MOTD:"] = "今日信息:"      -- Message Of The Day = M.O.T.D = MOTD -
    GRM_L["minimap"] = "小地图"

    -- R1.31
    GRM_L["Show 'Main' Tag on both Mains and Alts in Chat"] = "在聊天中主号与小号都显示'主号'标签"

    -- R1.32
    GRM_L["GRM has moved the Guild Leader setting restriction codes to the Guild Info tab."] = "GRM已将公会领袖设置限制的代码迁移至公会信息标签。"
    GRM_L["Please make room for them and re-add."] = "请增加空间并重新添加。"
    GRM_L["Your Guild Leader Has Set BAN Sync Restrictions to {name} or Higher"] = "只有 {name} 及以上的会阶成员才能同步黑名单。"
    GRM_L["Your Guild Leader Has Set CUSTOM NOTE Sync Restrictions to {name} or Higher"] = "只有 {name} 及以上的会阶成员才能同步自定义备注。"

    -- R1.33
    GRM_L["Macro will auto-remove after {num} seconds."] = "宏将在 {num} 秒后自动移除。"
    GRM_L["UI Controls"] = "界面控制"
    GRM_L["UI Configuration:"] = "界面设置:"
    GRM_L["Show Character Guild Reputation"] = "显示角色的公会声望"
    GRM_L["Show Guild Member Birthdays"] = "显示公会成员的生日"
    GRM_L["Set Birthday"] = "设定生日"
    GRM_L["Edit Birthday"] = "编辑生日"
    GRM_L["Remove Date"] = "移除生日"            -- Clear Birthday shorthand
    GRM_L["Birthday"] = "生日"
    GRM_L["Only Announce Birthdays and Anniversaries if Listed as 'Main'"] = "只公告'主号'的生日及周年日"
    GRM_L["{name} will be celebrating {num} year in the Guild!"] = "这天是 {name} 加入公会 {num} 周年纪念日!"           -- {custom1} will reference the DATE. Ex: "Arkaan will be celebrating 1 year in the Guild! ( 1 May )" - SINGULAR
    GRM_L["{name} will be celebrating {num} years in the Guild!"] = "这天是 {name} 加入公会 {num} 周年纪念日!"          -- Same thing but PLURAL - "years" in stead of "year"
    GRM_L["No player's currently available to sync {name}'s Guild Data..."] = "无法与任何玩家同步 {name} 的公会信息..."
    GRM_L["{name} has set {name2}'s Birthday: {custom1}"] = "{name} 已将 {name2} 的生日设为: {custom1}"                  -- custom note is the date like "12 Dec"
    GRM_L["{name}'s Birthday has been set: {custom1}"] = "{name} 的生日已被设为: {custom1}"

    -- R1.34
    GRM_L["Debugging Enabled"] = "启用调试"
    GRM_L["Debugging Disabled"] = "禁用调试"
    GRM_L["{num} is not a valid day of the month! It must be a number between 1 and 31"] = "{num} 为无效日期，请选择1至31之间的数字。"
    GRM_L["{num} is not a valid index of the month of the year! It must be a number between 1 and 12"] = "{num} 为无效月份，请选择1至12之间的数字。"
    GRM_L["The day cannot be {num}. It must be a number between 1 and 31"] = "日期不能为 {num}，请选择1至31之间的数字。"
    GRM_L["The month cannont be {num}. must be a number between 1 and 12"] = "月份不能为 {num}，请选择1至12之间的数字。"
    GRM_L["{num} birthdays have been reset."] = "{num} 个生日信息已被重置。"
    GRM_L["No player was found to have that birthday."] = "没有玩家在这天过生日。"

    -- R1.35
    GRM_L["Your Guild Leader Has Set Join Dates to only be added to the {name}"] = "只能在 {name} 中添加加入日期"        -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...
    GRM_L["Warning - Global Controls:"] = "警告 - 全局设置:"
    GRM_L["Sync Restrictions Globally Changed to {name} or Higher"] = "同步限制全局设置已改为 {name} 或更高的会阶成员"
    GRM_L["BAN Sync Restrictions Globally Changed to {name} or Higher"] = "黑名单同步限制全局设置已改为 {name} 或更高的会阶成员"
    GRM_L["CUSTOM NOTE Sync Restrictions Globally Changed to {name} or Higher"] = "自定义备注同步限制全局设置已改为 {name} 或更高的会阶成员"
    GRM_L["Join Dates Globally Changed to only be added to the {name}"] = "加入日期全局设置已改为仅为 {name} 添加"
    GRM_L["Unable to Modify. Global setting is set to the {name}"] = "无法修改，全局设置为 {name}"                          -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...

    -- R1.37
    GRM_L["No Action Configured"] = "无设置修改"
    GRM_L["OLD LOG"] = "旧日志"
    GRM_L["CHANGES"] = "变更"
    GRM_L["Sync has failed to start. Please try again!"] = "无法同步，请再试一次!"
    GRM_L["Please wait {num} more seconds before manually initiating the sync process again."] = "请等待 {num} 秒后再手动启动同步。"

    -- R1.39
    GRM_L["Only Report if there are no Active Alts in the Group"] = "仅在所有小号也未活跃时通告"
    GRM_L["Level Filter Minimum:"] = "通告的最低等级:"                               -- As in player level
    GRM_L["Report Milestones:"] = "通告里程碑:"
    GRM_L["Report Level Up Changes"] = "通告升级"
    GRM_L["Reporting:"] = "通告范围:"
    GRM_L["Unable to disable level cap tracking. Please disable ALL tracking to turn off."] = "无法禁用最高等级追踪，请禁用所有追踪。"
    GRM_L["No Levels to Report to Log"] = "无等级可通告"
    GRM_L["{name} has Surpassed their Level {num} Milestone and is Now {custom1}"] = "{name} 已超过其 {num} 级的里程碑，现在是 {custom1} 了"
    GRM_L["{name} has Reached their Level {num} Milestone"] = "{name} 已达到其 {num} 级的里程碑"
    GRM_L["{name}'s Ban has been Updated by {name2}!"] = "{name} 的黑名单状态已被 {name2} 更新!"
    GRM_L["{name} has Updated {name2}'s BAN and also BANNED all linked alts from the guild!"] = "{name} h更新了 {name2} 的黑名单状态并将其在公会中的所有小号加入黑名单!"
    GRM_L["One moment, GRM is still being configured."] = "请稍后, GRM仍在设置中。"
    GRM_L["Player Was Banned By: {name}"] = "玩家已被加入黑名单，操作者： {name}"
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED players are currently in the guild."] = "|cffff0000警告!!!|r 公会中有 {num} 个位于黑名单中的玩家。"    -- plural
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED player is currently in the guild."] = "|cffff0000警告!!!|r 公会中有 {num} 个位于黑名单中的玩家。"       -- Singular  -- please keep the color coding... this keeps the Warning in red

    -- R1.41
    GRM_L["Auto-Focus the search box"] = "自动聚焦搜索栏"
    GRM_L["This will skip the first time if set to load on logon"] = "如果设为登录时读取，则将跳过第一次。" -- Referring to the auto-focusing on the search box, this is a tooltip helper
    GRM_L["Please enter a valid level between 1 and {num}"] = "请从 1 至 {num}中选择一个有效等级"
    GRM_L["Player's Main: {name}"] = "玩家的主号: {name}"

    -- R1.43
    GRM_L["One moment, requesting additional details on {name} from the server. Ban List will soon update."] = "请等待，正在从服务器获取 {name} 的额外数据，黑名单将在稍后更新。"
    GRM_L["Unable to identify {name}. Ensure your spelling is accurate and the correct realm is selected!"] = "未找到 {name} ，请输入正确的角色名并选择正确的服务器名！"
    GRM_L["(Unable to Identify)"] = "(未找到)"                                                                   -- As in, unable to identify on the server, they possibly server transferred off but are still on ban list
    GRM_L["|CFFE6CC7FClick|r to select player class"] = "|CFFE6CC7F点击|r 选择玩家职业。"
    GRM_L["|CFFE6CC7FClick|r to select player's realm."] = "|CFFE6CC7F点击|r 选择玩家服务器。"
    GRM_L["All Connected Realms are available to choose."] = "可选择所有合并服务器。"
    GRM_L["{num} players were found to have the same name. Please manually select the player's realm"] = "找到 {num} 个此名字的玩家，请手动选择玩家所在的服务器"
    GRM_L["Click or Press TAB to cycle through each step."] = "左键点击或按TAB切换各个步骤。"
    GRM_L["Former and Current Members"] = "前成员及现有成员"
    GRM_L["No Matches Found. Add a Custom New Player or Match"] = true       -- as in, autocomplete typing matching

    --1.50
    GRM_L["{name}'s alt grouping has had their Birthday removed by: {name2}"] = "{name} 及其所有角色的生日已被 {name2} 移除"
    GRM_L["{name}'s Birthday has been removed by: {name2}"] = "{name} 的生日已被 {name2} 移除"
    GRM_L["Click to Sort"] = "点击以排序"
    GRM_L["No Updates"] = "无更新"
    GRM_L["Timestamp Formatting has been Globally Set to: < {name} >"] = "全局时间戳格式已被设置为 < {name} >"
    GRM_L["Your Guild Leader Has Globally Set the Timestamp Formatting to: < {name} >"] = "全局时间戳格式已被公会领袖设置为 < {name} >"
    GRM_L["Unable to Modify. Global setting is set to :   {name}"] = "无法修改，全局设置已被设置为: {name}"

    -- 1.52
    GRM_L["Times in Guild: {num}"] = "加入公会次数： {num}"

    -- 1.56
    -- More slash commands
    GRM_L["kick"] = true
    GRM_L["ban"] = true
    GRM_L["audit"] = true
    GRM_L["log" ] = true
    GRM_L["event"] = true
    GRM_L["events"] = true
    GRM_L["users"] = true
    GRM_L["syncusers"] = true
    GRM_L["opt"] = true
    GRM_L["option"] = true
    GRM_L["options"] = true

    GRM_L["GRM Date"] = "GRM日期"
    GRM_L["Note Date"] = "备注日期"
    GRM_L["Status"] = "状态"
    GRM_L["Refresh"] = "刷新"
    GRM_L["Clear Selection"] = "清除选择"
    GRM_L["Fix all mismatched note dates with GRM saved date"] = "用GRM保存的数据来修复所有不匹配的备注日期。"
    GRM_L["Fix selected mismatched note dates with GRM saved date"] = "用GRM保存的数据来修复所选择的不匹配的备注日期。"
    GRM_L["Fix all mismatched GRM dates with the note date"] = "用备注日期数据来修复所有GRM的不匹配日期。"
    GRM_L["Fix selected mismatched GRM dates with the note date"] = "用备注日期数据来修复所选择的GRM的不匹配日期。"
    GRM_L["Import all missing join dates from the note date"] = "将备注日期导入至所有缺失的加入日期"
    GRM_L["Import selected missing join dates from the note date"] = "将备注日期导入至所选择的缺失加入日期"
    GRM_L["Add all missing saved dates to the {name}"] = "为 {name} 添加所有缺失的保存日期"
    GRM_L["Add selected missing saved dates to {name}"] = "为 {name} 添加所选择的缺失保存日期"
    GRM_L["Clear all join dates from incorrect note locations"] = "从错误的备注位置中清除所有的加入日期"
    GRM_L["Clear selected join dates from incorrect note locations"] = "从错误的备注位置中清除所选择的加入日期"
    GRM_L["Not Found"] = "未找到"
    GRM_L["Not Set"] = "未设置"
    GRM_L["Complete"] = "完成"
    GRM_L["Multiple"] = "多个"
    GRM_L["Location"] = "位置"

    -- JD tool button actions and tooltips
    GRM_L["|CFFE6CC7FShift-Click|r Second Button to Select All In-Between"] = "|CFFE6CC7FShift左键|r 第二个按钮以选择之间的所有"
    GRM_L["|CFFE6CC7FClick|r to select player"] = "|CFFE6CC7F点击|r 以选择玩家"
    GRM_L["Only Show Players With Incomplete Status"] = "仅显示状态不完整的玩家"
    GRM_L["{num} Join Dates Need Attention"] = "{num} 个加入日期需特别注意"            -- In other words, "155 join dates need attention" as an example
    GRM_L["Do you really want to remove the join dates from notes other than the {name}?"] = "确认将除 {name} 以外所有的加入日期从备注中清除吗?"
    GRM_L["Do you really want to fix mismatched dates using the note?"] = "确认使用备注来修复所有不匹配的日期吗?"
    GRM_L["Do you really want to fix note dates using the saved GRM dates?"] = "确认使用GRM日期来修复备注中的日期吗?"
    GRM_L["Do you really want to add the missing join dates to the {name}?"] = "确认将确实的加入日期写入 {name}?"                    -- add the missing join dates to the default note name - like "... to the Officer Note?"
    GRM_L["Auto-adding join dates to the {name} is disabled. Do you still wish to continue?"] = "自动向 {name} 添加加入日期的功能已被禁用，仍要继续吗?"   -- Just as above
    GRM_L["There are currently {num} mismatched dates to fix"] = "有 {num} 个不匹配的日期需要修复"
    GRM_L["There are currently no mismatched dates that need to be fixed."] = "没有不匹配的日期需要修复。"
    GRM_L["There are currently no dates that need to be imported."] = "没有日期需要导入。"
    GRM_L["There are currently no dates that can be added to the default note."] = "没有日期可以加入默认备注。"
    GRM_L["There are currently no dates that need to be removed from incorrect notes"] = "没有日期需要从错误的备注种类中清除"
    GRM_L["There are currently {num} players who have join dates listed in the incorrect note"] = "有 {num} 名玩家的加入日期位于错误的备注种类中"
    GRM_L["Warning! Your function is extremely limited without officer permissions"] = "警告! 没有公会官员的许可，你的功能将受限"
    GRM_L["Advanced Join Date Tool" ] = "进阶加入日期工具"

    -- JD tool reasons
    GRM_L["Mismatched dates"] = "不匹配的日期"
    GRM_L["Matching date found in wrong note location"] = "在错误的位置中找到匹配的日期"
    GRM_L["Date not added to note"] = "日期未加入到备注中"
    GRM_L["Mismatched dates, and found in wrong note location"] = "不匹配的日期，且位于错误的备注种类中"
    GRM_L["Mismatched date found in multiple locations, including correct"] = "在多处找到不匹配的日期，有位于正确的位置"
    GRM_L["Mismatched date found in multiple incorrect note locations"] = "在多处错误位置中找到的不匹配的日期"
    GRM_L["Matching date found in multiple incorrect note locations"] = "在多处错误位置中找到的匹配的日期"
    GRM_L["Matching date found in multiple locations, including correct"] = "在多处找到匹配的日期，有位于正确的位置"
    GRM_L["Date found in incorrect note, but not yet imported"] = "在错误的备注中找到日期，且该日期还未导入"
    GRM_L["Date found in multiple incorrect notes, but not yet imported"] = "在多处错误的备注中找到日期，且日期还未导入"
    GRM_L["Date found in multiple locations, including correct, but not yet imported"] = "在多处备注中找到日期，有日期位于正确的备注中，且日期还未导入"
    GRM_L["Date found in correct note location, but not yet imported"] = "在正确的备注中找到日期，但该日期还未导入"

    -- More misc.
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been set to be added to join date note entries."] = "已设置在加入日期备注中自动添加\"{name}\" 和 \"{name2}\" 标签。"
    GRM_L["The \"{name}\" and \"{name2}\" tags have globally been disabled from adding to join date note entries."] = "在加入日期备注中自动添加\"{name}\" 和 \"{name2}\" 标签的设置已禁用。"
    GRM_L["Your rank has changed. Re-evaluating sync permissions."] = "你的会阶已改变，请重新确认同步许可。"

    -- 1.57
    GRM_L["Full Log Message:"] = "完整日志信息:"
    GRM_L["Log Entry Tooltip"] = "日志项鼠标提示"
    GRM_L["1 entry has been removed from the log"] = "从日志中清除了 1 项"
    GRM_L["{num} entries have been removed from the log"] = "从日志中清除了 {num} 项"

    -- 1.59
    GRM_L["Adding the Join Date cannot be disabled due to the global setting"] = "因与全局设置冲突，无法禁用添加加入日期的功能"
    GRM_L["Due to your current rank, you will be unable to add Join Date Timestamps"] = "你的当前会阶不允许你添加加入日期时间戳"
    GRM_L["Warning! Due to your rank you will be unable to add Join Date timestamps to the {name}"] = "警告! 你的当前会阶不允许你向{name}添加加入日期时间戳"
    GRM_L["Unable to Modify Format:  {name}"] = "无法修改格式:  {name}"
    GRM_L["Show Mouseover"] = "显示鼠标指向"
    GRM_L["Unable to create GRM hotkey macro. You currently are at the cap of {num} macros."] = "无法创建GRM热键宏，你的当前宏已达到{num}个的最大数目。"

    -- 1.60
    GRM_L["Really remove {name} Backup Point?"] = "确认要清除{name}的备份点?"     -- The {name} is the guildName

    -- 1.63
    GRM_L["Disabled"] = "已禁用"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays January to December"] = "|CFFE6CC7F点击|r按照生日月份升序排列"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays December to January"] = "|CFFE6CC7F点击|r按照生日月份降序排列"

    -- 1.64
    GRM_L["Chat Window for All GRM Messages:"] = "所有GRM信息的聊天窗口:"
    GRM_L["\"{name}\" Chat Window\nDo you wish to create it?" ] = "\"{name}\"聊天窗口\n确认创建?"             -- the \n indicates a line break.
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you close this one."] = "如果关闭此窗口，GRM会自动将信息发送至\"{name}\"窗口"
    GRM_L["Channel Settings Are Character Specific and Will Not Be Sync'd"] = "频道设置为角色专有，无法被同步"

    -- 1.66
    GRM_L["Custom Join Tag:"] = "自定义加入标签:"
    GRM_L["Custom Rejoin Tag:"] = "自定义重新加入标签:"
        -- Join Tag
    GRM_L["Custom Join Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "无法设置自定义加入标签\"{name}\"，此标签含有{num} 个字符，已超过{custom1}个字符的上限。"
    GRM_L["Custom Join Tag has been changed from \"{name}\" to \"{name2}\""] = "自定义加入标签\"{name}\"已被修改为\"{name2}\""
    GRM_L["Custom Join Tag has been set to \"{name}\""] = "\"{name}\"已被设置为自定义加入标签"
    GRM_L["Your Guild Leader has changed the Custom Join Tag from \"{name}\" to \"{name2}\""] = "公会领袖已把自定义加入标签\"{name}\"修改为\"{name2}\""
    GRM_L["Your Guild Leader has set the Custom Join Tag to \"{name}\""] = "\"{name}\"已被公会领袖设置为自定义加入标签"
        -- Rejoin Tag
    GRM_L["Custom Rejoin Date Tag \"{name}\" cannot be set as it is {num} characters. The max is {custom1}."] = "无法设置自定义重新加入标签\"{name}\"，此标签含有{num} 个字符，已超过{custom1}个字符的上限。"
    GRM_L["Custom Rejoin Tag has been changed from \"{name}\" to \"{name2}\""] = "自定义重新加入标签\"{name}\"已被修改为\"{name2}\""
    GRM_L["Custom Rejoin Tag has been set to \"{name}\""] = "\"{name}\"已被设置为自定义重新加入标签"
    GRM_L["Your Guild Leader has changed the Custom Rejoin Tag from \"{name}\" to \"{name2}\""] = "公会领袖已把自定义重新加入标签\"{name}\"修改为\"{name2}\""
    GRM_L["Your Guild Leader has set the Custom Rejoin Tag to \"{name}\""] = "\"{name}\"已被公会领袖设置为自定义重新加入标签"

     -- 1.67
    -- Note, lots of plural/singular forms here for just a superior user experience, albeit a bit of extra work
    GRM_L["Kick"] = "踢出"
    GRM_L["Promote"] = "升阶"
    GRM_L["Demote"] = "降阶"
    GRM_L["Macro:"] = "宏:"
    GRM_L["Macro Size: {num}/255"] = "宏字数: {num}/255"       -- "Macro Size: 242/255"
    GRM_L["Action"] = "操作"
    GRM_L["Ignored Action:"] = "忽略的操作:"                -- As in, the action being ignored, be it kick or promote or demote.
    GRM_L["Click to Build Macro"] = "点击以创建宏"
    GRM_L["No Current Names to Add"] = "无现有名字可添加"
    GRM_L["No Names to Add to the Macro"] = "无名字可添加至宏"
    GRM_L["Hot Key: {name}"] = "热键: {name}"
    GRM_L["Permissions"] = "许可"
    GRM_L["Player rank change detected, re-checking permissions and rebuilding GRM Macro Tool."] = "检测到会阶变化，重新确认许可并重新创建GRM宏工具。"
    GRM_L["Click to remove selected names from the macro"] = "点击以将名字从宏中移除"          -- Plural form of statement
    GRM_L["Click to remove selected name from the macro"] = "点击以将名字从宏中移除"           -- Singular form of statement
    GRM_L["Click to remove selected names from Ignore List"] = "点击以将名字从忽略名单中移除"        -- Plural
    GRM_L["Click to remove selected name from Ignore List"] = "点击以将名字从忽略名单中移除"         -- Singular
    GRM_L["No names selected to remove from macro"] = "未从宏中移除名字"
    GRM_L["No names selected to remove from Ignore List"] = "未从忽略名单中移除名字"
    GRM_L["Macro is currently empty"] = "宏是空的"
    GRM_L["{num} players removed from the macro"] = "{num}名玩家已从宏中移除"                   -- plural form of the statement
    GRM_L["{num} player was removed from the macro"] = "{num}名玩家已从宏中移除"                -- singular form of the statement
    GRM_L["{num} players removed from the Ignored List"] = "{num}名玩家已从忽略名单中移除"
    GRM_L["{num} player was removed from Ignore List"] = "{num}名玩家已从忽略名单中移除"
    GRM_L["There are no names currently selected to be removed from the Ignore List."] = "未选择要从忽略名单中移除的名字。"
    GRM_L["There are no names currently selected to be removed from the macro."] = "未选择要从宏中移除的名字。"
    GRM_L["The macro is not yet built. Please click the button to create the macro."] = "未创建宏，请点击按钮创建宏。"
    GRM_L["Nothing to clear"] = "无内容可清除"
    GRM_L["There are currently no names to add"] = "无名字可添加"
    GRM_L["There are currently no names to remove"] = "无名字可移除"
    GRM_L["Rules"] = "规则"
    GRM_L["Please choose a day between 1 and 999"] = "请从1到999中选择一天"
    GRM_L["Please choose a day between 0 and 999"] = "请从0到999中选择一天"
    GRM_L["Pressing the ESC key will also clear all lines"] = "按下ESC键也会清除所有行"
    GRM_L["Player's rank does not have permission to remove others from the guild"] = "玩家没有将成员踢出公会的许可"
    GRM_L["Player's rank does not have permission to promote others in the guild"] = "玩家没有将成员升阶的许可"
    GRM_L["Player's rank does not have permission to demote others in the guild"] = "玩家没有将成员降阶的许可"

    GRM_L["Queued Actions"] = "队列中的操作"
    GRM_L["Current Actions"] = "当前操作"
    GRM_L["View Ignore List"] = "查看忽略名单"
    GRM_L["No players are currently safe from recommendations"] = true
    GRM_L["1 player is on the safe list."] = "1位玩家位于安全名单中。"
    GRM_L["{num} players are on the safe list."] = "{num}位玩家位于安全名单中。"
    GRM_L["1 action is being ignored."] = "1个操作已被忽略。"
    GRM_L["{num} actions are being ignored."] = "{num}个操作已被忽略。"
    GRM_L["No current actions are being ignored"] = "没有当前操作被忽略"
    GRM_L["Actions Ignored:"] = "操作已被忽略:"
    GRM_L["Total Queued:"] = "队列中共有:"
    GRM_L["Ignored Players Safe From Action"] = "操作不会影响被忽略的玩家"
    GRM_L["Only show players with ignored action"] = "仅显示操作忽略的玩家"
    GRM_L["No players on Ignore List"] = "忽略名单中没有玩家"
    GRM_L["No players to select. 1 player filtered"] = "没有可选择的玩家，已过滤1名玩家。"                    -- Singular
    GRM_L["No players to select. {num} players filtered"] = "没有可选择的玩家，已过滤{num}名玩家。"               -- Plural
    GRM_L["There are no names to select. 1 player is filtered"] = "没有可选择的名字，已过滤1名玩家。"         -- these 2 statements might seem redundant, but often the text on a button is more short hand. This gives a cleaner statement in the chat. Useful for translating in some languages that need a bit more room to be more clear.
    GRM_L["There are no names to select. {num} players are filtered"] = "没有可选择的名字，已过滤{num}名玩家。"
    GRM_L["Really remove selected player from the ignore list?"] = "真的要将所选玩家从忽略名单中移除吗?"
    GRM_L["Really remove the {num} selected players from the ignore list?"] = "真的要将所选的{num}名玩家从忽略名单中移除吗?"
    GRM_L["Do you really wish to clear all players from the Ignore List?"] = "真的要将所有玩家从忽略名单中移除吗?"

    GRM_L["There are currently no players on the Ignore List"] = "忽略名单中无玩家"
    GRM_L["Remove all players from Ignore List"] = "将所有玩家从忽略名单中移除"
    GRM_L["Ignored Players: {num}"] = "已忽略玩家: {num}"
    GRM_L["Tool"] = "工具"                                            -- /grm tool
    GRM_L["Macro Tool"] = "宏命令工具"
    GRM_L["Macro Tool: {num}"] = "宏命令工具: {num}"

    -- CLASSIC
    GRM_L["Social"] = "社交"
    GRM_L["Roster"] = "名单"
    GRM_L["Feature is disabled in WoW Classic"] = "功能在魔兽世界怀旧服中被禁用"
    GRM_L["Feature is disabled in TBC Classic"] = "功能在燃烧的远征怀旧服中被禁用"         -- Just laying groundwork now in case Blizz ever releases it. Calendar was not added until WOTLK
    GRM_L["(Classic)"] = "(怀旧服)"      -- tooltip tag that shows only on the minimap mosueover version tooltip in Classic

    -- 1.69
    GRM_L["Importing dates must be done in a compatible format"] = "导入的日期必须是兼容的格式"
    GRM_L["The date selection in OPTIONS shows all supported"] = "请前往设置标签的日期选择查看所有支持的格式"
    GRM_L["Headers, like \"Joined,\" are supported"] = "支持使用标头, 例如：\"加入于\""
    GRM_L["To confirm or edit the date, open the player window, right click the date, edit, and submit"] = "若要确认或编辑日期，请打开玩家窗口，右键日期并编辑，然后提交"       --The "!!" tags are the {name}
    GRM_L["To confirm or edit the date, right click the date, edit, and submit"] = "若要确认或编辑日期，请右键日期并编辑，然后提交"    -- Slightly shorter explanation if already on player window
    GRM_L["The {name} tag indicates a date must be verified to sync"] = "{name}标签代表一个日期在同步前需被核实"

    -- 1.70
    GRM_L["GRM has errored due to a previous incompatible build with Classic that was enabled. Click YES to reload UI and fix the issue"] = "由于存在旧的与怀旧服不兼容的版本，GRM出现错误，点击确认以重载界面并修复此问题。"

    -- 1.71
    GRM_L["(Disabled in Classic)"] = "(在怀旧服中禁用)"          -- For the Options... rather than removing them all

    -- 1.73
    GRM_L["{name} is no longer in the Guild!"] = "{name}已不是公会成员!"      -- There should really be 3 options. They got kicked, they left on their own, or if not found in the event log, they are just no longer in the guild
    GRM_L["is no longer in the Guild!"] = "已不是公会成员!"             -- THIS MUST MATCH THE PREVIOUS LINE with missing name.
    GRM_L["Applying update patches... one moment."] = "正在应用更新补丁...请稍后。"
    GRM_L["Update Complete... {num} patches applied."] = "更新完成...应用了{num}个补丁。"  -- Plural
    GRM_L["Update Complete... 1 patch applied."] = "更新完成...应用了1个补丁。"        -- Singular version
    GRM_L["Disabling will also hide the Birthday info on the roster mouseover window"] = "禁用此项也会在名单鼠标提示中隐藏生日信息"      -- Enable/disable birthday chekbox on UI Options and the Audit windoppw
    GRM_L["Confirm Date"] = "确认日期"
    GRM_L["If the date is accurate, right click and select 'Confirm Date'"] = "如果日期正确，请右键点击并选择“确认日期”"

     -- 1.74
    GRM_L["Class Colorize Names in Guild Member Alerts"] = "在公会成员警告中以职业色显示名字"
    GRM_L["All player custom notes re-enabled for sync and their checkboxes set."] = true

    -- 1.75
    GRM_L["!note"] = true               -- !note in English will always work. This gives you the option of creating your own key to register a public note.
    GRM_L["No officer online to set {name}'s note"] = "无官员在线，无法设置{name}的备注"
    GRM_L["No officer is currently online to update your note"] = "无官员在线，无法更新你的备注"
    GRM_L["Allow Guild Members to Type \"!note notehere\" to Set Their Own Public Note"] = "允许公会成员输入\"!note notehere\"以设置他们自己的公共备注"
    GRM_L["Enabled"] = "已启用"        -- As in, the opposite of Disabled
    GRM_L["'!note' trigger has been globally ENABLED"] = "'!note'触发已启用"
    GRM_L["'!note' trigger has been globally DISABLED"] = "'!note'触发已禁用"

    -- 1.76
    GRM_L["Same Rank"] = "相同会阶"                                                                  -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Higher Rank"] = "更高的会阶"                                                                -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Limited Features. There is no Calendar in Classic"] = "怀旧服无日历，此功能受限"                          -- Events Tab top warning
    GRM_L["This only affects settings for your current guild: {name}"] = "此设置只会影响你当前所在的公会: {name}"                  -- Tooltip for Options > General > Sync settings to all alts in same guild
    GRM_L["GC"] = "全"                                                                         -- Options window, acronym for "Global Controls" and will be adjacent to all settings that have global controls
    GRM_L["*GC = Global Control - Use Guild Info to Force Setting For All"] = "*全 = 全局设置 - 强制用公会信息为所有人设定"             -- Top left Options window
    GRM_L["Set Global Controls"] = "设定全局设置"                                                     -- Options > Officer Tab > Bottom left export button
    GRM_L["Global Control Values Set in Guild Info"] = "将全局设置写入公会信息"                                    -- Export GuildInfo tool tooltip
    GRM_L["Configure your settings. Click to set in Guild Info"] = "调整你的设置，然后点击以写入公会信息"                                   -- Tooltip line 2- same as above
    GRM_L["Unable to add globals controls to GuildInfo. There is not enough room."] = "无法将全局设置添加到公会信息，没有足够的空间。"     -- If export of globals is not able to complete
    GRM_L["Global controls exported to the guild info note. Updating..."] = "全局设定已导出至公会信息文档，更新中..."               -- Success in exporting
    GRM_L["Your rank cannot edit the Guild Info"] = "你没有编辑公会信息的权限"                                             -- Mouseover tooltip helper for people without MOTD edit access
    GRM_L["All global controls are already set. You must Edit or Remove the settings manually in the guild Info."] = "全局设置已完成，你需要手动在公会信息中编辑或移除设置。"
    GRM_L["Do you really want to wipe all GRM data and settings account-wide?"] = "确认将此账号下的所有GRM数据移除吗?"
    GRM_L["Are you sure your settings are configured and ready for global controls?"] = "确认所有设定已完成并可以进入全局设定?"
    GRM_L["Players the same rank or higher will not be shown"] = "不会显示相同或更高会阶的玩家"
    GRM_L["Macro"] = "宏"      -- For the slash command  /grm tool or /grm macro - same thing

	-- 1.77
	GRM_L["Add Custom Rule"] = "添加自定义规则"        -- Kick Macro Tool - custom rule button right side
	GRM_L["Former Members"] = "前成员"         -- Export tool
	GRM_L["Data Export"] = "数据导出"
	GRM_L["*Max Export is 500 Log Entries at a Time"] = "*单次最多只能导出500条日志"
	GRM_L["*Max Export is 500 Members at a Time"] = "*单次最多只能导出500名成员"
	GRM_L["*Max Export is 500 Former Members at a Time"] = "*单次最多只能导出500名前成员"
	GRM_L["*Export obeys the current log display filters"] = "*导出会遵循现有的日志过滤规则"
	GRM_L["Select Line Range:"] = "选择条目范围:"
	GRM_L["Select Member Range:"] = "选择成员范围:"
	GRM_L["Export Selection"] = "导出选择项"
	GRM_L["Export Next {num}"] = "导出之后的{num}个"      -- As in, "Export next 500" names or log lines
	GRM_L["Export Prev {num}"] = "导出之前的{num}个"      -- As in, Export Previous name
	GRM_L["Total Members: {num}"] = "成员总计: {num}"
	GRM_L["Total Former Members: {num}"] = "前成员总计: {num}"
	GRM_L["Class"] = "职业"                      -- As in Class Name, there is currently a "Class:" we need one with the colon
	GRM_L["Guild Rep"] = "公会声望"                  -- Guild Faction reputation (abbreviated)
	GRM_L["Last Online (Days)"] = "上一次在线(天)"
	GRM_L["Spreadsheet Headers"] = "表格项目名"
	GRM_L["Auto Include Headers"] = "自动包含项目名"       -- Auto include headers on the export frame, as in the column headers for each category on member and former mebers
	GRM_L["These will only be included if exporting from the top of the table"] = "当从表格开头输出时才会包含这些项"     -- tooltip for the auto-Included export checkbutton
	GRM_L["Export"] = "导出"
	GRM_L["This will be rounded to the nearest day"] = "此日期将会被设为最近的日期"
	GRM_L["Clearing Log Export. A filter setting has been changed."] = "清除日志输出，过滤器被修改"            -- If the filter settings have been modified, the export string should be cleared and re-done
	GRM_L["No Tag"] = "无标签"                                                             -- Main Tag
	GRM_L["Delimiter:"] = "分隔符:"                                                         -- Delimiter selection for Export window
	GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7F点击|r以查看更多小号信息。"                        -- Calendar tooltip
	GRM_L["The selected delimiter will be removed from all notes on export"] = "在输出时会从所有文档中移除选择的分隔符"
	GRM_L["Choose thoughtfully"] = "请谨慎选择"
	GRM_L["{name}'s note has been updated!"] = "{name}的备注已被更新！"
	GRM_L["Locked. Press ESC"] = "已锁定，按ESC解锁"                                       -- Mouseover Locked text in top right.
	GRM_L["|CFFE6CC7FClick|r to Select for Removal"] = "|CFFE6CC7F点击|r以选择移除"
    GRM_L["Feel free to recommend a delimiter you wish to use to the author"] = "可联系作者添加你想要的分隔符"
    GRM_L["Export Tool"] = "导出工具"
    GRM_L["Opens the Data Export Tool"] = "打开数据导出工具"
    GRM_L["Opens the Advanced Macro Tool"] = "打开进阶宏命令工具"

    -- 1.78
    GRM_L["Hurray!"] = "好耶!"                                                             -- A short cheer! Like "Yay!" except "Hurray!"
    GRM_L["{name} has Reached the {num} Level Cap! {custom1}"] = "{name}已达到满级{num}级! {custom1}"                 -- Arkaan has Reached the 120 Level Cap! Hurray!

    -- 1.80
    GRM_L["Core Window:"] = "核心窗口:"
    GRM_L["Mouseover Player Details:"] = "鼠标指向玩家信息:"
    GRM_L["Macro Tool:"] = "宏命令工具:"
    GRM_L["Export Tool:"] = "导出工具:"
    GRM_L["Audit Join Date Tool:"] = "详单加入日工具:"
    GRM_L["Right-Click to Reset"] = "右键以重置"
    GRM_L["WARNING: Clear the text box before re-scaling or you may lock up your system"] = "警告: 为了防止系统锁定，请在调整尺寸前清除输入框的内容"
    GRM_L["Resets ALL settings, not just the ones on this page"] = "重置所有设置, 包括其他页面"
    GRM_L["Open MouseOver"] = "打开鼠标指向"
    GRM_L["Open Macro Tool"] = "打开宏命令工具"
    GRM_L["Open Export Tool"] = "打开导出工具"
    GRM_L["Open Join Date Tool"] = "打开加入日工具"

    -- 1.81
    GRM_L["Race"] = "种族"
    GRM_L["Sex"] = "性别"
    GRM_L["Male"] = "男性"
    GRM_L["Female"] = "女性"
    GRM_L["{name} {name2}"] = "{name2}{name}"         -- This might seem weird, but the format is "Race Sex" In other words, "Orc Male" or "Nightborne Female" and so on. Adjust how you see fit, it appears in the mouseover tooltip on the player name

    -- 1.82
    GRM_L["Disabled While Player is Grouped"] = "玩家在队伍中, 已被禁用"
    GRM_L["SYNC is currently disabled while you are grouped. Due to server restricted addon to addon talk data caps, and in an effort to avoid clogging up the shared global comm space of all addons, sync will be temporarily restricted while grouped."] = "当你在队伍中时同步将被禁用。原因：游戏服务器对插件之间的数据传递有最大限制，为了避免过多占用所有插件的共用沟通空间，当你在一个队伍中时同步将暂时被禁用。"

    -- 1.84
    GRM_L["The note is too long. Only the first {num} characters will be set."] = "备注过长, 将只写入前{num}个字符"
    GRM_L["Apply Only to Selected Ranks"] = "只对选择的会阶采用"
    GRM_L["Unable to create hotkey macro. Player is currently in combat and action is restricted. It will auto-build once out of combat."] = "战斗中无法创建热键宏, 玩家离开战斗后宏将自动创建。"
    GRM_L["No player data found, recommend full removal."] = "未找到玩家数据，建议完全移除。"
    GRM_L["OR"] = "或"     -- "Or" as in  This OR that  Use this button OR that button -- Advanced JD audit tool.
    GRM_L["Use Promo Date"] = "使用升阶日期"
    GRM_L["Use Join Date"] = "使用加入日期"
    GRM_L["Send to Promo Date"] = "发送至升阶日期"
    GRM_L["Send to Join Date"] = "发送至加入日期"
    GRM_L["(Press Tab to Cycle)"] = "(按TAB切换)"
    GRM_L["(Press Enter to Select)"] = "(按回车选择)"
    GRM_L["Setting join date to destination index {num} is not valid. Value must be between 0 and 3. Setting to default of Officer Note."] = "设定的加入日期目标索引{num}不可用，数值须为0到3之间。已设定为默认官员备注"
    GRM_L["Join Dates Globally Changed to no longer be added to the note when a player joins the guild"] = "已全局设置为不为新加入的成员添加加入日期"
    GRM_L["Your Guild Leader has disabled adding join dates to player notes"] = "添加加入日期至玩家备注已被公会领袖禁用"
    GRM_L["Unable to Modify. Global setting DISABLES adding the join date automatically. "] = "修改失败，自动添加加入日期已在全局设置禁用"
    GRM_L["General Sync"] = "综合同步"
    GRM_L["Ban Sync"] = "黑名单同步"
    GRM_L["Custom Sync"] = "自定义同步"
    GRM_L["Auto Join date"] = "自动加入日期"
    GRM_L["Include Headers"] = "包含标头"
    GRM_L["Join Header"] = "加入公会标头"
    GRM_L["ReJoin Header"] = "重新加入标头"
    GRM_L["!note Control"] = "!note控制"
    GRM_L["You need to clear {num} characters to fit the control tags"] = "控制标签过长，请删除至少{num}个字符"
    GRM_L["A new format exists for global settings controls."] = "全局设置控制已存在新格式"
    GRM_L["Go to GRM window > Options > Officer Tab > \"Set Global Controls\""] = "前往GRM窗口 > 设置 > 官员 > \"设定全局设置\""
    GRM_L["Remove the old format when all guildies have updated properly. You may wish to leave it in Guild Info until then."] = true
    GRM_L["It may take up to 60 seconds for other guild members to detect the changes and update."] = true
    GRM_L["Resets only the settings on this page"] = true
    GRM_L["Resets only the Export Settings"] = true
    GRM_L["Resets all Macro Tool Rules and Settings"] = true
    GRM_L["Are you sure you want to reset all Macro Tool Rules and Settings?"] = true
    GRM_L["Export settings to unify sync controls, timestamp format, and so on with your officers and members."] = true
    GRM_L["Consult with your guild leader and export settings to unify sync controls, timestamp format, and so on."] = true
    GRM_L["Global controls have not yet been set!"] = true
    GRM_L["Include Birthdays as Incomplete"] = true
    GRM_L["Make room and transfer before clearing"] = true
    GRM_L["1 player has a join date listed in the incorrect note."] = true             -- Singular (Join Date Audit tool - bottom button mouseover) - rare tooltip use
    GRM_L["{num} players have join dates listed in the incorrect note."] = true        -- Plural (same)
    GRM_L["Otherwise, {num} notes are ready to be cleared from the incorrect location"] = true                      -- Plural (same tooltip)
    GRM_L["Otherwise, 1 note is ready to be cleared from the incorrect location"] = true                            -- Plural (same tooltip)
    GRM_L["There are currently {num} dates that can be added to the {name}"] = true
    GRM_L["The previous action still has 1 recommended task. It is advised to do that first."] = true               -- Singular
    GRM_L["The previous action still has {num} recommended tasks. It is advised to do those first."] = true         -- Plural
    GRM_L["Step {num}"] = true

    -- 1.86
	GRM_L["What tags look like:"] = true
    GRM_L["Add Join Date to:"] = true

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
    GRM_L["Please Set a Name for this Rule. It can be 1 to 30 characters in length."] = true
    GRM_L["This will also clear all of your saved rules."] = true
    GRM_L["Within Level Range: {num} - {custom1}"] = true               -- Qued macro tool tooltip
    GRM_L["Note match: {name}"] = true                                  -- Same
    GRM_L["Matching Rank"] = true                                       -- ''
    GRM_L["Right-Click|r to Edit or Remove custom rule"] = true         -- Please keep the '|r' immediately after the click info - as it indicates a text color change point
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
    GRM_L["Does NOT apply to Ban List"] = true
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
    GRM_L["Colorize Names in Chat Window to Match Class"] = true
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
    GRM_L["Right-Click"] = true
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
    GRM_L["Due to limitations with macros a player can only move 1 rank at a time."] = true
    GRM_L["Disabled at Current Rank"] = true

    -- 1.922
    GRM_L["Verifying Macro Changes. One moment."] = true
    GRM_L["Not all macro changes validated. One moment..."] = true
    GRM_L["Macro rank changes have been validated!"] = true
    GRM_L["Warning! Macro changes were not able to be validated. Please verify expected results before using the macro tool further."] = true

    -- 1.93
    GRM_L["Customize Color"] = true
    GRM_L["Officer Only Access"] = true   -- Tooltip on the advanced join date tool button
    GRM_L["Player no longer has officer access. Advanced Join Date Tool has been closed."] = true
    GRM_L["{custom1} to open Player Window"] = true
    GRM_L["{custom1} for Additional Options"] = true

    --1.93
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
    GRM_L["Kick Rule {num}"] = true
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
    GRM_L["Search"] = "搜索" -- This is the global string for "Search"

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
    GRM_L["Sync has begun after waiting in queue for {num} seconds"] = true
    GRM_L["Not Determined"] = true  -- Ban List

    --R1.97
    GRM_L["You are added to the sync queue. Position: {num}"] = true
    GRM_L["Sync Queue Position Update: {num}"] = true
    GRM_L["Data has been transferred from the old Guild \"{name}\""] = true
    GRM_L["Restore Date:"] = true
    GRM_L["Guild Name"] = true
    GRM_L["Sync with {name} complete."] = true
    GRM_L["Transfer Data"] = true
    GRM_L["Please confirm that \"{name}\" has transferred. Clicking YES will import all guild data."] = true
    GRM_L["Set Restore Point"] = true
    GRM_L["Guild Transfer Tool"] = true
    GRM_L["Transfer Tool Guide"] = true
    GRM_L["Step-by-Step guide on how to use transfer tool"] = true
    GRM_L["Step {num}:"] = true  -- Step 1: , Step 2: etc...
    GRM_L["Click \"Set Restore Point\" to the guild you are currently in (remove save first if one already exists)."] = true
    GRM_L["Initiate the guild transfer process."] = true
    GRM_L["Log into the new guild on the new server."] = true
    GRM_L["Open the Restore Tab again and click \"Transfer Data\" from your old guild. Confirm YES."] = true
    GRM_L["If you are satisfied with the transfer, remove the restore point to lower memory use next session."] = true
    GRM_L["Ensure that the new guild rank structure is identical to the previous (name changes are fine)."] = true
    GRM_L["Transferred from old server"] = true
    GRM_L["{name} has transferred servers and REJOINED the Guild."] = true
    GRM_L["Group Info Module is Outdated."] = true

    -- R1.972
    GRM_L["Show Player Level"] = true
    GRM_L["Show Mythic+ Rating"] = true
    GRM_L["M+ Rating:" ] = true
    GRM_L["Do Not Show if at Max Level {num}"] = true
    GRM_L["Not on Server"] = true
    GRM_L["Mythic+ rating will only appear on members at max level {num}."] = true

    -- R1.973
    GRM_L["You are currently syncing. Please wait until sync completes to transfer the guild data."] = true
    GRM_L["Mythic+ Score"] = true
    GRM_L["Show Member Faction"] = true
    GRM_L["Faction"] = true
    GRM_L["Alts:"] = true

    -- R1.975
    GRM_L["Export a full list of names in the queue."] = true

    -- R1.977
    GRM_L["Guild Roster"] = true
    GRM_L["GRM Custom Guild Roster"] = true
    GRM_L["Unable to Promote players at this rank"] = true
    GRM_L["Unable to Demote players at this rank"] = true
    GRM_L["No Rank Permission to Kick"] = true;
    GRM_L["No Rank Permission to Demote"] = true;
    GRM_L["No Rank Permission to Promote"] = true;
    GRM_L["Promote Player to:"] = true
    GRM_L["Demote Player to:"] = true
    GRM_L["Lvl"] = true
    GRM_L["Opens Custom Guild Roster Window"] = true
    GRM_L["{custom1} to Open"] = true;
    GRM_L["{custom1} to Promote, Demote, or Kick"] = true
    GRM_L["Whisper"] = true
    GRM_L["{custom1} to Whisper"] = true

    -- R1.979
    GRM_L["{name}'s Settings"] = true
    GRM_L["Reserved for GRM Macro Tool Usage. Please do not delete."] = true
    GRM_L["Verify Promotion Dates"] = true
    GRM_L["Verify Join Dates"] = true
    GRM_L["Number of Unverified Promotion Dates: {num}"] = true
    GRM_L["Number of Unverified Join Dates: {num}"] = true
    GRM_L["Verify Only if Within Number of Days:"] = true
    GRM_L["Confirm All"] = true
    GRM_L["Only Confirm Dates Within {num} Days"] = true
    GRM_L["1 Promotion Date Has Been Confirmed."] = true;
    GRM_L["{num} Promotion Dates Have Been Confirmed."] = true
    GRM_L["1 Join Date Has Been Confirmed."] = true;
    GRM_L["{num} Join Dates Have Been Confirmed."] = true
    GRM_L["Searching Log..."] = true

    -- R1.990
    GRM_L["M+ Score" ] = true
    GRM_L["Search Public, Officer, and Custom Notes"] = true
    GRM_L["Note Search"] = true
    GRM_L["Tips"] = true    -- Options > Help tab - "Tips" as in helpful info.
    GRM_L["Hold the CONTROL key down to scroll 3x the speed"] = true
    GRM_L["Hold the SHIFT key down to scroll instantly to the top or bottom"] = true

    -- R1.981
    GRM_L["Player Level Range:"] = true

    -- R1.982
    GRM_L["Announce Member Join Date Anniversaries."] = true
    GRM_L["Announce Player Birthdates."] = true
    GRM_L["Anniversaries, Birthdays, and Other Events can be viewed."] = true
    GRM_L["Please confirm the removal of {num} events."] = true
    GRM_L["Show Offline Members"] = true
    GRM_L["{num}/{custom1} Online"] = true  -- Format on GRM Roster "10/154 Online"
    GRM_L["Hide Options"] = true
    GRM_L["Show Options"] = true
    GRM_L["Show Mains"] = true
    GRM_L["Show Alts"] = true
    GRM_L["Show Tag"] = true
    GRM_L["Group Alts With Main"] = true  -- Roster Options - grouping alts under the main.
    GRM_L["If enabled, sorting will be based on the Mains"] = true
    GRM_L["Rows:"] = true       -- Referencing the number of rows on the Guild Roster
    GRM_L["{num} Rows"] = true
    GRM_L["Right-Click to Reset to {num} Rows"] = true
    GRM_L["Mythic+ Rating is"] = true -- New Macro rule
    GRM_L["Mythic+ Rating:"] = true
    GRM_L["Mythic+ Rating: {num}"] = true
    GRM_L["Mythic+ Rating greater or equal to {num}"] = true
    GRM_L["Mythic+ Rating equal to {num}"] = true
    GRM_L["Mythic+ Rating less than {num}"] = true

    -- R1.983
    GRM_L["Special Rules that don't fit nicely into the other categories."] = true
    GRM_L["Special"] = true     -- Macro Tool tab "Special"
    GRM_L["Special Rules Not Available at Current Rank"] = true
    GRM_L["Add Special Rule"] = true
    GRM_L["The \"Special\" rules bypass any safe and ignore restrictions."] = true
    GRM_L["Unable to promote or demote players within the guild at current rank."] = true
    GRM_L["Special Rule Match:"] = true

    -- R1.984
    GRM_L["Edit Hot Key"] = true
    GRM_L["Clear"] = true
    GRM_L["Start Building Your Hot Key"] = true
    GRM_L["Control"] = true
    GRM_L["Shift"] = true
    GRM_L["Confirm New Hot Key?"] = true
    GRM_L["Please Build Your Hot Key First"] = true
    GRM_L["Control key is already added."] = true
    GRM_L["Shift key is already added."] = true
    GRM_L["Please add only 1 character"] = true
    GRM_L["Hot Key is the Same"] = true
    GRM_L["Please add final key"] = true
    GRM_L["Final Key"] = true
    GRM_L["WARNING! Keybind is already in use for \"{name}\"."] = true

    -- R1.986
    GRM_L["D"] = true -- Hardcore mode death tag [D] -- Change to any letter
    GRM_L["Classic Hardcore Mode"] = true
    GRM_L["Hardcore"] = true
    GRM_L["Include Date Player Died"] = true
    GRM_L["Add Death Indicator Tag to Player Note"] = true
    GRM_L["Hardcore Deaths"] = true
    GRM_L["{name} has died at level {num}."] = true
    GRM_L["Player is Still Alive"] = true
    GRM_L["{name} is no longer reported as Dead."] = true
    GRM_L["The \"{custom1}\" indicates the player is dead." ] = true
    GRM_L["Your rank does not have permission to remove the tag."] = true
    GRM_L["R.I.P. - {custom1}"] = true      -- "R.I.P. - 15/09/2023"
    GRM_L["Dead"] = true
    GRM_L["Total Deaths Recorded: {num}"] = true
    GRM_L["Time of Death"] = true
    GRM_L["Sort Deaths:"] = true
    GRM_L["*Max Export is 500 Recorded Deaths at a Time"] = true

    -- R1.988
    GRM_L["In-combat. Hiding all GRM windows"] = true
    GRM_L["Auto-Hide all GRM windows when entering combat."] = true

    -- R1.9902
    GRM_L["Unable to kick or promote or demote players within the guild at current rank."] = true
    GRM_L["Unable to kick or demote players within the guild at current rank."] = true
    GRM_L["Unable to kick or promote players within the guild at current rank."] = true
    GRM_L["Unable to kick players within the guild at current rank."] = true
    GRM_L["Please Select Special Macro Rule"] = true
    GRM_L["Alt Group Rank Sync"] = true
    GRM_L["Repeated Inactivity Monitor"] = true

    -- R1.9904
    GRM_L["If disabled, a one time scan is still done at login or reload."] = true

    -- R1.9906
    GRM_L["To access the color wheel, due to a compatibility issue that began in 10.2.5, you will need to reload the UI. Do you wish to reload now?"] = true

    -- R1.9907
    GRM_L["Alt Group Rule {num}"] = true
    GRM_L["Promote/Demote Alts to Same Rank as Main"] = true
    GRM_L["Promote/Demote Alts to Rank:"] = true
    GRM_L["Promote Alts to Same Rank as Main"] = true
    GRM_L["Promote Alts to Rank:"] = true
    GRM_L["Please Choose a Destination Rank for Alts."] = true
    GRM_L["Apply to Mains at:"] = true
    GRM_L["Only Selected Ranks"] = true
    GRM_L["Ignore if Offline for:"] = true
    GRM_L["{custom1} to Change."] = true        -- "Click to change"
    GRM_L["Sync Alts to Main:"] = true
    GRM_L["Main's Rank: {name}"] = true      -- Example: "Main's Rank: Guild Leader"
    GRM_L["Alt's Rank: {name}"] = true
    GRM_L["Destination Rank: {name}"] = true
    GRM_L["Up 1 Rank"] = true
    GRM_L["Up {num} Ranks"] = true
    GRM_L["Down 1 Rank"] = true
    GRM_L["Down {num} Ranks"] = true
    GRM_L["Ignore Alt Promotion if Offline for {num} {name}"] = true
    GRM_L["No Restrictions"] = true
    GRM_L["Special Rule"] = true
    GRM_L["{num} Players are Ready for {name}."] = true
    GRM_L["1 Player is Ready for {name}."] = true
    GRM_L["Promotion"] = true
    GRM_L["Demotion"] = true
    GRM_L["Disable Demote Option. Only Promote Players"] = true
    GRM_L["Unable to Move Alts to this Rank"] = true;

    -- R1.9909
    GRM_L["When you are ready to Move the player, press the Hot-Key {name} 1 time to complete all actions"] = true
    GRM_L["When you are ready to move the players, press the Hot-Key {name} {num} times to complete all actions"] = true

    -- R1.99094
    GRM_L["For GRM to log guild member deaths, you will need to join the \"{name}\" channel. Do you wish to join?"] = true
    GRM_L["You will not be asked this again."] = true
    GRM_L["Please note, GRM will now track the deaths behind the scenes. If you wish to see the full server message, you will need to manually enable in the General Chat Settings."] = true
    GRM_L["Join \"{name}\" Channel to Track Deaths"] = true
    GRM_L["HardcoreDeaths"] = true      -- Default Placeholder
    GRM_L["Configuring channel... one moment."] = true

    -- R1.9911
    GRM_L["Data collected. Ban list updated."] = true
    GRM_L["Birthday set for {name} and {num} alt: {custom1}"] = true
    GRM_L["Birthday set for {name} and {num} alts: {custom1}"] = true       -- Plural version
    GRM_L["{name} has set {name2}'s Birthday, and {num} alt: {custom1}"] = true
    GRM_L["{name} has set {name2}'s Birthday, and {num} alts: {custom1}"] = true
    GRM_L["{name}'s Birthday has been removed."] = true
    GRM_L["{name}'s alt grouping has had their Birthday removed"] = true
    GRM_L["{name} added {name2} to {custom1}'s list of Alts."] = true
    GRM_L["{name} added to {name2}'s list of Alts."] = true
    GRM_L["{name} has been removed from {name2}'s list of Alts."] = true
    GRM_L["{name} has updated {name2}'s custom public note"] = true
    GRM_L["UnBans"] = true
    GRM_L["Ban Edits"] = true
    GRM_L["Join Dates"] = true
    GRM_L["Promo Dates"] = true
    GRM_L["Alts/Mains"] = true
    GRM_L["Custom Notes"] = true
    GRM_L["Birthdays"] = true
    GRM_L["Normalized Realm Names is Acceptable" ] = true
    GRM_L["Example: \'Aerie Peak\' or \'AeriePeak\'"] = true
    GRM_L["Banned Player in Group: {name} - Identify Verified and Ban List Updated"] = true
    GRM_L["{name}'s Profile Succcessfully Updated!"] = true
    GRM_L["All {name} Region Realms"] = true
    GRM_L["Important Notice!!!"] = true
    GRM_L["Due to the implementation of x-realm guilds, when banning players from servers other than your own, important identification data cannot be obtained. To bypass this limitation, add the ban when still grouped with the player, or while you are targeting them."] = true
    GRM_L["This only applies to players who have never been a member of your guild and are not on your personal realm ({name})."] = true
    GRM_L["Remind Me Next Time"] = true
    GRM_L["Acknowledge"] = true
    GRM_L["Unfortunately, {name} was not able to be identified. You must be grouped or targeting the player to obtain server identification details."] = true
    GRM_L["Enable All"] = true
    GRM_L["Disable All"] = true

    --R1.9914
    -- PROFESSION TRACKING DETAILS
    GRM_L["BS"] = true      -- Blacksmithing
    GRM_L["LW"] = true      -- Leatherworking
    GRM_L["Alc"] = true     -- Alchemy
    GRM_L["Herb"] = true    -- Herbalism
    GRM_L["Mine"] = true    -- Mining
    GRM_L["TL"] = true      -- Tailoring
    GRM_L["Eng"] = true     -- Engineering
    GRM_L["Ench"] = true    -- Enchanting
    GRM_L["Skin"] = true    -- Skinning
    GRM_L["JC"] = true      -- Jewelcrafting
    GRM_L["Insc"] = true    -- Inscription
    GRM_L["Classic"] = true
    GRM_L["Classic Era, HC, and SOD"] = true    -- Classic Era, Hardcore, and Season of Discovery is the acronymns
    GRM_L["Classic Professions"] = true
    GRM_L["Auto Set and Update Profession Details to Player Notes"] = true
    GRM_L["Display Settings"] = true
    GRM_L["Format (If same rank):"] = true
    GRM_L["Details will only be added to the note if space is available."] = true
    GRM_L["Profession Update Report"] = true
    GRM_L["Update will only occur once per session to avoid note change spam."] = true
    GRM_L["No Professions Have Changed"] = true
    GRM_L["Total Notes Updated with Profession Details: {num}"] = true
    GRM_L["Total Notes not able to update: {num}"] = true
    GRM_L["Click to View All Names"] = true
    GRM_L["Report Details to Chat if Professions Updated"] = true
    GRM_L["Note too long: Free up {num} characters"] = true
    GRM_L["Click to Continue - {num} Members Remaining"] = true
    GRM_L["Choose Destination:"] = true
    GRM_L["Click to Set\nProfession Details"] = true        --\n is a line break -- It just looks better this way. Remove translation if you can write itm ore concise
    GRM_L["This will add or update available profession details to every member's {name}."] = true      -- ...every member's public note [officer, [custom ]
    GRM_L["Auto-update will occur once per session, shortly after logging in. You will not need to click this button again."] = true
    GRM_L["Auto-update is disabled. This will only update your notes a single time"] = true
    GRM_L["Cancel Auto-Update"] = true
    GRM_L["Only Available in Classic Era"] = true
    GRM_L["Only Available for Officers"] = true
    GRM_L["One moment. Processing profession data..."] = true
    GRM_L["Update profession ranks (Classic Era Only)"] = true
    GRM_L["Prof"] = true        -- /grm prof SLASH COMMAND -- Make your own slash command
    GRM_L["Realm Name"] = true
    GRM_L["{name} is no longer in the guild"] = true
    GRM_L["{custom1} Entry to Open Player Window"] = true

    -- R1.99142
    GRM_L["On higher ranked alt"] = true
    GRM_L["{num} player can be kicked by higher ranked alt {name}"] = true
    GRM_L["{num} players can be kicked by higher ranked alt {name}"] = true
    GRM_L["{num} player can be promoted by higher ranked alt {name}"] = true
    GRM_L["{num} players can be promoted by higher ranked alt {name}"] = true
    GRM_L["{num} player can be demoted by higher ranked alt {name}"] = true
    GRM_L["{num} players can be demoted by higher ranked alt {name}"] = true
    GRM_L["{num} player is ready to shift ranks by higher ranked alt {name}"] = true
    GRM_L["{num} players are ready to shift ranks by higher ranked alt {name}"] = true

    -- R1.99152
    GRM_L["Unable to kick these alts:"] = true

    -- R1.99161
    GRM_L["One Time Notice"] = true;
    GRM_L["Blizzard re-introduced the Classic roster, which you currently have enabled. GRM features will be limited. The communities roster will give you access to all of GRM's features."] = true;
    GRM_L["Would you like to enable the communities roster?"] = true
    GRM_L["Communities Roster is now Enabled."] = true

    -- R1.99165
    GRM_L["Player is Already in this Alt Group"] = true

    -- R1.99170
    GRM_L["Unable to invite. You are grouped without privileges."] = true

    -- R1.992
    GRM_L["This will remove the profession details from all player notes: public, officer, and custom."] = true
    GRM_L["Do you wish to continue?"] = true
    GRM_L["Click to Remove All Profession Notes"] = true
    GRM_L["{num} notes have had profession details removed."] = true
    -- Main/Alt Display Settings
    GRM_L["Alt, Main, and Nickname settings"] = true
    GRM_L["Names"] = true       -- Represents the Options "Names" tab
    GRM_L["Main and Alt Formatting"] = true
    GRM_L["Show both {name} and {name2} tags in Chat"] = true
    GRM_L["Show Main Name in Chat"] = true
    -- Nickname Settings
    GRM_L["Nicknames"] = true
    GRM_L["Show Nickname in Chat"] = true
    GRM_L["Share Nickname Across All Grouped Alts"] = true
    GRM_L["Append My Public Nickname to My Guild Messages"] = true
    GRM_L["Show Nickname instead of Main name"] = true
    GRM_L["Main name will still show if no nickname has been set"] = true
    -- Custom Chat Window Settings
    GRM_L["Would you like to recreate this chat window for messages unique to the GRM addon?"] = true
    GRM_L["\"{name}\" Custom Chat Window for GRM appears to be missing."] = true
    GRM_L["The following Custom Chat Windows for GRM appear to be missing:"] = true
    GRM_L["Would you like to recreate these chat windows for messages unique to the GRM addon?"] = true
    GRM_L["Add Channel"] = true
    GRM_L["Add Channels"] = true
    GRM_L["Set to {name}"] = true   -- Referencing the default chat channel "Set to General"
    GRM_L["Keep Only {name}"] = true
    GRM_L["GRM will now send all messages to the default \"{name}\" channel"] = true
    GRM_L["The missing GRM channel has been recreated."] = true
    GRM_L["The {num} missing GRM channels have been recreated"] = true
    GRM_L["GRM will now only send messages to the following channels:"] = true
    GRM_L["Ignore Missing"] = true
    -- Macro Rule Settings
    GRM_L["Search Public, Officer, and Custom Notes for Safe tag"] = true
    GRM_L["Re-scanning roster for rule match."] = true
    -- MISC
    GRM_L["Pending Feature"] = true

    -- 1.9926
    GRM_L["Add Message to Note After Demotion"] = true
    GRM_L["GRM will append the message to existing note if room."] = true
    GRM_L["However, if there is not enough room, the message will not be added."] = true
    GRM_L["Enable to forcibly overwrite existing note when not enough room for both."] = true
    GRM_L["Force Overwrite"] = true
    GRM_L["{rank}"] = true
    GRM_L["Add the bracket \'{rank}\' anywhere in message to insert former rank."] = true
    GRM_L["Ex: - Rank: {rank}"] = true
    GRM_L["Max Length: {num} letters, including rank name"] = true

    -- 1.9931
    GRM_L["Warning!"] = true
    GRM_L["Your guild Log has {num} entries. Warcraft addons are limited in how much data can be stored. GRM provides this warning as a cushion to help ensure this is never broken as it would result in a catastrophic overflow error that will potentially destroy the GRM save file."] = true
    GRM_L["You are currently storing {num} log entries across {custom1} guilds, taking up approximately {custom2}% of the addon's storage capacity."] = true
    GRM_L["You are currently storing {num} log entries in your guild, taking up approximately {custom1}% of the addon's storage capacity."] = true
    GRM_L["To Cleanup the log, if you wish to keep the data, please go to the export window by typing `/grm export` and copying the log to an external document. Then, on the log page, click on the \'Open Log Tools\' button on the right side."] = true
    GRM_L["You are at risk for GRM data loss. It is CRITICAL this is handled imediately. Click OK to acknowledge. You will not be warned again."] = true
    GRM_L["You are nearing max GRM storage limit. It is CRITICAL this is handled soon. Click OK to acknowledge."] = true
    GRM_L["Press OK to acknowledge and you will not be reminded again until you are at {num}% capacity."] = true

    -- 1.9933
    GRM_L["Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to Kick will remove {num} player(s) you currently have queued up for rank changes."] = true
    GRM_L["Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to {custom1} will remove {num} player(s) you currently have qued up to kick."] = true

    -- 1.99342
    GRM_L["Sync is temporarily disabled until the first scan of the guild roster has completed. It has been {num} seconds since logging in."] = true
    GRM_L["Given the unusually long time of {num} seconds and sync is still not availble, GRM may not be loading properly. If you are experiencing any Lua errors, please report then to the official GRM Discord channel."] = true

    -- 1.99344
    GRM_L["Not in Guild"] = true

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
    
end

-- Thank you 阿拉贝比-回音山 for you amazing work!
-- 谢谢你，阿拉贝比-回音山，你的工作太棒了！
-- TY @Blendomino for the updated translation work!
