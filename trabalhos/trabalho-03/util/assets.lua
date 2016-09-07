local Assets = {}

Assets.DIR = "assets/"

Assets.PATH_IMG_PLAYER = Assets.DIR .. "char.png"
Assets.PATH_IMG_ENEMY = Assets.DIR .. "enemy.png"
Assets.PATH_IMG_BACKGROUND = {Assets.DIR .. "bg.png", Assets.DIR .. "bg1.png", Assets.DIR .. "bg2.png"}

Assets.PATH_MP3_DONNALEE = Assets.DIR .. "donnalee.mp3"

-- Sounds by dklon (http://opengameart.org/content/platformer-jumping-sounds)

Assets.PATH_SFX_JUMP_SML1 = Assets.DIR .. "jump_sml_01.wav"
Assets.PATH_SFX_JUMP_SML2 = Assets.DIR .. "jump_sml_02.wav"
Assets.PATH_SFX_JUMP_HGH1 = Assets.DIR .. "jump_hgh_01.wav"
Assets.PATH_SFX_JUMP_HGH2 = Assets.DIR .. "jump_hgh_02.wav"

return Assets
