local Utils = require("../util/utils")
local Constants = require("../util/constants")
local GameObject = require("../model/gameobject")
local Assets = require("util/assets")

-- Player Class -- 

local function Player(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)
    local self = GameObject(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)

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
        print(self.x)
        self.x = self.x + self.dx * deltaTime
        self.x = Utils.clamp(self.x, BOUNDS_LEFT, BOUNDS_RIGHT)
    end

    function self.updatePositionY(deltaTime)
        self.y = self.y +  self.dy * deltaTime
        self.y = Utils.clamp(self.y, BOUNDS_TOP, BOUNDS_BOT)
    end

    function self.updateMotionX(deltaTime)
        if self.x == BOUNDS_LEFT or self.x == BOUNDS_RIGHT then
            self.dx = - self.dx
            self.ddx = - self.ddx
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

    function self.handleInput(deltaTime)
        if love.keyboard.isDown("left") then playerObject.ddx = -600
        elseif love.keyboard.isDown("right") then playerObject.ddx = 600
        else playerObject.ddx = 0 end

        if love.keyboard.isDown("space") and self.isGrounded() then
            self.dy = Constants.PLAYER_JUMP_VELOCITY
        end
    end

    return self
end

return Player