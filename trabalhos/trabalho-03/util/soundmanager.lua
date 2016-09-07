local Assets = require("../util/assets")

local function SoundManager()
    local self = {}

    local mainMusic = love.audio.newSource(Assets.PATH_MP3_DONNALEE)

    local SFXJumpsLow = {
        love.audio.newSource(Assets.PATH_SFX_JUMP_SML1),
        love.audio.newSource(Assets.PATH_SFX_JUMP_SML2)
    }

    local SFXJumpsHigh = {
        love.audio.newSource(Assets.PATH_SFX_JUMP_HGH1),
        love.audio.newSource(Assets.PATH_SFX_JUMP_HGH2)
    }

    function self.playMainMusic()
        mainMusic:setVolume(0.6)
        mainMusic:setLooping(true)
        mainMusic:play()
    end

    function self.triggerJumpLow()
        SFXJumpsLow[love.math.random(1,2)]:play()
    end

    function self.triggerJumpHigh()
        SFXJumpsHigh[love.math.random(1,2)]:play()
    end 

    return self
end

return SoundManager
