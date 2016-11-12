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
    local status = {};

    local gameOver = false
    local gameOverTime = 0

    function self.reset()
        gameOver = false
        self.objects = {}
        player = nil
        enemies = {}

        --  ** TRABALHO 06 **
        --
        --  Variável: status
        --  Tipo: Dicionário de dados.
        --  Descrição: Armazenamento por chave/valor. Consulta e CRUD em tempo constante.

        status["score"] = 0;
        status["hiscore"] = 0;
    end

    function setupBackground()
        local background = Background()

        --  ** TRABALHO 06 **
        --
        --  Variável: self.objects
        --  Tipo: Array.
        --  Descrição: Guarda os objetos que fazem parte da lógica do jogo. Dados indexados como um array.

        table.insert(self.objects, background)
    end

    -- Coleção: Instâncias de inimigo (variável enemies).
    -- Escopo: local.
    -- Tempo de vida: No início do jogo, iniciamos a coleção alocando três instâncias de inimigo
    -- posicionadas na extremidade direita da tela. toda vez que um inimigo atinge o lado esquerdo, 
    -- retiramos a instância correspondente do array, para que, mais tarde, o Garbage Collector colete 
    -- a memória fora de uso (Desalocação), encerrando o ciclo de vida do objeto. Ao mesmo tempo, alocamos 
    -- outra instância do objeto de inimigo, adicionando-a na coleção. Deste modo, sempre teremos três 
    -- objetos na coleção até o fim de seu ciclo de vida (game over), onde sua memória é desalocada.

    function onPlayerScore(scoredEnemy)
        status["score"] = status["score"] + 1

        cleanupEnemy(scoredEnemy)

        setupEnemy(createEnemy())
    end

    function cleanupEnemy(enemy)
        for i,v in pairs(self.objects) do
            if v == enemy then
                table.remove(self.objects, i)
            end
        end
        for i,v in pairs(enemies) do
            if v == enemy then
                table.remove(enemies, i)
            end
        end
    end

    function setupEnemies()
        for i = 1,3 do 
            setupEnemy(createEnemy()) 
        end
    end

    function setupEnemy(enemy)
        table.insert(self.objects, enemy)
        table.insert(enemies, enemy)
    end

    function createEnemy()
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
        if not player.isPlaying() then
            DrawManager.update(dt)
            return
        end

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
            if status["score"] > status["hiscore"] then
                status["hiscore"] = status["score"]
            end
        end
    end

    function self.draw()
        for i,o in pairs(self.objects) do
            o.draw()
        end

        if gameOver then
            DrawManager.drawGameOver(status["score"],status["hiscore"])
        elseif not player.isPlaying() then
            DrawManager.drawIntro()
        else
            DrawManager.drawHUD(status["score"],status["hiscore"])
        end
    end

    return self
end

return GameController
