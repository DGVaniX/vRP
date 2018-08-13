local allowedTowModels = { 
    ['flatbed'] = {x = 0.0, y = -0.85, z = 1.25}
}

local allowTowingBoats = false 
local allowTowingPlanes = false 
local allowTowingHelicopters = false 
local allowTowingTrains = false 
local allowTowingTrailers = true 

local currentlyTowedVehicle = nil

function isTargetVehicleATrailer(modelHash)
    if GetVehicleClassFromName(modelHash) == 11 then
        return true
    else
        return false
    end
end

local xoff = 0.0
local yoff = 0.0
local zoff = 0.0

function isVehicleATowTruck(vehicle)
    local isValid = false
    for model,posOffset in pairs(allowedTowModels) do
        if IsVehicleModel(vehicle, model) then
            xoff = posOffset.x
            yoff = posOffset.y
            zoff = posOffset.z
            isValid = true
            break
        end
    end
    return isValid
end

RegisterNetEvent('towVehicle')
AddEventHandler('towVehicle', function()
	
	local playerped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerped, true)
	
	local isVehicleTow = isVehicleATowTruck(vehicle)

	if isVehicleTow then

		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 20.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)
        
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				isVehicleTow = isVehicleATowTruck(vehicle)
				local roll = GetEntityRoll(GetVehiclePedIsIn(PlayerPedId(), true))
				if IsEntityUpsidedown(GetVehiclePedIsIn(PlayerPedId(), true)) and isVehicleTow or roll > 70.0 or roll < -70.0 then
					DetachEntity(currentlyTowedVehicle, false, false)
					TriggerServerEvent("setPlayerAsNotTowing", currentlyTowedVehicle)
					currentlyTowedVehicle = nil
					ShowNotification("~w~[T.A] ~r~Cablurile platformei s-au rupt iar vehiculul a cazut de pe rampa!")
				end
                
			end
		end)

		if currentlyTowedVehicle == nil then
			if targetVehicle then
                local targetVehicleLocation = GetEntityCoords(targetVehicle, true)
                local towTruckVehicleLocation = GetEntityCoords(vehicle, true)
                local distanceBetweenVehicles = GetDistanceBetweenCoords(targetVehicleLocation, towTruckVehicleLocation, false)
                if distanceBetweenVehicles > 12.0 then
                    ShowNotification("~w~[T.A] ~r~Cablurile nu sunt asa lungi. Apropiete de vehicul!")
                else
                    local targetModelHash = GetEntityModel(targetVehicle)
                    if not ((not allowTowingBoats and IsThisModelABoat(targetModelHash)) or (not allowTowingHelicopters and IsThisModelAHeli(targetModelHash)) or (not allowTowingPlanes and IsThisModelAPlane(targetModelHash)) or (not allowTowingTrains and IsThisModelATrain(targetModelHash)) or (not allowTowingTrailers and isTargetVehicleATrailer(targetModelHash))) then 
                        if not IsPedInAnyVehicle(playerped, true) then
                            if vehicle ~= targetVehicle and IsVehicleStopped(vehicle) then
								local isOwned = IsEntityAMissionEntity(targetVehicle)
								if(isOwned)then
									AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0 + xoff, -1.5 + yoff, 0.0 + zoff - 0.43, 0, 0, 0, 1, 1, 0, 1, 0, 1)
									currentlyTowedVehicle = targetVehicle
									TriggerServerEvent("setPlayerAsTowing", currentlyTowedVehicle)
									ShowNotification("~w~[T.A] ~g~Ai urcat vehiculul pe rampa.")
								else
									ShowNotification("~w~[T.A] ~r~Poti tracta doar vehicule personale!")
								end
                            else
                                ShowNotification("~w~[T.A] ~r~Nu este nici un vehicul pe platforma.")
                            end
                        else
                            ShowNotification("~w~[T.A] ~r~Trebuie sa fi in afara platformei pentru a urca o masina.")
                        end
                    else
                        ShowNotification("~w~[T.A] ~r~Platforma nu este echipata pentru a tracta acest vehicul.")
                    end
                end
            else
                ShowNotification("~w~[T.A] ~r~Nici un vehicul tractabil prin apropiere.")
			end
		elseif IsVehicleStopped(vehicle) then
            DetachEntity(currentlyTowedVehicle, false, false)
            local vehiclesCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -9.1, 0.0)
			SetEntityCoords(currentlyTowedVehicle, vehiclesCoords["x"], vehiclesCoords["y"], vehiclesCoords["z"], 1, 0, 0, 1)
			SetVehicleOnGroundProperly(currentlyTowedVehicle)
			currentlyTowedVehicle = nil
			TriggerServerEvent("setPlayerAsNotTowing", currentlyTowedVehicle)
			ShowNotification("~w~[T.A] ~g~Vehiculul a fost eliberat de pe rampa.")
		end
	else
        ShowNotification("~w~[T.A] ~r~Trebuie sa fii langa o rampa pentru a tracta o masina.")
    end
end)

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end
RegisterNetEvent("deleteTowedVehicle")
AddEventHandler("deleteTowedVehicle", function()
	DetachEntity(currentlyTowedVehicle, false, false)
	deleteCar(currentlyTowedVehicle)
	currentlyTowedVehicle = nil
end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end