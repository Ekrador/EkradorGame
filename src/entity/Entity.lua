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

    self.y = (self.mapX-1)*0.5*GROUND_HEIGHT+ (self.mapY-1)*0.5*GROUND_HEIGHT - self.height + GROUND_HEIGHT

    self.mmx = 0
    self.mmy = 0

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
    
    
      self.mapX= math.floor(x* inv.a + (y + self.height-GROUND_HEIGHT) * inv.b + 1)
      self.mapY= math.floor(x * inv.c + (y + self.height-GROUND_HEIGHT)* inv.d + 1)
    
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
    self.mmx = mx - VIRTUAL_WIDTH/2 
    self.mmy = my - VIRTUAL_HEIGHT/2 
end

function Entity:render()
    self.stateMachine:render()
end


function Entity:pathfind(def)
    startX = def.startX
    startY = def.startY
    endX = def.endX
    endY = def.endY
    xCur = startX
    yCur = startY
    tilemap = def.tilemap
    MDx = {0,1,1,1,0,-1,-1,-1}
    MDy = {-1,-1,0,1,1,1,0,-1}
    path = {}
    for i, tilemap.mapSize do
        path[i] = {}
        for j, tilemap.mapSize do
            path[i][j] = 0
        end
    end
    MShx = {}
    MShy = {}
    MshN = {}

    lastStep = 0
    curStep = 0
    for i = 1, 8 do
        local dx = MDx[i]
        local dy = MDy[i]
        local newX = xCur + dx
        local newY = yCur + dy
        if not tilemap[newY][newX]:collidable() and path[newY][newX] == 0 then
            lastStep = lastStep + 1
            MShx[lastStep] = newX
            MShy[lastStep] = newY
            MshN[lastStep] = i
            path[newY][newX] = i

            if newX == endX and newY == endY then
                goto
            end
        end
    end
    if curStep < lastStep then
        curStep = curStep + 1
        xCur = MShx[curStep]
        yCur = MShy[curStep]
            

end