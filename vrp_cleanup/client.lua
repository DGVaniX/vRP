--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
	

	Updated By 
	
	DoubleRepo AKA 
	TheFlyingDutchMan AKA 
	Mr'SuicideSheep#8623
	https://discord.gg/a8KBSA4
--]]

deleteTime = 45 --Seconds

local enumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function getEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
    
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, enumerator)
    
		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next
  
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function getVehicles()
  return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

RegisterNetEvent('vrp_cleanupthissit')
AddEventHandler('vrp_cleanupthissit', function()
  TriggerEvent("chatMessage", "[SERVER]", {255, 255, 0}, "All unoccupied vehicles will be deleted in "..deleteTime.." seconds!")
  Wait(deleteTime * 60000)
  local theVehicles = getVehicles()
  TriggerEvent("chatMessage", "[SERVER]", {0, 255, 0}, "All unoccupied vehicles have been deleted!")
  for veh in theVehicles do
	if ( DoesEntityExist( veh ) ) then 
	  if((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0)then
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( veh ) )
	  end
	end
  end
end)

Citizen.CreateThread(function()
	while true do
		Wait(15 * 60000)
		TriggerEvent("chatMessage", "[City]", {255, 255, 0}, "You can find Mr'SuicideSheep#8623 on discord @ https://discord.gg/a8KBSA4")
	end
end)
