local AbstractController = require('../controller/abstractcontroller')
local Player = require("model.player")
local Background = require("model.background")

local function MenuController(manager)
    local self = AbstractController(manager)

    function self.reset()
        self.objects = {}
    end

    function self.init()
        self.reset()
        table.insert(self.objects, Background())
    end

    function self.handleInput(dt)
        function love.keypressed(key)
            if key == "space" then
                self.manager.toGame()
            end
        end
    end

    self.init()

    return self
end

return MenuController
