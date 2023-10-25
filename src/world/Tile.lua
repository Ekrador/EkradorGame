Tile = Class{}

function Tile:init(def)
    self.x = def.x
    self.y = def.y
    self.id = def.id
    self.width = TILE_IDS[self.id]:getWidth()
    self.height = TILE_IDS[self.id]:getHeight() - 1
    self.occupied = false
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
    math.floor((self.x-1)*0.5*GROUND_WIDTH + (self.y-1)*-1*GROUND_WIDTH*0.5),
    math.floor((self.x-1)*0.5*GROUND_HEIGHT+ (self.y-1)*0.5*GROUND_HEIGHT)- self.height + GROUND_HEIGHT)
end