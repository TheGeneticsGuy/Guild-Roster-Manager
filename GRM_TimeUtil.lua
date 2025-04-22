-- All the time and time conversion functions.

local Time = {};
GRM.Time = Time;

Time.Enums = {}

-- GLOBAL Time Lookup Tables
-- Of note, these will be in English as default, but when used will be passed through the localizer.
local Configure_Time_Enums = function()
    local months = { "January" , "February" , "March" , "April" , "May" , "June" , "July" , "August" , "September" , "October" , "November" , "December" }
    local abrev = "";

    Time.Enums.abbrev_month_ind = {}
    Time.Enums.month_abbrev = {}
    Time.Enums.ind_to_month_abbrev = {}
    Time.Enums.months_full_name = {}

    for i = 1 , #months do
        abrev = months[i]:sub(1,3)
        Time.Enums.months_full_name[months[i]] = i
        Time.Enums.abbrev_month_ind[abrev] = i
        Time.Enums.ind_to_month_abbrev[i] = abrev
        Time.Enums.month_abbrev[i] = abrev

    end
end

Time.Enums.days_before_month = {
    [1] = 0,
    [2] = 31,
    [3] = 59,
    [4] = 90,
    [5] = 120,
    [6] = 151,
    [7] = 181,
    [8] = 212,
    [9] = 243,
    [10] = 273,
    [11] = 304,
    [12] = 334
};
Time.Enums.days_in_month = {
    [1] = 31,
    [2] = 28, -- Will adjust for leap years as needed
    [3] = 31,
    [4] = 30,
    [5] = 31,
    [6] = 30,
    [7] = 31,
    [8] = 31,
    [9] = 30,
    [10] = 31,
    [11] = 30,
    [12] = 31
}

---- END OF LOOKUP TABLES ---

Time.GetTodaysDate = function()
    local calendarTime;

    if C_DateAndTime.GetCurrentCalendarTime then
        -- RETAIL
        calendarTime = C_DateAndTime.GetCurrentCalendarTime();
        return calendarTime.weekday, calendarTime.month, calendarTime.monthDay, calendarTime.year, calendarTime.hour,
            calendarTime.minute;
    else
        -- CLASSIC
        calendarTime = C_DateAndTime.GetTodaysDate();
        return calendarTime.weekDay, calendarTime.month, calendarTime.day, calendarTime.year;
    end
end

Time.GetCurrentCalendarTime = function()
    if C_DateAndTime.GetCurrentCalendarTime then
        return C_DateAndTime.GetCurrentCalendarTime();
    else
        return C_DateAndTime.GetTodaysDate();
    end
end

------------------------------------
------ TIME TRACKING TOOLS ---------
--- TIMESTAMPS , TIMEPASSED, ETC. --
------------------------------------

-- Method:          Time.IsLeapYear(int)
-- What it Does:    Returns true if the given year is a leapYear
-- Purpose:         For this addon, the calendar date selection, allows it to know to produce 29 days on leap year.
Time.IsLeapYear = function(yearDate)
    if yearDate < 100 then
        yearDate = yearDate + 2000; -- Some old formatting had an array of dates with the year only with the 2 digits. In other words, 2012 would be "12"
    end
    return (((yearDate % 4 == 0) and (yearDate % 100 ~= 0)) or (yearDate % 400 == 0));
end

-- Method:          Time.CalculateTotalHours ( list )
-- What it Does:    Returns the numbers of hours of time passed given the lastOnline x years,months,days,hours
-- Purpose:         Accuracy in determine how long someone has been offline.
Time.CalculateTotalHours = function(timeTable)
    local _, month, _, year = Time.GetTodaysDate();

    local currentMonth = month;
    local currentYear = year;

    local years = timeTable[1] or 0;
    local months = timeTable[2] or 0;
    local days = timeTable[3] or 0;
    local hours = timeTable[4] or 0;

    local totalDays = 0;
    -- Calculate days based on full years
    for i = 1, years do
        if Time.IsLeapYear(currentYear - i) then
            totalDays = totalDays + 366;
        else
            totalDays = totalDays + 365;
        end
    end

    -- Calculate days for the remaining months in the current year
    local remainingMonths = months;
    local monthCounter = currentMonth;

    while remainingMonths > 0 do
        monthCounter = monthCounter - 1;
        if monthCounter < 1 then
            monthCounter = 12;
            currentYear = currentYear - 1;
        end

        totalDays = totalDays + Time.DaysInMonth(monthCounter, currentYear);
        remainingMonths = remainingMonths - 1;
    end

    -- Add the remaining days
    totalDays = totalDays + days;

    -- Calculate total hours
    local totalHours = hours + (totalDays * 24);

    if totalHours == 0 and not timeTable[5] then
        totalHours = 0.5;
    end

    return totalHours
end

-- Method:          Time.DaysInMonth ( int , int )
-- What it Does:    Returns the int number of days in a given month.
-- Purpose:         Useful for getting EXACT time, not estimates.
Time.DaysInMonth = function(month, year)
    if month == 2 and Time.IsLeapYear(year) then
        return 29
    end
    return Time.Enums.days_in_month[month];
end

-- Method:          Time.ConvertToStandardFormatDate ( int , int , int )
-- What it Does:    Converts the date into ISO 8601 international standard.
-- Purpose:         It's easy to parse this date.
Time.ConvertToStandardFormatDate = function(day, month, year)

    local result = "";

    if year > 0 and month > 0 and day > 0 then

        result = tostring(year);

        if month < 10 then
            result = result .. "0" .. tostring(month);
        else
            result = result .. tostring(month);
        end

        if day < 10 then
            result = result .. "0" .. tostring(day);
        else
            result = result .. tostring(day);
        end

    end

    return result;
