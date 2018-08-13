--[[Proxy/Tunnel]]--

vRPcc = {}
Tunnel.bindInterface("vRP_cuffcutter",vRPcc)
Proxy.addInterface("vRP_cuffcutter",vRPcc)
vRP = Proxy.getInterface("vRP")

lang_string = {
menu1 = "Cut Cuffs",
menu2 = "Close"
}

isHandcuffed = false

function MenuCutCuff()
    MenuTitle = "Cutter"
    ClearMenu()
    Menu.addButton(lang_string.menu1,"CutCuffs",nil)
    Menu.addButton(lang_string.menu2,"CloseMenu",nil) 
	FreezeEntityPosition(GetPlayerPed(-1),true)
	isHandcuffed = false
end

function CutCuffs()
	TriggerServerEvent('cutCuffs')
	CloseMenu()
end

function CloseMenu()
    Menu.hidden = true
	isHandcuffed = false
	FreezeEntityPosition(GetPlayerPed(-1),false)	
end

RegisterNetEvent("unfreezePlayer")
AddEventHandler("unfreezePlayer", function()
	FreezeEntityPosition(GetPlayerPed(-1),false)
	isHandcuffed = false
end)

RegisterNetEvent("freezePlayer")
AddEventHandler("freezePlayer", function()
	FreezeEntityPosition(GetPlayerPed(-1),true)
end)

RegisterNetEvent("tryCutCuffs")
AddEventHandler("tryCutCuffs", function()
	isHandcuffed = true
end)

function ply_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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
  DrawText(x , y)
end

Citizen.CreateThread(function()
	 while true do
		Citizen.Wait(0)
		if not IsEntityDead(PlayerPedId()) then
			if (IsPedInAnyVehicle(GetPlayerPed(-1), true) == false) then
				if (isHandcuffed == true) then
					MenuCutCuff()
					Menu.hidden = false  
				end
				Menu.renderGUI()
			end
		end
	end
end)