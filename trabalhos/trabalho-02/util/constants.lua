local Constants = {}

Constants.VIEWPORT_WIDTH = 800
Constants.VIEWPORT_HEIGHT = 600
Constants.GAME_TITLE = "EDL - Trabalho 02"

Constants.ENVIRONMENT_GRAVITY_ACCELERATION = 1750
Constants.ENVIRONMENT_GROUND_Y = 3*Constants.VIEWPORT_HEIGHT/4.0

-- Game object constants.

Constants.PLAYER_START_X = Constants.VIEWPORT_WIDTH/2.0
Constants.PLAYER_START_Y = Constants.ENVIRONMENT_GROUND_Y
Constants.PLAYER_JUMP_VELOCITY = -1500
Constants.PLAYER_WIDTH = 32
Constants.PLAYER_HEIGHT = 32
Constants.PLAYER_FRICTION_X = 20
Constants.PLAYER_FRICTION_Y = 20
Constants.PLAYER_MAX_DX = 1200
Constants.PLAYER_MAX_DY = 1200
Constants.PLAYER_SCALE = 2
Constants.PLAYER_MAX_JUMP_PWR = 1.0
Constants.PLAYER_MIN_JUMP_PWR = 0.3
Constants.PLAYER_CAN_FLY = false

Constants.BACKGROUND_WIDTH = 400
Constants.BACKGROUND_HEIGHT = 300
Constants.BACKGROUND_DX = {3.5, 6.0, 10.0}
Constants.BACKGROUND_SCALE = 2
Constants.BACKGROUND_LAYER_NUMBER = 3

return Constants