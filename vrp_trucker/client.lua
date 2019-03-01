vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vRP_trucker")
vRPtruckS = Tunnel.getInterface("vRP_trucker","vRP_trucker")
vRPtruckC = {}
Tunnel.bindInterface("vRP_trucker",vRPtruckC)
Proxy.addInterface("vRP_trucker",vRPtruckC)
x, y, z = 20.78282737732,-2486.6345214844,6.0067796707154
loadingBay = {43.820026397706,-2480.5437011718,6.0067782402038}

theTrailer = nil
incircle = false
incircle2 = false
inJob = false
hasTruck = nil
trailerBlip = nil
jobBlip = nil
trucks = {}
trailers = {}
jobDetails = {}
lBay = nil
leftBay = true

function trucker_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function DrawText3D(x,y,z, text, scl, font) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
   
	if onScreen then
		SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
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

AddEventHandler("playerSpawned",function()
	vRPtruckS.getTrucks({}, function(truckz, trailerz)
		trucks = truckz
		trailers = trailerz
	end)
end)

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function vRPtruckC.getDeliveryDistance(theX, theY, theZ)
	return round(Vdist(x, y, z, theX, theY, theZ))
end

function vRPtruckC.saveDeliveryDetails(theJob)
	jobDetails = theJob
	inJob = true
end

function vRPtruckC.spawnTrailer(theBay, bayLoc)
	bayX, bayY, bayZ = bayLoc[1], bayLoc[2], bayLoc[3]
	local vehicle = GetHashKey(trailers[math.random(1, #trailers)])
    RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
    theTrailer = CreateVehicle(vehicle, bayX, bayY, bayZ, 55.0, true, false)
    SetVehicleOnGroundProperly(theTrailer)
	SetEntityAsMissionEntity( theTrailer, true, true )
	trailerBlip = AddBlipForEntity(theTrailer)
	SetBlipSprite(trailerBlip, 68)
	SetBlipColour(trailerBlip, 2)
	lBay = theBay
	leftBay = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(theTrailer) and (leftBay == false)then
			local trailerCoords = GetEntityCoords(theTrailer)
			if(GetDistanceBetweenCoords(trailerCoords.x, trailerCoords.y, trailerCoords.z, loadingBay[1], loadingBay[2], loadingBay[3]) > 10)then
				leftBay = true
				vRPtruckS.updateBayStats({lBay, 1})
				lBay = nil		
			end
		end
		if(inJob == true) then
			if(theTrailer ~= nil)then
				if not (IsEntityDead(theTrailer)) then
					local ok = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					local ok2, vtype, name = vRP.getNearestOwnedVehicle({7})
					if (ok) then
						isInVehicle = false
						for i, v in pairs(trucks) do
							if (GetHashKey(v) == GetEntityModel(ok)) and (ok2) and (IsEntityAttached(theTrailer)) then
								isInVehicle = true
								if(trailerBlip ~= nil)then
									RemoveBlip(trailerBlip)
									trailerBlip = nil
								end
								if (jobBlip == nil)then
									jobBlip = AddBlipForCoord(jobDetails[2], jobDetails[3], jobDetails[4])
									SetBlipRoute(jobBlip, true)
								end
							end
						end
					else
						trucker_drawTxt("~y~[TRUCKER] ~r~You need a ~y~TRUCK ~r~si ~y~TRAILER ~r~to finish the delivery!",1,1,0.5,0.9,0.8,255,255,255,255)
					end
					if(isInVehicle == false)then
						trucker_drawTxt("~y~[TRUCKER] ~r~You need a ~y~TRUCK ~r~si ~y~TRAILER ~r~to finish the delivery!",1,1,0.5,0.9,0.8,255,255,255,255)
					elseif(isInVehicle == true)then
						if not IsEntityAttached(theTrailer) then
							trailerBlip = AddBlipForEntity(theTrailer)
							SetBlipSprite(trailerBlip, 479)
							SetBlipColour(trailerBlip, 2)
							trucker_drawTxt("~y~[TRUCKER] ~r~You need a ~y~TRUCK ~r~si ~y~TRAILER ~r~to finish the delivery!",1,1,0.5,0.9,0.8,255,255,255,255)
						else
							destinationType = jobDetails[5]
							destinationName = jobDetails[1]
							distanceLeft = tonumber(string.format("%0.4f", round(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, jobDetails[2], jobDetails[3], jobDetails[4]))))
							trucker_drawTxt("~g~Destination: ~b~"..destinationName,1,1,0.5,0.8,0.8,255,255,255,255)
							trucker_drawTxt("~g~Cargo: ~b~"..destinationType,1,1,0.5,0.84,0.8,255,255,255,255)
							trucker_drawTxt("~g~Distance: ~r~"..(distanceLeft/1000).." ~b~KM ~w~| ~g~Trailer Health: ~r~"..GetEntityHealth(theTrailer).." ~b~HP",4,1,0.5,0.87,0.5,255,255,255,255)
						end
					end
				else
					finishJob()
					vRP.notify({"~w~[TRUCK] ~r~The delivery job was cancelled!"})
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) > 40.0)then
						vRPtruckS.payTrailerFine({})
					end
				end
			end
		end
	end
