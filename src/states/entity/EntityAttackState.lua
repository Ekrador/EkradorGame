EntityAttackState = Class{__includes = EntityBaseState}

function EntityAttackState:init(entity, level)
    self.entity = entity
    self.level = level
    self.direction = self.entity.direction
    self.hitDirection = 1
<<<<<<< Updated upstream

    if direction == 'up' then
        self.hitDirection = 8
    elseif direction == 'up-right' then
        self.hitDirection = 1
    elseif direction == 'right' then
        self.hitDirection = 2
    elseif direction == 'down-right' then
        self.hitDirection = 3
    elseif direction == 'down' then
        self.hitDirection = 4
    elseif direction == 'down-left' then
        self.hitDirection = 5
    elseif direction == 'left' then
        self.hitDirection = 6
    elseif direction == 'up-left' then
        self.hitDirection = 7
    end 
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
=======
    if self.direction == 'up' then
        self.hitDirection = 8
    elseif self.direction == 'up-right' then
        self.hitDirection = 1
    elseif self.direction == 'right' then
        self.hitDirection = 2
    elseif self.direction == 'down-right' then
        self.hitDirection = 3
    elseif self.direction == 'down' then
        self.hitDirection = 4
    elseif self.direction == 'down-left' then
        self.hitDirection = 5
    elseif self.direction == 'left' then
        self.hitDirection = 6
    elseif self.direction == 'up-left' then
        self.hitDirection = 7
    end 
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))

>>>>>>> Stashed changes
end

function EntityAttackState:enter(params)
    self.damage = {}
    self.entity = params.entity
<<<<<<< Updated upstream
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    self.entity.getCommand = false
=======
    self.entity.currentState = params.state
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    self.entity.currentAnimation.interval = self.entity.currentAnimation.interval / self.entity.attackSpeed
>>>>>>> Stashed changes
    local dirx = self.level.player.mapX - self.entity.mapX
    local diry = self.level.player.mapY - self.entity.mapY
    for i = 1, 8 do
        if MDx[i] == dirx and MDy[i] == diry then
            self.entity.direction = self.entity.directions[i]
        end
    end
    local tile = {
        x = self.entity.mapX,
        y = self.entity.mapY
    }
    self:damageToTile(tile, self.entity.attackRange)

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
        self:checkAgro()
       --self.entity:changeState('attack', {state = 'attack', entity = self.entity})
    end
end



function EntityAttackState:damageToTile(tile, range)
    if range < 1 then
        return 
    else
        local dx = MDx[self.hitDirection == 1 and 8 or self.hitDirection - 1]
        local dy = MDy[self.hitDirection == 1 and 8 or self.hitDirection - 1]
        local newX = tile.x + dx
        local newY = tile.y + dy
        local nextTile = {x = newX, y = newY}
        self:damageToTile(nextTile, range - 1)
        table.insert(self.damage, nextTile)
        dx = MDx[self.hitDirection]
        dy = MDy[self.hitDirection]
        newX = tile.x + dx
        newY = tile.y + dy
        nextTile = {x = newX, y = newY}
        self:damageToTile(nextTile, range - 1)
        table.insert(self.damage, nextTile)
        dx = MDx[self.hitDirection == 8 and 1 or self.hitDirection + 1]
        dy = MDy[self.hitDirection == 8 and 1 or self.hitDirection + 1]
        newX = tile.x + dx
        newY = tile.y + dy
        nextTile = {x = newX, y = newY}
        self:damageToTile(nextTile, range - 1)
        table.insert(self.damage, nextTile)
    end

end