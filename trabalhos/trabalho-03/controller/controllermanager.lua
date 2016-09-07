local GameController = require("../controller/gamecontroller")
local MenuController = require("../controller/menucontroller")

local GAME_CONTROLLER = 1
local MENU_CONTROLLER = 2

local function ControllerManager()
    local self = {}
    local controllers = {}

    table.insert(controllers, GameController(self))
    table.insert(controllers, MenuController(self))

    local current = GAME_CONTROLLER

    function self.passControlTo(controller)
        current = controller
    end

    function self.toMenu()
        self.passControlTo(MENU_CONTROLLER)
    end

    function self.toGame()
        self.passControlTo(GAME_CONTROLLER)
    end

    function self.getCurrent()
        return controllers[current]
    end

    return self
end

return ControllerManager
