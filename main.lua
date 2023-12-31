--[[
    CS50 2023 --- Final Project

    Roadside Runner

    Author: Eduardo Reis "Longeloe"

    An infite-runner type of game based on the child day-dream of having a character
    running alongside the car while you are looking outside your window from the backseat.

    For this project I used some files from CS50's Intro to gamedev lessons as a starting point
    but all the code was written by myself.

    Most of the sounds, including the Menu and Gameplay music, were created by me using Bfxr (for effects)
    and Beepbox (for music).

    All of the game art was downloaded from https://opengameart.org/ and
    here are all the artist's names:
    Background/Hydrant - CraftPix.net 2D Game Assets - https://opengameart.org/users/craftpixnet-2d-game-assets
    Wasp - Tiamalt - https://opengameart.org/users/tiamalt
    Trashcan - dant-e - https://opengameart.org/users/dant-e
    Runner - bevouliin - https://opengameart.org/users/bevouliincom

    The font used was downloaded from https://www.1001freefonts.com/raider-crusader.font and was crated by Iconian Fonts.

    Hope you enjoy the game. I had a great time creating it!
]]





-- Added a Dependencies file to make main file less bulky
require 'src/Dependencies'

local background = love.graphics.newImage('graphics/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('graphics/foreground.png')
local groundScroll = 0

function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest', 16)

    -- seed the RNG
    math.randomseed(os.time())

    -- app window title
    love.window.setTitle('Roadside Runner')

    love.graphics.setFont(gFonts['title'])

    -- kick off music
    gSounds['menu']:setLooping(true)
    gSounds['music']:setLooping(true)
    musicOn = true

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['info'] = function() return InfoState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end,
        ['high-scores'] = function() return HighScoreState() end,
        ['enter-high-score'] = function() return EnterHighScoreState() end,
    }
    gStateMachine:change('start', {
        highScores = loadHighScores()
    })

    -- initialize input table
    love.keyboard.keysPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    -- stops the background movement if the game is paused
    if not gGamePaused then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % 512
    end

    if love.keyboard.wasPressed('m') and musicOn then
        musicOn = false
        gSounds['pause']:play()
        gSounds['music']:pause()
        gSounds['menu']:pause()
    elseif love.keyboard.wasPressed('m') and not musicOn then
        musicOn = true
        gSounds['pause']:play()
        gSounds['music']:play()
    end

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}

end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, 0)
    gStateMachine:render()

    push:finish()
end


-- Function that allows for a 'savefile' to be created containing all of the highscores
-- if a file already exists, it is loaded into the game.
function loadHighScores()
    love.filesystem.setIdentity('roadsideRunner')

    -- if the file doesn't exist, initialize it with some default scores
    if not love.filesystem.getInfo('roadsideRunner.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'LGL\n'
            scores = scores .. tostring(i * 3500) .. '\n'
        end

        love.filesystem.write('roadsideRunner.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('roadsideRunner.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores
end

function renderScore(score)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score:', VIRTUAL_WIDTH - 60, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end