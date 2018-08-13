local displayTime = true
local displayDate = true

local timeAndDateString = nil

function CalculateDayOfWeekToDisplay()
	if dayOfWeek == 1 then
		dayOfWeek = "Sunday"
	elseif dayOfWeek == 2 then
		dayOfWeek = "Monday"
	elseif dayOfWeek == 3 then
		dayOfWeek = "Tuesday"
	elseif dayOfWeek == 4 then
		dayOfWeek = "Wednesday"
	elseif dayOfWeek == 5 then
		dayOfWeek = "Thursday"
	elseif dayOfWeek == 6 then
		dayOfWeek = "Friday"
	elseif dayOfWeek == 7 then
		dayOfWeek = "Saturday"
	end
end

function CalculateDateToDisplay()
	if month == 1 then
		month = "January"
	elseif month == 2 then
		month = "February"
	elseif month == 3 then
		month = "March"
	elseif month == 4 then
		month = "April"
	elseif month == 5 then
		month = "May"
	elseif month == 6 then
		month = "June"
	elseif month == 7 then
		month = "July"
	elseif month == 8 then
		month = "August"
	elseif month == 9 then
		month = "September"
	elseif month == 10 then
		month = "October"
	elseif month == 11 then
		month = "November"
	elseif month == 12 then
		month = "December"
	end
end

function CalculateTimeToDisplay()
	if hour <= 9 then
		hour = tonumber("0" .. hour)
	end
	if minute <= 9 then
		minute = tonumber("0" .. minute)
	end
end

AddEventHandler("playerSpawned", function()	
	Citizen.CreateThread(function()
		while true do
			Wait(1)
			year, month, dayOfWeek, hour, minute = GetUtcTime()
			timeAndDateString = "|"
			CalculateTimeToDisplay()
			if displayTime == true then
				timeAndDateString = timeAndDateString .. " " .. hour .. ":" .. minute .. " |"
			end
			if displayDate == true then
				CalculateDateToDisplay()
				timeAndDateString = timeAndDateString .. " " .. dayOfWeek .. " " .. month .. " " .. year .. " |"
			end
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.30, 0.30)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextRightJustify(true)
			SetTextWrap(0,0.95)
			SetTextEntry("STRING")
			
			AddTextComponentString(timeAndDateString)
			DrawText(0.5, 0.01)
		end
	end)
end)