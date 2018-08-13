local robbing = false
local isDone = true
local bank = ""
local new_blip = nil
local theBlip = nil
local secondsRemaining = 0
local robbers = {}

function bank_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

banks = {
	["fleeca"] = {
		position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
		nameofbank = "Fleeca Bank",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca2"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
		nameofbank = "Fleeca Bank (Highway)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		nameofbank = "Blaine County Savings",
		lastrobbed = 0,
		from = 13,
		to = 15
	},
	["fleeca3"] = {
		position = { ['x'] = -1211.6306152344, ['y'] = -335.71124267578, ['z'] = 37.7 },
		nameofbank = "Fleeca Bank (Vinewood Hills)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca4"] = {
		position = { ['x'] = -354.452575683594, ['y'] = -53.8204879760742, ['z'] = 48.5463104248047 },
		nameofbank = "Fleeca Bank (Burton)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca5"] = {
		position = { ['x'] = 309.967376708984, ['y'] = -283.033660888672, ['z'] = 53.6745223999023 },
		nameofbank = "Fleeca Bank (Alta)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca6"] = {
		position = { ['x'] = 1176.86865234375, ['y'] = 2711.91357421875, ['z'] = 38.097785949707 },
		nameofbank = "Fleeca Bank (Desert)",
		lastrobbed = 0,
		from = 13,
		to = 15
	},
	["fleeca7"] = {
		position = { ['x'] = -2068.9252929688, ['y'] = -1023.221496582, ['z'] = 11.91005039215 },
		nameofbank = "Yacht Luxury(Beach)",
		lastrobbed = 0,
		from = 16,
		to = 18
	},
	["pacific"] = {
		position = { ['x'] = 255.001098632813, ['y'] = 225.855895996094, ['z'] = 101.005694274902 },
		nameofbank = "Pacific Standard PDB (Downtown Vinewood)",
		lastrobbed = 0,
		from = 1,
		to = 12
	}
}

RegisterNetEvent('es_bank:currentlyrobbing')
AddEventHandler('es_bank:currentlyrobbing', function(robb)
	robbing = true
	isDone = false
	bank = robb
	secondsRemaining = 480
end)

RegisterNetEvent('es_bank:toofarlocal')
AddEventHandler('es_bank:toofarlocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '[ROB]', {255, 0, 0}, "Robbery over, you didn't steal anything.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = true
end)

RegisterNetEvent('es_bank:playerdiedlocal')
AddEventHandler('es_bank:playerdiedlocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '[ROB]', {255, 0, 0}, "Robbery over, you died!.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = true
end)

RegisterNetEvent('playerDropped')
AddEventHandler('playerDropped', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '[ROB]', {255, 0, 0}, "Robbery over, you didn't steal anything.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = true
end)

RegisterNetEvent('es_bank:robberycomplete')
AddEventHandler('es_bank:robberycomplete', function()
	robbing = false
	robbingName = ""
	secondsRemaining = 0
	incircle = false
	isDone = false
end)


RegisterNetEvent('es_bank:stopRobbery')
AddEventHandler('es_bank:stopRobbery', function(user_id)
	robbing = false
	isDone = true
end)

Citizen.CreateThread(function()
	while true do
		if robbing then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 278)
		SetBlipColour(blip, 49)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robbable Bank")
		EndTextCommandSetBlipName(blip)
	end
end)
incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if (robbing == false) and (isDone == true) then
					DrawMarker(29, v.position.x, v.position.y, v.position.z, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, true, true, 0,0)
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2)then
						if (incircle == false) then
							bank_DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.nameofbank .. "~w~, the police will be notified!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('es_bank:rob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2)then
						incircle = false
					end
				end
			end
		end

		if (robbing == true) and (isDone == false) then
		    SetPlayerWantedLevel(PlayerId(), 0, 0)
            SetPlayerWantedLevelNow(PlayerId(), 0)
			
			bank_drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Robbery Time: ~r~" .. secondsRemaining .. "~w~ seconds remaining", 255, 255, 255, 255)
			
			local pos2 = banks[bank].position
			local ped = GetPlayerPed(-1)
			
            if IsEntityDead(ped) then
			TriggerServerEvent('es_bank:playerdied', bank)
			elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 15)then
				TriggerServerEvent('es_bank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)