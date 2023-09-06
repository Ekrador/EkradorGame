EntityRangedAttackState = Class{__includes = EntityBaseState}

function EntityRangedAttackState:init(entity, level)
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

function EntityRangedAttackState:enter(params)
    self.entity.currentAnimation.interval = self.entity.currentAnimation.baseInterval
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    self.entity.currentAnimation.interval = self.entity.currentAnimation.interval / self.entity.attackSpeed
    self.entity.getCommand = false
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
    -- restart animation
    self.entity.currentAnimation:refresh()
end

function EntityRangedAttackState:update(dt)  
    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0
        table.insert(self.level.projectiles, Projectile {
            type = ENTITY_DEFS[self.entity.name].projectileType,
            mapX = self.entity.mapX,
            mapY = self.entity.mapY,
            endPointX = self.level.player.x,
            endPointY = self.level.player.y,
            damage = ENTITY_DEFS[self.entity.name].damage,
            speed = ENTITY_DEFS[self.entity.name].projectileSpeed,
            x = self.entity.x + self.entity.width/2,
            y = self.entity.y + self.entity.height/2,
        })
        if self.entity:distToPlayer() <= self.entity.attackRange then
            self.entity:changeState('ranged_attack')
        else
            self.entity.stop = false
            self.entity:changeState('walk')
        end
    end
end