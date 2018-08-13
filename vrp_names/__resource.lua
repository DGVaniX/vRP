description "vrp_names"
dependency "vrp"

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
	"cfg/config.lua",
	"cl_main.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"sv_main.lua"
}
