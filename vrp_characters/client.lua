vRPCchars = {}
Tunnel.bindInterface("vRP_characters",vRPCchars)
Proxy.addInterface("vRP_characters",vRPCchars)
vRPSchars = Tunnel.getInterface("vRP_characters","vRP_characters")
vRP = Proxy.getInterface("vRP")

creationPos = {272.01669311524, -279.63037109375, 53.93998336792}
cPos = {272.66598510742, -278.20822143554, 53.939987182618}

characters = 0
charSlots = 0
playingWith = ""

charsPos = {
	[1] = {281.8883972168, -284.86364746094, 53.939346313476, -20.0, false, false, false, false, false},
	[2] = {283.73477172852, -285.40390014648, 53.941501617432, -20.0, false, false, false, false, false},
	[3] = {285.26272583008, -283.34335327148, 53.942687988282, 70.0, false, false, false, false, false}
}

RegisterNetEvent("dgRP:characterSpawned")
AddEventHandler("dgRP:characterSpawned", function(user_id, charID, first_spawn)
	local weapons = vRP.getWeapons({})
	vRP.giveWeapons({weapons,true})
	SetEntityCollision(GetPlayerPed(-1), true, true)
end)

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

function char_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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

function vRPCchars.populateCharsVars(slots, charPos)
	charSlots = slots
	charsPos = charPos
end

function vRPCchars.createNewCharacter(name, age, facName, facRank, skin)
	if(characters < charSlots)then
		characters = characters+1
		if(charsPos[characters][5] == false)then
			charsPos[characters][5] = name
			charsPos[characters][6] = skin
			charsPos[characters][7] = age
			charsPos[characters][8] = facName
			charsPos[characters][9] = facRank
			Citizen.CreateThread(function()
				creation = 1885233650
				RequestModel( creation )
				while ( not HasModelLoaded( creation ) ) do
					Citizen.Wait( 1 )
				end
				x, y, z = charsPos[characters][1], charsPos[characters][2], charsPos[characters][3]
				character = CreatePed(4, creation, x, y, z, 90, false, false)
				vRPCchars.setCharCustomization(json.decode(skin), character)
				SetModelAsNoLongerNeeded(creation)
				SetEntityHeading(character, charsPos[characters][4])
				FreezeEntityPosition(character, true)
				SetEntityInvincible(character, true)
				SetBlockingOfNonTemporaryEvents(character, true)
				TaskStartScenarioAtPosition(character, "PROP_HUMAN_SEAT_BENCH", x, y, z-0.5, GetEntityHeading(character), 0, 0, false)
			end)
		end
	end
end

function vRPCchars.setCharRotation(rot)
	SetEntityHeading(GetPlayerPed(-1), rot)
end

function vRPCchars.getCharacterPos()
	coords = GetEntityCoords(GetPlayerPed(-1))
	rot = GetEntityHeading(GetPlayerPed(-1))
	return coords.x, coords.y, coords.z, rot
end

function vRPCchars.spawnCharacters(chars)
	characters = #chars
	crs = characters
	for i, v in pairs(charsPos) do
		if(v[5] == false)then
			if(crs ~= 0)then
				v[5] = chars[crs].charName
				v[6] = chars[crs].skin
				v[7] = chars[crs].charAge
				v[8] = chars[crs].facName
				v[9] = chars[crs].facRank
				crs = crs - 1
			else
				break
			end
		end
	end
	Citizen.CreateThread(function()
		for i, v in pairs(charsPos) do
			if(v[5] ~= false)then
				x, y, z = v[1], v[2], v[3]
				rot = v[4]
				creation = 1885233650
				RequestModel( creation )
				while ( not HasModelLoaded( creation ) ) do
					Citizen.Wait( 1 )
				end
				x, y, z = v[1], v[2], v[3]
				character = CreatePed(4, creation, x, y, z, 90, false, false)
				vRPCchars.setCharCustomization(json.decode(v[6]), character)
				SetModelAsNoLongerNeeded(creation)
				SetEntityHeading(character, v[4])
				FreezeEntityPosition(character, true)
				SetEntityInvincible(character, true)
				SetBlockingOfNonTemporaryEvents(character, true)
				TaskStartScenarioAtPosition(character, "PROP_HUMAN_SEAT_BENCH", x, y, z-0.5, GetEntityHeading(character), 0, 0, false)
			end
		end
	end)
end

