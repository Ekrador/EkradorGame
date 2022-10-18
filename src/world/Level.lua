Level = Class{}

function Level:init(def)
    self.mapSize = def.mapSize
    self.data = def.data 
    self.safeZone = def.safeZone
    self.player = nil
    self.difficulty = def.difficulty
    self.enemiesAmount = def.enemiesAmount
    self.qwer = def.enemiesAmount
    self.objects = {}
    --self:generateObjects()
    self.entities = {}
    self.enemyOnScreen = {}
    self.timer = 0
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

function Level:generateEntities()
    if self.safeZone then

    else
 
        local types = {'skeleton'}
        local i = 0
        while self.enemiesAmount > 0 do
            for y = 1, self.mapSize do
                for x = 1, self.mapSize do
                    if not self.map.tiles[y][x]:collidable() and math.random(100) == 5 then
                        i = i + 1
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
                            height = 39
                        })

                        self.entities[i].stateMachine = StateMachine {
                            ['walk'] = function() return EntityWalkState(self.entities[i], self) end,
                            ['idle'] = function() return EntityIdleState(self.entities[i], self) end,
                            ['attack'] = function() return EntityAttackState(self.entities[i], self) end,
                            ['stunned'] = function() return EntityStunnedState(self.entities[i], self) end
                        }
                    
                        self.entities[i]:changeState('idle', self)
                        self.enemiesAmount = self.enemiesAmount - 1
                    end                
                end
            end
        end
    end
end


function Level:update(dt)
    self.map:update(dt)
    self:enemiesOnScreen(dt)
    if self.player then
        self.player.enemyOnScreen = self.enemyOnScreen
    end
    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]
        if entity.currentHealth <= 0 then
            entity.dead = true
        elseif not entity.dead then
            entity:update(dt)
            entity:processAI(dt)
        end
    end
end

function Level:render(x,y)
    self.map:render(x,y)
    for k, entity in pairs(self.entities) do
        if not entity.dead and entity.mapX == x and entity.mapY == y then
        entity:render()
        end
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
                and (v.y > screenY and v.y < screenY + VIRTUAL_HEIGHT) then
                    table.insert(self.enemyOnScreen, v)
                end
            end
            self.timer = 0
        end
    end
end