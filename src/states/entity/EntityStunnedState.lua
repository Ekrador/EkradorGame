EntityStunnedState = Class{__includes = EntityBaseState}
function EntityStunnedState:init(entity, level)
        self.level = level
        self.entity = entity
        self.entity:changeAnimation('idle-' .. self.entity.direction)
end

function EntityStunnedState:enter(params)
    self.stunDuration = params.duration
    self.timer = 0
end

function EntityStunnedState:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.stunDuration then
        self.entity:changeState('idle')
    end
end