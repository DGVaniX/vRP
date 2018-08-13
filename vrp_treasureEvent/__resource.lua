
description "vRP Treasure"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "Proxy.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}