PlayState = Class{__includes = BaseState}

function PlayState:init()
    gSounds['game_theme']:setVolume(0.3)
    gSounds['game_theme']:setLooping(true)
    gSounds['game_theme']:play()
    self.camX = 0
    self.camY = 0
    self.pause = false
    self.level = Level(LEVEL_DEF['city'])
    self.playerClass = 'warrior' 
    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        mapX = 38,
        mapY = 118,
        width = 32,
        height = 39,
        speed = ENTITY_DEFS['player'].speed,
        maxHealth = ENTITY_DEFS['player'].health,
        level = self.level,
        regenHp = ENTITY_DEFS[self.playerClass].regenHp,
        attackRange = ENTITY_DEFS['player'].attackRange,
        regenEnergy = ENTITY_DEFS[self.playerClass].regenEnergy,
        currentEnergy = ENTITY_DEFS[self.playerClass].currentEnergy,
        class = self.playerClass,
        regenRate = ENTITY_DEFS[self.playerClass].regenRate,
        strength = ENTITY_DEFS[self.playerClass].strength,
        agility = ENTITY_DEFS[self.playerClass].agility,
        intelligence = ENTITY_DEFS[self.playerClass].intelligence
    }
    self.player:initplayerSpells()

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
    self:populateMap()
end

function PlayState:enter(params)
    
end

function PlayState:update(dt)   
    if not self.pause then 
        self.player:update(dt)
        self.level:update(dt)
        self:updateCamera()
    end
    if love.keyboard.wasPressed('escape') then
        if self.pause then
            self.pause = false
            gSounds['game_theme']:play()
        else
            self.pause = true
            gSounds['game_theme']:pause()
        end
    end
    if self.player.currentHealth <= 0 then
        gStateStack:push(GameOverState(self.camX, self.camY))
    end
        
    mouseTileX, mouseTileY = to_grid_coordinate(self.player.x + mouseInScreenX - self.player.width/2, self.player.y + mouseInScreenY - self.player.height)
end

function PlayState:updateCamera()
    self.camX = self.player.x - VIRTUAL_WIDTH / 2
    self.camY = self.player.y - VIRTUAL_HEIGHT / 2
end

function PlayState:render()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.level:render(math.floor(self.camX), math.floor(self.camY))

    --self.player:render(math.floor(self.camX), math.floor(self.camY))
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), self.camX, self.camY)
    love.graphics.print(tostring(self.level.timer), self.camX, self.camY + 20)
    if self.pause then
        love.graphics.setFont(gFonts['gothic-large'])
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf('PAUSE', self.camX, self.camY + VIRTUAL_HEIGHT / 2 - 46, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(gFonts['gothic-large'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('PAUSE', self.camX, self.camY + VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center') 
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(gFonts['medium'])
    end
end

function PlayState:populateMap()
    self.level.vendor = Vendor {
        player = self.player,
        mapX = 40,
        mapY = 115,
        width = 32,
        height = 39,
    }
    self.level.vendor:updateAssortment()
    self.player.stateMachine:change('idle')
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 15, 12, 78, 30, 106, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 25, 44, 78, 120, 108, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 45, 90, 22, 120, 70, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 4, 12, 64, 26, 71, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 8, 33, 51, 53, 60, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 5, 58, 52, 65, 68, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 10, 70, 50, 83, 70, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 7, 70, 21, 72, 47, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 40, 44, 21, 65, 46, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 20, 33, 21, 39, 46, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 5, 23, 40, 28, 46, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 4, 24, 51, 29, 59, true)
    self.level:generateEntities({'skeleton', 'skeleton-archer'}, 5, 11, 51, 20, 59, true)
    self.level:generateEntities({'Lich'}, 1, 19, 23, 19, 23, true)
    table.insert(self.level.lootTable, Loot(13, 78, self.player))
    table.insert(self.level.lootTable, Loot(31, 63, self.player))
    table.insert(self.level.lootTable, Loot(120, 109, self.player))
    table.insert(self.level.lootTable, Loot(95, 36, self.player))
    table.insert(self.level.lootTable, Loot(78, 46, self.player))
    table.insert(self.level.lootTable, Loot(25, 42, self.player))
    table.insert(self.level.lootTable, Loot(24, 45, self.player))
    table.insert(self.level.lootTable, Loot(26, 45, self.player))
    table.insert(self.level.lootTable, Loot(28, 42, self.player))
end

