  ## **VERSION 1.990993 RELEASE - July 31st 2024**

  *Coding Typo overlooked. Very minor fix. Sorry about that!*

## **VERSION 1.990992 RELEASE - July 31st 2024**

***BUG FIXES***

* GRM was crashing on trying to apply patches for some people. This is now resolved and addon should work properly.

* Export was not working, nor was some mouseover issues when trying to display player class in Classic versions of the game. This is now resolved.

* The Mythic rating should once again show in the mouseover of a player's name in retail.


## **VERSION 1.990991 RELEASE - July 30th 2024**

* The demote ability has been added back and properly adapted to the new capabilities of the /demote macro. Blizz has introduced the ability to add the server name to the players in the /demote macro. This has not been the case for 19 years! So, good on Blizzard for finally updating that. I suspect it has to do with the x-realm guild changes in retail, and the incessant efforts of those in the Beta, like @Xulu on discord, in reporting these issues. Thank you!

## **VERSION 1.99099 RELEASE - July 29th 2024**

***COMPATIBILITY UPDATE***

* Surprise "TAINT" changes on the backend for the 11.0 update. These errors are now resolved and you should be able to promote/demote/kick players again.


## **VERSION 1.99098 RELEASE - July 29th 2024**

***COMPATIBILITY UPDATE***

* TWW 11.0 prepatch is here! GRM is fully compatible.

* Classic Era/HC/SOD 1.15.3 compatible to the new surprise UI changes


## **VERSION 1.99097 RELEASE - May 7th 2024**

* Retail 10.2.7 DF Compatibility release

***BUG FIXES***

* For people in very large guilds, on occasion it could time out when checking birthdays in the scan process, if you had it enabled to announce birthdays if they were currently active and logged in. This has been rewritten to be more efficient and not do this.'

* Fixed an issue where when using the Macro tool to demote a player, if you had 2 players in the same guild, but separate realms, it was causing a problem because of the limitation of the `/gdemote` macro. Unfortunately, blizz only enables this macro to work when you remove the server name of the player. Well, in x-realm guilds, this creates an issue. I tested this to see if it would select names in alphabetical order at least, and it was completely inconsistent. I reload, use the macro and boom, it demotes player 1, instead of player 2. I reload again, next time it demotes player 2 instead of player 1. So, I've just now added a little warning that the demotion will not work for players that share the same name and will auto-remove them from the macro. This ONLY applies to the demote slash command as the promote slash command allows adding of the server tag. I really don't know why this limitation exists.


## **VERSION 1.99096 RELEASE - May 2nd 2024**

* Cata Classic Compatibility Released 

*IMPORTANT NOTE - Sync may temporarily cause failure in Classic as Blizz made some unintended changes recently that they said they will be reverting "soon."*

***BUG FIXES***

* Noticed that the keybind setup for the guild window was not working. Basically,  if you have no keybind set to open your guild window, GRM will establish either the "J" or the semicolon symbol to be your keybind, as long as they are not already in use. This sets it to default behavior since 8.0 - I noticed that Blizz did not implement this feature in Cata with the Communities interface so I brought it back in.


## **VERSION 1.99095 RELEASE - April 18th 2024**

***BUG FIXES***

* You can now edit the Demot macro rules again. Before it was erroring if you right-clicked to edit the rule.

* Fixed an issue where GRM Group Info was not the correct version number

* Fixed an issue where the scan for changes could fail.

* In the Advanced Join Date Tool - Mousing over the button for Step 3 will no longer cause an error.

* THe HC Mode in Classic Era had some debugging print statements I accidentally left in. This has been cleaned up.

* Fixed an issue where an alt group would have a missing index due to a player name change where rather than renaming they were removed. This fixes that.


## **VERSION 1.99094 RELEASE - April 11th 2024**

***BUG FIXES***

* Classic Hardcore should now be working again, as well as be compatible with the new way of tracking Hardcore deaths by way of the global hardcore death channel.

* Fixed an issue where there would be a mouseover error on certain players and would cause the audit log to fail to load

* The "Cancel" button should once again work on the Custom Note when editing it. It seems you either had to hit ESC or Confirm the note to get off focus. The cancel button is now working properly.

## **VERSION 1.99093 RELEASE - April 6th 2024**

* Compatibility release for Season of Discovery Season 3

* When using the Special macro tool in any language but English, you should no longer receive a "Missing Key" message.

## **VERSION 1.99092 RELEASE - March 23rd 2024**

* Fixed a bug if a player is using certain macro rule filters that could trigger an error and crash the scan for changes and prevent new updates from being saved.

## **VERSION 1.9909 RELEASE - March 21st 2024**

***BUG FIXES***

* The Special macro rule should now properly display the message indicating how many times you need to hit the macro in total to complete all actions, just like the other rules.

* A lua error was occurring that could cause the frame to lock up momentarily and "run too long" should now be resolved.

***QUALITY OF LIFE***

* Fixed some spacing issues for the Russian translation in the options which text were not wrapping at end of frame.

* Fixed the wording in the GRM options > Officer tab for the '!note notehere` instructions as previously it was maybe not clear.

* Fixed the wording of the restore/transfer tool instructions so as not to be confusing as the previous wording made it somewhat sound as if a 2nd restore point could be made, but there cannot be.


## **VERSION 1.9908 RELEASE - March 20th 2024**

**COMPATIBILITY RELEASE FOR 10.2.6**

***QUALITY OF LIFE***

* Modified the scanning for guild chances process to be a little bit more memory efficient, and for mega guilds, remove possible instances of stutter.


## **VERSION 1.9907 RELEASE - March 17th 2024**

***NEW FEATURE - MACRO TOOL UPDATE - SPECIAL RULES***

> 2 Options:
> * Sync Alts to the same rank as Main
> * Sync Alts in a group to a destination rank, depending on the rank of the Main.


Please note the limitation - you cannot sync alts to the same rank as the guild leader, so the option is not available. However, on choosing a specific rank, this CAN be set for the guild leader.

![Special Rule](https://i.imgur.com/5d1dHlX.png)

Built Macro example - Promotion and Demotion in same macro build

![Built Macro](https://i.imgur.com/0NWhJkz.png)

When you first click the "Add Custom Rule" button to create a special rule, a special selection window appears first. This is ONLY because I have future plans to add additional "special" rules to it. For now, there is just one.

![Special Rule Selection](https://i.imgur.com/ALSzNct.jpeg)

***QUALITY OF LIFE***

* It was reported that players with custom notes that use a lot of line breaks can have REALLY long log entries when someone rejoins, or is kicked/leaves, and it is reported to the log. Rather than show all the line breaks, I now wrap the line breaks into a single line to make it clearer to read. To cleanup your log of this mess you will need to reprocess the text. You can do this easily in 2 ways:

  - Go to /grm > Options Tab > General > Change language to something else, then change it back. This reprocesses all the strings in the log.

  - Or, you can copy this into chat: `/run GRM.ReprocessAllLogEntriesToCurrentLanguage()`

* ReadMe has been updated with updated pictures - and the Curseforge page has been updated, as well as the Github.

* The Macro tool had some minor annoyances I noticed that needed to be cleaned up. For example, it would tell you that you couldn't promote someone to a certain rank if that rank was same rank or higher than you, clearly, but it still let you select that rank. I mean, most people would understand not to, but I just cleaned up some UI stuff so you couldn't select ranks like that, not just be warned.


***BUG FIXES***

* On the custom GRM /roster - if you right-clicked to whisper someone, it was erroring. This has been fixed.

* The Shift-clicking names was not working to put the names into chat. This should now work properly.

* The /grm guid was not working properly. It also should now work. Most probably don't use this, but I have had some ask me how to get your GUID easily, so I just added a simple slash command.

* In the macro tool, if you deleted a rank from your guild and reopened the macro tool to edit or create a rank, then that rank was still showing until the next session. This now will properly and dynamically address rank changes like this without needing to reload.

* Fixed a bug where if you selected the demote rule first, then the promote rule, the option to promote regardless of activity was missing. This should now worked. This ONLY happened if you configured a demote rule first.

* Fixed an issue with the macro tool recommendations reporting to the log where it would report someone as a match right after login, but then the next check it would not. This was due to the fact that certain queries of data from the server after login were not producing accurate results until sufficient time to load after loggging in had been given. The scan now validates the data before offering suggestions to the log. This would annoyingly pop open your log every single session if say, you had a match to kick a toon, but they were the same rank or higher than you so you couldn't. Every session you'd get an identical log entry. This will no longer happen.

* Fixed a lua error that could occur during sync if syncing a very old ban list with player names prior to the date I started storing GUID info (like 4 or 5 years ago maybe)

* Fixed an issue in WOTLK classic where it was tagging the max level cap as 40. This is from a recent update with Season of Discovery and has been resolved.

* Fixed an issue where if a player rejoins the guild, after having already left and rejoined, your note was getting left with an additional "Re" tag in the note, and it would keep adding it over and over and over if someone left and rejoined and so on. This should no longer happen.


## **VERSION 1.9906 RELEASE - March 3rd 2024**

***QUALITY OF LIFE***

* A minor change to the scanning, as per request. Whilst the actually processing is extremely minimal, some people use a lot of addons whilst raiding, or group activities, so to keep GRM's signature fairly low in the background, the scanning for changes will only occur when not in combat. The sync process already will not occur when grouped, but now the scan for the changes will only process when not actually in combat. This will probably go unnoticed as it's an under-the-hood change.

***BUG FIXES***

* Fixed an issue where the Message of the Day on the minmap mouseover was not appearing if your message was less than 65 characters long.

* Should no longer spam you to update GroupInfo each session. Forgot to update the version internally so it was thinking it was updated. Just download the latest updates of both and you'll be fine.

* Fixed an error that was occurring if the scanning for changes triggered whilst player was on a loading screen and if they logged in whilst in combat as it was trying to hide the GRM frames and checking a setting that had not yet been loaded.

* Fixed an issue with the  Color Wheel selection. It seems that there were some recent changes to the whole colorWheel selection that added some compatibility issues with GRM's settings, where if you first selected say, a change to the color of the chat channel text, then, you selected to change something in GRM, them it would overwrite indefinitely for the session. This has now been resolved.


## **VERSION 1.9905 RELEASE - February 26th 2024**

***QUALITY OF LIFE***

* Compatibility with Season of Discovery Season 2 for Classic Era

* The CustomNote has been added to the custom GRM roster (/roster). It is also searchable with the note search above.

* I added the option to choose your color by RGB on the 255 scale. Previously it was only  available by manually selecting the color on the wheel, or by entering the hexcode. I once had this added but due to some frame changes it's been missing for a long time, so I re-added it since I was working on fixing the color frame.

* The guild message of the day text will now "wrap" cleaner on the mouseover for the GRM minimap button. I guess I never noticed how bad it looked since I never utilized the full 250+ character limit. When I was debugging some issues in another person's guild it stretched across like 75% of my screen! lol. So, I wrote a function that can wrap any line to a given length (ish), so I might implement this other places if anyone has any suggestions on mouseovers that could use some nice text wrapping.

* Added support for the ClassColors addon.

* The addon will no longer bug you over system messages being disabled if you use an addon like Fast Guild invite. This is handled more efficient and smarter now, and you can enable/disable system messages at will.

* The Custom GRM roster should now properly update on the fly when adding, removing, or editing notes from the public, officer, or custom notes through the mouseover window.

***BUG FIXES***

* Fixed an issue where the additional filtering to kick a player regardless if they are active or inactive, if they haven't moved from a rank after X amount of time should now properly be clickable. In some cases it could be, but on making a new rule it would be greyed out improperly in certain circumstances.

* In addition, the demote rule was showing this filter option, which didn't make sense. This option has been removed from the demote macro rule window as an option, as well as the settings index to ensure data consistency here of a deprecated variable.

* Fixed an issue when kicking players with the macro tool, if you had checked the box to disable chat spam when using the tool, it was only working on promote/demote spam, but it was still showing the kick system message spam. This is now resolved.

* Fixed an issue where you were unable to select and change the main/alt tag color or the chat log colors. I guess there was a recent change around this I didn't notice, on the back end. This is now resolved.

* Fixed an issue where a Lua error would throw when changing colors on the log as it was checking for the "Hardcore Mode" death announce. even in retail, yet I never loaded those frames in non-hardcore modes. This should now work without any pesky error!

* On leaving a guild, if you had the GRM window open, it would throw some errors as it auto-hid. This should no longer happen.


## **VERSION 1.9904 RELEASE - January 16th, 2024**

***Patch 10.2.5 compatibility Release***

***BUG FIXES***

* Fixed a bug where if you had disabled the "scanning for changes" in the GRM options, where it still would scan for changes one time at login or reload, it was  failing to ever do any scan updates in the future. So, some might have disabled it from scanning for changes ever X seconds and in doing so it gimped GRM completely. This was only recently reported so I wonder if lots of people just never disable the scanning as to why it hasn't been reported for so long lol.

* Fixed a bug that could prevent some people from being able to update the addon and so it would never load. These are getting ironed out. It seems they pop up on occasion! lol

* Fixed an issue where if you were in the middle of a sync, but you had "scanning" of the roster disabled and thus only updated changes upon logging in, it would error.

* Fixed a bug where GRM was not configuring properly the macro tool so it was crashing, and thus the macro tool would not load properly, which would make it seem like you were denied permissions to use it. It was really just because the macro itself was crashing.

* Fixed an issue where GRM was overriding chat class coloring when not in a guild, and ther ewas no way to disable it since you didn't have access to this specific option when not in a guild. It now show only trigger and be able to disable when not in a guild, as intended.

* Fixed a bug where a lua error would trigger causing the ban list not to appear when opening the tab... this only effect classic builds.


## **VERSION 1.9903 RELEASE - December 11th, 2023**

***BUG FIXES***

* Fixed an issue where the addon will not load for someone who has not updated in a while as it crashes on patching. This was due to a small typo where I accidently typo'd and erased a function name without realizing it in the previous update. Whoops!

* Fixed an issue that will force a quicker update scan when someone logs back into the guild. This is useful in HC mode where people are dying often and making a new toon and relogging after deleting the old one. HOWEVER, this does not resolve the issue where a ghost double still exists on the server from Blizz's end. There isn't really a great way to resolve this without adding a lot of extra checks and trying to create some way to ignore the data being received from the server... which seems to self resolve after a few hours anyway. This is just going to resolve some annoyance with it.


## **VERSION 1.9902 RELEASE - December 1st, 2023**

*Significant update is coming, but I didn't get it done yet, so I commented out access to a lot of the changes. I will have the update out soon.*

* Compatibility update for Classic Season of Discovery

## **VERSION 1.9901 RELEASE - November 8th, 2023**

* Slight .toc issue on mainline build for 10.2 compatibility. Updated!

* Accidentally left in a debug print, now removed.

* Macro tool you could edit the rules if you didn't have access, this is now fixed, and was just from some testing I forgot to reset back.

## **VERSION 1.990 RELEASE - November 7th, 2023**

*Compatibility update for 10.2 Dragonflight release*

*Compatibility update for latest Classic Wrath Build*

***BUG FIXES***

* Due to some recent changes by Blizz, on the backend, some certain actions that should not cause "taint" (the error that says your action has been blocked), are causing taint. I have resolved a few of them that could occur where in combat. There are some that are erroneously triggering, however, for many many addons. There is a crowd effort among addon devs right now, but it seems like the general consensus is wait and see if Blizz fixes the error for 10.2 in just a week and we'll see. So, if you are still getting them after this patch, just wait til 10.2 drops and we'll see what happens from there.

* Fixed an issue where GRM could throw errors when entering combat if the addon is enabled when NOT in a guild. Now, the addon should not be doing inCombat status cheecks if you are not in a guild.

* Cleaned up the settings data to ensure no deprecated settings existed. The game now does a validation check. I had found a few save files I was given where people had rolled back to far earlier versions and it caused a lot of issues or added some ghost db entries to the saves. This now  cleans it up at start of your session. Very lightweight pre-check and prevents the endless amount of issues that can result because of this.

* FIxed an issue where a Lua error could happen in the error message to the player indicating the person they were syncing with went offline, effectively stopping to que with the next person who might be in que to sync.

* Fixed an issue where you were not able to add someone to the ban list manually. 

* The player window or the search log should open when you shift-click or ctrl-shift-click names in the chat box. This was not working properly.


## **VERSION 1.989 RELEASE - October 6th, 2023**

***BUG FIXES***

* GRM was causing there to be a closing frame sound in Classic builds when a new person joined the guild. This should no longer happen!

* GRM ctrl-click to open player names was not properly refreshing to the next player if you had already open the mouseover window by doing so. You would have to close and reopen to refresh. It should now properly refresh. This was not an issue in retail build.


## **VERSION 1.988 RELEASE - October 1st, 2023**

***QUALITY OF LIFE***

* GRM will now auto-hide all GRM frames when entering combat. The frames that were hidden will return when combat ends. This is to prevent any issues of GRM getting in the way when every second counts, especially in hardcore mode. This can be completely disabled in the GRM > Options > UI Settings

***BUG FIXES***

* There was an issue with GRM frame eating your keystrokes when entering combat. This should no longer happen, even if you choose to disable the option to auto-hide the frames. That is only an extra feature. 

* Fixed an issue with the join date and rank date hist not storing properly when important data from another person who has been banned.

* Fixed an issue which left the epoch timestamp of a data change incorrectly as a string instead of an int, causing a lua error whentrying to sync.

* Fixed an issue where in some languages you were not able to unban a player if they were still in your guild.

* Fixed an issue where when adding a ban it would say you had a missing "key" whilst referencing a Class name, which clearly didn't make sense.


## **VERSION 1.987 RELEASE - September 27th, 2023**

***BUG FIXES***

* Fixed an issue affecting Classic builds that would cause the GRM mouseover not to properly display

* Fixed an issue where a player joining the guild was not always registering immediately so there would be no data on the player on mouseover.

* Fixed an issue where when GRM modifies a join date, or a rejoin date with the advanced join date tool, or just when someone rejoins the guild, if the custom join tag or rejoin tag were similar, like "J:" and "RJ:", for example, then GRM was parsing the string incorrectly and correcting the date, but adding an extra char on the tail end of the note. It should now properly remove it. Unfortunately, this will not retroactively fix any notes that were modified, but it will prevent it going forward.

*Please note, I am aware of reports of the main designation being lost among alt groups, and in some cases, some alts, during sync. It appears to be affecting the same group over and over. This is something I am working on but it will take some time as I am possibly going to rewrite the whole sync protocol I wrote. I am seeing if it is necessary. Sorry about the hassle but I will have a fix for it soon!*


## **VERSION 1.986 RELEASE - September 14th, 2023**

***NEW FEATURE***

**CLASSIC HARDCORE DEATH TRACKING**

*Please note, this is somewhat limited in its ability in that the server does not provide player information on people who have died while you were offline and will require some crowd sourcing for better results.*

*Please provide additional feedback on where I can add more features or improve this. It is fairly barebones right now in its first form*
 
* Automatically Records the death of a player in your guild when the die, including the time of their death.

* To assist ALL GRM users of who has died, and since some go offline and never quit the guild after  dying, a special "[D]" death tag will be added to the player note, as well as the timestamp of when they died, thus your fellow GRM users, and others, will be indicated that a player has died while you were offline.

* Ability to export the hardcore deaths history, as well as sort by level, class, date, etc...

* The mouseover will have a strong indicator that a player is dead and is still in the guild.

* The GRM Roster will also indicate a player has died in the interface (and the status CAN be removed if someone erroneously or manually adds the death tag to a player note).

![Death Notification](https://i.imgur.com/cOKJlSQ.jpg)

![Death Log Tracking](https://i.imgur.com/q6BaAus.jpg)

![Roster Indication](https://i.imgur.com/YlEU6Qd.jpg)

![Deaths Export](https://i.imgur.com/O0rLBwO.jpg)

***BUG FIXES***

* GRM was erroneously spamming the chat when someone left or was kicked from the guild. Just an error trace I accidentally left in that is now cleaned up.

* GRM could lua error out when joining a guild. It would self-resolve on a reload, but this should no longer be an issue when joining and GRM should properly configure.

* Fixed an OnUpdate Lua error that would cycle if you had the roster window open when you quit a guild.

* Fixed an error where in the Options > UI tab, in Classic builds a player could enable the Mythic+ rating score, which doesn't make sense in classic!

* FIxed a bug that could cause GRM to not be able to load again if a player "rolled back" the addon to a much earlier version.

* Fixed a lua error that could cause sync to fail.

* On occasion, when someone joined the guild, GRM was blocking the reporting of the system message to chat. This happened because GRM was supposed to replace that message. However, the problem is that when someone joins, sometimes the server can take several seconds to report back all of the player details, so while GRM is waiting to build the profile, it was not reporting properly to the chat, coupled with a couple lua errors in there that shouldn't have happened, and boom, the system message would never show. This should no longer happen.

* The old "alts" save Variable on players is removed. This was deprecated a very long time ago and I just realized I still was adding the unused variable to each player profile. It is now removed from the database completely.

* Fixed a lua error where if importing a guild using the transfer tool, some remnants of players in the alt groups got left around. This resolves that.

* Fixed several miscellaneous lua errors that were causing people some issues...

* Fixed an issue causing an error where a player in the DB was not able to be loaded due to a mismatched server on merged realms... This could actually affect things like when a player logs off, or comes online, and so on, it can't match their name


## **VERSION 1.985 RELEASE - September 10th, 2023**

***BUG FIXES***

* Some lua errors causing the scan for changes to fail at times, particularly when logging in. This is a side effect of a previous fix I overlooked and it popped up. This is one error that caused many downstream errors so it will resolve many issues people have reported.

* Apparently GRM has been reporting people that got KICKED as having LEFT the guild, not kicked. This was a 1 line error oversight and easy fix. It didn't apply to people LIVE detected when online, but if they were kicked by an officer whilst you were offline it was not reporting it properly and indicating they had left the guild.

* The position of the GRM custom Roster button was hidden behind the "Groups" tab in Classic builds. I didn't realize there was a groups tab, but I guess that's a thing in Wrath! This has been adjusted to compensate.

## **VERSION 1.984 RELEASE - September 6th, 2023**

***QUALITY OF LIFE***

* **Customizable Macro Hot Key**
  - In addition to the macro key now being able to be changed easily to whatever you want, it does also have protection built-in to warn you if you would be overwriting an existing keybind, and what that keybind is for. So feel free to safely "Confirm" be warned before finalizing.

***BUG FIXES***

* Issue with sync being broken with previous release. Sorry about that! Was rushing to get out the door when I saw servers were up 4 hours early! This should be fixed now.


## **VERSION 1.983 RELEASE - September 5th, 2023**

*Please note - I am working on a few features and I just couldn't get them out in time for 10.1.7, so I am releasing a compatibility update as well as bug fixes, mainly. You will see some remnants of incompleted stuff, like the "Special" tab in the macro tools. Coming soon, but I wanted to make sure compatibility was ready for the latest update.*
aaaa
*Also of note, I am considering ways to support Hardcore on Classic. I have the ability to implement live death tracking, but not if they die when offline. The API appears to be limited right now in Classic Era hardcore. If you have any suggestions on Hardcore support for guilds, I'd be curious to hear. Please report them to the Discord channel!*

**QUALITY OF LIFE**

* You can now sort rank and note/officer note together on the GRM custom roster.

* The "Show offline Members" option and the "Group Alts with Main" now correctly unchecks the grouping alts with main if you wish to only show online members. The reason why is you cannot actually have a grouping of main/alts since technically only 1 will be online anyway, so it can kind of confuse things.

***BUG FIXES***

* Fixed an error that could occur preventing loading/patching of the GRM database for some who had maybe not used the addon in a while, and added some redundancy protection in case a person say, crashed in the middle of patching the addon

* Fixed an issue where syncing the ban lists some meta data on the player being sync'd and then created was not built correctly. This would not be obvious if the player was no longer in the guild, but if they ever rejoined, it would cause some data and UI errors.

* Fixed an issue with the syncing that could cause it to crash in some circumstances.

* Fixed an issue where the note and officer note fonts on the mouseover were not properly changing when reconfiguring the fonts. This could make certain Cyrilic fonts unreadable, for example, or asian character compatible.

* Fixed an issue that could cause verified join dates to be off by 1 day. This does not retroactively fix, but it will not cause issue moving forward. WARNING - Your events will not be entirely sorted in order that have already been reported, but going forward they will sort properly. It would have required a little more effort to retroactively update that, but with zero additional effort and a couple of weeks it will self-fix as the old bdays and anniversaries pass. Forgive me for my laziness on this one lol.

* Fixed a "taint" bug that could occur if a player presses the ESCAPE key to hide a window. This is normally not an issue, but if you were in combat when it occurred, it introduced taint and could block actions. This will no longer happen.

* Fixed an issue where the "Remove all Events" was not actually removing all of the events in the events tab for bdays and anniversaries. This is now resolved.



## **VERSION 1.9821 RELEASE - August 24, 2023**

** CLASSIC BUILD UPDATE ONLY ** - Hardcore Mode compatible

## **VERSION 1.982 RELEASE - August 14, 2023**

***QUALITY OF LIFE***

* Mythic+ Filtering added to the macro tool. You can kick, promote, and demote based on the person's Mythinc+ rating! Just one heads up, since the M+ rating is pulled directly from the server, for players that have not logged on, it still shows their old rating, even from previous expansions. As such, it is highly recommended to use the player level filter (set to max level), asn well as player activity.

![Mythic+ Filtering](https://i.imgur.com/OUXJNkY.jpg)

* The Custom GRM Roster now has many more UI controls.

* You can now choose to track only anniversaries or birthdays, not be forced to track both. You will find this in the normal GRM Options window, under the "Scan" tab. If you disable tracking, they will automatically be removed from the list, but they will also be re-added to your events list if you re-enable.

![Additional filtering](https://i.imgur.com/2OYEXm2.jpg)

* In Classic Era I have expanded the events information to be accessible, so even though there is no in-game Calendar as that was not added until WOTLK, I have at least given access to the information on upcoming birthdays and anniversaries.

if CalendarTrust_CalcUserTrustExplicit(gGroupCalendar_PlayerName) >= 2 then
	/dump gGroupCalendar_GuildDatabase.Events
end

***BUG FIXES***

* Fixed an iossue where if you logged to a non-guilded alt GRM could trigger a lua error. This didn't break anything, but annoying to have your Lua error tracking catch a needless error. This is resolved.

* Fixed an issue where chat could stop working after loading GRM because settings crashed on load. Not good! This is resolved now.
sss 

* Group Info was throwing a couple Lua errors. They should be gone now.

* Fixed an issue where in some cases, if a player logged out in the middle of a sync your chat could be spammed for a second with an error that they were no longer online. This should not happen now.

* Occasionally the mouseover was not working on all names. That shouldn't be a problem anymore. It was particularly noticeable if you moused past the top or bottom names in the window then moused back the mouseover wouldn't work. It now properly refreshed. Also, the window will no longer show for players whos names are not yet registered in the guild, so the very short window when someone joins to when GRM is configuring the name. This should literally be mere seconds, but it was causing some confusion for some as it kept the previous mouseover window open for the previous player.

* Fixed an issue on the GRM Roster where if you sort the officer or player notes, it was not properly considering case and that has been fixed.

* Regarding the public and officer notes search in the GRM Roster, it was removing any white space before/after (trimming). For the note search this makes sense to allow this whitespace so the search will now all you to search something like "  Re" instead of it reverting it to "Re", for example.

* Fixed an issue where if you Control-Clicked a player's name in the GRM roster, or audit, or various GRM frames, it would show the mouseover window, but to ctrl-click another player you'd have to close the window. This should now properly allow subsequent control-clicks without doing this.

* Fixed an issue where if you tried to /grm or /roster, and the addon was in the process of applying a patch, it would still try to open the window before it was fully configured. Clicking the minimap button was ok, but the slash commands would cause an error. This has been fixed.

* In some cases the GRM messages to the player would be lost if the addon was in the middle to being configured, like if it was applying a patch and you tried to open the window, it should give you a message to chat that GRM was still being configured. Well, the message would never print out the text. It should now properly function.

* The tooltip on the left side of the GRM Custom Roster was not clearing if mousing off of the note or officer notes. This should now properly reset or clear on moving off the roster frame.

* Fixed an issue causing GRM to fail to update the log because it was crashing the process of scanning for changes right after login.



## **VERSION 1.981 RELEASE - July 29th 2023**


***QUALITY OF LIFE***

> The GRM Roster window is slowly being improved. 2 Additional "minor" quality of life additions:

* Buttons to the right side of each of the search boxes to just instantly clear the text in there without needing to click inside and delete everything manually. Just clear with the click of the "X" button.

* Columns will now indicate which is selected for sorting, including if you are double sorting, like "Last online" and "Rank" at the same time.

![Column Sorting indication](https://i.imgur.com/YeqcsaQ.jpg)


* Announcing events for anniversaries and birthdays defaulted to 14 days in advance, with a max announcement of 4 weeks, or 28 days in advance. I have expanded that so you can configure it to be notified of these events up to 99 days in advance, and you can add them to the calendar far in advance as a result.

![Announce events much earlier](https://i.imgur.com/uSA47ny.png)

* Added level filtering to the data export, as well as cleaned up the frames a little. I noticed in some of the localization/translations they were too compacted together to cause overlap in some languages. They are now spaced a little better to accomodate.

![Level range filtering added to expot](https://i.imgur.com/QoHPDHS.jpg)

* AddOnSkins file has been updated. Please download it directly from the [AddOnSkins Git Repository](https://github.com/TheGeneticsGuy/Guild_Roster_Manager_AddonSkinsFile), where you can then copy it into the following location: `Interface\Addons\AddOnSkins\Skins\AddOns\Guild_Roster_Manager.lua`

*Please note, I have sent a "pull request" through github to merge my update to the main AddOnSkins release, but it has not yet been approved and sometimes this can take many weeks for the dev to take a look. In the meantime, if you don't want to wait, just follow the above instructions.

***BUG FIXES***

* Fixed some issues with the GRM export. Some of the headers were not being added or removed properly. I ended up rewriting much of the backend of this process to just optimize it a bit, so probably won't be noticeable on the front-end, but if I ever decide to do more with this it will be all the easier.

* Fixed a bug that made it so GRM would not load at all when trying to configure the settings. I typo'd a version check so some edge cases that would refer back were getting nil instead of a string. Oops!

* Fixed some alignment issues with a few frames.


## **VERSION 1.980 RELEASE - July 24th 2023**

***QUALITY OF LIFE***

* GRM's Custom Guild Roster has been expanded. Added M+ Column, Note, and Officer note, as well as the ability to search note and officer notes. More to come soon!

![Expanded GRM Guild Roster](https://i.imgur.com/aVcbX9J.jpg)

* The GRM Guild Roster log sorting is SMARTER! If you are sorting the roster by level, name, or last online, you can carry that sorting over when you sort by rank. In other words, let's say you are sorting by names alphabetically. If you click on the rank column to sort the roster by rank, then each rank will now be properly in order, but also within each rank they will be sorted alphabetically. The same applies to level, and last online. This can be done ascending, or descending. 

* Added a new "Tips" section to the Options > Help tab. Just a couple items for now regarding the CTRL and SHFT modifiers when scrolling, but I will likely expand this eventually. Not quire sure what to do with tips atm.

![Tips Section](https://i.imgur.com/u8hSy2Z.jpg)

* Small note, the "Mass verify" of the unverified join and promotion dates, I have decided to restrict those EXCLUSIVELY to officer use only. I have never had any guild trolls in my own guild, so I have allowed people of most ranks, aside from the starter rank, to be able to make their own changes, like set alts and so on. However, mass verify is a bit of a powerful tool that should really be very limited in use and I don't want to see someone come in and mass-verify a bunch dates that has been in the guild a short while and maybe doesn't sync ever or often. The mass verify button will ONLY appear if you are an officer. This applies to Classic and Retail.

***BUG FIXES***

* Fixed a Lua error if you are searching a log that is fairly massive in size (tens of thousands of entries), if you tried to mousewheel up/down while in the middle of the deep search it could throw a lua error. That will no longer happen. In addition, it should no longer re-search the log when you click on a different tab. Oops!

* Missing key message when opening the macro tool no longer will happen

* The log should no longer automatically open every single game session if you have it set to only open if there are changes.

* Fixed a lua error that could occur for some people immediately after login. It didn't break anything, but it would be annoying to get an indefinite bug every session.

* Fixed a scaling bug that could occur after updating the last time... If yours was broken, it fixes the problem and then resets the scaling, so if you had resized your window you may need to do it again. It does attempt to retain your setting, but in some cases the value was corrupted so had to be reset. 

* "---------CHANGES---------" was showing everytime you opened the log on the first time, even if there was none. This will no longer happen unless there were actual changes on login. In addition, the indication of the start of the "OLD LOG" entries should now properly show.

* Fixed a lua error that occurred when patching GRM from a previous version that was a bit older. The patch would fail thus GRM would never load. This should now be fixed.

* Fixed a lua error that could occur when setting someone as main. It didn't break anything, but it was sort of a UI error where it wouldn't refresh the mouseover window properly after setting as main. This would not always happen, just in some cases.

* Fixed an issue that seemed to only plague Classic Era, where when a person left the guild it would multi-spam. I haven't actually tested this but I found the vulnerability where it could happen so I assume that fixed it. Let me know!


## **VERSION 1.979 RELEASE - July 22nd 2023**

***QUALITY OF LIFE***

* You can now mass verify Unverified Join dates and rank promotion dates. You will notice these as when you mouse over the player, or look at them in the audit you will see a "!!" tag on the date. This can happen from a couple of ways. First, there was a bug recently that left some dates unverified that is resolved in this update. Second, the guild event log on Blizz's server only stores the last 100 events from within the guild. If you are in a highly active guild and 100 events have already occurred since you last logged in, GRM will not know what happened, so GRM will find a change, like someone joined while you were offline, but not be able to verify exactly when. And third, if you are on Classic Era Vanilla WOW, since there is no guild event log yet in the game (it wasn't introduced until patch 2.3), then GRM is unable to query the server for the info.

![Mass Confirm Unverified Dates](https://i.imgur.com/OKr6tJg.jpg)

* The GRM_Tool macro now has a default message stored inside it explaining why the macro exists with a request not to delete it. This is a necessary placeholder macro GRM uses for the GRM Macro Tool. When not in use the text used to be blank, which has caused some confusion why it gets deleted and GRM recreates it next time you login or reload.

* The Mythic+ rating that shows on the player mouseover now scales dozens of colors to match the [RAIDER.IO color scale](https://raiderio-color.wisak.me/). I will be doing more with M+ rating soon, but I need to wrap up a few more things first.

* For people with MASSIVE Logs, the search on the log could end up freezing up your game or it would timeout. This search is very detailed and it normalizes special characters so you can easily find hard to type names, but since that requires a few extra conversion steps the actual search of logs in the tens of thousands of lines can be a little laggy. As such, I added a preventative measure to prevent the lockup. I even tested it on a log > 100,000 lines long just to be sure it works. To prevent any confusion, I also added a new message "Searching Log" for people. This will not even be noticeable to people until you have > 10,000 log entries, and even then it is very minimal, like 1 sec delay per 10k lines.

![Delayed Search to prevent Lockups](https://i.imgur.com/RfLN3GF.jpg)

***BUG FIXES***

* Fixed an issue where for some who updated to 1.978, it would update the settings DB properly, but then faily to load the DB that session. A simple /reload would resolve the issue, but this should no longer occur anymore and the update should be more seemless for most.

* Fixed a small issue where the "FRIEND" tag would show on the players logging on when it shouldn't.

* Removed the old macro that doesn't need to exist anymore that was used to Ctrl-J access the old guild roster, since it is no longer necessary after Blizz removed it. 

* I THINK I added a fix for the issue with GRM failing to auto-verify the dates when doing a scan of the log. With that being said, be aware that the built-in guild log only shows the last 100 events in the guild, be it invites, promotes, demotions, joins, kicks, leaves. If you are in a highly active guild and you have been offline for a longer time, maybe even just a whole day in one of these mega guilds, 100 events may have already occurred so GRM is unable to verify the exact date say someone joined, but GRM can determine someone joined. With that being said, GRM should show the promotion dates as verified now consistently if it can find them.

* Mythic+ rating was not showing the correct number for some people. Be warned, this is sometimes an outdated number as if a player is inactive and hasn't logged in in a long time, it may still show a previous season's rating. Unfortunately this info is pulled directly from Warcraft's servers. GRM should only now reflect what the servers give us.

* Fixed an issue that plagued non-English clients saying missing key.


## **VERSION 1.978 RELEASE - July 11th, 2023**

* Rebuilt the addon settings DB as some were reporting the macros were disappearing at times. The settings have been rebuilt and are more robust now and a bit leaner in the database as well. They will exist as a single entry per guild. However, if you choose to set the settings to character specific, it will create a new entry for just that player as well. If you uncheck the box to remove them from being character specific, the player will be returned to the guild-wide settings. These cannot overwrite each other, which was actually what was happening... it was a logic flaw when swapping alts and then trying to sync the save data. There is no reason to sync data between alts now since the DB will only have 1 instance of the settings, which obviously makes more sense. This is a VERY old legacy format of the DB that had a bunch of spaghetti code that just needed to finally be fixed.

* Fixed an issue where the game wouldn't load properly for some who hadn't updated in a while.

* The name should now be class colorized on the right click dropdown selection on the custom GRM roster.

* Fixed an issue where if you were NOT in a guild, created a new toon, some keybinds could be lost because it was crashing as GRM was trying to set the guild window keybind, which doesn't make sense to do if not in a guild. This shouldn't happen anymore.

* Fixed an issue where the new GRM roster player search wasn't working if you used capital or special letters. The search should now work properly.


## **VERSION 1.977 RELEASE - May 7th, 2023**

***NEW FEATURE***

*Due to the changes in 10.1 and the removal of the old guild roster by Blizzard, we are now no longer able to type `/groster` to bring it up! Given that the Communities window that guilds now use, introduced in BFA 8.0, does not have the ability to filter by "Last Online" I think we can all agree that this is a HUGE problem in regards to guild management, especially those of you who are in rather large guilds where scrolling is going to be a HUGE hassle. As a result, I have introduced a new feature. GRM now has its own custom guild roster. It is fairly limited right now, as I wanted to get this out ASAP for the sake of all our our sanity, but I will be able to expand on it further.*

![New Custom GRM Roster](https://i.imgur.com/xKGzYth.jpg) 

You can access this roster by clicking the new GRM button on your Communities window. I have also added it to the social "FriendsFrame" in Classic Era and Wrath.

**MAIN FEATURES**

* Sort the roster by Last Online - this is a bigger deal in retail, for now.

* Right click any player to promote, demote, or kick from the guild, if it applies, and you have the rank permissions to do so. This will open the macro tool and all you will need to do is press your hotkey to continue.

* Hold the control key down when mousewheel scrolling for triple speed, or shift key to jump to top or bottom instantly (this also works on any other GRM scroll frame ).

* Search a player name easily.

![Button Added to Guild window](https://i.imgur.com/E1MBeb5.jpg)

* The `/roster` command will now open the NEW custom GRM roster window. You also can create your own localized custom slashcommand in your languages locale file. Just set it to `GRM.L["/YYYY"] = "/YourCommand"`

[Roster Demo](https://imgur.com/3qboDU9)

* Promote and Demote demo

[Promote and Demote Easily](https://imgur.com/wmG1DIw)


***BUG FIXES***

* Fixed a lua error if clicking the "X" close button on the mouseover window.

* Fixed an issue that could cause the GRM patching process to hang at loading...

* Fixed a hybridScrollFrame bug on the macro tool where the name class coloring could sometimes get messed up when scrolling up and down on the names

* Fixed a bug that could occur if you click the "Guild Log" button on the roster too quickly after logging in and GRM wasn't fully up dated yet.


## **VERSION 1.976 RELEASE - May 2nd, 2023**

**10.1 Compatibility Update!!**

***Important note for 10.1 Change -- Loss of a staple feature due to UI Changes by Blizz***

> Many of you are aware that in 10.1 Blizz has removed the old roster. Right now, there is the communities window that was introduced in 8.0 BFA. This replaced the old guild roster. However, the old roster you could still access just by typing `/groster` or by typing `Ctrl-J` on your keyboard, as I had GRM configured that way. Well, Blizz has officially removed this old guild roster window and it no longer exists in 10.1 -- this creates a problem for GRM.

> A staple feature is the ability to  Ctrl-click players' names all through the addon and it will auto-bring up their player window, with the built-in side window where you can promote/demote,kick a player. Well, by Blizzard removing that old frame, being forced to use the CommunitiesFrame means this feature can no longer be used. Blizzard has the communitiesFrame so locked down that any action I do to try to auto-find the person in the guild, or even open that side window, introduces "taint" into the game, and thus all subsequent acctions of promote/demote/etc... will be blocked until you reload. Taint from an addon is just not acceptable. Just be aware that as a result of this change, it will now be harder for you to promote/demote as you are once again, forced to scroll to their position in the roster to do any action. 

> The compromise is GRM will still bring up it's own window you can look at and work with, but that side details frame you will have to manually scroll to.


***BUG FIXES***

* Fixed sort of an edge case issue that could result in a macro rule getting purged because the data got corrupted. You will know if this happened to you as all other GRM addon data was fine, except you were missing your macro rule(s) only.

* Fixed an issue that could arise in the name of a player joining the guild and GRm capturing an empty text string only.

* Fixed an issue where a live kick detection was throwing a lua error.

* Fixed an issue where a join detection could end up having a missing name with the GUID call to server. GRM will now look for that and recall as needed. For some reason some reason some calls using `GetPlayerInfoByGUID ( GUID )` were returning "nil" on the first 1 or 2, but after that they were correctly returning the player data.

* The Check-all button on the `/grm export` member details window should no longer auto-check the button to replace alt-code chars from people's names.

* In addition, the Main/alt radial buttons for filtering on who to export should now behave properly. You could uncheck both radial buttons by repeat clicking. Now, one should always be marked as selected.

* In some cases GRM wasn't correctly picking up that someone joined the guild as it was rushing through the scan before the guild event log updated, thus GRM couldn't decipher who did the invite to the guild.


## **VERSION 1.975 RELEASE - APRIL 30th, 2023**

**QUALITY OF LIFE**

* You can now export the qued list from the macro tool, if you wish.


**BUG FIXES**

* Fixed an issue with some people who were not able to login to the game due to a patching error that occurred on some backend updates. Should affect minimal people only, but that is now resolved.

* Fixed an issue where join/leave/quit was not reporting to the chat window properly in Classic. It should now properly update and report when someone joins or gets kicked from the guild.

* Fixed an issue where after a sync, if you were stuck waiting in a que to sync, even though it completed the sync, you were never informed. No errors, sync worked, it just failed to trigger the message. This only affected people in guilds where multiple were syncing at same time.

## **VERSION 1.974 RELEASE - APRIL 30th, 2023**

* BUG fix that prevented some people from being able to update. Oops!

* Fixed an error that only affected *Classic Era* where Deathknight class was accidentally dropped in the ban list and was throwing errors since clearly that doesn't exist yet in that build.

* The "Disabled in Classic" text should no longer overlap on the `/grm export` tool for members/former members.

* The showing of the member faction option should now properly be check'd/set as true by default unless you are in any previous expansion prior to DF. This is in preparation of cross-faction guilds.


## **VERSION 1.973 RELEASE - APRIL 29th, 2023**

**QUALITY OF LIFE**

![Macro Tool - kick sorting](https://i.imgur.com/R8BQuIm.jpg)

* The Macro tool will now group all of the alts of a main underneath it if there are any toons in an alt group being kicked. It will only do this if you have a main designated. If you have an alt group with no main designated it will not do this.

![Macro Tool tooltip with alts](https://i.imgur.com/TORzDCq.jpg)

* The macro tooltip has been updated as well to show all of the player's alts still in the guild as often it is the case that you are kicking one toon, not the whole group, so it might be good for taking notes of that on occasion. Thank you @Poisonenvy for suggestions on these!

* The Macro tool had a slight annoyance in that when setting and changing some of the values of the rules, like the level range, you needed to hit ENTER or tab off them to lose focus on the editbox for the values to be saved. If you just confirmed the rule edit, it would not save the change. This will no longer be an issue going forward as the kick, promote, and demote rule windows will update properly without needing to hit ENTER when making a change. Confirming at the bottom to save the update is all that is necessary.

* Mythic+ Score can now be exported.

* Player faction has been added and will appear on the mouseover, enabled by default in retail, though turned off in classic builds since redundant.

* Player faction has been added to export list as well.

* On transfering a guild, using the transfer tool, it will now import all of your officer and public notes to the new guild. This is necessary for people that did not use the "Follow your guild" transfer option.

* In addition, on importing, it will no longer process it if in the middle of a sync with another player.


***BUG FIXES***

* Fixed a bug that affected CLASSIC ERA only, where if someone joined or left the guild it would mass spam it.

* Fixed an issue where you were getting some incorrect join/leave/promo/demote reporting to the log with the recent scanning update changes. I thought this was resolved in last build but I overlooked something. Should be good now.

* Fixed an issue where there was a missing localization key, or type, if you did `/grm help`

* Fixed an issue where the scan for changes would fail and not report to the log.

* Fixed some Lua errors that occurred preventing setting the join date.

* Fixed an issue that would cause GRM not to finish patching and fail.

* Fixed an issue where sorting the macro rules up and down could cause an error and not show properly until you refreshed.

* when opening the macro tool window it was transparent unless you dragged the window. It should now properly load the background translucent texture when opening the first time.

* Fixed an issue if you typed `/grm reset or /grm center` that the mouseover window would shrink really small rather than go back to default size. Oops! This is now resolved. It would self-fix between sessions, but now it is a permanent fix.

* Fixed a bug where the "Time in:" on the zone, on the mouseover window, was overlapping the "Note" wording.

* The Export Log feature the delimiter was not showing on the final line. This is necessary for certain parsing programs. It now should properly show the delimiter of your choice.

* Fixed an issue with the macro tool where if you checked the box to disable chat spam when using the macro tool, it would ALSO disable the chat spam indefinitely as well until you unchecked that, even if not using the tool. Whoops!

* Fixed an issue where if someone else is using the macro in your guild, you were silencing the kick messages from appearing.

* Sort of an edge case, but in some circumstances your settings could get wiped/reset on a player, then get sync'd to your alts. This shouldn't happen now. Sorry about that one!



## **VERSION 1.972 RELEASE - APRIL 20th, 2023**

**NEW FEATURE - Guild Transfer - Preservation of Data**

![Easier Guild Transfer - Keep your GRM Data!](https://i.imgur.com/GdtWI1z.jpg)

* The Guild Backups window has been rebuilt. First, the "backups" was a bit misleading and I think confused some people. They were not a "true" backup of the addon data since WOW addons do not have write to file access to say, Windows. It did however provide a restore point if you had maybe an officer go rogue and mess up all your data. I don't want to confuse anyone further so I have rebuilt this feature more as a tool to preserve your guild's GRM data if you decide to transfer servers. This will also clear a lot of the overall GRM memory usage that was storing a copy of all GRM data mostly needlessly to now only be used when transferring guilds.

> STEP BY STEP GUIDE FOR USE: 
  * STEP 1: Login to the guild you are planning on transferring BEFORE you transfer.
  * STEP 2: Open the GRM window *(/grm)* > Click Options Tab > Click Restore Tab
  * STEP 3: Click "Set Restore Point" to the guild you are currently in (remove the old if necessary)
  * STEP 4: Initiate the guild transfer process.
  * STEP 5: Log into the new guild on the new server.
  * STEP 6: Ensure that the new guild rank structure is identical to the previous (name changes are fine), otherwise it can only "guess" a player was promoted/demoted if the tier structure has been changed.
  * STEP 7: Open the Restore Tab again and click "Transfer Data" from your old guild. Confirm YES.
  * STEP 8: If you are satisfied with the transfer, remove the restore point to lower your memory usage next session.
  * **NOTE:**
    
  -- It is recommended to WAIT to transfer and import the data to the guild until the majority of your members have also transferred, otherwise they will be designated as having left the guild since they are not found. Also, please be aware that the server GUID tag of each player changes on a guild transfer, so if your guild members change their names on the transfer, GRM will be unable to detect this and count them only has new members once they transfer. GRM will note them as a returning member who transferred, however, if they rejoin after the fact and are protected, but it can only do this if their name is still the same (I do check a few additional metadata points to verify other than name as then any person could change name to old member and join).

  -- Also, BAN DATA IS NOW REDUNDANT. The ban data will be transferred, but because you are on a new server, the GUIDs will no longer match, so even if they changed servers and tried to join your guild, GRM will be unable to flag them if they have changed their names. While GRM will not automatically purge your old and now redundant ban list, I do recommend going into it and doing it yourself.


***QUALITY OF LIFE***

* Scaling corner drag has been added to the major frames, like the macro tool, the core /GRM frame, export window, etc... This is something I have wanted to implement for a while, but the logic of wrapping my head around "Drag-to-Scale" was sort of wonky as it required me to kind of hijack the "drag-to-size" ability, which doesn't really help GRM. I wanted the ability to quickly scale larger or smaller but keep frame sizing proportions consistent. It is now implemented. Just right-click to reset your scaling, or type /grm reset to manually reset ALL frames (this also re-centers your frames you have dragged). 50% to 150% is the acceptable scaling range.

![Window Scaling Example](https://i.imgur.com/rGoKvRG.gif)

* Added the ability to show Mythic+ Rating on the player mouseover window. I should note, that there is a flaw in the built-in guild roster in that if someone logs off and doesn't log back in, it only shows their M+ rating from when they last logged off. If this was say, over a year ago, it's just not accurate. So, GRM will ignore an outdated M+ rating on the mouseover and ONLY show the current rating for the current season, which I was able to deduce by just checking if the last time they logged in was AFTER the start of the current season. NOTE - THIS ONLY SHOWS WHEN A PLAYER IS MAX LEVEL.

!["Enable or Disable showing Mythic Rating"](https://i.imgur.com/DYCA2cm.gif)


* You will notice that the GRM scanning for changes and ackownledgment of things that change, like notes edited, or anything, will be far more responsive and quick. If you were to try a /grm scan, you will notice how quickly it makes it through the process now compared to before. The entire scanning logic has been rewritten. A lot of it was very old legacy code from when I was just tinkering with the idea of GRM, so it really could have used a revisit for a long time now. GRM should feel a bit more responsive now as a result. The code is also a LOT leaner.

* GRM will now auto-import, from the Blizzard servers, the date that you personally joined the guild. This will apply ONLY to retail Warcraft, as the data is tied to "communities" launched in 8.0 and the server provides no information prior to communities. You cannot pull this information from others in your guild, as the server will only provide your own information. There is also a limitation that if you were in the guild prior to July 7, 2018, 8.0 BFA patch day, then it cannot provide an accurate date you joined the guild, unfortunately. I had mostly ignored this feature since almost everyone was basically grandfathered into communities from their current guilds, but now that nearly 5 years has past, I will not import this data automatically. You will need to login to each of your alts for it to work. If you already have a date set, then GRM will ignore automation of this process. It is only for new toons you make going forward, or ones that have not yet been configured.

* 10.1 is going to be a fairly significant update due to the ability to have cross-faction guilds. I had my data storage tree separated by factions. This is forcing me to rebuild the database to remove faction separation since that is a bit redundant. Not hard, but we are talking about literally thousands of points of data. I wish it were as simple as mass-eliminating "editing all" but it isn't. Just to prevent any error, I do need to look at each line of code it affects and ensure it's not broken after I convert the DB. This is simple, but it will take some time. DF has had so so SOOO many changes it is just a huge time-sink.

* If you logged in and players had left or were kicked, it was spamming your chat window. These should ONLY appear in the log now after immediately logging in.

  ***BUG FIXES***

* Sync message on the que was not properly localized so would through a chat message error.

* Fixed a long-time bug that could cause erroneous reporting when player joined or left the guild, promoted or demoted. Basically, if you removed someone from the guild, for some people, and in some cases, it would report them as having rejoined the guild moments later, then it would FINALLY, some time later, correcelt re-report that they were no longer in the guild. This is just one example. It was due to an overlapping scan when something "live" happened. This has been rewritten and fixed.

* Fixed an error if you did a search, or tried to add a person to friends list, if the system message triggered that the person was no online, it would crash the sync and force it to end. Sort of a weird bug, but I had something gated wrong and it is now resolved and shouldn't cause sync to stop and fail mid-sync.

* Fixed an issue where on a merged realm the incorrect serverName was being tagged to a player that logged in so it was failing to add their chat tags, like the main tag, to their name. This ONLY affected some people on a different realm than you, for people on merged realms. It would not always happen, but in some cases it could. This shouldn't happen anymore.

* GRM_FullBackup_Save was a deprecated saved variable that will no longer appear as a nil in the savedVariables file.

* Fixed an error where if you are using the GRM > Options > UI > Tab fade feature a lua error could occur when selecting any tab but the Log tab. It didn't break anything, but it was a lua error needlessly.

* Fixed in issue where if you were to ban someone who is still in the guild, in some cases it wouldn't sync if the person requesting the sync did not have the data.

* Fixed a bug that could prvent someone who had not installed GRM since 2017 from updating to the current version.

* Fixed an issue with the minimap icon where it was leaving a "ghost" empty icon, in addition to a correct one, if you were using certain minimap brokers like Azilroka. This should no longer be any issue with ANY minimap brokers. 

* Fixed an issue where the minimap icon did not path around the minimap properly as of 10.0 changes in DF. I didn't notice this since mainly LibD minimap broker took it over, but if you disabled all addons but GRM and let GRM management, the pathing had changed on the minimap so this has now been fixed.

* Noticed that the Export window (/grm export) was scaling with the core GRM window as a child frame. They should have been independent. This is now fixed and can be scaled separately.

* Fixed an issue where the scaling on the windows was not scaling ALL text objects properly. Most was getting scaled, but some were not proper child frames to the core frame and were sister frames, so the logic of scaling applies to the given frame and all child frames. This is now resolved.

* The mouseover window was incorrectly scaled as default. I don't know how I didn't notice this, or I messed it up and got lazy to change it back in the day, I don't remember, but the scaling was default at 1.33, which is incorrect. It should be 1.0 -- or 100% scale. This likely caused zero difference to addon user, but it COULD have been a problem for anyone that used custom addons that affected scaling of any frame.

* Fixed a bug where a lot of "ghost" entries were added to the AltGroup savedvariable for people when they left the guild. This should no longer happen and all old entries will be cleaned up automatically from them.

* Fixed a bug where the player status tooltip was ultra small in the text (size 1 font for some reason lol). This has been fixed. Probably an accidental typo some patch back.

***MISC***

* Massive database rewrite has been done and refactoring of much of the code. This was done as a necessity due to the massive changes in 10.1 that will allow cross-faction guilds, something I had never ocnsidered. I originally had compartmentalized the data in the guilds by faction, so this needed a rewrite, but I also was not using queries to pull data fro mthe saved variables, so I ended up having to edit > 1000 lines of code for this patch. To save myself the hassle, and to cleanup the code, I wrote a bunch of GET queries for data from teh which clean things up a bit, but did take significant effor to rewrite.

* For those that monitor the .toc or savedVariable file, just a heads up, the "GRM_Misc" global variable is cleaned up and made a little more efficient and will cleanup the saved file a little and will NOT be stored needlessly. It's mostly redundant info and should ONLY be carried over between saves if a player logs off in the middle of an action.

* Added a new memberData point -- "MythicScore" is the variable name and it will represent your Mythic+ Score. Of course, this only applies to retail WOW, not Classic. People parsing the save data, the player value is "MythicScore".

## **VERSION 1.96 RELEASE - March 27th, 2023**

**NEW FEATURE**

* The "Sync Users" tab will now provide more clear and updated sync information so it is more clear what is being sync'd, what isn't, and why. Please note, due to the significant rewrite, the new SyncUsers page will not be forwards compatible so people with older versions will not be able to see your sync status as being unavailable. You will be able to see the outdated users, of course. This only applies to version prior to the 1.96 release.

**PENDING SYNC PROGRESS PAR HAS BEEN DELAYED TIL NEXT UPDATE -- IT IS 100% Built, but some quirks are making it not perfect so I am working on that

***TO BE RELEASE NEXT BUILD***
* Sync Progress Bar - Sync will now show your progress as a % completed. This is a rough estimation to kind of gauge the speed of your sync, based on total volume of information being sync'd. It will also update you with the details of who you are syncing with, and it will even inform you as sync has failed.

    -- You can hide this sync progress window
    -- You can re-show this window by typing `/grm sync`
    -- If you wish to manually trigger sync, just either click the "Start Sync" button or type /grm sync again
    -- I built an API for creating progress bars that can be used for any purpose but I plan on using it to more easily implement my future "Guild stats" feature. This API can be utilitzed by any addon dev for their own projects, however, fairly easily. This can be found in the "GRM_Stats.lua" file and can be used in conjunction with the GRM_API namespace in the "GRM_API.lua" file.
***PENDING FEATURE NEXT BUILD***


***QUALITY OF LIFE FEATURES***

* If a player has been removed from the guild, or they quit, it will retain the information on their previous alt group. When they rejoin the guild, GRM will now re-add them to their original alt group. While this is a minor thing, guild leadership has been known to joke around and "fake" kick players on occasion. This will save the hassle of having to re-link them to their alt group when they join. Or, just an alt kicked for inactivity from a guild will now auto-be linked back.

* On adding custom channels for GRM to report to, you no longer need to hit ENTER after typing. You still can, to trigger window creation, but upon losing focus from the window, either by pressing ESC or clicking something else, it will auto-trigger the creation of window, or save the changes if new chat window already exists.

* Adjusted the logic on sync leadership slightly. When dealing with a decentralized database, and to cut down on the "noise" of syncing across chat, there is a "sync leader" elected behind the scenes. This sync leader becomes the centralized database that session, that holds the most current sync data for all online to sync with. It will dynamically shift as people log off and on and request sync data. It now prioritises the sync leader a little more intelligently than just the previous method of relying on who is already the sync leader. The election process is more selective. Most people will not notice any difference since this process happens strictly behind the scenes, but it IS important as sync restrictions do matter for things like ban data and so on, so it doesn't make a whole lot of sense to have a non-officer as designated "sync leader" behind the scenes when a GRM officer is currently on, for example...


***BUG FIXES***

* Fixed many sync errors that were causing it to fail. I won't go into everyone but I found quite a few.

* Fixed an issue where in some cases the main data would be completely skipped from being sync.

* Same with birthday data -- fixed an issue where in some cases it would skip from being sync'd

* Fixed an issue where main designations were occasionally getting removed on a sync. I did find a flaw where in some circumstances the "timestamp" of the action was being changed to the current time() rather than the sync'd time. This would create a problem during sync because if the timstamp was overwritten with the current epoch time(), then the database would be showing as that being the most recent event, thus it would possibly remove the main time tag.

* Fixed a sync bug that would cause sync to fail when it finally got to comparing the alt data. If you noticed the join date and promotion dates syncing fine, but the alt group and main tags not syncing, and getting a "sync failed" message, this bug fix definitely applies to you.

* To improve sync efficiency, due to the heavy server throttling of data, GRM does a "pre-check" of mismatched data between the 2 players to do a cursory check if they differ so that only the differing information will be compared and sync'd, for the sake of efficiency. This is why subsequent syncs should get shorter over time as there is less to sync. There was a bug that was allowing birthday data to show as not differing between the 2 players in a pre-check, so in some cases sync would skip over syncing the birthday information, whilst still sharing the bday changes, wasting sync time. This has been fixed.

* Fixed an issue where the Event window would not load because if someone was on the events list of upcoming bdays or anniversaries, and they left the guild, it was in some cases not being removed, which ultimately caused an error as it looked up information on the player in the list. They now should properly be auto-removed from the list when they are no longer in the guild.

* Fixed a lua error that would occur for some people who were not able to export FORMER MEMBER lists.

* Fixed a lua error that could prevent patching if you haven't patched and updated GRM in several years.

* Fixed an issue on updating the database to new format would not work for some people so GRM would never load.

* Fixed an issue that caused the ban list to not load properly when viewing.

* Fixed an issue where the "Player not found" or "No Player name..." system message was being swalled by GRM and hidden. It was supposed to only apply when syncing and when a player goes offline, but was permanently doing so for all of those messages.


## **VERSION 1.954 RELEASE - January 23rd, 2023**

* 10.0.5 Compatibility Retail

## **VERSION 1.953 RELEASE - January 18th, 2023**

* WOTLK Compatibility fix for 3.4.1 release - Build for all

## **VERSION 1.952 RELEASE - December 4th, 2022**

***QUALITY OF LIFE***

* Super minor adjustment to the GRM Macro tool for promotions/demotions. You can now set the promotion to apply to a player at 0 days or months. In other words, you don't want to promote them until they become active again, so they may be at an "inactive" rank. Well, now, as soon as they come back to being active, with no delay, they can immediately be promoted from the rank. Prior to this you could not set the value to be zero days.

***BUG FIXES***

* Fixed a bug that could cause sync to fail, or in some cases, just not sync all of the join dates.

* Fixed an issue that was affecting GRM from loading if you were running ElvUI - this would not affect all people, just some. Not really a conflict, but a load order issue around the minimap causing GRM to crash. This has been fixed.


## **VERSION 1.951 RELEASE - Nov 30th, 2022**

* Sync bug fix that was reported - seems to be affecting some people, not all. It shouldn't occur anymore.

* (Vanilla Classic) Class coloring was not triggering in the chat until you opened the GRM window. So, if you logged in, the class chat coloring was not working until that was triggered. Slight load order error that has been fixed.


## **VERSION 1.950 RELEASE - Nov 30th, 2022**

* Fixed a critical issue with join/promo date sync that was overlooked due to some significant recent changes - oops!

* Fixed an issue where if a player adds/removes a rank in the guild, it doesn't overwrite the whole guild's ranks as they shift, and become unverified promotion dates :(
    -- If this did affect you, I encourage you to use this tool - WARNING - Only use you if this affected you DB recently -- `/run GRM_API.ClearAllUnverifiedPromoteDates()`  -- Copy that into chat and hit ENTER.


## **VERSION R1.949 RELEASE - Nov 29th, 2022*

***BUG FIXES***

* Fixed an issue preventing GRM from patching to completion for some people who have recently updated. This was due to an error in pulling GUID data from the server from players no longer on the server returning "nil" data.

* When adding a ban in Classic Vanilla or in Wrath, it should properly show the display of classes only for that expansion, and function properly. Previously, if you did the call to the server of a class that that expansion did not support, it would return no data, so I wrote the logic that if no data is received on the call, to just ignore that info, and I let the server handle it. Well, now, it actually provides the data regardless. So in Wrath, you can go `/dump RAID_CLASS_COLORS["MONK"]` and recived all class info, even though it doesn't exist in Wrath. This is likely due to efforts by Blizz to unify their API on the back end. This has been rewritten by build version control check now so it should not happen again in the future.

* Ban list should work properly in adding names. There was an issue with adding Evoker previously.

* Fixed an error where the Evnt log was not working if you tried to open the window

* There was also an issue where you could no longer add events to the calendar. It looks like the "other" category has been added into an Enum table, hurray! `Enum.CalendarEventType.Other` is the new code line. I really like how Blizz has cleaned up a ton of their code to move lists into Enumerator tables.

* The format `22-Nov-2022` for timestamp was broken in the audit tool and it was not being recognized. This was the only timestamp format affected and has now been rectified.

* Exporting the join date timestamps to the player designated note was accidentally broken in a recent update. Oops! It is working again.

* Fixed an issue where if a player deleted a toon or say, transfered servers, then joined the guild on a new toon with same name, it was not detecting it as a new join.

* Fixed an issue that could cause sync to fail when syncing ban data

* Fixed an issue where main tags were being lost during sync repeatedly. This should now be resolved. I have run my unit tests as well as tried to break it with some various edge cases, unsuccessfully, so we should be good, but there are a lot of moving parts during the sync process so please report if this is not fully resolved. Thank you!

## **VERSION R1.948 RELEASE - Nov 17th, 2022*

***VERSION COMPATIBILITY WITH 10.0.2 RELEASE***

***BUG FIXES***

* If a player logs on, and they match the macro rules for a promotion, the addon should now only inform you one time, even if they log off and on multiple times. It is just a once per session info message. There was an error where it was repeat reporting, but for only 1 player, everytime someone logged on, if there was a match.

* New join's the history was reporting as a "Rejoin" in some cases, even though they weren't. This has been fixed.

* Fairly significant flaw in the rank history and join history of player's rejoining the guild. This is a side effect of a recent overhaul of the database I did and something I just missed in the process and only noticed once some reports came in to discord. This should now work properly.

* In some cases the live detection of people joining/leaving the guild was not being detected and/or not reporting at least the system message to chat. It should work now.

* There was an issue where if someone left the guild, then rejoined the guild shortly after, the next scan of the roster then would erroneously report them as no longer in the guild... then the following scan would correct it saying they rejoined. How annoying! It's a little complicated to explain why this was happening, but we should be good now.

* Classic Wrath was not parsing the guild log fully, and it now should - this will allow GRM to determine things like who promoted. I had this working, so I think I had a version control error and re-merged some old stuff and it has given me some issues I didn't realize until I was too deep into the next builds... Oops!

* Issue with patching not completing for some people that has now been resolved.

* You should no longer get an error when mousing over a player who is a Drenai race. There was a typo in the raceID here. It seems to have been there a while so this must be evidence that very few people play as that race as this is the first report I got of it ever lol.

* Fixed an issue when mouseing over the "Custom Join Tag" in the officer tab of the GRM options - since this is a global control, in certain conditions the tooltip was erroring and throwing an error. It shouldn't anymore.

* The dropdown menus for the default tab and changing the "main tag" in the GRM General options should be working again properly. There was a typo in my last build when I added the new timestamp option so dropdowns weren't loading. Oops!

* Ignore players list was not refreshing properly when you removed or added people to the list and it was open. It now updates automatically on the fly without needing to reload the window.


## **VERSION R1.947 RELEASE - Nov 11th, 2022*

**HAPPY VETERAN'S DAY IN THE USA**

***QUALITY OF LIFE***

![Updated Export Window](https://i.imgur.com/9JE3w1w.jpg)

* GUID is now an optonal export - this is disabled by default. Also, you can choose to normalize the player names to the 26 char English alphabet and remove the special alt-code characters. This is also disabled by default.

![Macro Tool - Show Only Online](https://i.imgur.com/4HP8kpB.jpg)

* You now have an option to filter just the people currently online in the macro tool, for demotions and promotions (I did not include the option for kick). It seems useful to maybe want to only promote someone when you have a chance to talk to them.

* In addition - GRM will now inform you if the person logging on to the guild currently has a pending promotion/demotion. Sometimes you just get busy and forget. If they match a promotion rule and are due for a promotion, and they just came online, GRM will now remind you of this status.

* The system messages are now silenced and replaced by the GRM log messages. This only affects the promote/demote/kick/leave/join live recording messages. This is just so it cleans up a little bit of the spam in chat due to GRM's additional log message. If you would prefer the system message over the GRM message, just uncheck the box on the right side of the log "ToChat" for those specific messagess and you will see the system messages again. The GRM log messages will still be recorded to the log.

* It may not have been clear before, with the wording of this option, but you can silence the once per session message that your GRM version is outdated (if another guildie has a more current version). I have moved this checkbox to the "General" options tab. Also, for new addon users, the feature is disabled by default, but you are able to turn it on. I personally like it, but I know some people prefer to not be notified by addons in any way that there are updates.

* Furthermore, some of the sync reporting has been streamlined a bit, and the `/grm sync` command should no longer have the option to break current syncs.

* Re-wrote the GRM_API I am prepping for classic... Some preliminary stuff is put together. One I finish the core of it I will publish all the accessible API functions, but you can see them easily in the GRM_API lua file. This is also where some more powerful tools will be made that maybe do not apply to general addon use, but will allow some more advanced options.

***BUG FIXES***

* Fixed an issue where the log would report a demotion, immediately after a promotion was made, in error, then it would correctly re-report the promotion. This would seemingly affect only some people, oddly enough. In some rare cases this could also occur when someone leaves the guild, it would report they are returning. This should no longer occur.

* Some people may have found their join dates disappeared recently. There was an error on a patch and was not caught until it was reported by someone it happened to. It does not affect everyone. Fortunately, you can use the "Advanced Join Date Tool" in the /grm audit window if you were affected, and re-import the dates from the notes. 

* Issue with sync not starting properly for some has been resolved. There seems to be a few different issues here with sync failing and I am working to clean them up. If you are getting any issues where sync fails to start, please let me know, or you type /grm sync and it won't trigger, let me know. It should trigger automatically after X seconds after logging in (default is 60). But, some people set it as early zs 10 seconds, or just disable it altogether and only sync when theyt manually /grm sync command it.

* Fixed an issue where the join date was not getting added to a public or officer note properly. This would not have affected you if the date was going to custom note. There was a slight API change I didn't realize. This should work in all cases again.

* Fixed a bug where the "Apply promotions regardless of activity" was not sticking properly when editing the macro rule.

* Fixed a bug where GRM would not load at all as it was crashing in the patch process for someone who had not updated the addon in a little while.


## **VERSION R1.946 RELEASE - Nov 7th, 2022*

* Timestamp that can be added to the player note, and can be controlled globally is now independent of player settings. So, the timestamp format join dates can be a different format than your own personal preference for GRM timestamps in just the GRM frames, like on the audit window or mouseover window. This was done because a guild leader may mandate a format for say, the join date exported to the Officer Note, but I personally would prefer to have my log showing a different timestamp format.

![Officer controlled Timestamp format is different](https://i.imgur.com/pqCf80S.jpg.)


* Tooltip on guildies in chat removed in favor of just an expanded right-click window - you can now Ctrl-Click or Shft-ctrl click. Eventually, I will expand this window a little more to add some additional controls, but for now, it's just informational, and to set Main or demot from main status. I will likely expand the options here. Also, this tooltip is not fully integrated into the built in tooltip for style reasons and is a GRM frame on top. Please note, this ONLY works on the chat window, not on the communities frame in retail. Blizzard has blocked addons from being able to access the guild chat stream in retail so addon actions are restricted strictly to your live chat window.

![Right Click context Menu in Chat Frame](https://i.imgur.com/S0MQ7W3.jpg)


* The shift ranks up and down should now, once again, be showing for Classic build players. Someone please confirm this as I have not yet had the opportunity to.

* Should no longer get a warning on Evoker class missing localization.

* Cleaned up the ordering of the GRM Options tabs a little as it was getting a bit crowded. Slightly extended the window.

* RGB coloring of classes should stick and be compatible with the same coloring from the client, as is set by the player's client for colorblind play.

* GRM has removed the option to sync with outdated addon users. By default, players must be using the same version of the addon to sync between each other. This is just something that is going to save me some headaches in the future.

* Issue with completing patching for some people who haven't updated in a long time. This should actually be resolved now.

* Fixed an issue where GRM would not load properly after a guild namechange.

* (RETAIL ONLY) - Noticed that the mouseover still works when the recruitment window is open, sort of annoyingly. I now restrict the mouseover when the recruitment window is open.

* (CLASSIC ONLY) - Due to repeated efforts to resolve the taint issue that has appeared only in classic, the ctrl-click ability has been forcibly hard restricted down to only showing the guild roster, and the GRM window. The small side window that is built-in with the promote/demote controls cannot be opened in any way by addon scripting or else taint is introduced. This is not the case in retail, funny enough. But in Classic, this is the compromise that needed to happen.


## **VERSION R1.945 RELEASE - 30th Oct, 2022**

* Fixed an issue where if you set the date timestamp format to one of the last 2 options, globally, it would reset to a different format. This only affected people using the 30-10-2022 or the 2022.10.30 date formatting styles and had set it globally with the guildInfo tag.

* Additional bugs for the backend resolved reported on discord.


## **VERSION R1.944 RELEASE - 30th Oct, 2022**

***QUALITY OF LIFE***

* Added 2 New Macro Rule filters:

* > Promotion Rule - You can now choose to set a promotion based on the Time at Rank, or based on the Time in the Guild

![New Promotion Macro Tool Rule](https://i.imgur.com/AytQLR9.jpg)

* > Kick, Promote, Demote Rule - You can now search for a text match that will ignore the rule if a match is found. In other words, let's say your text match is "[S]" - The macro filter will skip over this player and deem them as "safe" from that specific rule. You can set any text tag you would like. However, I did make the decision that GRM will only search for the tag within the officer note. This is because the custom and public notes are typically widely available to players in the guild, and it doesn't make sense for a player who might discover the tag, to be able to add it to their own note.

![New Promotion Macro Tool Rule](https://i.imgur.com/1MV5tmE.jpg)

* Added compatibility to the YYYY.MM.DD timestamp formatting - This is another timestamp formatting option. This can be controlled as a global control for the guild. It is also a data format fully compatible with the "Advanced Join Date Tool" for importing/exporting join dates from player notes.


***BUG FIXES***

* Fixed the issue that is keeping new players' data from being added to the database properly when joining a guild. It also fixes the crashes of the log on load which was preventing the log from updating.

* Ban list search now should match the names correctly, no matter what format you use in a name, special character or not. Oops!

* Fixed an issue that could cause taint in Classic, which would block actions. These has been thoroughly tested to now be resolved, finally!

* Fixed various misc. errors that popped up and were reported on Discord. Significant amount of work on this, so hopefully cleaner. Not all reported items are yet resolved, but the game breaking ones are.


## **VERSION R1.942 RELEASE - 27th Oct, 2022**

* Fixed the new minimap compatibility issue error that was causing GRM to crash for people hiding the minimap button. If you are wondering why GRM stopped working for some people, this fix resolves that.

* Fixed a Lua error that could occur when changing fonts or on load in Classic  

* Fixed an issue where the mouseover could get locked even after closing the window. This seemed to only happen on the "Old" roster window.

* Fixed an issue so export won't throw an error when looking at Race data for export in Classic, but trying to determine the source.


## **VERSION R1.941 RELEASE - 27th Oct, 2022**

***QUALITY OF LIFE***

* Added compatibility to the LibDBIcon data broker, which is commonly used for MINIMAP Icons. The broker is not natively included within GRM, and the default GRM icon will work regardless. However, if GRM finds it installed, which is likely given the prevelance of other addons, it will take advantage of it and create a broker compatible icon. You may notice your minimap position has been reset. 

***BUG FIXES***

* Issue with the roster refreshing back to the top. Blizz must have made a change when doing a call to the roster to scan for changes, it will refresh the frames too. This is handled slightly differently now and should not annoyingly refresh your guild roster back to the top.


## **VERSION R1.94 RELEASE - 26th Oct, 2022**

***RELEASE FOR 10.0 COMPATIBILITY FOR DRAGONFLIGHT EXPANSION***

***QUALITY OF LIFE***

* There was some chance of spam when syncing if a player logged off in the middle of a sync, getting a message they are currently offline. GRM will now use that message to instantly know synce will fail and end the sync with the current player, silencing the spam messages.

***BUG FIXES***

* Compatibility issues with GRM and DF pre-patch 10.0 have been resolved.

* The check for dead accounts was not allowing you to ignore them on the scan - you would hit ignore, then next session you would see them again.

* The ban list search was not showing all names, just the ones currently in guild but banned, but not yet removed. Oops! Fixed

* There was an error where a Rejoining member was not processing in the scan properly. This has now been fixed. It broke the scan report so GRM will have reported no changes until this was resolved so if it has been broken for a few days for you, this will now resolve it. I tested it in all scenarios... Rejoining player, banned rejoining player, rejoining player with a namechange, and namechanged player who is rejoining but was previously banned. All scenarios working and reporting properly now.

* Found an issue with the patching process because there was a bug found where a player, in Classic, can have guild database on one faction, deleted the guild, or abandoned it in a previous expansion, then the saved data is carried over to the next Classic expansion, Like Vanilla to TBC, but they now have changed factions and recreated the same guild on same server with same name... Typically you cannot do this, as you can only have 1 guild with a name on the server, well... this is how it can happen. In retail this is not an issue because the guild Check relies on the unique guild GUID or "ClubID" post 8.0 communities patch, but in Classic, you have to check against the guild name string only... Thank you @kreun for this report. This is the first I have ever heard of this happening.

* When using the "Ignore List" - if you propagated all of the ignore rules to all alts of the player, and the macro tool was currently open, the queued window would need to be closed and opened to refresh. It will now refresh appropriately, automatically, when any ignore rules are set.

* "Fade on Tab Change (GRM UI setting option) was throwing a lua error I just realized. I guess no one uses this feature, including me, as I only discovered it when testing if everything was working. lol

* Classic had a potential taint issue that could occur if you CTRL-Clicked to bring up player window, like from audit window, prior to actually opening the guild frame yourself that session


## **VERSION R1.936 RELEASE - 23rd Oct, 2022**

***QUALITY OF LIFE***

* Added the ability to control-click a player's name in the chat window and open the guild roster directly. This only works, obviously, with current guild members. I also added a tooltip indicating this possibility on the current roster.

* Using the "search" in the Log will be a little bit smoother for people with large number of entries and it will only do the search once you've finished typing, not try to reprocess the whole log each char, instantly.

* The Ban List window now has a "Search" feature to find names - I did notice something I need to also update with the ban feature - This is the last window that is NOT a hybrid scrollframe, so it is a bit inefficient of a window. I completely forgot that I never implemented the code on this scrolling window. I made a note to do it on my to-do list. Regardless, enjoy the search feature! :)

![Search names on the ban list](https://i.imgur.com/Ogyle02.jpg)

* Dates should not be properly 2 index formatting. For example, 5th of January, 2022 was showing 2022-1-5 for date formatting, and now it should properly show 2022-01-05, which just is the proper way to show the dates.

* It might not be obvious, but you can actually shift click player's names in the GRM window to copy them. As such, I added a tooltip to make this information more known:

![Copy someone's name to chat](https://i.imgur.com/lpznWKa.jpg)


***BUG FIXES***

* Fixed a Lua error that could trigger when reviewing guild calendar.

* /grm guid was not posting to chat for some people - a delay has been added to ensure the proper clearing of the chat in the UI has enough time to occur and the player GUID pastes there to be copied.

* (Classic Only) - When using the `/grm search playerName` - you will no longer get spammed about a missing key. 



**VERSION R1.935 RELEASE - 21st Oct, 2022**

***QUALITY OF LIFE***

* You can now type `/grm search playerName` into the guild chat and it will bring up the audit window searching their name. It does not have to be exact spelling - this will also do partial matches, as well as disregard special alt code characters so complicated name spellings can be easily simplified.

***BUG FIXES***

* Fixed a bug that was missed that would cause GRM to fail to load or complete the patch process - this was missed because it ONLY affected people who had toons in their guild with join or rank dates on Feb 28th or Mar 1st -- Had a typo on my LeapYear API and the Lua error filters never caught it in any of the databases I tried due to this semi-edge case situation!

**VERSION R1.934 RELEASE - 21st Oct, 2022**

***BUG FIXES***

* Fixed an issue that would cause an "error" message about alt sync data message - this could ultimately cause alt data to not sync completely accuractely either for a few names at the end of the roster. Minor oversight from when I rewrote the alt sync protocol.

* Fixed a bug where GRM would not finish the "patching" process.

* Added a fix where if you used a custom channel for GRM messaging, in some cases it would get reset. This shouldn't happen anymore as there is some redundance to recheck that a channel exists before just purging it immediately.

* (Classic Only) - Class coloring was erroneously getting disabled in the default channels by mistake in latest update. This has been resolved. Also, you can control this much easier in the /grm > Options > UI settings tab with just a single checkbox.


**VERSION R1.933 RELEASE - 21st Oct, 2022**

***QUALITY OF LIFE***

* Events Tab/Window
  -- "Ignore All Events" button has now been added so you can just clear all.
  -- Last Online has been added
  -- Date is now visible without needing to click on it
  -- Events now sort in order of upcoming date
  -- Tooltip has been cleaned up to actually go away when mousing off of the event
  -- Classic compatibility has been added, though limited as there is no export to a calendar feature in TBC or Vanilla - it DOES work in WOTLK

![Improved Events Window](https://i.imgur.com/DQufBIU.jpg)

* A player search has been added to the audit window to help assist in finding players quicker

![Member Search Added to Audit](https://i.imgur.com/K4rSEPp.jpg)

* Macro Tool improved
  -- Copy feature now available. Right click and copy the rule, which opens the edit window that has the same vaolues as the existing rule, but now can be quickly and slightly modified without needing to edit the entire rule from scratch
  -- Macro tool rules can now be configured in any order you wish to view them. Sort them up and down. This is just for personal convenience.

![Macro Tool Rule Copy](https://imgur.com/fowJVTY.jpg)
![Macro Tool Reorder](https://imgur.com/Adu2ZIj.jpg)

* If an addon is now disabling system messages, GRM will prompt you with a popup window asking if you want to re-enable them. This allows this addon compatibilty with addons like Fast Guild Invite which auto-disable the messages, breaking GRM. Unfortunately, the API cannot permanently enable system messages between sessions. There will be a message informing the player that if they wish to permanently enable system messages they will need to do it manually in the chat general settings as this will only enable them for the current logged in session. This will only apply to people blocking all system messages so GRM cannot catch certain events, and for some reason Fast Guild Invite disabled it by default.

![ReEnable System Msg Easily](https://imgur.com/zeicZzS.jpg)

* The Sync join date among all alts now has a small button instead of relying on mouseover tooltip and right-clicking the join date title. Now, if it applies, a small button with an arrow to the right will appear. Click this and it will allow you to sync those join dates. Furthermore, the tool now shows the actual dates you are going to sync to. Before it just said "Want to sync to your main?" Well, now it shows you the actual date it is asking to sync to so it can be comapred to potential other options, like oldest.

![Sync Join Dates Button](https://imgur.com/m9WTcZy.jpg)

* The same applies to the alt group extra details window that would popout before when holding shift over Alts title - now, there is a button that appears and on mouseover the side window pops up, which you can click to lock in place.

![Alt Groups Button](https://imgur.com/jIpKFwa.jpg)

* (Classic Only) - Achievement announce. Thanks to @DinnerBone on discord, the code pull request has been merged and Classic Wrath will now announce achievements to other GRM users. For some reason this feature is missing from Classic Wrath even though it existed in the original WOTLK expansion - Blizz has acknowledged this bug, but who knows when they will fix it.

* Birthdays will now just say "Happy Birthday, [Guild Member]" instead of the weird "It's almost time to celebrate" message.

* GRM will now inform you if it is the player's birthday when they login - It will also inform you if when you login, any of the players that are already online, if it is their birthday. This will only announce once per player, no matter how many session you login that day, or how many times they login. This can be disabled in the OPTIONS > SCAN tab.

* Cleaned up some translation work, and also removed many redundant strings, or modified them to make more sense. I am pretty sure some of the ones I wrote I must have been half asleep!

* Fixed the logic in the "Hours report" that broke time since the player was "last online" down to hours, days, months, and years - There was a lazier away before. Now it is completely exact, taking into account leap years. This has been fully expanded into exact logic on the macro tool as well. Before I was lazy and just took a 365 / 12 approach to average X days in a month, and cross-referenced against the time pulled from the server, but now it will be exactly explicit. This is not as clean as it sounds because it essentially needed to reverse-engineer what I break down from the server as for ease of comparing numbers and time, when I pull the data from the server "last online" blizz gives this to me in the format of X years, X months, X days. On their own backend they take into consideration of all of these things, but then they throw out this simplified form, so I basically parse it all down and convert it into hours to compare. It really just leans out the code a bit to do this conversion. Well, now I need to reverse back the hours back to their actual epoch timestamp dates. This was a HUGE pain because to do so, and use the built-in Lua time tools, I had to also build a converter that took Operating System time (your windows PC time), and then convert it to the server time. That is the next line. It was a lot of work lol that most people will probably never notice lol.

* Fixed an issue where GRM was creating a lot of sync "spam" behind the scenes in guilds with tons of GRM users. While it might not have been obvious to some people, as it was behind the scenes, it was wasteful use of resources. The sync has been moved to happen across whisper between the "sync leader" account, and the person who just recently logged on, though the updates will be broadcast guild wide, if necessary. Should be a bit less noisy now.

* Sync speed slider in the Options has been removed as it no longer applies and is sort of a legacy feature that was unnecessary and applied more to when I was trying to "cheat" the server limits.

* Complete Rebuild of the entire backend alt database - while this will not be obvious on the front end, when I initially wrote the alt logic I was basically building as a I went and the entire codebase at that point was less than 1000 lines of code. Fundamentally it was not built in the most efficient way, but I have built over its foundation since. As GRM has grown into tens of thousands of lines of code, with increasing complexity, and with the alt logic having its tentacles all over thhe place, it got to the point where a decision had to be made, do I keep building on the original "leaky" logic, that had a larger memory footprint, or do I finally get around to rebuilding the entire alt database and accompanying logic from scratch. Well, with no end in sight for the future of GRM, it just made sense to get it over with now. This will have the side effect of fixing some potential logic flow errors that could result in alt groups getting jumbled incorrectly during a sync.

* Guild_Roster_Manager.lua file has been renamed to GRM_Core.lua - This is to prevent confusion with the SavedVariables which carry the same name as the addon.

* The advanced join date tool found in the audit window is now restricted to be only accessible by officers in the guild, and it will update on the fly if a person is removed from officer status, locking them out of the tool, to prevent confusion. Before you could still access it as a non-officer, but it was mostly useless. This just helps avoid any unnecessary attempts since they won't accomplish anything anyway.
  -- In addition, the tool was revamped a bit on the back end - fixing compatibility issues with some date formats, and also scanning the entire note for it to be imported or moved
  -- Retooled the tooltips a bit to be more clear and restructured the restrictions on it.
  -- Added compatibility for YYYY-MM-DD, DD-MM-YYYY - there was partial compatibility before with GRM, but the Advanced JD tool it had not yet been implemented until now.

* In the side Add Alt window - instead of needing to hit the ENTER key when adding an alt, just clicking the name a 2nd time will auto-add it to the alts list. Ty @TimeDrawsNigh

* Players can now Ctrl-Click the names in the alt lists and be taken to their player window which will allow them to do things like promote/demote. Before, just clicking on a name will swap to their GRM window, but not to actual player window. Of note, due to taint restrictions on the Communities window, this auto-popup of the roster is only possible with the classic guild roster window.

* If right clicking a player's name on the mouseover window, and resetting a specific player's info, it would then force a resync. It no longer does that now because it doesn't make sense to wipe an individual's player then re-sync it all back. Maybe you want to wipe it, then modify any changes first. This does not appear to be a widely used feature.

* Mouseover window should now shoe that the player is "AFK" or "Active" more quickly, as before it sometimes could take a long time to update. Also, it now takes into account if a person is on "mobile" chat rather than in-game.

* 2 new font choices: Avant Garde Bold and Nunito Xtra Bold, have been added, as per requested. Find them in the GRM Options / general settings.

* When updating a player's join date to the player note, before, if it found anything in the player, officerNote, or in some circumstances the custom, it would avoid updated the timestamp, it would skip over it. Now, it will purge the old date, no matter where it is in the note (text in front or after it doesn't matter), and it will now add the new timestamp. That is, if there is room for it to be added only. If you still don't have the room then it will not write over it to make room so it IS limited to the max char limit (31 for public and officer).

* The minimap icon on Classic will now be the same as retail - before I used the built-in icons for access and the icon I used was not available in Classic. I decided to grab the icon media file and import it directly from the addon folder.

* Promotions will now be reported to the log *AFTER* new member log entries, because it makes sense that a player changed rank after they joined the guild.

* The /grm help command is now fully localized to be compatible with all available languages, though it still needs translation work for some.

* GRM now auto-scans your roster for "Dead Accounts" when you login. Or, you can type /grm dead. Often accounts are abandoned, players banned, and so on, but their name is still in the guild. Sometimes the accounts are just so old an inactive that Blizz changes the name of the player and adds numbers to the name (this can also happen on a force rename too). But, the logic looks for an inactive player who has the features on this type of name which is most certainly indicating a dead account, thus that person will never be returning to the game on that toon. As a result, the addon now recommends permanently removing that player. You can also manually do a search by typing `/grm dead`

* Fixed an issue where sometimes the server was not providing correct information immediately on a player's ability to participate in guild chat. Some guilds can silence players as a punishment rank, but this also hinders addons from being able to communicate from players at that rank as well. The addon will now do a proper re-check when trying to sync, to ensure the server provided the most up-to-date info and not getting incorrecetly reported that the player does not have access to syncing data because chat is restricted. This is sort of an "edge case" system as very few people have ever reported this after logging in, and a /reload fixed it, but this should resolve the annoyance of having to reload.

* Russian translation has been updated, fixing some translation errors. Thank you @Oleg Koloskov on Github

* GRM will now add proper guild nameChange detection to Classic builds, as Blizz now allows the purchase of a namechange. Due to some complexity with this capability as some server information is not available in Classic that does exist in retail, a popup window will appear after logging in during a suspected nameChange detection and ask for confirmation. If you Reject the detection, it will just add the new guild, otherwise, it will just overwrite the old name with the new guild name and none of your guild data, like alt info, logs, etc... will be lost.

* When searching a name, like when adding an alt to a player's list, if the name has special "alt code" characters, the comparable english letter will still be able to find the name. For example, if your name is "Bîkê" then searching "bike" will be sufficient in the search.

* A player can no longer cause a Lua error by typing /grm quickly after logging on, since the addon is not configured instantly. It now ensures the addon is fully configured, similar to clicking the minimap button.

* New slash command `/grm guid` will add a player's GUID to the chat box to be easily copied and extracted from the game.

***BUG FIXES***

* Fixed a long broken issue where some alt groups were getting intermixed incorrectly. In the process to rebuild the flaw on the backend code to remove this sort of edge case error that could be propagated out in a sync, if there were co-mingled incorrect groups, I purged the alt lists from the players in those groups. This was in an effort to basically "reset" them, so they could be rebuilt to the new database structure that should resolve this from occurring in the future. This was actually a daunting amount of work because the alt group system was integrated into so much and I basically rebuilt it entirely, including the sync protocol. The problem should be gone now as it was an INSANE annoyance I am happy to say should be now resolved. It likely did not affect most people.

* Fixed an issue that could occur with the sync process would fail. This is sort of multi-faceted so I won't go into a lot of details, just know that the backend update regarding this was significant and should resolve it.

* Fixed another issue with sync failing due to trying to sync demotion data of a player who quit in the middle of a sync - as it attempted to demote a player from main it would no longer find the player. There is protection against this now (other sync data already had it, I just overlooked it on dropping a player from main status)

* Fixed a bug where the main tag would being added to a player going offline would error out if they had just recently quit the guild but their system message status was still showing for you even though no longer in the guild. This self-resolves within minutes of a person leaving the guild, so this is somewhat an edge case.

* Fixed an issue where some people who had noted updated GRM in a long time were having troubles updating their addon and it was crashing at load and never updating to current version. This is now resolved.

* Fixed an issue where if you banned a player when kicking them, and then you wanted to ban all their alts as well, it would successfully ban them, but the "reason" you gave for the ban was only showing on the toon that was first kicked, not on all of the alts that were just banned. The "Reason" will now propogate to all in the grouping.

* Fixed an issue where the "custom message" using the macro tool would not report to the log properly.

* Fixed an issue where an old member of the guild REJOINS, but also had changed player level. It errors out when trying to build the log string as a former member rejoining. This has been fixed.

* Fixed an issue where the "Macro Rules" button on the player mouseover, if a person had 12+ alts, it was being positioned incorrectly slightly shifted down. It should now be properly consistent.

* Rewrote the entire backend logic on parsing the date("*t") function and in parsing epoch time. There was a flaw that I found that I didn't realize before but in trying to figure out why some people's dates seemed to reflect differently I found that the function "date()" only pulls from the server your OS time, not the actual in-game server time, so if you played on a realm with a larger time difference there was a chance of things occasionally being off. No more!

* Fixed a bug where the mouseover window, when locked, sometimes the player status would sporatically swap and show other player status on the update. This has been a bug that kept creeping up every once in a while so I just redesigned the whole on update to instead of bandaid this annoying thing, it is rewritten and will not happen anymore. yay!

* Fixed minor issue where if you went to set the date of a player's promotion, then hit cancel, the text behind the set Promotion date button would not disappear.

* Fixed a bug where if you set birthday to Unknown, it was only setting that specific toon as unknown, not the entier alt grouping. Same with editing and setting unknown. This will now resolve that.

* Fixed a bug when syncing the join dates among all alts on selection the button would just disappear rather than hiding the whole side window.

* Fixed a minor bug with the macro tool where the ranks should be greyed out from selection if rules are set to ALL ranks. This would not properly happen during an "EDIT"

* Fixed an issue where the birthdays could possibly not sync properly if someone had mislabeled a toon's birthday, then co-mingled 2 alt groups. Since a birthday is shared among a person and their alts, the date is propagated, but in the sync process, this means the alt groups need to be finalized BEFORE looking at the birthdates, or else some edge case issues could arise. The sync process has been updated properly and the process of syncing birthdays has acctually been fundamentally re-written to be a bit more efficient as well.

* Fixed a bug where the tooltip did not work properly on the macro tool when mass kicking banned players or a player's set of alts

* Fixed a bug where it was saying 100% complete after a sync if the player had between > 99% and < 100% complete, it was always reporting 100%. It should now report more exactly.

* When someone had an unverified join date or promo date, you could "use the date of promotion/join" however you wanted, with the simple click of a button. It's a minor quality of life time saver. However, in some cases this was causing a Lua error and has been fixed.

* Fixed a bug where the birthdate was not properly syncing among a grouping of alts when adding a toon to a grouping. Sort of an edge case as bug that would not happen in all circumstances. The group structure had to be a certain way.

* Fixed an issue where in the GRM > Options > UI Tab - if you wanted to disable the borders around the player notes on the mouseover window, for a slightly cleaner UI, it was hiding the note. This now works properly.

* Fixed a minor lua error that could pop if you leave a guild in the middle of trying to update the "safe" lists for the macro tool

* (Retail Only) - If you have the communities guild frame open, and the old guild roster open - there was a problem where you would get the mouseover window to appear from coommunities, but because it was now hovering over the old roster window, it still detected the mouseover of different names on the old roster so it would change the name you were looking at. This now will no longer happen.

* (Classic Only) - Fixed a bug in some Classic builds where if you edited a public note in the GRM interface it would cause an error.

* (Classic Only) - Fixed an issue that could cause taint if you are a guild leader in Classic Vanilla WOW. This would ONLY affect guild leaders as the issue is related to a setting only GL had control to modify.

* (Classic Only) - Level filtering option in the GRM > Options > Scan tab should now properly include max level 70 checkbox if in BCC and 80 if in WOTLK (once fully released).

* (Classic Only) - Export, when you selected to "Check all" was erroneously checking the "Guild Rep

**CODE OPTIMIAZATION**

* A LOT of code has been changed, updated, modified, deleted, added, and so on. Significant rewrite on the backend of a lot, as well as the addition of a lot. This took a very long time, but laid the groundwork for easier development in the future and cleans up a lot of legacy issues that had never been truly resolved, only "patched"

***Removal of some individual guild member data variables***
**These no longer exist**

* player.rankHistory
* player.verifiedPromoteDate
* player.oldRank
* player.LeftGuildDate
* player.LeftGuildEpoch
* player.joinDate
* player.joinDateEpoch
* player.verifiedJoinDate

**They have been replaced by the 2 following player variables. Each change/promotion will be stored as a new index in the table:**

* player.rankHist
* player.joinDateHist

```lua
player.rankHist = 
{ 
    {
         rankName (string),
         day (int),
         month (int), 
         year (int),
         dateInEpoch (int),
         epochTimeOfChange (int),
         isVerified (bool),
         typeOfRankChange (int) -- typeOfRankChange: 1 = promotion, 2 = demotion , 3 = lef
    }
}

player.joinDateHist =
{ 
    {
         day (int),
         month (int), 
         year (int),
         dateInEpoch (int),
         epochTimeOfChange (int),
         isVerified (bool),
         typeOfMembershipChange (int) -- typeOfMembershipChange: 1 = Join, 2 = left
    }
}
```

*NOTE* These 2D tables/arrays where each nested table is another recording of the player either leaving the guild, joining the guild, or in regards to the rank information, changing rank (a join counts as a rank change as you rejoin lowest rank). The LATEST and most current event is inserted at position 1 of the table, just like above. This is the equivalent of position ZERO -- So `player.joinDateHist[1][1]` is the current RankName for the player. If the length of the table was > 1 then the 2nd position would be the previous rank, and so on.

***Note:** Each update will be tagged with  **Classic/Retail/Both** for context*

_______________________

**VERSION R1.92991 RELEASE - September 1st, 2022**

* Fixed an issue that affected class name colorization in Classic, as well as the hotkey binding for the guild pane. I repeat, GRM does **NOT** overwrite any keybinds at all, and even goes out of its way to ensure the default guild pane hotkey in Classic is not only not used at all, but not shared with the Push-to-Talk hotkey, if there even is one.
* Fixed an issue that could cause classic build errors if they ever released TBC again. Just better compartmentalizing of the various Classic builds so that I can have 1 single GRM build compatible with ALL Classic builds and Retail.

**VERSION R1.9299 RELEASE - September 1st, 2022**

* Fixed an issue that affected some localization clients with spamming of the GuildInfo to the chat. This now future proofs the parsing of the data with some pattern matching instead, in case Blizz decide's to change their translation a 3rd time!

**VERSION R1.9298 RELEASE - September 1st, 2022**

* Compatibility update for WOTLK Classic and for Retail
* Please note, the calendar feature of WOTLK has not been fully implemented by Blizzard so events cannot yet be created until they are. As such, the feature will still be disabled, like with TBC and Classic era until it is fully updated and implemented. This should hopefully happen in the first mini patch in WOTLK.
* This is NOT the pending major release. Stay tuned.

**VERSION R1.9297 RELEASE - February 22, 2022**

* Compatibility update for 9.2.0
* This is NOT the pending major release. Stay tuned.

**VERSION R1.9296 RELEASE - November 4th, 2021**

* Compatibility fix with 9.1.5, Classic 1.14, and BCC 2.5.2
* This is NOT the pending major release. Stay tuned.

**VERSION R1.9295 RELEASE - July 5th 2021**

* Compatibility fix with 9.1
* Minor bug fix for a critical issue in patching that needed to be addressed for some older accounts updating.
* This is NOT the pending major release. Stay tuned.

**VERSION R1.9294 RELEASE - May 24th, 2021**

* Fixed a bug that could cause the guild window to open when in combat and a new player joins - How annoying! This only affects Classic realms.


**VERSION R1.9293 RELEASE - May 22nd, 2021**

* Class coloring of the names should once again work in TBC.


**VERSION R1.9292 RELEASE - May 21st, 2021**

* Minor fixes for the public note in GRM Classic build and prevention of 1 Lua error


**VERSION R1.9291 RELEASE - May 20th, 2021**

* Typo fix pointing to wrong files in the retail .toc file


**VERSION R1.929 RELEASE - May 18th, 2021**

* Compatibility with TBC - also updates Classic - brings retail all into the same codebase.

* Another minor bandaid fix to some alt group issues until the major release is ready - 

Note: this is not a feature or bug update, but a compatibility one for TBC launch and unifying the codebase now. Larger update is pending soon, hopefully by June 1st (at least beta release on Discord).


**VERSION R1.928 RELEASE - March 9th, 2021**

* Compatibility release for the new 9.0.5 update

* Minor bandaid fix for some alt grouping issues. This will disassociate broken groups and you will need to rebuild them, but it is a temporary fix tile major release.

* Yes, this is the longest gap between releases ever. My next update is fairly significant and it is taking me a very very long time. It will be worth it. Join the discord channel for early access to beta within the next few weeks most likely


**VERSION R1.927 RELEASE - December 10th, 2020**

* Major bug fix for issue corrupting the log that has been overlooked since November 19th and can happen to anyone... BAD! Never before happened. If you have an in-game backup that predates this, or a windows backup, this can be fixed. It does not affect ALL people, but it effects enough to be a major issue.

**VERSION R1.926 RELEASE - November 27th, 2020**

***BUG FIXES***

* Pretty significant bug where some nested tables grew VERY large if you were experiencing a crash in a previous patch, so it built over and over. This cleans up the flaw and the database. Example, a 50MB database that experience this flaw would drop to roughly 10MB. It was a fairly big flaw, but it affected very few people it seems.

* Fixed an issue with some players not being able to patch properly from the previous update. This should resolve it.


**VERSION R1.925 RELEASE - November 24th, 2020**

***BUG FIXES***

* Fixed a long time bug that was causing the addon not to load for a very small number of people, and was basically the remnants of a very old bug that finally is getting quashed.

* Fixed an issue where a rank being renamed could spam the log more than 1 time before self-resolving...



**VERSION R1.924 RELEASE - November 22nd, 2020**

* Fixed a lot of errors in relation to last update

* Also - no more spammy notifications of addon being outdated... this should only occur once per session. oops!


**VERSION R1.923 RELEASE - November 20th, 2020**

* Minor bug fix that broke Classic


**VERSION R1.922 RELEASE - November 20th, 2020**

***BUG FIXES***

* Found an issue where the addon would not configure properly for some people who had remnants of an old unresolved DB conversion bug. This likely affects very few people but it should self-resolve now.

* Sync was crashing for many players with latest build due to a slight oversight in a change. This is now resolved.

* Sync was skipping syncing join and promotion dates as well in many cases. This is now resolved. Oops!

* Fixed the "Macro Rules" button tooltip on the mouseover window to now properly show status of of each macro rule category.

* The macro Rules button on the mouseover should no longer pop back up when editing the custom note.

* Demotions were not working in Classic. They are working now.

* Fixed an issue where export was not working... again!


***QUALITY OF LIFE***

* The macro tool will now attempt to properly validate that the promotion and demotion changes occurred at the end. It will inform you if they have been validated, and if not, then it will also inform you.

* Did a thorough cleanup of unused variables and global writes to ensure GRM isn't polluting the global space.


**VERSION R1.921 RELEASE - November 19th, 2020**

*FULLY COMPATIBLE WITH 9.0.2 UPDATE!*


***NEW FEATURE - MACRO TOOL UPGRADE***

**Promotions and Demotion Feature with Rules Added!**

*This has been a long time coming. While it may not seem that complicated, there were a lot of pieces under the hood that needed to come together to make this work, coupled with the less time I was able to spend on the addon this year due to RL obligations with work and increased time with the kids around due to schools being closed. I have to say, my vision for GRM has always been centered on a single principle, however. Does it make your life as an officer or a leader easier? Does it save you time? If so, I want it...* 

*I have been in guild leadership for coming on, I think, 13 years. I have been the casual leader, and I have worn the shoes of leader that hustles and promotes and recruits and grinds for status and rank. At the end of the day, the one thing in leadership that never changes is the opportunity you have to build your guild how you want to and get to experience the game how you want to. That's the main reason I do it. I get to build my guild and shape it with the culture I wish to have. But, there is one caveat. Time. The more time you spend doing administrative work, the less time you get to actually "play" the game, to join events with your friends and your members of the guild. Coming home after a long day at work, sometimes you'd rather just jump into some BGs with friends than have to spend an hour doing busy stuff. I get it. That is why I know that this "macro tool" here is more than just a "feature" of an addon. It is something that can help you leaders get back some of your time that gets lost into the black hole of administrative obligations forever. Burnout in leadership is a real thing. If there is just a small way I can help lower the burden of leadership, I am happy to be a part of it.*

**PROMOTIONS**

![Matching to Promotion Rules](https://i.imgur.com/PCUMGII.jpg)

![Unconfigured Promotion Settings](https://i.imgur.com/WhNgVwC.jpg)

**DEMOTIONS**

![Matching to Demotion Rules](https://i.imgur.com/QNSyRbK.jpg)

![Macro Button Improved Tooltip](https://i.imgur.com/zDg9lQB.jpg)

Bring up the Macro tool with any of the following SLASH commands.

```
/grm macro
/grm tool
/grm kick
/grm promote
/grm demote
```

**NOTABLE FEATURE ABSENT FROM MACRO TOOL**

* Rule sharing among officers. You cannot yet sync the rules to all the leadership in a guild. This is planned and coming very soon. I wanted to get this released first!

* I have plans to add an option to move all alts of a toon to the same rank of your choice and it will build a combo demotion/promotion macro if necessary

* Misc requests on filters... I am getting to them. Wanted to get out core tool ASAP for 9.0.2 update.

***NOTE*** - Please report to discord any errors you encounter, bugs, or recommendations for filters. There is a lot of overlap between the rules, but I did center the promotions to prioritize time at rank with demotions prioritizing inactivity, though you can customize your rules however you please.


***BUG FIXES***

* On exporting players, the column "headers" were not showing even if checked. This is now resolved.

* Issue with the verified promote date in some weird edge case getting set to nil after a sync, which then breaks future syncs. This shouldn't occur now.

* The new sync process, while much more efficient, can have a slightly longer behind the scenes "pre-check" of the data before identifying what needs to be sync'd. This time delay was not taken into consideration for so an error check was being triggered too soon, not to account for the change, causing sync to error in large guilds, whilst work perfectly fine in smaller. This should no longer happen.

* Fixed an issue if people had certain regex code in their player notes it now properly parses in consideration of the escape char so it doesn't fail in localizing log entries.

* Fixed a bit of a logic flow issue in the macro tool for kicking players if you were using the option under the rank selections to kick a player even if they were active, but still at a rank after X amount of time. It was overriding the main kick for inactivity and it doesn't seem to make sense to have both enabled, so now it is just one or the other. Furthermore, there was an issue where the actual epoch stamp was being set as the server time, not the actual date, so I fixed the logic issue, then in the "patches" the addon parses the entire databse and rebuilds the epoch stamp for all the rankHistory points by converting the string (text) timestamp to the actual epoch date in seconds. This may cause the patching process on updating the addon to the latest version to add a couple of seconds to the process.

* Fixed a bug that could occur where if you have global control set to NOT add the Join date to a player's note, but then you manually change the destination, like custom note instead of default officer... it was re-enabling it globally, but disabling locally. This is now resolved. It will only affect a small number of people as this was only first reporeted recently and it has been a long-existent bug,

* Fixed an issue where the rank being renamed was not reporting correctly. The addon will also detect the rank changes more easily, even if a rank was renamed that had no players in that rank. Before it was detecting a rank change if an existing player in that rank no longer had a matching rank name, yet the underlying rank index had not changed. Well, this could create some potential for oddities, like if a rank name was changed and no toons were currently members of that rank, GRM wouldn't notice. Another is that what if you changed the "new member" lowest rank name, then they joined the guild, well the addon didn't know how to handle that properly since the new member shows new current rank, but doesn't have a previous rank name to compare against. So, I rewrote the whole logic to be just a bit better and reliable in all instances of name change detection.

* The "Group Invite" button on the GRM mouseover window should now work with the new 9.0 API changes

* Fixed a bug with the macro tool setting the rules where you could uncheck all 3 of the radio buttons at the top for "all, alts only , mains only" - This should no longer be possible.

* Fixed a typo on the audit tab mouseover tooltip.

* Fixed an issue where if a player was holding on to a guild name with say an alt, so they could namechange a guild to it later, then they disbanded that guild then renamed their main guild with the name of that guild you just disbanded, then GRM was failing to detect the namechange as it was still finding the name in the database. GRM now properly compares against the guild GUID (the clubID) so this error should no longer occur.

**POST BETA BUG FIXES TO LIVE**

* Previous BETA update there was a fix needed to an old flaw that was found in how some epoch dates were stored in the rank history. This fixes that Beta bug for people who were using Macro Tool in beta. So, all the epoch stamps were reformatted and rebuilt to be sure they were all accurate using a Text string to integer epoch stamp formatter I wrote. However, if the string date was determined to be invalid I placed just an empty value there in the rank history as it was a sign of the old bug. Well, this is a problem for nested ranks in the array. If it was just the first rank ever, no biggie because it would just show the mouseover window for a player to set the promotion date, as if it was never set. However, if it was a later change, now I have an empty value which breaks some of the later logic. This update goes and recorrects this oversights and fixes those promotion date errors where you might see just an "!!" and nothing else there.

* Player Status should now properly show on the mouseover window. Anyone know how long this was not showing? I don't know when I broke this lol

* Fixed some behavior on the macro tool rules as it was not consistently disabling and enabling certain rule filter options when editing them.

* Fixed a BETA only bug where the timestamp formats were not showing correctly.

* Full "Kick Banned Players Still in Guild" is now fully working. If you a ban a player, or ban all of their alts, the main GRM window's BAN tab will show you all of the players who are banned but not yet removed from theh guild. In this case a button will appear giving you the option to kick all banned players. This will automatically bring up the macro tool and be ready to go.

![Easily mass kick banned players still in guild now](https://i.imgur.com/7HKwGjm.jpg)

* Fixed a bug where the "zone" and "time in zone" info was not disappearing underneath when editing or adding join/promo/birthdates. It would disappear and immediately reappear. It should now properly hide and reappear when completed.

* The text indicating how many times you need to press the macro key now reflects properly, including all the extra times as necessary if a player must be moved multiple ranks.

* Fixed a major issue with the macro demotions not working on merged realms. I have now gotten it to work on the merged realms, but there is a special condition that needs to be considered for guilds that have multiple players with the same name but from different realms in the same guild. Blizz does not handle this well so players will be informed on that rare edge case scenario that they will need to manually demote the players in the guild if they have the same name. Let's hope Blizz eventually revises this.

* Players should no longer be able to EDIT a macro tool rule if they don't have permissions set by guild leader to promote, demote, or kick

* Fixed an issue where if a player had a "verified" join or promotion date, if they left the guild and rejoined later, those old verified dates were not changed to their new ones. Even worse, if the new Rejoin date could not be verified it would keep the old verified date, so now the addon thinks a rejoin has verified info but they do not. The database has been cleaned up to people who have mismatching verified dates from their rank and join date histories. Be warned, you may end up with a few names that appear on your audit list again as not being complete, but this is just because it is wiping out incorrect data to begin with. This was actually a fairly significant bug. This same bug affected both promotion macro tool "time at rank" checking, and it also affected the advanced join date tool as being inaccurate for some players as it looked at the incorrect dates.

* Fixed a coloring issue of the system message in chat when a player goes offline. The parentheses was coloring the name of the player, if you were showing main and alt... looks clean now!

* Fixed a bug where the (Alt) and (main) tags on the mouseover window could overlap if you right-clicked someone on the alt list and set as main.

***QUALITY OF LIFE***

* No longer is just the "(Main)" title showing on players windows, but it now also shows the Alt title, though a slightly different chromatic shade.

* Huge cleanup of no longer used or duplicate strings from the language locale files. Special shoutout to @Mythos#7392 (Discord) for this huge cleanup (as well as some updated German translation work!)

* Macro tool - Cleaned up some of the rank selection, added some tooltips as well for the kick. Basically if the rank is equal to you or above you, it is now red indicated you cannot kick players from that rank, to prevent any confusion as to why they are not showing up in the list.

* Patch 8.3 introduced a bug that was causing disconnects of players, but not due to GRM, because of an error in coding on Blizz's end. However, the bug was very niche in who it targeted. It literally ONLY affected players in a guild who were officers with access to the new guild recruitment system. You see, it was firing a call to the server for information, and you were getting the event firing "CLUB_FINDER_RECRUITMENT_POST_RETURNED" - Well, if you kept the community frame window open the calls to the server snowballed to the point of sending hundreds and even thousands of calls a second, eventually causing the server to boot you offline. It was largely looked over because it only affected the unique situation of an officer who had his community window open to the guild page for 5-10+ minutes. So, as you can see, leadership in the guild could easily find themselves getting bumped, but it was a non-issue to most players. @Xulu on discord re-investigaed this bug to see if Blizz had resolved it in 9.0, which they have, so the temporary fix that I implemented to protect against these disconnects for GRM users is no longer necessary and it appears that Blizz has finally addressed the underlying code. That code is no longer necessary.

* The macro tool macros can now be spammed without risk of double spamming it. I added a protection against it by clearing the macro immediately after use so that you cannot spam click the macro again as you wait for it to be rebuilt. Current PCs it should rebuild the next macro within 0.025 seconds of clicking it, but there are people that like to mousehweel-hotkey their macros, like myself, and with the Logitech free-spinning stuff, I can punch out like 100 clicks a second, easily. So, now you have protections in place against it. This was probably a non-issue for most people.

* Removed some of the logic I added to the days/months selection in the macro tool. I realized how much I hated it auto-changing the date to a bigger number if I swapped back and forth on month and day. It was supposed to help be more convenient, but my guess is I coded it in a half stuper of sleep originally and my brain thought at the time, probably 2 or 3am, that it was a good idea. Ya... it wasn't. I purged all that logic now.

* The "safe list" you could put players on to ignore kick macro rules hav now been expanded to support promotion and demotions as well. Furthermore, you can also create a custom "extension" period of time where they will be removed from this list after X days expire.

* Github Readme has been updated to reflect addon features as well.


![Safe List Configuration](https://i.imgur.com/LsALIVk.jpg)



**VERSION R1.913 RELEASE - October 18th, 2020**

***BUG FIXES***

* Exporting only the alts should now work. Before it would always just show the mains even if you selected it to filter to only the alts.

* Fixed a bug where scanning for changes was causing a lua error when detecting level changes within a certain range (new bug from last update, minor oversight)

* Fixed an issue where if you were trying to export your guild roster it would error due to a 1 index overflow error of the array. I had modified the array to be more efficient for sync purposes, but forgot I used the same system on the export data and I had eliminated an index of the array that was not necessary, but now it causes the data to shift by 1. This shouldn't happen anymore.

***MISC***

* Building some custom function wrappers for Blizzard API to make a single codebase easier to deal with in the future since it doesn't seem Blizz is bringing the underlying 9.0 API to Classic anytime soon. The Naxx Classic PTR build does not have any of the 9.0 changes so just prepping adaptation.


**VERSION R1.912 RELEASE - October 18th, 2020**

***BUG FIXES***

- Fixed an issue where in some cases where if someone syncs data to a player through custom Note, it would update it, even if their rank was too low. This shouldn't happen anymore. Also noticed in some cases the cusotm notes were only going one direction. If the person initiating the sync had them, then the other could get them, but if they didn't they weren't getting them unless the other person initiated sync. Oops! Now it will properly work both sides.

* Minor oversight on the level squish. The log will no longer report that people leveled to a negative number...

* I noticed that in retail the /grm scan was taking a while to complete as it was not querying the Guild Event Log to process, it was doing the "classic" method, so there is now a condition for the build version and a manual /scan should now only take a few seconds to complete.

* The full proper sync file is attached now - uploaded an incomplete build one last time as I hadn't pushed changes to my "release" folder yet. Oops!


**VERSION R1.91 RELEASE -- October 13th, 2020**

* Minor fix with the player level filter range. If you were filtering levels > 60, it would error. Latest update resolves that.

***MASSIVE UPDATE FOR 9.0 Shadowlands launch!***

*The addon is now fully compatible with the new expansion and all of the underlying code and UI changes that came with it. You will find MANY of your old addons that have long worked for many years, even though they have not been updated, stop working this expansion. GRM should be working day 1. Hurray!*


***QUALITY OF LIFE***


* The Options for level filtering has been updated to match the new expansion in the GRM > Options > Scan tab

* If you choose 24hr or 12hr timing, the log will now reprocess the strings and update the timestamps to reflect the new formatting. This also applies if you change the timestamp format to a different one.

* Birthdays being included in the audit will be turned off by default now since most don't use the feature. This only applies to NEW GRM users, so veteran GRM users I have not undone any of your settings already in place.

* SYNC changes:

* * Data on the back end is now significantly more efficient and breaks down the entire database in a pre-sync comparison check on every piece of the data. Before, I broke it into blocks of 40 chunks of data for comparison, and if any pieces of info in that 40 was not the same it would compare all 40 between the 2 players just to find the 1 change. The concept finally has been expanded and now I do an exact 1:1 data point comparison pre-check between players before initiating a sync which ultimately makes it significantly more efficient, though it might add 2 to 4 seconds in pre-check sync time in very large guilds. The overall efficiency should cancel that out, however.

* * New option to delay when sync occurs after logging or, or to deactivate the auto-trigger altogether. You can now set the sync to trigger any period time after logging in from 10 seconds after and onward. For people that may have lots and lots of addons, or possibly are playing on older hardware, or maybe a netbook or something that might take longer, they can adjust it so the addon will restric any sync attempts until after the input number of seconds. The default will be 60 seconds after logging in, but some may wish to push earlier and some may want later. I personally set it to 15 seconds. I know one person would prefer it only loaded after 2 minutes. The choice is all yours now.

* * GRM will now go out of its way to prioritize other addons' data use on the comm channels. GRM data is not really that necessary to be needed instantly at all times, unlike many other addons, like say, DBM. So, with the server throttle limit, the last thing I want is GRM to clog up the channels, especially in a super large guild, and force them to the back of the que. As such, the sync algorithm has been updated that if any other data from other addons gets qued up GRM will delay its own sync data, allowing the others to pass through, then continue back on. This should eliminate any delays with other addons and hopefully eliminate any issues that might occur with addons clogging up the channels together and thus causing the throttle cap to be broken and in some cases, disconnects to occur. While I have not heard of any reports of disconnects in retail, there does seem to be some conflict with a couple of CLASSIC addons as to make this a possibility.

* Russian Language is now fully translated with the exception of just a couple of brand new lines I snuck in at the last minute. I also spent significant effort to ensure universally compatible UI formatting so no text was overlapping off frames and fit in buttons and so on.  TY @Максим on Discord for the translation work

* Global controls were previously restricted that once set, only the guild leader could edit them, unless an officer manually removed the global control settings tring in the Guild Info. This restriction has been loosened so that any officer in a guild that has access to edit the guild info can now change the GRM settings that are "Global Controls." If the string of control tags is already exported to the Guild Info then they will automatically be updated as you make changes to your global settings. Be aware that it can take up to 60 seconds for the guild Info to refresh for other players in Classic, if they are not directly looking at the screen, so other players may not immediately receive the global control changes, but they will shortly. Retail it can update within 10 seconds or less and GRM sends out a call to other players informing them that a change has been made and to re-check the global control string for quicker updating.

* I noticed that on the public/officer note Blizz has some algorithm that actually changes note fonts on the fly. It detects if you are using cyrillic characters, Asian, or a combination, and then it sets the note font to an appropriate compatible one. It ONLY uses the horrible looking unversally compatible font if you give it a mess of various characters to screw with it, otherwise it sticks to the FrizQT fonts and the Cyrillic compatible one and so on. GRM's custom, officer, public note fonts will now mirror whatever font Blizz is using in that moment for compatibility. In the future I will likely give you the option to ignore this and just use the custom font, but for now I've been getting too many people who have mentioned some guildies with "???" in their notes, indicating incompatible font.

* Players now have the ability to disable the message "PLAYERNAME tried to sync with you but their addon is outdated. Remind them to update!" -- While useful, there are some cases where a player just doesn't upgrade and rather than spamming you once per session day after day, you can disable the notification to chat.



***BUG FIXES***

* Fixed a weird edge case where if you invited a new alt to a guild and immediately promoted to guild master, it could cause your next session not to load properly.

* Reprocessing the log when changing languages was causing an error due to processing the new log rules message in a new way - this has been fixed

* Fixed a Lua error that could occur if player performed a hardreset to do the on logoff handler.

* Fixed an issue with the Advanced Join Date tool where if you had a format where the month > 12 it would error out on parsing as it was not doing a proper boolean check that the month integer was valid and between 1-12 when passing through the enum.

* Fixed an issue where if you create a new toon, and before joining a guild, you logoff, then when you log back on and join a guild, it now overwrites your settings on all alts for that guild. This should no longer occur.

* "Add Join Date to:" should now properly translate in the Officer Options tab if you use a language other than English (and the accompanying translation has been made

* Added several missing localizations to the localization files - they were all just in the raw English and not being wrapped by my localization function.

* When swapping between languages I noticed some of the options dropdown menus were not updating to new language properly. They now should properly localize with the rest.

* (CLASSIC ONLY) - The roster class coloring was not working when you changed it to player status. It now works on both roster view options! Oops!




**VERSION R1.895: Sep 12th, 2020**

* Final issue found to resolve issue when Blizz does massive new server merge.

**VERSION R1.894: Sep 11th, 2020**

* Fixed a bug in relation to previous release... the rush out was a bad idea as I placed the code *before* the variable was set when calling to it. Whoops! Your addon should now properly pick up when people Live join the guild without erroring.


**VERSION R1.893: Sep 10th, 2020**

* Found an issue with the recent mass server merges where the server keeps firing a player has joined the guild, yet they are already in the guild. This is a hidden "system message" but the GRM addon is picking it up and assuming it is someone joining the guild live. This now accounts for that possibility. I wanted to get this out asap as it can mess up join dates for people and it got reported early. It's happening when people log in on that toon for the first time.


**VERSION R1.892: Sep 8th, 2020**

***BUG FIXES***

* Fixed a bug that cuased the patches to fail if you haven't loaded GRM in a very long time due to just a simple variable typo

* Setting a new ban would cause an error on other's GRM versions in the guild as it had a parsing error on the comm message. Normal sync would work. This would only affect live changes.


**VERSION R189 DATE: Sep 5th, 2020**


***QUALITY OF LIFE***

* EXPORT UPDATES: 

![Export Tool Improvements](https://i.imgur.com/J3RS4v0.jpg)

* The Export window has been rebuilt. I realized it doesn't make a whole lot of sense to go from right to left. Why is the export copy window on the left anyway? lol - So, I rearranged it a bit and slightly expanded the height to make room for possible future export options.

* - Comma added as a delimiter in the EXPORT of data. Note, if comma is selected, since the alts are included as a comma separated list in the same column, the alts will be separated by semicolons, but only when comma delimiter is selected. Also, log entries the colon will be replaced with semicolon on all of them, so as to not mess up the columns.

* - "::" , "|" , "\t" all added as exort delimiters. The "\t" is representation of a "Tab" - if there are any formats you would still like included, please let me know. TY!

* Added the option in the Member/Former member export to only export players that are listed as a "main" in the guild, or the opposite, an alt.

* Added an additional option to mass check all or uncheck the member export filters. There's 17 buttons so it is a bit tedious to go through all of them 

* Added the ability to export the "Rank History" of the player to the export info as well. This sort of messes up your old columns a bit as it didn't make sense adding this to the end, just be aware this inserts a column. Also of note, this only includes the most recent 10 rank changes. If someone has like a 50 rank change history, it is just too much text spam for export and will not be included. This shouldn't be an issue for 99.99% of the community.

* When exporting the member details or the former member details, the delimiter is no longer included at the end, as it is unnecessary and ultimately creates a new empty column.

**-----------**

* MACRO TOOL RULE UPDATES:

![Macro Tool Improvements](https://i.imgur.com/PdlJqo0.jpg)

* The Macro tool has essentially been reorganized from Left to Right, instead of the backwards order it was in previously. Great idea @Vishal. Oh and, the text explanation has been updated a bit with the macro being built, to make hotkey use more obvious.

![New filter rules can be added](https://i.imgur.com/S8sMUTY.jpg)

*   - Apply specific rule to All, mains only, or alts only.

*   - Now you can match notes that are just empty - Thank you to @ManuelSifredi on Github for the idea and the contributing to its implementation into GRM.

*   - Activity filter at speicif rank(s) regardless of activity level. In other words, "If player has been at Initiate for x days/months" - it will recommend to kick. Easy way to keep track of purging players who never meet standards for promotion after X amount of time, even though they log on regularly and are not actually "inactive"

*   - Added Guild reputation filter - Set the filter to players less than, equal to, or greater than a specific rank (Disabled in Classic)

*   - Added a new custom message on the kick rule filters - Want a custom message to also appear in your log when this rule is flagged? Now you can set one, up to 80 characters in length.

* Recommend to kick log entries will now have the names properly colored to match their class.

* Cleaned up some text reporting in the Macro tool tooltip for plural and singular cases

* To remove confusion, if the player does not currently have the ability to remove people from the guild, they will no longer receiver the default kick recommendation notices, and they will also not be able to waste time trying to build rules in the macro tool until their rank permissions are expanded. Not that they could even use the macros before, as it would just fail and say unable to remove a player at their rank, but not it just informs them the feature is disabled and restricts the ability to build the macros.

**-----------**

* Since the occasional accidental click of the "Show Mouseover" button can occur, given its position at the top of the roster window, and in proxiity of the log and macro tool buttons, if unchecked the text will now display as red and make it more obvious to see.

* Updated some missing frames to skin for AddOnSkins ElvUI  as well as added compatibility to the Group Info GRM Module. Fixed an issue with ElvUI AddOnSkins where the Log Extra options/configuration was getting pinned back in original location. Also updated some missing reskins, and the new ones. TUKUI also has accepted the latest updates.

* Update the font of the Public, officer, and Custom notes to match the built-in font used by Blizzard "ARIALN.TTF" that is essentially a universal UTF8 font compatible with all possible characters. It's not as pretty looking, but it basically eliminates the possibility of people adding characters to their notes tht end of showing ????? in stead. Of note, this won't change the reporting to the log, so you still need a compatible font in your log on note changing. This also applies to the export window so it reveals all text appropriately.

* The "Custom Notes:" on the mouseover window now says "Custom Public Notes:" so as to eliminate some confusion about this note as being public vs officer use only.

* When a player rejoins the guild the "Date Originally Joined" entry would include the hour of day as well, which is generally unnecessary. This is now removed. If you wish to reprocess all your old log entries, just change the language to another in the settings, then re-change back. Otherwise, it will only be updated on New entries.

* The text should no longer overlap the checkbox to ban the player when you are removing a player from the guild manually. This seemed to not be an issue for most people.

* Updated some German translation work. TY @Mythos for that commit. Also to @zeatt for the line improvement suggestion as well.

* The tooltip over the Sync option about sending outgoing data to all, but restricting incoming data, has been expanded to clarify chance of misunderstanding, as well as updated the tooltip as the Custom Note part was outdated.

![Default Tab Opening Selection](https://i.imgur.com/XuwpNij.jpg)

* Added a new option. You can now select a "default tab" to auto open everytime the core GRM window is open. No matter what you close it on, the next time you reopen it will auto reopen to your default selection. The dropdown choice will allow you to choose any tab as your default and the option can be found on the bottome left of the main "Options > General" tab.

![Audit Tab Incomplete Counter](https://i.imgur.com/hjAVkiG.jpg)

* Audit Tab now has an number indicator revealing how many are "incomplete" without needing to actually click on the audit window to see. The tooltip was also updated to assist here.

![Keep track of your progress easier!](https://i.imgur.com/Hs05WRU.jpg)

* After the first sync there is now an "Audit Report" on the % complete in the guild, and how many members are incomplete.

* Added Compatibility to the "LOIHCal" Addon - On the calendar, the side LOIH window would overlap the GRM alt details window, so if you have this addon installed that issue is now resolved and takes into consideration whether you have LOIH set as an overlay on default position, or beside the original window.

* Some decent code cleanuup which was a decent amount of time but overall lowers fingerprint of addon. You may not notice honestly lol.

* Normalized the interact distance of all "Check Buttons" in all GRM settings and frames to have their "hit rect" interact range be the exact same distance of the width of the string. It scales dynamically as needed, matches the font size, and I wrote a script so it scales it accordingly for perfect matching regardless of the language selected. This is a fairly decent quality of life improvement that took a little time, and maybe people won't notice, but it is significant enough to merit the time for it!

* Before, if you mass shifted a rank, the addon would mass spam you of it, even if the ranks were the same name, just indicating a slight difference in guild rank "integer index" - I've added some logic so that it will ONLY report when players do actually change ranks, even if you mass delete or add ranks and they shift up and down. The reason this seems simple on the surface but under the hood is a little more complicated is because Blizzard allows guilds to name ranks the very same name, so there have been several people in guilds I have encountered that want to know when people change rank, as they name all ranks the very same name (I know lol). So, I basically just added the hidden integer of the rank to tag them, but if there IS not muultiple ranks of the same name, it can be safely assumed the entire rank merely shifted and the spam can be silenced from reporting to the log.

![Shift ranks up and down easily](https://i.imgur.com/Dyp0uxo.jpg)

* (CLASSIC ONLY) - The Guild Control Rank permissions window, the guild leader now has the ability to mass shift ranks up and down with the click of a button, rather than needing to rename and then mass promote/demote.

* (CLASSIC ONLY) - The roster class coloring (which can be enabled and disabled in the GRM UI Options), has been expanded to include class coloring of the names in chat as well.


***BUG FIXES***

*NOTE: I am only mentioning the more notable bugs. There was a LOT of little things cleaned up and found not reported on here.*

* Fixed a MAJOR issue where names can become disassociated from an alt grouping during a sync. This can also affect mains being removed. This only occurred during a sync and should no longer be an issue. This was a very weird and latent issue that had been slipping by for months so it is good to finally be rid of it. Took a bit to track down. Thank you for the many reports that finally helped me trace the origin of it!

* Fixed an issue whre the "Active" and "Offline" status could pop up erroneously on players that were not actually currently online. It would happen if you had the calendar window open

* Issue that could arise in compatibility with some addons on adding the main tag to the chat should now be resolved, though I haven't tested this well. This should eliminate possible frustrations any addon devs might have wtih compatibility issue. I should note, that there are some major addons out there that are far more popular than GRM that do not even bother and just rely on their status as being so dominant. This is not well tested but I'd be curious to hear of any reports if the solution was not sufficient in some cases, though in theory, it *should* be!

* Fixed a bug that could occur when setting the global controls to the guild info that would say the string was too long, even though you had room. This is because it was rebuilding it wrong and appending an extre "grm^" at the front. In other words, you might end up with *grmgrmgrmgrmgrm^* before the other global control tags. I'd double check them to see if this has happened to you. In most cases it will not be an issue, but you may want to cleanup if wasting characters.

* Fixed a bug where resetting to default the "Only show on log changes" on the General options was only resetting using the scan reset default tab button.

* If a player had ElvUI installed there was some error that was occurring when logging off or reloading. It will now no longer happen. It was just triggering an unnecessary call to set a keybind on logoff while the. I never noticed since it was getting dumped into the previous session log of errors. This will no longer happen.

* GRM was overriding some tooltip scaling, but only if the tooltip size had been altered by an alternative addon, like Tiny Tooltips, and it would only happen only on the first time you loaded the GRM options. This must've existed > 1 year and only 1 reported this lol. It is now resolved as it only was noticeable in some cases anyway!

* Fixed an issue where the UI Scaling buttons in the GRM Options could overlap at the bottom if your were using certain game resoletions.

* Fixed an issue where an update is required, but a player has logged onto a newly created toon who has never logged on to GRM before, thus it encounters the update and has no profile to build off of and thus fails on a settings check and thus appear to reset all settings again, but if you successfully complete that session without realizing it it would then write over your old settings due to the Lua error, assuming the current settings were what you wanted. Oops!

* If swapping languages or date formats, the addon would reprocess the entire log to new format, or translation, but in some old old ban formats it was failing as it was set to the wrong index identifier as an unban. This will now auto-fix and resolve.

* Fixed a bug where sync could fail on some occasions when syncing the "main" info as there was an incorrect insert into a table, instead of setting a value as an integer, causing arithmetic lua error. 

* Fixed an issue with major updates of people who have significantly large databases never getting through the update.

* Fixed a critical issue that would allow people with a certain bug from a long time ago, or far earlier version, to not be able to update the DB and thus GRM would be unfunctional without a full reset wipe of their data. This resolves this. Of note, this affected a very small number of people, but even 1 person is enough to need to resolve it.

* Danish/Dutch translations were missing a whole giant block of text strings so you would get spammed with errors. The translations are not really complete so not sure if anyone even noticed lol

* Found a bit of an edge case that could affect both retail and classic, but in some circumstances, after opening the calendar (in retail), the scanning would break it's loop and never actually scan for guild changes in the background within constraints of the time delay between checks. This could happen as well in Classic but is triggered in another way. Weird never to notice til now but it happened to me which caused me to track it down. This was actually a bit of a hunt and a lot of work for something that might seem so simple.

* Fixed a bug where it was refreshing and reprocessing the macro tool "rules" before confirming save of the macro filter rule. It was redundant as no changes had been saved, but wasted resources.

* Fixed an issue where sync could fail and get a lua error.

* Fixed an issue where it was not reporting the proper "time passed" since they had been in the guild when they were removed in some places instances of log reporting.

* Fixed an issue where you could not "reset defaults" on the Macro tool if you had removed all the rules. It would technically add it, but you would have to refresh the window manually before it updated and it would Lua error every time. No longer!

* (RETAIL ONLY) - Events added to the calendar already should now properly be auto-removed from the list of events to add for players who did not do them. It scans the calendar and verifies if the events has been already added and removes it from the queue if so.

* (CLASSIC ONLY) - On the GRM mouseover window you could click to edit the public note, and it would let you type it in, but if you didn't have permissions it would just not do anything. Now you cannot click the note to edit if you don't have a permission.

* (CLASSIC ONLY) - Roster coloring was sort of flickering a bit and when you clicked down it could reset and only rebuild after releasing mouse. It now hooks into the build function of the frame and essentially inserts itself to override the Blizz coloring completely now rather than updating after the fact. I can't believe how often Blizz fires that functin though... it is very spammy on the back end lol.

* (CLASSIC ONLY) - ColorPicker should now be properly draggable in Classic. It was erroring out due to a frame name difference. Small oversight with Classic compatibility.



**VERSION R1.881 DATE: April 30th 2020**

***NEW FEATURES***

**PLUGIN FRAMEWORK**

As time has passed, GRM has really grown to be a fairly large addon, ever growing with more and more features. While I attempt to focus on features that are within the **scope** of guild management, I find that there is room for a little bit of grey area feature support. Furthermore, I find that in many ways the overall addon can be useful for all players, but there are just some features that are completely unnecessary unless you are an officer. So, in an attempt to keep GRM's core from growing *too* bloated, I built an underlying framework to support my own "modules" - plugins, so to speak. Some things are just going to be far too niche for many guild members that there is just no reason to bloat the core addon with those features. I will use them, many leaders will use them, but maybe they will be better suited for a smaller module addon to the GRM core. An example of this is my future plans for the new retail "Recruitment" system. Clearly this only has to do with officers, so in the future I have it planned as another module rather than a core addon feature. 

*Of note, if it still falls explicitly within the scope of the original core addon goal, that will not be compartmentalized off, but kept within the core of the addon. So, today I introduce the **first** GRM module!!!*

* New Options tab called "Modules" - and it will populate dynamically depending on if you have the module installed or not.


**GROUP INFO MODULE**

*If you are in a party or a raid group, you are now given a special GRM "Group Info" button you can mouseover - this will reveal various things about your raid group.*

* It will tell you the names of all the people currently in your group who are guildies.

* It will inform you if you are grouped with any *former* guildies. This particularly feature goes very deep in that it will inform you the date they left. It will let you know if they were previously banned from the guild. It will let you know if they have name-changed since leaving the guild. It will inform you of their known alts and if any of them are still currently in your guild.

* It will inform you of all the people you are grouped with that are on the same server, or a connected realm member

* Colored indicators will appear next to raid/party member names if you are within trade distance of the player. They will update on the fly. Yes, it can be disabled.

![Mouseover Information](https://i.imgur.com/MKwNQQv.jpg)

![Lock window, then mouseover each name for more details](https://i.imgur.com/Y6ySSca.jpg)

![Don't forget to check out the new Modules Options](https://i.imgur.com/M7ya4B3.jpg)


***QUALITY OF LIFE***

**BOTH**

* Re-translate the log on the fly now just by swapping languages. On occasion we have wonderful volunteers that submit translation work to *localize* the addon to your country. Well, the neat thing now is you can retroactively re-translate your log entries to the updates. Or, you can swap to new languages. Maybe you are tired of using English, which may not be your first language. Just swap to your native language and see the log auto-translated for you, if there are sufficient localization work done at least (any help here always appreciated). Of note, there are limitations here. If you have been using GRM for a long time, older log entries will not be re-translated as they are stored in just static strings as I was not yet storing any of the metadata to rebuild the log entries. Otherwise, the data to rebuild the strings has been stored for, if I remember, maybe the last 6 months or so. It is hard to express how much underlying work needed to happen to make this possible. I doubt many will use it as well lol.

* On the log entries where a player left the guild or was removed, it will now state if they were themselves the "main" that left. Previously it only stated if their main was still in the guild, thus identifying an alt as leaving. It is now more obvious if a "main" has left.

* Customization of the Log message coloring! That's right! You can now select and save your own coloring for the logs... particularly that pesky eyesore that is the "Recommendations" coloring! You can always reset to default. To get the color selection options to appear, just click the "Open Log Tools" button.

![New Color Customization for the log!](https://i.imgur.com/MaIpzjE.jpg)


* I removed the "NG" tag on system message names when people login or out - and I changed it to "Friend" as it just makes more sense. "Non-Guildie" I was needing to explain. I was originally just trying to keep the tag very small, but since it really only affects those limited system messages then "Friend" seems an appropriate tag

* The "Log Tools" button is now in a more obvious place. Many people seemed to not know there were additional controls for managing the core GRM log for your guild as the button was semi-obscure - it is now in an obvious place.

* The Ban list now has the ability to mass kick players who are on the ban list, yet are still in the guild. Just click the button (which will only appear as an option if you have players banned that are still currently in the guild), and it will open the Macro Tool with the names all populated in and ready to go.

![New Banning kick button](https://i.imgur.com/7o57y9d.jpg)

* MULTI-CHANNEL support for GRM reporting! The Custom Channel in the GRM > Options > General Tab you can now have multiple channels supported by separating with commas.

![Multi-Channel support](https://i.imgur.com/XKAjOye.jpg)

* The counter for the Macro Tool button above the roster, which states how many are ready to be kicked before you ever open the tool, will now properly update after a sync and if you remove or add any alts, as that can adjust how the rule applies to some. It typically only refreshes every 60 seconds, if visible, but now it is forced to update immediately on any of these actions so there is no confusion.

* Purged all unused and deprecated strings from the localization files now due to some modifications

***BUG FIXES***

**BOTH**

* Longstanding bug where alt groups had been getting disassociated on sync - this is due to a flaw in how the DB got updated for some people and I won't get into the specifics, but I had tried to bandaid it and it just was getting to the point of too many reports so I've basically had to take a bazooka to the problem to isolate and fix it. Unfortunately this has the side-effect of disassociating the alt groupings of any affected groups. The reason this had to be done is let's say in your group 2 different groupings of alts were affected and becoming associated/disassociated over and over. Well, the addon has know way to correctly identify which of those groupings was the accurate one. It can at least identify the inconsistencies, and the flaw, but not the fix, so it just purges all associations, and then the player will need to rebuild them. This should hopefully make that issue go away, yay!

* Export should now properly not include the birthdays if it is unchecked.

* Fixed an issue where the kickRules were not configuring properly

* Fixed an issue where if a player guild Name Changed it would cause the addon to not longer load properly.

* Fixed a bug where on some toons the game would crash out on early configuration of the addon. This is now fixed.

* Fixed a potential load bug for a player who possibly crashed in the middle of a large update previously. I ran a stress test on doing a massive overhaul where you install the first version of the addon, then the latest, and seeing how it processes all updates from the beginning of time. On one of my builds it crashed. It *might* just be some edge case as I couldn't recreate it on my 2 other accounts, oddly enough. But, it is accounted for and fixed even though I doubt anyone will encounter it lol.

* Fixed a bug where if you log on to a new toon for the first time using GRM it attempts to sync addon settings even though you have not even build the guild DB yet. It is a one-time only error and next session would go away, so that is my guess why I haven't seen it reported yet as it literally only affected first session of a first time GRM user, but this now should no longer occur at all!

* Fixed an issue where the Auto-Complete list of names when clicking it for selection to add to the Ban List (includes current and former members in the list), if you click it it was not properly populating the editBox for name selection. This is now resolved.

* Fixed a minor UI bug where if you were changing the font size the note, officer note, and custom Note would not update their font size until your next session or on reload. This now should happen immediately. I oddly had it wrapped in a protective function to prevent them from being resized and I have no reason why I did that however long ago lol.

* Fixed a minor bug in relation to the MainTag color select box not functioning properly in the General GRM Options

* The message when you tried to sync while grouped was erroneously stating you didn't have access to guild chat when it should just be stating sync was restricted while in group. This has caused some confusion and should now properly report why sync is not triggering while in group.

* Fixed an issue when the ban list syncs it wasn't storing the original player join date properly and not syncing some data as a result in some few cases.

* Fixed an issue where the Guild Info tag was not being checked as often as it should be for updates.

* Finally found the origin of that stupid bug that messed up some groupings of alts and it had to do with some stupid database diving that occured pre-DB overhaul as a prep for the DB overhaul, but deep and nesteed in the code I had a variable pointing to an int counter "r" when it should have been pointing to "s" and subsequent downstream mess occurred. Wow, funny how something so imple can cause so much hassle.


**VERSION R1.871 DATE: March 16th, 2020**

**Minor Bug Fixes**

* On importing the kick rules to new system, if you had it disabled, it is re-enabling it, except with inactivity filters disabled, which is bad because now it has created a rule which has all of your guild members selected as the only remaining rules enabled are "All Levels" and "All Ranks" - so you will get some spam lol. For new downloads this resolves that.

* Fixed a significant issue involving not being able to update the addon properly if you haven't updated from an older version pre-DB overhaul (so basically anything pre-January).

* Fixed an issue in retail wow when Ctrl-Clicking Audit and opening the old roster window it would force the window to the right and it never properly configured and reset the position. This will no longer happen.


**VERSION R1.87 DATE: March 12th, 2020**

***FEATURE RELEASE***

**Phase II Macro Tool Release - Custom Rules**

*My lenghty and probably unnecessary exposition that prefaces large releases*

Phase II has been a long time coming. As I began building the custom rules, the ideas began to expand. Initially I had sketched out some plans on where I wanted to go with the design, laid some groundwork, had some ambitions, and when I started building it my thoughts evolved and ultimately went a different direction altogether. Utility, user experience, and ease is generally what I find the most important and what I wanted this to be. This also took me a while, aside from the many real-life distractions and priorities I have had over this the last month, because I felt this feature was so important that I wanted to make sure I got it right. It's a lot of work and there is nothing more soul killing in design when you dump so much time into something, realize you hated it, and decide to start over from the ground up. I have been there. 

You see, just for a little insight into my personal behavior and thought process, when I am building something for GRM, even though I can be presented with logical arguments from others and rationalize to myself as to why some ideas are good, I have no joy in building them if they don't "click" for me. I want to feel them, to be excited to put it together. As this remains a hobby project for me, I have to get enjoyment out of it, and I really do. So, for a while I would start development again, start adding UI frames and I just felt no energy in doing so, no excitement, no deep feeling that what I was building was "right" for the job. The underlying code was simple and had already been built, but then came designing and integrating it in meaningful ways. There was no passion inside for it. I was not having fun doing it because I didn't have a clear picture of what I wanted. So, after chipping away at it, going back to the drawing board on some design issues, pruning out some unnecessary filters that made no sense (like I built a filter for race/class which didn't make sense to just say, kick all gnomes from your guild). I can now say I am happy with the final design (and happy for continued suggestions on further improvements). While it is my personal preference in design, I hope that it is an overall improvement for people that use the GRM Macro Tool as well.

*Phase III plans, with promotion/demotions are going to be that much easier because much of the underlying infrastructure for it has now been built and I feel like I can see light at the end of the tunnel as I think about finalizing the that project now that Phase II is out of the way.*

*/end exposition*

**PHASE II FEATURES**

![Phase II Release](https://i.imgur.com/PlSSQav.jpg)

* Ability to add as many custom rules as you want. Want to build a rule for each rank, for level ranges and so on? Not a problem. In fact, if you ever build a rule where this is overlap, the tooltip when mousing over a player in the list will show you which rules apply to that player.

* Ability to Enable/Disable specific rules on the fly. No need to delete them, just temporarily disable.

* Additional Rule Filters: Specific ranks you want the rule to apply, level ranges, and even if you want to add people to the list that have a certain text match in any of their public,officer, or custom notes.

* The rules are so customizable that you could theoretically disable all the rules and just have it apply to a specific rank, so all the people that are then recommended to be kicked would just be a certain rank. Have fun with it!

* Ability to name each rule whatever you want.


***QUALITY OF LIFE***

**FIX TO RETAIL DISCONNECT BUG THAT BLIZZ HAS NOT YET ADDRESSED (that will affect any officer even if all addons disabled)**

Retail 8.3 Disconnect bug has been temporarily fixed until Blizzard can get their act together and resolve it. I love Blizzard, and I love Warcraft, but having this disconnect bug go unaddressed by Blizzard for months post 8.3 release is just unacceptable. So, I have decided to build my own fix to address it. Note, this disconnect bug **ONLY** affects officers because it is directly related to having access to the new guild recruitment system. If you have the Retail Guild Community window open and you are on the chat tab that has your guild chat scrollable history, the game gets stuck in a loop querying the server over and over and over again about the recruitment info, to the point it snowballs into hundreds and even thousands of calls a second. Eventually it just overloads and the server boots you. You can see the exact spam yourself. Just type `/etrace` - open your guild window, be on the chat tab, and look for this event being mass spammed: "CLUB_FINDER_RECRUITMENT_POST_RETURNED."

The fix is all done behind the scenes and automatically, but it is merely a stop-gap to address the issue until Blizz fixes it on their end of the code with an update. Having dissected their own code on the community frame, this is *NOT* a difficult fix and this is why I find it particularly frustrating that they have not even taken the short amount of time to address this, as a single developer on Blizz's team could probably properly fix it before lunch time the day they investigate it.

**BOTH**

* To get around the restrictions on addons promoting/demoting - with a little inspiration from the "Guild Search" addon and @gankenz on discord I was able to finagle a semi-solution that is very limited. Ctrl-Clicking a player's name in the audit, or any other GRM tool will now fully bring up the player member details window that has the promote/demote - Of note, due to the lock down and limitations of the community frame, I can only get this working using the Classic roster. So, in retail, you will notice now that Ctrl-clicking the names will now only bring up the Classic roster (/groster or Ctrl-J to bring it up).

* AddOnSkins profile has been updated - scrollbars now working properly. Some unskinned frames have now been skinned. New Macro Tool Custom Rules is updated as well.

* Mousewheel now properly works for scrolliing up and down when hovered over the scrollbar sliders, not just the windows themselves.

* Audit window will now properly refresh on the fly when using the macro tool, if the audit window is open and visible.

**CLASSIC**

* Names in the roster are now properly class colorized, even if you swap the status windows. Also, the side details popout window the name is now colorized. You can disable this class coloring in the GRM > Options > UI tab if you really wish to have a more authentic Classic experience. I'd imagine something as useful and unintrusive as this most will not have as much of an issue with.


***BUG FIXES***

**BOTH**

* Addon was erroring and failing to report players rejoining the guild. It now should properly.

* Every major bug reported on discord has been resolved.

* Resolved a bug that could happen shortly after login when interacting with other GRM users to inform the player on *who* currently is online with GRM installed.

* Fixed an issue where if editing the custom note you hit confirm with no changes it now properly resets and hides the confirm/cancel button.

* !note rule restrictions should properly work again if you disable the feature.

* Players that share the same name as their guild should now properly be added to the guild - It was looking at the guild names if already added to the guild on accident rather than guild members, so mostly unnoticed bug unless you

* Fixed an issue in reporting rank changes if you deleted a bunch of ranks and people shifted up or down.

* Fixed an issue where if you went from not allowing people of any GRM version to sync with you to instead restricting it to only the current version as you, it now properly wipes names already approved for sync. Before it would continue to allow outdated versions to sync if you enabled this and would only reset on a reload or relog.

* CustomNote sync seemed to only be working one direction, depending on who was the behind-the-scenes sync leader. It now is going both directions and should properly update the custom note.

* Custom note was not clearing the note properly - the new update should now fix that, and on your next sync, should properly collect the changes of any custom Notes that have been removed.

* Promotion dates in some cases were not getting set when a player joined the guildm even if they were verified joins.

* Audit list should now properly show player data as "incomplete" if it is Unverified ("!!")

* Fixed an issue where the Ban list would not load properly if you had a combination of players banned both outside the guild and some still in the guild.

* Also found an issue with the ban list where it would, in some cases, be missing 1 name from the ban list.

* Fixed an issue with the Advanced Join Date tool where it was using unverified dates to compare to the note rather than the verified.

* Creating a new toon, the addon settings were not being properly sync'd when the newly created toon received an invite to the guild. It should now properly absorb existing settings if you have it set to sync settings among all your alts.

* Minor bug that could cause a Lua error when trying to populate the tooltip on the Addon Users tab

* Fixed an issue where on mass kicking a player with the tool it would sometimes report them rejoining and then being promoted.

* fixed an issue whre you can get occasionally double recording of when you kick a player from the guild.

* Fixed a lua error that could occur on the "Macro Tool" button if opening community frame within seconds of logging in.

* Fixed an issue where if you use the macro tool, if the actual built-in /macro window was open, it would close it, then the ESC key would no longer work to bring up game menu. This is no longer a problem and the ESC key should work just normal again.


**RETAIL**

* Fixed an issue where it would error out the localization of the Death Knight class name when adding a custom ban on a player no longer in the guild that happens to be a Death Knight Class.

* Fixed another issue where it would fail to set the GUID properly on adding a ban on a player that was never a member of the guild or you don't have any metadata record of the player, so when it builds it it was setting to the GUID info incorrectly thus it would erroneously say on the ban list that the "player is no longer on the server." This is now resolved!

* Right click should work again on the roster when setting main

* Found an issue where you could theoretically encounter 2 join dates and the 2 one is set at an earlier date. How it works is if a player joins the guild they auto join at the lowest rank. The addon will record that rank. However, if let's say someone joins the guild while you are offline AND they get promoted, before you ever record them, the addon will take note that they joined the guild AND they were promoted. Here is the scenario. Let's say the day that they joined the guild was > 100 events ago, thus the date is unverified. If that is the case the addon puts a placeholder unverified date in the history tree as the date you logged in. But, then the addon detects they are no longer the same rank so they got a promotion, and now addon checks and guess what, their promotion <= 100 events that occurred, so now it can accurately report the date. You end up getting the first promotion/join date as an unverified date the day you logged in, but now the 2nd promotion received is given an accurate date X time previous, thus you end up with a potential for 2 promotion dates to be recorded, but 1 of them to be today and the other to be further in the past, even though it was a more recent promotion. Silly nuance, would be rare to find, but definitely possible to happen if you don't log on very much or are in an extremely high activity guild so events get pushed through faster. 

* Fixed an issue where the promotion date was not properly getting added and the audit log was not reporting it properly even though the filters showed it was complete.


**CLASSIC**

* The guild export window the default button no longer overlaps the info on about the Guild Rep being disabled in Classic.



**VERSION R1.86 DATE: Feb 3rd, 2020**

*Post DB overhaul cleanup and a few other things*

My neighbor is a business manager for Cox and a wonderful guy. He speaks so highly of the company. With my own good experience as a customer, when I began looking for a new job, it just made sense to first check out Cox Communications.
***QUALITY OF LIFE***

**BOTH**

* New addon description and info written up on Curseforge/Twitch and WowInterface

* Guild Info control tag mouseover in the options is improved and now gives more detailed explanation of what each control stands for.

![Guild Info Control Tags](https://i.imgur.com/eKyVYiM.jpg)

* If global control settings are detected as edited by someone else, if the GRM user currently has the GRM options window open, it should now update properly on the fly to the new updates.

* If Global controls are updated, it will no longer announce what the Join/Rejoin tags are if the global control is set to not even use them anyway, as this can be a little misleading when it reports them as it almost sounds like it is implying they are going to be used even if it is disabled.

* Options Officer tab now has the Join date destination Radial buttons in veritcal alignment, which is cleaner.

* Main will now be tagged in the leveled up info, so it's more clear when a person levels a toon

**CLASSIC**

* Roster names will now be colored to match their class in WOW Classic, just like in Retail!


***BUG FIXES***

**BOTH**

* Major bug fix where the 8.3 release (R1.85) would not work for some players. Now it should.

* Fixed a fairly major bug where any Promotion date edits would be overwritten on sync in certain cases even though they shouldn't have been.

* Found a lua error that could occur when trying to modify the system message of a player that just logged on before the guild was configured. Now it will properly wait til it is configured before tagging main/alt/NG on system message online/offline messages.

* Right click context menu sometimes was not showing the correct buttons or was not spaced properly.

* Fixed an simple Message reporting error where if the player didn't have enough room for the Control tags it would state {num} instead of the actual number. It should properly state the actual number of characters that need to be cleared from the guild Info to make room for the control tags.

* ColorPicker should now be draggable. It was erroring if you clicked the header.

* Found a bug where IF you had a player who had a birthhday set, but was not linked to any alt/main grouping, and then another player was the main in another grouping, if you adding the player with the birthdate set to the grouping that had the main, it would successfully clear the birthdate to match whatever the main had, but then it would erroneously attempt to add an empty string timestamp to the mouseover window for the birthdate rather than hiding the text, in this very specific situation, and showing the button.

* Birthday sync was not obeying the restrictions.

* Fixed an issue where the online status would not properly update from offline/online when swapping and selecting alts.

**RETAIL**

* Right click on the roster to set main or set as alt is working again on the community frame guild interface.



**VERSION R1.85 DATE: January 27th, 2020**


***MASSIVE OVERHAUL***

*My single biggest code release update in the entire history of this addon, though maybe not as obvious on the front end.*

When I first built this addon I only imagined one thing, a simple log of changes. It had no other major interface. I built it purely with the intentions of it being a simple log of "what has changed since I last logged in" in the guild. This was important to me to track and I assumed I could build the thing in less than maybe 500 lines of code. I didn't even originally intend to make this addon public, it was just for personal use. However, some friends and guildies liked my very early version enough that they encouraged I do a public release, and down the rabbit hole I went!

Ultimately, this lack of foreward thinking and planning created some underlying issues in the long run. I built the addon in a very simple way that was not a big deal when it was small, and purely because the computational cost was so minimal to just use simple arrays and loop through them. When it was just my own simple guild and very little to check, this was not a big deal. As the addon grew and became more and more complex, as features kept getting added on, a level of multi-D array complexity crept in that became a pain to follow, and ultimately, it brought a level of inefficiency that caused resource wasting. Even worse, it made it more challenging to debug tool. I bandaid the database and increased lookup speeds by sorting the arrays and implementing a [Binary Search Algorithm](https://en.wikipedia.org/wiki/Binary_search_algorithm), but at the end of the day, Lua was built around taking advantage of associative arrays. I won't get into the technicality of this deeper, but just know that it is more like using a dictinary "key" in pair with the data you wish to store, and it is so much faster than scanning through just a traditional integer based array for the data.

So, as I kept building and building, improving, and enhancing things, I had this always in the back of my mind (thanks to @Xulu on Discord lol)... that one day I was going to have to go back and rebuild the underlying database(DB) and rewrite so much of this addon to take advantage of those changes. It was such a HUGE project that I dreaded it. I procrastinated it. I felt zero inspiration and motivation to do it. You see, at the end of the day, this is something I do for **fun** and it is really just a side hobby I find a lot of enjoyment with. So, the moment it becomes too tedious, a chore, or too draining on my life and it loses that fun? Well, that's the day I give it up. So, I avoided it... But, recently, as I was building on the addon more and more, with my major Phase 2 and Phase 3 releases ahead of me, the crushing force of revelation hit me... I was giving myself just more work to do in the long run. Everything I built now was just more work I had to rebuild later. It wasn't a matter of **IF** it needed to get done, it was a matter of **WHEN.** So, I relented, and the journey began. You could say it started off a bit melancholy and slow, wishing I was doing something else, but quickly I realized how enjoyable this was. The fruits of my labor were going to be so sweet. I could see the great benefits to myself. I could see how much of my time was spent fixing bugs that never would have occurred if the changes were in place, and no longer was this a dreary slog to the finish, but a fun and rewarding challenge that I couldn't wait to complete.

It took me more hours than I even dare try to tally or say here, but it was worth it. This all occurred in the midst of the house I was building coming to completion in mid-December, moving into the home, the holidays with relatives in town staying at the new house, a vacation I had planned because we were supposed to move in in November but the house got delayed a month, keeping my wife's rep at exalted as I worked on this when there was a nice "to-do" RL checklist in a new house that is enormous haha. But, here I am... finally! A massive underlying DB overhaul of the addon occurred. A massive rewrite of much of the underlying code to take advantage of these changes as well, and tons of other things peppered in between it all you will see below.

*Of note, the DB will take up maybe 5% more memory, at a gain of performance, so I think worth it.*


***WHAT IS NOT IN THIS UPDATE***

**PHASE 2 RELEASE - Macro tool Custom Rules**

* This is not out because even though I am about 90% complete here, I got distracted on this other major project and didn't finish it. It is my next priority, tied with updating the new recruitment system as a standalone addon next. There is SO many other things I addressed though in the meantime.

**PHASE 3 RELEASE - Macro tool Promote/Demote**

* These 2 phases are my core priority after this release. I know how important they are and how much of a quality of life improvement they will bring to the leadership, especially in Classic with that painful demotion/promtion system. These might seem simple implementations. They are not. They are substantial projects.


***QUALITY OF LIFE***

**BOTH**

* Restructuring of Global controls. The text string in the guild Info is now much leaner and takes up less space. Easier to parse and manage as well. Of note, this will not automatically remove the old string. This is because we want that old format to still be there until you get everyone properly upgraded, so only remove it once everyone is properly updated in the guild. You can add the new string in the meantime by exporting it from the GRM > Options > Officer Tab:

![Global Control Setting](https://i.imgur.com/opYCzdm.jpg)

* Guild Leaders can now edit the global controls from the Options interface without the need to go into the GuildInfo and delete things to edit them. This only works after first exporting the new control string to Guild Info. They will automatically be updated on the fly as changes are made. All other players, including officers with access to the Guild Info still will have those actions blocked from the interface and they will need to manually edit them.

* Players now have the ability to Globally Control adding the join date at all. Before, 1,2, or 3 index indicated which note destination to go to. Now, a ZERO will indicate the wish to disable adding join dates automatically when a player joins the guild. So, guild leaders can now globally disable the setting. Of course, this setting is *OFF* by default anyway.

* REMINDER - The old guild control tags will not be automatically deleted. I am leaving these up for you to remove on your own because if people are still using older versions, you may want them to obey those until they upgrade properly. Otherwise, you will need to re-export the new ones as GRM will not do it automatically for you as a result. I also added a recommendation reminder to add them to the GuildInfo as I think it is critical guilds get their players all on the same page with some of those sync settings.

* If guildInfo is too full and no room for global control string, the addon will now inform you the exact number of characters necessary to make room for the guild tags for global controls. Before it just said it couldn't be done.

* Huge rewrite of the right-click selection window on the mouseover window. The one where you set main/alt, etc. It should now remain properly and consistently sized with only selections that are important, and not lots of empty space.

* Added a new option in the right-click context window of the player mouseover. User can now set the promotion date to the same as the join, or the other way around. Now, when doing lots of configuring of newer players you only need to configure one of the dates, then either send it over, or pull it over, either way works. Just right click to see.

![Example of sending date over](https://i.imgur.com/EzLnxwT.jpg)


* Audit window has been adjusted slightly for a slightly cleaner interface to view and use the tools, and the birthday filter has been appropriately updated as a separate function and button and the one in the Options > UI, which completely disabled birthdays. I removed the green "Disabled" message as it didn't really make sense in the new interface.

![New Audit Changes](https://i.imgur.com/nZQYdzk.jpg)


* "Restore Defaults" buttons found on various pages, like options pages, Log tools, or even now a new one on the Export Tool page, will now only reset the settings to default of the page you are currently on. There is a tooltip option shown that you can still set reset all addon-wide by Ctrl-Clicking with a confirmation, but other than that it is easier than ever to reset to default for just those settings.

* The side checkboxes that filter the Log information, as well as what reports to chat will now only appear when looking at the log. There was no need for it to be visible on all the other tabs, but it was for some reason that just didn't click for me as being weird until now.

* In the JD Audit tool, it was not entirely clear at times that even though some players the join date should be moved or cleared or modified in some way, that this action was not possible because the default join date destination was already filled with a note and GRM errs on the side of NOT overwriting pre-existing notes, in case they are important. Now, it informs you that even though action needs to be taken, it will not because the note is full and it recommends manually making room. Furthermore, the JD Audit tool now shows the recommend "Steps" to take when going through the tool, starting from top to bottom.

* GRM will now auto-set a player to main if they are part of an alt grouping that has left the guild and they are the only remaining player in the guild

* Adding an alt should now be a little more obvious how it works. The "Press tab" now states "Press tab to cycle" as well as "Press enter to select". This was not super clear for new users. Also, I have include a top right close button now. Before you needed to Press the ESC key or click off the window. Now you can also press the close button if you prefer. Just makes it more obvious since it isn't necessarily obvious you can press the ESC key

* Ctrl-Clicking a player should now load their window on the first attempt. Before, if you had not opened the roster window you would have to ctrl-click twice. Once to bring up Community/Guild window, the otherto open the player. Now it should just open without needing to open the roster first.

* GRM will now automatically enable system messagess if they have been disabled. Be warned, any addon that silences system messages completely will break GRM functionality. Fast Guild Invite Classic currently has an issue, for example.

* The Macro Tool position will now be saved unique to each player rather than be sync'd to all your alts, even if you have it set to sync between all alts. All other frames that are draggable, like the minimap, do this.

* If a guild leader removes a rank, all ranks below it will see their indexes shift up. Before, you would end up reporting a mass spam change that you would have to deal with, and now it will check if the ranks are the same now.

* The macro tool top window message "Players the same rank or higher will not be shown"  is now more appropriately placed on the Macro tool

* The Option in the Scan tab now properly states that the "Left Player" will show the Custom note, in addition to the public and officer, on log entries

* Backup data originally included the pending Calendar invites, which was essentially unnecessary to be included in backup data as it will scan and add/remove things dynamically.

* Backup info will now recommend a data purge in the tooltip to some guilds whose data was so old and players had not logged into those guilds for so long that they were in such an outdated format and they maybe just were old traces of guilds never properly cleared out... so now it recommends kicking them. Of course, the power remains in your control.

* Tooltip on syncing just outgoing information, not all incoming is now more clear for the player in the GRM > Options > Sync tab

* Cleaned up a lot of unused strings no longer being used from the transation profiles.

* And finally... massive DB overhaul that brings about massive efficiency improvements, speed improvements, and readability improvements.

**RETAIL**

* The "Show Mouseover* button should now only appear when looking at the guild community window, not any other. It was previously there even if looking at other communities.



***BUG FIXES***

**BOTH**

*In no particular order*

* Cyrillic or Asian characters were not being counted properly when counting an edit box by taking length of string and failing to account for UTF8 values. This is now resolved

* The !note should now properly allow a full 31 characters regardless of language. There is an additional message announcing if the !note is > than the 31 character cap.

* Fixed a major bug that plagued *SOME* users who experienced a crash in the middle of loading the addon when updating from an older version that caused the version to be saved *before* the new settings were implemented, causing an issue where it believed the version was updated but no patches were applied.

* Found a bug that could exist if you had not updated GRM in a while, created a new toon, then the first time you updated GRM was also the first time you logged on to a new toon, it could faily to load properly. This likely got missed because a reload/relog would self resolve it. But now this will prevent that from happening.

* On resetting defaults, it was not resetting the UI beyond the core GRM frame. It should now be properly set, as well as 

* Addressed an issue in regards to the hotkey macro being tried to be created whilst in combat, which is restricted. The addon will now delay the creation of the macro while in combat and enable it when combat ends.

* Fixed an issue where on sync the Custom Notes were not always syncing in all cases when they should have been.

* Fixed a Lua error if you tried to export "former guildies" but there were none that had yet left the guild since GRM was installed.

* Fixed an issue where the Guild Creation date is not stored properly in the backup information when looking at the backup window.

* A translation error warning was triggering with the Korean version in regards to the "SYNC USERS" phrase. This is now resolved.

* Fixed an issue where a guild data backup cannot be loaded if you are trying to load an "Auto" backup, whilst you have no Manual configured. You had to have both saved to load the auto for some reason. It now works properly.

* Fixed an issue that could prevent the addon from loading due to a certain Dropdown Logic function not being loaded yet by Blizz. The addon now does a logic take to see if the function has been initialized yet by the client before loading the rest of the addon. This prevents GRM from trying to hook a Blizz frame that doesn't yet exist. this affects very very few people and I only ever got 1 report of it. Might be system loading speed issue that the addon will now compensate for.

* Custom Note stopping working with 8.3 release. You could no longer edit it or set a note because Blizz changed the way Edit Boxes lost focus if you clicked off of them, so what would happen is you would click the button to confirm, but you would lose focus on the click down, not the release up, so when the release up happened, triggering the button, the window had already lost focus and things would be hidden. This is resolved.

* Fixed an issue with the RGB settings on adjusting the background color the edit boxes would be over the +/- box

* Found a bug that could cause the players that left or were kicked to report incorrectly that they were only in the guild for 1 day. This is resolved in the new DB. Be warned, there was a formatting error in the old DB that needed to be cleared so the very few toons this affected their Join Dates will be reset and will need to be reconfigured, or just resync'd to another guildie. This will affect a VERY small number of names in yoru guild, and possibly none at all if you successfully dodge one of my updates that caused this issue a little while back.

* Fixed an issue where if you had more than 12 alts on a single toon, the scrolling window the bar on the right would disappear if you clicked it. Mousewheel scrolling still worked, but this is now resolved. You can click on it!

* Fixed an issue if you CTRL-Clicked a player in say, the Audit, often the player online/offline status and the Zone information was not accurate and was incorrectly reporting them as online, especially if using the old roster in retail, or all the time in Classic

* Right clicking the mouseover window should now have a proper anchored dropdown box regardless of player scale now.

* Fixed a bug where if you tried to add an alt it wouldn't let you and it would say "X player is already listed as an alt" - this should no longer be an issue. To clean up this bug some alt groupings might have had a player removed from them. This would be minimal. All you need to do is re-add.

* Had to fix MANY editBoxes as 8.3 did a stealth change to the Blizz edit Box template that needed to be adjusted for.

* Fixed an issue where a Lua error could occur when adding a new alt to a grouping who had the bday already set in some cases.

* New bug in 8.3 - when clicking the player to add as alt, or shift-clicking, it was not keeping focus on the edit box. Now it should keep focus so you can just press ENTER again to confirm adding the player

* The Clear lines within a range was clearing as if the log was not being filtered. It should now properly only clear the selected lines that you see. This should make it easier to say, clear just leveling spam, and so on.

* Taiwanese Client should now properly configure and not spam your chat window.

**RETAIL**

* With the inclusion of the new community guild recruitment feature, the reporting on guild joins modified slightly. Before I would look for the player that INVITED the player AND the time they joined. Well, now the recruitment through the new system only shows when they joined, but not who invited them. The addon has been modified to adapt to the new system and while it will still maintain and report *who* invited a player through traditional means, it will now state "Unknown" on who invited them... until a better system can be devised, if possible.

* Fixed a lua error that could occur when opening the old /groster - it was mostly inconsequential and didn't break anything, but bugs are a defect. This is now resolved.

* Promotions and Demotions should now properly report *WHEN* they occurred in retail

* The Log should now properly report *when* a player leaves or is removed from the guild, if it can be found in the last 100 log entries. It was only reporting the current day.

* Fixed an issue where the addon wouldn't initialize for "esMX" Spanish Clients in retail

* If a player was the "Vulpera" race and you tried to export their data with the export tool it would error out. This is now resolved.



**VERSION R1.831 DATE: November 12th, 2019**


***BUG FIXES***

**CLASSIC**

* Fixed an issue where mouseover would not work for some people even though mouseover was enabled. Be warned, this had to reset everyone's setting in Classic on the mouseover tooltip being enabled/disabled as it was wrongly pointed at the communityFrame checkbox setting for the answer, which obviously doesn't apply in Classic. Just an accidental crossover mistake due to single codebase use.

**BOTH**

* Fixed an issue where when re-enabling the mosueover window it would appear over the player side/details window rather than the side of it.

* Fixed a very complicated issue that had to do with mass joining to a guild spam. Oops!



**VERSION R1.83 DATE: November 11th, 2019**

***HAPPY VETERAN'S DAY IN THE US!***

*Ok, MAJOR update for Classic users as I have finally addressed an annoying bug that plagues CLASSIC only. Basically, it could cause you to not only lock up, but super annoyingly lose keyboard focus when typing and also even close the player details side window on the roster automatically, making it impossible to keep open. Big thanks to @Dracaratos#2600 and @Denatherion#7293 for helping me trace a major bug here both through video recordings of the issue and for Dracratos letting me join his guild temporarily to see the bug for myself and trace the issue. It was SO unexpected how it was occurring. This update should now completely resolve that.*


***QUALITY OF LIFE***

**BOTH**

* LIve promotion/demotion detection occurs by analyzing the system messages. While this was handled by scanning the event log in Retail, in Classic this is even more effective in that before it would only register LIVE rank changes you made yourself, not your guildies. Now, it will function for all events even made by other players with full compatibility to all 11 clients (10 in Classic).

* Added a new right click dropdown menu for the Audit window as well as a mouseover highlight to the lines - The options will likely be expanded. For now you can now set as alt or set as main. My next step will likely be to bring the Add Alt autocomplete window over.

* Noticed something that bugged me. I am surprised more have not complained over this. But, when editing something in the mouseover window, when finishing, it auto-unlocks the window. This is ok, but only if the side member details window is not open. It doesn't make sense to allow mouseover if the member details window is currently open to be able to mouseover everyone else. So, it is now properly locked and doesn't unlock until first closed. And ESC key will do the job or closing the X button.

* Big efficiency boost in some of my On_Update checks for the frames and they are a bit more compartmentalized now in triggering only on the On_Show and disabling when hidden. Some key ones were not doing this. Probably not noticeable, but inefficient nonetheless.


***ADDITIONAL BUG FIXES***

**BOTH**

* Fixed a spacing issue on the "Addon Users" tab which shows you information on all the players with GRM installed.


**RETAIL**

* On a player joining it was reporting the name incorrectly if a player was detected to be set as "main" automatically, and also not setting as main due to a typo on the variable.



**VERSION R1.82 DATE: November 9th, 2019**

*MAJOR BUG FIX FOR CLASSIC!*

*There was an issue that seemed to be affecting people in Classic that could cause disconnects. First, there was a Lua error that could occur when syncing banned player data and it could end up messing up some of the throttles as it would crash in the middle of a loop before summing the amount of data sync'd for the throttle. Because it was just BAN information, other guilds who don't have an enormous amount of banned players maybe didn't even notice this. But those that did have some, it could happen. Also, to make it worse, the sync process was further flawed in Classic where a DC could more-likely occur while grouped. Here is the ultimate weird problem with this... I dual-boxed 2 accounts to test this more thoroughly and I would join a group with 2 of my accounts on 2 toons and then force some data transfers back and forth. With certain testing I could recreate and force the disconnect every single time. So, I swap back to retail and I place myself into the exact same situation and no matter how much I tried to break it, there was no issue. So, it made me realize that there was ultimately a problem on the backend comms across the server that only are affecting Classic.

So, I now have the option, do I just disable the sync process completely when grouped, only disable when just in combat, or should I just throttle harder in these situations? Well, I decided to listen and collect addon to addon noise among the popular raid addons in Classic (and even retail), and I was blown away by how much constant back and forth chatter there really is, especially when in combat. The global throttle cap on addon to addon comms is not that high, and it is shared globally by all addons. Well, GRM is really the lowest of lowest priorities to take up some of that important and limited global data when you are in a raid and especially, when in combat. While technically I am tallying the total global info to account for the cap, I still find it better to avoid potential issues at critical times, like in a raid, that might prop out from something as simple as a bad lag spike in the middle of a sync.

So, after thinking about it more and more, @Xulu#1278 (discord) really was right when it comes to the suggestion of just disabling sync when in a raid. This is why I have a compromise, and why I also agree. You see, a large guild a new sync might take a little bit of time to complete, so, it's not a great idea to initiate a sync because one is out of combat at that time, only to then have them enter combat... Ya, I could kill the sync immediately, but overall I hate that kind of user experience. So, I instead am going to throttle the retroactive sync process. The long synce that says it is beginning and ending. That is no longer going to be possible when grouped. However, the LIVE sync changes will be allowed. In other words, if you add a player as an alt, and you send that message out to the other GRM users in the guild, they will receive your update whether they are grouped or not. Only the bulk data sync will be restricted when grouped.*


***QUALITY OF LIFE***

**BOTH**

* Custom note will now be added to the log reports when a player leaves the guild, if there was a custom note, and it will also be displayed if a player rejoins the guild.

* I almost feel like this aversely affects QOL, but I have changed the minimum scan interval from 10 seconds to 20 seconds. While the default is 30, you could have manually set it to 10. I did a little testing this patch that I had never really done in the past in forcing lag on the system artificially. I wanted to see what would happen if I pushed the lag for 3 seconds then 5 then > 10 - just enough to lag long enough without getting kicked offline. Wow, I found witth a HUGE server lag spike you were really riding the line with the 10 second interval as a general scan I have it basically set to be spaced out a little, but push a sync cap, the addon doesn't know this and keeps running the numbers and sending server calls, and what happens is Warcraft quest them all up. With a hard lag, I could end up locking the game up for serveral seconds as it tries to triple scan changes to the guild due to que up queries. This just resolves that potential lag issue. 10 seconds per scan was a little overkill anyway and probably not necessary (it was originally set to 10 because the server refreshes the guild data every 10 seconds when the guild window is closed and every 1 second when guild window is opened).

* The mouseover history on the Join Date, which gives detailed info on if they left and rejoined. The tooltip states the number of times they have been in the guild at the bottom. This has now been moved to the top. In theory, a player could leave/join a 100 times and the tooltip will end up off screen and be unable to read (recommend right click and clear lol), but if you want to keep the info for fun, the number is now at the top to see.

* Massive improvement in reading and parsing the system messages.


***ADDITIONAL BUG FIXES***

**BOTH**

* An issue with exporting the guild player data, if you unchecked many of the filters, since I added the sex/race info, it aligns the export info incorrectly.

* Fixed an odd bug that could be related to updating an older version of the addon to the current ( Version 1.62 ). Thanks @Xulu for pointing this out.

* Fixed an issue where the LIVE reporting on who kicked who was inaccurate at times. There was an initial sloppy adaptation to implement compatibility in Classic when in Retail this was unnecessary thanks to the built-in event log for guilds. Well, it ended up having ripple effects that messed up reporting on occasion for bother retail AND classic lol. This has been cleaned up now.

* Fixed a lua error that could occur when a player is kicked or leaves a guild and they have GRM installed whilst looking at the mouseover window. In some instances, even though they are no longer in a guild, the built-in interface was not clearing the guild interface so the mouseover window stayed visible, expecting to be able to call the server for guild info when it obviously cannot. This will now add a check on if the player is in a guild or not in the On-Update for the mouseover info.

* In some cases if the player that left the guild did not have their name listed properly and it was blank.


**RETAIL**

* Fixed an issue where the mouseover window was not pinned properly to the Old /groster frame if you opened that first or used it exclusively. It would only pin once you clicked on a name. It now should appropriately be attached.



**VERSION R1.813 DATE: November 4th, 2019**

***NEW FEATURE***

*Relatively minor feature, but a great suggestion from @Vishal in Discord that I knew I wanted immediately!*

![Right-Click and set as main or alt in the chat window](https://i.imgur.com/xdtzzgZ.jpg)

* No need to open the roster when a player joins, and configure them. Once the addon detects they joined the guild you can just right-click their name in chat and set as main. You can also demote to alt the same way.


***BUG FIXES***

* Log button and macro tool button were floating and not hiding if you triggered the CommunitesFrame by the control panel click. This should now properly be hidden.

* They should also obey their current frames global scaling - I notice people with super high rez and very low scale the buttons wo8uld appear huge. They are now set as CommunitiesFrame as parent to inherit their scaling.

* Right click should now be properly pinned to their respective text on the mouseover window if you have differently scaled windows.

* When you sync all alts to the same join date, it now should properly say "Joined" and not "Rejoined" when populating a note.




**VERSION R1.81 DATE: November 2nd, 2019**

*Minor update fixing a few things and adding some additional details about the player including race/sex.*

![Race and Sex - Available both on Export and mouseover](https://i.imgur.com/Bkp0P6H.jpg)


***QUALITY OF LIFE***

**BOTH**

* Added Race/Sex information of a player. this can be found as an export option. Be aware, this might mess up your column allignment so you will need to readjust. I just couldn't add these details to the end without it not feeling right.

* Removed .toc CommunitiesFrame addon depencies. This is no longer necessary and also will prevent the addon from force loading Communities before your global C_Value settings configured, forcing them to be set to default, ignoring custom settings. 


***BUG FIXES***

**BOTH**

* Fixed an issue that would crash the log and get it stuck in a loop on load

* Fixed a bug that could cause Live Kick detection to error out in some cases.

* Fixed a bug that would error out when trying to detect a LIVE kick or Left the guild change by parsing the system message.



**VERSION R1.801 DATE: October 31st, 2019**

*Quick bug fix that prevented the right-click drop down selection from working on most of the mouseover window items. Side-effect of something I missed when updating the alt list. Fixed*

* Also, added the Race/Sex metadata to each toon. I am not entirely sure what I will do with it yet, but it can be parsed out in the save (position 46/47 of the metadata array), or I will likely include it as an export option as well as maybe in the mouseover info when mousing over a player's name.


**VERSION R1.80 DATE: October 31st, 2019**

*Happy Halloween!*

***QUALITY OF LIFE***


**BOTH**

* Alt list cleaned up a bit with scroll slider only appearing if moused over. Placed better

* Same with the custom note scroll slider for long custom notes.

* Added scaling options for all the main GRM frames: The Core settings/Log frame, mouseover, Export, Macro Tool, and even the Advanced Join Date Audit Tool

![Scaling Options](https://i.imgur.com/toVo01b.jpg)
![Example Scale](https://i.imgur.com/RthqyZX.jpg)


***BUG FIXES***

**BOTH**

* Scaling issue fixed

* Buttons were appearing and are now disappearing.

* On some language clients the options slider on tooltip scale wasn't pinned right.

* Fixed a bug that caused a Lua error when changing languages

* Fixed a bug that could cause potential disconnects, particularly in Classic when in a group. Very old code that was somewhat inactive in Retail and irrelevant I forgot about that got reactivated again thanks to old frames existing again.

* A few other misc. things I won't mention here.


**VERSION 8.2.5R1.791 DATE: October 28th, 2019**

*Dumb Typo on the loading the log fix*


**VERSION 8.2.5R1.79 DATE: October 28th, 2019**

*Minor updates to smooth things out a bit in terms of pressing bugs people are encountering as my next release is larger and at least a week or two off. I want to get these parts out asap at least*


***QUALITY OF LIFE***

**BOTH**

* Change the tooltip over the guild Info to now just show the full guildInfo page - This is especially helpful in Classic, but overall just removes the spamminess that is now the globals. It wasn't so bad when there was only a couple.


***FIXED BUGS***

**BOTH**

* Fixed an issue where it is crashing on load for some people, particularly in Classic, as it is trying to pull the hotkey info for player push-to-talk to ensure GRM doesn't overwrite the Roster window call with the default "J" or ";" keybinds. - Well, it was calling the API to check the push-to-talk key before the interface had been loaded by Blizzard.

* Fixed an issue to prevent compatibility issues with other addons that call the dependency CommunitiesFrame to load immediately.

* Fixed an issue where mouseover frame was not working properly for some people (This resolves it for some people, need to hear if there are still some it does not resolve it for)

* Fixed an issue where some log entries for players leveling up did not show properly in the log


**RETAIL**

* Fixed an issue that could occur when trying to verify if a player just joined the guild and if they are a main or not.


**CLASSIC**

* Issue where GRM can lockup your game if 2 people in the guild promote/demote a player at the same time. It should uncheck itself from the circumstance in less than a second now.

* Fixed an issue where the addon will detect the wrong person as being promoted/demote as well.



**VERSION 8.2.5R1.78 DATE: October 23rd, 2019**

***QUALITY OF LIFE***

**BOTH**

* Exporting member/former member details will now only include the full "Name-Server" if you are in a merged realm guild.

* Hitting Level cap now has a more obvious chat/log message

***FIXED BUGS***

**BOTH**

* Roster keybind no longer set it to a default if you have it set to your Push-To-Talk in-game chat key.

* Fixed an issue where the Sync reporting should have only reported one time that a person had an outdated version of the addon.

* Fixed a compatibility issue I found with the German client thus failing to show the "Leveled" entries in the log

**CLASSIC**

* Fixed a bug in relation to if a player updates the Guild Information, it was sending a retail only command for people to refresh the Guild Info and recheck for settings change. This is now fixed.

* Fixed a bug that affected exporting the member details in Classic version only due to differences in Class API


**VERSION 8.2.5R1.77 DATE: October 22nd, 2019**

***NEW FEATURE***

*LONG INTRO*

If you are reading this, I want to share with you a parable. Bear with me, I am not preaching here, only sharing an applicable story. Let me tell you about *The Parable of the Unjust Judge.*  It appears in the Gospel of Luke 18:1-8. This story is a parable of a judge who lacks compassion, who doe not care for what people thought, and who was essentially, *unjust.* This was not a good person and he had no issue letting others know he was not a good person. Something happens that bothers this judge. A woman goes to him and tells that she has been wronged, that she is seeking justice. He doesn't care. He brushes her off. He can't be bothered with her. She keeps coming back, over and over, begging for justice. Finally, the judge thinks to himself, "I'll just give her what she wants to be rid of her!" The *unjust* judge grants her justice.

The Biblical moral of the story was to show the people that they should pray often and not weary of it, being that if an unjust judge still granted what they asked if bothered enough, how much more would a loving God grant them what they asked. Yet, in my case, I find that I am comparing myself to the unjust judge. 

You see, I had zero intention on getting to the "Export" tool anytime soon as I was interested in other projects, busy with them. It was far enough down the list to say that it would be a while before I got around to it. Then, something happened. About the last month or so, especially since Classic launch, I feel like the requests for exporting data have been coming almost daily. Over and over and over I was having to explain to people I did not have a method to export. It was like 10 to 1 compared to any other request. I have about half a dozen PMs on Curseforge requesting it, not including the comments on discord.

I was *wearied* by the requests. I just wanted to be rid of them! I just wanted to say, "Yup, just type /grm export, it's that easy!" But, I couldn't...

So, I did it. I built an "export" tool to assist in better exporting the Log, the Member details, as well as the former member details. It might *appear* to be such a simple feature, but overall this took me nearly 2000 lines of code to really have a solid user experience. I am sure there is room for improvement and suggestions as well, but I am glad to know that I now have an answer to people who ask about this feature.

_______________________

**DATA EXPORT TOOL**

![Log Details](https://i.imgur.com/MWgmxWT.jpg)
![Member Details](https://i.imgur.com/cetws2s.jpg)

*Access in 3 ways: 
* /grm export
* Audit Window (top right)
* Log Tools window

*3 Main Data Exports: Log, Members, Former Members*

*Notable Features*

* Ability to choose specific ranges to export

* Auto build the next or previous block to export, to make the process easier.

* Filters for all Member Details you may or may not want to include.

* Delimiter selection to make it easier to copy the information to a txt file and import it into your favorite spreadsheet program. Of note, I have noticed that Googe Spreadsheets seems to handle special characters far better than Excel. Note, I only have 2 delimiters setup so far. I was going to have a custom and then I just realized how easy I was allowing players to break it if I did that lol. If you have a request for one, I would be happy to include it. I did want to include the "|" bar as a delimiter but for some reason the Lua code is not letting me set the text to an edit box if too large a size with the bars... So, something odd there I still need to discover.

**--------------**
**QUALITY OF LIFE**
**--------------**

**BOTH**

* Players can now disable the !note confirmation. It also no longer takes up actual guild chat lines, just GRM reported and printed to the chat window for GRM users.

* The !note messaging process has been completely rewritten to be more consistent. More importantly, it has been rebuilt to not spam the actual guild chat and instead only message GRM users *if* they have chat message enabled for public note updates. It is now wrapped in the checkbox on the "Public Note" chat and will be silent if not enabled.

* Player can now disable the "MAIN" tag - whilst still show the mainName - just set it to "No Tag"

* GRM will now enforce an instant Global Settings check for updates if the player edits the GuildInfo Global Control tags. There is no longer a long dely. It will instantly check

* There is now an indicator on the GRM mouseover window when it becomes "Locked" in place with an instruction on how to release the lock

* If you sync your addon with a player who is outdated, it now only reports one time that there was an attempted sync and it informs you (if more than 1) how many people have outdated addons online

* Macro Tool - The left-side macro now has a more detailed tooltip on what can be done and managed.

**RETAIL**

* Added a tooltip on the calendar for right click suggestion, as well as localized the string as it was not preiviously it seemed


**--------------**
**BUGS AND BUGS!**
**--------------**

**BOTH**

* Noticed an old delay in the system that was redundant, that would avoid reporting kicked players from the guild on the first pass on logon... this only applied when I was still adding names to friends list and delaying to check if they were still on server.

* Export log was in some cases not functioning. This has been remedied with the new export tool.

* Fixed an issue that could prevent the addon settings for some toons from loading properly and causing errors.

* Fixed a roster database issue that could occur where a player namechanged an alt to one of their own toons, like they server transferred one character, then namechanged a member of the guild into their name. There is now a check for this to ensure a correction to the database if necessary.

* Fixed an issue that could result in the wrong person getting banned when you kick a player from the guild and select to ban alts

* Fixed an issue with the Ban window not clearing and disappearing when on the screen confirming a kick of a player... it could end up hooked to things like the death window.

**RETAIL**

* Fixed an issue where it was reporting YOU as being the person that kicked someone when it was another officer.

* The old /groster default GameToolTip was not disappearing if closing the window. This should now be resolved.


**VERSION 8.2.5R1.76 DATE: October 1st, 2019**

***MAJOR OPTIMIZATION UPDATE***

*Optimized the code quite a bit on the back end. Restructured the database, sorted all my arrays properly. Implemented a binary search algorithm on all database queries. I probably should have done this originally, but the original scope of the addon in my mind when I started building it was a bit smaller. This is an ENORMOUS performance gain that cannot be understated compared to previous lookup methods. Of course, with the processing power and speed we do have these days it wasn't really noticeable for most, but for me, I think efficiency matters and this makes me feel a lot better! The structure using arrays(tables technically in Lua) like I have should now act correctly and be quite fast. We are talking some things that might take say 1,000,000 actions down to 10,000 actions. The gains cannot be understated. I should also mention a lot more went into this than just this optimization. I think it took me 15-20 hrs of work just on this one side project*

**--------------**
**QUALITY OF LIFE**
**--------------**

**BOTH**

* LOG now has font size control slider for specifically the log only. You can find it in the "Log Tools" window by clicking the bottom bottom left of the log.

* Global Controls can now be exported to the Guild Info notw with the click of a button in Options > Officer tab - the tooltip on the button will also state which are not yet exported

    - In addition, all "Global Control" settings that can be set are now more obvious with a "(GC)" indicator in the options

* Player level now is stated in the log when they leave or are removed from the guild

* CHECK YOUR BAN LISTS!!! GRM will now indicate if the player is no longer on the server (or no longer exist from deleting toon, aka, no longer on server) - Clean up your ban lists! If they are no longer on your server this means their GUID is no longer valid, and as such GRM cannot detect if they return to the guild or not. Since they cannot return at this point, it is safe to remove them from your list

* CTRL-Click and CTRL-SHFT-ClK options have been expanded to the Event windows (not relevant for Classic) and Ban windows for continuity, to bring up player window or search for the player.

* If the player side details window is open on the Classic roster or the /groster in Retail, and you re-click on the name. If it hides the side window it will unfreeze the lock on the mouseover automatically. Otherwise you still need to hit the ESC key or click the X. Communities default interface setup by Blizz functions a little different so it doesn't apply to that window.

* Added a tooltip to the sync all settings option to make it more clear it is for each guild, not account wide.

* In regards to the macro tool, typing /grm tool to bring it up, you can also now type /grm macro to bring up the same window. Of note, /grm kick also works

* New text info on the macro tool explaining that people same rank or higher will not be included in the queue due to the inability to modify player ranks the same or higher than your own.

* Noticed some inconsistencies in full name-server showing often when unneeded so I normalized those messages a little.

* Hard Reset slash command and Options > Help button now has a confirmation box.

**CLASSIC**

* Events Window now has a Classic specific message explaining why the feature is disabled (no calendar)

* AddOnSkins file has been accepted and merged into the official TUKUI repository for those of you that use ElvUI AddOnSkins - the template is fully updated. They should have a release ready through their own system.


**--------------**
**BUGS AND BUGS!**
**--------------**

**BOTH**

* Scaling issue with the GRM mouseover window has been resolved. It was squishing the frame due to a top and bottom "pin" when it should have just been the top corner.

* Fixed an issue where if you were the same rank as the player, they were still showing up on the macro tool with a recommendation to kick. Now, it should only show them if they are below your rank.

* Fixed an issue where if a player's birthday was set to unknown, even if you updated it correctly by right-click to edit, and even if it showed correctly on the Audit window, the mouseover would still say "Unknown" after mousing off and back on... no longer!

* Some frames had their bottom edge being cut off at certain resolutions. This should be resolved now.

* Export of the Log should now properly work and obey the filter rules that you currently have set. It only can do up to 1000 lines to avoid too big of a clipboard copy with CTRL-C

**RETAIL**

* Tooltip bug on the old Roster. You mouseover it and it grows and grows and grows until you mouse off and then come back and it restarts. This has finally been completely squashed and it is compatible with Raider.IO




**VERSION 8.2R1.75 DATE: September 25th, 2019**

*Compatibility Path for 8.2.5, among other things. It is not working with 8.2.5!*


***NEW FEATURES***

![Note Trigger](https://i.imgur.com/sG7iA4C.jpg)

*The return of the !note feature! While this is mostly redundant in Retail, it plays a big role in Classic. It has been updated, onverted, and rebuilt for newer integration and for Classic! Of note, I have decided to keep the feature availabe in retail, for continuity between both versions, but I mostly find it useless in retail.*

*In Retail this has mostly become useless as players now have the ability to edit their own notes and not others, unless they are officers. However, in Classic, the problem returns of players being able to modify **ANY** guildie's public note, not just their own, just by having access to editing public notes. This can be frustrating for leadership as the server stores no log of *who* made the changes. So, the !note feature allows a guild to disable the editing of public notes, eliminating this issue, but allowing guild members to easily update their own public note with the use of the "trigger," as long as an officer with GRM installed is currently online.*

* It should be noted that this painstakingly takes advantage of the behind-the-scenes sync leadership role. It would be bad if there were 10 GRM users who were officers online at the same time and all 10 of them saw the !note designation and all 10 of them updated the public note and spammed to chat they did so. So, how do you determine which of all the current GRM users is the one that does it without there being too much of a delay behind the scenes? Well, good thing I already resolved this in regards to sync leadership for a decentralized database. This is not super well tested, but moderately and I'd be curious to hear from people if it is or is not functioning properly at all times.

**How the !note feature works**

* Any guildie, including a GRM user, just starts their /g Guild message with this *trigger*: "!note"

* Anything after the !note trigger will be set as the public note (up to 31 characters). The previous note will be overwritten completely.

* Examples: !note iLvl=115, Eng 250, Alch 300 
 


**--------------**
**QUALITY OF LIFE**
**--------------**

* BOTH: Last online Header text now has a proper width cap set before it wraps it so that in some languages it is quite wide and can overlap with player name (like in PortuguesBR )


**--------------**
**BUGS AND BUGS!**
**--------------**

* RETAIL: Raider.IO tooltip should be working again now.

* CLASSIC: Noticed Portuguese BR localization file was not properly inserted into the .toc file in Classic. It was working in Retail, just not classic.

* CLASSIC: Found an issue where if an addon called the CommunitiesFrame dependcy, the mouseover window would stop working in Classic. Cleaned up!  

* BOTH: Fixed a bug where a Lua error would occur when a player logged off a the Member Alert message would not be shown (line 2091), and only if they had "Main Tag" designation disabled.

* BOTH: Guild alerts should now properly show or not show main tag desigations based on the settgins



**VERSION 8.2R1.74 DATE: September 19th, 2019**

*Smoothing some more things out!!!*

**--------------**
**QUALITY OF LIFE**
**--------------**

* BOTH: Brazilian Portuguese has been nearly fully transalted and is now selectable in the drop-down as an option. TY @@Drakar#0666 (Discord)

* BOTH: Logic on system message class coloring has been updated. You can now enable/disable "Guild member alert" system messages to include the class color rather than it be enabled by default in the General Options tab.

* BOTH: Scanning process in checking for changes is now improved. I actually haven't looked at this in quite a while but identified an inefficieny in it that could result in it skipping a pass, so even if you had it set to scan once per say, 30 seconds, it might only check for changes once per 60 seconds, on the 2nd attempt, or if you check every 10 seconds, then once per 20 seconds, skipping every other pass. This was a surprising improvement.

* BOTH: If a guild member that uses GRM is promoted or demoted themselves, their rank permissions should now be logged instantly so to avoid any confusion as to why sync permission may or may not functioning correctly. There may be a slight delay in Classic compared to retail here

* BOTH: The "Ignore Macro Tool Filters" button should now no longer overlap the alts window when you have 12 alts and will adjust its spacing if < 12 or > 12 or exactly 12, which is necessary

* BOTH: Language names are now translated in all 14 supported langues in their language selection dropdowns. 

* BOTH Localization efforts for translation work can now create their very own /grm slash command. /grm not make sense in your language? Make your own acronym!!! Note, /grm will always work, it allows you to create an additional slash command trigger. I have placed the slash command option at the top of each locale file

* BOTH: Cleaned up a few grammar mistakes pointed out!

* BOTH: When making a global setting change to the custom note, it not only forces the sync rank restriction for all, it also will reset all the individual notes to the given rank level to normalize them. This is necessary as too many were forcing filtering out. This can be retriggered the next time the rank is restriction is changed for all or for all new settings.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BOTH: The "Recommendations"  to suggest to kick a player was only reporting on 1 name per pass due to an error. It now should properly report all of them together in a group.

* BOTH: Kicking all alts should now properly work consistently and populate the kick macro tool

* BOTH:  Right click to confirm verified dates the button should now properly disappear when right-clicking player names to set as main/alt and should now be properly space when right-clicking Notification settting on player status - as well as fixed some unnoticed sizing issues too.

* RETAIL: Potentially fixed an issue of a growing tooltip bug in the roster. Let me know!

* RETAIL: Mouseover was not working on the Old Roster window after last update - as well as some other issues with checkbox on Community window. This is resolved now.

* RETAIL: Found a potential bug that can cause something to endlessly loop when lots of new people join back to back, quickly. Escape timer was re-engaging back to zero on each loop.


**VERSION 8.2R1.73 DATE: September 17th, 2019**

*A staggering amount of work went into this update over the last week. But, you see, I am motivated to get everything smoothed out as soon as possible so I can start enjoying Classic myself! With that being said, lots of busy work here, bug fixing, and even some new stuff. I find that as I dig into this port to Classic I keep stumbling upon old code where I go, "Why did I do it like that?" lol - so I keep getting distracted by all these little tangents. Thank you for your patience. Come check, see if your bug got fixed!*

*Note: Each update will be tagged with **Classic/Retail/Both** for context*

***NEW FEATURES***

* Added a "Confirm Date" button to the right-Click menu so you can just quickly confirm a date if it is already accurate. This applies to the "!!" unverified date tags. It should only appear if the date is unverified when you right click.

**--------------**
**QUALITY OF LIFE**
**--------------**

* RETAIL: Players promoted/demoted should now be detected instantly in retail, and no longer just when you do it, but if another officer in the guild changes someone's rank you will instantly update yours based on the system message. Please note that this does not work in Classic in full capacity due to limitations of the lack of a guild event log. The compromise is GRM will instantly detect your own changes, but not necessarily those of your officers when it comes to promotions/demotions. This may change in the future, but it will require me to go parse the strings for 11 clients rather than rely on the logs, so not priority. 

* RETAIL: People kicked/leaving the guild should now also be consistently detected instantly. Same circumtstance for Classic as above.

* RETAIL: RankdropDown text now is updated when rank change occurs. For some reason Blizz has still not updated this text error on the CommunityFrame guild interface. I bandaid it for now for them.

* CLASSIC: The ability to ban a player when removing them from the guild, as well as ban all of their alts has been fully integrated in to Classic now. The window should now appear.

* BOTH: When kicking a player from the guild, if you select to kick all their alts as well, the process is now fully integrated into the Macro Tool, and the window will popup ready for hotkey action with the macro already built and ready to go. This will allow you to much easier kick all their alts within seconds of you kicking them as well.

* BOTH: There is now a 3rd option when a player leaves the guild. The log reports that the player was kicked, that they left the guild, or if it is not able to be determined, that they are no longer in the guild. The 3rd option applies more towards Classic, but can definitely apply in retail. It just makes more sense to say "The player is no longer in the guild" than "The player left the guild" when it cannot be determined if they were kicked or they left, because the action occurred when you were not online.

* BOTH: Mouseover window can now be disabled in Retail community frame, or in the Classic roster frame as well... Checkboxes are in slightly different positions but still obvious

* BOTH: The addon will no longer rely on adding people to your friends list to determine their server status, if they are there or not. A much more reliable and faster method has been implemented. Yay! In the next retail patch, the new recruitment interface will do away with that "hackery" completely as well. Thankfully! If you unfortunately encountered the annoying error of friends that were not removed from your lists due to a crash of GRM before it could... use the following script in chat (be warned, it will clear ALL non battle.net friends).

'/run GRM.ClearFriendsList()'

* BOTH: Disable and Enabling the Birthday feature is now available with a checkbox right in the Audit window (this will also hide the bday info on the mouseover window if disabled)

* BOTH: "Check All" option on the log side panel where you can filter everything now behaves better. The check all should auto be checked if all are already checked, and it will uncheck as you uncheck one. Overall UX is better

* BOTH: On Adding a player to the "Ignore List" for the Macro tool, you can now CTRL-Click their checkbox on the bottom left mouseover to either add or remove all their alts as well from or to the list.

* BOTH: Log should now properly refresh if a player rejoins the guild and the log is open without needing to click off and rejoin

* BOTH: Language should now properly localize when player changes them on the mouseoverTooltip button

* BOTH: Cleaned up the patching process a bit. This largely does not affect most players, but in the case of someone who installed a very early version of GRM and then updated to the most new version, many updates would need to be patched and applied and could be a bit of a resource hog the first time on login causing the game to possibly momentarily freeze until completion, or worst case, time-out altogether. Note, this would only affect someone that installed the addon probably > 1.5 to 2 years ago and never updated since then. But, I have to look forward in that as time goes on the potential issue can only exacerbate. This also smooths out any issues of freezing during an update as it breaks them up into blocks of 5 patches per 2 seconds through a recursive patching method that is just more efficient. It will even announce to the player when a patch is being applied and when that is completely, no longer just a "GRM update to version XXXX" - it will still say that, but in case of patches being applied, it will announce them, announce completion, and announce how much work was done.

**--------------**
**BUGS AND BUGS!**
**--------------**

* CLASSIC: Taint should (hopefully) no longer be an issue in Classic. Tthere was an issue where the addon would block certain actions from occurring due to taint. In retail the exact method is used with no taint in communities, but in Classic it was problematic due to a change in permissions and UI restrictions.

* CLASSIC: Addon should no longer, **for real this time lol**, report players were demoted to the same rank when nothing happened.

* CLASSIC: Character count should no longer appear on the popup window unless editing the MOTD

* CLASSIC: Mouseover should continue to work proprely on the "Guild Status" screen. Some cases it would hide and then stay hidden.

* CLASSIC: Fixed and issue with live tracking of changes in the guild would stop scanning periodically after a player joined the guild

* BOTH: Hybrid Scrollframes were throwing an error if you tried to scroll and there wasn't enough data that required there to even be scrolling. This used to not be an issue until I broke it recently of course!  I accidentally had enabled the scrollwheel action when maxScrollLength equaled to zero, when it should have been disabled. Simple fix at least.

* BOTH: Addon was erroneously reporting player name changes and overwriting player names with a date timestamp! Oops! This also would end up with a downstream mess of issues, from false rank renames, etc...

* BOTH: Fixed an issue where even if you have disabled reporting to the CHAT that the player left the guild, it still did.

* BOTH: Players using Cyrillic characters were unable to properly input some names as bans due to a formatting issue and it not parsing it correctly with some input error protection. This is resolved now, but affected players using the Russian Client.



**VERSION 8.2R1.72 DATE: September 10th, 2019**

* Major bug fix - for many addon would not load in 1.71 update - this is resolved

* Player nameChanges should now report properly.


**VERSION 8.2R1.71 DATE: September 9th, 2019**

*More progress on the path to smoothing out Classic!*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: Classic - Social Micro button should now properly show a localized tooltip for all languages

* QOL2: Classic - Ctrl-hotkey (typically CTRL-J) keybind is unnecessary in Classic and is now removed

* QOL3: Classic - Reputation on player mouseover window is not relevant in Classic and is now removed

* QOL4: Classic - Several irrelevant "Options" configurations are made more obvious to not be applicable in Classic.

* QOL5: Both - When closing the members detail window (where you can do promotions), it doesn't immediately release the pause on mouseover if the player mouseover frame is still visible. Either closing the window or 1 more ESC key will do it. Feels better, imo.

* QOL6: BOTH: When editing a player date, rather than the starting date being today's date, it will instead be the corresponding date that is to be edited.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Classic - Rank changes should now properly log when you promote and demote people!

* BUG2: Classic - Players should no longer be reported as having gotten a demotion when they join the guild, in some cases.

* BUG3: Classic - Players should be unhighlighted and unselected now with the Guild Roster properly as you mouseover from one to the next

* BUG4: Classic - Compatibility built with ElvUI again, since they are still calling many community frames, it can error out GRM.

* BUG5: Classic - Mouseover should now work on the roster window for both "Player Status" and "Guild Status" settings...

* BUG6: Classic - Mouseover window should now be properly pinned to the guild roster in all cases.

* BUG7: Classic - Critical German Client only bug that caused tons of /ginfo system message spam. Oops!

* BUG8: BOTH - Adding and removing ranks to a guild should properly report how many to the log now.

* BUG9: BOTH - Keybind for opening the roster should not overwrite yours now if it already exists. Oops!

* BUG10: BOTH - Found that when a player not only joins the guild, but is promoted to a higher rank than the initial, the log was reporting this. But, in some cases it was logging a double report of a rank. It would have 2 listing in the mouseover history of promotions of the same exact promotion on the same day. Furthermore, this could error out in Classic where if it was not found in the event log, since it can't be, it would report a nil, throwing an error on mouseover. Database is cleaned up and prevented from occurring. This CAN technically happen in retail, but less likely for reasons I won't bore you with.

* BUG11: BOTH - Macro tool the recommendations to kick if player offline was accidentally set to a default of after 75 months, or in other words, 6 years and 3 months offline lol. If you had not already changed this the settings will be reset to their proper default recommendation of 12 months. This does not re-enable it if you have it disabled. It only changes the stored month interval.

* BUG12: BOTH - The ESCAPE key should once again properly work if you open the macro tool. It was not bringing up the game menu after loading the macro tool and it was messing up some things.

* BUG13: BOTH - Critical storage wasting bug. If you ever used /grm clearguild it created a 2nd index of the backups, wastefully. This now purges the double backups and removes the bug

* BUG14: BOTH - Ban reason count 14/0 on first focus when adding a ban. For some reason it was tallying maxLetters rather than maxBytes. It has to be set to maxBytes for sync purposes, rather than letters, as some alt-code type special characters or asian characters can take up 3 bytes (but count only as 1 character). 75 characters could be 225 bytes in theory, whilst 75 Bytes is 75 bytes.


**VERSION 8.2R1.70 DATE: September 5th, 2019**

*Minor update in regards to smoothing out some bugs for both Classic and retail*

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: CLASSIC - Promotions/Demotions that you make should now properly instantly trigger the change to the roster and report to the log

* BUG2: CLASSIC - Fixed an issue that could cause a Lua error when an invited player joins the guild.

* BUG3: CLASSIC - Fixed an issue that could prevent a Classic addon user from loading GRM properly due to a previously loaded incompatible build. Popup window will appear on logon requiring you to confirm the action and reload the UI to resolve the bug.

* BUG4: Default recommend to kick a player was accidentally set to only announce after 75 months lol. Oops! Shoulda been 12

* BUG5: Join dates detected live should now properly again be stored as verified information of that moment (promotion/demotions already does)

* BUG6: Fixed a bug that would cause a Lua error when adding an alt to a "main" where the alt had their bday set to "unknown" - the alt would still add, but it would error out and fill to reset the addAlt window. This is resolved now.

* BUG7: The Macro Tool button should now be properly sized, and the 2 buttons above the roster have had their font size increase a bit.


**VERSION 8.2R1.69 DATE: September 4th, 2019**

**CLASSIC COMPATIBILITY RELEASE**

*That's right! I went ahead and ported this to WoW Classic. This was not a small undertaking. GRM is deeply integrated into the guild interface and with BFA 8.0 release of Communities I decided to go all-in and intertwine the addon into the modern interface. I even abandoned some old data pull methods relying on the original roster and instead relied on the speedier "CommunitiesUtil" and "C_Club" API collection. This is not accessible in Classic. It meant reverting a great deal of work, and then adapting it to what I had built since BFA had launched.*

*As such, I have somewhat made the assumption that one day Blizz might release TBC Classic, and even WOTLK Classic some years down the road. So, rather than go through this process again, maybe 2 or 3 years from now, I have decided to take pre-emptive action and I basically rebuilt much of the addon with a bit more flexibility for handling these changes on the future down to not just expansion changes, but even individual "Builds" or patches. This should save me some future headaches. I also did this very a very important reason. Coding is time-consuming. This is a hobby of mine, at the end of the day. I still have my wife and kids, my career, my other distractions in life, and as such GRM remains basically my interest as I have time to put into it. This is just me making sure that my time doesn't get too buried into it as it continues to grow. By ensuring I have only 1 single code-base I have to deal with, rather than 1 for Classic, and 1 for Retail (and if more epxansions came out 1 for each of them), I instead get to deal with just 1 single code-base and my life is a heck of a lot easier. This may help explain why my release of Classic maybe took a bit more time and effort than usual.*

**Limitiations of Classic:**

* No in-game Calendar. This means no adding anniversaries and birthdays to the calendar. As such, I have temporarily disabled anniversary/bday announcements until I decide what I want to do... I am considering making at least a Classic unique "list" of upcoming anniversaries and bdays for leadership to reference. Until then it is disabled.

* No guild event log. It did not exist in Classic. This is that tiny log you can click that tells you the last 100 events in your guild, like who kicked a player, who invited a player and so on. Since this log does not exist, while GRM can detect that a player joined the guild or left it, the addon cannot determine who invited the person, or who promoted them. Sadly, you will have to rely on just knowing they were promoted. There is currently no server data that provides this information in Classic.

* More untrustworthy dates. Because the addon cannot know the exact date a person joined the guild. For example, let's say you are offline 3 days, you logon and find 10 new memebers. Before, in retail, GRM could look at the event log and pull the exact dates (as long as it was within the last 100 events). Well, in Classic there is no way to know when in the last 3 days it occurred. So, it just adds a timestamp of when you logged in. Those dates are flagged with 2 red exclamation points as "unverified" - This prevents unverified data from syncing to others. To verify all you need to do is right click the date on the player mouseover window, edit it or confirm it.

* Some limitiations on the speed information is accessible. With Communities, if someone joined the guild I could pull their full data and build a metadata profile of their character instantly. With Classic I have to wait for a callback from the server indicating the data has been refreshed. This can take up to 10 seconds when a player joins for it to trigger them in the guild. If you currently have the roster window open, it will update in less than a second, but in Classic, if the Guild Roster is closed, it won't do on-the-fly updates of roster info.

* Yay, most features still work just fine!


***Classic Specific Updates***

* CLASSIC1: GRM fully ported and working!!!

* CLASSIC2: Opening the Guild Info now auto-focuses the edit box, it also only closes the Guild Info frame when pressing ESCAPE key rather than closing the entire guild roster.

* CLASSIC3: Social Micro Button (since there is no guild/community button in Classic), I added a tooltip explanation and the ability to CTRL-CLICK that button to open guild window. CTRL-J also works, and added the keybind default to "J" to open guild roster (it was not set by default)

* CLASSIC4: Icon texture was unavailable for the minimap, so in classic a different texture is used. This also applies to the macro button icons.


***NEW FEATURES***

**Tagging and Flagging unverified dates (TY @Ayr on Discord)**

*Previously briefly touched on this in regards to Classic unverified dates. Yes, this works retroactively with your databases, as the information was already there.*

*Unverified dates exist because they were not able to be verified by using the guild event log. You NEED to have verified data to be "safe to sync." However, if the date is not discovered, or you are playing Classic, then it becomes untrustworthy data. These dates will now be obviously tagged with a “!!” red in front of the dates on both the player window and the audit, as well as a mouseover tooltip explanation on how to resolve them. These will automatically be removed if you sync with a guildie with verified data, or you Edit the data yourself and confirm it. What we don't want to happen is say a guildie has been offline for 3 months, logs in, tags a bunch of dates as the day he logged in, since no other dates were discoverable, and then sync that bad data over, ultimately overwriting accurate data because it is logged as newer. That would be bad. He still has a reference point date from when he logged on, but he won’t share that with you until data is verified.*


**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: AFK notification system, or players going offline/coming online, is now wholly independent of the roster process, so even if you have it to never scan for changes except when you logon. You can still right-click the AFK/Offline status of the player on the mouseover window and set to be notified of their return. If the roster window is open it will now notify you within 1 second of the update. If it is closed the server will push the information out within 10 seconds, so it is much much more reliable and usable.


**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed an issue with the recruitment window getting repeated hooks causing message spam on a ginvite and some additional guild check spam on the back end was unnecessary ( TY @Xulu on Discord)

* BUG2: Fixed an issue where sync was not working properly in all cases in regards to birthday information.

* BUG3: In the GRM Macro tool "safe" list the tooltip was not stating the time offline properly for "Kick" actions being ignored.

* BUG4: Officer note change message was not being reported instantly to the chat log when manually editing the officer note with GRM

* BUG5: Audit frames should now properly update LIVE as changes between players are sync'd. Some data was not updating visually on the fly.

* BUG6: /grm center should now properly center frames again, storing the positions between sessions. Useful if a player drags a frame off screen

* BUG7: Fixed an issue that could prevent some people from getting GRM to initialize on first login.



**VERSION 8.2R1.68 DATE: August 28th, 2019**

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed an issue in regards to people that used the original /groster - the "OnUpdate" handler of the new Tool's button was erroring out.

* BUG2: Ignore recommendations unless all in the alt grouping were inactive was not filtering properly. This is now updated.

* BUG3: Frames should now properly auto-update and repopulate the lists on changes to the roster, such as settings changes, or add/remove alts


**VERSION 8.2R1.67 DATE: August 26th, 2019**

*NOTE: This is NOT a compatibility update for Classic. I am planning on it. I have built a lot of backend infrastructure to help the process. But, I am pushing this out because I wanted to be done with it so I can focus on Classic!*

***NEW FEATURES***

**Macro Tool**

*This new Macro Tool is to assist players in being able to do things far more streamlined and easier since Blizz restricted addons from kicking/promoting/demoting players. So, what the addon now does is compiles a list of names based on a set of rules configured by some filters and then it auto-creates a large macro. It crams as many names as it can into that macro. It then binds that macro to a hot-key (so you don't have to keep it on the bars). Upon pressing the macro it activates all actions, clears the macro and rebuilds a new macro from the names in the que. In theory, you should be able to spam the macro rather rapidly to complete all macro'd actions, like /gremove playerName (and kick 10-15 names at a time, depending on their name length). It should be noted that as of now only the "Kick" recommendation rules are currently implemented.

![GRM Macro Tool](https://i.imgur.com/8OeTMwW.jpg)

* Auto-build and rebuild the macro as needed

* Ability to create a "Safe" ignore list of players you want to be immune to the recommended filters. For example, maybe you want to kick everyone offline > 6 months, but you don't want to kick a specific person ever. Or, maybe some gets deployed 9 months, etc...

* Ability to ignore recommended actions as long as at least 1 toon in an alt grouping is say, active.

* Ability to adjust the macro on the fly and remove names quickly with only temporarily removing them from the que. Rebuilding the macro will re-add the names

* Ability to manage the "Ignore List" easily from within the tool.

* New Checkbox on the mouseover window in the bottome left corner to set a person as ignore.

* /grm tool or kick or promote or demote will all bring up the new Macro Tool (or just click the new button on the roster window)

*I am about 3000+ lines of code into this new tool, and a bit more work to go. This is why this release took so long*

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a bug that seemed to affect a few people when trying to sync whilst in combat. Unfortunately there seems to have been a slight change on the backend server where some info is restricted when in combat. This no longer errors out.


**VERSION 8.2R1.66 DATE: July 23rd, 2019**

*Needed to rush this out due to a potential bug that could affect only new users, but not all. Sort of an edge case that would prvent some from loading the first time, though it would load properly on their 2nd attempt after relog or reload. Now is should configure properly for all.*

***NEW FEATURES***

*Custom Note Tags for auto added join dates (for join and rejoin)*

* Change the "Joined: XXXX" or "Rejoined: XXXX" date tags to your own custom ones! This is found in the Officer Options tab.

* Global control of these custom tags has also been included using the key "g6^"

* Example: "g6^Joined:^^Rejoined:^^"  (though using your own custom tags)

*   - You MUST include the "^^" to verify the stop. Max number of characters is 16 per tag.

*   - "g6^Joined:^^"      - No need to force both, you can force just the Joined.

*   - "g6^^^Rejoined:^^"  - You can also just force the Rejoined, and ignore the joined (notice there still is the double ^^, but the joined is empty, no text).

*   - "g6^Capt'sLog:^^Re-Recruited:^^"  - Pure custom, so if a player joins, or rejoins, they date auto added to the officer note will be like "Capt's Log: 23 Jul '19'"

**--------------**
**QUALITY OF LIFE**
**--------------**
  
* QoL1: Dutch compatibility has been built-in. While it is not yet localized into Dutch, it can now be selected as a language option as we patiently await the translation work (as of now roughly 900 lines to do all. So much work!)

* QoL2: Cleaned up a littl ebit of unnecessary processing in the background that could be optimized a little bit.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed another bug that could cause new addon users or new alts to trigger on load - it goes away after a reload - this is sort of an edge case and won't affect everyone.


**VERSION 8.2R1.65 DATE: July 22nd, 2019**

*Minor bug fix - addon would not load for NEW alts or new users of the addon as the LoadSettings was triggering a check on the new channel destination which had not yet been configured to default as of yet. This is now resolved.*


**VERSION 8.2R1.64 DATE: July 22nd, 2019**

***NEW FEATURES***

*Nothing too major. Some large stuff in the pipeline, so this is a minor cleanup patch with a couple Quality of Life improvements, and some added customization.*

* New1: Players now have the ability to choose which channel to send GRM messages to, in the General Options - 

*   - If you wish, GRM will create the channel for you when you type in a custom name, and if it doesn't exist, it will prompt you for permission to create it.

*   - If you end up removing the custom channel GRM will automatically report to the defauly general chat channel again.

*   - This chat window setting will not be sync'd between alts and will be character specific.

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Italian is fully translated once again! TY @Nihal6#8125 (Discord)

* QoL2: Someone had pointed out that when clicking some custom values, the editbox disappears, though you can still type. This has been around forever and I decided a long time ago I was only ever going to fix it if someone reported it lol. Well, the time has finally come!!! So now, they are properly displaying :D

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: Fixed an issue that caused a Lua error on trying to export the player join dates to the designated note location if they were not there.

* Bug2: When manually clearing a range of lines from the log, the addon will now properly tell you the number of lines cleared, not falsely report only 1 line was cleared.

* Bug3: The font should now properly resize and change on the main log, the audit window, the backup window, and the Advanced Join Date Audit tool - before it would only refresh the size settings on a reload. It should now happen instantly on changing the setting.

* Bug4: There's actually a couple of other bugs I resolved and now, for the life of me, I don't even remember exactly what they were because I was too lazy to document it that night lol.


**VERSION 8.2R1.63 DATE: July 12th, 2019**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: Audit Window has been rebuilt and now scrolls as a hybridscroll frame

*   - In addition, birthdays have been added to the audit window, as well as the ability to set birthdays as "unknown" if you prefer, both in the audit and the player mouseover window.

*   - It should be noted that in the GRM Options > UI tab, you can completely disable the birthday info if you choose not to track it in your guild, and the audit window will show that info as disabled and be considered "complete"

* QOL2: GRM window should now properly save its position. This is due to some changes in 8.2 that essentially made "SetUserPlaced" where Warcraft automatically stored the position you dragged the window between sessions. Now, I have to manually store the points as saved data and load it.

* QOL3: Fixed a couple misc. typos I noticed.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed and issue with the built-in backup/restore not working properly as it was not loading the guild names properly to match to the database.

* BUG2: Tooltip should no longer permanently resize in some cases, like when opening the audit log.

* BUG3: Fixed a self-resolving sync bug, so that it doesn't happen at all.

* BUG4: Fixed an issue on removing a range of log entries where it would not remove index position 1

* BUG5: Title of the events was wrapping the text and messing allignment in some cases. Fixed

* BUG6: The Communities window will now properly open when in combat when using the MicroToolbarButton, not the hotkey.

* BUG7: Advanced Join Date Audit tool should now always stay properly anchored in place.


**VERSION 8.2R1.62 DATE: June 28th, 2019**

*Further smoothing out the 8.2 transition*


**VERSION 8.2R1.61 DATE: June 26th, 2019**

*Unanticipated bug that only affects some people on the 8.2 update changes of patch R.160 release)


**VERSION 8.2R1.60 DATE: June 26th, 2019**

*UPDATED FOR 8.2 COMPATIBILITY!!! Sorry for the delay. Forgot 8.2 was around the corner.*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Cleaned up the in-game backups a bit... they were just too bloated to offer 4 points with 2 auto. The amount of memory being used on just backups was huge, especially since it has limited usability and is not really a true file backup, just a restore point for your guild.

* QoL2: Backups have been cleaned up and are now a hybrid scrollframe

* QoL3: The positioning of the text has been shifted down ever so slightly on the old /guildroster to enable mouseover buttons

*Note - there are a few things I am working on that I did not have time to get to as getting 8.2 compatibility out there was priority, but I know the tooltip scaling is an issue when opening the audit window, and I actually am rectifying this, but don't expect me to have that til probably this weekend as I am rebuilding the Audi window differently and it is a bit of work. This issue does not resolve the problem @Nightdragon#2207 is facing either, which has proven to be far more complex of an issue than I initially realized. This is an issue that won't affect most people, but with his 17 guilds, 1000 members each, and 30,000+ log lines on each of the guilds, it is a massive amount of data and kind of an extreme edge case I am trying to resolve as Lua is reaching some internal limits on how the saved data is stored and how Blizz reimports it (funn enough, Lua 5.2 resolves this automatically, but it is not what Blizz uses, so I kind of have to come up with a "hacky" solution. Eventually...*



**VERSION 8.1.5R1.59 DATE: June 19th, 2019**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Italian translation is once again nearly 100% completed, I just added a few extra lines, but it is amazing how much work is done here. Thank you again @Nihal6#8125 (discord) for all your hard work on this Italian transaltion!

* QoL2: Cleaned up the tooltips and blocked actions for more obvious controls on global settings for the join date formatting and adding.

* QoL3: Changing the guildInfo g5^ global settings should now inform you without needing to reload.

* QoL4: Player can disable the GRM mouseover window on the old roster with a checkbox. I will likely include the same feature for the community frame soon, but for now the old roster mouseover can be disabled.

![Mouseover Frame Can Be enabled or disabled on old roster](https://i.imgur.com/NtmKkao.jpg)

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Players should now be able to load the addon without issue. Before it was errneously creating a macro but would crash out if at 18 cap on personal.

* BUG2: The CTRL-CLICK on the event log and the audit window should now properly bring up the player window or the search

* BUG3: Some other misc. things I won't bother reporting since I am out of time and trying to get this update out before I am busy the remainder of the day lol

* GRM keybind Macro will now be properly placed in the general, not the character specific


**VERSION 8.1.5R1.58 DATE: June 17th, 2019**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Player Roster mouseover window now works again on the old Roster accessible with /guildroster or /groster

* QoL2: I have implemented an automatic hot-key macro to access the old roster. Just hit **CTRL-J** on your keyboard to bring it up. Of note, that "J" corresponds to the hotkey to bring up the communities interface, so if you have it set to a different key it will be "CTRL-YOURKEY"

* QoL3: The interface button to click on the bottom right of the default interface to bring up the community frame, you can now hold the CTRL key when clicking it to bring up the old guild roster interface instead.

* QoL4: The new BFA tooltip on the communities roster is now visible on the old guild roster as well.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a bug in relation to loading the guild recuitment addon frames .


**VERSION 8.1.5R1.57 DATE: June 14th, 2019**

*Nothing really **new**, just a cleanup of the previous release with a few QoL improvements. Of note, the main audit window is going to be revamped next, but I wanted to get this release out for the bugs*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Improved Scrolling controls on both the core log as well as the advanced Join date audit tool

*	- Holding CTRL while scrolling = 3x speed

*	- Holding CTRL-SHFT while scrolling = 12x speed (this is the core new thing, but many didn't seem to know you can do the others)

*	- Holding SHFT will jump you instantly to top or bottom

* QoL2: Tooltip added to the core log over them, rather than wrapping the lines, you now have a tooltip to show the whole thing. **This tooltip can be disabled by using the log tools button on bottom left of log.**

* QoL3: Click to drag anywhere is now less janky on the advanced Join Date audit tool, the event tab, and the banned tab

* QoL4: You need to CTRL-Click the users names on the main audit window now, rather than click. I found myself accidentally opening the player windows when trying to drag the window. No more!


**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Log search should work properly again!

* BUG2: Main log should now scroll properly in all cases, as well as maintain proper sorting and positioning whilst filtering.

* BUG3: Lua error resolved when trying to mousewheel scroll on the Join Date audit tool and the main log's windows when they did not have a full page of items to display.

* BUG4: Main log should no longer go crazy and rebuild copies of all fontstrings if you change the language or font size in the options.

* BUG5: New Changes/Old Log brackets when logging in to changes should be consistent now.

* BUG6: The Log tool to clear lines within a selected range is once again working properly, and even more clean in its implementation, I might add.

* BUG7: Fixed a Lua error where the scan for changes was not working properly on new players - this was reported by many people on discord.

* BUG8: Addon should no longer merge 2 join dates erroneously to designated note. Oops!

* BUG9: Namechange should properly state their former name now, not their class. Another Oops!

* BUG10: Fixed a bug where string name coloring was not properly getting removed on the calendar adds for bdays or anniversaries. This also caused some calendar checks to thinkn it had not been added.

* BUG11: Recruitment window should now trigger their frames properly


**VERSION 8.1.5R1.56 DATE: June 7th, 2019**

*Long time between patches. Lots involved with this one behind the scenes. RL was a bit busy as well. Enjoy!*

***NEW FEATURES***

**Advanced Join Date Audit Tool**

![JD Audit Tool](https://i.imgur.com/nn1ZyXN.jpg)

**Note:** This particular feature developed somewhat spontaneously and was not entirely planned. I had noticed some issues due to incorrect date reporting to the player notes with the auto-tagging, and the resulting sync info being inconsistent. Let me give you an example. If a player joins the guild while you are not online, the event is logged server side in the Blizzard built-in guild event log. This log only contains the last 100 events. Well, in a large guild the log reach > 100 events in less than a day. Thus, the addon has no idea the **REAL** date the player say, joined the guild. As such, the way the addon compensates for this is it sets the join date as the day you logged on. However, on the back end, the addon does not store that date for sync purposes because it is what I would call untrustworthy sync data. What can happen is maybe you had another officer that did get the accurate information and they were logged on and determined the true join date, and thus when you next sync with them, you sync the proper date. However, previously, the addon was still adding the join date to the default not location you had chosen (typically officer). Thus, if the player who has the accurate sync information logged the event, but did not have the setting enabled to add the join date note, but you did, you now added the incorrect date to the note, whilst you ended up syncing the proper date. You now have mismatched dates, often by only a single day.

The goal of this tool was to be able to easily guild-wide rectify this. However, I built it in a way to go over it more carefully, with the ability to modify a single player, multiple players with the Shift-key selection, or the entire guild. I ended up adding some additional features as well that can be useful tools for people that wish to import their join dates from the notes as well. Of note, THIS WAS NOT SIMPLE work. Just this tool was > 2000 lines of code, not that the number really matters, just as a representation of the effort put into such a niche tool makes little sense beyond my own amusement. Believe me, building in parsing compatibility for 18 different note formats was a bit of a pain, but really, I tried to build this with the easiest and simplest user experience that could be had. I also got distracted and used this as my template to build my first custom hybrid scroll frame. You'll notice how smooth it is in scrolling

**JD AUDIT TOOL FEATURES**

* Automatically mass fix GRM save dates by using parsed notes. It will fully scan the public, officer, and custom notes and you have the option to either import those dates to GRM, or the other way around, export the GRM saved dates and fix the notes.

* This maintenance on the join dates can be done guild wide or it can be done with a custom selection of names. Just click the names you wish to modify and it will highlight them. Shift-click to select all names between 2. I recommend being careful with this and doing a sample selection first before feeling more comfortable with the tool.

* Cleanup all notes so that the join date is ONLY in the default settings location. This tool will inform you not only about date mismatches, but if you have the join date listed in multiple notes and it will give you the ability to purge the date from the other notes automatically whilst setting/keeping the join date only in the proper default note location

* Ability to mass export all the join dates to the default note as well.

* Ability to import all join dates from the note into GRM. This supports 18 different note formats (including all 15 optional formats in GRM), as well as the Joined or Rejoined headers.

* Be aware, to save on the complexity of the addon and the bloat, this will only successfully parse the dates if they are listed at the beginning of a note. Exameple "Joined: 05 Aug '18" or "05 Aug '18" will be detected, but "John's friend - "05 Aug '18" will not be parsed properly. While this one example is easy to support, the fact that I decided to build parsing support for, so far, 18 different date formats was a lot of tedious work and to then scan for the start point has so much variability to all of them that I decided to save myself the hassle and just make it so the addon will only detect dates if at beginning of note. This can easily be modified by juse changing the position of your note.

* If there is a date format you wish me to include support for I am willing to consider it. I have considered possibly supporting "custom" headers, like "Joined" or "Rejoined" and "CustomTag" but I did not build that yet.

* Tooltip helpers are added for this tool to help you find entries in the log, bring up their player window and so on.

* The link to it is found on on the audit page, at the bottom of the join date column.

*Final Note on the Advanced JD Audit Tool - Use with caution. It mass modifies player notes. That cannot be undone since they store server side.*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: HYBRID SCROLL FRAMES!!! As a lot of people know, this is the superior way to truly do scroll frames. I suppose I never had imagined scrolling frames getting so absurdly large, not thinking long term, but when 
@Xulu#1278 (discord) got on my case about them and when @Nightdragon#2207 (discord) mentioned how he has like 30,000 logged event entries in a single guild, of a 17 guild community, and with Xulu expressing his passion for it I finally relented. I basically didn't want to bother with it for various reasons, but one is I wanted to build a template system to make it more reusable. I ended up doing just that with the new JD Audit tool and I was able to reuse the template, for the most part, for the core log. This is not entirely true as the core log is a bit more complex due to the variety of different string heigts due to wrapping and multi-lines so I had to modify it slightly.

* QOL2: MORE SLASH COMMANDS! They are now expanded to support all GRM window tabs. Example */grm users* or */grm events* or /grm options (or opt) are all supported and will bring them up with a simple slash command. If it sounds right, it probably works. Please feel free to recommend additional slash commands. They are quite simple to implement and I am a believer of the command line.

* QoL3: Addon no longer auto-adds join dates if it is not found in the event log, to improve accuracy.

* QoL4: The addon will now attempt to add the join date to the note properly, if enabled, even if something is already there. Before it just ignored adding the note. Now, it will ensure it's not already there, then merge the existing note with the date, and if it fits, it will join them and add it.

* QoL5: NEW GLOBAL SETTING! Players can now add a +/- sign to the end of g5^X to force global use of the "Joined:" and "Rejoined:" headers. Example "g5^1+" means that the default join date will be added to the officer note like "Joined: 06 Jun '19" or "g5^1-" will just be "06 Jun '19" - forcing consistency among all officers.

* QoL6: Lots of code cleanup on the backend in some places I hadn't touched since the first days of coding lol.

* QoL7: GRM Core window is now draggable no matter where you click, on all tabs (it didn't work on the log and the audit window, you had to click near top bar previously)

* QoL8: A more clear notification is given if the player's own rank changes, thus triggering a sync check, if permissions open up to sync with someone else new data. The triggered sync should only occur when the addon user's own rank has moved up. The addon will inform you *why* it is triggering this. Before it just did it.

* QoL9: The "(main)" on the side alt grouping details window is now properly *below* the main, not above, keeping position consistent with the alt listings.

* QoL10: Player should no longer erroneously get "(NG)" tag on the "(player) has logged in" system message in chat after shortly logging in. This would occur due to the GRM database not being fully loaded yet, but the System message listener already being initialized. Now it waits to modify the incoming system messages in the chat window with the tags until GRM is fully loaded and ready in the background.

* QoL11: The FrameStrate of the core GRM frame is now set to MEDIUM, to reflect most frames in WOW so you can click other flames and have them come to the front without it permanently being set on top. 

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed an issue that seems to affect a small % of the community on previous large update preventing them from fully updating properly.

* BUG2: Fixed an issue with tooltip scaling carrying over to non-addon tooltips. If GRM didn't auto-show on logon, and you selected the roster, typed /GRM the tooltip size would shrink small. Fixed!

* BUG3: Fixed an issue that could cause sync to fail (line 2313 error a few had reported).

* BUG4: Fixed an issue that could cause some reporting to never occor to the log in regars to a player rejoining the guild

* BUG5: Fixed an issue where class coloring was not being implemented properly on the promotion announcement entries of someone who just joined the guild and were promoted since before your last login.

* BUG6: Fixed some other minor misc. bugs, both cosmetic and on the back end I won't bore evryone with as they were likely not too noticeable.

* BUG7: Fixed an issue that could cause a clubID error if it never loaded properly when someone joins the guild.

* BUG8: Fixed an issue where leap year dates on non-leap years (Feb 29th) would be instead listed at Feb 1st, when they should have been listed at March 1st.


**VERSION 8.1.5R1.55 DATE: April 19th, 2019**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Added player tooltip mouseover compatibility for any other addons that utilize the guild community frame player tooltip (like Raider.io) - universal compatibility for all.

* QoL2: /grm audit and /grm ban slashcommands that bring up their respective windows is now available.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed an issue where some people's database might not load properly initially.

* BUG2: Fixed an issue that could cause some sync data to be lost or never sent

* BUG3: Misc. tweaks here and there...


**VERSION 8.1.5R1.54 DATE: April 18th, 2019**

*Minor patch update that could prevent some player's addon from loading the database properly and updating. This would only affect few people, but needed to be addressed as I didn't see the error until a report*


**VERSION 8.1.5R1.53 DATE: April 17th, 2019**

*Minor efficiency update on the database that seemed to stall on some people's PCs. Should complete a little less resource intensive now*


**VERSION 8.1.5R1.52 DATE: April 17th, 2019**

* QoL1: Adding some infrastructur for adding in custom easter eggs I wish to add

* BUG1: Fixed an issue that could cause sync to error out if at the tail end of a sync when triggered again

* BUG2: Some misc. issues with the new sync process have been corrected

* BUG3: Fixed an issue that led to some repeated join date spreading, and also cleaned up the repeats.


**VERSION 8.1.5R1.51 DATE: April 12th, 2019**

* Fixed 2 misc. bugs related to previous patch that were quickly reported :D

**VERSION 8.1.5R1.50 DATE: April 12th, 2019**

*NOTE: One of the reasons I was hesitant to go down the rabbit hole that was this patch is I just knew it was going to take a lot of effort to put out, so I avoided focusing on some things to focus on others. It was something I had always wanted to revisit, and while the updates are not fully 100% implemented in all aspects, and while there is some work still to do, we are at a significantly improved position. The delay with this patch is because I got lured into finally getting it over with, got seduced by how much easier the implementation seemed at first, then once I was past the point of no return found about 50 tentacles of the code all over the pladce that I had to deal with to get it working consistently and flawlessly.*

***NEW FEATURES***

***SYNC SYSTEM OVERHAUL***

* Sync system has been significantly updated and in some places, completely rewritten. The entire pre-check algorithm has been rebuilt and some of the sharing methods are far more efficient now. This will become obvious very quickly. Thanks @Xulu#1278 for some suggestions here.

* Theoretically, this rewrite should be the final nail in the coffin to the occasional disconnect bug that has plagued some people inconsistently.

* The addon will now report *what* information was sync'd. I think I will expand this further, but it is better than "x items updated"

* The addon now states if a sync is even necessary or not and no longer syncs without it being necessary. Be aware, while it may state "No Updates" on your end, the person you sync'd with received some info from you, or else no sync would have occurred.

* Of note, if alt data needs to be shared, while still significantly improved, this is a bit more tedious an implementation and you may find that the other areas that sync ligning fast, in a matter of 2 or 3 seconds, maye find the alt system taking just a tiny bit longer. This will be rectified further probably in the next update.

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: "g1^" global setting is returning in modified form! Use it to control which timestamp format is universally used in the guild. Add "g1^1" to the guildInfo, anywhere, to force all players. Example g1^1 = default. or g1^15 = the last selection in the timestamp format dropdown window.

* QoL2: Sort the ban list by clicking on the headers

* QoL3: Sort the alt details window (the shift-click alt window) by clicking the column headers as well

* QoL4: Addon settings are now stored automatically and sync'd after every manually change of the settings rather than only on closing the window, which could create problems if you modify settings and logoff without closing GRM window which used to be the trigger.

* QoL5: The Add Ban window no longer auto-hides if you swap windows to look at say, the Log.

* QoL6: The ban list should now re-check the GUID returns more consistently when looking at it to determine if the player has left the server

* QoL7: Patch code is in the process of being re-written, with initial foundation set and this major patch implementing the new tools. This is to prevent the code-bloat occurring on the patches now that many fixes have come and gone.

* QoL8: Rebuilt some aspects of the database to be more consistently alligned between the 2 clients.

**--------------**
**BUGS AND BUGS!**
**--------------**

*Note - Many many bug fixes, so I will just report them in no particular of what was a bigger issue.

* Bug1: Fixed an issue that seems to have popped up in 8.1.5 in relation to some calendar bug reporting on some addons.

* Bug2: Fixed an issue that allowed players using special characters to type more than the 75 character limit in the ban note.

* Bug3: Fixed an issue with the ban reasons that allowed player to overshoot the char count limit and slimmed the reasons that did.

* Bug4: Fixed an issue where a returning player's join/promo dates could overwrite other's in a sync, which is not noticeable for players that login frequently, but let's say a player takes 6 months off the game, comes back, another guildie has rejoined since then. This could occur for people who had not logged on in a very long time with GRM outdated data.

* Bug5: Birthdates should now properly sync in all cases. Found an issue here that could prevent it from occurring. This includes when you remove a birthdate, for conformity.

* Bug6: Cleans up error related to mass copying of birthdate across the guild. This cleans that error up.

* Bug7: New toons and alts of yours that join the guild should no longer write-over addon options settings with defaults and should properly sync to the already existing settings now.

* Bug8: Fixed an issue where sync would re-trigger 1 more time than as necessary on a new build.

* Bug9: Fixed major issue with syncing alts properly that was also not obvious but could end up in some alts taking multiple syncs to get tagged properly rather than on first time.

* Bug10: Fixed an isse that could occur with players returning to the guild that possibly could cause the addon to crash due to a previous bug when they left so it never recorded the date they left. The addon cannot recover that info, but it will now at least say "Date Left: Unknown" in its place, when before it would Lua error out and crash. This may have gone unnoticed as it would not break the addon completely so you'd only see it with Lua error reporting tools.

* Bug11: Fixed an issue that could prevent custom notes from sync properly on the first attempt, thus often in a subsquent sync you will see it say it was updated, but it didn't happen initially. It should now be consistent.

* Bug12: Fixed a major database flaw that could be restored using old old backups. Surprised this one was never found but I found it as I was creating some integrity tests of the database. It would only potentially affect you if you had a very old back as my update forgot to account for the backup data.

* Bug13: Fixed an issue if clicking the minimap early and it has not initialized the database fully yet.

* Bug14: Made it so the addon sync process would not trigger until the exact moment the database updates have been fully processes and the players that left and joining players have all been analyzed and updated. This is only necessary for mega guilds that kick hundreds at a time.

* Bug15: Fixed double copying of dates to the custom note that could occur if multiple officers online at same time

* Bug16: Fixed several other misc. Lua errors that I don't think are necessary to report here.


**VERSION 8.1.5R1.46 DATE: March 16th, 2019**

* BUG1: One more fix for the night! Sync Users should now display properly with people with older versions of the addon.


**VERSION 8.1.5R1.45 DATE: March 16th, 2019**

*I felt a bit off my groove for a couple of weeks. Things feel a bit better now. This focused almost solely on the reported issues when I was gone, as well as some other misc. things that came as a result of those distractions.*


**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Italian localization is back to 100%!!! Thank you @Nihal6#8125

* QoL2: Guild namechange log entry now properly is timestamped in the log

* QoL3: Tooltips for alts should no longer show whilst moused over the date selection dropdown menus.


**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a bug that could occur if still processing people that are no longer in the guild whilst sync triggers

* BUG2: Fixed an issue that could cause bans to not sync properly due to a nil value that should have been an empty string. Source eliminated, cleanup fixed. This bug likely affected a lot of people that utilized the ban list frequently

* BUG3: Fixed a slight UI bug when syncing some live join date changes.

* BUG4: Fixed some issues with regards to alt lists having doubles do to some super weird edge case circumstance that was kind of fun to diagnose and solve

* BUG5: Fixed an issue that resolves a copy bug when a player server transfers and the server shows a temporary double copy of them on occasion. Seems rare, but reported 2 times now happening.

* BUG6: Added potential fix during the sync process where when it starts syncing ban list (maybe half way through the process), a player may disconnect due to breaking throttling limits. If this doesn't resolve it then it is some other part of sync process causing it and I will need to hands on it with people.


**VERSION 8.1.0R1.44 DATE: February 22nd, 2019**

*BUG1: The log is NOW properly fixed... I had everything working but commented out the fix for just this one issue. Oops!


**VERSION 8.1.0R1.43 DATE: February 22nd, 2019**

***NOTE*** *Pending Features not quite yet ready* - I wanted to mention them as there has been a lot of discussion in discord on them, but the note searching and the mass-kick macro tool are being worked on they just weren't quite ready for release and I think I need to get this out asap.

**--------------**
**QUALITY OF LIFE**
**--------------**

*Even MORE Ban feature improvements!*

* QOL1: Adding a ban, name autocomplete. As you type, a selection of name matches will now be given as suggested selections. They will pool both the current and former guildies names together for selection. Just start typing to match!

* QoL2: Added a word count as you type in the "Reason for the ban" portion, so you know how many characters you have to use.

* QOL3: The addon will now tell you when adding someone to the ban list if it is still possible to pull their data from the server, otherwise they will be flagged with "Unable to identify."

* QOL4: "Unable to Identify" flags added to ban roster for players who may no longer be on the server. This will allow you to cleanup your ban lists a little.

* QOL5: The addon will now collect any missing GUID data tags from players that left the guild pre-8.0, before data was readily available. I have a somewhat tricky way I collect GUIDs from players who are offline. This also helps me determine if the player still exists.

* QOL6: If adding a ban of a player who left the guild before GRM was installed, or maybe was never even in the guild, it will collect their metadata as much as possible from the server and build a profile behind the scenes. The ban system will also auto-correct any mistakes you make, such as class selection, when creating the ban.

* QOL7: The addon will now tell you when adding someone to the ban list if it is still possible to pull their data from the server

* QOL8: Lots of behind the scenes details. Hard to explain, but the process is better.


**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a major issue that could cause search to not work due to finding nil values in the log. This was a HUGE potential bug that is now quashed and cleaned up. Hard to understate this.

* BUG2: Search should now work properly in all instances when using apostrophes in the search box.

* BUG3: Fixed an error that could occur when a player rejoined, it was trying to report a nil line. You may have noticed the lack of reporting of rejoins the last 2 weeks.

* BUG4: Sync throttle was modified slightly to alleviate growing concerns about disconnects that seem to have recently popped up after long being quashed. I confirmed the bulk sync feature was nerf'd by Blizz as well in that short time window. This caused me to have to make some slight changes and possibly had some ripple effects. We'll see how it goes but I suspect things will be better now.

* BUG5: The alt details window should now properly reset to the top of the list when showing when clicking on each player's alt lists from the Calendar invite lists.

* BUG6: Minor visual bug on the word count cap to send messages to players that join guild as well as the backspace not registering count changes on guild recruitment custom message character count.

* BUG7: Fixed an issue where the ban list drop-down selection of classes would not re-localize when changing languages.

* BUG8: Noticed a small edge case that could cause a player to be left on friends list evne on cleanup when it was supposed to be a quick add > scan > remove only.


**VERSION 8.1.0R1.42 DATE: February 6th, 2019**

***NOTE*** *Nothing too new here, just some minor bug fixes for some minor inconveniences as I work on a few other major things in the background. Wanted to at least get this out there!*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: French translation fully updated - TY @Enkh and Italian is like 99% complete. TY @Nihal6

* QOL2: The extra alt details window that can popout on the side with a shift-click will no longer go off screen if your game resolution is not wide enough, or scale is high. It will no overlap on the left. This is a rough stop-gap as I am actually building a new "snapping" and draggable window interface that will make it easier to place the frames around the window. We'll see what happens, but now this is a useful feature for those whose frame went off screen

* QOL3: The tooltip of the community/guild frame should no longer trigger through other frames and will now only show if there are no other windows on top of it.

* QOL4: When closing the side window to select how you want to sync all join dates, it no longer closes ALL windows, forcing you to reopen mouseover frame.

* QOL5: Noticed the Rejoins and rejoin bans were reporting in the log on separate log entry lines. This is now all on one line properly, which makes more sense. This only affects new log entries, not retroactive ones, for now.

* QOL6: Fixed some of the coloring as well to be more consistent with what they are doing. 

* QOL7: Custom notes as "additional notes" now show properly without being a jumped mess of words when a player rejoins the guild.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Promotion/demotion changes were not always reporting to the log properly if the player hadn't logged on since you last checked.This was a simple modification I did last update I forgot to remove.

* BUG2: Promotion date was still saying "Unknown" in cases where it should not have been on player mouseover. This has been automatically corrected. 

* BUG3: Inactive Returns were previously not being removed from the guild when filtered to just them, and using line number X through Y selection removal tool. This is now fixed.

* BUG4: Disabling or Enabling the reporting of when a player levels, to the log, is now working properly.

* BUG5: The timestamp formatting for Promotion/demotion log entries should now properly match the selected format of your choosing.

* BUG6: Fixed a bug where it would report a player's guild anniversary as "0 years" away on the same day they joined the guild. oops :D

* BUG7: Fixed a Lua error that could occur when a player first joins a guild whilst they had GRM installed and had just left a previous guild.

* BUG8: Fixed Lua error that could occur when setting a player's birthdate and syncing the info live to another currently online player. The data sync'd but the name didn't carry over properly for log msg in some cases.

* BUG9: Fixed an error where if you changed the birthdate of the player by adding them to an alt grouping, which auto-changed the bday to the "main," and it was not removing the old event date from the add to calendar window automatically like it should have


**VERSION 8.1.0R1.41 DATE: January 28th, 2019**

**NOTE!*** *Going down the list. It's funny... it always seems like I am taking 2 steps forward and 1 back in thbe progress. I am continually moving forward, but there's always something to distract me. The good thing is the side distractions, requests, bug fixes are all taking us step by step to a better addon.*

***NEW FEATURES***

* The player can now auto-focus the search box everytime the Log is opened, if they so choose. This is turned OFF by default. It skips the first time if set to load on logon.

* French Translation is complete (aside from my 1.41 updates which he did not have access to yet)! Thank @Enkh!!! Seriously, so much work

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: Due to some challenges in building metadata profiles of people who have left the guild, in the back and forth callbacks, delays in receiving info, a ban list could take 2 syncs. One, to sync most data, but if bans existed of players not in the guild, the other person who maybe was not in the guild when those profiles existed needs to create metadata profiles for them. this requires additional talk, and considering the delay, this could interrupt sync protocols. As such, after building the metadata profiles a subsequent sync would need to be done to complete the build for all ban list data to update. Now, the addon will determine the number of metadata profiles created of previous guildies, build them, then re-trigger a call, if necessary, for info, all automatically.

* QOL2: Italian translation has been updated and is current again (aside from 1.41 updates no one had yet). Ty @Nihal6

* QOL3: Noticed some inconsistencies in the Ban log reporting messages from sync vs live which should now use the same messages on both sides of the addon to addon comms.

* QOL4: The ban list log entries moving forward will now properly report on a single line. Previously they had the Ban info and the Reason as separate entries into the log. This is fixed now.

* QOL5:	If a player is no longer in the guild, they are removed from any upcoming events que.

* QOL6: Alt details now sorts by default the time since Last Online, rather than alphabetically (with main still at the top) -- interestingly, I wrote some code here to sort levels and ranks, but I didn't have time to build front end interface. I need ot think of how I want to implement it in a nice QoL way. Until then, default sorting by last online now!

* QOL7: Extra alt Details frame now closes alone with the ESC key rather than both windows.

* QOL8: The addon now states who the player's Main was when they are removed or leave the guild - this is only half-implemented. It seems I am not fully tracking alt/main data as good as I should once they leave the guild when I should store a snapshot of it at the time they are kicked or leave. Instead it is an unreliable tool. I will need to build the tools for this to expand on the feature. Until then, you have this small thing.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a major bug with the sync system not functioning properly and causing a lua error on some received data. The root cause was squashed and was actually quite a bit more complicated than I anticipated. This is the bug most were getting. The rabbit hole was deep lol

* BUG2: All words should properly localize now when swapping languages on the new Level Options changes.

* BUG3: Fixed a minor bug with the ban list sync system that might occur in certain circumstances. The root cause of this was also found and squashed.

* BUG4: Fixed Lua error that could occur if hitting enter on the Level filter entry when no level is selected.


**VERSION 8.1.0R1.40 DATE: January 21st, 2019** 

*Small typo fix on something was meant to be deleted*


**VERSION 8.1.0R1.39 DATE: January 21st, 2019** 

(Happy MLK Day to the USA users!)

***NOTE!*** - *I am currently in the process of just going down my to-do list, knocking out many things that were on the back burner. I am also trying to implement simple requests as they come as well as some bug fixing as priority as they come as well. As the addon grows, the complexity grows as well in adding features because there's just more and more tentacles to consider. For example, this update I managed to include the implementation of "who" banned a player, but this required a significant amount of work as the sync algorithm for the ban system, to maximize efficiency in packing in those 255 character size comm messages, as well as obeying throttle rules, is rather complex, and then to throw in a new piece of info into the mix, to carry over through several different channels not only required me to modify it slightly, I had to then add new parsing mechanisms on the other end because previously it assumed it was the end of the string, now I had to rewrite it to see this as the end of it. I had to expand array sizes, I had to build an entire front end feature to consider this. My point is that it seems "simple" for some features, like adding something as simple as the name of the player that originally set the ban on another, which in retrospect I probably should have originally included, but it took me a solid dozen hours+ of coding work just for this one simple feature, and testing to make sure it was solid. The good thing is this patch, since I dove into the ban system, sad that Blizzard didn't implement their own banning system in 8.1, I basically went all out in it too with some long overdue work on it. As a hobby project this is fun, but I do only have so many free hours in the day. I just figured I would let you guys know why maybe some things seem so simple but they actually take me a bit of time*

***NEW FEATURES***

* FEATURE1: The person who first added the ban will now be noted on mouseover of each of the bans. This cannot be retroactive, so it will say "unknown" for all existing bans. If you EDIT the ban and save it, your name will overwrite the person that set the ban as the most recent person to modify it is the one that is important.

* FEATURE2: More refined level filter options! Ability to set it to set milestones, and you can refine to which expansion cap milestones only if you want. Of note, if you have it set to announce when they hit say, 60, and you login and they went from 55 to 65, it will say in the log that they hit their 60 milestone, and are now currently at 65. It will only announce their highest milestone.

**-----**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: Player can now choose to set the log to only report an inactive return if ALL alts in that grouping are inactive. If at least one is active it won't report.

* QOL2: Rewrote the scannign algorithm to be about 95% more efficient. Yes, that is correct. Some major improvements as I hadn't revisited it in quite some time and it got me rethinking some efficiency angles and doing unnecessary work if they hadn't logged on since last check.

* QOL3: If there are currently people banned that are still in the guild, the guild tab will show a count as well as a tooltip warning to give you a heads up, in case you missed the log entry.

* QOL4: On the General Options - tooltip scale will actually adjust in size with the slider now so you can easily see.

* QOL5: Removing a ban from a player the text should now properly be class color coded of the player's names.

* QOL6: More obvious steps in adding or editing a ban

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: BAN LIST should now properly sync in all cases! 

* BUG1: One caveat, in some edge cases it might take 2 syncs to build it all because if it is a new guildie using GRM, they have to create metadata profiles from scratch for players they may have never encountered and are no longer in the guild, so what happens is they first create a blank profile, then they tell the person sending the ban information that they do not have a profile of the player yet so the player then forwards the known metadata on to build the profile properly and THEN and only then can a proper ban be established. The problem is these back and forth comms are not instant, and for me to avoid things like latency bugs, almost like a TCP protocol where you wait for a callback, rather than UDP, then it takes some seconds. Due to my lack of desire to create separate trees for qued up ban data to que up these lists, if the callback isn't fast enough it just builds the profiles without acknowledging the given ban data yet, though the subsequent sync should then work. This only applies to people wwho just installed GRM in your guild, for the most part.

* BUG2: Ban List should now properly sync ban list edits (this also was previously inconsistent)

* BUG3: Ban List should now properly sync the "ban all alts" option as well when this is chose LIVE with 2 people online at the same time. Before it seems it would sync the one name, so the player setting the ban would ban all the alts properly, but the sync'd guildie would only receive a message to ban just the one intial toon, not the alts

* BUG4: Ban List should now properly merge if a person had some bans but were too low rank and then brought up to a higher ban sync ok rank.

* BUG5: Fixed an issue that can cause some translation spam when editing a ban the first time after logging in telling you player's class was wrong as well.

* BUG6: Fixed a Lua error issue that could occur when clicking minimap too soon after login. This apparently was only partially resolved before. It wasn't major, as it didn't break anything, just error'd before finished configuring.


**VERSION 8.1.0R1.38 DATE: January 9th, 2019**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: All nearly 800 lines of translation work for ITALIAN is completed. TY @Nihal6
* QOL2: GRM sync message will be more obvious if /grm sync slash command failed to kickstart sync process properly

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a bug that will only affect people who have never used the addon before from dumb mistake I made in 1.37 update!

**VERSION 8.1.0R1.37 DATE: January 6th, 2019**

***NEW FEATURES***

*"CHANGES" and "Old Log" headers will now be visible the first time you view the log on logging in to make it more obvious the extent of changes since last login.*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: g8^ purge functionality removed from the addon. After careful consideration, it just seems like too much power for guild leader to control other's data and I hate it exists now. So, removing.

* QOL2: GRM sync message will be more obvious if /grm sync slash command failed to kickstart sync process properly

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed an issue causing a Lua error in syncing the custom note, as well as an issue with sync disconnects in relation to this bug.

* BUG2: Fixed an issue that could cause the ctrl-shift-click of the log to remove the incorrect entry, though it was the same message (like X promoted to Y rank)- This is very edge case and likely no one even noticed lol

**VERSION 8.1.0R1.36 DATE: January 3rd, 2019**

*Forgot to add English Localizations to all languages, so if you used any language but English you likely got spammed with missing key errors*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: Added the online / totalMember count to the roster tab. For some reason Blizz makes this only visible on the chat window. I find it useful on roster tab too.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a bug that seemed to be related to the new year and would have only popped up on Jan 1st and on. It likely would have stopped yuour addon from picking up new changes as it would break the scan until then.

* BUG2: Fixed an issue with large custom notes, as they were not splitting and sending backend comms properly if too large. The very large comms should now properly sync

* BUG3: Events were being announced on the calendar as dungeon events due to a change in the calendar in 8.0 that I didn't notice til now. They should now properly announce as a "OTHER" event for birthdays and anniversaries.

* BUG4: Resolved an issue that could make the main tagging not work properly if a person opens the calendar before the addon is fully loaded behind the scenes. Opening the calendar is fine, it just had an out of order check that should have been done sooner.



**VERSION 8.1.0R1.35 DATE: December 31st 2018**

*Minor update. Mostly some bug fixes. 1 new global configuration using guildInfo

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: New Global Setting! - g5^X can be added to the guild info to designate the location of the Join dates. g5^1 = officer note, 2 = public, 3 = custom

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed a bug that could allow the guild leader to purge their own data on accident using the g8+ tag! Oops!

* BUG2: Fixed a localization bug that would spam you about not knowing the key for a birthday translation.

* BUG3: Fixed a bug that could allow in some cases multiple copies of smae name to be added to alt list if spammed from a sync error (older version bug spaming backend comms to new version)

* BUG4: In relation to the previous bug, Cleans up broken alt lists that were broken from an older patch (some may have never noticed some groupings were broken)

* BUG5: Fixed a bug that could cause Lua error shortly after logging in if system message triggers, like "Player has gone offline" before it is configured properly.

* BUG6: Ban list "guild info" configuration of the global settings allowed the player to contradict allowed settings, with ban list restriction more loose than global.

* BUG7: Fixed an issue where the event announcing could be set to > 28 days (up to 98 days in advance). I wrote it to only scan 1 month in advance, not more, and thus to keep it clean I default it to 28 days in advnce as max announcement. This setting defaults to 14, but if you had it < 28, it will be reset down to max 28 and will no longer be editable a greater length of time than 4 weeks in advance.


**VERSION 8.1.0R1.34 DATE: December 16th 2018**

*Moderate update. Some bug fixes. Some bugs would be game-breaking for some players, and would not affect others. Thus, this needed to be pushed out asap!. A few other tweaks as well*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QOL1: Alt names listed as the main should not be shrunk tiny anymore.

* QOL2: Added tooltip message that you can "Right click to edit" the dates...

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed an issue that can prevent alt list from showing.

* BUG2: If more than 10 names were on the event calendar a Lua error could occur selecting wrong player info.

* BUG3: Accidentally included a spam message in the guild sync spam on birthday updates being shared.

* BUG4: Not all upcoming events were being announced if they were the next month (particularly from December to January). This is fixed. You may get a bunch of new announcements to report to the calendar.

* BUG5: Blizzard made some backend changes to the calendar, so I had to adjust the way it checked if events were already added. If it is already posted on the calendar it will not appear on your events list with a suggestion to add it to the calendar needlessly. Thus, if one player or officer in the guild adds it to the calendar, then all other players will have the option removed as it will no longer be necessary to add it. You will still have a log announcement of it and it should appear in the guild chat community stream the first time you look at it after it has been added.


**VERSION 8.0.1R1.33 DATE: December 15th 2018**

*NOTE! The !note feature has been removed. One, it was mostly redundant, since Blizzard introduced the ability for people to edit their own notes only. But two, in 8.1 Blizz broke it anyway and it can no longer be used. Blizz "protected" all chat streams now, from guilds and communities, since they are now stored. Apparently this was in an effort to prevent addon developers from attempting to use custom channels as exotic database storage (which I was funny enough, considering lol). The downside is it KILLS the feature.*

***NEW FEATURES***

**BIRTHDAYS**

* *That's right! You can now input players birthdays. They are linked to the alt grouping. I have made this as simple as possible and automatic to use. Here are some details:*

* 1) Completely optional. You can disable this in the settings. Both the ability to store birthdays as well as even see it in the options are configurable.

* 2) The date is linked to the alt grouping as it is assumed that the birthday will be the same for all players in the grouping as it is based on RL birthdays

* 3) This linking will be automatic. If an alt does not have a birthday set, but is added to a grouping of alts that does, then I will auto-set the birthday. All the nuances of this are extremely tedious to iron out to automate this all. Example, what if two toons not grouped have different dates set, but you try to add one to the other, which date takes priorty? Well, I look at if one is listed as main. Well, what if neither are. What if both are? What if one player is part of a group of alts, with no one listed as main, and no birthday, but then you add one player who is a main and already has a date? Does it override all the others? What if not a main, but it has a date? What if the large grouping has a date set, but the main does not? You can begin to see how there can be a large divere group of things to consider. I ironed out every last one to automate this for the smartest efficiency.

* 4) It only stores the day and the month. I avoid allowing the addon users to ask for the year. I do this on purpose. Some people don't feel comfortable giving their age. Not that it is likely a big deal for 95% of the community, but this spares you leaders the awkwardness of bothering with asking. It is not necessary anyway, just the day and the month is important.

* 5) These birthday events will auto-trigger to be added to the calendar as they approach as well. I HIGHLY recommend having the box checked to only announce the "mains"

* 6) Data is completely syncable and sharable. This also takes advantage of a new algorithm I am implementeing a little here and there for sync efficiency. It takes a while so one thing at a time. It is speedy, but is still extra, new data.

**GUILD REP**

* *Yup! For some reason it is hard to determine player's guild rep now without opening the /groster old window. It will now be visible and properly colored based on rank in the top right for each player. It is fully localized*

* 1) This also is completely optional, and you can disable it in the new UI panel of the options.

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: While not necessarily obvious to the user, I place this as number 1 because of the extensive backend cleanup on the process of scanning the database for events to announce to be added to calendar. I also converted the database from the use of strings in many areas to ints, thus removing the need of any string parsing when checking events. This is enormously more efficient now.

* QoL2: Cleaned up a bit of the Alt alignment, some auto controlling the font size to fit, even if a player bumps font size to 125% (in some fonts this may make the "main" alt seem a bit small.

* QoL3: A bit cleaner backend method on detecting player rank permissions in chat. The older method was a bit tedious, but it was necessary after the odd changes in patch 7.3. Well, 8.1 reverted a few of those and they are actually easier to use now and better than ever before! Sometimes they get things right!

* QoL4: Custom note sync rank filter tooltip is more obvious now what it is and how it is unique for that toon only.

* QoL5: ESC key used a bit more logically and cleanly when jumping through frames you had open.

**--------------**
**BUGS AND BUGS!**
**--------------**

* BUG1: Fixed an issue that could cause disconnects in some circumstances during a sync. I am not certain this fixes ALL issues for all players, but this definitely will resolve it for many that possibly had issues.

* BUG2: Tightened the sync process a bit further as well to prevent a bulk sync that overlaps or I should say, comes to close to the server throttle cutoff. This will likely help some people who had disconnects.

* BUG3: Sync disconnect fix 3! Additional protections added to people with low FPS when first logging in to prevent a bulk sync, or throttle down to match FPS a bit (interestingly FPS does affect throttle rate).

* BUG4: Fixed an issue that can cause a protection error when trying to mass invite people from the guild recruitment window with GuildInvite lua script. Blizzard seems to have protected it so it cannot be looped, it can only run once per click without tainting. As such I have implemented the macro strategy, where I create a premade macro with all the /ginvite (name) on each line, and with a simple hot-key press it mass invites, if you wish.

* BUG5: Fixed a rejoin bug issue where if a player quits the guild, deletes a toon, makes a new toon with the same name, it counts it as a rejoin. It should now properly only rely on GUID data, not name comparisons. Oops!

* BUG6: Found some issues that could cause problems for people whose database had been upgraded/converted after a long time of not updating the addon, and then they used the backup recoverty tool.

* Bug7: Fixed some bugs around updating from VERY old versions of the addon.

* Bug8: Fixed an issue where the "Anniversary!" was not translating properly in some circumstances on non-English versions of the addon.

* Bug9: Fixed an issue that good mingle alt groups incorrectly when adding one from two groups listed with a main, from a toon that was not a main in the grouping.

* Bug10: Addon should no longer randomly announce "XXX player is already listed as an alt" erroneously.

* Bug11: Fixed an issue with ban list syncing. - It only addresses one issue, however, this is still bugged and doesn't always sync the ban lists properly.



**VERSION 8.0.1R1.32 DATE: November 22nd 2018**

*Note! There are some big changes in the works in a couple of areas, this is taking me a bit of time, but it is in regards to the core log. I've decided to implement a hybridscrollframe and also make the log more dynamic, less static. This has a lot of tentacles in the code to deal with so it is taking me a while. In the meantime I pushed out a rather critical update for a major disconnect bug and some minor features*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Functionality has been expanded in the ability to FORCE and unify settings. The player can now force set the sync rank for ban lists and custom notes as well. 

* QoL2: Freeing up character space in the officer note, the Guild Info will now house the leader control tags to force settings. Example, g2^9 is not going to be placed into the guild info tab to work.

* QoL2: The addon will auto copy over your existing tags when you first login and configure this automatically for you.

* QoL3: The +GRM1 has been normalized to g1^+. If you used GRM1, then the addon will auto-convert the format, as well as copy it to the proper Guild Info tab.

* QoL4: Some formatting fixed that could occur in some cases with the alt list making them appear unalligned.

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: Major disconnect bug has been fixed that could occur if a player reloads and tries to auto-sync, with certain addons installed. This compatibility was hard to detect. It is now resolved in a new way so as to preserve compatibility with all addons. It might not kick them on logging in, but on a reload it would. Not anymore!

* Bug2: Manually moving the minimap icon could cause an error for new users. This is now resolved.

* Bug3: "Show main tag on all" in the settings was not showing it checked, even if enabled. This is now resolved.

* Bug4: Players that tried to manually trigger a sync with a /grm sync would often find it doesn't trigger without a 2nd attempt. Fixed!


**VERSION 8.0.1R1.31 DATE: November 2nd 2018**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Added the additional Main Tagging option to show the main tag on ALL toons, including the main, not just the alts

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: Accidentally included debug version of the addon's syunc, so you might have gotten a bit of spam in chat...

* Bug2: Players that were new to the addon that decided to manually move the minimap icon would get a lua error. I only updated this to build old databses, not add to new. Ooops!

* Bug3: Minimap position is something NOT sync'd between alts. This is intentional as on some alts people use different addons, so the one setting unique between toons is alts. The new Custom "drag anywhere" minimap button option should now properly reflect this.

* Bug4: Fixed an issue that could cause a Lua error in regards to minimap position when swapping between alts as well.


**VERSION 8.0.1R1.30 DATE: November 1st 2018**

**--------------**
**QUALITY OF LIFE**
**--------------**

*No major new features. Lots of bug fixing and quality of life adjustments for players, with some request implementations. Thank you for your patience!*

* QoL1: Syncing is less stuttery when syncing massive alt lists. There was some spaghetti code I had written a long time ago I had not revisited. OMG, it was rebuilding the entire database in a deep array copy every second lol. This could d/c at least some people, or make the game unbearable during the sync. Stutter removed!

* QoL2: The side box to input the name, when adding an alt, is now a scrollable list with up to 30 matches, to make those hard to match names easier to see. I can up the max limit, just let me know if 30 is good enough.

* QoL3: Sync is now disabled from triggering when a player /reloads -- there is no real need to trigger a sync on reload, on when logging in the first time.

* QoL4: Main/Alt tagging is now more obvious in chat, and it is also now in the System messages for when a player comes online or goes offline.

* QoL5: MOTD is now visible just by mousing over the GRM minimap button.

* QoL6: MINIMAP button can now be moved ANYWHERE (for you people that use those addons that make the map a non-sphere lol)

* QoL7: The optional message when sending a guild invite that can be included at the guild recruit window now makes it obvious you need to hit ENTER to save the message first.

* QoL8: I had built an optional DEBUG sync file for those with disconnect issues. Please ask me on discord and I will link you so we can diagnose the problem.

* QoL9: Slight optimization on just the Join Date sync information. This is just me doing a broad mass test right now on some minimal changes to my algorithm that will improve efficiency and make it a bit more lean and faster. If all seems good I will expand it to the rest of the sync data.


**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: Syncing settings of NEW players that first get configured was not working at all. In fact, it was screwing things up! If you logged on a new alt for the first time this addon installed, not only would it not sync right, it would then overwrite all of your alts you had previously configured with default settings again. HOW ANNOYING!!! Fixed...

* Bug2: Audit Log should now properly sort the Promo dates when sorting ascending or descending.

* Bug3: Fixed miscellaneous bug that caused error in some rare cases when loading CommunityFrame for the 1st time.

* Bug4: Portuguese Client should no longer spam adding friends in the system messages as they are properly filtered now.

* Bug5: Korean client was completely broken due to inability to parse creation date. This addon will now work for them perfectly.

* Bug6: A similar but different parsing error in the early configuration of the addon was affecting Mandarin Chinese and Taiwanese clients. This is now resolved and they should work properly...

*Yes, I am really debugging and testing on all 11 supported client languages.*


**VERSION 8.0.1R1.29 DATE: October 13th 2018**

**--------------**
**NEW FEATURE**
**--------------**

***Improvements to the Guild Recruitment Window***

* Player can now INVITE ALL with one button and it will invite all the players currently online

* Player can now include a guild custom message that is sent to the player when they are invited to the guild. The message can be customized up to 255 characters, or not used at all

***"KICK ALL ALTS" has returned in pseudo form!***

* When kicking a player from the guild, you now have the option to remove all of their alts nearly automatically as well

* The way this works is the addon will build a macro for you that auto-populates all of the alt names into with a /gremove altName1

* Then, it keybinds the macro to "CTRL-SHIFT-K" - This allows you to access this guild kick macro without needing it on a toolbar (A message will remind you of keybind)

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Guild Leader can now force rank restrictions logic with "g2^x" note in either the PUBLIC or OFFICER note. If it is in public, it mandates sync restriction settings guild-wide. If in officer, it only forces officer settings.

* QoL2: Cleaned up some of the UI interactions a bit. Might not be too noticeable, but they are overall better in some areas.

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: Fixed an issue related to guild sync where in some cases data would not be shared.

* Bug2: Fixed an issue where there are two copies of a player in the database from an old error if a player has not updated in a long time, fixed that, and ultimately fixed the audit log from being inaccurate on "number of incompletes"

* Bug3: The addon will no longer freeze WOW if you search the log with mature filter enabled.

* Bug4: Mature Language filter shouldn't cause repeat spam on note changes over and over again anymore if player has it enabled

* Bug5: Fixed a bug that could cause a lua error on Log tools line selection for mass deletion.


**VERSION 8.0.1R1.28 DATE: September 22nd, 2018**

***NOTE:** Long delay since last major patch was in relation to a recent job promotion at work resulting in a bit more workflow, as well as the BFA launch. I finally have a bit of a work breather, so I hammered this out. I know I didn't get everything, but I got a lot!"

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Player can now set the Custom Note as a destination for auto-joinDate adding.

* QoL2: Player now has the option to set the kick recommendation to only recommend if ALL alts in a grouping have been offline past the deadline (enabled by default)

* QoL3: Log will now display the player's public and officer notes when they leave the guild. You can toggle this on and off in the settings (under scan options)

* QoL4: The Guild recruit window now has a mass purge button that allows you to mass remove ALL guild applicants with one button (with confirmation protection)

* QoL5: Guild Leader can now set Officer note to force all officers to mandated sync restriction rank (This clearly only works for officers, as they are the only that can read the officer note)

* QoL5: -- Use "g2^X" with X being the rank index. 0 = Guild Leader, 9 = Lowest initiate rank.

* QoL5: -- So, if the GL has 2 officer ranks and wants to restrict to that, it is 0 = GL, 1 = officerRank1, 2 = OfficerRank2, thus g2^2 = officer rank and above.

* QoL6: Added a couple of tooltips that are Guild Leader only, for their own use, with instruction on how to use officer note settings (they only appear if not utilized)

* QoL7: Add alt auto-complete names as you type are now shifted more to the left so longer names don't bleed over the edge.

* QoL8: Hard reset button added in the help options... same thing as /grm hardreset. DO NOT USE unless desperate to do full reset account wide of all addon datra.

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1:	Calendar invite list should scroll properly now.

* Bug2: Calendar Date player modified should now properly be displayed in the tooltip of the calendar as well.

* Bug3:	Fixed 2 different issues that could lead to disconnect when syncing. BUT, I likely will need testers since many are disconnecting immediately.

* Bug4: Whispers were not working for some people who set their whispers to their own separate window. This has been resolved.

* Bug5: Fixed issue where Empty Officer notes were reported to the log as being added Thus "" was added was showing. (This may need some more testing)

* Bug6: Mouseover window should no longer spazz out while looking at guild professions window!

* Bug7: Fixed an issue that was causing syncing of settings among alts wrong.

* Bug8: Fixed a bug that could cause people who haven't updated in a long time to be unable to load the addon properly

* Bug9: Fixed an error that could prevent a player from updating their settings properly in 1.27

* Bug10: Fixed a bug that could cause a lua error if clicking the minimap icon too soon after logon. TY @TimeDrawsNigh

* Bug11: Player should no longer lose focus in ANY situation when typing in the calendar note windows.

* Bug12: Fixed issue on the Promotion date not showing properly in the tooltip and audit log, whilst the mouseover window did. @RedEvil11

* Bug13: System messages must be enabled for this addon to work. A source of problem for several players were those who had them disabled

* Bug13: -- The addon now properly informs them of this status and disables from moving forward until they are re-enabled, without causing error.

* Bug14: Main tag should properly show in all cases now when adding alts

* Bug15: Players with more than 12 alts could end up with misaligned alt lists. The width/wordwrap settings are now correct.



**VERSION 8.0.1R1.27 DATE: August 13th, 2018**

*MINOR UPDATE*

* Blizz made it so players can now edit their own note, even without being an officer. The addon now supports this.

* You can now toggle the public, officer, and custom note borders to be on or off in the general options.


**VERSION 8.0.1R1.26 DATE: August 8th, 2018**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Export log will now include the numbered lines if you wish.

* QoL2: Officer/Public/Custom note cleaned up a bit more to my liking... no need for the antiquated Blizz box

* QoL3: Officer/public notes should now update instantly if looking at Blizz's player details frame that pops out on clicking on the player. Before you had to click on it again to refresh. I force it now.

* QoL4: Cleaned up some custom note sync UX stuff. A little cleaner.

* QoL5: Blizz's StreamViewMarker is a little flawed and inconsistent on when we really want to scrollback in unread messages. I thus created my own tag.

* QoL6: Added right-click suggestion in tooltip on the mouseover alt names and player name, as many do not seem to know you can right click them for additional options, like setting as main.

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: Fixed an issue with retroactive !note tagging where it would scan past MORE than just the unread. Warning, you will need to logout at least once for this to trigger accurately.

* Bug2: Blizz finally fixed the CHAT_MSG_WHISPER and CHAT_MSG_GUILD properly, whcih broke my 1.25 workaround. But that's ok. It's proper now!

* Bug3: Fixed an issue with new players joining the guild where sometimes info wasn't saving accurate on first pass.

* Bug4: Add Alt should be working properly again in all cases

* Bug5: Fixed an issue that would allow new mouseover windows to popup, even though the member detail Blizz side frame was up.

* Bug6: Audit window should now properly auto-update as changes are made in ALL cases without needing to open/close the window.

* Bug7: Fixed an issue with auto-complete on the Add Alt when clicking the name instead of hitting enter.

* Bug8: Fixed an issue when syncing custom notes, shouldn't error out now, which might have crashed your sync.

* Bug9: Fixed an issue where in some cases a lua erorr could occur in showing the player promotion history on mouseover.


**VERSION 8.0.1R1.25 DATE: July 29th, 2018**

**--------------**
**NEW FEATURE**
**--------------**

*The **!note** tagging can now be done by any player in the guild, whether an officer with GRM installed is online or not. What now happens is when an officer logs on with GRM installed, they will scan the previous history of unread messages (up to 250 missed messages), and if it sees any !note messages, it will verify that they were added or not. Then, it will update those public notes that have been missed, retroactively.*

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Community frame scrolling for mouseover popup window - Keep the mouse cursor stationary, but use the mousewheel to scrool and you may have noticed that the player window did not update (not mine or Blizz's tooltip), only when you manually moved the mouse over each button.

* QoL1: Now, the names will updated on a static scroll. 

* QoL2: In relation to this, I noticed that Blizz's player tooltip seemed to work fine on mouseover with the Community window "CHAT" tab, but not the "ROSTER" tab, so on the guild community, I have fixed it, and the tooltip should now be working properly (I will remove my code if Blizz ever fixes it)

* QoL2: I have also made it so Blizz's tooltip behaves like mine behaves, where it will auto-update if the mouse is stationary and you just use scrollwheel. I have also Class colorized the name in the tooltip

* QoL3: I have figured out a reasonable way to make it so when a player joins the guild, I can build their metadata profile nearly immediately (2 seconds or less), so their mouseover works well right away. You have no idea how decidedly complicated this was considering the server call only provided me updated player data on the backend once per 10 seconds minimum, so often massive delay. No More! This is actually partially due thanks to new CommunityFrame data stream.

* QoL4: Calendar main/alt tagging should no longer reset and disappear and so on on the Calendar invite windows - it was a little buggy before, and now it should be without issue

* QoL5: Added a <NG> tag in the calendar invites... it will show over players who are invited to your event but are "Not Guildies" -- if you can think of a better tag, please let me know.

* QoL6: Added the [M] brackets format to choose from now in the main tag formatting options. Also, I made it so the tag is standardized for both main/alt formatting, and the proper format will now also show in the calendars, not just the guildied chat

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: Major behind the scenes bug fix for some players who were unable to load up addon (where they logon and window pops up but all tabs are blank)

* Bug2: Main Tags are working again on all realms, including MERGED realms. "CHAT_MSG_GUILD" is still broken on Blizz's end so I had to add a new guid check to pull full details)

* Bug3: Fixed an issuere where the "Time since Promotion" mouseover info would report the player as having joined 17 years ago (there might be some edge cases here I haven't thought of, so please report if you see the "17 years ago" bug.

* Bug4: Fixed an issue that could cause Lua erros in conflict with other addons through addon to addon chat.


**VERSION 8.0.1R1.24 DATE: July 23rd, 2018**

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Fixed some Audit Log column and fontstring allignment issues I didn't even notice until using non-English.

* QoL2: ElvUI AddOnSkins has been fully updated, and their author accepted and merged my file for their official next release (not sure when that will be)

* QoL2: I will post the file in Discord, so PM if you want it, or you can wait til their next release.

**--------------**
**BUGS AND BUGS!**
**--------------**

* Bug1: The Audit log should now properly be working again when you select the "Only show incomplete guildies" option!

* Bug2: Calendar Invite lists should work properly now, show proper alt/main tags, allow the right click context menu, and you should be able to click players with alts to see their side alt grouping window.

* Bug3: Calendar tooltips have been brought back and are working again... This was far more annoying and tedious a problem that would seem obvious :D

* Bug4: Fixed a Lua bug that could occur if you have version 1.23 and interacting with older versions of the addon (it didn't break anything, but Lua bug is annoying)

* Bug5: Fixed a translation spam error for those using non-English option when setting promo/join dates manually.

* Bug6: Possible fix for some people whose database is crashing completely on load...


**VERSION 8.0.1R1.23 DATE: July 21st, 2018**

**--------------**
**NEW FEATURE**
**--------------**

* Guild Leader can now add "-GRM1" or "+GRM1" to enable or disable, guild-wide, the !note adding ability. 

* If an officer in the game logs in, they scan the officer note, and they will adhere to the restrictions of the GL's officer note, allowing the GL to control Officer settings. This will be expanded in the future

* RUSSIAN now included, about 50%+ translated so far. TY @OldCold on discord for this massive undertaking and help

* ITALIAN AND GERMAN 99% translated as well, special shout out to @Nehry for the German and @Nihal6 for the Italian

* Note: French Translation is underway... if you have any time to volunteer help, or wish to have a language added, please let me know!

**--------------**
**QUALITY OF LIFE**
**--------------**

* QoL1: Guild Recruitment Frame can now be shown without having to open the entire communities and roster frame with /grm recruit (also improved UX over default)

* QoL1: Or just click on the hyperlink when someone is ONLINE and requesting to join the guild

* Qol2: !note tagging is now compatible with Identity2 and Name2Chat addons.

* QoL4: Option to enable or disable the !note adding can be set, and even controlled guild-wide.

**--------------**
**BUGS AND BUGS!**
**--------------**

* Fixed a HUGE bug that would make x-realm guilds mouseover not work right for all players... This was due to Blizz finally fixing the whispering and name-server tagging properly

* Calendar bug that would cause a LOT of problems... like endlessly looping sync requests, Lua errors... unable to add anniversaries to calendar, etc. FIXED

* Player should now properly see the buttons and config of the guild recruitment window

* Lua errors resolved in many instances where configuration load order was out of sync.

* Fixed an issue that could cause player to disconnect when in the middle of a Data sync and opening the Communities window for the first time, at the same time.


**VERSION 8.0.1R1.22 DATE: July 20th, 2018**

**--------------**
**NEW FEATURE**
**--------------**

**PUBLIC NOTE TAGGING FOR NON OFFICERS**

*In patch 8.0 Blizz changed the permission and officer system of guilds. They also made it so only officers can edit public notes. You are not even able to edit just your own. This resolves that*

* Type "!note" in guild chat, and anything you type after it will be auto-set to your public note by any officer that is online with the addon installed.

* Example:  **!note ilvl 300 MM Hunter - Eng/Alch**

* If I type this into guild chat, if an officer is online with GRM installed, they will then set my public note appropriately.

**--------------**
**QUALITY OF LIFE**
**--------------**

* Character count on MOTD and Guild info are now viewable again

**--------------**
**BUGS AND BUGS!**
**--------------**

* Alt grouping window on the Calendar events invite list should now close properly when closing calendar event

* Recruit window should now properly open its window.

* Request to join recruit window the top right buttons are now properly alligned.

* Guild window should now pop up appropriately when selecting player's names through things like the audit/events windows.

* Mouseover frame window flash should no longer occur when a non-guild community window is currently the focus.


**VERSION 8.0.1R1.21 DATE: July 17th, 2018**

*Massive changes had to occur to get this addon compatible with 8.0 changes. I am not sure many will appreciate the amount of effort that went in to make this happen. But, considering the extent of the updates, changes, and the addition of new features, I am certain there may be bumps along the way. Please report them ASAP so I can get them fixed quickly! Thank you!*

**--------------**
**NEW FEATURES**
**--------------**

* **SYNC ALGORITHM UPDATED FOR NEW EXPANSION!**

* - That's right, the sync algorithm has been updated to take advantage of the ability to do a bulk dump of data at 1.28MB/s within the 5-20 sec window after logging on. After that, it is rethrottled down to just over 4KB/s, which is an internal limit by Blizz.

* - This allows on first login to do a bulk sync and even complete an entire 1000 member sync within within 2-3 seconds of starting.

* - Of note, /reload does not reset the bulk data, on a full relog reopens it to the player. Throttle controls are smarter now as well, and even take into consideration Blizz's limitation of data comms on low FPS systems.

* **ALT GROUPING WINDOW**

* - On the player mouseover popup window, if you mouseover the player alts, hold SHIFT to popup a side panel with a grouping of alts with more exact data one them. Release shift for it to disappear

* - Shift-Click to keep the window open.

* **CALENDAR EVENT MAIN/ALT TAGGING**

* When looking at the invite list in a calendar, it will now show who the main/alt is for a player. The alt grouping window is also integrated for more info if you click on their name.

* **INFINITE SCROLLING**

* - While I have been a little hesitant to implement a hybrid scrollframe, I decided to keep the log from clogging the window too much, I implemented "infinite scrolling" algorithm on the main guild log, and the audit window. This should provide a smoother experience now for mega guilds.

* **AUTO MAIN TAGGING WHEN PLAYER JOINS**

* - If a player joins, while you are online, it checks the unique accounts counter, then tags the player automatically as "main" if the counter goes up, knowing it is an alt.

* - Of note, this is not always reliable, as the unique accounts is not always accurate and won't show it was a new person, even if it was, but in many instances it will work. This ONLY works live, not for players that joined when you were not online.

* - Also, there is a delay where it can take up to 10 seconds for the server to provide updated "unique account" info, so wait a few seconds on their join.

* **REQUEST TO JOIN RECRUIT WINDOW MANAGEMENT**

* - If a player request to join the guild and is currently ONLINE, the reporting is now cleanear.

* - The recruitment window now has the ability to navigate easier from one Online player to the next for invite. It will auto scroll to the first invite, and then you have next or previous buttons to continue

* - New option to Auto-popup the Recruitment window if a player comes online (or to popup once out of combat), and autoscroll to player name position


**--------------**
**QUALITY OF LIFE**
**--------------**

QoL1: Audit Log now shows the dates of the players join/promotions, rather than just "Ok"

QoL2: Audit Log each column can now be sorted, ascending/descending, by dates, etc...

QoL3: NameChange detection is now 100% flawless in BFA - due to the inclusion of GUID tags of players, namechange detection is easy to check

QoL4: In extension to this, rejoins are now flawless. This addon will absolutely now detect if a player quits the guild, namechanges outside of the guild, and rejoins the guild, it will now properly report they are rejoining the guild AND they namechanged. Great for people that get banned and think they can get back in with a name change (of note, GUID is reset on server transfer, so if they transfer back it won't detect)

QoL5: DateTime format has been added in the format "2018-07-17"

QoL6: Tooltips should now properly updated when hitting the ESC key, like on the events window panel.

QoL7: Ban List, Users, and Events windows should now have their columns properly alligned.

QoL8: Default scan time has been changed, for new players, from 10 to 30 seconds, to prevent spamminess. 

QoL9: Default BFA position of the memberdetailframe was poorly placed over the side tabs. This fixes that.

QoL10: Lots and lots of code optimization on the backend thanks to some major code changes by Blizz. This addon fully takes advantage of them.

**--------------**
**BUGS AND BUGS!**
**--------------**

*In no specific order of important, as they ALL are improtant to me!*

* Bug1: Fixed Lua error that could occur on some people's event calendar when trying to ignore the anniversary event.

* Bug2: Count should now properly display when syncing... before it was counting "mains" as a sync count, even if there were no updates.

* Bug3: Fixed an issue where player names were not saving properly if added manually through the Ban list, and the first character was a special character.

* Bug4: Fixed issue where Ban list was saying there was a localization bug when trying to edit a ban.

* Bug5: Player settings should now properly sync between alts as in some cases this was not working for some people.

* Bug6: Guild Log button frame strata on the roster window should now be appropriately matched.

* Bug7: Fixed a major bug that made it not possible to add certain players to the ban list if you were in a guild that had a large number of people who had left the guild. This would ONLY be an issue for mega guilds.

* Bug8: Fixed an error related to a conflict with the chat-chat plugin for ElvUI

* Bug9: Fixed a bug that was causing the calendar "Mass Invite" window to close

* Bug 10: Fixed a bug for players using 24hr time notation instead of 12hr clock that could cause their join/promo dates to be Jan 1st, 2001

* Bug 11: Friends lists should now be properly cleaned up if you disconnect or logoff in the middle of an Online check of the Request to join players... where you log within that 1 second window before removing them.

* Bug 12: When banning a person and all their alts... the ban "reason" was not carrying over to the alts properly. It now is.



**VERSION 7.3.5R1.1530 DATE: June 4th, 2018**

*Prepping for some big updates in BFA... so please, be patient and I will make sure we are rolling good for some big improvements. Looks like guilds being integrated into communities too so that will require a significant rework of things as well!*

**QUALITY OF LIFE**

* QoL1: For new players that join the guild, adding join date to officer/public note is turned off for people that install this addon going forward. It is an optional feature that needs to be manually engaged.

* QoL2: Previously, when a player left the guild it wiped some data I deemed unnecessary and only stored things like dates and so on. It did not store the alt lists. I have no idea how I logically deduced that was a good idea lol. So, while the alt list is reset if they rejoin, as necessity, you now have access to their previous alts when they left the guild, thus if you choose to ban the player after they left, you will now be given the option to ban all their alts as well. This unfortunately cannot be retroactive.

* QoL3: Ban List management even more streamlined. When a player types in a name it autoformats the name, then if on tabbing or moving to another box, if it finds the player in the guild or in the LeftPlayers list, it auto populates their class and auto-formats the name for adding.

* QoL4: Count now included on the number of items added sync'd.

* QoL5: Status on being able or not to add events to guild calendar has been added to the window.

**BUG FIXES**

* BUG1: Tooltip was once again, erroneously scaling ALL game tooltips when it should have just been scaling this addon's only. This would make smaller fonts like in ElvUI really difficult for some people. This is now once again FIXED. Oops!

* BUG2: Major bug fix for broken databases that never fully converted right for people that maybe haven't updated in a very long time. Thanks @chay on Discord for letting me use your database to debug this one.

* BUG3: Due to some formatting issues and non-precise user input error protections, the addon will now re-analyze the entire database and properly format any player's names that were manually added to the ban list, so they can properly be detected if they rejoin the guild.

* BUG4: Addon Settings were not properly syncing between alts, if you had that setting selected, at least not always. It is now wrapped properly and should work now. The first toon you logon to, verify their settings, and then from there the settings should sync properly.

* BUG5: Rejoin data "time passed" since they left the guild should now be accurate.


**VERSION 7.3.5R1.1520 DATE: May 27th, 2018**

*Got a little busy with RL and a promotion at work, so understand if the updates haven't been quite as speedily. I still am doing a little here and there, of course!*

**QUALITY OF LIFE**

* QoL1: Italian translation is now included! Thank you so much @Nihal6

* QoL2: When exporting the log, it should now obey the filters too, it won't export the entire log, just what you see based on your filters.

* QoL3: On manually adding players to the ban list, it scans if the player has "alts" and automatically asks you if you would like to ban all of their alts as well. This was previously possible when banning players in the guild, but now, on manually adding a guild ban it will check

* QoL4: Players now have the ability to EDIT bans.

* QoL5: Ban player interface a bit more user friendly and higher quality. Better tab or shift-tab for navigation, even up/down arrow use on the dropdown menu if you prefer.

* QoL6: Added some tooltips for some buttons, if they are localized in a language with a very long phrase, the scaling might get too small, thus tooltips on button mouseover should help clarify some more.


**BUG FIXES

* Bug1: Fixed a bug that could occure when a player is not in the guild then joins the guild, triggering scan for update.

* Bug2: Fixed a bug that could cause the player to lose keyboard focus when trying to edit calendar event.

* Bug3: On some occasions the guild ranks were not properly setting their indexes due to ranks being added or removed. This could cause serious sync issues downstream, as well as log spam. Fixed!

* Bug4: Fixed an issue with the German translation where ti would spam you saying you didn't have a string translated.


**VERSION 7.3.5R1.1510 DATE: May 2nd, 2018**

**MINOR FEATURE UPDATE**

* *GERMAN IS NOW FULLY LOCALIZED*

* Custom Note is a bit more accessible with the ability to have line breaks

* Hit enter, go to next line. Added Confirm and cancel buttons. Better control of Custom note display as a result.

**QUALITY OF LIFE**

* QoL1: Added ability to change timestamp format to your preference.

* QoL2: Furthermore, player can choose between the 24hr clock or the 12hr clock for log reporting times

* QoL3: "Time as Member" is now included in the log entries when a player leaves the guild, but only if it was known how long they were a member. If their join date was never configured this will be ignored.

* QoL4: "Time as Member" now included in the mouseover tooltip on the Member join date. 

* QoL5: "Join Date" button is now properly alligned, I just never noticed since I use the English version...

* QoL6: Auto font Scaling is now included for many buttons so they don't overlap out of bounds of their frames. This is necessary for some languages, like German, with very long words.

* QoL7: Add Alt button slightly increased in size, mainly to accomodate other languages, but it is also just cleaner, easier to click.

* QoL8: Added tooltips for mouseover of the options sub-tabs as some non-English words were too big to fit reasonably.

* QoL9: All promotion dates are now cleaned up, as some, due to an old bug now eliminated, had the 12:01am timestamp visible.

* QoL10: Events Frame cleaned up a little bit in preparation of pending new features

* QoL11: Ability to click the player's name in the events tab and bring up their player window (with tooltip over the names now)

* QoL12: Pressing escape in the events window now de-selects a player rather than closes the whole window, or closes the window if no player selected

* QoL13: Option to enable/disable the "fade" when moving between tabs

**BUG FIXES**

* Bug1: Bug on load for some people who haven't updated > 6 months

* Bug2: Localization issue fixed for not properly updating anything with a number

* Bug3: Fixed a very old bug where it was not giving the exact day properly on the recommend to kick a player who has been offline X number of months. The logic has been completely updated to even support with exactness on leapyear checks too. Before it was just a close estimate. Not it is 100% precise.

* Bug4: Fixed an issue where the custom note was not updating the log immediately upon the change.

* Bug5: The friends list spam on occasion would still happen. This was kind of wonky because even with delay checks and so on, sometimes the server would not detect a change and get a callback for a few moments, but there was no specific event to listen to to wait for the callback, so I had to ballpark it. Well, you get a lag-spike and you might get spammed. I figured a protection workaround to prevent the "added to friends" spam if you have a lot of people on the guild request to join page

* Bug6: Potential bug fix for the mass-custom note spam syncing - needs testing.

* Bug7: Not yet translated count now visible again when selecting which language you want.

* Bug8: The GRM tabs were not localizing on the language change, they are now.

* Bug9: "Time passed since..." player left the guild, was not online, etc... should now be exact to the day and was reporting wrong before.


**VERSION 7.3.5R1.1501 DATE: April 22nd, 2018**

*Fixed a bug that seems to affect SOME people, not all, causing the addon to fail to properly load*


**VERSION 7.3.5R1.1500 DATE: April 22nd, 2018**

**QUALITY OF LIFE**

* QoL1: Tooltip added to audit window over the "Unique accounts" to make it more clear that the server is not always accurate on these details, and hopefully Blizz fixes that.

* QoL2: For NEW users only, not retroactive, the base rank in the guild is now the default on the player details, like alt/main, etc... The reason is that now that ban lists, and custom notes and so on all have their own threshold filters and as such, with much tigher sync controls existing, it makes since for players to share data with each other by default. I say this as it seems 9/10 players that install the addon NEVER bother with trying to change any default configurations, thus they end up not sharing anything. This was originally only heavily restricted by default due to an imperfect process with less filters.

**BUGS**

* BUG1: Players were unable to click player alt names to bring up their details, in the list. It should work again.

* BUG2: Custom Note spam was only partially previous resolved. If you cleaned up your notes using '/run GRM.ClearCustomNoteMatches("Matching Text")' then if the OTHER person in the guild did not, you would proceed to immediately resync and receive all of those notes again. So, unless ALL players in the guild used the tool, you would just keep getting the data. This now ensures that a proper timestamp gate is in place to prevent accepting outdated data.

* BUG3: Fixed an issue with compatibility with backups for guilds players haven't logged into in a LONG time with OLD databases...

* BUG4: Fixed an issue where the backup tab wouldn't load any info for some players.

* BUG5: Removed chat spam when removing lines from the log... accidentally left debug chat msg from last patch

* BUG6: If the player had rank restrictions saved at say, the lowest rank, then the GM removed the number of ranks in the guild from 9 to 8, the player would need to manually reconfigure the sync in the settings. Now, it is done automatically if the ranks have been modified or deleted, it will push to the next equivalent "lowest" rank when it would previously bug out.

* BUG7: If the player had returned from inactivity within the last 60 minutes, the addon was waiting until they were at least offline again for 1 hr.

* BUG8: Fixed a HUGE issue where people that had used the "sync alt join dates" feature was not properly reporting all anniversary dates as they arrived, especially if you had it unchecked to limit to only the main, and in some cases it would only report one player, not even necessarily the main.

* BUG9: If the player checks the box to ONLY display "main" anniversary dates now, the event log should properly update to only show the main anniversaries.

* BUG10: It was checking the scan every 10 seconds regardless of the time interval on scan settings. Oops!

* BUG11: Fixed an issue where if a player joins the guild it could trigger a parallel scan, wasting resources, potentially causing double report conflicts

* BUG12: Fixed a significant issue where a double report of a promotion/demotion change could go to the log.

* BUG13: I found one more instance where names added to friends list to check online status, then removed, were still announcing to chat. This is removed now. I have extensively tested it now.

* BUG14: Fixed a bug when updating a VERY old version of the database it would fail as it was not considering the old guildName format.

***FINAL NOTE***
*I am working on a larger feature right now but it's taking me a lot of time, more than I had available. Also, my allergies have been impossible this week, greatly limiting how much time I could look at a computer screen comfortably. Seriously, my left eye in paticular was so bad for 2 days that it was nearly swollen shut from allergies and only Zyrtec is "sort of" helping (typical for this time of the year for me). So, I spent a lot of time off the PC. But, it's coming! Oh and, I got a little distracted with a new side project that is absurdly useless, but I want it. You'll see when it's ready.*


**VERSION 7.3.5R1.1492 DATE: April 13th, 2018**

*Fixed an issue for people that had a bug that seemed to effect people with guilds with rather old databases in the background that were trying to be converted...


**VERSION 7.3.5R1.1491 DATE: April 13th, 2018**

**MAJOR DATABASE LOOKUP CHANGE**

*Recently it has come to my attention that there is a flaw in the API call to Blizz's server to obtain the "Guild Creation Date" - For some reason, a few weeks back when the daylight savings change hit, all of a sudden a few guilds started reporting that they lost their data, except in the backups they now had 2 guilds, both of which being 1 day off. Thus, it seems likely that Blizz did not consider, accurately, timezone translations perfectly, and as a programmer myself, I find this kind of understandable. So, it is likely that guilds that were created within maybe 1hr of the day change likely might experience this issue where all of a sudden the API call from the server is reporting your guild as being created 1 day different. You can see the info yourself with a /ginfo*

*Well, I could just easily look into it and find guilds with the same name and parse out the dates and see ones 1 day apart, and then fix that, but ultimately I wanted a better solution to this issue, one with no exceptions or edge cases. Thus, I managed to discover some buried API, undocumented on any of the unofficial programming sites, on how I could get the server the guild was created on. You see, if I can just tag the server to the guild, that would be the best way to identify guilds uniquely, when before I tied their name to their creation date. This presented a problem since on merged realm guilds there did not seem to be a way to determine which server the guild was made on. Fortunately, I figured out a solution and even better, it is going to process and re-convert all of your databases to be compatible with this new info all behind the scenes. It also changes the way database queries occur.*

*This was a rather complicated process because I now have to consider the old databases that have not been upgraded yet, and have to deal with managing backup information from guilds you have not logged into to parse the server they originated on. So, it took a bit of conditional coding to get it just right, but I did a bit of testing with it and I am satisfied with the result. Thankfully, in 5 months when the next daylight savings happens again, guilds won't be SOL on their data again as their guild creation date shifts 1 day again.*

**QUALITY OF LIFE**

* QoL1: There is now a hyperlink to click when a player comes online, and is requesting to join the guild. Before the hyperlink only existed when it reported initially how many requested to join, even if all were offline. Now, it re-gives you the link when someone logs on.

* QoL2: Tooltip in the options Backup tab now properly scales, and now includes the guildaname in the mouseover tooltip, in case the name-server is so large it is cut off

* QoL3: Guild namechange report in the log is a bit cleaner now.

**BUG FIXES**

* Bug1: Fixed an issue where when adding an alt, instead of epoch timestamping the event, it leaves a boolean. This went unnoticed and is likely responsible for some lua erors during sync

* Bug2: Fixed a MAJOR issue where the "Auto" backup did not save the data properly, particularly for the logs. Manual backup data is finem but the auto-backups had to be reset, sadly. This was NOT an easy choice, but the previous database break was so bad it probably wasnt' worth the effort to retrofit them.

* Bug3: Public/officer notes, for a player with a massive font, should now stay within their boxes.

* Bug4: Noticed an instance where sync could send a message it was starting, then failed for whatever reason, and never re-triggered to check again, thus you end up hanging for a while wondering what happened.

* Bug5: In the options, the edit box to change the number of days to be notified in advance of an event to add to the calendar is now working again.


**VERSION 7.3.5R1.1483 DATE: April 11th, 2018**

**BUG FIX**

*I accidentally had sync disabled on the backend and forgot to restore it for release after testing... So all of your addons would not be able to sync at all. Major OOPS!*


**VERSION 7.3.5R1.1482 DATE: April 11th, 2018**

*NOTE: Due to an error that affected some players in the previous update, where the custom note was added to every player in the guild, I have included a tool here to modify that*

Type this out in chat:

> /run GRM.ClearCustomNoteMatches("YourText")

> "YourText" can be any identifying string to match your custom note. BE SPECIFIC! It is case sensitive. Make sure it is unique to the spammed one.
 

**BUG FIXES**

* Bug1: Sync bug that could occur when trying to sync the alt data, which would ultimately crash the sync. This has been in there a long time. I am surprised it hasn't been noticed til now, but it's critical

* Bug2: Custom note should no longer be copied to ever player (only affected some people)

* Bug3: Tooltips should now ONLY scale within this addon, not affect others.

* Bug4: When doing a '/grm clearguild' in some cases lua errors could occur when refreshing the audit frame

* Bug5: Edge case bug involving sync and when someone has removed and added alts to the same name a LOT of times.

* Bug6: Namechange bug should now be fixed and not englessly spam (though needs better real-time testing)

* Bug7: On deactivating the Roster scan in the options, it should now properly interrupt and deactivate the current scan.


**Quality of Life**

* QoL1: The log now reports the player IF they were promoted when they join the guild. In other words, if someone joins the guild, they may be quickly promoted before you have logged in to log it and now the addon will correctly state they were promoted rather than just log their new rank as their base rank.

* QoL2: Add Alt window should now say "Shift-click" not "shift-mouseover"

* QoL3: Custom note should now properly resert visually in ALL cases when canceling the edit with the ESC key, or any reason

* QoL4: Custom Note window is now correctly alligned

* QoL5: Tooltips for THIS ADDON ONLY can now have their size manually adjusted in the options

* QoL6: All options dropdown boxes are cleaner now.



**VERSION 7.3.5R1.1481 DATE: April 6th, 2018**

**BUG FIX**

* Found an instance where it can crash and get Lua errors because it was incorrectly indexing the new custom note in an array.


**VERSION 7.3.5R1.1480 DATE: April 6th, 2018**

**NEW FEATURE: Custom Note**

* 150 character limit on note rather than the tiny default 31.

* Ability to sync the custom note with guildies

* Custom note sync restrictions can be made per character in the guild, or overall

* Ability to disable custom note sync bother overall, or on a per character basis.

* Details WHO made the modification, and the date of the note edit on mouseover.

**QUALITY OF LIFE**

* Huge overhauls of the "Sync" tab in the Options, with many helpful tooltips and coloring to make sync restrictions and controls more clear

* Sync messages are now a bit more clear as in some cases they were not if one-way syncs were occurring, where the player would send data to all, but restrict incoming to threshold

* The main log search box, if typing too fast it could disconnect a player trying to rebuild the log too many times in a second. There are now protections in place to prevent this for you speed typers!

* Officer and Public notes should now be displayed in the log when new players join the guild. Previously they were filtered out as to avoid spamming the log with join dates. However, if a person had joined the log when the addon user was offline, modified a useful note, it would not announce it in the log. It now will report ALL public/officer notes with exception to the "Joined:" ones

* Dropdown menus for date editing, as well as much of them in the Options controls have been modified, cleaned up, and made more symmetrical for aesthetics. The side buttons are removed, and you now can just click the menu.

* The dropdown menus for date editing in the player window should now properly close with the ESC key rather than closing the whole player window.

* The note/officer note edit boxes should now properly resert if you were editing them and click another player, preventing accidental overwriting of older notes.

* Anniversary announcements in the log now include the timestamp, as well as class colored player names.

* While building the sync feature for the custom note I noticed a few places of the sync process that could be optimized better. Yay (prob won't be really noticeable for most)!

**BUG FIXES**

* CRITICAL BUG!!! Load bug preventing players from loading anything but an empty frame, is now resolved.

* Removing and restoring backups should now work for ALL language clients, not just English.

* Players requestion to join the guild will now properly say "OFFLINE" if they log off after being tagged as online.

* For the final time, for REAL this time lol... Add or Remove friend spam should not be visible and players should not be left on your friends list.

* The addon will no longer try to add more to friends list for online status check they are already at the 100 friends cap. If a player has 25 people requesting to join the guild, but only 10 free spots, it will stop at telling you 10 players online status, with a one-time recommendation to free up your non-battletag friends list, but will no longer try to add more than 100 friends ot the list. They will now say "Unknown"

* Audit Frame tooltip was not properly hiding.

* "Guild Recruits" hyperlink in the text, reporting players who are requesting to join the guild, should now work with ElvUI

* In some cases sync was not full restricting outgoing data, even if the player had it sync restricted. This only applied to the join/promo dates, and alt/main lists, not ban lists

* Also, rank filtering is now a bit cleaner on the backend as a result of digging deep into all of thus.

* Adding events to the calendar should once again sync properly live.

* Fixed an issue whre sync could just hange and do nothing.

* "Show on Logon" checkbox's clickable range was too far to the right and overriding the other checkbox.

* If a player had auto-sync disabled and typed /grm sync for a one-time sync, in some cases it would not properly re-disable and would then be open to continue syncing with other players.

* On resetting an individual player's info, in some cases the alt removed data could linger and mess things up. Lua errors should no longer appear.\

*FINAL NOTE: I didn't get to everything I wanted to. There is still SO much work to be done! This patch was a fairly significant time-sink for me. All of the reports are definitely noted. Some things I did not resolve as of yet. Thank you for your patience!*


**VERSION 7.3.5R1.1472 DATE: March 29th, 2018**

*The addon would not work for NEW users after last update. This is now fixed*

**VERSION 7.3.5R1.1471 DATE: March 29th, 2018**

*Shift click was not working properly on the audit frame...*

**VERSION 7.3.5R1.147 DATE: March 29th, 2018**

**BUG FIXES**

* Bug1: The Allignment Lua error that is crashing the scan, preventing any new information from updating and being saved, is now resolved.

* Bug1: Number of guildies not showing up in the raid window should now properly show again.

* Bug3: Names should no longer be errneously added to the friends list.

**QUALITY OF LIFE**
 
* QoL1: In the AUDIT window, players can now shift-ctrl-click a name for it to auto-search the log for any events concerning them.



**VERSION 7.3.5R1.1461 DATE: March 24th, 2018**

**ADDON BREAKING BUG FIX**

*Ya, your addons should load properly now... Wow, silly bug!*


**VERSION 7.3.5R1.146 DATE: March 24th, 2018**

**NEW FEATURE**

* Feature1: Custom Font Selection!

* Feature2: Font size slider controls! (For minimal adjustment)

**QUALITY OF LIFE**

* QoL1: Red lettering of the line numbers on line selection in the Log tools should now show or clear properly in all circumstances one is viewing the log

* QoL2: Refactored a bit of the load order of the code, and avoided double-processing some of the code upon reloading issues when they don't need to be. It's minimal, but it could shave off a bit of extra processing power use.

***BUG FIXES**

* Bug1: Player friends list should no longer spam the player when people are requesting to join the guild

* Bug2: Names should no longer accidentally be left on the friends list.

* Bug3: More SYNC protections... A major guild introduced me to a new load error gap in protections on double-syncing. It was a flaw in the code that occasionally could trigger a player syncing to disconnect. This resolves it.

* Bug4: Spam message "player not found" should no longer trigger erroneously.


**VERSION 7.3.5R1.145 DATE: March 21st, 2018**

**NEW FEATURE**

*Guild requests window now displays if the person is ONLINE or OFFLINE. Seriously, it is so annoying not knowing if the person requesting to join your guild is online or not. Now you know!*

* Feature1: Notifications now added for when a person requesting to join the guild comes ONLINE. No need to keep checking, just wait til you are notified!

**CRITICAL BUG FIX**

* Bug1: Major sync bug that could cause people to disconnect if there are 3+ people trying to sync at the same time. It would not happen every time, but I found a hole in the gate that has now been fixed.

* Bug2: Some names the custom "Add Ban" window was not accepting even though they are valid. It should be good now.


**VERSION 7.3.5R1.144 DATE: March 19th, 2018**

**MAJOR BUG FIX**

*It has come to my attention that the last update, while significant, also broke a few things... this patch rectifies that, particularly the one that makes the addon not useable lol*

* Bug1: Upon logging in, the player will get a blank addon window, but nothing else, and nothing is tracked. This is due to the frame generating, then all addon logic crashing before being loaded. This should be resolved automatically now.

* Bug2: Fonts were automatically getting changed, due to an oversight. They should not auto-be changed now unless you are swapping to an acryllic or Asian language to support those characters.

* Bug3: Minimap stopped saving its position. This should properly be working again.

* Bug4: Shift-Click on adding a name to the alt-add frame was closing the window IF you had the memberdetailframe (one with promot/demote/kick buttons) open. That side window does need to be hidden due to some taint issues in me not being able to override default in-game click actions, so I just hide it while you shift-click, but the add alt window should no longer disappear.

*I should note, I did a lot of behind-the-scenes pruning and cleanup of the code as well. This might not be noticeable to you, but it is noticeable to your CPU!*


**VERSION 7.3.5R1.143 DATE: March 16th, 2018**

**NEW FEATURES**

*The Log has been updated with quite a lot of new features, all for the goal of allowing you the flexibility to manage it far more than previously.*

***INCLUDED LOG FEATURES:***

* Log EXPORT is now possible! Just copy and paste into another document.

* Numbered Lines is now an option you can toggle on and off

* The ability to purge any range of lines in the log. For example, if you want to delete line 150 to 180, you can! It will also take into consideration your filters, so if you want to remove just those pesky leveling entries, just custom search for "Leveled" and then clear whatever range of lines you'd like.

* Ctrl-Shift-Click mouseover single line removal is now a toggleable feature.

*NOTE: I have determined that the smart/infinite scrolling is just not really that necessary anymore with these new log controls, even though I had plans to add it.*

**QUALITY OF LIFE**

* QOL1: Language Selection is now possible from the general settings menu. Of note, most languages have very minimal localization work done. A counter is given to display how much translated work needs to be done. Any help is welcome.

* QOL2: Ability to add non-Blizz Client languages as well. Have a request? Let me know and I can add ANY language now with my new system.

* QOL3: Sync chat spam should be cleaned up a little. It was overly spamming as of a recent update.

* QOL4: Player is now capable of Shift-Clicking the player window alts list names to copy them now as well, not just the roster window

* QOL5: On promotion Date editing/adding, you could sometimes click through the dropdown menu to the button behind it. This is no longer possible.

**BUG FIXES**

* Bug1: ColorSelection in the options is now compatible with ElvUI, ColorpickerPlus (this also fixes tabbing and selection) and doesn't overwrite their superior color-selection frames



**VERSION 7.3.5R1.142 DATE: March 11th, 2018**

**NEW FEATURES**

* Feature 1: You can now choose the format of the <M> main tagging between 4 (as of now) different versions. Please submit other suggestions.

* Feature 2: You can now choose which color, manually, based on RGB values or the color select wheel, for what you would like that main tag to look like.

* Feature 3: The Color Select window now universally, for anything you wish to use it in the game, has manual RGB values. Before these did not exist and are unique to this addon.

**QUALITY OF LIFE**

* QoL1: The Color Picker Window is now moveable (before it was static and stuck in place in the center of the screen)

**BUG FIXES**

* Bug1: The search box in the Log was not resetting properly if you tabbed off it or closed and opened the window, but the log was still resetting. The whole process should now work appropriately

* Bug2: The Autobackup of the database time-interval would default to once per day if a person "Reset to Defaults" all of the addon settings. It was supposed to default to once per week, or 7 days.


**VERSION 7.3.5R1.141 DATE: March 9th, 2018**

**FEATURES**

* Feature 1: The LOG is now SEARCHABLE!!! (With a count now on the log of how many entries visible)

* Feature 2: Player SYNC now has a new option! You are now able to choose to share your data with the whole guild, so all players can take advantage of it, yet restrict incoming data to a rank threshold, or to keep it how it has been.

*Of note... coming features include an option to export the log, as well as smarter scrolling with partial log loading (like 200 lines at a time until you scroll far enough it will load more)*

**Quality of Life**

* QoL1: When Player is hitting ESC key and both the mouseover window and the core addon "log" window are up, it should now more cleanly and properly close each window sequentually.



**VERSION 7.3.5R1.140 DATE: March 8th, 2018**

**BUG FIXES**

* MAJOR BUG!!! Major issue with the backup database. You can read the explanation in the chat on update. It makes me sad, but backup database needs to be wiped due to a massive critical flaw in build design. Very much apologize for this but it should be good now.

* Bug2: Fixed an issue where some settings were not saving properly, like hiding the minimap.

* Bug3: Backup window, the Number of Guildies display was misaligned and should now be properly spaced.


**VERSION 7.3.5R1.139 DATE: March 7th, 2018**

**Quality of Life**

* QoL1: New tooltip on the backup window when mousing over the guild. Option now included to purge that guild from your database. This is necessary for people who are using up memory for guilds they are no longer in and so on.


**VERSION 7.3.5R1.138 DATE: March 6th, 2018**

* BugFix1: Fixed an issue that could cause 2 syncs to occur at the same time which could cause a disconnect for a player. Doesn't happen often, but with many using addon there is a chance the timing could be just right to erroneously trigger it.

Note... lots being worked on, this is just a minor update to resolve this bug.


**VERSION 7.3.5R1.137 DATE: February 28th, 2018**

**NEW FEATURE: Auto-Backup**

*The addon will now auto-backup your guild data. Of course, you can manually back it up as well. The auto-backup can be set to a custom interval and it will keep a max of 2 unique auto-backup points per guild. It defaults to backup every 7 days.*

**QUALITY OF LIFE**

* QoL1: Ability to "Check All" has now been included in the Log filter options

* QoL2: ElvUI "AddOnSkins" plugin has been updated to include the backup frames as well

**BUG FIXES**

* Bug1: Backup was indexed wrong and was skipping over a guild. In other words, if you were in 5 different guilds, it would only show 4 in the backup window.

* Bug2: If the player had not logged into an old guild in a log time, to update the "Creation Date", the backup frames will now say "Unknown" - Log into that guild to update that info.

* Bug3: Guild namechange was not transferring all of the data properly under the new name. It now should properly detect and transfer the data.

* Bug4: Misc. Lua errors here and there have been quashed. TY for reporting!!!


**VERSION 7.3.5R1.136 DATE: February 23rd, 2018**

***NEW FEATURE***

*Guild Database Backups! That's right, scan through every single guild, on all of your toons account wide and add, delete, or load backups! It backs up everything, including the log.

**Things Not Yet Implemented, but soon Will be**

* Ability to do account wide backup...

* Ability to reset all data with one button

* Safety confirmation to ensure you want to restore from that save point.

* Auto-save point...

*Of note, the backend is already written for most of this, just need front-end implementation. Just been very busy in RL. Getting there.

* Bug1: Guild Namechange detection should now work properly with the new data change check as well...



**VERSION 7.3.5R1.135 DATE: February 20th, 2018**

**BUG FIX**

* Bug1: If you ever cleared your log since patch 1.130 you broke the database. Well, I broke your database because I messed up some code! This fixes your database so you can once again see your log lol

* Bug2: Lua error was crashing sync. Fixed!


**VERSION 7.3.5R1.134 DATE: February 13th, 2018**

* Quick fix for major flaw in previous release that crashes the TimestampToEpoch function, thus making sync and data log save impossible for many players...

**VERSION 7.3.5R1.133 DATE: February 13th, 2018**

* Fixed major database issue in regards to the guild creation date. This will resolve some of those issues.

**VERSION 7.3.5R1.132 DATE: February 12th, 2018**

* Fixed an issue when mousing over player alts names that could occur in a lua error

* Fixed an issue when removing an alt from the guild. Due to previous issues, if a player had been removed from the guild, but it crashed in the process, alt data might still be lingering in the bakcground. This can cause the gkick/left reporting to no longer work as it would result in a check against a null database. This cleans up the old database and resolves that issue.


**VERSION 7.3.5R1.131 DATE: February 11th, 2018**

* Bug1: Fixed a Lua error in regards to join/promo dates that I introduced this last patch in relation to the GRM.TimestampToEpoch() function

* Bug2: Several non-English clients were not parsing the guild creation dates properly. This has resolved that issue for ALL languages

**VERSION 7.3.5R1.130 DATE: February 10th, 2018**

*The Bug Squashing Update!!! And many other Quality of Life improvements. Of note, I have a major FEATURE release coming soon, I just couldn't get it done in time.*

**QUALITY OF LIFE**

* QoL1: The Log will now state the correct date the player joined the guild, was promoted, demoted, or left/quit the guild. If it is unable to find the date because this happened before is visible in the log, it will default to current day, but sync will not take precedence on that.

* QoL2: Added timestamps to the log when promotions/demotions occur whilst online

* QoL3: Hide the minimap with a CTRL-SHFT-CLICK action

* QoL4: Minimap should now properly save its position

* QoL5: On Logon, the left/kicked player info was still spamming the chat window. It should just post to the log now, though it may take a few extra seconds to properly update and receive all the left player info

* QoL6: Plugin for ElvUI "AddonSkins" is now fully updated, with a couple fixes to some overlapping frames.

* QoL7: Addon minimap position will now be unique to each player, whilst all the other addon settings will be shared. Before it was adjusting the minimap position on all alts in guild.

* QoL8: Namechange now properly class colorizes the names in the log.

* QoL9: The Log now sorts the newly joined guildies in a cluster of all those who were able to be determined who invited them.

* QoL10: Timestamp in the public/officer note should also reflect the accurate date they joined now.

* QoL11: It now says "Unknown" in the Ban List if the player was added to the ban list, yet was never in the guild, thus never had a previous rank

* QoL12: Sync throttle speed is being reset due to some issues that crashed people's sync speed to a painfully slow 10%. New logic added to protect universally against all backend comms. This eliminates the need to listen for specific addons and cross talk and instead looks at the global pool of messages as to control the throttle from being disconnected tighter.

* QoL13: New debugging utility: If you get disconnected... log back in with addon on, maybe sync disabled, and type: /run GRM.DebugLog(number)  -- the number being the number of lines of info you wish to see. This is mainly for addon dev use, so I will not include it in the help or slash commands.


**BUG FIX**

* Bug1: "Show on Logon" UNCHECKED should no longer bug out the window. Previously, if left unchecked, it would overlap all the options panel frames.

* Bug2: Join Dates should now sync properly, as before there was an issue with current date being added as the join date, then overlappy all sync info erroneously.

* Bug3: Players no longer show the <M> on their own toon online in chat, as they know their own.

* Bug4: Sync addon settings should now properly be disabled by default. This caused a lot of problematic resetting and syncing of settings when logging on different alts. It works properly now, but you may need to review some of your settings.

* Bug5: Right click on the minimap, if not in a guild, should no longer error out.

* Bug6: Minimap should now properly save its position between sessions.

* Bug7: Addon window was not properly loading on logon if player had a check in the box to load. It would take FOREVER! It is better now :)

* Bug8: The ESCAPE key now properly exits the officer/public note, or closes the player Info window, rather than exiting the core GRM window first.

* Bug9: Addon settings should now properly sync when a new alt of yours joins the guild, to the settings of your alts already in the guild, if they have the setting checked to sync.

* Bug10: Players using the Greenwall addon likely saw a decreasing speed of their sync process over time. This was due to a bug. Watching for Greenwall is also no longer necessary as the addon now catches all backend crosstalk between addons.

* Bug11: Fixed a MAJOR bug that affected like less than 0.1% of the population lol. If the player was a member of the same guild, same exact spelling, same faction, but on different servers, it could mess up and load the wrong database. this is now resolved. This required an extensive rework in how the database managed the guild, as well as mapping their "creation dates" and tagging them now, to differntiate them. This still did not differentiate them enough, as an even further edge case the player could be in a guild on different servers that were both created on the same day. Thus, in such a case, I dug even deeper and enabled a full database scan to find the matching guild the player belonged to.



**VERSION 7.3.5R1.129 DATE: January 30th, 2018**

**BUG FIX**

* For some guilds the promo dates were causing a Localization Key error, not finding it, due to a parsing error. This cleans up your database.

*Note, due to the nature of this bug, this will also automatically set to only sync with those with latest update, to prevent a reversion of syncing with bad data. PLEASE ENCOURAGE THEM TO UPDATE ASAP!!!*


**VERSION 7.3.5R1.128 DATE: January 28th, 2018**

**Minor Fix**

* The public and officer note would clear the ability to edit/add them after a few seconds. This was causing some minor errors, but also made it hard to change notes. VERY ANNOYING! This was a new bug added in 1.126 and a slight oversight.

**VERSION 7.3.5R1.127 DATE: January 28th, 2018**

*Minor Update*

* Cleaned up some settings info... fixed it to also be version 7.3.5 not 7.3.2

**VERSION 7.3.5R1.126 DATE: January 28th, 2018**

***HUGE USER EXPERIENCE UPDATE***

*Note: There is still a TON to do, but I knocked out a huge amount of busy features in this update that have just been piling up.*

**NEW FEATURES**

* New1: Players can now sync alt dates with the click of a button! Rather than choose each alt manually to set the date, you can choose to sync in 3 ways: To the alt with the earliest join date, to the main, to the currently selected player

* New2: Minimap Button has been added! Just right-click and drag where you want it!!! (or hide it)

**QUALITY OF LIFE**

QoL1: AddAlt "autocomplete" is now significantly smarter. It will not just alphabetize it, but will do partial word matches to names, it color codes the names to their class, and if they are already grouped as an alt/main it indicates it with alt or main tags

QoL2: Options Window has been a bit overhauled, with sub-tabs for each category. While they are mostly "empty" now, there is a lot of room for further customization as needed as more features are added without getting too cluttered.

QoL3: Players can now Globally sync the addon "settings" among all their alts within the same guild just by putting a check in the box. This syncs per client, so multiboxers will need to check the box for each account.

QoL4: Right-Click the sync speed slider to reset it back to 100%

QoL5: Scroll slider bars now function properly, the way the built in roster does. Clicking them now only moves the bar incrementally rather than jumping the bar to the position of the cursor.

QoL6: The core player detail window now just moves out to the side without hiding when the user clicks on a roster name to bring out the promote/demote/kick window

QoL7: The player no longer displays the main tagging on their own toons, since it is assumed the player knows their own alts!

QoL8: The audit window now has a new button allowing "unknown" to be included in the "complete/incomplete" filter

QoL9: Add an informative note to the "Add to Calender Events" tab, if the player does not have guild permission to add events to the calendar, the addon now informs them of it.

QoL10: ElvUI cleaned up a bit further, addressing a few minor allignment updates, as well as some compatibility issues. Merge request has been sent to addon dev.

QoL11: Several, and I mean several misc little things here and there... from allignment, to tiny bugs, to lots of time sucking things worked on I won't mention in their entirety.

**BUG FIXES**

Bug1: Sync should no longer trigger twice back to back when a player with the addon installed joins a guild

Bug2: Broken settings was the cause of an issue in regards to players that try to open the addon window and it was crashing... This has been resolved. For some players they may need to do a one-time /grm hardreset. But, the issue should not return. This will be noticeable as it will cause some alts they log into to crash the game, whilst some others it is just fine. This is 100% related to an old update that failed to consider a couple of factors upon updating some deprecated features, thus breaking their addon in certain eventual circumstances. This has been fixed.

Bug3: Fixed issue with the hex color code being added to Anniversary event description on the calendar add events.

Bug4: Fixed an issue where if a player is automatically removed from the Events list because the time of the event has passed without the player adding to calendar or removing from the list, it could error in certain circumstances.

Bug5: Fixed an issue where sync message was stating the wrong person was adding an event to the calendar.


**VERSION 7.3.2R1.125 DATE: January 13th, 2018**

***MAJOR ANNOUNCEMENT***

*Full Localization templates are now in the addon folder under "locales." I need any help that you can in getting this work translated. It's a lot of work and I don't expect any 1 person to do it all for any specific language. But, any bit that you can add, I will make sure you get the credit and I will incorporate it. Instructions are in each of the Lua files. I wrote my own, 100% in-house localization script, that is significantly leaner than using a publicly available library, like Ace. This also allowed me to customize it a bit for this addon. This was a significant job to put together these templates. Now, all we need is the remainder of the translation work done. Please just upload the file link and send it to me on Discord for any work that you have done. THANK YOU!!!*

**NEW FEATURES**

* New1: The player in chat will be tagged with their "main's" name. If they are on their main or their main/alt status has never been configured it won't show anything, but if they are a main or an alt, this will mark them as such :D - This affects guild/officer/party/raid/instance/whisper chat from guildies

* New2: Throttle Control slider in the options. Some people might have some sync/disconnect issues. If you find yourself disconnecting, it can be for a variety of reasons. Try throttling the sync speed back a little and see if that resolves it.

**QUALITY OF LIFE**

* QoL1: The addon no longer spams your chat window with the updates when logging in. It will inform you of live updates, of course, but you can always just look at the log for the mass of changes when logging in.

* QoL2: The DEL key now properly updates the character count on the note/officer note, MOTD, and guild info edit boxes.

* QoL3: On selecting the MOTD, you now will auto-highlight the whole text. I know, it's minor, but I don't have to click and hit ctrl-A anymore :D

* QoL4: Player names should now properly match ALL log messages to their class color, as well as sync messages, and nearly all aspects of the addon.

* QoL5: On the backend UI Globals are now finally 100% cleaned up into nice and neat, fast, tables. Keeping down on the global code clutter.

* QoL6: Ban List player ranks should now allign properly

* QoL7: New Lua class to hold specific update/player patch data. Cleaner, easier to debug.

**BUG FIXES**

* BugFix1: "Reset Defaults" button should now properly work. I must've broken it recently lol

* BugFix2: Somewhat huge bug I noticed that could cause players to end up with a lot of repeat player copies. It seemed to only affect x-realm guilds. So, I did 2 things. I resolved this bug so it will not repeat, and I wrote a script that will parse through your database and clean it all up if it affected you. So, you don't have to do anything. yay!

* BugFix3: More misc. Lua reports on some edge cases here and there.


**VERSION 7.3.2R1.124 DATE: January 2nd, 2018**

*HAPPY NEW YEAR!!!!!*

**NEW FEATURES**

* New1: If a player leaves the guild, and they transferred from the server, the addon will now inform you that the player is no longer on the server, in the log. Thanks @Polgara for the suggestion!

* New2: There are 2 new buttons on the Audit tab to set ALL incomplete promo/join dates to "unknown" (or undo the process)


**QUALITY OF LIFE**

* QoL1: Mouseover distance to the right of the chat/log filters, should now only trigger over the checkbox. They used to be very far wide right.

* QoL2: The Ban List will now display the players that are banned that are still in the guild at the TOP of the list, rather than the bottom.

* QoL3: Sync Messages stating that sync is starting should no longer display if everyone else with the addon online at the moment is not compatible to sync with, be it rank permissions or other reasons.

* QoL4: The Addon Users tab now states "Their rank too low" if another player's rank is below your threshold, as before the "Rank too low" some thought it was referring to their own rank.

* QoL5: Promoted/demoted messages are now cleaner and more concise for merged realm guilds.

* QoL6: Event Calendar Manager Buttons are now in the proper position.

* QoL7: "Unique Accounts" number is now fully localized so ALL non-English clients will be able to see this number

* QoL8: Cleaned up some allignment issues with ElvUI AddonSkins (and pushed new updates to the addon dev as well to incorporate)

* QoL9: New HardReset slash command /grm hardreset  -- This will not just wipe the saved data, it purges all, including settings, to be as if addon was just installed day 1. Be cautious. No warning on use. Mostly for quick emergency reset just in case.

* QoL10: If player is in a mega guild that uses "GreenWall" to share comms between all guilds, that use a signigicant amount of backend comms that goes to that internal server cap that can disconnect you, especially if many people chatting in gchat at same time. This addon now detects if the player has that addon loaded, and adjusts the comms appropriately to take into account the extra cross talk.


**BUG FIXES**

* Bug1: UI Bug where if player clicked "alt" name on the list of alts, you'd get overlapping frames if editing/adding a join/promo date

* Bug2: Noticed if reporting a namechange, if it couldn't identify which player was the namechange, it would reuse that for all namechangers. This would not be noticeable in most cases, but if you logged on and 2 or more namechanges happened in the guild, it would trigger the bug spam in the log, hence I never noticed it til recently.

* Bug3: Fixed an issue where non-English clients the player window would appear empty when looking at Guild Roster professions window.

* Bug4: Fixed major bug that avoids Lua error and the addon crashing out when a player joins a guild with addon installed

* Bug5: Fixed several other misc. Lua errors that have been reported and are mostly circumstantial cases. Thankfully we are knocking them out. Thank you!


**VERSION 7.3.2R1.123 DATE: December 23, 2017**

***BUGFIXES***
*Ya, my 330am release of my last update I somehow was half-asleept and pushed the update, but a few things in it I forgot to merge, I jsut thought I coded them and merged them. Nope! Sync likely would fail for many as a result. Not anymore!*


**VERSION 7.3.2R1.122 DATE: December 23, 2017**

**Continuing Updates on the Audit Log**

**FEATURE UPDATES**

* NEW "Unknown" feature - Don't know their join or promo date? Set it as unknown. Of note, this data does not yet sync.

* The unknown tag will feature in the audit window as a goldish orange

* New checkbox in the Audit Window for filtering so you can choose to see only incomplete guildies

* Additional useful info in Audit window: Num of unique accounts reflected next to number of mains

**QUALITY OF LIFE**

* Frame sizing has been adjusted slightly to be more how it was originally, as this larger frame just feels a bit bulky, right?

**BUG FIXES**

* Bug Fix1: Fixed a circumstance where Lua error could occur when syncing alt data

* Bug Fix2: Fixed circumstance where Lua error could crash sync on join date syncs in some circumstances.

*NOTE: I have heard reports of "double" reporting in the log, or reporting of something be removed and then re-added. I am still investigating this. I have a suspicion what is happening, but I have been having trouble recreating it. I will have this fixed sometime soon.*


**VERSION 7.3.2R1.121**

**Minor Bug fix** -- for players with very long server names, they would wrap the text and form a 2nd line, messing the allignment on the Audit Frame. This is fixed.

**VERSION 7.3.2R1.120**

**BUG FIX!!!**

*Ya, notice your screen is locking up momentarily after sync starts? Oops! I accidentally a code and made it so you were refreshing those new audit frames for every sync data sent lol. Ya, that'll crash your game. It is good now.*


**VERSION 7.3.2R1.119**

***TWO BIG UPDATES!!!***

**UPDATE 1: Guild Audit**

*Players can now open the audit tab and it will give an accounting of everyone in the entire guild, whether they have their join date/rank promo date/main or alt status determined. To take it a step further, the player can click on their name, if they are missing info, and it will immediately open up the player window where you can add the info together. It updates on the fly*

**UPDATE 2: UI Redesign**

*Tab system for the main roster window. Many other misc. features added as well, like some more mouseover tooltips on add events to calendar window and user sync info.*

**QUALITY OF LIFE**

* QOL1: Minimum Level filter now included on the leveling spam.

* QOL2: On scrolling, hold CONTROL down to scroll super fast. Hold SHIFT to immediately go to top or bottom

* QOL3: Class color coding of the player's names now added everywhere as well.

* QOL4: Online/AFK/Offline status now updates live on the player frame

* QOL5: /grm or /roster both work for slash commands now.

* QOL6: Added compatibility for ElvUI "AddOnSkins" plugin and committed it to the addon dev.

* QOL7: The Right-Click notification system, for player status updates, is now far more efficient and runs independently of the Scan for changes check (as some players may disable it, yet still want to be notified if someone comes back from being AFK).

**BUG FIXES** (so many!)

* Bug Fix1: If Officer/Player note was changed, it was incorrectly reporting it changed from a number.

* Bug Fix2: Major alt-sync issue where if you removed a player listed as an alt, then sync'd with another player they would all reappear! woops! lol

* Bug Fix3: Sync issue if the "syncLeader" behind the scenes goes offline, after having already received the data from another player, whilst in the brief moment of parsing it out, if that player goes offline, the other player would wait indefinitely for callback and ignore all other comms, never completing sync or retrying with another player. This is resolved!

* Bug Fix4: The Log should now properly appear on logon if you have it set to only appear with changes.

* Bug Fix5: Resetting Defaults in the Options should now properly reactive scanning for roster changes

**FINAL NOTE**

*Yes, still tons to do. I REALLY wanted to get a minimap button out with this release, but I just didn't have time. Several other requests from you guys, just know that I have them written down. Please stay on my case about them all! Shoutout to AddOnSkins dev for merging my gitlab commits so quickly for his addon as well.*

**VERSION 7.3.2R1.118**

* Bug Fix1: If guild had more than 250 members, addon would fail to report and build profiles for any new members or acknowledge leaving members properly

**VERSION 7.3.2R1.117 - DATE: 13 Dec, 2017**

* Bug Fix1: Lua error would occur if addon was suggesting player to be removed from guild due to inactivity. New bug introduced when I removed the stutter. Oops!

* Quality of Life: If the mouse was stationary, but you scrolled up and down in the log, the player window would not update until you actually moved the mouse. Now it does.


**VERSION 7.3.2R1.116 - DATE: 12 Dec, 2017**

***STUTTER ISSUE FIX***

* Stutter issue is now resolved on mega guilds. Tested on 950+ member guild with no more noticeable stutter, I mean, like 99% reduced.

* Fix minor reporting issue on changes that could delay the report until the next loop'd scan.


**VERSION 7.3.2R1.115 - DATE: 11 Dec, 2017**

***EVEN MORE DISCONNECT AND LUA FIXES LOL***

***STUTTER ON SCAN FOR MEGA GUILDS ABOUT 95% REMOVED***

*Well, I guess the massive sync speed update is not without hiccups. I just KNEW things were not going to be ready yet, even though testing on my end said it was good. So many things...*

* Sync should not properly not disconnect you lol.

* Lua error fixed on nil value (it was sending a blank message due to conditional error)

* Ban list sync particularly was having some issues. This is cleaned up now. This was more of a pain than people realize. Here is why. Let's say you are new to the guild, and you want ban list sync'd to you. Well, you don't have metadata profiles built on missing players because they were not in the guild when you were. However, if they rejoin the guild, since they are on the ban list, you need to rebuild their profile with old info, thus you too can trigger active monitoring of erroneous invites. This is problematic though since you don't want a bare template. So, addon checks if the sync person on ban list is in your leftPlayer database, and then if not, it syncs their metadata to you. Well, getting this all to sync right, particularly with my new sync method, was an absolute pain in the... you know. It should now be smoothed out properly. I hope!


**VERSION 7.3.2R1.114 - DATE: 11 Dec, 2017**

***ANNOYING DISCONNECTS FIXED***

* Sorry guys, the isssue did not present itself for myself and my smaller guild, but it did in larger, with the new speed sync changes. This should not kick you anymore, I hope. /crossFingers


* Accidentally included my debugging version - FIXED!


**VERSION 7.3.2R1.113 - DATE: 10 Dec, 2017**

* Accidentally included my debugging version - FIXED!


**VERSION 7.3.2R1.112 - DATE: 10 Dec, 2017**

***HUGE NEW FEATURE***

***Massively Increased Sync Speeds:** First off... WARNING! This will not sync well with others and will send them a lot of Lua errors if you do not have the check in the box to only sync with current addon users. Just a warning. Yes, it is still not instant, and unfortunately, it never can be. The reason is that Blizz limits messages across the server in comms that cna be no larger than 254 characters. If you do them too fast, you get disconnected. If you try to send a comm 255 characters or higher, you will disconnect. So, I have no choice but to throttle the speed of them. Now, the new sync method is I fully pack every single comm to capacity by putting them altogether in a giant string, and splitting up the comms with obvious markers for breaks in data and characters and so on. So, I jam pack each string and comm to its full capacity then unpack the data on the other end. It takes a bit more computational power (albeit minimally), but the time savings are massive and worth it.*

* 8x-10x sync speed increase. It really is faster!

**NEW FEATURES**

* Clickable link notification now if a player requests to join guild (opens recruit window)

* New Option to only "Show on Logon" if there have been changes.

**QUALITY OF LIFE**

* Message Headers with "-----" have been removed for allignment purposes. Looks cleaner now

* Adding player to ban list is a little smoother

* SyncInfo window fonts allign properly with all scaling/resolutions.

**BUG FIXES**

* Addon had allignment issues with ElvUI's "AddOnSkins" plugin. Built compatibility and sent it to addon dev. It will be implemented soon.


**VERSION 7.3.2R1.111 - DATE: 2 Dec, 2017**

*Note: I have a lot of little misc fixes here and there that I forgot to record as I was knocking them off the "to-do" list, so I will just mention a couple I remember*

***QUALITY OF LIFE***

* QOL1: Officer and Public Note changes now report on a single line to the log for all future changes

* QOL2: To avoid chat spam, player requests to join the guild now tell you how many requests there are rather then displaying all requests

* QOL3: Slash command '/roster recruit' will be used to open the window that shows how many recruits there are.


**BUG FIXES**

* Bug Fix1: Sometimes it would erroneously report a player Coming back from being offline, even though they never returned. This is now fixed.


**VERSION 7.3.2R1.110 - DATE: 24 Nov, 2017**

***MAJOR SYNC ISSUE BUG FIX***

*Ok, I won't get into the technical details, but suffice it to say a few updates back I kind of went in and did some behind-the-scenes updates, optimizing the process, improving some speed aspects of the sync, making the process leaner and so on. I also apparently broke it some aspects of it lol. This was not an easy fix. This was pretty gritty actually, largely because of how much extra work I need to do to actually get a dynamic, retroactive sync working, with this much data, within the limits of this API, and within the limits of throttled server comms by Blizz, all while doing it in a way that is seamless and invisible to the addon user. Welp, ya, I broke a few things without realizing it and I believe I have them working now. Yay!*

* *Of note, I have not yet tested this beyond 5 accounts syncing in a large guild, and it seemed fine. I will need people to report back and if there are issues, so we can get them resolved ASAP!!!*

**QUALITY OF LIFE**

* Player's full name-servername appear in the log when they leave or are kicked from the guild (for you xrealm people!)

* Furthermore, the class is now apparent in the log for the leaving player and any remaining alts

* Ability to clear just the guild data with '/roster resetguild' or from the options

* Options slash command buttons are much more obvious.

**BUG FIXES**

* Everyone appeared online in previous update. Silly bug! Status should now display accurately.

* Again, sync issues should hopefully be resolved now. I have not done a lot of testing, but I have done some. I will need reports.

*Final Note: Not a ton of major updates here, though I am working on a large project. My focus was 100% spent on resolving the sync issue for people. Thank you for your support in reporting issues and patience for me getting them fixed!*


**VERSION 7.3.2R1.109 - DATE: 19 Nov, 2017**

* OOPS! Uploaded sync.lua file with the sync helpers still in it (my test version). You would be getting a ton of sync spam as it transmitted data. This is hidden now and should not be scene lol


**VERSION 7.3.2R1.108 - DATE: 18 Nov, 2017**

*Very important Sync bug fix that I broke in a recent update*

* Bug Fix1: Sync would only work with 2 players in any guild larger than 50ish memebrs. If more than 1 person was online with the addon installed, it would fail endlessly and keep retrying. How annoying! Simple fix really, It just made the mistake of testing my new error checks worked properly in a guild that was too small and not a larger guild which faces throttle sync issues across the server.


**VERSION 7.3.2R1.107 - DATE: 15 Nov, 2017**

*I was trying to get another big project finished, but it's just not quite ready. I will have more time this weekend to work on it. So, very minor fix here since this is an annoying bug.*

**BUG FIXES**

* Bug Fix1: If a player had the "Add Join Date" to public/officer note disabled, it would report to the log that the note was changed, but then it would report the note was removed because it would scan the data and show it never actually was. This should no longer do it.


**VERSION 7.3.2R1.106 - DATE: 12 Nov, 2017**

**Minor Feature**

* Ability to add "Join Date" to either the officer OR public note, in the options window. It will auto-default to public note if you use certain addons (like "epgp")

**QUALITY OF LIFE**

* More live updating frames. For example, the zone timer will now update live the time passed.

* New slash command to bring up the ban list:  /roster ban or banlist

* Buttons now more properly alligned in the options window.

**BUG BIXES**

* Bug Fix1: Issue with namechange detection for very rare cases when players have literally all the same information (same class, lvl, achievement pts, guild rank, guiild rep, same notes), this event actually occurred and got reported to me. Now, the addon will detect if more than 1 player matches for namechange and handle it.


**VERSION 7.3.2R1.105 - DATE: 10 Nov, 2017**

**BUG FIX**

* One minor quick fix... if you tried to remove a ban from a player, you'd get a Lua error and frames would not update. FIXED!


**VERSION 7.3.2R1.104 - DATE: 10 Nov, 2017**

**NEW FEATURE**

*Player can now take advantage of manually adding a player to the ban list, not just when gkicking someone. This had a TON of things that needed to happen behind the scenes, so what might seem like such a simple feature on the front end was immensely time-consuming.Huge sub-project really due to the auto-generation of a manually added metadata profile and so on.*

**QUALITY OF LIFE**

* Addon now detects the "EPGP" addon and will automatically disable the adding of join dates to officer notes with the user needing to manually go into the settings. It is an immensely popular addon, so this helps avoid any officer note conflicts.

* Ban List sync tweaked a bit for some more edge cases I discovered.

* Modularized a bit of the UI loading to improve performance. It's already quick, but now it's quicker.


**VERSION 7.3.2R1.103 - DATE: 7 Nov, 2017**

**NEW FEATURE**

*"Ban all alts too" has now returned, sort of. While you no longer can gkick them all with the click of a button, as you could in pre-7.3, you now have the option to ban all of the alts of the player as well, so when you gkick the one player, it also bans all their alts. They immediately show up in the ban list as "still in guild" so you know who to still kick (plus the given reason will all be the same)*

**BUG FIXES**

* Bug Fix1: Sync is working again! I broke it without realizing it for like 90% of guilds out there. Oops lol

* Bug Fix2: Sometimes ban list could erroneously purge a name from it. Well that's not good! This shouldn't happen anymore.

* Bug Fix3: Blizz made another stealth change, so I had to adjust the "click on alt name" feature. It no longer attempts to scroll the roster to position of player.


**VERSION 7.3.2R1.102 - DATE: 5 Nov, 2017**

* Bug Fix1: Server Sync would not work if you had a server name that included a hyphen (like EU "Azjol-Nerub"), as it didn't parse properly. Fixed!

* Bug Fix2: Some even tighter controls on sync, if a player's sync fails (like if a player logs off in the middle), or for any reason, it will re-evaluate the sync leadership structure, as well as the que. It will even determine the cause of sync failure, even notify you if player is offline now, and so on.


**VERSION 7.3.2R1.101 - DATE: 30 Oct, 2017**

**QUALITY OF LIFE**

* QOL 1: SyncInfo window now states a "helper" if you have sync disabled in the options or not.

* QOL 2: Addon will now trigger a re-sync automatically after doing a full reset (/roster clearall), rather than needing to manually

* QOL 3: Sync sometimes could fail in certain occasions. Not a big deal as it would reset itself the next time someone logs with addon installed, or you /reload. However, in some edge cases you could get stuck in sync limbo, never acknowlodging it failed. This could happen say, if a player logged off in the middle of a sync in certain cases. Not always, just some circumstances. The addon is now significantly smarter at how to handle resync on failure, as well as checking things like online status of the players and so on.

* QOL 4: Reset Defaults button is now included in the OPTIONS panel.

**BUG FIXES**

* Bug Fix1: Slight modification to the font system for localization support in a more streamlined, server-side deciding way

* Bug Fix2: Lua error could occur on first login due to guildName loading order for ban list. Minor issue, just needed to load proper order, onshow



**VERSION 7.3.2R1.100 - DATE: 27 Oct, 2017**

***HUGE UPDATE*** *Note: You need to encourage your guildies to upgrade to latest version or else ban list will not sync. I'd even highly recommend in the options restricting sync to only people who have latest version. Some people with really old version might get hit with a Lua error or two as they try to talk to your addon. Again, encourage people to upgrade. It's worth it!*

**NEW FEATURE 1:** *Localization Framework has been built*

* Fonts have all been implemented for ALL languages, including support for Russian, Korean, Mandarin (Both Chinese and Taiwanese). No more "???"

* Some translations have already been implemented that I manually did on my own, just pulling from the built-in scripts. I am not going to focus on the full localization as of yet, this is more quality of life starting.

* This also resolves many issues for people using non-English clients and should provide and overall better user experience.


**NEW FEATURE 2:** *Sync'd Ban List*

* Custom Rank restriction on the Ban List. It seems like it would be prudent to allow widespread sync on general guild info, like alts and so on, but have tighter restrictions on who can modify the ban list. I personally have guild-wide sync, but officer only ban list permissions.

* Full retroactive Ban SYNC. So, new officer? They will be sync'd with up-to-date list, including all people who were banned prior to them even joining the guild, as long as someone with addon stored the info originally and sync'd the data.

* Ban List Custom UI window - shows name, rank when banned, and the date of the ban.

* Ability to remove people from ban list.

* Live frame updates, on both sync and live changes. No need to open and close window to refresh it.

* Note: the "Add" to ban list feature is not quite ready and is significantly more work than one might realize. So, until then... button will not do anything.

* So much is going on behind the scenes to get this all working together properly. A significant amount of effort had to be put into ensuring it is error free and an overall good, simple, user experience.

**QUALITY OF LIFE**

* QOL 1: Options Menu Changed a bit. A little bit cleaner, a little bit more logical, like the display options or clearLog are now always visible

* QOL 2: Buttons added to options menu slash commands that accomplish the same thing.

* QOL 3: Minor Localization progress has been made. Initially it was just down to lay a foundation for future work and to bring in proper fonts.

**BUG FIXES**

* Bug Fix1: Addon should now properly trigger a data sync shortly after joining a guild.

* Bug Fix2: OMG, WTF BLIZZ!!! Blizz just introdued a NEW bug that reintroduced "taint" on the gkick window. I have a feature where you click on an alt name and it not only opens that profile, but it opens the Guild Roster Slider to the correct position as well. Blizz just made it so manipulating the slider in the code will now block you from being able to gkick players again. WTF BLIZZ. I just don't get it. So, I am keeping the clicking on alts feature, but removing the Roster move-to positioning. Silly, silly Blizz for doing this.

* Bug Fix3: Addon will now properly register when a player joins the guild, asap. So, even if you have it set to only do a roster change scan once every 15 min, if a new player joins, the addon will register that update asap, then continue where it left off in the timer.

* Bug Fix4: Lua error could occur on occasion, often shortly after logging, in regards to the "SyncInfo" table it was populating, of all guildies with addon. This "should" be resolved now.

* Bug Fix5: And about a dozen other minor things here and there not worth mentioning...



**VERSION 7.3.0R1.099 - DATE: 10 Oct, 2017**

*Quick Bug Fix patch!!!*

* Bug Fix1: Fixed an issue if there is only 1 player online, the mouseover window will not popup again.

* Bug Fix2: Lua error could occur in certain circumstances in reference to the new guild addon user feature of last patch. Oops! no more...

* Bug Fix3: Lua error could occur in certain circumstances when syncing "alt" information. This was a coding typo. Fixed!

* Bug Fix4: Newer versions now do a better job of filter REALLY old versions of this addon, as if you didn't you could get spammed with Lua errors until guildie updated their addon.


**VERSION 7.3.0R1.098 - DATE: 9 Oct, 2017**

***NEW FEATURE:** New window that gives details on ALL players in guild that have addon installed. It tells you if sync is "ok!" with that player, and if it is not, it gives you the reason as to why, be it they have sync disabled, they are filtering out your rank, or you theirs, or even their addon is outdated and you are restricting sync of players with outdated addons (as per options). It will tell you ALL players in guild if they have addon. Furthermore, it will auto-update itself if opened, on receiving new data, like if a player logs off, it will remove them from the list, or if a player changes their sync settings/restrictions, it will update on the fly to you. All automatic!*

* Feature: Player now has the option to restrict anniversary reporting to only players listed as "main." Avoid getting spammed with all of someone's alt anniversaries too! Completely optional.

* Feature Fix: Finally, after some serious finesse and tedious finagling to try to hammer out my way around how much Blizz broke in 7.3, I finally worked out a solution on the "Shift-Click" to copy a player's name. Also, it will no longer just wipe out the whole text or chat box, it will just insert the name at the cursor. Exception is the "Add Alt" window it will clear and put in the entire name-server representation on shift-mouseover.

* Bug Fix1: Found a bug where the guild could false report that it name-changed.

* Bug Fix2: /roster clearall didn't reset the player alt auto-add feature, so if you wiped everything, it would still no longer re-add yourself and alts to a grouping on login automatically. This is fixed.


**VERSION 7.3.0R1.097 - DATE: 5 Oct, 2017**

* Feature: On mouseover, if you hold shift, it will now copy the player's name to any window the cursor is in, be it chat box, WIM, or even to add the altName rather than type it. Shift-mouseover. Of note, click is not possible due to 7.3 taint issues with anything to do with the Click() API action.

* Bug Fix1: Huge error fixed that "could" hit anyone not using the English client. It didn't in all cases, but if you had the Roster window open, and you had it set to the "Player Status" dropdown, not the "Guild Status" it could error. Fixed!

* Bug Fix2: If 2 players with same name in the guild, but different servers in merged realm, error could occur in some instances I found. This once again resolves them.


**VERSION 7.3.0R1.096 - DATE: 3 Oct, 2017**

***OPTIONS** panel has been largely redone. It's organized a little better. There is some open space, but I do have some additional options planned out to be added so I left room for them. They are just not quite ready for release.

* Feature: Slash command '/roster scan' will now trigger a one-time manual scan, even if the player has scanning disabled.

* Feature: Slash command '/roster sync' will now trigger a one-time manual sync, even if the player has sync disabled.

* Feature: Option to restrict sync only with players who have your version of the addon or higher. 

* QOL: Options menu mostly redone. Makes more sense know. Slash commands included. There is some open space atm, but to be added with future additions I have pending.

* Bug Fix1: '/roster scan' could at times fail to do anything. It should work now, unless there is no one online to sync with...

* Bug Fix2: Adding someone to list of alts could in some cases remove the "main" status of an alt. This now properly preserves alt/main grouping.

* Bug Fix3: Enhanced the code a bit, cleaned it up. Found a few misc. bugs here and there that don't need reporting now.



**VERSION 7.3.0R1.095 - DATE: 28 Sep, 2017**

* Bug Fix1: Sync bug that could cause disconnects is hopefully now resolved. TY @MCFUser175484 for helping me out in your guild to isolate this one.

* Bug Fix2: Which led to other bug fixes, like Sync Queing players was not working properly. If more than one person logged in or reloaded at the same time, it would still attempt to sync with ALL players at same time. This could cause disconnect as well.

* Bug Fix3: If the sync failed, it should retry with next person in que, but in some circumstances it was getting stuck in perpetual loop with players stuck in que not syncing.

* NOTE: Players that are in the middle of syncing that enter a loading screen the sync will fail. There is no API for another player to know that the other player is on loading screen, thus I can't que the data to wait til they are off it when sharing info. For live updating this is not an issue, but in batch sending data, the sync will fail. Just be aware.

* Yes, definitely working on some others major features, but these were just so game-breaking for some players they were necessary to fix. 



**VERSION 7.3.0R1.094 - DATE: 18 Sep, 2017**

* QOL: Mouseover added on the player status part to make it more obvious how to set notifications on status changes.

* Bug Fix1: Sync is working again. I completely broke it somehow like a coding noob! I was optimizing the sync speeds and over-confidently didn't test it apparently. I might've been half asleep.

* Bug Fix2: Promote/demote bug that could occur. It could even error out and false positive claim you changed your rank name lol. Hopefully fixed now :D


**VERSION 7.3.0R1.093 - DATE: 16 Sep, 2017**

***Main Feature:** Players will now auto-add themselves to their own alt list as they login to each of their toons. Note, you need to login to each one at least one time. The game is incapable of knowing who is your alts retroactively. Please login to each one!*

* QOL: When a player joins the guild, even if someone has it set to only scan for changes 10 min+ for example, it will still immediately build a new player profile. Note, Blizz server callback will take 15 seconds or less due to server call restrictions... It depends on when you last called the server.

* QOL: Addon now detects if a player's own rank is changed, triggering a resync if permission allows it, as rank change might open up more sync data. It also will live update your roster frames options permissions without needing to close/reopen the log window to refresh it

* QOL: Ban frames are now much cleaner post 7.3 changes that messed them up. They are closer now than ever to pre-patch 7.3.

* QOL: All UI frames are now updated on the fly for any changes. No need to close and reopen to refresh. This includes sync data received.

* Bug Fix1: Patch 7.3 broke a few things, including the way I can parse and receive data from the server. Very annoying. This reintroduced a merged-realm bug if player's had same name but different servers. This is now resolved :D

* Bug Fix2: Options button "Announce Events" was not funcitoning properly and you could not disable it, it also was not properly hiding the subsequent button to add events to calendar if disabled.

* Bug Fix3: When updating the timing interval to scan for changes, it now should properly update to new time interval immediately, not on 2nd pass.

* Bug Fix4: Code optimized a bit behind the scenes, in a few places...


**VERSION 7.3.0R1.091 - DATE: 10 Sep, 2017**

***NOTE: This sync overhaul is significant enough that you cannot sync retroactively. YOUR GUILDIES MUST UPGRADE TO LATEST VERSION TO SYNC WITH YOU!!! Recommend them to update.***

*Somewhat massive overhaul to sync system for efficiency, allowing slightly faster process. Furthermore, apparently there is a hard-cap on the number of backend server comm "prefixes" that can be used before crashing the account. This would not normally be an issue, but if the player is using a lot of addons that take up the limited use space, you could hit it, like DBM, Mythic key addons, and so on, coupled with this one, it could disconnect you on sync. I have stripped out 35 sync prefixes down to just 1 and buried the keywords as strings, and I just parse them out on receiving the sync message. A little extra processing power, albeit minimally, but will interact with the server and other addons much much better.*

* QOL: '/roster sync' will now trigger sync manually. Though it's pretty good at doing it automatically, but for whoever wants to.

* QOL: Sync start/stop notifications, even interrupted ones, are a bit more obvious now.

* QOL: On the "Add Event" window, for events, or in this case, bdays, the date is now listed in the window when you select it, before adding to the calendar.

* Bug Fix1: OMG, rank promotions/demotions screwed up the player's rank index. I had to rewrite some of the logic in recording the promotion/demotion changes due to 7.3 changes, and I had to collect the data slightly differently. Blizz is inconsistent in how it represents the ranks. Often they are represent as 0 - 9 or 1-10 (with guild leader rank index being 0 or 1). This inconsistency carries over to several API and the server and juggling them all sometimes I forget which is which. Unfortunately, I made the mistake which puts all ranks 1 index off if you change them... /clearall will fix your ranks, just make sure someone has your data to sync with em.

* Bug Fix2: Tigter sync data controls to ensure uncorrupted transfers.



**VERSION 7.3.0R1.09 - DATE: 9 Sep, 2017**

*Promote/Demote/Kick are now protected functions and an addon cannot do anything with them. As such I have integrated the built-in UI to do it. When you wish to kick or promote/demote a player, just click on their actual roster name in the list and it will hide the addon window and show Blizz's frames. Getting the "taint" to go away with patch 7.3 was brutally annoying and I had to do some rather inefficient shenannigans in the code behind the scenes to parse the data as :Click() to force a server call of the data taints the frams, sadly. At least it is working now*

* Bug Fix1: Kicking members from the guild should no longer be a problem. Due to 7.3 restrictions, it will now need to be done manually. Just click on the players and you will be able to remove them. Banning is fixed as well.

* Bug Fix2: Lua error could occur on occasion when clicking on one of the alt names.

* Bug Fix3: Sync issues could occur with players who had ranks in the guild with the exact same name. Rankindex is used in all cases now instead. I honestly didn't even know you could name ranks the exact same title.

* Bug Fix4: Problem with promote/demote I introduced last update. Newer method is more efficient and listens for chat emote event when player changes another's rank, so as not to wait for server update.

* Bug Fix5: In relation, occasionally the addon would say the incorrect person was promoting/demoting/kicking someone. This is now resolved.

* Bug Fix6: If a player was listed as a "main" and they added an alt to their list, but the alt was previously listed as main, then you would have 2xmains in a grouping. This caused interesting errors, though rarely encountered. No more!



**VERSION 7.3.0R1.087 - DATE: 6 Sep, 2017**

* Bug Fix1: I think I finally fully ironed out the gkick/ban issues due to 7.3 changes. Please let me know. I have had all my officers report it as working now, and 2 other guilds I know using it I beta tested first and they said no issues, so I HOPE we are good from here on out lol. 7.3 = #sadface

* Bug Fix2: OOPS!!! I accidentally broke reporting to you and the log if a player leaves or kicks the guild. Minor typo introduced and now fixed...

* Bug Fix3: Accidentally a word and the confirm popup window autohides in last patch! Seriously, you would not even be able to put on a BOE piece of gear. Stupid gamebreaking 1 line typo fixed lol

* Bug Fix4: A couple other misc. bugs fixed. This is a fairly minor patch as I really wanted to get this out there and fixed


**VERSION 7.3.0R1.086 - DATE: 5 Sep, 2017**
*Thank you for many suggestions and bug reporting. Keep em coming! So much to do!*

* **FEATURE:** Names on alt-list, if you click, you will jump to that alt's Roster profile window. I just want to add, this was not a simple feature to add and required a bit more behind the scenes than one would imagine. The code came out efficient and wonderful however. One of the more "fun" side projects to code.

* QOL: Scanning for changes can now be disabled if you so choose (maybe turn it off if you have bad internet connection?) - This was requested feature

* QOL: Scan for changes frequency can now be manually adjusted from the default interval of every 10 seconds.

* Bug Fix1: If adding a Friends' list Note, the roster window would hide it, making it impossible to add friend note if Guild Roster window was open. It no longer hides the note box.

* Bug Fix2: It is now vastly more reliable in stating WHO promoted/demoted/kicked a player.

* Bug Fix3: The database now instantly reports those changes when player does them without the need of waiting for scan. #Efficiency

* Bug Fix4: Fixed an annoying Lua error that could occur at times if player dies. This was a weird edge case I never noticed since I mostly just sit in a city coding than playing lol

* Bug Fix5: If player tried to disable sync before syncframes were initialized, it would error. Fixed!

* Bug Fix6: Tons of UI quality control done. Many many many behind-the-scenes stuff I won't mention here because tedious and too numerous. The point is that there is an evolution of the user experience here and progress continues to be made with this very active project.

*Final Note: I wrote 2 other custom addons I haven't released, but mainly for my own enjoyment, this past week, which distracted me a bit from pushing a new release quicker. Thank you again for all of your support and I hope that I can continue to increase the quality and build the desired features that are not currently missing. I have a HUGE list of things on my "to-do" list. It is no small project though. I am already over 12,000 lines of code for this beast, 100% built from the ground-up by myself, and the features I want to add and are in the pipeling would likely add another 5000-8000 lines more, plus not all lines of code are created equal in the amount of effort to write. Just know it's a lot of work, and since this is not my day job, just a side hobby, I can't put any realistic timetable. Just know I am working on things in a priority chain as of now.*


**VERSION 7.3.0R1.085 - DATE: 31 Aug, 2017**

*WTF!!! Blizz removed SO much more guild API functionality than I realized and broke a ton of things... These workarounds are not easy. Blizz completely broke my gkicking abilities, so I have had to hack around and get one working. This was for more of a pain than you would realize as it was not simple and straightforward like it should be. Blizz REALLY borked some stuff*

* Notice: Mass kicking a toon w/all alts is no longer possible with in-game API. Sadly, you will not be able to one-click remove a player with all their alts. This was a lovely feature, but Blizz removed the ability to use Lua or even macros to remove players. You HAVE to manually remove each one in-game from now on. Super annoying...

* Fixed gkicking and banning. Note, I don't know what Blizz did, but it seems to work like 75% of the time, not 100%. I don't know why. I haven't been able to trace why and I spent 4hrs working on it tonight. Seriously, if you gkick/ban someone, if it doesn't work the first time, try a 2nd time and it should work. It USUALLY works, but for some odd reason, Blizz's removal of API functions, using their own built-in API, it has broken something..


**VERSION 7.3.0R1.081 - DATE: 29 Aug, 2017**

*UPDATED FOR PATCH 7.3 COMPATIBILITY*

* Bug Fix1: Blizz decided to remove some backend API functionality on rank promotion/demotion. This kills many guild leader addons!!! I stitched in Blizz's default rank dropdown into the UI as API is no longer available and is protected function. Player should now be able to promote/demote players again.


**VERSION 7.3.0R1.08 - DATE: 29 Aug, 2017**

*UPDATED FOR PATCH 7.3 COMPATIBILITY*

* Note: Oddly, Blizz changed GuildControlSetRank() API function to now a protected function. Not sure why, but it limits ability to pull info on guild rank restrictions and so on... Minor issue, but could potentially cause issues for guilds who have a rank with guild chat restricted. Prob rare case usage.

* Bug Fix1: Error could occur in some cases when parsing through the guild event log to find out WHO did promotions/demotions and so on if server did not provide full info. 


**VERSION 7.2.5R1.075 - DATE: 27 Aug, 2017**

* Bug Fix1: Sync issue that could cause, in certain cases, sync to indefinitely loop and never complete. You'd get all join/promo sync fine, but it would only sync the first 50 alt changes lol OOPS!


**VERSION 7.2.5R1.071 - DATE: 25 Aug, 2017**

* QoL: Options now greyed out and unchecked if player does not have rank access to them.

* Bug Fix1: If a player did not have access to being able to add events to calendar, it would cause an error.

* Bug Fix2: HUGE issue that would cause certain servers with odd names (like Area52), to not sync properly. Works now!

* Bug Fix3: A couple behind-the-scenes fixes that smooth a couple of reported issues out. Complicated so I won't go into much detail here.



**VERSION 7.2.5R1.062 - DATE: 24 Aug, 2017**

***Note** - This is a quick, minor update to fix something real fast. I have other things I am working on, but this is so annoying I decided I wanted to get it out right away*

* Bug Fix1: Quick fix on shift-click names to add as alts. I typo'd a line and it was previously closing window than adding name



**VERSION 7.2.5R1.06 - DATE: 21 Aug, 2017**

*Note: R1.05 was a very small closed beta with a few people, so will be skipped here*

* FEATURE: Notifications! Player can right-click the "status" of player, like AFK, and set notification when no longer

* FEATURE: Player can set to be notified when players login or logoff (more noticeable than Blizz default one)

* FEATURE: Unlimited number of players can be monitored. Of note, they are wiped on each relog, not permanent.

* QOL: Version Check Incorporated. This is not backwards compatible with older version, but from R1.06 and on, player will receive notification if they have outdated addon if others in guild have newer version

* QOL: All future addon users, SYNC is now on by default (though ranks will need to be opened for more than GL)

* Bug Fix1: Addon now takes into consideration guilds with disciplinary ranks that restrict guild chat. This is critical as it can destroy comms and this will resolve a couple of odd bugs.

* Bug Fix2: On rank changes, the addon now takes into consideration rank pre-reqs, like having authenticator and does not attempt to change rank if server will not yet allow.




**VERSION 7.2.5R1.04 - DATE: 15 Aug, 2017**

* QOL: Players full name w/server now viewable on mouseover

* QOL: Name w/server mouseover on alts lits too!

* QOL: ALT CAP REMOVED!!!

* QOL: Player's with more than 12 alts now will have a scrollable alt window!

* QOL: Sync now states when it completes

* Bug Fix1: REMOVE button no longer shows on players of equal or higher rank

* Bug Fix2: Fixed UI bug where it shows promotion/demotion changes, even if player cannot.

* Bug Fix3: Adding event to calendar, description date previously was showing current date, not event date.

* Bug Fix4: Lua error could occur from other addons sharing guild comm channel. Now filters properly.

* Bug Fix5: Shift-clicking roster name now properly places player name where cursor is, not wiping all.


**VERSION 7.2.5R1.03 - DATE: 6 Aug, 2017**

* Bug Fix1: Shift-clicking roster names was wonky on adding alt. It works properly now.

* Bug Fix2: Mousing over names, then shift click if no editbox was focus would cause a Lua error.

* Bug Fix3: Issue where wrong player being selected invisibly in the background, but UI showed proper, thus

* Bug Fix3: behind the scenes it was pulling mismatched data from server on mouseover player at times. No more!

* Bug Fix4: Join Date could get overwritten on new player joining, thus rewriting join date for SYNC as current date

* Bug Fix4: rather than the date they actually joined, or when another player said they joined. This should sync the

* Bug Fix4: the data properly now and not override the correct info.

* Bug Fix5: On a player joining the guild, you could get this error where it would add an officer note as joined on current date, then it would overwrite

* Bug Fix5: it as it pulled the real officer note and spam the log as if it were a change. This annoyingly did it on all new joins

* Bug Fix5: if the player logged in at any date AFTER the player joined originally, if the officer note was tagged. How annoyingly spammy! Fixed

* Bug Fix6: Fixed a Width issue on the Year date on drop-down select that should no longer be an issue for people using non-widescreen resolutions.

* Bug Fix7: Sync on large guilds will now be a bit slower, but it seems it was spamming and disconnecting people even at the previous throttled rate

* Bug Fix7: The new Throttle rate is literally 25% the speed of the previous sync rate. Fortunately it all happens in the background so its not noticeable, just be 

* Bug Fix7: aware Sync will not update within seconds on LARGE guilds, but actually, a couple of minutes to prevent disconnect due to Blizz comm limits.

* Bug Fix7: Please report back if disconnects are gone. ALL in your guild will need to upgrade to current version to prevent disconnects.


**VERSION 7.2.5R1.02 - DATE: 24 July, 2017**

* Bug Fix1: Dynamic and retroactive sync did not work on any realm that had more than one word in the name, like "Burning Legion" or "Area 52"

* Bug Fix1: Never noticed string handling on comms since I tested on single word realm.

* Bug Fix2: Syncing could crash on MEGA guilds! In my 250+ guild, I never noticed any disconnects, but in larger guilds, too much data would be sent 

* Bug Fix2: across the server and would disconnect the player. Now, based on amount of info/size of guild, data packet is controlled to prevent disconnect.

* Bug Fix2: For some larger guilds, sync may no longer take 2-3 seconds for larger guilds. 500 to 1000 member guilds will take anywhere from 15-40 seconds, depending on 

* Bug Fix2: how much alt data needs to sync too. I want to speed it up, but Blizz has internel limits to prevent server spamming. Don't worry, it all happens in background.

* QOL:	Shift-Click player name in the roster and it will add it to anywhere your cursor has focus. It is universally compatible with any frame or addon.


**VERSION 7.2.5R1.00 - DATE: 21 July, 2017**

* Bug Fix1: If a promotion/Demotion was made, there would be a delay on register, which could cause an error when trying to populate the Rank promotion history

* Bug Fix1: Promotions and Demotions now a registered immediately!

* Bug Fix2: Noticed an issue where you could get double spam on reporting changes of public/officer note. This is resolved.

* QOL: Some minor behind-the-scenes tweaking lowered the fingerprint in a couple places. Extremely minimal.


**VERSION 7.2.5Beta_5_R1 - DATE: 20 July, 2017**

* **FEATURE:** SYNCING!!! Seriously, this addon will not sync the player data on rank, promotions, alts/main, and so on, both live and retroactively

*As a quick side note, this was NOT an easy job. Building a resource sensitive dynamic syncing algorithm in Lua, that could retroactively sync changes with guildies, be them online or not at the time was an enormous job. I actually didn't want to do it at first because I saw the scope of the task at hand and didn't want to do it. But, I did it... I think it was worth it!*

* Tons of updates, fixes, QoL features included, many minor, some big. Since this is a massive huge release, let's just consider it a fresh start from here!



**VERSION 7.2.5b500 - DATE: 19 Jun, 2017**

* **FEATURE:** Player zone is now displayed in playerwindow, along with the time duration they have been in the zone. Of note, the player cannot know how long they were in that zone prior to logging, so the time is reset upon logging, but from there on, any zone changes are automatically swept up with timer started for each online player. I am finding it extremely useful for things like not having to ask a player if they just got into that BG, or shouting out when they are in a long arena match, and so on.

* QOL: Fixed some text scaling issues. Ooo, ugly text on some machines. Normalizes all to same static font. Should not be weird now. Let me know if I missed any!

* QOL: Code Cleaned up a little more in a couple of places, which makes it even leaner with less server calls.

* QOL: Wrote some new methods for checking how much time has elapsed from given event, both from epoch time, and from a string timestamp. Much cleaner reporting now.

* QOL: Rearranged the positioning of the Day/Month dropdown as I think it makes more sense to have the month first.

* Bug Fix1: Issue with "mobile" players using armory app, it would screw up alt management. Text name parsed correctly from mobile icon now.

* Bug Fix2: Addon could fail in some circumstances if a player quit the guild and was linked as an alt. Not anymore!



**VERSION 7.2.5b450 - DATE: 19 Jun, 2017**

*Lots of misc. quality of life fixes here. Went through a few requests and got them added, and also worked a little more on the backend on a few things I am working on in a future update.

* Feature: On Mouseover of promotion date, it now includes "how long" a player has been at the promoted rank.

* QOL: Tooltips are now scaled down a little. They were almost obnoxiously large, imo.

* QOL: Note and officer note boxes are better designed. Word wrapping/spacing/etc... Just better

* Bug Fix1: Serious issue with timestamps I had not noticed, as server time was my local time. Apparently I was pulling local, not server, and not realizing it. This could cause issues with people playing in different time-zones than server time... potentially. Resolved

* Bug Fix2: Some issues related to the timstamp problem had to be resolved.

* Bug FixX: There was actually a LOT of behind-the-scenes labor on this one. Much more than you would realized, but there were just so many "little" things not worth mentioning here, but minor QoL stuff I made sure was taken care of.


**VERSION 7.2.5b410 - DATE: 18 Jun, 2017**

* BUG FIX!!! If a player was returning from inactity, I typo'd a bug, but didn't notice it until I was put under the circumstance of a guildie inactive returning. TY @k1ck3r for poinint this out!


**VERSION 7.2.5b400 - DATE: 17 Jun, 2017**

* TONS of work went into this update, even if on the front end the additions seem minimal. In the long run, it will have been worth it for you guys, but also for me as a developer. I won't get into it more. Just know that the x-realm solution was not as easy as I'd hoped because I had to dig into all of my frames and change the approach to how I pulled data. The good thing is it gave me the opportunity to go back and refactor much of my code and it is significantly more efficient now! One downside is your alt/main data needed to be reset. Sorry!*

* **MAJOR FEATURE:** The addon is now compatible with x-realm guilds and should successfully be able to handle multiple people of the same name in a guild, but of different servers. This was a surprisingly HUGE amount of work, even though the solution seemed rather simple. Please let me know if it is working. You MAY need to do a '/roster clearall' and reset your data if you are in a x-realm guild, but I am hoping the addon just sees it as a new person joining the guild. Please let me know how it works as I have not tested it.

*Additionally...*

* Feature: Chat message filtering options now provided for all events.

* Feature: Example, you can now disable leveling notifications to the chat window.

* QOL: Options Panel now opens and closes in a significantly better, and faster, transition

* QOL: Mousing over the roster at times felt a little "sluggish." I sped it up a little.

* QOL: The position you place the Roster Event Log is now saved between sessions.

* QOL: '/roster reset' will reset the window back to its original, centered position.

* QOL: Some text styling has changed, like "PROMOTED" is now "Promoted" and so on...

* Bug Fix1: Log events tracking now should ONLY trigger when updated from the server.

* Bug Fix1: Before, it could do a check before server returned data, thus you would get generic message rather than full details on who did what.

* Bug Fix2: "Clearing" the Rank Promotion history, the "Date Promoted?" button was not returning to proper position.

* Bug Fix3: "Guild Log" button will now seat properly if frame is dragged over it.

* Bug Fix4: Demoting from Main to alt would bug out due to a code typo I introduced last patch and didn't notice. FIXED


**VERSION 7.2.5b300 - DATE: 15 Jun, 2017**

*There was some confusion that was 100% my fault. This IS a BETA release. I mistakenly set it as release. I apologize for that rather serious distinction. As such, it should be noted that THIS IS A MASSIVE RELEASE! HUGE UPDATES!!! Sadly, due to major overhaul of data management and data merging techniques, far more efficient now, it was not backwards compatible. SO SORRY!*

* **MAJOR FEATURE:** Guild data is now stored per faction, and per guild. Are you in a guild that has the same name on both Alliance and Horde side? This should no longer have any issues... Seemless loading as you hop between toons and guilds and factions.


* Bug fix1: Officer Note Editbox was broken last patch. OOPS! Re-fixed

* Bug fix2: Fixed error that *could* happen if player loads addon not in guild, but then joins one. Caused various weird problems. FIXED

* Bug fix3: Namechange detection could error and report incorrectly under various conditions. Tightened to 100% detection.

* Bug fix4: Officer note change spam fixed! Such an annoying bug! Sorry about that one!

* Bug fix5: No merge merge issues!

* QOL: Slash command '/roster' should now open your Log window Properly

* QOL: Grey out options that do not pertain to player if they do not have permissions.

* QOL: Proper error message if player tries to add invalid alt name.

* QOL: Add Event Frame now updates live if events trigger and window is open

* MISC1: Player now can see if a player is on the mobile chat with "Is Mobile" indication

* MISC2: Add Event Calendar now restricts the player to adding 1 event to calendar per 5 seconds, due to internal Blizz server limit.

* MISC3: Several more things being tracked in the background... to be implemented in future patch 

* MISC4: And several other minor things not worth mentioning...


**VERSION 1.02 - DATE: 13 Jun, 2017**

* Feature1: You can now right click player name in main window for additional options

* Feature2: You can now reset an individual's saved data, if needed.

* Feature3: Better main/alt management - ability to set player as main, even without alts

* Feature3: This allows any subsequent alts added to auto-be tagged as "alt" instad of main. Minor QoL.

* Bug fix1: TAINT issues have been resolved (by building my own Dropdowns) - HUGE JOB

* Buf fix1: You no longer should be unable to enter a BG without disabling addon, for example!

* Bug fix2: Scaling issue (yes, not ALL scaling issues are resolved yet)

**VERSION: 1.01 - DATE: 11 Jun, 2017**

* Bug fix: On player namechange detection, it now changes the name in the alts lists as well!


**VERSION: 1.00 - DATE: 11 Jun, 2017**

* Initial Release