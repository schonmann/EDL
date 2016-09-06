local Utils = require("../util/utils")
local Constants = require("../util/constants")
local GameObject = require("../model/gameobject")
local Assets = require("util/assets")

local function Background(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,maxdy,sx,sy)
    local self = GameObject(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)

    self.image = love.graphics.newImage(Assets.PATH_IMG_BACKGROUND)
    self.w = Constants.BACKGROUND_WIDTH
    self.h = Constants.BACKGROUND_HEIGHT
    self.sx = Constants.BACKGROUND_SCALE
    self.sy = Constants.BACKGROUND_SCALE

    function self.updatePositionX(deltaTime)
        self.x = self.x + self.dx * deltaTime
    end

    function self.updatePositionY(deltaTime)
        self.y = self.y +  self.dy * deltaTime
    end

    function self.updateMotionX(deltaTime)
        self.dx = self.dx + self.ddx * deltaTime
        self.dx = Utils.clamp(self.dx, -self.maxdx, self.maxdx)
    end

    function self.updateMotionY(deltaTime)
        self.dy = self.dy + self.ddy * deltaTime
        self.dy = Utils.clamp(self.dy, -self.maxdy, self.maxdy)
    end

    function self.update(deltaTime)
        self.updateMotionX(deltaTime)
        self.updateMotionY(deltaTime)

        self.updatePositionX(deltaTime)
        self.updatePositionY(deltaTime)
    end

    return self
end

return Background