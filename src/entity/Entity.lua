Entity = Class{}

function Entity:init(def)
    self.directions = {'up-right','right','down-right','down','down-left','left','up-left','up'}
    self.direction = 'down'
    self.name = def.name
    self.animations = self:createAnimations(def.animations)
    self.mapX = def.mapX
    self.mapY = def.mapY
    self.attackRange = def.attackRange
    self.agroRange = def.agroRange
    self.chasing = false
    self.width = def.width 
    self.height = def.height 
    self.speed = def.speed
    self.attackSpeed = def.attackSpeed and def.attackSpeed or 1
    self.speedUnbaffed = def.speed
    self.level = def.level
    self.maxHealth = def.maxHealth
    self.currentHealth = self.maxHealth
    self.status = {}
    self.stunned = false
    self.healthLogHandler = 0
    self.healthChanged = false
    self.dead = false
    self.chanceOnLoot = true
    self.damage = def.damage
    self.path = {}
    self.timer = 0

    self.x = (self.mapX-1)*0.5*GROUND_WIDTH + (self.mapY-1)*-1*GROUND_WIDTH*0.5

    self.y = (self.mapX-1)*0.5*GROUND_HEIGHT+ (self.mapY-1)*0.5*GROUND_HEIGHT - self.height + GROUND_HEIGHT

    self.getCommand = false
    self.stop = false
    self.healthBar = ProgressBar{
        x = self.x,
        y = self.y - 5,
        width = self.width - 4,
        height = 3,
        color = {r = 189/255, g = 32/255, b = 32/255},
        value = self.currentHealth,
        max = self.maxHealth,
    }
    self.renderHealthBars = false
end


function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
    
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
    self.healthBar.x = self.x
    self.healthBar.y = self.y - 5
    self.healthBar.value = self.currentHealth
    self:statusEffect(dt)
    self:healthChangedTimer(dt)
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:takedamage(dmg)
    self.healthLogHandler = -dmg
    self.currentHealth = math.max(0, self.currentHealth - dmg)
    self.healthChanged = true
    gSounds['hit']:stop()
    gSounds['hit']:play() 
end

function Entity:heal(amount)
    self.healthLogHandler = amount
    self.currentHealth = math.min(self.maxHealth, self.currentHealth + amount)
    self.healthChanged = true
end

function Entity:render()
    self.stateMachine:render()
    self:healthChangedDisplay()
    if self.renderHealthBars then
        self.healthBar:render()
    end
end

function Entity:distToPlayer()
    return math.floor(math.sqrt((self.level.player.mapX - self.mapX)^2 + 
    (self.level.player.mapY - self.mapY)^2))
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
            local dx = MDx[i]
            local dy = MDy[i]
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
        local dx = MDx[reversedPath]
        local dy = MDy[reversedPath]
        xCur = xCur + dx
        yCur = yCur + dy
        if xCur == startX and yCur == startY then
            local movePath = {}
            for i = Npath, 1, -1  do
                movePath[Npath + 1 - i] = {
                    x = PathX[i],
                    y = PathY[i],
                    direction = path[PathY[i]][PathX[i]]
                }
            end
            return movePath
        end

    end
end

function Entity:getStatus(def)
    local state = {
        timer = 0,
        status = def.status,
        duration = def.duration,
        effectPower = def.effectPower
    }
    table.insert(self.status, state)
end

function Entity:statusEffect(dt)
    for k, state in pairs(self.status) do
        if state.timer == 0 then
            if state.status == 'stun' then
                self.stunned = true
                self:changeState('stunned', {duration = state.duration})
            elseif state.status == 'slow' then
                self.speedUnbaffed = self.speed
                self.speed = self.speed / state.effectPower
            end
        elseif state.timer > state.duration then
            if state.status == 'stun' then
                self.stunned = false
            elseif state.status == 'slow' then
                self.speed = self.speedUnbaffed
            end
            self.status[k] = nil
        elseif state.timer % 2 == 0 then        
            if state.status == 'dot' then               
                self:takedamage(state.effectPower)
            elseif state.status == 'hot' then
                self:heal(state.effectPower)
            end  
        end
        state.timer = state.timer + dt
    end
end

function Entity:healthChangedTimer(dt)
    if self.healthChanged then
        self.timer = self.timer + dt    
        if self.timer > 0.5 then
            self.healthLogHandler = 0
            self.timer = 0
            self.healthChanged = false
        end
    end
end

function Entity:healthChangedDisplay()
    if (self.healthLogHandler ~= 0) then
        if self.healthLogHandler < 0 then
            love.graphics.setColor(1, 0, 0, 1)
        else
            love.graphics.setColor(0, 1, 0, 1)
        end
        love.graphics.print(tostring(math.abs((math.floor(self.healthLogHandler)))), gFonts['small'], math.floor(self.x + self.width / 2), math.floor(self.y - 15))
        love.graphics.setColor(1,1,1,1)
    end

    if self.currentHealth ~= self.maxHealth then
        self.renderHealthBars = true
    else
        self.renderHealthBars = false
    end
end

