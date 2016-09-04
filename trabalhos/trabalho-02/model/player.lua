local util = require("../util/util")
local constants = require("../util/constants")

-- Player Class -- 

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
    image = nil, 
    sx = 0, 
    sy = 0
}

function Player:new(o,image,x,y,fx,fy,dx,dy,ddx,ddy,maxdx,sx,sy)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    self.x = x or constants.PLAYER_START_X
    self.y = y or constants.PLAYER_START_Y
    self.fx = fx or constants.PLAYER_FRICTION_X
    self.fy = fy or constants.PLAYER_FRICTION_Y
    self.dx = dx or 0
    self.dy = dy or 0
    self.ddx = ddx or 0
    self.ddy = ddy or 0
    self.maxdx = maxdx or constants.PLAYER_MAX_DX
    self.image = image or nil
    self.sx = sx or constants.PLAYER_SCALE
    self.sy = sy or constants.PLAYER_SCALE
    return o
end

function Player:applyFriction(deltaTime)
    if self.dx > 0 then
        self.dx = util.max(0, self.dx - constants.PLAYER_FRICTION_X * deltaTime)
    elseif self.dx < 0 then
        self.dx = util.min(0, self.dx + constants.PLAYER_FRICTION_X * deltaTime) 
    end
end

function Player:updateMotion(deltaTime)
    self.dx = self.dx + self.ddx * deltaTime
    self.dx = util.clamp(self.dx, - self.maxdx, self.maxdx)
    self.x = self.x +  self.dx*deltaTime
end

function Player:update(deltaTime)
    self:applyFriction(deltaTime)
    self:updateMotion(deltaTime)

    print("ddx: " .. self.ddx .. " dx: " .. self.dx)
end