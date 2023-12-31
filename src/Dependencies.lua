-- used to better fit the game to the screen
push = require 'lib/push'

Class = require 'lib/class'

-- constants
require 'src/Constants'

-- the obstacles to be dodged
require 'src/Obstacle'

-- the player-controlled runner
require 'src/Runner'

-- simple StateMachine that allows for better code readability and organization
require 'src/StateMachine'

-- each of the individual states in the game
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/CountdownState'
require 'src/states/PlayState'
require 'src/states/HighScoreState'
require 'src/states/InfoState'
require 'src/states/GameOverState'
require 'src/states/EnterHighScoreState'

-- initialize fonts
gFonts = {
    ['small'] = love.graphics.newFont('fonts/main.ttf', 12),
    ['controls'] = love.graphics.newFont('fonts/main.ttf', 14),
    ['medium'] = love.graphics.newFont('fonts/main.ttf', 16),
    ['title'] = love.graphics.newFont('fonts/main.ttf', 34),
    ['huge'] = love.graphics.newFont('fonts/main.ttf', 70)
}

-- initialize our table of sounds
gSounds = {
    ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
    ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['roll'] = love.audio.newSource('sounds/roll.wav', 'static'),
    ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
    ['back'] = love.audio.newSource('sounds/back.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
    ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
    ['menu'] = love.audio.newSource('sounds/menu.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/main_theme.wav', 'static')
}

-- load player animations
require 'src/playerAnimations'

-- load obstacle images and stats
require 'src/obstacleStats'