local util = require("../util/util")
local constants = require("../util/constants")

-- Player Class -- 

local ENV_VAR = {}

Player = {
    x = 0, 
    y = 0,
    fx = 0,
    fy = 0,
    dx = 0, 
    dy = 0,
    ddx = 0,
    ddy = 0,
    maxdx = 0,
    maxdy = 0,
    image = nil, 
    sx = 0, 
    sy = 0
}

function Player:new(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    self.x = x or constants.PLAYER_START_X
    self.y = y or constants.PLAYER_START_Y
    self.w = w or constants.PLAYER_WIDTH
    self.h = h or constants.PLAYER_HEIGHT
    self.fx = fx or constants.PLAYER_FRICTION_X
    self.fy = fy or constants.PLAYER_FRICTION_Y
    self.dx = dx or 0
    self.dy = dy or 0
    self.ddx = ddx or 0
    self.ddy = ddy or 0
    self.maxdx = maxdx or constants.PLAYER_MAX_DX
    self.maxdy = maxdy or constants.PLAYER_MAX_DY
    self.image = image or nil
    self.sx = sx or constants.PLAYER_SCALE
    self.sy = sy or constants.PLAYER_SCALE

    ENV_VAR.BOUNDS_LEFT = self.w * math.abs(self.sx)/2
    ENV_VAR.BOUNDS_RIGHT = constants.VIEWPORT_WIDTH - self.w * math.abs(self.sx)/2
    ENV_VAR.BOUNDS_TOP = self.h*math.abs(self.sy)/2
    ENV_VAR.BOUNDS_BOT = constants.GROUND_Y

    return o
end

function Player:applyFriction(deltaTime)
    if self.dx > 0 then
        self.dx = util.max(0, self.dx - constants.PLAYER_FRICTION_X * deltaTime)
    elseif self.dx < 0 then
        self.dx = util.min(0, self.dx + constants.PLAYER_FRICTION_X * deltaTime) 
    end
end

function Player:updatePositionX(deltaTime)
    self.x = self.x +  self.dx * deltaTime
    self.x = util.clamp(self.x, ENV_VAR.BOUNDS_LEFT, ENV_VAR.BOUNDS_RIGHT)
end

function Player:updatePositionY(deltaTime)
    self.y = self.y +  self.dy * deltaTime
    self.y = util.clamp(self.y, ENV_VAR.BOUNDS_TOP, ENV_VAR.BOUNDS_BOT)
end

function Player:updateMotionX(deltaTime)
    if self.x == ENV_VAR.BOUNDS_LEFT or self.x == ENV_VAR.BOUNDS_RIGHT then
        self.dx = - self.dx
        self.ddx = - self.ddx
    end

    self.dx = self.dx + self.ddx * deltaTime
    self.dx = util.clamp(self.dx, -self.maxdx, self.maxdx)
end

function Player:updateMotionY(deltaTime)
    self.dy = self.dy + self.ddy * deltaTime
    self.dy = self.dy + constants.GRAVITY_ACCELERATION * deltaTime
    self.dy = util.clamp(self.dy, -self.maxdy, self.maxdy)
end

function Player:updateOrientation(deltaTime)
    if self.ddx > 0 then -- player is facing right.
        self.sx = math.abs(self.sx)
    elseif self.ddx < 0 then -- player is facing left.
        self.sx = -math.abs(self.sx)
    else --, keep player's last orientation.
    end
end

function Player:update(deltaTime)
    self:applyFriction(deltaTime)

    self:updateMotionX(deltaTime)
    self:updateMotionY(deltaTime)

    self:updatePositionX(deltaTime)
    self:updatePositionY(deltaTime)

    self:updateOrientation(deltaTime)
end

function Player:isGrounded()
    return self.y == constants.GROUND_Y
end

function Player:handleInput(deltaTime)
    if love.keyboard.isDown("left") then
        playerObject.ddx = -600
    elseif love.keyboard.isDown("right") then
        playerObject.ddx = 600
    else 
        playerObject.ddx = 0
    end

    if love.keyboard.isDown("space") and self:isGrounded() then
        self.dy = constants.PLAYER_JUMP_VELOCITY
    end
end