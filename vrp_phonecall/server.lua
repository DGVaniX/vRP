local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_phonecall")

vRPpc = {}
Tunnel.bindInterface("vRP_phonecall",vRPpc)
Proxy.addInterface("vRP_phonecall",vRPpc)
vRPpcC = Tunnel.getInterface("vRP_phonecall","vRP_phonecall")

inPhoneCall = {}
talkingWith = {}
playersToCall = {}
callHosts = {}
isCalling = {}

callFee = 100
smsFee = 50

--[[RegisterCommand("t", function(source, args, rawCommand)
	local callerID = vRP.getUserId({source})
	local player = inPhoneCall[callerID]
	if(player == nil)then
			TriggerClientEvent('chatMessage', source, "^5[CALL] ^8You are not in a call!") 
	else
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^3SYNTAX: /"..rawCommand.." [Mesaj]") 
		else
			TriggerClientEvent('chatMessage', player, "^5[CALL] ^7| " .. GetPlayerName(source) .. ": " ..  rawCommand:sub(3))
			TriggerClientEvent('chatMessage', source, "^5[CALL] ^7| You: " ..  rawCommand:sub(3))
		end
	end
end, false)]]

function vRPpc.cancelCall(user_id)
	local calling = inPhoneCall[user_id]
	local callingID = vRP.getUserId({calling})
	local thePlayer = vRP.getUserSource({user_id})
	if(callHosts[user_id] ~= nil)then
		isCalling[user_id] = false
		if vRP.tryPayment({user_id, callFee}) then
			inPhoneCall[user_id] = nil
			inPhoneCall[callingID] = nil
			vRPclient.notify(thePlayer, {"~r~You have hang up on ~w~"..GetPlayerName(calling)})
			vRPclient.notify(calling, {"~w~"..GetPlayerName(thePlayer).."~r~ has hanged up"})
		end
	else
		if vRP.tryPayment({callingID, callFee}) then
			inPhoneCall[user_id] = nil
			inPhoneCall[callingID] = nil
			vRPclient.notify(thePlayer, {"~r~You have hang up on ~w~"..GetPlayerName(calling)})
			vRPclient.notify(calling, {"~w~"..GetPlayerName(thePlayer).."~r~ has hanged up"})
		end
	end
	TriggerClientEvent("cancelPhoneCall", thePlayer)
	TriggerClientEvent("cancelPhoneCall", calling)
	vRPclient.playAnim(thePlayer,{true,{{"cellphone@","cellphone_call_out",1}},false})
	vRPclient.playAnim(calling,{true,{{"cellphone@","cellphone_call_out",1}},false})
end

local call_seq = {
  {"cellphone@","cellphone_call_in",1},
  {"cellphone@","cellphone_call_listen_base",1}
}

function vRPpc.makePhoneCall(source,user_id)
	thePlayer = source
	local callerID = vRP.getUserId({thePlayer})
	local calling = vRP.getUserSource({user_id})
	if(inPhoneCall[callerID] == nil)then
		if (inPhoneCall[user_id] == nil)then
			calling = calling
			TriggerClientEvent("phoneCall", thePlayer, thePlayer, thePlayer, calling)
			vRPclient.playAnim(thePlayer,{true,call_seq,true})
			if(isCalling[callerID] == true)then
				vRPclient.notify(thePlayer, {"~r~You are already in a call!"})
				return
			end
			vRP.request({calling,"Primesti un apel de la "..GetPlayerName(thePlayer), 10, function(calling,ok)
				calling = calling
				if ok then
					local callerID = vRP.getUserId({thePlayer})
					local callingID = vRP.getUserId({calling})
					inPhoneCall[callerID] = calling
					inPhoneCall[callingID] = thePlayer
					callHosts[callerID] = thePlayer
					vRPclient.notify(thePlayer, {"~w~"..GetPlayerName(calling).." ~g~picked up! ~g~You the ~r~'N' ~g~hotkey to talk!"})
					vRPclient.notify(calling, {"~g~You picked up ~w~"..GetPlayerName(thePlayer).."'s call! ~g~You the ~r~'N' ~g~hotkey to talk!"})
					TriggerClientEvent("phoneCall", calling, thePlayer, calling, thePlayer)
					vRPclient.playAnim(calling,{true,call_seq,true})
					isCalling[callerID] = true
				else
					vRPclient.notify(thePlayer, {"~w~"..GetPlayerName(calling).." ~r~a has refused the call!"})
					vRPclient.notify(calling, {"~r~You have refused ~w~"..GetPlayerName(thePlayer).."'s call!"})
					TriggerClientEvent("cancelPhoneCall", thePlayer)
					isCalling[callerID] = false
					vRPclient.playAnim(thePlayer,{true,{{"cellphone@","cellphone_call_out",1}},false})
				end
			end})
			vRPclient.notify(thePlayer, {"~g~Calling ~w~"..GetPlayerName(calling).."~g~..."})
			vRPclient.notify(calling, {"~w~"..GetPlayerName(thePlayer).." ~g~is calling you!"})
		else
			vRPclient.notify(thePlayer, {"~r~"..GetPlayerName(calling).." ~w~is already in a call!"})
		end
	else
		vRPclient.notify(thePlayer, {"~r~You are already in a call with ~g~"..GetPlayerName(calling)"!"})
	end
