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

-- *** Trabalho 07 *** --

-- A cada vez que esta função for chamada criaremos uma nova closure,
-- representando uma nova instancia do objeto de "Titulo".

local Title = function ()
    local self = {}
    self.text = Constants.TEXT_TITLE
    self.x = Constants.VIEWPORT_WIDTH/2
    self.y = Constants.VIEWPORT_HEIGHT/4
    self.w = love.graphics.getFont():getWidth(self.text)
    self.h = love.graphics.getFont():getHeight(self.text)
    return self
end

local Intro = function ()
    local self = {}
    self.text = Constants.TEXT_INTRO
    self.x = Constants.VIEWPORT_WIDTH/2 - 40
    self.y = Constants.VIEWPORT_HEIGHT/2
    self.w = love.graphics.getFont():getWidth(self.text)
    self.h = love.graphics.getFont():getHeight(self.text)
    return self
end

-- Criamos duas closures.

local title = Title()
local intro = Intro()

-- Logica da movimentação retangular utilizada pela corotina.

function titleMotion(title)
    local r = 5*Constants.VIEWPORT_WIDTH/8
    local l = 3*Constants.VIEWPORT_WIDTH/8
    local u = 2*Constants.VIEWPORT_HEIGHT/8
    local d = 3*Constants.VIEWPORT_HEIGHT/8

    while true do
        if (title.x >= l and title.x <= r) then
            if title.y <= u then
                title.x = title.x + 1
                coroutine.yield()
            else
                title.x = title.x - 1
                coroutine.yield()
            end
        else
            if(title.x >= r) then
                if(title.y <= d) then
                    title.y = title.y + 1
                    coroutine.yield()
                else
                    title.x = title.x - 1
                    coroutine.yield()
                end
            else
                if(title.y >= u) then
                    title.y = title.y - 1
                    coroutine.yield()
                else
                    title.x = title.x + 1
                    coroutine.yield()
                end
            end
        end
    end
end

-- Cria a corotina c, dada pela função titleMotion.
local c = coroutine.create(titleMotion)

function self.drawIntro()
    
    local fsin = 1.0 + math.sin(love.timer.getTime() * 8)/20
    local fcos = 2 * math.cos(love.timer.getTime() * 10)

    -- Inicia a corotina, executando-a até uma 
    -- chamada yield ou seu término.
    coroutine.resume(c,title)

    love.graphics.print(title.text,
        title.x,
        title.y + fcos, 0, 
        Constants.TEXT_SCALE_TITLE,
        Constants.TEXT_SCALE_TITLE, title.w/2, title.h/2)

    love.graphics.print(intro.text, 
        intro.x,
        intro.y, 0, 
        Constants.TEXT_SCALE_INTRO*(fsin), 
        Constants.TEXT_SCALE_INTRO*(fsin), intro.w/2, intro.h/2)
end

return self