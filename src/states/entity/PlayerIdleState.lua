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
        
        if myy > 0 and myy < self.entity.map.mapSize 
        and mxx > 0 and mxx < self.entity.map.mapSize and
         not self.entity.map.tiles[myy][mxx]:collidable() then
            path = self.entity:pathfind{
                startX = self.entity.mapX,
                startY = self.entity.mapY,
                endX = mxx,
                endY = myy,
                tilemap = self.entity.map
            }
            if path then             
                if not self.entity.getCommand then
                    self.entity.getCommand = true
                    self:move(path, 1)
                else 
                    self.entity.stop = true
                end
            end
        end
    end
end

function PlayerIdleState:move(path, i)
    if self.entity.stop then
        self.entity.stop = false
        self.entity.getCommand = false
        return 
    end

    if i > #path then
        self.entity.getCommand = false
        return
    end
    newX = (path[i].x-1)*0.5*self.entity.width + (path[i].y-1)*-1*self.entity.width*0.5
    newY = (path[i].x-1)*0.5*GROUND_HEIGHT+ (path[i].y-1)*0.5*GROUND_HEIGHT - self.entity.height + GROUND_HEIGHT
    Timer.tween(1 / self.entity.speed,{
        [self.entity] = { x = newX, y = newY }
    })  
    :finish(function() self:move(path, i + 1) end)
end