local Constants = {}

Constants.VIEWPORT_WIDTH = 800
Constants.VIEWPORT_HEIGHT = 600
Constants.GAME_TITLE = "EDL - Trabalho 02"

Constants.ENVIRONMENT_GRAVITY_ACCELERATION = 500
Constants.ENVIRONMENT_GROUND_Y = 2*Constants.VIEWPORT_HEIGHT/3.0

-- Game object constants.

Constants.PLAYER_START_X = Constants.VIEWPORT_WIDTH/2.0
Constants.PLAYER_START_Y = Constants.ENVIRONMENT_GROUND_Y
Constants.PLAYER_JUMP_VELOCITY = -375
Constants.PLAYER_WIDTH = 32
Constants.PLAYER_HEIGHT = 32
Constants.PLAYER_FRICTION_X = 20
Constants.PLAYER_FRICTION_Y = 20
Constants.PLAYER_MAX_DX = 500
Constants.PLAYER_MAX_DY = 500
Constants.PLAYER_SCALE = 2
Constants.PLAYER_MAX_JUMP_PWR = 1.8
Constants.PLAYER_MIN_JUMP_PWR = 0.6
Constants.PLAYER_CAN_FLY = true

Constants.BACKGROUND_WIDTH = 400
Constants.BACKGROUND_HEIGHT = 300
Constants.BACKGROUND_SCALE = 4

return Constants