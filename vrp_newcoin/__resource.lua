--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
--]]

description "vrp_newcoin"
dependency "vrp"

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"server.lua",
	"cfg/coin.lua"
}
