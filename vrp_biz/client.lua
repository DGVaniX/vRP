--[[
========================================================
============== PROJECT: vRP Business ===================
=============== SCRIPTER: DGVaniX ======================
=============== DATE: 10/05/2018 =======================
========================================================
]]

vRPbizC = {}
Tunnel.bindInterface("vRP_biz",vRPbizC)
Proxy.addInterface("vRP_biz",vRPbizC)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP_biz","vRP_biz")

bizTable = {}
incircle = false

function vRPbizC.spawnBizs(bizs)	
	bizTable = bizs
end

function vRPbizC.boughtBiz(bizID, ownerName, ownerID)
	for i, v in pairs(bizTable) do
		if(v.id == bizID)then
			v.bizOwner = ownerName
			v.bizOwnerID = ownerID
		end
	end
end

function vRPbizC.setForSale(bizID, saleState, salePrice)
	for i, v in pairs(bizTable) do
		if(v.id == bizID)then
			v.bizForSale = saleState
			v.bizSalePrice = salePrice
		end
	end
end

function biz_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
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

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(bizTable)do
			bizID = v.id
			x = v.x
			y = v.y
			z = v.z 
			bizName = v.bizName
			bizOwner = v.bizOwner
			bizPrice = v.bizPrice
			bizDesc = v.bizDescription
			bizForSale = v.bizForSale
			bizSalePrice = v.bizSalePrice
			payday = tonumber(bizPrice / 2000)

			if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 20.0)then
				if(bizOwner == "None")then
					DrawMarker(29, x, y, z-0.7, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.2001, 0, 255, 0, 255, 0, 0, 0, true)
					DrawText3D(x,y,z+0.23, "~y~"..bizName, 1.5)
					DrawText3D(x,y,z, bizDesc, 0.7)
					DrawText3D(x,y,z-0.1, "~b~Owner: ~r~"..bizOwner.." ~b~Price: ~g~$"..bizPrice, 1)
					DrawText3D(x,y,z-0.21, "~b~Earnings: ~g~$"..payday.."/1h", 1)
				else
					if(bizForSale == 0)then
						DrawMarker(29, x, y, z-0.7, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.2001, 255, 0, 0, 255, 0, 0, 0, true)
						DrawText3D(x,y,z+0.23, "~y~"..bizName, 1.5)
						DrawText3D(x,y,z, bizDesc, 0.7)
						DrawText3D(x,y,z-0.1, "~b~Owner: ~r~"..bizOwner, 1)
						DrawText3D(x,y,z-0.21, "~b~Earnings: ~g~$"..payday.."/1h", 1)
					else
						DrawMarker(29, x, y, z-0.7, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.2001, 255, 255, 0, 255, 0, 0, 0, true)
						DrawText3D(x,y,z+0.23, "~y~"..bizName, 1.5)
						DrawText3D(x,y,z, bizDesc, 0.7)
						DrawText3D(x,y,z-0.1, "~b~Owner: ~r~"..bizOwner.." ~b~Price: ~g~$"..bizSalePrice, 1)
						DrawText3D(x,y,z-0.21, "~b~Earnings: ~g~$"..payday.."/1h", 1)
					end
				end
				if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 1.5)then
					--local playerCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					--if not (playerCar)then
						if (bizOwner == "None") then
							if (incircle == false) then
								biz_DisplayHelpText("Press ~INPUT_CONTEXT~ to buy ~b~"..bizName.." ~w~for ~g~$"..bizPrice)
							end
							incircle = true
							if(IsControlJustReleased(1, 51))then
								TriggerServerEvent('buyBiz', bizID)
							end
						else
							myname = NetworkPlayerGetName(PlayerId())
							if(myname == bizOwner)then
								if (incircle == false) then
									biz_DisplayHelpText("Press ~INPUT_CONTEXT~ to access ~g~"..bizName.."'s ~w~menu")
								end
								incircle = true
								if(IsControlJustReleased(1, 51))then
									TriggerServerEvent('accessBiz', bizID)
								end
							else
								if(bizForSale == 1)then
									if (incircle == false) then
									biz_DisplayHelpText("Press ~INPUT_CONTEXT~ to buy ~g~"..bizName.." ~w~from ~b~"..bizOwner.." ~w~for ~r~$"..bizSalePrice)
									end
									incircle = true
									if(IsControlJustReleased(1, 51))then
										TriggerServerEvent('buyBizFromOwner', bizID)
									end
								end
							end
						end
					--else
					--	biz_DisplayHelpText("~r~You can't access the biz's menu from a vehicle!")
					--end
				elseif(Vdist(pos.x, pos.y, pos.z, x, y, z) > 1.5)then
					incircle = false
				end
			end
		end
		Citizen.Wait(0)
	end
end)