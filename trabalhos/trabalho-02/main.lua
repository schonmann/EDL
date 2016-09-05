local Player = require("model.player")
local Constants = require("util.constants")
local Renderer = require("renderer.renderer")

function love.load()
    love.window.setMode(Constants.VIEWPORT_WIDTH, Constants.VIEWPORT_HEIGHT)
    love.window.setTitle(Constants.GAME_TITLE)
    love.graphics.setDefaultFilter('nearest')

    playerObject = Player()
end

function love.update(dt)
    playerObject.handleInput(dt)
    playerObject.update(dt)
end

function love.draw()
    Renderer.draw(playerObject)
end
