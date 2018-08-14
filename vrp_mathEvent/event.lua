over = false
theNumber = ""
theReward = 0
theSign = ""
nr1 = 0
nr2 = 0
operation = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(900000)
		over = false
		local nr1 = math.random(1, 50)
		local nr2 = math.random(1, 50)
		local operation = math.random(1,4)
		if(operation == 1)then
			theSign = "+"
			theNumber = tostring(nr1 + nr2)
		elseif(operation == 2)then
			theSign = "-"
			theNumber = tostring(nr1 - nr2)
		elseif(operation == 3)then
			theSign = "x"
			theNumber = tostring(nr1 * nr2)
		else
			theSign = "/"
			theNumber = tostring(nr1 / nr2)
		end
		theOperation = nr1..""..theSign..""..nr2
		theReward = math.random(100000, 250000)
		theReward2 = theReward * 2
		TriggerClientEvent('chatMessage', -1, "^2[Server] Who gives the correct answer to: ^1"..theOperation.." ^first gets ^1$"..theReward)
		SetTimeout(25000, function()
			if(over == false)then
				TriggerClientEvent('chatMessage', -1, "^2[Server] Time is over, no one wrote the word!")
				over = true
				theReward = 0
				theReward2 = 0
				theNumber = ""
				theSign = ""
				nr1 = 0
				nr2 = 0
				operation = 0
			end
		end)
	end
end)

AddEventHandler('chatMessage', function(player, color, message)
	if(over == false)then
		if(tonumber(message) == tonumber(theNumber))then
			local user_id = vRP.getUserId(player)
			TriggerClientEvent('chatMessage', -1, "^2[Server] ^1"..GetPlayerName(player).." ^2gave the correct answer and won ^1"..theReward.."!")
			over = true
			local newReward = theReward2 / 2
			vRP.giveMoney(user_id, newReward)
		end
	end
end)