end

-- Method:          Time.ParseStandardFormatDate ( string )
-- What it Does:    Converts the string formated date into integers, separated by YYYY,MM,DD
-- Purpose:         Easily store the dates of people for sync purposes in easily formatted use
Time.ParseStandardFormatDate = function(date)

    if #date == 8 then
        local year, month, day = string.match(date, "(%d%d%d%d)(%d%d)(%d%d)");

        return tonumber(day), tonumber(month), tonumber(year);
    else
        return "";
    end

end

-- Method:          Time.ConvertToEpoch ( int , int , int )
-- What it Does:    Converts a time to epochTime
-- Purpose:         Useful in comparing amounts.
Time.ConvertToEpoch = function(d, m, y)
    return time({
        day = d,
        month = m,
        year = y
    });
end

-- Method:          Time.ValidateHist ( playerTable )
-- What it Does:    It verifies that the data is stored properly
-- Purpose:         Prevents some edge case errors that have not been properly sourced where the verified bool has been flipped but no date added.
Time.ValidateHist = function ( player )

    if player.rankHist[1][7] and ( player.rankHist[1][2]==0 or player.rankHist[1][3]==0 or player.rankHist[1][4]==0 ) then
        player.rankHist = {{player.rankName, 0, 0, 0, "0", 0, false, 1, 0}};
    end

    if player.joinDateHist[1][6] and ( player.joinDateHist[1][1]==0 or player.joinDateHist[1][2]==0 or player.joinDateHist[1][3]==0 ) then
        player.joinDateHist = {{0, 0, 0, "0", 0, false, 1}};
    end

    return player;
end

-- Method:          Time.GetTimestamp()
-- What it Does:    Returns the exact time, as per the server, to the minute. Does not return seconds.
-- Purpose:         Just for cleaner presentation of the results. Also, need to report based on server time. In-game API only returns hour/min, not month and day. This resolves that.
Time.GetTimestamp = function()
    -- Time Variables
    local month, day, year, hour, minutes = select(2, Time.GetTodaysDate());
    if not hour then
        hour, minutes = GetGameTime();
    end
    return {day, month, year, hour, minutes};   -- Rearranged for day, month, year in order -- hour/minutes thrown at end.
end

-- Method:          Time.GetTimePassedInZone ( oldTimestamp , int , bool )
-- What it Does:    Reports back how many days, hours, minutes, or seconds has passed since player has been in a zone (days is unrealistic I know but some people might put in a 24hr+ session, so you never know.)
-- Purpose:         Time tracking to keep track of elapsed time in a zone.
Time.GetTimePassedInZone = function(oldTimestamp, exactSeconds, includeAll)
    local totalSeconds = exactSeconds or (time() - oldTimestamp);
    local year = math.floor(totalSeconds / 31536000); -- seconds in a year
    local yearTag = GRM.L("Year");
    local month = math.floor((totalSeconds % 31536000) / 2592000); -- etc.
    local monthTag = GRM.L("Month");
    local days = math.floor((totalSeconds % 2592000) / 86400);
    local dayTag = GRM.L("Day");
    local hours = math.floor((totalSeconds % 86400) / 3600);
    local hoursTag = GRM.L("Hour");
    local minutes = math.floor((totalSeconds % 3600) / 60);
    local minutesTag = GRM.L("Minute");
    local seconds = math.floor((totalSeconds % 60));
    local secondsTag = GRM.L("Second");

    local timestamp = "";
    if year > 1 then
        yearTag = GRM.L("Years");
    end
    if month > 1 then
        monthTag = GRM.L("Months");
    end
    if days > 1 then
        dayTag = GRM.L("Days");
    end
    if hours > 1 then
        hoursTag = GRM.L("Hours");
    end
    if minutes > 1 then
        minutesTag = GRM.L("Minutes");
    end
    if seconds ~= 1 then
        secondsTag = GRM.L("Seconds");
    end

    if year > 0 or month > 0 or days > 0 then

        if year > 0 then
            timestamp = (GRM.L("{num} {custom1}", nil, nil, year, yearTag));
        end
        if month > 0 then
            timestamp = (timestamp .. " " .. GRM.L("{num} {custom1}", nil, nil, month, monthTag));
        end
        if days > 0 then
            timestamp = (timestamp .. " " .. GRM.L("{num} {custom1}", nil, nil, days, dayTag));
        end
    end

    if (year == 0 and month == 0 and days == 0) or includeAll then
        if hours > 0 or minutes > 0 then
            if hours > 0 then
                timestamp = (timestamp .. " " .. GRM.L("{num} {custom1}", nil, nil, hours, hoursTag));
            end
            if minutes > 0 then
                timestamp = (timestamp .. " " .. GRM.L("{num} {custom1}", nil, nil, minutes, minutesTag));
            end
        end
        if (hours == 0 and minutes == 0) or includeAll then
            if not includeAll or #timestamp == 0 then
                timestamp = (GRM.L("{num} {custom1}", nil, nil, seconds, secondsTag));
            else
                timestamp = (timestamp .. " " .. GRM.L("{num} {custom1}", nil, nil, seconds, secondsTag));
            end
        end
    end

    return timestamp;
end

