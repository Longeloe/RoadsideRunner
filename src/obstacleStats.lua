--[[
    File that holds all of the different stats and images for the obstacles.
    Organized in this way, it is easier to add new obstacles, without having to change much of the other files.
]]

-- the first table has obstacles with numbers as keys so that they can be chosen at
-- random straight from the PlayState.
obstacleStats = {
    [1] = {
        id = 'hydrant',
        y = gGroundY,
        width = 47,
        height = 58,
        frameFreq = 100
    },
    [2] = {
        id = 'trash',
        y = gGroundY,
        width = 47,
        height = 54,
        frameFreq = 100
    },
    [3] = {
        id = 'wasp',
        y = gGroundY - 40,
        width = 36,
        height = 56,
        frameFreq = 0.01
    }
}


-- this second table holds all different images for the obstacles, having their 'id' (name) as keys.
-- for now, only the wasp obstacle has different frames.
obstacleIMG = {
    ['hydrant'] = {
        [1] = love.graphics.newImage('graphics/Obstacles/hydrant.png')
    },
    ['trash'] = {
        [1] = love.graphics.newImage('graphics/Obstacles/trash_can.png')
    },
    ['wasp'] = {
        [1] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp1.png'),
        [2] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp3.png'),
        [3] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp4.png'),
        [4] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp5.png'),
        [5] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp6.png'),
        [6] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp7.png'),
        [7] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp8.png'),
        [8] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp9.png'),
        [9] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp10.png'),
        [10] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp11.png'),
        [11] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp12.png'),
        [12] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp13.png'),
        [13] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp14.png'),
        [14] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp15.png'),
        [15] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp16.png'),
        [16] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp17.png'),
        [17] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp18.png'),
        [18] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp19.png'),
        [19] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp20.png'),
        [20] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp21.png'),
        [21] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp22.png'),
        [22] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp23.png'),
        [23] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp24.png'),
        [24] = love.graphics.newImage('graphics/Obstacles/Wasp/wasp25.png')
    }
}