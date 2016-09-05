local Player = require("model.Player")
local Constants = require("util.Constants")
local Renderer = require("renderer.Renderer")

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
