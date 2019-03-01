--[[
========================================================
============ PROJECT: vRP InfoPickups===================
=============== SCRIPTER: DGVaniX ======================
=============== DATE: 13/02/2018 =======================
========================================================
]]

vRPinfopC = {}
Tunnel.bindInterface("vRP_infoPickups",vRPinfopC)
Proxy.addInterface("vRP_infoPickups",vRPinfopC)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vRP_infoPickups")
vRPipS = Tunnel.getInterface("vRP_infoPickups","vRP_infoPickups")

thePickups = nil
theVehicles = 0
registeredMembers = 0
incircle = false
incircle2 = false

function vRPinfopC.setClientPickupData(coordsTable, users, vehicles, factions)
	thePickups = coordsTable
	registeredMembers = users
	theVehicles = vehicles
end

function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end

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
		dayOfWeek = "Thurstday"
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
		month = "Jully"
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


function infoPickup_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function infoPickup_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3600000)
		vRPipS.getAllUsers({})
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if(thePickups ~= nil)then			
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			for i, v in pairs(thePickups) do
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[2], v[3], v[4]) < 20.0)then
					if(i == 1)then
						rgb2 = RGBRainbow(1.3)
						DrawText3D(v[2], v[3], v[4]+0.3, "~g~"..v[1]..": ~r~"..registeredMembers, 1.4, 1)
						DrawMarker(32, v[2], v[3], v[4]-0.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, rgb2.r, rgb2.g, rgb2.b, 255, true, 0, 0, true)
					elseif(i == 2)then
						rgb3 = RGBRainbow(1.7)
						DrawText3D(v[2], v[3], v[4]+0.3, "~g~"..v[1]..": ~r~"..GetNumberOfPlayers(), 1.4, 1)
						DrawMarker(32, v[2], v[3], v[4]-0.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, rgb3.r, rgb3.g, rgb3.b, 255, true, 0, 0, true)
					elseif(i == 3)then
						rgb4 = RGBRainbow(2)
						DrawText3D(v[2], v[3], v[4]+0.3, v[1], 2, 1)
						DrawMarker(2, v[2], v[3], v[4]-0.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, rgb4.r, rgb4.g, rgb4.b, 255, true, true, 0, 0)
					elseif(i == 4)then
						rgb5 = RGBRainbow(0.8)
						year, month, dayOfWeek, hour, minute = GetLocalTime()
						timeAndDateString = ""
						CalculateTimeToDisplay()
						timeAndDateString = timeAndDateString .. " ~g~" .. hour .. ":" .. minute .. " ~w~|"
						CalculateDateToDisplay()
						timeAndDateString = timeAndDateString .. " ~r~" .. dayOfWeek .. " ~y~" .. month .. " ~b~" .. year
						DrawText3D(v[2], v[3], v[4]+0.3, "~y~"..timeAndDateString, 1.3, 1)
						DrawMarker(32, v[2], v[3], v[4]-0.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, rgb5.r, rgb5.g, rgb5.b, 255, true, 0, 0, true)
					elseif(i == 5)then
						rgb1 = RGBRainbow(1.5)
						DrawText3D(v[2], v[3], v[4]+0.4, "~g~"..v[1], 2.0, 1)
						DrawText3D(v[2], v[3], v[4]+0.2, "~y~Cars: ~r~"..theVehicles, 1.2, 1)
						DrawMarker(32, v[2], v[3], v[4]-0.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, rgb1.r, rgb1.g, rgb1.b, 255, true, 0, 0, true)
						if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[2], v[3], v[4]) < 0.8)then
							incircle2 = true
							if (incircle2 == true) then
								infoPickup_DisplayHelpText("Press ~INPUT_CONTEXT~ to see the ~g~"..v[1])
							end
							if(IsControlJustReleased(1, 51))then
								TriggerServerEvent('showVehiclesList')
							end
						elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[2], v[3], v[4]) > 0.8)then
							incircle2 = false
						end
					else
						rgb5 = RGBRainbow(2.1)
						DrawText3D(v[2], v[3], v[4]+0.3, "~g~"..v[1], 2.0, 1)
						DrawMarker(32, v[2], v[3], v[4]-0.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, rgb.r, rgb.g, rgb.b, 255, true, 0, 0, true)
					end
				end
			end
		end
	end
end)