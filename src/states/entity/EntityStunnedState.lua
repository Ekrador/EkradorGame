EntityStunnedState = Class{__includes = EntityBaseState}
function EntityStunnedState:init(entity, level)
        self.level = level
        self.entity = entity
        self.entity:changeAnimation('idle-' .. self.entity.direction)
end

function EntityStunnedState:enter(params)
    self.entity = params.entity
    self.stunDuration = params.duration
    self.timer = 0
end

function EntityStunnedState:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.stunDuration then
        self.entity:changeState('idle', {entity = self.entity})
    end
end

function EntityStunnedState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    math.floor(self.entity.x), math.floor(self.entity.y))
        
    love.graphics.draw(gTextures['stun'], self.entity.x , self.entity.y - 16)
end