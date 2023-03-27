
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
    parentFrame[frameName].RemainingTime = 0;
    parentFrame[frameName].StartTime = 0;
    parentFrame[frameName].Percent = 0;
    parentFrame[frameName].killSwitch = false;
    parentFrame[frameName].Hold = false;
    parentFrame[frameName].colorOnComplete = {};
    
end

-- /run GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , 100 , 5 );
-- Method:          GRM_API.CreateNewProgressBar ( frame , int , int , {r,g,b} , bool )
-- What it Does:    Enable the progress bar to actual display progress
-- Purpose:         Useful quality of life feature.
GRM_API.TriggerProgressBar = function ( progressBar , destinationNumber , timeToProgress , colorOnComplete , hold )

    if not progressBar.Hold or destinationNumber > 0 then       -- Hold a call and ignore all others.
        local count = 0;
        local loopDelay = 0.1;
        local num = 0;
        local ascending = true;
        local progressBarTexture = progressBar[progressBar:GetName() .. "Texture" ];
        local progressBarText = progressBar[progressBar:GetName() .. "Text" ];
        local barWidth = progressBar:GetWidth();
        local t = 0; -- Time placeholder
        if colorOnComplete then
            progressBar.colorOnComplete = colorOnComplete;
        end

        if timeToProgress > 0 and timeToProgress < 1 then
            t = 1;
        else
            t = timeToProgress;
        end

        -- Determine what % of total amount needs to go up or down
        if destinationNumber > progressBar.Percent then
            num = destinationNumber - progressBar.Percent;

        elseif destinationNumber < progressBar.Percent then
            num = progressBar.Percent - destinationNumber;
            ascending = false;

        end

        -- Instant progress - super speed in 1 second
        if t == 0 then -- Go all the way if time = 0;
            progressBar.Percent = destinationNumber;
            progressBarText:SetText ( math.floor ( progressBar.Percent + 0.5 ) .. "%" );
            progressBarTexture:SetSize ( ( progressBar.Percent / 100 ) * barWidth , 20 )

        else
            -- Over Time
            loopDelay = t / math.floor ( num + 0.5 );

            -- Dealing with sub 1 second time
            if timeToProgress > 0 and timeToProgress < 1 then
                loopDelay = loopDelay / ( 1 / timeToProgress );
            end
            
            progressBar.StartTime = time();
            if hold and destinationNumber > 0 then
                progressBar.Hold = true;
            end

            progressBar:SetScript ( "OnUpdate" , function ( self , elapsed )
                self.Timer = self.Timer + elapsed;
                if not self.killSwitch then
                    if self.Timer >= loopDelay then

                        self.RemainingTime = t - ( time() - self.StartTime );
            
                        if ascending then
                            self.Percent = self.Percent + 1;
                        else
                            self.Percent = self.Percent - 1;
                        end
                        
                        progressBarText:SetText ( math.floor ( self.Percent + 0.5 ) .. "%" );
                        progressBarTexture:SetSize ( ( self.Percent / 100 ) * barWidth , 20 )
            
                        if ( ascending and progressBar.Percent >= destinationNumber ) or ( not ascending and self.Percent <= destinationNumber ) then
                            self:SetScript ( "OnUpdate" , nil );
                            if colorOnComplete then
                                progressBarTexture:SetColorTexture ( progressBar.colorOnComplete[1] , progressBar.colorOnComplete[2] , progressBar.colorOnComplete[3] , 1 );
                            end
                            self.killSwitch = true;
                            if progressBar.Hold then
                                progressBar.Hold = false;
                                GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , destinationNumber , timeToProgress , progressBar.colorOnComplete , false );
                            end

                        end
            
                        self.Timer = 0;
                    end
                else
                    self:SetScript ( "OnUpdate" , nil );
                    self.killSwitch = true;
                    self.RemainingTime = 0;
                end
        
            end);

        end
    end

end

-- Method:          GRM_API.CheckPoint ( progressBarObject , in , int [,int] )
-- What it Does:    Adds a checkpoint to tweak the progressBar with updates as it goes.
-- Purpose:         Tighter controls of progress bar. Let's say you want it to reach 100% after 20 seconds. Well, you know X task must be completed at about half way through. Let's say you complete X task, so you trigger a 50% checkpoint -- it turns out that only 5 seconds have passed and you are already at the 50% mark. Well, you quickly go from 25% to 50% over the next second, then you recalculate the remaining time from 15 seconds down to 10 seconds. It is just a quality of life improvement. You need to know exectedCheckpoint time though for this to work. The final number can be modified but that may break things... be warned. It is recommended to keep at 100% as standard.
GRM_API.CheckPoint = function ( progressBar , destinationNumber , expectedCheckPointTime , final )

    local finalPercent = final or 100;

    if progressBar.RemainingTime > 1 then
        if destinationNumber > progressBar.Percent then

            GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , destinationNumber , 1 , progressBar.colorOnComplete , true , { finalPercent , GRMsyncGlobals.totalEstTime - progressBar.RemainingTime } );

        elseif destinationNumber < progressBar.Percent then
            
            GRM_API.TriggerProgressBar ( GRM_UI.GRM_SyncTrackerWindow.GRM_SyncProgressBar , finalPercent , expectedCheckPointTime - ( time() ) - parentFrame[frameName].StartTime , progressBar.colorOnComplete );

        end
    end
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

-- Method:          GRM_API.ResetProgressBar ( object , table {r,g,b} , bool )
-- What it Does:    Resets the progress bar to 0% and adjusts the color how you want
-- Purpose:         Reusable control to reset bar quickly.
GRM_API.ResetProgressBar = function ( progressBar , colors , isVert )
    local progressBarTexture = progressBar[progressBar:GetName() .. "Texture" ];
    progressBar[progressBar:GetName() .. "Text" ]:SetText ( "0%" );
    progressBar.Percent = 0;

    if isVert then
        progressBarTexture:SetSize ( progressBarTexture:GetWidth() , 1 );
    else
        progressBarTexture:SetSize ( 1 , progressBarTexture:GetHeight() );
    end

    if colors and type ( colors ) == "table" and #colors == 3 then
    
        progressBarTexture:SetColorTexture ( colors[1] , colors[2] , colors[3] , 1 );
    end

end