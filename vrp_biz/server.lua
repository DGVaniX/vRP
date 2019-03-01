--[[
========================================================
============== PROJECT: vRP Business ===================
=============== SCRIPTER: DGVaniX ======================
=============== DATE: 10/05/2018 =======================
========================================================
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_biz")
vRPCbiz = Tunnel.getInterface("vRP_biz","vRP_biz")

vRPbiz = {}
Tunnel.bindInterface("vRP_biz",vRPbiz)
Proxy.addInterface("vRP_biz",vRPbiz)

MySQL.createCommand("vRP/get_bizs", "SELECT * FROM vrp_business")
MySQL.createCommand("vRP/get_personal_bizs", "SELECT * FROM vrp_business WHERE bizOwnerID = @user_id")
MySQL.createCommand("vRP/get_owned_bizs", "SELECT * FROM vrp_business WHERE bizOwnerID <> 0")
MySQL.createCommand("vRP/add_biz", "INSERT IGNORE INTO vrp_business(x, y, z, bizName, bizDescription, bizPrice, bizType, bizCashier, bizSupplies, bizOwner, bizOwnerID) VALUES(@x, @y, @z, @bizName, @bizDescription, @bizPrice, @bizType, @bizCashier, @bizSupplies, @bizOwner, @bizOwnerID)")
MySQL.createCommand("vRP/get_biz", "SELECT * FROM vrp_business WHERE id = @bizID")
MySQL.createCommand("vRP/buy_biz", "UPDATE vrp_business SET bizOwner = @bizOwner, bizOwnerID = @bizOwnerID WHERE id = @bizID")
MySQL.createCommand("vRP/update_biz_money", "UPDATE vrp_business SET bizCashier = @bizCashier WHERE id = @bizID")
MySQL.createCommand("vRP/update_biz_owner", "UPDATE vrp_business SET bizOwner = @bizOwner, bizOwnerID = @bizOwnerID WHERE id = @bizID")
MySQL.createCommand("vRP/set_biz_for_sale", "UPDATE vrp_business SET bizForSale = 1, bizSalePrice = @bizSalePrice WHERE id = @bizID")
MySQL.createCommand("vRP/set_biz_notfor_sale", "UPDATE vrp_business SET bizForSale = 0, bizSalePrice = 0 WHERE id = @bizID")
MySQL.createCommand("vRP/set_owner_money", "UPDATE vrp_user_moneys SET bank = bank+@bizMoney WHERE user_id = @userID")
MySQL.createCommand("vRP/update_biz_stock", "UPDATE vrp_business SET bizSupplies = @bizSupplies WHERE id = @bizID")

function vRPbiz.spawnBiz(source)
	MySQL.query("vRP/get_bizs", {}, function(bizs, affected)
		if #bizs > 0 then
			vRPCbiz.spawnBizs(source, {bizs})
		end
	end)
end

function vRPbiz.spawnBizIcons(thePlayer, user_id)
	MySQL.query("vRP/get_personal_bizs", {user_id = user_id}, function(bizs, affected)
		if #bizs > 0 then
			for i, v in pairs(bizs) do
				vRPclient.addBlip(thePlayer,{v.x, v.y, v.z,375,49,v.bizName})
			end
		end
	end)
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPbiz.spawnBiz(source)
	vRPbiz.spawnBizIcons(source, user_id)
end)

local ch_createBiz = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRP.prompt({player,"Business Name:","",function(player,bizName)
			bizName = tostring(bizName)
			if(bizName == nil) or (bizName == "")then
				vRPclient.notify(player, {"~r~You didn't enter the name of the business!"})
			else
				vRP.prompt({player,"Business Description:","",function(player,bizDesc)
					bizDesc = tostring(bizDesc)
					if(bizDesc == nil) or (bizDesc == "")then
						vRPclient.notify(player, {"~r~You didn't enter the description of the business!"})
					else
						vRP.prompt({player,"Business Price:","",function(player,bizPrice)
							bizPrice = tonumber(bizPrice)
							if(bizPrice == nil) or (bizPrice == "") or (bizPrice < 0)then
								vRPclient.notify(player, {"~r~You didn't enter a price!"})
							else
								if not (tonumber(bizPrice))then
									vRPclient.notify(player, {"~r~The price has to be a number!"})
								else
									vRP.prompt({player,"Business Type:","",function(player,bizType)
										bizType = tostring(bizType)		
										if bizType ~= "" or bizType ~= nil then
											vRPclient.getPosition(player,{},function(x,y,z)
												MySQL.query("vRP/add_biz", {x = x, y = y, z = z, bizName = bizName, bizDescription = bizDesc, bizPrice = bizPrice, bizType = bizType, bizCashier = 0, bizSupplies = 75, bizOwner = "None", bizOwnerID = 0})
												vRPclient.notify(player,{"~w~[BIZ] ~g~Biz ~r~#"..bizName.." ~g~created!"})	
												local users = vRP.getUsers({})
												for k, thePlayer in pairs(users) do
													vRPbiz.spawnBiz(thePlayer)
												end
											end)
										else
											vRPclient.notify(player, {"~r~You didn't enter a type!"})
										end
									end})
								end
							end
						end})
					end
				end})
			end
		end})
	end
end, "Create a buyable business"}

