local AbstractController = require('../controller/abstractcontroller')
local Assets = require('../util/assets')
local Constants = require('../util/constants')
local Player = require("model.player")
local Enemy = require("model.enemy")
local Background = require("model.background")

local function GameController(manager)
    local self = AbstractController(manager)

    function setupBackground()
        local background = Background()
        table.insert(self.objects, background)
    end

    function setupEnemies()
        for i = 1,3 do
            local enemy = Enemy()
            table.insert(self.objects, enemy)
        end
    end

    function setupPlayer()
        local player = Player()
        table.insert(self.objects, player)
    end

    setupBackground()
    setupEnemies()
    setupPlayer()

    return self
end

return GameController
