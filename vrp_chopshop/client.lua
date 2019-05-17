vRPCremat = {}
Tunnel.bindInterface("vRP_remat",vRPCremat)
Proxy.addInterface("vRP_remat",vRPCremat)
vRP = Proxy.getInterface("vRP")
vRPSremat = Tunnel.getInterface("vRP_remat","vRP_remat")

incircle = false
local x, y, z = -45.0849609375,-1081.6473388672,26.687330245972

function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(7)
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

theVehicle = ""
vType = ""
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 40.0)then
			DrawText3D(x,y,z+0.25, "~r~Vehicle Chop-Shop", 1.5)
			DrawMarker(1, x, y, z-1.0, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 168, 104, 40, 255, 0, 0, 0, 0)
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 4.0)then
				incircle = true
				if (incircle == true) then
					if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
						local playerCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						if (GetPedInVehicleSeat( playerCar, -1 ) == GetPlayerPed(-1)) then 
							if(theVehicle == "")then
								local ok, vtype, name = vRP.getNearestOwnedVehicle({4})
								if ok then
									theVehicle = name
									vType = vtype
									vRPSremat.checkVehPrice({theVehicle})
								end
							end
						end
					end
				end
			elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) > 4.0)then
				incircle = false
				theVehicle = ""
				vType = ""
			end
		end
	end
end)

RegisterCommand("sellveh", function(source)
	if(theVehicle ~= "")then
		vRPSremat.sellTheVehicle({theVehicle, vType})
	end
end)