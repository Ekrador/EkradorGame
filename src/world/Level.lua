Level = Class{}

function Level:init(def)
    self.mapSize = def.mapSize
    self.data = def.data
    local tiles = {}
    local counter = 1

    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        mapX = 9,
        mapY = 9,
        width = 16,
        height = 32,
        mapSize = 10
    }
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['idle'] = function() return PlayerIdleState(self.player, self) end
    }
    self.player.stateMachine:change('idle')

    for i = 1, mapSize do
        tiles[i] = {}
        for j = 1 , mapSize do
            tiles[i][j] = Tile{
                x = j, y = i, id = self.data[counter], level = self}
           counter = counter + 1
        end
    end

    self.map = TileMap(self.mapSize)
    self.map.tiles = tiles

    

end

function Level:update(dt)
    self.player:update(dt)
    self.map:update(dt)
end

function Level:render()
    self.map:render()
    self.player:render()
end
