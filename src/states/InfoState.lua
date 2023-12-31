--[[
    Shows game controls and objective for the player
    Transitions back to Start screen when Esc is pressed
]]

InfoState = Class{__includes = BaseState}

function InfoState:enter(params)
    self.highScores = params.highScores
end

function InfoState:update(dt)
    -- return to the start screen if we press escape
    if love.keyboard.wasPressed('escape') then
        gSounds['back']:play()
        
        gStateMachine:change('start', {
            highScores = self.highScores
        })
    end
end

function InfoState:render()
    love.graphics.setFont(gFonts['title'])
    love.graphics.printf('Objective', 0, 15, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Dodge the incoming obstacles by",
        0, 65, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("jumping or rolling",
        0, 85, VIRTUAL_WIDTH, 'center')


    love.graphics.setFont(gFonts['title'])
    love.graphics.printf('Controls', 0, 120, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Up arrow - Jump",
        0, 160, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("Down arrow - Roll",
        0, 180, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("P - Pause",
        0, 200, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("M - Stop/Play Music",
        0, 220, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("Press ESC to return to the main menu!",
        0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')
end
