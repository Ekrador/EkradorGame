EntityDeathState = Class{__includes = EntityBaseState}

function EntityDeathState:init(entity, level)
    self.level = level
    self.entity = entity
    self.entity:changeAnimation('death')

end

function EntityDeathState:enter(params)
    self.entity = params.entity
    self.entity.currentState = 'death'
    self.entity:changeAnimation('death')
    self.entity.currentAnimation:refresh()
end

function EntityDeathState:update(dt)
    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0
        self.entity.dead = true
    end
end