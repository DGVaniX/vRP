resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description "vRP phonecall"

dependency "vrp"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
