local Utils = require("../util/utils")
local Constants = require("../util/constants")
local AbstractGameObject = require("../model/abstractgameobject")
local Assets = require("util/assets")

local function Background(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,maxdy,sx,sy)
    local self = AbstractGameObject(o,image,x,y,w,h,fx,fy,dx,dy,ddx,ddy,maxdx,maxdy,sx,sy)

    function self.init()
        self.image = love.graphics.newImage(Assets.PATH_IMG_BACKGROUND)
        
        -- [[ Infinite scrolling background! =) ]]
        
        self.scrlX = 0
        self.image:setWrap("repeat", "clamp")
        self.quad = love.graphics.newQuad(0,0,Constants.BACKGROUND_WIDTH, Constants.BACKGROUND_HEIGHT,
            self.image:getWidth(), self.image:getHeight())
        
        self.x = Constants.BACKGROUND_WIDTH
        self.y = Constants.BACKGROUND_HEIGHT
        self.w = Constants.BACKGROUND_WIDTH
        self.h = Constants.BACKGROUND_HEIGHT
        self.sx = Constants.BACKGROUND_SCALE
        self.sy = Constants.BACKGROUND_SCALE
        self.dx = Constants.BACKGROUND_DX

    end
    
    self.init()

    function self.updatePositionX(deltaTime)
        self.scrlX = self.scrlX + self.dx * deltaTime
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

        self.quad:setViewport(self.dx * self.scrlX, 0, Constants.BACKGROUND_WIDTH, self.image:getHeight())
    end

    function self.handleInput(deltaTime)
        -- Empty implementation.
    end

    return self
end

return Background