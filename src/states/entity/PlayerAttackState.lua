PlayerAttackState = Class{__includes = EntityAttackState}

function PlayerAttackState:init(entity, level)
    EntityAttackState.init(self, entity, level)
    self.level = level
end

function PlayerAttackState:enter(params)
    self.damage = {}
    self.entity.currentAnimation.interval = self.entity.currentAnimation.baseInterval
    self.entity:changeAnimation('attack-' .. tostring(self.entity.direction))
    self.entity.currentAnimation.interval = self.entity.currentAnimation.interval / self.entity.attackSpeed
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
    -- restart animation
    self.entity.currentAnimation:refresh()
end

function PlayerAttackState:update(dt)  
    if self.entity.currentAnimation.timesPlayed > 0 then
        gSounds['sword_swing']:stop()
        gSounds['sword_swing']:play() 
        self.entity.currentAnimation.timesPlayed = 0
        for k, enemy in pairs(self.level.entities) do
            for j, tile in pairs(self.damage) do
                if tile.x == enemy.mapX and tile.y == enemy.mapY then
                    if not enemy.dead then
                        enemy:takedamage(self.entity.damage)
                        if self.entity.energyBar == 'Rage' then
                            self.entity:getEnergy(3)
                        end
                    end
                    goto next
                end
            end
            ::next::
        end
        self.entity:changeState('walk')
    end
end

function PlayerAttackState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
    
end
