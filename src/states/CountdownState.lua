--[[
    Transitional state that shows the player a countdown before the game starts
]]

CountdownState = Class{__includes = BaseState}

-- removes from count everytime this threshold is met
COUNTDOWN_TIME = 0.75

function CountdownState:enter(params)
    self.highScores = params.highScores
    self.count = 3
    self.timer = 0
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    -- loop timer back to 0 (plus however far past COUNTDOWN_TIME we've gone)
    -- and decrement the counter once we've gone past the countdown time
    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        gSounds['confirm']:play()

        -- when 0 is reached, enter the PlayState
        if self.count < 0.1 then
            gStateMachine:change('play', {
                highScores = self.highScores
            })
        end
    end
end

function CountdownState:render()
    -- render count big in the middle of the screen
    love.graphics.setFont(gFonts['huge'])
    love.graphics.printf(tostring(self.count), 0, 100, VIRTUAL_WIDTH, 'center')
    
end