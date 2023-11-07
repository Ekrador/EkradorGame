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
end

function EntityIdleState:processAI(dt)
    self:checkAgro()
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + dt

        if self.waitTimer > self.waitDuration then
            self.entity:changeState('walk', {state='walk',entity = self.entity})
        end
    end
end