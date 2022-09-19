Level = Class{}

function Level:init(def)
    self.mapSize = def.mapSize
    self.data = def.data 
    self.safeZone = def.safeZone
    self.playerPos = {}
    
    self.difficulty = def.difficulty
    self.enemiesAmount = def.enemiesAmount
    self.qwer = def.enemiesAmount
    self.objects = {}
    --self:generateObjects()
    self.entities = {}
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
                            speed = ENTITY_DEFS[type].speed or 1,
                            mapX = x,
                            mapY = y,
                            width = 32,
                            height = 39,
                            health = ENTITY_DEFS[type].health,
                            level = self,
                            playerPos = self.playerPos
                        })

                        self.entities[i].stateMachine = StateMachine {
                            ['walk'] = function() return EntityWalkState(self.entities[i], self) end,
                            ['idle'] = function() return EntityIdleState(self.entities[i], self) end
                        }
                    
                        self.entities[i]:changeState('walk', self)
                        self.enemiesAmount = self.enemiesAmount - 1
                    end                
                end
            end
        end
    end
end


function Level:update(dt)
    self.map:update(dt)

    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]
        if entity.health <= 0 then
            entity.dead = true
        elseif not entity.dead then
            entity.playerPos = self.playerPos
            entity:processAI(dt)
            entity:update(dt)
        end
    end
end

function Level:render(x,y)
    self.map:render(x,y)
    for k, entity in pairs(self.entities) do
        if entity.mapX == x and entity.mapY == y then
        entity:render()
        end
    end
end

