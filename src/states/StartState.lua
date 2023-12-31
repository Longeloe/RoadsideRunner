--[[
    Represents games Start screen.
    The player has 3 options:
]]

StartState = Class{__includes = BaseState}

-- keeps track of which option is highlighted
local highlighted = 1

function StartState:enter(params)
    self.highScores = params.highScores
    gSounds['music']:stop()
    gSounds['menu']:play()
end

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') then
        highlighted = highlighted == 1 and 3 or highlighted - 1
        gSounds['select']:play()
    end

    if love.keyboard.wasPressed('down') then
        highlighted = highlighted == 3 and 1 or highlighted + 1
        gSounds['select']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change('countdown', {
                highScores = self.highScores
            })
        elseif highlighted == 2 then
            gStateMachine:change('high-scores', {
                highScores = self.highScores
            })
        else
            gStateMachine:change('info', {
                highScores = self.highScores
            })
        end
    end

    if key == 'escape' then
        love.event.quit()
    end

end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['title'])
    love.graphics.printf("Roadside Runner", 0, VIRTUAL_HEIGHT / 6,
        VIRTUAL_WIDTH, 'center')
    
    -- options
    love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 40,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 60,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 3 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("INFO", 0, VIRTUAL_HEIGHT / 2 + 80,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Game made by Longeloe",
        0, VIRTUAL_HEIGHT - 25, VIRTUAL_WIDTH, 'center')
end