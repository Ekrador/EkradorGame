StartState = Class{__includes = BaseState}

function StartState:init()
    mapSize = 10
    self.camX = 0
    self.camY = 0
    self.level = Level(LEVEL_DEF['city'])
 
    
end

function StartState:update(dt)
    self.level:update(dt)
    self:updateCamera()
end

function StartState:updateCamera()
    self.camX = math.floor(self.level.player.x)
    self.camY = math.floor(self.level.player.y)


end

function StartState:render()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.level:render()   
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2 + self.level.player.moveboxX, VIRTUAL_HEIGHT/2+ self.level.player.moveboxY, 8, 6)
    love.graphics.print(tostring(self.level.player.mapX)..''..tostring(self.level.player.mapY), gFonts['medium'], 10, 10)
end
