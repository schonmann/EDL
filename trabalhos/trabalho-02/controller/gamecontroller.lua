local AbstractController = require('../controller/abstractcontroller')
local Assets = require('../util/assets')
local Constants = require('../util/constants')
local Player = require("model.player")
local Background = require("model.background")

local function GameController(manager)
    local self = AbstractController(manager)
    
    -- Fields.

    local background = Background()
    local player = Player()
    
    table.insert(self.objects, background)
    table.insert(self.objects, player)

    -- Methods.

    function self.update(dt)
        background.update(dt)
        player.update(dt)
    end

    return self
end

return GameController
