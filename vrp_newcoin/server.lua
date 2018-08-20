--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
--]]

MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPnc = {}
Tunnel.bindInterface("vRP_newcoin",vRPnc)
Proxy.addInterface("vRP_newcoin",vRPnc)

vRPclient = Tunnel.getInterface("vRP","vRP_newcoin")

MySQL.createCommand("vRP/coins_init_user","INSERT IGNORE INTO vrp_newcoin(user_id,coins) VALUES(@user_id,@coins)")
MySQL.createCommand("vRP/get_coins","SELECT * FROM vrp_newcoin WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_coins","UPDATE vrp_newcoin SET coins = @coins WHERE user_id = @user_id")

tmpCoins = {}

function displayCoin(value)
	return "<span class=\"symbol\">$</span> "..value
end

function vRPnc.getCoins(user_id)
	local coins = tonumber(tmpCoins[user_id])
	if coins ~= nil then
		return tonumber(tmpCoins[user_id])
	else
		return 0
	end
end

function vRPnc.setCoins(user_id,value)
	local coins = tonumber(tmpCoins[user_id])
	if coins ~= nil then
		tmpCoins[user_id] = tonumber(value)
	end

	local source = vRP.getUserSource({user_id})
	if source ~= nil then
		vRPclient.setDivContent(source,{"coins",displayCoin(value)})
	end
end

function vRPnc.giveCoins(user_id,amount)
	local coins = vRPnc.getCoins(user_id)
	local newCoins = coins + amount
	vRPnc.setCoins(user_id,newCoins)
end

function vRPnc.takeCoins(user_id,amount)
	local coins = vRPnc.getCoins(user_id)
	local newCoins = coins - amount
	vRPnc.setCoins(user_id,newCoins)
end

function vRPnc.tryCoinPayment(user_id,amount)
	local coins = vRP.getCoins(user_id)
	if coins >= amount then
		vRP.setCoins(user_id,coins-amount)
		return true
	else
		return false
	end
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local cfg = getCoinConfig()
	MySQL.execute("vRP/coins_init_user", {user_id = user_id, coins = cfg.open_coins}, function(affected)
		MySQL.query("vRP/get_coins", {user_id = user_id}, function(rows, affected)
			if #rows > 0 then
				tmpCoins[user_id] = tonumber(rows[1].coins)
			end
		end)
	end)
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	local coins = tmpCoins[user_id]
	if coins and coins ~= nil then
		MySQL.execute("vRP/set_coins", {user_id = user_id, coins = coins})
	end
end)

AddEventHandler("vRP:save", function()
	for i, v in pairs(tmpCoins) do
		if v ~= nil then
			MySQL.execute("vRP/set_coins", {user_id = i, coins = v})
		end
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		local cfg = getCoinConfig()
		local myCoins = vRPnc.getCoins(user_id)
		vRPclient.setDiv(source, {"coins", cfg.display_css, displayCoin(myCoins)})
	end
end)

local function givePlayerCoins(player,choice)
	vRP.prompt({player, "User ID: ", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			vRP.prompt({player, "Coins: ", "", function(player, coins)
				coins = coins
				if(tonumber(coins))then
					coins = tonumber(coins)
					vRPnc.giveCoins(user_id,coins)
					vRPclient.notify(player, {"~g~I-ai dat lui ~w~"..GetPlayerName(target).." ~w~"..coins.." ~g~coins"})
					vRPclient.notify(target, {"~w~"..GetPlayerName(player).."~g~ ti-a dat ~w~"..coins.." ~g~coins"})
				else
					vRP.notify(player, {"~r~Coinsurile trebuie sa fie un numar!"})
				end
			end})
		else
			vRPclient.notify(player, {"~r~Jucatorul nu a fost gasit!"})
		end
	end})
end

local function takePlayerCoins(player,choice)
	vRP.prompt({player, "User ID: ", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource({user_id})
		if target ~= nil then
			vRP.prompt({player, "Coins: ", "", function(player, coins)
				coins = coins
				local tCoins = tonumber(vRPnc.getCoins(user_id))
				if(tonumber(coins))then
					coins = tonumber(coins)
					if(tCoins >= coins)then
						vRPnc.takeCoins(user_id,coins)
						vRPclient.notify(player, {"~g~Ai luat de la ~w~"..GetPlayerName(target).." ~w~"..coins.." ~g~coins"})
						vRPclient.notify(target, {"~w~"..GetPlayerName(player).."~g~ a luat de la tine ~w~"..coins.." ~g~coins"})
					else
						vRPclient.notify(player, {"~r~Jucatorul are doar ~w~"..tCoins.." ~g~Coins"})
					end
				else
					vRPclient.notify(player, {"~r~Coinsurile trebuie sa fie un numar!"})
				end
			end})
		else
			vRPclient.notify(player, {"~r~Jucatorul nu a fost gasit!"})
		end
	end})
end

vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if(vRP.hasPermission({user_id, "newcoin.give"}))then
			choices["Give Coins"] = {givePlayerCoins, "Give coins to a player"}
		end
		if(vRP.hasPermission({user_id, "newcoin.take"}))then
			choices["Take Coins"] = {takePlayerCoins, "Take coins from a player"}
		end
		add(choices)
	end
end})
