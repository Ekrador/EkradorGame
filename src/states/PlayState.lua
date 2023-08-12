PlayState = Class{__includes = BaseState}

function PlayState:init()
       
end

function PlayState:enter(params)
    self.camX = 0
    self.camY = 0
    self.level = Level(LEVEL_DEF['city'])
    self.playerClass = 'warrior' --params.playerClass
    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        mapX = 3,
        mapY = 5,
        width = 32,
        height = 39,
        speed = ENTITY_DEFS['player'].speed,
        maxHealth = ENTITY_DEFS['player'].health,
        level = self.level,
        attackRange = ENTITY_DEFS['player'].attackRange,
        regenEnergy = ENTITY_DEFS[self.playerClass].regenEnergy,
        currentEnergy = ENTITY_DEFS[self.playerClass].currentEnergy,
        class = self.playerClass,
        regenRate = ENTITY_DEFS[self.playerClass].regenRate,
        strength = ENTITY_DEFS[self.playerClass].strength,
        agility = ENTITY_DEFS[self.playerClass].agility,
        intelligence = ENTITY_DEFS[self.playerClass].intelligence
    }
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.level) end,
        ['idle'] = function() return PlayerIdleState(self.player, self.level) end,
        ['attack'] = function() return PlayerAttackState(self.player, self.level) end,
        ['stunned'] = function() return PlayerStunnedState(self.player, self.level) end,
        ['ability'] = function() return PlayerAbilityState(self.player, self.level) end
    }
    
    self.level:generateTileMap()
    self.map = self.level.map
    self.player.level = self.level
    self.level.player = self.player
    self.player.stateMachine:change('idle')
    self.level:generateEntities()
end

function PlayState:update(dt)    
    self.player:update(dt)
    self.level:update(dt)
    self:updateCamera()
    to_grid_coordinate(self.player.x + mouseInScreenX - self.player.width/2, self.player.y + mouseInScreenY - self.player.height)
end

function PlayState:updateCamera()
    self.camX = self.player.x - VIRTUAL_WIDTH / 2
    self.camY = self.player.y - VIRTUAL_HEIGHT / 2
end

function PlayState:render()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self:rendermap()
    self.player:render(math.floor(self.camX), math.floor(self.camY))
    love.graphics.print(tostring(self.player.x - VIRTUAL_WIDTH / 2)..'  '..tostring(self.player.y - VIRTUAL_HEIGHT / 2), gFonts['small'], self.camX, self.camY + 10)
    love.graphics.print(tostring(self.player.damage), gFonts['medium'], self.camX, self.camY + 10)
    love.graphics.print(tostring(mx)..'  '..tostring(my), gFonts['medium'], self.camX, self.camY + 40)
     love.graphics.print(tostring(mouseInScreenX)..'  '..tostring(mouseInScreenY), gFonts['medium'], self.camX, self.camY +50)
     
    -- love.graphics.print(tostring(mouseTileX)..'  '..tostring(mouseTileY), gFonts['medium'], self.camX, self.camY +40)
    -- love.graphics.print(tostring(self.camX)..'  '..tostring(self.camY), gFonts['medium'],self.camX, self.camY + 50)
    -- love.graphics.print(tostring(self.player.currentHealth), gFonts['medium'],self.camX, self.camY + 60)
    -- for k, v in pairs(ENTITY_SPELLS['player'][self.playerClass]) do
    --     love.graphics.print(tostring(v.name), gFonts['medium'],self.camX, self.camY + 70)
    -- end
    -- for k, v in pairs(self.player.stash) do
    --     love.graphics.print(tostring(v.type), gFonts['medium'], self.camX, self.camY + 70)
    -- end
    -- for k, v in pairs(self.level.entities) do
    --     love.graphics.print(tostring(v.mapX)..'  '..tostring(v.mapY), gFonts['medium'], self.camX, self.camY + 20)
    -- end
end

function PlayState:rendermap()
    local half = self.player.mapY + self.player.mapX
    local gridX = 0
    local gridY = 0
    local delay = half - self.level.mapSize
    local decreaseX = 1
    if half <= self.level.mapSize then
        gridX = half - 1
        gridY = half - 1   
    else 
        gridX = self.level.mapSize
        gridY = self.level.mapSize
        decreaseX = delay
    end

    for y = 1, gridY do
        for x = 1, gridX do
            self.level:render(x,y)
        end

        if decreaseX == 1 then
            gridX = gridX - 1
        else
            decreaseX = decreaseX - 1
        end
    end



    local nextX = (half < self.level.mapSize) and half or self.level.mapSize

    for y = (delay >= 1) and (delay + 1) or 1, self.level.mapSize do
        for x = nextX, self.level.mapSize do
            if ((y - self.player.mapY) < (self.level.map.tiles[y][x].height / GROUND_HEIGHT)  and
            (y - self.player.mapY) >= 0) and
            ((x - self.player.mapX) >= 0 and 
            (x  - self.player.mapX) < (self.level.map.tiles[y][x].height / GROUND_HEIGHT)) and
            self.level.map.tiles[y][x]:collidable() then
                love.graphics.setColor(255, 255, 255, 0.5)        
            end
            self.level:render(x,y)
            love.graphics.setColor(255, 255, 255, 1)
        end
        if nextX > 1 then
            nextX = nextX - 1
        end
    end
end



