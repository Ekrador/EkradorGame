EntityBaseState = Class{}

function EntityBaseState:init(entity)
    self.entity = entity
end

function EntityBaseState:update(dt) end
function EntityBaseState:enter() end
function EntityBaseState:exit() end
function EntityBaseState:processAI(params, dt) end

function EntityBaseState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
    
end

function EntityBaseState:checkAgro()
    local distToPlayer = self.entity:distToPlayer()
    if distToPlayer <= self.entity.attackRange  then
        self.entity.stop = true
        if self.entity.attackRange > 1 then
            self.entity:changeState('ranged_attack')
        else
            self.entity:changeState('attack')
        end
    end

    if distToPlayer <= self.entity.agroRange then
        self.entity.chasing = true
    else 
        self.entity.chasing = false
    end
end
