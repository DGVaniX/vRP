
description "vRP Factions"

dependencies {
	'vrp'
}

server_scripts{
	"@vrp/lib/utils.lua",
	'server.lua'
}
client_scripts{
	"lib/Tunnel.lua",
	"lib/Proxy.lua"
}