end

local function callPlayer(player,choice)
	local user_id = vRP.getUserId({player})
	local money = vRP.getMoney({user_id})
	local callingID = vRP.getUserId({playersToCall[choice]})
	if(money >= callFee)then
		if(user_id == callingID)then
			vRPclient.notify(player, {"~r~You cannot call yourself!"})
		else
			vRPpc.makePhoneCall(player,tonumber(callingID))
			vRP.closeMenu({player})
		end
	else
		vRPclient.notify(player, {"~r~You don't have enough money to start a call!"})
	end
end

local function smsPlayer(player,choice)
	local user_id = vRP.getUserId({player})
	local money = vRP.getMoney({user_id})
	local toSMS = playersToCall[choice]
	local callingID = vRP.getUserId({toSMS})
	player = player
	toSMS = toSMS
	if(money >= smsFee)then
		if(user_id == callingID)then
			vRPclient.notify(player, {"~r~You cannot SMS yourself!"})
		else
			vRP.prompt({player, "Text Message:", "", function(player,text)
				text = text
				if(text ~= "" and text ~= nil)then
					if vRP.tryPayment({user_id, smsFee}) then
						vRPclient.notifyPicture(toSMS, {"CHAR_BLANK_ENTRY", 1, "SMS From:", GetPlayerName(player), text})
						vRPclient.notify(player, {"~g~SMS successfuly sent!"})
					end
				else
					vRPclient.notify(player, {"~r~You didn't ender a message!"})
				end
			end})
			vRP.closeMenu({player})
		end
	else
		vRPclient.notify(player, {"~r~You don't have enough money to send an SMS!"})
	end
end

RegisterServerEvent('playerDropped')
AddEventHandler('playerDropped', function()
    local user_id = vRP.getUserId({source})
    if(inPhoneCall[user_id])then
        vRPpc.cancelCall(user_id)
    end
end)

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		choices["SMS Player"] = {function(player,choice)
			users = vRP.getUsers({})
			vRP.buildMenu({"Agenda", {player = player}, function(menu)
				menu.name = "Agenda"
				menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
				menu.onclose = function(player) vRP.closeMenu({player}) end
				myName = tostring(GetPlayerName(player))
				for k, v in pairs(users) do
					playerName = tostring(GetPlayerName(v))
					if(playerName ~= myName)then
						playersToCall[playerName] = v
						menu[playerName] = {smsPlayer, "Send SMS"}
					end
				end
				vRP.openMenu({player,menu})
			end})
		end}
		choices["Call Player"] = {function(player,choice)
			users = vRP.getUsers({})
			vRP.buildMenu({"Agenda", {player = player}, function(menu)
				menu.name = "Agenda"
				menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
				menu.onclose = function(player) vRP.closeMenu({player}) end
				user_id = vRP.getUserId({player})
				if(inPhoneCall[user_id] == nil)then
					myName = tostring(GetPlayerName(player))
					for k, v in pairs(users) do
						playerName = tostring(GetPlayerName(v))
						if(playerName ~= myName)then
							playersToCall[playerName] = v
							menu[playerName] = {callPlayer, "Call player"}
						end
					end
				else
					menu["Close Call"] = {function(player,choice)
						local user_id = vRP.getUserId({player})
						vRPpc.cancelCall(user_id)
						vRP.closeMenu({player})
					end,"Close call with "..(GetPlayerName(inPhoneCall[user_id]) or " ")}
				end
				vRP.openMenu({player,menu})
			end})
		end,"Call a player"}
		add(choices)
	end
end})
