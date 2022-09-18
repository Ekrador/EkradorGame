PlayState = Class{__includes = BaseState}

function PlayState:init()
       
end

function PlayState:enter(params)
    self.camX = 0
    self.camY = 0
    self.level = Level(LEVEL_DEF['city'])
    self.map = self.level.map
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
    self.player.stateMachine:change('idle')
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
    self.player:render() 
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2 + self.level.player.moveboxX, VIRTUAL_HEIGHT/2+ self.level.player.moveboxY, 8, 6)
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2 + self.level.player.x, VIRTUAL_HEIGHT/2+ self.level.player.y, self.level.player.width, self.level.player.height)
    love.graphics.print(tostring(self.level.player.mapX)..'  '..tostring(self.level.player.mapY), gFonts['medium'], self.camX, self.camY)
    love.graphics.print(tostring(self.level.player.x)..'  '..tostring(self.level.player.y), gFonts['medium'], self.camX, self.camY + 10)
    love.graphics.print(tostring(mx)..'  '..tostring(my), gFonts['medium'], self.camX, self.camY + 20)
    love.graphics.print(tostring(self.level.player.mmx)..'  '..tostring(self.level.player.mmy), gFonts['medium'], self.camX, self.camY +30)
    love.graphics.print(tostring(mxx)..'  '..tostring(myy), gFonts['medium'], self.camX, self.camY +40)
    
end
