
-- INSTRUCTIONS FOR LOCALIZATION

-- 1 ) Please avoid the "SYSTEM MESSAGES" as those are necessary for the addon code to properly identify and parse them. those are already complete.
-- 2 ) Any statement that "= true" needs to still be translated. Just remove the 'true' and replace it with the proper translation, in quotations
--     Please include the {name} for where the player names should appear, as well as the few instances {num} needs to be included (referring to number)
-- 3 ) If appropriate, in the context of the sentence, please keep the spacing properly.
-- 4 ) Report any issues to Arkaan on CurseForge or Discord. -- You can also find me Battle.net @  DNADissector#1958   (US)
-- 5 ) THANK YOU SO MUCH FOR ADDING THIS TRANSLATION WORK!!! I will ensure you are mentioned in the release notes and at the top of this header for your contribution

-- Data insert points:
--  {name} and {name2} and {num} and {custom1} and {custom2}

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
    GRM_L["/XXXX"] = true    -- /grm will always work -- now you can make your own acronym that fits your language. Example: GRM_L["/XXXX"] = "/грм" - Now, if you type /грм it will work in-game
    GRM_L["/YYYY"] = true    -- /roster              -- This is the custom GRM roster

    GRM_L["German"] = "德语"
	GRM_L["English"] = "英语"
	GRM_L["French"] = "法语"
	GRM_L["Italian"] = "意大利语"
	GRM_L["Russian"] = "俄语"
	GRM_L["SpanishMX"] = "西班牙语 (墨西哥)"
	GRM_L["SpanishEU"] = "西班牙语 (欧洲)"
    GRM_L["Portuguese"] = "葡萄牙语 (欧洲)"
    GRM_L["PortugueseBR"] = "葡萄牙语 (巴西)"
	GRM_L["Korean"] = "韩语"
	GRM_L["MandarinCN"] = "简体中文"
    GRM_L["MandarinTW"] = "繁體中文"
    GRM_L["Dutch"] = "荷兰语"
    GRM_L["Danish"] = "丹麦语"

    -- PLAYER MAIN ROSTER DETAILS WINDOW
    GRM_L["Level: "] = "等级"
    GRM_L["Level"] = "等级"
    GRM_L["Note:"] = "备注："
    GRM_L["Note"] = "备注"
    GRM_L["Officer's Note:"] = "官员备注:"
    GRM_L["Officer's Note"] = "官员备注"
    GRM_L["Zone:"] = "地区："
    GRM_L["(main)"] = "(主号)"
    GRM_L["( Main )"] = "( 主号 )"    -- Context: This one is used on player data window, the other is smaller used in the alts list...
    GRM_L["Set as Main"] = "设为主号"
    GRM_L["Set as Alt"] = "设为小号"
    GRM_L["Remove"] = "移除"
    GRM_L["Please Type the Name of the alt"] = "请输入小号角色名"
    GRM_L["Promoted:"] = "会阶提升："
    GRM_L["Unknown"] = "未知"    -- Context: The date of their promotion is "Unknown"
    GRM_L["Click here to set a Public Note"] = "点击此处设置公共备注"
    GRM_L["Unable to Edit Public Note at Rank"] = "无权限修改公共备注"
    GRM_L["Click here to set an Officer's Note"] = "点击此处设置官员备注"
    GRM_L["Unable to Edit Officer Note at Rank"] = "无权限修改官员备注"
    GRM_L["Unable to View Officer Note at Rank"] = "无权限查看官员备注"
    GRM_L["Online"] = "在线"
    GRM_L["( Active )"] = "( 活跃 )"    -- I included the parentheses here as I am not sure if any languages abstain from them, or use other notation. Feel free to remove if necessary
    GRM_L["( AFK )"] = "( 离开 )"
    GRM_L["( Busy )"] = "( 忙碌 )"
    GRM_L["( Mobile )"] = "( 移动端 )"
    GRM_L["( Offline )"] = "( 离线 )"
    GRM_L["Set Join Date"] = "设置加入日期"
    GRM_L["Edit Promo Date"] = "修改会阶提升日期"
    GRM_L["Edit Join Date"] = "修改加入日期"
    GRM_L["Set Promo Date"] = "设置会阶提升日期"
    GRM_L["Group Invite"] = "小队邀请"
    GRM_L["Date Promoted"] = "会阶提升日期"
    GRM_L["Last Online"] = "上一次在线"
    GRM_L["Time In:"] = "已在该地区:"    -- Context: "Time In" the current zone...
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
    GRM_L["Joined:"] = "加入于:"    -- as in "Joined" the guild
    GRM_L["Joined"] = "加入"
    GRM_L["Left:"] = "离开于:"    -- as in, "Left" the guild
    GRM_L["Rejoined:"] = "重新加入于:"    -- as in, "Rejoined" the guild
    GRM_L["Rejoined"] = "重新加入"
    GRM_L["Reset Data!"] = "重置数据!"
    GRM_L["Notify When Player is Active"] = "当玩家活跃时发送通知"
    GRM_L["Notify When Player Goes Offline"] = "当玩家下线时发送通知"
    GRM_L["Notify When Player Comes Online"] = "当玩家上线时发送通知"
    GRM_L["Edit Date"] = "编辑日期"
    GRM_L["Clear History"] = "清除历史"
    GRM_L["Options"] = "选项"

    -- LOG
    GRM_L["LOG"] = "日志"    -- Context - The guild Log shorthand for the tab
    GRM_L["Guild Roster Event Log"] = "成员变动日志"
    GRM_L["Clear Log"] = "清除日志"
    GRM_L["{name} KICKED {name2} from the Guild!"] = "{name} 已将 {name2} 开除出公会!"
    GRM_L["kicked"] = "已开除"
    GRM_L["{name} has BANNED {name2} and all linked alts from the guild!"] = "{name} 已将 {name2} 及其所有小号加入黑名单!"
    GRM_L["{name} has BANNED {name2} from the guild!"] = "{name} 已将 {name2} 加入黑名单!"
    GRM_L["Reason Banned:"] = "拉黑原因:"
    GRM_L["{name} has Left the guild"] = "{name} 离开了公会"
    GRM_L["has Left the guild"] = "离开了公会"    -- Context: PlayerName "has left the guild"  -- THESE MUST BE EXACT MATCH WITH PREVIOUS LINE (just without the name on this one)
    GRM_L["ALTS IN GUILD:"] = "仍在公会中的小号:"    -- Context: This appears If a person leaves the guild and there are still alts in the guild. It is like - "ALTS IN GUILD: Arkaan, Chris, Matt, and 4 others.""
    GRM_L["Player no longer on Server"] = "玩家已不在该服务器"
    GRM_L["{name} PROMOTED {name2} from {custom1} to {custom2}"] = "{name} 将 {name2} 的会阶从 {custom1} 提升至 {custom2}"
    GRM_L["{name} has been PROMOTED from {custom1} to {custom2}"] = "{name} 的会阶已从 {custom1} 提升至 {custom2}"
    GRM_L["{name} DEMOTED {name2} from {custom1} to {custom2}"] = "{name} 将 {name2} 的会阶从 {custom1} 降级至 {custom2}"
    GRM_L["{name} has been DEMOTED from {custom1} to {custom2}"] = "{name} 的会阶已从 {custom1} 降级至 {custom2}"
    GRM_L["(+ {num} More)"] = "(及另外 {num} 个)"    -- Context: Referencing num of alts if player leaves guild, that are stil in it. Example "ALTS IN GUILD: Christ, Matt, Sarah (+ 4 more)"
    GRM_L["{name} has Been in the Guild {num} Times Before"] = "{name} 已 {num} 次重新加入过公会"
    GRM_L["{name} is Returning for the First Time."] = "{name} 首次重新加入公会。"
    GRM_L["None Given"] = "未给出"    -- Context: No reason given for player ban. This is displayed when a player was banned, but the addon users did not input a reason why.
    GRM_L["WARNING!"] = "警告!"    -- Context: WARNING - banned player rejoined the guild!
    GRM_L["{name} REJOINED the guild but was previously BANNED!"] = "{name} 重新加入了公会但该玩家曾在黑名单中!"
    GRM_L["(Invited by: {name})"] = "(邀请人: {name})"
    GRM_L["Invited By: {name}"] = "邀请人: {name}"
    GRM_L["Date of Ban:"] = "加入黑名单日期:"
    GRM_L["Date Originally Joined:"] = "首次加入公会日期:"
    GRM_L["Old Guild Rank:"] = "曾经的公会会阶:"
    GRM_L["Additional Notes:"] = "额外备注:"
    GRM_L["{name} has REINVITED {name2} to the guild"] = "{name} 邀请了 {name2} 重新加入公会"
    GRM_L["(LVL: {num})"] = "(等级: {num})"    -- Context: LVL means Player Level - so Ex: (LVL: 110)
    GRM_L["{name} has REJOINED the guild"] = "{name} 重新加入了公会"
    GRM_L["{name} has JOINED the guild!"] = "{name} 加入了公会!"
    GRM_L["Date Left:"] = "离开公会日期:"
    GRM_L["{name} has Leveled to {num}"] = "{name} 的等级已提升至 {num}"
    GRM_L["(+{num} levels)"] = "(+{num} 级)"    -- Context: Person gained more than one level, hence the plural
    GRM_L["(+{num} level)"] = "(+{num} 级)"    -- Context: Person gains a level, just one level.
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Added"] = "{name}的公共备注被添加: \"{custom1}\""    -- Of note, the \" in the text here will just appear as " in-game. The \" notation is telling the program not to end the string, but to include quotation
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" was Removed"] = "{name}的公共备注: \"{custom1}\" 被移除"
    GRM_L["{name}'s PUBLIC Note: \"{custom1}\" to \"{custom2}\""] = "{name}的公共备注: \"{custom1}\" 被改为 \"{custom2}\""    -- Context: "Arkaan's PUBLIC Note: "ilvl 920" to "Beast Mode ilvl 960""  -- Changing of the note. custom1 = old note, custom2 = new note
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Added"] = "{name}的官员备注被添加: \"{custom1}\""
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" was Removed"] = "{name}的官员备注: \"{custom1}\" 被移除"
    GRM_L["{name}'s OFFICER Note: \"{custom1}\" to \"{custom2}\""] = "{name}的官员备注: \"{custom1}\" 被改为 \"{custom2}\""
    GRM_L["Guild Rank Renamed from {custom1} to {custom2}"] = "会阶名称 {custom1} 被改为 {custom2}"
    GRM_L["{name} has Name-Changed to {name2}"] = "{name} 已改名为 {name2}"
    GRM_L["{name} has Come ONLINE after being INACTIVE for {num}"] = "{name} 在离线 {num} 后重新上线"
    GRM_L["{name} has been OFFLINE for {num}. Kick Recommended!"] = "{name} 已离线 {num}。建议开除!"
    GRM_L["({num} ago)"] = "({num} 前)"    -- Context: (5 minutes ago) or (5 months 24 days ago) -- the {num} will automatically include the time-passed date.
    GRM_L["{name}'s Guild has Name-Changed to \"{name2}\""] = "{name}的公会已改名为 \"{name2}\""
    GRM_L["Promotions"] = "升阶"
    GRM_L["Demotions"] = "降阶"

    -- EVENTS WINDOW
    GRM_L["EVENTS"] = "活动"    -- Events tab
    GRM_L["{name}'s Anniversary!"] = "{name}的入会周年日!"
    GRM_L["{name}'s Birthday!"] = "{name}的生日!"
    GRM_L["No Calendar Events to Add"] = "无活动可添加"
    GRM_L["Event Calendar Manager"] = "活动日历管理"
    GRM_L["Event:"] = "活动:"
    GRM_L["Description:"] = "描述:"
    GRM_L["Add to\nCalendar"] = "添加至日历"
    GRM_L["Ignore Event"] = "忽略活动"
    GRM_L["No Player Event Has Been Selected"] = "未选择玩家活动"
    GRM_L["Event Added to Calendar: {custom1}"] = "活动{custom1}已添加至日历"    -- Custom1 = the title of the event, like "Arkaan's Anniversary"
    GRM_L["Please Select Event to Add to Calendar"] = "请选择活动添加至日历"
    GRM_L["{name}'s event has already been added to the calendar!"] = "{name}的活动已经添加至日历!"
    GRM_L["Please wait {num} more seconds to Add Event to the Calendar!"] = "请等待{num}秒后再添加活动至日历!"
    GRM_L["{name}'s Event Removed From the Queue!"] = "{name}的活动已从队列中移除!"
    GRM_L["Full Description:"] = "完整描述:"

    -- BAN WINDOW
    GRM_L["BAN LIST"] = "黑名单"    -- Ban List Tab
    GRM_L["Reason Banned?"] = "拉黑理由?"
    GRM_L["Click \"YES\" When Done"] = "完成后点击\"是\""    -- Of note, the \" is how you notate for quotations to actually appear. Adjust as needed
    GRM_L["Select a Player"] = "选择一名玩家"
    GRM_L["Player Selected"] = "已选择玩家"
    GRM_L["{name}(Still in Guild)"] = "{name}(仍是公会成员)"
    GRM_L["(Still in Guild)"] = "(仍是公会成员)"    -- same as previous, just formatting simplicity...
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
    GRM_L["Add"] = "添加"    -- Context: "Add" player to ban list
    GRM_L["Confirm Ban for the Following Player?"] = "确认将下列玩家加入黑名单?"
    GRM_L["Please Enter a Valid Player Name"] = "请输入正确的角色名"    -- Player Name
    GRM_L["Please Enter a Valid Server Name"] = "请输入正确的服务器名称"    -- Server Name
    GRM_L["Please Select a Player to Unban!"] = "请选择一名玩家从黑名单中移除!"
    GRM_L["{name} - Ban List"] = "{name} - 黑名单"    -- Context: "GuildName - Ban List"
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
    GRM_L["Ver: {custom1}"] = "版本: {custom1}"    -- Context:  Ver: R1.125  - Ver is short for Version
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
    GRM_L["Report addon ver"] = "报告插件版本"    -- Ver is short for Version
    GRM_L["Resets Guild data"] = "重置公会数据"
    GRM_L["Show at Logon"] = "登录后显示"
    GRM_L["Only Show if Log Changes"] = "只在有新日志时显示"

    -- This do need to be translated still
    GRM_L["Before Scan Timer"] = "每"    -- Context: "Scan for Changes Every 10 Seconds" -- There will be a number added here and may require custom positioning, so please provide full statement and Arkaan will allign
    GRM_L["After Scan Timer"] = "秒扫描变动"
    GRM_L["Before Inactive Timer"] = "当离线超过"
    GRM_L["After Inactive Timer"] = "天的玩家上线时发送通告"

    GRM_L["Reactivating SCAN for Guild Member Changes..."] = "正在重启扫描公会成员变动..."
    GRM_L["Deactivating SCAN of Guild Member Changes..."] = "正在关闭扫描公会成员变动..."
    GRM_L["Please choose a scan interval {num} seconds or higher!"] = "请选择不少于{num}秒的扫描间隔时长!"
    GRM_L["{num} is too Low!"] = "{num}太短了!"
    GRM_L["The Current Lvl Cap is {num}."] = "当前等级上限为{num}。"
    GRM_L["Kick Inactive Player Reminder at"] = "踢出不活跃玩家提醒："    -- Context: "Kick Inactive Player Reminder at X Months" - Again, allignment will need to be adjusted for options UI, so please post
    GRM_L["Please choose a month between 1 and 999"] = "选择的月数需在1到999之间"
    GRM_L["Please choose a month between 0 and 999"] = "选择的月数需在0到999之间"
    GRM_L["Sync BAN List With Guildies at Rank"] = "同步成员黑名单，会阶为"    -- Context: "Sync Ban List with Guildies at Rank [DROPDOWNMENU OF RANKS] or Higher" - Please show where dropdown menu should be pinned
    GRM_L["or Higher"] = "或以上"    -- Context: Look at the above statement. Show where this needs to go in regards to dropdown menu of rank selection in Options
    GRM_L["Restore Defaults"] = "恢复默认设置"
    GRM_L["Please choose between 1 and 180 days!"] = "选择的天数需在1到180之间"
    GRM_L["Announce Events"] = "提前"    -- Context: "Announce Events X number of days in advance" -- the X is the editbox to modify number of days. Please include the location of where to pin that.
    GRM_L["Days in Advance"] = "天通告活动"
    GRM_L["Add Events to Calendar"] = "添加活动至日历"
    GRM_L["SYNC Changes With Guildies at Rank"] = "同步成员变动，会阶为"    -- Context: at Rank [DROPDOWNRANKSELECTION] or Higher. - Please note where to place dropdown box in the position of the sentence.
    GRM_L["Reactivating Data SYNC with Guildies..."] = "正在重启同步公会成员..."
    GRM_L["Deactivating Data SYNC with Guildies..."] = "正在关闭同步公会成员..."
    GRM_L["Display Sync Update Messages"] = "显示同步更新信息"
    GRM_L["Only Sync With Up-to-Date Addon Users"] = "只与使用最新版本插件的用户同步"
    GRM_L["Leveled"] = "等级"
    GRM_L["Inactive Return"] = "长时离线回归"
    GRM_L["resetall"] = "全部重置"
    GRM_L["resetguild"] = "重置公会"
    --Side chat/log controls - Of note, limited spacing
    GRM_L["Name Change"] = "名字变更"
    GRM_L["Rank Renamed"] = "会阶改名"
    GRM_L["Event Announce"] = "活动通知"
    GRM_L["Left"] = "离开"    -- Context: As in, "Left" the guild...
    GRM_L["Recommendations"] = "推荐"
    GRM_L["Banned"] = "拉黑"
    GRM_L["To Chat:"] = "在聊天框中:"    -- Context: "To Chat Message frame -- in regards to announcing events like when a player leveled"
    GRM_L["To Log:"] = "在日志中:"    -- Context: To show it in the guild log.
    GRM_L["Display Changes"] = "显示变更"

    -- AUDIT WINDOW
    GRM_L["AUDIT"] = "详单"    -- Audit Tab name
    GRM_L["No Date Set"] = "日期未设定"
    GRM_L["Main"] = "主号"
    GRM_L["Main or Alt?"] = "主号还是小号?"
    GRM_L["Alt"] = "小号"
    GRM_L["Total Incomplete: {num} / {custom1}"] = "信息不完整: {num} / {custom1}"    -- Context: Total incomplete: 50 / 100    (50 out of 100)
    GRM_L["Mains:\n{num}"] = "主号:\n{num}"    -- Context: Number of "main" toons
    GRM_L["Unique Accounts:\n{num}"] = "游戏账号:\n{num}"
    GRM_L["All Complete"] = "信息完整"    -- Context: All dates have been added and are known, thus it states it is "All Complete"
    GRM_L["Set Incomplete to Unknown"] = "将信息不完整设为未知"    -- Context: Implied to set ALL incomplete to unknown
    GRM_L["Clear All Unknown"] = "清除所有未知"
    GRM_L["Please Wait {num} more Seconds"] = "请等待{num}秒"
    GRM_L["Guild Data Audit"] = "公会信息详单"
    GRM_L["Name"] = "名字"
    GRM_L["Join Date"] = "加入日期"
    GRM_L["Promo Date"] = "晋升日期"
    GRM_L["Main/Alt"] = "主号/小号"
    GRM_L["Only Show Incomplete Guildies"] = "只显示信息不完整成员"

    -- ADDON SYSTEM MESSAGES
    GRM_L["Guild Roster Manager"] = "公会名单管理器"
    GRM_L["GRM:"] = "GRM:"    -- Abbreviation for "Guild Roster Manager"
    GRM_L["(Ver:"] = "(版本号:"    -- Ver: is short for Version:
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
    GRM_L["Building Profiles on ALL \"{name}\" members"] = "为\"{name}\"所有成员创建档案"    -- {name} will be the Guild Name, for context
    GRM_L["NOTIFICATION:"] = "通知:"    -- Context:  "Notification: Player is no longer AFK"
    GRM_L["{name} is now ONLINE!"] = "{name}上线了!"
    GRM_L["{name} is now OFFLINE!"] = "{name}下线了!"
    GRM_L["{name} is No Longer AFK or Busy!"] = "{name}不再处于离开或忙碌状态!"
    GRM_L["{name} is No Longer AFK or Busy, but they Went OFFLINE!"] = "{name}不再处于离开或忙碌状态，并已下线！"
    GRM_L["{name}'s saved data has been wiped!"] = "{name}的数据已被清除!"
    GRM_L["Wiping all Saved Roster Data Account Wide! Rebuilding from Scratch..."] = "正在清除账号的所有成员信息! 重新建立数据库..."
    GRM_L["Wiping all saved Guild data! Rebuilding from scratch..."] = "正在清除所有公会信息! 重新建立数据库..."
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
    GRM_L["WARNING! Complete hard wipe, including settings, as if addon was just installed."] = "警告! 重置所有数据，包括设置，恢复出厂。";

    -- General Misc UI
    GRM_L["Really Clear All Account-Wide Saved Data?"] = "确定要清除此账号下的所有数据?"
    GRM_L["Really Clear All Guild Saved Data?"] = "确定要清除所有公会数据?"
    GRM_L["Yes!"] = "是!"
    GRM_L["Ban Player?"] = "拉黑玩家?"
    GRM_L["Ban the Player's {num} alts too?"] = "同时拉黑此玩家的{num}个小号?"    -- Plural number of alts
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
    GRM_L["Com Message too large for server"] = "通讯信息量超出服务器负载"    -- Context: "Com message" is short-hand for "Communications message" - this is a technical error on syncing data.
    GRM_L["Prefix:"] = "前缀:"
    GRM_L["Msg:"] = "信息:"    -- Context: Msg is short for Message
    GRM_L["Unable to register prefix > 16 characters: {name}"] = "无法注册前缀>16个字符: {name}"    -- Context: The {name} is the string code for the prefix. This is for debugging.

    --SLASH COMMANDS
    -- These are generally written in general shorthand. The original commands will ALWAYS work, but if there is one that makes more sense in your language, please feel free to modify
    GRM_L["clearall"] = "全部清除"    -- Context: In regards, "Clear All" saved data account wide
    GRM_L["clearguild"] = "清除公会"    -- Context: In regards, "Clear All" saved data from ONLY the current guild.
    GRM_L["hardreset"] = "彻底重置"    -- Context: In regards, "Hard Reset" ALL data account wide, including wiping player settings
    GRM_L["help"] = "帮助"    -- Context: "help" with info on the how to use addon
    GRM_L["version"] = "版本"    -- Context: "version" of the addon
    GRM_L["center"] = "居中"    -- Context: "center" the movable addon window back to center of screen
    GRM_L["sync"] = "同步"    -- Context: "sync" the data between players one time now.
    GRM_L["scan"] = "扫描"    -- Context: "scan" for guild roster changes one time now.

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
    GRM_L["1 Mar"] = "3月1日"    -- This date is used in a specific circumstance. If someone's anniversary/bday landed on a leap year (Feb 29th), it defaults to the 1st of March on non-leap year
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
    -- GRM_L["May"] = true  -- Duplicate
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
    GRM_L["HourBreak"] = ":"    -- Context, in English, and many languages, 11am = 11:00 -- or in French, 11h00   - the hour break is the ":" or the "h"

    GRM_L["am"] = "上午"
    GRM_L["pm"] = "下午"
    GRM_L["24HR_Notation"] = "";    -- if someone is using 24hr time notation in your country, instead of 12hr, how do you notate it? In English, there is no am/pm (though "hours" is technically right, but unnecessary)

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
    GRM_L["{num} {custom1}"] = true    -- Context: This is a placeholder for ANY generic time data -- Ex:  "1 year" or "15 months" - The translation is set this is just to set the orientation of the number properly.

    -- MISC Punctuation
    GRM_L[","] = "，"    -- I know in some Asia languages, a comma is not used, but something similar, for example.

    -- Updates 1.126
    GRM_L["General"] = "综合"
    GRM_L["General:"] = "综合:"
    GRM_L["Scan"] = "扫描"
    GRM_L["Help"] = "帮助"
    GRM_L["UI"] = "界面"    -- UI for User Interface. Abbreviation for changing custom UI featuers, like coloring of <M> main
    GRM_L["Officer"] = "官员"    -- as in, "Officer" rank
    GRM_L["Open Addon Window"] = "打开插件窗口"
    GRM_L["Sync Addon Settings on All Alts in Same Guild"] = "为所有在公会中的小号同步插件设定"
    GRM_L["Show Minimap Button"] = "显示小地图按键"
    GRM_L["Player is Not Currently in a Guild"] = "玩家不在一个公会中"
    -- tooltips
    GRM_L["|CFFE6CC7FClick|r to open GRM"] = "|CFFE6CC7F点击|r以打开GRM"    -- Please maintain the color coding
    GRM_L["|CFFE6CC7FRight-Click|r to Reset to 100%"] = "|CFFE6CC7F右击|r以重置为100%"    -- for the Options slider tooltip
    GRM_L["|CFFE6CC7FRight-Click|r to Set Notification of Status Change"] = "|CFFE6CC7F右击|r以设定状态变化通告"
    -- tooltip end
    GRM_L["GRM"] = "GRM"
    GRM_L["Include Unknown as Incomplete"] = "将未知作为信息不完整"    -- Context: Unknown in the Audit Tab will be hidden if filtering out complete players
    GRM_L["You Do Not Have Permission to Add Events to Calendar"] = "你没有在日历中添加活动的权限"
    GRM_L["Please Select Which Join Date to Sync"] = "请选择同步一个加入日期"
    GRM_L["Sync All Alts to {name}'s Join Date"] = "将{name}的加入日期同步给所有小号"
    GRM_L["Sync All Alts to the Earliest Join Date: {name}"] = "将{name}最早的加入日期同步给所有小号"
    GRM_L["Sync All Alts to {name}'s |cffff0000(main)|r Join Date"] = "将{name}|cffff0000(主号)|r的加入日期同步给所有小号"    -- The coloring ensures that "(main)" maintains the RED color. Please keep it consistent if relevant to your language.
    GRM_L["Join Date of All Alts is Currently Synced"] = "所有小号的啊加入日期已同步"

    -- Update 1.130
    GRM_L["|CFFE6CC7FCtrl-Shift-Click|r to Hide this Button."] = "|CFFE6CC7FCtrl-Shift左键|r以隐藏此按钮"
    GRM_L["Invited By:"] = "邀请人:"
    GRM_L["Error: Guild Not Found..."] = "错误: 未找到公会..."
    GRM_L["Debugger Start"] = "开始调试";

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
    GRM_L["Memory Usage: {num} MB"] = "内存占用: {num} MB"    -- MB references the number of MegaBytes of memory used.

    -- Update 1.137
    GRM_L["GRM: Unable to Create Backup for a Guild With Unknown Creation Date! Log into that guild on any alt to update old database."] = "GRM: 公会创建日期未知，无法建立备份! 请登录任何在该公会的角色以更新旧数据库。"
    GRM_L["Really restore {name} Backup Point?"] = "确认要从{name}备份点恢复?"
    GRM_L["Check All"] = "全选"

    -- Update 1.139
    GRM_L["Right-Click for options to remove this guild from the addon database completely"] = "右键以显示将此公会从数据库中抹除的选项"
    GRM_L["Player Cannot Purge the Guild Data they are Currently In!!!"] = "请先退出当前公会再进行数据抹除!!!"
    GRM_L["To reset your current guild data type '/grm clearguild'"] = "请输入'/grm clearguild'以重置当前公会数据"
    GRM_L["Click Here to Remove all traces of this guild, or hit ESC"] = "点击此处删除该公会所有信息, 或按ESC"
    GRM_L["{name} has been removed from the database."] = "{name}已从数据库中移除。"    -- The Guild Name has been removed from the database

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
    GRM_L["To"] = "至"    -- Clear Lines:  50 To 100     -- It stands between 2 edit boxes as its own fontstring, so work with that.
    GRM_L["Confirm Clear"] = "确认清除"
    GRM_L["Please Select Range of Lines from the Log You Wish to Remove"] = "请选择清除日志行的范围"
    GRM_L["Please put the lowest number in the first box"] = "请在第一格中输入最小值"
    GRM_L["Line selection is not valid"] = "选择的行不可用"
    GRM_L["Really Clear lines {custom1} to {custom2}?"] = "确认清除{custom1}至{custom2}行?"
    GRM_L["Enabling Line Numbers... Please choose within the given range"] = "启用行计数... 请在该范围中选择"
    GRM_L["Ctrl-C to Copy <> Ctrl-P to Paste <> Ctrl-A to Select All"] = "按Ctrl-C复制 <> 按Ctrl-P粘贴 <> 按Ctrl-A全选"
    GRM_L["Language:"] = "选择语言:"
    GRM_L["{num} phrases still need translation to {name}"] = "仍有{num}条字句需要被翻译成{name}"    -- Ex: 300 phrases still need translation to German

    -- update 1.145
    GRM_L["You currently are at {num} non-Battletag friends. To fully take advantage of all of GRM features, please consider clearing some room."] = "你目前有{num}位非战网好友。如需使用GRM的所有功能, 请清除部分。"

    -- Update 1.146
    GRM_L["Really Clear line {num}?"] = "确认清除第{num}行?"
    GRM_L["Font has been Reset to DEFAULT."] = "字体已重置。"
    GRM_L["Font:"] = "选择字体:"
    GRM_L["Font Scale:"] = "字体大小:"
    GRM_L["Example"] = "示例"
    GRM_L["Right-Click to Reset to 100%"] = "右键点击重设为100%"

    -- Update 1.147
    GRM_L["{custom1} to Search the Log for Player"] = "按{custom1}在日志中搜索玩家"

    -- Update 1.1480
    GRM_L["Custom Notes:"] = "自定义备注:"
    GRM_L["GRM Debugging Enabled."] = "启用GRM调试"
    GRM_L["GRM Debugging Disabled."] = "禁用GRM调试"
    GRM_L["Please type \"/grm debug 10\" to report 10 events (or any number)"] = "请输入\"/grm debug 10\"以显示10条报告 (或输入其他数值)"    -- Please keep the \"/grm debug 10)\" in-tact for slash command to work
    GRM_L["Format: \"/grm debug 10\""] = "格式: \"/grm debug 10\""    -- "" Likewise
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
    GRM_L["|CFFE6CC7FClick|r to Change Month"] = "|CFFE6CC7F点击|r以修改月份";
    GRM_L["|CFFE6CC7FClick|r to Change Year"] = "|CFFE6CC7F点击|r以修改年份";
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
    GRM_L["{custom1} to Change the Language"] = "{custom1}修改语言"
    GRM_L["{custom1} to Change Display Format"] = "{custom1}修改显示格式"
    GRM_L["{custom1} to Change the Font"] = "{custom1}修改字体"

    -- R1.1490
    GRM_L["Unable to properly locate guild for backup"] = "无法正确定位公会以备份"

    -- R1.1500
    GRM_L["Unique accounts pull from the server is known to be faulty"] = "从服务器获取的战网账号有几率出错"
    GRM_L["Use only as an estimate. Hopefully Blizz fixes this soon"] = "仅作为估算用，希望暴雪尽快修复"
    GRM_L["Add Upcoming Events to the Calendar"] = "将活动添加至日历"
    GRM_L["Player rank unable to add events to calendar"] = "玩家没有添加活动的权限"
    GRM_L["Anniversaries, Birthdays, and Other Events can be added with permission"] = "有权限的玩家可以添加入会周年日、生日及其他活动"

    -- R1.1510
    GRM_L["Check the \"Sync Users\" tab to find out why!"] = "检查\"同步用户\"标签以查明原因!"
    GRM_L["Time as Member:"] = "入会时长:"
    GRM_L["|CFFE6CC7FClick|r to select player event"] = "|CFFE6CC7F点击|r以选择玩家活动"
    GRM_L["Timestamp:"] = "时间戳："
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
    GRM_L["{num} guild ranks have been removed!"] = "公会移除了{num}个会阶!"
    GRM_L["Edit Ban"] = "编辑黑名单状态"
    GRM_L["Please Select a Player to Edit their Ban!"] = "选择一个玩家以编辑其黑名单状态!"
    GRM_L["Update Ban"] = "更新黑名单状态"
    GRM_L["{name}'s Ban Info has Been Updated!"] = "{name}的黑名单状态已更新!"

    -- R1.1530
    GRM_L["{name} plays the {custom1} class, not {custom2}."] = "{name}的职业是{custom1}而非{custom2}."    -- Example: Arkaan plays the Hunter class, not Paladin.
    GRM_L["{num} Items Updated"] = "{num}个物品已更新"
    GRM_L["You Currently Have Disabled Adding Events to Calendar"] = "向日历添加活动功能已禁用"

    -- R1.20
    GRM_L["|CFFE6CC7FHold Shift|r to view more alt details."] = "|CFFE6CC7F按住Shift|r显示更多小号信息。"    -- "Hold Shift to view more alt details" is the phrase, but the |CFF|r is the text coloring hex code. Please keep it in there on the keyboard command coloring
    GRM_L["|CFFE6CC7FClick|r to view more alt details."] = "|CFFE6CC7F点击|r显示更多小号信息。"
    GRM_L["{custom1} to keep alt details open."] = "{custom1}以保持显示小号信息。"    -- The same can be said here. ^^
    GRM_L["|CFFE6CC7FClick|r to flip player name ordering"] = "|CFFE6CC7F点击|r按照玩家名称反向排列"    -- and the reset...
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Newest"] = "|CFFE6CC7F点击|r按照加入日期由新到旧排列"
    GRM_L["|CFFE6CC7FClick|r to sort Join Dates by Oldest"] = "|CFFE6CC7F点击|r按照加入日期由旧到新排列"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Newest"] = "|CFFE6CC7F点击|r按照晋升日期由新到旧排列"
    GRM_L["|CFFE6CC7FClick|r to sort Promotion Dates by Oldest"] = "|CFFE6CC7F点击|r按照晋升日期由旧到新排列"
    GRM_L["|CFFE6CC7FClick|r to sort all Mains first"] = "|CFFE6CC7F点击|r按照主号优先排列"
    GRM_L["|CFFE6CC7FClick|r to sort all Alts first."] = "|CFFE6CC7F点击|r按照小号优先排列"
    GRM_L["{name}'s Alts"] = "{name}的小号"    -- Like "Arkaan's Alts"
    GRM_L["GRM window will open when combat ends."] = "GRM窗口会在离开战斗后打开。"

    -- R1.24
    GRM_L["This also will change the <Alt> format to match"] = "此选项也会改变<小号>格式"
    GRM_L["M"] = "主"    -- Of note, the "M" is short for "Main" and this is the reference to the main tag on alts in guild chat. For use in the Main tagging <M> (M) etc...
    GRM_L["A"] = "小"

    -- R1.25
    GRM_L["Include \"Joined:\" tag with the date."] = "在日期前包含 \"加入:\" 标签。"    -- the \" is so you include the qutoations in the actual text. You need them or it closes the phrase.
    GRM_L["GRM Auto-Detect! {name} has joined the guild and will be set as Main"] = "GRM自动检测：{name}加入了公会，此角色已被设为主号。"    -- Main auto-detect message

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
    GRM_L["Kick the Player's {num} alts too?"] = "要将此玩家的 {num} 个小号一同踢出吗？"    -- Plural
    GRM_L["Kick the Player's {num} alt too?"] = "要将此玩家的 {num} 个小号一同踢出吗？"    -- Not Plural  - "Kick the Player's 1 alt too?"
    GRM_L["Ban and Kick the Player's {num} alts too?"] = "要将此玩家的 {num} 个小号一同加入黑名单并踢出吗？"
    GRM_L["Ban and Kick the Player's {num} alt too?"] = "要将此玩家的 {num} 个小号一同加入黑名单并踢出吗？"

    -- R1.30
    GRM_L["Sync With {name} is Complete..."] = "与 {name} 的同步已完成..."
    GRM_L["|CFFE6CC7FLeft-Click|r and drag to move this button."] = "|CFFE6CC7F点击|r 并拖动此按钮。"
    GRM_L["{custom1} and drag to move this button anywhere."] = "{custom1} 并拖动以将此按钮移动至任何位置。"
    GRM_L["MOTD:"] = "今日信息:"    -- Message Of The Day = M.O.T.D = MOTD -
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
    GRM_L["Remove Date"] = "移除生日"    -- Clear Birthday shorthand
    GRM_L["Birthday"] = "生日"
    GRM_L["Only Announce Birthdays and Anniversaries if Listed as 'Main'"] = "只公告'主号'的生日及周年日"
    GRM_L["{name} will be celebrating {num} year in the Guild!"] = "这天是 {name} 加入公会 {num} 周年纪念日!"    -- {custom1} will reference the DATE. Ex: "Arkaan will be celebrating 1 year in the Guild! ( 1 May )" - SINGULAR
    GRM_L["{name} will be celebrating {num} years in the Guild!"] = "这天是 {name} 加入公会 {num} 周年纪念日!"    -- Same thing but PLURAL - "years" in stead of "year"
    GRM_L["No player's currently available to sync {name}'s Guild Data..."] = "无法与任何玩家同步 {name} 的公会信息..."
    GRM_L["{name} has set {name2}'s Birthday: {custom1}"] = "{name} 已将 {name2} 的生日设为: {custom1}"    -- custom note is the date like "12 Dec"
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
    GRM_L["Your Guild Leader Has Set Join Dates to only be added to the {name}"] = "只能在 {name} 中添加加入日期"    -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...
    GRM_L["Warning - Global Controls:"] = "警告 - 全局设置:"
    GRM_L["Sync Restrictions Globally Changed to {name} or Higher"] = "同步限制全局设置已改为 {name} 或更高的会阶成员"
    GRM_L["BAN Sync Restrictions Globally Changed to {name} or Higher"] = "黑名单同步限制全局设置已改为 {name} 或更高的会阶成员"
    GRM_L["CUSTOM NOTE Sync Restrictions Globally Changed to {name} or Higher"] = "自定义备注同步限制全局设置已改为 {name} 或更高的会阶成员"
    GRM_L["Join Dates Globally Changed to only be added to the {name}"] = "加入日期全局设置已改为仅为 {name} 添加"
    GRM_L["Unable to Modify. Global setting is set to the {name}"] = "无法修改，全局设置为 {name}"    -- The {name} will be the "Officer note" or "Public Note" or "Custom Note"  set, based on their settings...

    -- R1.37
    GRM_L["No Action Configured"] = "无设置修改"
    GRM_L["OLD LOG"] = "旧日志"
    GRM_L["CHANGES"] = "变更"
    GRM_L["Sync has failed to start. Please try again!"] = "无法同步，请再试一次!"
    GRM_L["Please wait {num} more seconds before manually initiating the sync process again."] = "请等待 {num} 秒后再手动启动同步。"

    -- R1.39
    GRM_L["Only Report if there are no Active Alts in the Group"] = "仅在所有小号也未活跃时通告"
    GRM_L["Level Filter Minimum:"] = "通告的最低等级:"    -- As in player level
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
    GRM_L["|cffff0000WARNING!!!|r {num} BANNED player is currently in the guild."] = "|cffff0000警告!!!|r 公会中有 {num} 个位于黑名单中的玩家。"    -- Singular  -- please keep the color coding... this keeps the Warning in red

    -- R1.41
    GRM_L["Auto-Focus the search box"] = "自动聚焦搜索栏"
    GRM_L["This will skip the first time if set to load on logon"] = "如果设为登录时读取，则将跳过第一次。"    -- Referring to the auto-focusing on the search box, this is a tooltip helper
    GRM_L["Please enter a valid level between 1 and {num}"] = "请从 1 至 {num}中选择一个有效等级"
    GRM_L["Player's Main: {name}"] = "玩家的主号: {name}"

    -- R1.43
    GRM_L["One moment, requesting additional details on {name} from the server. Ban List will soon update."] = "请等待，正在从服务器获取 {name} 的额外数据，黑名单将在稍后更新。"
    GRM_L["Unable to identify {name}. Ensure your spelling is accurate and the correct realm is selected!"] = "未找到 {name} ，请输入正确的角色名并选择正确的服务器名！"
    GRM_L["(Unable to Identify)"] = "(未找到)"    -- As in, unable to identify on the server, they possibly server transferred off but are still on ban list
    GRM_L["|CFFE6CC7FClick|r to select player class"] = "|CFFE6CC7F点击|r 选择玩家职业。"
    GRM_L["|CFFE6CC7FClick|r to select player's realm."] = "|CFFE6CC7F点击|r 选择玩家服务器。"
    GRM_L["All Connected Realms are available to choose."] = "可选择所有合并服务器。"
    GRM_L["{num} players were found to have the same name. Please manually select the player's realm"] = "找到 {num} 个此名字的玩家，请手动选择玩家所在的服务器"
    GRM_L["Click or Press TAB to cycle through each step."] = "左键点击或按TAB切换各个步骤。"
    GRM_L["Former and Current Members"] = "前成员及现有成员"
    GRM_L["No Matches Found. Add a Custom New Player or Match"] = "未找到匹配项。添加新自定义玩家或匹配项"    -- as in, autocomplete typing matching

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
    GRM_L["kick"] = "踢出"
    GRM_L["ban"] = "封禁"
    GRM_L["audit"] = "审计"
    GRM_L["log"] = "日志"
    GRM_L["event"] = "事件"
    GRM_L["events"] = "事件"
    GRM_L["users"] = "用户"
    GRM_L["syncusers"] = "同步用户"
    GRM_L["opt"] = "选项"
    GRM_L["option"] = "选项"
    GRM_L["options"] = "选项"

    GRM_L["GRM Date"] = "GRM日期"
    GRM_L["Note Date"] = "备注日期"
    GRM_L["Status"] = "状态"
    GRM_L["Refresh"] = "刷新"
    GRM_L["Clear Selection"] = "清除选择"
    GRM_L["Fix all mismatched note dates with GRM saved date"] = "用GRM保存的数据来修复所有不匹配的备注日期。"
    GRM_L["Fix selected mismatched note dates with GRM saved date"] = "用GRM保存的数据来修复所选择的不匹配的备注日期。"
    GRM_L["Fix all mismatched GRM dates with the note date"] = "用备注日期数据来修复所有GRM的不匹配日期。"
    GRM_L["Fix selected mismatched GRM dates with the note date"] = "用备注日期数据来修复所选择的GRM的不匹配日期。"
    GRM_L["Import all missing join dates from the note date"] = "将备注日期导入至所有缺失的加入日期";
    GRM_L["Import selected missing join dates from the note date"] = "将备注日期导入至所选择的缺失加入日期"
    GRM_L["Add all missing saved dates to the {name}"] = "为 {name} 添加所有缺失的保存日期";
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
    GRM_L["{num} Join Dates Need Attention"] = "{num} 个加入日期需特别注意"    -- In other words, "155 join dates need attention" as an example
    GRM_L["Do you really want to remove the join dates from notes other than the {name}?"] = "确认将除 {name} 以外所有的加入日期从备注中清除吗?"
    GRM_L["Do you really want to fix mismatched dates using the note?"] = "确认使用备注来修复所有不匹配的日期吗?"
    GRM_L["Do you really want to fix note dates using the saved GRM dates?"] = "确认使用GRM日期来修复备注中的日期吗?"
    GRM_L["Do you really want to add the missing join dates to the {name}?"] = "确认将确实的加入日期写入 {name}?"    -- add the missing join dates to the default note name - like "... to the Officer Note?"
    GRM_L["Auto-adding join dates to the {name} is disabled. Do you still wish to continue?"] = "自动向 {name} 添加加入日期的功能已被禁用，仍要继续吗?"    -- Just as above
    GRM_L["There are currently {num} mismatched dates to fix"] = "有 {num} 个不匹配的日期需要修复"
    GRM_L["There are currently no mismatched dates that need to be fixed."] = "没有不匹配的日期需要修复。"
    GRM_L["There are currently no dates that need to be imported."] = "没有日期需要导入。"
    GRM_L["There are currently no dates that can be added to the default note."] = "没有日期可以加入默认备注。"
    GRM_L["There are currently no dates that need to be removed from incorrect notes"] = "没有日期需要从错误的备注种类中清除"
    GRM_L["There are currently {num} players who have join dates listed in the incorrect note"] = "有 {num} 名玩家的加入日期位于错误的备注种类中"
    GRM_L["Warning! Your function is extremely limited without officer permissions"] = "警告! 没有公会官员的许可，你的功能将受限"
    GRM_L["Advanced Join Date Tool"] = "进阶加入日期工具"

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
    GRM_L["Really remove {name} Backup Point?"] = "确认要清除{name}的备份点?"    -- The {name} is the guildName

    -- 1.63
    GRM_L["Disabled"] = "已禁用"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays January to December"] = "|CFFE6CC7F点击|r按照生日月份升序排列"
    GRM_L["|CFFE6CC7FClick|r to sort Birthdays December to January"] = "|CFFE6CC7F点击|r按照生日月份降序排列"

    -- 1.64
    GRM_L["Chat Window for All GRM Messages:"] = "所有GRM信息的聊天窗口:"
    GRM_L["\"{name}\" Chat Window\nDo you wish to create it?"] = "\"{name}\"聊天窗口\n确认创建?"    -- the \n indicates a line break.
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
    GRM_L["Macro Size: {num}/255"] = "宏字数: {num}/255"    -- "Macro Size: 242/255"
    GRM_L["Action"] = "操作"
    GRM_L["Ignored Action:"] = "忽略的操作:"    -- As in, the action being ignored, be it kick or promote or demote.
    GRM_L["Click to Build Macro"] = "点击以创建宏"
    GRM_L["No Current Names to Add"] = "无现有名字可添加"
    GRM_L["No Names to Add to the Macro"] = "无名字可添加至宏"
    GRM_L["Hot Key: {name}"] = "热键: {name}"
    GRM_L["Permissions"] = "许可"
    GRM_L["Player rank change detected, re-checking permissions and rebuilding GRM Macro Tool."] = "检测到会阶变化，重新确认许可并重新创建GRM宏工具。"
    GRM_L["Click to remove selected names from the macro"] = "点击以将名字从宏中移除"    -- Plural form of statement
    GRM_L["Click to remove selected name from the macro"] = "点击以将名字从宏中移除"    -- Singular form of statement
    GRM_L["Click to remove selected names from Ignore List"] = "点击以将名字从忽略名单中移除"    -- Plural
    GRM_L["Click to remove selected name from Ignore List"] = "点击以将名字从忽略名单中移除"    -- Singular
    GRM_L["No names selected to remove from macro"] = "未从宏中移除名字"
    GRM_L["No names selected to remove from Ignore List"] = "未从忽略名单中移除名字"
    GRM_L["Macro is currently empty"] = "宏是空的"
    GRM_L["{num} players removed from the macro"] = "{num}名玩家已从宏中移除"    -- plural form of the statement
    GRM_L["{num} player was removed from the macro"] = "{num}名玩家已从宏中移除"    -- singular form of the statement
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
    GRM_L["No players are currently safe from recommendations"] = "目前没有玩家免于推荐"
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
    GRM_L["No players to select. 1 player filtered"] = "没有可选择的玩家，已过滤1名玩家。"    -- Singular
    GRM_L["No players to select. {num} players filtered"] = "没有可选择的玩家，已过滤{num}名玩家。"    -- Plural
    GRM_L["There are no names to select. 1 player is filtered"] = "没有可选择的名字，已过滤1名玩家。"    -- these 2 statements might seem redundant, but often the text on a button is more short hand. This gives a cleaner statement in the chat. Useful for translating in some languages that need a bit more room to be more clear.
    GRM_L["There are no names to select. {num} players are filtered"] = "没有可选择的名字，已过滤{num}名玩家。"
    GRM_L["Really remove selected player from the ignore list?"] = "真的要将所选玩家从忽略名单中移除吗?"
    GRM_L["Really remove the {num} selected players from the ignore list?"] = "真的要将所选的{num}名玩家从忽略名单中移除吗?"
    GRM_L["Do you really wish to clear all players from the Ignore List?"] = "真的要将所有玩家从忽略名单中移除吗?"
    GRM_L["There are currently no players on the Ignore List"] = "忽略名单中无玩家"
    GRM_L["Remove all players from Ignore List"] = "将所有玩家从忽略名单中移除"
    GRM_L["Ignored Players: {num}"] = "已忽略玩家: {num}"
    GRM_L["Tool"] = "工具"    -- /grm tool
    GRM_L["Macro Tool"] = "宏命令工具"
    GRM_L["Macro Tool: {num}"] = "宏命令工具: {num}"

    -- CLASSIC
    GRM_L["Social"] = "社交"
    GRM_L["Roster"] = "名单"
    GRM_L["Feature is disabled in WoW Classic"] = "功能在魔兽世界怀旧服中被禁用"
    GRM_L["Feature is disabled in TBC Classic"] = "功能在燃烧的远征怀旧服中被禁用"    -- Just laying groundwork now in case Blizz ever releases it. Calendar was not added until WOTLK
    GRM_L["(Classic)"] = "(怀旧服)"    -- tooltip tag that shows only on the minimap mosueover version tooltip in Classic

    -- 1.69
    GRM_L["Importing dates must be done in a compatible format"] = "导入的日期必须是兼容的格式"
    GRM_L["The date selection in OPTIONS shows all supported"] = "请前往设置标签的日期选择查看所有支持的格式"
    GRM_L["Headers, like \"Joined,\" are supported"] = "支持使用标头, 例如：\"加入于\""
    GRM_L["To confirm or edit the date, open the player window, right click the date, edit, and submit"] = "若要确认或编辑日期，请打开玩家窗口，右键日期并编辑，然后提交"    --The "!!" tags are the {name}
    GRM_L["To confirm or edit the date, right click the date, edit, and submit"] = "若要确认或编辑日期，请右键日期并编辑，然后提交"    -- Slightly shorter explanation if already on player window
    GRM_L["The {name} tag indicates a date must be verified to sync"] = "{name}标签代表一个日期在同步前需被核实"

    -- 1.70
    GRM_L["GRM has errored due to a previous incompatible build with Classic that was enabled. Click YES to reload UI and fix the issue"] = "由于存在旧的与怀旧服不兼容的版本，GRM出现错误，点击确认以重载界面并修复此问题。"
    GRM_L["(Disabled in Classic)"] = "(在怀旧服中禁用)"    -- For the Options... rather than removing them all

    -- 1.73
    GRM_L["{name} is no longer in the Guild!"] = "{name}已不是公会成员!"    -- There should really be 3 options. They got kicked, they left on their own, or if not found in the event log, they are just no longer in the guild
    GRM_L["is no longer in the Guild!"] = "已不是公会成员!"    -- THIS MUST MATCH THE PREVIOUS LINE with missing name.
    GRM_L["Applying update patches... one moment."] = "正在应用更新补丁...请稍后。"
    GRM_L["Update Complete... {num} patches applied."] = "更新完成...应用了{num}个补丁。"    -- Plural
    GRM_L["Update Complete... 1 patch applied."] = "更新完成...应用了1个补丁。"    -- Singular version
    GRM_L["Disabling will also hide the Birthday info on the roster mouseover window"] = "禁用此项也会在名单鼠标提示中隐藏生日信息"    -- Enable/disable birthday chekbox on UI Options and the Audit windoppw
    GRM_L["Confirm Date"] = "确认日期"
    GRM_L["If the date is accurate, right click and select 'Confirm Date'"] = "如果日期正确，请右键点击并选择“确认日期”"

    -- 1.74
    GRM_L["Class Colorize Names in Guild Member Alerts"] = "在公会成员警告中以职业色显示名字"
    GRM_L["All player custom notes re-enabled for sync and their checkboxes set."] = "所有玩家自定义备注已重新启用同步并勾选其复选框。"

    -- 1.75
    GRM_L["!note"] = "!备注"    -- !note in English will always work. This gives you the option of creating your own key to register a public note.
    GRM_L["No officer online to set {name}'s note"] = "无官员在线，无法设置{name}的备注"
    GRM_L["No officer is currently online to update your note"] = "无官员在线，无法更新你的备注"
    GRM_L["Allow Guild Members to Type \"!note notehere\" to Set Their Own Public Note"] = "允许公会成员输入\"!note notehere\"以设置他们自己的公共备注"
    GRM_L["Enabled"] = "已启用"    -- As in, the opposite of Disabled
    GRM_L["'!note' trigger has been globally ENABLED"] = "'!note'触发已启用"
    GRM_L["'!note' trigger has been globally DISABLED"] = "'!note'触发已禁用"

    -- 1.76
    GRM_L["Same Rank"] = "相同会阶"    -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Higher Rank"] = "更高的会阶"    -- Macro Tool, Ignore List window - tooltip info on why no action is being done on some players who may be on it.
    GRM_L["Limited Features. There is no Calendar in Classic"] = "怀旧服无日历，此功能受限"    -- Events Tab top warning
    GRM_L["This only affects settings for your current guild: {name}"] = "此设置只会影响你当前所在的公会: {name}"    -- Tooltip for Options > General > Sync settings to all alts in same guild
    GRM_L["GC"] = "全"    -- Options window, acronym for "Global Controls" and will be adjacent to all settings that have global controls
    GRM_L["*GC = Global Control - Use Guild Info to Force Setting For All"] = "*全 = 全局设置 - 强制用公会信息为所有人设定"    -- Top left Options window
    GRM_L["Set Global Controls"] = "设定全局设置"    -- Options > Officer Tab > Bottom left export button
    GRM_L["Global Control Values Set in Guild Info"] = "将全局设置写入公会信息"    -- Export GuildInfo tool tooltip
    GRM_L["Configure your settings. Click to set in Guild Info"] = "调整你的设置，然后点击以写入公会信息"    -- Tooltip line 2- same as above
    GRM_L["Unable to add globals controls to GuildInfo. There is not enough room."] = "无法将全局设置添加到公会信息，没有足够的空间。"    -- If export of globals is not able to complete
    GRM_L["Global controls exported to the guild info note. Updating..."] = "全局设定已导出至公会信息文档，更新中..."    -- Success in exporting
    GRM_L["Your rank cannot edit the Guild Info"] = "你没有编辑公会信息的权限"    -- Mouseover tooltip helper for people without MOTD edit access
    GRM_L["All global controls are already set. You must Edit or Remove the settings manually in the guild Info."] = "全局设置已完成，你需要手动在公会信息中编辑或移除设置。";
    GRM_L["Do you really want to wipe all GRM data and settings account-wide?"] = "确认将此账号下的所有GRM数据移除吗?"
    GRM_L["Are you sure your settings are configured and ready for global controls?"] = "确认所有设定已完成并可以进入全局设定?"
    GRM_L["Players the same rank or higher will not be shown"] = "不会显示相同或更高会阶的玩家"
    GRM_L["Macro"] = "宏"    -- For the slash command  /grm tool or /grm macro - same thing

    -- 1.77
    GRM_L["Add Custom Rule"] = "添加自定义规则"    -- Kick Macro Tool - custom rule button right side
    GRM_L["Former Members"] = "前成员"    -- Export tool
    GRM_L["Data Export"] = "数据导出"
    GRM_L["*Max Export is 500 Log Entries at a Time"] = "*单次最多只能导出500条日志"
    GRM_L["*Max Export is 500 Members at a Time"] = "*单次最多只能导出500名成员"
    GRM_L["*Max Export is 500 Former Members at a Time"] = "*单次最多只能导出500名前成员"
    GRM_L["*Export obeys the current log display filters"] = "*导出会遵循现有的日志过滤规则"
    GRM_L["Select Line Range:"] = "选择条目范围:"
    GRM_L["Select Member Range:"] = "选择成员范围:"
    GRM_L["Export Selection"] = "导出选择项"
    GRM_L["Export Next {num}"] = "导出之后的{num}个"    -- As in, "Export next 500" names or log lines
    GRM_L["Export Prev {num}"] = "导出之前的{num}个"    -- As in, Export Previous name
    GRM_L["Total Members: {num}"] = "成员总计: {num}"
    GRM_L["Total Former Members: {num}"] = "前成员总计: {num}"
    GRM_L["Class"] = "职业"    -- As in Class Name, there is currently a "Class:" we need one with the colon
    GRM_L["Guild Rep"] = "公会声望"    -- Guild Faction reputation (abbreviated)
    GRM_L["Last Online (Days)"] = "上一次在线(天)"
    GRM_L["Spreadsheet Headers"] = "表格项目名"
    GRM_L["Auto Include Headers"] = "自动包含项目名"    -- Auto include headers on the export frame, as in the column headers for each category on member and former mebers
    GRM_L["These will only be included if exporting from the top of the table"] = "当从表格开头输出时才会包含这些项"    -- tooltip for the auto-Included export checkbutton
    GRM_L["Export"] = "导出"
    GRM_L["This will be rounded to the nearest day"] = "此日期将会被设为最近的日期"
    GRM_L["Clearing Log Export. A filter setting has been changed."] = "清除日志输出，过滤器被修改"    -- If the filter settings have been modified, the export string should be cleared and re-done
    GRM_L["No Tag"] = "无标签"    -- Main Tag
    GRM_L["Delimiter:"] = "分隔符:"    -- Delimiter selection for Export window
    GRM_L["The selected delimiter will be removed from all notes on export"] = "在输出时会从所有文档中移除选择的分隔符"
    GRM_L["Choose thoughtfully"] = "请谨慎选择"
    GRM_L["{name}'s note has been updated!"] = "{name}的备注已被更新！"
    GRM_L["Locked. Press ESC"] = "已锁定，按ESC解锁"    -- Mouseover Locked text in top right.
    GRM_L["|CFFE6CC7FClick|r to Select for Removal"] = "|CFFE6CC7F点击|r以选择移除"
    GRM_L["Feel free to recommend a delimiter you wish to use to the author"] = "可联系作者添加你想要的分隔符"
    GRM_L["Export Tool"] = "导出工具"
    GRM_L["Opens the Data Export Tool"] = "打开数据导出工具"
    GRM_L["Opens the Advanced Macro Tool"] = "打开进阶宏命令工具"

    -- 1.78
    GRM_L["Hurray!"] = "好耶!"    -- A short cheer! Like "Yay!" except "Hurray!"
    GRM_L["{name} has Reached the {num} Level Cap! {custom1}"] = "{name}已达到满级{num}级! {custom1}"    -- Arkaan has Reached the 120 Level Cap! Hurray!

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
    GRM_L["{name} {name2}"] = "{name2}{name}"    -- This might seem weird, but the format is "Race Sex" In other words, "Orc Male" or "Nightborne Female" and so on. Adjust how you see fit, it appears in the mouseover tooltip on the player name

    -- 1.82
    GRM_L["Disabled While Player is Grouped"] = "玩家在队伍中, 已被禁用"
    GRM_L["SYNC is currently disabled while you are grouped. Due to server restricted addon to addon talk data caps, and in an effort to avoid clogging up the shared global comm space of all addons, sync will be temporarily restricted while grouped."] = "当你在队伍中时同步将被禁用。原因：游戏服务器对插件之间的数据传递有最大限制，为了避免过多占用所有插件的共用沟通空间，当你在一个队伍中时同步将暂时被禁用。"

    -- 1.85
    GRM_L["The note is too long. Only the first {num} characters will be set."] = "备注过长, 将只写入前{num}个字符"
    GRM_L["Apply Only to Selected Ranks"] = "只对选择的会阶采用"
    GRM_L["Unable to create hotkey macro. Player is currently in combat and action is restricted. It will auto-build once out of combat."] = "战斗中无法创建热键宏, 玩家离开战斗后宏将自动创建。"
    GRM_L["No player data found, recommend full removal."] = "未找到玩家数据，建议完全移除。"
    GRM_L["OR"] = "或"    -- "Or" as in  This OR that  Use this button OR that button -- Advanced JD audit tool.
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
    GRM_L["Include Headers"] = "包含标头";
    GRM_L["Join Header"] = "加入公会标头";
    GRM_L["ReJoin Header"] = "重新加入标头";
    GRM_L["!note Control"] = "!note控制"
    GRM_L["You need to clear {num} characters to fit the control tags"] = "控制标签过长，请删除至少{num}个字符"
    GRM_L["A new format exists for global settings controls."] = "全局设置控制已存在新格式"
    GRM_L["Go to GRM window > Options > Officer Tab > \"Set Global Controls\""] = "前往GRM窗口 > 设置 > 官员 > \"设定全局设置\""
    GRM_L["Remove the old format when all guildies have updated properly. You may wish to leave it in Guild Info until then."] = "当所有公会成员都正确更新后，请移除旧格式。在此之前，您可以将其保留在公会信息中。"
    GRM_L["It may take up to 60 seconds for other guild members to detect the changes and update."] = "其他公会成员可能需要最多60秒才能检测到更改并更新。"
    GRM_L["Resets only the settings on this page"] = "仅重置此页面的设置"
    GRM_L["Resets only the Export Settings"] = "仅重置导出设置"
    GRM_L["Resets all Macro Tool Rules and Settings"] = "重置所有宏工具规则和设置"
    GRM_L["Are you sure you want to reset all Macro Tool Rules and Settings?"] = "您确定要重置所有宏工具规则和设置吗？"
    GRM_L["Export settings to unify sync controls, timestamp format, and so on with your officers and members."] = "导出设置以与您的官员和成员统一同步控制、时间戳格式等。"
    GRM_L["Consult with your guild leader and export settings to unify sync controls, timestamp format, and so on."] = "请咨询您的公会会长并导出设置，以统一同步控制、时间戳格式等。"
    GRM_L["Global controls have not yet been set!"] = "全局控制尚未设置！"
    GRM_L["Include Birthdays as Incomplete"] = "将生日视为未完成"
    GRM_L["Make room and transfer before clearing"] = "清除前腾出空间并转移"
    GRM_L["1 player has a join date listed in the incorrect note."] = "1 名玩家的入会日期列在错误的备注中。"    -- Singular (Join Date Audit tool - bottom button mouseover) - rare tooltip use
    GRM_L["{num} players have join dates listed in the incorrect note."] = "{num} 名玩家的入会日期列在错误的备注中。"    -- Plural (same)
    GRM_L["Otherwise, {num} notes are ready to be cleared from the incorrect location"] = "否则，{num} 条备注已准备好从错误位置清除"    -- Plural (same tooltip)
    GRM_L["Otherwise, 1 note is ready to be cleared from the incorrect location"] = "否则，1 条备注已准备好从错误位置清除"    -- Plural (same tooltip)
    GRM_L["There are currently {num} dates that can be added to the {name}"] = "目前有 {num} 个日期可添加到 {name}"
    GRM_L["The previous action still has 1 recommended task. It is advised to do that first."] = "上一步操作仍有 1 个建议任务。建议先完成它。"    -- Singular
    GRM_L["The previous action still has {num} recommended tasks. It is advised to do those first."] = "上一步操作仍有 {num} 个建议任务。建议先完成它们。"    -- Plural
    GRM_L["Step {num}"] = "第 {num} 步"    -- Like Step 1 , Step 2 , etc.

    -- R1.86
    GRM_L["What tags look like:"] = "标签样式示例："
    GRM_L["Add Join Date to:"] = "添加入会日期到："

    -- R1.87
    GRM_L["|CFFE6CC7FLeft-Click|r to Disable Rule"] = "|CFFE6CC7F左键点击|r禁用规则"
    GRM_L["|CFFE6CC7FLeft-Click|r to Enable Rule"] = "|CFFE6CC7F左键点击|r启用规则"
    GRM_L["Edit"] = "编辑"
    GRM_L["|CFFE6CC7FClick|r to Change the Rule Name"] = "|CFFE6CC7F点击|r更改规则名称"
    GRM_L["Apply to All Ranks"] = "应用到所有阶层"
    GRM_L["Please select at least 1 RANK to apply this rule to."] = "请至少选择 1 个要应用此规则的阶层。"
    GRM_L["Apply to All Levels"] = "应用到所有等级"
    GRM_L["Apply Only to Level Range"] = "仅应用到等级范围"
    GRM_L["Level Range:"] = "等级范围："
    GRM_L["{num} to {custom1}"] = "{num} 到 {custom1}"    -- Example: "Level Range: 100 to 120"
    GRM_L["1 to {num}"] = "1 到 {num}"    -- Same principle.
    GRM_L["Require Text Match"] = "需要文本匹配"
    GRM_L["Click to Set"] = "点击设置"
    GRM_L["Inactivity:"] = "离线："
    GRM_L["Notify if inactive for {num} {name}"] = "离线达到 {num} {name} 时通知"    -- Notify if inactive for 15 Days  or Notify if inactive for 10 Months
    GRM_L["Rule Filter: {name}"] = "规则筛选：{name}"
    GRM_L["Ranks:"] = "阶层："
    GRM_L["All Ranks"] = "所有阶层"
    GRM_L["Note Match:"] = "备注匹配："
    GRM_L["Please Set a Name for this Rule. It can be 1 to 30 characters in length."] = "请为此规则设置名称。长度可为 1 到 30 个字符。"
    GRM_L["This will also clear all of your saved rules."] = "这也将清除你所有已保存的规则。"
    GRM_L["Within Level Range: {num} - {custom1}"] = "在等级范围内：{num} - {custom1}"    -- Qued macro tool tooltip
    GRM_L["Note match: {name}"] = "备注匹配：{name}"    -- Same
    GRM_L["Matching Rank"] = "匹配阶层"    -- ''
    GRM_L["Right-Click|r to Edit or Remove custom rule"] = "右键点击|r编辑或移除自定义规则"    -- Please keep the '|r' immediately after the click info - as it indicates a text color change point
    GRM_L["(Applies Only to Classic)"] = "（仅适用于怀旧服）"    -- For the Options... rather than removing them all

    -- R1.88
    -- Group Info Module
    GRM_L["GRM Info"] = "GRM 信息"
    GRM_L["GRM Group Info"] = "GRM 队伍信息"
    GRM_L["Group Info"] = "队伍信息"
    GRM_L["Click to Lock Info Window"] = "点击锁定信息窗口"
    GRM_L["Guildies: {num}"] = "公会成员: {num}"
    GRM_L["Former Guildies: {num}"] = "前公会成员: {num}"
    GRM_L["Other {name} Members: {num}"] = "其他{name}成员: {num}"    -- "Other Zul'jin Members: 5"  - basically just your realm name. This can be useful to know who in your raid is your realm as you can trade more freely.
    GRM_L["Total in Group: {num}"] = "队伍总人数: {num}"
    GRM_L["Date Left"] = "离开日期"
    GRM_L["1 Alt Still in Guild"] = "1个小号仍在公会中"
    GRM_L["{num} Alts Still in Guild"] = "{num}个小号仍在公会中"
    GRM_L["Known Alts:"] = "已知小号:"
    GRM_L["Close Enough to Trade"] = "距离足够交易"
    GRM_L["Plugins"] = "插件"    -- plural
    GRM_L["Plugin"] = "插件"    -- Singular
    GRM_L["Module"] = "模块"
    GRM_L["GRM Optional Modules"] = "GRM 可选模块"
    GRM_L["Enable Module"] = "启用模块"
    GRM_L["Show Interactable Distance Indicator"] = "显示可交互距离指示器"
    GRM_L["No GRM Modules Currently Installed"] = "当前未安装 GRM 模块"
    GRM_L["Custom Color"] = "自定义颜色"
    GRM_L["{name} is listed as the Main"] = "{name} 已被列为大号"
    GRM_L["Kick Banned in Guild"] = "踢出公会中的封禁成员"
    GRM_L["Kick macro created. Press Hotkey to Remove Banned Players Still in Guild"] = "踢出宏已创建。按快捷键移除仍在公会中的封禁玩家"
    GRM_L["Easily remove all Banned players still in the Guild with the Macro Tool"] = "使用宏工具轻松移除仍在公会中的所有封禁玩家"
    GRM_L["GRM will automatically send messages to the \"{name}\" window if you remove all custom channels."] = "如果你移除所有自定义频道，GRM 将自动向“{name}”窗口发送消息。"
    GRM_L["Multi-Channel support. Just separate with commas"] = "支持多频道。只需用逗号分隔"
    GRM_L["Disable tooltip. Only show popout window."] = "禁用鼠标提示。仅显示弹出窗口。"

    -- R1.89
    GRM_L["GRM API Error:"] = "GRM API 错误:"
    GRM_L["The guild name \"{name}\" cannot be found in the database. Ensure proper formatting."] = "在数据库中找不到公会名称“{name}”。请确保格式正确。"
    GRM_L["The player name \"{name}\" cannot be found in the database. Ensure proper spelling."] = "在数据库中找不到玩家名称“{name}”。请确保拼写正确。"
    GRM_L["Unable to change officer notes at current rank"] = "当前会阶无法修改官员备注"
    GRM_L["Player is not currently in a Guild"] = "玩家当前不在公会中"
    GRM_L["Mains Only"] = "仅大号"
    GRM_L["Alts Only"] = "仅小号"
    GRM_L["Custom Public Notes:"] = "自定义公众备注:"    -- Updated from Custom Notes
    GRM_L["Leave unchecked to export every member of the guild"] = "取消勾选以导出公会的所有成员"
    GRM_L["Only the 10 most recent rank changes will be included"] = "仅包含最近10次会阶变动"
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} 1 time to complete all actions"] = "准备好移除玩家时，按1次快捷键 {name} 以完成所有操作"
    GRM_L["When you are ready to remove the players, press the Hot-Key {name} {num} times to complete all actions"] = "准备好移除玩家时，按{num}次快捷键 {name} 以完成所有操作"
    GRM_L["This only affects GRM tooltips"] = "这仅影响 GRM 鼠标提示"
    GRM_L["Unable to remove players from the guild at current rank."] = "当前会阶无法将玩家移出公会。"
    GRM_L["Unable to promote players within the guild at current rank."] = "当前会阶无法提升公会成员。"
    GRM_L["Unable to demote players within the guild at current rank."] = "当前会阶无法降级公会成员。"
    GRM_L["Feature disabled."] = "功能已禁用。"
    GRM_L["Does NOT apply to Ban List"] = "不适用于封禁列表"
    GRM_L["This only applies to Alt/Main Groupings, Join Dates, Promotion Dates, Birthdates, and Custom Notes."] = "仅适用于大小号分组、入会日期、升职日期、生日和自定义备注。"
    GRM_L["Custom Notes can be Restricted Further Below"] = "自定义备注可在下方进一步限制"
    GRM_L["All ranks will receive the outgoing player data. Only players of the selected rank or higher can modify and share that data."] = "所有会阶都将收到发出的玩家数据。只有所选会阶及以上的玩家才能修改和分享该数据。"
    GRM_L["Default Open Tab:"] = "默认打开标签:"
    GRM_L["{num} guild members have incomplete info."] = "{num} 名公会成员信息不完整。"
    GRM_L["Just 1 guild member still has incomplete info. Great job!"] = "仅剩 1 名公会成员信息不完整，干得好！"
    GRM_L["No Audit Necessary! Great Work!"] = "无需审计！干得好！"
    GRM_L["GRM Audit Report:"] = "GRM 审计报告:"    -- Appears after the player's first sync that game secssion.
    GRM_L["100% complete. Great work!"] = "100% 完成，干得好！"
    GRM_L["{num}% complete."] = "已完成 {num}%。"
    GRM_L["Only 1 member with incomplete data."] = "仅 1 名成员数据不完整。"    -- singular phrase
    GRM_L["{num} members with incomplete data."] = "{num} 名成员数据不完整。"    -- plural version of it
    GRM_L["Colorize Names in Chat Window to Match Class"] = "在聊天窗口按职业着色玩家名字"
    GRM_L["Only Match Empty Notes"] = "仅匹配空备注"
    -- macro Tool
    GRM_L["Empty Note match: {name}"] = "空备注匹配: {name}"
    GRM_L["Empty Notes"] = "空备注"
    GRM_L["Public"] = "公众"
    GRM_L["Custom"] = "自定义"
    GRM_L["Apply Rules to:"] = "规则应用于:"    -- Macro tool rule (top selection)
    GRM_L["All"] = "全部"    -- As in, apply to everyone.
    GRM_L["Player is an Alt"] = "玩家是小号"
    GRM_L["Player is a Main"] = "玩家是大号"
    GRM_L["This only applies to KNOWN alts. Unconfigured will be excluded."] = "仅适用于已知小号。未配置的将被排除。"
    GRM_L["Main/Alt: {name}"] = "大号/小号: {name}"
    GRM_L["Kick Players at Selected Rank(s) after"] = "在此时间后踢出所选会阶的玩家:"
    GRM_L["Use Cautiously. Applies to all at rank, regardless of being active or inactive."] = "谨慎使用。适用于该会阶的所有成员，无论是否活跃。"
    GRM_L["This will only apply to players with verified promotion dates."] = "仅适用于有已验证升职日期的玩家。"
    GRM_L["Time at Rank: {name}"] = "在职时间: {name}"
    GRM_L["Notify if at Rank for {num} {name}"] = "在当前会阶满 {num} {name} 时通知"    -- "Notify if at Rank for 30 Days" or "Notify if at Rank for 12 Months"
    GRM_L["Player Guild Rep is"] = "玩家公会声望"    -- Ex: "Player Guild Rep is < Honored" or "Player Guild Rep is = Neutral"  -- Dropdown selection options immediately follow this line. If ordering of boxes before the line would be better, please inform me and I can accomadate your localization efforts
    GRM_L["|CFFE6CC7FClick|r to Change Rep"] = "|CFFE6CC7F点击|r更改声望"
    GRM_L["Guild Rep:"] = "公会声望:"
    GRM_L["Guild Rep lower than {name}"] = "公会声望低于 {name}"
    GRM_L["Guild Rep equal to {name}"] = "公会声望等于 {name}"
    GRM_L["Guild Rep higher than {name}"] = "公会声望高于 {name}"
    GRM_L["Rep: {name} - {name2}"] = "声望：{name} - {name2}"
    GRM_L["Custom Log Entry Message"] = "自定义日志条目消息"
    GRM_L["Press ENTER to Save"] = "按回车保存"
    GRM_L["{name} matches {num} macro tool rules. Kick Recommended!"] = "{name} 符合 {num} 条宏工具规则。建议踢出！"
    GRM_L["{name} matches {num} macro tool rule. Kick Recommended!"] = "{name} 符合 {num} 条宏工具规则。建议踢出！"
    -- Classic Only
    GRM_L["Shift Rank Up"] = "上移会阶"
    GRM_L["The Guild Rank \"{name}\" has Shifted up from rank {num} to {custom1}"] = "公会会阶“{name}”已从第 {num} 级上移至第 {custom1} 级"
    GRM_L["The Guild Rank \"{name}\" has Shifted lower from rank {num} to {custom1}"] = "公会会阶“{name}”已从第 {num} 级下移至第 {custom1} 级"
    GRM_L["After shifting the rank up by 1, the window will automatically close"] = "将会阶上移 1 级后，窗口将自动关闭"
    GRM_L["After shifting the down by 1, the window will automatically close"] = "将会阶下移 1 级后，窗口将自动关闭"
    GRM_L["Addon restrictions require manual selection of guild rank"] = "由于插件限制，需要手动选择公会会阶"
    GRM_L["Shift Rank Down"] = "下移会阶"

    -- R1.90
    GRM_L["GRM WARNING!!! FAILURE TO LOAD THIS KEY: {name}\nPLEASE REPORT TO ADDON DEV! THANK YOU!"] = "GRM 警告！！！无法加载此键值：{name}\n请向插件开发者反馈！谢谢！"
    GRM_L["Sync is disabled for {num} seconds after logging in. Please wait {custom1} seconds longer."] = "登录后 {num} 秒内禁用同步。请再等待 {custom1} 秒。"    -- if sync is triggered after logon too soon
    GRM_L["Type '/grm sync' to initiate a one-time sync."] = "输入 '/grm sync' 以发起单次同步。"
    -- Due to language differences on the edit box, this is to explain where to put the edit box. In Englist it will appear: "Auto Trigger Sync [ 30 ] Seconds After Logging On" - Please place the edit box in the appropriate position for your translation.
    GRM_L["Before Auto Trigger"] = "Auto Trigger Sync"
    GRM_L["After Auto Trigger"] = "Seconds After Logging On"
    GRM_L["Report When Other Members Have Outdated Versions"] = "当其他成员版本过旧时报告"

    -- Macro Tool update promote/demote
    -- R1.92
    GRM_L["Inactive"] = "不活跃"
    GRM_L["Promote Player if at Rank for"] = "如果处于该会阶达到以下时间则提升玩家"
    GRM_L["Demote Player if Inactive for"] = "如果不活跃达到以下时间则降级玩家"
    GRM_L["Apply Promotions Regardless of Activity"] = "无论活跃度如何均应用提升"
    GRM_L["Apply Only to Active Players"] = "仅应用于活跃玩家"
    GRM_L["Player is considered inactive if offline for"] = "如果离线达到以下时间则视为不活跃"
    GRM_L["Ignore inactivity if at least one player linked alt is active"] = "如果至少有一个关联小号处于活跃状态，则忽略不活跃"
    GRM_L["Promote to Rank:"] = "提升至会阶："
    GRM_L["Demote to Rank:"] = "降级至会阶："
    GRM_L["Only recommend to Demote if all player linked alts exceed max time"] = "仅当所有关联小号均超过最长时间时才建议降级"
    GRM_L["Unable to promote players to this rank"] = "无法将玩家提升至此会阶"
    GRM_L["Unable to demote players to this rank"] = "无法将玩家降级至此会阶"
    GRM_L["Unable to promote players at this rank."] = "无法提升处于此会阶的玩家。"
    GRM_L["Unable to demote players from this rank."] = "无法降级处于此会阶的玩家。"
    GRM_L["Unable to kick players at this rank"] = "无法踢出处于此会阶的玩家"
    GRM_L["Unable to promote players at this rank to \"{name}\""] = "无法将处于此会阶的玩家提升至“{name}”"
    GRM_L["Unable to demote players at this rank to \"{name}\""] = "无法将处于此会阶的玩家降级至“{name}”"
    GRM_L["Disable chat log spam while using the Macro Tool"] = "使用宏工具时禁用聊天日志刷屏"
    GRM_L["When you are ready to Promote the player, press the Hot-Key {name} 1 time to complete all actions"] = "准备好提升该玩家时，按 1 次热键 {name} 即可完成所有操作"    -- Similar entries demote/promote plura/singular versions
    GRM_L["When you are ready to Demote the player, press the Hot-Key {name} 1 time to complete all actions"] = "准备好降级该玩家时，按 1 次热键 {name} 即可完成所有操作"    -- ''
    GRM_L["When you are ready to Promote the players, press the Hot-Key {name} {num} times to complete all actions"] = "准备好提升这些玩家时，按 {num} 次热键 {name} 即可完成所有操作"    -- ''
    GRM_L["When you are ready to Demote the players, press the Hot-Key {name} {num} times to complete all actions"] = "准备好降级这些玩家时，按 {num} 次热键 {name} 即可完成所有操作"    -- ''

    -- Mouseover tooltip on the macro button on the roster
    GRM_L["Players to Kick:"] = "待踢出玩家："
    GRM_L["Players to Promote:"] = "待提升玩家："
    GRM_L["Players to Demote:"] = "待降级玩家："

    GRM_L["Hello {custom1}"] = "你好 {custom1}"

    -- Consideration for plural/singular
    GRM_L["Player has been at rank for more than {num} Day"] = "玩家在当前会阶已超过 {num} 天"
    GRM_L["Player has been at rank for more than {num} Days"] = "玩家在当前会阶已超过 {num} 天"
    GRM_L["Player has been at rank for more than {num} Month"] = "玩家在当前会阶已超过 {num} 个月"
    GRM_L["Player has been at rank for more than {num} Months"] = "玩家在当前会阶已超过 {num} 个月"

    -- Promote?Demote tooltup updates on the rules
    GRM_L["Time at Rank:"] = "会阶停留时间："
    GRM_L["Destination Rank:"] = "目标会阶："
    GRM_L["# Moves:"] = "变动级数："    -- This is shorthand in American English for "Number of Ranks:" - This is top right on macro tool promote/demote - indicating the number of ranks player needs to be promoted or demoted
    GRM_L["Notify if at current rank for {num} {name}"] = "在当前会阶满 {num} {name} 时通知"

    -- Macro Tool Log reporting
    GRM_L["{name} matches {num} macro tool rules. Promotion Recommended!"] = "{name} 符合 {num} 条宏工具规则。建议提升！"    -- I know, a little redundancy here, but I don't want to go back to the kick rules above and modify for all. Just copy/paste the first sentence for each singular/plural.
    GRM_L["{name} matches {num} macro tool rule. Promotion Recommended!"] = "{name} 符合 {num} 条宏工具规则。建议提升！"
    GRM_L["{name} matches {num} macro tool rules. Demotion Recommended!"] = "{name} 符合 {num} 条宏工具规则。建议降级！"
    GRM_L["{name} matches {num} macro tool rule. Demotion Recommended!"] = "{name} 符合 {num} 条宏工具规则。建议降级！"

    -- 1.921
    -- These are going to be used to cleanup some of the string formatting in the future
    GRM_L["Click"] = "点击"    -- Referencing a mouse click
    GRM_L["Ctrl-Click"] = "Ctrl-点击"    -- Ctrl = Control
    GRM_L["Alt-Click"] = "Alt-点击"
    GRM_L["Shift-Click"] = "Shift-点击"
    GRM_L["Ctrl-Shift-Click"] = "Ctrl-Shift-点击"
    GRM_L["Alt-Shiift-Click"] = "Alt-Shift-点击"
    GRM_L["Right-Click"] = "右键点击"
    GRM_L["Left-Click"] = "左键点击"
    GRM_L["Ctrl-Left-Click"] = "Ctrl-左键点击"

    GRM_L["{custom1} to add player to all 3 macro tool ignore lists"] = "{custom1} 将玩家添加到所有3个宏工具忽略列表"    -- custom1 = "Ctrl-Click"  - it is basically a macro action
    GRM_L["{custom1} to remove player from all 3 macro tool ignore lists"] = "{custom1} 将玩家从所有3个宏工具忽略列表中移除"
    GRM_L["{custom1} to push ignore list settings to {name}'s alts"] = "{custom1} 将忽略列表设置同步到 {name} 的小号"
    GRM_L["Type \"{name} {name2}\" to Bring Up Macro Tool. {custom1} also work."] = "输入“{name} {name2}”打开宏工具。{custom1} 也有效。"    -- This is how it looks in final form in English - "Type "/grm macro" to Bring Up Macro Tool (tool, kick, promote, demote also work)""
    GRM_L["Kick Rules"] = "踢出规则"
    GRM_L["Promote Rules"] = "提升规则"
    GRM_L["Demote Rules"] = "降级规则"
    GRM_L["Macro Rule Ignore Lists"] = "宏规则忽略列表"
    GRM_L["Select categories you wish the player to be ignored"] = "选择您希望忽略该玩家的类别"
    GRM_L["Ignoring"] = "已忽略"
    GRM_L["Monitoring"] = "监控中"
    GRM_L["Macro Rules"] = "宏规则"
    GRM_L["{name}'s alts now share the same macro rule ignore settings."] = "{name} 的小号现在共享相同的宏规则忽略设置。"
    GRM_L["{name} or Press ESC"] = "{name} 或按 ESC"
    GRM_L["Please choose a day between {num} and {custom1}"] = "请在 {num} 到 {custom1} 之间选择天数"    -- Example: "Please choose a day between 1 and 999"
    GRM_L["Reactivate monitoring after {num} days."] = "{num} 天后重新激活监控。"
    GRM_L["Set Days:"] = "设置天数："
    GRM_L["Configured: {custom1}"] = "已配置：{custom1}"
    GRM_L["Time Left: {custom1}"] = "剩余时间：{custom1}"
    GRM_L["{name} is now being monitored by the kick macro rules after being on the ignore list for {num} days."] = "{name} 在忽略列表停留 {num} 天后，现已受踢出宏规则监控。"
    GRM_L["{name} is now being monitored by the promote macro rules after being on the ignore list for {num} days."] = "{name} 在忽略列表停留 {num} 天后，现已受提升宏规则监控。"
    GRM_L["{name} is now being monitored by the demote macro rules after being on the ignore list for {num} days."] = "{name} 在忽略列表停留 {num} 天后，现已受降级宏规则监控。"
    GRM_L["WARNING! Unchecking this setting will reset the timer upon re-enabling."] = "警告！取消勾选此设置将在重新启用时重置计时器。"
    GRM_L["Year"] = "年"
    GRM_L["Years"] = "年"
    GRM_L["This note will appear with the log notification when a player meets this rule's conditions."] = "当玩家满足此规则条件时，此备注将随日志通知一同显示。"
    GRM_L["Due to limitations with macros a player can only move 1 rank at a time."] = "由于宏的限制，玩家一次只能移动 1 个会阶。"
    GRM_L["Disabled at Current Rank"] = "在当前会阶已禁用"

    -- 1.922
    GRM_L["Verifying Macro Changes. One moment."] = "正在验证宏更改，请稍候。"
    GRM_L["Not all macro changes validated. One moment..."] = "并非所有宏更改都已验证，请稍候..."
    GRM_L["Macro rank changes have been validated!"] = "宏会阶更改已验证！"
    GRM_L["Warning! Macro changes were not able to be validated. Please verify expected results before using the macro tool further."] = "警告！无法验证宏更改。请在继续使用宏工具前核实预期结果。"

    -- 1.93
    GRM_L["Customize Color"] = "自定义颜色"
    GRM_L["Officer Only Access"] = "仅限官员访问"    -- Tooltip on the advanced join date tool button
    GRM_L["Player no longer has officer access. Advanced Join Date Tool has been closed."] = "玩家不再拥有官员权限。高级加入日期工具已关闭。"
    GRM_L["{custom1} to open Player Window"] = "{custom1} 打开玩家窗口"
    GRM_L["{custom1} for Additional Options"] = "{custom1} 查看更多选项"

    --1.93
    GRM_L["Unable to notify yourself if you go offline."] = "离线时无法通知自己。"
    GRM_L["{custom1} to sync join date among all alts in grouping."] = "{custom1} 在分组内所有小号间同步加入日期。"
    GRM_L["Total Patch Time:"] = "总修补时间："
    GRM_L["Do you really want to import the join date for the selected player?"] = "确定要导入所选玩家的加入日期吗？"
    GRM_L["Do you really want to import the join date for the {num} selected players?"] = "确定要导入所选 {num} 名玩家的加入日期吗？"
    GRM_L["Do you really want to import the join date for 1 player?"] = "确定要导入 1 名玩家的加入日期吗？"
    GRM_L["Do you really want to import the join date for {num} players?"] = "确定要导入 {num} 名玩家的加入日期吗？"
    GRM_L["Dates to be imported: {num}"] = "待导入日期：{num}"
    GRM_L["{num} join dates have not been imported yet! Do that first!"] = "还有 {num} 个加入日期尚未导入！请先完成导入！"
    GRM_L["1 player's join date has not been imported yet! Do that first!"] = "还有 1 名玩家的加入日期尚未导入！请先完成导入！"
    GRM_L["It is recommended to follow the steps in order"] = "建议按顺序执行步骤"
    GRM_L["It's {name}'s Birthday today!!!"] = "今天是 {name} 的生日！！！"
    GRM_L["Announce if Player's Birthday when they Login."] = "玩家登录时若为生日则进行通告。"
    GRM_L["Happy Birthday, {name}!"] = "生日快乐，{name}！"
    GRM_L["This event has not yet been added to the calender. Are you sure?"] = "此事件尚未添加到日历。确定吗？"
    GRM_L["{num} events have not yet been added to the calendar. Are you sure?"] = "有 {num} 个事件尚未添加到日历。确定吗？"
    GRM_L["There are no events listed here to remove."] = "此处没有可移除的事件。"
    GRM_L["All events have been removed."] = "所有事件已移除。"
    GRM_L["Ignore All Events"] = "忽略所有事件"
    GRM_L["Day:"] = "日："    -- Events window title header on list
    GRM_L["Copy"] = "复制"    -- Macro tool - copying
    GRM_L["There are {num} players in your guild on dead accounts."] = "你的公会中有 {num} 名玩家处于死号状态。"
    GRM_L["There is 1 player in your guild on a dead account."] = "你的公会中有 1 名玩家处于死号状态。"
    GRM_L["Click CONFIRM to review the names, IGNORE to remove this pop-up permanently, or CANCEL to be reminded next session."] = "点击“确认”查看名单，点击“忽略”永久关闭此弹窗，或点击“取消”在下次登录时提醒。"
    GRM_L["Would you like to remove them?"] = "你想移除他们吗？"
    GRM_L["You can re-check in the future by typing '/grm dead'"] = "你以后可以输入 '/grm dead' 重新检查"
    GRM_L["Ignore"] = "忽略"
    GRM_L["Dead Account"] = "死号"
    GRM_L["Kicking {name}'s alts"] = "正在踢出 {name} 的小号"
    GRM_L["Kicking Banned Player"] = "正在踢出被封禁的玩家"

    GRM_L["Open any GRM window: {name}, {name2}, {custom1}, etc."] = "打开任意 GRM 窗口：{name}、{name2}、{custom1} 等。"
    GRM_L["Does a one-time check for dead accounts"] = "执行一次性死号检查"
    GRM_L["Dead player accounts found: {num}"] = "发现死号玩家：{num}"
    GRM_L["Rule Sync Enabled"] = "已启用规则同步"
    GRM_L["Rule Sync Disabled"] = "已禁用规则同步"
    GRM_L["Created By: {name}"] = "创建者：{name}"    -- Macro rule tooltip
    GRM_L["{name}'s Kick Rule {num}"] = "{name} 的踢出规则 {num}"
    GRM_L["{name}'s Promote Rule {num}"] = "{name} 的提升规则 {num}"
    GRM_L["{name}'s Demote Rule {num}"] = "{name} 的降级规则 {num}"
    GRM_L["Kick Rule {num}"] = "踢出规则 {num}"
    GRM_L["Sync: {name}"] = "同步：{name}"
    GRM_L["Macro Rules Sync Result:"] = "宏规则同步结果："
    GRM_L["Kick Rules Added: {num}"] = "已添加踢出规则：{num}"
    GRM_L["Kick Rules Removed: {num}"] = "已移除踢出规则：{num}"
    GRM_L["Promote Rules Added: {num}"] = "已添加提升规则：{num}"
    GRM_L["Promote Rules Removed: {num}"] = "已移除提升规则：{num}"
    GRM_L["Demote Rules Added: {num}"] = "已添加降级规则：{num}"
    GRM_L["Demote Rules Removed: {num}"] = "已移除降级规则：{num}"
    GRM_L["Macro Rule Sync:"] = "宏规则同步："
    GRM_L["Kick Rule \"{name}\" Removed by {name2}"] = "{name2} 移除了踢出规则“{name}”"
    GRM_L["Promote Rule \"{name}\" Removed by {name2}"] = "{name2} 移除了提升规则“{name}”"
    GRM_L["Demote Rule \"{name}\" Removed by {name2}"] = "{name2} 移除了降级规则“{name}”"
    GRM_L["Reject"] = "拒绝"
    GRM_L["Player Search"] = "玩家搜索"
    GRM_L["Search to find a player quicker"] = "搜索以更快找到玩家"

    -- Additonal slash command
    GRM_L["dead"] = "dead"    -- slash command for checking dead names
    GRM_L["deadnames"] = "deadnames"    -- slash command for checking dead names
    GRM_L["TabName"] = "标签名"
    GRM_L["Add unique player GUID to chat window to copy"] = "将唯一玩家 GUID 添加到聊天窗口以便复制"
    GRM_L["Achievement Announce"] = ACHIEVEMENT
    GRM_L["Only Guild Members with GRM installed will see."] = "仅安装了 GRM 的公会成员可见。"

    -- R1.935
    GRM_L["Search"] = "搜索"    -- This is the global string for "Search"

    -- R1.936
    GRM_L["Use '{name} search PlayerName' to also find guild members"] = "使用 '{name} search 玩家名' 也可查找公会成员"
    GRM_L["{custom1} to Copy Name to Chat"] = "{custom1} 复制名字到聊天框"    -- "Shift-Click to Copy Name to Chat" is the default

    -- R1.944
    GRM_L["Promote Player if in Guild for"] = "若入会时间满以下则提升"
    GRM_L["Time in Guild: {name}"] = "入会时间: {name}"
    GRM_L["Time in Guild:"] = "入会时间:"
    GRM_L["Notify if a member for at least {num} {name}"] = "成为成员至少 {num} {name} 时通知"
    GRM_L["Player has been a member for more than {num} Day"] = "玩家成为成员已超过 {num} 天"
    GRM_L["Player has been a member for more than {num} Days"] = "玩家成为成员已超过 {num} 天"
    GRM_L["Player has been a member for more than {num} Month"] = "玩家成为成员已超过 {num} 个月"
    GRM_L["Player has been a member for more than {num} Months"] = "玩家成为成员已超过 {num} 个月"
    GRM_L["Ignore Rule With Text Match"] = "文本匹配时忽略规则"
    GRM_L["This only searches the officer note for the safe tag"] = "仅在官员备注中搜索安全标签"
    GRM_L["Examples of simple tags:"] = "简单标签示例:"
    GRM_L["Do Not Kick"] = "请勿踢出"
    GRM_L["[S]"] = "[安]"    -- While this is just a tag, it is short for the word "Safe"
    GRM_L["Safe"] = "安全"
    GRM_L["Must be an exact match"] = "必须完全匹配"
    GRM_L["No safe tag '{name}' in officer note"] = "官员备注中无安全标签 '{name}'"
    GRM_L["Safe Text Match:"] = "安全文本匹配:"

    -- R1.946
    GRM_L["GRM Tools"] = "GRM 工具"
    GRM_L["Style Choices:"] = "样式选择:"
    GRM_L["Applies only to date format used for note"] = "仅适用于备注中使用的日期格式"

    -- R1.947
    GRM_L["Currently syncing with {name}. Please wait until after sync completes to activate again."] = "正在与 {name} 同步。请等待同步完成后再激活。"
    GRM_L["Be Informed When GRM is out of date."] = "当 GRM 过期时通知我。"
    GRM_L["This only reports to chat once per session."] = "每次登录仅在聊天框提示一次。"
    GRM_L["Player GUID"] = "玩家 GUID"
    GRM_L["Remove Alt-Code Letters From Names"] = "移除名字中的特殊字符"
    GRM_L["Only Show Players Currently Online"] = "仅显示当前在线玩家"
    GRM_L["{name} matches rules for a promotion and is currently online."] = "{name} 符合提升规则且当前在线。"
    GRM_L["{name} matches rules for a demotion and is currently online."] = "{name} 符合降级规则且当前在线。"
    GRM_L["Please choose a valid Month"] = "请选择有效的月份"
    GRM_L["Warcraft was not released until 2004. Please choose a valid year."] = "魔兽世界直到2004年才发布。请选择有效的年份。"

    --R1.953
    GRM_L["{name} has rejoined their original alt group."] = "{name} 已重新加入其原来的小号组。"

    --R1.96
    GRM_L["Not Currentlly Syncing"] = "当前未在同步";
    GRM_L["Sync with {name} Successful"] = "与 {name} 同步成功"
    GRM_L["Sync failed at this point:"] = "同步在此处失败:"
    GRM_L["Sync with {name} next."] = "接下来与 {name} 同步。"
    GRM_L["Sync is Currently Disabled"] = "同步当前已禁用"
    GRM_L["Sync has failed..."] = "同步失败..."
    GRM_L["Start Sync"] = "开始同步"
    GRM_L["Initializing Sync"] = "正在初始化同步"
    GRM_L["Initializing Sync. One Moment..."] = "正在初始化同步，请稍候..."
    GRM_L["No Member is Available to Sync"] = "没有可同步的成员"
    GRM_L["Outgoing Ban Data Restricted"] = "已限制发送封禁数据"
    GRM_L["Incoming Ban Data Restricted"] = "已限制接收封禁数据"
    GRM_L["Sync Ok, but their rank is too low to make changes."] = "同步成功，但对方会阶过低，无法进行更改。"
    GRM_L["Sync Ok, but your rank is too low to sync your changes."] = "同步成功，但你的会阶过低，无法同步你的更改。"
    GRM_L["Their Rank is too Low. All data is restricted."] = "对方会阶过低，所有数据均受限。"
    GRM_L["Your Rank is too Low. Player is restricting all data."] = "你的会阶过低，玩家已限制所有数据。"
    GRM_L["Sync is Currently Disabled. Do you wish to re-enable?"] = "同步当前已禁用。是否重新启用？"
    GRM_L["SYNC DATA"] = "同步数据"    -- AddonUsers Tab in Options
    GRM_L["Players"] = "玩家"
    GRM_L["Bans"] = "封禁"
    GRM_L["Details"] = "详情"
    GRM_L["Syncing all player data."] = "正在同步所有玩家数据。"
    GRM_L["Syncing all data except ban list. Player rank is too low."] = "正在同步除封禁列表外的所有数据。玩家会阶过低。"
    GRM_L["Syncing all data except ban list. Your rank is too low."] = "正在同步除封禁列表外的所有数据。你的会阶过低。"
    GRM_L["Currently Syncing With: {name}"] = "当前正在与 {name} 同步"
    GRM_L["Sync has begun after waiting in queue for {num} seconds"] = "在队列中等待 {num} 秒后已开始同步"
    GRM_L["Not Determined"] = "未确定"    -- Ban List

    --R1.97
    GRM_L["You are added to the sync queue. Position: {num}"] = "你已加入同步队列。当前位置：{num}"
    GRM_L["Sync Queue Position Update: {num}"] = "同步队列位置更新：{num}"
    GRM_L["Data has been transferred from the old Guild \"{name}\""] = "数据已从旧公会“{name}”转移"
    GRM_L["Restore Date:"] = "恢复日期："
    GRM_L["Guild Name"] = "公会名称"
    GRM_L["Sync with {name} complete."] = "与 {name} 的同步已完成。"
    GRM_L["Transfer Data"] = "转移数据"
    GRM_L["Please confirm that \"{name}\" has transferred. Clicking YES will import all guild data."] = "请确认“{name}”已转移。点击“是”将导入所有公会数据。"
    GRM_L["Set Restore Point"] = "设置恢复点"
    GRM_L["Guild Transfer Tool"] = "公会转移工具"
    GRM_L["Transfer Tool Guide"] = "转移工具指南"
    GRM_L["Step-by-Step guide on how to use transfer tool"] = "如何使用转移工具的分步指南"
    GRM_L["Step {num}:"] = "第 {num} 步："    -- Step 1: , Step 2: etc...
    GRM_L["Click \"Set Restore Point\" to the guild you are currently in (remove save first if one already exists)."] = "为你当前所在的公会点击“设置恢复点”（如果已存在存档，请先删除）。"
    GRM_L["Initiate the guild transfer process."] = "开始公会转移流程。"
    GRM_L["Log into the new guild on the new server."] = "登录新服务器上的新公会。"
    GRM_L["Open the Restore Tab again and click \"Transfer Data\" from your old guild. Confirm YES."] = "再次打开“恢复”选项卡，点击旧公会的“转移数据”。点击“是”确认。"
    GRM_L["If you are satisfied with the transfer, remove the restore point to lower memory use next session."] = "如果你对转移结果满意，请删除恢复点以降低下次会话的内存占用。"
    GRM_L["Ensure that the new guild rank structure is identical to the previous (name changes are fine)."] = "请确保新公会的会阶结构与之前完全一致（名称更改不影响）。"
    GRM_L["Transferred from old server"] = "从旧服务器转移"
    GRM_L["{name} has transferred servers and REJOINED the Guild."] = "{name} 已转服并重新加入公会。"
    GRM_L["Group Info Module is Outdated."] = "团队信息模块已过期。"

    -- R1.972
    GRM_L["Show Player Level"] = "显示玩家等级"
    GRM_L["Show Mythic+ Rating"] = "显示史诗钥石评分"
    GRM_L["M+ Rating:"] = "大秘评分:"
    GRM_L["Do Not Show if at Max Level {num}"] = "满级 {num} 时不显示"
    GRM_L["Not on Server"] = "不在本服"
    GRM_L["Mythic+ rating will only appear on members at max level {num}."] = "史诗钥石评分仅显示在满级 {num} 的成员上。"

    -- R1.973
    GRM_L["You are currently syncing. Please wait until sync completes to transfer the guild data."] = "您当前正在同步。请等待同步完成后再转移公会数据。"
    GRM_L["Mythic+ Score"] = "史诗钥石评分"
    GRM_L["Show Member Faction"] = "显示成员阵营"
    GRM_L["Faction"] = "阵营"
    GRM_L["Alts:"] = "小号:"
    GRM_L["Alts"] = "小号"

    -- R1.975
    GRM_L["Export a full list of names in the queue."] = "导出队列中的完整名字列表。"

    -- R1.977
    GRM_L["Guild Roster"] = "公会名单"
    GRM_L["GRM Custom Guild Roster"] = "GRM 自定义公会名单"
    GRM_L["Unable to Promote players at this rank"] = "无法提升此会阶的玩家"
    GRM_L["Unable to Demote players at this rank"] = "无法降级此会阶的玩家"
    GRM_L["No Rank Permission to Kick"] = "没有踢出权限";
    GRM_L["No Rank Permission to Demote"] = "没有降级权限";
    GRM_L["No Rank Permission to Promote"] = "没有提升权限";
    GRM_L["Promote Player to:"] = "提升玩家至:"
    GRM_L["Demote Player to:"] = "降级玩家至:"
    GRM_L["Lvl"] = "等级"
    GRM_L["Opens Custom Guild Roster Window"] = "打开自定义公会名单窗口"
    GRM_L["{custom1} to Open"] = "{custom1} 打开";
    GRM_L["{custom1} to Promote, Demote, or Kick"] = "{custom1} 提升、降级或踢出"
    GRM_L["Whisper"] = "密语"
    GRM_L["{custom1} to Whisper"] = "{custom1} 密语"

    -- R1.979
    GRM_L["{name}'s Settings"] = "{name} 的设置"
    GRM_L["Reserved for GRM Macro Tool Usage. Please do not delete."] = "保留给 GRM 宏工具使用，请勿删除。"
    GRM_L["Verify Promotion Dates"] = "核实晋升日期"
    GRM_L["Verify Join Dates"] = "核实入会日期"
    GRM_L["Number of Unverified Promotion Dates: {num}"] = "未核实的晋升日期数量: {num}"
    GRM_L["Number of Unverified Join Dates: {num}"] = "未核实的入会日期数量: {num}"
    GRM_L["Verify Only if Within Number of Days:"] = "仅核实天数以内的记录:"
    GRM_L["Confirm All"] = "全部确认"
    GRM_L["Only Confirm Dates Within {num} Days"] = "仅确认 {num} 天内的日期"
    GRM_L["1 Promotion Date Has Been Confirmed."] = "已确认 1 个晋升日期。";
    GRM_L["{num} Promotion Dates Have Been Confirmed."] = "已确认 {num} 个晋升日期。"
    GRM_L["1 Join Date Has Been Confirmed."] = "已确认 1 个入会日期。";
    GRM_L["{num} Join Dates Have Been Confirmed."] = "已确认 {num} 个入会日期。"
    GRM_L["Searching Log..."] = "正在搜索日志..."

    -- R1.980
    GRM_L["M+ Score"] = "大秘境评分"
    GRM_L["Search Public, Officer, and Custom Notes"] = "搜索公众、官员和自定义备注"
    GRM_L["Note Search"] = "备注搜索"
    GRM_L["Tips"] = "提示"    -- Options > Help tab - "Tips" as in helpful info.
    GRM_L["Hold the CONTROL key down to scroll 3x the speed"] = "按住 CONTROL 键以 3 倍速滚动"
    GRM_L["Hold the SHIFT key down to scroll instantly to the top or bottom"] = "按住 SHIFT 键直接滚动到顶部或底部"

    -- R1.981
    GRM_L["Player Level Range:"] = "玩家等级范围："

    -- R1.982
    GRM_L["Announce Member Join Date Anniversaries."] = "通告成员入会周年纪念日。"
    GRM_L["Announce Player Birthdates."] = "通告玩家生日。"
    GRM_L["Anniversaries, Birthdays, and Other Events can be viewed."] = "可查看周年纪念日、生日和其他事件。"
    GRM_L["Please confirm the removal of {num} events."] = "请确认移除 {num} 个事件。"
    GRM_L["Show Offline Members"] = "显示离线成员"
    GRM_L["{num}/{custom1} Online"] = "{num}/{custom1} 在线"    -- Format on GRM Roster "10/154 Online"
    GRM_L["Hide Options"] = "隐藏选项"
    GRM_L["Show Options"] = "显示选项"
    GRM_L["Show Mains"] = "显示大号"
    GRM_L["Show Alts"] = "显示小号"
    GRM_L["Show Tag"] = "显示标签"
    GRM_L["Group Alts With Main"] = "小号归入大号分组"    -- Roster Options - grouping alts under the main.
    GRM_L["If enabled, sorting will be based on the Mains"] = "启用后，将按大号进行排序"
    GRM_L["Rows:"] = "行数："    -- Referencing the number of rows on the Guild Roster
    GRM_L["{num} Rows"] = "{num} 行"
    GRM_L["Right-Click to Reset to {num} Rows"] = "右键点击重置为 {num} 行"
    GRM_L["Mythic+ Rating is"] = "史诗钥石评分为"    -- New Macro rule
    GRM_L["Mythic+ Rating:"] = "史诗钥石评分："
    GRM_L["Mythic+ Rating: {num}"] = "史诗钥石评分：{num}"
    GRM_L["Mythic+ Rating greater or equal to {num}"] = "史诗钥石评分大于或等于 {num}"
    GRM_L["Mythic+ Rating equal to {num}"] = "史诗钥石评分等于 {num}"
    GRM_L["Mythic+ Rating less than {num}"] = "史诗钥石评分小于 {num}"

    -- R1.983
    GRM_L["Special Rules that don't fit nicely into the other categories."] = "无法归入其他类别的特殊规则。"
    GRM_L["Special"] = "特殊"    -- Macro Tool tab "Special"
    GRM_L["Special Rules Not Available at Current Rank"] = "当前会阶不可用特殊规则"
    GRM_L["Add Special Rule"] = "添加特殊规则"
    GRM_L["The \"Special\" rules bypass any safe and ignore restrictions."] = "“特殊”规则会绕过所有安全与忽略限制。"
    GRM_L["Unable to promote or demote players within the guild at current rank."] = "当前会阶无法在公会内提升或降级玩家。"
    GRM_L["Special Rule Match:"] = "特殊规则匹配："

    -- R1.984
    GRM_L["Edit Hot Key"] = "编辑快捷键"
    GRM_L["Clear"] = "清除"
    GRM_L["Start Building Your Hot Key"] = "开始设置快捷键"
    GRM_L["Control"] = "Ctrl"
    GRM_L["Shift"] = "Shift"
    GRM_L["Confirm New Hot Key?"] = "确认新快捷键？"
    GRM_L["Please Build Your Hot Key First"] = "请先设置快捷键"
    GRM_L["Control key is already added."] = "已添加 Ctrl 键。"
    GRM_L["Shift key is already added."] = "已添加 Shift 键。"
    GRM_L["Please add only 1 character"] = "请仅添加 1 个字符"
    GRM_L["Hot Key is the Same"] = "快捷键未更改"
    GRM_L["Please add final key"] = "请添加最终按键"
    GRM_L["Final Key"] = "最终按键"
    GRM_L["WARNING! Keybind is already in use for \"{name}\"."] = "警告！按键绑定已被“{name}”使用。"

    -- R1.986
    GRM_L["D"] = "亡"    -- Hardcore mode death tag [D] -- Change to any letter
    GRM_L["Classic Hardcore Mode"] = "经典怀旧服硬核模式"
    GRM_L["Hardcore"] = "硬核"
    GRM_L["Include Date Player Died"] = "包含玩家死亡日期"
    GRM_L["Add Death Indicator Tag to Player Note"] = "在玩家备注中添加死亡标记"
    GRM_L["Hardcore Deaths"] = "硬核死亡记录"
    GRM_L["{name} has died at level {num}."] = "{name} 在 {num} 级时死亡。"
    GRM_L["Player is Still Alive"] = "玩家仍然存活"
    GRM_L["{name} is no longer reported as Dead."] = "{name} 不再被报告为已死亡。"
    GRM_L["The \"{custom1}\" indicates the player is dead."] = "“{custom1}”表示该玩家已死亡。"
    GRM_L["Your rank does not have permission to remove the tag."] = "你的会阶没有权限移除此标记。"
    GRM_L["R.I.P. - {custom1}"] = "安息 - {custom1}"    -- "R.I.P. - 15/09/2023"
    GRM_L["Dead"] = "已死亡"
    GRM_L["Total Deaths Recorded: {num}"] = "已记录死亡总数：{num}"
    GRM_L["Time of Death"] = "死亡时间"
    GRM_L["Sort Deaths:"] = "死亡排序："
    GRM_L["*Max Export is 500 Recorded Deaths at a Time"] = "*每次最多导出 500 条死亡记录"

    -- R1.988
    GRM_L["In-combat. Hiding all GRM windows"] = "战斗中。正在隐藏所有 GRM 窗口"
    GRM_L["Auto-Hide all GRM windows when entering combat."] = "进入战斗时自动隐藏所有 GRM 窗口。"

    -- R1.9902
    GRM_L["Unable to kick or promote or demote players within the guild at current rank."] = "当前会阶无法在公会中踢出、提升或降级玩家。"
    GRM_L["Unable to kick or demote players within the guild at current rank."] = "当前会阶无法在公会中踢出或降级玩家。"
    GRM_L["Unable to kick or promote players within the guild at current rank."] = "当前会阶无法在公会中踢出或提升玩家。"
    GRM_L["Unable to kick players within the guild at current rank."] = "当前会阶无法在公会中踢出玩家。"
    GRM_L["Please Select Special Macro Rule"] = "请选择特殊宏规则"
    GRM_L["Alt Group Rank Sync"] = "小号组会阶同步"
    GRM_L["Repeated Inactivity Monitor"] = "重复不活跃监控"

    -- R1.9904
    GRM_L["If disabled, a one time scan is still done at login or reload."] = "若禁用，仍会在登录或重载界面时进行一次扫描。"

    -- R1.9906
    GRM_L["To access the color wheel, due to a compatibility issue that began in 10.2.5, you will need to reload the UI. Do you wish to reload now?"] = "由于10.2.5版本的兼容性问题，访问调色盘需要重载界面。是否立即重载？"

    -- R1.9907
    GRM_L["Alt Group Rule {num}"] = "小号分组规则 {num}"
    GRM_L["Promote/Demote Alts to Same Rank as Main"] = "将小号提升/降级至与大号相同会阶"
    GRM_L["Promote/Demote Alts to Rank:"] = "将小号提升/降级至会阶："
    GRM_L["Promote Alts to Same Rank as Main"] = "将小号提升至与大号相同会阶"
    GRM_L["Promote Alts to Rank:"] = "将小号提升至会阶："
    GRM_L["Please Choose a Destination Rank for Alts."] = "请选择小号的目标会阶。"
    GRM_L["Apply to Mains at:"] = "适用于以下会阶的大号："
    GRM_L["Only Selected Ranks"] = "仅限选定会阶"
    GRM_L["Ignore if Offline for:"] = "离线超过以下时间则忽略："
    GRM_L["{custom1} to Change."] = "{custom1}更改。"    -- "Click to change"
    GRM_L["Sync Alts to Main:"] = "将小号同步至大号："
    GRM_L["Main's Rank: {name}"] = "大号会阶：{name}"    -- Example: "Main's Rank: Guild Leader"
    GRM_L["Alt's Rank: {name}"] = "小号会阶：{name}"
    GRM_L["Destination Rank: {name}"] = "目标会阶：{name}"
    GRM_L["Up 1 Rank"] = "升1阶"
    GRM_L["Up {num} Ranks"] = "升{num}阶"
    GRM_L["Down 1 Rank"] = "降1阶"
    GRM_L["Down {num} Ranks"] = "降{num}阶"
    GRM_L["Ignore Alt Promotion if Offline for {num} {name}"] = "若离线超过 {num} {name} 则忽略小号提升"
    GRM_L["No Restrictions"] = "无限制"
    GRM_L["Special Rule"] = "特殊规则"
    GRM_L["{num} Players are Ready for {name}."] = "{num} 名玩家已准备好进行{name}。"
    GRM_L["1 Player is Ready for {name}."] = "1 名玩家已准备好进行{name}。"
    GRM_L["Promotion"] = "提升"
    GRM_L["Demotion"] = "降级"
    GRM_L["Disable Demote Option. Only Promote Players"] = "禁用降级选项。仅提升玩家"
    GRM_L["Unable to Move Alts to this Rank"] = "无法将小号移动至此会阶";

    -- R1.9909
    GRM_L["When you are ready to Move the player, press the Hot-Key {name} 1 time to complete all actions"] = "准备好移动玩家时，按快捷键 {name} 1 次以完成所有操作"
    GRM_L["When you are ready to move the players, press the Hot-Key {name} {num} times to complete all actions"] = "准备好移动玩家时，按快捷键 {name} {num} 次以完成所有操作"

    -- R1.99094
    GRM_L["For GRM to log guild member deaths, you will need to join the \"{name}\" channel. Do you wish to join?"] = "为了让 GRM 记录公会成员死亡，你需要加入“{name}”频道。是否加入？"
    GRM_L["You will not be asked this again."] = "不会再询问你。"
    GRM_L["Please note, GRM will now track the deaths behind the scenes. If you wish to see the full server message, you will need to manually enable in the General Chat Settings."] = "请注意，GRM 现在将在后台追踪死亡信息。如果你想查看完整的服务器消息，需要在综合聊天设置中手动开启。"
    GRM_L["Join \"{name}\" Channel to Track Deaths"] = "加入“{name}”频道以追踪死亡"
    GRM_L["HardcoreDeaths"] = "专家死亡"    -- Default Placeholder
    GRM_L["Configuring channel... one moment."] = "正在配置频道... 请稍候。"

    -- R1.9911
    GRM_L["Data collected. Ban list updated."] = "数据已收集。封禁名单已更新。"
    GRM_L["Birthday set for {name} and {num} alt: {custom1}"] = "已为 {name} 和 {num} 个小号设置生日：{custom1}"
    GRM_L["Birthday set for {name} and {num} alts: {custom1}"] = "已为 {name} 和 {num} 个小号设置生日：{custom1}"    -- Plural version
    GRM_L["{name} has set {name2}'s Birthday, and {num} alt: {custom1}"] = "{name} 设置了 {name2} 及 {num} 个小号的生日：{custom1}"
    GRM_L["{name} has set {name2}'s Birthday, and {num} alts: {custom1}"] = "{name} 设置了 {name2} 及 {num} 个小号的生日：{custom1}"
    GRM_L["{name}'s Birthday has been removed."] = "{name} 的生日已被移除。"
    GRM_L["{name}'s alt grouping has had their Birthday removed"] = "{name} 的小号分组的生日已被移除"
    GRM_L["{name} added {name2} to {custom1}'s list of Alts."] = "{name} 将 {name2} 添加到了 {custom1} 的小号列表中。"
    GRM_L["{name} added to {name2}'s list of Alts."] = "{name} 已添加到 {name2} 的小号列表中。"
    GRM_L["{name} has been removed from {name2}'s list of Alts."] = "{name} 已从 {name2} 的小号列表中移除。"
    GRM_L["{name} has updated {name2}'s custom public note"] = "{name} 更新了 {name2} 的自定义公众备注"
    GRM_L["UnBans"] = "解封"
    GRM_L["Ban Edits"] = "封禁编辑"
    GRM_L["Join Dates"] = "入会日期"
    GRM_L["Promo Dates"] = "晋升日期"
    GRM_L["Alts/Mains"] = "大号/小号"
    GRM_L["Custom Notes"] = "自定义备注"
    GRM_L["Birthdays"] = "生日"
    GRM_L["Normalized Realm Names is Acceptable"] = "可使用标准化的服务器名称"
    GRM_L["Example: \'Aerie Peak\' or \'AeriePeak\'"] = "例如：“鹰巢山”或“AeriePeak”"
    GRM_L["Banned Player in Group: {name} - Identify Verified and Ban List Updated"] = "队伍中有被封禁玩家：{name} - 身份已验证，封禁列表已更新"
    GRM_L["{name}'s Profile Succcessfully Updated!"] = "{name} 的个人资料已成功更新！"
    GRM_L["All {name} Region Realms"] = "所有 {name} 地区服务器"
    GRM_L["Important Notice!!!"] = "重要提示！！！"
    GRM_L["Due to the implementation of x-realm guilds, when banning players from servers other than your own, important identification data cannot be obtained. To bypass this limitation, add the ban when still grouped with the player, or while you are targeting them."] = "由于跨服公会的机制，封禁其他服务器的玩家时无法获取重要的身份数据。要绕过此限制，请在与该玩家组队或选中其为目标时添加封禁。"
    GRM_L["This only applies to players who have never been a member of your guild and are not on your personal realm ({name})."] = "这仅适用于从未加入过你公会且不在你所在服务器（{name}）的玩家。"
    GRM_L["Remind Me Next Time"] = "下次提醒我"
    GRM_L["Acknowledge"] = "已知晓"
    GRM_L["Unfortunately, {name} was not able to be identified. You must be grouped or targeting the player to obtain server identification details."] = "遗憾的是，无法识别 {name}。你必须与其组队或选中其为目标以获取服务器身份信息。"
    GRM_L["Enable All"] = "全部启用"
    GRM_L["Disable All"] = "全部禁用"

    --R1.9914
    -- PROFESSION TRACKING DETAILS
    GRM_L["BS"] = "锻造"    -- Blacksmithing
    GRM_L["LW"] = "制皮"    -- Leatherworking
    GRM_L["Alc"] = "炼金"    -- Alchemy
    GRM_L["Herb"] = "草药"    -- Herbalism
    GRM_L["Mine"] = "采矿"    -- Mining
    GRM_L["TL"] = "裁缝"    -- Tailoring
    GRM_L["Eng"] = "工程"    -- Engineering
    GRM_L["Ench"] = "附魔"    -- Enchanting
    GRM_L["Skin"] = "剥皮"    -- Skinning
    GRM_L["JC"] = "珠宝"    -- Jewelcrafting
    GRM_L["Insc"] = "铭文"    -- Inscription
    GRM_L["Classic"] = "经典"
    GRM_L["Classic Era, HC, and SOD"] = "经典旧世、硬核与探索赛季"    -- Classic Era, Hardcore, and Season of Discovery is the acronymns
    GRM_L["Classic Professions"] = "经典旧世专业"
    GRM_L["Auto Set and Update Profession Details to Player Notes"] = "自动设置并更新玩家备注中的专业详情"
    GRM_L["Display Settings"] = "显示设置"
    GRM_L["Format (If same rank):"] = "格式（若同阶）："
    GRM_L["Details will only be added to the note if space is available."] = "仅在有剩余空间时才会将详情添加到备注中。"
    GRM_L["Profession Update Report"] = "专业更新报告"
    GRM_L["Update will only occur once per session to avoid note change spam."] = "每次登录仅更新一次，以避免备注更改刷屏。"
    GRM_L["No Professions Have Changed"] = "没有专业发生变化"
    GRM_L["Total Notes Updated with Profession Details: {num}"] = "已更新专业详情的备注总数：{num}"
    GRM_L["Total Notes not able to update: {num}"] = "无法更新的备注总数：{num}"
    GRM_L["Click to View All Names"] = "点击查看所有名称"
    GRM_L["Report Details to Chat if Professions Updated"] = "若专业已更新则在聊天框报告详情"
    GRM_L["Note too long: Free up {num} characters"] = "备注过长：请腾出 {num} 个字符"
    GRM_L["Click to Continue - {num} Members Remaining"] = "点击继续 - 剩余 {num} 名成员"
    GRM_L["Choose Destination:"] = "选择目标："
    GRM_L["Click to Set\nProfession Details"] = "点击设置专业详情"    --\n is a line break -- It just looks better this way. Remove translation if you can write itm ore concise
    GRM_L["This will add or update available profession details to every member's {name}."] = "这将为每位成员的{name}添加或更新可用的专业详情。"    -- ...every member's public note [officer, [custom ]
    GRM_L["Auto-update will occur once per session, shortly after logging in. You will not need to click this button again."] = "自动更新将在登录后不久执行一次（每次会话一次）。您无需再次点击此按钮。"
    GRM_L["Auto-update is disabled. This will only update your notes a single time"] = "自动更新已禁用。这将仅更新您的备注一次"
    GRM_L["Cancel Auto-Update"] = "取消自动更新"
    GRM_L["Only Available for Officers"] = "仅限官员使用"
    GRM_L["One moment. Processing profession data..."] = "请稍候。正在处理专业数据..."
    GRM_L["Update profession ranks (Classic Era Only)"] = "更新专业等级（仅限经典旧世）"
    GRM_L["Prof"] = "专业"    -- /grm prof SLASH COMMAND -- Make your own slash comm.0and
    GRM_L["Realm Name"] = "服务器名"
    GRM_L["{name} is no longer in the guild"] = "{name} 已不在公会中"
    GRM_L["{custom1} Entry to Open Player Window"] = "{custom1} 条目以打开玩家窗口"

    -- R1.99142
    GRM_L["On higher ranked alt"] = "在更高会阶的小号上"
    GRM_L["{num} player can be kicked by higher ranked alt {name}"] = "{num} 名玩家可被更高会阶的小号 {name} 踢出"
    GRM_L["{num} players can be kicked by higher ranked alt {name}"] = "{num} 名玩家可被更高会阶的小号 {name} 踢出"
    GRM_L["{num} player can be promoted by higher ranked alt {name}"] = "{num} 名玩家可被更高会阶的小号 {name} 提升"
    GRM_L["{num} players can be promoted by higher ranked alt {name}"] = "{num} 名玩家可被更高会阶的小号 {name} 提升"
    GRM_L["{num} player can be demoted by higher ranked alt {name}"] = "{num} 名玩家可被更高会阶的小号 {name} 降级"
    GRM_L["{num} players can be demoted by higher ranked alt {name}"] = "{num} 名玩家可被更高会阶的小号 {name} 降级"
    GRM_L["{num} player is ready to shift ranks by higher ranked alt {name}"] = "{num} 名玩家已准备好由更高会阶的小号 {name} 调整会阶"
    GRM_L["{num} players are ready to shift ranks by higher ranked alt {name}"] = "{num} 名玩家已准备好由更高会阶的小号 {name} 调整会阶"

    -- R1.99152
    GRM_L["Unable to kick these alts:"] = "无法踢出这些小号："

    -- R1.99161
    GRM_L["One Time Notice"] = "一次性通知";
    GRM_L["Blizzard re-introduced the Classic roster, which you currently have enabled. GRM features will be limited. The communities roster will give you access to all of GRM's features."] = "暴雪重新启用了经典公会名单，您当前已开启该选项。GRM 功能将受到限制。使用社区名单将使您能够访问 GRM 的全部功能。";
    GRM_L["Would you like to enable the communities roster?"] = "是否启用社区名单？"
    GRM_L["Communities Roster is now Enabled."] = "社区名单已启用。"

    -- R1.99165
    GRM_L["Player is Already in this Alt Group"] = "玩家已在此小号分组中"

    -- R1.99170
    GRM_L["Unable to invite. You are grouped without privileges."] = "无法邀请。你在队伍中没有权限。"

    -- R1.992
    GRM_L["This will remove the profession details from all player notes: public, officer, and custom."] = "这将从所有玩家备注（公众、官员和自定义）中移除专业详情。"
    GRM_L["Do you wish to continue?"] = "是否继续？"
    GRM_L["Click to Remove All Profession Notes"] = "点击移除所有专业备注"
    GRM_L["{num} notes have had profession details removed."] = "已从 {num} 条备注中移除专业详情。"
    -- Main/Alt Display Settings
    GRM_L["Alt, Main, and Nickname settings"] = "小号、大号和昵称设置"
    GRM_L["Names"] = "名称"    -- Represents the Options "Names" tab
    GRM_L["Main and Alt Formatting"] = "大号与小号格式"
    GRM_L["Show both {name} and {name2} tags in Chat"] = "在聊天中同时显示 {name} 和 {name2} 标签"
    GRM_L["Show Main Name in Chat"] = "在聊天中显示大号名称"
    -- Nickname Settings
    GRM_L["Nicknames"] = "昵称"
    GRM_L["Show Nickname in Chat"] = "在聊天中显示昵称"
    GRM_L["Share Nickname Across All Grouped Alts"] = "在所有分组小号间共享昵称"
    GRM_L["Append My Public Nickname to My Guild Messages"] = "在我的公会消息中附加我的公开昵称"
    GRM_L["Show Nickname instead of Main name"] = "显示昵称而不是大号名称"
    GRM_L["Main name will still show if no nickname has been set"] = "如果未设置昵称，仍将显示大号名称"
    -- Custom Chat Window Settings
    GRM_L["Would you like to recreate this chat window for messages unique to the GRM addon?"] = "是否重新创建此聊天窗口以用于 GRM 插件专属消息？"
    GRM_L["\"{name}\" Custom Chat Window for GRM appears to be missing."] = "GRM 的自定义聊天窗口“{name}”似乎已丢失。"
    GRM_L["The following Custom Chat Windows for GRM appear to be missing:"] = "以下 GRM 自定义聊天窗口似乎已丢失："
    GRM_L["Would you like to recreate these chat windows for messages unique to the GRM addon?"] = "是否重新创建这些聊天窗口以用于 GRM 插件专属消息？"
    GRM_L["Add Channel"] = "添加频道"
    GRM_L["Add Channels"] = "添加频道"
    GRM_L["Set to {name}"] = "设为 {name}"    -- Referencing the default chat channel "Set to General"
    GRM_L["Keep Only {name}"] = "仅保留 {name}"
    GRM_L["GRM will now send all messages to the default \"{name}\" channel"] = "GRM 现在将所有消息发送到默认的“{name}”频道"
    GRM_L["The missing GRM channel has been recreated."] = "丢失的 GRM 频道已重新创建。"
    GRM_L["The {num} missing GRM channels have been recreated"] = "已重新创建 {num} 个丢失的 GRM 频道"
    GRM_L["GRM will now only send messages to the following channels:"] = "GRM 现在仅将消息发送到以下频道："
    GRM_L["Ignore Missing"] = "忽略丢失"
    -- Macro Rule Settings
    GRM_L["Search Public, Officer, and Custom Notes for Safe tag"] = "在公众、官员和自定义备注中搜索安全标签"
    GRM_L["Re-scanning roster for rule match."] = "正在重新扫描名单以匹配规则。"
    -- MISC
    GRM_L["Pending Feature"] = "待定功能"

    -- 1.9926
    GRM_L["Add Message to Note After Demotion"] = "降级后向备注添加消息"
    GRM_L["GRM will append the message to existing note if room."] = "如果有空间，GRM 会将消息追加到现有备注中。"
    GRM_L["However, if there is not enough room, the message will not be added."] = "但是，如果没有足够空间，将不会添加该消息。"
    GRM_L["Enable to forcibly overwrite existing note when not enough room for both."] = "启用后，当空间不足时将强制覆盖现有备注。"
    GRM_L["Force Overwrite"] = "强制覆盖"
    GRM_L["{rank}"] = "{会阶}"
    GRM_L["Add the bracket \'{rank}\' anywhere in message to insert former rank."] = "在消息任意位置添加“{会阶}”即可插入原会阶。"
    GRM_L["Ex: - Rank: {rank}"] = "例：- 会阶：{会阶}"
    GRM_L["Max Length: {num} letters, including rank name"] = "最大长度：{num}个字符（含会阶名称）"

    -- 1.9931
    GRM_L["Warning!"] = "警告！"
    GRM_L["Your guild Log has {num} entries. Warcraft addons are limited in how much data can be stored. GRM provides this warning as a cushion to help ensure this is never broken as it would result in a catastrophic overflow error that will potentially destroy the GRM save file."] = "你的公会日志已有{num}条记录。魔兽插件的存储空间有限，GRM提供此警告以防止超出限制，否则可能导致严重的溢出错误并损坏GRM存档文件。"
    GRM_L["You are currently storing {num} log entries across {custom1} guilds, taking up approximately {custom2}% of the addon's storage capacity."] = "你当前在{custom1}个公会中共存储了{num}条日志记录，约占插件存储容量的{custom2}%。"
    GRM_L["You are currently storing {num} log entries in your guild, taking up approximately {custom1}% of the addon's storage capacity."] = "你当前在公会中存储了{num}条日志记录，约占插件存储容量的{custom1}%。"
    GRM_L["To Cleanup the log, if you wish to keep the data, please go to the export window by typing `/grm export` and copying the log to an external document. Then, on the log page, click on the \'Open Log Tools\' button on the right side."] = "如需清理日志并保留数据，请输入 `/grm export` 打开导出窗口，将日志复制到外部文档。然后前往日志页面，点击右侧的“打开日志工具”按钮。"
    GRM_L["You are at risk for GRM data loss. It is CRITICAL this is handled imediately. Click OK to acknowledge. You will not be warned again."] = "你正面临GRM数据丢失的风险，必须立即处理！点击“确定”确认，之后将不再提醒。"
    GRM_L["You are nearing max GRM storage limit. It is CRITICAL this is handled soon. Click OK to acknowledge."] = "你的GRM存储空间即将达到上限，请尽快处理。点击“确定”确认。"
    GRM_L["Press OK to acknowledge and you will not be reminded again until you are at {num}% capacity."] = "点击“确定”确认，在达到{num}%容量前将不再提醒。"

    -- 1.9933
    GRM_L["Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to Kick will remove {num} player(s) you currently have queued up for rank changes."] = "警告！此工具无法同时执行升/降级与踢出宏。选择要踢出的玩家将移除当前队列中待调整会阶的{num}名玩家。"
    GRM_L["Warning! You cannot combine promotions or demotion with kick macros using this tool. Selecting a player to {custom1} will remove {num} player(s) you currently have qued up to kick."] = "警告！此工具无法同时执行升/降级与踢出宏。选择要{custom1}的玩家将移除当前队列中待踢出的{num}名玩家。"

    -- 1.99342
    GRM_L["Sync is temporarily disabled until the first scan of the guild roster has completed. It has been {num} seconds since logging in."] = "在公会名单首次扫描完成前，同步功能暂时禁用。距离登录已过去{num}秒。"
    GRM_L["Given the unusually long time of {num} seconds and sync is still not availble, GRM may not be loading properly. If you are experiencing any Lua errors, please report then to the official GRM Discord channel."] = "已过去{num}秒仍无法使用同步，GRM可能未正常加载。如遇到任何Lua错误，请前往GRM官方Discord频道反馈。"

    -- 1.99344
    GRM_L["Not in Guild"] = "不在公会中"

    -- 1.99345
    GRM_L["Copy this link to use a web app to Export the contents of your log to a Text, CRV, or JSON file"] = "复制此链接以使用网页应用将日志内容导出为Text、CSV或JSON文件"
    GRM_L["Use Web App"] = "使用网页应用"
    GRM_L["Total Alts"] = "小号总数"
    GRM_L["No Main Set"] = "未设置大号"
    GRM_L["Alts in Group"] = "组内小号"
    GRM_L["Total Alt Groups Over Limit of {num}: {custom1}"] = "超出{num}个上限的小号组总数：{custom1}"
    GRM_L["Limit must be at least 1 or greater."] = "上限必须至少为1。"
    GRM_L["The web app can extract your GRM logs to Text, CSV, or JSON"] = "网页应用可将你的GRM日志提取为Text、CSV或JSON格式"
    GRM_L["Alt Group Limit Audit"] = "小号组上限审查"
    GRM_L["None Found"] = "未找到"
    GRM_L["altlimit"] = "小号上限"    -- Slash command for alt group limit audit (original Eng always works, so feel free to change)

    -- 1.99346
    GRM_L["View Official GRM Website"] = "访问GRM官方网站"
    GRM_L["Want to learn more about GRM, check out the FAQ, changelog, and receive general tips and tricks? Check out the website!"] = "想了解更多关于GRM的信息、查看常见问题、更新日志以及实用技巧吗？快去官网看看吧！"
    GRM_L["Check out the new GRM website"] = "访问全新GRM官网"

    -- 1.99347
    GRM_L["Expansion Change Detected - Updating player server IDs..."] = "检测到资料片变更 - 正在更新玩家服务器ID..."
    GRM_L["Database updated with new server IDs!"] = "数据库已更新为新的服务器ID！"

    -- 1.99372
    GRM_L["No"] = "否"
    GRM_L["Loading..."] = "加载中..."

    -- 1.99373
    GRM_L["Standard"] = "标准"
    GRM_L["Move Anywhere"] = "自由移动"

    -- 1.99374
    GRM_L["Addons are no longer restricted. Continuing GRM initialization now."] = "插件限制已解除，正在继续初始化GRM。"
    GRM_L["Please specify a number limit after the altlimit command."] = "请在altlimit命令后指定一个数量上限。"
    GRM_L["Nickname is too long. Max {num} letters."] = "昵称过长，最多{num}个字符。"
    GRM_L["Invalid Character: \"|\" is not allowed."] = "无效字符：不允许使用“|”。"
    GRM_L["Nicknames cannot contain special symbols like \'{name}\'"] = "昵称不能包含“{name}”等特殊符号"
    GRM_L["Nickname contains invalid hidden characters."] = "昵称包含无效的隐藏字符。"

    -- 1.99383
    GRM_L["Apply to Max Level Only"] = "仅适用于满级"
    GRM_L["Copy this text anywhere into the Guild Info window (preferably the end)."] = "将此文本复制到公会信息窗口的任意位置（建议放在末尾）。"
    GRM_L["Addon currently restricted by the server from reading Guild Info. Please adjust the settings when addon is not restricted to update global controls."] = "插件目前受服务器限制无法读取公会信息。请在插件不受限制时调整设置以更新全局控制。"
    GRM_L["Addon currently restricted by the server from reading Guild Info. Please wait to export the global control text when addon is not restricted."] = "插件目前受服务器限制无法读取公会信息。请等待插件不受限制时再导出全局控制文本。"
    GRM_L["Get Join Date"] = "获取加入日期"
    GRM_L["Copy the Join date to add to your note (Ctrl-C)"] = "复制加入日期以添加到备注 (Ctrl-C)"
    GRM_L["{name}'s Join Date is not yet Established."] = "{name} 的加入日期尚未确定。"
    GRM_L["{name}'s Join Date is NOT VERIFIED. Please verify join date before adding."] = "{name} 的加入日期尚未验证。请在添加前先验证加入日期。"
    GRM_L["FEATURE DISABLED - Addons restricted from editing Public or Officer notes with Midnight 12.0.1 Launch"] = "功能已禁用 - 至暗之夜 12.0.1 上线后插件被限制编辑公众或官员备注"
    GRM_L["Public Note not set"] = "未设置公众备注"
    GRM_L["Officer Note not Set"] = "未设置官员备注"
    GRM_L["API restricted by Blizzard - Public note editing not possible."] = "暴雪限制了 API - 无法编辑公众备注。"
    GRM_L["API restricted by Blizzard - Officer note editing not possible."] = "暴雪限制了 API - 无法编辑官员备注。"
    GRM_L["(Unavailable in Retail)"] = "（正式服不可用）"
    GRM_L["The Global Control string in your guild info needs to be updated. GRM no longer has the ability to do it. Please type /grm and go to the Options and Officer tab to re-obtain a new control text string to manually copy over."] = "您公会信息中的全局控制字符串需要更新。GRM 已无法自动完成此操作。请输入 /grm 并前往“选项”和“官员”标签页重新获取新的控制文本字符串以手动复制。"

    -- 1.99384
    GRM_L["NOTICE - Note Editing Restrictions Active - Unable to Edit"] = "注意 - 备注编辑限制已生效 - 无法编辑"
    GRM_L["Public Note Locations:"] = "公众备注位置："
    GRM_L["Officer Note Locations:"] = "官员备注位置："
    GRM_L["Due to addon limitations, the {num} public or officer notes cannot be edited automatically. You must edit manually."] = "由于插件限制，这 {num} 条公众或官员备注无法自动编辑。您必须手动编辑。"
    GRM_L["Disregard notes located in Public or Officer notes"] = "忽略位于公众备注或官员备注中的备注"

    -- R1.99386
    GRM_L["Unable to Retrieve. Addons currently restricted."] = "无法获取。插件当前受限。"
    GRM_L["The Log is already empty."] = "日志已为空。"
    GRM_L["Only the visible non-filtered log entries will be cleared. Do you really wish to delete the {num} log entries?"] = "仅会清除可见的未过滤日志条目。您确定要删除这 {num} 条日志吗？"
    GRM_L["Only the currently filtered {num} log entries will be removed."] = "仅会移除当前过滤出的 {num} 条日志。"

    -- R1.99387
    GRM_L["Custom note exceeds maximum character limit of {num} and cannot be saved."] = "自定义备注超过了 {num} 个字符的最大限制，无法保存。"
    GRM_L["Appended custom note for {name} exceeds the maximum character limit of {num} and cannot be saved."] = "为 {name} 追加的自定义备注超过了 {num} 个字符的最大限制，无法保存。"

    -- R1.99388
    GRM_L["You must be in a guild to view the Guild Log!"] = "您必须在公会中才能查看公会日志！"
    GRM_L["You must be in a guild to view the Guild Macro Tool!"] = "您必须在公会中才能查看公会宏工具！"

    -- R1.99389
    GRM_L["Analyzing Guild Event Log..."] = "正在分析公会事件日志..."
    GRM_L["Relevant Log Entries Added: {num}"] = "已添加相关日志条目：{num}"

    -- R1.9942
    GRM_L["Profession feature has been globally set to FULLY DISABLED."] = "专业功能已在全局设置为完全禁用。"
    GRM_L["Profession auto-updating has been globally DISABLED."] = "专业自动更新已在全局禁用。"
    GRM_L["Profession auto-updating globally changed to be added to the {name}"] = "专业自动更新已在全局更改为添加到 {name}"
    GRM_L["Your Guild Leadership has globally set the Profession feature to FULLY DISABLED."] = "您的公会管理层已将专业功能全局设置为完全禁用。"
    GRM_L["Your Guild Leadership has globally DISABLED Profession auto-updating."] = "您的公会管理层已全局禁用专业自动更新。"
    GRM_L["Your Guild Leadership has globally set Profession auto-updating to the {name}"] = "您的公会管理层已将专业自动更新全局设置为 {name}"
    GRM_L["Unlock Profession Feature for Use"] = "解锁专业功能以供使用"
    GRM_L["Addons are restricted from writing to the player note or officer note."] = "插件被限制写入玩家备注或官员备注。"
    GRM_L["You do not have permission to edit the public note."] = "你没有权限编辑公众备注。"
    GRM_L["You do not have permission to edit the officer note."] = "你没有权限编辑官员备注。"
    GRM_L["This will remove the profession details from all player Custom Notes. Public and Officer Notes are restricted at your rank."] = "这将从所有玩家的自定义备注中移除专业详情。你的会阶无权修改公众备注和官员备注。"
    GRM_L["This will remove the profession details from all player notes: public, and custom. Officer Notes are restricted at your rank."] = "这将从所有玩家的公众备注和自定义备注中移除专业详情。你的会阶无权修改官员备注。"
    GRM_L["This will remove the profession details from all player notes: officer, and custom. Public Notes are restricted at your rank."] = "这将从所有玩家的官员备注和自定义备注中移除专业详情。你的会阶无权修改公众备注。"

    -- Nickname Update
    -- 1.995
    GRM_L["Player Nicknames must be no longer than {num} letters in length"] = "玩家昵称长度不能超过 {num} 个字符"
    GRM_L["Player Nicknames must be at least {num} characters in length"] = "玩家昵称长度至少需要 {num} 个字符"
    GRM_L["{name} has set a shared nickname ({custom1}) for {name2}'s alt group."] = "{name} 为 {name2} 的小号组设置了共享昵称 ({custom1})。"
    GRM_L["{name} has removed the shared nickname for {name2}'s alt group."] = "{name} 移除了 {name2} 小号组的共享昵称。"
    GRM_L["{name} has removed {name2}'s nickname."] = "{name} 移除了 {name2} 的昵称。"
    GRM_L["{name} has set {name2}'s nickname ({custom1})."] = "{name} 设置了 {name2} 的昵称 ({custom1})。"
    GRM_L["A shared nickname ({name}) has been set to {name2}'s alt group."] = "已为 {name2} 的小号组设置共享昵称 ({name})。"
    GRM_L["A nickname ({name}) has been set to {name2}"] = "已为 {name2} 设置昵称 ({name})"
    GRM_L["{name} has removed the shared nickname from {name2}'s alt group."] = "{name} 从 {name2} 的小号组移除了共享昵称。"
    GRM_L["Invalid Character: \"|\" is not allowed when making a nickname."] = "无效字符：创建昵称时不允许使用 \"|\"。"

    -- Patching update
    GRM_L["The GRM update process has stalled due to a Lua error. Please report this bug to addon author on Discord!"] = "GRM 更新过程因 Lua 错误而停滞。请在 Discord 上向插件作者报告此错误！"

    -- Secret Protection warnings
    GRM_L["Failed to enable Communities Roster. Addons are currently restricted. Please enable in the settings manually or reload to try again."] = "无法启用社区名单。插件当前受限。请在设置中手动启用或重载界面重试。"
    GRM_L["Failed to enable Classic chat class coloring. Addons are currently restricted. Please enable in the settings manually or reload to try again."] = "无法启用经典聊天职业着色。插件当前受限。请在设置中手动启用或重载界面重试。"

    -- Misc
    GRM_L["All GRM Settings have been set to default."] = "所有 GRM 设置已恢复为默认值。"
    GRM_L["Public and Officer notes are addon restricted in current Warcraft version. GRM will only consider Custom Note if empty."] = "在当前魔兽版本中，公众备注和官员备注受插件限制。如果为空，GRM 将仅考虑自定义备注。"
    GRM_L["Due to the elimination of Realms, when banning players who have never been in your guild, some queries for important identification data cannot be currently obtained. This may be a technical hiccup. To bypass, add the ban when still grouped with a player or while you are targeting them."] = "由于取消了服务器限制，在封禁从未加入过公会的玩家时，目前无法获取某些重要识别数据的查询。这可能是技术问题。要绕过此问题，请在与该玩家组队或将其设为目标时添加封禁。"
    GRM_L["This only applies to players who have never been a member of your guild that you wish to ban."] = "这仅适用于你希望封禁的从未成为过公会成员的玩家。"
    GRM_L["Realms are Not Applicable"] = "服务器不适用"
    GRM_L["(Restricted)"] = "(受限)"

    -- NamesTab in options
    GRM_L["Tag Color"] = "标签颜色"
    GRM_L["Nickname Tag Color"] = "昵称标签颜色"
    GRM_L["Name Formatting (No Nickname)"] = "名称格式 (无昵称)"
    GRM_L["Format for Mains"] = "大号格式"
    GRM_L["Format for Alts"] = "小号格式"
    GRM_L["Nickname Formatting"] = "昵称格式"
    GRM_L["Format for Mains with Nicknames"] = "带昵称的大号格式"
    GRM_L["Format for Alts with Nicknames"] = "带昵称的小号格式"
    GRM_L["Format for Unassigned with Nicknames"] = "带昵称的未分配角色格式"
    GRM_L["Nickname"] = "昵称"
    GRM_L["AltName"] = "小号名"
    GRM_L["MainName"] = "大号名"
    GRM_L["ToonName"] = "角色名"
    GRM_L["Main Tag"] = "大号标签"
    GRM_L["Alt Tag"] = "小号标签"
    GRM_L["Nick Tag"] = "昵称标签"
    GRM_L["Tagging Disabled"] = "标签已禁用"
    GRM_L["Nickname Disabled"] = "昵称已禁用"
    GRM_L["Set Nickname"] = "设置昵称"
    GRM_L["Edit Nickname"] = "编辑昵称"
    GRM_L["Share Nickname across all Alts"] = "在所有小号间共享昵称"
    GRM_L["Save"] = "保存"
    GRM_L["Nickname for {name}"] = "{name} 的昵称"
    GRM_L["Unable to Process Nickname. Player no longer found."] = "无法处理昵称。未找到该玩家。"
    GRM_L["No nickname has been set."] = "尚未设置昵称。"
    GRM_L["Nickname sharing for ({name}) has been {name2}."] = "({name}) 的昵称共享已{name2}。"
    GRM_L["{name} has {custom1} nickname sharing for {name2}."] = "{name} 已为 {name2} {custom1}昵称共享。"

    -- General Tab
    GRM_L["{custom1} to Change Default GRM Tab on First Open."] = "{custom1}以更改首次打开时的默认 GRM 标签页。"

    -- Forever labeling
    GRM_L["(Forever)"] = "(永久)"
    GRM_L["Only Available in Classic or Forever"] = "仅在经典怀旧服或永久服可用"

    -- 1.9952
    GRM_L["First:"] = "名："
    GRM_L["Last:"] = "姓："
    GRM_L["Spelling and Case must be EXACT!"] = "拼写和大小写必须完全一致！"
    GRM_L["It is |CFFFF0000CRITICAL|r the player's First and Last name are spelled correctly, with the correct case, or they cannot be tracked correctly."] = "|CFFFF0000极其重要|r：玩家的名和姓必须拼写正确且大小写一致，否则无法正确追踪。"
    GRM_L["Please Enter a Valid Player First Name"] = "请输入有效的玩家名"
    GRM_L["Please Enter a Valid Player Last Name"] = "请输入有效的玩家姓"

    -- 1.9953
    GRM_L["Columns Manager"] = "列管理器"
    GRM_L["Click in order to add columns:"] = "按顺序点击以添加列："
    GRM_L["Reset Default"] = "恢复默认"
    GRM_L["Search by Player Name or Nickname"] = "按玩家名或昵称搜索"
    GRM_L["Drag Left/Right to Reorder  •  Click to Remove"] = "左右拖动排序  •  点击移除"
    GRM_L["Click to Add  •  Or Drag Up into Active Row"] = "点击添加  •  或向上拖入启用栏"
    GRM_L["Clear Optional"] = "清除可选项"
    GRM_L["Active Columns"] = "已启用列"
    GRM_L["Unused Columns"] = "未启用列"
    GRM_L["Only available in Battle for Azeroth or later."] = "仅在《争霸艾泽拉斯》或更高版本可用。"
    GRM_L["Drag Left/Right to reorder this column."] = "左右拖动以重新排列此列。"
    GRM_L["Name column is required and cannot be removed."] = "名称列为必需列，无法移除。"
    GRM_L["Click to remove and move to Unused."] = "点击移除并移至未启用。"
    GRM_L["Click to add to Active Columns (or drag into position above)."] = "点击添加到已启用列（或拖入上方位置）。"
    GRM_L["Only available in Cataclysm or later."] = "仅在《大地的裂变》或更高版本可用。"
    GRM_L["Reputation"] = "声望"

    -- 1.99531
    GRM_L["Addons Restricted while engaged in PVP. GRM initialization will continue when the {name} ends."] = "PVP 战斗中插件受限。GRM 将在{name}结束后继续初始化。"
    GRM_L["Addons Restricted while engaged in a Boss Fight. GRM initialization will continue when the combat ends"] = "首领战中插件受限。GRM 将在战斗结束后继续初始化。"
    GRM_L["Addons Restrcited in current state. Functionality Limited. GRM initialization will continue soon."] = "当前状态下插件受限，功能有限。GRM 将很快继续初始化。"

end


-- Thank you 阿拉贝比-回音山 for you amazing work!
-- 谢谢你，阿拉贝比-回音山，你的工作太棒了！
-- TY @Blendomino for the updated translation work!
