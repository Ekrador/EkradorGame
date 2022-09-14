StartState = Class{__includes = BaseState}

function StartState:init()
    mapSize = 10
    self.level = Level(LEVEL_DEF['city'])
 
    self.camX = self.level.player.x
    self.camY = self.level.player.y
end

function StartState:update(dt)
    self.level:update(dt)
    self:updateCamera()
    to_grid_coordinate(self.level.player.x + self.level.player.mmx - self.level.player.width/2, self.level.player.y + self.level.player.mmy - self.level.player.height + 10)
end

function StartState:updateCamera()
    self.camX = self.level.player.x
    self.camY = self.level.player.y 

end

function StartState:render()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.level:render()   
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2 + self.level.player.moveboxX, VIRTUAL_HEIGHT/2+ self.level.player.moveboxY, 8, 6)
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2 + self.level.player.x, VIRTUAL_HEIGHT/2+ self.level.player.y, self.level.player.width, self.level.player.height)
    love.graphics.print(tostring(self.level.player.mapX)..'  '..tostring(self.level.player.mapY), gFonts['medium'], self.camX, self.camY)
    love.graphics.print(tostring(self.level.player.x)..'  '..tostring(self.level.player.y), gFonts['medium'], self.camX, self.camY + 10)
    love.graphics.print(tostring(mx)..'  '..tostring(my), gFonts['medium'], self.camX, self.camY + 20)
    love.graphics.print(tostring(self.level.player.mmx)..'  '..tostring(self.level.player.mmy), gFonts['medium'], self.camX, self.camY +30)
    love.graphics.print(tostring(mxx)..'  '..tostring(myy), gFonts['medium'], self.camX, self.camY +40)
end
