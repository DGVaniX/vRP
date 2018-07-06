--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
	
	THIS RESOURCE WAS RELEASED FOR FREE!
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

adminGroups = {"superadmin", "admin", "mod", "helper"}

local function dummyAdminList(player, choice)
	return
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

local function showAdminsList(player,choice)
	vRP.closeMenu({player})
	SetTimeout(350, function()
		vRP.buildMenu({"Online Admins", {player = player}, function(menu)
			menu.name = "Online Admins"
			menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
			menu.onclose = function(player) vRP.closeMenu({player}) end
			local users = vRP.getUsers({})
			onlineAdmins = 0
			for i, v in pairs(users) do
				user_id = i
				thePlayer = v
				for k, p in pairs(adminGroups) do
					theGroup = p
					if(vRP.hasGroup({user_id, theGroup}))then
						onlineAdmins  = onlineAdmins + 1
						menu[GetPlayerName(thePlayer)] = {dummyAdminList, "ID: "..user_id.."<br>Rank: <font color=\"green\">"..firstToUpper(theGroup).."</font>"}
					end
				end
			end
			if(onlineAdmins == 0)then
				menu["No Online Admins"] = {dummyAdminList, "<font color=\"red\">There are no staff members online at this time!</font>"}
			end
			vRP.openMenu({player,menu})
		end})
	end)
end

vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		choices["Online Admins"] = {showAdminsList, "Show a list of online staff members"}
		add(choices)
	end
end})
