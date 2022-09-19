EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(entity, level, player)
    self.entity = entity
    self.level = level
    self.player = player
    self.steps = 0
    self.movementTimer = 0
    self.bumped = false
end

function EntityWalkState:enter(params)
  
end

function EntityWalkState:update(dt)
    
end

function EntityWalkState:processAI(dt)  
    if not self.getCommand  then
        self.getCommand = true
        self:doStep(dt)
        
    end
end

function EntityWalkState:doStep(dt)
    direction = math.random(#self.entity.directions)
    local dx = self.entity.MDx[direction]
    local dy = self.entity.MDy[direction]
    local newX = self.entity.mapX + dx
    local newY = self.entity.mapY + dy
    if not self.level.map.tiles[newY][newX]:collidable() then
        self.getCommand = true
        self.entity.direction = self.entity.directions[direction]
        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        self.entity.mapX = newX
        self.entity.mapY = newY
        newX = (self.entity.mapX-1)*0.5*self.entity.width + (self.entity.mapY-1)*-1*self.entity.width*0.5
        newY = (self.entity.mapX-1)*0.5*GROUND_HEIGHT+ (self.entity.mapY-1)*0.5*GROUND_HEIGHT - self.entity.height + GROUND_HEIGHT
    
        Timer.tween(1/self.entity.speed, {
            [self.entity] = { x = newX, y = newY }
        })  
        :finish(function() Timer.after(0.6,function() self:checkAgro(dt) self:chanceToIdle()end )
        end)
    else
        self.getCommand = false
    end
end
function EntityWalkState:chanceToIdle()
    self.getCommand = false
    if math.random(8) == 1 then
        self.entity:changeState('idle')
    end
end

function EntityWalkState:checkAgro(dt)
    local distToPlayer = math.sqrt((self.entity.playerPos.x - self.entity.mapX)^2 + 
    (self.entity.playerPos.y - self.entity.mapY)^2)
    if distToPlayer < 6 then
        path = self.entity:pathfind{
            startX = self.entity.mapX,
            startY = self.entity.mapY,
            endX = self.entity.playerPos.x,
            endY = self.entity.playerPos.y
        }
        if path then             
            if not self.entity.getCommand then
                self.entity.getCommand = true
                self:move(path, 1)
                if distToPlayer < 2 then
                    self.entity:changeState('idle')
                else 
                    self.entity:changeState('idle')
                end
            end
        end
    else 
        self.entity:changeState('idle')
    end
end

function EntityWalkState:move(path, i)
    if self.entity.stop then
        self.entity.stop = false
        self.entity.getCommand = false
        return 
    end

    if i > #path then
        self.entity.getCommand = false
        return
    end
    local newX = (path[i].x-1)*0.5*self.entity.width + (path[i].y-1)*-1*self.entity.width*0.5
    local newY = (path[i].x-1)*0.5*GROUND_HEIGHT+ (path[i].y-1)*0.5*GROUND_HEIGHT - self.entity.height + GROUND_HEIGHT
    Timer.tween(1 / self.entity.speed,{
        [self.entity] = { x = newX, y = newY }
    })  
    :finish(function() self:move(path, i + 1) end)
end