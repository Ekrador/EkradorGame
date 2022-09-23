EntityAttackState = Class{__includes = EntityBaseState}

function EntityAttackState:init(entity, level)
    self.entity = entity
    self.level = level
    local direction = self.entity.direction
    self.hitDirection = 1

    if direction == 'up' then
        hitDirection = 8
    elseif direction == 'up-right' then
        hitDirection = 1
    elseif direction == 'right' then
        hitDirection = 2
    elseif direction == 'down-right' then
        hitDirection = 3
    elseif direction == 'down' then
        hitDirection = 4
    elseif direction == 'down-left' then
        hitDirection = 5
    elseif direction == 'left' then
        hitDirection = 6
    elseif direction == 'up-left' then
        hitDirection = 7
    end
    
    
end

function EntityAttackState:enter(params)
    self.damage = {}
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    self.entity.getCommand = false
    local dirx = self.level.player.mapX - self.entity.mapX
    local diry = self.level.player.mapY - self.entity.mapY
    for i = 1, 8 do
        if self.entity.MDx[i] == dirx and self.entity.MDy[i] == diry then
            self.entity.direction = self.entity.directions[i]
        end
    end
    local tile = {
        x = self.entity.mapX,
        y = self.entity.mapY
    }
    self:damageToTile(tile, self.entity.attackRange)
    -- restart sword swing sound for rapid swinging
    -- gSounds['sword']:stop()
    -- gSounds['sword']:play()

    -- restart animation
    self.entity.currentAnimation:refresh()
end

function EntityAttackState:update(dt)  
    

    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0
        for k, tile in pairs(self.damage) do
            if tile.x == self.level.player.mapX and tile.y == self.level.player.mapY then
                self.level.player:takedamage(self.entity.damage)
            end
        end
        if self.entity:distToPlayer() <= self.entity.attackRange then
            self.entity:changeState('attack')
        else
            self.entity.stop = false
            self.entity:changeState('walk')
        end
    end
    


end



function EntityAttackState:damageToTile(tile, range)
    if range < 1 then
        return 
    else
        local dx = self.entity.MDx[hitDirection == 1 and 8 or hitDirection - 1]
        local dy = self.entity.MDy[hitDirection == 1 and 8 or hitDirection - 1]
        local newX = tile.x + dx
        local newY = tile.y + dy
        local nextTile = {x = newX, y = newY}
        self:damageToTile(nextTile, range - 1)
        table.insert(self.damage, nextTile)
        dx = self.entity.MDx[hitDirection]
        dy = self.entity.MDy[hitDirection]
        newX = tile.x + dx
        newY = tile.y + dy
        nextTile = {x = newX, y = newY}
        self:damageToTile(nextTile, range - 1)
        table.insert(self.damage, nextTile)
        dx = self.entity.MDx[hitDirection == 8 and 1 or hitDirection + 1]
        dy = self.entity.MDy[hitDirection == 8 and 1 or hitDirection + 1]
        newX = tile.x + dx
        newY = tile.y + dy
        nextTile = {x = newX, y = newY}
        self:damageToTile(nextTile, range - 1)
        table.insert(self.damage, nextTile)
    end

end