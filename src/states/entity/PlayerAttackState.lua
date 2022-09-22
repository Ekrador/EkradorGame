PlayerAttackState = Class{__includes = EntityAttackState}

function PlayerAttackState:init(entity, level)
    EntityAttackState.init(self, entity)
    self.level = level
end

function PlayerAttackState:enter(params)
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    self.entity.getCommand = false
    local direction = params and params.direction or nil
    if direction then
        self.entity.direction = self.entity.directions[params.direction] 
    end
    local tile = {
        x = self.entity.mapX,
        y = self.entity.mapY
    }
    self:damageToTile(tile, self.entity.attackRange)
    self.damage = self:deleteDuplicates(self.damage)
    -- restart sword swing sound for rapid swinging
    -- gSounds['sword']:stop()
    -- gSounds['sword']:play()

    -- restart animation
    self.entity.currentAnimation:refresh()
end

function PlayerAttackState:update(dt)  
    for k, enemy in pairs(self.level.entities) do
        for j, tile in pairs(self.damage) do
            if tile.x == enemy.mapX and tile.y == enemy.mapY then
                enemy:damage(self.entity.damage)
            end
        end
    end
    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0
        self.entity:changeState('walk')
    end
end