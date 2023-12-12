EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(entity, level)
    self.level = level
    self.entity = entity
    self.entity:changeAnimation('idle-' .. self.entity.direction)
    self.waitDuration = 0
    self.waitTimer = 0
end

function EntityIdleState:enter(params)
    self.entity = params.entity
    self.entity.walk = false
    self.entity.getCommand = false
end

function EntityIdleState:update(dt)
    self.entity.currentState = 'idle'
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + dt
        if self.waitTimer > self.waitDuration then
            self.waitDuration = 0
            self.waitTimer = 0
            self.entity.getCommand = true
            self.entity:changeState('walk', {entity = self.entity})
        end
        self:checkAgro()
    end
end