local Utils = require("../util/utils")
local Constants = require("../util/constants")
local AbstractGameObject = require("../model/abstractgameobject")
local Assets = require("util/assets")

-- Enemy Class --

--[[
    Nome: Cadeia de caracteres '--'.
    Propriedade: Significado.
    Binding Time: Design.
    Explicação: O significado de '--' como o início de
    uma linha de comentários em um código Lua é definido 
    em tempo de design da linguagem.
]]

local function Enemy(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)
    local self = AbstractGameObject(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)
    
    --[[
        Nome: Variável 'self'
        Propriedade: Endereço.
        Binding Time: Execução.
        Explicação: O endereço de memória
        onde guardaremos o valor de 'self'
        é determinado apenas em tempo de 
        execução, no momento em que a função
        'Enemy' é chamada, e, por consequência, 
        colocada na pilha.
    ]]

    local randomPower = 0

    function self.randomize()
        randomPower = love.math.random(Constants.PLAYER_MIN_JUMP_PWR*100, Constants.PLAYER_MAX_JUMP_PWR*100)/100
        self.x = Constants.VIEWPORT_WIDTH + self.sx*self.w/2
        self.dx = love.math.random(-350, -100)
        self.y = Constants.ENVIRONMENT_GROUND_Y
        self.dy = 0
    end

    function self.init()
        self.image = love.graphics.newImage(Assets.PATH_IMG_ENEMY)
        self.w = Constants.PLAYER_WIDTH
        self.h = Constants.PLAYER_HEIGHT
        self.x = Constants.VIEWPORT_WIDTH + self.w/2
        self.maxdx = Constants.PLAYER_MAX_DX
        self.maxdy = Constants.PLAYER_MAX_DY
        self.sx = Constants.PLAYER_SCALE
        self.sy = Constants.PLAYER_SCALE

        self.hitboxFactor = 0.7
        
        self.randomize()
    end

    self.init()

    function self.applyFriction(deltaTime)
        if self.dx > 0 then
            self.dx = Utils.max(0, self.dx - Constants.PLAYER_FRICTION_X * deltaTime)
        elseif self.dx < 0 then
            self.dx = Utils.min(0, self.dx + Constants.PLAYER_FRICTION_X * deltaTime) 
        end
    end

    function self.updatePositionX(deltaTime)
        self.x = self.x + self.dx * deltaTime
        if self.x < -self.sx*self.w/2 then
            self.randomize()
            self.scoreCallback(self);
        end
    end

    function self.updatePositionY(deltaTime)
        self.y = self.y +  self.dy * deltaTime
        self.y = Utils.clamp(self.y, self.h * self.sy/2, Constants.ENVIRONMENT_GROUND_Y)
    end
    
    --[[
        Nome: Operador "+".
        Propriedade: Semântica.
        Binding Time: Compilação.
        Explicação: Sob o contexto de linguagens
                    estáticas, o comportamento de determinados
                    operadores dependem dos tipos dos operandos.
                    Logo, seu comportamento é avaliado em tempo 
                    de compilação. 
    
                    No caso de linguagens dinâmicas como Lua e JavaScript, 
                    a avaliação das operações é feita em tempo de execução, 
                    o que pode levar a comportamentos inesperados se não 
                    houver cuidado por parte do programador quanto à integridade
                    dos operandos. 
    ]]

    function self.updateMotionX(deltaTime)
        self.dx = self.dx + self.ddx * deltaTime
        self.dx = Utils.clamp(self.dx, -self.maxdx, self.maxdx)
    end

    function self.updateMotionY(deltaTime)
        self.dy = self.dy + self.ddy * deltaTime
        self.dy = self.dy + Constants.ENVIRONMENT_GRAVITY_ACCELERATION * deltaTime
        self.dy = Utils.clamp(self.dy, -self.maxdy, self.maxdy)
    end

    function self.updateOrientation(deltaTime)
        if self.ddx > 0 then -- player is facing right.
            self.sx = math.abs(self.sx)
        elseif self.ddx < 0 then -- player is facing left.
            self.sx = -math.abs(self.sx)
        else --, keep player's last orientation.
        end
    end

    --[[
        Nome: function() (...) end
        Propriedade: Validade da sintaxe.
        Binding Time: Compilação.
        Explicação: A sintaxe correta do bloco
        de função é verificada durante o processo de
        compilação, de acordo com especificação
        da linguagem Lua.
    ]]

    function self.update(deltaTime)
        self.updateMotionX(deltaTime)
        self.updateMotionY(deltaTime)

        self.updatePositionX(deltaTime)
        self.updatePositionY(deltaTime)

        self.updateOrientation(deltaTime)
        self.jump()
    end

    --[[
        Nome: Parâmetro "deltaTime"
        Propriedade: Valor.
        Binding Time: Execução.
        Explicação: Como o valor de "deltaTime"
        é uma variavel local definida na chamada do procedimento
        "self.update", e representa exatamente o tempo 
        desde a última atualização, seu valor é somente 
        determinado em tempo de execução (no momento em que é feita a 
        passagem de parâmetro na chamada da função).
    ]]

    function self.setScoreCallback(scoreCallback)
        self.scoreCallback = scoreCallback
    end

    function self.isGrounded()
        return self.y == Constants.ENVIRONMENT_GROUND_Y
    end

    function self.turnRight()
        self.ddx = 2000/2
    end

    --[[
        Nome: Expressão "2000/2".
        Propriedade: Resultado/Valor.
        Binding Time: Compilação.
        Explicação: Visando otimização, todos
        os cálculos de constantes são realizados
        em tempo de compilação.
    ]]

    function self.turnLeft()
        self.ddx = -1000
    end

    function self.stop()
        self.ddx = 0
    end

    function self.jump()
        if not self.isGrounded() then return end
        self.dy = Constants.PLAYER_JUMP_VELOCITY * randomPower
    end
    
    --[[
        Nome: Bloco 'if'.
        Propriedade: Sintaxe.
        Binding Time: Design.
        Explicação: A sintaxe correta do bloco
        'if' é definida no design da linguagem.
    ]]

    function self.handleInput(deltaTime)
    end

    return self
end

return Enemy
