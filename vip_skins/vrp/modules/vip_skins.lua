local cfg = module("cfg/vip_skins")
local Proxy = module("vrp", "lib/Proxy")
local lang = vRP.lang

vRPnc = Proxy.getInterface("vRP_newcoin")

local menus = {}

local function save_idle_custom(player, custom)
	local r_idle = {}

	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		local data = vRP.getUserDataTable(user_id)
		if data then
			if data.vipskins_idle == nil then
				data.vipskins_idle = custom
			end

			for k,v in pairs(data.vipskins_idle) do
				r_idle[k] = v
			end
		end
	end
	return r_idle
end

local function rollback_idle_custom(player)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data then
      if data.vipskins_idle ~= nil then
        vRPclient.setCustomization(player,{data.vipskins_idle})
        data.vipskins_idle = nil
      end
    end
  end
end

for k,v in pairs(cfg.vip_skins) do
  local menu = {name="V.I.P Skins",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
  menus[k] = menu

	local not_uniform = false
	if v._config and v._config.not_uniform then not_uniform = true end

	local choose = function(player, choice)
		local custom = v[choice]
		if custom then
			local price = tonumber(custom.price)
			local user_id = tonumber(vRP.getUserId(player))
			local coins = tonumber(vRPnc.getCoins({user_id}))
			if(coins >= price) then
				vRPclient.getCustomization(player,{},function(custom)	
					local idle_copy = {}

					if not not_uniform then
					  idle_copy = save_idle_custom(player, custom)
					end

					if v[choice].model ~= nil then
					  idle_copy.modelhash = nil
					end

					for l,w in pairs(v[choice]) do
					  idle_copy[l] = w
					end
					vRPclient.setCustomization(player,{idle_copy})
				end)
				vRPnc.takeCoins({user_id, price})
				vRPclient.notify(player,{"~w~You purchased ~g~"..k.." ~w~for ~g~"..price.." Coins!"})
			else
				vRPclient.notify(player,{"~r~You don't have enough coins!"})
			end
		end
	end

  if not not_uniform then
    menu[lang.cloakroom.undress.title()] = {function(player,choice) rollback_idle_custom(player) end, "PERMANENTLY REMOVE THE SKIN!\nCOINS WILL NOT BE RETURNED!"}
  end

  for l,w in pairs(v) do
    if l ~= "_config" then
		local price = tonumber(w.price)
		menu[l] = {choose, "Price: "..price.." Coins"}
    end
  end
end

local function build_client_points(source)
	for k,v in pairs(cfg.vipskins) do
		local gtype,x,y,z = table.unpack(v)
		local vipskins = cfg.vip_skins[gtype]
		local menu = menus[gtype]
		if vipskins and menu then
			local gcfg = vipskins._config or {}

				local function vipskins_enter(source,area)
				local user_id = vRP.getUserId(source)
				if user_id ~= nil and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
					if gcfg.not_uniform then
						local data = vRP.getUserDataTable(user_id)
						if data.vipskins_idle ~= nil then
							vRPclient.notify(source,{lang.common.wearing_uniform()})
						end
					end

					vRP.openMenu(source,menu)
				end
			end

			local function vipskins_leave(source,area)
				vRP.closeMenu(source)
			end

			vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,125,255,125,150})
			vRP.setArea(source,"vRP:cfg:vipskins"..k,x,y,z,1,1.5,vipskins_enter,vipskins_leave)
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		build_client_points(source)
	end
end)
