TileMap = Class{}

function TileMap:init(mapSize)
    self.mapSize = mapSize
    self.tiles = {}
end

function TileMap:update(dt)
    for y = 1, self.mapSize do
        for x = 1, self.mapSize do
            self.tiles[y][x]:update()
        end
    end
end

function TileMap:pointToTile(x, y)

    return self.tiles[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

function TileMap:render()
    for y = 1, self.mapSize do
        for x = 1, self.mapSize do
            self.tiles[y][x]:render()
        end
    end
end