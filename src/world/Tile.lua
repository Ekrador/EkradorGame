Tile = Class{}

function Tile:init(def)
    self.x = def.x
    self.y = def.y
    self.id = def.id
    self.width = TILE_IDS[self.id]:getWidth()
    self.height = TILE_IDS[self.id]:getHeight() 

   
end


function Tile:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    love.graphics.draw(TILE_IDS[self.id], 
    math.floor(VIRTUAL_WIDTH / 2  + ((self.x - self.y) * (GROUND_WIDTH / 2))), 
    math.floor(VIRTUAL_HEIGHT / 2  + ((self.y + self.x) * (GROUND_HEIGHT / 2)) - (GROUND_HEIGHT * (mapSize / 2)) - self.height + 16))
end