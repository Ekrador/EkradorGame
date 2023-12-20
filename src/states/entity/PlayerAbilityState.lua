PlayerAbilityState = Class{__includes = PlayerIdleState}
function PlayerAbilityState:init(entity, level)
    self.level = level
    self.entity = entity
    self.mouseX = mouseInScreenX + self.entity.x
    self.mouseY = mouseInScreenY + self.entity.y
    self.target = nil
    self.stateTimer = 0
    self.skillTimer = 0
end


function PlayerAbilityState:enter(params)
    self.entity.stop = false
    --change cursor
    self.id = params.id
    self.spell = self.entity.spells[self.id]
    self.target = nil
    --self.entity:changeAnimation(self.entity.spells[self.id].name .. self.entity.direction)
end

function PlayerAbilityState:update(dt)
    self.mouseX = mouseInScreenX + self.entity.x
    self.mouseY = mouseInScreenY + self.entity.y
    if love.mouse.wasPressed(2) or love.keyboard.isDown('lshift') or love.keyboard.wasPressed('escape') then
        self.entity:changeState('walk')
    end

    self:getTarget()
    if self.target then
        for i = 1, 4 do
            if love.keyboard.isDown(self.entity.spellKeys[i]) then
                if self.entity.spellPanel[i] > 0 and not self.entity.spells[self.id] == self.entity.spellPanel[i] then
                    self.entity:changeState('ability', {self.entity.spellPanel[i]})
                elseif self.id == self.entity.spellPanel[i] then
                    self:castSpell()
                end
            elseif love.mouse.wasPressed(1) then
                    self:castSpell()
            end
        end
    end
end

function PlayerAbilityState:getTarget()
    if self.spell.targetType == 'enemy' then
        for k, v in pairs(self.level.enemyOnScreen) do
            if ((self.mouseX > v.x) and (self.mouseX < v.x + v.width)) and ((self.mouseY > v.y) and (self.mouseY < v.y + v.height)) then
                self.target = v
            end
        end
    elseif self.spell.targetType == 'cell' then
        if (mouseTileY > 0 and mouseTileY < self.level.mapSize) and (mouseTileX > 0 and mouseTileX < self.level.mapSize) and
        not self.level.map.tiles[mouseTileY][mouseTileX]:collidable() then
            local mapX = mouseTileX
            local mapY = mouseTileY
            self.target = {
                mapX,
                mapY
            }
        end
    elseif self.spell.targetType == 'self' then
        self.target = self.entity
    end
end


function PlayerAbilityState:castSpell()
        self.entity.spells[self.id]:use(self.target, self.level.enemyOnScreen)
end

function PlayerAbilityState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
    
end