-- Method:          Time.ConvertTimetableToServer ( table )
-- What it Does:    Returns the day, month, year in integer format based on the given timetable, adjusted to match server time based on the given offset.
-- Purpose:         Adapt OS time to match the Blizzard server time
-- Notes:           This can be used manually with the offset. If you already know that your local time is offset by 2 hrs, where your OS is at 9am, but server is 11am,
--                  then a "+2" offset is what is needed. If you are ahead of the server by 3hrs, the a "-3" is needed to match the server time.
--                  The logic can get complicated for the edge cases, like if it is Jan 1st, 2021 at 1am local time, yet your server is Dec. 31st, 2020 at 11pm. Gotta adjust.
Time.ConvertTimetableToServer = function(timeTable)

    if GRM_G.OStimeOffset ~= 0 then
        local newHour = timeTable.hour;

        if newHour >= 24 then
            timeTable.hour = newHour - 24;

            -- Ok, need to shift the day up 1;
            local maxDays = Time.DaysInMonth(timeTable.month, timeTable.year);

            if maxDays == timeTable.day then
                -- We have to shift it to the next month and the day goes to 1;\
                timeTable.day = 1;

                -- We need to adjust the month up too
                if timeTable.month == 12 then
                    timeTable.month = 1;
                    timeTable.year = timeTable.year + 1;
                else
                    timeTable.month = timeTable.month + 1;
                end
            else
                -- We are good, no more changing, adjust the day up by 1.
                timeTable.day = timeTable.day + 1;
            end

        elseif newHour < 0 then
            timeTable.hour = 24 + newHour;
            -- Ok, we need to shift the day down

            if timeTable.day == 1 then
                -- Now, we need to determine how many days in the month.
                if timeTable.month == 1 then
                    timeTable.month = 12;
                    timeTable.year = timeTable.year - 1;
                else
                    timeTable.month = timeTable.month - 1;
                    timeTable.day = Time.DaysInMonth(timeTable.month, timeTable.year);
                end
            else
                timeTable.day = timeTable.day - 1;
            end
        else
            timeTable.hour = newHour;
        end
    end

    return timeTable.day, timeTable.month, timeTable.year, timeTable.hour;
end

-- Method:          Time.EpochToDateFormat( int , int )
-- What it Does:    It takes an epoch timestamp and converts it into a string format as desired.
-- Purpose:         Epoch is very exact, to the second. It is nice to store that info than hard to interpret, non-mathematical text, for a computer.
--                  This is just easy formatting for human consumption
Time.EpochToDateFormat = function(epochstamp, forcedFormat)
    local day, month, year = 0, 0, 0;
    local sFormat = "";
    local tFormat;

    if epochstamp > 0 then
        day, month, year = Time.ConvertTimetableToServer(date("*t", epochstamp));
        sFormat = Time.FormatTimeStamp({day, month, year}, false, false, forcedFormat);
    end

    tFormat = {day, month, year};

    return sFormat, tFormat;
end

-- Method:          Time.GetHoursSinceTimestamp( int )
-- What it Does:    Returns the number of hours that has passed since as a flat integer. Anything less than 1hr returns zero
-- Purpose:         To be able to return the number of hours since the given time.
Time.GetHoursSinceTimestamp = function(epochStamp)
    local totalSeconds = time() - epochStamp;
    return math.floor(totalSeconds / 3600);
end

-- Method:          Time.DayOfYear ( dateArray { d,m,y })
-- What it Does:    Returns the number of days of the year you are at. For example, Dec. 31, 2024 would return 366 since it's a leap year
-- Purpose:         Easier way to do comparisons on days if we convert them to current day of the year vs futureday of the year.
Time.DayOfYear = function(date)
    local day, month, year = date[1], date[2], date[3];

    local dayOfYear = day
    for i = 1, month - 1 do
        dayOfYear = dayOfYear + Time.DaysInMonth(i, year);
    end

    return dayOfYear;
end

-- Method:          Time.GetDaysBetweenDates ( table , table )
-- What it Does:    Returns the number of days until the next event
-- Purpose:         Useful for calculating future dates.
-- Formatting       { dd,mm,yyyy }
Time.GetDaysBetweenDates = function(currentDate, futureDate)

    -- Setting up the anniversary date
    -- if the future month is less than or equal to the current
    if futureDate[2] <= currentDate[2] then
        if futureDate[2] < currentDate[2] then
            futureDate[3] = currentDate[3] + 1; -- Move it to the next year.
        else
            -- Both dates are the same month, let's check the day
            if futureDate[1] < currentDate[1] then
                futureDate[3] = currentDate[3] + 1;
            end
        end
    end

    local currentDayOfYear = Time.DayOfYear(currentDate);
    local futureDayOfYear = Time.DayOfYear(futureDate);

    local daysDifference = futureDayOfYear - currentDayOfYear;
    if futureDate[3] == currentDate[3] + 1 then
        -- Handle the case where the future date is in the next year
        daysDifference = daysDifference + 365;
    end

    return daysDifference;
end

