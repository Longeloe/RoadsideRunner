--[[
    Runner Class

    The Runner that the player controls using the Up/Down arrowkeys. Inside this file
    there is also the logic behind the collision system, which adapts based on what animation
    the player is currently on.
]]

Runner = Class{}

local GRAVITY = 560
local jumpPower = 320

function Runner:init()
    
    self.frameCounter = 1
    self.timer = 0

    self.x = VIRTUAL_WIDTH - 100
    self.y = gGroundY

    self.anim = 'run'
    self.width = playerAnim[self.anim][self.frameCounter]:getWidth()
    self.height = playerAnim[self.anim][self.frameCounter]:getHeight()

    self.dy = 0

    isRolling = false
end

function Runner:collides(obstacle)
    --[[
        This AABB-type collision is configured so that only when rolling the player can get under the flying obstacle.
        Added some offsets on both equations so that it worked better.
    ]]
    if self.anim == 'roll' then
        if (self.x) + (self.width) - 10 >= obstacle.x and self.x <= obstacle.x + obstacle.width - 12 then
            if (self.y) + (self.height) - 10 >= obstacle.y and self.y + 40 <= obstacle.y + obstacle.height then
                return true
            end
        end
    else
        if (self.x) + (self.width) - 10 >= obstacle.x and self.x <= obstacle.x + obstacle.width - 12 then
            if (self.y) + (self.height) - 10 >= obstacle.y and self.y <= obstacle.y + obstacle.height then
                return true
            end
        end
    end

    return false
end

function Runner:update(dt)

    -- jump when the Up arrow is pressed.
    if (love.keyboard.wasPressed('up')) and self.y == gGroundY then
        self.dy = -jumpPower
        gSounds['jump']:play()
        
    end

    -- roll when the Down arrow is pressed
    if love.keyboard.wasPressed('down') and self.y == gGroundY and self.anim == 'run' then
        gSounds['roll']:play()
        self.frameCounter = 1
        self.anim = 'roll'
    end

    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy * dt

    -- change animation back to Run when rolling animation is finished
    if self.frameCounter >= 36 then
        self.anim = 'run'
    end

    if self.dy > 0 then
        self.y = math.min(gGroundY, self.y + self.dy * dt)
    end

    -- timer-based frame changed for all Runner animations
    self.timer = self.timer + dt
    if self.timer > playerAnim[self.anim].freq then
        self.timer = 0
        if self.frameCounter >= #playerAnim[self.anim] then
            self.frameCounter = 1
        else
            self.frameCounter = self.frameCounter + 1
        end
    end
end

function Runner:render()
    -- adds a little offset to the roll animation images so that it looks better
    if self.anim == 'roll' then
        love.graphics.draw(playerAnim[self.anim][self.frameCounter], self.x, self.y, 0, 1, 1, 21, -2)
    else
        love.graphics.draw(playerAnim[self.anim][self.frameCounter], self.x, self.y)
    end
    
end