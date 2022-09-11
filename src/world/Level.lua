Level = Class{}

function Level:init(def)
    self.mapSize = def.mapSize
    self.data = def.data
    local tiles = {}
    local counter = 1

    for i = 1, mapSize do
        tiles[i] = {}
        for j = 1 , mapSize do
            tiles[i][j] = Tile{
                x = j, y = i, id = self.data[counter] }
           counter = counter + 1
        end
    end

    self.map = TileMap(self.mapSize)
    self.map.tiles = tiles

    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        mapX = 4,
        mapY = 4,
        width = 16,
        height = 32,
        mapSize = 10
    }
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }
    self.player.stateMachine:change('idle')

end

function Level:update(dt)
end

function Level:render()
    self.map:render()
    self.player:render()
end