-- Method:          Time.GetTimePassedUsingTableOrString()
-- What it Does:    Returns the Years, hours, and days that have passed since the given timestamp ( In format "day mon 'year")
-- Purpose:         Honestly, simpler solution than build a solution to parse through epoch time, since I don't need hours, minutes, seconds.
Time.GetTimePassedUsingTableOrString = function(timestamp)

    local startYear, startMonth, startDay;
    local month, day, year = select(2, Time.GetTodaysDate());
    local result = {0, 0, 0, "", 0}; -- resultYear, resultMonth , resultDay;

    if type(timestamp) == "string" then

        startYear = tonumber(string.sub(string.match(timestamp, "'%d%d"), 2)) + 2000;
        startMonth = Time.Enums.abbrev_month_ind[string.match(timestamp, "%a+")];
        startDay = tonumber(string.match(timestamp, "%d+"));

    elseif type(timestamp) == "table" then
        startDay = timestamp[1];
        startMonth = timestamp[2];
        startYear = timestamp[3]
    end

    if startYear < 1000 then
        startYear = startYear + 2000;
    end

    -- Narrow down the year!
    if year > startYear then -- If this event happened in a previous year.
        result[1] = year - startYear;
        if month < startMonth then -- Event is less than a year!
            result[1] = result[1] - 1;
        elseif month == startMonth then
            -- Need to check the day!
            if day < startDay then
                result[1] = result[1] - 1;
            else
                result[1] = year - startYear; -- If >= then it counts as 1 year.
            end
        else -- month > start meaning it's been a year.
            result[1] = year - startYear;
        end
    else
        result[1] = 0;
    end

    -- Ok, now let's get the month! Much easier!
    if month < startMonth then
        result[2] = month + (12 - startMonth);
        if day < startDay then -- Not quite 1 month
            result[2] = result[2] - 1;
        end
    elseif month == startMonth then
        if startYear == year then
            result[2] = 0;
        else
            if day < startDay then
                result[2] = 11;
            else
                result[2] = 0;
            end
        end
    else -- month > start
        if day < startDay then
            result[2] = (month - startMonth) - 1;
        else
            result[2] = month - startMonth;
        end
    end

    -- Finally, let's do the day!
    if day < startDay then

        local tempMonth = month;
        if tempMonth == 12 then
            tempMonth = 1;
        end
        result[3] = day + (Time.Enums.days_in_month[tempMonth] - startDay);

    else
        result[3] = day - startDay;
    end

    -- Final text report
    if result[1] > 0 then
        if result[1] == 1 then

            result[4] = result[4] .. GRM.L("{num} year", nil, nil, result[1]) .. " ";
        else
            result[4] = result[4] .. GRM.L("{num} years", nil, nil, result[1]) .. " ";
        end
    end
    if result[2] > 0 then
        if result[2] == 1 then
            result[4] = result[4] .. GRM.L("{num} month", nil, nil, result[2]) .. " ";
        else
            result[4] = result[4] .. GRM.L("{num} months", nil, nil, result[2]) .. " ";
        end
    end
    if result[3] > 0 and result[1] == 0 then -- To avoid including days if you have more than 1 year just need year and months
        if result[3] == 1 then
            result[4] = result[4] .. GRM.L("{num} day", nil, nil, result[3]) .. " ";
        else
            result[4] = result[4] .. GRM.L("{num} days", nil, nil, result[3]) .. " ";
        end
    end
    -- Clear off any white space.
    if result[1] == 0 and result[2] == 0 and result[3] == 0 then
        result[4] = GRM.L("< 1 day");
    else
        result[4] = GRM.Trim(result[4]);
    end
    return result;
end

-- Method:          Time.GetTimePassedUsingEpochTime ( int )
-- What it Does:    Returns a table with the time that has passed
-- Purpose:         Easily know how much time has passed since a given event based on the epochstamp
Time.GetTimePassedUsingEpochTime = function(epochSeconds)
    local result = {};
    local epochTimeStamp = Time.EpochToDateFormat(epochSeconds, 1); -- Setting to 1 so it can be easily formatted for parsing.
    local details = Time.GetTimePassedUsingTableOrString(epochTimeStamp);

    result.Years = details[1];
    result.Months = details[2];
    result.Days = details[3];
    result.timestamp = details[4];

    return result;
end

-- Method:          Time.GetTimePlayerHasBeenMember ( string )
-- What it does:    Parses the string of the player date they joined the guild the most recent, and then obtains how long they have been a member.
-- Purpose:         To display useful info on how long the player has been a member of the guild.
Time.GetTimePlayerHasBeenMember = function(name)
    local player = GRM.GetPlayer(name);
    local result = "";

    if player then
        if #player.joinDateHist[1][4] > 1 then
            result = Time.GetTimePassedUsingTableOrString({player.joinDateHist[1][1], player.joinDateHist[1][2], player.joinDateHist[1][3]});
            result = result[4];
        end
    end
    return result;
end

