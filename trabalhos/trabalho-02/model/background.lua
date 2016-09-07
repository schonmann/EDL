local Utils = require("../util/utils")
local Constants = require("../util/constants")
local AbstractGameObject = require("../model/abstractgameobject")
local BackgroundLayer = require("../model/backgroundlayer")
local Assets = require("util/assets")

local function Background()

    local self = {}
    self.layers = {}

    function self.initLayers()
        for i=1,Constants.BACKGROUND_LAYER_NUMBER do
            local img_pth = Assets.PATH_IMG_BACKGROUND[i]
            local img = love.graphics.newImage(img_pth)
            local bg = BackgroundLayer(nil, img)
            bg.setDx(Constants.BACKGROUND_DX[i])
            table.insert(self.layers, bg)
        end
    end

    function self.init()
        self.initLayers()
    end

    self.init()
    
    function self.draw()
        for i,o in pairs(self.layers) do
            o.draw()
        end
    end

    function self.update(deltaTime)
        for i,o in pairs(self.layers) do
            o.update(deltaTime)
        end
    end

    function self.handleInput(deltaTime)
        -- Empty implementation.
    end

    return self
end

return Background