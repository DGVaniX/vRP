
description "vRP showroom"
--ui_page "ui/index.html"

dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}

client_scripts{ 
  "cfg/showroom.lua",
  "lib/Proxy.lua",
  "client.lua"
}