-- Method:          Time.ComplexHoursReport(int)
-- What it Does:    Reports as a string the time passed since player last logged on. The logic is rather complex because this works backward and has to assume that information may not be available as it is used for log reporting even on players that may not be in the guild anymore thus do not have access to current last login information.
-- Purpose:         Cleaner reporting to the log, and it just reports the lesser info, no seconds and so on.
Time.ComplexHoursReport = function(hours)
    local result = ""

    if hours ~= nil then

        -- Convert total time to Epoch stamp to make life easier...
        local timeTable = date("*t", time() - (hours * 3600));
        timeTable.day, timeTable.month, timeTable.year, timeTable.hour = Time.ConvertTimetableToServer(timeTable);
        local currentMonth, currentDay, year, currentHour;
        currentMonth, currentDay, year, currentHour = select(2, Time.GetTodaysDate());
        local currentYear = year;
        local years, months, days, hrs = 0, 0, 0, 0;

        local hoursInYear = 8760;

        --- YEARS CALCULATION EXACT ---
        -- Let's get the exact number of years.
        while (hours / 8760) > 0 do

            -- Reset hours each loop to default;
            hoursInYear = 8760;

            -- hours in a year is 8760 or 8784 if leap year.
            if (currentMonth > 2 or (currentMonth == 2 and currentDay == 29)) then
                if Time.IsLeapYear(year) then
                    hoursInYear = 8784;
                end
            elseif currentMonth <= 2 and Time.IsLeapYear(year - 1) then
                hoursInYear = 8784;
            end

            if hours < hoursInYear then
                -- This indicates that player is at 8760+ but <= 8784
                -- 365 days on a 366 day leap year... ALMOST a year, not quite.
                break
            else
                hours = hours - hoursInYear;
                years = years + 1;
                year = year - 1;
            end

        end

        --- MONTHS CALCULATION EXACT ---
        -- No need to calculate the number of months if it is the same year and same month, we know it is less than
        -- it could be same month but different years and be 11 months X days though.
        if currentYear == timeTable.year and currentMonth == timeTable.month then
            months = 0;
        else
            -- Determine Months
            if currentMonth > timeTable.month then
                -- Ok, we don't have to cross years, this makes it easier.
                months = currentMonth - timeTable.month;
                if currentDay < timeTable.day then
                    months = months - 1;
                elseif currentDay == timeTable.day then
                    -- We need to compare the hour now.
                    if currentHour < timeTable.hour then
                        months = months - 1;
                    end
                end

            elseif currentMonth < timeTable.month then
                months = (currentMonth + 12) - timeTable.month;
                if currentDay < timeTable.day then
                    months = months - 1;
                elseif currentDay == timeTable.day then
                    -- We need to compare the hour now.
                    if currentHour < timeTable.hour then
                        months = months - 1;
                    end
                end

            elseif currentMonth == timeTable.month then

                -- same month means we either just hit a new year so it's zero, or we are at 11 months approaching 0
                if currentDay <= timeTable.day then
                    if currentDay < timeTable.day then
                        months = 11;

                    elseif currentDay == timeTable.day then
                        -- we need to check the hour now.
                        if currentHour <= timeTable.hour then
                            if currentHour < timeTable.hour then
                                months = 11;
                            end
                        end
                    end
                end
            end
        end

        --- DAYS CALCULATION EXACT ---
        if currentYear == timeTable.year and currentMonth == timeTable.month and currentDay == timeTable.day then
            days = 0;

        else
            if currentDay > timeTable.day then
                days = currentDay - timeTable.day;
                if currentHour < timeTable.hour then
                    days = days - 1;
                end

            elseif currentDay < timeTable.day then
                local leapYearModifier = 0;

                -- this year should reflect the timestamp of former year now, not current.
                if timeTable.month == 2 and Time.IsLeapYear(year) then
                    leapYearModifier = 1;
                end

                days = (currentDay + Time.Enums.days_in_month[timeTable.month] + leapYearModifier) - timeTable.day;

                -- now we need to compare hours.
                if currentHour < timeTable.hour then
                    days = days - 1;
                end

            elseif currentDay == timeTable.day then
                -- It could either be ZERO or it could be max days that month - 1.
                if currentHour < timeTable.hour then

                    local leapYearModifier = 0;

                    -- this year should reflect the timestamp of former year now, not current.
                    if timeTable.month == 2 and Time.IsLeapYear(year) then
                        leapYearModifier = 1;
                    end

                    days = Time.Enums.days_in_month[timeTable.month] + leapYearModifier - 1;
                else
                    days = 0;
                end

            end
        end

        --- HRS CALCULATION EXACT ---
        if currentYear == timeTable.year and currentMonth == timeTable.month and currentDay == timeTable.day and
            currentHour == timeTable.hour then
            hrs = 0;

        else
            if currentHour > timeTable.hour then
                hrs = currentHour - timeTable.hour;

            elseif currentHour < timeTable.hour then
                hrs = (currentHour + 24) - timeTable.hour;

            elseif currentHour == timeTable.hour then
                hrs = 0;
            end

        end

        if years >= 1 then
            if years > 1 then
                result = result .. "" .. GRM.L("{num} yrs", nil, nil, years) .. " ";
            else
                result = result .. "" .. GRM.L("{num} yr", nil, nil, years) .. " ";
            end
        end

        if months >= 1 then
            if years > 0 then
                result = GRM.Trim(result) .. ", ";
            end
            if months > 1 then
                result = result .. "" .. GRM.L("{num} mos", nil, nil, months) .. " ";
            else
                result = result .. "" .. GRM.L("{num} mo", nil, nil, months) .. " ";
            end
        end

        if days >= 1 then
            if months > 0 or ( years > 0 and not (months > 0) ) then
                result = GRM.Trim(result) .. ", ";
            end
            if days > 1 then
                result = result .. "" .. GRM.L("{num} days", nil, nil, days) .. " ";
            else
                result = result .. "" .. GRM.L("{num} day", nil, nil, days) .. " ";
            end
        end

        if hrs >= 1 and years < 1 and months < 1 then -- No need to give exact hours on anything over than a month, just the day is good enough.
            if days > 0 then
                result = GRM.Trim(result) .. ", ";
            end
            if hrs > 1 then
                result = result .. "" .. GRM.L("{num} hrs", nil, nil, hrs) .. " ";
            else
                result = result .. "" .. GRM.L("{num} hr", nil, nil, hrs) .. " ";
            end
        end
    end

    if result == "" or result == nil then
        result = GRM.L("< 1 hour");
    end
    return GRM.Trim(result);
end

