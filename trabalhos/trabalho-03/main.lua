local Constants = require("util.constants")
local Assets = require("util.assets")
local SoundManager = require("util.soundmanager")
local ControllerManager = require("util.controllermanager")

function love.load()
    love.window.setMode(Constants.VIEWPORT_WIDTH, Constants.VIEWPORT_HEIGHT)
    love.window.setTitle(Constants.GAME_TITLE)
    love.graphics.setDefaultFilter('nearest')

    soundManager = SoundManager()
    manager = ControllerManager()

    soundManager.playMainMusic()
end

function love.update(dt)
    manager.getCurrent().handleInput(dt)
    manager.getCurrent().update(dt)
end

function love.draw()
    manager.getCurrent().draw()
end