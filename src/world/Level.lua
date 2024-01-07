Level = Class{}

function Level:init(def)
    self.mapSize = def.mapSize
    self.data = def.data 
    self.player = nil
    self.vendor = nil
    self.difficulty = def.difficulty
    self.enemiesAmount = def.enemiesAmount
    self.objects = {}
    self.entities = {}
    self.enemyOnScreen = {}
    self.timer = 0
    self.lootTable = {}
    self.projectiles = {}
    self.entitiesCounter = 0
end

function Level:generateTileMap()
    local tiles = {}
    local counter = 1
    for i = 1, self.mapSize do
        tiles[i] = {}
        for j = 1 , self.mapSize do
            tiles[i][j] = Tile{
                x = j, y = i, id = self.data[counter]}
           counter = counter + 1
        end
    end

    self.map = TileMap(self.mapSize)
    self.map.tiles = tiles
end

function Level:generateEntities(types, amount, startX, startY, endX, endY, hasLoot)
    while amount > 0 do
            for y = startY, endY do
                for x = startX, endX do
                    if not self.map.tiles[y][x]:collidable() and math.random(100) == 1 then
                        self.entitiesCounter = self.entitiesCounter + 1
                        local type = types[math.random(#types)]
                        table.insert(self.entities, Entity{
                            animations = ENTITY_DEFS[type].animations,
                            name = ENTITY_DEFS[type].name,
                            speed = ENTITY_DEFS[type].speed or 15,
                            mapX = x,
                            mapY = y,
                            width = 32,
                            height = 39,
                            maxHealth = ENTITY_DEFS[type].health,
                            level = self,
                            attackRange = ENTITY_DEFS[type].attackRange,
                            agroRange = ENTITY_DEFS[type].agroRange,
                            damage = ENTITY_DEFS[type].damage,
                            width = 32,
                            height = 39,
                            attackSpeed = ENTITY_DEFS[type].attackSpeed,
                            chanceOnLoot = hasLoot
                        })
                        self.entities[self.entitiesCounter]:initSpells()
                        self.entities[self.entitiesCounter].stateMachine = StateMachine {
                            ['walk'] = function() return EntityWalkState(self.entities[self.entitiesCounter], self) end,
                            ['idle'] = function() return EntityIdleState(self.entities[self.entitiesCounter], self) end,
                            ['attack'] = function() return EntityAttackState(self.entities[self.entitiesCounter], self) end,
                            ['ranged_attack'] = function() return EntityRangedAttackState(self.entities[self.entitiesCounter], self) end,
                            ['stunned'] = function() return EntityStunnedState(self.entities[self.entitiesCounter], self) end,
                            ['ability_state'] = function() return EntityAbilityState(self.entities[self.entitiesCounter], self) end,
                            ['death_state'] = function() return EntityDeathState(self.entities[self.entitiesCounter], self) end                           
                        }
                    
                        self.entities[self.entitiesCounter]:changeState('idle', {entity = self.entities[self.entitiesCounter]})
                        self.entities[self.entitiesCounter].ready = true
                        amount = amount - 1
                        if amount <= 0 then
                            goto stop
                        end
                    end                
                end
            end
        end
    ::stop::
end


function Level:update(dt)
    self.timer = self.timer + dt
    if self.timer >= 180 then
        self.vendor:updateAssortment()
        self.timer = 0
    end
    self:enemiesOnScreen(dt)
    if self.vendor ~= nil then
        self.vendor:update(dt)
        if love.keyboard.wasPressed('f') and self.vendor.nearPlayer then
            self.vendor:onInteract()
        end
    end

    for k,v in pairs(self.enemyOnScreen) do
        if v.currentHealth <= 0 and not v.dead then
            if v.currentState ~= 'death' then
                v:changeState('death_state', {entity = v})
            else
                v:update(dt)
            end
            if v.name == 'Lich' then
                gStateStack:push(VictoryState(self.player.x - VIRTUAL_WIDTH / 2, self.player.y - VIRTUAL_HEIGHT / 2))
            end
            if v.chanceOnLoot then
                self.player:getXp(math.random(30, 50))
                if math.random(5) == 1 then
                    table.insert(self.lootTable, Loot(v.mapX, v.mapY, self.player))
                end
                v.chanceOnLoot = false
            end
        elseif not v.dead and v.ready then
            v:update(dt)
        end
    end

    for k, v in pairs(self.projectiles) do
        v:update(dt)
        if v.mapX == self.player.mapX and v.mapY == self.player.mapY then
            self.player:takedamage(v.damage)
            v:hit()
            table.remove(self.projectiles, k)
        elseif (v.mapY < 0 and v.mapY > self.mapSize) or (v.mapX < 0 and v.mapX > self.mapSize) or
        self.map.tiles[v.mapY][v.mapX]:collidable() then
            v:hit()
            table.remove(self.projectiles, k)
        end
    end

    for k, v in pairs(self.lootTable) do
        v:update(dt)
        if love.keyboard.wasPressed('f') and v.nearPlayer then
            v:use()
            break
        end
    end
end

function Level:render(x,y)
    local endX = self.player.mapX + 16 < self.mapSize and self.player.mapX + 16 or self.mapSize
    local endY = self.player.mapY + 16 < self.mapSize and self.player.mapY + 16 or self.mapSize
    local startY = self.player.mapY - 16 > 0 and self.player.mapY - 16 or 1
    local startX = self.player.mapX - 16 > 0 and self.player.mapX - 16 or 1
    for y = startY, endY do
        for x = startX, endX do
            if not self.map.tiles[y][x]:collidable() then
                self.map:render(x,y)
            end
        end
    end

    for k, v in pairs(self.lootTable) do
        v:render()
    end

    local upperEnt = {}
    local lowerEnt = {}
    for k, entity in pairs(self.enemyOnScreen) do
        if not entity.dead and entity.ready and 
        (entity.mapX + entity.mapY) - (self.player.mapX + self.player.mapY) == 1 or
        (entity.mapX + entity.mapY) - (self.player.mapX + self.player.mapY) == 2 then
            table.insert(lowerEnt, entity)
        elseif not entity.dead and entity.ready then
            table.insert(upperEnt, entity)
        end
    end
    if self.vendor ~= nil then
        self.vendor:render()
    end
    
    for y = startY, endY do
        for x = startX, endX do
            if self.map.tiles[y][x]:collidable() then
                if ((y - self.player.mapY) < (self.map.tiles[y][x].height / GROUND_HEIGHT)  and
                (y - self.player.mapY) >= 0) and
                ((x - self.player.mapX) >= 0 and 
                (x  - self.player.mapX) < (self.map.tiles[y][x].height / GROUND_HEIGHT)) then
                        love.graphics.setColor(255, 255, 255, 0.5)        
                end
                self.map:render(x,y)
                love.graphics.setColor(255, 255, 255, 1)
            end
            for k, v in pairs(upperEnt) do
                if v.mapX == x and v.mapY == y then
                    v:render()
                end
            end
        end
    end
    self.player:render()
    for k, v in pairs(lowerEnt) do
        v:render()
    end

    for k, v in pairs(self.projectiles) do
        v:render()
    end
    self.player.GUI:render(x, y) 
end

function Level:enemiesOnScreen(dt)
    if self.player then
        local screenX = self.player.x - self.player.width/2 - VIRTUAL_WIDTH / 2
        local screenY = self.player.y - self.player.height - VIRTUAL_HEIGHT / 2
        self.enemyOnScreen = {}
        for k, v in pairs(self.entities) do
            if (v.x + v.width > screenX and v.x < screenX + VIRTUAL_WIDTH) 
            and (v.y + v.height > screenY and v.y - v.height < screenY + VIRTUAL_HEIGHT)  and v.ready and not v.dead then
                table.insert(self.enemyOnScreen, v)
                v.onscreen = true
            else
                v.onscreen = false
            end
        end
    end
end
