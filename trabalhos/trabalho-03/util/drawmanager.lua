local Constants = require("../util/constants")

local self = {}

function self.drawGameOver(score,hiscore)
    local textGameOver = Constants.TEXT_GAME_OVER
    local textGameOverWidth = love.graphics.getFont():getWidth(textGameOver)
    local textGameOverHeight = love.graphics.getFont():getHeight(textGameOver)

    local textScore = Constants.TEXT_SCORE .. ": " .. score
    local textScoreWidth = love.graphics.getFont():getWidth(textScore)
    local textScoreHeight = love.graphics.getFont():getHeight(textScore)

    local textHiscore = Constants.TEXT_HISCORE .. ": " .. hiscore
    local textHiscoreWidth = love.graphics.getFont():getWidth(textHiscore)
    local textHiscoreHeight = love.graphics.getFont():getHeight(textHiscore)

    love.graphics.print(textGameOver, 
        Constants.VIEWPORT_WIDTH/2, 
        Constants.VIEWPORT_HEIGHT/2, 0,
        Constants.TEXT_SCALE_GOVER, 
        Constants.TEXT_SCALE_GOVER, 
        textGameOverWidth/2, 
        textGameOverHeight/2)

    love.graphics.print(textScore, 
        Constants.VIEWPORT_WIDTH/2, 
        2*Constants.VIEWPORT_HEIGHT/3, 0,
        Constants.TEXT_SCALE_HISCORE, 
        Constants.TEXT_SCALE_HISCORE, 
        textScoreWidth/2, 
        textScoreHeight/2)

    love.graphics.print(textHiscore, 
        Constants.VIEWPORT_WIDTH/2, 
        2*Constants.VIEWPORT_HEIGHT/3 + textHiscoreHeight*Constants.TEXT_SCALE_HISCORE, 0,
        Constants.TEXT_SCALE_HISCORE, 
        Constants.TEXT_SCALE_HISCORE, 
        textHiscoreWidth/2, 
        textHiscoreHeight/2)
end

function self.drawHUD(score,hiscore)
    local textScore = score
    local textHiscore = Constants.TEXT_HISCORE .. ": " .. hiscore

    local textScoreWidth = love.graphics.getFont():getWidth(textScore)
    local textScoreHeight = love.graphics.getFont():getHeight(textScore)
    local textHiscoreWidth = love.graphics.getFont():getWidth(textHiscore)
    local textHiscoreHeight = love.graphics.getFont():getHeight(textHiscore)

    love.graphics.print(textScore, 
        Constants.VIEWPORT_WIDTH/2, 
        100, 
        0, 
        Constants.TEXT_SCALE_SCORE, 
        Constants.TEXT_SCALE_SCORE, textScoreWidth/2, textScoreHeight/2)

    love.graphics.print(textHiscore, 
        20, 
        20, 
        0, 
        Constants.TEXT_SCALE_HISCORE, 
        Constants.TEXT_SCALE_HISCORE, 0, textHiscoreHeight/2)
end

function self.drawIntro()
    local textTitle = Constants.TEXT_TITLE
    local textIntro = Constants.TEXT_INTRO

    local textTitleWidth = love.graphics.getFont():getWidth(textTitle)
    local textTitleHeight = love.graphics.getFont():getHeight(textTitle)
    local textIntroWidth = love.graphics.getFont():getWidth(textIntro)
    local textIntroHeight = love.graphics.getFont():getHeight(textIntro)

    local fsin = 1.0 + math.sin(love.timer.getTime() * 8)/20
    local fcos = 2 * math.cos(love.timer.getTime() * 10)

    -- Cosinuidal

    love.graphics.print(textTitle,
        Constants.VIEWPORT_WIDTH/2,
        Constants.VIEWPORT_HEIGHT/4 + fcos, 0, 
        Constants.TEXT_SCALE_TITLE, 
        Constants.TEXT_SCALE_TITLE, textTitleWidth/2, textTitleHeight/2)

    -- Sinusoidal movement to intro text.

    love.graphics.print(textIntro, 
        Constants.VIEWPORT_WIDTH/2,
        Constants.VIEWPORT_HEIGHT/2, 0, 
        Constants.TEXT_SCALE_INTRO*(fsin), 
        Constants.TEXT_SCALE_INTRO*(fsin), textIntroWidth/2, textIntroHeight/2)
end

return self