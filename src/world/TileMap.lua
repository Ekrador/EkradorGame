TileMap = Class{}

function TileMap:init(mapSize)
    self.mapSize = mapSize
    self.tiles = {}
end

function TileMap:pointToTile(x, y)

    return self.tiles[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

function TileMap:render(x,y)
    self.tiles[y][x]:render()
end