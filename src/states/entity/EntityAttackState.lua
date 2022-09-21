EntityAttackState = Class{__includes = EntityBaseState}

function EntityAttackState:init(entity, level, player)
    self.entity = entity
    self.level = level
    self.player = player
end