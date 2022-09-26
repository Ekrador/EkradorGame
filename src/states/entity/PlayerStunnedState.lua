PlayerStunnedState = Class{__includes = EntityStunnedState}
function EntityStunnedState:init(entity, level)
    EntityWalkState.init(self, entity)
end