-- > ADD THIS AT THE TOP OF EVERY SCRIPT!

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPnc = Proxy.getInterface("vRP_newcoin")

-- > EXAMPLE

vRPnc.giveCoins({player, 100}) -- Give the player 100 coins
vRPnc.takeCoins({player, 100}) -- Take 100 coins from the player
local coins = vRPnc.getCoins({player}) -- Get the number of coins that the player has


-- > HOW TO

Add the Icon URL in line 22 in cfg/coin.lua
