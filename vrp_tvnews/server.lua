local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_tvnews")

group = "weazel"
camPerm = "weazel.camera"
micPerm = "weazel.mic"

local function cameraSettings(player, choice)
	vRP.closeMenu({player})
	player = player
	SetTimeout(350, function()
		vRP.buildMenu({"Camera Settings", {player = player}, function(menu2)
			menu2.name = "Camera Settings"
			menu2.css={top="75px",header_color="rgba(235,0,0,0.75)"}
			menu2.onclose = function(player) vRP.openMenu({player, menu}) end
			
			menu2["News Title"] = {function(player,choice)
				vRP.prompt({player, "News Title:", "", function(player,newsTitle)
					newsTitle = newsTitle
					vRPclient.notify(player, {"~g~News Title: ~w~"..newsTitle})
					TriggerClientEvent("Cam:SetNewsTitle", player, newsTitle)
				end})
			end,"Set the title of the news"}
			
			menu2["Top Title"] = {function(player,choice)
				vRP.prompt({player, "Top Title:", "", function(player,topTitle)
					topTitle = topTitle
					vRPclient.notify(player, {"~g~Top Title: ~w~"..topTitle})
					TriggerClientEvent("Cam:SetTopTitle", player, topTitle)
				end})
			end,"Set the top title"}
			
			menu2["Bottom Title"] = {function(player,choice)
				vRP.prompt({player, "Bottom Title:", "", function(player,botTitle)
					botTitle = botTitle
					vRPclient.notify(player, {"~g~Bottom Title: ~w~"..botTitle})
					TriggerClientEvent("Cam:SetBotTitle", player, botTitle)
				end})
			end,"Set the bottom title"}
			vRP.openMenu({player, menu2})
		end})
	end)
end

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if(vRP.hasGroup({user_id, group}))then
			choices["News Reporter Menu"] = {function(player,choice)
				vRP.buildMenu({"News Reporter Menu", {player = player}, function(menu)
					menu.name = "News Reporter Menu"
					menu.css={top="75px",header_color="rgba(235,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end
					
					if(vRP.hasPermission({user_id, camPerm}))then
						menu["News Camera"] = {function(player,choice)
							TriggerClientEvent("Cam:ToggleCam", player)
						end,"Use the filming camera"}
						
						menu["Camera Settings"] = {cameraSettings,"News camera settings"}
					end
					
					if(vRP.hasPermission({user_id, micPerm}))then
						menu["Microphone"] = {function(player,choice)
							TriggerClientEvent("Mic:ToggleMic", player)
						end,"Use the microphone"}
					end
					
					vRP.openMenu({player, menu})
				end})
			end, "The news reporter menu"}
		end
		add(choices)
	end
end})