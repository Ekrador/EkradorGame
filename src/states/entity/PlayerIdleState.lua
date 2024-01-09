PlayerIdleState = Class{__includes = EntityIdleState}
function PlayerIdleState:enter()
    self.entity.stop = false
end

function PlayerIdleState:update(dt)
    if love.mouse.wasPressed(2) or love.keyboard.isDown('lshift') then
        self.entity.getCommand = true
        self.entity:changeState('walk')
    end
end

function PlayerIdleState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
    
end