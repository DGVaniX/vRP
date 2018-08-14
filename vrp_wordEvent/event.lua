local Chars = {}
for Loop = 0, 255 do
   Chars[Loop+1] = string.char(Loop)
end
local String = table.concat(Chars)

local Built = {['.'] = Chars}

local AddLookup = function(CharSet)
   local Substitute = string.gsub(String, '[^'..CharSet..']', '')
   local Lookup = {}
   for Loop = 1, string.len(Substitute) do
       Lookup[Loop] = string.sub(Substitute, Loop, Loop)
   end
   Built[CharSet] = Lookup

   return Lookup
end

function string.random(Length, CharSet)
   local CharSet = CharSet or '.'

   if CharSet == '' then
      return ''
   else
      local Result = {}
      local Lookup = Built[CharSet] or AddLookup(CharSet)
      local Range = #Lookup

      for Loop = 1,Length do
         Result[Loop] = Lookup[math.random(1, Range)]
      end

      return table.concat(Result)
   end
end

over = false
theString = ""
theReward = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1600000)
		over = false
		local length = math.random(6, 10)
		theString = string.random(length, "%l%u")
		theReward = math.random(10000, 50000)
		theReward2 = theReward * 2
		TriggerClientEvent('chatMessage', -1, "^2[Server] Who writes the word: ^1"..theString.." ^first gets ^1$"..theReward)
		SetTimeout(10000, function()
			if(over == false)then
				TriggerClientEvent('chatMessage', -1, "^2[Server] Time is over, no one wrote the word!")
				over = true
				theReward = 0
				theReward2 = 0
				theString = ""
			end
		end)
	end
end)

AddEventHandler('chatMessage', function(player, color, message)
	if(over == false)then
		if(message == theString)then
			local user_id = vRP.getUserId(player)
			TriggerClientEvent('chatMessage', -1, "^2[Server] ^1"..GetPlayerName(player).." ^2wrote the word and won ^1$"..theReward)
			over = true
			local newReward = theReward2 / 2
			vRP.giveMoney(user_id, newReward)
		end
	end
end)