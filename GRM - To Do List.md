## TO DO LIST - Bug Fixes, Improvements, Suggestions

*These are either my own notes, or mostly suggestions and reports from all of you. This does not yet include all reported or suggestions on Discord. There is no guarantee I am going to do all of these eventually, just notes of all things suggested that I am either moderately interested in, or extremely interested in implemented. Some items I have already largely built but are not yet ready for release. Most I have not even begun to brainstorm implementation on. If you would like to add to any of these suggestions or expand on things further, please look at Suggestions in Discord*


**PRIORITY BUILD CHANGES**

** SYNC PROGRESS BAR - Finish getting it working.
    
** SYNC ISSUES SOME STILL FAILING, particularly on manual triger

** HYBRID SCROLLFRAME FOR BAN window...

** ADD MYTHIC+ OPTION for macro tool on promotions/demotions...

* Compress and decompress sync data.

* Lightweight Note tool that does the following:

  -- Auto sets iLvl to the note
  -- [+XX] or [+20] highest M rating
  -- RBG rating
  -- Arena rating

  -- Possibly give option to set it to custom note if you are in GRM, share alt data as well. 


# **BUG FIXES**

* StaticPopup is closing on Escape, which is bad if you die and hit escape. It should only on the GRM one. This seems to be affecting Classic Vanilla only, but I haven't been able to reproduce though I saw it once lol.

* Birthday column on Audit window is not sorting when clicked. Note, when selecting "Include bdays as incomplete," the sorting works fine, interestingly enough.


# **QUALITY OF LIFE**

* UI 2.0 - See Discord for details

* Occasionally GRM's window is appearing when a player is logging out, the ban attachment. That should not happen. This seems to be happening in Classic Vanilla, mainly.

* Make a video guide for the macro tool

* Radio button for the "Send outgoing data" 
    1) Receive changes from selected rank and above, send changes to everyone. >OR<
    2) Receive and Send changes to and from the selected rank and above only.

* Add step in Join Date tool that also syncs all alts to mains.

* Export option to also include rank history

* Custom hotkey for macro tool

* Tips for GRM users, like how shift and control scroll adjust scroll speed

* Add message or tooltip indicating that ranks can only move by 1 at a time due to macro limitations by Blizz.

* Add export tool tips:
 -- EXPORT: 'Excel: Paste data into Excel, Click the Data Tab, Click "Text to Columns" '
- - 'Google Sheets: Paste data into Google Sheets, Click the Data Tab, Click Split "text to columns" ' 

# **CODE IMPROVEMENTS**

* BanList is outdated scrollframe format - just realized it is NOT a hybridscrollframe and needs to be updated. Completely forgot about this.

* Replace GRM.SlimName everywhere with GRM.FormatName -- this is to give player the option choose the full name or the slimname, and only force the full name as needed on the backend database. Right now it is my own discretionary use and should me normalized.

* Leverage LibAlts data if it is found. Not relying on it, just pulling the data to help the alt lists automatically.

* Auto-select proper font when adjusting the language.

* Add slash command /grm search to bring up audit window with search

* When configuring a guild for the first time, scan the log for recent changes and add those to the log immediately.


# **SUGGESTIONS**

* Sync macro rules - Current work in progress. I'd say about 75% complete.

*  Macro tool rule that excludes people from kick/promote/demotion rule if certain tag is included

* Ability to export main names to alts in the notes

* Ability to search public/officer/custom notes

* Macro Tool - Include an option to send a premade message to guild chat in advance of the macro spam with click of a button - like a warning!!!

* "Has No Alts" as a filter option in the Macro Tool

* On export, include the "alt group" identifier so they can be grouped

* Ability to open player window directly from the log by Ctrl-clicking player name. In other words, see if a hyperlink can be added to the fontrstring that becomes clickable.

* In the GRM menu, have a list of mains and when you mouseover it shows all the alts.

* Titan Panel plugin support ahs been requested

* Merge multiple connected guilds to make them appear as 1 guild. This will only be a front end UI, but do it sort of how the cross-guild chat works. -- This will probably be a bit complicated as so much is integrated into actions that will only be doable with that current guild. This is not high priority for me, but I like the suggestion.

