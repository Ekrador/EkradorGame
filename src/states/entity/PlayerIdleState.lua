PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)
    if love.mouse.wasPressed(2) then
        if myy > 0 and myy < self.level.mapSize 
        and mxx > 0 and mxx < self.level.mapSize and
        not self.entity.map.tiles[myy][mxx]:collidable() then
            self.entity.getCommand = true
            self.entity:changeState('walk')
        end
    end
end