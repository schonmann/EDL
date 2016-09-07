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
    end

    function self.setImage(image)
        self.image = image
    end

    function self.setDx(dx)
        self.dx = dx
    end

    return self
end

return AbstractGameObject
