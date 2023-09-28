-- LibAlt import

local AltsAvailableToImport = function()
    local isAvailable = false;
    local listOfAddons = {};

    if IsInGuild() and GRM_G.guildName and GRM_G.guildName ~= "" then

        -- Check the Alts addon first
        if IsAddOnLoaded ( "Alts" ) and AltsDB and AltsDB.realm and AltsDB.realm[GRM_G.realmName] and AltsDB.realm[GRM_G.realmName].altsBySource["guild:".. GRM.SlimName ( GRM_G.guildName )] GRM.TableLength ( AltsDB.realm[GRM_G.realmName].altsBySource["guild:".. GRM.SlimName ( GRM_G.guildName )] ) > 0 then

            isAvailable = true;
            table.insert  ( listOfAddons , "Alts" );

        end
            
    end

    return isAvailable , listOfAddons
end

local DBCheck = function()

    local isAvailable , listOfAddons = AltsAvailableToImport();
    if isAvailable then

    end

end

GRM.ExportMainTagToNotes = function ( destinationNote )
    -- 1 = note, 2 == officerNote, 3 = custom
    local destination = destinationNote or 1;

end

GRM.ExportAltTagToNotes = function ( destinationNote )

    local destination = destinationNote or 1;

end

GRM.ImportAllMains = function()

end

GRM.ImportAllAlts = function()

end

-- When setting Main, it adds the main tag to the officer note
-- [M] or [A]mainName -- mainName - see if more than 1 with same mainName, if so, include server if different server. mainName-ServerName