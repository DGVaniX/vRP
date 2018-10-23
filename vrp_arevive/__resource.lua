description "vRP Admin Revive"

dependency "vrp"

client_scripts{ 
	"lib/Tunnel.lua",
	"lib/Proxy.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
