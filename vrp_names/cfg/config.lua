config = {
    -- range where names are visible on this distance
    range = 7,
    -- Show own id
    self = false,
    -- Shows speaker title
    speaker = true,
    -- Show user registration name
    name = false,
    -- Show user id
    id = true,
    -- Show names only for admins
    admin_only = false,
    -- Language vars
    lang = {
        default = "en",
        ['en'] = {
            speaking = "Speaking"
        },
        ['ru'] = {
            speaking = "Говорит"
        }
    },
    colors = {
		default = {r = 255, g = 255, b = 255, a = 225},
		--Staff
		owners = {r = 255, g = 0, b = 0, a = 225},
		admins = {r = 255, g = 0, b = 0, a = 225},
		mods = {r = 0, g = 255, b = 0, a = 225},
		--Guvern
		cop = {r = 0, g = 76, b = 255, a = 225},
		ems = {r = 255, g = 128, b = 255, a = 225},
		
        speaker = {r = 0, g = 150, b = 230, a = 225}
    }
}