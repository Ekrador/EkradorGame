Entity = Class{}

function Entity:init(def)
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)

    self.mapX = def.mapX
    self.mapY = def.mapY
    self.mapSize = def.mapSize

    self.width = def.width
    self.height = def.height

    self.x = (self.mapX-1)*0.5*self.width + (self.mapY-1)*-1*self.width*0.5

    self.y = (self.mapX-1)*0.5*0.5*self.height+ (self.mapY-1)*0.5*0.5*self.height - self.height+10
    self.moveboxX = self.x + 12
    self.moveboxY = self.y + self.height - 6
end
function Entity:invert_matrix(a, b, c, d)  
    det = (1 / (a * d - b * c))
    
    return {
      a= det * d,
      b= det * -b,
      c= det * -c,
      d= det * a
    }
end
  
function Entity:to_grid_coordinate(x,y) 
    local a = 1 * 0.5 * self.width
    local b = -1 * 0.5 * self.width
    local c =  0.5 * (16)
    local d =  0.5 * (16)
    
    inv = self:invert_matrix(a, b, c, d)
    
    
      self.mapX= math.floor(x* inv.a + (y + self.height-10) * inv.b + 1)
      self.mapY= math.floor(x * inv.c + (y + self.height-10)* inv.d + 1)
    
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
    self:to_grid_coordinate(self.x,self.y)
end

function Entity:render()
    self.stateMachine:render()
end