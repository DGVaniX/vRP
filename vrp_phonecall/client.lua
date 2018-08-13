DEFAULT_PROXIMITY = 15.0
inCall = false

function drawTxt(x,y,scale,font,text, r,g,b, mode, outline)
	if r == nil then r,g,b = 255,255,255 end
	if mode == 'center' then
		Citizen.InvokeNative(0x4E096588B13FFECA, 0)
	elseif mode == 'right' then
		Citizen.InvokeNative(0x4E096588B13FFECA, 2)
	else
		mode = 0
	end
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, 255)
	if outline == true or outline == nil then
		SetTextDropShadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

RegisterNetEvent("phoneCall")
AddEventHandler("phoneCall", function(id, called, caller)
	id = tonumber(id)
	playerPed = GetPlayerPed(-1)
	coords = GetEntityCoords(playerPed)
	bone = GetPedBoneIndex(playerPed, 28422)
	phoneModel = GetHashKey("prop_npc_phone_02")
	inCall = true
	Citizen.CreateThread(function()
		RequestModel(phoneModel)
		myPhone = CreateObject(phoneModel, coords.x, coords.y, coords.z, true, true, false)
		AttachEntityToEntity(myPhone, playerPed, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end)
	local ms = 0
	local sec = 0
	local min = 0
	Citizen.CreateThread(function()
		local p1 = GetPlayerFromServerId(called)
		local p2 = GetPlayerFromServerId(caller)
		local p2_name = nil
		while true do 
			Wait(1)
			if(inCall == true)then
				if caller ~= nil then
					if p2_name == nil then
						p2_name = GetPlayerName(p2)
					end
					ms = ms + 1
					if ms >= 100 then sec = sec + 1 ms = 0 end
					if sec >= 60 then min = min + 1 sec = 0 end
					--[[if min == 0 and sec < 10 then
						drawTxt(0.5,0.02,0.5, 4,("[~b~%s~w~] Call Duration: ~b~0%d ~w~seconds"):format(p2_name, sec), 255,255,255, 'center', true)
					elseif min ~= 0 then
						if min == 1 then
							drawTxt(0.5,0.02,0.5, 4,("[~b~%s~w~] Call Duration: ~b~%d ~w~minute ~b~%d ~w~seconds"):format(p2_name, min, sec), 255,255,255, 'center', true)
						else
							drawTxt(0.5,0.02,0.5, 4,("[~b~%s~w~] Call Duration: ~b~%d ~w~minutes ~b~%d ~w~seconds"):format(p2_name, min, sec), 255,255,255, 'center', true)
						end
					else
						drawTxt(0.5,0.02,0.5, 4,("[~b~%s~w~] Call Duration: ~b~%d ~w~seconds"):format(p2_name, sec), 255,255,255, 'center', true)
					end]] -- BUGGED
					NetworkSetVoiceChannel(id)
					NetworkSetVoiceActive(true)
					NetworkSetTalkerProximity(1.0)
				else
					return
				end
			end
		end
		return
	end)
end)

RegisterNetEvent("cancelPhoneCall")
AddEventHandler("cancelPhoneCall", function()
	DeleteObject(myPhone)
	inCall = false
	p2_name = nil
	NetworkSetTalkerProximity(DEFAULT_PROXIMITY)
	NetworkClearVoiceChannel()
   	NetworkSetVoiceActive(true)
end)