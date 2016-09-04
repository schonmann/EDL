-- Player Class -- 

Player = {
    x = 0, 
    y = 0,
    dx = 0, 
    dy = 0, 
    image = nil, 
    sx = 3, 
    sy = 3
}

function Player:new(o,image,x,y,dx,dy,sx,sy)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    self.x = x or 0
    self.y = y or 0
    self.dx = dx or 0
    self.dy = dy or 0
    self.image = image or nil
    self.sx = sx or 3
    self.sy = sy or 3
    return o
end

function Player:setPosition(x,y)
    self.x = x
    self.y = y
end
