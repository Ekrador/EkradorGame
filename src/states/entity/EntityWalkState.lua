EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(entity, level)
    self.entity = entity
    self.level = level
<<<<<<< Updated upstream
    self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
=======
    self.path = {
        x = nil,
        y = nil
    }
    self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
    local direction = math.random(#self.entity.directions)
    self.dx = MDx[direction]
    self.dy = MDy[direction]
        self.newX = self.entity.mapX + self.dx
        self.newY = self.entity.mapY + self.dy
end

function EntityWalkState:enter(params)
    self.entity = params.entity
    self.entity.currentState = params.state
>>>>>>> Stashed changes
end

function EntityWalkState:update(dt)
    self.entity.path = self.entity:pathfind{
        startX = self.entity.mapX,
        startY = self.entity.mapY,
        endX = self.level.player.mapX,
        endY = self.level.player.mapY
    }
end

<<<<<<< Updated upstream
function EntityWalkState:enter(params)
    self.entity = params.entity
end

function EntityWalkState:processAI(dt)  
    if not self.entity.getCommand  then
        self:checkAgro()
        self:doStep()      
    end
end

function EntityWalkState:doStep()
=======
function EntityWalkState:processAI(dt) 
    self:update(dt) 
    if not self.entity.getCommand  then
        self:checkAgro()
    else
        self:doStep(dt)  
    end    
end

function EntityWalkState:doStep(dt)
>>>>>>> Stashed changes
    local direction = 1
    if self.entity.chasing and #self.entity.path > 0  then
        direction = self.entity.path[1].direction
    else
        direction = math.random(#self.entity.directions)
    end
    
    if self.entity.walk == false then
        self.dx = MDx[direction]
        self.dy = MDy[direction]
        self.newX = self.entity.mapX + self.dx
        self.newY = self.entity.mapY + self.dy
        self.entity.direction = self.entity.directions[direction]
        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
    end

    if not self.level.map.tiles[self.newY][self.newX]:collidable() and 
    self.level.map.tiles[self.newY][self.newX].occupied == false then
        self.entity.walk = true
        self.entity.getCommand = true
        self.path.x = (self.newX-1)*0.5*GROUND_WIDTH + (self.newY-1)*-1*GROUND_WIDTH*0.5
        self.path.y = (self.newX-1)*0.5*GROUND_HEIGHT+ (self.newY-1)*0.5*GROUND_HEIGHT - self.entity.height + GROUND_HEIGHT
        local dir = math.atan2(self.path.y - self.entity.y, self.path.x - self.entity.x)
        local ax = self.entity.speed * dt * math.cos(dir)
        local ay = self.entity.speed * dt * math.sin(dir)
        self.entity.x = self.entity.x + ax
        self.entity.y = self.entity.y + ay
        if (math.abs(self.entity.x - self.path.x) < 1 and math.abs(self.entity.y - self.path.y) < 1) then
            self.level.map.tiles[self.entity.mapY][self.entity.mapX].occupied = false
            self.entity.x = self.path.x
            self.entity.y = self.path.y
            self.entity.mapX = self.newX
            self.entity.mapY = self.newY
            self.entity.walk = false
            self.level.map.tiles[self.entity.mapY][self.entity.mapX].occupied = true
            self.entity.getCommand = false
            if not self.entity.chasing then
                self:chanceToIdle()
            end
        end
    else
        self.entity.walk = false
        self.entity.getCommand = false
    end
end

function EntityWalkState:chanceToIdle()
    self.entity.getCommand = false
    if math.random(8) == 1 then
        self.entity:changeState('idle', {entity = self.entity})
    end
end


