local player = require("model.player")
local assets = require("util.assets")
local constants = require("util.constants")
local renderer = require("renderer.renderer")

function love.load()
    love.window.setMode(constants.VIEWPORT_WIDTH, constants.VIEWPORT_HEIGHT)
    love.graphics.setDefaultFilter('nearest')

    playerObject = Player:new(nil, love.graphics.newImage(assets.PATH_IMG_PLAYER))
end

function love.draw()
    renderer.draw(playerObject)
end