end)

function finishJob()
	hasTruck = nil
	inJob = false
	jobDetails = {}
	if(jobBlip ~= nil)then
		RemoveBlip(jobBlip)
		jobBlip = nil
	end
	if(trailerBlip ~= nil)then
		RemoveBlip(trailerBlip)
		trailerBlip = nil
	end
	if(theTrailer ~= nil)then
		Citizen.InvokeNative(0xEA386986E786A54F , Citizen.PointerValueIntInitialized(theTrailer))
		theTrailer = nil
	end
end

CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(inJob == true)then
			x3, y3, z3 = jobDetails[2], jobDetails[3], jobDetails[4]
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x3, y3, z3) < 40.0)then
				destinationName = jobDetails[1]
				DrawText3D(x3, y3, z3+0.4, "~b~"..destinationName, 2.0, 1)
				DrawMarker(39, x3, y3, z3-0.5, 0, 0, 0, 0, 0, 0, 1.3, 1.3, 1.3, 0, 205, 255, 255, 0, 0, 0, true)
			end
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x3, y3, z3) < 5)then
				incircle2 = true
				if (incircle2 == true) then
					vRPtruckS.finishTruckingDelivery({jobDetails[6]})
					finishJob()
				end
			elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x3, y3, z3) > 5)then
				incircle2 = false
			end
		end
		
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 40.0)then
			DrawText3D(x,y,z+0.4, "~b~Logistics", 2.0, 1)
			DrawText3D(x,y,z+0.15, "~g~Transport of imported goods", 1, 7)
			DrawMarker(39, x, y, z-0.5, 0, 0, 0, 0, 0, 0, 1.3, 1.3, 1.3, 0, 205, 255, 255, 0, 0, 0, true)
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 5)then
				incircle = true
				if (incircle == true) then
					if(hasTruck == nil)then
						local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
						if (ok) then
							for i, v in pairs(trucks) do
								if (v == name) then
									hasTruck = 1
								end
							end
						end
					end
					if (hasTruck == 1) then
						if(inJob == false)then
							trucker_drawTxt("~y~[TRUCKER] ~g~Press ~r~[E] ~g~the deliveries' menu!",1,1,0.5,0.8,0.8,255,255,255,255)
						else
							trucker_drawTxt("~y~[TRUCKER] ~r~You already have a delivery job active!",1,1,0.5,0.74,0.8,255,255,255,255)
						end	
						if(IsControlJustReleased(1, 51)) and (inJob == false)then
							TriggerServerEvent('openTruckerJobs')
						end
					else
						trucker_drawTxt("~y~[TRUCKER] ~r~You need a personal truck to get a delivery!",1,1,0.5,0.8,0.8,255,255,255,255)
					end
				end
			elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) > 5)then
				incircle = false
				hasTruck = nil
			end
		end
	end
end)

