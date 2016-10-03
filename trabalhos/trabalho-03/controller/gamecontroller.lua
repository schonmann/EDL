local AbstractController = require('../controller/abstractcontroller')
local Assets = require('../util/assets')
local Constants = require('../util/constants')
local Player = require("model.player")
local Enemy = require("model.enemy")
local Background = require("model.background")
local DrawManager = require("../util/drawmanager")

local function GameController(manager)
    local self = AbstractController(manager)

    local player = nil
    local enemies = {}
    local score = 0
    local hiscore = 0

    local gameOver = false
    local gameOverTime = 0

    function self.reset()
        gameOver = false
        self.objects = {}
        player = nil
        enemies = {}
        score = 0
    end

    function setupBackground()
        local background = Background()
        table.insert(self.objects, background)
    end

    -- Método de callback chamado quando uma entidade inimigo "morre".

    function onPlayerScore(scoredEnemy)
        score = score + 1

        cleanupEnemy(scoredEnemy)
        setupEnemy(createEnemy())
    end

    function cleanupEnemy(enemy)

        -- Desalocação. Limpa as refências nas tabelas de controle que 
        -- representam às entidades de 'inimigo' a serem destruídas.

        for i,v in pairs(self.objects) do
            if(v.objs_index == enemy.objs_index) then
                table.remove(self.objects, i)
            end
        end
        for i,v in pairs(enemies) do
            if(v.enms_index == enemy.enms_index) then
                table.remove(enemies, enemy.enms_index)
            end
        end
    end

    function setupEnemies()
        for i = 1,3 do 
            setupEnemy(createEnemy()) 
        end
    end

    function setupEnemy(enemy)
        -- Insere nas tabelas de controle.
         enemy.objs_index = #self.objects+1
        enemy.enms_index = #enemies+1
        table.insert(self.objects, enemy)
        table.insert(enemies, enemy)
    end

    function createEnemy()
        -- Alocação. Cria nova entidade de inimigo.

        local enemy = Enemy()
        enemy.setScoreCallback(onPlayerScore)
        return enemy;
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

        if gameOver then
            if love.timer.getTime() - gameOverTime > 2 then
                self.init()
            end
            return
        end

        for i,o in pairs(self.objects) do
            o.update(dt)
        end

        if self.checkForCollisions() then -- game over!
            gameOver = true
            gameOverTime = love.timer.getTime()
            if score > hiscore then
                hiscore = score
            end
        end
    end

    function self.draw()
        for i,o in pairs(self.objects) do
            o.draw()
        end

        if gameOver then
            DrawManager.drawGameOver(score,hiscore)
        elseif not player.isPlaying() then
            DrawManager.drawIntro()
        else
            DrawManager.drawHUD(score,hiscore)
        end
    end

    return self
end

return GameController