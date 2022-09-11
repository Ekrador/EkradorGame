PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)
if love.keyboard.isDown('right') and love.keyboard.isDown('up') then
    self.entity.direction = 'right-up'
    self.entity.x = self.entity.x + 14*dt
    self.entity.y = self.entity.y - 7*dt
elseif love.keyboard.isDown('right') and love.keyboard.isDown('down') then
    self.entity.direction = 'right-down'
    Timer.tween(0.5, {
    [self.entity] = {y = self.entity.y + 16,
    x = self.entity.x + 32}})
elseif love.keyboard.isDown('down') and love.keyboard.isDown('left') then
    self.entity.direction = 'left-down'
    self.entity.y = self.entity.y + 7*dt
    self.entity.x = self.entity.x - 14*dt
elseif love.keyboard.isDown('up') and love.keyboard.isDown('left') then
    self.entity.direction = 'left-up'
    self.entity.x = self.entity.x - 14*dt
    self.entity.y = self.entity.y - 7*dt
elseif love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - 15*dt
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + 15*dt
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity.y = self.entity.y - 15*dt
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity.y = self.entity.y + 15*dt
    
    else
        self.entity:changeState('idle')
end
end