RegisterServerEvent("buyBiz")
AddEventHandler("buyBiz", function(bizID)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
		if #bizs > 0 then
			for i, v in pairs(bizs) do
				if(v.bizOwner == "None")then
					if(vRP.tryFullPayment({user_id, tonumber(v.bizPrice)}))then
						vRPclient.notify(thePlayer, {"~w~[BIZ] ~g~You bought ~r~"..tostring(v.bizName).." ~g~for ~r~$"..tonumber(v.bizPrice)})
						MySQL.query("vRP/buy_biz", {bizID = bizID, bizOwner = GetPlayerName(thePlayer), bizOwnerID = user_id})
						vRPclient.addBlip(thePlayer, {v.x, v.y, v.z, 375, 49, v.bizName})
						vRPCbiz.boughtBiz(-1, {bizID, GetPlayerName(thePlayer), user_id})
					else
						vRPclient.notify(thePlayer, {"~w~[BIZ] ~r~You don't have enough money!"})
					end
				else
					vRPclient.notify(thePlayer, {"~w~[BIZ] ~r~This business is already owned by ~g~"..v.bizOwner})
				end
			end
		end
	end)
end)

function takeCashierMoney(thePlayer, bizID)
	local user_id = vRP.getUserId({thePlayer})
	vRP.prompt({thePlayer, "Amount: ", "", function(thePlayer, amount)
		amount = parseInt(amount)
		if(tonumber(amount)) and (amount > 0) and (amount ~= "") and (amount ~= nil)then
			MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
				if #bizs > 0 then
					if(bizs[1].bizCashier >= amount)then
						vRP.giveBankMoney({user_id, amount})
						local moneyLeft = bizs[1].bizCashier - amount
						if(moneyLeft < 0)then
							moneyLeft = 0
						end
						vRPclient.notify(thePlayer, {"~w~[BIZ] ~g~You took ~r~$"..amount.." ~g~out of the business' cash register!"})
						MySQL.query("vRP/update_biz_money", {bizCashier = moneyLeft, bizID = bizID})
						vRP.closeMenu({thePlayer})
					else
						vRPclient.notify(thePlayer, {"~w~[BIZ] ~r~There's not enough money in the business' cash register!"})
					end
				end
			end)
		else
			vRPclient.notify(thePlayer, {"~w~[BIZ] ~r~Please enter a valid amount!"})
		end
	end})
end

function sellBizToPlayer(thePlayer, bizID)
	local user_id = vRP.getUserId({thePlayer})
	vRPclient.getNearestPlayers(thePlayer, {15},function(nplayers)
		usrList = ""
		for k,v in pairs(nplayers) do
			usrList = usrList .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
		end
		if usrList ~= "" then
			vRP.prompt({thePlayer,"Players Nearby: " .. usrList .. "","",function(thePlayer,userID) 
				userID = userID
				if userID ~= nil and userID ~= "" then 
					local target = vRP.getUserSource({tonumber(userID)})
					if target ~= nil then
						vRP.prompt({thePlayer,"Price $: ","",function(thePlayer,amount)
							if (tonumber(amount)) then
								if(tonumber(amount) < 0)then
									vRPclient.notify(thePlayer, {"~r~The price cannot be under $0!"})
									return
								else
									MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
										if #bizs > 0 then
											for i, v in pairs(bizs) do		
												vRP.closeMenu({thePlayer})
												vRPclient.notify(thePlayer, {"~w~[BIZ] ~g~Sell request of ~r~"..v.bizName.." ~g~sent to ~r~"..GetPlayerName(target)})
												vRP.request({target,GetPlayerName(thePlayer).." wants to sell you: " ..v.bizName.. " For: $"..amount, 10, function(target,ok)
													if ok then
														local pID = vRP.getUserId({target})
														local money = vRP.getMoney({pID})
														if (tonumber(money) >= tonumber(amount)) then
															MySQL.query("vRP/update_biz_owner", {bizID = bizID, bizOwner = GetPlayerName(target), bizOwnerID = userID})
															vRPCbiz.boughtBiz(-1, {bizID, GetPlayerName(target), pID})
															vRPclient.addBlip(target, {v.x, v.y, v.z, 375, 49, v.bizName})
															vRPclient.removeNamedBlip(thePlayer, {v.bizName})
															vRP.giveMoney({user_id, amount})
															vRP.setMoney({pID,money-amount})
															vRPclient.notify(thePlayer,{"~w~[BIZ] ~g~You sold ~b~"..v.bizName.." to ~r~".. GetPlayerName(target).." ~g~for ~r~$"..amount.."!"})
															vRPclient.notify(target,{"~w~[BIZ] ~g~"..GetPlayerName(thePlayer).." sold you ~b~"..v.bizName.." ~g~for ~r~$"..amount.."!"})	
														else
															vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~".. GetPlayerName(target).." doesn't have enough money!"})
															vRPclient.notify(target,{"~w~[BIZ] ~r~You don't have enough money!"})
														end
													else
														vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~"..GetPlayerName(target).." refused to buy the business!"})
														vRPclient.notify(target,{"~w~[BIZ] ~r~You refused to buy "..GetPlayerName(thePlayer).."'s business!"})
													end
												end})
											end
										end
									end)
								end
							else
								vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~The price has to be a number"})
							end
						end})
					else
						vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~Player not found."})
					end
				end
			end})
		else
			vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~No player nearby."})
		end
	end)
