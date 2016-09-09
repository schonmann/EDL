local Utils = require("../util/utils")
local Constants = require("../util/constants")
local AbstractGameObject = require("../model/abstractgameobject")
local Assets = require("util/assets")

-- Player Class -- 

local function Player(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)
    local self = AbstractGameObject(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)

    function self.init()
        self.image = love.graphics.newImage(Assets.PATH_IMG_PLAYER)
        self.w = Constants.PLAYER_WIDTH
        self.h = Constants.PLAYER_HEIGHT
        self.x = Constants.PLAYER_START_X
        self.y = Constants.PLAYER_START_Y
        self.fx = Constants.PLAYER_FRICTION_X
        self.fy = Constants.PLAYER_FRICTION_Y
        self.maxdx = Constants.PLAYER_MAX_DX
        self.maxdy = Constants.PLAYER_MAX_DY
        self.sx = Constants.PLAYER_SCALE
        self.sy = Constants.PLAYER_SCALE
        self.isPlaying = false
    end

    self.init()

    local BOUNDS_LEFT = self.sx*self.w/2.0
    local BOUNDS_RIGHT = Constants.VIEWPORT_WIDTH - self.sx*self.w/2.0
    local BOUNDS_BOT = Constants.ENVIRONMENT_GROUND_Y
    local BOUNDS_TOP = self.sx*self.h/2.0
    
    function self.applyFriction(deltaTime)
        if self.dx > 0 then
            self.dx = Utils.max(0, self.dx - Constants.PLAYER_FRICTION_X * deltaTime)
        elseif self.dx < 0 then
            self.dx = Utils.min(0, self.dx + Constants.PLAYER_FRICTION_X * deltaTime) 
        end
    end

    function self.updatePositionX(deltaTime)
        self.x = self.x + self.dx * deltaTime
        self.x = Utils.clamp(self.x, BOUNDS_LEFT, BOUNDS_RIGHT)
    end

    function self.updatePositionY(deltaTime)
        self.y = self.y +  self.dy * deltaTime
        self.y = Utils.clamp(self.y, BOUNDS_TOP, BOUNDS_BOT)
    end

    function self.updateMotionX(deltaTime)
        if self.x == BOUNDS_LEFT or self.x == BOUNDS_RIGHT then
            self.dx = - self.dx/2
            self.ddx = self.ddx/2
        end

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

    function self.update(deltaTime)
        self.applyFriction(deltaTime)

        self.updateMotionX(deltaTime)
        self.updateMotionY(deltaTime)

        self.updatePositionX(deltaTime)
        self.updatePositionY(deltaTime)

        self.updateOrientation(deltaTime)
    end

    function self.isGrounded()
        return self.y == Constants.ENVIRONMENT_GROUND_Y
    end

    function self.turnRight()
        self.ddx = 1000
    end

    function self.turnLeft()
        self.ddx = -1000
    end

    function self.stop()
        self.ddx = 0
    end

    function manageJumpSound(power)
        if power > (Constants.PLAYER_MIN_JUMP_PWR + Constants.PLAYER_MAX_JUMP_PWR)/3 then
            soundManager.triggerJumpHigh()
        else
            soundManager.triggerJumpLow()
        end
    end

    function self.jump(timePressed)
        if not Constants.PLAYER_CAN_FLY and not self.isGrounded() then return end
        local power = Utils.clamp(timePressed/0.3, Constants.PLAYER_MIN_JUMP_PWR, Constants.PLAYER_MAX_JUMP_PWR)
        self.dy = Constants.PLAYER_JUMP_VELOCITY * power
        manageJumpSound(power)
    end

    local spaceDownDt = -1;
    local spaceUpDt = -1;

    function self.handleInput(deltaTime)

        if love.keyboard.isDown("left") then self.turnLeft()
        elseif love.keyboard.isDown("right") then self.turnRight()
        else self.stop()
        end

        function love.keypressed(key)
            if key == "space" then
                spaceDownDt = love.timer.getTime()
                if not self.playing then
                    self.playing = true
                end
            end
        end

        function love.keyreleased(key)
            if key == "space" then
                spaceUpDt = love.timer.getTime()
                if spaceDownDt ~= -1 then
                    self.jump(spaceUpDt - spaceDownDt)
                end
            end
        end
    end

    function self.isPlaying()
        return self.playing
    end

    return self
end

return Player