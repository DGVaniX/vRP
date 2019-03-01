local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_characters")

vRPSchars = {}
Tunnel.bindInterface("vRP_characters",vRPSchars)
Proxy.addInterface("vRP_characters",vRPSchars)
vRPCchars = Tunnel.getInterface("vRP_characters","vRP_characters")

MySQL.createCommand("vRP/create_character", "INSERT INTO vrp_characters(accID, charName, charAge, cDate, lastLogin, facName, facRank, facLeader, skin) VALUE(@accID, @charName, @charAge, NOW(), NOW(), 'user', 'none', '0', @skin)")
MySQL.createCommand("vRP/get_acc_characters", "SELECT * FROM vrp_characters WHERE accID = @accID")
MySQL.createCommand("vRP/get_acc_charSlots", "SELECT * FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/get_acc_byName", "SELECT * FROM vrp_characters WHERE charName = @charName")
MySQL.createCommand("vRP/update_char_lastlogin","UPDATE vrp_characters SET lastLogin = NOW() WHERE id = @charID")
MySQL.createCommand("vRP/update_character","UPDATE vrp_characters SET x = @x, y = @y, z = @z, rot = @rot, health = @health, weapons = @weapons, skin = @skin WHERE id = @charID")

charsPos = {
	[1] = {281.8883972168, -284.86364746094, 53.939346313476, -20.0, false, false, false, false, false},
	[2] = {283.73477172852, -285.40390014648, 53.941501617432, -20.0, false, false, false, false, false},
	[3] = {285.26272583008, -283.34335327148, 53.942687988282, 70.0, false, false, false, false, false}
}

charactersSpawned = {}
skin = {}
skin.default_customization = {
	model = "mp_m_freemode_01" 
}

for i=0,19 do
	skin.default_customization[i] = {0,0}
end

function checkName(theText)
	local foundSpace, valid = false, true
	local spaceBefore = false
	local current = ''
	for i = 1, #theText do
		local char = theText:sub( i, i )
		if char == ' ' then 
			if i == #theText or i == 1 or spaceBefore then 
				valid = false
				break
			end
			current = ''
			spaceBefore = true
		elseif ( char >= 'a' and char <= 'z' ) or ( char >= 'A' and char <= 'Z' ) then 
			current = current .. char
			spaceBefore = false
		else 
			valid = false
			break
		end
	end
	
	if (valid == true)  then
		return true
	else
		return false
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPclient.teleport(source, {272.57647705078,-278.17611694336,53.939987182618})
	vRPCchars.setCharRotation(source, {153.79486083984})
	MySQL.query("vRP/get_acc_charSlots", {user_id = user_id}, function(rows, affected)
		if #rows > 0 then
			maxSlots = rows[1].charSlots
			vRPCchars.populateCharsVars(source, {maxSlots, charsPos})
		end
	end)
	MySQL.query("vRP/get_acc_characters", {accID = user_id}, function(rows, affected)
		if #rows > 0 then
			vRPCchars.spawnCharacters(source, {rows})
		end
	end)
end)

RegisterCommand("spawnchars", function(source)
	user_id = vRP.getUserId({source})
	MySQL.query("vRP/get_acc_characters", {accID = user_id}, function(rows, affected)
		if #rows > 0 then
			vRPCchars.spawnCharacters(source, {rows})
		end
	end)
end)

RegisterServerEvent("spawnCharacter")
AddEventHandler("spawnCharacter", function(user_id, charID, player, first_spawn)
	TriggerEvent("dgRP:characterSpawned",user_id, charID, player, first_spawn)
	charName = vRPSchars.getCharNameById(charID)
	MySQL.query("vRP/get_acc_byName", {charName = charName}, function(rows, affected)
		if #rows > 0 then
			x, y, z = rows[1].x, rows[1].y, rows[1].z
			rotation = rows[1].rot
			skin = rows[1].skin
			health = rows[1].health
			thirst = rows[1].thirst
			hunger = rows[1].hunger
			vRPclient.teleport(player, {x, y, z})
			vRPCchars.setCharCustomization(player,{json.decode(skin), false})
			vRPclient.setHealth(player,{health})
			vRP.setThirst({user_id, thirst})
			vRP.setHunger({user_id, hunger})
			vRPCchars.setCharRotation(player, {rotation})
			vRPclient.notify(player, {"[CARACTER] ~g~You're now playing as: ~b~"..vRPSchars.getCharName(player)})
		end
	end)
	TriggerClientEvent("dgRP:characterSpawned",player, user_id, charID, first_spawn)
end)

function vRPSchars.getCharId(thePlayer)
	user_id = vRP.getUserId({thePlayer})
	charID = charactersSpawned[user_id].id
	return charID
end

function vRPSchars.getCharName(thePlayer)
	user_id = vRP.getUserId({thePlayer})
	theName = charactersSpawned[user_id].charName
	return theName
end

