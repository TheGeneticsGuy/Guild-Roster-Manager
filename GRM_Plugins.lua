-- GRM plugin support - PENDING FEATURE (not anytime soon, just laying some infrastructure)

-- CATEGORIES

    -- General API access to GRM user metadata

    -- Custom UI Creation Tools specific to the GRM Plugin location
        -- Option to place an item by dragging and dropping after creation as well
        -- Set other addon functions to custom plugin buttons
        -- Option to place the info *anywhere* or to keep it within the plugin info

        -- Early Example:
            -- GRM_P.CreateText ( nameOfTextString , stringPattern , inputs ... , r , g , b )      -- Just creates a simple fontstring
            -- GRM_P.CreateCheckBox ( nameOfCheckButton , text , buttonFunction )
            -- and so on...

    -- Sync access for limited information sharing using GRM's sync network
        -- Create a list of all information you wish to be part of the sync protocol.
        -- GRM will automatically break apart that information and format into a string to be sent. Sync leader will merely
        --  pass the information on... so as to maintain compatibility for any plugin with non plugin users as well. But this might be spammy if they passed it on... 
        --  Have to think about this one a little bit for ideal situation.



-- GRM_P = {};