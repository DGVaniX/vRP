resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "vRP_AdminJail"

dependency "vrp"
dependency "vrp_mysql"

client_scripts{ 
	"lib/Tunnel.lua",
	"lib/Proxy.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server.lua"
}
