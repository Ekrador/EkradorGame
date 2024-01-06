EntityRangedAttackState = Class{__includes = EntityBaseState}

function EntityRangedAttackState:init(entity, level)
    self.entity = entity
    self.level = level
    local direction = self.entity.direction
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
end

function EntityRangedAttackState:enter(params)
    self.entity.currentAnimation:refresh()
    self.entity = params.entity
    local dirx = self.level.player.mapX - self.entity.mapX
    local diry = self.level.player.mapY - self.entity.mapY
    if dirx > 0 then
        dirx = 1
    elseif dirx < 0 then
        dirx = -1
    else
        dirx = 0
    end
    if diry > 0 then
        diry = 1
    elseif diry < 0 then
        diry = -1
    else
        diry = 0
    end
    for i = 1, 8 do
        if MDx[i] == dirx and MDy[i] == diry then
            self.entity.direction = self.entity.directions[i]
        end
    end
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
end

function EntityRangedAttackState:update(dt)  
    self.entity.currentState = 'ranged_attack'
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