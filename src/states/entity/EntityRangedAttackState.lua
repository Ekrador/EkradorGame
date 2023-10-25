EntityRangedAttackState = Class{__includes = EntityBaseState}

function EntityRangedAttackState:init(entity, level)
    self.entity = entity
    self.level = level
    local direction = self.entity.direction
    self.hitDirection = 1

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
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
end

function EntityRangedAttackState:enter(params)
    self.entity = params.entity
<<<<<<< Updated upstream
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    self.entity.getCommand = false
=======
    self.entity.currentState = params.state
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    --self.entity.currentAnimation.interval = self.entity.currentAnimation.interval / self.entity.attackSpeed
>>>>>>> Stashed changes
    local dirx = self.level.player.mapX - self.entity.mapX
    local diry = self.level.player.mapY - self.entity.mapY
    for i = 1, 8 do
        if MDx[i] == dirx and MDy[i] == diry then
            self.entity.direction = self.entity.directions[i]
        end
    end
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
        self:checkAgro()
    end
end