Citizen.CreateThread(function()
	creation = 549978415
	RequestModel( creation )
	while ( not HasModelLoaded( creation ) ) do
		Citizen.Wait( 1 )
	end
	charCreation = CreatePed(4, creation, creationPos[1], creationPos[2], creationPos[3], 90, false, false)
	SetModelAsNoLongerNeeded(creation)
	SetEntityHeading(charCreation, -20.0)
	FreezeEntityPosition(charCreation, true)
	SetEntityInvincible(charCreation, true)
	SetBlockingOfNonTemporaryEvents(charCreation, true)
	TaskStartScenarioAtPosition(charCreation, "PROP_HUMAN_SEAT_BENCH", creationPos[1], creationPos[2], creationPos[3]-0.35, GetEntityHeading(charCreation), 0, 0, false)
end)

incircle = false
inCreation = false
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, cPos[1], cPos[2], cPos[3]) > 20)then
			if(playingWith == "")then
				SetEntityCoords(GetPlayerPed(-1), cPos[1], cPos[2], cPos[3])
				SetEntityHeading(GetPlayerPed(-1), 157.35888671875)
			end
		end
		
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, creationPos[1], creationPos[2], creationPos[3]) < 5.5)then
			DrawText3D(creationPos[1], creationPos[2], creationPos[3]+0.8, "~g~Character Creation", 1.2, 2)
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, creationPos[1], creationPos[2], creationPos[3]) < 2.5)then
				incircle = true
				if(incircle == true) then
					if(characters >= charSlots)then
						char_drawTxt("~r~You already have the maximum of ~y~"..charSlots.." ~r~characters",1,1,0.5,0.8,0.8,255,255,255,255)
					else
						if(inCreation == false)then
							char_drawTxt("~g~Press ~r~[E] ~g~to create a character",1,1,0.5,0.8,0.8,255,255,255,255)
							if(IsControlJustReleased(1, 51))then
								vRPSchars.showCharCreation({})
								inCreation = true
							end
						end
					end
				end
			elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, creationPos[1], creationPos[2], creationPos[3]) > 2.5)then
				incircle = false
				inCreation = false
			end
		end
		for i, v in pairs(charsPos) do
			x, y, z = v[1], v[2], v[3]
			if(v[5] ~= false)then
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 10.0)then
					DrawText3D(x, y, z+0.95, "~b~"..v[5], 1.2, 4)
					DrawText3D(x, y, z+0.83, "~y~"..v[7].." Years Old", 0.85, 1)
					DrawText3D(x, y, z+0.76, "~g~"..v[8].." ~w~| ~g~"..v[9], 1, 1)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 1.0)then
						incircle = true
						if(incircle == true) then
							if(playingWith ~= v[5])then
								char_drawTxt("~g~Press ~r~[E] ~g~ to play as ~b~"..v[5],1,1,0.5,0.8,0.8,255,255,255,255)
								if(IsControlJustReleased(1, 51))then
									vRPSchars.playWithCharacter({v[5]})
									SetEntityCollision(GetPlayerPed(-1), false, true)
									playingWith = v[5]
								end
							else
								char_drawTxt("~r~You're already playing as: ~b~"..v[5],1,1,0.5,0.8,0.8,255,255,255,255)
							end
						end
					elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) > 1.0)then
						incircle = false
					end
				end
			end
		end
	end
end)

local function parse_part(key)
	if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

function vRPCchars.getCharCustomization()
	local ped = GetPlayerPed(-1)
	local custom = {}

	custom.modelhash = GetEntityModel(ped)
	for i=0,20 do
		custom[i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
	end

	for i=0,10 do
		custom["p"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
	end
	return custom
end

function vRPCchars.setCharCustomization(custom, character)
	local exit = TUNNEL_DELAYED()

	Citizen.CreateThread(function()
		if custom then
			if(character)then
				ped = character
			else
				ped = GetPlayerPed(-1)
			end
			local mhash = nil

			if custom.modelhash ~= nil then
				mhash = custom.modelhash
			elseif custom.model ~= nil then
				mhash = GetHashKey(custom.model)
			end

			if mhash ~= nil then
				local i = 0
				while not HasModelLoaded(mhash) and i < 10000 do
					RequestModel(mhash)
					Citizen.Wait(10)
				end

				if HasModelLoaded(mhash) then
					SetPlayerModel(PlayerId(), mhash)
					SetModelAsNoLongerNeeded(mhash)
				end
			end
			for k,v in pairs(custom) do
				if k ~= "model" and k ~= "modelhash" then
					local isprop, index = parse_part(k)
					if isprop then
						if v[1] < 0 then
							ClearPedProp(ped,index)
						else
							SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
						end
					else
						SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
					end
				end
			end
		end
		exit({})
	end)
end