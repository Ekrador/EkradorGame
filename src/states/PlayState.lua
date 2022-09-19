PlayState = Class{__includes = BaseState}

function PlayState:init()
       
end

function PlayState:enter(params)
    self.camX = 0
    self.camY = 0
    self.level = Level(LEVEL_DEF['city'])
    
    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        mapX = 3,
        mapY = 5,
        width = 32,
        height = 39,
        speed = ENTITY_DEFS['player'].speed,
        health = ENTITY_DEFS['player'].health,
        level = self.level
    }
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.level) end,
        ['idle'] = function() return PlayerIdleState(self.player, self.level) end
    }
    

    self.level:generateTileMap()
    self.map = self.level.map
    self.player.level = self.level
    self.player.stateMachine:change('idle')
    self.level:generateEntities()

end

function PlayState:update(dt)
    self.level:update(dt)
    self.player:update(dt)
    self:updateCamera()
    to_grid_coordinate(self.player.x + self.player.mmx - self.player.width/2, self.player.y + self.player.mmy - self.player.height)
end

function PlayState:updateCamera()
    self.camX = self.player.x
    self.camY = self.player.y 

end

function PlayState:render()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.level:render()  
    for y = 1, self.level.mapSize do
        for x = 1, self.level.mapSize do
            self:renderCollidable(x,y)
        end
    end
    self.player:render() 
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2 + self.player.moveboxX, VIRTUAL_HEIGHT/2+ self.player.moveboxY, 8, 6)
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2 + self.player.x, VIRTUAL_HEIGHT/2+ self.player.y, self.player.width, self.player.height)
    love.graphics.print(tostring(self.player.mapX)..'  '..tostring(self.player.mapY), gFonts['medium'], self.camX, self.camY)
    love.graphics.print(tostring(self.player.x)..'  '..tostring(self.player.y), gFonts['medium'], self.camX, self.camY + 10)
    love.graphics.print(tostring(mx)..'  '..tostring(my), gFonts['medium'], self.camX, self.camY + 20)
    love.graphics.print(tostring(self.player.mmx)..'  '..tostring(self.player.mmy), gFonts['medium'], self.camX, self.camY +30)
    love.graphics.print(tostring(mxx)..'  '..tostring(myy), gFonts['medium'], self.camX, self.camY +40)
    love.graphics.print(tostring(self.level.qwer), gFonts['medium'],self.camX, self.camY + 50)
    
end

function PlayState:renderCollidable(x,y)
    if (y - self.player.mapY < self.level.map.tiles[y][x].height/GROUND_HEIGHT  and
    y - self.player.mapY >= 0) and
    (x - self.player.mapX >= 0 and 
    x - self.player.mapX < self.level.map.tiles[y][x].height/GROUND_HEIGHT) and
    self.level.map.tiles[y][x]:collidable() then
        love.graphics.setColor(255, 255, 255, 0.5)        
    end
    if self.level.map.tiles[y][x]:collidable() then
        love.graphics.draw(TILE_IDS[self.level.map.tiles[y][x].id], 
        math.floor(VIRTUAL_WIDTH / 2 + (x-1)*0.5*GROUND_WIDTH + (y-1)*-1*GROUND_WIDTH*0.5),
        math.floor(VIRTUAL_HEIGHT / 2 + (x-1)*0.5*GROUND_HEIGHT+ (y-1)*0.5*GROUND_HEIGHT)- self.level.map.tiles[y][x].height + GROUND_HEIGHT)
    end
    love.graphics.setColor(255, 255, 255, 1)
end

half = self.player.mapY + self.player.mapX
self.player.mapY
self.player.mapX
gridX = 0
gridY = 0
delay = half - self.level.mapSize
decreaseX = 1
if half <= self.level.mapSize then
    gridX = half - 1
    gridY = half - 1   
else 
    gridX = self.level.mapSize
    gridY = half - self.level.mapSize
    decreaseX = delay
end

for y = 1, gridY do
    for x = 1, gridX do
        self.level:render()
    end
    if decreaseX == 1 then
        gridX = gridX - 1
    else
        decreaseX = decreaseX - 1
    end
end

self.player:render()

for y = delay >= 1 and delay + 1 or 1, self.level.mapSize do
    for x = half < self.level.mapSize and half or self.level.mapSize, self.level.mapSize do
        