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



--[[if o.quad ~= nil then
            love.graphics.draw(
                o.image,
                o.quad,
                o.x,
                o.y,
                o.r,
                o.sx,
                o.sy,
                o.w/2,
                o.h/2)
        else
            love.graphics.draw(
                o.image, 
                o.x, 
                o.y, 
                o.r,
                o.sx,
                o.sy,
                o.w/2,
                o.h/2)
        end ]]