EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(entity, level)
    self.level = level
    self.entity = entity
    self.entity:changeAnimation('idle-' .. self.entity.direction)
end