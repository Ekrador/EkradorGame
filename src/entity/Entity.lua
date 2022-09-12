Entity = Class{}

function Entity:init(def)
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)

    self.mapX = def.mapX
    self.mapY = def.mapY
    self.mapSize = def.mapSize

    self.width = def.width
    self.height = def.height

    self.x = (self.mapX - 1)  + ((self.mapX-self.mapY) * (GROUND_WIDTH / 2)) 

    self.y = (self.mapY - 1) + ((self.mapY+self.mapX) * (GROUND_HEIGHT / 2)) - (GROUND_HEIGHT * (self.mapSize / 2)) -self.height
    self.moveboxX = self.x + 12
    self.moveboxY = self.y + self.height - 6
end

function Entity:changeState(name)
    self.stateMachine:change(name)
    
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Entity:onInteract()

end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
    self.moveboxX = self.x + 12
    self.moveboxY = self.y + self.height - 6
    -- self.mapX = math.floor(self.x - ((self.mapX-self.mapY) * (GROUND_WIDTH / 2))) 
    -- self.mapY = math.floor(self.y - ((self.mapY+self.mapX) * (GROUND_HEIGHT / 2)) - (GROUND_HEIGHT * (self.mapSize / 2)-self.height))
end

function Entity:render()
    self.stateMachine:render()
end