local AbstractController = require('../controller/abstractcontroller')
local Assets = require('../util/assets')
local Constants = require('../util/constants')
local Player = require("model.player")
local Enemy = require("model.enemy")
local Background = require("model.background")

local function GameController(manager)
    local self = AbstractController(manager)

    local player = nil
    local enemies = {}
    local score = 0
    local hiscore = 0

    function self.reset()
        self.objects = {}
        player = nil
        enemies = {}
        score = 0
    end

    function setupBackground()
        local background = Background()
        table.insert(self.objects, background)
    end

    function onPlayerScore()
        score = score + 1
        print(score)
    end

    function setupEnemies()
        for i = 1,3 do
            enemy = Enemy()
            enemy.setScoreCallback(onPlayerScore)

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

    function self.init()
        self.reset()
        setupBackground() 
        setupEnemies()
        setupPlayer()
    end

    self.init()
    
    function self.update(dt)
        if not player.isPlaying() then return end

        for i,o in pairs(self.objects) do
            o.update(dt)
        end

        if self.checkForCollisions() then -- game over!
            if score > hiscore then
                hiscore = score
            end

            self.init()
        end
    end

    function drawHUD()
        local scoreTxt = score
        local hiscoreTxt = Constants.TEXT_HISCORE .. ": " .. hiscore

        local scoreTxtWidth = love.graphics.getFont():getWidth(scoreTxt)
        local hiscoreTxtWidth = love.graphics.getFont():getWidth(hiscoreTxt)

        love.graphics.print(scoreTxt, 
        Constants.VIEWPORT_WIDTH/2 - Constants.TEXT_SCALE*1.5*scoreTxtWidth/2, 
        100, 
        0, 
        Constants.TEXT_SCALE*1.5, 
        Constants.TEXT_SCALE*1.5)

        love.graphics.print(hiscoreTxt, 20, 20, 0, Constants.TEXT_SCALE*1, Constants.TEXT_SCALE*1)
    end

    function drawIntro()
        local titleText = Constants.TEXT_TITLE
        local introText = Constants.TEXT_INTRO

        local titleTextWidth = love.graphics.getFont():getWidth(titleText)
        local titleTextHeight = love.graphics.getFont():getHeight(titleText)
        local introTextWidth = love.graphics.getFont():getWidth(introText)
        local introTextHeight = love.graphics.getFont():getHeight(introText)

        local fsin = 1.0 + math.sin(love.timer.getTime() * 8)/20
        local fcos = 2 * math.cos(love.timer.getTime() * 10)

        -- Cosinuidal

        love.graphics.print(titleText,
        Constants.VIEWPORT_WIDTH/2,
        Constants.VIEWPORT_HEIGHT/4 + fcos, 0, 
        Constants.TEXT_SCALE_TITLE, 
        Constants.TEXT_SCALE_TITLE, titleTextWidth/2, titleTextHeight/2)

        -- Sinusoidal movement to intro text.

        love.graphics.print(introText, 
        Constants.VIEWPORT_WIDTH/2,
        Constants.VIEWPORT_HEIGHT/2, 0, 
        Constants.TEXT_SCALE*(fsin), 
        Constants.TEXT_SCALE*(fsin), introTextWidth/2, introTextHeight/2)
    end

    function self.draw()
        for i,o in pairs(self.objects) do
            o.draw()
        end

        if not player.isPlaying() then
            drawIntro()
        else
            drawHUD()
        end
    end

    return self
end

return GameController