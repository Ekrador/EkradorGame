Tile = Class{}

function Tile:init(def)
    self.x = def.x
    self.y = def.y
    self.id = def.id
    self.width = TILE_IDS[self.id]:getWidth()
    self.height = TILE_IDS[self.id]:getHeight() - 1
    self.level = def.level

   
end

function Tile:update(dt)
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
    if (self.y - self.level.player.mapY < self.height/GROUND_HEIGHT  and
        self.y - self.level.player.mapY >= 0) and
        (0 >= self.x - self.level.player.mapX and 
        self.x - self.level.player.mapX < 3) and
        self:collidable() then
        love.graphics.setColor(255, 255, 255, 0.5)
    else love.graphics.setColor(255, 255, 255, 1)
    end
    love.graphics.draw(TILE_IDS[self.id], 
    math.floor(VIRTUAL_WIDTH / 2 + (self.x-1)*0.5*GROUND_WIDTH + (self.y-1)*-1*GROUND_WIDTH*0.5),
    math.floor(VIRTUAL_HEIGHT / 2 + (self.x-1)*0.5*GROUND_HEIGHT+ (self.y-1)*0.5*GROUND_HEIGHT)- self.height + GROUND_HEIGHT)
    -- math.floor(VIRTUAL_WIDTH / 2 + self.x - 1+ ((self.x - self.y) * (GROUND_WIDTH / 2))), 
    -- math.floor(VIRTUAL_HEIGHT / 2 + self.y - 1 + ((self.y + self.x) * (GROUND_HEIGHT / 2)) - (GROUND_HEIGHT * (mapSize / 2)) - self.height + GROUND_HEIGHT))
    love.graphics.setColor(255, 255, 255, 1)
end