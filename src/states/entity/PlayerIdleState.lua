PlayerIdleState = Class{__includes = EntityIdleState}
function PlayerIdleState:enter()
    self.entity.stop = false
end

function PlayerIdleState:update(dt)
    if love.mouse.wasPressed(2) then
            self.entity.getCommand = true
            self.entity:changeState('walk')
    end
end