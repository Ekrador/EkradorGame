EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(entity, level)
    self.entity = entity
    self.level = level
end

function EntityWalkState:enter(params)
  
end

function EntityWalkState:update(dt)
    self.entity.path = self.entity:pathfind{
        startX = self.entity.mapX,
        startY = self.entity.mapY,
        endX = self.level.player.mapX,
        endY = self.level.player.mapY
    }
end

function EntityWalkState:processAI(dt)  
    if not self.entity.getCommand  then
        self:checkAgro()
        self:doStep()      
    end
end

function EntityWalkState:doStep()
    local direction = 0
    if self.entity.chasing and self.entity.path  then
        direction = self.entity.path[1].direction
    else
        direction = math.random(#self.entity.directions)
    end

    local dx = self.entity.MDx[direction]
    local dy = self.entity.MDy[direction]
    local newX = self.entity.mapX + dx
    local newY = self.entity.mapY + dy
    if not self.level.map.tiles[newY][newX]:collidable() and not self.entity.stop then
        self.entity.getCommand = true
        self.entity.direction = self.entity.directions[direction]
        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        self.entity.mapX = newX
        self.entity.mapY = newY
        newX = (self.entity.mapX-1)*0.5*self.entity.width + (self.entity.mapY-1)*-1*self.entity.width*0.5
        newY = (self.entity.mapX-1)*0.5*GROUND_HEIGHT+ (self.entity.mapY-1)*0.5*GROUND_HEIGHT - self.entity.height + GROUND_HEIGHT
    
        Timer.tween(1/self.entity.speed, {
            [self.entity] = { x = newX, y = newY }
        })  
        :finish(function() Timer.after(0.6,function() 
            if not self.entity.chasing then
                self:chanceToIdle()
            end
            self.entity.getCommand = false
        end)
        end)
    else
        self.entity.getCommand = false
    end
end

function EntityWalkState:chanceToIdle()
    self.entity.getCommand = false
    if math.random(8) == 1 then
        self.entity:changeState('idle')
    end
end

function EntityWalkState:checkAgro()
    local distToPlayer = self.entity:distToPlayer()
    if distToPlayer <= self.entity.attackRange  then
        self.entity.stop = true
        self.entity:changeState('attack')
    end

    if distToPlayer <= self.entity.agroRange then
        self.entity.chasing = true
    else 
        self.entity.chasing = false
    end
end