-- Method:          Time.HoursReport( table )
-- What it Does:    Reports as a string the time passed since player last logged on.
-- Purpose:         Convert the information provide by the communities API to turn into useful info for player
Time.HoursReport = function( lastOnlineTime )
    local result = "";
    -- lastOnlineTime = { y , m , d , h };

    if lastOnlineTime[2] == 12 then
        lastOnlineTime[1] = lastOnlineTime[1] + 1;
        lastOnlineTime[2] = 0;
    end

    if lastOnlineTime[1] >= 1 then
        if lastOnlineTime[1] > 1 then
            result = result .. "" .. GRM.L("{num} yrs", nil, nil, lastOnlineTime[1]) .. " ";
        else
            result = result .. "" .. GRM.L("{num} yr", nil, nil, lastOnlineTime[1]) .. " ";
        end
    end

    if lastOnlineTime[2] >= 1 then
        if lastOnlineTime[1] > 0 then
            result = GRM.Trim(result) .. ", ";
        end
        if lastOnlineTime[2] > 1 then
            result = result .. "" .. GRM.L("{num} mos", nil, nil, lastOnlineTime[2]) .. " ";
        else
            result = result .. "" .. GRM.L("{num} mo", nil, nil, lastOnlineTime[2]) .. " ";
        end
    end

    if lastOnlineTime[3] >= 1 then
        if lastOnlineTime[2] > 0 or ( lastOnlineTime[1] > 0 and not ( lastOnlineTime[2] > 0 ) ) then
            result = GRM.Trim(result) .. ", ";
        end
        if lastOnlineTime[3] > 1 then
            result = result .. "" .. GRM.L("{num} days", nil, nil, lastOnlineTime[3]) .. " ";
        else
            result = result .. "" .. GRM.L("{num} day", nil, nil, lastOnlineTime[3]) .. " ";
        end
    end

    if lastOnlineTime[4] >= 1 and lastOnlineTime[1] < 1 and lastOnlineTime[2] < 1 then -- No need to give exact hours on anything over than a month, just the day is good enough.
        if lastOnlineTime[3] > 0 then
            result = GRM.Trim(result) .. ", ";
        end
        if lastOnlineTime[4] > 1 then
            result = result .. "" .. GRM.L("{num} hrs", nil, nil, lastOnlineTime[4]) .. " ";
        else
            result = result .. "" .. GRM.L("{num} hr", nil, nil, lastOnlineTime[4]) .. " ";
        end
    end

    if result == "" or result == nil then
        result = GRM.L("< 1 hour");
    end

    return result;
end

-- Method:          Time.GetNumHoursTilRecommend( int , int )
-- What it Does:    Returns the number of hours need to match the given numMonths time passed
-- Purpose:         Useful for checking if the player has been, for example, offline X number of months, if the time has passed, since the server gives time in hours since last online.
Time.GetNumHoursTilRecommend = function(numMonths, specialYear)
    local month, day, year = select(2, Time.GetTodaysDate());

    if numMonths == 0 then
        return 0;
    end

    if specialYear then
        year = specialYear;
    end

    -- Error protection
    if month == 0 or day == 0 then
        return nil;
    end
    local totalDays = 0;
    local numYears = math.floor(numMonths / 12);
    numMonths = numMonths % 12;
    local monthReference = month - numMonths;

    -- ok let's calculate the month index
    if monthReference < 1 then
        monthReference = 12 + month - numMonths;
    end

    -- Add up the total days...
    if numMonths > 0 then
        totalDays = day; -- This sets the initial number, which is this month.
        if numMonths >= month then
            totalDays = totalDays + Time.Enums.days_before_month[month]; -- Counts all the days of this year
            totalDays = totalDays + (365 - Time.Enums.days_before_month[monthReference]) - day; -- Counts all of the days from the reference month X months ago til end of the year

            -- Check Leap Year
            if (month > 2 or (month == 2 and day == 29)) and Time.IsLeapYear(year) and numYears == 0 then -- Adding 1 for the leap year   -- If the year > 1 then the end of this function will tally it auto for each year, if not it is calculated here.
                totalDays = totalDays + 1;
            end

        else -- Ex: if today is May, 11 months ago, reference month is June last year
            totalDays = totalDays +
                            (Time.Enums.days_before_month[month] - Time.Enums.days_before_month[monthReference]) - day;
            if monthReference <= 2 and (month > 2 or (month == 2 and day == 29)) and Time.IsLeapYear(year) and numYears ==
                0 then
                totalDays = totalDays + 1;
            end
        end
    end
    for i = 0, numYears - 1 do
        if Time.IsLeapYear(year - i) then
            totalDays = totalDays + 1;
        end
    end
    return (totalDays + (365 * numYears)) * 24
end

-- Method:          Time.GetTimestampBasedOnTimePassed ( array )
-- What it Does:    Returns an array that contains a string timestamp of the date based on the timepassed, as well as the epochstamp corresponding to that date
-- Purpose:         Incredibly necessary for join date and promo date tagging with proper dates for display and for sync.
Time.GetTimestampBasedOnTimePassed = function(dateInfo)
    local stampDay = dateInfo[1];
    local stampMonth = dateInfo[2];
    local stampYear = dateInfo[3];
    local stampHour = dateInfo[4];
    local month, day, year, hour, minutes;

    month, day, year, hour, minutes = select(2, Time.GetTodaysDate());

    if not hour then
        hour, minutes = GetGameTime();
    end
    local LeapYear = Time.IsLeapYear(year);
    local time = ""; -- Generic stamp placeholder
    if not GRM.S().twentyFourHrScale then
        time = "12:01am";
    else
        time = "00:01" .. GRM.L("24HR_Notation");
    end
    -- Adjust the year back for how many years passed
    year = year - stampYear;

    -- The month now... Must be a number for 1-12 for corresponding month index
    if month - stampMonth > 0 then
        month = month - stampMonth;
    else
        month = 12 - (stampMonth - month);
        year = year - 1;
    end

    -- Day
    if day - stampDay > 0 then
        day = day - stampDay;
    else
        local daysInSelectedMonth = Time.Enums.days_in_month[month];
        if LeapYear and month == 2 then
            daysInSelectedMonth = daysInSelectedMonth + 1;
        end
        day = daysInSelectedMonth - (stampDay - day);
        month = month - 1;
        if month == 0 then
            month = 12;
            year = year - 1;
        end
    end

    -- Hour
    if hour - stampHour > 0 then
        hour = hour - stampHour;
    else
        hour = 24 - (stampHour - hour);
        day = day - 1;
        if day == 0 then
            -- First, need to determine month now.
            month = month - 1;
            if month == 0 then
                month = 12;
                year = year - 1;
            end
            local dim = Time.Enums.days_in_month[month]; -- Days In Month = dim
            if LeapYear and month == 2 then
                dim = dim + 1;
            end
            day = dim - (stampDay - day);
        end
    end

    -- We know that it is within hours now.
    if (stampYear == 0 and stampMonth == 0 and stampDay == 0) then
        -- It's the same day! Use current timestamp!!!!

        time = Time.GetFormatTime(hour, minutes);
    end
    local timestamp = Time.FormatTimeStamp ( {day, month, year} , false , false );
    local arrayFormat = {day, month, year, hour, minutes};
    return {timestamp .. " " .. time, Time.ConvertToStandardFormatDate(day, month, year), arrayFormat};
