--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
--]]

local cfg = {}

cfg.open_coins = 0

cfg.display_css = [[
.div_coins{
	position: absolute;
	top: 123px;
	right: 10px;
	font-size: 30px;
	font-family: Pricedown;
	color: #FFFFFF;
	text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}

.div_coins .symbol{
	content: url('ICON .PNG URL'); 
	display: inline-flex;
	width: 23px;
	height: 23px;
}
]]

function getCoinConfig()
	return cfg
end
