Entity = Class{}

function Entity:init(def)
    self.directions = {'up-right','right','down-right','down','down-left','left','up-left','up'}
    self.direction = 'down'
    
    self.MDx = {0,1,1,1,0,-1,-1,-1}
    self.MDy = {-1,-1,0,1,1,1,0,-1}

    self.animations = self:createAnimations(def.animations)

    self.mapX = def.mapX
    self.mapY = def.mapY

    self.width = def.width
    self.height = def.height
    self.speed = def.speed
    self.level = def.level
    self.health = def.health
    self.dead = false
    self.playerPos = def.playerPos 

    self.x = (self.mapX-1)*0.5*self.width + (self.mapY-1)*-1*self.width*0.5

    self.y = (self.mapX-1)*0.5*GROUND_HEIGHT+ (self.mapY-1)*0.5*GROUND_HEIGHT - self.height + GROUND_HEIGHT

    self.mmx = 0
    self.mmy = 0
    self.getCommand = false
    self.stop = false
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
    self:to_grid_coordinate(self.x,self.y)
    self.mmx = mx - VIRTUAL_WIDTH/2 
    self.mmy = my - VIRTUAL_HEIGHT/2 
end

function Entity:render()
    self.stateMachine:render()
end


function Entity:pathfind(def)
    local startX = def.startX
    local startY = def.startY
    local endX = def.endX
    local endY = def.endY
    if startX == endX and startY == endY then
        return
    end
    
    local xCur = startX
    local yCur = startY
    local path = {}
    for i = 1, self.level.mapSize do
        path[i] = {}
        for j = 1, self.level.mapSize do
            path[i][j] = 0
        end
    end
    local MShx = {}
    local MShy = {}
    local MshN = {}

    local lastStep = 0
    local curStep = 0
    local maxSteps = 100
    local tracking = true
    while tracking do
        for i = 1, 8 do
            local dx = self.MDx[i]
            local dy = self.MDy[i]
            local newX = xCur + dx
            local newY = yCur + dy
            if not self.level.map.tiles[newY][newX]:collidable() and path[newY][newX] == 0 then
                lastStep = lastStep + 1
                MShx[lastStep] = newX
                MShy[lastStep] = newY
                MshN[lastStep] = i
                path[newY][newX] = i

                if newX == endX and newY == endY then
                    tracking = false
                    break
                end
                if lastStep > maxSteps then
                    return nil
                end

            end
        end

        if not tracking then
            break
        end

        if curStep < lastStep then
            curStep = curStep + 1
            xCur = MShx[curStep]
            yCur = MShy[curStep]
        end
    end

    local Npath = 0 
    local returnPath = {5,6,7,8,1,2,3,4}
    xCur = endX
    yCur = endY
    local PathX = {}
    local PathY = {}
    while true do
        Npath = Npath + 1
        PathX[Npath] = xCur
        PathY[Npath] = yCur
        local reverse = path[yCur][xCur]
        local reversedPath = returnPath[reverse]
        local dx = self.MDx[reversedPath]
        local dy = self.MDy[reversedPath]
        xCur = xCur + dx
        yCur = yCur + dy
        if xCur == startX and yCur == startY then
            local movePath = {}
            for i = Npath, 1, -1  do
                movePath[Npath + 1 - i] = {
                    x = PathX[i],
                    y = PathY[i],
                    direct = path[PathY[i]][PathX[i]]
                }
            end
            return movePath
        end

    end
end

