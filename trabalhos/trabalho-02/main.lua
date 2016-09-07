local Constants = require("util.constants")
local ControllerManager = require("controller.controllermanager")

function love.load()
    love.window.setMode(Constants.VIEWPORT_WIDTH, Constants.VIEWPORT_HEIGHT)
    love.window.setTitle(Constants.GAME_TITLE)
    love.graphics.setDefaultFilter('nearest')

    manager = ControllerManager();
end

function love.update(dt)
    manager.getCurrent().handleInput(dt)
    manager.getCurrent().update(dt)
end

function love.draw()
    manager.getCurrent().draw()
end