end

-- Method:          Time.GetCleanTimestamp ( string )
-- What it Does:    Returns the timestamp formatted properly
-- Purpose:         Clean the timestamp for proper parsing and formatting.
Time.GetCleanTimestamp = function(timestamp)
    return string.match(timestamp, "%d.+'%d%d");
end


-- Method:          Time.FormatTimeStamp( string or table , bool , bool , int ) -- last 3 arguments are optional
-- What it Does:    Returns the timestamp in a format designated by the player
-- purpose:         Give player proper timestamp format options.
Time.FormatTimeStamp = function(timestamp, includeHour, removeYear, forcedForm)

    local day = 0;
    local monthNum = 0;
    local year = 0;
    local typeForm = forcedForm or GRM.S().dateFormat;
    local month = ""
    local typeStamp = 0; -- 1 = string, 2 = table, 3 = epochNum

    if type(timestamp) == "string" then
        typeStamp = 1;
        timestamp = Time.GetCleanTimestamp(timestamp); -- ensure proper formatting
        -- Default format = 12 Mar '18

        day = string.match(timestamp, "%d+");
        if #day == 1 then
            day = "0" .. day;
        end
        month = GRM.GetEventMonth(timestamp);
        monthNum = tostring(Time.Enums.abbrev_month_ind[month]);
        if #monthNum == 1 then
            monthNum = "0" .. monthNum;
        end
        year = string.sub(string.match(timestamp, "'%d%d"), 2);

    elseif type(timestamp) == "table" then
        typeStamp = 2;

        day = timestamp[1];
        monthNum = tostring(timestamp[2]);
        if timestamp[3] then
            year = timestamp[3];

            if year > 2000 then
                year = year - 2000;
            end
            if not removeYear and year < 10 then
                year = "0" .. tostring(year);
            end

        else
            removeYear = true;
        end

        if day < 10 then
            day = "0" .. tostring(day);
        end

        month = tostring(Time.Enums.ind_to_month_abbrev[tonumber(monthNum)]);

        if #monthNum == 1 then
            monthNum = "0" .. monthNum;
        end
    end
    local result = "";

    if typeForm == 1 then -- 12 Mar '18
        if removeYear then
            result = day .. " " .. GRM.L(month);
        else
            result = day .. " " .. GRM.L(month) .. " '" .. year;
        end
    elseif typeForm == 2 then -- 12 Mar 18
        if removeYear then
            result = day .. " " .. GRM.L(month);
        else
            result = day .. " " .. GRM.L(month) .. " " .. year;
        end
    elseif typeForm == 3 then -- 12-Mar-2018
        if removeYear then
            result = day .. "-" .. GRM.L(month);
        else
            result = day .. "-" .. GRM.L(month) .. "-20" .. year;
        end
    elseif typeForm == 4 then -- 03-12-18
        if removeYear then
            result = day .. "-" .. monthNum
        else
            result = day .. "-" .. monthNum .. "-" .. year;
        end
    elseif typeForm == 5 then -- 03/12/18
        if removeYear then
            result = day .. "/" .. monthNum;
        else
            result = day .. "/" .. monthNum .. "/" .. year;
        end
    elseif typeForm == 6 then -- 03.12.18
        if removeYear then
            result = day .. "." .. monthNum;
        else
            result = day .. "." .. monthNum .. "." .. year;
        end
    elseif typeForm == 7 then -- 03.12.2018
        if removeYear then
            result = day .. "." .. monthNum;
        else
            result = day .. "." .. monthNum .. ".20" .. year;
        end
    elseif typeForm == 8 then -- Mar 12 '18
        if removeYear then
            result = GRM.L(month) .. " " .. day;
        else
            result = GRM.L(month) .. " " .. day .. " '" .. year;
        end
    elseif typeForm == 9 then -- Mar 12 18
        if removeYear then
            result = GRM.L(month) .. " " .. day;
        else
            result = GRM.L(month) .. " " .. day .. " " .. year;
        end
    elseif typeForm == 10 then -- Mar-12-2018
        if removeYear then
            result = GRM.L(month) .. "-" .. day;
        else
            result = GRM.L(month) .. "-" .. day .. "-20" .. year;
        end
    elseif typeForm == 11 then -- 12-03-18
        if removeYear then
            result = monthNum .. "-" .. day;
        else
            result = monthNum .. "-" .. day .. "-" .. year;
        end
    elseif typeForm == 12 then -- 12/03/18
        if removeYear then
            result = monthNum .. "/" .. day;
        else
            result = monthNum .. "/" .. day .. "/" .. year;
        end
    elseif typeForm == 13 then -- 12.3.18
        if removeYear then
            result = monthNum .. "." .. day;
        else
            result = monthNum .. "." .. day .. "." .. year;
        end
    elseif typeForm == 14 then -- 12.3.2018
        if removeYear then
            result = monthNum .. "." .. day;
        else
            result = monthNum .. "." .. day .. ".20" .. year;
        end
    elseif typeForm == 15 then -- 2018-03-12
        if removeYear then
            result = monthNum .. "-" .. day;
        else
            result = "20" .. year .. "-" .. monthNum .. "-" .. day;
        end
    elseif typeForm == 16 then -- 2018-03-12
        if removeYear then
            result = day .. "-" .. monthNum;
        else
            result = day .. "-" .. monthNum .. "-" .. "20" .. year;
        end
    elseif typeForm == 17 then
        if removeYear then
            result = monthNum .. "." .. day;
        else
            result = "20" .. year .. "." .. monthNum .. "." .. day;
        end
    end

    if includeHour then
        if typeStamp == 1 then
            result = result .. " " .. string.sub(timestamp, string.find(timestamp, "'") + 4);
        elseif typeStamp == 2 then
            if timestamp[4] ~= nil and timestamp[5] ~= nil then
                result = result .. " " .. Time.GetFormatTime(timestamp[4], timestamp[5]);
            end
        end
    end
    return result;
