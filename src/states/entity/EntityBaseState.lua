EntityBaseState = Class{}

function EntityBaseState:init()
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
    if distToPlayer <= self.entity.agroRange then
        self.entity.chasing = true
    else 
        self.entity.chasing = false
    end
    
    if distToPlayer <= self.entity.attackRange and self.entity.chasing then
        if math.random(10) > 3 then
            for k, v in pairs(self.entity.spells) do
                if v.ready and math.random(10) > 3 then
                    self.entity:changeState('ability_state', {spell = v, entity = self.entity})
                end
            end
        elseif self.entity.attackRange > 1 then
            self.entity:changeState('ranged_attack', {entity = self.entity})
        else
            self.entity:changeState('attack', {entity = self.entity})
        end
    else
        if self.entity.currentState == 'idle' then
        else
            self.entity.getCommand = true
            self.entity:changeState('walk', {entity = self.entity})
        end
    end

end
