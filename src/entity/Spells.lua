Spells = Class{}

function Spells:init(def, player)
    self.name = def.name
    self.id = def.id
    self.damage = def.damage
    self.x = def.x
    self.y = def.y
    self.range = def.range
    self.cost = def.cost
    self.energy = def.energy
    self.duration = def.duration
    self.debuff = def.debuff
    self.buff = def.buff
    self.aoe = def.aoe
    self.effectPower = def.effectPower
    self.level = def.level
    self.playerCanImprove = def.playerCanImprove
    self.scale = def.scale
    self.require = def.require
    self.player = player
    self.cooldown = def.cooldown
    self.targetType = def.target
    self.target = nil
    self.ready = true
    self.cooldownTimer = 0
    self.onUse = def.onUse
    self.mainStat = 1
    self.mainStatString = ''
    if self.player.class == 'warrior' then 
        self.mainStat = self.player.strength
        self.mainStatString = 'str'
    elseif self.player.class == 'ranger' then 
        self.mainStat = self.player.agility
        self.mainStatString = 'agi'
    elseif self.player.class == 'mage' then 
        self.mainStat = self.player.intelligence
        self.mainStatString = 'int'
    end
end

function Spells:update(dt)
    if self.ready == false then
        self.cooldownTimer = self.cooldownTimer + dt*self.player.cooldownReduction
        if self.cooldownTimer > self.cooldown then
            self.cooldownTimer = 0
            self.ready = true
        end
    end
end

function Spells:use(target, enemyOnScreen)
    if self.ready then
        if self:distToTarget(target) > self.range then
            --error sound
        else
            self.player:spentEnergy(self.cost)
            self.player:getEnergy(self.energy)
            self:assignTarget(target)
            self.onUse(self.player, target)
            for k, v in pairs(self.target) do
                for key, enemy in pairs(enemyOnScreen) do
                    if v.X == enemy.mapX and v.Y == enemy.mapY then
                        if self.debuff then
                            enemy:getStatus{
                                status = self.debuff,
                                duration = self.duration,
                                effectPower = self.effectPower + (self.level * self.effectPower + self.scale * self.mainStat) / self.duration
                            }
                        end
                        if self.damage > 0 then
                            enemy:takedamage(self.damage * self.level + self.scale * self.mainStat)
                        end
                    end
                end
            end
            if self.buff then
                self.player:getStatus{
                    status = self.buff,
                    duration = self.duration,
                    effectPower = self.effectPower + (self.level * self.effectPower + self.scale * self.mainStat) / self.duration
                }
            end
            self.ready = false
        end
    else 
        -- cooldown sound 
    end
end

function Spells:distToTarget(target)
    return math.floor(math.sqrt((self.player.mapX - target.mapX)^2 + 
    (self.player.mapY - target.mapY)^2))
end




function Spells:assignTarget(target)
    self.target = {}
    if self.aoe == 0 then
        local cell = {
            X = target.mapX,
            Y = target.mapY
            }
        table.insert(self.target, cell)
    else
        for i = 1, self.aoe do
            for j = 1, 8 do
                local cell = {
                    X = target.mapX + MDx[j]*i,
                    Y = target.mapY + MDy[j]*i
                    }
                    table.insert(self.target, cell)
            end
        end
    end
end