end

-- Method:          Time.GetFormatTime ( string , string )
-- What it Does:    Returns the time of day in the proper 24hr or 12hr format
-- Purpose:         To give players the option for time display formatting, but also to ensure 24hr/12hr standards are there as typically in the EU people often use the 24hr clock, whilst in the US it is the 12hr clock.
Time.GetFormatTime = function(hour, min)
    local morning = true;
    local amOrpm = GRM.L("pm");
    local result = "";

    if hour ~= nil and min ~= nil then
        -- Swap from military time if set to 12hr
        if (GRM.S() ~= nil and not GRM.S().twentyFourHrScale) then
            if hour > 12 then
                hour = hour - 12;
                morning = false;
            elseif hour == 12 then
                morning = false;
            elseif hour == 0 then
                hour = 12;
            end

            if morning then
                amOrpm = GRM.L("am");
            end
        else
            amOrpm = GRM.L("24HR_Notation");
        end

        -- Formatting...
        if min < 10 then
            min = ("0" .. min); -- Example, if it was 6:09, the minutes would only be "9" not "09" - so this looks better.
        end
        if hour < 10 then
            hour = ("0" .. hour);
        end

        result = hour .. GRM.L("HourBreak") .. min .. amOrpm;
    end

    return result;
end

-- Method:          Time.GetTimestampOfLastRankChange ( playerObject )
-- What it Does:    Returns the string timestamp based on the array values of the table
-- Purpose:         Quick conversion of time format.
Time.GetTimestampOfLastRankChange = function(player)
    local result = "";

    if player and #player.rankHist[1][5] > 1 then
        result = Time.FormatTimeStamp({player.rankHist[1][2], player.rankHist[1][3], player.rankHist[1][4]}, false, false);
    end

    return result;
end

-- Method:          Time.IsValidSubmitDate ( int , int , boolean )
-- What it Does:    Returns true if the submission date is valid (not an untrue day or in the future)
-- Purpose:         Check to ensure the wrong date is not submitted on accident.
Time.IsValidSubmitDate = function(daySelected, monthSelected, yearSelected, IsLeapYearSelected)
    local closeButtons = true;
    local month, day, year = select(2, Time.GetTodaysDate());
    local numDays;
    IsLeapYearSelected = IsLeapYearSelected or Time.IsLeapYear(yearSelected);

    if monthSelected > 12 then
        GRM.Report(GRM.L("Please choose a valid Month"));
        return false;
    end

    if yearSelected < 2004 then
        GRM.Report(GRM.L("Warcraft was not released until 2004. Please choose a valid year."));
        return false;
    end

    if monthSelected == 1 or monthSelected == 3 or monthSelected == 5 or monthSelected == 7 or monthSelected == 8 or
        monthSelected == 10 or monthSelected == 12 then
        numDays = 31;
    elseif monthSelected == 2 and IsLeapYearSelected then
        numDays = 29;
    elseif monthSelected == 2 then
        numDays = 28;
    else
        numDays = 30;
    end
    if daySelected > numDays then
        closeButtons = false;
    end

    if closeButtons then
        if (year < yearSelected) or (year == yearSelected and month < monthSelected) or
            (year == yearSelected and month == monthSelected and day < daySelected) then
            GRM.Report(GRM.L("Player Does Not Have a Time Machine!"));
            closeButtons = false;
        end
    end

    if closeButtons == false then
        GRM.Report(GRM.L("Please choose a valid DAY"));
    end

    return closeButtons;
end

-- Method:          Time.GetLogFormattedTimestamp ( list , string )
-- What it Does:    Attaches the timestamp properly to the log string at start and in converted format
-- Purpose:         Reusable function for cleaner code for repeat reporting.
Time.GetLogFormattedTimestamp = function(date, result)
    if date[4] ~= nil and date[5] ~= nil then
        result = Time.FormatTimeStamp(date, true) .. " : " .. result;
    end

    return result;
end

------------------------------------
------ END OF TIME METHODS ---------
------------------------------------

-- On Load or save for after loading in?
Configure_Time_Enums();