Spells = Class{}

function Spells:init(def, entity, map)
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
    self.entity = entity
    self.cooldown = def.cooldown
    self.targetType = def.target
    self.target = nil
    self.isProjectile = def.isProjectile
    self.ready = true
    self.cooldownTimer = 0
    self.onUse = def.onUse
    self.mainStat = 1
    self.mainStatString = ''
    self.map = map
    self.speed = def.speed
    self.isPassive = def.isPassive
    self.sound = def.sound and def.sound or function() end
end

function Spells:update(dt)
    if instanceOf(self.entity, Player) then
        if self.entity.class == 'warrior' then 
            self.mainStat = self.entity.totalStrength
            self.mainStatString = 'str'
        elseif self.entity.class == 'ranger' then 
            self.mainStat = self.entity.totalAgility
            self.mainStatString = 'agi'
        elseif self.entity.class == 'mage' then 
            self.mainStat = self.entity.totalIntelligence
            self.mainStatString = 'int'
        end
    end
    if self.ready == false then
        self.cooldownTimer = self.cooldownTimer + dt
        if self.cooldownTimer > self.cooldown then
            self.cooldownTimer = 0
            self.ready = true
        end
    end
    if self.isPassive and self.level > 0 then
        self.onUse(self.entity)
    end
end

function Spells:use(target, enemyOnScreen)
    if self.ready then
        if self:distToTarget(target) > self.range then
            if instanceOf(self.entity, Player) then
                wrongAction()
            end
        else
            self:assignTarget(target)
            self.onUse(self.entity, target, self.map)
            if instanceOf(self.entity, Player) then
                if self.entity.currentEnergy >= self.cost then
                    self.entity:spentEnergy(self.cost)
                    self.entity:getEnergy(self.energy)
                    self.sound()
                else
                    wrongAction()
                    return
                end
            end
            for k, v in pairs(self.target) do
                for key, enemy in pairs(enemyOnScreen) do
                    if not enemy.dead then
                        if v.X == enemy.mapX and v.Y == enemy.mapY then
                            if self.debuff then
                                enemy:getStatus{
                                    status = self.debuff,
                                    duration = self.duration,
                                    effectPower = self.effectPower + (self.level * self.effectPower + self.scale * self.mainStat) / self.duration
                                }
                            end
                            if (self.damage > 0 and self.isProjectile == false) then                               
                                enemy:takedamage(self.damage * self.level + self.scale * self.mainStat)
                            end
                        end
                    end
                end
            end
            if self.buff then
                self.entity:getStatus{
                    status = self.buff,
                    duration = self.duration,
                    effectPower = self.effectPower + (self.level * self.effectPower + self.scale * self.mainStat) / self.duration
                }
            end
            self.ready = false
        end
    else 
        if instanceOf(self.entity, Player) then
            wrongAction()
        end
    end
end

function Spells:distToTarget(target)
    return math.floor(math.sqrt((self.entity.mapX - target.mapX)^2 + 
    (self.entity.mapY - target.mapY)^2))
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
