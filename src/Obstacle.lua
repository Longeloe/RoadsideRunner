--[[
    Obstacle Class

    Represents the obstacles the player needs to avoid. They are created randomly using a random index 
    assigned during instantiation (inside the PlayState). Each obstacle has a different image and stats,
    that are imported from a different file for readability/organization purposes.
]]

Obstacle = Class{}

function Obstacle:init(index)
    self.x = 0 - 40

    -- flag to hold whether this obstacle has been scored (jumped over/rolled under)
    self.scored = false

    self.speed = 80

    -- whether this obstacle is ready to be removed from the scene
    self.remove = false

    self.id = obstacleStats[index].id
    self.y = obstacleStats[index].y
    self.width = obstacleStats[index].width
    self.height = obstacleStats[index].height
    self.frameFreq = obstacleStats[index].frameFreq

    self.frameCounter = 1
    self.timer = 0
    
end

function Obstacle:update(dt)
    -- remove the obstacle from the scene if it's beyond the right edge of the screen,
    -- else move it from left to right
    if self.x <= VIRTUAL_WIDTH then
        self.x = self.x + self.speed * dt
    else
        self.remove = true
    end

    -- timer-based frame changed for all Obstacle animations
    self.timer = self.timer + dt
    if self.timer > self.frameFreq then
        self.timer = 0
        if self.frameCounter >= #obstacleIMG[self.id] then
            self.frameCounter = 1
        else
            self.frameCounter = self.frameCounter + 1
        end
    end
end

function Obstacle:render()
    love.graphics.draw(obstacleIMG[self.id][self.frameCounter], self.x, self.y)
end