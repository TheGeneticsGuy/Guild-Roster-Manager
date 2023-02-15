
-- PENDING FEATURE
-- Stats feature, also to include API to build specialized frames, like the progress bars.



-- Method:          GRM_API.CreateNewProgressBar ( frame , string , int , int , {R , G , B} )
-- What it Does:    Initializes and creates a new progress bar
-- Purpose:         Tool to be able to make new progress bars as needed.
GRM_API.CreateNewProgressBar = function ( parentFrame , frameName , width , height , colorTable )
    local textureName = frameName .. "Texture";
    local textName = frameName .. "Text";

    -- Build progress bar
    parentFrame[frameName] = CreateFrame ( "Frame" , frameName , parentFrame , BackdropTemplateMixin and "BackdropTemplate" );
    GRM.CreateTexture ( parentFrame[frameName] , textureName , "ARTWORK" , true );
    parentFrame[frameName]:SetSize ( width , height );
    parentFrame[frameName]:SetBackdrop ( GRM_UI.framelessBackdrop );

    -- Add Text
    parentFrame[frameName][textName] = parentFrame[frameName]:CreateFontString ( nil , "OVERLAY" , "GameFontWhiteTiny" );
    parentFrame[frameName][textName]:SetPoint ( "RIGHT" , parentFrame[frameName] , "LEFT" , -7 , 0 );
    parentFrame[frameName][textName]:SetJustifyH ( "RIGHT" );
    parentFrame[frameName][textName]:SetText ( "0%" );
    
    -- Initialize Texture
    parentFrame[frameName][textureName]:SetPoint ( "LEFT" , parentFrame[frameName] , "LEFT" );
    parentFrame[frameName][textureName]:SetColorTexture ( colorTable[1] , colorTable[2] , colorTable[3] , 1 );

    -- OnUpdate
    parentFrame[frameName].Timer = 0;
    parentFrame[frameName].Percent = 0;
    
end

-- /run GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , 5 );
-- Method:          GRM_API.CreateNewProgressBar ( frame , int , int )
-- What it Does:    Enable the progress bar to actual display progress
-- Purpose:         Useful quality of life feature.
GRM_API.TriggerProgressBar = function ( progressBar , destinationNumber , timeToProgress )
    local count = 0;
    local loopDelay = 0.1;
    local num = 0;
    local ascending = true;
    local progressBarTexture = progressBar[progressBar:GetName() .. "Texture" ];
    local progressBarText = progressBar[progressBar:GetName() .. "Text" ];
    local barWidth = progressBar:GetWidth();

    -- Determine what % of total amount needs to go up or down
    if destinationNumber > progressBar.Percent then
        num = destinationNumber - progressBar.Percent;

    elseif destinationNumber < progressBar.Percent then
        num = progressBar.Percent - destinationNumber;
        ascending = false;

    end

    -- Instant progress - super speed in 1 second
    if timeToProgress == 0 then -- Go all the way if time = 0;
        loopDelay = 1 / math.floor ( num + 0.5 );

    else
        -- Over Time
        loopDelay = timeToProgress / math.floor ( num + 0.5 );
        
    end

    progressBar:SetScript ( "OnUpdate" , function ( self , elapsed )
        progressBar.Timer = progressBar.Timer + elapsed;
        if progressBar.Timer >= loopDelay then

            if ascending then
                progressBar.Percent = progressBar.Percent + 1;
            else
                progressBar.Percent = progressBar.Percent - 1;
            end
            
            progressBarText:SetText ( math.floor ( progressBar.Percent + 0.5 ) .. "%" );
            progressBarTexture:SetSize ( ( progressBar.Percent / 100 ) * barWidth , 20 )

            if ( ascending and progressBar.Percent >= destinationNumber ) or ( not ascending and progressBar.Percent <= destinationNumber ) then
                progressBar:SetScript ( "OnUpdate" , nil );
                print("Progress Complete!!")
            end

            progressBar.Timer = 0;
        end

    end);

end

-- Method:          GRM_API.SetProgressBarColor ( frame , RGBTable )
-- What it Does:    Sets the color of the progress bar texture as needed
-- Purpose:         Dynamic control of the progress colors.
GRM_API.SetProgressBarColor = function ( progressBar , colors )

    if colors and type ( colors ) == "table" and #colors == 3 then
        local progressBarTexture = progressBar[progressBar:GetName() .. "Texture" ];
    
        progressBarTexture:SetColorTexture ( colors[1] , colors[2] , colors[3] , 1 );
    end

end