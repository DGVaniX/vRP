
-- this file configure the cloakrooms on the map

local cfg = {}

-- prepare surgeries customizations
local skinul = { model = "Model_Skin", price = 1}

cfg.vip_skins = {
  ["V.I.P"] = {
		_config = { permissions = {"vip.skins"} },
		["Nume Skin"] = skinul
	}
}

cfg.vipskins = {
	{"V.I.P", -268.80694580078,-962.26007080078,31.22313117981}
}

return cfg
