local AbstractController = require('../controller/abstractcontroller')
local Assets = require('../util/assets')
local Constants = require('../util/constants')
local Player = require("model.player")
local Enemy = require("model.enemy")
local Background = require("model.background")

local function GameController(manager)
    local self = AbstractController(manager)

    local player = {}
    local enemies = {}

    function setupBackground()
        local background = Background()
        table.insert(self.objects, background)
    end

    function setupEnemies()
        for i = 1,3 do
            enemy = Enemy()
            table.insert(self.objects, enemy)
            table.insert(enemies, enemy)
        end
    end

    function setupPlayer()
        player = Player()
        table.insert(self.objects, player)
    end

    function self.checkForCollisions()
        for k,v in pairs(enemies) do
            if player.collidesWith(v) then
                return true
            end
        end
        return false
    end

    setupBackground() 
    setupEnemies()
    setupPlayer()

    function self.update(dt)
        for i,o in pairs(self.objects) do
            o.update(dt)
        end
        
        if self.checkForCollisions() then
            manager.toMenu()
        end
    end

    return self
end

return GameController