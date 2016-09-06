local AbstractController = require('../controller/abstractcontroller')
local Player = require("model.player")
local Background = require("model.background")

local function MenuController(manager)
    local self = AbstractController(manager)
    
    -- Fields.

    table.insert(self.objects, Background())

    -- Methods.

    return self
end

return MenuController
