--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
	
	THIS RESOURCE WAS RELEASED FOR FREE!
--]]

description "vrp_onlineadmins"
dependency "vrp"

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"server.lua"
}
