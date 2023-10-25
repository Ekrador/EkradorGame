EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(entity, level)
    self.level = level
    self.entity = entity
    self.entity:changeAnimation('idle-' .. self.entity.direction)
    self.waitDuration = 0
    self.waitTimer = 0
    self.level.map.tiles[self.entity.mapY][self.entity.mapX].occupied = true
end

function EntityIdleState:enter(params)
    self.entity = params.entity
    self.entity.currentState = params.state
end

function EntityIdleState:enter(params)
    self.entity = params.entity
end

function EntityIdleState:processAI(dt)
    self:checkAgro()
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + dt

        if self.waitTimer > self.waitDuration then
<<<<<<< Updated upstream
            self.entity:changeState('walk', {entity = self.entity})
=======
            self.entity:changeState('walk', {state='walk',entity = self.entity})
>>>>>>> Stashed changes
        end
    end
end