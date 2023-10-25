Level = Class{}

function Level:init(def)
    self.mapSize = def.mapSize
    self.data = def.data 
    self.safeZone = def.safeZone
    self.player = nil
    self.vendor = nil
    self.difficulty = def.difficulty
    self.enemiesAmount = def.enemiesAmount
    self.objects = {}
    --self:generateObjects()
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
    if self.safeZone then

    else 
        while amount > 0 do
            for y = startY, endY do
                for x = startX, endX do
                    if not self.map.tiles[y][x]:collidable() and math.random(100) == 5 then
                        self.entitiesCounter = self.entitiesCounter + 1
                        local type = types[math.random(#types)]
                        table.insert(self.entities, Entity{
                            animations = ENTITY_DEFS[type].animations,
                            name = ENTITY_DEFS[type].name,
                            speed = ENTITY_DEFS[type].speed or 1,
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
                            chanceOnLoot = hasLoot,
                        })
                        self.entities[self.entitiesCounter]:initSpells()
                        self.entities[self.entitiesCounter].stateMachine = StateMachine {
                            ['walk'] = function() return EntityWalkState(self.entities[self.entitiesCounter], self) end,
                            ['idle'] = function() return EntityIdleState(self.entities[self.entitiesCounter], self) end,
                            ['attack'] = function() return EntityAttackState(self.entities[self.entitiesCounter], self) end,
                            ['ranged_attack'] = function() return EntityRangedAttackState(self.entities[self.entitiesCounter], self) end,
                            ['stunned'] = function() return EntityStunnedState(self.entities[self.entitiesCounter], self) end,
                            ['ability_state'] = function() return EntityAbilityState(self.entities[self.entitiesCounter], self) end
                        }
                    
                        self.entities[self.entitiesCounter]:changeState('idle', {entity = self.entities[self.entitiesCounter]})
                        amount = amount - 1
                        self.entities[self.entitiesCounter].ready = true
                        break
                    end                
                end
            end
        end
    end
end


function Level:update(dt)
    self.map:update(dt)
    self:enemiesOnScreen(dt)
    if self.vendor ~= nil then
        self.vendor:update(dt)
        if love.keyboard.wasPressed('f') and self.vendor.nearPlayer then
            self.vendor:onInteract()
        end
    end
    if self.player then
        self.player.enemyOnScreen = self.enemyOnScreen
    end

    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]
        if entity.currentHealth <= 0 then
            entity.dead = true
            if entity.chanceOnLoot then
                if math.random(5) == 1 then
                    table.insert(self.lootTable, Loot(entity.mapX, entity.mapY, self.player))
                end
                entity.chanceOnLoot = false
            end
        elseif not entity.dead and entity.ready then
            entity:update(dt)
            entity:processAI(dt)
        end
    end

    for k, v in pairs(self.projectiles) do
        v:update(dt)
        if v.mapX == self.player.mapX and v.mapY == self.player.mapY then
            self.player:takedamage(v.damage)
            table.remove(self.projectiles, k)
        elseif (v.mapY < 0 and v.mapY > self.mapSize) or (v.mapX < 0 and v.mapX > self.mapSize) or
        self.map.tiles[v.mapY][v.mapX]:collidable() then
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

    -- FOR DEBUG
    if love.keyboard.wasPressed('x') then
        table.insert(self.lootTable, Loot(self.player.mapX, self.player.mapY, self.player))
    end
    if love.keyboard.wasPressed('z') then
        if self.vendor == nil then
            self.vendor = Vendor {
                player = self.player,
                mapX = self.player.mapX,
                mapY = self.player.mapY,
                width = 32,
                height = 39,
            }
        else
            self.vendor:updateAssortment()
        end
    end
end

function Level:render(x,y)
    self.map:render(x,y)
    for k, entity in pairs(self.entities) do
        if not entity.dead and entity.mapX == x and entity.mapY == y and entity.ready then
        entity:render()
        end
    end

    for k, v in pairs(self.projectiles) do
        v:render()
       end

    if self.vendor ~= nil then
        self.vendor:render()
    end
    for k, v in pairs(self.lootTable) do
        v:render(x, y)
    end
end

function Level:enemiesOnScreen(dt)
    if self.player then
        local screenX = self.player.x - VIRTUAL_WIDTH / 2
        local screenY = self.player.y - VIRTUAL_HEIGHT / 2
        self.timer = self.timer + dt
        if self.timer > 2 then
            self.enemyOnScreen = {}
            for k, v in pairs(self.entities) do
                if (v.x > screenX and v.x < screenX + VIRTUAL_WIDTH) 
                and (v.y > screenY and v.y < screenY + VIRTUAL_HEIGHT)  and v.ready then
                    table.insert(self.enemyOnScreen, v)
                end
            end
            self.timer = 0
        end
    end
end