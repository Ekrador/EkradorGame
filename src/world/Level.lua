Level = Class{}

function Level:init(def)
    self.mapSize = def.mapSize
    self.data = def.data
    local tiles = {}
    local counter = 1
    self.difficulty = def.difficulty
    
    
    for i = 1, self.mapSize do
        tiles[i] = {}
        for j = 1 , self.mapSize do
            tiles[i][j] = Tile{
                x = j, y = i, id = self.data[counter], level = self}
           counter = counter + 1
        end
    end

    self.map = TileMap(self.mapSize)
    self.map.tiles = tiles

    self.objects = {}
    --self:generateObjects()
    self.entities = {}
    self:generateEnemies(def.EnemiesAmount)
    if def.hub then
        self:generateEntities()
    end
end

function Level:generateEnemies(amount)
    local amount = amount
    local types = {'skeleton'}
    local i = 0
    while amount > 0 do
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
                        level = self
                    })

                    self.entities[i].stateMachine = StateMachine {
                        ['walk'] = function() return EntityWalkState(self.entities[i], self) end,
                        ['idle'] = function() return EntityIdleState(self.entities[i], self) end
                    }
            
                    self.entities[i]:changeState('walk', self)
                    amount = amount -1
                end                
            end
        end
    end
end

function Level:generateEntities()

end

function Level:update(dt)
    self.map:update(dt)
end

function Level:render()
    self.map:render()
end