end

function setForSale(thePlayer, bizID)
	local user_id = vRP.getUserId({thePlayer})
	vRP.prompt({thePlayer,"Price $: ","",function(thePlayer,amount)
		if (tonumber(amount)) then
			if(tonumber(amount) < 0)then
				vRPclient.notify(thePlayer, {"~r~The price cannot be under $0!"})
				return
			elseif(tonumber(amount) > 999999999)then
				vRPclient.notify(thePlayer, {"~r~The price is too high!"})
				return
			else
				MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
					if #bizs > 0 then
						for i, v in pairs(bizs) do		
							vRPclient.notify(thePlayer, {"~w~[BIZ] ~g~You've put the business on sale for ~r~$"..amount})
							bizSalePrice = amount
							MySQL.query("vRP/set_biz_for_sale", {bizID = bizID, bizSalePrice = bizSalePrice})
							vRPCbiz.setForSale(-1, {bizID, 1, bizSalePrice})
							vRP.closeMenu({thePlayer})
						end
					end
				end)
			end
		else
			vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~The price has to be a number."})
		end
	end})
end

function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function buyBizStock(thePlayer, bizID)
	local user_id = vRP.getUserId({thePlayer})
	MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
		if #bizs > 0 then
			for i, v in pairs(bizs) do
				bizProfit = tonumber(v.bizPrice)/2000
				stockPrice = round(tonumber(bizProfit)*0.3)
				bizSupplies = tonumber(v.bizSupplies)
				if(bizSupplies < 75)then
					vRP.prompt({thePlayer,"Stock: (1 Stock = $"..stockPrice..")","",function(thePlayer,amount)
						if (tonumber(amount)) then
							suppliesToBuy = 75 - bizSupplies
							if(tonumber(amount) < 0)then
								vRPclient.notify(thePlayer, {"~r~The amount of stock you want to be has to be more than 0!"})
								return
							elseif(tonumber(amount) > suppliesToBuy)then
								vRPclient.notify(thePlayer, {"~r~You have space for only ~g~"..suppliesToBuy.." more Stock!"})
								return
							else
								stocksPrice = stockPrice*amount
								if (vRP.tryFullPayment({user_id, stocksPrice})) then
									vRPclient.notify(thePlayer, {"~w~[BIZ] ~g~You bought ~r~"..amount.." ~g~more Stock!"})
									bizSupplies = tonumber(v.bizSupplies) + amount
									MySQL.query("vRP/update_biz_stock", {bizID = bizID, bizSupplies = bizSupplies})
									vRP.closeMenu({thePlayer})
								else
									vRPclient.notify({thePlayer,"~w~[BIZ] ~r~You don't have enough money!"})
								end
							end
						else
							vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~The stock amount has to be a number"})
						end
					end})
				else
					vRPclient.notify(thePlayer,{"~w~[BIZ] ~r~You don't have enough space in the stock deposit!"})
				end
			end
		end
	end)
end

function setNotForSale(thePlayer, bizID)
	MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
		if #bizs > 0 then
			for i, v in pairs(bizs) do
				user_id = vRP.getUserId({thePlayer})
				MySQL.query("vRP/set_biz_notfor_sale", {bizID = bizID})
				vRPCbiz.setForSale(-1, {bizID, 0, 0})
				vRP.closeMenu({thePlayer})
				vRPclient.notify(thePlayer, {"~w~[BIZ] ~g~The business is no longer for sale!"})
			end
		end
	end)
end

