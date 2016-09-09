local Constants = require("../util/constants")
local Utils = require("../util/utils")

local function AbstractGameObject(o,image,x,y,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)
    local self = {}
    
    -- Fields.

    self.x = x or 0
    self.y = y or 0
    self.w = w or 0
    self.h = h or 0
    self.fx = fx or 0
    self.fy = fy or 0
    self.dx = dx or 0
    self.dy = dy or 0
    self.ddx = ddx or 0
    self.ddy = ddy or 0
    self.maxdx = maxdx or 1000
    self.maxdy = maxdy or 1000
    self.image = image or nil
    self.sx = sx or 1
    self.sy = sy or 1
    self.hitboxFactor = 1

    -- Methods.

    function self.draw()
        love.graphics.draw(
            self.image, 
            self.x, 
            self.y, 
            self.r,
            self.sx,
            self.sy,
            self.w/2,
            self.h/2)

        if Constants.DEBUG then
            local c = self.getCircle()
            love.graphics.setColor( 130, 40, 140 )
            love.graphics.circle("line", c.x, c.y, c.r)
            love.graphics.setColor( 255, 255, 255)
        end
    end

    function self.setImage(image)
        self.image = image
    end

    function self.setDx(dx)
        self.dx = dx
    end

    function self.getCircle()
        return {x = self.x, y = self.y, r = math.abs(self.w*self.sx/2) * self.hitboxFactor}
    end

    function self.collidesWith(obj)
        local c1 = self.getCircle()
        local c2 = obj.getCircle()
        
        if Utils.distance(c1.x,c1.y,c2.x,c2.y) > c1.r + c2.r then
            return false
        end

        return true
    end

    return self
end

return AbstractGameObject
