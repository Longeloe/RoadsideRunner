--[[
    The PlayState class is the main part of game. Here is where all Obstacles are created/removed.
    The interval in which Obstacles spawn is random and gets smaller (more difficult) as the Score
    increases. Obstacle-type is also chosen randomly.
    The player gets points for every obstacle dodged and also by 'distance' covered.
    The speed of the game also increases with a higher score.
]]

PlayState = Class{__includes = BaseState}

RUNNER_WIDTH = 36
RUNNER_HEIGHT = 48
speedCounter = 200

-- instead of creating another gameState, created a variable to check if game is paused
-- made the variable global so the background movement could be stopped inside main.lua
gGamePaused = false

function PlayState:enter(params)
    self.highScores = params.highScores

    self.runner = Runner()
    self.obstacles = {}
    self.timer = 0
    self.score = 0
    self.distance = 0
    
    -- changes music when this state begins
    gSounds['menu']:stop()
    gSounds['music']:play()
end

function PlayState:update(dt)
    -- created the trigger to pause with the 'P' key
    -- plays the pause audio and pauses music
    if love.keyboard.wasPressed('p') and not gGamePaused then
        gGamePaused = true
        gSounds['pause']:play()
        gSounds['music']:pause()

    -- restarts music
    elseif love.keyboard.wasPressed('p') and gGamePaused then
        gGamePaused = false
        gSounds['pause']:play()
        gSounds['music']:play()
    end

    if not gGamePaused then
        -- update timer for obstacle spawning
        self.timer = self.timer + dt

        -- spawn a new obstacle on a set interval
        if self.timer > 6 then
            -- add a new obstacle at the end of the screen
            table.insert(self.obstacles, 
            Obstacle(math.random(1, #obstacleStats)))

            -- reset timer to a random value so it changes the spawn interval
            -- raises dificulty as score increases
            if self.score < 10000 then
                self.timer = math.random(0, 3)
            elseif self.score < 20000 then
                self.timer = math.random(2, 4)
            elseif self.score < 30000 then
                self.timer = math.random(3, 5)
            else
                self.timer = math.random(4, 5)
            end

        end


        self.distance =  self.distance + dt * -GROUND_SCROLL_SPEED
        -- increases score for distance traveled
        if self.distance > -GROUND_SCROLL_SPEED/3 then
            self.score = self.score + 50
            self.distance = 0
        end

        for k, obstacle in pairs(self.obstacles) do
            -- score a point if the Obstacle has gone past the Runner to the right all the way
            -- be sure to ignore it if it's already been scored
            if not obstacle.scored then
                if obstacle.x > self.runner.x + (RUNNER_WIDTH/2) then
                    self.score = self.score + 1000
                    obstacle.scored = true
                    gSounds['score']:play()
                end
            end

            -- update position of Obstacle
            obstacle:update(dt)
        end

        -- increase speed if score over threshold
        speedUp(self.score)

        -- remove obstacles that already left the screen
        for k, obstacle in pairs(self.obstacles) do
            obstacle.speed = -GROUND_SCROLL_SPEED
            if obstacle.remove then
                table.remove(self.obstacles, k)
            end
        end

        -- simple collision between Runner and all Obstacles
        for k, obstacle in pairs(self.obstacles) do
            if self.runner:collides(obstacle) then
                gSounds['explosion']:play()

                gStateMachine:change('game-over', {
                    score = self.score,
                    highScores = self.highScores
                })
            end
        end

        -- update Runner based on gravity and input
        self.runner:update(dt)

    end
end
function PlayState:render()
    for k, obstacle in pairs(self.obstacles) do
        obstacle:render()
    end

    love.graphics.setFont(gFonts['title'])
    love.graphics.print('Score ' .. tostring(self.score), 8, 6)

    self.runner:render()

    -- show the player the game is paused
    if gGamePaused then
        love.graphics.setFont(gFonts['huge'])
        love.graphics.printf('Game Paused', 0, 50, VIRTUAL_WIDTH, 'center')
    end

end

-- raises the speed as the score increases
function speedUp(score)
    if score > speedCounter then
        speedCounter = speedCounter * 1.4
        BACKGROUND_SCROLL_SPEED = BACKGROUND_SCROLL_SPEED - 5
        GROUND_SCROLL_SPEED = GROUND_SCROLL_SPEED - 10
    end
end