RegisterServerEvent("buyBizFromOwner")
AddEventHandler("buyBizFromOwner", function(bizID)
	thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
		if #bizs > 0 then
			local bizForSale = bizs[1].bizForSale
			local bizSalePrice = bizs[1].bizSalePrice
			local userID = bizs[1].bizOwnerID
			local bizName = bizs[1].bizName
			local bizOwner = bizs[1].bizOwner
			local x = bizs[1].x
			local y = bizs[1].y
			local z = bizs[1].z
			if(bizForSale == 1)then
				if(vRP.tryFullPayment({user_id, bizSalePrice}))then
					vRPclient.notify(thePlayer, {"~w~[BIZ] ~g~You bought ~b~"..bizName.." ~g~from ~y~"..bizOwner.." ~g~for ~r~$"..bizSalePrice})
					vRPCbiz.boughtBiz(-1, {bizID, GetPlayerName(thePlayer), user_id})
					vRPCbiz.setForSale(-1, {bizID, 0, 0})
					vRPclient.addBlip(thePlayer, {x, y, z, 375, 49, bizName})
					local theTarget = vRP.getUserSource({userID})
					if(theTarget)then
						vRPclient.removeNamedBlip(theTarget, {bizName})
						vRPclient.notify(theTarget, {"~w~[BIZ] ~g~The business ~b~"..bizName.." ~g~was bought by ~r~"..GetPlayerName(thePlayer)})
						vRP.giveBankMoney({userID, bizSalePrice})
					else
						MySQL.query("vRP/set_owner_money", {userID = userID, bizMoney = bizSalePrice})
					end
					MySQL.query("vRP/set_biz_notfor_sale", {bizID = bizID})
					MySQL.query("vRP/update_biz_owner", {bizID = bizID, bizOwner = GetPlayerName(thePlayer), bizOwnerID = user_id})
				else
					vRPclient.notify(thePlayer, {"~w~[BIZ] ~r~You don't have enough money!"})
				end
			else
				vRPclient.notify(thePlayer, {"~w~[BIZ] ~r~This business is not for sale!"})
			end
		end
	end)
end)

RegisterServerEvent("accessBiz")
AddEventHandler("accessBiz", function(bizID)
	thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	MySQL.query("vRP/get_biz", {bizID = bizID}, function(bizs, affected)
		if #bizs > 0 then
			local bizID = bizs[1].id
			local ownerID = bizs[1].bizOwnerID
			local owner = bizs[1].bizOwner
			local bizName = bizs[1].bizName
			local bizPrice = bizs[1].bizPrice
			local bizDesc = bizs[1].bizDescription
			local bizCashier = bizs[1].bizCashier
			local bizForSale = bizs[1].bizForSale
			local bizSalePrice = bizs[1].bizSalePrice
			local bizSupplies = bizs[1].bizSupplies
			if(user_id == bizs[1].bizOwnerID)then
				if(bizSupplies >= 0)then
					currentSuppliesText = "<font color='red'>"..bizSupplies.."</font>"
				else
					currentSuppliesText = "<font color='green'>"..bizSupplies.."</font>"
				end
				local biz_menu = {name=bizName,css={top="75px", header_color="rgba(0,125,255,0.75)"}}
				biz_menu["Cash Register"] = {function() takeCashierMoney(thePlayer, bizID) end, "Money: <font color='green'>$"..bizCashier.."</font>"}
				biz_menu["Sell Business"] = {function() sellBizToPlayer(thePlayer, bizID) end, "Sell the business to a player"}
				biz_menu["Buy Stock"] = {function() buyBizStock(thePlayer, bizID) end, "Stock Left: "..currentSuppliesText}
				if(bizForSale == 1)then
					biz_menu["Cancel Sale"] = {function() setNotForSale(thePlayer, bizID) end, "Cancel the sale of the business<br>Sale Price: <font color='red'>$"..bizSalePrice.."</font>"}
				else
					biz_menu["Put on Sale"] = {function() setForSale(thePlayer, bizID) end, "Put the business on sale"}
				end
				vRP.openMenu({thePlayer,biz_menu})
			else
				vRPclient.notify(thePlayer, {"~w~[BIZ] ~r~You are not the owner of this business!"})
			end
		end
	end)
end)

vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
	
		if vRP.hasPermission({user_id, "create.biz"}) then
			choices["Create Business"] = ch_createBiz
		end
		add(choices)
	end
end})

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3600000)
		MySQL.query("vRP/get_owned_bizs", {}, function(bizs, affected)
			if #bizs > 0 then
				for i, v in pairs(bizs) do
					bizID = v.id
					money = v.bizCashier
					price = v.bizPrice
					thePayday = price / 2000
					theMoney = thePayday + money
					bizSupplies = v.bizSupplies
					if(bizSupplies > 0)then
						bizSupplies = bizSupplies - 1
						MySQL.query("vRP/update_biz_money", {bizCashier = theMoney, bizID = bizID, bizSupplies = bizSupplies})
						MySQL.query("vRP/update_biz_stock", {bizID = bizID, bizSupplies = bizSupplies})
					end
				end
			end
		end)
	end
end)