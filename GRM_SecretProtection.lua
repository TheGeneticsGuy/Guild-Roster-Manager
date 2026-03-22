-- For Midnight Addon restriction changes...
local Secrets = {};
GRM.Secrets = Secrets;

GRM_G.Secrets = {};

-- Method:          Secrets.BuildHasSecretRestrictions()
-- What it Does:    Returns true if the current build has active Addon restrictive state as implemented in Midnight
-- Purpose:         Act as a gate so a wrapper can be around public/officer note editing features...
Secrets.BuildHasSecretRestrictions = function()
    if C_Secrets and C_Secrets.HasSecretRestrictions() then
        return true;
    end
    return false;
end

-- Wrap all the Secret/Protected logic so they will only initialize IF the current build supports
local InitializeSecrets = function()
    local restrictionListener = CreateFrame("Frame");
    local stateEnum = {[0]="Inactive", [1]="Activating", [2]="Active"}; -- Enum.AddOnRestrictionState reversed
    local typeEnum = {[0]="Combat", [1]="Encounter", [2]="ChallengeMode", [3]="PvPMatch", [4]="Map"}; -- Enum.AddOnRestrictionType reversed

    restrictionListener:RegisterEvent("ADDON_RESTRICTION_STATE_CHANGED");
    restrictionListener:SetScript("OnEvent", function(_, event, type, state)
        GRM_G.Secrets[typeEnum[type]] = state;

        if Secrets.IsAddonRestricted() then
            GRM_G.AddonRestricted = true;
        else
            GRM_G.AddonRestricted = false;
        end
    end);

    Secrets.IsAddonRestricted = function()
        for _, state in pairs(GRM_G.Secrets) do
            if state > 0 then
                return true;
            end
        end
        return false
    end

end

-- Initialize
if Secrets.BuildHasSecretRestrictions() then
    GRM_G.BuildHasRestrictions = true;
    InitializeSecrets();
end