function vRPSchars.getCharNameById(charID)
	theName = ""
	for i, v in pairs(charactersSpawned) do
		if(v.id == charID)then
			theName = v.charName
		end
	end
	return theName
end

function vRPSchars.playWithCharacter(charName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	MySQL.query("vRP/get_acc_byName", {charName = charName}, function(rows, affected)
		if #rows > 0 then
			charID = rows[1].id
			charactersSpawned[user_id] = rows[1]
			MySQL.execute("vRP/update_char_lastlogin", {charID = charID})
			TriggerEvent("spawnCharacter", user_id, charID, thePlayer, true)
		else
			vRPclient.notify(thePlayer, {"[CARACTER] ~r~This character doesn't exist!"})
			return
		end
	end)
end

function titleCase( first, rest )
	return first:upper()..rest:lower()
end

function vRPSchars.showCharCreation()
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	vRP.prompt({thePlayer, "Character Firstname:", "", function(thePlayer, firstName)
		firstName = tostring(firstName)
		if(checkName(firstName)) then
			if string.len(firstName) >= 3 and string.len(firstName) <= 20 then
				vRP.prompt({thePlayer, "Character Surname:", "", function(thePlayer, secondName)
					secondName = tostring(secondName)
					if(checkName(secondName)) then
						if string.len(secondName) >= 3 and string.len(secondName) <= 20 then
							firstName = string.gsub(firstName, "(%a)([%w_']*)", titleCase)
							secondName = string.gsub(secondName, "(%a)([%w_']*)", titleCase)
							name = firstName.." "..secondName
							MySQL.query("vRP/get_acc_byName", {charName = name}, function(rows, affected)
								if #rows > 0 then
									vRPclient.notify(thePlayer, {"[CARACTER] ~r~A character with this name already exists!"})
									return
								else
									vRP.prompt({thePlayer, "Character Age:", "", function(thePlayer, age)
										age = age
										if(tonumber(age)) then
											age = tonumber(age)
											if age >= 16 and age <= 100 then
												MySQL.execute("vRP/create_character", {
													accID = user_id,
													charName = name,
													charAge = age,
													skin = json.encode(skin)
												})
												vRPclient.notify(thePlayer, {"[CARACTER]\n~g~Name: ~y~"..name.."\n~g~Age: ~y~"..age.."\n~b~Was created!"})
												vRPCchars.createNewCharacter(thePlayer, {firstName.." "..secondName, age, 'Somer', 'Somer', json.encode(skin)})
											else
												vRPclient.notify(thePlayer, {"[CARACTER] ~r~Age must be between 16 and 100!"})
											end
										else
											vRPclient.notify(thePlayer, {"[CARACTER] ~r~Age must be a number!"})
										end
									end})
								end
							end)
						else
							vRPclient.notify(thePlayer, {"[CARACTER] ~r~The surname has to be between 3 and 20 character!"})
						end
					else
						vRPclient.notify(thePlayer, {"[CARACTER] ~r~The surname must be only letters!"})
					end

				end})
			else
				vRPclient.notify(thePlayer, {"[CARACTER] ~r~The Firstname has to be between 3 and 20 character!"})
			end
		else
			vRPclient.notify(thePlayer, {"[CARACTER] ~r~The Firstname must be only letters!"})
		end
	end})
end

Citizen.CreateThread(function()
	while true do
		Wait(100000)
		users = vRP.getUsers({})
		for i, v in pairs(charactersSpawned) do
			for k, vl in pairs(users) do
				if(i == k)then
					vRPCchars.getCharacterPos(vl, {}, function(x, y, z, rot)
						x, y, z, rot = x, y, z, rot
						charID = tonumber(v.id)
						vRPclient.notify(vl, {"Character saved!"})
						vRPclient.getHealth(vl, {}, function(health)
							health = tonumber(health)
							vRPclient.getWeapons(vl, {}, function(weaps)
								weaps = json.encode(weaps)
								vRPCchars.getCharCustomization(vl, {}, function(custom)
									custom = json.encode(custom)
									MySQL.execute("vRP/update_character", {charID = charID, x = x, y = y, z = z, rot = rot, health = health, weapons = weaps, skin = custom})
								end)
							end)
						end)
					end)
				end
			end
		end
	end
end)

AddEventHandler('playerDropped', function()
	user_id = vRP.getUserId({source})
	if(charactersSpawned[user_id])then
		vRPCchars.getCharacterPos(source, {}, function(x, y, z, rot)
			x, y, z, rot = x, y, z, rot
			charID = vRPSchars.getCharId(source)
			vRPclient.getHealth(source, {}, function(health)
				health = tonumber(health)
				vRPclient.getWeapons(source, {}, function(weaps)
					weaps = json.encode(weaps)
					vRPCchars.getCharCustomization(source, {}, function(custom)
						custom = json.encode(custom)
						MySQL.execute("vRP/update_character", {charID = charID, x = x, y = y, z = z, rot = rot, health = health, weapons = weaps, skin = custom})
					end)	
				end)
			end)
		end)
	end
end)