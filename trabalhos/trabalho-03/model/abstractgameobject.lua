local Constants = require("../util/constants")

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
    self.hostile = false

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
            local r = self.getRect()

        if Constants.DEBUG then
            love.graphics.setColor( 130, 40, 140 )
            love.graphics.rectangle("line",r.x1,r.y1,r.x2-r.x1,r.y2-r.y1)
            love.graphics.setColor( 255, 255, 255)
        end
    end

    function self.setImage(image)
        self.image = image
    end

    function self.setDx(dx)
        self.dx = dx
    end

    function self.getRect()
        return {
            x1 = self.x - self.sx*self.w/2, 
            y1 = self.y - self.sy*self.h/2,  
            x2 = self.x + self.sx*self.w/2, 
            y2 = self.y + self.sy*self.h/2
        }
    end

    function self.collidesWith(obj)
        local r1 = self.getRect()
        local r2 = obj.getRect()
        
        if  r1.x2 < r2.x1 or r1.x1 > r2.x2 or
            r1.y2 < r2.y1 or r1.y1 > r2.y2 then
            return false
        end

        print("Collision!")
        print("R1!: ",r1.x1,r1.y1,r1.x2,r1.y2)
        print("F2!: ",r2.x1,r2.y1,r2.x2,r2.y2)

        return true
    end

    return self
end

return AbstractGameObject
