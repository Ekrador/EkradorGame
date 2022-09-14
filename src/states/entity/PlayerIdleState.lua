PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)

    if love.keyboard.isDown('w')  then
        self.entity.direction = 'right-up'
        self.entity.x = self.entity.x + 14*dt
        self.entity.y = self.entity.y - 7*dt
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right-down'
        self.entity.x = self.entity.x + 14*dt
        self.entity.y = self.entity.y + 7*dt
    elseif love.keyboard.isDown('s') then
        self.entity.direction = 'left-down'
        self.entity.y = self.entity.y + 7*dt
        self.entity.x = self.entity.x - 14*dt
    elseif love.keyboard.isDown('a') then
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
    if love.mouse.wasPressed(2) then

        local newX = (mxx-1)*0.5*self.entity.width + (myy-1)*-1*self.entity.width*0.5
        local newY = (mxx-1)*0.5*GROUND_HEIGHT+ (myy-1)*0.5*GROUND_HEIGHT - self.entity.height + GROUND_HEIGHT
        Timer.tween(2,{
            [self.entity] = { x = newX, y = newY }
        })
    end
end