* Control-click a player's name in chat to open the guild roster - or just clickable player names

* Ability to have it just show "AltName <A>" in chat, instead of including the main.

* Add an option in there that syncs all allts to their mains join dates, using the Join Date Tool @Vishal

* Ability to just show <M> Main tag ewven if the player has alts.

* - Add an option menu to enable setting a sound effect for important events, e.g.:
- . someone quitting the guild (on their own accord);
- . someone being kicked from the guild (by someone else, not ourselves);
- . someone joining the guild;
- . someone blacklisted joining/rejoining the guild (this one should of course override the sound for someone joining)

* Add option to display a number on the minimap icon indicating the amount of members matching the rules for the macro tool so the tool does not need to be opened by opening guild window. On that note, add helptful tooltip showing /grm macro opens the tool.

* When unbanning - option to unban all known alts as well.

* Auto-add join date based on main's when adding alts

* Show who invited a player in the audit - This is currently stored in log history, but could be stored in the player data.

* Add ability to export ban list

* GRM to throw warning if alt and main are online at the same time as it would indicate error in tagging. Example: $playername is listed as an alt of $mainname, but both are online at the same time

* Ability to remove auto-tagging mains.

* Remind when a player is online and they have incomplete entries:  "GRM: $playername is online. Missing data: Main/Alt"

* Store how a person left the guild, whether it was a kick, left on their own, removed for inactivity.

* Add export option with dropdown to select any guild in database.

* Add export of just a specific player - add search box

* Add nickname feature/pronouns.

* Full name control - GRM.S().useFullName

*  Snapping back on the scrolling. Click the player locks the player, but it continues to allow mouseover scrolling, and snaps back when you scroll off... but lock is released if t he player's name is scrolled off.

* Log to show player's rank when they leave the guild.

* Option to extend the guild info

* Sync ignored lists

* Template of ban responses to choose from as to why they were kicked: Ninja, toxic, etc... and custom

* Promote to guilld master button - but keep the button secure by it being inactive unless player is holding Ctrl-ALT or something like that. Where to put the button?

* Ability to run the join date tool at set interval, or as a pre-selected prioritized order
  - Add join date to note, then fix mismatched dates with note date.

* Add main info to ElvUI player mousover tooltip

* Pre-set messages you can send to guild chat or guild members, with click of a button, or with a slash command
  -- Example: /grm warn Ted

* "WATCH LIST" but not a ban list. Basically, the same thing, but the player is more in a warning status

* Show a history of players you have recently sync'd with

* Ability to import alt/main from the notes based on popular addon formatting

* Add scheduler for MOTD where you can push the MOTD to chat in some set interval. Possibly add a minimum time restriction to 10 minutes minimum??

* Add Last Online to Audit Window

* Expanded audit window where column positions are customizable

* Bring back promotions/demotions to player window, just build it with the macro tool

* Add player level to the chat tag

* Add ability to remove a player that is on the ban list, but still in guild - macro tool

* Expandable and collapsable log groupings when reported on login and lots of items... like collapsable groups with +/- buttons on the side if > 5 in a group, for example

* Colorblind functionality by adding icons/shapes/texture/etc. to differentiate certain things.

* Rank icons can be set and then tagged in chat

* Group Calendar compatibility in Vanilla Classic and TBC Classic


## **SPECIAL EXPANDED MAJOR FEATURES**

**CUSTOM NOTE - TAGGING SYSTEM**

* Discord tag - recommendation - Yes/No if player is in discord.

* Tags - like [RAIDER][PVP] and so on - icons, etc...


**GUILD RECRUITMENT / APPLICATION SYSTEM**

* Ability to include a players "application message" in the log, in the event that they applied via the guild finder interface; of course only if they supplied one.

* Recruitment messages

* Indicator that a player has been invited by WHO but they are offline ... like X players have been invited to the guild but are currently offline or not accepted.

* Notificzation that player1, player2, etc..., who had applied, joined while you were offline.

* X players have requested to join the guild notification

* Possible to auto-refresh the recruitment option, so it stays at 30 days

