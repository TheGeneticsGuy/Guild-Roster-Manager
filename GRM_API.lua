-- Public Tool Useful APIs
-- NOT YET EXPANDED ON.


-- Method:          GRM.ClearFriendsList()
-- What it Does:    Clears the entire server side, non-battletag friends list completely to zero
-- Purpose:         For debugging cleanup
GRM.ClearFriendsList = function()
    for i = C_FriendList.GetNumFriends() , 1 , -1 do
        local name = C_FriendList.GetFriendInfoByIndex ( i ).name;
        C_FriendList.RemoveFriend ( name );
    end
end

-- Method:          GRM.ClearAllOfficerNotes()
-- What it Does:    Clears every officer note to every player in the guild
-- Purpose:         Mass cleanup abilities
GRM.ClearAllOfficerNotes = function()

    if CanEditOfficerNote() then
        for i = 1 , GetNumGuildMembers() do
            GuildRosterSetOfficerNote ( i , "" );
        end
    else
        if IsInGuild() then
            GRM.Report ( GRM.L ( "Unable to change officer notes at current rank" ) );
        else
            GRM.Report ( ( "Player is not in a guild" ) );
        end
    end
end
