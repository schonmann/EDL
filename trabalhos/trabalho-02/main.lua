local player = require("model.player")
local assets = require("util.assets")
local constants = require("util.constants")
local renderer = require("renderer.renderer")

function love.load()
    love.window.setMode(constants.VIEWPORT_WIDTH, constants.VIEWPORT_HEIGHT)
    love.window.setTitle(constants.GAME_TITLE)
    love.graphics.setDefaultFilter('nearest')

    playerObject = Player:new(nil, love.graphics.newImage(assets.PATH_IMG_PLAYER))
end

function love.update(dt)
    playerObject:update(dt)

    if love.keyboard.isDown("left") then
        playerObject.ddx = -600
    elseif love.keyboard.isDown("right") then
        playerObject.ddx = 600
    else 
        playerObject.ddx = 0
    end
end

function love.draw()
    renderer.draw(playerObject)
end