* Indication that player who is requesting to join is on the ban list, and also when inviting.

* Expanded recruitment rules, like minimum character level, and so on.

* Mouseover application note recall in roster

* When opening the mailbox, IF the player has people requesting to join the guild, popup window to send them a customizable recruitment message.



*Code Notes:
```Lua
-- /dump C_ClubFinder.ReturnClubApplicantList(GRM_G.clubID)
-- C_ClubFinder.ReturnPendingClubApplicantList(GRM_G.clubID)
-- /run for x in pairs (CommunitiesFrame.ApplicantList) do print(x) end
-- /dump CommunitiesFrame.ApplicantList.ApplicantInfoList[1].playerGUID
-- C_ClubFinder.RespondToApplicant(self:GetParent().Info.clubFinderGUID, self:GetParent().Info.playerGUID, shouldInvite, applicantType, self:GetParent().Info.name, forceAccept);
-- /run GRM.CancelPendingInvite ("PlayerTextName")
-- GRM.CancelPendingInvite = function ( playerName )
--     local applicants = C_ClubFinder.ReturnPendingClubApplicantList(GRM_G.gClubID);
--     local isFound = false;

--     for i = 1 , #applicants do
--         if applicants[i].name == playerName then
--             isFound = true;
--             print(i)
--             C_ClubFinder.RespondToApplicant ( applicants[i].clubFinderGUID , applicants[i].playerGUID , false , 1 , applicants[i].name , false )
--             break;
--         end
--     end

--     if not isFound then
--         GRM.Report ( "Player not Found in Pending Applicant List" );
--     end
-- end

-- Events:
-- CLUB FINDER APPLICANT INVITE RECIEVED
-- CLUB FINDER APPLICATIONS UPDATED
-- /dump C_Club.GetMemberInfo ( GRM_G.gClubID , C_Club.GetClubMembers ( GRM_G.gClubID )[67] ).overallDungeonScore
-- C_Club.GetMemberInfo ( GRM_G.gClubID )
-- C_Club.GetMemberInfo ( GRM_G.gClubID , C_Club.GetClubMembers ( GRM_G.gClubID )[1] )
-- C_Club.GetClubMembers ( GRM_G.gClubID )
-- C_Club.GetInvitationCandidates ("" , 5 , nil , true , GRM_G.gClubID )
-- "Guild Finder Posting expires in 30 days" refreshes only if you tab off and come backl

```

**POSSIBLE POWER TOOLS FOR LEADERSHIP**

* Set all of a rank to main

* Possible expanded master tools

* Restore public note from backup


**MACRO TOOL ENHANCEMENT**

* One-time use of macro tool. Click button to open a one-time use tool to arbitrarily search and add any name, with option to add their alts - and have a destination rank for the alts. Click "add" to macro, then it let's you keep adding until macro is full. @glowsome


**GUILD STAT REPORT**

* Report number of toons in each rank

* Number of each class

* Number at max level

* Number with various accomplishments

 -- Stat chage report
* Number of people joined in the last X days

* Number of people who left in the last X days

* Max number of members online at any given time

* Number of players promoted to X ranks

* And many more.


**REMINDER NOTIFICATION FEATURE**

*Possibly standalone addon*

* Slashcommand integration - /remind [Your Message] -- /remind Recheck AH or /remind Recheck AH - 30 min

* Upon typing the slash command, it will then popup a time window of when to remind, unless this was already configured in the slash command text after the " - " 


**GUILD TICKET SYSTEM**

* Using the mailbox, players can send requests for items, or inquiries to guild leadership, like a bank item. When opening the mailbox, the addon will read the request.

* Sync tickets among officers where they can be fulfilled and/or removed


**GUILD MAIL**

* Mass mail guildies a pre-defined message, or based on various filters. Limitations or restrictions? Doesn't this already exist? I'll have to look into it. I am fairly certain there is a 15 outgoing mail per 10 minute restriction, or something like that.


**ADDON IDEA - SAME OR CONNECTED REALM INDICATOR**

* Indicate on player's nameplate that you are connected, thus can trade, and are not just sharded together. People are more willing to help others on their own server.